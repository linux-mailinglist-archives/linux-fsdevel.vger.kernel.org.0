Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27210507E03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 03:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358695AbiDTBSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 21:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348369AbiDTBSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:18:08 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586A41D0EB;
        Tue, 19 Apr 2022 18:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650417323; x=1681953323;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=upUBr+KN3eH6eLSrc8P5xV6BhelVmGypneby0Vzs5tw=;
  b=axYEXcOsCbS8lFbGBvNAyvVAQTQS6lGp+eaxKAeS4Be/Bz3mdgC06h6+
   sZVL/DORu2rNF7mL48KJOwgR49tYjaF9jLD5UBkgqRn34JmZwh8vXqUu5
   ISeZbkuCxMWcBj8khsqpAmrVCbCt/G5egwIXCLqDDF2jNm5q06h2HgCZg
   +LvbVz/jsH5EmeIOV+siPJTUHV9Uwuudn2zwxDVqbeUTdDTIO0TfTo07T
   h6J6L5XfDJrvhEAuWg0ryHPUXCpyDEv/n9lsufKAVzWQXTC18a9R2ExaO
   ml51mxmEZW+fY4OomkGspM5SGLrcGdZqutKVw5dXo8/+wjb9qaeaeGEMc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="62450015"
X-IronPort-AV: E=Sophos;i="5.90,274,1643641200"; 
   d="scan'208";a="62450015"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:15:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsXaWDhEiBb861MXoOuesKuvClc8frK1hL3Ub7lXu67x7Q4bWNe5j5CoOgoZr+RC1By8u4mNKYY/lQSvzajfavMlTTQphgDld74cAzA23ASBhGWrfzVrSfieiHFf37Zhy2XuAECVcBTlZVWeWMhsQRspHAGhkEnIIi2lF8y+91e9go1mw40TQKMHuaWMip6dSn2RWSoIl3ZyUhzU/zyLcvLT8PfaZBTHTn3cILEAiQIV61K28cvqBPv9zSH1qi+zihyBXo6yHHGmyjYMG3OcfblwbCntLbU2c70KUdbdPm+4Gg98NvuMg59drTh3OS967sEHrrnH5RKgiKq62LAM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upUBr+KN3eH6eLSrc8P5xV6BhelVmGypneby0Vzs5tw=;
 b=DaOUYVzrRyDE7YurQsLR01wW7fehzLngysp1Cul3p/udh14EInmm9pnodunOdFVqvUFuCAQtEN/Vc6PPN8OJCwT9cOtzO+QuUtgV70iVZ2+mF9RgXUsqMuhu7pTrI1vRTZyYAqnmh7DmlSBfqyVthTFPScfSiH1ElWKSPEiFG569YZOihvMIdpNF+zZLy4qP69eXwTCQCL4f2Ip/exWxoYmosKe9yYPwJUSV7oqgPXcyDGCgYDioTrzC3GyMrvb67o2hW5q0iPhB+L0ZavdL138VDeIerD5+98W/iMcWOz08jVKmR9n3HOd/HNQezGFmTFoWnlQtOaMnKDtp8gIEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upUBr+KN3eH6eLSrc8P5xV6BhelVmGypneby0Vzs5tw=;
 b=QQUXe7y04Y7xPX0Y6h3/imK/agWvbbpEdXPYEZ98m4jDhfGdO18sbv+uO7oeibJ/J+A9q69fzhLc/E/oau5Juoiyj12SVMnGPe4tUNpv7cXMm46aXvfCWH8EQUu0X+UH0viXU0h3a8kiqRxU8+/6Vc/oc5ZskfB/zQlqxFZo5nI=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB10073.jpnprd01.prod.outlook.com (2603:1096:604:1e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 20 Apr
 2022 01:15:14 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 01:15:14 +0000
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
Subject: Re: [PATCH v4 6/8] ntfs3: Use the same order for acl pointer check in
 ntfs_init_acl
Thread-Topic: [PATCH v4 6/8] ntfs3: Use the same order for acl pointer check
 in ntfs_init_acl
Thread-Index: AQHYU9sMzZ7q+jW9SU2N1QUozq55caz3RMgAgADMy4A=
Date:   Wed, 20 Apr 2022 01:15:14 +0000
Message-ID: <625F6CFD.4000803@fujitsu.com>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650368834-2420-6-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220419140330.jogjwtdzy735j567@wittgenstein>
In-Reply-To: <20220419140330.jogjwtdzy735j567@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4795b91c-9b7a-45c1-6033-08da226b396a
x-ms-traffictypediagnostic: OS3PR01MB10073:EE_
x-microsoft-antispam-prvs: <OS3PR01MB10073B80E936A686D724D3915FDF59@OS3PR01MB10073.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UGqbQv/Q4MjPyjOdTRKJs9xIHaT6xXimadAPxJ9px3uAMFhw+sdPnAzokRG5IjLD0ocFzgXbGCcxccpRNukAq1t0MkZC62CwWxM5CeUQaOAXQ1J4wy8ieWEELwxTeRrd3jBpiHxLZGSyKQw/rNMHHVmtZ1xc2CrnOHhR88uWI/9ZLR2SoSAYVly4buzOinmQMA2/zYziOb0GUqpfoATYF6E6F65SMNqkEB9x4C9eujzNcq/kJMeF6nLpMjS6ZE5XZfyZuMgMzVFK0Kmhn2MleWM2KtzEjg3Z3Q7SuVitZ7ePpKBWCSPH537zg+bIUROqD+i9y+McokwOcoYJ4AlzZbwmC2tjtqCeVgHf4Eh83v3mm/88s2szjgxZ8UX73wvtJXPMmoI1vpyq5GNLg7Wm+Rbo9lriStrt0r0+Cnq+LZyXE2+OSoeON/o0AinQpbtFelig15neSN375fhyMnQQegdECpVKmT0XmMS6hdqU8LXFZkytCceuQsLRr9CPOdsjxRvVqgyOEsZ4g9UTZw78T2hpnsl17CSXkVsVHzR9bcfFtnRDVKQQKBdoUnI2+vgkI7DrDqrX4aXPIs/W0LcRZL5mzTdjFxQ/Pa+vWM2T72a4OEWIe36/npiqyP38dJuIQBT1IYnh5wJn7GouNGn22zPFkkWwE2SbEnekbOa8gaO07+5+8wlcP8WvHdwOd2wbYKeCe5l8oTK8qWIMdbP/FA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(54906003)(6916009)(8936002)(6512007)(87266011)(26005)(2616005)(2906002)(64756008)(8676002)(82960400001)(38070700005)(38100700002)(91956017)(122000001)(6486002)(36756003)(66946007)(6506007)(33656002)(83380400001)(7416002)(85182001)(316002)(66446008)(86362001)(186003)(71200400001)(66476007)(66556008)(76116006)(508600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEltWm1VR0FCaXJqMUtuZ0p0VE1BRnBFOXh4ZHd5cEVHZUpvaUNXbVgvSE9O?=
 =?utf-8?B?RkdzTU1DZW1qdkRvbHlOSmZ5K05MdXlhQ2twWmVMWlo5UTlNVFI4N2hBYllI?=
 =?utf-8?B?MTNRZFRmTUFQNTd6SUVyYUVoYlcybkdOODU5SmkxbUFReEZKN0YzT2w5UkFD?=
 =?utf-8?B?TVBzWVd1aW9LYm1VOHlUWjlRM3N5UWZxdVhDTVc0YVN4Q0ozdmUreFNnMzQ0?=
 =?utf-8?B?T1NCMkpBUzEvdlp3WFE4ai9kbW5RK3hoOGNBZTRBTzZWZ0ZSZnowdGpkcTdh?=
 =?utf-8?B?OStzSUU1QThadEJJdTZpL0dETzZpYkFKeU9XeVRaOGZkSGFoOWNBRTFEWnRj?=
 =?utf-8?B?eVdzTWM0WjJER3VFNjJKNXA4T3c5Z0Z4R2pBdVZETWxUMGVGOGJ4SHYyWlV6?=
 =?utf-8?B?eHNySlB2QS9NODlGbzBkdEJVTGorVkdZNEpueW9jb0VEUXEvc0NyVFpacm9U?=
 =?utf-8?B?UWZPZDFqZVBCMW85ZlkvVnZvWWtoRy9CZG1RT042eWpMY1FLSWJGR0YrNHVJ?=
 =?utf-8?B?OGl6dmhWeEJBNlhrelNoQVg4YlhGQ25sLzlNcTEwZ3YrRzhmYmxycFM1OFVr?=
 =?utf-8?B?TEdtQms0WFVKbXlkcU5YQ3lDY3N3NFRVL3F5TW1WYUIvZFRraVNOVlFncW90?=
 =?utf-8?B?OEphNnJ6TzJDWHRVajkyK1JRZW9mZWdpQW5NZzBVdVUzditpdkJ6WVhPM25L?=
 =?utf-8?B?djZzQjkvYnhVM2xocm1lQlQ5TXUvQmJ6NnJBQmlFWCtGclNaTmh5RTFzUlZN?=
 =?utf-8?B?d002RVNyVHJrNlROTjZzRXJoOGtGZTIzODAyZ29Dd2F4R3N6VWR1UGdvS3Zn?=
 =?utf-8?B?Tk52cXIvYWFRM1pjQmpidU1qZWR2VktYYkR3L1RuUkZnWmRaTDJVK3E4bWhV?=
 =?utf-8?B?K1BBa0t4VHVtMHVJejBiaGFDSkFCK21tZStNaVR2Vjd6MUhLSXVnN0krcDh0?=
 =?utf-8?B?WWh4bUtESUtUbGJXNUtaUUFBaUpQWTNsZnVYaGtvSW4wNEdTWWk1NE5TUGFV?=
 =?utf-8?B?bmJ5b25tUWNmTldUclVpQkE3aU1QV1ArTjRzYXh2S3JibVhFYnJrNEsxamJm?=
 =?utf-8?B?dGNnQU1jbXNFZFIwVXZRZTdoRmoxVVFxc29tdzhLWkVhT1hmWW9ESTQ5QWU5?=
 =?utf-8?B?bnNqeVRUVDZSMzR0TEtjdlQ5dW5DK20rdndTcHZOWExlN1VRMmJwODc4TzVh?=
 =?utf-8?B?RlpHNUJpQkpobm9yTEFEUFZ3RTJ5N3BWRkg5M0N5SGlEdXlqTElGZkt6aHRs?=
 =?utf-8?B?cWVBcFBvUHo1OTVDbFFRNHVoRFFSOFkxRDRJMzZva0dWeWtTOWFSaU9Bb1NK?=
 =?utf-8?B?NXF4dHVhMzVncVJKdjBHNFZZY2VZSGx3VEhiUUVhbDBKSmdqaXJrOWgrQTF5?=
 =?utf-8?B?UUhqYXRiZisrUU0xZG80TTkvRDhBYkpJRC9IcGQxVHY3dkJuL0xhNjJkK3o3?=
 =?utf-8?B?alRTTWhPbjV4M2l6ejIwUFNFM2hjR2JwVUNGNmZpVG1YaWRsVVVKbjhqQWNt?=
 =?utf-8?B?VnNnbXk0Z0QyeUNKc0NSTVJjTk9vT1drVXJFUGZXeERXWWlKall2UTgxWWx6?=
 =?utf-8?B?UGRMbjcvQnVoSmtPNVJ1b2xSK3RrQm96ek5LSUJzUzZIOE1aa280VFFpL0s2?=
 =?utf-8?B?aVFZRUhqVmxoQ1owREg3WmVjbG0yRURvZklwcWh5Q0RSOCtNRElld3hVVTNK?=
 =?utf-8?B?ZFdDeS9sMFpnUTI1VW5INUFleS9xVnNJR0lYSFJNSWpKckNoam5yN2p4ZWdP?=
 =?utf-8?B?V29xQlRUem5EdEFmczZ1a21DWlFWTHp6K3hQVDgzRUpsOEs2dGVzU0FBekhD?=
 =?utf-8?B?N2JVZ1lKZ3NiVFJwN1dQaDhZQjRhODVZalk2djN6cVBuWVQ0MFlUZ0gzeDg5?=
 =?utf-8?B?eTRnd3A1Ty9MNnBzNWFTeUh6MWlBSUF3SnY4SzRITXp5SkdoaW1oMlhMTnlT?=
 =?utf-8?B?WWsvck1yMm5iV2FGODUzbk54cFYrTlVUYlJ0ZUlxOUhHbFYyZXlaTWhTcHBD?=
 =?utf-8?B?YjkzNEZaV3h3bUpBS1Jubkw2bXNjYXNBaWw1TDVlS05qeEZkR0NkakJqTk1m?=
 =?utf-8?B?UG1IbDIwRm1KODU0cDB2WWFUYkluTFA5ZHF2YjhudXFnNVpnblZXbGNYbHI4?=
 =?utf-8?B?ZkExZWlhUit1WTVXZXlUSWF0V3dEVXZ5UDVOQ1pZb1AyNlhySTJUQUFOT1Jq?=
 =?utf-8?B?MUl6T0dzS2RhQlVyUVA1bHNpR1IvTDVQSVhVNFhuTWxraS83ZUhJV1M1cXJU?=
 =?utf-8?B?WTNnWFNVazNCWjVPOVlSYy9lV0FyU0hRZlZESkp2QkVjR0ZoTW8zVlpWTnRO?=
 =?utf-8?B?bm9iMnV1ZlF0bksrV2hVelNzcUs5NmFWS1p4eG11KzVqSTJ2MXVLUmowRGM3?=
 =?utf-8?Q?qhQj+6lpRTTcPvMqqVLtToL1fkj1rKtO4OQi1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB0F22C109A815419E991B16D02BDE31@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4795b91c-9b7a-45c1-6033-08da226b396a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 01:15:14.5839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6q0t/3ghIZZgc3OCA/umixVspUVwhrTjbuNrN2qdLX5mVjuouLOg5srTgE5Tpm9hSFnmd7hduaxMjBAuyygkJmUJweeuohM+hvYVfU+Yxwo=
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

b24gMjAyMi80LzE5IDIyOjAzLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMTksIDIwMjIgYXQgMDc6NDc6MTJQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IExpa2Ug
ZXh0NCBhbmQgb3RoZXIgdXNlICR7ZnN9X2luaXRfYWNsIGZpbGVzeXN0ZW0sIHRoZXkgYWxsIHVz
ZWQgdGhlIGZvbGxvd2luZw0KPj4gc3R5bGUNCj4+DQo+PiAgICAgICAgIGVycm9yID0gcG9zaXhf
YWNsX2NyZWF0ZShkaXIsJmlub2RlLT5pX21vZGUsJmRlZmF1bHRfYWNsLCZhY2wpOw0KPj4gICAg
ICAgICBpZiAoZXJyb3IpDQo+PiAgICAgICAgICAgICAgICAgIHJldHVybiBlcnJvcjsNCj4+DQo+
PiAgICAgICAgICBpZiAoZGVmYXVsdF9hY2wpIHsNCj4+ICAgICAgICAgICAgICAgICAgZXJyb3Ig
PSBfX2V4dDRfc2V0X2FjbChoYW5kbGUsIGlub2RlLCBBQ0xfVFlQRV9ERUZBVUxULA0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlZmF1bHRfYWNsLCBYQVRUUl9D
UkVBVEUpOw0KPj4gICAgICAgICAgICAgICAgICBwb3NpeF9hY2xfcmVsZWFzZShkZWZhdWx0X2Fj
bCk7DQo+PiAgICAgICAgICB9IGVsc2Ugew0KPj4gICAgICAgICAgICAgICAgICBpbm9kZS0+aV9k
ZWZhdWx0X2FjbCA9IE5VTEw7DQo+PiAgICAgICAgICB9DQo+PiAgICAgICAgICBpZiAoYWNsKSB7
DQo+PiAgICAgICAgICAgICAgICAgIGlmICghZXJyb3IpDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgZXJyb3IgPSBfX2V4dDRfc2V0X2FjbChoYW5kbGUsIGlub2RlLCBBQ0xfVFlQRV9BQ0NF
U1MsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBh
Y2wsIFhBVFRSX0NSRUFURSk7DQo+PiAgICAgICAgICAgICAgICAgIHBvc2l4X2FjbF9yZWxlYXNl
KGFjbCk7DQo+PiAgICAgICAgICB9IGVsc2Ugew0KPj4gICAgICAgICAgICAgICAgICBpbm9kZS0+
aV9hY2wgPSBOVUxMOw0KPj4gICAgICAgICAgfQ0KPj4gCS4uLg0KPj4NCj4+IFNvIGZvciB0aGUg
cmVhZGFiaWxpdHkgYW5kIHVuaXR5IG9mIHRoZSBjb2RlLCBhZGp1c3QgdGhpcyBvcmRlci4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+
PiAtLS0NCj4NCj4gQWdhaW4sIHRoaXMgcGF0Y2ggaXMgaXJyZWxldmFudCB0byB0aGUgbWFpbiBk
cml2ZSBvZiB0aGlzIHBhdGNoIHNlcmllcw0KPiBhbmQgaXQncyBzZW5zaXRpdmUgZW5vdWdoIGFz
IGl0IGlzLiBKdXN0IGRyb3AgaXQgZnJvbSB0aGlzIHNlcmllcyBhbmQNCj4gdXBzdHJlYW0gaXQg
c2VwYXJhdGVseSB0byB0aGUgcmVsZXZhbnQgZmlsZXN5c3RlbSBpbWhvLg0KT0ssIHdpbGwgZG8u
