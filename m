Return-Path: <linux-fsdevel+bounces-6990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4801E81F576
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 08:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA01C1F226D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 07:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D51441B;
	Thu, 28 Dec 2023 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="NuF4yYoR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D13D72
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BS6a6Ne003020;
	Thu, 28 Dec 2023 07:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=41Qn0Gdup4Ub2Hkwcy/wH+oyWt3lP2IX/QU/3FzqG3c=;
 b=NuF4yYoRAxdo2yMJy6oEHTcXev/WIL6Y7Gq0dqMjPxJrCnzv8k9zz4CeEaDtC3m5gNMS
 45pMUsvRXkyl64NhNhdHI0a265RKS+UZSWQUJpoE2U3wptQjVM6VAzK6aojiPH27BSeI
 LHAy9YPrypUtFRhCBftuPv1VHSINmcWv4B8RGINyzpP4HbA62O9n9q9Uk233/QrhTX4f
 9UXut/+ehStFPEEDZsFPju/4598w5Yl+9tMbBasaMq3srFwlolVgHBQSlNBXwE15fLAK
 eSD5gtHVUJf8rgeatt0Lpq7Cw/VUGgqeCUarA3fIqMFkXZBJ+rYEWleL4kDcKN80nfXJ 8w== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3v5nrhvaf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 07:24:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji5fX21P7fTEI8JlqehaTWZ2GwFqhOrUD2hvcrCOe7C1fwVIJHr35ci+C6sTeYGImCky8JLYG1bp4pZLSs+qcfIkeuaX0nrUCULhDZvXmqTtYPhinPWhGRdkF+AlmcjqaFNSwlmeax8S2gMP1KLJVOHctIYN/+IYZABYtxbdf14mwCZYtc8DLC86TZCfo+Lip375k+aJqgPdq4Y3WmB/JcbhfBORml7Qi4o5mzqsukq0nA6jetZd+F+4ILBu1uSklxs6xI53XEZpdnKWfEn1LzHwH/FEghPh/TmZc1zCJ9fLElKceBKmcxm0d+3w8RYHO9J4EeAF3/8E9w9X3iLAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41Qn0Gdup4Ub2Hkwcy/wH+oyWt3lP2IX/QU/3FzqG3c=;
 b=nHGlyWs411AA5P5o1auRqfK04yHVYM7Re1W7vTZ71RSuL5X1/CR+5FQNDydCH9yzl3QJ837mRRyVifCJfJoXufUa01obIzMyb076kQ+MXqjhvCMxTMnTEe/4qd5iskLjRKYLgsq5HqNhToieATj8vNxGoqK0SeHiLs6+1QpvFojYJGcdI3MIPz5oPVGqaxzx5xUiXRC6uU+J7JyYnvvBQtBSeFINE/xt8UyWkCzk0ZMthZqBBCwNu+JVuWy+x/nNbDSE0YHxUMh/RVbZnh77lnYq3ym+57UM8LhJEYUkjEnL3OAGFEbyndvZCQ+e7XuQ57JUNLwC6ikoamblYrj0OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB7206.apcprd04.prod.outlook.com (2603:1096:400:463::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 07:24:31 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34%7]) with mapi id 15.20.7113.026; Thu, 28 Dec 2023
 07:24:31 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: 
 =?gb2312?B?s7e72DogW1BBVENIIHYyIDA5LzEwXSBleGZhdDogZG8gbm90IHN5bmMgcGFy?=
 =?gb2312?Q?ent_dir_if_just_update_timestamp?=
Thread-Topic: [PATCH v2 09/10] exfat: do not sync parent dir if just update
 timestamp
Thread-Index: AQHaOV7mEMi4+opSJkGxFJ5S7gqSRA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Thu, 28 Dec 2023 07:24:31 +0000
Message-ID: 
 <PUZPR04MB6316D4DE800438BC2400666B819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB7206:EE_
x-ms-office365-filtering-correlation-id: 40506814-c1c2-453f-b6f3-08dc07760894
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EpZCe7BM2ckGI/LacMLHpeRx3vgQL1qc28W88e3FJsCzSIXKkrx/H2tjcm5qgf/96voGVKNma+vve7GQlEgWkc2w/lS+eVORAoxz4IcYtXCVridoLd6K1V8fLoktAOVzBrnRoDlzJM8LuY5JOaaNu9Y3CN5SG0K6LXnf+Tm1OeynzT7Hp+Iuzivo5h6mVL9AI4fZRF1omIjp3lbs7UmIrxMBIU79EQ/JUqufkUQ1MD8YnL7Lz7rlqx63Ly0NH9lS4QQVYgA4eBi7QWzmzmSXKd6BMS7upKs0Sru4989+hqfEYAgb0v+FlTC0ThJoyGdeM6nzTSuekRb/POc+vBQIV9Ddy4w+LyPbsVAHFE5iq+NU33gok1WxySn6Tmf+znirgZwNnnwkJDsqGW5YEafENZTBuwPTdl2rWt/4yozQqhQOsDkNPCGawnOFxJibMBrsHzZ6ng4TnNjDG3mGUPEEuiwe9MaSqLhlUrMF4e1cF3L0DGB8kcZ/cxgDANPVsZcMttAMvHgiJZ+RHLLYX8LuwAfs+WhUgdIaJFwuT1wOxCmTRiqVqbLhq7bVQ4tNLUXSsXzf2QFfNER4ZeGxjgzR1aQJQ7crNR4PPAPO/MVcriRKv7bJw3xDQXyK4Rl39HoMSup3lu2vRJ3hujt0fRE7GgVkwZnY4KmEDhFYWWQsK/g=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(33656002)(558084003)(224303003)(7696005)(6506007)(64756008)(71200400001)(66946007)(66476007)(66446008)(76116006)(66556008)(38070700009)(9686003)(86362001)(2906002)(82960400001)(26005)(38100700002)(107886003)(122000001)(83380400001)(41300700001)(15650500001)(5660300002)(8936002)(54906003)(316002)(478600001)(110136005)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?ZkVyQURkdmViMERzaCtKcWh0SkRKUEc1Y1p3QzFLc1U5T3RvT20rUFBBMFBY?=
 =?gb2312?B?WjR3WmVhU0cxQ25lbTBnL1FqVVVFZ0FpSkM0OFAyVzA1SDJ2UkVLd0tpVmwz?=
 =?gb2312?B?RGdQK1c5MWsxb0phbHdXZm51V1Frc1h2T0tkQzlWSUZCcVVjWnVCU1NadkVK?=
 =?gb2312?B?QmFWMnRGeDBpM254NEpFclh2Ums1d0RNZmJ1TFNZV3hHNDFEcUZIZE9hZjh2?=
 =?gb2312?B?TUV1UEVjRWMwK1VDVjNBZkpyR3prdmRxY0dLUHlsQ090RlpCR29NOGtSOVpk?=
 =?gb2312?B?RmN5OWswNWJEV2hzQ3ZsbzN3cTNDanY0MHowL05maFlGUHFwM1IxT2lMNUIv?=
 =?gb2312?B?YzdNWDZLcmVkQUdxd1ppS2NDU09SaTFHV0g0V0dSdWNyZm4va2kwOFlEQWhh?=
 =?gb2312?B?VUdDRllocGZSQStJdEhRcHpESFRhaGppbUFHUmZYdzRadXpkVGNreisvWWlC?=
 =?gb2312?B?VGhnNlcvd1c1dHhnL29zRTh1Q05EZllpYWFHeHJRTFRYYVZFQnJqdXNDVXBC?=
 =?gb2312?B?Q2ZCZDNFZlZkVDgranBQbjc0eUFaWXgyZEJmVC9zVlFoUmJpZTQ5QnpYWG5p?=
 =?gb2312?B?Z0NXdUkrSDAxT3NKK29oTEdoSmxFWEdGWTc1dm5FNUVQK2pJTktEQ0dDejFV?=
 =?gb2312?B?Z1J2b21CeVFYMjBzVHFzMVNPV0plQnk0NkNZc2lGMCtLSXpER2lVb3Q1TjhV?=
 =?gb2312?B?U2RZZ3VLSm9LeExiZGNMSm5yK3E2RDFVYngvVVo0c2NxNGgvbm45ZFZ0VVBa?=
 =?gb2312?B?ZjlxNjZDSmlKK3ExWm1HOVc4ZGRmOE1OV1pFelIrTzUvTUVndDViWHdMNEs4?=
 =?gb2312?B?MHI2TE1QVXA5aW9zRmM4anZNMmw4VVM5STU1blpoT2cxOUo2R2VtYmQzWEFr?=
 =?gb2312?B?YllvcXY1YkZYZ1kzUjBWNXR3UXliSmZSeDlnL1NRU0JWQW43bzRuYjdkbXBx?=
 =?gb2312?B?cFdYTjFIeXlVVVB4clQwSWd0NmNtSytyZGVobU12cEdZUmhlRCtyUE51dlhV?=
 =?gb2312?B?cTNoUEhpS3cva0UwalJsMDRxQ3FIK2YzREIvV29QeHM5cGlLVGlHTzZ5M0t1?=
 =?gb2312?B?dzBseGNTcDAxWXZKTVpOeE9qSnRkZUFVVG9kcUQrK3ovb3UxZkVUdlRBcmc5?=
 =?gb2312?B?cnE1N2Nna2diaWd0UWxwNGdYUWQ4SnRGbjdQaUk1bnQwMVdsd21oOUhBQ3l6?=
 =?gb2312?B?RFkvaW40cy9hYzB2Yjhrbks4RWJFN2x2MVVZd0Y1SCtxZGFaanZmNmFUcUUr?=
 =?gb2312?B?aDRmK0RrV0Rwdi9scUhOS0tmUllwc0oyU1F4M3dsSEpna3pwZjVBdnJ0VC94?=
 =?gb2312?B?ODRDNnNUS0FPMm5uaHlXdjVjb29vdnZ6UWJaeThsYXZSR0hJdmNJLzdtOVlm?=
 =?gb2312?B?THc5SHI1a3prYVB5TWRBcVl0cDBZbWZMdDB5L0VBVkM0VmpqczhpVDBQYkpE?=
 =?gb2312?B?aGpVUkRQSTk3TGF5OFprYWRtanZpTHB0REx5ajk3RGJrc3NNZS9yYXlSMi80?=
 =?gb2312?B?RmQ0dFlXV094cWxFUHNtZUR0Q0Jwbnd0ZThMS2xTNWxMci9zaTdXdTE1SWJM?=
 =?gb2312?B?ellSK2VYM0h1VmwwbERIYTMzU21vZGZNUFZqNlR1Vi9SQUZrMFJaQWNrdlVt?=
 =?gb2312?B?S3VqZ050VCtNWlpLN3lQeHJXSTdrd0V0ZkZlanNteFR3dEh0RXQzeWNDRUpw?=
 =?gb2312?B?a1lTUkg1SlUxMnVDdGNKc3JFWGJkbWhyNk5yWTdRZHJyeGQwRDc5UTZDdVlX?=
 =?gb2312?B?Y1kycTU1VFVDQlZhTzdJVEg3RW0yWGZqemJ0VnNaRkRtU2dmTTlnQkJJWkRQ?=
 =?gb2312?B?T0R5aVdVaWlMaHV2b2l3UDdGRURVVjduakNWQUtsQlhvK0hWVy8welZzbkYx?=
 =?gb2312?B?b24xa3dwamh5WmsybHlkNHVMUnF4TWgvMWFIck9HdUV5ZVRMZHliaHNneVdk?=
 =?gb2312?B?RkE4SUdPY0QrT1pJTHRMRzBEc2RmbUhDamJZaTd0elc0UlNwSDBSSURMR0lz?=
 =?gb2312?B?dHpZR2IvdzZBMldqQWlOL1VtcnRUdUkzQlJnQ05saExCRExBdjhGVVBiQUdh?=
 =?gb2312?B?UUJ6L0pkUXc4SVU3VTBtdEFEK20vc2xmOGpDVitTNmNBUHFWSCtFRXl3VmRt?=
 =?gb2312?Q?IQ08u6faoXEVNrTm62m5ru7gz?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5VrVJ6rMWiDJ+VtNCia1adt8akLethGFRKuvKHpdMTQVn2j7kgNy3viMVI2Dugjoi5JhVteCOrnu2sfFONGWY3hTSCdL3g1rFwyfesFidJZ58mVIo5ZVTi11xnFczeJCJNC3/ezQXt2Ou6ideZKxMK9ziHtMgnbui2Br98xeuMwkzzZ4fohyhePj7276vudI9bP472szMRR6ywk/a3e8WTAA3KumvHiD8SNu2LyvO4rZlsoDuamthT9Sc3hh1FUFbw5zQDxKorqTjYNEqn94Lv21AQb2hY1rwLjE+sOBCsNfnRLn0axiN49mhoERoOPvcmv0feCPAp0LnxfgPhXfUsopdRyTRpBLHjQ/pY5Y+oG9I+xi0+OA61UTsMJxZpZdkxfdoeyOF7FXlgaXTA+Ujc+5X4MSua+nyZ0oe64ZV2z2CVoi6s6d2hCffQzW1fHvr7M3SHtWUxbkJl0XG9EkBS85uf3yaP8eMk6kL/4IqKePBEJFbNcZRxKnFhOOr7n7WTbaV0GVDSmTHwLkeyOSLNKFJ9iELN2hTLOgbs6wQ0M409MKIwSG1YDr4NtVF7J9u9utkpvqgd4BdzbmKJShW4g0y71/JS1HHaCnKXbUYj8S9mIq1UcGEkG6pRRzbOo9
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40506814-c1c2-453f-b6f3-08dc07760894
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 07:24:31.0912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OyuUfjSvQ+Mo+E/EXE3xgFGWv/59UDGOIzBoepLPqcyhOQPyq3p2LMJ58T+0EHifbrHaozp0RHET9L2X9nOwDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7206
X-Proofpoint-GUID: P1MVW146GFQp-NO9ZGVeI5yeeCl6-9kK
X-Proofpoint-ORIG-GUID: P1MVW146GFQp-NO9ZGVeI5yeeCl6-9kK
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: P1MVW146GFQp-NO9ZGVeI5yeeCl6-9kK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-28_02,2023-12-27_01,2023-05-22_02

TW8sIFl1ZXpoYW5nIL2rs7e72NPKvP6hsFtQQVRDSCB2MiAwOS8xMF0gZXhmYXQ6IGRvIG5vdCBz
eW5jIHBhcmVudCBkaXIgaWYganVzdCB1cGRhdGUgdGltZXN0YW1wobGhow==

