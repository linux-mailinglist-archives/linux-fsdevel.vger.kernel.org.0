Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11928172D90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 01:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgB1Ane (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 19:43:34 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57317 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730120AbgB1And (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:43:33 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2A8B15AE0;
        Thu, 27 Feb 2020 19:43:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 27 Feb 2020 19:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        WDBemPNCysVXmovtXdZ+Fmhvn30nAoiqvFdtKbQjVNU=; b=YK4tHmE6ayv7oVIJ
        PIKzxzvORN8fBQxtRJ1oevZttnXo50N7fwQRQFL3ZVn/VND4zaIpJ02ycg1nytE6
        qiCmAyoM+pxXKzYhhFfyMaAMpPg4ibHLWK/+VAhpf7in9Gp6MGc95uErdNwqwP3p
        uOWlDCMMsdsxRgTPyfUePPUSVa5uYGTG7alWp7JXXfenrXNmrH6G9lihciQU7/iv
        41pQjPI5aTHoRQUlxGHhPSrz9hKAt54E1VKcaY55bMFvz38ejKhETXw61UQgNgl0
        3G6l4C09hE6EY9BqYxqMhQA+r2pp4b7jROI9eMCWQ82kYU53qpb9VmFt4xVhmwNu
        DaTFHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=WDBemPNCysVXmovtXdZ+Fmhvn30nAoiqvFdtKbQjV
        NU=; b=TUQCUY3A02IMlJEITczf1DoElLTggjrGA5tP3XvyovFL7fyyjnnletPnu
        wE6jCGSF28AnFpuMaCCMkoYD58Hs2ItxicY1EEPnCUTAQMCBhKk/UPS28U4QtmKg
        emiScc6ba+IQ3tzwDaPSXyCdHWlwgoX6fWNNkvnnZA0YnUxw6ExB/n7xCL4S1Jwm
        hVyJjLbQisIS9dtEy5/t700+ELFYdw7vSIvHoUN2SioaKU/JqV6h4F971plU8AcZ
        XymozN7IYpDJyYocKtqGpqQY5loR/xZ0Fi2zA9F9nKspjysw8pAqglLG1ZrqIAYg
        FpPiDipujWJRroY7Ee18M+ASv4hgg==
X-ME-Sender: <xms:M2JYXqNFDuvBJMAe_DStK9UVzi9TiRVX_FBlazoBxMGnLXdZyndQeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleejgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    dukedvrdeludenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:M2JYXjrxjZaSk4WTajunwLrhF1mRY8-rJScrFmJahndKuQ1BcCM_nA>
    <xmx:M2JYXn6EYVt_6PJnjhtu2bMCOl6tv8cZ3ULM-XiisjfY-yvctgbYDw>
    <xmx:M2JYXlo534q2lXX69GCRUhjaO2U1j-LAsmFs0S6a55-rYFWTIUmouQ>
    <xmx:NGJYXp2beQemkZQgYlxxK0iAGrf1SCPK_0x0LSQGEEXZZykcI2pSjQ>
Received: from mickey.themaw.net (unknown [118.209.182.91])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6DD53060FDD;
        Thu, 27 Feb 2020 19:43:25 -0500 (EST)
Message-ID: <ba2b44cc1382c62be3ac896a5476c8e1dc7c0230.camel@themaw.net>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   Ian Kent <raven@themaw.net>
To:     Karel Zak <kzak@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        util-linux@vger.kernel.org
Date:   Fri, 28 Feb 2020 08:43:21 +0800
In-Reply-To: <20200227151421.3u74ijhqt6ekbiss@ws.net.home>
References: <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
         <1582556135.3384.4.camel@HansenPartnership.com>
         <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
         <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
         <1582644535.3361.8.camel@HansenPartnership.com>
         <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
         <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
         <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
         <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net>
         <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com>
         <20200227151421.3u74ijhqt6ekbiss@ws.net.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-02-27 at 16:14 +0100, Karel Zak wrote:
> On Thu, Feb 27, 2020 at 02:45:27PM +0100, Miklos Szeredi wrote:
> > > So the problem I want to see fixed is the effect of very large
> > > mount tables on other user space applications, particularly the
> > > effect when a large number of mounts or umounts are performed.
> 
> Yes, now you have to generate (in kernel) and parse (in
> userspace) all mount table to get information about just 
> one mount table entry. This is typical for umount or systemd.
> 
> > > >  - add a notification mechanism   - lookup a mount based on
> > > > path
> > > >  - and a way to selectively query mount/superblock information
> > > based on path ...
> 
> For umount-like use-cases we need mountpoint/ to mount entry
> conversion; I guess something like open(mountpoint/) + fsinfo() 
> should be good enough.
> 
> For systemd we need the same, but triggered by notification. The
> ideal
> solution is to get mount entry ID or FD from notification and later
> use this
> ID or FD to ask for details about the mount entry (probably again
> fsinfo()).
> The notification has to be usable with in epoll() set.
> 
> This solves 99% of our performance issues I guess.
> 
> > > So that means mount table info. needs to be maintained, whether
> > > that
> > > can be achieved using sysfs I don't know. Creating and
> > > maintaining
> > > the sysfs tree would be a big challenge I think.
> 
> It will be still necessary to get complete mount table sometimes,
> but 
> not in performance sensitive scenarios.

That was my understanding too.

Mount table enumeration is possible with fsinfo() but you still
have to handle each and every mount so improvement there is not
going to be as much as cases where the proc mount table needs to
be scanned independently for an individual mount. It will be
somewhat more straight forward without the need to dissect text
records though.

> 
> I'm not sure about sysfs/, you need somehow resolve namespaces, order
> of the mount entries (which one is the last one), etc. IMHO translate
> mountpoint path to sysfs/ path will be complicated.

I wonder about that too, after all sysfs contains a tree of nodes
from which the view is created unlike proc which translates kernel
information directly based on what the process should see.

We'll need to wait a bit and see what Miklos has in mind for mount
table enumeration and nothing has been said about name spaces yet.

While fsinfo() is not similar to proc it does handle name spaces
in a sensible way via. file handles, a bit similar to the proc fs,
and ordering is catered for in the fsinfo() enumeration in a natural
way. Not sure how that would be handled using sysfs ...

Ian

