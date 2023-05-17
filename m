Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258E5706075
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEQGv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 02:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEQGv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 02:51:57 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058E82112;
        Tue, 16 May 2023 23:51:51 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-4348416ae45so224043137.3;
        Tue, 16 May 2023 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684306310; x=1686898310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueYvFiNPIqodyLv9v94eNhjcPY0/j41IxYzpNNl2tWA=;
        b=CvNG7VViNSsj8iEJdkr97mdB8Bw1Zk0V/8lT0NhnxzuZbuvYFZYSfLaECM9k6R/+Xk
         qOkehyeybXgM4oOWUvyl0tgGU8D0q4r3EoFEhR74UB1z4Nx7PZY53T1GZcXht9TBcf6V
         6wjDImt7h9T0YQe/M9Q+NR8qhqR9a9xyCdqQ1ASCnHiDmaH46DXURJ2bMQc8iSnQjf++
         oInZZA55Gdl0GlqcdNpWkmZC+YsrV3LRKSqzEPw29/OKRc8zpG3kJiAuxqO4G/2O7wZt
         nB8z8OyL6qu0+qVFyWpKgqdu8zNjhlvQTP6xZEkwBa7OglroEj63HTGZNds38MqLbcbL
         qilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684306310; x=1686898310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueYvFiNPIqodyLv9v94eNhjcPY0/j41IxYzpNNl2tWA=;
        b=c2avkECpmJ0wg3ckwhjOhA2eLtQK+rdNPuHuUaSXeqpouk41QzOb1nXIgjjPks0EBi
         r+FWbRDV5tdFrMelUr5tC9tCHRcNM7eksPkNP+CKmoaOjYYcekSGUaCYNZvyoK8t6bVV
         A0OPjgHRvF+TUIsGMajrZSOzpz2YB0NFzimKtGymYYu3TyitnyF/NKcDOaE2ST8zQnjN
         FsgXkQN7Ff4jIxkO6ImKvaiO7AJ3dCsvMFsDjHh8NsH7KfDbRP0PyhbpXVsgN6+PAE5O
         lqupd7nBiJXhqptQKmbDLsmSRpseW67gv6z9A9ZT2wDKNeOOMUOpB6QBbxemrnhh9h0W
         e28w==
X-Gm-Message-State: AC+VfDwNFedVhhx8A3wYH1FbZl2lamXzv70CLb3X7xMeaFMZa6KEY8Fm
        AWkuPVG0Kp3rkty//QF6Q8N74WfzvzNfpDQ2dnU=
X-Google-Smtp-Source: ACHHUZ41BL482ERiVf/+uhBJvKHbw61Ab2b9cZwPIbODjpi3yNUcwpX8KmOeC8OcOjGX3Le6YiWDGAcu3svkDMrNbj0=
X-Received: by 2002:a05:6102:3a66:b0:42f:46d6:7a65 with SMTP id
 bf6-20020a0561023a6600b0042f46d67a65mr17316190vsb.21.1684306310492; Tue, 16
 May 2023 23:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com> <CAJfpegtuNgbZfLiKnpzdEP0sNtCt=83NjGtBnmtvMaon2avv2w@mail.gmail.com>
 <CA+PiJmTMs2u=J6ANYqHdGww5SoE_focZGjMRZk5WgoH8fVuCsA@mail.gmail.com> <93e0e991-147f-0021-d635-95e615057273@linux.alibaba.com>
In-Reply-To: <93e0e991-147f-0021-d635-95e615057273@linux.alibaba.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 May 2023 09:51:39 +0300
Message-ID: <CAOQ4uxjCebxGxkguAh9s4_Vg7QHM=oBoV0LUPZpb+0pcm3z1bw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 00/37] FUSE BPF: A Stacked Filesystem
 Extension for FUSE
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 5:50=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2023/5/2 17:07, Daniel Rosenberg wrote:
> > On Mon, Apr 24, 2023 at 8:32=E2=80=AFAM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> >>
> >>
> >> The security model needs to be thought about and documented.  Think
> >> about this: the fuse server now delegates operations it would itself
> >> perform to the passthrough code in fuse.  The permissions that would
> >> have been checked in the context of the fuse server are now checked in
> >> the context of the task performing the operation.  The server may be
> >> able to bypass seccomp restrictions.  Files that are open on the
> >> backing filesystem are now hidden (e.g. lsof won't find these), which
> >> allows the server to obfuscate accesses to backing files.  Etc.
> >>
> >> These are not particularly worrying if the server is privileged, but
> >> fuse comes with the history of supporting unprivileged servers, so we
> >> should look at supporting passthrough with unprivileged servers as
> >> well.
> >>
> >
> > This is on my todo list. My current plan is to grab the creds that the
> > daemon uses to respond to FUSE_INIT. That should keep behavior fairly
> > similar. I'm not sure if there are cases where the fuse server is
> > operating under multiple contexts.
> > I don't currently have a plan for exposing open files via lsof. Every
> > such file should relate to one that will show up though. I haven't dug
> > into how that's set up, but I'm open to suggestions.
> >
> >> My other generic comment is that you should add justification for
> >> doing this in the first place.  I guess it's mainly performance.  So
> >> how performance can be won in real life cases?   It would also be good
> >> to measure the contribution of individual ops to that win.   Is there
> >> another reason for this besides performance?
> >>
> >> Thanks,
> >> Miklos
> >
> > Our main concern with it is performance. We have some preliminary
> > numbers looking at the pure passthrough case. We've been testing using
> > a ramdrive on a somewhat slow machine, as that should highlight
> > differences more. We ran fio for sequential reads, and random
> > read/write. For sequential reads, we were seeing libfuse's
> > passthrough_hp take about a 50% hit, with fuse-bpf not being
> > detectably slower. For random read/write, we were seeing a roughly 90%
> > drop in performance from passthrough_hp, while fuse-bpf has about a 7%
> > drop in read and write speed. When we use a bpf that traces every
> > opcode, that performance hit increases to a roughly 1% drop in
> > sequential read performance, and a 20% drop in both read and write
> > performance for random read/write. We plan to make more complex bpf
> > examples, with fuse daemon equivalents to compare against.
> >
> > We have not looked closely at the impact of individual opcodes yet.
> >
> > There's also a potential ease of use for fuse-bpf. If you're
> > implementing a fuse daemon that is largely mirroring a backing
> > filesystem, you only need to write code for the differences in
> > behavior. For instance, say you want to remove image metadata like
> > location. You could give bpf information on what range of data is
> > metadata, and zero out that section without having to handle any other
> > operations.
>
> A bit out of topic (although I'm not quite look into FUSE BPF internals)
> After roughly listening to this topic in FS track last week, I'm not
> quite sure (at least in the long term) if it might be better if
> ebpf-related filter/redirect stuffs could be landed in vfs or in a
> somewhat stackable fs so that we could redirect/filter any sub-fstree
> in principle?    It's just an open question and I have no real tendency
> of this but do we really need a BPF-filter functionality for each
> individual fs?

I think that is a valid question, but the answer is that even if it makes s=
ense,
doing something like this in vfs would be a much bigger project with larger
consequences on performance and security and whatnot, so even if
(and a very big if) this ever happens, using FUSE-BPF as a playground for
this sort of stuff would be a good idea.

This reminds me of union mounts - it made sense to have union mount
functionality in vfs, but after a long winding road, a stacked fs (overlayf=
s)
turned out to be a much more practical solution.

>
> It sounds much like
> https://learn.microsoft.com/en-us/windows-hardware/drivers/ifs/about-file=
-system-filter-drivers
>

Nice reference.
I must admit that I found it hard to understand what Windows filter drivers
can do compared to FUSE-BPF design.
It'd be nice to get some comparison from what is planned for FUSE-BPF.

Interesting to note that there is a "legacy" Windows filter driver API,
so Windows didn't get everything right for the first API - that is especial=
ly
interesting to look at as repeating other people's mistakes would be a sham=
e.

Thanks,
Amir.
