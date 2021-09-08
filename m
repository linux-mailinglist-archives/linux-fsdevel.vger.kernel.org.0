Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26F34036E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348495AbhIHJ31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 05:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351396AbhIHJ3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:29:18 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B74AC061575
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Sep 2021 02:28:11 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id x137so1443659vsx.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Sep 2021 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwx8f6Mk1CLA5ePmaTymKmh3jkzdbVUmieX2WKV07r0=;
        b=eFUuD8RZT6QmB3gYWbo3UiaT03MkMBfmNyGTCra6mB5WTEhu4dWxIRLdBjK7s71/1b
         0bupuyOQH9mSn+CUG/oNqchZzm7OqXh/83ZBVeJIBqZnUPm7TNnwVFwUKYVoXIbFruVi
         tPQErrwZmtU3ZZusk+0svRILUEaDEmd3GeSFo/Rs9XNNExTYvebbV9A0JYs0dEIPDx59
         niF8CYVd0OkZ7CyAqFFyyKIROA2y8Dew4xP+aX9+oTdnvHhSUPwxy/VyENXaFNG0g0gH
         +auYwf6coqcV+KXyWN620x4D7qKhaHbB0DAt7CoA8UBgWdfPoGBpLILh6FP/WKdz0Bv/
         XqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwx8f6Mk1CLA5ePmaTymKmh3jkzdbVUmieX2WKV07r0=;
        b=pN2StiLFYh0E5jURbQxg49rvAKpdATBdhYdrcap6WFpSdgNI8U2kYMo3g2ff5nH4pZ
         Dw4NNHwO/8y3Mvtcm106x3dbv5IeuyG7l0kx/ur0n9hlheHJirrEy6QxTFdN3mqYoM4H
         GkNS2T8oba4lvkEVDjIZH9SjiBcsIsNZtVZxhF/uTc/dgu41yX8lzNsDMvPPwmMVsBuc
         QBBknj/EMEV1pMvB1kj5m4e8klLeCAsb6dXIpfqYwlF8IS84MijgZvrJwq97Fz5s7PgZ
         gkPuOEnLIyRzyFz2VPYbfiENUch9OXQszXX2dIXQAZqajfNAk1R2BLKlMuROimpheuBU
         wWCA==
X-Gm-Message-State: AOAM5335oKdSgAWNcK2Ds2+30uB/m0TcfJRT0LarmtX64D6O3P0EaUdE
        n43NP4TSQMsgePHhrcLHyHunEYsIccXhzGwyVM3nyekhKenmQow7
X-Google-Smtp-Source: ABdhPJwCZSJnUjkHHg+knt0f+LwU9oBlIuUTqFmnYukg3YNPdSE112Qz49kRLe76T7vtxFISUcBriYgfHWDiLtMq1vw=
X-Received: by 2002:a67:cb83:: with SMTP id h3mr1279194vsl.8.1631093290600;
 Wed, 08 Sep 2021 02:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50a+j8UL9g3UwpRsye5e+a=M0Hy7Tf1FdfwOrUUBWMyosNg@mail.gmail.com>
 <CAJfpegtbdz-wzfiKXAaFYoW-Hqw6Wm17hhMgWMqpTCtNXgAnew@mail.gmail.com>
 <CAPm50aKJ4ckQJw=iYDOCqvm=VTYaEcfgNL52dsj+FX8pcVYNmw@mail.gmail.com> <CAJfpegt9J75jAXWo=r+EOmextpSze0LFDUV1=TamxNoPchBSUQ@mail.gmail.com>
In-Reply-To: <CAJfpegt9J75jAXWo=r+EOmextpSze0LFDUV1=TamxNoPchBSUQ@mail.gmail.com>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Wed, 8 Sep 2021 17:27:43 +0800
Message-ID: <CAPm50aLPuqZoP+eSAGKOo+8DjKFR5akWUhTg=WFp11vLiC=HOA@mail.gmail.com>
Subject: Re: [PATCH] fuse: add a dev ioctl for recovery
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 8, 2021 at 5:08 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 8 Sept 2021 at 04:25, Hao Peng <flyingpenghao@gmail.com> wrote:
> >
> > On Tue, Sep 7, 2021 at 5:34 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Mon, 6 Sept 2021 at 14:36, Hao Peng <flyingpenghao@gmail.com> wrote:
> > > >
> > > > For a simple read-only file system, as long as the connection
> > > > is not broken, the recovery of the user-mode read-only file
> > > > system can be realized by putting the request of the processing
> > > > list back into the pending list.
> > >
> > > Thanks for the patch.
> > >
> > > Do you have example userspace code for this?
> > >
> > Under development. When the fuse user-mode file system process is abnormal,
> > the process does not terminate (/dev/fuse will not be closed), enter
> > the reset procedure,
> > and will not open /dev/fuse again during the reinitialization.
> > Of course, this can only solve part of the abnormal problem.
>
> Yes, that's what I'm mainly worried about.   Replaying the few
> currently pending requests is easy, but does that really help in real
> situations?
>
> Much more information is needed about what you are trying to achieve
> and how, as well as a working userspace implementation to be able to
> judge this patch.
>
I will provide a simple example in a few days. The effect achieved is that the
user process will not perceive the abnormal restart of the read-only file system
process based on fuse.

> Thanks,
> Miklos
