Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4988D325ABE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 01:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhBZAWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 19:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhBZAWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:22:23 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F133DC061574;
        Thu, 25 Feb 2021 16:21:42 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id u75so7227547ybi.10;
        Thu, 25 Feb 2021 16:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9wtvzsP9n0ZRp/18oaJpo+a9Pw9RY5ZydEKMoj+prZQ=;
        b=KWnxoUuLankb6FZHjOMUSUEwdZNfjyWKrzwnCCL5JzhoYAhH0xkXSoKkBYy2tfNOYD
         Z0T7gvEAHVXB8TlSBL9mQ2xwNuEcWRQpSz9hPBiNr/b7IuaWojQpg+RR8JrdKs02YO/d
         c5wAQ5sIsZ+JeQaYXVW5yQdrWkMJkL19aTcpYzFCRyZwDgY9BZBCwTkyMi1MqWK6yMyn
         yUw83JCCya+OTPrDDWsnyXL5Bny21naIpnd2efprgcJ7Nj1MANBp1lxlrzPPU0LU+BQC
         y6h0ETobPoQvAoOI/NlH7/7vWK+bc5Vg+frflhdIJTaydK8pwctzu4Jt86ES6ek3MSKB
         +f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9wtvzsP9n0ZRp/18oaJpo+a9Pw9RY5ZydEKMoj+prZQ=;
        b=oVsE+WGqbpGW+d9pacTrg4p+T4h2S9ojgNG0KzYFLEugNJpJ7P8o3KhW8M7LLSwEAl
         /FUu+ncR4cT7vzNy+f/4nWrZhjUoH5LntLetnR0JBR7zn+SO+PBR6CVEMNwgswDKw5lJ
         esUvTwclhEPgS8rdigFt9fomk3qTxTMf4gmlqJL6QI1AR6m2K1ZSB3Np+qZNK/r1VREA
         qB65W0tCtCTrYudoSCtDhHWHSizIHOKRm4d1M2fRV5oHyDEoe6cHQ5PVpsn5rXhQJ4to
         gsXF2FMCutf3P7imwbMDJppkzsUPYyQfmkIm+bVS1rM6Hf7WN1rT8jqnIBI/cwiV4Iu3
         N2WQ==
X-Gm-Message-State: AOAM5313i9GV4b+xUHE2aCxlXXSNxW9srqnFidMxmcM1X2J9TONXT+Pv
        Zsw62C2p21r5NoJ6q66EVFGCSESY8JOCzEETNm4=
X-Google-Smtp-Source: ABdhPJxdpwta3sQHIacZtRXurLpIYJ0uo+xxbZR6oqhEoUcPjg1cME7UKVdDk6sd05qQ9g06g6hkZkKew8q12rFHFoI=
X-Received: by 2002:a25:424f:: with SMTP id p76mr720182yba.109.1614298902249;
 Thu, 25 Feb 2021 16:21:42 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
 <20210225132647.GB7604@twin.jikos.cz> <CAPkEcwjcRgnaWLmqM1jEvH5A9PijsQEY5BKFyKdt_+TeugaJ_g@mail.gmail.com>
 <CAE1WUT7JOyeWi8DHZS3fNMAq+GX9qsm7iPC01x60m1W84ZdPrA@mail.gmail.com>
In-Reply-To: <CAE1WUT7JOyeWi8DHZS3fNMAq+GX9qsm7iPC01x60m1W84ZdPrA@mail.gmail.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 25 Feb 2021 19:21:06 -0500
Message-ID: <CAEg-Je-QP+6ad649L-vQDctfQbsHm_d4-NpGOwCKATHM0LamTA@mail.gmail.com>
Subject: Re: Adding LZ4 compression support to Btrfs
To:     Amy Parker <enbyamy@gmail.com>
Cc:     Jim N <northrup.james@gmail.com>, dsterba@suse.cz,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 25, 2021 at 6:18 PM Amy Parker <enbyamy@gmail.com> wrote:
>
> Thanks for your comments, Jim. I was originally going to abandon my
> thoughts about LZ4 on btrfs - but I didn't realize that FAQ was from
> 2014.
>
> > lz4 has had ongoing development and now exists in other linux kernel fs=
's.
> What other filesystems currently employ LZ4? Not as familiar with it
> being used on other filesystems.
>

In the Linux kernel, both SquashFS and F2FS have LZ4 compression support.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
