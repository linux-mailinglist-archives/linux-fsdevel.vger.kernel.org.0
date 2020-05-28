Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EEF1E567D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 07:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgE1FbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 01:31:25 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:50529 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgE1FbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 01:31:24 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200528053121epoutp049458f6a0579604272532382e566281a0~TGi7acVbO2954929549epoutp042
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 05:31:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200528053121epoutp049458f6a0579604272532382e566281a0~TGi7acVbO2954929549epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590643881;
        bh=1rhWb2ghlHfx6/GhiY4d6pvDsvdGG8/7te8jw6OSzt8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=t6RgU4PEe3i80V+3nbBIQSGWfje8fc7cSfbXdDmNEhHaZMgllBAj8u8SI7of5P+eE
         Y0RV7zGSBsL6O6FfC2vbVtJn/aeh0oWHep4O4WVuZqKm2cGBs0BpC1iPrYl1E0WMOh
         4UPfroT0imZe5zsKoL0gwrvpkUgWVwvJaqVZQKXc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200528053121epcas1p36e79e000ffaccbe1f2e8d8af3a5c7f9d~TGi6_-VuK1798617986epcas1p3R;
        Thu, 28 May 2020 05:31:21 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.161]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49XbsN42rRzMqYkp; Thu, 28 May
        2020 05:31:20 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.0D.04645.8AC4FCE5; Thu, 28 May 2020 14:31:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200528053119epcas1p1a35e08216d21caaf5fea2a09b5529697~TGi5k-JY50039900399epcas1p1w;
        Thu, 28 May 2020 05:31:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200528053119epsmtrp10cf4263f87a22ff29d18837b0814155c~TGi5kVsaF2902029020epsmtrp1d;
        Thu, 28 May 2020 05:31:19 +0000 (GMT)
X-AuditID: b6c32a36-f4fff70000001225-6c-5ecf4ca82203
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.6A.08382.7AC4FCE5; Thu, 28 May 2020 14:31:19 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200528053119epsmtip2f949ad102c907171b38e785318f06dd4~TGi5WzzRe1556715567epsmtip2P;
        Thu, 28 May 2020 05:31:19 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200525115052.19243-1-kohada.t2@gmail.com>
Subject: RE: [PATCH 1/4] exfat: redefine PBR as boot_sector
Date:   Thu, 28 May 2020 14:31:19 +0900
Message-ID: <040701d634b1$375a2a40$a60e7ec0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIZHoFQlzEF60igWH7M0f/y+WBvNgEl0VwLqCz/jOA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk7O4aL07R6E6x1KKJgc8c5O1raTWKpkRFERWgnPThpN3Y2
        yQjSElEpu6zr1K4UOaFgWKnln0nZulhpdhN/WBZN0mRaLstq8yj57/ne93m+533e7yMxxQ0i
        hiww23mbmTPSxEz8TusylepG5vNsTW/FIjZY242zX32ncfZ+iw9nO5trCLbzbwBnr484cTZ4
        9uAamX6kpk2mL3P+kekPP6wj9E2uHpm+qsGN9MOeBVnETuMqA8/l8TYlb8615BWY81PojK05
        63N0iRpGxSSxK2ilmTPxKXRaZpZqQ4ExNAqtLOSMjlApixMEOi51lc3isPNKg0Wwp9C8Nc9o
        ZTRWtcCZBIc5X51rMSUzGk28LsTcbTS8PtaCWZ9H7OvvjC5Gg7JKFEEClQD+q0OSSjSTVFCN
        CE7d+YLCDQUVQHDte7LY+IFgoL4Kn1KcHHiHiY0WBB9bu6XiwY/gl9cpDbMISgV9b39iYRxN
        qcHne0OEMUaVSOCRf28lIskIKgkaPqSEy1HUSnB2dE1QcGoJnOmtmzCThyhj3W6ZiGeD73wf
        Ll6zEO4O1GDiQEq4F3ggFa2SIeAZkomcaKiuKJsYFKhaEo6UjkpFQRq4P30jRBwF/W0Nk7uI
        Af+xskl8GEFVz0ZRXIrA3XhoUqCFwPAwCgfAqGVwqzlOLC+Cpl+1SDSeBYPfj0jDFKDkUF6m
        ECmLYXSoCZ+yehXskhxHtGtaNNe0aK5pEVz/zS4h3I3m8lbBlM8LjDV++lt70MQvXZ7YiK60
        Z3oRRSI6Ul6e3p6tkHKFQpHJi4DE6Gj5umdPshXyPK5oP2+z5NgcRl7wIl1o8yewmDm5ltCf
        N9tzGF28VqtlExJXJOq09Dz5xeDTbAWVz9n5vTxv5W1TOgkZEVOMTKuf/N5zsx9zHj0XadG9
        f5HQUZ66K+N27M3h3rENV0cPuus9mpJ7FyQk0WUwca5k+ci2z8GeHRcdfem9u9M2FVeXFPY1
        nfk744C/InbtzvZxtXdL5ODHjvGEuy/Bc+7ARvXjU23z7bPHZEu//WG25+5/k8X4L99Pr35W
        PHf8bOpmJ40LBo5ZjtkE7h+MoVHTuwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXne5z/k4g32bTCx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi+KySUnNySxLLdK3S+DKuNa/l7ngPGfFq8siDYzv2LsYOTkkBEwkJr29ydzFyMUh
        JLCbUeJEw2qmLkYOoISUxMF9mhCmsMThw8UQJc8ZJb6828AK0ssmoCvx5MZPZhBbREBP4uTJ
        62wgRcwCzUwSrV+amSA6uhgl7k7ZCjaUU8BSYssjW5AGYQFricmXrrKB2CwCqhLTHq5kAbF5
        gUp+3V7FDmELSpyc+YQFpJUZaEHbRkaQMLOAvMT2t3OYIe5XkNj96SgrxA1WEp82fWCHqBGR
        mN3ZxjyBUXgWkkmzECbNQjJpFpKOBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcx
        guNJS3MH4/ZVH/QOMTJxMB5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQozQHi5I4743C
        hXFCAumJJanZqakFqUUwWSYOTqkGJjZepZ5JQreKnV89/59cVN8nocjLV3Le/rCjsMBR6f1p
        PjmM335dddGuaqsNm1+wefcdT941bjxrZ1yfH29kUyMe6z4hIM5M/vLuA8ZKKufWsG5a86Fi
        6+HFYRmMGc12/Pl/fzk66n3TsrhtUf7ZaJ4Q970HXmW6Qku1WLP/vFzJlv1SbI+h9sdXnHGy
        k6/eme+YdEhjW/3ud79Opp88Mze6bbviSt9zvK2lO8VWaG9svi1qKjTxOb/sjele//L08j7O
        9uDSKFFbXKarNH322ngPpbKPFe+sr21rMnoWmur4+M+u2tyIt8HXts/iCU/YkCDN3LetuLJv
        y/PzHt/7rgtrBdcekLXadW+5ZGOjEktxRqKhFnNRcSIAT7z47BYDAAA=
X-CMS-MailID: 20200528053119epcas1p1a35e08216d21caaf5fea2a09b5529697
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200525115110epcas1p491bfb477b12825536e81e376f34c7a02
References: <CGME20200525115110epcas1p491bfb477b12825536e81e376f34c7a02@epcas1p4.samsung.com>
        <20200525115052.19243-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Aggregate PBR related definitions and redefine as "boot_sector" to comply
> with the exFAT specification.
> And, rename variable names including 'pbr'.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
>  fs/exfat/exfat_fs.h  |  2 +-
>  fs/exfat/exfat_raw.h | 79 +++++++++++++++--------------------------
>  fs/exfat/super.c     | 84 ++++++++++++++++++++++----------------------
>  3 files changed, 72 insertions(+), 93 deletions(-)
> 
[snip]
> +/* EXFAT: Main and Backup Boot Sector (512 bytes) */ struct boot_sector
> +{
> +	__u8	jmp_boot[BOOTSEC_JUMP_BOOT_LEN];
> +	__u8	oem_name[BOOTSEC_OEM_NAME_LEN];

According to the exFAT specification, fs_name and BOOTSEC_FS_NAME_LEN look
better.

> +	__u8	must_be_zero[BOOTSEC_OLDBPB_LEN];
> +	__le64	partition_offset;
> +	__le64	vol_length;
> +	__le32	fat_offset;
> +	__le32	fat_length;
> +	__le32	clu_offset;
> +	__le32	clu_count;
> +	__le32	root_cluster;
> +	__le32	vol_serial;
> +	__u8	fs_revision[2];
> +	__le16	vol_flags;
> +	__u8	sect_size_bits;
> +	__u8	sect_per_clus_bits;
> +	__u8	num_fats;
> +	__u8	drv_sel;
> +	__u8	percent_in_use;
> +	__u8	reserved[7];
> +	__u8	boot_code[390];
> +	__le16	signature;
>  } __packed;

