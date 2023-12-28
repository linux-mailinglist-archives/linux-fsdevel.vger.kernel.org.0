Return-Path: <linux-fsdevel+bounces-7003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC71F81F89E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 14:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74971C21D84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 13:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B3B79CB;
	Thu, 28 Dec 2023 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="m+xCoec7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2043.outbound.protection.outlook.com [40.107.215.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345B7496
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw1q8oICp2qHZ44r/xMxMUewN7qOXpQy2qcKeIN+D+GmRbiY5cNn9J5aem9jGLxWgmOLhJPTM/lyBnkonBK+gzlLzwrvrE0PD7elxVkmNloHqLQSulC0EYmRtYk3+7j1G+khsebn2GtSNUrTXHIGqy5BGL/Ily1IgCENj6L2NN8y7t8YE6xioSVurkjz5cMy7eP0xq+IsFxiEEFwdK2yWzhzS5Om0EViXHCtN7KEj5lyyniGwZkLXYXGbVuNDl9r+/BJ7pmVxOEV/XEvP8gDXU2C1XEcZ5Z008ei3IkC50QGad7tq8UFDdn0HxrYdzaIw9yR2gD0CP1PMyqLgqokIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU9bLgIMEsKpawfFf/IwRdCLLKqVMgRpmrSnPrUGND0=;
 b=DA6jh3lYmAwQppeCxO1TWWbt3xEgY6fSIbsJjfcXZTBN4ZuuZgk8zZsGMkbCPVZ58X32DK4gr5XNwL7yHurRF2lVyoFFxibR4CDRxelci6SokGCEljwRd0IZ5ECWidIs6FHCdzZ+1uaajYJ+5FrZIdhSJdTyb9WT22gsZcM6fjZbXfL6U7ZzkbvxSGmB4O355Bqei9UbjX0EPUj4bv0bwf8YiCeFznAJdWa/WmxXanUDzhIw7Z91VkBAQG7w/8kwK1ZddgrJdcPM4dM86Z0PyskEDCnoUtZIRNMi2FiTKom7bLOLmiBCZ1PAk7X43d0nGCly1v4d4P6DERXAgnMrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU9bLgIMEsKpawfFf/IwRdCLLKqVMgRpmrSnPrUGND0=;
 b=m+xCoec7NMKwtxBFu5NNv+VM1XNTfGu/krwSaKyjOl0BnNKPkIt/9EZKIcEUXjVSRQg8eaJwlPQzlap3zS1lhDxBcWQJ5mkLF27+2H5PQXgwQEMY1fuHv4SBVmyQQh+ilbjOzSZy7ucFg7rQJAv5TrlmQuEj0o6s37Ttum/VvaWH5k+msyrjlLcRyE2wj6rUywXL/eRnFW36JP5guzleDffkXy3YTIKEFgmsDd1RsBJj8b2rXq8NLKp/pwFpldSKfeo4NFZ8uYkmxf9n4jx06taYw+XRcMd1/J4mouSJN8K0+nx0FSE9Jh1Emt1hE6hhAGeFer1YDanIlBLPPvRjZA==
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com (2603:1096:4:1ec::12)
 by TYZPR06MB5321.apcprd06.prod.outlook.com (2603:1096:400:1f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 13:06:38 +0000
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::ed1b:8435:e0a1:e119]) by SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::ed1b:8435:e0a1:e119%4]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 13:06:38 +0000
From: Lege Wang <lege.wang@jaguarmicro.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "vgoyal@redhat.com" <vgoyal@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "miklos@szeredi.hu" <miklos@szeredi.hu>, shawn.shao
	<shawn.shao@jaguarmicro.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUkZDXSBmdXNlOiB1c2UgcGFnZSBjYWNoZSBwYWdlcyBmb3Ig?=
 =?utf-8?Q?writeback_io_when_virtio=5Ffs_is_in_use?=
Thread-Topic: [RFC] fuse: use page cache pages for writeback io when virtio_fs
 is in use
Thread-Index: AQHaOYp2dAdxgcNKdUmWrx247t1RqrC+pmxQ
Date: Thu, 28 Dec 2023 13:06:38 +0000
Message-ID:
 <SI2PR06MB53852C772180B28FE8AD7182FF9EA@SI2PR06MB5385.apcprd06.prod.outlook.com>
References: <20231228123528.705-1-lege.wang@jaguarmicro.com>
In-Reply-To: <20231228123528.705-1-lege.wang@jaguarmicro.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5385:EE_|TYZPR06MB5321:EE_
x-ms-office365-filtering-correlation-id: ca922159-b3a2-4f1e-a561-08dc07a5d3d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4QuPlkK3wTp5ITzuu4N/NL522Lkh4CTNTJHdyVnN7XakvO0sF0UoiO9YOx5g4gTfxYMqQIW6ZfmJ6CYtko9SgsfJFU8pDsMULIcjxkZs+DAt5i03CtgrSdKH6eFdTeVEwT8lU/lGwh7CAVEwiXMJ/7Y7922/UHuEczI/pRO08lj0Krq9urgl3toTHsQYhpIimhxJWvZXd6wwdr1UZo1COrX2s1uPpoePlHEWkFGbOBQU0WwH6Sb31uql9Q8z3PK2WY+hMLH6AigY6rcdDYrInct30CFnRbHQgdjqdFWYAaohHJzpcPZ3kr3L7N0P4gqDUUQii2mfCxfW5/tmVBSaswiPZsOpGjaPACfzWbc7ezBOMmZwcbDIC3z6gTvUS4QRV5jOLcT5UyVGFncXO9crQDbfq3927eVbrkaI7Dz+yOvOCJiu0ZS9Y6ym0HA2AYvbyXYlTU8qxF/NSEadzz84Cegg3clW5+izf+GQ4wppUXDtiefZntemuO3SAIV6hEdtbmk9AyZRda1XRQGgZrtnZkeDvPH71WbkuD5+AMDaz1je0D8S3v7/en4UT812PtC2K/eHPOj52pXK/qaKqAts6dw8tVfmQgqnvOcwU/fnYUwWhVWO87Q+Dr1/L6UdfZEq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5385.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39830400003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(224303003)(6506007)(41300700001)(38070700009)(8936002)(54906003)(316002)(52536014)(5660300002)(44832011)(478600001)(4326008)(71200400001)(9686003)(107886003)(7696005)(66556008)(76116006)(66946007)(64756008)(66446008)(26005)(66476007)(6916009)(122000001)(38100700002)(2906002)(86362001)(558084003)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3NocGtPOVZHa0I2Q1Nscy90S2gyUjRSSWwvR2YyRVpyRlZKTUZodWxoNWQv?=
 =?utf-8?B?OG1SbnQ5UDIvRzJaN3RCVVFDTzFOVnBJUGVHY3lwUTQrcVl4bU14RkNhaWgx?=
 =?utf-8?B?aEpudndQTnRHeE5nYmRqYnV2cWxkMlZJNTFhdlNqejVtdFV3YkhjUWlBeUln?=
 =?utf-8?B?S24vWVZBWWVWcDRjbzhReGVMYVo4MngzQjhjVXl5WmNzdFlReEZsYXUwaHRN?=
 =?utf-8?B?Wm1qSnNzeVFxTXVGU2Z6am1Iend6TURGNGUvQWs3MmtiUE53NzdiYXd0eFA0?=
 =?utf-8?B?VEFZSjRvRGROWUE1dHJYUjN4dkgvbGFZNkFWWm55UzdTbVo1RWFGK0c2b05Q?=
 =?utf-8?B?NmtTZnZrejhPZHRGOEVac01kRTBXV1FzZlo4VzhxNkhXM29neWQ5YW9JTXpT?=
 =?utf-8?B?MnliVWdnWHF6L0JDd3U1VHVMcktyWEN0K2lSWEdxN0xtR2VjbW1SUllqS1pE?=
 =?utf-8?B?Y2UvVE1VMFVZUmgzeXB1TXMyazVkQjYrM1BabkY3MFBYcFFYUG1CcUxSMHlx?=
 =?utf-8?B?SlBHWXo0djRZRUxEcnd3VXF4Nk1qUStoT1VpdG8rYU5ITzhYMFlsbkROU3N5?=
 =?utf-8?B?NlNEaVZOODVibElwNm9mUHZmZTJSS2F2THlyVlNrUm54Rnd0QnVMelJVM3Bi?=
 =?utf-8?B?Ky94UCtPczNnV3dVeFRTcWYwQjlMYWR3b3BPQWFES01ZMktUSFlsdmZISWxw?=
 =?utf-8?B?UitOeWVocXZyWXdlVko0aXZ5cFJXTXdOZmh4WXJKUk4xcHJiU0dOQlNVb0Jw?=
 =?utf-8?B?QzE0V0VENWMySGg3Slc3TkI5RytTa0ROeVBCdXd4cmxGR1hRcS9QM0ticTM5?=
 =?utf-8?B?bVl2dXZ4SFppVkdyaTAza3I4ekRDaVBZeXdKclVXd2FyRDJ0WXNRUHBNSGdX?=
 =?utf-8?B?WXhPQ0NOSWpHcCs4VWJkamk4ZFE2UHNhUDVsa2lOSzRBemFoOTMyWHFMUDNt?=
 =?utf-8?B?bmdVZDlWMGNqb0dVOGxYRThETEFESXFVSldCUmk3bFdhZVJHdGhjYTl5VnZh?=
 =?utf-8?B?bktrRG1rWHF4OGFERkdFaHRndGhPNDA4MVJLTDRzY1RQSlU3eE44YlIwNUhu?=
 =?utf-8?B?SDdud2lhSWw5b0ZLYzRzL0thL215RE9aMUptUmQrcHNhOXY1aytDZ2RYaDNO?=
 =?utf-8?B?Y1RSOE1wSW1zOVNKUUJwQjRzeTdSNmFkeDFCdGRzenpRRmlpT3pUZFZkN2hU?=
 =?utf-8?B?eitTQnpzTjVuRFc5L1dWWGgyaEFEVFhXTGN0VzBiSUJ2d3VGcXdIaTV4UU5l?=
 =?utf-8?B?TDhVakdJVE1udktuZTk5OGo1RDhCOC9SWW5CUFZ4cVlUK2QzVC9mdFd1MVZi?=
 =?utf-8?B?QmZ0SDNjaUZTUS9ZMkJBeUhNNEx6T3hJcGpxQ00zYUFiVCt3OXlSRmJRWjV3?=
 =?utf-8?B?MGtCQmx0b3NJQ1A3QkVRajZUdFlLRXdPcmhrNUxEbkZEQkxVYnF6ZG93S0dY?=
 =?utf-8?B?TGIzQ1ExUjFHeHFPZ2V3eFFzZlJ4UW1HZHA2RDBKY04xTnc1bTU5ZkJyR2h6?=
 =?utf-8?B?TlJKUVh6TTRFYjNPamtlb2tvYTlnWnNSYStoT2Z6OHFTM3c1bWMrQ3JBRUhG?=
 =?utf-8?B?MnMxTU9OcUtyaUZYeGorb1hxZC9TVnNrQ2NCVGgvcjloaGFqY1o1L2psS0Nq?=
 =?utf-8?B?VFVTSUFSMzcvekQreE1NcWJLbEpEcXcyaTRVb25kdTZZZi9VazhkalpVVVF2?=
 =?utf-8?B?aDVpQ3ZobERWdmc3ZFJYTEVDRGRJcnhoYXpBR2xYaXoybGJDaWlKS01VWmNo?=
 =?utf-8?B?Q0hHV2lwbXJ6akxpbW1UNGpHU01Nd1VhS3NkbVA4dU8rVTdkL0EySlRQeGVv?=
 =?utf-8?B?UWoyS3QzV3loMW03WnFZY2dxZUtLcXgxNjJ1YVZtZXhHM1RVVFV0d2xpdXhJ?=
 =?utf-8?B?QnBBRHR0NHNDNEwxazFLYWc2Qy9zamlueXQ3Y20xZGo4eitlUi95NnQvZG40?=
 =?utf-8?B?THBZMS8vUzFsTkpqZGhNam0yWjVGcU5lS05BTVJCcGdFMnNFL1ZGLzd1cWFs?=
 =?utf-8?B?RDVySnJNMHFiUEV3TC9vb1hiRW1zV0orV0Z1b1k2YUk5ayszeFFJeWsyenFS?=
 =?utf-8?B?ZS9PK2s4enlFVGtTMkp6TVJGOVU5Yy92djFxSEFPaHNyK0JQeTkveVdNT1FG?=
 =?utf-8?Q?QT5ZbpzUQu2/ynT5sZWDFpALs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5385.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca922159-b3a2-4f1e-a561-08dc07a5d3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 13:06:38.4157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHu2wgKkgnnfpK2Q3zWCEiuKyu6++CUB6LYb+GHQesB6Sec2ru5d23xvyGORkGbWEPAo8neGytlWD5fhyHTa1Dcq3qMPdmprK+c4tewu0ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5321

aGksDQoNClRoaXMgcGF0Y2gganVzdCBzaG93cyB0aGUgaWRlYSwgdG8gc2VlIGlmIEknbSBpbiB0
aGUgcmlnaHQgZGlyZWN0aW9uIPCfmIoNCkFuZCBhIHF1aWNrIHByb3RvdHlwZSBzaG93cyB0aGUg
cGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQuDQpJZiB0aGVyZSdyZSBubyBvYnZpb3VzIGNvbmNlcm5z
LCBJJ2xsIHRyeSB0byBtYWtlIGEgZm9ybWFsIHBhdGNoIGFuZA0KcnVuIHRoZSBmc3Rlc3RzDQoN
Cg0KUmVnYXJkcywNClhpYW9ndWFuZyBXYW5nDQoNCg0KLQ0KDQo=

