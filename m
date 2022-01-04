Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5FB483C28
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 08:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiADHPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 02:15:23 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57823 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230349AbiADHPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:15:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V0rVymd_1641280518;
Received: from 30.21.164.248(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0V0rVymd_1641280518)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jan 2022 15:15:19 +0800
Message-ID: <048124e2-8436-62e3-6205-f122ec386763@linux.alibaba.com>
Date:   Tue, 4 Jan 2022 15:15:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 0/2] Forced idle time accounting per cpu
Content-Language: en-US
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     adobriyan@gmail.com, joshdon@google.com, edumazet@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping.
Accounting forced idle time for per cpu can help us measure the cost of
enabling core scheduling from a global perspective. Mind having a look
at it?
在 2021/12/23 下午8:30, Cruz Zhao 写道:
> Josh Don's patch 4feee7d12603 ("sched/core: Forced idle accounting")
> provides one means to measure the cost of enabling core scheduling
> from the perspective of the task, and this patchset provides another
> means to do that from the perspective of the cpu.
> 
> Forced idle can be divided into two types, forced idle with cookie'd task
> running on it SMT sibling, and forced idle with uncookie'd task running
> on it SMT sibling, which should be accounting to measure the cost of
> enabling core scheduling too. This patchset accounts both and the sum
> of both, which are displayed via /proc/stat.
> 
> Cruz Zhao (2):
>   sched/core: Cookied forceidle accounting per cpu
>   sched/core: Uncookied force idle accounting per cpu
> 
>  fs/proc/stat.c              | 26 ++++++++++++++++++++++++++
>  include/linux/kernel_stat.h |  4 ++++
>  kernel/sched/core.c         |  7 +++----
>  kernel/sched/core_sched.c   | 21 +++++++++++++++++++--
>  kernel/sched/sched.h        | 10 ++--------
>  5 files changed, 54 insertions(+), 14 deletions(-)
> 
> base commit: 2850c2311ef4bf30ae8dd8927f0f66b026ff08fb
