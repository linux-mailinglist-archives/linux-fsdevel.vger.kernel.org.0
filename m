Return-Path: <linux-fsdevel+bounces-6978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E5681F539
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 07:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0E71C21C34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 06:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B873C1D;
	Thu, 28 Dec 2023 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Yr3zY0cI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE63C0B
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BS5LcFp029839;
	Thu, 28 Dec 2023 06:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=VnZHycp6jI1p9faY8qa5WpUpWqERRAEfBqQ12r0k9mg=;
 b=Yr3zY0cIw8pr6srf8U3uLw56XYuZPUbnYCBIZk6o119LhK4XVabt9Jy7qId7xDK0fq0B
 QFeVExDWnhEJ4HAUagzBNnOuZ07sUj2qx4R9SmwaysS97dMBcj/A4yk4cqZl2QvUBCEX
 sT5z1JaBXraMsc0QlQmuEAwt9+G3X/XTA3JIWxeuY3JCGmkdhZBCmnOJx9Bts46PpkMn
 qQ2GlRAbhxwE3/cgO9XgfzX69j+96PIBndIc4qUu6OUwXmLwHLo8Ao0jOlwHBCnAw/qn
 d3LZQcVvRP4QFCRi6ifX35vDe3hJHQCCKSDkIylKzHzohirdohNq2V3zGsR3HpmgdOFP FA== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3v5pw1ut2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 06:59:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA5Ncdt+noyTETU+55adRcKYCGOn5ByYxjUalbd+Udzqu6nf9OwfZMYb7n73mqHcnJT9TvW4gvZbHWhe6H8nNCXGoujWeFKWfA/XmFP3tgzf9woofrxOxMkmV3EM8gUGX4p4+nozO0mgywiRyFf0e78KKiQ4mIrwG8XNfViu+N7w9dtIERompx9Vae/iXX/34rJucVxO9TLzJVOe+YeyMx3CUDHO8lPOnORvnIg3F9pn4hoL0Pu18b4rrmolPOCGZ8pOWLcTxpLGwmFpT9X7lrV/f/cafzC+m1VyZy7X13q8j30zX36RqboE8q5ZfnmFwZXn4S09X9siEe/iO22ncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnZHycp6jI1p9faY8qa5WpUpWqERRAEfBqQ12r0k9mg=;
 b=lUxSWNajKXPfXYmku1NtTJ1D7+3ZEnunBXRxxpKE10Z6D3mdHhXeQP2qDuIJVpG0SCMdtoBWfZYIp4qfUUs4x4aABNH0VJz7msCHwo3OMEG8+32G1Fivo3kLGOlcnA+k2642AUUPtsV879xn2qiJosoLLrOnKXet+rEUSsZSvspwSOKEYsdG1yAS0oY58VSolPbGQUfPf7l7coH+/KYIYYuGadIK+AIutM8TPStVcn2CfeS7yu7qRnF1MdocDUvJwFBmzJz01jbui1VCKkfC7xf5c10ZSllHM4mm/FCiINcWN9NISCv3EnptMjkev8aitDdqc70aJkcSaBVGOPwQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6878.apcprd04.prod.outlook.com (2603:1096:820:d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Thu, 28 Dec
 2023 06:58:54 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34%7]) with mapi id 15.20.7113.026; Thu, 28 Dec 2023
 06:58:53 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v2 00/10] exfat: improve sync dentry
Thread-Topic: [PATCH v2 00/10] exfat: improve sync dentry
Thread-Index: Ado5WJu71ggSUDvySECWBpSIgzEMmg==
Date: Thu, 28 Dec 2023 06:58:53 +0000
Message-ID: 
 <PUZPR04MB63168E78C43B0DD03532D841819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6878:EE_
x-ms-office365-filtering-correlation-id: c9c20b82-968a-4c15-4ef5-08dc07727449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ra5phT29KPolcCHdPLrXN+w/ixJ5hSUYkboDBcVkgW+v/vvF5anHbnRou/7vVmre23DXy+52jXL2EpdcY9chdUnWWJTck+zbyFYtRrB8WHyDxcM7f81U/yB0mDxV3rZF7PrzuwmbjYkPEwVwy1bc5LHqiimxv0M3R2BC8ALM6hobJqi98ryHfBa/WYe93N4ldm660QqugTsRQRRcwNwpCOXk9gwfaqHQ3dQ+nYfBD55KjlhPryfWpFj3chv7u3P6HEW6onjTaWZVIZDjcmLa61qxXWtv3ks6pbwGruQmJnw9+IVWxyKYySKMC74V83vqSibvE0L44H0IvogrSNsaJU8ICcsFOIwh9Vrl5FZJoKSVXjBzbMsM1pqBtZXPoxZFoy6uAnf6VQe2o4cbOzIJ6a0TzQOYw72eZjSi8+WPUfOIjkMLFPoLq5d/7+sxiqMLy3BpfsfdXfWc2YDmeNxWQtkPyDSjXHm7tZy9bl/vbpoqFdFT69vjEwC0oKbXaIHWnp+IqcgbMicDKXm/BR3mfIazjDMeYKZg9hPwd0yAOmIERcKNi+ejvECR5rn88dm4bTBzB6Kh7yCN+De5vNEeN4ag1D+XCevGdr/RyV3nZ4vbKLtOqPwZYVQlReBIiXTU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(33656002)(9686003)(6506007)(71200400001)(83380400001)(7696005)(478600001)(107886003)(26005)(38100700002)(122000001)(82960400001)(41300700001)(316002)(54906003)(110136005)(66556008)(66946007)(66446008)(66476007)(64756008)(4326008)(8676002)(8936002)(52536014)(5660300002)(76116006)(2906002)(38070700009)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UExWUkpyYWxOK0RUYW9zekdOZ2JvZkFCR2Z3SlRMVU82TDlVZWF2K1ZuSWZ3?=
 =?utf-8?B?clYxRXUvYmRKS25pbHRFY3hObFdQcXhxdUZsZ2kyYkZjSXZFVUFmcEFvME4v?=
 =?utf-8?B?OFlzVVZ0QXZJQTlrQjhLdU5UeEIwSHJ0ZnZRazNsSFdkZk9KNVNKNURqcVBs?=
 =?utf-8?B?U0tNU1ZqOWJDNm4rRWhKdlV2SGorc2ZZbFF6dmFyQUxmbUR3S3BXemxKSVpZ?=
 =?utf-8?B?N1R1L3VRNEpIdjIwQkJ4c056bW5ZRHdGSlpXbUxZVnpVNXcwdmNod21hSmVK?=
 =?utf-8?B?SjdhcVJTWmxSUzdEZGNUcVJ0MDhETWdQZW5FckFjS0d5NlRsOVdPWGlWclNi?=
 =?utf-8?B?L1dyM053eWJFNktrekw0amJWTktuUDVQVmRFbnVTNEJYSFlyWElTaGJvVWkz?=
 =?utf-8?B?Z3pqd1BGRkJMM0RwTStTaGxtS3pRc0hGc0NNeC9vb1U3ZzA0a3JKczUrWGph?=
 =?utf-8?B?a2c1UFkwU3ppVEJRbHZEM29RaE53TEdackZQSFlPMDBBZ2ZHb0FpTEZ0Vlhl?=
 =?utf-8?B?NnByNFRVMDFKT0NjYTUrYjc0V3E5VWZSS1dqeGRFelZ5MkpDSUQrdEV6d2NZ?=
 =?utf-8?B?UGE1V1hXQmo5bGFENC80czdqWlU1dGhrd3dMMDFpVXdIcmsyNk0xUXVqb3lP?=
 =?utf-8?B?Y0pIZGRoSVMrNmUyQTU0WWJzelA0VDg2Y2lWOXVWbzVkRm5NNklRMitKN0RU?=
 =?utf-8?B?bEx2YlVjY21pc0twZ004RGYrMkdXeHpMMW9WbFBoeWlCdGp5dVYwc0VwMU85?=
 =?utf-8?B?L1hOS1pLcTIzUk9KSy9YZ0lBNWRrY01saThJMnFqbkI1M0VtTnpJNDNzWHpT?=
 =?utf-8?B?Qk5Tck50d292KzJtT0hDMC9zQlpXMDhuM2p5Q0JWbEE1MnB5aExISVpPSmhE?=
 =?utf-8?B?eXVLcXVLNFV2NytPQW5TTWY0bTBJMUdoM1drc3QzWTZ6L1RZMzU2VERMb0pP?=
 =?utf-8?B?dUhYcm00dFFHM04vK212WWg4TWpyckcyVjVCYVVLeWpqVE1vNkJCSkYxcE5q?=
 =?utf-8?B?RGdDcDdtZjdUMnhGVmg2RGxiaVFxVEpoclMxbWJDTytWN2w4Nkxad2xjM1F4?=
 =?utf-8?B?bFNYUnFMR1FZV0xwT1BGT2xwME5hTHdYM0xqajZmNUpaQTJTOENyU08wdVBq?=
 =?utf-8?B?NnVjNFJTUzYxRTNlQnNxQTMyUmxPWEwvVEhEbnVPVnl4djdqK29WemFnN2xF?=
 =?utf-8?B?TDB2RExUZ0grWUpkZ04zNTM3Ny9HeWZNTmlFZXZqZzZJQUNCQmNrOWkwem1u?=
 =?utf-8?B?U0VqTWNhYXd6bG9BckVZcVFPbnR6bzhIVHh6Q1ZYbDJEKzdWQzZZczE3aGd2?=
 =?utf-8?B?ZnFyUjJtQnNnOGd1QlRGVU9Cc0VmVW1rU3diME9CK0N3L2NDZXM4ZlVTS3BC?=
 =?utf-8?B?QWRhUXdwdllzNWpxbDMrUW9TZ1hkdGJ6QjlXaXhPdXlIM0w3Z2ViVjFnSGFJ?=
 =?utf-8?B?ZEtibmlENE84M3JacU9HOWsrY0FRT0Jzd05MUHZ0TVY3NElsa1daSnQxNkIr?=
 =?utf-8?B?YklGS2dRZSsyMkxxb1U4MTIvOVEyS1YySXhGQ0N0akZyTnFCL2pRU1BjZjdB?=
 =?utf-8?B?TFRlZG10N0FlRWowUE9uWWZzandhZ2NiTnZiRGFDNGFOeTZXMFFxMmltRG04?=
 =?utf-8?B?bzV1dDE2UWdlc1FYdEdDOXBVNG81R1FydlAvYjVSTWJsaU1uUlAreWoyb1NX?=
 =?utf-8?B?eHkvV2VuRVhkMWpMSGtCS093R28rbTcrTVZmRWdpcW1PVDNVQStySzRjUEsy?=
 =?utf-8?B?NnErcnhIYXY3MmxURHBMZjhQQ1kzaVVncGI4MzdxVzJEcFdNd3ZJOEV4UEZL?=
 =?utf-8?B?Z3JVUWs4aVEwN1FsUkVzTGg3cnZnZVFpUExaZWVTQXI5M09veDRhOUxtdTg1?=
 =?utf-8?B?TnNka0RPa0R3OTZtcVJyTndQZlozWXVSa2ticE9zN3ZZQ01peWw2aEFuZkxT?=
 =?utf-8?B?Mk1PeEVRcWJ2ejFSbFZ6Q2NiaGlxdGpFek4zOUJoL3piU25wTkltVmVIVHp3?=
 =?utf-8?B?cnJpUmdQbEQvYUoxN0NkcnByQU1waEUwRFZyUFFUWmRpaTZXWDhyVGEzYldz?=
 =?utf-8?B?MDZXVDllNjZMeDNrRGZsNjdxK3FnMWlHT1puSDlBSHZSQzJSVlJGNW9haS9J?=
 =?utf-8?Q?Q3IZjnQDbXP8bUmqdzN8tgE6w?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	30YRw9YmxMOHMD6T7ei2SwfYkjphOY8S2lCgobqqxsPGPbaeYYCFxjBGYZoJRQ8M3poI1wghLRM7gY7LGqXZksDQcZT16zYMg1lIr4zuj0M0qoKa9vX2kPhRDFU6H6QVDpgAs8FUFx6qn+Nm+i6Gk1qxme9Poshwr//YVLiGvJ+ud5/XOlhLGs9457VE/ezKlPfLkocGAiCzRFIZPhU7FzPN19iLzjxg84pBo16XM3uL9NElEW+5ZjTS01IqFCxydSly4ruhnxouJlNCXR88OetDaYcystFnNTZZ4HNLTqwlzIpnsRA3bGgyJlIKhnLIaa2arOMaTNLd83AyVsXkWFFPfYMNc/wWZ7i3hggaES7vwYQYYrarviQFqqmyvSObXaHZ8oV1gultGquCDG5IAU46fPaQNcjCvPvC8qRHT5mNCiKS/h3gt8zZHTVMg/wT1EoFPU4xUoORjCvc/Rs1jr/hVUy26bIM1i2/KsbAb7xhtZpcs+zHYrwMEoWSuJbZzRyCHGEV1NLfo8cWQ8glbyneGHIPunjP1wXhiF9Hg1QOW/9zv2Kq2SQC1NwxkhisTk2pU+Bxau5+J7G2I3q//uub3+vrsk1nLnBxlcnpZK8XzP0+pQSPcNGRzC9DrNvL
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c20b82-968a-4c15-4ef5-08dc07727449
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:58:53.7814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOVjUEXCjydNdflrt3deiKPAWW7M+rgM5SNq8GV2rr4zAXJn36V+0j4VKyI4Of8CKUGdyVczUKynAgF0Jrp+AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6878
X-Proofpoint-GUID: IL_hygE5ZiA8w6tDOgfKcu-6yrjinmdY
X-Proofpoint-ORIG-GUID: IL_hygE5ZiA8w6tDOgfKcu-6yrjinmdY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: IL_hygE5ZiA8w6tDOgfKcu-6yrjinmdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-28_02,2023-12-27_01,2023-05-22_02

VGhpcyBwYXRjaCBzZXQgY2hhbmdlcyBzeW5jIGRlbnRyeS1ieS1kZW50cnkgdG8gc3luYw0KZGVu
dHJ5U2V0LWJ5LWRlbnRyeVNldCwgYW5kIHJlbW92ZSBzb21lIHN5bmNzIHRoYXQgZG8gbm90IGNh
dXNlDQpkYXRhIGxvc3MuIEl0IG5vdCBvbmx5IGltcHJvdmVzIHRoZSBwZXJmb3JtYW5jZSBvZiBz
eW5jIGRlbnRyeSwNCmJ1dCBhbHNvIHJlZHVjZXMgdGhlIGNvbnN1bXB0aW9uIG9mIHN0b3JhZ2Ug
ZGV2aWNlIGxpZmUuDQoNCkkgdXNlZCB0aGUgZm9sbG93aW5nIGNvbW1hbmRzIGFuZCBibGt0cmFj
ZSB0byBtZWFzdXJlIHRoZSBpbXByb3ZlbWVudHMNCm9uIGEgY2xhc3MgMTAgU0RYQyBjYXJkLg0K
DQpybSAtZnIgJG1udC9kaXI7IG1rZGlyICRtbnQvZGlyOyBzeW5jDQp0aW1lIChmb3IgKChpPTA7
aTwxMDAwO2krKykpO2RvIHRvdWNoICRtbnQvZGlyLyR7cHJlZml4fSRpO2RvbmU7c3luYyAkbW50
KQ0KdGltZSAoZm9yICgoaT0wO2k8MTAwMDtpKyspKTtkbyBybSAkbW50L2Rpci8ke3ByZWZpeH0k
aTtkb25lO3N5bmMgJG1udCkNCg0KfCBjYXNlIHwgbmFtZSBsZW4gfCAgICAgICBjcmVhdGUgICAg
ICAgICAgfCAgICAgICAgdW5saW5rICAgICAgICAgIHwNCnwgICAgICB8ICAgICAgICAgIHwgdGlt
ZSAgICAgfCB3cml0ZSBzaXplIHwgdGltZSAgICAgIHwgd3JpdGUgc2l6ZSB8DQp8LS0tLS0tKy0t
LS0tLS0tLS0rLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
fA0KfCAgMSAgIHwgMTUgICAgICAgfCAxMC4yNjBzICB8IDE5MUtpQiAgICAgfCA5LjgyOXMgICAg
fCA5NktpQiAgICAgIHwNCnwgIDIgICB8IDE1ICAgICAgIHwgMTEuNDU2cyAgfCA1NjJLaUIgICAg
IHwgMTEuMDMycyAgIHwgNTYyS2lCICAgICB8DQp8ICAzICAgfCAxNSAgICAgICB8IDMwLjYzN3Mg
IHwgMzUwMEtpQiAgICB8IDIxLjc0MHMgICB8IDIwMDBLaUIgICAgfA0KfCAgMSAgIHwgMTIwICAg
ICAgfCAxMC44NDBzICB8IDY0NEtpQiAgICAgfCA5Ljk2MXMgICAgfCAzMTVLaUIgICAgIHwNCnwg
IDIgICB8IDEyMCAgICAgIHwgMTMuMjgycyAgfCAxMDkyS2lCICAgIHwgMTIuNDMycyAgIHwgNzUy
S2lCICAgICB8DQp8ICAzICAgfCAxMjAgICAgICB8IDQ1LjM5M3MgIHwgNzU3M0tpQiAgICB8IDM3
LjM5NXMgICB8IDU1MDBLaUIgICAgfA0KfCAgMSAgIHwgMjU1ICAgICAgfCAxMS41NDlzICB8IDEw
MjhLaUIgICAgfCA5Ljk5NHMgICAgfCA1OTRLaUIgICAgIHwNCnwgIDIgICB8IDI1NSAgICAgIHwg
MTUuODI2cyAgfCAyMTcwS2lCICAgIHwgMTMuMzg3cyAgIHwgMTA2M0tpQiAgICB8DQp8ICAzICAg
fCAyNTUgICAgICB8IDFtNy4yMTFzIHwgMTIzMzVLaUIgICB8IDBtNTguNTE3cyB8IDEwMDA0S2lC
ICAgfA0KDQpjYXNlIDEuIGRpc2FibGUgZGlyc3luYw0KY2FzZSAyLiB3aXRoIHRoaXMgcGF0Y2gg
c2V0IGFuZCBlbmFibGUgZGlyc3luYw0KY2FzZSAzLiB3aXRob3V0IHRoaXMgcGF0Y2ggc2V0IGFu
ZCBlbmFibGUgZGlyc3luYw0KDQpDaGFuZ2VzIGZvciB2MjoNCiAgLSBGaXggdHlwb2VzIGluIHBh
dGNoIHN1YmplY3QNCiAgLSBNZXJnZSBbMy8xMV0gYW5kIFs4LzExXSBpbiB2MSB0byBbNy8xMF0g
aW4gdjINCiAgLSBVcGRhdGUgc29tZSBjb2RlIGNvbW1lbnRzDQogIC0gQXZvaWQgZWxzZXt9IGlu
IF9fZXhmYXRfZ2V0X2RlbnRyeV9zZXQoKQ0KICAtIFJlbmFtZSB0aGUgYXJndW1lbnQgdHlwZSBv
ZiBfX2V4ZmF0X2dldF9kZW50cnlfc2V0KCkgdG8NCiAgICBudW1fZW50cmllcw0KDQpZdWV6aGFu
ZyBNbyAoMTApOg0KICBleGZhdDogYWRkIF9fZXhmYXRfZ2V0X2RlbnRyeV9zZXQoKSBoZWxwZXIN
CiAgZXhmYXQ6IGFkZCBleGZhdF9nZXRfZW1wdHlfZGVudHJ5X3NldCgpIGhlbHBlcg0KICBleGZh
dDogY29udmVydCBleGZhdF9hZGRfZW50cnkoKSB0byB1c2UgZGVudHJ5IGNhY2hlDQogIGV4ZmF0
OiBjb252ZXJ0IGV4ZmF0X3JlbW92ZV9lbnRyaWVzKCkgdG8gdXNlIGRlbnRyeSBjYWNoZQ0KICBl
eGZhdDogbW92ZSBmcmVlIGNsdXN0ZXIgb3V0IG9mIGV4ZmF0X2luaXRfZXh0X2VudHJ5KCkNCiAg
ZXhmYXQ6IGNvbnZlcnQgZXhmYXRfaW5pdF9leHRfZW50cnkoKSB0byB1c2UgZGVudHJ5IGNhY2hl
DQogIGV4ZmF0OiBjb252ZXJ0IGV4ZmF0X2ZpbmRfZW1wdHlfZW50cnkoKSB0byB1c2UgZGVudHJ5
IGNhY2hlDQogIGV4ZmF0OiByZW1vdmUgdW51c2VkIGZ1bmN0aW9ucw0KICBleGZhdDogZG8gbm90
IHN5bmMgcGFyZW50IGRpciBpZiBqdXN0IHVwZGF0ZSB0aW1lc3RhbXANCiAgZXhmYXQ6IHJlbW92
ZSBkdXBsaWNhdGUgdXBkYXRlIHBhcmVudCBkaXINCg0KIGZzL2V4ZmF0L2Rpci5jICAgICAgfCAy
ODYgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCiBmcy9leGZhdC9leGZhdF9m
cy5oIHwgIDI1ICsrLS0NCiBmcy9leGZhdC9pbm9kZS5jICAgIHwgICAyICstDQogZnMvZXhmYXQv
bmFtZWkuYyAgICB8IDM1MiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KIDQgZmlsZXMgY2hhbmdlZCwgMjg5IGluc2VydGlvbnMoKyksIDM3NiBkZWxldGlvbnMo
LSkNCg0KLS0gDQoyLjI1LjENCg==

