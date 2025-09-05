Return-Path: <linux-fsdevel+bounces-60323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A890B44AAE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 02:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBF8A47D26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 00:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5C03C0C;
	Fri,  5 Sep 2025 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mcbridemail.com header.i=@mcbridemail.com header.b="gOV/GCbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7D36D;
	Fri,  5 Sep 2025 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030778; cv=none; b=fxGD/7WG8tzlxMFG9o9yuhahXqhBat5sCeHGHmxWHC9xKykn0322vPNfNa6hGdqDzMIqsSzDOaEkHXNu1m4+eApiJQrQ73RZ0v/OTxc7U88KHnR8gwIbwaeZIP1hyErilq28iqk3os4Y1lk/8KT7s1R8Pnu1YII0zOk+JqWVEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030778; c=relaxed/simple;
	bh=hJWW7W0NNJebh0kiiQvjaDWZfUvqH1Az5B1bZTG6wls=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMmIII2AGfzuV6aj/62TH24XLmBoTZc1jaqdqGR/Q4mY/E11LA5MJFENQO4abfKaYoret9Zimp/Wmy2ZBNatjtgCQDy7ykRkvMGlV3OGSXikXkLpbk5eSg4UL+sumQrwdfbpWIJT8gqm8i4tMTGA+B1Os4D1y4cb9sXXa5oDFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcbridemail.com; spf=pass smtp.mailfrom=mcbridemail.com; dkim=pass (2048-bit key) header.d=mcbridemail.com header.i=@mcbridemail.com header.b=gOV/GCbZ; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcbridemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcbridemail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcbridemail.com;
	s=protonmail; t=1757030772; x=1757289972;
	bh=hJWW7W0NNJebh0kiiQvjaDWZfUvqH1Az5B1bZTG6wls=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gOV/GCbZorxNkFeHYcSaX8HdKbqq+P/PoHKdRY1u3Nxn36in3GInUDUazhPKDwmqa
	 EKyhhjEgIskYYjPkBU9jbDHt1cESKtkei/ImIWxKJX6qJXXJUgcoqYAXF/akMvS6n+
	 PK3dB16+9W6LzDP7u+6RJR/THvmOuP8wVcx+qtaLKUdJRgPXtgO4c/HKxJlOoLwjMM
	 k+gkEe7JSgi+jDfzrj9T5Ys5SmvkMDbc9KsaUqE2qFu59aN0/mqGFEVtsZhaEOzEa6
	 iR3dr5akbcxbsp84ziLQ1jJBqq5jiCdNEd6mXUdPIKBnjGEQoi/Tv83tY+7xjnnDdP
	 qgVP3QcHci5vA==
Date: Fri, 05 Sep 2025 00:06:06 +0000
To: Blake McBride <blake@mcbridemail.com>
From: Blake McBride <blake@mcbridemail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Colby Wes McBride <colbym84@gmail.com>
Subject: Re: [RFC] View-Based File System Model with Program-Scoped Isolation
Message-ID: <AgYydTLPzIi7PfK3SIbKYBYJ_S2P-9yFe9Eit6yRKwIgoQ_ktaPUDwPI_SzP97wKduSmJf118DaGulVu-TaQhkx5KYPpKfOD0x98BXKRDxU=@mcbridemail.com>
In-Reply-To: <X0FicR_DkHDIm8QFrAKwaEcu5_rAQY4OUHYnA62zwbNXPxJJ6vk-e3zsNkoTaOFSXVwAaPom7WDhrnSauyUjtqvPYDQKIDwsHzY2TWnSuv8=@mcbridemail.com>
References: <Oa1N9bTNjTvfRX39yqCcQGpl9FJVwfDT2fTq-9NXTT8HqTIqG2Y-Gy0f7QHKcp2-TIv7NZ3bu_YexmKiGuo9FBTeCtRnVzABBVnhx5EiShk=@mcbridemail.com> <20250904220650.GQ39973@ZenIV> <DHMURiMioUDX6Ggo4Qy8C43EUoC_ltjjS52i2kgC9tl6GhjGuJXOwyf9Nb-WkI__cM0NXECZw_HdKeIUmwShKkAmP7PwqZcmGz-vBrdWYL8=@mcbridemail.com> <20250904230846.GR39973@ZenIV> <nPMV5WRZT62Eq5Cu84Q0NMH2CgxAuisCAMQ4XfuG7kb6OdEOgY9UMi5sVx3CV0kSVcEBoDDz1w5btWaT1CfOCC_4jkCDrIoYk866FO9bZVo=@mcbridemail.com> <X0FicR_DkHDIm8QFrAKwaEcu5_rAQY4OUHYnA62zwbNXPxJJ6vk-e3zsNkoTaOFSXVwAaPom7WDhrnSauyUjtqvPYDQKIDwsHzY2TWnSuv8=@mcbridemail.com>
Feedback-ID: 30086830:user:proton
X-Pm-Message-ID: d4a45dc4e2dd82f8ea9ffc545412d1ee1e2ac378
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In effect, it is like an enhanced cwd. You change what directory you are in=
 (your cwd), and then all commands you run (except for absolute paths) are =
relative to your cwd. However, in this case, it isn't just your cwd; it als=
o depends on your current view or context.

--blake




On Thursday, September 4th, 2025 at 6:58 PM, Blake McBride <blake@mcbridema=
il.com> wrote:

>=20
>=20
> Let me be a little more clear about the application programmer-level API =
- nothing has to change. A context or view is selected by the user before a=
 program is started (unless a program has a default or specific context). T=
he API that the program uses is utterly unchanged. However, all of the call=
s are within the context of the view.
>=20
> --blake
>=20
>=20
>=20
>=20
>=20
> On Thursday, September 4th, 2025 at 6:41 PM, Blake McBride blake@mcbridem=
ail.com wrote:
>=20
> > On Thursday, September 4th, 2025 at 6:09 PM, Al Viro viro@zeniv.linux.o=
rg.uk wrote:
> >=20
> > > On Thu, Sep 04, 2025 at 10:58:12PM +0000, Blake McBride wrote:
> > >=20
> > > > Off the cuff, I'd say it is an mv option. It defaults to changing a=
ll occurrences, with an option to change it only in the current view.
> > >=20
> > > Huh? mv(1) is userland; whatever it does, by definition it boils down
> > > to a sequence of system calls.
> >=20
> > Yes. This is what is intended. All of userland would just operate on th=
e view the same as if that was your real hierarchy.
> >=20
> > > If those "views" of yours are pasted together subtrees of the global
> > > forest, you already can do all of that with namespaces; if they are n=
ot,
> > > you get all kinds of interesting questions about coherency.
> >=20
> > These views are not pasted together subtrees. Each view can have utterl=
y different layouts of the same set of files.
> >=20
> > > Which one it is? Before anyone can discuss possible implementations
> > > and relative merits thereof, you need to define the semantics of
> > > what you want to implement...
> > >=20
> > > And frankly, if you are thinking in terms of userland programs (file
> > > manglers, etc.) you are going the wrong way - description will have
> > > to be on the syscall level.
> >=20
> > I did not specify the implementation, just the user experience. All of =
userland would "appear" to function as it does now. The same with the sysca=
lls that are made by the application code. They all effect the current view=
 as if it was the real hierarchy.
> >=20
> > --blake

