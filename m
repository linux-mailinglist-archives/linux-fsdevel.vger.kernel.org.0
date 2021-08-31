Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E2F3FCF58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 23:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbhHaVzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 17:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhHaVzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 17:55:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E5BC061575;
        Tue, 31 Aug 2021 14:54:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p15so1316337ljn.3;
        Tue, 31 Aug 2021 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yn7kY0+ZqcKBGO15qoxRhkt8dbSMFL2aEpbkJ8qKlBs=;
        b=sBhUYev66r6Hw0CXEulsWJV3qcQHHWDq3LuGfIhcEP3CitVNxR8W6xkKt7PR1AGFUL
         6PyrHhHzktEKT6Zw1BymLkhnuz7AK2TKWBoG4QlZ6Z026CqyOv7DW6gqRPOCpLWmRPnf
         oikY748d4wK2g9xXajZa377RohH7u4qua8Dc2bmnqsbu9i4TlVL4KhDIGXUSxeMhPK38
         cw378VTj4jHJHeuzpBSzgwDsHML74pZhu4Dw2dBWfefahtH3a6BLUoTntg9OY+hyd8/I
         eFEXOdNcqg4JW4/dRbM8a07IonRM7ElwqSDWv/sZR4fxERtFHLWnrinFDgHlcrBF1gf4
         JmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yn7kY0+ZqcKBGO15qoxRhkt8dbSMFL2aEpbkJ8qKlBs=;
        b=CzIVS/he6CZuhi/8PMPoil2qyyV3at07LMxINHhzQx4BqHQNRreiAmzb5EDYjIhu39
         CLToSb92tnDLiQxtMBCaeoonmL0RKz3zKOYlrUDLB95mclfbZWNLz6BMYwhPwBYXxBOO
         hLsjmPj4Z0gG6z3tJlhBmzlMPqSjRwFXTBuhe/a+ClGCQR1YdmBuRvQNv/W9djdzkwzw
         FSDnDj5wADF9a4kGmDUlWpTXztikmhrKGW+otZMXNbksOhWL7gQbD+8tf7icI6r3H4oc
         7LNPFOyGES2/hZwNT2fkqclqQm3nt0rbXCtPlVSCE4W1M5BysJhlwbDsnwEy2w5AqmrT
         71EQ==
X-Gm-Message-State: AOAM530KnEOFDAkPkxwZHRAdYkI9p5K0fJXivw/5TCwkKks/kcVcNzMc
        oHGv+GyZUtXheXsnp9uyzGo=
X-Google-Smtp-Source: ABdhPJwZIXdw534TKgicftioA1y7MnVrNKUqU0fXKmWN2t3IARik7ZGJVBH4QSt4rtlXSqbwqEs0YA==
X-Received: by 2002:a2e:bd06:: with SMTP id n6mr26881012ljq.52.1630446853085;
        Tue, 31 Aug 2021 14:54:13 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id j13sm1837259lfu.214.2021.08.31.14.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 14:54:12 -0700 (PDT)
Date:   Wed, 1 Sep 2021 00:54:10 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Rework file operations
Message-ID: <20210831215410.wkolls3jvev2rebk@kari-VirtualBox>
References: <c076bd59-64b1-149b-3a23-5e89a77b7795@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c076bd59-64b1-149b-3a23-5e89a77b7795@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

First of this commit is already in ntfs3/master without review. Please
do not do that. We are middle of merge window and new this kind of patch
is in.

This patch does also lot of refactoring, dead code removel, maybe some
bug fixes and who knows what else. One patch should address only one
thing.  I did not review whole thing but some comments there.  I also
feel like this is kinda impossible to review because so much happening.
This is over 2000 lines long patch.  Do you want to review this kind of
patches yourself? I cc also fsdevel, maybe someone can help us little
bit.

Partial review starts here:

sfr@canb.auug.org.au
^^
There is this same cc. Accident?

Subject: [PATCH] fs/ntfs3: Rework file operations

^^ Not very informative commit header

Maybe better should be:
Change rename logic to add new name and then remove old one 


Please also use at least checkpatch. It found three warnings with this
patch.

On Tue, Aug 31, 2021 at 07:34:28PM +0300, Konstantin Komarov wrote:
> Rename now works "Add new name and remove old name".
> "Remove old name and add new name" may result in bad inode
> if we can't add new name and then can't restore (add) old name.

Also little hard to read commit message. Let me help a little bit. 
Maybe something like (not checked your patch yet):

Current rename logic is that we first remove old name and then add new
name.  This can result bad inode if there is situation that when we add
new name and it fails we have no option to return old one.

Change behavier so that we first try to add new name and only after that
we delete old one.

> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/attrib.c   |  17 +--
>  fs/ntfs3/attrlist.c |  26 ++--
>  fs/ntfs3/frecord.c  | 342 ++++++++++++++++++++++++++++++++++++--------
>  fs/ntfs3/fsntfs.c   |  87 +++++------
>  fs/ntfs3/index.c    |  45 +++---
>  fs/ntfs3/inode.c    | 275 ++++++++++++-----------------------
>  fs/ntfs3/namei.c    | 236 ++++++++----------------------
>  fs/ntfs3/ntfs_fs.h  |  31 +++-
>  fs/ntfs3/record.c   |   8 +-
>  fs/ntfs3/xattr.c    |  25 ++--
>  10 files changed, 563 insertions(+), 529 deletions(-)
> 
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> index 4b285f704e62..ffc323bacc9f 100644
> --- a/fs/ntfs3/attrib.c
> +++ b/fs/ntfs3/attrib.c
> @@ -218,9 +218,11 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
>  	}
>  
>  out:
> -	/* Undo. */
> -	run_deallocate_ex(sbi, run, vcn0, vcn - vcn0, NULL, false);
> -	run_truncate(run, vcn0);
> +	/* Undo 'ntfs_look_for_free_space' */
> +	if (vcn - vcn0) {
> +		run_deallocate_ex(sbi, run, vcn0, vcn - vcn0, NULL, false);
> +		run_truncate(run, vcn0);
> +	}

Can this happend for both goto out paths? If not then other should
return err straight away. 

>  
>  	return err;
>  }
> @@ -701,7 +703,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  			 * (list entry for std attribute always first).
>  			 * So it is safe to step back.
>  			 */
> -			mi_remove_attr(mi, attr);
> +			mi_remove_attr(NULL, mi, attr);
>  
>  			if (!al_remove_le(ni, le)) {
>  				err = -EINVAL;
> @@ -1004,7 +1006,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
>  			end = next_svcn;
>  		while (end > evcn) {
>  			/* Remove segment [svcn : evcn). */
> -			mi_remove_attr(mi, attr);
> +			mi_remove_attr(NULL, mi, attr);
>  
>  			if (!al_remove_le(ni, le)) {
>  				err = -EINVAL;
> @@ -1600,7 +1602,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
>  			end = next_svcn;
>  		while (end > evcn) {
>  			/* Remove segment [svcn : evcn). */
> -			mi_remove_attr(mi, attr);
> +			mi_remove_attr(NULL, mi, attr);
>  
>  			if (!al_remove_le(ni, le)) {
>  				err = -EINVAL;
> @@ -1836,13 +1838,12 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
>  			u16 le_sz;
>  			u16 roff = le16_to_cpu(attr->nres.run_off);
>  
> -			/* run==1 means unpack and deallocate. */

What's whit this one? Old comment maybe but should not be addressed with
this patch.

>  			run_unpack_ex(RUN_DEALLOCATE, sbi, ni->mi.rno, svcn,
>  				      evcn1 - 1, svcn, Add2Ptr(attr, roff),
>  				      le32_to_cpu(attr->size) - roff);
>  
>  			/* Delete this attribute segment. */
> -			mi_remove_attr(mi, attr);
> +			mi_remove_attr(NULL, mi, attr);
>  			if (!le)
>  				break;
>  
> diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
> index 32ca990af64b..fa32399eb517 100644
> --- a/fs/ntfs3/attrlist.c
> +++ b/fs/ntfs3/attrlist.c
> @@ -279,7 +279,7 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
>  	struct ATTR_LIST_ENTRY *le;
>  	size_t off;
>  	u16 sz;
> -	size_t asize, new_asize;
> +	size_t asize, new_asize, old_size;
>  	u64 new_size;
>  	typeof(ni->attr_list) *al = &ni->attr_list;
>  
> @@ -287,8 +287,9 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
>  	 * Compute the size of the new 'le'
>  	 */
>  	sz = le_size(name_len);
> -	new_size = al->size + sz;
> -	asize = al_aligned(al->size);
> +	old_size = al->size;
> +	asize = al_aligned(old_size);
>  	new_asize = al_aligned(new_size);
>  
>  	/* Scan forward to the point at which the new 'le' should be inserted. */
> @@ -302,13 +303,14 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
>  			return -ENOMEM;
>  
>  		memcpy(ptr, al->le, off);
> -		memcpy(Add2Ptr(ptr, off + sz), le, al->size - off);
> +		memcpy(Add2Ptr(ptr, off + sz), le, old_size - off);
>  		le = Add2Ptr(ptr, off);
>  		kfree(al->le);
>  		al->le = ptr;
>  	} else {
> -		memmove(Add2Ptr(le, sz), le, al->size - off);
> +		memmove(Add2Ptr(le, sz), le, old_size - off);
>  	}
> +	*new_le = le;
>  
>  	al->size = new_size;
>  
> @@ -321,23 +323,25 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
>  	le->id = id;
>  	memcpy(le->name, name, sizeof(short) * name_len);
>  
> -	al->dirty = true;
> -
>  	err = attr_set_size(ni, ATTR_LIST, NULL, 0, &al->run, new_size,
>  			    &new_size, true, &attr);
> -	if (err)
> +	if (err) {
> +		/* Undo memmove above. */

There is path also for memcpy. What if we go there. Is this path then
impossible? Just checking.

> +		memmove(le, Add2Ptr(le, sz), old_size - off);
> +		al->size = old_size;
>  		return err;
> +	}
> +
> +	al->dirty = true;
>  
>  	if (attr && attr->non_res) {
>  		err = ntfs_sb_write_run(ni->mi.sbi, &al->run, 0, al->le,
>  					al->size);
>  		if (err)
>  			return err;
> +		al->dirty = false;
>  	}
>  
> -	al->dirty = false;
> -	*new_le = le;
> -
>  	return 0;
>  }
>  
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 9d374827750b..3f48b612ec96 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -163,7 +163,7 @@ int ni_load_mi_ex(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
>  /*
>   * ni_load_mi - Load mft_inode corresponded list_entry.
>   */
> -int ni_load_mi(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
> +int ni_load_mi(struct ntfs_inode *ni, const struct ATTR_LIST_ENTRY *le,
>  	       struct mft_inode **mi)

Feels like unnecesary change for this patch.

>  {
>  	CLST rno;
> @@ -402,7 +402,7 @@ int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  		if (!attr)
>  			return -ENOENT;
>  
> -		mi_remove_attr(&ni->mi, attr);
> +		mi_remove_attr(ni, &ni->mi, attr);
>  		return 0;
>  	}
>  
> @@ -441,7 +441,7 @@ int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  		if (!attr)
>  			return -ENOENT;
>  
> -		mi_remove_attr(mi, attr);
> +		mi_remove_attr(ni, mi, attr);
>  
>  		if (PtrOffset(ni->attr_list.le, le) >= ni->attr_list.size)
>  			return 0;
> @@ -454,12 +454,11 @@ int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
>   *
>   * Return: Not full constructed attribute or NULL if not possible to create.
>   */
> -static struct ATTRIB *ni_ins_new_attr(struct ntfs_inode *ni,
> -				      struct mft_inode *mi,
> -				      struct ATTR_LIST_ENTRY *le,
> -				      enum ATTR_TYPE type, const __le16 *name,
> -				      u8 name_len, u32 asize, u16 name_off,
> -				      CLST svcn)
> +static struct ATTRIB *
> +ni_ins_new_attr(struct ntfs_inode *ni, struct mft_inode *mi,
> +		struct ATTR_LIST_ENTRY *le, enum ATTR_TYPE type,
> +		const __le16 *name, u8 name_len, u32 asize, u16 name_off,
> +		CLST svcn, struct ATTR_LIST_ENTRY **ins_le)

Reviewing would be lot lot easier if you make one patch which just adds
this new ins_le to every function needed. Just call it with NULL. Then
there would be much less noise to watch.

>  {
>  	int err;
>  	struct ATTRIB *attr;
> @@ -507,6 +506,8 @@ static struct ATTRIB *ni_ins_new_attr(struct ntfs_inode *ni,
>  	le->ref = ref;
>  
>  out:
> +	if (ins_le)
> +		*ins_le = le;
>  	return attr;
>  }
>  
> @@ -599,7 +600,7 @@ static int ni_repack(struct ntfs_inode *ni)
>  		if (next_svcn >= evcn + 1) {
>  			/* We can remove this attribute segment. */
>  			al_remove_le(ni, le);
> -			mi_remove_attr(mi, attr);
> +			mi_remove_attr(NULL, mi, attr);
>  			le = le_p;
>  			continue;
>  		}
> @@ -695,8 +696,8 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
>  		free -= asize;
>  	}
>  
> -	/* Is seems that attribute list can be removed from primary record. */
> -	mi_remove_attr(&ni->mi, attr_list);
> +	/* It seems that attribute list can be removed from primary record. */
> +	mi_remove_attr(NULL, &ni->mi, attr_list);
>  
>  	/*
>  	 * Repeat the cycle above and move all attributes to primary record.
> @@ -724,7 +725,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
>  		attr_ins->id = id;
>  
>  		/* Remove from original record. */
> -		mi_remove_attr(mi, attr);
> +		mi_remove_attr(NULL, mi, attr);
>  	}
>  
>  	run_deallocate(sbi, &ni->attr_list.run, true);
> @@ -842,7 +843,8 @@ int ni_create_attr_list(struct ntfs_inode *ni)
>  		memcpy(attr, b, asize);
>  		attr->id = le_b[nb]->id;
>  
> -		WARN_ON(!mi_remove_attr(&ni->mi, b));
> +		/* Remove from primary record. */
> +		WARN_ON(!mi_remove_attr(NULL, &ni->mi, b));
>  
>  		if (to_free <= asize)
>  			break;
> @@ -883,7 +885,8 @@ int ni_create_attr_list(struct ntfs_inode *ni)
>  static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
>  			   enum ATTR_TYPE type, const __le16 *name, u8 name_len,
>  			   u32 asize, CLST svcn, u16 name_off, bool force_ext,
> -			   struct ATTRIB **ins_attr, struct mft_inode **ins_mi)
> +			   struct ATTRIB **ins_attr, struct mft_inode **ins_mi,
> +			   struct ATTR_LIST_ENTRY **ins_le)
>  {
>  	struct ATTRIB *attr;
>  	struct mft_inode *mi;
> @@ -956,12 +959,14 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
>  
>  		/* Try to insert attribute into this subrecord. */
>  		attr = ni_ins_new_attr(ni, mi, le, type, name, name_len, asize,
> -				       name_off, svcn);
> +				       name_off, svcn, ins_le);
>  		if (!attr)
>  			continue;
>  
>  		if (ins_attr)
>  			*ins_attr = attr;
> +		if (ins_mi)
> +			*ins_mi = mi;
>  		return 0;
>  	}
>  
> @@ -977,7 +982,7 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
>  	}
>  
>  	attr = ni_ins_new_attr(ni, mi, le, type, name, name_len, asize,
> -			       name_off, svcn);
> +			       name_off, svcn, ins_le);
>  	if (!attr)
>  		goto out2;
>  
> @@ -1016,7 +1021,8 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
>  static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  			  const __le16 *name, u8 name_len, u32 asize,
>  			  u16 name_off, CLST svcn, struct ATTRIB **ins_attr,
> -			  struct mft_inode **ins_mi)
> +			  struct mft_inode **ins_mi,
> +			  struct ATTR_LIST_ENTRY **ins_le)
>  {
>  	struct ntfs_sb_info *sbi = ni->mi.sbi;
>  	int err;
> @@ -1045,7 +1051,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  
>  	if (asize <= free) {
>  		attr = ni_ins_new_attr(ni, &ni->mi, NULL, type, name, name_len,
> -				       asize, name_off, svcn);
> +				       asize, name_off, svcn, ins_le);
>  		if (attr) {
>  			if (ins_attr)
>  				*ins_attr = attr;
> @@ -1059,7 +1065,8 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  	if (!is_mft || type != ATTR_DATA || svcn) {
>  		/* This ATTRIB will be external. */
>  		err = ni_ins_attr_ext(ni, NULL, type, name, name_len, asize,
> -				      svcn, name_off, false, ins_attr, ins_mi);
> +				      svcn, name_off, false, ins_attr, ins_mi,
> +				      ins_le);
>  		goto out;
>  	}
>  
> @@ -1117,7 +1124,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  		t16 = le16_to_cpu(attr->name_off);
>  		err = ni_ins_attr_ext(ni, le, attr->type, Add2Ptr(attr, t16),
>  				      attr->name_len, t32, attr_svcn(attr), t16,
> -				      false, &eattr, NULL);
> +				      false, &eattr, NULL, NULL);
>  		if (err)
>  			return err;
>  
> @@ -1125,8 +1132,8 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  		memcpy(eattr, attr, t32);
>  		eattr->id = id;
>  
> -		/* Remove attrib from primary record. */
> -		mi_remove_attr(&ni->mi, attr);
> +		/* Remove from primary record. */
> +		mi_remove_attr(NULL, &ni->mi, attr);
>  
>  		/* attr now points to next attribute. */
>  		if (attr->type == ATTR_END)
> @@ -1136,7 +1143,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  		;
>  
>  	attr = ni_ins_new_attr(ni, &ni->mi, NULL, type, name, name_len, asize,
> -			       name_off, svcn);
> +			       name_off, svcn, ins_le);
>  	if (!attr) {
>  		err = -EINVAL;
>  		goto out;
> @@ -1251,7 +1258,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
>  	 */
>  	attr = ni_ins_new_attr(ni, mi_min, NULL, ATTR_DATA, NULL, 0,
>  			       SIZEOF_NONRESIDENT + run_size,
> -			       SIZEOF_NONRESIDENT, svcn);
> +			       SIZEOF_NONRESIDENT, svcn, NULL);
>  	if (!attr) {
>  		err = -EINVAL;
>  		goto out;
> @@ -1315,14 +1322,15 @@ int ni_expand_list(struct ntfs_inode *ni)
>  		err = ni_ins_attr_ext(ni, le, attr->type, attr_name(attr),
>  				      attr->name_len, asize, attr_svcn(attr),
>  				      le16_to_cpu(attr->name_off), true,
> -				      &ins_attr, NULL);
> +				      &ins_attr, NULL, NULL);
>  
>  		if (err)
>  			goto out;
>  
>  		memcpy(ins_attr, attr, asize);
>  		ins_attr->id = le->id;
> -		mi_remove_attr(&ni->mi, attr);
> +		/* Remove from primary record. */
> +		mi_remove_attr(NULL, &ni->mi, attr);
>  
>  		done += asize;
>  		goto out;
> @@ -1382,7 +1390,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  	}
>  
>  	err = ni_insert_attr(ni, type, name, name_len, asize, name_off, svcn,
> -			     &attr, mi);
> +			     &attr, mi, NULL);
>  
>  	if (err)
>  		goto out;
> @@ -1422,7 +1430,8 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
>   */
>  int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
>  		       enum ATTR_TYPE type, const __le16 *name, u8 name_len,
> -		       struct ATTRIB **new_attr, struct mft_inode **mi)
> +		       struct ATTRIB **new_attr, struct mft_inode **mi,
> +		       struct ATTR_LIST_ENTRY **le)
>  {
>  	int err;
>  	u32 name_size = ALIGN(name_len * sizeof(short), 8);
> @@ -1430,7 +1439,7 @@ int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
>  	struct ATTRIB *attr;
>  
>  	err = ni_insert_attr(ni, type, name, name_len, asize, SIZEOF_RESIDENT,
> -			     0, &attr, mi);
> +			     0, &attr, mi, le);
>  	if (err)
>  		return err;
>  
> @@ -1439,8 +1448,13 @@ int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
>  
>  	attr->res.data_size = cpu_to_le32(data_size);
>  	attr->res.data_off = cpu_to_le16(SIZEOF_RESIDENT + name_size);
> -	if (type == ATTR_NAME)
> +	if (type == ATTR_NAME) {
>  		attr->res.flags = RESIDENT_FLAG_INDEXED;
> +
> +		/* is_attr_indexed(attr)) == true */
> +		le16_add_cpu(&ni->mi.mrec->hard_links, +1);
> +		ni->mi.dirty = true;
> +	}
>  	attr->res.res = 0;
>  
>  	if (new_attr)
> @@ -1452,22 +1466,13 @@ int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
>  /*
>   * ni_remove_attr_le - Remove attribute from record.
>   */
> -int ni_remove_attr_le(struct ntfs_inode *ni, struct ATTRIB *attr,
> -		      struct ATTR_LIST_ENTRY *le)
> +void ni_remove_attr_le(struct ntfs_inode *ni, struct ATTRIB *attr,
> +		       struct mft_inode *mi, struct ATTR_LIST_ENTRY *le)
>  {
> -	int err;
> -	struct mft_inode *mi;
> -
> -	err = ni_load_mi(ni, le, &mi);
> -	if (err)
> -		return err;
> -
> -	mi_remove_attr(mi, attr);
> +	mi_remove_attr(ni, mi, attr);
>  
>  	if (le)
>  		al_remove_le(ni, le);
> -
> -	return 0;
>  }
>  
>  /*
> @@ -1549,10 +1554,12 @@ int ni_delete_all(struct ntfs_inode *ni)
>  
>  /* ni_fname_name
>   *
> - *Return: File name attribute by its value. */
> + * Return: File name attribute by its value.
> + */
>  struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
>  				     const struct cpu_str *uni,
>  				     const struct MFT_REF *home_dir,
> +				     struct mft_inode **mi,
>  				     struct ATTR_LIST_ENTRY **le)
>  {
>  	struct ATTRIB *attr = NULL;
> @@ -1562,7 +1569,7 @@ struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
>  
>  	/* Enumerate all names. */
>  next:
> -	attr = ni_find_attr(ni, attr, le, ATTR_NAME, NULL, 0, NULL, NULL);
> +	attr = ni_find_attr(ni, attr, le, ATTR_NAME, NULL, 0, NULL, mi);
>  	if (!attr)
>  		return NULL;
>  
> @@ -1592,6 +1599,7 @@ struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
>   * Return: File name attribute with given type.
>   */
>  struct ATTR_FILE_NAME *ni_fname_type(struct ntfs_inode *ni, u8 name_type,
> +				     struct mft_inode **mi,
>  				     struct ATTR_LIST_ENTRY **le)
>  {
>  	struct ATTRIB *attr = NULL;
> @@ -1599,10 +1607,12 @@ struct ATTR_FILE_NAME *ni_fname_type(struct ntfs_inode *ni, u8 name_type,
>  
>  	*le = NULL;
>  
> +	if (FILE_NAME_POSIX == name_type)
> +		return NULL;
> +
>  	/* Enumerate all names. */
>  	for (;;) {
> -		attr = ni_find_attr(ni, attr, le, ATTR_NAME, NULL, 0, NULL,
> -				    NULL);
> +		attr = ni_find_attr(ni, attr, le, ATTR_NAME, NULL, 0, NULL, mi);
>  		if (!attr)
>  			return NULL;
>  
> @@ -2788,6 +2798,222 @@ int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
>  	return err;
>  }
>  
> +/*
> + * ni_remove_name - Removes name 'de' from MFT and from directory.
> + * 'de2' and 'undo_step' are used to restore MFT/dir, if error occurs.
> + */
> +int ni_remove_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
> +		   struct NTFS_DE *de, struct NTFS_DE **de2, int *undo_step)
> +{
> +	int err;
> +	struct ntfs_sb_info *sbi = ni->mi.sbi;
> +	struct ATTR_FILE_NAME *de_name = (struct ATTR_FILE_NAME *)(de + 1);
> +	struct ATTR_FILE_NAME *fname;
> +	struct ATTR_LIST_ENTRY *le;
> +	struct mft_inode *mi;
> +	u16 de_key_size = le16_to_cpu(de->key_size);
> +	u8 name_type;
> +
> +	*undo_step = 0;

It looks to me that this function can make undo by itself. There is no
need for ni_remove_name_undo. This looks very strange way to do this.

One other way if really needed is also to use return value, but this
pointer undo_step feels just wrong. 

> +
> +	/* Find name in record. */
> +	mi_get_ref(&dir_ni->mi, &de_name->home);
> +
> +	fname = ni_fname_name(ni, (struct cpu_str *)&de_name->name_len,
> +			      &de_name->home, &mi, &le);
> +	if (!fname)
> +		return -ENOENT;
> +
> +	memcpy(&de_name->dup, &fname->dup, sizeof(struct NTFS_DUP_INFO));
> +	name_type = paired_name(fname->type);
> +
> +	/* Mark ntfs as dirty. It will be cleared at umount. */
> +	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
> +
> +	/* Step 1: Remove name from directory. */
> +	err = indx_delete_entry(&dir_ni->dir, dir_ni, fname, de_key_size, sbi);
> +	if (err)
> +		return err;
> +
> +	/* Step 2: Remove name from MFT. */
> +	ni_remove_attr_le(ni, attr_from_name(fname), mi, le);
> +
> +	*undo_step = 2;
> +
> +	/* Get paired name. */
> +	fname = ni_fname_type(ni, name_type, &mi, &le);

It does not feel right that ni_fname_type does not return anything if
name_type is FILE_NAME_POSIX. It can do it right? Why won't we check
before ni_fname_type call if name_type == FILE_NAME_POSIX and just exit
with return 0 if it is.

> +	if (fname) {
> +		u16 de2_key_size = fname_full_size(fname);
> +
> +		*de2 = Add2Ptr(de, 1024);
> +		(*de2)->key_size = cpu_to_le16(de2_key_size);
> +
> +		memcpy(*de2 + 1, fname, de2_key_size);
> +
> +		/* Step 3: Remove paired name from directory. */
> +		err = indx_delete_entry(&dir_ni->dir, dir_ni, fname,
> +					de2_key_size, sbi);
> +		if (err)
> +			return err;
> +
> +		/* Step 4: Remove paired name from MFT. */
> +		ni_remove_attr_le(ni, attr_from_name(fname), mi, le);
> +
> +		*undo_step = 4;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * ni_remove_name_undo - Paired function for ni_remove_name.
> + *
> + * Return: True if ok
> + */
> +bool ni_remove_name_undo(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
> +			 struct NTFS_DE *de, struct NTFS_DE *de2, int undo_step)
> +{
> +	struct ntfs_sb_info *sbi = ni->mi.sbi;
> +	struct ATTRIB *attr;
> +	u16 de_key_size = de2 ? le16_to_cpu(de2->key_size) : 0;
> +
> +	switch (undo_step) {
> +	case 4:
> +		if (ni_insert_resident(ni, de_key_size, ATTR_NAME, NULL, 0,
> +				       &attr, NULL, NULL)) {
> +			return false;
> +		}
> +		memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), de2 + 1, de_key_size);
> +
> +		mi_get_ref(&ni->mi, &de2->ref);
> +		de2->size = cpu_to_le16(ALIGN(de_key_size, 8) +
> +					sizeof(struct NTFS_DE));
> +		de2->flags = 0;
> +		de2->res = 0;
> +
> +		if (indx_insert_entry(&dir_ni->dir, dir_ni, de2, sbi, NULL,
> +				      1)) {
> +			return false;
> +		}
> +		fallthrough;
> +
> +	case 2:
> +		de_key_size = le16_to_cpu(de->key_size);
> +
> +		if (ni_insert_resident(ni, de_key_size, ATTR_NAME, NULL, 0,
> +				       &attr, NULL, NULL)) {
> +			return false;
> +		}
> +
> +		memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), de + 1, de_key_size);
> +		mi_get_ref(&ni->mi, &de->ref);
> +
> +		if (indx_insert_entry(&dir_ni->dir, dir_ni, de, sbi, NULL, 1)) {
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * ni_add_name - Add new name in MFT and in directory.

*to would be better? Also in comments.

> + */
> +int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
> +		struct NTFS_DE *de)
> +{
> +	int err;
> +	struct ATTRIB *attr;
> +	struct ATTR_LIST_ENTRY *le;
> +	struct mft_inode *mi;
> +	struct ATTR_FILE_NAME *de_name = (struct ATTR_FILE_NAME *)(de + 1);
> +	u16 de_key_size = le16_to_cpu(de->key_size);
> +
> +	mi_get_ref(&ni->mi, &de->ref);
> +	mi_get_ref(&dir_ni->mi, &de_name->home);
> +
> +	/* Insert new name in MFT. */
> +	err = ni_insert_resident(ni, de_key_size, ATTR_NAME, NULL, 0, &attr,
> +				 &mi, &le);
> +	if (err)
> +		return err;
> +
> +	memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), de_name, de_key_size);
> +
> +	/* Insert new name in directory. */
> +	err = indx_insert_entry(&dir_ni->dir, dir_ni, de, ni->mi.sbi, NULL, 0);
> +	if (err)
> +		ni_remove_attr_le(ni, attr, mi, le);
> +
> +	return err;
> +}
> +
> +/*
> + * ni_rename - Remove one name and insert new name.
> + */
> +int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
> +	      struct ntfs_inode *ni, struct NTFS_DE *de, struct NTFS_DE *new_de,
> +	      bool *is_bad)
> +{
> +	int err;
> +	struct NTFS_DE *de2 = NULL;
> +	int undo = 0;
> +
> +	/*
> +	 * There are two possible ways to rename:
> +	 * 1) Add new name and remove old name.
> +	 * 2) Remove old name and add new name.
> +	 *
> +	 * In most cases (not all!) adding new name in MFT and in directory can
> +	 * allocate additional cluster(s).
> +	 * Second way may result to bad inode if we can't add new name
> +	 * and then can't restore (add) old name.
> +	 */
> +
> +	/*
> +	 * Way 1 - Add new + remove old.
> +	 */

Way too big comment for thing this small.

> +	err = ni_add_name(new_dir_ni, ni, new_de);

if (err)
	return err;

> +	if (!err) {
> +		err = ni_remove_name(dir_ni, ni, de, &de2, &undo);
> +		if (err && ni_remove_name(new_dir_ni, ni, new_de, &de2, &undo))
> +			*is_bad = true;

Maybe we can return errno or 1 here. is_bad is again imo little
unnecessary here. And now that I think this maybe this should be in
caller site in ntfs_rename. 

> +	}
> +
> +	/*
> +	 * Way 2 - Remove old + add new.
> +	 */
> +	/*
> +	 *	err = ni_remove_name(dir_ni, ni, de, &de2, &undo);
> +	 *	if (!err) {
> +	 *		err = ni_add_name(new_dir_ni, ni, new_de);
> +	 *		if (err && !ni_remove_name_undo(dir_ni, ni, de, de2, undo))
> +	 *			*is_bad = true;
> +	 *	}
> +	 */
> +
> +	return err;
> +}
> +
> +/*
> + * ni_is_dirty - Return: True if 'ni' requires ni_write_inode.
> + */
> +bool ni_is_dirty(struct inode *inode)
> +{
> +	struct ntfs_inode *ni = ntfs_i(inode);
> +	struct rb_node *node;
> +
> +	if (ni->mi.dirty || ni->attr_list.dirty ||
> +	    (ni->ni_flags & NI_FLAG_UPDATE_PARENT))

No need to save space here. Just another if statment for third one.

> +		return true;
> +
> +	for (node = rb_first(&ni->mi_tree); node; node = rb_next(node)) {
> +		if (rb_entry(node, struct mft_inode, node)->dirty)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * ni_update_parent
>   *
> @@ -2802,8 +3028,6 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
>  	struct ntfs_sb_info *sbi = ni->mi.sbi;
>  	struct super_block *sb = sbi->sb;
>  	bool re_dirty = false;
> -	bool active = sb->s_flags & SB_ACTIVE;
> -	bool upd_parent = ni->ni_flags & NI_FLAG_UPDATE_PARENT;
>  
>  	if (ni->mi.mrec->flags & RECORD_FLAG_DIR) {
>  		dup->fa |= FILE_ATTRIBUTE_DIRECTORY;
> @@ -2867,19 +3091,9 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
>  		struct ATTR_FILE_NAME *fname;
>  
>  		fname = resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
> -		if (!fname)
> +		if (!fname || !memcmp(&fname->dup, dup, sizeof(fname->dup)))
>  			continue;
>  
> -		if (memcmp(&fname->dup, dup, sizeof(fname->dup))) {
> -			memcpy(&fname->dup, dup, sizeof(fname->dup));
> -			mi->dirty = true;
> -		} else if (!upd_parent) {
> -			continue;
> -		}
> -
> -		if (!active)
> -			continue; /* Avoid __wait_on_freeing_inode(inode); */
> -
>  		/* ntfs_iget5 may sleep. */
>  		dir = ntfs_iget5(sb, &fname->home, NULL);
>  		if (IS_ERR(dir)) {
> @@ -2898,6 +3112,8 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
>  			} else {
>  				indx_update_dup(dir_ni, sbi, fname, dup, sync);
>  				ni_unlock(dir_ni);
> +				memcpy(&fname->dup, dup, sizeof(fname->dup));
> +				mi->dirty = true;
>  			}
>  		}
>  		iput(dir);
> @@ -2969,7 +3185,9 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
>  			ni->mi.dirty = true;
>  
>  		if (!ntfs_is_meta_file(sbi, inode->i_ino) &&
> -		    (modified || (ni->ni_flags & NI_FLAG_UPDATE_PARENT))) {
> +		    (modified || (ni->ni_flags & NI_FLAG_UPDATE_PARENT))
> +		    /* Avoid __wait_on_freeing_inode(inode). */
> +		    && (sb->s_flags & SB_ACTIVE)) {
>  			dup.cr_time = std->cr_time;
>  			/* Not critical if this function fail. */
>  			re_dirty = ni_update_parent(ni, &dup, sync);
> @@ -3033,7 +3251,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
>  		return err;
>  	}
>  
> -	if (re_dirty && (sb->s_flags & SB_ACTIVE))
> +	if (re_dirty)
>  		mark_inode_dirty_sync(inode);
>  
>  	return 0;
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> index 0edb95ed9717..669249439217 100644
> --- a/fs/ntfs3/fsntfs.c
> +++ b/fs/ntfs3/fsntfs.c
> @@ -358,29 +358,25 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
>  			     enum ALLOCATE_OPT opt)
>  {
>  	int err;
> +	CLST alen = 0;
>  	struct super_block *sb = sbi->sb;
> -	size_t a_lcn, zlen, zeroes, zlcn, zlen2, ztrim, new_zlen;
> +	size_t alcn, zlen, zeroes, zlcn, zlen2, ztrim, new_zlen;
>  	struct wnd_bitmap *wnd = &sbi->used.bitmap;
>  
>  	down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
>  	if (opt & ALLOCATE_MFT) {
> -		CLST alen;
> -
>  		zlen = wnd_zone_len(wnd);
>  
>  		if (!zlen) {
>  			err = ntfs_refresh_zone(sbi);
>  			if (err)
>  				goto out;

Before we return this error code. Now we return -ENOSPC if this error.

> -
>  			zlen = wnd_zone_len(wnd);
> +		}
>  
> -			if (!zlen) {
> -				ntfs_err(sbi->sb,
> -					 "no free space to extend mft");
> -				err = -ENOSPC;
> -				goto out;
> -			}
> +		if (!zlen) {
> +			ntfs_err(sbi->sb, "no free space to extend mft");
> +			goto out;

This is just refactoring and should do in different patch.

>  		}
>  
>  		lcn = wnd_zone_bit(wnd);
> @@ -389,14 +385,13 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
>  		wnd_zone_set(wnd, lcn + alen, zlen - alen);
>  
>  		err = wnd_set_used(wnd, lcn, alen);
> -		if (err)
> -			goto out;
> -
> -		*new_lcn = lcn;
> -		*new_len = alen;
> -		goto ok;
> +		if (err) {
> +			up_write(&wnd->rw_lock);
> +			return err;
> +		}
> +		alcn = lcn;
> +		goto out;
>  	}
> -
>  	/*
>  	 * 'Cause cluster 0 is always used this value means that we should use
>  	 * cached value of 'next_free_lcn' to improve performance.
> @@ -407,22 +402,17 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
>  	if (lcn >= wnd->nbits)
>  		lcn = 0;
>  
> -	*new_len = wnd_find(wnd, len, lcn, BITMAP_FIND_MARK_AS_USED, &a_lcn);
> -	if (*new_len) {
> -		*new_lcn = a_lcn;
> -		goto ok;
> -	}
> +	alen = wnd_find(wnd, len, lcn, BITMAP_FIND_MARK_AS_USED, &alcn);
> +	if (alen)
> +		goto out;
>  
>  	/* Try to use clusters from MftZone. */
>  	zlen = wnd_zone_len(wnd);
>  	zeroes = wnd_zeroes(wnd);
>  
> -	/* Check too big request. */
> -	if (len > zeroes + zlen)
> -		goto no_space;
> -
> -	if (zlen <= NTFS_MIN_MFT_ZONE)
> -		goto no_space;
> +	/* Check too big request */
> +	if (len > zeroes + zlen || zlen <= NTFS_MIN_MFT_ZONE)
> +		goto out;
>  
>  	/* How many clusters to cat from zone. */
>  	zlcn = wnd_zone_bit(wnd);
> @@ -439,31 +429,24 @@ int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
>  	wnd_zone_set(wnd, zlcn, new_zlen);
>  
>  	/* Allocate continues clusters. */
> -	*new_len =
> -		wnd_find(wnd, len, 0,
> -			 BITMAP_FIND_MARK_AS_USED | BITMAP_FIND_FULL, &a_lcn);
> -	if (*new_len) {
> -		*new_lcn = a_lcn;
> -		goto ok;
> -	}
> -
> -no_space:
> -	up_write(&wnd->rw_lock);
> -
> -	return -ENOSPC;
> -
> -ok:
> -	err = 0;
> +	alen = wnd_find(wnd, len, 0,
> +			BITMAP_FIND_MARK_AS_USED | BITMAP_FIND_FULL, &alcn);
>  
> -	ntfs_unmap_meta(sb, *new_lcn, *new_len);
> +out:
> +	if (alen) {

Just use more goto if needed. This is hard to follow when we come here
and when not.

> +		err = 0;
> +		*new_len = alen;
> +		*new_lcn = alcn;
>  
> -	if (opt & ALLOCATE_MFT)
> -		goto out;
> +		ntfs_unmap_meta(sb, alcn, alen);
>  
> -	/* Set hint for next requests. */
> -	sbi->used.next_free_lcn = *new_lcn + *new_len;
> +		/* Set hint for next requests. */
> +		if (!(opt & ALLOCATE_MFT))
> +			sbi->used.next_free_lcn = alcn + alen;
> +	} else {
> +		err = -ENOSPC;
> +	}
>  
> -out:

Example here 

err_up_write:

and you can use that for many place

>  	up_write(&wnd->rw_lock);
>  	return err;
>  }
> @@ -2226,7 +2209,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
>  	sii_e.sec_id = d_security->key.sec_id;
>  	memcpy(&sii_e.sec_hdr, d_security, SIZEOF_SECURITY_HDR);
>  
> -	err = indx_insert_entry(indx_sii, ni, &sii_e.de, NULL, NULL);
> +	err = indx_insert_entry(indx_sii, ni, &sii_e.de, NULL, NULL, 0);
>  	if (err)
>  		goto out;
>  
> @@ -2247,7 +2230,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
>  
>  	fnd_clear(fnd_sdh);
>  	err = indx_insert_entry(indx_sdh, ni, &sdh_e.de, (void *)(size_t)1,
> -				fnd_sdh);
> +				fnd_sdh, 0);
>  	if (err)
>  		goto out;
>  
> @@ -2385,7 +2368,7 @@ int ntfs_insert_reparse(struct ntfs_sb_info *sbi, __le32 rtag,
>  
>  	mutex_lock_nested(&ni->ni_lock, NTFS_INODE_MUTEX_REPARSE);
>  
> -	err = indx_insert_entry(indx, ni, &re.de, NULL, NULL);
> +	err = indx_insert_entry(indx, ni, &re.de, NULL, NULL, 0);
>  
>  	mark_inode_dirty(&ni->vfs_inode);
>  	ni_unlock(ni);
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 70ef59455b72..1224b8e42b3e 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -1427,7 +1427,7 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
>  	alloc->nres.valid_size = alloc->nres.data_size = cpu_to_le64(data_size);
>  
>  	err = ni_insert_resident(ni, bitmap_size(1), ATTR_BITMAP, in->name,
> -				 in->name_len, &bitmap, NULL);
> +				 in->name_len, &bitmap, NULL, NULL);
>  	if (err)
>  		goto out2;
>  
> @@ -1443,7 +1443,7 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
>  	return 0;
>  
>  out2:
> -	mi_remove_attr(&ni->mi, alloc);
> +	mi_remove_attr(NULL, &ni->mi, alloc);
>  
>  out1:
>  	run_deallocate(sbi, &run, false);
> @@ -1529,24 +1529,24 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
>  /*
>   * indx_insert_into_root - Attempt to insert an entry into the index root.
>   *
> + * @undo - True if we undoing previous remove.
>   * If necessary, it will twiddle the index b-tree.
>   */
>  static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  				 const struct NTFS_DE *new_de,
>  				 struct NTFS_DE *root_de, const void *ctx,
> -				 struct ntfs_fnd *fnd)
> +				 struct ntfs_fnd *fnd, bool undo)
>  {
>  	int err = 0;
>  	struct NTFS_DE *e, *e0, *re;
>  	struct mft_inode *mi;
>  	struct ATTRIB *attr;
> -	struct MFT_REC *rec;
>  	struct INDEX_HDR *hdr;
>  	struct indx_node *n;
>  	CLST new_vbn;
>  	__le64 *sub_vbn, t_vbn;
>  	u16 new_de_size;
> -	u32 hdr_used, hdr_total, asize, used, to_move;
> +	u32 hdr_used, hdr_total, asize, to_move;
>  	u32 root_size, new_root_size;
>  	struct ntfs_sb_info *sbi;
>  	int ds_root;
> @@ -1559,12 +1559,11 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  
>  	/*
>  	 * Try easy case:
> -	 * hdr_insert_de will succeed if there's room the root for the new entry.
> +	 * hdr_insert_de will succeed if there's
> +	 * room the root for the new entry.

Not relevant for this patch.

>  	 */
>  	hdr = &root->ihdr;
>  	sbi = ni->mi.sbi;
> -	rec = mi->mrec;
> -	used = le32_to_cpu(rec->used);
>  	new_de_size = le16_to_cpu(new_de->size);
>  	hdr_used = le32_to_cpu(hdr->used);
>  	hdr_total = le32_to_cpu(hdr->total);
> @@ -1573,9 +1572,9 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  
>  	ds_root = new_de_size + hdr_used - hdr_total;
>  
> -	if (used + ds_root < sbi->max_bytes_per_attr) {
> -		/* Make a room for new elements. */
> -		mi_resize_attr(mi, attr, ds_root);
> +	/* If 'undo' is set then reduce requirements. */
> +	if ((undo || asize + ds_root < sbi->max_bytes_per_attr) &&
> +	    mi_resize_attr(mi, attr, ds_root)) {
>  		hdr->total = cpu_to_le32(hdr_total + ds_root);
>  		e = hdr_insert_de(indx, hdr, new_de, root_de, ctx);
>  		WARN_ON(!e);
> @@ -1629,7 +1628,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  			sizeof(u64);
>  	ds_root = new_root_size - root_size;
>  
> -	if (ds_root > 0 && used + ds_root > sbi->max_bytes_per_attr) {
> +	if (ds_root > 0 && asize + ds_root > sbi->max_bytes_per_attr) {
>  		/* Make root external. */
>  		err = -EOPNOTSUPP;
>  		goto out_free_re;
> @@ -1710,7 +1709,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  
>  		put_indx_node(n);
>  		fnd_clear(fnd);
> -		err = indx_insert_entry(indx, ni, new_de, ctx, fnd);
> +		err = indx_insert_entry(indx, ni, new_de, ctx, fnd, undo);
>  		goto out_free_root;
>  	}
>  
> @@ -1854,7 +1853,7 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
>  	 */
>  	if (!level) {
>  		/* Insert in root. */
> -		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd);
> +		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd, 0);
>  		if (err)
>  			goto out;
>  	} else {
> @@ -1876,10 +1875,12 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
>  
>  /*
>   * indx_insert_entry - Insert new entry into index.
> + *
> + * @undo - True if we undoing previous remove.
>   */
>  int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
>  		      const struct NTFS_DE *new_de, const void *ctx,
> -		      struct ntfs_fnd *fnd)
> +		      struct ntfs_fnd *fnd, bool undo)
>  {
>  	int err;
>  	int diff;
> @@ -1925,7 +1926,7 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
>  		 * new entry into it.
>  		 */
>  		err = indx_insert_into_root(indx, ni, new_de, fnd->root_de, ctx,
> -					    fnd);
> +					    fnd, undo);
>  		if (err)
>  			goto out;
>  	} else {
> @@ -2302,7 +2303,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
>  							      fnd->level - 1,
>  							      fnd)
>  				    : indx_insert_into_root(indx, ni, re, e,
> -							    ctx, fnd);
> +							    ctx, fnd, 0);
>  			kfree(re);
>  
>  			if (err)
> @@ -2507,7 +2508,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
>  		 * Re-insert the entry into the tree.
>  		 * Find the spot the tree where we want to insert the new entry.
>  		 */
> -		err = indx_insert_entry(indx, ni, me, ctx, fnd);
> +		err = indx_insert_entry(indx, ni, me, ctx, fnd, 0);
>  		kfree(me);
>  		if (err)
>  			goto out;
> @@ -2595,10 +2596,8 @@ int indx_update_dup(struct ntfs_inode *ni, struct ntfs_sb_info *sbi,
>  	struct ntfs_index *indx = &ni->dir;
>  
>  	fnd = fnd_get();
> -	if (!fnd) {
> -		err = -ENOMEM;
> -		goto out1;
> -	}
> +	if (!fnd)
> +		return -ENOMEM;
>  
>  	root = indx_get_root(indx, ni, NULL, &mi);
>  	if (!root) {
> @@ -2645,7 +2644,5 @@ int indx_update_dup(struct ntfs_inode *ni, struct ntfs_sb_info *sbi,
>  
>  out:
>  	fnd_put(fnd);
> -
> -out1:
>  	return err;
>  }
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index b86ec7dd731c..8f72066b3229 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -399,6 +399,12 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>  		goto out;
>  	}
>  
> +	if (names != le16_to_cpu(rec->hard_links)) {
> +		/* Correct minor error on the fly. Do not mark inode as dirty. */
> +		rec->hard_links = cpu_to_le16(names);
> +		ni->mi.dirty = true;
> +	}
> +
>  	set_nlink(inode, names);
>  
>  	if (S_ISDIR(mode)) {
> @@ -1279,6 +1285,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  	}
>  	inode = &ni->vfs_inode;
>  	inode_init_owner(mnt_userns, inode, dir, mode);
> +	mode = inode->i_mode;
>  
>  	inode->i_atime = inode->i_mtime = inode->i_ctime = ni->i_crtime =
>  		current_time(inode);
> @@ -1371,6 +1378,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  		attr = Add2Ptr(attr, asize);
>  	}
>  
> +	attr->id = cpu_to_le16(aid++);
>  	if (fa & FILE_ATTRIBUTE_DIRECTORY) {
>  		/*
>  		 * Regular directory or symlink to directory.
> @@ -1381,7 +1389,6 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  
>  		attr->type = ATTR_ROOT;
>  		attr->size = cpu_to_le32(asize);
> -		attr->id = cpu_to_le16(aid++);
>  
>  		attr->name_len = ARRAY_SIZE(I30_NAME);
>  		attr->name_off = SIZEOF_RESIDENT_LE;
> @@ -1412,52 +1419,46 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  		/* Insert empty ATTR_DATA */
>  		attr->type = ATTR_DATA;
>  		attr->size = cpu_to_le32(SIZEOF_RESIDENT);
> -		attr->id = cpu_to_le16(aid++);
>  		attr->name_off = SIZEOF_RESIDENT_LE;
>  		attr->res.data_off = SIZEOF_RESIDENT_LE;
> -	} else {
> +	} else if (S_ISREG(mode)) {

This should definetly be own patch. Way too much noice. And yes I think
this is a good change but if this is in this patch then how do we see
what is relevant?

>  		/*
> -		 * Regular file or node.
> +		 * Regular file. Create empty non resident data attribute.
>  		 */
>  		attr->type = ATTR_DATA;
> -		attr->id = cpu_to_le16(aid++);
> -
> -		if (S_ISREG(mode)) {
> -			/* Create empty non resident data attribute. */
> -			attr->non_res = 1;
> -			attr->nres.evcn = cpu_to_le64(-1ll);
> -			if (fa & FILE_ATTRIBUTE_SPARSE_FILE) {
> -				attr->size =
> -					cpu_to_le32(SIZEOF_NONRESIDENT_EX + 8);
> -				attr->name_off = SIZEOF_NONRESIDENT_EX_LE;
> -				attr->flags = ATTR_FLAG_SPARSED;
> -				asize = SIZEOF_NONRESIDENT_EX + 8;
> -			} else if (fa & FILE_ATTRIBUTE_COMPRESSED) {
> -				attr->size =
> -					cpu_to_le32(SIZEOF_NONRESIDENT_EX + 8);
> -				attr->name_off = SIZEOF_NONRESIDENT_EX_LE;
> -				attr->flags = ATTR_FLAG_COMPRESSED;
> -				attr->nres.c_unit = COMPRESSION_UNIT;
> -				asize = SIZEOF_NONRESIDENT_EX + 8;
> -			} else {
> -				attr->size =
> -					cpu_to_le32(SIZEOF_NONRESIDENT + 8);
> -				attr->name_off = SIZEOF_NONRESIDENT_LE;
> -				asize = SIZEOF_NONRESIDENT + 8;
> -			}
> -			attr->nres.run_off = attr->name_off;
> +		attr->non_res = 1;
> +		attr->nres.evcn = cpu_to_le64(-1ll);
> +		if (fa & FILE_ATTRIBUTE_SPARSE_FILE) {
> +			attr->size = cpu_to_le32(SIZEOF_NONRESIDENT_EX + 8);
> +			attr->name_off = SIZEOF_NONRESIDENT_EX_LE;
> +			attr->flags = ATTR_FLAG_SPARSED;
> +			asize = SIZEOF_NONRESIDENT_EX + 8;
> +		} else if (fa & FILE_ATTRIBUTE_COMPRESSED) {
> +			attr->size = cpu_to_le32(SIZEOF_NONRESIDENT_EX + 8);
> +			attr->name_off = SIZEOF_NONRESIDENT_EX_LE;
> +			attr->flags = ATTR_FLAG_COMPRESSED;
> +			attr->nres.c_unit = COMPRESSION_UNIT;
> +			asize = SIZEOF_NONRESIDENT_EX + 8;
>  		} else {
> -			/* Create empty resident data attribute. */
> -			attr->size = cpu_to_le32(SIZEOF_RESIDENT);
> -			attr->name_off = SIZEOF_RESIDENT_LE;
> -			if (fa & FILE_ATTRIBUTE_SPARSE_FILE)
> -				attr->flags = ATTR_FLAG_SPARSED;
> -			else if (fa & FILE_ATTRIBUTE_COMPRESSED)
> -				attr->flags = ATTR_FLAG_COMPRESSED;
> -			attr->res.data_off = SIZEOF_RESIDENT_LE;
> -			asize = SIZEOF_RESIDENT;
> -			ni->ni_flags |= NI_FLAG_RESIDENT;
> +			attr->size = cpu_to_le32(SIZEOF_NONRESIDENT + 8);
> +			attr->name_off = SIZEOF_NONRESIDENT_LE;
> +			asize = SIZEOF_NONRESIDENT + 8;
>  		}
> +		attr->nres.run_off = attr->name_off;
> +	} else {
> +		/*
> +		 * Node. Create empty resident data attribute.
> +		 */
> +		attr->type = ATTR_DATA;
> +		attr->size = cpu_to_le32(SIZEOF_RESIDENT);
> +		attr->name_off = SIZEOF_RESIDENT_LE;
> +		if (fa & FILE_ATTRIBUTE_SPARSE_FILE)
> +			attr->flags = ATTR_FLAG_SPARSED;
> +		else if (fa & FILE_ATTRIBUTE_COMPRESSED)
> +			attr->flags = ATTR_FLAG_COMPRESSED;
> +		attr->res.data_off = SIZEOF_RESIDENT_LE;
> +		asize = SIZEOF_RESIDENT;
> +		ni->ni_flags |= NI_FLAG_RESIDENT;
>  	}
>  
>  	if (S_ISDIR(mode)) {
> @@ -1485,7 +1486,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  		asize = ALIGN(SIZEOF_RESIDENT + nsize, 8);
>  		t16 = PtrOffset(rec, attr);
>  
> -		if (asize + t16 + 8 > sbi->record_size) {
> +		/* 0x78 - the size of EA + EAINFO to store WSL */
> +		if (asize + t16 + 0x78 + 8 > sbi->record_size) {
>  			CLST alen;
>  			CLST clst = bytes_to_cluster(sbi, nsize);
>  
> @@ -1545,20 +1547,15 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  	rec->next_attr_id = cpu_to_le16(aid);
>  
>  	/* Step 2: Add new name in index. */
> -	err = indx_insert_entry(&dir_ni->dir, dir_ni, new_de, sbi, fnd);
> +	err = indx_insert_entry(&dir_ni->dir, dir_ni, new_de, sbi, fnd, 0);
>  	if (err)
>  		goto out6;
>  
> -	/* Update current directory record. */
> -	mark_inode_dirty(dir);
> -

This was also probably just fix it is own?

>  	inode->i_generation = le16_to_cpu(rec->seq);
>  
>  	dir->i_mtime = dir->i_ctime = inode->i_atime;
>  
>  	if (S_ISDIR(mode)) {
> -		if (dir->i_mode & S_ISGID)
> -			mode |= S_ISGID;

This also is not relevant for this patch. Yes dead code but not releted
to this one. This kind of stuff takes lot of reviewers time.


I do not even feel like i will continue this review. There is just way
too much stuff and would definetly nack. But as this already is in ntfs3
master I just don't know what to do. I cc fsdevel so maybe they can help
a little bit.

	Argillander

>  		inode->i_op = &ntfs_dir_inode_operations;
>  		inode->i_fop = &ntfs_dir_operations;
>  	} else if (S_ISLNK(mode)) {
> @@ -1601,8 +1598,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  	d_instantiate(dentry, inode);
>  
>  	ntfs_save_wsl_perm(inode);
> -	mark_inode_dirty(inode);
>  	mark_inode_dirty(dir);
> +	mark_inode_dirty(inode);
>  
>  	/* Normal exit. */
>  	goto out2;
> @@ -1646,61 +1643,36 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
>  {
>  	int err;
> -	struct inode *dir = d_inode(dentry->d_parent);
> -	struct ntfs_inode *dir_ni = ntfs_i(dir);
>  	struct ntfs_inode *ni = ntfs_i(inode);
> -	struct super_block *sb = inode->i_sb;
> -	struct ntfs_sb_info *sbi = sb->s_fs_info;
> -	const struct qstr *name = &dentry->d_name;
> -	struct NTFS_DE *new_de = NULL;
> -	struct ATTR_FILE_NAME *fname;
> -	struct ATTRIB *attr;
> -	u16 key_size;
> -	struct INDEX_ROOT *dir_root;
> -
> -	dir_root = indx_get_root(&dir_ni->dir, dir_ni, NULL, NULL);
> -	if (!dir_root)
> -		return -EINVAL;
> +	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
> +	struct NTFS_DE *de;
> +	struct ATTR_FILE_NAME *de_name;
>  
>  	/* Allocate PATH_MAX bytes. */
> -	new_de = __getname();
> -	if (!new_de)
> +	de = __getname();
> +	if (!de)
>  		return -ENOMEM;
>  
> -	/* Mark rw ntfs as dirty.  It will be cleared at umount. */
> -	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_DIRTY);
> -
> -	/* Insert file name. */
> -	err = fill_name_de(sbi, new_de, name, NULL);
> -	if (err)
> -		goto out;
> -
> -	key_size = le16_to_cpu(new_de->key_size);
> -	err = ni_insert_resident(ni, key_size, ATTR_NAME, NULL, 0, &attr, NULL);
> -	if (err)
> -		goto out;
> -
> -	mi_get_ref(&ni->mi, &new_de->ref);
> -
> -	fname = (struct ATTR_FILE_NAME *)(new_de + 1);
> -	mi_get_ref(&dir_ni->mi, &fname->home);
> -	fname->dup.cr_time = fname->dup.m_time = fname->dup.c_time =
> -		fname->dup.a_time = kernel2nt(&inode->i_ctime);
> -	fname->dup.alloc_size = fname->dup.data_size = 0;
> -	fname->dup.fa = ni->std_fa;
> -	fname->dup.ea_size = fname->dup.reparse = 0;
> -
> -	memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), fname, key_size);
> +	/* Mark rw ntfs as dirty. It will be cleared at umount. */
> +	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
>  
> -	err = indx_insert_entry(&dir_ni->dir, dir_ni, new_de, sbi, NULL);
> +	/* Construct 'de'. */
> +	err = fill_name_de(sbi, de, &dentry->d_name, NULL);
>  	if (err)
>  		goto out;
>  
> -	le16_add_cpu(&ni->mi.mrec->hard_links, 1);
> -	ni->mi.dirty = true;
> +	de_name = (struct ATTR_FILE_NAME *)(de + 1);
> +	/* Fill duplicate info. */
> +	de_name->dup.cr_time = de_name->dup.m_time = de_name->dup.c_time =
> +		de_name->dup.a_time = kernel2nt(&inode->i_ctime);
> +	de_name->dup.alloc_size = de_name->dup.data_size =
> +		cpu_to_le64(inode->i_size);
> +	de_name->dup.fa = ni->std_fa;
> +	de_name->dup.ea_size = de_name->dup.reparse = 0;
>  
> +	err = ni_add_name(ntfs_i(d_inode(dentry->d_parent)), ni, de);
>  out:
> -	__putname(new_de);
> +	__putname(de);
>  	return err;
>  }
>  
> @@ -1713,113 +1685,56 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
>  int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
>  {
>  	int err;
> -	struct super_block *sb = dir->i_sb;
> -	struct ntfs_sb_info *sbi = sb->s_fs_info;
> +	struct ntfs_sb_info *sbi = dir->i_sb->s_fs_info;
>  	struct inode *inode = d_inode(dentry);
>  	struct ntfs_inode *ni = ntfs_i(inode);
> -	const struct qstr *name = &dentry->d_name;
>  	struct ntfs_inode *dir_ni = ntfs_i(dir);
> -	struct ntfs_index *indx = &dir_ni->dir;
> -	struct cpu_str *uni = NULL;
> -	struct ATTR_FILE_NAME *fname;
> -	u8 name_type;
> -	struct ATTR_LIST_ENTRY *le;
> -	struct MFT_REF ref;
> -	bool is_dir = S_ISDIR(inode->i_mode);
> -	struct INDEX_ROOT *dir_root;
> +	struct NTFS_DE *de, *de2 = NULL;
> +	int undo_remove;
>  
> -	dir_root = indx_get_root(indx, dir_ni, NULL, NULL);
> -	if (!dir_root)
> +	if (ntfs_is_meta_file(sbi, ni->mi.rno))
>  		return -EINVAL;
>  
> +	/* Allocate PATH_MAX bytes. */
> +	de = __getname();
> +	if (!de)
> +		return -ENOMEM;
> +
>  	ni_lock(ni);
>  
> -	if (is_dir && !dir_is_empty(inode)) {
> +	if (S_ISDIR(inode->i_mode) && !dir_is_empty(inode)) {
>  		err = -ENOTEMPTY;
> -		goto out1;
> -	}
> -
> -	if (ntfs_is_meta_file(sbi, inode->i_ino)) {
> -		err = -EINVAL;
> -		goto out1;
> -	}
> -
> -	/* Allocate PATH_MAX bytes. */
> -	uni = __getname();
> -	if (!uni) {
> -		err = -ENOMEM;
> -		goto out1;
> +		goto out;
>  	}
>  
> -	/* Convert input string to unicode. */
> -	err = ntfs_nls_to_utf16(sbi, name->name, name->len, uni, NTFS_NAME_LEN,
> -				UTF16_HOST_ENDIAN);
> +	err = fill_name_de(sbi, de, &dentry->d_name, NULL);
>  	if (err < 0)
> -		goto out2;
> -
> -	/* Mark rw ntfs as dirty.  It will be cleared at umount. */
> -	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
> -
> -	/* Find name in record. */
> -	mi_get_ref(&dir_ni->mi, &ref);
> -
> -	le = NULL;
> -	fname = ni_fname_name(ni, uni, &ref, &le);
> -	if (!fname) {
> -		err = -ENOENT;
> -		goto out3;
> -	}
> -
> -	name_type = paired_name(fname->type);
> -
> -	err = indx_delete_entry(indx, dir_ni, fname, fname_full_size(fname),
> -				sbi);
> -	if (err)
> -		goto out3;
> -
> -	/* Then remove name from MFT. */
> -	ni_remove_attr_le(ni, attr_from_name(fname), le);
> -
> -	le16_add_cpu(&ni->mi.mrec->hard_links, -1);
> -	ni->mi.dirty = true;
> -
> -	if (name_type != FILE_NAME_POSIX) {
> -		/* Now we should delete name by type. */
> -		fname = ni_fname_type(ni, name_type, &le);
> -		if (fname) {
> -			err = indx_delete_entry(indx, dir_ni, fname,
> -						fname_full_size(fname), sbi);
> -			if (err)
> -				goto out3;
> +		goto out;
>  
> -			ni_remove_attr_le(ni, attr_from_name(fname), le);
> +	undo_remove = 0;
> +	err = ni_remove_name(dir_ni, ni, de, &de2, &undo_remove);
>  
> -			le16_add_cpu(&ni->mi.mrec->hard_links, -1);
> -		}
> -	}
> -out3:
> -	switch (err) {
> -	case 0:
> +	if (!err) {
>  		drop_nlink(inode);
> -		break;
> -	case -ENOTEMPTY:
> -	case -ENOSPC:
> -	case -EROFS:
> -		break;
> -	default:
> +		dir->i_mtime = dir->i_ctime = current_time(dir);
> +		mark_inode_dirty(dir);
> +		inode->i_ctime = dir->i_ctime;
> +		if (inode->i_nlink)
> +			mark_inode_dirty(inode);
> +	} else if (!ni_remove_name_undo(dir_ni, ni, de, de2, undo_remove)) {
>  		make_bad_inode(inode);
> +		ntfs_inode_err(inode, "failed to undo unlink");
> +		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
> +	} else {
> +		if (ni_is_dirty(dir))
> +			mark_inode_dirty(dir);
> +		if (ni_is_dirty(inode))
> +			mark_inode_dirty(inode);
>  	}
>  
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> -	mark_inode_dirty(dir);
> -	inode->i_ctime = dir->i_ctime;
> -	if (inode->i_nlink)
> -		mark_inode_dirty(inode);
> -
> -out2:
> -	__putname(uni);
> -out1:
> +out:
>  	ni_unlock(ni);
> +	__putname(de);
>  	return err;
>  }
>  
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index f79a399bd015..e58415d07132 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -152,12 +152,14 @@ static int ntfs_link(struct dentry *ode, struct inode *dir, struct dentry *de)
>  	if (inode != dir)
>  		ni_lock(ni);
>  
> -	dir->i_ctime = dir->i_mtime = inode->i_ctime = current_time(inode);
>  	inc_nlink(inode);
>  	ihold(inode);
>  
>  	err = ntfs_link_inode(inode, de);
> +
>  	if (!err) {
> +		dir->i_ctime = dir->i_mtime = inode->i_ctime =
> +			current_time(dir);
>  		mark_inode_dirty(inode);
>  		mark_inode_dirty(dir);
>  		d_instantiate(de, inode);
> @@ -249,25 +251,26 @@ static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
>  /*
>   * ntfs_rename - inode_operations::rename
>   */
> -static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
> -		       struct dentry *old_dentry, struct inode *new_dir,
> +static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *dir,
> +		       struct dentry *dentry, struct inode *new_dir,
>  		       struct dentry *new_dentry, u32 flags)
>  {
>  	int err;
> -	struct super_block *sb = old_dir->i_sb;
> +	struct super_block *sb = dir->i_sb;
>  	struct ntfs_sb_info *sbi = sb->s_fs_info;
> -	struct ntfs_inode *old_dir_ni = ntfs_i(old_dir);
> +	struct ntfs_inode *dir_ni = ntfs_i(dir);
>  	struct ntfs_inode *new_dir_ni = ntfs_i(new_dir);
> -	struct ntfs_inode *old_ni;
> -	struct ATTR_FILE_NAME *old_name, *new_name, *fname;
> -	u8 name_type;
> -	bool is_same;
> -	struct inode *old_inode, *new_inode;
> -	struct NTFS_DE *old_de, *new_de;
> -	struct ATTRIB *attr;
> -	struct ATTR_LIST_ENTRY *le;
> -	u16 new_de_key_size;
> -
> +	struct inode *inode = d_inode(dentry);
> +	struct ntfs_inode *ni = ntfs_i(inode);
> +	struct inode *new_inode = d_inode(new_dentry);
> +	struct NTFS_DE *de, *new_de;
> +	bool is_same, is_bad;
> +	/*
> +	 * de		- memory of PATH_MAX bytes:
> +	 * [0-1024)	- original name (dentry->d_name)
> +	 * [1024-2048)	- paired to original name, usually DOS variant of dentry->d_name
> +	 * [2048-3072)	- new name (new_dentry->d_name)
> +	 */
>  	static_assert(SIZEOF_ATTRIBUTE_FILENAME_MAX + SIZEOF_RESIDENT < 1024);
>  	static_assert(SIZEOF_ATTRIBUTE_FILENAME_MAX + sizeof(struct NTFS_DE) <
>  		      1024);
> @@ -276,24 +279,18 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  	if (flags & ~RENAME_NOREPLACE)
>  		return -EINVAL;
>  
> -	old_inode = d_inode(old_dentry);
> -	new_inode = d_inode(new_dentry);
> -
> -	old_ni = ntfs_i(old_inode);
> +	is_same = dentry->d_name.len == new_dentry->d_name.len &&
> +		  !memcmp(dentry->d_name.name, new_dentry->d_name.name,
> +			  dentry->d_name.len);
>  
> -	is_same = old_dentry->d_name.len == new_dentry->d_name.len &&
> -		  !memcmp(old_dentry->d_name.name, new_dentry->d_name.name,
> -			  old_dentry->d_name.len);
> -
> -	if (is_same && old_dir == new_dir) {
> +	if (is_same && dir == new_dir) {
>  		/* Nothing to do. */
> -		err = 0;
> -		goto out;
> +		return 0;
>  	}
>  
> -	if (ntfs_is_meta_file(sbi, old_inode->i_ino)) {
> -		err = -EINVAL;
> -		goto out;
> +	if (ntfs_is_meta_file(sbi, inode->i_ino)) {
> +		/* Should we print an error? */
> +		return -EINVAL;
>  	}
>  
>  	if (new_inode) {
> @@ -304,168 +301,61 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  		ni_unlock(new_dir_ni);
>  		dput(new_dentry);
>  		if (err)
> -			goto out;
> +			return err;
>  	}
>  
>  	/* Allocate PATH_MAX bytes. */
> -	old_de = __getname();
> -	if (!old_de) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> +	de = __getname();
> +	if (!de)
> +		return -ENOMEM;
>  
> -	err = fill_name_de(sbi, old_de, &old_dentry->d_name, NULL);
> +	/* Translate dentry->d_name into unicode form. */
> +	err = fill_name_de(sbi, de, &dentry->d_name, NULL);
>  	if (err < 0)
> -		goto out1;
> -
> -	old_name = (struct ATTR_FILE_NAME *)(old_de + 1);
> +		goto out;
>  
>  	if (is_same) {
> -		new_de = old_de;
> +		/* Reuse 'de'. */
> +		new_de = de;
>  	} else {
> -		new_de = Add2Ptr(old_de, 1024);
> +		/* Translate new_dentry->d_name into unicode form. */
> +		new_de = Add2Ptr(de, 2048);
>  		err = fill_name_de(sbi, new_de, &new_dentry->d_name, NULL);
>  		if (err < 0)
> -			goto out1;
> -	}
> -
> -	ni_lock_dir(old_dir_ni);
> -	ni_lock(old_ni);
> -
> -	mi_get_ref(&old_dir_ni->mi, &old_name->home);
> -
> -	/* Get pointer to file_name in MFT. */
> -	fname = ni_fname_name(old_ni, (struct cpu_str *)&old_name->name_len,
> -			      &old_name->home, &le);
> -	if (!fname) {
> -		err = -EINVAL;
> -		goto out2;
> +			goto out;
>  	}
>  
> -	/* Copy fname info from record into new fname. */
> -	new_name = (struct ATTR_FILE_NAME *)(new_de + 1);
> -	memcpy(&new_name->dup, &fname->dup, sizeof(fname->dup));
> -
> -	name_type = paired_name(fname->type);
> -
> -	/* Remove first name from directory. */
> -	err = indx_delete_entry(&old_dir_ni->dir, old_dir_ni, old_de + 1,
> -				le16_to_cpu(old_de->key_size), sbi);
> -	if (err)
> -		goto out3;
> -
> -	/* Remove first name from MFT. */
> -	err = ni_remove_attr_le(old_ni, attr_from_name(fname), le);
> -	if (err)
> -		goto out4;
> -
> -	le16_add_cpu(&old_ni->mi.mrec->hard_links, -1);
> -	old_ni->mi.dirty = true;
> -
> -	if (name_type != FILE_NAME_POSIX) {
> -		/* Get paired name. */
> -		fname = ni_fname_type(old_ni, name_type, &le);
> -		if (fname) {
> -			/* Remove second name from directory. */
> -			err = indx_delete_entry(&old_dir_ni->dir, old_dir_ni,
> -						fname, fname_full_size(fname),
> -						sbi);
> -			if (err)
> -				goto out5;
> -
> -			/* Remove second name from MFT. */
> -			err = ni_remove_attr_le(old_ni, attr_from_name(fname),
> -						le);
> -			if (err)
> -				goto out6;
> -
> -			le16_add_cpu(&old_ni->mi.mrec->hard_links, -1);
> -			old_ni->mi.dirty = true;
> +	ni_lock_dir(dir_ni);
> +	ni_lock(ni);
> +
> +	is_bad = false;
> +	err = ni_rename(dir_ni, new_dir_ni, ni, de, new_de, &is_bad);
> +	if (is_bad) {
> +		/* Restore after failed rename failed too. */
> +		make_bad_inode(inode);
> +		ntfs_inode_err(inode, "failed to undo rename");
> +		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
> +	} else if (!err) {
> +		inode->i_ctime = dir->i_ctime = dir->i_mtime =
> +			current_time(dir);
> +		mark_inode_dirty(inode);
> +		mark_inode_dirty(dir);
> +		if (dir != new_dir) {
> +			new_dir->i_mtime = new_dir->i_ctime = dir->i_ctime;
> +			mark_inode_dirty(new_dir);
>  		}
> -	}
> -
> -	/* Add new name. */
> -	mi_get_ref(&old_ni->mi, &new_de->ref);
> -	mi_get_ref(&ntfs_i(new_dir)->mi, &new_name->home);
> -
> -	new_de_key_size = le16_to_cpu(new_de->key_size);
> -
> -	/* Insert new name in MFT. */
> -	err = ni_insert_resident(old_ni, new_de_key_size, ATTR_NAME, NULL, 0,
> -				 &attr, NULL);
> -	if (err)
> -		goto out7;
> -
> -	attr->res.flags = RESIDENT_FLAG_INDEXED;
> -
> -	memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), new_name, new_de_key_size);
> -
> -	le16_add_cpu(&old_ni->mi.mrec->hard_links, 1);
> -	old_ni->mi.dirty = true;
> -
> -	/* Insert new name in directory. */
> -	err = indx_insert_entry(&new_dir_ni->dir, new_dir_ni, new_de, sbi,
> -				NULL);
> -	if (err)
> -		goto out8;
>  
> -	if (IS_DIRSYNC(new_dir))
> -		err = ntfs_sync_inode(old_inode);
> -	else
> -		mark_inode_dirty(old_inode);
> +		if (IS_DIRSYNC(dir))
> +			ntfs_sync_inode(dir);
>  
> -	old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
> -	if (IS_DIRSYNC(old_dir))
> -		(void)ntfs_sync_inode(old_dir);
> -	else
> -		mark_inode_dirty(old_dir);
> -
> -	if (old_dir != new_dir) {
> -		new_dir->i_mtime = new_dir->i_ctime = old_dir->i_ctime;
> -		mark_inode_dirty(new_dir);
> -	}
> -
> -	if (old_inode) {
> -		old_inode->i_ctime = old_dir->i_ctime;
> -		mark_inode_dirty(old_inode);
> +		if (IS_DIRSYNC(new_dir))
> +			ntfs_sync_inode(inode);
>  	}
>  
> -	err = 0;
> -	/* Normal way* */
> -	goto out2;
> -
> -out8:
> -	/* undo
> -	 * ni_insert_resident(old_ni, new_de_key_size, ATTR_NAME, NULL, 0,
> -	 *			 &attr, NULL);
> -	 */
> -	mi_remove_attr(&old_ni->mi, attr);
> -out7:
> -	/* undo
> -	 * ni_remove_attr_le(old_ni, attr_from_name(fname), le);
> -	 */
> -out6:
> -	/* undo
> -	 * indx_delete_entry(&old_dir_ni->dir, old_dir_ni,
> -	 *					fname, fname_full_size(fname),
> -	 *					sbi);
> -	 */
> -out5:
> -	/* undo
> -	 * ni_remove_attr_le(old_ni, attr_from_name(fname), le);
> -	 */
> -out4:
> -	/* undo:
> -	 * indx_delete_entry(&old_dir_ni->dir, old_dir_ni, old_de + 1,
> -	 *			old_de->key_size, NULL);
> -	 */
> -out3:
> -out2:
> -	ni_unlock(old_ni);
> -	ni_unlock(old_dir_ni);
> -out1:
> -	__putname(old_de);
> +	ni_unlock(ni);
> +	ni_unlock(dir_ni);
>  out:
> +	__putname(de);
>  	return err;
>  }
>  
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 64ef92e16363..f9436cbbc347 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -478,7 +478,7 @@ struct ATTR_STD_INFO *ni_std(struct ntfs_inode *ni);
>  struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni);
>  void ni_clear(struct ntfs_inode *ni);
>  int ni_load_mi_ex(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi);
> -int ni_load_mi(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
> +int ni_load_mi(struct ntfs_inode *ni, const struct ATTR_LIST_ENTRY *le,
>  	       struct mft_inode **mi);
>  struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
>  			    struct ATTR_LIST_ENTRY **entry_o,
> @@ -505,15 +505,18 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
>  			  struct mft_inode **mi);
>  int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
>  		       enum ATTR_TYPE type, const __le16 *name, u8 name_len,
> -		       struct ATTRIB **new_attr, struct mft_inode **mi);
> -int ni_remove_attr_le(struct ntfs_inode *ni, struct ATTRIB *attr,
> -		      struct ATTR_LIST_ENTRY *le);
> +		       struct ATTRIB **new_attr, struct mft_inode **mi,
> +		       struct ATTR_LIST_ENTRY **le);
> +void ni_remove_attr_le(struct ntfs_inode *ni, struct ATTRIB *attr,
> +		       struct mft_inode *mi, struct ATTR_LIST_ENTRY *le);
>  int ni_delete_all(struct ntfs_inode *ni);
>  struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
>  				     const struct cpu_str *uni,
>  				     const struct MFT_REF *home,
> +				     struct mft_inode **mi,
>  				     struct ATTR_LIST_ENTRY **entry);
>  struct ATTR_FILE_NAME *ni_fname_type(struct ntfs_inode *ni, u8 name_type,
> +				     struct mft_inode **mi,
>  				     struct ATTR_LIST_ENTRY **entry);
>  int ni_new_attr_flags(struct ntfs_inode *ni, enum FILE_ATTRIBUTE new_fa);
>  enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
> @@ -528,6 +531,21 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
>  		  u32 pages_per_frame);
>  int ni_write_frame(struct ntfs_inode *ni, struct page **pages,
>  		   u32 pages_per_frame);
> +int ni_remove_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
> +		   struct NTFS_DE *de, struct NTFS_DE **de2, int *undo_step);
> +
> +bool ni_remove_name_undo(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
> +			 struct NTFS_DE *de, struct NTFS_DE *de2,
> +			 int undo_step);
> +
> +int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
> +		struct NTFS_DE *de);
> +
> +int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
> +	      struct ntfs_inode *ni, struct NTFS_DE *de, struct NTFS_DE *new_de,
> +	      bool *is_bad);
> +
> +bool ni_is_dirty(struct inode *inode);
>  
>  /* Globals from fslog.c */
>  int log_replay(struct ntfs_inode *ni, bool *initialized);
> @@ -631,7 +649,7 @@ int indx_find_raw(struct ntfs_index *indx, struct ntfs_inode *ni,
>  		  size_t *off, struct ntfs_fnd *fnd);
>  int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
>  		      const struct NTFS_DE *new_de, const void *param,
> -		      struct ntfs_fnd *fnd);
> +		      struct ntfs_fnd *fnd, bool undo);
>  int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
>  		      const void *key, u32 key_len, const void *param);
>  int indx_update_dup(struct ntfs_inode *ni, struct ntfs_sb_info *sbi,
> @@ -694,7 +712,8 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
>  			      const __le16 *name, u8 name_len, u32 asize,
>  			      u16 name_off);
>  
> -bool mi_remove_attr(struct mft_inode *mi, struct ATTRIB *attr);
> +bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
> +		    struct ATTRIB *attr);
>  bool mi_resize_attr(struct mft_inode *mi, struct ATTRIB *attr, int bytes);
>  int mi_pack_runs(struct mft_inode *mi, struct ATTRIB *attr,
>  		 struct runs_tree *run, CLST len);
> diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
> index d48a5e6c5045..61e3f2fb619f 100644
> --- a/fs/ntfs3/record.c
> +++ b/fs/ntfs3/record.c
> @@ -489,7 +489,8 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
>   *
>   * NOTE: The source attr will point to next attribute.
>   */
> -bool mi_remove_attr(struct mft_inode *mi, struct ATTRIB *attr)
> +bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
> +		    struct ATTRIB *attr)
>  {
>  	struct MFT_REC *rec = mi->mrec;
>  	u32 aoff = PtrOffset(rec, attr);
> @@ -499,6 +500,11 @@ bool mi_remove_attr(struct mft_inode *mi, struct ATTRIB *attr)
>  	if (aoff + asize > used)
>  		return false;
>  
> +	if (ni && is_attr_indexed(attr)) {
> +		le16_add_cpu(&ni->mi.mrec->hard_links, -1);
> +		ni->mi.dirty = true;
> +	}
> +
>  	used -= asize;
>  	memmove(attr, Add2Ptr(attr, asize), used - aoff);
>  	rec->used = cpu_to_le32(used);
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index b4c921e4bc1a..22fd5eb32c5b 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -395,11 +395,13 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>  		}
>  
>  		err = ni_insert_resident(ni, sizeof(struct EA_INFO),
> -					 ATTR_EA_INFO, NULL, 0, NULL, NULL);
> +					 ATTR_EA_INFO, NULL, 0, NULL, NULL,
> +					 NULL);
>  		if (err)
>  			goto out;
>  
> -		err = ni_insert_resident(ni, 0, ATTR_EA, NULL, 0, NULL, NULL);
> +		err = ni_insert_resident(ni, 0, ATTR_EA, NULL, 0, NULL, NULL,
> +					 NULL);
>  		if (err)
>  			goto out;
>  	}
> @@ -419,9 +421,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>  
>  	if (!size) {
>  		/* Delete xattr, ATTR_EA_INFO */
> -		err = ni_remove_attr_le(ni, attr, le);
> -		if (err)
> -			goto out;
> +		ni_remove_attr_le(ni, attr, mi, le);
>  	} else {
>  		p = resident_data_ex(attr, sizeof(struct EA_INFO));
>  		if (!p) {
> @@ -441,9 +441,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>  
>  	if (!size) {
>  		/* Delete xattr, ATTR_EA */
> -		err = ni_remove_attr_le(ni, attr, le);
> -		if (err)
> -			goto out;
> +		ni_remove_attr_le(ni, attr, mi, le);
>  	} else if (attr->non_res) {
>  		err = ntfs_sb_write_run(sbi, &ea_run, 0, ea_all, size);
>  		if (err)
> @@ -605,8 +603,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>  			goto out;
>  	}
>  
> -	err = ntfs_set_ea(inode, name, name_len, value, size,
> -			  acl ? 0 : XATTR_REPLACE, locked);
> +	err = ntfs_set_ea(inode, name, name_len, value, size, 0, locked);
>  	if (!err)
>  		set_cached_acl(inode, type, acl);
>  
> @@ -632,8 +629,10 @@ static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
>  	struct posix_acl *acl;
>  	int err;
>  
> -	if (!(inode->i_sb->s_flags & SB_POSIXACL))
> +	if (!(inode->i_sb->s_flags & SB_POSIXACL)) {
> +		ntfs_inode_warn(inode, "add mount option \"acl\" to use acl");
>  		return -EOPNOTSUPP;
> +	}
>  
>  	acl = ntfs_get_acl(inode, type);
>  	if (IS_ERR(acl))
> @@ -655,8 +654,10 @@ static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
>  	struct posix_acl *acl;
>  	int err;
>  
> -	if (!(inode->i_sb->s_flags & SB_POSIXACL))
> +	if (!(inode->i_sb->s_flags & SB_POSIXACL)) {
> +		ntfs_inode_warn(inode, "add mount option \"acl\" to use acl");
>  		return -EOPNOTSUPP;
> +	}
>  
>  	if (!inode_owner_or_capable(mnt_userns, inode))
>  		return -EPERM;
> -- 
> 2.28.0
> 
