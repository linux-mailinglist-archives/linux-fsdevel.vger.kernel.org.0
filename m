Return-Path: <linux-fsdevel+bounces-1794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F607DED97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 08:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C60F1C20E20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E4B6FAD;
	Thu,  2 Nov 2023 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="illgXM+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF096FA3
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 07:46:07 +0000 (UTC)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0083BE7
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 00:46:02 -0700 (PDT)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A25b3o5022467;
	Thu, 2 Nov 2023 06:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=z1ZpYz8cFW2Vb3qG63+OFoKc2zg/6x1FWuOVFWzS/Tg=;
 b=illgXM+EVIy7wLp6aKm4D0a60/pjxF3lVUU6An1QvkPnffKcS60BpBp/pHK+Cf8iUf47
 KMeqr8XyIRJAzTo8+emrd6CmikQP8nH2sRXeCTlYNlkUwfLNfoH6whGm6Y5WlhzCDQUm
 MUCwGCFYoPFDJbejnC+AvsEcLtXeB/s3spDnYAtqBc3/vGZgqmSnmqyXXKabmjnwYjZp
 c4lZDqf0rDQi4Tesw715EPQHjMmxGEGZKzsCX8AilS5qtcOtvL3WvPXXQLZ9Duy+lxzC
 tm+Zk2KSo6ZNVlKBdYVAW4V9mdCSHemxIkt10rkn4ht0wQGXspJwcj+B4Shs98DfuqmX 3g== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3u0rv659uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Nov 2023 06:10:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/bUGsTW8g1QJIBH6C5Zh/zS0W/1uDukWJuoqai5/Bq5/dJWI8Q/reDovn7UESKH6KhsCBQlTfEBoR3iQ32XpFvBdi1gumqVxj/fAWXtwt5XRkg50NlmXP4Cpvwe+dDJKYWNk4FSPlZn5+1YwDBQDIhIQDNrUVHRv/blEblFylGd5u0TolzMXrZNz0k3g9XjjtEq4ULwXqpbKyF6Su9hvY2rX6YdKcOfr/T/GYZ6Wvfv7FlcogRM9Nd7ASr6BZ9Xx3Uwg6TO8ea3ootvVbfhSNKyXtMqcXUaPV7qNACucywHQsIWaEEW0PRaDuOsbr7T988wfF/f5STYC4loniGJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1ZpYz8cFW2Vb3qG63+OFoKc2zg/6x1FWuOVFWzS/Tg=;
 b=ME1vVyn+GdNV/dWgJB85t62CrPcQUNvd8G9r9uEmDTFLiPHmBaaqOhbZlNeXc76VZT9yJA//sh28smkO2IrkA63E9OXDUbpAk4+W7zGDiZT1prVeT6TLKA0jg3LB6RgezVGfnEPOszQpfwLjnWSGVKWkhzh84M6XZ0QAZs+ww7jCr+Vr7cK/7+uJutbQvRlLj/4iIU+nknBvnYv/g0CJ6UXd7weTOoQoMvDMcIzQmLfOVlREZUoAjXWJEuEbGUaw0a+0XU+Y4c648F2ljekDJm7M/BH/kA08frLbICRcPZ5OITDdtmEA5P0kQkCYUPdOYIvutIHeFx5PfuVkInqbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB7408.apcprd04.prod.outlook.com (2603:1096:101:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.20; Thu, 2 Nov
 2023 06:10:26 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.6907.025; Thu, 2 Nov 2023
 06:10:26 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "jlayton@kernel.com" <jlayton@kernel.com>
Subject: [PATCH v1 2/2] exfat: fix ctime is not updated
Thread-Topic: [PATCH v1 2/2] exfat: fix ctime is not updated
Thread-Index: AdoNUu6tBN2Qe7smSPuW28E/tnlHZw==
Date: Thu, 2 Nov 2023 06:10:26 +0000
Message-ID: 
 <PUZPR04MB6316869EFAFE8BC496D88FE281A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB7408:EE_
x-ms-office365-filtering-correlation-id: 2f62afd2-3a90-471c-cc26-08dbdb6a685e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ml/dRMqltVSO3yZnpJxYvbJo39IvmUBehjBNZxsbL1DmXMPwMEGSA/7kaYPJYVxtzQIWlbPQSE9kTa0tkrosu34Ztfuggq9n4gGRpnxBe212d/xeVcy4lBQEY/lyUSd4KOP60fr90t9oAYbpyAITxp+iCxSzEkuptSr6nFCD7Gz71E2NiDBK6NdynbL4LGy6fYk/nbQ552RxWeQPev7r9zcCzjJUwgSksaUf7mGiME0fjxAW8xxDHKACyqz1G5/p5GYxBUWkEedA4TtNUH1kW5f/1rHCJU2pgxTaKyOJz4CmNQHLwaieViR2g/QFVwprzRvZzH7rJTADBDsAxZ3AkKTvk0YMPB3fySp7twkHkvSQrYcSX9uycU2zIY10pH8DcINM7abNotWvZaZ6ntCeiNDt2pRyb7UJjZLlu8XCMyA9a4n0qaGSM5DiC8XFtSDcoVPXhGmWxholDf1GlGF0BQb4j565bukTRJniz0CG4TKIjvELlLRCxLxASueg4DMKR85+N2jWQyeJGcY5UeZG5PG0FBCROr3blHqjSCZcWvuhFJ4Oed46u0k0dnZ5liuxwz0r/sJL/sE2paUC3blb0o7PNDtlCy2UIhZ4Q/CXY3uYWz67GcDO59pXAfh2ChNu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(110136005)(66946007)(76116006)(9686003)(478600001)(71200400001)(66556008)(66476007)(64756008)(316002)(54906003)(26005)(66446008)(52536014)(8936002)(8676002)(4326008)(83380400001)(55016003)(6506007)(7696005)(5660300002)(15650500001)(2906002)(38100700002)(82960400001)(41300700001)(122000001)(86362001)(33656002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b3RocnorK3c4dzFCM1grNncyWnNIV1pObGVwVzJZM0IraDNWNkVQZlB1eGxo?=
 =?utf-8?B?TEttQkdmTEFmcVY1bXpUcDY1Z0RnQWM0UWFaS2RqMFU1S1NiMUUyTFVMS1ho?=
 =?utf-8?B?OGR0VzZRM2tBRnpqZ3pMZHQrNnRWKy8wTnpmZG52aStaYjdaOXJEMFBpOThC?=
 =?utf-8?B?RldIWm9xTEVhdS9RSHFZbHVJYW9Rc3QvSnl6TDM2S3BQaS9zZCtQdGlZcU9S?=
 =?utf-8?B?cWVlbndvZlVlVE1ZZ2NsUUJMc2hlWDRhbElrbVI0UlJ0YTdEM0lxekkvRGRs?=
 =?utf-8?B?RWR1cVBKQmVDcWw5dEJvUHlmaTZQS2NZa2pYcS9yMENnSjloMGRuckdZbVRO?=
 =?utf-8?B?QXpEbnBMWTZjZGh2UnNob2FzdzJuRU40ZFZYZ1hDS3pvYWVDbzZqZkQ4TTdL?=
 =?utf-8?B?Vk1tN296NEtQcWI4dEdNdWRGMmtwWHV1cUJqei9vUE9XSEtXWjVBdVBWUEhM?=
 =?utf-8?B?ZzBnb0xTd0ZLeURSd0Q3U3ZkbExGdy9ObXozLy90b3lJaVgrNXN4MG5YZVNI?=
 =?utf-8?B?L1FORXBPMVliL1hBaDNvUjJYK1FjOEZ5Q3RuQ2Q1R01iRWFLSVdsNE9UWUNZ?=
 =?utf-8?B?TDRGT2dMZWZDYVg5U0dQWFk4TFlLQ1ZlOVhWVjFNOEdBb1pUUnFYR3M3NUQy?=
 =?utf-8?B?dE1RbDY5VC94amtwZHFCcFBVRWJSbFg3S0dtaFc0cWRubnl6Z0dGUFpiUllD?=
 =?utf-8?B?T3preHB0R3l6MGtnQ0dxbXNxR2RHYkdrTzEzdVYvdkROa2JQUGdCNnMvd21p?=
 =?utf-8?B?NzM4RzJOQ3pGemkwTDRzdFVJU1puTUhkVVh3NDkyRFlQY2tSZnZRTC9NeXFa?=
 =?utf-8?B?S2I1aG9qQm5ubTFUSC80SDJMRks3L0w1Nlg0VndMc3U4WUNPaGFuSUtnYkg5?=
 =?utf-8?B?S3k0R0Y2WjdoSHdVYU9TMEdFRkthN0R6YlFaekJhNFppNmFMNTlnaVJnWkNH?=
 =?utf-8?B?UlZvNUFkUHlWY0djK0RoZEk4TG5QeE0zUU9wTHFhTFliTlB1YmhCeE16cGVx?=
 =?utf-8?B?dFZleU1ORS9TaEdHdzcxbE11UlFFTERUek50dW5oOS9mc25xM2FBZk0zb1dm?=
 =?utf-8?B?UTI3WEt3RUdITFhEVGFQY2l1V1M4SFhRSzI5blpwcHFjeUJQYmN0ZjlBbEdH?=
 =?utf-8?B?ajZsNEtTem1FZEhMQTVUeE9Pa3JId09zYkdzRWE1L1Q2SlNORzJyUDFFL1lD?=
 =?utf-8?B?c1ZkK2haTHdReXhoUjFsdklkRDByalNkUjdvSE9paXAvQ1kwR2pVbVVkYnRY?=
 =?utf-8?B?Zk1qMkg3S1VZbnFtb2ZDTlZXYjZMbEp5WG95Znpyd2pheXgvRWwwREJkNmwx?=
 =?utf-8?B?MDlLTlcvcXI1YlhhVXhCay9XZjh1dTA2UTRkK0YzdFFmZDFURFBwMk10QnY4?=
 =?utf-8?B?NVR6RGVQZkQxaHRGT3ZFZzV5OXVkbXlJMnZNR0Qvc3gxNWNyVmFDaE05MVN5?=
 =?utf-8?B?SHNGOXdhN2xiRllpcnpuTkZOcHgxbmlOWThWcFkyaGdSalVvRlVXSEJWNHEw?=
 =?utf-8?B?bmRWWmlFVzlTRVlrWUtTK015bnZFMW0yNW5mMmdvRDZESjJzc2dQZU9oem4r?=
 =?utf-8?B?OWRsaCsyeEV1emNzak5jVkVDOUxONVVTNXRLRytXM2J1U0g3amV5NCsyS3hw?=
 =?utf-8?B?MWJYZ0JmQTZIc0w5K3NPcXBiNjVkNDArNDEydkRrTy9NMEI1TU9LcXdHSDBQ?=
 =?utf-8?B?QUJIL3NWcWk2R2FpNXJjZy81R0ZRUnZ3MGN4ZDZVazA3dlVJVHhMc3U0WCtZ?=
 =?utf-8?B?S3R1dHFOTmRJYnA1SlZ5dnVubDdFQVpRMFc0WWUwcU5TOUt0eFovMFZlWXdT?=
 =?utf-8?B?TFNDY3JhOUZBV05pWVVudGVaYllWa0NQbTRtK0owdUcvRWI2bFVUQ2QrVlV5?=
 =?utf-8?B?SW40RUQ0V0xSY3ZkRDR3bFhaSFB0V2cyMk5BYUI4OWdpYW1GajVpbTR3U3Rx?=
 =?utf-8?B?NlMyL0h3QTdoeEZUZU16T0Q2bDAxczJsM0QydDhjZ0ZtWEFxdzNValB2dk1N?=
 =?utf-8?B?a2pzdGo1cUQ3Y2o0cTNhdzNyU0p5eXB5d0NPbDFjYXZGUmxteGVUUTlIY2wv?=
 =?utf-8?B?VklVbm95ZEQ1WnNpZWFsZ21OZWg0QkYrYzVXdG9jOTQ1YkIyNXlCL2EzaTAr?=
 =?utf-8?Q?KSRHNmLpskvfUQpdAC7e5KNkc?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	36jLU0nbfrdNqJMQ5SFsoPruCukXlVkMdZfQARNQwCBNpAXiqhfo265YjgLHKC494eQAAm2A1xbGKXxa7kLvY5xDjLBpeQtpQuVPSLYKjurgoJWeStsVnWJe1twV+8GkuJMghM/ThlYomGBhxt53PkrT6DaDLkpz6OQx5AcncBpXx56gkUh+o54NbX2cUttSovdfiz23p8vbZFSJGTmUSIAW2R00L362c24yx+swMNX6BUSmypYnF5r8zABvze9VxjQhauV7zttDioMx3LGN4wPgluW8k0wf2j4eLJP3dMBFrlYvUD9lbOtW+cwDWAofgeLc+9fyqFQfLJqoJrAev8noxiCNvyuauwFf4D0claNXhYa89feaVyyWF80R0KTiJb8VtZ93odjhOTxamaBg8dS5jnqrlsHQdjslrAcBp6eVbgScVa/LvuW7VNCjJYNK20pfUaLgjPQ6DOxPx/uwPEM0Ts/s1W4z8FbC3SpFprxz6p0tmqEWxVq6V8XH3wduMtXQ+By+E+YwWAyvGaBw4LUl5KyaphhwWT6wfSuyPOAVd5it4YsOCQKJjpXGBNB5dsC1uc0ZoraFVCE6jpkiCZXQoIVZHmETelZU11sEoFIow4aiZzM9O8tKLhhviU50Wq6mRTQMGW8WcD/xILVVAxLJYSG2nsye9JZc7ov0RP+ievBck1Y3TBEgWhyJEJbxvTHTfeFw+KT7SSUhFQ7trE5SBIMBazZm3vZH0vEVr2VZnK5isMUOqLi/582DaB+hzO9Nq+wKwNyizKqPTCLt/N+XH1ssDkLgrPzBT+hn6a/M0f6UEE3/Kl0Lc2aAvjlwsVQEP+3uqFTxzG52MsgGxjbbwZNZK1dkkzrOrfJgX3QOKmAauXuQhEeSfE+VbIur
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f62afd2-3a90-471c-cc26-08dbdb6a685e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 06:10:26.6913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uF99tjogiedq+5BYcc0LHl9bRkFHDdkc259qQubjL+xTxmb51RtTszMhEMLN8S4rTxRlhGqWkOm1JQ0uCAounw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7408
X-Proofpoint-GUID: aEGGaplJTeskvJ-9GMQeintlNSn6R3lM
X-Proofpoint-ORIG-GUID: aEGGaplJTeskvJ-9GMQeintlNSn6R3lM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: aEGGaplJTeskvJ-9GMQeintlNSn6R3lM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

Q29tbWl0IDRjNzJhMzZlZGQ1NCByZW1vdmVkIGF0dHJfY29weSgpIGZyb20gZXhmYXRfc2V0X2F0
dHIoKS4NCkl0IGNhdXNlcyB4ZnN0ZXN0cyBnZW5lcmljLzIyMSB0byBmYWlsLiBJbiB4ZnN0ZXN0
cyBnZW5lcmljLzIyMSwNCml0IHRlc3RzIGN0aW1lIHNob3VsZCBiZSB1cGRhdGVkIGV2ZW4gaWYg
ZnV0aW1lbnMoKSB1cGRhdGUgYXRpbWUNCm9ubHkuIEJ1dCBpbiB0aGlzIGNhc2UsIGN0aW1lIHdp
bGwgbm90IGJlIHVwZGF0ZWQgaWYgYXR0cl9jb3B5KCkNCmlzIHJlbW92ZWQuDQoNCmF0dHJfY29w
eSgpIG1heSBhbHNvIHVwZGF0ZSBvdGhlciBhdHRyaWJ1dGVzLCBhbmQgcmVtb3ZpbmcgaXQgbWF5
DQpjYXVzZSBvdGhlciBidWdzLCBzbyB0aGlzIGNvbW1pdCByZXN0b3JlcyB0byBjYWxsIGF0dHJf
Y29weSgpIGluDQpleGZhdF9zZXRfYXR0cigpLg0KDQpGaXhlczogNGM3MmEzNmVkZDU0ICgiZXhm
YXQ6IGNvbnZlcnQgdG8gbmV3IHRpbWVzdGFtcCBhY2Nlc3NvcnMiKQ0KDQpTaWduZWQtb2ZmLWJ5
OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW5keSBX
dSA8QW5keS5XdUBzb255LmNvbT4NClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUu
YW95YW1hQHNvbnkuY29tPg0KDQotLS0NCiBmcy9leGZhdC9maWxlLmMgfCAxICsNCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2ZpbGUuYyBi
L2ZzL2V4ZmF0L2ZpbGUuYw0KaW5kZXggMDJjNGUyOTM3ODc5Li5iZmRmYWZlMDA5OTMgMTAwNjQ0
DQotLS0gYS9mcy9leGZhdC9maWxlLmMNCisrKyBiL2ZzL2V4ZmF0L2ZpbGUuYw0KQEAgLTI5NSw2
ICsyOTUsNyBAQCBpbnQgZXhmYXRfc2V0YXR0cihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3Ry
dWN0IGRlbnRyeSAqZGVudHJ5LA0KIAlpZiAoYXR0ci0+aWFfdmFsaWQgJiBBVFRSX1NJWkUpDQog
CQlpbm9kZV9zZXRfbXRpbWVfdG9fdHMoaW5vZGUsIGlub2RlX3NldF9jdGltZV9jdXJyZW50KGlu
b2RlKSk7DQogDQorCXNldGF0dHJfY29weSgmbm9wX21udF9pZG1hcCwgaW5vZGUsIGF0dHIpOw0K
IAlleGZhdF90cnVuY2F0ZV9pbm9kZV9hdGltZShpbm9kZSk7DQogDQogCWlmIChhdHRyLT5pYV92
YWxpZCAmIEFUVFJfU0laRSkgew0KLS0gDQoyLjI1LjENCg0K

