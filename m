Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3154E2655
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 00:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407858AbfJWWWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 18:22:47 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38061 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407855AbfJWWWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:22:46 -0400
Received: by mail-wr1-f52.google.com with SMTP id v9so12490596wrq.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MbP7FAnNW4lzJOOJLlPcQu6DfBQwczijiTVcJlcur9w=;
        b=GrFesmFtRQ9v1wS5yK9jx94AIhodbF3J3vXr/WDXcTI/KJUjWo7CifIoep2bl1Anr5
         k7QT+/uo20J/npir7PFAimVwuqX0bCuza0GoDk5NvUW68emxyqwC3v16ot94e/UR/myD
         9hhHmTk3SRfn7N0OQNM+HXoCYIHN0Ns7AIGJAmfks5mItzIkeHqQ+Gurj7Xeeq7ERu7f
         AVbwIdTqy/esUTcXEf3q5CS4cJWbJ4APnzQh/rYGlBuoMRo2JXs1Pb7BONbyvMS7CW+a
         AGg8uH4tArv6b64EcTrR8aJjLkcqr2J2nLXY0N0hXLBZg8g2e51dEHtTMCbqZGiCNzdl
         aGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MbP7FAnNW4lzJOOJLlPcQu6DfBQwczijiTVcJlcur9w=;
        b=IeU7ElbI37EaHin90BTad6oV/npzvTlWghinaSXMhQUL2Mrm93JRlvjNsuYBVMIntp
         pdaepbflnp2J4kK2/55LxZu77XQ6Y9TPOy/smITT9BcSUU+kvO/eaH4SHmP7Z6lpTYjq
         OXkgAjjDJQjoOaBV+mhUmZP71j7R+JuxBApqDNDvKThECVR6+VYdePHdcC2hGqzhVzKp
         Md8lsK0e6wptcx7Ty8Dj7bWs87VdNhvJh5Nd1RleM2K/eQu2m1S2mgl/CMlLVI9b7yDb
         bCiIsNTgp49AzFEbCkvX3+hyZ9SJX+qPgq1OlUO8L6Hv9ujG/vIlK2pJ1JzOilDrnmii
         yPtw==
X-Gm-Message-State: APjAAAVL5HVbh8Gk6rFEunRRhaKMPB7Ypxaj8j0T9QuDZQM1xx/W4H/a
        4Mw85/pwp5puj6nWZ7RKrDC/TdEJunuJChUK2aI=
X-Google-Smtp-Source: APXvYqy2TMA5z6TfKEzNGPOiLAdvtUNcN6VRxxuOq54GPi1Q2qhwaNv486qyL9AdceBWHoNQN7BPcHhFbfam3nTTjtI=
X-Received: by 2002:a5d:498a:: with SMTP id r10mr843849wrq.129.1571869364521;
 Wed, 23 Oct 2019 15:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali> <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
 <20191023115001.vp4woh56k33b6hiq@pali> <CAJCQCtTZRoDKWj2j6S+_iWJzA+rejZx41zwM=VKgG90fyZhX6w@mail.gmail.com>
 <20191023171611.qfcwfce2roe3k3qw@pali> <CAFLxGvxCVNy0yj8SQmtOyk5xcmYag1rxe3v7GtbEj8fF1iPp5g@mail.gmail.com>
 <CAJCQCtTEN50uNmuSz9jW5Kk51TLmB2jfbNGxceNqnjBVvMD9ZA@mail.gmail.com>
In-Reply-To: <CAJCQCtTEN50uNmuSz9jW5Kk51TLmB2jfbNGxceNqnjBVvMD9ZA@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 24 Oct 2019 00:22:32 +0200
Message-ID: <CAFLxGvwDraUwZOeWyGfVAOh+MxHgOF--hMu6P4J=P6KRspGsAA@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:56 PM Chris Murphy <lists@colorremedies.com> wrote:
> Any atomicity that depends on journal commits cannot be considered to
> have atomicity in a boot context, because bootloaders don't do journal
> replay. It's completely ignored.

It depends on the bootloader. If you care about atomicity you need to handle
the journal.
There are also filesystems which *require* the journal to be handled.
In that case you can still replay to memory.

And yes, filesystem implementations in many bootloaders are in beyond
shameful state.

> If a journal is present, is it appropriate to consider it a separate
> and optional part of the file system?

No. This is filesystem specific.

-- 
Thanks,
//richard
