Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731071D6E5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 02:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgERAxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 20:53:40 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54457 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbgERAxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 20:53:39 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id BBC075C003D;
        Sun, 17 May 2020 20:53:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 17 May 2020 20:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        x8+wYDtaURVodIiWZG1wMgfzVKUJnR2YLZKOn2qHRVo=; b=l7b/UVbrCIzRfBLH
        jU6YTC5Oy99qgxihuT3ZgDgc1V3pg7m1YCLDOpmlMbihk9LpG0Ib+Oamrt/75eGR
        KrcCjmNUe4EFl+q3+a76DFLM7LZkCfCaJnhDoLukDkSzR2LCmDpBmAYgWZEZmPfA
        JJ80AaqJr0U9Z5fma8py+bMFcwr5k/7i3epPJ4dZCB5hL3SdnN9n0cPwTVCQEsdv
        nQTaFU29iF6Xk4kdhMZMELuiMV5s+M26ebPO51jp/fhdKb+0uuYINbZbgSnxR5j6
        Wxp6Z2vdfUeEOY71iZExdjU0qfljD0vlRhFDXcyFavdYn4vCaRLDoPYAjMyFlkxE
        vER5Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=x8+wYDtaURVodIiWZG1wMgfzVKUJnR2YLZKOn2qHR
        Vo=; b=CNyz+ORvE+N2eDrGyfebvU/zZkX4n2iBAnyWjwsJ2KDKWtOv/ftO0eYNr
        4OfKbz2ZV+iNCLQmG9N7hJ78Mvw/hQUgnoxwH0gwQX3kk8q0uCX5h6yQwvP85qiv
        7RUsYpsgHb/I4hf4DORToEjvF31NyCrl3AKB8RLdwbygPN0RVUO2G5ApFa92I7WB
        d4/k1h06Z19J6pnBYTX0PRetdk0w21eS+iV0SDoJh2IhPntnzvFq930hqtol/rOs
        UnhddLVGNSXOUu2gsE/yM8gBXHU/CM736rjU3rSeV0VYsOgwt+TLWnx8kkg3wjmA
        l44n2CxeJ9ZbrdwGJJlKthLakeyFw==
X-ME-Sender: <xms:kdzBXufrjYoBq14cjGP9MgtcFAIUCEIN_V8UhAByyykTAtrZjy6-8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtgedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtje
    ertddtreejnecuhfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidr
    nhgvtheqnecuggftrfgrthhtvghrnhepfeefteetvdeguddvveefveeftedtffduudehue
    eihfeuvefgveehffeludeggfejnecukfhppeduudekrddvtdekrdduiedurddufedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:kdzBXoMXSZOWMt-HR8tjin1ksPHMlzI3qNo54RqoWCZwWLSDJSPqqA>
    <xmx:kdzBXvgMY5_n0FpvHsofpreycr0jEtqVeKzYkPGhVLZa-Ys3zarLow>
    <xmx:kdzBXr_BViR-59odoAltTFSKR6vlE0S5OWc_2XSyWkh6tLszbROb7Q>
    <xmx:ktzBXvWldk709pLNw4l0LnII8fLrihAxk-Z1w5AMlrcFyWL5B8qkIg>
Received: from mickey.themaw.net (unknown [118.208.161.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1E6DC3280059;
        Sun, 17 May 2020 20:53:34 -0400 (EDT)
Message-ID: <e994d56ff1357013a85bde7be2e901476f743b83.camel@themaw.net>
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
From:   Ian Kent <raven@themaw.net>
To:     Chengguang Xu <cgxu519@mykernel.net>, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Date:   Mon, 18 May 2020 08:53:31 +0800
In-Reply-To: <20200515072047.31454-1-cgxu519@mykernel.net>
References: <20200515072047.31454-1-cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-05-15 at 15:20 +0800, Chengguang Xu wrote:
> This series adds a new lookup flag LOOKUP_DONTCACHE_NEGATIVE
> to indicate to drop negative dentry in slow path of lookup.
> 
> In overlayfs, negative dentries in upper/lower layers are useless
> after construction of overlayfs' own dentry, so in order to
> effectively reclaim those dentries, specify LOOKUP_DONTCACHE_NEGATIVE
> flag when doing lookup in upper/lower layers.

I've looked at this a couple of times now.

I'm not at all sure of the wisdom of adding a flag to a VFS function
that allows circumventing what a file system chooses to do.

I also do really see the need for it because only hashed negative
dentrys will be retained by the VFS so, if you see a hashed negative
dentry then you can cause it to be discarded on release of the last
reference by dropping it.

So what's different here, why is adding an argument to do that drop
in the VFS itself needed instead of just doing it in overlayfs?

> 
> Patch 1 adds flag LOOKUP_DONTCACHE_NEGATIVE and related logic in vfs
> layer.
> Patch 2 does lookup optimazation for overlayfs.
> Patch 3-9 just adjusts function argument when calling
> lookup_positive_unlocked() and lookup_one_len_unlocked().
> 
> v1->v2:
> - Only drop negative dentry in slow path of lookup.
> 
> v2->v3:
> - Drop negative dentry in vfs layer.
> - Rebase on latest linus-tree(5.7.0-rc5).
> 
> Chengguang Xu (9):
>   fs/dcache: Introduce a new lookup flag LOOKUP_DONTCACHE_NEGATIVE
>   ovl: Suppress negative dentry in lookup
>   cifs: Adjust argument for lookup_positive_unlocked()
>   debugfs: Adjust argument for lookup_positive_unlocked()
>   ecryptfs: Adjust argument for lookup_one_len_unlocked()
>   exportfs: Adjust argument for lookup_one_len_unlocked()
>   kernfs: Adjust argument for lookup_positive_unlocked()
>   nfsd: Adjust argument for lookup_positive_unlocked()
>   quota: Adjust argument for lookup_positive_unlocked()
> 
>  fs/cifs/cifsfs.c      |  2 +-
>  fs/debugfs/inode.c    |  2 +-
>  fs/ecryptfs/inode.c   |  2 +-
>  fs/exportfs/expfs.c   |  2 +-
>  fs/kernfs/mount.c     |  2 +-
>  fs/namei.c            | 14 ++++++++++----
>  fs/nfsd/nfs3xdr.c     |  2 +-
>  fs/nfsd/nfs4xdr.c     |  3 ++-
>  fs/overlayfs/namei.c  |  9 +++++----
>  fs/quota/dquot.c      |  3 ++-
>  include/linux/namei.h |  9 +++++++--
>  11 files changed, 32 insertions(+), 18 deletions(-)
> 

