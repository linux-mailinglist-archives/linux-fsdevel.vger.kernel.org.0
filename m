Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2FA26BA3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 04:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgIPCcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 22:32:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:11673 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgIPCcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:32:17 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200916023215epoutp03fa7f14a11f18d2b4bb909ff014b965e4~1ItOrgLsz3086030860epoutp03p
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 02:32:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200916023215epoutp03fa7f14a11f18d2b4bb909ff014b965e4~1ItOrgLsz3086030860epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600223535;
        bh=Yfl4dFFxDqDZxjerfzfkoY+8akViH1weFET+b6zYsDg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=iXKCe03fZXxPnKsjs1JIUCYHR4GvDXdvM6wprv8L07JhSRFbn33ARCdXD8u2t8WQs
         3MZwxAX0I6FV9gK49eUo1M73Sh3Ehsx5VSPppsfWTCSrlFeUruQwGWD4tKfzmGIsEq
         rL5LNgCAaQIelGg/i8GTF4/2EFlbdTY0MMWeT2wc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200916023214epcas1p27986168474714ba5878d2fe6fd527a39~1ItOIPur32185321853epcas1p2f;
        Wed, 16 Sep 2020 02:32:14 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BrkdT6qCKzMqYkp; Wed, 16 Sep
        2020 02:32:13 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.40.18978.D29716F5; Wed, 16 Sep 2020 11:32:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200916023213epcas1p1c82e74099554114d1e14ec4b15ca3ed0~1ItM33tT01610016100epcas1p1P;
        Wed, 16 Sep 2020 02:32:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200916023213epsmtrp1c73641e21923df2e4df9e28c944a04ad~1ItM3PsJ_2982129821epsmtrp1g;
        Wed, 16 Sep 2020 02:32:13 +0000 (GMT)
X-AuditID: b6c32a35-b8298a8000004a22-1e-5f61792d1982
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.4A.08382.D29716F5; Wed, 16 Sep 2020 11:32:13 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200916023212epsmtip1e17c7d5d06a7500a4ddbac7b6a5dc245~1ItMseg6D0762807628epsmtip1p;
        Wed, 16 Sep 2020 02:32:12 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200911044506.13912-1-kohada.t2@gmail.com>
Subject: RE: [PATCH 2/3] exfat: remove useless check in exfat_move_file()
Date:   Wed, 16 Sep 2020 11:32:12 +0900
Message-ID: <015f01d68bd1$95ace4d0$c106ae70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGgZsB+KXs97exselB5tzyGrN5ddgLZy8s5qcAEzwA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmvq5uZWK8wctH+hY/5t5msXhzciqL
        xZ69J1ksLu+aw2Zx+f8nFotlXyazWPyYXu/A7vFlznF2j7bJ/9g9mo+tZPPYOesuu0ffllWM
        Hp83yQWwReXYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQo0CtOzC0uzUvXS87PtTI0
        MDAyBapMyMnY8foxe0ELZ8X7Bv8GxrnsXYwcHBICJhLN0+q6GLk4hAR2MEo8+ryZCcL5xCjR
        tL+HEcL5xihxums+SxcjJ1jH9tfH2SASexkl1rb/ZoFwXjJKTFvyixWkik1AV+LJjZ/MILaI
        gJ7EyZPX2UBsZoFGJokTL7NBbE4BS4lrXbsZQWxhAU+Jxi9rwDawCKhKrNm3BczmBaq58WgS
        lC0ocXLmExaIOfIS29/OYYa4SEFi96ejrBC7rCTOzP/DDlEjIjG7s40Z5DgJgZkcEpOOXWeE
        eNpF4t10RYheYYlXx7ewQ9hSEi/726Dseon/89eyQ/S2MEo8/LSNCaLXXuL9JQsQk1lAU2L9
        Ln2IckWJnb/nMkKs5ZN497WHFaKaV6KjTQiiREXi+4edLDCbrvy4yjSBUWkWksdmIXlsFpIH
        ZiEsW8DIsopRLLWgODc9tdiwwBA5qjcxghOplukOxolvP+gdYmTiYDzEKMHBrCTCe6AxPl6I
        NyWxsiq1KD++qDQntfgQoykwqCcyS4km5wNTeV5JvKGpkbGxsYWJmbmZqbGSOO/DWwrxQgLp
        iSWp2ampBalFMH1MHJxSDUxu/qy/G2bfV+hujPOP+VZRX3iSc2XCYaXmH0om2QvjIo5vjqs/
        rFpwYcdJ8470FamTNn1edGLf5ZqmYxqSXzhVnKRfhQof/fjk+wn7T0eT+983ssVnSs4/drrh
        r4uo6hajzqBPalouli2XeFP15WvP/vgeFfH0jXO0TrXuha4zKXdqtl9SVdTY/t81I/u1+/KD
        z9vaF3lv76hs/MMyxb3ju1y4qtavMNZephtl0i/nzHMOqPy0KexKp/17A4nysvakY4zHdwdz
        6zWua189o656+aF43e/Bvg8mHbFWNimWnJMbI776I0/WiRtVl2tLuU2M5r2ZcC9AeOfaW+U9
        dlWrzh0WKAssWMC15s+RYiWW4oxEQy3mouJEAKc13VgtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTle3MjHeYO11Fosfc2+zWLw5OZXF
        Ys/ekywWl3fNYbO4/P8Ti8WyL5OBstPrHdg9vsw5zu7RNvkfu0fzsZVsHjtn3WX36NuyitHj
        8ya5ALYoLpuU1JzMstQifbsErowdrx+zF7RwVrxv8G9gnMvexcjJISFgIrH99XE2EFtIYDej
        RNPu6C5GDqC4lMTBfZoQprDE4cPFEBXPGSUeb3YFsdkEdCWe3PjJDGKLCOhJnDx5HWgKFwez
        QDOTROuXZiYQR0igi1FiRcNCJpAqTgFLiWtduxlBbGEBT4nGL2tYQGwWAVWJNfu2gNm8QDU3
        Hk2CsgUlTs58wgJyBDPQhraNYK3MAvIS29/OYYY4X0Fi96ejrBBHWEmcmf+HHaJGRGJ2Zxvz
        BEbhWUgmzUKYNAvJpFlIOhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOJi3N
        HYzbV33QO8TIxMF4iFGCg1lJhPdAY3y8EG9KYmVValF+fFFpTmrxIUZpDhYlcd4bhQvjhATS
        E0tSs1NTC1KLYLJMHJxSDUzBd7fGqi+MP/P1svbEGSvv5phs1pFSSK5gmbP3gfkWVZ4dCmyd
        E/7EP/eOffI9bJrtXxF9WyO90gcba8yVfD/E1C3Z5SO29pn3ZQfNGRLanEHSdya6Lz8e4n9v
        mi1XQ86VZrYnUbPCw7jrPz288FbjaJJi1naDE/8CFQTdbXvzFCsvVy7R46t+fNFMT6D7qeGP
        ndfn3v+itDVyeobB9mPT9kmdmh7YGz2tyf/T/HP+wSezCmeI1vm9PXrv8Y2/PYJttw7c6BM4
        ZDbrx/4IppYX5uGc8bs1fqfm7BCwqEyO+X/oxbKLU0V60y9PXnv9yJ6uBXm1Bu9Eiz+fmR70
        eELsk3D5+ouqBwMOsTC5+XorsRRnJBpqMRcVJwIAYs7dKRUDAAA=
X-CMS-MailID: 20200916023213epcas1p1c82e74099554114d1e14ec4b15ca3ed0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200911044511epcas1p4d62863352e65c534cd6080dd38d54b26
References: <CGME20200911044511epcas1p4d62863352e65c534cd6080dd38d54b26@epcas1p4.samsung.com>
        <20200911044506.13912-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> In exfat_move_file(), the identity of source and target directory has been
> checked by the caller.
> Also, it gets stream.start_clu from file dir-entry, which is an invalid
> determination.
> 
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
>  fs/exfat/namei.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c index
> 803748946ddb..1c433491f771 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -1095,11 +1095,6 @@ static int exfat_move_file(struct inode *inode,
> struct exfat_chain *p_olddir,
>  	if (!epmov)
>  		return -EIO;
> 
> -	/* check if the source and target directory is the same */
> -	if (exfat_get_entry_type(epmov) == TYPE_DIR &&
> -	    le32_to_cpu(epmov->dentry.stream.start_clu) == p_newdir->dir)
> -		return -EINVAL;
> -

It might check if the cluster numbers are same between source entry and
target directory.
Could you let me know what code you mentioned?
Or do you mean the codes on vfs?

>  	num_old_entries = exfat_count_ext_entries(sb, p_olddir, oldentry,
>  		epmov);
>  	if (num_old_entries < 0)
> --
> 2.25.1


