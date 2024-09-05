Return-Path: <linux-fsdevel+bounces-28757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1620396DE95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0401C20C2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE24119F469;
	Thu,  5 Sep 2024 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nyzZ03BO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bBS1+t/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3464319DF69;
	Thu,  5 Sep 2024 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550900; cv=fail; b=NHSE5jjmfzHA5vi45ps6gC+llttxXQAFiBFmVoNwTxMR1aYILl0Gu1i7fXa2FnNjqm9iaiBAtgcK/4kYEm1YfBYDFt/YkFfq0uXOsKLzTQwrZNSeNixY0SEH0Seq1EYRSdcNYgAgfz2RA+YG/mkxIGPfwDVt2223bkGL6w9/Ct8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550900; c=relaxed/simple;
	bh=Vc4AyVRJR2Yn2coDnB0PvDSBYpq9fCn/7/KKlATpMUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ACiUtAo6JP+NgAwfmKpskj8ltmkRIwUy2J3apasItxr2yS3QgouzoAooQVhTo7a7t/ge3rvDF+oq12fsUl3VfDaUXQY1q1jerTasiE60zaWTX2uO5jLmjkH0VocZhPy/bmw8lBqQD+W9KjFPZw8+DEH3EYMcV5Do2+DG9oSMvSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nyzZ03BO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bBS1+t/5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485EteYq027840;
	Thu, 5 Sep 2024 15:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Vc4AyVRJR2Yn2coDnB0PvDSBYpq9fCn/7/KKlATpM
	UI=; b=nyzZ03BO2tMIvodA+0EULOtBfAvzPjxXfx4jiXlUUN9LCUMOub1zGHMRz
	rMTD/91k0nmMudKn6iyKbg0HW8zERnBJMnaO3uBOMi6Avm/W1ETIEb+wUYNlAyaI
	Gl/88QcPGR96/bT3Zl3n8+HuXWZpoxdiO4vFdjBagtqNN9Pok4CoNyNQbHMu4I4Y
	Womh8PRWO4eRPVXeJcK7iWc72/fHN084tNmYZDksa9pg4XYi8It9/6BM7mwK5uNo
	8WfEqpk94eLrq4YADlqS3Tu0uBiUzGjfFD7EzKr3en/rZkp52hcCyBPN3DdchzNe
	uXozsjmh9vH5xwG4FN2W7cdOA1bfw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dr0jxp5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 15:41:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 485EdxLr001699;
	Thu, 5 Sep 2024 15:41:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmhxxud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 15:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaxMiMhU4xS2W0V1JwckEk1U//QiQR3WsX8T8SVTst3eY/5LnhMpRvm+mtiPSHYvtJTL+DSI3JH2o/YdulwhQDNwnIWddHtOA7Ajh2hudG6X4jd4sFt71M0ilhkp2Y73HxekA1WEtcTy9d4zZ/bNZV2Rnprc6b0YYexdRiJob770yJbQmUp7r+vyyOhXs39DLo6Px68KKjYLjveIQtcXthjf+pN6U+5T9tpSL1tKD7xZrhevGk7DAHc/do+0Kf5QF6G9b7kyVirbOCwTo3JTnT+pMmLwzK+1FNV/gU6XVxD79YVUNJg1JPu2DjKDzUqpgOkAHEaSh3J01NwwGh4U8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc4AyVRJR2Yn2coDnB0PvDSBYpq9fCn/7/KKlATpMUI=;
 b=vANoIDJoFGsR7f8eu19CPYB3HmZgR4NdgFBeuwEPtlIABRfJ76bbASxklFpVjIHR36Zru/1YSvv2kZZl+41S2OFRkNqO1QO9JuXco3hTFcCwBb7g8yh9ASdGnXstwivL/G7feIs7yHEm98d7iCmUzJ5BdG/FHfu7nerMLx7aftI2XnuuOLJQLU63fRabmmumNo/fFQiyVQFljqkvtZqlENVpk5DcApnJbh754Q3WjDCkweOFkGNt5iH0gvyo9lEt6zqoIolcDtv7/wazl+ZlUz/g7WlGOHz6VAY639P4TWgLdZ7kQ6cX+E+gRbEHi6cvpKapeGWPq4YFV79O+WAoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc4AyVRJR2Yn2coDnB0PvDSBYpq9fCn/7/KKlATpMUI=;
 b=bBS1+t/5/MaZZ0XJdUz6bwpPy96DFVUhGsArjyNbjDB3CRUNvw5J5cupUQ/D5x17+eYFk8I2o1UTUr7x+Is63Gxe6OPGcnrspCmO6Rp9+8sYGL9pPOMLiyMIRLYVdvjC7FbV8WsZY8653oSyrh64JoSlNz/gexIsPvgofAJyu1g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7141.namprd10.prod.outlook.com (2603:10b6:208:3fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Thu, 5 Sep
 2024 15:41:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Thu, 5 Sep 2024
 15:41:24 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Topic: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Index:
 AQHa+/Z8NjJpiHCGJkyIBxPv6nO2sLJGJLQAgAABzwCAAAV7gIAABX6AgAACqoCAAAhmAIAAbZ+AgABs/QCAAJLIgIABm82AgAAWagA=
Date: Thu, 5 Sep 2024 15:41:24 +0000
Message-ID: <903975A6-EEA4-4BFD-826F-5A82C40AD5DC@oracle.com>
References: <67405117-1C08-4CA9-B0CE-743DFC7BCE3F@oracle.com>
 <172540270112.4433.6741926579586461095@noble.neil.brown.name>
 <172542610641.4433.9213915589635956986@noble.neil.brown.name>
 <Zthk29iSYQs6J8NX@tissot.1015granger.net> <Ztm-TbSdXOkx3IHn@kernel.org>
In-Reply-To: <Ztm-TbSdXOkx3IHn@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7141:EE_
x-ms-office365-filtering-correlation-id: 3d4ac7b4-8ef5-4e02-7ac0-08dccdc13318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amI1cU14c2RoMjRIQ2ZzOFYzVnM1b3Z4SUVqQUZQTmhUbytYU3k3T3dnQ2Zj?=
 =?utf-8?B?L1VOQXJoSWdmTy8wSEt3bWkzaU9ldkNjM0gzZWNmSVFTdlRJbkprbEtDbzc4?=
 =?utf-8?B?SEd5VUlNRHV5dUNBYURzTVVRQUFvZUVlVHNzMnRkaGV6a1c3aFBySVY0Q1p3?=
 =?utf-8?B?R05CcHBFdDVZRHNSYkh6TTR5Y0NrNWU3cC9QckFlazNDK0Y3VFliajNxdjJo?=
 =?utf-8?B?UFBTcUNBSGpITUFleTcxS1pnMFAvWWhDZlJvcnoxYTF1WHRoR1BiRTZQOTM1?=
 =?utf-8?B?dFJhTVA2bGNnMjdHSFJZckF3QnRmbWFxVnlhL3RFOG56aGlUSUFDYm4yY3dE?=
 =?utf-8?B?OW55cExoaEtUUXBUanpZZnFyUktBYU52d3lqcnVaRWEzWjROVFNZSFBTZ3pW?=
 =?utf-8?B?VEd4elpwaDZpbVpMRHUxSzdwUmVLWmg3ZDhsOHMxZWV5U3VBKzhUWVNrR2RJ?=
 =?utf-8?B?U0w1R05DSTAxaytGaURGU3Z2UHhNdm45cmhsQzB1NlFrZ2ttU3M4RVRsWERS?=
 =?utf-8?B?d2hlaXY3eWlWZGNpY1hiV0FUaFI4bkM3WU5qd0hXREcxUEpaYVBxUmY4ZUN6?=
 =?utf-8?B?R3JWRUVBcUd3NC9rNk5YL3hVN2oySW9HUU8yNnoyVEhITG13MlNkQTVDa2JQ?=
 =?utf-8?B?eFU3WEtkZnhheHJaZXFxQ3VNejhoSzNOS0ZYR0hpYklScVc2U1RhNEdpKzlJ?=
 =?utf-8?B?dTBWc3Eyekova0R3R0FWY2w2NDJ5RFlBMi9XZElETjJqUUN5REVxdnk1ZG1C?=
 =?utf-8?B?SGZxeUxCRUUySHZDRmlaQy9jSlIzSFBiNmtIT09TZklaaVFjRThSNWpTQWsy?=
 =?utf-8?B?VlRLeU9NWk8yek5Jai80ZWNVaU9YNG43V0tXYzVHT1J2Wkk3T2NzREh3UVk5?=
 =?utf-8?B?L1R5aVYxQ21RZ1VIR2Mxd2toeHNyT2VCdjJ4emgzT0NRbkV3TkxJT2MxZk1i?=
 =?utf-8?B?SXlaaXVHMTM5dlFURWlVZDV1NWt5MHFpbm1NK2VEMnVGWktQeElwVC8rUlNr?=
 =?utf-8?B?WisyN2c5MWtnWTdydkhKR2pTUnM1eFNMQklyTmVnV2NtVEQ3WUYvTHB0QTZG?=
 =?utf-8?B?dFd1cVVYMWJuMHlZNjlvOEQwYXVRanh5aGxjSWt1RVUzeUhDdGhqYjZaUVBv?=
 =?utf-8?B?cFVkQllxaWVINUZmeWQvVWdDeVpMMXQwKzM0S3RZbU80U0o5VnZhQk5jYlpT?=
 =?utf-8?B?VXc4NkkzekhLVnFwWGx5UXdvZDlDTGxWWXlZUjl1U0NBaDhjQjU0SldZR1pu?=
 =?utf-8?B?RzZxVTFpUmNGV1MwbjBodU94blZOcDRrYnNRb2Y3cnBydThIcHZKZHRkbkJy?=
 =?utf-8?B?M1psVUVZa2ZuRU13UUhhSW5xVDZ4cERFTDk4MmVselZheEVlc082eDhvMDR4?=
 =?utf-8?B?NGtEL24vZE1hSlFNWWJsWnF2NEt3L1pRTlZpcnFFY2lHSWtVZ0lLMTFXWGJX?=
 =?utf-8?B?S3lFS1JwOTl4ZjBra2lGRmtUZXgzNWkwSVlmaWdQNHp0bWI0NENxMThPRmxT?=
 =?utf-8?B?Q3o0VjN1bU95bXBNMHZKd2sraDJMTHpTY0VXTlo1QXZhUTNjcGw2bHYzdDJG?=
 =?utf-8?B?cUxmOWxFZ3VQZ3FWSkd1ckk0alBTaTEwbW5PRTVSclJXS1NPU2NBTkJPL1Jl?=
 =?utf-8?B?VzF1dzdoYVc3cCs5QWF0cVd4ODZzZnhWZGlWMUR4a2FWZGoyVGhKSVdLQkhN?=
 =?utf-8?B?aWtPaU93a2xsUmYwdUFoMi93L21nS29ldGM2MFlpWmVjaEZmYmNQdnRJNFFH?=
 =?utf-8?B?NWdzYzlKSFBtbGdxT2pwbSs2MFVoZlRnNU5XNXE2bEgvMVIvTktGWGxGWExp?=
 =?utf-8?B?MDA2eTYyYWdIakhyL3FFUGU1QytWRWQyV0pCaXBQbmxQUlRpNHlRRysrS2Ey?=
 =?utf-8?B?a1dzR1hzNVBRM2IxK04vbWVnbGh1dFpTc2FDZUpmQzlJNDRMTCtWUUhLbThQ?=
 =?utf-8?Q?1l8FCFbT1dE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlRqNi9QZ3R4a3Z1dG4ydEdoanUzR0FCQmhIY3lCMHBDcEwxck1HWm9Rcks5?=
 =?utf-8?B?ZXl2TW1JVjJHVk5ZcGhMNGUrVmo5RTlvMHpKMWcwR2N0MDhtUFFpQ21wbWlp?=
 =?utf-8?B?SkdMS1Q2eUNCdUhubkRpWEN6Rk45WG5JSmRPdW9ITHlHZStuZk5GbDBjTXdu?=
 =?utf-8?B?d21SeDRTaGY1eHB5RlJaaTFpb2c3bnN2aWhhbmV4MENuRm9jWGdCQlVBcHFF?=
 =?utf-8?B?VU5DMysxa0lwaXhmUjFmelhRZ0dlZVNldVVRU2NZVkU2RHpIaHVINEVYdWV5?=
 =?utf-8?B?bDkrQkZXV0t2SkN4M094S3FYcUVDbUlZNkhZc0ZJTytEeVJ1MlBUWk5rbzVo?=
 =?utf-8?B?dndWSE15SnpVdE1INHlFU29SMGRURzk3T1JMTkRFWmVrdFgwRGRVRGNCVGF6?=
 =?utf-8?B?VGVEdlk3a3cweFprRkdMY0JmZUtaK3hUZGdKYk84aWdkRW1ySTR1M2lNSkRu?=
 =?utf-8?B?VndEU2ZGMHZleUpoZXVrYmtPR3ZDaU94L3licFN0M3dicWxOV2RUWXJTZ1Z1?=
 =?utf-8?B?dGk0RXkrT3dxVFpmZGdIZnhvNVRCRzdPZTUwWWtRMjdudTVPbHYxU09EUmkx?=
 =?utf-8?B?SkFjQXE1YmMvSHE3bjFBdnRpQTZhRzNEaCtxNlgvdGxoMG9YQjB3aXg1Szh1?=
 =?utf-8?B?dmJRVjRsZGxGUjZDdEc3ZUN5YTBwbERCZ01xWC91SWJSU2kwUmFpejRFNGFO?=
 =?utf-8?B?S0ZhaU9xSGNvMHhoSlMxV2pBR3ExTDZjQTdoc2ZoTkVtRkZlTkt2Y1NlRVhF?=
 =?utf-8?B?VzhFRWhmakJTblo4cE1oRlZXZnltdzhQVURMenUrUm1reGpnVm1JOXo5enM4?=
 =?utf-8?B?WVlwcysvOGp6OVBNeFVOYzBXYVowM056MEU4MFVZbG54Wk54Z0xzSGUwSzRF?=
 =?utf-8?B?WUlsRDQ3aHBnRU5scUFBOGc2THpQUDJ0WmJvU09QbkdFMktJRFo1MTRZdXh4?=
 =?utf-8?B?TllVVVEzU2hsaEJHMUFnS0dIUVNKL1ZLRlgxdmxoSVh4L2loOXBGSnRxbVlD?=
 =?utf-8?B?VTM0WUF0R3hCK0lpUVVYbTVlT2JoRFZWZTNkYkcxek9McmE2QThKYWVwUVVl?=
 =?utf-8?B?QkVJcytzRnYvSUxPaTZZdXM5K3pscTYyc3VnMCtFSWxxSVc0OTMzcjB5OWN2?=
 =?utf-8?B?RnIwdmlHc0VlMlo4emdPZUdFYVNvSUVZSGVKQ0tVMStJZTErWUVzVCtvVm9N?=
 =?utf-8?B?bEpnLzF1NzVXS2tSWlpJOGhKdHFIYUdFSHhjWVI4cGFmOEpJOWNtM283Mm1m?=
 =?utf-8?B?VUVrcEYwV1RYdVNENkdnUUc5Q2tKbzJlUEJLU3ljei9YWWJObjFWZDhJZHJ0?=
 =?utf-8?B?SXhSanB3cFIrRDE0WG1nL09ldy9zMXhmaVB6THJ4Z2U3Vm1jVjRHZjI1THo4?=
 =?utf-8?B?RHczUFYyZ2M4dGIzUE1WN0I3OGluTWtyMmJpVVZkYktWYlR1b2hmSDVjNXRQ?=
 =?utf-8?B?eWp1MkorQnJCMnhVWTEzU1NYdmtXQ04xZUQ4eTY5Nkl1QnRxNi9PL25WTEVq?=
 =?utf-8?B?dUpVK0Z1azN3bFQ5RURPVGRoMzM1c3M4UXVETGFnRllqN080LzFNeFRRQSs0?=
 =?utf-8?B?WCszcmkxSUlDc01INWV3a2t5V202ekpIdmxBbTllYm43RmpWM1h3c0xYTlZY?=
 =?utf-8?B?MEdKSzdicmhnWkQwZlhUT3BVQnJ1UFA1QmFqQUtyTUdKSmd5d0Q2RUw5TmtD?=
 =?utf-8?B?WndRKzNyMm9LeUExTEZzQ2t3K1F6d242dUUxUXlRMW1sdEdvU2xBbmJmaUFK?=
 =?utf-8?B?UlBSYjV6THpXWCs0dkQrbThZb3IvOW9UOVRyMkRHZXI5YWt4cVNhbG93VWc5?=
 =?utf-8?B?U2Q2d1pNKzNmTFVpcHJTS2NpUHJJSDFWN2tRVWtYNTlTNEowMmdXakJpVEZI?=
 =?utf-8?B?QnlscnBjKzFHUXVCVTl0bXA4UjVBUkViejNYSnhmb2ExWFhabGM2RjQwaDF4?=
 =?utf-8?B?RmZSa1V5WEpZeitBTGVSZVFkZWNSb2NWUWJwa2lUWmpJdnQvSkxmaS9zaVFu?=
 =?utf-8?B?K2tLS25PeDNNNEZKK0FxRUdZSzZCd1VuMHo2T201NEdjeXlUOWVObXkzZzlR?=
 =?utf-8?B?eWtWK1VDNUp2a1Azb3BSdWRwdmZwUWVMaG9PTUdSQmh0ampwMzhmQU40WWtJ?=
 =?utf-8?B?bERDazRJaVVvWFJudTU5YS8ybmcrbzRidXdSZ3NzZkpZUVNzQndDTlU2a0Nl?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4DD1123FCC52E46B5E2C4280936FB26@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a5SEIbN4jJOi95jqZ9hez1tZrqm9UX8jFau1cWo2zo1ig5WGTiglBtIHd1stRXz6a+RXuDa0GDJGkH56vFgf0XSk228aEIo21BF2ar+E2pV/KtszcWtdRMBRF40fSN5HoQVy28FMfHAHWC1xAdLLvjJloKbXBgWyBt78A2IJGikKbgMYARJNGTTzidZZPWyTKTxM8l0rPateeTP0jUkJujanjO8YGkGzr6EfNQ5zoIopVdi2vKxpzKhwsI6UsY0Z2tF4DT4OSSk5L0ZWYgH0ycuIot/Oh9A1RlNXeAemmfyXU1d6DRv5JIi1dp4o1EVD/jm06WQEL7c4Is1AW7J1jlS1Gax2xxLdh9zQsRSJJXuTwIWqFFvpX2ap2nAlBE+JxUJEe1WI8XlEUx6/DsqItDZbyes5sp2aIg7cpwFJ3Mr7lZ1zttRCXgmZH95I6QcbzfPhT0aDXhT7xP7XuR8ao+n845K6NWYpBqxWHbJWU44+Z3ysqlCH75SPzTsrE1gE9hTxk+mzocjP18F0KHq0lfryhLfzgZzPA7UQq/mLv7AVk8u5IrHRivM1H7qqviWyzbV+PU+206TaTI2ayOabW1pr/JzydDIw6TlRTilE5z4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4ac7b4-8ef5-4e02-7ac0-08dccdc13318
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 15:41:24.9090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yx4UOkYV4/jJxZ2fa7h9OjwHRAalBVhCj2GWhlW8F/rHxCzugjeaRq+wf0LIDQmuQznEUWgTZ4r8VvaKuj05Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_10,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409050116
X-Proofpoint-GUID: bAXpseTfA4LIYis5DgeJrkJqJca-U6Ib
X-Proofpoint-ORIG-GUID: bAXpseTfA4LIYis5DgeJrkJqJca-U6Ib

DQoNCj4gT24gU2VwIDUsIDIwMjQsIGF0IDEwOjIx4oCvQU0sIE1pa2UgU25pdHplciA8c25pdHpl
ckBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgU2VwIDA0LCAyMDI0IGF0IDA5OjQ3
OjA3QU0gLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4gT24gV2VkLCBTZXAgMDQsIDIwMjQg
YXQgMDM6MDE6NDZQTSArMTAwMCwgTmVpbEJyb3duIHdyb3RlOg0KPj4+IE9uIFdlZCwgMDQgU2Vw
IDIwMjQsIE5laWxCcm93biB3cm90ZToNCj4+Pj4gDQo+Pj4+IEkgYWdyZWUgdGhhdCBkcm9wcGlu
ZyBhbmQgcmVjbGFpbWluZyBhIGxvY2sgaXMgYW4gYW50aS1wYXR0ZXJuIGFuZCBpbg0KPj4+PiBi
ZXN0IGF2b2lkZWQgaW4gZ2VuZXJhbC4gIEkgY2Fubm90IHNlZSBhIGJldHRlciBhbHRlcm5hdGl2
ZSBpbiB0aGlzDQo+Pj4+IGNhc2UuDQo+Pj4gDQo+Pj4gSXQgb2NjdXJyZWQgdG8gbWUgd2hhdCBJ
IHNob3VsZCBzcGVsbCBvdXQgdGhlIGFsdGVybmF0ZSB0aGF0IEkgRE8gc2VlIHNvDQo+Pj4geW91
IGhhdmUgdGhlIG9wdGlvbiBvZiBkaXNhZ3JlZWluZyB3aXRoIG15IGFzc2Vzc21lbnQgdGhhdCBp
dCBpc24ndA0KPj4+ICJiZXR0ZXIiLg0KPj4+IA0KPj4+IFdlIG5lZWQgUkNVIHRvIGNhbGwgaW50
byBuZnNkLCB3ZSBuZWVkIGEgcGVyLWNwdSByZWYgb24gdGhlIG5ldCAod2hpY2gNCj4+PiB3ZSBj
YW4gb25seSBnZXQgaW5zaWRlIG5mc2QpIGFuZCBOT1QgUkNVIHRvIGNhbGwNCj4+PiBuZnNkX2Zp
bGVfYWNxdWlyZV9sb2NhbCgpLg0KPj4+IA0KPj4+IFRoZSBjdXJyZW50IGNvZGUgY29tYmluZXMg
dGhlc2UgKGJlY2F1c2UgdGhleSBhcmUgb25seSB1c2VkIHRvZ2V0aGVyKQ0KPj4+IGFuZCBzbyB0
aGUgbmVlZCB0byBkcm9wIHJjdS4gDQo+Pj4gDQo+Pj4gSSB0aG91Z2h0IGJyaWVmbHkgdGhhdCBp
dCBjb3VsZCBzaW1wbHkgZHJvcCByY3UgYW5kIGxlYXZlIGl0IGRyb3BwZWQNCj4+PiAoX19yZWxl
YXNlcyhyY3UpKSBidXQgbm90IG9ubHkgZG8gSSBnZW5lcmFsbHkgbGlrZSB0aGF0IExFU1MgdGhh
bg0KPj4+IGRyb3BwaW5nIGFuZCByZWNsYWltaW5nLCBJIHRoaW5rIGl0IHdvdWxkIGJlIGJ1Z2d5
LiAgV2hpbGUgaW4gdGhlIG5mc2QNCj4+PiBtb2R1bGUgY29kZSB3ZSBuZWVkIHRvIGJlIGhvbGRp
bmcgZWl0aGVyIHJjdSBvciBhIHJlZiBvbiB0aGUgc2VydmVyIGVsc2UNCj4+PiB0aGUgY29kZSBj
b3VsZCBkaXNhcHBlYXIgb3V0IGZyb20gdW5kZXIgdGhlIENQVS4gIFNvIGlmIHdlIGV4aXQgd2l0
aG91dA0KPj4+IGEgcmVmIG9uIHRoZSBzZXJ2ZXIgLSB3aGljaCB3ZSBkbyBpZiBuZnNkX2ZpbGVf
YWNxdWlyZV9sb2NhbCgpIGZhaWxzIC0NCj4+PiB0aGVuIHdlIG5lZWQgdG8gcmVjbGFpbSBSQ1Ug
KmJlZm9yZSogZHJvcHBpbmcgdGhlIHJlZi4gIFNvIHRoZSBjdXJyZW50DQo+Pj4gY29kZSBpcyBz
bGlnaHRseSBidWdneS4NCj4+PiANCj4+PiBXZSBjb3VsZCBpbnN0ZWFkIHNwbGl0IHRoZSBjb21i
aW5lZCBjYWxsIGludG8gbXVsdGlwbGUgbmZzX3RvDQo+Pj4gaW50ZXJmYWNlcy4NCj4+PiANCj4+
PiBTbyBuZnNfb3Blbl9sb2NhbF9maCgpIGluIG5mc19jb21tb24vbmZzbG9jYWxpby5jIHdvdWxk
IGJlIHNvbWV0aGluZw0KPj4+IGxpa2U6DQo+Pj4gDQo+Pj4gcmN1X3JlYWRfbG9jaygpOw0KPj4+
IG5ldCA9IFJFQURfT05DRSh1dWlkLT5uZXQpOw0KPj4+IGlmICghbmV0IHx8ICFuZnNfdG8uZ2V0
X25ldChuZXQpKSB7DQo+Pj4gICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7DQo+Pj4gICAgICAgcmV0
dXJuIEVSUl9QVFIoLUVOWElPKTsNCj4+PiB9DQo+Pj4gcmN1X3JlYWRfdW5sb2NrKCk7DQo+Pj4g
bG9jYWxpbyA9IG5mc190by5uZnNkX29wZW5fbG9jYWxfZmgoLi4uLik7DQo+Pj4gaWYgKElTX0VS
Uihsb2NhbGlvKSkNCj4+PiAgICAgICBuZnNfdG8ucHV0X25ldChuZXQpOw0KPj4+IHJldHVybiBs
b2NhbGlvOw0KPj4+IA0KPj4+IFNvIHdlIGhhdmUgMyBpbnRlcmZhY2VzIGluc3RlYWQgb2YgMSwg
YnV0IG5vIGhpZGRlbiB1bmxvY2svbG9jay4NCj4+IA0KPj4gU3BsaXR0aW5nIHVwIHRoZSBmdW5j
dGlvbiBjYWxsIG9jY3VycmVkIHRvIG1lIGFzIHdlbGwsIGJ1dCBJIGRpZG4ndA0KPj4gY29tZSB1
cCB3aXRoIGEgc3BlY2lmaWMgYml0IG9mIHN1cmdlcnkuIFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rp
b24uDQo+PiANCj4+IEF0IHRoaXMgcG9pbnQsIG15IGNvbmNlcm4gaXMgdGhhdCB3ZSB3aWxsIGxv
c2UgeW91ciBjb2dlbnQNCj4+IGV4cGxhbmF0aW9uIG9mIHdoeSB0aGUgcmVsZWFzZS9sb2NrIGlz
IGRvbmUuIEhhdmluZyBpdCBpbiBlbWFpbCBpcw0KPj4gZ3JlYXQsIGJ1dCBlbWFpbCBpcyBtb3Jl
IGVwaGVtZXJhbCB0aGFuIGFjdHVhbGx5IHB1dHRpbmcgaXQgaW4gdGhlDQo+PiBjb2RlLg0KPj4g
DQo+PiANCj4+PiBBcyBJIHNhaWQsIEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBhIG5ldCB3aW4sIGJ1
dCByZWFzb25hYmxlIHBlb3BsZSBtaWdodA0KPj4+IGRpc2FncmVlIHdpdGggbWUuDQo+PiANCj4+
IFRoZSAid2luIiBoZXJlIGlzIHRoYXQgaXQgbWFrZXMgdGhpcyBjb2RlIHNlbGYtZG9jdW1lbnRp
bmcgYW5kDQo+PiBzb21ld2hhdCBsZXNzIGxpa2VseSB0byBiZSBicm9rZW4gZG93biB0aGUgcm9h
ZCBieSBjaGFuZ2VzIGluIGFuZA0KPj4gYXJvdW5kIHRoaXMgYXJlYS4gU2luY2UgSSdtIG1vcmUg
Zm9yZ2V0ZnVsIHRoZXNlIGRheXMgSSBsZWFuIHRvd2FyZHMNCj4+IHRoZSBtb3JlIG9idmlvdXMg
a2luZHMgb2YgY29kaW5nIHNvbHV0aW9ucy4gOy0pDQo+PiANCj4+IE1pa2UsIGhvdyBkbyB5b3Ug
ZmVlbCBhYm91dCB0aGUgMy1pbnRlcmZhY2Ugc3VnZ2VzdGlvbj8NCj4gDQo+IEkgZGlzbGlrZSBl
eHBhbmRpbmcgZnJvbSAxIGluZGlyZWN0IGZ1bmN0aW9uIGNhbGwgdG8gMiBpbiByYXBpZA0KPiBz
dWNjZXNzaW9uICgzIGZvciB0aGUgZXJyb3IgcGF0aCwgbm90IGEgcHJvYmxlbSwganVzdCBiZWlu
ZyBwcmVjaXNlLg0KPiBCdXQgSSBvdGhlcndpc2UgbGlrZSBpdC4uIG1heWJlLi4gaGVoLg0KPiAN
Cj4gRllJLCBJIGRpZCBydW4gd2l0aCB0aGUgc3VnZ2VzdGlvbiB0byBtYWtlIG5mc190byBhIHBv
aW50ZXIgdGhhdCBqdXN0DQo+IG5lZWRzIGEgc2ltcGxlIGFzc2lnbm1lbnQgcmF0aGVyIHRoYW4g
bWVtY3B5IHRvIGluaXRpYWxpemUuICBTbyBOZWlsJ3MNCj4gYWJvdmUgY29kZSBiZWNhbWVzOg0K
PiANCj4gICAgICAgIHJjdV9yZWFkX2xvY2soKTsNCj4gICAgICAgIG5ldCA9IHJjdV9kZXJlZmVy
ZW5jZSh1dWlkLT5uZXQpOw0KPiAgICAgICAgaWYgKCFuZXQgfHwgIW5mc190by0+bmZzZF9zZXJ2
X3RyeV9nZXQobmV0KSkgew0KPiAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsNCj4g
ICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOWElPKTsNCj4gICAgICAgIH0NCj4gICAg
ICAgIHJjdV9yZWFkX3VubG9jaygpOw0KPiAgICAgICAgLyogV2UgaGF2ZSBhbiBpbXBsaWVkIHJl
ZmVyZW5jZSB0byBuZXQgdGhhbmtzIHRvIG5mc2Rfc2Vydl90cnlfZ2V0ICovDQo+ICAgICAgICBs
b2NhbGlvID0gbmZzX3RvLT5uZnNkX29wZW5fbG9jYWxfZmgobmV0LCB1dWlkLT5kb20sIHJwY19j
bG50LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNyZWQs
IG5mc19maCwgZm1vZGUpOw0KPiAgICAgICAgaWYgKElTX0VSUihsb2NhbGlvKSkNCj4gICAgICAg
ICAgICAgICAgbmZzX3RvLT5uZnNkX3NlcnZfcHV0KG5ldCk7DQo+ICAgICAgICByZXR1cm4gbG9j
YWxpbzsNCj4gDQo+IEkgZG8gdGhpbmsgaXQgY2xlYW5zIHRoZSBjb2RlIHVwLi4uIGZ1bGwgcGF0
Y2ggaXMgaGVyZToNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvc25pdHplci9saW51eC5naXQvY29tbWl0Lz9oPW5mcy1sb2NhbGlvLWZvci1uZXh0LnYx
NS13aXRoLWZpeHVwcyZpZD1lODUzMDY5NDE4NzhhODcwNzAxNzY3MDJkZTY4N2YyNzc5NDM2MDYx
DQo+IA0KPiBCdXQgSSdtIHN0aWxsIG9uIHRoZSBmZW5jZS4uIHNvbWVvbmUgaGVscCBwdXNoIG1l
IG92ZXIhDQoNCkkgd2Fzbid0IGV4cGVjdGluZyBpdCB3b3VsZCBiZSBsZXNzIHVnbHksIGJ1dCBp
dCBkb2VzIGxvb2sNCmhhcmRlciB0byBzY3JldyB1cCBkb3duIHRoZSByb2FkIHdoZW4gd2UndmUg
Zm9yZ290dGVuIHdoeQ0KdGhlIEFQSSBsb29rcyB0aGlzIHdheS4NCg0KDQo+IFRhbmdlbnQsIGJ1
dCBpbiB0aGUgcmVsYXRlZCBidXNpbmVzcyBvZiAid2hhdCBhcmUgbmV4dCBzdGVwcz8iOg0KPiAN
Cj4gSSB1cGRhdGVkIGhlYWRlcnMgd2l0aCB2YXJpb3VzIHByb3ZpZGVkIFJldmlld2VkLWJ5OnMg
YW5kIEFja2VkLWJ5OnMsDQo+IGZpeGVkIGF0IGxlYXN0IDEgY29tbWl0IGhlYWRlciwgZml4ZWQg
c29tZSBzcGFyc2UgaXNzdWVzLCB2YXJpb3VzDQo+IGZpeGVzIHRvIG5mc190byBwYXRjaCAocmVt
b3ZlZCBFWFBPUlRfU1lNQk9MX0dQTCwgc3dpdGNoZWQgdG8gdXNpbmcNCj4gcG9pbnRlciwgdXBk
YXRlZCBuZnNfdG8gY2FsbGVycykuIEV0Yy4uLg0KPiANCj4gQnV0IGlmIEkgZm9sZCB0aG9zZSBj
aGFuZ2VzIGluIEkgY29tcHJvbWlzZSB0aGUgcHJvdmlkZWQgUmV2aWV3ZWQtYnkNCj4gYW5kIEFj
a2VkLWJ5Li4gc28gSSdtIGxlYW5pbmcgdG93YXJkIHBvc3RpbmcgYSB2MTYgdGhhdCBoYXMNCj4g
dGhlc2UgaW5jcmVtZW50YWwgZml4ZXMvaW1wcm92ZW1lbnRzLCBzZWUgdGhlIDMgdG9wbW9zdCBj
b21taXRzIGhlcmU6DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3NuaXR6ZXIvbGludXguZ2l0L2xvZy8/aD1uZnMtbG9jYWxpby1mb3ItbmV4dC52MTUt
d2l0aC1maXh1cHMNCj4gDQo+IE9yIGlmIHlvdSBjYW4gcmV2aWV3IHRoZSBpbmNyZW1lbnRhbCBw
YXRjaGVzIEkgY2FuIGZvbGQgdGhlbSBpbiBhbmQNCj4gcHJlc2VydmUgdGhlIHZhcmlvdXMgUmV2
aWV3ZWQtYnkgYW5kIEFja2VkLWJ5Li4uDQoNCkZvciB0aGUgdGhyZWUgdG9wbW9zdCBwYXRjaGVz
IGluIHRoYXQgYnJhbmNoOg0KDQpSZXZpZXdlZC1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVy
QG9yYWNsZS5jb20gPG1haWx0bzpjaHVjay5sZXZlckBvcmFjbGUuY29tPj4NCg0KSFRIDQoNCg0K
PiBZb3UgY2FuIGFsc28gc2VlIGluY3JlbWVudGFsIGRpZmYgZnJvbSAudjE1IHRvIC52MTUtd2l0
aC1maXh1cHMgd2l0aDoNCj4gZ2l0IHJlbW90ZSB1cGRhdGUgc25pdHplcg0KPiBnaXQgZGlmZiBz
bml0emVyL25mcy1sb2NhbGlvLWZvci1uZXh0LnYxNSBzbml0emVyL25mcy1sb2NhbGlvLWZvci1u
ZXh0LnYxNS13aXRoLWZpeHVwcw0KPiANCj4gRWl0aGVyIHdheSwgSSBzaG91bGQgcG9zdCBhIHYx
NiByaWdodD8gIFNPIHF1ZXN0aW9uIGlzOiBzaG91bGQgSSBmb2xkDQo+IHRoZXNlIGluY3JlbWVu
dGFsIGNoYW5nZXMgaW4gdG8gdGhlIG9yaWdpbmFsIG9yIGtlZXAgdGhlbSBzcGxpdCBvdXQ/DQo+
IA0KPiBJJ20gZ29vZCB3aXRoIHdoYXRldmVyIHlvdSBndXlzIHRoaW5rLiAgQnV0IHdoYXRldmVy
IGlzIGRlY2lkZWQ6IHRoaXMNCj4gbmVlZHMgdG8gYmUgdGhlIGhhbmRvZmYgcG9pbnQgdG8gZm9j
dXNlZCBORlMgY2xpZW50IHJldmlldyBhbmQgaG9wZWZ1bA0KPiBzdGFnaW5nIGZvciA2LjEyIGlu
Y2x1c2lvbiwgSSd2ZSBwaXZvdGVkIHRvIHdvcmtpbmcgd2l0aCBUcm9uZCB0bw0KPiBtYWtlIGNl
cnRhaW4gaGUgaXMgZ29vZCB3aXRoIGV2ZXJ5dGhpbmcuDQoNCg0KLS0NCkNodWNrIExldmVyDQoN
Cg0K

