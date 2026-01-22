Return-Path: <linux-fsdevel+bounces-75022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCEFO3UMcmksawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:39:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99449661E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 947F5700C9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933484418D1;
	Thu, 22 Jan 2026 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ctA/1z3a";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OPEBp4qE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DE267AF6;
	Thu, 22 Jan 2026 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079903; cv=fail; b=awJ65ahfAanmCvH/5M7UtRveXv5WuU8D6hG9VNxotyUyUmKm3dUn7ovw5m0TienvGixlzcabXTu3bO/N8y0YWO6kUHS2qMO2KSkhBRDuq8xqnVhmoDFHA4qhICQv9oq/AFH9HyeOTxVwHA93nVILcrIzyRcd3AopttUajsQ8Uc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079903; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wrjja8wv5z6TL4EOzsf1eEI+w1VsQ+Vmr6ws1O7CMXIby3AE6h47HN+qguQVSXUWXSOwqDPgpgcRbCVM4MedOHZN6unPpjxqmkmLDkh6buaLgFs1cjCT5Iq7nz4f+Tju0pTT1mTwx2A2B3T+6u45VXyMKthg03P3A4uf9Lhr5ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ctA/1z3a; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OPEBp4qE; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769079901; x=1800615901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=ctA/1z3aPjThtIz4S6SydGNiExAHgEdcEWDiC0wufQTpjWggf/7vhu65
   TeEXfw99d5iC5mF9g4xDte4TQryXFv72+R/QoM99Hdr/WkmQxE/YtGv7J
   RturYUdgGouOMOLKc1ryqynFv9qDj76lc0SeniT0bdwyaPAbbEe0OpL0h
   t6t7ZCR751wFdgaOBTAr8spbbPnnuG7RqjPbjggQB13oSBV4cEFMsptLG
   GYNSyntE1792W/TqsngGz7bBL4/+pkFcEs65Qh59V2UGd1WulyE0sQQwX
   uLWKwv0wxZMLDEaa1TRUztQRWW96XfqQiGXPPjudayl70yyesgpx2GteT
   w==;
X-CSE-ConnectionGUID: U+HfayJASGGCoerZtvl4ZQ==
X-CSE-MsgGUID: nuMqsikgRJqAf/ePaSEkEg==
X-IronPort-AV: E=Sophos;i="6.21,246,1763395200"; 
   d="scan'208";a="139271159"
Received: from mail-northcentralusazon11013023.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.23])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2026 19:04:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQzeWrfM9RVILzaVNULNIyufmwUFBPAzJRLMRl3OrIZeDtBIXnsXzq7frmm760F8Hzgcq2omXMRw68WieAVZ4T0Sb8frNRsm6I53DLgxxVgbcsmfLQ5voeGlYgQwrf03wjFUDmGinz8m0Yy7pOtu8CLclZWrB9zVriYa+zrxIe81kbI8p4OtnfdaCMrnK+2JXZOE0aYf8Dmj6o3PRx2xPTzJ66tQNt5oAuOlP2XSqbOkxWNBoX5Ii/r0jJa3Hg1y1VAzivM9+omwajFLf65fx1xPuhhKOFFG/LPThtUdAgzVKuhZY0xCSodjifT/7BwNRY4ooK34LcvUkjeKek46iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=TklIItfDZLRXR5GRXeShHWwGqzaZHLZK0e1Vfgo4/ArT0T63yTwm/blVfEUvkdz+wurQas4G5Alo5m7Gps3jnYQ+hPXI4VCI2Fb+B//WBcvLji+WIbYT5qjQ04iPWpBIqSq4OC+zhr2NplMru9ukYUJ2DyuoTf/OF0z/BTY63s9dZpszGArBhjtV3/evRA6MTOwtTEEHXosumnIGfr2k09hCQk5c293XQuRHPD14Cj403wS5e7LajwOKg1FAdzuAdmXF04dHLrNyUzAXDn3Jwj3uKIfXD32JJXkep6g3shWYFb/kxA4hO5+0itLy3egUVYQZ6CSRQjaEv99YCUdhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=OPEBp4qEdPmiMDOzpP9ZRpCKkY/ULJnvyVhbSvf4MxxMW4a03ty9AdBJfhTRxH5ExmHDMXkBcLXAEfXOiXSIHkjwM9jOK9EZiA1mLW1aWsZH+e9zbogYDGITnTMqAIMCj1PBI4g+q4cMxQeHQikzlJ7njz1SfFFB/jOd4t3czhI=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH0PR04MB8084.namprd04.prod.outlook.com (2603:10b6:610:f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 11:04:50 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Thu, 22 Jan 2026
 11:04:50 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian Brauner
	<brauner@kernel.org>
CC: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	WenRuo Qu <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 02/14] block: open code bio_add_page and fix handling of
 mismatching P2P ranges
Thread-Topic: [PATCH 02/14] block: open code bio_add_page and fix handling of
 mismatching P2P ranges
Thread-Index: AQHciRd/rWm9agU78EG2TasXgYqbKrVeC6qA
Date: Thu, 22 Jan 2026 11:04:49 +0000
Message-ID: <7cebb0e0-17e1-4268-9a0a-f41e50548d0e@wdc.com>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-3-hch@lst.de>
In-Reply-To: <20260119074425.4005867-3-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH0PR04MB8084:EE_
x-ms-office365-filtering-correlation-id: 1d491efc-b935-4eff-61f1-08de59a60fea
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|19092799006|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkNDYWVreUREaHFzY1ZndUpweit6MjZVZzRvdGV2Sm9pZEU5QjFjY1lQVWc0?=
 =?utf-8?B?a0hXVi9SclFpbDNIRjFNdm1YQkVKR0Fya0RPb3pURk1rOVljWTFEa2NselZx?=
 =?utf-8?B?bGtoczRNa093U1VZd1o4aEdET1FZK2VxUUF0eDFmMWpPV1JXeXQyWTFUWklW?=
 =?utf-8?B?VnZEK0N1R0JIS0Fta0lkRWV3R2l1QWQxdmlENFJlNVlmZkhhcXVRaFQzQlFz?=
 =?utf-8?B?T1d0Vk1leTNTdzd4OTk2ZHcyR1RLWkFTWU13dHFpOUFOVytiMUIvajNhVkdo?=
 =?utf-8?B?TTlFUjlheFdHRm5BMjVJN2ZzUzZUdHo4UTdpUUZIME5xL1RUVytkcGo1cWlx?=
 =?utf-8?B?Z2FzYWQrUFFsd0dOWW9LS0trMTFHSVBEMDFYRk1tNnpUTnFreFg0WEdiSStm?=
 =?utf-8?B?QStYNzRwVUFGZTR1MEU0U2RQR01lQWxMYXJISituY0t3NVEyTFJtUVhrZ2hi?=
 =?utf-8?B?VURBMENSa0VrazYyR2JQZnp3dEEzS21SWFpCdGFqZGNReTMwL3RueXJCVjFl?=
 =?utf-8?B?aHBlc2RTYUZOUStaOFN1MmY4TVRkRjB2R04vV21yWHQ3cVltYmphcTRRR2ly?=
 =?utf-8?B?SGNhZkYvSzNxSnRZRFhiaVc0dGRYZWJWRmxNdGFtSHpNaTJkb2ZVNDIzdlBR?=
 =?utf-8?B?cG05QkpYWTZWSVE2MjR0cUNwMFB5T2dJK3RDZmVTREdhRjA1ckNJOGR6QUsx?=
 =?utf-8?B?NUVUNW9XRWZSdXZSRjlKZmlNb0IrdFFWLzRmT2h3SWtTRWtFeDB1TVpVbS9J?=
 =?utf-8?B?eHFrNkpSL29La25DZ1BOczN1cmUvYkE1bG93cUQ2RmtWMTRONW5sNlppVzRq?=
 =?utf-8?B?OHBmR3Qzb2ZIMkNmQ2hEbk53K05JVG9lWk9QZnBWbmRrdkZ6MUQ1ZS9acWRL?=
 =?utf-8?B?V3gvVzV2di9HMWJyQWRuRnZadVc1VVA4aGhtM21POVh2MzBFbkVHcEJ4QWln?=
 =?utf-8?B?eXQrWVhIMTA4WHVJekplUTVCVEtpNzVaQ1poNlQ2bk1BUm1oeGdQeDFRTTZm?=
 =?utf-8?B?NjVUNDg1cmd5NXZzN3E0b1A3dmptaCtHbzY0S1ZSUXM2dHE5QU9sRWJFdkYw?=
 =?utf-8?B?RXJrZTUwNHJlai92YXBmRXcwWjFwOHoramtqZTc0cHhlUGhveVR0d2c4bHh1?=
 =?utf-8?B?TzdCVzNvR1gyTFdzaUxxV2gycnFGc1phOFYvd2VnLzZ5UGU3STRsQmR0b21z?=
 =?utf-8?B?ZUJBYTJmRk82c3RjY0ZlbWsvTkRlbW54OFVILzdxWUVqcW8yWU52WTc3Mzhm?=
 =?utf-8?B?b0JyZ1hEd3kwN3g5V3hJY28wTHk3Z3JPZ1ROZ2tKQ3dESmRraFNPalVydnpE?=
 =?utf-8?B?bFkreEFvV1R5cml4TVNMZFNPUzRkN3NoM2RGRnlqVU9XMkNSMjNjV051dkcx?=
 =?utf-8?B?bWJ5ZGR3Z3UzSTUzUGFNeFVieW9hTkR2R08vNTNHZ1pGVXowQ05yZitrL0do?=
 =?utf-8?B?OUJBa1hnZE9lTEdoa3BXSzUwZ1ZlSit5dklkRTdLbG9rSmhJcFBBWmwvZ3dG?=
 =?utf-8?B?WFF4a0l3LzRwaE9sa3kxdXdVazU0bU1zZUwyVXFNVVBMNTF4MGlPbi9STy85?=
 =?utf-8?B?Zm9oOXV6eVJ3STgyaXNKN2ZJRkpPK2hqdTR6Q25icVJlTklFZDRmaW9IQklU?=
 =?utf-8?B?VnRoSjg0WUZ3Ykx3R1dkVzhoL1FoWjhTRUNsL2V4YjJ5bVBjYnArVjNVUGc2?=
 =?utf-8?B?UmJzek9pbml1cHJSNjVJaFdvVUZ3Ry9xN1MxK1pWd2tUSGpNWitXY2hhbngy?=
 =?utf-8?B?YlcxVGNTLzIvdlVTYVo0cFRZdTV0aG1INGVHWXoyUXNGWWRpdFBxUUhZbkdZ?=
 =?utf-8?B?bVlPdE1BYW94UlNraUZsVVFvZ1A0U05LN1BQd2c5a0lDWFM1dW41YnNNaWx6?=
 =?utf-8?B?aENZajJLYTZsYU45YVlLQjQzcnNMbmtqZ0tPVUZDTDQ2RGtndGlzckpmVTFB?=
 =?utf-8?B?ZFVlTi84bHNyOEVrWnRuUlJRVlZ6YUlmclpMbTk0YUFmdDR4WHdURVYzcG9y?=
 =?utf-8?B?blkyOGpWcVJ6TVMvTEZ4amxWT1M1ZTF3WHU4ZWN6czNVREY4YXpPK0NuZkIw?=
 =?utf-8?B?SFJoWmkxOHZLWFBHZ0p3d01kSjBLN1V1bmIvSUdCQnlPV0dUVGtNajJxTU5Y?=
 =?utf-8?B?WkpOL0xwdEJDd1hkN09hWHBwenVpdWVMVXpCdW1zQnFSNFJxNWQzT3ZLTXNH?=
 =?utf-8?Q?OhKfPRj2DUJ97z84PskUuD8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmRhcGJxWFpkRk53VWpUWE95cTdha1FXZllwUjhJbFovbEt0Y3VVWWpWRG1X?=
 =?utf-8?B?RkgrY1c1U08xQ2tWcktnMU8ydEdDajAxcjlFU1VkNC9qRUJzc2F1NTdMc1U1?=
 =?utf-8?B?U01idnB2Wk9CQXhTUVJWOU1JT0VrWjZNM0V2UEFRcS9laUNwUUNwQVpmQzNi?=
 =?utf-8?B?TmZXQTFVRTJyVFZpK1BIYXg4VjA2L0c5cUpraEs1VHFRK0xZRXcxcXdpTVZ3?=
 =?utf-8?B?ekRXcGFBblJlc1IyTnRLeWVWZkNJS0JVS1pSZ0hVTXRZaDBveUlsWWd5SmY5?=
 =?utf-8?B?WmlvbGg4eGZOMXBWOHc1b2R1UUkrVFl5YllrZ2dnbkozMGc2WnIwZmtmUmp4?=
 =?utf-8?B?K0hiNVJEQ0dFSkdYVTlYVUdSaVRxYk4vOUhUd3habjV6N1pyOHBOQVpNdXh4?=
 =?utf-8?B?UExvcUl0NzVEcjEyaWJIV3dDZ3BTQjgyMHlLU0hJMWhhWHVyR2JOc2JtdlBC?=
 =?utf-8?B?aXIwcDVEdXZMY3ZTb0UvLzF2WS9nc3VOWUo0VHlYSWpaOFNRWW56VC80bVZW?=
 =?utf-8?B?VW45ME83VWZzQUdyNWtLMy9NVk13OXFDUlBBT1FNRE9sS25sZC9YNGJGZHp4?=
 =?utf-8?B?V0xjNEhueDZoWTdUbHBveVd2Wm9NS2ZlMTFRWVZDU1NXMzM5RVlNTzcxUnlK?=
 =?utf-8?B?Z0hKUTc2Y0RWcTc2QzNzSFg4c3B6bkVoemdHTmJBcklQUzNaQk9yVTFScmsx?=
 =?utf-8?B?NTBkRWhERUVPQmIyMGRNaHFPNkhXZWwwOUplWDdQT29ZVXJxc2RUT3JXU2ZD?=
 =?utf-8?B?NmIwR0M4M1JLKzcyTVBZVzljRTF3Ym5xeS9tRWNKTlVqa0V0YWRKazhxZ1RL?=
 =?utf-8?B?KzlhMnF5WXBRcm4vRUpaTzFqTmFudnFpQWVleFpjYXNPNUY0YmdGWU5NMDk1?=
 =?utf-8?B?dmZLVkhKMHBodHlFdEJ4amhKdnI0SVdQMitkV01QbkxxdGU3WWpieGxiOWV2?=
 =?utf-8?B?UnlYREZzMTdNTENhSGg1WXVka1FKYmNaM1hVM2tLbld1NHZoYXVYT0RPc3lR?=
 =?utf-8?B?aVRwUmpvekk1Z0RVMnZMUWE1eVJXYWFZWmd5MDFVRHN5Mm1lM1pMM3RVT2kx?=
 =?utf-8?B?eGt2SDMySjdsSFJ3YnRabklrQnE3Sm0vd3djeEJMbEtWTEdBajNPYW9TWEZE?=
 =?utf-8?B?ZVF2UDNkZk45SlFYcFlqaFJTQzBnNEFFM2djTzQ5SkducW1pZmFxUEREbWR2?=
 =?utf-8?B?VWczUGFPRWlNM2FTY3Z2c1RtNE1sOGQvOG1yQmJtdkZZQy9XbzJuUGZyY1U0?=
 =?utf-8?B?MjBWS2VRZWc3OXh5elBTVXpNOTdYOFBNSmd2UFNlSyt5UFZucXhKQjN0Qmgr?=
 =?utf-8?B?UEsxUUs0RnBubGZPS1E5a0dOSVFYMHZXMUx4VGRNRys2cmw5dkdITGZpOWp6?=
 =?utf-8?B?MHZ4MUJnRDFYd1NCTXM1bjBLdnhRSGZpLzZaT1JZbnJOQU1LTmlrNVpXQzJt?=
 =?utf-8?B?VHhBZ1pJWUpOeEwyeVdNQjFrakZPVWdlVTJoZ00wWmgrTGJnRXFORU55YWYx?=
 =?utf-8?B?MjlMZlc3SXFpTWd0N09GYUN1d1RONU9vMy8wekNzVFN2dzdOYkl2SEJ5NGYv?=
 =?utf-8?B?dmI4NkxzeDRMcXdiYnUrWS9keHZWQm10eCtMa0U1V2lWdTQxN1h0RjZFalcy?=
 =?utf-8?B?ZzdMNklXQmptZm9rUVZDMUpKMnZSb0w2RVMvdGgySFNlcHpzT1lmR3gwWk1D?=
 =?utf-8?B?RlV4a1Y3UVpDMGNscE1hL2M3MlNaK2dBRlM3R2p0UEtJUmJaajBKUGlJczd3?=
 =?utf-8?B?R3BpT3pwdDBXUmRCRDZUWVVaUEYrRFBSVVNqcXZhemlTenJXSzFtN3Mzc0ww?=
 =?utf-8?B?VEhiZ3FlbzQ0cnVJeHo5Y3lFK05ZcURWdGljc0dvamNveGQrb1Q4V3c4T2ty?=
 =?utf-8?B?VHRGT0QrWlVNckUwR0U0dDdDNkxCVEhnUzdsRm1RdUxhcEpOUjRZS0NJbFNv?=
 =?utf-8?B?QUJCLy9FSCthWWtlK05HWlc1YWYvVEd2cTFNVlJrdGVxVS9yRHNDbHVXaldK?=
 =?utf-8?B?M2dIQUZzdFUwVHpDNHdIaXEwUC9YODJHdStwMFErRVBHZ3hvcDV2WTNxSGQ0?=
 =?utf-8?B?L3pTVWVralBRSnRYZjlkM3BxaGJOUHJGMndWQ25EWnJTTzRJMmFnNUxzYWxG?=
 =?utf-8?B?MjE0aGxadThGeUFaMktudDZRWmJFTXJYSCtGVUJWMnpSYXVrNEZDU21uUkVV?=
 =?utf-8?B?S3dveVhnZVlIcTkvK1VxUU1TT0VxZ2RlM2VPVXF3SGMwSThhSzB0SVg4YS90?=
 =?utf-8?B?RkF6TUVhN2JJWHVUUzQzNUJqNHQ5ZWkyamdhNDFYODlWa2VzQ083SzF5WWhv?=
 =?utf-8?B?TWVYNjJNRS9rM0pHL2Z6Y0FtTW5rdDFVUndzTWtCejllR1hpN1VGcWttSHJH?=
 =?utf-8?Q?oTUNfbOSLhe9LH1QnEe8o1EePjFiyiLGrjQ+VSwtP6NMP?=
x-ms-exchange-antispam-messagedata-1: 7zbgGmdDnQ7OFmc2NGoCGaST76zMOow8+qc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D686ADD9F533F14993D004A5237525EF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GMi+4cUc0qfFAlZEJ4gwbkRaislPcJnDKfvbEXmWh0v4GSjBO0H3VxJcE+hWdJUapEx3al1nq+flObnC75Z5LEZp+bRAiD3TH/6IdhLrQVsG+juPp4K2mM//X8CxBHlBYQG8gMaKwW3UbJpRSCIbGrcm3MrH5tKaHoS7M1RF9h+7BQ8b+qP178zJ/JqB/z2oIr81l6tE9MWoRHJZWwntJNb5pz5aBCq3QcZ5lVyeCYslrPCHvLr+2iBDEtUQImmWGEHEJxjCVbQ3Jbt40t/wVih+ZrmePB6jvqbNpCpNBWdZ0uMBRRSRmqjYc+89Mszsms/lLtONGIVvUZQJ+9qAP8/DGFjKxTbx/id2m56cwTgDMZNnNgmG0jMLIDSkLreVK4Bh4fGQSPgqj53hZhe3xR9bVyE15+iANQ59NJ7IYqXmBeRDvDlYmA5EiqSGJuot5v9ytcIQNKsPkh+DkejJoEjPM67Ol7HKtw1GtdQ0Ngsx1pWy/FyzpGnuTB4oO2q3th8l234eoQ36OTxjqgXh5+Iqbix4CuLV+nVgkyRQRQ5fMswmlVM5llnqtVTDvcR19cIoMfMagfsPtpoql5K+x4tHZwWtP6gGMC988HBPtpaL+/MiRt9bFs91yfygeImn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d491efc-b935-4eff-61f1-08de59a60fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 11:04:49.9321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIuXPm4CHzcr34xMc93Uyq9fKG9z0RIz6r5+YaQ5RDborwJleWd4U2X6SWSjeoLPQk4HCXAyR/T+TWzQKGW4fJ0wm1yJr9RXMtAlJ13RyRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75022-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[wdc.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sharedspace.onmicrosoft.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,wdc.com:email,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Queue-Id: 99449661E2
X-Rspamd-Action: no action

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

