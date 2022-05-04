Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC96519744
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 08:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344852AbiEDGRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 02:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiEDGRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 02:17:02 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C23217051
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 23:13:28 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j9so330756qkg.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 May 2022 23:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+IWfkK7oJXhUk2Lnn9P524hIFSIrAG5TSuPhYiWH0Q=;
        b=bM5wL0MZZHtJfosNEelkzqLNSiIuxMtVyNQqmGC544ZlHtYjgmfVoophuq1QRKfqMj
         xm3TCNPkPi+TZ88UARLEkXkVqVnAStgmv+LvjkmJCE07ncMSWqUoqGBdNCHyX5TWUO6P
         5EH2bec11qchJXgtEcAJWGsAZSaUpPTRS+uahy/gBVLbhVuQv/VzgK4mZBEnf+vtyjt/
         H0OEmfJwkc4zKsHqL8DlhR7JNQqesUDmc+jFLFfW4jqQGTDK4gB4b6dSUr4qXrwVqTwu
         B8cqSac6rp53rkcj8MGImlmEVAAl72MY/HWO1vk0N4LpoIraVw8a0ckDXiLu5zKPVS/N
         po/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+IWfkK7oJXhUk2Lnn9P524hIFSIrAG5TSuPhYiWH0Q=;
        b=VQoMrT02phBWQKm32iC/Y39PzxinvCpUzWU5Lpi1V1nAvrHhgRyed87PMiDw9Vzojx
         jN9R/2IB3otqonYHYEDLPxj0WeUUQQkHzDnn+BWlFGFI28EPB7ewtSWBDjqFVFTvxN5s
         ICqs+E/1B8h/paa9SN3Xz2fp5S/BDi/KipgMUsbRxx4XgmTBboTylgAd6pGe4Ap5vU0K
         pUGVSGPhPbmN1ezXlGE2Yhaotzt/wf+wc3aR2aLZUIahL9QCayVHB/eU8COuB3nrHsGq
         AzaTHvXGzg5+AsTloqHhDPDr2n2rVLnOczjNO1QEWVYHKCYwYETQbWNUeNHH1dWQTw29
         omjQ==
X-Gm-Message-State: AOAM532sTQKmssdhut+HNBvEGEa7tFhJncJlbgrvuula6nLeYrtPJuPM
        Jo1pjEfdDduED7mr3Pn4+xug4krtCOuMff/WbLmDf7s7+TZmbQ==
X-Google-Smtp-Source: ABdhPJxxrP0BtJj4GgNILuXQlQKcQoApZiPz4i5KBeCBxqD+zZAHPhfwi7gASpt+9ARXjDIWuRdtRnhkuqVpmHdSRiA=
X-Received: by 2002:a05:620a:1aa0:b0:6a0:a34:15e0 with SMTP id
 bl32-20020a05620a1aa000b006a00a3415e0mr3231099qkb.19.1651644807224; Tue, 03
 May 2022 23:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan> <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
 <ff14ec84-2541-28c9-4d28-7e2ee13835dc@mail.de> <CAOQ4uxhry1_tW9NPC4X3q3YUQ86Ecg+G6A2Fvs5vKQTDB0ctHQ@mail.gmail.com>
 <8c636384-8db6-d7d1-b89b-424ef1accfe8@mail.de> <CAOQ4uxgLovYffU5epFy+r3qa7WjD9637YNuiFJHGj_du7H8gOA@mail.gmail.com>
 <20220303092459.mglgfvq653ge4k42@quack3.lan> <6799146c-fa5a-7b64-bb91-6038006cf612@mail.de>
In-Reply-To: <6799146c-fa5a-7b64-bb91-6038006cf612@mail.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 May 2022 09:13:15 +0300
Message-ID: <CAOQ4uxgXfL6_fi9rSf8_cUW0Lgbw8Rj_VcBOPiA5ec3PqBqo_Q@mail.gmail.com>
Subject: Re: [RFC] Volatile fanotify marks
To:     Tycho Kirchner <tychokirchner@mail.de>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 2, 2022 at 12:13 PM Tycho Kirchner <tychokirchner@mail.de> wrote:
>
> All right, I thought a bit more about that and returned to your
> original BPF idea you mentioned on 2020-08-28:
>
> > I was thinking that we could add a BPF hook to fanotify_handle_event()
> > (similar to what's happening in packet filtering code) and you could attach
> > BPF programs to this hook to do filtering of events. That way we don't have
> > to introduce new group flags for various filtering options. The question is
> > whether eBPF is strong enough so that filters useful for fanotify users
> > could be implemented with it but this particular check seems implementable.
> >
> >                                                               Honza
>
> Instead of changing fanotify's filesystem notification functionality,
> I suggest to rather **add a tracing mode (fantrace)**.
>
> The synchronous handling of syscalls via ptrace is of course required
> for debugging purposes, however that introduces a major slowdown (even
> with seccomp-bpf filters). There are a number of cases, including
> [1-3], where async processing of file events of specific tasks would be
> fine but is not readily available in Linux. Fanotify already ships
> important infrastructure in this regard: it provides very fast
> event-buffering and, by using file descriptors instead of resolved
> paths, a clean and race-free API to process the events later. However,
> as already stated, fanotify does not provide a clean way, to monitor
> only a subset of tasks. Therefore please consider the following
> proposed architecture of fantrace:
>
> Each taks gets its own struct fsnotify_group. Within
> fsnotify.c:fsnotify() it is checked if the given task has a
> fsnotify_group attached where events of interest are buffered as usual.
> Note that this is an additional hook - sysadmins being subscribed to
> filesystem events rather than task-filesystem-events are notified as
> usual - in that case two hooks possibly run. The fsnotify_group is
> extended by a field optionally pointing to a BPF program which allows
> for custom filters to be run.
>
> Some implementation details:
> - To let the tracee return quickly, run BPF filter program within tracer
>    context during read(fan_fd) but before events are copied to userspace
> - only one fantracer per task, which overrides existing ones if any
> - task->fsnotify_group refcount increment on fork, decrement on exit (run
>    after exit_files(tsk) to not miss final close events). When last task
>    exited, send EOF to listener.
> - on exec of seuid-programs the fsnotify_group is cleared (like in ptrace)
> - lazy check when event occurs, if listener is still alive (refcount > 1)
> - for the beginning, to keep things simple and to "solve" the cleanup of
>    filesystem marks, I suggest to disable i_fsnotify_marks for fantrace
>    (only allow FAN_MARK_FILESYSTEM), as that functionality can be
>    implemented within the user-provided BPF-program.
>

Maybe I am slow, but I did not understand the need for this task fsnotify_group.

What's wrong with Jan's suggestion? (add a BPF hook to fanotify_handle_event())
that hook is supposed to filter by pid so why all this extra complexity?

We may consider the option to have another BFP hook when reading
events if there is
good justification, but subtree filters will have to be in handle_event().

Thanks,
Amir.
