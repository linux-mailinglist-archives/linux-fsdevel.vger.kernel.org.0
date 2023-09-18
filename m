Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D293D7A5434
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 22:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjIRUe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 16:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIRUe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:34:26 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E74B6
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 13:34:21 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 38IKXQ0J1708850
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 18 Sep 2023 13:33:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 38IKXQ0J1708850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1695069211;
        bh=Xq1BpfVZL3W4xv3SzKlLmP2NbrilOBD8XdeK58PoqgY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=nfeenvONH+MXsV3D1F076tXfcae5uJqqkegnmOu8gwgeUYfpxsLrOXNpxNdl92MU7
         iPo2A4/hpmZvhA6Xtjuc81pBSh1MSml7N92Z56tYbH7cWyxVMa3ogyr6UOSjQeatyL
         xt9sgYJ9xF/n/oDL+1VozAVdGwi7ZJeIA6IAnGWNSihPDu3pgMys16uhZUZEI6h7Nm
         xchzwnoDWQAR5a4EyxS89462kUG/B6OM6JCtNRZxCWwLMFZ+xnqEQ4WtXyeI2Er/is
         H6ulotojz3I5OwQ6vi+atn8u6Rz/pF1jJyJAzC5L1do8d1J6UK6+st+q1s4aCim0Hz
         GJxv1N1LcPbHw==
Date:   Mon, 18 Sep 2023 13:33:23 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        NeilBrown <neilb@suse.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
User-Agent: K-9 Mail for Android
In-Reply-To: <nycvar.YFH.7.76.2309182127480.14216@cbobk.fhfr.pm>
References: <ZPlFwHQhJS+Td6Cz@dread.disaster.area> <20230907071801.1d37a3c5@gandalf.local.home> <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net> <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com> <ZQTfIu9OWwGnIT4b@dread.disaster.area> <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com> <169491481677.8274.17867378561711132366@noble.neil.brown.name> <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com> <20230917185742.GA19642@mit.edu> <CAHk-=wjHarh2VHgM57D1Z+yPFxGwGm7ubfLN7aQCRH5Ke3_=Tg@mail.gmail.com> <20230918111402.7mx3wiecqt5axvs5@quack3> <CAHk-=whB5mjPnsvBZ4vMn7A4pkXT9a5pk4vjasPOsSvU-UNdQg@mail.gmail.com> <nycvar.YFH.7.76.2309182127480.14216@cbobk.fhfr.pm>
Message-ID: <9569DF2A-343D-4E87-B78A-104C39DC6D68@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On September 18, 2023 12:32:05 PM PDT, Jiri Kosina <jikos@kernel=2Eorg> wro=
te:
>On Mon, 18 Sep 2023, Linus Torvalds wrote:
>
>> But mmap() is *not* important for a filesystem that is used just for=20
>> data transport=2E I bet that FAT is still widely used, for example, and=
=20
>> while exFAT is probably making inroads, I suspect most of us have used =
a=20
>> USB stick with a FAT filesystem on it in the not too distant past=2E Ye=
t I=20
>> doubt we'd have ever even noticed if 'mmap' didn't work on FAT=2E Becau=
se=20
>> all you really want for data transport is basic read/write support=2E
>
>I am afraid this is not reflecting reality=2E
>
>I am pretty sure that "give me that document on a USB stick, and I'll tak=
e=20
>a look" leads to using things like libreoffice (or any other editor liked=
=20
>by general public) to open the file directly on the FAT USB stick=2E And=
=20
>that's pretty much guaranteed to use mmap()=2E
>

I mean=2E=2E=2E fopen() on Linux optionally uses mmap()=2E=2E=2E and it us=
ed to do so unconditionally, even=2E mmap() is a good match for stdio (at l=
east the input side), so it is a reasonable thing to do=2E
