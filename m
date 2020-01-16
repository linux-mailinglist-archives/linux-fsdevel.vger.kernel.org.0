Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0AF13FE6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 00:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404070AbgAPXc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 18:32:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41899 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391539AbgAPXcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:32:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so20926441wrw.8;
        Thu, 16 Jan 2020 15:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YDWLm6XpqMI02rMFx3Yb45aze/71UxlSxD1MYyNVKss=;
        b=d95X4kB3aWSrf5EvGU4uzYYHZZbih5nZwN0V97zERE4yecu7yDy8A8+o7MOMZhrPgs
         /rPBKOGLIFY7ls4zfxHALS7VNK9jM2Nwjtag9b0DpaDEprrzTJxh5NLei1GRuZYXR169
         p/tmWDgXSPFu0bdauwtEXYSL2k+V1vn7tFidCiOEbR6/PAk+EKbVpZjvM1WAuskg1qQr
         89TTB5sZH+lRkQHlkuLd3/l7XZfWvj2hFYhXdOw1Mor7z9TwHC9jUzvH8gZH0dAqnBae
         UfabZpNgiT4LVL83N6F5MVDCZz9dU70ilxuerH+jnjuceu7G+/XzVqInobQz12XRk40t
         mydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YDWLm6XpqMI02rMFx3Yb45aze/71UxlSxD1MYyNVKss=;
        b=UM0xvtwvbtHBCsuKfTDh5iOf0EdsbblRrbrXErregSCXIrGQHTA4s0WFU2R6v0bGIl
         sGdzm4mJcNjO6MRLgqecedOy47dmYC1xva63OZixRl0MZ52+4bZm6U5Vr1bjXNGDWANg
         lC0XJLKvOFOyDMOH2ofHpOqzf0qT8xhmnoy0nlTNI8cUb9+2MoGF9XzviDtSnHD5X99l
         WbTA3rH+y7nIY2CZtiQahlhzdj6jJJe2aqMptn9TMzTyAEfzTjJYaRYsn5OecUPOxQM/
         gnNngFdBCIRpYSTKYASYYcDpLAwTTchPbwKFtZflTyUFYfv58sSEEomiu11rBTTRiQpL
         Zmdw==
X-Gm-Message-State: APjAAAXkrCG1lvjUFXj8xEHYnPEIxAI7I9y/+/iyuyqUJT1OPzpBXfpY
        qnChXk66BYNdp7sEmnMJKv2aMN+qfeiLXg3t+uDuwA==
X-Google-Smtp-Source: APXvYqwLX0lrkZdJFe5t0zpO2tuKs8Y79hcNs/Gk+HUAJGy8yctH8b/KG5My1MY/0dBlSpc+VFll6ki0vfP1JpdRDMs=
X-Received: by 2002:adf:f606:: with SMTP id t6mr5590987wrp.85.1579217542497;
 Thu, 16 Jan 2020 15:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20191209222325.95656-1-ebiggers@kernel.org> <20200114220016.GL41220@gmail.com>
 <1925918130.21041.1579039436354.JavaMail.zimbra@nod.at>
In-Reply-To: <1925918130.21041.1579039436354.JavaMail.zimbra@nod.at>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 17 Jan 2020 00:32:11 +0100
Message-ID: <CAFLxGvz8mjUdh67aw1vKoxJnQBHixrPUC8CTJYMbQG2CqZQrwQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ubifs: fixes for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS
To:     Richard Weinberger <richard@nod.at>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt <linux-fscrypt@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 11:04 PM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Eric Biggers" <ebiggers@kernel.org>
> > An: "richard" <richard@nod.at>
> > CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-fscrypt" <linux=
-fscrypt@vger.kernel.org>, "linux-fsdevel"
> > <linux-fsdevel@vger.kernel.org>
> > Gesendet: Dienstag, 14. Januar 2020 23:00:17
> > Betreff: Re: [PATCH 0/2] ubifs: fixes for FS_IOC_GETFLAGS and FS_IOC_SE=
TFLAGS
>
> > On Mon, Dec 09, 2019 at 02:23:23PM -0800, Eric Biggers wrote:
> >> On ubifs, fix FS_IOC_SETFLAGS to not clear the encrypt flag, and updat=
e
> >> FS_IOC_GETFLAGS to return the encrypt flag like ext4 and f2fs do.
> >>
> >> Eric Biggers (2):
> >>   ubifs: fix FS_IOC_SETFLAGS unexpectedly clearing encrypt flag
> >>   ubifs: add support for FS_ENCRYPT_FL
> >>
> >>  fs/ubifs/ioctl.c | 14 +++++++++++---
> >>  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > Richard, have you had a chance to review these?  I'm intending that the=
se be
> > taken through the UBIFS tree too.

Both applied. Thanks a lot for addressing this, Eric.
--=20
Thanks,
//richard
