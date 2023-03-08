Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63DA6B09D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 14:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCHNvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 08:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjCHNvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:51:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E711B8F718;
        Wed,  8 Mar 2023 05:51:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so1197839wmq.1;
        Wed, 08 Mar 2023 05:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678283472;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2a7IZeMYO9n6PXhDENMf/0WN13+dEVs/avcgaXRcG/k=;
        b=A4NTo7Z6YDgzCwMQESROwQaWS7+cg9Iy1ytO1f0y336fkSDEYoFEwSWHuMio2AeImv
         bRKfQOPZS7v7R8U6HmQRtcOA2GmhZ7dXgMzYNjo0fDH0ScPWI0V6twP+EVgUmWmt9j+5
         qJj4k5QZ/geasNr19348OmPQkRXOJpbvvsrRy0RL54mL+tySiJ+QoZRhhU9YG79PINK1
         kERy8iZxpB6awyslCA7+Usb+u05LnxScq5SqVkyt6rluOcUlzOxOawVHn2MbjEq+Eqkh
         QRUARSyxOX7fJCt4YFU0PBFlW9OGyW36+oQQ0TGau6MT7BLuiC5P4+0x+GaandeSVmXQ
         OI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678283472;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2a7IZeMYO9n6PXhDENMf/0WN13+dEVs/avcgaXRcG/k=;
        b=P1davj40wEI+te7gOZQj/GzXqw2FigY2K1rSXsTFhMMKbjlL6jr9jv3vdeMvDY8R0x
         97Y/3RGw7b16Kvm74qxZ1jn3UG9PFMAZS0ppbe/BWpbNY5tyZRrM+74KXD9zDh+5QDVl
         S1wJUJw1qb/k6bpTCoICZ6E7G5rBGu8/lUqDlT6nfhMJ9LDQn5/zMRgV9pWgHMg6LY1c
         ZJpFo77elh9gk56AKOZBLmPuzrzP7/XWvwYhop0cH0fjuMd4AJowF45DcDIY1vyjBUrF
         LtEAzZSneFt85X+U43htP0BDyajGimoIewbaqDV75j2S3jPiRxlvdDM7ubvbNH50vkX5
         QHdw==
X-Gm-Message-State: AO0yUKWydeaOpa6SsoP8qkE2/L7ZoSEvuBfz9Lu1YdPhYDe56GHut2f/
        z65hcYS8tdMtPsOhudKtwcQ=
X-Google-Smtp-Source: AK7set/iI0f+bFuGX2KOYnRyVO55NVMzanwW/UZXPecNwIj6030n4Qu5dMtQwcP4F+mKYfu9HOXczw==
X-Received: by 2002:a05:600c:3d14:b0:3df:9858:c033 with SMTP id bh20-20020a05600c3d1400b003df9858c033mr16288216wmb.8.1678283472235;
        Wed, 08 Mar 2023 05:51:12 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c510e00b003dc522dd25esm4731434wms.30.2023.03.08.05.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:51:11 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 8 Mar 2023 14:51:09 +0100
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
Subject: Re: [PATCH RFC v2 bpf-next 7/9] selftests/bpf: Replace
 extract_build_id with read_build_id
Message-ID: <ZAiSzVTaOuWw5qRU@krava>
References: <20230228093206.821563-1-jolsa@kernel.org>
 <20230228093206.821563-8-jolsa@kernel.org>
 <CAEf4Bzb-ZuR6RwgGEw1Dyy+HtvyzdnCYXWXU86v=694rWcZpAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb-ZuR6RwgGEw1Dyy+HtvyzdnCYXWXU86v=694rWcZpAA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:26:32PM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 28, 2023 at 1:33 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Replacing extract_build_id with read_build_id that parses out
> > build id directly from elf without using readelf tool.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> small nit below, but looks good. Thanks for clean up!
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> >  .../bpf/prog_tests/stacktrace_build_id.c      | 19 ++++++--------
> >  .../bpf/prog_tests/stacktrace_build_id_nmi.c  | 17 +++++--------
> >  tools/testing/selftests/bpf/test_progs.c      | 25 -------------------
> >  tools/testing/selftests/bpf/test_progs.h      |  1 -
> >  4 files changed, 13 insertions(+), 49 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
> > index 9ad09a6c538a..9e4b76ee356f 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
> > @@ -7,13 +7,12 @@ void test_stacktrace_build_id(void)
> >
> >         int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> >         struct test_stacktrace_build_id *skel;
> > -       int err, stack_trace_len;
> > +       int err, stack_trace_len, build_id_size;
> >         __u32 key, prev_key, val, duration = 0;
> > -       char buf[256];
> > -       int i, j;
> > +       char buf[BPF_BUILD_ID_SIZE];
> >         struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
> >         int build_id_matches = 0;
> > -       int retry = 1;
> > +       int i, retry = 1;
> >
> >  retry:
> >         skel = test_stacktrace_build_id__open_and_load();
> > @@ -52,9 +51,10 @@ void test_stacktrace_build_id(void)
> >                   "err %d errno %d\n", err, errno))
> >                 goto cleanup;
> >
> > -       err = extract_build_id(buf, 256);
> > +       build_id_size = read_build_id("./urandom_read", buf);
> 
> nit: "urandom_read" vs "./urandom_read" matters only when executing
> binary, not when opening a file. So all these "./" just creates
> unnecessary confusion, IMO

right, I'll remove it also in the other test

thanks,
jirka

> 
> > +       err = build_id_size < 0 ? build_id_size : 0;
> >
> > -       if (CHECK(err, "get build_id with readelf",
> > +       if (CHECK(err, "read_build_id",
> >                   "err %d errno %d\n", err, errno))
> >                 goto cleanup;
> >
> > @@ -64,8 +64,6 @@ void test_stacktrace_build_id(void)
> >                 goto cleanup;
> >
> >         do {
> > -               char build_id[64];
> > -
> >                 err = bpf_map_lookup_elem(stackmap_fd, &key, id_offs);
> >                 if (CHECK(err, "lookup_elem from stackmap",
> >                           "err %d, errno %d\n", err, errno))
> > @@ -73,10 +71,7 @@ void test_stacktrace_build_id(void)
> >                 for (i = 0; i < PERF_MAX_STACK_DEPTH; ++i)
> >                         if (id_offs[i].status == BPF_STACK_BUILD_ID_VALID &&
> >                             id_offs[i].offset != 0) {
> > -                               for (j = 0; j < 20; ++j)
> > -                                       sprintf(build_id + 2 * j, "%02x",
> > -                                               id_offs[i].build_id[j] & 0xff);
> > -                               if (strstr(buf, build_id) != NULL)
> > +                               if (memcmp(buf, id_offs[i].build_id, build_id_size) == 0)
> >                                         build_id_matches = 1;
> >                         }
> >                 prev_key = key;
> > diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> > index f4ea1a215ce4..8d84149ebcc7 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> > @@ -28,11 +28,10 @@ void test_stacktrace_build_id_nmi(void)
> >                 .config = PERF_COUNT_HW_CPU_CYCLES,
> >         };
> >         __u32 key, prev_key, val, duration = 0;
> > -       char buf[256];
> > -       int i, j;
> > +       char buf[BPF_BUILD_ID_SIZE];
> >         struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
> > -       int build_id_matches = 0;
> > -       int retry = 1;
> > +       int build_id_matches = 0, build_id_size;
> > +       int i, retry = 1;
> >
> >         attr.sample_freq = read_perf_max_sample_freq();
> >
> > @@ -94,7 +93,8 @@ void test_stacktrace_build_id_nmi(void)
> >                   "err %d errno %d\n", err, errno))
> >                 goto cleanup;
> >
> > -       err = extract_build_id(buf, 256);
> > +       build_id_size = read_build_id("./urandom_read", buf);
> > +       err = build_id_size < 0 ? build_id_size : 0;
> >
> >         if (CHECK(err, "get build_id with readelf",
> >                   "err %d errno %d\n", err, errno))
> > @@ -106,8 +106,6 @@ void test_stacktrace_build_id_nmi(void)
> >                 goto cleanup;
> >
> >         do {
> > -               char build_id[64];
> > -
> >                 err = bpf_map__lookup_elem(skel->maps.stackmap, &key, sizeof(key),
> >                                            id_offs, sizeof(id_offs), 0);
> >                 if (CHECK(err, "lookup_elem from stackmap",
> > @@ -116,10 +114,7 @@ void test_stacktrace_build_id_nmi(void)
> >                 for (i = 0; i < PERF_MAX_STACK_DEPTH; ++i)
> >                         if (id_offs[i].status == BPF_STACK_BUILD_ID_VALID &&
> >                             id_offs[i].offset != 0) {
> > -                               for (j = 0; j < 20; ++j)
> > -                                       sprintf(build_id + 2 * j, "%02x",
> > -                                               id_offs[i].build_id[j] & 0xff);
> > -                               if (strstr(buf, build_id) != NULL)
> > +                               if (memcmp(buf, id_offs[i].build_id, build_id_size) == 0)
> >                                         build_id_matches = 1;
> >                         }
> >                 prev_key = key;
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> > index 6d5e3022c75f..9813d53c4878 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -591,31 +591,6 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
> >         return err;
> >  }
> >
> > -int extract_build_id(char *build_id, size_t size)
> > -{
> > -       FILE *fp;
> > -       char *line = NULL;
> > -       size_t len = 0;
> > -
> > -       fp = popen("readelf -n ./urandom_read | grep 'Build ID'", "r");
> > -       if (fp == NULL)
> > -               return -1;
> > -
> > -       if (getline(&line, &len, fp) == -1)
> > -               goto err;
> > -       pclose(fp);
> > -
> > -       if (len > size)
> > -               len = size;
> > -       memcpy(build_id, line, len);
> > -       build_id[len] = '\0';
> > -       free(line);
> > -       return 0;
> > -err:
> > -       pclose(fp);
> > -       return -1;
> > -}
> > -
> >  static int finit_module(int fd, const char *param_values, int flags)
> >  {
> >         return syscall(__NR_finit_module, fd, param_values, flags);
> > diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> > index 9fbdc57c5b57..3825c2797a4b 100644
> > --- a/tools/testing/selftests/bpf/test_progs.h
> > +++ b/tools/testing/selftests/bpf/test_progs.h
> > @@ -404,7 +404,6 @@ static inline void *u64_to_ptr(__u64 ptr)
> >  int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
> >  int compare_map_keys(int map1_fd, int map2_fd);
> >  int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
> > -int extract_build_id(char *build_id, size_t size);
> >  int kern_sync_rcu(void);
> >  int trigger_module_test_read(int read_sz);
> >  int trigger_module_test_write(int write_sz);
> > --
> > 2.39.2
> >
