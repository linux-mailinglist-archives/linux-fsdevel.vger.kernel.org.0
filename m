Return-Path: <linux-fsdevel+bounces-46059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F09BA821D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D3416FB4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF56225D546;
	Wed,  9 Apr 2025 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCYeOeKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5968D25A2DC;
	Wed,  9 Apr 2025 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193695; cv=none; b=XFr9vB7t7lHxzSQ3tNnTdLG3MfyByvxTJnHfRLdnjqZ9SeB+9o6PFKXtjRlBZDFGGxPNnX37jQUho2LHrvsQAmil6YNOVuTwfJXE22BvVO13cKKMivRo3uGI1ABpDy61hWzeWV5ydqEdHX+gxfmVTtv0pqmhVlE5L3XYiq9W+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193695; c=relaxed/simple;
	bh=08Q12D4+eJ/PH4cZwiH9X2cmEbA6ZrZJcpHWrxSnHvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpgCdfxQNyGMQ+qzRfRxbNXBkzhFLry3TYJ7y7h05iby46oEUBOJNtOBODdpBxv+QIut/u+C3xKwcaZhJp5KHOPGQXMPmcfWjBcjdg2fN93lzncbOoqqVa6RYm8Eed844yooPjFaSkrgM0EhhLI1MzYrrwzt9kbdqubt1wLffFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCYeOeKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8112BC4CEE3;
	Wed,  9 Apr 2025 10:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744193694;
	bh=08Q12D4+eJ/PH4cZwiH9X2cmEbA6ZrZJcpHWrxSnHvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCYeOeKc0JOkKbfY1OcT626Ivy6pmPZLEUWNnFNsBdgW33Zx/Q9D7ZhAV1PhJEGcg
	 ykKy4WgGT/Go+Mqpv7HN4ZYyE1YiVTaAXnKarMzt/fDZpv6n5OHp0NdB8ol2FwoGb7
	 1zz/B0VhEinOvBM2uz55GyvQUHSsEHA6iP5zsbGRGewI9txyjn0brvR9y26bDUkIhV
	 rncpGupgOf2zfYzOrCAlgr34eXw85VVyzJxuET2apEl3kMAbknfUxapStl9gbhjjhO
	 /Hx1l23SdFmYtaZJvSZdk23dILrvwjDKNG0e8dKY0cU4Zj4i9ob2kRg2Yta6JyOFKV
	 lnhenpFHGRqNg==
Date: Wed, 9 Apr 2025 12:14:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-fsdevel@vger.kernel.org, NeilBrown <neilb@suse.de>, 
	linux-debuggers@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] dcache: convert dentry flag macros to enum
Message-ID: <20250409-mutig-sperren-9b48128ca999@brauner>
References: <177665a082f048cf536b9cd6af467b3be6b6e6ed.1744141838.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177665a082f048cf536b9cd6af467b3be6b6e6ed.1744141838.git.osandov@fb.com>

On Tue, Apr 08, 2025 at 01:00:53PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit 9748cb2dc393 ("VFS: repack DENTRY_ flags.") changed the value of
> DCACHE_MOUNTED, which broke drgn's path_lookup() helper. drgn is forced
> to hard-code it because it's a macro, and macros aren't preserved in
> debugging information by default.
> 
> Enums, on the other hand, are included in debugging information. Convert
> the DCACHE_* flag macros to an enum so that debugging tools like drgn
> and bpftrace can make use of them.

Ok, that's fine and I prefer them anyway.

> 
> Link: https://github.com/osandov/drgn/blob/2027d0fea84d74b835e77392f7040c2a333180c6/drgn/helpers/linux/fs.py#L43-L46
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> Hi,
> 
> This is based on Linus' tree as of today. If possible, it'd be great to
> get this in for 6.15.
> 
> Here are a couple of examples of similar changes in the past:
> 
> 	0b108e83795c ("SUNRPC: convert RPC_TASK_* constants to enum")
> 	ff202303c398 ("mm: convert page type macros to enum")
> 
> There's also an alternative approach that is more verbose but allows for
> automatic numbering:

Meh, no need imho.

> 
> 	enum dentry_flags {
> 		__DCACHE_OP_HASH,
> 		__DCACHE_OP_COMPARE,
> 		...
> 	};
> 	
> 	#define DCACHE_OP_HASH BIT(__DCACHE_OP_HASH)
> 	#define DCACHE_OP_COMPARE BIT(__DCACHE_OP_COMPARE)
> 	...
> 
> Let me know if you'd prefer that approach.
> 
> Thanks,
> Omar
> 
>  include/linux/dcache.h | 105 ++++++++++++++++++++---------------------
>  1 file changed, 50 insertions(+), 55 deletions(-)
> 
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 8d1395f945bf..a945cc86a8f1 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -173,65 +173,60 @@ struct dentry_operations {
>   */
>  
>  /* d_flags entries */
> -#define DCACHE_OP_HASH			BIT(0)
> -#define DCACHE_OP_COMPARE		BIT(1)
> -#define DCACHE_OP_REVALIDATE		BIT(2)
> -#define DCACHE_OP_DELETE		BIT(3)
> -#define DCACHE_OP_PRUNE			BIT(4)
> +enum dentry_flags {
> +	DCACHE_OP_HASH = BIT(0),
> +	DCACHE_OP_COMPARE = BIT(1),
> +	DCACHE_OP_REVALIDATE = BIT(2),
> +	DCACHE_OP_DELETE = BIT(3),
> +	DCACHE_OP_PRUNE = BIT(4),
> +	/*
> +	 * This dentry is possibly not currently connected to the dcache tree,
> +	 * in which case its parent will either be itself, or will have this
> +	 * flag as well.  nfsd will not use a dentry with this bit set, but will
> +	 * first endeavour to clear the bit either by discovering that it is
> +	 * connected, or by performing lookup operations.  Any filesystem which
> +	 * supports nfsd_operations MUST have a lookup function which, if it
> +	 * finds a directory inode with a DCACHE_DISCONNECTED dentry, will
> +	 * d_move that dentry into place and return that dentry rather than the
> +	 * passed one, typically using d_splice_alias.
> +	 */
> +	DCACHE_DISCONNECTED = BIT(5),
> +	DCACHE_REFERENCED = BIT(6),		/* Recently used, don't discard. */
> +	DCACHE_DONTCACHE = BIT(7),		/* Purge from memory on final dput() */
> +	DCACHE_CANT_MOUNT = BIT(8),
> +	DCACHE_GENOCIDE = BIT(9),
> +	DCACHE_SHRINK_LIST = BIT(10),
> +	DCACHE_OP_WEAK_REVALIDATE = BIT(11),
> +	/*
> +	 * this dentry has been "silly renamed" and has to be deleted on the
> +	 * last dput()
> +	 */
> +	DCACHE_NFSFS_RENAMED = BIT(12),
> +	/* Parent inode is watched by some fsnotify listener */
> +	DCACHE_FSNOTIFY_PARENT_WATCHED = BIT(13),
> +	DCACHE_DENTRY_KILLED = BIT(14),
> +	DCACHE_MOUNTED = BIT(15),		/* is a mountpoint */
> +	DCACHE_NEED_AUTOMOUNT = BIT(16),	/* handle automount on this dir */
> +	DCACHE_MANAGE_TRANSIT = BIT(17),	/* manage transit from this dirent */
> +	DCACHE_LRU_LIST = BIT(18),
> +	DCACHE_ENTRY_TYPE = (7 << 19),		/* bits 19..21 are for storing type: */
> +	DCACHE_MISS_TYPE = (0 << 19),		/* Negative dentry */
> +	DCACHE_WHITEOUT_TYPE = (1 << 19),	/* Whiteout dentry (stop pathwalk) */
> +	DCACHE_DIRECTORY_TYPE = (2 << 19),	/* Normal directory */
> +	DCACHE_AUTODIR_TYPE = (3 << 19),	/* Lookupless directory (presumed automount) */
> +	DCACHE_REGULAR_TYPE = (4 << 19),	/* Regular file type */
> +	DCACHE_SPECIAL_TYPE = (5 << 19),	/* Other file type */
> +	DCACHE_SYMLINK_TYPE = (6 << 19),	/* Symlink */
> +	DCACHE_NOKEY_NAME = BIT(22),		/* Encrypted name encoded without key */
> +	DCACHE_OP_REAL = BIT(23),
> +	DCACHE_PAR_LOOKUP = BIT(24),		/* being looked up (with parent locked shared) */
> +	DCACHE_DENTRY_CURSOR = BIT(25),
> +	DCACHE_NORCU = BIT(26),			/* No RCU delay for freeing */
> +};
>  
> -#define	DCACHE_DISCONNECTED		BIT(5)
> -     /* This dentry is possibly not currently connected to the dcache tree, in
> -      * which case its parent will either be itself, or will have this flag as
> -      * well.  nfsd will not use a dentry with this bit set, but will first
> -      * endeavour to clear the bit either by discovering that it is connected,
> -      * or by performing lookup operations.   Any filesystem which supports
> -      * nfsd_operations MUST have a lookup function which, if it finds a
> -      * directory inode with a DCACHE_DISCONNECTED dentry, will d_move that
> -      * dentry into place and return that dentry rather than the passed one,
> -      * typically using d_splice_alias. */
> -
> -#define DCACHE_REFERENCED		BIT(6) /* Recently used, don't discard. */
> -
> -#define DCACHE_DONTCACHE		BIT(7) /* Purge from memory on final dput() */
> -
> -#define DCACHE_CANT_MOUNT		BIT(8)
> -#define DCACHE_GENOCIDE			BIT(9)
> -#define DCACHE_SHRINK_LIST		BIT(10)
> -
> -#define DCACHE_OP_WEAK_REVALIDATE	BIT(11)
> -
> -#define DCACHE_NFSFS_RENAMED		BIT(12)
> -     /* this dentry has been "silly renamed" and has to be deleted on the last
> -      * dput() */
> -#define DCACHE_FSNOTIFY_PARENT_WATCHED	BIT(13)
> -     /* Parent inode is watched by some fsnotify listener */
> -
> -#define DCACHE_DENTRY_KILLED		BIT(14)
> -
> -#define DCACHE_MOUNTED			BIT(15) /* is a mountpoint */
> -#define DCACHE_NEED_AUTOMOUNT		BIT(16) /* handle automount on this dir */
> -#define DCACHE_MANAGE_TRANSIT		BIT(17) /* manage transit from this dirent */
>  #define DCACHE_MANAGED_DENTRY \
>  	(DCACHE_MOUNTED|DCACHE_NEED_AUTOMOUNT|DCACHE_MANAGE_TRANSIT)
>  
> -#define DCACHE_LRU_LIST			BIT(18)
> -
> -#define DCACHE_ENTRY_TYPE		(7 << 19) /* bits 19..21 are for storing type: */
> -#define DCACHE_MISS_TYPE		(0 << 19) /* Negative dentry */
> -#define DCACHE_WHITEOUT_TYPE		(1 << 19) /* Whiteout dentry (stop pathwalk) */
> -#define DCACHE_DIRECTORY_TYPE		(2 << 19) /* Normal directory */
> -#define DCACHE_AUTODIR_TYPE		(3 << 19) /* Lookupless directory (presumed automount) */
> -#define DCACHE_REGULAR_TYPE		(4 << 19) /* Regular file type */
> -#define DCACHE_SPECIAL_TYPE		(5 << 19) /* Other file type */
> -#define DCACHE_SYMLINK_TYPE		(6 << 19) /* Symlink */
> -
> -#define DCACHE_NOKEY_NAME		BIT(22) /* Encrypted name encoded without key */
> -#define DCACHE_OP_REAL			BIT(23)
> -
> -#define DCACHE_PAR_LOOKUP		BIT(24) /* being looked up (with parent locked shared) */
> -#define DCACHE_DENTRY_CURSOR		BIT(25)
> -#define DCACHE_NORCU			BIT(26) /* No RCU delay for freeing */
> -
>  extern seqlock_t rename_lock;
>  
>  /*
> -- 
> 2.49.0
> 

