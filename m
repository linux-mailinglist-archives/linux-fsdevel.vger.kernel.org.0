Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB61679A5C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Sep 2023 10:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjIKIPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 04:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjIKIPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:15:35 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC86BBB
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 01:15:30 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7a7857e5290so1516959241.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694420130; x=1695024930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCLd9Ikw1gjtm0RUWutIKdUvhEWnYjKkn35Inf4QqEE=;
        b=bzcZbberz5Z5PSLHN/4HK9d+tIo5Vxa0QnWsupvGd8E/IalMBcgGrCYLnc8GlaHQJv
         fEF9p0OMu+fIazCMsMcMUIuLZ2rg1xLdSThoYzPxOTzsXKRith0BUrUHS85vFTpeHP0q
         iMc+xJg5U/qLhjI1nwm8rm0lI5U/0iTTbXQYBtYlPtQKtbrzU679MFTRqKKX6iP3VFf5
         MgbS3VNuo9a9ZkV2DYuZ1JOs+iDODbHUAhmrmFvbVjWQriqk2Ct0v4IiF887PVMEn64l
         cagevytfTUqBCLQw5SGVH7baNw4N6HydVmrJvnUfvJ7y6DsdhzwfDKPebPZNzkTChT6J
         Dv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420130; x=1695024930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCLd9Ikw1gjtm0RUWutIKdUvhEWnYjKkn35Inf4QqEE=;
        b=Q3vfScF5GnOpiFitGYYPuSVcHWHeofcGZpeS5j658ouqhCbDwlLh0yN0sG+a62qXU7
         OhdWB/4cV0I7honU/WSCQVCdm1kZTgVM/zoGIvG6bPob8l9i4026VRARBH1mRbUpL+ts
         MDKiXldfSCYWC5SojNElY8hR353pQYCnRiQauY92KNRwfI/0ontezPL5ReCkz75py580
         tZrrDniLPTtCIPAvLdHY50/5agADAy9AXFK6HcGju2D5KIXDL0sLXgNsNdCM3gIwYl6q
         M4XHTmY5cPlPlSAx+eesTshuBbfhLbf66EuZTCVAs1JXcpth1gnh5rInuoOYWqkqjAQT
         UuKA==
X-Gm-Message-State: AOJu0YwK6UCW90pdoViowf2Cj+51su83013uiA7M5K+sr5p5+XHyLm7v
        mUwuj8iL46rScR5B92H2VTnBSFm9Deodni72Auo=
X-Google-Smtp-Source: AGHT+IE8seJn0YgnQgiUnBgYA1zOb2lAJwzzQnQdBHJgK1cw32s0GQmXQvTAMpn7OAM67cNLmza5HjRBEoGQIHw3cIQ=
X-Received: by 2002:a05:6102:1359:b0:44e:d6c3:51d4 with SMTP id
 j25-20020a056102135900b0044ed6c351d4mr7661906vsl.18.1694420129976; Mon, 11
 Sep 2023 01:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com> <CAOQ4uxiEmJjWQV=cbrmwXF0N1vyRi8sej9ZqbieUUct4_uWuEw@mail.gmail.com>
 <20230910-werken-sololauf-df32fb5dcddc@brauner>
In-Reply-To: <20230910-werken-sololauf-df32fb5dcddc@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 11 Sep 2023 11:15:19 +0300
Message-ID: <CAOQ4uxjDyUKR_U-as=PBLu0mEJyz6XLrbsZhcp1YLpEkssBvpQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix readahead(2) on block devices
To:     Christian Brauner <brauner@kernel.org>
Cc:     Reuben Hawkins <reubenhwk@gmail.com>,
        linux-fsdevel@vger.kernel.org, mszeredi@redhat.com,
        willy@infradead.org, viro@zeniv.linux.org.uk
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

On Sun, Sep 10, 2023 at 1:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sat, Sep 09, 2023 at 09:36:10AM +0300, Amir Goldstein wrote:
> > On Sat, Sep 9, 2023 at 7:39=E2=80=AFAM Reuben Hawkins <reubenhwk@gmail.=
com> wrote:
> > >
> > > Readahead was factored to call generic_fadvise.  That refactor broke
> > > readahead on block devices.
> >
> > More accurately: That refactor added a S_ISREG restriction to the sysca=
ll
> > that broke readahead on block devices.
> >
> > >
> > > The fix is to check F_ISFIFO rather than F_ISREG.  It would also work=
 to
> > > not check and let generic_fadvise to do the checking, but then the
> > > generic_fadvise return value would have to be checked and changed fro=
m
> > > -ESPIPE to -EINVAL to comply with the readahead(2) man-pages.
> > >
> >
> > We do not treat the man-pages as a holy script :)
> >
> > It is quite likely that the code needs to change and the man-page will
> > also be changed to reflect the fact that ESPIPE is a possible return va=
lue.
> > In fact, see what the man page says about posix_fadvise(2):
> >
> >        ESPIPE The specified file descriptor refers to a pipe or FIFO.
> > (ESPIPE is the error specified by POSIX, but before kernel version
> > 2.6.16, Linux returned EINVAL in this case.)
> >
> > My opinion is that we should drop the ISREG/ISFIFO altogether,
> > let the error code change to ESPIPE, and send a patch to man-pages
> > to reflect that change (after it was merged and released),
> > but I would like to hear what other people think.
>
> Probably fine with the understanding that if we get regression reports
> it needs to be reverted quickly and the two of you are around to take
> care of that... ;)

Sure. Hopefully, if there are regressions, they will be reported sooner
than 5 years, as this one was...

Reuben,

Please post v2 just removing the S_ISREG restriction and mention
the change minor of behavior in the commit message.

There is no need to change the comment in readahead code,
because the comment does not mention the S_ISREG restriction.

Thanks,
Amir.
