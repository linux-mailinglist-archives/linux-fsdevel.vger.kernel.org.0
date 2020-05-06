Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7151C7C5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 23:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgEFVYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 17:24:14 -0400
Received: from smtp-33.italiaonline.it ([213.209.10.33]:44145 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728878AbgEFVYN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 17:24:13 -0400
Received: from venice.bhome ([94.37.193.252])
        by smtp-33.iol.local with ESMTPA
        id WRWUjnoahrZwsWRWUjruNU; Wed, 06 May 2020 23:24:11 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1588800251; bh=Rr2oEU9tu5OaKqs6OtlRMglgb9Avr/qHZB3V7YunWjE=;
        h=From;
        b=ccs66kgdFN8xKVl00MTQK7Cs1miLkmo/GVXFqjK43pkIM4WkZxrfAEdczGvxC8rOs
         Bd6/OxfiK8tPJBWP/Nl4bgmjv49mMkTgP8mg/ccj7f9Gz/GPWFEPfnxte7cxWCs317
         qgPRx/Ngwmb4OQLoewjX6MKXAKaSQFUTgjZqwiHLX3RUM68n3JIe+wdsI4KUcxjgo5
         iZQ+ESqoGxOknoo2UT5xSeqHJBBmOwIvKEY/KlXnEYoOXZGp/my+51p67FpILuwB7r
         x+68M6kQo8t9eezjEmOt5VMgSxb0pSu/6/sRP+tMz6836UrU/iKVQhZ1RDWZN0k+0L
         zqE6Z/J+Ud15A==
X-CNFS-Analysis: v=2.3 cv=ANbu9Azk c=1 sm=1 tr=0
 a=m9MdMCwkAncLgtUozvdZtQ==:117 a=m9MdMCwkAncLgtUozvdZtQ==:17
 a=IkcTkHD0fZMA:10 a=DsloTXpuAAAA:20 a=qTpr3AHhMGleqoAtVKkA:9
 a=QEXdDO2ut3YA:10 a=CtvLCtAli4LrSFkZZ_cB:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
To:     Jeff Mahoney <jeffm@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        david <david@sigma-star.at>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <164471725.184338.1588629556400.JavaMail.zimbra@nod.at>
 <SN4PR0401MB3598DDEF9BF9BACA71A1041D9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <bc2811dd-8d1e-f2ff-7a9b-326fe4270b96@suse.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <fb18c698-5e47-1e1a-4977-b3b6ed7c0e7f@libero.it>
Date:   Wed, 6 May 2020 23:24:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bc2811dd-8d1e-f2ff-7a9b-326fe4270b96@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB6yrYXHlXpIBjo7sxrpHbhO5DTCWgVdvubq4uIgFjr+HwhlZaviLrWMmhtMslEo5V1GeJ2bp2k0qr6p6PnT4sv7FU0xDgQX/fqMxY/iW5M51CC7ANme
 +No2wcfKGVX7jXnWqXwHbU2TQupKvdVZ1p10pjYBxt/o7/pUxLDuwB+g4kXUF37dCvhS+Z3DFcGoafP/HZWM+GW3hkksTxkBnoraVEIlfueGRcNuWXbUgmP8
 HuFumSYTMWidgMsSeHYsyr+wajrPSLrk63zJjQ6oNk4GflwRShIWzGCjKhc+VzSw/C6Vi9wa2lGJEUe+14Onml4j0g6fGJsdr+/oZwXc4rnw5Ih/1YTCSKkU
 cBeO4wk4narW8PgTwNFZaM0qQ5WanEZIuhfIze6vzrdajYg4k6HkM7EWTmZkEWKsn3V+Zr2KGHhUqpWjJWJgeYbm7iP7gYrqOM2wfHg3qhJT4MLphRop/Xw5
 U5N647KWPhEs02U5
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/5/20 2:36 PM, Jeff Mahoney wrote:
> On 5/5/20 3:55 AM, Johannes Thumshirn wrote:
>> On 04/05/2020 23:59, Richard Weinberger wrote:
>>> Eric already raised doubts, let me ask more directly.
>>> Does the checksum tree really cover all moving parts of BTRFS?
>>>
>>> I'm a little surprised how small your patch is.
>>> Getting all this done for UBIFS was not easy and given that UBIFS is truly
>>> copy-on-write it was still less work than it would be for other filesystems.
>>>
>>> If I understand the checksum tree correctly, the main purpose is protecting
>>> you from flipping bits.
>>> An attacker will perform much more sophisticated attacks.
>>
>> [ Adding Jeff with whom I did the design work ]
>>
>> The checksum tree only covers the file-system payload. But combined with
>> the checksum field, which is the start of every on-disk structure, we
>> have all parts of the filesystem checksummed.
> 
> That the checksums were originally intended for bitflip protection isn't
> really relevant.  Using a different algorithm doesn't change the
> fundamentals and the disk format was designed to use larger checksums
> than crc32c.  The checksum tree covers file data.  The contextual
> information is in the metadata describing the disk blocks and all the
> metadata blocks have internal checksums that would also be
> authenticated.  


> The only weak spot is that there has been a historical
> race where a user submits a write using direct i/o and modifies the data
> while in flight.  This will cause CRC failures already and that would
> still happen with this.
I faced this issue few years ago.
However it would be sufficient to disable DIRECT IO for a DATASUM file.
And I think that this should be done even for a "non authenticate" filesystem.
Allow the users to use a feature that can cause a bad crc to me doesn't seems a good idea.

BTW it seems that ZFS ignore O_DIRECT

https://github.com/openzfs/zfs/issues/224


> 
> All that said, the biggest weak spot I see in the design was mentioned
> on LWN: We require the key to mount the file system at all and there's
> no way to have a read-only but still verifiable file system.  That's
> worth examining further.
> 
> -Jeff
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
