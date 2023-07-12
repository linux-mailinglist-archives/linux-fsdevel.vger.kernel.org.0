Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EB2751074
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 20:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjGLSZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 14:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjGLSZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:25:57 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9436F1BEC;
        Wed, 12 Jul 2023 11:25:54 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-440b53841a4so1752176137.3;
        Wed, 12 Jul 2023 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689186353; x=1691778353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sOcI2jxuVJp353RgogKNfvCVFy7OwS+eMp4jITy9DY=;
        b=kggsOn6JcSO57G7NFHcUbcsHJOaMIK5tz1Mxw/dr95Sj8bB41AgzwvX0PcQm9Uwm3V
         zYtTkNvklyoK++BatlmLLgCo9PlvV6NeJVRKWjcVw+IUlCTAXDBt0lWS4QBpuZT3ooAO
         pSQCpdXFq2/T7F735GQEuInuPJdHTDtWkl4toBR1TAJ5zxgB8Nikggw88ts1nhxp/RCL
         /bC+p0sVVo8jiztLH2xJbvkYdWWFTw9GKmgnJOSWHwI/2YWajkOEJ6WvpF0mrn1Ssbxc
         eQr2kziE3zttEIVWwlNKTA1nnKGRiX28DUQj1iCrtnc2B1okbRMzZLuJiuNW0ZL+o4kp
         WoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689186353; x=1691778353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sOcI2jxuVJp353RgogKNfvCVFy7OwS+eMp4jITy9DY=;
        b=hYm09VOWIbQxttLZ0PVKeyGyGwi/iQOhc0oawY/3tjG8NkYgpJ1s8+ipo7QYb8dwjl
         z5u48JUqyndiFawAuksOY0rIx1lkOPBvBQ3hDhP8QPTzcU3Ll2Kc1pXcDAipCv+A74Y6
         I4uD5ZtoAJ4qLpoUTZJf6CdT8TjH53XEHveSeUtW0O7EILcrOJ7ejKJCLRs9E8Y/3jH3
         CU2aeAdFrWgl1zkERzU0cM9Wqr1khQhh/mHj/C0fNVNhtC5L4RJuvfImda3D1u97wTmS
         4InBmjGPiDxMKjcidM+yL8iRK1TrUORf6wiuGkE9ceEYKvjyAgz1VxnX5jYuwRgI1nPn
         24fA==
X-Gm-Message-State: ABy/qLYIAuze3xq132a0ZAMqRHXw47J2u6DN1t4+DenfSuCywuRzoqwD
        yQbYxBlO+RPibu7FILqbpvN9ojY3KG5YIT5dotc=
X-Google-Smtp-Source: APBJJlHyRxqI+3+chJwIFnAoBNpNOha/JYdUdI8l5xO8mEtpGJFTnFIwYDBcfPZI75Pja6vysb+v/1GzB2oqO6hPIdw=
X-Received: by 2002:a67:eb84:0:b0:443:7572:598b with SMTP id
 e4-20020a67eb84000000b004437572598bmr6648863vso.13.1689186353314; Wed, 12 Jul
 2023 11:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLizjBp_8ceKq=RLznXdsHD-+N55RoPh_D7_Mpkg7M-BwQ@mail.gmail.com>
 <877cr5yzjc.fsf@miraculix.mork.no>
In-Reply-To: <877cr5yzjc.fsf@miraculix.mork.no>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 12 Jul 2023 23:55:41 +0530
Message-ID: <CAOuPNLhUtVtrOQQ1Z_rA0NAerG5PSfA26=hoenuCtCBDvz1CJA@mail.gmail.com>
Subject: Re: MTD: Lots of mtdblock warnings on bootup logs
To:     =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel@kvack.org, ezequiel@collabora.com,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Bjorn and Miquel,

Thank you so much for your help!
Please see my reply inline.

On Wed, 12 Jul 2023 at 19:58, Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
>
> Pintu Agarwal <pintu.ping@gmail.com> writes:
>
> > Kernel: 5.15 ; arm64 ; NAND + ubi + squashfs
> > We have some RAW partitions and one UBI partition (with ubifs/squashfs =
volumes).
> >
> > We are seeing large numbers of these logs on the serial console that
> > impact the boot time.
> > [....]
> > [    9.667240][    T9] Creating 58 MTD partitions on "1c98000.nand":
> > [....]
> > [   39.975707][  T519] mtdblock: MTD device 'uefi_a' is NAND, please
> > consider using UBI block devices instead.
> > [   39.975707][  T519] mtdblock: MTD device 'uefi_b' is NAND, please
> > consider using UBI block devices instead.
> > [....]
> >
> > This was added as part of this commit:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/drivers/mtd/mtdblock.c?h=3Dv5.15.120&id=3Df41c9418c5898c01634675150696da29=
0fb86796
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/drivers/mtd/mtdblock.c?h=3Dv5.15.120&id=3De07403a8c6be01857ff75060b2df9a1a=
a8320fe5
>
> You have 5.15.what exactly?  commit f41c9418c5898 was added in v5.15.46.
> Your log looks like it is missing.
>
My exact Kernel version is: 5.15.78
And I see that the below commit is also present:
commit f41c9418c5898c01634675150696da290fb86796
mtdblock: warn if opened on NAND

> FWIW, commit f41c9418c5898 was supposed to fix exactly that problem with
> commit e07403a8c6be01.
>
> But to catch actual mounts it will still warn if the mtdblock device is
> opened.  This can obviously cause false positives if you e.g have some
> script reading from the mtdblock devices.  If you are running v5.15.46 or
> later then there *is* something accessing those devices. You'll have to
> figure out what it is and stop it to avoid the warning.
>
You mean, if someone is using "mount .. /dev/mtdblock*" then only we
get these warnings ?
Or, if someone is trying to access the node using open("/dev/mtdblock*") .

But in this case, there should be only 1,2,3 entries but here I am
seeing for all the NAND partitions.
Or, is it possible that systemd-udevd is trying to access these nodes ?

Can we use ubiblock for mount ubifs (rw) volumes, or here we have to
use mtdblock ?
We have a mixture of squashfs (ro) and ubifs (rw) ubi volumes.
Currently, we are using the ubiblock way of mounting for squashfs but
mtdblock mounting for ubifs.

>> CONFIG_MTD_BLOCK=3Dy
>> CONFIG_MTD_UBI_BLOCK=3Dy
>>
> If you don't need both, then yes.

We actually need both of them because of several dependencies.

There are few applications that are trying to read content from /proc/mtd.
Is this also a problem if we disable MTD_BLOCK ?


Thanks,
Pintu
