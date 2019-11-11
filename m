Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F3BF6F99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 09:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKIQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 03:16:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37580 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfKKIQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:16:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id g8so3304999plt.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 00:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ab0kK2oHM6lO8iZ9R6h+DRnRFocI2oaYPhhXxQ1txf0=;
        b=z3Ov0zrW5pKVWZiuX6afIe1HwcGBXL/ZAOrf/X3AcxbxxjQQRyh1bY13fCTnXI/DMs
         BqrRHko3WrBeGVhxfHD33oIaBUnZoBUhHbrFwp+BaYeLbsEuFJZABnk41EK/gi7kULeN
         LjSZoU9GbUDaYOXwXSSvFewWFcmum4yLoN05nG6B4YR6RImXmmszM46C1hqOQ4iTtiWE
         2OkOxxf1t+15SWU4xeB9bvtmf8B4lX2oBZe5+C6sxsJXw9T55dg5rB/EQIElzaeJGNTw
         FFr3aYZE6VkOspuPwdNzNlnwUafWckN4kR7PoJ+tQNgKjYCIPtcJZR0wRQwJRp1FqgC2
         9/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ab0kK2oHM6lO8iZ9R6h+DRnRFocI2oaYPhhXxQ1txf0=;
        b=pgQc9Wv/lN9/wFu1KQ7FXcBLa2eDfqnYOop+G9Bt0NW4CjTjlJKhS5cKdjJKMbgjxM
         KFWWE8r+3B5Wt2dqmpEmin8eZD8uG/8WmoSU9h9XPCD6NxYqSJKwkVCZcUKc347Sh93E
         S/fjuKnyqw34Rys8z3F+SJC7LEupBeEFiwRn8KhwQwaTCBgm6TzbuTSm5qVhT5tKtbzR
         Xdaf6DjhKrQihBalDsfnciK69O+dX7QOlQsRS8hddPeTCRVZxCSMmUPSOuhKHskpEnxe
         8qDfZPAikcwhgP21Boe3DC1nIQmkhkYCNMeu90R3iWpCGBzlqBZajTtxzR5aAMJo9Cvo
         s6MA==
X-Gm-Message-State: APjAAAWo2tsnh7xfc4ZVmHHpCF1dtXmS/guGNVSqiqcch5R3oZyo2AbD
        4bnkpE2chJp75qwsoCWE3enF
X-Google-Smtp-Source: APXvYqzDnT6gQYZ42is73xOlBKBgkqM0AarxPX+1UqoPZg2hvePO/xVhfBGiay3u77CDH/cIElpiIA==
X-Received: by 2002:a17:902:7c8c:: with SMTP id y12mr24542085pll.260.1573460197164;
        Mon, 11 Nov 2019 00:16:37 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id 12sm16086321pjm.11.2019.11.11.00.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:16:36 -0800 (PST)
Date:   Mon, 11 Nov 2019 19:16:29 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+991400e8eba7e00a26e1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        riteshh@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Subject: Re: WARNING in iov_iter_pipe
Message-ID: <20191111081628.GB14058@bobrowski>
References: <000000000000d60aa50596c63063@google.com>
 <20191108103148.GE20863@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108103148.GE20863@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 08, 2019 at 11:31:48AM +0100, Jan Kara wrote:
> On Thu 07-11-19 10:54:10, syzbot wrote:
> > syzbot found the following crash on:
> > 
> > HEAD commit:    c68c5373 Add linux-next specific files for 20191107
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13d6bcfce00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=742545dcdea21726
> > dashboard link: https://syzkaller.appspot.com/bug?extid=991400e8eba7e00a26e1
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1529829ae00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a55c0ce00000
> > 
> > The bug was bisected to:
> > 
> > commit b1b4705d54abedfd69dcdf42779c521aa1e0fbd3
> > Author: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > Date:   Tue Nov 5 12:01:37 2019 +0000
> > 
> >     ext4: introduce direct I/O read using iomap infrastructure
> 
> Hum, interesting and from the first looks the problem looks real.
> Deciphered reproducer is:
> 
> int fd0 = open("./file0", O_RDWR | O_CREAT | O_EXCL | O_DIRECT, 0);
> int fd1 = open("./file0, O_RDONLY);
> write(fd0, "some_data...", 512);
> sendfile(fd0, fd1, NULL, 0x7fffffa7);
>   -> this is interesting as it will result in reading data from 'file0' at
>      offset X with buffered read and writing them with direct write to
>      offset X+512. So this way we'll grow the file up to those ~2GB in
>      512-byte chunks.
> - not sure if we ever get there but the remainder of the reproducer is:
> fd2 = open("./file0", O_RDWR | O_CREAT | O_NOATIME | O_SYNC, 0);
> sendfile(fd2, fd0, NULL, 0xffffffff)
>   -> doesn't seem too interesting as fd0 is at EOF so this shouldn't do
>      anything.
> 
> Matthew, can you have a look?

Sorry Jan, I've been crazy busy lately and I'm out at training this
week. Let me take a look at this and see whether I can determine
what's happening here.

/M
