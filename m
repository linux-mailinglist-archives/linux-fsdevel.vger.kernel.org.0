Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED93209E1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 14:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404393AbgFYMHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 08:07:33 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55355 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404222AbgFYMHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:07:33 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id B78A3580424;
        Thu, 25 Jun 2020 08:07:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 25 Jun 2020 08:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=PiBMVVu5x8FU1A2d+mE/UjKt5Vm
        t02B5VJYAAFZjK5A=; b=cw8o465cp2YW6tqJTrLs7+c96T3Zl8Cm8v1diSoqz6K
        ojoNTAssI6J9IyWq3jbHP9Xt7fTJ3viZieEDwFIOCVpYNWc7cSyWd1mM4kHd2yrB
        Egz/MPXIX6kIcLq0m9yXsyllMqPmA9U0vKiIJSJRmpTlzyIn2iFf5m0d2T02fWqX
        RmOiNKTzIhertR7xFN4ol+PjjlwX0bzPjQknZIzmRP2AIZANtp7t15VcPqzv5ebV
        857Kc2o7j4MghLF8KFlRxSmR/kUH80LTzuAG7xtZjvgxhjIdQzmb5Mccwc8Rvfrl
        9o88Nd88Vqbid1Di3cXf5ay0EpNpF+1yiUtZQb10nJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PiBMVV
        u5x8FU1A2d+mE/UjKt5Vmt02B5VJYAAFZjK5A=; b=k5vM73JGgo0AoQ33fPHuvx
        AgH3ZCpETBWv5WeuMvKZYwbmVSx03gq1NM9gXiML2p0FFPvvp0LODlOOmkyo0CNZ
        PAhE6XJpMFPUU98hm5qd0kNSU6drbtTptrKPHzAb1in3GyljIJ76u8oXNmByb+tm
        kU1f1K/PBeIA/zMFfHsEcrcE5jA21VIf/ze+BmEUai6W6hti5uvupkbnmAKkyogq
        Hhv/wEu8rHvlhU6HnPOzMu40SQTDm0l5XXwGexi2waqMOeWwCodbSyarGiKAj1V9
        vUgMrlO9Ds49OPBcW7hd+Q1wHZOjLYfo79JaTBRhLS9Pi1ueygOo0GdwKKeoXbBQ
        ==
X-ME-Sender: <xms:gpP0XiOd1X8mrjfZsYChyNZpxXKcG8nds5xgcAW039LCOKgbyG-MSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekledggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:gpP0Xg92W9cEmQa6urOQyFXtDZVeyrZEfiFEZqw3xARC8APVk_VG6Q>
    <xmx:gpP0XpQWN628-sjZUJ3IS07E3XWsIxjSYVJ8OnOrCrnbR5fvOGmQ2w>
    <xmx:gpP0XisBEaztrWDCCeNG3BNdztkKEzMc3n9nyFke5j11ZFirIN2O8g>
    <xmx:g5P0Xl35HjYXZvbNfAQDj8T3pjrj7dZw6i03T-l74k-aojcrFArJlA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1A5553280059;
        Thu, 25 Jun 2020 08:07:30 -0400 (EDT)
Date:   Thu, 25 Jun 2020 14:07:25 +0200
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
Message-ID: <20200625120725.GA3493334@kroah.com>
References: <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org>
 <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
 <20200625013518.chuqehybelk2k27x@ast-mbp.dhcp.thefacebook.com>
 <b83831ba-c330-7eb8-e6d5-5087de68a9b8@i-love.sakura.ne.jp>
 <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 08:03:26PM +0900, Tetsuo Handa wrote:
> On 2020/06/25 18:57, Greg KH wrote:
> > On Thu, Jun 25, 2020 at 03:38:14PM +0900, Tetsuo Handa wrote:
> >> My questions are:
> >>
> >> (1) "Signed and in-tree kernel module" assertion is pointless.
> >>     In future, some of in-tree kernel modules might start using fork_usermode_blob()
> >>     instead of call_usermodehelper(), with instructions containing what your initial
> >>     use case does not use. There is no guarantee that such thing can't happen.
> > 
> > I hope that this would happen for some tools, what's wrong with that?
> > That means we can ship those programs from within the kernel source tree
> > instead of trying to rely on keeping a specific user/kernel api stable
> > for forever.
> > 
> > That would be a good thing, right?
> 
> Some in-tree users might start embedding byte array containing userspace programs
> like /bin/sh when building kernels. How can we prove that such thing won't happen?

We have the code, we can read it, we can say, "hey, looks like you are
including bash, do you want to do that?"  :)

> I consider that the byte array can contain arbitrary instructions (regardless of
> some tools used for building the byte array).

Sure, and is this a problem?

> >>     Assuming that there will be multiple blobs, we need a way to identify these blobs.
> >>     How does fork_usermode_blob() provide information for identification?
> > 
> > If the kernel itself was running these blobs, why would LSM care about
> > it?  These are coming from "within the building!" don't you trust the
> > kernel already?
> > 
> > I don't understand the issue here.
> 
> The byte array came from the kernel, but due to possibility of "root can poke into
> kernel or any process memory.", that byte array can become as untrusted as byte
> array coming from userspace. There is no concept like "the kernel itself _is_ running
> these blobs". Only a fact "the byte array _was_ copied from the kernel address space
> (rather than from some file on the filesystem)" exists. We need a mechanism (ideally,
> without counting on LSMs) for avoid peeking/poking etc. into/from the byte array
> which was copied from the kernel address space to user address space.

And what are you going to do with that if you can "look at the array"?
I really don't understand the objection here, why is this any different
than any other random kernel driver for what it can do?

> >>     call_usermodehelper() can teach LSM modules via pre-existing file's pathname and
> >>     inode's security label at security_bprm_creds_for_exec()/security_bprm_check() etc.
> >>     But since fork_usermode_blob() accepts only "byte array" and "length of byte array"
> >>     arguments, I'm not sure whether LSM modules can obtain information needed for
> >>     inspection. How does fork_usermode_blob() tell that information?
> > 
> > It would seem that the "security context" for those would be the same as
> > anything created before userspace launches today, right?  You handle
> > that ok, and this should be just the same.
> 
> I don't think so. Today when call_usermodehelper() is called, LSMs switch their security
> context (at least TOMOYO does it) for further syscalls from the usermode process started
> by the kernel context. But when fork_usermode_blob() is called, how LSMs can switch their
> security context for further syscalls from the usermode process started by the kernel
> context?

Ok, that makes a bit more sense.  Why not just do the same thing that
you do today with call_usermodehelper()?  The logic in a way is the
same, right?

> > But again, as these programs are coming from "within the kernel", why
> > would you want to disallow them?  If you don't want to allow them, don't
> > build them into your kernel?  :)
> 
> I'm talking about not only "disallow unauthorized execve() request" but also "disallow
> unauthorized syscalls after execve() request". Coming from the kernel is not important.

Ok, then do the same thing that you do for call_usermodehelper() to
prevent this.

> >>     Thus, LSM modules (including pathname based security) want to control how that byte
> >>     array can behave. And how does fork_usermode_blob() tell necessary information?
> > 
> > Think of these blobs just as any other kernel module would be today.
> 
> No, I can't. How can we guarantee that the byte array came from kernel remains intact
> despite the possibility of "root can poke into kernel or any process memory" ?

You guarantee it the same way you guarantee that the wifi driver really
is running the code you think it is running.  There is no difference
here.

> > Right now I, as a kernel module, can read/write to any file in the
> > system, and do all sorts of other fun things.  You can't mediate that
> > today from a LSM, and this is just one other example of this.
> 
> Some functions (e.g. kernel_sock_shutdown()) bypass permission checks by LSMs
> comes from a sort of trustness that the byte array kept inside kernel address
> space remains secure/intact.

And what is going to change that "trustness" here?  The byte array came
from the kernel address space to start with.  Are you thinking something
outside of the kernel will then tamper with those bytes to do something
else with them?  If so, shouldn't you be preventing that userspace
program that does the tampering from doing that in the first place with
the LSM running?

> > The "only" change is that now this code is running in userspace context,
> > which for an overall security/system issue, should be better than
> > running it in kernel context, right?
> 
> As soon as exposing that byte array outside of kernel address space, processes
> running such byte array are considered insecure/tampered.

Why?  Do you mean that you do not trust any program once it has been
started either?  If you can, why not do the same thing here?

> We can't prove that
> the byte array exposed to outside of kernel address space does only limited
> set of instructions, and we have to perform permission checks by LSMs.

Those checks should come through the same way you check any other
userspace program through an LSM.  Fix up the context like mentioned
above with call_usermodehelper() and you should be fine, right?

> And LSMs need to receive the intent (or "security context" argument) from fork_usermode_blob()
> for restricting further syscalls by the usermode process started via fork_usermode_blob().
> 
> > 
> > Perhaps we just add new LSM hooks for every place that we call this new
> > function to run a blob?  That will give you the needed "the kernel is
> > about to run a blob that we think is a userspace USB IR filter driver",
> > or whatever the blob does.
> 
> Yes, that would be the intent (or "security context" argument) fork_usermode_blob()
> is missing. Though I don't know how such stringuish argument can be represented for
> individual LSM modules...

The same way we do it today for any LSM callback?  i.e. by a new
function call :)

thanks,

greg k-h
