Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ACA2F85FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 21:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbhAOUDI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 15:03:08 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:27269 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388656AbhAOUDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:03:03 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-79-PS3OFpBZPgGXINPuMHjjeQ-1; Fri, 15 Jan 2021 20:01:22 +0000
X-MC-Unique: PS3OFpBZPgGXINPuMHjjeQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 15 Jan 2021 20:01:15 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 15 Jan 2021 20:01:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'sonicadvance1@gmail.com'" <sonicadvance1@gmail.com>
CC:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oleg Nesterov <oleg@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jan Kara <jack@suse.cz>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH] Adds a new ioctl32 syscall for backwards compatibility
 layers
Thread-Topic: [PATCH] Adds a new ioctl32 syscall for backwards compatibility
 layers
Thread-Index: AQHW6wzXd1V6Thk8U0iiUgMFo8hTJqopEBwA
Date:   Fri, 15 Jan 2021 20:01:15 +0000
Message-ID: <b15672b1caec4cf980f2753d06b03596@AcuMS.aculab.com>
References: <20210106064807.253112-1-Sonicadvance1@gmail.com>
 <20210115070326.294332-1-Sonicadvance1@gmail.com>
In-Reply-To: <20210115070326.294332-1-Sonicadvance1@gmail.com>
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

From: sonicadvance1@gmail.com
> Sent: 15 January 2021 07:03
> Problem presented:
> A backwards compatibility layer that allows running x86-64 and x86
> processes inside of an AArch64 process.
>   - CPU is emulated
>   - Syscall interface is mostly passthrough
>   - Some syscalls require patching or emulation depending on behaviour
>   - Not viable from the emulator design to use an AArch32 host process
> 

You are going to need to add all the x86 compatibility code into
your arm64 kernel.
This is likely to be different from the 32bit arm compatibility
because 64bit items are only aligned on 32bit boundaries.
The x86 x32 compatibility will be more like the 32bit arm 'compat'
code - I'm pretty sure arm32 64bit aligned 64bit data.

You'll then need to remember how the process entered the kernel
to work out which compatibility code to invoke.
This is what x86 does.
It allows a single process to do all three types of system call.

Trying to 'patch up' structures outside the kernel, or in the
syscall interface code will always cause grief somewhere.
The only sane place is in the code that uses the structures.
Which, for ioctls, means inside the driver that parses them.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

