Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFC5486423
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 13:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbiAFMJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 07:09:54 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42273 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232358AbiAFMJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:09:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V15yiET_1641470987;
Received: from 30.21.164.187(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0V15yiET_1641470987)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Jan 2022 20:09:50 +0800
Message-ID: <b7b06597-b3f1-677d-863b-e6cbf6664389@linux.alibaba.com>
Date:   Thu, 6 Jan 2022 20:09:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] sched/core: Cookied forceidle accounting per cpu
Content-Language: en-US
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1640262603-19339-2-git-send-email-CruzZhao@linux.alibaba.com>
 <CABk29NvPJ3S1xq5xm+52OoUGDyuMSxGOLJbopPa3+-QmLnVYeQ@mail.gmail.com>
 <b02204ea-0683-2879-5843-4cfb31d44d27@linux.alibaba.com>
 <CABk29Nts4sysjmRcnZ_DWmMzhUrianp55Zgf-Nod8m+aUKiWeA@mail.gmail.com>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <CABk29Nts4sysjmRcnZ_DWmMzhUrianp55Zgf-Nod8m+aUKiWeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/1/6 上午4:47, Josh Don 写道:
> On Wed, Jan 5, 2022 at 3:33 AM cruzzhao <cruzzhao@linux.alibaba.com> wrote:

> 
> I don't see how this is very helpful for steal_cookie_task(), since it
> isn't a targeted metric for that specific case. If you were interested
> in that specifically, I'd think you'd want to look at more direct
> metrics, such as task migration counts, or adding some
> accounting/histogram for the time between steal and load balance away.
> 

I've already read the patch "sched: CGroup tagging interface for core
scheduling", but it hasn't been merged into linux-next. IMO it's better
to do this at the cgroup level after the cgroup tagging interface is
introduced.

Best,
Cruz Zhao

> 
> That motivation makes more sense to me. Have you considered
> accumulating this at the cgroup level (ie. attributing it as another
> type of usage)?
