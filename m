Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF9721592
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 10:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjFDI0Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 04:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFDI0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:26:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3510CE9
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jun 2023 01:26:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-969f90d71d4so534977366b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jun 2023 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685867179; x=1688459179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFfM5d2nTHRmpRlO8mIDJZgjXTrnnKiTQlq61ReJsa0=;
        b=JmQ+twu4hyc6GP5UJQA6Eu29aA0DwIhCrRkHmDjwYwe/BSzxhojMr8b26mJnMv8/jg
         BtIXW2q5PfM1UgknUh9nKTTPZ8XLNMBwVvrOGlXr95KLX76vfLyP1M++KLH7kIrYQ/yY
         BOVKOwnF9SIi+7FHkP0XtD+3ZADPO3kRukwbA7EBKhI1h9xA3NasnueOukU9xlEyLM7I
         FWugG+Ccy00cHRUGTSQCmWT49iWdS0QpCS0bf4ReiAWadq53Mici8wKzHFjfcbFLSVOa
         w2SfgAiOpXSoxFYDV2PvgszyHJJp2+rsk6TshffX3hYXYZ7NG9ghdkDzN3FOWDJDAbwk
         Lotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685867179; x=1688459179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFfM5d2nTHRmpRlO8mIDJZgjXTrnnKiTQlq61ReJsa0=;
        b=IFGo2hcCK9May9TCpp0bvA2sblrQfAguxjxfGoVL1wRVeIsYOY5KF/GabAUWXxdo5e
         fCOVtRDyTIh9IIbkf4AIlL532Vl1AG26+lhM8PNeuq9WW9QWIx42hnMDx9g520vWwJEe
         43WMB7SH+gOUAcyTw8U3Qec/2D+LjY7QXguTDTqbfESGWiqolWHUcynQvxjhK8idNIsG
         JLf6Cwf0OCMX+iQXxnfGnXqUa90Bnq2kQlcRhr6ZSHi2AwYQWXslVy8rXrwosCotz9nl
         szViyNpA3J47g4KuWX5T5Iw2i3wjXkeDoSMvzVxCWniJC78Wn6m7XVGqlYoui+8RyhWw
         aFEw==
X-Gm-Message-State: AC+VfDzhr8c+mUr3iLv7mRYUnnrgMzePaNpDR54z4N/QiJgsZG+cGVw0
        TweluhGRO65U9vw5inlj/83TSxy0bVhO+QUBUzqmyQ==
X-Google-Smtp-Source: ACHHUZ63QyJHCE9Vzap3rzxeqGwgrwCnmQzp7XvVjXQK6XDPmgKa/rhNXBwua/DrWHYym9NtXdUrhIsVZ8egKlt0CVI=
X-Received: by 2002:a17:907:3f27:b0:94b:d57e:9d4b with SMTP id
 hq39-20020a1709073f2700b0094bd57e9d4bmr3443889ejc.2.1685867179447; Sun, 04
 Jun 2023 01:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <ZFd5bpfYc3nPEVie@dhcp22.suse.cz> <66F9BB37-3BE1-4B0F-8DE1-97085AF4BED2@didiglobal.com>
 <ZFkEqhAs7FELUO3a@dhcp22.suse.cz>
In-Reply-To: <ZFkEqhAs7FELUO3a@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sun, 4 Jun 2023 01:25:42 -0700
Message-ID: <CAJD7tkaw_7vYACsyzAtY9L0ZVC0B=XJEWgG=Ad_dOtL_pBDDvQ@mail.gmail.com>
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
        "linux-mm@kvack.org" <linux-mm@kvack.org>
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

On Mon, May 8, 2023 at 7:18=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Mon 08-05-23 09:08:25, =E7=A8=8B=E5=9E=B2=E6=B6=9B Chengkaitao Cheng w=
rote:
> > At 2023-05-07 18:11:58, "Michal Hocko" <mhocko@suse.com> wrote:
> > >On Sat 06-05-23 19:49:46, chengkaitao wrote:
> > >> Establish a new OOM score algorithm, supports the cgroup level OOM
> > >> protection mechanism. When an global/memcg oom event occurs, we trea=
t
> > >> all processes in the cgroup as a whole, and OOM killers need to sele=
ct
> > >> the process to kill based on the protection quota of the cgroup
> > >
> > >Although your patch 1 briefly touches on some advantages of this
> > >interface there is a lack of actual usecase. Arguing that oom_score_ad=
j
> > >is hard because it needs a parent process is rather weak to be honest.
> > >It is just trivial to create a thin wrapper, use systemd to launch
> > >important services or simply update the value after the fact. Now
> > >oom_score_adj has its own downsides of course (most notably a
> > >granularity and a lack of group protection.
> > >
> > >That being said, make sure you describe your usecase more thoroughly.
> > >Please also make sure you describe the intended heuristic of the knob.
> > >It is not really clear from the description how this fits hierarchical
> > >behavior of cgroups. I would be especially interested in the semantics
> > >of non-leaf memcgs protection as they do not have any actual processes
> > >to protect.
> > >
> > >Also there have been concerns mentioned in v2 discussion and it would =
be
> > >really appreciated to summarize how you have dealt with them.
> > >
> > >Please also note that many people are going to be slow in responding
> > >this week because of LSFMM conference
> > >(https://events.linuxfoundation.org/lsfmm/)
> >
> > Here is a more detailed comparison and introduction of the old oom_scor=
e_adj
> > mechanism and the new oom_protect mechanism,
> > 1. The regulating granularity of oom_protect is smaller than that of oo=
m_score_adj.
> > On a 512G physical machine, the minimum granularity adjusted by oom_sco=
re_adj
> > is 512M, and the minimum granularity adjusted by oom_protect is one pag=
e (4K).
> > 2. It may be simple to create a lightweight parent process and uniforml=
y set the
> > oom_score_adj of some important processes, but it is not a simple matte=
r to make
> > multi-level settings for tens of thousands of processes on the physical=
 machine
> > through the lightweight parent processes. We may need a huge table to r=
ecord the
> > value of oom_score_adj maintained by all lightweight parent processes, =
and the
> > user process limited by the parent process has no ability to change its=
 own
> > oom_score_adj, because it does not know the details of the huge table. =
The new
> > patch adopts the cgroup mechanism. It does not need any parent process =
to manage
> > oom_score_adj. the settings between each memcg are independent of each =
other,
> > making it easier to plan the OOM order of all processes. Due to the uni=
que nature
> > of memory resources, current Service cloud vendors are not oversold in =
memory
> > planning. I would like to use the new patch to try to achieve the possi=
bility of
> > oversold memory resources.
>
> OK, this is more specific about the usecase. Thanks! So essentially what
> it boils down to is that you are handling many containers (memcgs from
> our POV) and they have different priorities. You want to overcommit the
> memory to the extend that global ooms are not an unexpected event. Once
> that happens the total memory consumption of a specific memcg is less
> important than its "priority". You define that priority by the excess of
> the memory usage above a user defined threshold. Correct?

There has been a parallel discussion in the cover letter thread of v4
[1]. To summarize, at Google, we have been using OOM scores to
describe different job priorities in a more explicit way -- regardless
of memory usage. It is strictly priority-based OOM killing. Ties are
broken based on memory usage.

We understand that something like memory.oom.protect has an advantage
in the sense that you can skip killing a process if you know that it
won't free enough memory anyway, but for an environment where multiple
jobs of different priorities are running, we find it crucial to be
able to define strict ordering. Some jobs are simply more important
than others, regardless of their memory usage.

It would be great if we can arrive at an interface that serves this
use case as well.

Thanks!

[1]https://lore.kernel.org/linux-mm/CAJD7tkaQdSTDX0Q7zvvYrA3Y4TcvLdWKnN3yc8=
VpfWRpUjcYBw@mail.gmail.com/

>
> Your cover letter mentions that then "all processes in the cgroup as a
> whole". That to me reads as oom.group oom killer policy. But a brief
> look into the patch suggests you are still looking at specific tasks and
> this has been a concern in the previous version of the patch because
> memcg accounting and per-process accounting are detached.
>
> > 3. I conducted a test and deployed an excessive number of containers on=
 a physical
> > machine, By setting the oom_score_adj value of all processes in the con=
tainer to
> > a positive number through dockerinit, even processes that occupy very l=
ittle memory
> > in the container are easily killed, resulting in a large number of inva=
lid kill behaviors.
> > If dockerinit is also killed unfortunately, it will trigger container s=
elf-healing, and the
> > container will rebuild, resulting in more severe memory oscillations. T=
he new patch
> > abandons the behavior of adding an equal amount of oom_score_adj to eac=
h process
> > in the container and adopts a shared oom_protect quota for all processe=
s in the container.
> > If a process in the container is killed, the remaining other processes =
will receive more
> > oom_protect quota, making it more difficult for the remaining processes=
 to be killed.
> > In my test case, the new patch reduced the number of invalid kill behav=
iors by 70%.
> > 4. oom_score_adj is a global configuration that cannot achieve a kill o=
rder that only
> > affects a certain memcg-oom-killer. However, the oom_protect mechanism =
inherits
> > downwards, and user can only change the kill order of its own memcg oom=
, but the
> > kill order of their parent memcg-oom-killer or global-oom-killer will n=
ot be affected
>
> Yes oom_score_adj has shortcomings.
>
> > In the final discussion of patch v2, we discussed that although the adj=
ustment range
> > of oom_score_adj is [-1000,1000], but essentially it only allows two us=
ecases
> > (OOM_SCORE_ADJ_MIN, OOM_SCORE_ADJ_MAX) reliably. Everything in between =
is
> > clumsy at best. In order to solve this problem in the new patch, I intr=
oduced a new
> > indicator oom_kill_inherit, which counts the number of times the local =
and child
> > cgroups have been selected by the OOM killer of the ancestor cgroup. By=
 observing
> > the proportion of oom_kill_inherit in the parent cgroup, I can effectiv=
ely adjust the
> > value of oom_protect to achieve the best.
>
> What does the best mean in this context?
>
> > about the semantics of non-leaf memcgs protection,
> > If a non-leaf memcg's oom_protect quota is set, its leaf memcg will pro=
portionally
> > calculate the new effective oom_protect quota based on non-leaf memcg's=
 quota.
>
> So the non-leaf memcg is never used as a target? What if the workload is
> distributed over several sub-groups? Our current oom.group
> implementation traverses the tree to find a common ancestor in the oom
> domain with the oom.group.
>
> All that being said and with the usecase described more specifically. I
> can see that memcg based oom victim selection makes some sense. That
> menas that it is always a memcg selected and all tasks withing killed.
> Memcg based protection can be used to evaluate which memcg to choose and
> the overall scheme should be still manageable. It would indeed resemble
> memory protection for the regular reclaim.
>
> One thing that is still not really clear to me is to how group vs.
> non-group ooms could be handled gracefully. Right now we can handle that
> because the oom selection is still process based but with the protection
> this will become more problematic as explained previously. Essentially
> we would need to enforce the oom selection to be memcg based for all
> memcgs. Maybe a mount knob? What do you think?
> --
> Michal Hocko
> SUSE Labs
