Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1666B1CDA9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 15:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgEKNAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 09:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727827AbgEKNAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 09:00:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF917C061A0C;
        Mon, 11 May 2020 06:00:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so17948170wmb.4;
        Mon, 11 May 2020 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:references:user-agent:to:cc:subject:in-reply-to
         :message-id:date:mime-version;
        bh=GT1dtgToCuf3JZQXWgmn/1+1Vz720HE+8i0ZCjTlo7w=;
        b=KMIYu0AtbfomOEZKHqvTVcN79xGzhnfhHfc7vhfsX/lwOqA1f19NINZIIxSAUC6QLQ
         5VsPpzc0E+023+kEaNkndCHKiXjMuzEWlkp6VsqvTWnMhnzY1MTQCODGdxGf9/zTdUsr
         HbkSTNLDGabEucMdKXdALoz7wQVWpsotJTehLTQRh+jYB06ncAumAb2Am9CGttiGR5Sh
         aiiikjtkdt/06zyvSctEimqsm8VJNYrnfWXwVvrHb92UNz9uA/ux8QfhDPgCZEihPtvH
         NwvSlbe6MGUoGWWvSseNcxCfF8QM7aOQuwsYrw4PWWDp/xctTdAJICB2yEgDBdKfIRaC
         Hzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:references:user-agent:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=GT1dtgToCuf3JZQXWgmn/1+1Vz720HE+8i0ZCjTlo7w=;
        b=pMOUrg3QGClVIPQhdVKAscw+O4OgkDvjRLqwl2KlCLqzSiRRlzq6alKJcbUIslsvx3
         gy32gojR8U09GXuxZhXzqim64bqLRu7/GS+2bedt8I4/baGFmp8hcsCGqBVk2bW6A7ST
         BPXqJBvEXNDe3aqey35gZwI7vqFa2iXyiJE9JZiHvc8B8alzQMjHzEkv5JoVAgH8t1MV
         PBByTqROVg7UIj3Yqa2sX+VCjTKSJr1gMdJz7q2EyHYZmoId+Z5Zuz9QYu/IW3yIBBGm
         lfQQln21GdyPPd3q1CUGcxqYkczzE95B051r3BTxM+zYrIb25BU/P0ZJDGASUQe1v0Yg
         jD/w==
X-Gm-Message-State: AGi0Pua0omwPWO/goomQM2967UocxWA+LO1PxlGTUVE+QoPlH7913PNp
        0sC/NrX1Fg/JTQKpuzB7GkFLXQvd1Is=
X-Google-Smtp-Source: APiQypIdEhVCj3AfwnDtXHxVYKduAfM7hgi55kuPoCwoSEKk/rppyVs+ayP4HIB75wIQ3XU0hprR4g==
X-Received: by 2002:a1c:e305:: with SMTP id a5mr14612754wmh.1.1589202009946;
        Mon, 11 May 2020 06:00:09 -0700 (PDT)
Received: from darkstar ([51.154.17.58])
        by smtp.gmail.com with ESMTPSA id 5sm26454868wmz.16.2020.05.11.06.00.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 06:00:08 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
X-Google-Original-From: Patrick Bellasi <patrick.bellasi@matbug.com>
References: <20200501114927.15248-1-qais.yousef@arm.com> <20200501114927.15248-2-qais.yousef@arm.com> <87d07krjyk.derkling@matbug.com> <20200505145637.5daqhatsm5bjsok7@e107158-lin.cambridge.arm.com>
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
In-reply-to: <20200505145637.5daqhatsm5bjsok7@e107158-lin.cambridge.arm.com>
Message-ID: <877dxik4ob.derkling@matbug.com>
Date:   Mon, 11 May 2020 15:00:04 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Qais,

On Tue, May 05, 2020 at 16:56:37 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

>> > +sched_util_clamp_min_rt_default:
>> > +================================
>> > +
>> > +By default Linux is tuned for performance. Which means that RT tasks always run
>> > +at the highest frequency and most capable (highest capacity) CPU (in
>> > +heterogeneous systems).
>> > +
>> > +Uclamp achieves this by setting the requested uclamp.min of all RT tasks to
>> > +SCHED_CAPACITY_SCALE (1024) by default, which effectively boosts the tasks to
>> > +run at the highest frequency and biases them to run on the biggest CPU.
>> > +
>> > +This knob allows admins to change the default behavior when uclamp is being
>> > +used. In battery powered devices particularly, running at the maximum
>> > +capacity and frequency will increase energy consumption and shorten the battery
>> > +life.
>> > +
>> > +This knob is only effective for RT tasks which the user hasn't modified their
>> > +requested uclamp.min value via sched_setattr() syscall.
>> > +
>> > +This knob will not escape the constraint imposed by sched_util_clamp_min
>> > +defined above.
>> 
>> Perhaps it's worth to specify that this value is going to be clamped by
>> the values above? Otherwise it's a bit ambiguous to know what happen
>> when it's bigger than schedu_util_clamp_min.
>
> Hmm for me that sentence says exactly what you're asking for.
>
> So what you want is
>
> 	s/will not escape the constraint imposed by/will be clamped by/
>
> ?
>
> I'm not sure if this will help if the above is already ambiguous. Maybe if
> I explicitly say
>
> 	..will not escape the *range* constrained imposed by..
>
> sched_util_clamp_min is already defined as a range constraint, so hopefully it
> should hit the mark better now?

Right, that also can work.

>> 
>> > +Any modification is applied lazily on the next opportunity the scheduler needs
>> > +to calculate the effective value of uclamp.min of the task.
>>                     ^^^^^^^^^
>> 
>> This is also an implementation detail, I would remove it.
>
> The idea is that this value is not updated 'immediately'/synchronously. So
> currently RUNNING tasks will not see the effect, which could generate confusion
> when users trip over it. IMO giving an idea of how it's updated will help with
> expectation of the users. I doubt any will care, but I think it's an important
> behavior element that is worth conveying and documenting. I'd be happy to
> reword it if necessary.

Right, I agree on giving an hint on the lazy update. What I was pointing
out was mainly the reference to the 'effective' value. Maybe we can just
drop that word.

> I have this now
>
> """
>  984 This knob will not escape the range constraint imposed by sched_util_clamp_min
>  985 defined above.
>  986
>  987 For example if
>  988
>  989         sched_util_clamp_min_rt_default = 800
>  990         sched_util_clamp_min = 600
>  991
>  992 Then the boost will be clamped to 600 because 800 is outside of the permissible
>  993 range of [0:600]. This could happen for instance if a powersave mode will
>  994 restrict all boosts temporarily by modifying sched_util_clamp_min. As soon as
>  995 this restriction is lifted, the requested sched_util_clamp_min_rt_default
>  996 will take effect.
>  997
>  998 Any modification is applied lazily to currently running tasks and should be
>  999 visible by the next wakeup.
> """

That's better IMHO, would just slightly change the last sentence to:

       Any modification is applied lazily to tasks and is effective
       starting from their next wakeup.

Best,
Patrick

