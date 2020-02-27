Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA71117161A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 12:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgB0Lev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 06:34:51 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:41971 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbgB0Leu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:34:50 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8EF9E767F;
        Thu, 27 Feb 2020 06:34:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Feb 2020 06:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        /WM2YZ2D2kC2nX6ey9Dp12UFoyDaBYP6YdN9OBPRzCI=; b=Yi7Xz2yEteTWYyPV
        XuOgGIIUQ4kJyUZ+P4eUHdacFShsL0wlqi3+tYWDcZxIbTMPCZC7kKkKqwBU5Vr7
        mV3KiB80I62eTn/Z/rSMRVA1xKR5HPR6Y1xdqEzpkWYilWVC+139vbvODAqjs7qI
        7b0uh7GsGFpcHQLHdtaaFmkJ1qlEFr9kI0BkpSTfrSOiARZh/QwJJHcLBVtQZKxX
        i1RfGu7DmtV2Bg70Kio8NgCh2vcKbQtRXopRbQ3V18BNBKmEtknX04jdAu08Eu+P
        ilek2b0di/g2LaR09sNv/kyhUqcmRmz7rMJZarFmIFokUN4uKZpCZu3trRfGXC59
        NNO0bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=/WM2YZ2D2kC2nX6ey9Dp12UFoyDaBYP6YdN9OBPRz
        CI=; b=WXQ+Btytbj9wM9gplu/g8YR5EqjlaOsQPw5KeiKVENv41/rQtbwUg/X5d
        PButX8I33urqRP1cPco2dE+wZC5vG0swH4LEJZ21VW8y3tX/MnZm9wG2Dy1+MRVX
        Nik9U2eNrcc0HaG8bY5LvA4y/ADSdAFXr0WO7+BfP9A14XeDgyOA0u07mx2GO5eI
        Qr4FyHIneaBtJD4Gqxgn8/kxyeJc7DIGYXk79iRNCSPHF7XeTxiV/8rTv820i3lO
        nHTtL9EFn6lS9wNqQM035aMxDCxmTFEIMPFKsOPfi0bdxKEf1ccOCDfiLhMazt01
        y7jlQF8Bx81Qz/oCfTFEdbFNocLdQ==
X-ME-Sender: <xms:WKlXXpwoBSSMIpNx92ZIjGKMr7LeHNUzTuUOuinSM_HyHQWj-GJltA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeigdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    dukedvrdeludenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:WKlXXkZjZSe1NR_ge1ViMtyXdZbwwq2UcNhnv61CqhxmT7A-B8l49A>
    <xmx:WKlXXtpYWO0zIoajim09iFfr1ZFgKsuj86KKjpYJzqOgoIfV7-Ctnw>
    <xmx:WKlXXoGoMgITJUdXzGKgSOrUBFWfHHWjUPULTtlks3eR4oEgBSY9eg>
    <xmx:WalXXjbUuSjsDmVLDFkg-xH65BT7NdSKqxPbcE61UlYxpJihRGOEnA>
Received: from mickey.themaw.net (unknown [118.209.182.91])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5464C328005A;
        Thu, 27 Feb 2020 06:34:44 -0500 (EST)
Message-ID: <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Feb 2020 19:34:40 +0800
In-Reply-To: <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
         <1582316494.3376.45.camel@HansenPartnership.com>
         <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
         <1582556135.3384.4.camel@HansenPartnership.com>
         <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
         <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
         <1582644535.3361.8.camel@HansenPartnership.com>
         <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
         <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
         <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-02-27 at 10:36 +0100, Miklos Szeredi wrote:
> On Thu, Feb 27, 2020 at 6:06 AM Ian Kent <raven@themaw.net> wrote:
> 
> > At the least the question of "do we need a highly efficient way
> > to query the superblock parameters all at once" needs to be
> > extended to include mount table enumeration as well as getting
> > the info.
> > 
> > But this is just me thinking about mount table handling and the
> > quite significant problem we now have with user space scanning
> > the proc mount tables to get this information.
> 
> Right.
> 
> So the problem is that currently autofs needs to rescan the proc
> mount
> table on every change.   The solution to that is to

Actually no, that's not quite the problem I see.

autofs handles large mount tables fairly well (necessarily) and
in time I plan to remove the need to read the proc tables at all
(that's proven very difficult but I'll get back to that).

This has to be done to resolve the age old problem of autofs not
being able to handle large direct mount maps. But, because of
the large number of mounts associated with large direct mount
maps, other system processes are badly affected too.

So the problem I want to see fixed is the effect of very large
mount tables on other user space applications, particularly the
effect when a large number of mounts or umounts are performed.

Clearly large mount tables not only result from autofs and the
problems caused by them are slightly different to the mount and
umount problem I describe. But they are a problem nevertheless
in the sense that frequent notifications that lead to reading
a large proc mount table has significant overhead that can't be
avoided because the table may have changed since the last time
it was read.

It's easy to cause several system processes to peg a fair number
of CPU's when a large number of mounts/umounts are being performed,
namely systemd, udisks2 and a some others. Also I've seen couple
of application processes badly affected purely by the presence of
a large number of mounts in the proc tables, that's not quite so
bad though.

> 
>  - add a notification mechanism   - lookup a mount based on path
>  - and a way to selectively query mount/superblock information
based on path ...
> 
> right?
> 
> For the notification we have uevents in sysfs, which also supplies
> the
> changed parameters.  Taking aside namespace issues and addressing
> mounts would this work for autofs?

The parameters supplied by the notification mechanism are important.

The place this is needed will be libmount since it catches a broad
number of user space applications, including those I mentioned above
(well at least systemd, I think also udisks2, very probably others).

So that means mount table info. needs to be maintained, whether that
can be achieved using sysfs I don't know. Creating and maintaining
the sysfs tree would be a big challenge I think.

But before trying to work out how to use a notification mechanism
just having a way to get the info provided by the proc tables using
a path alone should give initial immediate improvement in libmount.

Ian

