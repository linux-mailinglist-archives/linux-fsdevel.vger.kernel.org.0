Return-Path: <linux-fsdevel+bounces-60416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A54EB46963
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 08:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A21D5A64A6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233DA29E0F6;
	Sat,  6 Sep 2025 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="SwFQhtS/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66514B086
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757139024; cv=none; b=NQsL0DjwDGbGxxFkDIHdra7UL9Ky27So+Aji19+fZ+KAhm26ny/mvF7zPXaF886FOjJzcSJQoc6hY5lQNez3n+Ttj/u5JZwjrnDci66MnrJe1JYc5nteYv3PUuxOyHFtfZsWrzOm1S0NemWL5UlCMxsMSKBDuu0wPdFzydnet88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757139024; c=relaxed/simple;
	bh=6SzxGHmNXzbefVo2fxX8Wyri4WNEy60Ee2B+ikhpMLw=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=rEzdx5PqjI6qV5RrqPXb5rGPXiYjdgF4CzYi4S8lkTUmw83lTAPT/AQnggs0pHGZYhYVUjxijbk8sxKKi4H5X+02d8eTkqUdtS2kBkHXCONIULTsjDqoyYeNUrPn4qgyAmekqW05TfDZv7WK7dei3mGfbXqjBdwg+IVIP+IxlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=SwFQhtS/; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr4.hinet.net ([10.199.216.83])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 5866AH7Z961492
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Sat, 6 Sep 2025 14:10:19 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1757139019; bh=feCW9LyeqhzGuLyuc0GLu+qEpYk=;
	h=From:To:Subject:Date;
	b=SwFQhtS/nlJ+REd7Ukmy5BGEYdZEFoNj3YIYMJ49sQZzBx1O88j587RXR/QJWPeet
	 CPcjezryB0wLChWBcBvEqUemF2E2n3KbNUQx0LxMYW+650t3E+78lBepOTAlvXqS4t
	 wm8sekhn+fGkY0CYFKT0cDoerJ3ky2tmZSPjQC50=
Received: from [127.0.0.1] (111-243-153-128.dynamic-ip.hinet.net [111.243.153.128])
	by cmsr4.hinet.net (8.15.2/8.15.2) with ESMTPS id 58663kKP729422
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Sat, 6 Sep 2025 14:05:23 +0800
From: "Info - Albinayah 582" <Linux-fsdevel@ms29.hinet.net>
To: linux-fsdevel@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMjA1NDYgU2F0dXJkYXksIFNlcHRlbWJlciA2LCAyMDI1IGF0IDA4OjA1OjIxIEFN?=
Message-ID: <62b0b1fe-ef40-861f-f75e-81d549c4c973@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Sat, 06 Sep 2025 06:05:22 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=V87e0vni c=0 sm=1 tr=0 ts=68bbcf23
	p=OrFXhexWvejrBOeqCD4A:9 a=LWD7ruzaBuI9r6QGgxaPaw==:117 a=IkcTkHD0fZMA:10
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

