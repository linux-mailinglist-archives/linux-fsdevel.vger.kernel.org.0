Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5722F0B66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 04:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbhAKDO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 22:14:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10702 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAKDO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 22:14:59 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DDf0Z2HLFzkcn5;
        Mon, 11 Jan 2021 11:13:02 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 11 Jan 2021 11:14:09 +0800
Subject: Re: [PATCH v2] proc_sysctl: fix oops caused by incorrect command
 parameters.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "wangle6@huawei.com" <wangle6@huawei.com>
References: <20210108023339.55917-1-nixiaoming@huawei.com>
 <CAHp75Vfdyh1ad7p_-uqYZPyF78tOB96HKNQVXkOv_yrReo2Mcg@mail.gmail.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <ce276a4e-6be2-cb39-6006-a21bced347f8@huawei.com>
Date:   Mon, 11 Jan 2021 11:14:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfdyh1ad7p_-uqYZPyF78tOB96HKNQVXkOv_yrReo2Mcg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/1/9 17:10, Andy Shevchenko wrote:
> 
> 
> On Friday, January 8, 2021, Xiaoming Ni <nixiaoming@huawei.com 
> <mailto:nixiaoming@huawei.com>> wrote:
> 
>     The process_sysctl_arg() does not check whether val is empty before
>       invoking strlen(val). If the command line parameter () is incorrectly
>       configured and val is empty, oops is triggered.
> 
>     For example, "hung_task_panic=1" is incorrectly written as
>     "hung_task_panic".
> 
>     log:
> 
> 
> Can you drop redundant (not significant) lines from the log to avoid 
> noisy commit message?
> 
ok,
Thank you for your advice.
I will update it in v3 patch.

Thanks

Xiaoming Ni.

