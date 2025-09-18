Return-Path: <linux-fsdevel+bounces-62055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85475B825BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 02:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1972D3B54D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 00:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3288B1C84BB;
	Thu, 18 Sep 2025 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="Wc6U7yYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B81BD9F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758154525; cv=none; b=BnqmE3ghZPjzSEMBJZ+7sAXHcZaqjBsEOoZsGJ2yyh+bPI0Iw51gd52cLFHOIi86ZeoPJG4nH8JQVAsnSrMy6TPU2fLgg3Xyz0yhHkZQS5+3SBkaATsumgf5hFrpIaitGVZYo4yQUZMoyohuG4oyXCypRGr/wUYNQjSKst/+F1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758154525; c=relaxed/simple;
	bh=6SzxGHmNXzbefVo2fxX8Wyri4WNEy60Ee2B+ikhpMLw=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=ddbysVvF3ISavTqbUfTx0lWcuznc9rH9AXNS0ZCor3Wx1MkgeOnsP/lWgzY54HnZCFEHxQFdG1VVw1sfT+p5cRy54Wm0E3gpupNaRsiNnk1dzGzOtQToQfKH/UM0UieEsSF4vZstpGcQ7OCy+4QQe7cuLZAg6cBNXTADHnre5sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=Wc6U7yYJ; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr3.hinet.net ([10.199.216.82])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I0FEhE129082
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 08:15:20 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758154520; bh=feCW9LyeqhzGuLyuc0GLu+qEpYk=;
	h=From:To:Subject:Date;
	b=Wc6U7yYJSPVVClJYBN6tafOi6+BEN+gRyFxQuRsykUnrcDZ+G0vSKtrNlWI/yOygV
	 lrXm9BA69eV/FUCA6pMIylI2AEHBvkg7B7Ma5hjKj65k92EPgPOBeKTjm81g2V0Vrz
	 Ff9HL4dZvoNUNjbJXflFQJF75VbcT+OvRHtE0LDA=
Received: from [127.0.0.1] (111-242-211-6.dynamic-ip.hinet.net [111.242.211.6])
	by cmsr3.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I0E4UN800432
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 08:14:31 +0800
From: "Info - Albinayah 736" <Linux-fsdevel@ms29.hinet.net>
To: linux-fsdevel@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gODcyODYgVGh1cnNkYXksIFNlcHRlbWJlciAxOCwgMjAyNSBhdCAwMjoxNDozMCBBTQ==?=
Message-ID: <f5a7961e-0dbe-8700-c064-ccb45f32bd88@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Sep 2025 00:14:30 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=LvQxyWdc c=0 sm=1 tr=0 ts=68cb4ee8
	p=OrFXhexWvejrBOeqCD4A:9 a=gMe1Ao7I0FFVVmf+TS0DsQ==:117 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10

Hi Linux-fsdevel,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading

