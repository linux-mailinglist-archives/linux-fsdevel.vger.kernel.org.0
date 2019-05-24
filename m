Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE9E28F96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 05:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfEXD1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 23:27:49 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:39778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729972AbfEXD1t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 23:27:49 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 3D7A1350DA8E8166CC16;
        Fri, 24 May 2019 11:27:47 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 May 2019 11:27:47 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 24 May 2019 11:27:46 +0800
Subject: Re: [PATCH v6 1/1] f2fs: ioctl for removing a range from F2FS
To:     Sahitya Tummala <stummala@codeaurora.org>
CC:     sunqiuyang <sunqiuyang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190524015555.12622-1-sunqiuyang@huawei.com>
 <e7cfed52-0212-834f-aed8-0c5abc07f779@huawei.com>
 <20190524030958.GB10043@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d298c4a5-4ba7-df8c-5bbe-74ce4ce9604e@huawei.com>
Date:   Fri, 24 May 2019 11:28:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190524030958.GB10043@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/5/24 11:09, Sahitya Tummala wrote:
> I am okay with merging.

Thank you, it looks Qiuyang has confirmed before v2. :)

Thanks,

