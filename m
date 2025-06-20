Return-Path: <linux-fsdevel+bounces-52304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 949A4AE14E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 09:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC2317F81A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 07:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4798227E92;
	Fri, 20 Jun 2025 07:28:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486830E85C;
	Fri, 20 Jun 2025 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404485; cv=none; b=kz2quPxqePy0M1uIQfHJAnPnIiu8LMlIbH/WhNQv32x4Tl55ujKhTKIymxoAu8n3812/YNqgrvFDvTpsydPmhNlft5dMDkRnfKmOXXhCArFP5dLV15EYn73v40B12fapwd0F7KMAhAlkw4I80dn2bMx0tx+zxr9aOLiQ3/nj+uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404485; c=relaxed/simple;
	bh=Z88Xr/r2X1V3xuBQSaKOLouLnwxIDOwBPIQPYj6RwXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amb03OnImTLGhnykiGkuw6AGCVTwNJxtw8z1xxmAad9i8DDJ4dm91CKEZuMhoYi2KO9gbB5MCk4wJ75ckvf3a7USaAi6a8lzEiiyTaEWAPQEE+ur5fjzRA05hzD8QDbAg8kOd2BoHtXxXMLN9+hXwGTW7XbXSG9x75uzm8Dqm44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 45AF910F737;
	Fri, 20 Jun 2025 07:28:00 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Jani Partanen <jiipee@sotapeli.fi>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
Date: Fri, 20 Jun 2025 09:27:59 +0200
Message-ID: <2793428.mvXUDI8C0e@lichtvoll.de>
In-Reply-To: <3366564.44csPzL39Z@lichtvoll.de>
References:
 <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
 <ep4g2kphzkxp3gtx6rz5ncbbnmxzkp6jsg6mvfarr5unp5f47h@dmo32t3edh2c>
 <3366564.44csPzL39Z@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Martin Steigerwald - 20.06.25, 09:12:21 CEST:
> If you stick to your approach about merge window rules and many other
> kernel developers including Linus stick to their rules this will go in
> circles.
> 
> Indefinitely so.

Also it has even been quite predictable.

The moment I saw your merge request I would have been very surprised if 
Linus would just have pulled it.

-- 
Martin



