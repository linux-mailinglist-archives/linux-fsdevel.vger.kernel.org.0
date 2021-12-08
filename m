Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD13946DB70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 19:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbhLHSqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 13:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhLHSqm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:46:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D594C0617A1;
        Wed,  8 Dec 2021 10:43:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA491B820D1;
        Wed,  8 Dec 2021 18:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CE8C00446;
        Wed,  8 Dec 2021 18:43:05 +0000 (UTC)
Date:   Wed, 8 Dec 2021 13:43:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org, pmladek@suse.com,
        david@redhat.com, arnaldo.melo@gmail.com,
        andrii.nakryiko@gmail.com, linux-mm@kvack.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH -mm 4/5] tools/perf: replace hard-coded 16 with
 TASK_COMM_LEN
Message-ID: <20211208134304.615abbbf@gandalf.local.home>
In-Reply-To: <20211204095256.78042-5-laoar.shao@gmail.com>
References: <20211204095256.78042-1-laoar.shao@gmail.com>
        <20211204095256.78042-5-laoar.shao@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat,  4 Dec 2021 09:52:55 +0000
Yafang Shao <laoar.shao@gmail.com> wrote:

> @@ -43,7 +45,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
>  		return -1;
>  	}
>  
> -	if (evsel__test_field(evsel, "prev_comm", 16, false))
> +	if (evsel__test_field(evsel, "prev_comm", TASK_COMM_LEN, false))
>  		ret = -1;
>  
>  	if (evsel__test_field(evsel, "prev_pid", 4, true))
> @@ -55,7 +57,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
>  	if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
>  		ret = -1;
>  
> -	if (evsel__test_field(evsel, "next_comm", 16, false))
> +	if (evsel__test_field(evsel, "next_comm", TASK_COMM_LEN, false))
>  		ret = -1;
>  
>  	if (evsel__test_field(evsel, "next_pid", 4, true))
> @@ -73,7 +75,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
>  		return -1;
>  	}
>  
> -	if (evsel__test_field(evsel, "comm", 16, false))
> +	if (evsel__test_field(evsel, "comm", TASK_COMM_LEN, false))

Shouldn't all these be TASK_COMM_LEN_16?

-- Steve

>  		ret = -1;
>  
>  	if (evsel__test_field(evsel, "pid", 4, true))

