Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E9A6B09D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 14:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjCHNuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 08:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCHNuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:50:03 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1683E81CFA;
        Wed,  8 Mar 2023 05:50:02 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso1361234wmb.0;
        Wed, 08 Mar 2023 05:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678283400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fw1ybOndIbrrRfvAYzPl/haUKNAOK7/LNFeGJa5C17A=;
        b=TM835z/umscpO2GS4Z2UxobOoh2M9emTqm+nRPeWHtx4n44rsnPBo9HTt2JZgwYiLN
         hOPt5YYnSzwoQyTSDveBC7yrxlSjzlzn8SSY/VDcUqlukeuL2fXVpC/VYWkitDjrjGcH
         OXpvfVcsdxa7WJFjhIDK04kYmqSkyXf83V0vVIgNS4yLOYnJxj+ehCD+LIWbKgQk45BD
         AqqOeuO76An83Vl+EKcRQVzBR0iUdIJzmAC515HM3CvkjqCxTE0ex2hcO0E/f84UwwFj
         VKK7p2QgdmLdOv42OswM43nCO/j8GEwkpf8HGh6ETf7vdrOoYKGOPUjHwHWMYRtzkHXg
         iEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678283400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fw1ybOndIbrrRfvAYzPl/haUKNAOK7/LNFeGJa5C17A=;
        b=5xNOwKIVezPyeSuzu4rYvfYbokX87xWQnPf+sLKqcRFq/dVor1xE5uHqGp4pnTAq/d
         EM/g6F3m8tcdvY1+X+0nqtV9NbgGfUUXiA27ITmlYn0+PA6r7vo37p9V/RJOvHYUsMyF
         d4oSEyiLSe2g5stQ2fuKNrKMBbbLLUIWFYr20d1nP1aWbDiOBLIjoVcz4Mj6m5aEwNNO
         qV5/+hplFcttiYWWfjrMkF182CJ3U4MgeA+WGHbda4D/kMqfY+Rt0BbJf7RlS/9//10/
         brM5AIWYNYUGq9oT+GPPCfeLeTLZ3U+OJedo+9Bowd1BF7I21k3GvsPIsZ6+MpVNYw2B
         CWSg==
X-Gm-Message-State: AO0yUKVO8UdDcRGhJIsWmyf2Iq9BJUV16210BN5mTN+gaiaqhSUuCHy6
        AElLuX/Omjsd7LsrK92J0F4=
X-Google-Smtp-Source: AK7set/OJOwNtGT/PaElIGIyqo5Mldye4v822B33ypCNm7WfiKFmKdLzDkkbQcHN+5Bmw7+p7e0QQw==
X-Received: by 2002:a05:600c:4590:b0:3e2:2467:d3f5 with SMTP id r16-20020a05600c459000b003e22467d3f5mr15524629wmo.25.1678283400466;
        Wed, 08 Mar 2023 05:50:00 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b003dc434b39c7sm2613058wmo.0.2023.03.08.05.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:50:00 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 8 Mar 2023 14:49:57 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
        Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH RFC v2 bpf-next 5/9] selftests/bpf: Add read_buildid
 function
Message-ID: <ZAiShb3hVRlnGam0@krava>
References: <20230228093206.821563-1-jolsa@kernel.org>
 <20230228093206.821563-6-jolsa@kernel.org>
 <CAEf4BzZsOvvPJRt69vj+YCAJ1DAXgLSD0E3rfoMOLo3c6mSKiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZsOvvPJRt69vj+YCAJ1DAXgLSD0E3rfoMOLo3c6mSKiQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:22:51PM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 28, 2023 at 1:33 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding read_build_id function that parses out build id from
> > specified binary.
> >
> > It will replace extract_build_id and also be used in following
> > changes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/trace_helpers.c | 98 +++++++++++++++++++++
> >  tools/testing/selftests/bpf/trace_helpers.h |  5 ++
> >  2 files changed, 103 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> > index 09a16a77bae4..c10e16626cd3 100644
> > --- a/tools/testing/selftests/bpf/trace_helpers.c
> > +++ b/tools/testing/selftests/bpf/trace_helpers.c
> > @@ -11,6 +11,9 @@
> >  #include <linux/perf_event.h>
> >  #include <sys/mman.h>
> >  #include "trace_helpers.h"
> > +#include <linux/limits.h>
> > +#include <libelf.h>
> > +#include <gelf.h>
> >
> >  #define DEBUGFS "/sys/kernel/debug/tracing/"
> >
> > @@ -230,3 +233,98 @@ ssize_t get_rel_offset(uintptr_t addr)
> >         fclose(f);
> >         return -EINVAL;
> >  }
> > +
> > +static int
> > +parse_build_id_buf(const void *note_start, Elf32_Word note_size,
> > +                  char *build_id)
> > +{
> > +       Elf32_Word note_offs = 0, new_offs;
> > +
> > +       while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
> > +               Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
> > +
> > +               if (nhdr->n_type == 3 &&
> > +                   nhdr->n_namesz == sizeof("GNU") &&
> > +                   !strcmp((char *)(nhdr + 1), "GNU") &&
> > +                   nhdr->n_descsz > 0 &&
> > +                   nhdr->n_descsz <= BPF_BUILD_ID_SIZE) {
> > +                       memcpy(build_id, note_start + note_offs +
> > +                              ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
> > +                              nhdr->n_descsz);
> > +                       memset(build_id + nhdr->n_descsz, 0,
> > +                              BPF_BUILD_ID_SIZE - nhdr->n_descsz);
> 
> I won't count :) but if something fits within 100 characters, please
> keep it on single line

copy&paste from kernel code ;-) I'll reformat that

SNIP

> > diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
> > index 53efde0e2998..50b2cc498ba7 100644
> > --- a/tools/testing/selftests/bpf/trace_helpers.h
> > +++ b/tools/testing/selftests/bpf/trace_helpers.h
> > @@ -4,6 +4,9 @@
> >
> >  #include <bpf/libbpf.h>
> >
> > +#define ALIGN(x, a)            __ALIGN_MASK(x, (typeof(x))(a)-1)
> > +#define __ALIGN_MASK(x, mask)  (((x)+(mask))&~(mask))
> 
> nit: I know these are macros, but why would you first use __ALIGN_MASK
> and then #define it? swap them?

same reason as above, I'll swap that

thanks,
jirka
