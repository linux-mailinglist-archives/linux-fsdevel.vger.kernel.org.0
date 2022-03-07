Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A844CF138
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 06:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiCGFh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 00:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiCGFhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:37:25 -0500
Received: from mx04.melco.co.jp (mx04.melco.co.jp [192.218.140.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B5F5E774;
        Sun,  6 Mar 2022 21:36:31 -0800 (PST)
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx04.melco.co.jp (Postfix) with ESMTP id 4KBnJG1ytvzMw0BB;
        Mon,  7 Mar 2022 14:36:30 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 4KBnJG1Wv5zNBhHS;
        Mon,  7 Mar 2022 14:36:30 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr06.melco.co.jp (Postfix) with ESMTP id 4KBnJG1ChZzNBhHH;
        Mon,  7 Mar 2022 14:36:30 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 4KBnJG19p4z6thS;
        Mon,  7 Mar 2022 14:36:30 +0900 (JST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (unknown [104.47.23.170])
        by mf03.melco.co.jp (Postfix) with ESMTP id 4KBnJG10TFzMqf1C;
        Mon,  7 Mar 2022 14:36:30 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYjLle6Rxt/Tiz5VbiLqk5sjC9PVpHq5fIXUPnIuapimY0A+3eOyfD3+1sfZUj+C944NhvMAGyrp18SaS8g91KT61FnPOY5zJ8PudQKQtMN4zp1zoiYxYAhh/bBmpuqS3nYoWeWOtWF1AliN4yB1BpdWitbbXbH4XGNCaVhY/rr+ZEwGKb8/otBB4Cs8OAIDvkKY2XDRM8IUc6/2MsqpiRMm8VjV+LSOUF0sj/UAaoKLRNnSpfGD9+tpS/7zWMuhnYEM3Cuo7WQ7MDhQrBWIE6HoQtbBI/OBG9DpsQQO7p/Lpf0vCa7+w1FgnAmnM3m1ZwdIJyDFHPxPmCZdrsOHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z23WoYwekR1511MEaMAJ2B1ZdnXdEHDv3D6+9geENjc=;
 b=jkMgvcTXg/TEtUlqGyGMqHu573f75IsLjh1hoKc0lTjdyLeLOLR6TpNYavmlQFO8pn4WRLdZ89pvWp6r3FsghyIisJ2hIKHUNcaLr6BIFepECe6wxfXuLFVGJHHUkcpd7cwSvVe6vHW/Q3zlc2N7xnsZqa2oXlUaGRoKDfX9fy7Kp7M5OyUdto1tryVkp0eOrRYnv9ARezRMZj535VaY9aDT6OjZXjKUpiZ4QOgpxoR0h0YAZQgiZdhYrjNu+z2lCgEI8BoUoNayKb/lr5xtJvrJbqz6CFUns1V9CPkI5vz4EY4IpUrM4Uzsj1swqfYxAabYKXyQlcNdIYoI/AgHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z23WoYwekR1511MEaMAJ2B1ZdnXdEHDv3D6+9geENjc=;
 b=DhWUC78p8gsPr4Twtx9hrF//eTENxLRThVYTG+x8dBsSu4i3RN62Hj+Ga+Zwd0Ix2bRPaH3NZjTGtglCS8nCr0b+rI4ZgFRoDU0RJhZsf6NdZaXMzDjxg/WinBITCo5IodpPFCnCuTuL5zwc92tSXXeqqRdxABwzmMAPTq7JQRI=
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com (2603:1096:404:803d::8)
 by OS3PR01MB8444.jpnprd01.prod.outlook.com (2603:1096:604:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 05:36:28 +0000
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::cd6:cd27:1fe8:818]) by TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::cd6:cd27:1fe8:818%7]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 05:36:28 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Subject: RE: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Index: AQHYHKozeVmted1T5UKvjQCq+AaGCayoqY+AgAA/KGCAAw0zD4ABYXsAgAYuVrA=
Date:   Mon, 7 Mar 2022 05:34:17 +0000
Deferred-Delivery: Mon, 7 Mar 2022 05:36:00 +0000
Message-ID: <TYAPR01MB53536D7149FDB6A9ABBD8F5090089@TYAPR01MB5353.jpnprd01.prod.outlook.com>
References: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <TYAPR01MB5353E089F4843C6CE6A0BA1E90019@TYAPR01MB5353.jpnprd01.prod.outlook.com>
 <HK2PR04MB3891B4F1C2BC707582E81C0C81019@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <TYAPR01MB53531DB8B19324F7D60EE9AA90039@TYAPR01MB5353.jpnprd01.prod.outlook.com>
 <HK2PR04MB38913077A55A6E7124A41A4281049@HK2PR04MB3891.apcprd04.prod.outlook.com>
In-Reply-To: <HK2PR04MB38913077A55A6E7124A41A4281049@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dc.MitsubishiElectric.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 625c159d-edb3-4d91-4e0b-08d9fffc6db5
x-ms-traffictypediagnostic: OS3PR01MB8444:EE_
x-microsoft-antispam-prvs: <OS3PR01MB8444982CE41D10A5876EA6F290089@OS3PR01MB8444.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s0pFJYHNmauv5qNUi3tE4cgZxaEh71EFn2drm03EESGhdisVX1jePI+pISnectrlptmm4OvSEGQ8iwJbHCLtKY+9KFNR9+r+ZkLDKonnod0wouuxWJX0/EFaHzUFGaeYxvuHLQEi1+7kwO/6aXjUfyepT4FX8oVCY0MmHTjpZ4EZCXgZ8rz2Sh1d4ew8QPSbUm3GwjrffABptyfm6I7DRvHNmJu5c1yG2v9oia29EdA54f6XMyWsBbsRFwL1aRrmz2w8RoswhjRg9dejNq+5xEMnwGALdRiumANwn7wOJd6adTt915v6LZ+TJb1m0+57o9AYifbluYweD2cxD1HkJzTDq5w3H/eUKQv6QS9ZGlv2u+zwehJON0qXnYYnCZqK7mIPdkuXQCOzpAAVuDLuXqQ73SnDW+/EhlvrRebFJCrc9rBFr7JFQlFZuop6m2dplalp9j9nX9bx3pSY6+SiauOELJVePLhM4cAO214pFWGWmEKMlTNn+UCu3feovEVZ4Yn6OSMZOuwTbcpl3gEy4oaY10nMKW+1l9JAtz3Pz7YkaLZ4hFYndVZT1dRZwVzvEwY3MbLnKocaRxTpdOsJsMpByG5t5Sysvj8R8kpjwrnDN+G5Uu6vX3VUoaFKfHpgYvenzrdBtAA6hAOApt2xoQIIzHXGwVJNZ1vmLsssJtGBnRz3VEFFONQMl/sQWnANLHtCRGX7yI52zi0gxsWg8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5353.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(33656002)(71200400001)(52536014)(4326008)(186003)(26005)(38100700002)(508600001)(9686003)(7696005)(5660300002)(6666004)(6506007)(86362001)(2906002)(4744005)(8936002)(122000001)(66446008)(8676002)(64756008)(66476007)(54906003)(66556008)(83380400001)(76116006)(66946007)(55016003)(316002)(109986005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTZjTzBvcUxuMHlINi9TTW5sMUNmeS9kQmNTNW9uTE5sVVk4enJscWZ0cTNZ?=
 =?utf-8?B?MlBYN1FoYzAySE9RRzZTbHNtK1J3L1Z1Vjk4ckVYaS9Ld3o4WktlMlB2WWls?=
 =?utf-8?B?UFVIbmxReVdIK2tvblFBM3NSdGFhTTIxNGVtWk5nbEFEZjRHV1gyTTNDdkY3?=
 =?utf-8?B?NVdEeHgxWVBYYVJFU1Z4Y1hJcHJsNmREWjdUL2NYYm1mVG1LVzhWdldYNVE1?=
 =?utf-8?B?UjdHRjdRZThhY0EvN05mWld5Q3dDNHgyaWZxa2xITUlQK3p0aUhzTThGdlQy?=
 =?utf-8?B?V0R1ZTBYOEl2WDB3ZWdCRk1IRUUyVTFpYWN5TGNkVU1NLzJHZzByVkRzVmtP?=
 =?utf-8?B?WE5EazYyK1NGZmpQWm5yM2ljSXh6c0twbFRlSkY4NmRnWTBTbEtYKzJRdzJX?=
 =?utf-8?B?L0I5U2NLcDR6dngvaDF4K3NVRXA2YTdKcDlNYU9OZTM4UStUdmtDc1g5VENH?=
 =?utf-8?B?MjdXMmtZSEtQa0R4cWRTSDlFbUZNeVF5WWZOcWgzaytBUDZjOGxLZFFaTGZk?=
 =?utf-8?B?ZDVVVXdPV1hmWEFCbXpiQnhGTlhQQ1J2U3lUcWVtWnd5MUJwbW9ZbFYwV1pP?=
 =?utf-8?B?VTVvOUxUUXIvZ3JnKyswbmlZYTFZTW1oR1dqcEV2bU9QN3VFanFZdmNWTlNz?=
 =?utf-8?B?cmh0VmJJUUMvNTZMS2Z5aDMwKzV3VGtXL3Fqc1NqODVEVFE0bWlvSVBUK21j?=
 =?utf-8?B?ODVpdkFKV2hoUVg2RzFzQkVOKzFaeHJrdHpyYnkraC9YUjB2NmVCOVo3Ukt4?=
 =?utf-8?B?dWhGSWVyNXpoV2tHYzZEK0g2NG5pRnNPUmVpbDVtNzJReFVUZXJ4U1BNZjRl?=
 =?utf-8?B?U3QwSlVmODBsNjFYcWVkYjZSUXNWYVZsRnZ6YXdUcmNJbjhyL01MeW5rMWdo?=
 =?utf-8?B?WUlGOGdPS3lwSGJvdm1UK2xBNmJFc0JHckpqRVdUN0JicnlQVXFuaWw0aXNO?=
 =?utf-8?B?OVpHbDZGZVJ5NVl0eXFRcjBHamVOS2lIMnB2YzJGdzhEWmhCQlFVWW9CZmRl?=
 =?utf-8?B?SzlqMDlJV2tmeXdnTmZWK0VtbC9iQmdDc08vbEplUU9mRnh0UzhLb2VKam9E?=
 =?utf-8?B?YVpDZmZYZkNTTDVYWktWV3ZGamN3Umw3NUJxRFc3TGZrL1dpYjVRaW5zVGJZ?=
 =?utf-8?B?RzBKZzJhY2NiTEc2QUdzdkZETFFOZ1c5RGJoNTY2S1Q2am1jMW41ZnMzc2M4?=
 =?utf-8?B?Z3UrOEYwbGE0WEw5U29MdmpvSFNpeU0xRjcxMHlab0JqTlhFa3Vac3llQ3Rj?=
 =?utf-8?B?MUtheDFmd3pIZElmeXJMWnFhWG5ONmhXUVZBaWVMMUN6QnpjTDNleU11TnVG?=
 =?utf-8?B?Z2lVWEFESTl6QzV2ZVQybVRCQnJoNkhqaWlNUzBjWGNILzdrUnN2UkhsekxB?=
 =?utf-8?B?RmpWUHRWSE5OcXl2VUhqUGhGanNzdTV3T2JPSGY2bGt6WGE2UnBiSGs1aDB3?=
 =?utf-8?B?ZTNKUnJHaHJwQUVRVjdxQ25NaUE0R1E3eElnalM2cHUybzh1MGd6Yk4wUEtv?=
 =?utf-8?B?anY1NmFBWXhNNjV0a1V3RFR6SG5xYTJYTVg5VHZLWm1pdUIySXFub2pHUnFR?=
 =?utf-8?B?ZkRtT0FCSHN4Z2hHZENacmcvRklPWllFUGg4VEg2azRtM3F1ME5rZFJFdTJH?=
 =?utf-8?B?Y1J4cnZDaWtqZlBTYVZlN2ZjZlk3TkpPY2UrQjNiUUdnQ2wxb3ZjMkFoRUVN?=
 =?utf-8?B?VHpCWkx2VkJRYjhhM241S3NSM2lHV2pQc2dicFIxUXhQQzZkV20wTVErVXNr?=
 =?utf-8?B?SEw3aEF2TkIrUHNEaEkzWFBlYVE5bCtXVEpTMjY2ODNoV05IbytHNUZ1RGtv?=
 =?utf-8?B?QSs0REF2c3ZWSHVLdGllMTRaWlNPWlZMakZJK1dxMUxnMzYrUnNjVm1FcGJB?=
 =?utf-8?B?VG9HV1RxcFprT2l1ejBWZ2M1MUJGc1lkZlFCN2t3aGl0R2FJRTdWcE9aelBl?=
 =?utf-8?B?RDljWS91eTFabER5ZTRrenZxTElaQ202Tmlrak4ySFNpSlFNN0l0ZVFGUHAz?=
 =?utf-8?B?RUNQRGZJT3lRUjh2TDFTRlIxL3pNOW9SSTZyRFB4VE9rZE5nWXh6WWRPUjRL?=
 =?utf-8?B?WlU0TVFqekV1K29Qa0taa3c3dEJ5KzNsZFNZQTJvbURsZ1Vjc05rV3JrSG1F?=
 =?utf-8?B?K3ZoeFBFMGlwNTdqUmkrd25TSCtQWTJabWZPdVUyZGJmOFhGT0R6dkF0L3Bu?=
 =?utf-8?Q?EG7SHm90TTnpjEVGH3Rgfbg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5353.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625c159d-edb3-4d91-4e0b-08d9fffc6db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 05:36:28.5982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6xXUlk6NDLP/HcfJtYbixC33tpSVirzteAF2/5w5pn3iMd9pcdqdBE0BM3A4NtpmJs6GWMObZNuS8UuGnX4auw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8444
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksIFl1ZXpoYW5nLE1vDQoNCj4gPiA+KFBTOiBUaGUgb3JpZ2luYWwgbG9naWMgaXMgdG8gY2xl
YXIgVm9sdW1lRGlydHkgYWZ0ZXIgQml0TWFwLCBGQVQgYW5kIGRpcmVjdG9yeQ0KPiA+IGVudHJp
ZXMgYXJlIHVwZGF0ZWQuKQ0KPiA+DQo+ID4gSG93ZXZlciwgdGhlIHdyaXRpbmcgb3JkZXIgd2Fz
IG5vdCBndWFyYW50ZWVkLg0KPiA+IE1vcmUgc3luY2hyb25vdXMgd3JpdGVzIGFyZSBuZWVkZWQg
dG8gZ3VhcmFudGVlIHRoZSB3cml0ZSBvcmRlci4NCj4gDQo+IElmICJkaXJzeW5jIiBvciAic3lu
YyIgaXMgZW5hYmxlZCwgQml0TWFwLCBGQVQgYW5kIGRpcmVjdG9yeSBlbnRyaWVzIGFyZSBndWFy
YW50ZWVkIHRvIGJlIHdyaXR0ZW4gaW4gb3JkZXIuDQo+IFRoaXMgaXMgdGhlIHJlYXNvbiB0byBr
ZWVwIGNsZWFyaW5nIFZvbHVtZURpcnR5Lg0KDQpTQl9ESVJTWU5DIHJlcXVlc3RzIHN5bmNocm9u
aXphdGlvbiBvZiB0aGUgaW5vZGUgb2YgdGhlIGN1cnJlbnQgZmlsZS9kaXIuDQpUaGUgZXhmYXQg
aW1wbGVtZW50YXRpb24gdXBkYXRlcyBhbmQgc3luY3MgdGhlIGRpci1lbnRyaWVzIG9mIHRoZSBj
dXJyZW50IGZpbGUvZGlyLg0KSWYgb25seSBTQl9ESVJTWU5DIGlzIHNldCBhbmQgU0JfU1lOQyBp
cyBub3Qgc2V0LCBpdCBjYW5ub3QgYmUgZ3VhcmFudGVlZCB0aGF0IEZBVC9taXJyb3JGQVQgaXMg
c3luY2hyb25pemVkLg0KDQpCUg0KVCAuS29oYWRhDQo=
