Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E11253F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 21:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfLRU7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 15:59:09 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35015 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfLRU7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:59:08 -0500
X-Originating-IP: 92.243.9.8
Received: from localhost (joshtriplett.org [92.243.9.8])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id DB3841C0003;
        Wed, 18 Dec 2019 20:59:02 +0000 (UTC)
Date:   Wed, 18 Dec 2019 12:59:02 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Akemi Yagi <toracat@elrepo.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        DJ Delorie <dj@redhat.com>, David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
Message-ID: <20191218205731.GA8723@localhost>
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz>
 <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <CAKfTPtDBtPuvK0NzYC0VZgEhh31drCDN=o+3Hd3fUwoffQg0fw@mail.gmail.com>
 <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com>
 <CABA31DqGSycoE2hxk92NZ8qb47DqTR0+UGMQN_or1zpoGCg9fw@mail.gmail.com>
 <CAHk-=wjnXUUbYikSFba5QqvJoFnO8c_ykXrw9Zz2Lt4SeyeZUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjnXUUbYikSFba5QqvJoFnO8c_ykXrw9Zz2Lt4SeyeZUQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 09, 2019 at 10:18:57AM -0800, Linus Torvalds wrote:
> On Mon, Dec 9, 2019 at 9:57 AM Akemi Yagi <toracat@elrepo.org> wrote:
> >
> > In addition to the Fedora make-4.2.1-4.fc27 (1) mentioned by Linus,
> > RHEL 8 make-4.2.1-9.el8 (2) is affected. The patch applied to Fedora
> > make (3) has been confirmed to fix the issue in RHEL's make.
> >
> > Those are the only real-world examples I know of. I have no idea how
> > widespread this thing is...
> 
> Looks like opensuse and ubuntu are also on 4.2.1 according to
> 
>    https://software.opensuse.org/package/make
>    https://packages.ubuntu.com/cosmic/make
> 
> so apparently the bug is almost universal with the big three sharing
> this buggy version.

Debian and Ubuntu have make 4.2.1-1.2, which includes "[SV 51159] Use a
non-blocking read with pselect to avoid hangs." and various other fixes.
https://metadata.ftp-master.debian.org/changelogs/main/m/make-dfsg/make-dfsg_4.2.1-1.2_changelog
So, both Debian and Ubuntu should be fine with the pipe improvements.
(I'm testing that now.)

Is the version of your non-thundering-herd pipe wakeup patch attached to
https://lore.kernel.org/lkml/CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com/
still the best version to test performance with?
