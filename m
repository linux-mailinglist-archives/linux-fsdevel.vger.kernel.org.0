Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54C50C13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfFXNdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 09:33:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728884AbfFXNdt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:33:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D7DD23998DC962976001;
        Mon, 24 Jun 2019 21:33:43 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Jun 2019
 21:33:37 +0800
Subject: Re: [PATCH next] softirq: enable MAX_SOFTIRQ_TIME tuning with sysctl
 max_softirq_time_usecs
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <corbet@lwn.net>, <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, <akpm@linux-foundation.org>,
        <manfred@colorfullife.com>, <jwilk@jwilk.net>,
        <dvyukov@google.com>, <feng.tang@intel.com>,
        <sunilmut@microsoft.com>, <quentin.perret@arm.com>,
        <linux@leemhuis.info>, <alex.popov@linux.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "wangxiaogang (F)" <wangxiaogang3@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, <tedheadster@gmail.com>,
        Eric Dumazet <edumazet@google.com>
References: <f274f85a-bbb6-3e32-b293-1d5d7f27a98f@huawei.com>
 <alpine.DEB.2.21.1906231820470.32342@nanos.tec.linutronix.de>
 <0099726a-ead3-bdbe-4c66-c8adc9a4f11b@huawei.com>
 <alpine.DEB.2.21.1906241141370.32342@nanos.tec.linutronix.de>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <e870e089-efb6-53a7-4299-8468f2ba8852@huawei.com>
Date:   Mon, 24 Jun 2019 21:32:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906241141370.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/6/24 17:45, Thomas Gleixner wrote:
> Zhiqiang,
> 
> On Mon, 24 Jun 2019, Zhiqiang Liu wrote:
>> ÔÚ 2019/6/24 0:38, Thomas Gleixner Ð´µÀ:
>>
>> Thanks again for your detailed advice.
>> As your said, the max_softirq_time_usecs setting without explaining the
>> relationship with CONFIG_HZ will give a false sense of controlability. And
>> the time accuracy of jiffies will result in a certain difference between the
>> max_softirq_time_usecs set value and the actual value, which is in one jiffies
>> range.
>>
>> I will add these infomation in the sysctl documentation and changelog in v2 patch.
> 
> Please make the sysctl milliseconds based. That's the closest approximation
> of useful units for this. This still has the same issues as explained
> before but it's not off by 3 orders of magitude anymore.
> 
> Thanks,
> 
> 	tglx
> 
Thanks for your suggestion.
I will adopt max_softirq_time_ms to replace MAX_SOFTIRQ_TIME in v2.

