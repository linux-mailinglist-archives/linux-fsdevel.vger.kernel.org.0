Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADBE21021A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 11:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKSKIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 05:08:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34523 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfKSKIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:08:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id z188so11145841pgb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 02:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0as+kqGp44tyRx+kW5oQfsxwSoGdl6l76oT22Nl8N74=;
        b=v8Q3Ts5nxlnauS/2ghDpbPKFgU64xhcUk2q9N0EIKCrEeCO1UZzdvm7IxtaY2XYPox
         DIHxrwKQ1tzXYSKoZY5C7lLdHvwJ4dTI9PGVyravK4EbkP01DQ9DhAzxQZutRDhxYmDT
         VTY4TDGDSPgqLRcJYHp71FgLyYf6puBT63wzO3s3OClM8A+6XXuYqJd8iwbtvJia0tgj
         yzx/SQrS4tR5h4Z4vSBYh3CE+03HV2elpZ/6xxadUkDMlG/70b7shQf2rPHa+BzqcXm+
         AOeqQ7WXjQUfeoBP1EqMUCsJykbbdHJQHTfVaz4SF0i/z+y/+FeNRd+CCGbvVX78DTwn
         FZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0as+kqGp44tyRx+kW5oQfsxwSoGdl6l76oT22Nl8N74=;
        b=qe540Uk1Sh+pII60fvIgYdPhOZv5YAaw6vuhNjH3E+FBZO+M8JJj3tieJ2vwu1eWzs
         987qBeXDQm77wFJy45MZLoVWuUGyuHnyXvzvYwewBx6LcxBaGuhRB7v6iQ1fk7u7epeX
         N2AweYhOd080naqpkX6yox0r6T0U+W3dTT3UUKaLA6zjj30RbNkGlT578ZH2HTZMjNHW
         lcRQ31OP7t5hZyRZ2Nknu4JTGqDvnrppkfVxk8ERATMRAQW2hQvbwDE8e20a/twCxv82
         fiIajulMHCFUjYTp2Jk+tCsIoESCFmt2Uktq3v8FveTULCHCOF6EBbSd0A3Qo7Dj4Nri
         QRcw==
X-Gm-Message-State: APjAAAUxMIGIHIkNy5yZ8i3VqnDbw2SJJ7PkEWbZ54kMAu/e39MfqYwX
        bV+++VsriLl1m1UxvJE/nT8L
X-Google-Smtp-Source: APXvYqxOjci1H8Ei4WdF79tc6UVvv6rGHGtq5HEtKINHp8jaqtc8G29vaDRMXLC+T1Tt4lx/p/J5UQ==
X-Received: by 2002:a63:5f49:: with SMTP id t70mr4738291pgb.219.1574158110418;
        Tue, 19 Nov 2019 02:08:30 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id v128sm6167533pgv.24.2019.11.19.02.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 02:08:29 -0800 (PST)
Date:   Tue, 19 Nov 2019 21:08:22 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+991400e8eba7e00a26e1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        riteshh@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Subject: Re: WARNING in iov_iter_pipe
Message-ID: <20191119100821.GB22484@bobrowski>
References: <000000000000d60aa50596c63063@google.com>
 <20191108103148.GE20863@quack2.suse.cz>
 <20191111081628.GB14058@bobrowski>
 <20191119031021.GI3147@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119031021.GI3147@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 18, 2019 at 07:10:21PM -0800, Eric Biggers wrote:
> On Mon, Nov 11, 2019 at 07:16:29PM +1100, Matthew Bobrowski wrote:
> > On Fri, Nov 08, 2019 at 11:31:48AM +0100, Jan Kara wrote:
> > > On Thu 07-11-19 10:54:10, syzbot wrote:
> > > > syzbot found the following crash on:
> > > > 
> > > > HEAD commit:    c68c5373 Add linux-next specific files for 20191107
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=13d6bcfce00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=742545dcdea21726
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=991400e8eba7e00a26e1
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1529829ae00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a55c0ce00000
> > > > 
> > > > The bug was bisected to:
> > > > 
> > > > commit b1b4705d54abedfd69dcdf42779c521aa1e0fbd3
> > > > Author: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > > > Date:   Tue Nov 5 12:01:37 2019 +0000
> > > > 
> > > >     ext4: introduce direct I/O read using iomap infrastructure
> > > 
> > > Hum, interesting and from the first looks the problem looks real.
> > > Deciphered reproducer is:
> > > 
> > > int fd0 = open("./file0", O_RDWR | O_CREAT | O_EXCL | O_DIRECT, 0);
> > > int fd1 = open("./file0, O_RDONLY);
> > > write(fd0, "some_data...", 512);
> > > sendfile(fd0, fd1, NULL, 0x7fffffa7);
> > >   -> this is interesting as it will result in reading data from 'file0' at
> > >      offset X with buffered read and writing them with direct write to
> > >      offset X+512. So this way we'll grow the file up to those ~2GB in
> > >      512-byte chunks.
> > > - not sure if we ever get there but the remainder of the reproducer is:
> > > fd2 = open("./file0", O_RDWR | O_CREAT | O_NOATIME | O_SYNC, 0);
> > > sendfile(fd2, fd0, NULL, 0xffffffff)
> > >   -> doesn't seem too interesting as fd0 is at EOF so this shouldn't do
> > >      anything.
> > > 
> > > Matthew, can you have a look?
> > 
> > Sorry Jan, I've been crazy busy lately and I'm out at training this
> > week. Let me take a look at this and see whether I can determine
> > what's happening here.
> > 
> 
> FYI, syzbot is still seeing this on linux-next.
> 
> Also, a new thread was started to discuss this:
> https://lkml.kernel.org/linux-ext4/20191113180032.GB12013@quack2.suse.cz/T/#u
> (Mentioning this in case anyone is following this thread only.)

Understood. I suppose this issue will get some more traction this
week.

/M
