Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EAF32504C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 14:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhBYNUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 08:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhBYNUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:20:10 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78664C061574;
        Thu, 25 Feb 2021 05:19:29 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 133so5368082ybd.5;
        Thu, 25 Feb 2021 05:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4JV2j4UkKblrD8dvxt7pVuzmkwSyT4nO4+MXb/5296c=;
        b=EH70tK7qxc9ePO4ZUWjXeeXo2zXb6vx5BB1v+9BVVqbqGhPpVG9xayDnw44BFrzneF
         tOKBtiJP31f52ivwd3vszEOJj7kbCk/Q/61a+3qurr0njlEyrfVhfGwAKWRmAwzDNyPc
         +kbbq7q7RpAlBZfQ9duf4JUo20Ko8qSBrnsVWbBbUCNg3QHtZmuWtUGpEJQE7MnuBskr
         jXkctkzUCYoXxwmjMMiHO+evBHP5XHqVDBF7V0A/O2UwlQTKY+LWfyCHGNTn0ncSimAu
         e/BgeqfXmPhnj6P2Mu7IL9p5/OE7ZubFQeElq18E3uoHX1zyp3DQKGopwimFlZlZxmE3
         E9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4JV2j4UkKblrD8dvxt7pVuzmkwSyT4nO4+MXb/5296c=;
        b=IgeMa/oWL5Bh3f4O48GkqgJqUimKUSpJwK9OaekGyJOk2ajhHF4X2SAltpNk3VNN0R
         iC0mNpknB1hMK0FImSMOsayJ2l5gy/lzu0IKav+3kSlN4MjP5vwWgNvbEWBlsGYIdvM/
         V1E920BVMuUOOOAQtDmFeXj3AyX4nOjAghSg5fGCyRMFUo+uFL0wd3mckmrk8ffYzyNv
         kDWSw7pclw18OwHAUqeZQwboA4sMjxw0tOblHcNg2gBe3yY5duGiuf/OZHOPPx5EMNyj
         7mGIzsr6VYCaIsQ82OVTuTe/l1kaopp2qY5W8W9JKYd8GOFYB/tqoIUwcla1DEZ2HkAe
         vKIA==
X-Gm-Message-State: AOAM530JZAcE3EZ4ADZLWpOvsViFLgWZVP6hhTIvq9tZR8RW3im8Ytab
        nbwaGp8Rw/CV3Pxi3atRzTOe/KlUIgnWGjUIV0Y=
X-Google-Smtp-Source: ABdhPJzIhuYph4dFAyEjbDgWes+B0xljjyrLlBNo8C6OOrkds3LH6oHV4pLkDCBJ+VCf9u0hxZmzbBRFM9waZGC9xYU=
X-Received: by 2002:a05:6902:4b0:: with SMTP id r16mr4086758ybs.184.1614259168783;
 Thu, 25 Feb 2021 05:19:28 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
In-Reply-To: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 25 Feb 2021 08:18:53 -0500
Message-ID: <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
Subject: Re: Adding LZ4 compression support to Btrfs
To:     Amy Parker <enbyamy@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 11:10 PM Amy Parker <enbyamy@gmail.com> wrote:
>
> The compression options in Btrfs are great, and help save a ton of
> space on disk. Zstandard works extremely well for this, and is fairly
> fast. However, it can heavily reduce the speed of quick disks, does
> not work well on lower-end systems, and does not scale well across
> multiple cores. Zlib is even slower and worse on compression ratio,
> and LZO suffers on both the compression ratio and speed.
>
> I've been laying out my plans for a backup software recently, and
> stumbled upon LZ4. Tends to hover around LZO compression ratios.
> Performs better than Zstandard and LZO slightly for compression - but
> significantly outpaces them on decompression, which matters
> significantly more for users:
>
> zstd 1.4.5:
>  - ratio 2.884
>  - compression 500 MiB/s
>  - decompression 1.66 GiB/s
> zlib 1.2.11:
>  - ratio 2.743
>  - compression 90 MiB/s
>  - decompression 400 MiB/s
> lzo 2.10:
>  - ratio 2.106
>  - compression 690 MiB/s
>  - decompression 820 MiB/s
> lz4 1.9.2:
>  - ratio 2.101
>  - compression 740 MiB/s
>  - decompression 4.5 GiB/s
>
> LZ4's speeds are high enough to allow many applications which
> previously declined to use any compression due to speed to increase
> their possible space while keeping fast write and especially read
> access.
>
> What're thoughts like on adding something like LZ4 as a compression
> option in btrfs? Is it feasible given the current implementation of
> compression in btrfs?

This is definitely possible. I think the only reason lz4 isn't enabled
for Btrfs has been the lack of interest in it. I'd defer to some of
the kernel folks (I'm just a user and integrator myself), but I think
that's definitely worth having lz4 compression supported.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
