Return-Path: <linux-fsdevel+bounces-77330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VImPIv3Uk2lA9AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 03:39:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD614882B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 03:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 458893019511
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 02:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF39236A73;
	Tue, 17 Feb 2026 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="pPv7VDgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9417A30A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771295991; cv=none; b=UcGMJmCUOVOMVex2RP1yKfkO+Jhg937Wn5+dzIPEP7wXCNTa00QoWsbR/TQ4dZBLCjFmRRWeDQAVfaKTFkk8aLDlLzwXZmfVKvk7RjPjYWgO7vEjmWSbu/LqKGoHz8rJkFcTN6xgz2+S2jjk77gWrB0YzgjHXSdCBd3JFzaXpA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771295991; c=relaxed/simple;
	bh=qoZDd2C2aNkRERkGimFnR5pATVjq8xpicEkM8y0o2+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OPnbYkKUE/ZKFqYLrIku9/IQUCR3pUvSP43AW7M8ONQMrbiEH46UqEbiziSymEHYxoRcZVgCQCbrf//XCCuwdSFNjA3ICYGWSP4H5rt9PSs5btaeIM2sr6dqv2ne6e5lLBooTo2JwhNc7vorn/c+fzaEdOfEk4yA/s3YaQrtS2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=pPv7VDgy; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 84AA6240027
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 03:39:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1771295979; bh=U1jNNhhmLqE8QmwOWkCsc5eScYtUKnnJVtGPC0Upwpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=pPv7VDgyj60mjhD6ktM4bsAUveFmpNVQGdE8V9vFVoYcPvQJ0NFDKVDNZQv2l5Jlj
	 SJDLnBwodbxN978Rrd51fmU3fbYxSh5uq4POjm3y8ogWBIKxxpiOeEm0vRKRGoR4Ye
	 RGgZhmfC0xMLVP4ZUK3+lkUdXcQ11vIUSBcDqEn6D2009QK7CjbU5wWqweU/BOZbBs
	 Zy6k66ZfAFgfNvHDy6TsfdbuT+M0wd1UoT+oSWhqJu9IC4DkyQrOJozXTRA9Jg5oZT
	 ozjqGD03ANn7QCGjFP0i33X7uuyZKYxTC9AohC3DAa5bDvZUhd8LmOe+qi5fI6g/0a
	 UZfOuNoSVlkbg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fFP4B2VkJz9rxF;
	Tue, 17 Feb 2026 03:39:38 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de,  linux-fsdevel@vger.kernel.org,
  frank.li@vivo.com,  Slava.Dubeyko@ibm.com
Subject: Re: [PATCH] hfs/hfsplus: fix timestamp wrapped issue
In-Reply-To: <20260216233556.4005400-1-slava@dubeyko.com>
References: <20260216233556.4005400-1-slava@dubeyko.com>
Date: Tue, 17 Feb 2026 02:39:39 +0000
Message-ID: <87a4x8f5zq.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77330-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[posteo.net:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charmitro@posteo.net,linux-fsdevel@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivo.com:email]
X-Rspamd-Queue-Id: A2FD614882B
X-Rspamd-Action: no action

Viacheslav Dubeyko <slava@dubeyko.com> writes:

> The xfstests' test-case generic/258 fails to execute
> correctly:
>
> FSTYP -- hfsplus
> PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc4+ #8 SMP PREEMPT_DYNAMIC Thu May 1 16:43:22 PDT 2025
> MKFS_OPTIONS -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
>
> generic/258 [failed, exit status 1]- output mismatch (see xfstests-dev/results//generic/258.out.bad)
>
> The main reason of the issue is the logic:
>
> cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET)
>
> At first, we take the lower 32 bits of the value and, then
> we add the time offset. However, if we have negative value
> then we make completely wrong calculation.
>
> This patch corrects the logic of __hfsp_mt2ut() and
> __hfsp_ut2mt (HFS+ case), __hfs_m_to_utime() and
> __hfs_u_to_mtime (HFS case). The HFS_MIN_TIMESTAMP_SECS and
> HFS_MAX_TIMESTAMP_SECS have been introduced in
> include/linux/hfs_common.h. Also, HFS_UTC_OFFSET constant
> has been moved to include/linux/hfs_common.h. The hfs_fill_super()
> and hfsplus_fill_super() logic defines sb->s_time_min,
> sb->s_time_max, and sb->s_time_gran.
>
> sudo ./check generic/258
> FSTYP         -- hfsplus
> PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.19.0-rc1+ #87 SMP PREEMPT_DYNAMIC Mon Feb 16 14:48:57 PST 2026
> MKFS_OPTIONS  -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
>
> generic/258 29s ...  39s
> Ran: generic/258
> Passed all 1 tests
>
> [1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/133
>
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/hfs/hfs_fs.h            | 17 ++++-------------
>  fs/hfs/super.c             |  4 ++++
>  fs/hfsplus/hfsplus_fs.h    | 13 ++++---------
>  fs/hfsplus/super.c         |  4 ++++
>  include/linux/hfs_common.h | 18 ++++++++++++++++++
>  5 files changed, 34 insertions(+), 22 deletions(-)
>
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index ac0e83f77a0f..7d529e6789b8 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -229,21 +229,11 @@ extern int hfs_mac2asc(struct super_block *sb,
>  extern void hfs_mark_mdb_dirty(struct super_block *sb);
>  
>  /*
> - * There are two time systems.  Both are based on seconds since
> - * a particular time/date.
> - *	Unix:	signed little-endian since 00:00 GMT, Jan. 1, 1970
> - *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1, 1904
> - *
> - * HFS implementations are highly inconsistent, this one matches the
> - * traditional behavior of 64-bit Linux, giving the most useful
> - * time range between 1970 and 2106, by treating any on-disk timestamp
> - * under HFS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
> + * time helpers: convert between 1904-base and 1970-base timestamps
>   */
> -#define HFS_UTC_OFFSET 2082844800U
> -
>  static inline time64_t __hfs_m_to_utime(__be32 mt)
>  {
> -	time64_t ut = (u32)(be32_to_cpu(mt) - HFS_UTC_OFFSET);
> +	time64_t ut = (time64_t)be32_to_cpu(mt) - HFS_UTC_OFFSET;
>  
>  	return ut + sys_tz.tz_minuteswest * 60;
>  }
> @@ -251,8 +241,9 @@ static inline time64_t __hfs_m_to_utime(__be32 mt)
>  static inline __be32 __hfs_u_to_mtime(time64_t ut)
>  {
>  	ut -= sys_tz.tz_minuteswest * 60;
> +	ut += HFS_UTC_OFFSET;
>  
> -	return cpu_to_be32(lower_32_bits(ut) + HFS_UTC_OFFSET);
> +	return cpu_to_be32(lower_32_bits(ut));
>  }
>  #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, vfs_inode))
>  #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 97546d6b41f4..6b6c138812b7 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -341,6 +341,10 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_flags |= SB_NODIRATIME;
>  	mutex_init(&sbi->bitmap_lock);
>  
> +	sb->s_time_gran = NSEC_PER_SEC;
> +	sb->s_time_min = HFS_MIN_TIMESTAMP_SECS;
> +	sb->s_time_max = HFS_MAX_TIMESTAMP_SECS;
> +
>  	res = hfs_mdb_get(sb);
>  	if (res) {
>  		if (!silent)
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 5f891b73a646..3554faf84c15 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -511,24 +511,19 @@ int hfsplus_read_wrapper(struct super_block *sb);
>  
>  /*
>   * time helpers: convert between 1904-base and 1970-base timestamps
> - *
> - * HFS+ implementations are highly inconsistent, this one matches the
> - * traditional behavior of 64-bit Linux, giving the most useful
> - * time range between 1970 and 2106, by treating any on-disk timestamp
> - * under HFSPLUS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
>   */
> -#define HFSPLUS_UTC_OFFSET 2082844800U
> -
>  static inline time64_t __hfsp_mt2ut(__be32 mt)
>  {
> -	time64_t ut = (u32)(be32_to_cpu(mt) - HFSPLUS_UTC_OFFSET);
> +	time64_t ut = (time64_t)be32_to_cpu(mt) - HFS_UTC_OFFSET;
>  
>  	return ut;
>  }
>  
>  static inline __be32 __hfsp_ut2mt(time64_t ut)
>  {
> -	return cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET);
> +	ut += HFS_UTC_OFFSET;
> +
> +	return cpu_to_be32(lower_32_bits(ut));
>  }
>  
>  static inline enum hfsplus_btree_mutex_classes
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 592d8fbb748c..dcd61868d199 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -487,6 +487,10 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (!sbi->rsrc_clump_blocks)
>  		sbi->rsrc_clump_blocks = 1;
>  
> +	sb->s_time_gran = NSEC_PER_SEC;
> +	sb->s_time_min = HFS_MIN_TIMESTAMP_SECS;
> +	sb->s_time_max = HFS_MAX_TIMESTAMP_SECS;
> +
>  	err = -EFBIG;
>  	last_fs_block = sbi->total_blocks - 1;
>  	last_fs_page = (last_fs_block << sbi->alloc_blksz_shift) >>
> diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
> index dadb5e0aa8a3..816ac2f0996d 100644
> --- a/include/linux/hfs_common.h
> +++ b/include/linux/hfs_common.h
> @@ -650,4 +650,22 @@ typedef union {
>  	struct hfsplus_attr_key attr;
>  } __packed hfsplus_btree_key;
>  
> +/*
> + * There are two time systems.  Both are based on seconds since
> + * a particular time/date.
> + *	Unix:	signed little-endian since 00:00 GMT, Jan. 1, 1970
> + *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1, 1904
> + *
> + * HFS/HFS+ implementations are highly inconsistent, this one matches the
> + * traditional behavior of 64-bit Linux, giving the most useful
> + * time range between 1970 and 2106, by treating any on-disk timestamp
> + * under HFS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
> + */

Since this is replacing the wrapping behavior with a linear 1904-2040
mapping, should we update this comment to match? It still describes the
old "2040 to 2106" wrapping semantics.

Cheers,
C. Mitrodimas

> +#define HFS_UTC_OFFSET 2082844800U
> +
> +/* January 1, 1904, 00:00:00 UTC */
> +#define HFS_MIN_TIMESTAMP_SECS		-2082844800LL
> +/* February 6, 2040, 06:28:15 UTC */
> +#define HFS_MAX_TIMESTAMP_SECS		2212122495LL
> +
>  #endif /* _HFS_COMMON_H_ */

