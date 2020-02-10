Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B4E156E92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 06:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgBJFG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 00:06:28 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42467 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgBJFG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 00:06:28 -0500
Received: by mail-qk1-f193.google.com with SMTP id q15so5320643qke.9;
        Sun, 09 Feb 2020 21:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gkrur8ZH9ga6UJf6rP/okXyfpeLE1Q7jCwwBrZ0bZFM=;
        b=qMDqBORmRAd5ZpgOFblqUAwZo5iLmgGGq3mA5EuH9/v9M4jnptJjMVAlIEeY9dn4AR
         0YsfD7fsn1NcP/TI3Aps4vngLlG792/PKjX3xALpZk9POCmkIsiZJTq9S9ofE8Q4mFRk
         eWoeL/jTylMIXjAVVXjdZILXit/Vt1OSJCBRvc07SM/K84PqtpSC1g3lu1At/Od4jJnZ
         lZtjhHDlWVIital3eUTyZ4MpVwokI+93hWCa+7YiymA3e+CBusU+Hdl7kNCz2CTxIGGe
         QFf0xdjVQ6mOpz7YY4fS7L6A9aHtSLUij4ZT3lxT4vMighPeqLAGWnbuvFmaMUItWkd1
         IxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gkrur8ZH9ga6UJf6rP/okXyfpeLE1Q7jCwwBrZ0bZFM=;
        b=TwUZoLRlaEFYePzGEboOkW19Rwg2lPipZlCDXLXaLJ9/Xc9nbqI3zY+m0JP8bDkaiM
         W5gDt7W9H+tpFeKA3it1eAmGNERoJW8eoCzINCXcMNmx2D/CxdgbZBPIGXYkFn8Rr+aS
         IB7c8Q6QWn0pw/iGPoID+XnP5uwx5kUnhddCv2k87O9ipZdGF0dhJhp4B6Bq1RUvoL64
         a+GRo88ddAYgJDVC3L5+yMsdnl8jiWB+S4HIP1Bc5TCDmyy7MmxYomZJD+8qJtiKcp8H
         tWdo8nbvWBxH4AuTN5lRkKq1I/yYFt56y1L3zdN607qtHvxNE3yCXI/oGRkT1ERneMRB
         quQA==
X-Gm-Message-State: APjAAAXjwP+ulb54M6YytjQpXUMPYEF33NVPu25Yw2piY/n4sQTDkhCX
        W7MeWoZYDY2bb8seD1WSghk=
X-Google-Smtp-Source: APXvYqwSzMHVASezVRXSEx111LCTL6KYQKgXVKxPFaGrTTAj3Le8B8i0qPcuW9xjxatAcitodSZ5iA==
X-Received: by 2002:a37:693:: with SMTP id 141mr9034197qkg.134.1581311186806;
        Sun, 09 Feb 2020 21:06:26 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q130sm5238519qka.114.2020.02.09.21.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Feb 2020 21:06:26 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 61B2A21ADD;
        Mon, 10 Feb 2020 00:06:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 10 Feb 2020 00:06:25 -0500
X-ME-Sender: <xms:0ORAXj082ZX2f0mvLw_lTVNcfgVqHnk2OdcBfKX5CZidSeTVg2qUJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedtgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhm
    rghilhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:0ORAXkeaS0vsh9hphVg5ara8sSALAIK9pPbyS1APcE4TUJHV3t9Mww>
    <xmx:0ORAXtJ708DhpCxWnYjsps7jOER7L-PblLN0wXJs425T806EKprg0Q>
    <xmx:0ORAXr8Po-h87hb_pymMVqxE1OoNJSAo7VJHS3imKW6KlrAALEECSA>
    <xmx:0eRAXuiXgJYAxbQsh6dLAynE3_8s0-CHQ-bPiUfqAbrstoJQ9SCh29AiXao>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 94EBE328005E;
        Mon, 10 Feb 2020 00:06:23 -0500 (EST)
Date:   Mon, 10 Feb 2020 13:06:22 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, akpm@linux-foundation.org,
        dvyukov@google.com, glider@google.com, aryabinin@virtuozzo.com,
        bsegall@google.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, mgorman@suse.de,
        dvhart@infradead.org, tglx@linutronix.de, namhyung@kernel.org,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        mark.rutland@arm.com, acme@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/11] Lock warning cleanup
Message-ID: <20200210050622.GC69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <0/11>
 <cover.1581282103.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581282103.git.jbi.octave@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jules,

On Sun, Feb 09, 2020 at 10:24:42PM +0000, Jules Irenge wrote:
> This patch series adds missing annotations to functions that register warnings of context imbalance when built with Sparse tool.
> The adds fix the warnings and give insight on what the functions are actually doing.
> 
> 1. Within the futex subsystem, a __releases(&pi_state->.pi_mutex.wait_lock) is added because wake_futex_pi() only releases the lock at exit,
> must_hold(q->lock_ptr) have been added to fixup_pi_state_owner() because the lock is held at entry and exit;
> a __releases(&hb->lock) added to futex_wait_queue_me() as it only releases the lock.
> 
> 2. Within fs_pin, a __releases(RCU) is added because the function exit RCU critical section at exit.
> 
> 3. In kasan, an __acquires(&report_lock) has been added to start_report() and   __releases(&report_lock) to end_report() 
> 
> 4. Within ring_buffer subsystem, a __releases(RCU) has been added perf_output_end() 
> 
> 5. schedule subsystem recorded an addition of the __releases(rq->lock) annotation and a __must_hold(this_rq->lock)
> 
> 6. At hrtimer subsystem, __acquires(timer) is added  to lock_hrtimer_base() as the function acquire the lock but never releases it.
> Jules Irenge (11):
>   hrtimer: Add missing annotation to lock_hrtimer_base()
>   futex: Add missing annotation for wake_futex_pi()
>   futex: Add missing annotation for fixup_pi_state_owner()

Given that those three patches have been sent and reviewed, please do
increase the version number (this time, for example, using v2) when
sending the updated ones. Also please add a few sentences after the
commit log describing what you have changed between versions.

Here is an example:

	https://lore.kernel.org/lkml/20200124231834.63628-4-pmalani@chromium.org/

Regards,
Boqun

>   perf/ring_buffer: Add missing annotation to perf_output_end()
>   sched/fair: Add missing annotation for nohz_newidle_balance()
>   sched/deadline: Add missing annotation for dl_task_offline_migration()
>   fs_pin: Add missing annotation for pin_kill() declaration
>   fs_pin: Add missing annotation for pin_kill() definition
>   kasan: add missing annotation for start_report()
>   kasan: add missing annotation for end_report()
>   futex: Add missing annotation for futex_wait_queue_me()
> 
>  fs/fs_pin.c                 | 2 +-
>  include/linux/fs_pin.h      | 2 +-
>  kernel/events/ring_buffer.c | 2 +-
>  kernel/futex.c              | 3 +++
>  kernel/sched/deadline.c     | 1 +
>  kernel/sched/fair.c         | 2 +-
>  kernel/time/hrtimer.c       | 1 +
>  mm/kasan/report.c           | 4 ++--
>  8 files changed, 11 insertions(+), 6 deletions(-)
> 
> -- 
> 2.24.1
> 
