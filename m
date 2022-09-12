Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9D25B5E07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 18:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiILQS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 12:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiILQSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:18:55 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FA63868A;
        Mon, 12 Sep 2022 09:18:54 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id m16so4805076ilg.3;
        Mon, 12 Sep 2022 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dKtqFa8Lj7sKVbipP1evfO/jZ1JEKgMyQWZPo5L2svY=;
        b=LYJrUWkBI5r0+ftj5RafEIHZV3TKIYV+GtfpLp5bklqBn7NVcwrDDRIvV40oAViNnw
         PAYijJ1aNQ4wlDinX3lV3rhtEr6tMQHvjF4Qpem/VsESXWSpyHspJurr8+MBPgRUnyS1
         JSyYvDet2ykXQxZD7W0xJQ/PbXRNVY8laRRXUVrXu8sLgFQQEl/CQnZve/OUnnSCjOC9
         SWBwhTCcO23qhLn2kVpDFhkjIR4NmaqXoDjc0wRMDxkqLUhcCuzscCc2alA3Bl4rAfUt
         b5JxVOVq1YMz+KhSjV168EA76QkBJyrj/895rj3CdO4d8Ut7a/C9fvaelZoVGDGCEllR
         K/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dKtqFa8Lj7sKVbipP1evfO/jZ1JEKgMyQWZPo5L2svY=;
        b=Z8HIHWjrHTTpQL4YWbVNpS5pVfa/1Ij5usrAUhmaIsTWwK6CUKPPFaJ5Pugg8zWZdS
         pn6PAv+rWCt3i03UJMvUAggMs4LiOoW0cG92h7RF3dCDbtm9hpIyKVCRoAWNXrRXwXeE
         tRytTY477Fd30MY+9SnHS/zDOZJEr5eymwiepSokmTYnwTuxWNFld6rtmghNcLbFsjC2
         +50U+msnwdaigM/hA6edJvKvBPARXxK9YM7Ko+ZLKwzzKv5A+vG03AAD0tG6m48//uA4
         aB4wbF9nk0xSyIlPdl45NcMaUkeW/6xR2NibHJ0UMFgYS2rjFo2ZzDcYmKXYIHI/drcG
         iD5Q==
X-Gm-Message-State: ACgBeo2wlpfoxvcydeojEc8KT/jBxnMNc2q+rByxP4e5tiyoYeNeCZxQ
        qbuIcOjoR/kvZqT26Xh9PmkMk8auYidpUCr3qWw=
X-Google-Smtp-Source: AA6agR6MemFAoJLParyi3ed9uKb3AZKl39DwttCreIuRBOy0bqj7TVF1woYsiMJbd8RxkweMyI0pKSKSOrXHyq4gx6o=
X-Received: by 2002:a05:6e02:1aac:b0:2f1:94e3:1805 with SMTP id
 l12-20020a056e021aac00b002f194e31805mr10813730ilv.72.1662999534105; Mon, 12
 Sep 2022 09:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-24-ojeda@kernel.org>
 <CAK7LNAQ=JfmrnGAUNXm_4RTz0fOhzfYC=htZ-VuEx=HAJPNtmw@mail.gmail.com>
In-Reply-To: <CAK7LNAQ=JfmrnGAUNXm_4RTz0fOhzfYC=htZ-VuEx=HAJPNtmw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 12 Sep 2022 17:18:43 +0100
Message-ID: <CANiq72kZEqAwr_m14mAFjHsFJTLjj7i4He0qyrprubpmBfOFdw@mail.gmail.com>
Subject: Re: [PATCH v9 23/27] Kbuild: add Rust support
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        patches@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
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

Hi Masahiro,

On Mon, Sep 12, 2022 at 5:08 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I have not figured out where this difference comes from.

It is the `RUSTC_BOOTSTRAP` environment variable: it allows to use
unstable featuers in the stable compiler.

We currently set it in the global `Makefile`, but we could be more
explicit and do it on each command if you think that would be better.

If you want that we keep using the global export, then we can add a
comment explaining this to clarify.

Cheers,
Miguel
