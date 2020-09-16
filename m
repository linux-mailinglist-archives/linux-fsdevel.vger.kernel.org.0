Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7953E26BA09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 04:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgIPCXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 22:23:23 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:26060 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgIPCXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:23:18 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200916022314epoutp01875e93626531b03297cbd90033b82d4b~1IlXHZTzv0899608996epoutp01c
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 02:23:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200916022314epoutp01875e93626531b03297cbd90033b82d4b~1IlXHZTzv0899608996epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600222994;
        bh=RUkxGjoJHTxV+9unBl05oZRi2zZoszin3TMYq18G08E=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=iku/vKD6rnYl1bZQ5Vi9L7Y495cBwm/j7WvfWHxuaJakfmcU5pqDEQrj9pEGOXjCa
         QXKK68OPWomq0z9WWZqL68Vq2G1r1oyFSNDtyWuwqUv6QQLGkOrIUTjRt+D0rKFXVn
         sLg/YkqTJ7YwXgj3EDiGSR4VV58WA+jgN1qOBsCQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200916022313epcas1p1c3dc7e57c959f036cc81194ca9400b49~1IlWtzq-c1079710797epcas1p1F;
        Wed, 16 Sep 2020 02:23:13 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BrkR52DGtzMqYkm; Wed, 16 Sep
        2020 02:23:13 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.C3.29173.017716F5; Wed, 16 Sep 2020 11:23:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200916022312epcas1p493c4934bca0203679a32367ff5472549~1IlU7E3fw0382203822epcas1p4T;
        Wed, 16 Sep 2020 02:23:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200916022312epsmtrp293aac011acff9c48e186ed993362a01a~1IlU6WMG42038920389epsmtrp28;
        Wed, 16 Sep 2020 02:23:12 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-ec-5f6177104afe
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.28.08303.F07716F5; Wed, 16 Sep 2020 11:23:11 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200916022311epsmtip1ecaf3ec532e02e3b75b8e593e3d238c0~1IlUubj-M0164701647epsmtip1O;
        Wed, 16 Sep 2020 02:23:11 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200911044519.13981-1-kohada.t2@gmail.com>
Subject: RE: [PATCH 3/3] exfat: replace memcpy with structure assignment
Date:   Wed, 16 Sep 2020 11:23:11 +0900
Message-ID: <015e01d68bd0$5324fe00$f96efa00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIymYVYvhNfeAT30ihzwZ6Ldl+/FgEhire6qKlhCeA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmga5AeWK8wcGdQhY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwReXYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0
        MDAyBapMyMmYtNW54J1sxdTL+9kbGA+LdzFyckgImEh82LaZrYuRi0NIYAejxM5vCxhBEkIC
        nxglvmxIhUh8ZpTo3PCfHaZjzZlPzBCJXYwS99rvQTkvGSUmrj7OAlLFJqAr8eTGT2YQW0RA
        T+LkyetsIDazQCOTxImX2SA2p4ClxJ6d/8HWCQt4SGy50QHWyyKgKrGqdzUriM0LVPPo3Gwm
        CFtQ4uTMJywQc+Qltr+dwwxxkYLE7k9HWSF2WUn0/fgJVSMiMbuzDapmJofEqafVELaLxIO7
        C6HiwhKvjm+B+kxK4vO7vWwQdr3E//lr2UEekxBoYZR4+Gkb0BEcQI69xPtLFiAms4CmxPpd
        +hDlihI7f89lhFjLJ/Huaw8rRDWvREebEESJisT3DztZYDZd+XGVaQKj0iwkj81C8tgsJA/M
        Qli2gJFlFaNYakFxbnpqsWGBMXJUb2IEJ1It8x2M095+0DvEyMTBeIhRgoNZSYT3QGN8vBBv
        SmJlVWpRfnxRaU5q8SFGU2BQT2SWEk3OB6byvJJ4Q1MjY2NjCxMzczNTYyVx3oe3FOKFBNIT
        S1KzU1MLUotg+pg4OKUamPr5irNc9Dgn9Yux5HTuFuct6M1eMX/q7m9c8VENF4Mt2UPtb3V9
        Spa6O+Gcz7xQEdfNe5+5dUrMN5g9X7UwRGPt9OLFYjLvmSPeHHQ//7BJ7GNip0/ius0OwSE7
        0quPxf1g295zYmdkqhhrlYvjrpmmzDvDE7bHnl1e88DwnnsL82KDie/WHhV9+4Lz6N6O0Njn
        u6WXfGFQ27apc0rD7Nv/PwRuX1Ay5WBN0DvJW6Esl/NZZd9LzFjfsuuUxF+v7Bk86QFr4u8/
        +8MdvPGd9BIDu9xkKUbRa9krtyS+PrNNU9hTuV71d1HzNrt2ifRV/1sW/LzMd9M/dMeTN+mT
        JRYdqWPpdjKVffWk9nJuoRJLcUaioRZzUXEiAOe0S8UtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTpe/PDHe4OsNS4sfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5NZLH5Mr3dg9/gy5zi7R9vkf+wezcdWsnnsnHWX3aNvyypG
        j8+b5ALYorhsUlJzMstSi/TtErgyJm11LngnWzH18n72BsbD4l2MnBwSAiYSa858YgaxhQR2
        MEpM2xTRxcgBFJeSOLhPE8IUljh8uLiLkQuo4jmjxNwNq5hAytkEdCWe3PgJ1ioioCdx8uR1
        NpAiZoFmJonWL81MEDO7GCVefjUBsTkFLCX27PzPCGILC3hIbLnRwQJiswioSqzqXc0KYvMC
        1Tw6N5sJwhaUODnzCQvIEcxAC9o2grUyC8hLbH87hxnifAWJ3Z+OskLcYCXR9+MnC0SNiMTs
        zjbmCYzCs5BMmoUwaRaSSbOQdCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREc
        TVpaOxj3rPqgd4iRiYPxEKMEB7OSCO+Bxvh4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxfZy2M
        ExJITyxJzU5NLUgtgskycXBKNTA5JD/9tflUUOxOfwvug2o3rFm/ia1uPlz7sZRzGxvv306D
        kliffZ3Xl72c/XJ/0uyb8ddeiVyb5Wb9R6SCL/lRoE+98opea66iT6YRaQYMbW2RN2tEBYr3
        uQtFu622y/Rc2yM4Mex6Ks+/BKWaN/y/Mx2tJr/btXtyfqOdapTl+ytbI/U8u/e/SVkuF3BY
        9bZGYI9eauq1CeXWtQ8cZ1nOVI35G9/z/nFaUoR72gEDryjzuosXmTSnPuDJd8y+HdaZ4c5x
        2PfSafPskE2KV/R2vxJ57S5su/QGU+nKNecsow4G2U67GyLuUbqqO+/jgu+GJjtmKz5xT6gP
        Obn9sa10xhvHaMtjc968/njQSImlOCPRUIu5qDgRANYBLUwVAwAA
X-CMS-MailID: 20200916022312epcas1p493c4934bca0203679a32367ff5472549
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200911044525epcas1p4a050411f3049c625b81c7d6516982537
References: <CGME20200911044525epcas1p4a050411f3049c625b81c7d6516982537@epcas1p4.samsung.com>
        <20200911044519.13981-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Use structure assignment instead of memcpy.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>

Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/dir.c   |  7 ++-----
>  fs/exfat/inode.c |  2 +-
>  fs/exfat/namei.c | 15 +++++++--------
>  3 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> fa5bb72aa295..8520decd120c 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -974,11 +974,8 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
>  					if (ei->hint_femp.eidx ==
>  							EXFAT_HINT_NONE ||
>  						candi_empty.eidx <=
> -							 ei->hint_femp.eidx)
{
> -						memcpy(&ei->hint_femp,
> -							&candi_empty,
> -
sizeof(candi_empty));
> -					}
> +							 ei->hint_femp.eidx)
> +						ei->hint_femp = candi_empty;
>  				}
> 
>  				brelse(bh);
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c index
> 70a33d4807c3..687f77653187 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -554,7 +554,7 @@ static int exfat_fill_inode(struct inode *inode,
> struct exfat_dir_entry *info)
>  	struct exfat_inode_info *ei = EXFAT_I(inode);
>  	loff_t size = info->size;
> 
> -	memcpy(&ei->dir, &info->dir, sizeof(struct exfat_chain));
> +	ei->dir = info->dir;
>  	ei->entry = info->entry;
>  	ei->attr = info->attr;
>  	ei->start_clu = info->start_clu;
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c index
> 1c433491f771..2932b23a3b6c 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -318,8 +318,7 @@ static int exfat_find_empty_entry(struct inode *inode,
>  	hint_femp.eidx = EXFAT_HINT_NONE;
> 
>  	if (ei->hint_femp.eidx != EXFAT_HINT_NONE) {
> -		memcpy(&hint_femp, &ei->hint_femp,
> -				sizeof(struct exfat_hint_femp));
> +		hint_femp = ei->hint_femp;
>  		ei->hint_femp.eidx = EXFAT_HINT_NONE;
>  	}
> 
> @@ -519,7 +518,7 @@ static int exfat_add_entry(struct inode *inode, const
> char *path,
>  	if (ret)
>  		goto out;
> 
> -	memcpy(&info->dir, p_dir, sizeof(struct exfat_chain));
> +	info->dir = *p_dir;
>  	info->entry = dentry;
>  	info->flags = ALLOC_NO_FAT_CHAIN;
>  	info->type = type;
> @@ -625,7 +624,7 @@ static int exfat_find(struct inode *dir, struct qstr
> *qname,
>  	if (dentry < 0)
>  		return dentry; /* -error value */
> 
> -	memcpy(&info->dir, &cdir.dir, sizeof(struct exfat_chain));
> +	info->dir = cdir;
>  	info->entry = dentry;
>  	info->num_subdirs = 0;
> 
> @@ -1030,7 +1029,7 @@ static int exfat_rename_file(struct inode *inode,
> struct exfat_chain *p_dir,
>  		if (!epnew)
>  			return -EIO;
> 
> -		memcpy(epnew, epold, DENTRY_SIZE);
> +		*epnew = *epold;
>  		if (exfat_get_entry_type(epnew) == TYPE_FILE) {
>  			epnew->dentry.file.attr |=
cpu_to_le16(ATTR_ARCHIVE);
>  			ei->attr |= ATTR_ARCHIVE;
> @@ -1050,7 +1049,7 @@ static int exfat_rename_file(struct inode *inode,
> struct exfat_chain *p_dir,
>  			return -EIO;
>  		}
> 
> -		memcpy(epnew, epold, DENTRY_SIZE);
> +		*epnew = *epold;
>  		exfat_update_bh(new_bh, sync);
>  		brelse(old_bh);
>  		brelse(new_bh);
> @@ -1113,7 +1112,7 @@ static int exfat_move_file(struct inode *inode,
> struct exfat_chain *p_olddir,
>  	if (!epnew)
>  		return -EIO;
> 
> -	memcpy(epnew, epmov, DENTRY_SIZE);
> +	*epnew = *epmov;
>  	if (exfat_get_entry_type(epnew) == TYPE_FILE) {
>  		epnew->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
>  		ei->attr |= ATTR_ARCHIVE;
> @@ -1133,7 +1132,7 @@ static int exfat_move_file(struct inode *inode,
> struct exfat_chain *p_olddir,
>  		return -EIO;
>  	}
> 
> -	memcpy(epnew, epmov, DENTRY_SIZE);
> +	*epnew = *epmov;
>  	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
>  	brelse(mov_bh);
>  	brelse(new_bh);
> --
> 2.25.1


