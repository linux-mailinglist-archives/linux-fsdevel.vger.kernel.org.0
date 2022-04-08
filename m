Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB7D4F8C9B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 05:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiDHDEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 23:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiDHDEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:04:43 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DF7B647A;
        Thu,  7 Apr 2022 20:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649386958; x=1680922958;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UL1+y9v3Yi3PbDJMytkTW6on4NutbesXwF37L/o9NBY=;
  b=EvHqRs0/L0P19Q2joMtsKmv4dm+q7SS6gtWZ4SYX96DbPu0WQWv2FD9U
   vuqfhE78T+8URM+D4SgfEGboFcfiXnIvVylTml9K0/ZpLH1v2TrqSPXdm
   WNFovxYgxhXeShNrqPCkDdSMXQpf8oD4s0bqIqZ9Lwxi6vzU6KMtFT4PC
   A+utdsPM2CZT2Z2nCskBOxVRu2H5Lulh52r1ZZzDDfIrySBCVBPB5mH0b
   fEvX6txKoaz6PE6HiQsgWrttuoOhj5quTimXWEm4I6UuHB4iL2o4yR+9d
   F27C4aEZ8hSkll4JvRLsXWiLSbgH7QNaDuc2GElR6qWcpAcIalCQLMjgL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="53180382"
X-IronPort-AV: E=Sophos;i="5.90,243,1643641200"; 
   d="scan'208";a="53180382"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:02:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsIRHXodXDBmpBLFcboBAwn0x/AUZHTCm4hOYpiZz3tK5ZXpINlmQOh/KwoT1POPdSfpm3h2t966nKsnfB34eR59Iav6W640K6SQBJgBuv4+zOgaW3O1jE66dSlpC9/+lAkbocO29o5x5ZZVfD/Ad2VQ3BsU1j10kRl9LIY9fJlfPXS6qYH28ucpMBJPBDEMpUlYnx5v0nYljRqZRH8gCFglCqGtXuC0ZwXR7m9pvlYhU9eLZqHk0h03jgMqRIxNaMUHpdaFQEs/ijbw8HBVoRJISLpL+slR+Cu0YWYocCSajATMdNo/Kj7jHAULiea5nXqAXZbiNI62aXSggKtUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL1+y9v3Yi3PbDJMytkTW6on4NutbesXwF37L/o9NBY=;
 b=F4s7amTL/boDARd2Oxw//xmZ4w+CdVNf933EuOcbWpUp0AiegnCqbsKwJLOCNf71ph9Lq/QNzht8cQo19rV/wvpm0CMlM7B+dHIYzjrZpUzYhuHidcc8PoL+NMuE0v8JCVdw2NafzuFe1OK/MvjPfCC+LQf5V0DIgEAUQyM/8TnAMf0Co8rgud34zyvEG7IpkTyBkzRHGj3soRF+w48NirpeAznQxUoEXg0ikXo2Akum/gQklpRhjUw73x6WvTbVg56sYvx/Fe6xJVX6qTFTdNrRC6kUq6xb8jbZg2o5jzd81K2FCRQbC//YIeMctiITP7PTM0D8IVY42075JCogXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL1+y9v3Yi3PbDJMytkTW6on4NutbesXwF37L/o9NBY=;
 b=lEMyAUHHOErzSUKto00/pL55MKXVLHiZ/kA1ktHOXSEttMsFBHPlhaxL+94TiCZ88MoLEK33Vtyo+GRWyEpQAvqAuoEq4ugEKmt/Ql+cIrxtxn1WnHWxjFx59mAb0RM3mz3afA4xFhvFeCAnygpjmrtx87rWGAbNK1y7DGhWngQ=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB5179.jpnprd01.prod.outlook.com (2603:1096:404:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 03:02:30 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 03:02:30 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] idmapped-mounts: Add mknodat operation in setgid
 test
Thread-Topic: [PATCH v2 2/6] idmapped-mounts: Add mknodat operation in setgid
 test
Thread-Index: AQHYSm/7meadmMO/3EG0PfvNWomTLazkdR+AgADxJgA=
Date:   Fri, 8 Apr 2022 03:02:30 +0000
Message-ID: <624FB404.5020503@fujitsu.com>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649333375-2599-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220407134009.s4shhomfxjz5cf5r@wittgenstein>
In-Reply-To: <20220407134009.s4shhomfxjz5cf5r@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a091d1bc-af10-4f5a-f0b2-08da190c385b
x-ms-traffictypediagnostic: TY2PR01MB5179:EE_
x-microsoft-antispam-prvs: <TY2PR01MB517920DF00FDB4A1F6B9488FFDE99@TY2PR01MB5179.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T2tSqdo0yzrIRHAFiRAhrZgVSFdbZ6BP+TDt92N2v06TzsdAf8hJNxRtFlShbnwOupuG5dnxWGm4smDkGCJ8d2TZhxwVA18zcHHNvuzJr4muZWKjUz5Qdkk2N4qHL+9eRKj8CY+Co5ibHpjVlw7LKUGpDJvm1CmwMalIci5AEAKTDFDQCfXIo+e51eixGANhkXmQZO+wOb156dvuVB2Qs94pSUQMpU4mrApyUkr7F+8EtjOXtrKvEoB/ENUugVlf/dCWAbn3/KHgimue6CIGGj09IlCxbaeJQ5rBhUyHVn/ucHtV4lhJqy0JHnWeFnCLNYbnzNV8e1uFcBNe1CbRoV9J8HelWHKz2IpRV+/15wllLF5z2mz/egoyAPew52hdZzWM0iJJ5bq78OracDLUqONZ/2RBMLtuP+uiXnvz4KtOcgegtMAVw1jMxd1yWPpPpFaiK4KMLa3bBLASCnL2zkgQsCC4QbwVyFwf/l6OqQunABp7xVJJgxdIStVIQoQ3SYLTIK6yYpkQIhsNQTDukEAPm3PyA/GQkdzkfSXWt4W/dM4a479GHjViWZE6lMWZ4Qnd/ewlvea2N7pZYZJ02cCOyuaapo4sIimVBEH6TMPmNPhsd8MOYbkIMdPaY9CJ4S9NgFTMdnMGiOZfRxeKZ+q5aCEbYlot4RbRcJlFbV3M7/Q22l8Arm0Ha1ePDQQiH6RkMnNYVO1pF5Oj+fB2tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(8936002)(38100700002)(54906003)(6916009)(71200400001)(82960400001)(85182001)(186003)(36756003)(6512007)(38070700005)(2906002)(2616005)(33656002)(66446008)(66946007)(76116006)(66556008)(45080400002)(87266011)(122000001)(91956017)(66476007)(64756008)(8676002)(6506007)(4326008)(26005)(5660300002)(6486002)(86362001)(83380400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVdCUjlNM1RCR2d1eFZyc2VBaW5NSEE2dDdIUVVWc2VJZ05VYjRSaHpQa1dD?=
 =?utf-8?B?K0hjOCtGaEMxNk9MaDNaeGxmL1NFelpaYk4zTEc2dndNYy83Rk9OQ2RBc0Z0?=
 =?utf-8?B?d05qRmJic2Z3QktOaWhBSW8wYTJqakYvZ2g0em83cUdvQ3RyNm1OQktRaldS?=
 =?utf-8?B?V2FSaUhCamt1eGY3YmJMbHA4ZHhMd0ZxRmRXWG85WFNOWjl2Nk44eFA0YWVO?=
 =?utf-8?B?UHNNTFJWMkdweFdDNktiRDRXbU00MElPUmJ3NU05YktFMDc2Zzh5VG5kWkRM?=
 =?utf-8?B?OFg3TmJyMXV5RkRiOEcxOXhqd3RFMUh6Vjl6ZUZQNzkrbWovOHI1cGNUWUtP?=
 =?utf-8?B?UmVQQk0rV1ZxTHUveElwdkczMHYxdGJ4L3VjUTBJSWtsK0EwZ3kzR212MkE4?=
 =?utf-8?B?YkZQRC9rMGxTUXVwM0dveDJobng2ZzVTY1NKWHRMRG15VXl1c2REbkFGVnBu?=
 =?utf-8?B?ZlcwelBxc29kVHNBRVJRZ0MySERPcjNIZnB2UHkvZndEQjB2RmFYMlUwR1FD?=
 =?utf-8?B?SFQwNVBhY3ZyeVVmdFNSNGRJdE1jNjk2QjJTR3VUenVLbVd1WFlTTnZQR2hC?=
 =?utf-8?B?dGJNb1h3QSt2a256QzJBRWN2Y0NWQzg2Z2VjS0F2YU1ndUM5dm5pVm9Cbk9N?=
 =?utf-8?B?UUpDTFBkeDlRZVdtZ1ExUnVWV29KUlBhcmlWV3NCZUNYSVpLaWVvSGw0bWZC?=
 =?utf-8?B?VGZxeGkxOFBrb2wvR0dvWERhb1NLSkd3Nkkra1ZLK2NWZGpySVZhK1Z0Y2I0?=
 =?utf-8?B?ODg1RGlNUFVxZHFyYy9lbGhsN1k2NHJvSEFxZXd4Z2tNMUNZcjI2ZURRUzBR?=
 =?utf-8?B?MHQ2a1NMOWZqbHpvVTQ4T0FNY3hRZHg5NWM1dlBlSTZKWGN2bkNxdDNianZC?=
 =?utf-8?B?SEhhMHh4RUpDQlVRTUtIdXpRS3RpaVl0cWY4RTJiTk9WZU1sckdLZDNtS0Nl?=
 =?utf-8?B?VFdjam5rVi9TUER0UEo2UGJqRDBBYnhwL0RpdkN1NVhmSmtQN2lZV1FPeWov?=
 =?utf-8?B?UjVYT2poR2RPdTBkcG1pTGRoWmtNeFhZMklId0p2akVaRldZZVgrRFJqeE5F?=
 =?utf-8?B?NlIwVTFPVTVQdVlYR1ZjRXM4MkRwSVl1OUwzSlplYkwrQnBEeTM1M2dSb0FK?=
 =?utf-8?B?SStrMEpUbVl1TXVSWThaRzZmYitKa3o2QkdDeHhiMmh5eG5RamRlMi9TTm45?=
 =?utf-8?B?MURqWGVzYXIveisyaUtHM1ppV0RoOGx2MjhidHBwSzJXMDhoMHlhcVRXcjFU?=
 =?utf-8?B?em9oUTg0ZnRXY1RnQ2VDcWJJWE1JQU1uaG1rMXAvNWZUMkZYUHJtRWVqc040?=
 =?utf-8?B?RjFpWEZhTmdscUNLRVcvR2lzR0d4TkFaSGg3TUpNRGxDeWV1ZC8yclZybGgz?=
 =?utf-8?B?ZVlxcG16bVlKbk1iamFqVkpTbXlOL1lhdVdBZjBGM2ZnMldEOENtODREcjVm?=
 =?utf-8?B?ai9HTHVIRWRTYnE3UnZINFlWSnJMekJNR1UzSXZTZjhXZndqUTBNcVpONDhF?=
 =?utf-8?B?YlYvdzA2YzBZL3IyMEJtUFc3TitWMUV0REY0VzdWa2phWEdLYTNCNEpRZWRH?=
 =?utf-8?B?S21QcjIxT1BsRk5HblZFb0JLQzdCZzRncTBpaWVlL05nVksrTTFXVnAvZ09E?=
 =?utf-8?B?MkxGcmtUQUtFdVUxOG4rZnpSRmY2TWpKRWUwcTdrK0RaOFBhb0Y0UTNQZDk0?=
 =?utf-8?B?WjNMbTBBc1pxRmNQWWdZVUpUYldReE13OFA3K2VIdUNwM2VKUlN1U3NJejNs?=
 =?utf-8?B?OGFnUlFiRGJ1d2FZcEg1WHJCZWNMZkgvQ2Q4Slh2QXk3eVltdmVEUjZPTkMz?=
 =?utf-8?B?cVlKU3kvckRNWnR1MVFuZDQvK2Z1NTU4NzZyWklXbVVDT3NFL2M2V2RweHFP?=
 =?utf-8?B?S3ZqV1NwekdrcG93NE1MSXUxc1FLL2UrUWF3N0F1aXJ5c1djZjVJMVliWnJT?=
 =?utf-8?B?THVNN0xnWHM3SWZmdzRCUlByRXdvZTNyT256WFdtb21tU0hlZmFkNUw2OTQ5?=
 =?utf-8?B?YVpPVjBIWnRYTUx1d2dBcERaZnJDNG9kQkdoRnlVY3JGYXlaWGN0SXlHNjlZ?=
 =?utf-8?B?RWNtaDVnazJGaVJpTERmTWQ5YkV0ZTdINHltTis5blVGeWJTaDlpZnRSNWdi?=
 =?utf-8?B?TFVoN3hya1RsNDNCK3dTWEtybmVHNWpzK1ptaTFyNXM4dXBOSEpOUVhsOWJ0?=
 =?utf-8?B?K2pYRnZ4My83U2JXYVErQ044dlE2ckt2NUFTOVJMYXJFeWNmMUhLRUVCekVs?=
 =?utf-8?B?YTRLR1U3eGx4M1Q0ektGTFM4ZGo1ZVdZWFpuN2ptci91RWxtakJZb0w3c1c1?=
 =?utf-8?B?TE5OTnRKajhqMG1yd1FiZDlTTm9HUVhsV1hlZS8yK1hwNTMyS2FDY3BDcUlj?=
 =?utf-8?Q?sImzgZlynV+Q42yOpugoeQ7Zto+koTq7dVuyb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7258C25997684D4BA1D2FA23C8F903A8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a091d1bc-af10-4f5a-f0b2-08da190c385b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 03:02:30.1572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDgXYVdO6BscXi3hdfddMbNDRi/2YlA9QspjOjjVrNsPUf2YLLItvyrr/FrVwI9mnJ3w2ORQ8Z83yngVrSJjT3cqM2pt4XGq8VaFuEK/YgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5179
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzcgMjE6NDAsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPiBPbiBUaHUsIEFw
ciAwNywgMjAyMiBhdCAwODowOTozMVBNICswODAwLCBZYW5nIFh1IHdyb3RlOg0KPj4gU2luY2Ug
bWtub2RhdCBjYW4gY3JlYXRlIGZpbGUsIHdlIHNob3VsZCBhbHNvIGNoZWNrIHdoZXRoZXIgc3Ry
aXAgU19JU0dJRC4NCj4+IEFsc28gYWRkIG5ldyBoZWxwZXIgY2Fwc19kb3duX2ZzZXRpZCB0byBk
cm9wIENBUF9GU0VUSUQgYmVjYXVzZSBzdHJpcCBTX0lTR0lEDQo+PiBkZXBvbmQgb24gdGhpcyBj
YXAgYW5kIGtlZXAgb3RoZXIgY2FwKGllIENBUF9NS05PRCkgYmVjYXVzZSBjcmVhdGUgY2hhcmFj
dGVyDQo+PiBkZXZpY2UgbmVlZHMgaXQgd2hlbiB1c2luZyBta25vZC4NCj4+DQo+PiBPbmx5IHRl
c3QgbWtub2RhdCB3aXRoIGNoYXJhY3RlciBkZXZpY2UgaW4gc2V0Z2lkX2NyZWF0ZSBmdW5jdGlv
biBiZWNhdXNlIHRoZSBhbm90aGVyDQo+PiB0d28gZnVuY3Rpb25zIHRlc3QgbWtub2RhdCB3aXRo
IHdoaXRlb3V0IGRldmljZS4NCj4+DQo+PiBTaW5jZSBrZXJuZWwgY29tbWl0IGEzYzc1MWE1MCAo
InZmczogYWxsb3cgdW5wcml2aWxlZ2VkIHdoaXRlb3V0IGNyZWF0aW9uIikgaW4NCj4+IHY1Ljgt
cmMxLCB3ZSBjYW4gY3JlYXRlIHdoaXRlb3V0IGRldmljZSBpbiB1c2VybnMgdGVzdC4gU2luY2Ug
a2VybmVsIDUuMTIsIG1vdW50X3NldGF0dHINCj4+IGFuZCBNT1VOVF9BVFRSX0lETUFQIHdhcyBz
dXBwb3J0ZWQsIHdlIGRvbid0IG5lZWQgdG8gZGV0ZWN0IGtlcm5lbCB3aGV0aGVyIGFsbG93DQo+
PiB1bnByaXZpbGVnZWQgd2hpdGVvdXQgY3JlYXRpb24uIFVzaW5nIGZzX2FsbG93X2lkbWFwIGFz
IGEgcHJveHkgaXMgc2FmZS4NCj4+DQo+PiBUZXN0ZWQtYnk6IENocmlzdGlhbiBCcmF1bmVyIChN
aWNyb3NvZnQpPGJyYXVuZXJAa2VybmVsLm9yZz4NCj4+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
QnJhdW5lciAoTWljcm9zb2Z0KTxicmF1bmVyQGtlcm5lbC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBZYW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgc3JjL2lk
bWFwcGVkLW1vdW50cy9pZG1hcHBlZC1tb3VudHMuYyB8IDE5MCArKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTgzIGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3NyYy9pZG1hcHBlZC1tb3VudHMvaWRtYXBwZWQt
bW91bnRzLmMgYi9zcmMvaWRtYXBwZWQtbW91bnRzL2lkbWFwcGVkLW1vdW50cy5jDQo+PiBpbmRl
eCBkZmY2ODIwZi4uZThhODU2ZGUgMTAwNjQ0DQo+PiAtLS0gYS9zcmMvaWRtYXBwZWQtbW91bnRz
L2lkbWFwcGVkLW1vdW50cy5jDQo+PiArKysgYi9zcmMvaWRtYXBwZWQtbW91bnRzL2lkbWFwcGVk
LW1vdW50cy5jDQo+PiBAQCAtMjQxLDYgKzI0MSwzNCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgY2Fw
c19zdXBwb3J0ZWQodm9pZCkNCj4+ICAgCXJldHVybiByZXQ7DQo+PiAgIH0NCj4+DQo+PiArc3Rh
dGljIGludCBjYXBzX2Rvd25fZnNldGlkKHZvaWQpDQo+PiArew0KPj4gKwlib29sIGZyZXQgPSBm
YWxzZTsNCj4+ICsjaWZkZWYgSEFWRV9TWVNfQ0FQQUJJTElUWV9IDQo+PiArCWNhcF90IGNhcHMg
PSBOVUxMOw0KPj4gKwljYXBfdmFsdWVfdCBjYXAgPSBDQVBfRlNFVElEOw0KPj4gKwlpbnQgcmV0
ID0gLTE7DQo+PiArDQo+PiArCWNhcHMgPSBjYXBfZ2V0X3Byb2MoKTsNCj4+ICsJaWYgKCFjYXBz
KQ0KPj4gKwkJZ290byBvdXQ7DQo+PiArDQo+PiArCXJldCA9IGNhcF9zZXRfZmxhZyhjYXBzLCBD
QVBfRUZGRUNUSVZFLCAxLCZjYXAsIDApOw0KPj4gKwlpZiAocmV0KQ0KPj4gKwkJZ290byBvdXQ7
DQo+PiArDQo+PiArCXJldCA9IGNhcF9zZXRfcHJvYyhjYXBzKTsNCj4+ICsJaWYgKHJldCkNCj4+
ICsJCWdvdG8gb3V0Ow0KPj4gKw0KPj4gKwlmcmV0ID0gdHJ1ZTsNCj4+ICsNCj4+ICtvdXQ6DQo+
PiArCWNhcF9mcmVlKGNhcHMpOw0KPj4gKyNlbmRpZg0KPj4gKwlyZXR1cm4gZnJldDsNCj4+ICt9
DQo+PiArDQo+PiAgIC8qIGNhcHNfZG93biAtIGxvd2VyIGFsbCBlZmZlY3RpdmUgY2FwcyAqLw0K
Pj4gICBzdGF0aWMgaW50IGNhcHNfZG93bih2b2lkKQ0KPj4gICB7DQo+PiBAQCAtNzgwNSw4ICs3
ODMzLDggQEAgb3V0X3VubWFwOg0KPj4gICAjZW5kaWYgLyogSEFWRV9MSUJVUklOR19IICovDQo+
Pg0KPj4gICAvKiBUaGUgZm9sbG93aW5nIHRlc3RzIGFyZSBjb25jZXJuZWQgd2l0aCBzZXRnaWQg
aW5oZXJpdGFuY2UuIFRoZXNlIGNhbiBiZQ0KPj4gLSAqIGZpbGVzeXN0ZW0gdHlwZSBzcGVjaWZp
Yy4gRm9yIHhmcywgaWYgYSBuZXcgZmlsZSBvciBkaXJlY3RvcnkgaXMgY3JlYXRlZA0KPj4gLSAq
IHdpdGhpbiBhIHNldGdpZCBkaXJlY3RvcnkgYW5kIGlyaXhfc2dpZF9pbmhpZXJ0IGlzIHNldCB0
aGVuIGluaGVyaXQgdGhlDQo+PiArICogZmlsZXN5c3RlbSB0eXBlIHNwZWNpZmljLiBGb3IgeGZz
LCBpZiBhIG5ldyBmaWxlIG9yIGRpcmVjdG9yeSBvciBub2RlIGlzDQo+PiArICogY3JlYXRlZCB3
aXRoaW4gYSBzZXRnaWQgZGlyZWN0b3J5IGFuZCBpcml4X3NnaWRfaW5oaWVydCBpcyBzZXQgdGhl
biBpbmhlcml0IHRoZQ0KPj4gICAgKiBzZXRnaWQgYml0IGlmIHRoZSBjYWxsZXIgaXMgaW4gdGhl
IGdyb3VwIG9mIHRoZSBkaXJlY3RvcnkuDQo+PiAgICAqLw0KPj4gICBzdGF0aWMgaW50IHNldGdp
ZF9jcmVhdGUodm9pZCkNCj4+IEBAIC03ODYzLDE1ICs3ODkxLDQxIEBAIHN0YXRpYyBpbnQgc2V0
Z2lkX2NyZWF0ZSh2b2lkKQ0KPj4gICAJCWlmICghaXNfc2V0Z2lkKHRfZGlyMV9mZCwgRElSMSwg
MCkpDQo+PiAgIAkJCWRpZSgiZmFpbHVyZTogaXNfc2V0Z2lkIik7DQo+Pg0KPj4gKwkJLyogY3Jl
YXRlIGEgc3BlY2lhbCBmaWxlIHZpYSBta25vZGF0KCkgdmZzX2NyZWF0ZSAqLw0KPj4gKwkJaWYg
KG1rbm9kYXQodF9kaXIxX2ZkLCBESVIxICIvIiBGSUxFMSwgU19JRlJFRyB8IFNfSVNHSUQgfCAw
NzU1LCAwKSkNCj4+ICsJCQlkaWUoImZhaWx1cmU6IG1rbm9kYXQiKTsNCj4NCj4gQ2FuIHlvdSBw
bGVhc2UgcmVwbGFjZSAwNzU1IHdpdGggdGhlIGNvcnJlc3BvbmRpbmcgZmxhZ3MgZXZlcnl3aGVy
ZT8NCj4gSSBwZXJzb25hbGx5IGZpbmQgdGhlbSBlYXNpZXIgdG8gcGFyc2UgYnV0IGl0J3MgYWxz
byB3aGF0IHdlJ3ZlIGJlZW4NCj4gdXNpbmcgbW9zdGx5IGV2ZXJ5d2hlcmUgaW4gdGhlIHRlc3Rz
dWl0ZS4NCk9LLCB3aWxsIGRvLg0KPg0KPj4gKw0KPj4gKwkJaWYgKCFpc19zZXRnaWQodF9kaXIx
X2ZkLCBESVIxICIvIiBGSUxFMSwgMCkpDQo+PiArCQkJZGllKCJmYWlsdXJlOiBpc19zZXRnaWQi
KTsNCj4+ICsNCj4+ICsJCS8qIGNyZWF0ZSBhIGNoYXJhY3RlciBkZXZpY2UgdmlhIG1rbm9kYXQo
KSB2ZnNfbWtub2QgKi8NCj4+ICsJCWlmIChta25vZGF0KHRfZGlyMV9mZCwgQ0hSREVWMSwgU19J
RkNIUiB8IFNfSVNHSUQgfCAwNzU1LCBtYWtlZGV2KDUsIDEpKSkNCj4+ICsJCQlkaWUoImZhaWx1
cmU6IG1rbm9kYXQiKTsNCj4+ICsNCj4+ICsJCWlmICghaXNfc2V0Z2lkKHRfZGlyMV9mZCwgQ0hS
REVWMSwgMCkpDQo+PiArCQkJZGllKCJmYWlsdXJlOiBpc19zZXRnaWQiKTsNCj4+ICsNCj4+ICAg
CQlpZiAoIWV4cGVjdGVkX3VpZF9naWQodF9kaXIxX2ZkLCBGSUxFMSwgMCwgMCwgMCkpDQo+PiAg
IAkJCWRpZSgiZmFpbHVyZTogY2hlY2sgb3duZXJzaGlwIik7DQo+Pg0KPj4gKwkJaWYgKCFleHBl
Y3RlZF91aWRfZ2lkKHRfZGlyMV9mZCwgRElSMSAiLyIgRklMRTEsIDAsIDAsIDApKQ0KPj4gKwkJ
CWRpZSgiZmFpbHVyZTogY2hlY2sgb3duZXJzaGlwIik7DQo+PiArDQo+PiArCQlpZiAoIWV4cGVj
dGVkX3VpZF9naWQodF9kaXIxX2ZkLCBDSFJERVYxLCAwLCAwLCAwKSkNCj4+ICsJCQlkaWUoImZh
aWx1cmU6IGNoZWNrIG93bmVyc2hpcCIpOw0KPj4gKw0KPj4gICAJCWlmICghZXhwZWN0ZWRfdWlk
X2dpZCh0X2RpcjFfZmQsIERJUjEsIDAsIDAsIDApKQ0KPj4gICAJCQlkaWUoImZhaWx1cmU6IGNo
ZWNrIG93bmVyc2hpcCIpOw0KPj4NCj4+ICAgCQlpZiAodW5saW5rYXQodF9kaXIxX2ZkLCBGSUxF
MSwgMCkpDQo+PiAgIAkJCWRpZSgiZmFpbHVyZTogZGVsZXRlIik7DQo+Pg0KPj4gKwkJaWYgKHVu
bGlua2F0KHRfZGlyMV9mZCwgRElSMSAiLyIgRklMRTEsIDApKQ0KPj4gKwkJCWRpZSgiZmFpbHVy
ZTogZGVsZXRlIik7DQo+PiArDQo+PiArCQlpZiAodW5saW5rYXQodF9kaXIxX2ZkLCBDSFJERVYx
LCAwKSkNCj4+ICsJCQlkaWUoImZhaWx1cmU6IGRlbGV0ZSIpOw0KPj4gKw0KPj4gICAJCWlmICh1
bmxpbmthdCh0X2RpcjFfZmQsIERJUjEsIEFUX1JFTU9WRURJUikpDQo+PiAgIAkJCWRpZSgiZmFp
bHVyZTogZGVsZXRlIik7DQo+Pg0KPj4gQEAgLTc4ODksOCArNzk0Myw4IEBAIHN0YXRpYyBpbnQg
c2V0Z2lkX2NyZWF0ZSh2b2lkKQ0KPj4gICAJCWlmICghc3dpdGNoX2lkcygwLCAxMDAwMCkpDQo+
PiAgIAkJCWRpZSgiZmFpbHVyZTogc3dpdGNoX2lkcyIpOw0KPj4NCj4+IC0JCWlmICghY2Fwc19k
b3duKCkpDQo+PiAtCQkJZGllKCJmYWlsdXJlOiBjYXBzX2Rvd24iKTsNCj4+ICsJCWlmICghY2Fw
c19kb3duX2ZzZXRpZCgpKQ0KPj4gKwkJCWRpZSgiZmFpbHVyZTogY2Fwc19kb3duX2ZzZXRpZCIp
Ow0KPj4NCj4+ICAgCQkvKiBjcmVhdGUgcmVndWxhciBmaWxlIHZpYSBvcGVuKCkgKi8NCj4+ICAg
CQlmaWxlMV9mZCA9IG9wZW5hdCh0X2RpcjFfZmQsIEZJTEUxLCBPX0NSRUFUIHwgT19FWENMIHwg
T19DTE9FWEVDLCBTX0lYR1JQIHwgU19JU0dJRCk7DQo+PiBAQCAtNzkxNyw2ICs3OTcxLDE5IEBA
IHN0YXRpYyBpbnQgc2V0Z2lkX2NyZWF0ZSh2b2lkKQ0KPj4gICAJCQkJZGllKCJmYWlsdXJlOiBp
c19zZXRnaWQiKTsNCj4+ICAgCQl9DQo+Pg0KPj4gKwkJLyogY3JlYXRlIGEgc3BlY2lhbCBmaWxl
IHZpYSBta25vZGF0KCkgdmZzX2NyZWF0ZSAqLw0KPj4gKwkJaWYgKG1rbm9kYXQodF9kaXIxX2Zk
LCBESVIxICIvIiBGSUxFMSwgU19JRlJFRyB8IFNfSVNHSUQgfCAwNzU1LCAwKSkNCj4+ICsJCQlk
aWUoImZhaWx1cmU6IG1rbm9kYXQiKTsNCj4+ICsNCj4+ICsJCWlmIChpc19zZXRnaWQodF9kaXIx
X2ZkLCBESVIxICIvIiBGSUxFMSwgMCkpDQo+PiArCQkJZGllKCJmYWlsdXJlOiBpc19zZXRnaWQi
KTsNCj4+ICsNCj4+ICsJCS8qIGNyZWF0ZSBhIGNoYXJhY3RlciBkZXZpY2UgdmlhIG1rbm9kYXQo
KSB2ZnNfbWtub2QgKi8NCj4+ICsJCWlmIChta25vZGF0KHRfZGlyMV9mZCwgQ0hSREVWMSwgU19J
RkNIUiB8IFNfSVNHSUQgfCAwNzU1LCBtYWtlZGV2KDUsIDEpKSkNCj4+ICsJCQlkaWUoImZhaWx1
cmU6IG1rbm9kYXQiKTsNCj4+ICsNCj4+ICsJCWlmIChpc19zZXRnaWQodF9kaXIxX2ZkLCBDSFJE
RVYxLCAwKSkNCj4+ICsJCQlkaWUoImZhaWx1cmU6IGlzX3NldGdpZCIpOw0KPg0KPiBSaWdodCBh
Ym92ZSB0aGlzIHNlY3Rpb24geW91IGNhbiBzZWUgdGhlIGZvbGxvd2luZzoNCj4NCj4gCQlpZiAo
eGZzX2lyaXhfc2dpZF9pbmhlcml0X2VuYWJsZWQoKSkgew0KPiAJCQkvKiBXZSdyZSBub3QgaW5f
Z3JvdXBfcCgpLiAqLw0KPiAJCQlpZiAoaXNfc2V0Z2lkKHRfZGlyMV9mZCwgRElSMSwgMCkpDQo+
IAkJCQlkaWUoImZhaWx1cmU6IGlzX3NldGdpZCIpOw0KPiAJCX0gZWxzZSB7DQo+DQo+IHdoaWNo
IHRlc3RzIHhmcyBzcGVjaWZpYyBiZWhhdmlvci4gSWYgdGhpcyBpcyB0dXJuZWQgb24gdGhlbg0K
PiB0X2RpcjFfZmQvRElSMSB3b24ndCBiZXQgYSBzZXRnaWQgZGlyZWN0b3J5Lg0KPg0KPiBDb25z
ZXF1ZW50bHkgdGhlIHRlc3Q6DQo+DQo+IAkJLyogY3JlYXRlIGEgc3BlY2lhbCBmaWxlIHZpYSBt
a25vZGF0KCkgdmZzX2NyZWF0ZSAqLw0KPiAJCWlmIChta25vZGF0KHRfZGlyMV9mZCwgRElSMSAi
LyIgRklMRTEsIFNfSUZSRUcgfCBTX0lTR0lEIHwgMDc1NSwgMCkpDQo+IAkJCWRpZSgiZmFpbHVy
ZTogbWtub2RhdCIpOw0KPg0KPiAJCWlmIChpc19zZXRnaWQodF9kaXIxX2ZkLCBESVIxICIvIiBG
SUxFMSwgMCkpDQo+IAkJCWRpZSgiZmFpbHVyZTogaXNfc2V0Z2lkIik7DQo+DQo+IHdpbGwgZmFp
bCBiZWNhdXNlIHRoZSBicmFuY2ggaW4gdGhlIGtlcm5lbCB0aGF0IHN0cmlwcyB0aGUgc2V0Z2lk
IGJpdA0KPiB3b24ndCBiZSBoaXQuDQo+DQo+IFNvIGFmaWFjdCwgeW91IG5lZWQgdG8gZW5zdXJl
IHRoYXQgdGhlIHNldGdpZCBiaXQgaXMgcmFpc2VkIGluIHRoZSBpZg0KPiAoeGZzX2lyaXhfc2dp
ZF9pbmhlcml0X2VuYWJsZWQoKSkgYnJhbmNoIGFmdGVyIGhhdmluZyB2ZXJpZmllZCB0aGF0IHRo
ZQ0KPiBkaXJlY3RvcnkgaGFzbid0IGluaGVyaXRlZCB0aGUgc2V0Z2lkIGJpdCB3aXRoIHRoZSBs
ZWdhY3kgaXJpeCBiZWhhdmlvci4NCj4NCj4gSWYgeW91IGRvbid0IGRvIHRoYXQgdGhlbiB0aGUg
dGVzdCB3aWxsIGJlIGEgZmFsc2UgbmVnYXRpdmUgZm9yIHhmcyB3aXRoDQo+IHRoZSBzeXNjdGwg
dHVybmVkIG9uLiBJdCdzIHN1cGVyIHJhcmUgYnV0IGl0J2xsIGJlIGFubm95aW5nIGlmIHdlIGhh
dmUNCj4gdG8gdHJhY2sgdGhpcyBkb3duIGxhdGVyLg0KR29vZCBjYXRjaCwgd2lsbCBmaXggdGhp
cy4NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo=
