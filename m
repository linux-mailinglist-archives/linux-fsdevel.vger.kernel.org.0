Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5A440A519
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 06:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhINEGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 00:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhINEGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:06:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14278C061574;
        Mon, 13 Sep 2021 21:05:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso1085149pjh.5;
        Mon, 13 Sep 2021 21:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=PL/GS6q4SqVK2KC0THrnGifAWnULLf6Cd+wl37vjXas=;
        b=Mgtj6O4rvWFg3ueda79BxWJnLy38s8YM67cnMbAyp7u6VBV5steUeagQ/AG5JA7Ps6
         XX+0e4u72RYMO9xkeIbihFLqLxTJtknZu53T8971pRhWp8NDVmWjojwIdXKBbB8Ddxf9
         iMG5PD3Zf8uwyaJQrzmsGDszFaYCzN2HAkCxcDaFOs0fzhEwHWLxy+S69nSlz8aw7cA8
         eCPv5H87Q4YhJNTRi3X1aOOIkGqv2/R+SpcCPT/T4F0fDhR/SaQk4WktiL0F38YFLAZ8
         RW6gY4qbcwcYmzxU2WxBob7AzXjHa362pM0mmpg3NcXMCGPUoMtYKvNvejU14gjGwpk4
         QZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=PL/GS6q4SqVK2KC0THrnGifAWnULLf6Cd+wl37vjXas=;
        b=C0Gupn0hnSlPVgORqJJUVS6CJOVPVD9/XvKxZDe9DIn/uLm8GcXyda7AcbGWWNji4r
         MwlkBZdTIgTJoUcOD1ZFK+AYHbQPFaOrZCPbvzN5MwzBZp+NbJ9tJihBVL/EncAzqQRB
         sr5877qz3fnBaCAnwLUW41jNsoZ2wgl6mbEQO4TBCg3NiV83XBoSeT2x2W4BCD+0o1cC
         ZIJv0jPOCXUR64EoYaAQFmerJJzIz3/4n7DECR8JzC50cGxiSHBkBJTaagdaEsccBYM8
         aCtrd8x0ktwch/HID7iOt+0Z1MQxzjxKFi3bS/W461TQvJ1uF1iikPae7xyvivuI4sQV
         u1pw==
X-Gm-Message-State: AOAM533zMP/XJrFglkd6K6EYZqAdWsiGnt2UdlfiooUEi6GxpxXbQR6n
        /hP30Vb9/3AhdtPj1HZgb30=
X-Google-Smtp-Source: ABdhPJy8TzY+ZgZWQq0bVm31vY6F2o9k06O4GXfnIlSKoTCpLprAk2wc487NKDfTMj8RGODkbXYS4A==
X-Received: by 2002:a17:902:d202:b0:13a:709b:dfb0 with SMTP id t2-20020a170902d20200b0013a709bdfb0mr13411695ply.34.1631592326512;
        Mon, 13 Sep 2021 21:05:26 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b7sm8273692pfl.195.2021.09.13.21.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 21:05:25 -0700 (PDT)
Message-ID: <61401f85.1c69fb81.76628.8a83@mx.google.com>
X-Google-Original-Message-ID: <20210914040524.GA141438@cgel.zte@gmail.com>
Date:   Tue, 14 Sep 2021 04:05:24 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     yzaikin@google.com, liu.hailong6@zte.com.cn, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, mcgrof@kernel.org,
        keescook@chromium.org, pjt@google.com, yang.yang29@zte.com.cn,
        joshdon@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zeal Robot <zealci@zte.com.cm>
Subject: Re: [PATCH] sched: Add a new version sysctl to control child runs
 first
References: <20210912041222.59480-1-yang.yang29@zte.com.cn>
 <YT8IQioxUARMus9w@hirez.programming.kicks-ass.net>
 <613f37fc.1c69fb81.9092.a4f5@mx.google.com>
 <20210913134245.GD4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913134245.GD4323@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

esOn Mon, Sep 13, 2021 at 03:42:45PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 13, 2021 at 11:37:31AM +0000, CGEL wrote:
> > On Mon, Sep 13, 2021 at 10:13:54AM +0200, Peter Zijlstra wrote:
> > > On Sun, Sep 12, 2021 at 04:12:23AM +0000, cgel.zte@gmail.com wrote:
> > > > From: Yang Yang <yang.yang29@zte.com.cn>
> > > > 
> > > > The old version sysctl has some problems. First, it allows set value
> > > > bigger than 1, which is unnecessary. Second, it didn't follow the
> > > > rule of capabilities. Thirdly, it didn't use static key. This new
> > > > version fixes all the problems.
> > > 
> > > Does any of that actually matter?
> > 
> > For the first problem, I think the reason why sysctl_schedstats() only
> > accepts 0 or 1, is suitbale for sysctl_child_runs_first(). Since
> > task_fork_fair() only need sysctl_sched_child_runs_first to be
> > zero or non-zero.
> 
> This could potentially break people that already write a larger value in
> it -- by accident or otherwise.

Thanks for reply!

You mean it's right to set sched_child_runs_first 0 or 1, but consider about
compatibility, just leave it?
Should stable/longterm branches keep compatibility, but linux-next fixes it?

Let's take a look at negative influence about unnecessary values of sysctl.
Some tune tools will automatic to set different values of sysctl to see
performance impact. So invalid values may waste tune tools's time, specially
when the range of values is big.

For example A-Tune, see below:
https://docs.openeuler.org/zh/docs/20.03_LTS/docs/A-Tune/%E8%AE%A4%E8%AF%86A-Tune.html 
Since it's wroten in Chinese, I try to explain it in short.
A-Tune modeling sysctls first(what values sysctls accept), then automatic to iterate
different values to find the best combination of sysctl values for the workload.

> 
> > For the second problem, I remember there is a rule: try to
> > administration system through capilities but not depends on
> > root identity. Just like sysctl_schedstats() or other
> > sysctl_xx().
> 
> It seems entirely daft to me; those files are already 644, if root opens
> the file and passes it along, it gets to keep the pieces.
> 

I think it's indeed a little tricky: root may drop it's own capabilites.
Let's see another example of netdev_store(), root can't modify netdev
attribute without CAP_NET_ADMIN, even it pass the 644 DAC check.

> > For the thirdly problem, sysctl_child_runs_first maynot changes
> > often, but may accessed often, like static_key delayacct_key
> > controlled by sysctl_delayacct().
> 
> Can you actually show it makes a performance difference in a fork
> micro-bench? Given the amount of gunk fork() already does, I don't think
> it'll matter one way or the other, and in that case, simpler is better.

With 5.14-rc6 and gcc6.2.0, this patch will reduce test instruct in
task_fork_fair() as Documentation/staging/static-keys.rst said.
Since task_fork_fair() may called often, I think it's OK to use static
key, actually there are quit a lot static keys in kernel/xx.

When talk about simply, maybe keep in consistent with other sysctls like
task_delayacct() is also a kind of simply in code style.

Before this patch:
ffff810a5c60 <task_fork_fair>:
..
ffffffff810a5cf3: e8 a8 b3 ff ff       callq ffffffff810a10a0 <place_entity>
ffffffff810a5cf8: 8b 05 e2 b5 5d 01    mov 0x15db5e2(%rip),%eax # ffffffff826812e0 <sysctl_sched_child_runs_first>
ffffffff810a5cfe: 85 c0                test %eax,%eax
ffffffff810a5d00: 74 5b                je ffffffff810a5d5d <task_fork_fair+0xfd>
ffffffff810a5d02: 49 8b 55 50          mov 0x50(%r13),%rdx
ffffffff810a5d06: 49 8b 84 24 10 01 00 mov 0x110(%r12),%rax
ffffffff810a5d0d: 00 
ffffffff810a5d0e: 48 39 c2             cmp %rax,%rdx
ffffffff810a5d11: 78 36                js ffffffff810a5d49 <task_fork_fair+0xe9>
ffffffff810a5d13: 48 2b 45 28          sub    0x28(%rbp),%rax

After this patch:
ffffffff810a5c60 <task_fork_fair>:
..
ffffffff810a5cf3: e8 a8 b3 ff ff       callq  ffffffff810a10a0 <place_entity>
ffffffff810a5cf8: 66 90                xchg   %ax,%ax
ffffffff810a5cfa: 49 8b 84 24 10 01 00 mov    0x110(%r12),%rax
ffffffff810a5d01: 00
ffffffff810a5d02: 48 2b 45 28          sub    0x28(%rbp),%rax

Thanks!
