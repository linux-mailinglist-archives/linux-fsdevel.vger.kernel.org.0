Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F881FBEF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 21:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgFPTZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 15:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbgFPTZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:25:33 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22A0C061573;
        Tue, 16 Jun 2020 12:25:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n11so20361918qkn.8;
        Tue, 16 Jun 2020 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqyZv/AEdfRFWYzawxZF77n0qsAqhj2SZG0Xirc3F4g=;
        b=SlZMq6uWhZJNfx5IyN2PbbrAVNA3s239SAI5d9jkZdVUMarGb9AydgvqEup8B2A3Kv
         6C2+fKosPUP9rnyCUmoQFLu2MQEukMr8xIoMNOpRjeSRX7d0t1k+tcbdjJ9ZI76Lyw66
         yzMsuW2uGGoTEPe0X8KwFpbvbHxMa0fVIRgztMWFToTtXsAUveB4i+G+KCJY94hMLVzI
         3WPRfyu6Zrkhi7RwDn69SEaPFst0t6In1AwSSEtcuFnppsf8GIzeEM5xZoo+58vj1LTG
         +nPPpxzCCnszzda4rrwf7kzclvelK3IFhdJOpKqNpv8l5IaKfDpESlQehljuB/4Ot68L
         L2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqyZv/AEdfRFWYzawxZF77n0qsAqhj2SZG0Xirc3F4g=;
        b=KODnZquGmr8AcX59yrwTziv7IK6PplZAoGHgctzYLrFrtxaWNlAPa8cpyTivS9K+gt
         FVclpIF/8rg6WEIB9TyE3z78Bi3w9S+2RcxU+xTZx9VvzX5tcvdaRXXa65y2PVYu8ulW
         HS6LdRlskFDRFWSILIk2OtcF4RSWo6stHDbZjBZ0e0TPAo1ClqUIsiQrcsVaYuYKHyIR
         5j+x0teke2/eDR6j5qC7ilYTE2SLxDjWiQdbRRdnhNqwDNamfFh6bMEssfOSsNv0D+MQ
         T8iTQT/EcMri5JPPvkaA6hymcU32yBKWZe9pb4tpm4vDVeu0GlELguZh1FOQ2giezOvA
         TjXw==
X-Gm-Message-State: AOAM5324Q1TyE/ztLfOgBB7ykonjFnsTrgb3GluCGszVI64WzKjDPKZT
        alQAP+6KxokDGSqWdbZJmvvGSCPPGb0fqu/M1ueWRjVo
X-Google-Smtp-Source: ABdhPJx5AGwWzB3aiMX4WTsIXceaI2A1twdPvo2n9uInGG+Q3VUgoPtIjaIzbEhof6k4y6WR3RS8wGMEdirPbReQ0HI=
X-Received: by 2002:a37:d0b:: with SMTP id 11mr23186679qkn.449.1592335532792;
 Tue, 16 Jun 2020 12:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200526163336.63653-1-kpsingh@chromium.org> <20200526163336.63653-5-kpsingh@chromium.org>
 <CAEf4BzY0=Hh3O6qeD=2sMWpQRpHpizxH+nEA0hD0khPf3VAbhA@mail.gmail.com> <20200616155433.GA11971@google.com>
In-Reply-To: <20200616155433.GA11971@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Jun 2020 12:25:21 -0700
Message-ID: <CAEf4BzZm86BQqhfVHfm7aKvwK-UXC7679DsJe8xQqYR8eUUwAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpf: Add selftests for local_storage
To:     KP Singh <kpsingh@chromium.org>, Yonghong Song <yhs@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 8:54 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On 01-Jun 13:29, Andrii Nakryiko wrote:
> > On Tue, May 26, 2020 at 9:34 AM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > inode_local_storage:
> > >
> > > * Hook to the file_open and inode_unlink LSM hooks.
> > > * Create and unlink a temporary file.
> > > * Store some information in the inode's bpf_local_storage during
> > >   file_open.
> > > * Verify that this information exists when the file is unlinked.
> > >
> > > sk_local_storage:
> > >
> > > * Hook to the socket_post_create and socket_bind LSM hooks.
> > > * Open and bind a socket and set the sk_storage in the
> > >   socket_post_create hook using the start_server helper.
> > > * Verify if the information is set in the socket_bind hook.
> > >
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > ---
> > >  .../bpf/prog_tests/test_local_storage.c       |  60 ++++++++
> > >  .../selftests/bpf/progs/local_storage.c       | 139 ++++++++++++++++++
> > >  2 files changed, 199 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c
> > >
> >
> > [...]
> >
> > > +struct dummy_storage {
> > > +       __u32 value;
> > > +};
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_INODE_STORAGE);
> > > +       __uint(map_flags, BPF_F_NO_PREALLOC);
> > > +       __type(key, int);
> > > +       __type(value, struct dummy_storage);
> > > +} inode_storage_map SEC(".maps");
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_SK_STORAGE);
> > > +       __uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_CLONE);
> > > +       __type(key, int);
> > > +       __type(value, struct dummy_storage);
> > > +} sk_storage_map SEC(".maps");
> > > +
> > > +/* Using vmlinux.h causes the generated BTF to be so big that the object
> > > + * load fails at btf__load.
> > > + */
> >
> > That's first time I hear about such issue. Do you have an error log
> > from verifier?
>
> Here's what I get when I do the following change.
>
> --- a/tools/testing/selftests/bpf/progs/local_storage.c
> +++ b/tools/testing/selftests/bpf/progs/local_storage.c
> @@ -4,8 +4,8 @@
>   * Copyright 2020 Google LLC.
>   */
>
> +#include "vmlinux.h"
>  #include <errno.h>
> -#include <linux/bpf.h>
>  #include <stdbool.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> @@ -37,24 +37,6 @@ struct {
>         __type(value, struct dummy_storage);
>  } sk_storage_map SEC(".maps");
>
> -/* Using vmlinux.h causes the generated BTF to be so big that the object
> - * load fails at btf__load.
> - */
> -struct sock {} __attribute__((preserve_access_index));
> -struct sockaddr {} __attribute__((preserve_access_index));
> -struct socket {
> -       struct sock *sk;
> -} __attribute__((preserve_access_index));
> -
> -struct inode {} __attribute__((preserve_access_index));
> -struct dentry {
> -       struct inode *d_inode;
> -} __attribute__((preserve_access_index));
> -struct file {
> -       struct inode *f_inode;
> -} __attribute__((preserve_access_index));
>
> ./test_progs -t test_local_storage
> libbpf: Error loading BTF: Invalid argument(22)
> libbpf: magic: 0xeb9f
> version: 1
> flags: 0x0
> hdr_len: 24
> type_off: 0
> type_len: 4488
> str_off: 4488
> str_len: 3012
> btf_total_size: 7524
>
> [1] STRUCT (anon) size=32 vlen=4
>         type type_id=2 bits_offset=0
>         map_flags type_id=6 bits_offset=64
>         key type_id=8 bits_offset=128
>         value type_id=9 bits_offset=192
> [2] PTR (anon) type_id=4
> [3] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [4] ARRAY (anon) type_id=3 index_type_id=5 nr_elems=28
> [5] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [6] PTR (anon) type_id=7
> [7] ARRAY (anon) type_id=3 index_type_id=5 nr_elems=1
> [8] PTR (anon) type_id=3
> [9] PTR (anon) type_id=10
> [10] STRUCT dummy_storage size=4 vlen=1
>         value type_id=11 bits_offset=0
> [11] TYPEDEF __u32 type_id=12
>
>   [... More BTF Dump ...]
>
> [91] TYPEDEF wait_queue_head_t type_id=175
>
>   [... More BTF Dump ...]
>
> [173] FWD super_block struct
> [174] FWD vfsmount struct
> [175] FWD wait_queue_head struct
> [106] STRUCT socket_wq size=128 vlen=4
>         wait type_id=91 bits_offset=0 Invalid member
>
> libbpf: Error loading .BTF into kernel: -22.
> libbpf: map 'inode_storage_map': failed to create: Invalid argument(-22)
> libbpf: failed to load object 'local_storage'
> libbpf: failed to load BPF skeleton 'local_storage': -22
> test_test_local_storage:FAIL:skel_load lsm skeleton failed
> #81 test_local_storage:FAIL
>
> The failiure is in:
>
> [106] STRUCT socket_wq size=128 vlen=4
>         wait type_id=91 bits_offset=0 Invalid member
>
> >
> > Clang is smart enough to trim down used types to only those that are
> > actually necessary, so too big BTF shouldn't be a thing. But let's try
> > to dig into this and fix whatever issue it is, before giving up :)
> >
>
> I was wrong about the size being an issue. The verifier thinks the BTF
> is invalid and more specificially it thinks that the socket_wq's
> member with type_id=91, i.e. typedef wait_queue_head_t is invalid. Am
> I missing some toolchain patches?
>

It is invalid BTF in the sense that we have a struct, embedding a
struct, which is only defined as a forward declaration. There is not
enough information and such situation would have caused compilation
error, because it's impossible to determine the size of the outer
struct.

Yonghong, it seems like Clang is pruning types too aggressively here?
We should keep types that are embedded, even if they are not used
directly by user code. Could you please take a look?



> - KP
>
>
> > > +struct sock {} __attribute__((preserve_access_index));
> > > +struct sockaddr {} __attribute__((preserve_access_index));
> > > +struct socket {
> > > +       struct sock *sk;
> > > +} __attribute__((preserve_access_index));
> > > +
> > > +struct inode {} __attribute__((preserve_access_index));
> > > +struct dentry {
> > > +       struct inode *d_inode;
> > > +} __attribute__((preserve_access_index));
> > > +struct file {
> > > +       struct inode *f_inode;
> > > +} __attribute__((preserve_access_index));
> > > +
> > > +
> >
> > [...]
