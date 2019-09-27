Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E1CBFFC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfI0HJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 03:09:40 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56149 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbfI0HJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:09:39 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B7CD22362;
        Fri, 27 Sep 2019 03:09:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Sep 2019 03:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        GfB0VwhZ5Vb6U12HepXOfvATebN+pR5DmYnRUOROdAY=; b=fjkwsEXnqtXQcm4A
        Ra8GdmZ0j0Ujn53uZ8RxRA6oI2m8xalP/b358kgmzGbb20RNBrA+WTXyAxf73XLR
        lMXlwQRyRGUmX4UlC5MSku4jcdePfaB1RS+JuRqmnV8gVbPELC/ZmG/qPnqZ+a96
        y60CmERuUenQEC9/8Edx7zJ3OIKZhO2txch5sHPTZFjHPuhaY+mACExEIXUZl7ey
        2t4Iypo1VppWtQ+WEZzsMjM9TruoTvNT13tWflw32dNCVm4bCbiy+4QqjVcaWWmP
        30ccz04awOez5bWYi76+minmKu1RdBOK33sIODoBOjpTAOEt+hWhspueHczjxlfm
        4I+uHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=GfB0VwhZ5Vb6U12HepXOfvATebN+pR5DmYnRUOROd
        AY=; b=rPsB8scJ85Z/S47shSh2xCgjKRwXQxthlvQr1JgP51R5pOk+1SKN/sQhn
        w4J2aFdOxUvsFDLwl4Kgp9fs4WCCA0/wTpO7eJoA254KqOEIXSM5CCj0a9tOPR0j
        qHieptqk0SHiF7MxhURSd3Sm0leY0YRorFfnOkZzLmrQ6df+HtyiQfz2RMuq5kkc
        amIQ7XxPTI3snxr3O9eiKcmmq6khIfsLWwAYOGjpqCId1HtQZ/lSS3ka28Hkwp0k
        Bb7AWXA97IF99Jkkgzd5NTOfU3VAuG3qerLcEmZ1agzYgSWfCBGmp7UCgoqckvp/
        aspFlOl14YB5PiTuFlQgMqp/IHcQw==
X-ME-Sender: <xms:srWNXd6-EQkfFPl6DEMVIVz81fqt8wLruSKyiZMqjH1FPZLXiVItKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrfeehgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucffohhmrghinheprhgvug
    hhrghtrdgtohhmnecukfhppeduudekrddvtdelrdduieekrddvieenucfrrghrrghmpehm
    rghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvghtnecuvehluhhsthgvrhfuih
    iivgeptd
X-ME-Proxy: <xmx:srWNXQNZre6kQS-WP1D44sYNt-0180xiU-LjoZAd1zu8MQvl1JxZ3g>
    <xmx:srWNXUWpBWzyX2dhUinYiC13GNBMyskKIBtycAqTQtBcbYDf3nuewA>
    <xmx:srWNXWJcW3tgV98XkisKU16ly9r9CROEnBn9ZVr6PmHS4CpSb6SfVQ>
    <xmx:s7WNXcspxR-Neay0rz5EzmGNj-qwwaPva8jzAF3d5WKOy_f5OMN-hw>
Received: from mickey.themaw.net (unknown [118.209.168.26])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5202780059;
        Fri, 27 Sep 2019 03:09:36 -0400 (EDT)
Message-ID: <e5fbf32668aea1b8143d15ff47bd1e4309d03b17.camel@themaw.net>
Subject: Re: [RFC] Don't propagate automount
From:   Ian Kent <raven@themaw.net>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, viro@zeniv.linux.org.uk
Cc:     autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 27 Sep 2019 15:09:32 +0800
In-Reply-To: <3468a81a09d13602c67007759593ddf450f8132c.camel@themaw.net>
References: <20190926195234.bipqpw5sbk5ojcna@fiona>
         <3468a81a09d13602c67007759593ddf450f8132c.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-09-27 at 09:35 +0800, Ian Kent wrote:
> On Thu, 2019-09-26 at 14:52 -0500, Goldwyn Rodrigues wrote:
> > An access to automounted filesystem can deadlock if it is a bind
> > mount on shared mounts. A user program should not deadlock the
> > kernel
> > while automount waits for propagation of the mount. This is
> > explained
> > at https://bugzilla.redhat.com/show_bug.cgi?id=1358887#c10
> > I am not sure completely blocking automount is the best solution,
> > so please reply with what is the best course of action to do
> > in such a situation.
> > 
> > Propagation of dentry with DCACHE_NEED_AUTOMOUNT can lead to
> > propagation of mount points without automount maps and not under
> > automount control. So, do not propagate them.
> 
> Yes, I'm not sure my comments about mount propagation in that
> bug are accurate.
> 
> This behaviour has crept into the kernel in reasonably recent
> times, maybe it's a bug or maybe mount propagation has been
> "fixed", not sure.
> 
> I think I'll need to come up with a more detailed description
> of what is being done for Al to be able to offer advice.
> 
> I'll get to that a bit later.

To duplicate this problem use an autofs indirect map
that uses bind mounts and has offsets:

test	/	:/exports \
	/tmp	:/exports/tmp \
	/lib	:/exports/lib

and add:

/bind	/etc/auto.exports

to /etc/auto.master.

Finally create the bind mount directories:

mkdir -p /exports/lib /exports/tmp

Then, on a broken kernel, eg. 4.13.9-300.fc27:

ls /bind/test

will result in:

/etc/auto.exports on /bind type autofs (rw,relatime,fd=5,pgrp=2981,timeout=300,minproto=5,maxproto=5,indirect,pipe_ino=45485)
/dev/mapper/fedora_f27-root on /bind/test type ext4 (rw,relatime,seclabel,data=ordered)
/etc/auto.exports on /bind/test/lib type autofs (rw,relatime,fd=5,pgrp=2981,timeout=300,minproto=5,maxproto=5,offset,pipe_ino=45485)
/etc/auto.exports on /exports/lib type autofs (rw,relatime,fd=5,pgrp=2981,timeout=300,minproto=5,maxproto=5,offset,pipe_ino=45485)
/etc/auto.exports on /bind/test/tmp type autofs (rw,relatime,fd=5,pgrp=2981,timeout=300,minproto=5,maxproto=5,offset,pipe_ino=45485)
/etc/auto.exports on /exports/tmp type autofs (rw,relatime,fd=5,pgrp=2981,timeout=300,minproto=5,maxproto=5,offset,pipe_ino=45485)

these mount entries, not all of which have been mounted by autofs.

Whereas on a kernel that isn't broken, eg. 4.11.8-300.fc26, the same
ls command will result in:

/etc/auto.exports on /bind type autofs (rw,relatime,fd=6,pgrp=2920,timeout=300,minproto=5,maxproto=5,indirect,pipe_ino=42067)
/etc/auto.exports on /bind/test/lib type autofs (rw,relatime,fd=6,pgrp=2920,timeout=300,minproto=5,maxproto=5,offset,pipe_ino=42067)
/etc/auto.exports on /bind/test/tmp type autofs (rw,relatime,fd=6,pgrp=2920,timeout=300,minproto=5,maxproto=5,offset,pipe_ino=42067)

these mount entries, all of which have been mounted by autofs (and
are what's needed for these offset mount constructs).

If the /bind mount is made propagation slave or private at mount
by automount the problem doesn't happen and that is the workaround
I implemented in autofs.

I initially thought this was the result of a "fix" in the mount
propagation code but it occurred to me that propagation is meant
to occur between mount trees not within them so this might be a
bug.

I probably should have worked out exactly what upstream kernel
this started happening in and then done a bisect and tried to
work out if the change was doing what it was supposed to.

Anyway, I'll need to do that now for us to discuss this sensibly.

> 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > diff --git a/fs/pnode.c b/fs/pnode.c
> > index 49f6d7ff2139..b960805d7954 100644
> > --- a/fs/pnode.c
> > +++ b/fs/pnode.c
> > @@ -292,6 +292,9 @@ int propagate_mnt(struct mount *dest_mnt,
> > struct
> > mountpoint *dest_mp,
> >  	struct mount *m, *n;
> >  	int ret = 0;
> >  
> > +	if (source_mnt->mnt_mountpoint->d_flags &
> > DCACHE_NEED_AUTOMOUNT)
> > +		return 0;
> > +
> 
> Possible problem with this is it will probably prevent mount
> propagation in both directions which will break stuff.
> 
> I had originally assumed the problem was mount propagation
> back to the parent mount but now I'm not sure that this is
> actually what is meant to happen.
> 
> >  	/*
> >  	 * we don't want to bother passing tons of arguments to
> >  	 * propagate_one(); everything is serialized by namespace_sem,
> > 

