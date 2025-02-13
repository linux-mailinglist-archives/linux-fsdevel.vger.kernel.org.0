Return-Path: <linux-fsdevel+bounces-41674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A76A34D54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E193B3A9932
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6052F6F073;
	Thu, 13 Feb 2025 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jabberwocky.com header.i=@jabberwocky.com header.b="Vhb+DUER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from walrus.jabberwocky.com (walrus.jabberwocky.com [173.9.29.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E3523A9AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.9.29.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470490; cv=none; b=dznwZxXpjES8dJx484wZzBQz0g6Qk2RrspaC+CCCosays/WeEWA1W9CjojeaGVytHwwuH9CNQFIKNm2B4hM3I3i3k/xnD8HdKMIjs2Fo9DrLSoZ3A4uaqxv6Sz13vDD7NGYMWqevfhGgTqP5tjR9LEbbyQRzyG3s0tdQCDJLZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470490; c=relaxed/simple;
	bh=YxzSN5iJdz7U63kmVid0vIQp/FcEAlEt2AZvqXWcXjs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aZlJgX3eckjeh0KoLBDWnhduljVqu7/eoISBtXuNrFzL2bKfWnvW7bATPv2x76Tjl4dIar84J8Iw91qCty7RX4UVTRPjPrLCWVPSknvM2KbjPl4IWmseIPLLKoDhEPOO1JlvbOEnjRKXtPfUveBBUSMqyeqqCNpCw7YbY+1J02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jabberwocky.com; spf=pass smtp.mailfrom=jabberwocky.com; dkim=pass (2048-bit key) header.d=jabberwocky.com header.i=@jabberwocky.com header.b=Vhb+DUER; arc=none smtp.client-ip=173.9.29.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jabberwocky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabberwocky.com
Received: from smtpclient.apple (grover.home.jabberwocky.com [172.24.84.28])
	by walrus.jabberwocky.com (Postfix) with ESMTPSA id 7D52A206F016;
	Thu, 13 Feb 2025 13:14:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 walrus.jabberwocky.com 7D52A206F016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabberwocky.com;
	s=s1; t=1739470487; bh=oP3Uhvp5gyKQiXOc66+awg4NVVHK64zKNuN7ggLwrf8=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=Vhb+DUERhbkiBcSOr3ILlVlS1AViPviKKHp0ZmnP317e327nVikbU1VqOUrV2aFvU
	 4JJEMS64KCJZQVg2d2zhCrCQfrTMW/Ps3OI8jH1ljrzGtyVobXUt7Mum0Z5qnNXXNI
	 MFQ9bnBYMfEb/n9BaNGe6akMx8qzLIm+9FxMaKnUmCRox9MKUEuvpPG/wpGbbBn0RH
	 b6dZxPgsYjKW3b8dhAnyzX8pNjgS3uwAAPewmOQS9BhVYLASYXr4oh8151ZDfE/ReY
	 5vU3YN7TXi2q1QoK8jQfI9HH9D7uZ/1OVMStAzFtHW2LAuDG8vEajEmB4ERqZfY34k
	 PFy7/Qln/NY8A==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: Odd split writes in fuse when going from kernel 3.10 to 4.18
From: Daphne Shaw <dshaw@jabberwocky.com>
In-Reply-To: <CAJfpeguq5phZwqCDv0OtMkubmAmo6LnQxZaex2=z4Xhe4Mz3fw@mail.gmail.com>
Date: Thu, 13 Feb 2025 13:14:37 -0500
Cc: linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BE8C6E7-FB3A-4ABA-8493-E37B69732E50@jabberwocky.com>
References: <34823B36-2354-49B0-AC44-A8C02BCD1D9D@jabberwocky.com>
 <CAJfpeguq5phZwqCDv0OtMkubmAmo6LnQxZaex2=z4Xhe4Mz3fw@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

On Feb 13, 2025, at 4:58=E2=80=AFAM, Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>=20
> On Wed, 12 Feb 2025 at 21:01, Daphne Shaw <dshaw@jabberwocky.com> =
wrote:
>=20
>> Can anyone help explain why one of the 4000-byte writes is being =
split into a 96-byte and then 3904-byte write?
>=20
> Commit 4f06dd92b5d0 ("fuse: fix write deadlock") introduced this
> behavior change and has a good description of the problem and the
> solution.  Here's an excerpt:
>=20
> "...serialize the synchronous write with reads from
>    the partial pages.  The easiest way to do this is to keep the =
partial pages
>    locked.  The problem is that a write() may involve two such pages =
(one head
>    and one tail).  This patch fixes it by only locking the partial =
tail page.
>    If there's a partial head page as well, then split that off as a =
separate
>    WRITE request."
>=20
> Your example triggered exactly this "two partial pages" case.

Ah, we suspected something like this. Thanks for the pointer.

> One way out of this is to switch to writeback_cache mode.  Would that
> work for your case?

I will run some tests - it should, as the only access is via fuse so =
nobody can modify the files behind its back. Even so, you said that was =
"one way out". What would be another way out of this?

Thanks,

Daphne


