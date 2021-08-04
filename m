Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449073DF901
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 02:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhHDAt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 20:49:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47784 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229878AbhHDAtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 20:49:55 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1740nTfV026154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Aug 2021 20:49:29 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EB7B915C3DEA; Tue,  3 Aug 2021 20:49:28 -0400 (EDT)
Date:   Tue, 3 Aug 2021 20:49:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        zajec5@gmail.com, "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <YQnkGMxZCgCWXQPf@mit.edu>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <YQnHxIU+EAAxIjZA@mit.edu>
 <YQnU5m/ur+0D5MfJ@casper.infradead.org>
 <YQnZgq3gMKGI1Nig@mit.edu>
 <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 05:10:22PM -0700, Linus Torvalds wrote:
> The user-space FUSE thing does indeed work reasonably well.
> 
> It performs horribly badly if you care about things like that, though.
> 
> In fact, your own numbers kind of show that:
> 
>   ntfs/default: 670 tests, 55 failures, 211 skipped, 34783 seconds
>   ntfs3/default: 664 tests, 67 failures, 206 skipped, 8106 seconds
> 
> and that's kind of the point of ntfs3.

Sure, although if you run fstress in parallel ntfs3 will lock up, the
system hard, and it has at least one lockdep deadlock complaints.
It's not up to me, but personally, I'd feel better if *someone* at
Paragon Software responded to Darrrick and my queries about their
quality assurance, and/or made commitments that they would at least
*try* to fix the problems that about 5 minutes of testing using
fstests turned up trivially.

I can even give them patches and configsto make it trivially easy for
them to run fstests using KVM or GCE....

				- Ted
