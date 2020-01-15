Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4172013C6DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 16:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAOPDd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 10:03:33 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:56503 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOPDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:03:33 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MKuGD-1j5pc718HN-00LDZa; Wed, 15 Jan 2020 16:03:30 +0100
Received: by mail-qk1-f170.google.com with SMTP id a203so15920536qkc.3;
        Wed, 15 Jan 2020 07:03:30 -0800 (PST)
X-Gm-Message-State: APjAAAUTH+OhoeArYDcHK6lLuou6CZD62hVTzfwWVuNwdeZA/AzpaWiL
        awcsahaZqxBCFz7EAwXhrt5aSxM8+m1dsjOp4h0=
X-Google-Smtp-Source: APXvYqyLEtTG1GZUpIw0OkGP+O+sBSsb+LojprESwrqQPyNJkIFkk2fME3gwB3pEN88Qe6ZkLxRK+sarxOTwhUNkQn0=
X-Received: by 2002:a05:620a:cef:: with SMTP id c15mr28574667qkj.352.1579100609065;
 Wed, 15 Jan 2020 07:03:29 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115082447.19520-10-namjae.jeon@samsung.com>
 <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
 <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com>
 <20200115133838.q33p5riihsinp6c4@pali> <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com>
 <20200115142428.ugsp3binf2vuiarq@pali>
In-Reply-To: <20200115142428.ugsp3binf2vuiarq@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 16:03:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0_sotmv40qHkhE5M=PwEYLuJfX+uRFZvh9iGzhv6R6vw@mail.gmail.com>
Message-ID: <CAK8P3a0_sotmv40qHkhE5M=PwEYLuJfX+uRFZvh9iGzhv6R6vw@mail.gmail.com>
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <linkinjeon@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:X3H0QcE2jFdspteJSk8fSpj1ophyqEmMuDO8cOJwQbCnkMBqGrz
 SN5FHEbNEvlkpo8rIXHQeNtXOTVLyofH4z54WOxOggNPh6PCKeCmmWt7bYCzZtmCU9hLXOB
 GTMvC+50mf8Wv9kg5RStJnvhM9wphxD9eq52Ya/cWnQ3YFHzbLFwvG3s0tVX0LofgUMgbwF
 cjFI+nGlEGXKVNZ1sQbsQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SRpCajnw3uA=:JnWYDUbp/mZ6rEppOH1diO
 /DOGJIOd55WLAahGjPJ4eXl7aotAC9JrAkbYeRYEXH4k3o4MQ1SLLMuEMToVJW21FRZk0aY+O
 Cz6W6ICqSN1bmSQTLSMn5JzZ6PG50ht8uHy4wshUvPbMAL8IxAyzk7DSP03/o8bRC5pSEbH1e
 ikkJtVsATYwSUvalD8XSZP/CkwhKChqve+FdCc9HfuqvYAxrx/dmMM34UBihu+Zyq9bF/ve/D
 fHBxjohbzPnfytzMoSiZYrglzIyzSMBx2li3AC1bA/ZhNUp4SK3DbfXF5tSGJyFX/LMBWFXWe
 vugLWNUKxo6KtHHIh7T0iLmRy66UUHFtr1IMIB/Io4ny73i9dx0qkoWtbhmDH/1vlvJffsjl5
 ZPxA6IODL8bwM1Kh52si5MLK9i3QVEEumsQGz9Bpyi43V8hQKjA7gEZHcQC+vpAoadYfZ1tr5
 ys4JbUxye1Zu+0exzI77cy3+bAWR1k1+6o82t+Zl8IIOJ4RndQLTU8jg7jj0IkcoBuCXamf6H
 AGCcyVn5/ZKhUwZ6ma9/tFvh7wk5D6XZBaTauQpyQVW/VgvwsOh41VIpvmju4ZiVqZhtmoU0M
 xl9S24cIlKcYwVgqdD1HqdbxoegnnAZF7cS5pXDhvDdN7Bi1EefLX9mHguPu8AJGQnP/oDmEP
 OvIUOQuBlykD9UxxPqamgeMjN0qhtTkXDbWrfdiinlayMkYzA1ZbWoN6+2g/R9fLzXJlquexl
 YFFziuMidoji/ZI+q90G2ZsvF7pa9Z8jT/wJgPrZW6hpfavJvDDVjyZfEAy/F6bbCtrC7h+RD
 CjsayRD0LtP+3EBmFgSLREHuPuaOl/iKGHNusYjrGM20IoeMBRHsyc92eULnHXqhLxgBlaeIi
 Dp6Km1qmJnmdJBEKduJA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 3:24 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> On Wednesday 15 January 2020 14:50:10 Arnd Bergmann wrote:
> > On Wed, Jan 15, 2020 at 2:38 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > On Wednesday 15 January 2020 22:30:59 Namjae Jeon wrote:
> > > > 2020-01-15 19:10 GMT+09:00, Arnd Bergmann <arnd@arndb.de>:
> > However, in user space, every user may set their own timezone with
> > the 'TZ' variable, and the default timezone may be different inside of a
> > container based on the contents of /etc/timezone in its root directory.
>
> So kernel timezone is shared across all containers, right?

Yes.

> > You can use it to access removable media that were written in
> > a different timezone or a partition that is shared with another OS
> > running on the same machine but with different timezone settings.
>
> So... basically all userspace <--> kernel API which works with timestamp
> do not have information about timezone right? creat(), utime() or
> utimensat() just pass timestamp without timezone information. Is this
> timestamp mean to be in UTC or in local user time zone (as specified by
> user's TZ= env variable)?

As a rule, all timekeeping in the kernel is done in terms of UTC. You can
see what the current exceptions are using

$ git grep -wl sys_tz
Documentation/filesystems/vfat.txt
arch/alpha/kernel/osf_sys.c
arch/nds32/kernel/vdso.c
arch/powerpc/kernel/time.c
arch/s390/kernel/time.c
arch/sparc/kernel/vdso.c
drivers/media/platform/vivid/vivid-rds-gen.c
drivers/media/platform/vivid/vivid-vbi-gen.c
drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
drivers/scsi/3w-9xxx.c
drivers/scsi/3w-sas.c
drivers/scsi/aacraid/commsup.c
drivers/scsi/arcmsr/arcmsr_hba.c
drivers/scsi/mvumi.c
drivers/scsi/mvumi.h
drivers/scsi/smartpqi/smartpqi_init.c
fs/affs/amigaffs.c
fs/affs/inode.c
fs/affs/super.c
fs/fat/misc.c
fs/hfs/hfs_fs.h
fs/hfs/inode.c
fs/hfs/sysdep.c
fs/hpfs/hpfs_fn.h
fs/udf/udftime.c
include/linux/time.h
kernel/debug/kdb/kdb_main.c
kernel/time/ntp.c
kernel/time/time.c
kernel/time/timekeeping.c
kernel/time/vsyscall.c
net/netfilter/nft_meta.c
net/netfilter/xt_time.c
tools/testing/selftests/x86/test_vdso.c

The vdso and kernel/time/ code are for maintaining the timezone through
settimeofday()/gettimeofday(), and the drivers should probably all be changed
to use UTC. The file systems (affs, fat, hfs, hpfs and udf) do this for
compatibility with other operating systems that store the metadata in
localtime.

       Arnd
