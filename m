Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBF91585F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 00:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBJXKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 18:10:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53391 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbgBJXKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 18:10:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so1161140wmh.3;
        Mon, 10 Feb 2020 15:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=HlH978RiT/OKtcm1ieT3FHA3Af2vEFe/d++NhRbZZHo=;
        b=hUMe+OTAFXZgUF0+R7cEvjnrltme/tHFT+wFq3l3Nzg1DtXP4xQl47fCHVEROqJ+0c
         1IT2s5+YdBO0d/8sou/Dd9MFnuA6l8twUXKyy6q/mJRw7F53FgVbEyLqK9SyV8bZ7Vrb
         MRTqY9Q1oyBVQILT+p4MSBb9bQeRYqOK3FUIZoXnHyynBXjxc79s1vTdHvzsOiabaFyE
         ZvWSOhJVXx54CswqcaFYfuEdPV2yTA7rRKaVVdtquY7ONWQZEcoLj3C6Mw5UNpXJtVES
         U+fsEinijrH+fpcvx19n07N91WSpZqBzct7ajwT1RucauWCaU+v0CJoEkFkEgr1GKrO0
         kUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=HlH978RiT/OKtcm1ieT3FHA3Af2vEFe/d++NhRbZZHo=;
        b=mGQnU5UP5uzNnlgZgYfzEEtjUeySxeJ24XDW+uY90UMhHgylRCUkkY0qIXGk/JFPNw
         atIzF+iRlylaZTCDo0KEkTZbEZ0m5Ex6iSYgQokitfC+lPo2GCONtDrHHLJ7obrHyQ+7
         IkXFP7aWcXr1AanVzb+K8PHjsj73VQkwm+BQ61+yqTECc+2AczJUBh054seR9120Yu+L
         VyuUVFaHSogOulKPSPMNg+dWMJdKukt8idbd4yfa90RLZNHFtmuXDEjsbPFp9pESLeuz
         ge9sEKu2/8tULrKklxEG1x6GuOqbKCtpTCggdmAdxBrxPAOE1ohEggklTSx7MGMZ4lx9
         YEKA==
X-Gm-Message-State: APjAAAUpnqFpHdvoDzP0ZedyONHVnawBd0bUOsvolJTTSduH4B3q5U8e
        3PXQmEs/NProhU7Ew9VAHw==
X-Google-Smtp-Source: APXvYqx05+Nv0JSPMDzbeKlDwV27qd+uDgHvjje2LWi8e7snFKtFKr/I3E7VoY7I3fYYmsg581it+g==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr1428624wmc.78.1581376208631;
        Mon, 10 Feb 2020 15:10:08 -0800 (PST)
Received: from ninjahub.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.gmail.com with ESMTPSA id 18sm1122951wmf.1.2020.02.10.15.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 15:10:08 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Mon, 10 Feb 2020 23:09:59 +0000 (GMT)
To:     Boqun Feng <boqun.feng@gmail.com>
cc:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        akpm@linux-foundation.org, dvyukov@google.com, glider@google.com,
        aryabinin@virtuozzo.com, bsegall@google.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        mgorman@suse.de, dvhart@infradead.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/11] Lock warning cleanup
In-Reply-To: <20200210050622.GC69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Message-ID: <alpine.LFD.2.21.2002102306000.191510@ninjahub.org>
References: <0/11> <cover.1581282103.git.jbi.octave@gmail.com> <20200210050622.GC69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 10 Feb 2020, Boqun Feng wrote:

> Hi Jules,
> 
> On Sun, Feb 09, 2020 at 10:24:42PM +0000, Jules Irenge wrote:
> > This patch series adds missing annotations to functions that register warnings of context imbalance when built with Sparse tool.
> > The adds fix the warnings and give insight on what the functions are actually doing.
> > 
> > 1. Within the futex subsystem, a __releases(&pi_state->.pi_mutex.wait_lock) is added because wake_futex_pi() only releases the lock at exit,
> > must_hold(q->lock_ptr) have been added to fixup_pi_state_owner() because the lock is held at entry and exit;
> > a __releases(&hb->lock) added to futex_wait_queue_me() as it only releases the lock.
> > 
> > 2. Within fs_pin, a __releases(RCU) is added because the function exit RCU critical section at exit.
> > 
> > 3. In kasan, an __acquires(&report_lock) has been added to start_report() and   __releases(&report_lock) to end_report() 
> > 
> > 4. Within ring_buffer subsystem, a __releases(RCU) has been added perf_output_end() 
> > 
> > 5. schedule subsystem recorded an addition of the __releases(rq->lock) annotation and a __must_hold(this_rq->lock)
> > 
> > 6. At hrtimer subsystem, __acquires(timer) is added  to lock_hrtimer_base() as the function acquire the lock but never releases it.
> > Jules Irenge (11):
> >   hrtimer: Add missing annotation to lock_hrtimer_base()
> >   futex: Add missing annotation for wake_futex_pi()
> >   futex: Add missing annotation for fixup_pi_state_owner()
> 
> Given that those three patches have been sent and reviewed, please do
> increase the version number (this time, for example, using v2) when
> sending the updated ones. Also please add a few sentences after the
> commit log describing what you have changed between versions.
> 
> Here is an example:
> 
> 	https://lore.kernel.org/lkml/20200124231834.63628-4-pmalani@chromium.org/
> 
> Regards,
> Boqun
> 
> >   perf/ring_buffer: Add missing annotation to perf_output_end()
> >   sched/fair: Add missing annotation for nohz_newidle_balance()
> >   sched/deadline: Add missing annotation for dl_task_offline_migration()
> >   fs_pin: Add missing annotation for pin_kill() declaration
> >   fs_pin: Add missing annotation for pin_kill() definition
> >   kasan: add missing annotation for start_report()
> >   kasan: add missing annotation for end_report()
> >   futex: Add missing annotation for futex_wait_queue_me()
> > 
> >  fs/fs_pin.c                 | 2 +-
> >  include/linux/fs_pin.h      | 2 +-
> >  kernel/events/ring_buffer.c | 2 +-
> >  kernel/futex.c              | 3 +++
> >  kernel/sched/deadline.c     | 1 +
> >  kernel/sched/fair.c         | 2 +-
> >  kernel/time/hrtimer.c       | 1 +
> >  mm/kasan/report.c           | 4 ++--
> >  8 files changed, 11 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.24.1
> > 
> 

Thanks for the feedback, I take good notes. I am working on the 
second version.

Kind regards,
Jules
