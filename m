Return-Path: <linux-fsdevel+bounces-60321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8118EB44AA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 01:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E970117F825
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A7E2F290E;
	Thu,  4 Sep 2025 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mcbridemail.com header.i=@mcbridemail.com header.b="gEpeEReT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473152EFD82
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030289; cv=none; b=PqLVIsGVLlvWZ4eVPZRHgKVwikH/tGxGlv0gQUGlBiVyk4hf++uxVp1YECh4pLzxoWBSdzbGlX1b4u9CDhXPNXpAGVlh5YWrG7tb0M4SZKbeH8MFr9kgzqqE/9OAq1Dj/T1kXsUV2+hFB0ZTPheFxZhkvc6ET2oNRCoX3rtmTuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030289; c=relaxed/simple;
	bh=C4NU9cMtdxrLyGuN3xq4dbUAslLZuV/Eo1Sag8WFxzA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3QjuRER8KS3y5lE1pbHdZEZaXqvpzn0b4yq1J08o09Ign2p+t9cP5OBuR+FRH7e2zHJ3ENy/2WKqjHfPZ6a/cA3w+BSoPyvvL8bwEsfTxGLBZeERCkwLckG7pJZrq68seJSqHIRQuRhVueDJY1oJmU0Zkkc0ehmBjFhpChkNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcbridemail.com; spf=pass smtp.mailfrom=mcbridemail.com; dkim=pass (2048-bit key) header.d=mcbridemail.com header.i=@mcbridemail.com header.b=gEpeEReT; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcbridemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcbridemail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcbridemail.com;
	s=protonmail; t=1757030285; x=1757289485;
	bh=C4NU9cMtdxrLyGuN3xq4dbUAslLZuV/Eo1Sag8WFxzA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gEpeEReTLhr9KUZI/6wL0U4qXN71QR5W2SDkS/jBl2o+6QgTdBqWkhTZvHGnIXYTp
	 ANWUXuMIk2+mx9wUqiKZQKyu8Shuy5VhqVJMbBonEw/y5t5IBfBYV/5wSzqklGr02c
	 k20zE1dqnD0L5FmT7qd8rT0bgb+Jp8mGOIOIAmxwy+hcUEpWUH5DpkN9IWvpS3vsxj
	 Csy3s1sNA9ZF68hoxboUJ0Hi6xbe4xG0ak3zrGZf3L9GjG/svMSh8z0384G5nelj8N
	 B1w/48FOt0p9KuC9KwkxoWSiovkVkN/wlLNRBlGL0iw7u3ZjEeUVWNQgU+kvYf88N5
	 7oVYRqc6Tg99A==
Date: Thu, 04 Sep 2025 23:57:58 +0000
To: Blake McBride <blake@mcbridemail.com>
From: Blake McBride <blake@mcbridemail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Colby Wes McBride <colbym84@gmail.com>
Subject: Re: [RFC] View-Based File System Model with Program-Scoped Isolation
Message-ID: <X0FicR_DkHDIm8QFrAKwaEcu5_rAQY4OUHYnA62zwbNXPxJJ6vk-e3zsNkoTaOFSXVwAaPom7WDhrnSauyUjtqvPYDQKIDwsHzY2TWnSuv8=@mcbridemail.com>
In-Reply-To: <nPMV5WRZT62Eq5Cu84Q0NMH2CgxAuisCAMQ4XfuG7kb6OdEOgY9UMi5sVx3CV0kSVcEBoDDz1w5btWaT1CfOCC_4jkCDrIoYk866FO9bZVo=@mcbridemail.com>
References: <Oa1N9bTNjTvfRX39yqCcQGpl9FJVwfDT2fTq-9NXTT8HqTIqG2Y-Gy0f7QHKcp2-TIv7NZ3bu_YexmKiGuo9FBTeCtRnVzABBVnhx5EiShk=@mcbridemail.com> <20250904220650.GQ39973@ZenIV> <DHMURiMioUDX6Ggo4Qy8C43EUoC_ltjjS52i2kgC9tl6GhjGuJXOwyf9Nb-WkI__cM0NXECZw_HdKeIUmwShKkAmP7PwqZcmGz-vBrdWYL8=@mcbridemail.com> <20250904230846.GR39973@ZenIV> <nPMV5WRZT62Eq5Cu84Q0NMH2CgxAuisCAMQ4XfuG7kb6OdEOgY9UMi5sVx3CV0kSVcEBoDDz1w5btWaT1CfOCC_4jkCDrIoYk866FO9bZVo=@mcbridemail.com>
Feedback-ID: 30086830:user:proton
X-Pm-Message-ID: b9e2af5321edd8adc1d662b30d3cb6329281b864
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Let me be a little more clear about the application programmer-level API - =
nothing has to change. A context or view is selected by the user before a p=
rogram is started (unless a program has a default or specific context). The=
 API that the program uses is utterly unchanged. However, all of the calls =
are within the context of the view.

--blake





On Thursday, September 4th, 2025 at 6:41 PM, Blake McBride <blake@mcbridema=
il.com> wrote:

>=20
>=20
> On Thursday, September 4th, 2025 at 6:09 PM, Al Viro viro@zeniv.linux.org=
.uk wrote:
>=20
> > On Thu, Sep 04, 2025 at 10:58:12PM +0000, Blake McBride wrote:
> >=20
> > > Off the cuff, I'd say it is an mv option. It defaults to changing all=
 occurrences, with an option to change it only in the current view.
> >=20
> > Huh? mv(1) is userland; whatever it does, by definition it boils down
> > to a sequence of system calls.
>=20
>=20
>=20
> Yes. This is what is intended. All of userland would just operate on the =
view the same as if that was your real hierarchy.
>=20
> > If those "views" of yours are pasted together subtrees of the global
> > forest, you already can do all of that with namespaces; if they are not=
,
> > you get all kinds of interesting questions about coherency.
>=20
>=20
>=20
> These views are not pasted together subtrees. Each view can have utterly =
different layouts of the same set of files.
>=20
>=20
>=20
>=20
> > Which one it is? Before anyone can discuss possible implementations
> > and relative merits thereof, you need to define the semantics of
> > what you want to implement...
> >=20
> > And frankly, if you are thinking in terms of userland programs (file
> > manglers, etc.) you are going the wrong way - description will have
> > to be on the syscall level.
>=20
>=20
> I did not specify the implementation, just the user experience. All of us=
erland would "appear" to function as it does now. The same with the syscall=
s that are made by the application code. They all effect the current view a=
s if it was the real hierarchy.
>=20
> --blake

