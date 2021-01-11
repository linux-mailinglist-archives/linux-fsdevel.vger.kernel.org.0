Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9592F0B6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 04:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbhAKDUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 22:20:45 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:56071 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbhAKDUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 22:20:44 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8A73A226A;
        Sun, 10 Jan 2021 22:19:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 10 Jan 2021 22:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        5fBxdt4X52vNUbQIYEG2UHMsdTlD/2Xi5Lao/NWleKY=; b=tc3UQQrGFc1Zj430
        Rk9uP7BAQDl2VDUukYbcGq1oPGxzzlJWIq7aUPCHKZcDvux4NzUAe3vF7QNnhXBz
        RXfyAFwBp5zLqVCV4nCJtJK+bpqY3LKvkTCNwo70UgmdzOmci0THJfO+4bDM0OZP
        L6lDKB33EKsNP6PPL2QM0jbIQTvMFXgJbILTw1pPZFe0xe3dR0BsSGjONR+/fDWQ
        iOUEFUSX9qe1sHO9QKGmNpICJPgv0zpJMefSE45h0FLMWMVuOAR6Oju8Beb0F3GA
        J07Pb7fv4lLaVnHTW+4lVJbfwmi/2tiDAT5J2swQq/PcVuqDtgwZl+gkVNC7ir7m
        24Vr6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=5fBxdt4X52vNUbQIYEG2UHMsdTlD/2Xi5Lao/NWle
        KY=; b=Eety+OrTSfoVKnZwDXWRsc9LTA9awt+qUqwBUmsNOTV5LpGXRTLVfWA97
        3Dey8tJw5LDCuV395wa2v8kOf7oNCqSVcoBYi7ZGsYQBAbuugQb/qwRkXxEAtUc0
        rbqFoB0A67c/OrsE8bR3pkuv5sfObqhCUcqn+fconhGekI7bFz8GrtiaUWA/Nesr
        AU+gk8WhXv6e9YPHWk7YVmEQ1k6WecmfqyeeGccWZsqHsv4qPw6KhZZeX3tHL/sV
        mmWDPnhYptZwPZkzQ0OQIVJqqMuW2V0zd8sDPujN2TTbIZGkWr5JBcwM7RArbF+H
        zJvsfsUvSgaNRufSpQ0uB01zQh9Cg==
X-ME-Sender: <xms:yMP7X6Nt09QmTcm_U3C0U72usX3_t_T0byNlKpC5l6CVhUXdYqRvcg>
    <xme:yMP7X488wEbwObbdEHn0e8rw89TCOnenx4438P5Cy2bUf-JaTREADoLDnlQwYlQrp
    llDDX-0MU3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eikeeggeeuvdevgfefiefhudekkeegheeileejveethedutedvveehudffjeevudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvddurdeggedrudefuddrvdefne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgv
    nhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:yMP7XxSbdqMCFW2gMSybb7OzYSYfE3KL-yi7JwpbneFmnD5GsRkvUw>
    <xmx:yMP7X6trJ7yY0TGYbEqUIKccWX1Z_RAe1t_4ruc6WIfXoPwgb7wW-g>
    <xmx:yMP7Xyc-bE_CixUUqEk53sGv7MBeofv5STflZ4vvbtKmpukZ1zdQMw>
    <xmx:ysP7Xx5eFsxQoQor0MSeIm960D_uRXzenoyq9q-xxHVA35-cCHpy4A>
Received: from mickey.themaw.net (unknown [121.44.131.23])
        by mail.messagingengine.com (Postfix) with ESMTPA id EAE21240057;
        Sun, 10 Jan 2021 22:19:33 -0500 (EST)
Message-ID: <75de66869bd584903055996fb0e0bab2b57acd68.camel@themaw.net>
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
Date:   Mon, 11 Jan 2021 11:19:30 +0800
In-Reply-To: <CAC2o3D+qsH3suFk4ZX9jbSOy3WbMHdb9j6dWUhWuvt1RdLOODA@mail.gmail.com>
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
         <CAC2o3DJqK0ECrRnO0oArgHV=_S7o35UzfP4DSSXZLJmtLbvrKg@mail.gmail.com>
         <04675888088a088146e3ca00ca53099c95fbbad7.camel@themaw.net>
         <CAC2o3D+qsH3suFk4ZX9jbSOy3WbMHdb9j6dWUhWuvt1RdLOODA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-01-06 at 10:38 +0800, Fox Chen wrote:
> Hi Ian,
> 
> I am rethinking this problem. Can we simply use a global lock?
> 
>  In your original patch 5, you have a global mutex attr_mutex to
> protect attr, if we change it to a rwsem, is it enough to protect
> both
> inode and attr while having the concurrent read ability?
> 
> like this patch I submitted. ( clearly, I missed __kernfs_iattrs
> part,
> but just about that idea )
> https://lore.kernel.org/lkml/20201207084333.179132-1-foxhlchen@gmail.com/

I don't think so.

kernfs_refresh_inode() writes to the inode so taking a read lock
will allow multiple processes to concurrently update it which is
what we need to avoid.

It's possibly even more interesting.

For example, kernfs_iop_rmdir() and kernfs_iop_mkdir() might alter
the inode link count (I don't know if that would be the sort of thing
they would do but kernfs can't possibly know either). Both of these
functions rely on the VFS locking for exclusion but the inode link
count is updated in kernfs_refresh_inode() too.

That's the case now, without any patches.

I'm not entirely sure what's going on in kernfs_refresh_inode().

It could be as simple as being called with a NULL inode because
the dentry concerned is negative at that point. I haven't had
time to look closely at it TBH but I have been thinking about it.

Ian

> 
> 
> 
> thanks,
> fox

