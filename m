Return-Path: <linux-fsdevel+bounces-50404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9909BACBE90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 04:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFB63A355E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 02:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618415382E;
	Tue,  3 Jun 2025 02:40:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.meituan.com (unknown [103.202.147.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F3A6BFC0
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.202.147.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748918407; cv=none; b=Oa+t3iVrJCHIyZP1TJcuihsMiZR7ODAPwRsXT7582ga5KmoBD+iMUE3gKytJpHUxvhJe3IahPSjYLE1UrPmsxH7hWG3qxfWsI5Dm8cDCbOIiYberK1RfR/IfjL8XYWq4zJ/tZNEhZAN/V/IwhauMsVkJpngoxmwPU7EXPfmjZ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748918407; c=relaxed/simple;
	bh=kuTMt1VodnYhz84qN/6CpT1dmbNBmO1uxGAfcrDY8dA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Qmc4w4iYpodHvWRkliR36W5xP5A0EeJbkgBTu39AybjRVSXvOT2K+diWN73rGqKtRSfEkfy2aDg5M6MecuDmz820hArHsTK79aBzA4u0Hn1FdcoZ/uajhXgX1AmGsNQfca6mJLOGYb05R702901jItC+mkGi9OhIzSOg8DFekZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=meituan.com; spf=pass smtp.mailfrom=meituan.com; arc=none smtp.client-ip=103.202.147.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=meituan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meituan.com
Received: from JD-IT-PW-EX14.sankuai.info (172.23.128.74) by
 JD-IT-PW-EX16.sankuai.info (172.23.128.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 3 Jun 2025 10:24:52 +0800
Received: from JD-IT-PW-EX14.sankuai.info ([fe80::c41f:7f37:e139:e9fb]) by
 JD-IT-PW-EX14.sankuai.info ([fe80::c41f:7f37:e139:e9fb%6]) with mapi id
 15.01.2507.044; Tue, 3 Jun 2025 10:24:52 +0800
From: =?gb2312?B?wu3V8c/I?= <mazhenxian@meituan.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: subscribe linux-fsdevel
Thread-Topic: subscribe linux-fsdevel
Thread-Index: AQHb1C6vCwZJ1X8m302TR7pjgzT29g==
Date: Tue, 3 Jun 2025 02:24:52 +0000
Message-ID: <8AA7A7E8-160E-4FFD-BCB7-737E77C39950@meituan.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-ID: <619B238D21FAD74F892F2D45EEA8BA93@meituan.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

c3Vic2NyaWJlIGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo=

