Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE384214064
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 22:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGCUa0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 16:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCUa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:30:26 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27DEC061794;
        Fri,  3 Jul 2020 13:30:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so15551057pgk.4;
        Fri, 03 Jul 2020 13:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O+Fe+jCmJ3Q4m2sr6/EFiUxSNkmMVEuKNulCBTI6aX8=;
        b=bqH1lAIDU7lP2lH/S/ULCtIL+9zvkmLW1g/oWZxsUZm7e+y1Cict1kkkPQNwlZIOJb
         T8A/cJ14zFBsro+r81v5oreU34IYlBzlL607/H0B72w2nkjUXHCnq6DZrLohZOyVkeux
         GpEB21FFx5yv4O6EQjvPxUE/JFpa072s8ivNowK8qoNk7zZSDJkb2HgmS1tDBdziHvpW
         Z9vxHtbExfEWbK/NyquDShBdckCShd/qLzNoi7LwLMIAYUSHnv9w8hBPt3apmx1f1ZaU
         pH7OxMhQNM9hPOr1pA46grRemTFrtSsHc3ly+4jR+zcu8t4HQYvR+eZdMcAfiENQjsGw
         IoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O+Fe+jCmJ3Q4m2sr6/EFiUxSNkmMVEuKNulCBTI6aX8=;
        b=LAtpo5uUr9+jWN0a1UOOQkgvdXg0malpkSoMp4KunDuQjEV4hGF3VvGA/ZGu7O/QjV
         QnDlznjozf4inIsQIik1KK9vjyVY8MkYLc87NHyFG4hairDRSQwZMUf8eoZQp/nwzot3
         tCge2+Xp0T/uatLdTA8i3+90FsKBRxXO6FK2RJEBKlZse0sRIK3b9av9GYFGp+lwKTvW
         ebKaxKvvLt8stNUqOdq65k/+XUP3OuA0fsSSdAkZ4zlXQLs3w2rWC7DWL2VCJ6GMi/vF
         CTXGt41Jtq4RxncE5XV72au4r1Eqojt+taPo5eqblUdQT7goydlEbIuXjUENfTnB1t2G
         ecuQ==
X-Gm-Message-State: AOAM533K5DmUw1cWEbJp4oaz5ASdQGX/HlxYazoGi7TdJTvQ7jM8Apc9
        8QTju4L1FWQCOEVOULzOsi1voXhQ
X-Google-Smtp-Source: ABdhPJweQ3ohfl5U0k+uZFYAvDvySzSgjNlobf3cIwdKvQknDnJJKGsoHc1g/gBH8R2H8NHrw+GwAw==
X-Received: by 2002:a65:4b85:: with SMTP id t5mr28075476pgq.36.1593808225366;
        Fri, 03 Jul 2020 13:30:25 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:d8c2])
        by smtp.gmail.com with ESMTPSA id o1sm11351745pjp.37.2020.07.03.13.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 13:30:24 -0700 (PDT)
Date:   Fri, 3 Jul 2020 13:30:21 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 13/16] exit: Factor thread_group_exited out of
 pidfd_poll
Message-ID: <20200703203021.paebx25miovmaxqt@ast-mbp.dhcp.thefacebook.com>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
 <20200702164140.4468-13-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702164140.4468-13-ebiederm@xmission.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 11:41:37AM -0500, Eric W. Biederman wrote:
> Create an independent helper thread_group_exited report return true
> when all threads have passed exit_notify in do_exit.  AKA all of the
> threads are at least zombies and might be dead or completely gone.
> 
> Create this helper by taking the logic out of pidfd_poll where
> it is already tested, and adding a missing READ_ONCE on
> the read of task->exit_state.
> 
> I will be changing the user mode driver code to use this same logic
> to know when a user mode driver needs to be restarted.
> 
> Place the new helper thread_group_exited in kernel/exit.c and
> EXPORT it so it can be used by modules.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/sched/signal.h |  2 ++
>  kernel/exit.c                | 24 ++++++++++++++++++++++++
>  kernel/fork.c                |  6 +-----
>  3 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 0ee5e696c5d8..1bad18a1d8ba 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -674,6 +674,8 @@ static inline int thread_group_empty(struct task_struct *p)
>  #define delay_group_leader(p) \
>  		(thread_group_leader(p) && !thread_group_empty(p))
>  
> +extern bool thread_group_exited(struct pid *pid);
> +
>  extern struct sighand_struct *__lock_task_sighand(struct task_struct *task,
>  							unsigned long *flags);
>  
> diff --git a/kernel/exit.c b/kernel/exit.c
> index d3294b611df1..a7f112feb0f6 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1713,6 +1713,30 @@ COMPAT_SYSCALL_DEFINE5(waitid,
>  }
>  #endif
>  
> +/**
> + * thread_group_exited - check that a thread group has exited
> + * @pid: tgid of thread group to be checked.
> + *
> + * Test if thread group is has exited (all threads are zombies, dead
> + * or completely gone).
> + *
> + * Return: true if the thread group has exited. false otherwise.
> + */
> +bool thread_group_exited(struct pid *pid)
> +{
> +	struct task_struct *task;
> +	bool exited;
> +
> +	rcu_read_lock();
> +	task = pid_task(pid, PIDTYPE_PID);
> +	exited = !task ||
> +		(READ_ONCE(task->exit_state) && thread_group_empty(task));
> +	rcu_read_unlock();
> +
> +	return exited;
> +}

I'm not sure why you think READ_ONCE was missing.
It's different in wait_consider_task() where READ_ONCE is needed because
of multiple checks. Here it's done once.

The rest all looks good to me. Tested with and without bpf_preload patches.
Feel free to create a frozen branch with this set.

btw I'll be offline starting tomorrow for a week.
Will catch up with threads afterwards.
