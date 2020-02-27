Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9ADC170FF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 06:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgB0FGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 00:06:50 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59977 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgB0FGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:06:50 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 27D5C737F;
        Thu, 27 Feb 2020 00:06:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Feb 2020 00:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        7VMetkVh205MzER1jhY7QfzeT/S8gk9URVRPcaR9UKY=; b=W2OsanbM4Y8N7In5
        ulcg2cGkc762HChDxbpL7sdlY3FHEr5UtUaky3Id8B4Ez8PVwLkaF8cfEpICIdBy
        Xt7n/6Dqk5eI0e9+rMeUws2jM5RFovMCugq/+PvYK5jEXpfQan0q58LWdchZ2bfR
        WzeY10G1WL4d7N8leKIlgQqyysYWhjhW/BMmasr3oPfa1GOSd5ABB7A3H75gtt/x
        bXclqh60MTUvIcM/qtScr0uW+euP6nWv4EyQkbvJLNdwZPabxC9Z/wBRlTlTwBmH
        bfEeQEx3KWLaawlf5FdpkiqtUASSGU5lRdXJ5ZUK8KNvHa6k+A/chvB/Olwq2lLZ
        Bd1cUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=7VMetkVh205MzER1jhY7QfzeT/S8gk9URVRPcaR9U
        KY=; b=s2D+WB69gZXt5NsTV7nJlj/+NG6CxkQ5cJWonajElYzKmdNc2fxAODUR5
        vLjjyzrHRBo1uSgVb7VPVOPbQ4BJkBglTx+kkoUUfPvcKcF7bY+UghGP/dlZWL44
        WJULFq6b2tHrB2rXxOi08xPrUyu2VxELzKsrZ93L8UfXLlmNFHOpIfiXNDoR7uQW
        W9BWiBePb2kB6zeA1mtU+YZHeLXHnrCaQo3dIMoH0TgZCKDn7VIv3zP8QqxXQdtA
        fvdC7SGbyGvO3E9j1HucB7UXo/KbPiLMU4Adiswzw7DTEln6Q8Mzvu8Ey54uHEDS
        vPQXTN7R6HV1lKXYR7oTMRYpWHV/Q==
X-ME-Sender: <xms:Zk5XXu8UUkZ2foIoXf2SguUEfEfUsPzeSYQW-32vD9v-SHSFfot_2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleehgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdekrd
    dukeehrddugeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:Zk5XXjq2kzjheij30NPfrlzINAHm9we_2SZugqbGzz8-L-1hyruffg>
    <xmx:Zk5XXsLFGLC4IIMpEQT_lEIId5f-TSAaWcnoEPFyYNNEchYsX4B0aQ>
    <xmx:Zk5XXm71yRDmPqsFHdKQOnobRhiSGeyg8pgFiBiVRJ3G8aXsVPV25Q>
    <xmx:Z05XXsRQd3afcvSV6Fqqrd1CstsqPgyXFpAuNFt_ETou83LLB_gPXw>
Received: from mickey.themaw.net (unknown [118.208.185.148])
        by mail.messagingengine.com (Postfix) with ESMTPA id CE3CA3280059;
        Thu, 27 Feb 2020 00:06:41 -0500 (EST)
Message-ID: <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Feb 2020 13:06:37 +0800
In-Reply-To: <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
         <1582316494.3376.45.camel@HansenPartnership.com>
         <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
         <1582556135.3384.4.camel@HansenPartnership.com>
         <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
         <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
         <1582644535.3361.8.camel@HansenPartnership.com>
         <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-02-26 at 10:11 +0100, Miklos Szeredi wrote:
> On Tue, Feb 25, 2020 at 4:29 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> 
> > The other thing a file descriptor does that sysfs doesn't is that
> > it
> > solves the information leak: if I'm in a mount namespace that has
> > no
> > access to certain mounts, I can't fspick them and thus I can't see
> > the
> > information.  By default, with sysfs I can.
> 
> That's true, but procfs/sysfs has to deal with various namespacing
> issues anyway.  If this is just about hiding a number of entries,
> then
> I don't think that's going to be a big deal.

I didn't see name space considerations in sysfs when I was looking at
it recently. Obeying name space requirements is likely a lot of work
in sysfs.

> 
> The syscall API is efficient: single syscall per query instead of
> several, no parsing necessary.
> 
> However, it is difficult to extend, because the ABI must be updated,
> possibly libc and util-linux also, so that scripts can also consume
> the new parameter.  With the sysfs approach only the kernel needs to
> be updated, and possibly only the filesystem code, not even the VFS.
> 
> So I think the question comes down to:  do we need a highly efficient
> way to query the superblock parameters all at once, or not?

Or a similar question could be, how could a sysfs interface work
to provide mount information.

Getting information about all mounts might not be too bad but the
sysfs directory structure that would be needed to represent all
system mounts (without considering name spaces) would likely
result in somewhat busy user space code.

For example, given a path, and the path is all I know, how do I
get mount information?

Ignoring possible multiple mounts on a mount point, call fsinfo()
with the path and get the id (the path walk is low overhead) to
use with fsinfo() to get the all the info I need ... done.

Again, ignoring possible multiple mounts on a mount point, and
assuming there is a sysfs tree enumerating all the system mounts.
I could open <sysfs base> + mount point path followed buy opening
and reading the individual attribute files ... a bit more busy
that one ... particularly if I need to do it for several thousand
mounts.

Then there's the code that would need to be added to maintain the
various views in the sysfs tree, which can't be restricted only to
the VFS because there's file system specific info needed too (the
maintain a table idea), and that's before considering name space
handling changes to sysfs.

At the least the question of "do we need a highly efficient way
to query the superblock parameters all at once" needs to be
extended to include mount table enumeration as well as getting
the info.

But this is just me thinking about mount table handling and the
quite significant problem we now have with user space scanning
the proc mount tables to get this information.

Ian

