Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB942C13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 18:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502072AbfFLQVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 12:21:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36806 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437976AbfFLQVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:21:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so11720481qtl.3;
        Wed, 12 Jun 2019 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9EBwbWfsA9jQlfiCxUyc9e2H035Ves6CLXOfri3HY3c=;
        b=sV7Q9pQ5BfY4ghdOP9Q0XQAuEO4teJ16NQq2soC0ZjRUbAOSlRIZFbSU5LilX2fCY1
         QmWOJbWMb6mwyLo5X9BUA/4mN3D/5EEC0JxcILAhOymTk4Jvyin69iSq/3jdBRonpTcE
         76ytq9PpM32r7Dvy/VNW7lKrCAMI1nrRQw3t7pYVOrKbd6kgqF58W2UDG9aMAqVJjtVv
         4c6O7zIO+6+HbUV/OVpcJiSO1s0HE/ay994FzUySe7RwW+ytF7G3HhxYSsLFCQDoZtM1
         MwZrrEpmKSGCBingJmWrVmOI/AliTlbaMk9Z8pVivv7dwC45mnDBa8fA3MKSJ2NO/0b8
         dE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9EBwbWfsA9jQlfiCxUyc9e2H035Ves6CLXOfri3HY3c=;
        b=HLDV11rRl9voqB1EFPiuB9Kj0LiAZdwrLYPOX0baMZj9gTBg53SdFoVFGWaD4Iqqok
         alOzFwMdHPn/JwDFw05OEsb3R86XpNkCs1fB5zlZewCEuXiosn/7VLHzcbPfa0oPc02s
         QtExNGQuXZhYF7uFFyfcxnKUXrpJ9/JM6pFsm2GE5+ZvmdY2oFURaUB02hlBg5G1zlx0
         tM7spomDDoaCU64g6DAlKTKHnIxg0XJrBENsXUdgTGDW72JSSKDFbTGiUfjzC2QktsIl
         nL1QB8XG/jGkjZ+V+GXx9XPh9sQ3dQn4YdIgwqbbcrYNwqzQ5EIS+YYb3YwzcjbRpx87
         ETSg==
X-Gm-Message-State: APjAAAUbr0H5gy/Vp5e2yK2se6rm+4LsXutLNLwNuVvbT/KHX7wKodqI
        z86TBq5SLVF4O8iY6owpQg==
X-Google-Smtp-Source: APXvYqxZApMK6W8Zar2IN27EONCe2VtQ7jzp+fOnM7MS9mn0USyIB/k4W++raMdWD9E7hA0WCVh/Ug==
X-Received: by 2002:ac8:1b2d:: with SMTP id y42mr22428374qtj.202.1560356507411;
        Wed, 12 Jun 2019 09:21:47 -0700 (PDT)
Received: from kmo-pixel ([69.5.123.9])
        by smtp.gmail.com with ESMTPSA id s23sm143068qtj.56.2019.06.12.09.21.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 09:21:46 -0700 (PDT)
Date:   Wed, 12 Jun 2019 12:21:44 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker
 merged)
Message-ID: <20190612162144.GA7619@kmo-pixel>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel>
 <20190611043336.GB14363@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611043336.GB14363@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 11, 2019 at 02:33:36PM +1000, Dave Chinner wrote:
> I just recently said this with reference to the range lock stuff I'm
> working on in the background:
> 
> 	FWIW, it's to avoid problems with stupid userspace stuff
> 	that nobody really should be doing that I want range locks
> 	for the XFS inode locks.  If userspace overlaps the ranges
> 	and deadlocks in that case, they they get to keep all the
> 	broken bits because, IMO, they are doing something
> 	monumentally stupid. I'd probably be making it return
> 	EDEADLOCK back out to userspace in the case rather than
> 	deadlocking but, fundamentally, I think it's broken
> 	behaviour that we should be rejecting with an error rather
> 	than adding complexity trying to handle it.
> 
> So I think this recusive locking across a page fault case should
> just fail, not add yet more complexity to try to handle a rare
> corner case that exists more in theory than in reality. i.e put the
> lock context in the current task, then if the page fault requires a
> conflicting lock context to be taken, we terminate the page fault,
> back out of the IO and return EDEADLOCK out to userspace. This works
> for all types of lock contexts - only the filesystem itself needs to
> know what the lock context pointer contains....

Ok, I'm totally on board with returning EDEADLOCK.

Question: Would we be ok with returning EDEADLOCK for any IO where the buffer is
in the same address space as the file being read/written to, even if the buffer
and the IO don't technically overlap?

This would simplify things a lot and eliminate a really nasty corner case - page
faults trigger readahead. Even if the buffer and the direct IO don't overlap,
readahead can pull in pages that do overlap with the dio.

And on getting EDEADLOCK we could fall back to buffered IO, so userspace would
never know...
