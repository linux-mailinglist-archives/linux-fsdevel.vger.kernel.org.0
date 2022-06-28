Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D091C55EB0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiF1R3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiF1R3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:29:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A15122B10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 10:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A38BB81F39
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 17:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1346DC385A2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 17:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656437383;
        bh=TqEYTZnMgksw0Z2Wcnpbc4laQ2Yl9I0Q2zLV8wa/sQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BeJx60YZ3iy46fSHB9s+0nASIyUqWvA5+4pTt9eJ79A+Wrt+pQlWfxX7v5Ck/6slT
         tLMwCuJO51fg9c9xdASV2P53gX7lO12ZrMKhfzXs0CFNLHZGQVUxeKND3MDZGz70Cw
         luWuzf4Q7oLInMYZGWGOkrPUsWMN7/fvVP17+jS4ooL9s5pTP1SMJHZpA3kzkPji7g
         Z9ETPkf9PW57hK9VvPU74e+ViVODollDaeHEhlYNB461F4LRpc6/HWHZuAHTGjpoCC
         lH7U4YGoJa78AggNbfxzrmAxJtlspdezcFBU3y757NLBUXjHW0X2PyiHdHhIabJnSe
         lvPEKCII3E4IQ==
Received: by mail-yb1-f169.google.com with SMTP id p7so21979365ybm.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 10:29:43 -0700 (PDT)
X-Gm-Message-State: AJIora+axalHKqRkBdld6tZUtQVrL0vuuIFXc3TtFokqSbvxMTjRqLJ/
        4kPlklnSrHo9UQ44G10YKYzqMcF8XUipZ75g7Ywv1A==
X-Google-Smtp-Source: AGRyM1uL5WWmevZOAv80me4K4eb2sB6Nm3KzUbn3rqFmoXRjZ0358Dge6nXwFDzpRGo+tp+WsYXuS8PaHbnt+rMCyUg=
X-Received: by 2002:a05:6902:701:b0:66d:2797:ec90 with SMTP id
 k1-20020a056902070100b0066d2797ec90mr4702142ybt.84.1656437382101; Tue, 28 Jun
 2022 10:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220628161948.475097-1-kpsingh@kernel.org> <20220628161948.475097-5-kpsingh@kernel.org>
 <Yrs4+ThR4ACb5eD/@ZenIV>
In-Reply-To: <Yrs4+ThR4ACb5eD/@ZenIV>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 28 Jun 2022 19:29:31 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4RyrF4dZWwt-Wo75AbE7eK7Q6dbr+b8DHcw7paMeUEwA@mail.gmail.com>
Message-ID: <CACYkzJ4RyrF4dZWwt-Wo75AbE7eK7Q6dbr+b8DHcw7paMeUEwA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/5] bpf: Add a bpf_getxattr kfunc
To:     Al Viro <viro@zeniv.linux.org.uk>
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

On Tue, Jun 28, 2022 at 7:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jun 28, 2022 at 04:19:47PM +0000, KP Singh wrote:
> > LSMs like SELinux store security state in xattrs. bpf_getxattr enables
> > BPF LSM to implement similar functionality. In combination with
> > bpf_local_storage, xattrs can be used to develop more complex security
> > policies.
> >
> > This kfunc wraps around __vfs_getxattr which can sleep and is,
> > therefore, limited to sleepable programs using the newly added
> > sleepable_set for kfuncs.
>
> "Sleepable" is nowhere near enough - for a trivial example, consider
> what e.g. ext2_xattr_get() does.
>         down_read(&EXT2_I(inode)->xattr_sem);
> in there means that having that thing executed in anything that happens
> to hold ->xattr_sem is a deadlock fodder.
>

We could limit this to sleepable LSM hooks:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/bpf_lsm.c#n169

and when we have abilities to tag
kernel functions and pointers with the work Yonghong did
(e.g. https://reviews.llvm.org/D113496) we can expand the set.


> "Can't use that in BPF program executed in non-blocking context" is
> *not* sufficient to make it safe.
