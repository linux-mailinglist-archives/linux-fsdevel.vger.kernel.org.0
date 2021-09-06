Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92208401E3F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 18:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbhIFQ30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 12:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243784AbhIFQ3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:29:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF8CC061575;
        Mon,  6 Sep 2021 09:28:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jg16so14493596ejc.1;
        Mon, 06 Sep 2021 09:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6oKyG7zEb/nW+FeiP30bM48MUXtoqIWfTDkbvnG8BkY=;
        b=bszZ/g+TVWRlcuLYrm4cp/AJpQzap4khelKGOFDxT37GwmFEI0nnoKH1mXocTABgEr
         kVhKcce52l+Bda2ODC/ZGHW8uZSxriuGwxC0LX48Hp8snUsmUVEXttz7mv959xm+oqyF
         bAg5uikiKTYSVezC6S3St86oKeK8d99jnXGqhATYzzcK2iRXCj37sVbgIQH+FlBFzMu7
         qfs6jGjKM5o0LL9zRHBR73Sg1ZX0fRKN9P+K9qpA/WpYOc26ou7hAj7+mogNeb7JbXOf
         qOBWnKxn3Tz5Xu3MlM0GqX3FLeEaCgGOT/oL2MxPcb3m9e093RzGm+AL2OOUcvurFelA
         a4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6oKyG7zEb/nW+FeiP30bM48MUXtoqIWfTDkbvnG8BkY=;
        b=RQF5n4tw1xWqkk4rzPzWEyh2JzDVcsAYgfmgM8t6MNtojeLof6lWYyOhKpYQIaxTCD
         oWYrTLaSaXNRTCXj6HqVSwCCnhnFv/9y8fe7OknO020aDpHQo++tF7V8ZlR6q8jFL8lw
         fxvAygjC2mBMkNEJBhzKoJaeljaVDd/Jo2hqA9LAlvYHBMICAMFXvMc2VcNdh1tu6tSh
         MNQ9rrk2BmDsC1bGrC0veODBa+9IJNKwfCwE4PRv/5aze1tVcJgRzxp7ksKnDikqfk8r
         GFC9qz7WJmFIkciqkDtU5LHkbZtGBacenrvmKnPhsByk7hPzy5BBDEjAYNR8orkjT2Co
         Y7Iw==
X-Gm-Message-State: AOAM532dOsB6y4HLGqGMzJmugq+v842Bvp7yhhoPsCFm3COX3Q8SK7rP
        d+ANKAsmiBT83fpjToaMXTftaLLSJp949tYlcoo=
X-Google-Smtp-Source: ABdhPJwyZI2iQmBxtUR38Zx7Nafy9EsJjNnIzDOyi9cAU4A8FwKXYxAZphlwRFe+JlmOEU0Qn2HcyvKeOV2DlHvWXs0=
X-Received: by 2002:a17:906:fb19:: with SMTP id lz25mr14543783ejb.162.1630945699450;
 Mon, 06 Sep 2021 09:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com>
 <alpine.LRH.2.02.2107200737510.19984@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com>
 <alpine.LRH.2.02.2107211300520.10897@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLi-xz_4P+v45CHLx00ztbSwU3_maf4tuuyso5RHyeOytg@mail.gmail.com>
 <CAOuPNLg0m-Q7Vhp4srbQrjXHsxVhOr-K2dvnNqzdR6Dr4kioqA@mail.gmail.com>
 <20210830185541.715f6a39@windsurf> <CAOuPNLhTidgLNWUbtUgdESYcKcE1C4SOdzKeQVhFGQvEoc0QEg@mail.gmail.com>
 <20210830211224.76391708@windsurf> <CAOuPNLgMd0AThhmSknbmKqp3_P8PFhBGr-jW0Mqjb6K6NchEMg@mail.gmail.com>
In-Reply-To: <CAOuPNLgMd0AThhmSknbmKqp3_P8PFhBGr-jW0Mqjb6K6NchEMg@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 6 Sep 2021 21:58:08 +0530
Message-ID: <CAOuPNLiW10-E6F_Ndte7U9NPBKa9Y_UuLhgdwAYTc0eYMk5Mqg@mail.gmail.com>
Subject: Re: Kernel 4.14: Using dm-verity with squashfs rootfs - mounting issue
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, dm-devel@redhat.com,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>, agk@redhat.com,
        snitzer@redhat.com, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Thomas, Mikulas,
Need your help in root causing my dm-verity issue with squashfs.
Please see my comments inline.

On Tue, 31 Aug 2021 at 18:49, Pintu Agarwal <pintu.ping@gmail.com> wrote:

> > No, but you can backport it easily. Back at
> > http://lists.infradead.org/pipermail/openwrt-devel/2019-November/025967.html
> > I provided backports of this feature to OpenWrt, for the 4.14 and 4.19
> > kernels.
> >
> Yes, I can backport it to our 4.14 Kernel.
> Can you share the list of patches to be backported to make it work on 4.14 ?
> If it's backported also I need to report to our internal kernel, but
> it might be slightly easier.
> Please share the details.
>

I am interested to backport dm-mod.create related patches to our 4.14 kernel.
Please let me know where can I find all the patches ?
Is it already part of mainline 4.14 ?
Please share the list of commits (from mainline) that we need to pull
and backport.

> > > Here is our kernel command line:
> > >
> > > [    0.000000] Kernel command line: ro rootwait
> > > console=ttyMSM0,115200,n8 ....  verity="95384 11923
> > > 16da5e4bbc706e5d90511d2a3dae373b5d878f9aebd522cd614a4faaace6baa3 12026
> > > " rootfstype=squashfs ubi.mtd=40,0,30 ubi.block=0,0 root=/dev/dm-0
> > > .... init=/sbin/init root=/dev/dm-0 dm="rootfs none ro,0 95384 verity
> > > 1 /dev/ubiblock0_0 /dev/mtdblock53 4096 4096 11923 8 sha256
> > > 16da5e4bbc706e5d90511d2a3dae373b5d878f9aebd522cd614a4faaace6baa3
> > > aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7 10
> > > restart_on_corruption ignore_zero_blocks use_fec_from_device
> > > /dev/mtdblock53 fec_roots 2 fec_blocks 12026 fec_start 12026" ...
> >
> > I don't see how this can work without the dm-mod.create feature. Are
> > you sure the verity= and dm= kernel arguments exist?
>
I checked a little further and yes there is "dm=" command line in
kernel available.
This is already working with ext4 glue, but was never tried with squashfs.
I think it is mainline derived from Android.
https://patchwork.kernel.org/project/dm-devel/patch/2c01b2a43a46fab760208d7af3a7af37eec8c41a.1537936397.git.helen.koike@collabora.com/
https://github.com/projectceladon/device-androidia-kernel/blob/master/init/do_mounts_dm.c

Mostly, this is the main repo where our source might be derived:
https://github.com/android-linux-stable/msm-4.14

Can we backport the patches here ?
If I get the list I can try it.

>
> Also, you mentioned:
> >>> Here, it definitely worked to append the hash tree to the squashfs
> >>> image and store them in the same partition.
> Can you share some details about it ?
> How it can be done since squashfs is readonly.
Can you share your reference, how are you appending the hash tree ?
Let me try the same.

But it seems like the underlying concept is the same for both
"dm-mod.create" and "dm=".
However, I am not sure if there are any changes required for squashfs
as block device..

Errors:
Currently, we are getting this in boot logs:

[    4.962188] device-mapper: init: attempting early device configuration.
[    4.969699] device-mapper: init: created device '253:0'
[    4.975503] device-mapper: init: adding target '0 95384 verity 1
/dev/ubiblock0_0 /dev/mtdblock53 4096 4096 11923 8 sha256
8fc2e4bb751f4b3145a486a0f4f1b58149ba3eedc2a67312f31fbee131380dab
aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7 10
restart_on_corruption ignore_zero_blocks use_fec_from_device
/dev/mtdblock53 fec_roots 2 fec_blocks 12026 fec_start 12026'
[    4.992323] device-mapper: verity: sha256 using implementation
"sha256-generic"
[    5.015568] device-mapper: init: dm-0 is ready
[   10.080065] prepare_namespace: dm_run_setup - done
[   10.080093] prepare_namespace: saved_root_name: /dev/dm-0
[   10.083903] prepare_namespace: Inside: name_to_dev_t
[   10.089605] prepare_namespace: Calling - mount_root() ...
[   10.094519] [PINTU]: mount_block_root: called with input name:
/dev/root, fs_names: squashfs
[   10.263510] [PINTU]: do_mount_root: sys_mount failed: err: -22
[   10.263544] [PINTU]: mount_block_root: do_mount_root: err: -22, p:
squashfs, flags: 32769, root_mount_data: (null)
[..]
[   10.745672] No filesystem could mount root, tried:
[   10.745676]  squashfs
[   10.748015]
[   10.755232] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(253,0)

It seems the rootfs could not mount due to invalid arguments.
Not sure which arguments are invalid here...


Thanks,
Pintu
