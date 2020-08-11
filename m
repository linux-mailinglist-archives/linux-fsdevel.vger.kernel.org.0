Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BDC2417F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgHKIJR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 04:09:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:44165 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727998AbgHKIJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:09:17 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-6-6yjApz6GO-e2kdqAupHRLw-1; Tue, 11 Aug 2020 09:09:13 +0100
X-MC-Unique: 6yjApz6GO-e2kdqAupHRLw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 11 Aug 2020 09:09:10 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 11 Aug 2020 09:09:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?iso-8859-1?Q?=27Micka=EBl_Sala=FCn=27?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Eric Biggers" <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?iso-8859-1?Q?Philippe_Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        "Scott Shell" <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v7 0/7] Add support for O_MAYEXEC
Thread-Topic: [PATCH v7 0/7] Add support for O_MAYEXEC
Thread-Index: AQHWb1PwbfAzth+cK0yvrOzhTaEjE6kx5WiAgAAMbuyAAJu5IA==
Date:   Tue, 11 Aug 2020 08:09:10 +0000
Message-ID: <26a4a8378f3b4ad28eaa476853092716@AcuMS.aculab.com>
References: <20200723171227.446711-1-mic@digikod.net>
 <202007241205.751EBE7@keescook>
 <0733fbed-cc73-027b-13c7-c368c2d67fb3@digikod.net>
 <20200810202123.GC1236603@ZenIV.linux.org.uk>
 <30b8c003f49d4280be5215f634ca2c06@AcuMS.aculab.com>
 <20200810222838.GF1236603@ZenIV.linux.org.uk>
 <2531a0e8-5122-867c-ba06-5d2e623a3834@digikod.net>
In-Reply-To: <2531a0e8-5122-867c-ba06-5d2e623a3834@digikod.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 11/08/2020 00:28, Al Viro wrote:
> > On Mon, Aug 10, 2020 at 10:09:09PM +0000, David Laight wrote:
> >>> On Mon, Aug 10, 2020 at 10:11:53PM +0200, Mickaël Salaün wrote:
> >>>> It seems that there is no more complains nor questions. Do you want me
> >>>> to send another series to fix the order of the S-o-b in patch 7?
> >>>
> >>> There is a major question regarding the API design and the choice of
> >>> hooking that stuff on open().  And I have not heard anything resembling
> >>> a coherent answer.
> >>
> >> To me O_MAYEXEC is just the wrong name.
> >> The bit would be (something like) O_INTERPRET to indicate
> >> what you want to do with the contents.
> 
> The properties is "execute permission". This can then be checked by
> interpreters or other applications, then the generic O_MAYEXEC name.

The english sense of MAYEXEC is just wrong for what you are trying
to check.

> > ... which does not answer the question - name of constant is the least of
> > the worries here.  Why the hell is "apply some unspecified checks to
> > file" combined with opening it, rather than being an independent primitive
> > you apply to an already opened file?  Just in case - "'cuz that's how we'd
> > done it" does not make a good answer...

Maybe an access_ok() that acts on an open fd would be more
appropriate.
Which might end up being an fcntrl() action.
That would give you a full 32bit mask of options.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

