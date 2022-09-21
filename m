Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961D45BF686
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 08:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIUGmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 02:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIUGmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:42:24 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27DF80F41;
        Tue, 20 Sep 2022 23:42:23 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id u28so3360208qku.2;
        Tue, 20 Sep 2022 23:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=E8I9rBfQ5kkDMM02r33jjyjvis+HSRyzLrad88lTqXk=;
        b=YL+dYDNj+S7MpBPdlQLQpKnh1GekYhLusBiVSqhfu5/pKOLZi9CVWRPKwDBeJSyX7j
         kXXwRsYWJaZXGqzYQMOlix/p/ydrFKtV/DlaF1uXDNnWjm7Hs2FOjp46Qtc90TBq9vgx
         cU1QSByZBj+u7ypE4y9vgALDUmEKWPTJrHxaIx0UxYKkR4DjwV+VW4Tp5i1/zLIDoN6k
         rXY+vrF4bw9FfjwSIRjOst+tcha/1m7llkkmqwC1cFs6rCEXd5JmOHtx4FiVtKWuiHjX
         mWL4h+wY9Xj507+6DgsaRTrk32H+g1QZUv9QqBz9JfxkxwDJpOhjgRIkYyYKkiQT+drd
         GuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=E8I9rBfQ5kkDMM02r33jjyjvis+HSRyzLrad88lTqXk=;
        b=nmfV8YV4GD5TEuOWPndXURGEq84sMc8P7u+rLHg7yfIS7XuKZyeO4a4Yo9ffnL1JzI
         uXuzLm0VIw5FZ+PuKRYENKrbFiiz6IqD/cYatrkpNNAaipdWVeCAYZP4SatC7QTTsUZH
         ik4pOv8kaaxPBUs780UnJjdb0KnAh6oJ8UnWYDapWzFW9s68oMZbunaSUKKw1gDZsLfu
         t2woMqHlmfR/CvnwPF8xUomZnbB7lmp2N9Okpb+YwRfOn3z64RsgwNQtdMTwghtNML5/
         +mENOAawMGPLFvO5NCkcc57Gxxuwin41P1GvNUMUFzVUSH6ozzAyR9imq91Li5LeRJkk
         bdxg==
X-Gm-Message-State: ACrzQf24hczsShas7gnq1xHW20R/O+oL7GcdWheFyV2pvxy+pQgBun7J
        l0a4y5PGI618g60RCH4yb+I=
X-Google-Smtp-Source: AMsMyM5vNeur7GXJTuMTn4PsiPjjeN5I0wfzn23jiONcct+nwbDwCbwuJ13oqgPc0a+yCKBiselFoQ==
X-Received: by 2002:a05:620a:1b8b:b0:6cf:4dbc:e0a9 with SMTP id dv11-20020a05620a1b8b00b006cf4dbce0a9mr672098qkb.342.1663742543051;
        Tue, 20 Sep 2022 23:42:23 -0700 (PDT)
Received: from smtpclient.apple (pool-162-84-172-44.nycmny.fios.verizon.net. [162.84.172.44])
        by smtp.gmail.com with ESMTPSA id h5-20020ac87145000000b0034454d0c8f3sm1057520qtp.93.2022.09.20.23.42.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Sep 2022 23:42:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
From:   comex <comexk@gmail.com>
In-Reply-To: <20220920233947.0000345c@garyguo.net>
Date:   Wed, 21 Sep 2022 02:42:18 -0400
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>, ojeda@kernel.org,
        ark.email@gmail.com, bjorn3_gh@protonmail.com, bobo1239@web.de,
        bonifaido@gmail.com, Boqun Feng <boqun.feng@gmail.com>,
        davidgow@google.com, dev@niklasmohrin.de, dsosnowski@dsosnowski.pl,
        foxhlchen@gmail.com, geofft@ldpreload.com,
        gregkh@linuxfoundation.org, jarkko@kernel.org,
        john.m.baublitz@gmail.com, leseulartichaut@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        me@kloenk.de, milan@mdaverde.com, mjmouse9999@gmail.com,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        thesven73@gmail.com, viktor@v-gar.de,
        Andreas Hindborg <andreas.hindborg@wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C85081E7-99CB-421F-AA3D-60326A5181EB@gmail.com>
References: <20220805154231.31257-13-ojeda@kernel.org>
 <Yu5Bex9zU6KJpcEm@yadro.com>
 <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
 <Yu6BXwtPZwYPIDT6@casper.infradead.org> <Yyh3kFUvt2aMh4nq@wedsonaf-dev>
 <CAHk-=wgaBaVaK2K=N05fwWSSLM6YJx=yLmP4f7j6d6o=nCAtdw@mail.gmail.com>
 <CAHk-=whTDbFZKB4KJ6=74hoLcerTm3JuN3PV8G6ktcz+Xm1qew@mail.gmail.com>
 <YyivY6WIl/ahZQqy@wedsonaf-dev>
 <CAHk-=whm5Ujw-yroDPZWRsHK76XxZWF1E9806jNOicVTcQC6jw@mail.gmail.com>
 <Yyjut3MHooCwzHRc@wedsonaf-dev>
 <CAHk-=wityPWw4YkHeMNU4iGanyiC3UwDRhbOHYCJrhB2paCGwA@mail.gmail.com>
 <CAFRnB2VPpLSMqQwFPEjZhde8+-c6LLms54QkMt+wZPjOTULESw@mail.gmail.com>
 <CAHk-=wiyD6KqZN8jFkMHPRPxrbyJEUDRP6+WaH9Q9hjDB5i1zg@mail.gmail.com>
 <CAHk-=wj6sDFk8ZXSEKUMj-J9zfrMSSO3jhBEaveVaJSUpr=O=w@mail.gmail.com>
 <87a66uxcpc.fsf@email.froward.int.ebiederm.org>
 <20220920233947.0000345c@garyguo.net>
To:     Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 20, 2022, at 6:39 PM, Gary Guo <gary@garyguo.net> wrote:
>=20
> It should be noted however, atomic context is not something that a
> token can represent. You can only use tokens to restrict what you =
*can*
> do, but not what you *can't* do. There is no negative reasoning with
> tokens, you can't create a function that can only be called when you
> don't have token.

On the other hand, it ought to be feasible to implement that kind of =
=E2=80=99negative reasoning' as a custom lint.  It might not work as =
well as something built into the language, but it should work decently =
well, and could serve as a prototype for a future built-in feature.=
