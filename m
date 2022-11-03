Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B369617D06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 13:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiKCMuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 08:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiKCMuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:50:01 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C18411C38
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 05:50:00 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221103124957epoutp02822d13d9822bedadd037597c334198fe~kFAqT8AGb2516625166epoutp02g
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 12:49:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221103124957epoutp02822d13d9822bedadd037597c334198fe~kFAqT8AGb2516625166epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667479797;
        bh=znlX5RKHDJ+ayCJjCIHaQMPd9t4Q8Zsw6ook6gubUo4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=o2nYGsjmM/emJ5qauRRZT1Hr+InraTSdkDm61LZMoY77eZd3IeiTJzIAhXuc/2LCM
         g0YmYfees+0nWuNquvxFeS6Mk89SRbO1TirzHKC5ipYppqsC2evR14ZULthuB+P8Qm
         2EI1FJf5YXy8fllXdOXSolt2i3MBjLHqspCiyQMk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20221103124957epcas1p486a3c4e9dcf8615b09c5de59600cbba0~kFAqAvbGu2192821928epcas1p4K;
        Thu,  3 Nov 2022 12:49:57 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.248]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N33W904Jdz4x9Pp; Thu,  3 Nov
        2022 12:49:57 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.87.20046.4F8B3636; Thu,  3 Nov 2022 21:49:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20221103124956epcas1p34c9cf3f29114e4f11f387b2ce5952eb7~kFAo1XFfz2280622806epcas1p3k;
        Thu,  3 Nov 2022 12:49:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221103124956epsmtrp15805e2e3b1d08c0ed1606472b433fe15~kFAo0ohKq1786917869epsmtrp1U;
        Thu,  3 Nov 2022 12:49:56 +0000 (GMT)
X-AuditID: b6c32a39-35fff70000004e4e-ba-6363b8f4189d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.F4.18644.3F8B3636; Thu,  3 Nov 2022 21:49:56 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221103124955epsmtip124ca3bf71747c139b0cbfdbadfd23e00~kFAosm77m2497524975epsmtip1Y;
        Thu,  3 Nov 2022 12:49:55 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB6316C6A981A51EA6C079455D81399@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v2 1/2] exfat: simplify empty entry hint
Date:   Thu, 3 Nov 2022 21:49:55 +0900
Message-ID: <4ea901d8ef82$c64b7310$52e25930$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHcv1k1HOc4p1+ptDfeX3TNB2EsPgGzhLa+rhfn5CA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmnu6XHcnJBudmmlpMnLaU2WLP3pMs
        Fpd3zWGz2PLvCKsDi8emVZ1sHn1bVjF6fN4kF8Ac1cBok1iUnJFZlqqQmpecn5KZl26rFBri
        pmuhpJCRX1xiqxRtaGikZ2hgrmdkZKRnbBlrZWSqpJCXmJtqq1ShC9WrpFCUXABUm1tZDDQg
        J1UPKq5XnJqX4pCVXwpyol5xYm5xaV66XnJ+rpJCWWJOKdAIJf2Eb4wZBy/2shf8latY9CWo
        gfG7eBcjJ4eEgInE+jNNrF2MXBxCAjsYJX4v+MoMkhAS+MQo8eVuHUTiM6PEkfWXWGE6Ht77
        zAyR2MUoMW3CaSjnJaPEsSNTmECq2AR0JZ7c+AmU4OAQEdCWuP8iHaSGWaCJUeLq7xNgNZwC
        sRJrjn9iB7GFBWwkFpz4CbaaRUBFYt3PH4wgNq+ApcSK+/fYIGxBiZMzn7CA2MwC8hLb385h
        hrhIQWL3p6Ng14kIWEmsXXeYDaJGRGJ2ZxtUzVd2iV1vRUHukRBwkThyxA4iLCzx6vgWdghb
        SuJlfxuU3c0o8eccL8jNEgITGCVa7pyF+t5Y4tPnz4wgc5gFNCXW79KHCCtK7Pw9lxHCFpQ4
        fa2bGeIEPol3X3tYIdbySnS0CUGUqEh8/7CTZQKj8iwkj81C8tgsJA/MQli2gJFlFaNYakFx
        bnpqsWGBKXJsb2IEp04tyx2M099+0DvEyMTBeIhRgoNZSYT307bkZCHelMTKqtSi/Pii0pzU
        4kOMycCgnsgsJZqcD0zeeSXxhibGBgZGwERobmluTISwpYGJmZGJhbGlsZmSOG/DDK1kIYH0
        xJLU7NTUgtQimC1MHJxSDUwq/+2E5974z3VKqag6o3fO7F8LlMLmuleteb846Gnv3A+fZn2W
        6Ei+VXvK/I7j7Gtnuv8d3x6Y/KVC/OrJBVftp+l2SnVZat6+8Ft8tVLqq4xzRX6LPryYcjB4
        W1XwD+0Zc055Js3MvNNb23bIJnZBee0rptB3ZUKLqto49G2mJ2t7LAl3vbrN9aFU1Bm2rW31
        czSZNlpNmvGq/OCS2Qfrk9+KRk68fvfI27TA2/a+EydVl3zca7vhmnn0u7MeKUe4pvmwH+/r
        reeKDHAUrlkr8+3T6cJ7MbKTA668T9xwWlazVuDFJZX6eeH5x8+LdDO9vhp+zNiwvqR7SV/F
        3EnVq5ecjvi7KNLncrMI8xQLJZbijERDLeai4kQASnCvSlQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnO6XHcnJBpe+M1lMnLaU2WLP3pMs
        Fpd3zWGz2PLvCKsDi8emVZ1sHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJVx8GIve8FfuYpF
        X4IaGL+LdzFyckgImEg8vPeZuYuRi0NIYAejxPzl9xi7GDmAElISB/dpQpjCEocPF0OUPGeU
        6Fu1iRmkl01AV+LJjZ/MIDUiAtoS91+kg9QwC7QwSsxqfMYG0bCOUaJ11mRWkAZOgViJNcc/
        sYPYwgI2EgtO/AQbxCKgIrHu5w9GEJtXwFJixf17bBC2oMTJmU9YQGxmoAW9D1sZIWx5ie1v
        5zBDPKAgsfvTUbD5IgJWEmvXHWaDqBGRmN3ZxjyBUXgWklGzkIyahWTULCQtCxhZVjFKphYU
        56bnFhsWGOWllusVJ+YWl+al6yXn525iBEeGltYOxj2rPugdYmTiYDzEKMHBrCTC+2lbcrIQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTGozZmyVaPze
        f+Tz0/iDgQ+9ylZt3jb92y7eufMjJYQ5ao8+K3JL9pbTjetnesHXF/Q8aLl/3KGnfQHOGWdt
        d+iUHeUoVRI5FH6h1XFRa8+xuSdrr6rlnYpzr+EqdTlTP3/6nvebT6rF/Je3PK7/cYW0wKrw
        yP0sK78eeVatvUb+mYescLXLj9xv/Ucmsoq7HTokIKV4Qkb3pKm5SRkTwzt25xc13atUJRYF
        zS1mD9MoLTM+2bIs4ULzNA0frTOOLjGMFsumlW+vXsi14NquT1kTxSN+rt6a+vyA9c7yLD2n
        NSo2l8M1zl+bx3+K/aebdSnbyQXmcldTVuz5+evRzGPvVZYsW1BlNHPifH33OUosxRmJhlrM
        RcWJAHsTd1P7AgAA
X-CMS-MailID: 20221103124956epcas1p34c9cf3f29114e4f11f387b2ce5952eb7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221102071135epcas1p2ef12631e6b239dded4224aa795ee5166
References: <CGME20221102071135epcas1p2ef12631e6b239dded4224aa795ee5166@epcas1p2.samsung.com>
        <PUZPR04MB6316C6A981A51EA6C079455D81399@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This commit adds exfat_set_empty_hint()/exfat_reset_empty_hint()
> to reduce code complexity and make code more readable.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

Looks good. Thanks!

> ---
>  fs/exfat/dir.c | 58 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> a27b55ec060a..9f9b8435baca 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -897,6 +897,29 @@ struct exfat_entry_set_cache
> *exfat_get_dentry_set(struct super_block *sb,
>  	return NULL;
>  }
> 
> +static inline void exfat_reset_empty_hint(struct exfat_hint_femp
> +*hint_femp) {
> +	hint_femp->eidx = EXFAT_HINT_NONE;
> +	hint_femp->count = 0;
> +}
> +
> +static inline void exfat_set_empty_hint(struct exfat_inode_info *ei,
> +		struct exfat_hint_femp *candi_empty, struct exfat_chain *clu,
> +		int dentry, int num_entries)
> +{
> +	if (ei->hint_femp.eidx == EXFAT_HINT_NONE ||
> +	    ei->hint_femp.eidx > dentry) {
> +		if (candi_empty->count == 0) {
> +			candi_empty->cur = *clu;
> +			candi_empty->eidx = dentry;
> +		}
> +
> +		candi_empty->count++;
> +		if (candi_empty->count == num_entries)
> +			ei->hint_femp = *candi_empty;
> +	}
> +}
> +
>  enum {
>  	DIRENT_STEP_FILE,
>  	DIRENT_STEP_STRM,
> @@ -921,7 +944,7 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,  {
>  	int i, rewind = 0, dentry = 0, end_eidx = 0, num_ext = 0, len;
>  	int order, step, name_len = 0;
> -	int dentries_per_clu, num_empty = 0;
> +	int dentries_per_clu;
>  	unsigned int entry_type;
>  	unsigned short *uniname = NULL;
>  	struct exfat_chain clu;
> @@ -939,10 +962,13 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
>  		end_eidx = dentry;
>  	}
> 
> -	candi_empty.eidx = EXFAT_HINT_NONE;
> +	exfat_reset_empty_hint(&ei->hint_femp);
> +
>  rewind:
>  	order = 0;
>  	step = DIRENT_STEP_FILE;
> +	exfat_reset_empty_hint(&candi_empty);
> +
>  	while (clu.dir != EXFAT_EOF_CLUSTER) {
>  		i = dentry & (dentries_per_clu - 1);
>  		for (; i < dentries_per_clu; i++, dentry++) { @@ -962,26
> +988,8 @@ int exfat_find_dir_entry(struct super_block *sb, struct
> exfat_inode_info *ei,
>  			    entry_type == TYPE_DELETED) {
>  				step = DIRENT_STEP_FILE;
> 
> -				num_empty++;
> -				if (candi_empty.eidx == EXFAT_HINT_NONE &&
> -						num_empty == 1) {
> -					exfat_chain_set(&candi_empty.cur,
> -						clu.dir, clu.size, clu.flags);
> -				}
> -
> -				if (candi_empty.eidx == EXFAT_HINT_NONE &&
> -						num_empty >= num_entries) {
> -					candi_empty.eidx =
> -						dentry - (num_empty - 1);
> -					WARN_ON(candi_empty.eidx < 0);
> -					candi_empty.count = num_empty;
> -
> -					if (ei->hint_femp.eidx ==
> -							EXFAT_HINT_NONE ||
> -						candi_empty.eidx <=
> -							 ei->hint_femp.eidx)
> -						ei->hint_femp = candi_empty;
> -				}
> +				exfat_set_empty_hint(ei, &candi_empty, &clu,
> +						dentry, num_entries);
> 
>  				brelse(bh);
>  				if (entry_type == TYPE_UNUSED)
> @@ -989,8 +997,7 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
>  				continue;
>  			}
> 
> -			num_empty = 0;
> -			candi_empty.eidx = EXFAT_HINT_NONE;
> +			exfat_reset_empty_hint(&candi_empty);
> 
>  			if (entry_type == TYPE_FILE || entry_type == TYPE_DIR)
> {
>  				step = DIRENT_STEP_FILE;
> @@ -1090,9 +1097,6 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
>  		rewind = 1;
>  		dentry = 0;
>  		clu.dir = p_dir->dir;
> -		/* reset empty hint */
> -		num_empty = 0;
> -		candi_empty.eidx = EXFAT_HINT_NONE;
>  		goto rewind;
>  	}
> 
> --
> 2.25.1

