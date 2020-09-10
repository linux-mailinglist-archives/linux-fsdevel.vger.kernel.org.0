Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F142648CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbgIJPdD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 11:33:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:39154 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727887AbgIJPcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:32:16 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-276-Rr3yeOHPPMud0l-oIQnsyA-1; Thu, 10 Sep 2020 16:31:54 +0100
X-MC-Unique: Rr3yeOHPPMud0l-oIQnsyA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 10 Sep 2020 16:31:53 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 10 Sep 2020 16:31:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Segher Boessenkool' <segher@kernel.crashing.org>
CC:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Thread-Topic: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Thread-Index: AQHWhvDyD2c/lZfV3kC0Ftay5UVebqlhgjnw///zuACAABnIEIAAOoMggAAi9ACAABJI8A==
Date:   Thu, 10 Sep 2020 15:31:53 +0000
Message-ID: <18fdbaeacba349a0a8bf7568f709e991@AcuMS.aculab.com>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142803.GM1236603@ZenIV.linux.org.uk>
 <CAHk-=wgQNyeHxXfckd1WtiYnoDZP1Y_kD-tJKqWSksRoDZT=Aw@mail.gmail.com>
 <20200909184001.GB28786@gate.crashing.org>
 <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
 <3beb8b019e4a4f7b81fdb1bc68bd1e2d@AcuMS.aculab.com>
 <186a62fc-042c-d6ab-e7dc-e61b18945498@csgroup.eu>
 <59a64e9a210847b59f70f9bd2d02b5c3@AcuMS.aculab.com>
 <5050b43687c84515a49b345174a98822@AcuMS.aculab.com>
 <20200910152030.GJ28786@gate.crashing.org>
In-Reply-To: <20200910152030.GJ28786@gate.crashing.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Segher Boessenkool <segher@kernel.crashing.org>
> Sent: 10 September 2020 16:21
> To: David Laight <David.Laight@ACULAB.COM>
> Cc: 'Christophe Leroy' <christophe.leroy@csgroup.eu>; 'Linus Torvalds' <torvalds@linux-
> foundation.org>; linux-arch <linux-arch@vger.kernel.org>; Kees Cook <keescook@chromium.org>; the
> arch/x86 maintainers <x86@kernel.org>; Nick Desaulniers <ndesaulniers@google.com>; Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org>; Alexey Dobriyan <adobriyan@gmail.com>; Luis Chamberlain
> <mcgrof@kernel.org>; Al Viro <viro@zeniv.linux.org.uk>; linux-fsdevel <linux-fsdevel@vger.kernel.org>;
> linuxppc-dev <linuxppc-dev@lists.ozlabs.org>; Christoph Hellwig <hch@lst.de>
> Subject: Re: remove the last set_fs() in common code, and remove it for x86 and powerpc v3
> 
> On Thu, Sep 10, 2020 at 12:26:53PM +0000, David Laight wrote:
> > Actually this is pretty sound:
> > 	__label__ label;
> > 	register int eax asm ("eax");
> > 	// Ensure eax can't be reloaded from anywhere
> > 	// In particular it can't be reloaded after the asm goto line
> > 	asm volatile ("" : "=r" (eax));
> 
> This asm is fine.  It says it writes the "eax" variable, which lives in
> the eax register *in that asm* (so *not* guaranteed after it!).
> 
> > 	// Provided gcc doesn't save eax here...
> > 	asm volatile goto ("xxxxx" ::: "eax" : label);
> 
> So this is incorrect.

From the other email:

> It is neither input nor output operand here!  Only *then* is a local
> register asm guaranteed to be in the given reg: as input or output to an
> inline asm.

Ok, so adding '"r" (eax)' to the input section helps a bit.

> > 	// ... and reload the saved value here.
> > 	// The input value here will be that modified by the 'asm goto'.
> > 	// Since this modifies eax it can't be moved before the 'asm goto'.
> > 	asm volatile ("" : "+r" (eax));
> > 	// So here eax must contain the value set by the "xxxxx" instructions.
> 
> No, the register eax will contain the value of the eax variable.  In the
> asm; it might well be there before or after the asm as well, but none of
> that is guaranteed.

Perhaps not 'guaranteed', but very unlikely to be wrong.
It doesn't give gcc much scope for not generating the desired code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

