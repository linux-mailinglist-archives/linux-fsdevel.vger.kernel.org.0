Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECD43418D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 10:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCSJx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 05:53:26 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:60938 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhCSJxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:53:06 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210319095304epoutp01c7012822cecdc982f795e14c986a13fd~ttapq8JJq2997729977epoutp01S
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 09:53:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210319095304epoutp01c7012822cecdc982f795e14c986a13fd~ttapq8JJq2997729977epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616147584;
        bh=hQUQLvKMxc1O4fnMYJ6ryHc1801SMoggfFnL74Izkqo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Cu6aUar3ZVsTsbFGOFjB0t34W9RJ+yG5+MVkdUb04NkLztLwFwygz6q9Vfoy3D6pP
         GIkgUMHB+80N3px7uqzJAjrPx9WNZBYLv1ZcLRtdqegUs55/5ss/lye2qDrYB4hZBc
         5AyLtyEOEn+RnTfsrHE9oruyUHD/Va/VYVIWRAZo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210319095304epcas1p4c1ee2502f24053ff6279f8e7e39743e6~ttapalk7Q2795727957epcas1p4n;
        Fri, 19 Mar 2021 09:53:04 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.161]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4F1zjC1Nfxz4x9Pr; Fri, 19 Mar
        2021 09:53:03 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.C3.63458.F7474506; Fri, 19 Mar 2021 18:53:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210319095302epcas1p174994dc0d98fb576a920e05e4078863a~ttanZZwdA0986509865epcas1p1k;
        Fri, 19 Mar 2021 09:53:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210319095302epsmtrp110df1169bfa25bac8177a73c479e2367~ttanYmNrx2034820348epsmtrp1W;
        Fri, 19 Mar 2021 09:53:02 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-a1-6054747ff240
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.C3.08745.E7474506; Fri, 19 Mar 2021 18:53:02 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210319095302epsmtip256c0b749176f550a60dda7efec5113f6~ttanChq6s2989729897epsmtip2V;
        Fri, 19 Mar 2021 09:53:01 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Hyeongseok Kim'" <hyeongseok@gmail.com>,
        <namjae.jeon@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <20210318064132.78752-1-hyeongseok@gmail.com>
Subject: RE: [PATCH v2] exfat: speed up iterate/lookup by fixing start point
 of traversing cluster chain
Date:   Fri, 19 Mar 2021 18:53:02 +0900
Message-ID: <b88e01d71ca5$a6e424b0$f4ac6e10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJSXJp2VpJLuZZWgh8bHuKYTJrI4AJgJpPZqYA9g1A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTV7e+JCTBYFEjh8XfiZ+YLPbsPcli
        cXnXHDaLH9PrLbb8O8LqwOqxc9Zddo++LasYPT5vkgtgjsqxyUhNTEktUkjNS85PycxLt1Xy
        Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
        Ly6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0MDAyBapMyMn49+wXS8FZ2Ypnrz+zNTAuEOti
        5OSQEDCR2L/vNlMXIxeHkMAORomHMx8zgiSEBD4xSlx9HQ2R+Mwo8WD/TxaYjks/GlggErsY
        JW50bIJyXjJKbHt5gB2kik1AV+LJjZ/MILaIgIfE46ZjTCA2s0C8xO5pfWArOAWsJE42LQKL
        CwtkSbzvvQe2gUVAVeL7jQlgc3gFLCXObrjDCGELSpyc+YQFYo68xPa3c5ghLlKQ2P3pKCvE
        LiuJ2X/vQ9WISMzubGMGOU5C4Cu7xMMlHVANLhLXX29lhLCFJV4d38IOYUtJvOxvg7LrJf7P
        X8sO0dwCDJhP24Au5QBy7CXeX7IAMZkFNCXW79KHKFeU2Pl7LiPEXj6Jd197WCGqeSU62oQg
        SlQkvn/YyQKz6cqPq0wTGJVmIflsFpLPZiH5YBbCsgWMLKsYxVILinPTU4sNC4yQI3sTIzg1
        apntYJz09oPeIUYmDsZDjBIczEoivCeSQxKEeFMSK6tSi/Lji0pzUosPMZoCw3ois5Rocj4w
        OeeVxBuaGhkbG1uYmJmbmRorifMmGjyIFxJITyxJzU5NLUgtgulj4uCUamBa0XJ61bRTxRdk
        E4UP5UzTvMZ+L4Q5PJyN5ZuimerR5g3u4nt6HllkcN37n/4v5dhDYQ9ZMwHl5hajF8+f+zEb
        bk2aKdBw+fcvU6e/DI+11nF8PvHFyGH15bP7Jt4u/X39/nv9SnfHewKLPrh8tjQ5xXDn08tA
        nue56zL2OF/RTnm8Oi+yJG3JP2EhruNhmvbf52iXP8g7IrgiQfthjE3eXZYKq0uzT+ycqrGu
        8c+/2e9PTb06m33OYa7tv14GvnFq91iwdu5608SFH/0al1e86Chgd3noKijRtHRLh6bDm0vX
        bO4wlD7b5Tj77uX/16Y5eT8sTDodnC3iIFkY/+va8868h7VPGf7wMB31f+tyWomlOCPRUIu5
        qDgRAFy4EDUWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvG5dSUiCwYRzwhZ/J35istiz9ySL
        xeVdc9gsfkyvt9jy7wirA6vHzll32T36tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoEr49+zXywF
        Z2Urnr3+zNbAuECsi5GTQ0LAROLSjwaWLkYuDiGBHYwSHbt2AzkcQAkpiYP7NCFMYYnDh4sh
        Sp4zSlzbPJkdpJdNQFfiyY2fzCC2iICXxP6m12BxZoFEieYvl5ggGroZJVpW9zGCJDgFrCRO
        Ni1iArGFBTIk/v67xgZiswioSny/MQGsmVfAUuLshjuMELagxMmZT8DuYRbQk2jbyAgxX15i
        +9s5zBD3K0js/nSUFeIGK4nZf++zQNSISMzubGOewCg8C8mkWQiTZiGZNAtJxwJGllWMkqkF
        xbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMHxoaW1g3HPqg96hxiZOBgPMUpwMCuJ8J5IDkkQ
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqganefO392y+e
        2uQscT2txyO0VNIqUnOqxZ6JrzesPmrP12L6WzWv5phtj/hDdeUqvs69tVuSEmets7Lm7u/8
        mC6wbsaNSVrOCUYfxR0eBF3vSJJlmMZVrKd69M8blfmFPj5Lcw6EfHpiL902N/uk0DzBzbey
        mAX1foRzzeFTZJunmrjYzsG4/OlVKbZlj5uWBC39NKWydNemmDyz/FjLlqnlixt5thVWsrjx
        HC/6NsX+F/9/3W//drnN+Xb4xJYJP/hyV/xi7uQ43vF37hZtjrhbUZ0Mj9+pX//8klPp8zdN
        8bMexw4cFj15/MUiNVnOM4YXlXaUCZQLLp/c1RZ1xlrRIbxQeVpJfASXUmlmohJLcUaioRZz
        UXEiAIPdF3X+AgAA
X-CMS-MailID: 20210319095302epcas1p174994dc0d98fb576a920e05e4078863a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210318064206epcas1p442b4ed65b1c14b1df56d3560612de668
References: <CGME20210318064206epcas1p442b4ed65b1c14b1df56d3560612de668@epcas1p4.samsung.com>
        <20210318064132.78752-1-hyeongseok@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> When directory iterate and lookup is called, there's a buggy rewinding of
> start point for traversing cluster chain to the parent directory entry's
> first cluster. This caused repeated cluster chain traversing from the
> first entry of the parent directory that would show worse performance if
> huge amounts of files exist under the parent directory.
> Fix not to rewind, make continue from currently referenced cluster and dir
> entry.
> 
> Tested with 50,000 files under single directory / 256GB sdcard, with
> command "time ls -l > /dev/null",
> Before :     0m08.69s real     0m00.27s user     0m05.91s system
> After  :     0m07.01s real     0m00.25s user     0m04.34s system
> 
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
> ---
>  fs/exfat/dir.c      | 39 ++++++++++++++++++++++++++++++++-------
>  fs/exfat/exfat_fs.h |  2 +-
>  fs/exfat/namei.c    |  6 ++++--
>  3 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> e1d5536de948..63f08987a8fe 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -147,7 +147,7 @@ static int exfat_readdir(struct inode *inode, loff_t
> *cpos, struct exfat_dir_ent
[snip]
> + * @de:         If p_uniname is found, filled with optimized dir/entry
> + *              for traversing cluster chain. Basically,
> + *              (p_dir.dir+return entry) and (de.dir.dir+de.entry) are
> + *              pointing the same physical directory entry, but if
> + *              caller needs to start to traverse cluster chain,
> + *              it's better option to choose the information in de.
> + *              Caller could only trust .dir and .entry field.

exfat-fs has exfat_hint structure for keeping clusters and entries as hints.
Of course, the caller, exfat_find(), should adjust exfat_chain with
hint value just before calling exfat_get_dentry_set() as follows.

        /* adjust cdir to the optimized value */
        cdir.dir = hint_opt.clu;
        if (cdir.flag & ALLOC_NO_FAT_CHAIN) {
                cdir.size -= dentry / sbi->dentries_per_clu;
        dentry = hint_opt.eidx;

What do you think about using it?

> + * @return:
> + *   >= 0:      file directory entry position where the name exists
> + *   -ENOENT:   entry with the name does not exist
> + *   -EIO:      I/O error
>   */
[snip]
> @@ -1070,11 +1081,14 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
>  		}
> 
>  		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
> -			if (--clu.size > 0)
> +			if (--clu.size > 0) {
> +				exfat_chain_dup(&de->dir, &clu);

If you want to make a backup of the clu, it seems more appropriate to move
exfat_chain_dup() right above the "if".

>  				clu.dir++;
> +			}
>  			else
>  				clu.dir = EXFAT_EOF_CLUSTER;
>  		} else {
> +			exfat_chain_dup(&de->dir, &clu);
>  			if (exfat_get_next_cluster(sb, &clu.dir))
>  				return -EIO;
>  		}
> @@ -1101,6 +1115,17 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
>  	return -ENOENT;
> 
>  found:
> +	/* set as dentry in cluster */
> +	de->entry = (dentry - num_ext) & (dentries_per_clu - 1);
> +	/*
> +	 * if dentry_set spans to the next_cluster,
> +	 * e.g. (de->entry + num_ext + 1 > dentries_per_clu)
> +	 * current de->dir is correct which have previous cluster info,
> +	 * but if it doesn't span as below, "clu" is correct, so update.
> +	 */
> +	if (de->entry + num_ext + 1 <= dentries_per_clu)
> +		exfat_chain_dup(&de->dir, &clu);
> +

Let it be simple.
1. Keep an old value in the stack variable, when it found a FILE or DIR
entry.
2. And just copy that here.

There are more assignments, but I think its impact might be negligible.
Thanks.

