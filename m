Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A55F6BDB9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 23:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCPW02 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 18:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCPW01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:26:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593941B564;
        Thu, 16 Mar 2023 15:25:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z21so13554484edb.4;
        Thu, 16 Mar 2023 15:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679005478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzi3EGx3mzrGU9iTISeTb63Fgg6MhSomZdBCL7cyj+o=;
        b=XOaHYas9FnoBdxMnckbXMyhlvgIiZD9s8VYjd7j36wNR2Ma7cBcP8tAHDMwhNVybMr
         1GIgZssARR2HlpUNKBCqs/QzLVEmx32Cgm8/RL1DaAxMvbeVeRND0uUxsTjGXPkRa4kV
         8eE5TmiqE74jzN/dFZOrKVFt05Hq9iixRQYpX+1MGr7NVwZjy36PlIpLZKEI34T/FAR3
         vQG8B/E1LzUxP9zIOcFuyUuikguVGk/iCw0cfEKfxI/Tv4uYM/FELMLQdSlTtDzZX/gi
         Yf+tMhpy7xhgIGQQ90MVVxkBrIslOdglP+R7bVYVsgsdmPg4+1BwOJySZELq0lgp1VzM
         DI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679005478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzi3EGx3mzrGU9iTISeTb63Fgg6MhSomZdBCL7cyj+o=;
        b=zEsQ4bs6omhUkFzHVnbyNcNKg1QSE9LSgBSlN1Wfs7I+BueDrgAYK8RCDoWdQHYb7S
         +Wwmcrlf32EZWksWdWKyWRk6/2iUKngnsvaYwqWVfZvhXE77TvPUevB35NlwabpKe12W
         ll33JxKjUgT36ncyiAzyeMIMvW8R/QHe1BJ0Ol4D0Cc4MDvkDCOUjqLaXq6Zo6Oe7k4S
         elTk+wNYHqXNb+nj0lYjYhtBcljD8u0kQhTY8IN/eOo2NBt7s1DakfENJJd2uQ39U8VL
         ijxjjyoeQRR8f3Qetxke8w26r6AMpp4Zk/7eX+f9J8YDWT/jelfCjeVC7jofHp2KyEj8
         6wUw==
X-Gm-Message-State: AO0yUKUtjSl6X2ffjBIJZO6gJSjbo2UEvdS67YyDk+nk0nN+FAYZP51b
        QfPOERCmBx45WFg+3tYTmEefZbq0I924rR4oG9I=
X-Google-Smtp-Source: AK7set/8FXe5X4wxvGnF2bgiUFbJrM4Ml9npaabQIr2UDGdKxgo1k7jOCD0lBqj3mxfbfSUdmEHxEJODRhJFGYNzcm0=
X-Received: by 2002:a17:906:ccd1:b0:930:310:abf1 with SMTP id
 ot17-20020a170906ccd100b009300310abf1mr2482731ejb.5.1679005477747; Thu, 16
 Mar 2023 15:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <20230316170149.4106586-7-jolsa@kernel.org>
In-Reply-To: <20230316170149.4106586-7-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Mar 2023 15:24:25 -0700
Message-ID: <CAEf4BzbhD3r=1bio=0RNG82ESU_7Gz_T1rdmPyKcoDWvpsOWTg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 6/9] selftests/bpf: Add err.h header
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
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

On Thu, Mar 16, 2023 at 10:03=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Moving error macros from profiler.inc.h to new err.h header.
> It will be used in following changes.
>
> Also adding PTR_ERR macro that will be used in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/progs/err.h        | 18 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/profiler.inc.h |  3 +--
>  2 files changed, 19 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/err.h
>

[...]
