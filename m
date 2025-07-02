Return-Path: <linux-fsdevel+bounces-53650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A75AF59C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2D016DB75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467527A102;
	Wed,  2 Jul 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="TaoMGapY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4962749D6;
	Wed,  2 Jul 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463619; cv=pass; b=NrYrZx4aXNydTmzWpQ+HTj6hTXhX1UIPO5hi81D++obcZvJFhmgYsq7Jv2K3acACE9eP2C+u4/1uXbiCvqhO1X6qa8UKeNNWOOwc3VKaqVyUuGMOcEgn+0M74gd4kd1dMTDcStVX0jspx+QjYoiJPvpYmOkc0CSQqZFaEqatJpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463619; c=relaxed/simple;
	bh=zGz3wZaMO2CCXdPpXYEDAMhtkv9y3EB0vMLHbEUIfYQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JyemlBK0sU2GIkkLAXhdJtEa8NbaA0MAdjnnmuC4s7SkryPYt21YiPqEuxW948IZQZ0x9Li43sGVuTvCwLEzwYupf1dLJ4FtS9MWcI2ByEU7j22dscjWa5TA21BCYPcbOoI8+wmwpBox4n5u+kfwFQxwSBisUziSsdt92oOd8H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=TaoMGapY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751463588; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cExZJQShZ2uQ1MN1i5UO8fmEQalayc+lyTtgz46ZkgqQgPLT9tOz30SLJDv3qFITFp0srCKKCJ93qIKXTcke0806yZo9AekWCmgkTlHTfSB6F6XQ+USpo+aqUDMg0snEMhhxMWr1Z7QxG5nKx8l3451G0YTJzb1VkmmVzgkN71Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751463588; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zGz3wZaMO2CCXdPpXYEDAMhtkv9y3EB0vMLHbEUIfYQ=; 
	b=nSetWO1moVj9josi1pcj5yvFifyocK6d3/CKHmkV8TjL2jF7aMjnj1pRt4X+RXBA6AltKoVI4nnrE2DgePS1bH78+i2JhYrECS1hYmm5aEigpcrewVurzv+slfS+DOdHVDL0fvpZnlXAt1Sh9slZm7MreNfNKlL9jPJdFjGILJU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751463588;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=zGz3wZaMO2CCXdPpXYEDAMhtkv9y3EB0vMLHbEUIfYQ=;
	b=TaoMGapYkuGCPVaT+OpCTHgKvr3HndiuyLlDNyl+81jX7y2HthpMkQ44DE3cw/Ch
	G8vAT9xp7J6s+vLU1orxlhw7Qy2zkrauGwzba7KrjQPceZ3XljUICqN7tWFxxWwBmFj
	lyhE0JLSZJar7N8jOP16vAGl0D0EEb+oQL6n1cNc=
Received: by mx.zohomail.com with SMTPS id 1751463587050641.5348975838191;
	Wed, 2 Jul 2025 06:39:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 3/3] rust: xarray: add `insert` and `reserve`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAJ-ks9k7Jn=8K1a0QeDK-vhTWO8-dv_bkw2SJm3EEUsinMTFQA@mail.gmail.com>
Date: Wed, 2 Jul 2025 10:39:30 -0300
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <70F0607C-FFAA-412C-9412-5F5A01079C45@collabora.com>
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
 <20250701-xarray-insert-reserve-v1-3-25df2b0d706a@gmail.com>
 <CANiq72nf-h86GszE3=mLpWHi5Db+Tj0TRyUe9ANfjdNbesBEEg@mail.gmail.com>
 <CAJ-ks9k7Jn=8K1a0QeDK-vhTWO8-dv_bkw2SJm3EEUsinMTFQA@mail.gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi, this is on my todo list.

Again, thanks Tamir for working on this.

> On 1 Jul 2025, at 14:04, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> On Tue, Jul 1, 2025 at 12:56=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>=20
>> On Tue, Jul 1, 2025 at 6:27=E2=80=AFPM Tamir Duberstein =
<tamird@gmail.com> wrote:
>>>=20
>>> Add `Guard::{insert,reserve}` and `Guard::{insert,reserve}_limit`, =
which
>>> are akin to `__xa_{alloc,insert}` in C.
>>=20
>> Who will be using this? i.e. we need to justify adding code, =
typically
>> by mentioning the users.
>=20
> Daniel, could you name your use case?

My main use case is for insert_limit.

Tyr uses xarrays to keep track of resources allocated by userspace, and =
we need
to impose limits on how many resources can be allocated at once.

insert_limits() provides the exact semantics needed, i.e.: insert =
somewhere in
the array as long as there is vacant space in the given range.

=E2=80=94 Daniel=

