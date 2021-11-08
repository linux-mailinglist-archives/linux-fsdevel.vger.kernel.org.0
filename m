Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AF54481D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 15:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbhKHOd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 09:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbhKHOd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:33:56 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812FC061570;
        Mon,  8 Nov 2021 06:31:11 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m14so62605320edd.0;
        Mon, 08 Nov 2021 06:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=w24kyLgv/+tRpo8I42SDBKmopyeaJ4ePm0P/HuK8v0E=;
        b=l53/lifRs1L0mG2kiETTRBZoz7tuhX3GfAlMA83P6/EM9J/SfWiCyNxfD0vjjMjRql
         nnMiiXKVxw9GzR5vOB5day8YfYg2RUJ7Bz6oNgahsA01Y3FoBKgdFvG+mEhFJEbTwnUD
         4zixvM+wmiM9SSJ4zEqFtwRoyCqTD12Ul5q7ZV3Rf2GcxBMKe7t57/gqG5jZViiNa9FZ
         XrW/j0WrpqNw/6jTHj9yeN5JG4pELl6o4tVANMEVPlg+1Y+inYSinG0UuhtubJ85nlMW
         /7Oh5ZEWltTX/VBTo0qVamuiuee7e1Sq2P1S0sCRJQ7x28GX2MQMc9TlGuVrwI6X13xO
         YXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w24kyLgv/+tRpo8I42SDBKmopyeaJ4ePm0P/HuK8v0E=;
        b=4DOrQwtOBfMPSef9/ksbBKfYj2gIssZCzqRFZzV2PmurAN2BTp0igqKOzqlD0OrUe+
         gBP+578LYKWcYr7c44TNRuz+ZoREBEl+qm6UOI9egb5nPDAbtOXGAQgF3pwF7hpkyMLv
         XY8JKEsYvKddubWc9P8uWj1JckD1HLMLEFJoM9U8wdyzm8EpZWnyNJf4uMHpoXRQjpDK
         TDEHRpHFq1Vyzz/tx/ENKScs/JBbxzFZq3DXapGWEO9Lg3OqHh/M2BLNM3Me76tipXnt
         HyL0Yl4xxCazdxr4SvoPbPRynP0AYeWEbTeTEO75skJ63CbfMqw7TyznAwR5o0bPEliM
         cCVw==
X-Gm-Message-State: AOAM5322JHqVCoAKv829tHJgOCTKWMtC8EsHOYgsJEmCDTTi8lSuYzJu
        lnsMEqfev2obXyRde36+iKMHJ3UVDBekywrWko5x3tTLYw2mfw==
X-Google-Smtp-Source: ABdhPJy+CUCy4DtJsFc1sFIUJC3eXz9pThsGdgn6pHpEYmaxe6UL4ZDtO5HI5J/PFwCYYvEgRPLHHE+FhZK20HJ79Gw=
X-Received: by 2002:a17:906:2ad2:: with SMTP id m18mr384079eje.64.1636381865427;
 Mon, 08 Nov 2021 06:31:05 -0800 (PST)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 8 Nov 2021 20:00:54 +0530
Message-ID: <CAOuPNLinoW5Cx=xbUcT-DB4RiQkAPpe=9hsc-Rkch0LxD0mh+Q@mail.gmail.com>
Subject: Kernel-4.14: With ubuntu-18.04 building rootfs images and booting
 gives SQUASHFS error: xz decompression failed, data probably corrupt
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        dm-devel@redhat.com, Phillip Lougher <phillip@squashfs.org.uk>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
Here are few details.
* Linux Kernel: 4.14
* Processor: Qualcomm Arm32 Cortex-A7
* Storage: NAND 512MB
* Platform: Simple busybox
* Filesystem: UBIFS, Squashfs
* Build system: Linux Ubuntu 18.04 with Yocto build system
* Consists of nand raw partitions, squashfs ubi volumes.

What we are trying to do:
We are trying to boot dm-verity enabled rootfs on our system.
The images for rootfs were generated on Ubuntu 18.04 machine using
Yocto build system.

Issue:
Earlier, when we were using Ubuntu 16.04 to generate our images, the
system was booting fine even with dm-verity enabled.
Recently we switched to Ubuntu 18.04 build machine, and now with the
same changes we are seeing the below squashfs error, just after the
mount.
Note: with 18.04 also our rootfs is mounting successfully and
dm-verity is also working fine.
We only get these squashfs errors flooded in the boot logs:
{{{
....
[    5.153479] device-mapper: init: dm-0 is ready
[    5.334282] VFS: Mounted root (squashfs filesystem) readonly on device 253:0.
....
[    8.954120] SQUASHFS error: xz decompression failed, data probably corrupt
[    8.954153] SQUASHFS error: squashfs_read_data failed to read block 0x1106
[    8.970316] SQUASHFS error: Unable to read data cache entry [1106]
[    8.970349] SQUASHFS error: Unable to read page, block 1106, size 776c
[    8.980298] SQUASHFS error: Unable to read data cache entry [1106]
[    8.981911] SQUASHFS error: Unable to read page, block 1106, size 776c
[    8.988280] SQUASHFS error: Unable to read data cache entry [1106]
....
}}}

Note: For dm-verity wwe are trying to append the verity-metadata as
part of our rootfs image like this:
...
218 +    with open(verity_md_img, "rb") as input_file:
219 +        with open(sparse_img, "ab") as out_file:
220 +            for line in input_file:
221 +                out_file.write(line)
....

These changes work fine when we build it with Ubuntu 16.04.
So, we are wondering what could be the issue with Ubuntu 18.04 build ?

If there is any history about it please let us know.


Regards,
Pintu
