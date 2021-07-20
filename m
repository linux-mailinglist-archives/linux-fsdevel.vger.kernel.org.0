Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072AE3CF465
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 08:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhGTFht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 01:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbhGTFhk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 01:37:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A658FC0613E1;
        Mon, 19 Jul 2021 23:18:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ca14so27129918edb.2;
        Mon, 19 Jul 2021 23:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i0kMgSuHZ4kPt4sP1uRhzPOM7Gd+u7oji/d01Xfy6CI=;
        b=JN4hdVZX4kVjpEa2ZUVU46PqVLYNHzXlDz6vh8HxpEVP4n6GlVPer5Vm0zzRm+Og7U
         znr42WF/93H00R0SFA/Qmi50tfGItf8ENCn+XUZ+BeRdtA2JQ2bPplCqJtVvkpMrWlnI
         79d8dzSKR3IwP/cbOvmjbFjrRHaTN6IbpmrkBxJYTuEJ7nstVhhJSSl1tPG4LTXtEdNV
         DeTpaKZuahpiFUsuLQOHmRJqq7gMn1vlXB7X05G6bdEpvaS0+VFTmODa8NCj2foTHHVj
         sBdBYyYZuYz1GvR1nI4P+5U5+PVPRLP0j9OZbN2OhhSDgb6K7tUcqzy4KWPg4qvnqdrr
         QcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i0kMgSuHZ4kPt4sP1uRhzPOM7Gd+u7oji/d01Xfy6CI=;
        b=sdunnJqf+pVx419Kr/gvObzUwkX0gMi8FQpANXgtN1MIM+Al5D+5RWKraS9GvAuZKI
         WkATo2Jxwlgm4hbyIR9756Wm6GnOsrnE6AvamXEDESvtSpG7NB4BP9KLrewvGZeV8gJC
         af8EgHXBaewKLDodd4ahsNQpqPxVecbymFtTVWKyur5whOp4PxugfsBMsyMIIBHac7m+
         FMeIWAHjCFOY2/WCVXzvVEULjBjspJWouSV/OuRog9ZuxigcyPKbv9tgljFXx/biZXu0
         SOYBgtBi4sCegzUHNHhxCduWWFiLAWMY99OnaZfTMuE8+JcCq+00m7foWa0CRn+LLY5i
         EVJw==
X-Gm-Message-State: AOAM532UzJu+suePz0fdeBf+SPF2bSI4mCa8vqwYKNoPea0b3u2t2CFQ
        hwSex+FHYWShwbqu8rtPWOFEuGhhJUkPwNni3E0=
X-Google-Smtp-Source: ABdhPJy6k0BPgBjkY1GjQMzqFi44EyZ3OU0v6LZ8PrYAbhFp7ALdrGWVXIkwNCfOmdT6Uhq8PtDLdGyUso1rul1NT9k=
X-Received: by 2002:a05:6402:270d:: with SMTP id y13mr39156656edd.66.1626761881202;
 Mon, 19 Jul 2021 23:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <YPGojf7hX//Wn5su@kroah.com> <568938486.33366.1626452816917.JavaMail.zimbra@nod.at>
 <CAOuPNLj1YC7gjuhyvunqnB_4JveGRyHcL9hcqKFSNKmfxVSWRA@mail.gmail.com> <1458549943.44607.1626686894648.JavaMail.zimbra@nod.at>
In-Reply-To: <1458549943.44607.1626686894648.JavaMail.zimbra@nod.at>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 20 Jul 2021 11:47:49 +0530
Message-ID: <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
To:     Richard Weinberger <richard@nod.at>
Cc:     Greg KH <greg@kroah.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 19 Jul 2021 at 14:58, Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Pintu Agarwal" <pintu.ping@gmail.com>
> > An: "richard" <richard@nod.at>
> > CC: "Greg KH" <greg@kroah.com>, "linux-kernel" <linux-kernel@vger.kerne=
l.org>, "linux-mtd"
> > <linux-mtd@lists.infradead.org>, "linux-fsdevel" <linux-fsdevel@vger.ke=
rnel.org>, "Phillip Lougher"
> > <phillip@squashfs.org.uk>, "Sean Nyekjaer" <sean@geanix.com>, "Kernelne=
wbies" <kernelnewbies@kernelnewbies.org>
> > Gesendet: Montag, 19. Juli 2021 11:09:46
> > Betreff: Re: MTD: How to get actual image size from MTD partition
>
> > On Fri, 16 Jul 2021 at 21:56, Richard Weinberger <richard@nod.at> wrote=
:
> >
> >> >> My requirement:
> >> >> To find the checksum of a real image in runtime which is flashed in=
 an
> >> >> MTD partition.
> >> >
> >> > Try using the dm-verity module for ensuring that a block device real=
ly
> >> > is properly signed before mounting it.  That's what it was designed =
for
> >> > and is independent of the block device type.
> >>
> >> MTDs are not block devices. :-)
> >>
> > Is it possible to use dm-verity with squashfs ?
> > We are using squashfs for our rootfs which is an MTD block /dev/mtdbloc=
k44
>
> Well, if you emulate a block device using mtdblock, you can use dm-verity=
 and friends.
> Also consider using ubiblock. It offers better performance and wear level=
ing support.
>
Okay thank you.
We have tried dm-verity with squashfs (for our rootfs) but we are
facing some mounting issues.
[...]
[    4.697757] device-mapper: init: adding target '0 96160 verity 1
/dev/mtdblock34 /dev/mtdblock39 4096 4096 12020 8 sha256
d7b8a7d0c01b9aec888930841313a81603a50a2a7be44631c4c813197a50d681
aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7'
[    4.704771] device-mapper: verity: sha256 using implementation
"sha256-generic"
[...]
[    4.727366] device-mapper: init: dm-0 is ready
[    4.912558] VFS: Cannot open root device "dm-0" or
unknown-block(253,0): error -5

The same works with ext4 emulation.
So, not sure if there are any changes missing w.r.t. squashfs on 4.14 kerne=
l ?

Anyways, I will create a separate thread for dm-verity issue and keep
this thread still open for UBI image size issue.
We may use dm-verify for rootfs during booting, but still we need to
perform integrity check for other nand partitions and UBI volumes.

So, instead of calculating the checksum for the entire partition, is
it possible to perform checksum only based on the image size ?
Right now, we are still exploring what are the best possible
mechanisms available for this.

Thanks,
Pintu
