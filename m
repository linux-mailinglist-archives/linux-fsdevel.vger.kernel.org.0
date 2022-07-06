Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731CB568C34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 17:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiGFPFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiGFPFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:05:31 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D3515A33
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jul 2022 08:05:29 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220706150525epoutp023b13f1a543b63934825b1b9068a1bfd1~-Rcr2lTCc2516825168epoutp02j
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jul 2022 15:05:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220706150525epoutp023b13f1a543b63934825b1b9068a1bfd1~-Rcr2lTCc2516825168epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657119925;
        bh=VMwwtygRnTB7bjYnOEXVdIrlP/+f9Js42lyK/zUqzNw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=U9JG+jZbVdY3aanBiTT1gZo6r9MVAlXDFAAwgG9KSS2fRJeX4k2Fg4Z9PF1IpcRsJ
         YADhHaKJURwfxZcRDUKZifh/yaaqlG1M8GhV5e2MwRejX322ZGlllTzBcNupDDxc4+
         kesNqsOnWES7JOc3QUiS8XIG+FAQatIVOEOlM4w0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220706150525epcas1p3d2979b8df99df50bb26ed144dace472d~-RcrGzfUn2908929089epcas1p3N;
        Wed,  6 Jul 2022 15:05:25 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.227]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LdNBr5c35z4x9Pv; Wed,  6 Jul
        2022 15:05:24 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.BC.09633.4B4A5C26; Thu,  7 Jul 2022 00:05:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220706150524epcas1p2e1a78fe57585ee14fdbe0e31bf535482~-RcqTyFxL1201412014epcas1p2e;
        Wed,  6 Jul 2022 15:05:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220706150524epsmtrp26c9f84772d253242d144bb528a29d8e8~-RcqTA4CH0553705537epsmtrp2h;
        Wed,  6 Jul 2022 15:05:24 +0000 (GMT)
X-AuditID: b6c32a36-05fff700000025a1-c6-62c5a4b48dd9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.4E.08802.4B4A5C26; Thu,  7 Jul 2022 00:05:24 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220706150524epsmtip208a919de706cc8899dca61c17dd937e8~-RcqJu2hp3261032610epsmtip26;
        Wed,  6 Jul 2022 15:05:24 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Jun'" <hljhnu@gmail.com>
Cc:     <linux-fsdevel@vger.kernel.org>,
        "'Namjae Jeon'" <linkinjeon@kernel.org>, <sj1557.seo@samsung.com>
In-Reply-To: <20220706072117.GA29711@ubuntu>
Subject: RE: [RFC PATCH] exfat: optimize performance of deleting a file
Date:   Thu, 7 Jul 2022 00:05:23 +0900
Message-ID: <000001d89149$d166b940$74342bc0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQG5mTviE6BCbAZLr8XBQZcBarGc9AGSiOqFraK+bLA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmru6WJUeTDBYe17G4NcXCYuK0pcwW
        e/aeZLHY8u8IqwOLx85Zd9k9Nq3qZPPo27KK0ePzJrkAlqgGRpvEouSMzLJUhdS85PyUzLx0
        W6XQEDddCyWFjPziElulaENDIz1DA3M9IyMjPWPLWCsjUyWFvMTcVFulCl2oXiWFouQCoNrc
        ymKgATmpelBxveLUvBSHrPxSkDP1ihNzi0vz0vWS83OVFMoSc0qBRijpJ3xjzJi1V7vgj1rF
        pU9nmRsYF8t3MXJySAiYSEx+s4Kpi5GLQ0hgB6NE546TrBDOJ0aJqw3PoTKfgTIb7wFlOMBa
        Fj92AekWEtjFKNHWyAxR85JR4kHXbHaQBJuArsSTGz+ZQepFBOQkmte7gpjMAhkStx5WgZic
        AjoSy/9HgJjCAu4Sa3pzQPpYBFQkPtztYQaxeQUsJY6ev8UCYQtKnJz5BMxmFpCX2P52DjPE
        +QoSuz8dZYXYYyXxaqILRImIxOzONrC7JAQ+sksceXyWFaLeReLVysUsELawxKvjW9ghbCmJ
        z+/2skHYzYwSzY1GEHYHo8TTjbIQf9tLvL9kAfGHpsT6XfoQFYoSO3/PZYSwBSVOX+tmhjiB
        T+Ld1x5oiPFKdLQJQZSoSHz/sJNlAqPyLCR/zULy1ywkD8xCWLaAkWUVo1hqQXFuemqxYYER
        cjxvYgSnTS2zHYyT3n7QO8TIxMF4iFGCg1lJhDe3/WiSEG9KYmVValF+fFFpTmrxIcZkYEhP
        ZJYSTc4HJu68knhDE2MDAyNg8jO3NDcmQtjSwMTMyMTC2NLYTEmcd9W004lCAumJJanZqakF
        qUUwW5g4OKUamLK+emm35s6aoWubN//0JelzBaqhh8t+1p85lPpm8cMrQRavMoRv/S9yl7E1
        T0l7pFsy/4f/2bU3lGe9dzfWXnTI/g43z+a0uP58lrd2nDPVk34kHa1wm33P/ZfNl+rkTl3b
        wuU6Jpcv9Vx8c7/hreLjvsQ+d4eSlKS90vnJxkbTnzW8MC7LaVVTMb+VdF/OiHubfv4bn4Uu
        PuwZmz8ekp6d0+/KfWPVNd0FfutlWDpCeSN5uw3aL61Ts1xluYFje53X5ibJ5EdJjRP3BZz9
        1xw+tX7O1nN3XqY2yVSeOSAxacPU1ZxCbG3id35b/bLZzj/38JH4FZf1j7pOiL65/Ns9ljlh
        Oro6yr+mhC6LV2Ipzkg01GIuKk4EAIUKRIFSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvO6WJUeTDJYv4ra4NcXCYuK0pcwW
        e/aeZLHY8u8IqwOLx85Zd9k9Nq3qZPPo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujFl7tQv+
        qFVc+nSWuYFxsXwXIweHhICJxOLHLl2MXBxCAjsYJeb2X2SFiEtJHNynCWEKSxw+XAxR8pxR
        YnLvceYuRk4ONgFdiSc3fjKD1IgIyEk0r3cFCTMLZEnc/nqHHSQsJFAr8eQ4WAWngI7E8v8R
        IKawgLvEmt4ckGIWARWJD3d7wObxClhKHD1/iwXCFpQ4OfMJC0g5s4CeRNtGRojZ8hLb384B
        K5cQUJDY/ekoK8R6K4lXE10gSkQkZne2MU9gFJ6FZNAshEGzkAyahaRjASPLKkbJ1ILi3PTc
        YsMCo7zUcr3ixNzi0rx0veT83E2M4HjQ0trBuGfVB71DjEwcjIcYJTiYlUR4c9uPJgnxpiRW
        VqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXANOPsCtt/txc+OOSz
        k+VayEPLpRk7f33w0NJ9Z3/CkO9qR+H+d/dXcSVWC0oFSQQqM535d/R1wlF+S1EWm60hSUfi
        l6/ansWs436Rr0/BxHDasYRny1Qf72UJ8lq04tn3e+bWciKr4xQXxSzc0nEiRe2IsHxqP1ND
        0GuBK30r9789kWb1rfRx0wGOvnjzZJtHfS9yfCINmr3PSyav/PcqtCFb5N/ZG70CK1efepi2
        5ezqAx+TdFJnXw5U/cvQr2CQp97tfHztkZ6Icj+tZUeF1CUYrs9aK1bofr2a+4hF86Kl23in
        O9xk25L/yZ5Jav+RwvfJHo+cV6xdYSoZVbyMo77jSMTpuWv/iPkr7VDuUWIpzkg01GIuKk4E
        AFhE4qr2AgAA
X-CMS-MailID: 20220706150524epcas1p2e1a78fe57585ee14fdbe0e31bf535482
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220706072124epcas1p42f5e7b4bde0cdb4d0fb80ac5ea18158a
References: <CGME20220706072124epcas1p42f5e7b4bde0cdb4d0fb80ac5ea18158a@epcas1p4.samsung.com>
        <20220706072117.GA29711@ubuntu>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Jun,

Perhaps you are looking at an old version of the exfat code.
The performance of exfat_free_cluster has been improved in the latest
version. I think the below commit could help you.

f728760aa923 ("exfat: improve performance of exfat_free_cluster when
using dirsync mount option")

Thanks.

> When a large file is deleted, it's cluster bitmap is cleared.
> After a bit is cleared, the buffer_head is synced.
> A buffer_head can be synced many times repeatedly.
> We can clear all bits first and then sync all buffer_heads.
> So each buffer_head is synced only once, which significantly improves
> performance.
> 
> In my test, It takes about 2 minitues to delete a 5GB file without the
> patch.
> After applying the patch, the file is deleted in almost less than 1s.
> 
> Signed-off-by: Jun <hljhnu@gmail.com>
> Change-Id: I7637032db04042b8ad1ca73fe7db09d43a253255
> ---
>  fs/exfat/balloc.c   | 28 ++++++++++++++++++++++++++--
>  fs/exfat/exfat_fs.h |  2 ++
>  fs/exfat/fatent.c   | 45 +++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 69 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c index
> 579c10f57c2b..58bdfb58bf1d 100644
> --- a/fs/exfat/balloc.c
> +++ b/fs/exfat/balloc.c
> @@ -164,7 +164,6 @@ void exfat_clear_bitmap(struct inode *inode, unsigned
> int clu)
>  	unsigned int ent_idx;
>  	struct super_block *sb = inode->i_sb;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> -	struct exfat_mount_options *opts = &sbi->options;
> 
>  	WARN_ON(clu < EXFAT_FIRST_CLUSTER);
>  	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
> @@ -172,7 +171,32 @@ void exfat_clear_bitmap(struct inode *inode, unsigned
> int clu)
>  	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
> 
>  	clear_bit_le(b, sbi->vol_amap[i]->b_data);
> -	exfat_update_bh(sbi->vol_amap[i], IS_DIRSYNC(inode));
> +	set_buffer_uptodate(sbi->vol_amap[i]);
> +	mark_buffer_dirty(sbi->vol_amap[i]);
> +}
> +
> +void exfat_wait_bitmap(struct inode *inode, unsigned int clu) {
> +	int i;
> +	unsigned int ent_idx;
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	WARN_ON(clu < EXFAT_FIRST_CLUSTER);
> +	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
> +	i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
> +
> +	if (IS_DIRSYNC(inode))
> +		sync_dirty_buffer(sbi->vol_amap[i]);
> +}
> +
> +void exfat_discard_cluster(struct inode *inode, unsigned int clu) {
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct exfat_mount_options *opts = &sbi->options;
> +
> +	WARN_ON(clu < EXFAT_FIRST_CLUSTER);
> 
>  	if (opts->discard) {
>  		int ret_discard;
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index
> b8f0e829ecbd..1ecd2379022d 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -409,6 +409,8 @@ int exfat_load_bitmap(struct super_block *sb);  void
> exfat_free_bitmap(struct exfat_sb_info *sbi);  int exfat_set_bitmap(struct
> inode *inode, unsigned int clu);  void exfat_clear_bitmap(struct inode
> *inode, unsigned int clu);
> +void exfat_wait_bitmap(struct inode *inode, unsigned int clu); void
> +exfat_discard_cluster(struct inode *inode, unsigned int clu);
>  unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int
> clu);  int exfat_count_used_clusters(struct super_block *sb, unsigned int
> *ret_count);
> 
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c index
> c3c9afee7418..f39a912a7da7 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -183,19 +183,56 @@ int exfat_free_cluster(struct inode *inode, struct
> exfat_chain *p_chain)
> 
>  			num_clusters++;
>  		} while (num_clusters < p_chain->size);
> +		sbi->used_clusters -= num_clusters;
> +
> +		clu = p_chain->dir;
> +		num_clusters = 0;
> +		do {
> +			exfat_wait_bitmap(inode, clu);
> +			clu++;
> +
> +			num_clusters++;
> +		} while (num_clusters < p_chain->size);
> +
> +		clu = p_chain->dir;
> +		num_clusters = 0;
> +		do {
> +			exfat_discard_cluster(inode, clu);
> +			clu++;
> +
> +			num_clusters++;
> +		} while (num_clusters < p_chain->size);
> +
>  	} else {
>  		do {
>  			exfat_clear_bitmap(inode, clu);
> 
>  			if (exfat_get_next_cluster(sb, &clu))
> -				goto dec_used_clus;
> +				goto exit;
> +
> +			sbi->used_clusters--;
> +		} while (clu != EXFAT_EOF_CLUSTER);
> +
> +		clu = p_chain->dir;
> +		do {
> +			exfat_wait_bitmap(inode, clu);
> +
> +			if (exfat_get_next_cluster(sb, &clu))
> +				goto exit;
> +
> +		} while (clu != EXFAT_EOF_CLUSTER);
> +
> +		clu = p_chain->dir;
> +		do {
> +			exfat_discard_cluster(inode, clu);
> +
> +			if (exfat_get_next_cluster(sb, &clu))
> +				goto exit;
> 
> -			num_clusters++;
>  		} while (clu != EXFAT_EOF_CLUSTER);
>  	}
> 
> -dec_used_clus:
> -	sbi->used_clusters -= num_clusters;
> +exit:
>  	return 0;
>  }
> 
> --
> 2.36.1


