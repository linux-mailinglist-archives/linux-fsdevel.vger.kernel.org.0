Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A3E13C814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 16:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgAOPjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 10:39:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35662 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgAOPjs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:39:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so16196740wro.2;
        Wed, 15 Jan 2020 07:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AV6/6+Rm6sJNKou15Oy3/DL2ZvvtkxPHbPv37+QGecY=;
        b=bobbYMTAUjW66dd6WkRKU38Zt6cb01eoabtHa75nqJiqysVSRvmZ0Rwv7gz4ybMBzJ
         n+EW26W0/NMDxkCbHVtt0cYkrJYRon/O7pKunnrdfKysp4F8BFMORyfUHYo63QkwZhyw
         kqESSdWDUVrNIH/uKNRaih5Prpjt3vQi1IBhBYI7P0LMFH7hkFYPtx0ONJwHfF5+5MNO
         Zhy2rH9Hx3s+2OluecWrk3N2e+jiQu8qdztl3q7bVgUa99t8pEqP3nt3vXjqscrb/2vh
         oM7feHQmz9VFHBNEoUyrmEq3valZrmox+KlZOm8Jclx3RF/rQQS8t/RONDhHstwU8o+f
         rWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AV6/6+Rm6sJNKou15Oy3/DL2ZvvtkxPHbPv37+QGecY=;
        b=lCsu/I6VOdcAJS4r+S79Yq9bkeS9VHMk4psiBb74I9vqA0C9fYkqke74hGrSvSXXJ9
         uyPmmkUZQbK1SMtk4HEjiUKdt3d7kh81scQwiloT7gizm7JYYgq/HZxGmvgU5kY52ecr
         VVWTWuqOmlWog4ks5go9o8lSvvoQsVqZcFFKx5ERfNLaqgCvHNtXHYwmPAABdv3Sq6pz
         eWtHJ11TKZvGibw+4Sa/xx0ofQoXcLmyUu2Ik2CpzO9WwMAE5zQijdvwyKfmRR4bqBb5
         Q092oeKnSR16yOG0+EsJVUesPsoWBD1E244A90B3lzJvoB/YNg1AoLn+L3+dwOuNOJKq
         inag==
X-Gm-Message-State: APjAAAXkezSfXfrM29GR68o+FS1TUprn/dXUEeyH4LZC+91bXS+F1GU4
        56JSp7xFIfUTXYoHBhaAYVhoFUgD
X-Google-Smtp-Source: APXvYqxDiaYOyu5Yat3E63SAjQWxoEh2En5QiNXuSdXPPCwkS8rSDYfi6176LgkMuuJuqcd9D3k6xA==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr31964227wrx.153.1579102785438;
        Wed, 15 Jan 2020 07:39:45 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id e6sm26154594wru.44.2020.01.15.07.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:39:44 -0800 (PST)
Date:   Wed, 15 Jan 2020 16:39:43 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Namjae Jeon <linkinjeon@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
Message-ID: <20200115153943.qw35ya37ws6ftlnt@pali>
References: <CGME20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com>
 <20200115082447.19520-10-namjae.jeon@samsung.com>
 <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
 <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com>
 <20200115133838.q33p5riihsinp6c4@pali>
 <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com>
 <20200115142428.ugsp3binf2vuiarq@pali>
 <CAK8P3a0_sotmv40qHkhE5M=PwEYLuJfX+uRFZvh9iGzhv6R6vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0_sotmv40qHkhE5M=PwEYLuJfX+uRFZvh9iGzhv6R6vw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 15 January 2020 16:03:12 Arnd Bergmann wrote:
> On Wed, Jan 15, 2020 at 3:24 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > On Wednesday 15 January 2020 14:50:10 Arnd Bergmann wrote:
> > > On Wed, Jan 15, 2020 at 2:38 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > On Wednesday 15 January 2020 22:30:59 Namjae Jeon wrote:
> > > > > 2020-01-15 19:10 GMT+09:00, Arnd Bergmann <arnd@arndb.de>:
> > > However, in user space, every user may set their own timezone with
> > > the 'TZ' variable, and the default timezone may be different inside of a
> > > container based on the contents of /etc/timezone in its root directory.
> >
> > So kernel timezone is shared across all containers, right?
> 
> Yes.
> 
> > > You can use it to access removable media that were written in
> > > a different timezone or a partition that is shared with another OS
> > > running on the same machine but with different timezone settings.
> >
> > So... basically all userspace <--> kernel API which works with timestamp
> > do not have information about timezone right? creat(), utime() or
> > utimensat() just pass timestamp without timezone information. Is this
> > timestamp mean to be in UTC or in local user time zone (as specified by
> > user's TZ= env variable)?
> 
> As a rule, all timekeeping in the kernel is done in terms of UTC.

Ok, thanks!

> You can
> see what the current exceptions are using
> 
> $ git grep -wl sys_tz
> Documentation/filesystems/vfat.txt
> arch/alpha/kernel/osf_sys.c
> arch/nds32/kernel/vdso.c
> arch/powerpc/kernel/time.c
> arch/s390/kernel/time.c
> arch/sparc/kernel/vdso.c
> drivers/media/platform/vivid/vivid-rds-gen.c
> drivers/media/platform/vivid/vivid-vbi-gen.c
> drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> drivers/scsi/3w-9xxx.c
> drivers/scsi/3w-sas.c
> drivers/scsi/aacraid/commsup.c
> drivers/scsi/arcmsr/arcmsr_hba.c
> drivers/scsi/mvumi.c
> drivers/scsi/mvumi.h
> drivers/scsi/smartpqi/smartpqi_init.c
> fs/affs/amigaffs.c
> fs/affs/inode.c
> fs/affs/super.c
> fs/fat/misc.c
> fs/hfs/hfs_fs.h
> fs/hfs/inode.c
> fs/hfs/sysdep.c
> fs/hpfs/hpfs_fn.h
> fs/udf/udftime.c
> include/linux/time.h
> kernel/debug/kdb/kdb_main.c
> kernel/time/ntp.c
> kernel/time/time.c
> kernel/time/timekeeping.c
> kernel/time/vsyscall.c
> net/netfilter/nft_meta.c
> net/netfilter/xt_time.c
> tools/testing/selftests/x86/test_vdso.c
> 
> The vdso and kernel/time/ code are for maintaining the timezone through
> settimeofday()/gettimeofday(), and the drivers should probably all be changed
> to use UTC. The file systems (affs, fat, hfs, hpfs and udf) do this for
> compatibility with other operating systems that store the metadata in
> localtime.

Ok. But situation for exFAT is quite different. exFAT timestamp
structure contains also timezone information. Other filesystems do not
store timezone into their metadata (IIRC udf is exception and also
stores timezone). So question is in which timezone we should store to
exFAT timestamps. This is not for compatibility with legacy systems, but
because of fact that filesystem supports feature which is not common for
other filesystems.

Also, to make it more complicated exFAT supports storing timestamps also
in "unspecified" (local user) timezone, which matches other linux
filesystems.

So for storing timestamp we have options:

* Store them without timezone
* Store them in sys_tz timezone
* Store them in timezone specified in mount option
* Store them in UTC timezone

And when reading timestamp from exFAT we need to handle both:

* Timestamps without timezone
* Timestamps with timezone

So what is the best way to handle timezone/timestamps?

For me it looks sane:

When storing use: mount option timezone. When not available then use
sys_tz. And when sys_tz is not set (it is possible?), do not specify
timezone at all. Maybe there should be a mount option which says that
timestamps on exfat are stored without timezone.

When reading timestamp with timezone: Convert timestamp to timezone
specified in mount option (or fallback to sys_tz or fallback to UTC).

And when reading timestamp without timezone: Pass it as is without
conversion, ignoring all timezone mount options and sys_tz.

Arnd, what do you think about it?

-- 
Pali Rohár
pali.rohar@gmail.com
