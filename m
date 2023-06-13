Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A3C72DCA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbjFMIhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 04:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbjFMIhj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:37:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB64CA0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 01:37:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98220bb31c6so277985766b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686645448; x=1689237448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ+CvAJZZG5mOPdj3tAJQaLRWxTq3hPFAsybxhkvum8=;
        b=ueFdsDRGBH0IFFxFK5dPixyGXGsAYzcWqUEOQdg71MXN4n/hDpu0fNd0RBX7IsmfP3
         2LqBGZ7Zq7fzGNk1KNj2QhoaYIBhAcrjtYWnhh8lBr/CZRgapwKBEo9Yv0ShQqCEhWWv
         dvl8YHEyWCBJXZQ46e5a4rsHQDnQGFHAFsRsAJbsg66c/0Jok8KeWHl2y6iOw9PN0ldg
         ZWOUAS0SHMlY9th/JhoJ+LiL0QsVq0PSzBI5bllG3ESnXuSADW/2eGQu6CKX6lbLKy72
         JhXWx5Sk4E4G/oAYn95haLXo0bn5JcE6n0OgTMYsXscI9SoyZZAvG0HnlKS/9h0EVtR6
         /cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645448; x=1689237448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZ+CvAJZZG5mOPdj3tAJQaLRWxTq3hPFAsybxhkvum8=;
        b=YL1JdSBmYxEstOp4O1SsE87lPncfXcEGdpjX6/pDhmrK4MfCbxc5qnA+k8P7CMAlcT
         H1wQrg+G8PQ6kAX8XZu98Jvc/w+ux3hxicAhNSOIWyDuXtcycN5cctLNQIgtizFFYk7y
         AL6lqV8XKTx4JGdpPfp5vaYC2R8UwvucJ1eJjC/tNPMi+539TDlYm01LA08QLrCryMJ7
         g2B6MPun0Eagc4U22z5hZltvg1y+y1hzxp6b9fin5AT/9bR6iNPgtwR5fJ7TRI5kgcMr
         Hm3tzuuuq96RFSfY4iC3+qpyVoXFvsSr4hORHi+hEBLZ9SZ24CFdpNUJOPZ7zNcpMNa4
         fu0Q==
X-Gm-Message-State: AC+VfDxbvl7E7Rtn1S7/Bo+8ZojOfChUh7Rn4QHxUNuBAgK0nWWxHeKB
        eQPMTikXjlTyffAV135ihfBGOHL9kdNeA3qebGuPxw==
X-Google-Smtp-Source: ACHHUZ6uGMKBTwsoiCikHiVn+L2G5gz5cmKZSfbfxN+oebwVUTrET8ET/OE8YdnXQUdl3/48h5DDxbOZETNpF3Zdca8=
X-Received: by 2002:a17:906:7945:b0:978:8e58:e1b9 with SMTP id
 l5-20020a170906794500b009788e58e1b9mr13770780ejo.74.1686645448020; Tue, 13
 Jun 2023 01:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <ZFd5bpfYc3nPEVie@dhcp22.suse.cz> <66F9BB37-3BE1-4B0F-8DE1-97085AF4BED2@didiglobal.com>
 <ZFkEqhAs7FELUO3a@dhcp22.suse.cz> <CAJD7tkaw_7vYACsyzAtY9L0ZVC0B=XJEWgG=Ad_dOtL_pBDDvQ@mail.gmail.com>
 <ZIgodGWoC/R07eak@dhcp22.suse.cz>
In-Reply-To: <ZIgodGWoC/R07eak@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 13 Jun 2023 01:36:51 -0700
Message-ID: <CAJD7tkawYZAWKYgttgtPjscnZTARj+QaGZLGiMiSadwC3oCELQ@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+David Rientjes

On Tue, Jun 13, 2023 at 1:27=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Sun 04-06-23 01:25:42, Yosry Ahmed wrote:
> [...]
> > There has been a parallel discussion in the cover letter thread of v4
> > [1]. To summarize, at Google, we have been using OOM scores to
> > describe different job priorities in a more explicit way -- regardless
> > of memory usage. It is strictly priority-based OOM killing. Ties are
> > broken based on memory usage.
> >
> > We understand that something like memory.oom.protect has an advantage
> > in the sense that you can skip killing a process if you know that it
> > won't free enough memory anyway, but for an environment where multiple
> > jobs of different priorities are running, we find it crucial to be
> > able to define strict ordering. Some jobs are simply more important
> > than others, regardless of their memory usage.
>
> I do remember that discussion. I am not a great fan of simple priority
> based interfaces TBH. It sounds as an easy interface but it hits
> complications as soon as you try to define a proper/sensible
> hierarchical semantic. I can see how they might work on leaf memcgs with
> statically assigned priorities but that sounds like a very narrow
> usecase IMHO.

Do you mind elaborating the problem with the hierarchical semantics?

The way it works with our internal implementation is (imo) sensible
and straightforward from a hierarchy POV. Starting at the OOM memcg
(which can be root), we recursively compare the OOM scores of the
children memcgs and pick the one with the lowest score, until we
arrive at a leaf memcg. Within that leaf, we also define per-process
scores, but these are less important to us.

I am not sure I understand why this is not sensible from a hierarchy
POV or a very narrow use case. Not that all this is optional, by
default all memcgs are given the same score, and ties are broken based
on per-memcg (or per-process) usage.

>
> I do not think we can effort a plethora of different OOM selection
> algorithms implemented in the kernel. Therefore we should really
> consider a control interface to be as much extensible and in line
> with the existing interfaces as much as possible. That is why I am
> really open to the oom protection concept which fits reasonably well
> to the reclaim protection scheme. After all oom killer is just a very
> aggressive method of the memory reclaim.
>
> On the other hand I can see a need to customizable OOM victim selection
> functionality. We've been through that discussion on several other
> occasions and the best thing we could come up with was to allow to plug
> BPF into the victim selection process and allow to bypass the system
> default method. No code has ever materialized from those discussions
> though. Maybe this is the time to revive that idea again?

That definitely sounds interesting, and it was brought up before. It
does sound like BPF (or a different customization framework) can be
the answer here. Interested to hear what others think as well.

>
> > It would be great if we can arrive at an interface that serves this
> > use case as well.
> >
> > Thanks!
> >
> > [1]https://lore.kernel.org/linux-mm/CAJD7tkaQdSTDX0Q7zvvYrA3Y4TcvLdWKnN=
3yc8VpfWRpUjcYBw@mail.gmail.com/
> --
> Michal Hocko
> SUSE Labs
