Return-Path: <linux-fsdevel+bounces-43014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A833A4CF10
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 00:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611191892C6B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 23:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8594E2356B7;
	Mon,  3 Mar 2025 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDb+bis/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D691E9B28;
	Mon,  3 Mar 2025 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043207; cv=none; b=Jd922rnwMstf24exHqbMjWbfkX3ql2wmf1ewZy1Otc/CoFxIh5J4U6YsP0cyh1dZDQyaxDoW0tKPMmXBIJdvi2ob3aAbc2OV3DB11VQyXsreZFowCwRI27pB8H03YHXgHuEZzhKY5QcMUKbMCQYkR408bEvqOwy+LTA+PDf7z3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043207; c=relaxed/simple;
	bh=UJILM/vpJTvTLD9NoFEaSiIxBWcrfUtPn/ODc8cmblU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw2khJqeHY3pji3S4T7mn3c8hjMfk3Cwg7IKEdhho+k/+MrI8aNIKC2aMgRu4G0FOUgYSpY2Q1yUNGBqxkiha/BevxZfRld1Lu2OF3KgAC0izuPOTHdOe3mP52VgFP5wg4gr3W1+0z1n/DdIdF2pzUsg702sd7zuZEoDuTSxMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDb+bis/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D22C4CEE8;
	Mon,  3 Mar 2025 23:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741043206;
	bh=UJILM/vpJTvTLD9NoFEaSiIxBWcrfUtPn/ODc8cmblU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDb+bis/RYzdNTpvPkr+S6OCAEtVWVnUUTOhTQrL2CTU2w/a7RvTEjs6e2bpi49dS
	 4i0t0wjJDdunLyjITa3qgbvQoFbG5oJDOy1j2iHNbNpOpUW+n2sdKT634B4EhVWatS
	 DgknKMrSunabqvaXKSyI8c87dQXF57gFeK7O8II4ERMBsO8Prq+ek021bFXCYDgNrE
	 z2wuzdgORHl2q3nrHQ9APXbtnAK9qCGb3S7iYwnU4yB6SD8FMW2W6WAO+3jInvI7LW
	 Ew5VE/yT2NWU0yrhjRa4gZz4L89u42Vy5O8PAJXZGuZH2QR9J6FdH9/irl+QuyBAXC
	 +KP+kGVswHX6g==
Date: Mon, 3 Mar 2025 23:06:44 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] f2fs: support F2FS_NOLINEAR_LOOKUP_FL
Message-ID: <20250303230644.GA3695685@google.com>
References: <20250303034606.1355224-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303034606.1355224-1-chao@kernel.org>

On Mon, Mar 03, 2025 at 11:46:06AM +0800, Chao Yu via Linux-f2fs-devel wrote:
> This patch introduces a new flag F2FS_NOLINEAR_LOOKUP_FL, so that we can
> tag casefolded directory w/ it to disable linear lookup functionality,
> it can be used for QA.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/dir.c             |  3 ++-
>  fs/f2fs/f2fs.h            |  2 ++
>  fs/f2fs/file.c            | 36 +++++++++++++++++++++++-------------
>  include/uapi/linux/f2fs.h |  5 +++++
>  4 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 54dd52de7269..4c74f29a2c73 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -366,7 +366,8 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>  
>  out:
>  #if IS_ENABLED(CONFIG_UNICODE)
> -	if (IS_CASEFOLDED(dir) && !de && use_hash) {
> +	if (IS_CASEFOLDED(dir) && !de && use_hash &&
> +				!IS_NOLINEAR_LOOKUP(dir)) {
>  		use_hash = false;
>  		goto start_find_entry;
>  	}
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 05879c6dc4d6..787f1e5a52d7 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3047,6 +3047,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>  #define F2FS_NOCOMP_FL			0x00000400 /* Don't compress */
>  #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
>  #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
> +#define F2FS_NOLINEAR_LOOKUP_FL		0x08000000 /* do not use linear lookup */
>  #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
>  #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
>  #define F2FS_DEVICE_ALIAS_FL		0x80000000 /* File for aliasing a device */
> @@ -3066,6 +3067,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>  #define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
>  
>  #define IS_DEVICE_ALIASING(inode)	(F2FS_I(inode)->i_flags & F2FS_DEVICE_ALIAS_FL)
> +#define IS_NOLINEAR_LOOKUP(inode)	(F2FS_I(inode)->i_flags & F2FS_NOLINEAR_LOOKUP_FL)
>  
>  static inline __u32 f2fs_mask_flags(umode_t mode, __u32 flags)
>  {
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 014cb7660a9a..1acddc4d11e4 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2062,6 +2062,11 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  		}
>  	}
>  
> +	if ((iflags ^ masked_flags) & F2FS_NOLINEAR_LOOKUP_FLAG) {
> +		if (!S_ISDIR(inode->i_mode) || !IS_CASEFOLDED(inode))
> +			return -EINVAL;
> +	}
> +
>  	fi->i_flags = iflags | (fi->i_flags & ~mask);
>  	f2fs_bug_on(F2FS_I_SB(inode), (fi->i_flags & F2FS_COMPR_FL) &&
>  					(fi->i_flags & F2FS_NOCOMP_FL));
> @@ -2093,17 +2098,18 @@ static const struct {
>  	u32 iflag;
>  	u32 fsflag;
>  } f2fs_fsflags_map[] = {
> -	{ F2FS_COMPR_FL,	FS_COMPR_FL },
> -	{ F2FS_SYNC_FL,		FS_SYNC_FL },
> -	{ F2FS_IMMUTABLE_FL,	FS_IMMUTABLE_FL },
> -	{ F2FS_APPEND_FL,	FS_APPEND_FL },
> -	{ F2FS_NODUMP_FL,	FS_NODUMP_FL },
> -	{ F2FS_NOATIME_FL,	FS_NOATIME_FL },
> -	{ F2FS_NOCOMP_FL,	FS_NOCOMP_FL },
> -	{ F2FS_INDEX_FL,	FS_INDEX_FL },
> -	{ F2FS_DIRSYNC_FL,	FS_DIRSYNC_FL },
> -	{ F2FS_PROJINHERIT_FL,	FS_PROJINHERIT_FL },
> -	{ F2FS_CASEFOLD_FL,	FS_CASEFOLD_FL },
> +	{ F2FS_COMPR_FL,		FS_COMPR_FL },
> +	{ F2FS_SYNC_FL,			FS_SYNC_FL },
> +	{ F2FS_IMMUTABLE_FL,		FS_IMMUTABLE_FL },
> +	{ F2FS_APPEND_FL,		FS_APPEND_FL },
> +	{ F2FS_NODUMP_FL,		FS_NODUMP_FL },
> +	{ F2FS_NOATIME_FL,		FS_NOATIME_FL },
> +	{ F2FS_NOCOMP_FL,		FS_NOCOMP_FL },
> +	{ F2FS_INDEX_FL,		FS_INDEX_FL },
> +	{ F2FS_DIRSYNC_FL,		FS_DIRSYNC_FL },
> +	{ F2FS_PROJINHERIT_FL,		FS_PROJINHERIT_FL },
> +	{ F2FS_CASEFOLD_FL,		FS_CASEFOLD_FL },
> +	{ F2FS_NOLINEAR_LOOKUP_FL,	F2FS_NOLINEAR_LOOKUP_FL },
>  };
>  
>  #define F2FS_GETTABLE_FS_FL (		\
> @@ -2121,7 +2127,8 @@ static const struct {
>  		FS_INLINE_DATA_FL |	\
>  		FS_NOCOW_FL |		\
>  		FS_VERITY_FL |		\
> -		FS_CASEFOLD_FL)
> +		FS_CASEFOLD_FL |	\
> +		F2FS_NOLINEAR_LOOKUP_FL)
>  
>  #define F2FS_SETTABLE_FS_FL (		\
>  		FS_COMPR_FL |		\
> @@ -2133,7 +2140,8 @@ static const struct {
>  		FS_NOCOMP_FL |		\
>  		FS_DIRSYNC_FL |		\
>  		FS_PROJINHERIT_FL |	\
> -		FS_CASEFOLD_FL)
> +		FS_CASEFOLD_FL |	\
> +		F2FS_NOLINEAR_LOOKUP_FL)
>  
>  /* Convert f2fs on-disk i_flags to FS_IOC_{GET,SET}FLAGS flags */
>  static inline u32 f2fs_iflags_to_fsflags(u32 iflags)
> @@ -3344,6 +3352,8 @@ int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>  		fsflags |= FS_INLINE_DATA_FL;
>  	if (is_inode_flag_set(inode, FI_PIN_FILE))
>  		fsflags |= FS_NOCOW_FL;
> +	if (IS_NOLINEAR_LOOKUP(inode))
> +		fsflags |= F2FS_NOLINEAR_LOOKUP_FL;
>  
>  	fileattr_fill_flags(fa, fsflags & F2FS_GETTABLE_FS_FL);
>  
> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> index 795e26258355..a03626fdcf35 100644
> --- a/include/uapi/linux/f2fs.h
> +++ b/include/uapi/linux/f2fs.h
> @@ -104,4 +104,9 @@ struct f2fs_comp_option {
>  	__u8 log_cluster_size;
>  };
>  
> +/* used for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS */
> +enum {
> +	F2FS_NOLINEAR_LOOKUP_FLAG = 0x08000000,
> +};

FS_IOC_GETFLAGS and FS_IOC_SETFLAGS are not filesystem-specific, and the
supported flags are declared in include/uapi/linux/fs.h.  You can't just
randomly give an unused bit a filesystem specific meaning.

- Eric

