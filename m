Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526851C499
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 10:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfENIWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 04:22:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36217 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENIWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 04:22:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so7895720plr.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 01:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pQNyZmnkLUqdbsnux8K39fvyz0qGerh/7Car1s/R2uk=;
        b=tWPxjZovh3MyjrxN+cixrW9Jv9/RHjc+lJ7GXmNoQ/Ef7+uMw/qQbTw5B9oFRJByIG
         pu9cyVG7MEJ6Vrt9UDR/0OiBNk3XC3mIME5PnMdl1pxZjgK/yYxMK2jT2bktFIZCLj/9
         rAq5RImK1TNYHhzh3BwnBdJnTscEEXpdoCXCZrYFiBJt6MVyxh9eyaIR+hsmrppBY4Er
         Bq/52n3SPw77fLYMMjIJQxNzhUURTmdWpHo3b3rdN6ULdHR6om48a59eyBuoLr8W0DtP
         VybSOjpmoyAKFiH9TuBHDkyK9+loWcz1WQPsILkxRVCB7AQgy3rXyfsfxyR+sEcpOSQW
         MevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pQNyZmnkLUqdbsnux8K39fvyz0qGerh/7Car1s/R2uk=;
        b=RPnUXPJCaJjP86HDIaOHGSJaCPvW/PLZ/x1NNrmyVK+Ua/fkBQmXXxYcUZx265OyXh
         3w2K+WxfJO4NybBFQk3JzXZKRqOAnu4hmFdwejpyIgwY8RJ0KB6YpqOMPhMBfqGngg4z
         XxDNbtCZbHGWu/CE9urMN2/K1aZu22Jbs3SeK3KVD7Nh+pRYfmTisJ/JxhNbtUlQUsYs
         eUQYdlffmksPxzy+DqDXvTOLHfkoSLBlbcNlJgQ4oK4tpJtWXiznPfdhuPGjWQ5ETsqP
         bmqFC0weTk4WZYxXaNpuR92JrpS3OF+ZiaWoj8g8FUeKHl9vI/R9v1pIBa5QcHqaKqid
         JW3A==
X-Gm-Message-State: APjAAAU+Vq4GBDp+PQU9Au4LDtIkM3uP5HcLNcqf26ckkgqHxshGhccE
        YJYqIzeMaxEp1ZzaQA4Hf+D+5FcbssMcEtfN
X-Google-Smtp-Source: APXvYqxXP9cCuNSrb6ZlkbjUS9VfrgYUq3KTkMgAUQmqTxOMmXPmYuZ0Q7WN0Be8aLpg1XdbhvZmmA==
X-Received: by 2002:a17:902:28ab:: with SMTP id f40mr8616928plb.295.1557822140758;
        Tue, 14 May 2019 01:22:20 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
        by smtp.gmail.com with ESMTPSA id d67sm23500676pfa.35.2019.05.14.01.22.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 01:22:19 -0700 (PDT)
Date:   Tue, 14 May 2019 01:22:14 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190514082214.GB230665@google.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
 <20190507172256.GB5900@mit.edu>
 <4d963cdc-1cbb-35a3-292c-552f865ed1f7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d963cdc-1cbb-35a3-292c-552f865ed1f7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 08, 2019 at 05:58:49PM -0700, Frank Rowand wrote:
> Hi Ted,
> 
> On 5/7/19 10:22 AM, Theodore Ts'o wrote:
> > On Tue, May 07, 2019 at 10:01:19AM +0200, Greg KH wrote:
> Not very helpful to cut the text here, plus not explicitly indicating that
> text was cut (yes, I know the ">>>" will be a clue for the careful reader),
> losing the set up for my question.
> 
> 
> >>> My understanding is that the intent of KUnit is to avoid booting a kernel on
> >>> real hardware or in a virtual machine.  That seems to be a matter of semantics
> >>> to me because isn't invoking a UML Linux just running the Linux kernel in
> >>> a different form of virtualization?
> >>>
> >>> So I do not understand why KUnit is an improvement over kselftest.
> >>>
> >>> It seems to me that KUnit is just another piece of infrastructure that I
> >>> am going to have to be familiar with as a kernel developer.  More overhead,
> >>> more information to stuff into my tiny little brain.
> >>>
> >>> I would guess that some developers will focus on just one of the two test
> >>> environments (and some will focus on both), splitting the development
> >>> resources instead of pooling them on a common infrastructure.
> >>>
> >>> What am I missing?
> >>
> >> kselftest provides no in-kernel framework for testing kernel code
> >> specifically.  That should be what kunit provides, an "easy" way to
> >> write in-kernel tests for things.
> >>
> >> Brendan, did I get it right?
> > 
> > Yes, that's basically right.  You don't *have* to use KUnit.  It's
> 
> If KUnit is added to the kernel, and a subsystem that I am submitting
> code for has chosen to use KUnit instead of kselftest, then yes, I do
> *have* to use KUnit if my submission needs to contain a test for the
> code unless I want to convince the maintainer that somehow my case
> is special and I prefer to use kselftest instead of KUnittest.
> 
> 
> > supposed to be a simple way to run a large number of small tests that
> > for specific small components in a system.
> 
> kselftest also supports running a subset of tests.  That subset of tests
> can also be a large number of small tests.  There is nothing inherent
> in KUnit vs kselftest in this regard, as far as I am aware.
> 
> 
> > For example, I currently use xfstests using KVM and GCE to test all of
> > ext4.  These tests require using multiple 5 GB and 20GB virtual disks,
> > and it works by mounting ext4 file systems and exercising ext4 through
> > the system call interfaces, using userspace tools such as fsstress,
> > fsx, fio, etc.  It requires time overhead to start the VM, create and
> > allocate virtual disks, etc.  For example, to run a single 3 seconds
> > xfstest (generic/001), it requires full 10 seconds to run it via
> > kvm-xfstests.
> > 
> 
> 
> > KUnit is something else; it's specifically intended to allow you to
> > create lightweight tests quickly and easily, and by reducing the
> > effort needed to write and run unit tests, hopefully we'll have a lot
> > more of them and thus improve kernel quality.
> 
> The same is true of kselftest.  You can create lightweight tests in
> kselftest.
> 
> 
> > As an example, I have a volunteer working on developing KUinit tests
> > for ext4.  We're going to start by testing the ext4 extent status
> > tree.  The source code is at fs/ext4/extent_status.c; it's
> > approximately 1800 LOC.  The Kunit tests for the extent status tree
> > will exercise all of the corner cases for the various extent status
> > tree functions --- e.g., ext4_es_insert_delayed_block(),
> > ext4_es_remove_extent(), ext4_es_cache_extent(), etc.  And it will do
> > this in isolation without our needing to create a test file system or
> > using a test block device.
> > 
> 
> > Next we'll test the ext4 block allocator, again in isolation.  To test
> > the block allocator we will have to write "mock functions" which
> > simulate reading allocation bitmaps from disk.  Again, this will allow
> > the test writer to explicitly construct corner cases and validate that
> > the block allocator works as expected without having to reverese
> > engineer file system data structures which will force a particular
> > code path to be executed.
> 
> This would be a difference, but mock functions do not exist in KUnit.
> The KUnit test will call the real kernel function in the UML kernel.
> 
> I think Brendan has indicated a desire to have mock functions in the
> future.
> 
> Brendan, do I understand that correctly?

Oh, sorry, I missed this comment from earlier.

Yes, you are correct. Function mocking is a feature I will be
introducing in a follow up patchset (assuming this one gets merged of
course ;-) ).

Cheers!

> -Frank
> 
> > So this is why it's largely irrelevant to me that KUinit uses UML.  In
> > fact, it's a feature.  We're not testing device drivers, or the
> > scheduler, or anything else architecture-specific.  UML is not about
> > virtualization.  What it's about in this context is allowing us to
> > start running test code as quickly as possible.  Booting KVM takes
> > about 3-4 seconds, and this includes initializing virtio_scsi and
> > other device drivers.  If by using UML we can hold the amount of
> > unnecessary kernel subsystem initialization down to the absolute
> > minimum, and if it means that we can communicating to the test
> > framework via a userspace "printf" from UML/KUnit code, as opposed to
> > via a virtual serial port to KVM's virtual console, it all makes for
> > lighter weight testing.
> > 
> > Why did I go looking for a volunteer to write KUnit tests for ext4?
> > Well, I have a plan to make some changes in restructing how ext4's
> > write path works, in order to support things like copy-on-write, a
> > more efficient delayed allocation system, etc.  This will require
> > making changes to the extent status tree, and by having unit tests for
> > the extent status tree, we'll be able to detect any bugs that we might
> > accidentally introduce in the es tree far more quickly than if we
> > didn't have those tests available.  Google has long found that having
> > these sorts of unit tests is a real win for developer velocity for any
> > non-trivial code module (or C++ class), even when you take into
> > account the time it takes to create the unit tests.
> > 
> > 					- Ted>
> > P.S.  Many thanks to Brendan for finding such a volunteer for me; the
> > person in question is a SRE from Switzerland who is interested in
> > getting involved with kernel testing, and this is going to be their
> > 20% project.  :-)
> > 
> > 
