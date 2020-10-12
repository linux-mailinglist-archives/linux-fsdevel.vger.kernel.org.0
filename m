Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728D128B467
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 14:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbgJLMNd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 08:13:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3631 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388209AbgJLMNd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:13:33 -0400
X-Greylist: delayed 966 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 08:13:32 EDT
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 000DCF8DF6F97C310D13;
        Mon, 12 Oct 2020 19:57:24 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.75]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0487.000;
 Mon, 12 Oct 2020 19:57:21 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     "yulei.kernel@gmail.com" <yulei.kernel@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
        "kernellwp@gmail.com" <kernellwp@gmail.com>,
        "lihaiwei.kernel@gmail.com" <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: RE: [PATCH 00/35] Enhance memory utilization with DMEMFS
Thread-Topic: [PATCH 00/35] Enhance memory utilization with DMEMFS
Thread-Index: AQHWnUhD+KX8RHawSUyoBEEGXF5fO6mT4mTw
Date:   Mon, 12 Oct 2020 11:57:20 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED49E01801@dggemm526-mbx.china.huawei.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> -----Original Message-----
> From: yulei.kernel@gmail.com [mailto:yulei.kernel@gmail.com]
> Sent: Thursday, October 08, 2020 3:54 PM
> To: akpm@linux-foundation.org; naoya.horiguchi@nec.com;
> viro@zeniv.linux.org.uk; pbonzini@redhat.com
> Cc: linux-fsdevel@vger.kernel.org; kvm@vger.kernel.org;
> linux-kernel@vger.kernel.org; xiaoguangrong.eric@gmail.com;
> kernellwp@gmail.com; lihaiwei.kernel@gmail.com; Yulei Zhang
> Subject: [PATCH 00/35] Enhance memory utilization with DMEMFS
> 
> From: Yulei Zhang <yuleixzhang@tencent.com>
> 
> In current system each physical memory page is assocaited with
> a page structure which is used to track the usage of this page.
> But due to the memory usage rapidly growing in cloud environment,
> we find the resource consuming for page structure storage becomes
> highly remarkable. So is it an expense that we could spare?
> 
> This patchset introduces an idea about how to save the extra
> memory through a new virtual filesystem -- dmemfs.
> 
> Dmemfs (Direct Memory filesystem) is device memory or reserved
> memory based filesystem. This kind of memory is special as it
> is not managed by kernel and most important it is without 'struct page'.
> Therefore we can leverage the extra memory from the host system
> to support more tenants in our cloud service.
> 
> We uses a kernel boot parameter 'dmem=' to reserve the system
> memory when the host system boots up, the details can be checked
> in /Documentation/admin-guide/kernel-parameters.txt.
> 
> Theoretically for each 4k physical page it can save 64 bytes if
> we drop the 'struct page', so for guest memory with 320G it can
> save about 5G physical memory totally.

Sounds interesting, but seems your patch only support x86, have you
 considered aarch64?

Regards
Zengtao 
