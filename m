Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0125E7111E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 19:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240928AbjEYRUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 13:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbjEYRUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 13:20:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECB818D
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:19:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f53c06babso162549666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685035197; x=1687627197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wavdum6yYAqpFeopZHwVVFgnm4JMHiQDU/53zz3FxBY=;
        b=goawVQC5jsSd/ZTijZq1yB03zafWo77t7+Zao+UGglnPeOunriCGqUVh062x+pz1AY
         Tm6HF3/F6232FkJS/srHiOjoWJ2WkCfRbkSzQmEN5ODbd7yGZCOQ5sLH4DYv5CrGa+s5
         e0VL41YYNBfodf21AAsHSNGeEZXBPWbV6TSR/vppHSrWwPAjso3m69mzGaS7WCIsY2qk
         YHv4D1XAI2Hh7zUAqDDxfH/EH3R8VK0LKb7a4VOuaSMqwY/BqZ7j6t6IO9IYPhg0aIRw
         /Ls6gN2GUX2SboOkFRqwC832l5xeBUyf3o+FzvunNuWi6pJRcGXO7ckZjC16TypYGtTQ
         yPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035197; x=1687627197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wavdum6yYAqpFeopZHwVVFgnm4JMHiQDU/53zz3FxBY=;
        b=dVZ4zyDE8WarokLJO6VF72DkdGpDqgjv1scUwgcg0Aw7r13TLOJo6Lw8pWJ1HzYQ/u
         s8nl8aaAcfFggkBMFhQDcRWBwHvHxG9gT0LDSU4hYK/KbXKN0FAY2F5VD82RnFoOzI5H
         u9PFoETTdAc9bfSjT4BLRGwtKEpl6QX2YZsZA9TV7F5fP+Bf8GZe6IlEjjrES/e3K4Mt
         xfNVYNGF/ye6Gf8OyJtvmcwbshG9iCcpZMLCBVShhQMtqc2mlGIdlKBkkYK5QCCB5O+V
         iQkXYT2fP6Q4AsuOPOuQvkGyIRgszBP+QsYcSUjLokUznvwwIEISrqYsTJRehADiMIed
         rclw==
X-Gm-Message-State: AC+VfDzf+6gT6B+dEpY3jdQgha/bj9U5VuS3NcGxxgXhY3kPEpiCJhvN
        ATVwZgn2dHwsCSBQlCYe8wH8L1JWfRnKxVUZxDxczg==
X-Google-Smtp-Source: ACHHUZ6Ui5kgEQBgjsGW/abGwW/6LSNUNvdC9IkyTBIGvkXtbAtZVyDWbuuhLnEuEJEVY52cPEeQOivGWEI+sXKKbBw=
X-Received: by 2002:a17:907:2da8:b0:96f:d154:54f7 with SMTP id
 gt40-20020a1709072da800b0096fd15454f7mr2878524ejc.42.1685035197205; Thu, 25
 May 2023 10:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZwCreOS_XxDM_9mOTBo=Gatr12r1xtc64B_e5+HJhRqg@mail.gmail.com>
 <B438A058-7C4A-46B3-B6FB-4CF32BD7D294@didiglobal.com>
In-Reply-To: <B438A058-7C4A-46B3-B6FB-4CF32BD7D294@didiglobal.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 25 May 2023 10:19:20 -0700
Message-ID: <CAJD7tkaQdSTDX0Q7zvvYrA3Y4TcvLdWKnN3yc8VpfWRpUjcYBw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] memcontrol: support cgroup level OOM protection
To:     =?UTF-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        "pilgrimtao@gmail.com" <pilgrimtao@gmail.com>,
        "haolee.swjtu@gmail.com" <haolee.swjtu@gmail.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vasily.averin@linux.dev" <vasily.averin@linux.dev>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "surenb@google.com" <surenb@google.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 1:19=E2=80=AFAM =E7=A8=8B=E5=9E=B2=E6=B6=9B Chengka=
itao Cheng
<chengkaitao@didiglobal.com> wrote:
>
> At 2023-05-24 06:02:55, "Yosry Ahmed" <yosryahmed@google.com> wrote:
> >On Sat, May 20, 2023 at 2:52=E2=80=AFAM =E7=A8=8B=E5=9E=B2=E6=B6=9B Chen=
gkaitao Cheng
> ><chengkaitao@didiglobal.com> wrote:
> >>
> >> At 2023-05-20 06:04:26, "Yosry Ahmed" <yosryahmed@google.com> wrote:
> >> >On Wed, May 17, 2023 at 10:12=E2=80=AFPM =E7=A8=8B=E5=9E=B2=E6=B6=9B =
Chengkaitao Cheng
> >> ><chengkaitao@didiglobal.com> wrote:
> >> >>
> >> >> At 2023-05-18 04:42:12, "Yosry Ahmed" <yosryahmed@google.com> wrote=
:
> >> >> >On Wed, May 17, 2023 at 3:01=E2=80=AFAM =E7=A8=8B=E5=9E=B2=E6=B6=
=9B Chengkaitao Cheng
> >> >> ><chengkaitao@didiglobal.com> wrote:
> >> >> >>
> >> >> >> At 2023-05-17 16:09:50, "Yosry Ahmed" <yosryahmed@google.com> wr=
ote:
> >> >> >> >On Wed, May 17, 2023 at 1:01=E2=80=AFAM =E7=A8=8B=E5=9E=B2=E6=
=B6=9B Chengkaitao Cheng
> >> >> >> ><chengkaitao@didiglobal.com> wrote:
> >> >> >> >>
> >> >> >>
> >> >> >> Killing processes in order of memory usage cannot effectively pr=
otect
> >> >> >> important processes. Killing processes in a user-defined priorit=
y order
> >> >> >> will result in a large number of OOM events and still not being =
able to
> >> >> >> release enough memory. I have been searching for a balance betwe=
en
> >> >> >> the two methods, so that their shortcomings are not too obvious.
> >> >> >> The biggest advantage of memcg is its tree topology, and I also =
hope
> >> >> >> to make good use of it.
> >> >> >
> >> >> >For us, killing processes in a user-defined priority order works w=
ell.
> >> >> >
> >> >> >It seems like to tune memory.oom.protect you use oom_kill_inherit =
to
> >> >> >observe how many times this memcg has been killed due to a limit i=
n an
> >> >> >ancestor. Wouldn't it be more straightforward to specify the prior=
ity
> >> >> >of protections among memcgs?
> >> >> >
> >> >> >For example, if you observe multiple memcgs being OOM killed due t=
o
> >> >> >hitting an ancestor limit, you will need to decide which of them t=
o
> >> >> >increase memory.oom.protect for more, based on their importance.
> >> >> >Otherwise, if you increase all of them, then there is no point if =
all
> >> >> >the memory is protected, right?
> >> >>
> >> >> If all memory in memcg is protected, its meaning is similar to that=
 of the
> >> >> highest priority memcg in your approach, which is ultimately killed=
 or
> >> >> never killed.
> >> >
> >> >Makes sense. I believe it gets a bit trickier when you want to
> >> >describe relative ordering between memcgs using memory.oom.protect.
> >>
> >> Actually, my original intention was not to use memory.oom.protect to
> >> achieve relative ordering between memcgs, it was just a feature that
> >> happened to be achievable. My initial idea was to protect a certain
> >> proportion of memory in memcg from being killed, and through the
> >> method, physical memory can be reasonably planned. Both the physical
> >> machine manager and container manager can add some unimportant
> >> loads beyond the oom.protect limit, greatly improving the oversold
> >> rate of memory. In the worst case scenario, the physical machine can
> >> always provide all the memory limited by memory.oom.protect for memcg.
> >>
> >> On the other hand, I also want to achieve relative ordering of interna=
l
> >> processes in memcg, not just a unified ordering of all memcgs on
> >> physical machines.
> >
> >For us, having a strict priority ordering-based selection is
> >essential. We have different tiers of jobs of different importance,
> >and a job of higher priority should not be killed before a lower
> >priority task if possible, no matter how much memory either of them is
> >using. Protecting memcgs solely based on their usage can be useful in
> >some scenarios, but not in a system where you have different tiers of
> >jobs running with strict priority ordering.
>
> If you want to run with strict priority ordering, it can also be achieved=
,
> but it may be quite troublesome. The directory structure shown below
> can achieve the goal.
>
>              root
>            /      \
>    cgroup A       cgroup B
> (protect=3Dmax)    (protect=3D0)
>                 /          \
>            cgroup C      cgroup D
>         (protect=3Dmax)   (protect=3D0)
>                        /          \
>                   cgroup E      cgroup F
>                (protect=3Dmax)   (protect=3D0)
>
> Oom kill order: F > E > C > A

This requires restructuring the cgroup hierarchy which comes with a
lot of other factors, I don't think that's practically an option.

>
> As mentioned earlier, "running with strict priority ordering" may be
> some extreme issues, that requires the manager to make a choice.

We have been using strict priority ordering in our fleet for many
years now and we depend on it. Some jobs are simply more important
than others, regardless of their usage.

>
> >>
> >> >> >In this case, wouldn't it be easier to just tell the OOM killer th=
e
> >> >> >relative priority among the memcgs?
> >> >> >
> >> >> >>
> >> >> >> >If this approach works for you (or any other audience), that's =
great,
> >> >> >> >I can share more details and perhaps we can reach something tha=
t we
> >> >> >> >can both use :)
> >> >> >>
> >> >> >> If you have a good idea, please share more details or show some =
code.
> >> >> >> I would greatly appreciate it
> >> >> >
> >> >> >The code we have needs to be rebased onto a different version and
> >> >> >cleaned up before it can be shared, but essentially it is as
> >> >> >described.
> >> >> >
> >> >> >(a) All processes and memcgs start with a default score.
> >> >> >(b) Userspace can specify scores for memcgs and processes. A highe=
r
> >> >> >score means higher priority (aka less score gets killed first).
> >> >> >(c) The OOM killer essentially looks for the memcg with the lowest
> >> >> >scores to kill, then among this memcg, it looks for the process wi=
th
> >> >> >the lowest score. Ties are broken based on usage, so essentially i=
f
> >> >> >all processes/memcgs have the default score, we fallback to the
> >> >> >current OOM behavior.
> >> >>
> >> >> If memory oversold is severe, all processes of the lowest priority
> >> >> memcg may be killed before selecting other memcg processes.
> >> >> If there are 1000 processes with almost zero memory usage in
> >> >> the lowest priority memcg, 1000 invalid kill events may occur.
> >> >> To avoid this situation, even for the lowest priority memcg,
> >> >> I will leave him a very small oom.protect quota.
> >> >
> >> >I checked internally, and this is indeed something that we see from
> >> >time to time. We try to avoid that with userspace OOM killing, but
> >> >it's not 100% effective.
> >> >
> >> >>
> >> >> If faced with two memcgs with the same total memory usage and
> >> >> priority, memcg A has more processes but less memory usage per
> >> >> single process, and memcg B has fewer processes but more
> >> >> memory usage per single process, then when OOM occurs, the
> >> >> processes in memcg B may continue to be killed until all processes
> >> >> in memcg B are killed, which is unfair to memcg B because memcg A
> >> >> also occupies a large amount of memory.
> >> >
> >> >I believe in this case we will kill one process in memcg B, then the
> >> >usage of memcg A will become higher, so we will pick a process from
> >> >memcg A next.
> >>
> >> If there is only one process in memcg A and its memory usage is higher
> >> than any other process in memcg B, but the total memory usage of
> >> memcg A is lower than that of memcg B. In this case, if the OOM-killer
> >> still chooses the process in memcg A. it may be unfair to memcg A.
> >>
> >> >> Dose your approach have these issues? Killing processes in a
> >> >> user-defined priority is indeed easier and can work well in most ca=
ses,
> >> >> but I have been trying to solve the cases that it cannot cover.
> >> >
> >> >The first issue is relatable with our approach. Let me dig more info
> >> >from our internal teams and get back to you with more details.
>
> --
> Thanks for your comment!
> chengkaitao
>
>
