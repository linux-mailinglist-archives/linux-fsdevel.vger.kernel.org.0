Return-Path: <linux-fsdevel+bounces-73408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AC0D18035
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 11:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BD8B30049E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA1238B9BD;
	Tue, 13 Jan 2026 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="IbVYOKzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0886A38B7A2;
	Tue, 13 Jan 2026 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300081; cv=fail; b=D1vE0RvOVuloDtDhhDzKflEpPxJdpDORd6VP5u8s3zP8vrU1TGAuVNoPTmAUEoowmo7I7hed6iZNBG7xAFegKJ0qp1dpK5KxBiWzwxtDbQB6Qc/pLc0XZtCvKSiBBirY0CCBYpELGQoyiJJvOWKSUC3tOWQTpfo00gWLA3VXemY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300081; c=relaxed/simple;
	bh=bFGKgMef/D2+inZUYz9+gmIo/2PvUZZTeUriXo8EL3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KtUvJUZ8VqqEu+N7sBza2D1ufmj87EYq13VE07fde2n3mJWSS/s85ItsLExgGpplqFISec0JSmntu2jvwVqS3HYsSDizp/V0+HG0jOpQXAfgISRBnYn0aqefCqY+l9BUn4t6y+21I0pzQvkTBinqLsRXJQPDmEFP0ugvxWfcNNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=IbVYOKzO; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60D50WxE022049;
	Tue, 13 Jan 2026 10:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=bFGKgMe
	f/D2+inZUYz9+gmIo/2PvUZZTeUriXo8EL3M=; b=IbVYOKzOBs0Xu0+0ZXSoKw3
	iOvaiv4hJWi+Z0YMNfNmVRYTCCJVShTmj7GykjK6ZJJawCw4J9hQrt82a9H3km3x
	wb43TsqWw19/tWbypoUYzkMIJwIFhnBjOt2YNkXacd8GUzVkdTIl8/XjHhRwFHP3
	mSWyfqS+4cuaGZnU6RLjqjlqdK/rZLAebOSgXXtCfpM7kgFTXtQvncVTBUXgdbaS
	7DKUSXYUgxQ9F3Sk8DemgOMub3YWgQFNMqd++NCwLo8geW1QenJUbpcwdhr/I+mO
	9mfWRbZfjq4OWp+X9yz/wDAUp1nwcBNv+oneP3W3Qy79eXZKAeIE1pvzV3ePN9Q=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012044.outbound.protection.outlook.com [52.101.126.44])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4bkupc2t2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 10:27:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6p0dgUau7/Eq/8JQ5Tbygz6jroLp0/u8a719H0NSGdhxOAJNd55lqa+QXWyW7BkIGMvbSOvSSUVEdaC5LO/whuzGzMFwAZ2FWMb0RV4pLUnvbNnmfW8t1zGeeZbCRUlj9O7yU0Jtioi3WG5dCbCHfT8oTGcaHuAD50drtxr3v1t23shvasmlVbaoR5z+oomvhgwEU/bKEZC4grPKH8OkD8+4CnXHo/dzOU8+QGtJLFGYT+6ae/N2UGZCNuwyeGKEfF7oygHESgIgh13HdOj3/aZYAnns3mFhD9id4Az8f2J20UQLVU4PoIw8n9CeB2sizEUXAEZr4hXYc/fO4SrQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFGKgMef/D2+inZUYz9+gmIo/2PvUZZTeUriXo8EL3M=;
 b=RFnqmARB9ETQ0dnajvpK9KXTJ5o86xlBnrlq3QqTdOtlAgkmvY/hyN4SaMKIZfLMOmvhVSzqyGe61OfuWgPveG+unpgUjiYixmsk04QZPRItzJ2BvlzTm9+dmc1Aij1RHSnHQL5The7SMZ/Gl7BlD7NugeqJ3anTj5KV/bqY34QqS7VYyJ5bpvNihLDEOw238qJwOy9fy46CtPnlcL4c8E61sF56Wno3sCuRbfif7R4Gjk66Ay1P7Vz4XhNGqktmkFKwdEBYOoLKm++bdjiiyE33tqUv0ug5oNuQH15J3hb44F/axXks1xalM5C+sa8d15alfghswkrron6YFRf8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by OS8PR04MB8278.apcprd04.prod.outlook.com (2603:1096:604:2b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 10:26:59 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 10:26:59 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Chi Zhiling <chizhiling@163.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo
	<sj1557.seo@samsung.com>,
        Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v2 10/13] exfat: support multi-cluster for
 exfat_map_cluster
Thread-Topic: [PATCH v2 10/13] exfat: support multi-cluster for
 exfat_map_cluster
Thread-Index: AQHcgHN7X7Pv68Je5U6kxvoRzuBpFbVPqmVUgAAo1QCAAAhbmQ==
Date: Tue, 13 Jan 2026 10:26:58 +0000
Message-ID:
 <PUZPR04MB6316586A2FCEA0BAECA86CB3818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20260108074929.356683-1-chizhiling@163.com>
 <20260108074929.356683-11-chizhiling@163.com>
 <PUZPR04MB631615D6191EF6FB711E63C3818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <f7cc8f8a-81f0-4a31-9d75-983858daf985@163.com>
In-Reply-To: <f7cc8f8a-81f0-4a31-9d75-983858daf985@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|OS8PR04MB8278:EE_
x-ms-office365-filtering-correlation-id: 2f332d7b-743a-4e59-d8bf-08de528e483b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDdjZ0FMam1SMnU1WEJkcUh1RFRiczBjWkRJOVVlR2xPblM5RjV3MnhkbVFr?=
 =?utf-8?B?clY5c3lTK0Z5bFozS3ZCVkcvSHdySC90U2h0TUFLakppczlOREZidlFXOFl3?=
 =?utf-8?B?WVBSM3VsSmZoeGVyNU9SVGxlbjFsWGFtdzFyejlLbXUzSlFvbklXTy9nQVJH?=
 =?utf-8?B?OGE3aHR6VjliTVk3eFdndi8yV1ovM2s0UEdRcXNCRzVQSUkwOU5zbTViTjNV?=
 =?utf-8?B?S3JGUzJkWEltTUc0RWtJbDZrdVRWT1FvVDdtQlN4a0lYNjBTSVpIMVBMTVNK?=
 =?utf-8?B?OUZPMFVSb3dGQkM5YkFOV1JjNldzT1daS2RRNkcyVmJ5V1ROODZybU5QWnhr?=
 =?utf-8?B?Qnh5VW5NZ0E4c1BDYldaVDE2RVVRaU1JcE94QUVmK2ppQXlJU01GeXd4SDV6?=
 =?utf-8?B?K0N3dXZMVkN2K2RzVk9yVktyR3h0K0lPcjJPNHFoeWJ3UUF4Q2MyNlUrZTRn?=
 =?utf-8?B?TENTRG9CZ2JPbXVWQlR6R1hpZXZnRmNNQmtoQ0EydjFPc1BxZWdjMlRiUHkx?=
 =?utf-8?B?MVphUjE4d2trUEh6S1N2R3lRWTdsWVNZRUhtaGVSMUJSWkxZSGhYNjdMdDkr?=
 =?utf-8?B?NHgrUmdXUm1ETUVxUGFXaVFjc1k3Smh6U29JblpXTjZERFRyL1pKcE9zLzBy?=
 =?utf-8?B?SHhuc25YRDd5TmwwQWRhSDRRNmxoYzF3cTl4cERHYy9nWXFBZ1JEd2g2UWlP?=
 =?utf-8?B?UkdZNWtqWDkyR1M5dVMzcGRmYlUyUk1mT1dDeTVUdE5sYTRjMm5Fb2JzOThC?=
 =?utf-8?B?Q0tQclBKMlJLcjF0ZmFPZFF3a0hnQUtwaUJwL25CQ0xPU1ZXbFE0TVRnZGNP?=
 =?utf-8?B?UWNHaFkzTlJsV280YlRkOFZSeDZwOW1zU1U3VmtiVGZrYjA3eXo4UG1NL2hU?=
 =?utf-8?B?QVRodW5ieFJ5TGlyQVZjQm5lVlFCZklKR1VMcjMvdXZrMTdvQXhnMERCaG1i?=
 =?utf-8?B?QmJxeWIzU1NnNURVYzhIcHE5RG9naTZpRWo3Y2wvVFVJRnR0NE9ONTZXa2Yv?=
 =?utf-8?B?SHpGNHEvRW9MejNOa3VYK2dONGJSdzJVWlBwZU1ZNHpXbm40RU9DUmZJckZs?=
 =?utf-8?B?VFVjRk5QdVJtZ3dIK2xXdWxweVAyWEs3MkswU0pHdUFUaTVheWFpSFFKSENy?=
 =?utf-8?B?OHl5QmZFU1dNZkNLbzBqaXR4WTdwUHhPUmd1emRqTUxLMUllb09PTUQwQXA5?=
 =?utf-8?B?NkVSNFkra2o1QTE0ZS9ET3NuUWR4bTZXeEVNcXVzSEVxbEV4Z2JhRTJaVW9s?=
 =?utf-8?B?MDRLUitGR1NtMCtBZytudW5KUTdOaitTSXlIMWxYa2hsMThXYjVNSGJhaVdh?=
 =?utf-8?B?UDNFQnpFdHdtQ2p1NXl0cFNJODI2UHVrNUtKek13c0xTb3dVM3FROUxiUVhS?=
 =?utf-8?B?bll6NndWNG81RjRBekdCME4xbzMyQkRJaE9wTngwcG11emp1RTNURytFNGd3?=
 =?utf-8?B?b0h2dTFNNzNuTVpnQmdieitqVkVwZWlsZlc0emMrQ0FJbmsxeUhXdG5nbjU5?=
 =?utf-8?B?MkZHSElncGNITWdmS0lheUNhdnFDMm14TkZaLyttVHdJdWJQbnNtVUhmWllD?=
 =?utf-8?B?VlBFcGF6Zkd5T3k1NXJlcnQxaWVuOU5DdmVIa1NNVWk1NmNodDdCdVcyTVNy?=
 =?utf-8?B?NDJVajVwZTdUcVppREkwSE1nS3BNQUc0eGhoN1Z5UWhaRURkU21xa2ZlTHVv?=
 =?utf-8?B?S2g1VjQzdit4YW9CRzArWjlDeEcxd1ZrZVlmb1dXK2tQYUs3OGpESEFaTjV1?=
 =?utf-8?B?NnlTSlZQTnNjcjJ5bW9pQlcxRDNlK0hFSXAray9GY1B4OS9FY0szM3NFNTNR?=
 =?utf-8?B?TWJ6MEZPMGlMbHY2ZEJvNEVjdzVyRDZCTGlSRm8xMkJSZGJKSmNhdUtoZE95?=
 =?utf-8?B?LzYyTTNSU0YyL1ZTdVQ2dUxxSEoybmtQSTN1MjB6V2I4ditoYWpKMkJYOUhi?=
 =?utf-8?B?V3NYWW5mN2tNMm91eXlHK1RWb3ZoOThldlM0Q1BkMmFSeHM5RG0zWjVDdktH?=
 =?utf-8?B?VWFTWks1ZkRpTDgrY21JdjNXMnBTUmllVEpHZDVXUmpobmkrUmtvdnVRa1dV?=
 =?utf-8?Q?MYKlz2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkdlbS9vK05aeS92cERpVUtpTmRZQytkMjZmK00wV1R3Rm96b1JoZjVwU1pN?=
 =?utf-8?B?Zk1ZanBrek9zTGRnVzlKWlp0YjBRTFQrbDZuNU5TRWg4MXdVSHBYQ2dwdTZX?=
 =?utf-8?B?ZzFZMnNEUmNLNXFWclBKZzhielFQYlZKcDEyV205ZjBFMWt6NXhXYys5aE5a?=
 =?utf-8?B?NURoa0pRcFlaZHZKd2Q2b2JwRFo1Ymg2K3RVZ2VPaUQyaHltNGpuU3A5OXA3?=
 =?utf-8?B?bktvdkFBLzdlZk5wSWs5L0pSOHNLR2lVYTc0ZGlFL25HVy9ZN0o1YXBsY0tF?=
 =?utf-8?B?UmpySk16dDB0ZXY4UjltMEhTOU5hMWNWYWg4VTJna2xObnQzOWlxeGRjL25i?=
 =?utf-8?B?d0VPNFVRRzZHcGw2QXhuUUFHUVN4aENJb2g3R25SNzZLQVVONXdNRmY0dGdF?=
 =?utf-8?B?OGNqbGdmYmRHL1Y0NElKcnpvZzAyVFdDLy9obHYwWVVVK2hEMkFFeFZ0Y1pI?=
 =?utf-8?B?aDUrSGx5L3FOQlpTVXlWSzZsY1BBZWxLZGYvL09aTnBvMmg5NDN2RFUyYytV?=
 =?utf-8?B?LzdZQ3ltL2lXUkdGOWpVT0tQSzY3c2JnaExuMXd6ck5hU1h1ZDBGVkozUDFR?=
 =?utf-8?B?VW81eTM4aFBtWS9WZXV6OVJFc1NHQjZsd25qTkJHK1pUV1AxRjRoVTBTcmQ1?=
 =?utf-8?B?bXBpS1R2ZGlld2ZzcHV2ZHVqVWJHMTB2MFhra1M5c0ZKbmtZTkVWeitCRlZQ?=
 =?utf-8?B?elRNb0xyZzZDMmtTcHlJUngyU1hmaVNLVUJkNGxNQkZndG0wNGxuUjRhNjdl?=
 =?utf-8?B?ZS85NFJPUm0xem9pZ3Y0WXVkaWVaTVVndUgwUFQvSGZ6djZ3SjQxQXNXUk5j?=
 =?utf-8?B?dDlpNndVaGg5WHZnalVxelVHWnI4UWFrZlo2ZzMyWnhKdFpSclppcElIQTRo?=
 =?utf-8?B?SkJrLy9vbzV2T3h4RysyT3JqV0ZiaVdNUDlyWlFrVDR2blI4QnhqN25FNDZm?=
 =?utf-8?B?QUN6Y0lTR2tRemNYRC8rNEdmUHlaTGxDbTJRcWJQZkNZODdqVjdsZ2Y1a1kw?=
 =?utf-8?B?RGRFb3p5L3NubmxzT2FFY2dORWNGQWltbUFwZ0JEdGpFSi9DQjFxTjFwR2ty?=
 =?utf-8?B?MEpBZUxMbEFPL1FrRm83VkRUNSt5dW5oeFovS2lNckgvNlVZUFp0VzBsbExQ?=
 =?utf-8?B?NjNSVEVua0lscmgxWEdrVFVnNVdsR2V1RmxVZENEb2krSC9ENUlpQkVRU3Bq?=
 =?utf-8?B?dGZUMkM3MzhKS1FqdGtBVnp5RjhtdzVBd0hWWldiUzBtc04ranZsZmR5MWRC?=
 =?utf-8?B?c3dUQ1lXM3JFRFZHaWIxakJQVlEwdXg1MUl2czhvNUFsRnk5L1hrR0ZVQjZB?=
 =?utf-8?B?VElPeVlienQ0VjVRck01cVdpMDVqRERtOEZjRlZWZXRqczl6Z1I2aWpHZ25E?=
 =?utf-8?B?OHBhOUYyN1JjUU5TbGJsWTUvQUZzaSsvcWRpT2xVdERwL3pYYi9iS1ZlWmNP?=
 =?utf-8?B?dnFkZWw0VG1PTlNiTzFHR2VKMzFBQUp2bDI0YXg3K1E4SklYR1NkaXBLYXVi?=
 =?utf-8?B?ckJmRm53V1VlU1lXNlc2OEpVVHZLd1pSV2QyWUlJRU1SRENYbHNMSHdGRi9B?=
 =?utf-8?B?Y0l0TGtXcFhoVEcxN1Q1TVBEclpWYTVuRFlzMW4yMURURG5tcnIzSm1pQlNm?=
 =?utf-8?B?WVFhcmJBRWNqZDJHd2RIUUd0elB4ZEsvb2d1aHNHVEtIeUIrak1PV3hKVzlh?=
 =?utf-8?B?V08xbHdhckdsUlF4UVg2V1NDZFBJQWRZVFp3THkwSmRkcWlST2ZWQ0ZrRk9I?=
 =?utf-8?B?WnRlZTJPcXltWmtWWEQraU1vY0RJa3hXTnhFRFpiQXVyWFc1SHVabURPam5D?=
 =?utf-8?B?aEFjM2RSTmxrWWdkNFordGdWR2syNFJ0QzZxOEM1TWNvSGVoZnY5OGZubStW?=
 =?utf-8?B?cDVWMUtrRUhPcTd4SGJ3VGxNSzF5Ni9NbHpsSTgyMW0vMU43OUFBeDZqK2xp?=
 =?utf-8?B?Ynd2blpKT3poT05KdHVZWGZaQ1F2SU5EcFl2V1ZqYUNxaktoMUszWnNsVW9K?=
 =?utf-8?B?aWx3cmVka2hHQUZYSEo3L3pWRTZFb0MwZDBxZjZ3ZU42NnB0bUJCdHh3RzZ2?=
 =?utf-8?B?T1YwKzlPdkZYaXJqYW5UcHZvUnM3MUpkNGlraGc2Um9WV25oSHlFOUQyZGNu?=
 =?utf-8?B?SHJOS0ZkaHVLWFZWQjExZURlQVRmWjFhSllTejZkRkFWd1hydE9PLzVoTy8w?=
 =?utf-8?B?Z0lITU96dXFtQ1NReThCQ0dGYXZ1cTVhemVRVC92UlVoR0hGTDBvU1F3SUtp?=
 =?utf-8?B?QmtlTlJ5TllYOEhSZmlCbWxHOWhrbVNuc05QNU1rQ3hkMmFibm5HTHdLc2pG?=
 =?utf-8?B?UkZ3MmJ3VHNUc3JkMU5odFZia0FmSU1tZ3BTZmloQXFoSU5kd0xndz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mkUrRw49H2MXqbfTNUh24bgAxcDIt858bq3fV8FoFPWf3yGICaJovfIyqt32Kl3TB/M/zhbuuhFAkTmEV3feqxmbM0Ik/s2y6Uk3kSFmIaBJIJWXxMuKwxgHsmaD2hJRBLbViG8KE4UV9Ks6lAc9ibwLuMIWrQ/eqvwYrveXzRK6P6EEBS0H4x56qOJtwGXM3txTpJ2EnLxozGBlfrB8Qk3lmMpJ74AiKQwgLvrVtek1EJyc0opa5hno9kNkspcUkYKnzGQh3K1iQs7j75nm9h1BIOfOUTAfgXw5EKXW1rH9OueWL1FzNJJqbJY+YI4/I4ggtNnkZDCSr2N3PmC9IMesbtAiHGtW1PBAH4yxtDiFWahRLXTVm6jCow2uuIo+EbUKjmpbmhAUc3MGjGoyXraNwcTiuoR+cHxzUPrBBZEYOzIZG3C7csljP3BBEHNT7O6HN+nmhnML90qC8FqiTwYQ9gPUcYrTGfqeD2uJtgbKq5g20p+Mpt+mcWZrU7/ayeLrxR1D+NqTUFT0PDxKVC/auI0O8P50X1zyQqTK55AEpB4aR4pR5vBkm1vUDaUwhUXCZBxBWHGyPU4vtW6c/eAi7mpRN0bJduXSqwP6EQzkEv/8j9o9SPireEEOA9Kb
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f332d7b-743a-4e59-d8bf-08de528e483b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 10:26:58.3430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IW8+811lKQj0+kgX4q0uwoHmT1BNr0XxQJjCJzyOtxWhw/oALyuhHln/Ro7f2XHZvnN9VwqmS+xijwwLNUIhoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8278
X-Proofpoint-ORIG-GUID: 3ET9YXOJdSimaJ_96iMB4NiuJAzyhEYA
X-Authority-Analysis: v=2.4 cv=foLRpV4f c=1 sm=1 tr=0 ts=69661dfd cx=c_pps a=MHq0tdBkReDSW4qRyocOiQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=z6gsHLkEAAAA:8 a=QRrz3PqKjPalw96IhGIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4OCBTYWx0ZWRfX9ih0WPxxfsa1 BKT3R+AAxxOySv4j9r0CLQG5/R+vDXa0b/ZThx4CCvuG95JKpe85Bgzniovvry3c1C05ooNZrl6 gXtTyz0CjGYb2LQeZgl2QxKzSf8QYmFVd/JnZhbpc5pKIILpKiqTH6IXBz4TvmGknWZWeJ2dS7A
 M6UrW9XGCAe5NXcmPCyPb9jEbJHtWeyaI+XL8Eph/sW+zb1CIJ8iQ2V0r2biMXfOZ4rfJBVNXku gogOlo6IPfPhV6hKhrZBxDHORNEvn31qrhysQVzt1wvK+fNd3NSMc4G27p5VUevSMAvsMLYmu1x lDjefIZF2U7v1p40X52wNTbZ1R5b8z7vpOXraa5xauFf4ktrRLhPCMHESDeK99so2II9diHc15l
 fqHVeqBise3legNBbZgBelY5vpgdSShf8Qn0Zdh1rKQ43T8RN9MGLL/Uu+UNqMcC9vnm88K2SC+ q0fXqalcTajvW1Lx0Vg==
X-Proofpoint-GUID: 3ET9YXOJdSimaJ_96iMB4NiuJAzyhEYA
X-Sony-Outbound-GUID: 3ET9YXOJdSimaJ_96iMB4NiuJAzyhEYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01

PiBPbiAxLzEzLzI2IDE0OjM3LCBZdWV6aGFuZy5Nb0Bzb255LmNvbSB3cm90ZToKPj4+IEBAIC0y
ODEsNyArMjg1LDcgQEAgc3RhdGljIGludCBleGZhdF9nZXRfYmxvY2soc3RydWN0IGlub2RlICpp
bm9kZSwgc2VjdG9yX3QgaWJsb2NrLAo+Pj4gICAgICAgICBzZWNfb2Zmc2V0ID0gaWJsb2NrICYg
KHNiaS0+c2VjdF9wZXJfY2x1cyAtIDEpOwo+Pj4KPj4+ICAgICAgICAgcGh5cyA9IGV4ZmF0X2Ns
dXN0ZXJfdG9fc2VjdG9yKHNiaSwgY2x1c3RlcikgKyBzZWNfb2Zmc2V0Owo+Pj4gLSAgICAgICBt
YXBwZWRfYmxvY2tzID0gc2JpLT5zZWN0X3Blcl9jbHVzIC0gc2VjX29mZnNldDsKPj4+ICsgICAg
ICAgbWFwcGVkX2Jsb2NrcyA9IChjb3VudCA8PCBzYmktPnNlY3RfcGVyX2NsdXNfYml0cykgLSBz
ZWNfb2Zmc2V0Owo+Pgo+PiBUaGlzIGxlZnQgc2hpZnQgd2lsbCBjYXVzZSBhbiBvdmVyZmxvdyBp
ZiB0aGUgZmlsZSBpcyBsYXJnZXIgdGhhbiAyVEIKPj4gYW5kIHRoZSBjbHVzdGVycyBhcmUgY29u
dGlndW91cy4KPgo+IFRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgdGhpcyBvdXQsIEkgd2lsbCBjaGFu
Z2UgdGhlIHR5cGUgdG8gYmxrY250X3QgaW4KPiB2MyB0byBmaXggdGhpcyBidWcuCgpJIGRvbid0
IHRoaW5rIGl0J3MgbmVjZXNzYXJ5IHRvIGNoYW5nZSB0aGUgdHlwZSB0byBibGtjbnRfdCwgYmVj
YXVzZSB0aGUgdHlwZQpvZiBiaF9yZXN1bHQtPmJfc2l6ZSBpcyBzaXplX3QgKGFrYSB1bnNpZ25l
ZCBsb25nIGludCkuCgpUaGUgb3ZlcmZsb3cgd2FzIGNhdXNlZCBieSAnKmNvdW50JyBiZWluZyBp
bmNyZWFzZWQgaW4gZXhmYXRfbWFwX2NsdXN0ZXIoKS4KSSB0aGluayBpdCBzaG91bGQgYmUgZml4
ZWQgYXMgYmVsb3cuCgotLS0gYS9mcy9leGZhdC9pbm9kZS5jCisrKyBiL2ZzL2V4ZmF0L2lub2Rl
LmMKQEAgLTE1Myw3ICsxNTMsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X21hcF9jbHVzdGVyKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBjbHVfb2Zmc2V0LAogICAgICAgICAgICAgICAg
bGFzdF9jbHUgKz0gbnVtX2NsdXN0ZXJzIC0gMTsKICAgICAgICAgICAgICAgIGlmIChjbHVfb2Zm
c2V0IDwgbnVtX2NsdXN0ZXJzKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICpjbHUgKz0gY2x1
X29mZnNldDsKLSAgICAgICAgICAgICAgICAgICAgICAgKmNvdW50ID0gbnVtX2NsdXN0ZXJzIC0g
Y2x1X29mZnNldDsKKyAgICAgICAgICAgICAgICAgICAgICAgKmNvdW50ID0gbWluKG51bV9jbHVz
dGVycyAtIGNsdV9vZmZzZXQsICpjb3VudCk7CiAgICAgICAgICAgICAgICB9IGVsc2UgewogICAg
ICAgICAgICAgICAgICAgICAgICAqY2x1ID0gRVhGQVRfRU9GX0NMVVNURVI7CiAgICAgICAgICAg
ICAgICAgICAgICAgICpjb3VudCA9IDA7CkBAIC0yODQsNyArMjg0LDcgQEAgc3RhdGljIGludCBl
eGZhdF9nZXRfYmxvY2soc3RydWN0IGlub2RlICppbm9kZSwgc2VjdG9yX3QgaWJsb2NrLAogICAg
ICAgIHNlY19vZmZzZXQgPSBpYmxvY2sgJiAoc2JpLT5zZWN0X3Blcl9jbHVzIC0gMSk7CiAKICAg
ICAgICBwaHlzID0gZXhmYXRfY2x1c3Rlcl90b19zZWN0b3Ioc2JpLCBjbHVzdGVyKSArIHNlY19v
ZmZzZXQ7Ci0gICAgICAgbWFwcGVkX2Jsb2NrcyA9IChjb3VudCA8PCBzYmktPnNlY3RfcGVyX2Ns
dXNfYml0cykgLSBzZWNfb2Zmc2V0OworICAgICAgIG1hcHBlZF9ibG9ja3MgPSAoKHVuc2lnbmVk
IGxvbmcpY291bnQgPDwgc2JpLT5zZWN0X3Blcl9jbHVzX2JpdHMpIC0gc2VjX29mZnNldDsKICAg
ICAgICBtYXhfYmxvY2tzID0gbWluKG1hcHBlZF9ibG9ja3MsIG1heF9ibG9ja3MpOwogCiAgICAg
ICAgbWFwX2JoKGJoX3Jlc3VsdCwgc2IsIHBoeXMpOwoKPiAKPiBkaWZmIC0tZ2l0IGEvZnMvZXhm
YXQvaW5vZGUuYyBiL2ZzL2V4ZmF0L2lub2RlLmMKPiBpbmRleCBlOGI3NDE4NWIwYWQuLjljMWUw
MGY1YjAxMSAxMDA2NDQKPiAtLS0gYS9mcy9leGZhdC9pbm9kZS5jCj4gKysrIGIvZnMvZXhmYXQv
aW5vZGUuYwo+IEBAIC0yNTAsOSArMjUwLDkgQEAgc3RhdGljIGludCBleGZhdF9nZXRfYmxvY2so
c3RydWN0IGlub2RlICppbm9kZSwKPiBzZWN0b3JfdCBpYmxvY2ssCj4gICAgICAgICBzdHJ1Y3Qg
ZXhmYXRfaW5vZGVfaW5mbyAqZWkgPSBFWEZBVF9JKGlub2RlKTsKPiAgICAgICAgIHN0cnVjdCBz
dXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9zYjsKPiAgICAgICAgIHN0cnVjdCBleGZhdF9zYl9p
bmZvICpzYmkgPSBFWEZBVF9TQihzYik7Cj4tICAgICAgIHVuc2lnbmVkIGxvbmcgbWF4X2Jsb2Nr
cyA9IGJoX3Jlc3VsdC0+Yl9zaXplID4+IGlub2RlLT5pX2Jsa2JpdHM7Cj4rICAgICAgIGJsa2Nu
dF90IG1heF9ibG9ja3MgPSBFWEZBVF9CX1RPX0JMSyhiaF9yZXN1bHQtPmJfc2l6ZSwgc2IpOwo+
KyAgICAgICBibGtjbnRfdCBtYXBwZWRfYmxvY2tzID0gMDsKPiAgICAgICAgIGludCBlcnIgPSAw
Owo+LSAgICAgICB1bnNpZ25lZCBsb25nIG1hcHBlZF9ibG9ja3MgPSAwOwo+ICAgICAgICAgdW5z
aWduZWQgaW50IGNsdXN0ZXIsIHNlY19vZmZzZXQsIGNvdW50Owo+ICAgICAgICAgc2VjdG9yX3Qg
bGFzdF9ibG9jazsKPiAgICAgICAgIHNlY3Rvcl90IHBoeXMgPSAwOwo+Cj4+Cj4+IFRoZSBvdGhl
cnMgbG9vayBnb29kLgo+PiBSZXZpZXdlZC1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNv
bnkuY29tPgo+Cj4KPiBUaGFua3MsCgoK

