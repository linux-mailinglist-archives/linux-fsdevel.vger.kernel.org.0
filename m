Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A68A8466
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 15:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfIDNVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 09:21:21 -0400
Received: from mail.thelounge.net ([91.118.73.15]:59163 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbfIDNVV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:21:21 -0400
Received: from srv-rhsoft.rhsoft.net  (Authenticated sender: h.reindl@thelounge.net) by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 46Nkws0PVKzXMk;
        Wed,  4 Sep 2019 15:21:17 +0200 (CEST)
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qian Cai <cai@lca.pw>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>
References: <1567523922.5576.57.camel@lca.pw>
 <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <20190903211747.GD2899@mit.edu>
 <CABeXuvoYh0mhg049+pXbMqh-eM=rw+Ui1=rDree4Yb=7H7mQRg@mail.gmail.com>
 <CAK8P3a0AcPzuGeNFMW=ymO0wH_cmgnynLGYXGjqyrQb65o6aOw@mail.gmail.com>
 <CABeXuvq0_YsyuFY509XmwFsX6tX5EVHmWGuzHnSyOEX=9X6TFg@mail.gmail.com>
 <20190904125834.GA3044@mit.edu>
From:   Reindl Harald <h.reindl@thelounge.net>
Openpgp: id=9D2B46CDBC140A36753AE4D733174D5A5892B7B8;
 url=https://arrakis-tls.thelounge.net/gpg/h.reindl_thelounge.net.pub.txt
Organization: the lounge interactive design
Message-ID: <ffa30399-00a4-e105-8f1b-a04c8d2360c7@thelounge.net>
Date:   Wed, 4 Sep 2019 15:21:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904125834.GA3044@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Am 04.09.19 um 14:58 schrieb Theodore Y. Ts'o:
> Again, the likelihood that there will be file systems that have this
> problem in 2038 is... extremely low in my judgement.  Storage media
> just doesn't last that long

in times of virtualization storage media are below the vdisk and the
file system lasts that long and even longer

in times of running RAID on your storage they last that long because you
happily replace dead disks and move you hard drives to the next computer
when the rest of the hardware is dead

> and distributions such as Red Hat and
> SuSE very strongly encourage people to reformat file systems and do
> *not* support upgrades from ext3 to ext4 by using tune2fs.  If you do
> this, their help desk will laugh at you and refuse to help you.

i would have laughed at somebody telling me in 2010 that i have to start
again from scratch instead convert all the virtual servers installed two
years ago to ext4 or in general install repeatly from scratch instead
doing all the dist-upgrades from Fedora 9 to Fedora 30 with no downtime
longer than a ordinary kernel update and reboot

and here we are, with file systems and operating systems installed in
2008 running 11 years later just fine - it's Linux not Windows
