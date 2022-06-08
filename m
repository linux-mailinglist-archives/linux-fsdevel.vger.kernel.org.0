Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDD6542F9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbiFHMBb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 08:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiFHMBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:01:30 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4171B047B
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 05:01:29 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id e11so4940417vsh.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jun 2022 05:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTp8ROUSTNRPhHmOUtBbTj99Sj1RYk80Myq3vxgf2tc=;
        b=hNRd/QRwdsHXuMKtV1JmHimGD3D2DCbJHuZ2Hi8+pnS0dVFmq6W2Xsh6oWhZ2vqusI
         oaSwwMh8XnFGi9bhfIxh8p0k37PkuTen/77rhGm5fx8mUJ6TSMdzoRjna93Yqfx6/aRe
         +qCuSXoFzQLVsi/dcYhfcpG5IT1GvQqoumH7QmQQqEjPjrc9vcgm8S8nXh8aC6U/P5Od
         I4UZJhaAuPpz8JC0iJDPDbE1vYmAewRNHrCpbq1frfgh8VQhibkWn/ze3dwjbzBjYTUc
         rO8uw4yZy5jh34Hpt68ifdqtnkbkC7cb24r6VMCZxK9IgaJt5/5tAhYc2JSFAuWgkTte
         mijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTp8ROUSTNRPhHmOUtBbTj99Sj1RYk80Myq3vxgf2tc=;
        b=2i2aYKs76TQsRDBDfSRg/SJ2F3B+8MM7/0MWDWvb3ECdI6hexqAKSHMS/i+R/T77AR
         NgfdqYPFhbHGa6mHuzplg3nY7xlqckflOkplq5jSLAHtw1pzlQpA/5gPVGXQqUKFPo3W
         NZ4WJCPAydLxJ9v7XW3ZT+wxy7xvdM8skXCkPjrHydmG8MHXKZcTmp13iSRSv+I8Tcxu
         W/3Jsoh1idjcyCY/xuPTupVYpudaMvKRGSz4By5SfDT3hrGw56IP1QFAOA5R0PGv9ajy
         9/8eg6Cg5e7VLH9IosWgg0xtiUTqBXaSJHU7B8pRYrvonINUUvcB/lgy4o9zXjAeRTEl
         c7cw==
X-Gm-Message-State: AOAM530b7JIwrDubCSLWBDLRT0MoZCRTBp1m7SZ241ZVi+VPrONZj0Bd
        x3IV2RalRduBMK4tm1CEgRWCJ+624vw6J+rr0pE=
X-Google-Smtp-Source: ABdhPJwi95S6aKKmGkAaM3so8Ow8SVtdf3BR7Ji/DEUJFDcMFuBciADbZ59T3w6yE68hgYN7fbXEYzy4KBFTWVniuPo=
X-Received: by 2002:a67:70c4:0:b0:349:d442:f287 with SMTP id
 l187-20020a6770c4000000b00349d442f287mr15432151vsc.2.1654689688464; Wed, 08
 Jun 2022 05:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-MHhCyDB576-vpcJuazyrO-4Q1UuTprD88pdd0WRzjOx8ptQ@mail.gmail.com>
 <CAOQ4uxj=Cd=R7oj4i3vE+VNcpWGD3W=NpqBu8E09K205W-CTAA@mail.gmail.com> <CAJ-MHhCJYc_NDRvMfB2S9tHTvOdc4Tqrzo=wRNkqedSLyfAnRg@mail.gmail.com>
In-Reply-To: <CAJ-MHhCJYc_NDRvMfB2S9tHTvOdc4Tqrzo=wRNkqedSLyfAnRg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 Jun 2022 15:01:17 +0300
Message-ID: <CAOQ4uxjH9o_XwowdyjyCYswpfvwRSq9wUAkYvg_XoKULvx23-g@mail.gmail.com>
Subject: Re: Failed on reading from FANOTIFY file descriptor
To:     Gal Rosen <gal.rosen@cybereason.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Wed, Jun 8, 2022 at 2:01 PM Gal Rosen <gal.rosen@cybereason.com> wrote:
>
> Hi Amir,
>
> What do you mean by bumping the CAP_SYS_ADMIN limit ?
> You mean to increase the max open file for my process that watches the FANOTIFY fd ?

Yes

> May I instead decrease the read buffer size ?

Yes.

> My read buffer is 4096 * 6, the fanotify_event_metadata structure size is 24 bytes, so it can hold 1024 file events at one read.
> My process Max open files soft limit is 1024, so why do I get this error ?

Perhaps you already have several open files (the fanotify ds itself to name one)

> Ohh, maybe because after reading the events I put them in a queue and continue for the next read, so if file events still have not been released by my application, then the next read can exceed 1024 files opened.
>

Yes, that can explain it.
There could be many other reasons. do ls -l /proc/<your process pid>/fd/

> Yes ,we use permission events. We watch on FAN_OPEN_PERM | FAN_CLOSE_WRITE.
> We also want to support the oldest kernels.
>
> BTW: What do you mean by "assuming that your process has CAP_SYS_ADMIN" ?

The fanotify process must be running as root.

>
> Regarding the EPERM, how do we continue to investigate it ?

Besides adding prints to the kernel I don't know.
Basically, there is a file that is being opened by some process
that your listener process has no permissions to open, so
check with the people responsible to the SELinux policy what that could be.

Thanks,
Amir.
