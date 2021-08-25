Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420A03F756A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 14:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbhHYMx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 08:53:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50490 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhHYMx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:53:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A77DF1FE13;
        Wed, 25 Aug 2021 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629895989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oOMEW2fwaD5aLPPBQC66DYit7VHFfFPiKW/lOPUGF5o=;
        b=nYv/NHKlT3afw61QcZVC3fkIiR/Jck8e2TTZc0LODudlsWAS0jEFLRv6F7PT0sHIMeQTef
        q5h4KmwwNb9+xDAXfIPM7UFbI4zKBWepSuQ62NKVHWaANV1gwJtsRSntn6m2U61CCV6C2A
        UDNv4Bn/larAGnsxgGeYiMGawY0E+3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629895989;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oOMEW2fwaD5aLPPBQC66DYit7VHFfFPiKW/lOPUGF5o=;
        b=2cNbckg15o5EzwCkBFym4aYiqWYWRsgsUFPU3ETHAYuF9NJy2fOyoWftnKGnEu+TTek475
        IpG6it67xczaMoAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 99EBFA3B89;
        Wed, 25 Aug 2021 12:53:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 791211F2BA4; Wed, 25 Aug 2021 14:53:09 +0200 (CEST)
Date:   Wed, 25 Aug 2021 14:53:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] FIEMAP cleanups for 5.15-rc1
Message-ID: <20210825125309.GA8508@quack2.suse.cz>
References: <20210825124920.GF14620@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825124920.GF14620@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Forgot to CC fsdevel so adding it now.

								Honza
On Wed 25-08-21 14:49:20, Jan Kara wrote:
>   Hello Linus,
> 
>   Another early pull request for the merge window due to clashing holidays.
> Could you please pull from
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fiemap_for_v5.15-rc1
> 
> to get FIEMAP cleanups from Christoph transitioning all remaining
> filesystems supporting FIEMAP (ext2, hpfs) to iomap API and removing the
> old helper.
> 
> Top of the tree is 9acb9c48b940. The full shortlog is:
> 
> Christoph Hellwig (4):
>       ext2: make ext2_iomap_ops available unconditionally
>       ext2: use iomap_fiemap to implement ->fiemap
>       hpfs: use iomap_fiemap to implement ->fiemap
>       fs: remove generic_block_fiemap
> 
> The diffstat is
> 
>  fs/ext2/Kconfig        |   1 +
>  fs/ext2/inode.c        |  15 ++--
>  fs/hpfs/Kconfig        |   1 +
>  fs/hpfs/file.c         |  51 ++++++++++++-
>  fs/ioctl.c             | 203 -------------------------------------------------
>  include/linux/fiemap.h |   4 -
>  6 files changed, 60 insertions(+), 215 deletions(-)
> 
> 							Thanks
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
