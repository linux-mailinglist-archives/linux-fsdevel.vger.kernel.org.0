Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD265A7E64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 15:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiHaNMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 09:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiHaNMx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:12:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A0CC6956
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 06:12:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qh18so8013319ejb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/TYfUlJgesANvwVE24wak6nodOGOqM3+oLVQgG8lR6A=;
        b=CaoTV93XOkOTTwYUCcG3dahKaG9iHQ5Ca023SmYaBhZSX9JBiPejvoTaNFWSfezt+I
         gNElvFLEv4Wk2Ks0I4vtX4wrv51SXRtPvCIJKxwu/lPxDVy+mufE33H5YVE5LTtIR7oF
         sB37f5hqaAUh5FDsfvdfzu7WKwRgMDIZevO/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/TYfUlJgesANvwVE24wak6nodOGOqM3+oLVQgG8lR6A=;
        b=jzfkiLT/EyFAL1W8tJgI0XZvPiUaWHxNzmY6TU8aVwMojS7xhawOEZ8Nr/qpvpsatG
         ducZUccH1PaJ29nVXyjukYYHer4U+onmVAm/WMggNBGKk9fYr9P5/YulAlQSh+qJ5h9W
         Kx73Nvje05YLQKyKncBCxRT9S3c/AaX5KfZu5SrGKH8ZeXNbJecHRN7lEN2pSQSfC+rI
         2dImD8YbuN+TiZwIt7vBKOD4QadCedQaUxdnedb2dSFNgltmtSPWreOqSScYI+zIfUmW
         VEqK9CKhdLKWqdRZ53T1n4T0EPelf5KOBbx1i0zpnp7G+U4VvLybuyuCzlNjALxgytal
         DZsw==
X-Gm-Message-State: ACgBeo0IW1ncqntLH02WHTgJjDwizQrAMuhv0QngeS8Zc326WYG+RdH0
        fdGOUwKRJgRiCHITaD+oXBFFhF6e07s8skg3Wb/mpA==
X-Google-Smtp-Source: AA6agR7/X9C5u+5U4B9YJaK3+UdxdmeAQxtfuZ/KdrBaXh0FWNDXedQ+V8pDgVzr+ThezEFHcRUewASbY8T3VFSd9TM=
X-Received: by 2002:a17:907:16a0:b0:741:833b:c4c9 with SMTP id
 hc32-20020a17090716a000b00741833bc4c9mr10791544ejc.524.1661951570633; Wed, 31
 Aug 2022 06:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200728234513.1956039-1-ytht.net@gmail.com> <CAJfpegv=8gc1W80e0=33dEcdQb4OgVWKBVXi3jNDKVWV1fWetA@mail.gmail.com>
 <CALqoU4wtPnMPqWZF=DjHApZRA58Vruwa3X3sQxR9UkugZJOgwg@mail.gmail.com>
In-Reply-To: <CALqoU4wtPnMPqWZF=DjHApZRA58Vruwa3X3sQxR9UkugZJOgwg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 31 Aug 2022 15:12:39 +0200
Message-ID: <CAJfpegvZMS=P82E2t_BLOhxbiwLZNyFH1U1moAdHEjgU89wT_w@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add filesystem attribute in sysfs control dir.
To:     lepton <ytht.net@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 Aug 2022 at 21:00, lepton <ytht.net@gmail.com> wrote:
>
> On Mon, Aug 22, 2022 at 6:37 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, 29 Jul 2020 at 01:45, Lepton Wu <ytht.net@gmail.com> wrote:
> > >
> > > With this, user space can have more control to just abort some kind of
> > > fuse connections. Currently, in Android, it will write to abort file
> > > to abort all fuse connections while in some cases, we'd like to keep
> > > some fuse connections. This can help that.
> >
> > You can grep the same info from /proc/self/mountinfo.  Why does that not work?
> Hi Miklos, thanks for this hint. That will work. But the code in user
> space will be more complicated and not straightforward.
> For now, I can see 2 issues with mountinfo:
> 1.  one connection could have multiple entries under
> /proc/self/mountinfo if there are bind mounts,  user space code needs
> to handle that.

Using the first match should be okay, bind mounts will have the same
filesystem type.

> 2.  /proc/self/mountinfo is limited by namespace, so in theory, some
> connection under /sys/fs/fuse/connections  could be missed in it.

True.  OTOH this could be a security issue as well, since the point of
namespaces is to hide information.

> While this isn't an issue
> for the current android code, maybe it could get broken in the future.
>
> Overall, I am feeling my kernel patch is a straightforward and simple
> solution and it's just one more attribute under
> /sys/fs/fuse/connections, may I know if there are any downsides to
> doing this?

Your patch adds an ad-hoc interface for a very specific purpose with
likely no other users.  As long as this information can be gotten in
other ways there's no compelling reason to add a new interface.

Thanks,
Miklos
