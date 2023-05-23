Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094E270E899
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 00:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbjEWWEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 18:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjEWWEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 18:04:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592E1B1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 15:03:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f53c06babso22722366b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684879412; x=1687471412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3/mPMNJ7/h7rqHqGun24hHWu5NE/mF12cbPJ8Cl0jU=;
        b=aYxN790+J554PL0/3OW2aefHRP/LSi7dZW7T3QLjGyI+bv2qU5rZXasC8nFYcaWe/L
         f4tj7bCOgnpk7pykJqTG7i0bvAT3Cwvxwj9ptsiN8D9EF85TPt34UlwDIZq9c5B5WBID
         zHHRH7mkSLFlokOVMW/o+eQMmw0wJ1qPFzziAw5IPd3ps19BxBzmdreH87NRIWktCC5j
         ch/f5Z07n0h36ceShdVSLYfr9dRshXuNWnV+ObT4M5ha3OqQBOFPTpr8JwAlDS6KVafo
         Tzq8nlvl0ck3HYb1AF64mhDlW8dj8rAGBVTikzzLKDzmWRN1IsfUqgZoQFeyVURJTMsW
         3UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684879412; x=1687471412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3/mPMNJ7/h7rqHqGun24hHWu5NE/mF12cbPJ8Cl0jU=;
        b=SCpVBWINxr2m+g4hkLYxtilwkpVaPm3pTXIoVPbgVDXdIVuttBqg//EAwn73sw+X+y
         sL+o7ioXW+yuyTymK1QZ8nesxBKvXtuIpvr4eg+seH/IX4IjcyKIqxRCR0TCHi8Kk2cy
         w6ebTurNfF+RWAgPYEfFgLYhtwiZWsQDDPCp3r6tSKmEgXo58+iAJlF3PDd3qzxy7IN+
         bWyL+ywvBcDdyUQq1N+Q4Ml93KR+VVq/xnu0bwGORlW/M7oR/NJpxy6baD33I1iHap3v
         Q9uJhrie2qAcvxpBucFRuGqBWya37d8Pp0ENFNP1BL/hvn1ZSLX/VFivQGGo+VtO49+P
         Vh9w==
X-Gm-Message-State: AC+VfDwPBifn1qW+IORKYxUAJXFfVwnBnM7cPq1XwNMpGlz1r2QT+CgN
        3R9oYohS7R5OjfC7u+EkZlLIdpw3nqjFciC5yP/AZw==
X-Google-Smtp-Source: ACHHUZ6bWQQJTpzhU6WaLsUhzz2pNvgVXRIJ+sev91yWzcFsyqudHvKqDOT3DIyvGufJlx5Q87lN+jnd33841n6FhuY=
X-Received: by 2002:a17:907:8a26:b0:96f:a0ee:113c with SMTP id
 sc38-20020a1709078a2600b0096fa0ee113cmr13953384ejc.19.1684879412141; Tue, 23
 May 2023 15:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkb7zSFT5VnZ-00CA0mBE8dFmVqwPwvMpCYG9c-J3ovjyA@mail.gmail.com>
 <B55000F8-BD65-432F-8430-F58054611474@didiglobal.com>
In-Reply-To: <B55000F8-BD65-432F-8430-F58054611474@didiglobal.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 23 May 2023 15:02:55 -0700
Message-ID: <CAJD7tkZwCreOS_XxDM_9mOTBo=Gatr12r1xtc64B_e5+HJhRqg@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 2:52=E2=80=AFAM =E7=A8=8B=E5=9E=B2=E6=B6=9B Chengka=
itao Cheng
<chengkaitao@didiglobal.com> wrote:
>
> At 2023-05-20 06:04:26, "Yosry Ahmed" <yosryahmed@google.com> wrote:
> >On Wed, May 17, 2023 at 10:12=E2=80=AFPM =E7=A8=8B=E5=9E=B2=E6=B6=9B Che=
ngkaitao Cheng
> ><chengkaitao@didiglobal.com> wrote:
> >>
> >> At 2023-05-18 04:42:12, "Yosry Ahmed" <yosryahmed@google.com> wrote:
> >> >On Wed, May 17, 2023 at 3:01=E2=80=AFAM =E7=A8=8B=E5=9E=B2=E6=B6=9B C=
hengkaitao Cheng
> >> ><chengkaitao@didiglobal.com> wrote:
> >> >>
> >> >> At 2023-05-17 16:09:50, "Yosry Ahmed" <yosryahmed@google.com> wrote=
:
> >> >> >On Wed, May 17, 2023 at 1:01=E2=80=AFAM =E7=A8=8B=E5=9E=B2=E6=B6=
=9B Chengkaitao Cheng
> >> >> ><chengkaitao@didiglobal.com> wrote:
> >> >> >>
> >> >>
> >> >> Killing processes in order of memory usage cannot effectively prote=
ct
> >> >> important processes. Killing processes in a user-defined priority o=
rder
> >> >> will result in a large number of OOM events and still not being abl=
e to
> >> >> release enough memory. I have been searching for a balance between
> >> >> the two methods, so that their shortcomings are not too obvious.
> >> >> The biggest advantage of memcg is its tree topology, and I also hop=
e
> >> >> to make good use of it.
> >> >
> >> >For us, killing processes in a user-defined priority order works well=
.
> >> >
> >> >It seems like to tune memory.oom.protect you use oom_kill_inherit to
> >> >observe how many times this memcg has been killed due to a limit in a=
n
> >> >ancestor. Wouldn't it be more straightforward to specify the priority
> >> >of protections among memcgs?
> >> >
> >> >For example, if you observe multiple memcgs being OOM killed due to
> >> >hitting an ancestor limit, you will need to decide which of them to
> >> >increase memory.oom.protect for more, based on their importance.
> >> >Otherwise, if you increase all of them, then there is no point if all
> >> >the memory is protected, right?
> >>
> >> If all memory in memcg is protected, its meaning is similar to that of=
 the
> >> highest priority memcg in your approach, which is ultimately killed or
> >> never killed.
> >
> >Makes sense. I believe it gets a bit trickier when you want to
> >describe relative ordering between memcgs using memory.oom.protect.
>
> Actually, my original intention was not to use memory.oom.protect to
> achieve relative ordering between memcgs, it was just a feature that
> happened to be achievable. My initial idea was to protect a certain
> proportion of memory in memcg from being killed, and through the
> method, physical memory can be reasonably planned. Both the physical
> machine manager and container manager can add some unimportant
> loads beyond the oom.protect limit, greatly improving the oversold
> rate of memory. In the worst case scenario, the physical machine can
> always provide all the memory limited by memory.oom.protect for memcg.
>
> On the other hand, I also want to achieve relative ordering of internal
> processes in memcg, not just a unified ordering of all memcgs on
> physical machines.

For us, having a strict priority ordering-based selection is
essential. We have different tiers of jobs of different importance,
and a job of higher priority should not be killed before a lower
priority task if possible, no matter how much memory either of them is
using. Protecting memcgs solely based on their usage can be useful in
some scenarios, but not in a system where you have different tiers of
jobs running with strict priority ordering.

>
> >> >In this case, wouldn't it be easier to just tell the OOM killer the
> >> >relative priority among the memcgs?
> >> >
> >> >>
> >> >> >If this approach works for you (or any other audience), that's gre=
at,
> >> >> >I can share more details and perhaps we can reach something that w=
e
> >> >> >can both use :)
> >> >>
> >> >> If you have a good idea, please share more details or show some cod=
e.
> >> >> I would greatly appreciate it
> >> >
> >> >The code we have needs to be rebased onto a different version and
> >> >cleaned up before it can be shared, but essentially it is as
> >> >described.
> >> >
> >> >(a) All processes and memcgs start with a default score.
> >> >(b) Userspace can specify scores for memcgs and processes. A higher
> >> >score means higher priority (aka less score gets killed first).
> >> >(c) The OOM killer essentially looks for the memcg with the lowest
> >> >scores to kill, then among this memcg, it looks for the process with
> >> >the lowest score. Ties are broken based on usage, so essentially if
> >> >all processes/memcgs have the default score, we fallback to the
> >> >current OOM behavior.
> >>
> >> If memory oversold is severe, all processes of the lowest priority
> >> memcg may be killed before selecting other memcg processes.
> >> If there are 1000 processes with almost zero memory usage in
> >> the lowest priority memcg, 1000 invalid kill events may occur.
> >> To avoid this situation, even for the lowest priority memcg,
> >> I will leave him a very small oom.protect quota.
> >
> >I checked internally, and this is indeed something that we see from
> >time to time. We try to avoid that with userspace OOM killing, but
> >it's not 100% effective.
> >
> >>
> >> If faced with two memcgs with the same total memory usage and
> >> priority, memcg A has more processes but less memory usage per
> >> single process, and memcg B has fewer processes but more
> >> memory usage per single process, then when OOM occurs, the
> >> processes in memcg B may continue to be killed until all processes
> >> in memcg B are killed, which is unfair to memcg B because memcg A
> >> also occupies a large amount of memory.
> >
> >I believe in this case we will kill one process in memcg B, then the
> >usage of memcg A will become higher, so we will pick a process from
> >memcg A next.
>
> If there is only one process in memcg A and its memory usage is higher
> than any other process in memcg B, but the total memory usage of
> memcg A is lower than that of memcg B. In this case, if the OOM-killer
> still chooses the process in memcg A. it may be unfair to memcg A.
>
> >> Dose your approach have these issues? Killing processes in a
> >> user-defined priority is indeed easier and can work well in most cases=
,
> >> but I have been trying to solve the cases that it cannot cover.
> >
> >The first issue is relatable with our approach. Let me dig more info
> >from our internal teams and get back to you with more details.
>
> --
> Thanks for your comment!
> chengkaitao
>
>
