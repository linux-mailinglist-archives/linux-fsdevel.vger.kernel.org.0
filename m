Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671862E022F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 22:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgLUVsr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 16:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLUVsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 16:48:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A2FC0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 13:48:00 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i9so12607521wrc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 13:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJwNosMQ9oAMOMVQpA2VE5VLl1WCOnFs/smZFBMMo6c=;
        b=FTqz5zxIJ/vHa8Zjey5z9EQR6oluje5MsYy2c1S9D43nA2MWTp2ut3MZHpxoLNANTK
         FNjoU+qy3iE/+ewoLWayxvF8OH6mo8AoZQPLWNUAaC5ZXZ6uwS57ww3IB1mA+YI+xlTD
         ncr3hEsOZypPqZDtgRNWK4pA9diIe+GtKiDGbr0KvZVaPT3r4I7iQTLDRCZvY3YvLJ2M
         W0NA6IV6bdoIoSzyIGj1Brqd1LaCjuBeeQMGtSjs84oN9nkUn8IfF3n73nErIgFcFqTs
         GYP68ZwLDcsbZjaOcVoML1vEOHLx3rhYMRcXD1sPEheKRBmPYBybGq5R+IZ05mkCB4u+
         vr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJwNosMQ9oAMOMVQpA2VE5VLl1WCOnFs/smZFBMMo6c=;
        b=D905aGBhIYYx0P1tK7xou+cUPhmgmd5w99gAxaRYhBJmwOcj71JyeqPOKohMgkZ2V5
         Fo2+1PC/lo1Z+gJZmNWgwEnvwdu+7VInaEMJHlNOvJ+s64Wd6e47jCuz8j7m73XqMfiY
         WAefvvHTbzPu0ODr3W8OL4ja/HzKhQ5kLXzNLu+48gmSZZ2fV3epNTjOR8Q/TvZO+ivz
         ptEo19+gRKAQ1gV6/VMCKT/cS6VvtEL/8xdUD6OO9WWFtI0l9kuGi7EPkiaa/dbQ8eYJ
         jQTHJ2y8NnWWlei+iZb3B92L+XF1VK5sLwxiszdsQwOyMBXym0yrp00DUr4jPSr9jP1E
         Krxg==
X-Gm-Message-State: AOAM530PV/ZXR0HqWfTnLexM8/om5Qn6eVd4xqr0+mC80Aidjk8v0xCd
        EK4PnM3s62H10uGVBOAEg7qECYV8ImWEhN9caQ/Cxw==
X-Google-Smtp-Source: ABdhPJxDGgM14sCGDoSKDWoalGca8/FS3iPb0F3tPE4WTXkIlDmxfQ/bAGbA8fBhB8+v11deLDnbAh+ltPyhudecGi4=
X-Received: by 2002:a5d:47cc:: with SMTP id o12mr19570778wrc.236.1608587279373;
 Mon, 21 Dec 2020 13:47:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtQUvyopGxBcXzenTy8MuEvm+W1PQNqzFf1Qp=p1M9pBGQ@mail.gmail.com>
 <x49sg83t0dq.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49sg83t0dq.fsf@segfault.boston.devel.redhat.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 21 Dec 2020 14:47:43 -0700
Message-ID: <CAJCQCtSgZiD=F2SJw2NPq1ApoLXDJFWXPSib=A4=hi2KH7ZsNA@mail.gmail.com>
Subject: Re: how to track down cause for EBUSY on /dev/vda4?
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 18, 2020 at 11:49 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Chris Murphy <lists@colorremedies.com> writes:
>
> > Hi,
> >
> > Short version:
> > # mkfs.any /dev/vda4
> > unable to open /dev/vda4: Device or resource busy
> >
> > Curiously /dev/vda4 is just a blank partition, not in use by anything
> > that I'm aware of. And gdisk is allowed to modify the GPT on /dev/vda
> > without complaint. This is a snippet from strace of the above command
> > at the failure point:
> >
> > openat(AT_FDCWD, "/dev/vda4", O_RDWR|O_EXCL) = -1 EBUSY (Device or
> > resource busy)
>
> [snip]
>
> > format, and /proc/mounts shows
> >
> > /dev/vda /run/initramfs/live iso9660
> > ro,relatime,nojoliet,check=s,map=n,blocksize=2048 0 0
>
> That mount claims the device, and you can't then also open a partition
> on that device exclusively.
>
> > So it sees the whole vda device as iso9660 and ro? But permits gdisk
> > to modify some select sectors on vda? I admit it's an ambiguous image.
> > Is it a duck or is it a rabbit? And therefore best to just look at it,
> > not make modifications to it. Yet /dev/vda is modifiable, where the
> > partitions aren't. Hmm.
>
> The file system is mounted read-only.  It may be that the /device/ is not
> read-only.


OK super, thanks for the clear explanation.


-- 
Chris Murphy
