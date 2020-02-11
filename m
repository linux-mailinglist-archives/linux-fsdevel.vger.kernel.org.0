Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49581158808
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 02:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgBKByI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 20:54:08 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:36036 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727523AbgBKByI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:54:08 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 48BD9585BDD19205D0E7;
        Tue, 11 Feb 2020 09:54:04 +0800 (CST)
Received: from dggeme715-chm.china.huawei.com (10.1.199.111) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 09:54:04 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme715-chm.china.huawei.com (10.1.199.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 11 Feb 2020 09:54:03 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Tue, 11 Feb 2020 09:54:03 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "Luoshijie (Poincare Lab)" <luoshijie1@huawei.com>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: remove comments about free_more_memory
Thread-Topic: [PATCH] fs: remove comments about free_more_memory
Thread-Index: AdXgfZ1UANEONoNWRy6wHEkzu1R96A==
Date:   Tue, 11 Feb 2020 01:54:03 +0000
Message-ID: <4e4c4220c12c45cd8f1bbf0505a69f16@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.158]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi:
Luoshijie (Poincare Lab) <luoshijie1@huawei.com> wrote:
> Remove comments about free_more_memory because this function no more exists.
>
>Signed-off-by: Shijie Luo <luoshijie1@huawei.com>

Looks fine. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

