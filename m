Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B982CF04C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 16:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgLDPDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 10:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbgLDPDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:03:06 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8C4C061A4F
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Dec 2020 07:02:26 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id j140so3400751vsd.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Dec 2020 07:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L8Av0b0tkSDoVYAGA9Ul3UP0kLwwbvt1kNS0v+OC54s=;
        b=Xm5/6uLpgEYar8q6Uww1lyRELI9tbT7fkb8OU6oHeRzLyQOPQAxVUKzCzSv59vRQNW
         ulc5cP7UYGP9yfc0sunyEaE7hejWfb09FT2bLgt3XI8cjbTFkpPRTRknTXIFFhOTViaC
         i2+YxFZNLG2KC7eeA8yPoq4NZgBqGSaJ3/ot4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L8Av0b0tkSDoVYAGA9Ul3UP0kLwwbvt1kNS0v+OC54s=;
        b=pjTrCAT9itGrc8Pqf/ueIp6T+49CIt3+JueJTvfEq3heMtUJhWBtCaCN10Bv4Tql1g
         RqPB3iyKK1VMsI+1nAAXMl2CeL8ZitClkKZqIEByHinxqmZnc4WvykyJ1qQzFmRf5/MH
         hYZFDz4OZl2dkPupzA/bFSnXrYp0DXyTX/pGMFhfku/WKkyGlUVmoL4j4WumvbL1ZSl6
         XQpaiD7WzKfcuT1QXLxMEleNitl69AYjI7ZvRHD2sWE1Ac/1Ytdj8HTjMkADGY04w9ap
         Zom8muIiilte6jtVNrFgh4y2FtYw6HBnBzqKIxZKiFWeY0v7WuCS5ItWUzY4eFX0nJv2
         Ce+A==
X-Gm-Message-State: AOAM530im+bFmoqKYu9RnpoEwRZkLD3XakbUQvamz9dur47UsrKuDh5C
        xi2kgQS7dDo1Hz70Nl3aF34J7ejo7CsLOBZiIWvVTQ==
X-Google-Smtp-Source: ABdhPJxwaq9QG5yLGeL/Oybu4svoQAZwW6p0AtOH1k3WSVCT5wGrFbndLVa39lzuAECYH/4XoNTWvCSFyUHNvAkFJ8I=
X-Received: by 2002:a05:6102:126c:: with SMTP id q12mr3992650vsg.9.1607094145824;
 Fri, 04 Dec 2020 07:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20201113065555.147276-1-cgxu519@mykernel.net> <1762e3a7bce.e28cb82145070.9060345012556073676@mykernel.net>
In-Reply-To: <1762e3a7bce.e28cb82145070.9060345012556073676@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 4 Dec 2020 16:02:14 +0100
Message-ID: <CAJfpegsbb4iTxW8ZyuRFVNc63zg7Ku7vzpSNuzHASYZH-d5wWA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/9] implement containerized syncfs for overlayfs
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack <jack@suse.cz>, amir73il <amir73il@gmail.com>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 4, 2020 at 3:50 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2020-11-13 14:55:46 Chenggua=
ng Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
>  > Current syncfs(2) syscall on overlayfs just calls sync_filesystem()
>  > on upper_sb to synchronize whole dirty inodes in upper filesystem
>  > regardless of the overlay ownership of the inode. In the use case of
>  > container, when multiple containers using the same underlying upper
>  > filesystem, it has some shortcomings as below.
>  >
>  > (1) Performance
>  > Synchronization is probably heavy because it actually syncs unnecessar=
y
>  > inodes for target overlayfs.
>  >
>  > (2) Interference
>  > Unplanned synchronization will probably impact IO performance of
>  > unrelated container processes on the other overlayfs.
>  >
>  > This series try to implement containerized syncfs for overlayfs so tha=
t
>  > only sync target dirty upper inodes which are belong to specific overl=
ayfs
>  > instance. By doing this, it is able to reduce cost of synchronization =
and
>  > will not seriously impact IO performance of unrelated processes.
>
> Hi Miklos,
>
> I think this version has addressed all previous issues and comments from =
Jack
> and Amir.  Have you got time to review this patch series?

Hopefully yes.

I'm really keen to finish off the unprivileged overlay patches first.
Will test and post a new version shortly.

Thanks,
Miklos
