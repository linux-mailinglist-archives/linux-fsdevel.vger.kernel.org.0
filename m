Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A300116078A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 01:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgBQAiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 19:38:00 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:58118 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgBQAiA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 19:38:00 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200217003757epoutp03f835948a1f7a5e9d6e94e88c0a8a6dab~0CY7FsZr_2529825298epoutp03D
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 00:37:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200217003757epoutp03f835948a1f7a5e9d6e94e88c0a8a6dab~0CY7FsZr_2529825298epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581899877;
        bh=NfSYzOZrDfPikqsu0krg/aS0e7+5iK66tJfBtsMoaE8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=jJfN4ChdjRrsQilTSUCykap0gRguEDe5JTvdGOeXE9Vodn+Aj1BIdnL4r4P6+zm51
         jjR9cMEulmLRI2OH5reA0Al5pV5tY50BsTgIxHBoUE77ysxIbRcfmmgM5H8mbfPpo8
         /5jCUJka1bL4wpggP7Lb2I348rh5+qkum9tBfkGA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200217003757epcas1p41ac1f5e16d9c11a5b02df864d3e8506b~0CY6nxvOC0792707927epcas1p4D;
        Mon, 17 Feb 2020 00:37:57 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48LQ7S2lN4zMqYkr; Mon, 17 Feb
        2020 00:37:56 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.4C.48019.460E94E5; Mon, 17 Feb 2020 09:37:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200217003756epcas1p30946199dd3cc6ba1055699f48105f038~0CY5XJDYY1356213562epcas1p3L;
        Mon, 17 Feb 2020 00:37:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200217003756epsmtrp2a4db0fae17c50f7c926b490537764ce1~0CY5WYIXq2536725367epsmtrp2n;
        Mon, 17 Feb 2020 00:37:56 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-65-5e49e064d749
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.52.06569.360E94E5; Mon, 17 Feb 2020 09:37:56 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200217003755epsmtip2302aae121c4563c094cb538c3ce752e7~0CY5MSbND2197021970epsmtip2d;
        Mon, 17 Feb 2020 00:37:55 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     =?windows-1257?Q?'Valdis_Kl=E7tnieks'?= <valdis.kletnieks@vt.edu>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <hch@lst.de>,
        <sj1557.seo@samsung.com>, <pali.rohar@gmail.com>, <arnd@arndb.de>,
        <viro@zeniv.linux.org.uk>, "'Namjae Jeon'" <linkinjeon@gmail.com>,
        "'Sasha Levin'" <sashal@kernel.org>
In-Reply-To: <89603.1581722921@turing-police>
Subject: RE: [PATCH] exfat: tighten down num_fats check
Date:   Mon, 17 Feb 2020 09:37:55 +0900
Message-ID: <001b01d5e52a$7f029340$7d07b9c0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1257"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEsiKNbA3f6Ud8ZBzvjODngDpGbQQJ4Yw3zqV1wpoA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmvm7KA884gzVtYhZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLCae/s1ksWnNNTaLLf+OsFpcev+BxeL83+OsDtwev39N
        YvTYOesuu8emVZ1sHvvnrmH32H2zgc2jb8sqRo/Pm+Q8Dm1/w+ax6clbpgDOqBybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKBzlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORnzfzewFLzg
        quh7VN/AuI2ji5GTQ0LAROL154tMXYxcHEICOxgl2ldvYIZwPjFKXDp6C8r5xiix/PZrNpiW
        KatXs0Ak9jJKHDy8hBXCecko8fB2EzNIFZuArsS/P/vBOkQEXCXmtjUzghQxCyxgknhy4xZ7
        FyMHBydQ0c6jMSA1wgLmErvm7GABsVkEVCVOf77NBFLCK2ApceJVGUiYV0BQ4uTMJ2AlzAIG
        EgfOLGWEsOUltr+dwwxxnILEz6fLWEFaRQSsJD5/CIcoEZGY3dkG9oyEwDp2ibc3LjCD1EgI
        uEgcXSkD0Sos8er4FnYIW0ri87u9bBAl1RIf90NN72CUePHdFsI2lri5fgMrhK0osfP3XKhr
        +CTefe1hhWjllehoE4IoUZXou3SYCcKWluhq/8A+gVFpFpK/ZiH5axaSv2YheWABI8sqRrHU
        guLc9NRiwwIT5KjexAhOyFoWOxj3nPM5xCjAwajEw/si0DNOiDWxrLgy9xCjBAezkgjvYUW3
        OCHelMTKqtSi/Pii0pzU4kOMpsBgn8gsJZqcD8wWeSXxhqZGxsbGFiZm5mamxkrivA8jNeOE
        BNITS1KzU1MLUotg+pg4OKUaGH3CLn63lBZdduKz+ofY9hhn1YJTMw9e+rbucVn8o507Mpxy
        4udb8S849ONKcJB5gzTrze+L1sR2r2rMyph3UOrGjnd5TqfUF+399CP1fdFu+9thDKayE3pE
        je/mHiqL5LyQW8XJuGf3v8t5WeITCjetf1y+yO5j1JZ88wf/d82a092081Jmf4YSS3FGoqEW
        c1FxIgD7myRf3gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSvG7KA884g281Fn8nHWO3aF68ns1i
        5eqjTBbX795ittiz9ySLxeVdc9gsJp7+zWSxac01Nost/46wWlx6/4HF4vzf46wO3B6/f01i
        9Ng56y67x6ZVnWwe++euYffYfbOBzaNvyypGj8+b5DwObX/D5rHpyVumAM4oLpuU1JzMstQi
        fbsEroz5vxtYCl5wVfQ9qm9g3MbRxcjJISFgIjFl9WqWLkYuDiGB3YwSzxpus0MkpCWOnTjD
        3MXIAWQLSxw+XAxR85xR4uXnp2wgNWwCuhL//uwHs0UEXCXmtjUzghQxC6xhklj45z0TSEJI
        oE5iU+MDJpBBnEANO4/GgISFBcwlds3ZwQJiswioSpz+fBushFfAUuLEqzKQMK+AoMTJmU/A
        SpgFjCQmdUJMZBaQl9j+dg4zxJkKEj+fLmMFaRURsJL4/CEcokREYnZnG/MERuFZSCbNQjJp
        FpJJs5C0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERyVWlo7GE+ciD/EKMDB
        qMTD6xDiGSfEmlhWXJl7iFGCg1lJhPewolucEG9KYmVValF+fFFpTmrxIUZpDhYlcV75/GOR
        QgLpiSWp2ampBalFMFkmDk6pBsZ5V+dm6n8TLPB4+qS/4+bhe73MfX9ZGq6/4lzyz00vesY7
        WwvXa3Y7Lsdd+WXz+NKW3QtOL5u3st94Q0JWstju09fU4p4eW3Xgi+2LZ8dy2UrWzdwkkXpn
        1v2jO90qLR21T/KytPVX/F4hdVxke4j0zYaI9rsrPbOMH0Ue49X/+n3PWc6dOZc7lFiKMxIN
        tZiLihMBaGKNbcYCAAA=
X-CMS-MailID: 20200217003756epcas1p30946199dd3cc6ba1055699f48105f038
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200214232853epcas1p241e47cdc4e0b9b5c603cc6eaa6182360
References: <CGME20200214232853epcas1p241e47cdc4e0b9b5c603cc6eaa6182360@epcas1p2.samsung.com>
        <89603.1581722921@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Change the test for num_fats from != 0 to a check for specifically 1.
> 
> Although it's theoretically possible that num_fats == 2 for a TexFAT
> volume (or an implementation that doesn't do the full TexFAT but does
> support 2 FAT tables), the rest of the code doesn't currently DTRT if it's
> 2 (in particular, not handling the case of ActiveFat pointing at the
> second FAT area), so we'll disallow that as well, as well as dealing with
> corrupted images that have a trash non-zero value.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> --- a/fs/exfat/super.c	2020-02-14 17:45:02.262274632 -0500
> +++ b/fs/exfat/super.c	2020-02-14 17:46:37.200343723 -0500
> @@ -450,7 +450,7 @@ static int __exfat_fill_super(struct sup
>  	}
> 
>  	p_bpb = (struct pbr64 *)p_pbr;
> -	if (!p_bpb->bsx.num_fats) {
> +	if (p_bpb->bsx.num_fats  != 1) {
>  		exfat_msg(sb, KERN_ERR, "bogus number of FAT structure");
Could you please update error message for the reason why num_fats is allowed
only 1?
>  		ret = -EINVAL;
>  		goto free_bh;
Let's remove exfat_mirror_bh(), FAT2_start_sector variable and the below
related codes together.

sbi->FAT2_start_sector = p_bpb->bsx.num_fats == 1 ?
                sbi->FAT1_start_sector :
                        sbi->FAT1_start_sector + sbi->num_FAT_sectors;

Thanks for your patch!
> 
> 
> 
> 


