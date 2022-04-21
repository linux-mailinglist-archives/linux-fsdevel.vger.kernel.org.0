Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39537509A90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 10:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386600AbiDUIWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 04:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381397AbiDUIWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:22:17 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03995F91;
        Thu, 21 Apr 2022 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650529168; x=1682065168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OPq+22WZoWVq6H337z0jp62lvWevXTNey5efM/4mLl0=;
  b=TVUyvrdCDqNnOhL+SxTEQVamzQp3buMCU+5N8tVElOgnNh19BwMa17nG
   oQTZjupNF+Di7KXZmYUaTYXUolcNPb6NVVGgypzUSYuy6mqWyrOegjZbJ
   xyrSlU7MpdPFSdQTc1zjOqNj8RFerDOBWxFibkGZ34TgXFaODRsN+lZ25
   RWXshi1IfGtBs+bqsoZhzD4ZJ+Ml367zwYIm+I2fLqiTPvBSElWplA0BF
   CJAc9qp2hc76+GzK0LvmEoR1BEY0KW20IcGX7elOAFTIGdC3YP7H00B1+
   63n3LtDoe0iTcCVg9Ri7KYueQjr9hjS6BTpiNZM9ei6709IfDKd8na8v5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="54175247"
X-IronPort-AV: E=Sophos;i="5.90,278,1643641200"; 
   d="scan'208";a="54175247"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 17:19:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0KXrnDsmPPpzx/6y5VyqJ311DRzbBaPtTMGGPMEblypxi35qB02AeOsKIu4iIdOSBKdLt40EoZILEt4mkG8ZxWRoYbC8IP/Dp0mVM0X2Tx47ATi6nydVy6tT3e2XyYz8+Mdu01DbpEpi9DefI42/cDB+8MPCKwHJtnzrr9jy/TAqAFui5/Cr2ejsvxfw33QVuUpVb08BrzseoHcW59xheW5Mxmc4Q5bU7yt/nLZCt4bnwrxInVxTYrwJdrWjfhKG3d3BilWnemghxV9gwWVC3hAb1CANXzdsDX2fUS12P2yt2bnp/5fyG+KIxpPPx+5hyeDUdnxJz1Zf8IMQERYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPq+22WZoWVq6H337z0jp62lvWevXTNey5efM/4mLl0=;
 b=K6XwtRFGvOMTkB7c+6Fnz3K6Hw4Psu9SZLfyqh59DCm/bp+zAKjygaMAmNalkP1ZDqDxIfmcrt4qtTSgtER6HMnXmdFfeqntvsaREX1y4SV3gvaeO6Q0cuhWFz6fKDLVKjTYCKX3AKxkJKMnh1OaX6ajunB7rqyjfk0vWy3eH4ZfFSciGEfX96iUypBMOlwpdv3/ied+WHiui2w83R1qif3JYCGF6y95+SCSKb7x1bFs18L0lk+awe2o21R4OMTMbI2UYuk9smt2kRpftTOtFylHm2K3SeZstaAGXSAyzOQvF9y1OwT6x6N7+0EnsWVY22/EoP2I3NF9zc9HnY7OGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPq+22WZoWVq6H337z0jp62lvWevXTNey5efM/4mLl0=;
 b=WwJyp3XWjPOlaEnTzWSjwl6MjzT6oM0fnIj1PgqANZvl51tgGsc6gog1KCebqq2YxJzeI2L/XWasxvEQAzaG8NdY8lMgkysX6nRekUhEyPg0ZeK8kx8nzeKWkTcNPUVKwUfK1uYQddkInHTMxuLlc9sU8f7KtseAdJrYYv0fMuI=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB10121.jpnprd01.prod.outlook.com (2603:1096:604:1e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Thu, 21 Apr
 2022 08:19:18 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 08:19:18 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v5 1/4] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Topic: [PATCH v5 1/4] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Index: AQHYVUyPCCbG7abR4k+5ZAmuw7aI86z6AWEAgAAWIoA=
Date:   Thu, 21 Apr 2022 08:19:18 +0000
Message-ID: <626121E3.1080506@fujitsu.com>
References: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220421080122.nhcs6hksr5vdilgy@wittgenstein>
In-Reply-To: <20220421080122.nhcs6hksr5vdilgy@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 938f50c0-476f-4231-8373-08da236fa165
x-ms-traffictypediagnostic: OS3PR01MB10121:EE_
x-microsoft-antispam-prvs: <OS3PR01MB101212440416047F383102E4EFDF49@OS3PR01MB10121.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lhlgwITdSMzuJcy171JZq/LlFw7BK3T6HYRpFRJy8AKmtstoFQP4lvyrI3VXJTEY3F8T6AJ8wi7BOa117Jgdhx4gyJiZc4HTIRgGPnxiHOJob3SFfQBn+dLOn/Rwea6qNsxSI2/XDC3sYzl733S56sJ5ukGdpVgDd4NyCrrMStPNX8ZdVNHt+D9HwnDhGvCCu50y/mm3Nb0YmgkfUA7uj5dC75vubwkE93qqCSmaBpXZnOAW7A+XdBLJvi2rJNmC1LM68E0BhzselBXND5kWzJarfOoTdc/73Rcc2ABieP+DQLKkzU8WicyCMEH0yBGN4wODoYBlQRD9ZHqZL24g6W6FohbKCNPYPMZsDZzqDmW4vJD56GWt4g/iAG7aqRk7LfqT7zNx7LCx3lBXwknUqLSAvtyZzBpIH9vupnmQbF0wHhC7v7iIg7Ur/hBWRRbbOzCzD+GQgZ+KSfPUu+l87RfD1sUpVrfcDtWTWtlWggmtPdPqfotuyLlX/0wDtbpAZ8y7bPNBZy/8NU65NPTNck21Hg8Uf+NiREa6DkGDWpZ2GRc5yOtjonkPFX0rL6owDF/zOwPu6epRWBmw7dQ5003y00fiLUqz3V16zzyV4nVRjwxLZ7XBOmXcfd1gS/5iiHHc5OH7pLg2kNk/CmavftNuu9cXmYfVYkOGVzpNr60KRDlu86Y8LvgUlVwQ6pq8kGAUvgkpyn3viKLlhKi6ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(66476007)(66556008)(76116006)(5660300002)(2906002)(91956017)(87266011)(38100700002)(33656002)(122000001)(86362001)(85182001)(36756003)(82960400001)(83380400001)(64756008)(4326008)(45080400002)(8936002)(186003)(508600001)(6486002)(71200400001)(66446008)(26005)(66946007)(8676002)(316002)(6506007)(2616005)(6512007)(54906003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0F3S01QNllISm0xUStUVk41WE40cHdDV0krT1k0N2x3TVRPR0N5ZERPM0hl?=
 =?utf-8?B?cEtKcjVQRmhmUm1yQTBubjZ0OG5GaXhUTkgyQ0VPYkRUd2JJNlprRWQrSXor?=
 =?utf-8?B?Sjl0MDhJOHZXM1ZQQ0ZwR2RuSmNCNVQ1LysraWVLVmE3b1dycW00M1VITEJj?=
 =?utf-8?B?VklxOXl3RUpMQ29aTlZGUzhvQ1dpSHlRNTJreDFnelNnM3IvQ0Rtckd5VElP?=
 =?utf-8?B?aVczRlFDaWIrTjE5R2pHRU9PMWd6WEpyTWhXOE9sYUdZd3FZYkdKNDhpcndK?=
 =?utf-8?B?L3lTTDdhTlRiN056aC9FMVo1Z1l3VHFzYmR3WWk2N2NLVWZxemlkNWllZ1R3?=
 =?utf-8?B?YkVGdjlrNU5VMjl1bmRJL0NDVWhsZzBJalZCWjFjekxVbGN0VnRGNUwwMnRQ?=
 =?utf-8?B?MnBzSnoyUjBSczlqNXpFakg1dlVhWDc1emt4WHdMa1dUTUlDRjFJS1lCRlhi?=
 =?utf-8?B?VUpRWnFtRWduYUZwV0dZcklJV0FiZ2QvYXBXdEtPY09OV1pScW9lZSttU0FB?=
 =?utf-8?B?ci93VWNxbW80Tld5cy9sc2pMSXdtaXBReFByemtWakRLdXhkcjdCOW43bnFl?=
 =?utf-8?B?L1d6bkhOYUVxVk12MlFTU3F2WVRHNFhsS0cvNGFxRjlucCtSbUUxTUhCa3RO?=
 =?utf-8?B?MFRkbEU5Qi9ybDVUanVrQ0YvdjlWcy9GV3FMTCsyMW1oc3lwYjB1U2ZMY2xU?=
 =?utf-8?B?SS92UDBDQ3NmRE1wbHZxRURzbzhpMFNxeGNaQXVjMmx1aUVYU1FkOTBmQ1ZB?=
 =?utf-8?B?N3RZNVVJUmt4RVQwUXNuZ0pmd1pSWUtKdndpWmNNS3JKUEdDVjh6cUZBVmY1?=
 =?utf-8?B?czlMWEZ2Zm9iOHNvUTlYRlM2azlFRXpMSC81Z1ZKZndOWWhpa2ZKaUZWUHNW?=
 =?utf-8?B?Yis4a1cwNmY0YkYzc1ZlaHJaUlRWQnlnc2RWM3JOWGI1WjBaTjFmeVhYLzY1?=
 =?utf-8?B?dndIRm5WUnBnRWZPb0RHSThnM01NcmlBQ2JqVklGQkNWZEtINldVRXFHMm1m?=
 =?utf-8?B?RVhNWjZlcXMyVUxZYlhIU1BQQzIwQzlUNHlYcFNFcU5HUXdzcWQxMEVwM21o?=
 =?utf-8?B?MnB4RDVDcjI5TlpZKzB0aUY1cjBnK2JtaWdrMWlVSHNGWWdENUViZ2ZQS0JW?=
 =?utf-8?B?eWpteEV6cUUzaGVsMTVVRHVMYytQbHlYd2hmak84ZlVXSGxGQXVQalQ1MmxI?=
 =?utf-8?B?N3JvZko4N0NWRThNZWQyK3VLdFFzOWdibWFjbDFRZ053UWM2MDliSU5JSTgx?=
 =?utf-8?B?VEhnOUFIckx2d0JGNUhhTjFPK2huWERFVTVlMHM2NU1mTWJDRUp1YWNGdm9M?=
 =?utf-8?B?T2Nma1p5blZuaTU3YnRLa0ZDTjgvK3JiZmpETnFJZUwxa2JkN2hhTnhtdFl3?=
 =?utf-8?B?dmpjaGg2cVBrWElKTjZ5V2xUTDhkanZVUThRSS9vQ2ZqNFMvdlY0aWpIUXNm?=
 =?utf-8?B?QVU4UzVUdG42WnV6OFBCTW0yT29Pd014dkpsUnVlNk5Zb21WTGxuVWhCai9j?=
 =?utf-8?B?bnBEK2F2TTdLUDA3MGI3NG1RNldqUVMzclhBNEsrRHNIbG9KdWJyY0ZBMFFw?=
 =?utf-8?B?bWpFd05rQXJaUjJvemRJZGEreDJsalZ0MHl1cExYbWJScU80b2NYQWdVR09Q?=
 =?utf-8?B?azh0aE5mMUZRK0RKM2VGYjdEOExhWUdzRENaNy9YQUdtN3FVUnBOVmpzTElJ?=
 =?utf-8?B?RVF6YStnbGdJb3dSOUs3eFhlSjlBaHBiUHFXVFdJMHk1S0dqSjRrU1BobDJp?=
 =?utf-8?B?YnROdFNlMDREZW5oQmVjVGtzcmtLYXFlZVowcDBxRTJtUVBCK25jek9xQUJn?=
 =?utf-8?B?Wkp4QU5QQ2k4dWo3OG83Q3c3UzdjZkZ3dlBiSTVkNkttUVNNeFZERlFGK3oz?=
 =?utf-8?B?TENjV240OGx1VHBKSEx1eWxocEIrZnJpenhPRUxTQnNTRnM4ODYyRnNRa0Vk?=
 =?utf-8?B?dWo3bmppUEJSdUxTNDl2N2Q1cXhqWHVVS09HYld0UWltdU9FQ0ZJSmxWWEQ1?=
 =?utf-8?B?RnVYMDBnWkdaSXhHQjRvYXBzaUNmM1NlSmlUMUFyU3NUWm5MY2JYWHNrVEJw?=
 =?utf-8?B?aUhjL1A4bitjVFhCKzZabjZyV2RlNGltdG0rZnF6Znp2ME1kUVlGcGhyeGhm?=
 =?utf-8?B?UDJzcUY5ZldZVE95N05KWG5HcTcwaWlsUW51M29vZ2pVVDN3ZFRZaGwxR0hD?=
 =?utf-8?B?MENjWjI4V3lYQ3g3dzF1RldRbjNMaFRSb2N5cDlldGoxb2lwb1d6L3kzT3lY?=
 =?utf-8?B?WW5haEprR050N3lmVFFDOEpnTkVoenUyYVFFNHhKVG8vVk00TmxyZE9GQ1FI?=
 =?utf-8?B?VmF3MVlkSTdnQmNKUmZpVjdpc3U2SGwvQzVaWFZSbTVxaEJtOUs1d0VlN2xy?=
 =?utf-8?Q?udPiTZcM8Y8EvADo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D183B56A001E3343B294284CDA5E7108@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938f50c0-476f-4231-8373-08da236fa165
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 08:19:18.2004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVSnPLxL3KlHYX3exklRtrKaYmMWbR2NCdK2nElluMvEfdi6QH/ubgmyp7ER3FeaKrl1C6zlGuLrhKW/AOhzdccITkwgdueZ9fULTGYb0HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10121
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzIxIDE2OjAxLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVGh1LCBB
cHIgMjEsIDIwMjIgYXQgMDM6NTQ6MTVQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFRoaXMg
aGFzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlLiBKdXN0IGNyZWF0ZSBhbmQgZXhwb3J0IGlub2RlX3Nn
aWRfc3RyaXANCj4+IGFwaSBmb3IgdGhlIHN1YnNlcXVlbnQgcGF0Y2guIFRoaXMgZnVuY3Rpb24g
aXMgdXNlZCB0byBzdHJpcCBpbm9kZSdzDQo+PiBTX0lTR0lEIG1vZGUgd2hlbiBpbml0IGEgbmV3
IGlub2RlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHU8eHV5YW5nMjAxOC5qeUBmdWpp
dHN1LmNvbT4NCj4+IC0tLQ0KPg0KPiBDb3VsZCB5b3UgcGxlYXNlIGFkZCB0aGUga2VybmVsIGRv
YyBJIHNrZXRjaGVkIGJlbG93IHRvIHRoZSBuZXcgaGVscGVyPw0KR3JlYXQsIHdpbGwgc2VuZCBh
IHY2IHBhdGNoIGZvciB0aGlzIGFuZCBhbHNvIGFkZCBmaXhlcyB0YWcgYW5kIGNjIA0Kc3RhdGJs
ZSBrZXJuZWwgZm9yICIgZnM6IEFkZCBtaXNzaW5nIHVtYXNrIHN0cmlwIGluIHZmc190bXBmaWxl
IiBwYXRjaC4NCg0KPg0KPiBMb29rcyBnb29kIHRvIG1lLA0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0
aWFuIEJyYXVuZXIgKE1pY3Jvc29mdCk8YnJhdW5lckBrZXJuZWwub3JnPg0KdGhhbmtzIGZvciB5
b3VyIHJldmlldy4NCj4NCj4+IHY0LXY1Og0KPj4gdXNlIHVtb2RlX3QgcmV0dXJuIHZhbHVlIGlu
c3RlYWQgb2YgbW9kZSBwb2ludGVyDQo+PiAgIGZzL2lub2RlLmMgICAgICAgICB8IDIzICsrKysr
KysrKysrKysrKysrKystLS0tDQo+PiAgIGluY2x1ZGUvbGludXgvZnMuaCB8ICAyICsrDQo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZnMvaW5vZGUuYyBiL2ZzL2lub2RlLmMNCj4+IGluZGV4IDlkOWI0MjI1
MDRkMS4uNTcxMzBlNGVmOGI0IDEwMDY0NA0KPj4gLS0tIGEvZnMvaW5vZGUuYw0KPj4gKysrIGIv
ZnMvaW5vZGUuYw0KPj4gQEAgLTIyNDYsMTAgKzIyNDYsOCBAQCB2b2lkIGlub2RlX2luaXRfb3du
ZXIoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5vZGUgKmlub2Rl
LA0KPj4gICAJCS8qIERpcmVjdG9yaWVzIGFyZSBzcGVjaWFsLCBhbmQgYWx3YXlzIGluaGVyaXQg
U19JU0dJRCAqLw0KPj4gICAJCWlmIChTX0lTRElSKG1vZGUpKQ0KPj4gICAJCQltb2RlIHw9IFNf
SVNHSUQ7DQo+PiAtCQllbHNlIGlmICgobW9kZSYgIChTX0lTR0lEIHwgU19JWEdSUCkpID09IChT
X0lTR0lEIHwgU19JWEdSUCkmJg0KPj4gLQkJCSAhaW5fZ3JvdXBfcChpX2dpZF9pbnRvX21udCht
bnRfdXNlcm5zLCBkaXIpKSYmDQo+PiAtCQkJICFjYXBhYmxlX3dydF9pbm9kZV91aWRnaWQobW50
X3VzZXJucywgZGlyLCBDQVBfRlNFVElEKSkNCj4+IC0JCQltb2RlJj0gflNfSVNHSUQ7DQo+PiAr
CQllbHNlDQo+PiArCQkJbW9kZSA9IGlub2RlX3NnaWRfc3RyaXAobW50X3VzZXJucywgZGlyLCBt
b2RlKTsNCj4+ICAgCX0gZWxzZQ0KPj4gICAJCWlub2RlX2ZzZ2lkX3NldChpbm9kZSwgbW50X3Vz
ZXJucyk7DQo+PiAgIAlpbm9kZS0+aV9tb2RlID0gbW9kZTsNCj4+IEBAIC0yNDA1LDMgKzI0MDMs
MjAgQEAgc3RydWN0IHRpbWVzcGVjNjQgY3VycmVudF90aW1lKHN0cnVjdCBpbm9kZSAqaW5vZGUp
DQo+PiAgIAlyZXR1cm4gdGltZXN0YW1wX3RydW5jYXRlKG5vdywgaW5vZGUpOw0KPj4gICB9DQo+
PiAgIEVYUE9SVF9TWU1CT0woY3VycmVudF90aW1lKTsNCj4+ICsNCj4NCj4gLyoqDQo+ICAgKiBp
bm9kZV9zZ2lkX3N0cmlwIC0gaGFuZGxlIHRoZSBzZ2lkIGJpdCBmb3Igbm9uLWRpcmVjdG9yaWVz
DQo+ICAgKiBAbW50X3VzZXJuczoJaWRtYXBwaW5nIG9mIHRoZSBtb3VudA0KPiAgICogQGRpcjog
cGFyZW50IGRpcmVjdG9yeQ0KPiAgICogQG1vZGU6IG1vZGUgb2YgdGhlIGZpbGUgdG8gYmUgY3Jl
YXRlZCBpbiBAZGlyDQo+ICAgKg0KPiAgICogSWYgdGhlIEBtb2RlIG9mIHRoZSBuZXcgZmlsZSBo
YXMgYm90aCB0aGUgU19JU0dJRCBhbmQgU19JWEdSUCBiaXQNCj4gICAqIHJhaXNlZCBhbmQgQGRp
ciBoYXMgdGhlIFNfSVNHSUQgYml0IHJhaXNlZCBlbnN1cmUgdGhhdCB0aGUgY2FsbGVyIGlzDQo+
ICAgKiBlaXRoZXIgaW4gdGhlIGdyb3VwIG9mIHRoZSBwYXJlbnQgZGlyZWN0b3J5IG9yIHRoZXkg
aGF2ZSBDQVBfRlNFVElEDQo+ICAgKiBpbiB0aGVpciB1c2VyIG5hbWVzcGFjZSBhbmQgYXJlIHBy
aXZpbGVnZWQgb3ZlciB0aGUgcGFyZW50IGRpcmVjdG9yeS4NCj4gICAqIEluIGFsbCBvdGhlciBj
YXNlcywgc3RyaXAgdGhlIFNfSVNHSUQgYml0IGZyb20gQG1vZGUuDQo+ICAgKg0KPiAgICogUmV0
dXJuOiB0aGUgbmV3IG1vZGUgdG8gdXNlIGZvciB0aGUgZmlsZQ0KPiAgICovDQo+PiArdW1vZGVf
dCBpbm9kZV9zZ2lkX3N0cmlwKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywNCj4+
ICsJCQkgY29uc3Qgc3RydWN0IGlub2RlICpkaXIsIHVtb2RlX3QgbW9kZSkNCj4+ICt7DQo+PiAr
CWlmIChTX0lTRElSKG1vZGUpIHx8ICFkaXIgfHwgIShkaXItPmlfbW9kZSYgIFNfSVNHSUQpKQ0K
Pj4gKwkJcmV0dXJuIG1vZGU7DQo+PiArCWlmICgobW9kZSYgIChTX0lTR0lEIHwgU19JWEdSUCkp
ICE9IChTX0lTR0lEIHwgU19JWEdSUCkpDQo+PiArCQlyZXR1cm4gbW9kZTsNCj4+ICsJaWYgKGlu
X2dyb3VwX3AoaV9naWRfaW50b19tbnQobW50X3VzZXJucywgZGlyKSkpDQo+PiArCQlyZXR1cm4g
bW9kZTsNCj4+ICsJaWYgKGNhcGFibGVfd3J0X2lub2RlX3VpZGdpZChtbnRfdXNlcm5zLCBkaXIs
IENBUF9GU0VUSUQpKQ0KPj4gKwkJcmV0dXJuIG1vZGU7DQo+PiArDQo+PiArCW1vZGUmPSB+U19J
U0dJRDsNCj4+ICsJcmV0dXJuIG1vZGU7DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1CT0woaW5vZGVf
c2dpZF9zdHJpcCk7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mcy5oIGIvaW5jbHVk
ZS9saW51eC9mcy5oDQo+PiBpbmRleCBiYmRlOTUzODdhMjMuLjUzMmRlNzZjOWI5MSAxMDA2NDQN
Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvZnMuaA0KPj4gKysrIGIvaW5jbHVkZS9saW51eC9mcy5o
DQo+PiBAQCAtMTg5Nyw2ICsxODk3LDggQEAgZXh0ZXJuIGxvbmcgY29tcGF0X3B0cl9pb2N0bChz
dHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwNCj4+ICAgdm9pZCBpbm9kZV9pbml0
X293bmVyKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0IGlub2RlICpp
bm9kZSwNCj4+ICAgCQkgICAgICBjb25zdCBzdHJ1Y3QgaW5vZGUgKmRpciwgdW1vZGVfdCBtb2Rl
KTsNCj4+ICAgZXh0ZXJuIGJvb2wgbWF5X29wZW5fZGV2KGNvbnN0IHN0cnVjdCBwYXRoICpwYXRo
KTsNCj4+ICt1bW9kZV90IGlub2RlX3NnaWRfc3RyaXAoc3RydWN0IHVzZXJfbmFtZXNwYWNlICpt
bnRfdXNlcm5zLA0KPj4gKwkJCSBjb25zdCBzdHJ1Y3QgaW5vZGUgKmRpciwgdW1vZGVfdCBtb2Rl
KTsNCj4+DQo+PiAgIC8qDQo+PiAgICAqIFRoaXMgaXMgdGhlICJmaWxsZGlyIiBmdW5jdGlvbiB0
eXBlLCB1c2VkIGJ5IHJlYWRkaXIoKSB0byBsZXQNCj4+IC0tDQo+PiAyLjI3LjANCj4+DQo=
