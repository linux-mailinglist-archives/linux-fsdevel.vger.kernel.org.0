Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7E123D298
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 22:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgHEUO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 16:14:27 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:33995 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726630AbgHEQX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:23:26 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id C2975896;
        Wed,  5 Aug 2020 07:14:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Aug 2020 07:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        FVkQ6ze2JnvmGPoYApJAFrAYvt8zexmv/OJPsQaZMgU=; b=SN6O21jHLK0jauIv
        DHnrckspKjX+uHVpnvEe4ydIfNyWICmVz5vDuIWkrhD6BDOFY0TkwrbAZRk6w+1n
        b0JOgpMtOaA0CdCItQ1I7EP2XGvtxxkIXzXKr6pJzrkg1imkIHrw6qdEr5usv770
        TF94RSGVQzI1I1xhTD81JGRpO0o1CXFMC1fOaDHeMuFz6zLfH1gh/4sZb45Sypzp
        nxt9P31drzNGLf82/3m7ou6Qi0MeUCQz4nUovrm1phU4nAmFwgWNorQqxTKuOZrE
        cX+zbtVKnadGSqYxJYPKNSm6hVeiZBjSiqrm31nXRfRBqHJf92PTpJZ8ojGEvp9T
        cY6Lug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=FVkQ6ze2JnvmGPoYApJAFrAYvt8zexmv/OJPsQaZM
        gU=; b=l6X0RVD4SEfucgzG7MU9P4LWBYpQeenQulu7vIeLEodV4OgRrxT8p5V7d
        SX+i0vqXNgN/pYIF94Vw+/Nny8YMre3j+pMQ0VIcIXobZM3QRawB+4Y0nJOE5oXI
        KOCq53RP+0gfhifZeaDjotj0XF5st0cm5xdyFeS60gNJPGMOnLD7GqsRKoa2CmkV
        LF080vlM7qNt+pzSo5yWegq5WhzlQgbJz4+Fzzsa9Pynj0hFWWtUKcqfDDfdHDXT
        b0MMmHgxM4tETeVo4tYY1IwgGGa9BKZ5NePS1ZUEMhjXNUbxFc2hRtG6/XEyaZ4v
        IPiwEYwE9Clglld0sB+of3asGsH0g==
X-ME-Sender: <xms:fJQqX3YA6t9GhKywLlioHdvjAPLUKQoeO-w2HpxmGXhTOWuEfFbO_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeekgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvdehhedrvddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:fJQqX2ZSypsPRmH_WPh6Sn6WnkeTZD5BzdfzmwHtuNQSc1OfyePtoQ>
    <xmx:fJQqX58RlXwDK3acV11t81Cv0jisurrfQMtArHXlzDZZB43U0xvcAg>
    <xmx:fJQqX9rGxF5_oGzFN9o9XGL1hKRia1bhRkTp65swupz3FRzBIFvAsQ>
    <xmx:fZQqXx1SYZGX-rvfKFPpEzq0vN_0iaQlPqCCpIxnDdLEADGFuTzMz10KcRw>
Received: from mickey.themaw.net (58-7-255-220.dyn.iinet.net.au [58.7.255.220])
        by mail.messagingengine.com (Postfix) with ESMTPA id D79573280060;
        Wed,  5 Aug 2020 07:13:59 -0400 (EDT)
Message-ID: <c44b1c225b0aec20969aace1ba1b7900ddda5a5e.camel@themaw.net>
Subject: Re: [GIT PULL] Filesystem Information
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 05 Aug 2020 19:13:55 +0800
In-Reply-To: <CAJfpegvQdCr+u51_xkpbS7eMZyNqtnk_tdK1KVhsiCuiFWWJJw@mail.gmail.com>
References: <1842689.1596468469@warthog.procyon.org.uk>
         <1845353.1596469795@warthog.procyon.org.uk>
         <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
         <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
         <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
         <dd1a41a129cd6e8d13525a14807e6dc65b52e0bf.camel@themaw.net>
         <CAJfpegvQdCr+u51_xkpbS7eMZyNqtnk_tdK1KVhsiCuiFWWJJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-08-05 at 10:00 +0200, Miklos Szeredi wrote:
> On Wed, Aug 5, 2020 at 3:33 AM Ian Kent <raven@themaw.net> wrote:
> > On Tue, 2020-08-04 at 16:36 +0200, Miklos Szeredi wrote:
> > > And notice how similar the above interface is to getxattr(), or
> > > the
> > > proposed readfile().  Where has the "everything is  a file"
> > > philosophy
> > > gone?
> > 
> > Maybe, but that philosophy (in a roundabout way) is what's resulted
> > in some of the problems we now have. Granted it's blind application
> > of that philosophy rather than the philosophy itself but that is
> > what happens.
> 
> Agree.   What people don't seem to realize, even though there are
> blindingly obvious examples, that binary interfaces like the proposed
> fsinfo(2) syscall can also result in a multitude of problems at the
> same time as solving some others.
> 
> There's no magic solution in API design,  it's not balck and white.
> We just need to strive for a good enough solution.  The problem seems
> to be that trying to discuss the merits of other approaches seems to
> hit a brick wall.  We just see repeated pull requests from David,
> without any real discussion of the proposed alternatives.
> 
> > I get that your comments are driven by the way that philosophy
> > should
> > be applied which is more of a "if it works best doing it that way
> > then
> > do it that way, and that's usually a file".
> > 
> > In this case there is a logical division of various types of file
> > system information and the underlying suggestion is maybe it's time
> > to move away from the "everything is a file" hard and fast rule,
> > and get rid of some of the problems that have resulted from it.
> > 
> > The notifications is an example, yes, the delivery mechanism is
> > a "file" but the design of the queueing mechanism makes a lot of
> > sense for the throughput that's going to be needed as time marches
> > on. Then there's different sub-systems each with unique information
> > that needs to be deliverable some other way because delivering
> > "all"
> > the information via the notification would be just plain wrong so
> > a multi-faceted information delivery mechanism makes the most
> > sense to allow specific targeted retrieval of individual items of
> > information.
> > 
> > But that also supposes your at least open to the idea that "maybe
> > not everything should be a file".
> 
> Sure.  I've learned pragmatism, although idealist at heart.  And I'm
> not saying all API's from David are shit.  statx(2) is doing fine.
> It's a simple binary interface that does its job well.   Compare the
> header files for statx and fsinfo, though, and maybe you'll see what
> I'm getting at...

Yeah, but I'm biased so not much joy there ... ;)

Ian

