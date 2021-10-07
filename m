Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E1D425CE3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 22:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhJGUHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 16:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJGUHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 16:07:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B97C061570;
        Thu,  7 Oct 2021 13:05:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b20so30161380lfv.3;
        Thu, 07 Oct 2021 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GdrPLxIt+4l06ZDStQvsA9eNQxoPR6Mc0OkW5r/qjY8=;
        b=p9wWC8WOBmLVxXG+FbUgl0PhDa7xdfYn7DfGgt4Za10zeZbuuvI+CDQty+ytKgr051
         bquDTuc/sDoqpnK4MY9dcWDEexn63YrVz9jxD89oADgEfqpGyzy5c0WBR8XaWKxplYrx
         ErN2hIyWcKQTiQ+c7yJIVrjqmVL5dUFaOy47VcntzzfKw1dmAItQ96mPJCSXgi18ysV6
         CftAeWC7DEQJjbwusPWFMf+4QO+wrmx7lLazzvzGGvIbY42Ll+Fkgi2EpYmH9EX1ZclH
         9aWV6wbLFzSK4gLhIYSoNv14I8Y/1lEnQCFFV8oC5I4aLUluC73bTMTo63W0Ez8c5gjJ
         0QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GdrPLxIt+4l06ZDStQvsA9eNQxoPR6Mc0OkW5r/qjY8=;
        b=bBKSbwDR58K9d1nFx+S/Neit8tZu1Gx0cMbwxqK2EhZiVzEaPy+SShHb5tgpYW0bPl
         kAR/wn/e7eUaDVRDrQp/jpjyUVFrvKebAvVdrE9sQIoG002VcoS2NBfbMZU+a7EjiBAF
         ype7M/lgvUFSUIgKuqKU+/0E6VscE1tNBskg6Tq9EiTmnqvYZGdlm7BLm4Y39pNRWU11
         iwvxnvJSjuERh/j3keC9F3EoXQfc3stOIQ20LHEjjeJgijDofKIk7NnPlTFJ7rkkOh8V
         wAu2vkz9/G6hVmrTVdJUP1FrJVe80/SvaTkdgdV19G5e573coX7GE270WdunlhMBnNw+
         Tn6Q==
X-Gm-Message-State: AOAM533uaTKhrYxMz2Fge6QdV9Xzz+fAFSE24/Ggnhw9U2ZYo9+DF4Hz
        gpQ9hAN4aE7pqsdeJL3zWCWWeh4OlbU=
X-Google-Smtp-Source: ABdhPJzB0ke14BsK9NYlXQJnMII/9+HuFG3m7HOBiL19V6hi+2hvZedCWPb3vKY9XyEc7nepBX0gQQ==
X-Received: by 2002:a2e:801a:: with SMTP id j26mr6972454ljg.175.1633637124026;
        Thu, 07 Oct 2021 13:05:24 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id r3sm28081lfc.169.2021.10.07.13.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:05:23 -0700 (PDT)
Date:   Thu, 7 Oct 2021 23:05:21 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mark@harmstone.com
Subject: Re: [PATCH] fs/ntfs3: Remove bothcase variable
Message-ID: <20211007200521.fj7aq5wlppxa7xzw@kari-VirtualBox>
References: <45f2af05-9f5c-bf56-aa91-47d8b0055f5b@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45f2af05-9f5c-bf56-aa91-47d8b0055f5b@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 07, 2021 at 06:37:55PM +0300, Konstantin Komarov wrote:
> bothcase == true when upcase != NULL
> bothcase == false when upcase == NULL
> We don't need to have second variable, that is a copy of upcase.

Can I suggest this one. This way we have three possible state. 

/* Note that NTFS_CASE can also have state CASE_BOTH */
int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
		   const u16 *upcase, enum NTFS_CASE case_cmp)
{
	int diff1 = 0;
	int diff2;
	size_t len = min(l1, l2);

	if (case_cmp == CASE_INSENSITIVE)
		goto case_insentive;

	for (; len; s1++, s2++, len--) {
		diff1 = le16_to_cpu(*s1) - le16_to_cpu(*s2);
		if (diff1) {
			if (case_cmp != CASE_SENSITIVE)
				goto case_insentive;

			return diff1;
		}
	}
	return l1 - l2;

case_insentive:
	for (; len; s1++, s2++, len--) {
		diff2 = upcase_unicode_char(upcase, le16_to_cpu(*s1)) -
			upcase_unicode_char(upcase, le16_to_cpu(*s2));
		if (diff2)
			return diff2;
	}

	diff2 = l1 - l2;
	return diff2 ? diff2 : diff1;
}


It might also be possible to add compile time error for condition

	!upcase && case_cmp != CASE_SENSITIVE

You also wrote [1] this  

On 6.10.2021 17.37 Konstantin Komarov wrote:
>
> There is indeed some dubious code with ntfs_cmp_names_cpu / ntfs_cmp_names.
> We must always compare filenames with bothcase == true.

This I do not understand. If we have upcase and bothcase == false then
it will mean we are comparing case insentive. bothcase was dubious I
admit because with two parameters there could be four state and one of
them did not make any sense. But maybe enum will make it more clear. We
really need 3 different stage.

Your patch cannot actually compare case_insentive at all. Your patch
will compare case_sensitive or case_both. I think we need to also way to
compare case_insentive. I also belive that because bothcase was
everywhere true that it was the real bug. More testing is needed from my
part before I can make sure. I will test this in weekend and also review
other patches.

  Argillander

> 
> Suggested-by: Mark Harmstone <mark@harmstone.com>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/attrlist.c |  8 +++-----
>  fs/ntfs3/frecord.c  |  3 +--
>  fs/ntfs3/index.c    |  6 ++----
>  fs/ntfs3/inode.c    |  2 +-
>  fs/ntfs3/ntfs_fs.h  |  4 ++--
>  fs/ntfs3/record.c   |  2 +-
>  fs/ntfs3/upcase.c   | 18 ++++++------------
>  7 files changed, 16 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
> index bad6d8a849a2..1a31ef4ed92b 100644
> --- a/fs/ntfs3/attrlist.c
> +++ b/fs/ntfs3/attrlist.c
> @@ -194,8 +194,7 @@ struct ATTR_LIST_ENTRY *al_find_ex(struct ntfs_inode *ni,
>  			 * Compare entry names only for entry with vcn == 0.
>  			 */
>  			diff = ntfs_cmp_names(le_name(le), name_len, name,
> -					      name_len, ni->mi.sbi->upcase,
> -					      true);
> +					      name_len, ni->mi.sbi->upcase);
>  			if (diff < 0)
>  				continue;
>  
> @@ -246,8 +245,7 @@ static struct ATTR_LIST_ENTRY *al_find_le_to_insert(struct ntfs_inode *ni,
>  			 * Compare entry names only for entry with vcn == 0.
>  			 */
>  			diff = ntfs_cmp_names(le_name(le), le->name_len, name,
> -					      name_len, ni->mi.sbi->upcase,
> -					      true);
> +					      name_len, ni->mi.sbi->upcase);
>  			if (diff < 0)
>  				continue;
>  
> @@ -393,7 +391,7 @@ bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
>  	if (le->name_len != name_len)
>  		return false;
>  	if (name_len && ntfs_cmp_names(le_name(le), name_len, name, name_len,
> -				       ni->mi.sbi->upcase, true))
> +				       ni->mi.sbi->upcase))
>  		return false;
>  	if (le64_to_cpu(le->vcn) != vcn)
>  		return false;
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 007602badd90..ecf982aca437 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -1589,8 +1589,7 @@ struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
>  	if (uni->len != fname->name_len)
>  		goto next;
>  
> -	if (ntfs_cmp_names_cpu(uni, (struct le_str *)&fname->name_len, NULL,
> -			       false))
> +	if (ntfs_cmp_names_cpu(uni, (struct le_str *)&fname->name_len, NULL))
>  		goto next;
>  
>  	return fname;
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 6f81e3a49abf..a12f6fa0537e 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -38,7 +38,6 @@ static int cmp_fnames(const void *key1, size_t l1, const void *key2, size_t l2,
>  	const struct ntfs_sb_info *sbi = data;
>  	const struct ATTR_FILE_NAME *f1;
>  	u16 fsize2;
> -	bool both_case;
>  
>  	if (l2 <= offsetof(struct ATTR_FILE_NAME, name))
>  		return -1;
> @@ -47,7 +46,6 @@ static int cmp_fnames(const void *key1, size_t l1, const void *key2, size_t l2,
>  	if (l2 < fsize2)
>  		return -1;
>  
> -	both_case = f2->type != FILE_NAME_DOS /*&& !sbi->options.nocase*/;
>  	if (!l1) {
>  		const struct le_str *s2 = (struct le_str *)&f2->name_len;
>  
> @@ -55,12 +53,12 @@ static int cmp_fnames(const void *key1, size_t l1, const void *key2, size_t l2,
>  		 * If names are equal (case insensitive)
>  		 * try to compare it case sensitive.
>  		 */
> -		return ntfs_cmp_names_cpu(key1, s2, sbi->upcase, both_case);
> +		return ntfs_cmp_names_cpu(key1, s2, sbi->upcase);
>  	}
>  
>  	f1 = key1;
>  	return ntfs_cmp_names(f1->name, f1->name_len, f2->name, f2->name_len,
> -			      sbi->upcase, both_case);
> +			      sbi->upcase);
>  }
>  
>  /*
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 7dd162f6a7e2..c7014e5f941c 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -179,7 +179,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>  		names += 1;
>  		if (name && name->len == fname->name_len &&
>  		    !ntfs_cmp_names_cpu(name, (struct le_str *)&fname->name_len,
> -					NULL, false))
> +					NULL))
>  			is_match = true;
>  
>  		goto next_attr;
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 38b7c1a9dc52..859624d0dccb 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -830,9 +830,9 @@ int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range);
>  
>  /* Globals from upcase.c */
>  int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
> -		   const u16 *upcase, bool bothcase);
> +		   const u16 *upcase);
>  int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
> -		       const u16 *upcase, bool bothcase);
> +		       const u16 *upcase);
>  
>  /* globals from xattr.c */
>  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
> diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
> index 861e35791506..6afd3c20b0d3 100644
> --- a/fs/ntfs3/record.c
> +++ b/fs/ntfs3/record.c
> @@ -23,7 +23,7 @@ static inline int compare_attr(const struct ATTRIB *left, enum ATTR_TYPE type,
>  
>  	/* They have the same type code, so we have to compare the names. */
>  	return ntfs_cmp_names(attr_name(left), left->name_len, name, name_len,
> -			      upcase, true);
> +			      upcase);
>  }
>  
>  /*
> diff --git a/fs/ntfs3/upcase.c b/fs/ntfs3/upcase.c
> index b5e8256fd710..c15ae0993839 100644
> --- a/fs/ntfs3/upcase.c
> +++ b/fs/ntfs3/upcase.c
> @@ -24,29 +24,26 @@ static inline u16 upcase_unicode_char(const u16 *upcase, u16 chr)
>  /*
>   * ntfs_cmp_names
>   *
> - * Thanks Kari Argillander <kari.argillander@gmail.com> for idea and implementation 'bothcase'
> + * Thanks Kari Argillander <kari.argillander@gmail.com> for idea and implementation
>   *
>   * Straight way to compare names:
>   * - Case insensitive
> - * - If name equals and 'bothcases' then
> + * - If name equals and 'upcase' then
>   * - Case sensitive
>   * 'Straight way' code scans input names twice in worst case.
>   * Optimized code scans input names only once.
>   */
>  int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
> -		   const u16 *upcase, bool bothcase)
> +		   const u16 *upcase)
>  {
>  	int diff1 = 0;
>  	int diff2;
>  	size_t len = min(l1, l2);
>  
> -	if (!bothcase && upcase)
> -		goto case_insentive;
> -
>  	for (; len; s1++, s2++, len--) {
>  		diff1 = le16_to_cpu(*s1) - le16_to_cpu(*s2);
>  		if (diff1) {
> -			if (bothcase && upcase)
> +			if (upcase)
>  				goto case_insentive;
>  
>  			return diff1;
> @@ -67,7 +64,7 @@ int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
>  }
>  
>  int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
> -		       const u16 *upcase, bool bothcase)
> +		       const u16 *upcase)
>  {
>  	const u16 *s1 = uni1->name;
>  	const __le16 *s2 = uni2->name;
> @@ -77,13 +74,10 @@ int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
>  	int diff1 = 0;
>  	int diff2;
>  
> -	if (!bothcase && upcase)
> -		goto case_insentive;
> -
>  	for (; len; s1++, s2++, len--) {
>  		diff1 = *s1 - le16_to_cpu(*s2);
>  		if (diff1) {
> -			if (bothcase && upcase)
> +			if (upcase)
>  				goto case_insentive;
>  
>  			return diff1;
> -- 
> 2.33.0
> 
