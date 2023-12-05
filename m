Return-Path: <linux-fsdevel+bounces-4862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4FD805075
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 11:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2417BB20D68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 10:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADAE5C901
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="HFk7bsKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C2D10FE
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 02:16:36 -0800 (PST)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B54cC3E007968;
	Tue, 5 Dec 2023 10:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=Y+KyY+eJu2b9IvvS8W/D2GIAGVih+k7q9/1mW2ENSCc=;
 b=HFk7bsKUdl+N3713UOcVjphtHe5CJNdTVl2FIc0gP152/Pw78TnyDmAclHkbvgBm5FNv
 vosLdoz2OlMTPgPMYYzqVLcRkvbvJ2OVsv24OYBzMjgRcYhu+bsizHHH1NPUwkifzSV1
 EAivr9SpWZmKl0uDPlSwnxVzenAPQybgbkvCHuYTblx4IqFNLmHyqYOIQBNC2cg/ywm/
 /ZlQla6/yRVnPrdFM1c9hJxvcEouzd/0t+003RJ5A1P0Xjq4uwFN78VwbBLQSPKn22zo
 xBaVJdtOygahSbgML6eR6wPrGTCx2TC4bkBoR0MqxsjI4uAFL4kimYuSBG+COHAdXVlY gQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3uqvytjnun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Dec 2023 10:16:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAliMJpo1ogccuaEjvro9sJ+o8LIEDkVsb/iBIXnfMFbzvylWXO+fnQM/2ChjZZUZouAz9caie3Mb8+XFuZKAfYM+YIBrGMVcMJ+FOOjcELoLlyXVrPCs6ZyeBnFLxUEY0NGtVq1F4NJYPcgGO9/R/dMZcYQMpuBfzSN455vhMsBRF1p2bPeBKLihcfaLLzs5Nfoqt43qBH1vI356e+gZOlkftfU4gVfLZrmjlkCvl/0feFHiePe951QAmyIlV0Fxx6sFay3OyyK7lrZhKIkSlbYanq8osKnDsPsJj2Qk801Dyx+MlLUBgKI0c/bBDMKuTO52vZ1CFh4GhLqJvOWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+KyY+eJu2b9IvvS8W/D2GIAGVih+k7q9/1mW2ENSCc=;
 b=K98d1rGjdBVUtHsdh2QHz3Asqc3nvPvcPGCI5EBxgEZYy1P7L/GP9bsp9GGYJMl5ZOiqLCx6XH1iFGiSBSS/2jBgcxE6UQ/Pfkh2klN8flxbPM/0rtxZ0iB7hAq1U2dXPnNvuUAfuIyksm8tpD9TmM9EmBYeLYlxj4P1OU0PkIVzCFCNGJDqlMvfK7GeMgZGvuBCRwkd7g/HqP+LKfIgEQ27NpGbfnaVDrnzsiaBqWNSvprlD52o36VB1KLUDxlgxg+nrdmxTwpi2D6aNLyLtH8kX/Scpcu8rq0U2jZHp3096BYLBDw9pko6a47kVub+1Wb/11NSNhJo1wHr8810bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY0PR04MB5633.apcprd04.prod.outlook.com (2603:1096:400:1ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 10:16:10 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 10:16:10 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v6 0/2] exfat: get file size from DataLength
Thread-Topic: [PATCH v6 0/2] exfat: get file size from DataLength
Thread-Index: AQHaJ2QRA07S+aCZCkuGISZG+wv1gw==
Date: Tue, 5 Dec 2023 10:16:10 +0000
Message-ID: 
 <PUZPR04MB63167EF34D0B46A4D418A86C8185A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <PUZPR04MB6316D39C9404C34756CA368981A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <PUZPR04MB63164691A5119414706F66998182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: 
 <PUZPR04MB63164691A5119414706F66998182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY0PR04MB5633:EE_
x-ms-office365-filtering-correlation-id: 1691ef10-d0be-400b-d14c-08dbf57b33bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mWH8p5fMUSWFxN1O7zPbLwScQnnuuaTfCrwjuDwP2GCe/vsd4oc7kPOmIkhuTy8iRRPWVynLR964rUGI4WibXMR9Vfrz2VPQAVvafOq9XiJ0WiILtHklj+0hZfKb9AGxvJcV1ls0RYb7CVOPYUUYS5QvBXKfdtcRQN4E+RS7epnEbxSZYIp/6sQwsJL61QLK+BebUep504BUE+H4Yn/sXNMEFJPM/kmucspyipBMX7ENDMZpzIEqmgGtIJevKmcK52RMCtHJdWTSKt0enI6A/DYIOzJe0kL2HyTJQfDvz3uW/k8J6eLoouRm7SXm45I78xZ7W5ZTwpuueO7d0QQGuxcDbsfcaqiWFP7Jp+WphxYAxDm+9ps/FKNJIYfv2WcLz3zIVLHvhSJsWMq/FFJ/zYClQ2s/wO98659IWRrizZqISRVBvGCsWGdyylyKtPwZurHkA25UnrY1vAlJR2YqyK6iCPnWtVbfH5y3q7CBoSvzOa5NP+lMpIfIdu+asZtKMDblonKEYC0ya1Auf4XXymBRT2//mw2uYN3HWpBTwEdpoSNtIfXgvDnkDx6+TcJX795l9YPwSMMfOucedHeoxUdwfEmpqs8rTpLqTouiR08Ca9EtKYxXgxbabznqR98Gtg/1kW8GxfmDHIm3ZmgBo5aoiTVpRZXgIqr3WBdi+Ns=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(76116006)(110136005)(122000001)(83380400001)(71200400001)(478600001)(6506007)(7696005)(82960400001)(66446008)(38100700002)(8936002)(8676002)(4326008)(66556008)(54906003)(66476007)(64756008)(316002)(9686003)(55016003)(26005)(66946007)(86362001)(52536014)(5660300002)(2906002)(41300700001)(38070700009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d0FsVUhJbXV0KzlrcVl1b3QxTGhwNGhJeVRzYnlkY3NMVlIwaGdCdG5JZHd0?=
 =?utf-8?B?ZCt2L0gydTJCcU5NYTdBL3ZkdjVMYmhteTJ3cDgrcGo4cUV0NEVYbm1OdUU0?=
 =?utf-8?B?OEo4TXF1bHp5SjFtTGpwZEN3eE1RakxncU0xMFhUK0tWdlJsN2VoWUN3N1Z4?=
 =?utf-8?B?dmdacllSc2NsTTVUZjcrUlJoclk5QVc1aXlTL29Bbytqa21mZW41dGVIZmts?=
 =?utf-8?B?SFJOZm1mTTErVTc4aDIyMlQ5cHlmWE1QWTFnWi9zaVc1cUNjTERFdHdVR1Z4?=
 =?utf-8?B?RUJKaU9xbWpQaElsSnRSM000M0RxTFVYKzVYd0RBelA1MFVFbjV5Wk5sVFlE?=
 =?utf-8?B?cnhuL2Q1cWRVbE1hb0pZak9LVVpzTGFqa3J1R1I3ejVUczdVeTJZUHlSRVpY?=
 =?utf-8?B?eTJLNS84RVhHdWM5L3N0aDlLZ3RBRjlLdzBxZjVabEthYitRUjJhb25vSFRI?=
 =?utf-8?B?N3B2NTNncCtKOGZBNldnclpRbUhyVmQrWDg0L0tEeTZwVjVmWDAvT2hONDJr?=
 =?utf-8?B?QjZDdjlLcVJLSEt1NkZFZFNPOFN5VHpuMmhhc2RYdjhEN0ZPQUlodnR6YS8x?=
 =?utf-8?B?OFBVU25UbUNpZ3ZrbG84OUNESWh6MU1TaHluS2I2THp4cGQzMWoyakJBRXNU?=
 =?utf-8?B?aHE2K1krb2NGQmxCMjc5cHFIR0FlNTJZdGtEZEZCblNvUWpEWTJRdGRtaUVX?=
 =?utf-8?B?U2w2K2lxVGxuNzZMZ0gvVlBHTW14bElFYzRQMm04MTdGL0szWDBsNit5OVVX?=
 =?utf-8?B?d3lBUHlKQ21KMGlPMVcrcjRxcmdJMjVIbnlHaDFRN3hmckpGYjI4eE5RRWJx?=
 =?utf-8?B?RWJHZkNPYnlzTmdhV2Zzd3VlSGNLd0o4ZXV1Q3B5UnFYWnNORlNscDRLVjlj?=
 =?utf-8?B?RmpFZ3RHNFhleWFLOWxLVGh6UVdtS241UGs4VThBRXB3NVgyMU9pd2FpWnh6?=
 =?utf-8?B?d3FtNmdzcmpYQTdoUCsvNW45Q256T2pxWEhsTmlrbXA0Y0pIeXdYRTR3ZURn?=
 =?utf-8?B?ekNiZjFPdzRtdFFGWGliMVUrSWhJRjlvZ0wrNmVqWVpmQlZ1emhJMVphdENm?=
 =?utf-8?B?cXR2YmhYQU5PV3BMUFgraFo2UVIvMkgvNXBWUWJZZm9lOW4wZi9GSTFwYmVJ?=
 =?utf-8?B?L2dEODJzVmFqVG13Z0Q2aGUzVitteG9Wb1hNQlF5clpWTnpSbEwyVVZKcmQ4?=
 =?utf-8?B?c2dlYUIzSlZFUVNjYjV0VS81MTJjb2thNm9NV1NXSllSb2cycmFQNW4vTHU0?=
 =?utf-8?B?VUhSQktLeDlPY1I0RjhodHYvd1JEd3FZdHJSVTc2NnZwUm5FV3plNUtHTVlT?=
 =?utf-8?B?cW5Qb2lHZSsvRGVoeEkvZVVwOTVQL3JSUk9taTZmVWQ1OGs5ZHJkb2hGVldh?=
 =?utf-8?B?RW9TbVQzTFBsYk45TU52bFoxUXVZb0RLYzZxa2lOSWxHS20xOGNJTWdnWkdj?=
 =?utf-8?B?UVlHd0lYSWdQa1ZuYlZubEM1YnV1eThQUThpaytPYlQzTlhFWVZ5dmFQRzha?=
 =?utf-8?B?NlRHUG0wR0hZS1NGZ3E4WEcrZytZUzJFbmt5OU1Zbm9XeGwrdEZXWlpJVVZF?=
 =?utf-8?B?cURXaUF0cmlseVdtU0Q4OGZuVHQrYWV6NytMM2lnZmJhZnNoMHBRSURwajVD?=
 =?utf-8?B?dUZBUHBQZFdOOFowVzBEN2E4V2o0eUIrNkdBWGswYWVqNHR4SWt4L3ducVpQ?=
 =?utf-8?B?cXcwV2xGQnhINFlhNHMvWlBaZmNyVUJ1MGhnbFUvUi9xQnNyUzJKM3ZwcFAv?=
 =?utf-8?B?cEFYZFpVYktkdzVKQ2NQZUg3ZW10dnhmNU9vMW1FWk9YdnVtZG05Zlk3aUdE?=
 =?utf-8?B?V1MzL1d4bFNqbEZuc2c5b2x1bUlxcHRTNUdvaUppVHJQeDBJYkZpMmtNRDFI?=
 =?utf-8?B?RHdiN293VS9JeG1CQ2tpRGtlcDFIbXVFdnMxNUZtS04xano4RzBnVHNxZFRB?=
 =?utf-8?B?R1h6bUhVcFZzNlgreU5UZ0ZFd3p0M2dwY0xTVkgwVlkyczBvcHAzay85V1FZ?=
 =?utf-8?B?SVYwMmNBd0dUM21lNmJJYmhzczl6dTBYQ1BoZkNTejJ0cEp5RTUwU0Y2aUZ2?=
 =?utf-8?B?YWJ1WUF2UnlkSWg1VFNCbWNNNXMxQ2x2SXBaK3N0WmtDa200bk9URUpVZmpv?=
 =?utf-8?Q?i71XgalVH9ZEMhuPxaKOmUAep?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+7tol0wadUT1qgMxrZnF9MnCfxZUoeUxJzslkHgT/tfZ4U0V7Z80od4QrOHVBUuUHKgfpH4wxjtnngX3UNVL0kX7TtactV2XpKULQgEJWVk8ASQjPgBrkLZ1tB6f2LUev//pungIWupZasI3uBmrhLchMr1DA1y4/gq9Q3xImwGXkSfIrI8pgvqwXz+JUiMuRYVhFXHqHsOMlyrMJIQh1fi+U6T/OPHlq+c9X4Fdc/wtIOCJjWpdf3LyC/bdg/j8v/x89D5p2kTQ961y1xbI4VDlx8Zp1YdXtqA4TKbiskDsFzcpREYAgWkZCgdBIPYHgsbrvOyKRExL+HXG8QKVsIMEOmRbFzP8bynDZAUSeTl+VfetnCGMjw6RTJpo8i+QxkmWevrDU6id7jaAogk3sononwZblESijJGt+a1EGoDvGrHCjirSaDotRJflpaAfZfp2ox7IYJejMdP2Ca9u3AQwTqeXO77ZFedmL+nlUThjBQ1y4kjwIBF45Tf1qtGEfxqlNpyPIvKX0L+8qhdqxoMKK5EaLwpHWw1eK9fiAnKhA9yIz7Y9NCBF44lNQaw318t1orq9HQVBS+Y1EyNCeJM6DiAiTFMGd9BK4uNpaTyNdyBWdJG7ykfw9u+eW+wyTSqIezLLTsNQiIs6+x4+XhDO5V1dm8foPhXyvIMjnFm6J1lB11XePuGQ1Qum9LoCDZt0Vah8zfCNiHcgL5FwlAptKjdgd23gMgdeKbdAc//20zHtQa1kJH5mHM58HajJsqvDwdG6Vfms6HHrDDWoJ0RO390bbqZAxSz57dJEbF1ZZKADJPdWPiWmo2Jq4z2Wr+L3Cs6r24x57057tO3LjF1OWheFv/dj3dCAneBRx64bHhYjdkRrmnRI7j1MHiTg
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1691ef10-d0be-400b-d14c-08dbf57b33bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 10:16:10.0795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GdWnX75BXc3t3tU0QikPaBP2a9mlmJOLcCH4rX+ZmjLE5KG3ykEGPKWp7uTU0Pnrh3cq8FYQINb/DxHe3bThg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5633
X-Proofpoint-GUID: 9CLwwtZSRNUziMRz127QHjlgdolPR7a0
X-Proofpoint-ORIG-GUID: 9CLwwtZSRNUziMRz127QHjlgdolPR7a0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 9CLwwtZSRNUziMRz127QHjlgdolPR7a0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_04,2023-12-05_01,2023-05-22_02

RnJvbSB0aGUgZXhGQVQgc3BlY2lmaWNhdGlvbiwgdGhlIGZpbGUgc2l6ZSBzaG91bGQgZ2V0IGZy
b20gJ0RhdGFMZW5ndGgnDQpvZiBTdHJlYW0gRXh0ZW5zaW9uIERpcmVjdG9yeSBFbnRyeSwgbm90
ICdWYWxpZERhdGFMZW5ndGgnLg0KDQpXaXRob3V0IHRoaXMgcGF0Y2ggc2V0LCAnRGF0YUxlbmd0
aCcgaXMgYWx3YXlzIHNhbWUgd2l0aCAnVmFsaWREYXRhTGVuZ3RoJw0KYW5kIGdldCBmaWxlIHNp
emUgZnJvbSAnVmFsaWREYXRhTGVuZ3RoJy4gSWYgdGhlIGZpbGUgaXMgY3JlYXRlZCBieSBvdGhl
cg0KZXhGQVQgaW1wbGVtZW50YXRpb24gYW5kICdEYXRhTGVuZ3RoJyBpcyBkaWZmZXJlbnQgZnJv
bSAnVmFsaWREYXRhTGVuZ3RoJywNCnRoaXMgZXhGQVQgaW1wbGVtZW50YXRpb24gd2lsbCBub3Qg
YmUgY29tcGF0aWJsZS4NCg0KQ2hhbmdlcyBmb3IgdjY6DQogIC0gRml4IGJ1aWxkIHdhcm5pbmcg
b2YgcHJpbnRrKCkgb24gMzItYml0IHN5c3RlbS4NCiAgLSBGaXggcmVhZC93cml0ZSBqdWRnbWVu
dCBpbiBleGZhdF9kaXJlY3RfSU8oKS4NCiAgLSBSZW1vdmUgdXBkYXRlIGVpLT52YWxpZF9zaXpl
IGluIGV4ZmF0X2ZpbGVfemVyb2VkX3JhbmdlKCkuDQoNCkNoYW5nZXMgZm9yIHY1Og0KICAtIGRv
IG5vdCBjYWxsIGV4ZmF0X21hcF9uZXdfYnVmZmVyKCkgaWYgaWJsb2NrICsgbWF4X2Jsb2NrcyA8
IHZhbGlkX2Jsa3MuDQogIC0gUmVvcmdhbml6ZWQgdGhlIGxvZ2ljIG9mIGV4ZmF0X2dldF9ibG9j
aygpLCBib3RoIHdyaXRpbmcgYW5kIHJlYWRpbmcgdXNlDQogICAgYmxvY2sgaW5kZXgganVkZ21l
bnQuDQogIC0gUmVtb3ZlIHVubmVjZXNzYXJ5IGNvZGUgbW92ZXMuDQogIC0gUmVkdWNlIHN5bmMg
aW4gZXhmYXRfZmlsZV93cml0ZV9pdGVyKCkNCg0KQ2hhbmdlcyBmb3IgdjQ6DQogIC0gUmViYXNl
IGZvciBsaW51eC02LjctcmMxDQogIC0gVXNlIGJsb2NrX3dyaXRlX2JlZ2luKCkgaW5zdGVhZCBv
ZiBjb250X3dyaXRlX2JlZ2luKCkgaW4gZXhmYXRfd3JpdGVfYmVnaW4oKQ0KICAtIEluIGV4ZmF0
X2NvbnRfZXhwYW5kKCksIHVzZSBlaS0+aV9zaXplX29uZGlzayBpbnN0ZWFkIG9mIGlfc2l6ZV9y
ZWFkKCkgdG8NCiAgICBnZXQgdGhlIG51bWJlciBvZiBjbHVzdGVycyBvZiB0aGUgZmlsZS4NCg0K
Q2hhbmdlcyBmb3IgdjM6DQogIC0gUmViYXNlIHRvIGxpbnV4LTYuNg0KICAtIE1vdmUgdXBkYXRl
IC0+dmFsaWRfc2l6ZSBmcm9tIGV4ZmF0X2ZpbGVfd3JpdGVfaXRlcigpIHRvIGV4ZmF0X3dyaXRl
X2VuZCgpDQogIC0gVXNlIGJsb2NrX3dyaXRlX2JlZ2luKCkgaW5zdGVhZCBvZiBleGZhdF93cml0
ZV9iZWdpbigpIGluIGV4ZmF0X2ZpbGVfemVyb2VkX3JhbmdlKCkNCiAgLSBSZW1vdmUgZXhmYXRf
ZXhwYW5kX2FuZF96ZXJvKCkNCg0KQ2hhbmdlcyBmb3IgdjI6DQogIC0gRml4IHJhY2Ugd2hlbiBj
aGVja2luZyBpX3NpemUgb24gZGlyZWN0IGkvbyByZWFkDQoNCll1ZXpoYW5nIE1vICgyKToNCiAg
ZXhmYXQ6IGNoYW5nZSB0byBnZXQgZmlsZSBzaXplIGZyb20gRGF0YUxlbmd0aA0KICBleGZhdDog
ZG8gbm90IHplcm8gdGhlIGV4dGVuZGVkIHBhcnQNCg0KWXVlemhhbmcgTW8gKDIpOg0KICBleGZh
dDogY2hhbmdlIHRvIGdldCBmaWxlIHNpemUgZnJvbSBEYXRhTGVuZ3RoDQogIGV4ZmF0OiBkbyBu
b3QgemVybyB0aGUgZXh0ZW5kZWQgcGFydA0KDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8ICAgMiAr
DQogZnMvZXhmYXQvZmlsZS5jICAgICB8IDE5MyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLQ0KIGZzL2V4ZmF0L2lub2RlLmMgICAgfCAxMzYgKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLQ0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAgIDYgKysNCiA0IGZp
bGVzIGNoYW5nZWQsIDI5OSBpbnNlcnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkNCg0KLS0gDQoy
LjI1LjENCg==

