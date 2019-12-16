Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B503120149
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 10:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLPJgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 04:36:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39965 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726994AbfLPJgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576488964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSNyJVDQQRShHLUJMx+I06u7S4GHKJEzYoSM/fhjhl0=;
        b=KpVe2GESAxSkhqJFEkvvSCeB8C/0YkeGP3d5R3G00QXd6pO8ngnG8Wj2QIzqpLdREcgObm
        0yHrsd1Bb3UHKiuf+aIECliZ0aC+66xALbntSzHHgG4Vwr2y9NAPznatxSUyoLH+wjIlGo
        b7Qrs5nvA9KxxrqhlrF6CQd7NmeagWg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-oCm13FpMNVOE2aSkLvWf5g-1; Mon, 16 Dec 2019 04:36:03 -0500
X-MC-Unique: oCm13FpMNVOE2aSkLvWf5g-1
Received: by mail-wm1-f71.google.com with SMTP id l13so830692wmj.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 01:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=zSNyJVDQQRShHLUJMx+I06u7S4GHKJEzYoSM/fhjhl0=;
        b=pkk85HPuye4qkgiZabncXDeXZdNud6vY4PZJKCLcGfNlK8ApR2hi3Bxs81NCrYtWhg
         VMY0zSqOSNImclz/EeZ0upCamez0bP10D00zp2qVVt2oq8eIVsIlMUPJr7xOdfP6canI
         vksAanwkuYPxtl6jFSJ9LT0ftgz3cF1yURaNP3XRmyfOVkjNVO1xn+V6MDhpsdN0gJLQ
         gIw2la56YqWGjiekDhjl9pfIN1AqCKkEC1ywrdnnTDd8SRMSLRA7tqP9Wb2WDe2e/u2G
         skhmRoaP4VszvXzP0u4Avo8oVblJ4W5gSqo5onvhbLJzrrLrtVCvM6XNhQUz6QPF0+qb
         9PYg==
X-Gm-Message-State: APjAAAWXxwmw24JFp8PCsWYS8paiRNv71RJYfhIQroYaf9y3jQZkrkSf
        n4oos4/FQaf3NahsvXGSZ/FMWvSB/SgwEDMwN9D6TDjV5qNVUg2wsxo49Joz8Msc4hesQiG7U+A
        YGhwwYxZqBBj66yIPKz9BcTv5jg==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr29989643wmi.46.1576488960985;
        Mon, 16 Dec 2019 01:36:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRrLkYcQb78YO6pW50jZPw7PzUtEfqQAiUKG8CT/bAx6EnRhpIUN902jFhbm+mxHE/24TLcQ==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr29989631wmi.46.1576488960727;
        Mon, 16 Dec 2019 01:36:00 -0800 (PST)
Received: from orion (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id a16sm20765369wrt.37.2019.12.16.01.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 01:35:59 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:35:57 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/2] New zonefs file system
Message-ID: <20191216093557.2vackj7qakk2jngd@orion>
Mail-Followup-To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <29fb138e-e9e5-5905-5422-4454c956e685@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29fb138e-e9e5-5905-5422-4454c956e685@metux.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 16, 2019 at 09:18:23AM +0100, Enrico Weigelt, metux IT consult wrote:
> On 12.12.19 19:38, Damien Le Moal wrote:
> 
> Hi,
> 
> > zonefs is a very simple file system exposing each zone of a zoned block
> > device as a file. Unlike a regular file system with zoned block device
> > support (e.g. f2fs or the on-going btrfs effort), zonefs does not hide
> > the sequential write constraint of zoned block devices to the user.
> 
> Just curious: what's the exact definition of "zoned" here ?
> Something like partitions ?

Zones inside a SMR HDD.

> 
> Can these files then also serve as block devices for other filesystems ?
> Just a funny idea: could we handle partitions by a file system ?
> 
> Even more funny idea: give file systems block device ops, so they can
> be directly used as such (w/o explicitly using loopdev) ;-)
> 
> > Files representing sequential write zones of the device must be written
> > sequentially starting from the end of the file (append only writes).
> 
> So, these files can only be accessed like a tape ?

On a SMR HDD, each zone can only be written sequentially, due to physics
constraints. I won't post any link with references because I think majordomo
will spam my email if I do, but do a google search of something like 'SMR HDD
zones' and you'll get a better idea


> 
> Assuming you're working ontop of standard block devices anyways (instead
> of tape-like media ;-)) - why introducing such a limitation ?

The limitation is already there on SMR drives, some of them (Device Managed
models), just hide it from the system.

> 
> > zonefs is not a POSIX compliant file system. It's goal is to simplify
> > the implementation of zoned block devices support in applications by
> > replacing raw block device file accesses with a richer file based API,
> > avoiding relying on direct block device file ioctls which may
> > be more obscure to developers. 
> 
> ioctls ?
> 
> Last time I checked, block devices could be easily accessed via plain
> file ops (read, write, seek, ...). You can basically treat them just
> like big files of fixed size.
> 
> > One example of this approach is the
> > implementation of LSM (log-structured merge) tree structures (such as
> > used in RocksDB and LevelDB)
> 
> The same LevelDB as used eg. in Chrome browser, which destroys itself
> every time a little temporary problem (eg. disk full) occours ?
> If that's the usecase I'd rather use an simple in-memory table instead
> and and enough swap, as leveldb isn't reliable enough for persistent
> data anyways :p
> 
> > on zoned block devices by allowing SSTables
> > to be stored in a zone file similarly to a regular file system rather
> > than as a range of sectors of a zoned device. The introduction of the
> > higher level construct "one file is one zone" can help reducing the
> > amount of changes needed in the application while at the same time
> > allowing the use of zoned block devices with various programming
> > languages other than C.
> 
> Why not just simply use files on a suited filesystem (w/ low block io
> overhead) or LVM volumes ?
> 
> 
> --mtx
> 
> -- 
> Dringender Hinweis: aufgrund existenzieller Bedrohung durch "Emotet"
> sollten Sie *niemals* MS-Office-Dokumente via E-Mail annehmen/öffenen,
> selbst wenn diese von vermeintlich vertrauenswürdigen Absendern zu
> stammen scheinen. Andernfalls droht Totalschaden.
> ---
> Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
> werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schlüssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
> 

-- 
Carlos

