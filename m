Return-Path: <linux-fsdevel+bounces-1799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE097DEF50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 10:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E6DB2124D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44F7125C8;
	Thu,  2 Nov 2023 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="oomE2O5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345D1171A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 09:59:02 +0000 (UTC)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1A9111
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 02:58:57 -0700 (PDT)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A25riEA029642;
	Thu, 2 Nov 2023 09:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=fEqXdgbx7Yvoeld/IrIsf1h1yRvI+f0hyJGwHseeea4=;
 b=oomE2O5SvJ/nG6V7GDy+lJ3t5EHdo13h6ZHnZ7xWRAIV26dBpo0yk7buSAFFvZJv4sYp
 UcbX2XULpYl6m9ombFU8TujieJ07eeDzaULXlJQkUXNVrZRGbcIdt/60YYmibr/abrp0
 00RhYV66M1MVuqypmtHZZqkwGMvGlgrbgzd5aWdlxt03af929Lpdm2pV376znGw7ZIQw
 tdeEQ5Qp9k5qQv33VJld0epWvtkxtWv7YUfJGn5j7VSH//TjUbyG0Oo/Qmo1JXSue4HG
 wChiEi7cKqZqsFgFH0Oz4JeXDIrmuYhlDoN0h/xYvtfVIUoDobg3L6D14NKUFQfDVc1y ZA== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2110.outbound.protection.outlook.com [104.47.26.110])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3u0qhywk7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Nov 2023 09:58:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6UpAt9NCY68s/lMezYvQKdzrXYsUaUchF+EmXrzgqVJUJOd2kkHkohTTmal2ZQDfBXL2v0nvoC5V9QYrzR6yk/P7mv5hv7R76vA0h2iNzogBjXq0h7lz29ay9MBcJDdpGwuujINh1d8GUfOJkPBCVvqOLjsMc/p2qa65hBcntfg9SjEoVoOogw8KYHpVAZAYUd8lcbRzm+RuDyXzEZR7IHU4qzuYaSwQfJetWTHVOLv7lATfhzVd34sAjY46xBvv/ult3qEf5SHok6nKQtgyxyFhX9f+REfHYVb+MW9RvkmkCNzJwAWQlGrFx5qyHjREA3MARRFUFpbbRiKIgfs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEqXdgbx7Yvoeld/IrIsf1h1yRvI+f0hyJGwHseeea4=;
 b=Pw4sK0gmFDpIg1HC4WdQH/eGg6j0zk//Lg/2jg4KACOOL6vAAwA8h0ksG0OqmTadBD6PqkLUr48iDOiV3XloeX1Ujv8KQaMuO20p+gF1URGLHnVHr5JxCPiikZp0hRc0zXTCcELN9/yfdJbuU28B9xAvRBTe9Mb/vUspFqbO3XHjlz49WuFKQyw0aYe50n12mU8dIAq1lkqd/Wgp+QclcZJi1PaLeiCsGA9uqNVt6kFywTRyuMomRF85OMQArZyy2WXpEaJyuJxTrqrBDv65QDbmP+ZUS0l9tcovculYaly4qAD2f0ZDqXD1sKmeJs5RqYMERbf1wCbXpLY33LEypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB4432.apcprd04.prod.outlook.com (2603:1096:400:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.20; Thu, 2 Nov
 2023 09:58:38 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.6907.025; Thu, 2 Nov 2023
 09:58:38 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v4 0/2] exfat: get file size from DataLength
Thread-Topic: [PATCH v4 0/2] exfat: get file size from DataLength
Thread-Index: AdoNcnl3W2G+vxeLT6KlObW3hRdjBA==
Date: Thu, 2 Nov 2023 09:58:38 +0000
Message-ID: 
 <PUZPR04MB6316D39C9404C34756CA368981A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB4432:EE_
x-ms-office365-filtering-correlation-id: c5dfaa34-7ec7-4a1e-7276-08dbdb8a4983
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 n6Q+EJVhK6YGUhse/H4vgzLtbOwUXHq2pFW0UcLBRuQi9cYJbzQc1y8/sGp5hLXc0Jcj1lYLCX9Lm2OKY9ntvZqs4yfRVdT1mBeCsqB2F+DI1rFKcunVnZ8Yfa0KHyTlGNAorfH2gh/fyZUimNwkEcA1vHVQs4jX1IdIGBUmwOHkwsySdS9TqkNe+xuYTfjx+E+ChsfnhnnFDp6U4PI0xylWbj5GvMk67RMeGE8BzqJNYA8QV++bTQt6PKm5TxsrCsHRH/3Yl0JasDCg6r0VMitBKArMULrz1s9xP9D04J2rfwSk8MGzGWyfuBqRC73Am6caqtDDyCT3Q44WD2qX9EKBaseByDjgYL8P279kvSl5jFgNr8sGMms18vT9TpBOCFkfjy5EEkENZut0fN2VGnLmzKKFoqECORJGaQyuw/VFPEiNVE5yVi0k9QzxeaTWh1V0+l8x8i4rcQ0j2oldRWExdMtsxOCId5Z75gfxhyibGvXgVxUnuzdmOoN8LxBn/LVDh3VtSwBBltuku/CpHiuPoOIBPwDkxC97SyJyyDGoRNRXgKvWsMlthf51XnxJbGbICTg5TcUDRw7yhEOywSUKNeCABKRu1bk2PIx3T4l5/XcLdWhVJFBzlbMN5g+/
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(107886003)(71200400001)(6506007)(7696005)(83380400001)(9686003)(8936002)(4326008)(5660300002)(52536014)(41300700001)(8676002)(2906002)(478600001)(26005)(76116006)(316002)(110136005)(66476007)(66556008)(66446008)(54906003)(64756008)(66946007)(33656002)(122000001)(82960400001)(86362001)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eTZMWWczc2JualdwN2haQUZueTZDYVNjUm1rZE1pQ2dCbnNGMENSMnVIcHlD?=
 =?utf-8?B?bXNXRmhBZ3MzNW0xK21MejEzcnp5TVFKcTdWVG02TUNDRkRZd1hUWWZSVEhw?=
 =?utf-8?B?bzJPZTdiTGZvWWRQZEtTaElFZUY4VVNNTGxtZWJZbzZUV1ZQYTNjb3JERTNU?=
 =?utf-8?B?K0dGcDdTY0kxdzBZbHFIUHYxV0IyUCs5cHgxRXc2Q2szQ3o4a2F1U3czTDlr?=
 =?utf-8?B?ZEljR2MrSzYwZ1B1dnZFby9MQ290VUdCOVJUeFJoVWxKV21aR3BEZFN2elFY?=
 =?utf-8?B?T3VMRW11VitZeFB0eExOeFljQVdScG94ODZwT3dQdFlWeGkvZ3J1UEJlcXll?=
 =?utf-8?B?R2tvQy8rKzF6OEluY0tLYzVrM0gyWUdpOUZSOEFnKzJOZTMwajAxczhYWHRw?=
 =?utf-8?B?eWJOa29SVUo0ck1EMnlXV2tpb0gvRHZ5NHpkNk9Eam9XdS9VYTNDZVlEd3VF?=
 =?utf-8?B?WEgrTHd2WWltU0dCQm1rTEdDTUR0WCs0OEFOOVR5enBmd2twMzdLMk1ZZG5O?=
 =?utf-8?B?cEpGRGNzYVpOVWUyL241eDlWd1BEOWgzbGpwZXF5NFNtdWdpMTlEc20yTHhS?=
 =?utf-8?B?YW1acmppOXFtNnlHSS9YZ3FuU1NBV3pWSkVScXFhcnJmeXVEUS8zMVoxZnVW?=
 =?utf-8?B?eFNqTUIrRTl4MHgxL3FiM1ZIRHNibXJQaUQ1S29RSjNJcFpSRmE5aVRNb2Vr?=
 =?utf-8?B?dURvNnBlYzlXTmxyczdoRmtMYkhBVGJSM2lrZ0d5b2F6MkZ0WnpJbmdGcXZn?=
 =?utf-8?B?ZWhnQXgxa3lKTUs3c05hRmdTMWgrK21zOUNMV3BQOGFrSkdxVDhmV0dKZWVy?=
 =?utf-8?B?UVJXMzhyMEI4UGNXMlk2cjN6dFduN0E0cXZBOFZ2MTgrbmdoNTVUSzdaRXEx?=
 =?utf-8?B?NG9BQWRjM2JReHhzU2VIOUgzSE9wbjIwTExiMkxBQjlWR09BcnpHWjNUK1d4?=
 =?utf-8?B?T1FaYUc1RnFFdUhvOUZhd0k3ODFneGMwamQ5bzhtNjlQbStNbjRxUjQ1VDh5?=
 =?utf-8?B?eTd1cWlTTmVMUVdSZnZVNnErdk9IWnJOLzFJaUg3TjNDR3lwKzIrSU5NWnBu?=
 =?utf-8?B?WmZqR1U5RnlzWXpVUmVUSi9YTFR6UDBscjBmREZiaVhOcDdkeHpGejFzYnN2?=
 =?utf-8?B?Y2JlcjRWVlBabHRkOUVQRllFRjNKa1dmWk9OREtyMkcvaktHeW1vOEhnTGJj?=
 =?utf-8?B?Z2hwRFluWUdBcUhCZTdDcDZueXRvcGRMZEdFZk5POHdEL3pOLzQ1cHRlVHJx?=
 =?utf-8?B?RUpWVUJsMHpJNHZuOXRodmhZajdRaDYvbUhTQTVrVnBpYngraUZOdGk4czBO?=
 =?utf-8?B?aFd5bW1KSkZXVTNFTXJiQVZnL05HanYwVTBSTlJQSDF5cHIxR2hVZUU4ODB5?=
 =?utf-8?B?R0MwNTBvS2FxT1Nia0ZUTlNIVzVjUCtxK1QvKzE3ZkpoeUxMQkVkN05SbVVq?=
 =?utf-8?B?d0gxWVgrN0N6NVh5dS9rQ05RNjBGdnEwS1FLUXR6ZjArcDVwTUxaNGs5UURS?=
 =?utf-8?B?YUw5dkoySFcxQUthWThrY2tOdUhWK1lRWlIxc09wSXhoUmJpalZ4a0diWjVO?=
 =?utf-8?B?a2I1VlZrQS9rYWhJZ2tISjVvYWlhTjJYS2xvTU81dEpka1V5dHFUdnhIcUlS?=
 =?utf-8?B?SlhGYUpscmtIYjhJbWdJMENmREl3aVhUNEg1K1dyRFE4bHFBaW5OamtHQks4?=
 =?utf-8?B?TUxVRkhsRjc4d1M2bEV0WnRiSDlmZTBRcjljWkJIbmFaNnc4SE01ZGxLNUhY?=
 =?utf-8?B?SUd6RVVEVnlEc2o5dTB5bldlQ3FSaGRPWGFGN1ZITG5vRmVuaXJHbDJkRFY2?=
 =?utf-8?B?SDNST011QUxVSnN3d2YvSUc3bFFSb09ydWNsb0RmRFRkbzZRaVprWTVmcnVY?=
 =?utf-8?B?L2xZVFlJM3p6Q0oyM05kYXEzWFdDMEZ5Tk52bnZSbUdHRm9md3BlYXZPUUIv?=
 =?utf-8?B?L0Ivc2hJQllZM1ZWNUxTVHRrVXNSSmlhb3kwT2wwbjVvZTdNY0lpZUtwY0hO?=
 =?utf-8?B?SmEvY1NKWXl2aWFUVzcyZXVadW0xN05FRDM4SWtGeGs2d2xFWEZsNmplNnFq?=
 =?utf-8?B?T0YwR3NOa2x2K0pnZ1BjVUF3b1lxS0lBY2VhK01yditNd2h3Y0pBSnplYkl5?=
 =?utf-8?Q?Eq16nFlW+hoWKaj13nISctFht?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dV/M+tMHG8KETlWkLbHgeVv4AbrN0HyFNPUQ925ilQ4J9ugMdLiJ95WfNi4NMT5HApgIOLKLmgDq83oCqjDAfeDrBz9T+nKTnvHpKn3oU+C4Ux2DBx1c1kRfIpKbBxhvWFO16o8X0UBRI/YfYNDa/GQzEKiTXG+5PRR5p9n3zVs+kbpPwgFjiGfSzzC67rIfacZG9uhw6yp54+ZlKf2jeiCRFjYhsDvqbEr/SkI/Aw9ZMsedKcO5ceUDm4dSKRgMtJwPtpn/bmPyog0dh3xJOCSEpceGC7IlnrBykC+Py7em1/iUWatBV+2ByB05x5p8yockR3lIuJNZ/Gp/pvbnv5IpB8xSYMyLvZmqr2u8o+gRCCAPVEduUwhIgEquGnFf7x74tCWCmT2V4clQk+ldcI1XpdnIWl8MN29Bq3PZ2sPZ7r+fa9Iw8F5dLA2tZoMA0L6kKIq/HELVQNtzXNmHtQRjdSbGHo5wp7ddVftWJkmgaBzcOFP2vx8F6DeVDgWQJZAh/4I+xOLRO1YguVcR8l1QD+1s/sImMLrw2HCbBihlS5JHnNOrxvKk8KAj5uIQkwi8FaAcCUgKrM7QC0WI+ALrkCWgB4u4wm9QU0LQ0QATr5/E1m28ZwLYOdTchwGPOrEnTCWvVD/NrjAsYwHjxs7um5VErwkJeVUfKzzPl6SFbBcRJ6nG/oL80szhUDcS/O1zPTyX/vrHO7nf7ZVuTPHOayL1BtxYOSP0ZyM0oUw4zFVZBFXlNJV6T17RG8Bu+6tRXsXc0OhIJMnUnY2dXDFC31Tv4TSjmgpF/9dSe5gs8PNud6sPL/ZE9Yk/5zwnY8qgR1CGbXUtJoZKQ0sK9g==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dfaa34-7ec7-4a1e-7276-08dbdb8a4983
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 09:58:38.8204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsSaBQPcQDaH+sf9yaFEnzNW6SLrJeC+KYnmyE20WgWbqGK9o6CEsh8eBM/ZiOiTpVKtAWcavpZxeS4esnPBRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4432
X-Proofpoint-GUID: 4r9yJMo9iQXsjkqgMv7zrTsv02_TN4ph
X-Proofpoint-ORIG-GUID: 4r9yJMo9iQXsjkqgMv7zrTsv02_TN4ph
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 4r9yJMo9iQXsjkqgMv7zrTsv02_TN4ph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

RnJvbSB0aGUgZXhGQVQgc3BlY2lmaWNhdGlvbiwgdGhlIGZpbGUgc2l6ZSBzaG91bGQgZ2V0IGZy
b20gJ0RhdGFMZW5ndGgnDQpvZiBTdHJlYW0gRXh0ZW5zaW9uIERpcmVjdG9yeSBFbnRyeSwgbm90
ICdWYWxpZERhdGFMZW5ndGgnLg0KDQpXaXRob3V0IHRoaXMgcGF0Y2ggc2V0LCAnRGF0YUxlbmd0
aCcgaXMgYWx3YXlzIHNhbWUgd2l0aCAnVmFsaWREYXRhTGVuZ3RoJw0KYW5kIGdldCBmaWxlIHNp
emUgZnJvbSAnVmFsaWREYXRhTGVuZ3RoJy4gSWYgdGhlIGZpbGUgaXMgY3JlYXRlZCBieSBvdGhl
cg0KZXhGQVQgaW1wbGVtZW50YXRpb24gYW5kICdEYXRhTGVuZ3RoJyBpcyBkaWZmZXJlbnQgZnJv
bSAnVmFsaWREYXRhTGVuZ3RoJywNCnRoaXMgZXhGQVQgaW1wbGVtZW50YXRpb24gd2lsbCBub3Qg
YmUgY29tcGF0aWJsZS4NCg0KQ2hhbmdlcyBmb3IgdjQ6DQogIC0gUmViYXNlIGZvciBsaW51eC02
LjctcmMxDQogIC0gVXNlIGJsb2NrX3dyaXRlX2JlZ2luKCkgaW5zdGVhZCBvZiBjb250X3dyaXRl
X2JlZ2luKCkgaW4gZXhmYXRfd3JpdGVfYmVnaW4oKQ0KICAtIEluIGV4ZmF0X2NvbnRfZXhwYW5k
KCksIHVzZSBlaS0+aV9zaXplX29uZGlzayBpbnN0ZWFkIG9mIGlfc2l6ZV9yZWFkKCkgdG8NCiAg
ICBnZXQgdGhlIG51bWJlciBvZiBjbHVzdGVycyBvZiB0aGUgZmlsZS4NCg0KQ2hhbmdlcyBmb3Ig
djM6DQogIC0gUmViYXNlIHRvIGxpbnV4LTYuNg0KICAtIE1vdmUgdXBkYXRlIC0+dmFsaWRfc2l6
ZSBmcm9tIGV4ZmF0X2ZpbGVfd3JpdGVfaXRlcigpIHRvIGV4ZmF0X3dyaXRlX2VuZCgpDQogIC0g
VXNlIGJsb2NrX3dyaXRlX2JlZ2luKCkgaW5zdGVhZCBvZiBleGZhdF93cml0ZV9iZWdpbigpIGlu
IGV4ZmF0X2ZpbGVfemVyb2VkX3JhbmdlKCkNCiAgLSBSZW1vdmUgZXhmYXRfZXhwYW5kX2FuZF96
ZXJvKCkNCg0KQ2hhbmdlcyBmb3IgdjI6DQogIC0gRml4IHJhY2Ugd2hlbiBjaGVja2luZyBpX3Np
emUgb24gZGlyZWN0IGkvbyByZWFkDQoNCll1ZXpoYW5nIE1vICgyKToNCiAgZXhmYXQ6IGNoYW5n
ZSB0byBnZXQgZmlsZSBzaXplIGZyb20gRGF0YUxlbmd0aA0KICBleGZhdDogZG8gbm90IHplcm9l
ZCB0aGUgZXh0ZW5kZWQgcGFydA0KDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8ICAgMiArDQogZnMv
ZXhmYXQvZmlsZS5jICAgICB8IDE5NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLQ0KIGZzL2V4ZmF0L2lub2RlLmMgICAgfCAxMTAgKysrKysrKysrKysrKysrKysr
KysrLS0tLQ0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAgIDYgKysNCiA0IGZpbGVzIGNoYW5nZWQs
IDI3NyBpbnNlcnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjI1LjENCg==

