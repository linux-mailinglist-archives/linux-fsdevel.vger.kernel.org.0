Return-Path: <linux-fsdevel+bounces-31242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F3B9935B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41AE1F22814
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E071DDA3A;
	Mon,  7 Oct 2024 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IbpHSz2a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ywhogRqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF061DDC0D;
	Mon,  7 Oct 2024 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324583; cv=fail; b=TRv09FNYVLVwR1Xx7enp0djTMbvhIL/FI6RebIJI7RtUY1h60zN8tjiN49vSdscC0dL9QY0JLwzOdXWqoJ2vCH9QagqecrbJpIKUJbwQpNuVhd9ViAdzSwKCp7qy8gecvHxyVRcVzhXIj992cufw1L3ikqUCEEdEXiiFrcofCzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324583; c=relaxed/simple;
	bh=OfVF+wmUzl6ZxqyIKiU4j1iHoC+9VUl/fTPNiaASVOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=joA0B4DuHQDYkN4JcRGs+Wen/caX56Vj4YshWQFDcERRjoJbYhJxxqTXjXguNRTaEXktLGadMbHSshVRYhWx4WW/aKwKu4fK7SEyKyt5v0l6nEpxv1WasqxqdMl1Eh6RRkp+Ujuoh6YgCSyvmiF9p5p0lRupLn1nvlF+QjMKXD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IbpHSz2a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ywhogRqU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMfpn016454;
	Mon, 7 Oct 2024 18:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OfVF+wmUzl6ZxqyIKiU4j1iHoC+9VUl/fTPNiaASVOI=; b=
	IbpHSz2anq8b7kurEWqhQ5W+UJPtPueuSy/3wAjTbcsGcp9HTJcNcQwjxAHrICPM
	dh4buVvbRsHGMvAvBT3XOht20cWMrJLz3z5ZrRGiAUxhueNf3OasYSNWqU4TOEZj
	+6E1PlFNcF/nWndnzywLWCqCvjn/k5MD+9mHjqKowFZp9YNKC2lZ+LymsUTYMlz5
	JMkmuqVo0T3POV/rSIgiwuUMyp/8tCIBIMveO7sJ9F2ui5CSvyozsHCPmmLDvpHJ
	8J+jpUanbGsDXZJzxBJ9TLHMhwiwaPiQuiVR7d3SVsvHUtF2g7cXebypVQngSvi8
	ZFi336H38DQYzakZEPthRQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dm1cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 18:09:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497Gu0YU024144;
	Mon, 7 Oct 2024 18:09:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwcdjys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 18:09:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FR5ZxLovrriQOCXb9AdADbadgRB68DpAaQRt/sC1vKa91+ZSHII8JnRbX2kJGp/ZqH2T0WCWLO13LvSeYHhbBX2VzYhKKhf6RW/GMI2AS8Nov9GKPbOzDdEh7xXI0hDvcj7gMZEkvYkbSgeoN9qtBvHnqB6v41NHkyYyDFBkuC/6+HeSxAVqFiw0kujeIz6jvEdkyplqzcbSeRvcPKuDz4M3Q3J9be5MUE1v1Cg7GZdzZzOGb26HRSknUQzBd6rZUiLOSwdcAW1I4HzxF6+MdZ950RJVmg9W6LdlD1rl6XXMIYCH+wGpU1478gm7dW/pZucvKtHposh/ru0mLLDe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfVF+wmUzl6ZxqyIKiU4j1iHoC+9VUl/fTPNiaASVOI=;
 b=IHoAY3nw8M84rmiPH2ioQkemr4HJ9w7WtrBmGXgNWKB4DwmkQjxijYT87Cv6honjGv2F8W30ivhZPeGQCHJ3x07S3EiZpQmXPRJ5p1jUEALoJGId0aVWSmn3GST1ixc0zGaaB8Yzdlzv38E1bI5j1ehNU+U4V+5HHNhTWVL/1QNwTidgNTtzlhnF2/QrU1yU8iafTrSb6uxMP0nidQ4/E3N4oE63zwCswm0LOFsEd6+Nf7r57rkSSH1Rt4WqIjTruRBhH8Y5wFyDEWe+PPgJxBtRlkq+chRaRccJGpCirFVCiVJSMikMt5+6vmd/j50OTYFcE7UHwK3L48Hzd/b2PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfVF+wmUzl6ZxqyIKiU4j1iHoC+9VUl/fTPNiaASVOI=;
 b=ywhogRqU8FDrRbVRAWXQqjvPXjPqZRT2QUuarwe3ICC3DRRpcZma2CQArXVnhJ+NtJ8t5i5NakGli9bQ3w2wmk4FIhb7pSazKYa+PIlKEwOjDwBY11lJDp9T82MHu0rTUs1UsxLGBqBVt90NPbWTVYctpBU4U2SJZx9QWqeOfDE=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by LV3PR10MB8153.namprd10.prod.outlook.com (2603:10b6:408:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 18:09:28 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 18:09:28 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
        Linux
 FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/2] API for exporting connectable file handles to
 userspace
Thread-Topic: [PATCH v2 0/2] API for exporting connectable file handles to
 userspace
Thread-Index: AQHbDZKabcL6mUGCDU675RiVN1TFc7JoO1wAgBND/YCAAC2NgA==
Date: Mon, 7 Oct 2024 18:09:28 +0000
Message-ID: <F27FAEB3-666C-4063-A2AD-C5348146CAEF@oracle.com>
References: <20240923082829.1910210-1-amir73il@gmail.com>
 <20240925-seeufer-atheismus-6f7e6ab4965f@brauner>
 <CAOQ4uxiBwtEs_weg67MHP4TOsXN7hVi0bDCUe_C7b2tHqohtAQ@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxiBwtEs_weg67MHP4TOsXN7hVi0bDCUe_C7b2tHqohtAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|LV3PR10MB8153:EE_
x-ms-office365-filtering-correlation-id: 6b7e5aad-b296-4411-2cf6-08dce6fb2f24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFZkYXIveFNRbDhkbkVUSjZvaGhwbitTME9IT3JoTnQrYXdhdVJ2amk5ekMw?=
 =?utf-8?B?aGtRWlp2cWJHTXcwcThPNHBuZGpuNDNhRlFMNGxGNHBPMmxwaW1peWtTSmgx?=
 =?utf-8?B?eFRxeTdheE5DbEsrcVVNRnB0dmc4SHBpWDZvK29vR2hpWmpzc2dMczFncXVn?=
 =?utf-8?B?TEM3UEJFeDRNc3UyV0VBS2czZ2xUeHYwcDVCZW9wOHZmZ1VIUHFqMXBIYndF?=
 =?utf-8?B?Sm5aQlNWb2xPNFJwN1BNZW1LYkRmcVhoMkwrNFhNVVUrdFVuak80NWxlV3lZ?=
 =?utf-8?B?OEtYVjNxRllUcGNjeXV0NVdYb1JFeC9Qb1BGT21EOGdRYU1kL3lTWGFyYklo?=
 =?utf-8?B?d2VpYUs5NWNDK1R4NUNjMm5rRGpyMW9weUN4SkdPSUxOWVVkQUJMTzhYMDZM?=
 =?utf-8?B?Y2dwZ1hHakRZa0wxMXdBSXVvYnRVc2lhTGZ2Z1pELzBIU09xejRSa3F2OHVh?=
 =?utf-8?B?c0duQkNQUHVvRHNOR09zMk9FbStpU0JYeUhocThkd0QrbVg4Zzh3cHkvREFr?=
 =?utf-8?B?bEZKdEpZNll4ZkxDaDI3WlRVQkMva1JFS29GRHV4UGpWREE2THRaRlFkMW9Y?=
 =?utf-8?B?N0JqeGtWdWF3elFMMU1Fbm4raWVpM2pLMFNCeDJJQWdEcHJYVGFLYWlOQ1Y3?=
 =?utf-8?B?NWk1NnY1Sm1LcEJpZm9DbzFqeGxnd0dCaEJIY1VQcVhad1pjU2dta0VDQUVp?=
 =?utf-8?B?UjlReE1PSVdrZUVBYnRwWk5nSk93eE9VUnJremlLOElSb2lYdDV0ei9aWlBj?=
 =?utf-8?B?R2dZWTFqcFpDK2Izam50SWlPcGR6dlNMbnN3d3dTWGJXNDFBWDZiSmk3bnI3?=
 =?utf-8?B?S25yRUF3cDBJWW1zYkZLSWthZ1V1ZnNLcEJKY0wxQnpuUlp4WTR4Q1BXYWEz?=
 =?utf-8?B?YS8yVk81OGJYYWdNdkU0OGl4NGxPeEMxTkR2U2UrV1FiSGNBcFE1QzFwd1R2?=
 =?utf-8?B?MEtKMUdtUWNXQXVDMGZaMkQwcUtGMDZXNGlxNFNERXhaYytBNXBBcVFCSXhq?=
 =?utf-8?B?d0VXd3c4dkNaeUFKeGsxR3huTnB6UlRsRDd5M3pIcGpUOEJEN0pLRGQ0djNV?=
 =?utf-8?B?YjFRZEN0QllIdFhCWFA5Q3dYTWdTSndMN3pJakwreCtnc09GRmxCS2tkSmcy?=
 =?utf-8?B?UGJqMGJwanNONVpmdEZzSmtHOEdrcldaOWROWU1Lc0pUdUJ5SjBYTnRtU2Vt?=
 =?utf-8?B?c2VCZjA2bzR1aVg4a3RmUEhaTWJITzUxVXA4bUQwUTI5dExiWmVsT1JrYU5R?=
 =?utf-8?B?aUo4SzNsUnNSL1M0WkVkT2JyQTExeGp1OWlMeE5nTTF5a3hwUXhacHVkSnFC?=
 =?utf-8?B?bGQ5VlpZWDArMkFTS21QMkNjaG1hb1RZb2RVbHdGbXRVdGlNZ2JDblR5UmhD?=
 =?utf-8?B?WEpoaHdDaTlPcU5rV1dINS9QbGxoeVhaeEhnWmZTSWpRcDlJR3NOa2o0TldR?=
 =?utf-8?B?Y0JiSmVxLzFpYlpDaFRwckdXLzVsK2daMlR4YnVxQzM1N0VYWHU0bnhnWjVv?=
 =?utf-8?B?ZGd4YkxtNytwNDFGbXhENGRFSUpDcGN2anNIeEFYb2FDRFRaSW5EdFJGTDZH?=
 =?utf-8?B?bXhZekFPdDV5K3E0ZDhyc1ZPcWhyNDV0Z2dEYlV2M01scHM0UFdxNHorOG9F?=
 =?utf-8?B?S1RTRk0vTFNxOFlrK2pnL2UyQ1l5R05QbEdjWXF1S3pFb0d6ZmR3Z1NyRC9n?=
 =?utf-8?B?NmlMb3FUc2hnZHRDWWdTVVVEaHNWbzdVK3lzSUJZWG9IQ2xpMEw4S2xoTjZZ?=
 =?utf-8?B?SjE0TC8rclRDRzVmMm1aeFBFVGZlaUc3bnE1MlZ4Vy9IcS82K2lWeHVQMDFk?=
 =?utf-8?B?cE9ON29US1NxOTBVK3V3QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cm10c0thcVNka1RiTnlnSU1mVVRFcjhDKzJsaG1JUFFxd3hMUWpCVnYrUGsx?=
 =?utf-8?B?ZDRwTzZETTMrT0phQzJXYnpYM1NlYnBQbE8xQ0xPak9vR09EbUtjMG5hSG5W?=
 =?utf-8?B?WGY3SkV6bkRMWU5oVnFvWld3cllMUHFQMW5zK2RkWStjZlV1NkdzbHNrVk4z?=
 =?utf-8?B?OGhhdm1UQXQ0Tkp3V2gwejRRaXl0RTFiK2RNOU9tbERFS21qYmF0TlhJbG5w?=
 =?utf-8?B?WjdPbFpURnQyREJmTTRCaTc0Z1ZQak52SE1QaE8xN0YrdU1ONlBBa2thZmp1?=
 =?utf-8?B?RlE4T2lKbEQydy9zUEVPcnZkU0tRR0VDRDNDa01SVVVNQWlYTGlhVlAyQXNC?=
 =?utf-8?B?UjhRbW43T1BsWk5WQSt6ZVQ5djdkVml3cFVhT2Jnc3A0THNqeTE4QnZ5QUlu?=
 =?utf-8?B?Z2JkdWFFY093bng5TUpOUHpncjJ0Q3BuanhJYUhLQSswV0JxYkRkWXVCVCtR?=
 =?utf-8?B?cisxWWRJY1JiSGZGR0JFMHVUSG1FYXN0bk9ScFdBMHhhRndBMUZiamEya3VM?=
 =?utf-8?B?Q25CMmJlZDRnUGRVRDdXZTJMbG13M0JEeklSMGRscmF5bWc5ZkJmSnNHOWJ2?=
 =?utf-8?B?NXMvWTZ1S3ZiZ2h6VEI2anU1U1Jta1FWYTVsWTNLKzArTlVsbi9ZbFJLb0ZD?=
 =?utf-8?B?TUtzOCtRK1ZHcVhlQ0ZaS3J0VzhnWXMvZi9acjRUR0VPWS9aZGNjbUVlRW1H?=
 =?utf-8?B?OWxneCtHS1lTaWpaYlJhUWE3KzZ5Q3UralExQzZZRDBuZkNobW1Uc0Rlb0ZI?=
 =?utf-8?B?bmNSeVNrcUFFU0NPSmhoaTV3dUM0Y0V1cTJkQjROOFRaeTlRV1phbkt6UUlW?=
 =?utf-8?B?RXJVNFQwOC9zWXpFNGxxYjU1UTdVc3UwU0lINHdjNnZhanp6Y2cwalptd1Zv?=
 =?utf-8?B?a0Z2cDJ0UnV3R09jOGgwd3BlbUpTYnltMS96dUpKZnlDcjNjbnFtUkhQQ1hF?=
 =?utf-8?B?SC8zbFlwYVcvVzJ0UkVuZEVCSm9pcFdsN1k3U1RRMlZqdmlGMEtlRFNqZHQx?=
 =?utf-8?B?d3d1OVlwVWRSV3ZiS256dGkwdXgyb3hqRGZMQ3JESjRZQ1dlNnJIVForVmVz?=
 =?utf-8?B?Mktid3NXMnlvemJaWGQ1ZzAzMXR0QWxSbGV1RTJHelUrd2VJQzFWU2V3WkVj?=
 =?utf-8?B?OWZUcUdaenhmRjZDTXRySndnLzdmZU1tdnd3TmxtdnhGZDJGNjFHWTNxUHg5?=
 =?utf-8?B?VXB5eUZKNVNIVkl6QTFKUzY0a0dKb1NpUEYrMzY3ejYxK0lMdVZ6ekZIeHow?=
 =?utf-8?B?czV0WC9jTmtGclc2bkxXbHRjQ3I0NlNzclplTk44TlRlL3RENENEc3JueWFv?=
 =?utf-8?B?dUtoWWZjMWYxUWMzYXVvb29wcG9RWHVUMkNaVEh4ZVlNWXpMS0pkd3hTVmhB?=
 =?utf-8?B?a3NjZFd1amFrcjBRZXYxNlNoSlVlUFRxcFRrdEtqSTlkTksvNUgxV2Z4TVgw?=
 =?utf-8?B?Wks3U0JLbzFhUW14MjhZMnZ3SytCREl6ZEFsMXlGakRiTy9XQ1lYREwxOWhX?=
 =?utf-8?B?a0pKT3VrczlCREVQSDdjVWlHQTVEWFBhcUt5bTFRbmpwWmFYOUJvUGlUSzUw?=
 =?utf-8?B?bVQ5WTl4N0VXNWhFWVZwaE54alNVTUFROUhmUEd5M0ViYWp5dHRWTzBoOS9S?=
 =?utf-8?B?VWhCa044TTFiNThyOHVkOFBvRmZ6blZHRnQwNlFQN3l4UkhsV3dVaWFzREtl?=
 =?utf-8?B?ZDd1ZVo5Y2pNT1d6emlCTU53TFNIRGhiYzlRNjVVMHFrTEFYY0NqYWExWWRs?=
 =?utf-8?B?cGJsZFdHT2hQTWRkc21sL0NtMXNyUGZLeDc2aTI0NkgwOHZjdFdWMFgvRkJt?=
 =?utf-8?B?VGRpSlFwYzZyWHBGVG55eGRTRDBRS0xldDRxREEzSHNVRkw1QVoxNTlxU2tR?=
 =?utf-8?B?UXV3czRnblhiWTN6SS9nOEp5Yy84L1ZLQlVDRjQrYzA5M05PN1JuT1gyWDZK?=
 =?utf-8?B?YlBxTFNPSGFHQk5sSFZNeWRveVJqMFJVTmRnV2E4cWZCWllKNi9QaVlJU2Nk?=
 =?utf-8?B?eXVsQ0RnMlhTTUZuTXFXUHlaNzY0cDl1OVZtRDUrR1FWNG9qY1RtSi9iV1BW?=
 =?utf-8?B?ODZuUHd4VEJWa005UHdvUStSYnhNWTZhbkdQY21TR3NZUlJrSW5jWmVHYmd2?=
 =?utf-8?B?OTg1MHlwc1RDaHhNYXBrbytJZW1jdG1HaUt3ZmdYNUd0ZDJvMDV2Ty9td08x?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0D48B1BEDDF8B4483CEE13782AD8D4F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fHH1EKryq0tfV9w79zSDGE0xtqdpkXxChQlxWisu7PW3QlQc8ZGb9x/aqGeQ3a47+wpzABrHx9Cg9Bm2ILtv/oeAnw2cqt9CgIEEP1Zry1+ju3mxVG+vgKh2g3YOdX5+2aA2CCNjYfevpsykAz8fxjDH38hpZkgeHFauyHhm8DXQW4Lc+77HCSFgBtc/hCk7fNbb7tuz+Snfb+56KqVO/AJjxzcLtoF2uh5hfNBvHUoatt1JPCQD95O1dFvkXNueeFbhemgvuw4sQTPm1LiZpupMlgW5syP4Vo6S1IL7uyRGl3XulXCWERp8dL9Zt8kEysGNgPb44lkNHzd203EZ8bcjI8PiqytRPKRlkBTVNNoXZNg5fxZCrTHHbAKEfCVv1wgoym8PaFNUFhGfBT+SsslCQRDbfqEigoFeLlJQgbpJ85N/PTDVccCaf7GWnKPoCyMaWRNxyXgGTgreFY8w+ohgJuyIwXc919tuGlBToMGdk0uPzWkpt2YpKB+hyUC9QPYYXAiNpB2Irh1MDYpHD9NMm6W6Iou9tGIJUz+TLObHDdRBYACDQ4AgSqJVv98r9h83nKLmV9F10lx0TTzTUmAs/4+rxU0b51cEaaHs/AU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7e5aad-b296-4411-2cf6-08dce6fb2f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 18:09:28.1778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2eRM/v/iHwhZ9K08On4fO8EDw7c1urNGpdMXzMrCPU9z8Y1DNJNdDCRr3EgPjpNrOZ4cRic3+OgCFpliEeMiCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_11,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=686
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070126
X-Proofpoint-ORIG-GUID: EJW099FrIR8peIr4e4GJG7URHO27Nsb_
X-Proofpoint-GUID: EJW099FrIR8peIr4e4GJG7URHO27Nsb_

DQoNCj4gT24gT2N0IDcsIDIwMjQsIGF0IDExOjI24oCvQU0sIEFtaXIgR29sZHN0ZWluIDxhbWly
NzNpbEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBTZXAgMjUsIDIwMjQgYXQgMTE6
MTTigK9BTSBDaHJpc3RpYW4gQnJhdW5lciA8YnJhdW5lckBrZXJuZWwub3JnPiB3cm90ZToNCj4+
IA0KPj4+IG9wZW5fYnlfaGFuZGxlX2F0KDIpIGRvZXMgbm90IGhhdmUgQVRfIGZsYWdzIGFyZ3Vt
ZW50LCBidXQgYWxzbywgSSBmaW5kDQo+Pj4gaXQgbW9yZSB1c2VmdWwgQVBJIHRoYXQgZW5jb2Rp
bmcgYSBjb25uZWN0YWJsZSBmaWxlIGhhbmRsZSBjYW4gbWFuZGF0ZQ0KPj4+IHRoZSByZXNvbHZp
bmcgb2YgYSBjb25uZWN0ZWQgZmQsIHdpdGhvdXQgaGF2aW5nIHRvIG9wdC1pbiBmb3IgYQ0KPj4+
IGNvbm5lY3RlZCBmZCBpbmRlcGVuZGVudGx5Lg0KPj4gDQo+PiBUaGlzIHNlZW1zIHRoZSBiZXN0
IG9wdGlvbiB0byBtZSB0b28gaWYgdGhpcyBhcGkgaXMgdG8gYmUgYWRkZWQuDQo+IA0KPiBUaGFu
a3MuDQo+IA0KPiBKZWZmLCBDaHVjaywNCj4gDQo+IEFueSB0aG91Z2h0cyBvbiB0aGlzPw0KDQpJ
IGRvbid0IGhhdmUgYW55dGhpbmcgY2xldmVyIHRvIGFkZC4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXIN
Cg0KDQo=

