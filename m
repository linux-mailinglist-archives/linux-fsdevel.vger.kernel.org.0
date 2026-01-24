Return-Path: <linux-fsdevel+bounces-75342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFZdE/lCdGn73wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 04:56:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A42767C6D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 04:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E243019F27
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 03:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCA31EB9FA;
	Sat, 24 Jan 2026 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rf43+iEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF11373;
	Sat, 24 Jan 2026 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769226994; cv=fail; b=PpeHGu49Of2ZmQ0/tiCB9jA0AQv9CSts7kFXSdRh4kEdvrMWXVfF2d7/DqkIsAJ3n9e0cKLmIkoQEr3B4lb0SAlGuVigaj5dlf+LG5metJNDKDmOUi9S7MlqTpCj/+R5fOglAnCN9aOTi5UxCLVYj/9Fp5r/fnr7IzsjzetXbCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769226994; c=relaxed/simple;
	bh=ghnbbvLBdSDJcdIVKr+2cIa7KyP1KhX2KG3L7rqdhRg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=IxEfZKM1mvMZTWixQcR/0ZLUJ8kqDZdJ6YGyi7qTmjPVti6EigyA3er1YizraWVoe8hY0/curWF/3k2LZbU+SaQ5JN+EXeCN/uhXPjpwy/ovZTkhbQZZnPu8zghhq4plRBCsI903XKAS3Cda90IfmS+zZ3Ra6WeiGtHBJE08OKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rf43+iEr; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60O1VwWE025118;
	Sat, 24 Jan 2026 03:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ghnbbvLBdSDJcdIVKr+2cIa7KyP1KhX2KG3L7rqdhRg=; b=rf43+iEr
	msHJzZuStiLDBfXqAheFBit1gcesDqedVhqUABI+GQx1OWq2QpA96PuykJdupWxm
	LqJuiPeB8H5mYzr7LdsyMJmF8VIIXk4CLzYrOliW+c7uGoBW0VN6dkI8DfAhk6mV
	KlY0d+szaixdfxyQLcw2K2KOdHaRj2upCz9/jIw2OHWcHerXNh5bSprbmIknQeXn
	jmTCt1gH1sWb/4tJ35vpDXHUzBo9Y33ZertLJAJ6uvNwQb1o504VDWtVdWqE8Hno
	fR28Qe0iwF9aANEDFbIj4XqlJssxZBdbb/kZf/bzvuptvsIYd8Y4trl/33X2zNxg
	GEpY8i08NJrajg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfg8ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Jan 2026 03:56:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60O3uSAm008530;
	Sat, 24 Jan 2026 03:56:28 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfg8ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Jan 2026 03:56:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qza3/MhAduyz4XVPCsIU2pOTmLgR3t4MpK5Vae1r0mBSA3hk4BuSivMJFT/2K8F9BCFQOxrHHBKFCcK/dwHeIyW8F8ehKmVJ159bGmajxsR3yFyvKlpUpLlfnae+C3qjAU7lJKTCac2QQxqrXSBtY0728KFdPbEwkk01iZuOwCTE28aELrKPY5Dt6goy56wttBq57GCT8tcDTFXLapyGXVx3YjErAiZNjlEhTzxcsok4nRFdAXK75ax3QG7NxlCJl5K0HmPYGp5s58tfTH56teBjN65bUVTItsdbPi5v9VJVmj44LzTAVgaqWVYVsIDQ5JXMt7OXohrFia/AfERmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghnbbvLBdSDJcdIVKr+2cIa7KyP1KhX2KG3L7rqdhRg=;
 b=wrDfqODpXUMHEWcgmvEKUfx0i0Od5ZEkJc6f1bhvtBOS6GL0Utp52C2apkjW65mlELFfOSpcaxey4nvHWZBKs+B1QE42xem9GDcHSqRaptKzZdHS+3Ly3cioMTbU1wBlSWKUw9Wtus3x1cY62K8dQTvnWTmM6C0HXpND0oe98y+nAxXtZyJfETLC2/+A/H5RYCFskxsbA/mPGT2B4+/5GMQiktm6ai+xPbZe8jq/hoMHbPpy6mQE5/Rop0Jq94tnc0tkc0v7rDDhGlaKkJPlOBZ+ZWn7DuzWpZU/vMwUPk7gnp5oiG5s3TKaKTJvq46zwVLAh5oUDzUb06bWsOFtdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH5PR15MB6963.namprd15.prod.outlook.com (2603:10b6:510:39c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Sat, 24 Jan
 2026 03:56:24 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 03:56:24 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "tytso@mit.edu" <tytso@mit.edu>
CC: "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
Thread-Topic: [EXTERNAL] Re: [LSF/MM/BPF TOPIC] Is it time of refreshing
 interest to NILFS2 file system?
Thread-Index: AQHcjL4dwd18ibQvbkShxUxQIrpTcrVgjRIAgAAkQAA=
Date: Sat, 24 Jan 2026 03:56:24 +0000
Message-ID: <43e3ce52eabd37b8af1e70fb2f0936f6bfb6127c.camel@ibm.com>
References: <8e6c3a70db8b216ab3e9aba1a485de8e6e9db23d.camel@ibm.com>
	 <20260124014638.GH19954@macsyma.local>
In-Reply-To: <20260124014638.GH19954@macsyma.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH5PR15MB6963:EE_
x-ms-office365-filtering-correlation-id: 6b667733-d39a-4a78-8055-08de5afc8b32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkhhTzJIYzB6YkRMb1IrUU5MeXhnbXlBaGh0czU5cy9Wb2JsUmxKNU53QWQy?=
 =?utf-8?B?UHdMVXlFMjZFdEFFTWZGc3VqQ29rb3hxbUFZYTVKS1Y3VlptYjVlekQ2MmFG?=
 =?utf-8?B?VjBkUlNHOWVqbmozMFZkRlVRSVRpRjIyR0kyN09kdFNQUldReXFPYlFCdC9S?=
 =?utf-8?B?L3NFeXV3TjNDTFJuR0NsSkhaa1pLaTBPYTkvd0tQU2svR1k3ZFlLdVhvU3RQ?=
 =?utf-8?B?cit6THZrS0FqaUIxaXR5SUdMR1E1WXIveFBSaHJzcFM1Rkl5RVFjM2E1cjN5?=
 =?utf-8?B?dzRNeEUrMUNzWVVNNkVxUFhRQzhKR1JCWHB0RDNOanlUMWc5dWRFQnV4akRz?=
 =?utf-8?B?RXUxQWQ5YzdVRVdJZ1JnQWNTZXNVNGZHYzZCd1FwZTMvOGhsZnFBVk1HWWFh?=
 =?utf-8?B?dklaRjFZb0VBdHZ1Kzl3T2lQd2lsekVicVg2OHgyQVlZY2s0Z3Fod0kveStV?=
 =?utf-8?B?SlZiU0NPenZSVXBDNGxER3pBRGN0d3hDMUFmeFVkaGNoSVhyVnNremZHNGVV?=
 =?utf-8?B?L2xQZ3hlSlRqV1JnbW1iM3hTbzVGM0E3V3VJRzNQTFRvRm9PYlBTSUhpdFE4?=
 =?utf-8?B?UHpIOGlhUHJkNXU1SHFmSmxtbExpbGcxeitVKzEzMUFRTklqU2dQclVXMmJo?=
 =?utf-8?B?eGxGSTBzYmNId0FqN3lxQ0lOVmRMMVUvQW16WFBkZk9hRWhTQ3YxdGZYU28r?=
 =?utf-8?B?MkhuUkpwczBTZy9vSkZPOCtGazVQNmM2SW1GZHA2NkJGL1pVazhrdEFtcFQ2?=
 =?utf-8?B?OFlUKytZN2FsV1RHS2szYW9wNW9ZMlVaUG1BdGNEa3hXOGJGam5TTGZsbUJZ?=
 =?utf-8?B?eDF5OW1HN1lkUFkyMXZCNHgrSWJCWDFxek1MZnRHaWNYYi9tL0xUeVhrZmFt?=
 =?utf-8?B?aFp0WlVVT0U0UytCWlVZa1ZNdTNjRzhsYU5JbzlQSHZrQ0t6cTBtRWxVK3ln?=
 =?utf-8?B?cjFvL2tVWnYzaWx3NHdOaVVvMnRNR2x3RzNBYjBaNDR6L0NmNHFoTmdVTXp0?=
 =?utf-8?B?Z3NPMUQrL29Fak5aRXE4ZHM4N2hyRXpqN3pLeDdQaUl4bnF3bHlTUUYzOFhM?=
 =?utf-8?B?K1ZjT082aUpDc0t4OVJLUXJIZ3BVak50d21CM3A2Sytud3FaYm1kK3Q0dWha?=
 =?utf-8?B?ZU9Ybm5aOHFnMUdKbGwrd3RVODRLbWR2ZERiWjVOU3NpM3dkRUI5YTRzenJJ?=
 =?utf-8?B?ZS94d1FRaVFMK09HZUh0MmpmcU8xdFFGZmZoUWt4S0luY2tyZGNXNVpUYzAz?=
 =?utf-8?B?VVFnMVhiMTZYaUt5RUVmTThEd0c0WnkwQWxSOFpMOEFXbXhxTmJ0WUJLSmdj?=
 =?utf-8?B?OU1uOGZ2cDI0WnU1ZjhBS2pjWHZHWnZDRmtuVDhZUk1ZUDBHY3BrcnNiaklh?=
 =?utf-8?B?RWVzZms4eURJNFcxRnQ4S24wckRWalFhNHdVUGZ5ZHFyQzRRcmthV1hsREFP?=
 =?utf-8?B?bXZuSHVWUWlBdEc2ZXV5RitPandEZWlmU25zSTc0dUlLdDBvQkJBa1RmaUlV?=
 =?utf-8?B?RDNZM3NOUkpGaFJhM0xON2JTS3k2RHBrV3c1ZC9pQmYwcGU4UURrd0pFVWNL?=
 =?utf-8?B?K2RCU3NCaHllT1RPWFVsMDBPWWE0M2tHbmFZNWxmSy9BZGgyUVVDeW5SNkRj?=
 =?utf-8?B?UTR5dkpIQlNuSVF0Q0RzNXNUTWJxei92dysyVCtQREN0dERtZEpjODcxY2hq?=
 =?utf-8?B?Sm9TeGdiZTE0RFc5WDNjQmo4MnhHRGx1aFVYOE1LRXUzMG5WQjJuRW1nU2NK?=
 =?utf-8?B?cloyQlZrUzBZcWRPaWZ4M3NHcnRsSVkvRFp3dlN4UEFIbVR0NG5BbjJPT2xt?=
 =?utf-8?B?dnZwQ1JuV3liMTB4UjNFcWdJS1dUSU53NWdOd2RpMGpMblkwTitGcEJvNlhK?=
 =?utf-8?B?cWlRVW9JeFN2d0NITk9xcVkrS3NzeWxoMkRMR0dnd3VyVGMwTjNjYmFwdVA3?=
 =?utf-8?B?Ti8yTDA5YVgzU1FOWlBSNHlMSjdwakxLV2Zhb3BWNURNS0dKZEZzdUpGT3I1?=
 =?utf-8?B?U3hEZ2ROaS81bzlCamZITmNIczlqYlJ3MXo4OEFPaHhDRnZMMDcwbElJTzMz?=
 =?utf-8?B?OFYrdC9MOGxSTlpMekZUNTAvY2dvT3B0ZHZzb25rR1BtZCtXV3R1SFEzWEQv?=
 =?utf-8?B?K1EwWk9FU29jWm5pMG1rZUx4SEdBUVFSV3Z5aTlYRHJyaHp0M1hHVDgzU001?=
 =?utf-8?Q?S8/bauI8+D3ZSJDfIgQyB6U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGF2bU82UlJ4d25oT0RqdjZnZ1poRmZNTXdZQkQ3Zm1wbE9IM29SQmZrWEM4?=
 =?utf-8?B?bmh0ZWxmdVFRS3c3T1VaUzkxb0lyRGRBeWsrMENReGVYNDlxR21VU2lPZ25q?=
 =?utf-8?B?d0lQMVdwclQvY0c2bURUcWlUMDBZbjdVbjRGUFE2NDhRNXJoeGVZbkcrNVhx?=
 =?utf-8?B?RG85dEdwNE5TV2VVUHVaN3g2bForak1pcFVxUFoveTRoQk81R2RYTlFIRFo1?=
 =?utf-8?B?NVk3R1lMNWRQeXhqbllDRmpnUDFmWjNybnJkb3lYSnpZc3Y2d1BJNUVvaDBM?=
 =?utf-8?B?dURHaXh6bk40bWgyLzJLdEdmQ1RYbGkrOFNFUjZrWHdtcUl3WnFuRDB2QjZU?=
 =?utf-8?B?NHBUNnpja3lOQUNoMEwzcnpHTEVRUC9CNWlEcGpDelJkcEVnM05yY2JMZ3p2?=
 =?utf-8?B?SGQvSy90ME1lR25XNGF5V3U1ZC9KWWdDRFUxR1EzL1Njd0dsU0djZUpCNGYv?=
 =?utf-8?B?S0RZaFRzK044cW5QVldQZndkc1ZSRUVSKy9TSGVWNk9GNWJkSlpPSXBmeCtD?=
 =?utf-8?B?a3hlUDdvOU51V1BHRTBCTUozejU0dDhBWXdvQmpIQTRIeXg2YUVkOE5nWHh4?=
 =?utf-8?B?UmRPN1NBQkRNTmRoMEhPVnh2QU9JQjhzRGZIaGJoQkFXdGtucUxmejNqL2Nl?=
 =?utf-8?B?eE4rSGxaNXV1eU9RcjVsVDczd3lFUVYxSUdZbldYanFaT3o3VnM3NThPME5w?=
 =?utf-8?B?MTkxWnFUYlJpS1k3ZlhLMVpVSTFXZHM4Ri9ZQUNzZDBLaHJLWXVIZTFGYlhX?=
 =?utf-8?B?SmpWYTBwc0tRdndoV2x5dzJHSGw1dGVqcDBDVjFvVzZUdEJtTS9palExSG1y?=
 =?utf-8?B?K25JejJOSGxaMmtseUFoNXZueVVJN1NQZGxBcXNQdkRhWXdmZEx1RHpmMlo0?=
 =?utf-8?B?Z1RQUlRTUi9wMG80VE9ra1dmcktCVDJsb1BibzRBb2N2WldKYVRUczhBTk96?=
 =?utf-8?B?VENBNzlpeDZnWXVFOEM4VkxIY1MyTFordVhuUEpNVGRESjJLZTNWVkI1OCtn?=
 =?utf-8?B?QXhOZngzaXloVGR2ZnNUMkY3SGlHd1pxVnRVZUJKQXhDU2FWQ0NJMk5iVkND?=
 =?utf-8?B?RWtnK2FwNlpXbFdsVWZHM0Q5ektDOEVya0laUkVPNE5TOEhZSnlKdER1Yy9R?=
 =?utf-8?B?MUE4eVlJUGpQM3ZOVnVUVzJFRHIzNTF4Z0NPak84ZWRzbGJwTGxudmRIbGly?=
 =?utf-8?B?Q2RLRDNlYm11MW55ZWtiNlJJdGowMExrZjZUTXRLb1FPZDdSYnFvU21ldzJ0?=
 =?utf-8?B?Yk9qaUJZZFBhZWZ3a1g0V1MwYmlBUTgwUHBxeVZ5K2NuSHN1c01IWXhGUG5r?=
 =?utf-8?B?TytleDR1S0EzZ0Rja2lCdTg5emtSVmdZUlRtdFVkSHdVbG5lL2xucnpEYXdq?=
 =?utf-8?B?NzZ3VSs4ZDNkcXNjaGRtREJQYUtlS0JrNnRlN0JaQW5pQ1ZrYzlCRmJEY3pX?=
 =?utf-8?B?QXVvdUp3QVlqSi9IOG8rV2JxdkFDb3hXZGR5Mk02cmVGSnlrT2I5MnlEeUhN?=
 =?utf-8?B?c0JrY012UVprazJaZk1MVDkveXBOMFAreEM3VkZKR01mb2s5dllzL2ZmZmRM?=
 =?utf-8?B?VUdUbmpKbTRCaW5iczdRRm5xMHhhcmZFems1elhLS3BJVm4vL3ozenJLMmJh?=
 =?utf-8?B?R3FSVGYzdFVlV0dyaGZOSnpsbWNDekowa042VGtqYVJRK2ZJbTJ0b2V3dDB0?=
 =?utf-8?B?SEtMdFg1N3F6L095aTRGVzA2S1JnN3ZiM1ZTRjgzMUd0UFdXVHpyYklPTFpS?=
 =?utf-8?B?RzF6ZUEvbVdWeEhpT0lETTdDUDRaRTVxVGxmSWdWdGRZR0Z6M2tkWlBxL2dB?=
 =?utf-8?B?MThlc08rRHlqd1VOTVQrYnpvRnhqV244K2RrS3E4cXRPMFFyZXB2NlM1SUdx?=
 =?utf-8?B?bUZQZGxqcDNoMURGUFIwa3pnRktoMVFQRk1wbitEUk95dXljU0VpZVF4S0lj?=
 =?utf-8?B?eDNCN0xXSlphTlF5TkRIL0VMQndyR1lmSHRrRWJ5L1lKSWVBM3RnbFU0TmxX?=
 =?utf-8?B?WXdZcmFVOEQrYjdqMjhBZXdDa0lSa1BqMHE3OHplVHpWbzYwZ0VqRmJWcVI0?=
 =?utf-8?B?Y0R1aFNXUjF1WjVwemxLZzFJTGMvVnNILzBTR045NENVOEZTMGNNVkhXZFBm?=
 =?utf-8?B?c2RXeDh5dDFFNjlFOEJQYjlYcFNYNGczR0hkblBZRDdIZVJwZERTa2w0MHpv?=
 =?utf-8?B?MkJhNTViQjlkM0ZYYlJRN0s4RWZxc2R5eEVqY0NXNGozNWxYbjFsRzVhU0or?=
 =?utf-8?B?NVVQdkVLMEZRNk9DYjl5THBnOXZVRkVkT3RKQnVPSDVoTGxXTXpMRGpHMnJi?=
 =?utf-8?B?WCs1RVk4TTZodTB6MEpWTzJ1RUg4UDBjU0tBUG5nZFVYREhReFgvNThVNUlL?=
 =?utf-8?Q?6TRmGinCE5vyz5AH0fed7y72kyq3L3ueNjIJz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90B38E3368B1E540B0168D088933FC3D@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b667733-d39a-4a78-8055-08de5afc8b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2026 03:56:24.6345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MiDeS1oJOm6xNbp8v6LrmbDOZbDJ42FM8LOUcDeyKkPQ6ysSWsqWtE6uoRL8H284w1W7mJ17IuqEPUac+gdOpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR15MB6963
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697442ec cx=c_pps
 a=V+mzYH1ZSfwt9Wwm8MCB5w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xg1uNFgt4xrJTclt:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OPlqN5CZKAIVqjiJ0XgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C8GwRbq6x44U29p1VSsZ3pXgK1NzyKEh
X-Proofpoint-ORIG-GUID: 5DAf7dW7fNWWzHCw5-vvk7SLwGY3ncnU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDAyNyBTYWx0ZWRfX5zxnurnqF7O/
 WOMrmZPt/VW0sM0O70/z78CTRjT9zTX92f8tpR8PU57j4DEI0m945KnhCq40JCVtmokugAxlt3V
 wZOLwYkBnEPH6rHl1VamGvOetn02Vl8GeacFjLLHx965I+34YnfK58OIw0IdiRPUvnXmdeOyTCc
 ZE6GjKcOns7Kb72JjkGW+x+oHzkzXqWI+F+awgfzKX8pg2bJFiPvhPUmp30eQHmzygKkiyNjGvt
 ChbDh3fbT011uGR1Da/ArdMFCyqfdyjxtpRPSfIA4tt62QXtbvW1kWuVIinC25Ah0Z97nzxkL2B
 DUaxBcnhAJmkju8C2g2DmVSqrHbv7/25aZBFUlKOBU63MU9885ApigQikq8xmDzDo53OYQ7fFsa
 1h23if6TasNoDW4J9xw94Wy4ftpCfgrOZ6IPa1YzJaXWiw2T1oJGXeq00YrH6od5a7oRBz3Fxo0
 KUl932VqzEpME6iv4lg==
Subject: RE: [LSF/MM/BPF TOPIC] Is it time of refreshing interest to NILFS2
 file system?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601240027
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75342-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,dubeyko.com,lists.linux-foundation.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A42767C6D3
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAxLTIzIGF0IDE1OjQ2IC0xMDAwLCBUaGVvZG9yZSBUc28gd3JvdGU6DQo+
IE9uIEZyaSwgSmFuIDIzLCAyMDI2IGF0IDExOjE1OjA4UE0gKzAwMDAsIFZpYWNoZXNsYXYgRHVi
ZXlrbyB3cm90ZToNCj4gPiANCj4gPiBGcmVzaCBMaW51eCBrZXJuZWwgZ3V5cyBhbHdheXMgYXNr
IGhvdyB0aGV5IGNhbiBjb250cmlidXRlIHRvIExpbnV4IGtlcm5lbCBhbmQNCj4gPiBtYW55IGd1
eXMgYXJlIGNvbnNpZGVyaW5nIHRoZSBmaWxlIHN5c3RlbSBkaXJlY3Rpb24uIE5JTEZTMiBpcyB2
aWFibGUgZGlyZWN0aW9uDQo+ID4gd2l0aCBwbGVudHkgb3Bwb3J0dW5pdGllcyBmb3Igb3B0aW1p
emF0aW9ucyBhbmQgbmV3IGZlYXR1cmVzIGltcGxlbWVudGF0aW9uLiBJDQo+ID4gd291bGQgbGlr
ZSB0byBkZWxpdmVyIHRoaXMgdGFsayB3aXRoIHRoZSBnb2FscyBvZjogKDEpIGVuY291cmFnaW5n
IGZyZXNoIExpbnV4DQo+ID4ga2VybmVsIGRldmVsb3BlcnMgb2Ygam9pbmluZyB0byBjb250cmli
dXRpb24gaW50byBOSUxGUzIsIGFuZCAoMikgY29udmluY2luZw0KPiA+IG9wZW4tc291cmNlIGNv
bW11bml0eSB0byByZXZpdmUgdGhlIGludGVyZXN0IHRvIE5JTEZTMi4gSSBiZWxpZXZlIHRoYXQg
TklMRlMyDQo+ID4gZGVzZXJ2ZXMgdGhlIHNlY29uZCBsaWZlIGluIHRoZSB3b3JsZCBvZiBRTEMg
TkFORCBmbGFzaCBhbmQgQUkvTUwgd29ya2xvYWRzLg0KPiA+IE5JTEZTMiBpcyBwYXJ0IG9mIExp
bnV4IGVjb3N5c3RlbSB3aXRoIHVuaXF1ZSBzZXQgb2YgZmVhdHVyZXMgYW5kIGl0IG1ha2VzIHNl
bnNlDQo+ID4gdG8gbWFrZSBpdCBtb3JlIGVmZmljaWVudCwgc2VjdXJlLCBhbmQgcmVsaWFibGUu
DQo+IA0KPiBJIHdvbmRlciBpZiB0aGlzIG1pZ2h0IGJlIGJldHRlciBmaXQgZm9yIHRoZSBMaW51
eCBQbHVtYmVycw0KPiBDb25mZXJlbmNlLiAgVGhlIExTRi9NTS9CUEYgaXMgd29ya3Nob3AgaXMg
YSBpbnZpdGUtb25seSB3b3Jrc2hvcA0KPiB3aGljaCBpcyBmb2N1c2VkIG9uIGRpc2N1c3Npb25z
LCBub3QgdGFsa3MuICBJZiB0aGUgdGFyZ2V0IG9mIHlvdXINCj4gdGFsayBpbmNsdWRlcyAiZnJl
c2ggTGludXgga2VybmVsIGRldmVsb3BlcnMiLCBpdCBpcyB1bmxpa2VseSB0aGF0DQo+IHRoZXJl
IHdpbGwgYmUgbWFueSBhdCB0aGUgTFNGL01NLiAgVGhleSBhcmUgbW9yZSBsaWtlbHkgdG8gYmUg
YXQNCj4gUGx1bWJlcnMsIHdoaWNoIHdpbGwgaGF2ZSByb3VnaGx5IGFuIG9yZGVyIG9mIG1hZ25p
dHVkZSBvcmUgYXR0ZW5kZWVzLg0KPiANCg0KSSB0aGluayB0aGVyZSBhcmUgdGhyZWUgdGFyZ2V0
IGF1ZGllbmNlczogKDEpIGZyZXNoIExpbnV4IGtlcm5lbCBkZXZlbG9wZXJzLCAoMikNCmZpbGUg
c3lzdGVtIG1haW50YWluZXJzLCAoMykgcG90ZW50aWFsIGN1c3RvbWVycy4gSWYgd2UgY29uc2lk
ZXIgb25seSBmcmVzaA0KTGludXgga2VybmVsIGRldmVsb3BlcnMsIHRoZW4sIHllcywgTFBDIGNv
dWxkIGJlIGJldHRlciBwbGFjZS4gSG93ZXZlciwgd2UNCmNhbm5vdCBjb25zaWRlciB0aGlzIGF1
ZGllbmNlIGluIGlzb2xhdGlvbi4gQmVjYXVzZSwgdGhlc2UgZ3V5cyBwcmVmZXIgdG8gYXNrDQpn
dWlkYW5jZSBmcm9tIHRoZSB0b3Aga2VybmVsIG1haW50YWluZXJzLiBTbywgdGhlIG1vcmUgaW1w
b3J0YW50IGF1ZGllbmNlIGlzIHRoZQ0Kc2Vjb25kIG9uZS4gTXVsdGlwbGUgb3RoZXIgTGludXgg
a2VybmVsIGZpbGUgc3lzdGVtcyBhcmUgaW4gYmV0dGVyIHNoYXBlIGJlY2F1c2UNCnRoZXkgaGF2
ZSBtb3JlIGF0dGVudGlvbi4gU28sIHRoZSBtYWluIHBvaW50IG9mIHRoaXMgdG9waWMgaXMgc2hh
cmluZyB0aGUNCmN1cnJlbnQgc3RhdHVzIG9mIE5JTEZTMiAoaXNzdWVzIGFuZCBUT0RPcykgYW5k
IHRvIGhhdmUgZGlzY3Vzc2lvbiBob3cgd2UgY2FuDQptb3ZlIHRoZSBOSUxGUzIgdG8gYmV0dGVy
IHNoYXBlLiBJIGJlbGlldmUsIHdlIG5lZWQgdG8gY29uc2lkZXIgTGludXggYXMNCmVjb3N5c3Rl
bSBhbmQgYWxsIHBpZWNlcyBvZiB0aGlzIHB1enpsZSBzaG91bGQgYmUgcmVsaWFibGUsIGVmZmlj
aWVudCwgYW5kDQpzZWN1cmUuIEFuZCB0aGlzIGlzIHdoeSBJIHdvdWxkIGxpa2UgdG8gYXR0cmFj
dCBhdHRlbnRpb24gdG8gTklMRlMyLiBMRlMvTU0vQlBGDQppcyByZWFsbHkgZ29vZCBzdGFnZSBm
b3IgdGhpcy4gQW5kIGFsc28gaXQgaXMgdGhlIHdheSB0byBzZW5kIGEgc2lnbmFsIHRvIHRoaXJk
DQphdWRpZW5jZSAocG90ZW50aWFsIGN1c3RvbWVycykgdGhhdCBOSUxGUzIgaXMgbm90IGRlYWQu
IE5JTEZTMiBzdGlsbCBoYXMgZ29vZA0KcG90ZW50aWFsIGJ1dCBpdCBzaW1wbHkgaGFzIG5vdCBl
bm91Z2ggYXR0ZW50aW9uLCBmcm9tIG15IHBvaW50IG9mIHZpZXcuIEl0IHdhcw0KY2xlYXIgZnJv
bSB0aGUgYmVnaW5uaW5nIHRoYXQgTklMRlMyIGNhbiBiZSBlYXNpbHkgbW9kaWZpZWQgdG8gc3Vw
cG9ydCBaTlMgU1NELA0KZm9yIGV4YW1wbGUuIE5vdywgZXZlbiBYRlMgaGFzIFpOUyBTU0Qgc3Vw
cG9ydCwgYnV0IE5JTEZTMiBzdGlsbCBoYXNuJ3QuIFdlIG5lZWQNCnRvIHJlYnVpbGQgdGhlIE5J
TEZTMiBjb21tdW5pdHksIGJ1dCBpdCByZXF1aXJlcyBvZiBjcmVhdGluZyBzb21lIG5vaXNlLiBC
dXQsIG9mDQpjb3Vyc2UsIEkgY2FuIGdvIHRvIExQQyBvci9hbmQgT1NTIGFuZCBJIGFtIGFscmVh
ZHkgY3JlYXRpbmcgdGhlIG5vaXNlLiA6KQ0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

