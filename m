Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1DB2E8EF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 00:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbhACXSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 18:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbhACXSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 18:18:40 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EEBC061573;
        Sun,  3 Jan 2021 15:17:59 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id h22so60557554lfu.2;
        Sun, 03 Jan 2021 15:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BAvAQQ+kFb6MYxJyXY6rcBWKb+4Ftoc7s8FLX1WY9Gs=;
        b=gynPkt3ezVczKuRJ8Of69KnuHHieIGlemh74sSHl1iekRBAqH7UgnMfYovP15R/cBf
         Ejnu+46GhT0oMsiEUb49KAOTtBZQlmFh84nl3w3GRKpn7waLfhcYLoXX8rpsLthgBucM
         PzNeGXthBqE4S8b3vZOF1p7uGIaONaeurCgTjpWfZFF1sXu2WFkSO2xnIpuILx77DSyt
         SJMkW+4dHVqmFc9HCwuHAIe5wtKF7c8EpzM2tUOJdEXvdfJtxlOj2qDexwwXZKySMnBr
         MRKOxboObO9eJ+e05IvHpe8cJSFP5pwcgQ4qRLuSbPCOWszxKGjr36v1IzI+eRKq6caI
         YHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BAvAQQ+kFb6MYxJyXY6rcBWKb+4Ftoc7s8FLX1WY9Gs=;
        b=JNX0birjO0K65kRoJQ8W8lb5VoeqZ2liELFi2LlGozPyO87Bt//i1wsb/Y8jITxTA5
         MVwtT3JkJdz4o93Q6nifXkgFZCVIcPRsBpL0ov7gxAHXRS/0u74xuEs4iNR706/Gem/p
         PaWDv3tsr7KgZ6PFQ7j1y6ch8mBhiBdCq7opZkjAhGa2Vq9jrM5bdaMuJ2gq+FzFZTaL
         HqbU80Xs4LIJ9FT1SG0Ng6Y0H3HP91Uc0RUSqd1R/7nlfkjcSMgrdD6K7/lYxyQ+90QF
         Qj7nd8ysirlabADpkq7Q3A+sgtVlcfP4ITMyaU8Vd+xSsZRFHRFsy89ISXsD14dF2Sg/
         jHNQ==
X-Gm-Message-State: AOAM530HTx/WjLaZv7HDyLI+RLvtJ80rUxjUvpN/5KOnB+F9dlKP/8zO
        JNeZ9Dc4EHhVqLl2FjcmaNI=
X-Google-Smtp-Source: ABdhPJzX1PcNnVbkJVDLB865DWzaUFjzCANnvqsk8a3Ro+ia0/OP7x2mrIwcWTXg1ziTWziZmzXFRw==
X-Received: by 2002:a2e:8695:: with SMTP id l21mr36488941lji.151.1609715878235;
        Sun, 03 Jan 2021 15:17:58 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id c142sm7132529lfg.309.2021.01.03.15.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:17:57 -0800 (PST)
Date:   Mon, 4 Jan 2021 01:17:55 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v17 01/10] fs/ntfs3: Add headers and misc files
Message-ID: <20210103231755.bcmyalz3maq4ama2@kari-VirtualBox>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-2-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231152401.3162425-2-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 31, 2020 at 06:23:52PM +0300, Konstantin Komarov wrote:

> diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h

> +/*
> + * Logging macros ( thanks Joe Perches <joe@perches.com> for implementation )
> + */
> +
> +#define ntfs_err(sb, fmt, ...)  ntfs_printk(sb, KERN_ERR fmt, ##__VA_ARGS__)
> +#define ntfs_warn(sb, fmt, ...) ntfs_printk(sb, KERN_WARNING fmt, ##__VA_ARGS__)
> +#define ntfs_info(sb, fmt, ...) ntfs_printk(sb, KERN_INFO fmt, ##__VA_ARGS__)
> +#define ntfs_notice(sb, fmt, ...)                                              \
> +	ntfs_printk(sb, KERN_NOTICE fmt, ##__VA_ARGS__)
> +
> +#define ntfs_inode_err(inode, fmt, ...)                                        \
> +	ntfs_inode_printk(inode, KERN_ERR fmt, ##__VA_ARGS__)
> +#define ntfs_inode_warn(inode, fmt, ...)                                       \
> +	ntfs_inode_printk(inode, KERN_WARNING fmt, ##__VA_ARGS__)
> +
> +#define ntfs_alloc(s, z)	kmalloc(s, (z) ? (GFP_NOFS | __GFP_ZERO) : GFP_NOFS)

kmalloc with __GFP_ZERO is just kzalloc. So why we even need ntfs_alloc(). We
will be much happier if we straight away see

kzalloc( , GFP_NOFS) or kmalloc( , GFP_NOFS)

That way it will be easier to remove GFP_NOFS flag when not needed.
I have not knowledge but I have read that even with filesystems it
is not good pratice to always use that flag. Another point is that
we will get these defines deleted from debug.h. Atleast to me this
is strange place for them. And also this not even save line space
much.

kzalloc( , GFP_NOFS)
ntfs_alloc( , 0)

ntfs_free()
kree()

I can send patch fror this if you prefer this way. And nobady not
nack about it.

> +#define ntfs_free(p)		kfree(p)
> +#define ntfs_memdup(src, len)	kmemdup(src, len, GFP_NOFS)

> diff --git a/fs/ntfs3/upcase.c b/fs/ntfs3/upcase.c

> +static inline u16 upcase_unicode_char(const u16 *upcase, u16 chr)
> +{
> +	if (chr < 'a')
> +		return chr;
> +
> +	if (chr <= 'z')
> +		return chr - ('a' - 'A');
> +
> +	return upcase[chr];
> +}
> +
> +int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
> +		   const u16 *upcase)
> +{
> +	int diff;
> +	size_t len = l1 < l2 ? l1 : l2;
> +
> +	if (upcase) {
> +		while (len--) {
> +			diff = upcase_unicode_char(upcase, le16_to_cpu(*s1++)) -
> +			       upcase_unicode_char(upcase, le16_to_cpu(*s2++));
> +			if (diff)
> +				return diff;
> +		}
> +	} else {
> +		while (len--) {
> +			diff = le16_to_cpu(*s1++) - le16_to_cpu(*s2++);
> +			if (diff)
> +				return diff;
> +		}
> +	}
> +
> +	return (int)(l1 - l2);
> +}

I notice that these functions might call both ignore case and upcase in a row.
record.c - compare_attr()
index.c - cmp_fnames()

So maybe we can add bool bothcases.

int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
		   const u16 *upcase, bool bothcase)
{
	int diff1 = 0;
	int diff2;
	size_t len = l1 < l2 ? l1 : l2;

	if (!bothcase && upcase)
		goto case_insentive;

	for (; len; s1++, s2++, len--) {
		diff1 = le16_to_cpu(*s1) - le16_to_cpu(*s2);
		if (diff1) {
			if (bothcase && upcase)
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

	if (bothcase && diff1)
		return diff1;

	return l1 - l2;
}

This is not tested. I can send patch for this also if you like idea.
cmp_fnames() and compare_attr() will clean up alot with this.

> +
> +int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
> +		       const u16 *upcase)
> +{
> +	const u16 *s1 = uni1->name;
> +	const __le16 *s2 = uni2->name;
> +	size_t l1 = uni1->len;
> +	size_t l2 = uni2->len;
> +	size_t len = l1 < l2 ? l1 : l2;
> +	int diff;
> +
> +	if (upcase) {
> +		while (len--) {
> +			diff = upcase_unicode_char(upcase, *s1++) -
> +			       upcase_unicode_char(upcase, le16_to_cpu(*s2++));
> +			if (diff)
> +				return diff;
> +		}
> +	} else {
> +		while (len--) {
> +			diff = *s1++ - le16_to_cpu(*s2++);
> +			if (diff)
> +				return diff;
> +		}
> +	}
> +
> +	return l1 - l2;
> +}
