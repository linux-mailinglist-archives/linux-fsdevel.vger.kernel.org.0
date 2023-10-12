Return-Path: <linux-fsdevel+bounces-201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B77F07C77D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 22:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43FE1C20F75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA373D3A7;
	Thu, 12 Oct 2023 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EESR4x9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF33CCFE;
	Thu, 12 Oct 2023 20:23:55 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF1BB;
	Thu, 12 Oct 2023 13:23:54 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CIAgqv029693;
	Thu, 12 Oct 2023 13:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=1zwU7DcgxQmVnElD7sMqR40Qi3pGNtyzFb2I2XY8QMo=;
 b=EESR4x9lfDcKvsjtUejXR6FFw34ZLRHKoKh6T4P+qC6jLoERQX0c1p/xtvtYgfq/tBQG
 Re4yHQrHprxzvYilaYL2Mwmkm/Csy5/+L5vg5VNEQg/B29teD0atU35h3s6XHNGl0rbJ
 Rbaus8eOO8lZYzesgKsewD7SjRUn42v5esktsSDhVvnCW04mMk+fubUsqHg/I4QPx+0t
 sRSuTfMQ3e422AX6zDhV+1hPowhBFBUDHS9/o5adOEb19ur3CdxehhqY5iak++uWMEJu
 o8u97cck3TKT6v75llYNs0asjss0uekfgtlGAi2kDovV0VLbGIzbe5VZhkWWWYqPUpuD fw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tpbryrfw8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:23:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWGfoPHYquecm1YKKV09gystuK6Kqs5Vc6A8IS4vgT7cfkBuIc1EPrhZ5YPB2WxM4oE6Kc+bouRcWI2/vXXfeQLRDc0gg0SKOY24QH/g/cT+kTk61Cay/FGmLerozdfweOD1t4IHHuD8A1yM66zfmSmYbxHzWYhqlv280xii0iLSX1V3CMGOWR4+OXZwC03o/UbFjn/Fu8CPusMBmnElYNGoOrRh2QKe7D/0IuWavScVu/18+BsrkWEvJWrTbdWJiv2vKOl3sf3F3khDssSkaJFmUdlthiH30MDvpLpoMy+/Agg8BeEQ8XuV5GHAzAylbmlLH+dB6iTkPUngQIULPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zwU7DcgxQmVnElD7sMqR40Qi3pGNtyzFb2I2XY8QMo=;
 b=MpdSPt7RO0CqE6OImEG+mhRbx5qmXbQAZ6iAaHzqfoJ1qTv4/70JkMkeV5zbCHl3oO+pHnBPnzl8tT3R9CXTRWc6MPPHai+4Q6MfYLzw2CXw136nyZmVPlhJU8D0MV0nREtNiWqmrE8tiSHX7qOXUNpVsWpN4qvO8tXm0Dju9pfAUTAyQGwsQl8haL+SLaDQxDO7A34zmD0Lj/rlRvwAIwIQnsoiJGc404+mlYS9zIqm9bLTeo+wBDULH7pcv8JzSHnoDpBveJS3WKHIgnvkxuQ5++PpDNwkMF7oyQQ7Zvp7jO4WMs4pZuFucQ6h4Bpu20cdZTx7xNGr4Js8NhMMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SA0PR15MB3982.namprd15.prod.outlook.com (2603:10b6:806:88::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 20:23:51 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::60e6:62d8:ca42:402f]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::60e6:62d8:ca42:402f%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 20:23:51 +0000
From: Nick Terrell <terrelln@meta.com>
To: Kees Cook <keescook@chromium.org>
CC: Nick Terrell <terrelln@meta.com>, Eric Biggers <ebiggers@kernel.org>,
        syzbot <syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com>,
        Chris Mason
	<clm@meta.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com"
	<josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: Re: [syzbot] [zstd] UBSAN: array-index-out-of-bounds in
 FSE_decompress_wksp_body_bmi2
Thread-Topic: [syzbot] [zstd] UBSAN: array-index-out-of-bounds in
 FSE_decompress_wksp_body_bmi2
Thread-Index: AQHZ+WIW2tZXKI1VfkS0RwXdr6keRLBBuYeAgATf4ACAAATqgIAAAuQA
Date: Thu, 12 Oct 2023 20:23:51 +0000
Message-ID: <176F983D-1160-4163-93DE-553AE89E8D3E@meta.com>
References: <00000000000049964e06041f2cbf@google.com>
 <20231007210556.GA174883@sol.localdomain> <202310091025.4939AEBC9@keescook>
 <19E42116-8FE3-4C4B-8D26-E9B47B0B9AC5@meta.com>
 <202310121311.4B9DD96E51@keescook>
In-Reply-To: <202310121311.4B9DD96E51@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|SA0PR15MB3982:EE_
x-ms-office365-filtering-correlation-id: 2a659a25-3d0f-4fa3-dc1b-08dbcb6125f9
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 t/45SMdZ0l6AKuwk93Ahwcukrk3FEHUjMX/A9LL+mpIqBLkm+HXPK7ayvKo1znayM7iRN3swiioTx4Xx1vrG0vQnJuuWBLkAX2AUemcRs2/YPVeUrlHrdpEWZCC5tOJPbjalczkxkA+0WzvDRrKDGjQWfC1cY/D7r6XJmTZsyqm4iqsU8R8Y4YXH3HTapuntKYFVbnu2RSY1Cah1dMifN+c05gd/Js9eladYbL8pV4hG9wq2sqLZ0n88DOncl9Ht23qxe7xIP4ADSQHM5bAi77+QGLmUHTHowBiqT/tjnWR65NDMDPLvD/4iqHsFfCPSG4/0MiQ57h8bOJ79NyO5is+Y/6D1mr4Dw6bArAS4LKieelJ4YGUbj0xmJdjntjIrWi1ETHzcC1Ozes3ngwmw3GOtoV0ZwQC5FDZn6+Yy1n9NpBMl4IjhhZD3L9Mpd/R3Zds/Bqc/PkmlfHEz9WaXXEsUwBPixqjr9nIH4iAJzjYd9OLDGANO3OhHt9j2gwBPt84U/Gfs7H/Sce3JEItZCbERoFTM/wNsebwPBNx+JuVe64sCygbpikaDAB7lee7dVXWlbnIQ385slQq5dQ1yvBB3B0BYzxly5VLefOvzMjIRGtev7mS399moJCtK1MEMvz5L+WKhS/jn30OF+bGPKQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6506007)(53546011)(83380400001)(38100700002)(38070700005)(122000001)(6512007)(86362001)(7416002)(33656002)(2906002)(5660300002)(8936002)(966005)(4326008)(8676002)(6486002)(71200400001)(316002)(6916009)(66946007)(76116006)(66476007)(66556008)(91956017)(36756003)(64756008)(54906003)(41300700001)(66446008)(2616005)(478600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?REZEd3dKdktGNUgvYnRZUTl0elQybGZLT2ZDTXJUMkNsVnRiSmd1eW9hUVhz?=
 =?utf-8?B?MWxHR2J1Z1dwSmxyb2ZwMkZ1aWN5SHFWUWFsYzh2dVRLcHZTRjlzOFMxU2oz?=
 =?utf-8?B?T3pLZ0owYnAzWHRKSUVubUo2NGtOdWs3MDlMUDFhbUtiM0dMVitwMHBWdnBY?=
 =?utf-8?B?N2cvWThOMzVqaWw0TElSVitaaXN6RWZkemxSZFUrZFErcStFM244R2tIR1B5?=
 =?utf-8?B?YjNsQ0NEeXFrVjZjdlhPcUJXekM3UUdFaWhWWkZIRVAxZjE4S2F1U2w0dzlF?=
 =?utf-8?B?d1NuenFXUGQ4NjAyaVJKWUNFZk0yMU9jYmlZVUNGMmxCU3l3ci9sYkljcEFG?=
 =?utf-8?B?T1gwQndwNlowdlhVQ0FxTHRKSk1ZNkFlbk1mdWY4TGMxckZPNUc1YXFMRWVi?=
 =?utf-8?B?OEZvOGs4aG9KakJZdk9aVHJUR0pHaG1ycVNxL1dFVkhZelpDS3BzTlNVcUxj?=
 =?utf-8?B?OExDUDM0VE4vZlY1amhmUGVINHBlV1FaYzRiN2o1MUZkSG1VZUQ3cy91WUgr?=
 =?utf-8?B?azdQRSsrM1ZDN1RaVERreUcxREFkR25oKzVhYlZUdVBJMXVIQjczdUZnNnFR?=
 =?utf-8?B?QmtCTi9Bcm10cm5KbWZGVDZtU3FUdmZMc3ZmTjR0bUFXZGQ3d1AvTVVsdmhM?=
 =?utf-8?B?WXdEbHNxRjlKVE5CaFJQc3JRMHE2MGJNRGVaK1ZHeDdWeUY0K0JScXczTkRH?=
 =?utf-8?B?dGErMStFMTZINVVhSkRSYkxZZnhSVkFUS28zK2thckdYaDZ0Y2lXYm5RTm9S?=
 =?utf-8?B?SUIrUHhrcHNXZUpLL2lBUk5XUXhPYkVJUFF3WGg0Yzl6d2FaSW1PbUV3SnFF?=
 =?utf-8?B?dGg3NTh4RWVrU3I4Y2laMlZIc0dRR0JXb1UzMFJHTnBmbnF1bnd6ejlqenZF?=
 =?utf-8?B?eXNBRWtMN243SWhtV0FYTXM1YlBnVVNycXh1Mzk0VlNYUUlPYnJnZ01NVHdG?=
 =?utf-8?B?TVZBbHNDMzErRWJEUDZCdWZJOGZ0ZWJtT2RaZTkzc3I5WUY0cm52eFQyczhz?=
 =?utf-8?B?T0g5L1prUEhhakZ4cHFUY2JENU41cDh1THJrbXFvbEVQb01CK2d5RGNiUjkv?=
 =?utf-8?B?UkVFUVJma2ZjNWM1NHhkMml5ejZaSUc2RTUwMlZhTEQ3TEFtU0JRb0FUSEJo?=
 =?utf-8?B?ekV1cGs5YlhSdDFlcXFwVTk0clNEQUQ0bDdNNVB2WWp3bENoSldHUzFhTVA3?=
 =?utf-8?B?c25JSkZpelFNM3FkY1l0M1U3L01Wa1QrVEdDTDMvbmdnNnhrRFNETTBSdlBi?=
 =?utf-8?B?bGoxc0xMWWNSMkp2L25ab2k4K3dYZGRmYndnT2tHZVlCKzFEdnlqajdaVTRX?=
 =?utf-8?B?ZGZHMzMyL1BoVE9DNk5BRGJWWXZkd1NaTGRpdjlXMm5LTzgzM0YrRGxjbXF5?=
 =?utf-8?B?U0FSaEcvVDVDK3ppa2RpdzVuRFd6QXNNRVNYcjE0RmJQQ0RtdUJLUXRuTkFk?=
 =?utf-8?B?cnZwQXQxY0VTS1l2YllMRzlXZThFWFk4VlBCUkxKZWY4YWZod1pyVmlUR2cw?=
 =?utf-8?B?Z2VkZnNQUklvQkE1ZkJIV0FIK3BhbDVnNVEyNVZmSUt6RDVaU2ZUQlE4NHlV?=
 =?utf-8?B?cXdwVy9XczdqVG4rMWgxR1NkdjFBQnl2d1dSK1NRYWNXZ3I4dkJlUFUzQ1hR?=
 =?utf-8?B?cGFOSlpnSVNGWUZlNWlsUjhBVVFQdVQ4UVZnQi9jaXNpM2EvbjJZS2NlWG1D?=
 =?utf-8?B?c0hNNTc0VGRwd3psV0lqL2NHOGYzWVRwSndGbEo2NzBjNExpb2NXdEJrSjhi?=
 =?utf-8?B?cllqZHVzRG92QVZkbTVGNWYwRjlHa3VzaUhuTld5Z1I5SXdsM012d2tMY1BS?=
 =?utf-8?B?YjVOUHBQTUxqUlVjSVp2c05kclhrZlE0aTdnUXptL0k5SGZTN21IMTR1U253?=
 =?utf-8?B?OGkrdThkQmZiVUY1RHdmZERrYjRZQTVicFFqcTZuR2VqNXBnNmkrOTB5NkI3?=
 =?utf-8?B?cnV6eUZvUGpEdXM0Z1BjL3h3dElueFFOWnhyenRWU1V6TjkzOFIyR0hFa0JH?=
 =?utf-8?B?REVIZytFVlA1a3J0aWd1L2hGQXVJSExDbmlFR0tDNDB0dS9RaDNlZnoyTmdF?=
 =?utf-8?B?TzFWMW1RZnZXZ1hycThIcjA5OVZBMWo1NHptOXRiaFFSS0UwUitkd1VvbDNU?=
 =?utf-8?B?ck1ZZWVOY2czTE1IV2hkWjFDa01SQWVFeEVrRCs1c291a1JYcWlNSER2VExo?=
 =?utf-8?Q?FS1azLeeYUYJnky5CJnBOlA=3D?=
Content-ID: <CD2A50B0070B2A4D85AADD15DB652571@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a659a25-3d0f-4fa3-dc1b-08dbcb6125f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 20:23:51.1835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPcUArgS0dolpQkmiQ734TJlIMyXZN983d1QILVOm9oKCIIYQMCW8Fi1bN8W8gprBbaydV6pIDjz4QeQn4O77w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3982
X-Proofpoint-GUID: i428Sl-G7adq8z4XnjpLG_-6kF3Q7fP8
X-Proofpoint-ORIG-GUID: i428Sl-G7adq8z4XnjpLG_-6kF3Q7fP8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_12,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDEyLCAyMDIzLCBhdCA0OjEzIFBNLCBLZWVzIENvb2sgPGtlZXNjb29rQGNo
cm9taXVtLm9yZz4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIFRoaXMgTWVzc2FnZSBJ
cyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcg0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBPbiBU
aHUsIE9jdCAxMiwgMjAyMyBhdCAwNzo1NTo1NVBNICswMDAwLCBOaWNrIFRlcnJlbGwgd3JvdGU6
DQo+PiANCj4+PiBPbiBPY3QgOSwgMjAyMywgYXQgMToyOSBQTSwgS2VlcyBDb29rIDxrZWVzY29v
a0BjaHJvbWl1bS5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPj4+IFRoaXMg
TWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcg0KPj4+IA0KPj4+IHwtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
IQ0KPj4+IA0KPj4+IE9uIFNhdCwgT2N0IDA3LCAyMDIzIGF0IDAyOjA1OjU2UE0gLTA3MDAsIEVy
aWMgQmlnZ2VycyB3cm90ZToNCj4+Pj4gSGkgTmljaywNCj4+Pj4gDQo+Pj4+IE9uIFdlZCwgQXVn
IDMwLCAyMDIzIGF0IDEyOjQ5OjUzQU0gLTA3MDAsIHN5emJvdCB3cm90ZToNCj4+Pj4+IFVCU0FO
OiBhcnJheS1pbmRleC1vdXQtb2YtYm91bmRzIGluIGxpYi96c3RkL2NvbW1vbi9mc2VfZGVjb21w
cmVzcy5jOjM0NTozMA0KPj4+Pj4gaW5kZXggMzMgaXMgb3V0IG9mIHJhbmdlIGZvciB0eXBlICdG
U0VfRFRhYmxlWzFdJyAoYWthICd1bnNpZ25lZCBpbnRbMV0nKQ0KPj4+PiANCj4+Pj4gWnN0YW5k
YXJkIG5lZWRzIHRvIGJlIGNvbnZlcnRlZCB0byB1c2UgQzk5IGZsZXgtYXJyYXlzIGluc3RlYWQg
b2YgbGVuZ3RoLTENCj4+Pj4gYXJyYXlzLiAgaHR0cHM6Ly9naXRodWIuY29tL2ZhY2Vib29rL3pz
dGQvcHVsbC8zNzg1IHdvdWxkIGZpeCB0aGlzIGluIHVwc3RyZWFtDQo+Pj4+IFpzdGFuZGFyZCwg
dGhvdWdoIGl0IGRvZXNuJ3Qgd29yayB3ZWxsIHdpdGggdGhlIGZhY3QgdGhhdCB1cHN0cmVhbSBa
c3RhbmRhcmQNCj4+Pj4gc3VwcG9ydHMgQzkwLiAgTm90IHN1cmUgaG93IHlvdSB3YW50IHRvIGhh
bmRsZSB0aGlzLg0KPj4+IA0KPj4+IEZvciB0aGUga2VybmVsLCB3ZSBqdXN0IG5lZWQ6DQo+Pj4g
DQo+Pj4gZGlmZiAtLWdpdCBhL2xpYi96c3RkL2NvbW1vbi9mc2VfZGVjb21wcmVzcy5jIGIvbGli
L3pzdGQvY29tbW9uL2ZzZV9kZWNvbXByZXNzLmMNCj4+PiBpbmRleCBhMGQwNjA5NWJlODMuLmIx
MWU4N2ZmZjI2MSAxMDA2NDQNCj4+PiAtLS0gYS9saWIvenN0ZC9jb21tb24vZnNlX2RlY29tcHJl
c3MuYw0KPj4+ICsrKyBiL2xpYi96c3RkL2NvbW1vbi9mc2VfZGVjb21wcmVzcy5jDQo+Pj4gQEAg
LTMxMiw3ICszMTIsNyBAQCBzaXplX3QgRlNFX2RlY29tcHJlc3Nfd2tzcCh2b2lkKiBkc3QsIHNp
emVfdCBkc3RDYXBhY2l0eSwgY29uc3Qgdm9pZCogY1NyYywgc2l6ZQ0KPj4+IA0KPj4+IHR5cGVk
ZWYgc3RydWN0IHsNCj4+PiAgICBzaG9ydCBuY291bnRbRlNFX01BWF9TWU1CT0xfVkFMVUUgKyAx
XTsNCj4+PiAtICAgIEZTRV9EVGFibGUgZHRhYmxlWzFdOyAvKiBEeW5hbWljYWxseSBzaXplZCAq
Lw0KPj4+ICsgICAgRlNFX0RUYWJsZSBkdGFibGVbXTsgLyogRHluYW1pY2FsbHkgc2l6ZWQgKi8N
Cj4+PiB9IEZTRV9EZWNvbXByZXNzV2tzcDsNCj4+IA0KPj4gVGhhbmtzIEVyaWMgYW5kIEtlZXMg
Zm9yIHRoZSByZXBvcnQgYW5kIHRoZSBmaXghIEkgYW0gd29ya2luZyBvbiBwdXR0aW5nIHRoaXMN
Cj4+IHBhdGNoIHVwIG5vdywganVzdCBuZWVkIHRvIHRlc3QgdGhlIGZpeCBteXNlbGYgdG8gZW5z
dXJlIEkgY2FuIHJlcHJvZHVjZSB0aGUNCj4+IGlzc3VlIGFuZCB0aGUgZml4Lg0KPj4gDQo+PiBJ
biB5b3VyIG9waW5pb24gZG9lcyB0aGlzIHdvcnRoIHRyeWluZyB0byBnZXQgdGhpcyBwYXRjaCBp
bnRvIHY2LjYsIG9yIHNob3VsZCBpdA0KPj4gd2FpdCBmb3IgdjYuNz8NCj4gDQo+IEZvciBhbGwg
dGhlc2UgZmxleCBhcnJheSBjb252ZXJzaW9ucyB3ZSdyZSBtb3N0bHkgb24gYSAic2xvdyBhbmQg
c3RlYWR5Ig0KPiByb3V0ZSwgc28gdGhlcmUncyBubyBydXNoIHJlYWxseS4gSSB0aGluayB3YWl0
aW5nIGZvciB2Ni43IGlzIGZpbmUuIElmDQo+IGFueW9uZSBlbmRzIHVwIHdhbnRpbmcgdG8gYmFj
a3BvcnQgaXQsIGl0IHNob3VsZCBiZSBwcmV0dHkgY2xlYW4NCj4gSSBpbWFnaW5lLg0KDQpTb3Vu
ZHMgZ29vZCwgdGhhbmtzIGZvciB0aGUgY29udGV4dCENCg0KSeKAmWxsIG1ha2Ugc3VyZSB0aGUg
Zml4IGdldHMgYmFja3BvcnRlZC4gRXJpYyBCaWdnZXJzIGFscmVhZHkgaGFzIGEgUFIgdXAhIFsw
XQ0KDQpbMF0gaHR0cHM6Ly9naXRodWIuY29tL2ZhY2Vib29rL3pzdGQvcHVsbC8zNzg1DQoNCj4g
VGhhbmtzIGZvciBnZXR0aW5nIGl0IGFsbCBsYW5kZWQhIDopDQo+IA0KPiAtS2Vlcw0KPiANCj4g
LS0gDQo+IEtlZXMgQ29vaw0KDQoNCg==

