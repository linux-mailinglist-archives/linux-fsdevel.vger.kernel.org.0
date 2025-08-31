Return-Path: <linux-fsdevel+bounces-59721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199E4B3D4CE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 21:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E4F166D87
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 19:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB8625BEE5;
	Sun, 31 Aug 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="ftRws3jq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cmsr-t-8.hinet.net (cmsr-t-8.hinet.net [203.69.209.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65B20CCCC
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Aug 2025 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667114; cv=none; b=kSYSJNAc2aGgsM20ucUXWJ8xA3gSh/EPcfkxWE3llOcoPDacRni6Cwz94O82pebcF9tW2zlRq6Rs4Rlnp5ECaCscIj5eXNAnu0tvQ5mRuOxssAIZlCLimsCgEgpHzl5GqqMFkzehnYZjdoDgwN69yP5YrYBv7KXf/1LfrLQ+U38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667114; c=relaxed/simple;
	bh=6SzxGHmNXzbefVo2fxX8Wyri4WNEy60Ee2B+ikhpMLw=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=XG/6AZS7+tMY5Hl4p3ynMGeHBYh0MTBzJvc9OBhkx7Pn9+ub9E9vawio9Xo8aVWsoShpzU77qRgq56eEPMfpfRF5pl6YNwz5+WmrKHKNPUzcg7exuIh0gFSLnq5EtGgoqBcEx2oBz73DKuHUVlt7wjhtPka69lAd0tJ0LX3LQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=ftRws3jq; arc=none smtp.client-ip=203.69.209.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr7.hinet.net ([10.199.216.86])
	by cmsr-t-8.hinet.net (8.15.2/8.15.2) with ESMTPS id 57VJ58Pl854906
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Mon, 1 Sep 2025 03:05:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1756667108; bh=6SzxGHmNXzbefVo2fxX8Wyri4WNEy60Ee2B+ikhpMLw=;
	h=From:To:Subject:Date;
	b=ftRws3jq3NGxhC2Vm7a6vlHNM6RHRC/WP2Abi3JAOUoXDqh8mFNw17ScPKFtlkIUE
	 4riUW1jzAbvhkQ3YCmHS+2t7DCK2wkFzDbhFLCJqCJL+UKemsmd5NMxgDCJ1YSzHRE
	 XakiArjA/FDOdbn2p4OQn1sJo0iSEUfnLE4OH4Yq49uCtqOTVe0zXtp0I1uDmdm5rs
	 KA1bhbZETtGr7QB3bed2yP/sQELW0Ld2eVpIwfqQCgk2AMnUn0oMG5q4g3ttxOuSnz
	 /yiiL26R5IpiTzw2NdtEOUbsyN++3ZdKQC5SzdnIxI1S+6SsMES5j8S9eHaPOQWAt1
	 ckMc7AdnpM8CQ==
Received: from [127.0.0.1] (36-226-131-87.dynamic-ip.hinet.net [36.226.131.87])
	by cmsr7.hinet.net (8.15.2/8.15.2) with ESMTPS id 57VJ34gP297704
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-fsdevel@vger.kernel.org>; Mon, 1 Sep 2025 03:05:07 +0800
From: "Info - Albinayah 104" <Linux-fsdevel@ms29.hinet.net>
To: linux-fsdevel@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNDUyOTYgU3VuZGF5LCBBdWd1c3QgMzEsIDIwMjUgYXQgMDk6MDU6MDUgUE0=?=
Message-ID: <9e4ab41e-80af-975c-5900-13100c50e1fd@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Sun, 31 Aug 2025 19:05:06 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=ZJd0mm7b c=1 sm=1 tr=0 ts=68b49ce4
	a=cWVjYNg22us+amK5Vx430Q==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=OrFXhexWvejrBOeqCD4A:9 a=QEXdDO2ut3YA:10

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

