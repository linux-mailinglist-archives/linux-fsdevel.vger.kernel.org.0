Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED8B1C2E6D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 19:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgECRp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 13:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728831AbgECRp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 13:45:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C7BC061A0E;
        Sun,  3 May 2020 10:45:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so6180363wmh.0;
        Sun, 03 May 2020 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:references:user-agent:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=36HKN1eX4QBns91xZLt6xASIlJevon5QYZl/z69RQPY=;
        b=IFKYlZaAl5gUxMO/QtqSSywZxS6lD+AgVXy+xzlRLxHdeBgA/txUK9BYpJ4JoU9mun
         jkGNZcLO0CVI/rrTABIFD2J+8b014tDPpqLSpCquxxUKgN7JaAXKIxMwRdu+TbEyRk01
         vNpjeTMJNixvmec06tMF8Hb/NHTm8YTs9xaOKVOCuc/pEJ00OfX00/T4sPeSkn5M91mZ
         /pdvRCXWikS2lcshwbG6QNkb0pla4Xf56VsA17vAAAusjX0F106HyGS5TWMeW0SLeRUr
         6G2b/5x9kGQQZsaeLpB5l+SRRoweVHTyh7Q9JEUP7QFQPZX+qfYrfrZ+CxysavHVMMWk
         ARmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:user-agent:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=36HKN1eX4QBns91xZLt6xASIlJevon5QYZl/z69RQPY=;
        b=QQ35df3ljUMnbodKeiczoNLEbf1QCuPlicn5zO8kkza7IsQvpoFne0IL8WmdA9u+LI
         GEGer+AsVubigwF7/q9U/m4NH9ZZsp60XhdcyQdGY+fwd4M2fzYmlslhe47uajWsbEjL
         HY5g6dDuGhdC2+476nVNzMFhN0vWZxgLrkex+JmiKgVxK3wxscUfp/Aa+AK7/04by7q3
         PQ5WE+DUHZkpQa70x3ShmISxyvboBaMwQ98WwrRxJG4Q0uMflrGfn+5jcQFjxSCytFOM
         SLUMY0Jf3Gr5sjvL6eWIgr4ksihoxa51CaSwzlMe4h+c2oiTPm1W5M5bm+pw6AgqjVJP
         vAlA==
X-Gm-Message-State: AGi0PubpFbIBr15yQdJrFjNHJy1mUxvtpnq4/iMMOMyk1DCWaEbq642Z
        ZsdB39+fKUEI5GekZvdZNFe/Ai7ILOMXMQ==
X-Google-Smtp-Source: APiQypJ8GHBJCPVtV4oX3y0cF0j3lcOVXn4fsurFj3AiGUzOs2jmMDZFzaLb+ksbyBFQ5ks+ag4q5Q==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr9990234wmb.41.1588527925282;
        Sun, 03 May 2020 10:45:25 -0700 (PDT)
Received: from darkstar ([51.154.17.58])
        by smtp.gmail.com with ESMTPSA id f7sm13946189wrt.10.2020.05.03.10.45.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 May 2020 10:45:24 -0700 (PDT)
From:   Patrick Bellasi <derkling@gmail.com>
X-Google-Original-From: Patrick Bellasi <patrick.bellasi@matbug.com>
References: <20200501114927.15248-1-qais.yousef@arm.com> <20200501114927.15248-2-qais.yousef@arm.com>
User-agent: mu4e 1.4.3; emacs 26.3
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Documentation/sysctl: Document uclamp sysctl knobs
In-reply-to: <20200501114927.15248-2-qais.yousef@arm.com>
Message-ID: <87d07krjyk.derkling@matbug.com>
Date:   Sun, 03 May 2020 19:45:23 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Qais,

On Fri, May 01, 2020 at 13:49:27 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

[...]

> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 0d427fd10941..521c18ce3d92 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -940,6 +940,54 @@ Enables/disables scheduler statistics. Enabling this feature
>  incurs a small amount of overhead in the scheduler but is
>  useful for debugging and performance tuning.
>  
> +sched_util_clamp_min:
> +=====================
> +
> +Max allowed *minimum* utilization.
> +
> +Default value is SCHED_CAPACITY_SCALE (1024), which is the maximum possible
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Mmm... I feel one of the two is an implementation detail which should
probably not be exposed?

The user perhaps needs to know the value (1024) but we don't need to
expose the internal representation.


> +value.
> +
> +It means that any requested uclamp.min value cannot be greater than
> +sched_util_clamp_min, i.e., it is restricted to the range
> +[0:sched_util_clamp_min].
> +
> +sched_util_clamp_max:
> +=====================
> +
> +Max allowed *maximum* utilization.
> +
> +Default value is SCHED_CAPACITY_SCALE (1024), which is the maximum possible
> +value.
> +
> +It means that any requested uclamp.max value cannot be greater than
> +sched_util_clamp_max, i.e., it is restricted to the range
> +[0:sched_util_clamp_max].
> +
> +sched_util_clamp_min_rt_default:
> +================================
> +
> +By default Linux is tuned for performance. Which means that RT tasks always run
> +at the highest frequency and most capable (highest capacity) CPU (in
> +heterogeneous systems).
> +
> +Uclamp achieves this by setting the requested uclamp.min of all RT tasks to
> +SCHED_CAPACITY_SCALE (1024) by default, which effectively boosts the tasks to
> +run at the highest frequency and biases them to run on the biggest CPU.
> +
> +This knob allows admins to change the default behavior when uclamp is being
> +used. In battery powered devices particularly, running at the maximum
> +capacity and frequency will increase energy consumption and shorten the battery
> +life.
> +
> +This knob is only effective for RT tasks which the user hasn't modified their
> +requested uclamp.min value via sched_setattr() syscall.
> +
> +This knob will not escape the constraint imposed by sched_util_clamp_min
> +defined above.

Perhaps it's worth to specify that this value is going to be clamped by
the values above? Otherwise it's a bit ambiguous to know what happen
when it's bigger than schedu_util_clamp_min.

> +Any modification is applied lazily on the next opportunity the scheduler needs
> +to calculate the effective value of uclamp.min of the task.
                    ^^^^^^^^^

This is also an implementation detail, I would remove it.

>  
>  seccomp
>  =======


Best,
Patrick

