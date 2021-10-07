Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742F0424C35
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 05:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhJGD2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 23:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhJGD2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 23:28:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442D3C061746;
        Wed,  6 Oct 2021 20:26:40 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id g184so4326495pgc.6;
        Wed, 06 Oct 2021 20:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=0B2TGRHKRDQCqRLmntyasrU6KkUmi/971ba9rDHssCw=;
        b=LmF9Vp4gCJz93Api59At3t9L5bA+Vg0yfLQoIFgoc5cyz5sTEX0lJd/uCnlPsJhzcZ
         gWxIJbGoNk15xnp5NTjkjhzuofy0kgRDtjNb76zJ15i0WKUrbGmDyHLWIPZr4ddVyE1z
         cccWVs+IWeHbkulbIC38qu9zD8aJuMOXZ+FZNfnLZGv3MumCGdWSzHeL72rITFezoBfx
         yV8FVSJTXHDgBk4iUIeEyjcLSKK2kP42XeA38TcRWYmTPOIfrKWUpt/u8j+mEys1OyoA
         dmmc1bSS/wm9sZztHdNmQIk+cp+gyz+FjvBAPyk4K91KYuiJwG97PDFJf+5rcdYQlBOw
         2ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=0B2TGRHKRDQCqRLmntyasrU6KkUmi/971ba9rDHssCw=;
        b=fRFwRuhy1JHKDKejUUWHEVT1E8SbUeHXhu7ESXFzW13jtk3cgCS/6VT/mieSfYFBfl
         ErM7AqAmTCOzrVkBDb3afxfqyDePSb2akWm909w8xg9S/pRhyVIrw4/3W2LFxklYZyxt
         PewZwyVqHrv7uk0uGYF/hEZgUktjsPt17D5NYGFn8UF/h43ErNCu2NZH9J/UqEEJyfjF
         SlMzCVjqb9cum5a18W6YOHYbCtreiaCSrClI4i6S8UpDs7w3xFQjg0L8TAB1oJ1FeIb5
         gzKNbs7dXausYAjgvFjaaWtYNnO6bzRq0k4lof1TdgSC3Vl9ryX5oRVt/9lV0gBhpE2t
         aanA==
X-Gm-Message-State: AOAM531LlWiJAwEASiAy9ZA5fFG/6+oAgqGaqV9OAmdmePZsAJ/f8F1z
        wJIrZwzpiUNeGXazWQsUVmk=
X-Google-Smtp-Source: ABdhPJyWY5WlhobpipyoBWdtIfLDYfdJTM0SwaK3Sd7F762J8ujZWFOdXd9uRM4zUMFknYZuQ6OBHA==
X-Received: by 2002:a63:ea44:: with SMTP id l4mr1455822pgk.210.1633577199729;
        Wed, 06 Oct 2021 20:26:39 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k3sm6429520pjg.43.2021.10.06.20.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 20:26:39 -0700 (PDT)
Message-ID: <615e68ef.1c69fb81.bf82e.41af@mx.google.com>
X-Google-Original-Message-ID: <20211007032637.GA460559@cgel.zte@gmail.com>
Date:   Thu, 7 Oct 2021 03:26:37 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     yzaikin@google.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, mcgrof@kernel.org, keescook@chromium.org,
        pjt@google.com, yang.yang29@zte.com.cn, joshdon@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
Subject: Re: [PATCH] sched: Add a new version sysctl to control child runs
 first
References: <20210912041222.59480-1-yang.yang29@zte.com.cn>
 <YT8IQioxUARMus9w@hirez.programming.kicks-ass.net>
 <613f37fc.1c69fb81.9092.a4f5@mx.google.com>
 <20210913134245.GD4323@worktop.programming.kicks-ass.net>
 <20210914040524.GA141438@cgel.zte@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914040524.GA141438@cgel.zte@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:05:26AM +0000, CGEL wrote:
> esOn Mon, Sep 13, 2021 at 03:42:45PM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 13, 2021 at 11:37:31AM +0000, CGEL wrote:
> > > On Mon, Sep 13, 2021 at 10:13:54AM +0200, Peter Zijlstra wrote:
> > > > On Sun, Sep 12, 2021 at 04:12:23AM +0000, cgel.zte@gmail.com wrote:
> > > > > From: Yang Yang <yang.yang29@zte.com.cn>
> > > > > 
> > > > > The old version sysctl has some problems. First, it allows set value
> > > > > bigger than 1, which is unnecessary. Second, it didn't follow the
> > > > > rule of capabilities. Thirdly, it didn't use static key. This new
> > > > > version fixes all the problems.
> > > > 
> > > > Does any of that actually matter?
> > > 
> > > For the first problem, I think the reason why sysctl_schedstats() only
> > > accepts 0 or 1, is suitbale for sysctl_child_runs_first(). Since
> > > task_fork_fair() only need sysctl_sched_child_runs_first to be
> > > zero or non-zero.
> > 
> > This could potentially break people that already write a larger value in
> > it -- by accident or otherwise.
> 
> Thanks for reply!
> 
> You mean it's right to set sched_child_runs_first 0 or 1, but consider about
> compatibility, just leave it?
> Should stable/longterm branches keep compatibility, but linux-next fixes it?
> 
> Let's take a look at negative influence about unnecessary values of sysctl.
> Some tune tools will automatic to set different values of sysctl to see
> performance impact. So invalid values may waste tune tools's time, specially
> when the range of values is big.
> 
> For example A-Tune, see below:
> https://docs.openeuler.org/zh/docs/20.03_LTS/docs/A-Tune/%E8%AE%A4%E8%AF%86A-Tune.html 
> Since it's wroten in Chinese, I try to explain it in short.
> A-Tune modeling sysctls first(what values sysctls accept), then automatic to iterate
> different values to find the best combination of sysctl values for the workload.
>
Hi 
Should modify this path or just abandon it?

> > 
> > > For the second problem, I remember there is a rule: try to
> > > administration system through capilities but not depends on
> > > root identity. Just like sysctl_schedstats() or other
> > > sysctl_xx().
> > 
> > It seems entirely daft to me; those files are already 644, if root opens
> > the file and passes it along, it gets to keep the pieces.
> > 
> 
> I think it's indeed a little tricky: root may drop it's own capabilites.
> Let's see another example of netdev_store(), root can't modify netdev
> attribute without CAP_NET_ADMIN, even it pass the 644 DAC check.
> 
> > > For the thirdly problem, sysctl_child_runs_first maynot changes
> > > often, but may accessed often, like static_key delayacct_key
> > > controlled by sysctl_delayacct().
> > 
> > Can you actually show it makes a performance difference in a fork
> > micro-bench? Given the amount of gunk fork() already does, I don't think
> > it'll matter one way or the other, and in that case, simpler is better.
> 
> With 5.14-rc6 and gcc6.2.0, this patch will reduce test instruct in
> task_fork_fair() as Documentation/staging/static-keys.rst said.
> Since task_fork_fair() may called often, I think it's OK to use static
> key, actually there are quit a lot static keys in kernel/xx.
> 
> When talk about simply, maybe keep in consistent with other sysctls like
> task_delayacct() is also a kind of simply in code style.
> 
> Before this patch:
> ffff810a5c60 <task_fork_fair>:
> ..
> ffffffff810a5cf3: e8 a8 b3 ff ff       callq ffffffff810a10a0 <place_entity>
> ffffffff810a5cf8: 8b 05 e2 b5 5d 01    mov 0x15db5e2(%rip),%eax # ffffffff826812e0 <sysctl_sched_child_runs_first>
> ffffffff810a5cfe: 85 c0                test %eax,%eax
> ffffffff810a5d00: 74 5b                je ffffffff810a5d5d <task_fork_fair+0xfd>
> ffffffff810a5d02: 49 8b 55 50          mov 0x50(%r13),%rdx
> ffffffff810a5d06: 49 8b 84 24 10 01 00 mov 0x110(%r12),%rax
> ffffffff810a5d0d: 00 
> ffffffff810a5d0e: 48 39 c2             cmp %rax,%rdx
> ffffffff810a5d11: 78 36                js ffffffff810a5d49 <task_fork_fair+0xe9>
> ffffffff810a5d13: 48 2b 45 28          sub    0x28(%rbp),%rax
> 
> After this patch:
> ffffffff810a5c60 <task_fork_fair>:
> ..
> ffffffff810a5cf3: e8 a8 b3 ff ff       callq  ffffffff810a10a0 <place_entity>
> ffffffff810a5cf8: 66 90                xchg   %ax,%ax
> ffffffff810a5cfa: 49 8b 84 24 10 01 00 mov    0x110(%r12),%rax
> ffffffff810a5d01: 00
> ffffffff810a5d02: 48 2b 45 28          sub    0x28(%rbp),%rax
> 
> Thanks!
