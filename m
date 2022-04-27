Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873AD510E0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 03:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356755AbiD0Bhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 21:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356758AbiD0Bhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:37:51 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E50F3A4E;
        Tue, 26 Apr 2022 18:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1651023281; x=1682559281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xRUyA0rLwAWxmlv0SAnfh8aq0GeTmADNKB16555chZM=;
  b=oi8hGmc0vLFStC6HvNd4BS83DrVJ8Qfn+bmAsmyAPoiOZgkJMPB21KFn
   8gDLnig1lW9oPyFgfCHucGlJp0/3QdHeFTBuu6FCFW7vSsqxsrCoID4QY
   g7EkUf8VszSXiiJ8SidjYYZAJBve45D9TkqKl7soih9c/h6IvcDYn9zLR
   D2OgFKrpYZvYioUS7GN4uvRGWZpCehM73uw9Jf1GTLntEJYQtTAs6WlAW
   8mRxDWzVvIeiEXxr9NSXD2EMEGlX7dU50aYhik47tW5YmQPT6dS8pCRrL
   3Pbh3y4ud3hn63+VW6os31nShFBgMNjqKmIpm3ylP9HN3yzDQDXMScQqx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="55062051"
X-IronPort-AV: E=Sophos;i="5.90,292,1643641200"; 
   d="scan'208";a="55062051"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 10:34:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5BX7kflYqTcYA0xCppqtP/+RM1KEoGYppYf6cqes6Lp6efgOtwkKJTJoS+IZWXGOTq9RUvqQsvYuZcTr2djJKWJOJV/2Y/JataX85gV9bZGcFYbvGCHSUrZUT3UZ91M43QC7fmndBMNMue0ONQqDpd8xySWgxdKPY4MPyshtfR70rxii2DtOpmfp+eAI1wcpLES/PPSSrw54qTftynUv/MvanEFQ/trpcorBSghbf5rtJJI4M+l2vp91kRMFs896D5oUd5y0fn48JffkquUMsvLePZXofxdMKX1om8LdfS7AU461lVnUERkwGaTLg7AyztTMf2uVIgqDT9NsbPhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRUyA0rLwAWxmlv0SAnfh8aq0GeTmADNKB16555chZM=;
 b=m7qqAGGOoc4Nqef6KjpSKz4++LhyBOwO8T3owqCEDVl6uvE0hdINakhcdKKnnf4jN3csZH0wEVcPjqZFQdId7D76aqMFoaan5Mh+wTapcqPz5wV7mj4bY9JKvDq8R7ELGI/ZKV7og1+HSxBpFDgPybDczJYx5FhlzAN6VgfObbc6EI9OknnQZLyLwUqCzDU6faSPRFXISEwqhUQk3XL7z35wsFP6MOnrVfqBzosmcKdRh4eA86d5dBhwyHNELcig9vYh5kuPS+a4y4qEpM287ZzJ664Gk9X2YSMIi6UXF3LUkdt+29QbSyfv06WLdPe+Iky1PwcMenTJ8c7FVOw5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRUyA0rLwAWxmlv0SAnfh8aq0GeTmADNKB16555chZM=;
 b=Voc4I/l13sb/dlP5GAOKtr+nqKgd1n1WfVu8CXx55/QqkF4TF18dNltUMkHUhOUNLKBlzOAw66+PodY/0GAHKYdsn6HSItK2ncr2TyrJaIFVtAlUqq7lvmo1oNU++epKpfiiUPsOeGF6ANuJh7s3o8be4/6UdcWArKiDDdVtYsA=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS0PR01MB5492.jpnprd01.prod.outlook.com (2603:1096:604:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 01:34:34 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:34:34 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Thread-Topic: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Thread-Index: AQHYWVXfz8USQ3fGU0yVfe+Yu4r8bq0CR/QAgADEc4A=
Date:   Wed, 27 Apr 2022 01:34:34 +0000
Message-ID: <6268AC13.2020300@fujitsu.com>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <a6919986dcd93c695761b022b9fddb93937d3deb.camel@kernel.org>
In-Reply-To: <a6919986dcd93c695761b022b9fddb93937d3deb.camel@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbe40779-4a65-4535-b085-08da27ee155d
x-ms-traffictypediagnostic: OS0PR01MB5492:EE_
x-microsoft-antispam-prvs: <OS0PR01MB54924575C9B886BA12B50EC1FDFA9@OS0PR01MB5492.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2KEV3torN8GCpr59GlgYuvdsBa5q6UrIghLCdZIEnOW1NE/Ht7/wT7/aaFMLIKh/Fz0RUvK6Q9JXPRKUltPHfouDBJdCUGvljIC5rFmg+l2WJn9c5gkOeboXH2PXjfGos6GHPd3i7wFbfr0UmeujxI94SMXsFuoDCSzNB67uT5rD+WFzLinMaay9OqAAd6KJGF/UT42+kq5Ciy3E/0xCfE9J6sCurBGKe/rV2d4USqKIVc2lv+52Y7xgdxbYWBumGEMNWe7H8eQW5PPXYwA0YuMm69XCDg+KdI4Hb/Ony6uDBERhBV21bNZbLnj8FQCSRXXFMu5eHiWBzEFBE1Q8ssxPM5e1B2Y0W7s8nWjT13SX2YqhhzV7MELWf4o2L/n311Fh5af10HrO7yIlSQD70SkJD9roYde7Ibd8Anm3pXGy5wSVDhy5ji3+WEhDh04dukrFoCLXmO3U7Ee31Hle9MsegjvJ9AAuLlJa32BhQ8NCi2v2pN+pvqpK7etsp2UIZcHfxyEKUIiZ8fzV6v9yPl/8dBik6k5DEvpke6PUnoIZ4yl4DHMd4iZep5AcO/254xIiv91QyHI7Atyto/1SUDjqj8C4yPuO8p4mav0m9DBNcwnPvAKLCVPNipv+IJyAoAYg+iduabVL8SUcjXrA/2nysenoiBgCenGPMS9GhBRw2fogqB+9FdDI2XvejpAaM/edM4pwUCuaH0OmbK19aF9dqsepA8Kvq9ti8KzdIXT2v1rvMWnudHmNfQJdeZof9+7pY/ND4JGkYHUlXg/ma9sckL8cWXLXZHE5Ms0/35I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(8936002)(2616005)(91956017)(5660300002)(85182001)(45080400002)(2906002)(33656002)(6506007)(26005)(54906003)(186003)(86362001)(87266011)(83380400001)(122000001)(38070700005)(66476007)(66556008)(6916009)(66446008)(76116006)(8676002)(6512007)(66946007)(38100700002)(64756008)(4326008)(82960400001)(36756003)(316002)(6486002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDUyV0xUdjVCSytQVVg4bmVoZU0vbm93VFZOYVB1SHJFVzZSb3NTQnNnVGJy?=
 =?utf-8?B?WGZSNkNJWXBpODllRWZObjhvZ0NWZVJHN0hieFZ2dzYxYkc1VmtMRnpTNlpp?=
 =?utf-8?B?Uy9LWTR2UHU0VjNvUXZnMjQxMnU4NEV2N1VUc0tHWXdEb21wdzA1a1pwWVVL?=
 =?utf-8?B?ZklDMEJhdkxrNkRvSmc1OFBZUDR6aFhHSW5iTDhxclJ2ZXhrellCVk9xKzNP?=
 =?utf-8?B?aXQ1U3NFRzdaa0hUdjhpU0RHRmlIQlZ4ZlVLY1dxWXFjNGhRSU9hY0dGMndt?=
 =?utf-8?B?N09PWm5ERTFpWU1ONFV6S2Y5bXc4ZzRuVjRZTWFsczl0aUN1QnJwWFpMSks5?=
 =?utf-8?B?TWhnLzNndFVSbnNQaEZHVVdsdHpwUFpSc1BrWFRVZW5sR1lRNXRaa1Zha3ds?=
 =?utf-8?B?UGY0L0kvVG4zLzZVQ3gzcloyclloVG9hQnQ0OUJjVnIrWWFuYkdJUE1aL3VD?=
 =?utf-8?B?a3ZqdkdvYXVuZW9FRkZyekdYZGMwOHpsVFFHZDVab2gyc3hndE56UWk1REkv?=
 =?utf-8?B?dlpXRWxDVk1NNThYcmhibms0ci9yNFZHWlUxYUVCanczc2RFZ21SNitHaFRn?=
 =?utf-8?B?bGdxSm5WTUp3d2xrdlNnZEc1MFNxVDMza0N4cXNFRXRzb1lxZEs1cW1CNG9F?=
 =?utf-8?B?OWpmR3NsU3A3WlcvdE9XeDZ1VmlOVlBXaE16N2J6aXZBaHpIT3p5eEJYcEl2?=
 =?utf-8?B?WERiNHJ6TzI2enVNK0kxaUxYYWp0OTJPS01iU2YxWnNCVW9jdE50SjI5ZVNm?=
 =?utf-8?B?a0pkQWFlTWNreWhXYjh5U0wvL0YxNXYvQVQxb2ZHYTRmZUpYcWdLbGJiOS9I?=
 =?utf-8?B?UXlQVG84c0hVOVRMQ08vRXpjV1plWGIzZVFKbE9hMm5PVlVQTHlPa25Cd1c2?=
 =?utf-8?B?N1djYWpZdjlaODFyUGhiQk5XcVhrU05nV21XUk1ZYlFsL3M2TWttOEJBaDVq?=
 =?utf-8?B?TTNxeHJmdHFvV3FZY2cyQm1uU3FIY1pyZlBkaFdSWmlIV29ubW9RdW13SXVz?=
 =?utf-8?B?dVhjOHBmL3dHZDVQazQ5NkpGakVyUTBLbDZ1dkNOMGExVzhxalZwaEdmZ2RQ?=
 =?utf-8?B?NTZ4YURJN2Y4RkpMcHRBSVZDY2xhWWhHNklwRzVLV3pzVUNKVHRZbW9KRW10?=
 =?utf-8?B?S25VYTdLTVhKYkRmOG9sL2cxTTRxVDFJb3pxb08wb3M3MW5xdGNxVDdxZnlO?=
 =?utf-8?B?dlBvREtLQTZkQTVHL3ByekR3Q244alRjV245QSthNzNXRTdLVWsrVENON0dn?=
 =?utf-8?B?YUFDU3dHc3BYRVdBWUw1WG9UcW1ZNHI0OW1lSHdtU2lpbGtTcklhbGdBR1c3?=
 =?utf-8?B?T3dRbThlTGZaOTVEYjh0eVpuR3RoMXR3MitMSUU5d3dlM2xhUzc4MDR0RHdC?=
 =?utf-8?B?R3JUYjUwQnh6WWtvcitWaFJ5TkRyWkp6OWZVNTlKcHJ1cSt2ZzkycVFYNDRX?=
 =?utf-8?B?T2l0OUphekhzaVdtTmp4dERKSnNRNnhTVkZZbm9NY2Z1RHJUSHJPdlhVV1pD?=
 =?utf-8?B?T1AwdW1PcHJSZHQ2emRLbEV4U1NLMzRBZkUxbE1FSXJDalROTGZoa3g2Tmhm?=
 =?utf-8?B?MnY5aDJndGkwYzFnSXNIRU5VTkQ5RWI1VXgwQVlKR1Fha0ROQ0ZUWXh2L0Zu?=
 =?utf-8?B?aEFRNEE1TG9NaWRDNzYrVmh5SFFmcFdiblNVTFB1a2NmbEZWVERTYVNVVHFs?=
 =?utf-8?B?bXNITTIzQWR6eG5EakswbDA5NnhDaG9teW9pNE13T1ExVmF5aUpHUWZkK2Z3?=
 =?utf-8?B?Y2V3ZXY1RXNVLzZkcStXRGhDZ2RWdUpKd3orcTcyR3JFRXZsbFJVaW9KOWpl?=
 =?utf-8?B?djZwWnNlZTUra294Y1VheDRHdUFVaHhrL3NZMCtISGdhK3pkclpYSTBqdEZ5?=
 =?utf-8?B?NWxMUUd3VWpnYldYSFJmRHhhZGtobXE0OHlrQ0kwMUZZRjVoOXBiRTBsVitG?=
 =?utf-8?B?WmQ5US9SUnZCOFpqQUowbnJwUkF1YXd3dGJRd3l2Q1ZOaU9JMDVlZ3FYdWNP?=
 =?utf-8?B?YVlNT0FTTW56QytibVc1SEF6Zm50SGcxUTZ0MkFYaFNVN3I3RGIwQlR2eXdr?=
 =?utf-8?B?ckhKSVlqTkNCWTdzMXFPbW1LRTVyenEzb2tPY3Z6c0dqeGZockp4NmlmQ2NF?=
 =?utf-8?B?SjhqM3phU092eFRUN0FIYVg3eVE2ek5KUVJESk9RRFltV1U1dHdYT21pZm1N?=
 =?utf-8?B?STUzd3MwYzF3Q1psNE83UEdRZFdKM2pDY3lPME81UnRBL2ZreC90S3BTZnF4?=
 =?utf-8?B?MFRxc3RnZ2FZQk1vWlRNL1o2MzhHME4rTENsMU5xLzdCc0d1YUgvaHkyb0VG?=
 =?utf-8?B?cWo3blBDYmlJenRKL24wUHhlaUVVK09FVXpvOWMrL2M2M3ZQNjB4NHBxQ2Er?=
 =?utf-8?Q?CPTsDE6C1yhBxZkNzUpp3VkLFDerprHozWpdq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59EEBF384590C9429602DD3D167FEEC1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe40779-4a65-4535-b085-08da27ee155d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 01:34:34.0351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B77KAvBLKC5+1HmEIT5jhhZqwA2b4KLrCmVFnVjnsdKxfKkH/AuD/PGoQVpw1UbkE+SHyF039lKvXRdBzg2ZPU7swcavkfjXeCUEzCKLgh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5492
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

5LqOIDIwMjIvNC8yNiAyMjo1MiwgSmVmZiBMYXl0b24g5YaZ6YGTOg0KPiBPbiBUdWUsIDIwMjIt
MDQtMjYgYXQgMTk6MTEgKzA4MDAsIFlhbmcgWHUgd3JvdGU6DQo+PiBBZGQgYSBkZWRpY2F0ZWQg
aGVscGVyIHRvIGhhbmRsZSB0aGUgc2V0Z2lkIGJpdCB3aGVuIGNyZWF0aW5nIGEgbmV3IGZpbGUN
Cj4+IGluIGEgc2V0Z2lkIGRpcmVjdG9yeS4gVGhpcyBpcyBhIHByZXBhcmF0b3J5IHBhdGNoIGZv
ciBtb3Zpbmcgc2V0Z2lkDQo+PiBzdHJpcHBpbmcgaW50byB0aGUgdmZzLiBUaGUgcGF0Y2ggY29u
dGFpbnMgbm8gZnVuY3Rpb25hbCBjaGFuZ2VzLg0KPj4NCj4+IEN1cnJlbnRseSB0aGUgc2V0Z2lk
IHN0cmlwcGluZyBsb2dpYyBpcyBvcGVuLWNvZGVkIGRpcmVjdGx5IGluDQo+PiBpbm9kZV9pbml0
X293bmVyKCkgYW5kIHRoZSBpbmRpdmlkdWFsIGZpbGVzeXN0ZW1zIGFyZSByZXNwb25zaWJsZSBm
b3INCj4+IGhhbmRsaW5nIHNldGdpZCBpbmhlcml0YW5jZS4gU2luY2UgdGhpcyBoYXMgcHJvdmVu
IHRvIGJlIGJyaXR0bGUgYXMNCj4+IGV2aWRlbmNlZCBieSBvbGQgaXNzdWVzIHdlIHVuY292ZXJl
ZCBvdmVyIHRoZSBsYXN0IG1vbnRocyAoc2VlIFsxXSB0bw0KPj4gWzNdIGJlbG93KSB3ZSB3aWxs
IHRyeSB0byBtb3ZlIHRoaXMgbG9naWMgaW50byB0aGUgdmZzLg0KPj4NCj4+IExpbms6IGUwMTRm
MzdkYjFhMiAoInhmczogdXNlIHNldGF0dHJfY29weSB0byBzZXQgdmZzIGlub2RlIGF0dHJpYnV0
ZXMiKSBbMV0NCj4+IExpbms6IDAxZWExNzNlMTAzZSAoInhmczogZml4IHVwIG5vbi1kaXJlY3Rv
cnkgY3JlYXRpb24gaW4gU0dJRCBkaXJlY3RvcmllcyIpIFsyXQ0KPj4gTGluazogZmQ4NGJmZGRk
ZDE2ICgiY2VwaDogZml4IHVwIG5vbi1kaXJlY3RvcnkgY3JlYXRpb24gaW4gU0dJRCBkaXJlY3Rv
cmllcyIpIFszXQ0KPj4gUmV2aWV3ZWQtYnk6IERhcnJpY2sgSi4gV29uZzxkandvbmdAa2VybmVs
Lm9yZz4NCj4+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gQnJhdW5lciAoTWljcm9zb2Z0KTxicmF1
bmVyQGtlcm5lbC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1PHh1eWFuZzIwMTguanlA
ZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgZnMvaW5vZGUuYyAgICAgICAgIHwgMzcgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4gICBpbmNsdWRlL2xpbnV4L2ZzLmgg
fCAgMiArKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2ZzL2lub2RlLmMgYi9mcy9pbm9kZS5jDQo+PiBp
bmRleCA5ZDliNDIyNTA0ZDEuLmU5YTVmMmVjMmY4OSAxMDA2NDQNCj4+IC0tLSBhL2ZzL2lub2Rl
LmMNCj4+ICsrKyBiL2ZzL2lub2RlLmMNCj4+IEBAIC0yMjQ2LDEwICsyMjQ2LDggQEAgdm9pZCBp
bm9kZV9pbml0X293bmVyKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0
IGlub2RlICppbm9kZSwNCj4+ICAgCQkvKiBEaXJlY3RvcmllcyBhcmUgc3BlY2lhbCwgYW5kIGFs
d2F5cyBpbmhlcml0IFNfSVNHSUQgKi8NCj4+ICAgCQlpZiAoU19JU0RJUihtb2RlKSkNCj4+ICAg
CQkJbW9kZSB8PSBTX0lTR0lEOw0KPj4gLQkJZWxzZSBpZiAoKG1vZGUmICAoU19JU0dJRCB8IFNf
SVhHUlApKSA9PSAoU19JU0dJRCB8IFNfSVhHUlApJiYNCj4+IC0JCQkgIWluX2dyb3VwX3AoaV9n
aWRfaW50b19tbnQobW50X3VzZXJucywgZGlyKSkmJg0KPj4gLQkJCSAhY2FwYWJsZV93cnRfaW5v
ZGVfdWlkZ2lkKG1udF91c2VybnMsIGRpciwgQ0FQX0ZTRVRJRCkpDQo+PiAtCQkJbW9kZSY9IH5T
X0lTR0lEOw0KPj4gKwkJZWxzZQ0KPj4gKwkJCW1vZGUgPSBtb2RlX3N0cmlwX3NnaWQobW50X3Vz
ZXJucywgZGlyLCBtb2RlKTsNCj4+ICAgCX0gZWxzZQ0KPj4gICAJCWlub2RlX2ZzZ2lkX3NldChp
bm9kZSwgbW50X3VzZXJucyk7DQo+PiAgIAlpbm9kZS0+aV9tb2RlID0gbW9kZTsNCj4+IEBAIC0y
NDA1LDMgKzI0MDMsMzQgQEAgc3RydWN0IHRpbWVzcGVjNjQgY3VycmVudF90aW1lKHN0cnVjdCBp
bm9kZSAqaW5vZGUpDQo+PiAgIAlyZXR1cm4gdGltZXN0YW1wX3RydW5jYXRlKG5vdywgaW5vZGUp
Ow0KPj4gICB9DQo+PiAgIEVYUE9SVF9TWU1CT0woY3VycmVudF90aW1lKTsNCj4+ICsNCj4+ICsv
KioNCj4+ICsgKiBtb2RlX3N0cmlwX3NnaWQgLSBoYW5kbGUgdGhlIHNnaWQgYml0IGZvciBub24t
ZGlyZWN0b3JpZXMNCj4+ICsgKiBAbW50X3VzZXJuczogVXNlciBuYW1lc3BhY2Ugb2YgdGhlIG1v
dW50IHRoZSBpbm9kZSB3YXMgY3JlYXRlZCBmcm9tDQo+PiArICogQGRpcjogcGFyZW50IGRpcmVj
dG9yeSBpbm9kZQ0KPj4gKyAqIEBtb2RlOiBtb2RlIG9mIHRoZSBmaWxlIHRvIGJlIGNyZWF0ZWQg
aW4gQGRpcg0KPj4gKyAqDQo+PiArICogSWYgdGhlIEBtb2RlIG9mIHRoZSBuZXcgZmlsZSBoYXMg
Ym90aCB0aGUgU19JU0dJRCBhbmQgU19JWEdSUCBiaXQNCj4+ICsgKiByYWlzZWQgYW5kIEBkaXIg
aGFzIHRoZSBTX0lTR0lEIGJpdCByYWlzZWQgZW5zdXJlIHRoYXQgdGhlIGNhbGxlciBpcw0KPj4g
KyAqIGVpdGhlciBpbiB0aGUgZ3JvdXAgb2YgdGhlIHBhcmVudCBkaXJlY3Rvcnkgb3IgdGhleSBo
YXZlIENBUF9GU0VUSUQNCj4+ICsgKiBpbiB0aGVpciB1c2VyIG5hbWVzcGFjZSBhbmQgYXJlIHBy
aXZpbGVnZWQgb3ZlciB0aGUgcGFyZW50IGRpcmVjdG9yeS4NCj4+ICsgKiBJbiBhbGwgb3RoZXIg
Y2FzZXMsIHN0cmlwIHRoZSBTX0lTR0lEIGJpdCBmcm9tIEBtb2RlLg0KPj4gKyAqDQo+PiArICog
UmV0dXJuOiB0aGUgbmV3IG1vZGUgdG8gdXNlIGZvciB0aGUgZmlsZQ0KPj4gKyAqLw0KPj4gK3Vt
b2RlX3QgbW9kZV9zdHJpcF9zZ2lkKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywN
Cj4+ICsJCQkgY29uc3Qgc3RydWN0IGlub2RlICpkaXIsIHVtb2RlX3QgbW9kZSkNCj4+ICt7DQo+
PiArCWlmIChTX0lTRElSKG1vZGUpIHx8ICFkaXIgfHwgIShkaXItPmlfbW9kZSYgIFNfSVNHSUQp
KQ0KPj4gKwkJcmV0dXJuIG1vZGU7DQo+PiArCWlmICgobW9kZSYgIChTX0lTR0lEIHwgU19JWEdS
UCkpICE9IChTX0lTR0lEIHwgU19JWEdSUCkpDQo+PiArCQlyZXR1cm4gbW9kZTsNCj4+ICsJaWYg
KGluX2dyb3VwX3AoaV9naWRfaW50b19tbnQobW50X3VzZXJucywgZGlyKSkpDQo+PiArCQlyZXR1
cm4gbW9kZTsNCj4+ICsJaWYgKGNhcGFibGVfd3J0X2lub2RlX3VpZGdpZChtbnRfdXNlcm5zLCBk
aXIsIENBUF9GU0VUSUQpKQ0KPj4gKwkJcmV0dXJuIG1vZGU7DQo+PiArDQo+PiArCW1vZGUmPSB+
U19JU0dJRDsNCj4+ICsJcmV0dXJuIG1vZGU7DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1CT0wobW9k
ZV9zdHJpcF9zZ2lkKTsNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZzLmggYi9pbmNs
dWRlL2xpbnV4L2ZzLmgNCj4+IGluZGV4IGJiZGU5NTM4N2EyMy4uOThiNDRhMjczMmY1IDEwMDY0
NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9mcy5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2Zz
LmgNCj4+IEBAIC0xODk3LDYgKzE4OTcsOCBAQCBleHRlcm4gbG9uZyBjb21wYXRfcHRyX2lvY3Rs
KHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLA0KPj4gICB2b2lkIGlub2RlX2lu
aXRfb3duZXIoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5vZGUg
Kmlub2RlLA0KPj4gICAJCSAgICAgIGNvbnN0IHN0cnVjdCBpbm9kZSAqZGlyLCB1bW9kZV90IG1v
ZGUpOw0KPj4gICBleHRlcm4gYm9vbCBtYXlfb3Blbl9kZXYoY29uc3Qgc3RydWN0IHBhdGggKnBh
dGgpOw0KPj4gK3Vtb2RlX3QgbW9kZV9zdHJpcF9zZ2lkKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAq
bW50X3VzZXJucywNCj4+ICsJCQkgY29uc3Qgc3RydWN0IGlub2RlICpkaXIsIHVtb2RlX3QgbW9k
ZSk7DQo+Pg0KPj4gICAvKg0KPj4gICAgKiBUaGlzIGlzIHRoZSAiZmlsbGRpciIgZnVuY3Rpb24g
dHlwZSwgdXNlZCBieSByZWFkZGlyKCkgdG8gbGV0DQo+DQo+IFRoaXMgc2VyaWVzIGxvb2tzIGxp
a2UgYSBuaWNlIGNsZWFudXAuIEkgd2VudCBhaGVhZCBhbmQgYWRkZWQgdGhpcyBwaWxlDQo+IHRv
IGFub3RoZXIga2VybmVsIEkgd2FzIHRlc3Rpbmcgd2l0aCB4ZnN0ZXN0cyBhbmQgaXQgc2VlbWVk
IHRvIGRvIGZpbmUuDQo+DQo+IFlvdSBjYW4gYWRkIHRoaXMgKG9yIHNvbWUgdmFyaWFudCBvZiBp
dCkgdG8gYWxsIDQgcGF0Y2hlcy4NCj4NCj4gUmV2aWV3ZWQtYW5kLVRlc3RlZC1ieTogSmVmZiBM
YXl0b248amxheXRvbkBrZXJuZWwub3JnPg0KDQpUaGFua3MsIEkgYWxzbyBoYXZlIGEgeGZzdGVz
dHMgcGF0Y2ggc2V0WzFdIGZvciB0ZXN0aW5nIHRoaXMsIGJ1dCBub3cgaXQgDQppcyBub3QgYSBm
aW5hbCB2ZXJzaW9uLg0KDQpbMV1odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
ZnN0ZXN0cy9saXN0Lz9zZXJpZXM9NjMxNDYxDQo=
