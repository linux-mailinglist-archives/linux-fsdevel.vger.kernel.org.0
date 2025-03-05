Return-Path: <linux-fsdevel+bounces-43218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85038A4F8B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 09:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9300188A9D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D41F866B;
	Wed,  5 Mar 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZVtwLqt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094151C8FBA;
	Wed,  5 Mar 2025 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163088; cv=none; b=BzTSm/och4uuWLpmcXfS6l2nxe6ht1issaklrTmDcPeiFZu4NuOM3tO4XhduAJoMqgvMoIaZfL5q4qxp6qz499uGaC3J9i9MFmLQ2iYagbG7pCb7PtHGkvgF7tzhT4+13EN9LQEIPAoI06mNlKajwtexv7kQpw/C4B9EXqKgjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163088; c=relaxed/simple;
	bh=PW3JaKtoCnCno27xMt0CxSjDwQZd35hm3I+KQGOj6nM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oWYjS/U0uiVMtWv5VD3JaBMi7fxoSVEpHNeS9vU6HZ5cc3EmnIAJ5eXNuR7oIBe6BLVN+ieP9dwsvDFHlECOXAr9fN0MH4KsAylE40fiHEL8Z7VNCM2HyhAKJg2yb/hZPpmqbsJaUzkPOkkLuwFuqMznm5tZ/rr4eWReeViUjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZVtwLqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06913C4CEE2;
	Wed,  5 Mar 2025 08:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741163087;
	bh=PW3JaKtoCnCno27xMt0CxSjDwQZd35hm3I+KQGOj6nM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZZVtwLqtAUqKGkPwf5T8kYsPFSfE22uLdgVP/rVjmmoFSjcQR7R2Te/vrDvfZ7noG
	 D5wqGFMMslK/3p9DMbnf+zE9/X5PO9ocFGx4kEr7LpB2641QelQm4f4+t2z9UIeNO6
	 uE9YsU0JzLenNyMCypJ4wEZwpqp0bi9SPBHiupMVpyPGK5jxX1c54Sw2KtpTDeyTzS
	 GJN+yJ+gBF0ckJbdQhNP2d6FWw7PzMPjAW0fynH2LdjrhTQmqZqV6ucGXxwtsw3AQh
	 9yyxar38tM3VjnO0WaKpqwDEjdsL7N5dAHYSnC+EjUC2+Rr5hJLE7qsbOp/FqsNNrp
	 6EbFndHcPUOZA==
Message-ID: <1ed6cd1b-4165-4a87-a2eb-a8278c944922@kernel.org>
Date: Wed, 5 Mar 2025 16:24:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] f2fs: support F2FS_NOLINEAR_LOOKUP_FL
To: Eric Biggers <ebiggers@kernel.org>
References: <20250303034606.1355224-1-chao@kernel.org>
 <20250303230644.GA3695685@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250303230644.GA3695685@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 07:06, Eric Biggers wrote:
> On Mon, Mar 03, 2025 at 11:46:06AM +0800, Chao Yu via Linux-f2fs-devel wrote:
>> This patch introduces a new flag F2FS_NOLINEAR_LOOKUP_FL, so that we can
>> tag casefolded directory w/ it to disable linear lookup functionality,
>> it can be used for QA.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  fs/f2fs/dir.c             |  3 ++-
>>  fs/f2fs/f2fs.h            |  2 ++
>>  fs/f2fs/file.c            | 36 +++++++++++++++++++++++-------------
>>  include/uapi/linux/f2fs.h |  5 +++++
>>  4 files changed, 32 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 54dd52de7269..4c74f29a2c73 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -366,7 +366,8 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>>  
>>  out:
>>  #if IS_ENABLED(CONFIG_UNICODE)
>> -	if (IS_CASEFOLDED(dir) && !de && use_hash) {
>> +	if (IS_CASEFOLDED(dir) && !de && use_hash &&
>> +				!IS_NOLINEAR_LOOKUP(dir)) {
>>  		use_hash = false;
>>  		goto start_find_entry;
>>  	}
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 05879c6dc4d6..787f1e5a52d7 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -3047,6 +3047,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>>  #define F2FS_NOCOMP_FL			0x00000400 /* Don't compress */
>>  #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
>>  #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
>> +#define F2FS_NOLINEAR_LOOKUP_FL		0x08000000 /* do not use linear lookup */
>>  #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
>>  #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
>>  #define F2FS_DEVICE_ALIAS_FL		0x80000000 /* File for aliasing a device */
>> @@ -3066,6 +3067,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>>  #define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
>>  
>>  #define IS_DEVICE_ALIASING(inode)	(F2FS_I(inode)->i_flags & F2FS_DEVICE_ALIAS_FL)
>> +#define IS_NOLINEAR_LOOKUP(inode)	(F2FS_I(inode)->i_flags & F2FS_NOLINEAR_LOOKUP_FL)
>>  
>>  static inline __u32 f2fs_mask_flags(umode_t mode, __u32 flags)
>>  {
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 014cb7660a9a..1acddc4d11e4 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -2062,6 +2062,11 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>  		}
>>  	}
>>  
>> +	if ((iflags ^ masked_flags) & F2FS_NOLINEAR_LOOKUP_FLAG) {
>> +		if (!S_ISDIR(inode->i_mode) || !IS_CASEFOLDED(inode))
>> +			return -EINVAL;
>> +	}
>> +
>>  	fi->i_flags = iflags | (fi->i_flags & ~mask);
>>  	f2fs_bug_on(F2FS_I_SB(inode), (fi->i_flags & F2FS_COMPR_FL) &&
>>  					(fi->i_flags & F2FS_NOCOMP_FL));
>> @@ -2093,17 +2098,18 @@ static const struct {
>>  	u32 iflag;
>>  	u32 fsflag;
>>  } f2fs_fsflags_map[] = {
>> -	{ F2FS_COMPR_FL,	FS_COMPR_FL },
>> -	{ F2FS_SYNC_FL,		FS_SYNC_FL },
>> -	{ F2FS_IMMUTABLE_FL,	FS_IMMUTABLE_FL },
>> -	{ F2FS_APPEND_FL,	FS_APPEND_FL },
>> -	{ F2FS_NODUMP_FL,	FS_NODUMP_FL },
>> -	{ F2FS_NOATIME_FL,	FS_NOATIME_FL },
>> -	{ F2FS_NOCOMP_FL,	FS_NOCOMP_FL },
>> -	{ F2FS_INDEX_FL,	FS_INDEX_FL },
>> -	{ F2FS_DIRSYNC_FL,	FS_DIRSYNC_FL },
>> -	{ F2FS_PROJINHERIT_FL,	FS_PROJINHERIT_FL },
>> -	{ F2FS_CASEFOLD_FL,	FS_CASEFOLD_FL },
>> +	{ F2FS_COMPR_FL,		FS_COMPR_FL },
>> +	{ F2FS_SYNC_FL,			FS_SYNC_FL },
>> +	{ F2FS_IMMUTABLE_FL,		FS_IMMUTABLE_FL },
>> +	{ F2FS_APPEND_FL,		FS_APPEND_FL },
>> +	{ F2FS_NODUMP_FL,		FS_NODUMP_FL },
>> +	{ F2FS_NOATIME_FL,		FS_NOATIME_FL },
>> +	{ F2FS_NOCOMP_FL,		FS_NOCOMP_FL },
>> +	{ F2FS_INDEX_FL,		FS_INDEX_FL },
>> +	{ F2FS_DIRSYNC_FL,		FS_DIRSYNC_FL },
>> +	{ F2FS_PROJINHERIT_FL,		FS_PROJINHERIT_FL },
>> +	{ F2FS_CASEFOLD_FL,		FS_CASEFOLD_FL },
>> +	{ F2FS_NOLINEAR_LOOKUP_FL,	F2FS_NOLINEAR_LOOKUP_FL },
>>  };
>>  
>>  #define F2FS_GETTABLE_FS_FL (		\
>> @@ -2121,7 +2127,8 @@ static const struct {
>>  		FS_INLINE_DATA_FL |	\
>>  		FS_NOCOW_FL |		\
>>  		FS_VERITY_FL |		\
>> -		FS_CASEFOLD_FL)
>> +		FS_CASEFOLD_FL |	\
>> +		F2FS_NOLINEAR_LOOKUP_FL)
>>  
>>  #define F2FS_SETTABLE_FS_FL (		\
>>  		FS_COMPR_FL |		\
>> @@ -2133,7 +2140,8 @@ static const struct {
>>  		FS_NOCOMP_FL |		\
>>  		FS_DIRSYNC_FL |		\
>>  		FS_PROJINHERIT_FL |	\
>> -		FS_CASEFOLD_FL)
>> +		FS_CASEFOLD_FL |	\
>> +		F2FS_NOLINEAR_LOOKUP_FL)
>>  
>>  /* Convert f2fs on-disk i_flags to FS_IOC_{GET,SET}FLAGS flags */
>>  static inline u32 f2fs_iflags_to_fsflags(u32 iflags)
>> @@ -3344,6 +3352,8 @@ int f2fs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>>  		fsflags |= FS_INLINE_DATA_FL;
>>  	if (is_inode_flag_set(inode, FI_PIN_FILE))
>>  		fsflags |= FS_NOCOW_FL;
>> +	if (IS_NOLINEAR_LOOKUP(inode))
>> +		fsflags |= F2FS_NOLINEAR_LOOKUP_FL;
>>  
>>  	fileattr_fill_flags(fa, fsflags & F2FS_GETTABLE_FS_FL);
>>  
>> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
>> index 795e26258355..a03626fdcf35 100644
>> --- a/include/uapi/linux/f2fs.h
>> +++ b/include/uapi/linux/f2fs.h
>> @@ -104,4 +104,9 @@ struct f2fs_comp_option {
>>  	__u8 log_cluster_size;
>>  };
>>  
>> +/* used for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS */
>> +enum {
>> +	F2FS_NOLINEAR_LOOKUP_FLAG = 0x08000000,
>> +};
> 
> FS_IOC_GETFLAGS and FS_IOC_SETFLAGS are not filesystem-specific, and the
> supported flags are declared in include/uapi/linux/fs.h.  You can't just
> randomly give an unused bit a filesystem specific meaning.

Yeah, let me have a try to propose it into vfs.

Thanks,

> 
> - Eric


