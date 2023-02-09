Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6AD6900BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 08:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjBIHMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 02:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBIHMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:12:49 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E261241B64
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 23:12:46 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w5so1882821plg.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 23:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WVs22Kg7Btgcs7NcU/V4V2lSD7tkAUiSfve9Y1LNwY=;
        b=AoYrrJJs6k9GtmQ4jMGk0yXnsurRdiogv4N9KaUtAvk7czZiKUvynb//Bfa2EC5y3x
         bThSbc2PuWdlSa6zqhkSM3mNpiJHJPK8QHZP0bb0ANnmBRq9y6M6tosCkqa0HtjZEr7m
         pdZWvIjuSCgtmifIjb6P+QJwoD6nwQX/OA31bMpYqq3qigQS8QSqGSlSiq47cdl+XVQx
         2JCuvOxpC3CK/kIQhAqtz+Zi7zTcsXfsqIKsjnrCzTvJoB5FP4M6IVUUoVQ4vN1tGuCr
         X41zK9YDiG7cBtw8BW3R1Jb/SbukYgAhUI7qDCI7mUA4yRA0v5Gq7Ipcnhb/YmqWIm3T
         qicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WVs22Kg7Btgcs7NcU/V4V2lSD7tkAUiSfve9Y1LNwY=;
        b=a0ZSPUfwNfYx/c1vhfKuLzoBH7u8YH5yIsLTQduxpnRyAWUd3pZfCBFNkZehc/+HrI
         Cj0gnrnR5TTldNHcf57PIeYAOCVKcSqsxceuHhItA/cW7wzjtfB7rwYwVXeatX+S/7gL
         cv62WNhme74JoLKhxGC0XCU8ekgIuuGznn8MJ16RiYt3vrelLKreyJvQqNVtxCE6Vi80
         7xu3Sc83XyjqpHEJDEybOFlQ6tk1/7k4I4R0BMYl6dXD5baA65GnKGAzUuYmmOf57VeI
         zjQbnRZnl2Cm8i0jp0I+Nb2dwjFyi6cSlFLBaQVf5+wOeFYysy8uuTjD8ph3zSsSYMbj
         S42g==
X-Gm-Message-State: AO0yUKVp79pqcAJOsGvnHlu+SwSP8dniwXgpDi5nWO1jBC4KtWHJQZjY
        gC+sqXDXXJhnjPryEldTDOGxy6uPQBjDlt44920TGQ==
X-Google-Smtp-Source: AK7set/JAGjMaYyKUc3wik1Zpc3z1fF27fTbmID4hmKb+mM1VoQt/VnzqKCHgPPcXP/4CDxya8Ss+VkiNAm6JDV2cqw=
X-Received: by 2002:a17:902:b78a:b0:199:26df:77b6 with SMTP id
 e10-20020a170902b78a00b0019926df77b6mr2518442pls.3.1675926766145; Wed, 08 Feb
 2023 23:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20230201135737.800527-1-jolsa@kernel.org> <Y9vSZhBBCbshI3eM@casper.infradead.org>
 <Y9vX49CtDzyg3B/8@krava>
In-Reply-To: <Y9vX49CtDzyg3B/8@krava>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 8 Feb 2023 23:12:34 -0800
Message-ID: <CA+khW7juLEcrTOd7iKG3C_WY8L265XKNo0iLzV1fE=o-cyeHcQ@mail.gmail.com>
Subject: Re: [RFC 0/5] mm/bpf/perf: Store build id in file object
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
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
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 2, 2023 at 7:33 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Feb 02, 2023 at 03:10:30PM +0000, Matthew Wilcox wrote:
> > On Wed, Feb 01, 2023 at 02:57:32PM +0100, Jiri Olsa wrote:
> > > hi,
> > > we have a use cases for bpf programs to use binary file's build id.
> >
> > What is your use case?  Is it some hobbyist thing or is it something
> > that distro kernels are all going to enable?
> >
>
> our use case is for hubble/tetragon [1] and we are asked to report
> buildid of executed binary.. but the monitoring process is running
> in its own pod and can't access the the binaries outside of it, so
> we need to be able to read it in kernel
>
> I understand Hao Luo has also use case for that [2]
>

Sorry for the late reply.

We use BPF to profile stacktraces and build id is more useful than
instruction addresses. However, sometimes we need to record
stacktraces from an atomic context. In that case, if the page that
contains the build id string is not in the page cache, we would fail
to get build id. Storing the build id in file object solves this
problem and helps us get build id more reliably.

> jirka
>
>
> [1] https://github.com/cilium/tetragon/
> [2] https://lore.kernel.org/bpf/CA+khW7gAYHmoUkq0UqTiZjdOqARLG256USj3uFwi6z_FyZf31w@mail.gmail.com/
