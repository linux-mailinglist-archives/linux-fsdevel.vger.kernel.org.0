Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B794058EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 16:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343593AbhIIOYN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 10:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245487AbhIIOYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:24:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23C3C02539B;
        Thu,  9 Sep 2021 05:53:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k13so3544934lfv.2;
        Thu, 09 Sep 2021 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XCX2UYSZQUn08q9KgA+a/AS7BgY7qzOnl3a2YH/6Kuw=;
        b=eAduYSyq3BXBiMt/5ixhkpPXUguKt3L3vs0oOTKzbfvKtth0bD+uim1i2YIh0SCp/N
         QF/XdsMzRXyuoFq0XjQTwpY77rL/CW9H2g5w1MbtuIjSzwm6/RmY9xCwTlKkX7u/Eskv
         O3YvZhZUYbbgVwQRa75rhbD2YvKhaeq6N40XO+Cr/MxI70ACWpbmO1IGQGZwm/PCt3WI
         s5vzQRS7nWRO5q3Dml33bIvfHKS83CS3WyCMnS4zJ8ut0gOXjjNes2BfjOFjg15LuhsF
         6bqkJfurYW2qyv9apcO+hp0Et9Kh94JEqGJHfbju5QA+B3xVtsacVk5YY34OXjpA+Ppl
         b6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XCX2UYSZQUn08q9KgA+a/AS7BgY7qzOnl3a2YH/6Kuw=;
        b=tEG3EOSzw3uRiJHNEo9ErHcD4EIlLsBZe+aD+ECUIE33hxfXhT5tartU2x8luAWsfd
         8mrNythVJ5Yn402Ly3EdZlCRhwisXkOV4l/AZVB7M5IdjWDYCnRosRaYXoM2JjHmHBIb
         FvN4cR0fOEC5qnofZolZpJ7mLTdsTbuHVF5htjdeBiLUSgGMQdNeDGm6iBNLxqxUMI/w
         5mlFGQs9izRDd8IfbY0bzxnjONFdZhXkjEbm1WL4dJ4+7tUSxWmj94JVaJ6XMbLGrKhK
         pvz17/yCA32kk/7K4jB0nIVBmdz3MjXesG1b1iPutCS7QrItxb0ulJ81AZ6zc9VW6Tk/
         /SlQ==
X-Gm-Message-State: AOAM5316dmuxr3fthqCJ+ugXzmGPWC8Sx1RO0RHFbsM3OTTlJn3ASa82
        VM36Picx2ypz4UhiYioHN14qiblcs1Q=
X-Google-Smtp-Source: ABdhPJwCPp4aujaH2CwqmOaRLoiQKu8uRpFu8nsdXcaf9BbvGIVFheodyVV1j0kHVwI7LWQsUiOMqw==
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr2161495lfg.629.1631192019881;
        Thu, 09 Sep 2021 05:53:39 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id m5sm191061lfk.267.2021.09.09.05.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:53:39 -0700 (PDT)
Date:   Thu, 9 Sep 2021 15:53:37 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] fs/ntfs3: Add sync flag to ntfs_sb_write_run and
 al_update
Message-ID: <20210909125337.664ezyu7jrke5vdn@kari-VirtualBox>
References: <8a99d42f-1097-9c0d-d1b2-5b971a8a4d1f@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a99d42f-1097-9c0d-d1b2-5b971a8a4d1f@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:58:08PM +0300, Konstantin Komarov wrote:
> This allows to wait only when it's requested.
> It speeds up creation of hardlinks.
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/attrib.c   | 2 +-
>  fs/ntfs3/attrlist.c | 6 +++---
>  fs/ntfs3/frecord.c  | 2 +-
>  fs/ntfs3/fslog.c    | 9 +++++----
>  fs/ntfs3/fsntfs.c   | 8 ++++----
>  fs/ntfs3/inode.c    | 2 +-
>  fs/ntfs3/ntfs_fs.h  | 4 ++--
>  fs/ntfs3/xattr.c    | 2 +-
>  8 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> index 34c4cbf7e29b..64a28fe7c124 100644
> --- a/fs/ntfs3/attrib.c
> +++ b/fs/ntfs3/attrib.c
> @@ -291,7 +291,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
>  		if (!rsize) {
>  			/* Empty resident -> Non empty nonresident. */
>  		} else if (!is_data) {
> -			err = ntfs_sb_write_run(sbi, run, 0, data, rsize);
> +			err = ntfs_sb_write_run(sbi, run, 0, data, rsize, 0);
>  			if (err)
>  				goto out2;
>  		} else if (!page) {
> diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
> index fa32399eb517..e41443cb3d63 100644
> --- a/fs/ntfs3/attrlist.c
> +++ b/fs/ntfs3/attrlist.c
> @@ -336,7 +336,7 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
>  
>  	if (attr && attr->non_res) {
>  		err = ntfs_sb_write_run(ni->mi.sbi, &al->run, 0, al->le,
> -					al->size);
> +					al->size, 0);
>  		if (err)
>  			return err;
>  		al->dirty = false;
> @@ -423,7 +423,7 @@ bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
>  	return true;
>  }
>  
> -int al_update(struct ntfs_inode *ni)
> +int al_update(struct ntfs_inode *ni, int sync)
>  {
>  	int err;
>  	struct ATTRIB *attr;
> @@ -445,7 +445,7 @@ int al_update(struct ntfs_inode *ni)
>  		memcpy(resident_data(attr), al->le, al->size);
>  	} else {
>  		err = ntfs_sb_write_run(ni->mi.sbi, &al->run, 0, al->le,
> -					al->size);
> +					al->size, sync);
>  		if (err)
>  			goto out;
>  
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 5dd7b7a7c5e0..8478be3ab0e4 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -3209,7 +3209,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
>  					goto out;
>  			}
>  
> -			err = al_update(ni);
> +			err = al_update(ni, sync);
>  			if (err)
>  				goto out;
>  		}
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index b5853aed0e25..5c82b6218d94 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -2219,7 +2219,7 @@ static int last_log_lsn(struct ntfs_log *log)
>  
>  			err = ntfs_sb_write_run(log->ni->mi.sbi,
>  						&log->ni->file.run, off, page,
> -						log->page_size);
> +						log->page_size, 0);
>  
>  			if (err)
>  				goto out;
> @@ -3710,7 +3710,8 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>  
>  	if (a_dirty) {
>  		attr = oa->attr;
> -		err = ntfs_sb_write_run(sbi, oa->run1, vbo, buffer_le, bytes);
> +		err = ntfs_sb_write_run(sbi, oa->run1, vbo, buffer_le, bytes,
> +					0);

If you don't mind that this is oneline I won't mind. 80 is limit, but
case like this imo checkpatch limit was raised to 100. So vote for this
becoming oneliner.

>  		if (err)
>  			goto out;
>  	}
> @@ -5152,10 +5153,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
>  
>  	ntfs_fix_pre_write(&rh->rhdr, log->page_size);
>  
> -	err = ntfs_sb_write_run(sbi, &ni->file.run, 0, rh, log->page_size);
> +	err = ntfs_sb_write_run(sbi, &ni->file.run, 0, rh, log->page_size, 0);
>  	if (!err)
>  		err = ntfs_sb_write_run(sbi, &log->ni->file.run, log->page_size,
> -					rh, log->page_size);
> +					rh, log->page_size, 0);
>  
>  	kfree(rh);
>  	if (err)
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> index 91e3743e1442..c89a0f5c5ad4 100644
> --- a/fs/ntfs3/fsntfs.c
> +++ b/fs/ntfs3/fsntfs.c
> @@ -1080,7 +1080,7 @@ int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
>  }
>  
>  int ntfs_sb_write_run(struct ntfs_sb_info *sbi, const struct runs_tree *run,
> -		      u64 vbo, const void *buf, size_t bytes)
> +		      u64 vbo, const void *buf, size_t bytes, int sync)
>  {
>  	struct super_block *sb = sbi->sb;
>  	u8 cluster_bits = sbi->cluster_bits;
> @@ -1100,7 +1100,7 @@ int ntfs_sb_write_run(struct ntfs_sb_info *sbi, const struct runs_tree *run,
>  
>  	for (;;) {
>  		u32 op = len < bytes ? len : bytes;
> -		int err = ntfs_sb_write(sb, lbo, op, buf, 0);
> +		int err = ntfs_sb_write(sb, lbo, op, buf, sync);
>  
>  		if (err)
>  			return err;
> @@ -2175,7 +2175,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
>  
>  	/* Write main SDS bucket. */
>  	err = ntfs_sb_write_run(sbi, &ni->file.run, sbi->security.next_off,
> -				d_security, aligned_sec_size);
> +				d_security, aligned_sec_size, 0);
>  
>  	if (err)
>  		goto out;
> @@ -2193,7 +2193,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
>  
>  	/* Write copy SDS bucket. */
>  	err = ntfs_sb_write_run(sbi, &ni->file.run, mirr_off, d_security,
> -				aligned_sec_size);
> +				aligned_sec_size, 0);
>  	if (err)
>  		goto out;
>  
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 187ef6adc9e1..aa519ed4453c 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1593,7 +1593,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  
>  	/* Write non resident data. */
>  	if (nsize) {
> -		err = ntfs_sb_write_run(sbi, &ni->file.run, 0, rp, nsize);
> +		err = ntfs_sb_write_run(sbi, &ni->file.run, 0, rp, nsize, 0);
>  		if (err)
>  			goto out7;
>  	}
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 97e682ebcfb9..a29578fa935b 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -436,7 +436,7 @@ bool al_remove_le(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le);
>  bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
>  		  const __le16 *name, size_t name_len,
>  		  const struct MFT_REF *ref);
> -int al_update(struct ntfs_inode *ni);
> +int al_update(struct ntfs_inode *ni, int sync);
>  static inline size_t al_aligned(size_t size)
>  {
>  	return (size + 1023) & ~(size_t)1023;
> @@ -577,7 +577,7 @@ int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buffer);
>  int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
>  		  const void *buffer, int wait);
>  int ntfs_sb_write_run(struct ntfs_sb_info *sbi, const struct runs_tree *run,
> -		      u64 vbo, const void *buf, size_t bytes);
> +		      u64 vbo, const void *buf, size_t bytes, int sync);
>  struct buffer_head *ntfs_bread_run(struct ntfs_sb_info *sbi,
>  				   const struct runs_tree *run, u64 vbo);
>  int ntfs_read_run_nb(struct ntfs_sb_info *sbi, const struct runs_tree *run,
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 83de1fd3b9c3..210a23979e71 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -444,7 +444,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>  		/* Delete xattr, ATTR_EA */
>  		ni_remove_attr_le(ni, attr, mi, le);
>  	} else if (attr->non_res) {
> -		err = ntfs_sb_write_run(sbi, &ea_run, 0, ea_all, size);
> +		err = ntfs_sb_write_run(sbi, &ea_run, 0, ea_all, size, 0);
>  		if (err)
>  			goto out;
>  	} else {
> -- 
> 2.28.0
