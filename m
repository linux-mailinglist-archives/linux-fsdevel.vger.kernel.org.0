Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6202E8F10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 01:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbhADAnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 19:43:52 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46215 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbhADAnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 19:43:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 077EA5C00CC;
        Sun,  3 Jan 2021 19:42:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 03 Jan 2021 19:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        eS8T0yKQFpRtxfbu+8s/zU/IQ7/8fcCJ/NcnUWLXlpQ=; b=X1XsmzqcGz+wuAZz
        TstkxUjNmwc0Ct8kYK4Do8huIEveRWJaM85dUnpRoaN0ImAMriEDo+M+XRaPQvw9
        LlAhDuXXCMx5WVXHQYKZWdKXseUTiPc4uHu+DBAbNIdQRp2wAB0XiQqkIoqGOO7p
        0ImV2jnTGI7BlzCv/jMe0jPWLiwx7SnCEH4vcM9BXerfMvP4woI+Wu3tn8ZSxjXH
        xB3aKJ+xGo05NAoSv66Wc5f8ZGJegBhFHDSikF0Njbg2FES2jZkUBTdzOPB6R32Z
        evEtrsKtDWvjrNl02zPIdGxGbNm4dP8AdnwpMtEoWwbebmlp9e9OLum7nInoXvvX
        qu99uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=eS8T0yKQFpRtxfbu+8s/zU/IQ7/8fcCJ/NcnUWLXl
        pQ=; b=PXNJZa1eVBgBIqCe+UE6aK+QYyAZiyAnwHzK/sSaJqSZCsqnrOfasY5Cv
        lA/g3OaG3gUoG+JHNTQW4cWPIyE1XLa/oW/2QOBekaQi9rSORQKOOiSQzNsGeaJj
        YW21amf0Ekl27Pb8yNYBqxyM8Mc0cj36e4hKwXpBwI7PHkJBHgFyng3DvOFzC7l5
        FiVebTql4ILWFYR6xPYU8GuMQXjAHGJYcBb/Zs1eP5qjsDhc6eZ6Roipej2aRCo5
        CHuLCUGUXmYWiZSWC0QmyKxL3w1YZLlbTVPQfMknhA7+q50odcpGtMdLxk335Yr0
        wMmsSF9pVHELPysyZQHVsXZ+HNp3g==
X-ME-Sender: <xms:hWTyX2Mb_KKy8xTkPpoqXeREtMRGRuQQqCHbjfNWfsRDqgyF8Ns0Ag>
    <xme:hWTyX0-3LEdtN5JGTV3rLDhg5sUcJBv1QS4kbJltbSXabmkDpONw33PAmoI2xqwWK
    oKJf3_vTQVF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefvddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddtiedrieelrddvgeejrddvtdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:hWTyX9Re7_BVoUEqd_JLe4IIlyGschgnmPn-PfJEguw99-0wrozOug>
    <xmx:hWTyX2tEcS1pD5NeYc2RM_kBlih93qx_DPshrfvfx91sNL47xOVRbw>
    <xmx:hWTyX-cHmjXyz9wxhFPouFW_MNnFpAcKVWimB_zHlh29ln_I3cXPSw>
    <xmx:hmTyX97VP5EYR484wD-STRDeI6-S0D-NO8__NRxH5KFFmJj3QhCyiw>
Received: from mickey.themaw.net (106-69-247-205.dyn.iinet.net.au [106.69.247.205])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2EBE5108005C;
        Sun,  3 Jan 2021 19:42:41 -0500 (EST)
Message-ID: <04675888088a088146e3ca00ca53099c95fbbad7.camel@themaw.net>
Subject: Re: [PATCH 0/6] kernfs: proposed locking and concurrency improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 04 Jan 2021 08:42:37 +0800
In-Reply-To: <CAC2o3DJqK0ECrRnO0oArgHV=_S7o35UzfP4DSSXZLJmtLbvrKg@mail.gmail.com>
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
         <CAC2o3DJqK0ECrRnO0oArgHV=_S7o35UzfP4DSSXZLJmtLbvrKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-12-23 at 15:30 +0800, Fox Chen wrote:
> Hi Ian,
> 
> On Tue, Dec 22, 2020 at 3:47 PM Ian Kent <raven@themaw.net> wrote:
> > Here is what I currently have for the patch series we were
> > discussing
> > recently.
> > 
> > I'm interested to see how this goes with the problem you are
> > seeing.
> > 
> > The last patch in the series (the attributes update patch) has seen
> > no more than compile testing, I hope I haven't messed up on that.
> 
> OK, I just ignored the last patch (kernfs: add a spinlock to kernfs
> iattrs for inode updates)
> because I can not boot the kernel after applying it.

Right, clearly I haven't got that last patch right yet.

It looks like the problem there is that the iattrs structure might
not be allocated at the time so clearly I can't just use the spin
lock inside.

It would be simple enough to resolve except for the need to set
the inode link count too.

Ian

> 
> Applying the first five patches, my benchmark shows no improvement
> this time,
> one open+read+close cycle spends 500us. :(
> 
> perf suggests that down_write in kernfs_iop_permission drags the most
> performance
> (full report see attachment) which makes sense to me, since
> down_write
> has no difference
> here compared to the mutex, they all allow only one thread running
> simultaneously.
> 
> sigh... It's really hard to fix.
> 
>    |
>    |--51.81%--inode_permission
>    |          |
>    |           --51.36%--kernfs_iop_permission
>    |                     |
>    |                     |--50.41%--down_write
>    |                     |          |
>    |                     |           --50.32%
> --rwsem_down_write_slowpath
>    |                     |                     |
>    |                     |                      --49.67%
> --rwsem_optimistic_spin
>    |                     |                                |
>    |                     |                                 --49.31%
> --osq_lock
>    |                     |
>    |                      --0.74%--up_write
>    |                                rwsem_wake.isra.0
>    |                                |
>    |                                 --0.69%--wake_up_q
>    |                                           |
>    |                                            --0.62%
> --try_to_wake_up
>    |                                                      |
>    |
> --0.54%--_raw_spin_lock_irqsave
>    |                                                                 
> |
>    |
> --0.52%--native_queued
>    |
>     --29.90%--walk_component
>               |
>                --29.72%--lookup_fast
>                          |
>                           --29.51%--kernfs_dop_revalidate
>                                     |
>                                     |--28.88%--down_read
>                                     |          |
>                                     |
> --28.75%--rwsem_down_read_slowpath
>                                     |                     |
>                                     |
> --28.50%--rwsem_optimistic_spin
>                                     |                                
> |
>                                     |
> --28.38%--osq_lock
>                                     |
>                                      --0.59%--up_read
>                                                rwsem_wake.isra.0
>                                                |
>                                                 --0.54%--wake_up_q
>                                                           |
> 
> --0.53%--try_to_wake_up
> 
> > Please keep in mind that Greg's continued silence on the question
> > of whether the series might be re-considered indicates to me that
> > he has not changed his position on this.
> 
> Since the problem doesn't break the system, it doesn't need immediate
> attention.
> So I bet it must be labeled with a low priority in Greg's to-do list.
> And it's merging
> window & holiday season. Let's just give him more time. :)
> 
> 
> > ---
> > 
> > Ian Kent (6):
> >       kernfs: move revalidate to be near lookup
> >       kernfs: use VFS negative dentry caching
> >       kernfs: use revision to identify directory node changes
> >       kernfs: switch kernfs to use an rwsem
> >       kernfs: stay in rcu-walk mode if possible
> >       kernfs: add a spinlock to kernfs iattrs for inode updates
> > 
> > 
> >  fs/kernfs/dir.c             |  285 ++++++++++++++++++++++++++++---
> > ------------
> >  fs/kernfs/file.c            |    4 -
> >  fs/kernfs/inode.c           |   19 ++-
> >  fs/kernfs/kernfs-internal.h |   30 ++++-
> >  fs/kernfs/mount.c           |   12 +-
> >  fs/kernfs/symlink.c         |    4 -
> >  include/linux/kernfs.h      |    5 +
> >  7 files changed, 238 insertions(+), 121 deletions(-)
> > 
> > --
> > Ian
> > 
> 
> thanks,
> fox

