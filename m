Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F085D408A60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 13:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbhIMLiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 07:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbhIMLit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:38:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30D2C061574;
        Mon, 13 Sep 2021 04:37:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f65so8512822pfb.10;
        Mon, 13 Sep 2021 04:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=QBkvZtRuthYO+WkN5dTUd+gbBpCcqBYymSu9tcHbcUg=;
        b=JgEmhVoT07+/jpj9Hw8XTtF7PaQg78QzX6zNtz/av0Pye/os/Oop7lo99/y8wP3Jyj
         gWe4Gh6c+AU0BSkAeBGYKfJM+on+F85RSTeMLJj2X0NgjlaNW59Y6QzIQzFBjS3+Gryj
         XOVp82ALeta68ZHn8T6sw93BkiO5yAS7cmSTAfM/GvQPsMDPevpT21BIlMwGRwo5m9OU
         fmbcxhXpeqWw+dgm8DWLuFHo7nDK6tosO9UUOhQYk/kyNKn3+h9emnC1da80pDOPN64k
         7tCICxtg12M5RLo7DuHsNCaBtKzLsW0YToYtjT+t8Ci0tCMtLkQf5xM8S3XbWj8mp7Mg
         wmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=QBkvZtRuthYO+WkN5dTUd+gbBpCcqBYymSu9tcHbcUg=;
        b=SWdzqW4D6lZrwEfWNmSNdi/7oYOPNOcymHRiVFnOzky3pRewNtcH1WAplBeF4D7FUT
         SlcrzwkRXHCbcqQSEfbKhRqzYH1Sr1n4UiVJ9nAxi2fyN9nkW7nY6erbFsmIIZfvEmCj
         d/LIbPToTurSWMHk9UTHRdMfIsYhFxShf729RMm9kAdsS/7N3kjR7fs263LQ6QQE2GMq
         pk4YHQYiLlivo5QczT0XRO3TCzav3XRWqfsm3EcnXoI0ZPchdExiB4sfgmv50YxWlr9c
         4OOeMYdyngExaL8D+yB5tvgfPSuQnB50QP4BFFJYJqe6e02iaa+mWaIMtFTgZaxG2kIc
         qykw==
X-Gm-Message-State: AOAM533I/HJOqj0EKuh2OtKhjNgNFAa1eiWYvgNv/oA4ts2yEoQEa62a
        I9abctGiAEiGhX0fe0Sleco=
X-Google-Smtp-Source: ABdhPJznt26Z8rp9Ii/ANoIlwxfTk4jSzPtD+DI7HGBndU3Hzz3KpSJbKm3N4/ayXkxrYx4b2GGBKg==
X-Received: by 2002:a63:e04a:: with SMTP id n10mr10621845pgj.381.1631533053480;
        Mon, 13 Sep 2021 04:37:33 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e15sm4055388pjl.11.2021.09.13.04.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:37:32 -0700 (PDT)
Message-ID: <613f37fc.1c69fb81.9092.a4f5@mx.google.com>
X-Google-Original-Message-ID: <20210913113731.GA83262@cgel.zte@gmail.com>
Date:   Mon, 13 Sep 2021 11:37:31 +0000
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT8IQioxUARMus9w@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 10:13:54AM +0200, Peter Zijlstra wrote:
> On Sun, Sep 12, 2021 at 04:12:23AM +0000, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > The old version sysctl has some problems. First, it allows set value
> > bigger than 1, which is unnecessary. Second, it didn't follow the
> > rule of capabilities. Thirdly, it didn't use static key. This new
> > version fixes all the problems.
> 
> Does any of that actually matter?

For the first problem, I think the reason why sysctl_schedstats() only
accepts 0 or 1, is suitbale for sysctl_child_runs_first(). Since
task_fork_fair() only need sysctl_sched_child_runs_first to be
zero or non-zero.

For the second problem, I remember there is a rule: try to
administration system through capilities but not depends on
root identity. Just like sysctl_schedstats() or other
sysctl_xx().

For the thirdly problem, sysctl_child_runs_first maynot changes
often, but may accessed often, like static_key delayacct_key
controlled by sysctl_delayacct().

Thanks!
