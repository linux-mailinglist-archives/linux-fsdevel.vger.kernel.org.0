Return-Path: <linux-fsdevel+bounces-61714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55964B592B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 11:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D972A4ACD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB32B29B778;
	Tue, 16 Sep 2025 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="cdGRZobw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E234274FDE
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016315; cv=none; b=qrMkT/QoyKeQrNu1AqY5KtNnXr6DzJIBYkcbnSjRS/GgM92Rigm2KvF46v2sBU29mzaQds3JCWJunvn2F4B5s3AlIiMMr7AeIvizUQqipNpjFLwAsmxLD5gg4a//TL/XexWEZz6CDE37ucAEThmeQNg/9zonPMRNKRULMyr/hsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016315; c=relaxed/simple;
	bh=6SzxGHmNXzbefVo2fxX8Wyri4WNEy60Ee2B+ikhpMLw=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=flPTrltDz5jQG1Dwq0WBUPnpWTN0WzBt+ClbG722aHAWNgAOLDsiB+m9SGQMDubPrLPVGNGFgMIjJgHn3ERppME1qUWe0ZqXMhGRoNWlnvB3V4FG8fT75xEC10JxiRNmgUdSnUjGDZySTIJCLiaHoyfOjejfCw/ylYbcsA6ebBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=cdGRZobw; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr10.hinet.net ([10.199.216.89])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58G9pmGM037025
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 17:51:51 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758016311; bh=feCW9LyeqhzGuLyuc0GLu+qEpYk=;
	h=From:To:Subject:Date;
	b=cdGRZobw3r9HE2VKdFWFdUS3ul0YRWj2nG8i+IrBMF7hyhHIQt4Z/YTgvIznLlWBF
	 xd9LwnSFByn4i1V6PuWdqZ25Qb9/9romPPHuhahfCOcrEHN+vMzzGTfT1kVJzb4NwN
	 GbO+oVKmPpTgx3C3DUGaeBzW1LmLZ1knFErcAtOQ=
Received: from [127.0.0.1] (118-170-0-139.dynamic-ip.hinet.net [118.170.0.139])
	by cmsr10.hinet.net (8.15.2/8.15.2) with ESMTPS id 58G9j1uE281612
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 17:46:53 +0800
From: "Info - Albinayah 765" <Linux-fsdevel@ms29.hinet.net>
To: linux-fsdevel@vger.kernel.org
Reply-To: "Info - Albinayah." <sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gOTkxNjYgVHVlc2RheSwgU2VwdGVtYmVyIDE2LCAyMDI1IGF0IDExOjQ2OjUxIEFN?=
Message-ID: <4d42dca6-10a3-f4bb-bacb-bc1e9175075c@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Sep 2025 09:46:52 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=V93e0vni c=0 sm=1 tr=0 ts=68c9320e
	p=OrFXhexWvejrBOeqCD4A:9 a=Yn/GehCQGalBAclSqUIbzQ==:117 a=IkcTkHD0fZMA:10
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

