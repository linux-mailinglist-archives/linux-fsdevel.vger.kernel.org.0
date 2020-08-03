Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E657823AA88
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHCQdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCQdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:33:39 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67AEC06179E
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2020 09:33:39 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id l184so7451055vki.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2020 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZrsVGmEonw8RlzrjbIL0se7EVy203/PdgKAT5NhYH9U=;
        b=EuzrSyZx2O9WjU4B/dBgt6g2qnGt7FmJ53XV6UBNMRexm1Ii6XSUrrzJfGvy9OTU2M
         maTa4Wp9YJ6b092D3ecVEcnbxlzAw8DQNSe0Q3FWUkv9MNnOJ3ZQCyzbb+RqTe4lDjAK
         BFQv+NKZWB6TsIq/7yvND0QeQJuyi7NhAlvCWMNm0RWKm3nj5cxYRwzRaV/Lyox20Tz+
         wRv2i+kklqMQsKooBSZBjLGXFsB5Mo2/GHH25ZE1OPOhcqz8AAgxCC0DliJWesp2J6FO
         +fzW6YY9JgId7v7deB+ExovkiaIRNHeZ8FdhLAsQnDy3WC5Uf5ots1Bt+c04iZnJsy8g
         QoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZrsVGmEonw8RlzrjbIL0se7EVy203/PdgKAT5NhYH9U=;
        b=XEYD3cM5Fq4Br/0yYVpktNAanCtgeSln8uPPgRT0kVUV8QW1Pr8+5+7w+Wc9nCW9pq
         jaYIGoGrv4paEgS/sd6LB/9VikAtxpJqPH2xCRsuHNiDyDuyQZMRY+hXwy1JfTwU5Iyx
         JsVlP+AODwNZ/tt9BHuEKzDRBpAbULg5+vcn+jmtxX6FRATz5rE/IDMp1MYD3M9cC3mO
         yQwFPCrKi57e4h7YYCXQqJO1cZcQNCqKkUQofUwIfHDGnRV1RNrjuML1MC5DaFJjALo/
         DqtDLuCF9tmfP0uw03BhzkJJ5NpqQ4Er7ynGw2zzsWVxDWqWOWqR8cmzwfqGqloxETCe
         eL0A==
X-Gm-Message-State: AOAM531TK/inPrjyRrYSzWKPvrPJhnaOGa2ZTyMvD5+2G7PLe9rb+sto
        u2u3Zx3wtLfu/t4JSjx9+PTd0Q==
X-Google-Smtp-Source: ABdhPJxNZWf6OwoaN9iiZETX6lkFT97KzJHntHF276HRslkmU5htJ72jrlMz9cB9lP3tWNZIEV7w6g==
X-Received: by 2002:a05:6122:1353:: with SMTP id f19mr12642301vkp.38.1596472418034;
        Mon, 03 Aug 2020 09:33:38 -0700 (PDT)
Received: from google.com (182.71.196.35.bc.googleusercontent.com. [35.196.71.182])
        by smtp.gmail.com with ESMTPSA id k74sm2802571vka.16.2020.08.03.09.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:33:37 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:33:34 +0000
From:   Kalesh Singh <kaleshsingh@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-fsdevel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Ioannis Ilkos <ilkos@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 2/2] dmabuf/tracing: Add dma-buf trace events
Message-ID: <20200803163334.GA3212137@google.com>
References: <20200803144719.3184138-1-kaleshsingh@google.com>
 <20200803144719.3184138-3-kaleshsingh@google.com>
 <20200803113239.194eb86f@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803113239.194eb86f@oasis.local.home>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 11:32:39AM -0400, Steven Rostedt wrote:
> On Mon,  3 Aug 2020 14:47:19 +0000
> Kalesh Singh <kaleshsingh@google.com> wrote:
> 
> > +DECLARE_EVENT_CLASS(dma_buf_ref_template,
> > +
> > +	TP_PROTO(struct task_struct *task, struct file *filp),
> > +
> > +	TP_ARGS(task,  filp),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(u32, tgid)
> > +		__field(u32, pid)
> 
> I only see "current" passed in as "task". Why are you recording the pid
> and tgid as these are available by the tracing infrastructure.
> 
> At least the pid is saved at every event. You can see the tgid when
> enabling the "record_tgid".
> 
>  # trace-cmd start -e all -O record_tgid
>  # trace-cmd show
> 
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 39750/39750   #P:8
> #
> #                                      _-----=> irqs-off
> #                                     / _----=> need-resched
> #                                    | / _---=> hardirq/softirq
> #                                    || / _--=> preempt-depth
> #                                    ||| /     delay
> #           TASK-PID    TGID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |        |      |   ||||       |         |
>        trace-cmd-28284 (28284) [005] .... 240338.934671: sys_exit: NR 1 = 1
>      kworker/3:2-27891 (27891) [003] d... 240338.934671: timer_start: timer=00000000d643debd function=delayed_work_timer_fn expires=4535008893 [timeout=1981] cpu=3 idx=186 flags=I
>        trace-cmd-28284 (28284) [005] .... 240338.934672: sys_write -> 0x1
>      kworker/3:2-27891 (27891) [003] .... 240338.934672: workqueue_execute_end: work struct 000000008fddd403: function psi_avgs_work
>      kworker/3:2-27891 (27891) [003] .... 240338.934673: workqueue_execute_start: work struct 00000000111c941e: function dbs_work_handler
>      kworker/3:2-27891 (27891) [003] .... 240338.934673: workqueue_execute_end: work struct 00000000111c941e: function dbs_work_handler
>      kworker/3:2-27891 (27891) [003] d... 240338.934673: rcu_utilization: Start context switch
>      kworker/3:2-27891 (27891) [003] d... 240338.934673: rcu_utilization: End context switch
> 
> -- Steve
> 
Thanks for the comments Steve. I'll remove the task arg.

> > +		__field(u64, size)
> > +		__field(s64, count)
> > +		__string(exp_name, dma_buffer(filp)->exp_name)
> > +		__string(name, dma_buffer(filp)->name ? dma_buffer(filp)->name : UNKNOWN)
> > +		__field(u64, i_ino)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->tgid = task->tgid;
> > +		__entry->pid = task->pid;
> > +		__entry->size = dma_buffer(filp)->size;
> > +		__entry->count = file_count(filp);
> > +		__assign_str(exp_name, dma_buffer(filp)->exp_name);
> > +		__assign_str(name, dma_buffer(filp)->name ? dma_buffer(filp)->name : UNKNOWN);
> > +		__entry->i_ino = filp->f_inode->i_ino;
> > +	),
> > +
