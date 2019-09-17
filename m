Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4B4B51BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfIQPof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 11:44:35 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:34667 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbfIQPoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:44:34 -0400
Received: by mail-lj1-f182.google.com with SMTP id h2so4078009ljk.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eMaYS49lFbgSsohx/uto7SYiN/yZPj6/KF2SZpjDYK8=;
        b=SKDk8ecQiMfhg/s7AWxDyMGMZQ2k4vJZG8shoor+7UtbczHHnipC9orRcO6b0BQAxR
         p1Hgpp5ldSGDT/ZVoV3WNQdtgXAqHlFda2X1OEPsrQw8wNEFR6kZUX72qKx6By7hD0fz
         i7A4lEG4QZWp6hPNDw9XSc9N3MndLYi4hP3o9YjjDgcpNmYXqIGmpqklMewm7NwgB3dB
         JQrZeIdACZ/tE6x2d3corihot/sfrJhkLQ7C1bpS/Ktt7IDreaYHxB4xxJCmkZfG8WuA
         ZRbWok5YftdTgmOVuWEVd6HHdxV1tLJ3mB8Vga0VdHB0Gr3R5PNjBJorgjdMW8NdDw57
         TFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eMaYS49lFbgSsohx/uto7SYiN/yZPj6/KF2SZpjDYK8=;
        b=iWm4oX75JOg/EShvBKyqR9RMBwpgNo50BBrRNZhYwDfJfGm8w9UeBQSxtCP8bc+HFN
         LC0mUsSpF01TQEv4pdnw3/EgLT4YiIXt/qvc/CygBYEup5Z0IxySZOV6KAooavzLYnld
         p8okXZPgDa83NnvNtKqnIujZPjZMPuouzaZ+YwNJzLr7TADDLNqf0tQ5BJxOE4gzPdJ+
         G1N4qK+Ar6Gbfr4ulviROWB9B1xKmzVPqFBArBdhTDxDAvAmNsegDzXpub9JqXOCBSGr
         tZEbiAjkhhKP5/WnQz8zA81HFsKQKA/H3xFFH/uPF8XfVZlNlXx2OC/9djTwAhwPprT4
         fg1w==
X-Gm-Message-State: APjAAAUXEBGvUxIFxozbGFTCohx/TU7KCdI2l+bKj2bPz2RcXvZx6LjC
        +Gj0IW62SdjCjPZGasKwFBo97REGp9G8tM/Fa/I=
X-Google-Smtp-Source: APXvYqzHC4gvmHF+4+hZcEKW8VJaJ9j6GKKYUUsyEG6t+vQOzPZoDjjycdvjQJg1qq6D02a5zvwTJePh6OKmjEipnQk=
X-Received: by 2002:a2e:7f07:: with SMTP id a7mr2288400ljd.173.1568734697229;
 Tue, 17 Sep 2019 08:38:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:e00f:0:0:0:0:0 with HTTP; Tue, 17 Sep 2019 08:38:16
 -0700 (PDT)
In-Reply-To: <20190917125423.GE6762@mit.edu>
References: <CAARcW+r3EvFktaw-PfxN_V-EjtU6BvT7wxNvUtFiwHOdbNn2iA@mail.gmail.com>
 <bfa92367-f96a-8a4e-71c7-885956e10d0e@sandeen.net> <CAARcW+pLLABT9sq5LHykKmrcNjct8h64_6ePKeVGsOzeLgG8Tg@mail.gmail.com>
 <20190917125423.GE6762@mit.edu>
From:   Daegyu Han <hdg9400@gmail.com>
Date:   Wed, 18 Sep 2019 00:38:16 +0900
Message-ID: <CAARcW+oHoUEf7qrehcV_C8hZj05HPiGEpwkY48yipHntJDAHsw@mail.gmail.com>
Subject: Re: Sharing ext4 on target storage to multiple initiators using NVMeoF
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for the clear explanation.

Best regards,

Daegyu

2019-09-17 21:54 GMT+09:00, Theodore Y. Ts'o <tytso@mit.edu>:
> On Tue, Sep 17, 2019 at 09:44:00AM +0900, Daegyu Han wrote:
>> It started with my curiosity.
>> I know this is not the right way to use a local filesystem and someone
>> would feel weird.
>> I just wanted to organize the situation and experiment like that.
>>
>> I thought it would work if I flushed Node B's cached file system
>> metadata with the drop cache, but I didn't.
>>
>> I've googled for something other than the mount and unmount process,
>> and I saw a StackOverflow article telling file systems to sync via
>> blockdev --flushbufs.
>>
>> So I do the blockdev --flushbufs after the drop cache.
>> However, I still do not know why I can read the data stored in the
>> shared storage via Node B.
>
> There are many problems, but the primary one is that Node B has
> caches.  If it has a cached version of the inode table block, why
> should it reread it after Node A has modified it?  Also, the VFS also
> has negative dentry caches.  This is very important for search path
> performance.  Consider for example the compiler which may need to look
> in many directories for a particular header file.  If the C program has:
>
> #include "amazing.h"
>
> The C compiler may need to look in a dozen or more directories trying
> to find the header file amazing.h.  And each successive C compiler
> process will need to keep looking in all of those same directories.
> So the kernel will keep a "negative cache", so if
> /usr/include/amazing.h doesn't exist, it won't ask the file system
> when the 2nd, 3rd, 4th, 5th, ... compiler process tries to open
> /usr/include/amazing.h.
>
> You can disable all of the caches, but that makes the file system
> terribly, terribly slow.  What network file systems will do is they
> have schemes whereby they can safely cache, since the network file
> system protocol has a way that the client can be told that their
> cached information must be reread.  Local disk file systems don't have
> anything like this.
>
> There are shared-disk file systems that are designed for
> multi-initiator setups.  Examples of this include gfs and ocfs2 in
> Linux.  You will find that they often trade performance for
> scalability to support multiple initiators.
>
> You can use ext4 for fallback schemes, where the primary server has
> exclusive access to the disk, and when the primary dies, the fallback
> server can take over.  The ext4 multi-mount protection scheme is
> designed for those sorts of use cases, and it's used by Lustre
> servers.  But only one system is actively reading or writing to the
> disk at a time, and the fallback server has to replay the journal, and
> assure that primary server won't "come back to life".  Those are
> sometimes called STONITH schemes ("shoot the other node in the head"),
> and might involve network controlled power strips, etc.
>
> Regards,
>
> 						- Ted
>
