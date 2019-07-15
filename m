Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E8469969
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfGOQyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 12:54:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35249 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbfGOQyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:54:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so7704406pfn.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2019 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ys4uOVKl6GGxj9issQsvhgYSxfR11pboh5SjeQpl28Y=;
        b=cXm/r65PHJswk7kkQcxenSxmFOzYQ6XS4N9Xzcs0KGDvnjb2FlHcUqHrC6j1rgP8re
         G/a84sV7igbIAbAZo5GifS61rqKQY7zSOBCrRYx+38QNbfKMZTXVY6Z2HdPNV8z2DjJu
         zJxn5jKPiOzZzdAzSkqtU+R1e7ucg99w4CjxQ1X1oMO3WCevi3O2EVZm6GUyq7JZWBmt
         ySOGSuP65tVAYMaosPyQPL2IdYyGn97+ifjBVlNfZEEAoihQTLXyDUhV+9aLShixVxgW
         8oZKgwsytjm4hRnit3OOWmU8+qQw4rRdoCCXliC1nCyeLRFZlAfjTtYxRuYpw3ksFnTn
         exuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ys4uOVKl6GGxj9issQsvhgYSxfR11pboh5SjeQpl28Y=;
        b=pKFVONUkeHkfKctdLwVFMdvoHujaOlKAuJiJ1fNEOCiksndLTnq48pUKKU8I6NexBi
         uyXLC8EHIzuZtKSxzgGW2h2N/Bu+JG/S07Q5jBObuW1mwcc7HU82tbN2VmNtv3UxQbm8
         9TG6gDnuygT6ciXBfwor78N1HwmNoG/PbkXZjnIgHAsSntL5ul/Zri0I7+UgfIVY3Exe
         1EiKQervukjHTPfnrMtCXP1QIM5Eou6IYVpfH9/COC8YheS9LKC7TJnaMRlbSqyQrIeL
         CJbmIJeIjw+p3rVZ+jUNDTUogo9iGQQaTrUSlOh1Tdbs942AxP+s5fQm8UY2nZwhuXBv
         nLsA==
X-Gm-Message-State: APjAAAVO97oUfVNF37hKWPaPjwz0ZZonZxO7MI/c0tQ0OeYp4vp9Fnio
        6/+p2w05PbeWzXRS/4H5bcRTX9ol2hU=
X-Google-Smtp-Source: APXvYqwqZNF5nN611U1lr13X7qBiuon8gT4/5O5bb2Bkqw8X+KAzgfpVSGcZ6geyuwo2ahbpJIDw8A==
X-Received: by 2002:a17:90a:cb97:: with SMTP id a23mr29737776pju.67.1563209656202;
        Mon, 15 Jul 2019 09:54:16 -0700 (PDT)
Received: from [192.168.1.136] (c-67-169-41-205.hsd1.ca.comcast.net. [67.169.41.205])
        by smtp.gmail.com with ESMTPSA id a3sm23586265pje.3.2019.07.15.09.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 09:54:15 -0700 (PDT)
Message-ID: <1563209654.2741.39.camel@dubeyko.com>
Subject: Re: [PATCH RFC] fs: New zonefs file system
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Ting Yao <d201577678@hust.edu.cn>
Date:   Mon, 15 Jul 2019 09:54:14 -0700
In-Reply-To: <BYAPR04MB5816F3DE20A3C82B82192B94E7F20@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
         <1562951415.2741.18.camel@dubeyko.com>
         <BYAPR04MB5816F3DE20A3C82B82192B94E7F20@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-07-12 at 22:56 +0000, Damien Le Moal wrote:
> On 2019/07/13 2:10, Viacheslav Dubeyko wrote:
> > 
> > On Fri, 2019-07-12 at 12:00 +0900, Damien Le Moal wrote:
> > > 
> > > zonefs is a very simple file system exposing each zone of a zoned
> > > block device as a file. This is intended to simplify
> > > implementation 
> > As far as I can see, a zone usually is pretty big in size (for
> > example,
> > 256MB). But [1, 2] showed that about 60% of files on a file system
> > volume has size about 4KB - 128KB. Also [3] showed that modern
> > application uses a very complex files' structures that are updated
> > in
> > random order. Moreover, [4] showed that 90% of all files are not
> > used
> > after initial creation, those that are used are normally short-
> > lived,
> > and that if a file is not used in some manner the day after it is
> > created, it will probably never be used; 1% of all files are used
> > daily.
> > 
> > It sounds for me that mostly this approach will lead to waste of
> > zones'
> > space. Also, the necessity to update data of the same file will be
> > resulted in frequent moving of files' data from one zone to another
> > one. If we are talking about SSDs then it sounds like quick and
> > easy
> > way to kill this device fast.
> > 
> > Do you have in mind some special use-case?
> As the commit message mentions, zonefs is not a traditional file
> system by any
> mean and much closer to a raw block device access interface than
> anything else.
> This is the entire point of this exercise: allow replacing the raw
> block device
> accesses with the easier to use file system API. Raw block device
> access is also
> file API so one could argue that this is nonsense. What I mean here
> is that by
> abstracting zones with files, the user does not need to do the zone
> configuration discovery with ioctl(BLKREPORTZONES), does not need to
> do explicit
> zone resets with ioctl(BLKRESETZONE), does not have to "start from
> one sector
> and write sequentially from there" management for write() calls (i.e.
> seeks),
> etc. This is all replaced with the file abstraction: directory entry
> list
> replace zone information, truncate() replace zone reset, file current
> position
> replaces the application zone write pointer management.
> 
> This simplifies implementing support of applications for zoned block
> devices,
> but only in cases where said applications:
> 1) Operate with large files
> 2) have no or only minimal need for random writes
> 
> A perfect match for this as mentioned in the commit message are LSM-
> tree based
> applications such as LevelDB or RocksDB. Other examples, related,
> include
> Bluestore distributed object store which uses RocksDB but still has a
> bluefs
> layer that could be replaced with zonefs.
> 
> As an illustration of this, Ting Yao of Huazhong University of
> Science and
> Technology (China) and her team modified LevelDB to work with zonefs.
> The early
> prototype code is on github here: https://github.com/PDS-Lab/GearDB/t
> ree/zonefs
> 
> LSM-Tree applications typically operate on large files, in the same
> range as
> zoned block device zone size (e.g. 256 MB or so). While this is
> generally a
> parameter that can be changed, the use of zonefs and zoned block
> device forces
> using the zone size as the SSTable file maximum size. This can have
> an impact on
> the DB performance depending on the device type, but that is another
> discussion.
> The point here is the code simplifications that zonefs allows.
> 
> For more general purpose use cases (small files, lots of random
> modifications),
> we already have the dm-zoned device mapper and f2fs support and we
> are also
> currently working on btrfs support. These solutions are in my opinion
> more
> appropriate than zonefs to address the points you raised.
> 

Sounds pretty reasonable. But I still have two worries.

First of all, even modest file system could contain about 100K files on
a volume. So, if our zone is 256 MB then we need in 24 TB storage
device for 100K files. Even if we consider some special use-case of
database, for example, then it's pretty easy to imagine the creation a
lot of files. So, are we ready to provide such huge storage devices
(especially, for the case of SSDs)?

Secondly, the allocation scheme is too simplified for my taste and it
could create a significant fragmentation of a volume. Again, 256 MB is
pretty big size. So, I assume that, mostly, it will be allocated only
one zone at first for a created file. If file grows then it means that
it will need to allocate the two contigous zones and to move the file's
content. Finally, it sounds for me that it is possible to create a lot
of holes and to achieve the volume state when it exists a lot of free
space but files will be unable to grow and it will be impossible to add
a new data on the volume. Have you made an estimation of the suggested
allocation scheme?

Thanks,
Viacheslav Dubeyko.

