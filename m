Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D95E5F179B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 02:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiJAArh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 20:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiJAArf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:47:35 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B821A5998
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 17:47:34 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h194so4517601iof.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 17:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zGaqpg2niwnnEvwqmIq3slYbxa8AmaMub7+ROy/hgu8=;
        b=n6OF9mj0yMYABdvzdK6rA8MJxGje/mxfz7zosLl9tRuxM7trmf8t4PoRYbLP9dArJY
         EtUZudC0AEwHoZrRNinMawgIT3m61e66Ew03oReEeSHpWYqKi+cJSKHRmiR6qlM8Yf6+
         5j9/SHLnjJHaPnlU2aH1XyIEs6tf/AfQTdtxixd+OWR+cH6NHhAIahON5dQb6c3t/HPg
         9bYoNDKkSTyRm0gvNmzUWnnaBkibizg0xkpWX6taNm7F3YpqfH3YuM03SHcbsueXu5KG
         9RxtJfNHpr/MvOZAqrmKsxtQSFHS6oSfkEOHBPnC3eaPxs36n+D3xjynrmA2rUGWOIfk
         Cw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zGaqpg2niwnnEvwqmIq3slYbxa8AmaMub7+ROy/hgu8=;
        b=t2378TCR1WyvlfkungCDTDbPsNSzZTfHPDqMJgm9i1BLmYtypGOU351E2virPk0ypd
         dAm4A40+TAyewS4fpgMJztAgKTpUPir77UYgZrYESA6AOpAt9tsS3pJJjUVYVKe5JBpP
         r4+YYT8qgfOoytNNlY/8L5FOo8NlKZgTlQhHv5MGM71cZOiL6FcP809fRiPJhrzug0sZ
         fPpfOeJKx9XEC69JsIcrnfwDSWmYO6AUpxgn0+Bl3o8DeCiTQPHyJaWxbiPLBkgT2B+k
         4xK2wvK4tU4do/0FigdJnkuN/qY1VN87159kLGni6jcvc4VMKorLpnbw9O20+Tu8qVmn
         nRDw==
X-Gm-Message-State: ACrzQf2sE8XlAFDdgUur8klL0hpAh7xhpGPDzTXAEijcMYsZ9m2BMN6W
        okMRNOX7RTNMNz4X25XdsYzjNTN+5j8FoLZ8PV1aGg==
X-Google-Smtp-Source: AMsMyM55pd0uxJsLBNf6039vP4c9CDdkSitv4YkLN1Bdvy8JgnXFM8O9mXINvidFTR2VL6W31P9Ks7TAZq2eKnElODQ=
X-Received: by 2002:a02:a493:0:b0:35a:7a4b:3efa with SMTP id
 d19-20020a02a493000000b0035a7a4b3efamr6227411jam.117.1664585253162; Fri, 30
 Sep 2022 17:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com> <1fc38ba0-2bbe-a496-604d-7deeb4e72787@linux.dev>
 <YzQ+ke3JIx69Plld@bfoster>
In-Reply-To: <YzQ+ke3JIx69Plld@bfoster>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Fri, 30 Sep 2022 17:47:22 -0700
Message-ID: <CA+PiJmQC9ghrmNdtbfWBbtnngm6F1g0X2HeRbxJGMLxEwuLxeg@mail.gmail.com>
Subject: Re: [PATCH 00/26] FUSE BPF: A Stacked Filesystem Extension for FUSE
To:     Brian Foster <bfoster@redhat.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 28, 2022 at 5:31 AM Brian Foster <bfoster@redhat.com> wrote:
>
> I had a similar thought when poking through this. A related question I
> had is how much of a functional dependency does the core passthrough
> mechanism have on bpf? If bpf is optional for filtering purposes and
> isn't absolutely necessary to set up a basic form of passthrough, I
> think review would be made easier by splitting off those core bits from
> the bpf components so each part is easier to review by people who know
> them best. For example, introduce all the fuse enhancements, hooks and
> cleanups to set up a passthrough to start the series, then plumb in the
> bpf filtering magic on top. Hm?
>

The passthrough code has no dependency on the bpf functionality. I can
reorder these patches to not have any bpf changes until patch 24. I'll
probably change the order like I described in my previous email. The
patches do become a lot more useful once the pre/post filters enter
the mix though.

> BTW if the bpf bits are optional, how might one mount a fuse/no
> daemon/passthrough filesystem from userspace? Is that possible with this
> series as is?
>
This is provided by patch 23. You can mount with the "no_daemon"
option. Anywhere FUSE attempts to call the daemon will end up with an
error, since the daemon is not connected. If you pair this with
"root_dir=[fd]" and optionally "root_bpf=[fd]", you can run in a
daemon-less passthrough mode. It's a bit less exciting though, since
at that point you're kind of doing a bind mount with extra steps.
Useful for testing though, and in theory you may be able to implement
most of a daemon in bpf.

> Something more on the fuse side.. it looks like we introduce a pattern
> where bits of generic request completion processing can end up
> duplicated between the shortcut (i.e.  _backing()/_finalize()) handlers
> and the traditional post request code, because the shortcuts basically
> bypass the entire rest of the codepath. For example, something like
> create_new_entry() is currently reused for several inode creation
> operations. With passthrough mode, it looks like some of that code (i.e.
> vfs dentry fixups) is split off from create_new_entry() into each
> individual backing mode handler.
>
> It looks like much of the lower level request processing code was
> refactored into the fuse_iqueue to support things like virtiofs. Have
> you looked into whether that abstraction can be reused or enhanced to
> support bpf filtering, direct passthrough calls, etc.? Or perhaps
> whether more of the higher level code could be refactored in a similar
> way to encourage more reuse and avoid branching off every fs operation
> into a special passthrough codepath?
>
> Brian
>

The largest opportunity for reducing duplicate code would probably be
trying to unify the backing calls between overlayfs and our work here.
In places where you need to do more work than directly calling the
relevant vfs calls we probably could factor out some common helpers. I
haven't looked too much into that yet since I want to see where the
fuse-bpf code ends up before I try to commit to that. I've thought
about unifying some of the code around node creation in the backing
implementations, but haven't gotten around to it yet. We definitely
need to branch off for every operation though, since fuse otherwise
has no concept of the backing filesystem. We do have some more work to
do to ensure there is a clean handoff between regular fuse and
fuse-bpf. The goal is to be able to handle just the parts you need to
in the daemon, while the rest can be passed through if you're acting
as a stacked filesystem. There are some oddities around things fuse
does for efficiency that fuse-bpf doesn't need to do. For instance, if
you're using passthrough for getattr, you don't really need to do a
readdir_plus, since you don't have to worry about all the extra daemon
requests.

-Daniel
