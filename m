Return-Path: <linux-fsdevel+bounces-60319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37596B44A7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 01:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B38169B6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2CA2F6572;
	Thu,  4 Sep 2025 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mcbridemail.com header.i=@mcbridemail.com header.b="uDsIAzcP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8002882C8
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757029284; cv=none; b=qsxV3Lt82kW73AhSw0+5tTJTy/Cu7bl2Im9/qUasr8c9IYOEk08D4xaiL8p6dPP4N/BITRoyDZhVur3SEtLI1az4kShww+hj8wIw/ZDsBLgbN+0D7fxQCHkEuyF3E3kwAGJlDOKJXUzOO6v5iCsqCMzkMfPabaBMq8xxaJVHOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757029284; c=relaxed/simple;
	bh=LFbIKM8j4M9g/fcCcVVVRJnzocvfkIzRKWElyt6Oha8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHWJUkUl8wPkfgEUF9BtH3nFq+1gG+jOvjBsy9QfhSyIao+qAUYe4uh+bbYb3KPz6GaJHHjiPoTKBDM1z5LYEIKC2NLiV+81w9fs650omuKa/XCfYOs0BqhzMaWZQj7kiJGN2PWPA6pDE8RdNx3ulymq2hEFR9giJPC9l84hu6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcbridemail.com; spf=pass smtp.mailfrom=mcbridemail.com; dkim=pass (2048-bit key) header.d=mcbridemail.com header.i=@mcbridemail.com header.b=uDsIAzcP; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcbridemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcbridemail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcbridemail.com;
	s=protonmail; t=1757029278; x=1757288478;
	bh=PvkD4sYAUcc7H3PsgqKK7mZCcx4fpxzEJ/vRxP1AZio=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uDsIAzcPsIcRKoq5QwwojpV8tBpeU2vrNKCcY+F1qN8bA/qq9ZBpQPotGZ1dQmihv
	 KkguBe8DxvoB2ZY6oHlc8Ppc/mm76bMe+yS6ipi4DczV6Up0VbkuLitpn4ztZu/960
	 IxPk26yY2E5vxEAhsPVStYjoyN2DtD3SRhp1HCT434wK9BF6OxjZVOPfYOTcdh7h34
	 z+R0ndGe5k7RUfYQKrbRYHSrIkywoAmPuGfw8NpsizYUw2uGWrbyxfFcg/vh5TtpjV
	 gQ7N2ZxlqK/74DjcX4rkgPlcsq28bOkWeRZkS1oiJdMujkXXSAthQqzqVQpAQvow89
	 2TvtIpNiCkH4g==
Date: Thu, 04 Sep 2025 23:41:12 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
From: Blake McBride <blake@mcbridemail.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Colby Wes McBride <colbym84@gmail.com>
Subject: Re: [RFC] View-Based File System Model with Program-Scoped Isolation
Message-ID: <nPMV5WRZT62Eq5Cu84Q0NMH2CgxAuisCAMQ4XfuG7kb6OdEOgY9UMi5sVx3CV0kSVcEBoDDz1w5btWaT1CfOCC_4jkCDrIoYk866FO9bZVo=@mcbridemail.com>
In-Reply-To: <20250904230846.GR39973@ZenIV>
References: <Oa1N9bTNjTvfRX39yqCcQGpl9FJVwfDT2fTq-9NXTT8HqTIqG2Y-Gy0f7QHKcp2-TIv7NZ3bu_YexmKiGuo9FBTeCtRnVzABBVnhx5EiShk=@mcbridemail.com> <20250904220650.GQ39973@ZenIV> <DHMURiMioUDX6Ggo4Qy8C43EUoC_ltjjS52i2kgC9tl6GhjGuJXOwyf9Nb-WkI__cM0NXECZw_HdKeIUmwShKkAmP7PwqZcmGz-vBrdWYL8=@mcbridemail.com> <20250904230846.GR39973@ZenIV>
Feedback-ID: 30086830:user:proton
X-Pm-Message-ID: 584adc3b8567c8ef078a37bca4435820c1ddcfdb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, September 4th, 2025 at 6:09 PM, Al Viro <viro@zeniv.linux.org.=
uk> wrote:

>=20
>=20
> On Thu, Sep 04, 2025 at 10:58:12PM +0000, Blake McBride wrote:
>=20
> > Off the cuff, I'd say it is an mv option. It defaults to changing all o=
ccurrences, with an option to change it only in the current view.
>=20
>=20
> Huh? mv(1) is userland; whatever it does, by definition it boils down
> to a sequence of system calls.


Yes.  This is what is intended.  All of userland would just operate on the =
view the same as if that was your real hierarchy.


>=20
> If those "views" of yours are pasted together subtrees of the global
> forest, you already can do all of that with namespaces; if they are not,
> you get all kinds of interesting questions about coherency.


These views are not pasted together subtrees.  Each view can have utterly d=
ifferent layouts of the same set of files.





>=20
> Which one it is? Before anyone can discuss possible implementations
> and relative merits thereof, you need to define the semantics of
> what you want to implement...
>=20
> And frankly, if you are thinking in terms of userland programs (file
> manglers, etc.) you are going the wrong way - description will have
> to be on the syscall level.

I did not specify the implementation, just the user experience.  All of use=
rland would "appear" to function as it does now.  The same with the syscall=
s that are made by the application code.  They all effect the current view =
as if it was the real hierarchy.

--blake


