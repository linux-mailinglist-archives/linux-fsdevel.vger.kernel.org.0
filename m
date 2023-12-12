Return-Path: <linux-fsdevel+bounces-5735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C565980F66C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 20:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1796B20EED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 19:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CAA81E3A;
	Tue, 12 Dec 2023 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="rMg4ncyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta-101a.earthlink-vadesecure.net (mta-101a.earthlink-vadesecure.net [51.81.61.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D1AD;
	Tue, 12 Dec 2023 11:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; bh=iNhXZaA1uzGEWSnxpxhdt0noXL5bjA9mN7YcaH
 C9Il8=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1702408684;
 x=1703013484; b=rMg4ncyUWE8j4hdw52dMjlM4O2QSzI2aQaZyfa18oIbaXYdAZs5B/n/
 +OfDMejvRgdAyZQqce4B27Z/gab85vDlI18AjfzyAKbXIhoPupbpK32Ykf3BvvFqkqFaLJp
 WbLtGIltspRy02zgm7XPPdTXMLXDyUnN3cav7VDhqn50zMcdmRmMOwuNCVBtHQ0OimRZSWy
 PpGYInXwl86M6RyzCgFIfZaJpLLUvJulkSLHEBFzBYJ49I4GVxhWr68R/im7CwJlkmbe+Aj
 jMsKWhO9XcHbZp0OwF+0zkyhFLSSWMiwQ41fLj8CsZ+XI69PtwxJm830KZu+osjcn0D6eca
 tig==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by vsel1nmtao01p.internal.vadesecure.com with ngmta
 id ef714e20-17a02bad7b096f68; Tue, 12 Dec 2023 19:18:04 +0000
From: "Frank Filz" <ffilzlnx@mindspring.com>
To: "'Amir Goldstein'" <amir73il@gmail.com>,
	"'Kent Overstreet'" <kent.overstreet@linux.dev>
Cc: "'Theodore Ts'o'" <tytso@mit.edu>,
	"'Donald Buczek'" <buczek@molgen.mpg.de>,
	"'Dave Chinner'" <david@fromorbit.com>,
	"'NeilBrown'" <neilb@suse.de>,
	<linux-bcachefs@vger.kernel.org>,
	"'Stefan Krueger'" <stefan.krueger@aei.mpg.de>,
	"'David Howells'" <dhowells@redhat.com>,
	<linux-fsdevel@vger.kernel.org>
References: <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan> <170233460764.12910.276163802059260666@noble.neil.brown.name> <20231211233231.oiazgkqs7yahruuw@moria.home.lan> <170233878712.12910.112528191448334241@noble.neil.brown.name> <20231212000515.4fesfyobdlzjlwra@moria.home.lan> <170234279139.12910.809452786055101337@noble.neil.brown.name> <ZXf1WCrw4TPc5y7d@dread.disaster.area> <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de> <20231212152016.GB142380@mit.edu> <0b4c01da2d1e$cf65b930$6e312b90$@mindspring.com> <20231212174432.toj6c65mlqrlt256@moria.home.lan> <CAOQ4uxgcUQE9Ldg8rodMXJvbU9BDCC9wGED0jANGrC-OLY1HJQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgcUQE9Ldg8rodMXJvbU9BDCC9wGED0jANGrC-OLY1HJQ@mail.gmail.com>
Subject: RE: file handle in statx
Date: Tue, 12 Dec 2023 11:18:02 -0800
Message-ID: <0b5d01da2d2f$ee5df9e0$cb19eda0$@mindspring.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQI9D5j+iWWTWnyU8CMdbk6E8xo4PwHHTjCPAatvR2sCMTvAAQGKlz4oApPNpA0BSHZRUQKfmjdIAWd4JeUCEu11rwHu2mPMAhIwDuivNxBsIA==
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;

> On Tue, Dec 12, 2023 at 7:44=E2=80=AFPM Kent Overstreet =
<kent.overstreet@linux.dev>
> wrote:
> >
> > On Tue, Dec 12, 2023 at 09:15:29AM -0800, Frank Filz wrote:
> > > > On Tue, Dec 12, 2023 at 10:10:23AM +0100, Donald Buczek wrote:
> > > > > On 12/12/23 06:53, Dave Chinner wrote:
> > > > >
> > > > > > So can someone please explain to me why we need to try to
> > > > > > re-invent a generic filehandle concept in statx when we
> > > > > > already have a have working and widely supported user API =
that
> > > > > > provides exactly this functionality?
> > > > >
> > > > > name_to_handle_at() is fine, but userspace could profit from
> > > > > being able to retrieve the filehandle together with the other
> > > > > metadata in a single system call.
> > > >
> > > > Can you say more?  What, specifically is the application that
> > > > would want
> > > to do
> > > > that, and is it really in such a hot path that it would be a
> > > > user-visible improveable, let aloine something that can be =
actually be
> measured?
> > >
> > > A user space NFS server like Ganesha could benefit from getting
> > > attributes and file handle in a single system call.
> > >
> > > Potentially it could also avoid some of the challenges of using
> > > name_to_handle_at that is a privileged operation.
> >
> > which begs the question - why is name_to_handle_at() privileged?
> >
>=20
> AFAICT, it is not privileged.
> Only open_by_handle_at() is privileged.

Ah, that makes sense. I'm a consumer of these interfaces, not so much in =
the kernel these days.

Ganesha depends on open_by_handle_at as well, so requires privilege to =
do handle stuff with kernel file systems.

In any case, Ganesha could easily benefit from a savings of system =
calls.

What would also be handy is a read directory with attributes that gave =
the statx results for each entry.

Frank


