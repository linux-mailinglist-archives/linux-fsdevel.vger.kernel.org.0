Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF159129F79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 09:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfLXIv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 03:51:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39721 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfLXIvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 03:51:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so1888974wmj.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2019 00:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unipv-it.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=Ip6gBMfKVrzqTbtFPr3qMhjyph5AY5RxQraBAQBkILA=;
        b=R7KDsihzez4UHxy2gEka+irALy5DMxOyUlMO2FIkfz5aXZ5FG7RatDIhOtTfrLYYtx
         PW9HuotOvJuWSn4VOsc76F0r3Bthv8TkaZ8pAddOJwZQOtWn+24dcUMfr+Pfk+MGar9l
         LAS1etqfDU3jX+dldY+4fmyJX1IOxV0xJe4e6iBIor7czSL5pT1ActKIqSc3dHGWPdbU
         6BccMJBsNSFOVGlYOeKn4hIVO5qpZOH0kN0Qxwg1GsclbMVUp+0D6SyJwAtCDEbwZ+JT
         fpy04cemWNhE2uHtlrPY7NQhfs1nI70A8r2kDu9B4Y3OJhBKg7+YL1oyShnvA06T0e+N
         ePPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=Ip6gBMfKVrzqTbtFPr3qMhjyph5AY5RxQraBAQBkILA=;
        b=lOGSvnnOuEMUiUXpIlQfaBDaANKryO8dZiVawZpG/F4+AFdCs5/7e86CQMGvY+iC2h
         AW8z0frZBwZvuK3uZmFrUiWn/gLjPqEqNdvzjeWXyKQuxpoEQXXNSIky8Oo7OuOaYEev
         GmGy1VWZsdlLZN/rQCCDwfRHXvluPLgP2W9a/+YWU1B0JwNhxxn8EPZ5YbtWyj+SQ0EG
         PV+edZjYWdNfVVLifcg3U/aAsw3ZkJkQ/eC3B+YIY8uC+qvQjLPrsijCY4ztg9sIbRWW
         ca5Ova3GhPmJzmOTrhCSO8kwxHr9Rxy5m/e2YQPox/BhP78TkLT3j0561k7Ual3wV5sE
         cg0w==
X-Gm-Message-State: APjAAAVw23m5uzVDt61IPLduZpWUE4KZAzIz+oWh1ddxHFXZzn8IdU0A
        3yPtWPje/xAJkXlZpMTHDoWPgA==
X-Google-Smtp-Source: APXvYqwzOivSXhibzR+wh9ag7IeiaEUK6l42Bm+019NaMEgNeuJYz+P2ZjHbUE9H0/FZ9/F7eb/PKQ==
X-Received: by 2002:a1c:1dd7:: with SMTP id d206mr3019483wmd.5.1577177478822;
        Tue, 24 Dec 2019 00:51:18 -0800 (PST)
Received: from angus.unipv.it (angus.unipv.it. [193.206.67.163])
        by smtp.gmail.com with ESMTPSA id n16sm23794220wro.88.2019.12.24.00.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:51:17 -0800 (PST)
Message-ID: <0094198b6c3382ee2efbd4431e4ad1bfb8cef269.camel@unipv.it>
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
Date:   Tue, 24 Dec 2019 09:51:16 +0100
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
Content-Type: multipart/mixed; boundary="=-lD2DCQr1GVgo6Ui2Zfl8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-lD2DCQr1GVgo6Ui2Zfl8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

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

Meanwhile, I tried to run the test and obtained an error (...usage:
trace [-h] [-b BUFFER_PAGES] [-p PID]...), so assumed the "-P" should
be "-p", corrected and obtained the attached log with ext4 and a slow
copy (2482 seconds) by doing:

- start the test
- look at the cp pid
- run the trace
- wait for the test to finish
- stop the trace.

Thanks,
Andrea

--=-lD2DCQr1GVgo6Ui2Zfl8
Content-Type: application/zip; name="20191224_test_ming.zip"
Content-Disposition: attachment; filename="20191224_test_ming.zip"
Content-Transfer-Encoding: base64

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
AwAAUEsFBgAAAAABAAEAZAAAAORQAAAAAA==


--=-lD2DCQr1GVgo6Ui2Zfl8--

