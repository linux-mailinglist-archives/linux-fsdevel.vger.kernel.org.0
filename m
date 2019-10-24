Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5188E3F47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 00:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbfJXWTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 18:19:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33036 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfJXWTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:19:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so176546wro.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ur3SzervNy5z3kprdStHyt6yaPFy2FcCR01L4oTo5v8=;
        b=ulxjH88GwBdA9mUfcbP6BvvC7qj6YFeD/L8tcuLgFXyhoqH+vt62wM6DV+hGi8dueT
         RtVK9lKvrRTlJOe4GXwkodCn+tJAasHFACIL1khRjuCw+EXjq5djiPipMyKwGawdDjyb
         DAO9KrF/tjgN/M3Pr7ztwFA+BjTrZP8rk5u+lhN6IY/0ef1dhuDT0IaJZVS7yIR00d6J
         RZtDVUPXtNmxkvWWESNdVc683vb6TtJNrWiX2278GK1z8Ce/Pmk9T3bSdfbJ1kGKCR50
         Y6ZptNGtJXcHvTrl4SiId4DcdFyovRako0mek9UsEUOJIgs305FDFD5zZace0YpE7Q/w
         HOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ur3SzervNy5z3kprdStHyt6yaPFy2FcCR01L4oTo5v8=;
        b=lixqZjZmKZHPtVOQBW8I9Wj7YkrsoUeDSrgq3OV9HO/6CgleDEyJ4OsWuQ72k6ln0e
         QKa1U/OQKrk7Jyq9EVZTft3Hsy5fiqh4Ots8zz5yZ2GDC4VAr9VDCrIbey6El8iJOo9W
         nRAzukVVBTV8uW0nn82fOZQdo3QuTECvl936K+07DLJAnM4H8+aR7X0Mulmtybu2pui+
         sKSMFuYJ5kWi/cAxHVTQrxU9HfnvT3/CXUYqrQ7QWLqRDFBmW9xhQC4xbmw4DSp5sO9e
         Pke72wXAHq+cuUGMKUwPtLkQO9C1L/NQpXHFrnBRCvO8xvofjo97uB6DAyGOwMOMA/YN
         i/AA==
X-Gm-Message-State: APjAAAUjvzHN5+C2pAjd1y6IYAbsPrdX5YYBn/YmTMlWGis24a4WO2rP
        HjbE5wkldSH6vSpBGU/N0AY3O22QeL5rtMSYxlHkwg==
X-Google-Smtp-Source: APXvYqweYnPzIO8x3A3ChJdioqoQlkMzM2pvjdCFuDyLnhlhukOurTBrfaCi5KrasVInQKTIEmvKESNHtaXfD9+oqas=
X-Received: by 2002:a5d:6246:: with SMTP id m6mr6040124wrv.262.1571955577288;
 Thu, 24 Oct 2019 15:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali> <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
 <20191023115001.vp4woh56k33b6hiq@pali> <CAJCQCtTZRoDKWj2j6S+_iWJzA+rejZx41zwM=VKgG90fyZhX6w@mail.gmail.com>
 <20191023171611.qfcwfce2roe3k3qw@pali> <CAFLxGvxCVNy0yj8SQmtOyk5xcmYag1rxe3v7GtbEj8fF1iPp5g@mail.gmail.com>
 <CAJCQCtTEN50uNmuSz9jW5Kk51TLmB2jfbNGxceNqnjBVvMD9ZA@mail.gmail.com>
 <CAFLxGvwDraUwZOeWyGfVAOh+MxHgOF--hMu6P4J=P6KRspGsAA@mail.gmail.com>
 <CAJCQCtQhCRPG-UV+pcraCLXM5cVW887uX1UoymQ8=3Mk56w1Ag@mail.gmail.com> <20191024215740.dtcudmehqvywfnks@pali>
In-Reply-To: <20191024215740.dtcudmehqvywfnks@pali>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 25 Oct 2019 00:19:16 +0200
Message-ID: <CAJCQCtTzv0K2xNZ8VDyziMRRKe5sdTApdZ1mZs0MJ_nx1JpMCQ@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 11:57 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> On Thursday 24 October 2019 23:46:43 Chris Murphy wrote:
> > So that leads me to, what about FAT? i.e. how does this get solved on F=
AT?
>
> Hi Chris! I think that for FAT in most cases it used ostrich algorithm.
> Probability that kernel crashes in the middle of operation which is
> updating kernel image on boot partition is very low.
>
> I'm Looking at grub's fat source code and there is no handling of dirty
> bit... http://git.savannah.gnu.org/cgit/grub.git/tree/grub-core/fs/fat.c
> It just expects that whole FAT fs is in consistent state.

I can't estimate how likely the same situation is for typical UEFI
firmware. But many follow TianoCore and if TianoCore is being overly
optimistic, now what?

So then I think of ugly but effective things, just like ChromeOS,
where we have two mirrored ESP's, and create a faux dirty bit with a
hidden file /.dirty or some ugly crap and hope to some deity that we
could get agreement among bootloader developers to prefer the ESP
without that file. File gets set, do all the modifications, and only
once fsync() exits 0, remove the /.dirty file? I mean...that's crazy
isn't it?

--=20
Chris Murphy
