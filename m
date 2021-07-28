Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842A23D9219
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 17:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhG1Pe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 11:34:58 -0400
Received: from foss.arm.com ([217.140.110.172]:58818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235622AbhG1Pe6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:34:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 330901FB;
        Wed, 28 Jul 2021 08:34:56 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6DA03F70D;
        Wed, 28 Jul 2021 08:34:53 -0700 (PDT)
Date:   Wed, 28 Jul 2021 16:34:51 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/uclamp: Introduce a method to transform UCLAMP_MIN
 into BOOST
Message-ID: <20210728153451.2s4ftzs5u4go7qlm@e107158-lin.cambridge.arm.com>
References: <20210721075751.542-1-xuewen.yan94@gmail.com>
 <d8e14c3c-0eab-2d4d-693e-fb647c7f7c8c@arm.com>
 <CAB8ipk9rO7majqxo0eTnPf5Xs-c4iF8TPQqonCjv6sCd2J6ONA@mail.gmail.com>
 <20210726171716.jow6qfbxx6xr5q3t@e107158-lin.cambridge.arm.com>
 <CAB8ipk9cZ4amrarQSN9TtqEwc42RFM1cBUGsTYKuF0maRFx4Zw@mail.gmail.com>
 <20210727134509.j2fhimhp4dht3hir@e107158-lin.cambridge.arm.com>
 <CAB8ipk8bKe_PxKaXdpqa62soC9_uqTDZMoWU3fi8DUBOD8uErg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8ipk8bKe_PxKaXdpqa62soC9_uqTDZMoWU3fi8DUBOD8uErg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/28/21 09:40, Xuewen Yan wrote:
> Hi Qais
> 
> Thanks for your patient reply, and I have got that I need to do more
> work in uclamp to balance the performance and power, especially in
> per-task API.
> And If there is any progress in the future, I hope to keep
> communicating with you.

Sounds good :)

Thanks!

--
Qais Yousef
