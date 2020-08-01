Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1412354A3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 01:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgHAXgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 19:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHAXgg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 19:36:36 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A963A20888;
        Sat,  1 Aug 2020 23:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596324995;
        bh=jKcmiVnyhX7ZMjwFG8uJA1WfaDH8Ynl7u9BiO2s1YC4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=rZheyni+lAHzs+CQMwfRnP1HENyNQDkHQ/vl64Tu7CqSyADn/DkgOYj3j9fo6OI4e
         zlRqj85XB+azY/8XYFBiQFX7yCzYpJB/DextHt31dR7WOzhgw3J7OYzN9eEBwKt2Gd
         sFlMf9+vlWyC4j9OnCeGJVp2aV1bruqG0SDLDRHA=
Received: by mail-oi1-f181.google.com with SMTP id b22so4191474oic.8;
        Sat, 01 Aug 2020 16:36:35 -0700 (PDT)
X-Gm-Message-State: AOAM530efL4bNBzHFoBNfPdbOZpmDpKCVuHfp4cV81cghwWZdDBFutKj
        2kPsLbmXUvqOvr1FUH6MyXX6xGb6LLcJSoU6j7U=
X-Google-Smtp-Source: ABdhPJwpfKPTdvd6Lc82P75TrzmAWSMEtx+KOlXM6xx6ELxRw45Qn2z+cM3lFxlRxrTz3+ZI9m8hOyoettzvVmhAO6s=
X-Received: by 2002:aca:3957:: with SMTP id g84mr6289817oia.62.1596324994894;
 Sat, 01 Aug 2020 16:36:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6102:0:0:0:0:0 with HTTP; Sat, 1 Aug 2020 16:36:33 -0700 (PDT)
In-Reply-To: <CA+icZUX8KWtdDpMcmzqp461ndcyfvP13gaZK591OFpkp3nRHaQ@mail.gmail.com>
References: <CGME20200731071604epcas1p39fe86c3931c5adf9073817c12fb15f1d@epcas1p3.samsung.com>
 <002901d6670a$742e8cf0$5c8ba6d0$@samsung.com> <CA+icZUX8KWtdDpMcmzqp461ndcyfvP13gaZK591OFpkp3nRHaQ@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 2 Aug 2020 08:36:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-VCQrJqP_dfM+wPEf4nPhuqhu3F=9cGeNCOGzFmPZwjw@mail.gmail.com>
Message-ID: <CAKYAXd-VCQrJqP_dfM+wPEf4nPhuqhu3F=9cGeNCOGzFmPZwjw@mail.gmail.com>
Subject: Re: exfatprogs-1.0.4 version released
To:     sedat.dilek@gmail.com
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

2020-07-31 18:56 GMT+09:00, Sedat Dilek <sedat.dilek@gmail.com>:
> On Fri, Jul 31, 2020 at 9:16 AM Namjae Jeon <namjae.jeon@samsung.com>
> wrote:
>>
>> Hi folk,
>>
>> In this release, The performance of fsck have been much improved and
>> the new option in mkfs have been added to adjust boundary alignment.
>>
>> As the result below, The fsck performance is improved close to windows's
>> fsck
>> and much faster than the one in exfat-utils package.
>>
>> We measured the performance on Samsung 64GB Pro microSDXC UHS-I Class 10
>> which
>> was filled up to 35GB with 9948 directories and 16506 files.
>>
>> | Implementation       | version           | execution time (seconds) |
>> |--------------------- |-------------------|--------------------------|
>> | **exfatprogs fsck**  | 1.0.4             | 11.561                   |
>> | Windows fsck         | Windows 10 1809   | 11.449                   |
>> | [exfat-fuse fsck]    | 1.3.0             | 68.977                   |
>>
>
> Hi Namjae Jeon (what is your First name and Family name?),
Hi Sedat,
First name : Namjae, Last name : Jeon
>
> congrats to version 1.0.4 and hope to see it in the Debian repositories
> soon.
Thanks:)
>
> Great numbers for exfatprogs/fsck!
>
>> And we have been preparing to add fsck repair feature in the next
>> version.
>> Any feedback is welcome!:)
>>
>> CHANGES :
>>  * fsck.exfat: display sector, cluster, and volume sizes in the human
>>    readable format.
>>  * fsck.exfat: reduce the elapsed time using read-ahead.
>>
>> NEW FEATURES :
>>  * mkfs.exfat: generate pseudo unique serials while creating filesystems.
>>  * mkfs.exfat: add the "-b" option to align the start offset of FAT and
>>    data clusters.
>>  * fsck.exfat: repair zero-byte files which have the NoFatChain
>> attribute.
>>
>> BUG FIXES :
>>  * Fix memory leaks on error handling paths.
>>  * fsck.exfat: fix the bug that cannot access space beyond 2TB.
>>
>> The git tree is at:
>>       https://github.com/exfatprogs/exfatprogs
>>
>> The tarballs can be found at:
>>
>> https://github.com/exfatprogs/exfatprogs/releases/download/1.0.4/exfatprogs-1.0.4.tar.gz
>>
>
> Just a small nit for the next announcement.
> Please point (also) to the tar.xz tarball and maybe to the releases
> tag in GitHub.
Sure. I will do that on next release.
> ( Today, I love/prefer to use ZSTD where possible - that is another story.
> )
I'm not sure if it is meaningful to provide various compression for
small archive file. In particular, I wonder if other distribution
maintainers want it.
>
> Have more fun.
Nice day!
>
> Regards,
> - Sedat -
>
> [1]
> https://github.com/exfatprogs/exfatprogs/releases/download/1.0.4/exfatprogs-1.0.4.tar.xz
> [2] https://github.com/exfatprogs/exfatprogs/releases/tag/1.0.4
>
