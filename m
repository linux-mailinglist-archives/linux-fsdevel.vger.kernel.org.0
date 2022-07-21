Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0780B57C1AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 02:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiGUAg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 20:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiGUAg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:36:56 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF8875396
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 17:36:54 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220721003649epoutp02d130a6b79d0dc0dc086d4ddc9d2a1e43~DsRkbmQZ01857918579epoutp02c
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 00:36:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220721003649epoutp02d130a6b79d0dc0dc086d4ddc9d2a1e43~DsRkbmQZ01857918579epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658363809;
        bh=VRxCJBmeMeIfHCw20HGM2OUWF/cbxVYH3881kVhEA0w=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=u4kT1T/OSyurUe+5AI+scP+wbkplbrCqUGhNWPpBXp6gv8O4E+MPLIo+1dBBTS7BM
         ru4aWxjF7EANLsEnFAfkHOgqZNULkzddEG3f1v2tVl+qBh4uvA94rzY+s4CNXqirqt
         Ij4L2xacbBhtQQ8HuUkTbBhnAz/fga+EptZ9QDPg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220721003648epcas1p1b195e82b8e422de9392e19a1cc1eca9a~DsRj-ljKw1825018250epcas1p1E;
        Thu, 21 Jul 2022 00:36:48 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.241]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LpDCh4Tj4z4x9Pv; Thu, 21 Jul
        2022 00:36:48 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.8E.10203.B9F98D26; Thu, 21 Jul 2022 09:36:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220721003642epcas1p4e316dcedc2165bc4e1f5d32d715073c9~DsReds18-0049400494epcas1p4b;
        Thu, 21 Jul 2022 00:36:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220721003642epsmtrp1193e9c2312b80698dd9234bc191d3e65~DsRedFGZQ1863018630epsmtrp1C;
        Thu, 21 Jul 2022 00:36:42 +0000 (GMT)
X-AuditID: b6c32a38-597ff700000027db-e4-62d89f9bc999
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.35.08802.A9F98D26; Thu, 21 Jul 2022 09:36:42 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220721003642epsmtip29f1523f7b15754235ec82fd58448d491~DsReQbQJx2261522615epsmtip28;
        Thu, 21 Jul 2022 00:36:42 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'linkinjeon'" <linkinjeon@kernel.org>
Cc:     "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <SG2PR04MB3899752B10CFB6CF93A6127C81879@SG2PR04MB3899.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v2 0/3] exfat: remove duplicate write directory entries
Date:   Thu, 21 Jul 2022 09:36:42 +0900
Message-ID: <011d01d89c99$f2b1fd70$d815f850$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFemAJYJOoyOYeQemHeqAgjsZ9DnAHKuyhHrm2tVkA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmge7s+TeSDLatYLOYOG0ps8WevSdZ
        LC7vmsPmwOyxaVUnm8fnTXIBTFENjDaJRckZmWWpCql5yfkpmXnptkqhIW66FkoKGfnFJbZK
        0YaGRnqGBuZ6RkZGesaWsVZGpkoKeYm5qbZKFbpQvUoKRckFQLW5lcVAA3JS9aDiesWpeSkO
        WfmlIIfpFSfmFpfmpesl5+cqKZQl5pQCjVDST/jGmPF5XytbwRHNirVbIhsYd0l2MXJySAiY
        SLxsu8vYxcjFISSwg1Gia/YpZgjnE6PE19PN7BDOZ0aJg5uWssK0zLr2jRUisYtRYt7lJ8wg
        CSGBl4wSy95Xg9hsAroST278BIpzcIgIaEl0H48GCTMLZEhsnPmBHcTmFIiVmPjzOpgtLOAt
        8ejadDYQm0VAVeLflM9gcV4BS4nnH25B2YISJ2c+YYGYoy2xbOFrZoh7FCR2fzoKdpuIgJXE
        livT2CFqRCRmd7aBfSMhcI9d4uJjkD85gBwXicZ9CRC9whKvjm9hh7ClJF72t0HZzYwSzY1G
        EHYHo8TTjbIQrfYS7y9ZgJjMApoS63fpQ1QoSuz8PZcRwhaUOH2tmxniAj6Jd197WCE6eSU6
        2oQgSlQkvn/YyTKBUXkWkr9mIflrFpL7ZyEsW8DIsopRLLWgODc9tdiwwAQ5rjcxglOklsUO
        xrlvP+gdYmTiYDzEKMHBrCTC+7TwepIQb0piZVVqUX58UWlOavEhxmRgSE9klhJNzgcm6byS
        eEMTYwMDI2ASNLc0NyZC2NLAxMzIxMLY0thMSZy3d+rpRCGB9MSS1OzU1ILUIpgtTBycUg1M
        cmvKk7c8Z/l1VnXLpf/XuMoa/7EKn9hwt6b3Sv+r53odBavvbb6fOlk1YWHSNn6+n1r3bMp4
        b6VxmplxvUuXyLyzeWrfhYanqxuT3/S+8+bwvta3ac1yAc5s/q/bSrTc93rMFLmRcWbC/xPy
        NRuvOq2z3Dvn45SFExZtenzv9PwFe2K0j9519cmTE1i2ZPOKaQ8fHo4+51ha/93whduBpS0r
        rbfsTdqmL6U6N75ezGqnxH62R/f37Uiy5BDmiFTM/z5V7qXc7hPrDwXeWZjI7dgqv/kUw17T
        RdN8hL7MWKDK6XDvKutMp1u9E4qV6jt3anKc1N4dpc2WPWkDl4VGllrAYQWBmwfi+hIvt33h
        WqTEUpyRaKjFXFScCAC+hX9qSAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvO6s+TeSDA69ULeYOG0ps8WevSdZ
        LC7vmsPmwOyxaVUnm8fnTXIBTFFcNimpOZllqUX6dglcGWsev2Mr+KhWcfhNP3MD41+xLkZO
        DgkBE4lZ176xdjFycQgJ7GCUaNx+iaWLkQMoISVxcJ8mhCkscfhwMUi5kMBzRont3S4gNpuA
        rsSTGz+ZQUpEBLQkuo9Hg4SZBTIkZu3YwgZRvo5RYvqTeBCbUyBWYuLP6+wgtrCAt8Sja9PB
        algEVCX+TfkMFucVsJR4/uEWlC0ocXLmExaImdoSvQ9bGWHsZQtfM0NcryCx+9NRVhBbRMBK
        YsuVaewQNSISszvbmCcwCs9CMmoWklGzkIyahaRlASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi
        0rx0veT83E2M4AjQ0trBuGfVB71DjEwcjIcYJTiYlUR4nxZeTxLiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBid/+Z8IMSYvdbBY/7E0yjaZeKv8o3eBv
        P63yywaHM8uWsR4p81+XXXc1eWNZT9r+E+Y2zAv0DY6VtU/QrWTmv1/Jk/X+21XHBzmLii6u
        ZhabbHOj5pK7WX3UVMWmiHWz576/6qbQdVnyoNSZAKlTk7RS4qQaEu/f3R27eDPT2/CmcyZX
        lI+l7zl3REtOM2K6gdWs6XVvsrtzLhroLOeaHr3qYujZ6W7vRRPijplIxKY0/Tecze3o9Dp9
        UV/SjA8VHAl/jJZUW5vf7V7nyWAsdWW2+EQOiTV8HWV/9youlRNojbTRmOrhojlLSfSniMjx
        j5OU+iZdkrKwNHj++Xda8Y2r5mJhCzwzhOU4dD4osRRnJBpqMRcVJwIAH7ZGQe8CAAA=
X-CMS-MailID: 20220721003642epcas1p4e316dcedc2165bc4e1f5d32d715073c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220711093004epcas1p4b7f4a4426c8d4f950631731156d95aa3
References: <CGME20220711093004epcas1p4b7f4a4426c8d4f950631731156d95aa3@epcas1p4.samsung.com>
        <SG2PR04MB3899752B10CFB6CF93A6127C81879@SG2PR04MB3899.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Changes for v2:
>   - =5B1/3=5D: Fix timing of calling __exfat_write_inode()
>     - __exfat_write_inode() should be called after updating inode.
>     - This call will be removed in =5B3/3=5D, so the patch series is
>       no code changes between v1 and v2.
>=20
>=20
> These patches simplifie the code, and removes unnecessary writes for the
> following operations.

Looks good. Thanks.

Reviewed-by: Sungjong Seo <sj1557.seo=40samsung.com>

>=20
> 1. Write data to an empty file
>   * Preparation
>     =60=60=60
>     mkdir /mnt/dir;touch /mnt/dir/file;sync
>     =60=60=60
>   * Capture the blktrace log of the following command
>     =60=60=60
>     dd if=3D/dev/zero of=3D/mnt/dir/file bs=3D=24=7Bcluster_size=7D count=
=3D1
> oflag=3Dappend conv=3Dnotrunc
>     =60=60=60
>   * blktrace log
>     * Before
>       =60=60=60
>       179,3    0        1     0.000000000    84  C  WS 2623488 + 1 =5B0=
=5D
> BootArea
>       179,3    2        1    30.259435003   189  C   W 2628864 + 256 =5B0=
=5D
> /dir/file
>       179,3    0        2    30.264066003    84  C   W 2627584 + 1 =5B0=
=5D
> BitMap
>       179,3    2        2    30.261749337   189  C   W 2628608 + 1 =5B0=
=5D        /dir/
>       179,3    0        3    60.479159007    84  C   W 2628608 + 1 =5B0=
=5D        /dir/
>       =60=60=60
>     * After
>       =60=60=60
>       179,3    0        1     0.000000000    84  C  WS 2623488 + 1 =5B0=
=5D
> BootArea
>       179,3    3        1    30.185383337    87  C   W 2629888 + 256 =5B0=
=5D
> /dir/file
>       179,3    0        2    30.246422004    84  C   W 2627584 + 1 =5B0=
=5D
> BitMap
>       179,3    0        3    60.466497674    84  C   W 2628352 + 1 =5B0=
=5D        /dir/
>       =60=60=60
>=20
> 2. Allocate a new cluster for a directory
>   * Preparation
>     =60=60=60
>     mkdir /mnt/dir
>     for ((i=3D1; i<cluster_size/96; i++)); do > /mnt/dir/file=24i; done
>     mkdir /mnt/dir/dir1; sync
>     =60=60=60
>   * Capture the blktrace log of the following command
>     =60=60=60
>     > /mnt/dir/file
>     =60=60=60
>   * blktrace log
>     - Before
>       =60=60=60
>       179,3    0        1     0.000000000    84  C  WS 2623488 + 1 =5B0=
=5D
> BootArea
>       179,3    2        1    30.263762003   189  C   W 2629504 + 128 =5B0=
=5D      /dir/
>       179,3    2        2    30.275596670   189  C   W 2629376 + 128 =5B0=
=5D      /dir/
>       179,3    2        3    30.290174003   189  C   W 2629119 + 1 =5B0=
=5D        /dir/
>       179,3    2        4    30.292362670   189  C   W 2628096 + 1 =5B0=
=5D        /
>       179,3    2        5    30.294547337   189  C   W 2627584 + 1 =5B0=
=5D
> BitMap
>       179,3    0        2    30.296661337    84  C   W 2625536 + 1 =5B0=
=5D
> FatArea
>       179,3    0        3    60.478775007    84  C   W 2628096 + 1 =5B0=
=5D        /
>       =60=60=60
>     - After
>       =60=60=60
>       179,3    0        1     0.000000000    84  C  WS 2623488 + 1 =5B0=
=5D
> BootArea
>       179,3    3        1    30.288114670    87  C   W 2631552 + 128 =5B0=
=5D      /dir/
>       179,3    3        2    30.303518003    87  C   W 2631424 + 128 =5B0=
=5D      /dir/
>       179,3    3        3    30.324212337    87  C   W 2631167 + 1 =5B0=
=5D        /dir/
>       179,3    3        4    30.326579003    87  C   W 2627584 + 1 =5B0=
=5D
> BitMap
>       179,3    0        2    30.328892670    84  C   W 2625536 + 1 =5B0=
=5D
> FatArea
>       179,3    0        3    60.503128674    84  C   W 2628096 + 1 =5B0=
=5D        /
>       =60=60=60
>=20
> 3. Truncate and release cluster from the file
>   * Preparation
>     =60=60=60
>     mkdir /mnt/dir
>     dd if=3D/dev/zero of=3D/mnt/dir/file bs=3D=24=7Bcluster_size=7D count=
=3D2
>     sync
>     =60=60=60
>   * Capture the blktrace log of the following command
>     =60=60=60
>     truncate -s =24=7Bcluster_size=7D /mnt/dir/file
>     =60=60=60
>=20
>   * blktrace log
>     * Before
>       =60=60=60
>       179,3    0        1     0.000000000    84  C  WS 2623488 + 1 =5B0=
=5D
> BootArea
>       179,3    1        1     5.048452334    49  C   W 2629120 + 1 =5B0=
=5D        /dir/
>       179,3    0        2     5.062994334    84  C   W 2627584 + 1 =5B0=
=5D        BitMap
>       179,3    0        3    10.031253002    84  C   W 2629120 + 1 =5B0=
=5D        /dir/
>       =60=60=60
>=20
>      * After
>       =60=60=60
>       179,3    0        1     0.000000000  9143  C  WS 2623488 + 1 =5B0=
=5D
> BootArea
>       179,3    0        2    14.839244001  9143  C   W 2629888 + 1 =5B0=
=5D        /dir/
>       179,3    0        3    14.841562335  9143  C   W 2627584 + 1 =5B0=
=5D
> BitMap
>       =60=60=60
>=20
> Yuezhang Mo (3):
>   exfat: reuse __exfat_write_inode() to update directory entry
>   exfat: remove duplicate write inode for truncating file
>   exfat: remove duplicate write inode for extending dir/file
>=20
>  fs/exfat/exfat_fs.h =7C  1 +
>  fs/exfat/file.c     =7C 82 ++++++++++++++-------------------------------
>  fs/exfat/inode.c    =7C 41 ++++++-----------------
>  fs/exfat/namei.c    =7C 20 -----------
>  4 files changed, 37 insertions(+), 107 deletions(-)
>=20
> --
> 2.25.1

