Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AB423C7CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 10:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgHEIaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 04:30:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:43938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgHEIaU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:30:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1681B63A;
        Wed,  5 Aug 2020 08:30:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3C5381E12CB; Wed,  5 Aug 2020 10:30:17 +0200 (CEST)
Date:   Wed, 5 Aug 2020 10:30:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Jeff Mahoney <jeffm@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: delete duplicated words
Message-ID: <20200805083017.GA4117@quack2.suse.cz>
References: <20200805024925.12281-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805024925.12281-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 04-08-20 19:49:25, Randy Dunlap wrote:
> Delete repeated words in fs/reiserfs/.
> {from, not, we, are}
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> To: linux-fsdevel@vger.kernel.org
> Cc: Jan Kara <jack@suse.com>
> Cc: Jeff Mahoney <jeffm@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: reiserfs-devel@vger.kernel.org

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/reiserfs/dir.c       |    8 ++++----
>  fs/reiserfs/fix_node.c  |    4 ++--
>  fs/reiserfs/journal.c   |    2 +-
>  fs/reiserfs/xattr_acl.c |    2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> --- linux-next-20200804.orig/fs/reiserfs/dir.c
> +++ linux-next-20200804/fs/reiserfs/dir.c
> @@ -289,7 +289,7 @@ void make_empty_dir_item_v1(char *body,
>  
>  	/* direntry header of "." */
>  	put_deh_offset(dot, DOT_OFFSET);
> -	/* these two are from make_le_item_head, and are are LE */
> +	/* these two are from make_le_item_head, and are LE */
>  	dot->deh_dir_id = dirid;
>  	dot->deh_objectid = objid;
>  	dot->deh_state = 0;	/* Endian safe if 0 */
> @@ -299,7 +299,7 @@ void make_empty_dir_item_v1(char *body,
>  	/* direntry header of ".." */
>  	put_deh_offset(dotdot, DOT_DOT_OFFSET);
>  	/* key of ".." for the root directory */
> -	/* these two are from the inode, and are are LE */
> +	/* these two are from the inode, and are LE */
>  	dotdot->deh_dir_id = par_dirid;
>  	dotdot->deh_objectid = par_objid;
>  	dotdot->deh_state = 0;	/* Endian safe if 0 */
> @@ -323,7 +323,7 @@ void make_empty_dir_item(char *body, __l
>  
>  	/* direntry header of "." */
>  	put_deh_offset(dot, DOT_OFFSET);
> -	/* these two are from make_le_item_head, and are are LE */
> +	/* these two are from make_le_item_head, and are LE */
>  	dot->deh_dir_id = dirid;
>  	dot->deh_objectid = objid;
>  	dot->deh_state = 0;	/* Endian safe if 0 */
> @@ -333,7 +333,7 @@ void make_empty_dir_item(char *body, __l
>  	/* direntry header of ".." */
>  	put_deh_offset(dotdot, DOT_DOT_OFFSET);
>  	/* key of ".." for the root directory */
> -	/* these two are from the inode, and are are LE */
> +	/* these two are from the inode, and are LE */
>  	dotdot->deh_dir_id = par_dirid;
>  	dotdot->deh_objectid = par_objid;
>  	dotdot->deh_state = 0;	/* Endian safe if 0 */
> --- linux-next-20200804.orig/fs/reiserfs/fix_node.c
> +++ linux-next-20200804/fs/reiserfs/fix_node.c
> @@ -611,9 +611,9 @@ static int get_num_ver(int mode, struct
>   *	blk_num	number of blocks that S[h] will be splitted into;
>   *	s012	number of items that fall into splitted nodes.
>   *	lbytes	number of bytes which flow to the left neighbor from the
> - *              item that is not not shifted entirely
> + *              item that is not shifted entirely
>   *	rbytes	number of bytes which flow to the right neighbor from the
> - *              item that is not not shifted entirely
> + *              item that is not shifted entirely
>   *	s1bytes	number of bytes which flow to the first  new node when
>   *              S[0] splits (this number is contained in s012 array)
>   */
> --- linux-next-20200804.orig/fs/reiserfs/journal.c
> +++ linux-next-20200804/fs/reiserfs/journal.c
> @@ -32,7 +32,7 @@
>   *                      to disk for all backgrounded commits that have been
>   *                      around too long.
>   *		     -- Note, if you call this as an immediate flush from
> - *		        from within kupdate, it will ignore the immediate flag
> + *		        within kupdate, it will ignore the immediate flag
>   */
>  
>  #include <linux/time.h>
> --- linux-next-20200804.orig/fs/reiserfs/xattr_acl.c
> +++ linux-next-20200804/fs/reiserfs/xattr_acl.c
> @@ -373,7 +373,7 @@ int reiserfs_cache_default_acl(struct in
>  
>  		/* Other xattrs can be created during inode creation. We don't
>  		 * want to claim too many blocks, so we check to see if we
> -		 * we need to create the tree to the xattrs, and then we
> +		 * need to create the tree to the xattrs, and then we
>  		 * just want two files. */
>  		nblocks = reiserfs_xattr_jcreate_nblocks(inode);
>  		nblocks += JOURNAL_BLOCKS_PER_OBJECT(inode->i_sb);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
