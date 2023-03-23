Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9FB6C65B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 11:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCWKwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 06:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjCWKwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:52:23 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F4423C49
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 03:51:12 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230323105108epoutp0488883f77ccff003d4d9d9b1f5cf8d363~PBs4rE-Yv1295912959epoutp04V
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 10:51:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230323105108epoutp0488883f77ccff003d4d9d9b1f5cf8d363~PBs4rE-Yv1295912959epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679568668;
        bh=MxviwYlwt0W/gci07Q9zodQuj98HPISdycPrqXMA2vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f9gjPKByFouRjU2cSjkkIrSxeHS8HTpS4nyod0/BnBPUDs++fqV8DKm9uxO6m6tPV
         kRDwac6ldY+KcaldLweIOElJBmq9lPDmRLZPfBoBwV4c8R4qs84Zbj0dF92Ebj52dg
         4yEBxOFdHlvW0KjjO96vHTRrJ0omfQKt/hVIpG68=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230323105107epcas2p205cefa0fdeb0ef47cb44455c90a09507~PBs37wD4p0502205022epcas2p2S;
        Thu, 23 Mar 2023 10:51:07 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Pj2FR0hYGz4x9Py; Thu, 23 Mar
        2023 10:51:07 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.8B.08750.A1F2C146; Thu, 23 Mar 2023 19:51:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3~PBs2btIaT0693906939epcas2p33;
        Thu, 23 Mar 2023 10:51:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230323105106epsmtrp1c28a31c8ae7fd6b73844c8806ab1086d~PBs2bC69B1681716817epsmtrp1o;
        Thu, 23 Mar 2023 10:51:06 +0000 (GMT)
X-AuditID: b6c32a47-777ff7000000222e-82-641c2f1a0328
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.B2.31821.A1F2C146; Thu, 23 Mar 2023 19:51:06 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230323105105epsmtip2082c66a9db596e5a9db97cdac0f0dbaa~PBs2PkLfp1816818168epsmtip2r;
        Thu, 23 Mar 2023 10:51:05 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     dan.j.williams@intel.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        ying.huang@intel.com
Subject: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Thu, 23 Mar 2023 19:51:05 +0900
Message-Id: <20230323105105.145783-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <641b7b2117d02_1b98bb294cb@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmma60vkyKwdVEi+mHFS2mT73AaHF+
        1ikWiz17T7JY3Fvzn9Vi3+u9zBYdG94wWpycNZnFgcPj34k1bB6L97xk8tj0aRK7x+Qbyxk9
        +rasYvT4vEkugC0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6BwlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbG9Q8PmAr2CFXsOa3VwNjH38XIySEhYCIxaepeli5GLg4hgR2MEnMmv2OE
        cD4xSqy+ewDK+cwosWn6axaYlsvnVjNBJHYxSnxt7WaDcLqYJObf7GIHqWIT0Jb4c+U8G4gt
        IiAjseH/dmaQImaB04wSJ8+/BysSFnCX2L6khxXEZhFQlfi+9AQjiM0rYCOx6PwjVoh18hIz
        L30Hq+cU8JLYePw7C0SNoMTJmU/AbGagmuats8EWSAj8ZJf4eWAOE0Szi0TDps9QtrDEq+Nb
        2CFsKYmX/W1QdrHE49f/oOwSicNLfkP9aSzx7uZzoCM4gBZoSqzfpQ9iSggoSxy5BbWWT6Lj
        8F92iDCvREebEESjisT2f8uZYRad3r8JariHxPoPj6AhOpdRYnf/PvYJjAqzkHwzC8k3sxAW
        L2BkXsUollpQnJueWmxUYAyP4eT83E2M4OSp5b6DccbbD3qHGJk4GA8xSnAwK4nwujFLpAjx
        piRWVqUW5ccXleakFh9iNAWG9URmKdHkfGD6ziuJNzSxNDAxMzM0NzI1MFcS55W2PZksJJCe
        WJKanZpakFoE08fEwSnVwMTLO1+/vHz6E8O72zK+8YmcNe7rcFP/nxZkIPHNwuPX5yVfTvRu
        bt8aWJXFf6mxZMHXWZM28ogKh/mvv39y2hOdL/dWqjrKqywTSz5SxXxsUrD7jh9FZ9axfeuO
        87nTdy637JKaq++1l/N/n5gkVGzJs4uzqeh5T3rj+qAXd81eXpv5cWrumscfWPV/qF21PLul
        Oi9KerHu2uI3sYLl7DfSy6X1uf5Fn88s7J+4XZf5v5PfwTl2qUsP/QrYt+D3xHWRIUvW7Oh5
        uUjUP+atoUb1FN3zb98a5MY6rBMJORah+2BlTNmHqqiMQu5eHbkejhUb8xamn690ntfyQ/zu
        4T3xhxYzpZ7LbxL66ve2uV6JpTgj0VCLuag4EQCff14bJwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSvK6UvkyKQc9/FovphxUtpk+9wGhx
        ftYpFos9e0+yWNxb85/VYt/rvcwWHRveMFqcnDWZxYHD49+JNWwei/e8ZPLY9GkSu8fkG8sZ
        Pfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj+ocHTAV7hCr2nNZqYOzj72Lk5JAQMJG4fG41
        UxcjF4eQwA5GiZs7fzBBJKQk3p9uY4ewhSXutxxhhSjqYJI4+GYJI0iCTUBb4s+V82wgtoiA
        jMSG/9uZQWxmgYuMEk9uR4PYwgLuEtuX9LCC2CwCqhLfl54A6+UVsJFYdP4RK8QCeYmZl76D
        LeMU8JLYePw7C4gtJOAp8e/vb3aIekGJkzOfsEDMl5do3jqbeQKjwCwkqVlIUgsYmVYxSqYW
        FOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSHuZbWDsY9qz7oHWJk4mA8xCjBwawkwuvGLJEi
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA1P1lY2sl7Lb
        bI2jVqiZz2Wqu5RsK7fMSvuYFov8v717mW3ufFpy91mwoOGtB556dx4+L5bZfTRxxdRp9z75
        vztx/0fY2s/uqioHmaa5e3lvC5BQPJewsImJ4+PbU/zHL55cOjlyR9bVk2k6qyaF5L1z6D2i
        8j0rpj/uSoncubPtiR61c/KrQkQ3/Xc+XsFmn6zd9SLWjveQdt3MlEtXmNcIzb5xRkhk+uXZ
        yyZdKb79Trs3/vKX+z8qQ0QczLqWf7VfOLdomsoiwXvyy27c2nJYv/rLj6zHB45mdt7PtWJb
        JHjkzd41u7u3CwW8ibk+02WpSIvB089fr9QIF+YpCywrXsE2M/qUwJIOTo4PGjvilFiKMxIN
        tZiLihMBGOBuweICAAA=
X-CMS-MailID: 20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3
References: <641b7b2117d02_1b98bb294cb@dwillia2-xfh.jf.intel.com.notmuch>
        <CGME20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I appreciate dan for the careful advice.

>Kyungsan Kim wrote:
>[..]
>> >In addition to CXL memory, we may have other kind of memory in the
>> >system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>> >memory in GPU card, etc.  I guess that we need to consider them
>> >together.  Do we need to add one zone type for each kind of memory?
>> 
>> We also don't think a new zone is needed for every single memory
>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>> manage multiple volatile memory devices due to the increased device
>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>> represent extended volatile memories that have different HW
>> characteristics.
>
>Some advice for the LSF/MM discussion, the rationale will need to be
>more than "we think the ZONE_EXMEM can be used to represent extended
>volatile memories that have different HW characteristics". It needs to
>be along the lines of "yes, to date Linux has been able to describe DDR
>with NUMA effects, PMEM with high write overhead, and HBM with improved
>bandwidth not necessarily latency, all without adding a new ZONE, but a
>new ZONE is absolutely required now to enable use case FOO, or address
>unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>maintainability concern of "fewer degress of freedom in the ZONE
>dimension" starts to dominate.

One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
So, we thought it could be a graceful approach adding a new zone and separately manage the new features.

Kindly let me know any advice or comment on our thoughts.

