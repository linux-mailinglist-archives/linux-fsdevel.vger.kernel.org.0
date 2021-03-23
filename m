Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB8345F98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 14:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhCWN0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 09:26:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:39696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhCWNZw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:25:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6163BAD80;
        Tue, 23 Mar 2021 13:25:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E32561F2BA7; Tue, 23 Mar 2021 14:25:50 +0100 (CET)
Date:   Tue, 23 Mar 2021 14:25:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Theodore Tso <tytso@mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] Better fanotify support for tmpfs
Message-ID: <20210323132550.GA28062@quack2.suse.cz>
References: <20210322173944.449469-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322173944.449469-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-03-21 19:39:42, Amir Goldstein wrote:
> Jan,
> 
> I needed the tmpfs patch for the userns filesystem mark POC, but it
> looks useful for its own right to be able to set filesystem mount or
> inode marks on tmpfs with FAN_REPORT_FID.
> 
> I can break the cleanup patch into helper and individual patches
> for the fs maintainers, but since its so dummy, I thought it might
> be best to get an ACK from fs maintainers and carry this as a single
> patch.

The series looks fine to me. I'll wait if I get some feedback from Hugh. If
Hugh doesn't object, I'll take the two patches to my tree.

								Honza

> Amir Goldstein (2):
>   fs: introduce a wrapper uuid_to_fsid()
>   shmem: allow reporting fanotify events with file handles on tmpfs
> 
>  fs/ext2/super.c        | 5 +----
>  fs/ext4/super.c        | 5 +----
>  fs/zonefs/super.c      | 5 +----
>  include/linux/statfs.h | 7 +++++++
>  mm/shmem.c             | 3 +++
>  5 files changed, 13 insertions(+), 12 deletions(-)
> 
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
