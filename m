Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8574687975
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 10:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjBBJse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 04:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjBBJs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:48:26 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE41AD26
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Feb 2023 01:48:02 -0800 (PST)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0BD53442F0
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Feb 2023 09:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675331215;
        bh=j6zWA0cmeZq/Pdujw3e8IyUapMEhl5TgQN8H+c5DyTY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=GTwdiPbSuSaJMT5L0j2KMlY3lcYYOfdk0g0HHFzHp7uoknkeZ7xc81THDSXctGTst
         DIMdDM7BLU33V2o16thXOWjI5xJKNPd400bSA051mAHwkN1aEg2+MqNr+tdR/Tx3mj
         tBLbdoFib9rIGEjljP5fhNFapcdPmoC1yq2qYlOXiwuWIr/TUbhEI77h6D2vdX7H8B
         TE+FYPYqDv7C2rpHy60fSzvDz0wLdbY6t9QWSp1NgjkR1VhoTQfJkc5vQ+TynoqMFm
         6Q/71NXleyahCl6CmS0pxKuQfg6vF2OgKjAig0ZakmEMfnFPyAdgNSgKEpx2hwAgh9
         ex/zNMiI4um7g==
Received: by mail-yb1-f199.google.com with SMTP id u106-20020a25ab73000000b00843e2d6a2c8so1242825ybi.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Feb 2023 01:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6zWA0cmeZq/Pdujw3e8IyUapMEhl5TgQN8H+c5DyTY=;
        b=DiwjekD01URNTUMrwOpNooPkKZczZqofJ04XXn7TuKe+6MHOo37iSsQwIHIWX1oD04
         acw3EPf+zMK0Lc3A8ix7jsfnTi2OB169+cRgo6nRvyjWzwSqsjN99+saLFLnYf39L/u4
         wnAxK752HsEEcrxpQMqsJMnWM0FaVAoFkleN7UHwUNbAMv7g2hwLjTA07qBiqwFxL/oy
         JjS9dC3IS/E1ytnfJH0L3FKuf8g+/Kt9ww+PPmui1Hjjts65E7M34jtCDtYa8MKLzTGl
         F9O6TJvShDcZmxBybUnm6smSY2cYlGJnse/zWo5H6PhG25wh5vr+7wiFADUz/iL84Roj
         VW4w==
X-Gm-Message-State: AO0yUKX3bogXB7Jx7kP4GkifhIlbFzZRq7DJ17zYNJaiwD/TvmNSje/c
        9XpVBplJ3X5xFmGzrqtC6CY34pNZrbM2DnEgVMdtmQGrOHVjni93QJQX0jP3pwkX5AlVrc2fIZc
        3ZXjs8zlG3gCDv709Q3nLQowbQUaVDPWA9qpXXuK41wrHIXDz4STEjq8ljDk=
X-Received: by 2002:a81:70c2:0:b0:506:6e1a:9b0 with SMTP id l185-20020a8170c2000000b005066e1a09b0mr631039ywc.277.1675331214116;
        Thu, 02 Feb 2023 01:46:54 -0800 (PST)
X-Google-Smtp-Source: AK7set93ZODHHCCQG04l+loQG6KBDQem1oCQB9qjfFasFJzVoB868hVcGOuxhSj0em1uOkSPuerV1TPOuLKFLpPe8Gc=
X-Received: by 2002:a81:70c2:0:b0:506:6e1a:9b0 with SMTP id
 l185-20020a8170c2000000b005066e1a09b0mr631035ywc.277.1675331213915; Thu, 02
 Feb 2023 01:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20230131121608.177250-1-aleksandr.mikhalitsyn@canonical.com>
 <87bkme4gwu.fsf@meer.lwn.net> <CAEivzxfxkWtYP4bqFrmD__3M9WpJNZjTJNx9wp4WQ0_LoGKT6g@mail.gmail.com>
 <Y9tJPn0a/O27SBuJ@sol.localdomain>
In-Reply-To: <Y9tJPn0a/O27SBuJ@sol.localdomain>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Thu, 2 Feb 2023 10:46:42 +0100
Message-ID: <CAEivzxdLUy6CKaQg7Go6P892xgQxi_CEk2M4A3TdVA644DSLqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: filesystems: vfs: actualize struct
 super_operations description
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 2, 2023 at 6:25 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jan 31, 2023 at 10:12:42PM +0100, Aleksandr Mikhalitsyn wrote:
> > On Tue, Jan 31, 2023 at 8:56 PM Jonathan Corbet <corbet@lwn.net> wrote:
> > >
> > > Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com> writes:
> > >
> > > > Cc: linux-fsdevel@vger.kernel.org
> > > > Cc: linux-doc@vger.kernel.org
> > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > > > ---
> > > >  Documentation/filesystems/vfs.rst | 74 ++++++++++++++++++++++++-------
> > > >  1 file changed, 59 insertions(+), 15 deletions(-)
> > >
> > > Thanks for updating this document!  That said, could I ask you, please,
> > > to resubmit these with a proper changelog?  I'd also suggest copying Al
> > > Viro, who will surely have comments on the changes you have made.
> >
> > Hi, Jonathan!
> >
> > Sure. Have done and of course I've to add Al Viro to CC, but forgot to do that,
> > cause scripts/get_maintainer.pl have didn't remind me (-:
> >
> > >
> > > > diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> > > > index fab3bd702250..8671eafa745a 100644
> > > > --- a/Documentation/filesystems/vfs.rst
> > > > +++ b/Documentation/filesystems/vfs.rst
> > > > @@ -242,33 +242,42 @@ struct super_operations
> > > >  -----------------------
> > > >
> > > >  This describes how the VFS can manipulate the superblock of your
> > > > -filesystem.  As of kernel 2.6.22, the following members are defined:
> > > > +filesystem.  As of kernel 6.1, the following members are defined:
> > >
> > > Why not 6.2 while you're at it?  We might as well be as current as we
> > > can while we're updating things.
> >
> > I'm on 6.2, but for some reason decided to put 6.1. Will fix it :)
> >
>
> It would be better to just remove the version number.  Whenever documentation
> says something like "as of vX.Y.Z", people usually forget to update the version
> number when updating the documentation.  So then we end up in the situation
> where the documentation actually describes the latest kernel version, but it
> claims to be describing an extremely old kernel version.

Hi, Eric!

Agree. Will remove version specifiers in the next resend after Al
Viro's and other folks reviews. :)

Kind regards,
Alex

>
> - Eric
