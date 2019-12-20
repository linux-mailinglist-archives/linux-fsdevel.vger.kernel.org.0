Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9643712792C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 11:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLTKS2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 05:18:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:60369 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727201AbfLTKS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:18:27 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-7-xsbhb676OPeybTliNzrcug-1;
 Fri, 20 Dec 2019 10:18:24 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Dec 2019 10:18:23 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Dec 2019 10:18:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Aleksa Sarai' <cyphar@cyphar.com>
CC:     Florian Weimer <fweimer@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        "dev@opencontainers.org" <dev@opencontainers.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 1/2] uapi: split openat2(2) definitions from fcntl.h
Thread-Topic: [PATCH 1/2] uapi: split openat2(2) definitions from fcntl.h
Thread-Index: AQHVtnKfNpps3AEjjUOZljxYP1VvUqfBfNKAgAFG6YCAAAuokA==
Date:   Fri, 20 Dec 2019 10:18:23 +0000
Message-ID: <85251686ad074be18db926f903497a45@AcuMS.aculab.com>
References: <20191219105533.12508-1-cyphar@cyphar.com>
 <20191219105533.12508-2-cyphar@cyphar.com>
 <87a77oy3oe.fsf@oldenburg2.str.redhat.com>
 <20191219134525.mgzmjbsp4wo5b2bw@yavin.dot.cyphar.com>
 <845fc9e8b55e4868bb4d20655e674b50@AcuMS.aculab.com>
 <20191220093153.v7jpzvch3lohabll@yavin.dot.cyphar.com>
In-Reply-To: <20191220093153.v7jpzvch3lohabll@yavin.dot.cyphar.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: xsbhb676OPeybTliNzrcug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Aleksa Sarai
> Sent: 20 December 2019 09:32
...
> > I'm guessing that is just 64bit aligned on 32bit archs like x86?
> 
> Yeah,
> 
> #define __aligned_u64 __u64 __attribute__((aligned(8)))
> 
> > No need to enforce it provided the structure will have no padding on
> > archs where the 64bit fields are 64bit aligned. A plain __u64 should
> > be fine.
> 
> Will this cause problems for x86-on-x86_64 emulation? Requiring an
> 8-byte alignment for 'struct open_how' really isn't that undue of a
> burden IMHO. Then again, clone3 is a bit of an outlier since both
> perf_event_open and sched_setattr just use __u64s.

Makes diddly-squit difference.
The 64bit kernel will 64bit align the structure.
The kernel must allow for the userspace structure having arbitrary alignment.
So there is no reason to (try to) align the user structure.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

