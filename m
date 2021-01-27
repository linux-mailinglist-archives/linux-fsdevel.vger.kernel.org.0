Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E523061E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 18:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhA0R00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 12:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhA0R0F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:26:05 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D0AC061573;
        Wed, 27 Jan 2021 09:25:23 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id p5so2958817oif.7;
        Wed, 27 Jan 2021 09:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpNKPhFYVjcsXSJ1jEZxg4Wd3C6P+uhGCHWvmUGFXHU=;
        b=UXt1WULRneWHA1rDNZL4fib0kjk3x9nDY21VsjEiEcuOcyymnCb9qSAZp3uz1Yvi5H
         8PKJFoqTV3UVAtgAFkx4tcChl2jnATlTIXN0U3fxnhVRbfVCSgUWsPiDF2/Nsra3TC0C
         OgJ1TqdIJ/W3w5scsne4nDJLKwjJqS3+gZtw8rf7IwhqkxIBtpJ4x+tO7cgo3DfLr1Bc
         LFLr5ep2J9ZOPwuyXQ+cSkx33JnkTpy8eBQ1NGlH7iHubDiNt3Y3KnRbMjL+iZq7KSSl
         Oz6G6WrD1SmxDioUFlJ5206zUeKXFwzdT7knH6L3byBprQiyWGnapwdRxnDNb71mf7/3
         cQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpNKPhFYVjcsXSJ1jEZxg4Wd3C6P+uhGCHWvmUGFXHU=;
        b=BMxQigfgmk40+Wj8oVzcpHur0Iwrk+QV1R55CrpAPEQgyIAgQWDsgP7H3NgioRBSwQ
         qaiq95dcVXWTj2wy8cz/7ltRUQ4TlZpaJ9dkq6HZIBWam07QC8DNXJfXHEYnuciZoJyE
         ++PCZe2wL+72JF4DqXHudRoYQB14EDYRR3pgnpbV5Gtg3hCLcBfoPSATy4RrBjOeIMZd
         j54dEdBj4NfQ5BG74dekImAraGw6wHhfHy6e5FrRkVEIAzIgapDV6EkV1aDWzFifSlgy
         rgkGTRM8devDxIj+1sMR0vkSjt3PUqiiZOAx1hnNNYIuteN7wCHxMQQKagL3vZB+26dL
         O9VA==
X-Gm-Message-State: AOAM5315sEMzgzIxlz5GOTMfsk+iCwpEj2ihSYR95oTW+8fIXAtPolGj
        8xrYM/N/dV/l5vf7bt4J52jPhVMbKNmMOGxrM5M=
X-Google-Smtp-Source: ABdhPJzzQeCaEjLFyXb6qH1Tt1y49HsaZizluH4lwwnG3PmcKk874XnZsTtfm5CdPPh4afKqpikxbe4263gpMwZu8qQ=
X-Received: by 2002:a54:458f:: with SMTP id z15mr4021087oib.139.1611768322530;
 Wed, 27 Jan 2021 09:25:22 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT55QViS=XE9QUTDp1KQ1_5fwuddLY3+2XSrMdoOuCOyYg@mail.gmail.com>
 <20210127170828.eydoe7didip7pukr@kari-VirtualBox>
In-Reply-To: <20210127170828.eydoe7didip7pukr@kari-VirtualBox>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 27 Jan 2021 09:25:11 -0800
Message-ID: <CAE1WUT50jKwVcFwgMAkBr19HjCGiYtZ1h-GKx-zs2F1ZJiOuCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efs/inode.c: follow style guide
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 9:08 AM Kari Argillander
<kari.argillander@gmail.com> wrote:
>
> On Tue, Jan 26, 2021 at 12:58:05PM -0800, Amy Parker wrote:
> > This patch updates inode.c for EFS to follow the kernel style guide.
>
> > +++ b/fs/efs/inode.c
> > @@ -109,9 +109,9 @@ struct inode *efs_iget(struct super_block *super,
> > unsigned long ino)
> >        /* this is the number of blocks in the file */
> >        if (inode->i_size == 0) {
>
> Still has { here so you didn't even compile this? Also I think you
> should make one patch for whole EFS.

I might've accidentally done that after the compile but before the commit.

> Just change one type of thing at
> ones. Like
>
> [Patch 1/X] fs/efs: Remove braces from single statments
> [Patch 2/X] fs/efs: Add space after C keywords
> [Patch 3/X] fs/efs: Fix code indent levels

Yeah, that's probably a better idea.

>
> That way it is super easy to review them. Also because there is no
> maintainer it is kind of scary to accept patches. Specially when lot of
> different kind of things are changed.

Ah yep, so having them organized would definitely be better.

>
> Please also send your patches against cover letter. If you have problem
> with your email client plese take a look git send-email. This will work
> beautiful for all of this.

Gonna being switching email services soon anyways, I'll be using git
send-email once I do.

>
> And because you are new (i think). Welcome.

Thank you!

Best regards,
Amy Parker
(she/her)
