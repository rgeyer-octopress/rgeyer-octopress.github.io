---
layout: post
title: Microsoft's Tlbimp creates leaky BSTR signatures
categories:
- C# coding
tags:
- BSTR
- in/out
- linkedin
- memory leak
- tlbimp
status: publish
type: post
published: true
meta:
  _sexybookmarks_shortUrl: http://bit.ly/cchcxv
  _sexybookmarks_permaHash: 4f51339ae6fbad1ee6d7194d8766bc7f
---
This one confounded me when I first discovered it, and I've recently been reminded about it.  For the sake of remembering the details, and hopefully helping someone else out I'm going to document it here.

The problem is this.  When you have a COM library that you need to use from a C# app, you import it as a reference.  In the background the Microsoft.NET wizards do their magic by running the <a href="http://msdn2.microsoft.com/en-us/library/tt0cf3sx(VS.80).aspx">Tlbimp.exe</a> to generate a managed DLL with all of the objects and interfaces from the COM library.  You proceed to use the code that Microsoft so conveniently converted for you fully confident that all is well.

But it's not.  See, suppose your COM library has a method that returns a <strong>BSTR</strong> via an [out] parameter, or perhaps it defines an interface for a listener your managed code must implement.  Suddenly there is the potential for a serious memory leak!

See, a <strong>BSTR</strong> in unmanaged code aren't just any normal string.  <strong>BSTR</strong>'s are allocated by the system by calling <strong>SysAllocString</strong> and subsequently released by calling <strong>SysFreeString</strong>.  This poses a problem for managed code if you aren't careful.  Take the following listener interface for example.
<p style="font-family: italic; font-size: 10px">*Interface names and GUID's changed to protect the innocent</p>

<pre line="1" lang="idl">
interface IImplementMeListener : IDispatch{
[
id(0x000000C9)
]
HRESULT _stdcall notify([in] TEventType eventType, [in] BSTR data );
};</pre>
The Tlbimp.exe generates a managed assembly with the following signature for this same method.
<pre line="1" lang="csharp">
[ComImport, TypeLibType((short) 0x10c0), Guid("00000000-0000-0000-0000-000000000000")]
public interface IImplementMeListener
{
    [MethodImpl(MethodImplOptions.InternalCall, MethodCodeType=MethodCodeType.Runtime), DispId(0xc9)]
    void notify([In, ComAliasName("ExampleLib.TEventType")] TEventType eventType,
        [In, MarshalAs(UnmanagedType.BStr)] string data);
}</pre>
Which means when you implement this interface in your managed class, you'll just have <strong>String</strong> as the data type for the second parameter.  Which might look like this.
<pre line="1" lang="csharp">
class MyManagedListener : ExampleLib.IImplementMeListener{
    public void notify(ExampleLib.TEventType eventType, String data)
    {
        DoSomethingWithData(data);
    }
}</pre>
So this is what happens.

1) Your COM library allocates the string to pass into your listener using <strong>SysAllocString</strong>.

2) Your COM library passes the newly allocated string into your managed app by calling the <strong>notify</strong> method of your listener.

3) Your managed app does whatever it's going to do with the string, then returns.

Normally in a fully managed app this would be no problem, when the reference count to the string finally reaches 0, the garbage collector sweeps it up and the memory is reclaimed.  However, in this case we have a problem.  The COM library allocated the string, and passed it into your managed app, and it's responsibility for that string ends there.  The expectation is that the client will release the <strong>BSTR</strong> by calling <strong>SysFreeString</strong>.  Clearly we can't explicitly do that to the managed <strong>String</strong> type.

So what do we do?  We rewrite the part of the assembly that Tlbimp.exe made for us, and adjust our listener implementation slightly.

This is how I did it, though there may be better ways.

1) Use a disassembler to view the code of the Tlbimp.exe generated assembly for your COM library.  I used, <a href="http://www.aisto.com/roeder/dotnet/">Lutz's Reflector</a>.

2) Copy the code for the entire library into a *.cs file, then change just the signature of the method you're concerned with.

The new signature should look like this.
<pre line="1" lang="csharp">
[ComImport, Guid("00000000-0000-0000-0000-000000000000"), TypeLibType((short) 0x10c0)]
public interface IImplementMeListener
{
[MethodImpl(MethodImplOptions.InternalCall, MethodCodeType=MethodCodeType.Runtime), DispId(0xc9)]
    void notify([In, ComAliasName("ExampleLib.TEventType")] TEventType eventType,
        [In] IntPtr data);
}</pre>
And your implementing class changes to this.
<pre line="1" lang="csharp">
class MyManagedListener : ExampleLib.IImplementMeListener{
    public void notify(ExampleLib.TEventType eventType, IntPtr data)
    {
        String dataStr = Marshal.PtrToStringBSTR(data);
        DoSomethingWithData(dataStr);
        Marshal.FreeBSTR(data);
    }
}</pre>
This is not particularly tricky wizardry.  All we're doing is marshaling the input value from the library as an <strong>IntPtr</strong> instead of a managed <strong>String</strong>.  This allows us to explicitly release it using the <strong>System.Runtime.InteropServices.Marshal.FreeBSTR</strong> method, just like the library expects us to do.

Hopefully, this will save you some hastle, and avoid a potentially large memory leak.
