Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FC2526625
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382044AbiEMPau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 11:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382039AbiEMPar (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 11:30:47 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6316F4AB
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 08:30:46 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id n10so6902293qvi.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aW+qiuuX9T5JCP8jrcHcLIm5ncOFZRpDVkBGr8nNpZk=;
        b=GoNducfn8OiKDJnmDyd9adoiAaTkNjaodB+e/MzGdyU/Bh2YV7b2Mfg/9tFEHr/Cmn
         ZaT97VZC5O4yMubi4aYxyovu3QbPt0M4tI3InUb0N9DuoE4C6Qh/7pL5xmRtTODimyGN
         0RbXrFccpxJ6NSDIox+nXhjLWmwMPqO508b1AcM8JQdtHwxye48Ez/PCFXnQCPeDp+si
         /0/GdjN8ogs6v2Iy6vqQtQnJyDEQKgePpAMlZxTtqPo9jVZw5awH36vm2gMbbOft9ueO
         xhm92ovGSt5DSiWHe7H/n62XJ1zg4wkFd3/EeFcLF44LncRuChfJgLIGVd2w2UL3rthv
         yHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aW+qiuuX9T5JCP8jrcHcLIm5ncOFZRpDVkBGr8nNpZk=;
        b=ho3dGUHQt9PmDhLPcKDPM3fvdFJCPKgUHRNjLQm8u1WjwypPQW/ZI35hThh69FRqYU
         QO8p5XFiKiyw/DpewTbcjInXS7XUbYYWDzJEtSkTrqP1HMVByxAsxz0HDDuXFnVhv1nz
         IsPnkTdb9Cu2BbJeG55iJeDn/+s5HlP08ledk7SK3rQwxU++UdTG+prFzRtpxILa4es7
         HQSb3QdVZO9JoM8pOGHZvgZXP+yaIKgsygXPl5bNYVWYS6rPZs/xqij/ubbFOAHfRbWP
         czcvGz3BM4rwk8skLQEYEX8BOCycV6g598ePMVXhQBJ49y90a/opYjhvEIDaCTwXh4Rr
         f10Q==
X-Gm-Message-State: AOAM532TzCoRzAnhZUP27Fq3U957uTdclGvLi5rxunulz98ZBcTZRdDL
        rI0Yek1kskUbIB3Slf5z2cMV7A==
X-Google-Smtp-Source: ABdhPJz1kFwidIR/VFz9WYpp4JgCZ1bYA+NPg4EHkUicTTkXJTZdB/1BbO4AJYAPgXiOWV6iM3G8xQ==
X-Received: by 2002:ad4:5aeb:0:b0:45a:f61f:d9d1 with SMTP id c11-20020ad45aeb000000b0045af61fd9d1mr4858160qvh.120.1652455845325;
        Fri, 13 May 2022 08:30:45 -0700 (PDT)
Received: from google.com (122.213.145.34.bc.googleusercontent.com. [34.145.213.122])
        by smtp.gmail.com with ESMTPSA id g20-20020a37e214000000b0069fc13ce23csm1453598qki.109.2022.05.13.08.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:30:44 -0700 (PDT)
Date:   Fri, 13 May 2022 15:30:41 +0000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] Volatile fanotify marks
Message-ID: <Yn55ocRH8f83n4RY@google.com>
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228140556.ae5rhgqsyzm5djbp@quack3.lan>
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

On Mon, Feb 28, 2022 at 03:05:56PM +0100, Jan Kara wrote:
> Hi Amir!
> 
> On Wed 23-02-22 20:42:37, Amir Goldstein wrote:
> > I wanted to get your feedback on an idea I have been playing with.
> > It started as a poor man's alternative to the old subtree watch problem.
> > For my employer's use case, we are watching the entire filesystem using
> > a filesystem mark, but would like to exclude events on a subtree
> > (i.e. all files underneath .private/).
> > 
> > At the moment, those events are filtered in userspace.
> > I had considered adding directory marks with an ignored mask on every
> > event that is received for a directory path under .private/, but that has the
> > undesired side effect of pinning those directory inodes to cache.
> > 
> > I have this old fsnotify-volatile branch [1] that I am using for an overlayfs
> > kernel internal fsnotify backend. I wonder what are your thoughts on
> > exposing this functionally to fanotify UAPI (i.e. FAN_MARK_VOLATILE).
> 
> Interesting idea. I have some reservations wrt to the implementation (e.g.
> fsnotify_add_mark_list() convention of returning EEXIST when it updated
> mark's mask, or the fact that inode reclaim should now handle freeing of
> mark connector and attached marks - which may get interesting locking wise)
> but they are all fixable.
> 
> I'm wondering a bit whether this is really useful enough (and consequently
> whether we will not get another request to extend fanotify API in some
> other way to cater better to some other usecase related to subtree watches
> in the near future). I understand ignore marks are mainly a performance
> optimization and as such allowing inodes to be reclaimed (which means they
> are not used much and hence ignored mark is not very useful anyway) makes
> sense. Thinking about this more, I guess it is useful to improve efficiency
> when you want to implement any userspace event-filtering scheme.
> 
> The only remaining pending question I have is whether we should not go
> further and allow event filtering to happen using an eBPF program. That
> would be even more efficient (both in terms of memory and CPU). What do you
> think?

Wait. Did I just read that Jan is open to implementing in kernel event
filtering through eBPF? This feature is something that I'd definitely
be interested in and perhaps also open to running with doing the
design/implementation. One of the really obvious filtering semantics
that immediately comes to mind for me would be to filter on expected
processes/binary images touching an expected set of files. Currently,
this level of filtering has traditionally been done in userspace, but
if we could offload that it'd be nice...

/M
