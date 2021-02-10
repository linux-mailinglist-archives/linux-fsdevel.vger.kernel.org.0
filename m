Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A603315DDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 04:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhBJDib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 22:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhBJDi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 22:38:29 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FB3C061574;
        Tue,  9 Feb 2021 19:37:49 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u20so462338iot.9;
        Tue, 09 Feb 2021 19:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=x9HVDgnPoTke0bTnuMqVx+ED2tqcGWP2ABeatH+aVes=;
        b=t7jAMtqyHUpSGSscQfTSXEJg5kxqcTvxCIqa+fqcNpnL6oPcIoUnTrzPw9IrmAiSaW
         skylVVMOSW7rFqdoITC3I6GbrBr4+rw8OHB1DBWdL5yuVmQ4C9AB8JiHXIp/xkJLHXVJ
         SGQn55LLfsO5dGpLCnsyII8Nw3AgDI+aAdvNjlJ5ywh1u12ubuYWRozdkc2TLLcZItq6
         SfYAHH8i1Q2VgAN5k6jSDMaXpqj5P4Tnzd2Y9YUSP2O0oColRn5k2ULL0Aftfv1FosGZ
         Jotm4ifYvjjCKb3pjld8AskrthCliWdtsXB5ToEc+nov3YEP+0N6td5eutKTFxHage4q
         4SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=x9HVDgnPoTke0bTnuMqVx+ED2tqcGWP2ABeatH+aVes=;
        b=Oa8+9Xr0qnUOZhb7QUMxcLqgTZxyrDpkXBWen5ilhi1vVrbLv8XMOAcHGpkZFuRkiS
         rLK9opFz6v4+IhcfYh0XeSWEGFIojeLTq7AD6wRVULBUahlhFnpN05zn+lLRRJJdSy+D
         FY6jQ9Bd0dgLhpbLxOJurXKyM7gN4Piwjr/KN+NH9hZhF5tPHQrKiDTMy5s7whm0wJBg
         9QqlUzhh2pl8a37mLdKcIcD7XCYeX8TeikpJsdBeNi33vnOW8FwRO8SfhqSyNjtzmlRk
         Vz2k9kSQTJc50SNY2QqZh4XnOo2gwG2uojmp/jHsVvd+ghJCJF0JL9FWlhnnjXYt12BG
         iYgA==
X-Gm-Message-State: AOAM531UFNAypPGch5Yx9miJxfhQMwfqrhrrYh5IVy+mH19Zi4bP3F5U
        nbYSiVqTyZc8wVxNuozHDzDwmzxPI3YX3xdsT24=
X-Google-Smtp-Source: ABdhPJwk9hdwRzXxAIyP5Z1WKgHTjO3lQXYOnilNvqQLvkxYQOA3T7jqvfdl/hDL4K/3b8+GagpJW3riyr3Y9cvPHEU=
X-Received: by 2002:a02:74a:: with SMTP id f71mr1153813jaf.30.1612928269184;
 Tue, 09 Feb 2021 19:37:49 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210209235046epcas1p1416b5b121c0d78bfcb854aab46ea35c2@epcas1p1.samsung.com>
 <000001d6ff3e$62f336d0$28d9a470$@samsung.com>
In-Reply-To: <000001d6ff3e$62f336d0$28d9a470$@samsung.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 10 Feb 2021 04:37:40 +0100
Message-ID: <CA+icZUUFFrEJccHDZPV9nzj7zav-RA53eWqgKkDyvwOxCaKKnQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] exfatprogs-1.1.0 version released
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicolas Boos <nicolas.boos@wanadoo.fr>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Luca Stefani <luca.stefani.ge1@gmail.com>,
        Matthieu CASTET <castet.matthieu@free.fr>,
        Sven Hoexter <sven@stormbind.net>,
        Ethan Sommer <e5ten.arch@gmail.com>,
        Hyeongseok Kim <hyeongseok@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:50 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:
>
> Hi folk,
>
> We have released exfatprogs 1.1.0 version. In this release, exfatlabel
> has been added to print or re-write volume label and volume serial value.
> Also, A new dump.exfat util has been added to display statistics from
> a given device(Requested by Mike Fleetwood(GParted Developer)).
>
> Any feedback is welcome!:)
>

Congrats to the new release and thanks to all involved people.

Hope Sven will do a new release for Debian.
( Note that Debian/bullseye release  plans "Milestone 2" this Friday,
February 12th (see [1] > "Key release dates" > "[2021-Feb-12] Soft
Freeze"). Dunno which impact this might have on this. )

- Sedat -

[1] https://release.debian.org/


> CHANGES :
>  * fsck.exfat: Recover corrupted boot region.
>
> NEW FEATURES :
>  * exfatlabel: Print or set volume label and serial.
>  * dump.exfat: Show the on-disk metadata information and the statistics.
>
> BUG FIXES :
>  * Set _FILE_OFFSET_BITS=64 for Android build.
>
> The git tree is at:
>       https://github.com/exfatprogs/exfatprogs
>
> The tarballs can be found at:
>       https://github.com/exfatprogs/exfatprogs/releases/download/1.1.0/exfatprogs-1.1.0.tar.gz
>
