Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096C32E8F0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 01:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbhADA0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 19:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbhADA0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 19:26:39 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDF3C061574;
        Sun,  3 Jan 2021 16:25:58 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s26so60622417lfc.8;
        Sun, 03 Jan 2021 16:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R7hvpfkH9hm2F1ljXe6kGhfQ96YKfh3yMzjTm0ieqD8=;
        b=rCeemwx2glN9MpYPcYl3kvS4BmsTM6ZZOl97JKu3dPhZQ+QF+fBaOke5EwCy4bwtq8
         agQqa045vE7hm8S1QP8o3fyUBRwzwiGLCXUJaOBz7I7Qyrw93Od8/dF3tVYfEv/cr01m
         vfrMFJOZFslaCoIQhPpVOa3Nn7NaXmBUtUFk86SG5xtWRuHZwfrl7boslRJxkIm4Aa7S
         CsMSw1OgDLFxqaaybzvtlqCHlPBL5uXruocArj9ogz7vod7wwe35Hvv5wAMQG6E1XqOV
         o9b/h0H18vTxIggwkzp1MfGafdfj5zK0lsa4jY0IuZE4Hb+8a5HTN+2HjQW8zyC5KoN2
         Vz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R7hvpfkH9hm2F1ljXe6kGhfQ96YKfh3yMzjTm0ieqD8=;
        b=qLWvYYDuoCZX39FkYNLYEu1MUBVqfoqG/w7fVws6+66Tb4liL3JJbgtVdD3bbFwAg9
         LTrTXt+KvTnftf1lc/VZbug6JijGPknQDaWGMAUCEGr/+VBLolelk75GZZuYvJAf+6lO
         FhIJ1CKc5P9JXyaLUWPKukBXI+Bk0a60aAvatM0p0VwCbe8qcV22MeYTnO7igxQTrMsm
         jsEGJ327Ukn9T6ak4eT6suzU+7ssZ/GdqjB2kQ/mPNQAhGmuTbDBc45UZd5y8QQKLwGu
         6wByWWKdD7m429pX9NybxvWTcOACq8oA4PIuTv+hPEq3FdV0orM+NNg/XOu28uESi9y0
         5f0Q==
X-Gm-Message-State: AOAM53124YF+c50bOwKFXufTzRdl5dAtO8yDlISTWbgFqX9gcW3gBOvX
        ZOHG5/hPvg49sjQSGJe6TTU=
X-Google-Smtp-Source: ABdhPJx/Cw20aEzfrWzLLsvU8YderbZ242tKhXuOzcrXDTm10NV0w523k4IVvA+Q5v3T1Gp5emSt1Q==
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr32816918lfr.180.1609719957315;
        Sun, 03 Jan 2021 16:25:57 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id b141sm7115792lfg.123.2021.01.03.16.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 16:25:56 -0800 (PST)
Date:   Mon, 4 Jan 2021 02:25:54 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v17 05/10] fs/ntfs3: Add attrib operations
Message-ID: <20210104002554.gdxoyu2q2aaae5ph@kari-VirtualBox>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-6-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231152401.3162425-6-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 31, 2020 at 06:23:56PM +0300, Konstantin Komarov wrote:
> This adds attrib operations
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/attrib.c   | 2081 +++++++++++++++++++++++++++++++++++++++++++
>  fs/ntfs3/attrlist.c |  463 ++++++++++
>  fs/ntfs3/xattr.c    | 1072 ++++++++++++++++++++++
>  3 files changed, 3616 insertions(+)
>  create mode 100644 fs/ntfs3/attrib.c
>  create mode 100644 fs/ntfs3/attrlist.c
>  create mode 100644 fs/ntfs3/xattr.c
> 
> diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c

> +/*
> + * al_find_ex
> + *
> + * finds the first le in the list which matches type, name and vcn
> + * Returns NULL if not found
> + */
> +struct ATTR_LIST_ENTRY *al_find_ex(struct ntfs_inode *ni,
> +				   struct ATTR_LIST_ENTRY *le,
> +				   enum ATTR_TYPE type, const __le16 *name,
> +				   u8 name_len, const CLST *vcn)
> +{
> +	struct ATTR_LIST_ENTRY *ret = NULL;
> +	u32 type_in = le32_to_cpu(type);
> +
> +	while ((le = al_enumerate(ni, le))) {
> +		u64 le_vcn;
> +		int diff;
> +
> +		/* List entries are sorted by type, name and vcn */

Isn't name sorted with upcase sort.

> +		diff = le32_to_cpu(le->type) - type_in;
> +		if (diff < 0)
> +			continue;
> +
> +		if (diff > 0)
> +			return ret;
> +
> +		if (le->name_len != name_len)
> +			continue;
> +
> +		if (name_len &&
> +		    memcmp(le_name(le), name, name_len * sizeof(short)))
> +			continue;

So does this compare name correctly? So it is caller responsible that
name is up_cased? Or does it even mater.

And this will check every name in right type. Why not use name_cmp and
then we know if we over. It might be because performance. But maybe
we can check that like every 10 iteration or something.

> +		if (!vcn)
> +			return le;
> +
> +		le_vcn = le64_to_cpu(le->vcn);
> +		if (*vcn == le_vcn)
> +			return le;
> +
> +		if (*vcn < le_vcn)
> +			return ret;
> +
> +		ret = le;

So we still have wrong vcn at this point. And we save that so we can
return it. What happens if we will not found right one. Atlest function 
comment say that we should return NULL if we do not found matching entry.

> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * al_find_le_to_insert
> + *
> + * finds the first list entry which matches type, name and vcn

This comment seems wrong? This seems to find insert point for new
le.

> + * Returns NULL if not found
> + */
> +static struct ATTR_LIST_ENTRY *
> +al_find_le_to_insert(struct ntfs_inode *ni, enum ATTR_TYPE type,
> +		     const __le16 *name, u8 name_len, const CLST *vcn)
> +{
> +	struct ATTR_LIST_ENTRY *le = NULL, *prev;
> +	u32 type_in = le32_to_cpu(type);
> +	int diff;
> +
> +	/* List entries are sorted by type, name, vcn */
> +next:
> +	le = al_enumerate(ni, prev = le);
> +	if (!le)
> +		goto out;
> +	diff = le32_to_cpu(le->type) - type_in;
> +	if (diff < 0)
> +		goto next;
> +	if (diff > 0)
> +		goto out;
> +
> +	if (ntfs_cmp_names(name, name_len, le_name(le), le->name_len, NULL) > 0)
> +		goto next;

Why not go out if compare is < 0. In my mind this will totally ignore
name and next just find right vcn (or we come next ID) and call it a day. 

NAME	VCN
[AAB]	[2] <- Looks insert point for this.

[AAA]	[1]
[AAB]	[1]
	    <- This is right point.
[AAC]	[1]
	    <- But we tell that insert point is here.
[AAD]	[2]

I might be totally wrong but please tell me what I'm missing.

> +	if (!vcn || *vcn > le64_to_cpu(le->vcn))
> +		goto next;
> +
> +out:
> +	if (!le)
> +		le = prev ? Add2Ptr(prev, le16_to_cpu(prev->size)) :
> +			    ni->attr_list.le;
> +
> +	return le;
> +}

There seems to be lot of linear list search. Do you think it will be
benefital to code binary or jump search for them? Just asking for
intrest. Might be that it will not benefit at all but just thinking
here.

I might try to do that in some point if someone see point of that.
