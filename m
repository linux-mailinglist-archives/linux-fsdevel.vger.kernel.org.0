Return-Path: <linux-fsdevel+bounces-76765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEuoGjprimnnKAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:18:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D21BC1155D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A30C6300B44D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 23:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE7932ABC1;
	Mon,  9 Feb 2026 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A+Al/M3O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bhhbWiUf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF032AABF;
	Mon,  9 Feb 2026 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679069; cv=fail; b=USBoquclxchcYX0RAuC0H7CZ3naHMIdl3j1PoWTq7rLzD+61OctroLnl9av3zZXzLBXgAjfr9HtmPugmB8pWS8WALpL7SyCKSU0TiaIdSUl2dRaYaia03vExAvos6C0inJfXRL5uxn6AE1IS33NEpwoM+Hljzb/U97OcuJuVlJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679069; c=relaxed/simple;
	bh=YJ7j7qFcD5ZTexoCPZmnhM1CTTnhR0JM4Qw4+9xBBFg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j96tMKoAsLg3yoahPvO9BvGZhQFMVRrS6K4563Z7jwk3amclsPRZQMBSfEa4pNaw3tX1e3wBZzBN6FFkBY39u8jx7uEvA/chL6EjES1Sf1qH/pB/fxjblu4iTznIjCevteZkumw1E4hzJNGPX9ET39h0/cNk4ERbEI26wE8LI3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A+Al/M3O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bhhbWiUf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619MUnmx1557983;
	Mon, 9 Feb 2026 23:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AE+fA2scsEXpyPgulBkPSD8moAiRFans39LxwoPslSw=; b=
	A+Al/M3O/pUOHL3syyyNjFaIVORAfY/H+Sz6B3nvgqfDtq/63nNNQyYSaZmeoRgV
	0uVOlYP0A2mN5SxjVeGBHBiDYK50TXnilzGEdqkhbX7I0NRcPb+bXH3wTk8QOskf
	TwCBclUVkaiMgKTfOTpTrzTzu04x8sNIaN9F68/LnJ7ubEyn5yrVMeuH6jxFWSVL
	eR2MuGOGGC8vJ+i/9FGnFMt5ZPN7OKKPGOkjDeZeCYLh1ttioPHAj5rGoY6Z3sNM
	9OBFMWKEl+/Ez2HCUo6flL8YVh85NAZTg+6bOJxtN847SoLfRsIiIR2rWm22mw6f
	zmCNrbRvfCmpobEgTIjcQw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xhub0qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 23:17:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619KoKBx030953;
	Mon, 9 Feb 2026 23:17:07 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uum6awj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 23:17:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3IOglNYLkgWtv8f00r/naewJQ2Jms3d8GH7e4Jx/nFWwEjmGyg+I2LtNQuTtBanKxdG2qZ/9CKpgtrQcgapUcOAcktL6qq00BVvdEpR5d3gn+7xhcQncmraqH6TQ9RSZCYsUq1j5LUv7B3U096DuWHXfvDkO9KetAUIsKc1hlNJmiIJjh1hHU2XHcs2VhhOM1+d6hBRQkwz8DgXpaYKTnrVX4cRDaGEI/h7S5EHhYpSjdN+o8Qf3wWQzpXpYxS/zYMNsqFC8yP94sKV8N1MCqomiBa6zww4wbc5VgOvORG43IxXthK4d1iKn/Zn31Qlq4BaEXUXpen9c6KIWOJ1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AE+fA2scsEXpyPgulBkPSD8moAiRFans39LxwoPslSw=;
 b=U3diAxnhb2WinyAnBkpr8ih6eyP3lObaFbEZuwbB21E+y+CbsfMSH+0RtWCsqCuv+q00N+3cr+bXm0ZjO9oAMPz358XdvIS1eZl0hwBTbB0RTSbwd+Ma+9A/FYfEB3IT/QKG9Ze76s3QpPuX7+cGycYUazFpkRd6Q54Mz9cfnej4YD+KnsME1Fy4KbftBMlsgttd0r3Q7DIDEz8Jg0Du9aDBne5hoX5pKfcCXkjP0sjTphizZMavizChhxQHdD8u6NaL9M/Kbm84ulbuKGplzEIk+ntb5S/lyKMMfYW6ObmV9/CmPKKPGihP1MGWVK1ks6sjhur19lymuDM2ant1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AE+fA2scsEXpyPgulBkPSD8moAiRFans39LxwoPslSw=;
 b=bhhbWiUfK6BxLpOZzQ7PfImPdW34huVlrUWRxUgctnIZShLlGMIUB9YSF9DyOK7g4UZnCE5vWp1abIwncceyeqkwnkDTglnh5rt3mZN4u/Mjltno5a5F8dsa4wtjhp5X07xuM1a8zosFIlLR9+ABZK7ZMihV9aVrCGVB1tcFVt4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8111.namprd10.prod.outlook.com (2603:10b6:806:446::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Mon, 9 Feb
 2026 23:17:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 23:17:03 +0000
Message-ID: <44b1953f-728e-4ea1-99b4-a3e022564652@oracle.com>
Date: Mon, 9 Feb 2026 18:17:01 -0500
User-Agent: Mozilla Thunderbird
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 3/3] NFSD: Sign filehandles
To: Eric Biggers <ebiggers@kernel.org>
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
References: <cover.1770660136.git.bcodding@hammerspace.com>
 <c24f0ce95c5d2ec5b7855d6ab4e3f673b4f29321.1770660136.git.bcodding@hammerspace.com>
 <8574c412-31fb-4810-a675-edf72240ae29@oracle.com>
 <20260209210420.GA1062842@google.com>
Content-Language: en-US
In-Reply-To: <20260209210420.GA1062842@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:610:76::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA6PR10MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3dc1bf-fa75-42a8-1c5d-08de683155fe
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?b25STTR2bUdoeEs2Tm8rS3N6S2xUMHA0UkxCU0c4OU02WWJ0MW8wL2JPdG9T?=
 =?utf-8?B?QjdBd2ErRDNwU2hXMDltbnRSOEY5MEp6eWRLcURvdFcxSXdVTjJQZC9KUjlB?=
 =?utf-8?B?QmRvU1BqWXFzWkdJS25nczJleVZMRlpBQnVaK2hUaktOV3ROTWJpVk9xSWh5?=
 =?utf-8?B?V0wwZlhTMGZsRENaekkrcGsrbWhFNlFnU3ZDKzFWanFVcEtiL0FTWkhmNnUr?=
 =?utf-8?B?S29nVlNFV2V1QmErK0tqQWs5bkx1dEh1VnlsRENzM2I4SDk1a25TTm44V2Zv?=
 =?utf-8?B?RlBYcS91RnNJVWM3U25TSCtRTitpL210eVZNZWt2akd3blp5ejVycmQvMHRL?=
 =?utf-8?B?SjVqUWhOb3RvVkpTYmZ2Z2JFNGV0enZmMFNwajFZSGcyVzFlc1RLTERqdmQ4?=
 =?utf-8?B?U2lJUTZRZUcrdVp0b0JXaU9PQkhtV2FMejVUZVB6czhmN2ZocVlvT0M1VUdy?=
 =?utf-8?B?cERTZDNNN2NEUG9DR3JmNjg1WGJNdVo0WWRDblpmeWJmNi9OUDBNMnJQQjRI?=
 =?utf-8?B?VDF6SUNvQWlESUdHVkliMUpmK0s2M2tFa0tnMnY1aXBtaVhJQjlzdFBtZDYz?=
 =?utf-8?B?K0t2ZzJlVUhYT0pRNHloYld0ZmNxR2p3Zm5jR2ptem43L25hdnRDYmRWYVZE?=
 =?utf-8?B?ZUJnaWhZNlY1dkhmdjAyaXFWNi9KcFVzZjMyZlhaWmZtTWw5MU1qR2FaUVpj?=
 =?utf-8?B?bDF5elY5aXNzVS9HYjFMU3lDaHlHRnVMcnF3aXNkcnVyWWRPaThBTVBId1Ez?=
 =?utf-8?B?ZWpwWjNybURpelBKSGx5eGpKekQwZWorelRPaldzUWk4ZkkzMm9QNUpRTDJN?=
 =?utf-8?B?dnd0UzA2V1hndlBicDNMc2pSais2ZmU1QzJhOVhUc3NyTEprQmZDcXdOOFpR?=
 =?utf-8?B?a2Nzcy9qZmpqeFJrK0pZMGRkK3lMeXhWYlNTTmc5cFBOVVhZU3pJWFZvTGxn?=
 =?utf-8?B?TnVJcGgyeGNXOGZlTnlHcUR4aXUyVjNrU1graTI1VU1xRUpqMlJiMWx2VzhW?=
 =?utf-8?B?bWR5bTlXWnFvYVVuL0NMZDlIVUpBS3lPRlNMeDhESDdoK1NPbVhXak4ySWZN?=
 =?utf-8?B?WURHUTl6M21YRlAzUVJpeW8vU2tzS3RBMGpqTHZmb2hrMzRZbHQvNytIMWpm?=
 =?utf-8?B?aGFFSWtaenRlRkJvclUzUGJoc1hHU3ZNdUlaZEZWY0g5UHBmQmNyQ0NZS3ZB?=
 =?utf-8?B?T3YyWDRuY1hWQWk4ZGNpbytlN2R2bWw4RFdmTEtZRmxyRXBISStPbWxIZnRz?=
 =?utf-8?B?b1pSM0crRGpyQTJ4WHIyUWtJbkNmb3Z0VEcxYUsxdGJvZXV4ZCtPRG9JRXB1?=
 =?utf-8?B?dEREaGxIWkRiSWw5SEZ1ckJPcUhybk9ObWJpTDJTLzJNeERSRW5CUnhkbUpj?=
 =?utf-8?B?SDJ0d0R1S1h3Z0VkWDlLNzN1cG51MzAzQ2ZTWXdKNlllRGZRMk1MKzVpMkVu?=
 =?utf-8?B?R1JMSWtJT2paU0UyT0lWcDBaSTFXemZWaDhmNmNWZGEzdFk4VkhzSGt0alBy?=
 =?utf-8?B?QUlpWWFvdmUxOG9VRmc2MERIZDJveGZmSXVLSmtPYUtmWEpaQTRzZG1ZSGNx?=
 =?utf-8?B?bDRBVmxIRW12WCsvbXpEZnlxVmhZTDd1VlZXWmtzVTY1R3pjWGEzMUpVeHNU?=
 =?utf-8?B?bFlCei9oWlhTWVo3V0tPSGFiODhpNU95eGJxZXAwWVpzZS8xSzRSVjhYN3FP?=
 =?utf-8?B?M3R0VUErS0VlZkgzSUgzZStZVmsrVU9sd2R6WmZranQyOUsybE5WaUh4THAx?=
 =?utf-8?B?Mm01VjUvUTlmdXJ1ZUpWNVptTWZMckhUZjJhS0hScC8ybGc3dGt5U1RBbU1O?=
 =?utf-8?B?R1BOUmVheGk3M05lekhVRW1qelFLSlNwWXJISWVFdHIyUUwxcWdDcDN4MzV6?=
 =?utf-8?B?YTlWUE44UStHSHk5VXdpTnJiOWZSUWY5SlNYSEpmQmNGQWJJWWpwWGtSYzJH?=
 =?utf-8?B?TGtHbVB6ZDJMUUwzb3puWjZudDhCa2taUzRuL2tLNUJaeDlrL3BoWXVlQlU5?=
 =?utf-8?B?dWd1Y0czVzk4RHlpSnpGQzlET2FrM1hQWmV4ZVgyTlI2S1dBSnM4V3F0c1F4?=
 =?utf-8?Q?xMqRox?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eUtTelR5eVNFQWxTelZZMFprZHhlRlRXLzZGZlp6S25EMzBxelRUaXZUbnpZ?=
 =?utf-8?B?bUNUTjlTNXdtQlNjUlNOL2hqY3N6ZWpXaWRCQWpEc0R5NWFUZ09KTHk0NGdL?=
 =?utf-8?B?KzZDQmcvdGcyZU5zOThYc3YrU0k3OHdyRXNtcjl6MHd0Q1NYTVV2ci9PbkM0?=
 =?utf-8?B?clNLbVl2SUQxeVZ6ejhpaEVrME5xa0NDK2lXeFFUaW02WGFZdExyTzRZZldN?=
 =?utf-8?B?bmpZRHR1QVlpVzhOaWJiWnF1UmhlVmlzMDB1QkhNeHBXZUcwc2F1UmpjWkFW?=
 =?utf-8?B?dFpLdFNLY2Y1WWZOM2M4SUMwWVdpaHZPT05aRDZOaW1hVEE3azNTblFFUEww?=
 =?utf-8?B?YnVGWkM3dlcvaUdTWG81dHl2OTBSQ21HSFp3RkRVWDRQOHlhaXdQNDA3VWhp?=
 =?utf-8?B?eGFJMnB1NTQ2RkF6bHVIaGRPT2dsd2hJbjhiUTB5R29VZnBmVURPQTJZbWlB?=
 =?utf-8?B?c3VzT3RIUUtmcHpJUk1BeTBTSjNXVndONnpmRmtpUXgrUkFVUXJVZDd0ODBO?=
 =?utf-8?B?c2taTU1GZTduYUc2Z1luV05qYVU1M2pFMEY3RlBqaHNDOFRPMEtKNWZ2S1M4?=
 =?utf-8?B?d0NTc21sei9keGlMamhYUncrTzE3bE53RHpQenB4bEQ1amNtdGs5SHFlSnlT?=
 =?utf-8?B?dkxyUTJMNUJCYlpqOVNHTjdzN3NEdXY2UDVGK2Rqb1gvQ3JERkVQVkxXd2F0?=
 =?utf-8?B?QWRBUE5VMFBuZzI3dmVuR2xDKzFjamJ3NGxJRkJVRVoreGRScnV1dWdIZi80?=
 =?utf-8?B?R011bytiRytxT2E4MnZnRHBvUXpWdVZFVlZ2clZnZjhoZzFwOVpYT1R4cWZ2?=
 =?utf-8?B?ODVBK0p5Qzh0dlRhRCsxcWF2QjZ4aEk3b0Y2bXNqZk5lQjdPWVUrTTZxcVFr?=
 =?utf-8?B?cUhac293OXkvSUgyU0VEN2tzYkhwMGtJT1lmcWxyQ2Z3aVZNcHhhbFRYNi9q?=
 =?utf-8?B?M2lFa0FWZ3N5TXlVRW5KYzRCdkRFRlFPZk5GdC9ySUJFMUF0cTNkTW9RQ0h0?=
 =?utf-8?B?QzI5NzFLbSttdHR2VGlyY3ZHRGFSVVc5b253SFVvUFJnWFA4M0wrSjY1RGZ0?=
 =?utf-8?B?Tkh0cENZVWhQSldNM09DUTdnZUVyZUIxRk9HWTA4WGhrL0lSWEI5NXVpTmhE?=
 =?utf-8?B?Y1lIK3U2cnhRQms5WW5FYnp5SmJrQ3c0UkZDcWdFOXFROUFOM0w2dnlzaUNx?=
 =?utf-8?B?T1NVeFFZejVIb0N6ZkdhYlArNmNic1FPUFBLU29xelVTV0o0VmZCbXBWWHNO?=
 =?utf-8?B?S055M2ozNWc5UG1VZWFaQXRrQk85MEhRc2NERGFKQ1B5Um1yWmRLdzFXZjZr?=
 =?utf-8?B?ajV6MUpnLzFrbmZiOFZDZ3hVWnhhYk1lQ1FjeDlZaTBSV3JUZXNiUTBobkM1?=
 =?utf-8?B?dmxEeEFGaGhGRzRDdXpGZ2hUWE9YMzlvQ2hFMXVCY2hnVnBUSEYwTFpvNHlF?=
 =?utf-8?B?NWtDWmwraGFtSENOcFpDYXlyUUM2NFZhazgyamF6VGZZeDEzNmxvdUlvNm04?=
 =?utf-8?B?ZHE1ZGpqT1MrSFFhV2cvOTM1T1EvUklEdVFpeTdLS1NXbHBrY2U0SDZ1ZjhG?=
 =?utf-8?B?aGpLVWpVb01mN3Qyc3BUWnlPSGlVcHB4M2NVUEVXWUIxYjZPeXF5RVhaVkxU?=
 =?utf-8?B?S3AzdEI1UWhjZEVJUHdJWnJNT1FJNmM3YlM2bTBiSEJZMFhTVzA2MVlqZ3BS?=
 =?utf-8?B?SzNlZ0pmaERoQ2gydUN6dWV2bUF2MlYrcE1nZENSSjNqR0l2eWJ0aGVpeUU3?=
 =?utf-8?B?c3pGbmcvWjljQ1lVVTZ5QTNFOE9GWHpMV2hOUXc2RmVHQkYvbW1SMnZ1S3Ir?=
 =?utf-8?B?Mk1Najhlem5mK3BiVnlSRitmS3NEWDE2a0xjU3UvZ0VoT0xwR1ZXWUxQenFv?=
 =?utf-8?B?RHZUc2tDaVFUdlh3NGlDSFdUR2JLVWREa29mMTJMd0tvWE1CRGtydzlsWnpp?=
 =?utf-8?B?OWdQT05PMlFIS1d5Ry9nd1Z4VTJBZUNjaEwzdnhoQlJWeXVUZGNuU2dOMitW?=
 =?utf-8?B?RXdYRzhldDJoWGxsNE5FQWYyRU9McGFKVTlsbktNOU82emkxOHkySENTaVNx?=
 =?utf-8?B?RmxwREdtWW0vaElBNXRmczErL01HWnRRTUpSSmtFaXJmR2dWSHdTUUFqNytr?=
 =?utf-8?B?NWpJY1JhUzR5Mkk2Z0lFTUNGVFNFbVYzR05EVThzbVlpNU8xL1NVWmlXWHdR?=
 =?utf-8?B?eldJbDFwNE5lekxsUWM5dm9lNXpEcmxXYlVQaVZQbWZkYlR2Vi9hYUprcmJt?=
 =?utf-8?B?a1F5c2pITmdZdDhhNE9vSFdxbkoraFhjYk1ENnJKdUYwQi9nZ3BXSFdtWW9I?=
 =?utf-8?B?ZzlnNEdLOExqRGNwaGlFVXBqRjJHNlNPcG1ncnZtWUhHRFQ4aE0xQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GJr7zrS4+os14KvUESikUish1EqTDYKlSCnXjSPbwpIjUm4ydRpLdqh9YrgajZ/NWzM1NUgZgnjpzK4WZnSQqOm+4BtQoiLQGXs+hQYZk5doi7lxbNZ2sf6A2d0v1E1qHHGdQRNl7byz8PDVe3/BTKkQDT2jWFK7nYjkHgckPIQHTYIsHxBoKCs0oT2qpADSwS/MoUnWLd/k7KDawS6YPWRiaIt78M0nVdYl6VSPPnLzJRiQXy5WuZWovWAZMoJiFJzSGTMG9APXDCVp8u8z4ZGvm47r/W3mxFz7+P+kTNaQwuVJp8dSOpdBkbBFWSXGZLm3/qAlZjnMrwQ3PNu+XRWvl2a2Xk9NAyeJr+jkKm3tnFRbkfo4aiR18/RW0zCqhPrnXY+RtO1EmwK+LtMEzAl1K8U22UBZVNkBRq4wWPIDMjVZxT1KTscG585LZhwJlfXLcJWscXv7tMwkj+VZOAiIgUZF7CiJQZOwBaK2UNjL66HluI3um0g+uqvPKxzw/O2R6gTKgwFB6G5r/1WSZVGoVJZe1/1UG1l9xM0xXA4nY3AotRVvJHBBKTGPsmjYilrelABLco5GDnV3icICo3H9DVENZgxkrmA43x9HXUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3dc1bf-fa75-42a8-1c5d-08de683155fe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:17:03.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSMEXHpygfpCvMbefj1c5/G0kOr6uHPx+CC7h9W6nVzx6qBjYi3AN5QAisQFXCnWHfVMEvLv0ZN9Avawu79WiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090197
X-Proofpoint-GUID: uP0WNTSblcCP4lU4ijoCAKFFVvnJhV7C
X-Authority-Analysis: v=2.4 cv=FIsWBuos c=1 sm=1 tr=0 ts=698a6af5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=MVff1mliAAAA:8
 a=HIz5GZpxOaFRr7uDsOkA:9 a=QEXdDO2ut3YA:10 a=54LGQyWa7_ZnQzWOCYU5:22 cc=ntf
 awl=host:13697
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE5NyBTYWx0ZWRfX/uIk8i4ImPwr
 nJ3B5WssoVz+Ry0D9xxEJIaSqVydHncqIvYy2mvnTZjWpsSUpDm7U6q0YppqMCWcFpT/gMYhc3Z
 wAA/ZSXqfXBkMHA0jYSTbG0e0yx3akYD/NnTlAbwmmqMpip/1Q43skeg0VWjKsgE5FqIBQbr7L1
 5mq+NuYhSnnURNpp17e+l1akx66iL2sdooR+Mq/vCqLfJuCENXsPnEU+k3m1d6N0kLYgGRiFhxn
 Jz/pc0TnS6jua3qk9FM5vtHfhRuXGXzlsUoBxBW7xYV9ZKwz9WlskKOvMY7d65hfJNsUuZp+SXW
 tT4Np3YJh774eUTnXMnbj6yoaqH37fR9QrETssqNSNglt8Q5xBKnLeX4F53N7/lxlEVqh0QZmLI
 dHzKvAnL8eup4EAeIL6AFi8/2KPkN7xnqZIwGixvX7XcFYgzTRLEhY0hnPScA4yrdXKIMWsaxhc
 aiiX0Cl4a4MTjkOR8TH1uBTsu3c4ZtarXzBT/NoM=
X-Proofpoint-ORIG-GUID: uP0WNTSblcCP4lU4ijoCAKFFVvnJhV7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[hammerspace.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76765-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,yp.to:url,oracle.com:mid,oracle.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D21BC1155D7
X-Rspamd-Action: no action

On 2/9/26 4:04 PM, Eric Biggers wrote:
> On Mon, Feb 09, 2026 at 03:29:07PM -0500, Chuck Lever wrote:
>> On 2/9/26 1:09 PM, Benjamin Coddington wrote:
>>> NFS clients may bypass restrictive directory permissions by using
>>> open_by_handle() (or other available OS system call) to guess the
>>> filehandles for files below that directory.
>>>
>>> In order to harden knfsd servers against this attack, create a method to
>>> sign and verify filehandles using siphash as a MAC (Message Authentication
>>> Code).  Filehandles that have been signed cannot be tampered with, nor can
>>> clients reasonably guess correct filehandles and hashes that may exist in
>>> parts of the filesystem they cannot access due to directory permissions.
>>
>> It's been pointed out to me that siphash is a PRF designed for hash
>> tables, not a standard MAC. We suggested siphash as it may be sufficient
>> here for preventing 8-byte tag guessing, but the commit message and
>> documentation calls it a "MAC" which is a misnomer. Can the commit
>> message (or even the new .rst file) document why siphash is adequate for
>> this threat model?
>>
>> Perhaps Eric has some thoughts on this.
> 
> PRFs are also MACs, though.

In our case, the hash authenticates the file handle because only our NFS
server knows the hash key. Fair enough.


> So SipHash is also a MAC.  See the original
> paper: https://cr.yp.to/siphash/siphash-20120918.pdf
> 
> However, SipHash's tag size is only 64 bits, which limits its resistance
> to forgeries.  There will always be at least a 1 in 2^64 chance of a
> forgery.
> 
> In addition, the specific variant of SipHash implemented by the kernel's
> siphash library is SipHash-2-4.  That's the performance-optimized
> variant.  While no attack is known on that variant, and the SipHash
> paper claims that even this variant is a cryptographically strong PRF
> and thus also a MAC, SipHash-4-8 is the more conservative variant.
> 
> If you'd like to be more conservative with the cryptographic primitive
> and also bring the forgery chance down to 1 in 1^128, HMAC-SHA256 or
> BLAKE2s with 128-bit tags could be a good choice.

We're looking for good performance because file handle verification will
be done frequently, and also I imagine that we have a hash size budget
in certain cases. I am relying on others to do the math regarding how
much forgery protection is needed.

Since there is currently no mechanism for selecting a different hash for
signing file handles, perhaps we should also consider the expected
longevity of the protection offered by SipHash-2-4 versus file handle
lifetime.


> (In commit 2f3dd6ec901f29aef5fff3d7a63b1371d67c1760, I used HMAC-SHA256
> with 256-bit tags for SCTP cookies.  Probably overkill, but the struct
> already had 256 bits reserved for the tag.)
> 
> But again, SipHash (even SipHash-2-4) is indeed considered to be a MAC.
> So if the only concern is that it's "a PRF but not a MAC", that's not
> correct.

Then the rationale to be added might be nothing more than "According to
https://cr.yp.to/siphash/siphash-20120918.pdf SipHash can be used as a
MAC, and our use of SipHash-2-4 provides a low 1 in 2^64 chance of
forgery."


-- 
Chuck Lever

