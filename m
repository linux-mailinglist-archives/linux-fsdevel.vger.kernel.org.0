Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8F6ED03A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 16:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjDXOWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjDXOV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:21:59 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCFF8A51
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 07:21:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4edc63e066fso12136e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682346113; x=1684938113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=enbgg+lqaw2zyPJZ1pbEEFHlLXGIOHAiWtJzwllHKYk=;
        b=d/qZRyT5eP+jU3o4eFNHhYxVnfxA6MScMHl7EjDAUKW8eeAqkTfrkneA4vEc9uBXwZ
         h4ZGQJRzWcXcoXy42qQQAV1i4o0OUT7utHIj2IoI7VFMMkb3DSzd4yHsNk9rQKJ+Q0Ba
         nMOvmgEa5xIOvPXkoUS0vb2tva2pNXVvMgkmCungv6F2+M0Fwnc1Jl7fLI7rLZaZWeiU
         o/IcRqlPrSKXcDkM6nZYnx9nYtaTtj80DS33Cf5UiYjI54XuWOklqvx5bm9Ikxcy3ndx
         QrzsivjDGtZL5voUC900DRzJleGdv4R1Yf5ZDQmV5GoyD/NumwZc188PEi5kVsnKNkNp
         Ri3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682346113; x=1684938113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enbgg+lqaw2zyPJZ1pbEEFHlLXGIOHAiWtJzwllHKYk=;
        b=JudcNmtjHB9fFXwPjkOthqhDlVVDMFDasoNCXR/j8R24Av9lsSobbvSuRofPYQR/pz
         KFlrVmChZA9mSHjdUzLUoFINEQXRd5a2j8QrLE6tbGPKwdv61tdV6c4+cgqWOSc1rf4f
         cC6cHymqlgmtJd0+J5thL9TohnGbiGFoouaIF9HWxQfokxqZXKU2BkJpEah2Qlz/1Efx
         WkrLOuSZNlWCqMXD0J4xLqf/1hQjeHJvNrxP14RBIf3gC29eSnPootEQdfAqya+Qm+3S
         jN/urtfbU4cVEWc1uh2ST5OLkAIcRzqz6UrH2w/TkNGntalkGDONx4/0uTq+ozCkuULG
         EeuA==
X-Gm-Message-State: AAQBX9fsCW43SpnHNy9cepZF83zWleswDW7oH/Wi66HTZmOmFgyGsRxn
        l7iyhxWi3BzxZJC65njEs2uXn+oMa/IUgK7uEXg0Jw==
X-Google-Smtp-Source: AKy350by1ELWJ/CmwHDxqXyCll4tWAI6i/5CdlY/6JgR+z+2K/yBvdGz9oOpWc3MDBoV51yKVHZIfVVj7zO9PkuCDIY=
X-Received: by 2002:a05:6512:39c4:b0:4ef:ef1d:a97b with SMTP id
 k4-20020a05651239c400b004efef1da97bmr110782lfu.0.1682346112665; Mon, 24 Apr
 2023 07:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d0737c05fa0fd499@google.com> <CACT4Y+YKt-YvQ5fKimXAP8nsV=X81OymPd3pxVXvmPG-51YjOw@mail.gmail.com>
 <ZEaCSXG4UTGlHDam@casper.infradead.org> <CACT4Y+YeV8zU2x+3dpJJFez5_33ic3q7B2_+KYrcNOQxooRWpw@mail.gmail.com>
 <ZEaN7PP794H2vbe/@casper.infradead.org>
In-Reply-To: <ZEaN7PP794H2vbe/@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Apr 2023 16:21:40 +0200
Message-ID: <CACT4Y+aHoUT22Cd3yfBzW78iiwy-4P-L0=SHJJ5qaN--n-D2Ng@mail.gmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in __filemap_remove_folio /
 folio_mapping (2)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com>,
        djwong@kernel.org, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Apr 2023 at 16:10, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Apr 24, 2023 at 03:49:04PM +0200, Dmitry Vyukov wrote:
> > On Mon, 24 Apr 2023 at 15:21, Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Apr 24, 2023 at 09:38:43AM +0200, Dmitry Vyukov wrote:
> > > > On Mon, 24 Apr 2023 at 09:19, syzbot
> > > > <syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com> wrote:
> > > > If I am reading this correctly, it can lead to NULL derefs in
> > > > folio_mapping() if folio->mapping is read twice. I think
> > > > folio->mapping reads/writes need to use READ/WRITE_ONCE if racy.
> > >
> > > You aren't reading it correctly.
> > >
> > >         mapping = folio->mapping;
> > >         if ((unsigned long)mapping & PAGE_MAPPING_FLAGS)
> > >                 return NULL;
> > >
> > >         return mapping;
> > >
> > > The racing write is storing NULL.  So it might return NULL or it might
> > > return the old mapping, or it might return NULL.  Either way, the caller
> > > has to be prepared for NULL to be returned.
> > >
> > > It's a false posiive, but probably worth silencing with a READ_ONCE().
> >
> > Yes, but the end of the function does not limit effects of races. I
>
> I thought it did.  I was under the impression that the compiler was not
> allowed to extract loads from within the function and move them outside.
> Maybe that changed since C99.
>
> > to this:
> >
> > if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) && folio->mapping)
> >    if (test_bit(AS_UNEVICTABLE, &folio->mapping->flags))
> >
> > which does crash.
>
> Yes, if the compiler is allowed to do that, then that's a possibility.

C11/C++11 simply say any data race renders behavior of the whole
program undefined. There is no discussion about values, functions,
anything else.

Before that there was no notion of data races, so it wasn't possible
to talk about possible effects and restrict them. But I don't think
there ever was an intention to do any practical restrictions around
function boundaries. That would mean that inlining can only run as the
latest optimization pass, which would inhibit tons of optimizations.
Users would throw such a compiler away.
