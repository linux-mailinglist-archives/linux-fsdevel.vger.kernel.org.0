Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30866457E8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 13:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhKTNCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Nov 2021 08:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhKTNCd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:02:33 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C66EC061574;
        Sat, 20 Nov 2021 04:59:30 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z26so16479558iod.10;
        Sat, 20 Nov 2021 04:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqj1rXbXhvpm+wn7g12M1++4UGTsLe43CX7Eb8nvKZ4=;
        b=hH7KAHwUCAkSUoYDCm9chTdaGIoaaQ6X37AqsJltTYzQVEX4myjJ9G1fC+WME+MI51
         jtcazbVIadOk4SuFdY4IKkgYqvOm6wh34EJ7nbORDBZ/Ftk81iNMFhlsxOVsMHx8px8h
         3C1L+lS5WWdoqpgWVuLmZbkUhag74lbXncBeR4RVNHgsQDERIj34cIesUo2bbfTsLjbs
         3l91E2jIg89jMbu8bLQINjg8P6Q3CgeevE0CyjpS2wdoHgy6B/5lKLQOyrMSdy2tOLJ1
         v8D4T8v3aS6X2edkyVPEYAkCd2TaOjZhLr99cskKUJXh04wKhkgf4wMU+iQ38SGdDCLR
         P7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqj1rXbXhvpm+wn7g12M1++4UGTsLe43CX7Eb8nvKZ4=;
        b=lK0pkTx+aG1L+UBdpn4ZdJlJm1wJLbEE+F4sT44YEK/Dhde1PLmIIYu93OnQBqBVGV
         yTVSLrAwI22zPdwk47NJtMl6vdh28XKaYA6JTEyEWB6SMSN8dIy4K63kV0+9nnd9TPt0
         YWGga/5rxWNGTUlJPnwYn+uHFaKzY7m/tG5pA+vvR9EVEApKoH5AmwVU+7I5xRwNvAHU
         4VIYZ67cflfej9qz1MwEItTefK5Si/TJC3ynqGuIWL7HXORaOQTKiFQLCywVwxLh5pok
         O+GiPEg18aoseY4Ori7ZFLreSj6q4qeZUaMwDTvYzelYx+Hdd/Z2QgeGBXdFWBjZJ6PI
         B8lw==
X-Gm-Message-State: AOAM532phukTd7NPeRWq05PAi33akVhkkBXdei/d5G5K+q+k8MZolknL
        Ca0KVYCDQl6R3MxKrm9c2yVQmuX5xJEA+rQHn/Ik+K3J9BQ=
X-Google-Smtp-Source: ABdhPJyE1Zn8zVqdyNwfVcZ15GTsoJGhlmUzVVAzG+G+OC/J91F4DbBR4tRPL4vKrrNknL+Y+iRU+Pm58cRBlAIZ2Gg=
X-Received: by 2002:a6b:d904:: with SMTP id r4mr10965131ioc.52.1637413169580;
 Sat, 20 Nov 2021 04:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20211119071738.1348957-1-amir73il@gmail.com>
In-Reply-To: <20211119071738.1348957-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 20 Nov 2021 14:59:18 +0200
Message-ID: <CAOQ4uxgHHF-sY+NSGQhc=vkrEg34k7tNuPZvQy3NYU-0yZPQ3A@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Extend fanotify dirent events
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 9:17 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Jan,
>
> This is the 2nd version of FAN_REPORT_TARGET_FID patches [1].
>
> In the first version, extra info records about new and old parent+name
> were added to FAN_MOVED_FROM event.  This version uses a new event
> FAN_RENAME instead, to report those extra info records.
> The new FAN_RENAME event was designed as a replacement for the
> "inotify way" of joining the MOVED_FROM/MOVED_TO events using a cookie.
>
> FAN_RENAME event differs from MOVED_FROM/MOVED_TO events in several ways:
> 1) The information about old/new names is provided in a single event
> 2) When added to the ignored mask of a directory, FAN_RENAME is not
>    reported for renames to and from that directory
>
> The group flag FAN_REPORT_TARGET_FID adds an extra info record of
> the child fid to all the dirent events, including FAN_REANME.
> It is independent of the FAN_RENAME changes and implemented in the
> first patch, so it can be picked regardless of the FAN_RENAME patches.
>
> Patches [2] and LTP test [3] are available on my github.
> A man page draft will be provided later on.
>
> Thanks,
> Amir.
>
> [1] https://lore.kernel.org/linux-fsdevel/20211029114028.569755-1-amir73il@gmail.com/
> [2] https://github.com/amir73il/linux/commits/fan_rename
> [3] https://github.com/amir73il/ltp/commits/fan_rename

Here is a first man page draft [4].
It based on top of both FAN_REPORT_PIDFD and FAN_FS_ERROR patches.
I did not elaborate about the new info types yet in fanotify.7, because Matthew
was going to rephrase the entire section about fanotify_event_info_header.

Thanks,
Amir.

[4] https://github.com/amir73il/man-pages/commits/fan_rename
