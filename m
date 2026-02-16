Return-Path: <linux-fsdevel+bounces-77259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDYEFyKokmkNwQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 06:16:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C24140F19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 06:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 625DA3010D92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 05:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE862DE6F8;
	Mon, 16 Feb 2026 05:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HPCYuKIm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011044.outbound.protection.outlook.com [40.107.74.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D0F4A21;
	Mon, 16 Feb 2026 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771218962; cv=fail; b=dLD7mszZmwQbTODuP/GqJAOP+nmjfiBcJckSdQogXf5cgkDt6PBPOcJ8+TnMaGzy9oxgLUVV0+6dhpSK0nGb65zdZ5ZMX38qsG7P5J7mtSvNpkZ/kXsXt6hPOufaFKl12O6tD/XMh37hWkxGrzchWGS94LpF81JxHMMLdypJes8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771218962; c=relaxed/simple;
	bh=4xsHTAGqMt25kbtzoxXwEcMLxpw+HSf0LFJ9REyB7II=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tEtW8jT13VfXGgYSuGszfmjqdP7Eed0dDz6AJMzrtzS0gNDqhghDKsvi8n90kBmjSFWWF8sVsWjjk1J2HT+ZsasQTfm+DwvwVv9HlbwuwH0j5HVuZmuS9CxPxl1CDuKF5uv75NBgav6VuTHKMudTmGg90UUxOAHY7DuMcD7Sq1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HPCYuKIm; arc=fail smtp.client-ip=40.107.74.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdY8FdQFUZg7lHnKen3nfxF/Y8YLG+rGBG/hJX1/vtJ/CRsx1f/UwDp3XasDPgZLaW/2ZyL5nMT46VuFCIe6BE0p2JsxoAYpzzoISbx5ojbp0Trqv0FjyRbcByV1QEE0+MoyP2IhtAGG5BnHO0DVDuyjcqyYpnz+pkD9KY6ms8V13dCVFnZdAJnfnw6m+LJuPlZQgBqM8Ci5+MdhIzLZDwfFMGH9BTl46bb1U94o9MvX6vKzHDSSFvEC8KWS1Kc+LnNN/nQKQ9GOpYlRv5J+zrLTYX6H71ChhqnJYWQreT3VdfpqItrogbIIUJUYR3aEEYkDc9PeC1ianwX2RBzplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xsHTAGqMt25kbtzoxXwEcMLxpw+HSf0LFJ9REyB7II=;
 b=sadZIILmgY0K7Ku+rMrKlT2XZ8RNqI4haEwuLtmle4sOQmw/hb0709K41tBGJKe2vgL2faLKrTBHGNO/ScmSqrIbt7/LlvZZjibS/UpZNjWEz/YN7KmObB+2kE2SE3m0UR/WBmFNilwYdOYhO6SSgYIjVXvcZVPdSDOCsLCtqjJ776Liu8ehsLzLES87nfhA6UPpF75iYNy37J4dCqU4TvTS2mSPIsp4wqCxnikARU5riJ/u+NG+s+7iOoDhbkRZm1V6O+PUPDiiDbe1ksm9SQGTn6S4i8mITk0XObw9fqS7a29jLfzUO9TWE34PzxxBvi6PuxnPG4rR3VrfcfibIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xsHTAGqMt25kbtzoxXwEcMLxpw+HSf0LFJ9REyB7II=;
 b=HPCYuKImqImixYGtXh3A+mieRIp2B9r/LbbB43o0UVYrKCgPIg/UGSDDods2F6rLZcrYclPqMf7OTXXg7mDDwTbS1Zxx9DgoLT/U1VAsVsJOp4qzyJowsYP4ClUF+av62fGnZ4D122B9WWvXyXvAP/GHeZUA3ADEJONI0olmalHFwxP4UE3DaU/LvBPed+pNIItkYjG71TpdMFB8i2L2HqJRgGchx6zUU1dt1cK1ENSPbGsC3fLdVoiYidmcMdpnj3wY2Trdt6mp68y/HZ35ONgAwVUGs1juBkGusZFbFehPq5+kGO8P541EDNgKtbNccyC/nvkK72YZxoB9WrfsaQ==
Received: from TYRPR01MB16276.jpnprd01.prod.outlook.com
 (2603:1096:405:2f1::11) by TYYPR01MB6729.jpnprd01.prod.outlook.com
 (2603:1096:400:ca::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 05:15:54 +0000
Received: from TYRPR01MB16276.jpnprd01.prod.outlook.com
 ([fe80::464f:166d:23fe:e8cf]) by TYRPR01MB16276.jpnprd01.prod.outlook.com
 ([fe80::464f:166d:23fe:e8cf%4]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 05:15:54 +0000
From: "Yasunori Goto (Fujitsu)" <y-goto@fujitsu.com>
To: 'Alison Schofield' <alison.schofield@intel.com>
CC: "Tomasz Wolski (Fujitsu)" <tomasz.wolski@fujitsu.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
	"bp@alien8.de" <bp@alien8.de>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "huang.ying.caritas@gmail.com"
	<huang.ying.caritas@gmail.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"jack@suse.cz" <jack@suse.cz>, "jeff.johnson@oss.qualcomm.com"
	<jeff.johnson@oss.qualcomm.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "len.brown@intel.com" <len.brown@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, "ming.li@zohomail.com" <ming.li@zohomail.com>,
	"nathan.fontenot@amd.com" <nathan.fontenot@amd.com>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "pavel@kernel.org" <pavel@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "rrichter@amd.com" <rrichter@amd.com>,
	"terry.bowman@amd.com" <terry.bowman@amd.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "willy@infradead.org" <willy@infradead.org>,
	"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>
Subject: RE: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Thread-Topic: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Thread-Index:
 AQHcmljeqGwxci4vD0qX6xZEB4t9YbV8TuqAgALYgoCAAG4nAIAAnjxAgAC0k4CAA+iBIA==
Date: Mon, 16 Feb 2026 05:15:54 +0000
Message-ID:
 <TYRPR01MB16276531464794E7A118F3679906CA@TYRPR01MB16276.jpnprd01.prod.outlook.com>
References: <aYuEIRabA954iSfR@aschofie-mobl2.lan>
 <20260212144415.10418-1-tomasz.wolski@fujitsu.com>
 <aY5DpvAvqxqWZczR@aschofie-mobl2.lan>
 <TYRPR01MB16276AE76EB8585F3786510F59061A@TYRPR01MB16276.jpnprd01.prod.outlook.com>
 <aY9f3SZ7dp0P4sEi@aschofie-mobl2.lan>
In-Reply-To: <aY9f3SZ7dp0P4sEi@aschofie-mobl2.lan>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9YWUzM2NhNGUtMzk0Ny00ODM0LWJlNTMtNGI2MDhjYTlj?=
 =?utf-8?B?OTVkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI2LTAyLTE2VDA1OjE1OjMwWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB16276:EE_|TYYPR01MB6729:EE_
x-ms-office365-filtering-correlation-id: 925e5bd6-a6d8-44fd-d52e-08de6d1a75cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dElRUDR5VUE5L3JYVnI1OFdyMTcyUHdaYlpVTU1SUkFYQ2hpK0w4RFdOaGF5?=
 =?utf-8?B?endEbHhnYzZpeXpiRUUzRndCRHUveForYTlaNlhQbDl0T2pYTXovd3MyeGJt?=
 =?utf-8?B?ZUFSa2RQUXIxQkkwNktDVjI0UDNBaXA5RXRlQnRKdC9VaGluUytxdDIzRjRY?=
 =?utf-8?B?M0xXaTdCOHpqUTRUMTVyd1YrN2FRdWdKOFlkTCsvNDdVTGRlN1RIRWszVmMw?=
 =?utf-8?B?ZjFaZnMzdW1Ra1c0dmZ4dTRzUjUxVzRvbGtIY3VPRUxSM2MvdHM3Tkp5VjRV?=
 =?utf-8?B?QXBndVFIYW1LRWU1QTdsN1FTUlZoRlFCeWJwcGcvb2d0L1E0RUxScWhRMlhp?=
 =?utf-8?B?a1o1WU9pM1dMOWtqMXRmQklZRUhsY29FbENna2hLOW9YSUhTVkFGU2c2ZnNy?=
 =?utf-8?B?dFQ0SEM5UDBlZUVNMldTeDhzRUhWRU5xb1p5dmlRemJnQjEwcHAxeE1ETFpH?=
 =?utf-8?B?bE1FUmZ4RG85aFB1ZytmVmppdUlSc0NLQ011elVxR2RwOVRTMG1kUTNmc2pW?=
 =?utf-8?B?NWtURkRqZDVzaU9Id2FxSjUzRGE4aVdIMlNybHVIUzlMdldSQ0hlUExDQnYx?=
 =?utf-8?B?QTlDMHdmc3JXd1RuUS8rRWwydGN6OG5iS08yZTI0eVFvREQwNGNXNnN0NUZr?=
 =?utf-8?B?Qm0xTjU4NGJlOXZVbGN0NTQvdi9MYWNWc1gxdWV1QTFpV1d6V0NFcTdMVzJ6?=
 =?utf-8?B?TXRSSWRTWXZSbXNPU3ZhNmZnbVRhU2cwZExvUWpuVTlRd2sxZGJ4VDRtUjdD?=
 =?utf-8?B?RTBRZ2t4RnNYTDBRbEIvTVRlRDVVN3JiTmhwREZJYVpIOFE5bGZzWUlRckNn?=
 =?utf-8?B?aGVEbGFKd2hWZVdVVzRDcWRJS1RLckVaUkphWHJ1TWZDYUw1ZUN3WmFZK1k4?=
 =?utf-8?B?NzVHS0NqTnhqMDBnM25BQ241SlJoaUg4TDZFeFpnOU1rM2kwZ3BzSU1kZG9r?=
 =?utf-8?B?L1hKSlR0OFFLOFVsbnF0cW5XWXQxcHE0cnlFN01ZTFRxamxVWmNGNGZvYkhv?=
 =?utf-8?B?OEZBbXgvT2hUdkJwc0todU9tek5xZlV6QitlL1Y1aktkL0kvTldSUHI0NXJH?=
 =?utf-8?B?czIyMUtnci9rb2UzQXJwd3dUKzFWcE9KNEI0emNXRURXbXZOenp6cld4dmIr?=
 =?utf-8?B?em1qOFZsa2NNZDRGK01MQ2FIYnc3aVVzTE1BMDFzZjVxRUlNQXZKWk9PcjlJ?=
 =?utf-8?B?Nnp3VGxCc0RGdU85bVJOdFBvSlRSTE1iWlpOcTJuZ0dBS0VqSnVvanhYT1dH?=
 =?utf-8?B?bFpIOTVydUZtY0cveW5aT2U2aWhTUzJHTkJqYXR0Ym12dUxvQXkxcFdsdUtm?=
 =?utf-8?B?dnJ0RFBVNm8raW4rd2liSVQzR3Z6elBPZkxmRjZkL1BmS1lVZUdwWjAxT3Ex?=
 =?utf-8?B?bytqZ3pOQ21kNitwbFJnMzZjS054b3hyK2tMelFHSVd1bTV1d1FIa2JmcWsr?=
 =?utf-8?B?MWhKVFNMdGxNdExxTjQyci8vNGRjNys0L2FrVWVMSHZIYTNvb05QMnpHeERr?=
 =?utf-8?B?eGQxUmo2VTlwMmwzYW1zcHpvK3BCTFlzUXAybjB5OENtMllEK1VUVlI3a1Bk?=
 =?utf-8?B?NUdYNUtseFQ0bW5JcE8xYXBXbXlPVmdsZ05oMlhMWGh0R29HU2Y4Y3FUemkz?=
 =?utf-8?B?dXlaVktGMGVmUGF4TXJoVVdUbHZtNjcwYStMV2d4QnBXcGZvazltdG9CNEh2?=
 =?utf-8?B?U0liNUVOOERIMDdVNmJsMW1POTdBSVhnMVZaZ2hCS1NSZXpudW9wL2w1WGJX?=
 =?utf-8?B?N3JYdEdKTEJGc3NaWWJhWnlxNmRyaWZKNFNBaFdEUVFxcEVLakhOSTFHNjhX?=
 =?utf-8?B?bTdsYzZRc09KUDlOMm9DL0RENExEWTJLNUEzcEhHQnBIb0ptZGsrcEZNYzhX?=
 =?utf-8?B?VmRhcW9RN0RqaFdlTGZaUEp0UmtWaEJVSVB3RThoVzB1blVqZEZyZ2JheXNv?=
 =?utf-8?B?Y0VLd1dubGE1cDNoRkEyelZML3NDQ2F2ZlFCNHRPMkRhZS9nOFZ2NHNmTm1u?=
 =?utf-8?B?ZkxPT2hqalBlQWh5ZHh4bXBtcjFUYm4rK1hhQ2Y4WXg5NWhzYm9nZjJ2SkF5?=
 =?utf-8?B?bVRMbVRVdERGMmgyR1BtbmQwOEp1QS9tcVQrdEZoeG9zclU2aURMU2tOYTJO?=
 =?utf-8?B?LzQ5VjM5aXIrbVFRb3BhY2dXMmlPcnh6SVZrZks0N01tNm1FS0NmcGdEY2NW?=
 =?utf-8?B?cTFqYWt4QnZqM1RRSDVKbU5ZVTM4QUtKMTM1T3hOUVNGaUZUc0VoTlpxYkFi?=
 =?utf-8?B?YzM5WXdPUytySHREU3lPa0tRSFFRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB16276.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1BNNDROK3QxZTlZMkd0SHhnZmNDcXNIMHpwa200dkhvdzMyNExFNGg3Tk9j?=
 =?utf-8?B?dUJETGpkS2pSWHdnTEh0UFFxKy9wbDErZDBXazZwaHdQTitVQ1V5cmd4Tlho?=
 =?utf-8?B?RkpuQXZaRlp3S2FYV05xNWZCeFJIWEw0OG1SSUxndXRySjgwdmYzcmJtdUxz?=
 =?utf-8?B?ajExejVoaHJ5VUVlRGdjR0VzVnJxVzlEN3dzM1d2QXI4UXREYmNvRzNjWlNU?=
 =?utf-8?B?NDdpOU1mVkhkWUhMdHBlcjIvQ1BLMVh3VGdmMnJ3Y0NMWEVlZlFNVUNueGdB?=
 =?utf-8?B?SUI2MUQ3MXNWb1FBODFOV2k5WTRBSW1JRUlyTEZlN2Mrck8zL0RLU2NvWVBZ?=
 =?utf-8?B?RFdqVC8yWjNFdnV5SmxPOEJJUC9saXJUMmFLSHNBY2VWTzRhZHJkdk0zZGhS?=
 =?utf-8?B?VC9jRFNDdTJ2YkxxU29ucDhNVGVsWVRQTElhNXphLzJBU1pwWE0wSmV2WWlW?=
 =?utf-8?B?L3oraUZDUllzL1ZTaWhna2JUTiswc2xDZm5wOFgyaGhpVHR6WWdTN2J5N2wv?=
 =?utf-8?B?SDlueW5CZkROa2JaajloeHdkRUg0RzU0NExOVjI2VWFmOE9TYzVPNW45ZWtz?=
 =?utf-8?B?WkdOUGZpT1o0c0sxOWcyMWs3dmhFd0IwczZyaHVBek9vL2Vud3psYWZzZDRv?=
 =?utf-8?B?OXdFcHc2SnhPL2kvTlVXSi9DWGk5SmlZM3hydm9rTHpTb2VndEdITFJ4VlhQ?=
 =?utf-8?B?d0kxL3cvUkljVlZBdjhZeFcxWFV3UEhtM3ZvemEyRGlGNXVDUW5abFY4SEha?=
 =?utf-8?B?OTdrWVErMitzbGZZVEFRYUJ1MXZ5ZzJEUStRWWVTeXQ3THg2V0RTV3dWcU5B?=
 =?utf-8?B?WVZhSitvZzh4aVVlZEUweFk5Yi9xUFVBYU85aFZHRm5TUWlKRERWcFhqaGdU?=
 =?utf-8?B?Nm92YTVzNWlWWlJabTZWbThadzRteDJjWEJ2UkFYdURCcU5aSU8wSEFtdFFx?=
 =?utf-8?B?QUNUaUNjUHFNdVJ2bktJRmZnbzhEZHVQZFh4TWNXY1V1ZzBzY3hMb2xLTXNy?=
 =?utf-8?B?QWNuMk9mZ0RJQm1rUTZHcTFkZzlCemk5L09QcC8wQ1d3UHpmY3AvejhoN1cr?=
 =?utf-8?B?MFExOElRK0V6bGtTRnkrREhYbU83U05kblFlWXYvR3NqcnFHWWtlalduQkFj?=
 =?utf-8?B?eFUrRDgvZlNSVGl5T09tUlB1ZFdTTlRoa0ZaQTJGanRwTERUbmhyRzFiZXZj?=
 =?utf-8?B?enNXYzRYK1F3WUVwSXV6VVAyOVVPcXVsS2owa0I2TCsycHV3OGEzNDdLM2Fv?=
 =?utf-8?B?eEU0VlhmeEJNc0pWQmtjTGNHdDk4UDREVjJralZUZW9sRDNObld2RlJnNWFW?=
 =?utf-8?B?U0JvbXRVN3dxQ0NYUFM0UCtNeGt3aGc3RnFBVS9lN1VLNE1TbHZjTENiWTh4?=
 =?utf-8?B?N2hyRUZmNFhScGc5UlZJMEh2dXhEMVRHSWE2OWpSVCtoM3k3aHJJQXZVbThy?=
 =?utf-8?B?enhGaXF2K3FadmFNUkFucU16Q0R0RmNmWlFuQThyTHUvdjRyOU5JSnVpWkdV?=
 =?utf-8?B?bW43YXRNT2Y1bDVwT2tuWG1qWVF3VjdLWEZ3ZmdGTU53VGd3UFIwWmhmRk11?=
 =?utf-8?B?b2JEV1BzSjZ0UnhGTGtvWWFQbUZOOTdzTmNvL3h6ZXplZDdZeG9PKy9WYkZi?=
 =?utf-8?B?Wkl6WmJNY2FUdWJmUW9CTUVPNWhjSVA0REh1Qjc5U2llNWlSZTB1dlJpZmZS?=
 =?utf-8?B?ZDZiMG1tSXhtMEZqV3AzT3FkcWZyTnJwd0NaUmZyNGNHRXE4K3Q4Q1Z4R0pZ?=
 =?utf-8?B?MFh1TURxY3BsQnZBdjNWRHVDTlRMM3AzVG5ZUW4xR3M3bHNMOCtDNmZvNHJY?=
 =?utf-8?B?TVRuZDR6MHMrOGNadkcySXBxTGg4SldobVUrMFdDUWlHTjZGWkpFQUZJNXcz?=
 =?utf-8?B?YlVqVkdyRXFtSVhib3RZSUNoQmQ0NmV0VlpKTnhZbGgzMTJ2Vjl0eTBXRE1Z?=
 =?utf-8?B?WE53amlQbnNjRTN0U3ZWTzVKRXZCNnhUa0RKN1Zod2M2OWZsbHZYUjFOVjBt?=
 =?utf-8?B?Tjg2WUo5VWQwTVlWRTJNT2FNVWhuTm8yZzZ6c2txNXpYZWQ2WXA2NlVjU0ZV?=
 =?utf-8?B?ZjhXT2szS3E5dnhGcnR0WHR5T2lZNjl2b3JKVUl1ZEJVVmM1NVUvN3hsRHFh?=
 =?utf-8?B?VVBsa2FGMGpoMlF2MU1oWWs3NklKZnFKVytaVVhoSE8zNVFIVmFvK2dweFdK?=
 =?utf-8?B?QnZXNVpQaUJ2cEZzLzFLMjJGZ3RNdlRBeG1mQ25WN0ptakVET2R1NGVEd3NK?=
 =?utf-8?B?WTU4TllidWNHUmVZVEtGQXg2UHQxb2VaME1TUVdNakUvSXZ6cS9KeUw4VWdG?=
 =?utf-8?B?NXhwaGFSYTF0UUFjUkJuMlZGajVPR0hSVXlxWWNFS09UYU1YOHh0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB16276.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925e5bd6-a6d8-44fd-d52e-08de6d1a75cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 05:15:54.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhEw/ufnjPQLrcE0wFudHzRViNAw3kCMdVzNBnBSnT3ELGq91olMi9ODHJUV10nmlqzmYedS58wx821x2ps0gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6729
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77259-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[y-goto@fujitsu.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fujitsu.com,amd.com,kernel.org,alien8.de,intel.com,stgolabs.net,linuxfoundation.org,gmail.com,suse.cz,oss.qualcomm.com,huawei.com,vger.kernel.org,zohomail.com,lists.linux.dev,infradead.org];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8C24140F19
X-Rspamd-Action: no action

DQo+IE9uIEZyaSwgRmViIDEzLCAyMDI2IGF0IDA3OjQ3OjA4QU0gKzAwMDAsIFlhc3Vub3JpIEdv
dG8gKEZ1aml0c3UpIHdyb3RlOg0KPiA+IEhlbGxvLCBBbGlzb24tc2FuLA0KPiA+DQo+ID4gSSB3
b3VsZCBsaWtlIHRvIGNsYXJpZnkgeW91ciBhbnN3ZXIgYSBiaXQgbW9yZS4NCj4gPg0KPiA+ID4g
T24gVGh1LCBGZWIgMTIsIDIwMjYgYXQgMDM6NDQ6MTVQTSArMDEwMCwgVG9tYXN6IFdvbHNraSB3
cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+RllJIC0gSSBhbSBhYmxlIHRvIGNvbmZpcm0gdGhl
IGRheCByZWdpb25zIGFyZSBiYWNrIGZvcg0KPiA+ID4gPiA+bm8tc29mdC1yZXNlcnZlZCBjYXNl
LCBhbmQgbXkgYmFzaWMgaG90cGx1ZyBmbG93IHdvcmtzIHdpdGggdjYuDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPi0tIEFsaXNvbg0KPiA+ID4gPg0KPiA+ID4gPiBIZWxsbyBBbGlzb24sDQo+ID4gPiA+
DQo+ID4gPiA+IEkgd2FudGVkIHRvIGFzayBhYm91dCB0aGlzIHNjZW5hcmlvLg0KPiA+ID4gPiBJ
cyBteSB1bmRlcnN0YW5kaW5nIGNvcnJlY3QgdGhhdCB0aGlzIGZpeCBpcyBuZWVkZWQgZm9yIGNh
c2VzDQo+ID4gPiA+IHdpdGhvdXQgU29mdA0KPiA+ID4gUmVzZXJ2ZSBhbmQ6DQo+ID4gPiA+IDEp
IENYTCBtZW1vcnkgaXMgaW5zdGFsbGVkIGluIHRoZSBzZXJ2ZXIgKG5vIGhvdHBsdWcpIGFuZCBP
UyBpcw0KPiA+ID4gPiBzdGFydGVkDQo+ID4gPiA+IDIpIENYTCBtZW1vcnkgaXMgaG90LXBsdWdn
ZWQgYWZ0ZXIgdGhlIE9TIHN0YXJ0cw0KPiA+ID4gPiAzKSBUZXN0cyB3aXRoIGN4bC10ZXN0IGRy
aXZlcg0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9yIFFFTVUNCj4gPg0K
PiA+IFRob3VnaCBJIGNhbiB1bmRlcnN0YW5kIHRoYXQgY2FzZXMgMikgYW5kIDMpIGluY2x1ZGUg
UUVNVSwgSSdtIG5vdCBzdXJlDQo+IHdoeSBMaW51eCBkcml2ZXJzIG11c3QgaGFuZGxlIGNhc2Ug
MSkuDQo+ID4gSW4gc3VjaCBhIGNhc2UsIEkgZmVlbCB0aGF0IHRoZSBwbGF0Zm9ybSB2ZW5kb3Ig
c2hvdWxkIG1vZGlmeSB0aGUgZmlybXdhcmUgdG8NCj4gZGVmaW5lIEVGSV9NRU1PUllfU1AuDQo+
ID4NCj4gPiBJbiB0aGUgcGFzdCwgSSBhY3R1YWxseSBlbmNvdW50ZXJlZCBhbm90aGVyIGlzc3Vl
IGJldHdlZW4gb3VyIHBsYXRmb3JtDQo+IGZpcm13YXJlIGFuZCBhIExpbnV4IGRyaXZlcjoNCj4g
Pg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jeGwvT1M5UFIwMU1CMTI0MjFBRUE4
QjI3QkY5NDJDRDBGMThCMQ0KPiA5MA0KPiA+IDU3QUBPUzlQUjAxTUIxMjQyMS5qcG5wcmQwMS5w
cm9kLm91dGxvb2suY29tLw0KPiA+IEluIHRoYXQgY2FzZSwgSSBhc2tlZCBvdXIgZmlybXdhcmUg
dGVhbSB0byBtb2RpZnkgdGhlIGZpcm13YXJlLCBhbmQgdGhlIGlzc3VlDQo+IHdhcyByZXNvbHZl
ZC4NCj4gPg0KPiA+IFRoZXJlZm9yZSwgSSB3b3VsZCBsaWtlIHRvIGNvbmZpcm0gd2h5IGNhc2Ug
MSkgbXVzdCBiZSBoYW5kbGVkLg0KPiA+IEhhdmUgYW55IGFjdHVhbCBtYWNoaW5lcyBhbHJlYWR5
IGJlZW4gcmVsZWFzZWQgd2l0aCBzdWNoIGZpcm13YXJlPw0KPiA+IE90aGVyd2lzZSwgaXMgdGhp
cyBqdXN0IHRvIHByZXBhcmUgZm9yIGEgcGxhdGZvcm0gd2hvc2UgZmlybXdhcmUgY2Fubm90IGJl
DQo+IGZpeGVkIG9uIHRoZSBmaXJtd2FyZSBzaWRlPw0KPiANCj4gTWF5YmUgSSdtIG1pc3VuZGVy
c3RhbmRpbmcgVG9tYXN6J3MgQ2FzZSAxKSwgYmVjYXVzZSB0aGlzIGlzIG5vdCBhDQo+IHdvcmst
YXJvdW5kIGZvciBhIGZpcm13YXJlIGlzc3VlLg0KPiANCj4gVGhlIENYTCBkcml2ZXIgYWx3YXlz
IHRyaWVzIHRvIGNyZWF0ZSBEQVggcmVnaW9ucyBvdXQgb2YgUkFNIHJlZ2lvbnMuDQo+IFRoYXQg
aGFwcGVucyBpZiB0aGUgQ1hMIHJlZ2lvbiBpcyBCSU9TIGRlZmluZWQgJ2F1dG8nIHJlZ2lvbiBv
ciBhIHJlZ2lvbg0KPiByZXF1ZXN0ZWQgdmlhIHVzZXJzcGFjZS4gVGhhdCBpcyBpcnJlZ2FyZGxl
c3Mgb2YgU29mdCBSZXNlcnZlZCBleGlzdGVuY2UuDQo+IFNvZnQtUmVzZXJ2ZWQgaXMgbm90IGEg
cmVxdWlyZW1lbnQgZm9yIENYTCBvciBEQVggcmVnaW9uIGNyZWF0aW9uLg0KDQpJIG1pc3VuZGVy
c3Rvb2QgaXQgDQpJJ2xsIHJlLWNoZWNrIHRoZSBzcGVjaWZpY2F0aW9ucy4NClNvcnJ5IGZvciB0
aGUgbm9pc2UuDQoNCj4gDQo+IFRoYXQgcGllY2UgYnJva2UgaW4gYW4gZWFybGllciByZXYgb2Yg
dGhpcyBwYXRjaHNldCBbMV0gd2hlcmUgdGhlIGNhbGxzIHRvDQo+IGRldm1fY3hsX2FkZF9kYXhf
cmVnaW9uKGN4bHIpIHN0YXJ0ZWQgcmV0dXJuaW5nIEVQUk9CRV9ERUZFUi4NCj4gDQo+IEkgaW50
ZW5kZWQgdG8gcG9pbnQgb3V0IHRvIFNtaXRhLCB0aGF0IGJlaGF2aW9yIGlzIHJlc3RvcmVkIGlu
IHY2Lg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoLg0KDQotLS0tLQ0KWWFzdW5vcmkgR290bw0K

