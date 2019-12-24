Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE96129CB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 03:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfLXCYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 21:24:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53913 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfLXCYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:24:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id m24so1288544wmc.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2019 18:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ni8hIT/6QtQaBN0u/poXlAqh+507aFvCN6pPrZnXhE0=;
        b=cHcQDL3Xokf4xFkfIRBY0PYbIU41KsZTKHzQhtWH0HzSzhBTAULdr617ndGf1Vdsfd
         3q+OMXWsbHtPLC0x7ZyPzr0akkteVD5jdbLvFjb/Q/Kr20ccpXOCYfTA28eDaBd3iaOr
         EH9pTX4xXfWuw8EE9T42XFpjhDqzhvB5RtcyRpF2YG/HdSbIGZ00ku01frJsqCMnxE/J
         PUbmCXrdgashkiziAMUzzXU2VJO5HUwSXXsT+6rTA+lrPgk4WZB9Lh7BTJgHoZZDPYjt
         kprnpQ5dyY7cFPQfl2bvvbcdY3RNX9+6MbNF6DfyiNFEQkzbvS3GUW0mTW0FB5U/Dw9r
         06og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ni8hIT/6QtQaBN0u/poXlAqh+507aFvCN6pPrZnXhE0=;
        b=p6nWjxSLk9VNpCgc0Hr9fjt3d0Ezh001v6Yoqy2mKmtPeELttqA5Y9DggVhNEZgRCN
         4IwEL8j4WH7qYHhHfNZSoTqX/MkbXE/WtT3q1jVabYjEeloODpU09c6sQ85J3Edcksof
         PYA7vF9P6aCgvzxmln42C/HHk+j6aM3e2OLZgzHmaLhZ5AprMACMWyLwyvVV57hFcbfo
         UNJXRKcwHhOs7fuVDtguEWhsVEy+YQmRpSEqmm2o22L3qWDBKj5pjP8jaygfsHfDX8jQ
         1IspnR5icwmqxYE7em7iQnYKTn78q99Yo+2kk9G4HhOfzRGRIcBwcyssxz7U5TsrGi8i
         XClg==
X-Gm-Message-State: APjAAAWe8BA2yYWwGImvVBPFoUuCKxQFJO/EnUPPq1zdskSdNiwUNCcz
        gqpa8+mI/2tozpa/elw229HhcOgLgWCIBZlbnsYnouk4mLodDQ==
X-Google-Smtp-Source: APXvYqylXcme6uYxSfXaks9qK9bEz0O/1X2Zyi7e+SFj/kvvjcnUYxbSwi0Fbh4zui4pPdpXgUHF/CHiO9eOqmo5kBo=
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr1620194wmh.164.1577154262694;
 Mon, 23 Dec 2019 18:24:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtS_7vjBnqeDsedBQJYuE_ap+Xo6D=MXY=rOxf66oJZkrA@mail.gmail.com>
 <4eca86cf-65c3-5aba-d0fd-466d779614e6@toxicpanda.com> <20191211155553.GP3929@twin.jikos.cz>
 <20191211155931.GQ3929@twin.jikos.cz>
In-Reply-To: <20191211155931.GQ3929@twin.jikos.cz>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Mon, 23 Dec 2019 19:24:06 -0700
Message-ID: <CAJCQCtTH65e=nOxsmy-QYPqmsz9d2YciPqxUGUpdqHnXvXLY4A@mail.gmail.com>
Subject: Re: 5.5.0-0.rc1 hang, could be zstd compression related
To:     David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Applied that single line on top of 5.5.0-rc3

fs/btrfs/compression.c:449:17: error: implicit declaration of function
=E2=80=98bio_set_bev=E2=80=99; did you mean =E2=80=98bio_set_dev=E2=80=99?
[-Werror=3Dimplicit-function-declaration]

If I use bio_set_dev

...
  CC [M]  fs/btrfs/compression.o
fs/btrfs/compression.o: warning: objtool:
end_compressed_bio_read.cold()+0x11: unreachable instruction
  LD [M]  fs/btrfs/btrfs.o
  GEN     .version
...

Despite that, it seems to work, and no crash with the reproducer.

On Wed, Dec 11, 2019 at 8:59 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Dec 11, 2019 at 04:55:53PM +0100, David Sterba wrote:
> > On Wed, Dec 11, 2019 at 09:58:45AM -0500, Josef Bacik wrote:
> > > On 12/10/19 11:00 PM, Chris Murphy wrote:
> > > > Could continue to chat in one application, the desktop environment =
was
> > > > responsive, but no shells worked and I couldn't get to a tty and I
> > > > couldn't ssh into remotely. Looks like the journal has everything u=
p
> > > > until I pressed and held down the power button.
> > > >
> > > >
> > > > /dev/nvme0n1p7 on / type btrfs
> > > > (rw,noatime,seclabel,compress=3Dzstd:1,ssd,space_cache=3Dv2,subvoli=
d=3D274,subvol=3D/root)
> > > >
> > > > dmesg pretty
> > > > https://pastebin.com/pvG3ERnd
> > > >
> > > > dmesg (likely MUA stomped)
> > > > [10224.184137] flap.local kernel: perf: interrupt took too long (25=
22
> > > >> 2500), lowering kernel.perf_event_max_sample_rate to 79000
> > > > [14712.698184] flap.local kernel: perf: interrupt took too long (31=
53
> > > >> 3152), lowering kernel.perf_event_max_sample_rate to 63000
> > > > [17903.211976] flap.local kernel: Lockdown: systemd-logind:
> > > > hibernation is restricted; see man kernel_lockdown.7
> > > > [22877.667177] flap.local kernel: BUG: kernel NULL pointer
> > > > dereference, address: 00000000000006c8
> > > > [22877.667182] flap.local kernel: #PF: supervisor read access in ke=
rnel mode
> > > > [22877.667184] flap.local kernel: #PF: error_code(0x0000) - not-pre=
sent page
> > > > [22877.667187] flap.local kernel: PGD 0 P4D 0
> > > > [22877.667191] flap.local kernel: Oops: 0000 [#1] SMP PTI
> > > > [22877.667194] flap.local kernel: CPU: 2 PID: 14747 Comm: kworker/u=
8:7
> > > > Not tainted 5.5.0-0.rc1.git0.1.fc32.x86_64+debug #1
> > > > [22877.667196] flap.local kernel: Hardware name: HP HP Spectre
> > > > Notebook/81A0, BIOS F.43 04/16/2019
> > > > [22877.667226] flap.local kernel: Workqueue: btrfs-delalloc
> > > > btrfs_work_helper [btrfs]
> > > > [22877.667233] flap.local kernel: RIP:
> > > > 0010:bio_associate_blkg_from_css+0x1c/0x3b0
> > >
> > > This looks like the extent_map bdev cleanup thing that was supposed t=
o be fixed,
> > > did you send the patch without the fix for it Dave?  Thanks,
> >
> > The fix for NULL bdev was added in 429aebc0a9a063667dba21 (and tested
> > with cgroups v2) and it's in a different function than the one that
> > appears on the stacktrace.
> >
> > This seems to be another instance where the bdev is needed right after
> > the bio is created but way earlier than it's actually known for real,
> > yet still needed for the blkcg thing.
> >
> >  443         bio =3D btrfs_bio_alloc(first_byte);
> >  444         bio->bi_opf =3D REQ_OP_WRITE | write_flags;
> >  445         bio->bi_private =3D cb;
> >  446         bio->bi_end_io =3D end_compressed_bio_write;
> >  447
> >  448         if (blkcg_css) {
> >  449                 bio->bi_opf |=3D REQ_CGROUP_PUNT;
> >  450                 bio_associate_blkg_from_css(bio, blkcg_css);
> >  451         }
> >
> > Strange that it takes so long to reproduce, meaning the 'if' branch is
> > not taken often.
>
> Compile tested only:
>
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -446,6 +446,7 @@ blk_status_t btrfs_submit_compressed_write(struct ino=
de *inode, u64 start,
>         bio->bi_end_io =3D end_compressed_bio_write;
>
>         if (blkcg_css) {
> +               bio_set_bev(bio, fs_info->fs_devices->latest_bdev);
>                 bio->bi_opf |=3D REQ_CGROUP_PUNT;
>                 bio_associate_blkg_from_css(bio, blkcg_css);
>         }
>


--=20
Chris Murphy
