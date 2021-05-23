Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2544138DBF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 May 2021 18:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhEWQqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 May 2021 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhEWQqH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 May 2021 12:46:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C520CC061574;
        Sun, 23 May 2021 09:44:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lz27so37957391ejb.11;
        Sun, 23 May 2021 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAFb3erVyh9l7NbV9IVwXoe/tovaucpjdp9+mTsw0mY=;
        b=UNlC+LppBUnPJsgnPozFUrzg9ihAxdNmxtnSQo6Q0AyniKM34c5rh5mVrnIqVjIQxE
         NjCjWwrBVX5KJDhVh/WiKm48b3muANovfZoQfXnAEEynmOfQyzWIWJozeMmy+h27Lm8S
         D71HnsJHcQjEm3of8sdgSEIsUfajRmRYvFjYGOr+8cJZvLCBpSA3CAhqYYeV0WV/K7ed
         P4XqpbJocXZpzBic3+ExSV/gDE+d4hJVRPT2++yHQa1OnSD7xhia5NbSGv/hacHwWUMc
         e+qFPlhIe3NF9YJTsgIL0rNKzURW/gWP6EhQ/9NVvpQJmEZ3Ga3IPhsylPxE6ktbBOWU
         ZkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAFb3erVyh9l7NbV9IVwXoe/tovaucpjdp9+mTsw0mY=;
        b=k8FP6u2NWxXMyre1VhUKeJodONOgAycRq9Pe45/CNTo3235XNBL9jZL/DLV4KIH881
         hwsnpE9OMypaUGSP+ox96+7AHFRrz5VD/SXLapXh1jQIXHoyN5cWiqjvJ8SPwLcrxVvg
         EAMx47NGr2geHXdzMceSoQX/WgRlkaQxmkHPTOHCIhXnquY74rHEf6ne+gER2XA8dwje
         nK6zF64m7XDEbq2591QJfij+6jdiIdHdMjCteJS5wtxf1XXim1jCdIkT4Vh1wjcUH/zT
         +U249i9IQ1vGTI7m1JMm/C8RgkQpmUfWAayD/i3nHb2oKaQihRNOzBEsdxmtM6+2yVLN
         BhIQ==
X-Gm-Message-State: AOAM533hMIFP9DX+18n4VG/3uw53kgpfJWwkAOBq24+k2850IfJdjjBq
        U6UQw0fJm73OS7sIIeHFIIQDyXAB6yHfk/59IDLgcHZ/
X-Google-Smtp-Source: ABdhPJyATAZTZbl8eyO8apZqTIlULc0XOMVCun2e1vUJkIhWR0MkASvVTYla8WDJRXsEuXTtwt8NkzXo7a8rO2RlyhA=
X-Received: by 2002:a17:907:2646:: with SMTP id ar6mr18934656ejc.293.1621788278247;
 Sun, 23 May 2021 09:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjgpkBh9dnfNTdDcfk5HiL=HjjiB9o_=fjrm+0vP7Re2Q@mail.gmail.com>
 <CAOuPNLh_0Q9w96GKT-ogC0BBcEHgo=Hv3+c=JBcas2VgqDiyaw@mail.gmail.com>
 <CAOuPNLjmJ0YufFktJzjkyvdxwFTOpxVj5AW5gANAGSG=_yT=mQ@mail.gmail.com>
 <1762403920.6716767.1621029029246@webmail.123-reg.co.uk> <CAOuPNLhn90z9i6jt0-Vv4e9hjsxwYUT2Su-7SQrxy+N=HDe_xA@mail.gmail.com>
 <486335206.6969995.1621485014357@webmail.123-reg.co.uk>
In-Reply-To: <486335206.6969995.1621485014357@webmail.123-reg.co.uk>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Sun, 23 May 2021 22:14:26 +0530
Message-ID: <CAOuPNLjBsm9YLtcb4SnqLYYaHPnscYq4captvCmsR7DthiWGsQ@mail.gmail.com>
Subject: Re: [RESEND]: Kernel 4.14: UBIFS+SQUASHFS: Device fails to boot after
 flashing rootfs volume
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     open list <linux-kernel@vger.kernel.org>, sean@geanix.com,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 20 May 2021 at 10:00, Phillip Lougher <phillip@squashfs.org.uk> wrote:
>

> Then run it on your Squashfs image
>
> % unsquashfs <your image>
>
> If the image is uncorrupted, it will unpack the image into
> "squashfs-root".  If it is corrupted it will give error
> messages.
>
I have tried this and it seems with unsquashfs I am able to
successfully extract it to "squashfs-root" folder.

> I have not used the MTD subsystem for more than 13 years, and so
> this is best answered on linux-mtd.

Yes, I have already included the linux-mtd list here.
Maybe MTD folks can share their opinion as well....
That is the reason I have changed the subject as well.

> You appear to be running busybox, and this has both support for
> "dd" and the "md5sum" checksum program.
>
> So do this
>
> % dd if=<your character device> of=img bs=1 count=<image size>
>
> Where <image size> is the size of the Squashfs image reported
> by "ls -l" or "stat".  You need to get the exact byte count
> right, otherwise the resultant checksum won't be right.
>
> Then run md5sum on the extracted "img" file.
>
> % md5sum img
>
> This will produce a checksum.
>
> You can then compare that with the result of "md5sum" on your
> original Squashfs image before flashing (produced on the host
> or the target).
>
> If the checksums differ then it is corrupted.
>
I have also tried that and it seems the checksum exactly matches.
$ md5sum system.squash
d301016207cc5782d1634259a5c597f9  ./system.squash

On the device:
/data/pintu # dd if=/dev/ubi0_0 of=squash_rootfs.img bs=1K count=48476
48476+0 records in
48476+0 records out
49639424 bytes (47.3MB) copied, 26.406276 seconds, 1.8MB/s
[12001.375255] dd (2392) used greatest stack depth: 4208 bytes left

/data/pintu # md5sum squash_rootfs.img
d301016207cc5782d1634259a5c597f9  squash_rootfs.img

So, it seems there is no problem with either the original image
(unsquashfs) as well as the checksum.

Then what else could be the suspect/issue ?
If you have any further inputs please share your thoughts.

This is the kernel command line we are using:
[    0.000000] Kernel command line: ro rootwait
console=ttyMSM0,115200,n8 androidboot.hardware=qcom
msm_rtb.filter=0x237 androidboot.console=ttyMSM0
lpm_levels.sleep_disabled=1 firmware_class.path=/lib/firmware/updates
service_locator.enable=1 net.ifnames=0 rootfstype=squashfs
root=/dev/ubiblock0_0 ubi.mtd=30 ubi.block=0,0

These are few more points to be noted:
a) With squashfs we are getting below error:
[    4.603156] squashfs: SQUASHFS error: unable to read xattr id index table
[...]
[    4.980519] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(254,0)

b) With ubifs (without squashfs) we are getting below error:
[    4.712458] UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0,
name "rootfs", R/O mode
[...]
UBIFS error (ubi0:0 pid 1): ubifs_read_node: bad node type (255 but expected 9)
UBIFS error (ubi0:0 pid 1): ubifs_read_node: bad node at LEB
336:250560, LEB mapping status 1
Not a node, first 24 bytes:
00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff

c) While flashing "usrfs" volume (ubi0_1) there is no issue and device
boots successfully.

d) This issue is happening only after flashing rootfs volume (ubi0_0)
and rebooting the device.

e) We are using "uefi" and fastboot mechanism to flash the volumes.

f) Next I wanted to check the read-only UBI volume flashing mechanism
within the Kernel itself.
Is there a way to try a read-only "rootfs" (squashfs type) ubi volume
flashing mechanism from the Linux command prompt ?
Or, what are the other ways to verify UBI volume flashing in Linux ?

g) I wanted to root-cause, if there is any problem in our UBI flashing
logic, or there's something missing on the Linux/Kernel side (squashfs
or ubifs) or the way we configure the system.

Thanks,
Pintu
