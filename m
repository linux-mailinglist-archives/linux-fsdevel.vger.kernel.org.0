Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40815B314
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 22:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgBLVuI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 16:50:08 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:37243 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgBLVuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:50:08 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MDhpZ-1jAULx1JKB-00AoXF; Wed, 12 Feb 2020 22:50:06 +0100
Received: by mail-qv1-f50.google.com with SMTP id g6so1679427qvy.5;
        Wed, 12 Feb 2020 13:50:05 -0800 (PST)
X-Gm-Message-State: APjAAAWppP3PsilR6zdVQALksCVMQUYmSp6cQRQkGg13p2bwzhRyTjJ+
        Z3l3Z/yHY69cnTU+kEdPV9kHe1f2EVtvQSdbTJk=
X-Google-Smtp-Source: APXvYqy8/dUIT78ziPbi+m7w9c1it35QsSL0SZ9iXSbO5y/IXrIrtcYAZ9F8FLr3BxGmZME4ZZPNyKpXXH0FnHsB7eo=
X-Received: by 2002:a05:6214:524:: with SMTP id x4mr21607034qvw.4.1581544204910;
 Wed, 12 Feb 2020 13:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20200102145552.1853992-1-arnd@arndb.de> <20200102145552.1853992-14-arnd@arndb.de>
 <20200212211452.GA5726@latitude>
In-Reply-To: <20200212211452.GA5726@latitude>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Feb 2020 22:49:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0oPpMC8367sEs+9Ae=wFH30BHAq+aRDbWLyeVLuNOnEw@mail.gmail.com>
Message-ID: <CAK8P3a0oPpMC8367sEs+9Ae=wFH30BHAq+aRDbWLyeVLuNOnEw@mail.gmail.com>
Subject: Re: [PATCH v3 13/22] compat_ioctl: scsi: move ioctl handling into drivers
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?Q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Martin Wilck <mwilck@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ira Weiny <ira.weiny@intel.com>, Iustin Pop <iustin@k1024.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-block <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AMbg5Kbwp0ZgWpd+6x82VvNG+Xp6eE91XjdX6a0JmqQqHcsuLj1
 y66vqJ+WySq/xm+jYa/KXKCMH62L0//GcfVaAuVk+E23z5wpntu28PdtPvdki5HxDHS4O7S
 kyCITKBtNxjAQRBDg+C9XqvQsMEuOG7mi65XNjaf0dCqyogXpRW9uadkveWArF75zDrXA03
 1KBJcEAaYzOJ60lUhPjCQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WPDNrXRrPvQ=:w55XpvFInf2VvVPbJc796H
 lsKaQWa59drCUHCWu/cX+EdpXpA9FkYrEnbyL1h2kpH+2TeNsA4313htUsNcQIUXCR9A9N7QL
 E+EN+ph6Fd1sBV2NcVt5a7wNLqeKKI5v2tgc1kwHTWCgyVt5CBhTgP4dCeY68+4l1rSqMkI5s
 XclXxIdjrFgOlnEt5Xsq5Rjo98HQx+1S4HGsBPLodRKRMzGT8e6duVRuk/0g4Ld3jEfZkpMFW
 eUhL6FTgUGNMAvtMAJLyvrVE6X2gVfKBzZcryk/se2GzirgFIlWSvzux9Rgu/iUKcRFRjf4Hz
 qRm2wkcygz/Ui9LmL9tfQplHN16Hrydo3DqLHvSUgwNSjhEg+vvqI8xHFKoJ6UahA2bqMm3nL
 tpWlU+6wBfgBkgXYRjAG4voYVpftOaMDJtu9R+IXngL9cRLJoetWQ8ZuUagh3rWsdDB0ZQU6s
 lkIbWrkd6B3J9WHymvICUvsi3zs5diwH6oZC4P0Ltac8KFbzRnlQd9aJNfGF7rIKt+0W2x2uP
 7345rPGkIVppwCYqpst/rgVay8+BhGuq2tGJcn2QGsBGBvz4fe6u1vEu7sYqITQMaeZZ/3mK9
 Jw6dyb3oi2GGDosXxXiVS2alqlG+2qL0Jj1dqoIaoJU3wgRKan9x/S8+gDcgjcqNy+TXFTCgz
 bmnyK/jV7HkVgqkP8nLSfJMUSwVVWsbKH+ZQcRhkx70+8doTigMbR2+F3lAKCkivPMMajc9wx
 fHk3jMWO0ZyMyQ4Mf8G+hovxSu4n3/1rzOiOi07cpQfTTjHNnqGRiOWP65PgHNELfGRVS2XJp
 xBKa5ju70BRgFPCwiDOs4Zo2U+MKFEfNYYb4A2O+1ry3UwrHv4=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:15 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> On 2020 Jan 02, Arnd Bergmann wrote:

>
> Error in getting drive hardware properties
> Error in getting drive reading properties
> Error in getting drive writing properties
> __________________________________
>
> Disc mode is listed as: CD-DA
> ++ WARN: error in ioctl CDROMREADTOCHDR: Bad address
>
> cd-info: Can't get first track number. I give up.

Right, there was also a report about breaking the Fedora installer,
see https://bugzilla.redhat.com/show_bug.cgi?id=1801353

There is a preliminary patch that should fix this, I'll post a
version with more references tomorrow:
https://www.happyassassin.net/temp/0001-Replace-.ioctl-with-.compat_ioctl-in-three-appropria.patch

      Arnd
