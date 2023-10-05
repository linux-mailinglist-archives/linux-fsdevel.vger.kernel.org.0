Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB6D7BA18B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbjJEOsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbjJEOpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:45:53 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747C4B2D2A
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 07:28:18 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231005115954epoutp03ec8f82ec77230719387513ce0b2281e1~LNE4lBYrE0889408894epoutp03S
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 11:59:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231005115954epoutp03ec8f82ec77230719387513ce0b2281e1~LNE4lBYrE0889408894epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696507194;
        bh=+6P7kYwTsI/syAFJr/vDIbvAx6N2NJbpxlsh+84U80k=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=vKIW8RQPfUqKoXpVuSDHBOrPUrvbMG9r/dYmVKw7EyFFkkJpZ2bIym20TWhr+33A7
         8G3D8CYxpAiEyO6OXWNUwHwfnGeumO6IXnWTSZVhrjkzxsBiTZIV6Eqovdax+NfLbK
         DyZxyhSaBosfJnuIlcIdu31/75OGV7GMqMk7NoXk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231005115954epcas2p1966c150d583b0cb3aac3078561fc2d4b~LNE3-nC_62742227422epcas2p13;
        Thu,  5 Oct 2023 11:59:54 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S1VVK50JBz4x9Pv; Thu,  5 Oct
        2023 11:59:53 +0000 (GMT)
X-AuditID: b6c32a47-d5dfa700000025bc-12-651ea539b059
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.90.09660.935AE156; Thu,  5 Oct 2023 20:59:53 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 05/13] scsi: core: Query the Block Limits Extension VPD
 page
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jorn Lee <lunar.lee@samsung.com>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230920191442.3701673-6-bvanassche@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231005115852epcms2p3a3338e2696b91342acee7bc332428965@epcms2p3>
Date:   Thu, 05 Oct 2023 20:58:52 +0900
X-CMS-MailID: 20231005115852epcms2p3a3338e2696b91342acee7bc332428965
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmua7lUrlUg23fVCxW3+1ns5j24Sez
        xctDmharHoRbrFx9lMli0Y1tTBZ7b2lb7Nl7ksWi+/oONouTK16wWCw//o/JYlXHXEaLqeeP
        MDnwely+4u1x+Wypx4RFBxg9dt9sYPP4+PQWi0ffllWMHp83yQWwR2XbZKQmpqQWKaTmJeen
        ZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdqqRQlphTChQKSCwuVtK3synK
        Ly1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIztj9eTdzwXfWivZja1ka
        GB+zdjFyckgImEgc7e0Csrk4hAR2MErM7nnC1sXIwcErICjxd4cwSI2wQJDEp3m32UBsIQEl
        ifUXZ7FDxPUkbj1cwwhiswnoSEw/cR8sLiLgJtFwdRcbyExmgYfMEuvPd7BDLOOVmNH+lAXC
        lpbYvnwrWDOngJXEs/WL2CDiGhI/lvUyQ9iiEjdXv2WHsd8fm88IYYtItN47C1UjKPHg526o
        uKTE7bmboOrzJf5fWQ5l10hsOzAPytaXuNaxEewGXgFfib0tG8DiLAKqEj/6+6BqXCR2L3kD
        NpNZQFti2cLXzKAwYRbQlFi/Sx/ElBBQljhyiwWigk+i4/BfuA8bNv7Gyt4x7wkThK0mse7n
        eqYJjMqzEAE9C8muWQi7FjAyr2IUSy0ozk1PLTYqMIbHbXJ+7iZGcJrVct/BOOPtB71DjEwc
        jIcYJTiYlUR40xtkUoV4UxIrq1KL8uOLSnNSiw8xmgJ9OZFZSjQ5H5jo80riDU0sDUzMzAzN
        jUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRqYJrx5dbFnkMrg+/M2zV/5tL7Ssvd4vVK
        NvJqZNRd43A/9Oda+y7r0K1npp9r+rZZc9lkbvnPk6Zcu+t4p2r6wutTBFLePf7yTcc6OzxJ
        7PNvGe7nEs9YDilvtzJZcsjZZmJL6dyzZ9t+KpxX+bog9JN6V/abUxki1ZPqS7RKpPdu2l66
        JFfFX2BCRT537xlG97c6Vy8WcGxb+ij0FEPw5bX3n55KzM5zXB+tFPPEXzdtvZrHgnjxa13u
        MrfuH1lyTTRHuNVZ+mvtmyCthWktnv9enXzc8rLmTWN9W+Jf7c3XWVpuXC56t0A6gi265e/D
        Gy/uvi475JWkdlj8p2Wz/j2Xdwnt2x2FlS3dM8/EpnkosRRnJBpqMRcVJwIAXcz+KDwEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920191816epcas2p1b30d19aa41e51ffaf7c95f9100ee6311
References: <20230920191442.3701673-6-bvanassche@acm.org>
        <20230920191442.3701673-1-bvanassche@acm.org>
        <CGME20230920191816epcas2p1b30d19aa41e51ffaf7c95f9100ee6311@epcms2p3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=C2=A0=0D=0A>=20Parse=20the=20Reduced=20Stream=20Control=20Supported=20(RSC=
S)=20bit=20from=20the=20block=0D=0A>=20limits=20extension=20VPD=20page.=20T=
he=20RSCS=20bit=20is=20defined=20in=20T10=20document=0D=0A>=20=22SBC-5=20Co=
nstrained=20Streams=20with=20Data=20Lifetimes=22=0D=0A>=20(https://protect2=
.fireeye.com/v1/url?k=3D046aff72-65e1ea35-046b743d-000babff99aa-a76aa64ec2a=
10777&q=3D1&e=3D39d8e8ca-6f96-4283-86e4-54310bfa56e1&u=3Dhttps%3A%2F%2Fwww.=
t10.org%2Fcgi-bin%2Fac.pl%3Ft%3Dd%26f%3D23-024r3.pdf).=0D=0A>=C2=A0=0D=0A>=
=20Cc:=20Martin=20K.=20Petersen=20<martin.petersen=40oracle.com>=0D=0A>=20S=
igned-off-by:=20Bart=20Van=20Assche=20<bvanassche=40acm.org>=0D=0A=0D=0ARev=
iewed-by:=20Daejun=20Park=20<daejun7.park=40samsung.com>
