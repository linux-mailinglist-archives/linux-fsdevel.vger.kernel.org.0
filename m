Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4DEC0F44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2019 03:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfI1BrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 21:47:17 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58505 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbfI1BrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 21:47:17 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B2B8421240;
        Fri, 27 Sep 2019 21:47:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 27 Sep 2019 21:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        9qn4lTRuwnsm5s7oXrizvqhqRqTVOlG7gJtsPCNK9Hg=; b=uCynQEy2GVVobuiH
        kKpRmifpyWOk/0q6Xj1Yr+PC56IBALK1F14wDHxOsCLhVTfNLNJh2yNjSTAQGhHZ
        yTtsREAwXiduJy9RxTv6rbIBFesK0Ur6uwEAQ1C1htuhgw1LWUve22SrZ6tDkiwW
        EqW6bnrStHRNqQJFtxC7D3r7sYiFao3bArFth/O/5C6f32IhA9q2L1MRqBgFMGLh
        PY5DpoAiuq2kySVhWkz3FI52noMbVZNAvB8c6u0xnGG9VpcUdZwfIjOCU6ElKmMB
        psLgZNDF90BOPz3ATM22MEJ7N2HEiJ5etLT+J5yV3q891TxL74SN7ykxprJwQHUv
        SsJCyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=9qn4lTRuwnsm5s7oXrizvqhqRqTVOlG7gJtsPCNK9
        Hg=; b=t8fxynaoW6cPkNCTVqUBZQWvKw46VbaZGJHMAGedx4kiwWcTVL+DugRyH
        wEIBcm5leXRfR4IDBFgcJ8yRI9RTbQj2SLu0NYDAlQ1MHTuV6341reqqJONdeHPi
        WqsjWw15mDsAdGouQQL8fC3xvctqOre7/WR8RAK/CHmVMzQWXNYphcHwj5MS4Jsy
        S/N7ZYeuJx8q7S9LuWRAt/8wB6B5sbyJsRXMMIxa7qvmi9Q9GWEKNREgWZ4gZs5y
        /dn4SbfY5UAU7t39JO2mklJnYdb8DL/HO7rsuEkFB+/SyvcjF9PkhQNwb7cQUnO0
        UF+Vn9Q/28U8B6Wok1J7smKDuvBAw==
X-ME-Sender: <xms:o7uOXUIRzSGXQ4-bxbXOxmgf-lFoQsMTl02zWs1kfLiqPwH91n4uOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrfeejgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghenucfkphepuddukedrvddtledrudeikedrvdeinecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:o7uOXZauqNVDD6XTjfxb4N8iLNgenQ-idcgxwR_SqxQkun2I0nNgHA>
    <xmx:o7uOXWa5iGQaFaKChodmKtOJy4snRv-EwGTKfSNLLq6ATl9ub5ztiw>
    <xmx:o7uOXZmKGTe1Kiyzs-rWoW_TwR2QpYoL4JDJ1dZUIbg0TQVO2SK5DA>
    <xmx:o7uOXVWlWBIjF7w0_79EIPaL8tlQVL6qo_36Nq075zvIQsVNHdFcfg>
Received: from mickey.themaw.net (unknown [118.209.168.26])
        by mail.messagingengine.com (Postfix) with ESMTPA id 16F58D6005B;
        Fri, 27 Sep 2019 21:47:12 -0400 (EDT)
Message-ID: <f0849206eff7179c825061f4b96d56c106c4eb66.camel@themaw.net>
Subject: Re: [RFC] Don't propagate automount
From:   Ian Kent <raven@themaw.net>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     viro@zeniv.linux.org.uk, autofs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Sat, 28 Sep 2019 09:47:09 +0800
In-Reply-To: <20190927161643.ehahioerrlgehhud@fiona>
References: <20190926195234.bipqpw5sbk5ojcna@fiona>
         <3468a81a09d13602c67007759593ddf450f8132c.camel@themaw.net>
         <e5fbf32668aea1b8143d15ff47bd1e4309d03b17.camel@themaw.net>
         <d163042ab8fffd975a6d460488f1539c5f619eaa.camel@themaw.net>
         <7f31f0c2bf214334a8f7e855044c88a50e006f05.camel@themaw.net>
         <b2443a28939d6fe79ec9aa9d983f516c8269448a.camel@themaw.net>
         <20190927161643.ehahioerrlgehhud@fiona>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-09-27 at 11:16 -0500, Goldwyn Rodrigues wrote:
> On 18:51 27/09, Ian Kent wrote:
> > On Fri, 2019-09-27 at 15:41 +0800, Ian Kent wrote:
> > > > > I initially thought this was the result of a "fix" in the
> > > > > mount
> > > > > propagation code but it occurred to me that propagation is
> > > > > meant
> > > > > to occur between mount trees not within them so this might be
> > > > > a
> > > > > bug.
> > > > > 
> > > > > I probably should have worked out exactly what upstream
> > > > > kernel
> > > > > this started happening in and then done a bisect and tried to
> > > > > work out if the change was doing what it was supposed to.
> > > > > 
> > > > > Anyway, I'll need to do that now for us to discuss this
> > > > > sensibly.
> > > > > 
> > > > > > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > > > > 
> > > > > > > diff --git a/fs/pnode.c b/fs/pnode.c
> > > > > > > index 49f6d7ff2139..b960805d7954 100644
> > > > > > > --- a/fs/pnode.c
> > > > > > > +++ b/fs/pnode.c
> > > > > > > @@ -292,6 +292,9 @@ int propagate_mnt(struct mount
> > > > > > > *dest_mnt,
> > > > > > > struct
> > > > > > > mountpoint *dest_mp,
> > > > > > >  	struct mount *m, *n;
> > > > > > >  	int ret = 0;
> > > > > > >  
> > > > > > > +	if (source_mnt->mnt_mountpoint->d_flags &
> > > > > > > DCACHE_NEED_AUTOMOUNT)
> > > > > > > +		return 0;
> > > > > > > +
> > > > > > 
> > > > > > Possible problem with this is it will probably prevent
> > > > > > mount
> > > > > > propagation in both directions which will break stuff.
> 
> No, I am specifically checking when the source has a automount flag
> set.
> It will block only one way. I checked it with an example.

I don't understand how this check can selectively block propagation?

If you have say:
test    /       :/exports \
        /tmp    :/exports/tmp \
        /lib    :/exports/lib

and
/bind	/etc/auto.exports

in /etc/auto.master

and you use say:

docker run -it --rm -v /bind:/bind:slave fedora-autofs:v1 bash

your saying the above will not propagate those offset trigger mounts
to the parent above the /bind/test mount but will propagate them to
the container?

It looks like that check is all or nothing to me?
Can you explain a bit more.

> 
> > > > > > I had originally assumed the problem was mount propagation
> > > > > > back to the parent mount but now I'm not sure that this is
> > > > > > actually what is meant to happen.
> > 
> > Goldwyn,
> > 
> > TBH I'm already a bit over this particularly since it's a
> > solved problem from my POV.
> > 
> > I've gone back as far as Fedora 20 and 3.11.10-301.fc20 also
> > behaves like this.
> 
> The problem started with the root directory being mounted as
> shared.

The change where systemd set the root file system propagation
shared was certainly an autofs pain point (for more than just
this case too) but I was so sure that wasn't when this started
happening.

But ok, I could be mistaken, and you seem to be sure about.

> 
> > Unless someone says this behaviour is not the way kernel
> > mount propagation should behave I'm not going to spend
> > more time on it.
> > 
> > The ability to use either "slave" or "private" autofs pseudo
> > mount options in master map mount entries that are susceptible
> > to this mount propagation behaviour was included in autofs-5.1.5
> > and the patches used are present on kernel.org if you need to
> > back port them to an earlier release.
> 
> What about "shared" pseudo mount option? The point is the default
> shared option with automount is broken, and should not be exposed
> at all.

What about shared mounts?

I don't know of a case where propagation shared is actually needed.
If you know of one please describe it.

The most common case is "slave" and the "private" option was only
included because it might be needed if people are using isolated
environments but TBH I'm not at all sure it could actually be used
for that case.

IIUC the change to the propagation of the root file system was
done to help with containers but turned out not to do what was
needed and was never reverted. So the propagation shared change
probably should have been propagation slave or not changed at
all.

> 
> > https://mirrors.edge.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.5/autofs-5.1.4-set-bind-mount-as-propagation-slave.patch
> > 
> > https://mirrors.edge.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.5/autofs-5.1.4-add-master-map-pseudo-options-for-mount-propagation.patch
> > 
> > It shouldn't be too difficult to back port them but they might
> > have other patch dependencies. I will help with that if you
> > need it.
> 
> My problem is not with the patch and the "private" or "slave" flag,
> but
> with the absence of it. We have the patch you mention in our repos.

Ha, play on words, "absence of it" and "we have it in our repos"

Don't you mean the problem is that mount propagation isn't
set correctly automatically by automount.

> 
> I am assuming that users are stupid and they will miss putting the
> flags
> in the auto.master file and wonder why when they try to access the
> directories
> the process hangs. In all, any user configuration should not hang the
> kernel.

I thought about that when I was working on those patches but,
at the time, I didn't think the propagation problem had started
when the root file system was set propagation shared at boot.

I still think changing the kernel propagation isn't the right
way to resolve it.

But I would be willing to add a configuration option to autofs
that when set would use propagation slave for all bind mounts
without the need to modify the master map. Given how long the
problem has been around I'm also tempted to make it default
to enabled.

I'm not sure yet what that would mean for the existing mount
options "shared" and "private" other than them possibly being
needed if the option is disabled, even with this I'm still not
sure a "shared" option is useful.

Isn't this automation your main concern?

> 
> My point is, if you don't have a automount map with the daemon, how
> can you
> propagate it and still be in control?

Well, maybe, but IIUC the container example is probably one
case but that doesn't quite match what your saying.

Typically there would be no daemon in the container for the
example I gave.

Ian

