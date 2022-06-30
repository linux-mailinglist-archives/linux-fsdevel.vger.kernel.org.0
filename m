Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EDE56204F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiF3Q3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 12:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiF3Q3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:29:06 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7751735242;
        Thu, 30 Jun 2022 09:29:05 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id w187so18803365vsb.1;
        Thu, 30 Jun 2022 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1a1RzxlSCIM5dhtCqVAmfijoRUkJ4QQhUiMrMG0/U+k=;
        b=nge/4Og2obmsAZqMW7WDf73S0qVksl/kWK/6XGt1QGAZoUZvRdszv07aJYpM7wDVPr
         CV6hD27j9UyiaFC+frjNcMd0HBOqkEkvLyDFUGVUrfmN+PacsRLCngGVi/7b554YK7Fz
         JMQwNuMEurGBA5RLnxHaq+Dnvb95xEH5I2X9ioJxpUqxB2e5s2npEncLYf7hY/MbIIU3
         Q65sZmCKg5gdcAmX2b8AcCRghD21iTBp3A0nLVJBjdDV1OdGjnp+ZiS76DEppwDHACvR
         fmN3N3CHeI4syPY5ia37AulmGr4Zt0iepvuBeMqe9S4V7h2OaeNDo3nIuRr19nQgHB3C
         ojMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1a1RzxlSCIM5dhtCqVAmfijoRUkJ4QQhUiMrMG0/U+k=;
        b=tEv24tUDxCwMmErgLKbwNIJNwUwAmKitSWAn/Xj3gLPuLQjM/AN1ryR8CT4yREVW25
         5KPyHLNIOHFoTHozEQ5tXfKn3uKyilf34j0FW1rI7nML8hQd1IXofmbQGpOSOE1E58u6
         0xneGixD/o7jZHlKyHCOfK6zIExswlAuwkhGV6cjdwf6kdBlqUJt1bWwovU9NGzJXmv9
         G10VhE9QdJKJ1QE8ZBmlWdt0SB/kwCU39h37UeREuAsoxozs/Du8iIPhizPvcYmpynmL
         Pp6txlNhPpS5jbVyisijl7MvpytvGgU3ooKoJE6joO7Cm9jfG3233pSCl5s8sbsn9xar
         w+vg==
X-Gm-Message-State: AJIora/m+q477irGsQzmaGoUyhNWrPq+08TCi0RJ3U43w1BoAkkitKn3
        CvqZwPoH3To/HrEOnfNDcEtHWop+uyiXE6ZutF8=
X-Google-Smtp-Source: AGRyM1sgS6ijsKCwRqwmgQKWMOIBMYAygsJYHI3yCEwvUdnIrxokOV2PwPiDavJUDDs9Cm+7xBjrbstsdcfeGiezf0c=
X-Received: by 2002:a67:c113:0:b0:354:3ef9:3f79 with SMTP id
 d19-20020a67c113000000b003543ef93f79mr8992976vsj.3.1656606544004; Thu, 30 Jun
 2022 09:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220628161948.475097-1-kpsingh@kernel.org> <20220628161948.475097-6-kpsingh@kernel.org>
 <20220628173344.h7ihvyl6vuky5xus@wittgenstein> <CACYkzJ5ij9rth_v3KQrCVYsQr2STBEWq1EAzkDb5D06CoRRSjA@mail.gmail.com>
 <CAADnVQ+mokn3Yo492Zng=Gtn_LgT-T1XLth5BXyKZXFno-3ZDg@mail.gmail.com>
 <20220629081119.ddqvfn3al36fl27q@wittgenstein> <20220629095557.oet6u2hi7msit6ff@wittgenstein>
 <CAADnVQ+HhhQdcz_u8kP45Db_gUK+pOYg=jObZpLtdin=v_t9tw@mail.gmail.com>
 <20220630114549.uakuocpn7w5jfrz2@wittgenstein> <CACYkzJ4uiY5B09RqRFhePNXKYLmhD_F2KepEO-UZ4tQN09yWBg@mail.gmail.com>
In-Reply-To: <CACYkzJ4uiY5B09RqRFhePNXKYLmhD_F2KepEO-UZ4tQN09yWBg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 30 Jun 2022 19:28:52 +0300
Message-ID: <CAOQ4uxhKG7wDsh2qhtzcF7QYFRD51r500C9YKp2NrBPJtjphww@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 5/5] bpf/selftests: Add a selftest for bpf_getxattr
To:     KP Singh <kpsingh@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Serge Hallyn <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jan Kara <jack@suse.cz>, Alessio Balsini <balsini@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >
> > This discussion would probably be a lot shorter if this series were sent
> > with a proper explanation of how this supposed to work and what it's
> > used for.
>
> It's currently scoped to BPF LSM (albeit limited to LSM for now)
> but it won't just be used in LSM programs but some (allow-listed)
> tracing programs too.
>

KP,

Without taking sides in the discussion about the security aspect of
bpf_getxattr(),
I wanted to say that we have plans to add BPF hooks for fanotify event
filters and
AFAIK Alessio's team is working on adding BPF hooks for FUSE bypass decisions.

In both those cases, being able to tag files with some xattr and use
that as part of
criteria in the hook would be very useful IMO, but I don't think that
it should be a
problem to limit the scope of the allowed namespace to security.bpf.* for these
use cases.

Thanks,
Amir.
