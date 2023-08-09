Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090CD775624
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 11:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjHIJJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 05:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHIJJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:09:38 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98701FCD;
        Wed,  9 Aug 2023 02:09:37 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d4d0ddc15feso3852973276.1;
        Wed, 09 Aug 2023 02:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691572177; x=1692176977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZRqyHdN+bb6JjBx+blO7CBOqR+vtAkWtIczQCNF/E8=;
        b=Vljv67WcCWPeKntdb3UPEU3bBrZSQYa8jxfh1h9QnK/XV98cHxr6j0Bal4qB9v9Qo4
         EkWjXbov5A+PAY39tnYkElkqzoo6WUb6MB6eopabCJNmcKPZPrhkca0TY+iu73iujQ8I
         1kr4lcXU2tVcFppRdfb97vBaI332NZtNvQzT3tvel10z6M1lnVhiqG+GNS/tdfw7rV2U
         /eV3aOdWsakwGVV2JN6boFdyRj3Ebkx7DKyCeoeKLGk6wM1CNbgrbOjbZyZOu12iwhr8
         Fd4ov14gKvxbU1WOMBhbvxMJn+ppB7Z3llr3sWQgg+R8q9q31P/LrU2nLUrd+H9IhBfb
         I6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691572177; x=1692176977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZRqyHdN+bb6JjBx+blO7CBOqR+vtAkWtIczQCNF/E8=;
        b=TkiBJiRlGX5jle6dqFoOsauEBi8AwnPCjamuJNdnP2nw4oPr2YhyKmGG7Mld71NPPU
         BANc0c7Iw76zqSi9WymQ2I7WnEvPMHHVIoOTdTqGVG28ZvtZ8o2Uh/irkbjD9X7p/CHb
         P6aXXcnesufQbmFMUkd349f6uBuUQDjla9KyQgoMxDPDCK/kZB2pDt2TmtOQYTqTML8g
         B2MAABNjBn1qTHpZTxS/zt0WauXssg+VHYD9cvkrWuso5dxFH6VdiyHXpEsf8RC8ijxj
         Rv12eqJ14IcuzQBJc1aaUm2RaciQ5ZNfg00+HAwbOfv5RR03sjXMiy5WXQRETliFhaFz
         CWrA==
X-Gm-Message-State: AOJu0YzhbxiAiaGGk6qvxzTmlrE/CoSI4TnakaMFYhAqapgaBk5RFJKw
        s7PufQwBclRmKuvonOxcYwshC10AKO4ZwDNGOhg=
X-Google-Smtp-Source: AGHT+IHYrGM2sNe8AaJmcFQSYvY+3ZVZmxRS/X5P4nJUNrhefBxGURmr3eFs3XSlOQdA1MhdArfePH5CX2RXeqHTtHw=
X-Received: by 2002:a25:db88:0:b0:d10:7acb:24e0 with SMTP id
 g130-20020a25db88000000b00d107acb24e0mr2113431ybf.41.1691572176991; Wed, 09
 Aug 2023 02:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230720152820.3566078-1-aliceryhl@google.com>
 <20230720152820.3566078-6-aliceryhl@google.com> <bee24ff5-444c-44f9-81c8-88ff310b401a@gmail.com>
 <CANiq72mHU7n2jTPFsO=tjfqucrbe2ABSUYPUG6ctEerh4J+U_g@mail.gmail.com>
In-Reply-To: <CANiq72mHU7n2jTPFsO=tjfqucrbe2ABSUYPUG6ctEerh4J+U_g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 9 Aug 2023 11:09:25 +0200
Message-ID: <CANiq72m5tbj2_N_s371d5N_4H1xpE2ahTHOUvFtUd+N0Y=0tsA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 9, 2023 at 11:00=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> If you mean for the commit, then we should follow the kernel
> convention instead. Please see my reply to Alice above.

One extra note: if it is a external repository, then yes, I would
definitely recommend adding a `Link` because readers may not be able
to easily `git show` the hash. But if it is the kernel tree, then it
is not needed.

Cheers,
Miguel
