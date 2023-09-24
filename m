Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15337ACA7E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 17:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjIXPct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXPcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 11:32:48 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97537B8
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 08:32:42 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-452527dded1so1820637137.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695569561; x=1696174361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSJZSZOUN6KSZ1Fr0SU6EUu5NSVFxvEmO17713Eu80I=;
        b=a8gVViAiLzOLZvPB8cv7ASddX8NYO4Dbp7C59WGN2VLsBUJ+d/wgW9flcK2kVkhk7n
         2jRZ/VSlj65xLLR/3nSF6PgpRt2rBcn0l9nFim8DVfVlDjaTLn749qQ5vpve1Wauc82Q
         PMqDtc4TyC5//wg4cKQ9eiD1TDGaHUTvOAOhgKyDOREr8bV2j8U+9h/TKMqWRCj13KyW
         yHrMinZE0a2BXtctVbQU+Gwbhm7VBRpEZWiGP4lt0BQ17fJ+Giohv2QqwgHt/nUR8p1M
         l1S/C2vwJ/YK8XQdOAeVluLShQDAzB2a+58m9G4HtTPiUu/z7nbQgKOMlJsEQZSgCgJk
         VnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695569561; x=1696174361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSJZSZOUN6KSZ1Fr0SU6EUu5NSVFxvEmO17713Eu80I=;
        b=LRWyHI2wH6UEjj/Lp5lwRiESEDC7hftY3ozJxOk653VOHVHb0KkjQZMfygNz4RnAnP
         vmDKKt0txiPY21hErjgtHIYbicroZYqDiLdc+06mUNkBMibhZp5/CBsVNxlYMIZv6EUj
         7Y/mLLmrBEIfI4YQaJdxsH+ddi1IvA1FnvJBeYoRrVd6w3eZtYCdFU2pxugXNFVcuCvv
         8dcT7Tvz4jt4fXbBQxY5oCsjTYM/HVS3qK7ZN/6hqwDJlNnM5sG+U3nj5+kNVekPTopm
         wHWontNnYwfT7sKPw09O5i1Bgk1xuV67OaOv7B3a0jjwCear+p7kFIr6JvPfcU3gHcWi
         BJ0Q==
X-Gm-Message-State: AOJu0YyZULEL3bZ6PfXoUuvy1P76vapwickh8UX9cvA6gbjJO8Twgnew
        r/XQEBd1RDkPqUtBysyvS4EylEvkd3GkXghxQVc=
X-Google-Smtp-Source: AGHT+IGaW7Sz7LnHaiHMPxCDOprArU6bv7d1igX5IF19CZvB5oCjZWd8rNuEQr9WVblupNky/X8iMDYXlIT9ved+/kE=
X-Received: by 2002:a67:f947:0:b0:44d:3f96:6c61 with SMTP id
 u7-20020a67f947000000b0044d3f966c61mr2463076vsq.30.1695569561610; Sun, 24 Sep
 2023 08:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki> <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org> <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com> <ZRBHSACF5NdZoQwx@casper.infradead.org>
In-Reply-To: <ZRBHSACF5NdZoQwx@casper.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 24 Sep 2023 18:32:30 +0300
Message-ID: <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
To:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Reuben Hawkins <reubenhwk@gmail.com>, brauner@kernel.org,
        Cyril Hrubis <chrubis@suse.cz>, mszeredi@redhat.com,
        lkp@intel.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev,
        ltp@lists.linux.it, Jan Kara <jack@suse.cz>
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

On Sun, Sep 24, 2023 at 5:27=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Sep 24, 2023 at 02:47:42PM +0300, Amir Goldstein wrote:
> > Since you joined the discussion, you have the opportunity to agree or
> > disagree with our decision to change readahead() to ESPIPE.
> > Judging  by your citing of lseek and posix_fadvise standard,
> > I assume that you will be on board?
>
> I'm fine with returning ESPIPE (it's like ENOTTY in a sense).  but
> that's not what kbuild reported:

kbuild report is from v1 patch that was posted to the list
this is not the patch (v2) that is applied to vfs.misc
and has been in linux-next for a few days.

Oliver,

Can you say the failure (on socket) is reproduced on
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.misc?

I would expect the pipe test to fail for getting ESPIPE
but according to Reuben the socket test does not fail.

>
> readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) succeeded
>
> 61:     fd[0] =3D SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> 62:     TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
>
> I think LTP would report 'wrong error code' rather than 'succeeded'
> if it were returning ESPIPE.
>
> I'm not OK with readahead() succeeding on a socket.

Agree. Reuben reported that this does not happen on v2
although I cannot explain why it was reported on v1...

> I think that should
> also return ESPIPE.  I think posix_fadvise() should return ESPIPE on a
> socket too, but reporting bugs to the Austin Group seems quite painful.
> Perhaps somebody has been through this process and can do that for us?
>

This is Reuben's first kernel patch.
Let's agree that changing the standard of posix_fadvise() for socket is
beyond the scope of his contribution :)

Thanks,
Amir.
