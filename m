Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F034EEB62
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344001AbiDAKgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 06:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245575AbiDAKgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:36:07 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC1265D07
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Apr 2022 03:34:18 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220401103416epoutp027bb13c04d6d748f3779fe825da1733bf~hv0hvFSF50042200422epoutp02M
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Apr 2022 10:34:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220401103416epoutp027bb13c04d6d748f3779fe825da1733bf~hv0hvFSF50042200422epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648809256;
        bh=QD2Kd3UBHUe67Xsz/iHKdHMKOdhJMByAo2BtR/3Ii0E=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Hf1xWk3/fo8Bbi8CsSECVAZhgUqDnFl01bkDWdLTXDHewkY6am0WNYgik9GSEdE0b
         pYOP56DQp0+5gne+yj7mlcHJ2t30rVzMEQjzz5pAkUyqk1E6FDT50czc5wDqbchCAM
         KlLfJe6OgfsvcJVaATXhMFgHiajYqmiK9lccnKcs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220401103416epcas1p2b86898a2495b0ab46026f9bc6a2ff25c~hv0hZp01U1031510315epcas1p2p;
        Fri,  1 Apr 2022 10:34:16 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.249]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KVGkG5w7Vz4x9Pv; Fri,  1 Apr
        2022 10:34:14 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.3E.21932.625D6426; Fri,  1 Apr 2022 19:34:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220401103414epcas1p2d43a8f3512776d4e443c13bfbe1cf05c~hv0ffOlR01039110391epcas1p2m;
        Fri,  1 Apr 2022 10:34:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220401103413epsmtrp114f71ef7a6e66cf285e574750cff6635~hv0fei6fK2426024260epsmtrp1Y;
        Fri,  1 Apr 2022 10:34:13 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-30-6246d5266ef0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.67.03370.525D6426; Fri,  1 Apr 2022 19:34:13 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220401103413epsmtip1c2af0f04b4c56c3e0a391373636231ce~hv0fU7zu80295502955epsmtip1Q;
        Fri,  1 Apr 2022 10:34:13 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <HK2PR04MB38911DEEC1C24C06E4C272D5811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Subject: RE: [PATCH 2/2] exfat: remove exfat_update_parent_info()
Date:   Fri, 1 Apr 2022 19:34:13 +0900
Message-ID: <818b01d845b4$07f97b50$17ec71f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQImj1FvZKQ/JrGWTmbWjfW63dKOuAHSXdAirC+2C+A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmrq7aVbckg2dTlCwmTlvKbLFn70kW
        i8u75rBZbPl3hNWBxWPTqk42j74tqxg9Pm+SC2COyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneO
        NzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqmpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
        Si1IySkwK9ArTswtLs1L18tLLbEyNDAwMgUqTMjOOHf5AmPBRJGKx68fsTQwrhDoYuTkkBAw
        kbi/o5uli5GLQ0hgB6PE/M+LmCGcT4wSS2Y9YIVwPjNKbN3TwwzTcn79V6iWXYwSL36thXJe
        Mkpcm98KVsUmoCvx5MZPIJuDQ0RAW+L+i3SQMLNAvMTuaX2MIGFOgViJX3f4QMLCAo4SB8+c
        YAKxWQRUJKZuXMYCYvMKWEr0nb3JBGELSpyc+YQFYoy8xPa3c6DuUZDY/ekoK4gtImAlsbv3
        DRtEjYjE7M42sG8kBH6yS6w8sRSqwUXi3p0fLBC2sMSr41vYIWwpiZf9bVB2M6NEc6MRhN3B
        KPF0oyzIzRIC9hLvL1mAmMwCmhLrd+lDVChK7Pw9lxFiLZ/Eu689rBDVvBIdbUIQJSoS3z/s
        ZIFZdOXHVaYJjEqzkDw2C8ljs5A8MAth2QJGllWMYqkFxbnpqcWGBSbwqE7Oz93ECE6GWhY7
        GOe+/aB3iJGJg/EQowQHs5II79VY1yQh3pTEyqrUovz4otKc1OJDjKbAoJ7ILCWanA9Mx3kl
        8YYmlgYmZkYmFsaWxmZK4ry9U08nCgmkJ5akZqemFqQWwfQxcXBKNTDVFzgXxu2UKGIKkDuT
        lbebM7s5oPTpV7MD2doqgfqdLcfeWMTNiPq61oG7WevuZmlbv0nHvN0S231v6vk6/pi2arLC
        uaLZQiX7lfUsxLexudRLfkuK59eqfxkt77jor6zCh17THwbGRhN4jY4eUfe/VN52IfczqwbT
        pBVFJ8s/T1H4IbNc8KIRZ03Q9jz1tSue5S2YGh3Wqdu70V3R/eGD1Yrft/2JCf1exvbPwspc
        9rTM0UuPcl9sijOw81It9P8lv+lq2P8tEXut01lbHWsOnnBwPR2xSVw99IjW2mKPqqz5d0rE
        +6SO6m9uD6rv2SByccb0yH3ytvP+1akkXG9Zs7bs4qKVzq/SbzFHKLEUZyQaajEXFScCAMfI
        U1gPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSnK7qVbckg8vHzC0mTlvKbLFn70kW
        i8u75rBZbPl3hNWBxWPTqk42j74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4Mo4d/kCY8FEkYrH
        rx+xNDCuEOhi5OSQEDCROL/+K0sXIxeHkMAORokrx/4ydjFyACWkJA7u04QwhSUOHy6GKHnO
        KHF36yJ2kF42AV2JJzd+MoPUiAhoS9x/kQ4SZhZIlGj+cokJon4do0TT7z0sIDWcArESv+7w
        gdQICzhKHDxzggnEZhFQkZi6cRkLiM0rYCnRd/YmE4QtKHFy5hMWiJnaEr0PWxkhbHmJ7W/n
        MEOcryCx+9NRVhBbRMBKYnfvGzaIGhGJ2Z1tzBMYhWchGTULyahZSEbNQtKygJFlFaNkakFx
        bnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcFxoae1g3LPqg94hRiYOxkOMEhzMSiK8V2Ndk4R4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgKuR66blqq1NG
        X8bO/j3F+w14Jd4fO9b66KTj47iQtJdun3dNfe3qYuyWGcq+rmL5/9cLwuOeLtj58iLP6gS+
        49/LzRJ67mw4vnDl9JaU2Tvbc68sebQ2fUtQcnOM4bynu29Jqb9Z+9Sg3fWj0/WdBi1b+BZE
        XY7NLY0WcHK+ePyEtOtvZc1Ylru2rOIHLWqX/ZKJsEsMDhU5alP4+8vp41NXh+v/8JH9fOb8
        9Kdv1F6yKnVNllpq8erQUePV6pU+XD/aO9cxP9i8R1xXfLr4r4effjwSXabtl7LKYz7no0WL
        JoUv7Zz/OuBSMue+rHfBVQsmfJFtNGk9uaY/QvKL0xqOr98VJG8cy1lx9ADzjCNKLMUZiYZa
        zEXFiQBUeq45+gIAAA==
X-CMS-MailID: 20220401103414epcas1p2d43a8f3512776d4e443c13bfbe1cf05c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220325094234epcas1p28605e75eef8d46f614ff11f98e5a6ef8
References: <CGME20220325094234epcas1p28605e75eef8d46f614ff11f98e5a6ef8@epcas1p2.samsung.com>
        <HK2PR04MB38911DEEC1C24C06E4C272D5811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> exfat_update_parent_info() is a workaround for the wrong parent directory
> information being used after renaming. Now that bug is fixed, this is no
> longer needed, so remove it.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>

As you said, exfat_update_parent_info() seems to be a workaround
that exists from the legacy code to resolve the inconsistency of
parent node information.

Thanks for your patch!
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/namei.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
> 
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c index
> e7adb6bfd9d5..76acc3721951 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -1168,28 +1168,6 @@ static int exfat_move_file(struct inode *inode,
> struct exfat_chain *p_olddir,
>  	return 0;
>  }
> 
> -static void exfat_update_parent_info(struct exfat_inode_info *ei,
> -		struct inode *parent_inode)
> -{
> -	struct exfat_sb_info *sbi = EXFAT_SB(parent_inode->i_sb);
> -	struct exfat_inode_info *parent_ei = EXFAT_I(parent_inode);
> -	loff_t parent_isize = i_size_read(parent_inode);
> -
> -	/*
> -	 * the problem that struct exfat_inode_info caches wrong parent
> info.
> -	 *
> -	 * because of flag-mismatch of ei->dir,
> -	 * there is abnormal traversing cluster chain.
> -	 */
> -	if (unlikely(parent_ei->flags != ei->dir.flags ||
> -		     parent_isize != EXFAT_CLU_TO_B(ei->dir.size, sbi) ||
> -		     parent_ei->start_clu != ei->dir.dir)) {
> -		exfat_chain_set(&ei->dir, parent_ei->start_clu,
> -			EXFAT_B_TO_CLU_ROUND_UP(parent_isize, sbi),
> -			parent_ei->flags);
> -	}
> -}
> -
>  /* rename or move a old file into a new file */  static int
> __exfat_rename(struct inode *old_parent_inode,
>  		struct exfat_inode_info *ei, struct inode *new_parent_inode,
> @@ -1220,8 +1198,6 @@ static int __exfat_rename(struct inode
> *old_parent_inode,
>  		return -ENOENT;
>  	}
> 
> -	exfat_update_parent_info(ei, old_parent_inode);
> -
>  	exfat_chain_dup(&olddir, &ei->dir);
>  	dentry = ei->entry;
> 
> @@ -1242,8 +1218,6 @@ static int __exfat_rename(struct inode
> *old_parent_inode,
>  			goto out;
>  		}
> 
> -		exfat_update_parent_info(new_ei, new_parent_inode);
> -
>  		p_dir = &(new_ei->dir);
>  		new_entry = new_ei->entry;
>  		ep = exfat_get_dentry(sb, p_dir, new_entry, &new_bh);
> --
> 2.25.1

