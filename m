Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB437F341
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 08:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhEMGye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 02:54:34 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:53737 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEMGyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 02:54:33 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210513065322epoutp031997874aa0e284795ea634dd8a16ba17~_jcdIPbMM0368203682epoutp03e
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 May 2021 06:53:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210513065322epoutp031997874aa0e284795ea634dd8a16ba17~_jcdIPbMM0368203682epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620888802;
        bh=S2hZXTeEprigf1/naAVh9wjABL/XvXOadHwNpq7cUk8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=MtyTPeyYE1CXdxESRcslkSPI9AR8ECMMNt7Hw79WbDzTnDx8A5HUOUXIj75YpQvDd
         9b3J9REOgIDDYA+ILh63wUDcdaWH74SMAxsUt0L6dXll8c7oWSnk8RKnUdqqRwgMch
         aC+oANBNl4BmpUs3DNLsOjcTt5V5Amkdwl/dK7NQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210513065322epcas1p3dd8423efbc4a03d20d64bbbf8b5bdfa3~_jccRMVb91913019130epcas1p33;
        Thu, 13 May 2021 06:53:22 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Fgj6T0b1Fz4x9Q6; Thu, 13 May
        2021 06:53:21 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.A4.09824.0ECCC906; Thu, 13 May 2021 15:53:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210513065319epcas1p4289aec995010840ac9d743e93efb4deb~_jcaL3_jJ1061610616epcas1p4U;
        Thu, 13 May 2021 06:53:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210513065319epsmtrp2cd74181eb30b4def2b593d9049c13258~_jcaLNjvg2636426364epsmtrp2N;
        Thu, 13 May 2021 06:53:19 +0000 (GMT)
X-AuditID: b6c32a37-061ff70000002660-02-609ccce01ef9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.5B.08163.FDCCC906; Thu, 13 May 2021 15:53:19 +0900 (KST)
Received: from namjaejeon01 (unknown [10.89.31.77]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210513065319epsmtip29baafcad4ef9eddaed6b3f6553999189~_jcaBcoWu2431324313epsmtip2g;
        Thu, 13 May 2021 06:53:19 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Eric Sandeen'" <sandeen@sandeen.net>,
        "'Hyunchul Lee'" <hyc.lee@gmail.com>
Cc:     "'Namjae Jeon'" <linkinjeon@kernel.org>,
        "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'Pavel Reichl'" <preichl@redhat.com>,
        <chritophe.vu-brugier@seagate.com>
In-Reply-To: <39726442-efd9-2c7a-c52e-04b1d7f14985@sandeen.net>
Subject: RE: problem with exfat on 4k logical sector devices
Date:   Thu, 13 May 2021 15:53:19 +0900
Message-ID: <003901d747c4$a8801f50$f9805df0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEo2/DaJy0YUotfQpay9jtmd1bcWAIfpTVmAa7BVgkB2ON5bQKp9gK5AZBO5OQB5D2sQQE5UguEAbMZGUiryD9h4A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmnu6DM3MSDNqf6Vm0LZ3PZnHt/nt2
        i4nTljJb7Nl7ksVi5kE3i9YrWg5sHjtn3WX32LSqk83j/b6rbB5bFj9k8mg//I3F4/MmuQC2
        qBybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAjlBTK
        EnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJ
        ORlXD65iLNjNVTHzUloD4yyOLkZODgkBE4lL+/6xdjFycQgJ7GCU+HLvE5TziVFi+tpD7BDO
        Z0aJFy2dzDAtPfvms0AkdjFKrDs+FarqBaPE9eddTCBVbAK6Ev/+7GcDsUUEgiS2LHjMBlLE
        LLCWUWLXyT2sIAlOAXuJvp1LgRIcHMICNhItZ6pAwiwCqhK/Z+4CK+EVsJTYff4kO4QtKHFy
        5hMWEJtZQF5i+9s5UBcpSPx8uowVZIyIQJbE+w0qECUiErM725hB1koIzOSQmHv4KwtEvYvE
        t5YGNghbWOLV8S3sELaUxOd3e6Hi5RInTv5igrBrJDbM28cOMl9CwFii50UJiMksoCmxfpc+
        RIWixM7fcxkh1vJJvPvawwpRzSvR0SYEUaIq0XfpMNRAaYmu9g/sExiVZiH5axaSv2YheWAW
        wrIFjCyrGMVSC4pz01OLDQuMkaN6EyM4eWqZ72Cc9vaD3iFGJg7GQ4wSHMxKIrxiSbMThHhT
        EiurUovy44tKc1KLDzGaAkN6IrOUaHI+MH3nlcQbmhoZGxtbmJiZm5kaK4nzpjtXJwgJpCeW
        pGanphakFsH0MXFwSjUwrVBc+OGkqcGZgHeOjww2y0d9julkbU1e3T+ZZ0lu101PuZDuiU/X
        mN08o7JB5rL7ubZP7QW377443Xirc9vZ3k7vsjPLO+9PSqszPuWVwsa1LqqorWG9iXbg3PNz
        K9dscey7YVd8f/bx5p7FQXry8bnOOxbyeoQVKnBdv7bu3vEPP2KLnrGWxz98Ifp+31t2nlXv
        mTb/Db92P7yu1czStcTn90orfcEj3yqn7pgh7PEttfJYyH3jHrup4ut7XIU9Qyezvv+ULGdy
        7m3dWk+J9Q4VX08xm0qsmyoX5dvJn26zqJ0pf67rzKJMc7lA7QepDkv2F6il398bLbltYlut
        QumVkHD/Xy8FmO+FaugpsRRnJBpqMRcVJwIAeG/D6icEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvO79M3MSDGaf0LZoWzqfzeLa/ffs
        FhOnLWW22LP3JIvFzINuFq1XtBzYPHbOusvusWlVJ5vH+31X2Ty2LH7I5NF++BuLx+dNcgFs
        UVw2Kak5mWWpRfp2CVwZVw+uYizYzVUx81JaA+Msji5GTg4JAROJnn3zWboYuTiEBHYwSsw5
        dYERIiEtcezEGeYuRg4gW1ji8OFiiJpnjBJTbh5kA6lhE9CV+PdnP5gtIhAkcen3DGaQImaB
        9YwSBxs2skF0TGGR+P12PTNIFaeAvUTfzqVsIFOFBWwkWs5UgYRZBFQlfs/cxQpi8wpYSuw+
        f5IdwhaUODnzCQuIzSygLdH7sJURwpaX2P52DjPEoQoSP58uYwUZKSKQJfF+gwpEiYjE7M42
        5gmMwrOQTJqFZNIsJJNmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOI60
        tHYw7ln1Qe8QIxMH4yFGCQ5mJRFesaTZCUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcS
        SE8sSc1OTS1ILYLJMnFwSjUwna+Mn9BTVaK/c2JSeqqpSlzcIpcF89IXdh1MC5B6HhgneeWF
        4OXyd3bbgla5/ND6oPRbd3vodoMUiahjmk+i9rim154JzNqyjvGwQR1rtO/y0siVzX9uHPly
        9OiVORUNN7xsJsdYWK++8SbywA2pvHKxQy1mF3ljXvnLLkhrsrN8+tJurfkTfyHv0KusHwKZ
        ft7+c+Qn812/nx7fzubOaJplIBl7QO9Z0b3dwaXTMr3fFC36uEXP0rClp4EjmFVmXovQ7xs8
        ZpLCBwROnf5o9DL/6ptgVZ86ngSN9Sal3+dPc72brXMwtNqvOFNtW/f5wmQ2G7ky3j01AfWr
        fded+nhLh8npqZ3E0e2zxVOVWIozEg21mIuKEwG4ScfKEgMAAA==
X-CMS-MailID: 20210513065319epcas1p4289aec995010840ac9d743e93efb4deb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210511233346epcas1p3071e13aa2f1364e231f2d6ece4b64ca2
References: <372ffd94-d1a2-04d6-ac38-a9b61484693d@sandeen.net>
        <CAKYAXd_5hBRZkCfj6YAgb1D2ONkpZMeN_KjAQ_7c+KxHouLHuw@mail.gmail.com>
        <CGME20210511233346epcas1p3071e13aa2f1364e231f2d6ece4b64ca2@epcas1p3.samsung.com>
        <276da0be-a44b-841e-6984-ecf3dc5da6f0@sandeen.net>
        <001201d746c0$cc8da8e0$65a8faa0$@samsung.com>
        <b3015dc1-07a9-0c14-857a-9562a9007fb6@sandeen.net>
        <CANFS6bZs3bDQdKH-PYnQqo=3iDUaVy5dH8VQ+JE8WdeVi4o0NQ@mail.gmail.com>
        <35b5967f-dc19-f77f-f7d1-bf1d6e2b73e8@sandeen.net>
        <39726442-efd9-2c7a-c52e-04b1d7f14985@sandeen.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 5/12/21 11:44 AM, Eric Sandeen wrote:
> > I also wonder about:
> >
> >         bd->num_sectors = blk_dev_size / DEFAULT_SECTOR_SIZE;
> >         bd->num_clusters = blk_dev_size / ui->cluster_size;
> >
> > is it really correct that this should always be in terms of 512-byte sectors?
> 
> It does look like this causes problems as well:
> 
> # dump/dump.exfat /root/test.img
> exfatprogs version : 1.1.1
> -------------- Dump Boot sector region --------------
> Volume Length(sectors): 		65536 <<<<<<
> FAT Offset(sector offset): 		256
> FAT Length(sectors): 			64
> Cluster Heap Offset (sector offset): 	512
> Cluster Count: 				65024
> Root Cluster (cluster offset): 		6
> Volume Serial: 				0x1234
> Sector Size Bits: 			12    <<<<<<<
> Sector per Cluster bits: 		0
> 
> ...
> 
> # tune/tune.exfat -v /root/test.img
> exfatprogs version : 1.1.1
> [exfat_get_blk_dev_info: 202] Block device name : /root/test.img
> [exfat_get_blk_dev_info: 203] Block device offset : 0
> [exfat_get_blk_dev_info: 204] Block device size : 268435456
> [exfat_get_blk_dev_info: 205] Block sector size : 512         <<<<<<<
> [exfat_get_blk_dev_info: 206] Number of the sectors : 524288  <<<<<<<
> [exfat_get_blk_dev_info: 208] Number of the clusters : 65536
Understood, Will fix it.
Thanks for detailed explanation!

