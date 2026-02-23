Return-Path: <linux-fsdevel+bounces-78009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA7TBvTSnGkJLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:21:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7464117E383
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED33431DA123
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FEF378812;
	Mon, 23 Feb 2026 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="a/HJ7HIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A899376463
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.26.1.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884773; cv=fail; b=q+GEoRNQ/xqSy/HeB5/4xWGXLbl4GxyVFawqHTnBWs3T+yrc4agARQr4tgLdNJWjVOeJvPainWYPcJDi0Cr4Wdc3uRpgt8gfVGQ5pUm/HbnTbahGDDCu7a4AeEJKth3aKHHNXrFzWzxV1+Dy9sPR+FDGXck3sMqJy1i+OYihL1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884773; c=relaxed/simple;
	bh=uiWRBDRpPzy9hMzb2zq/cS+bELz1z0YsamQ4ESogjEw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FH8Z5Eltb1F5nlFtPawjnMy2TT2inVzNMDKi6g5zSP/5RyEhWA9y3WVWieQuAZ2apv4U/57qNMaJU8+cnuJdlL+yKmA3ba1J725D67FzFqCNgaYV/Lk4W+anklc/wI0Bxr4WwuigSt425CsvTZ7+v9Pu1pbsToEuigaCVVIyenA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=a/HJ7HIZ; arc=fail smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771884772; x=1803420772;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=uiWRBDRpPzy9hMzb2zq/cS+bELz1z0YsamQ4ESogjEw=;
  b=a/HJ7HIZe5Noyu7jdme/ukeezBv1aCz3CstgENA//wrrzc+hkSFs6f0X
   s5O+eQVe2yCgPlbodIehb58tV0nXtxqGqn3q99wiO+k18SnnJ5V5lIVer
   0yV/dSppDuuU446SQhaX5oCraH9MLH5bxYO3rrLhz1hzwB5jipb8RhLeA
   n4XUSJ+dWytNXxv2Hok9urGFAXu2vfDY6an03jw8xFK7NauLAtR2yi4vh
   WA9FR9eVV2oPopRsTETg8pw8w1NHLCOMsJ+0JIFKfm7xrkovdmSgNJ9pe
   duXNyAe2cNokpPgKMHViHfR/GQV2lsQhOjoy5n+0QHU0xGPxtiLlVcX60
   Q==;
X-CSE-ConnectionGUID: 2PRibHy2TdC6dND2ehZ4Zg==
X-CSE-MsgGUID: 6qP+xWMNS4CQwd3q6LwBoA==
X-IronPort-AV: E=Sophos;i="6.21,307,1763424000"; 
   d="scan'208";a="13633613"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 22:12:51 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:1549]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.105:2525] with esmtp (Farcaster)
 id 07bad998-1282-4fef-84df-8b2a7f61feae; Mon, 23 Feb 2026 22:12:51 +0000 (UTC)
X-Farcaster-Flow-ID: 07bad998-1282-4fef-84df-8b2a7f61feae
Received: from EX19EXOUWB002.ant.amazon.com (10.250.64.247) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 23 Feb 2026 22:12:49 +0000
Received: from PH0PR07CU006.outbound.protection.outlook.com (10.250.64.238) by
 EX19EXOUWB002.ant.amazon.com (10.250.64.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35
 via Frontend Transport; Mon, 23 Feb 2026 22:12:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcb45AvagwMIPJLo7rb8InFXwWtPvuJ9b02WKE7AvzyIht4bq8kOvQl51vYcS8I9Xct3qLr4jOhb+5hvau1g3bgG7JkT64AcobcoJZR9asHbgi/qG/Pz45UzAs3ac17JSCrN+bysW6+XPeHYV4ieJYRR8f4Aewr5NC+u+0pImN3AiJLIeU4eO12ZAz/PSozZh/aB3J5DBCvviZxZp3C3FXGlmz7mdhbZdWTdOMgol6qToaA9cB5qiKytrAvswGRIkx8jqjJdCqhp+s6SMagnAdT05ywzCG2vxH8DITtdgnqEgRh1m58Pld9rIOn5oTTCzvTK4LWr+2YR+a3BVd8ZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiWRBDRpPzy9hMzb2zq/cS+bELz1z0YsamQ4ESogjEw=;
 b=OiHgDd8JIZwaQlSLn273LTLV0VMqLNGOke1eK7zppievnnNTD8ZebYEoR3Iih4Z9juvYyKZwnMBxPVfDvT4KToA5k+tDEtYxPdlNtUO8kBttWle+3eI5JyN1UIWqAg52eR3qy+AE/qYDSeIf8B2nrD0CxYjFDWAp/sTaS2drRV2rcYw+gfjhRfm3ll2hTn68LGmM5pXIqZYpKMybuq2yRiIotP+b13fp0a9+SIINlKPWLO+Pi9MgrmZH5X/HdkpLUIrZq9YOJydgQ+5KrOeI9EzyTFOpmsFioekfOwXS8S4u3dK/B+5+3SFBLUrF5BNNwdpRxMP+m2y+zKnpW5SRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MW3PR18MB3673.namprd18.prod.outlook.com (2603:10b6:303:57::17)
 by BY3PR18MB4529.namprd18.prod.outlook.com (2603:10b6:a03:3b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.10; Mon, 23 Feb
 2026 22:12:47 +0000
Received: from MW3PR18MB3673.namprd18.prod.outlook.com
 ([fe80::86db:c59c:3fed:2e81]) by MW3PR18MB3673.namprd18.prod.outlook.com
 ([fe80::86db:c59c:3fed:2e81%5]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 22:12:47 +0000
From: "Day, Timothy" <timday@amazon.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "lustre-devel@lists.lustre.org" <lustre-devel@lists.lustre.org>
Subject: [RFC] Lustre Upstreaming Project Update
Thread-Topic: [RFC] Lustre Upstreaming Project Update
Thread-Index: AQHcpRGK3EeF+w0AHEqVbwQXb0TFbw==
Date: Mon, 23 Feb 2026 22:12:47 +0000
Message-ID: <B588ECCE-7CBF-4111-841F-0510A8F5886B@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2026-02-23T22:05:42Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=15dd08bf-be04-43f7-859d-0e3adfab39d5;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR18MB3673:EE_|BY3PR18MB4529:EE_
x-ms-office365-filtering-correlation-id: 8734780a-052d-4611-250f-08de7328ad0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?S252dUdJOVZTRXMwZHRWeU9iT2syN2VoNDg1YnR6Z28zWElFYVZwb3B2aTB3?=
 =?utf-8?B?eUhyNW1qUnpKYUt3bEcxL3AwL2pBUk5RWU51amNPSjM0RkRkcjFCV0VhVnQr?=
 =?utf-8?B?dkNGYjdCd3p3ZTNtSlR2TFZ6SGU2L1o5WlhEZ1BzVU5VMTJzYmtiU0ZHbmtl?=
 =?utf-8?B?TG10RHlYU2tDVlFxSUdjTjRzQkVDVGRKaGZ0YVR5eFNPNkpBTjZmSkY2M3ly?=
 =?utf-8?B?aEg5WjlNODNkbzBJaWdQdXB2VTVoM0pIYkhBd3NBd0hEaVE1cTdwMzRGU1Yz?=
 =?utf-8?B?M08yZzh2SlhkVUphNHhhSnB5Y3VZZlBWdHhWaVA4RW4xVHRpZTVkN0FYOU5h?=
 =?utf-8?B?cVRlMFZ0NmVUQ1pIUVBXbnI0cXA3dmw2NG5IWndabUh0UGpCUDdwRWcxako2?=
 =?utf-8?B?eFdyRmZWckFOVGRXVXNyeEJSd0p1WVlPT2tQaW9kaHRESzhQNEt0ZDZBdEhK?=
 =?utf-8?B?b2ZaUmdPUkp1bzlEc3pGeDZNbE53MEJUQ0hGK0FnbkJmMCtvTFBTT2dvYmZn?=
 =?utf-8?B?TmxMaGdxY3VJcnhRc3h4eXNGMHpKWG9oYWErWWJOSDh3SEFPa2dTQi9JbGZI?=
 =?utf-8?B?dkhCMm4xVzhtV1U2djBMd0tGakxPdG5yOXJRak1BbFRObFE0RFVjUGlxSUpJ?=
 =?utf-8?B?V0g2SFNKYTZJRFNYZWFCZGlwaFk2eFNmckZ4Yk1oK2U2NDArcXhrNUpDMDhl?=
 =?utf-8?B?ajY4UTJFNGZncDlSdTV4Yk1zb0NMYkNnSWpPait4enZqc1pSQmNyYlRvR2Rx?=
 =?utf-8?B?ODI2Znk5M0M0b0N1SUVYV1lmVWFPdlNhdGY2WUlBWEpEMnp1YnVkeVdRcVR2?=
 =?utf-8?B?R2FURUxidGtpdXEyUDYxQnRFYmE5MUQySEZtZFkwc1JnZkdMdDk5eEc5QkxF?=
 =?utf-8?B?SklJVjBid3UzaVdXRnlEWGV1WUR6RExoYUpJcGdKVzg1UEp5WUpHOVVxVi92?=
 =?utf-8?B?Y1pnMFQ1V2Y3WjRuWmxaMWFzTVNrYXJLQUNjazZWckFRTXcrMjhRdE1hYWI0?=
 =?utf-8?B?RWUrUjZMb1V4UHhYYk1OcSs0Tmxmb1dldzMxVFFBVC9hbW9pQWVvMG5RM2pZ?=
 =?utf-8?B?QXRuM3BPUWNtSksydmdsVG1QVGYzZHlHdFY1aURDYjRTOEhrZXhHazBzUjhm?=
 =?utf-8?B?eUdxdzJuM2FuTlM1d1E3eHZ1SnpaeGtBemlKUDJCcEFGaW5nOW9UVVhJc05Q?=
 =?utf-8?B?MS95U1RwVDJvdnlwbmEyN3dYRy9rbldHNkRIdG5xaDhUNjE0TndxOGlRbFFC?=
 =?utf-8?B?a3VpcUpuaDcxdUs1SjVldE42RTd6SzBwTEVUeUhUMURQaEcya0hueTFhT3h3?=
 =?utf-8?B?U0ZMTmMwQUcwck9GSE5IakVpY2xsaHdKd3dXcHBIZlo5MW9WbGdRVjNWaDZx?=
 =?utf-8?B?T0R3YXlIdUhwMjFOa3RiU1FSazk0YTdRMnpvSHREN0xkRVlqRTFlbk9NMW42?=
 =?utf-8?B?SURqdzN6SXZLL2JmUVA1OFVrb0pqYysrRU1YdmwreHhvVjdZY0hVejZPRHMv?=
 =?utf-8?B?UTZNZnAxTitPbXBNWVozWWRvWEZybHVkS1dsdjd5YU0rQm9TVGhvNk1iNjRl?=
 =?utf-8?B?cTVDa3lpaklBbHU0cnhzU3hKS3MwQ3h2MG04b2szbHdKQ2tGMm9WSFltMmlj?=
 =?utf-8?B?S3psWlNYUTVLNVFVR0MzRmZsU0YxV1RwMDlPN3Y1RStrbW9NVHJFcGhVQTJO?=
 =?utf-8?B?bkE3TCtzMkc3L01mZ1lWMU9FMkl2eTkvODlEN1JLWXVuQU00amxpaS9YNUFw?=
 =?utf-8?B?VUszV3QvZVhhZFdrdDhKQW1lZ2dZK3Ftb0ZpZ1cwOGFrZmhaQ2tOQ0ZJWVVD?=
 =?utf-8?B?a0JrbGY3M0MrMWxFVGZMM0RYc3I5ekg3K2lrRnI5cnFVWFVYaVBFdERqTEFE?=
 =?utf-8?B?dWhOODdnRXFVQnY1UlFEdzlxdWxCYXR1R1NVRHFTTUFTR3kxK2dsaDBIb04z?=
 =?utf-8?B?MVRmeFBieWhUeXgvZVBJaHFEOUNGZTZlM2hXeXB6ejYyMHZFZXZrSGcyVU5C?=
 =?utf-8?B?ME9ZU3BFSkpKY1g0N3NEWklQNWZKeHdQM0lGMWpDdXRFL1BiNnR1RUlLaVV6?=
 =?utf-8?B?dTdiTEw3WFp3dU1iS1BMRDJvNVNDY1R6eFl2Mjc1OW1ScWEwd1FTYk5mZloy?=
 =?utf-8?Q?dUvg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR18MB3673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sjd1clBxTndTSDhjc3R4VDhteS9rRUM0OXlPcDFyaFRmdVZzdllOdFJWQjg1?=
 =?utf-8?B?T09WbWhsWnd5VzhmM2pzRUFLZG9wQ3IvcU9WdXJqZitoNVRpYk5qcnA4cGw4?=
 =?utf-8?B?bnRlckhEbHUyTVVkcFl6bWpKU2lOeWN1U0QrRDdjZDlaWUJOeWtXRWxsb2JE?=
 =?utf-8?B?dk80SkRyYzVtVklXa05BZ1pTY1A3Uzd1L1dxZ0JtMkFIZGFqSGRLL1NvOHd2?=
 =?utf-8?B?VVZRVkxmdjlFK055RXQrMWFQY1NOMm15cFZ5ZHFWQ2w3aDdEa3haTkVSQTV1?=
 =?utf-8?B?b0pZYWNJQ2ppN0VGYXNaN21BU0NPdElzWmkwaXZJeFN1MHoxWFFkaWJVNEJF?=
 =?utf-8?B?QW5wSGhmR2xvVmhQWDFvUTkvYkZXMjA5dWxGb1cwclIyWVp3YTYwZC92YmFu?=
 =?utf-8?B?eUxNOElweis4VVR3U3VvUU9CV2RQMjc1QjlVYk4wVHgxK0pLRUkrTFdpWXY4?=
 =?utf-8?B?MnB5RkliZTQyTXdQWGZIVDVFSVhmeGZ2UlFRRjFJbjN2RmMrMGlJMFRIMXlS?=
 =?utf-8?B?MTU4SHFtTVRwczRmUDhveGZBc2VaY09BU1BFUWZMQ0NsOVJpNGxJaThlaGNn?=
 =?utf-8?B?NE85S05GTkpnN3k2MVdPY0lyc2lOeW8wN3NZZjRaa3NjcmFnaXpxVlRFMVhS?=
 =?utf-8?B?NjlMcG81a0ljNm9OTTQ1Z0s2dVdXY3gvWFJmUU03Q1d0YVE2VmxSbTN2bTVR?=
 =?utf-8?B?K2dXNjU5dGtIc1ZtTFNiYnY1WjVuRFA5d0g1cTZZVEk2eGY3eWhVZ0NIZitS?=
 =?utf-8?B?OEFBSGEva0ZocmlxLzhIalM2azZWMXZ6cjRrKzVjUmpjVExKUlNaTUl0S2Vr?=
 =?utf-8?B?eWhVY3p3OW5jR05jTGRucngzcC9FRVJlamlLRkJibHJKeGR4d0xsL2t3Witv?=
 =?utf-8?B?aVpQVThzcm9qOW5QSGU5Q0NkamtYRXNiVDZ5amhGd3hMdUZ5VlVYS3NaQmhy?=
 =?utf-8?B?RWh1WU9HSGJVUmFFU3lBcDc5L1pTOXNTdnhkM0RoYjdkWmNSQ29CVUExT1l2?=
 =?utf-8?B?SmtRSVFwcWVBRFlMVXJ6eGxldjRnbTF5STdrb2RlQWwvaXpPM0ZLUDllR1VM?=
 =?utf-8?B?cHdyRUVieEEzWFJKL1dDbGJrVXIvNEZNUjRpU2VGbmVGYndJaklSRVNJUWhp?=
 =?utf-8?B?WW1SM1B0cW9wSXZ1dXgrdDRxc2RRZG9BazJBOHpqaHpJbS9yellSQ0tpTVh3?=
 =?utf-8?B?R0tFV0FIcEN2UEpBODVUL1k4bHAxTVNzUDNhQTdVT1NhN2tobTNPeWc3R2JL?=
 =?utf-8?B?eHdic3dWVWJYNDRwMGI5Z2lRYTgrSHMxU0hMeDRtMnpjVnl6Nzk1bjQwQUs1?=
 =?utf-8?B?WWlVdUY5b0JzejBRc0hNcldXdlNlR0lCKzgxbEtmK1RlY1VaY2ZYTktSUERZ?=
 =?utf-8?B?L2pNYVdYN2ozQUFWNjJKUlZ6TXpHU05iZGhucFlROWpCNUd5TzhmQWNhalND?=
 =?utf-8?B?ZU9ONnFUSzFQZVBDa29wTm1wVHZWb3hNczdSN2tuYnRqNGYvME5DWExQbEN4?=
 =?utf-8?B?TUxIVGU3bExQUkNsU1pUWHllNjhKZzBCWnJKcTJ3NldpTzY2R3IxT3JxeHd1?=
 =?utf-8?B?bHZUWWRPNnJ6ZXhON0hkSFdCai9uNklSNVhDS0NOWXlhSHQ5aVNCMWNkNzdh?=
 =?utf-8?B?bDEvY2RDb0FmdS9tUFh3R2RtbHV5MnZTR25EU3dwakdUSDVRdUdyZEUvUWM4?=
 =?utf-8?B?bXZWTUt4cm9kODd4OTFNZEs0Y2NZbTlTRG5zZ0tjM0tBZDNjQURCUjN3cjI1?=
 =?utf-8?B?RUl1OXJZY3dRMTdpN0lWQnBLZEEvUkZOdTVOYk9MNGJHSHJZMlRvS1dKR3A4?=
 =?utf-8?B?T3UxRzgzUHdwL01KbXVCMnVEU0hiZVJUSDNqb2pOcnZreklES2IwemNXYUNM?=
 =?utf-8?B?U0FlNWNtZzE3OGlvUEEvT2pMdFFqUjZQdWc3NlR3d0NxSHQxQWhOTVNQZG9R?=
 =?utf-8?B?Nml3Qm8wY1lJOE1JZkVtV2RWaUF5OW1WWFZCVTlTbFhNQkVoVGJGSVQ5Rzhi?=
 =?utf-8?B?clk1S1hLUXdBdFkvZlNRVG8yOExibWpZS1ZEVkVpTklzb3k4c2RWU1N4QzBv?=
 =?utf-8?B?MUFlT2FlZGNJRVBNTVhDK08yMGJxZzRDeE83NUZRcHhVa0tTSmxsSElHSmpw?=
 =?utf-8?B?QVFOTFUxN01ucXhWOTBMclhOWEJQMCs4emNjU3FIUFhFMlpUOUprQUpnc0J5?=
 =?utf-8?B?TDh2Y1NxMGpja05OMHN6ZFNNanhoaFJDYy9rWldNamp2YTZWaWoxZUJhZlhF?=
 =?utf-8?B?L1pBMEVweWtpbEh3U01MMzVMMWJrT3FWMC9LcEk2NytuSVBaSHdxMWNZay8z?=
 =?utf-8?B?U3BQcGlUamhsRi9HeDRLRitaLzEyWkk2anIyV3lKeTgrVXVxTjBUUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <612FDAEB218C7049916ECE709F862123@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR18MB3673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8734780a-052d-4611-250f-08de7328ad0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 22:12:47.1863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nRKbAzYhrLj0IoLC3mYmS2rwWfbVUWUcbpFx5v+r8KfQioXDEivGzbUV6A2nyS9735VgQPBhwB08s2yucxGMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4529
X-OriginatorOrg: amazon.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.06 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78009-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lwn.net:url,kernelci.org:url,tim-day-387.github.io:url,lustre.org:url,whamcloud.com:url];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[timday@amazon.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7464117E383
X-Rspamd-Action: no action

TGFzdCB5ZWFyLCB3ZSBhdHRlbmRlZCBMU0YgdG8gdGFsayBhYm91dCB1cHN0cmVhbWluZyB0aGUg
THVzdHJlIGZpbGVzeXN0ZW0NClsxXS4gSSB3YW50ZWQgdG8gc2hhcmUgYW4gdXBkYXRlICh0byBm
c2RldmVsIGFuZCBsdXN0cmUtZGV2ZWwpIGFib3V0IHRoZQ0Kd29yayB3ZSd2ZSBhY2hpZXZlZCBh
bmQgb3VyIHBsYW5zIGluIHRoZSBjb21pbmcgeWVhci4NCg0KV2Ugb3V0bGluZWQgYSBwbGFuIFsy
XSBmb3IgY29udmVydGluZyBvdXIgb3V0LW9mLXRyZWUgcmVwb3NpdG9yeSBpbnRvIGENCmNsZWFu
IHBhdGNoIHNlcmllcyBvbiB0aGUgbWFpbmxpbmUga2VybmVsLiBUaGlzIHByb2Nlc3Mgd291bGQg
aW52b2x2ZQ0Kc3BsaXR0aW5nIG91ciBleGlzdGluZyBjb2RlIGJhc2UgaW50byBhIHNldCBvZiBj
bGVhbiwgaWRpb21hdGljIGtlcm5lbA0KbW9kdWxlcyBhbmQgYSBsdXN0cmVfY29tcGF0LyBiYWNr
d2FyZCBjb21wYXRpYmlsaXR5IGxheWVyIHRvIHN1cHBvcnQNCmV4aXN0aW5nIHVzZXJzIG9mIEx1
c3RyZSBvbiBMVFMga2VybmVscy4gU28gZmFyLCB0aGUgaW5pdGlhbCBzcGxpdCBoYXMNCmJlZW4g
bW9zdGx5IGNvbXBsZXRlZCBhbmQgd2UgYXJlIHdvcmtpbmcgb24gc2ltcGxpZnlpbmcgdGhlIEx1
c3RyZSBidWlsZA0Kc3lzdGVtIGFuZCBzdGFydGluZyB0byBjbGVhbiB1cCBpbmxpbmUgbm9uLUNP
TkZJRyAjaWZkZWZzLiBJIG9yaWdpbmFsbHkNCmVzdGltYXRlZCB0aGF0IHdlIHdvdWxkIGJlIGFi
bGUgdG8gcG9zdCBwYXRjaGVzIG9uIHRoZSBtYWlsaW5nIGxpc3QgYnkNCk5vdmVtYmVyIDIwMjYu
IEJ1dCBJIHRoaW5rIDIwMjdRMSBpcyBtb3JlIGxpa2VseSwgZ2l2ZW4gdGhlIGN1cnJlbnQgYW1v
dW50DQpvZiBvdXRzdGFuZGluZyB3b3JrLg0KDQpBIHN1bW1hcnkgb2YgdGhlIG1ham9yIG9uZ29p
bmcgcHJvamVjdHMgY2FuIGJlIHNlZW4gb24gb3VyIHdpa2kgcGFnZSBbMl0uDQpUaGUgZm9saW8g
dHJhbnNpdGlvbiBpcyBvbmdvaW5nIGFuZCBwcmVkaWN0ZWQgdG8gbGFuZCBpbiB0aGUgY29taW5n
IG1vbnRocywNCndpdGggc29tZSBvZiB0aGUgaW5pdGlhbCBwYXRjaGVzIGxhbmRpbmcgc29vbmVy
LiBXZSBjb250aW51ZSB0byBtb3ZlIGF3YXkNCmZyb20gTHVzdHJlJ3MgY3VzdG9tIChvciBvdXQt
b2YtdHJlZSkgaW50ZXJmYWNlcyAtIHN1Y2ggYXMgY29udmVydGluZyB0bw0Kcmhhc2h0YWJsZSBv
ciBhZG9wdGluZyB0aGUgcDJwZG1hIGZyYW1ld29yay4gTW9zdCBvZiB0aGUgY29kZSBiYXNlIGhh
cw0KYmVlbiBjb252ZXJ0ZWQgKG9yIGlzIGluIHRoZSBwcm9jZXNzIG9mIGJlaW5nIGNvbnZlcnRl
ZCkgdG8gbW9yZSBzdGFuZGFyZA0Ka2VybmVsIHN0eWxlIC0gd2l0aCByZWNlbnQgcGF0Y2hlcyBm
b2N1c2luZyBvbiBjb252ZXJ0aW5nIGZyb20gRG94eWdlbiB0bw0Ka2VybmVsLWRvYyBmb3IgY29k
ZSBjb21tZW50cy4gVGhlcmUgYXJlIHNldmVyYWwgc21hbGxlciBwcm9qZWN0cyBhbmQNCnRhc2tz
IHRoYXQgYXJlIG9uZ29pbmcuDQoNCkFsdGhvdWdoIHdlIGhhdmUgcHJpbWFyaWx5IGZvY3VzZWQg
b24gdGhlIEx1c3RyZSBjbGllbnQgLSB0aGUgTHVzdHJlIGNsaWVudA0KYW5kIHNlcnZlciBhcmUg
Y2xvc2VseSBsaW5rZWQgYW5kIHdlIGludGVuZCB0byB1cHN0cmVhbSB0aGVtIGJvdGggKGVpdGhl
cg0KaW4gcXVpY2sgc3VjY2Vzc2lvbiBvciB0b2dldGhlcikuIE91ciBpbml0aWFsIHN1Ym1pc3Np
b24gb2YgdGhlIHNlcnZlciBjb2RlDQp3aWxsIG9ubHkgaW5jbHVkZSB0aGUgaW4tbWVtb3J5IHN0
b3JhZ2UgYmFja2VuZC4gQWx0aG91Z2ggd29yayBjb250aW51ZXMgb24NCnByZXBhcmluZyB0byB1
cHN0cmVhbSBjaGFuZ2VzIHRvIGV4dDQgdG8gd29yayBhcyBhIGJhY2tlbmQsIHdlIGRvbid0IGV4
cGVjdA0KdGhhdCB3b3JrIHdpbGwgYmUgaW5jbHVkZWQgaW4gdGhlIGluaXRpYWwgc3VibWlzc2lv
biBvZiB0aGUgc2VydmVyIGNvZGUuDQpUaGlzIHdpbGwgZ3JlYXRseSBzaW1wbGlmeSB1cHN0cmVh
bWluZyBlZmZvcnRzIHdoaWxlIHN0aWxsIGVuYWJsaW5nIGRldmVsb3BlcnMNCnRvIGVhc2lseSB0
ZXN0IHRoZWlyIEx1c3RyZSBjb2RlIGNoYW5nZXMuDQoNClJlZ2FyZGluZyB0ZXN0aW5nLCBJJ3Zl
IHNldCB1cCBhIG1vZGVzdCB0ZXN0IGJvdCB0byB2YWxpZGF0ZSBkaWZmZXJlbnQNCmJ1aWxkIGNv
bmZpZ3VyYXRpb25zIG9uIHRoZSBsYXRlc3QgbWFpbmxpbmUga2VybmVscyBbM10uIFdoaWxlIEx1
c3RyZQ0KYWxyZWFkeSBoYXMgZXh0ZW5zaXZlIHBlci1wYXRjaCB0ZXN0aW5nIFs0XVs1XSwgdGhp
cyBib3QgaXMgZm9jdXNlZCBzb2xlbHkNCm9uIHRoZSBuZWVkcyBhbmQgcmVxdWlyZW1lbnRzIG9m
IHRoZSB1cHN0cmVhbWluZyBwcm9qZWN0LiBMaW51eCBzdXBwb3J0cyBhDQpsYXJnZSB2YXJpZXR5
IG9mIHBsYXRmb3JtcyBhbmQgY29uZmlndXJhdGlvbnMgdGhhdCBMdXN0cmUgY3VzdG9tZXJzIHR5
cGljYWxseQ0KZG8gbm90IHVzZS4gQnV0IHdlIHdhbnQgdG8gdmFsaWRhdGUgYXMgbWFueSBvZiB0
aGVzZSBjb25maWd1cmF0aW9ucyBhcyBwb3NzaWJsZQ0KKGF0IGxlYXN0IGF0IGEgYmFzaWMgbGV2
ZWwpIHRvIG1pbmltaXplIGZyaWN0aW9uIGluIHRoZSBmdXR1cmUuIEFzIHdlIGdldA0KY2xvc2Vy
IHRvIHVwc3RyZWFtaW5nLCB3ZSBtYXkgaW52ZXN0aWdhdGUgS2VybmVsQ0kgWzZdIHRvIHN1cmZh
Y2Ugc29tZSBvZiB0aGVzZQ0KaXNzdWVzIChpbiBhZGRpdGlvbiB0byBvdXIgb3RoZXIgdGVzdGlu
ZykuDQoNCk92ZXJhbGwsIEkgdGhpbmsgd2UgbWFkZSBzb2xpZCBwcm9ncmVzcy4gV2hpbGUgdGhl
cmUgaXMgc29tZSB3b3JrIHRoYXQgSQ0Kd2lzaCB3ZSBjb3VsZCBoYXZlIGZpbmlzaGVkIGJ5IG5v
dywgSSdtIG9wdGltaXN0aWMgdGhhdCB3ZSB3aWxsIGFjaGlldmUgdGhlDQpidWxrIG9mIG91ciBn
b2FscyBieSB0aGlzIHRpbWUgbmV4dCB5ZWFyLiBUaGVyZSB3aWxsIGJlIG1vcmUgZGlzY3Vzc2lv
bg0KYWJvdXQgdGhlIHN0YXRlIG9mIHRoZSB1cHN0cmVhbWluZyBwcm9qZWN0IGF0IHRoZSB1cGNv
bWluZyBMdXN0cmUgVXNlcg0KR3JvdXAgWzddLiBUaGlzIHdpbGwgYWxzbyBnaXZlIHVzIGEgY2hh
bmNlIHRvIGRpc2N1c3MgaXNzdWVzIHBlcnRpbmVudCB0bw0KdXBzdHJlYW1pbmcgaW4tcGVyc29u
LiBXZSB3aWxsIG5vdCBiZSBhdHRlbmRpbmcgTFNGIHRoaXMgeWVhciAtIGFsdGhvdWdoDQp3ZSBt
YXkgYXR0ZW5kIGluIHRoZSBmdXR1cmUgKGFzIG5lZWRlZCkgb25jZSB3ZSBoYXZlIG9mZmljaWFs
bHkgc3VibWl0dGVkDQpwYXRjaGVzIGZvciByZXZpZXcuIFVudGlsIHRoZW4sIEknbSBsb29raW5n
IGZvcndhcmQgdG8gYW5vdGhlciBwcm9kdWN0aXZlDQp5ZWFyLg0KDQpUaW0gRGF5DQoNClsxXSAi
R2V0dGluZyBMdXN0cmUgVXBzdHJlYW0iIC0gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzEwMjUy
NjgvDQpbMl0gV2lraSAtIGh0dHBzOi8vd2lraS5sdXN0cmUub3JnL0x1c3RyZV9VcHN0cmVhbWlu
Z190b19MaW51eF9LZXJuZWwNClszXSBVcHN0cmVhbSBUZXN0aW5nIEJvdCAtIGh0dHBzOi8vdGlt
LWRheS0zODcuZ2l0aHViLmlvL3Vwc3RyZWFtLXBhdGNoLXJldmlldy8jDQpbNF0gSmVua2lucyAt
IGh0dHBzOi8vYnVpbGQud2hhbWNsb3VkLmNvbS8NCls1XSBNYWxvbyBUZXN0aW5nIC0gaHR0cHM6
Ly90ZXN0aW5nLndoYW1jbG91ZC5jb20vDQpbNl0gS2VybmVsQ0kgLSBodHRwczovL2tlcm5lbGNp
Lm9yZy8NCls3XSBMVUcyMDI2IC0gaHR0cHM6Ly93d3cub3BlbnNmcy5vcmcvbHVnLTIwMjYvDQoN
Cg0K

