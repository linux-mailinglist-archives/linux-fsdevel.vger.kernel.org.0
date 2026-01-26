Return-Path: <linux-fsdevel+bounces-75547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPpELB7ud2kVmgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:43:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 124A78E027
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 23:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 806533032CCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16092F549C;
	Mon, 26 Jan 2026 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iGIAU0nI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC944301001
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467373; cv=fail; b=ZHpDjpd7aEp0qQO5URyqv4rLaJL174GKhGwdfVNGSdwNVehmhwsApf3HfKB5DKVmvtjJSOulR74LpGcPARnVWwCnIxnWcmcBV6PAUyXP1xgdeczyHJVHX/J2Ogj0yHKVUvYSbThXK8RtBPLm8N9l3TEIF78JLF9quzCVnOcm1gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467373; c=relaxed/simple;
	bh=jvzkYsBImbjASoj+UQ2XljJvX65yz30R4230kHlCoVU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=hrvqjVFrTPMI/hZCzd0ul2Y4LT6WZ1ZfpBtZCA7U6eUuGtzZFuju5cg4CcJC0r/tVkVjMplw/4IVJhOmpqc8X3Ox+EmMTsW1FGgN90ufY3IA1B6RnfhgF3RBwIp1i/L9Wn7wBeYUp2MMM9BUcFWUJXZM0owbRoSLmu02815al7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iGIAU0nI; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QGWksu006488
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 22:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=t5TX4OaOoxSWvpSwdVZzLzWJ9lQj/3vYa/8nCIIz/lc=; b=iGIAU0nI
	9W5Vp05ykw0xpLbWmeVjaXLBA3XQA3U1jRUbcKrLfwLT7JkUfmx2uHt3Ow1c+3Xm
	XUDd0FWkdyfnCeUfwvNr4GD7oASoMxe9QnT1oEpBmNUixzro+VghIZRD+xFvGiIU
	qfq0q43UhgAHUi7p6xN55dg8alVi79EFkLMBNjQqxiLuudaoGN0KCcowC5bmfmBa
	LpAg+uVUK5aqO4JfX7QK4Ysf+cncU54om1T/NxuPb/M+sBtiy4US+oO5vsfocs7F
	4D330PCCymzfnQT4upcZWDyZgr0KX8R5KHY/bnxa6kBGV+xmw3KxKDvRw/1T2OWC
	8neQyjAEOFwt9A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfs40y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 22:42:50 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QMcggF031116
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 22:42:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfs40w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 22:42:49 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QMgngE004862;
	Mon, 26 Jan 2026 22:42:49 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfs40t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 22:42:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCGGkngKtgD9W9Gh5+g1qKkK0lYXROD72zzWCZGjhsP9dIkBHDttibnRN37VnT+U0HsXJclf36kYO2hVXz4mEUlLY+OPDFETlp9rto070uxMMwerey0nBYtS9b2GPRHt2Kf7qYgqp9G8Nj49WOF+hAUKuall/+5cxxNk93UimAfujoZLKwzlfgnqntkF3ImRezFHl9+EOJvz6OqCstxwrqxXgRYCT8AC2J76CoGDAx3HKKVVIt+/b696gQGUV1t7/qInwq129StReQyaDo4AR2/uQqYsfGSFKHHDVbY2UWco29kpFj9TWTG0Rk+ulmMxqg0dGYLVlBWVzq9dtgN9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpKPnVb+W/7k0qX2FHVcUcyLhj/9aA98qm3JRrxVyN4=;
 b=Jfct2pa8/CZh8nzI7ba3Gln6SBfXKSYuzb1JaWU8A/7dZoe4HgpUsVc3QmuurwN32Q/MbhqFJ15OvFJ3dTtF30xcK+U6UlzxwwrpwjfeOVL+Qwdzk6u4fhqGiLwc5wLy9xpkV8aGMdmYji5LDU/2kHA10qRX6ZyxBvkxOWLHSRJmiXiJOrEUzdIH/9N5sYlbt0rDIetHspbBakfwmh/yWzebvKelRcWTOUoL9rXlPPY/KGvIfSYbprmYiqjjvZtLT+iTqMB1z1G37vetvSCubepWls19KYBooWcmRu0lAKBiQc6jxcC2eqDVBKqdym+sj4H0HSyhz8nfKubigBXO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4766.namprd15.prod.outlook.com (2603:10b6:510:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 22:42:49 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 22:42:49 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>,
        "janak@mpiricsoftware.com" <janak@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>
Thread-Topic: [EXTERNAL] [PATCH v2] hfsplus: validate btree bitmap during
 mount and handle corruption gracefully
Thread-Index: AQHcjaflnJcGDC2HW0iE8SCLfauYebVlDt2A
Date: Mon, 26 Jan 2026 22:42:49 +0000
Message-ID: <11c93c90c986ab0bc52d19c0e81463cbba004657.camel@ibm.com>
References: <20260125030733.1384703-1-shardul.b@mpiricsoftware.com>
In-Reply-To: <20260125030733.1384703-1-shardul.b@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4766:EE_
x-ms-office365-filtering-correlation-id: 156a59e8-45b1-47de-d98f-08de5d2c3bd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkFaMTF5QjNGVGZ3THJETFg5QzkvckZQVVAwZ29EcWNPY1k2SGx6SDU2ZEgv?=
 =?utf-8?B?QkkwTnFoOHVOMCt1NEZySEVqcG5IMDl2eEt3Ri85UWZ1ODdEcUh0NlpTa0No?=
 =?utf-8?B?RCtwNTFGMWNyWC9ud3hDdTJpTjdIR1RpdWNqVHpHL2IzUVQwd2UydkR6L0lX?=
 =?utf-8?B?VGxkRXJCY3BKWC84cjVMNktpK2FwWEhCalBKYkxCQWw0b2JvdllPbGhkVjB3?=
 =?utf-8?B?QU10NEhZc21UeGUxalc0RnlPK05EUldGdzVZaXI0d3IyS3JNLy9SOTRxZDZz?=
 =?utf-8?B?R1BxVlBFS3ZjeC9ZMklvWG1QcEwrdm5CbGtwWlNmckFqcjJ2M0VPeU1OWDJE?=
 =?utf-8?B?MWxVOEJpQkVRNlBmcXA3ajB6TXBHVU0vSjIxTDJOUjdEQkR6RitRQzQ1UkJX?=
 =?utf-8?B?YkpQRWtjRlFMakNjbEluczdjdnlOcjJIRFd5OUsyZzZCRlF1eWZZQUpMM3JK?=
 =?utf-8?B?ZXdSa041cUVSOGNnRkMwdjJveG85VU9FUGZTWXk2Z0llcGhKRFNPSU9XMkYr?=
 =?utf-8?B?Nk9ueXBkNTdEWlBuSGsxUlJYQnkvcnNab2dVY1BTNmtOdDNwOTRSeVNRSnN4?=
 =?utf-8?B?Rmw5SU1lYnhWM1F6YU9XR0VVeDJCcXJ5QUR2b3ZUQ090M2xEVmV3aUdadkgr?=
 =?utf-8?B?Ym9jQWtpaC9XY0N4MUcrZFk3ZG5JUGJXeGJvcGVpK25vcERrVk5ZMDZDUXVp?=
 =?utf-8?B?MFJRaFNZU2o4N3RuZnpOK1NmOXd6WkxORk5GQUN2YlgyVWs1b1hJZUFmRytw?=
 =?utf-8?B?SGZDNmx6MHRRVk9LTnlvSkNuaU4rNTY5Yk9IZ2x3M0owUFdUYnluVEphSGh0?=
 =?utf-8?B?TlNmd25iUkRWRTNsZy9iQjAzTStUeWZ4T01SUWtJNUI3QThoYjQ2MzZsSmk3?=
 =?utf-8?B?V3NQNGZTM0V6ZmNTK3FXbGkyRFFmQ0hOMG9nWW9mVUYyZStGc3E0bXZCZDFw?=
 =?utf-8?B?TmVEVWhUbUJnOW9mbkRIWHk5bm9KU3FVbzU0RWRjU3J2MFVVQkxjcitwNDJx?=
 =?utf-8?B?Z0VkYUdVK2VvSU1WZ0Z0Rk5FQTdaaEtNZEpuZDFPM1Y1Nk93bjd6VWxKUmpv?=
 =?utf-8?B?M2Y5WnQ4TlZobjBzSFRIYjdHTlVDRTJHWmpjdEFwOWppbWZDZ3BROHluZVRn?=
 =?utf-8?B?dzMreU5wT3ZMbk9oT1NwNTJWT2lsMGdDaXdrN0tneGRSNloxaGRTOG9sTXVC?=
 =?utf-8?B?R1hqbXF4cGVub2dpc3pGeC9nYVViemhHS0Y1bmRHbUZuRk5pVXpuRTNZWlAy?=
 =?utf-8?B?a0kvcDZDTUN1dWRhclhuNld5OTdzMUZ1a0lSTDYyTlZqNktRUmZMNGxwMlRV?=
 =?utf-8?B?SUZIL2I5ZmJvdVBFdWtXNDVZZ3BPUy9CNHdERTFsWGJPY21xbmFXQ0JHQjFD?=
 =?utf-8?B?L215SG1wMktGc2RuYXBCMnJCcEY5MmlscFlJNEtJajdpVHA3QzQ0eExrQWVR?=
 =?utf-8?B?Zm4wMXBKWGkzRnVPblZNemRXeGp6aVVCV0ZVQ2pnWXByVFRINk1LMXpES2Er?=
 =?utf-8?B?OFlYcEpiVGxsaEo3YW1BRlkyMUNPQndjN1B3VVkwd3lURnNQMzd0TTZNS0xF?=
 =?utf-8?B?aThaZlJFMi8wcUlVYmVCN3pVOGphWWo1bEIyUjJDRGNpc1RGVUZtUC9OeEIy?=
 =?utf-8?B?T2R0MFhkd1N5MisxdENBVGhsZDRCRmNTQW9WNSt0ZmdXdlMwT280bmpjei9P?=
 =?utf-8?B?Y3FkTVV1OUpvWUN4d2p6cFpkWk5CWEgxeVF4UVZ5TXNNbE44MWdOdjYraXRn?=
 =?utf-8?B?N3FkbTFJTkVqcUNSaXQ3a0dvSVVqRTlCR0RBN3h3eUM1UXNiaDh1YWIrdk1C?=
 =?utf-8?B?NEc3Rzg5MUR4MG9JTVkreDQ4WHc1S0hGS0pUdFE4eUlaTDZtOElqYTVpSXBv?=
 =?utf-8?B?anFqRStaVU5CSDZtVkU1a3pTaVBsUnpUVTdrU0d2dTAxTjJ3Z0xWSXNoN2Jh?=
 =?utf-8?B?M3pqeDhUcUx2YThEMk9ydWd6K1RyWDFGWnVOMVFaYktUVzhGTzVvUDJUVDMy?=
 =?utf-8?B?S05sY0NyRExUd3ZMejdPKy9BMk5jMFBIRy96aDE1Mmt1S2czaHgyaTRTa3ND?=
 =?utf-8?B?ZFpBcTJsbUtyQlhBbWlJcXU0L2ZJMFgyeEw0M1labDJxamp1cmJmTkU0UUFD?=
 =?utf-8?Q?/Z5FM4XB25PQuxmezQ5jJzhyb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlY0bVlSVEpuSWdQamdlNEN4WVI0YlZETnU4Y2VnYUhvajRsdlFJejNOUllX?=
 =?utf-8?B?d3ZLY0dod3NqV3BJVnNIS1lwWmIrWFRJTzJuQzNwempoZGdUWjdQN0x3TDRY?=
 =?utf-8?B?R2x6b2FHckJyamRoYk43YWJ2R0VZZDRzQUVLTzJuUkR6MTVLamVRY3BqVm5S?=
 =?utf-8?B?cWFhL1JsQlRhTkZEd28rUWhmR200eVQ3RlBpc2NzdW1tcnpIdlFZVS9rWXEr?=
 =?utf-8?B?Z0dSN3B2MHhMSmtpdThBU29MbmtJRXZCZ0MydklwZjNHSXI1VGpzQ3o0OFhE?=
 =?utf-8?B?ZlhtVDhXbHdjSDBTYy8vQlBkWTNzdStvaHorak9FWDBkeXF0QmREa3VnTWI1?=
 =?utf-8?B?QkNtRzhXNlNSTVJxaXlsZDNmdkpJNmxCRnhlY3J2ZTVKUy9JLy9YRE1mOUNR?=
 =?utf-8?B?UFpWaTMyOGtPaElTVW5VbWpBdTVicWI1ak9BazNFSnljOXlodHFCWjRZYkg4?=
 =?utf-8?B?bm1taWdSaUpQczd2dVBYMEdsaWlpbkZ5eCt2eVM1anNxYWJyVWIzdnhQS0Fv?=
 =?utf-8?B?aExLdUxrcmxYTHlxVWFmNzl4TnNrT2hBYUJ5UTR2TXduclpLWGNnZzMyV2F3?=
 =?utf-8?B?Z2dUazU3RVA4eU9HdFZHRlJ4cHF5NjJabU9wM3RmczhsNVkxTjYwRWtDSzBB?=
 =?utf-8?B?d3gyamdIS0xtb0lJLzI1RDZ3L2RsQkp0RnlaczAxNUN3NForeVkweU4zaFBn?=
 =?utf-8?B?Ymp4S0EwMmxxM1lEb05LZWc5c0tHZWJXdjY4T2xiNURHd2pqU1ZMQWJKaUhH?=
 =?utf-8?B?dm9BUm1KSW1ESVpQV0NLS0VCNldjemhSWmhQRDE2WlVLcGhlV1pvK3hWNVYw?=
 =?utf-8?B?ajJCVnJiWSt2R3FFU2U0VmkzL2VwcnUwQm5aNjUxay8xV3poQWZ0YWRLQjRp?=
 =?utf-8?B?clZ5cVR2K3lreDNiT3FQYVVvVENNUnFxejIyZ21sS1pVWHh4VHhLTVBiampn?=
 =?utf-8?B?eElwZUE0blNPbk96bEhJUmp4OEhaUFlOSGVSMEVZdVNXZ3ZsRHFaMHpBY2Rs?=
 =?utf-8?B?N01ISlM0TkVvR3IwdEZhQVlIQ2ZsUG1XRFNDQmNnQXZpWk1UMnJDUm1NMmRh?=
 =?utf-8?B?T0dONWo0TkJRK0JOSnFFS3hFMXFLbTQ1YUo0SlpXNE5YT0lMWVhUU0MwVEhz?=
 =?utf-8?B?bzdzaGtsZUZZQmR6UjVPQlJqY2tNL2tQRGJLNHd2bVFlc3hGa1M2OCtEbDJL?=
 =?utf-8?B?YVVoQk91QUtsZURyNk9ORG5oRjAwbk5iSnhGVEtPMU4xUzQ1QjBNd3VOUmRx?=
 =?utf-8?B?TGY0NjJnaFZGa1psb2dEKzdCc29RUENmYVdaekwrbmxPY1RFOFhkTzJ1S01I?=
 =?utf-8?B?WFFVbElsOU5tTTlOcDNsUFJWdXBFRVRtV0ZDQzNUa1k3QTZoeXExQ3BQTE5U?=
 =?utf-8?B?b2Z6K1Q0NGd6bW01QWU1azJROStrWGxiRnlXWFp2anlVb3JwejV3dnlOaUh4?=
 =?utf-8?B?NXhtcS9WNDJEakxJOE5ReU1ybXRlek9IcmNzWURjN0dPRDkrOVBvQ3ZXWEpN?=
 =?utf-8?B?aXpFdWNxOGFQS2VJajRwMzA0VitSdnJkS05VNDNCcWdlQzB6c0xPd2EwdjhT?=
 =?utf-8?B?Tm9SRmRBKzJBTWxPTXIrQU9CaHRjdnJEVVdmNGtQWmpsdi9QUnkxWjk0R1VB?=
 =?utf-8?B?bUN5Nk0zNUQ1V0loaWN0V3d1UFVRcVpOTFF3cVNhYXkrRGRmVWFFRDJCN0ND?=
 =?utf-8?B?cC9hYlFycitRU1J6bVZSaFRnNlYvUEY0THdXNFpkdGR4dWlKeFN2RGR0RGFk?=
 =?utf-8?B?YU9yNDYrL3pQeWgwZ3BEbklUZFhPSFQwVHQ1SFJORmlCRmc1TVU0NDFuRENO?=
 =?utf-8?B?UG4vQ1NWMlpCUCtDOWsrR2RiWEthVlp2M0xETHNyakxmZ0N0WWo1RlNMVE5N?=
 =?utf-8?B?clJTeHVreGVIRnlOajRWamhtMDhBd25OMHJKTGRZdTJTMlB0M2FMZTdJd0RB?=
 =?utf-8?B?b1pIL3E0dTBHRmpCUTc0cnJic0RONVIyTFRLWlNKOWNSTi92SkxJSEhZTEdz?=
 =?utf-8?B?YjBHZGlHVUFvMmtLd2JudW1DNlVjeW9mVm1nbWRmUUp5WVNnbHVCZ0RvekZ1?=
 =?utf-8?B?TE1IMUVHaWN5bjNLZi9LMkxkb1ZDeFQ4bU8xZFJwT3RqcTAvemU2dHA2eE1s?=
 =?utf-8?B?ODdqS2hraVJEa096SWY4ZG5rR1VTaVgwYnJsOTl4YVFqQk4zMHhBSTFMNk0y?=
 =?utf-8?B?M2tMcTFuM3dUdkdpc0pOU3ExbzZhRnd5N1BXdmlUUmV1ZzdkS2krM2ZTTkVa?=
 =?utf-8?B?SnpFdko1THArdkNQVG0yTng5Z1R1ZkNRZDhMakhhMFRSQU02amZOUHdkSDR6?=
 =?utf-8?B?cUY4ZlR2RmdsUTFIZWoxZGtucU4xQ2hJSHd1TkE5MnMzQnFzTGFnTUVwTEF5?=
 =?utf-8?Q?E3R/NUSBRFYIKrgWKwe6IO14g9eMyZX0n4W9G?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156a59e8-45b1-47de-d98f-08de5d2c3bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 22:42:49.6885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPI9gZtB+eM830r2M/bB/g3QURHPCSv+AS57SpDhj6Mr0GdYF9wyTH2eqTKzhMwqYn3SVAlsHLKihl72t1GmMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4766
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=6977ede9 cx=c_pps
 a=vtur6dA+JiXx+GD1nKNobw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=hSkVLCK3AAAA:8 a=szKgq9aCAAAA:8
 a=Jf970vQZTNBStanUW2QA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=R_ZFHMB_yizOUweVQPrY:22
X-Proofpoint-ORIG-GUID: YlTD4241TXYJ0DD8Dk11YjYzrbGwbtMM
X-Proofpoint-GUID: mwQSw-Vh0-ONS-NeJYBOJ4NBJiRl_dz0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE5MSBTYWx0ZWRfX94OtWCqN8UJ8
 T9K4JnanSnGt6HID47xvF/8eZEOb3e1T9EKj8Y2tZA35N8oRO7klUviTBvfhOU+qCT5r9muvl4g
 aqBD8EYlInvHEwkORvHkKNQpp/esMnEUa96/k0o6Kztn/olAkPhuzWXSLA/2ZWlBtFZ+SgsrIj5
 9XHTRz+NOFeuze+7rn2ACVnn+5n+8iDRDqy81OmyNMF0jQJNGbPjDqI3IR21kkQ/f2i07focgnP
 n13e3XoJjNT7y7IM3n3SsK4uzCj8aOtz0i+PldPenYH880/svTFvm5I+SK3bFzIFwhiNODpFMjP
 ZoKkU6OHCcwBypcQhLyJxgFpRm295p3ecSTp2qV9DpkNR7jbzYWg/QNagNwyPgaxPJVLFliONq3
 IayvTo/JdZMsTtehCs35bWK3r400Phs02SASzVacWEb2gJ7pIRAwwwWKYlHxfrJTVHkBwpQUS2l
 Z9dvnNJ6a8nUbH7zjIQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F451F73F635D74CBAC1A7309845B51C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v2] hfsplus: validate btree bitmap during mount and
 handle corruption gracefully
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2601150000 definitions=main-2601260191
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,mpiricsoftware.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-75547-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpiricsoftware.com:email,syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 124A78E027
X-Rspamd-Action: no action

On Sun, 2026-01-25 at 08:37 +0530, Shardul Bankar wrote:
> Add bitmap validation during HFS+ btree open to detect corruption where
> node 0 (header node) is not marked allocated. When corruption is detected,
> mount the filesystem read-only instead of failing the mount, allowing data
> recovery from corrupted images.
>=20
> The bitmap validation checks the node allocation bitmap in the btree head=
er
> node (record #2) and verifies that bit 7 (MSB) of the first byte is set,
> indicating node 0 is allocated. This is a fundamental invariant that must
> always hold.
>=20
> Implementation details:
> - Add 'btree_bitmap_corrupted' flag to 'struct hfsplus_sb_info' to track
>   corruption at superblock level
> - Create and use 'hfsplus_validate_btree_bitmap()' to return bool
>   indicating corruption
> - Check corruption flag in 'hfsplus_fill_super()' after all btree opens
> - Mount read-only with consolidated warning message when corruption
>   detected
> - Preserve existing btree validation logic and error handling patterns
>=20
> This prevents kernel panics from corrupted syzkaller-generated HFS+ images
> while enabling data recovery by mounting read-only instead of failing.
>=20
> Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=3D1c8ff72d0cd8a50dfeaa =20
> Link: https://lore.kernel.org/all/784415834694f39902088fa8946850fc1779a31=
8.camel@ibm.com/ =20
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
> v2 changes:
>   - Fix compiler warning about comparing u16 bitmap_off with PAGE_SIZE wh=
ich
> can exceed u16 maximum on some architectures
>   - Cast bitmap_off to unsigned int for the PAGE_SIZE comparison to avoid
> tautological constant-out-of-range comparison warning.
>   - Link: https://lore.kernel.org/oe-kbuild-all/202601251011.kJUhBF3P-lkp=
@intel.com/ =20
>=20
>  fs/hfsplus/btree.c      | 69 +++++++++++++++++++++++++++++++++++++++++
>  fs/hfsplus/hfsplus_fs.h |  1 +
>  fs/hfsplus/super.c      |  7 +++++
>  3 files changed, 77 insertions(+)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 229f25dc7c49..0fb8c7c06afe 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -129,6 +129,68 @@ u32 hfsplus_calc_btree_clump_size(u32 block_size, u3=
2 node_size,
>  	return clump_size;
>  }
> =20
> +/*
> + * Validate that node 0 (header node) is marked allocated in the bitmap.
> + * This is a fundamental invariant - node 0 must always be allocated.
> + * Returns true if corruption is detected (node 0 bit is unset).
> + * Note: head must be from kmap_local_page(page) that is still mapped.

This function works with pointer on memory region. It doesn't need to expla=
in
the details of how this pointer has been prepared.=20

> + * This function accesses the page through head pointer, so it must be
> + * called before kunmap_local(head).
> + */
> +static bool hfsplus_validate_btree_bitmap(struct hfs_btree *tree,
> +					  struct hfs_btree_header_rec *head)

I don't think that we need in struct hfs_btree_header_rec here. We don't us=
e any
information from the header. We simply need to provide pointer on node itse=
lf
and it can be void * or u8 * pointer.

> +{
> +	u8 *page_base;
> +	u16 rec_off_tbl_off;
> +	__be16 rec_data[2];
> +	u16 bitmap_off, bitmap_len;
> +	u8 *bitmap_ptr;
> +	u8 first_byte;
> +	unsigned int node_size =3D tree->node_size;
> +
> +	/*
> +	 * Get base page pointer. head points to:
> +	 * kmap_local_page(page) + sizeof(struct hfs_bnode_desc)

Forget about kmap_local_page(page).

> +	 */
> +	page_base =3D (u8 *)head - sizeof(struct hfs_bnode_desc);

What's the point to provide pointer on header record if you need the start =
of
node? This computation could be source of bugs. Simply provide the pointer =
on
node's start to this function.

> +
> +	/*
> +	 * Calculate offset to record 2 entry in record offset table.
> +	 * Record offsets are at end of node: node_size - (rec_num + 2) * 2
> +	 * Record 2: (2+2)*2 =3D 8 bytes from end
> +	 */
> +	rec_off_tbl_off =3D node_size - (2 + 2) * 2;

Don't invent the wheel. HFS+ code already has logic of offsets table readin=
g.

What if the node size will be bigger that 4K (for example, 8K)?

I never accept the patch with hardcoded constants. Please, use named consta=
nts.
But you need to reuse the existing logic of working with b-tree nodes.

> +
> +	/* Only validate if record offset table is on the first page */
> +	if (rec_off_tbl_off + 4 > node_size || rec_off_tbl_off + 4 > PAGE_SIZE)
> +		return false; /* Skip validation if offset table not on first page */

So, we skip bitmap validation if a node is bigger than 4K? I cannot accept =
such
code.

> +
> +	/* Read record 2 offset table entry (length and offset, both u16) */
> +	memcpy(rec_data, page_base + rec_off_tbl_off, 4);

Ditto.

> +	bitmap_off =3D be16_to_cpu(rec_data[1]);
> +	bitmap_len =3D be16_to_cpu(rec_data[0]) - bitmap_off;

I assume we have metadata structure for offsets table record. No?

> +
> +	/*
> +	 * Validate bitmap offset is within node and after bnode_desc.
> +	 * Also ensure bitmap is on the first page.
> +	 */
> +	if (bitmap_len =3D=3D 0 ||
> +	    bitmap_off < sizeof(struct hfs_bnode_desc) ||
> +	    bitmap_off >=3D node_size ||
> +	    (unsigned int) bitmap_off >=3D PAGE_SIZE)
> +		return false; /* Skip validation if bitmap not accessible */

First of all, it makes sense to introduce the static inline function for the
check.

Secondly, we need to be ready to validate the bitmap for any reasonable node
size.

> +
> +	/* Read first byte of bitmap */
> +	bitmap_ptr =3D page_base + bitmap_off;
> +	first_byte =3D bitmap_ptr[0];

The bitmap_ptr is completely enough. The *bitmap_ptr gives you access to the
first byte.

> +
> +	/* Check if node 0's bit (bit 7, MSB) is set */
> +	if (!(first_byte & 0x80))

What's about test_bit(nr, addr) here?

> +		return true; /* Corruption detected */
> +
> +	return false;
> +}
> +
>  /* Get a reference to a B*Tree and do some initial checks */
>  struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
>  {
> @@ -176,6 +238,13 @@ struct hfs_btree *hfs_btree_open(struct super_block =
*sb, u32 id)
>  	tree->max_key_len =3D be16_to_cpu(head->max_key_len);
>  	tree->depth =3D be16_to_cpu(head->depth);
> =20
> +	/* Validate bitmap: node 0 must be marked allocated */
> +	if (hfsplus_validate_btree_bitmap(tree, head)) {
> +		struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> +
> +		sbi->btree_bitmap_corrupted =3D true;

Please, see my comment about this field.

> +	}
> +
>  	/* Verify the tree and set the correct compare function */
>  	switch (id) {
>  	case HFSPLUS_EXT_CNID:
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 45fe3a12ecba..b925878333d4 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -154,6 +154,7 @@ struct hfsplus_sb_info {
> =20
>  	int part, session;
>  	unsigned long flags;
> +	bool btree_bitmap_corrupted;	/* Bitmap corruption detected during btree=
 open */

This field is completely unnecessary. The hfs_btree_open() can return -EROFS
error code and hfsplus_fill_super() can process it.
 =20

> =20
>  	int work_queued;               /* non-zero delayed work is queued */
>  	struct delayed_work sync_work; /* FS sync delayed work */
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index aaffa9e060a0..b3facd23d758 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -534,6 +534,13 @@ static int hfsplus_fill_super(struct super_block *sb=
, struct fs_context *fc)
>  		}
>  		atomic_set(&sbi->attr_tree_state, HFSPLUS_VALID_ATTR_TREE);
>  	}
> +
> +	/* Check for bitmap corruption and mount read-only if detected */
> +	if (sbi->btree_bitmap_corrupted) {
> +		pr_warn("HFS+ (device %s): btree bitmap corruption detected, mounting =
read-only; run fsck.hfsplus to repair\n",

We don't need to mention "HFS+" here. I prefer to have two messages: (1)
information about bitmap corruption (it will be good to know which tree is
corrupted), (2) recommendation of running FSCK tool.

Thanks,
Slava.

> +			sb->s_id);
> +		sb->s_flags |=3D SB_RDONLY;
> +	}
>  	sb->s_xattr =3D hfsplus_xattr_handlers;
> =20
>  	inode =3D hfsplus_iget(sb, HFSPLUS_ALLOC_CNID);

