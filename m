Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA9150B4C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446452AbiDVKRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 06:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiDVKRA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:17:00 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BF46362;
        Fri, 22 Apr 2022 03:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650622441; x=1682158441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+gI289bSGWfZGzh4iVKMoCoclBexIBP9W3QQr4n6lc=;
  b=EfHo69MlOjLyuvbAqLSEA2/5ww4J30kEOL2yu0vYgG67zEVNc2mVFoSV
   B2SxFzkIKLhtYRrWngPXOTRH7zSShr2byJqNI3eO4cxRSH6v82qU2Wny8
   ts2NN10r9+FI31ecNCzkSBUC13eC9Atjd+huP1ZeIWQ5Vbi869VptTI2u
   OX2Yg1PSE3VAyy/1PcU17FJZrQZlc0ThfmSb+4iQzzKQ0Hq0MjPzSQDpw
   up/dBettoSbySzeHTqkcMgPT1InQn+Z8roJ61wnTmT97PhddrLjb9Tc+J
   X8a9GG63ookQ9dNXJzPvN/obszX4mXnxJFjbMYwYSjDraWqDcjCtQQ5sR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="54493583"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="54493583"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 19:13:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjpQkRyPoGbSeLKuUdZhec/MNfwb/8xIUZkVxIlphg7B1Rv0AWkQ71pImywp7DiYBmk8MbYqiS+NvNaxtQv7UfT0ENwFqVyOqutb6ar7d0w1MIqXLhv/5FYMfmyA1A0lZs9HrIIzPqpmnTKZ0RziqnlcOETxUthojgmw2xsiTSLn94EExUycKjku/9/yk9ylicnwQ0Qwfh5qxr6BnpHlPZGajQlTk7PA5mNYlqaEoDhVI23B1Zv7o27ruudCVOm9+2zfT5NuEDU6wbig5iomjUU2kvNb0gfOMkfVvES0XkILnTbqoWTsdGPpBm/9KibKaxzIj+rvOTtAretGdb/Yvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+gI289bSGWfZGzh4iVKMoCoclBexIBP9W3QQr4n6lc=;
 b=cmTVaDo9nHNlb4+vshvgB8GqjikP2sIVN8XUAYVM3sbe6PIAScsrQTPcf3DW5cufXcnkhlEk5VWUzcBxyeRyE0lOdiAkntF2+d7RSzJawupQNJ3XiPB4w+AiYOvYCf5jsgXiDcr25LL1mBIwmcvo4XLfnUF23NWRcrNNaK7FqKkDm7+8Cm9kHjJs2lzeL+fnggE68XfGRSfgFyucGcDRF7/pM0goCVsj+/k8NJAemFr+C9TDinNW28qKyhoLkTAr26D+ej5tL/XRcPgQQo/UQ3hcdIkdYFvLzoAJadfJzOvOD00Mh65OwykgkXfwrXLrBTimDn1avir5CUrNhCG96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+gI289bSGWfZGzh4iVKMoCoclBexIBP9W3QQr4n6lc=;
 b=It5pZ2kx1zPUXM7vdNigo83e/WZF5/VN8eyYJm7AHay0RAazp5sXIZwFXyfKAOLS9iJw4gzlATtyiSalHJyXAuXr+E2AInyMxeDrqHuNl0fLQ7dPZ5BtbzVzr93FNuRtjrupfEe6iOPlXirpJbMi1EUwGfd5QtaJkI9dNwtYcZk=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB8088.jpnprd01.prod.outlook.com (2603:1096:400:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 10:13:53 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 10:13:52 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v5 3/4] fs: strip file's S_ISGID mode on vfs instead of on
 underlying filesystem
Thread-Topic: [PATCH v5 3/4] fs: strip file's S_ISGID mode on vfs instead of
 on underlying filesystem
Thread-Index: AQHYVUycADeAybUFHk63mGLHHkoIM6z6Cs+AgAF5AQCAAC2ZAIAAGHMA
Date:   Fri, 22 Apr 2022 10:13:52 +0000
Message-ID: <62628E3E.3070604@fujitsu.com>
References: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650527658-2218-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220421083507.siunu6ohyba6peyq@wittgenstein> <6262537C.9020908@fujitsu.com>
 <20220422094740.4d4wcx5fv4zkwcc2@wittgenstein>
In-Reply-To: <20220422094740.4d4wcx5fv4zkwcc2@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d52454e9-3f0d-4648-7f7f-08da2448cd51
x-ms-traffictypediagnostic: TYCPR01MB8088:EE_
x-microsoft-antispam-prvs: <TYCPR01MB8088D51A2504BCA7F00AC0B3FDF79@TYCPR01MB8088.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WXkG4y4jo3WiOhKmzH59koMzLRP+V11TziEIslrE1UmRnwr69SOLC+d2CEl2lhPxpxPwxk9iBjoRZAymxIl45+ZzLXKZF4zn6QAYViCN++3AkKKqy3yFFu3YUSosHoYQQNKdOmmtINln6CUJCn+UJP++Hjk63x5J96QerKxUSKtr5St8OgLEJkST9GqFJYlIkdSS/N/c1Mlr3ByVqtXtKWTokeLCSMHI9EJ040K7CCMETfthZXks5j3zU/gVGMUtMFSXnPAGwEfrdcFoxfNz3t5oLKgd8BYhFlMjkxcmJbliu9iydfH/bi6YQcX5Xcf3i5nPy/6g00/32vLbOOmnG7iJ5Z2ZeWTlh9wtm4VCBK5SP5ifNV6dAd/UuOInwtzfPNxwIpST++mTay5s+DxYPecYGgE/CfgPQaq4pSCZwV9yfaGMKjLhjPYvsU081amVj5sNEZP35eDTy6vd/jR+dlXLlck88O8UkIgXJJ//mjYV/aTS7qPTz9ssKo7OkbLA/pdx4Uk4Ou0V/si5cB9ZPFnpU2xGtD56NtOc/EMQhwrZIUk+Zy0F3ZM06ih30bfp942HvZPVimJDYLvk/UgkoYHtAN723nwT+E2W241ekz4kurwkmNJI4A70eOvtr2Ix6lhIldc1PbsAIoJidSqK0sgp7qE3bBbKtXQ6EGxWenJK784gKMWPLZvbOSZRd6S/whUQQYxueaFOMLy7xVrNYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(8936002)(2616005)(82960400001)(38070700005)(2906002)(186003)(83380400001)(5660300002)(38100700002)(122000001)(30864003)(508600001)(8676002)(316002)(91956017)(6506007)(76116006)(6512007)(87266011)(4326008)(85182001)(71200400001)(66556008)(66446008)(64756008)(6916009)(6486002)(54906003)(66946007)(33656002)(66476007)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm1rM3FWbW5UdlhhMUhmRjB5SHdsN2NBK1dKZGszQVVFQndpalZuQWd3Zlk5?=
 =?utf-8?B?UlRtdGljdmxDZmV3aGV3UW8yNHo0bXRvV1JXR3BOQTF0T29DbHcwSHQyU2Vz?=
 =?utf-8?B?bUNOSDBsZTk0Y1FWeW5LUXc4NmlkbGR2OW82NVN5a3ZuWlhzemRCc3VKZjQ0?=
 =?utf-8?B?enFqbUhESXU1OU51NHNZY0lndmVBSFl6U3lyNmdtemxJdGJTTm1PNmkyOStH?=
 =?utf-8?B?MVNQMDhqWG9OWFluTVBQNExqZnNLRUE3TnBVZ3BITmJ2Vy9wdlB0UC9URG5i?=
 =?utf-8?B?MEFMWUlzVXFXeHFic01PVlZaM08yVksxNk1WNTFhUENKcG1aem14NmM1OHBt?=
 =?utf-8?B?Y0N6NnhJbjEvMEhuYmlMK3JLVTVCaXE0U2llRVk3UXA0RWpGK2hOMzZCVDhX?=
 =?utf-8?B?WXRZQ0ljdHNDaFBsVEpyRmhOaVNqY3g2bUJ5ck9NM1E5STBaVGZFanNVRkxk?=
 =?utf-8?B?NWdrUHUyZCtYY1NOUi96N3JYajJkKzNCaW5TRTZOS3YrcEwrRzQwTE9QRURW?=
 =?utf-8?B?d0h5RU5JZmZTZnZxQm1vc25zTXVDT1hZNUZnWm5SaG5oOXlzcFZqRkEyNEt3?=
 =?utf-8?B?R1VsM0Q5RUQxbkZBb1dYdlhscUFGYkR6TjdlYXI5Rm5vOTNMZ1dHVFYxYlRH?=
 =?utf-8?B?WG1LYlQzOGc1R25XWi8xR3pQTllwaVgvVklFTFF5dTBkVVYwblhQVGNBTngv?=
 =?utf-8?B?UkJwMlZYTzkzSFNNdS9iMGFNNFVmRExzTVNkYllUTExQZjlEV2ErNjJEN1pE?=
 =?utf-8?B?b0QrejV2VlV5RGpFZVRvL053cVFqNUIrWWFlNm9UYUJLR0NWUWFpaUZnbkdE?=
 =?utf-8?B?OVFlWS9oeFMxK2kwSEtwVmk4QjRncFFzVTcwL1JCQWo0a296ZERIejJQcjZP?=
 =?utf-8?B?UG1COVJKdm9JV2pIQmtGWXJuRkI5SzdURVVXSjZ5SU00VEVkOXdoeWRlQkpW?=
 =?utf-8?B?cU1Dd3JXMTF6RVlDZ2JYQkNpdmFGTVM2WFJNdnFiM01oeEZSaG1OVWtNZXhz?=
 =?utf-8?B?eFplOTRjOVpBbmpQSzFiQ0pjWkN0eGlBL20rRGh0cFhieEhrNGFHb3ZyRzdN?=
 =?utf-8?B?MHpkdi9XeXp5Q3B6bVRKSk85Y29DemUrTlpuM2EzOVpKUzZLdHlsNlgxeFZG?=
 =?utf-8?B?VkhmdU9DNmdsUWlJa0RSaGlPZDM4cDExSjZYVnJINGNUM1E0MHV2TGpIQXY4?=
 =?utf-8?B?R3NYSGNGaVRVbTc1TGlJV1gxdHVBYzg2VVpqZnBPMmxJSDdCOWFIazBaZHFT?=
 =?utf-8?B?T3dScG5TeXdiM0g1aEdTZGxtdW5uYlI1eC8wVGk3SXIrNVh1c2NyOS9ML1Y3?=
 =?utf-8?B?RjJsQk9IVjNraldDTmRkQ0dTcnJiaXVLN0IwRWNjbTI2d252Q2pRaGF1RHgy?=
 =?utf-8?B?WWVyUGJGV3ZwV2Y1ZTB5WXZXdzRQWGFPRUcyUnR6eUdQNW1WVXhiMVNqblBG?=
 =?utf-8?B?VytoSmkySklRdzlidmRaWm5kK3UzRVlRb3REenNBNDM0ZTlkNGxzdHFKNFR5?=
 =?utf-8?B?MjB0UUVwZ3ZPWUZrNlVXc3VyVWV0MGV2SS9abEM1bHBidjZ0d2k4YUN3emlN?=
 =?utf-8?B?YWd5cjBBZDJNbzRNWTk5RjJnYkRJMjlaNHZuUWdEeHRuWVRxby9mZWNBRlds?=
 =?utf-8?B?RFVvbUZ4UUhNcVdMQXBhT3lZSmpRZWYzZHdQUUkwQjZZbkZHNkt3T3E3ek1P?=
 =?utf-8?B?bktKZ3k1endaTFlCSDU5NmFlbDB0WFBHaGhJdXpoSXBwTnZQRDcyZDh2aEdw?=
 =?utf-8?B?aFVhVW9ESzVlQWVTa3ZlWEZrVTU0aGNGZEozTVNRaFppMzlmQllHWEN2UlZK?=
 =?utf-8?B?ZGFwVXZYR3lvQ2pmb3RKdjFSeUdlWFZLbHdlM0pvdmd6U0FxT3BlM0k5OFBO?=
 =?utf-8?B?Znl4bkViTVFzbUZGVUdiT1BNa0xkOVpFRWNYOTE1NGp2eC9hb0ttTHVXckEz?=
 =?utf-8?B?ci9pY1Q2R3Z0ekRudDhWK2NoZC9qaEFmVlBaMmFSajVFeko3bmhqWGRDUFFi?=
 =?utf-8?B?dUdkMmFLcXNONnQ2Ris4aGF3amhYNkFieW9pVTdvSlBOY2h6TG9lbHFoc0pH?=
 =?utf-8?B?TzlPVXVuUjJ6KzI1TndlQXBPQ29IeVdZNXJVY09wUVlqM1F0cmZYZndVcjR4?=
 =?utf-8?B?OFN5TG5HL29Ic0NtZDBiZ2JlN0k1Qyt1R1FvZkVNZUFvWUJUV1g0OWw5aDEr?=
 =?utf-8?B?Tkc3ak5VUjJ1eVpsYzVSWjFPRDd6cmJmS1pWeGtheVY2VDhkUS9jdmIwNUdY?=
 =?utf-8?B?dWNSK01DN0xYZDB5cFNBaUtKWWJ0VmFNUGJjNEIvY2hkYjdHdFNmbHhYYlg2?=
 =?utf-8?B?Y3FIYncyZ0ZQZXNlUkdIT3djQUhqOU8xajBmNHhPOFZ6Tk9RS1BOZHBvczBq?=
 =?utf-8?Q?Gq7DcgLUvedyznTWigkeGN8IZBuvTBvrwX+aM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3254B9B05F20C14593018552A53056C8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52454e9-3f0d-4648-7f7f-08da2448cd51
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 10:13:52.6949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddeQ5tQkJg3puh/GNawaY66uW8moZMjy7Zv9j6ex3Ovo+RPOPFpq+tB0qIoSGa8Ve2dc86mgFKOMCKa0IYFK1eWPqYLC6Wmb7jmMPq0+ydM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8088
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzIyIDE3OjQ3LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gRnJpLCBB
cHIgMjIsIDIwMjIgYXQgMDY6MDM6MDlBTSArMDAwMCwgeHV5YW5nMjAxOC5qeUBmdWppdHN1LmNv
bSB3cm90ZToNCj4+IG9uIDIwMjIvNC8yMSAxNjozNSwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6
DQo+Pj4gT24gVGh1LCBBcHIgMjEsIDIwMjIgYXQgMDM6NTQ6MTdQTSArMDgwMCwgWWFuZyBYdSB3
cm90ZToNCj4+Pj4gQ3VycmVudGx5LCB2ZnMgb25seSBwYXNzZXMgbW9kZSBhcmd1bWVudCB0byBm
aWxlc3lzdGVtLCB0aGVuIHVzZSBpbm9kZV9pbml0X293bmVyKCkNCj4+Pj4gdG8gc3RyaXAgU19J
U0dJRC4gU29tZSBmaWxlc3lzdGVtKGllIGV4dDQvYnRyZnMpIHdpbGwgY2FsbCBpbm9kZV9pbml0
X293bmVyDQo+Pj4+IGZpcnN0bHksIHRoZW4gcG9zeGkgYWNsIHNldHVwLCBidXQgeGZzIHVzZXMg
dGhlIGNvbnRyYXJ5IG9yZGVyLiBJdCB3aWxsDQo+Pj4+IGFmZmVjdCBTX0lTR0lEIGNsZWFyIGVz
cGVjaWFsbHkgd2UgZmlsdGVyIFNfSVhHUlAgYnkgdW1hc2sgb3IgYWNsLg0KPj4+Pg0KPj4+PiBS
ZWdhcmRsZXNzIG9mIHdoaWNoIGZpbGVzeXN0ZW0gaXMgaW4gdXNlLCBmYWlsdXJlIHRvIHN0cmlw
IHRoZSBTR0lEIGNvcnJlY3RseQ0KPj4+PiBpcyBjb25zaWRlcmVkIGEgc2VjdXJpdHkgZmFpbHVy
ZSB0aGF0IG5lZWRzIHRvIGJlIGZpeGVkLiBUaGUgY3VycmVudCBWRlMNCj4+Pj4gaW5mcmFzdHJ1
Y3R1cmUgcmVxdWlyZXMgdGhlIGZpbGVzeXN0ZW0gdG8gZG8gZXZlcnl0aGluZyByaWdodCBhbmQg
bm90IHN0ZXAgb24NCj4+Pj4gYW55IGxhbmRtaW5lcyB0byBzdHJpcCB0aGUgU0dJRCBiaXQsIHdo
ZW4gaW4gZmFjdCBpdCBjYW4gZWFzaWx5IGJlIGRvbmUgYXQgdGhlDQo+Pj4+IFZGUyBhbmQgdGhl
IGZpbGVzeXN0ZW1zIHRoZW4gZG9uJ3QgZXZlbiBuZWVkIHRvIGJlIGF3YXJlIHRoYXQgdGhlIFNH
SUQgbmVlZHMNCj4+Pj4gdG8gYmUgKG9yIGhhcyBiZWVuIHN0cmlwcGVkKSBieSB0aGUgb3BlcmF0
aW9uIHRoZSB1c2VyIGFza2VkIHRvIGJlIGRvbmUuDQo+Pj4+DQo+Pj4+IFZmcyBoYXMgYWxsIHRo
ZSBpbmZvIGl0IG5lZWRzIC0gaXQgZG9lc24ndCBuZWVkIHRoZSBmaWxlc3lzdGVtcyB0byBkbyBl
dmVyeXRoaW5nDQo+Pj4+IGNvcnJlY3RseSB3aXRoIHRoZSBtb2RlIGFuZCBlbnN1cmluZyB0aGF0
IHRoZXkgb3JkZXIgdGhpbmdzIGxpa2UgcG9zaXggYWNsIHNldHVwDQo+Pj4+IGZ1bmN0aW9ucyBj
b3JyZWN0bHkgd2l0aCBpbm9kZV9pbml0X293bmVyKCkgdG8gc3RyaXAgdGhlIFNHSUQgYml0Lg0K
Pj4+Pg0KPj4+PiBKdXN0IHN0cmlwIHRoZSBTR0lEIGJpdCBhdCB0aGUgVkZTLCBhbmQgdGhlbiB0
aGUgZmlsZXN5c3RlbSBjYW4ndCBnZXQgaXQgd3JvbmcuDQo+Pj4+DQo+Pj4+IEFsc28sIHRoZSBp
bm9kZV9zZ2lkX3N0cmlwKCkgYXBpIHNob3VsZCBiZSB1c2VkIGJlZm9yZSBJU19QT1NJWEFDTCgp
IGJlY2F1c2UNCj4+Pj4gdGhpcyBhcGkgbWF5IGNoYW5nZSBtb2RlLg0KPj4+Pg0KPj4+PiBPbmx5
IHRoZSBmb2xsb3dpbmcgcGxhY2VzIHVzZSBpbm9kZV9pbml0X293bmVyDQo+Pj4+ICINCj4+Pj4g
YXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9jZWxsL3NwdWZzL2lub2RlLmM6ICAgICAgaW5vZGVfaW5p
dF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlIHwgU19JRkRJUik7DQo+Pj4+
IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvY2VsbC9zcHVmcy9pbm9kZS5jOiAgICAgIGlub2RlX2lu
aXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9kZSB8IFNfSUZESVIpOw0KPj4+
PiBmcy85cC92ZnNfaW5vZGUuYzogICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMs
IGlub2RlLCBOVUxMLCBtb2RlKTsNCj4+Pj4gZnMvYmZzL2Rpci5jOiAgIGlub2RlX2luaXRfb3du
ZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+Pj4+IGZzL2J0cmZzL2lub2Rl
LmM6ICAgICAgIGlub2RlX2luaXRfb3duZXIobW50X3VzZXJucywgaW5vZGUsIGRpciwgbW9kZSk7
DQo+Pj4+IGZzL2J0cmZzL3Rlc3RzL2J0cmZzLXRlc3RzLmM6ICAgaW5vZGVfaW5pdF9vd25lcigm
aW5pdF91c2VyX25zLCBpbm9kZSwgTlVMTCwgU19JRlJFRyk7DQo+Pj4+IGZzL2V4dDIvaWFsbG9j
LmM6ICAgICAgICAgICAgICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwg
ZGlyLCBtb2RlKTsNCj4+Pj4gZnMvZXh0NC9pYWxsb2MuYzogICAgICAgICAgICAgICBpbm9kZV9p
bml0X293bmVyKG1udF91c2VybnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4+PiBmcy9mMmZzL25h
bWVpLmM6ICAgICAgICBpbm9kZV9pbml0X293bmVyKG1udF91c2VybnMsIGlub2RlLCBkaXIsIG1v
ZGUpOw0KPj4+PiBmcy9oZnNwbHVzL2lub2RlLmM6ICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0
X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4+PiBmcy9odWdldGxiZnMvaW5vZGUuYzog
ICAgICAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9k
ZSk7DQo+Pj4+IGZzL2pmcy9qZnNfaW5vZGUuYzogICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRf
dXNlcl9ucywgaW5vZGUsIHBhcmVudCwgbW9kZSk7DQo+Pj4+IGZzL21pbml4L2JpdG1hcC5jOiAg
ICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+
Pj4+IGZzL25pbGZzMi9pbm9kZS5jOiAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9u
cywgaW5vZGUsIGRpciwgbW9kZSk7DQo+Pj4+IGZzL250ZnMzL2lub2RlLmM6ICAgICAgIGlub2Rl
X2luaXRfb3duZXIobW50X3VzZXJucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+Pj4+IGZzL29jZnMy
L2RsbWZzL2RsbWZzLmM6ICAgICAgICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBp
bm9kZSwgTlVMTCwgbW9kZSk7DQo+Pj4+IGZzL29jZnMyL2RsbWZzL2RsbWZzLmM6IGlub2RlX2lu
aXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIHBhcmVudCwgbW9kZSk7DQo+Pj4+IGZzL29j
ZnMyL25hbWVpLmM6ICAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUs
IGRpciwgbW9kZSk7DQo+Pj4+IGZzL29tZnMvaW5vZGUuYzogICAgICAgIGlub2RlX2luaXRfb3du
ZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIE5VTEwsIG1vZGUpOw0KPj4+PiBmcy9vdmVybGF5ZnMv
ZGlyLmM6ICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkZW50cnkt
PmRfcGFyZW50LT5kX2lub2RlLCBtb2RlKTsNCj4+Pj4gZnMvcmFtZnMvaW5vZGUuYzogICAgICAg
ICAgICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUp
Ow0KPj4+PiBmcy9yZWlzZXJmcy9uYW1laS5jOiAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3Vz
ZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4+PiBmcy9zeXN2L2lhbGxvYy5jOiAgICAgICBp
bm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4+PiBm
cy91Ymlmcy9kaXIuYzogaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGly
LCBtb2RlKTsNCj4+Pj4gZnMvdWRmL2lhbGxvYy5jOiAgICAgICAgaW5vZGVfaW5pdF9vd25lcigm
aW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+Pj4gZnMvdWZzL2lhbGxvYy5jOiAg
ICAgICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsN
Cj4+Pj4gZnMveGZzL3hmc19pbm9kZS5jOiAgICAgICAgICAgICBpbm9kZV9pbml0X293bmVyKG1u
dF91c2VybnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4+PiBmcy96b25lZnMvc3VwZXIuYzogICAg
ICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBwYXJlbnQsIFNfSUZESVIg
fCAwNTU1KTsNCj4+Pj4ga2VybmVsL2JwZi9pbm9kZS5jOiAgICAgaW5vZGVfaW5pdF9vd25lcigm
aW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+Pj4gbW0vc2htZW0uYzogICAgICAg
ICAgICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsN
Cj4+Pj4gIg0KPj4+Pg0KPj4+PiBUaGV5IGFyZSB1c2VkIGluIGZpbGVzeXN0ZW0gdG8gaW5pdCBu
ZXcgaW5vZGUgZnVuY3Rpb24gYW5kIHRoZXNlIGluaXQgaW5vZGUNCj4+Pj4gZnVuY3Rpb25zIGFy
ZSB1c2VkIGJ5IGZvbGxvd2luZyBvcGVyYXRpb25zOg0KPj4+PiBta2Rpcg0KPj4+PiBzeW1saW5r
DQo+Pj4+IG1rbm9kDQo+Pj4+IGNyZWF0ZQ0KPj4+PiB0bXBmaWxlDQo+Pj4+IHJlbmFtZQ0KPj4+
Pg0KPj4+PiBXZSBkb24ndCBjYXJlIGFib3V0IG1rZGlyIGJlY2F1c2Ugd2UgZG9uJ3Qgc3RyaXAg
U0dJRCBiaXQgZm9yIGRpcmVjdG9yeSBleGNlcHQNCj4+Pj4gZnMueGZzLmlyaXhfc2dpZF9pbmhl
cml0LiBCdXQgd2UgZXZlbiBjYWxsIHByZXBhcmVfbW9kZSgpIGluIGRvX21rZGlyYXQoKSBzaW5j
ZQ0KPj4+PiBpbm9kZV9zZ2lkX3N0cmlwKCkgd2lsbCBza2lwIGRpcmVjdG9yaWVzIGFueXdheS4g
VGhpcyB3aWxsIGVuZm9yY2UgdGhlIHNhbWUNCj4+Pj4gb3JkZXJpbmcgZm9yIGFsbCByZWxldmFu
dCBvcGVyYXRpb25zIGFuZCBpdCB3aWxsIG1ha2UgdGhlIGNvZGUgbW9yZSB1bmlmb3JtIGFuZA0K
Pj4+PiBlYXNpZXIgdG8gdW5kZXJzdGFuZCBieSB1c2luZyBuZXcgaGVscGVyIHByZXBhcmVfbW9k
ZSgpLg0KPj4+Pg0KPj4+PiBzeW1saW5rIGFuZCByZW5hbWUgb25seSB1c2UgdmFsaWQgbW9kZSB0
aGF0IGRvZXNuJ3QgaGF2ZSBTR0lEIGJpdC4NCj4+Pj4NCj4+Pj4gV2UgaGF2ZSBhZGRlZCBpbm9k
ZV9zZ2lkX3N0cmlwIGFwaSBmb3IgdGhlIHJlbWFpbmluZyBvcGVyYXRpb25zLg0KPj4+Pg0KPj4+
PiBJbiBhZGRpdGlvbiB0byB0aGUgYWJvdmUgc2l4IG9wZXJhdGlvbnMsIGZvdXIgZmlsZXN5c3Rl
bXMgaGFzIGEgbGl0dGxlIGRpZmZlcmVuY2UNCj4+Pj4gMSkgYnRyZnMgaGFzIGJ0cmZzX2NyZWF0
ZV9zdWJ2b2xfcm9vdCB0byBjcmVhdGUgbmV3IGlub2RlIGJ1dCB1c2VkIG5vbiBTR0lEIGJpdA0K
Pj4+PiAgICAgIG1vZGUgYW5kIGNhbiBpZ25vcmUNCj4+Pj4gMikgb2NmczIgcmVmbGluayBmdW5j
dGlvbiBzaG91bGQgYWRkIGlub2RlX3NnaWRfc3RyaXAgYXBpIG1hbnVhbGx5IGJlY2F1c2Ugd2UN
Cj4+Pj4gICAgICBkb24ndCBhZGQgaXQgaW4gdmZzDQo+Pj4+IDMpIHNwdWZzIHdoaWNoIGRvZXNu
J3QgcmVhbGx5IGdvIGhyb3VnaCB0aGUgcmVndWxhciBWRlMgY2FsbHBhdGggYmVjYXVzZSBpdCBo
YXMNCj4+Pj4gICAgICBzZXBhcmF0ZSBzeXN0ZW0gY2FsbCBzcHVfY3JlYXRlLCBidXQgaXQgdCBv
bmx5IGFsbG93cyB0aGUgY3JlYXRpb24gb2YNCj4+Pj4gICAgICBkaXJlY3RvcmllcyBhbmQgb25s
eSBhbGxvd3MgYml0cyBpbiAwNzc3IGFuZCBjYW4gaWdub3JlDQo+Pj4+IDQpIGJwZiB1c2UgdmZz
X21rb2JqIGluIGJwZl9vYmpfZG9fcGluIHdpdGgNCj4+Pj4gICAgICAiU19JRlJFRyB8ICgoU19J
UlVTUiB8IFNfSVdVU1IpJiAgIH5jdXJyZW50X3VtYXNrKCkpIG1vZGUgYW5kDQo+Pj4+ICAgICAg
dXNlIGJwZl9ta29ial9vcHMgaW4gYnBmX2l0ZXJfbGlua19waW5fa2VybmVsIHdpdGggU19JRlJF
RyB8IFNfSVJVU1IgbW9kZSwNCj4+Pj4gICAgICBzbyBicGYgaXMgYWxzbyBub3QgYWZmZWN0ZWQN
Cj4+Pj4NCj4+Pj4gVGhpcyBwYXRjaCBhbHNvIGNoYW5nZWQgZ3JwaWQgYmVoYXZpb3VyIGZvciBl
eHQ0L3hmcyBiZWNhdXNlIHRoZSBtb2RlIHBhc3NlZCB0bw0KPj4+PiB0aGVtIG1heSBiZWVuIGNo
YW5nZWQgYnkgaW5vZGVfc2dpZF9zdHJpcC4NCj4+Pj4NCj4+Pj4gQWxzbyBhcyBDaHJpc3RpYW4g
QnJhdW5lciBzYWlkIg0KPj4+PiBUaGUgcGF0Y2ggaXRzZWxmIGlzIHVzZWZ1bCBhcyBpdCB3b3Vs
ZCBtb3ZlIGEgc2VjdXJpdHkgc2Vuc2l0aXZlIG9wZXJhdGlvbiB0aGF0IGlzDQo+Pj4+IGN1cnJl
bnRseSBidXJyaWVkIGluIGluZGl2aWR1YWwgZmlsZXN5c3RlbXMgaW50byB0aGUgdmZzIGxheWVy
LiBCdXQgaXQgaGFzIGEgZGVjZW50DQo+Pj4+IHJlZ3Jlc3Npb24gIHBvdGVudGlhbCBzaW5jZSBp
dCBtaWdodCBzdHJpcCBmaWxlc3lzdGVtcyB0aGF0IGhhdmUgc28gZmFyIHJlbGllZCBvbg0KPj4+
PiBnZXR0aW5nIHRoZSBTX0lTR0lEIGJpdCB3aXRoIGEgbW9kZSBhcmd1bWVudC4gU28gdGhpcyBu
ZWVkcyBhIGxvdCBvZiB0ZXN0aW5nIGFuZA0KPj4+PiBsb25nIGV4cG9zdXJlIGluIC1uZXh0IGZv
ciBhdCBsZWFzdCBvbmUgZnVsbCBrZXJuZWwgY3ljbGUuIg0KPj4+Pg0KPj4+PiBTdWdnZXN0ZWQt
Ynk6IERhdmUgQ2hpbm5lcjxkYXZpZEBmcm9tb3JiaXQuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBZYW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiB2NC0+
djU6DQo+Pj4+IHB1dCBpbm9kZV9zZ2lkX3N0cmlwIGJlZm9yZSB0aGUgaW5vZGVfaW5pdF9vd25l
ciBpbiBvY2ZzMiBmaWxlc3lzdGVtDQo+Pj4+IGJlY2F1c2UgdGhlIGlub2RlLT5pX21vZGUncyBh
c3NpZ25tZW50IGlzIGluIGlub2RlX2luaXRfb3duZXINCj4+Pj4gICAgZnMvaW5vZGUuYyAgICAg
ICAgIHwgIDIgLS0NCj4+Pj4gICAgZnMvbmFtZWkuYyAgICAgICAgIHwgMjIgKysrKysrKysrLS0t
LS0tLS0tLS0tLQ0KPj4+PiAgICBmcy9vY2ZzMi9uYW1laS5jICAgfCAgMSArDQo+Pj4+ICAgIGlu
Y2x1ZGUvbGludXgvZnMuaCB8IDExICsrKysrKysrKysrDQo+Pj4+ICAgIDQgZmlsZXMgY2hhbmdl
ZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1n
aXQgYS9mcy9pbm9kZS5jIGIvZnMvaW5vZGUuYw0KPj4+PiBpbmRleCA1NzEzMGU0ZWY4YjQuLjk1
NjY3ZTYzNGJkNCAxMDA2NDQNCj4+Pj4gLS0tIGEvZnMvaW5vZGUuYw0KPj4+PiArKysgYi9mcy9p
bm9kZS5jDQo+Pj4+IEBAIC0yMjQ2LDggKzIyNDYsNiBAQCB2b2lkIGlub2RlX2luaXRfb3duZXIo
c3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLA0K
Pj4+PiAgICAJCS8qIERpcmVjdG9yaWVzIGFyZSBzcGVjaWFsLCBhbmQgYWx3YXlzIGluaGVyaXQg
U19JU0dJRCAqLw0KPj4+PiAgICAJCWlmIChTX0lTRElSKG1vZGUpKQ0KPj4+PiAgICAJCQltb2Rl
IHw9IFNfSVNHSUQ7DQo+Pj4+IC0JCWVsc2UNCj4+Pj4gLQkJCW1vZGUgPSBpbm9kZV9zZ2lkX3N0
cmlwKG1udF91c2VybnMsIGRpciwgbW9kZSk7DQo+Pj4+ICAgIAl9IGVsc2UNCj4+Pj4gICAgCQlp
bm9kZV9mc2dpZF9zZXQoaW5vZGUsIG1udF91c2VybnMpOw0KPj4+PiAgICAJaW5vZGUtPmlfbW9k
ZSA9IG1vZGU7DQo+Pj4+IGRpZmYgLS1naXQgYS9mcy9uYW1laS5jIGIvZnMvbmFtZWkuYw0KPj4+
PiBpbmRleCA3MzY0NmUyOGZhZTAuLjViOGU2Mjg4ZDUwMyAxMDA2NDQNCj4+Pj4gLS0tIGEvZnMv
bmFtZWkuYw0KPj4+PiArKysgYi9mcy9uYW1laS5jDQo+Pj4+IEBAIC0zMjg3LDggKzMyODcsNyBA
QCBzdGF0aWMgc3RydWN0IGRlbnRyeSAqbG9va3VwX29wZW4oc3RydWN0IG5hbWVpZGF0YSAqbmQs
IHN0cnVjdCBmaWxlICpmaWxlLA0KPj4+PiAgICAJaWYgKG9wZW5fZmxhZyYgICBPX0NSRUFUKSB7
DQo+Pj4+ICAgIAkJaWYgKG9wZW5fZmxhZyYgICBPX0VYQ0wpDQo+Pj4+ICAgIAkJCW9wZW5fZmxh
ZyY9IH5PX1RSVU5DOw0KPj4+PiAtCQlpZiAoIUlTX1BPU0lYQUNMKGRpci0+ZF9pbm9kZSkpDQo+
Pj4+IC0JCQltb2RlJj0gfmN1cnJlbnRfdW1hc2soKTsNCj4+Pj4gKwkJbW9kZSA9IHByZXBhcmVf
bW9kZShtbnRfdXNlcm5zLCBkaXItPmRfaW5vZGUsIG1vZGUpOw0KPj4+PiAgICAJCWlmIChsaWtl
bHkoZ290X3dyaXRlKSkNCj4+Pj4gICAgCQkJY3JlYXRlX2Vycm9yID0gbWF5X29fY3JlYXRlKG1u
dF91c2VybnMsJm5kLT5wYXRoLA0KPj4+PiAgICAJCQkJCQkgICAgZGVudHJ5LCBtb2RlKTsNCj4+
Pj4gQEAgLTM1MjEsOCArMzUyMCw3IEBAIHN0cnVjdCBkZW50cnkgKnZmc190bXBmaWxlKHN0cnVj
dCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywNCj4+Pj4gICAgCWNoaWxkID0gZF9hbGxvYyhk
ZW50cnksJnNsYXNoX25hbWUpOw0KPj4+PiAgICAJaWYgKHVubGlrZWx5KCFjaGlsZCkpDQo+Pj4+
ICAgIAkJZ290byBvdXRfZXJyOw0KPj4+PiAtCWlmICghSVNfUE9TSVhBQ0woZGlyKSkNCj4+Pj4g
LQkJbW9kZSY9IH5jdXJyZW50X3VtYXNrKCk7DQo+Pj4+ICsJbW9kZSA9IHByZXBhcmVfbW9kZSht
bnRfdXNlcm5zLCBkaXIsIG1vZGUpOw0KPj4+PiAgICAJZXJyb3IgPSBkaXItPmlfb3AtPnRtcGZp
bGUobW50X3VzZXJucywgZGlyLCBjaGlsZCwgbW9kZSk7DQo+Pj4+ICAgIAlpZiAoZXJyb3IpDQo+
Pj4+ICAgIAkJZ290byBvdXRfZXJyOw0KPj4+PiBAQCAtMzg1MCwxMyArMzg0OCwxMiBAQCBzdGF0
aWMgaW50IGRvX21rbm9kYXQoaW50IGRmZCwgc3RydWN0IGZpbGVuYW1lICpuYW1lLCB1bW9kZV90
IG1vZGUsDQo+Pj4+ICAgIAlpZiAoSVNfRVJSKGRlbnRyeSkpDQo+Pj4+ICAgIAkJZ290byBvdXQx
Ow0KPj4+Pg0KPj4+PiAtCWlmICghSVNfUE9TSVhBQ0wocGF0aC5kZW50cnktPmRfaW5vZGUpKQ0K
Pj4+PiAtCQltb2RlJj0gfmN1cnJlbnRfdW1hc2soKTsNCj4+Pj4gKwltbnRfdXNlcm5zID0gbW50
X3VzZXJfbnMocGF0aC5tbnQpOw0KPj4+PiArCW1vZGUgPSBwcmVwYXJlX21vZGUobW50X3VzZXJu
cywgcGF0aC5kZW50cnktPmRfaW5vZGUsIG1vZGUpOw0KPj4+PiAgICAJZXJyb3IgPSBzZWN1cml0
eV9wYXRoX21rbm9kKCZwYXRoLCBkZW50cnksIG1vZGUsIGRldik7DQo+Pj4+ICAgIAlpZiAoZXJy
b3IpDQo+Pj4+ICAgIAkJZ290byBvdXQyOw0KPj4+Pg0KPj4+PiAtCW1udF91c2VybnMgPSBtbnRf
dXNlcl9ucyhwYXRoLm1udCk7DQo+Pj4+ICAgIAlzd2l0Y2ggKG1vZGUmICAgU19JRk1UKSB7DQo+
Pj4+ICAgIAkJY2FzZSAwOiBjYXNlIFNfSUZSRUc6DQo+Pj4+ICAgIAkJCWVycm9yID0gdmZzX2Ny
ZWF0ZShtbnRfdXNlcm5zLCBwYXRoLmRlbnRyeS0+ZF9pbm9kZSwNCj4+Pj4gQEAgLTM5NDMsNiAr
Mzk0MCw3IEBAIGludCBkb19ta2RpcmF0KGludCBkZmQsIHN0cnVjdCBmaWxlbmFtZSAqbmFtZSwg
dW1vZGVfdCBtb2RlKQ0KPj4+PiAgICAJc3RydWN0IHBhdGggcGF0aDsNCj4+Pj4gICAgCWludCBl
cnJvcjsNCj4+Pj4gICAgCXVuc2lnbmVkIGludCBsb29rdXBfZmxhZ3MgPSBMT09LVVBfRElSRUNU
T1JZOw0KPj4+PiArCXN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJuczsNCj4+Pj4NCj4+
Pj4gICAgcmV0cnk6DQo+Pj4+ICAgIAlkZW50cnkgPSBmaWxlbmFtZV9jcmVhdGUoZGZkLCBuYW1l
LCZwYXRoLCBsb29rdXBfZmxhZ3MpOw0KPj4+PiBAQCAtMzk1MCwxNSArMzk0OCwxMyBAQCBpbnQg
ZG9fbWtkaXJhdChpbnQgZGZkLCBzdHJ1Y3QgZmlsZW5hbWUgKm5hbWUsIHVtb2RlX3QgbW9kZSkN
Cj4+Pj4gICAgCWlmIChJU19FUlIoZGVudHJ5KSkNCj4+Pj4gICAgCQlnb3RvIG91dF9wdXRuYW1l
Ow0KPj4+Pg0KPj4+PiAtCWlmICghSVNfUE9TSVhBQ0wocGF0aC5kZW50cnktPmRfaW5vZGUpKQ0K
Pj4+PiAtCQltb2RlJj0gfmN1cnJlbnRfdW1hc2soKTsNCj4+Pj4gKwltbnRfdXNlcm5zID0gbW50
X3VzZXJfbnMocGF0aC5tbnQpOw0KPj4+PiArCW1vZGUgPSBwcmVwYXJlX21vZGUobW50X3VzZXJu
cywgcGF0aC5kZW50cnktPmRfaW5vZGUsIG1vZGUpOw0KPj4+PiAgICAJZXJyb3IgPSBzZWN1cml0
eV9wYXRoX21rZGlyKCZwYXRoLCBkZW50cnksIG1vZGUpOw0KPj4+PiAtCWlmICghZXJyb3IpIHsN
Cj4+Pj4gLQkJc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zOw0KPj4+PiAtCQltbnRf
dXNlcm5zID0gbW50X3VzZXJfbnMocGF0aC5tbnQpOw0KPj4+PiArCWlmICghZXJyb3IpDQo+Pj4+
ICAgIAkJZXJyb3IgPSB2ZnNfbWtkaXIobW50X3VzZXJucywgcGF0aC5kZW50cnktPmRfaW5vZGUs
IGRlbnRyeSwNCj4+Pj4gICAgCQkJCSAgbW9kZSk7DQo+Pj4+IC0JfQ0KPj4+PiArDQo+Pj4+ICAg
IAlkb25lX3BhdGhfY3JlYXRlKCZwYXRoLCBkZW50cnkpOw0KPj4+PiAgICAJaWYgKHJldHJ5X2Vz
dGFsZShlcnJvciwgbG9va3VwX2ZsYWdzKSkgew0KPj4+PiAgICAJCWxvb2t1cF9mbGFncyB8PSBM
T09LVVBfUkVWQUw7DQo+Pj4+IGRpZmYgLS1naXQgYS9mcy9vY2ZzMi9uYW1laS5jIGIvZnMvb2Nm
czIvbmFtZWkuYw0KPj4+PiBpbmRleCBjNzVmZDU0YjkxODUuLjIxZjNkYTJlNjZjOSAxMDA2NDQN
Cj4+Pj4gLS0tIGEvZnMvb2NmczIvbmFtZWkuYw0KPj4+PiArKysgYi9mcy9vY2ZzMi9uYW1laS5j
DQo+Pj4+IEBAIC0xOTcsNiArMTk3LDcgQEAgc3RhdGljIHN0cnVjdCBpbm9kZSAqb2NmczJfZ2V0
X2luaXRfaW5vZGUoc3RydWN0IGlub2RlICpkaXIsIHVtb2RlX3QgbW9kZSkNCj4+Pj4gICAgCSAq
IGNhbGxlcnMuICovDQo+Pj4+ICAgIAlpZiAoU19JU0RJUihtb2RlKSkNCj4+Pj4gICAgCQlzZXRf
bmxpbmsoaW5vZGUsIDIpOw0KPj4+PiArCW1vZGUgPSBpbm9kZV9zZ2lkX3N0cmlwKCZpbml0X3Vz
ZXJfbnMsIGRpciwgbW9kZSk7DQo+Pj4+ICAgIAlpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJf
bnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4+DQo+Pj4gRm9yIHRoZSByZWNvcmQsIEknbSBub3Qg
dG9vIGZvbmQgb2YgdGhpcyBzZXBhcmF0ZSBpbnZvY2F0aW9uIG9mDQo+Pj4gaW5vZGVfc2dpZF9z
dHJpcCgpIGJ1dCBzaW5jZSBpdCdzIG9ubHkgb25lIGxvY2F0aW9uIHRoaXMgbWlnaHQgYmUgZmlu
ZS4NCj4+PiBJZiB0aGVyZSdzIG1vcmUgdGhhbiBvbmUgbG9jYXRpb24gYSBzZXBhcmF0ZSBoZWxw
ZXIgc2hvdWxkIGV4aXN0IGZvcg0KPj4+IHRoaXMgdGhhdCBhYnN0cmFjdHMgdGhpcyBhd2F5IGZv
ciB0aGUgZmlsZXN5c3RlbS4NCj4+IEFncmVlLiBUaGlzIGNhc2Ugb25seSBiZSBmb3VuZCB3aGVu
IHVzaW5nIE9DRlMyX0lPQ19SRUZMSU5LIGlvY3RsLiBBbmQNCj4NCj4gKEkgaGF2ZSBvbmUgdmVy
eSBtaW5vciBub24tdGVjaG5pY2FsIGFzazogY2FuIHlvdSBwbGVhc2UgbWFrZSBzdXJlIHRvDQo+
IGxlYXZlIGFuIGVtcHR5IGxpbmUgYmV0d2VlbiB0aGUgdGV4dCB5b3UncmUgY2l0aW5nIGFuZCB5
b3VyIHJlcGx5PyBJdA0KPiB3b3VsZCBtYWtlIHJlYWRpbmcgeW91ciByZXBsaWVzIGEgbG90IGVh
c2llci4gOikpDQoNCk9mIGNvdXJzZS4NCg0KPg0KPj4gb3RoZXIgc3VwcG9ydCByZWZsaW5rIGZp
bGVzeXN0ZW0oeGZzLCBidHJmcykgdGhleSB1c2UgIEZJQ0xPTkUgb3INCj4+IEZJQ0xPTkVSQU5H
RSBpb2N0bC4NCj4+DQo+PiBTaW5jZSBvY2ZzMiBoYXMgc3VwcG9ydGVkIHJlZmxpbmsgYnkgdXNp
bmcgaXQgcmVtYXBfZmlsZV9yYW5nZSwgc2hvdWxkDQo+PiB3ZSBzdGlsbCBuZWVkIHRoaXMgaW9j
dGw/DQo+Pg0KPj4gY29tbWl0IGJkNTA4NzNkYzcyNWE5ZmE3MjU5MmVjYzk4NmM1ODgwNWU4MjMw
NTENCj4+IEF1dGhvcjogVGFvIE1hPHRhby5tYUBvcmFjbGUuY29tPg0KPj4gRGF0ZTogICBNb24g
U2VwIDIxIDExOjI1OjE0IDIwMDkgKzA4MDANCj4+DQo+PiAgICAgICBvY2ZzMjogQWRkIGlvY3Rs
IGZvciByZWZsaW5rLg0KPj4NCj4+ICAgICAgIFRoZSBpb2N0bCB3aWxsIHRha2UgMyBwYXJhbWV0
ZXJzOiBvbGRfcGF0aCwgbmV3X3BhdGggYW5kDQo+PiAgICAgICBwcmVzZXJ2ZSBhbmQgY2FsbCB2
ZnNfcmVmbGluay4gSXQgaXMgdXNlZnVsIHdoZW4gd2UgYmFja3BvcnQNCj4+ICAgICAgIHJlZmxp
bmsgZmVhdHVyZXMgdG8gb2xkIGtlcm5lbHMuDQo+Pg0KPj4gICAgICAgU2lnbmVkLW9mZi1ieTog
VGFvIE1hPHRhby5tYUBvcmFjbGUuY29tPg0KPj4NCj4+IE9mIGNvdXJzZSwgdGhpcyBpcyBhIHBy
b2JsZW0gZG9lc24ndCBiZWxvbmcgdG8gdGhpcyBzZXJpZXMuDQo+Pg0KPj4+DQo+Pj4gVHdvIHF1
ZXN0aW9uczoNCj4+PiAtIFNvdWxkIHRoaXMgY2FsbCBwcmVwYXJlX21vZGUoKSwgaS5lLiBzaG91
bGQgd2UgaG9ub3IgdW1hc2tzIGhlcmUgdG9vPw0KPj4gSU1PLCBpdCBkZXNuJ3QgbmVlZCB0byBo
b25vciB1bWFzay4gQmVjYXVzZSByZWZsaW5rIG9ubHkgd2lsbCB1cGRhdGUNCj4+IGlub2RlX2lt
b2RlIGJ5IHNldGF0dHIgdG8gc3RyaXAgU19JU0dJRCBhbmQgU19JU1VJRCBpbnN0ZWFkIG9mIGNy
ZWF0aW5nDQo+PiBhIGZpbGUuDQo+DQo+IEkgaGFkIGEgbWlzY29uY2VwdGlvbiBoZXJlIGJlY2F1
c2UgSSBnb3QgY29uZnVzZWQgYnkgb2NmczIuDQo+IFdoaWxlIHRoZSBPQ0ZTMl9JT0NfUkVGTElO
SyBpb2N0bCBjcmVhdGVzIHRoZSB0YXJnZXQgZmlsZSBpdHNlbGYgYW5kIHRoZQ0KPiByZWZsaW5r
IHRoZSBGSUNMT05FIGFuZCBGSUNMT05FUkFOR0UgX29ubHlfIGNyZWF0ZSB0aGUgcmVmbGluay4N
Cj4NCj4gU28gdGhlIHRhcmdldCBmaWxlIGl0c2VsZiBtdXN0J3ZlIGJlZW4gY3JlYXRlZCBwcmlv
ciB0bw0KPiBGSUNMT05FL0ZJQ0xPTkVSQU5HRSB3aGljaCBtZWFucyBiYXNpYyBzZXRnaWQgc3Ry
aXBwaW5nIHNob3VsZCd2ZSBiZWVuDQo+IGRvbmUgd2hlbiB0aGUgZmlsZSB3YXMgY3JlYXRlZC4N
Cg0KWWVzLg0KDQo+DQo+IFNpbmNlIG9jZnMyIHJlZmxpbmsgY2FsbHBhdGhzIHdvcmsgdmVyeSBk
aWZmZXJlbnRseSB3ZSBjYW4ndCBzd2l0Y2ggaXQNCj4gdG8gRklDTE9ORS9GSUNMT05FUkFOR0Ug
YXMgdGhpcyB3b3VsZCByZWdyZXNzIG9jZnMyIHVzZXJzLg0KPg0KPj4+IC0gSG93IGlzIHRoZSBz
Z2lkIGJpdCBoYW5kbGVkIHdoZW4gY3JlYXRpbmcgcmVmbGlua3Mgb24gb3RoZXIgcmVmbGluaw0K
Pj4+ICAgICBzdXBwb3J0aW5nIGZpbGVzeXN0ZW1zIHN1Y2ggYXMgeGZzIGFuZCBidHJmcz8NCj4+
IHhmc3Rlc3RzIGhhcyBhIHRlc3QgY2FzZSBnZW5lcmljLzY3MyBmb3IgdGhpcywgc28gYnRyZnMg
YW5kIHhmcyBzaG91bGQNCj4+IGhhdmUgdGhlIHNhbWUgYmVoYXZpb3IuDQo+PiBJIGxvb2sgaW50
byB4ZnMgY29kZS4NCj4+DQo+PiBGaXJzdGx5DQo+Pg0KPj4gSWYgd2UgZG9uJ3QgaGF2ZSBDQVBf
RlNFVElEIGFuZCBpdCBpcyBhIHJlZ3VscmUgZmlsZSxhbHNvIGhhdmUgc2dpZCBiaXQsDQo+PiB0
aGVuIHNob3VsZF9yZW1vdmVfc3VpZCB3aWxsIGdpdmUgYXR0ciBhIEFUVFJfS0lMTF9TR0lEIG1h
c2suDQo+DQo+IFdoYXQgeW91J3JlIHJlZmVycmluZyB0byBiZWxvdyBpcyBwcml2aWxlZ2Ugc3Ry
aXBwaW5nIHdoZW4gX21vZGlmeWluZw0KPiB0aGUgY29udGVudF8gb2Ygc2V0e2csdX1pZCBiaW5h
cmllcy4NCj4NCj4gVGhhdCBoYXBwZW5zIGUuZy4gZHVyaW5nIHdyaXRlKCkgb3IgaW5kZWVkIGEg
cmVmbGluayBjcmVhdGlvbiB2aWENCj4gRklDTE9ORS9GSUNMT05FUkFOR0UuIEZvciB0aGUgbGF0
dGVyIHByaXZpbGVnZSBzdHJpcHBpbmcgaGFwcGVucyB3aGVuDQo+IG9ubHkgc29tZSBleHRlbnRz
IGFyZSByZWZsaW5rZWQgYW5kIG5vdCB0aGUgd2hvbGUgZmlsZS4gU28gdGhhdCdzOg0KPg0KPiAq
IGlvY3RsX2ZpbGVfY2xvbmUoKQ0KPiAgICAqIHZmc19jbG9uZV9maWxlX3JhbmdlKCkNCj4gICAg
ICAqIGRvX2Nsb25lX2ZpbGVfcmFuZ2UoKQ0KPiAgICAgICAgKiBnZW5lcmljX2ZpbGVfcndfY2hl
Y2tzKCkNCj4gICAgICAgICogcmVtYXBfdmVyaWZ5X2FyZWEoKQ0KPiAgICAgICAgICAqIHNlY3Vy
aXR5X2ZpbGVfcGVybWlzc2lvbigpDQo+ICAgICAgICAqIC0+cmVtYXBfZmlsZV9yYW5nZSgpIFsx
XQ0KPg0KPiBbMV06DQo+IGJ0cmZzOg0KPiAqIGJ0cmZzX3JlbWFwX2ZpbGVfcmFuZ2UoKQ0KPiAg
ICAqIGdlbmVyaWNfcmVtYXBfZmlsZV9yYW5nZV9wcmVwKCkNCj4gICAgICAqIGZpbGVfbW9kaWZp
ZWQoKSAvLyBwcml2aWxlZ2Ugc3RyaXBwaW5nDQo+DQo+IG9jZnMyOg0KPiAqIG9jZnMyX3JlbWFw
X2ZpbGVfcmFuZ2UoKQ0KPiAgICAqIGdlbmVyaWNfcmVtYXBfZmlsZV9yYW5nZV9wcmVwKCkNCj4g
ICAgICAqIGZpbGVfbW9kaWZpZWQoKSAvLyBwcml2aWxlZ2Ugc3RyaXBwaW5nDQo+DQo+IHhmczoN
Cj4gKiB4ZnNfcmVtYXBfZmlsZV9yYW5nZSgpDQo+ICAgICogZ2VuZXJpY19yZW1hcF9maWxlX3Jh
bmdlX3ByZXAoKQ0KPiAgICAgICogZmlsZV9tb2RpZmllZCgpIC8vIHByaXZpbGVnZSBzdHJpcHBp
bmcNCj4NCj4gLy8gVGhpcyBpcyBzdGFja2VkLCBpLmUuIG92bCBmaWxlc3lzdGVtcyB3aWxsIHJl
bHkgb24gdGhlIGZpbGVzeXN0ZW0NCj4gLy8gdXNlZCBmb3IgdGhlIHVwcGVyIG1vdW50IGFuZCBp
dCdzIC5yZW1hcF9maWxlX3JhbmdlKCkgaW1wbGVtZW50YXRpb24uDQo+IG92ZXJsYXlmczoNCj4g
KiBvdmxfcmVtYXBfZmlsZV9yYW5nZSgpDQo+ICAgICogdmZzX2Nsb25lX2ZpbGVfcmFuZ2UoKQ0K
Pg0KPiBUaGUgb3RoZXIgdHdvIGltcGxlbWVudGVycyBhcmU6DQo+DQo+IGNpZnM6DQo+ICogY2lm
c19yZW1hcF9maWxlX3JhbmdlKCkNCj4NCj4gbmZzOg0KPiAqIG5mczQyX3JlbWFwX2ZpbGVfcmFu
Z2UoKQ0KPg0KPiBib3RoIG9mIHdoaWNoIGRvbid0IGNhbGwgaW50byBnZW5lcmljX3JlbWFwX2Zp
bGVfcmFuZ2VfcHJlcCgpIGFuZCBzbw0KPiBmaWxlX21vZGlmaWVkKCkgaXNuJ3QgY2FsbGVkLiBC
dXQgdGhleSBhcmUgbmV0ZnNlcyBhbmQgdGhlcmUncyBhIHNlcnZlcg0KPiBpbnZvbHZlZC4gSW4g
Z2VuZXJhbCwgdGhpcyBpc24ndCByZWFsbHkgYSBjb25jZXJuIGZvciB0aGlzIHBhdGNoc2V0Lg0K
PiAoQnV0IHNvbWV0aGluZyB0byBwb3RlbnRpYWxseSB0byBsb29rIGludG8gaW4gdGhlIGZ1dHVy
ZS4pDQo+DQo+IEFuZCBpdCB3YXNuJ3Qgd2hhdCBJIHdhcyB3b3JyaWVkIGFib3V0Lg0KPg0KPiBU
aGUgY3J1Y2lhbCBpbmZvcm1hdGlvbiB0aGF0IHdlIG5lZWRlZCB3YXMgd2hldGhlciByZWZsaW5r
IGNhbGxwYXRocw0KPiBvdGhlciB0aGFuIG9jZnMyIGNyZWF0ZSBmaWxlcyB0aGVtc2VsdmVzIGFu
ZCB0aGVyZWZvcmUgbWlnaHQgcmVseQ0KPiBpbXBsaWNpdGx5IG9uIHNldGdpZCBzdHJpcHBpbmcg
aW4gaW5vZGVfaW5pdF9vd25lcigpLg0KPg0KPiBOb3cgdGhhdCB3ZSBsb29rZWQgYXQgYWxsIGNh
bGxlcnMgd2UgY2FuIGJlIGNvbmZpZGVudCB0aGF0IHRoaXMgaXNuJ3QNCj4gdGhlIGNhc2UuIF9B
cGFydCBmcm9tIG9jZnMyXyBidXQgd2hpY2ggeW91IGhhbmRsZSBpbiB0aGUgcGF0Y2hzZXQuDQoN
CklmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoaXMgc3RyaXBwaW5nIGNvZGUgaXMgb2suIFNv
IGNhbiBJIHNlbmQgYSB2NiANCnBhdGNoPw0K
