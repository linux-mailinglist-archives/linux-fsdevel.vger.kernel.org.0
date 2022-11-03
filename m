Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA4617D14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 13:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiKCMvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 08:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiKCMvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:51:09 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDE011C38
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 05:51:08 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221103125106epoutp02501345f31870a69309df0651f0eaaed6~kFBqnhlSw2591525915epoutp02X
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 12:51:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221103125106epoutp02501345f31870a69309df0651f0eaaed6~kFBqnhlSw2591525915epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667479866;
        bh=dgtRx1SgXG71NCP0VLB8ykwpSVh812d4TvZZZJsXTeU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ZDNtqsnO0HxmgkQrGkFGr2tY6yI04/h90myN/Jp2e1zlcrwYWex73K/nuu4TxRMVM
         HNWH4GKjjZIfVMu7BzIC35dzyFS03VcsG8RZRAsh/5EESOopZFIrxduNcT9w+1jlSa
         3C0eLsH3vAPF/cNFOZ/CfUv8QW2MrVy10+kbn+q8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20221103125105epcas1p4c48fbcce3f5f9f04ba79b2c9e2e16650~kFBpxW0Cb1415814158epcas1p4X;
        Thu,  3 Nov 2022 12:51:05 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.224]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N33XT3MWgz4x9Py; Thu,  3 Nov
        2022 12:51:05 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.A7.20046.939B3636; Thu,  3 Nov 2022 21:51:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221103125104epcas1p26523c136cab92e8d9903ec64aaacd765~kFBoj4yTZ1547715477epcas1p2q;
        Thu,  3 Nov 2022 12:51:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221103125104epsmtrp187b2787f1f0923e892a5a133d85f371e~kFBojNFAZ1787017870epsmtrp1B;
        Thu,  3 Nov 2022 12:51:04 +0000 (GMT)
X-AuditID: b6c32a39-35fff70000004e4e-38-6363b939200b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.CC.14392.839B3636; Thu,  3 Nov 2022 21:51:04 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221103125104epsmtip1fdae7b1cb28364146a5fed9e20ac06f7~kFBoZc9dl2497524975epsmtip1m;
        Thu,  3 Nov 2022 12:51:04 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB6316A41FC40A84059E60BAB481399@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v2 2/2] exfat: hint the empty entry which at the end of
 cluster chain
Date:   Thu, 3 Nov 2022 21:51:04 +0900
Message-ID: <4eaa01d8ef82$ef0f1680$cd2d4380$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGcCjGLLgLtQ0s1lVkCZdVnEZTYcAGvYgVvrpl2KGA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmvq7lzuRkg6P7xC0mTlvKbLFn70kW
        i8u75rBZbPl3hNWBxWPTqk42j74tqxg9Pm+SC2COamC0SSxKzsgsS1VIzUvOT8nMS7dVCg1x
        07VQUsjILy6xVYo2NDTSMzQw1zMyMtIztoy1MjJVUshLzE21VarQhepVUihKLgCqza0sBhqQ
        k6oHFdcrTs1LccjKLwU5Ua84Mbe4NC9dLzk/V0mhLDGnFGiEkn7CN8aMZ90fmAr+6FTsW3mX
        sYGxW7mLkZNDQsBEYsb+BexdjFwcQgI7GCUeL1gN5XxilHh0oYURwvnGKPHk3nMmmJZnXauh
        EnsZJe7OOAflvGSUWP3lHhtIFZuArsSTGz+Zuxg5OEQEtCXuv0gHqWEWaGKUuPr7BNgkToFY
        iR87L7CD2MIC0RIPNm8Ai7MIqEjMedgHNodXwFLi1LRjLBC2oMTJmU/AbGYBeYntb+cwQ1yk
        ILH701FWEFtEwEri68apjBA1IhKzO9uYQRZLCHxklzix5AtUg4vE5K9PoWxhiVfHt7BD2FIS
        L/vboOxuRok/53ghmicwSrTcOcsKkTCW+PT5MyPIZ8wCmhLrd+lDhBUldv6eywhhC0qcvtbN
        DHEEn8S7rz2sIOUSArwSHW1CECUqEt8/7GSZwKg8C8lrs5C8NgvJC7MQli1gZFnFKJZaUJyb
        nlpsWGCKHOObGMEpVMtyB+P0tx/0DjEycTAeYpTgYFYS4f20LTlZiDclsbIqtSg/vqg0J7X4
        EGMyMLAnMkuJJucDk3heSbyhibGBgREwIZpbmhsTIWxpYGJmZGJhbGlspiTO2zBDK1lIID2x
        JDU7NbUgtQhmCxMHp1QDU5JtdgHnZcE7yjFbtt/VfdwTxz6v/8ahU/vDFe40/PNXfyus9Uh3
        b5LMTqe/adfvxdzd+yRrisYe5UcKm+dn9s2TM2u1Z55yazZHp+fjK3PTfMXnv+UK5HizJvtx
        6oO49CWb7v95djCAJ2SRPOcT5tM/xFccen9iYiqveAXf2ndl9vNvrX4T/rXFY++FryflhZ+o
        J+1eeP/bv/fZFgrSAjl9zN/ctzzJndhauOFa+gGu2PtdUi1LzZ/q+G+d///A0tuqVodf5by8
        lnqrMzrd+HjxtBnn7yfIrP0YU+zo/E5fRt/x3rXp0R4r7z/Ys2X6Qc7SwqyA7KsmT/+blbdt
        yJ682l9ZOHtdzKWGuRHSimFKLMUZiYZazEXFiQBSQYB3WAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnK7FzuRkgxVrpS0mTlvKbLFn70kW
        i8u75rBZbPl3hNWBxWPTqk42j74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4Mp41v2BqeCPTsW+
        lXcZGxi7lbsYOTkkBEwknnWtZuxi5OIQEtjNKHFtz1EghwMoISVxcJ8mhCkscfhwMUTJc0aJ
        exeOsoP0sgnoSjy58ZMZpEZEQFvi/ot0kBpmgRZGiVmNz9ggGtYxSvw/8JAZpIFTIFbix84L
        YM3CApES7959ZAGxWQRUJOY87GMDsXkFLCVOTTvGAmELSpyc+QTMZgZa0PuwlRHClpfY/nYO
        M8QDChK7Px1lBbFFBKwkvm6cClUjIjG7s415AqPwLCSjZiEZNQvJqFlIWhYwsqxilEwtKM5N
        zy02LDDMSy3XK07MLS7NS9dLzs/dxAiODS3NHYzbV33QO8TIxMF4iFGCg1lJhPfTtuRkId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGphyGe5rfBaSEDF9
        x1fSO5XPySDziN2f2HM8BqeFrVvMdPTYG1cxXm4uFWxNzHmjt+jWjoC2mUuuRveHvI7bZdk8
        +XxzZXfinoKZTty1Ya+VWBYb2yYxhM1Yuffq2rRF/dq5d/qv6av/enpG2tX6/Qr3KQav7GoP
        +99R9XAptC8++uNSspmv2cUXH92KGW2YWFsrTT8sZN+x31HF6NvE2YqH5LhEGvM7+/lWXpJ9
        pP7i960wfuePdya0aRpKTKo7zTH9Z/qvprM5vAviOSLzFr7JrJSc7mZu3r4uQlOg+a6xf9/b
        k5dfzrCZ9mbuhnPp7kt1G2PrvbdzmSxSzRZiYGxjtvGVW6V3TcR13kwbJZbijERDLeai4kQA
        bisUzfwCAAA=
X-CMS-MailID: 20221103125104epcas1p26523c136cab92e8d9903ec64aaacd765
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221102071138epcas1p198e20ca74ae4df32b6f754a382b9c2ba
References: <CGME20221102071138epcas1p198e20ca74ae4df32b6f754a382b9c2ba@epcas1p1.samsung.com>
        <PUZPR04MB6316A41FC40A84059E60BAB481399@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> After traversing all directory entries, hint the empty directory
> entry no matter whether or not there are enough empty directory
> entries.
> 
> After this commit, hint the empty directory entries like this:
> 
> 1. Hint the deleted directory entries if enough;
> 2. Hint the deleted and unused directory entries which at the
>    end of the cluster chain no matter whether enough or not(Add
>    by this commit);
> 3. If no any empty directory entries, hint the empty directory
>    entries in the new cluster(Add by this commit).
> 
> This avoids repeated traversal of directory entries, reduces CPU
> usage, and improves the performance of creating files and
> directories(especially on low-performance CPUs).
> 
> Test create 5000 files in a class 4 SD card on imx6q-sabrelite
> with:
> 
> for ((i=0;i<5;i++)); do
>    sync
>    time (for ((j=1;j<=1000;j++)); do touch file$((i*1000+j)); done)
> done
> 
> The more files, the more performance improvements.
> 
>             Before   After    Improvement
>    1~1000   25.360s  22.168s  14.40%
> 1001~2000   38.242s  28.72ss  33.15%
> 2001~3000   49.134s  35.037s  40.23%
> 3001~4000   62.042s  41.624s  49.05%
> 4001~5000   73.629s  46.772s  57.42%
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

Looks good. Thanks!

> ---
>  fs/exfat/dir.c   | 26 ++++++++++++++++++++++----
>  fs/exfat/namei.c | 33 +++++++++++++++++++++------------
>  2 files changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index 9f9b8435baca..5497a610808d 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -905,17 +905,24 @@ static inline void exfat_reset_empty_hint(struct
> exfat_hint_femp *hint_femp)
> 
>  static inline void exfat_set_empty_hint(struct exfat_inode_info *ei,
>  		struct exfat_hint_femp *candi_empty, struct exfat_chain *clu,
> -		int dentry, int num_entries)
> +		int dentry, int num_entries, int entry_type)
>  {
>  	if (ei->hint_femp.eidx == EXFAT_HINT_NONE ||
>  	    ei->hint_femp.eidx > dentry) {
> +		int total_entries = EXFAT_B_TO_DEN(i_size_read(&ei-
> >vfs_inode));
> +
>  		if (candi_empty->count == 0) {
>  			candi_empty->cur = *clu;
>  			candi_empty->eidx = dentry;
>  		}
> 
> -		candi_empty->count++;
> -		if (candi_empty->count == num_entries)
> +		if (entry_type == TYPE_UNUSED)
> +			candi_empty->count += total_entries - dentry;
> +		else
> +			candi_empty->count++;
> +
> +		if (candi_empty->count == num_entries ||
> +		    candi_empty->count + candi_empty->eidx == total_entries)
>  			ei->hint_femp = *candi_empty;
>  	}
>  }
> @@ -989,7 +996,8 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
>  				step = DIRENT_STEP_FILE;
> 
>  				exfat_set_empty_hint(ei, &candi_empty, &clu,
> -						dentry, num_entries);
> +						dentry, num_entries,
> +						entry_type);
> 
>  				brelse(bh);
>  				if (entry_type == TYPE_UNUSED)
> @@ -1100,6 +1108,16 @@ int exfat_find_dir_entry(struct super_block *sb,
> struct exfat_inode_info *ei,
>  		goto rewind;
>  	}
> 
> +	/*
> +	 * set the EXFAT_EOF_CLUSTER flag to avoid search
> +	 * from the beginning again when allocated a new cluster
> +	 */
> +	if (ei->hint_femp.eidx == EXFAT_HINT_NONE) {
> +		ei->hint_femp.cur.dir = EXFAT_EOF_CLUSTER;
> +		ei->hint_femp.eidx = p_dir->size * dentries_per_clu;
> +		ei->hint_femp.count = 0;
> +	}
> +
>  	/* initialized hint_stat */
>  	hint_stat->clu = p_dir->dir;
>  	hint_stat->eidx = 0;
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index b617bebc3d0f..add4893711d3 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -224,11 +224,18 @@ static int exfat_search_empty_slot(struct
> super_block *sb,
> 
>  	if (hint_femp->eidx != EXFAT_HINT_NONE) {
>  		dentry = hint_femp->eidx;
> -		if (num_entries <= hint_femp->count) {
> -			hint_femp->eidx = EXFAT_HINT_NONE;
> -			return dentry;
> -		}
> 
> +		/*
> +		 * If hint_femp->count is enough, it is needed to check if
> +		 * there are actual empty entries.
> +		 * Otherwise, and if "dentry + hint_famp->count" is also
> equal
> +		 * to "p_dir->size * dentries_per_clu", it means ENOSPC.
> +		 */
> +		if (dentry + hint_femp->count == p_dir->size *
> dentries_per_clu
> +		    && num_entries > hint_femp->count)
> +			return -ENOSPC;
> +
> +		hint_femp->eidx = EXFAT_HINT_NONE;
>  		exfat_chain_dup(&clu, &hint_femp->cur);
>  	} else {
>  		exfat_chain_dup(&clu, p_dir);
> @@ -293,6 +300,12 @@ static int exfat_search_empty_slot(struct super_block
> *sb,
>  		}
>  	}
> 
> +	hint_femp->eidx = p_dir->size * dentries_per_clu - num_empty;
> +	hint_femp->count = num_empty;
> +	if (num_empty == 0)
> +		exfat_chain_set(&hint_femp->cur, EXFAT_EOF_CLUSTER, 0,
> +				clu.flags);
> +
>  	return -ENOSPC;
>  }
> 
> @@ -369,15 +382,11 @@ static int exfat_find_empty_entry(struct inode
> *inode,
>  			if (exfat_ent_set(sb, last_clu, clu.dir))
>  				return -EIO;
> 
> -		if (hint_femp.eidx == EXFAT_HINT_NONE) {
> -			/* the special case that new dentry
> -			 * should be allocated from the start of new cluster
> -			 */
> -			hint_femp.eidx = EXFAT_B_TO_DEN_IDX(p_dir->size, sbi);
> -			hint_femp.count = sbi->dentries_per_clu;
> -
> +		if (hint_femp.cur.dir == EXFAT_EOF_CLUSTER)
>  			exfat_chain_set(&hint_femp.cur, clu.dir, 0, clu.flags);
> -		}
> +
> +		hint_femp.count += sbi->dentries_per_clu;
> +
>  		hint_femp.cur.size++;
>  		p_dir->size++;
>  		size = EXFAT_CLU_TO_B(p_dir->size, sbi);
> --
> 2.25.1

