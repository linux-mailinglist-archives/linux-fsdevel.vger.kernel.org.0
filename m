Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038197324C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 03:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjFPBpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 21:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjFPBp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:45:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBAC2D58
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 18:45:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-983f499fc81so14517866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 18:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686879923; x=1689471923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTYhjgjxFSXf3VV7TigycNG8AweXhCpfWjk/TzQLXHc=;
        b=S3sEkwkMSll1Qn9sm5LHOkOGyqa9IWwEh1o6Y2R2ElKB5bZkFZpm65z7B/tJRybHER
         yTY2PIEZH0eR3Po6ZzHc16OeGyVIkYmwtCdXTjriszEjXtNBantUF2Ozi0mpVcPOGbQR
         VgvxxP+s36cJ6ooAMxS1X3+6p3goyhZP/H5vJrbNfsyKpR2M7tBc+v8IN6GtYfyfbbta
         ICo8LaY+2xcwDkL7DVIETr6Y4ilhpY6Yewxp7bD4HTMOHcQrYq25VgUL9Z1BeZ7c2lQW
         a+FSy7QJEBUbtpKMDq5KKPiz2RtmaJRgAFtsxBoSZ+nKhq+XI8wXK4yAB4bxQZC1j+qn
         v45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686879923; x=1689471923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTYhjgjxFSXf3VV7TigycNG8AweXhCpfWjk/TzQLXHc=;
        b=RAclAE9YdgXylQa527DcszU6gIb4T89D7Ec3PTyP1vToRHJGdmqEL8eXoijOS5lY/s
         6BKtw7P945Regb7UuWIH/ivNNN3phe+uHFlggGIhLM76cViMbUeGopmYWFKZpFqYo0pn
         3Q9nLnLvxWo94bwiywhng/jBp6oNLMZIgQNbJqhIv7hiY304+cAgdKGeZkiNMwulR7Xw
         nO+iyV5MyZsCx+dhcK2tEPWl9LdyM/1Y9NLeBaJ7vXS+4uHxzGxzKALdvh+wy4ecFnki
         T/8HzerldtVVhPZZ9q4S1rxZ83g/k/75x4cJi2tuABe5DvUawn3T3F7A+AyAOwGZtx/D
         cZSg==
X-Gm-Message-State: AC+VfDw9ON5VSWIo9i0Fl1MYPE9xGwhwwyjuhJMlWYbBQsVFFpPDXk4H
        7/Cbwm/sBfFayX3SFhdOhjV4+tlkok7Pc3c+zXUYPA==
X-Google-Smtp-Source: ACHHUZ76cAdEZK0llouR54CbD1icf6/E/UdAzOAQRemvApKZ4TRkyjsCJnLxVEcQpOzKFdNMdqwzNpJQNZ132gn3wXY=
X-Received: by 2002:a17:906:730d:b0:974:b15:fcd9 with SMTP id
 di13-20020a170906730d00b009740b15fcd9mr615087ejc.53.1686879923492; Thu, 15
 Jun 2023 18:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <ZFd5bpfYc3nPEVie@dhcp22.suse.cz> <66F9BB37-3BE1-4B0F-8DE1-97085AF4BED2@didiglobal.com>
 <ZFkEqhAs7FELUO3a@dhcp22.suse.cz> <CAJD7tkaw_7vYACsyzAtY9L0ZVC0B=XJEWgG=Ad_dOtL_pBDDvQ@mail.gmail.com>
 <ZIgodGWoC/R07eak@dhcp22.suse.cz> <CAJD7tkawYZAWKYgttgtPjscnZTARj+QaGZLGiMiSadwC3oCELQ@mail.gmail.com>
 <ZIhb1EwvrdKXpEMb@dhcp22.suse.cz> <CAJD7tka-w8-0G5hjr8MRAue0wct0UPh4-BrPEGkOa1eUycz5mQ@mail.gmail.com>
 <ZIrqYX9olxbZJML2@dhcp22.suse.cz>
In-Reply-To: <ZIrqYX9olxbZJML2@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 15 Jun 2023 18:44:46 -0700
Message-ID: <CAJD7tkYtJcC6zYqy5vWeaB=1Rv16gY=q+OG7vF_Oc=DmVk24GA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] memcontrol: support cgroup level OOM protection
To:     Michal Hocko <mhocko@suse.com>
Cc:     =?UTF-8?B?56iL5Z6y5rabIENoZW5na2FpdGFvIENoZW5n?= 
        <chengkaitao@didiglobal.com>, "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
        "sujiaxun@uniontech.com" <sujiaxun@uniontech.com>,
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

On Thu, Jun 15, 2023 at 3:39=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 13-06-23 13:24:24, Yosry Ahmed wrote:
> > On Tue, Jun 13, 2023 at 5:06=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Tue 13-06-23 01:36:51, Yosry Ahmed wrote:
> > > > +David Rientjes
> > > >
> > > > On Tue, Jun 13, 2023 at 1:27=E2=80=AFAM Michal Hocko <mhocko@suse.c=
om> wrote:
> > > > >
> > > > > On Sun 04-06-23 01:25:42, Yosry Ahmed wrote:
> > > > > [...]
> > > > > > There has been a parallel discussion in the cover letter thread=
 of v4
> > > > > > [1]. To summarize, at Google, we have been using OOM scores to
> > > > > > describe different job priorities in a more explicit way -- reg=
ardless
> > > > > > of memory usage. It is strictly priority-based OOM killing. Tie=
s are
> > > > > > broken based on memory usage.
> > > > > >
> > > > > > We understand that something like memory.oom.protect has an adv=
antage
> > > > > > in the sense that you can skip killing a process if you know th=
at it
> > > > > > won't free enough memory anyway, but for an environment where m=
ultiple
> > > > > > jobs of different priorities are running, we find it crucial to=
 be
> > > > > > able to define strict ordering. Some jobs are simply more impor=
tant
> > > > > > than others, regardless of their memory usage.
> > > > >
> > > > > I do remember that discussion. I am not a great fan of simple pri=
ority
> > > > > based interfaces TBH. It sounds as an easy interface but it hits
> > > > > complications as soon as you try to define a proper/sensible
> > > > > hierarchical semantic. I can see how they might work on leaf memc=
gs with
> > > > > statically assigned priorities but that sounds like a very narrow
> > > > > usecase IMHO.
> > > >
> > > > Do you mind elaborating the problem with the hierarchical semantics=
?
> > >
> > > Well, let me be more specific. If you have a simple hierarchical nume=
ric
> > > enforcement (assume higher priority more likely to be chosen and the
> > > effective priority to be max(self, max(parents)) then the semantic
> > > itslef is straightforward.
> > >
> > > I am not really sure about the practical manageability though. I have
> > > hard time to imagine priority assignment on something like a shared
> > > workload with a more complex hierarchy. For example:
> > >             root
> > >         /    |    \
> > > cont_A    cont_B  cont_C
> > >
> > > each container running its workload with own hierarchy structures tha=
t
> > > might be rather dynamic during the lifetime. In order to have a
> > > predictable OOM behavior you need to watch and reassign priorities al=
l
> > > the time, no?
> >
> > In our case we don't really manage the entire hierarchy in a
> > centralized fashion. Each container gets a score based on their
> > relative priority, and each container is free to set scores within its
> > subcontainers if needed. Isn't this what the hierarchy is all about?
> > Each parent only cares about its direct children. On the system level,
> > we care about the priority ordering of containers. Ordering within
> > containers can be deferred to containers.
>
> This really depends on the workload. This might be working for your
> setup but as I've said above, many workloads would be struggling with
> re-prioritizing as soon as a new workload is started and oom priorities
> would need to be reorganized as a result. The setup is just too static
> to be generally useful IMHO.
> You can avoid that by essentially making mid-layers no priority and only
> rely on leaf memcgs when this would become more flexible. This is
> something even more complicated with the top-down approach.

I agree that other setups may find it more difficult if one entity
needs to manage the entire tree, although if the scores range is large
enough, I don't really think it's that static. When a new workload is
started you decide what its priority is compared to the existing
workloads and set its score as such. We use a range of scores from 0
to 10,000 (and it can easily be larger), so it's easy to assign new
scores without reorganizing the existing scores.

>
> That being said, I can see workloads which could benefit from a
> priority (essentially user spaced controlled oom pre-selection) based
> policy. But there are many other policies like that that would be
> usecase specific and not generic enough so I do not think this is worth
> a generic interface and would fall into BPF or alike based policies.

That's reasonable. I can't speak for other folks. Perhaps no single
policy will be generic enough, and we should focus on enabling
customized policy. Perhaps other userspace OOM agents can benefit from
this as well.

>
> --
> Michal Hocko
> SUSE Labs
