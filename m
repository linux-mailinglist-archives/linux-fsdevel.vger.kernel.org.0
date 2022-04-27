Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D523510DDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 03:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356654AbiD0BYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 21:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242681AbiD0BYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:24:43 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636D7674EF;
        Tue, 26 Apr 2022 18:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1651022492; x=1682558492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5eVVIQblIx7JYuN/akh7bPuQKTei+Bhib2DN1WWB+ng=;
  b=qnb2+XE2TLEfpiD6hJeU5omD9nJIKYgHe4NqO58nr0XIWKlxbAcaxp5d
   efg6zFK/bYOyovRw8mF8DmDsQPWYvY9e+3gSElAkXCIue5R8NWKeJowyr
   PDjOlL7u4uCnTaBSIR7/2iyALnR+UeXwM/y58UUczltvKSCpP7OnUmQRi
   yiEgWTgbCMn9hIApz6ab1wDF5xwVyRHi6fiM6j1idXpopz/GT2hM2tYmf
   mwuNqlUwGv4t28mcyXGjJPbeF1kpAL9uqNgB66hEuUhwkL8Gn6NWSYAQe
   +MyFKYIzV2XG26VjqoniwQu8697eOKc5TufD09POXVRnZWJ2IPboxR0cb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="55060933"
X-IronPort-AV: E=Sophos;i="5.90,292,1643641200"; 
   d="scan'208";a="55060933"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 10:21:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crHiGm790pYBpKaaaOyZAGfsQ6KVAlFq3ko8F2PM8uxeMqZTs9NPLi8W/cTfH20q6XX8vXTkODBbT9wOFSt5oQNUKoUoeB6stm8028Q2gDrYUijRbVSlZRDC+yvuD+svcNg1g5bOSmBMLEnRhWg0E1CUIdHLd0onnCe+iwnf1E8RIWfhF/0rxL838LCQe3s5YREfDiExLEsTIZYLOvMpOT2yIgS8yKQBJjJmfSu4b3RKzyZd9GzPIQe3hNvUGeFtWjraLVnLZwHD7+AzhObQH4PsFhl0Cj/YbEuFGZyQPm4wpSWsifRtGwnlcyuU+wqbgp9MAYLIaJVhvMkeJCkq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eVVIQblIx7JYuN/akh7bPuQKTei+Bhib2DN1WWB+ng=;
 b=kcYudGHtxsIlLhTa/F5pRiaTkU+miubTRDQKUzC4qL0XJPG3sFuS7UYjweubOglb5h6vIRxPdJdhQuyTMZ6YfZL7j4Fey39IeLJPB4746nii1kqEAJy7xEKclZlmDN7tUlGKff4lSrYpyYdrIVTWBadcsxNyyEuU2sUjN/DRtgKw6RygtREdaEkxRchTdmdn02dWF6KW2Z+cDIgYK2ALmU0Pm9HskDd2pK6qmD4UB/b2meAJfJlJYbBU2f5i5oC3amKfUMucxutGSY4ksWKWn5wAVCjTuchvXQeO4BRrj+/F45L8lbcgqfoCRlnIE0E17sIk9M7FJSRlHm52Uwf2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eVVIQblIx7JYuN/akh7bPuQKTei+Bhib2DN1WWB+ng=;
 b=PAiMjLHeY1oDmKjYKiupDfW3jNKxPia9/KGkFY9y1c2rFAESx1tpP0YO0mssdkwJ+9nG7LW2mLdCtj9G2gxPPBj0GvZ5nPEYVfdxb2bxVlX+fCy3VPFO1b10phl0fma/c8COsbQ1IvJMqTu0FqO6JZ5ocqd3dupjzo5zOMJAXNI=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB10211.jpnprd01.prod.outlook.com (2603:1096:400:1e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 01:21:17 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:21:17 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v8 3/4] fs: move S_ISGID stripping into the vfs
Thread-Topic: [PATCH v8 3/4] fs: move S_ISGID stripping into the vfs
Thread-Index: AQHYWVX6/nIEZ6SfxU6/P54BIq/K6a0CWJYAgACwHIA=
Date:   Wed, 27 Apr 2022 01:21:17 +0000
Message-ID: <6268A8F7.2020508@fujitsu.com>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650971490-4532-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220426155228.frw5ztdcwhhnnt3i@wittgenstein>
In-Reply-To: <20220426155228.frw5ztdcwhhnnt3i@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 819ddd1e-fd93-4908-fdf3-08da27ec3aa5
x-ms-traffictypediagnostic: TYWPR01MB10211:EE_
x-microsoft-antispam-prvs: <TYWPR01MB10211EA7CFFF8F6C7FCF7A533FDFA9@TYWPR01MB10211.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6PEw//FxtWunKb9Cy/P3WhMWQ/rgaUKtYQ063dDWRWpUit+UWToaGta+v+28iHnOGqo5JmSajbEOmdoy3WzNbIxJtxRihdl6yOlzloVGhDDQcTdziPcQCNGDNy6K4bAYbvX1kYVDYI0k5zmFvyp+2I2t9DUZeYJJaD+0WTCV0m+a/fjdZ0ncwO6XKBbJuEZZ+LvHNKPJRfjkXEC1QDwPjEdY/k3Zz7wjfjrzyEhyhWpSm4TnFDvS3/OXuQFTu8gvOt9GI0eDtvE+x3+z+5QKaBzm09gttxvzw02cgf0C44B+EIYo6L61lGANY7qskMXOnSCCXAHwoPvkfWMkeaYcr/kWxskcq2n3CRz1yLzpwe8P5fcrMfAQ/je1scdOlHKm6o4BTM6scyu/xqGBY6p26SP/UPCQiRi6OGgYwoX97sICOVwgEVKdhjWPY5mZWQa1uBOYGmOxp0LcIMAVi0ulPItS/qcnm10NvuvLrSLqX9cgrg4YhVDliK/R/ZC4xr15oOtbKSINqyjH1g6cABWg+2w/cjasn7zY0+3doREI9mk1xXS0RNg/5qVK5kVKZmirTqC6/tSekiovnosn7VNYWhFlItlBZkMOtBFWDd0Vp2GhY1El0P4WgvOe3+FNVwlWAUF9rNSw1EUCNUpjrF72IGDsCB7Vk0zrVTbXbPfVTWFn3FwFqO5A8hIlxD4eUsqptbUV58Xu6FXGhOvwXzfhM938Yo/+K5T55NZQs1p6TE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(2616005)(316002)(186003)(38070700005)(91956017)(38100700002)(87266011)(6512007)(86362001)(82960400001)(122000001)(26005)(6506007)(6486002)(5660300002)(30864003)(508600001)(2906002)(36756003)(85182001)(71200400001)(8936002)(66446008)(4326008)(76116006)(66476007)(54906003)(33656002)(66556008)(64756008)(8676002)(66946007)(6916009)(168613001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHJIQTEzc0FXcTRtdG0vZHVKVi9rOUp1ZW1ucUxhaXBpbmNkNzM1SDVzU012?=
 =?utf-8?B?am91L2RMbnBwN3E2RWVQQ3ZmTHhvVE5US3YwRnVBZjFGRDc3dFJ0UHYwOTJk?=
 =?utf-8?B?WThDU1U1VWhrb3FGL0hJclkvTk9oanE2VU0yeDA4dFZMZENnMVRMSlBKWXBE?=
 =?utf-8?B?MTlkREZVU3Z0UjJJbW1nM2VjN0pnRFBiS3hSZmo0REVESVRyTTM2Q3lLZ0Nr?=
 =?utf-8?B?b3lJcVdjQmM2T2RBeHNLOWxPeU11NGppdkNYK1ZMOHJWUUVQdmdEekpWamor?=
 =?utf-8?B?Z3BjNnF6Q3pOSjRsK0x3SndEVTFadjIyVGJJdG9LYTY0Vlo3RW94Z1RKRnJR?=
 =?utf-8?B?RFZMa2JZMk9WNHJ3bC9VYUJqSlFVRkdiaEJHQlVDVmgvcVZYRUdTR0N5TStn?=
 =?utf-8?B?NVlsNWJaSjJscW1yalBlZ1AwV2w3Qll6dy9abnB4S2hFY0FWQ3dvQ3V2K0JM?=
 =?utf-8?B?R01nR0podHpuWkhIQk5nc25sSnN5Z1BmbUJDZCtPSDVEc2xLY3JjUkNjWDNn?=
 =?utf-8?B?Qy90OHc2aUdZL3ZyZ3UyWjBQTXg5V1VwSGZ3UTFOZGJUMkZEamRkZldGOVJG?=
 =?utf-8?B?WlBYQnA4Si9KRllQUnRkbzQ3UHZIeDg5Yk1zOE4zNXZnTm5CR05hN2RtWEIy?=
 =?utf-8?B?em5mUGU4WU1WS0VOT0RZK0VSdFE5c2JTY1hDS09OQU9BaFkxNUsvUGVyWUM1?=
 =?utf-8?B?ZWo0dUYwQmxyZ2dMM0dMbVdmQlRnNFRsTndPMzdDKzRycWZKb1JiWnZjRDQv?=
 =?utf-8?B?cndEQ0pXM2N5eVFobTNtK3Z3dlNYY28yMS9jRE80SUVOTE9QQmRBYWUybCtx?=
 =?utf-8?B?T3F1Ymk2VGFvT2tYRXpzTFdhMDhOMnQzOC81VUZ5d3h3a3pmdE0ybmY3UVh6?=
 =?utf-8?B?Qm5xNklKNkcwZFFITmFWZTlWNWFpRHdBcWs2Mk1SRXNuLzFUM1VBcjBUMjhl?=
 =?utf-8?B?Smx5U1M1dlRtVWt3dkRmRHljRElzOFJkNEtwRGxpaWRORk1ZZGNnTjNxSktk?=
 =?utf-8?B?bUxxYnN1cUM4elBidlh4a01UekFKMzFCNUtZSFFjb0ZITVhDc0ozOGQvbFhh?=
 =?utf-8?B?Q0IwcVdibmhqZ2VaQVpQcWNkS0k5Y2dTcm8yNlY1dkJoZU5Cb3FWUmdnWEpC?=
 =?utf-8?B?MDFyYU9HenI1NTBxa0ZQK3BaZlYzMFZjVTVTanlZZVBXeUlnTWpzczNiTGVz?=
 =?utf-8?B?WWtJVTRGUkw1cnpJZGN6Um5mckJuK2g1MTRaNDlMM213TXc5cDlEZHRXVS9P?=
 =?utf-8?B?T1doYkFsc2FmMkY4TWhOd0dvbVowSWVtcGVmbG14QVYveUpMRm5DSkgvU2F0?=
 =?utf-8?B?N3N6RWtReFdLRmJXaEJkWGhBQ25JU2Y3clhDTkRjQWRzOWM3cFF5ZlAva3ZS?=
 =?utf-8?B?UGQ0Wnl3KzdRZ2YyUjJEYThTVVdNUi9GZE9vVnE1dmw4OHBGb2RBTUpiOUZL?=
 =?utf-8?B?UklIcXdkcXJlZEQvVllJWEtOL2haeE9PeTd5YnpmNjdjaUFCdWZKVUNjUmNE?=
 =?utf-8?B?aU9zS0lOc3o0UTkvUWF0UnlMOVJEVVRYSkw0NnhEYWVpMS9ucFljcWg0UFR0?=
 =?utf-8?B?WTFiQk9IVjZPUkl1cFVIUkRudy9IcGpkbGRtRngvOGZsK0NIQnZaOVBSUk9S?=
 =?utf-8?B?V2FwUHNUSlFLZ1k4MjUxR0w3a25WWFZ3dHNnZFgxRTJHR1Q4WXEvc1pDZDhU?=
 =?utf-8?B?ZFEwQWVlVzVOYUR6dFBTMUZkNWpabm51clVmNFFQMkpRb1MyMVlKZEl0Qkd3?=
 =?utf-8?B?anV1SVJUd0EybnM5QThkNW5INW1XL2ZTbitnZExMT2pKUW14U2RWSkhiQ2xQ?=
 =?utf-8?B?d1NmSVZCZ25Pb0pKdzlGRUZXVUlpTFZNWTVWQkszZmZSU3F2OVFmQ2V5WlhL?=
 =?utf-8?B?YnNyWkJpb1g1enRUUVVrSmJvaXM3cFpCMCthTlNMUDdtbC9ueWcxM1FFb1JQ?=
 =?utf-8?B?RHg4dFFFZUY4ZXJWaTQ5RHViQzV5eVZKWlAzSlhlQWhqRWViL1dXQ0RHZVJa?=
 =?utf-8?B?bE9jb0Z3Y1JrQ0NOU2Z5Q2V4Z2xTWkF5Vmh0QStvamlUTEZ5VU9XVVZqMWVZ?=
 =?utf-8?B?S0prVW1YQTF1UGtyV0FvM2N1b3UrcUdZakJxcDlEMHR5N3RWTTBsZGo5anFG?=
 =?utf-8?B?cmg5MFZRTlcrUWMrV01VUGlxVjV6Rm9VYnpPTkwrZjduNzd0N2pZYURBQm8r?=
 =?utf-8?B?SDQxMVIxYXlkRTdQVFI5VGhuOWdPcE1aWE1uZGJOT3dSajNnN2hZN2ovVkJm?=
 =?utf-8?B?bWdZYUpFWWpGbkNGNEJXVVFwaTFQWHRJdzVEY0VXajdqYXdMeTRBNGJaNlpn?=
 =?utf-8?B?dG9VRDlpRnlhTENlK1J4RjNWQTA3S05laUV3TTZjdWFmOVdjT2hEWm94eGZo?=
 =?utf-8?Q?XkwEn4ETJPmqC3zR0mMikdwuwjvu5ptG+Gw5j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37DA9ED12680C84098CA89E46CF8A27F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819ddd1e-fd93-4908-fdf3-08da27ec3aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 01:21:17.5912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qq3778j0D7vC8m50lqFsfecR+QN8y8OGmiFaNRTqCHa+tQxK9ypm6qPl6gyin6NpOuLPpWGw2Yi6Z7lPkCvRcGIS1uTMBt4cdjPso7kbsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10211
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzI2IDIzOjUyLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMjYsIDIwMjIgYXQgMDc6MTE6MjlQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IENyZWF0
aW5nIGZpbGVzIHRoYXQgaGF2ZSBib3RoIHRoZSBTX0lYR1JQIGFuZCBTX0lTR0lEIGJpdCByYWlz
ZWQgaW4NCj4+IGRpcmVjdG9yaWVzIHRoYXQgdGhlbXNlbHZlcyBoYXZlIHRoZSBTX0lTR0lEIGJp
dCBzZXQgcmVxdWlyZXMgYWRkaXRpb25hbA0KPj4gcHJpdmlsZWdlcyB0byBhdm9pZCBzZWN1cml0
eSBpc3N1ZXMuDQo+Pg0KPj4gV2hlbiBhIGZpbGVzeXN0ZW0gY3JlYXRlcyBhIG5ldyBpbm9kZSBp
dCBuZWVkcyB0byB0YWtlIGNhcmUgdGhhdCB0aGUNCj4+IGNhbGxlciBpcyBlaXRoZXIgaW4gdGhl
IGdyb3VwIG9mIHRoZSBuZXdseSBjcmVhdGVkIGlub2RlIG9yIHRoZXkgaGF2ZQ0KPj4gQ0FQX0ZT
RVRJRCBpbiB0aGVpciBjdXJyZW50IHVzZXIgbmFtZXNwYWNlIGFuZCBhcmUgcHJpdmlsZWdlZCBv
dmVyIHRoZQ0KPj4gcGFyZW50IGRpcmVjdG9yeSBvZiB0aGUgbmV3IGlub2RlLiBJZiBhbnkgb2Yg
dGhlc2UgdHdvIGNvbmRpdGlvbnMgaXMNCj4+IHRydWUgdGhlbiB0aGUgU19JU0dJRCBiaXQgY2Fu
IGJlIHJhaXNlZCBmb3IgYW4gU19JWEdSUCBmaWxlIGFuZCBpZiBub3QNCj4+IGl0IG5lZWRzIHRv
IGJlIHN0cmlwcGVkLg0KPj4NCj4+IEhvd2V2ZXIsIHRoZXJlIGFyZSBzZXZlcmFsIGtleSBpc3N1
ZXMgd2l0aCB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGluZ3M6DQo+Pg0KPj4gKiBUaGUgU19JU0dJ
RCBzdHJpcHBpbmcgbG9naWMgaXMgZW50YW5nbGVkIHdpdGggdW1hc2sgc3RyaXBwaW5nLg0KPj4N
Cj4+ICAgIElmIGEgZmlsZXN5c3RlbSBkb2Vzbid0IHN1cHBvcnQgb3IgZW5hYmxlIFBPU0lYIEFD
THMgdGhlbiB1bWFzaw0KPj4gICAgc3RyaXBwaW5nIGlzIGRvbmUgZGlyZWN0bHkgaW4gdGhlIHZm
cyBiZWZvcmUgY2FsbGluZyBpbnRvIHRoZQ0KPj4gICAgZmlsZXN5c3RlbS4NCj4+ICAgIElmIHRo
ZSBmaWxlc3lzdGVtIGRvZXMgc3VwcG9ydCBQT1NJWCBBQ0xzIHRoZW4gdW5tYXNrIHN0cmlwcGlu
ZyBtYXkgYmUNCj4+ICAgIGRvbmUgaW4gdGhlIGZpbGVzeXN0ZW0gaXRzZWxmIHdoZW4gY2FsbGlu
ZyBwb3NpeF9hY2xfY3JlYXRlKCkuDQo+Pg0KPj4gKiBGaWxlc3lzdGVtcyB0aGF0IGRvbid0IHJl
bHkgb24gaW5vZGVfaW5pdF9vd25lcigpIGRvbid0IGdldCBTX0lTR0lEDQo+PiAgICBzdHJpcHBp
bmcgbG9naWMuDQo+Pg0KPj4gICAgV2hpbGUgdGhhdCBtYXkgYmUgaW50ZW50aW9uYWwgKGUuZy4g
bmV0d29yayBmaWxlc3lzdGVtcyBtaWdodCBqdXN0DQo+PiAgICBkZWZlciBzZXRnaWQgc3RyaXBw
aW5nIHRvIGEgc2VydmVyKSBpdCBpcyBvZnRlbiBqdXN0IGEgc2VjdXJpdHkgaXNzdWUuDQo+Pg0K
Pj4gKiBUaGUgZmlyc3QgdHdvIHBvaW50cyB0YWtlbiB0b2dldGhlciBtZWFuIHRoYXQgdGhlcmUn
cyBhDQo+PiAgICBub24tc3RhbmRhcmRpemVkIG9yZGVyaW5nIGJldHdlZW4gc2V0Z2lkIHN0cmlw
cGluZyBpbg0KPj4gICAgaW5vZGVfaW5pdF9vd25lcigpIGFuZCBwb3NpeF9hY2xfY3JlYXRlKCkg
Ym90aCBvbiB0aGUgdmZzIGxldmVsIGFuZA0KPj4gICAgdGhlIGZpbGVzeXN0ZW0gbGV2ZWwuIFRo
ZSBsYXR0ZXIgcGFydCBpcyBlc3BlY2lhbGx5IHByb2JsZW1hdGljIHNpbmNlDQo+PiAgICBlYWNo
IGZpbGVzeXN0ZW0gaXMgdGVjaG5pY2FsbHkgZnJlZSB0byBvcmRlciBpbm9kZV9pbml0X293bmVy
KCkgYW5kDQo+PiAgICBwb3NpeF9hY2xfY3JlYXRlKCkgaG93ZXZlciBpdCBzZWVzIGZpdCBtZWFu
aW5nIHRoYXQgU19JU0dJRA0KPj4gICAgaW5oZXJpdGFuY2UgbWlnaHQgb3IgbWlnaHQgbm90IGJl
IGFwcGxpZWQuDQo+Pg0KPj4gKiBXZSBkbyBzdGlsbCBoYXZlIGJ1Z3MgaW4gdGhpcyBhcmVhcyB5
ZWFycyBhZnRlciB0aGUgaW5pdGlhbCByb3VuZCBvZg0KPj4gICAgc2V0Z2lkIGJ1Z2ZpeGVzLg0K
Pj4NCj4+IFNvIHRoZSBjdXJyZW50IHN0YXRlIGlzIHF1aXRlIG1lc3N5IGFuZCB3aGlsZSB3ZSB3
b24ndCBiZSBhYmxlIHRvIG1ha2UNCj4+IGl0IGNvbXBsZXRlbHkgY2xlYW4gYXMgcG9zaXhfYWNs
X2NyZWF0ZSgpIGlzIHN0aWxsIGEgZmlsZXN5c3RlbSBzcGVjaWZpYw0KPj4gY2FsbCB3ZSBjYW4g
aW1wcm92ZSB0aGUgU19TSUdEIHN0cmlwcGluZyBzaXR1YXRpb24gcXVpdGUgYSBiaXQgYnkNCj4+
IGhvaXN0aW5nIGl0IG91dCBvZiBpbm9kZV9pbml0X293bmVyKCkgYW5kIGludG8gdGhlIHZmcyBj
cmVhdGlvbg0KPj4gb3BlcmF0aW9ucy4gVGhpcyBtZWFucyB3ZSBhbGxldmlhdGUgdGhlIGJ1cmRl
biBmb3IgZmlsZXN5c3RlbXMgdG8gaGFuZGxlDQo+PiBTX0lTR0lEIHN0cmlwcGluZyBjb3JyZWN0
bHkgYW5kIGNhbiBzdGFuZGFyZGl6ZSB0aGUgb3JkZXJpbmcgYmV0d2Vlbg0KPj4gU19JU0dJRCBh
bmQgdW1hc2sgc3RyaXBwaW5nIGluIHRoZSB2ZnMuDQo+Pg0KPj4gVGhlIFNfSVNHSUQgYml0IGlz
IHN0cmlwcGVkIGJlZm9yZSBhbnkgdW1hc2sgaXMgYXBwbGllZC4gVGhpcyBoYXMgdGhlDQo+PiBh
ZHZhbnRhZ2UgdGhhdCB0aGUgb3JkZXJpbmcgaXMgdW5hZmZlY3RlZCBieSB3aGV0aGVyIHVtYXNr
IHN0cmlwcGluZyBpcw0KPj4gZG9uZSBieSB0aGUgdmZzIGl0c2VsZiAoaWYgbm8gUE9TSVggQUNM
cyBhcmUgc3VwcG9ydGVkIG9yIGVuYWJsZWQpIG9yIGluDQo+PiB0aGUgZmlsZXN5c3RlbSBpbiBw
b3NpeF9hY2xfY3JlYXRlKCkgKGlmIFBPU0lYIEFDTHMgYXJlIHN1cHBvcnRlZCkuDQo+Pg0KPj4g
VG8gdGhpcyBlbmQgYSBuZXcgaGVscGVyIHZmc19wcmVwYXJlX21vZGUoKSBpcyBhZGRlZCB3aGlj
aCBjYWxscyB0aGUNCj4+IHByZXZpb3VzbHkgYWRkZWQgbW9kZV9zdHJpcF9zZXRnaWQoKSBoZWxw
ZXIgYW5kIHN0cmlwcyB0aGUgdW1hc2sNCj4+IGFmdGVyd2FyZHMuDQo+Pg0KPj4gQWxsIGlub2Rl
IG9wZXJhdGlvbnMgdGhhdCBjcmVhdGUgbmV3IGZpbGVzeXN0ZW0gb2JqZWN0cyBoYXZlIGJlZW4N
Cj4+IHVwZGF0ZWQgdG8gY2FsbCB2ZnNfcHJlcGFyZV9tb2RlKCkgYmVmb3JlIHBhc3NpbmcgdGhl
IG1vZGUgaW50byB0aGUNCj4+IHJlbGV2YW50IGlub2RlIG9wZXJhdGlvbiBvZiB0aGUgZmlsZXN5
c3RlbXMuIENhcmUgaGFzIGJlZW4gdGFrZW4gdG8NCj4+IGVuc3VyZSB0aGF0IHRoZSBtb2RlIHBh
c3NlZCB0byB0aGUgc2VjdXJpdHkgaG9va3MgaXMgdGhlIG1vZGUgdGhhdCBpcw0KPj4gc2VlbiBi
eSB0aGUgZmlsZXN5c3RlbS4NCj4+DQo+PiBGb2xsb3dpbmcgaXMgYW4gb3ZlcnZpZXcgb2YgdGhl
IGZpbGVzeXN0ZW0gc3BlY2lmaWMgYW5kIGlub2RlIG9wZXJhdGlvbnMNCj4+IHNwZWNpZmljIGlt
cGxpY2F0aW9uczoNCj4+DQo+PiBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL2NlbGwvc3B1ZnMvaW5v
ZGUuYzogICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1v
ZGUgfCBTX0lGRElSKTsNCj4+IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvY2VsbC9zcHVmcy9pbm9k
ZS5jOiAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9k
ZSB8IFNfSUZESVIpOw0KPj4gZnMvOXAvdmZzX2lub2RlLmM6ICAgICAgaW5vZGVfaW5pdF9vd25l
cigmaW5pdF91c2VyX25zLCBpbm9kZSwgTlVMTCwgbW9kZSk7DQo+PiBmcy9iZnMvZGlyLmM6ICAg
aW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+IGZz
L2J0cmZzL2lub2RlLmM6ICAgICAgIGlub2RlX2luaXRfb3duZXIobW50X3VzZXJucywgaW5vZGUs
IGRpciwgbW9kZSk7DQo+PiBmcy9idHJmcy90ZXN0cy9idHJmcy10ZXN0cy5jOiAgIGlub2RlX2lu
aXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIE5VTEwsIFNfSUZSRUcpOw0KPj4gZnMvZXh0
Mi9pYWxsb2MuYzogICAgICAgICAgICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMs
IGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gZnMvZXh0NC9pYWxsb2MuYzogICAgICAgICAgICAgICBp
bm9kZV9pbml0X293bmVyKG1udF91c2VybnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gZnMvZjJm
cy9uYW1laS5jOiAgICAgICAgaW5vZGVfaW5pdF9vd25lcihtbnRfdXNlcm5zLCBpbm9kZSwgZGly
LCBtb2RlKTsNCj4+IGZzL2hmc3BsdXMvaW5vZGUuYzogICAgIGlub2RlX2luaXRfb3duZXIoJmlu
aXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+PiBmcy9odWdldGxiZnMvaW5vZGUuYzog
ICAgICAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9k
ZSk7DQo+PiBmcy9qZnMvamZzX2lub2RlLmM6ICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3Vz
ZXJfbnMsIGlub2RlLCBwYXJlbnQsIG1vZGUpOw0KPj4gZnMvbWluaXgvYml0bWFwLmM6ICAgICAg
aW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+IGZz
L25pbGZzMi9pbm9kZS5jOiAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5v
ZGUsIGRpciwgbW9kZSk7DQo+PiBmcy9udGZzMy9pbm9kZS5jOiAgICAgICBpbm9kZV9pbml0X293
bmVyKG1udF91c2VybnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gZnMvb2NmczIvZGxtZnMvZGxt
ZnMuYzogICAgICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBOVUxM
LCBtb2RlKTsNCj4+IGZzL29jZnMyL2RsbWZzL2RsbWZzLmM6IGlub2RlX2luaXRfb3duZXIoJmlu
aXRfdXNlcl9ucywgaW5vZGUsIHBhcmVudCwgbW9kZSk7DQo+PiBmcy9vY2ZzMi9uYW1laS5jOiAg
ICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0K
Pj4gZnMvb21mcy9pbm9kZS5jOiAgICAgICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25z
LCBpbm9kZSwgTlVMTCwgbW9kZSk7DQo+PiBmcy9vdmVybGF5ZnMvZGlyLmM6ICAgICBpbm9kZV9p
bml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkZW50cnktPmRfcGFyZW50LT5kX2lub2Rl
LCBtb2RlKTsNCj4+IGZzL3JhbWZzL2lub2RlLmM6ICAgICAgICAgICAgICAgaW5vZGVfaW5pdF9v
d25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+IGZzL3JlaXNlcmZzL25h
bWVpLmM6ICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9k
ZSk7DQo+PiBmcy9zeXN2L2lhbGxvYy5jOiAgICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3Vz
ZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gZnMvdWJpZnMvZGlyLmM6IGlub2RlX2luaXRf
b3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+PiBmcy91ZGYvaWFsbG9j
LmM6ICAgICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1v
ZGUpOw0KPj4gZnMvdWZzL2lhbGxvYy5jOiAgICAgICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91
c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+IGZzL3hmcy94ZnNfaW5vZGUuYzogICAgICAg
ICAgICAgaW5vZGVfaW5pdF9vd25lcihtbnRfdXNlcm5zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+
IGZzL3pvbmVmcy9zdXBlci5jOiAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywg
aW5vZGUsIHBhcmVudCwgU19JRkRJUiB8IDA1NTUpOw0KPj4ga2VybmVsL2JwZi9pbm9kZS5jOiAg
ICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+
IG1tL3NobWVtLmM6ICAgICAgICAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywg
aW5vZGUsIGRpciwgbW9kZSk7DQo+Pg0KPj4gQWxsIG9mIHRoZSBhYm92ZSBmaWxlc3lzdGVtcyBl
bmQgdXAgY2FsbGluZyBpbm9kZV9pbml0X293bmVyKCkgd2hlbiBuZXcNCj4+IGZpbGVzeXN0ZW0g
b2JqZWN0cyBhcmUgY3JlYXRlZCB0aHJvdWdoIHRoZSBmb2xsb3dpbmcgLT5ta2RpcigpLA0KPj4g
LT5zeW1saW5rKCksIC0+bWtub2QoKSwgLT5jcmVhdGUoKSwgLT50bXBmaWxlKCksIC0+cmVuYW1l
KCkgaW5vZGUNCj4+IG9wZXJhdGlvbnMuDQo+Pg0KPj4gU2luY2UgZGlyZWN0b3JpZXMgYWx3YXlz
IGluaGVyaXQgdGhlIFNfSVNHSUQgYml0IHdpdGggdGhlIGV4Y2VwdGlvbiBvZg0KPj4geGZzIHdo
ZW4gaXJpeF9zZ2lkX2luaGVyaXQgbW9kZSBpcyB0dXJuZWQgb24gU19JU0dJRCBzdHJpcHBpbmcg
ZG9lc24ndA0KPj4gYXBwbHkuIFRoZSAtPnN5bWxpbmsoKSBpbm9kZSBvcGVyYXRpb24gdHJpdmlh
bGx5IGluaGVyaXQgdGhlIG1vZGUgZnJvbQ0KPj4gdGhlIHRhcmdldCBhbmQgdGhlIC0+cmVuYW1l
KCkgaW5vZGUgb3BlcmF0aW9uIGluaGVyaXRzIHRoZSBtb2RlIGZyb20gdGhlDQo+PiBzb3VyY2Ug
aW5vZGUuDQo+Pg0KPj4gQWxsIG90aGVyIGlub2RlIG9wZXJhdGlvbnMgd2lsbCBoYXZlIHRoZSBT
X0lTR0lEIGJpdCBzdHJpcHBlZCBvbmNlIGluDQo+PiB2ZnNfcHJlcGFyZV9tb2RlKCkgYmVmb3Jl
Lg0KPj4NCj4+IEluIGFkZGl0aW9uIHRvIHRoaXMgdGhlcmUgYXJlIGZpbGVzeXN0ZW1zIHdoaWNo
IGFsbG93IHRoZSBjcmVhdGlvbiBvZg0KPj4gZmlsZXN5c3RlbSBvYmplY3RzIHRocm91Z2ggaW9j
dGwoKXMgb3IgLSBpbiB0aGUgY2FzZSBvZiBzcHVmcyAtDQo+PiBjaXJjdW12ZW50aW5nIHRoZSB2
ZnMgaW4gb3RoZXIgd2F5cy4gSWYgZmlsZXN5c3RlbSBvYmplY3RzIGFyZSBjcmVhdGVkDQo+PiB0
aHJvdWdoIGlvY3RsKClzIHRoZSB2ZnMgZG9lc24ndCBrbm93IGFib3V0IGl0IGFuZCBjYW4ndCBh
cHBseSByZWd1bGFyDQo+PiBwZXJtaXNzaW9uIGNoZWNraW5nIGluY2x1ZGluZyBTX0lTR0lEIGxv
Z2ljLiBUaGVyZm9yZSwgYSBmaWxlc3lzdGVtDQo+PiByZWx5aW5nIG9uIFNfSVNHSUQgc3RyaXBw
aW5nIGluIGlub2RlX2luaXRfb3duZXIoKSBpbiB0aGVpciBpb2N0bCgpDQo+PiBjYWxscGF0aCB3
aWxsIGJlIGFmZmVjdGVkIGJ5IG1vdmluZyB0aGlzIGxvZ2ljIGludG8gdGhlIHZmcy4NCj4+DQo+
PiBTbyB3ZSBkaWQgb3VyIGJlc3QgdG8gYXVkaXQgYWxsIGZpbGVzeXN0ZW1zIGluIHRoaXMgcmVn
YXJkOg0KPj4NCj4+ICogYnRyZnMgYWxsb3dzIHRoZSBjcmVhdGlvbiBvZiBmaWxlc3lzdGVtIG9i
amVjdHMgdGhyb3VnaCB2YXJpb3VzDQo+PiAgICBpb2N0bHMoKS4gU25hcHNob3QgY3JlYXRpb24g
bGl0ZXJhbGx5IHRha2VzIGEgc25hcHNob3QgYW5kIHNvIHRoZSBtb2RlDQo+PiAgICBpcyBmdWxs
eSBwcmVzZXJ2ZWQgYW5kIFNfSVNHSUQgc3RyaXBwaW5nIGRvZXNuJ3QgYXBwbHkuDQo+Pg0KPj4g
ICAgQ3JlYXRpbmcgYSBuZXcgc3Vidm9sdW0gcmVsaWVzIG9uIGlub2RlX2luaXRfb3duZXIoKSBp
bg0KPj4gICAgYnRyZnNfbmV3X2lub2RlKCkgYnV0IG9ubHkgY3JlYXRlcyBkaXJlY3RvcmllcyBh
bmQgZG9lc24ndCByYWlzZQ0KPj4gICAgU19JU0dJRC4NCj4+DQo+PiAqIG9jZnMyIGhhcyBhIHBl
Y3VsaWFyIGltcGxlbWVudGF0aW9uIG9mIHJlZmxpbmtzLiBJbiBjb250cmFzdCB0byBlLmcuDQo+
PiAgICB4ZnMgYW5kIGJ0cmZzIEZJQ0xPTkUvRklDTE9ORVJBTkdFIGlvY3RsKCkgdGhhdCBpcyBv
bmx5IGNvbmNlcm5lZCB3aXRoDQo+PiAgICB0aGUgYWN0dWFsIGV4dGVudHMgb2NmczIgdXNlcyBh
IHNlcGFyYXRlIGlvY3RsKCkgdGhhdCBhbHNvIGNyZWF0ZXMgdGhlDQo+PiAgICB0YXJnZXQgZmls
ZS4NCj4+DQo+PiAgICBJb3csIG9jZnMyIGNpcmN1bXZlbnRzIHRoZSB2ZnMgZW50aXJlbHkgaGVy
ZSBhbmQgZGlkIGluZGVlZCByZWx5IG9uDQo+PiAgICBpbm9kZV9pbml0X293bmVyKCkgdG8gc3Ry
aXAgdGhlIFNfSVNHSUQgYml0LiBUaGlzIGlzIHRoZSBvbmx5IHBsYWNlDQo+PiAgICB3aGVyZSBh
IGZpbGVzeXN0ZW0gbmVlZHMgdG8gY2FsbCBtb2RlX3N0cmlwX3NnaWQoKSBkaXJlY3RseSBidXQg
dGhpcw0KPj4gICAgaXMgc2VsZi1pbmZsaWN0ZWQgcGFpbiB0YmguDQo+Pg0KPj4gKiBzcHVmcyBk
b2Vzbid0IGdvIHRocm91Z2ggdGhlIHZmcyBhdCBhbGwgYW5kIGRvZXNuJ3QgdXNlIGlvY3RsKClz
DQo+PiAgICBlaXRoZXIuIEluc3RlYWQgaXQgaGFzIGEgZGVkaWNhdGVkIHN5c3RlbSBjYWxsIHNw
dWZzX2NyZWF0ZSgpIHdoaWNoDQo+PiAgICBhbGxvd3MgdGhlIGNyZWF0aW9uIG9mIGZpbGVzeXN0
ZW0gb2JqZWN0cy4gQnV0IHNwdWZzIG9ubHkgY3JlYXRlcw0KPj4gICAgZGlyZWN0b3JpZXMgYW5k
IGRvZXNuJ3QgYWxsbyBTX1NJR0lEIGJpdHMsIGkuZS4gaXQgc3BlY2lmaWNhbGx5IG9ubHkNCj4+
ICAgIGFsbG93cyAwNzc3IGJpdHMuDQo+Pg0KPj4gKiBicGYgdXNlcyB2ZnNfbWtvYmooKSBidXQg
YWxzbyBkb2Vzbid0IGFsbG93IFNfSVNHSUQgYml0cyB0byBiZSBjcmVhdGVkLg0KPj4NCj4+IFdo
aWxlIHdlIGRpZCBvdXIgYmVzdCB0byBhdWRpdCBldmVyeXRoaW5nIHRoZXJlJ3MgYSByaXNrIG9m
IHJlZ3Jlc3Npb25zDQo+PiBpbiBoZXJlLiBIb3dldmVyLCBmb3IgdGhlIHNha2Ugb2YgbWFpbnRl
bmFuY2UgYW5kIGdpdmVuIHRoYXQgd2UndmUgc2Vlbg0KPj4gYSByYW5nZSBvZiBidWdzIHllYXJz
IGFmdGVyIFNfSVNHSUQgaW5oZXJpdGFuY2UgaXNzdWVzIHdlcmUgZml4ZWQgKHNlZQ0KPj4gWzFd
LVszXSkgdGhlIHJpc2sgc2VlbXMgd29ydGggdGFraW5nLiBJbiB0aGUgd29yc3QgY2FzZSB3ZSB3
aWxsIGhhdmUgdG8NCj4+IHJldmVydC4NCj4+DQo+PiBBc3NvY2lhdGVkIHdpdGggdGhpcyBjaGFu
Z2UgaXMgYSBuZXcgc2V0IG9mIGZzdGVzdHMgdG8gZW5mb3JjZSB0aGUNCj4+IHNlbWFudGljcyBm
b3IgYWxsIG5ldyBmaWxlc3lzdGVtcy4NCj4+DQo+PiBMaW5rOiBlMDE0ZjM3ZGIxYTIgKCJ4ZnM6
IHVzZSBzZXRhdHRyX2NvcHkgdG8gc2V0IHZmcyBpbm9kZSBhdHRyaWJ1dGVzIikgWzFdDQo+PiBM
aW5rOiAwMWVhMTczZTEwM2UgKCJ4ZnM6IGZpeCB1cCBub24tZGlyZWN0b3J5IGNyZWF0aW9uIGlu
IFNHSUQgZGlyZWN0b3JpZXMiKSBbMl0NCj4+IExpbms6IGZkODRiZmRkZGQxNiAoImNlcGg6IGZp
eCB1cCBub24tZGlyZWN0b3J5IGNyZWF0aW9uIGluIFNHSUQgZGlyZWN0b3JpZXMiKSBbM10NCj4+
IFJldmlld2VkLWJ5OiBEYXJyaWNrIEouIFdvbmc8ZGp3b25nQGtlcm5lbC5vcmc+DQo+PiBTdWdn
ZXN0ZWQtYnk6IERhdmUgQ2hpbm5lcjxkYXZpZEBmcm9tb3JiaXQuY29tPg0KPj4gU2lnbmVkLW9m
Zi1ieTogWWFuZyBYdTx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiAgIGZz
L2lub2RlLmMgICAgICAgICB8ICAyIC0tDQo+PiAgIGZzL25hbWVpLmMgICAgICAgICB8IDIyICsr
KysrKysrKy0tLS0tLS0tLS0tLS0NCj4+ICAgZnMvb2NmczIvbmFtZWkuYyAgIHwgIDEgKw0KPj4g
ICBpbmNsdWRlL2xpbnV4L2ZzLmggfCAxMSArKysrKysrKysrKw0KPj4gICA0IGZpbGVzIGNoYW5n
ZWQsIDIxIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9mcy9pbm9kZS5jIGIvZnMvaW5vZGUuYw0KPj4gaW5kZXggZTlhNWYyZWMyZjg5Li5kZDM1N2Y0
YjU1NmQgMTAwNjQ0DQo+PiAtLS0gYS9mcy9pbm9kZS5jDQo+PiArKysgYi9mcy9pbm9kZS5jDQo+
PiBAQCAtMjI0Niw4ICsyMjQ2LDYgQEAgdm9pZCBpbm9kZV9pbml0X293bmVyKHN0cnVjdCB1c2Vy
X25hbWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0IGlub2RlICppbm9kZSwNCj4+ICAgCQkvKiBE
aXJlY3RvcmllcyBhcmUgc3BlY2lhbCwgYW5kIGFsd2F5cyBpbmhlcml0IFNfSVNHSUQgKi8NCj4+
ICAgCQlpZiAoU19JU0RJUihtb2RlKSkNCj4+ICAgCQkJbW9kZSB8PSBTX0lTR0lEOw0KPj4gLQkJ
ZWxzZQ0KPj4gLQkJCW1vZGUgPSBtb2RlX3N0cmlwX3NnaWQobW50X3VzZXJucywgZGlyLCBtb2Rl
KTsNCj4+ICAgCX0gZWxzZQ0KPj4gICAJCWlub2RlX2ZzZ2lkX3NldChpbm9kZSwgbW50X3VzZXJu
cyk7DQo+PiAgIAlpbm9kZS0+aV9tb2RlID0gbW9kZTsNCj4+IGRpZmYgLS1naXQgYS9mcy9uYW1l
aS5jIGIvZnMvbmFtZWkuYw0KPj4gaW5kZXggNzM2NDZlMjhmYWUwLi41ZGJmMDA3MDRhZTggMTAw
NjQ0DQo+PiAtLS0gYS9mcy9uYW1laS5jDQo+PiArKysgYi9mcy9uYW1laS5jDQo+PiBAQCAtMzI4
Nyw4ICszMjg3LDcgQEAgc3RhdGljIHN0cnVjdCBkZW50cnkgKmxvb2t1cF9vcGVuKHN0cnVjdCBu
YW1laWRhdGEgKm5kLCBzdHJ1Y3QgZmlsZSAqZmlsZSwNCj4+ICAgCWlmIChvcGVuX2ZsYWcmICBP
X0NSRUFUKSB7DQo+PiAgIAkJaWYgKG9wZW5fZmxhZyYgIE9fRVhDTCkNCj4+ICAgCQkJb3Blbl9m
bGFnJj0gfk9fVFJVTkM7DQo+PiAtCQlpZiAoIUlTX1BPU0lYQUNMKGRpci0+ZF9pbm9kZSkpDQo+
PiAtCQkJbW9kZSY9IH5jdXJyZW50X3VtYXNrKCk7DQo+PiArCQltb2RlID0gdmZzX3ByZXBhcmVf
bW9kZShtbnRfdXNlcm5zLCBkaXItPmRfaW5vZGUsIG1vZGUpOw0KPj4gICAJCWlmIChsaWtlbHko
Z290X3dyaXRlKSkNCj4+ICAgCQkJY3JlYXRlX2Vycm9yID0gbWF5X29fY3JlYXRlKG1udF91c2Vy
bnMsJm5kLT5wYXRoLA0KPj4gICAJCQkJCQkgICAgZGVudHJ5LCBtb2RlKTsNCj4+IEBAIC0zNTIx
LDggKzM1MjAsNyBAQCBzdHJ1Y3QgZGVudHJ5ICp2ZnNfdG1wZmlsZShzdHJ1Y3QgdXNlcl9uYW1l
c3BhY2UgKm1udF91c2VybnMsDQo+PiAgIAljaGlsZCA9IGRfYWxsb2MoZGVudHJ5LCZzbGFzaF9u
YW1lKTsNCj4+ICAgCWlmICh1bmxpa2VseSghY2hpbGQpKQ0KPj4gICAJCWdvdG8gb3V0X2VycjsN
Cj4+IC0JaWYgKCFJU19QT1NJWEFDTChkaXIpKQ0KPj4gLQkJbW9kZSY9IH5jdXJyZW50X3VtYXNr
KCk7DQo+PiArCW1vZGUgPSB2ZnNfcHJlcGFyZV9tb2RlKG1udF91c2VybnMsIGRpciwgbW9kZSk7
DQo+PiAgIAllcnJvciA9IGRpci0+aV9vcC0+dG1wZmlsZShtbnRfdXNlcm5zLCBkaXIsIGNoaWxk
LCBtb2RlKTsNCj4+ICAgCWlmIChlcnJvcikNCj4+ICAgCQlnb3RvIG91dF9lcnI7DQo+PiBAQCAt
Mzg1MCwxMyArMzg0OCwxMiBAQCBzdGF0aWMgaW50IGRvX21rbm9kYXQoaW50IGRmZCwgc3RydWN0
IGZpbGVuYW1lICpuYW1lLCB1bW9kZV90IG1vZGUsDQo+PiAgIAlpZiAoSVNfRVJSKGRlbnRyeSkp
DQo+PiAgIAkJZ290byBvdXQxOw0KPj4NCj4+IC0JaWYgKCFJU19QT1NJWEFDTChwYXRoLmRlbnRy
eS0+ZF9pbm9kZSkpDQo+PiAtCQltb2RlJj0gfmN1cnJlbnRfdW1hc2soKTsNCj4+ICsJbW50X3Vz
ZXJucyA9IG1udF91c2VyX25zKHBhdGgubW50KTsNCj4+ICsJbW9kZSA9IHZmc19wcmVwYXJlX21v
ZGUobW50X3VzZXJucywgcGF0aC5kZW50cnktPmRfaW5vZGUsIG1vZGUpOw0KPj4gICAJZXJyb3Ig
PSBzZWN1cml0eV9wYXRoX21rbm9kKCZwYXRoLCBkZW50cnksIG1vZGUsIGRldik7DQo+PiAgIAlp
ZiAoZXJyb3IpDQo+PiAgIAkJZ290byBvdXQyOw0KPj4NCj4+IC0JbW50X3VzZXJucyA9IG1udF91
c2VyX25zKHBhdGgubW50KTsNCj4+ICAgCXN3aXRjaCAobW9kZSYgIFNfSUZNVCkgew0KPj4gICAJ
CWNhc2UgMDogY2FzZSBTX0lGUkVHOg0KPj4gICAJCQllcnJvciA9IHZmc19jcmVhdGUobW50X3Vz
ZXJucywgcGF0aC5kZW50cnktPmRfaW5vZGUsDQo+PiBAQCAtMzk0Myw2ICszOTQwLDcgQEAgaW50
IGRvX21rZGlyYXQoaW50IGRmZCwgc3RydWN0IGZpbGVuYW1lICpuYW1lLCB1bW9kZV90IG1vZGUp
DQo+PiAgIAlzdHJ1Y3QgcGF0aCBwYXRoOw0KPj4gICAJaW50IGVycm9yOw0KPj4gICAJdW5zaWdu
ZWQgaW50IGxvb2t1cF9mbGFncyA9IExPT0tVUF9ESVJFQ1RPUlk7DQo+PiArCXN0cnVjdCB1c2Vy
X25hbWVzcGFjZSAqbW50X3VzZXJuczsNCj4+DQo+PiAgIHJldHJ5Og0KPj4gICAJZGVudHJ5ID0g
ZmlsZW5hbWVfY3JlYXRlKGRmZCwgbmFtZSwmcGF0aCwgbG9va3VwX2ZsYWdzKTsNCj4+IEBAIC0z
OTUwLDE1ICszOTQ4LDEzIEBAIGludCBkb19ta2RpcmF0KGludCBkZmQsIHN0cnVjdCBmaWxlbmFt
ZSAqbmFtZSwgdW1vZGVfdCBtb2RlKQ0KPj4gICAJaWYgKElTX0VSUihkZW50cnkpKQ0KPj4gICAJ
CWdvdG8gb3V0X3B1dG5hbWU7DQo+Pg0KPj4gLQlpZiAoIUlTX1BPU0lYQUNMKHBhdGguZGVudHJ5
LT5kX2lub2RlKSkNCj4+IC0JCW1vZGUmPSB+Y3VycmVudF91bWFzaygpOw0KPj4gKwltbnRfdXNl
cm5zID0gbW50X3VzZXJfbnMocGF0aC5tbnQpOw0KPj4gKwltb2RlID0gdmZzX3ByZXBhcmVfbW9k
ZShtbnRfdXNlcm5zLCBwYXRoLmRlbnRyeS0+ZF9pbm9kZSwgbW9kZSk7DQo+PiAgIAllcnJvciA9
IHNlY3VyaXR5X3BhdGhfbWtkaXIoJnBhdGgsIGRlbnRyeSwgbW9kZSk7DQo+PiAtCWlmICghZXJy
b3IpIHsNCj4+IC0JCXN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJuczsNCj4+IC0JCW1u
dF91c2VybnMgPSBtbnRfdXNlcl9ucyhwYXRoLm1udCk7DQo+PiArCWlmICghZXJyb3IpDQo+PiAg
IAkJZXJyb3IgPSB2ZnNfbWtkaXIobW50X3VzZXJucywgcGF0aC5kZW50cnktPmRfaW5vZGUsIGRl
bnRyeSwNCj4+ICAgCQkJCSAgbW9kZSk7DQo+PiAtCX0NCj4+ICsNCj4+ICAgCWRvbmVfcGF0aF9j
cmVhdGUoJnBhdGgsIGRlbnRyeSk7DQo+PiAgIAlpZiAocmV0cnlfZXN0YWxlKGVycm9yLCBsb29r
dXBfZmxhZ3MpKSB7DQo+PiAgIAkJbG9va3VwX2ZsYWdzIHw9IExPT0tVUF9SRVZBTDsNCj4+IGRp
ZmYgLS1naXQgYS9mcy9vY2ZzMi9uYW1laS5jIGIvZnMvb2NmczIvbmFtZWkuYw0KPj4gaW5kZXgg
Yzc1ZmQ1NGI5MTg1Li45NjFkMWNmNTQzODggMTAwNjQ0DQo+PiAtLS0gYS9mcy9vY2ZzMi9uYW1l
aS5jDQo+PiArKysgYi9mcy9vY2ZzMi9uYW1laS5jDQo+PiBAQCAtMTk3LDYgKzE5Nyw3IEBAIHN0
YXRpYyBzdHJ1Y3QgaW5vZGUgKm9jZnMyX2dldF9pbml0X2lub2RlKHN0cnVjdCBpbm9kZSAqZGly
LCB1bW9kZV90IG1vZGUpDQo+PiAgIAkgKiBjYWxsZXJzLiAqLw0KPj4gICAJaWYgKFNfSVNESVIo
bW9kZSkpDQo+PiAgIAkJc2V0X25saW5rKGlub2RlLCAyKTsNCj4+ICsJbW9kZSA9IG1vZGVfc3Ry
aXBfc2dpZCgmaW5pdF91c2VyX25zLCBkaXIsIG1vZGUpOw0KPj4gICAJaW5vZGVfaW5pdF9vd25l
cigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+ICAgCXN0YXR1cyA9IGRxdW90
X2luaXRpYWxpemUoaW5vZGUpOw0KPj4gICAJaWYgKHN0YXR1cykNCj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2ZzLmggYi9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4+IGluZGV4IDk4YjQ0YTI3
MzJmNS4uOTE0YzhmMjhiYjAyIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9mcy5oDQo+
PiArKysgYi9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4+IEBAIC0zNDU5LDYgKzM0NTksMTcgQEAgc3Rh
dGljIGlubGluZSBib29sIGRpcl9yZWxheF9zaGFyZWQoc3RydWN0IGlub2RlICppbm9kZSkNCj4+
ICAgCXJldHVybiAhSVNfREVBRERJUihpbm9kZSk7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIGlu
bGluZSB1bW9kZV90IHZmc19wcmVwYXJlX21vZGUoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRf
dXNlcm5zLA0KPj4gKwkJCQkgICBjb25zdCBzdHJ1Y3QgaW5vZGUgKmRpciwgdW1vZGVfdCBtb2Rl
KQ0KPg0KPiBTb3JyeSwgc2luY2UgeW91J3JlIG9ubHkgY2FsbGluZyB0aGUgaGVscGVyIGluIGZz
L25hbWVpLmMgeW91IGRvbid0IG5lZWQNCj4gdG8gZXhwb3NlIGl0IGluIGZzLmg7IGp1c3Qga2Vl
cCBpdCBsb2NhbCB0byBmcy9uYW1laS5jLg0KDQpPaCwgeWVzLCB3aWxsIG1vdmUgaXQgaW50byBm
cy9uYW1laS5jLg0K
