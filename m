Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95E3189347
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 01:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCRApP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 20:45:15 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:18698 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgCRApP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:45:15 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200318004511epoutp01dfb7bd20df715f5f4d5f01a72c81eb70~9P1zWcnvg1091210912epoutp01Q
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2020 00:45:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200318004511epoutp01dfb7bd20df715f5f4d5f01a72c81eb70~9P1zWcnvg1091210912epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584492311;
        bh=xflZ5naocjES2lNG2CE/e+guTevV4zS2t2WzjlStQJg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=X55crc4VWfr+u5R+U6AgJOKd10bV+8Do7kPYZueVqnWgn5U4Q45IVOGgFgLjH5V21
         AwjanMINV9MuAYMVGiqgqdDTdZtdt0shbW5BLv8b7kWYlu3/r39sX+55zjVfaUbeNq
         3a9VjJAjbRkOn5GmfeJ2qJygGCDeub3XDtGGFKa0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200318004511epcas1p49bd87026b8ed5c723d8c751dea02a530~9P1yyabXJ1737117371epcas1p4_;
        Wed, 18 Mar 2020 00:45:11 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48hrsy1SB6zMqYm3; Wed, 18 Mar
        2020 00:45:10 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.E6.04071.61F617E5; Wed, 18 Mar 2020 09:45:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200318004509epcas1p46dc21b5922471d9441a2880fe8b8a565~9P1xWuo191737117371epcas1p46;
        Wed, 18 Mar 2020 00:45:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200318004509epsmtrp18f2185ebc817b88325467dbdc83e2ea6~9P1xWC4x10331703317epsmtrp1c;
        Wed, 18 Mar 2020 00:45:09 +0000 (GMT)
X-AuditID: b6c32a37-797ff70000000fe7-9c-5e716f167307
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.E1.04024.51F617E5; Wed, 18 Mar 2020 09:45:09 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200318004509epsmtip1975667e1191e2ea81fa1f5e9382d8099~9P1xK3tJl2068620686epsmtip1j;
        Wed, 18 Mar 2020 00:45:09 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Joe Perches'" <joe@perches.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Alexander Viro'" <viro@zeniv.linux.org.uk>
In-Reply-To: <12f7e30cabca4cb16989a65ab0fb69f8457d53b2.camel@perches.com>
Subject: RE: [PATCH] exfat: Remove unnecessary newlines from logging
Date:   Wed, 18 Mar 2020 09:45:09 +0900
Message-ID: <000601d5fcbe$79d90830$6d8b1890$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ7S+dG6Sk9dDatxIqd+7FdiHfmbwLX4tnmpuwiYhA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmrq5YfmGcwbSV3Baz7z9msdiz9ySL
        xeVdc9gstvw7wmpx/u9xVgdWjy+rrjF79G1ZxejxeZOcx6Ynb5kCWKJybDJSE1NSixRS85Lz
        UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
        8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS9ZLzc60MDQyMTIEqE3IyljVNZC/oM6vYvCSg
        gfGmVhcjJ4eEgInE9U+NzCC2kMAORokvH6Ig7E+MErvfOHcxcgHZ3xglDv2bzAbT8PzoWSaI
        xF5GiT03L7NBOC8ZJTp/3WAEqWIT0JX492c/WIeIgKrEhzszmUGKmAUWMEps3HSUFSTBKeAp
        cejtQrAiYQEXiff968BsFqCGF5/ms4DYvAKWElNuPWWDsAUlTs58AhZnFpCX2P52DjPESQoS
        P58uY4VYZiXx92MrO0SNiMTszjawxRIC99kkVlxcxAjR4CLR+u4QO4QtLPHq+BYoW0riZX8b
        kM0BZFdLfNwPNb+DUeLFd1sI21ji5voNrCAlzAKaEut36UOEFSV2/p7LCLGWT+Ld1x5WiCm8
        Eh1tQhAlqhJ9lw4zQdjSEl3tH9gnMCrNQvLYLCSPzULywCyEZQsYWVYxiqUWFOempxYbFhgj
        R/UmRnCK1DLfwbjhnM8hRgEORiUeXo4NBXFCrIllxZW5hxglOJiVRHgXF+bHCfGmJFZWpRbl
        xxeV5qQWH2I0BYb7RGYp0eR8YPrOK4k3NDUyNja2MDEzNzM1VhLnnXo9J05IID2xJDU7NbUg
        tQimj4mDU6qB0atD7cTlexM+hW9PO8TD2X9Nbv2ixv9RZV1audIXHKTmG71mUdwuu/1AlXmH
        U5Sh8dzTkd0u3zJ2W08/3HRiDac3S+eTgEfZh+czS4vN4jg29dbU4qDXTg1r+1+8kp2T9vzM
        0vflKhPFu9mVpE86NMz4/ePh6cYny7NvtKeqq/x87t2+x6vtpRJLcUaioRZzUXEiAGMGeSen
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnK5ofmGcwZLfqhaz7z9msdiz9ySL
        xeVdc9gstvw7wmpx/u9xVgdWjy+rrjF79G1ZxejxeZOcx6Ynb5kCWKK4bFJSczLLUov07RK4
        MpY1TWQv6DOr2LwkoIHxplYXIyeHhICJxPOjZ5m6GLk4hAR2M0o8X9jHCJGQljh24gxzFyMH
        kC0scfhwMUTNc0aJ3oUTmUBq2AR0Jf792c8GYosIqEp8uDOTGaSIWWARo8Tn7TtZQBJCArMY
        JS5uEgOxOQU8JQ69XQjWICzgIvG+fx2YzQLU/OLTfLB6XgFLiSm3nrJB2IISJ2c+YQE5gllA
        T6JtI9htzALyEtvfzmGGuFNB4ufTZawQN1hJ/P3Yyg5RIyIxu7ONeQKj8Cwkk2YhTJqFZNIs
        JB0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEx4qW5g7Gy0viDzEKcDAq8fAm
        bCqIE2JNLCuuzD3EKMHBrCTCu7gwP06INyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJ
        JanZqakFqUUwWSYOTqkGxoYPB5bZXHnZEvDj3aYHR0/aHp238J6qnMXVb2dZj+Z9MhLZ5/HF
        zX/B/Y6YmaY/e/4dP/JjCXvD9ae74w/UC2hGLfUv/hY9beZcbQu34sgi4Q0BSS92zSko3JQq
        OYshsCcg4Prvrl3vi2dvn7u1hd3ypre34ketjIct88r9zyoZ/Vs448dp0etKLMUZiYZazEXF
        iQAGO3ehkQIAAA==
X-CMS-MailID: 20200318004509epcas1p46dc21b5922471d9441a2880fe8b8a565
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200317234424epcas1p2e6a1a1b3e261dd6c23174dbf977633f3
References: <CGME20200317234424epcas1p2e6a1a1b3e261dd6c23174dbf977633f3@epcas1p2.samsung.com>
        <12f7e30cabca4cb16989a65ab0fb69f8457d53b2.camel@perches.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> None of these message formats should end in a newline as exfat_msg and its
> callers already appends messages with one.
> 
> Miscellanea:
> 
> o Remove unnecessary trailing periods from formats.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
Looks good!
Acked-by: Namjae Jeon <namjae.jeon@samsung.com>

Thanks!
> ---
>  fs/exfat/dir.c    | 4 ++--
>  fs/exfat/fatent.c | 8 ++++----
>  fs/exfat/file.c   | 2 +-
>  fs/exfat/inode.c  | 6 +++---
>  fs/exfat/misc.c   | 2 +-
>  fs/exfat/nls.c    | 4 ++--
>  fs/exfat/super.c  | 4 ++--
>  7 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index 4b91af..a213520 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -750,7 +750,7 @@ struct exfat_dentry *exfat_get_dentry(struct
> super_block *sb,
>  	sector_t sec;
> 
>  	if (p_dir->dir == DIR_DELETED) {
> -		exfat_msg(sb, KERN_ERR, "abnormal access to deleted
> dentry\n");
> +		exfat_msg(sb, KERN_ERR, "abnormal access to deleted
dentry");
>  		return NULL;
>  	}
> 
> @@ -853,7 +853,7 @@ struct exfat_entry_set_cache
> *exfat_get_dentry_set(struct super_block *sb,
>  	struct buffer_head *bh;
> 
>  	if (p_dir->dir == DIR_DELETED) {
> -		exfat_msg(sb, KERN_ERR, "access to deleted dentry\n");
> +		exfat_msg(sb, KERN_ERR, "access to deleted dentry");
>  		return NULL;
>  	}
> 
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c index a855b17..dcf840
> 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -305,7 +305,7 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned
> int clu)
>  	return 0;
> 
>  release_bhs:
> -	exfat_msg(sb, KERN_ERR, "failed zeroed sect %llu\n",
> +	exfat_msg(sb, KERN_ERR, "failed zeroed sect %llu",
>  		(unsigned long long)blknr);
>  	for (i = 0; i < n; i++)
>  		bforget(bhs[i]);
> @@ -325,7 +325,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned
> int num_alloc,
> 
>  	if (unlikely(total_cnt < sbi->used_clusters)) {
>  		exfat_fs_error_ratelimit(sb,
> -			"%s: invalid used clusters(t:%u,u:%u)\n",
> +			"%s: invalid used clusters(t:%u,u:%u)",
>  			__func__, total_cnt, sbi->used_clusters);
>  		return -EIO;
>  	}
> @@ -338,7 +338,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned
> int num_alloc,
>  	if (hint_clu == EXFAT_EOF_CLUSTER) {
>  		if (sbi->clu_srch_ptr < EXFAT_FIRST_CLUSTER) {
>  			exfat_msg(sb, KERN_ERR,
> -				"sbi->clu_srch_ptr is invalid (%u)\n",
> +				"sbi->clu_srch_ptr is invalid (%u)",
>  				sbi->clu_srch_ptr);
>  			sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
>  		}
> @@ -350,7 +350,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned
> int num_alloc,
> 
>  	/* check cluster validation */
>  	if (hint_clu < EXFAT_FIRST_CLUSTER && hint_clu >= sbi->num_clusters)
> {
> -		exfat_msg(sb, KERN_ERR, "hint_cluster is invalid (%u)\n",
> +		exfat_msg(sb, KERN_ERR, "hint_cluster is invalid (%u)",
>  			hint_clu);
>  		hint_clu = EXFAT_FIRST_CLUSTER;
>  		if (p_chain->flags == ALLOC_NO_FAT_CHAIN) { diff --git
> a/fs/exfat/file.c b/fs/exfat/file.c index 483f68..146024 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -235,7 +235,7 @@ void exfat_truncate(struct inode *inode, loff_t size)
>  		/*
>  		 * Empty start_clu != ~0 (not allocated)
>  		 */
> -		exfat_fs_error(sb, "tried to truncate zeroed cluster.");
> +		exfat_fs_error(sb, "tried to truncate zeroed cluster");
>  		goto write_size;
>  	}
> 
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c index 068874..a84819
> 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -181,7 +181,7 @@ static int exfat_map_cluster(struct inode *inode,
> unsigned int clu_offset,
>  		/* allocate a cluster */
>  		if (num_to_be_allocated < 1) {
>  			/* Broken FAT (i_sze > allocated FAT) */
> -			exfat_fs_error(sb, "broken FAT chain.");
> +			exfat_fs_error(sb, "broken FAT chain");
>  			return -EIO;
>  		}
> 
> @@ -351,7 +351,7 @@ static int exfat_get_block(struct inode *inode,
> sector_t iblock,
>  		err = exfat_map_new_buffer(ei, bh_result, pos);
>  		if (err) {
>  			exfat_fs_error(sb,
> -					"requested for bmap out of range(pos
:
> (%llu) > i_size_aligned(%llu)\n",
> +					"requested for bmap out of range(pos
:
> (%llu) >
> +i_size_aligned(%llu)",
>  					pos, ei->i_size_aligned);
>  			goto unlock_ret;
>  		}
> @@ -428,7 +428,7 @@ static int exfat_write_end(struct file *file, struct
> address_space *mapping,
> 
>  	if (EXFAT_I(inode)->i_size_aligned < i_size_read(inode)) {
>  		exfat_fs_error(inode->i_sb,
> -			"invalid size(size(%llu) > aligned(%llu)\n",
> +			"invalid size(size(%llu) > aligned(%llu)",
>  			i_size_read(inode), EXFAT_I(inode)->i_size_aligned);
>  		return -EIO;
>  	}
> diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c index 14a330..d480b5a
> 100644
> --- a/fs/exfat/misc.c
> +++ b/fs/exfat/misc.c
> @@ -32,7 +32,7 @@ void __exfat_fs_error(struct super_block *sb, int
report,
> const char *fmt, ...)
>  		va_start(args, fmt);
>  		vaf.fmt = fmt;
>  		vaf.va = &args;
> -		exfat_msg(sb, KERN_ERR, "error, %pV\n", &vaf);
> +		exfat_msg(sb, KERN_ERR, "error, %pV", &vaf);
>  		va_end(args);
>  	}
> 
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c index 6d1c3a..9e07e1 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -688,7 +688,7 @@ static int exfat_load_upcase_table(struct super_block
> *sb,
>  		bh = sb_bread(sb, sector);
>  		if (!bh) {
>  			exfat_msg(sb, KERN_ERR,
> -				"failed to read sector(0x%llx)\n",
> +				"failed to read sector(0x%llx)",
>  				(unsigned long long)sector);
>  			ret = -EIO;
>  			goto free_table;
> @@ -723,7 +723,7 @@ static int exfat_load_upcase_table(struct super_block
> *sb,
>  		return 0;
> 
>  	exfat_msg(sb, KERN_ERR,
> -			"failed to load upcase table (idx : 0x%08x, chksum :
> 0x%08x, utbl_chksum : 0x%08x)\n",
> +			"failed to load upcase table (idx : 0x%08x, chksum :
> 0x%08x,
> +utbl_chksum : 0x%08x)",
>  			index, checksum, utbl_checksum);
>  	ret = -EINVAL;
>  free_table:
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index 16ed202e..3e3c606
> 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -573,7 +573,7 @@ static int exfat_fill_super(struct super_block *sb,
> struct fs_context *fc)
> 
>  	root_inode = new_inode(sb);
>  	if (!root_inode) {
> -		exfat_msg(sb, KERN_ERR, "failed to allocate root inode.");
> +		exfat_msg(sb, KERN_ERR, "failed to allocate root inode");
>  		err = -ENOMEM;
>  		goto free_table;
>  	}
> @@ -582,7 +582,7 @@ static int exfat_fill_super(struct super_block *sb,
> struct fs_context *fc)
>  	inode_set_iversion(root_inode, 1);
>  	err = exfat_read_root(root_inode);
>  	if (err) {
> -		exfat_msg(sb, KERN_ERR, "failed to initialize root inode.");
> +		exfat_msg(sb, KERN_ERR, "failed to initialize root inode");
>  		goto put_inode;
>  	}
> 


