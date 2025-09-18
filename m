Return-Path: <linux-fsdevel+bounces-62060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88458B82A93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 04:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF043462015
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 02:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06202222C5;
	Thu, 18 Sep 2025 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="RFSODt1n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE411DC9B5
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 02:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163015; cv=none; b=sEZjIMFgyiHJruszrmH8O8zMU4nxGHrbkaaNcRS5pNhiTwEPmFKLsr8nXEACyK0Y1nusF6Tx2YyRdt9OnuZ+b0DWdIWhiTxls6IEj/R0M9wG5fY051YZmPNLhfVJiSdjfZoOCEe8tfI88d1/zLA2ykWBxTAZ55fNHVfFRjR8NQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163015; c=relaxed/simple;
	bh=6SzxGHmNXzbefVo2fxX8Wyri4WNEy60Ee2B+ikhpMLw=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=cGUZ6kcpPtaG52NqvDuztIYPXTynApY/98WgLf1JWHJyjVZLed0KtCso8NVIqysW4+mVz+us56UogaCJXSRYDYjsqvAZDVbF3IgPeAiNylYcRtSw8mTYnP6yyFo8Uu3/MTrkfFAh7pDSW1cMkhXrfb5q1D8osa8tn5O7E8r71TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=RFSODt1n; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr10.hinet.net ([10.199.216.89])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I2amXO453358
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 10:36:51 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758163011; bh=feCW9LyeqhzGuLyuc0GLu+qEpYk=;
	h=From:To:Subject:Date;
	b=RFSODt1nErwqWrBFqZNSMQvgX+IIOs2vXVnnlglGElNhXj3z0ZuU8ItodCYZ3/TLr
	 ZPVkccBB7nDjoi3qbt3vJ7QAoaNU4j7X6FRYUWz/Ubtoqk7AC5n29s8HHILuSZOd/P
	 u9p6urJoIWxJlI6hKk+MwLCppEwEjgXP21Xbjmys=
Received: from [127.0.0.1] (111-253-41-236.dynamic-ip.hinet.net [111.253.41.236])
	by cmsr10.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I2S9d2753149
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 10:32:03 +0800
From: "Info - Albinayah 228" <Linux-fsdevel@ms29.hinet.net>
To: linux-fsdevel@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gOTQwNDggVGh1cnNkYXksIFNlcHRlbWJlciAxOCwgMjAyNSBhdCAwNDozMjowMSBBTQ==?=
Message-ID: <dd3e3293-d021-938b-019a-069b7ec62841@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Sep 2025 02:32:02 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=I/PGR8gg c=0 sm=1 tr=0 ts=68cb6f24
	p=OrFXhexWvejrBOeqCD4A:9 a=VzeL7syqs32dbrS4vs1vDQ==:117 a=IkcTkHD0fZMA:10
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

