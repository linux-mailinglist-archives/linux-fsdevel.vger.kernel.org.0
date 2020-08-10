Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CDF2401E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 08:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHJGNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 02:13:34 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:35408 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgHJGNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:13:33 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200810061330epoutp02a09b9a929bd069b1224388ac93cf7a53~p022J2EKz3269932699epoutp02D
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 06:13:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200810061330epoutp02a09b9a929bd069b1224388ac93cf7a53~p022J2EKz3269932699epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597040010;
        bh=sVPhD786G5RSI7VpSeDq+N2HMw4cX49OUlz/9umjFjw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=lKxda/VVZm69bBvS+0PXCpFC6QMp9K14RMAv80svDKfNetHV9aveXQ/2Y8xLBLYJn
         /ZgbfFddBHUmrdtO0Jfo03IKnC8WYtV0d+POZ3Vp/sy56yFyLUWR+efm6WDEwEHycs
         xFDy/PtxvoNt446/fwMiyzvyUgJBLf2z5fUp5YFs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200810061330epcas1p1ff04f76adca509aafc6566661b5cf6dc~p0214tUPv2157521575epcas1p1P;
        Mon, 10 Aug 2020 06:13:30 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BQ5Hs2WwFzMqYkk; Mon, 10 Aug
        2020 06:13:29 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.86.19033.685E03F5; Mon, 10 Aug 2020 15:13:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200810061326epcas1p45c82807cc8d4a0b90c28160caa566812~p02yN7dAk0090500905epcas1p4t;
        Mon, 10 Aug 2020 06:13:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200810061326epsmtrp2af80ad4670f3934966e3c7a40b3bee42~p02yNVGWN1918219182epsmtrp2d;
        Mon, 10 Aug 2020 06:13:26 +0000 (GMT)
X-AuditID: b6c32a36-159ff70000004a59-2b-5f30e586b39e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.2E.08382.585E03F5; Mon, 10 Aug 2020 15:13:25 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200810061325epsmtip2e233ecb93e63bc89904320f22fc277e7~p02yBDhmj1343413434epsmtip2J;
        Mon, 10 Aug 2020 06:13:25 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806055653.9329-1-kohada.t2@gmail.com>
Subject: RE: [PATCH 1/2] exfat: add NameLength check when extracting name
Date:   Mon, 10 Aug 2020 15:13:25 +0900
Message-ID: <003d01d66edd$5baf4810$130dd830$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGPHLM6XNMdYK+OwXwRZrdCO4AVLgGp1IjqqbIx7ZA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmnm7bU4N4g3cnDS1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBaVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
        lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK
        0MDAyBSoMiEnY8vmn4wFf4Qqmq/uZm9gXM3fxcjJISFgIvFh4TOmLkYuDiGBHYwS1zomMkM4
        nxgllj5cwgLhfGOU6Pl8ma2LkQOs5eghL4j4XkaJWV962SGcl4wSS77+ZAeZyyagK/Hvz342
        EFtEQE/i5MnrbCBFzAKNTBLLT3xhBklwClhI/PmzjRXEFhbwlNjWOhnMZhFQlVi84hITiM0r
        YClxcdd3KFtQ4uTMJywgNrOAvMT2t3OYIZ5QkPj5dBkryHUiAlYS6w6VQJSISMzubAN7R0Jg
        IYdE4/r5LBAfuEjsf2YB0Sos8er4FnYIW0ri87u9UE9WS3zcDzW9g1HixXdbCNtY4ub6DWCb
        mAU0Jdbv0ocIK0rs/D2XEWIrn8S7rz2sEFN4JTrahCBKVCX6Lh1mgrClJbraP7BPYFSaheSt
        WUjemoXk/lkIyxYwsqxiFEstKM5NTy02LDBCjupNjOBUqmW2g3HS2w96hxiZOBgPMUpwMCuJ
        8Nrd1Y8X4k1JrKxKLcqPLyrNSS0+xGgKDOiJzFKiyfnAZJ5XEm9oamRsbGxhYmZuZmqsJM77
        8JZCvJBAemJJanZqakFqEUwfEwenVAPT0k1PhQ33eV1d8uaVcGDyLcWlC9Ijmk7PKFy4c+LD
        v8xs6aK2lvk2gpOkv2z1rP+Y5aosVtG8qa/60ksTY9H+XdMaj65+cL5onbeq/Ofap5OTrdQf
        9S1nWK9uuKQ9gDFsjn9W7bXNzwQtd0aHPpL26Ei0nBm959A7zpkBv2Tf6dczLrxdUXtQVjdt
        Pj9v5Kd7FXe/Sjn/+2lSXGil/iV03QNb6WDxPct7yjfZMVq7OBXWGhzdxJsa/GaLX/Tb5OuN
        Z+etjitxne5mzzw77nLzg3xb4bv7EpmSTIXMzVZEm6pGf+W/Ple5XUmcrzNc0ujh7mDB9pCu
        g4bf7mVs6028YWHndtTljusBOfvdzUosxRmJhlrMRcWJAK12MoMuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXrf1qUG8wbGLVhY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWGz5d4TVgd3jy5zj7B5tk/+xezQfW8nmsXPWXXaPvi2r
        GD0+b5ILYIvisklJzcksSy3St0vgytiy+SdjwR+hiuaru9kbGFfzdzFycEgImEgcPeTVxcjF
        ISSwm1GiYc579i5GTqC4tMSxE2eYIWqEJQ4fLoaoec4oce7nRCaQGjYBXYl/f/azgdgiAnoS
        J09eZwMpYhZoZpL49mwJM0RHJ6PEgqYusCpOAQuJP3+2sYLYwgKeEttaJ4PZLAKqEotXXAKb
        yitgKXFx13coW1Di5MwnLCBXMANtaNvICBJmFpCX2P52DjPEoQoSP58uYwUpERGwklh3qASi
        RERidmcb8wRG4VlIBs1CGDQLyaBZSDoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P
        3cQIjiktzR2M21d90DvEyMTBeIhRgoNZSYTX7q5+vBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        G4UL44QE0hNLUrNTUwtSi2CyTBycUg1MHZ6z7zk8WXdoqYKDEEvXrxMvFGc9Y/UPuMNgWVG5
        z6h+hsTiS35Tr/cnVCxW1gn3c9GV3uH+7pHdc6fm6ijj/0LdmRs/LGXbHP3fKvJkgMSB94Zh
        wrxyk65q3X3Re+1e0s2NpevfPF7qL1lstSjoE+fSEnfj3s5vDF3v280uaefYvA6QCNOTC3b+
        1nF+Ts/P+TNFDs/zW1jxpHHTtTJLrYOH1bb0trdc4m0WlPn6xtOg5i2726On3Rdl/WuFl/My
        7Tv/nePW/PKQduEd9643dZtfiZ3cKOvSo+B25Jf/vRs3IuUNbXuvzXpip9aT1araUrDA7tN+
        e7Pbyoo/39jeEhYrWrO+Ml1+9s2PZs5KLMUZiYZazEXFiQD0VPqlGAMAAA==
X-CMS-MailID: 20200810061326epcas1p45c82807cc8d4a0b90c28160caa566812
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200806055718epcas1p1763d92dbf47e2a331a74d0bb9ea03c15
References: <CGME20200806055718epcas1p1763d92dbf47e2a331a74d0bb9ea03c15@epcas1p1.samsung.com>
        <20200806055653.9329-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> The current implementation doesn't care NameLength when extracting the name from Name dir-entries, so
> the name may be incorrect.
> (Without null-termination, Insufficient Name dir-entry, etc) Add a NameLength check when extracting
> the name from Name dir-entries to extract correct name.
> And, change to get the information of file/stream-ext dir-entries via the member variable of
> exfat_entry_set_cache.
> 
> ** This patch depends on:
>   '[PATCH v3] exfat: integrates dir-entry getting and validation'.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
>  fs/exfat/dir.c | 81 ++++++++++++++++++++++++--------------------------
>  1 file changed, 39 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index 91cdbede0fd1..545bb73b95e9 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -28,16 +28,15 @@ static int exfat_extract_uni_name(struct exfat_dentry *ep,
> 
>  }
> 
> -static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
> -		struct exfat_chain *p_dir, int entry, unsigned short *uniname)
> +static int exfat_get_uniname_from_name_entries(struct exfat_entry_set_cache *es,
> +		struct exfat_uni_name *uniname)
>  {
> -	int i;
> -	struct exfat_entry_set_cache *es;
> +	int n, l, i;
>  	struct exfat_dentry *ep;
> 
> -	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
> -	if (!es)
> -		return;
> +	uniname->name_len = es->de_stream->name_len;
> +	if (uniname->name_len == 0)
> +		return -EIO;
Can we validate ->name_len and name entry ->type in exfat_get_dentry_set() ?
> 
>  	/*
>  	 * First entry  : file entry
> @@ -45,14 +44,15 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
>  	 * Third entry  : first file-name entry
>  	 * So, the index of first file-name dentry should start from 2.
>  	 */
> -
> -	i = 2;
> -	while ((ep = exfat_get_validated_dentry(es, i++, TYPE_NAME))) {
> -		exfat_extract_uni_name(ep, uniname);
> -		uniname += EXFAT_FILE_NAME_LEN;
> +	for (l = 0, n = 2; l < uniname->name_len; n++) {
> +		ep = exfat_get_validated_dentry(es, n, TYPE_NAME);
> +		if (!ep)
> +			return -EIO;
> +		for (i = 0; l < uniname->name_len && i < EXFAT_FILE_NAME_LEN; i++, l++)
> +			uniname->name[l] = le16_to_cpu(ep->dentry.name.unicode_0_14[i]);
>  	}
> -
> -	exfat_free_dentry_set(es, false);
> +	uniname->name[l] = 0;
> +	return 0;
>  }

