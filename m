Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B55687C00
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 12:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBBLQH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 06:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjBBLPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:15:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855708AC2B;
        Thu,  2 Feb 2023 03:15:52 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f7so1619289edw.5;
        Thu, 02 Feb 2023 03:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wpEflEFgONyZvi4WlCVrqQszvFR7vLDMgEvU+XA8+7w=;
        b=F9HPADDYpgDBMmMTw31hsL/BPt7sHthFt72xAHYYI6C4/tsAnTR9FS5BP08bc1GDo3
         DlNxEE3klfp5hJgGUiMrrQ2mXMAacJZUbuP6LwQWECphzi485IppWULASmHz4LQ0aNhe
         xmD+ztykHvf7YxHzipN8QUabxTl21cADcR325iN5Z22Re7fK+YDv+KzZtQndt4y5qkdR
         FvWv+JZ4jOrSNBvgP++Q08Zn2vgEBArx8wh4B7VvOiWaOtUyeJ4ZEG+usB/Ibqg1JjPd
         Y7k9q6EN6VNFNdx2Qh5peMUR9I7rEkdi8CWxdUbf7hKziuzJzDOYs8600k1Q5nl5p6ld
         vFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpEflEFgONyZvi4WlCVrqQszvFR7vLDMgEvU+XA8+7w=;
        b=67jBChMPPxdws5c1h2zFqTRIDYzwaeqeBmQ0s3ErSy3/OP4PtHaRlISfa4KXFy4VRk
         /ssAPlMuKzKqJMkAzlNtsjtndpTEL+yDu5l6rubtgdKvX5yWFezoviFR8Mv2MNRx6gF5
         4w1dQRPZ3hQcvT7MOfItHCGRqAKW7hhPQDJr7R6X2skYnyr9qzsYV6F7+r+MUuN5uO8A
         IGz6tz8Z44IZQargQ6Oc4yfu7CZ5w4Hs6qlNdCcXURM2SqgxgdvVsUe0SHnKM8WdbtNd
         iK5lJjSmDcUUVDNZJpdaHKVIPhSA71s3nwoMvNs+3otoNTeyZidM1pWt6sFTg+EdFbnZ
         PNYA==
X-Gm-Message-State: AO0yUKV7Iely+RYqo802RLDsRqhpIclqTFhFwQyiph83epWiThbtY5sQ
        pMHp21oc88VEw0jAa/x9T7oZ+ACL4jhAQZNov5Y=
X-Google-Smtp-Source: AK7set/7vshqxPiS23f8zcEnLOB/WqJuLi7g76SaS9Fq+nI1GtacYnaPHdA3rg1UlpyFnJfbN29NT+FyA7W/0XKnnAM=
X-Received: by 2002:aa7:d385:0:b0:49e:6501:57a2 with SMTP id
 x5-20020aa7d385000000b0049e650157a2mr1774099edq.43.1675336550794; Thu, 02 Feb
 2023 03:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20230201135737.800527-1-jolsa@kernel.org>
In-Reply-To: <20230201135737.800527-1-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Feb 2023 03:15:39 -0800
Message-ID: <CAADnVQ+im7FwSqDcTLmMvfRcT9unwdHBeWG9Snw7W5Q-bcdWvg@mail.gmail.com>
Subject: Re: [RFC 0/5] mm/bpf/perf: Store build id in file object
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 1, 2023 at 5:57 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> we have a use cases for bpf programs to use binary file's build id.
>
> After some attempts to add helpers/kfuncs [1] [2] Andrii had an idea [3]
> to store build id directly in the file object. That would solve our use
> case and might be beneficial for other profiling/tracing use cases with
> bpf programs.
>
> This RFC patchset adds new config CONFIG_FILE_BUILD_ID option, which adds
> build id object pointer to the file object when enabled. The build id is
> read/populated when the file is mmap-ed.
>
> I also added bpf and perf changes that would benefit from this.
>
> I'm not sure what's the policy on adding stuff to file object, so apologies
> if that's out of line. I'm open to any feedback or suggestions if there's
> better place or way to do this.

struct file represents all files while build_id is for executables only,
and not all executables, but those currently running, so
I think it's cleaner to put it into vm_area_struct.
