resource "aws_lb_target_group_attachment" "ec2_attach_web" {
  target_group_arn = aws_lb_target_group.apl_tg.arn
  target_id        = aws_instance.web.id
  port             = 80
  
}
resource "aws_lb_target_group_attachment" "ec2_attach_web1" {
  target_group_arn = aws_lb_target_group.apl_tg.arn
  target_id        = aws_instance.web1.id
  port             = 80
  
}