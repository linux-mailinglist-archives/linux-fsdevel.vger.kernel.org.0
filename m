Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05587BEE8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 00:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378945AbjJIWyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 18:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378964AbjJIWx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:53:56 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9289D
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 15:53:52 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9a50ac5eabso332273276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 15:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696892031; x=1697496831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAItUfujL+mWM9AjntNyz6dEI1LC27fi7NkwloZDHY0=;
        b=P3AP2K7x2UukO6qS5KFMowt6zx012uVQtz0+IFTGvEOQgZ6bQ/XIPVskKIcWeUEkIs
         zagAWqFNIsj0sVamXPwgYmGGy04N7Rb0/gMMWN39Pl5EgnHcm/vE+MLGxVKeXj3ZpBSt
         wCE07Qhr3+9rHrwAcVU4JCPICnh7LynR9du4y0AOR0kCOVLOKeBAfv0w2etD8FKgnrE2
         IF80gHWcZ5G8zaLCZngezMcxB/nCRR7S4NNnEy4Jdre84F/tElyPuyPqHm0B82oFN8vd
         TgvoqMMKHyyH2GikKGlnvWCErOhMNnQ5YEsIdqCvhGnwtxsRs2VG+61uMLj++iF4nl4u
         M/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892031; x=1697496831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAItUfujL+mWM9AjntNyz6dEI1LC27fi7NkwloZDHY0=;
        b=BZV5u7pZe6k/eJTfCk3lhqabFECcSkufT6oT8P1NncuN2T45uUT3SWDnT531WqmIjd
         rhL3QTApUA/MFt8D8uVaMmS4z+g5XzNiU5ACBOk9VXYLMQDPerMrcNpVRJx36dyIzZpP
         w1CWwYavTLFIfsrOBA6V5+tiApyu70ww28sPWmylSRHbXybYyAJYiP9oTe7+GGNNttWo
         DOpUXSVogYZGVXHTsKhQtJbiWxeR0P34muPQMMfWY8E9wOdkdmet5B41YliNpWPjWQ7R
         X/Gl5FTubO1sh6WBNLXowVCzHs47IW++dvgd9sigjez6g6eerViuAEkDFYR7LnDB2+2j
         ZzBQ==
X-Gm-Message-State: AOJu0YzEb+Fg593Nw07+2Qo+IlczaPqg8dg80St1lqaXe64O4Mxx0Xgn
        R00InIiftr+4VLYgORSUxO8dodzT8iYaVBHVDws7
X-Google-Smtp-Source: AGHT+IEPiXf9wuTcoTK3FORZIR49aCFr3p9oLJrFSqR5cezvxqmIqJ9VXVN+Ozcg5dWNg6hXIiJg/XsmuoYE2AW0rNM=
X-Received: by 2002:a5b:151:0:b0:d81:8da3:348e with SMTP id
 c17-20020a5b0151000000b00d818da3348emr14341516ybp.41.1696892031418; Mon, 09
 Oct 2023 15:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230919214800.3803828-1-andrii@kernel.org> <20230919214800.3803828-4-andrii@kernel.org>
 <20230926-augen-biodiesel-fdb05e859aac@brauner> <CAEf4BzaH64kkccc1P-hqQj6Mccr3Q6x059G=A95d=KfU=yBMJQ@mail.gmail.com>
 <20230927-kaution-ventilator-33a41ee74d63@brauner> <CAEf4BzZ2a7ZR75ka6bjXex=qrf9bQBEyDBN5tPtkfWbErhuOTw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ2a7ZR75ka6bjXex=qrf9bQBEyDBN5tPtkfWbErhuOTw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Oct 2023 18:53:40 -0400
Message-ID: <CAHC9VhTTzOCo8PL_wV=TwXHDjr7BymESMq8G1WQvsXnrw627uw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 03/13] bpf: introduce BPF token object
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 12:03=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Sep 27, 2023 at 2:52=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:

...

> > IOW, everything stays the same apart from the fact that bpf token fds
> > are actually file descriptors referring to a detached bpffs file instea=
d
> > of an anonymous inode file. IOW, bpf tokens are actual bpffs objects
> > tied to a bpffs instance.
>
> Ah, ok, this is a much smaller change than what I was about to make.
> I'm glad I asked and thanks for elaborating! I'll use
> alloc_file_pseudo() using bpffs mount in the next revision.

Just a FYI, I'm still looking at v6 now, but moving from an anon_inode
to a bpffs inode may mean we need to drop a LSM hook in
bpf_token_create() to help mark the inode as a BPF token.  Not a big
deal either way, and I think it makes sense to use a bpffs inode as
opposed to an anonymous inode, just wanted to let you know.

--=20
paul-moore.com
