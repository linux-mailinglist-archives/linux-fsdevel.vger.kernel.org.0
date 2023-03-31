Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607156D296C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 22:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjCaU2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 16:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaU2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:28:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78314B76C;
        Fri, 31 Mar 2023 13:27:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t10so94193103edd.12;
        Fri, 31 Mar 2023 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680294478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GK0MF0uNmzEytcPCm/B24vsna4+KtlPH2hXHihrk2Pg=;
        b=a/Ja9f9xnk268bxONMh+OrG/q2neNdI+XZOeSE0+gdJLLPyDUH7YsRtBloLv7Tx9Lx
         2djuie1urUE8cShkZloYXQjcgj99w0IxdWx6FkeISv+u+Ha1n6hUOk15wyK8p2snyqcw
         fikUhuKOMKa5WgA4BaKYp70euRK7kdjWxVyAuwEhLiJEmNv2fqZfD1RoTUCY5TwE9A29
         gfgkovrzvAvyS1CDUPEG43I6Hwngd15jU5eDD3DKPe1rlro5tvYt5jUY5Nam5MQYpvGL
         fROJ3HiGFUgcXzuoeFBPXAkV9d0ZdoTjeE77LprD3k1S96+wHJssIUgoAyqS4y268JCP
         8uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GK0MF0uNmzEytcPCm/B24vsna4+KtlPH2hXHihrk2Pg=;
        b=R2oiH3muFMo63MgBWfPi60L7pHdgyZoj2nPKQpZjljWaanAQYGXfWdViAu0/JmvMq7
         40TS8OojVXvrmHgHw03xYl5UceByIDx5xzjqA09+hpP6qifiHje2ZjJr/WecR695ZVdg
         9Ij6iTYB5l0IexHqWLgsC1c5tUh1w2w1Tnacyg2GG5/odexM8pcmz8wDjQ/1/byM47aR
         QmXg2JgNOR74Hca/VQPsiJ3w0G79JRH/X8EWWdoku9uE+oLKMUmN+/0YJcw5ywrMv7Y4
         GF5er0LV79u3WphQzhird8IiLwReymku8THaQHysByRPw9ro4dFWiB1oKgRrJpHhJqYJ
         Tn0A==
X-Gm-Message-State: AAQBX9dv2aGL6HeC+yoNLVP8B2faIhTa/Q8VlaiNhK8ap4vFgfMGfhqU
        Bh3S4YdTb0G/NCfjNEartVTz2gwUntyCg5WwO1U=
X-Google-Smtp-Source: AKy350aujevccavshd57e5DTjfc6arS/wKqQ78BHDMvmLt/9c+KO7t8cHimGhGNrYQFNiE3Yn8wTcaUYy+D9jbsyOvQ=
X-Received: by 2002:a50:d58c:0:b0:502:719e:e7e9 with SMTP id
 v12-20020a50d58c000000b00502719ee7e9mr3286257edi.1.1680294477852; Fri, 31 Mar
 2023 13:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <ZBNTMZjEoETU9d8N@casper.infradead.org>
 <ZBV3beyxYhKv/kMp@krava> <ZBXV3crf/wX5D9lo@casper.infradead.org>
 <ZBsihOYrMCILT2cI@kernel.org> <CAEf4BzakHh3qm2JBsWE8qnMmZMeM7w5vZGneKAsLM_vktPbc9g@mail.gmail.com>
 <ZCcoLcncAVeKOZRL@casper.infradead.org>
In-Reply-To: <ZCcoLcncAVeKOZRL@casper.infradead.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 31 Mar 2023 13:27:45 -0700
Message-ID: <CAEf4Bzbb-NfyXjvkPSGq_akSD4zwvwiVETaJuo2Gu_T+_6bStA@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, bpf@vger.kernel.org,
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:36=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Mar 31, 2023 at 11:19:45AM -0700, Andrii Nakryiko wrote:
> > On Wed, Mar 22, 2023 at 8:45=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > > Having said that, it seems there will be no extra memory overhead at
> > > least for a fedora:36 x86_64 kernel:
> >
> > Makes sense to me as well. Whatever the solution, as long as it's
> > usable from NMI contexts would be fine for the purposes of fetching
> > build ID. It would be good to hear from folks that are opposing adding
> > a pointer field to struct file whether they prefer this way instead?
>
> Still no.  While it may not take up any room right now, this will
> surely not be the last thing added to struct file.  When something
> which is genuinely useful needs to be added, that person should
> not have to sort out your mess first,

So I assume you are talking about adding a pointer field to the struct
file, right? What about the alternative proposed by Arnaldo to have a
struct exec_file that extends a struct file?

>
> NAK now, NAK tomorrow, NAK forever.  Al told you how you could do it
> without trampling on core data structures.

As I replied to Al, any solution that will have a lookup table on the
side isn't compatible with usage from NMI context due to locking. And
lots of tracing use cases are based on perf counters which are handled
in NMI context. And that's besides all the complexities with
right-sizing hash maps (if hashmaps are to be used).
