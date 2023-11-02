Return-Path: <linux-fsdevel+bounces-1801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723037DEF52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 10:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523ED1C20EA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2711112B7A;
	Thu,  2 Nov 2023 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="TAICW6i1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68533125BD
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 09:59:16 +0000 (UTC)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAC5112
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 02:59:11 -0700 (PDT)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A25cgY4023067;
	Thu, 2 Nov 2023 09:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=3uIPvyGMUc34q3xm+SNWbdRV5KP5nxH0fiUVoKgnqT4=;
 b=TAICW6i1nibtvDyqpLWy1ujSkvi4Nsi519jCS5Flvx2fbg0gju4Vc5RbPM1OTuvWfUR9
 5iOK3Zj8kiTRORwQW8glvjal0IuA3a7aidS1jZEhFfPj/I6XBUtVzSjcs4q/n/cEs5lc
 EmLQc3V8zXluP4Oc1SbXzLuCmDNlnHwu6VR2UnuVLE6Nst/pnJ1/DPMTPAWeJmgKNdG5
 hiIfBGQm56qda0Y69NFyeP6f+qqC4DJDGjZ73SHIkFyNqUY3RzX3RdD+GP4pUvDSzfZd
 2lo7trHQp+c736Od9OSPKwjF3NSio1tzz65ncJaQzTxUXTLKuVNSPR2WAYxEC6vDMmTj /w== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3u0r6mdhtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Nov 2023 09:58:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7vOitjVpk1col/6JyXDQUfyN8WhpiHgxBlja53ebUH6fMM/I3IpceOaG/AF7yi1E1s/sAQEj4dQbMil+p3M7fuNyZWjQWfIysJp9Tw/eth0TT2Ek1C2/wbrdeGdXXqB7y7tRuLDjacJ6SR242nvjMmn0VX7SfOQP+dW+D5hxPyQldN5IeWpbgrvpC4eTETkpb2UdI33KB//4nrTACEX4tVQZVM8LiZ54OSL5DPBxRUDM6Ep5LD11R7igVSbcshSD8nEmOvchCwW7aI/AudgK0xLkg0SjtQkYJrVoQ9l1YhCrBGAwnZLILylhwthLiipginSb2VNtBQvez2eSaA2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uIPvyGMUc34q3xm+SNWbdRV5KP5nxH0fiUVoKgnqT4=;
 b=NHDLN2HQJ2P1Q0YrELv8O8Fw6bUvgK4MaTURhenyqdWYlPqjrorhw9BDvnIWVphiXuunKz7fUHzA2HufplFAPPqUHuduHgZRezCpP+lHvkU7ZGCb9NoywrTsTC+XWG6IgbUX3cklbKbEcUjLDRWL3oOiJfgFzT5JHrRru7GGy200kTJEpEyc6/uyOEQeHg0s6+e3FC689Dvo4FWVVWvNbHR9EFevCu6ncUmfcw9PDcTO4GXHWSGXKQNBLxEjzRb44G2tvTnOiN5N6Ys2Z5Z9ankdqcz9/mLL/2BGxLuekU9Fa+MlNIMQilquG0hoDKOwh8CsF//UKNi5Ys+8NV4D+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB7934.apcprd04.prod.outlook.com (2603:1096:405:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:58:51 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.6907.025; Thu, 2 Nov 2023
 09:58:51 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v4 2/2] exfat: do not zeroed the extended part
Thread-Topic: [PATCH v4 2/2] exfat: do not zeroed the extended part
Thread-Index: AdoNcu9nRDbe3wI6SL2iRFBJj5Gtdg==
Date: Thu, 2 Nov 2023 09:58:51 +0000
Message-ID: 
 <PUZPR04MB63163B0DB9D9894ACCC6760E81A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB7934:EE_
x-ms-office365-filtering-correlation-id: 71c1e13c-6f20-4dea-47f0-08dbdb8a510c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 N8uJuXyMQDjYteQw+q5qfqtgQ8RyWPuY1OgP5FiwCC29DjfLWvAM+Tg/T287ZfiT5n1ycHh+vNpxLyOYROmLY9s2g2HtJIjU37zgtRn9l0RXxKluTkKa9mDKy+tTWJfhp6IfWdy+a/tk25cNWkC6FK73wF1mQVv5R0a5MEnevSeNMxNAM8h74lasaO2yeRWnYmf6Vwiiul9DgpArLWU3LA6Fu2xMz+yN5SQMJLmUnndvay0iqq4VKPcn3hz1acwM8h2+3VLia+zum4oTbNSPNSy/jRVsp4vpIFvqg6nIBkaHm0QaSM8VSDgzDtttXiXc5xmOEYh/4nIfawqUMNrp+fWVUX+INEMJ6sNgkbXTrmD/E77puuHRjY9r4wf+DSVFxRqc6HXpDzqHL0ul02ygljs9p0uWK1WDqeD7tZW2iG50hTSWm6dOAKARzRlaUO/gziivdZ6Uw50hDogONk9XLIPKFjx99M9/RPR4ApFrri8SGFN16l0XClOizKtb0JxKRpRAnUMpk+I36bvGxlrcPPr6XmaABKtp7RWFcMTmS3mcEghunYMWwJyOyTzUPsP6D3+gFBr+HzZT3ofTDqetgPvXonXQlCRD3q5uVs5LdbTo+CECbK1fypsneJZbMNN6
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38100700002)(83380400001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(38070700009)(52536014)(2906002)(122000001)(86362001)(9686003)(478600001)(55016003)(82960400001)(7696005)(6506007)(71200400001)(316002)(76116006)(66446008)(66476007)(54906003)(107886003)(66556008)(110136005)(64756008)(66946007)(26005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MXVicS80ZmpRcUtZMVNxSFhlTkx3bWs2b2pkamN0cTJpejRCZWsrY0l4VHpW?=
 =?utf-8?B?ZlB5eWQzN1ZVVFlHVlNSZGtwUm53TXlhYVhTbUtBOGxYMkdWelRabnVHUXZu?=
 =?utf-8?B?UzdFamczUnU1RFVrMFUzSFRibFVhUVZ0OUhEQU0rMGR1TTRWRVI3Q01keXR0?=
 =?utf-8?B?SytlN3lLdC91eDRUMUZSRzdsZ3pYanlMbkZqdm1ZWmJXeWVlZXYzQ0QveFp3?=
 =?utf-8?B?TW55eW03d3pCaGJkWGFRK3pjK2ZnNE1mUkIwTldWOXduTG5QMGQ0YzFoRmZv?=
 =?utf-8?B?OTBEMUlIZGlmVGxQTWJXMHFldXNCWnFtVjdyNitDbStEeGdESCt4VmUxdjNK?=
 =?utf-8?B?T3lTK3Bodi9HcFc5Y1hrR1p5MTdWMklGTDZYTWxTVXVIcllzRytvbDBjR2VS?=
 =?utf-8?B?RUwyMlA1dGhTZzRtbmRPU0JoQzdlY0ZUdExJZDR5cWVRcWlnandtVjlKbk5w?=
 =?utf-8?B?emtkZzZ1aGpXeHNlMTZJb3lreFFiTlFkZjNYeU9DdTVjY0dzL0VuV3huYXB0?=
 =?utf-8?B?YUVabWhrSDFsR21iM2FkTUp3NnptamVvZ1RLQW44R0J5aXFOcHBVZnBUL1hI?=
 =?utf-8?B?OU9na04yNEJaOW5oVENzVytOdGpsMGFCRXlMYXNTeXR1UDJycVd5RW51MG1K?=
 =?utf-8?B?dFArWEMvZkJTMWlCL2hMR3VDejR4cXZwbWorOEk5ZFM2aU1MZHhVTFphVGZr?=
 =?utf-8?B?QVJ1WHV1ZmJQaERDRGI2M1JGdUdKWUx0ZTlNdEhlMjc2V2IvMytMbHlNVDNR?=
 =?utf-8?B?OXlGQ1RpUE1jTkJXTlgrNEprNTlINnhaZ2RyZjdtVTR6UXVVcUJPNUcrb1RX?=
 =?utf-8?B?OXQydHB2MldXUXJiL09OMmRRWGIvTnpjeVFIaGpRTDZ4K1dkOEVaaVM5RklC?=
 =?utf-8?B?NHF0T2F5YXNQU2R4dVdndzNMNkpIRlh1Wm4xVlp1alczMTAvOS9YTnBNRVFC?=
 =?utf-8?B?NnpHd2U3R250NXNiRUcvdStvT0FwYkM2WVlOZXphZWdCZTVER3ZGSnowSmVW?=
 =?utf-8?B?OENqSkVZdjVBNXRHYS9Tc09SMXRRRGZHYTdEV1VEN3F3ZmtjeDNNNWl4dk1r?=
 =?utf-8?B?UTM5b2pzNm1yQzRVenJUSm1TOXB2NDVBcEszYTR6aWhKT2dvY3V6cEJlckgx?=
 =?utf-8?B?ZVFNN0duWHZaeWludkhjNEhRdVFCb2JNRmZoK1J1SGs1eWdxaVQ5SVc4bXkr?=
 =?utf-8?B?R1dxYWpKYTg3b1J3MnViczFoaU5jTUJqSXE0bW9EaE8wdFJoeFhQZnMxZk9W?=
 =?utf-8?B?MXFlaDZlbm5YWmNBQm90VEdHK2tKOGI1TmdPcGpuc29YN1Y2NVFlWnRQUHU2?=
 =?utf-8?B?ZEFNdEJmZWlaWEE4YmxjT1FPQmhzQVRvekJHcUgrdlpvVldOQjE1bjcrUjYz?=
 =?utf-8?B?S3JFR2I2M2RnWlVjSDc5S3pNMTU3TGZzRDREZ1MwUlhkSXVRc2FzUnNESEtx?=
 =?utf-8?B?aFUxNWp1ZnZRUlV1bW1YWVVHVmlrZVlJcjB6Z08xanhDbDA5TkIrR0pjM3Vp?=
 =?utf-8?B?RlRVTGVRRWNNd2xvSjJJQ05SdUxOYUZ3MWs5M1RFaTlZV0NSWUJlNVgybmt6?=
 =?utf-8?B?L2paRkFLcVRKSTZNUU5RNjNUUTErRWxwQzYrTnEwVjMzVzhUOFJRRzdzaVFl?=
 =?utf-8?B?U0dGZHZWWkwwUjJaS3V5Q3FHSXRDWENXcHNjRHpzU0dCdlBEVWFIcHltWDZo?=
 =?utf-8?B?L09PQU5JTXlpUmxNVWIrdXBCY0Y4YUZrc2QxYnJBajVFazlHM3NIUzEvYmc3?=
 =?utf-8?B?QzdDWDVGb2RaNVRBZm93ZTRqSCtyQnBGTnMyUEZ0MlU4emtlOUN5Zk5xUDAy?=
 =?utf-8?B?WnNwakR4T3F5UXgwQmVTUGFudW1YVGR6QTRvaVlMU09qSW13S1ZhU1g5bWdY?=
 =?utf-8?B?RDlDTzA1a2dCalVwN3dGWGdPc3JPbUxNbklDeDgrdXZwbE5VTHFkdE9qUUlw?=
 =?utf-8?B?UUJyeFVmSmtiMjFKdlF6NjJVYWFXczBtOFBPNWJrczZ1S3hGN1RqM0VCNU9L?=
 =?utf-8?B?YUlvdVQva2dYN2NFbE0vT2dHbHZIMzVIaFVNVlNGSnkvdHZPRlBhYmllcGVX?=
 =?utf-8?B?Z2d2dTFRZUJoUE1ncDd0NUNIcjhFMG43NHlCOHBydURIc0ZkcEdrcmxpYnRj?=
 =?utf-8?Q?C0RplH4ZP0+ih6ewh2/X2Ga4p?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CWDPXRdc+Ec9Sx+SdPMtCe0FJqaQEIl9/bDIumLiXWWvO2fcFPYG10wRJz3/IItkcM6mJXXFTH8jeUHfDdTWgg0ogQp1iGc7lxEdrxe4X+9CioFrxNGrAGLZPxPMFXj0PXKOowDyg0KLpbvv7WP3B/A7inWW/PogE4i+DgInRHdFLSiUESU+si9Zf7FPCjmqh9oW7lcbL0Fgydn3NZVeKfNYlSUny4GoVWLdA3DmQzieIrG9eJ26ifwihuCnvb3SzfMLhyLEvyLbMnkZKCcLNneWqtew8pzqZl3w4R4TK0kyqbC8roN2zd3Fweyj4ZEcZV6ijdmi88o6MawcCv5vQxaBnDYRBrgjLTgCbhw+9HrnKmm2YQXv8BhPsf+i2WWfCTjjjfZvnolBpj+Vv1eCgmg4hmn4JZudIMr04SJZLLn31skVRH+oJGy76Kd2NkCavrLKZNcBjzrBHn97waTl+j2voW+1Qszyb3csJcQWergi+5GVbvejeGG1ueQKc9w8RLk6o0caNXLleGdkFEv9Iin/PLOROjfXIJfR9j/IhteL1YUcjeX6r56ugrnW/t9zjOSy0xcywj+WIZrw0jWsuSuib6/A2hW9nIRp1Gsl0HuiPZ73jwvK/OZy9I/kmO+uoLTWgldvmgdcNk2kK+1fMKmqQJFnwxTXKmkWRxh1xwBGTaufQ6YS00XrRQHoCOScV4ZPKNf4zXTKK6kopZ+6cg7xW31zyKIlAWSgjsFe1KiOp5IUGqukovybuR7/EhDfaOwRvBDbfnC2xPdvFVSgzixPlt0cY645PP6JUEsrCzlbhyBrqpsbclPjHsALnH4rdp7y2BvbQtAlh67xazozMA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c1e13c-6f20-4dea-47f0-08dbdb8a510c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 09:58:51.4424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YT+WW4uUA9uqJS0l7EfZcTtbHvBMqty7QHItvtxL08wkL/UY+WhInB5Le0CdKX1jwpA/7wNMFDXO3QB6LJDdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7934
X-Proofpoint-ORIG-GUID: 8_D0yQGngi-5g-LDvNoCdITEL0vd4rqV
X-Proofpoint-GUID: 8_D0yQGngi-5g-LDvNoCdITEL0vd4rqV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 8_D0yQGngi-5g-LDvNoCdITEL0vd4rqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

U2luY2UgdGhlIHJlYWQgb3BlcmF0aW9uIGJleW9uZCB0aGUgVmFsaWREYXRhTGVuZ3RoIHJldHVy
bnMgemVybywNCmlmIHdlIGp1c3QgZXh0ZW5kIHRoZSBzaXplIG9mIHRoZSBmaWxlLCB3ZSBkb24n
dCBuZWVkIHRvIHplcm8gdGhlDQpleHRlbmRlZCBwYXJ0LCBidXQgb25seSBjaGFuZ2UgdGhlIERh
dGFMZW5ndGggd2l0aG91dCBjaGFuZ2luZw0KdGhlIFZhbGlkRGF0YUxlbmd0aC4NCg0KU2lnbmVk
LW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8
d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2ZpbGUuYyAgfCA3NyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiBmcy9leGZhdC9p
bm9kZS5jIHwgMTYgKysrKysrKysrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygr
KSwgMjEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9maWxlLmMgYi9mcy9l
eGZhdC9maWxlLmMNCmluZGV4IDdmZWM5YTY2MDczNC4uZjk1NDEyNWE1NDVhIDEwMDY0NA0KLS0t
IGEvZnMvZXhmYXQvZmlsZS5jDQorKysgYi9mcy9leGZhdC9maWxlLmMNCkBAIC0xOCwzMiArMTgs
NjkgQEANCiANCiBzdGF0aWMgaW50IGV4ZmF0X2NvbnRfZXhwYW5kKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIGxvZmZfdCBzaXplKQ0KIHsNCi0Jc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcgPSBp
bm9kZS0+aV9tYXBwaW5nOw0KLQlsb2ZmX3Qgc3RhcnQgPSBpX3NpemVfcmVhZChpbm9kZSksIGNv
dW50ID0gc2l6ZSAtIGlfc2l6ZV9yZWFkKGlub2RlKTsNCi0JaW50IGVyciwgZXJyMjsNCisJaW50
IHJldDsNCisJdW5zaWduZWQgaW50IG51bV9jbHVzdGVycywgbmV3X251bV9jbHVzdGVycywgbGFz
dF9jbHU7DQorCXN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSA9IEVYRkFUX0koaW5vZGUpOw0K
KwlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0gaW5vZGUtPmlfc2I7DQorCXN0cnVjdCBleGZhdF9z
Yl9pbmZvICpzYmkgPSBFWEZBVF9TQihzYik7DQorCXN0cnVjdCBleGZhdF9jaGFpbiBjbHU7DQog
DQotCWVyciA9IGdlbmVyaWNfY29udF9leHBhbmRfc2ltcGxlKGlub2RlLCBzaXplKTsNCi0JaWYg
KGVycikNCi0JCXJldHVybiBlcnI7DQorCXJldCA9IGlub2RlX25ld3NpemVfb2soaW5vZGUsIHNp
emUpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJldDsNCisNCisJbnVtX2NsdXN0ZXJzID0gRVhG
QVRfQl9UT19DTFVfUk9VTkRfVVAoZWktPmlfc2l6ZV9vbmRpc2ssIHNiaSk7DQorCW5ld19udW1f
Y2x1c3RlcnMgPSBFWEZBVF9CX1RPX0NMVV9ST1VORF9VUChzaXplLCBzYmkpOw0KKw0KKwlpZiAo
bmV3X251bV9jbHVzdGVycyA9PSBudW1fY2x1c3RlcnMpDQorCQlnb3RvIG91dDsNCisNCisJZXhm
YXRfY2hhaW5fc2V0KCZjbHUsIGVpLT5zdGFydF9jbHUsIG51bV9jbHVzdGVycywgZWktPmZsYWdz
KTsNCisJcmV0ID0gZXhmYXRfZmluZF9sYXN0X2NsdXN0ZXIoc2IsICZjbHUsICZsYXN0X2NsdSk7
DQorCWlmIChyZXQpDQorCQlyZXR1cm4gcmV0Ow0KIA0KKwljbHUuZGlyID0gKGxhc3RfY2x1ID09
IEVYRkFUX0VPRl9DTFVTVEVSKSA/DQorCQkJRVhGQVRfRU9GX0NMVVNURVIgOiBsYXN0X2NsdSAr
IDE7DQorCWNsdS5zaXplID0gMDsNCisJY2x1LmZsYWdzID0gZWktPmZsYWdzOw0KKw0KKwlyZXQg
PSBleGZhdF9hbGxvY19jbHVzdGVyKGlub2RlLCBuZXdfbnVtX2NsdXN0ZXJzIC0gbnVtX2NsdXN0
ZXJzLA0KKwkJCSZjbHUsIElTX0RJUlNZTkMoaW5vZGUpKTsNCisJaWYgKHJldCkNCisJCXJldHVy
biByZXQ7DQorDQorCS8qIEFwcGVuZCBuZXcgY2x1c3RlcnMgdG8gY2hhaW4gKi8NCisJaWYgKGNs
dS5mbGFncyAhPSBlaS0+ZmxhZ3MpIHsNCisJCWV4ZmF0X2NoYWluX2NvbnRfY2x1c3RlcihzYiwg
ZWktPnN0YXJ0X2NsdSwgbnVtX2NsdXN0ZXJzKTsNCisJCWVpLT5mbGFncyA9IEFMTE9DX0ZBVF9D
SEFJTjsNCisJfQ0KKwlpZiAoY2x1LmZsYWdzID09IEFMTE9DX0ZBVF9DSEFJTikNCisJCWlmIChl
eGZhdF9lbnRfc2V0KHNiLCBsYXN0X2NsdSwgY2x1LmRpcikpDQorCQkJZ290byBmcmVlX2NsdTsN
CisNCisJaWYgKG51bV9jbHVzdGVycyA9PSAwKQ0KKwkJZWktPnN0YXJ0X2NsdSA9IGNsdS5kaXI7
DQorDQorb3V0Og0KIAlpbm9kZV9zZXRfbXRpbWVfdG9fdHMoaW5vZGUsIGlub2RlX3NldF9jdGlt
ZV9jdXJyZW50KGlub2RlKSk7DQotCUVYRkFUX0koaW5vZGUpLT52YWxpZF9zaXplID0gc2l6ZTsN
Ci0JbWFya19pbm9kZV9kaXJ0eShpbm9kZSk7DQorCS8qIEV4cGFuZGVkIHJhbmdlIG5vdCB6ZXJv
ZWQsIGRvIG5vdCB1cGRhdGUgdmFsaWRfc2l6ZSAqLw0KKwlpX3NpemVfd3JpdGUoaW5vZGUsIHNp
emUpOw0KIA0KLQlpZiAoIUlTX1NZTkMoaW5vZGUpKQ0KLQkJcmV0dXJuIDA7DQorCWVpLT5pX3Np
emVfYWxpZ25lZCA9IHJvdW5kX3VwKHNpemUsIHNiLT5zX2Jsb2Nrc2l6ZSk7DQorCWVpLT5pX3Np
emVfb25kaXNrID0gZWktPmlfc2l6ZV9hbGlnbmVkOw0KKwlpbm9kZS0+aV9ibG9ja3MgPSByb3Vu
ZF91cChzaXplLCBzYmktPmNsdXN0ZXJfc2l6ZSkgPj4gOTsNCiANCi0JZXJyID0gZmlsZW1hcF9m
ZGF0YXdyaXRlX3JhbmdlKG1hcHBpbmcsIHN0YXJ0LCBzdGFydCArIGNvdW50IC0gMSk7DQotCWVy
cjIgPSBzeW5jX21hcHBpbmdfYnVmZmVycyhtYXBwaW5nKTsNCi0JaWYgKCFlcnIpDQotCQllcnIg
PSBlcnIyOw0KLQllcnIyID0gd3JpdGVfaW5vZGVfbm93KGlub2RlLCAxKTsNCi0JaWYgKCFlcnIp
DQotCQllcnIgPSBlcnIyOw0KLQlpZiAoZXJyKQ0KLQkJcmV0dXJuIGVycjsNCisJaWYgKElTX0RJ
UlNZTkMoaW5vZGUpKQ0KKwkJcmV0dXJuIHdyaXRlX2lub2RlX25vdyhpbm9kZSwgMSk7DQorDQor
CW1hcmtfaW5vZGVfZGlydHkoaW5vZGUpOw0KKw0KKwlyZXR1cm4gMDsNCiANCi0JcmV0dXJuIGZp
bGVtYXBfZmRhdGF3YWl0X3JhbmdlKG1hcHBpbmcsIHN0YXJ0LCBzdGFydCArIGNvdW50IC0gMSk7
DQorZnJlZV9jbHU6DQorCWV4ZmF0X2ZyZWVfY2x1c3Rlcihpbm9kZSwgJmNsdSk7DQorCXJldHVy
biAtRUlPOw0KIH0NCiANCiBzdGF0aWMgYm9vbCBleGZhdF9hbGxvd19zZXRfdGltZShzdHJ1Y3Qg
ZXhmYXRfc2JfaW5mbyAqc2JpLCBzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KZGlmZiAtLWdpdCBhL2Zz
L2V4ZmF0L2lub2RlLmMgYi9mcy9leGZhdC9pbm9kZS5jDQppbmRleCA0YTA2ZGYzZWQ0YjcuLmQw
ZWU4NjBmMTZlMiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2lub2RlLmMNCisrKyBiL2ZzL2V4ZmF0
L2lub2RlLmMNCkBAIC04NCw3ICs4NCwxNSBAQCBpbnQgX19leGZhdF93cml0ZV9pbm9kZShzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBpbnQgc3luYykNCiAJCWVwMi0+ZGVudHJ5LnN0cmVhbS5zdGFydF9j
bHUgPSBFWEZBVF9GUkVFX0NMVVNURVI7DQogCX0NCiANCi0JZXAyLT5kZW50cnkuc3RyZWFtLnZh
bGlkX3NpemUgPSBjcHVfdG9fbGU2NChlaS0+dmFsaWRfc2l6ZSk7DQorCS8qDQorCSAqIG1tYXAg
d3JpdGUgZG9lcyBub3QgdXNlIGV4ZmF0X3dyaXRlX2VuZCgpLCB2YWxpZF9zaXplIG1heSBiZQ0K
KwkgKiBleHRlbmRlZCB0byB0aGUgc2VjdG9yLWFsaWduZWQgbGVuZ3RoIGluIGV4ZmF0X2dldF9i
bG9jaygpLg0KKwkgKiBTbyB3ZSBuZWVkIHRvIGZpeHVwIHZhbGlkX3NpemUgdG8gdGhlIHdyaXRy
ZW4gbGVuZ3RoLg0KKwkgKi8NCisJaWYgKG9uX2Rpc2tfc2l6ZSA8IGVpLT52YWxpZF9zaXplKQ0K
KwkJZXAyLT5kZW50cnkuc3RyZWFtLnZhbGlkX3NpemUgPSBlcDItPmRlbnRyeS5zdHJlYW0uc2l6
ZTsNCisJZWxzZQ0KKwkJZXAyLT5kZW50cnkuc3RyZWFtLnZhbGlkX3NpemUgPSBjcHVfdG9fbGU2
NChlaS0+dmFsaWRfc2l6ZSk7DQogDQogCWV4ZmF0X3VwZGF0ZV9kaXJfY2hrc3VtX3dpdGhfZW50
cnlfc2V0KCZlcyk7DQogCXJldHVybiBleGZhdF9wdXRfZGVudHJ5X3NldCgmZXMsIHN5bmMpOw0K
QEAgLTMzMyw2ICszNDEsMTIgQEAgc3RhdGljIGludCBleGZhdF9nZXRfYmxvY2soc3RydWN0IGlu
b2RlICppbm9kZSwgc2VjdG9yX3QgaWJsb2NrLA0KIAkJCQkJcG9zLCBlaS0+aV9zaXplX2FsaWdu
ZWQpOw0KIAkJCWdvdG8gdW5sb2NrX3JldDsNCiAJCX0NCisNCisJCXBvcyAtPSBzYi0+c19ibG9j
a3NpemU7DQorCQlpZiAocG9zICsgYmhfcmVzdWx0LT5iX3NpemUgPiBlaS0+dmFsaWRfc2l6ZSkg
ew0KKwkJCWVpLT52YWxpZF9zaXplID0gcG9zICsgYmhfcmVzdWx0LT5iX3NpemU7DQorCQkJbWFy
a19pbm9kZV9kaXJ0eShpbm9kZSk7DQorCQl9DQogCX0gZWxzZSB7DQogCQlzaXplX3QgYl9zaXpl
ID0gRVhGQVRfQkxLX1RPX0IobWF4X2Jsb2Nrcywgc2IpOw0KIA0KLS0gDQoyLjI1LjENCg0K

