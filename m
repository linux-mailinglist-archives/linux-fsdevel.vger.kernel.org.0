Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E00129E3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 07:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfLXGtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 01:49:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38320 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfLXGtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 01:49:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so19005429wrh.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2019 22:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unipv-it.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Du3w8o4be0YrPPaCkoujjN4fjZHuiFhvUdHnNG8GiXA=;
        b=xo/+5mAtkGrSMXmN3dzVYXFvFKdi79jVzFHyAR1q7tGeErbGpJuKOjy3KF53yUe6WP
         wCtoeKrw+xm7PO+8U4jfxyCvO44yw1/TlLGPWZgW3q3JFzu81zqarZyAYielqlGlXIu7
         iKqI2kw/JzsJ9vJVdlf7+L6IjAq+8PYGaqrefRz4tqHuMBbK0txIfWL0AQnExpOPoAQq
         RbNSpnPWpirQY2QojFrv4SDseYki/2IEK0GgeF3gO3mrRrgRyY0IvZ0yFLKInyt4sF6W
         JzFSykGv4RD5IAz2jqO45seMAre//6RSgEzy5ykeOs56jPa22uSjIAyzI19SRGTqTaB6
         snzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Du3w8o4be0YrPPaCkoujjN4fjZHuiFhvUdHnNG8GiXA=;
        b=PcfpZvBLRidrhlcJXRuo93nGe9l621hjpPAwMTMKKf+ND2W5Uk9pmY0jq48QqHfYGR
         J1WEG6wlMI9aOpmMSdYN4brtPd1zNQQm3/VIucBxEAF/xNmeCEejZpIksOPmSD3n9Y/M
         WNYOEICpjIJ7QShBmJlpvPy7uPHi0lN2OzdDLCd8LSBTZFXK07/3iLrZRmlgIOkwFOMJ
         Zv86V3GL0ojv0d0cS7q0DesRx4X/LJS6jIxr06GdRD4g4lN82zrU41mCDLKbpn0syMCu
         Ka5FFBVQ7miL64Pz6riHjgHA2Shqp9zRYXi6fClN1Gqr9ApHDMUImov9YAc/7pWFtUw6
         ioXQ==
X-Gm-Message-State: APjAAAWjHx7ikU2QcYrXV6+fC/+5z4r6Iw0+lfR7bvDUu2ofMc1u1STe
        3A7qhDFuGH3pr1y17aqsRtHxsQ==
X-Google-Smtp-Source: APXvYqzK4i70c8JMuCt/z/08xxUl65emDBiqKV0XE4PJ2lO+Y0Oxfarqmn4UeP3nUVE4Oj2YCmqBYw==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr34577062wrv.146.1577170179120;
        Mon, 23 Dec 2019 22:49:39 -0800 (PST)
Received: from angus.unipv.it (angus.unipv.it. [193.206.67.163])
        by smtp.gmail.com with ESMTPSA id d16sm25168758wrg.27.2019.12.23.22.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 22:49:38 -0800 (PST)
Message-ID: <e3dc2a3e0221c0a0beb91172ba2bff1f6acc0cb7.camel@unipv.it>
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
Date:   Tue, 24 Dec 2019 07:49:37 +0100
In-Reply-To: <20191224012707.GA13083@ming.t460p>
References: <20191211213316.GA14983@ming.t460p>
         <f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it>
         <20191218094830.GB30602@ming.t460p>
         <b1b6a0e9d690ecd9432025acd2db4ac09f834040.camel@unipv.it>
         <20191223130828.GA25948@ming.t460p> <20191223162619.GA3282@mit.edu>
         <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
         <20191223172257.GB3282@mit.edu>
         <bb5d395fe47f033be0b8ed96cbebf8867d2416c4.camel@unipv.it>
         <20191223195301.GC3282@mit.edu> <20191224012707.GA13083@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Il giorno mar, 24/12/2019 alle 09.27 +0800, Ming Lei ha scritto:
> Hi Ted,
> 
> On Mon, Dec 23, 2019 at 02:53:01PM -0500, Theodore Y. Ts'o wrote:
> > On Mon, Dec 23, 2019 at 07:45:57PM +0100, Andrea Vai wrote:
> > > basically, it's:
> > > 
> > >   mount UUID=$uuid /mnt/pendrive
> > >   SECONDS=0
> > >   cp $testfile /mnt/pendrive
> > >   umount /mnt/pendrive
> > >   tempo=$SECONDS
> > > 
> > > and it copies one file only. Anyway, you can find the whole
> script
> > > attached.
> > 
> > OK, so whether we are doing the writeback at the end of cp, or
> when
> > you do the umount, it's probably not going to make any
> difference.  We
> > can get rid of the stack trace in question by changing the script
> to
> > be basically:
> > 
> > mount UUID=$uuid /mnt/pendrive
> > SECONDS=0
> > rm -f /mnt/pendrive/$testfile
> > cp $testfile /mnt/pendrive
> > umount /mnt/pendrive
> > tempo=$SECONDS
> > 
> > I predict if you do that, you'll see that all of the time is spent
> in
> > the umount, when we are trying to write back the file.
> > 
> > I really don't think then this is a file system problem at
> all.  It's
> > just that USB I/O is slow, for whatever reason.  We'll see a stack
> > trace in the writeback code waiting for the I/O to be completed,
> but
> > that doesn't mean that the root cause is in the writeback code or
> in
> > the file system which is triggering the writeback.
> 
> Wrt. the slow write on this usb storage, it is caused by two
> writeback
> path, one is the writeback wq, another is from ext4_release_file()
> which
> is triggered from exit_to_usermode_loop().
> 
> When the two write path is run concurrently, the sequential write
> order
> is broken, then write performance drops much on this particular usb
> storage.
> 
> The ext4_release_file() should be run from read() or write() syscall
> if
> Fedora 30's 'cp' is implemented correctly. IMO, it isn't expected
> behavior
> for ext4_release_file() to be run thousands of times when just
> running 'cp' once, see comment of ext4_release_file():
> 
> 	/*
> 	 * Called when an inode is released. Note that this is
> different
> 	 * from ext4_file_open: open gets called at every open, but
> release
> 	 * gets called only when /all/ the files are closed.
> 	 */
> 	static int ext4_release_file(struct inode *inode, struct file
> *filp)
> 
> > 
> > I suspect the next step is use a blktrace, to see what kind of I/O
> is
> > being sent to the USB drive, and how long it takes for the I/O to
> > complete.  You might also try to capture the output of "iostat -x
> 1"
> > while the script is running, and see what the difference might be
> > between a kernel version that has the problem and one that
> doesn't,
> > and see if that gives us a clue.
> 
> That isn't necessary, given we have concluded that the bad write
> performance is caused by broken write order.
> 
> > 
> > > > And then send me
> > > btw, please tell me if "me" means only you or I cc: all the
> > > recipients, as usual
> > 
> > Well, I don't think we know what the root cause is.  Ming is
> focusing
> > on that stack trace, but I think it's a red herring.....  And if
> it's
> > not a file system problem, then other people will be best suited
> to
> > debug the issue.
> 
> So far, the reason points to the extra writeback path from
> exit_to_usermode_loop().
> If it is not from close() syscall, the issue should be related with
> file reference
> count. If it is from close() syscall, the issue might be in 'cp''s
> implementation.
> 
> Andrea, please collect the following log or the strace log requested
> by Ted, then
> we can confirm if the extra writeback is from close() or
> read/write() syscall:
> 
> # pass PID of 'cp' to this script
> #!/bin/sh
> PID=$1
> /usr/share/bcc/tools/trace -P $PID  -t -C \
>     't:block:block_rq_insert "%s %d %d", args->rwbs, args->sector,
> args->nr_sector' \
>     't:syscalls:sys_exit_close ' \
>     't:syscalls:sys_exit_read ' \
>     't:syscalls:sys_exit_write '

Sorry if I am a bit confused, should I run it on ext4 or xfs, or
doesn't matter? What if I get it on a "fast" run? Should I throw it
away and try again until I get a slow one, or it doesn't matter?

Thanks,
Andrea

