Return-Path: <linux-fsdevel+bounces-12682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8815B8627EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 23:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B711C20B59
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 22:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06874D9E1;
	Sat, 24 Feb 2024 22:10:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88617C2D0
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708812640; cv=none; b=spC+rWerabZUgXVLgrNhSTvcVyIiA937RmV6zRcC9K6KiST77zf/gdG312KvwXoQcmN+TdL/7AZdL3DstrGcHOPbM3d3VXZIR1lmTRkX02jqNh0cWGgatsnuLh2kOGShmS6jAULSjp3j+3ShytC2C1BFJbb5gk+Xx4nHfSvn6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708812640; c=relaxed/simple;
	bh=3ptU5r2TNQLqAXFUNm3uyWN2DrpdKyRJ6+9DsuJYWIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Y+kir8CJEsVCY9jeOSXaa4aSAG3b/BgUOy9sL+eTEuoZigT2joUWJrijVimGzT5bcW0yXkIfANH7OEFy1WHaJvFh/iLVRD+f1w2vKoycb04jHDM5n92V8hWQdKKX/J1SKAJ9rGwHKX+W1K1N5LN92vFXF2HdM4gMZ/le16+/mDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-209-K7PK0T93M2GOk-Vn9vdHcA-1; Sat, 24 Feb 2024 22:10:28 +0000
X-MC-Unique: K7PK0T93M2GOk-Vn9vdHcA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 24 Feb
 2024 22:10:27 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 24 Feb 2024 22:10:27 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Herbert Xu' <herbert@gondor.apana.org.au>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Graf
	<tgraf@suug.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [PATCH 0/1] Rosebush, a new hash table
Thread-Topic: [PATCH 0/1] Rosebush, a new hash table
Thread-Index: AQHaZrdg3OPv1gzlbEiBbQpUz0xlprEaCpvw
Date: Sat, 24 Feb 2024 22:10:27 +0000
Message-ID: <4a1416fcb3c547eb9612ce07da6a77ed@AcuMS.aculab.com>
References: <20240222203726.1101861-1-willy@infradead.org>
 <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
In-Reply-To: <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Herbert Xu
> Sent: 24 February 2024 00:21
>=20
> On Thu, Feb 22, 2024 at 08:37:23PM +0000, Matthew Wilcox (Oracle) wrote:
> >
> > Where I expect rosebush to shine is on dependent cache misses.
> > I've assumed an average chain length of 10 for rhashtable in the above
> > memory calculations.  That means on average a lookup would take five ca=
che
> > misses that can't be speculated.  Rosebush does a linear walk of 4-byte
>=20
> Normally an rhashtable gets resized when it reaches 75% capacity
> so the average chain length should always be one.

The average length of non-empty hash chains is more interesting.
You don't usually search for items in empty chains.
The only way you'll get all the chains of length one is if you've
carefully picked the data so that it hashed that way.

I remember playing around with the elf symbol table for a browser
and all its shared libraries.
While the hash function is pretty trivial, it really didn't matter
whether you divided 2^n, 2^n-1 or 'the prime below 2^n' some hash
chains were always long.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


