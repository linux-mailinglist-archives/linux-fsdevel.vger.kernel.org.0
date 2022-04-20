Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01288507E06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 03:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358697AbiDTBTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 21:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348326AbiDTBTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:19:21 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257001D0EB;
        Tue, 19 Apr 2022 18:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650417397; x=1681953397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X/WSFZzwDRFJ87Rb7HwHc2/mPD5bEW/Qz45Dv07PzNE=;
  b=XFqDqbz1Qd3oyMN4QYvJ2beo6dcKfwBJOAln0rTmlYDr6DWNWPLsDXcT
   gvV/yxr6gTffcB9D9OaFKzVsqMT+iPYvJ2ph/E15QoN3Gdv4JUlou+AeE
   5hWGBBodKksRo6tioxE/yskjAKrmfBd07angTlCKrOtLeLcyoEqEWqHEa
   Kh1EavL4WsSr9KuQ1gs9ZoIr1HZo8aHkEdWBUa0CtBzBY79hiyi1uj3hb
   kJ4UbK53J37P6vXNSf9FPgs9gBKxDVOO48D9G0lowbpOiRTDPrtYX4Noz
   U3b+ScNkx0N7e9C4DHKgBFUd5qpXYgFcm1lqmE+4uuG/2kUj1Be54j1EV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="62450105"
X-IronPort-AV: E=Sophos;i="5.90,274,1643641200"; 
   d="scan'208";a="62450105"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:16:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xlz7z9QhDIfiNCJ7Pw9+vUDvWi2pX8ExWs3zSN+Q3sFUyGv39/V/JzFPspIfTPCXrcg6lXPj6IxRmIWaoonFFhxmAXa1O7x+3BLaqS5CJjuOqe1e58tX9qY7FjI7VxPqTIH5xgC/qwYp9BNl8vBHyCjkvU9Xm+X8qvCZ9MIGWCkxZlEMc/nG25D8YgDE8cyZE+du9fB/ksE0+lEyJjOftJUSfjKOHeEtYZlrNsgF0lkpVD3sDGre2+xyMdtX5Vhc9yu9iJKAaZXu6AJGIxIuy0aYqUm9Xbr2JAWGQCIFt3FVIiZyJiuO8u+42pAuUuE9cMhGxLshLlVJKLtUb57/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/WSFZzwDRFJ87Rb7HwHc2/mPD5bEW/Qz45Dv07PzNE=;
 b=DMjhgN64UZTuRjzD7YqFJfBo8OqDjnkQxt+3s+bATFLSBFxuF0Iat7tGJQvbuSC5y9qxJZHBdMTIlU1/AgNtHOYuhKVs4dqDuWdU/rXEnsXs5HCmqkdMP4LfAm2/lUK7APvVIAafpguKywNGmaSqaD5hcJZIIPE81POLw9FRMg35REtzzI8UYLklhiIQT9ol6HQvCN1uKZhFjXnGxcKMD6HaJx1wMoGPEMPh92xxt9NtId5FE5dF3IRBDWigSc05GTuKGbz34WflHS0T2LgSSv4JN3AkqbpEDItyqNozDxpysqBDQTz63EBDgJoOR79DvyrNLps52PJ6QCuXuzTQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/WSFZzwDRFJ87Rb7HwHc2/mPD5bEW/Qz45Dv07PzNE=;
 b=YNvrMZadYX3EEdV+hR+U8i/+8tqIHIHusvL4lBjl4bneLLErra+bwVhktzhWOVAsIqZrydaPUlS6BMmcj4R0ZGDqblTzjXb1b/WkeSfPMnOZOxQy+qYVV63SZJQwv6oFjeuURMYxmtqxNhRcxeUI5UZRUbfl90vTM4XSoHBlSRU=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB10073.jpnprd01.prod.outlook.com (2603:1096:604:1e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 20 Apr
 2022 01:16:28 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 01:16:28 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH v4 7/8] fs: strip file's S_ISGID mode on vfs instead of on
 underlying filesystem
Thread-Topic: [PATCH v4 7/8] fs: strip file's S_ISGID mode on vfs instead of
 on underlying filesystem
Thread-Index: AQHYU9smrES0QaSd7UyAJX8RLA+ZpKz3RliAgADLkgA=
Date:   Wed, 20 Apr 2022 01:16:28 +0000
Message-ID: <625F6D46.3010604@fujitsu.com>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650368834-2420-7-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220419140905.7pbfqrzmyczyhneh@wittgenstein>
In-Reply-To: <20220419140905.7pbfqrzmyczyhneh@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddb09ae7-3188-4f68-3fe4-08da226b654e
x-ms-traffictypediagnostic: OS3PR01MB10073:EE_
x-microsoft-antispam-prvs: <OS3PR01MB10073F10CB0A5D2A51C5FC677FDF59@OS3PR01MB10073.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zX+gFvvLM0S08TSOXW4Kn2C2wUJInizZdZg7enmdZOjd5lmwOM2KMZD38IQUBq2TvWLPWwaszzQpraqM97IN/zUE+EhZynaW3xoIFshtY/GJGqBvNOG+XcMzJ/d8gd3uCRaBTfVbbCHyaxTjKJpbfNA8Wd7m2UoYAHNd8K189k3pS4nbwiyqu896Ld8UCMAxzAkuKob6YBnL+BDoflR6y4HsWkZxnjtLJQKlHqeM56Cwjv+VCtZaxtZa6pF3/MgypNkKF2cHledW8pzSRUNfcz/YZlMXtZawk/Cs0739//wOo3GnhLLYl37hD8/EtbtB0qfa+RUP3Mle3bMrjbTOeR3x86eVBeFFrkfNNGTA4tQPm0TpZs9IOg4zFTuGHKNvawRmk0KnFH2aM6NsChzYjlYmEv2+iXga1RsHn3H45klK6wzPR4G+3qY5teB8wLd4+4XWCIviTR+TBxDvYlpvY4pmwmv3WD4O1XMM+Ewj3iFZr9uMA5XtvJ/CldhGNweFqQtlmQl57nux+V+L40OvFI/jMQNQDUNaC/xcazkj5syC1l/8D5vbU3j7eRPeUJGho/kgH0BrAX5M90bItgal/sMZ2bX4lO04sw/BzCizInsUmXg7Rf9EE6BaHrlMxJTbSxfdfZ4LGyp3hZXlpGfjRLhVyg82RsYAXHPofcP/ZgB9kJOA0OG76leX1fG5nibSWbXiOdE/ZBjN76FheiO1qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(54906003)(6916009)(8936002)(6512007)(87266011)(26005)(2616005)(2906002)(64756008)(8676002)(82960400001)(38070700005)(38100700002)(91956017)(122000001)(6486002)(36756003)(66946007)(6506007)(33656002)(83380400001)(7416002)(85182001)(316002)(66446008)(86362001)(186003)(71200400001)(66476007)(66556008)(76116006)(508600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU4vdjE3MDVoZW95ZHhJN3V4MXFRblhMaUwvMW5DblRDdzBtTHlvT3p5cEFx?=
 =?utf-8?B?RVdKWXpnalBUVHc3amFxUS9CaW5rK2Z1ZHo5NytBSG0xR1hpOStSVzJmbUtU?=
 =?utf-8?B?Z21LRWJsUVdhL2dvbGIzSE42cEtpQzlQQVprbkFlUWFwTDRseDh1cm9FZ2t0?=
 =?utf-8?B?U2lkbzR6T0dJUFZCZnpLaVU4WlJpVmREMUpPNzVkdkFxTzhrdXpYU1FzMFU4?=
 =?utf-8?B?VHZkenplRlZibUFpaWl2M2ZteDF4dk5OQVA3NHBuMW5kSVJVWUEvYWN6YVVY?=
 =?utf-8?B?UW81b3dUYm51di9qNnJLeXZib2g5TzAvTVh6M0lvd1N6eGZjL2JPR1BYNm9a?=
 =?utf-8?B?bExvZ1JsU3RWTHBaYzRZMVVWa2psdkxwcm00R3VXVURTMmx6UWRVbCtqOVQ2?=
 =?utf-8?B?dCt6RmVLOUJLMnlMaHBFRFdCK1NHRnVaQnpwdndKU1dVS2U5UnNnVjBKbDdF?=
 =?utf-8?B?UUVkTVJNSjNSSTBibEpKOFp2MjRXalkrYTZ5Mzd3L2dPNUtHM2FmVlFpRDJm?=
 =?utf-8?B?bDVTbjNvNDFmQnUvWWhOTlpxRlpad3lpeml6aUVEMnR3OGhKb05HWWhLRlJl?=
 =?utf-8?B?eWptQlBMWjVyang0TEVGdkpqbEFOWS8vNm1ydDRBV2ErOEcySlBnYSs4bXNj?=
 =?utf-8?B?bEhPcytlWFpCQzBFWVpZcU5EYmRTYkFhYmF0N3gzM1NhN2NnZ2hJZk14MWFE?=
 =?utf-8?B?U3ZOVld3c1FqZFJsNFZmb0hxRC9RcmhvSzdOMkZWcW9LbTJhVXlnL2JHZURD?=
 =?utf-8?B?Y091d2Z4WVErSWx4ck40RGNZcVpMZGlqREsxVm5Yd29DRmdLVmlHeXEzNVRT?=
 =?utf-8?B?NDRyMkduS2Ntc21vVjQvMDI5SXB2ZWk0SVZ4Wmd6Z1FhSmdsaDBlRjR5b1Jn?=
 =?utf-8?B?M3NuaHcvN01RMEZycWM1bjI0djRFNlhoYVRMbGtqdFJYaEdHWGxlL0JFbnQx?=
 =?utf-8?B?STAydGViVDJFbFljZnhDdEtMeTEySHAxSVZhd2EveVYybnpKTStUY0lvUGtn?=
 =?utf-8?B?RHpXRTBoOGVNdE9iUzB6V0FMV3RMS3B2QXd3UjF4TTdTR1grR09YWi9aU3Vr?=
 =?utf-8?B?Uis4RDlHRFE0bkprN0JMUkY5TXZqQzJrR0NheHU0ZUs0MElKV1F6RFFsZ2s1?=
 =?utf-8?B?dzBIeHovbjk3OUwyc0U2L3F3dW53L0I2bDFkVGdVYTRUNTFoR2kwM3V2MllU?=
 =?utf-8?B?KzdPalgyZjRvRXoraFlvdWxWbjhibzNvNDVSaWUvdkRKMFFmSlJ0eEtNS1Fj?=
 =?utf-8?B?MUpCdnQzcnN4aGVBQlB4RW8wQnR2ckxYZVZ5U3VMc3I2R2RHaTNSVFI0dVY5?=
 =?utf-8?B?eGY0QmZ4bi9hWEhrcFAyNzR2ZkhPY2xkRTJDM01kTGJYQTA1Y1Z1Z0pjcjBI?=
 =?utf-8?B?RzN3anh1ZWxwNUVpSDZMQngwblVmc29jMUd6UWd2TVdMaVg3OUtWbnVUbWRX?=
 =?utf-8?B?OUNUaUNMS3JSalpRbDNCMWRZTHJadzhZY1N0cUVveVFyRnpLZkFOblcvQkJv?=
 =?utf-8?B?ckpTVDVTWGtJMlBmeEdDUVYrcEh4MmtlVmZqUzd1VEFjc0N2ZTFHNktmZnB6?=
 =?utf-8?B?aXoxaWVHV1Jmb29TNWJGSzhuWW5oVHhycEFHMlpaRm03eHdQMkY3eFBEVndx?=
 =?utf-8?B?amNwM3dUL21GWXIxTUVockJLWmRrZ2QyUVNsdGpaL0l6TzBHdGxKRWRXbEF5?=
 =?utf-8?B?L09PYkdjTDI3dmMwaFFuaE5XcUt3K1ZtbkRnQnZGR2RXU2Nyd2MvbXBBZGkw?=
 =?utf-8?B?aHJUUDVFODIxSHdyZnF5TGg1Tm1WQzZGdFVTR1lOSi91b3lGWjhuOEZqeHh3?=
 =?utf-8?B?N095aFJ0b1BZL3VybXBLdlp6Zm1xK3VpR2JCbzYwWklTZHdCZWhDSmV0YTlU?=
 =?utf-8?B?NUtLVDlnaDA5dVhFTUFwSXd4TjMvTkVUWGtRZ04ya1dyNEpiMmovR2ZQVlBz?=
 =?utf-8?B?U05vcGozZ3oxeXgvT3A5OVFzbyt0MkcrUlFDMEszUUNPdlMrc003WXlQWFhu?=
 =?utf-8?B?VWJSbmtaaGZVUnZaM2xxNVZHSzJkS2c0OEFHdkhQdi8zSjdLL2YwSXBKdkZR?=
 =?utf-8?B?TjZkd0xzdTdiTHhIV0dvODJHZk5YRm1OU1JpWmhjSEF5UzJaYW82SytqR2tq?=
 =?utf-8?B?ZFFGenIyMXBvdXlacXVLSUlucVByeWlzT1BlRElPMmp2VDNEVm85b0w0S002?=
 =?utf-8?B?VTdmK24yVEhRSU5QTEIwVk02T2VZYm5yQjlwd295WTIyOFFSRktpZGI0ZDZJ?=
 =?utf-8?B?YmYzTzdGRE8wT1hocXk3cm1nbllqTjlrM0xEa0ZFZmNCemYzZ28wWXlFakhm?=
 =?utf-8?B?QnIyZDRlRVVRNC9jRjRvQUZGdC9uUlJKWjdwYUxDNEZVaUtvTi9EMzJPc0dp?=
 =?utf-8?Q?iWeBS9/lVtxTELrmP44fo3tLCNNy0BI+4UvTm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <348444529BD3CC4E836A044AF0CB71A3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb09ae7-3188-4f68-3fe4-08da226b654e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 01:16:28.2037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7Yqe7+ftJ01gFjLiydtOlzxBLAYP1v4E+klafS2yjiABNiZ/EoLtRCSqwOQTHikczK/Gn9Ks/3xksoqJYf9UoQxQmFInEYHE2UBdKKbT4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10073
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzE5IDIyOjA5LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMTksIDIwMjIgYXQgMDc6NDc6MTNQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IEN1cnJl
bnRseSwgdmZzIG9ubHkgcGFzc2VzIG1vZGUgYXJndW1lbnQgdG8gZmlsZXN5c3RlbSwgdGhlbiB1
c2UgaW5vZGVfaW5pdF9vd25lcigpDQo+PiB0byBzdHJpcCBTX0lTR0lELiBTb21lIGZpbGVzeXN0
ZW0oaWUgZXh0NC9idHJmcykgd2lsbCBjYWxsIGlub2RlX2luaXRfb3duZXINCj4+IGZpcnN0bHks
IHRoZW4gcG9zeGkgYWNsIHNldHVwLCBidXQgeGZzIHVzZXMgdGhlIGNvbnRyYXJ5IG9yZGVyLiBJ
dCB3aWxsIGFmZmVjdA0KPj4gU19JU0dJRCBjbGVhciBlc3BlY2lhbGx5IHdlIGZpbHRlciBTX0lY
R1JQIGJ5IHVtYXNrIG9yIGFjbC4NCj4+DQo+PiBSZWdhcmRsZXNzIG9mIHdoaWNoIGZpbGVzeXN0
ZW0gaXMgaW4gdXNlLCBmYWlsdXJlIHRvIHN0cmlwIHRoZSBTR0lEIGNvcnJlY3RseSBpcw0KPj4g
Y29uc2lkZXJlZCBhIHNlY3VyaXR5IGZhaWx1cmUgdGhhdCBuZWVkcyB0byBiZSBmaXhlZC4gVGhl
IGN1cnJlbnQgVkZTIGluZnJhc3RydWN0dXJlDQo+PiByZXF1aXJlcyB0aGUgZmlsZXN5c3RlbSB0
byBkbyBldmVyeXRoaW5nIHJpZ2h0IGFuZCBub3Qgc3RlcCBvbiBhbnkgbGFuZG1pbmVzIHRvDQo+
PiBzdHJpcCB0aGUgU0dJRCBiaXQsIHdoZW4gaW4gZmFjdCBpdCBjYW4gZWFzaWx5IGJlIGRvbmUg
YXQgdGhlIFZGUyBhbmQgdGhlIGZpbGVzeXN0ZW1zDQo+PiB0aGVuIGRvbid0IGV2ZW4gbmVlZCB0
byBiZSBhd2FyZSB0aGF0IHRoZSBTR0lEIG5lZWRzIHRvIGJlIChvciBoYXMgYmVlbiBzdHJpcHBl
ZCkgYnkNCj4+IHRoZSBvcGVyYXRpb24gdGhlIHVzZXIgYXNrZWQgdG8gYmUgZG9uZS4NCj4+DQo+
PiBWZnMgaGFzIGFsbCB0aGUgaW5mbyBpdCBuZWVkcyAtIGl0IGRvZXNuJ3QgbmVlZCB0aGUgZmls
ZXN5c3RlbXMgdG8gZG8gZXZlcnl0aGluZw0KPj4gY29ycmVjdGx5IHdpdGggdGhlIG1vZGUgYW5k
IGVuc3VyaW5nIHRoYXQgdGhleSBvcmRlciB0aGluZ3MgbGlrZSBwb3NpeCBhY2wgc2V0dXANCj4+
IGZ1bmN0aW9ucyBjb3JyZWN0bHkgd2l0aCBpbm9kZV9pbml0X293bmVyKCkgdG8gc3RyaXAgdGhl
IFNHSUQgYml0Lg0KPj4NCj4+IEp1c3Qgc3RyaXAgdGhlIFNHSUQgYml0IGF0IHRoZSBWRlMsIGFu
ZCB0aGVuIHRoZSBmaWxlc3lzdGVtcyBjYW4ndCBnZXQgaXQgd3JvbmcuDQo+Pg0KPj4gQWxzbywg
dGhlIGlub2RlX3NnaWRfc3RyaXAoKSBhcGkgc2hvdWxkIGJlIHVzZWQgYmVmb3JlIElTX1BPU0lY
QUNMKCkgYmVjYXVzZQ0KPj4gdGhpcyBhcGkgbWF5IGNoYW5nZSBtb2RlLg0KPj4NCj4+IE9ubHkg
dGhlIGZvbGxvd2luZyBwbGFjZXMgdXNlIGlub2RlX2luaXRfb3duZXINCj4+ICINCj4+IGFyY2gv
cG93ZXJwYy9wbGF0Zm9ybXMvY2VsbC9zcHVmcy9pbm9kZS5jOiAgICAgIGlub2RlX2luaXRfb3du
ZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9kZSB8IFNfSUZESVIpOw0KPj4gYXJjaC9w
b3dlcnBjL3BsYXRmb3Jtcy9jZWxsL3NwdWZzL2lub2RlLmM6ICAgICAgaW5vZGVfaW5pdF9vd25l
cigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlIHwgU19JRkRJUik7DQo+PiBmcy85cC92
ZnNfaW5vZGUuYzogICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBO
VUxMLCBtb2RlKTsNCj4+IGZzL2Jmcy9kaXIuYzogICBpbm9kZV9pbml0X293bmVyKCZpbml0X3Vz
ZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gZnMvYnRyZnMvaW5vZGUuYzogICAgICAgaW5v
ZGVfaW5pdF9vd25lcihtbnRfdXNlcm5zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+IGZzL2J0cmZz
L3Rlc3RzL2J0cmZzLXRlc3RzLmM6ICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBp
bm9kZSwgTlVMTCwgU19JRlJFRyk7DQo+PiBmcy9leHQyL2lhbGxvYy5jOiAgICAgICAgICAgICAg
IGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+PiBm
cy9leHQ0L2lhbGxvYy5jOiAgICAgICAgICAgICAgIGlub2RlX2luaXRfb3duZXIobW50X3VzZXJu
cywgaW5vZGUsIGRpciwgbW9kZSk7DQo+PiBmcy9mMmZzL25hbWVpLmM6ICAgICAgICBpbm9kZV9p
bml0X293bmVyKG1udF91c2VybnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gZnMvaGZzcGx1cy9p
bm9kZS5jOiAgICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBt
b2RlKTsNCj4+IGZzL2h1Z2V0bGJmcy9pbm9kZS5jOiAgICAgICAgICAgaW5vZGVfaW5pdF9vd25l
cigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+IGZzL2pmcy9qZnNfaW5vZGUu
YzogICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIHBhcmVudCwgbW9k
ZSk7DQo+PiBmcy9taW5peC9iaXRtYXAuYzogICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3Vz
ZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gZnMvbmlsZnMyL2lub2RlLmM6ICAgICAgaW5v
ZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+IGZzL250
ZnMzL2lub2RlLmM6ICAgICAgIGlub2RlX2luaXRfb3duZXIobW50X3VzZXJucywgaW5vZGUsIGRp
ciwgbW9kZSk7DQo+PiBmcy9vY2ZzMi9kbG1mcy9kbG1mcy5jOiAgICAgICAgIGlub2RlX2luaXRf
b3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIE5VTEwsIG1vZGUpOw0KPj4gZnMvb2NmczIvZGxt
ZnMvZGxtZnMuYzogaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgcGFyZW50
LCBtb2RlKTsNCj4+IGZzL29jZnMyL25hbWVpLmM6ICAgICAgIGlub2RlX2luaXRfb3duZXIoJmlu
aXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+PiBmcy9vbWZzL2lub2RlLmM6ICAgICAg
ICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBOVUxMLCBtb2RlKTsNCj4+
IGZzL292ZXJsYXlmcy9kaXIuYzogICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywg
aW5vZGUsIGRlbnRyeS0+ZF9wYXJlbnQtPmRfaW5vZGUsIG1vZGUpOw0KPj4gZnMvcmFtZnMvaW5v
ZGUuYzogICAgICAgICAgICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2Rl
LCBkaXIsIG1vZGUpOw0KPj4gZnMvcmVpc2VyZnMvbmFtZWkuYzogICAgaW5vZGVfaW5pdF9vd25l
cigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+IGZzL3N5c3YvaWFsbG9jLmM6
ICAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9kZSk7
DQo+PiBmcy91Ymlmcy9kaXIuYzogaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9k
ZSwgZGlyLCBtb2RlKTsNCj4+IGZzL3VkZi9pYWxsb2MuYzogICAgICAgIGlub2RlX2luaXRfb3du
ZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+PiBmcy91ZnMvaWFsbG9jLmM6
ICAgICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUp
Ow0KPj4gZnMveGZzL3hmc19pbm9kZS5jOiAgICAgICAgICAgICBpbm9kZV9pbml0X293bmVyKG1u
dF91c2VybnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gZnMvem9uZWZzL3N1cGVyLmM6ICAgICAg
aW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgcGFyZW50LCBTX0lGRElSIHwg
MDU1NSk7DQo+PiBrZXJuZWwvYnBmL2lub2RlLmM6ICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0
X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gbW0vc2htZW0uYzogICAgICAgICAgICAg
aW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+ICIN
Cj4+DQo+PiBUaGV5IGFyZSB1c2VkIGluIGZpbGVzeXN0ZW0gaW5pdCBuZXcgaW5vZGUgZnVuY3Rp
b24gYW5kIHRoZXNlIGluaXQgaW5vZGUgZnVuY3Rpb25zIGFyZSB1c2VkDQo+PiBieSBmb2xsb3dp
bmcgb3BlcmF0aW9uczoNCj4+IG1rZGlyDQo+PiBzeW1saW5rDQo+PiBta25vZA0KPj4gY3JlYXRl
DQo+PiB0bXBmaWxlDQo+PiByZW5hbWUNCj4+DQo+PiBXZSBkb24ndCBjYXJlIGFib3V0IG1rZGly
IGJlY2F1c2Ugd2UgZG9uJ3Qgc3RyaXAgU0dJRCBiaXQgZm9yIGRpcmVjdG9yeSBleGNlcHQgZnMu
eGZzLmlyaXhfc2dpZF9pbmhlcml0Lg0KPj4gQnV0IHdlIGV2ZW4gY2FsbCBpdCBpbiBkb19ta2Rp
cmF0KCkgc2luY2UgaW5vZGVfc2dpZF9zdHJpcCgpIHdpbGwgc2tpcCBkaXJlY3RvcmllcyBhbnl3
YXkuIFRoaXMgd2lsbA0KPj4gZW5mb3JjZSB0aGUgc2FtZSBvcmRlcmluZyBmb3IgYWxsIHJlbGV2
YW50IG9wZXJhdGlvbnMgYW5kIGl0IHdpbGwgbWFrZSB0aGUgY29kZSBtb3JlIHVuaWZvcm0gYW5k
DQo+PiBlYXNpZXIgdG8gdW5kZXJzdGFuZCBieSB1c2luZyBuZXcgaGVscGVyIHByZXBhcmVfbW9k
ZSgpLg0KPj4NCj4+IHN5bWxpbmsgYW5kIHJlbmFtZSBvbmx5IHVzZSB2YWxpZCBtb2RlIHRoYXQg
ZG9lc24ndCBoYXZlIFNHSUQgYml0Lg0KPj4NCj4+IFdlIGhhdmUgYWRkZWQgaW5vZGVfc2dpZF9z
dHJpcCBhcGkgZm9yIHRoZSByZW1haW5pbmcgb3BlcmF0aW9ucy4NCj4+DQo+PiBJbiBhZGRpdGlv
biB0byB0aGUgYWJvdmUgc2l4IG9wZXJhdGlvbnMsIGZvdXIgZmlsZXN5c3RlbXMgaGFzIGEgbGl0
dGxlIGRpZmZlcmVuY2UNCj4+IDEpIGJ0cmZzIGhhcyBidHJmc19jcmVhdGVfc3Vidm9sX3Jvb3Qg
dG8gY3JlYXRlIG5ldyBpbm9kZSBidXQgdXNlZCBub24gU0dJRCBiaXQgbW9kZSBhbmQgY2FuIGln
bm9yZQ0KPj4gMikgb2NmczIgcmVmbGluayBmdW5jdGlvbiBzaG91bGQgYWRkIGlub2RlX3NnaWRf
c3RyaXAgYXBpIG1hbnVhbGx5IGJlY2F1c2Ugd2UgZG9uJ3QgYWRkIGl0IGluIHZmcw0KPj4gMykg
c3B1ZnMgd2hpY2ggZG9lc24ndCByZWFsbHkgZ28gaHJvdWdoIHRoZSByZWd1bGFyIFZGUyBjYWxs
cGF0aCBiZWNhdXNlIGl0IGhhcyBzZXBhcmF0ZSBzeXN0ZW0gY2FsbA0KPj4gc3B1X2NyZWF0ZSwg
YnV0IGl0IHQgb25seSBhbGxvd3MgdGhlIGNyZWF0aW9uIG9mIGRpcmVjdG9yaWVzIGFuZCBvbmx5
IGFsbG93cyBiaXRzIGluIDA3NzcgYW5kIGNhbiBpZ25vcmUNCj4+IDQpYnBmIHVzZSB2ZnNfbWtv
YmogaW4gYnBmX29ial9kb19waW4gd2l0aCAiU19JRlJFRyB8ICgoU19JUlVTUiB8IFNfSVdVU1Ip
JiAgfmN1cnJlbnRfdW1hc2soKSkgbW9kZSBhbmQNCj4+IHVzZSBicGZfbWtvYmpfb3BzIGluIGJw
Zl9pdGVyX2xpbmtfcGluX2tlcm5lbCB3aXRoIFNfSUZSRUcgfCBTX0lSVVNSOyAsIHNvIGJwZiBp
cyBhbHNvIG5vdCBhZmZlY3RlZA0KPj4NCj4+IFRoaXMgcGF0Y2ggYWxzbyBjaGFuZ2VkIGdycGlk
IGJlaGF2aW91ciBmb3IgZXh0NC94ZnMgYmVjYXVzZSB0aGUgbW9kZSBwYXNzZWQgdG8gdGhlbSBt
YXkgYmVlbg0KPj4gY2hhbmdlZCBieSBpbm9kZV9zZ2lkX3N0cmlwLg0KPj4NCj4+IEFsc28gYXMg
Q2hyaXN0aWFuIEJyYXVuZXIgc2FpZCINCj4+IFRoZSBwYXRjaCBpdHNlbGYgaXMgdXNlZnVsIGFz
IGl0IHdvdWxkIG1vdmUgYSBzZWN1cml0eSBzZW5zaXRpdmUgb3BlcmF0aW9uIHRoYXQgaXMgY3Vy
cmVudGx5IGJ1cnJpZWQgaW4NCj4+IGluZGl2aWR1YWwgZmlsZXN5c3RlbXMgaW50byB0aGUgdmZz
IGxheWVyLiBCdXQgaXQgaGFzIGEgZGVjZW50IHJlZ3Jlc3Npb24gIHBvdGVudGlhbCBzaW5jZSBp
dCBtaWdodCBzdHJpcA0KPj4gZmlsZXN5c3RlbXMgdGhhdCBoYXZlIHNvIGZhciByZWxpZWQgb24g
Z2V0dGluZyB0aGUgU19JU0dJRCBiaXQgd2l0aCBhIG1vZGUgYXJndW1lbnQuIFNvIHRoaXMgbmVl
ZHMgYSBsb3QNCj4+IG9mIHRlc3RpbmcgYW5kIGxvbmcgZXhwb3N1cmUgaW4gLW5leHQgZm9yIGF0
IGxlYXN0IG9uZSBmdWxsIGtlcm5lbCBjeWNsZS4iDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBEYXZl
IENoaW5uZXI8ZGF2aWRAZnJvbW9yYml0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHU8
eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPg0KPiBJIHRoaW5rIHdlJ3JlIGdl
dHRpbmcgY2xvc2VyIGJ1dCBwbGVhc2UgZm9jdXMgdGhlIHBhdGNoIHNlcmllcy4gVGhpcyBoYXMN
Cj4gbW9ycGhlZCBpbnRvIGFuIDggcGF0Y2ggc2VyaWVzIHdoZXJlIDQgb3IgNSBvZiB0aGVzZSBw
YXRjaGVzIGFyZSBmaXhlcw0KPiB0aGF0IGEpIEknbSBub3Qgc3VyZSBhcmUgd29ydGggaXQgb3Ig
Zml4IGFueXRoaW5nIGIpIHRoZXkgYXJlIGZpbGVzeXN0ZW0NCj4gc3BlY2lmaWMgYW5kIGNhbiBi
ZSBpbmRlcGVuZGVudGx5IHVwc3RyZWFtZWQgYW5kIGMpIGhhdmUgbm90aGluZyB0byBkbw0KPiB3
aXRoIHRoZSBjb3JlIG9mIHRoaXMgcGF0Y2ggc2VyaWVzLg0KPg0KPiBTbyBJJ2Qgc3VnZ2VzdCB5
b3UnZCBqdXN0IG1ha2UgdGhpcyBhYm91dCBzZ2lkIHN0cmlwcGluZyBhbmQgdGhlbiB0aGlzDQo+
IGRvZXNuJ3QgaGF2ZSB0byBiZSBtb3JlIHRoYW4gMyBtYXliZSA0IHBhdGNoZXMsIGltaG8uDQpP
aywgd2lsbCBmb2N1cyBvbiB0aGlzIHNnaWQgc3RyaXBwaW5nLg0K
