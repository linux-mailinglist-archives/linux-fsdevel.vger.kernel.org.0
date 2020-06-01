Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E481EB03A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 22:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFAU3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 16:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgFAU3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:29:46 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EB7C061A0E;
        Mon,  1 Jun 2020 13:29:45 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so8788570qtq.11;
        Mon, 01 Jun 2020 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAs9Kw635YW+HDXvo0zhakrzZhJRnpKHS/Rqz6u5QVM=;
        b=cayfLfklNNt8EmT631CpwrTFKbLubWMnfHX9UAcGmVVpB72JZ5N7bSspIsqetgItMu
         hyhsMUWDhHRi/LKEkkvhL3ie9JmTTqzMlrL6BG90PzpHtJVQ+JJnwRZ2yxcusbPhKvWq
         oTDeYcoDcrQxGU5SwaOMdK7HnAQOaeI4WrzqaJYlSTHCjaoaPoOilMYjzDiAP5gNl2o0
         bFMx02zEd8/P4nImlfX12mrOSG/0zWG+GXKschLlTLXoYkgyjDO+NlLN5+FjUAE3IO0c
         3MGeLBcyeSuyeifbU82DPV+bAuLqgddgmU6jywwPnhakMlBhaFn6YIbJJIgd1tMWTTWT
         +D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAs9Kw635YW+HDXvo0zhakrzZhJRnpKHS/Rqz6u5QVM=;
        b=MYUCl8TzN94TdCeM5BiQMzPpNpHSjdWGbjzlu3jS5tOpLtulLZoXFC8etNF9xP702j
         knM4yec1F3v53Fc3/ENkLQewelrQHQDHWpwRy8xBF94eP6tJ+CcN0ZT0eYGib/4783aK
         uBA3wvmKnIF6FHJCG9V3fqCCY3xSv8ZPPbIvbRrUWTvuAoP/pL/7WN+EfAHk/NC4wZNZ
         kHp/EAPtiSmCvN8JffRKLksaoGaWqwJ9lXbRKSkXlHDZOSzc8NSvOobQ9FDhMubClSlj
         stUmM4Bh4NvuGf0UMA7fqZBXpFSMvtW/IJObTqVpM1yxptTl/6oVYrJ/hOatKXLmqro5
         CT2Q==
X-Gm-Message-State: AOAM530h64EhQcbK4rfzZL4A17vVix4BY7dL41YYalYyavhfskhrQH7Q
        /kiM7AzA5DEp7V+B2hwBE87wvulwIe08IjuNGKRaG8JF
X-Google-Smtp-Source: ABdhPJyFqi2sy1XpNUtKnyJCkuPklMuovTOzVIZJEpTDi6XMDFRLM77wlqBxWlNBC9o8/kQn1VsjhpYUIoUmWKs47Fg=
X-Received: by 2002:ac8:2dc3:: with SMTP id q3mr23123105qta.141.1591043384218;
 Mon, 01 Jun 2020 13:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200526163336.63653-1-kpsingh@chromium.org> <20200526163336.63653-5-kpsingh@chromium.org>
In-Reply-To: <20200526163336.63653-5-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Jun 2020 13:29:33 -0700
Message-ID: <CAEf4BzY0=Hh3O6qeD=2sMWpQRpHpizxH+nEA0hD0khPf3VAbhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpf: Add selftests for local_storage
To:     KP Singh <kpsingh@chromium.org>
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

On Tue, May 26, 2020 at 9:34 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> inode_local_storage:
>
> * Hook to the file_open and inode_unlink LSM hooks.
> * Create and unlink a temporary file.
> * Store some information in the inode's bpf_local_storage during
>   file_open.
> * Verify that this information exists when the file is unlinked.
>
> sk_local_storage:
>
> * Hook to the socket_post_create and socket_bind LSM hooks.
> * Open and bind a socket and set the sk_storage in the
>   socket_post_create hook using the start_server helper.
> * Verify if the information is set in the socket_bind hook.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  .../bpf/prog_tests/test_local_storage.c       |  60 ++++++++
>  .../selftests/bpf/progs/local_storage.c       | 139 ++++++++++++++++++
>  2 files changed, 199 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_local_storage.c
>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage.c
>

[...]

> +struct dummy_storage {
> +       __u32 value;
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_INODE_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, struct dummy_storage);
> +} inode_storage_map SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_SK_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC | BPF_F_CLONE);
> +       __type(key, int);
> +       __type(value, struct dummy_storage);
> +} sk_storage_map SEC(".maps");
> +
> +/* Using vmlinux.h causes the generated BTF to be so big that the object
> + * load fails at btf__load.
> + */

That's first time I hear about such issue. Do you have an error log
from verifier?

Clang is smart enough to trim down used types to only those that are
actually necessary, so too big BTF shouldn't be a thing. But let's try
to dig into this and fix whatever issue it is, before giving up :)

> +struct sock {} __attribute__((preserve_access_index));
> +struct sockaddr {} __attribute__((preserve_access_index));
> +struct socket {
> +       struct sock *sk;
> +} __attribute__((preserve_access_index));
> +
> +struct inode {} __attribute__((preserve_access_index));
> +struct dentry {
> +       struct inode *d_inode;
> +} __attribute__((preserve_access_index));
> +struct file {
> +       struct inode *f_inode;
> +} __attribute__((preserve_access_index));
> +
> +

[...]
