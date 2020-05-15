Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF08A1D49CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 11:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgEOJju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 05:39:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727785AbgEOJjt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 05:39:49 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6FBF7C70F08E624CB061;
        Fri, 15 May 2020 17:39:47 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 17:39:38 +0800
Subject: Re: [PATCH 4/4] sysctl: Add register_sysctl_init() interface
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
 <1589517224-123928-5-git-send-email-nixiaoming@huawei.com>
 <202005150110.988A691@keescook>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <d82003f3-8449-03ba-b069-2247a2454443@huawei.com>
Date:   Fri, 15 May 2020 17:39:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <202005150110.988A691@keescook>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/15 16:10, Kees Cook wrote:
> On Fri, May 15, 2020 at 12:33:44PM +0800, Xiaoming Ni wrote:
>> In order to eliminate the duplicate code for registering the sysctl
>> interface during the initialization of each feature, add the
>> register_sysctl_init() interface
> 
> I think this should come before the code relocations.
> 
Thanks for your guidance, I will adjust it in v2 version.

Thanks
Xiaoming Ni


