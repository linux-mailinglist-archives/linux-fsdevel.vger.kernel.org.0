Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E0E6478A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfGJNur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 09:50:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52511 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJNuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:50:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so2411845wms.2;
        Wed, 10 Jul 2019 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fabHZPAYJZma6uZryzQKLNaNjNwU8sofqj/+wik4T2k=;
        b=NqkXfKOLIq7U4KThby4Itc6DV+yYyHJdxfNkJDr9pC3ssR20yR+jWUDuMxrM6CPhA5
         WMVkRi9uQm07tiiEpBrv9AQ7fx29bBTw139/n+sIq2vV+mM/62pp7DpMA2aRmyPN8LaY
         WOz/WO3vkcJlR3+OeCKQkV7LcLOnhx5/O7xN1XQkR7R3aIYuSkKIxEmoHZ2fgVuARyxs
         RXHlJMPhQNJRtscO32XtKpueRmpxKX9NdLIICkyxuEwrsk0wZ9k26xoVFQ2kFaF/ufXa
         6A6nCLrpPRa6UqwapHmeSUV83Di1xSC8X6FTo0/0tU1tyQa1BmjrfthmfwqAJSVp3tnl
         U2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fabHZPAYJZma6uZryzQKLNaNjNwU8sofqj/+wik4T2k=;
        b=ibs+u44abRPaYzHLfe/4VNcIMgs/wtnhUQwbXp9RxdbFgeBktfaCIzIiiDO1BgrCN9
         gs9Lp2SfmzzzghT6IBBe0W1vO5mLX/FAignPisrqD/jmLZGN+y/km/EQq9EtYvnA2PhK
         OquydebkyYEVqElz3jT95xfWuKn0B9GjtIZL2bl5TStJvBNPE+mOrTbiLE+4uDohu+Tf
         YsgSOHPeGHd68gnGRJQo4VaJvNX0mAOsTGr5bjganY91pEBoJcGi77zy/mmW66Ogy9rK
         i+v1JT+QJIgFNLqCUbyneba9MMxfPr0fHYYkSSgJPZqxNh7BjzwqeuBxotO5ZSF/Hlwd
         4QTA==
X-Gm-Message-State: APjAAAUWX8JalFFNIwdACIkDSa1z2DsRsBgsV8Rn6Au08YLtXZfk9kc9
        gvjJOSCCaz3nW7cK9Bbg07s=
X-Google-Smtp-Source: APXvYqx//KKGXi4rYljlu6Pvc/VnAMSzbQROUXgKVYP9kg/dejzjiZZIg4eM8GL2pSqYVrzPbbugXg==
X-Received: by 2002:a1c:238e:: with SMTP id j136mr5443337wmj.144.1562766644432;
        Wed, 10 Jul 2019 06:50:44 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id j10sm3406009wrd.26.2019.07.10.06.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 06:50:43 -0700 (PDT)
Date:   Wed, 10 Jul 2019 15:50:42 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.cz>,
        =?utf-8?Q?Vojt=C4=9Bch?= Vladyka <vojtech.vladyka@foxyco.cz>,
        linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] udf: 2.01 interoperability issues with Windows 10
Message-ID: <20190710135042.cfvx465cedie36sh@pali>
References: <96e1ea00-ac12-015d-5c54-80a83f08b898@digidescorp.com>
 <20190709185638.pcgdbdqoqgur6id3@pali>
 <958ea915-3568-8f5a-581c-e5f0a673d30f@digidescorp.com>
 <20190709210457.kzjnigu6fwgxxq27@pali>
 <2994ee3a-9e38-0ed0-652a-e85de704f8d1@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2994ee3a-9e38-0ed0-652a-e85de704f8d1@digidescorp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 10 July 2019 08:24:09 Steve Magnani wrote:
> 
> On 7/9/19 4:04 PM, Pali Rohár wrote:
> > On Tuesday 09 July 2019 15:14:38 Steve Magnani wrote:
> > > On 7/9/19 1:56 PM, Pali Rohár wrote:
> > > > Can grub2 recognize such disks?
> > > I'm not sure what you're asking here. The physical interface to this drive is USB,
> > It is USB mass storage device? If yes, then grub2 should be able to
> > normally use. Read its content, etc... You can use "ls" grub command to
> > list content of disk with supported filesystem.
> 
> Yes, Mass Storage Bulk-Only Transport.
> 
> > 
> > > and it's not designed for general-purpose storage (or booting). That said, if you
> > > have some grub2 commands you want me to run against this drive/partition let me know.
> > There is also some way for using grub's fs implementation to read disk
> > images. It is primary used by grub's automated tests. I do not know
> > right now how to use, I need to look grub documentation. But I have
> > already used it during implementation of UDF UUID in grub.
> 
> Grub is not recognizing my USB drive, i.e. 'ls' does not show usb0 as an option.
> I tried 'insmod usb' but that made no difference. Maybe grub does not support my
> USB 3.0 host controller, I will retry on a USB2 port when I have a chance.

In some cases, BIOS/UEFI firmware supports USB mass storage devices and
then grub see them... So it depends on how grub access to disk. Pre-boot
environment is always fragile...

> > > > Also can you check if libparted from git master branch can recognize
> > > > such disk? In following commit I added support for recognizing UDF
> > > > filesystem in libparted, it is only in git master branch, not released:
> > > > 
> > > > http://git.savannah.gnu.org/cgit/parted.git/commit/?id=8740cfcff3ea839dd6dc8650dec0a466e9870625
> > > Build failed:
> > >    In file included from pt-tools.c:114:0:
> > >    pt-tools.c: In function 'pt_limit_lookup':
> > >    pt-limit.gperf:78:1: error: function might be candidate for attribute 'pure' [-Werror=suggest-attribute=pure]
> > > 
> > > If you send me some other SHA to try I can attempt a rebuild.
> > Try to use top of master branch. That mentioned commit is already in git
> > master.
> > 
> > And if it still produce that error, compile without -Werror flag (or add
> > -Wno-error).
> 
> I had to configure with CFLAGS=-Wno-error.
> 
> It does not recognize Windows-formatted 4K-sector media:
>   Disk /dev/sdb: 17.6TB
>   Sector size (logical/physical): 4096B/4096B
>   Partition Table: msdos
>   Disk Flags:
> 
>   Number  Start   End     Size    Type     File system  Flags
>    1      1049kB  17.6TB  17.6TB  primary
> 

Ok, so it means that GUI/TUI tools based on libparted would have
problems with these disks too.

So ISSUE 1 is big problem for Linux.

> It does recognize mkudffs-formatted media.

That is expected.

> > 
> > > > ISSUE 2: Inability of Windows chkdsk to analyze 4K-sector media
> > > >            formatted by mkudffs.
> > > > This is really bad :-(
> > > > 
> > > > > It would be possible to work around this by tweaking mkudffs to
> > > > > insert dummy BOOT2 components in between the BEA/NSR/TEA:
> > > > > 
> > > > >     0000: 00 42 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .BEA01..........
> > > > >     0800: 00 42 4f 4f 54 32 01 00 00 00 00 00 00 00 00 00  .BOOT2..........
> > > > >     1000: 00 4e 53 52 30 33 01 00 00 00 00 00 00 00 00 00  .NSR03..........
> > > > >     1800: 00 42 4f 4f 54 32 01 00 00 00 00 00 00 00 00 00  .BOOT2..........
> > > > >     2000: 00 54 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .TEA01..........
> > > > > 
> > > > > That would introduce a slight ECMA-167 nonconformity, but Linux
> > > > > does not object and Windows actually performs better. I would
> > > > > have to tweak udffsck though since I believe this could confuse
> > > > > its automatic detection of medium block size.
> > > > I would like to avoid this hack. If chkdsk is unable to detect such
> > > > filesystem, it is really a good idea to let it do try doing filesystem
> > > > checks and recovery? You are saying that udfs.sys can recognize such
> > > > disk and mount it. I think this should be enough.
> > > Fair enough, but it's also reasonable to assume the bugginess is
> > > limited to the VRS corner case. AFAIK that's the only place in ECMA-167
> > > where there is a difference in layout specific to 4K sectors.
> > > With the BOOT2 band-aid chkdsk is able to analyze filesystems on 4Kn media.
> > Main problem with this hack is that it breaks detection of valid UDF
> > filesystems which use VRS for block size detection. I do not know which
> > implementation may use VRS for block size detection, but I do not see
> > anything wrong in this approach.
> 
> I went through this with udffsck. The VRS is not very helpful in
> determining block size because the only time the block size can be
> determined conclusively is when the interval between VRS components
> is > 2048 bytes. With an interval of 2048 bytes, the only conclusion
> that can be drawn is that blocks are no larger than 2048 bytes.

Yes, I know. But for >2048 block sizes it can be used and is allowed by
specification.

> > > I use chkdsk frequently to double-check UDF generation firmware
> > Vojtěch wrote in his thesis that MS's chkdsk sometimes put UDF
> > filesystem into more broken state as before.
> 
> Yes, I have personally experienced this. I don't have chkdsk do
> repairs any more. In my case the problem may be that chkdsk
> poorly handles the cascading corruption that resulted from this:
> 
>     https://lkml.org/lkml/2019/2/8/740
> 
> > > I am writing, and also udffsck work-in-progress.
> > Have you used some Vojtěch's parts? Or are you writing it from scratch?
> > 
> A udffsck discussion should probably continue in another thread.
> Here let me just say that I have been enhancing Vojtěch's code,
> in this fork:
> 
>   https://github.com/smagnani/udftools
> 
> ...as time permits. Since winter ended the time I have available
> for this has plummeted, so progress is very slow. But this recent
> kernel driver patch grew out of work to make sure that udffsck
> handles the UDF "file tail" properly:
> 
>   https://lkml.org/lkml/2019/6/4/551
>   https://lkml.org/lkml/2019/6/30/181

Great, thank you for update.

-- 
Pali Rohár
pali.rohar@gmail.com
