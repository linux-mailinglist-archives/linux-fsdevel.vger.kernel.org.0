Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B4529DBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 11:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbiEQJTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 05:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244612AbiEQJTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 05:19:02 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1732B2AE1B
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 02:18:38 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220517091837euoutp01493de0d15838ac11f6a5d4c16592b9fd~v2dmjZ6b40612806128euoutp01T
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 09:18:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220517091837euoutp01493de0d15838ac11f6a5d4c16592b9fd~v2dmjZ6b40612806128euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652779117;
        bh=Xx6LiI2N7zXzXe6D47VeoDmtSPAgM7x9gfv66x7nXf4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=IA4MPLLaEWwNdOeYo6LNZPRnH+Spn9FlillpzIsthWm0Us4gzJW4OFmJYxa+uwQi9
         RCTemcymVdx5BWGIUBY2Ntc+4YBB7Zok4VNVvov059+YyzKXqlZOsXtqP2oz2xcUCm
         T463E2j+XpLZ3S7NET7zPF0khI0EFyEJX9xc167Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220517091836eucas1p1b4f31c8b471be4cec69d428e87500289~v2dmHOtrc0676506765eucas1p1o;
        Tue, 17 May 2022 09:18:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 44.CF.09887.C6863826; Tue, 17
        May 2022 10:18:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220517091836eucas1p29b087b757e6368110a993b6161f558a4~v2dlr-o5d1027210272eucas1p2Z;
        Tue, 17 May 2022 09:18:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517091836eusmtrp268345fd5a35205b6ac7f4519dcde07ee~v2dlqyygZ0823508235eusmtrp28;
        Tue, 17 May 2022 09:18:36 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-c5-6283686c6c70
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.C7.09522.B6863826; Tue, 17
        May 2022 10:18:36 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220517091835eusmtip22dc882ff288673a913e1a719db7c1311~v2dlik-a70904809048eusmtip2V;
        Tue, 17 May 2022 09:18:35 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 17 May 2022 10:18:35 +0100
Date:   Tue, 17 May 2022 11:18:34 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Pankaj Raghav <p.raghav@samsung.com>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <pankydev8@gmail.com>,
        <dsterba@suse.com>, <linux-nvme@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <jiangbo.365@bytedance.com>, <linux-block@vger.kernel.org>,
        <gost.dev@samsung.com>, <linux-kernel@vger.kernel.org>,
        <dm-devel@redhat.com>
Subject: Re: [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <20220517091834.dvkrab5l63v3b2zn@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <20220517081048.GA13947@lst.de>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djP87o5Gc1JBqubpC1W3+1ns/h99jyz
        xd53s1ktLvxoZLJYufook0XPgQ8sFntvaVtceryC3WLP3pMsFpd3zWGzmL/sKbvFmptPWRx4
        PP6dWMPmsXPWXXaPy2dLPTYvqffYfbMBKNJ6n9Xj/b6rbB7rt1xl8fi8SS6AM4rLJiU1J7Ms
        tUjfLoErY/3CFSwFS/gqGtdvZ2xg7OXuYuTkkBAwkbi48RZLFyMXh5DACkaJLdPmskI4Xxgl
        fs/fxgzhfGaU2Nl7kBGmZfu2j0wQieWMEl+vXGWEq7o7Zy4bhLOVUWJOywZ2kBYWAVWJ/iur
        wWw2AXuJS8tuMYPYIgJKEk9fnQXrZhZoZpaY9PAckMPBISzgJLH4NzOIyStgK/HvcDRIOa+A
        oMTJmU9YQGxmASuJzg9NrCAlzALSEsv/cYCEOQV0JG4uew/WKSGgLLF8ui/EzbUSa4+dYQdZ
        JCGwmFNi8ssrbBAJF4nH+14xQ9jCEq+Ob2GHsGUk/u+czwRhZ0tcPNMNVVMisfj9Maj51hJ9
        Z3Igwo4S7bf2skOE+SRuvBWEOJJPYtK26VDVvBIdbUIQ1WoSO5q2Mk5gVJ6F5K1ZSN6ahfDW
        AkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIGp6/S/4192MC5/9VHvECMTB+MhRgkO
        ZiURXoOKhiQh3pTEyqrUovz4otKc1OJDjNIcLErivMmZGxKFBNITS1KzU1MLUotgskwcnFIN
        TNLvJ7dJB5YJ3Ft9kyUzz/vAopyD/gszri+vVDXbyqlSF8b9u8f9vairXnCEaMDJvDv8KZMZ
        XQ7ePhlb2h94bs0JkeOt0hmHwqb8ivq17N8+hatf1NX/+cuGT8sL+znD97bc4mYuo+wTG9eX
        3YtNeeN7LtPrukz3ks48mZaMx+H6M/O/K00NVHReac3ycgf3Nn0Wbv7X+klczr8rJ+z/8WfL
        1MORqS+tF3wRDnBWLHYJW+QrFp6s6nPqmeDJrJUBbzTZhW9HrFP58NNp9Z+l9a+teayFmULf
        /t5yXjDHtkBdOMQjoVlw4reT+57on7CffqGFkdFhu9i2KwKe3O3m73a5mX6OXrp7j2B6+uN5
        SizFGYmGWsxFxYkALkktKMwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7o5Gc1JBiuvMVmsvtvPZvH77Hlm
        i73vZrNaXPjRyGSxcvVRJoueAx9YLPbe0ra49HgFu8WevSdZLC7vmsNmMX/ZU3aLNTefsjjw
        ePw7sYbNY+esu+wel8+WemxeUu+x+2YDUKT1PqvH+31X2TzWb7nK4vF5k1wAZ5SeTVF+aUmq
        QkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexvqFK1gKlvBVNK7f
        ztjA2MvdxcjJISFgIrF920emLkYuDiGBpYwSPWdWM0MkZCQ+XfnIDmELS/y51sUGUfSRUeLo
        27WsEM5WRom9T2+CdbAIqEr0X1kN1sEmYC9xadktsLiIgJLE01dnGUEamAUamSUm3loGNIqD
        Q1jASWLxb2YQk1fAVuLf4WiQciGBDUAzF3uC2LwCghInZz5hAbGZBSwkZs4/zwhSziwgLbH8
        HwdImFNAR+LmsvdgUyQElCWWT/eFOLlW4tX93YwTGIVnIRk0C8mgWQiDFjAyr2IUSS0tzk3P
        LTbUK07MLS7NS9dLzs/dxAiM4W3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeA0qGpKEeFMSK6tS
        i/Lji0pzUosPMZoCw2Eis5Rocj4wieSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqem
        FqQWwfQxcXBKNTBxKyapr3/1xatW42ms5seT5RF/fSMv7JBKztHe2BZ9RFZytQ6vJntxf9Yf
        t4f9YazrkoTyOKvedWhfvcLXc6d6i8pxnzRN3SMH/9vbv2EPYM/yP/7hvE3gOmmnY3fy1bKZ
        dxTyf7y9qT+xb4vErgk9mr7Jcsv/8Tx3uhGg79+dcLQuxS6zaWtzwONbf5bs0m+am3j74OG0
        byr3rxzJevDgzDWBovDEP4xMO8x+pPwtVUstVz5e7s2W5O22e/b6vfYv75p90v45xUd669eQ
        697u9SbhD5vDLdcan69KLJRimP97+z179ckq/yXZYlddVZtVpJWx7NbLhntL3glK1sVYx8nZ
        Of68deT8ro8t65RYijMSDbWYi4oTAbuoZDFqAwAA
X-CMS-MailID: 20220517091836eucas1p29b087b757e6368110a993b6161f558a4
X-Msg-Generator: CA
X-RootMTR: 20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
        <20220516165416.171196-1-p.raghav@samsung.com>
        <20220517081048.GA13947@lst.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.05.2022 10:10, Christoph Hellwig wrote:
>I'm a little surprised about all this activity.
>
>I though the conclusion at LSF/MM was that for Linux itself there
>is very little benefit in supporting this scheme.  It will massively
>fragment the supported based of devices and applications, while only
>having the benefit of supporting some Samsung legacy devices.

I believed we had agreed that non-power-of-2 zoned devices was something
to explore. Let me summarize the 3 main points we covered at different
times at LSF/MM:

   - This is not for legacy Samsung ZNS devices. At least 4 other
     vendors have reported building non-power-of-2 ZNS devices to meet
     customer demands on removing holes in the address space. It seems
     like there will be more ZNS devices with size=capacity out there
     than with PO2 sizes. Block device and FS support is very desirable
     for these.

   - We also talked about how the capacity not being a PO2 is the one
     introducing the fragmentation, as applications that already worked
     with SMR HDDs will have to change their data placement policy. The
     size is just a construction, but the real work is adopting the
     capacity.

   - Besides the previous poit, the fragmentation will happen from the
     moment we have available devices. This is not a kernel-only issue.
     We have SMR, ZNS, and soon another spec for zone devices. I
     understood that as long as we do not break any existing support, we
     would be able to expend the zoned ecosystem in Linux.

>So my impression was that this work, while technically feasible, is
>rather useless.  So unless I missed something important I have no
>interest in supporting this in NVMe.

Does the above help you reconsidering your interest in supporting this
in NVMe?
