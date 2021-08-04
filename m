Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01DA3E05F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbhHDQbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 12:31:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46132 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237566AbhHDQbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:31:14 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 174GUefr026063
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Aug 2021 12:30:41 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8AB6815C37C1; Wed,  4 Aug 2021 12:30:40 -0400 (EDT)
Date:   Wed, 4 Aug 2021 12:30:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        zajec5@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <YQrAsGBmVeKQp+Z9@mit.edu>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <YQnHxIU+EAAxIjZA@mit.edu>
 <YQnU5m/ur+0D5MfJ@casper.infradead.org>
 <YQnZgq3gMKGI1Nig@mit.edu>
 <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com>
 <YQnkGMxZCgCWXQPf@mit.edu>
 <20210804010351.GM3601466@magnolia>
 <20210804063810.dvnqgxnaoajy3ehe@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804063810.dvnqgxnaoajy3ehe@kari-VirtualBox>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 04, 2021 at 09:38:10AM +0300, Kari Argillander wrote:
> Konstantin has wrote about these thing see below.
> 
> Source:
> https://lore.kernel.org/linux-fsdevel/7538540ab82e4b398a0203564a1f1b23@paragon-software.com/

Thanks for the link; that's really helpful.

> I'm just bringing this thing up because so many has asked and Konstantin
> has not responded recently. Hopefully he will soon. Of course is it
> little bit worrying that example generic/013 still fails after almoust
> year has passed and Konstantin said he is working on it. And it seems that
> more tests fails than beginning of review process.

Also interesting is that back in August 2020 Konstantin had promised
that they would be publishing their own fsck and mkfs tools.
Personally, I consider having a strong set of file system utilities to
be as important, if not more important, than the kernel code.  Perhaps
there are licensing issues which is why he hasn't been able to make
his code available?

One thing which I wonder about is whether there is anyone other than
Konstantin which is working on ntfs3?  I'm less concerned about
specific problems about the *code* --- I'll let folks like Christoph,
Dave, and Al weigh in on that front.

I'm more concerned about the long term sustainability and
maintainibility of the effort.  Programming is a team sport, and this
is especially true in the file system.  If you look at the successful
file systems, there are multiple developers involved, and ideally,
those developers work for a variety of different companies.  This way,
if a particular file system developer gets hit by a bus, laid low with
COVD-19, or gets laid off by their company due to changing business
strategies, or just decides to accept a higher paying job elsewhere,
the file system can continue to be adequately supported upstream.

If Konstantin really is the only developer working on ntfs3, that may
very well explain why generic/013 failures have been unaddressed in
over a year.  Which is why I tend to be much more concerned about
development community and development processes than just the quality
and maturity of the code.  If you have a good community and
development processes, the code qualtiy will follow.  If you don't,
that tends to be a recipe for eventual failure.

There are a large number of people on the cc line, include from folks
like Red Hat, SuSE, etc.  It would be *great* to hear that they are
also working on ntfs3, and it's not just a one engineer show.  (Also,
given the deadlock problems, lack of container compatibility, etc.,
are the Linux distros actually planning on shipping ntfs3 to their
customers?  Are they going to help make ntfs3 suitable for customers
with access to their help desks?)

> > > I can even give them patches and configs to make it trivially easy for
> > > them to run fstests using KVM or GCE....

I've since posted RFC patches to the fstests list to allow other
people to run xfstests on ntfs3.  I don't know why Konstantin hadn't
published his patches to fstests a year ago --- perhaps because of
licensing concerns with the mkfs and fsck userspace programs which
Paragon Software is using?

My fstests patches use the mkfs.ntfs and ntfsfix which ships with the
ntfs-3g package.  They are not ideal; for example ntfsfix will not
detect or fix all problems, and it is documented that for some issues,
you have to boot into Windows and run CHKDSK.  But it is the only
thing that is going to be available for any **users** of ntfs3 outside
of Paragon Software.

Some kind of update from Paragon Software about when their versions of
{mkfs,fsck}.ntfs might be made available for Linux distributions to
use would certainly be enlightening.

					- Ted
