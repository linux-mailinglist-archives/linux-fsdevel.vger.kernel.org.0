Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE116565C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 05:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBTEmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 23:42:25 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:41471 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727469AbgBTEmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 23:42:25 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D6A73608;
        Wed, 19 Feb 2020 23:42:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 19 Feb 2020 23:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        gQLg/u8G+UeVHb4xnmxvzs+U+CqS0x1Y3C2s8LsROHc=; b=fXHLIE2xqEA3A3Aa
        g1483W+2PGufTEyqxEk/5ccDLQJH4544UhukQX9+afLFMR3Xoh9IiuaNCDwBh9od
        avq9F+BVcovv9yR5pWpEQeBdg7t0s3Zab8SU3h0qoxmDjXDqxf5uRIYJExDzYfw5
        XBSoUZBZDK5HeWXLkrejATZHXobna36M0m0/SpJH137sfASwhD1c3ZuuWyicGJGV
        VO3DJN9Eq5qWMuUwKA8AoojRqbn3/aYRjTmS6PMV5KaIhd0NguxAtoQJ8an6+n0P
        Z04Gwtjp5bSVPd7uzp+aDrPZSS2vpJsm2/J7pbqDULx8VMeD5cg/e9XKzzYgUwFZ
        E5DZJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=gQLg/u8G+UeVHb4xnmxvzs+U+CqS0x1Y3C2s8LsRO
        Hc=; b=IF7UlWxQKaGDh9JIgM2V9a9PWiYklF/X0uDH31JgpFojyd1nqLzln4VVo
        V1SOJ5FCrSODw0heXdHK1LIy6elEaadyH+Ex10PciJInMu5EkqTyqnuYRP+Su9NE
        maXuOvKYwauT8qEYAH7gNgyRPOqyebkz1wQDcL3K26HgCS6HDJjVuK1jPkbgsG/6
        oMlGQAeKqpEzrwyOl4CPi2YVgwqqOK70SsJ6ZvcT6G22Z6ekN6KF/c4RtAL4OqyS
        rVYIl7/DIg6OLvG15jKJOmaBVjocI+g3ZduMAGspW6CsLpTDy6vllbhZ8CpJOsBG
        cCRmLxYINJ4mFTjff/xtH0pE4vFvg==
X-ME-Sender: <xms:Lw5OXsM9kDX4xgW5s00E0n71w8XwKYH93bPxSozMwdtcUpnSurX6iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedugdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdekrd
    duieefrdefvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:Lw5OXki7WaKdB6a6MDoNeNx_br_EZ3fU9O0WBRKllT4bwUDXPa5_kw>
    <xmx:Lw5OXigEYhudCQbWOcLuYm4FMyMXCu3zkvObmjES4lHhVYh--gfPzA>
    <xmx:Lw5OXrKGVmjXQ2Tp5ceV7i33wKBW53VePd6RaIgmdkIQ1v7SBGnblQ>
    <xmx:Lw5OXlBt-kCZlcKWsoVt2GKPtZ18WSvcAmd9ypYEDJAlEPfRclGtRA>
Received: from mickey.themaw.net (unknown [118.208.163.32])
        by mail.messagingengine.com (Postfix) with ESMTPA id DFD023060BD1;
        Wed, 19 Feb 2020 23:42:19 -0500 (EST)
Message-ID: <c9a6f929b57e0c21c8845c211d1e3eab09d09633.camel@themaw.net>
Subject: Re: [PATCH 00/19] VFS: Filesystem information and notifications
 [ver #16]
From:   Ian Kent <raven@themaw.net>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, mszeredi@redhat.com, christian@brauner.io,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Feb 2020 12:42:15 +0800
In-Reply-To: <20200219144613.lc5y2jgzipynas5l@wittgenstein>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
         <20200219144613.lc5y2jgzipynas5l@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-02-19 at 15:46 +0100, Christian Brauner wrote:
> On Tue, Feb 18, 2020 at 05:04:55PM +0000, David Howells wrote:
> > Here are a set of patches that adds system calls, that (a) allow
> > information about the VFS, mount topology, superblock and files to
> > be
> > retrieved and (b) allow for notifications of mount topology
> > rearrangement
> > events, mount and superblock attribute changes and other superblock
> > events,
> > such as errors.
> > 
> > ============================
> > FILESYSTEM INFORMATION QUERY
> > ============================
> > 
> > The first system call, fsinfo(), allows information about the
> > filesystem at
> > a particular path point to be queried as a set of attributes, some
> > of which
> > may have more than one value.
> > 
> > Attribute values are of four basic types:
> > 
> >  (1) Version dependent-length structure (size defined by type).
> > 
> >  (2) Variable-length string (up to 4096, including NUL).
> > 
> >  (3) List of structures (up to INT_MAX size).
> > 
> >  (4) Opaque blob (up to INT_MAX size).
> 
> I mainly have an organizational question. :) This is a huge patchset
> with lots and lots of (good) features. Wouldn't it make sense to make
> the fsinfo() syscall a completely separate patchset from the
> watch_mount() and watch_sb() syscalls? It seems that they don't need
> to
> depend on each other at all. This would make reviewing this so much
> nicer and likely would mean that fsinfo() could proceed a little
> faster.

The remainder of the fsinfo() series would need to remain useful
if this was done.

For context I want work on improving handling of large mount
tables.

Ultimately I expect to solve a very long standing autofs problem
of using large direct mount maps without prohibitive performance
overhead (and there a lot of rather challenging autofs changes to
do for this too) and I believe the fsinfo() system call, and
related bits, is the way to do this.

But improving the handling of large mount tables for autofs
will have the side effect of improvements for other mount table
users, even in the early stages of this work.

For example I want to use this for mount table handling improvements
in libmount. Clearly that ultimately needs mount change notification
in the end but ...

There's a bunch of things that need to be done alone the way
to even get started.

One thing that's needed is the ability to call fsinfo() to get
information on a mount to avoid constant reading of the proc based
mount table, which happens a lot (since the mount info. needs
to be up to date) so systemd (and others) would see an improvement
with the fsinfo() system call alone able to be used in libmount.

But for the fsinfo() system call to be used for this the file
system specific mount options need to also be obtained when
using fsinfo(). That means the super block operation fsinfo uses
to provide this must be implemented for at least most file systems.

So separating out the notifications part, leaving whatever is needed
to still be able to do this, should be fine and the system call
would be immediately useful once the super operation is implemented
for the needed file systems.

Whether the implementation of the super operation should be done
as part of this series is another question but would certainly
be a challenge and make the series more complicated. But is needed
for the change to be useful in my case.

Ian

