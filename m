Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C474504B35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 05:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiDRDPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 23:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbiDRDP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:15:28 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DA613E91;
        Sun, 17 Apr 2022 20:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650251571; x=1681787571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+KOfZFdBmAsvuqFfD0ff5Lt47/t6cbvs+OBimtnuwK8=;
  b=zkcuiQ5MDx5orOvha6yejIhplRGXTrl0REC4Vz/CJVzHAeiknyeUGdsQ
   4Rl2zf5hZKMVAoVDZ9HQhbZEXZuV36JYqCrZps6ZGw/eMhWoH52TPBLfS
   XAN8Td2vvG670a7OJBPm8h7Lug+Ke8XSgpVqQP7vlrDtpJyoNwCQeTdyp
   2jvChaEEgOXvG+RwAOThMSMrzyjVV1kqmvitLMrpiJ6+a5Mlt7fESiNur
   t4Vig4HWuwxQsEyu6Ne79ADDg5l8qPciUGl81JiDCDowWzIbwTqbWs+am
   klglH91Xg19baBQYw3wKrTqzrKQaYtDoCLLj87D2yEqzGLIUzL5SxKe+9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="53913095"
X-IronPort-AV: E=Sophos;i="5.90,267,1643641200"; 
   d="scan'208";a="53913095"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 12:12:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLaNeY+qdmv2xEPO/07m+8VZ5nrnIIsk/T9kZxEwH0GSzRcLAVpMIAmn1G+3gwFcAvc0+vt5T3VEX8zN53UJ/WS0oA3IBRHKli7XI77FLMVTIpv1kT03MhhA/B76hrwsjegw0lmrAUEPB9PUcqT6eQ9dmwZ+8O7IfCRPRYa8eWfWRsM185+GqZR47XqffJdUMxg+r5q20ed3/GzMvI3VwvqTT6r3hyeiX3iWihbYLEbq9zYS9tTvu+yQ3QzT10Bxxwu1/i4Rw/jl+/ljBJ2/hvQogcV3M4CFORsQy+Kbvxv2fPT4LeJR+ssHDIV0mc26Aqsv4BX5ULAkjab53Mn1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KOfZFdBmAsvuqFfD0ff5Lt47/t6cbvs+OBimtnuwK8=;
 b=PG8YHCnAJtCfNQkrl7amp/BTAjEQw6AhnpwGxhNf4UUNwVuczTqERJI6mu69Xx9UcYq+gGhbJDveFimNA9D4GLE+ZzSnNC+u4Ti9PVl9oVTYz4b1bgI/OvjJGRKlAFF/SMaT8AH4ycVhLsJDowwtJvV1wd2pLBvzu7SaIqAj3DFKCXZqbl4N9HF2ut/dIQjI6UQ24lsuJJ/e/5bxl+pQY4F1P/eBcSJMglv4/uiCmXCTiISo9MNHdFWNATTRhCAaoiXM9tQ0f+4w5b/HqZWp63sF1y1TogjJ3wnvhGBAc7fZz6uRBkNd4pIg4UZsMwuAqIT2gBO38IBVhDCqusfX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KOfZFdBmAsvuqFfD0ff5Lt47/t6cbvs+OBimtnuwK8=;
 b=GnoHgPaVyF2FT2rzdBdARPyO0hfqfzfNQZAq8ekSdTIavrQxmvuqU3EK1qp1luz7Vf50l42u1lDawywuZVvU29acs2hS3WSHzrrHqjKaUCUhPKPxjISq0G1oyYMjYo61bzkeL+Gd8XrRoc8F9ReC+B6+rCGor/aRRqd7dm+H+zw=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB3907.jpnprd01.prod.outlook.com (2603:1096:604:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 03:12:41 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 03:12:41 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Xiubo Li <xiubli@redhat.com>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v3 7/7] ceph: Remove S_ISGID clear code in
 ceph_finish_async_create
Thread-Topic: [PATCH v3 7/7] ceph: Remove S_ISGID clear code in
 ceph_finish_async_create
Thread-Index: AQHYULA5Wjdkot1KzUWwZT2y9D0qY6z1AJaAgAATdIA=
Date:   Mon, 18 Apr 2022 03:12:41 +0000
Message-ID: <625CE57F.7050501@fujitsu.com>
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650020543-24908-7-git-send-email-xuyang2018.jy@fujitsu.com>
 <c26f5638-b97e-babf-3177-99fbcd4bbec2@redhat.com>
In-Reply-To: <c26f5638-b97e-babf-3177-99fbcd4bbec2@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 404652f0-18f2-48f3-ca9e-08da20e94ce0
x-ms-traffictypediagnostic: OSAPR01MB3907:EE_
x-microsoft-antispam-prvs: <OSAPR01MB3907823DFB6D075B83D8CE9BFDF39@OSAPR01MB3907.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FGbR/G56FKrFacx/UF2gWyF0SJGS56wsd277WP8IsvnSh5Hq3bX5e2uJX3Oqd5rsl5x8+neVG5fp11lsxgc1vh9E+Hk9iaL1xQfbNF0UJfopE7wwmZaQ8Dxlaf7yfjOexOphS4SdwBTL9ThpL0qk7MVWrm3i/1e2NRni8ddDPNFC9ITIfbrTqqC2UFj941Mqcr6MZv0I31/2WpLymFy57bHhxPnXBSykeEk0DYDYXy5ydN67IxSKzy+ZvUzzAGijmBYKdBW3MkNzoBrFK52+rjdNuJ7qB8LBGfEe6dsYV3yH3G8DDhQxS3sby5BEkHOZUjTgBGx5pyf1tZ7z4pCLcSonu9m+Vcn0QCQ8AVLjgaypqPK/PWLEBxlW05qBNB4ST8eQnk1X9q1sVmbhwJUTXa7TGODc/JfvNyqnopA0Gt2BVA2rJNMaWHr5r8WBbs1QbdlX4T7TzJW3GHk06AfVwm8YMM2z+ea07sd6TpnAz2RKQbLxcPijVVYLFNs62rFllxzcSZyGmoYuIxHjEsxkGwFz8Pyclud1UhQllIIv8m6MS/lyoBpjeuXntrusqMG+7KXy1Pp5M/OpDeKUuyOReVwwE/pkEogLuJpPUfjPZxv9poGY67KRlBL0LkQiMJB+N4g4hpqD1zUQvY7WmfLvFBc+GVwNDgbC5YfXROnb1XirjMOjNNNIMZr32BXu/c+kZdL63KjET634gV8gVCOCKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(86362001)(66946007)(66556008)(64756008)(76116006)(66476007)(82960400001)(8676002)(85182001)(66446008)(4326008)(8936002)(2906002)(5660300002)(7416002)(83380400001)(91956017)(38100700002)(38070700005)(87266011)(36756003)(53546011)(316002)(54906003)(6916009)(508600001)(2616005)(122000001)(6486002)(6512007)(6506007)(26005)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUs5QTEyWXZiVkZHYUZqQktTQVhHNXFnZHE0YnZsNlRrWWZxSmphVXpQK29v?=
 =?utf-8?B?RDZxU1pVMHFQaXVwVW9Nb0tsc3E2S1hjZWZhcDNiSENlczVUNXpQWmY1YS9H?=
 =?utf-8?B?SUxTYVBvUzhmTU04a3BtdklWV29RUTdLWlQrRGNGaE1Ld2dicy9CbG8yMUZR?=
 =?utf-8?B?dEpPb2JNZThLYjlKR25vTDlyMmZxd3pFYnNuL3Jna1dHbE5rbm9kdkdUcnNZ?=
 =?utf-8?B?SUZsS2U0a3FaYjlrRGFTcWpFVzBPWk4zbVZWZnVOSGRwRUVDcWdpRDBPeFRZ?=
 =?utf-8?B?eUZXblJrdGtlQkxMSE04bUlwbklNalFKSmxKbnc5NzBub2NMMS9wMjFtTE4w?=
 =?utf-8?B?NGlXWk16L3FIQ0ZnaUE4NDZFU3lBQ1FCaldSbS9VSUdwaEt0S2wxY2N3d2Yv?=
 =?utf-8?B?R2xrWCtoRWRZbzd4NUpjNVJzZTg4OVpzWDdxZVhjWWp3VGowajhxanI3b2hk?=
 =?utf-8?B?RmhGNHRGNUdadkJmbFNVMnl5UXd5cHNCN0VpejBYWkp5eldVOWdwVHlXWWUw?=
 =?utf-8?B?WHZlMHYwcHNRR3k5b1MySmdtaEVDc3pvTkdsamxXTE5sUmdrTXBFTk1jalFy?=
 =?utf-8?B?UUdhekw3K2V5TWRVUkJsSWxFN2tYV2lDeUJJcytzZVNlS05VVkozMEFUWUtx?=
 =?utf-8?B?cEhDL3pmNXZwN0x2bmpLUm1LNXBySVZNZkh6RHJmMmJMWnB3MGlxSjdNRFFF?=
 =?utf-8?B?aEhNZ1VlSDRRUkZ4RmlUd25jeHgyRnk5ZVR6Y2xCSW5iN1BnZnlYRFRPSVgw?=
 =?utf-8?B?WHlmdEowZjBTRXhmMDhBamJVb0F5cEJjNVZWaFF3a1lrSWJZRXJWSWVlSmww?=
 =?utf-8?B?blRBYksrbW40bm00NDY5TFREb0d5S1JFMGF2VThhS2w2RXhQeHlUZjA2Q2Jn?=
 =?utf-8?B?Q3RydWpSZDVRZ1IvdjFWMDkwT0taZWtTcXlIZ2U0bGRvN2hJSjdoeTlRb1Y2?=
 =?utf-8?B?UGNUakpYMllCWGtNT0E2bzNIS2tLeXBGcXRIZVdteEJDaFZ3cHQ5YkNjR2Y2?=
 =?utf-8?B?NVpmbStWN1NQWEF6WXlRRFhOUmNpQzBpS1AwS3VtWVNzQlpXZzZ6S1hzWkIz?=
 =?utf-8?B?OEFUZ2xCK0p6dXQzdUhqaGMwbjI3U3Mwb2xyQ00xMmtzcXFRQ01rVHlia1kr?=
 =?utf-8?B?emdsNHFncEVDMk04a2pGOHhDb1g2K05FdXFNbUZYZEZqZXRVTGVkTm9KNTh0?=
 =?utf-8?B?TFBnc3hyQzBJK1g1TmhvQndERUI2a2NHNEF2SkpIaVJ2YXdFSVl0L0U0V3Q3?=
 =?utf-8?B?OC9tRnp5MEZ5TnQ5UTIwUGZrZ1VNcWd6MjBxSklMT3JITmo5Snh0RC9aUGh5?=
 =?utf-8?B?L1hDRzVkb2JwNFBCZnZKRFFtMjlPaWJHZy93aVE5VjVCRUYxamdKdjBOZlhM?=
 =?utf-8?B?SVlFaEIxZHVtTzVJajFOb2ppK2swdzYwaFdGYjQ1QnN4aHBlVU5FYUtMSTc2?=
 =?utf-8?B?SGpqVElRZGt5K3dyNFlNWERlTDRBS3ZJUDJCeHhIeG1KNGJwYm52U2daUmNp?=
 =?utf-8?B?cnVuWHRUQVpIYVBxVTVTMW1MaHRiUzVLNEVENnJQOHY3SGJPQ0ZORzRGaHI5?=
 =?utf-8?B?YUpyR0taYkt1aUZ3dDE2Sm9WWXNmVnl5Y2NGMjFPZVZTeXNWTnBjMm8vRzFz?=
 =?utf-8?B?ejBUWllJdnFQeEhVR2xZYVN6N2ZXN2R4d2FRd0VGVW9MM1B5RnpXclFaUUwr?=
 =?utf-8?B?ZW9ZYnpETjdROUJPaTIydldCa1NNNTlDZjhOa2lxSEZvdTd4MzdRbEJqTzlO?=
 =?utf-8?B?aDFqbjRqRWkrdm5YRE40OVluK3VabUVPbklhTk0wVStkUmRadUNwNlM4N1hO?=
 =?utf-8?B?TndOK0NFOFFDdGJ6cDlFUjdlRzViSldXMytpN0wrSE40S05lOEEvQ3Q4ZE9m?=
 =?utf-8?B?UjRJSDVUUmxPT0tuQU53cXpxWWlvN3JaRUJvdGVkdVVWZ0ZXbDJUc3ZvUXcw?=
 =?utf-8?B?YlljTEQyR1lsR00rQ2ZDN0tlaUtORXUrbWQzdVFFb0x2cjV5YkdCWnJQcSto?=
 =?utf-8?B?bHFaOW9zeGRrTVFWZWhLbGRmdFFBaVlKKysrN1RWV3ltaGdHMWZrUktVZE81?=
 =?utf-8?B?U2t0L2RrTnJOYUpNcnZRcmV1d09oRzExQXVueTZ0UnJxQlRHVzJ1cDdZUXBl?=
 =?utf-8?B?b1N1USs4YUxpdm5QNzZvR0NpK3RQdnUya2Z5VnJmU2JMQitzbGM3K3E5Ly9a?=
 =?utf-8?B?OVV6dVhZYUVFcnk4OU9uNVBmQXNpNk9uQVpWaThEMFNob1l3U0szQ0I1Q3VV?=
 =?utf-8?B?TVF4c3Y3K1p0ZmRqK24xRlRCd3g4Ny95TFZzTytSbFl3eEZwQ01KZXdWeDhZ?=
 =?utf-8?B?ODkzeW1lb3h3OEVFSGxzb3kxekZWaGVuSFMxc0NkVGFjeGdOb3IvZ1grTjl4?=
 =?utf-8?Q?i+7npoHlYZ8lQ1rw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3593632751BF7D448EF735CD653791B8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404652f0-18f2-48f3-ca9e-08da20e94ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 03:12:41.2959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ymfGgniK0F+9pxt4xnLN3qFnM55ZQRcy6UCCjQhkxCypbDHvuNRq1jq2TYLmO72yzy2CJ7hZ1QYCdaW6E0qarokgRz7oMWFUXMBJBSKZVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3907
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzE4IDExOjA0LCBYaXVibyBMaSB3cm90ZToNCj4NCj4gT24gNC8xNS8yMiA3OjAy
IFBNLCBZYW5nIFh1IHdyb3RlOg0KPj4gU2luY2UgdmZzIGhhcyBzdHJpcHBlZCBTX0lTR0lELCB3
ZSBkb24ndCBuZWVkIHRoaXMgY29kZSBhbnkgbW9yZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZ
YW5nIFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiBmcy9jZXBoL2Zp
bGUuYyB8IDQgLS0tLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2ZzL2NlcGgvZmlsZS5jIGIvZnMvY2VwaC9maWxlLmMNCj4+IGluZGV4IDZj
OWU4MzdhYTFkMy4uOGUzYjk5ODUzMzMzIDEwMDY0NA0KPj4gLS0tIGEvZnMvY2VwaC9maWxlLmMN
Cj4+ICsrKyBiL2ZzL2NlcGgvZmlsZS5jDQo+PiBAQCAtNjUxLDEwICs2NTEsNiBAQCBzdGF0aWMg
aW50IGNlcGhfZmluaXNoX2FzeW5jX2NyZWF0ZShzdHJ1Y3QgaW5vZGUNCj4+ICpkaXIsIHN0cnVj
dCBkZW50cnkgKmRlbnRyeSwNCj4+IC8qIERpcmVjdG9yaWVzIGFsd2F5cyBpbmhlcml0IHRoZSBz
ZXRnaWQgYml0LiAqLw0KPj4gaWYgKFNfSVNESVIobW9kZSkpDQo+PiBtb2RlIHw9IFNfSVNHSUQ7
DQo+PiAtIGVsc2UgaWYgKChtb2RlICYgKFNfSVNHSUQgfCBTX0lYR1JQKSkgPT0gKFNfSVNHSUQg
fCBTX0lYR1JQKSAmJg0KPj4gLSAhaW5fZ3JvdXBfcChkaXItPmlfZ2lkKSAmJg0KPj4gLSAhY2Fw
YWJsZV93cnRfaW5vZGVfdWlkZ2lkKCZpbml0X3VzZXJfbnMsIGRpciwgQ0FQX0ZTRVRJRCkpDQo+
PiAtIG1vZGUgJj0gflNfSVNHSUQ7DQo+DQo+IENvdWxkIHlvdSBwb2ludCBtZSB3aGVyZSBoYXMg
ZG9uZSB0aGlzIGZvciBjZXBoID8NCg0KWW91IGNhbiBzZWUgdGhlIDZ0aCBwYXRjaCwgaXQgYWRk
ZWQgcHJlcGFyZV9tb2RlIGZvciB0bXBmaWxlLCBvcGVuLCANCm1rbm9kYXQsIG1rZGlyYXQgaW4g
dmZzLiBUaGUgcHJlcGFyZV9tb2RlIGRvZXMgaW5vZGUgc2dpZCBzdHJpcCBhbmQgDQp1bWFzayBz
dHJpcC4NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo+DQo+IC0tIFhpdWJvDQo+DQo+DQo+PiB9
IGVsc2Ugew0KPj4gaW4uZ2lkID0gY3B1X3RvX2xlMzIoZnJvbV9rZ2lkKCZpbml0X3VzZXJfbnMs
IGN1cnJlbnRfZnNnaWQoKSkpOw0KPj4gfQ0KPg0K
