Return-Path: <linux-fsdevel+bounces-50604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084CACDB04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 11:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6523A522A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1A528CF5A;
	Wed,  4 Jun 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ZokxAoHm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39F28C849;
	Wed,  4 Jun 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029389; cv=fail; b=TLfNbJSZAcB46uas7AeMeux82ukLCQquQxJD89niqr6aohH84KRy3Fp6qBEGErSfaJWF09YCzAP8RkkrrEF4WQxrw1Nz/KFETzr2EgIncwMnTE3q5qYS7/nXYQejOCU6tgOoN3eWAqiME706exfn6ACnwEFuP/gaPT0KF07Ve6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029389; c=relaxed/simple;
	bh=MJvcnxfxzpAH49y8ucTCGN2c+0UjPVFsy20Sj05zW7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aC3Nx0wiVB4UJI9H1WC3QogGErVoORpqj4vIFxEcbQwY/n0wOa7hMva54HLDfnDhDp8dZOo4zWClIe4NG/ICdIEKJSfTrAKsVFQhpHaYVRC9dydG6gLy9pOzr+QM6F174+dsPc37p/Kj3Y6T1WquGVS2ln9/MROeIjcF7j1hggI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ZokxAoHm; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749029387; x=1780565387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MJvcnxfxzpAH49y8ucTCGN2c+0UjPVFsy20Sj05zW7o=;
  b=ZokxAoHmGKbcsODENMWSaBlWkdJBX14vLzqhkbSVoZ7w/aRNe3kNxGZa
   q57WvK8e8m7O5PQFE581F3UZXiQwycHxJT4Gd+o37fS5o87Zsj+Q6eerK
   Uf6QuLgIiI4yON4dTZvlsKmi+PLQNTtAhbCXvcW7j/XBOvA/YyalcmHE5
   4flh/sWCPMQEio/1MHuJ0iJBa2iMnsEy0ucL5u4xnW4bJTPhv+DTAM0S/
   Kf82LX1dke/YAuGWnRZ1xNxEYbxJkjS4S4xgsTK2awazo2DWD2x5qvhpN
   kIK4RzasDqFFSzBYYE/EW3tN1MefXERYOjywVXcaOzkUp51J7/RZ3OPeD
   Q==;
X-CSE-ConnectionGUID: 8qWob3OLRSqRCsjubwzIEQ==
X-CSE-MsgGUID: vYFoMWCaRI6LCD8XWnOiTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="157588254"
X-IronPort-AV: E=Sophos;i="6.16,208,1744038000"; 
   d="scan'208";a="157588254"
Received: from mail-japaneastazon11010007.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 18:29:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZRmkhw8OoF0ip5HQIJKW2ugBxW9NYaxRlSihk9En+JmoZ/Zu3thSwl/Ll1eFwWn5TvzbmTqRYJK+hBm2QnvC0IiPt8nKotKl0QizE6Lbdmmv+BGHj8ZtYj7cJEGtxINw7qbGeiuBxIibz3g06dqnv2gcDsl6/0Hp/8w/wW55ZaH4PszBqV/HG7gKF9Bb+i675qYD/5ycMJaNNQ57L0bJ5NIpxOEpDjptBlRhvK8koayFNPAU1k31GZGVCPwqeDXMdZq7VB08O1MJpu8fK9QyHutgNCTZr+fXyvhQEJcJjnfVgNV1PsHQHiQZtTMS32MzBE6kRaFwKIEH5dVrGlPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJvcnxfxzpAH49y8ucTCGN2c+0UjPVFsy20Sj05zW7o=;
 b=KC8hymYBbv6EBRKbUeeJmtiwL89rq8MKd5oTeqFdmEAEqzdiuwHDdCt3hmwEv+sB469KWP5Vxs2vs27QS8y0GLKtIOMeTuuqX16h7g4+ypHn0OkagIsEpVAXPHe3lu2aWsp+8SyFsvGAY09lHJsdmsnauCm0tp9REQ9DT/upi6KXiWXkzH67dACY90ZqdWwnWDjLy/wCAq3pimX3NJWUbf55GwvtOTWj8j17JpUNUj9TLJR9b94CiT0hD/K7yBi6vScww9B/CSmMEaxZZV5lnW8p7WZgBRU2Dmxee12zIr9CzyWy6VTmkXRRmI19/9L/VXazCpmW7m7V9WJCqVquzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY4PR01MB14264.jpnprd01.prod.outlook.com (2603:1096:405:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 09:29:35 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 09:29:35 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v4 3/7] cxl/pci: Add pci_loaded tracking to mark PCI
 driver readiness
Thread-Topic: [PATCH v4 3/7] cxl/pci: Add pci_loaded tracking to mark PCI
 driver readiness
Thread-Index: AQHb1NWunfo8fV9pHE6/H4ddWB0VhLPyvLEA
Date: Wed, 4 Jun 2025 09:29:35 +0000
Message-ID: <2b5c1df3-a279-4208-ab21-7ae033403939@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-4-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250603221949.53272-4-Smita.KoralahalliChannabasappa@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY4PR01MB14264:EE_
x-ms-office365-filtering-correlation-id: 1eb0176e-6bac-427e-1cb3-08dda34a51f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rlpsc0hHQWNPNURucXFRSXFiWmlDeG5TeFk5dVJVWmZJQnpZekRoam9kbHU3?=
 =?utf-8?B?bmsxcWx1eFk0R3pIQlVqdGNnSElRS3FSSk4ybnlLMHlSYW5jQ1ptc2YraHQ5?=
 =?utf-8?B?ZWYzSlY4ZGVEU2JDU1BTdmpGWDdyY3NaOGRyTkdoamNyRnI5VnlwNmVoZEtO?=
 =?utf-8?B?dmh1aDk5c1Y1dUtnMzN6UTJrOSt2SmhaNnBxWkphVSs3S3IwOHdKMjk0YmZ6?=
 =?utf-8?B?MmlzczZjMit1ZTVkUm9aNDkrM1ZtRnlZY1ovQzVLRkVkVGxmckt1T2R5bFpk?=
 =?utf-8?B?R3E0ZlJnb1kyWVRqTUxoSzRzcU03VDhpR2FCYTB3WU5YQ0VhcEpxTEpkM0Nn?=
 =?utf-8?B?VXdXVXplVmhxanZ3eDBLVndseFhhUVh1cnRKL1dCaG9QY0JUNVR4cFZ0REdv?=
 =?utf-8?B?Ry95YlRGU0gwY3BCeFhxeTVTNGdMaWxPaTBKeE93SXllNFNsSkJ5MUtsem1W?=
 =?utf-8?B?RlgvY05MZVREaFVIRTduT1A4Y1lla3YrTk1DQWxub1R5Q2VlM2J3eG45Z3Yz?=
 =?utf-8?B?eC82bkVKbDZFck9IUFBreExON3dGR2FzMGF2YTRNT2piVXN3MitOUC91ZzQ4?=
 =?utf-8?B?WDlFRTZFSlJUZEJwRTRLci9FZzNvRkRubnc3QnF5WWNrQ1Z1dDFiUWJxWHRY?=
 =?utf-8?B?QW1weXdLMnE5ZUlXS2poZWQ1MWxueHhUbVBZVlhQclVQVjR1NXhNRHg5dUtw?=
 =?utf-8?B?VThRQ2EyWVl5dmcrRmEwTlFrcHdTbUlDSi90c3J4bHBDSGlYbzdVcWJDZHV6?=
 =?utf-8?B?MUhuSi8xeEk0ak9kUUp2TmQzODVGOHdYMU5QMnJ1YkxPQVJOc0EvazJYSG1K?=
 =?utf-8?B?NStHS0VOYTByWElLYzM1T0l1ZVpkSVZ6QWdJRk0rdUozRU0zRTBQVGthS2JW?=
 =?utf-8?B?dkY0VXdSdjZyWWdRMWM5ekFqM1R3TTJuSlpicEVLVWhadDdsQUhsMlJPUWJx?=
 =?utf-8?B?MVE5ZEZ2eTlXd1RRQmFkRkY5S3ppejRBZzdndXNjbTRjY2ZMNjE0UDhKUnov?=
 =?utf-8?B?dzRsZDFkaWpEelB2R2tiY1VneTlYMzhBV3Q1eVYwVkdJclVwdUcrRC9DbnJw?=
 =?utf-8?B?a2lrdmpLUjlqbVowbnZ0VkV0RXNWQU1HNjFvaGJmQ3I3dW5xVWVyaFFCTDJL?=
 =?utf-8?B?bXlhcXN1ZUY3L3Z2NmlkTDhNR0pqeHZxNkorWFZPSFFKRXkxV25hWFI4TGE5?=
 =?utf-8?B?WlJENVBhcWJaZVVNQkVmYjhhSy9DOVlscGJybjFwKzNzSWI2bE14V0Zucnlr?=
 =?utf-8?B?UnBNRnZxUnErVlQ1V1VWTEJaaHdYTVZGNXBxMVpxZ0s0N0xwZUc3VXUwd0NG?=
 =?utf-8?B?TUIwclA0SThYN3RNRmY1OGUyQ2htWkovM0ZDVFozQnZPZFFlSTRwVU5YZ2RB?=
 =?utf-8?B?SlB1UHRSOU9lK05EcXZDRkREcmF5bzcvYlRBM08zQmpxQTNmSWdFTTByYUFB?=
 =?utf-8?B?VW1IUFkyQ0ZhRlNiekt2YXFsZDJ0UUlib1ZNaFFiUU0vbmpER3NFYVc2cHo3?=
 =?utf-8?B?YmZYQU5JTm9ldWJldkhTVzdqOUVFek1ZbzhQNjAvVVo1S0JKMlBSeldhMGxG?=
 =?utf-8?B?azlFLzhXb2FlNHZrYlg4MWdvcGdtV25ZNStQWk5yaVIzdjFhbkh5WlY1empC?=
 =?utf-8?B?SGgwQ2dOcnUzWkc4RHpsaWE1RzVldnliT1BTR2lBUDJiaFJ4Tk9INWg5SUNq?=
 =?utf-8?B?MEM0TXE3dmFWQjdKdDMzOFVidDd3L2VIWXUrR1A2Qzdadm0wZHNlVXVUWEpJ?=
 =?utf-8?B?SDh4TFJsaHNxYTdUZ25aOGk3TFpaaUU1akwzbm1ES2hmV3RBTmx0UHZtajhY?=
 =?utf-8?B?Wjd1NFc3RTl2a1pPczIzRVhlWU5BMGk1cEYwLzVMeGxjUmlwc0JhZU5hUFUr?=
 =?utf-8?B?eU0rdFRxdWlhZjZRQ2prRExtemJibFVXNWpLN2JhYThhMmw2R3RuNlFrd1hT?=
 =?utf-8?B?WTFhYkN0MXd2Zlg3UmFvZ3FzZEhNM003OHYrUFdFaVROYm5WSE1HRmltZzhF?=
 =?utf-8?B?MHR4ajZ0UlhsQUZEMWQ3bWxQaVEwMURwRWo3QWY4WGpnNGhncnR2d09tQXd1?=
 =?utf-8?Q?AW3P3i?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUNYMFR6eE9oTTVkeHAvRVRiVkpKS3I1eUJEeUt3Tm1sbEpVb1RDMTlTVXlX?=
 =?utf-8?B?Tmw4bVlKV01pRTkxL2JkMDlNbEtvSTBqUkxyMUdLNC8yU3p1VXh3K2lZbGla?=
 =?utf-8?B?TXFXOWNxUmRnMkVTNUp2eTlESW90Nm1vdlpYVFhLL0NZMGxuWWRyYmNFY0Zn?=
 =?utf-8?B?N1RMTU5LU3c2QUl6UURrcVB0T2JBRk1HYU1kb1c2Y3BTN2kzSS9abmUydE5Q?=
 =?utf-8?B?WEJTSWcrdXQrNmdGTjBhb3ByQnY2MngxZldVRUdOZkI1RW9TQnVJeWlFQW0r?=
 =?utf-8?B?Sk1UUG0zVGxRS2RjeDRaRXMwRThMSzBWTElEZGNRT1dHTXhvS3A0dFBwV2JR?=
 =?utf-8?B?MUJBNGl3bHNKaVVFKytBK2RXNjdXa3NrOFRXK09qUUJGQXJkUnVoTXI5ellS?=
 =?utf-8?B?cENUSjJYb2t0bzNDU2pPdzF1RHBWS2prdDR4c3ovaGVCekxxYVRQZHNLTUZa?=
 =?utf-8?B?S0ZXeHlxclZQSG5JVi9sd2MrY1VIMWFER0JPMlFuR1hmUVB6MlNDYnZrVCt2?=
 =?utf-8?B?NDJub2pnNDlaT3hEZzdvZjM4UWJpZmZ2L3poT2NNT2htOHErMTFPa2ZWSCs2?=
 =?utf-8?B?KytTd3UrWEZ5MkFRYTNCYUFnSXNRcVYrUkJjWVhaZTdXTnY1djFmYWZLYWI0?=
 =?utf-8?B?ck9nV0tWMlJCWGxQWlgwMG5YNkVZbU01RHZQWVFQZG5aOFBlaWp4SUU4WTEz?=
 =?utf-8?B?R09CZ2h4SHpxTG1oS3REQzdPNDBGa2hnT3hBYng2dnNCZWhkYkdjZlV6RERp?=
 =?utf-8?B?M2VpdUlQNmhVNndzbkZLKzUxR1FCVHpoZzRqbzFwc2RiYzYyay8vRnpxYkdx?=
 =?utf-8?B?c3NHZHhsOEV3UitPcW03bXJmcDhxOGE0Zk1vRmxtTFFIMTFSZHF1NUQzYVVW?=
 =?utf-8?B?Ni9yS2pMSnFvMUJGTFFHbWNpQzh3YWQ4K2VWUERRWVYrUHJaV05tMmZNUUZu?=
 =?utf-8?B?UmppaVRBVGhFalFuckJ4emcrV3p3OWNmMWdINTVCeUlIV0N3LzR2aXZMeTZC?=
 =?utf-8?B?bXZOcGpuUmxHQUEyVmlZb0JMWGFndmNFZUFEcnpJSjNNQ2RBb2xDdGdXZXBn?=
 =?utf-8?B?ZTg3bVVURXBhRW1ZcktRQmpqWGNrQkkzN1RpbUY3bWN2WlVuZmtsYXYzNHdG?=
 =?utf-8?B?cUo2ak51VEdIOXdHdXppdXVnK0d6L2R2ME50bmtMdldBS3ZuY2FzenQ1TFZs?=
 =?utf-8?B?OGVIcEg5dUZrMlhsZWJrcEU3T0t1bDhoU2owbk8wNFRrTVVmV0xzc080K3o4?=
 =?utf-8?B?eGlpS2VIWWJKZ2YzZmc1WnZkMm03NHY5M09GR2R5eVc2WFpGQmEvajRzWGtq?=
 =?utf-8?B?OXJXa3dnSCt4VWRENmsvNC8zNU5YZlBIQkl0cTByb0hxWkFkVkxnTUdRcENi?=
 =?utf-8?B?dVh3Q0ZiSHc2TkFRUCtJYzV5d2Jab25OT3o3WU1NN2FOTE1QQ0dlaEN0Vnlu?=
 =?utf-8?B?bVhCTCt6M1U5MjUvaktVUW85TVM5SkNZRWVDYmdkRkwwSFN4UXdiMVRIOHFX?=
 =?utf-8?B?Wmc4QTdkL3JhZ21IUHdVcVN1ZjhHYnRWVmJIclM2bVAyVG5hUHA1VVJMSXhU?=
 =?utf-8?B?TUZLSWlpMzB6VmNxdEJTNkFyTkhabGMzUnpOYkdFZzZDWTh5M2JBUjNTZFMz?=
 =?utf-8?B?c3JhM3F6TVJuYVNWV3hnK1YvUVZ6TXlmdWx2OVN0SEgwc2phcGdHS1Z5R2tz?=
 =?utf-8?B?bXY2MEVzS09ISDhCb0h0aGtzR2xnZ3ZiTGI1TU9zd1QvSGhMdWVNNTFrQzN5?=
 =?utf-8?B?WmtLQW9ZYWJadFVrTTZma3ZOQkFyV0NmbEF4d0U4VWZRUE9LT3krT21qUEZ4?=
 =?utf-8?B?b05CT0Y5aEloUUNFenVkR0V0N0Jiekp3M0dFdDk5M053eC9nL1Jocm4vSjZv?=
 =?utf-8?B?M0FYR05lYmlUR08rL3RWRjNYQm52S0xOYVN4ZU5YcWpWTStDUFFRZlFCd1pG?=
 =?utf-8?B?ZnpZMi83eVg1Sm5aNm4vc2NFSm9kQ2RlekQ4d2hzZDFOSVNrRzUrUU1wMCtr?=
 =?utf-8?B?L0tLWkVOU2g3TzZnclZkZmJDa1FqRk5KOXVRMkxxS2JtZUo2UDVGcFo3WEFH?=
 =?utf-8?B?V3JqMkV4MVI2NHA0WFJjZ2ZIcmYyZ2JuVjFwZ3JHZmZwSys5VHlWYnhuaTRC?=
 =?utf-8?B?YmJnb28rQzg3anhtSFJpaTNVK3VOUUpCallvVVk0MXorUFg2eC9MZjA3dm9P?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51DE2757B96BB44290EF7147F7660327@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X6R83tQOSbumgk8sMuBpLmBudCcZNgUx5dFldMGjlnreioc2S4xRiSO8SR5YKRHGzEV5HYsGvl5wix2cZOCVsURYk2GfWxPrFeOyHNlaBAs8JRZFpleR2ujEJoMYj/aKb8hPGfe2Jev4V87dj/3ahobGBE/htGpZvkt6kpy4RUpSUHFRjBsHMeCkMDibExStSp+m1pSlvqfXvYi1avMp/UtLXgIDX6EoGBNz2Rw71FyqP+L/gJYjI6gk5Fyl3pARXurPbtq2P7POS9EDRqQra3wyuc5WbRWbIw3KCFH/XePWLwf7624nRFWcCWwGbGERtQ048bs2tIdIPDE0DoA8TF2Ii8EOAQM/fy/J5DzfVWTud0lK6ZTo9SJPFN/zgvlqLoN+wkEmzFsfOWE4TGTgdOkUrnRwBz9HhdSpoJbdzEx/kvagF+j/pIjtw/Q5CdghhQ1iqQ72dxXTHXrFgxldGNhZU+T3/JmlPPcREzDpakv4yW/sENa5hcvkywpEYvGVOTo23iRaiaaAOAyxn4G5bL+tPZNuSJmG8Qh2s3n/xaP+2cXe/cusStSrgefenpb8J6+cHD0PeRFja86ifzHWa/391ms8NwrEJ9fYXUx//Wtp4yRgVDkqBvHw1mxf5ruA
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb0176e-6bac-427e-1cb3-08dda34a51f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 09:29:35.4111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUkShBydhadbHWhI7TceqZaSKWYNOvWrqFGR4Qwpj5YP1fBzFyfHgT+jjb10MXR7PJsRUYTpXaLtaQjg0r3gHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14264

DQoNCk9uIDA0LzA2LzIwMjUgMDY6MTksIFNtaXRhIEtvcmFsYWhhbGxpIHdyb3RlOg0KPiBJbnRy
b2R1Y2UgYSBwY2lfbG9hZGVkIGZsYWcgc2ltaWxhciB0byBtZW1fYWN0aXZlLCBhbmQgZGVmaW5l
DQo+IG1hcmtfY3hsX3BjaV9sb2FkZWQoKSB0byBpbmRpY2F0ZSB3aGVuIHRoZSBQQ0kgZHJpdmVy
IGhhcyBpbml0aWFsaXplZC4NCj4gDQo+IFRoaXMgd2lsbCBiZSB1c2VkIGJ5IG90aGVyIENYTCBj
b21wb25lbnRzLCBzdWNoIGFzIGN4bF9hY3BpIGFuZCB0aGUgc29mdA0KPiByZXNlcnZlZCByZXNv
dXJjZSBoYW5kbGluZyBsb2dpYywgdG8gY29vcmRpbmF0ZSBpbml0aWFsaXphdGlvbiBhbmQgZW5z
dXJlDQo+IHRoYXQgZGVwZW5kZW50IG9wZXJhdGlvbnMgcHJvY2VlZCBvbmx5IGFmdGVyIGJvdGgg
Y3hsX3BjaSBhbmQgY3hsX21lbQ0KPiBkcml2ZXJzIGFyZSByZWFkeS4NCj4gDQo+IENvLWRldmVs
b3BlZC1ieTogTmF0aGFuIEZvbnRlbm90IDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogTmF0aGFuIEZvbnRlbm90IDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT4NCj4g
Q28tZGV2ZWxvcGVkLWJ5OiBUZXJyeSBCb3dtYW4gPHRlcnJ5LmJvd21hbkBhbWQuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBUZXJyeSBCb3dtYW4gPHRlcnJ5LmJvd21hbkBhbWQuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBTbWl0YSBLb3JhbGFoYWxsaSA8U21pdGEuS29yYWxhaGFsbGlDaGFubmFiYXNh
cHBhQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvY3hsL2NvcmUvc3VzcGVuZC5jIHwgOCAr
KysrKysrKw0KPiAgIGRyaXZlcnMvY3hsL2N4bHBjaS5oICAgICAgIHwgMSArDQo+ICAgZHJpdmVy
cy9jeGwvcGNpLmMgICAgICAgICAgfCAyICsrDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9zdXNwZW5kLmMg
Yi9kcml2ZXJzL2N4bC9jb3JlL3N1c3BlbmQuYw0KPiBpbmRleCA1YmE0YjRkZTBlMzMuLjcyODE4
YTJjOGVjOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jeGwvY29yZS9zdXNwZW5kLmMNCj4gKysr
IGIvZHJpdmVycy9jeGwvY29yZS9zdXNwZW5kLmMNCj4gQEAgLTMsOCArMywxMCBAQA0KPiAgICNp
bmNsdWRlIDxsaW51eC9hdG9taWMuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvZXhwb3J0Lmg+DQo+
ICAgI2luY2x1ZGUgImN4bG1lbS5oIg0KPiArI2luY2x1ZGUgImN4bHBjaS5oIg0KPiAgIA0KPiAg
IHN0YXRpYyBhdG9taWNfdCBtZW1fYWN0aXZlOw0KPiArc3RhdGljIGF0b21pY190IHBjaV9sb2Fk
ZWQ7DQoNCg0KSSBmaW5kIGl0IG9kZCB0byBwbGFjZSB0aGVzZSBjaGFuZ2VzIGluIHN1c3BlbmQu
Yy4gQWxzbywgSSBub3RpY2VkIHRoYXQgaW4gYQ0Kc3Vic2VxdWVudCBwYXRjaCwgREogaGFzIG1l
bnRpb25lZCAoYW5kIEkgYWdyZWUpIHRoYXQgdGhpcyBwYXRjaCBpcyB1bm5lY2Vzc2FyeS4NCg0K
DQpUaGFua3MNClpoaWppYW4NCg0KDQo+ICAgDQo+ICAgYm9vbCBjeGxfbWVtX2FjdGl2ZSh2b2lk
KQ0KPiAgIHsNCj4gQEAgLTI1LDMgKzI3LDkgQEAgdm9pZCBjeGxfbWVtX2FjdGl2ZV9kZWModm9p
ZCkNCj4gICAJYXRvbWljX2RlYygmbWVtX2FjdGl2ZSk7DQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1C
T0xfTlNfR1BMKGN4bF9tZW1fYWN0aXZlX2RlYywgIkNYTCIpOw0KPiArDQo+ICt2b2lkIG1hcmtf
Y3hsX3BjaV9sb2FkZWQodm9pZCkNCj4gK3sNCj4gKwlhdG9taWNfaW5jKCZwY2lfbG9hZGVkKTsN
Cj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfTlNfR1BMKG1hcmtfY3hsX3BjaV9sb2FkZWQsICJDWEwi
KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2N4bHBjaS5oIGIvZHJpdmVycy9jeGwvY3hs
cGNpLmgNCj4gaW5kZXggNTRlMjE5YjAwNDllLi41YTgxMWFjNjNmY2YgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvY3hsL2N4bHBjaS5oDQo+ICsrKyBiL2RyaXZlcnMvY3hsL2N4bHBjaS5oDQo+IEBA
IC0xMzUsNCArMTM1LDUgQEAgdm9pZCByZWFkX2NkYXRfZGF0YShzdHJ1Y3QgY3hsX3BvcnQgKnBv
cnQpOw0KPiAgIHZvaWQgY3hsX2Nvcl9lcnJvcl9kZXRlY3RlZChzdHJ1Y3QgcGNpX2RldiAqcGRl
dik7DQo+ICAgcGNpX2Vyc19yZXN1bHRfdCBjeGxfZXJyb3JfZGV0ZWN0ZWQoc3RydWN0IHBjaV9k
ZXYgKnBkZXYsDQo+ICAgCQkJCSAgICBwY2lfY2hhbm5lbF9zdGF0ZV90IHN0YXRlKTsNCj4gK3Zv
aWQgbWFya19jeGxfcGNpX2xvYWRlZCh2b2lkKTsNCj4gICAjZW5kaWYgLyogX19DWExfUENJX0hf
XyAqLw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvcGNpLmMgYi9kcml2ZXJzL2N4bC9wY2ku
Yw0KPiBpbmRleCA3ODVhYTJhZjVlYWEuLmIwMTliZDMyNGRiYSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9jeGwvcGNpLmMNCj4gKysrIGIvZHJpdmVycy9jeGwvcGNpLmMNCj4gQEAgLTExODksNiAr
MTE4OSw4IEBAIHN0YXRpYyBpbnQgX19pbml0IGN4bF9wY2lfZHJpdmVyX2luaXQodm9pZCkNCj4g
ICAJaWYgKHJjKQ0KPiAgIAkJcGNpX3VucmVnaXN0ZXJfZHJpdmVyKCZjeGxfcGNpX2RyaXZlcik7
DQo+ICAgDQo+ICsJbWFya19jeGxfcGNpX2xvYWRlZCgpOw0KPiArDQo+ICAgCXJldHVybiByYzsN
Cj4gICB9DQo+ICAg

