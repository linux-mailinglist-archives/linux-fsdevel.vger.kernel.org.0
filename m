Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99E959787C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 23:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbiHQVAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 17:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242132AbiHQVAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:00:37 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EAE44577;
        Wed, 17 Aug 2022 14:00:36 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id q16so1030275ile.1;
        Wed, 17 Aug 2022 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=40iIAr8LYhq5AvW22C3hNEy4bzm1gOgGQLFh1Xg7rvI=;
        b=UzVVbziiojQv3LCsqLxQ/RkYiVAPOLMi+ecGqOGoVaUva1PaYPrdnN5Kor+wyv+doe
         oTcltujdLHKR9FH1b8i2IkoPcsgoSA7EH5wfIGX2GntI/IPVrLr6nVCSRVMVN7IlRjL5
         8tkCIFgNvhueXXmcaTok+gEBFkUmLIki7txlv8/l7GKHDBa0etfwuumZLwmAfl8qd0fB
         EAxbQFwZkFdoTaQfYHsh7FU5FbRyCHNU/OBBxIoh/tKonBmMAKr8IEs7H4Qd9wS4me1W
         XqvAgCsQ9nB2T6x++wkmAsOS0EoTMMbeycUNZ1H200y5AJxn493q1Jrb+EY4N2Wk2oVb
         FYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=40iIAr8LYhq5AvW22C3hNEy4bzm1gOgGQLFh1Xg7rvI=;
        b=WRODdIYz5X2O965nJrkEjmYRD22QD25n4gBA/S7hwBSRNGYgNb5gz3guFhZa0hKYYO
         JkuwvV1aPKExYWqmhA056wVGNZG5KUiU1VD4m8SwYZVEKS+zFo8PoSyj4ihfv/xzPcEy
         sHeR5Bgb11XDfBL1jw1qIzKPkligTEP9pvHByduxHcgeKZ5mfG5YhdTu3RFWZTOeIwhL
         2am4k66tbPRLz4bCjwyMBYC2NfqZOAC7dJuIMbZtWkucQOrRfqQ45O6FXNN2o+1jJutH
         AiCWIlLfbPWymgYQH8lM66VowgFWN9PPl64VnlB8El6wnJVyniHLoWQVP534Y4coNgkD
         FPmA==
X-Gm-Message-State: ACgBeo3zOum9BFCM574yG/E0kl4GrdnnmhgT8wrzOCWYJB5nFB0Pa9FV
        /fWO1NRImPNOkWDqVpmeQOUgEsNr6Iz1c843GVo=
X-Google-Smtp-Source: AA6agR6w3qxjJ9EAZgEhyHRkMEdSpaFT754F+1mteNpzDA698wU0APNIvqfrrwixCsek1yfY8Luu4BVO8zVdyBhJx2k=
X-Received: by 2002:a05:6e02:1ca9:b0:2e5:fa2a:6345 with SMTP id
 x9-20020a056e021ca900b002e5fa2a6345mr5042837ill.5.1660770035500; Wed, 17 Aug
 2022 14:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-8-ojeda@kernel.org>
 <202208171257.E256DAA@keescook>
In-Reply-To: <202208171257.E256DAA@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 17 Aug 2022 23:00:24 +0200
Message-ID: <CANiq72mOgDjp5eSJW6pkkNdF-YX0BSLofEwAm88oUzQFybQZGg@mail.gmail.com>
Subject: Re: [PATCH v9 07/27] rust: import upstream `alloc` crate
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:07 PM Kees Cook <keescook@chromium.org> wrote:
>
> Can you include an easy script (in the commit log) for this kind of
> verification?

Of course, good idea!

> For this, I have done:
>
> $ git am 0001-rust-import-upstream-alloc-crate.patch
> $ for i in $(diffstat -lp3 0001-rust-import-upstream-alloc-crate.patch); do
>         wget --quiet -O check.rs \
>          https://github.com/rust-lang/rust/raw/1.62.0/library/alloc/src/$i
>         diff -up rust/alloc/$i check.rs && echo $i: ok
>         rm -f check.rs
> done

Thanks for providing the steps like in the other version. This one is
even fancier :)

Cheers,
Miguel
