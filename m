Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE42343C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 11:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbgGaJ5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 05:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732075AbgGaJ5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:57:10 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A6EC061574;
        Fri, 31 Jul 2020 02:57:09 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v6so11453020ota.13;
        Fri, 31 Jul 2020 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=FyhCYi6g4YzyZpgKiE56nTAk512yZAZT9MByNiXh9aY=;
        b=IscAdJ8/QI37J/xWoKdvhAHwTtMGr8z2w/2J4DyRBrBoPNLM0O8CVBNSJHNNuoVj3m
         R40Tqw7xsrBvG8YmhQtBPCrM7ehFPR5lHo0lyPRIn/ZAbfQVkjiCHsihfviqeV/xrhJi
         ycROQMv6/FiGneIB36YowjGvYUUB677RfZQ1MxyecIQFAls/KNm28J4Z86Kwbeo2bA0g
         iASOj4T9yYFcttmdG1e0Qp9MKD1z9s3pS2tp7eZUql+wTpkjPhpuKvxJTRwJP4TDG8NL
         7KVvmuHq5tZw4WSfGFPUAisysr9nd29FLY+UJyoXltG6gh5KuOi+fJKeREyrhyf23m93
         kC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=FyhCYi6g4YzyZpgKiE56nTAk512yZAZT9MByNiXh9aY=;
        b=chEo02++naT5ocYn5fJJGxCD6KQqlYRiRPrIbN0KVQ0vb7W9+dBHoUE5Gv03/rQa6t
         DvpYzqMQfEfmcHqUqLsUep6Yx78KHWwdEksX3NU3rbt4GznNrjlwn+2PMKJwcKLLqdJH
         1lBr2c7VoDvXUfZP1nMfsEmq2PJV5MabP4VuCCucDZf0IAjSEJZU2l1STp8MQgHsZVDe
         OgmdNRcoFO/9wWtCaacOD3APvyrUimSGePbqgoLre0Nww+88udx+NhFRQ6Pf+w+fGQvq
         mcyoP4iP4EcfQAG9aUvha6XJG4+ZIGeJY70P4Uldratnv5WFDb/PdPEopzA1N5NsLI5p
         7u6g==
X-Gm-Message-State: AOAM531SewF6CYvfvLBRY+WAWSMkii2cTU5LNDd7rODdW867QRVfMJ7T
        wv00cevZpvzUB/d7MnJ+IUWi96aZHCch5XoRpqQ=
X-Google-Smtp-Source: ABdhPJzlP+lxlTp00U4Ru19RjqY2nXFlPVbvrCW8DYnGm2HCe340v8RToGMbM+LapxM5074rP6X50okluR/wbMaN2h8=
X-Received: by 2002:a9d:5e5:: with SMTP id 92mr2412425otd.9.1596189429228;
 Fri, 31 Jul 2020 02:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200731071604epcas1p39fe86c3931c5adf9073817c12fb15f1d@epcas1p3.samsung.com>
 <002901d6670a$742e8cf0$5c8ba6d0$@samsung.com>
In-Reply-To: <002901d6670a$742e8cf0$5c8ba6d0$@samsung.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 31 Jul 2020 11:56:57 +0200
Message-ID: <CA+icZUX8KWtdDpMcmzqp461ndcyfvP13gaZK591OFpkp3nRHaQ@mail.gmail.com>
Subject: Re: exfatprogs-1.0.4 version released
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
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 31, 2020 at 9:16 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:
>
> Hi folk,
>
> In this release, The performance of fsck have been much improved and
> the new option in mkfs have been added to adjust boundary alignment.
>
> As the result below, The fsck performance is improved close to windows's fsck
> and much faster than the one in exfat-utils package.
>
> We measured the performance on Samsung 64GB Pro microSDXC UHS-I Class 10 which
> was filled up to 35GB with 9948 directories and 16506 files.
>
> | Implementation       | version           | execution time (seconds) |
> |--------------------- |-------------------|--------------------------|
> | **exfatprogs fsck**  | 1.0.4             | 11.561                   |
> | Windows fsck         | Windows 10 1809   | 11.449                   |
> | [exfat-fuse fsck]    | 1.3.0             | 68.977                   |
>

Hi Namjae Jeon (what is your First name and Family name?),

congrats to version 1.0.4 and hope to see it in the Debian repositories soon.

Great numbers for exfatprogs/fsck!

> And we have been preparing to add fsck repair feature in the next version.
> Any feedback is welcome!:)
>
> CHANGES :
>  * fsck.exfat: display sector, cluster, and volume sizes in the human
>    readable format.
>  * fsck.exfat: reduce the elapsed time using read-ahead.
>
> NEW FEATURES :
>  * mkfs.exfat: generate pseudo unique serials while creating filesystems.
>  * mkfs.exfat: add the "-b" option to align the start offset of FAT and
>    data clusters.
>  * fsck.exfat: repair zero-byte files which have the NoFatChain attribute.
>
> BUG FIXES :
>  * Fix memory leaks on error handling paths.
>  * fsck.exfat: fix the bug that cannot access space beyond 2TB.
>
> The git tree is at:
>       https://github.com/exfatprogs/exfatprogs
>
> The tarballs can be found at:
>       https://github.com/exfatprogs/exfatprogs/releases/download/1.0.4/exfatprogs-1.0.4.tar.gz
>

Just a small nit for the next announcement.
Please point (also) to the tar.xz tarball and maybe to the releases
tag in GitHub.
( Today, I love/prefer to use ZSTD where possible - that is another story. )

Have more fun.

Regards,
- Sedat -

[1] https://github.com/exfatprogs/exfatprogs/releases/download/1.0.4/exfatprogs-1.0.4.tar.xz
[2] https://github.com/exfatprogs/exfatprogs/releases/tag/1.0.4
