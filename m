Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9324E377CF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 09:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhEJHNg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 03:13:36 -0400
Received: from smtpout-fallback.aon.at ([195.3.96.119]:37237 "EHLO
        smtpout-fallback.aon.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhEJHNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 03:13:34 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 03:13:34 EDT
Received: (qmail 18896 invoked from network); 10 May 2021 07:05:49 -0000
Received: from unknown (HELO smtpout.aon.at) ([172.18.1.203])
          (envelope-sender <klammerj@a1.net>)
          by fallback43.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-fsdevel@vger.kernel.org>; 10 May 2021 07:05:49 -0000
X-A1Mail-Track-Id: 1620630349:18895:fallback43:172.18.1.203:1
Received: (qmail 6424 invoked from network); 10 May 2021 07:05:43 -0000
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        WARSBL607.highway.telekom.at
X-Spam-Level: 
X-Spam-Relay-Country: 
Received: from 100-75-90-60.rfc6598.a1.net (HELO [192.168.0.2]) ([100.75.90.60])
          (envelope-sender <klammerj@a1.net>)
          by smarthub83.res.a1.net (qmail-ldap-1.03) with SMTP
          for <linux-fsdevel@vger.kernel.org>; 10 May 2021 07:05:43 -0000
X-A1Mail-Track-Id: 1620630337:5918:smarthub83:100.75.90.60:1
Message-ID: <6098DB34.1010007@a1.net>
Date:   Mon, 10 May 2021 09:05:24 +0200
From:   Johann Klammer <klammerj@a1.net>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.5.0
MIME-Version: 1.0
To:     linux-fsdevel@vger.kernel.org
Subject: iso9660: problems mounting japanese cdrom images
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Good morning,

I had tried to mount the SP2.BIN image found in this archive.
<https://archive.org/details/SequencePalladium2>

there's also a .CUE file wot has:
FILE "SP2.BIN" BINARY
  TRACK 01 MODE1/2352
    INDEX 01 00:00:00
  TRACK 02 AUDIO
    PREGAP 00:02:00
    INDEX 01 69:29:06

I've tried the following:

mount -o loop -t iso9660 /mnt/sda1/images/SP2.BIN ./test
mount -t iso9660 -o sbsector=2352 -o loop /mnt/sda1/images/SP2.BIN ./test
mount -t iso9660 -o cruft -o sbsector=2352 -o loop /mnt/sda1/images/SP2.BIN ./test
mount -t iso9660 -o session=0 -o loop /mnt/sda1/images/SP2.BIN ./test
mount -t iso9660 -o session=1 -o loop /mnt/sda1/images/SP2.BIN ./test
mount -t iso9660 -o norock -o loop /mnt/sda1/images/SP2.BIN ./test
mount -t iso9660 -o session=1 -o norock -o loop /mnt/sda1/images/SP2.BIN ./test
mount -t iso9660 -o session=0 -o norock -o loop /mnt/sda1/images/SP2.BIN ./test
mount -t iso9660 -o nojoliet -o loop /mnt/sda1/images/SP2.BIN ./test
mount -t iso9660 -o nojoliet,norock -o loop /mnt/sda1/images/SP2.BIN ./test

dmesg has:
[208088.506869] loop: module loaded
[208088.653563] ISOFS: Unable to identify CD-ROM format.
[208095.914710] ISOFS: Unable to identify CD-ROM format.
[208119.748715] ISOFS: Unable to identify CD-ROM format.
[208347.191915] ISOFS: Unable to identify CD-ROM format.
[208493.553881] ISOFS: Unable to identify CD-ROM format.
[209441.613811] ISOFS: Invalid session number or type of track
[209441.613822] ISOFS: Invalid session number
[209441.615161] ISOFS: Unable to identify CD-ROM format.
[209446.118334] ISOFS: Invalid session number or type of track
[209446.118344] ISOFS: Invalid session number
[209446.119287] ISOFS: Unable to identify CD-ROM format.
[212424.794984] ISOFS: Unable to identify CD-ROM format.
[212435.664533] ISOFS: Invalid session number or type of track
[212435.664544] ISOFS: Invalid session number
[212435.665578] ISOFS: Unable to identify CD-ROM format.
[212439.839751] ISOFS: Invalid session number or type of track
[212439.839762] ISOFS: Invalid session number
[212439.841020] ISOFS: Unable to identify CD-ROM format.
[212478.808366] ISOFS: Unable to identify CD-ROM format.
[212485.561928] ISOFS: Unable to identify CD-ROM format.

Kernel Version is 3.14.15
What else to try?


