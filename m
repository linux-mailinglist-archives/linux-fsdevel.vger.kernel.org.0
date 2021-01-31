Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BC4309B3B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jan 2021 10:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhAaJ30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jan 2021 04:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhAaJ3P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jan 2021 04:29:15 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4DEC061574;
        Sun, 31 Jan 2021 01:28:34 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id e67so13654818ybc.12;
        Sun, 31 Jan 2021 01:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S5yV9i6jWuCebpjraSAPH2dm0s2WjtRDuSW/WMDSU4Q=;
        b=Nn+oAEcphb1SqSRAvX2eZRkwdhPnuIUpvdpIEGiLCt+cpa5+lgu0q/8cGF+MjFRf5z
         NBxrQVdbym8zfkbEEfe56N+BNoq1oTamq68fxDA4YFJDBGUEU/86AYVjymmghQ+MmmHc
         uTIGhrTKu5EebKiCHxxyyFKbHLqBCeuEQmVh+VNMaGVf5+s+bRHZoFHoShUTaUkr4VoE
         JqUYIbJBLhYNR3D0Md76w7quSEDFFljfXd5RjXEdlKQVVF2mgU8QVePrFV7b3JmfNObk
         4F0kR6j9FUutfkcJEmH0OR1tIIcQXMk2JyhSrQvkT8zInnHeL4m4H4VjdYt9ImoSRUQK
         AOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S5yV9i6jWuCebpjraSAPH2dm0s2WjtRDuSW/WMDSU4Q=;
        b=EMkOUYN5BOJrCfiDtBjiP6jlC6qKOKl5/BZdFUpLYMzxy/4SwiBJ42byyDPv1c87iq
         NKBOrJ0aZ+aLHRZ/QIQApl0hW19f17rjYzPyUdAK77NZ4Abf0Qh+alFbIeQH8YV5Q3T0
         dt8qfLwKh3hydJwarsQYO9Aj8DPYwjzFJga5ohq17vlbr7+7Bfs2K1dowqcwMcXBSIo2
         MDfG3iO4UezoxP8XDRfMI6bcfL1bS1KNeQghzu+ejV4UggvfXBByqZ3a2agtMdKmkJ42
         s7LGRmm8CsmFvI+ip9HsZo3JqPOyhkBdIHWrhJOKJRJ3V3SgB1KkUKAuPD3lWoOFLzk1
         ItBw==
X-Gm-Message-State: AOAM533wk2Cor4C4fDxTP/kNdEV64K3Yq39tYol0YwQsYTbHY49uNuMp
        WHiSHFRARsmmmedlZDVO96OPa7yKZRWwbtX13Mg=
X-Google-Smtp-Source: ABdhPJwP3s9Ka/9ThbCixT02PWzw4SascfKxDb+K4HJZsvfJQUw67CW7BpCe449eAyrBIUEGSodpn5HJGdb8eGtoB/g=
X-Received: by 2002:a25:aa70:: with SMTP id s103mr8097957ybi.131.1612085313120;
 Sun, 31 Jan 2021 01:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20210129171316.13160-1-aaptel@suse.com>
In-Reply-To: <20210129171316.13160-1-aaptel@suse.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Sun, 31 Jan 2021 01:28:22 -0800
Message-ID: <CANT5p=ofvpimU9Z7jwj4cPXXa1E4KkcijYrxbVKQZf5JDiR-1g@mail.gmail.com>
Subject: Re: [PATCH v1] cifs: make nested cifs mount point dentries always
 valid to deal with signaled 'df'
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>, Paulo Alcantara <pc@cjr.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm assuming that the revalidation is failing in
cifs_revalidate_dentry, because it returns -ERESTARTSYS.

Going by the documentation of d_revalidate:
> This function should return a positive value if the dentry is still
> valid, and zero or a negative error code if it isn't.

In case of error, can we try returning the rc itself (rather than 0),
and see if VFS avoids a dentry put?
Because theoretically, the call execution has failed, and the dentry
is not found to be invalid.

Regards,
Shyam

On Fri, Jan 29, 2021 at 9:16 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote=
:
>
> From: Aurelien Aptel <aaptel@suse.com>
>
> Assuming
> - //HOST/a is mounted on /mnt
> - //HOST/b is mounted on /mnt/b
>
> On a slow connection, running 'df' and killing it while it's
> processing /mnt/b can make cifs_get_inode_info() returns -ERESTARTSYS.
>
> This triggers the following chain of events:
> =3D> the dentry revalidation fail
> =3D> dentry is put and released
> =3D> superblock associated with the dentry is put
> =3D> /mnt/b is unmounted
>
> This quick fix makes cifs_d_revalidate() always succeed (mark as
> valid) on cifs dentries which are also mount points.
>
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
> ---
>
> I have managed to reproduce this bug with the following script.  It
> uses tc with netem discipline (CONFIG_NET_SCH_NETEM=3Dy) to simulate
> network delays.
>
> #!/bin/bash
>
> #
> # reproducing bsc#1177440
> #
> # nested mount point gets unmounted when process is signaled
> #
> set -e
>
> share1=3D//192.168.2.110/scratch
> share2=3D//192.168.2.110/test
> opts=3D"username=3Dadministrator,password=3Daaptel-42,vers=3D1.0,actimeo=
=3D0"
>
> cleanup() {
>     # reset delay
>     tc qdisc del dev eth0 root
>     mount|grep -q /mnt/nest/a && umount /mnt/nest/a
>     mount|grep -q /mnt/nest && umount /mnt/nest
>
>     echo 'module cifs -p' > /sys/kernel/debug/dynamic_debug/control
>     echo 'file fs/cifs/* -p' > /sys/kernel/debug/dynamic_debug/control
>     echo 0 > /proc/fs/cifs/cifsFYI
>     echo 0 > /sys/module/dns_resolver/parameters/debug
>     echo 1 > /proc/sys/kernel/printk_ratelimit
>
> }
>
> trap cleanup EXIT
>
> nbcifs() {
>     mount|grep cifs|wc -l
> }
>
> reset() {
>     echo "unmounting and reloading cifs.ko"
>     mount|grep -q /mnt/nest/a && umount /mnt/nest/a
>     mount|grep -q /mnt/nest && umount /mnt/nest
>     sleep 1
>     lsmod|grep -q cifs && ( modprobe -r cifs &> /dev/null || true )
>     lsmod|grep -q cifs || ( modprobe cifs &> /dev/null  || true )
> }
>
> mnt() {
>     dmesg --clear
>     echo 'module cifs +p' > /sys/kernel/debug/dynamic_debug/control
>     echo 'file fs/cifs/* +p' > /sys/kernel/debug/dynamic_debug/control
>     echo 1 > /proc/fs/cifs/cifsFYI
>     echo 1 > /sys/module/dns_resolver/parameters/debug
>     echo 0 > /proc/sys/kernel/printk_ratelimit
>
>     echo "mounting"
>     mkdir -p /mnt/nest
>     mount.cifs $share1 /mnt/nest -o "$opts"
>     mkdir -p /mnt/nest/a
>     mount.cifs $share2 /mnt/nest/a -o "$opts"
> }
>
> # add fake delay
> tc qdisc add dev eth0 root netem delay 300ms
>
> while :; do
>     reset
>     mnt
>     n=3D$(nbcifs)
>     echo "starting df with $n mounts"
>     df &
>     pid=3D$!
>     sleep 1.5
>     kill $pid || true
>     x=3D$(nbcifs)
>     echo "stopping with $x mounts"
>     if [ $x -lt $n ]; then
>         echo "lost mounts"
>         dmesg > kernel.log
>         exit 1
>     fi
> done
>
>
>
> fs/cifs/dir.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
> index 68900f1629bff..876ef01628538 100644
> --- a/fs/cifs/dir.c
> +++ b/fs/cifs/dir.c
> @@ -741,6 +741,10 @@ cifs_d_revalidate(struct dentry *direntry, unsigned =
int flags)
>         if (flags & LOOKUP_RCU)
>                 return -ECHILD;
>
> +       /* nested cifs mount point are always valid */
> +       if (d_mountpoint(direntry))
> +               return 1;
> +
>         if (d_really_is_positive(direntry)) {
>                 inode =3D d_inode(direntry);
>                 if ((flags & LOOKUP_REVAL) && !CIFS_CACHE_READ(CIFS_I(ino=
de)))
> --
> 2.29.2
>


--=20
Regards,
Shyam
