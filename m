Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E526B09C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 14:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCHNsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 08:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCHNsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:48:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6042F233D2;
        Wed,  8 Mar 2023 05:48:19 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso1183582wmp.4;
        Wed, 08 Mar 2023 05:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678283298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eeukihki09mFh5Tgwwz3g9D7DAvSgW843JlsCSZBqvk=;
        b=N6PvQAEn37lp58tqEPw/ABQMH1wD1koV7wrbUPpnxRk+Sw04kEs6b9mcewq487BZvS
         PPaEBWGf1G5xLhSxWV4/X7+HtFJcv13hPo/rYRpCjziAPtmnE3GZmFT8/xVmenaiK5mW
         21ZxVtBXxlUENvU6CpfiuF7Hsp7mRtAlOLobIk5HQd0m+SC6ixIlYOLs7qMBR3cJccvd
         AGyKhw3sRypwGqwqnUWHWa0ZOOeG5S/1dctzOpxoPqECmisHQq8Aj0Ro5WFmQZSC27iV
         Rqxd0E7GQYwcanuyp3aHwk8SMieQT+rp3DFfcAIMebesejcH4X07a05WQLUX0rfTPzMk
         nhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678283298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eeukihki09mFh5Tgwwz3g9D7DAvSgW843JlsCSZBqvk=;
        b=pLGlg9xxOQiCckTPYkMqpFiafl9UpJQlRX6TSiwwOf2GfNaAxu4UPnU5vo0fGy41JA
         uXnKcbm3OUNDYapjpL+eix4Al3IEZ/WcZORcOI+Xe//Y9/6o57Tr8rrKq/ZJjQUFL3Lu
         8NsHIBcqcR59ncl7R6debGA7L9MO1oiFR3+goLc5L7yyD5zbwMBkKFEmfj8LwYNmkDCc
         PxLD8Z3X6w2F/WHnnqTGmERWkQBBsYmtDR+EjNcQX+yKNrUhNZCMt2Ib6R8hLWyqa/HO
         jCVE2cAM3gEj52+tDE78jd9KpcFXshzIqRAdsDdCujMdgIMLrGx9+QEiUwn+ayw8Awjz
         LoJQ==
X-Gm-Message-State: AO0yUKUoMPGW0TPCOwaTRyQd1tfgqNAKfHa5j5XVUTCWTJsnoUrT48vX
        Nfdt5++hgIpiMXxtB6KqjqQ=
X-Google-Smtp-Source: AK7set/We+21S7n72POqTKt6ngyQSPmSgUn7r5KwmhLXABqmHks8nzQ0ne3JyfD77aWaHXBj99vHNA==
X-Received: by 2002:a05:600c:1c96:b0:3ea:f6c4:5f3d with SMTP id k22-20020a05600c1c9600b003eaf6c45f3dmr15837479wms.2.1678283297706;
        Wed, 08 Mar 2023 05:48:17 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003eb2e33f327sm2220186wmf.2.2023.03.08.05.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:48:17 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 8 Mar 2023 14:48:14 +0100
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
Subject: Re: [PATCH RFC v2 bpf-next 4/9] libbpf: Allow to resolve binary path
 in current directory
Message-ID: <ZAiSHjVjdS76kSVN@krava>
References: <20230228093206.821563-1-jolsa@kernel.org>
 <20230228093206.821563-5-jolsa@kernel.org>
 <CAEf4Bzar7H1OsjgqJ8H6R-f3DZPhhR0+KOamyt0MDNboept--A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzar7H1OsjgqJ8H6R-f3DZPhhR0+KOamyt0MDNboept--A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:19:00PM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 28, 2023 at 1:33 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Try to resolve uprobe/usdt binary path also in current directory,
> > it's used in the test code in following changes.
> 
> nope, that's not what shell is doing, so let's not invent new rules
> here. If some tests need something like that, utilize LD_LIBRARY_PATH
> or even better just specify './library.so'

ok, that fixed that:

SEC("uprobe/./liburandom_read.so:urandlib_read_without_sema")

thanks,
jirka

> 
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 05c4db355f28..f72115e8b7f9 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -10727,17 +10727,19 @@ static const char *arch_specific_lib_paths(void)
> >  /* Get full path to program/shared library. */
> >  static int resolve_full_path(const char *file, char *result, size_t result_sz)
> >  {
> > -       const char *search_paths[3] = {};
> > +       const char *search_paths[4] = {};
> >         int i, perm;
> >
> >         if (str_has_sfx(file, ".so") || strstr(file, ".so.")) {
> >                 search_paths[0] = getenv("LD_LIBRARY_PATH");
> >                 search_paths[1] = "/usr/lib64:/usr/lib";
> >                 search_paths[2] = arch_specific_lib_paths();
> > +               search_paths[3] = ".";
> >                 perm = R_OK;
> >         } else {
> >                 search_paths[0] = getenv("PATH");
> >                 search_paths[1] = "/usr/bin:/usr/sbin";
> > +               search_paths[2] = ".";
> >                 perm = R_OK | X_OK;
> >         }
> >
> > --
> > 2.39.2
> >
