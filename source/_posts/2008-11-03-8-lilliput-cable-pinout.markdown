---
layout: post
title: 8" Lilliput cable pinout
categories:
- Worklogs
tags:
- cable
- lilliput
- linkedin
- touch screen
- vga
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://bit.ly/biclyG
  _sexybookmarks_permaHash: 5b7b70659acd7e3e264fade611cd1d54
---
So we just recently got a new sectional.  In order to make space for it, we put our old recliner sofa in the back of my truck, and hauled it away.  Of course, this meant I had to remove my car pc from the back of my explorer.  Unfortunately, I didn't tidy up the loose cables that were left behind before we put the couch in.

The result?  I bent a bunch of the pins on my VGA connector on the cable to my 8" Lilliput touch screen.  I tried bending them back, but they simply broke.  So the only solution is to put a new connector on.

Now the Lilliput proprietary cable carries the VGA signal and the USB signal for the touchscreen.  In total there are 9 wires.  Of course, I had to figure out the pinout in order to connect everything back up.

Using a multimeter and some trial and error I figured it out for my cable.  It might fit be the same for others, it might not but this info might be useful for somebody.

<table border="1">
  <tr>
    <td>Lilliput Proprietary Cable</td>
    <td>USB</td>
    <td>VGA</td>
  </tr>
  <tr>
    <td>green</td>
    <td>green</td>
    <td> - </td>
  </tr>
  <tr>
    <td>orange</td>
    <td>black</td>
    <td> - </td>
  </tr>
  <tr>
    <td>yellow</td>
    <td>white</td>
    <td> - </td>
  </tr>
  <tr>
    <td>red</td>
    <td>red</td>
    <td> - </td>
  </tr>
  <tr>
    <td>grey</td>
    <td> - </td>
    <td>pin1</td>
  </tr>
  <tr>
    <td>brown/beige</td>
    <td> - </td>
    <td> pin2 </td>
  </tr>
  <tr>
    <td>black</td>
    <td> - </td>
    <td>pin3</td>
  </tr>
  <tr>
    <td>blue</td>
    <td> - </td>
    <td> pin13 </td>
  </tr>
  <tr>
    <td>purple</td>
    <td> - </td>
    <td> pin14 </td>
  </tr>
</table>
