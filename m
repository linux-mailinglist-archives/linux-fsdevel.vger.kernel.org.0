Return-Path: <linux-fsdevel+bounces-55773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F9CB0E834
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 03:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7812B1C286B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 01:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C3E199237;
	Wed, 23 Jul 2025 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="fuKVzimE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4912F43;
	Wed, 23 Jul 2025 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234726; cv=pass; b=dwJPa9FLiNStOc2JblMrd69krFaW+u1jKNBfKrYgEiAt9hq0N96Rjlw4BLSs0ywuczoo8z9/nY4ApIFsQGajWtiyuAZ2Gj1COxGOXeIWVoSGKqB9hiHKiNeXZmovUk2laGVUiFYxVwNrxMrHYviGr3J9Mm1CP0J03lR5A/NTerM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234726; c=relaxed/simple;
	bh=kQtBD4u/2DWbddKH9xYLkSt3qDB8X4SffSwuW+eoKug=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OWQOwNYBiKJF1ryfOf0Y5UOFCZ4mxH/y0wLj4OJ8UrQyPWGHbE8ZzIC+uJy2reEsYBOnR3gYssLf+oaCZKcHX3PQcvT46spiIA0kenumNMmNZOiG37ZPuHZHuxSe95jsM9FNmheMsGMq9oSeEzlk+5IZ1UVepzo35sGA89Npkh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=fuKVzimE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753234699; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dcs/Bw9mxtzJgk7Y5Kk1J2gUOdVUAjSVAGOg/+Yf0e/9Wmj1g/i2y0Bv7E20emP4bZdIinpgEnbICecqExezPikJsckqYIGAcuruusYjhumH6+EdmYGaNdqY12sbkKnqw/asxSUb1VkP1Af9z4er+Jg7bN/7MMou4b2elaOrs1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753234699; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kQtBD4u/2DWbddKH9xYLkSt3qDB8X4SffSwuW+eoKug=; 
	b=kxjK2/NvQmyPXolw9abSvXe34vFq06jWNRD4QWogwkG7HDLnNzVrzpCJCatp0jmotGc1jYSgXdeiCA0zhcCc1YkU59RvFZTQC9vRXEM2i8KCENO5ZSYwQq4zJkCmpffMCq8NRDHPP77fJi9bZXOt7Zca5Ydu9E4M9OTZPBImJuQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753234699;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=kQtBD4u/2DWbddKH9xYLkSt3qDB8X4SffSwuW+eoKug=;
	b=fuKVzimEnUAiXPzrss/iJfEzZBdyx7qDmgkTKcIIUKG3flg5hyeJGbjhMioC6FTZ
	MLJ9H6a/lhm/CcrgXhfQV7q2EIaKLoxs5H6dxAnRKwF7gAiRJBDtQTuZ8TGCI4rDxq5
	HaGXV4YqPWw/2MzmhP7bxBHTJcGpWMKM9846HjQo=
Received: by mx.zohomail.com with SMTPS id 1753234696386671.5480253480471;
	Tue, 22 Jul 2025 18:38:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 0/3] rust: xarray: add `insert` and `reserve`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
Date: Tue, 22 Jul 2025 22:38:00 -0300
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
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
 linux-mm@kvack.org,
 Janne Grunau <j@jannau.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C5ED010-C61D-4748-B399-C6D052170224@collabora.com>
References: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Tamir,


> On 13 Jul 2025, at 09:05, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> The reservation API is used by asahi; currently they use their own
> abstractions but intend to use these when available.
>=20
> Rust Binder intends to use the reservation API as well.
>=20
> Daniel Almeida mentions a use case for `insert_limit`, but didn't name
> it specifically.

Sorry, this fell out of my radar for a bit. Will have a look in the next =
couple of days.


=E2=80=94 Daniel=

