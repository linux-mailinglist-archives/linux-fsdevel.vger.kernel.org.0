Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A8E4689D7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Dec 2021 08:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhLEH3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Dec 2021 02:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhLEH3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Dec 2021 02:29:30 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0065AC061751;
        Sat,  4 Dec 2021 23:26:02 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id m186so8129175qkb.4;
        Sat, 04 Dec 2021 23:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zowSszGCjMgYZHdPz1ZCQ1VnEOEblLnUPR7Gj0ga0Vs=;
        b=H8L2+8nVJ1TzoM56VfiynvmoGFyaKEcyjMd1peEexDpDjB9ClTekh46kJx5dHglpsN
         LEnfx63YLMZOjFknCW+9ZNJocppmoS3NwNLzYuv7CvaeJvq0RXniwrT+olAZ9h/3aOD/
         8VL6fGXO3kxlVOTdYGfWjhHcWlb/AN0MEBYJ1H+8lrYCxV1yN63EAYVLHaDO1k4OrLQ4
         vVQppnxQ5JynrTKFam9ElX1hiZGq1BA6v4jh9D/Al6M140wUyxGa2TtFyVM9On32QaXP
         rhe+1LJWKyiL9g6Ddc8BJQNrENHUyco6Kyd2O+6yZ7lo0TWWojZGsKlKtFsUy97h2MbY
         VjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zowSszGCjMgYZHdPz1ZCQ1VnEOEblLnUPR7Gj0ga0Vs=;
        b=XK+sOOWQoZ2OgnQeNcEJX6b1jNKf9Rv7K/Bx3CsgFzac85gbyNv6e479Uc1PsfawJp
         kuFf6hNCWQdRcmfCBvCAVJZ33I0pY8bFUejfEm5lamQLlXuGg+1rvBUvxv0MMOKxadMN
         8ZRBCJBakwr0YTwb49dvwgkvEAso/qifN1jaYk/DFmHFtanTQ8vl9kHHFto6njqC+8ZJ
         s4bgttFNsHyw8Wz03sFAN/WJWwLcWvfzTxqULOtwxN+4NA9VUTShAMDBzIwSGfPeby+9
         KGrJFjUlB28nBRak6xg5mptFtH4ABhzWhUiXPaPB1bmTHoJTjaAGtNK+jHq2v8/H2DQV
         mlng==
X-Gm-Message-State: AOAM533maehMG5PBkGcqcz66WpuRv4zoRGIic4ZAYWHCrGIdlex2YCxi
        t2E5euImzsyOml2EdrFA03ncQ0E86Fh+7vkirkA=
X-Google-Smtp-Source: ABdhPJxJLKvaTSR4/NERlECHBcz96OgqGrG1jCo7M7WsfQN7m2yL5KJ1ECd+GDH+HUX2k6HIT1BhZZN0LElX5ftUrQ4=
X-Received: by 2002:a05:620a:2148:: with SMTP id m8mr26529583qkm.435.1638689161996;
 Sat, 04 Dec 2021 23:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20211204095256.78042-1-laoar.shao@gmail.com> <20211204095256.78042-6-laoar.shao@gmail.com>
 <CAADnVQLS4Ev7xChqCMbbJiFZ_kYSB+rbiVT6AJotheFJb1f5=w@mail.gmail.com>
 <CALOAHbCud62ivvoRuz1SV-d3sL9Y9knEga0N-jiXnM3SYzWxNA@mail.gmail.com> <CAADnVQLu+RWSeMfOe5eBuTsp9gxPsFC_bRTXoWmvWP+Lv_rZzQ@mail.gmail.com>
In-Reply-To: <CAADnVQLu+RWSeMfOe5eBuTsp9gxPsFC_bRTXoWmvWP+Lv_rZzQ@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 5 Dec 2021 15:25:27 +0800
Message-ID: <CALOAHbBv-_5uF=T4MyC_6J08PRX6KTGora4FArdYKLC0dOy8HQ@mail.gmail.com>
Subject: Re: [PATCH -mm 5/5] bpf/progs: replace hard-coded 16 with TASK_COMM_LEN
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 5, 2021 at 11:13 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Dec 4, 2021 at 6:45 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Sun, Dec 5, 2021 at 12:44 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Dec 4, 2021 at 1:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > >  static int process_sample(void *ctx, void *data, size_t len)
> > > >  {
> > > > -       struct sample *s = data;
> > > > +       struct sample_ringbuf *s = data;
> > >
> > > This is becoming pointless churn.
> > > Nack.
> > >
> > > > index 145028b52ad8..7b1bb73c3501 100644
> > > > --- a/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
> > > > +++ b/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
> > > > @@ -1,8 +1,7 @@
> > > >  // SPDX-License-Identifier: GPL-2.0
> > > >  // Copyright (c) 2019 Facebook
> > > >
> > > > -#include <linux/bpf.h>
> > > > -#include <stdint.h>
> > > > +#include <vmlinux.h>
> > > >  #include <stdbool.h>
> > > >  #include <bpf/bpf_helpers.h>
> > > >  #include <bpf/bpf_core_read.h>
> > > > @@ -23,11 +22,11 @@ struct core_reloc_kernel_output {
> > > >         int comm_len;
> > > >  };
> > > >
> > > > -struct task_struct {
> > > > +struct task_struct_reloc {
> > >
> > > Churn that is not even compile tested.
> >
> > It is strange that I have successfully compiled it....
> > Below is the compile log,
> >
> > $ cat make.log | grep test_core_reloc_kernel
> >   CLNG-BPF [test_maps] test_core_reloc_kernel.o
> >   GEN-SKEL [test_progs] test_core_reloc_kernel.skel.h
> >   CLNG-BPF [test_maps] test_core_reloc_kernel.o
> >   GEN-SKEL [test_progs-no_alu32] test_core_reloc_kernel.skel.h
> >
> > Also there's no error in the compile log.
>
> and ran the tests too?

My bad. I thought it was just a name change, which will work well if
it can be compiled successfully.
But it seems the task_struct in this file is a dummy struct, which
will be relocated to the real task_struct defined in the kernel.
We can't include vmlinux.h in this file, as it is for the relocation test.

-- 
Thanks
Yafang
