Return-Path: <linux-fsdevel+bounces-75023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC+UBxEKcmmOagAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:29:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F3065FFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B73F7215F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E1C477997;
	Thu, 22 Jan 2026 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yq+lDV3f";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jWCRiu2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3ED46AED4;
	Thu, 22 Jan 2026 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080494; cv=fail; b=dVGyC5AXEj1+jsEg6uNK7WUKTFqL5Z6K8F1/CVTeH1m9gp4bM6Z2sM5ZrFq21YzWj44/5PS8vE16ROW6oQ/xBlsj0Zj/ri3vEzrkXZK+Ih69bRyqtNrMMS/j23XRUylRbHqo5976a9SruHrX2Y6cjt9KqVnkJDOJ5s/FPDIBKN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080494; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gGQuUrgm8aOrcsU9AxKJFCPArCcmgGA1tKPNkKOiD8qpjrXQhhKabgHH7PttbpcEwXPsgOzPpi6ng3ANOFMc1dGmA0Tc23JQjUgGBitb9ux3TnChgoSAZ11ExE4czmWygdgPFWxV4NsSVJxhgKZ2E1sz+NaMUcH/Gu07QjB69a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Yq+lDV3f; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jWCRiu2k; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769080490; x=1800616490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=Yq+lDV3fBI5dKWQZ4hUyZoCMaMgNn5iyd4HjBS86FicZ4gEPA07sboS+
   nYMKe7/goW/darLiuWtbRfmYWMaApfp2Z5xzYhNm7RkiExDUnmgxREh2e
   qEVPb9DBM3mJr7AInbLsTjJvFAM7NIr8eIl/SMcS8L9vOoMzlBffbohNM
   SBOwMaKB7l88Bxui79Qkc8CqR1HMMEiHzoHIWoeKwNWWvLqdXz64ceJlq
   yogIRzaBh7a9FyGJYxvRFMP/IiZoAOt6EfMZRCpeTrCzet2UDo3sCz76C
   3pu46jeW3q0UmgXjPbyhr6kq0bRZUoPmyPsVzDV3T5xyHDm2Dvd7QnJMk
   g==;
X-CSE-ConnectionGUID: Z/bOZHx4TgOyo0IKQPSDTA==
X-CSE-MsgGUID: ITLlKGA+Q/C7rmtz3dYTnw==
X-IronPort-AV: E=Sophos;i="6.21,246,1763395200"; 
   d="scan'208";a="135873727"
Received: from mail-westus2azon11010069.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.69])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2026 19:14:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkp0d8WtgpS8CQ+oynO4AXyhJdKtuHYbDXYh+5Ufht5BHH4niw2psCTufzdXweH0fYMYQpLRd8z+lI3V5sg/oELG0N4+f2UFBMbOKWs2Uq85+GddplZmbbNtDYDq8BkpuAKwwTaHTLZFdXsqfhrVYen7ddL5zaXhaBPmfWAV3a1wYMzb+8aDVZnGxbaTq2cJiZtWXMsQsW7MwsLjSCxd/IhAmRi/pKCCBZcJ++pb1hEUtHDMFEQavd2C6pmmy37dKo+lZF6CPQmF9Bvvc2AE0/99BW8enDHUv/wl06QpJgczDFIECFYYHkdgUsllbuLR/RNcNyG+x6lfS92ifpDJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=MzviApdKzql6FIFdYOg+dZj5jH74eCYUJG4fKDjAvLakF86tM+z2Fh7vIRJAG3LrDTZryTUj8l7oiMr8W+HW8GN6NtJBmNp5+jHkrIKjmPZxSiTiIKhESZZchtf+prPHser59BLAcpJZEDjnS8A1TgDaKOkAfofs+vRnlogSUQf4v8fngDpia+HFmtwCl/M5Gc2HS54eKGqYF9kZfZdFJKtAVDrYQVmtQFv27i6ty10zvz8WneaJT9JAjQFrU5tzNJ8XyZVuam3V8R8YGIvi6h2tLl8ZA2110zOCbRYmIn8e8GSaXahty+h8tJUkZv2EwltYA6pj/DbLnUpJ6EJ5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=jWCRiu2kEu4MaUue+pAIzRkryLLLVoBz44v7bUyfxSTYJfzA0GhtfKChZde53BoI9dohWMuoRzxe1bPsPWL3ToFHngVSPhPweX77R7sHfW8LWiIonuGdeeBQcuhMA7RSC+r1ej3gw8b60QOehlbL/CWI5AlXW2e6NBwPzBHQAX0=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH2PR04MB6490.namprd04.prod.outlook.com (2603:10b6:610:69::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Thu, 22 Jan
 2026 11:14:48 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Thu, 22 Jan 2026
 11:14:47 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian Brauner
	<brauner@kernel.org>
CC: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	WenRuo Qu <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 04/14] block: remove bio_release_page
Thread-Topic: [PATCH 04/14] block: remove bio_release_page
Thread-Index: AQHciReGVCQNhTYEQ0aewl8mGlH8cbVeDnIA
Date: Thu, 22 Jan 2026 11:14:47 +0000
Message-ID: <27ddf78f-f9dd-4d0f-80cf-b9065088fe01@wdc.com>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-5-hch@lst.de>
In-Reply-To: <20260119074425.4005867-5-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH2PR04MB6490:EE_
x-ms-office365-filtering-correlation-id: c9467a80-859c-4d2e-bae4-08de59a77406
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGNjMFErSjBwYno3eTNUOHA0Ri9ac3lRais0enBEY29VVG9vOVdqeW85aVYw?=
 =?utf-8?B?V21NS0o3dDhldVZ0eWtkQklnZy9taW9yeG8zOE1uNGR4anhYTVlCL3JiNGZD?=
 =?utf-8?B?cmtnekdjcFJuaXhYeFprdEdBRTVTQlJUTFpOYThJdVcrSFNXV2lSb1VHT2tV?=
 =?utf-8?B?dkpZdHlKQmQ0ek9wMzI5THliM1JtZHY3V1N1TlJhSnpGQ00yajFnR2V5V1ZQ?=
 =?utf-8?B?VUdoQUs3ZTBZanpNL2RuMmJzWGVibGlGWVFqY0FpWjJtZWtueHRyUFczaUFW?=
 =?utf-8?B?NVhoYUVYRmhrR1hDT05jdjdzRmQzVWdreFY1N0d5WFN4cjV5SzlLR0N3MkRR?=
 =?utf-8?B?ai9wY3V5R0N1eUNQSmcrMnRLU3lqaEJCOUZMbUJNRFpXSk1JMnIyZUtZSjZE?=
 =?utf-8?B?enJoWmVCVDVvZWpLU29xam5oUVh0MjdMSmNPQ2trQ0crOERYR3dhaE9sMG1V?=
 =?utf-8?B?Z2FDRkcraS9SM0JsQlZ2cGtoblVuRnY4bUdYZWZoRlpoMUM1L055NkhOQzZL?=
 =?utf-8?B?eENrY1dWYlR1TFBwVTJCQVNSYk9GUUFJMkpBTkVodjdZYU5zc1VjY0crdTBN?=
 =?utf-8?B?bHBqVjkwcUUycjdGV3RMZ3dXcmJSMjI3d0Z5dll4UzVYWUl0V2xnd2Z5QTNQ?=
 =?utf-8?B?dVJUWkg4NGRkQWxEc2NSQ2dxMnp5MXRzTklwbzFvS1BVRm9Cbzl1SEMzRmlE?=
 =?utf-8?B?eG9uQ1Z5c01mRFpoYUlIWm1mWnloQ1dTVjVtVmt4NUxNTjY2d2dCT2xkZTVr?=
 =?utf-8?B?Y1dKVi9wR0xYSGRQMEZOZzh6SjRUWU1tb1p1NjcyZWdUTmIyZmprK2dSQlRG?=
 =?utf-8?B?Y1JVSWhTOFVDMjlsSm0wZ3hMcnJxLzdlVUxMQXp6QVBpTVhKKzJ6SWlWTmdX?=
 =?utf-8?B?L1hZYW9ydm1xSWV3RVF0bDlJR05DYkFKMEpramV3bUlFK3luUUh2c1pBSVNR?=
 =?utf-8?B?NmhQQkFLeXppRG9MZk9tN3UyNmExZ1d1dlI4T1Z4RFM1WFUrRzRXV3pCRjRV?=
 =?utf-8?B?c20ranZoTlFjTDJKM3l5Z0k5LzNsRjg3ZXhBODUvaW1DWnhmTk8zcUtvNkNi?=
 =?utf-8?B?VExyM1J6RGFidk5GNGIyVjZ1cGhvazZrWThLV2NFbGxqMkJrTFF2M0VoRlJC?=
 =?utf-8?B?anZVMzVuaTlhS0lMQkx1dXdiOUhETFVWeHZCMk5CdnY2YmRnYWpTb2JPWEpH?=
 =?utf-8?B?b1N3TjFudWRlZmZPOGt6QTFsbFAvRk1nVlNPbWx1S2JMdUlWdFd4MkRlSmNZ?=
 =?utf-8?B?dkVvMm5MWElhMElTb2dRVnF3L2szK0drZ0k3NDB6SVN2VDVldUZEdmdvb085?=
 =?utf-8?B?TzBCTGVtei9ybXFpMVI3WXBVRW5FdEhVaFdCdXRCUWIyN21TMFFOYnB0Yk8v?=
 =?utf-8?B?dHk0SWEwSnhucCtQQ3o3R3ZmOTd5d0F0cWptNlNpMW5VMklic1NVUFVUL3Bl?=
 =?utf-8?B?SzVzVnhvc0VvdndRUTRnK2ZUWGs4WHdLWFpSNThZdCtjTjNmSVpiR3lBRDF1?=
 =?utf-8?B?TjI1MHBURHdHT2N2L1I3bmZ0S2xYamEyUTJ4UGZTdGgrZnRhOFRyVyt2R3cw?=
 =?utf-8?B?Vk5Xb2pkb045OGpvOVB5R2gyVEdYOHVWZ0VvNWlaTTJVc0JwV2MwMXZVQUYy?=
 =?utf-8?B?WnMyYTZGV0dBeTNacmR3TnowVGpPUi9lenZvRXpvWS9TNFkzNU9QOVQvWW9w?=
 =?utf-8?B?dGVMNm0rQ2tyNW9QUkUxOXpjQUs5S1hXNmtYYlZGaWMrTExNZmNPWEJXU3Jm?=
 =?utf-8?B?ZGJpbWN1cGVFcUYyVFdhNi9vTlNhWE02eXpPQWQwRFNralN2T3hsYXNObnBo?=
 =?utf-8?B?amZyYXNmdHlPdXQzb3h1VGhicjQzS1N0RXRzTHhVbGs0Ri9pR1ZhSGh0TDJI?=
 =?utf-8?B?THF4VXJGc1U4a0ppb0dCTlB3a3cwdkF3ajhYYzZtZU50T3FDbkpvVGpaSHpq?=
 =?utf-8?B?cjJLUnZLZ2pJQlAyUDdJVUsrNlJqbGdmRHlsTjNlSXNOOGwvWG1VS2hVOTA3?=
 =?utf-8?B?d0ZDSi9PTTlsMSt0NXE0YlZ5MmppYVdoV3pFajdsU0gxVFRVMXFNWkJjUGI2?=
 =?utf-8?B?ZEVzeWZrQmhSVXJJcGxpL3gxQUp5a1BUQnF0cjNVemx3a1dtcmFJd0hvU0lj?=
 =?utf-8?B?K0hJRHAvM29zUEZBVVpuR1NTTURGd1lVZWdmaVlPVmNnMXNzaFBWbXdKcDNi?=
 =?utf-8?Q?u2oNSrwFbhcXA76YD21v2Qw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHVPOTNrNkwxNFlmM2lxcTRjVDdaMEM3bCtrb0t3QlRTWUVJZFVRWG1wNlJG?=
 =?utf-8?B?eUI4RGZ1VVZvekVxL2xZNTZzS1dOdG9KMFZwWXlSSnNqZmZlekc5SVFVZTgy?=
 =?utf-8?B?ZU9Wd0NTSDlGdkkwUkZTeERIakZGdmN1S1J5SzQ4NG81U3ljM1J6b05hVEc4?=
 =?utf-8?B?MFc1T2tyaXZ1b2hVTE0xb0xQNTlYTGZPUzlTVVlWaHNpUUFValcrZFM2N2RD?=
 =?utf-8?B?SUhvT2hZNlYxZnNwZmlPWEJKRDVpUmtsR2xmVnNTZHRlOWRpeitXQkFTOG1Y?=
 =?utf-8?B?Wi8wb04wUXVJUUFHc3o2OXNWL0VOSUtjclFHUjdKYUM4TXhBbkVsY0d5T2Q4?=
 =?utf-8?B?UkZabVdDazIzR2pLc2RiOTBBWFQvdzdnV3NmQ1JIU1NUaCtIQjZhTEZ2TnY2?=
 =?utf-8?B?K2VBSVBkL3doNUhYM1pDREIydEFlM1dFMTdrQi8zRldWRWtWOFM0VTRFMXQ1?=
 =?utf-8?B?Q2Y0VVhWYXJva1pNWTdScWplY3BuNXR5M1hhT3Z6dEUwTm1hL3FCa3RQampU?=
 =?utf-8?B?VW5hRjZLRjZIeUV2YVJSbWZrNHI2YlNWMVNEQjlrK3AwWWxRTlNvVTlnWlNV?=
 =?utf-8?B?aGRwaHNRNmJMalJQU1N2d3d5bFEzdzJiL0lNS1BXOFg1WFlIaWNYdUIzQkJ3?=
 =?utf-8?B?a09GT25jMUplV1RJUXF4WVdmelhZVTMxbnNiNTBYT2k2OElzWGYySGJVRFFI?=
 =?utf-8?B?VkJvL0xrellTZE53amNQZVk1dWZNNldacEQ4Vjg3elAydnRZR0RYMWtqRFd4?=
 =?utf-8?B?bzdrTExTNStZMjB6bmFJM1psd2o4aEhQS2hBL0ZQMHBsUFFTTHI3ME9zWlBy?=
 =?utf-8?B?QUk3Q2wwcDBmV3JFS1lSNjJqZkFmNXZiWSs5ZzhFV0R0QkJpZEhleDJSQnRI?=
 =?utf-8?B?a3FiWWtGMEdmNmUvemdtMXdvQ1FTY20rR1Q3YUR1MHEyY1kxTjUvdDZHYkNL?=
 =?utf-8?B?RVdZQlpYWmtzVitGMUVCQjRtdjRQVE1HNzNVSkFDVDBoWVRuall0cFF1NjF4?=
 =?utf-8?B?OW9pc01tZHBwRnpreVdFMUwrMTBNbXpwdDNnSEJGWVQvbnZzOS9WWUY2Nitz?=
 =?utf-8?B?OS9weUprS2VDNHh0T1BIb3lDL042YnRmTSt4QXcxSWhId1F1QmFOL3FWdEN4?=
 =?utf-8?B?ZG95WlZpeFRwUkdNd2NVdmtzdUZSakU2eWNMTjIrWjJnMUNYWi84SDRZakVK?=
 =?utf-8?B?c0NvazF6bURPa1BHSk5hZmZFYUYrOTBhREtNZlJ3dUNzM1M1Uy9PQmdaR2t4?=
 =?utf-8?B?Wnk2aEdZallhdWZ5NVNGL3pDQ3lBa3BGNG9NSWd1aklhMFFIdG9DdmxidVlO?=
 =?utf-8?B?allDSjA2bnpycWNJbHUxaU9ibFpIZ2xPdlhtVjJYV2NlcmptVHpqYXpiOUJv?=
 =?utf-8?B?eTh2blZuc0xFbkJyOUhpOHVvQVdob3pJWGIwd2FkazZyVFFjVUhEL1RPcGpp?=
 =?utf-8?B?Ykh1L2lMKzhvRklINWxOK21rUzNtSjNXb3BRUTcwMElKU1diRG9lWW56ZHFu?=
 =?utf-8?B?Y1owNmxlb05JWjY0SExPOHI3N2NTU282c2dZTzBSWDF3WHpQaW1DVmt2WkVC?=
 =?utf-8?B?V0dXQmwxZksvaEM5NitpWTRMVlZLWEJGR0pDSVFmQXZlQ09hRlRYNzlHNlNG?=
 =?utf-8?B?N3dwaFVJZmxiY1dYMnlYVDJvM1dNYk5Ha3pRK29LN1h2ZDJwNEovdW9tMHhx?=
 =?utf-8?B?MGFiYkNNdzFKaGNLY0tZa2txT2dPMXhuVm1tL0JrMWExejJ1OWNiemtYRmht?=
 =?utf-8?B?N3lLZ243Z3N1K21KdzBSaFoyc1UwRE1XdlpPZUZsb2FlSHpPUU9tekpIbWIw?=
 =?utf-8?B?Yi9RU3RwYUhRUUdxM0ZpbGNNRzdVeW9SdGRPdDA0T1NTM3pheFI5Zm5oaEVC?=
 =?utf-8?B?RWpyMExWdWJ1Mm85Tkw4Y2hMb2x4NzFNY2NVaUlTK2ZEU3gzdmtpakxubmRw?=
 =?utf-8?B?ejVyOVNiaTRKTWpTaTdDV0FJSjhNaXBkaXozQmZDSmMreFFsdVJBbkRZQ04z?=
 =?utf-8?B?Y2RCa3crVDIrMHE4OUl3Y3RoRG1WWmp2L2hXRjcwejFMMXBuUDJRdmlKVzEr?=
 =?utf-8?B?UCtEcnBPMjJlTWFzS0c0M0pDQXdFc3h5d2tCYmovVE1sVkFVbDUvaW00Zlpx?=
 =?utf-8?B?cjdDZSswY09lK0M0V3pWc1A3WTc4Sm1UUWNOTnFBUm96NnIwRmE2V2NPS00x?=
 =?utf-8?B?MnVUU1Z3dVc4L05qUmt3NURLSjNWMXVLTm9mNFJDbXNib2xWbEI5R3ZqRUdY?=
 =?utf-8?B?T092SXhhWjdHdXNVL2o1L0R4ajR5VVdidHhhOEROVVJHamttWE1SY1RlOG5O?=
 =?utf-8?B?U3h6WlRFZDVSTU80YjhuYWNpS1R2VVdUY1pHRzduTWQrT2wxTEZIU0JJYzlD?=
 =?utf-8?Q?hxertgHn8WPZdulK7Lf+KBB9BJYsSXF/GBhGop8V+WGri?=
x-ms-exchange-antispam-messagedata-1: FA+jZmyiIN9113KKdvNDxjaERlG8VrCHgSM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19A88B640E662E41B42FA6CF387BB57D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RLmXZ3Zpreog6AfuNpEgp6JfNwLaMjwIup/QlRdLDJOCb8jpMTbuPV0UJ/ivJ47osfMNkSrgAEUo8vfSEuvFS+zLiEA1VP/RQrnKLiCSksY4ni0AmOXImD9+azyzI0FPfFJoyicTmWKtU4Sn3xmxtiEQHDIjF2NF5FeqdPBNDkpjZTVDBXVRfbbqyCj+Q4AtoKNu5Yltk528r2s+3BBDjUvNNSRpyQgPv/mPlYQ1RAXV9Vc7Pvm5a2uIqbLwvCrmNt48mMvZJkmUJA00EZiUAl/JgmHQVAa55Wka7GZ99nWueAxF25L0t3ubm05Bc9j6tDmlrmIzBxtAGxK2ms15KvB3ABgjD2Pdosav/2lEmMTViZJTqOl0kCajkouTYXrT0aEwsn0s9k1JdTHAqbIyp59rx1cIY4fa5oyD7EktBI4zb/zKXiuu395Gzj31ZKJCaWRQdINXAw2DnNaEpkhMbRjntZw57emYEwWSpRbQ7wdK26rHCoHt1rXbVedrR2IhzfLhsqGfMhXrmQAmQXMtRh3Z5UNgjhvs+AGKsxX6qvCO8TOFenM5jPTsHzCBd0sUPtc3664+s/+PpaRXXmnCywmryKHghjpy0Ze0JA+rws9CG6ieNKfBCDbzGjhU4kvF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9467a80-859c-4d2e-bae4-08de59a77406
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 11:14:47.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPuEkuCnaOLYS9NMXzXoqNCSyf4/fDzfAQuT4lJsKGCeWiCQJheef+k8a/SQaw7wSzkOJVlsDO56YC9u+Nj5fV7BBZ//PKDNA7G/2wiCle0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6490
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
	TAGGED_FROM(0.00)[bounces-75023-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,wdc.com:dkim,wdc.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: D6F3065FFA
X-Rspamd-Action: no action

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

