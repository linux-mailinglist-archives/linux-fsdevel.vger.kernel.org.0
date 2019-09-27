Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34426C0002
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 09:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfI0H1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 03:27:02 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58101 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfI0H1C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:27:02 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B5941221CF;
        Fri, 27 Sep 2019 03:27:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Sep 2019 03:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        Jziqa9PfVj9L8hy/qpQNgHSLStG0zKGVAV2eeX50w8A=; b=HaSrqwVPll7PPGcU
        ZM0V8K1fI2oNvq02/u6Nh5WwXkL7sEW3ddtwxRBadGRZYptrhx+nh1fPWdZd/M3r
        60PvDAah1fJ+IrO6Ja+iqmYZZCoP5xdmW1eaS/hjsAskxP1qKar7b1rOT34P9RjG
        mbW9BdE3UTEm1NLYcG3yQm+X/+b8RGNbyo4Sfl5VvWTfH15ty1ae1ipvu3QvWpRB
        CPXouBz54UJw8CGRuc1/bSjqcZQ6Ccj1EmcisLUvCL1uKRSG3jZu954rhx2j8mK9
        MnZvGtYIWVH1N/mF0q5O2DhMWNvpF/K7NtUSBtb+x49EdeIAMtDtAfvLA8YA5L1V
        VpXxLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Jziqa9PfVj9L8hy/qpQNgHSLStG0zKGVAV2eeX50w
        8A=; b=etBibQxctCg+FXOdLQH1AmGR89Kl9VcUcBZxDuoZp4y0Li38NGZAfiR8R
        ZDJylPsSH4+1T5nxFeNRr33Il9AwVntl8a6QGq3Y87+gHfDjWA/s0CBdIwPTdkHd
        mZbuXVEwPTF1yglA7GRV0eId8DWH+kwz0jUK3BPB0Kzzsv5tZaCULY604wA6OouP
        aPsafGDmsEXIkDF4yMqUyhoj3TOxEUHRkDp0NmsdvxuSnWLVNStDbOaljcwggQ3I
        87UclAxu2wC6VmarIqCBC59nOxHvPxRdBzOHBYTUljJAxtXBUalOdHANe8BCJ4B7
        hDZ04pUlvFqzPjKakQQRabqtKC+zA==
X-ME-Sender: <xms:xLmNXWzvNWu0pfHCVtXdmvToR76cB0tRmoIOpeh_Ux8PYRk5OhFZNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrfeehgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucffohhmrghinheprhgvug
    hhrghtrdgtohhmnecukfhppeduudekrddvtdelrdduieekrddvieenucfrrghrrghmpehm
    rghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvghtnecuvehluhhsthgvrhfuih
    iivgeptd
X-ME-Proxy: <xmx:xLmNXenlTDzGoIOdtsqO3o1cp5huV9YU_FMyy6IZwE3WIBixM0_LVA>
    <xmx:xLmNXbFDGNPmaPcM6M1Cez7X8DhuJxxlXbxeOOanUDmNlhPF_2TxhA>
    <xmx:xLmNXeV35WtlSMwiMf4HDYHcfxaJDVZV5ILwHwpPtsYOfto42bBG_w>
    <xmx:xLmNXcSLCgIzCntqn8z5Ovu0W4xQHgq9KYNf4j73I6WplpVSfVU1vA>
Received: from mickey.themaw.net (unknown [118.209.168.26])
        by mail.messagingengine.com (Postfix) with ESMTPA id 13EC48005A;
        Fri, 27 Sep 2019 03:26:57 -0400 (EDT)
Message-ID: <d163042ab8fffd975a6d460488f1539c5f619eaa.camel@themaw.net>
Subject: Re: [RFC] Don't propagate automount
From:   Ian Kent <raven@themaw.net>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, viro@zeniv.linux.org.uk
Cc:     autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 27 Sep 2019 15:26:53 +0800
In-Reply-To: <e5fbf32668aea1b8143d15ff47bd1e4309d03b17.camel@themaw.net>
References: <20190926195234.bipqpw5sbk5ojcna@fiona>
         <3468a81a09d13602c67007759593ddf450f8132c.camel@themaw.net>
         <e5fbf32668aea1b8143d15ff47bd1e4309d03b17.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-09-27 at 15:09 +0800, Ian Kent wrote:
> On Fri, 2019-09-27 at 09:35 +0800, Ian Kent wrote:
> > On Thu, 2019-09-26 at 14:52 -0500, Goldwyn Rodrigues wrote:
> > > An access to automounted filesystem can deadlock if it is a bind
> > > mount on shared mounts. A user program should not deadlock the
> > > kernel
> > > while automount waits for propagation of the mount. This is
> > > explained
> > > at https://bugzilla.redhat.com/show_bug.cgi?id=1358887#c10
> > > I am not sure completely blocking automount is the best solution,
> > > so please reply with what is the best course of action to do
> > > in such a situation.
> > > 
> > > Propagation of dentry with DCACHE_NEED_AUTOMOUNT can lead to
> > > propagation of mount points without automount maps and not under
> > > automount control. So, do not propagate them.
> > 
> > Yes, I'm not sure my comments about mount propagation in that
> > bug are accurate.
> > 
> > This behaviour has crept into the kernel in reasonably recent
> > times, maybe it's a bug or maybe mount propagation has been
> > "fixed", not sure.
> > 
> > I think I'll need to come up with a more detailed description
> > of what is being done for Al to be able to offer advice.
> > 
> > I'll get to that a bit later.
> 
> To duplicate this problem use an autofs indirect map
> that uses bind mounts and has offsets:
> 
> test	/	:/exports \
> 	/tmp	:/exports/tmp \
> 	/lib	:/exports/lib
> 
> and add:
> 
> /bind	/etc/auto.exports
> 
> to /etc/auto.master.
> 
> Finally create the bind mount directories:
> 
> mkdir -p /exports/lib /exports/tmp
> 
> Then, on a broken kernel, eg. 4.13.9-300.fc27:
> 
> ls /bind/test
> 
> will result in:
> 
> /etc/auto.exports on /bind type autofs
> (rw,relatime,fd=5,pgrp=2981,timeout=300,minproto=5,maxproto=5,indirec
> t,pipe_ino=45485)
> /dev/mapper/fedora_f27-root on /bind/test type ext4
> (rw,relatime,seclabel,data=ordered)
> /etc/auto.exports on /bind/test/lib type autofs
> (rw,relatime,fd=5,pgrp=2981,timeout=300,minproto=5,maxproto=5,offset,
> pipe_ino=45485)
> /etc/auto.exports on /exports/lib type autofs
> (rw,relatime,fd=5,pgrp=2981,timeout=300,minproto=5,maxproto=5,offset,
> pipe_ino=45485)
> /etc/auto.exports on /bind/test/tmp type autofs
> (rw,relatime,fd=5,pgrp=2981,timeout=300,minproto=5,maxproto=5,offset,
> pipe_ino=45485)
> /etc/auto.exports on /exports/tmp type autofs
> (rw,relatime,fd=5,pgrp=2981,timeout=300,minproto=5,maxproto=5,offset,
> pipe_ino=45485)
> 
> these mount entries, not all of which have been mounted by autofs.
> 
> Whereas on a kernel that isn't broken, eg. 4.11.8-300.fc26, the same
> ls command will result in:
> 
> /etc/auto.exports on /bind type autofs
> (rw,relatime,fd=6,pgrp=2920,timeout=300,minproto=5,maxproto=5,indirec
> t,pipe_ino=42067)
> /etc/auto.exports on /bind/test/lib type autofs
> (rw,relatime,fd=6,pgrp=2920,timeout=300,minproto=5,maxproto=5,offset,
> pipe_ino=42067)
> /etc/auto.exports on /bind/test/tmp type autofs
> (rw,relatime,fd=6,pgrp=2920,timeout=300,minproto=5,maxproto=5,offset,
> pipe_ino=42067)
> 
> these mount entries, all of which have been mounted by autofs (and
> are what's needed for these offset mount constructs).
> 
> If the /bind mount is made propagation slave or private at mount
> by automount the problem doesn't happen and that is the workaround
> I implemented in autofs.

Actually that's not quite right, there should be a bind mount at
/bind/test as well but it's not present.

Although I expect this will happen with a rootless multi-mount
as well, aka.

test \
   /tmp	:/exports/tmp \
   /lib	:/exports/lib

Leave it with me while I investigate further.

> 
> I initially thought this was the result of a "fix" in the mount
> propagation code but it occurred to me that propagation is meant
> to occur between mount trees not within them so this might be a
> bug.
> 
> I probably should have worked out exactly what upstream kernel
> this started happening in and then done a bisect and tried to
> work out if the change was doing what it was supposed to.
> 
> Anyway, I'll need to do that now for us to discuss this sensibly.
> 
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > 
> > > diff --git a/fs/pnode.c b/fs/pnode.c
> > > index 49f6d7ff2139..b960805d7954 100644
> > > --- a/fs/pnode.c
> > > +++ b/fs/pnode.c
> > > @@ -292,6 +292,9 @@ int propagate_mnt(struct mount *dest_mnt,
> > > struct
> > > mountpoint *dest_mp,
> > >  	struct mount *m, *n;
> > >  	int ret = 0;
> > >  
> > > +	if (source_mnt->mnt_mountpoint->d_flags &
> > > DCACHE_NEED_AUTOMOUNT)
> > > +		return 0;
> > > +
> > 
> > Possible problem with this is it will probably prevent mount
> > propagation in both directions which will break stuff.
> > 
> > I had originally assumed the problem was mount propagation
> > back to the parent mount but now I'm not sure that this is
> > actually what is meant to happen.
> > 
> > >  	/*
> > >  	 * we don't want to bother passing tons of arguments to
> > >  	 * propagate_one(); everything is serialized by namespace_sem,
> > > 

