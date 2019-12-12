Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4819B11C675
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 08:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfLLHea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 02:34:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42468 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfLLHea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:34:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so1517663wro.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 23:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unipv-it.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ouu20+mE9n/tPYHmfkHzcHWK0RTLjVdq3889eJu3VP0=;
        b=lmtQeDO0RVMVq5UaQ/yHPY07AfXs62TQ590bzWxxhQaAA/OaOB21aNqrC1Zlo45s+i
         0vqOpszc8Sfm2BBuncYr8tlj7W9bIc7EYH4J1UDr3BBFEYge7eIFNYAJWO2NQIzACRy8
         sSVzNMIr1hZEY5iikGTDJf2NPrHPoeHl5AG5OylC98AeaeJw96Euvod9mMvblTCJGjD9
         6qsE8uOYHKRAsu1xmiY5Az/7p9YfDoB1FtlTfUJDUJsN9RxZJ0sIKI+lDVR/bCYUud7F
         n3m5AqVOLGyqEbqy9t5Cdr6E/ifNMpVhVtWyCb8LVjExB3CRLPxurspWLQshKirl27l9
         TJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ouu20+mE9n/tPYHmfkHzcHWK0RTLjVdq3889eJu3VP0=;
        b=gAAsUxxy6pEfMIgCVIZM/I3duVZntb96avAj1rm1R2Dt0LWP3+BQq/CxG/3ZsD0BRH
         IdGdERmQivSi0NQc6/SGzCjKWyupLVWLSKa70uhoOcTSz9S7xJT4wQhV1Xkeiepogf9s
         6dJZJX7yDSEQjbFjE05lppFHdtAaGNDRypNcoQKJueviURoqhi2uhUPbKhu1MdBmC4X/
         YoXxGDsd2VT1hCSrv/VzoVeBdcGnGF0jj9fzi0BSX8Itv3mvYQ9EQIdl83fCZ5gTga8M
         30NKZ2rYp3wqx9rUNbkLSrSOa9zE28ICf85L6L0kT280FaVf94JbBP1MUppnZe6V3zFU
         uWrg==
X-Gm-Message-State: APjAAAXvyMkfbhgdV4idFyRcWgcgCUTh9UlTNvCHnHXyIjS4Mkjb8J+A
        s4LTnnrOnfDskDjr8HJ6QkZzLw==
X-Google-Smtp-Source: APXvYqwlTzWP0XWOqGIJf4UvsmxnRFuIxB+FV85xriWGt31SdJo44/OLaYrtTWBOIOO+0sMh8wDsnw==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr4385600wru.353.1576136068427;
        Wed, 11 Dec 2019 23:34:28 -0800 (PST)
Received: from angus.unipv.it (angus.unipv.it. [193.206.67.163])
        by smtp.gmail.com with ESMTPSA id o66sm1101251wmo.20.2019.12.11.23.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 23:34:27 -0800 (PST)
Message-ID: <430b562eeba371ef3b917193246b9eb6c46be71e.camel@unipv.it>
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
Date:   Thu, 12 Dec 2019 08:34:26 +0100
In-Reply-To: <20191211213316.GA14983@ming.t460p>
References: <f82fd5129e3dcacae703a689be60b20a7fedadf6.camel@unipv.it>
         <20191129005734.GB1829@ming.t460p> <20191129023555.GA8620@ming.t460p>
         <320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it>
         <20191203022337.GE25002@ming.t460p>
         <8196b014b1a4d91169bf3b0d68905109aeaf2191.camel@unipv.it>
         <20191210080550.GA5699@ming.t460p> <20191211024137.GB61323@mit.edu>
         <20191211040058.GC6864@ming.t460p> <20191211160745.GA129186@mit.edu>
         <20191211213316.GA14983@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Il giorno gio, 12/12/2019 alle 05.33 +0800, Ming Lei ha scritto:
> On Wed, Dec 11, 2019 at 11:07:45AM -0500, Theodore Y. Ts'o wrote:
> > On Wed, Dec 11, 2019 at 12:00:58PM +0800, Ming Lei wrote:
> > > I didn't reproduce the issue in my test environment, and follows
> > > Andrea's test commands[1]:
> > > 
> > >   mount UUID=$uuid /mnt/pendrive 2>&1 |tee -a $logfile
> > >   SECONDS=0
> > >   cp $testfile /mnt/pendrive 2>&1 |tee -a $logfile
> > >   umount /mnt/pendrive 2>&1 |tee -a $logfile
> > > 
> > > The 'cp' command supposes to open/close the file just once,
> however
> > > ext4_release_file() & write pages is observed to run for 4358
> times
> > > when executing the above 'cp' test.
> > 
> > Why are we sure the ext4_release_file() / _fput() is coming from
> the
> > cp command, as opposed to something else that might be running on
> the
> > system under test?  _fput() is called by the kernel when the last
> 
> Please see the log:
> 
> https://lore.kernel.org/linux-scsi/3af3666920e7d46f8f0c6d88612f143ffabc743c.camel@unipv.it/2-log_ming.zip
> 
> Which is collected by:
> 
> #!/bin/sh
> MAJ=$1
> MIN=$2
> MAJ=$(( $MAJ << 20 ))
> DEV=$(( $MAJ | $MIN ))
> 
> /usr/share/bcc/tools/trace -t -C \
>     't:block:block_rq_issue (args->dev == '$DEV') "%s %d %d", args-
> >rwbs, args->sector, args->nr_sector' \
>     't:block:block_rq_insert (args->dev == '$DEV') "%s %d %d", args-
> >rwbs, args->sector, args->nr_sector'
> 
> $MAJ:$MIN points to the USB storage disk.
> 
> From the above IO trace, there are two write paths, one is from cp,
> another is from writeback wq.
> 
> The stackcount trace[1] is consistent with the IO trace log since it
> only shows two IO paths, that is why I concluded that the write done
> via
> ext4_release_file() is from 'cp'.
> 
> [1] 
> https://lore.kernel.org/linux-scsi/320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it/2-log_ming_20191129_150609.zip
> 
> > reference to a struct file is released.  (Specifically, if you
> have a
> > fd which is dup'ed, it's only when the last fd corresponding to
> the
> > struct file is closed, and the struct file is about to be
> released,
> > does the file system's f_ops->release function get called.)
> > 
> > So the first question I'd ask is whether there is anything else
> going
> > on the system, and whether the writes are happening to the USB
> thumb
> > drive, or to some other storage device.  And if there is something
> > else which is writing to the pendrive, maybe that's why no one
> else
> > has been able to reproduce the OP's complaint....
> 
> OK, we can ask Andrea to confirm that via the following trace, which
> will add pid/comm info in the stack trace:
> 
> /usr/share/bcc/tools/stackcount  blk_mq_sched_request_inserted
> 
> Andrea, could you collect the above log again when running new/bad
> kernel for confirming if the write done by ext4_release_file() is
> from
> the 'cp' process?

Yes, I will try to do it as soon as possible and let you know.
I will also try xfs or btrfs, as you suggested in another message.

Thanks, and bye
Andrea

