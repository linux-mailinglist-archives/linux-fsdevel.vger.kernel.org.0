Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD51D1D4948
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 11:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgEOJST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 05:18:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727116AbgEOJST (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 05:18:19 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8383EF3AD3429BBE4F04;
        Fri, 15 May 2020 17:18:16 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 17:17:57 +0800
Subject: Re: [PATCH 3/4] watchdog: move watchdog sysctl to watchdog.c
To:     Kees Cook <keescook@chromium.org>
CC:     <mcgrof@kernel.org>, <yzaikin@google.com>, <adobriyan@gmail.com>,
        <mingo@kernel.org>, <peterz@infradead.org>,
        <akpm@linux-foundation.org>, <yamada.masahiro@socionext.com>,
        <bauerman@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <skhan@linuxfoundation.org>, <dvyukov@google.com>,
        <svens@stackframe.org>, <joel@joelfernandes.org>,
        <tglx@linutronix.de>, <Jisheng.Zhang@synaptics.com>,
        <pmladek@suse.com>, <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <wangle6@huawei.com>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-4-git-send-email-nixiaoming@huawei.com>
 <202005150107.DA3ABE3@keescook>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <287d50e9-28b6-0d9f-1aa7-aac5bbeb0807@huawei.com>
Date:   Fri, 15 May 2020 17:17:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <202005150107.DA3ABE3@keescook>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/15 16:09, Kees Cook wrote:
> On Fri, May 15, 2020 at 12:33:43PM +0800, Xiaoming Ni wrote:
>> +static int sixty = 60;
> 
> This should be const. (Which will require a cast during extra2
> assignment.)
> 
Sorry, I forgot to append const.
Thanks for your guidance.

Thanks
Xiaoming Ni

