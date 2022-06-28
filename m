Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B7555EADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 19:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiF1RUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 13:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiF1RUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EF437A18
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 10:20:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7E2161935
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 17:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12932C385A2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656436841;
        bh=YBEcIe8LEXTpiYbJtMSJ1VncueK3lmc9S5IiA0FB5yQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=etYwaiz7xWhwNPK3k+EDK0wHzVCcyUK/fSNg+AX0fiVYOQBmHXwOaFhM624vPy5CT
         tBIxMkiBU352Pq6S37doR/t8yEwZDx3BB7PSwwgxkwSB/w1vuiWYujAJSFaEmDGXj4
         GPLt5yjG8w5rPMRqkJs45s8skySDw6Q9kpMVjiwmzAwGsYD4JPVSm/CGjLvhw+o4Ss
         qiVNv1G6/AgkWLzXC4YTcADj0ER7ciCW0pcUEEbq9juax2i+QLY6IxFSt0XmSvXFxS
         MfC+DDaFh6Za2LuVXsLNmqg9LZL9ChMzMMh2bf8AlRoZFQngi4RYgafwMThBFVfGxc
         3nixZTtrnVxFQ==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-317a66d62dfso124247537b3.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 10:20:41 -0700 (PDT)
X-Gm-Message-State: AJIora+hHdY6DDjLeDtg8fODok7hqsTSVZxhLiVg35u6AwS/H1pVMRco
        HPmFhApAThdpZue30nqrppexCdF8MqpGOdrxKL7CHg==
X-Google-Smtp-Source: AGRyM1vBM2LegLm3Wr1k+Cn5bcujoFIr/MnnTidd67yBHyRco1INNvtuc5OFR6WQ2qsXbniL8qcBWPjaK9x0DilSyf0=
X-Received: by 2002:a0d:cbc8:0:b0:317:95ef:399e with SMTP id
 n191-20020a0dcbc8000000b0031795ef399emr23316677ywd.340.1656436840107; Tue, 28
 Jun 2022 10:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220628161948.475097-1-kpsingh@kernel.org> <20220628171325.ccbylrqhygtf2dlx@wittgenstein>
In-Reply-To: <20220628171325.ccbylrqhygtf2dlx@wittgenstein>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 28 Jun 2022 19:20:29 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4kWFwC82EAhtEYcMBPNe49zXd+uPBt1i09mVwLnoh0Bw@mail.gmail.com>
Message-ID: <CACYkzJ4kWFwC82EAhtEYcMBPNe49zXd+uPBt1i09mVwLnoh0Bw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] Add bpf_getxattr
To:     Christian Brauner <brauner@kernel.org>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 7:13 PM Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Jun 28, 2022 at 04:19:43PM +0000, KP Singh wrote:
> > v4 -> v5
> >
> > - Fixes suggested by Andrii
> >
> > v3 -> v4
> >
> > - Fixed issue incorrect increment of arg counter
> > - Removed __weak and noinline from kfunc definiton
> > - Some other minor fixes.
> >
> > v2 -> v3
> >
> > - Fixed missing prototype error
> > - Fixes suggested by other Joanne and Kumar.
> >
> > v1 -> v2
> >
> > - Used kfuncs as suggested by Alexei
> > - Used Benjamin Tissoires' patch from the HID v4 series to add a
> >   sleepable kfunc set (I sent the patch as a part of this series as it
> >   seems to have been dropped from v5) and acked it. Hope this is okay.
> > - Added support for verifying string constants to kfuncs
>
> Hm, I mean this isn't really giving any explanation as to why you are
> doing this. There's literally not a single sentence about the rationale?
> Did you accidently forget to put that into the cover letter? :)


Yes, actually I did forget to copy paste :)

Foundation for building more complex security policies using the
BPF LSM as presented in LSF/MM/BPF:

http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-xattr.pdf\

See: https://lore.kernel.org/bpf/20220624045636.3668195-1-kpsingh@kernel.org/


>
> >
> >
> >
> > Benjamin Tissoires (1):
> >   btf: Add a new kfunc set which allows to mark a function to be
> >     sleepable
> >
> > KP Singh (4):
> >   bpf: kfunc support for ARG_PTR_TO_CONST_STR
> >   bpf: Allow kfuncs to be used in LSM programs
> >   bpf: Add a bpf_getxattr kfunc
> >   bpf/selftests: Add a selftest for bpf_getxattr
> >
> >  include/linux/bpf_verifier.h                  |  2 +
> >  include/linux/btf.h                           |  2 +
> >  kernel/bpf/btf.c                              | 43 ++++++++-
> >  kernel/bpf/verifier.c                         | 89 +++++++++++--------
> >  kernel/trace/bpf_trace.c                      | 42 +++++++++
> >  .../testing/selftests/bpf/prog_tests/xattr.c  | 54 +++++++++++
> >  tools/testing/selftests/bpf/progs/xattr.c     | 37 ++++++++
> >  7 files changed, 229 insertions(+), 40 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/xattr.c
> >
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
