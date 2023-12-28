Return-Path: <linux-fsdevel+bounces-6986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 986CD81F542
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 08:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0142819D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E52440D;
	Thu, 28 Dec 2023 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="fbJGrIaO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A43C07
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BS5sBVl013923;
	Thu, 28 Dec 2023 07:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=ORbU2cqMsTvRJr1w1HFDe0xceFIO87Wgaalnna9+M14=;
 b=fbJGrIaOF3EK8rvbGd4FrhaEvXOeI33LkvM6ZLzIk5N80y7pVOOk/O7M/v4F8QTEt/LL
 uCI4Hala/Ponw8s7yXCVwRJMejuf6iRldAXQuXWs7Lwg09JBS5Ofk2hnxzR/ld/gE0Tv
 8x3mAJUxHOpiEfSM7y7CA5hzbQPaDzSCssXeH85NUnESFKHV7RyYr3yB9jiUuGO6ZGAj
 D4XHptLtlygLlhmTEmUtT1kBekqSaC6NtW8QnethAj4u9u01SKCJv/7z+i02+BmxR3gl
 rd69U30OavxCn+brz3rc87PSq4BmQsNQ0WxtzicbcQBHpeMOaheB0rmSwNoZb69D6+cc 3A== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2105.outbound.protection.outlook.com [104.47.26.105])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3v5p7149pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 07:00:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMw9iToKNqyRQavhSRZxbn/04KqLhFKN7i+zB8IKjELawE3eV8m1OCmBW9cDEwnsuaPKwwbiIo+FyS00VW6Z7eVZ8iWUGAG2InpAjiaN47n5vJ8GE9ojA3sbH/9EoGY5aT7Xm0+uq1uApOjE0sEWIwcnIOzZH4Ycs5M9iapoANadylOchQofbm7kVsWoXyrJ9gxxbUcrkZUCLnByAJJN6KLE9z0Diby9yhG+Pi0bKTJfRhquzI6p/q+1jgl6G5oo+hvAayA3sNikO2+ursXZX2cXr1BVKCcvsI3NY/zL1qLGkPQ0fZNjw8rQMoQtywoRvdb4M86f/wsvgAWgnsb+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORbU2cqMsTvRJr1w1HFDe0xceFIO87Wgaalnna9+M14=;
 b=V22o8c9PQ4l6yE37oezkNcOIGFUesNc+pJVgwfOeK7hqW2zLmTufH6cy976Y2mbIsvsC64nbaT0Uw1rlVpCruBEHxe+1t4e2x9k/h3nJvwRndma4x9kS7S9qFDE7sNzb7gEtDFACxUNMAYsF0q9RKkQ4wUYu5wlAX+oxphqqMUX9HABGJdbosiZAqWPFurCZAU87UBSE19LaPW1zXg+qM7s5FxOwEnUallosHtlHTf2bQF66po+ca/kze/8FWOApnxA3rxUPHeX+abonj6f1qFLuGaSq0imvpSoNTXzNvY38HVbPWoyU+sIksqV28obwhj2DYhAqCBYNMeHgJM/dmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB7223.apcprd04.prod.outlook.com (2603:1096:101:167::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 07:00:05 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34%7]) with mapi id 15.20.7113.026; Thu, 28 Dec 2023
 07:00:05 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v2 10/10] exfat: remove duplicate update parent dir
Thread-Topic: [PATCH v2 10/10] exfat: remove duplicate update parent dir
Thread-Index: Ado5WyQamlonHuZbT6mkMfRhSzKbCg==
Date: Thu, 28 Dec 2023 07:00:05 +0000
Message-ID: 
 <PUZPR04MB63165D5DE9EC67C428B2020C819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB7223:EE_
x-ms-office365-filtering-correlation-id: 3f09add0-c741-4b9e-d360-08dc07729f08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NXMxG98LNvO1zBlk6cvdVpctnEFCCACcoLNkS/szy87sNSDbzS5p9+lVvZap3GGVUrhKwQuz3Ei69MxuNEZJzyUzpum1J6hGbAhPVrTpst2P2vH6bG6sxJ78PO/0ttqNSe2ZVueRWXLkBzv03KzDXuo7FDj2uY/9bYeRxj91ErkGtMkkV9vz0WI/I/hSvVBZRdohe3GIscjKpMWVD7XuhmBCX5kJFei7jOjd4qdlrRU2XLpN53Rl3lclrUG2gXUEJStYxFLmUXwBDx+VLTRM6kqsUt8OtlNmkNgXv9ywQB2BWYX1J9jV9hlkZFqZouHooK+O/e9tDK4xErX4VqD+gTQk97j90hT0PJkCMda2em1SbnVnIV/U6Tl4EGq2PLjHfanzC0ixc6hcfSbZ+5jp/9Da3qYqt+d/kzKEJ9pGGBwgKFtRfBud+lbrxmbbuLaNhqRs8aANuLtJAqS5lD0dZxmbsBV0l3FBT7DdKX5vN6dmhOApLqXU0y47GkJATECzca9ZAHtEyfinHuK78IfSGnZw4otVRrgUOV0/Cy4wFtzirlS6LCx50CLiyE0lsB4XhXr3o7Jdu4Hq1l7jLudNqWP2j99xrBPwVRyPMcOq+1GY2XqsMdyGxVgERX0yzO5k
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2906002)(66556008)(66446008)(66476007)(76116006)(5660300002)(15650500001)(64756008)(66946007)(55016003)(4326008)(52536014)(4744005)(8676002)(8936002)(316002)(54906003)(110136005)(38070700009)(9686003)(107886003)(7696005)(478600001)(71200400001)(26005)(86362001)(6506007)(33656002)(122000001)(41300700001)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UlR4QkN0Sndya0x4OGoyN016cTRVQXJnY0hxMEJZU2taYytvd0prQWUyTUtY?=
 =?utf-8?B?ZDVUeHBQY1FYbzFmSEw0WlN1RGhST2RMM0FTYXVHdEFKazl4YjVFdVptWldS?=
 =?utf-8?B?OUhzOGpiTFZoNStkODkyeGp4dFRyQnEzQ0U1TFpENHkzRHZseFpLT3ZGUjJo?=
 =?utf-8?B?Y2V2RnVuME45Rk5TOTViQ1JwNmdIc2o4M2NTcFpKVXFRZGF5Tm10cklRN2ta?=
 =?utf-8?B?bzdRanVHdC9QR1ZxdWl1b3FmQitRWm90RFI4aklCT3VWTVQ1ZmpNSnVaYWk1?=
 =?utf-8?B?UlRBWFN0ZldRWnFvTXVueGZsTDFwWFpVTUxHSXpoYXQ4RUNsYTVQT1RjVnBO?=
 =?utf-8?B?aVFVWGx3T3JEb1R5UWJYNUlhN1FZWng4Q3k5a0xaUWRiS1Vxd0xHWk1OSnAx?=
 =?utf-8?B?TXRPbUNkWVlNRzdhVjBEdkZTa2ZvOVA0bHRnTzJvUWErRVRTVk9vQkhuUk5I?=
 =?utf-8?B?aGdtWlBUZ2RybFRuSnB6TkdjS0ZZNEl2Qm4raTIzMGp6U29MVWFVTTcyYkh0?=
 =?utf-8?B?NU4yNGN2TkxzekFjemo2dVN2Vld5WXRYNFo4bjVDQVJncVkvNTc2N0VEaTdh?=
 =?utf-8?B?NkZnK2ZxdzBmT01GMVh1dDVTVlBoVnkyU0RrMVBkL2FRRjNseTIyaGlHREpM?=
 =?utf-8?B?R1dIbmZrcjE1RFcrNHZsd0diUzROZzA5eXMwQTFNVjR5d1ZCS2JzL3RCeG1U?=
 =?utf-8?B?RlBMSGpQMzVxUkVXK1RMdlF4YU94ZU5rQU41YkhaZ3JIakVqdWtUSkg5M2Q3?=
 =?utf-8?B?VCtoZTlnRzVJRzZMMW9kdHZ0RVNaTmpxemsvWVRYVmpxUnlsVm13MFhlYzJV?=
 =?utf-8?B?R2d2ZEFyQis5Q1NheVNaYjFhOGNsVEQ4a3V2MlNxbnNHK1A0amNvODg2eDc0?=
 =?utf-8?B?ZUN6WEhncWdDTTlGaU5YU2JoVnhUNjlKdEVxKzExb1BoMVBJSHNWOEFGUEw2?=
 =?utf-8?B?TkpLdjRPeGs1Wk92OUFKUzJ5eEtQemQ3QVc5MXZVczJwTjBpeFZLK09TbDRZ?=
 =?utf-8?B?TklxWWdPamQwNWJzQ3VMc21jbnppaWcvM3V1QUhKc3BJZHZYWDJ1VFYya1Bn?=
 =?utf-8?B?eUdKWkVIR3BDaUZ4Tzk3SmtQZkJnN21xa1gxYW5lUmNEcVJhS3F1M0JYT0lM?=
 =?utf-8?B?ai9LbGR1QThBWGNTbzhndjhEL3RLTk9YbFFpNElOVjJTSWZwbEVTOEV5a1Bu?=
 =?utf-8?B?Z2tKZlUwUVIvZEdqdUlabStOeC9ycFlTZlV0aEdoRzJlRitmYlZZSDNBbXZ2?=
 =?utf-8?B?Y1g4eXF2Q3lLWE9wWjE4dU15Y3czRmluYTFFZzdHZmZYUVFST1U1V0x4cGxO?=
 =?utf-8?B?eTZhd0RZa28yNm51Y0tCL2ZLcjlMK3puWkFZekF4Y1VHS01PQ2xLT3JkQk1m?=
 =?utf-8?B?WjRQTmFrTVlKSTJQa0s0clJHb2R4OGZyREg4cHpLSm9VOS9oblI3aHBXTE13?=
 =?utf-8?B?WHFwdXBzbXpEam05M0ZKeDBpMWo4L2ZJS2VuN2YxMGhzNEl4enVlcDltRGlS?=
 =?utf-8?B?UXg1M3BMUS9DZlFNbVBtT1ZaQW1uejNYSHR6Y1VzL1U1SGljQndYVy9zaC80?=
 =?utf-8?B?QlJZeEozL0pPU3J3Z29ydVZOMXJhSDVjb1psenNxNzk0dnM0YUFSckthVmpH?=
 =?utf-8?B?cDJOeXFnUWMzdVUyZm8yRWw1SGh2MHlHdTFGWGdXWmdIOTRpRXM2a0wyT0Ux?=
 =?utf-8?B?ZThBTjBKclRhU21qVXZ3V0hBSkxvVTNGZ0FWbmVIMnhQbEZXbUZ2UVBYOGRG?=
 =?utf-8?B?dm55ODd6VjV4UXBybXRyNWhqNytqWDBFbmVTY3BKckJmZERPNS94cmFPaGl4?=
 =?utf-8?B?UndmMjl5VzJQK2NnOWIxajViY21nRXErOTdka0RFc3hsSUFKNkl3K1VHQmxw?=
 =?utf-8?B?WnBYWS82Kys0T2JUT0xIOTAxVWg5YkFoTUxBSjlPTm9ZNHZ6MDRYSU9ndUxF?=
 =?utf-8?B?ZUZXa2hsSVJRcFcvbVNtVEVZK3RzdndYcXE3bEtmcGNtVFVPRnUrZnN6T0hY?=
 =?utf-8?B?UytCa3FPMEROdHN0dW9BVWh6YVdMdi95eER2QXVmNk5rTlJvV0t4c2JaTzYy?=
 =?utf-8?B?VEplNHJjMVdhVVJ1VGF1Rk9XNmJNbkNwRFprWXlHdnY3NVQ2ZG5rT2VhZDdl?=
 =?utf-8?Q?Kxm+BYM43QydDoo+NcklA3K11?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ut26Og/TQ+Wqtc/jRnO8hN5OqWE7H48EY/MhbhjvioJCbjz4XcYlNmmPHFFZpscFmzLTmbwgbx367+Kw82LpL30d6w9KmkUSex/W9Ol90sb5Hf/FEX4VCn5wVzRvK2aW3xy07O0bGTV1RVwufq/wZLMqwEdLQrpTi+eOBnK+BzQso+Fqlp+/MAz1xU23+rZGp2+0tRB3lBlU+VQdTply6JGyxG7VI9woguPr0cmjCsFJnTwO9IBJ+/JAXVqcI+LIqZeeA+wKrbf2MUcR5Gla1Zyo3jniqYXqdj1rdSNw7hf5GxF+SOfTDWmfDElop7EMqQwuXJr8mLRpChoX8cL5GYsygGQFOTCOsa0+4Ax1u+znzlpuwoHZs0TKWzXfgsUCU8mM/F+8/hIBwZPXvYUw+uPI9Y32ifhMFEmczAxFPZlYo4ZOZ7KzRZdMVOekPAn/unJXLX+ShQ4QZpJKQyqLu05E+GnoRUEihyzHWcPip8k/b/1tSCA8xpsAQ9HSVjKIGLovX9g5KCGUj8emIcqaEZ82nijZOhnYw9wB1LysBiQlgFeuxaMeuiEDcAtUqwNLQMYo0BC2ru7miedJhBNJtO7s67VZcJrGYW48Vg06vvVqtTeW2ml87iNYeXnw5nNX
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f09add0-c741-4b9e-d360-08dc07729f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 07:00:05.5090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RYWbPdN75Efu3drfaSFxGMh3o0Yn+4UFOSqzTqUpWPD9yN0no5lh9KPOR/j0CZ+LXmr4gCkjQcTTecO3TZCUMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7223
X-Proofpoint-GUID: 5N2gLS6TfoPrrkHhw5xeF2sRQusGnGP_
X-Proofpoint-ORIG-GUID: 5N2gLS6TfoPrrkHhw5xeF2sRQusGnGP_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 5N2gLS6TfoPrrkHhw5xeF2sRQusGnGP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-28_02,2023-12-27_01,2023-05-22_02

Rm9yIHJlbmFtaW5nLCB0aGUgZGlyZWN0b3J5IG9ubHkgbmVlZHMgdG8gYmUgdXBkYXRlZCBvbmNl
IGlmIGl0DQppcyBpbiB0aGUgc2FtZSBkaXJlY3RvcnkuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpo
YW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5
Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFA
c29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9uYW1laS5jIHwgMyArKy0NCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZh
dC9uYW1laS5jIGIvZnMvZXhmYXQvbmFtZWkuYw0KaW5kZXggYjMzNDk3ODQ1YTA2Li42MzFhZDll
OGUzMmEgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1l
aS5jDQpAQCAtMTI4MSw3ICsxMjgxLDggQEAgc3RhdGljIGludCBleGZhdF9yZW5hbWUoc3RydWN0
IG1udF9pZG1hcCAqaWRtYXAsDQogCX0NCiANCiAJaW5vZGVfaW5jX2l2ZXJzaW9uKG9sZF9kaXIp
Ow0KLQltYXJrX2lub2RlX2RpcnR5KG9sZF9kaXIpOw0KKwlpZiAobmV3X2RpciAhPSBvbGRfZGly
KQ0KKwkJbWFya19pbm9kZV9kaXJ0eShvbGRfZGlyKTsNCiANCiAJaWYgKG5ld19pbm9kZSkgew0K
IAkJZXhmYXRfdW5oYXNoX2lub2RlKG5ld19pbm9kZSk7DQotLSANCjIuMjUuMQ0K

