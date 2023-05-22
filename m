Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA92870CBAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 22:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjEVUzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjEVUz2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 16:55:28 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D63100;
        Mon, 22 May 2023 13:55:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d4e45971bso1701117b3a.2;
        Mon, 22 May 2023 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684788915; x=1687380915;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jcZ4xLHlFOBJMSeqJOPUC+cCxzFb/2bpMue0o2+LyWg=;
        b=NhDfKwKmQqTx0k0rb4etztvU4oZUGCrD6GnpDCUv5gYrdAInkuG+Pbfj2sWkRK75GE
         eEv4hZBxOKHblTbEOwTE8x6zJjRsFkyPrKtDO5aSvmAzTGc9h2JeKkeliGLT4oxzAM+z
         cqrGjTVlai+tBgdsWwPy2OB5kzJWfbCe2HwZib6Rd12NaySc4rZGX3wwAwljRyPxCuM7
         mkkG66UWcfS8BoUgs04jDarriwnupHX7oygNuJwUINElggfMahoJvfCuSFteFLt58k2i
         bWUIDDlJPDXAH7NrXm4602kvJUflIHBfpMI2XRO2fB4UVTvnvlAt2dcpTbtjAqgsi1HT
         0LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788915; x=1687380915;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcZ4xLHlFOBJMSeqJOPUC+cCxzFb/2bpMue0o2+LyWg=;
        b=JQm6QzYjh8l7576W78ZqwmAXxe4riHwyjxjONFFHbdgrsxTEtZ7v5bhgMz+u3xZ+wg
         2MIsLYIVsUnXLl8jmeitd3oFm7xxjF+enD8QsbfNa92yPfifDXisrpssPqUy1Wo/sEyl
         qPe9v5JRypmQR22R6mKW5noG3gX3g0CeNmd+TcV+LA3wgt4NU9kqZUQOzTeeY0VhACOF
         zTMSB7ObbgoKluPXI+wtqxSGT5YVPMKkvuZrTSy75xbiVEjPobx1kPJmR66NXHtSlqSB
         m0bejgOlxLzCLytPyCQKYcrva8jweq+PxtO25KXZrCDtg49sMMMAzzubX9MIounoVbrR
         Nxvw==
X-Gm-Message-State: AC+VfDyrknY54Gocg2nCJIkSECbE/n8sHrlkIPv/Zi66Um7SGKiAZuPT
        fHhxlMqevOBi73qFD7BcbaI=
X-Google-Smtp-Source: ACHHUZ68aGA3rwWC2fPM5JhK2e0SIaBG0ZlgFltV8K9ruuYYzLQvyYCvqTWRNBEdmZ7V0pnttUmYJg==
X-Received: by 2002:a05:6a00:c88:b0:641:d9b:a444 with SMTP id a8-20020a056a000c8800b006410d9ba444mr15735727pfv.31.1684788915189;
        Mon, 22 May 2023 13:55:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:39c])
        by smtp.gmail.com with ESMTPSA id w17-20020aa78591000000b006414c3ba8a3sm4673018pfn.177.2023.05.22.13.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:55:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 22 May 2023 10:55:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: Re: [RFC PATCH 3/3] cgroup: Do not take css_set_lock in
 cgroup_show_path
Message-ID: <ZGvWsOOw2C68SYUx@slm.duckdns.org>
References: <20230502133847.14570-1-mkoutny@suse.com>
 <20230502133847.14570-4-mkoutny@suse.com>
 <ZFUktg4Yxa30jRBX@slm.duckdns.org>
 <ta7bilcvc7lzt5tvs44y5wxqt6i3gdmvzwcr5h2vxhjhshmivk@3mecui76fxvy>
 <ZFVIJlAMyzTh3QTP@slm.duckdns.org>
 <6rjdfjltz5kkwzobpeefbqxzj4wbd4jzstdryb6rb67td3x45q@5ujarspzjk3x>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6rjdfjltz5kkwzobpeefbqxzj4wbd4jzstdryb6rb67td3x45q@5ujarspzjk3x>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Michal.

Sorry about the delay.

On Tue, May 09, 2023 at 12:34:53PM +0200, Michal Koutný wrote:
> On Fri, May 05, 2023 at 08:17:10AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > On Fri, May 05, 2023 at 07:32:40PM +0200, Michal Koutný wrote:
> > > On Fri, May 05, 2023 at 05:45:58AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > > > > There are three relevant nodes for each cgroupfs entry:
> > > > > 
> > > > >         R ... cgroup hierarchy root
> > > > >         M ... mount root
> > > > >         C ... reader's cgroup NS root
> > > > > 
> > > > > mountinfo is supposed to show path from C to M.
> > > > 
> > > > At least for cgroup2, the path from C to M isn't gonna change once NS is
> > > > established, right?
> > > 
> > > Right. Although, the argument about M (when C above M or when C and M in
> > > different subtrees) implicitly relies on the namespace_sem.
> > 
> > I don't follow. Can you please elaborate a bit more?
> 
> I wanted to say that even with restriction to cgroup2, the css_set_lock
> removal would also rely on namespace_sem.
> 
> For a given mountinfo entry the path C--M won't change (no renames).
> The question is whether cgroup M will stay around (with the relaxed
> locking):
> 
>   - C >= M (C is below M) 
>     -> C (transitively) pins M

Yeah, this was what I was thinking.

>   - C < M (C is above M) or C and M are in two disjoint subtrees (path
>     goes through a common ancestor)
>     -> M could be released without relation to C (even on cgroup2, with
>        the css_set_lock removed) but such a destructive operation on M
>        is excluded as long as namespace_sem is held during entry
>        rendering.
> 
> Does that clarify the trade-off of removing css_set_lock at this spot?

Right, you can have cgroup outside NS root still mounted and that mount root
can be viewed from multiple cgroup NS's, so the the path isn't fixed either.

Having enough lockdep annotations should do but if reasonable the preference
is being a bit more self-contained.

Thanks for the explanation.

-- 
tejun
