Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC47C2547EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgH0O4X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:56:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:24259 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbgH0NHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:07:45 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-193-ebJTYPNPMbe2YTXzj0WrTA-1; Thu, 27 Aug 2020 14:07:34 +0100
X-MC-Unique: ebJTYPNPMbe2YTXzj0WrTA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 27 Aug 2020 14:07:33 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 27 Aug 2020 14:07:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuqi Jin <jinyuqi@huawei.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH] fs: Optimized fget to improve performance
Thread-Topic: [PATCH] fs: Optimized fget to improve performance
Thread-Index: AQHWfHA0Q0HraGCxZUqID6ug/Nw0ZqlL69xQ
Date:   Thu, 27 Aug 2020 13:07:33 +0000
Message-ID: <6feef2f0b6ed4df99e66c8325c8e66ae@AcuMS.aculab.com>
References: <1598523584-25601-1-git-send-email-zhangshaokun@hisilicon.com>
 <20200827123040.GE14765@casper.infradead.org>
In-Reply-To: <20200827123040.GE14765@casper.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
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
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox
> Sent: 27 August 2020 13:31
> On Thu, Aug 27, 2020 at 06:19:44PM +0800, Shaokun Zhang wrote:
> > From: Yuqi Jin <jinyuqi@huawei.com>
> >
> > It is well known that the performance of atomic_add is better than that of
> > atomic_cmpxchg.
> 
> I don't think that's well-known at all.

Especially since on (probably) every architecture except x86
atomic_add() is implemented using atomic_cmpxchg().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

