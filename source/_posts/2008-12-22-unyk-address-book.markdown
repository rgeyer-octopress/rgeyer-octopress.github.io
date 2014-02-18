---
layout: post
title: UNYK Address Book
comments: true
categories:
- Cloud computing
- Rants
- Reviews
tags:
- address book
- contact management
- goosync
- htc
- linkedin
- security
- unky
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://bit.ly/ant3Nt
  _sexybookmarks_permaHash: c20f854f95518e65c6880e6ee855aa77
---
I just received an email today from one of my contacts on <a href="https://www.linkedin.com/">LinkedIn</a>.  It was an invitation to join this new <a href="http://www.unyk.com/">UNYK</a> Address Book application which is apparently in beta.

I think I've made it clear that I'm a <a href=http://blog.ryangeyer.com/blog/2008/09/09/livin-on-the-web/>big fan</a> of anything which centralizes my information and allows me to access it through a web browser from anywhere, so I checked it out.

Overall, it looks quite promising.  It will harvest your existing contacts from several different locations (Yahoo!, Google, LinkedIn, Microsoft Outlook, MSN, etc.) and consolidate them.  When you sign up you provide your personal and professional contact information, and this in turn keeps your contact record up to date for anyone who has you in their address book.  Their premise is that everyone will eventually use them to manage their contact information, and therefore your address book will always be "automatically" up to date, because all of your contacts will have updated their information with UNYK.

My first, and perhaps biggest problem with the service is that they don't provide an https:// option.  So as I'm entering all of this personal and professional data, as well as supplying my login credentials for these other services it's all going across the wire in plain text!

My second problem is that I'm already using <a href="https://www.goosync.com/">GooSync</a> to store my contacts, and then synchronize them with my HTC phone, which is my life line as far as contact information is concerned.

There is also some considerable controversy regarding the fact that it will effectively "spam" the contacts that you do import inviting them to join UNYK as well.  This is no doubt how the email was sent to me.  I'm less concerned about this than the previous two points however.

So in order for me to fully embrace this new UNYK solution, it'll have to get a "secure" presence, and either integrate (which they seem to already do quite well with several other services) with GooSync, or provide the same functionality (syncing with my HTC).

Seems like a cool idea, but it's not quite mature enough for me to dive in head first.  I'll keep an eye out though!

EDIT:
Since I was more than a little bit surprised that there was no secure access to login and supply my credential for other services, I did a little further digging.  UNYK insists in their <a href="http://www.unyk.com/en/Confidentiality">privacy policy</a> that they encrypt any "sensitive data" that goes across the wire.  Here it is directly from their site.

<blockquote>How Secure Are Your Web Servers?  	[ ^ ]
The security of your personal information is important to us. When you enter sensitive information (such as credit card number) on our registration or order forms, we encrypt that information using secure socket layer technology (SSL).
To learn more about SSL, follow this link http://www.verisign.com/products-services/security-services/ssl/index.html.

We follow generally accepted industry standards to protect the personal information submitted to us, both during transmission and once we receive it. No method of transmission over the Internet, or method of electronic storage, is 100% secure, however. Therefore, while we strive to use commercially acceptable means to protect your personal information, we cannot guarantee its absolute security.

If you have any questions about security on our Web site, you can contact us.</blockquote>

So, since it looked like they used a lot of Web 2.0 technologies I thought possibly they were doing some javascript magic to encrypt the stuff going across the wire, I did a little test with <a href="http://www.wireshark.org/">Wireshark</a> to see what got sent.  I bit the bullet and imported my gmail contacts, and this was the result, with the password obscured by me, of course.

<pre lang="bash">
POST /Scripts/dotNET/ContactFinderProxy/Services.asmx/ImportWebContacts HTTP/1.1
Host: www.unyk.com
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.17) Gecko/20081021 Firefox/2.0.0.17
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Accept-Language: en-us,en;q=0.5
Accept-Encoding: gzip,deflate
Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
Keep-Alive: 300
Connection: keep-alive
X-Requested-With: XMLHttpRequest
Content-Type: application/x-www-form-urlencoded; charset=UTF-8
Referer: http://www.unyk.com/Diffusion/main.asp?nub=5EDC7952-7D0D-445F-B49A-0E068F4CA09E
Content-Length: 76
Cookie: BIGipServerwebUnyk=185207306.12310.0000; s_cc=true; s_campaign=en-US-0064; s_cp_persist=en-US-0064; s_sq=%5B%5BB%5D%5D; s_vi=[CS]v1|49503BB000004A0E-A02085E000051AD[CE]; InfosCompleted=3; nub=5EDC7952%2D7D0D%2D445F%2DB49A%2D0E068F4CA09E; __qca=1224815862-86415704-76514833; __qcb=1181521546; UNYK=LoginPassword=&LoginUsername=&RememberOption=0
Pragma: no-cache
Cache-Control: no-cache
provider=Gmail&username=qwikrex%40gmail.com&password=*********&useOctazen=true
</pre>

Clearly not secure.  I do have to admit however that I seem to have been wrong about the mobile sync, they do provide this, though I'll have no idea how well it works until they fix the security problem.
