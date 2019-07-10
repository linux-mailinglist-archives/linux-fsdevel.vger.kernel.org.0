Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE10646E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 15:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfGJNYN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 09:24:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38897 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJNYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:24:12 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so4655655ioa.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=x+gc9GZtHp422tQIfawx4zs0fYbybr4yBJpSkctzV1g=;
        b=c6tGrN626dGm/p0X1AMQX4LFqgrGjf6QtN8qn97tfRy7GPaqeRdrMoklTq9N5WmLP6
         AAz8gk6grD/OfwWPobVsSJ1t1AjzBi9/7sllazpEyFMqIJRjA+/ZUFMHxYgYR2Eu+7Pr
         QJYWMYxCXP3f9yiaBoX9RaG75pJDXbh9qAD5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=x+gc9GZtHp422tQIfawx4zs0fYbybr4yBJpSkctzV1g=;
        b=YZmlTA7Zcj1/ebHSxXO+vA20eVhu7WE+rhW4OegiudfcL2P97xu3Xn3PeUOQ2F4yz2
         vP3ioyo17e6WrUWUrHzLP/7/qj9vgLkU92seO09f0lLNwhIl1RkjInI4G0DrPRfoz42e
         Ci0IaViEYH7laXdc8k3DBoI5ZDX9lFvB1K4D9HWQU6YnXAxuqITkEIqkm3bGR6cmBnkI
         4qr7WCudiZvAD7B4BDhzQYwg7WPKsVlfTA+dlYC6mpbumD05zFYWolsb8TWnA+Ns37iF
         fah5tIlN9Hrtoif1TKurYoz3Oxy7s4WbmZzf4YTdwpkeCFx4SFiiI8/Z+0TcSjRyKNFC
         tjXw==
X-Gm-Message-State: APjAAAWg/1yxFYaObEkR0SOqVm5uxX1N93JpUBA2SIvYdSmisRezZPAZ
        hwvMjXRh0BSdsYsfHQ3if1MHcIRKih4=
X-Google-Smtp-Source: APXvYqy6nQtQZbt8QJGAfncQMWkzH2hLSafcXQ2x1/OpTWyK8iMthcfk3vX0PcoXz6pINEBJCmo19Q==
X-Received: by 2002:a02:ce37:: with SMTP id v23mr34346376jar.2.1562765050853;
        Wed, 10 Jul 2019 06:24:10 -0700 (PDT)
Received: from [10.10.7.141] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id j14sm1700858ioa.78.2019.07.10.06.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 06:24:10 -0700 (PDT)
From:   Steve Magnani <steve.magnani@digidescorp.com>
Subject: Re: [RFC] udf: 2.01 interoperability issues with Windows 10
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        =?UTF-8?Q?Vojt=c4=9bch_Vladyka?= <vojtech.vladyka@foxyco.cz>,
        linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <96e1ea00-ac12-015d-5c54-80a83f08b898@digidescorp.com>
 <20190709185638.pcgdbdqoqgur6id3@pali>
 <958ea915-3568-8f5a-581c-e5f0a673d30f@digidescorp.com>
 <20190709210457.kzjnigu6fwgxxq27@pali>
Message-ID: <2994ee3a-9e38-0ed0-652a-e85de704f8d1@digidescorp.com>
Date:   Wed, 10 Jul 2019 08:24:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709210457.kzjnigu6fwgxxq27@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/9/19 4:04 PM, Pali Rohár wrote:
> On Tuesday 09 July 2019 15:14:38 Steve Magnani wrote:
>> On 7/9/19 1:56 PM, Pali Rohár wrote:
>>> Can grub2 recognize such disks?
>> I'm not sure what you're asking here. The physical interface to this drive is USB,
> It is USB mass storage device? If yes, then grub2 should be able to
> normally use. Read its content, etc... You can use "ls" grub command to
> list content of disk with supported filesystem.

Yes, Mass Storage Bulk-Only Transport.

>
>> and it's not designed for general-purpose storage (or booting). That said, if you
>> have some grub2 commands you want me to run against this drive/partition let me know.
> There is also some way for using grub's fs implementation to read disk
> images. It is primary used by grub's automated tests. I do not know
> right now how to use, I need to look grub documentation. But I have
> already used it during implementation of UDF UUID in grub.

Grub is not recognizing my USB drive, i.e. 'ls' does not show usb0 as an option.
I tried 'insmod usb' but that made no difference. Maybe grub does not support my
USB 3.0 host controller, I will retry on a USB2 port when I have a chance.

>>> Also can you check if libparted from git master branch can recognize
>>> such disk? In following commit I added support for recognizing UDF
>>> filesystem in libparted, it is only in git master branch, not released:
>>>
>>> http://git.savannah.gnu.org/cgit/parted.git/commit/?id=8740cfcff3ea839dd6dc8650dec0a466e9870625
>> Build failed:
>>    In file included from pt-tools.c:114:0:
>>    pt-tools.c: In function 'pt_limit_lookup':
>>    pt-limit.gperf:78:1: error: function might be candidate for attribute 'pure' [-Werror=suggest-attribute=pure]
>>
>> If you send me some other SHA to try I can attempt a rebuild.
> Try to use top of master branch. That mentioned commit is already in git
> master.
>
> And if it still produce that error, compile without -Werror flag (or add
> -Wno-error).

I had to configure with CFLAGS=-Wno-error.

It does not recognize Windows-formatted 4K-sector media:
   Disk /dev/sdb: 17.6TB
   Sector size (logical/physical): 4096B/4096B
   Partition Table: msdos
   Disk Flags:

   Number  Start   End     Size    Type     File system  Flags
    1      1049kB  17.6TB  17.6TB  primary


It does recognize mkudffs-formatted media.

>
>>> ISSUE 2: Inability of Windows chkdsk to analyze 4K-sector media
>>>            formatted by mkudffs.
>>> This is really bad :-(
>>>
>>>> It would be possible to work around this by tweaking mkudffs to
>>>> insert dummy BOOT2 components in between the BEA/NSR/TEA:
>>>>
>>>>     0000: 00 42 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .BEA01..........
>>>>     0800: 00 42 4f 4f 54 32 01 00 00 00 00 00 00 00 00 00  .BOOT2..........
>>>>     1000: 00 4e 53 52 30 33 01 00 00 00 00 00 00 00 00 00  .NSR03..........
>>>>     1800: 00 42 4f 4f 54 32 01 00 00 00 00 00 00 00 00 00  .BOOT2..........
>>>>     2000: 00 54 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .TEA01..........
>>>>
>>>> That would introduce a slight ECMA-167 nonconformity, but Linux
>>>> does not object and Windows actually performs better. I would
>>>> have to tweak udffsck though since I believe this could confuse
>>>> its automatic detection of medium block size.
>>> I would like to avoid this hack. If chkdsk is unable to detect such
>>> filesystem, it is really a good idea to let it do try doing filesystem
>>> checks and recovery? You are saying that udfs.sys can recognize such
>>> disk and mount it. I think this should be enough.
>> Fair enough, but it's also reasonable to assume the bugginess is
>> limited to the VRS corner case. AFAIK that's the only place in ECMA-167
>> where there is a difference in layout specific to 4K sectors.
>> With the BOOT2 band-aid chkdsk is able to analyze filesystems on 4Kn media.
> Main problem with this hack is that it breaks detection of valid UDF
> filesystems which use VRS for block size detection. I do not know which
> implementation may use VRS for block size detection, but I do not see
> anything wrong in this approach.

I went through this with udffsck. The VRS is not very helpful in
determining block size because the only time the block size can be
determined conclusively is when the interval between VRS components
is > 2048 bytes. With an interval of 2048 bytes, the only conclusion
that can be drawn is that blocks are no larger than 2048 bytes.

>> I use chkdsk frequently to double-check UDF generation firmware
> Vojtěch wrote in his thesis that MS's chkdsk sometimes put UDF
> filesystem into more broken state as before.

Yes, I have personally experienced this. I don't have chkdsk do
repairs any more. In my case the problem may be that chkdsk
poorly handles the cascading corruption that resulted from this:

     https://lkml.org/lkml/2019/2/8/740

>> I am writing, and also udffsck work-in-progress.
> Have you used some Vojtěch's parts? Or are you writing it from scratch?
>
A udffsck discussion should probably continue in another thread.
Here let me just say that I have been enhancing Vojtěch's code,
in this fork:

   https://github.com/smagnani/udftools

...as time permits. Since winter ended the time I have available
for this has plummeted, so progress is very slow. But this recent
kernel driver patch grew out of work to make sure that udffsck
handles the UDF "file tail" properly:

   https://lkml.org/lkml/2019/6/4/551
   https://lkml.org/lkml/2019/6/30/181

------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com               Earthling, return my space modulator!"

  #include <standard.disclaimer>

