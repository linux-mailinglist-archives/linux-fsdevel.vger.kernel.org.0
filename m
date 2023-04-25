Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DFD6EE910
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 22:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjDYU3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 16:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbjDYU3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:29:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7451E146D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 13:29:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-506bfe81303so10578818a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682454584; x=1685046584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OoYLtgXDECRIcYzlRafhWyTnCuP0UwAEGivrVP3VPE=;
        b=FYxR9bkcCnyGu6VLNk7j9WxM/KRFvVzt71mQUOTS0fkQ0G3wVhp5Edo7FjQF6/DrIG
         9fxDJXOJFPsUPtea34kRfrBMhrYN+KIPhqyOaUaP+3nWlLvvTmqo6hAT7KnMuGx02gk/
         dKgBQN7zMc//+DWNnMiQ/a4z0CxBlugR+CaLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682454584; x=1685046584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OoYLtgXDECRIcYzlRafhWyTnCuP0UwAEGivrVP3VPE=;
        b=EbRcRcocs1zlaXSReUpuGnsyDZiuZPOyftxKEmOJSKL0EA39YDFfi9Mie7ylo2S4J+
         kO1ulO3hPDNsoKqukpHcDEk/SEBsb4vePNOuvDFN8hH2dv1QGrsmzTCir7Oldkwll2GU
         XPjMwydvQBML4xFz2WVVYu2wttxZjVn5RaeVCyroIUVEJhvSH63HYwLHmg46bXVeZT6l
         peWykaloO0h+l99gbF/vUbrwv/4U7L7rEtLNgcJq+iYgoD4dQ+1vLebVY9dxDkvkngr3
         hoNo3u3CXUPfkmiKgvo8Nv9R6UVR/y/PYs7cfPr3cZswzI2SyBYkoR436PxizUVc+dw8
         lDVA==
X-Gm-Message-State: AAQBX9fVnxzjGCz5NGX0VJjLxFk0T4YcY2cHu3B5L2tX2r8zBf9k5OoI
        lxbfRiIWOSV1rufY0l1SWQyOnPYQ8jibkWdAO/+jjQ==
X-Google-Smtp-Source: AKy350b7crm7wcjGwk0ZJfDse1r5I+XbrvWELAHf26AFk0dguwbitaKJ2I007gJW8JuLLisqObgr9Q==
X-Received: by 2002:aa7:d949:0:b0:506:bce0:48d6 with SMTP id l9-20020aa7d949000000b00506bce048d6mr15010289eds.5.1682454583678;
        Tue, 25 Apr 2023 13:29:43 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7d394000000b00504803f4071sm6001952edq.44.2023.04.25.13.29.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 13:29:43 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-506b20efd4cso10573085a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 13:29:42 -0700 (PDT)
X-Received: by 2002:aa7:da41:0:b0:506:8660:77a3 with SMTP id
 w1-20020aa7da41000000b00506866077a3mr17103894eds.37.1682454582655; Tue, 25
 Apr 2023 13:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk> <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
 <2e7d4f63-7ddd-e4a6-e7eb-fd2a305d442e@kernel.dk> <69ec222c-1b75-cdc1-ac1b-0e9e504db6cb@kernel.dk>
 <CAHk-=wiaFUoHpztu6Zf_4pyzH-gzeJhdCU0MYNw9LzVg1-kx8g@mail.gmail.com>
 <CAHk-=wjSuGTLrmygUSNh==u81iWUtVzJ5GNSz0A-jbr4WGoZyw@mail.gmail.com>
 <20230425194910.GA1350354@hirez.programming.kicks-ass.net> <CAHk-=wjNfkT1oVLGbe2=Vymp66Ht=tk+YKa9gUL4T=_hA_JLjg@mail.gmail.com>
In-Reply-To: <CAHk-=wjNfkT1oVLGbe2=Vymp66Ht=tk+YKa9gUL4T=_hA_JLjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Apr 2023 13:29:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVi5U_DF2Y+fnBuy=RH9OKfK7-MRmpnuZP2wmCdNCqYw@mail.gmail.com>
Message-ID: <CAHk-=wjVi5U_DF2Y+fnBuy=RH9OKfK7-MRmpnuZP2wmCdNCqYw@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 12:58=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok. I'll try to remember this, but maybe it might be worth documenting.

We might document it by just making it clear that it's not that we
want to read it "once", it's that we want to have a stable value.

There might be other situations where that is all we want.

IOW, maybe we could have something like

  #define READ_STABLE(x) \
      ({ __auto_type __val =3D (x); OPTIMIZER_HIDE_VAR(__val); __val; })

instead - although from a quick look, the code generation is pretty
much exactly the same.

I dunno. Just throwing that idea out there as a "if reading _once_
isn't the issue, maybe we shouldn't make the code look like it is"...

                Linus
