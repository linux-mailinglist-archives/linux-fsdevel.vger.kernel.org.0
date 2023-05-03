Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F26F4F35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 05:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjECDpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 23:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECDpb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 23:45:31 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4A92683;
        Tue,  2 May 2023 20:45:29 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-77d46c7dd10so1521686241.0;
        Tue, 02 May 2023 20:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683085529; x=1685677529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/HXv6CG+LxJ7BClSWO3ugL9TVXyN0Lqq9OyDlKsu+U=;
        b=hZ2fCikkaJ3a8AARHzwxnFamVk+Ky1uH8Sv3ZmruF70hU5fTJER//ZGjvUth/M+Tls
         w+FlE6924Bz6XqfFZn50ZPuqGiHpw0PrAZtx5WVfEv2joJ6RyF/L4ynNU0jPzRak30Ck
         z22nyDOyti4yCC9GS6fzKvB7vDbkmrt3kxYb9Z9RexGYEd51PgLB+zWssA18S7zmJ4Em
         sdTP5SHmqQEzxnobgoPdo8+9/GfCBEVtZCEdVLhAhw1miPbyAXyUpJ5MwOLoObrXUbRN
         tukCKwHxTTci7FSkFfebZdBTI+HKHArdxM8bCliFQxnkwQm/+WB9Nkvl8+DxWnwk0zTS
         fPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683085529; x=1685677529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/HXv6CG+LxJ7BClSWO3ugL9TVXyN0Lqq9OyDlKsu+U=;
        b=IYe22Jvc5IRMcVeW7LJ9/nz54Hg1X29GAYj89+iQHuU7mQv8zEH5Ka6eqwBQiCMNCe
         O6ICOyyaebNCA1ms5x0F+2m38eu1N8+ZAh5jkPsALux2OjrOTJHmGdFzp44xkOjEj12Y
         D4ksbrWSBM7iv7Q00Ru9cyaiWL6c1bF+R3ViqIA+rLEOtuhHiDynmGW/jnlYi+B62bCF
         eaFRYIZzxWaXRDMsmg3klcH1xM2pXNNGJw79VqxXtyqb5zgvilrjOtfuz6MEmmo5RuLV
         3qN4+b21tKQyD0rYkSAiSRO2pzhl51tcWQmY2ja93PqRSQXqApXdDqIH6YP0uvKJaIix
         ANcA==
X-Gm-Message-State: AC+VfDzR7jzgLk2UDP620tl6ZaMERugrcsHRPvFDR9TtbTpDdog8sSJ+
        4A4Rk0f/Ahb6NSj/oWpH/4THO8YdYtAbkcfL/hY=
X-Google-Smtp-Source: ACHHUZ5tzzMWOASC+yK6hxGcJYLcI+b9I/oT+mJ2v1V8ZQ4we7IPzywRC+azTftiFych0glVNcKyJE7ikI8ACK/DupM=
X-Received: by 2002:a1f:5e10:0:b0:432:e55:b103 with SMTP id
 s16-20020a1f5e10000000b004320e55b103mr290197vkb.3.1683085528720; Tue, 02 May
 2023 20:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com> <20230418014037.2412394-9-drosen@google.com>
 <20230502033825.ofcxttuquoanhe7b@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230502033825.ofcxttuquoanhe7b@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 3 May 2023 06:45:17 +0300
Message-ID: <CAOQ4uxi3WXb2MKx+YUnsCad2jUDtUuafFzuqJi0uo4us7xmfuA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 08/37] fuse: Add fuse-bpf, a stacked fs extension
 for FUSE
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>
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

On Tue, May 2, 2023 at 6:38=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 17, 2023 at 06:40:08PM -0700, Daniel Rosenberg wrote:
> > Fuse-bpf provides a short circuit path for Fuse implementations that ac=
t
> > as a stacked filesystem. For cases that are directly unchanged,
> > operations are passed directly to the backing filesystem. Small
> > adjustments can be handled by bpf prefilters or postfilters, with the
> > option to fall back to userspace as needed.
>
> Here is my understanding of fuse-bpf design:
> - bpf progs can mostly read-only access fuse_args before and after proper=
 vfs
>   operation on a backing path/file/inode.
> - args are unconditionally prepared for bpf prog consumption, but progs w=
on't
>   be doing anything with them most of the time.
> - progs unfortunately cannot do any real work. they're nothing but simple=
 filters.
>   They can give 'green light' for a fuse_FOO op to be delegated to proper=
 vfs_FOO
>   in backing file. The logic in this patch keeps track of backing_path/fi=
le/inode.
> - in other words bpf side is "dumb", but it's telling kernel what to do w=
ith
>   real things like path/file/inode and the kernel is doing real work and =
calling vfs_*.
>
> This design adds non-negligible overhead to fuse when CONFIG_FUSE_BPF is =
set.
> Comparing to trip to user space it's close to zero, but the cost of
> initialize_in/out + backing + finalize is not free.
> The patch 33 is especially odd.
> fuse has a traditional mechanism to upcall to user space with fuse_simple=
_request.
> The patch 33 allows bpf prog to return special return value and trigger t=
wo more
> fuse_bpf_simple_request-s to user space. Not clear why.
> It seems to me that the main assumption of the fuse bpf design is that bp=
f prog
> has to stay short and simple. It cannot do much other than reading and co=
mparing
> strings with the help of dynptr.
> How about we allow bpf attach to fuse_simple_request and nothing else?
> All fuse ops call it anyway and cmd is already encoded in the args.
> Then let bpf prog read fuse_args as-is (without converting them to bpf_fu=
se_args)
> and avoid doing actual fuse_req to user space.
> Also allow bpf prog acquire and remember path/file/inode.
> The verifier is already smart enough to track that the prog is doing it s=
afely
> without leaking references and what not.
> And, of course, allow bpf prog call vfs_* via kfuncs.
> In other words, instead of hard coding
>  +#define bpf_fuse_backing(inode, io, out,                             \
>  +                      initialize_in, initialize_out,                 \
>  +                      backing, finalize, args...)                    \
> one for each fuse_ops in the kernel let bpf prog do the same but on deman=
d.
> The biggest advantage is that this patch set instead of 95% on fuse side =
and 5% on bpf
> will become 5% addition to fuse code. All the logic will be handled purel=
y by bpf.
> Right now you're limiting it to one backing_file per fuse_file.
> With bpf prog driving it the prog can keep multiple backing_files and shu=
ffle
> access to them as prog decides.
> Instead of doing 'return BPF_FUSE_CONTINUE' the bpf progs will
> pass 'path' to kfunc bpf_vfs_open, than stash 'struct bpf_file*', etc.
> Probably will be easier to white board this idea during lsfmmbpf.
>

I have to admit that sounds a bit challenging, but I'm up for sitting
in front of that whiteboard :)

BTW, thanks Daniel (Borkmann) for sorting out the cross track
sessions for FS-BFP.
We have another FS only session on FUSE-BFP, but I feel there is plenty
to discuss on the FUSE-bypass part, as well as on the BPF part.
Same goes for BFP iterators for filesystems session.

Thanks,
Amir.
