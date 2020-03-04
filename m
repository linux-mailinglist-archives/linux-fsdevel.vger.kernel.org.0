Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9CB1787EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 03:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgCDCBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 21:01:45 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:44619 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727725AbgCDCBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:01:45 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id D50014BCC;
        Tue,  3 Mar 2020 21:01:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 03 Mar 2020 21:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        ow4wwXQIg9ovCqqBjjjTQMs5ZKSMH9h5wtQ/U1CNI/I=; b=vDPbhtWTqiBiUQry
        B1qXySlymx6WucS60DbKY/k3yxXdgkijDpLdraCuA6qqY/1rusUCZvinzKpoXQlT
        vQK51RWEHlRcQm9Wu7/ygpykpyYACaLGWin8w3PubywD5mZ+i2kjY3nRILBDlNb/
        2J5cLHfMj3r/BHP3sPRIJlI1ou13L36kJmvVXaoY2wPCW+Egymg8oriIt9FAYiSj
        RcDhx3MoxwDpUSi6a+FhzYAKoYo3y5oR17IYbmH9jscxV5Qog/TX2BsP/6pPiEfx
        jl7vo3Y+vVfd0kfuAqadwIOAxFQaG3z/X02VYL+0pgH1KXR1i7yPomSe1tFz4UUM
        v2ZhGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=ow4wwXQIg9ovCqqBjjjTQMs5ZKSMH9h5wtQ/U1CNI
        /I=; b=gctaaglvDbkWZxX8IvhuEc3hMbS93cVej20svOfL42SOTof7DxnnnIJ2E
        EfCwjiUtphQ61Xy+RfujGBtVdIwNZ9JD9iSPb9mxSJvSbu8gmQM4JkL+n1iZU4vO
        kdUZqMQ2hz7C83cn/EtrLto5BxzeYlAWxvl52tD0MyC9k48Z/6Nox5IkUyMFtvxl
        RjJt51LcK7XBIm8iFl1pPR6hM7OO7kWaSBUJdsKxRGRnd216QdX2kXfH32L+wCSS
        0J99u0agy4eJyFJSzXCPNrfiCAs8P341khlZGoE6EiQVMl17EDMSKPv++2fxLfcK
        KSITryfZXHbSItn+co5uUDPOxUcDA==
X-ME-Sender: <xms:BgxfXuGLOxUSByDJ8jy-5pyDace_gLPSJgmB70kBBMRvWdyqEhg05g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddtjedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtke
    drudektddrvddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:BgxfXtLCknRPtWwE86XXC3rwy0pVR1chvaPVbZHTCV00-SeOX9Hq0g>
    <xmx:BgxfXinVXuCvUWH2ouDYQSdD-zlfItf_r00yukPTThsswleQhuPshw>
    <xmx:BgxfXlTmRRpUDMheX1NVKlWyFvoS1aAlFybjDCRLikM-1BY0w6yXrA>
    <xmx:BwxfXsE8W3Bmqg4AueenI57GlWlN7i5b0lVa2g4WxLy11sUSyo8_ygTlTic>
Received: from mickey.themaw.net (unknown [118.208.180.202])
        by mail.messagingengine.com (Postfix) with ESMTPA id C9AA93280063;
        Tue,  3 Mar 2020 21:01:37 -0500 (EST)
Message-ID: <33d900c8061c40f70ba2b9d1855fd6bd1c2b68bb.camel@themaw.net>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karel Zak <kzak@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Wed, 04 Mar 2020 10:01:33 +0800
In-Reply-To: <20200303130347.GA2302029@kroah.com>
References: <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
         <1582644535.3361.8.camel@HansenPartnership.com>
         <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
         <107666.1582907766@warthog.procyon.org.uk>
         <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
         <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
         <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
         <1509948.1583226773@warthog.procyon.org.uk>
         <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
         <20200303113814.rsqhljkch6tgorpu@ws.net.home>
         <20200303130347.GA2302029@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-03-03 at 14:03 +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 03, 2020 at 12:38:14PM +0100, Karel Zak wrote:
> > On Tue, Mar 03, 2020 at 10:26:21AM +0100, Miklos Szeredi wrote:
> > > No, I don't think this is going to be a performance issue at all,
> > > but
> > > if anything we could introduce a syscall
> > > 
> > >   ssize_t readfile(int dfd, const char *path, char *buf, size_t
> > > bufsize, int flags);
> > 
> > off-topic, but I'll buy you many many beers if you implement it ;-
> > ),
> > because open + read + close is pretty common for /sys and /proc in
> > many userspace tools; for example ps, top, lsblk, lsmem, lsns,
> > udevd
> > etc. is all about it.
> 
> Unlimited beers for a 21-line kernel patch?  Sign me up!
> 
> Totally untested, barely compiled patch below.
> 
> Actually, I like this idea (the syscall, not just the unlimited
> beers).
> Maybe this could make a lot of sense, I'll write some actual tests
> for
> it now that syscalls are getting "heavy" again due to CPU vendors
> finally paying the price for their madness...

The problem isn't with open->read->close but with the mount info.
changing between reads (ie. seq file read takes and drops the
needed lock between reads at least once).

The problem is you don't know the buffer size needed to get this
in one hit, how is this different to read(2)?

> 
> thanks,
> 
> greg k-h
> -------------------
> 
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl
> b/arch/x86/entry/syscalls/syscall_64.tbl
> index 44d510bc9b78..178cd45340e2 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -359,6 +359,7 @@
>  435	common	clone3			__x64_sys_clone3/ptregs
>  437	common	openat2			__x64_sys_openat2
>  438	common	pidfd_getfd		__x64_sys_pidfd_getfd
> +439	common	readfile		__x86_sys_readfile
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache
> impact
> diff --git a/fs/open.c b/fs/open.c
> index 0788b3715731..1a830fada750 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1340,3 +1340,23 @@ int stream_open(struct inode *inode, struct
> file *filp)
>  }
>  
>  EXPORT_SYMBOL(stream_open);
> +
> +SYSCALL_DEFINE5(readfile, int, dfd, const char __user *, filename,
> +		char __user *, buffer, size_t, bufsize, int, flags)
> +{
> +	int retval;
> +	int fd;
> +
> +	if (force_o_largefile())
> +		flags |= O_LARGEFILE;
> +
> +	fd = do_sys_open(dfd, filename, flags, O_RDONLY);
> +	if (fd <= 0)
> +		return fd;
> +
> +	retval = ksys_read(fd, buffer, bufsize);
> +
> +	__close_fd(current->files, fd);
> +
> +	return retval;
> +}

