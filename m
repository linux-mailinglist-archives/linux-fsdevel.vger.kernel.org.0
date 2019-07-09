Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F99E63C95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 22:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfGIUOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 16:14:41 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:41004 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbfGIUOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:14:40 -0400
Received: by mail-io1-f48.google.com with SMTP id j5so26576802ioj.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2019 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nl3mnuhlIhCXtQUWhAeoEFp/LNwVHyfN3axtB6DoSkI=;
        b=mTHdVIu11IxM2wFaRiGg84BN7fYsctJfR4WJbbWh4cUnHLBEDoctklskDG9cUBtgfs
         FQlK2zKNsg9rR9PTz+ZWW1BfyST1eVpBQyuOSyWH6pS3izob6kcgh2p+sTyFHc5kyRdX
         SEQqLKXn8Opd4EKSO86CWd7xAR7C6aeJDebhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nl3mnuhlIhCXtQUWhAeoEFp/LNwVHyfN3axtB6DoSkI=;
        b=lptz/9etc0uRxDtIM+4FRRo2fvijCJEfqsY+U87ZoFvg5q5cCUnTY5l+xAYt/26qaV
         KT+bv3iiSI0z34ePafcVodMSyVR96lXVRWBZouY1R9GBxiEn081Q52e1vrYjQIwt2ZES
         cxqZQWPZAzWldzuxeQP1idGdDabkQTcEyo3x7EXHOE9ZLtmIqIkwuy7PKJXv1S/VC8H3
         Usv8EtEpwGUJcl6SQFuVkIgfQMbiO5oVGnSgLhq28r+6VndpQMA4dj5olYN66Rw0nMmz
         Sb3B+f2HY7wAqvJUSU3Ca/rplWp6x4igFhcNtgBfDxqt8XhJIrjbZxrx10MpctY8CQFc
         2arw==
X-Gm-Message-State: APjAAAULxK5OZG49nEH9vs747hNI9YNs9GOWFwo1e4tj3s2sFU1NK3iN
        XpT5FWlPv15R47A6Tl30C2Bq/g==
X-Google-Smtp-Source: APXvYqxTU+n4n4abvAEbKz7KRYlYpv6alc4iCfNx0JoTZ1Emc9Nb4kyQTnXd4Wt0tBEx9LGSg0qztg==
X-Received: by 2002:a5d:8c84:: with SMTP id g4mr3656520ion.211.1562703279961;
        Tue, 09 Jul 2019 13:14:39 -0700 (PDT)
Received: from [10.10.7.141] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id j14sm19865534ioa.78.2019.07.09.13.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 13:14:39 -0700 (PDT)
From:   Steve Magnani <steve.magnani@digidescorp.com>
Subject: Re: [RFC] udf: 2.01 interoperability issues with Windows 10
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        =?UTF-8?Q?Vojt=c4=9bch_Vladyka?= <vojtech.vladyka@foxyco.cz>,
        linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <96e1ea00-ac12-015d-5c54-80a83f08b898@digidescorp.com>
 <20190709185638.pcgdbdqoqgur6id3@pali>
Message-ID: <958ea915-3568-8f5a-581c-e5f0a673d30f@digidescorp.com>
Date:   Tue, 9 Jul 2019 15:14:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709185638.pcgdbdqoqgur6id3@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/9/19 1:56 PM, Pali Rohár wrote:
> Steve, can you describe what you mean by Advanced Format 4K sector size?
>
> It is hard disk with 512 bytes logical sector size and 4096 bytes
> physical sector size? Or do you mean hard disk which has both logical
> and physical sector size equal to 4096 bytes?

Sorry, forgot that the term Advanced Format introduces ambiguity.
As far as the OSes are concerned the drive is 4Kn.

On Tuesday 09 July 2019 13:27:58 Steve Magnani wrote:

>> Hi,
>>
>> Recently I have been exploring Advanced Format (4K sector size)
>> and high capacity aspects of UDF 2.01 support in Linux and
>> Windows 10. I thought it might be helpful to summarize my findings.
>>
>> The good news is that I did not see any bugs in the Linux
>> ecosystem (kernel driver + mkudffs).
>>
>> The not-so-good news is that Windows has some issues that affect
>> interoperability. One of my goals in posting this is to open a
>> discussion on whether changes should be made in the Linux UDF
>> ecosystem to accommodate these quirks.
>>
>> My test setup includes the following software components:
>>
>> * mkudffs 1.3 and 2.0
> Can you do tests also with last version of mkudffs 2.1?

A very quick smoke test of a 16-ish TiB 4Kn partition seemed OK.

>> * kernel 4.15.0-43 and 4.15.0-52
>> * Windows 10 1803 17134.829
>> * chkdsk 10.0.17134.1
>> * udfs.sys 10.0.17134.648
>>
>>
>> ISSUE 1: Inability of the Linux UDF driver to mount 4K-sector
>>           media formatted by Windows.
> Can you check if udfinfo (from udftools) can recognize such disk?

It cannot:

   $ ./udfinfo /dev/sdb1
   udfinfo: Error: UDF Volume Recognition Sequence found but not Anchor Volume Descriptor Pointer, maybe wrong --blocksize?
   udfinfo: Error: Cannot process device '/dev/sdb1' as UDF disk

   $ ./udfinfo --blocksize=4096 /dev/sdb1
   udfinfo: Error: UDF Volume Recognition Sequence not found
   udfinfo: Error: Cannot process device '/dev/sdb1' as UDF disk

   $ ./udfinfo
   udfinfo from udftools 2.1

> And can blkid (from util-linux) recognize such disk as UDF with reading
> all properties?

Seemingly:

   $ blkid --info /dev/sdb1
   /dev/sdb1: MINIMUM_IO_SIZE="4096"
              PHYSICAL_SECTOR_SIZE="4096"
              LOGICAL_SECTOR_SIZE="4096"

   $ blkid --probe /dev/sdb1
   /dev/sdb1: VOLUME_ID="UDF Volume"
              UUID="0e131b3b20554446"
              VOLUME_SET_ID="0E131B3B UDF Volume Set"
              LABEL="WIN10_FORMATTED"
              LOGICAL_VOLUME_ID="WIN10_FORMATTED"
              VERSION="2.01"
              TYPE="udf"
              USAGE="filesystem"

   $ blkid --version
   blkid from util-linux 2.31.1  (libblkid 2.31.1, 19-Dec-2017)

> Can grub2 recognize such disks?

I'm not sure what you're asking here. The physical interface to this drive is USB,
and it's not designed for general-purpose storage (or booting). That said, if you
have some grub2 commands you want me to run against this drive/partition let me know.

> Also can you check if libparted from git master branch can recognize
> such disk? In following commit I added support for recognizing UDF
> filesystem in libparted, it is only in git master branch, not released:
>
> http://git.savannah.gnu.org/cgit/parted.git/commit/?id=8740cfcff3ea839dd6dc8650dec0a466e9870625

Build failed:
   In file included from pt-tools.c:114:0:
   pt-tools.c: In function 'pt_limit_lookup':
   pt-limit.gperf:78:1: error: function might be candidate for attribute 'pure' [-Werror=suggest-attribute=pure]

If you send me some other SHA to try I can attempt a rebuild.

> ISSUE 2: Inability of Windows chkdsk to analyze 4K-sector media
>           formatted by mkudffs.
> This is really bad :-(
>
>> It would be possible to work around this by tweaking mkudffs to
>> insert dummy BOOT2 components in between the BEA/NSR/TEA:
>>
>>    0000: 00 42 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .BEA01..........
>>    0800: 00 42 4f 4f 54 32 01 00 00 00 00 00 00 00 00 00  .BOOT2..........
>>    1000: 00 4e 53 52 30 33 01 00 00 00 00 00 00 00 00 00  .NSR03..........
>>    1800: 00 42 4f 4f 54 32 01 00 00 00 00 00 00 00 00 00  .BOOT2..........
>>    2000: 00 54 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .TEA01..........
>>
>> That would introduce a slight ECMA-167 nonconformity, but Linux
>> does not object and Windows actually performs better. I would
>> have to tweak udffsck though since I believe this could confuse
>> its automatic detection of medium block size.
> I would like to avoid this hack. If chkdsk is unable to detect such
> filesystem, it is really a good idea to let it do try doing filesystem
> checks and recovery? You are saying that udfs.sys can recognize such
> disk and mount it. I think this should be enough.

Fair enough, but it's also reasonable to assume the bugginess is
limited to the VRS corner case. AFAIK that's the only place in ECMA-167
where there is a difference in layout specific to 4K sectors.
With the BOOT2 band-aid chkdsk is able to analyze filesystems on 4Kn media.

I use chkdsk frequently to double-check UDF generation firmware
I am writing, and also udffsck work-in-progress.

------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>

