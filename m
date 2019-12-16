Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B312F11FF8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 09:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfLPITK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 03:19:10 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:53031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfLPITJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:19:09 -0500
Received: from [192.168.1.155] ([77.2.44.177]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MdwRi-1i63OV2Z8Q-00b1UM; Mon, 16 Dec 2019 09:18:53 +0100
Subject: Re: [PATCH 0/2] New zonefs file system
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <29fb138e-e9e5-5905-5422-4454c956e685@metux.net>
Date:   Mon, 16 Dec 2019 09:18:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191212183816.102402-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tidq86cq2DrC1PaZAL2dKYJ8Xq6L/BNZALT0S0rGhHF9IHdklv6
 QxOC+tG0GGdRnDgug5OwTkqgahcCry64UVr6OT9eFfI6P66f3GmZDaaPWbn89dKmnyWUOZo
 /y1fU3Bs8t5MhU6qhWGVdM0SmkuMuM7SMXDWgweXBm5gBUDxo+G9oOt3Z/bTP4FyQfN2Z40
 ThdV/1wLYtycKHyr6Yr7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:muUEbKg+/lA=:DVZVDvOZRrXWYtgG8RfWi0
 s7YWyjYaVPCML/RwUaWXCy2SMQ9xiKk3oMoPaBbicEfDKJrU/pKNESYnsUDyGwHBEcjhfTVKs
 kL8um95dhaYin3gncmQkwOfu14gWZpDX9ywW7KQ/V/SgfaAjnDa5OMhyKeV/VmdKlo/lfCN8I
 awC+pqryEm6balHN8hIYQY9N6B9+ul140bY3K2cidO6X1KRg/rZ4B57KKzkCV+7q+AMO4ZC4x
 5yrjDt6tNrGzmYtSbVBVGoVXO4jejCSCYbc7AIW/baoKeZu5yhUUc0mnAN4BdlprXciIihKKm
 Xt6UoD89rDKLDkqK599Zu9MoWXPU2nOjmKrIy3oqJjjrOUYuq/IlMLWzxutXjyF74NC9C0UPs
 D/aejmBaDmFv0/LsWg1yp/shoVu6+vrXiB+fEUtIGdU1l0j7iH3rlpOEq/Xdaiz7NIWRAUCbj
 2fbEpHE5RG0jkZjf9It7FmFsCDeHXVAq0pd5k/5eypylShLvhZWiJPlncNnUQ6PO6fP2kEs6r
 1j04zgnnhi4yuwEGHcalIK5uOG5CQOvVivcCUsFL32D0hUiWGFJmPIrnbgRkq6S5NyNNU/aPs
 QNRE2fdfewU2vXVs42RRprDcrmTFx61CbdouTE9xKwIIV6Ryxfwt/OfU04IupvlO84MGOSwcH
 FZpGeva+pmKZxPCwN+gfcElxW5aK/g1DNikdMn/6paO/9zdHfxZbkhIF42bbo9AvMvAq0wN01
 Ju6PHROyJZb9Z5aw2GYSr1ApqURGZhUhdI83O+7duTs10Lh6zuAf8PZttKzrSufws/BtqnPoF
 3Wf2uwNJnijgHUNIPnHENjQXqGutxJXNGJ6ypfjB9JBT0I1xnbkR1b+CvRS5SmfYV/ybkk7/0
 TSkZiM6jyyD5oR09dR/A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.12.19 19:38, Damien Le Moal wrote:

Hi,

> zonefs is a very simple file system exposing each zone of a zoned block
> device as a file. Unlike a regular file system with zoned block device
> support (e.g. f2fs or the on-going btrfs effort), zonefs does not hide
> the sequential write constraint of zoned block devices to the user.

Just curious: what's the exact definition of "zoned" here ?
Something like partitions ?

Can these files then also serve as block devices for other filesystems ?
Just a funny idea: could we handle partitions by a file system ?

Even more funny idea: give file systems block device ops, so they can
be directly used as such (w/o explicitly using loopdev) ;-)

> Files representing sequential write zones of the device must be written
> sequentially starting from the end of the file (append only writes).

So, these files can only be accessed like a tape ?

Assuming you're working ontop of standard block devices anyways (instead
of tape-like media ;-)) - why introducing such a limitation ?

> zonefs is not a POSIX compliant file system. It's goal is to simplify
> the implementation of zoned block devices support in applications by
> replacing raw block device file accesses with a richer file based API,
> avoiding relying on direct block device file ioctls which may
> be more obscure to developers. 

ioctls ?

Last time I checked, block devices could be easily accessed via plain
file ops (read, write, seek, ...). You can basically treat them just
like big files of fixed size.

> One example of this approach is the
> implementation of LSM (log-structured merge) tree structures (such as
> used in RocksDB and LevelDB)

The same LevelDB as used eg. in Chrome browser, which destroys itself
every time a little temporary problem (eg. disk full) occours ?
If that's the usecase I'd rather use an simple in-memory table instead
and and enough swap, as leveldb isn't reliable enough for persistent
data anyways :p

> on zoned block devices by allowing SSTables
> to be stored in a zone file similarly to a regular file system rather
> than as a range of sectors of a zoned device. The introduction of the
> higher level construct "one file is one zone" can help reducing the
> amount of changes needed in the application while at the same time
> allowing the use of zoned block devices with various programming
> languages other than C.

Why not just simply use files on a suited filesystem (w/ low block io
overhead) or LVM volumes ?


--mtx

-- 
Dringender Hinweis: aufgrund existenzieller Bedrohung durch "Emotet"
sollten Sie *niemals* MS-Office-Dokumente via E-Mail annehmen/öffenen,
selbst wenn diese von vermeintlich vertrauenswürdigen Absendern zu
stammen scheinen. Andernfalls droht Totalschaden.
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
