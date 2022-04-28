Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93350512E1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 10:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344055AbiD1IWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 04:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344056AbiD1IWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:22:19 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B0F9FE6F
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 01:19:03 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220428081901epoutp01f4bed648f6bbd81911567ae53eb777e0~qAZJC-Q1W1907819078epoutp01H
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 08:19:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220428081901epoutp01f4bed648f6bbd81911567ae53eb777e0~qAZJC-Q1W1907819078epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651133941;
        bh=wOXierUafvtxBlcmLM8miKLDWIrpcRM3NRzL9LIllCI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RRs2Pf/NQ1HxorjPRILWRRPuW8wd9+yspJN2nnu1mZZXHKUDrAsGgC6+MAH96KKzW
         WRxujTUxwPrAWVlHgogHsRoPifVjfdMD6wMEgBeHZL4yhYSzUlRkXcsnLF9PuwM6//
         Sf3X9a27uWVRH9AAyq72K3sK8C+2T32ob2v1PC20=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220428081859epcas5p19880ba6dfa6389f18098ac62ca74e360~qAZIA-u-l0467704677epcas5p1x;
        Thu, 28 Apr 2022 08:18:59 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KppRg2W7Dz4x9QB; Thu, 28 Apr
        2022 08:18:55 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.07.09827.EED4A626; Thu, 28 Apr 2022 17:18:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220428075435epcas5p285a70634102f71440a283361657f4d9b~qAD0bnrr92164321643epcas5p2Q;
        Thu, 28 Apr 2022 07:54:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220428075435epsmtrp1a9ee8d4d92953b0ff2d7f9b7559998a2~qAD0asRh-1575615756epsmtrp1S;
        Thu, 28 Apr 2022 07:54:35 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-dd-626a4deee6d4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.BF.08924.B384A626; Thu, 28 Apr 2022 16:54:35 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428075434epsmtip13f509946fb1170bf6e1ff8e4df1f4948~qADzDll5X1873018730epsmtip1z;
        Thu, 28 Apr 2022 07:54:34 +0000 (GMT)
Date:   Thu, 28 Apr 2022 13:19:26 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Message-ID: <20220428074926.GG9558@test-zns>
MIME-Version: 1.0
In-Reply-To: <c285f0da-ab1d-2b24-e5a4-21193ef93155@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmpu5736wkgz+5Fr/Pnme22PtuNqvF
        3lvaFnv2nmSxuLxrDpvF/GVP2S26r+9gs9jxpJHRgcNj56y77B6bl9R77Gy9z+rxft9VNo/P
        m+QCWKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        DlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZ
        AhUmZGfcv7eFtaCfu+Lm7busDYztnF2MnBwSAiYSXe+2sYLYQgK7GSXmLI3uYuQCsj8xSsx/
        8IIVwvnMKHF8/Uk2mI75d6ayQyR2MUqcOz0XquoZo0TT/HnsIFUsAqoSD6Z2MXYxcnCwCWhL
        nP7PARIWETCVeNvTygJSzyxwhlGi/f0usHphATOJ1Z2tYBt4BXQkFs/fzQ5hC0qcnPmEBcTm
        FHCTmL3xG5gtKqAscWDbcSaIiyZySMyYmwqyS0LARaL5dTREWFji1fEt7BC2lMTL/jYou1xi
        e9sCJpAbJARaGCW6Tp1igUjYS1zc8xdsJrNAhsTsb2uhPpaVmHpqHVScT6L39xOovbwSO+bB
        2MoSa9YvgKqXlLj2vRHK9pDY+XElNIBWMkm8PH2IfQKj/Cwkv81Csm8W0A/MApoS63fpQ4Tl
        JZq3zmaGCEtLLP/HgaRiASPbKkbJ1ILi3PTUYtMCo7zUcnjcJ+fnbmIEJ1ktrx2MDx980DvE
        yMTBeIhRgoNZSYT3y+6MJCHelMTKqtSi/Pii0pzU4kOMpsBom8gsJZqcD0zzeSXxhiaWBiZm
        ZmYmlsZmhkrivKfTNyQKCaQnlqRmp6YWpBbB9DFxcEo1MHmYxBi3KS/r+5xXoHh/5e5/mpOK
        OLaz1QUJJm5LlWV+dGCy2qfIDR1bPTv4Cv8o7cuz5K+7k+o17+LTf7WP9Hb0x/PP1u849K1e
        9ECS25U/X77MfXHhdDCf6CKtxUE1cj17vjAr/U6ZkKPatTBKKu23yc1t05J0TR/EblD+sWFx
        0DPf6Q7i++QYDghltRZyCmdZbpQ0mbLf//CW7BVyO3Mj78a3hghMUJNqNAp1337257kTdWFK
        F5WF48I+LnzLVaHz1Wvq/N+HWwX5lVy6/OQDdXwTmyQOHOF9+P5ORO+1sxMfmJVUr1snvTy8
        Kfb+1bVvxTqdU/dcnR/13vrQ+u4M04X3O3s98v0vTXLvVmIpzkg01GIuKk4EAG3bN+s7BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnK61R1aSQcdnPYvfZ88zW+x9N5vV
        Yu8tbYs9e0+yWFzeNYfNYv6yp+wW3dd3sFnseNLI6MDhsXPWXXaPzUvqPXa23mf1eL/vKpvH
        501yAaxRXDYpqTmZZalF+nYJXBkrtjkWbOSo2PbVroHxKFsXIyeHhICJxPw7U9m7GLk4hAR2
        MEp8aTrHApGQlFj29wgzhC0ssfLfc6iiJ4wSs+6vBetmEVCVeDC1i7GLkYODTUBb4vR/DpCw
        iICpxNueVhaQemaBM4wS7e93sYMkhAXMJFZ3toL18groSCyevxtq6Eomiff7V7JDJAQlTs58
        AnYFs4C6xJ95l5hBFjALSEss/8cBEZaXaN46G+w4TgE3idkbv4GViwooSxzYdpxpAqPQLCST
        ZiGZNAth0iwkkxYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOGy2tHYx7Vn3Q
        O8TIxMF4iFGCg1lJhPfL7owkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqem
        FqQWwWSZODilGphmNkSeu+/Zy/AzdJGv3sPXJ3sNLl4t7nK+dN/kX+8ctbV/eb6LrRTa9s+k
        YDWbSN7z4NI5On1n5fnNvWRuVogfPnn2Q/QKI/2ZvLOWpR5raFxyxPrm3G/zt/3jSAwIVNEV
        vlGj9r15qkzKnZTAabfNrOunnG56dvDkm55ZLamR00U/P9HWbLHer/0vbFnmhkXlsVeflx5I
        PvfhVElgVdO7F6tL4/72aE+82pMt+Icv6rLBBfXuw+1eMw7u+cD1b3uQ34IF52+4Sfkp/Ulg
        1VRZN3Ghe9+N0/Z2JkkWB4s/O9acPB8mtemFG6OJ8TmFi3pr5/kn6pxVuj8j33YeF+MJ4zdn
        HZjXyDM/fquzxWWKEktxRqKhFnNRcSIAWXgw9goDAAA=
X-CMS-MailID: 20220428075435epcas5p285a70634102f71440a283361657f4d9b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----MMcOyA4CJjQRgHhn55zXOrpiM0Dxers-aGNKdRjWa9MqQ0PV=_1cb6b_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
        <20220426101241.30100-1-nj.shetty@samsung.com>
        <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
        <20220427124951.GA9558@test-zns>
        <c285f0da-ab1d-2b24-e5a4-21193ef93155@opensource.wdc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------MMcOyA4CJjQRgHhn55zXOrpiM0Dxers-aGNKdRjWa9MqQ0PV=_1cb6b_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Thu, Apr 28, 2022 at 07:05:32AM +0900, Damien Le Moal wrote:
> On 4/27/22 21:49, Nitesh Shetty wrote:
> > O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
> >> On 4/26/22 19:12, Nitesh Shetty wrote:
> >>> The patch series covers the points discussed in November 2021 virtual call
> >>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> >>> We have covered the Initial agreed requirements in this patchset.
> >>> Patchset borrows Mikulas's token based approach for 2 bdev
> >>> implementation.
> >>>
> >>> Overall series supports –
> >>>
> >>> 1. Driver
> >>> - NVMe Copy command (single NS), including support in nvme-target (for
> >>>     block and file backend)
> >>
> >> It would also be nice to have copy offload emulation in null_blk for testing.
> >>
> > 
> > We can plan this in next phase of copy support, once this series settles down.
> 
> So how can people test your series ? Not a lot of drives out there with
> copy support.
>

Yeah not many drives at present, Qemu can be used to test NVMe copy.

--
Nitesh Shetty

------MMcOyA4CJjQRgHhn55zXOrpiM0Dxers-aGNKdRjWa9MqQ0PV=_1cb6b_
Content-Type: text/plain; charset="utf-8"


------MMcOyA4CJjQRgHhn55zXOrpiM0Dxers-aGNKdRjWa9MqQ0PV=_1cb6b_--
