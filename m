Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5F95B5D07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 17:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiILPWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiILPWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:22:30 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on0101.outbound.protection.outlook.com [104.47.25.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7403E1CB30;
        Mon, 12 Sep 2022 08:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOsXyCopBE/KejaD1CzQ8eLvVvCiFzkjmn1hWY2Gp9m431jqYhrMfveShYE/WIPQyxTyrLzw9pWIscpEOuoisL3kbrbjvt22msAKdWSfSEzd7uximUrTs5d7u6f50R4pbmN3om0kHrtOj4cQ5C19LAkMp2GRP741frhLQSZ/VrxIUBm8rkivhZy/LL/CwTaBftrCLTvgUqhBor4QblW5E5xBpL0fLM9tBn3ni7vAdp9xSxTI4G+y3thdiVHr04nbWEVrNCYuav5BKAjNKwPWlBqKl7y6W2Fkl+vp+gqigUAg2SWnrOAeyqBitWkDclpI6UcmusZtsjTokYZkhydbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TINFsMBUUJDIqfyoK7LDpdoWPB9yZrb63k4DjzSupvI=;
 b=SZR81c9G/MljOivjMzVGIDk4xay4uhxfqcjCYRLO46g59skkC7IQPqiK5usaz/aGG8/OfK1gd+NWAWAWCsBYgduPP+mEHlunhnwp91+/ZIPLp8dLgdadB0H5SJM4QTPKaLuj4VcoHJorR/4bthIeReBQeSdBEZo7KuDjJl2TovCshimn1wZbLnKLMfpSGqHRKPAVIQ6E0QHFSj4v4+kcCBldBWORryw943AhnVpnJErcf1kizh0B+zPpRnzPQKkzL83skenTtQI1o16WujjzyM4q8PlKzfqvoeQFCJn8TOtDToeFWLfookeJ04Eq7Pirlv6EfmIjiFooMtJtPDtojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TINFsMBUUJDIqfyoK7LDpdoWPB9yZrb63k4DjzSupvI=;
 b=SSMJAlWS9VuvZeI5vNz2t7kiZPzITgdB9kKcy5F3r6YbaSbQEgmriDezeg8ym54Xs/K96TW/iUyKEbAb3YImpUk9EV6yjR7cio82Jb/JMhyFGALLlbfcLOaE9zvo+6xqb8GtJTvwV/yAIBwG0E3YPiMdR9Out7uT1eJExOd+JhNlzFU9eMTehgmzxpYjYHzXCoucvmOlUyGMPdCboZySRm3dSIDJP/6FiZtY1jI4OT1HEqihAn0C9FrpEI4sYJ/LA/Vf4xYMAvrFLgi/JjKegqq0hlcI2VbIesqjbzA5Wl9MKQEgBCz5DrDq44R7kptzKkK8LI1X3+6raDf/MLz4+g==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1674.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 15:22:25 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%5]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 15:22:25 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: State of RFC PATCH Remove CONFIG_DCACHE_WORD_ACCESS
Thread-Topic: State of RFC PATCH Remove CONFIG_DCACHE_WORD_ACCESS
Thread-Index: AQHYxq4wmGXci5t3SUq1L5YpNHl6Yq3b6Y+A
Date:   Mon, 12 Sep 2022 15:22:25 +0000
Message-ID: <91e6cf8b-f66a-3ea1-daa0-2ea875b7e7e8@csgroup.eu>
References: <CAKXUXMzQDy-A5n8gvHaT9s21dn_ThuW0frCgm_tXMHPUhLY2zA@mail.gmail.com>
In-Reply-To: <CAKXUXMzQDy-A5n8gvHaT9s21dn_ThuW0frCgm_tXMHPUhLY2zA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1674:EE_
x-ms-office365-filtering-correlation-id: 2629f0af-6ca8-46ba-064f-08da94d29918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S6ZWdIUMuk8HtAbqOx80wfoXozT23sCnmy0RMZuMGVCG89/Qp6bb74lYR8lT+1gL4AnS83EMBSh2NFKdPYArjCCN3yNfu3TTnCv2OrUmCaWGnTBSXTiSov5GaTz3Yh3ZxHpGUv4QhYMq3bERngorX9FB/8kMQI50d0tG9ocImgqwLhp16n6OU8yPAozEG2Cq0zX5xyWfITWNx1iRt426Rkfmwa8AurS8EVSAf4pRALRmtzY0Qby4q0cMfXV8AAxZW+Fo+O9+2VAFGf1qyEI0BmzBPmCqO25aVeYllqRikcfotTMfDLRC7cfU3eE/stjQRuT6hgFgtU8zxFDdMwrhfLXqQo4d6EWh4vtKLXMep4xKXN7biqCkGIWv7+aiVUzkwCWvJV428o3T64x5DMO9zj2xTGOf57GeoQU9FKZTDYdzt6obuKQUm5nHyDBfWYDiZMbSxU5vqfpjEryLjyRx3BbhHL7uRTgqWE8AzLpAOnHlk5IrUwVUdgH4YZZMeRKjz5Uoo30v8FD0WXx+D/KCIzwKNIbFaf1iNTcMNY8oohonoB4zd2DToVwIHQKvx3EzmJAiCclDzyH/uW2PbVy3R2URx+ooFUSRvzoRNiKZpBGZRh/aUsSTNlx3RQxgFtAuwEYc5aYAZTkJ01jebXB1U71X3ljOZi2SlQQzLrDrddQVVkYIhdTRHdiEwHgwrNZHSINPU0b4z7A/sc+qYBY2knfjpVQg0lXSrJ29X74D2nwXiIIRlWhyiilkc8w7RwE7hIJFVEG9KpuGFKo6QDCWHaHeOcvwknlCODCDDIDFz7Vb8NhHQuXEW09SBU41nCjniXycXmj7JNUO+stFvrnmfgKP+EVjo1eAps4q9ZaOw4w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(86362001)(38100700002)(36756003)(66946007)(76116006)(66476007)(66556008)(122000001)(66446008)(64756008)(91956017)(31696002)(38070700005)(31686004)(8676002)(83380400001)(2616005)(6512007)(71200400001)(6486002)(186003)(66574015)(478600001)(41300700001)(26005)(966005)(316002)(6506007)(110136005)(44832011)(8936002)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDViVVUzNURkVm85dDRHMUlFZnp6enBMRjdBbWovWmplUWphVDY4aE1uSFR0?=
 =?utf-8?B?Nk1NVzc5TjZLN2lrZklPb1RQR2JwditSc0g0Q0NXc1I0QXZHRXVPNHdReDdR?=
 =?utf-8?B?K1BuYWxKb1Z5ZzhleTh0bzRpWjdxTUd3andUcnB1MkFkREVLbGhVUzhWM1BI?=
 =?utf-8?B?NVU5bDNOaWpaZUdxM0FHbTRiSC9TWDQ2Wm1aNzR4N3VmS1NjU2tNandJaVlB?=
 =?utf-8?B?bTJ2emNOcWVFcnkzelRvTHNIc2k4UnNnWWd5b1d5bHltUFNoZlB0eWt1aFZG?=
 =?utf-8?B?TngrOTh0S0p5K2VCUWNZdjlEaGU5ckFPUWpEUERuSTJhOUJBd095MmJLV0k0?=
 =?utf-8?B?TUlKVGxKeWpURm9GSWltajJJTDVwQ2p3YnJqTU9idmJzbEhIeU1GSWN4MXA0?=
 =?utf-8?B?K3F1cWFNSnNrQlhqcStxcGk1c016OWtlUzJMaWFqL2lyaU9ybnVYakpjZzJn?=
 =?utf-8?B?U0ExZTZQU0ZoMHM3bWZ1S1E2NFI4TWxncWZ5bDFWZU5DbmtYWTUydGFVYVIx?=
 =?utf-8?B?elJrNUZkTGpnRXgrTjRzTWdqbUY1Y2NkaE9RcHR4dW1WT2dBRTNKbUIrakt4?=
 =?utf-8?B?Q1hsdGJPL1lWYXBxVVFjRkpOamJxUWNpSlNDZlRFTWgwWW5vdG1IWmw0Wm5X?=
 =?utf-8?B?SzNOTnkrZGpJK1JYZFdUV0JGK2VMMVdBelhWMEsrVC84VnJxZ3lWT0NVa1kx?=
 =?utf-8?B?ZG00Um9lalFjdzJOOStZMEhDUlFTdWdNcW1NWFFyLzR4aFYvei9rT2NvdzJV?=
 =?utf-8?B?NlVYT2Z4a1NTQ20zcjFSTkcyYnhOSWRydExNS3F0WUZyWDVmNFZiWFAveGZI?=
 =?utf-8?B?Qk1EZklURlBielYxLytMbXQxYU53RGdXMkp5dERBT25EaDRuZmFHUmRXUjlm?=
 =?utf-8?B?dVFkRlRITGgvUlh6YVFqU1dIQjFvQ1N4NE5iVUtYNkd1blJQOExiQ3RtWWN2?=
 =?utf-8?B?TU8yR2NadjlFN2wyRTY3V1p6QVhzWWNhOFV0bkhRaUNKanNVMFdiSWY1alNt?=
 =?utf-8?B?dzRzSkVPTVBuVlI5R2svM2RHaVpPOHdGeXFQRnF5NnpFQkxtMzU5MjNkVnli?=
 =?utf-8?B?Vm9oK0J0Z1hJRUFqWUFnZng4bVdiMGEzcytWRFhLUEI1YlowZGkrZzBxcG4z?=
 =?utf-8?B?UE1xYmdGeDlTSU1DY1ZIbmFGby9GL29PQitHNmVtN0hHUzNjT1ZPUHFveUFx?=
 =?utf-8?B?VzFJYURQckhWajQ5Ykw4S2l3RkYrRHVsWHVzeDl3Q0JsR2RGSlBlRGs0RWVG?=
 =?utf-8?B?dnhTTHBmR1BabkxFbFNZZ1FoZnF5ampJYUJlb0cyYWpzK2M4QmhLaHA5NjZw?=
 =?utf-8?B?RTRPYmZPdnZwOGU3ZlBuTkFvaUlGbEsyVncxWndZcHozTUJRUWliUS9DT2dv?=
 =?utf-8?B?UlRJbXg2eHRsbEI2eEdiMytkbDNoNkwxOW5YUFFZMUtteVlZZ0ZEYW5qR2tw?=
 =?utf-8?B?N04vVWNFblZwUEg1WnNGaDczUDFreFYxTFB2NkNMZUIxaWtlUzV3MjBBQXlJ?=
 =?utf-8?B?Z1Z4OEtHdFR2elliS3RwWnl2UGZZL1hWR1BteVQ4VTQwR2ZOcVNiZk5PK0hq?=
 =?utf-8?B?OVZzRnNFcGJzc0V6SXpHc2FmeEZ6cm81VjJGT3o2dkU0VmhQOEYrTnZaN2tK?=
 =?utf-8?B?VjgrMlFiai9GZjd1WDZnay80aDgzWk1VS1R5MDN3WFZmODI4Mm5uMkRnOFVH?=
 =?utf-8?B?THh5NXRSMk1sSFJ2RFIzb25VOXhvc0t0NEkzZ2pnRjVrcmN4OWhUalJUTnc0?=
 =?utf-8?B?UlQyZE85d3dhYjhwbVN1TXhUVGhCc3BlMXdBRHhSS3htVEJpNm9IbkhJeWI1?=
 =?utf-8?B?TFRIWXY2QStlTHorUnBJK3Z6L09FelFISUt2WlZHYnRxcHlsSklEZzVvejdP?=
 =?utf-8?B?ZUtsZFdOcjQzcnBab2Y4aWlBYjhWZlZkNWRlM2xNS1UySDBUU0c2UWtvNGkw?=
 =?utf-8?B?Slg0ZXRmd0VvY3BBcExTTmVWSEppZGtTU2FleUtwQml2K1lhMzhHampZM0xN?=
 =?utf-8?B?cUJXY3NrMW9sbVg1QjhLZ2NTMkRjS2FoQVlVNDZWT0drVVY5Y0w4Q0gwSFdl?=
 =?utf-8?B?WjF2ZGkrRVNjYVdMZU1mNTdLZlRydm5uZ216Y1RTa3VQeWZlSUlhaXhTRWV1?=
 =?utf-8?B?VnRsMHM2M2dvbFVpMTkzYVBpQ296b0h2dUd4WVluOXdrNEFIY1lwL29aRmVl?=
 =?utf-8?Q?U3ndY7TlQqiy7ab4bJ2irio=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <767D4DD0DD14E24B87D2EE3575C4B80E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2629f0af-6ca8-46ba-064f-08da94d29918
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 15:22:25.8253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Beq63pCaZycWIJkrH9g4hSB2ZRuw9/mHptuVe1mdiMb1sXztpleIfa3n2RwAI+SADPoUPnK6A8qqOSZnYxgAQIPwTKv+Y/LsjY6QXPkw2LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1674
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCkxlIDEyLzA5LzIwMjIgw6AgMTU6NDYsIEx1a2FzIEJ1bHdhaG4gYSDDqWNyaXTCoDoNCj4g
SGkgSm9lLCBoaSBCZW4sDQo+IA0KPiBXaGlsZSByZXZpZXdpbmcgc29tZSBrZXJuZWwgY29uZmln
LCBJIGNhbWUgYWNyb3NzDQo+IENPTkZJR19EQ0FDSEVfV09SRF9BQ0NFU1MgYW5kIHRyaWVkIHRv
IHVuZGVyc3RhbmQgaXRzIHB1cnBvc2UuDQo+IA0KPiBUaGVuLCBJIGRpc2NvdmVyZWQgdGhpcyBS
RkMgcGF0Y2ggZnJvbSAyMDE0IHRoYXQgc2VlbXMgbmV2ZXIgdG8gaGF2ZQ0KPiBiZWVuIGludGVn
cmF0ZWQ6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMTM5Mzk2NDU5MS4yMDQz
NS41OC5jYW1lbEBqb2UtQU83MjIvDQo+IFtSRkNdIFJlbW92ZSBDT05GSUdfRENBQ0hFX1dPUkRf
QUNDRVNTDQo+IA0KPiBUaGUgZGlzY3Vzc2lvbiBzZWVtZWQgdG8ganVzdCBub3QgY29udGludWUg
YW5kIHRoZSBwYXRjaCB3YXMganVzdCBub3QNCj4gaW50ZWdyYXRlZCBieSBhbnlvbmUuDQo+IA0K
PiBJbiB0aGUgbWVhbnRpbWUsIHRoZSB1c2Ugb2YgQ09ORklHX0RDQUNIRV9XT1JEX0FDQ0VTUyBo
YXMgc3ByZWFkIGludG8NCj4gYSBmZXcgbW9yZSBmaWxlcywgYnV0IHJlcGxhY2luZyBpdCB3aXRo
DQo+IENPTkZJR19IQVZFX0VGRklDSUVOVF9VTkFMSUdORURfQUNDRVNTIHN0aWxsIHNlZW1zIGZl
YXNpYmxlLg0KPiANCj4gQXJlIHlvdSBhd2FyZSBvZiByZWFzb25zIHRoYXQgdGhpcyBwYXRjaCBm
cm9tIDIwMTQgc2hvdWxkIG5vdCBiZSBpbnRlZ3JhdGVkPw0KPiANCj4gSSB3b3VsZCBzcGVuZCBz
b21lIHRpbWUgdG8gbW92ZSB0aGUgaW50ZWdyYXRpb24gb2YgdGhpcyBwYXRjaCBmdXJ0aGVyDQo+
IGlmIHlvdSBjb25zaWRlciB0aGF0IHRoZSBwYXRjaCBpcyBub3QgY29tcGxldGVseSB3cm9uZy4N
Cj4gDQoNCkFzIGZhciBhcyBJIGNhbiBzZWUsIGZvciB0aGUgdGltZSBiZWluZyB0aGlzIGlzIG5v
dCBlcXVpdmFsZW50IG9uIHBvd2VycGM6DQoNCnNlbGVjdCBIQVZFX0VGRklDSUVOVF9VTkFMSUdO
RURfQUNDRVNTICBpZiAhKENQVV9MSVRUTEVfRU5ESUFOICYmIA0KUE9XRVI3X0NQVSkNCg0Kc2Vs
ZWN0IERDQUNIRV9XT1JEX0FDQ0VTUyAgICAgICAgICAgICAgIGlmIFBQQzY0ICYmIENQVV9MSVRU
TEVfRU5ESUFODQoNClRoaXMgd2lsbCBuZWVkIHRvIGJlIGludmVzdGlnYXRlZCBJIGd1ZXNzLg0K
DQpJbiB0aGUgbWVhbnRpbWUgSSdsbCB0cnkgdG8gc2VlIGlmIGl0IG1ha2VzIGFueSBkaWZmZXJl
bmNlIGZvciBwcGMzMi4NCg0KQ2hyaXN0b3BoZQ==
