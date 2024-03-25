Return-Path: <linux-fsdevel+bounces-15240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5530488AE8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1251F633FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCA35C5F3;
	Mon, 25 Mar 2024 18:20:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23B54735
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390816; cv=none; b=eozYU98ldwcU/8cE30nNan1zwmV+n2p88tUDTIOaZcQokDtJTryV+tsDWQnNHE48CbCk1y9QpIuk6EIhl+gC4Runx4o5QhRtMa7FEYpxtm/mnLUqSIZxKUuYQsbCMAm9iYe2NdYJc+PCokd5ruTFj2cw4XCXZq7W3G9QMbAxYLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390816; c=relaxed/simple;
	bh=QmzhBPWLVjsvBB8JZcL6YcnOYE1uoWA7lOCB0MQJTcM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=b4BuJ9Mjgar74QjfvS+zu8MUPMk2ZrOEUH6nGwrBC2zuo4TnNh1DbY4hVZuAzmVSnkJX4h7TDEdTgr6oqI/Mu53uo20a/cu0hGWzTOjF/tDGnom++AUqzhQz2bQJIW7680ahw9HebbBUigMbctCyW3dkl0NZp0+ULZsIwbLYoU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id EC3CC62F2902;
	Mon, 25 Mar 2024 19:20:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id K3LxzLwggEyW; Mon, 25 Mar 2024 19:20:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BB5A564103E7;
	Mon, 25 Mar 2024 19:20:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qZ50c87yJ2ct; Mon, 25 Mar 2024 19:20:03 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 551BD62F2902;
	Mon, 25 Mar 2024 19:20:03 +0100 (CET)
Date: Mon, 25 Mar 2024 19:20:02 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Pintu Agarwal <pintu.ping@gmail.com>
Cc: linux-fsdevel@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Richard Weinberger <richard.weinberger@gmail.com>, 
	Ezequiel Garcia <ezequiel@collabora.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <321330094.101965.1711390802883.JavaMail.zimbra@nod.at>
In-Reply-To: <CAOuPNLjQPo8hoawK73H7FOVitQHp21HHODExO+7cguGrtURKWg@mail.gmail.com>
References: <CAOuPNLjQPo8hoawK73H7FOVitQHp21HHODExO+7cguGrtURKWg@mail.gmail.com>
Subject: Re: linux-mtd: ubiattach taking long time
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: linux-mtd: ubiattach taking long time
Thread-Index: Mx3wAXRAa/xn1RI2GU7JLp9fVCsk7g==

Pintu,

----- Urspr=C3=BCngliche Mail -----
> Von: "Pintu Agarwal" <pintu.ping@gmail.com>
> I have tried using fastmap as well, but still no difference.
> Are there any other techniques to improve the ubiattach timing ?
>=20
> Logs:
> ----------
> Doing from initramfs:
> {{{
> [    6.949143][  T214] ubi0: attaching mtd54
> [    8.023766][  T214] ubi0: scanning is finished

No fastmap attach here.

Make sure to set fm_autoconvert:
http://www.linux-mtd.infradead.org/doc/ubi.html#L_fastmap
If set, UBI create after a few writes a fastmap.

Speaking of other techniques, you can improve scanning time also by
tuning UBI for your NAND controller/setup.
E.g. transferring only the amount of bytes needed for an header.
Or reading without ECC and re-reading with ECC if the header CRC-check fail=
s.

Thanks,
//richard

