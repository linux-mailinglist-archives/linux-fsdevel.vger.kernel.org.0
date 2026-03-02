Return-Path: <linux-fsdevel+bounces-79094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL0SMhMipmlQKwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 00:49:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FDE1E6D6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 00:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 351D93071F01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 23:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D32C344057;
	Mon,  2 Mar 2026 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sjYDBO1M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56852346FC0;
	Mon,  2 Mar 2026 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495150; cv=fail; b=KomolQdkc87bPEJkeITmLguF/JfS1oHGslycPeNh4Lq4gfPL6zE6ZSpD3srfi0YT7RQGv2EtGNTIcOEMDDCp/o3q7m8flSx7G1WzpzBp+v7hzdmKDH4ZSGg2+QN86b5LZAOyvsfiMUoOIa94U0lgYrM322sfod0EQt130CXbjrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495150; c=relaxed/simple;
	bh=+Bvt69jQmZZA9pPOH6tUPzI0ts2nIKDc6NUtGN90CVM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=iZCGiAtmDRpl2KVRf1qVr5iN7gHZ1aQmot7IHKiDvQ5QFSbtKJ+QW0uJcz4R+5xgoy6oZIy0ii2IbJuM2LqJRxFXaGCT4EAH5Y6KIR2eEnFxQGVde6tDv6hx9hAr1h0YRYmYk4DtAKVWoLC557u9RxrMmZli3OT2ZGMZRdNihCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sjYDBO1M; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622E3gVe2246261;
	Mon, 2 Mar 2026 23:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=+Bvt69jQmZZA9pPOH6tUPzI0ts2nIKDc6NUtGN90CVM=; b=sjYDBO1M
	7Qz5DTzPBWg1rTN3/CnrGWey5nadyG4FHWS793/ockcebQoD42U0AdNzEC9r3ksN
	a0vN9yluzpFT/esN5X8uw5yiAI3mqy5paFsLXu84sWZBPSokMRKyN66q9Pi6GfGX
	6ZtZriaHQuh3fLBLidgdiixwgwPdcNiUzCE/d7hGcFckOtYw6V9Jo0Xkm5dDMK8t
	fYnC6cMVdH8lXzTGEsskyTYr3TPcsYelO+1CSDEj3Oz7LrjlaXWeXNu34V+W6fPl
	/T73r5ZhG0a81Oz4GnJBsP/Z14M5yTdryre0T79QMoZuayk5ACdROdPP9xchdwol
	WulAr14sNjyNTA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3rmxj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 23:45:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3QQbBCy2YrFVq58aE2Sv3xegqsa91Gu/7YlC0iIHQ8FwIsRxIYC88x2FC2BxV1zGj6CgHtCAd2ximXRHlASr7k+L1XIduagjHarV9DOI6S/aAKFTMTV8kmWvtPYjwjRjitgnEL2YdDxb3kDHZH7072v0NorZH5GVB/ZHfhzJXFhWPubIxA/urTpFmBRGnPyrBZyn84tdA3ZhWkS1Z+Nj0ZVFhJOvik57EpHNYdusdXr93iwpmNn7iAHj+tnmHpMY4soNWp6seo54f+UDXCv51ifpxF908I/4DlC1yMZgrCbn7qc6zem8Q11uMikxX9nY+nnrI6LeP0rq0TEDmO1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Bvt69jQmZZA9pPOH6tUPzI0ts2nIKDc6NUtGN90CVM=;
 b=rX1vfa1okNgW07aUCzjKHlLk7i+Q1C4zy4INiOJ05/BqmTzPVFYb9QPucHotEuUo7+FLyCkmTkGXb3ofzFLIDgajmhYKMJDsCRXGaj7tvHQQt3+VzC6BVFvHzb3k0PXqTHdT8oKRrZzPcn7MAq5IH1nFXjz/PqnYgOUSgFk/HixrdgXdvZzgjjJIqyzODfes3S4EPFsajTJNQZUaj4yff6SM7JnsmwUA6ES/JYVL3WUCs24o29gFsqNmrtQXRXFlvQKFKWNtx1VGlinCDvBAcSu4ZEuKOefmAwgG1/xO+x/kOp6JGLfxZXZE7mByDOAvJeRKNOgcrS63oBWSNNQUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CHAPR15MB6975.namprd15.prod.outlook.com (2603:10b6:610:2f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 23:45:33 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 23:45:33 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "janak@mpiric.us" <janak@mpiric.us>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	<syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v5 2/2] hfsplus: validate b-tree node 0 bitmap
 at mount time
Thread-Index: AQHcqK1WfMeq1sftbkaruq26jpZbz7Wb6/eA
Date: Mon, 2 Mar 2026 23:45:33 +0000
Message-ID: <4442aca3ca4745748a7f181189bd16b2b345428e.camel@ibm.com>
References: <20260228122305.1406308-1-shardul.b@mpiricsoftware.com>
	 <20260228122305.1406308-3-shardul.b@mpiricsoftware.com>
In-Reply-To: <20260228122305.1406308-3-shardul.b@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CHAPR15MB6975:EE_
x-ms-office365-filtering-correlation-id: 653a0219-a414-44b5-4f8e-08de78b5cbe8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 86MkqGPD1JF0IR4+MSVtPq3iugA7BjJYpixc0HNvLi+Bx+eTwwBkt9zdtVwrxBacAHCnOUBD61w5yVXE+XNxYWg1rFyuK7I/nk8rVIlzSorAZZWmAnTVW/6/lwHYlA4w/j+EHoNUoSJszBKTDsFxVXOvLiVC+Zr8aWNcIQgeyLap7XFbrMefQTTSPPSdRmI45/3TqkZD1mg8MdIja4DzFNDURgLk+rflSobVpcAE+h7vdmAwC0IX/w5qHTk0lGFrl5b35SjD9DCcWDRjA2Fn1JUN4n3PQWIvp1+ET6bBJWIfwnRLoms2tHaS811rPb/X/BtlJOJa7X7uMd1fZstFkmWdBYjOBMpKL8wxbd3kr25T2gLJTnmHrWxaMQnh/rG6xKk06FDOqlVnHhQsEw6YB+9taQUcmpIhGDpCeRnt+PwL1/8EG/n4Gxe1bCYFe/XhIGcYDWUFZ1sdyz0b/fR4V75sxzNXdhGSE6jtd5nGaFsgxwCiod7uOXEFEQ4//4e/4O6O3lq9isIPWeOBm19St4yGHpRLPEaHWuv7Tb2wAvQfQNrY7dIug552Y2n0ksIixpC8+SqopuZWp3jBTmBKNw5Uf34inpNd5FQmnCfQljC6tnjqKxEfEO3gNFCn6j1xJsks6wA4DZPOBf+0ApWBzCFOPeUhwW6fpTfUylav43LKzf7Mky3uHaKPoYdbjSrT2sh2iqnCuFD1jSzcoSXYgECM5p9OCWG01Bp3bLur2a3aMaPrWE74q2k0txI2xg2Q
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkVIelE4UjQvdCtRR0RGYTA5ZUEwZHg3eFVXbkNDNlc2T0ZMK2JIelQ3REhO?=
 =?utf-8?B?TkpFcmRoZlpMSHRRZFBrcDZtMk5rTlEvNGZEMUtpVk5UdzNTNTA0SXF0Y2U0?=
 =?utf-8?B?cWxYWVlOMUJYVWVFZ2hiSXhKRDlyamFXQytqMlVDR2xOUHNGcVBnUSt5VVll?=
 =?utf-8?B?a2g4QlVtUi9GZ3JveWZoSGZaVGR0UGx0UTBrYmF5b1RaM0IwQTBvcGpGOHU2?=
 =?utf-8?B?Umt3NjlZTThjMmRJRDZYMUtQamtmN2JOUzFoeXgyME5yTDRiS2VDRkNLT3Ax?=
 =?utf-8?B?L2hYRnhNUkxCWnNkSE83K2ZUU3Nac0VQV1VaZk1jVzFvaTUyUTF4Y21Ed29J?=
 =?utf-8?B?eElySHp1bkFLNzV0UzlWM0dnSERycURWbTZBTHF6eGxlUEFrUDdBK3Z3Qjh6?=
 =?utf-8?B?QStXajY4NnRpQVBFR0hCNEkyQzZEVzc0dEhRYVVFMHRSand2YkZnK1RlUVJU?=
 =?utf-8?B?NW9rdjF2VWE3QSt3VFJYblM2Uy9jbUZIRXBwd1Fmc09PTnVNU3V1NVZibDJW?=
 =?utf-8?B?bVpBWWtvWTBkMVhUdTFwb2IwdGdXMkJqa3lVN3lDUkhmRzFZMUUxem00UWFF?=
 =?utf-8?B?ZCt3bzBkWlhXQlBYV3ozeDdRbDVOTXV2aFpIa09UajQ4a0NpcDFHM0tSY0R2?=
 =?utf-8?B?TTcxN29ETG5GVXBuU2t6cGxSNnBxanJwbmFTMXU3ZlZmQWtTWnorRFRGbEor?=
 =?utf-8?B?V2dBVmdmcGwzWkRyZ2FMa2orSjdiSW1UQVQzRlNSVDNOa0lYNnJmRi9rMzVS?=
 =?utf-8?B?N2VRTEh0SGZFTTV3czN1Yk05OEVlV1p0UktDU3B6VlpQN1kyT0RSZzJVUDMw?=
 =?utf-8?B?WHhSQnRzeG9VL2dwSkk1R2JERjBmWXFkRENCcnl4b2F1R0tUb3FuUHVXOFB6?=
 =?utf-8?B?blpjVSs4dUZwbWdWZEZOL1RiYzlEQWFraTBSRHROZkF3ODlsTm5qVjg3TVJY?=
 =?utf-8?B?cjhXc0ZZY3N2SVM5aUs1ci81azhUaUkrcmpkVmNydzk5SGhsMHNYLzhWb284?=
 =?utf-8?B?Tld4ZTdHemdyaDNFTDlEaGh1cEU0WTVwOUVmM2ZHeDVsbXZIUzAxWTdYZkcz?=
 =?utf-8?B?MUVPY2dXdTFYZ25VZzJaTXB4UHBXUC9xMmpTc3A0S2xWT0F4OUF6S1poRTFO?=
 =?utf-8?B?bGF4UlZaeDZYMGpLMUprSjd6dWxqMmdGNnpSOC9pdWpFZkR0Zms1ZmtsU2px?=
 =?utf-8?B?WmpLZldUYXNrYnN6OHk0T1IyL2tFWDMyenlOaHo1S2ZrTXhWOWJjMTZZd1VM?=
 =?utf-8?B?dExENndZZThma2JvOFBUV1Z5R1UrODl2bFE4dDliZ2xaTHNibUxId1RoMHB4?=
 =?utf-8?B?bXo1NHMvWUQ0elZTQ1pPY04zamlrWHVTeTZQS0NWQnhrSnFGU2lhcHE4Mkda?=
 =?utf-8?B?aVVOWW9rc0RNNUNhWWhrMzNUK2krOEd5dXhOWjZsZXpMZXNuK0VyRFdoUkJL?=
 =?utf-8?B?VnVBaEc2RGRadUZIK3lKTVZuNVNGQ2hUbU9QOGc5bTh5Sko2aVAwb1lHVFdS?=
 =?utf-8?B?RXhDNHkyaU5MbUVVZGh6TUVmVURJUjNnRERJRXh4SmFSR2pLRjdGcHhVeWYw?=
 =?utf-8?B?c04zWmVMSHdVYWR0UTJhOUMxSUdubmRIQWkvWEQ3d1lrWUpPd0REcTdNMkta?=
 =?utf-8?B?M0kyM2d0MHdlVlRscy9WN2hQMEwyc3N3aTIxWmx5REV3MkRrQ1ZRNk53WFgr?=
 =?utf-8?B?UDVsaU53amRRVWxDTlo5K080S3FYQTlYeXVXdmk5QzRNSGNLL3BXeTRGTlk2?=
 =?utf-8?B?TmY1OHFPakY3Y1BnbUxEcXlyVEF4Z0Rsc0hpaUdVOGFHbjZ5ZE1HOEtybnJ4?=
 =?utf-8?B?Mmc4STBGTytoTS8xU0RZM1pwTmQ2MWhCRVVJMVp2UkF3MUFhdE9yTkNpTXNF?=
 =?utf-8?B?Y1BoQjVGYXdPMHkwUlhjbU5WSXllT3dTREFPZ2JpOVJvdWdtbmVlZU9IWXh4?=
 =?utf-8?B?bHpiNGpqQ2xFR3BnTC81RDU0Q0plcUR3VDh0bGdJOFd1NXVaR0VsUnp2TzZ4?=
 =?utf-8?B?Mk1TMmJnT243ZWRZUHQzbVF0M2dVZ0tVNytUejJlZ2NyaDdWczU2cXkrNUxn?=
 =?utf-8?B?SEZmNk91MjU0aHByVkFCRGFHQTFDTnF3SkdPNXNXK3dHSDc2MjU0R204UDkr?=
 =?utf-8?B?cWtZRlplUFAyUExBNUlZK1RaUGtBUEFTdlVUUHdlQ1FMTkQ1N0UwemNPMGE4?=
 =?utf-8?B?R29VaFJWRjlrNmhId2J0d0RWVDJ2SXE0ZW00SWVSRGQ1SXNWVnQvM3ZLZEhH?=
 =?utf-8?B?U09yQ3loL0Y5WTk2OHBxUGNTa2h5QmM4dDZLLzkzOE1nWVFIYW4rNDdJRmJD?=
 =?utf-8?B?K0NnbFBvRk4xN2xUUXEzT0hKRCsrKzREOWVUdHZGYWNkNHNqdUNUbVowTmgz?=
 =?utf-8?Q?aM9TXrF90jdTqbaIuvfS8vXzi7oBhXGTSjJvs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3815C03444B1EF43886F483ADC857A20@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 653a0219-a414-44b5-4f8e-08de78b5cbe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 23:45:33.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+S6sbdIq9RfBdW4Xi5hw6psS1lvb2xTJUzE/ZXf1xuZwErLuNO3LC1Me75YkW6/vKssvCwmQ8Q+ElCqLDglyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR15MB6975
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: vsm_VRVyxjpsBqH1p3hf12vpvitQEkau
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE3MiBTYWx0ZWRfX4tnzHNOiIMcI
 69kKvblbgHfIAHWffnxUtdBpKCTdBGHV4QKS10waW2B6O9dfBpA4vtEklEHHQPqrcMXLEc5PF6Q
 KagWoUNfxBaaFh961EPLIeVghRuWYblPGx1aoLAOyMxuhEiDivkAXLBuCncvLEbDKqSjE9eyVFL
 1RCTZC8nkrkQTT29gb1xlbYjxlwrmYydxqBBhHAlJ0DFAU85/2aIDYKr+Uf+aiMfdclsWixtPRX
 dPep2rEspHr7+UCRrVg1UGV7XhOdFEpqnXIrH9/VHj/5jNOAJMZLDjz4cNf90K4MmmVLL1PBUaE
 Gjkx/2QSgg682sR7ClzJiRNiy3ntDCXPa6cjCOmuWpWnRbc/TLZqz32wNQSe7lMUuYAzDKLJqCf
 GCpF7tqOS01kqYekj3fbQ0YXMl4jQTgjMP6dgo624VQ9MT7eL0m+w2lnawxWama96NPh5A19gLn
 Nc2wcZxHvmwSCL1Uy6w==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a62121 cx=c_pps
 a=BNrqkoHBqsJX0pt4tOnUqg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hSkVLCK3AAAA:8 a=szKgq9aCAAAA:8 a=fLtQGj4U74i0tDip7nsA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=R_ZFHMB_yizOUweVQPrY:22
X-Proofpoint-GUID: TVSscHLNWgj2lsTlKHmq_Jb9d4ssQxN_
Subject: Re:  [PATCH v5 2/2] hfsplus: validate b-tree node 0 bitmap at mount
 time
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020172
X-Rspamd-Queue-Id: 50FDE1E6D6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-79094-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[mpiric.us,mpiricsoftware.com,gmail.com,syzkaller.appspotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,proofpoint.com:url,mpiricsoftware.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gU2F0LCAyMDI2LTAyLTI4IGF0IDE3OjUzICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gU3l6a2FsbGVyIHJlcG9ydGVkIGFuIGlzc3VlIHdpdGggY29ycnVwdGVkIEhGUysgaW1hZ2Vz
IHdoZXJlIHRoZSBiLXRyZWUNCj4gYWxsb2NhdGlvbiBiaXRtYXAgaW5kaWNhdGVzIHRoYXQgdGhl
IGhlYWRlciBub2RlIChOb2RlIDApIGlzIGZyZWUuIE5vZGUgMA0KPiBtdXN0IGFsd2F5cyBiZSBh
bGxvY2F0ZWQgYXMgaXQgY29udGFpbnMgdGhlIGItdHJlZSBoZWFkZXIgcmVjb3JkIGFuZCB0aGUN
Cj4gYWxsb2NhdGlvbiBiaXRtYXAgaXRzZWxmLiBWaW9sYXRpbmcgdGhpcyBpbnZhcmlhbnQgbGVh
ZHMgdG8gYWxsb2NhdG9yDQo+IGNvcnJ1cHRpb24sIHdoaWNoIGNhc2NhZGVzIGludG8ga2VybmVs
IHBhbmljcyBvciB1bmRlZmluZWQgYmVoYXZpb3Igd2hlbg0KPiB0aGUgZmlsZXN5c3RlbSBhdHRl
bXB0cyB0byBhbGxvY2F0ZSBibG9ja3MuDQo+IA0KPiBQcmV2ZW50IHRydXN0aW5nIGEgY29ycnVw
dGVkIGFsbG9jYXRvciBzdGF0ZSBieSBhZGRpbmcgYSB2YWxpZGF0aW9uIGNoZWNrDQo+IGR1cmlu
ZyBoZnNfYnRyZWVfb3BlbigpLiBVc2luZyB0aGUgbmV3bHkgaW50cm9kdWNlZCBoZnNfYm1hcF90
ZXN0X2JpdCgpDQo+IGhlbHBlciwgdmVyaWZ5IHRoYXQgdGhlIE1TQiBvZiB0aGUgZmlyc3QgYml0
bWFwIGJ5dGUgKHJlcHJlc2VudGluZyBOb2RlIDApDQo+IGlzIG1hcmtlZCBhcyBhbGxvY2F0ZWQu
DQo+IA0KPiBJZiBjb3JydXB0aW9uIGlzIGRldGVjdGVkIChlaXRoZXIgc3RydWN0dXJhbGx5IGlu
dmFsaWQgbWFwIHJlY29yZHMgb3IgYW4NCj4gaWxsZWdhbGx5IGNsZWFyZWQgYml0KSwgcHJpbnQg
YSB3YXJuaW5nIGlkZW50aWZ5aW5nIHRoZSBzcGVjaWZpYw0KPiBjb3JydXB0ZWQgdHJlZSBhbmQg
Zm9yY2UgdGhlIGZpbGVzeXN0ZW0gdG8gbW91bnQgcmVhZC1vbmx5IChTQl9SRE9OTFkpLg0KPiBU
aGlzIHByZXZlbnRzIGtlcm5lbCBwYW5pY3MgZnJvbSBjb3JydXB0ZWQgaW1hZ2VzIHdoaWxlIGVu
YWJsaW5nIGRhdGENCj4gcmVjb3ZlcnkuDQo+IA0KPiBSZXBvcnRlZC1ieTogc3l6Ym90KzFjOGZm
NzJkMGNkOGE1MGRmZWFhQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gTGluazogaHR0cHM6
Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19zeXprYWxsZXIu
YXBwc3BvdC5jb21fYnVnLTNGZXh0aWQtM0QxYzhmZjcyZDBjZDhhNTBkZmVhYSZkPUR3SURBZyZj
PUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhOSnUxX1JHbW5RMmZNV0txNFk0
UkFrRWx2VWdTczAwJm09M1hoMVpzOF9SRXVMUkxaV1VlWnRkUE5XSkFuOV91TFduR1hDYy1jNWZp
X2ZEYktIQUdaSExpeTloblZ3aUNkdyZzPTI4LTIwSkllb0lTNTZKWUtjc1ZINEdJTXJwVWdNQW5N
OFVBVm16bkdzaGMmZT0gDQo+IExpbms6IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNv
bS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX2FsbF81NGRjOTMzNmI1MTRmYjEw
NTQ3ZTI3YzdkNmUxYjhiOTY3ZWUyZWRhLmNhbWVsLTQwaWJtLmNvbV8mZD1Ed0lEQWcmYz1CU0Rp
Y3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0Vs
dlVnU3MwMCZtPTNYaDFaczhfUkV1TFJMWldVZVp0ZFBOV0pBbjlfdUxXbkdYQ2MtYzVmaV9mRGJL
SEFHWkhMaXk5aG5Wd2lDZHcmcz1uanhXa08wNnJUZkxMUjFOallxMXZmdUpMdEdYZlBWbVdNakl1
dlFocFdZJmU9IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFyZHVsIEJhbmthciA8c2hhcmR1bC5iQG1w
aXJpY3NvZnR3YXJlLmNvbT4NCj4gLS0tDQo+ICBmcy9oZnNwbHVzL2J0cmVlLmMgfCAzNiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy9idHJlZS5jIGIvZnMv
aGZzcGx1cy9idHJlZS5jDQo+IGluZGV4IDg3NjUwZTIzY2Q2NS4uZWUxZWRiMDNhMzhlIDEwMDY0
NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2J0cmVlLmMNCj4gKysrIGIvZnMvaGZzcGx1cy9idHJlZS5j
DQo+IEBAIC0yMzksMTUgKzIzOSwzMSBAQCBzdGF0aWMgaW50IGhmc19ibWFwX2NsZWFyX2JpdChz
dHJ1Y3QgaGZzX2Jub2RlICpub2RlLCB1MzIgYml0X2lkeCkNCj4gIAlyZXR1cm4gMDsNCj4gIH0N
Cj4gIA0KPiArc3RhdGljIGNvbnN0IGNoYXIgKmhmc19idHJlZV9uYW1lKHUzMiBjbmlkKQ0KPiAr
ew0KPiArCXN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgdHJlZV9uYW1lc1tdID0gew0KPiArCQlb
SEZTUExVU19FWFRfQ05JRF0gPSAiRXh0ZW50cyIsDQo+ICsJCVtIRlNQTFVTX0NBVF9DTklEXSA9
ICJDYXRhbG9nIiwNCj4gKwkJW0hGU1BMVVNfQVRUUl9DTklEXSA9ICJBdHRyaWJ1dGVzIiwNCj4g
Kwl9Ow0KPiArDQo+ICsJaWYgKGNuaWQgPCBBUlJBWV9TSVpFKHRyZWVfbmFtZXMpICYmIHRyZWVf
bmFtZXNbY25pZF0pDQo+ICsJCXJldHVybiB0cmVlX25hbWVzW2NuaWRdOw0KPiArDQoNCiNkZWZp
bmUgSEZTX1BPUl9DTklECQkxCS8qIFBhcmVudCBPZiB0aGUgUm9vdCAqLw0KI2RlZmluZSBIRlNQ
TFVTX1BPUl9DTklECUhGU19QT1JfQ05JRA0KI2RlZmluZSBIRlNfUk9PVF9DTklECQkyCS8qIFJP
T1QgZGlyZWN0b3J5ICovDQojZGVmaW5lIEhGU1BMVVNfUk9PVF9DTklECUhGU19ST09UX0NOSUQN
CiNkZWZpbmUgSEZTX0VYVF9DTklECQkzCS8qIEVYVGVudHMgQi10cmVlICovDQojZGVmaW5lIEhG
U1BMVVNfRVhUX0NOSUQJSEZTX0VYVF9DTklEDQojZGVmaW5lIEhGU19DQVRfQ05JRAkJNAkvKiBD
QVRhbG9nIEItdHJlZSAqLw0KI2RlZmluZSBIRlNQTFVTX0NBVF9DTklECUhGU19DQVRfQ05JRA0K
I2RlZmluZSBIRlNfQkFEX0NOSUQJCTUJLyogQkFEIGJsb2NrcyBmaWxlICovDQojZGVmaW5lIEhG
U1BMVVNfQkFEX0NOSUQJSEZTX0JBRF9DTklEDQojZGVmaW5lIEhGU19BTExPQ19DTklECQk2CS8q
IEFMTE9DYXRpb24gZmlsZSAoSEZTKykgKi8NCiNkZWZpbmUgSEZTUExVU19BTExPQ19DTklECUhG
U19BTExPQ19DTklEDQojZGVmaW5lIEhGU19TVEFSVF9DTklECQk3CS8qIFNUQVJUdXAgZmlsZSAo
SEZTKykgKi8NCiNkZWZpbmUgSEZTUExVU19TVEFSVF9DTklECUhGU19TVEFSVF9DTklEDQojZGVm
aW5lIEhGU19BVFRSX0NOSUQJCTgJLyogQVRUUmlidXRlcyBmaWxlIChIRlMrKSAqLw0KI2RlZmlu
ZSBIRlNQTFVTX0FUVFJfQ05JRAlIRlNfQVRUUl9DTklEDQojZGVmaW5lIEhGU19FWENIX0NOSUQJ
CTE1CS8qIEV4Y2hhbmdlRmlsZXMgdGVtcCBpZCAqLw0KI2RlZmluZSBIRlNQTFVTX0VYQ0hfQ05J
RAlIRlNfRVhDSF9DTklEDQojZGVmaW5lIEhGU19GSVJTVFVTRVJfQ05JRAkxNgkvKiBmaXJzdCBh
dmFpbGFibGUgdXNlciBpZCAqLw0KI2RlZmluZSBIRlNQTFVTX0ZJUlNUVVNFUl9DTklECUhGU19G
SVJTVFVTRVJfQ05JRA0KDQpXaGF0IGlmIGNuaWQgd2lsbCBiZSAxLCAyLCA1PyBIb3cgY29ycmVj
dGx5IHdpbGwgbG9naWMgd29ya3M/IEZvciBtYXkgdGFzdGUsIHRoZQ0KZGVjbGFyYXRpb24gbG9v
a3Mgc2xpZ2h0bHkgZGFuZ2Vyb3VzLg0KDQpJdCB3aWxsIG11Y2ggZWFzaWVyIHNpbXBseSBpbnRy
b2R1Y2UgdGhlIHN0cmluZyBjb25zdGFudHM6DQoNCiNkZWZpbmUgSEZTX0VYVEVOVF9UUkVFX05B
TUUgICJFeHRlbnRzIg0KLi4uDQojZGVmaW5lIEhGU19VTktOT1dOX0JUUkVFX05BTUUgICJVbmtu
b3duIg0KDQpQcm9iYWJseSwgc2ltcGxlIHN3aXRjaCB3aWxsIGJlIHNpbXBsZXIgaW1wbGVtZW50
YXRpb24gaGVyZToNCg0Kc3dpdGNoIChjbmlkKSB7DQpjYXNlIEhGU1BMVVNfRVhUX0NOSUQ6DQog
ICAgcmV0dXJuIEhGU19FWFRFTlRfVFJFRV9OQU1FOw0KLi4uDQpkZWZhdWx0Og0KICAgIHJldHVy
biBIRlNfVU5LTk9XTl9CVFJFRV9OQU1FOw0KfQ0KDQpPciBpdCBuZWVkcyB0byBpbnRyb2R1Y2Ug
YXJyYXkgdGhhdCB3aWxsIGluaXRpYWxpemUgYWxsIGl0ZW1zIGZyb20gMCAtIDE1Lg0KDQpNYXli
ZSwgSSBhbSB0b28gcGlja3kgaGVyZS4gVGhpcyBsb2dpYyBzaG91bGQgd29yay4gQnV0IEkgcHJl
ZmVyIHRvIGhhdmUgc3RyaW5nDQpkZWNsYXJhdGlvbnMgb3V0c2lkZSBvZiBmdW5jdGlvbi4NCg0K
PiArCXJldHVybiAiVW5rbm93biI7DQo+ICt9DQo+ICsNCj4gIC8qIEdldCBhIHJlZmVyZW5jZSB0
byBhIEIqVHJlZSBhbmQgZG8gc29tZSBpbml0aWFsIGNoZWNrcyAqLw0KPiAgc3RydWN0IGhmc19i
dHJlZSAqaGZzX2J0cmVlX29wZW4oc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdTMyIGlkKQ0KPiAg
ew0KPiAgCXN0cnVjdCBoZnNfYnRyZWUgKnRyZWU7DQo+ICAJc3RydWN0IGhmc19idHJlZV9oZWFk
ZXJfcmVjICpoZWFkOw0KPiAgCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nOw0KPiArCXN0
cnVjdCBoZnNfYm5vZGUgKm5vZGU7DQo+ICAJc3RydWN0IGlub2RlICppbm9kZTsNCj4gIAlzdHJ1
Y3QgcGFnZSAqcGFnZTsNCj4gIAl1bnNpZ25lZCBpbnQgc2l6ZTsNCj4gKwlpbnQgcmVzOw0KPiAg
DQo+ICAJdHJlZSA9IGt6YWxsb2Nfb2JqKCp0cmVlKTsNCj4gIAlpZiAoIXRyZWUpDQo+IEBAIC0z
NTIsNiArMzY4LDI2IEBAIHN0cnVjdCBoZnNfYnRyZWUgKmhmc19idHJlZV9vcGVuKHN0cnVjdCBz
dXBlcl9ibG9jayAqc2IsIHUzMiBpZCkNCj4gIA0KPiAgCWt1bm1hcF9sb2NhbChoZWFkKTsNCj4g
IAlwdXRfcGFnZShwYWdlKTsNCj4gKw0KPiArCW5vZGUgPSBoZnNfYm5vZGVfZmluZCh0cmVlLCBI
RlNQTFVTX1RSRUVfSEVBRCk7DQo+ICsJaWYgKElTX0VSUihub2RlKSkNCj4gKwkJZ290byBmcmVl
X2lub2RlOw0KPiArDQo+ICsJcmVzID0gaGZzX2JtYXBfdGVzdF9iaXQobm9kZSwgMCk7DQo+ICsJ
aWYgKHJlcyA8IDApIHsNCj4gKwkJcHJfd2FybigiKCVzKTogJXMgQnRyZWUgKGNuaWQgMHgleCkg
bWFwIHJlY29yZCBpbnZhbGlkL2NvcnJ1cHRlZCwgZm9yY2luZyByZWFkLW9ubHkuXG4iLA0KPiAr
CQkJCXNiLT5zX2lkLCBoZnNfYnRyZWVfbmFtZShpZCksIGlkKTsNCj4gKwkJcHJfd2FybigiUnVu
IGZzY2suaGZzcGx1cyB0byByZXBhaXIuXG4iKTsNCj4gKwkJc2ItPnNfZmxhZ3MgfD0gU0JfUkRP
TkxZOw0KPiArCX0gZWxzZSBpZiAocmVzID09IDApIHsNCj4gKwkJcHJfd2FybigiKCVzKTogJXMg
QnRyZWUgKGNuaWQgMHgleCkgYml0bWFwIGNvcnJ1cHRpb24gZGV0ZWN0ZWQsIGZvcmNpbmcgcmVh
ZC1vbmx5LlxuIiwNCj4gKwkJCQlzYi0+c19pZCwgaGZzX2J0cmVlX25hbWUoaWQpLCBpZCk7DQo+
ICsJCXByX3dhcm4oIlJ1biBmc2NrLmhmc3BsdXMgdG8gcmVwYWlyLlxuIik7DQo+ICsJCXNiLT5z
X2ZsYWdzIHw9IFNCX1JET05MWTsNCj4gKwl9DQo+ICsNCj4gKwloZnNfYm5vZGVfcHV0KG5vZGUp
Ow0KPiArDQo+ICAJcmV0dXJuIHRyZWU7DQo+ICANCj4gICBmYWlsX3BhZ2U6DQoNClRoaXMgbG9n
aWMgbG9va3MgbW9zdGx5IGdvb2QuIE15IG1haW4gcmVtYXJrcyBhcmUgaW4gdGhlIGZpcnN0IHBh
dGNoLg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

