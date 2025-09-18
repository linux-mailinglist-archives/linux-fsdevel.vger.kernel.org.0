Return-Path: <linux-fsdevel+bounces-62153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C4B85DDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 18:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3333A914D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E7F2641C3;
	Thu, 18 Sep 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="NB543TVh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EA30748A;
	Thu, 18 Sep 2025 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211044; cv=none; b=ZQcMgb9ccTtuIfbGXaR8Libt8/YTlfh209JcFxE8ZxzyCAvG2j8x7h52qRfz28Iv0jlCmNo80Ha6e9d9PoKasPpaABgIedWbr+ofmfZo/neREzFBdC4jt3rtdgfymhG/szMulRhDKKJdmqTxqmTRBFCt4zWa28FLQ138wKTlrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211044; c=relaxed/simple;
	bh=zA6/OnTfTyUR4ReMbBgbAS7Aeu9Shy3hTUxFOIVTxpw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2hWmigIu5zCpxqMSaJetFRquSj3Kn/EPR2IDrg3o5Lw31MWhNu3iScFe+89EqhYGSJ82GXnOIlK+C2slVit9CP86FUl13oo7m0Oa4IKFunhQrNatZb45P/OkhG0WyjAoST+69xiUJ83AmAdy3lyrOk2C0+NblQKTraIg7LZp6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=NB543TVh; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1758211040; x=1758470240;
	bh=zA6/OnTfTyUR4ReMbBgbAS7Aeu9Shy3hTUxFOIVTxpw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NB543TVhzB6EFCSkGtashONtbosi4Z00OvwULl8ovAseHr7H4D/WMtCVeEHVwK7qR
	 wCA4OaOdaKObASbqnNxK3rq2VNAJWsQBuorAn65LXrJJQ5Nk4xYonqrMloxfwuPkCG
	 07Pv3srXl8B4YdRqAYtVicr/R9CkqPOgSpLsB+8+7UqKT5x+PTVslh9BgDbAhZyAit
	 a9tfkQkBPK/bHtOsmgwEDVHxpjP4bPbIhynAi5hJ2wsumna23s6fL39kgllEVo/XXU
	 giPN2g8OVIQLf0a27rfkp5DuNwsKJ9F8AxWCnW/ozbd42tSBvg2IpwpThmo65YYR3Z
	 MhjL7fmECQHGQ==
Date: Thu, 18 Sep 2025 15:57:15 +0000
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: ManeraKai <manerakai@protonmail.com>
Cc: "aliceryhl@google.com" <aliceryhl@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: miscdevice: Implemented `read` and `write`
Message-ID: <5cf242fd-ded4-4aea-a5b7-9c856f75fdb6@protonmail.com>
In-Reply-To: <2025091841-remindful-manned-a57f@gregkh>
References: <20250918144356.28585-1-manerakai@protonmail.com> <20250918144356.28585-3-manerakai@protonmail.com> <2025091820-canine-tanning-3def@gregkh> <2025091841-remindful-manned-a57f@gregkh>
Feedback-ID: 38045798:user:proton
X-Pm-Message-ID: df1acba63728c7bb4ec2049c7df8555582ead7d6
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

 > What type of real misc driver do you want to write in rust that you
 > need a read/write callback and not just an ioctl one?

I don't have one in mind. I was reading your book and experimenting with=20
char drivers. However, I found out that you prefer new developers to use=20
misc instead:
https://lore.kernel.org/rust-for-linux/2024101256-amplifier-joylessly-6ca9@=
gregkh/

So, I wanted to safe-wrap misc for new Rust developers (me included).=20
And go from there to write real drivers.


