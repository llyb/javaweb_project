package servlet;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CheckServ
 */
@WebServlet("/CheckServ")
public class CheckServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static int width=60;
     private static int height=20;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckServ() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("=======");
		HttpSession session=request.getSession();
		response.setContentType("image/jpeg");
		ServletOutputStream servletOutputStream=response.getOutputStream();
		//�����������Ҫ�����ͼƬ
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		//�����ڴ�ͼƬ�������ͼ��������
		BufferedImage image=new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics graphics=image.getGraphics();
		//�����������֤��
		char[] rands=generCode();
		//����ͼ��
		drawRands(graphics, rands);
		//����ͼ��Ļ��ƹ��̣����ͼ��
		graphics.dispose();
		//��ͼ��������ͻ���
		ByteArrayOutputStream byteArrayOutputStream=new ByteArrayOutputStream();
		ImageIO.write(image, "JPEG", byteArrayOutputStream);
		byte[] buf=byteArrayOutputStream.toByteArray();
		response.setContentLength(buf.length);
		servletOutputStream.write(buf);
		byteArrayOutputStream.close();
		servletOutputStream.close();
		
		//����ǰ����֤��д�뵽session��
		session.setAttribute("checkcode", new String(rands));
	}
	private char[] generCode(){
    	//������֤����ַ���
    	String chars="0123456789abcdefghijklmnopqrstuvwxyz";
    	char[] rands=new char[4];
    	for(int i=0;i<4;i++){
    		int rand=(int)(Math.random()*36);
    		rands[i]=chars.charAt(rand);
    	}
    	return rands;
    }
	private void drawRands(Graphics g,char[] rands){
		g.setColor(Color.WHITE);
		g.setFont(new Font(null, Font.ITALIC|Font.BOLD, 18));
		//�ڲ�ͬ�߶��������֤���ÿ���ַ�
		g.drawString(""+rands[0], 1, 17);
		g.drawString(""+rands[1], 16, 15);
		g.drawString(""+rands[2], 31, 18);
		g.drawString(""+rands[3], 46, 16);
		System.out.println(rands);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
