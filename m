Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21BB6BEE63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 17:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCQQde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 12:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCQQdd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:33:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EB733CE9;
        Fri, 17 Mar 2023 09:33:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z21so22702718edb.4;
        Fri, 17 Mar 2023 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679070810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOc1064wJwVxntbc0Hg4Pm5Z8bh8eNRp/vDpjqeTV8A=;
        b=npLaYxhqDOo4k6OjTdGIDQG0WQfkgtv9fM6BdKrkgn40eFBPLGXHs3yWzljccmyqFp
         9ZPFV+7u4iptswc+firC3lJ9YhcygL+/3eHPtfo5wxoGAuB4gYp2xWIsUES5cUTFkq++
         xz8PToZXfHlOeG7TmrhhOx53Nog+9wC2ylbmAmjZmwpEN170qmKZukfxhjUX8GuEyda9
         nJ8Vns+osPqA4HvBdp+PUjkFpCKf/cu1P/jPkbynrcOTe2VmLIAaObRntsQY90dkhDaY
         cqg/85OMC1OnxVBzE8PYrjQwnyNgcTf7/05NJ9SZNG0+tn97Fo0kTnS/LwY63/7nMi5p
         3P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679070810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOc1064wJwVxntbc0Hg4Pm5Z8bh8eNRp/vDpjqeTV8A=;
        b=hnjnVungEnlFTLIz1SaL0yAbsiOe4s7SehpwgjIObnvWCX9F1Dpf4u1PcJ50cOW4yK
         obhi3yRoJVQ/eG9BcdvrowI0yAHzMv68QZWiSqnrtGO8YXnIOsu07g6TQpvCGPqzMfIT
         YYp2CKN3h3HY55CNw7pGKS9Gy8b4EMHBUsZMrO6Epw7x7Zv9jXHj6iNwjGlBuLPAJAQe
         XDNmZAfpF5NuugBlpT2r6hRCdW2mY7SfH9JrPy6NxRyiGNCW1nS2c55MVnWTtRjqZgW8
         9cOom/3BIB8HJ8UftedSqS31AE44WA2TelYduKoi0HPOCFiynXNJCX/p4Zfg3roMpy6u
         UcIg==
X-Gm-Message-State: AO0yUKXBX2gl9X+5eB/2KawHOAMQLxkzFtY79gUFnT52ExWlqtvY0m0q
        5H2yFp9Gk238N/9Rg8XjPfsuyROOOzQnRxpJtjY=
X-Google-Smtp-Source: AK7set+0ohyPqN6E5Ro9SkqCqggHHZv4+NXE5j4GuR8AQ+M1h80H52LGa3htbnGp0mJWOjTgUhvmwUwf1sMfqR3ewCU=
X-Received: by 2002:a17:906:8552:b0:8ab:b606:9728 with SMTP id
 h18-20020a170906855200b008abb6069728mr7694310ejy.5.1679070809653; Fri, 17 Mar
 2023 09:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <ZBNTMZjEoETU9d8N@casper.infradead.org>
 <CAP-5=fVYriALLwF2FU1ZUtLuHndnvPw=3SctVqY6Uwex8JfscA@mail.gmail.com>
 <CAEf4BzYgyGTVv=cDwaW+DBke1uk_aLCg3CB_9W6+9tkS8Nyn_Q@mail.gmail.com> <ZBPjs1b8crUv4ur6@casper.infradead.org>
In-Reply-To: <ZBPjs1b8crUv4ur6@casper.infradead.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 09:33:17 -0700
Message-ID: <CAEf4BzbPa-5b9uU0+GN=iaMGc6otje3iNQd+MOg_byTSYU8fEQ@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
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

On Thu, Mar 16, 2023 at 8:51=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Mar 16, 2023 at 02:51:52PM -0700, Andrii Nakryiko wrote:
> > Yep, Meta is also capturing stack traces with build ID as well, if
> > possible. Build IDs help with profiling short-lived processes which
> > exit before the profiling session is done and user-space tooling is
> > able to collect /proc/<pid>/maps contents (which is what Ian is
> > referring to here). But also build ID allows to offload more of the
> > expensive stack symbolization process (converting raw memory addresses
> > into human readable function+offset+file path+line numbers
> > information) to dedicated remote servers, by allowing to cache and
> > reuse preprocessed DWARF/ELF information based on build ID.
> >
> > I believe perf tool is also using build ID, so any tool relying on
> > perf capturing full and complete profiling data for system-wide
> > performance analysis would benefit as well.
> >
> > Generally speaking, there is a whole ecosystem built on top of
> > assumption that binaries have build ID and profiling tooling is able
> > to provide more value if those build IDs are more reliably collected.
> > Which ultimately benefits the entire open-source ecosystem by allowing
> > people to spot issues (not necessarily just performance, it could be
> > correctness issues as well) more reliably, fix them, and benefit every
> > user.
>
> But build IDs are _generally_ available.  The only problem (AIUI)
> is when you're trying to examine the contents of one container from
> another container.  And to solve that problem, you're imposing a cost
> on everybody else with (so far) pretty vague justifications.  I really
> don't like to see you growing struct file for this (nor struct inode,
> nor struct vm_area_struct).  It's all quite unsatisfactory and I don't
> have a good suggestion.

There is a lot of profiling, observability and debugging tooling built
using BPF. And when capturing stack traces from BPF programs, if the
build ID note is not physically present in memory, fetching it from
the BPF program might fail in NMI (and other non-faultable contexts).
This patch set is about making sure we always can fetch build ID, even
from most restrictive environments. It's guarded by Kconfig to avoid
adding 8 bytes of overhead to struct file for environment where this
might be unacceptable, giving users and distros a choice.
