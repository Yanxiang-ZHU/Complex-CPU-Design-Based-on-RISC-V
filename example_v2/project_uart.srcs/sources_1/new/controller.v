module controller #(
    parameter                           P_UART_DATA_WIDTH   = 8,
    parameter                           P_SW_CNT            = 64,
    parameter                           P_LED_CNT           = 32,
    parameter                           P_SEG_CNT           = 40,
    parameter                           P_KEY_CNT           = 8
) (
    input sys_clk,
    input sys_rst,
    input i_clk,
    input i_rst,

    input  [P_UART_DATA_WIDTH - 1 : 0]	i_user_rx_data  ,
    input                               i_user_tx_ready ,
    input                               i_user_rx_valid ,
    input  [P_LED_CNT:1]                i_virtual_led   ,
    input  [P_SEG_CNT:1]                i_virtual_seg   ,
    input  [P_KEY_CNT:1]                i_virtual_key   ,
    input  [P_SW_CNT:1]                 i_virtual_sw    ,

    output [P_KEY_CNT:1]                o_virtual_key   ,
    output [P_SW_CNT:1]                 o_virtual_sw    ,
    output                              o_user_tx_valid ,    
    output [P_UART_DATA_WIDTH - 1 : 0]  o_user_tx_data
    
);
/***************function**************/

/***************parameter*************/

localparam  P_TOTAL_CNT          = P_SW_CNT + P_LED_CNT + P_SEG_CNT + P_KEY_CNT     ;
localparam 	P_OUTPUT_DATA_CNT    = 18                                               ; // read指令输出18 byte数据
localparam  P_OUTPUT_DATA_WIDTH  = 8                                                ;
localparam  P_LOGIC_BIT          = 7                                                ; // write指令0/1设置位为�?7�?
localparam  P_ADDRESS_WIDTH      = 7                                                ; // write指令地址为共7位，i_user_rx_data[6:0]
localparam  P_NONE_INSTRUCTION   = 0                                                ;
localparam  P_READ_INSTRUCTION   = 1                                                ;
localparam  P_WRITE_INSTRUCTION  = 2                                                ;

/***************port******************/             

/***************mechine***************/

/***************reg*******************/

reg [1:0]                               r_instr_active      ; 
reg [7:0]                               r_cnt               ;              
reg                                     r_user_tx_valid     ;
reg                                     r_instr_end         ;

reg [P_UART_DATA_WIDTH - 1 : 0]         ro_user_tx_data     ;
reg [P_SW_CNT:1]                        ro_virtual_sw       ;
reg [P_KEY_CNT:1]                       ro_virtual_key      ;
reg [P_TOTAL_CNT-1:0]                   r_every_component   ;

/***************wire******************/

wire                                    w_user_active       ;
wire                                    w_addr_not_zero     ;
wire                                    w_set_logic         ;
wire [6:0]                              w_address           ;  

/***************component*************/

/***************assign****************/			
assign w_set_logic          = i_user_rx_data[P_LOGIC_BIT]                                   ;
assign w_address            = i_user_rx_data[P_ADDRESS_WIDTH-1:0]                           ;
assign w_addr_not_zero      = |w_address                                                    ;   // �?0为非法指�?,1000_0000为读指令，其他指令为写指�?

assign w_user_active        = i_user_tx_ready & r_user_tx_valid                             ;
assign o_user_tx_data       = ro_user_tx_data                                               ;
assign o_user_tx_valid      = r_user_tx_valid                                               ;
assign o_virtual_sw         = ro_virtual_sw                                                 ;
assign o_virtual_key        = ro_virtual_key                                                ;

/***************always****************/
always @(posedge sys_clk or posedge sys_rst)
begin
    if (sys_rst)
        r_instr_active <= P_NONE_INSTRUCTION;
    else if (~w_addr_not_zero && w_set_logic && i_user_rx_valid || r_instr_active == P_READ_INSTRUCTION) // 1型指令为读指�?,格式�?1000_0000
        if (r_instr_end)
            r_instr_active <= P_NONE_INSTRUCTION;
        else
            r_instr_active <= P_READ_INSTRUCTION;
    else if (w_addr_not_zero && w_address <= 7'b100_1000 && i_user_rx_valid || r_instr_active == P_WRITE_INSTRUCTION)   // 2型指令为写指令，�?要满足地�?线不�?0且地�?范围合法
        if (r_instr_active == P_NONE_INSTRUCTION)
            r_instr_active <= P_WRITE_INSTRUCTION;
        else
            r_instr_active <= r_instr_active + 'd1; // 写指令需要重新更新虚拟开关的状�?�（虚拟�?关会延迟�?个周期更新），因此需要两个周期才能完成，因此使用2�?3�?0来进行两次计�?
    else
        r_instr_active <= P_NONE_INSTRUCTION;
end

always @(posedge sys_clk or posedge sys_rst)
begin
    if (sys_rst) begin
        ro_virtual_sw <= i_virtual_sw;
        ro_virtual_key <= i_virtual_key;
    end
    else if (~w_addr_not_zero && w_set_logic && i_user_rx_valid || r_instr_active == P_READ_INSTRUCTION) begin
        ro_virtual_sw <= i_virtual_sw;
        ro_virtual_key <= i_virtual_key;
    end
    else if (w_addr_not_zero && w_address <= 7'b100_1000 && i_user_rx_valid || r_instr_active == P_WRITE_INSTRUCTION) begin
        if (w_address > 7'b100_0000) // 指令编码�?000_0001~100_0000为sw�?�?64个，100_0001~100_1000为key�?�?8个，其他地址非法
            ro_virtual_key[w_address[3:0]] <= w_set_logic; // key修改只需要低4�?
        else 
            ro_virtual_sw[w_address] <= w_set_logic;
    end
    else begin
        ro_virtual_sw <= i_virtual_sw;
        ro_virtual_key <= i_virtual_key;
    end
end

always @(posedge i_clk or posedge i_rst)
begin
    if (i_rst)
        r_user_tx_valid <= 'd0;
    else if (w_user_active)
        r_user_tx_valid <= 'd0;
    else if (r_instr_active == P_NONE_INSTRUCTION)
        r_user_tx_valid <= 'd0;
    else if (r_instr_active == P_READ_INSTRUCTION && i_user_tx_ready) // 读指令需要满足：接受读命令r_instr_active==1且串口已经准备好
        r_user_tx_valid <= 'd1;
    else
        r_user_tx_valid <= r_user_tx_valid;
end

always @(posedge i_clk or posedge i_rst)
begin
    if (i_rst)
        r_instr_end <= 'd0;
    else if (r_cnt == P_OUTPUT_DATA_CNT)
        r_instr_end <= 'd1;
    else
        r_instr_end <= 'd0;
end

always @(posedge i_clk or posedge i_rst)
begin
    if (i_rst)
        r_cnt <= 'd0;
    else if (r_cnt == P_OUTPUT_DATA_CNT)
        r_cnt <= 'd0;
    else if (w_user_active) 
        r_cnt <= r_cnt + 'd1;
    else
        r_cnt <= r_cnt;
end

// 引入读取随机性，奇数读取延迟�?个周期，偶数不延�?
reg read_odd, read_check;

always @(posedge r_instr_active or posedge sys_rst) begin
    if (sys_rst) read_odd <= 1;
    else read_odd <= read_odd + 1;
end

// read_check用于每一次读的检查，1为待�?查，0为已�?�?
always @(posedge sys_clk) begin
    if (sys_rst) read_check <= 0;
    else if (r_instr_end) read_check <= 1;
    else if (r_instr_active == P_READ_INSTRUCTION) read_check <= 0;
    else read_check <= read_check;
end

always @(posedge sys_clk or posedge sys_rst)
begin
    if (sys_rst)
        r_every_component <= {i_virtual_led, i_virtual_sw, i_virtual_key, i_virtual_seg};
    else if (r_cnt == P_OUTPUT_DATA_CNT - 1) // 数据恢复
        r_every_component <= {i_virtual_led, i_virtual_sw, i_virtual_key, i_virtual_seg};
    else if (r_instr_active != P_READ_INSTRUCTION)
        r_every_component <= {i_virtual_led, i_virtual_sw, i_virtual_key, i_virtual_seg};
    else begin
        // 此时r_instr_active == P_READ_INSTRUCTION，为read状�??
        if (read_check && read_odd) r_every_component <= {i_virtual_led, i_virtual_sw, i_virtual_key, i_virtual_seg};
        else r_every_component <= r_every_component;
//        r_every_component <= r_every_component;
    end
end

always @(posedge i_clk or posedge i_rst)
begin
    if (i_rst)
        ro_user_tx_data <= r_every_component[P_OUTPUT_DATA_WIDTH-1:0];
    else if (r_cnt == P_OUTPUT_DATA_CNT - 1) // �?后一次发送需要的数据维持
        ro_user_tx_data <= ro_user_tx_data;
    else if (r_cnt == P_OUTPUT_DATA_CNT) // 发�?�完成，数据恢复
        ro_user_tx_data <= r_every_component[P_OUTPUT_DATA_WIDTH-1:0];
    else if (r_instr_active == P_NONE_INSTRUCTION && i_user_tx_ready) // 无指令空闲状态的数据刷新
        ro_user_tx_data <= r_every_component[P_OUTPUT_DATA_WIDTH-1:0];
    else if (w_user_active) // 每一次数据发�?
        ro_user_tx_data <= r_every_component[r_cnt*P_OUTPUT_DATA_WIDTH+P_OUTPUT_DATA_WIDTH+:P_OUTPUT_DATA_WIDTH];
    else
        ro_user_tx_data <= ro_user_tx_data;
end

endmodule