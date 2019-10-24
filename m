Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B494E3E7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 23:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfJXVrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 17:47:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37700 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbfJXVrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:47:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id q130so3843152wme.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lG3WdyNLCcfTNzO352JfUKqOKVeMeSmYj5nsZjZkwpc=;
        b=khr+06rrcJqynyZYpC/d1ohf3JHyIrUkbhSr8T7ldCZQxaJzodnmw9cPczz+z6h+KN
         V09iZLOpUhQBzPf6tUaAygxzN6Y6PVbAXybdeIWJROCfrbvEKFYnGrOIsxb2aOPxhvBK
         7VVhB6s1P+fSXGwm2PaDLZSvFSmyNJ+sMVxBDzmegMznef1i95ijx+uYAIOhpWcwXsg5
         Tf7Ro5mIac/jfysKAgQ88XichMVWzPetvTHZOSJ0XYhYA9AosTEf0g1RGwHy+XavjyUK
         IU0gxwRfd2fX2tnDhflauZj/MW4PZbdLl9v19kXGvJ0K762KUhHKrMmI7Uc19AsqnQWO
         VsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lG3WdyNLCcfTNzO352JfUKqOKVeMeSmYj5nsZjZkwpc=;
        b=deG+jAgKmoojYxMN57s27HNsbtiqxxrXsgaPIp5JBMaQv9cSbJT8tlPMJ9OT0VaipK
         aKTiYj8jwkgL+hL3SyObJsxsAlbto9VFcaarBHAfHPDPYcve6W/G0/hksqXcR2dTTh8/
         yLIeYxFaie1mPQTDnskKnMz/lPQhtoOafdpkA4q/jX9dErGbxB6OVVtkUVSXf4yKaQ0A
         fEWzGsrqgA0ZXn2PKKP2e3U3jd9OlVTFrntzWnUshyL/t+dMRBb2q97b34Qifke6hXI7
         T2JYNhgmiPMjaWDsPwON62WiocX+GaOj66f3E7uMuOn6ZKoE5VgjiOsA5NUhGFjJSYjQ
         DXBA==
X-Gm-Message-State: APjAAAV8Bitx0cjQnqJdxW3B0zdEguPh61vaLacWC6yV5tn1sgvjT05U
        HrwuPiCMziMConQrFR62dWXxe+nMQ2Gu0hXFIvk5mA==
X-Google-Smtp-Source: APXvYqzkE+sU1EkGJQK4JdUKGlJonXlWfXDzIipQi5qiYj9e9sZgCx6220s7Nojpr2W74pIDqxbQYZY1lv+r0Czbin4=
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr399796wma.176.1571953623534;
 Thu, 24 Oct 2019 14:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali> <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
 <20191023115001.vp4woh56k33b6hiq@pali> <CAJCQCtTZRoDKWj2j6S+_iWJzA+rejZx41zwM=VKgG90fyZhX6w@mail.gmail.com>
 <20191023171611.qfcwfce2roe3k3qw@pali> <CAFLxGvxCVNy0yj8SQmtOyk5xcmYag1rxe3v7GtbEj8fF1iPp5g@mail.gmail.com>
 <CAJCQCtTEN50uNmuSz9jW5Kk51TLmB2jfbNGxceNqnjBVvMD9ZA@mail.gmail.com> <CAFLxGvwDraUwZOeWyGfVAOh+MxHgOF--hMu6P4J=P6KRspGsAA@mail.gmail.com>
In-Reply-To: <CAFLxGvwDraUwZOeWyGfVAOh+MxHgOF--hMu6P4J=P6KRspGsAA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 24 Oct 2019 23:46:43 +0200
Message-ID: <CAJCQCtQhCRPG-UV+pcraCLXM5cVW887uX1UoymQ8=3Mk56w1Ag@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 12:22 AM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Wed, Oct 23, 2019 at 11:56 PM Chris Murphy <lists@colorremedies.com> wrote:
> > Any atomicity that depends on journal commits cannot be considered to
> > have atomicity in a boot context, because bootloaders don't do journal
> > replay. It's completely ignored.
>
> It depends on the bootloader. If you care about atomicity you need to handle
> the journal.
> There are also filesystems which *require* the journal to be handled.
> In that case you can still replay to memory.

I'm vaguely curious about examples of bootloaders that do journal
replay, only because I can't think of any that apply. Certainly none
that do replay on either ext4 or XFS. I've got some stale brain cells
telling me there was at one time JBD code in GRUB for, I think ext3
journal replay (?) and all of that got ripped out a very long time
ago. Maybe even before GRUB 2.


> And yes, filesystem implementations in many bootloaders are in beyond
> shameful state.

Right. And while that's polite language, in their defence its just not
their area of expertise. I tend to think that bootloader support is a
burden primarily on file system folks. If you want this use case
supported, then do the work. Ideally the upstreams would pair
interested parties from each discipline to make this happen. But
anyway, as I've heard it described by file system folks, it may not be
practical to support it, in which case for the atomic update use case,
the modern journaled file systems are just flat out disqualified.

Which again leads me to FAT. We must have a solution that works there,
even if it's some odd duck like thing, where the FAT ESP is
essentially a static configuration, not changing, that points to some
other block device (a different partition and different file system)
that has the desired behavioral charactersistics.

> > If a journal is present, is it appropriate to consider it a separate
> > and optional part of the file system?
>
> No. This is filesystem specific.

I understand it's optional for ext3/4 insofar as it can optionally be
disabled, where on XFS it's compulsory. But mere presence of a journal
doesn't mean replay is required, there's a file system specific flag
that indicates replay is needed for the file system to be valid/cought
up to date. To what degree a file system indicating journal replace is
required, but can't be replayed, is still a valid file system isn't
answered by file system metadata. The assumption is, replay must
happen when indicated. So if a bootloader flat out can't do that, it
essentially means the combination of GRUB2, das uboot,
syslinux/extlinux and ext3/4 or XFS, is *proscribed* if the use case
requires atomic kernel updates. Given the current state of affairs.

So that leads me to, what about FAT? i.e. how does this get solved on
FAT? And does that help us solve it on journaled file systems? If not,
can it also be generic enough to solve it here? I'm actually not
convinced it can be solved in journaled file systems at all, unless
the bootloader can do journal replay, but I'm not a file system expert
:P

-- 
Chris Murphy
