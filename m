Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C9209C59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390704AbgFYJ5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 05:57:32 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:43007 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388485AbgFYJ5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:57:32 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id A82B97B3;
        Thu, 25 Jun 2020 05:57:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 25 Jun 2020 05:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=V805shkVOPNnHUNuLuHeH4UuBCN
        6jSEp2aG2hEIbnPg=; b=VG+m5GQu1uYFLcDSHZeJGZcpdUCHBA0mOAgZPdnh8dH
        EXKniL9wfaSKceUEI3KXc+WfKYPGvdbiCm60wIEiNl8p/I5TfEwGg/PxMLl6UnTL
        ewStxtu6XJPrzdestIUKoVq7fm4DcObM0k+SfLAn9Zkg2FkM9PLko8uzszafnE77
        CrfvA9uwKc0528FE7geTniah8qnOt+7r7TDITw6uich5+9VaJc7lQVrngJ6yBkuv
        xLP3ukqN6jpJLyQHGa9DISYyadaz3wSLQnqlbRWhFYa3vbldH+plTX0hiZo6qvhs
        5ydNc9DM8Gt33Q8IOayqwqQsDz0z2xbE1GguSCGQ/oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=V805sh
        kVOPNnHUNuLuHeH4UuBCN6jSEp2aG2hEIbnPg=; b=gJFDwjURhRCiAQNBRg5QyC
        fdFiNnRQ1JY8k9F5E/GYMz8WvZ+wtWJNDrUJtPOO8mYnZ8KW4dZ6sOOnee21Nez6
        oyTeTK+vBStNN36yHirCaX4OgGVXgYklOlJ12JTxag01PrV+VysdjQBgle9TW6fO
        EtIvcvRsgDO+rqrIFrKpOq669dnNI9wB6Owfjn5s0LDOMopt3hpnWWkGTYdSBkA1
        5EdpwO2GY6HKg4cQq1MxcAHWsuCqnr3FWWnBWCYTc4FNl2jHNLFZgkL8q1Ph6KwO
        GMUskCqMaIVyUS7dSe+31W+un27/MkgEhI7uS04JUF0Gy8ToZIGNd8GtpLuIqatA
        ==
X-ME-Sender: <xms:CHX0XihKNBPTZ-rn06vP8s6HYzJWPp3j3pSlh4NyDRKFpez4I_K9aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekledgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:CHX0XjCfuXxgtWINNHRw5O5-NNBYmyQ18tyhPr-Rh0x0zJVkQf4Daw>
    <xmx:CHX0XqE_rjdwLkKQK7IryPM-2n7GBDz3uWcmmUDRTe3RbQho1gaOGg>
    <xmx:CHX0XrQpq821-lDfNwCwgYhunB2dJ0T1_mY4uWbQ-xMahd0mLuMZEg>
    <xmx:CXX0XkLV8Ymx-z-bmK-70bfaCQK9IVPRte_lO0blcUQlb4-o7PdVEt-HDhY>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9566E30677A9;
        Thu, 25 Jun 2020 05:57:27 -0400 (EDT)
Date:   Thu, 25 Jun 2020 11:57:25 +0200
From:   Greg KH <greg@kroah.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200625095725.GA3303921@kroah.com>
References: <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org>
 <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
 <20200625013518.chuqehybelk2k27x@ast-mbp.dhcp.thefacebook.com>
 <b83831ba-c330-7eb8-e6d5-5087de68a9b8@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b83831ba-c330-7eb8-e6d5-5087de68a9b8@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 03:38:14PM +0900, Tetsuo Handa wrote:
> On 2020/06/25 10:35, Alexei Starovoitov wrote:
> >> What is unhappy for pathname based LSMs is that fork_usermode_blob() creates
> >> a file with empty filename. I can imagine that somebody would start abusing
> >> fork_usermode_blob() as an interface for starting programs like modprobe, hotplug,
> >> udevd and sshd. When such situation happened, how fork_usermode_blob() provides
> >> information for identifying the intent of such execve() requests?
> >>
> >> fork_usermode_blob() might also be an unhappy behavior for inode based LSMs (like
> >> SELinux and Smack) because it seems that fork_usermode_blob() can't have a chance
> >> to associate appropriate security labels based on the content of the byte array
> >> because files are created on-demand. Is fork_usermode_blob() friendly to inode
> >> based LSMs?
> > 
> > blob is started by a kernel module. Regardless of path existence that kernel module
> > could have disabled any LSM and any kernel security mechanism.
> > People who write out of tree kernel modules found ways to bypass EXPORT_SYMBOL
> > with and without _GPL. Modules can do anything. It's only the number of hoops
> > they need to jump through to get what they want.
> 
> So what? I know that. That's irrelevant to my questions.
> 
> > Signed and in-tree kernel module is the only way to protect the integrity of the system.
> > That's why user blob is part of kernel module elf object and it's covered by the same
> > module signature verification logic.
> 
> My questions are:
> 
> (1) "Signed and in-tree kernel module" assertion is pointless.
>     In future, some of in-tree kernel modules might start using fork_usermode_blob()
>     instead of call_usermodehelper(), with instructions containing what your initial
>     use case does not use. There is no guarantee that such thing can't happen.

I hope that this would happen for some tools, what's wrong with that?
That means we can ship those programs from within the kernel source tree
instead of trying to rely on keeping a specific user/kernel api stable
for forever.

That would be a good thing, right?

>     Assuming that there will be multiple blobs, we need a way to identify these blobs.
>     How does fork_usermode_blob() provide information for identification?

If the kernel itself was running these blobs, why would LSM care about
it?  These are coming from "within the building!" don't you trust the
kernel already?

I don't understand the issue here.


> (2) Running some blob in usermode means that permission checks by LSM modules will
>     be enforced. For example, socket's shutdown operation via shutdown() syscall from
>     usermode blob will involve security_socket_shutdown() check.
>     
>     ----------
>     int kernel_sock_shutdown(struct socket *sock, enum sock_shutdown_cmd how)
>     {
>             return sock->ops->shutdown(sock, how);
>     }
>     ----------
>     
>     ----------
>     int __sys_shutdown(int fd, int how)
>     {
>             int err, fput_needed;
>             struct socket *sock;
>     
>             sock = sockfd_lookup_light(fd, &err, &fput_needed);
>             if (sock != NULL) {
>                     err = security_socket_shutdown(sock, how);
>                     if (!err)
>                             err = sock->ops->shutdown(sock, how);
>                     fput_light(sock->file, fput_needed);
>             }
>             return err;
>     }
>     
>     SYSCALL_DEFINE2(shutdown, int, fd, int, how)
>     {
>             return __sys_shutdown(fd, how);
>     }
>     ----------
>     
>     I don't know what instructions your blob would contain. But even if the blobs
>     containing your initial use case use only setsockopt()/getsockopt() syscalls,
>     LSM modules have rights to inspect and reject these requests from usermode blobs
>     via security_socket_setsockopt()/security_socket_getsockopt() hooks. In order to
>     inspect these requests, LSM modules need information (so called "security context"),
>     and fork_usermode_blob() has to be able to somehow teach that information to LSM
>     modules. Pathname is one of information for pathname based LSM modules. Inode's
>     security label is one of information for inode based LSM modules.
>     
>     call_usermodehelper() can teach LSM modules via pre-existing file's pathname and
>     inode's security label at security_bprm_creds_for_exec()/security_bprm_check() etc.
>     But since fork_usermode_blob() accepts only "byte array" and "length of byte array"
>     arguments, I'm not sure whether LSM modules can obtain information needed for
>     inspection. How does fork_usermode_blob() tell that information?

It would seem that the "security context" for those would be the same as
anything created before userspace launches today, right?  You handle
that ok, and this should be just the same.

But again, as these programs are coming from "within the kernel", why
would you want to disallow them?  If you don't want to allow them, don't
build them into your kernel?  :)

> (3) Again, "root can poke into kernel or any process memory." assertion is pointless.
>     Answering to your questions
> 
>       > hmm. do you really mean that it's possible for an LSM to restrict CAP_SYS_ADMIN effectively?
>       Not every LSM module restricts CAP_* flags. But LSM modules can implement finer grained
>       restrictions than plain CAP_* flags.
> 
>       > How elf binaries embedded in the kernel modules different from pid 1?
>       No difference.
> 
>       > If anything can peek into their memory the system is compromised.
>       Permission checks via LSM modules are there to prevent such behavior.
> 
>       > Say, there are no user blobs in kernel modules. How pid 1 memory is different
>       > from all the JITed images? How is it different for all memory regions shared
>       > between kernel and user processes?
>       I don't know what "the JITed images" means. But I guess that the answer is
>       "No difference".
> 
>     Then, I ask you back.
> 
>     Although the byte array (which contains code / data) might be initially loaded from
>     the kernel space (which is protected), that byte array is no longer protected (e.g.
>     SIGKILL, ptrace()) when executed because they are placed in the user address space.
>
>     Why the usermode process started by fork_usermode_blob() cannot interfere (or be
>     interfered by) the rest of the system (including normal usermode processes) ?
>     And I guess that your answer is "the usermode process started by fork_usermode_blob()
>     _can_ (and be interfered by) the rest of the system, for they are nothing but
>     normal usermode processes."
> 
>     Thus, LSM modules (including pathname based security) want to control how that byte
>     array can behave. And how does fork_usermode_blob() tell necessary information?

Think of these blobs just as any other kernel module would be today.
Right now I, as a kernel module, can read/write to any file in the
system, and do all sorts of other fun things.  You can't mediate that
today from a LSM, and this is just one other example of this.

The "only" change is that now this code is running in userspace context,
which for an overall security/system issue, should be better than
running it in kernel context, right?

Perhaps we just add new LSM hooks for every place that we call this new
function to run a blob?  That will give you the needed "the kernel is
about to run a blob that we think is a userspace USB IR filter driver",
or whatever the blob does.

Would that help out?

But, given that we don't even have any in-kernel users, all of this
feels like a lot of arguing over something that no one can currently
even have happen...

thanks,

greg k-h
