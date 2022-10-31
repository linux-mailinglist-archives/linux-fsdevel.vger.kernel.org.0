Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C6C613039
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 07:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJaGRb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 02:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaGRa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:17:30 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5667665A4
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Oct 2022 23:17:25 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221031061721epoutp03f5e5c261a19df41215f4cab4422f7261~jEuBL922b0710407104epoutp03X
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 06:17:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221031061721epoutp03f5e5c261a19df41215f4cab4422f7261~jEuBL922b0710407104epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667197041;
        bh=zrcuyzlSiXoFgoqpUlNcrlJrfzSJzWIX6MW85Q5KClg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WTaZtki4V96+De/36Iip/kAB42efae7LjF2Q9kzBD195rxMJYddsrpMMmP6MmrKnG
         mNMQ19nCIxMV130WXzbpJ5OCjqyrcaBcU2+anzI/YuJaDMz5ZKiTztv0x3dEK1egDY
         pYC0tbzph2XRBZahAgCIDVneBc2vRWHKY+VcIB4k=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20221031061721epcas1p4351b13048df38ba807e5620cd531f3f8~jEuAzq6L91417814178epcas1p4-;
        Mon, 31 Oct 2022 06:17:21 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.225]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4N12xX5lyYz4x9QC; Mon, 31 Oct
        2022 06:17:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.82.51827.0786F536; Mon, 31 Oct 2022 15:17:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221031061720epcas1p1f95ab18b14a8e51bf064f0dcffbfea27~jEt-xLQ663011430114epcas1p1K;
        Mon, 31 Oct 2022 06:17:20 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221031061720epsmtrp26b5afaa63382726c70cd73a9fffc97c2~jEt-wcoFa0949709497epsmtrp2L;
        Mon, 31 Oct 2022 06:17:20 +0000 (GMT)
X-AuditID: b6c32a36-72a32a800000ca73-1b-635f6870f4ea
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.68.18644.F686F536; Mon, 31 Oct 2022 15:17:19 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221031061719epsmtip1580399a80943acad7222d74c8ec369ae~jEt-f5IUM1526715267epsmtip1W;
        Mon, 31 Oct 2022 06:17:19 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB631604A0BBD29713D3F8DAB0812B9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1 2/2] exfat: hint the empty entry which at the end of
 cluster chain
Date:   Mon, 31 Oct 2022 15:17:19 +0900
Message-ID: <014c01d8ecf0$6e74bc80$4b5e3580$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJbGVKlRTjGnAJr8oRiJ7knPGKj+wGohbknrRZoyDA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmvm5BRnyywbdeFYuJ05YyW+zZe5LF
        4vKuOWwWW/4dYXVg8di0qpPNo2/LKkaPz5vkApijGhhtEouSMzLLUhVS85LzUzLz0m2VQkPc
        dC2UFDLyi0tslaINDY30DA3M9YyMjPSMLWOtjEyVFPISc1NtlSp0oXqVFIqSC4BqcyuLgQbk
        pOpBxfWKU/NSHLLyS0FO1CtOzC0uzUvXS87PVVIoS8wpBRqhpJ/wjTFj3sIb7AVr5SpanzWz
        NzC2SXQxcnJICJhIzH90mamLkYtDSGAHo8TFa39YIZxPjBL7PxyHcj4zStx8+JgJpmXqvDY2
        iMQuRonlqz8zQjgvGSW6LyxjBqliE9CVeHLjJ5DNwSEioC1x/0U6SA2zQBOjxITGlywgNZwC
        sRLPb+xlA7GFBaIlNszdxgpiswioSsz42MIIYvMKWEosn/KbGcIWlDg58wlYL7OAvMT2t3OY
        IS5SkNj96ShYr4iAlcTaHQuYIGpEJGZ3tjGDLJYQ+MkuMWfOLqgXXCQOnulghbCFJV4d38IO
        YUtJfH4HcZCEQDejxJ9zvBDNExglWu6chWowlvj0GeRlDqANmhLrd+lDhBUldv6eywhhC0qc
        vtbNDHEEn8S7rz2sIOUSArwSHW1CECUqEt8/7GSZwKg8C8lrs5C8NgvJC7MQli1gZFnFKJZa
        UJybnlpsWGCEHOObGMEpVMtsB+Oktx/0DjEycTAeYpTgYFYS4a0/G50sxJuSWFmVWpQfX1Sa
        k1p8iDEZGNgTmaVEk/OBSTyvJN7QxNjAwAiYEM0tzY2JELY0MDEzMrEwtjQ2UxLnbZihlSwk
        kJ5YkpqdmlqQWgSzhYmDU6qBaWaA+8JtUpHivU2/TKxNEk+bzmVe8KxCcteN5LmWItU3Ui++
        m/T85+s/k/Jm3nsgnb5cqVd+d/Uxd02fBSYm8rJrJDiCmutm7Lt4tf+kgGPnJpu5V9Kd3YS/
        rxRnOrd86iv+jj8qQleOzwjX81N/stNLf9LFhu2vavfpTrzU+N7+VpPB+j2RGzVFC6piZhta
        X//j+crls5jALAXmZ30HN30pvb4u+tvirWccjgukds/gdpY89+yIWUNP2rvLexfM+Xhh8c+4
        gzy8M0XZ1lolN+64tufo/U3lm05pPmbn2sl2tp1rcrq9v3BUr82i+izPkwsjzrywkj9j6WnN
        f3/d8v3r6s4y5UpOXSU6R8SltVCJpTgj0VCLuag4EQAzdltbWAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnG5+Rnyywc13FhYTpy1lttiz9ySL
        xeVdc9gstvw7wurA4rFpVSebR9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGXMW3iDvWCtXEXr
        s2b2BsY2iS5GTg4JAROJqfPa2LoYuTiEBHYwSmxat5api5EDKCElcXCfJoQpLHH4cDFIuZDA
        c0aJ7e0sIDabgK7Ekxs/mUFKRAS0Je6/SAeZwizQwijRsOskE8TIdYwS3T2r2EEaOAViJZ7f
        2MsGYgsLREqcXfabFcRmEVCVmPGxhRHE5hWwlFg+5TczhC0ocXLmE7BlzEALnt58CmXLS2x/
        O4cZ4n4Fid2fjoLNERGwkli7YwETRI2IxOzONuYJjMKzkIyahWTULCSjZiFpWcDIsopRMrWg
        ODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgytLR2MO5Z9UHvECMTB+MhRgkOZiUR3vqz0clC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MFkL2qt9ZDi6
        zHhlzWaJgMb+87PfbepNVlm37kdR5sljXTq5Mme5cztuvXh6SnAFy8TyY47JATvsDjxmatAt
        12i5ISJ03ndv79N6t19bEp+tN95zSubWLDvdGpFJxnOjKhZUxv9Z+2TWMUWxR2sfBdidNZeO
        v8y0Rb/CzrB20VF3nx+xa1dZyf/9NT2ubF59lvjmoNu3xW4aPHozwfbv8+Ptf4t+BVxT72aW
        y5rbsDHntLsH68nbmzfdNVgoLqLX6ahy96KhnRz/08QX2stZlja95G7suct6LsVw8t6rjctZ
        vf+rzGd4kO9YxPVpq3ahyjLrqNuu22S37PjyVsvyQ1a6MOeCDFGmIxuPnpdfPE+JpTgj0VCL
        uag4EQBvL6JN+wIAAA==
X-CMS-MailID: 20221031061720epcas1p1f95ab18b14a8e51bf064f0dcffbfea27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221019072854epcas1p2a2b272458803045b4dfa95b17fb4f547
References: <CGME20221019072854epcas1p2a2b272458803045b4dfa95b17fb4f547@epcas1p2.samsung.com>
        <PUZPR04MB631604A0BBD29713D3F8DAB0812B9@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Yuezhang Mo,

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
> ---
>  fs/exfat/dir.c   | 26 ++++++++++++++++++++++----
>  fs/exfat/namei.c | 22 ++++++++++++++--------
>  2 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index a569f285f4fd..7600f3521246 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -936,18 +936,25 @@ struct exfat_entry_set_cache
> *exfat_get_dentry_set(struct super_block *sb,
> 
>  static inline void exfat_hint_empty_entry(struct exfat_inode_info *ei,
>  		struct exfat_hint_femp *candi_empty, struct exfat_chain *clu,
> -		int dentry, int num_entries)
> +		int dentry, int num_entries, int entry_type)
>  {
>  	if (ei->hint_femp.eidx == EXFAT_HINT_NONE ||
>  	    ei->hint_femp.count < num_entries ||
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

This seems like a very good approach. Perhaps the key fix that improved
performance seems to be the handling of cases where empty space was not
found and ended with TYPE_UNUSED.

However, there are concerns about trusting and using the number of free
entries after TYPE_UNUSED calculated based on directory size. This is
because, unlike exFAT Spec., in the real world, unexpected TYPE_UNUSED
entries may exist. :( 
That's why exfat_search_empty_slot() checks if there is any valid entry
after TYPE_UNUSED. In my experience, they can be caused by a wrong FS driver
and H/W defects, and the probability of occurrence is not low.

Therefore, when the lookup ends with TYPE_UNUSED, if there are no empty
entries found yet, it would be better to set the last empty entry to
hint_femp.eidx and set hint_femp.count to 0.
If so, even if the lookup ends with TYPE_UNUSED, exfat_search_empty_slot()
can start searching from the position of the last empty entry and check
whether there are actually empty entries as many as the required
num_entries as now.

what do you think?

> +		else
> +			candi_empty->count++;
> +
> +		if (candi_empty->count == num_entries ||
> +		    candi_empty->count + candi_empty->eidx == total_entries)
>  			ei->hint_femp = *candi_empty;
>  	}
>  }
[snip]
> --
> 2.25.1

