Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A8E612FA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 06:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJaFRU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 01:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJaFRT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:17:19 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7709FFC
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Oct 2022 22:17:15 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221031051710epoutp02120025e36e4c7993296e26e930d549ee~jD5eRO4o-1574615746epoutp02b
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 05:17:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221031051710epoutp02120025e36e4c7993296e26e930d549ee~jD5eRO4o-1574615746epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667193430;
        bh=EWc3TU+UKzuHAAeYLmIUhlxAOX/P9kcA5YVwj5nzh48=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WMlwzsb1es/NtpU52WN21lXaz+vJtI0uPitNi7jdUYY2UXFxtL8v1RIzFRANRyqAy
         oo8/Z19Ew1D9reW2rRtsLgnsJ9iAPWvS2OEjhtyOQHz2xzk3qHaCUTuZiZwihXRWTJ
         evf6h/xAwgPgHFiqqbZ4+46ZApIYZZYe3Wd8teZ0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221031051710epcas1p169a9a5978298b4e75f82c9d5af20fce8~jD5d_Zlk-3256732567epcas1p1f;
        Mon, 31 Oct 2022 05:17:10 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.242]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4N11c602Bsz4x9Q7; Mon, 31 Oct
        2022 05:17:10 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.8E.51827.E4A5F536; Mon, 31 Oct 2022 14:17:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20221031051702epcas1p4c1c056724b49bee216f5c71d2392137a~jD5Ws94k61687916879epcas1p4x;
        Mon, 31 Oct 2022 05:17:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221031051702epsmtrp1ea8749e016ff7ad0235a4d62747e8891~jD5WsU7ES1131911319epsmtrp1F;
        Mon, 31 Oct 2022 05:17:02 +0000 (GMT)
X-AuditID: b6c32a36-17bfa7000000ca73-15-635f5a4e9d66
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.35.14392.E4A5F536; Mon, 31 Oct 2022 14:17:02 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221031051702epsmtip2b0e474e5ea48fa67055a9cd04e52af2f~jD5WYJfpY1823718237epsmtip2L;
        Mon, 31 Oct 2022 05:17:02 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB6316EBE97C82DFBEFE3CCDAF812B9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1 1/2] exfat: simplify empty entry hint
Date:   Mon, 31 Oct 2022 14:16:47 +0900
Message-ID: <000001d8ece8$0241bca0$06c535e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJj/zaSoZMPYtmG2fVrgFRBP80hpwJaGMqRrP7ew+A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmnq5/VHyyweQWTouJ05YyW+zZe5LF
        4vKuOWwWW/4dYXVg8di0qpPNo2/LKkaPz5vkApijGhhtEouSMzLLUhVS85LzUzLz0m2VQkPc
        dC2UFDLyi0tslaINDY30DA3M9YyMjPSMLWOtjEyVFPISc1NtlSp0oXqVFIqSC4BqcyuLgQbk
        pOpBxfWKU/NSHLLyS0FO1CtOzC0uzUvXS87PVVIoS8wpBRqhpJ/wjTHjwrLsgisiFWfmXGFp
        YLwm0MXIySEhYCKx4/cHti5GLg4hgR2MEv8ebWCEcD4xSiw62cIK4XxjlNj9ZDlQGQdYy40T
        GhDxvYwSL968ZoFwXjJKPFnznxFkLpuArsSTGz+ZQRpEBLQl7r9IB6lhFmhilJjQ+JIFpIZT
        IFbi7J2TYLawgI3Ei85zzCA2i4CqxL5jn8Dm8ApYSux4uYQNwhaUODnzCVg9M9DMZQtfM0P8
        oCCx+9NRVhBbRMBK4l/zb3aIGhGJ2Z1tzCCLJQQ+skt0z77CDtHgIvHo/XpGCFtY4tXxLVBx
        KYmX/W1QdjejxJ9zvBDNExglWu6cZYVIGEt8+vyZEeQzZgFNifW79CHCihI7f8+Fmikocfpa
        NzPEEXwS7772sEJCjleio00IokRF4vuHnSwTGJVnIXltFpLXZiF5YRbCsgWMLKsYxVILinPT
        U4sNC4yQ43sTIzh9apntYJz09oPeIUYmDsZDjBIczEoivPVno5OFeFMSK6tSi/Lji0pzUosP
        MSYDA3sis5Rocj4wgeeVxBuaGBsYGAGTobmluTERwpYGJmZGJhbGlsZmSuK8DTO0koUE0hNL
        UrNTUwtSi2C2MHFwSjUwzej0OmUq1GatYzvnv1RJQfVM94WO5d8T5ITOfXzKKNP9wbPEo3Xz
        qZz90oq8hh3/J7Z13bxwVvsRlz9LlaNivZJw2a2EX2u9xH1bsv9Ny937OyG+/dWt6fHHD7mz
        vVT2/Lj1256kH0L81/yfm083XX56omRKLJ8C14Nv2ycVC0ixv1F8MPlNTlmd/YrDvz/x/lBN
        N5kicOpyuJwiU9sCNXUB9gVqs5Vu73g22bvm5saSiWyKbDMLnkZ5r2+cw3hvTYTSqb0r/Jdr
        3/x31df71/sqjQebuiW93vgbnDE3ufWz7O2+whU5p2u0mk63KW/XED7WvYrZIYKzJvuP3p0m
        FntJQ05e1XSDskX+k+2VWIozEg21mIuKEwHC2Y+8VgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSvK5fVHyywaF98hYTpy1lttiz9ySL
        xeVdc9gstvw7wurA4rFpVSebR9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGXs/dDNVDBDpOLQ
        1HbmBsZpAl2MHBwSAiYSN05odDFycggJ7GaU6FstBhGWkji4TxPCFJY4fLi4i5ELqOI5o8Tc
        M3PYQcrZBHQlntz4yQxSIyKgLXH/RTpIDbNAC6NEw66TTBAN6xglLnzazALSwCkQK3H2zkkw
        W1jARuJF5zlmEJtFQFVi37FPjCA2r4ClxI6XS9ggbEGJkzOfgNUzAy14evMpnL1s4WuwXgkB
        BYndn46ygtgiAlYS/5p/s0PUiEjM7mxjnsAoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OL
        DQsM81LL9YoTc4tL89L1kvNzNzGC40JLcwfj9lUf9A4xMnEwHmKU4GBWEuGtPxudLMSbklhZ
        lVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVANTwyTmmJXtExRqHnk5
        ZH4zn7p29TJb2WqTpeftbsVZ2UVbmc/r1eeMiGrW+BUhcnjOUc4e48Nnin/yr3vQKRuzcd1V
        zXKucx+WLZnw6Z+xZ2ijlsAeHsFFm/OveGUEFPksPO3o9j6J4/tDm2+r1JOvPHecfPj0hhfl
        PJ46KyL6p8SGezFv9j7wMNNnT9AGzXyz197qT+r557/YsqdASEzHfOO8SevlL23VjZr+WoJZ
        r6fulX7/NE/eF4sjSvcpSLP9E2aUCzvSe89D6cP5pStDL2msYZ61UO72t1j5RcWfHmxZtlhK
        fcHU1rvT9Hmk+b4s3zn9ZWHl01PC0gtNjK3XnunV0iwI3Pj+sHpNAm+UEktxRqKhFnNRcSIA
        qgD1DvoCAAA=
X-CMS-MailID: 20221031051702epcas1p4c1c056724b49bee216f5c71d2392137a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221019072850epcas1p459b27e0d44eb0cc36ec09e9a734dcf60
References: <CGME20221019072850epcas1p459b27e0d44eb0cc36ec09e9a734dcf60@epcas1p4.samsung.com>
        <PUZPR04MB6316EBE97C82DFBEFE3CCDAF812B9@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Yuezhang Mo,

> This commit adds exfat_hint_empty_entry() to reduce code complexity and
> make code more readable.
>=20
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo=40sony.com>
> Reviewed-by: Andy Wu <Andy.Wu=40sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama=40sony.com>
> ---
>  fs/exfat/dir.c =7C 56 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> 7b648b6662f0..a569f285f4fd 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> =40=40 -934,6 +934,24 =40=40 struct exfat_entry_set_cache
> *exfat_get_dentry_set(struct super_block *sb,
>  	return NULL;
>  =7D
>=20
> +static inline void exfat_hint_empty_entry(struct exfat_inode_info *ei,
> +		struct exfat_hint_femp *candi_empty, struct exfat_chain *clu,
> +		int dentry, int num_entries)
> +=7B
> +	if (ei->hint_femp.eidx =3D=3D EXFAT_HINT_NONE =7C=7C
> +	    ei->hint_femp.count < num_entries =7C=7C

It seems like a good approach.
BTW, ei->hint_femp.count was already reset at the beginning of
exfat_find_dir_entry(). So condition-check above could be removed.
Is there any scenario I'm missing?

> +	    ei->hint_femp.eidx > dentry) =7B
> +		if (candi_empty->count =3D=3D 0) =7B
> +			candi_empty->cur =3D *clu;
> +			candi_empty->eidx =3D dentry;
> +		=7D
> +
> +		candi_empty->count++;
> +		if (candi_empty->count =3D=3D num_entries)
> +			ei->hint_femp =3D *candi_empty;
> +	=7D
> +=7D
> +
>  enum =7B
>  	DIRENT_STEP_FILE,
>  	DIRENT_STEP_STRM,
> =40=40 -958,7 +976,7 =40=40 int exfat_find_dir_entry(struct super_block *=
sb,
> struct exfat_inode_info *ei,  =7B
>  	int i, rewind =3D 0, dentry =3D 0, end_eidx =3D 0, num_ext =3D 0, len;
>  	int order, step, name_len =3D 0;
> -	int dentries_per_clu, num_empty =3D 0;
> +	int dentries_per_clu;
>  	unsigned int entry_type;
>  	unsigned short *uniname =3D NULL;
>  	struct exfat_chain clu;
> =40=40 -976,7 +994,15 =40=40 int exfat_find_dir_entry(struct super_block =
*sb,
> struct exfat_inode_info *ei,
>  		end_eidx =3D dentry;
>  	=7D
>=20
> -	candi_empty.eidx =3D EXFAT_HINT_NONE;
> +	if (ei->hint_femp.eidx =21=3D EXFAT_HINT_NONE &&
> +	    ei->hint_femp.count < num_entries)
> +		ei->hint_femp.eidx =3D EXFAT_HINT_NONE;
> +
> +	if (ei->hint_femp.eidx =3D=3D EXFAT_HINT_NONE)
> +		ei->hint_femp.count =3D 0;
> +
> +	candi_empty =3D ei->hint_femp;
> +

It would be nice to make the code block above a static inline function as w=
ell.

>  rewind:
>  	order =3D 0;
>  	step =3D DIRENT_STEP_FILE;
=5Bsnip=5D
> --
> 2.25.1

