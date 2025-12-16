Return-Path: <linux-fsdevel+bounces-71457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21578CC1AB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 09:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EADC3005F26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CEA3385A8;
	Tue, 16 Dec 2025 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Ke+jndx8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53406313E2D;
	Tue, 16 Dec 2025 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765875282; cv=fail; b=iPq15zImucFh4zL/Q2k8uFrslIzHTmgJZ4qdv0+ExKXDgp8YPKm7jM4gqAx/6SDnTQoSWUqqXoW7vVGhnj7gmOMrSOKRGtckJquw1RwdUdh/dn39r9N7cSFrofuERyGv8d4LgFixkKYVDgLWx5NhpbyAiF68JnWpxjn1rt6q6w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765875282; c=relaxed/simple;
	bh=HSh2WIp3skK8M7qV9OKWbskqYcwFHHcXELpuAClUdxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HEr1u1w8RZv/AYpaeqysKK1a3sS2Ni5lVUCPWQn17E71ZzZAQvokLDatKssg3Nj6CR+5eC67yenv6yrcmG9cS43Y/MwySanyGx+Ko9LiI3gs6y1ZdBJhv7Ngbhczi1blcDTlh5X36ooQBATnqRwnQNb1bDYE6VNonRkCBh3x7Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Ke+jndx8; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020109.outbound.protection.outlook.com [52.101.85.109]) by mx-outbound-ea9-35.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 16 Dec 2025 08:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOjM3x3WpgYu2+sgt9CoIKO9ggkR5jmn0Jfu1rUdu5cqERorr4A//gp8jFBNUh6BDCLkW1V2SeTogJfy2qONEnsIysKWBr78qXVTGnEwkUTR5E1a+2zYvIUpvGoRGyzZhe2iporw/lbfKUtZqd5FxCvtOQalEeNZFBohrF6KhzooTu1ToCvTgyguMuKINetU/h/Kn86gcjPTW5qSKVMczO9Ei7/JkqIJNxPuYOYm/AHUMTJfTyQo3lIvojK3RhzNE8eHL3+Ej0+94qYJsIqRYDxcJ5jUkOw4nv6qV6OJh7erA70vx8EUmtin6JyEX5jersLGXdNyEBrm8cistPFYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSh2WIp3skK8M7qV9OKWbskqYcwFHHcXELpuAClUdxg=;
 b=n+S7uQ6+C5i/FjX6Nnt6s061fZlfGlgaCZxjyM6iW+YEDV+cU6P85/d6oMhFQfMswXp6Xh7AiGASIY87v4PiijP6O707kd+SnsbL+/Wf0Eu/tzruYABdOy7n0UzoiClHWIgN089zsrCnJfr45dt3ixscZMDrKJFjy02Sjc7yLU4osoc/Nb6G854qqiGzz9RiAdeoswJDsqHAcn9Pd3bXoNe1hJ8H2xcGOVmcPyNMYJbSYcAbtH4cifVxa9TkkEA7plR5Uuxr3NfXHVHQuMrsg7vBOAbCS0C8hTCifsB3sBND2QNlcqfn1lc/1BOp7CRVeWXyURKgugl5vUbW1/Gx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSh2WIp3skK8M7qV9OKWbskqYcwFHHcXELpuAClUdxg=;
 b=Ke+jndx8zjdwbLz8Zn9V/EuD/ofeH+tjGLIfO73MnXnHefFTNzn8rGtK9AwAtFN3ATKFjAXbF3Y6tSBb4QrKG6DxurWwEgGwNUEx9b2oETwcnyjtWD5SHC6En1s0VYBk53GLP2LcRE0tKufEfijHPxNr1OknNTaLFl2cbtRxG5U=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DS7PR19MB4632.namprd19.prod.outlook.com (2603:10b6:5:2cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 08:54:27 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 08:54:27 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, Horst
 Birthelmer <hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE
 operation
Thread-Topic: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
Thread-Index: AQHca5L6H9Qcz3ILT0uNUnhRpRthBrUj+qqAgAABWQA=
Date: Tue, 16 Dec 2025 08:54:26 +0000
Message-ID: <0427cbb9-f3f2-40e6-a03a-204c1798921d@ddn.com>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-5-luis@igalia.com>
 <CAJnrk1aN4icSpL4XhVKAzySyVY+90xPG4cGfg7khQh-wXV+VaA@mail.gmail.com>
In-Reply-To:
 <CAJnrk1aN4icSpL4XhVKAzySyVY+90xPG4cGfg7khQh-wXV+VaA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|DS7PR19MB4632:EE_
x-ms-office365-filtering-correlation-id: 8493cf89-5355-4973-1c91-08de3c80b7ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Wi9CdG9zcHJCdnlvbS9QMmpUUHRMOTdpRmhvWjU1SDcvWFlKVldtSjBvVGY4?=
 =?utf-8?B?ejJGTStwRFFsUW9BSkNyUzBDem1oOVJkOUFIdkF2UVMxYUVSempWbHpMUGIw?=
 =?utf-8?B?aGNYNDZub0FWd1dUWTl1dGx3NDVKc2JobENEdVZjTXVjYXNYb0Q5ZkxqeHln?=
 =?utf-8?B?YmxKeGxXWnJKQTVMUGE5SUtrLzJPNDZZRFpoR084SjJmRTc4SUp1SGxTWkND?=
 =?utf-8?B?Y1I3aUt6bklhek1OYzhnUHlhM3E4SXFSTXMrMkFPWnh5bTFRN3dSUjBYQXl5?=
 =?utf-8?B?QjhScWYybk13V0hHc0NsSmxzYlVNd0Vyb0JxK09qcHVGMnBVMUhUeitTUW0z?=
 =?utf-8?B?eDhZMXFOR2tzVlQvZUxIUWxGd3BNYzVTc3ovUkxPRFlwVVVrTVpmZnVTUjR6?=
 =?utf-8?B?SFJBUnlZNVRva0RkeFhrcGwxc0QySjFRVXI1UStoQ0lvQ1IzUS9kcllWWEt0?=
 =?utf-8?B?L05SWnFjRnhVU05aVUlhMWd1UjR5MjA2SGlWWnhURHZhMk02MFBOUUh4WE5i?=
 =?utf-8?B?aVN4bklKUHFrWCtEOHpZNXpUcTJDSStlMk1YYy9qTjIvem43NDFmaXUzZVN1?=
 =?utf-8?B?TTZGRDZSdWpQd2YwN0VxenpXVFBaQ3JCUVkrRGMvRDc1dVd3WDIxNUJrb0ll?=
 =?utf-8?B?Ni84amJTSU85d2ZRNGVCL1g4WS9hVldGbjZuZjFQVnJ5eHBLb1NXUk1TWEwr?=
 =?utf-8?B?KytkeVFZN0xvWnIza0NrTGxJcm10MGNhQkk4dVdGYUpSOE02KytJWWlGVjM2?=
 =?utf-8?B?OTBNakIzVktDUlZRS3kyZzhySVNFT1VDeGM2MzFXUE5qMVpSbTZES3BOK0xI?=
 =?utf-8?B?MnFaRXAwcTdsRXgwN3JtRDJheWpvb1d0U2wrek1YSFpyK2JKdVpXTGVEWVp6?=
 =?utf-8?B?QWhNcCs0OUZpOWQ3TzFWVUlFSGsvSlJ3NHY0SUJYMS9KaWhoK2ZGWkovK0RS?=
 =?utf-8?B?RllETTArSjVKZ3c0K3VKd093Y3hhaW5yTW9tSjdsam1DNitFSXM4eFJUR3JT?=
 =?utf-8?B?STBMMm04OHpkSHVjb1dRREFnVVJBTUxZZWlCY0xFWG41eVR1TkhPYVU2clh3?=
 =?utf-8?B?RzZNUHIyN2JyYW95bXRzdnNORHl3L1htN2dBUVRCd3h1cC9CdzRTRFUrS0Q4?=
 =?utf-8?B?Z0pLNm5JY1k1UzA4bVQzSGhJcUhsaUFDOGRrZWF5VE5aT1Q5NldxYjlJWjdT?=
 =?utf-8?B?T0dKNndnMVoweFJiTUR3RkxPUDJPdzQxNmh2a2F5WnBZcEx0cGtaM1VpTTZi?=
 =?utf-8?B?TmZCeUlDQS9GUzZINTNkeStjNzJNUG4vRUxjZUNOZmxUSjNWd3I2SERWNDBY?=
 =?utf-8?B?Rjhlb296YldsZnBOdS9YeHlldmtJaWFqVVNwbVZUWTJBcGZmdGZYNmpybWk2?=
 =?utf-8?B?NkR3b2hCNEgwVVVWSE5MQXk2c2liSG5VNmxBN01ybjBkOGZQS3RMci8xWVdi?=
 =?utf-8?B?elkyd3lHbFRpRWYxQWdOcThKWG51aG8rd3lxc0laNlZrelNKRE5Cdk5Nc1Y5?=
 =?utf-8?B?dnVMdGNxOU1TZXJ4MjFkYlNWbVlyeEx4TUNkU3ZwUkM2WFV4N3hJVlhzY0dB?=
 =?utf-8?B?eGhPVERlNDIrdWZZc29jUTJoOU40YVRMcUs3VXZwMEI1RDRTZk5hajdLMXBC?=
 =?utf-8?B?Mmo1eE9QdWdlVlFlNEh5c3RKQm0zYWJ0OCtQQ1Z2Wk9GWXM5ZkNWall5dXoy?=
 =?utf-8?B?SlExVHFndDhPd09CRnFPVXZXQjhtZTlsdDYvVm5wS2RoZ2tQMmdpWGtPRFBC?=
 =?utf-8?B?bHVzV3Yvb1RUVkphUjZIamhmN0lKeXYrQ3pLL3R4Tk9yWkZLTXhlRTRUV0Jm?=
 =?utf-8?B?dHhmendjU3RDd05lejlFREdzeE5mV1p0OXNJNDJIYTgrNjRxUDE3UDN4WHJy?=
 =?utf-8?B?REorY2VVSXFWZVl2bWY1dlRIbHB4R2VGVVZlcXNiUnRubC9vTG9qR01FR2dQ?=
 =?utf-8?B?eGJKTG5RWEFpMlJ5S2RTVHBuSVJnOFNtd3BDVWNUWGtqQzRQdXJCbVlwcHlM?=
 =?utf-8?B?UXpva214OFlmdTI5QUEwOGdDRmJLcWExZTlyTkN3dExKK25PYnBqejRyTnZj?=
 =?utf-8?Q?/fBJmC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1lLNGRiS2VWdjZQbnpxRVd3YksyZDlTa1l4YnIyY1dvd0dtT0V5YkdNeHln?=
 =?utf-8?B?T3JWbUlUQUx2aUc1MzVtc0RDNFJFQmVRVGx0VjduT0trVWMzMGRHS3ZUR0J1?=
 =?utf-8?B?RG9yVlpQY29GeldOeEdZZkZrdDFyczBGekNkWng1UWJSbXJmc0l2QXhpU0Jz?=
 =?utf-8?B?STZEcGt1cnFxK3cwODlyaWNFTlEySUJMMWpZWTMrWU9oRXFXR0JLUk9nd2RW?=
 =?utf-8?B?cmpPTWp4N2I2OFBXa2UrRWhWUGhVWTRXRTR1UGtKTzUvUWxpODdwVVAvaXJ0?=
 =?utf-8?B?MzJRVzJvTmlkVlNDa3p1YVNBekV1ZjJRYlFJWXU2Ly9vZGRvOUpCSHloejdE?=
 =?utf-8?B?eEFSbWZRR0VWMnR2S3h3Y3dsUDY5SUtDZGNWUW11SGtoSzNDNDhGeFFHOW9W?=
 =?utf-8?B?dkxGNEpDNUpBY2lBalBjKzZmOGF1MUprbzJyV0hRUmtXVG1RbU5NVmJBTTFx?=
 =?utf-8?B?RkdGMGJIU3RVNEpjWEprYUx3RUhsMktZNGxjUHFLb2JHN0RhYndYWWVVNWxX?=
 =?utf-8?B?cEZXR05yQkg1MUtOZTZscVI3c05WSmxCWVlHOHE3NitHVHlML1pSSGR3c3dH?=
 =?utf-8?B?T3pNN3k2OUgrR2kyUkZpVS9lUWJTQ0VmM0pnSWRaRnRvdy9sQnNuOHJiSDJx?=
 =?utf-8?B?OUM1YitpTHdtS2gwZXl2dDBXRWRKenVOLzk1cExEQVczTFdXRHlVVVVBWUo5?=
 =?utf-8?B?MExlKzJ2YmF1NlZieDJhZGgxMkxENjRIbm0yalErMlNyY0JnMmx0blJiOGxE?=
 =?utf-8?B?MndMYlVOYzlNY095ODdpL2JnNU5zNUwxM2pPdEtNUGJsS0sraVlvL2ROc28y?=
 =?utf-8?B?VFJXNndNQ0V2RyszaENkUXJBZGRUeEhBekttU0ZLTkZCRitpRnhWcnc5ZENh?=
 =?utf-8?B?R3VNZTJzS09VNzB2c0pmRWpJZXRnM2F3RkpSUUZvQWo0MHAyQzczbDV6VVZv?=
 =?utf-8?B?OG91MExjNWl5V3NQQ3UrbjlQSGpHbkdFYVR3UkFJYU1TRHdZVzcyQjJzR2Fz?=
 =?utf-8?B?VFN2dDZkNkdnc3dKaGRqc1BxM01udWg2SGQvYmFGK294aVBiY0JzRUFZd3Va?=
 =?utf-8?B?WGdrckkwSFVCODBRUGk3Y1hzdEROMk52SC94ZjRqNy9TOE1lTWFFVDZRMGhh?=
 =?utf-8?B?a2pYd3NuMGNSdjRkc3F2VzNDVnEwalB1VUZnREY5NmU2U3h6NmhZQXJVSElF?=
 =?utf-8?B?TStiN25YZlB3TjZSRHFFN0VWRDYxS01JeERNYWh3NkdvY0p2bFNSci9JMmc0?=
 =?utf-8?B?STRYSnVyalgwMG9YQTJHWmtwTWlUUWR0YWs5N242Q1ozdkpSbDFnT0xoQ28r?=
 =?utf-8?B?WVZFd1dHSE40aitMU0p2ZjJTdWk2RzBXdFp2Wi8yYVd5M0MwbmNVMHpneUhw?=
 =?utf-8?B?WlpSZXQwSkVKb2ZJNDAySGU0c0Y3b2xXT2NZUUdNQ3NxTW15WlNNLzZJQzhU?=
 =?utf-8?B?U214eGQ0TjhYYy94K09WaXc1Y3E5OC85dnBFWjFlRzRRVGVnaTJFR3o4YlFi?=
 =?utf-8?B?bGIvWjIwbGFUdU9meHBaclVUbjR4TUFURmppaS9Lb1ZaYng2bk5MRmZWYkJ5?=
 =?utf-8?B?dW9Udmx3OWsxY0pQaUkzU2dEYXQvWm83d1g3WXcxaVRQWHRsRWM4MjhmUWlO?=
 =?utf-8?B?OUtQNmlMekQrWFZHSGhNUXM4R3FOd2hhd1NSOTRYVkdEL1MyVUtFdWxYb21O?=
 =?utf-8?B?VkVFMXEyYkV4UTlDbk5iSVlRQmhUL0RCWWhzNVlVU2Q1VW96WW55L2tlSlJi?=
 =?utf-8?B?ZkdWNDVubFdRcU5JRW02cGJCM09BcCtybEEvTGJtNFdySGpidWFUUVBYbnhU?=
 =?utf-8?B?ZStJWWowclppN24zNWZKRU5Rc2tEY0h4MTlSaGhhT3R5dDU3aVJWbGJ0c05N?=
 =?utf-8?B?a04yZFloZE44eUZ5cXNUWnRYaW9Ca1VBS1l1ZHNiUnYrbnQzeUtDUUtyOWZn?=
 =?utf-8?B?VkdKcWtjMThVQkRBaHVZalIyN1lycGxoUDk0VjgxVW1MMUppUitKSG85ZkZZ?=
 =?utf-8?B?YlBEaFBwU3RVQ3ZDZUtVQmJNRktEUi9VWHVrdUJTWjRXcHBlSjJMU2R5T1Y5?=
 =?utf-8?B?RXRqTU9BdWk1Um5oR2MvRnpDK0h2MGJlTG1KVEtjT2VpanUvMXBjUkFJZmhK?=
 =?utf-8?B?NjVkNmx5Y0FlYU9taEFFU1AvNyszRDR2dXFuWmljY0MxNzRLNWpwbDZmNWE5?=
 =?utf-8?Q?6KpDLTRmtNTuaVEpsoTKjxQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <107D6A15236AD244BADE91CE1B5A6CB2@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ekz2z3cl9tb+habc+3SyDQh7pBe49wKakiJwmnwOwJRnjSpGlGYA378TsgJ57RmUEtLWrXSmBSrm7RMSGMPGMPzArJUs1/9dMdE8R2yCl1Lw3x3rmNTqsjMNaD+Bv2SLcQwnAgNCVjmCb13Sz8kbrzukX0O+QCiiXeDAiEbEhsrK1O0cL+hGAiyfbjSPkoAYpJ7rriJwdKMdLMkFjoFH2s+jQYsbKSSRAXwyMrjrKlxcAecsFpMOBkEp46KhqnZKI7IB+Vp/5eXxCaydBYUJWQ/E47MFcMQn9AwGspp5ZnGjy2dRZ5r0nKQrbvMX5SiTs+ysF5XQlfqlQxEo/kxsZKvJ4lYzF6OMEQSfvAC7aTC7pMrFt3cjMHN5kwWB9FeKk1GIBK8gY5X3uLjf1qfxaq27/Kf7C2KRemg7GZqTOr2t/qiMAQZ4F3dzNUUyC3OkDgaNmjK5zjrN+CttiDqJ48pFS1d3yewV1rTTNz6tjSZEwdMCAjCVw2MPRGcXzst2emtSXu638r01JtNgi6QePKjZTAIomYskEJWToUG3HZ7jkb/nMI9juPRIgph1t8yTrRYw+47VE/bAuX8wt8v7LUJZfZqIqQ3Jq+i4/T5Pspnj7ZTXCWFbTSzM3JcM1swFaoZggY3AS0PHeWdEFIQs/g==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8493cf89-5355-4973-1c91-08de3c80b7ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 08:54:26.9798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jIXueFO+YAKuTn2ResdCIxc0K+8Q8IZUjzx9CY0/0tUbtJ35uwWVhGB6IRLcU7nB3sfgz0tEpFd9hV+830W/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4632
X-BESS-ID: 1765875269-102339-8318-25230-1
X-BESS-VER: 2019.3_20251215.2143
X-BESS-Apparent-Source-IP: 52.101.85.109
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmRqZAVgZQMNXYLNEyMSU1NS
	0ZSJskmScZGqdYpBgaGCQlJ5taJCnVxgIA2TJ3K0EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.269701 [from 
	cloudscan17-207.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTIvMTYvMjUgMDk6NDksIEpvYW5uZSBLb29uZyB3cm90ZToNCj4gT24gU2F0LCBEZWMgMTMs
IDIwMjUgYXQgMjoxNOKAr0FNIEx1aXMgSGVucmlxdWVzIDxsdWlzQGlnYWxpYS5jb20+IHdyb3Rl
Og0KPj4NCj4+IFRoZSBpbXBsZW1lbnRhdGlvbiBvZiBMT09LVVBfSEFORExFIG1vZGlmaWVzIHRo
ZSBMT09LVVAgb3BlcmF0aW9uIHRvIGluY2x1ZGUNCj4+IGFuIGV4dHJhIGluYXJnOiB0aGUgZmls
ZSBoYW5kbGUgZm9yIHRoZSBwYXJlbnQgZGlyZWN0b3J5IChpZiBpdCBpcw0KPj4gYXZhaWxhYmxl
KS4gIEFsc28sIGJlY2F1c2UgZnVzZV9lbnRyeV9vdXQgbm93IGhhcyBhIGV4dHJhIHZhcmlhYmxl
IHNpemUNCj4+IHN0cnVjdCAodGhlIGFjdHVhbCBoYW5kbGUpLCBpdCBhbHNvIHNldHMgdGhlIG91
dF9hcmd2YXIgZmxhZyB0byB0cnVlLg0KPj4NCj4+IE1vc3Qgb2YgdGhlIG90aGVyIG1vZGlmaWNh
dGlvbnMgaW4gdGhpcyBwYXRjaCBhcmUgYSBmYWxsb3V0IGZyb20gdGhlc2UNCj4+IGNoYW5nZXM6
IGJlY2F1c2UgZnVzZV9lbnRyeV9vdXQgaGFzIGJlZW4gbW9kaWZpZWQgdG8gaW5jbHVkZSBhIHZh
cmlhYmxlIHNpemUNCj4+IHN0cnVjdCwgZXZlcnkgb3BlcmF0aW9uIHRoYXQgcmVjZWl2ZXMgc3Vj
aCBhIHBhcmFtZXRlciBoYXZlIHRvIHRha2UgdGhpcw0KPj4gaW50byBhY2NvdW50Og0KPj4NCj4+
ICAgQ1JFQVRFLCBMSU5LLCBMT09LVVAsIE1LRElSLCBNS05PRCwgUkVBRERJUlBMVVMsIFNZTUxJ
TkssIFRNUEZJTEUNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMdWlzIEhlbnJpcXVlcyA8bHVpc0Bp
Z2FsaWEuY29tPg0KPj4gLS0tDQo+PiAgZnMvZnVzZS9kZXYuYyAgICAgICAgICAgICB8IDE2ICsr
KysrKysNCj4+ICBmcy9mdXNlL2Rpci5jICAgICAgICAgICAgIHwgODcgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+PiAgZnMvZnVzZS9mdXNlX2kuaCAgICAgICAgICB8
IDM0ICsrKysrKysrKysrKystLQ0KPj4gIGZzL2Z1c2UvaW5vZGUuYyAgICAgICAgICAgfCA2OSAr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+PiAgZnMvZnVzZS9yZWFkZGlyLmMgICAg
ICAgICB8IDEwICsrLS0tDQo+PiAgaW5jbHVkZS91YXBpL2xpbnV4L2Z1c2UuaCB8ICA4ICsrKysN
Cj4+ICA2IGZpbGVzIGNoYW5nZWQsIDE4OSBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkN
Cj4+DQo+IA0KPiBDb3VsZCB5b3UgZXhwbGFpbiB3aHkgdGhlIGZpbGUgaGFuZGxlIHNpemUgbmVl
ZHMgdG8gYmUgZHluYW1pY2FsbHkgc2V0DQo+IGJ5IHRoZSBzZXJ2ZXIgaW5zdGVhZCBvZiBqdXN0
IGZyb20gdGhlIGtlcm5lbC1zaWRlIHN0aXB1bGF0aW5nIHRoYXQNCj4gdGhlIGZpbGUgaGFuZGxl
IHNpemUgaXMgRlVTRV9IQU5ETEVfU1ogKGVnIDEyOCBieXRlcyk/IEl0IHNlZW1zIHRvIG1lDQo+
IGxpa2UgdGhhdCB3b3VsZCBzaW1wbGlmeSBhIGxvdCBvZiB0aGUgY29kZSBsb2dpYyBoZXJlLg0K
DQpJdCB3b3VsZCBiZSBxdWl0ZSBhIHdhc3RlIGlmIG9uZSBvbmx5IG5lZWRzIHNvbWV0aGluZyBs
aWtlIDEyIG9yIDE2DQpieXRlcywgd291bGRuJ3QgaXQ/IDEyOCBpcyB0aGUgdXBwZXIgbGltaXQs
IGJ1dCBtb3N0IGZpbGUgc3lzdGVtcyB3b24ndA0KbmVlZCB0aGF0IG11Y2guDQoNCg0KVGhhbmtz
LA0KQmVybmQNCg==

