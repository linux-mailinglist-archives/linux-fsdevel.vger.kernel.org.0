Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0C0575924
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 03:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiGOBjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 21:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiGOBjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:39:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9613242AD4
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 18:39:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e63-20020a253742000000b0066e1afdb46aso2943642yba.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 18:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mAeXqOZZBVPdbq4yhQiUP5VN0GJajqrt77b0GTm8ddQ=;
        b=JfY/dZhiys1bZY5EGSfSj6NS3oNMqRabw0VWDSE9yIeZMDLkSZqc+2FvMnzpS4MNgZ
         XOFzz5TtApvGzeW/vTh65Ag9cCAWr3OBzN4gAv4CDkN+voEmvI9EdsHqA7vo7vvm4OyG
         kgPnXqIerO7mSCxfm6ZLl7CSkBrXFSl32yXeRbVtior4ZdkP6BQJmSFZqNdYcm3LxDyl
         j9UFszpl2EpD+Pge2UyrwQcfprrMB0rwLkicdT4Eeak3RDQO1ugIpwyxBjErKRLN+CEp
         XJMbd3u4sWaJP27ptJxp7gFOIRpGqWZVCj56XMU8IayCbz29K0X7EcS9njUklygLxjva
         DvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mAeXqOZZBVPdbq4yhQiUP5VN0GJajqrt77b0GTm8ddQ=;
        b=6RMH7rRuEPq6S/i7xM7GIS7Nrd6VeT1PvVjN7WgkYWDNB72T2ipDtXIJR5ip460+S2
         PUa04L2EPdA73G+FLyKbNKZpPW96jyKBGfpgr1WTPJiECq5JsfNIyOmQuHfhGlUL1pya
         lsGqpeaYvrX2gLegueTnNagYwGx6oTuPjq9V1gIjc3AATD5b6cVNAKqh2SqZ6F+vuaG1
         8ojAynVi6fwsCy3yzRz/zACcqf0Gl2EQNGJ3168FKnENY9b0WFcCroQpasHlNwsk8fjP
         5tg63iAZnYQ8o0rV/sq75UtvRJZkswTlsPGf+DoSs+34VnKh8OJRlgsU3lseL2yBMpBs
         2Tyg==
X-Gm-Message-State: AJIora8NVU705keQ89SOFuuv3avjLklXWhkQuHYrbCN52HmH9SzwVVmo
        PI6xOPL8kqIEMEijkXCjfRMO1oQcyFV+Nw==
X-Google-Smtp-Source: AGRyM1twMADmukVDHq0OwkYLBQBbC2d2LlX8VOPaRlImf1uqHpMX5qVQPJ25TQtBfNyXY015rkJIjGLC0J2OxQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:a2ca:0:b0:66e:719e:279 with SMTP id
 c10-20020a25a2ca000000b0066e719e0279mr11067587ybn.622.1657849150783; Thu, 14
 Jul 2022 18:39:10 -0700 (PDT)
Date:   Fri, 15 Jul 2022 01:39:08 +0000
In-Reply-To: <534fa596-0c29-0f1e-b292-53ad9c3dbbe3@I-love.SAKURA.ne.jp>
Message-Id: <20220715013908.ayyimue5yhfwonho@google.com>
Mime-Version: 1.0
References: <000000000000471c2905e3c2c2c2@google.com> <20220714141813.yi5p4o2tiyvkao6b@quack3>
 <534fa596-0c29-0f1e-b292-53ad9c3dbbe3@I-love.SAKURA.ne.jp>
Subject: Re: [syzbot] possible deadlock in start_this_handle (3)
From:   Shakeel Butt <shakeelb@google.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 15, 2022 at 07:24:55AM +0900, Tetsuo Handa wrote:
> On 2022/07/14 23:18, Jan Kara wrote:
> > Hello,
> > 
> > so this lockdep report looks real but is more related to OOM handling than
> > to ext4 as such. The immediate problem I can see is that
> > mem_cgroup_print_oom_meminfo() which is called under oom_lock calls
> > memory_stat_format() which does GFP_KERNEL allocations to allocate buffers
> > for dumping of MM statistics. This creates oom_lock -> fs reclaim
> > dependency and because OOM can be hit (and thus oom_lock acquired) in
> > practically any allocation (regardless of GFP_NOFS) this has a potential of
> > creating real deadlock cycles.
> > 
> > So should mem_cgroup_print_oom_meminfo() be using
> > memalloc_nofs_save/restore() to avoid such deadlocks? Or perhaps someone
> > sees another solution? Generally allocating memory to report OOM looks a
> > bit dangerous to me ;).

mem_cgroup_print_oom_meminfo() is called only for memcg OOMs. So, the
situaion would be dangerous only if the system is also OOM at that time.

> > 
> > 								Honza
> 
> I think mem_cgroup_print_oom_meminfo() should use GFP_ATOMIC, for it will fall into
> infinite loop if kmalloc(GFP_NOFS) under oom_lock reached __alloc_pages_may_oom() path.

I would prefer GFP_NOWAIT. This is printing info for memcg OOMs and if
the system is low on memory then memcg OOMs has lower importance than
the system state.
