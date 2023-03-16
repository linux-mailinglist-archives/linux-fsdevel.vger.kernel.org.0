Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ADE6BDB22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 22:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCPVwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 17:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCPVwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:52:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9466CC30F;
        Thu, 16 Mar 2023 14:52:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h8so13223714ede.8;
        Thu, 16 Mar 2023 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679003525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtfiY/9Ts/lxuhuIdPnRLbTi5IvroJVQJHVG9Rqr+Bg=;
        b=PoXtj1HJ3nrMs24bTw7Qvq7nChyhyYPmubiruUJPAEJ70lvXIjOlzac5InPDksRn7i
         g0aTSuSv2ZdeQDmUNfAP0ynTLMuNjgD5TA7t7p/zrq6jiiqjkLyrJed7r4QtZGCz773h
         mHmvNU3eDFVPpiqtKMb224poxmWOdQyoVTEFGcLtmv12HsHobRnt81GCeC1yOpu7LZ0O
         l9kQuz2RB5jFR3IrBjJIV1yYe86PeTOMu1ffEgQ7MQ+pjCE/3p1AqwQH8kWZDBMU6oQt
         3kNadT6eMf3Q6rQWqZ5qnjyRNU77QxSgP1cdp/w0otNSQ4KFBfD3EQc45LstN16nNTka
         IaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679003525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtfiY/9Ts/lxuhuIdPnRLbTi5IvroJVQJHVG9Rqr+Bg=;
        b=5SvdwXiL0OmZjCsa9SLkIdUFcgHVLAN3YKlJXfRzNjiOFrLFZmbCOs05Z1ckPSBCy4
         Hw6b8QMD3wMh5XnUltCYvJP0O7AhCVOwRc6talSFrbG8LjbTLv2J2IbP45E2ieDZEZSP
         Qgj1uGJEUMmgL96gEGNpLRKQBc+d03/eEau6w/Uya6/NXxAUlb821osBBAnzTrZeLAxI
         +ggO6hmNX5tDUrJ6X6CL1Gz40r4FMuymop4FIjOUIhf0LY58usl1wKZAkKzlt/pj2Rin
         mZil/kqnxlq2nlyIhJ0dBBaW6euEwW5NXrewEicDwttiKVNGjzHtbsxZclVSfCJzkToD
         fa1Q==
X-Gm-Message-State: AO0yUKWoMw1c8cajf77oIjVMZSmCQS7gCZdAjG31MrvfPeB+mOOuU53o
        b7B5jRsnpxXIKhyOKZR2KWkQ+69LHW8TRSfxVo0=
X-Google-Smtp-Source: AK7set+JHSJCpQhlouI1fR8tmdBnrXTHcd+1Y5inVf/QAlkKqOBIrzQH16xoTjuF0I2vgt3/7fxuTJfLifCY5KSGxyY=
X-Received: by 2002:a17:906:bc51:b0:923:6595:a81b with SMTP id
 s17-20020a170906bc5100b009236595a81bmr6185367ejv.5.1679003525011; Thu, 16 Mar
 2023 14:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <ZBNTMZjEoETU9d8N@casper.infradead.org>
 <CAP-5=fVYriALLwF2FU1ZUtLuHndnvPw=3SctVqY6Uwex8JfscA@mail.gmail.com>
In-Reply-To: <CAP-5=fVYriALLwF2FU1ZUtLuHndnvPw=3SctVqY6Uwex8JfscA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Mar 2023 14:51:52 -0700
Message-ID: <CAEf4BzYgyGTVv=cDwaW+DBke1uk_aLCg3CB_9W6+9tkS8Nyn_Q@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
To:     Ian Rogers <irogers@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 10:50=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Mar 16, 2023 at 10:35=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Thu, Mar 16, 2023 at 06:01:40PM +0100, Jiri Olsa wrote:
> > > hi,
> > > this patchset adds build id object pointer to struct file object.
> > >
> > > We have several use cases for build id to be used in BPF programs
> > > [2][3].
> >
> > Yes, you have use cases, but you never answered the question I asked:
> >
> > Is this going to be enabled by every distro kernel, or is it for specia=
l
> > use-cases where only people doing a very specialised thing who are
> > willing to build their own kernels will use it?
> >
> > Saying "hubble/tetragon" doesn't answer that question.  Maybe it does
> > to you, but I have no idea what that software is.
> >
> > Put it another way: how does this make *MY* life better?  Literally me.
> > How will it affect my life?
>
> So at Google we use build IDs for all profiling, I believe Meta is the
> same but obviously I can't speak for them. For BPF program stack

Yep, Meta is also capturing stack traces with build ID as well, if
possible. Build IDs help with profiling short-lived processes which
exit before the profiling session is done and user-space tooling is
able to collect /proc/<pid>/maps contents (which is what Ian is
referring to here). But also build ID allows to offload more of the
expensive stack symbolization process (converting raw memory addresses
into human readable function+offset+file path+line numbers
information) to dedicated remote servers, by allowing to cache and
reuse preprocessed DWARF/ELF information based on build ID.

I believe perf tool is also using build ID, so any tool relying on
perf capturing full and complete profiling data for system-wide
performance analysis would benefit as well.

Generally speaking, there is a whole ecosystem built on top of
assumption that binaries have build ID and profiling tooling is able
to provide more value if those build IDs are more reliably collected.
Which ultimately benefits the entire open-source ecosystem by allowing
people to spot issues (not necessarily just performance, it could be
correctness issues as well) more reliably, fix them, and benefit every
user.

> traces, using build ID + offset stack traces is preferable to perf's
> whole system synthesis of mmap events based on data held in
> /proc/pid/maps. Individual stack traces are larger, but you avoid the
> ever growing problem of coming up with some initial virtual memory
> state that will allow you to identify samples.
>
> This doesn't answer the question about how this will help you, but I
> expect over time you will see scalability issues and also want to use
> tools assuming build IDs are present and cheap to access.
>
> Thanks,
> Ian
