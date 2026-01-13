Return-Path: <linux-fsdevel+bounces-73367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DECAD163FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 03:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53D3F3030FD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BFC2D8DAF;
	Tue, 13 Jan 2026 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="fbQYBnUj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCCE2D7D41;
	Tue, 13 Jan 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269632; cv=none; b=uStaxxtUNEwj4zs2Jne7cQhHI9wG0mm1HG/75PWNPwGVPOI1Gk2840BHPAv74LFuOtsCHV+eDviK8lWZ5ztpb7lOSrLgTo9C3LkoTC/E2e9/owc7ePR3I3pxjHGr5LZzTl7MBWhdZGzzi+AQubwrOi2hOxP1pckA0f/hHOIrboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269632; c=relaxed/simple;
	bh=cpMMSXmxxAK/oz2nR0lbi8N/BFlxzjt8GL5z0xcp/9A=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=nAJK6QAl7qC2JZIOS1BZrJkRt2oragDdpfYBxv3w6bAcUZNVJns+e3OWnTxOjUpFKNm0LtfPNO1kjYVO3mAp0HmSvs7DqH5aEYpRbsUpjpIZpC8qN1J3PiqLJ2byMx+TnjrgKFEzopRjZM+s34eGsSeIuWoNHM5C9Ftv1Ympg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=fbQYBnUj; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=cpMMSXmxxAK/oz2nR0lbi8N/BFlxzjt8GL5z0xcp/9A=; b=f
	bQYBnUj2Twy3AHfRba6wPyvWh1IVSEZVHlnZGVIaPV1SjkfJyK6C/P2/2e7cDf+y
	pTj4N3HuNrYyNbsBsj3dZ0m38dARQqxWsJxf2PjksjujZzLUpm5esStCIis6oFEb
	rIy0ppNTZcGLRkhBbcOr/hKwWgak9/kd1P0VzCojOs=
Received: from cp3alai$126.com ( [49.7.65.243] ) by
 ajax-webmail-wmsvr-41-107 (Coremail) ; Tue, 13 Jan 2026 10:00:11 +0800
 (CST)
Date: Tue, 13 Jan 2026 10:00:11 +0800 (CST)
From: alai <cp3alai@126.com>
To: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-mm@kvack.org
Subject: =?GBK?B?wLTX1GFsYWm1xNPKvP4=?=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 126com
X-NTES-SC: AL_Qu2dCv6dtk4q5yCdZOkfmUkUjus3WMKyuv4u34RQPpF8jDrjwg4aTHFNLVTZ2dCFLSqMiTaGVSZo9+Z/T4RIYKUOLK5IUAtaKRTxyH8BokwUqg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <697cd2e2.171a.19bb5150035.Coremail.cp3alai@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aykvCgDXnxArp2VpysNDAA--.50487W
X-CM-SenderInfo: lfsttzldl6ij2wof0z/xtbBrQunZGllpyuk1wAA3W
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpzdWJzY3JpYmU=

