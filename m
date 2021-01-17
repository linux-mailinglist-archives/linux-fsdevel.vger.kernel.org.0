Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E76F2F94A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jan 2021 19:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbhAQSdV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jan 2021 13:33:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:23037 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729934AbhAQSdS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jan 2021 13:33:18 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-165-qzM2FzfaOG6j69VeZBrcNw-1; Sun, 17 Jan 2021 18:31:37 +0000
X-MC-Unique: qzM2FzfaOG6j69VeZBrcNw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 17 Jan 2021 18:31:36 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 17 Jan 2021 18:31:36 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>, Andy Lutomirski <luto@kernel.org>
CC:     Arnd Bergmann <arnd@kernel.org>,
        Ryan Houdek <sonicadvance1@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Amanieu d'Antras <amanieu@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>, Jan Kara <jack@suse.cz>,
        David Rientjes <rientjes@google.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: RE: [PATCH] Adds a new ioctl32 syscall for backwards compatibility
 layers
Thread-Topic: [PATCH] Adds a new ioctl32 syscall for backwards compatibility
 layers
Thread-Index: AQHW6+b/d1V6Thk8U0iiUgMFo8hTJqosJEIw
Date:   Sun, 17 Jan 2021 18:31:36 +0000
Message-ID: <cc3ce5e484f041948cb008f7508c968b@AcuMS.aculab.com>
References: <20210106064807.253112-1-Sonicadvance1@gmail.com>
 <CAK8P3a2tV3HzPpbCR7mAeutx38_D2d-vfpEgpXv+GW_98w3VSQ@mail.gmail.com>
 <CABnRqDfQ5Qfa2ybut0qXcKuYnsMcG7+9gqjL-e7nZF1bkvhPRw@mail.gmail.com>
 <CAK8P3a2vfVfEWTk1ig349LGqt8bkK8YQWjE6PRyx+xvgYx7-gA@mail.gmail.com>
 <CALCETrUtyVaGSE9fcFAkhrGCpkyYcYnZb6tj8227o2EH5hgOfg@mail.gmail.com>
 <20210116090721.GA30277@lst.de>
In-Reply-To: <20210116090721.GA30277@lst.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig
> Sent: 16 January 2021 09:07
...
> > I personally would like to see in_compat_syscall() go away,
> > but some other people (Hi, Christoph!) disagree, and usage seems to be
> > increasing, not decreasing.
> 
> I'm absolutely against it going away.  in_compat_syscall helped to
> remove so much crap compared to the explicit compat syscalls.

The only other real option is to pass the 'syscall type' explicitly
through all the layers into every piece of code that might need it.

So passing it as a 'parameter' that is (probably) current->syscall_type
does make sense.

It might even make sense have separate bits for the required emulations.
So you'd have separate bits for '32bit pointers' and '64bit items 32bit
aligned' (etc).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

