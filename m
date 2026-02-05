Return-Path: <linux-fsdevel+bounces-76499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPVfIv0ihWnM8wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 00:08:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9022F845B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 00:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C328A300EA87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 23:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1623382C7;
	Thu,  5 Feb 2026 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DvMr2RUx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5861DFD96;
	Thu,  5 Feb 2026 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770332917; cv=fail; b=umyUoYwMvkmqvzQTssSVuthYsYQHq9oYpNFpsUUxYvck2Qdt2zc30xKzAZ/OF0rlkkgt8V0S+i5DJSCbRYdMtp6Mb8Aj9wLmi/xXM0E/+GMW2OCSKppgiVJ3TivPoetfaWZBUzFgzaHjyvFzjQRIj+hZX0FUoT4iMYow4FLClZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770332917; c=relaxed/simple;
	bh=zh2DVc30ZWuWsqWE137Y8WrQDSzQZXF3Z6Nw6+bPYmE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=XAZedtMTc8I3aVn/EdqFaxgo9VHFSDyJ90u9A3dhrSK215dP+ThW91hB0pO5ZqHGN6PhuySrA2TH/3SRybIiWrv2pNAEPcX/wblLS8/qcLmakV+eedambkiBFNTVtCYPCsz21mQaJxE+y3djycX6/z866QLbFReDYoqltzyBr+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DvMr2RUx; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 615MlYPW027015;
	Thu, 5 Feb 2026 23:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=zh2DVc30ZWuWsqWE137Y8WrQDSzQZXF3Z6Nw6+bPYmE=; b=DvMr2RUx
	Uo4Z88vcqR91w85TT7Tj73cbaASwovcYY3GV9KVlIbfgofP+sckUG0etU7gZamQs
	kiAPMcmNmvrV8NfCXCmGsLt9AZUrb+x58E+/2NIlip+QQSmk5Ryvi7C6PhDR2cFK
	8j3hV7OtANb6oM4c2otDI/daElSekxLLP9P3cvhhBJM1jQBdO20zuldj0p2uLlWt
	0/0jlS6fjqGdS+KlRwtDTfbESZ8Awyg+pOxb4/w8ihPvV8L2nFuzbqq6Qibx/lp5
	/xLCbnZ5TzPZDmNDiFVbnTKYxYq5Xi2oqM9EnCGOyp1I3J58kDplf/Xa7YyXeOeE
	W/jWFpCqUpR4FQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cwe35v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 23:08:20 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 615N8Jcv027835;
	Thu, 5 Feb 2026 23:08:19 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cwe35r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 23:08:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqe6hUq9Q1QvQWlmn6UGBCRCJc9JiIUVnmuqr/B7ommkY8A1P4GWeMp4T8BBtBwRHAryvP8kjKy2kD3EBImDz5ypEYpQSmD/7HTgAS6HJFB5hGlTRgoYR1LWuzEq03KiVidLwkM1B5h7+cxwJt9LnQAW2S9V8ODDlY4Ee2O1VBcAB6nzi5TsGvO8KQiH9rmiZ0C+tObGMyZkGWPwAX1QdMBMgvXUO6KrTE3r92xFqXPfTlIq+VTl/Y3I6WxD67ZoEJ/0XJL6+SOOz1bULBGxBMD3L6s3nt+7/hz/3Ig3U1T1DGRXJeI3UI2lcd+nMB31eCHZ1sHX+52OzASWCOgCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh2DVc30ZWuWsqWE137Y8WrQDSzQZXF3Z6Nw6+bPYmE=;
 b=G78hIN1YwXkEszXetjfw65cl5WRSUlF0CoSUuqaZeT6xonwx19lbFJNr8a2TclyOL4fZGMbCshoTE7Sei0ktJb4FSPCAL+beTjhp9aBSS4non6acjyKVgNZRyG6ttBsoeRwn4vxEcHpmDWDfG6q/1kfEot/REElm49tS4m7eWXyrLeFxaHqGPd12cyTbRikcNo8ALI/45PNRdcahcaIdZPxWgtpPO3kobTMjM/keUDF5PSl5T816HQlvKSLm7WyCruoBmNER5XfKejat0QTxbpzT64+mMxXEdOwai9CG8Qzo/mVIrs/022iSWkz9FtWXbO1JzViL1y3K30pVpwvyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB5511.namprd15.prod.outlook.com (2603:10b6:208:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 23:08:17 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 23:08:17 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>
CC: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "brauner@kernel.org" <brauner@kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] hfsplus: avoid double unload_nls() on mount
 failure
Thread-Index: AQHclfjHEDDNtBvzV0GWhSKb+kVnKbV0vKwA
Date: Thu, 5 Feb 2026 23:08:16 +0000
Message-ID: <e43a62e755600326b94ca2be3aa035bdf75c9594.camel@ibm.com>
References:
 <4375f20e2b0d3507a0209f7129e00d360d3eb32c.camel@mpiricsoftware.com>
	 <20260204170440.1337261-1-shardul.b@mpiricsoftware.com>
In-Reply-To: <20260204170440.1337261-1-shardul.b@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB5511:EE_
x-ms-office365-filtering-correlation-id: 48eb60cf-ae46-4225-794f-08de650b7251
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjVDUXZMdjlGSjVOZXZSWk5FdVEwWDRhcUxMcFliVWNaTXN3My9yN1B2eWRE?=
 =?utf-8?B?WmtGbGEwVXpZdW9neU9ON09hbWVvUUZ1cThnS0FQa21peHc0QnVRa1VHczBP?=
 =?utf-8?B?VFU1dnRQQm43b0lqR1p2KzNGaEgwNDM0SUJLVGlGR0lRWkRGZEliZXJLMkpF?=
 =?utf-8?B?UG5HdlhqeEpnRStsZDFrS3I0SEZTTlFrZGhDeWs2b1JXT0hKZmtDNE02YUVx?=
 =?utf-8?B?b0p0YlBSVGZpWWhPRU5LZklTWHZaR2NNb2xpcThNVEVKNkgyVTNnUXNLM3Vl?=
 =?utf-8?B?UGoyei91VG43cGkybGh5QkVjYjFpa09EQTdFbTd2S2tjaXF1OWNGMk1HU2Jr?=
 =?utf-8?B?M011SWNNbFU5Sms5MUhVNEtxT1R1TWtMQlBsRkU2Qk56T0FpNitlem9DaDZq?=
 =?utf-8?B?NWUrRzVISWxHdXFJUGdscXVSSUgwZ21zTHR0NDhaOWk4d05rWUEyOVJFbnB6?=
 =?utf-8?B?d3NTYUR0aDRrUmVjelRTb3JtSzlQUU1FS2wxSXIxLzI4eGRDKzUrSWZoTEVC?=
 =?utf-8?B?VUNib3ZKTWJVdkszejhJWTBlb0ord3NSL21nUEhDaGZhMHpvVHJscVE4OERr?=
 =?utf-8?B?MTU0dWMzaVpXbUk0KzVMVzlSeDR2Y3VESXdCNURnUzBGMEFzVi9lcVNIcVRV?=
 =?utf-8?B?aGx4V1BRQlRTakQ5MHFaTXI5eU1adW8xV2NXY09jZGVYVTBiaW8xN0VFMU1Z?=
 =?utf-8?B?WEkyZFlWSXlKWnI4MTE2SVIwbkZLV0phT1hPbHdaNDFCTTRiVDRzTWJFNk1M?=
 =?utf-8?B?Zk5WSFdPOXJNemlkMmhXS1hpK3FLMFNNenZFY2drYnNNeW81OGdaN0U2ZmNP?=
 =?utf-8?B?SzI1bE1XcXlGR2trM050QW1kQXdWdVRrSEV4enlnT05ibllHOTlBL1hkNDZ3?=
 =?utf-8?B?ZE1CUFMvTVpYTlNCWHRHMDlEZW92ZWdXdU9xZDljK3F3VmZuWVpuaXVueUND?=
 =?utf-8?B?bHJSbUg5Y1lKcUpQY0hFWndwNERhdWtqdElSaWo3K05FTkkxSi9wYmdsTk5s?=
 =?utf-8?B?OVNWUHBYci9zdTdRbkVUWXdHM2xyN0VUcHJoaUZLT2tmQm9LRitaSFVmVVEy?=
 =?utf-8?B?clJjRklKZEw1SUl0bncrUEUvMUNlMHc2Ky9TT0l6elpTU0FEVnN3cENZWXlI?=
 =?utf-8?B?S0Z6L0hCcWROVThoTGh1QlZLeTh1V3dRcTN6SnZib0tqUHhmV1ZqU3ovaFhj?=
 =?utf-8?B?YzVBQUdvTEV5aXdiZVlTeDFpRUw3QU9QekxqNGFEbDE5bllVU3FXSlJ3bVFs?=
 =?utf-8?B?M0JycmFKM0JscDNKVVBCQWZGVStJUURmeVg5ZTZhWjF0dGQybGpMWWUxN2E3?=
 =?utf-8?B?b080TGtHWWFCU3AyUjNuNm5RZFZQdk1xcE9PUFk4bjFsTmVHd2VzUW43NFBG?=
 =?utf-8?B?QkFwQitRKzB3R2lEM0c5T2xBcjlnU0JPbmpUMXF6a3RPRUhBYlRrTXFXRFNN?=
 =?utf-8?B?OVNrUzhvaHp3TEZJZWZVRVgvUnBrckM5dlRFMzlWbEV1SDZxOVFEQVJsK2tt?=
 =?utf-8?B?NzVDTys2aE13V0llU2duK0pPY2FxSzJIblh5bXdDeVVXVENCNFdLUnhxUERW?=
 =?utf-8?B?NmI1YXB2UFhCZ1RRRURaQzlFT3dmdHE3bEdhNWNYT3RqTExnaGgxSnJJVVQ1?=
 =?utf-8?B?Z3hlOWtZYW9aMGg4R1I2aTJnZVg0ODV0WnIvWkNFYndzd3FINkdwS1ZZVkc0?=
 =?utf-8?B?eTlGQzhBWldzaVI2bWpQN2kvWTF4djg1RmM2K016eVBrS2ZhY21vQlVFOXRZ?=
 =?utf-8?B?K1JTRU5NNWFzanRPdnZkelJTWVZ6OThDTnZCSG5FQlVhNDJkMHJGUGxhKzh3?=
 =?utf-8?B?QU1yK2g5V1pxMk93TkJpUmFpRDJpbzA4UFloaEZGQjA0cXZrUERGajQ2OGwz?=
 =?utf-8?B?MHVKQ0pBNFVGQjY5OXhCTm9McjNSTGpTTm9RKzh4VjRpaEVpRDZCQ2lXRTd1?=
 =?utf-8?B?NHpRV0p3dXlkREdGL1hFY3VTRmIwZnRYcEpoWnZ1Y0c3dkR5dlpJUkRObmxN?=
 =?utf-8?B?d2QzaUVHcFROV1ZvWHBhYTA4SVRMcHpNOW5tTUdYT1J2RmgwTEErTFFVQmNo?=
 =?utf-8?B?YnphSmtqZWFNR250NDR5Z0xtZHcvRDUzK3JPZlAzdGxwdG9aa0RVNlJHR05i?=
 =?utf-8?B?NzJBQVkvczlaZ09sZUhLUzZLWlg2dlJzV0ZqZ1ZpU1NZV2lBNm1XL3dLcU9s?=
 =?utf-8?Q?lC16DsmVZk7PgVXnJF4HD0I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFNRdkVyTCtzYUg4THZaVm9nbW1wdzg5VWdRNnczdmhneTFCMUNsYURaSlFr?=
 =?utf-8?B?T09tcFl6SnlQbjdXeVZzWjNnWmxlWUpsS24vOWFqdUNHMWo3RTcrcFRqY29r?=
 =?utf-8?B?d3M1TTFIcndsVWJ2L2tlWnllVlFqQmpwR0lrQThPYTAwWU5Yei9TQkR2NlpT?=
 =?utf-8?B?SUNUUWJoaXRpS3hOa1hLQ0pkd2dXSlRLRU1BS2pndVpHajFMbVMxQkJZNm1s?=
 =?utf-8?B?S3NzN1pPQ3lldHNqcUc0MVI2ZnM5ZW1kSk9Ra0Evay9QMHc1WEp4VFhkRTZY?=
 =?utf-8?B?b0swcWdmUE9QWDNxRFV2c1FKemVRcEdXT284dE4vQUErM1l3LzlWVE1FU0lL?=
 =?utf-8?B?STdyZ3JsTnlUaUUvTGpuTko2SEFlaGxrdXZZMVlxRFhEUEJUM2dsOXZzWCtU?=
 =?utf-8?B?MGJGTUxtQm1JWTE2UXlCNHZObTFPVVVqYUFCQ0poVEpBZ2Q3ZTlhZytQbVJH?=
 =?utf-8?B?TFdJWno1UEIrVTJ4NkRScmYxOURjbFlBUml3ZXd1TlBCRXdOQ2ZRMkRqbG1S?=
 =?utf-8?B?M21mdGltbjY4UEUvS2ExbDFhOXY3dFI4RVd4bXFMTlZMODg2cG4zUFRBRHoy?=
 =?utf-8?B?dlpHU2pzTWppTkZBRmt2Z2JQOEtjUXFFOGk0amQ1Yk5ab0pXVmJ0RUVBeTFk?=
 =?utf-8?B?VUZPSTgwMHN6THJaemRnZHM2VFFXZElOeHh0dU9nOUJ6eVUyVnpnNSs5ZXZH?=
 =?utf-8?B?TmlCRjJsT3RFLys0R0l2OEZFWW1oMUxwdnBtMW9keEVRcVAwTThwQnhrUG9Y?=
 =?utf-8?B?b29YYUxPclVMaVRPd0lKbTQrdHBwNDFWRXh5RkJ2c0NKR1ZtbU5vTDJDUVBG?=
 =?utf-8?B?MEdZcUZsZVJ6OU05eGtwWFRTU0U1VGtHNWF3dEpPazhGMldpVFJUOWVvN3dp?=
 =?utf-8?B?QWNjdXg4Sy9oWStRc1NubnV2cGNMOWlTcXpjNS9aRG1IQndhd3JRZDE2anpu?=
 =?utf-8?B?dDR6NDcxQXFhcDJ3b2xXNXQxalNiS2w4M1lvNElBMEpCMkFaaWJOcDJCMnVZ?=
 =?utf-8?B?VmVEdnRBUEY0MUl5elRkN1BzZWlSS0JGNFRIYmE0eDVDQ25id3dzRjR3Zllh?=
 =?utf-8?B?Z1V3cTF1QU5aQlVxVFVsZzFXMVBFTlQ4UzhCc2lvWkdqK2hlejVzZXAramcy?=
 =?utf-8?B?cmFBYlpYV2ZKWlNreDJMVmQ2UlFRa05JazFqTE12a0N1RVdKblhLb1dmNzg2?=
 =?utf-8?B?OUpLZDBRYWk2dXdlY3lqemNXblM0SFFkaStXSklpS3d0N3FHa09QWGh4eGRx?=
 =?utf-8?B?RGU4cHliSXJmd1k0Qjl0SDZ5M2k3TG5qNEpjUDQ2S2JkbUN1SnNpSjlPR3Qv?=
 =?utf-8?B?RllTbGdacldXdm4zOUR2RitBYlVLaGFocXhIdHMxMm15ZzZHRG5COU9NdDR3?=
 =?utf-8?B?RTZlc3pPQUVMdTlzMklNSFhoZ1VjeExQZ25MRzRqKzRFYklqSHIvRTRRZC9q?=
 =?utf-8?B?WTNleWVuWDFCYS9Iak8vc01mWUdBZ1pRaWRySGFOcUVNSk5UNHBtV0l5My9N?=
 =?utf-8?B?cmVKa3AzUTF5UW5hODlWZE5rNnAycDdraC84V0lzL09jeXQ3RkZKYlFNQlhE?=
 =?utf-8?B?bjQwN2kxMzFIaElzU0w2QUd2UEV5d1VvK2diZnlIWEgxVk5ERi9KU3dLdE9B?=
 =?utf-8?B?SGhoalphY2xqZ0Q2bzl4RjdlY0NRRS8yM0ZNbkNLalZDbHE2OWhndnY2Yk1N?=
 =?utf-8?B?SUl3WTF3S1pxSkNuR3ZwMEU5b2hUeEhPcFdhcWFGQjdrZVk1S2w5ZUhnUWhm?=
 =?utf-8?B?TWR4NEFUMmtLSWh4cHJoeXlIT0dBVFNtOWFsN0pkS00zd0JjZDN2MHRNemVH?=
 =?utf-8?B?UXphSFhWY1BOaFptY0VRZk94cE5RaS9rSGpYcVgrZnBkNzdTVUJsNEFXM2NV?=
 =?utf-8?B?eDdSM2o0emcweUd1enBXenUzT3VmYTRIRE90NmJhdEhLSlJaeVFTUTFrT2o4?=
 =?utf-8?B?Yk90eUIwaDk4Tnp5WDhvU0hnQW5IUjJqRjNzbU54Z1pPSkcvY3JDZXNQd1Ry?=
 =?utf-8?B?d1lUSlJTYnhXV0NhZEMxbG12RnhZTW15RzJkTEhqYlNuY1pIRi9QVURMWFdk?=
 =?utf-8?B?eCtCcExHd2xYT3ZsVm45SmFsS2IzNXhmNmlZYlFWT09LSVh3TUx6dXlVVUQ0?=
 =?utf-8?B?d1VkdUFacG1mbldjZTB1dlczbTkvcnlibkg5Mjdwb25YT3RqMDFNWGR5cHIr?=
 =?utf-8?B?bHVnU1ZHQkxUbUl6dEJHdzI1WTVxcEt6d0lybm94Vlc0QTNWWlUyV0diV0Ey?=
 =?utf-8?B?OHdZbGJodnlieU9acGJhWERhZVE5eWxjNTR0eWdoajBzQlJGQjlVY0ViQkEw?=
 =?utf-8?B?QWJoMncxNDJTeHo0Y1c0U1FLRjdKdEZldWo2djNXbXlIR2c1a1B2TDN4b0t1?=
 =?utf-8?Q?C9NhZlpMyG6orVPmMuo574SDPLt9v3Q8L6S1f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6504D91FC5D5FF49B9F0FBA33F52E99A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48eb60cf-ae46-4225-794f-08de650b7251
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 23:08:16.9396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ytu18A+or+PUw7eN9Kp2PdU3vvqQnqlp5hCYiBLjiSAWVPE/uswrDk5kFGg8ts9NldvGJHeMJIbOsX2Sw6bQBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5511
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE3NSBTYWx0ZWRfX0g+kPBFbxLu4
 JXDSBdBgmSTwd6p0RS6LRVCCInrSqwpjTFZ+OP2F5ONPFaWTurfl941eMM1zTtZMcVfcU6k7hlD
 QSWg/6fKc0cDMRAqTzxSQe2bvgSx0pT8aFZP/hpwPuf4d7F9R5OECExWg7iwYbYHiQF+tktr2Lc
 ORZvhWKgOsDjJYt9aDwJf8wkhLvRAuiPhKxrWugxmclm7sVUCpFBDcAx7e+lbmVHYCOZIz8J5li
 rs+bhPFZD8I/pzoieGYhkZ/HAwa1L+95LN3jLIiuI/py3ZjkulXp5UFA0q4FxzMMRZ9TI/FQdlW
 2XDC19D1Xxox/vu5UIgvQ/usJDsau3iG+1aYxtv9chTa1UJhak/JWf01FI6fKkWd/1g+Y2uD7Ju
 kahJLzsTZsj3tL2OeTDKoQQUxz9yjRxfpXaVfkvVfZXHxMNR3nmROhLuV1uCnZWO1yKVZD3DLOm
 cgUmiQiZex39e9uZdLQ==
X-Authority-Analysis: v=2.4 cv=UuRu9uwB c=1 sm=1 tr=0 ts=698522e4 cx=c_pps
 a=qSv8Sft3UEt4GReRCOm4JQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=drOt6m5kAAAA:8
 a=szKgq9aCAAAA:8 a=wCmvBT1CAAAA:8 a=AlgK0z1frHBggaYPLK4A:9 a=QEXdDO2ut3YA:10
 a=RMMjzBEyIzXRtoq5n5K6:22 a=R_ZFHMB_yizOUweVQPrY:22 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: b5UTZzsLYKFZUcGBqPU_d6HhweX6chf9
X-Proofpoint-GUID: oPIto6KA2uK4ef4kSwVI4QEug08sC21X
Subject: Re:  [PATCH] hfsplus: avoid double unload_nls() on mount failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_06,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-76499-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,gmail.com,dubeyko.com,zeniv.linux.org.uk,vger.kernel.org,vivo.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D9022F845B
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTA0IGF0IDIyOjM0ICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gVGhlIHJlY2VudCBjb21taXQgImhmc3BsdXM6IGVuc3VyZSBzYi0+c19mc19pbmZvIGlzIGFs
d2F5cyBjbGVhbmVkIHVwIg0KPiBbMV0gaW50cm9kdWNlZCBhIGN1c3RvbSAtPmtpbGxfc2IoKSBo
YW5kbGVyIChoZnNwbHVzX2tpbGxfc3VwZXIpIHRoYXQNCj4gY2xlYW5zIHVwIHRoZSBzX2ZzX2lu
Zm8gc3RydWN0dXJlIChpbmNsdWRpbmcgdGhlIE5MUyB0YWJsZSkgb24NCj4gc3VwZXJibG9jayBk
ZXN0cnVjdGlvbi4NCj4gDQo+IEhvd2V2ZXIsIHRoZSBlcnJvciBoYW5kbGluZyBwYXRoIGluIGhm
c3BsdXNfZmlsbF9zdXBlcigpIHN0aWxsIGNhbGxzDQo+IHVubG9hZF9ubHMoKSBiZWZvcmUgcmV0
dXJuaW5nIGFuIGVycm9yLiBTaW5jZSB0aGUgVkZTIGxheWVyIGNhbGxzDQo+IC0+a2lsbF9zYigp
IHdoZW4gZmlsbF9zdXBlciBmYWlscywgdGhpcyByZXN1bHRzIGluIHVubG9hZF9ubHMoKSBiZWlu
Zw0KPiBjYWxsZWQgdHdpY2UgZm9yIHRoZSBzYW1lIHNiaS0+bmxzIHBvaW50ZXI6IG9uY2UgaW4g
aGZzcGx1c19maWxsX3N1cGVyKCkNCj4gYW5kIGFnYWluIGluIGhmc3BsdXNfa2lsbF9zdXBlcigp
ICh2aWEgZGVsYXllZF9mcmVlKS4NCj4gDQo+IFJlbW92ZSB0aGUgZXhwbGljaXQgdW5sb2FkX25s
cygpIGNhbGwgZnJvbSB0aGUgZXJyb3IgcGF0aCBpbg0KPiBoZnNwbHVzX2ZpbGxfc3VwZXIoKSB0
byByZWx5IHNvbGVseSBvbiB0aGUgY2xlYW51cCBpbiAtPmtpbGxfc2IoKS4NCj4gDQo+IFsxXSBo
dHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2xvcmUu
a2VybmVsLm9yZ19yXzIwMjUxMjAxMjIyODQzLjgyMzEwLTJEMy0yRG1laGRpLmJlbmhhZGpraGVs
aWZhLTQwZ21haWwuY29tXyZkPUR3SURBZyZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJ
bTRBWE16YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09bklSRlZCYlhrTzFVX1lB
c0JMVDZEaHN6LWt2TkNielZ5dVVVRml5elFmQUlYN3RmajZ6U3BiSF9nOHYwREpiViZzPTZ3WmhL
clFnQlRUN2FyZWxLZzdmZTFHejU5aExBWXh0bnpFRWR1RkRMR3MmZT0gDQo+IA0KPiBSZXBvcnRl
ZC1ieTogQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5vcmcudWs+DQo+IExpbms6IGh0dHBzOi8v
dXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwu
b3JnX3JfMjAyNjAyMDMwNDM4MDYuR0YzMTgzOTg3LTQwWmVuSVZfJmQ9RHdJREFnJmM9QlNEaWNx
QlFCRGpESTlSa1Z5VGNIUSZyPXE1YkltNEFYTXpjOE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZV
Z1NzMDAmbT1uSVJGVkJiWGtPMVVfWUFzQkxUNkRoc3ota3ZOQ2J6Vnl1VVVGaXl6UWZBSVg3dGZq
NnpTcGJIX2c4djBESmJWJnM9a0RpU0lxd29Ua0k4TWtWb2dOeGFmWTBkcDgwTXVaazB0LXdfRTRJ
NDBRUSZlPSANCj4gU2lnbmVkLW9mZi1ieTogU2hhcmR1bCBCYW5rYXIgPHNoYXJkdWwuYkBtcGly
aWNzb2Z0d2FyZS5jb20+DQo+IC0tLQ0KPiAgZnMvaGZzcGx1cy9zdXBlci5jIHwgMSAtDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3Bs
dXMvc3VwZXIuYyBiL2ZzL2hmc3BsdXMvc3VwZXIuYw0KPiBpbmRleCA4MjljOGFjMjYzOWMuLjVi
YTI2NDA0ZjUwNCAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9zdXBlci5jDQo+ICsrKyBiL2Zz
L2hmc3BsdXMvc3VwZXIuYw0KPiBAQCAtNjQ2LDcgKzY0Niw2IEBAIHN0YXRpYyBpbnQgaGZzcGx1
c19maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBmc19jb250ZXh0ICpm
YykNCj4gIAlrZnJlZShzYmktPnNfdmhkcl9idWYpOw0KPiAgCWtmcmVlKHNiaS0+c19iYWNrdXBf
dmhkcl9idWYpOw0KPiAgb3V0X3VubG9hZF9ubHM6DQo+IC0JdW5sb2FkX25scyhzYmktPm5scyk7
DQo+ICAJdW5sb2FkX25scyhubHMpOw0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQoNCk1ha2VzIHNl
bnNlIGFuZCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxz
bGF2YUBkdWJleWtvLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

