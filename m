Return-Path: <linux-fsdevel+bounces-77617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPblL6sklmn0bAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 21:44:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2FD159809
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 21:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E5CA3005332
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 20:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FA3318BA6;
	Wed, 18 Feb 2026 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eqRerM8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6F2DC77F;
	Wed, 18 Feb 2026 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771447461; cv=fail; b=hODMWy5VMxEM+MNTNwiy21gS2q79pSn4yzZF/G4e/CB6FPFt/vQSRNkxPCsO2tgYWw8Wu0Ywb6Sa+wVvfU37gCwL3xyRkO72ctMRfUBlyyMfO0XEUrUZLQDpKdbpDCyDCCR/D+YG61KHXRmqUuSFCqnUEEWx2ZRsbpsf2y6l+WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771447461; c=relaxed/simple;
	bh=hc9ABf4R3yQQoLE5IJcXO4FlW6aDMNC5+fpnOAv2bGs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=hhQw4gIcugcpnxho+j6TgOKmwZEouRjXiw5WwhcUL3V2bwTJHMJ1PBZ3Y/JFxLLd+NwQySb+8xHgrKjjWKerWuyjw4r92+G8cvN04rHwqCZesfC993Orb1N3tWB5MB8sFcZ/DjTTvYKm0TbxSX9kQm1XAk+lzxdOSzlKwbOHmZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eqRerM8U; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I9VomW3759249;
	Wed, 18 Feb 2026 20:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=hc9ABf4R3yQQoLE5IJcXO4FlW6aDMNC5+fpnOAv2bGs=; b=eqRerM8U
	1WpnXb/NgA/91Ckf9gaqvcLYDkwESAzQj/pDYNGREXc+OnXwFUKhMXZAKPCAxUfm
	cIrRMif3hAZIIChjHVWW+v96LzcqlxEGAjvCQWmCzpwXTwllKSGT0rc8Dtia14Eo
	yWi8FUVazTuFJdKNom9JK/ijfXWt4HfavOJH8KK+xTFKxGfTR09vD/WGlr320dA6
	vdjJsiVqn+1+hYpyrELQ2btV3yIfakpUvaF59zsoTkaE3x82q8HFgcwS4e3dd3pn
	iWOjRvWh2dfoi1PJkSlA37FdcXzBJVulaBqc1KKQmAwMYWahtYH6bmrPgKrOe2el
	bhHPByhKf+7NQg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjj15d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 20:44:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSuW6F0wEK+4Kga6WWd2joA5MsAA3TYhsejDRRXC8vSMfsVPgWLtqLJL8NDV8uSuhm+ww21q1iEgPW8MjOwjHnuLowCAiEFFDc/zLSxgpxZg6g0Id6GY0mL7ypkoZLx3kouNZDVIyreJesYNJitb2zSH96WOEsuMxAzJ7jLlmBy/oVMRGBrvKQUIxSMtjy/iQZJbYy6WnixiIjh6xT7HbwfixSzks0e2R7Rer4asPIGxE0lZzganB6+/9aPZTebuhEqVgAZvPuoePD2g9XWa5lfSSXLYHaL/38+Gyo96PhCSEHTB3sV7AnauqgKdJAEtJiGu6hjp/kyPbE31uZV+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hc9ABf4R3yQQoLE5IJcXO4FlW6aDMNC5+fpnOAv2bGs=;
 b=iDmVdIyhb9zp/oW6ZfwyBosogZM4jRJpEjaZ6oAR+5kAohR+jyAiTa9PFckAz1+OPKDgmspAwhyjRyeVTroSejzfl6k4smZtc/qP03cffgt9ePSktZQwvFuRXeKDTjb1C6o6ZpNkaVYdhNWIg9LEeHHs+9TTkKZFkzAgToRrSxdw1rJD9pH6S5V6cO7yZGtprnoZ3jnBucH723UcsgSiLf/OQsD0cL4Ldu+ILL6Cmnw5rAknJZXWEovTqWNtkqGOgpqEd1v7vmHgBDdllLgxCPGrloNwwsS0dMAzuLyKr/7TQfQS9zRNKSdXhzdVMXJaxU/fxBSwXXjqPTtjXHRrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA0PR15MB4045.namprd15.prod.outlook.com (2603:10b6:806:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 20:44:12 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 20:44:12 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ethantidmore06@gmail.com" <ethantidmore06@gmail.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] hfsplus: Fix error pointer dereference
Thread-Index: AQHcoQ2PfLuIW3M4xkq6NJvekMIQCrWI7JCA
Date: Wed, 18 Feb 2026 20:44:12 +0000
Message-ID: <4c416deeaa61d93abf3a825cbe15eba9e1e23964.camel@ibm.com>
References: <20260218193305.11316-1-ethantidmore06@gmail.com>
In-Reply-To: <20260218193305.11316-1-ethantidmore06@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA0PR15MB4045:EE_
x-ms-office365-filtering-correlation-id: efc5c045-2c82-4a07-7b61-08de6f2e7918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHJJemV4bit6QTdBTm9HTXNyam1ZRmVSMGZFVi9URmhIRXRRU1ZMcVh3ZkFP?=
 =?utf-8?B?TjB2Q0kwWkg1Mzd5dkYra01TNkdxKzNyL1RYMHA3bVVaT2dRVEw2ZVJlTFBP?=
 =?utf-8?B?akFBQ0V1ZHpKSUFxYTVPRGJLNXJZaHJyc3J4WmlEVHNabkpQYi9rMy83bEJO?=
 =?utf-8?B?MVZVUEZ1MFpoS1Y1UFZoc2RKSlZFNmRkTEZRbHpLT3NRZFAvakk0TkVJbmp4?=
 =?utf-8?B?S0JiWGZNcVJVajk2STJpTnJ1L1ArY2VkcDVWeEx6bzFnSG9FMVpSSURLMWtU?=
 =?utf-8?B?REltcXNaR3htMXRnNXk1WFVja3ZtOEN2eU15RmkwN0pSZVJ3S2JLZ2wrQ29F?=
 =?utf-8?B?cWxwODNhVExINHBpWmdjM1YvZ0EwQzVhSFBwQWFSZE9RVkdlSU1hRm04Y0Zs?=
 =?utf-8?B?TTdmQ2tERU9JU2xsZGRkYzVrdHVaODVxbnNmVkZqRVRaQmRJOGxaZG5vbVcz?=
 =?utf-8?B?ZUErcVdWTGQ1b1RMVW1CNkxRM2E0OWMzYXprNW9tNzlZVFdqTHNkd3JpSDZD?=
 =?utf-8?B?U0NhQUFkcFVMYjZBazc2c3d3bFdzaU91ZXpQNXhJajBCT1J6RC9wZG5YcGhj?=
 =?utf-8?B?SG5jZlZUMHB1N2tNU1VBb01vWldNNFJNbmVMUHBBaUhGdng2WUVEOU14RTJO?=
 =?utf-8?B?ZHBJdy9MekVTVFlwVlpzTWU0RlF6Rk9IS2sxU2ZLanNmbkx3azNQUW0zVUxn?=
 =?utf-8?B?NXR5S1ZaOXVNV2doeUNJSzhSZzJVTFVERGdsVWFQR2hSRm1FbThRZzhKN0dp?=
 =?utf-8?B?cFY5TUdOSEppVW80dXpyeHZNMnVYc3k0aE9aL3BpOXF5M3R1c0ZRaGtJTWx4?=
 =?utf-8?B?b0l5ZTNrK3E3WWVLRXEwbk44MmIycmtwZTBFWVgrODNnVW1IdWhKR1p6SzNB?=
 =?utf-8?B?cXNzWG04K3doc1F1UWpjU00vc2t5VkRqL0V1eGYrSklNRFpkMk01QXYvbzdl?=
 =?utf-8?B?TFMwblZ2dlA5RENVTzBuLzJHV05sQXlwTDNZbzFZZjY0alhlZTJhUmQ2WGpY?=
 =?utf-8?B?SzZ5NEtEakdRcThLOERHQ0d2cmlmeTlUS2Rxdm1CekF2Rm1NQ0lYWmJ5SzMy?=
 =?utf-8?B?dWN1Z3RmSk1qL0VYOWxDYTZoNTBmQkRUSG5JVTQvNFpnVVhiaEFYbmVwdFN1?=
 =?utf-8?B?MWJVZ2U1YmlJZk9ZQnNob1VjempuRVFaTm43RnNrS3E1WXJ4QlFPV1lNTVJV?=
 =?utf-8?B?N0VsRXNMaHkrcHU5bWw4bGkyWVVuSEcwRVloMnlXd0dwbldCNzkvUmJNQklm?=
 =?utf-8?B?VlVGamJrVk10M05QTUV4c0FiV2lWY09Oelk3VWo1eHQraHRxYitWZ2tTNUJq?=
 =?utf-8?B?NHBWYzJLWWI0VEs3aTBBTnVZVFRlTHBYa2N3bCtGd3Q5VWhML1AxamRnOUc2?=
 =?utf-8?B?b3VRUEVCam9JRHdMMTVUNmtWSlZQK0lGRVVleitFWmc0TTlPcTNwQ1pCcUNn?=
 =?utf-8?B?VlozRkpEZzhaQ2JVQ1BKM2J2N3Y0andjWGwyYzQ0Smh3dEE1YnZnOTZMdU1Y?=
 =?utf-8?B?NytZV045WWRQYUd6UktoYkhNZ1FMMlZhanRCZWFYWGhiYkhIR1ZOSnp1VFpC?=
 =?utf-8?B?cmtsYlFCRXJYdGVtRXdjbmdJVldJWExYY0tFU29ZSzQvc08yTDVsN29SbWZS?=
 =?utf-8?B?N0M5N2ladnh0MFNoSmZhUXVtVEdHMWZjVVptbWExUmZFK0psTlg5OGxMQ09n?=
 =?utf-8?B?R1djdGd6bThpNU5MaUtHU1JlVWl1S3JOL0pnTVR0cEpGZm9NZmM1eGMxeUpq?=
 =?utf-8?B?NnhEbndoN3c5MFNvUTlId1IreXVkYzhWbVFNMEpPYUE0WmpYdEJwcWg2VlJu?=
 =?utf-8?B?T0ZiY2NCZ0JMTHhTZmFLVTQ4RkhHZDNvcDErNStRamlLZE0rSnRhdFhZSko0?=
 =?utf-8?B?WFJpVDRUK0NLa25vSHNTRCtZUGh3bU4xdWRtbFpNQ3pFTXlmZ01aV0Fkc2tj?=
 =?utf-8?B?d0lEWEEvNDFORncvR09WSUYvNDRHc2hBblc0VUFrNGpseWx1YjNkVWpiaUdo?=
 =?utf-8?B?WEJFVnptZVVnOUxSWDFnOEhKUXVNb0VVK2RYRmd3S3JzNmRTSHlhVERhR1lV?=
 =?utf-8?B?M3Q3TGw2MGVXenp5dTNxSG82N1A2dXdnRWw0TW1Bek4ySUhmaUNiRzNDZ21T?=
 =?utf-8?Q?WcuI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVdPQ2lxc0owOVVEZE80dEhRR0RzZ3c5S1V5UWQzY2M1ZGR6RGtqS1ZPOEN1?=
 =?utf-8?B?eHJKTUMyeWdRRkRiSEVUQWRiL04xTDNpa1pIM1hadHV4eVZnMGlHdGxGVDJl?=
 =?utf-8?B?S1Y2Tm0rc3YxUFRuYnlLSFJES3RPRmlhYkMvTklOMzRqSjdvQmVKSDVUUFJ5?=
 =?utf-8?B?d3dGS00wcDNqUGtSaVJJTHozcmE3Vk9Udk0xN1BsdVI0WXoyQjd2MkpVMDlD?=
 =?utf-8?B?d05yMjNLbExuWWVENUt0cFNGaFU2TUppcEkwOG1FZHdKeEhXQ1VqQzF6K0h2?=
 =?utf-8?B?VU82cHpEQWhUWG8vdmhlTXh6cUpmbzNHemc0L1dZSlRCTmo5RTA4d08vdGcr?=
 =?utf-8?B?VGlsTWoyL3R3ZWNVSThUVE5MeDZwbkZaVU41dE12Tm5LSHNxSHZhbzBmWmZj?=
 =?utf-8?B?clNwaVY5TG5sUlNDcHBxSGVHdDBHWjN1eWZXNEJkYUV6WFA4L0JOU3g0UWs5?=
 =?utf-8?B?U3k1MUxMUnNsZGFYOWxpeWtVNzY5NURMY3pySnhNWG9qa1BHbUNFUjBDa1E2?=
 =?utf-8?B?T2RDTFpvSnJJMVBmUUdCYUhUcGREKzFiQitoNHcyS0gzZUc1eUpIL29jY2dl?=
 =?utf-8?B?L2Foc1lJbGZLV3JpNU1OakNyY0NGYnV6dng4cFJtUWhvU1c1c2ZnVnNuS29V?=
 =?utf-8?B?SmJqY2REaWk1K3VIU2d0Z2xSaXlqWXFIcmpiRkpGVHk2SHhoc2RtYTFpWjJu?=
 =?utf-8?B?MDNQci9TRXJDQjJmem5zYTgzUVJyTGhmZXFJTHRqMXEyUG4xY1QxSGFGVkxM?=
 =?utf-8?B?RTd3ZXRBS2xnZE5VYXhNRXVqZ3BEZlZrSVE2bFVtZEVkRW1uSzRPN2w2SkZY?=
 =?utf-8?B?azNCckhrM3dnZ1Vsa2FtdCtFejc3aEpnTVE4MFVKWHdGKy9Rems4NmV4bEQw?=
 =?utf-8?B?MWpBWTBnK2FyS0Z3UmJIR0k5NGkzdmJONzJwdW13U2FNdlU3b0VlZTZQTVR5?=
 =?utf-8?B?cDZrcmdidzhvdkpRUU0rT05taHRyNVlwRmQ1bUpoOGx1bjNhRDY2VjkxaXFk?=
 =?utf-8?B?a0JlUmp1UDllcHJWTlBOdkJhVlJIaVkxckl4VmM4by9xTTd2MXU4VFArUXpJ?=
 =?utf-8?B?VFpIVWc1Nmk2VHFIdndCL0tyYVdXRXhoeTYzZDlIczc3Nlc2NGp1UDhGWTRT?=
 =?utf-8?B?SHJkUi8yZzlnek5KMGpZdkJ5eFJlckptc3pkcWVhaXpMMlNRL1RmVndoWUI3?=
 =?utf-8?B?bWE3Qk8wdWltbHVjZDEwOWZlcTJJYzE4ZSt0a0haQW5UYzZoWDBOM2lPNHJp?=
 =?utf-8?B?OU1RYWFzM3RseUJXN3RtU2pIZktseWVhMFlLcTFkQ0tQbGJqUGtVbzRvZ3NN?=
 =?utf-8?B?SW1SMHFEaTVNc1ZPS01tY1dIb0g1cnFuN3lkRlFZenJlZ250R3MyQ2U2blk1?=
 =?utf-8?B?Z3M5bnNZemtROGFwb1lCSXRQYUE5bVUvTURTaGExNHdkNkpBbDdrNHd5Mms5?=
 =?utf-8?B?ek5IYWJ3Z1IycUN3Zi9XT1pmZ0ZPYVpEdDVuaVBvaWo2dE5mNUR6NEM2UnNG?=
 =?utf-8?B?ZHd4V2lrVHlzSWFCa0V4ZFYzanEwWThpZmlydXc2d0V2MjAzOTE5dUZhRU9B?=
 =?utf-8?B?Q0FyRWpQTlN0MG1SaVNCSHhja2dBV3ZWSWVJY1l6d0FabHhDMTVBQm95eTRv?=
 =?utf-8?B?SXpNN05IZ1FjeTd5TTliSlZMOWQvbGNNajVWOVJtamdmMWFzREkrNjhjMGxz?=
 =?utf-8?B?WnBBbHJrUHVNdEpXNXMvL0RYU2dYRE55RDZOa2R2WTVUTVBOVCtHeDZpSW9Z?=
 =?utf-8?B?aGoyamdINTFCV1JxV2xuU0M5QTg1SXduZ1FnbWVhL1BySFdPa0RxOGw1d0dJ?=
 =?utf-8?B?TkZ2aVRXM0ZReFN6RXZlU3luUWxTUENjL203VEdDK2c3K05wNmJlVWkxd0Ns?=
 =?utf-8?B?UHV6Uno1MG5JczMxRTgrNlNLRjhJaFRma3E3T2tORWhjVE5USFRRd012S01H?=
 =?utf-8?B?aDRjUEZUZzdSaktwOEJ4ais5Q0cyd0hHcWVqaXEwWFRpM1FJN2w0Y1JPZzhs?=
 =?utf-8?B?QUJCYlN4cmE4MEVvMGlKb1crSGpEVFZJY1V2K1dBQk5ZRnJOMERkYjFKNUUw?=
 =?utf-8?B?cHNlNGZ0ZDlFbnZWdlM0VFNtcnptNG9xUngyQ3hBaHBPMzJhNDFDS1NyT001?=
 =?utf-8?B?WlZqSTJiekZzQVhERXJUZmQvRG9PU2pXWjJzRWkySFBCTVhqWDNxRkJJVHJQ?=
 =?utf-8?B?dWFHR2t1bFk4MWVCUk5hcXl6TG1HM214cHJKcVI1U3FhNG41OGJmMXZLVStL?=
 =?utf-8?B?UFpRQlRqY0kybUFIQ1ppa00vaGRldkVpWEZFZUxXYWw5ajhaYkZYMkphd0dv?=
 =?utf-8?B?aWtIdDhTSk1TaklHWHVZOHdZcGxqWEgrcUx0NkcvdmNwbUU1Uk04c2FoOTUz?=
 =?utf-8?Q?zifzRi2r7loP3YPc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CB4F0ABEAF3F94F803173B79DD2D4A3@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: efc5c045-2c82-4a07-7b61-08de6f2e7918
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 20:44:12.2853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rU2bpIvqhm9P4D9hhNVr4WQA/R5nyQGdULRvS5pC2J94OGQyWrza6kIX/WEJdmpfmDk8UyBbKSCp5aab8IHf7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4045
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YqKSXDwa8F20uENun-UxquupFl6EkKxe
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6996249f cx=c_pps
 a=aX6hwv3pUrsX0fnHaj1tZQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8
 a=G9rIxY0Geut4SF0C2hYA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE3NyBTYWx0ZWRfX3V+hOtJG83Tg
 mglILaQx/G53d0iHzsVKGkXp6Gsu1hH88xVrA3zlapUTkhnL4SCbKwnN0BsQKJmwL4UHWAs2nOi
 SN9XY0T4Nbe9tzCVd9EPhqg6hd3HEdR2n44bZCi4yktG4xujXC8BxqoHhEIroSi63NeFkgl4Cuj
 rLGzhmAtxxad/2rE04p3CcNb7a24wodkABg+STFeiH8mw3q7LIJRjIKSfpVY4FYwUqyS9xoK1dG
 H0oePX1gzJ50HUX/99/HozTo0diYtljOSaRMIBndSJEORfRl2u0p4TwwbfuIfDhFiPp9cwXOUkk
 BFwyQNL7bnX6EkjsldpYZVI1r86ZWNo28IVct3P2ygfKasgbJtQM9WNiO/vOTvYHXBGyixCgyf4
 yvfqdpsFI60J4Dj78hFomAgf+3f+QZD9lENxG/LDIBv+vmowUcvFv6yUsdhSB3Wb3vcJgcTW2Ra
 z52gWCQVgFt8Mt4M3Vw==
X-Proofpoint-GUID: 4BtAEo6FbHjBgbtaUShYPW6JusiuubxR
Subject: Re:  [PATCH] hfsplus: Fix error pointer dereference
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180177
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77617-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,physik.fu-berlin.de,vivo.com,dubeyko.com];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB2FD159809
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTE4IGF0IDEzOjMzIC0wNjAwLCBFdGhhbiBUaWRtb3JlIHdyb3RlOg0K
PiBUaGUgZnVuY3Rpb24gaGZzX2Jub2RlX2ZpbmQoKSBjYW4gcmV0dXJuIGFuIGVycm9yIHBvaW50
ZXIgYW5kIGlzIG5vdA0KPiBjaGVja2VkIGZvciBvbmUuIEFkZCBlcnJvciBwb2ludGVyIGNoZWNr
Lg0KPiANCg0KSWYgd2UgdGFrZSBhIGxvb2sgaW50byB0aGUgaGZzX2JyZWNfdXBkYXRlX3BhcmVu
dCgpLCB0aGVuIHdlIGNhbiBzZWUgdGhhdCBwYXJlbnQNCm5vZGUgaXMgYWxyZWFkeSBmb3VuZCBh
cyB2YWxpZCBub2RlIFsxXS4gQW5kIG5ld19ub2RlIGhhcyBiZWVuIHByZXBhcmVkIHdpdGgNCnBh
cmVudCBub2RlIHNldCBpbiBoZnNfYm5vZGVfc3BsaXQoKSBbMl0uIEl0J3MgaGlnaGx5IG5vdCBw
b3NzaWJsZSB0byBoYXZlIG5vdA0KdmFsaWQgcG9pbnRlciBmb3IgdGhpcyBjYWxsLiBJIGRvbid0
IHRoaW5rIHRoYXQgd2UgcmVhbGx5IG5lZWQgdGhpcyBjaGVjay4NCg0KVGhhbmtzLA0KU2xhdmEu
DQoNCj4gRGV0ZWN0ZWQgYnkgU21hdGNoOg0KPiBmcy9oZnNwbHVzL2JyZWMuYzo0NDEgaGZzX2Jy
ZWNfdXBkYXRlX3BhcmVudCgpIGVycm9yOiANCj4gJ2ZkLT5ibm9kZScgZGVyZWZlcmVuY2luZyBw
b3NzaWJsZSBFUlJfUFRSKCkNCj4gDQo+IEZpeGVzOiAxZGExNzdlNGMzZjQgKCJMaW51eC0yLjYu
MTItcmMyIikNCj4gU2lnbmVkLW9mZi1ieTogRXRoYW4gVGlkbW9yZSA8ZXRoYW50aWRtb3JlMDZA
Z21haWwuY29tPg0KPiAtLS0NCj4gIGZzL2hmc3BsdXMvYnJlYy5jIHwgMyArKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVz
L2JyZWMuYyBiL2ZzL2hmc3BsdXMvYnJlYy5jDQo+IGluZGV4IDY3OTZjMWE4MGU5OS4uZWZlNzlh
OGYxZDk4IDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2JyZWMuYw0KPiArKysgYi9mcy9oZnNw
bHVzL2JyZWMuYw0KPiBAQCAtNDM0LDYgKzQzNCw5IEBAIHN0YXRpYyBpbnQgaGZzX2JyZWNfdXBk
YXRlX3BhcmVudChzdHJ1Y3QgaGZzX2ZpbmRfZGF0YSAqZmQpDQo+ICAJCQluZXdfbm9kZS0+cGFy
ZW50ID0gdHJlZS0+cm9vdDsNCj4gIAkJfQ0KPiAgCQlmZC0+Ym5vZGUgPSBoZnNfYm5vZGVfZmlu
ZCh0cmVlLCBuZXdfbm9kZS0+cGFyZW50KTsNCj4gKwkJaWYgKElTX0VSUihmZC0+Ym5vZGUpKQ0K
PiArCQkJcmV0dXJuIFBUUl9FUlIoZmQtPmJub2RlKTsNCj4gKw0KPiAgCQkvKiBjcmVhdGUgaW5k
ZXgga2V5IGFuZCBlbnRyeSAqLw0KPiAgCQloZnNfYm5vZGVfcmVhZF9rZXkobmV3X25vZGUsIGZk
LT5zZWFyY2hfa2V5LCAxNCk7DQo+ICAJCWNuaWQgPSBjcHVfdG9fYmUzMihuZXdfbm9kZS0+dGhp
cyk7DQoNClsxXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xOS1yYzUvc291
cmNlL2ZzL2hmc3BsdXMvYnJlYy5jI0wzNzENClsyXSBodHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC92Ni4xOS1yYzUvc291cmNlL2ZzL2hmc3BsdXMvYnJlYy5jI0wyNTMNCg==

