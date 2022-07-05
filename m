Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDC2566488
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 10:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiGEH7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 03:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGEH7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:59:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3671DF37
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jul 2022 00:59:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t25so19196630lfg.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Jul 2022 00:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YcN1CPbmsq+eEhYjUJ7QBLV8GN1X0/sFN2j6K0a9zG4=;
        b=iw4NBiQOX4K3Ririme7ECgzl4I04HgdDVWOEeWYPqQ8IiYs6mkMElUvvBtt+s+FKAL
         eKt1zaL7fqMZdpObugl8x7i416zzFvKruigQ7vkp0vqvhR8xLSeJ2ZdNxWpDBDYYuuxZ
         5TLdPK8uC2gDJK37f6+36JcEbG4HT2DYuJL1qbDIxebGDzJhd+OuQQvLo5PZrTfoSx2G
         9pW6AI6HJGSHDREneZAc6DAXmwIcPyh26Fste/U1Md1veg4ezDaL8l2obCMDFuseDBF/
         3DSJhCS2bJkldZ+GefaLZlaTFugcKMVa14sUb1QoyDJwaGDJpTKRmFIEx4lu6QikP2zs
         bDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YcN1CPbmsq+eEhYjUJ7QBLV8GN1X0/sFN2j6K0a9zG4=;
        b=dP87V2tOhAkZAdTW7VP1KZ2oRqOF1wC+/4dW8daN4PyvtGILNvBdWKolf0CKusegFI
         twYDVuIv7GjgXzVzwxRKg2fNjoq5IrCTKg8bduYEPlqI+nJg6G+binuq+5a+dCCPR8tE
         uNUMKvUgtoP8Ge169PJPz/G8EnUt5Uc9HuJmncV4SF6+ofkMkko2c4QeNw6s6nOPLkdF
         JcAwMDdOhBdpw3HayEJ1PRiMqDwGyL2x9npAqcQ7wDU0ajYgWob1I+trcrNT19xz/uVT
         +75oFbWqlGIgHcZpvFCk13unXi9wyyGuG8iyuAH2fDhTbDi0CaTQW0JKVTpp3axK3pra
         Z81A==
X-Gm-Message-State: AJIora9SbAVOigPFPeIHN+HfTHkk/qnAjYE2m3aBnqGCbprWySDxcGNm
        waR8zqJdPRqobjxrVHrkyPdnlwz3sz+zr9VtDGORAA==
X-Google-Smtp-Source: AGRyM1ud60pjA0M3K5/bIk7ihBO2au6KTpyzZIavlIZWqjsvbSdJHBmZqGBnuJStBS5IrUD55IqtO2K1zFZCF+OE6XU=
X-Received: by 2002:a05:6512:10c3:b0:47f:a97e:35c with SMTP id
 k3-20020a05651210c300b0047fa97e035cmr21330261lfg.417.1657007975375; Tue, 05
 Jul 2022 00:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008f6f7405e2f81ce9@google.com> <YsLHQCvp8W5oObv2@casper.infradead.org>
 <CACT4Y+ZvK0Oxf=Hw7mznmFU=x_zCwC4Ev_Zxo2N0p79DNNi-jw@mail.gmail.com> <YsL2gTVwHL0wFvmI@casper.infradead.org>
In-Reply-To: <YsL2gTVwHL0wFvmI@casper.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 5 Jul 2022 09:59:24 +0200
Message-ID: <CACT4Y+bUtBuhD7_BAN+NavEfhBNOavqF0CJkrZ+Gc4pYeLiy+g@mail.gmail.com>
Subject: Re: [syzbot] WARNING in mark_buffer_dirty (4)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+2af3bc9585be7f23f290@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 4 Jul 2022 at 16:17, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jul 04, 2022 at 03:13:13PM +0200, Dmitry Vyukov wrote:
> > On Mon, 4 Jul 2022 at 12:56, Matthew Wilcox <willy@infradead.org> wrote:
> > > It's clearly none of those commits.  This is a bug in minix, afaict.
> > > Judging by the earlier errors, I'd say that it tried to read something,
> > > failed, then marked it dirty, at which point we hit an assertion that
> > > you shouldn't mark a !uptodate buffer as dirty.  Given that this is
> > > minix, I have no interest in pursuing this bug further.  Why is syzbot
> > > even testing with minix?
> >
> > Shouldn't it? Why? It does not seem to depend on BROKEN.
>
> There is no entry for minix in MAINTAINERS.  Nobody cares about it.

Humm... but it is also enabled in real distros (debian, ubuntu, my
current one) and 32 kernel defconfigs...
Subject to auto-mounting when anything is inserted into usb, right?

In this situation it's good to test it at least to know the state.
Otherwise few kernel devs may know it's broken and unmaintained, but
the rest of the world assumes it's all good and solid and happily
enables it :)
