Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7466BDBCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 23:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCPWhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 18:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCPWhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:37:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0773DC0B3;
        Thu, 16 Mar 2023 15:36:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z21so13648821edb.4;
        Thu, 16 Mar 2023 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679006218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDnCsGM/FV1yfEUIqdP+WO9uXlOSf1wmfPkNbc+Ep1A=;
        b=ij85mTrQsntyqaM6cYuQUcOw0ZVEZaogn+UmtL4AdzKsjIpIykVVEc9T6NaoHuSvFn
         qD5fBvBqM4pVlBiGKwVOang8C1VcmLu0t936OUjLkRl5Ncv/21XOHsFhl3BhGRopkJ0i
         CprpN/fg55PCEhGt84hVw2ojJHBdULh01mjLVDfBFcLZ3/UesQBOx0EWab76TTpaN4hJ
         Gv0AdjlgBN9Ft7BZkZ08+kYX9AGR6MrGWY//APrptfEuaoU07bwqvCjsKdZOg4mLzvVn
         wCUKhdj74B1mdK4nIveVEfIc45r3R2s0whRYhcLvV/MWBNeuaggNKngOnWpmIodrP+BY
         aHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679006218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDnCsGM/FV1yfEUIqdP+WO9uXlOSf1wmfPkNbc+Ep1A=;
        b=HLLQ4N0sIhuhEmUl+dmthoa0J3LEn1QsH5SJd4rysyjoPT08syUKs+1GluhQbvxoYT
         E1KaV2ODpsWO3dj2RsqfKDX3HSfJAmXei0dXqRPmFyVREkwLxuarWabF9tyUtVgbUmDy
         Z3xM5NsUoG1AwMCx28CDS/lmSz3XwfltzipTdc8icuAiNlU8w2Vg5GaMWVRNcoPytHGY
         9VGA0/rGy+hqQHfeibvHcPQp/NJ76ttuE8ekqbjdVeZ0vm+vImMoWfUebOmYz2ojIJER
         7BHiMvlwP5sRtGVkSwunVAyGXoRQQBfULSSgLhPJ4zy1wZNfb4JtxQsPt0Zh6YJhZcbK
         wkQA==
X-Gm-Message-State: AO0yUKXkyXTF3OxT28uj9u+jFTLt3X8os0ShaI2M9qxCI8hPgX69ssve
        h+kPGsIOmXJhM88luliE/ooOZPAldpVGIm08WoI=
X-Google-Smtp-Source: AK7set/fYofBPE5FDtJ+WwJR9R3P0GNPMgNfhVh7QImSlv+fd8oGgSx09RSedQu6am3rrZne9IkTLIcoG7c1+0R1TTk=
X-Received: by 2002:a50:8e14:0:b0:4fb:f19:883 with SMTP id 20-20020a508e14000000b004fb0f190883mr683888edw.1.1679006218096;
 Thu, 16 Mar 2023 15:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <20230316170149.4106586-10-jolsa@kernel.org>
In-Reply-To: <20230316170149.4106586-10-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Mar 2023 15:36:46 -0700
Message-ID: <CAEf4BzaXRXZ7u3Pj2zsS9tXB-j8GtovK5rveVke=5KYTj2DdMA@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 9/9] selftests/bpf: Add file_build_id test
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
> The test attaches bpf program to sched_process_exec tracepoint
> and gets build of executed file from bprm->file object.

typo: build ID

>
> We use urandom_read as the test program and in addition we also
> attach uprobe to liburandom_read.so:urandlib_read_without_sema
> and retrieve and check build id of that shared library.
>
> Also executing the no_build_id binary to verify the bpf program
> gets the error properly.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile          |  7 +-
>  tools/testing/selftests/bpf/no_build_id.c     |  6 ++
>  .../selftests/bpf/prog_tests/file_build_id.c  | 98 +++++++++++++++++++
>  .../selftests/bpf/progs/file_build_id.c       | 70 +++++++++++++
>  tools/testing/selftests/bpf/test_progs.h      | 10 ++
>  5 files changed, 190 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/no_build_id.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/file_build_id.=
c
>  create mode 100644 tools/testing/selftests/bpf/progs/file_build_id.c
>

Looks good, but let's add CONFIG_FILE_BUILD_ID to
selftests/bpf/config, as Daniel mentioned.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
