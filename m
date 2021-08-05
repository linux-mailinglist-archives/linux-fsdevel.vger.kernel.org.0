Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5D3E189F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbhHEPsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 11:48:53 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:51810 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242016AbhHEPsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:48:53 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 2319A1F9B;
        Thu,  5 Aug 2021 18:48:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1628178517;
        bh=epeSWkZAOGd13DhgazWf/4E+OlVgHpyPhbZ/y2BOlIc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=oh4+CHHD7M9Kv2JH1m8vFxb2a5v2eqTt2tj35coiaU73j84PhMnW3Ds6RC9Ardoj4
         9WljMm/mt2rwNU/pcZdmFQroCR1Hr/lYhW1PnvPIMZcgyehpTTDkAs2T/2P52s/t9L
         fLoo1oYJsLYOXwy8Djgs5ybZ+eeExu0HFC3qBwe0=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 18:48:36 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.2176.009; Thu, 5 Aug 2021 18:48:36 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: RE: [GIT PULL] vboxsf fixes for 5.14-1
Thread-Topic: [GIT PULL] vboxsf fixes for 5.14-1
Thread-Index: AQHXd9Q0d6WirG0Ih0y0eIuA7j/DOatBFNyAgAAQcQCAAPTFAIAAQ2AAgAATA4CAAAGlAIAAA7AAgALYuICAAGpsgIAcmIIAgAAPpwCAAAV/AIAAAbIAgAAK7QCAAAQEgIACXTsA
Date:   Thu, 5 Aug 2021 15:48:36 +0000
Message-ID: <0e175373cef24e2abe76e203bb36d260@paragon-software.com>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <YQnHxIU+EAAxIjZA@mit.edu> <YQnU5m/ur+0D5MfJ@casper.infradead.org>
 <YQnZgq3gMKGI1Nig@mit.edu>
 <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com>
 <YQnkGMxZCgCWXQPf@mit.edu> <20210804010351.GM3601466@magnolia>
In-Reply-To: <20210804010351.GM3601466@magnolia>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.0.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Darrick J. Wong <djwong@kernel.org>
> Sent: Wednesday, August 4, 2021 4:04 AM
> To: Theodore Ts'o <tytso@mit.edu>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>; Matthew Wilcox <willy=
@infradead.org>; Leonidas P. Papadakos
> <papadakospan@gmail.com>; Konstantin Komarov <almaz.alexandrovich@paragon=
-software.com>; zajec5@gmail.com; Greg Kroah-
> Hartman <gregkh@linuxfoundation.org>; Hans de Goede <hdegoede@redhat.com>=
; linux-fsdevel <linux-fsdevel@vger.kernel.org>;
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Al Viro <viro@z=
eniv.linux.org.uk>
> Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
>=20
> On Tue, Aug 03, 2021 at 08:49:28PM -0400, Theodore Ts'o wrote:
> > On Tue, Aug 03, 2021 at 05:10:22PM -0700, Linus Torvalds wrote:
> > > The user-space FUSE thing does indeed work reasonably well.
> > >
> > > It performs horribly badly if you care about things like that, though=
.
> > >
> > > In fact, your own numbers kind of show that:
> > >
> > >   ntfs/default: 670 tests, 55 failures, 211 skipped, 34783 seconds
> > >   ntfs3/default: 664 tests, 67 failures, 206 skipped, 8106 seconds
> > >
> > > and that's kind of the point of ntfs3.
> >
> > Sure, although if you run fstress in parallel ntfs3 will lock up, the
> > system hard, and it has at least one lockdep deadlock complaints.
> > It's not up to me, but personally, I'd feel better if *someone* at
> > Paragon Software responded to Darrrick and my queries about their
> > quality assurance, and/or made commitments that they would at least
> > *try* to fix the problems that about 5 minutes of testing using
> > fstests turned up trivially.
>=20
> <cough> Yes, my aim was to gauge their interest in actively QAing the
> driver's current problems so that it doesn't become one of the shabby
> Linux filesystem drivers, like <cough>ntfs.
>=20
> Note I didn't even ask for a particular percentage of passing tests,
> because I already know that non-Unix filesystems fail the tests that
> look for the more Unix-specific behaviors.
>=20
> I really only wanted them to tell /us/ what the baseline is.  IMHO the
> silence from them is a lot more telling.  Both generic/013 and
> generic/475 are basic "try to create files and read and write data to
> them" exercisers; failing those is a red flag.
>=20

Hi Darrick and Theodore! First of all, apologies for the silence on your qu=
estions.
Let me please clarify and summarize the QA topic for you.

The main thing to outline is that: we have the number of autotests executed
for ntfs3 code. More specifically, we are using TeamCity as our CI tool, wh=
ich
is handling autotests. Those are being executed against each commit to the
ntfs3 codebase.

Autotests are divided into the "promotion" levels, which are quite standard=
:
L0, L1, L2. Those levels have the division from the shortest "smoke" (L0)
to the longest set (L2). This we need to cover the ntfs3 functionality with
tests under given amount of time (feedback loop for L0 is minutes, while fo=
r
L2 is up to 24hrs).

As for suites we are using - it is the mix of open/well known suites:
- xfstests, ltp, pjd suite, fsx, dirstress, fstorture - those are of known =
utilites/suites
And number of internal autotests which were developed for covering various =
parts of
fs specs, regression autotests which are introduced to the infrastructure a=
fter bugfixes
and autotests written to test the driver operation on various data sets.

This approach is settled in Paragon for years, and ntfs3, from the first li=
ne of code written,
is being developed this way. You may refer the artifacts linked below, wher=
e the progress/coverage
during the last year is spoken by autotest results:

the 27th patch-series code (July'2021):=20
https://dl.paragon-software.com/ntfs3/p27_tests.tar
25th (March'2021):
https://dl.paragon-software.com/ntfs3/p25_tests.tar
2nd (August, 2020):
https://dl.paragon-software.com/ntfs3/p2_tests.tar

Those are results on ntfs3 ran within the 'linux-next' (the most recent one=
 given the tests start date)
As may be observed, we never skipped the "tests day" :)

There is a note should be provided on xfstests specifically. We have been u=
sing this suite
as a part of our autotests for several years already. However the suite ori=
ginate for Linux
native file systems and a lot of cases are not applicable to the NTFS. This=
 is one of the reasons
why some of "red-flag" failures are there (e.g. generic/475) - they were ex=
cluded at some point of time
and we've missed to enable it back when it was the time :)

Thank you all for this effort to run and look closer on our code, on the ne=
xt patchset, the
91, 317 and 475 should be resolved. And now we are looking up to other excl=
uded tests to find out more of such.

Hope this will resolve some of your concerns.

> --D
>=20
> > I can even give them patches and configsto make it trivially easy for
> > them to run fstests using KVM or GCE....
> >
> > 				- Ted
