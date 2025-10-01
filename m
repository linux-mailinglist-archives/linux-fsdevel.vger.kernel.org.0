Return-Path: <linux-fsdevel+bounces-63163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CB0BB00FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262ED3AB46D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE062C028E;
	Wed,  1 Oct 2025 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="KTLrU2eg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D627A927
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315976; cv=none; b=bZfyE/ah0X9sFr+0QtrehPo5GXRgF0q5i6pBe3fDzZdgKmH9hCDSa480zZmzNTJlZeTBtLS/qpShR+t9LUP6u4LRROL6U0Hmo/C3Xip09bfssKX6OMtNRy0Pt83FYy5d5Eyh33Qe4s/e+7vSERzeDfTtyUTUoagrI495wkebEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315976; c=relaxed/simple;
	bh=6SzxGHmNXzbefVo2fxX8Wyri4WNEy60Ee2B+ikhpMLw=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=sxUhyeQrxOMcj9M6gdinZLqlTUhygthfgqjBLaBL0ptaVvC0K74hxdbPdVxtu3yKFnvunzOv5s5Yb5rmstOfNzasRkz1pmN/LjlwNAKB3QkIFjGkGtQqFZ9mI73CI7WViFv2fF1xk/mXvkKYAhNqG6nE5MBallPahO37cLld2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=KTLrU2eg; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr6.hinet.net ([10.199.216.85])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 591AKCXI187531
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Wed, 1 Oct 2025 18:20:16 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1759314016; bh=feCW9LyeqhzGuLyuc0GLu+qEpYk=;
	h=From:To:Subject:Date;
	b=KTLrU2egptDWLXZ+JIRTKXx2mpRIGwGRX1J9ABfxK4CsF1NjKxT3D0g8OVViu6bRf
	 9hgZC3FRYIvUMuZMBypTktRlHoHwhcjzaqRqjhWvgm26DSg4UtXeSymwuM3x18l3ve
	 RCgj9pJZH4EqNt+18DyiMnLoiN5KZGBOWHuj1b7s=
Received: from [127.0.0.1] (36-229-220-118.dynamic-ip.hinet.net [36.229.220.118])
	by cmsr6.hinet.net (8.15.2/8.15.2) with ESMTPS id 591AF0US111944
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Wed, 1 Oct 2025 18:18:20 +0800
From: "Info - Albinayah 184" <Linux-fsdevel@ms29.hinet.net>
To: linux-fsdevel@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMDA0NjEgV2VkbmVzZGF5LCBPY3RvYmVyIDEsIDIwMjUgYXQgMTI6MTg6MTggUE0=?=
Message-ID: <84dc7821-bdcc-b26b-0435-e3effdf7b7ca@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Oct 2025 10:18:19 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=L46+QPT8 c=0 sm=1 tr=0 ts=68dcffed
	p=OrFXhexWvejrBOeqCD4A:9 a=Vj9/uF/yNhCp9ba9uRU/1g==:117 a=IkcTkHD0fZMA:10
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

