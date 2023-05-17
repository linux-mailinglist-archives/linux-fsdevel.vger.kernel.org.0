Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A437C706257
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjEQIKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 04:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjEQIKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 04:10:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A343A9D
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 01:10:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so827728a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684311027; x=1686903027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/JbPTvNpjTaAOSiw7cq2XUFwTTZo3maiLd9kZ3gbPY=;
        b=E/nQr0TtAbvKOJgpRKAM1JVFuP/MwUX23KxLMaK9E935LDpjE6s9HpTk6zcktHzA3V
         lVxuSKWxkpaEF/0X7X4fb0A2wQtR+BP46udE3XC2KotT4N3Y20wucgNCN5myvUQPrgYm
         hf8qXaIk4/mtVqOzBMdebf1uOebU+yZFQwgKC0uSR7A2S8DJaBgTCt2tXTRjmHgu9gTl
         He1rqLvC6itIyQX551xHdP0ntcFbz4HClZ9Wg7mkLnBAKGlfTSh3/2KEYLgKR0024kd1
         FZk9gcyZUQemmV3CyHP8mGDAj9j4MwZkxgKrt5y90zAG/N8tFGr657bHQAGYojKPXnWN
         MoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684311027; x=1686903027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/JbPTvNpjTaAOSiw7cq2XUFwTTZo3maiLd9kZ3gbPY=;
        b=ESkpwpp5TPhckkVs/qnrsrtun+4qOoOm7b6H5l8UxVT8s31Gxg9rQZ57LNqcHbhIkq
         qJ5D15rfdVs/I8J2ERTwZT2D+x9GpMhWQmoIk0czQBvIVQJXmUhsqf3h7yyjjQNHEVYY
         Jp4cobiyHH5b8zfOf3rU9Ue3V27XvhqV+PRPYc5G0nImcNPz0zGZHHVDYwHEtR5A2r9P
         0I9JZFeBDhZruxsgGPlVpXjYhqjuAn5AO3Dgbsu/rtLbZwFcGJNW6zp5yGVGLP9pXEWB
         C1al0FduL2PFyVFKvjqHP/Fg4KdGZXh24BC2ZsSMhuwf9Ux0pPmpMYaA4obTS4I3i+Gj
         F0Ug==
X-Gm-Message-State: AC+VfDykcFhpwUoH4+wr5NPCIzj+m6QRPM9+/VkSDMUhr0hb5PLrSss0
        rMxPoXPozjG6g3betKhG4c3NpVHaBmfVjL8hUEDsVw==
X-Google-Smtp-Source: ACHHUZ45upb/WQWXJ0QlUEgpUZn+CmUofbM6pNnjDG0KW/H53o2SeMyeHn7WakUEa0zZJ6DGueoe8o/J1+MWpbNBXNs=
X-Received: by 2002:a17:906:fe04:b0:966:1984:9d21 with SMTP id
 wy4-20020a170906fe0400b0096619849d21mr30993043ejb.9.1684311027372; Wed, 17
 May 2023 01:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkYPGwAFo0mrhq5twsVquwFwkhOyPwsZJtECw-5HAXtQrg@mail.gmail.com>
 <09A746CC-E38D-4ECA-B0F4-862EC6229A0F@didiglobal.com>
In-Reply-To: <09A746CC-E38D-4ECA-B0F4-862EC6229A0F@didiglobal.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 17 May 2023 01:09:50 -0700
Message-ID: <CAJD7tkbHKQBoz7kn6ZjMTMoxLKYs7x9w4uRGWLvuyOogmBkZ_g@mail.gmail.com>
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

On Wed, May 17, 2023 at 1:01=E2=80=AFAM =E7=A8=8B=E5=9E=B2=E6=B6=9B Chengka=
itao Cheng
<chengkaitao@didiglobal.com> wrote:
>
> At 2023-05-17 14:59:06, "Yosry Ahmed" <yosryahmed@google.com> wrote:
> >+David Rientjes
> >
> >On Tue, May 16, 2023 at 8:20=E2=80=AFPM chengkaitao <chengkaitao@didiglo=
bal.com> wrote:
> >>
> >> Establish a new OOM score algorithm, supports the cgroup level OOM
> >> protection mechanism. When an global/memcg oom event occurs, we treat
> >> all processes in the cgroup as a whole, and OOM killers need to select
> >> the process to kill based on the protection quota of the cgroup.
> >>
> >
> >Perhaps this is only slightly relevant, but at Google we do have a
> >different per-memcg approach to protect from OOM kills, or more
> >specifically tell the kernel how we would like the OOM killer to
> >behave.
> >
> >We define an interface called memory.oom_score_badness, and we also
> >allow it to be specified per-process through a procfs interface,
> >similar to oom_score_adj.
> >
> >These scores essentially tell the OOM killer the order in which we
> >prefer memcgs to be OOM'd, and the order in which we want processes in
> >the memcg to be OOM'd. By default, all processes and memcgs start with
> >the same score. Ties are broken based on the rss of the process or the
> >usage of the memcg (prefer to kill the process/memcg that will free
> >more memory) -- similar to the current OOM killer.
>
> Thank you for providing a new application scenario. You have described a
> new per-memcg approach, but a simple introduction cannot explain the
> details of your approach clearly. If you could compare and analyze my
> patches for possible defects, or if your new approach has advantages
> that my patches do not have, I would greatly appreciate it.

Sorry if I was not clear, I am not implying in any way that the
approach I am describing is better than your patches. I am guilty of
not conducting the proper analysis you are requesting.

I just saw the thread and thought it might be interesting to you or
others to know the approach that we have been using for years in our
production. I guess the target is the same, be able to tell the OOM
killer which memcgs/processes are more important to protect. The
fundamental difference is that instead of tuning this based on the
memory usage of the memcg (your approach), we essentially give the OOM
killer the ordering in which we want memcgs/processes to be OOM
killed. This maps to jobs priorities essentially.

If this approach works for you (or any other audience), that's great,
I can share more details and perhaps we can reach something that we
can both use :)

>
> >This has been brought up before in other discussions without much
> >interest [1], but just thought it may be relevant here.
> >
> >[1]https://lore.kernel.org/lkml/CAHS8izN3ej1mqUpnNQ8c-1Bx5EeO7q5NOkh0qrY=
_4PLqc8rkHA@mail.gmail.com/#t
>
> --
> Thanks for your comment!
> chengkaitao
>
