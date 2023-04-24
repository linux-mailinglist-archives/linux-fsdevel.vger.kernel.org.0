Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6508D6ED167
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 17:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjDXPdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjDXPdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:33:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD9559E
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 08:32:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so34345087a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1682350374; x=1684942374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uAia9ZoCM3Ngt40DYLr2QLseOj/p7pPYWNkC2fjWJmw=;
        b=qWrSGUzCxRq8qH9ciyQYay96/ootXHgah+P6qqyhGbCAQ2pJ8/OxJrzulk56To27uy
         09RLg/kTfw37Y4n+Y6DBPHrqNJM86jTGeI+B59T2u0X1ivH2gkzn4r7IIy7tcMBPzleL
         451KVjoReU+5shixxVPasIdCw/4ump/BEaTRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682350374; x=1684942374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAia9ZoCM3Ngt40DYLr2QLseOj/p7pPYWNkC2fjWJmw=;
        b=VT4/4+m2noapN3qeHsh1Z0ugkeZ8l4RETaY3h0rNjnMMckowgb2HPdRmQWzbsgJrta
         nOdYuUfypqpctzST1RfqfbNrDAvxtXnLyWw9svcJ0BJRk1euC+GwuFop2sAQlSfbn+rA
         +bVEKbXhUVGkxSf79Swtxo04pCSbCeaJET70Kcgs5YO5t/KPT8lPqfeq6QKIf38WWTin
         7rmaCuYgtkm+bK3sElHALOZM7kHw4lrHiyk1xiJsGM/5UHl+DrC6GWgjnaagOJbZzSn4
         YZHc3B+DPxPUMjsOlu8fU18mudc2SpftS2uilMKFb/fyVJRUqhzgnpEgqj2QVQ20ouyb
         EGjA==
X-Gm-Message-State: AAQBX9creSK/vbHIC1i23UNmomJYLajLkG7KgxKXnsElG0zCLzk1+jiZ
        mutQ1EgvfoH4z1xNBqfyGx60B7g6X+o6IxUMEDbl7g==
X-Google-Smtp-Source: AKy350ZlEFYElE3Cz+YrZZbx+udm5MYxX+58hoksQpdxqtGw8JQgjq/51zlo+VJfHxiyRLGkhE1nZhNtsXCZO/Kgvz0=
X-Received: by 2002:a17:906:d1cb:b0:957:9ddd:8809 with SMTP id
 bs11-20020a170906d1cb00b009579ddd8809mr8178755ejb.35.1682350374328; Mon, 24
 Apr 2023 08:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Apr 2023 17:32:42 +0200
Message-ID: <CAJfpegtuNgbZfLiKnpzdEP0sNtCt=83NjGtBnmtvMaon2avv2w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 00/37] FUSE BPF: A Stacked Filesystem
 Extension for FUSE
To:     Daniel Rosenberg <drosen@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 18 Apr 2023 at 03:40, Daniel Rosenberg <drosen@google.com> wrote:
>
> These patches extend FUSE to be able to act as a stacked filesystem. This
> allows pure passthrough, where the fuse file system simply reflects the lower
> filesystem, and also allows optional pre and post filtering in BPF and/or the
> userspace daemon as needed. This can dramatically reduce or even eliminate
> transitions to and from userspace.

I'll ignore BPF for now and concentrate on the passthrough aspect,
which I understand better.

The security model needs to be thought about and documented.  Think
about this: the fuse server now delegates operations it would itself
perform to the passthrough code in fuse.  The permissions that would
have been checked in the context of the fuse server are now checked in
the context of the task performing the operation.  The server may be
able to bypass seccomp restrictions.  Files that are open on the
backing filesystem are now hidden (e.g. lsof won't find these), which
allows the server to obfuscate accesses to backing files.  Etc.

These are not particularly worrying if the server is privileged, but
fuse comes with the history of supporting unprivileged servers, so we
should look at supporting passthrough with unprivileged servers as
well.

My other generic comment is that you should add justification for
doing this in the first place.  I guess it's mainly performance.  So
how performance can be won in real life cases?   It would also be good
to measure the contribution of individual ops to that win.   Is there
another reason for this besides performance?

Thanks,
Miklos
