Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25D775603
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 11:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjHIJBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 05:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHIJBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:01:08 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138211BD9;
        Wed,  9 Aug 2023 02:01:07 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d61b6fc3015so272847276.1;
        Wed, 09 Aug 2023 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691571666; x=1692176466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8p6/0KX3fVxDGykNsAB8y9ONKtikHgYp/M2932Yhtg=;
        b=a+Zu8NL83uIaY2kPK/hzZzHyi7vS7ZDBxBzBas0D7lsWImIDv7Qwd1BiEcv6FKTPP1
         BdMSYMPzdND5JC7oC8v9M124xkp5LnmnJE5/klfgAzt2xAFxC8Ix/ATgHA73sGHIq6M5
         8OrafZcJ9GdZPgCALz/hIhLavsI9b/Dr6TdEQlqt8LZqcG0yWZaerqRjYwnLJH58K7vt
         JQ3+FbcofYPvCtDrlcpkILNmTu7Hd19Y/cUYPc+r6qC4noDNhfIpgilb6dDWBQ7jRR1L
         /D8Jy5DP8f/9nxAZ93mmMJwTgohGO38fsuD20oMAYUxgObu8MmDLJJ/dTzqsykEe/tu+
         mlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691571666; x=1692176466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8p6/0KX3fVxDGykNsAB8y9ONKtikHgYp/M2932Yhtg=;
        b=HJXhGOmI3l5QXFh6t7Ih1dvpLbJ13nGf8XVSbVJo9j3qQjyaVtryzhMZFzlOgllCr0
         mne7FtunRTNTIb79gHFTXnj4C+x2FasA8iIp5iSnDEBkUdiv9PKVAlK3tlqSWJ9tF/FP
         ezUaFpdQKRYJjjeYhXPp0wx3Mq/EfL2JA+fyYXlyT82fNQMjsIREdC9fkrEuqqYDIU+X
         v0PJjFdrw12Ft5C41BpwEqb6FyVZBy6VgxXrMVGismkRh6gMyRlNM0jNT0i3t8ZpPTiq
         vNNiMN2T3PaG5+75Nud0qltQinACazoWhJY6gHL6aEK0dlBhnn1wGvcrBjMdV1e4kPnE
         aG7Q==
X-Gm-Message-State: AOJu0YyOLEhc/9qn+6qeVV/o1HaAJC4em/cDfQj7NF5gEUVzI3r4+DhA
        iZ/JS2/EpRElFPp+RBoPFvQduHwoj4CQFhmpPn4=
X-Google-Smtp-Source: AGHT+IHuTiTRTDu7yLIKac8kPi++wFPcYqkZyXa6gABjSHv6p2rSzxLSrZKIX6NfdlXPlBCmD9m9fopnnqjOidvHgH4=
X-Received: by 2002:a25:e704:0:b0:cad:347e:2c8f with SMTP id
 e4-20020a25e704000000b00cad347e2c8fmr1661550ybh.39.1691571666128; Wed, 09 Aug
 2023 02:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230720152820.3566078-1-aliceryhl@google.com>
 <20230720152820.3566078-6-aliceryhl@google.com> <bee24ff5-444c-44f9-81c8-88ff310b401a@gmail.com>
In-Reply-To: <bee24ff5-444c-44f9-81c8-88ff310b401a@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 9 Aug 2023 11:00:54 +0200
Message-ID: <CANiq72mHU7n2jTPFsO=tjfqucrbe2ABSUYPUG6ctEerh4J+U_g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/5] rust: file: add `DeferredFdCloser`
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 9, 2023 at 6:34=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Please provide links, at least for the doc comment.

If you mean for the commit, then we should follow the kernel
convention instead. Please see my reply to Alice above.

> Ditto.

For code, we are also using the same convention.

Cheers,
Miguel
