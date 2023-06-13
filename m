Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC18C72ECDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 22:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjFMUZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 16:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbjFMUZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:25:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B72F198B
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 13:25:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977cc662f62so862574866b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 13:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686687901; x=1689279901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu74121bGTOyi/gScvgyRcJ4UHCFo8s9EjAjR7M4bno=;
        b=ulZ0jrJSHTa44Qg7LztFaCU5OztMo1pzVdcwaQdm3K0MJ+V8u2aBjSkTyr9cquXrQA
         GHi/c9unlglS2gH6aSu87kJPrEnsYJkUqT7K98t95dvhTb2hl8FnJlyKH59hFs/QomsE
         B0IG2WTvaJQe+TMeAvtQzzZCYw9ZbLHP7XM+ayfnU//j7Plf0t2fyDdDz/YHSjg1fE1y
         vfJ7xZTNRGH04qcTdDaxtvDjnf7xuB9RSqUHby5veNVYLqpQ7nGJy4ytb5MQtdmPP4O8
         yNPNCgR/Ew0tge3k25Z+klUrBuGsQ4LGa/QDhPzFgee+jNvpGtHmhB70UEtFK1O60XHE
         s3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687901; x=1689279901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tu74121bGTOyi/gScvgyRcJ4UHCFo8s9EjAjR7M4bno=;
        b=Gl3IgUYGYsrjHIdMuewWC7XutY5nYJSzNO+341nE0d1EqAt9PFHvuCO8ncsk97dd4J
         nwiijZJ+5fG7P/3hRbp1Z2m5OuXF6CeGVU/EVuG3u6lKvdJCSSX04004IuAqN45ugeY+
         pn1Mp2JCGmxD40pP6IX2ZsfxSns3ix4qoI/Bc355KJq60tT+GbAkoGDKhx5vrjYjVANW
         Q6uy0fnI0nJNldsiAvorDzBqu81dGepZckahf3WdTgbfWFcITgvAEyP6QhlEyN/hTmMo
         L80BOCTI/CB0gL0ECFfVdF1s9UAsAULQrsyjO7+l6pBR0k7grxnNwNz/g9q33V6dKHKC
         GCtA==
X-Gm-Message-State: AC+VfDxZiWRLEKDjOm58F8r4vKAEkE1LOzhYIfzKkfhjeNnowUpKii18
        iIRx+tNcSJ4hMrm5/BI7OtopNy8aEIg2p62SWWQbzg==
X-Google-Smtp-Source: ACHHUZ4UQLCRFW8Ae1CeHiyl3YXv4gfhRdDudewN0V5us8ifj90n5vl30hC8MeMLRwFSyiBhziB9drX0AujNZLFOpc0=
X-Received: by 2002:a17:907:2d8f:b0:959:5407:3e65 with SMTP id
 gt15-20020a1709072d8f00b0095954073e65mr16064057ejc.55.1686687901264; Tue, 13
 Jun 2023 13:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZFd5bpfYc3nPEVie@dhcp22.suse.cz> <66F9BB37-3BE1-4B0F-8DE1-97085AF4BED2@didiglobal.com>
 <ZFkEqhAs7FELUO3a@dhcp22.suse.cz> <CAJD7tkaw_7vYACsyzAtY9L0ZVC0B=XJEWgG=Ad_dOtL_pBDDvQ@mail.gmail.com>
 <ZIgodGWoC/R07eak@dhcp22.suse.cz> <CAJD7tkawYZAWKYgttgtPjscnZTARj+QaGZLGiMiSadwC3oCELQ@mail.gmail.com>
 <ZIhb1EwvrdKXpEMb@dhcp22.suse.cz>
In-Reply-To: <ZIhb1EwvrdKXpEMb@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 13 Jun 2023 13:24:24 -0700
Message-ID: <CAJD7tka-w8-0G5hjr8MRAue0wct0UPh4-BrPEGkOa1eUycz5mQ@mail.gmail.com>
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

On Tue, Jun 13, 2023 at 5:06=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 13-06-23 01:36:51, Yosry Ahmed wrote:
> > +David Rientjes
> >
> > On Tue, Jun 13, 2023 at 1:27=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Sun 04-06-23 01:25:42, Yosry Ahmed wrote:
> > > [...]
> > > > There has been a parallel discussion in the cover letter thread of =
v4
> > > > [1]. To summarize, at Google, we have been using OOM scores to
> > > > describe different job priorities in a more explicit way -- regardl=
ess
> > > > of memory usage. It is strictly priority-based OOM killing. Ties ar=
e
> > > > broken based on memory usage.
> > > >
> > > > We understand that something like memory.oom.protect has an advanta=
ge
> > > > in the sense that you can skip killing a process if you know that i=
t
> > > > won't free enough memory anyway, but for an environment where multi=
ple
> > > > jobs of different priorities are running, we find it crucial to be
> > > > able to define strict ordering. Some jobs are simply more important
> > > > than others, regardless of their memory usage.
> > >
> > > I do remember that discussion. I am not a great fan of simple priorit=
y
> > > based interfaces TBH. It sounds as an easy interface but it hits
> > > complications as soon as you try to define a proper/sensible
> > > hierarchical semantic. I can see how they might work on leaf memcgs w=
ith
> > > statically assigned priorities but that sounds like a very narrow
> > > usecase IMHO.
> >
> > Do you mind elaborating the problem with the hierarchical semantics?
>
> Well, let me be more specific. If you have a simple hierarchical numeric
> enforcement (assume higher priority more likely to be chosen and the
> effective priority to be max(self, max(parents)) then the semantic
> itslef is straightforward.
>
> I am not really sure about the practical manageability though. I have
> hard time to imagine priority assignment on something like a shared
> workload with a more complex hierarchy. For example:
>             root
>         /    |    \
> cont_A    cont_B  cont_C
>
> each container running its workload with own hierarchy structures that
> might be rather dynamic during the lifetime. In order to have a
> predictable OOM behavior you need to watch and reassign priorities all
> the time, no?

In our case we don't really manage the entire hierarchy in a
centralized fashion. Each container gets a score based on their
relative priority, and each container is free to set scores within its
subcontainers if needed. Isn't this what the hierarchy is all about?
Each parent only cares about its direct children. On the system level,
we care about the priority ordering of containers. Ordering within
containers can be deferred to containers.

>
> > The way it works with our internal implementation is (imo) sensible
> > and straightforward from a hierarchy POV. Starting at the OOM memcg
> > (which can be root), we recursively compare the OOM scores of the
> > children memcgs and pick the one with the lowest score, until we
> > arrive at a leaf memcg.
>
> This approach has a strong requirement on the memcg hierarchy
> organization. Siblings have to be directly comparable because you cut
> off many potential sub-trees this way (e.g. is it easy to tell
> whether you want to rule out all system or user slices?).
>
> I can imagine usecases where this could work reasonably well e.g. a set
> of workers of a different priority all of them running under a shared
> memcg parent. But more more involved hierarchies seem more complex
> because you always keep in mind how the hierarchy is organize to get to
> your desired victim.

I guess the main point is what I mentioned above, you don't need to
manage the entire tree, containers can manage their subtrees. The most
important thing is to provide the kernel with priority ordering among
containers, and optionally priority ordering within a container
(disregarding other containers).

>
> --
> Michal Hocko
> SUSE Labs
