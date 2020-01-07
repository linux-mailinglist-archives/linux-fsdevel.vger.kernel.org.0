Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4531320B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 08:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgAGHvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 02:51:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50799 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgAGHvq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:51:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so17834136wmb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 23:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unipv-it.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JeiqdmtUMyWOTftvNLubB0ZlSpHFDswOnC4RjW6U6GE=;
        b=SlkuC2H9D5qWyaQ8qcx3F+xQydYl+QJcDgYjhvL4rtZQwX4HIrQo4UgAuLTY7BfB75
         PUeh0Dq+H0Lmi7EtK7cBvCCoww5Kp3sGm9mU/3mOkZSw69UhjD+dCEyocHKQzVFBOd/f
         1hwCcKM1Jvr1F0sNP7oAEe9J0ArUT1iAGTQbRCmMofqUGZfdbWQ22aWbnK6QGFNM/taU
         qqGf8Zcd7yvzxKWY8xV2IPz3IF3sQfTXtFPQdTwi3R8+4tYmOFdNmQIeynklFPby/TXs
         f4cDx6dhVDp86rGW02rMNHn6GVKqhBo0PIficdDSpRPP8cpoOPEqbZuJ0bNnB52K6viV
         oc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JeiqdmtUMyWOTftvNLubB0ZlSpHFDswOnC4RjW6U6GE=;
        b=GA/xpla7olCfHooPGxlGu0eIR+7hL+ZsOqB8zZjGn3g7brPmvwVl6faC0faUR1F5cb
         LipdwvsHmbvUqQ209EjK9jECSTB5DgsIABmmNdJ0k1jBRXNu0HTXKPf18GWRVpPlRcC3
         +FOuHVBrwThWt3p8TSHARnruPD2SS4kzEBPO+v0XwXglj8u2HMT2krpOa/qU5Mr81jeL
         sU57FV6VBIdbwEWpA0bT5DDI9UBy07OtrsYF5wCkWX7nRvm6gj0mQGVPPiyNqvxqyKc2
         sn9AvIWekKQ2K7DQrkDiQIRc5Tg4AIB2DCpkkArf9LCpX7x3MDLE4TnTeN3vj1+/vvHS
         ucZQ==
X-Gm-Message-State: APjAAAWjrvYLVk1uwlbd7fhGUty8E9e+VQ+kzXcsYnAnff/eBBN72yhZ
        DJHj1+UUFewwv3l3DwwDjardTg==
X-Google-Smtp-Source: APXvYqwbTzi4da5sYoYBNersGjGd0bPEnenG66OEdAADR5SYHnHw2lSWqTjx0cyI8PP76Y14jUTwNg==
X-Received: by 2002:a05:600c:2150:: with SMTP id v16mr35755682wml.156.1578383503183;
        Mon, 06 Jan 2020 23:51:43 -0800 (PST)
Received: from angus.unipv.it (angus.unipv.it. [193.206.67.163])
        by smtp.gmail.com with ESMTPSA id s10sm76197003wrw.12.2020.01.06.23.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 23:51:42 -0800 (PST)
Message-ID: <5bd51904b1b6511748c5454bce437bdc038eeb1f.camel@unipv.it>
Subject: Re: AW: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
From:   Andrea Vai <andrea.vai@unipv.it>
To:     Ming Lei <ming.lei@redhat.com>, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 07 Jan 2020 08:51:41 +0100
In-Reply-To: <20191226083706.GA17974@ming.t460p>
References: <20191223130828.GA25948@ming.t460p>
         <20191223162619.GA3282@mit.edu>
         <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
         <20191223172257.GB3282@mit.edu>
         <bb5d395fe47f033be0b8ed96cbebf8867d2416c4.camel@unipv.it>
         <20191223195301.GC3282@mit.edu> <20191224012707.GA13083@ming.t460p>
         <20191225051722.GA119634@mit.edu> <20191226022702.GA2901@ming.t460p>
         <20191226033057.GA10794@mit.edu> <20191226083706.GA17974@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Il giorno gio, 26/12/2019 alle 16.37 +0800, Ming Lei ha scritto:
> On Wed, Dec 25, 2019 at 10:30:57PM -0500, Theodore Y. Ts'o wrote:
> > On Thu, Dec 26, 2019 at 10:27:02AM +0800, Ming Lei wrote:
> > > Maybe we need to be careful for HDD., since the request count in
> scheduler
> > > queue is double of in-flight request count, and in theory NCQ
> should only
> > > cover all in-flight 32 requests. I will find a sata HDD., and
> see if
> > > performance drop can be observed in the similar 'cp' test.
> > 
> > Please try to measure it, but I'd be really surprised if it's
> > significant with with modern HDD's.
> 
> Just find one machine with AHCI SATA, and run the following xfs
> overwrite test:
> 
> #!/bin/bash
> DIR=$1
> echo 3 > /proc/sys/vm/drop_caches
> fio --readwrite=write --filesize=5g --overwrite=1 --
> filename=$DIR/fiofile \
>         --runtime=60s --time_based --ioengine=psync --direct=0 --
> bs=4k
> 		--iodepth=128 --numjobs=2 --group_reporting=1 --
> name=overwrite
> 
> FS is xfs, and disk is LVM over AHCI SATA with NCQ(depth 32),
> because the
> machine is picked up from RH beaker, and it is the only disk in the
> box.
> 
> #lsblk
> NAME                            MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
> sda                               8:0    0 931.5G  0 disk 
> ├─sda1                            8:1    0     1G  0 part /boot
> └─sda2                            8:2    0 930.5G  0 part 
>   ├─rhel_hpe--ml10gen9--01-root 253:0    0    50G  0 lvm  /
>   ├─rhel_hpe--ml10gen9--01-swap 253:1    0   3.9G  0 lvm  [SWAP]
>   └─rhel_hpe--ml10gen9--01-home 253:2    0 876.6G  0 lvm  /home
> 
> 
> kernel: 3a7ea2c483a53fc("scsi: provide mq_ops->busy() hook") which
> is
> the previous commit of f664a3cc17b7 ("scsi: kill off the legacy IO
> path").
> 
>             |scsi_mod.use_blk_mq=N |scsi_mod.use_blk_mq=Y |
> -----------------------------------------------------------
> throughput: |244MB/s               |169MB/s               |
> -----------------------------------------------------------
> 
> Similar result can be observed on v5.4 kernel(184MB/s) with same
> test
> steps.
> 
> 
> > That because they typically have
> > a queue depth of 16, and a max_sectors_kb of 32767 (e.g., just
> under
> > 32 MiB).  Sort seeks are typically 1-2 ms, with full stroke seeks
> > 8-10ms.  Typical sequential write speeds on a 7200 RPM drive is
> > 125-150 MiB/s.  So suppose every other request sent to the HDD is
> from
> > the other request stream.  The disk will chose the 8 requests from
> its
> > queue that are contiguous, and so it will be writing around 256
> MiB,
> > which will take 2-3 seconds.  If it then needs to spend between 1
> and
> > 10 ms seeking to another location of the disk, before it writes
> the
> > next 256 MiB, the worst case overhead of that seek is 10ms / 2s,
> or
> > 0.5%.  That may very well be within your measurements' error bars.
> 
> Looks you assume that disk seeking just happens once when writing
> around
> 256MB. This assumption may not be true, given all data can be in
> page
> cache before writing. So when two tasks are submitting IOs
> concurrently,
> IOs from each single task is sequential, and NCQ may order the
> current batch
> submitted from the two streams. However disk seeking may still be
> needed
> for the next batch handled by NCQ.
> 
> > And of course, note that in real life, we are very *often* writing
> to
> > multiple files in parallel, for example, during a "make -j16"
> while
> > building the kernel.  Writing a single large file is certainly
> > something people do (but even there people who are burning a 4G
> DVD
> > rip are often browsing the web while they are waiting for it to
> > complete, and the browser will be writing cache files, etc.).  So
> > whether or not this is something where we should be stressing over
> > this specific workload is going to be quite debateable.
> 

Hi,
  is there any update on this? Sorry if I am making noise, but I would
like to help to improve the kernel (or fix it) if I can help.
Otherwise, please let me know how to consider this case,

Thanks, and bye
Andrea

