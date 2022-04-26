Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B06850EE14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 03:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbiDZB24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 21:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240925AbiDZB2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:28:53 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7399120100;
        Mon, 25 Apr 2022 18:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650936347; x=1682472347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KeGSuY4mHX9enAlVIpMFhHCtiPBy1qyX+4hAvi7tfSQ=;
  b=lm4Sg7V5680dziZEVvc1bwiJZyWaFeXC09di4JuOQSexYRSwVO9/2IAK
   +3nTfpqLF3Q6iT2HAV076Ts3RXa8znBnANKE5y7M4M98heDhdmi8zBLDK
   6jGoTwE01sXFOBAldbnpqsJhDPm2Oy60XexRRCDrTk/9TrU5Ly8Q3mB7O
   /hYkpffDiriZUQzVDS3MexNNoBzwMBpWMzLWjDyPDXVlNz304WRcoqwe7
   eOgLe33MkGmftq2cG0DNUajdiQrHmWvXgRhBB5pW1gdVKWjogFZOuFZIt
   bN+RuJ19ENUHfwV0lcStQMUdvy31vQTLedNlJzumCRQcMOGhZpQ5xfsmo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="54745462"
X-IronPort-AV: E=Sophos;i="5.90,289,1643641200"; 
   d="scan'208";a="54745462"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 10:25:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1pnZ3+LhWaXQyXeTAn2fhggt8IndBe0Vjj1KlgMPhYmG1EdzMD40PTPQA9o8l01BxBP1LFeULD8xxEDMvVxxC6b1efO8n+xZ9JRm9e7DLCHnJrZF6cBRCZfMzdlggBRaSRPhyfDCV3v8Ymj68c3AsoBgKB9tIyMSuBy8flxFIjyOjFR6HWCfpDQoy3bBqMEiAAt83ehiwJMaH7YmzL/ZHlJCAvseBc9Q63bpDsGGPb6G1avk7+gSm4dDmWgAQZbLPl9Jcuca4532YkuX/IIiSd9EcdEphJ+p/t8Vkwsjmz8LktNhJK9bhxqwQBctoVpC6Hr9shWjvpE4udMbNneGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeGSuY4mHX9enAlVIpMFhHCtiPBy1qyX+4hAvi7tfSQ=;
 b=anBs4iMVtAJrFTp4XJUUfBwaJ61MQsDvNEQW9GqkYVp04dz6gJkzE/8BZlMmPfTTb7OmZRYJ94G1liOIEm/rr5a/lAkyzs/NzvJBarhWy+v9XKUrguiDaEh0lgz2Ua2+I9qSEbRrlnfejZoxtDOuymr51zAt5wSDABNeC5GVicRKDvjmmdmjy38RcPo0cYuBFFTkTJNgcYcoqltHX9wL7NBZ2ku20wGDSC8aWC3k2eX/RQpLkt+6xYoEzfIuQn4S+9Y0Vi/ddv8QH/5mZH8uf8U1SpvZGJJ8o5Vwf+l2akAY3qf2OJddS0zftsvd2v3C5BW8E+f9E8uJ83LQ0wISEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeGSuY4mHX9enAlVIpMFhHCtiPBy1qyX+4hAvi7tfSQ=;
 b=l0C6Ec0wLavoLXk6RbUZ82OVvT7Ak3sj3TfV/WW0PnN0u5KK3sysm3o5yOMNxKIwM6ZYfcgY9ejcIxIMTcHOmaf1lxD6AXG2rEOVXZ5hxB2qejhCW9R/s8Ooz/kR9ZkAzAl1VhuCWqTdF4UalKZo/r7Kdi7nddSqZRFfDcyv5KA=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYXPR01MB1840.jpnprd01.prod.outlook.com (2603:1096:403:10::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 01:25:39 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 01:25:39 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v6 3/4] fs: strip file's S_ISGID mode on vfs instead of on
 underlying filesystem
Thread-Topic: [PATCH v6 3/4] fs: strip file's S_ISGID mode on vfs instead of
 on underlying filesystem
Thread-Index: AQHYWEl0B/vFy+yRQUikDZ1In3spE60A2OSAgACgxwA=
Date:   Tue, 26 Apr 2022 01:25:39 +0000
Message-ID: <6267587A.3040908@fujitsu.com>
References: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650856181-21350-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220425165139.GC16996@magnolia>
In-Reply-To: <20220425165139.GC16996@magnolia>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e53a381e-a72b-41af-2bd4-08da2723ac5d
x-ms-traffictypediagnostic: TYXPR01MB1840:EE_
x-microsoft-antispam-prvs: <TYXPR01MB18400FED6EAF81B1BD5594C2FDFB9@TYXPR01MB1840.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZYRn+Iu0tq5Nao787Z8iE+R9Vhl/rzywpI0hiOIT4vcbY2AzHkkyXi5m3VxbflI/4TcnZ4Ht0Q/wFvgM0c2k1S3GlJiKwGtOAunuHQkjGnSeWf7ILfV7nr0NSZLw/Jq8ARYRGWcihmQlz56kEee9wzc7fn0bg6dprnLWT4eo9A4XkxrlAX+MXgpE7ORzbJ6INYzuyLo2XqWIZu+/vcKev/RrU9O4bd/FXeX5pXu0s7gJNzA3VPDJy8CQHO9gF/uYzqESITmaMpEWbJE8NpfARvsz34ZFrvDf7FtgCwgzgz6q51zQx+c6fciKIjT7+uhYMjy8B673/XJp5/KX8AGsZ2NhnH+nOJku1jxMJj1KSvJy/sa6amFGb/LpDATyAbO2KAWAlwCs44jk6ECtAboKHV61R4NuTO1eVdWgIILeUYQzdbv4Qzr5IdbYhTA3EGF/rKpZxvwz8PT054m36FjYVNSjVIsWunSke2bzd7pymCF7GjJvbWjERpKuvmzp1DreIR8MZkIxDbaxWqnrlu6GOZQ/wkIvbncy28Y1VfcPORSEu1AtzOCh9ztnnmLf4Op9eQAVRbPT1Oq963x2f5fU6l6Q+mnE5etkKr5HNm5DpUDOrB9Uh12gF9ULEeLIWFxfvBaHiQkXcSF+FD0sX+z07Z+Nu2zCJHF9b/21NWgTEimhOLyHqRa1lnK5s7YQGbOyF7P/gqAEtukHauxgRUWa5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6506007)(5660300002)(87266011)(8936002)(186003)(2616005)(30864003)(36756003)(85182001)(83380400001)(6512007)(26005)(4326008)(6486002)(508600001)(33656002)(316002)(54906003)(6916009)(122000001)(38070700005)(66946007)(38100700002)(71200400001)(86362001)(8676002)(66556008)(66476007)(66446008)(64756008)(76116006)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WEZJT1VMVkx4ZndrTS9XTkxsYjY4eUhuZFpZNitINHFWUHc3akhqdVpGeUN4?=
 =?gb2312?B?aSt5ampMemZ3NWIwSTNTYlpqTFJISCt6RWdaREVNUktSNXFqYlRYS0dFbW5k?=
 =?gb2312?B?Q2c2TGxZZFpvTHBmWXVaMjJjdnNuUUdtRHdxdEVsZFhVZmFVYmsxV2FsN1lY?=
 =?gb2312?B?MWE1S0VNRzROTTNveVV0SEl4TWxHcGZZYTFpenpQejJGeEpwWVFxbzRVQ3Jh?=
 =?gb2312?B?T1V6Z1A4NG4vbDIrNkVqSStucUQ4ci9HaHR1YWlENXNyT3Z2VURBY1hyQzJw?=
 =?gb2312?B?SU1HR25SZ1NhL0Eya3UzY2tXQ2ZlaXlzSnhqU3EvK3hjVlN3UmZEQXFPL2pr?=
 =?gb2312?B?MXNDTVhBQ1p5cUd5d2xyM05SRDJKbFduNGxlenRnUFNNTHBNYXRELzBqMC96?=
 =?gb2312?B?a1cveVhGQ1BHQ1NXZXY4YTNQM0JraHdIbFQwZC9DTkp1VUZ1ZENYU2RVMHI2?=
 =?gb2312?B?M1QreU9mRDNPOVNxTmRHaUNnV2NNaGI2YlF2Z2lVVTBBd2liZXNQekFOMEw5?=
 =?gb2312?B?MEZTRjVVenhnbytsbjYrM2JjYnhuVzBuSDVEYVJmN3ZDMHdoWXZTSkQ0NFdR?=
 =?gb2312?B?ZjUyN2NjZXg0eXJQTnJvL0kvSWt4UHNjTkptSlBkZU5XQ3RNY3lpeFNjdE1N?=
 =?gb2312?B?eGJxU2VlVmZLTjRzSU1tMjhVV1o4ZHNzQ01Uakk0RlE5T3k3TW80UjlMQzQ3?=
 =?gb2312?B?SzR2STNSQUt4akNDenFDdUpKbVhvVDdrb1BDdm5GdzVEMjdRaFpSK0dUYk5F?=
 =?gb2312?B?bVJXQTNZZnRVc0duUjFGeUs2ZVVrVzFteTNBZXI4Z0Y1c2pRTlBLdExuV3Mz?=
 =?gb2312?B?ajhRZEhiTld4dWhCRzREalFRV2MrRENSZGdwamJNcDhKclNVT05YOEVJa0Nn?=
 =?gb2312?B?eTlUcnN0cFhtRVo2NUt1UERla1puZ2J1czFjTGNTMU9XVDJvbGVtcG1yY0Nt?=
 =?gb2312?B?c0NJY090bCswTU4xUVRxQks4UGc0NW5kejF5bUNHdXBwN2JRdjJXODVTMkxh?=
 =?gb2312?B?eWJPbktQQkFoNFYvbG9VZHpWOThMeTlZMGJUVG9PbEdVWjF5NFJ6WUMxOG5M?=
 =?gb2312?B?RStpR0VDWjRxdisrME1zTmp1Y3NsMjFJK3lENzZOVkJPK2wwL2ZqMHlNRlVm?=
 =?gb2312?B?aFh5ZWk0WXNWOWJwbVorSUxFR3YvckQzWTRhMG5pS2FQUnB4bjUvN01mSXFk?=
 =?gb2312?B?QStyNU1tblZLN1lrcDlxNGxBa0hjS09nczRRVzcwM1dWVVdTOEg5NkxpWHZM?=
 =?gb2312?B?ejAxa3h0L3R0YkRRQU11M05MNEV2SVYrYkhxQjFZUnJNeTBML2F3Rm91WDlE?=
 =?gb2312?B?REdVRFhselhRRnFDdXlVTHRoV081T0hPYVB4ZkJERHY2V29PMi9xb21HWWFr?=
 =?gb2312?B?c1R3WERiRFd3aUx6T2RKb2lobzhiVXF5NlZWeStHZ2VlUGFUMGVSU2JHRzVF?=
 =?gb2312?B?SGN4K3JaMEdMVkFPTDE0S25SQ0RabWxLQkdZdWRBSTM1R3hHQ01YQ21YRTFE?=
 =?gb2312?B?c0d6RWdTaDMrNGVBc2xVeS9iaE9GbzMvcTlHRGgwTUgzOFBPUVBDcDNJS29H?=
 =?gb2312?B?aHQzL2FwN0Y1OHJLOWJPTEYzcXV2WVZrUFpMZENlclEvOWFIR0FPaWtZemxm?=
 =?gb2312?B?QTZ1ZzhjQVRHejJ3ZUFReURuTzRmWmJ3NkVvdkxVQUhQWXNOOXFieThpT3l2?=
 =?gb2312?B?MktDb2ZJL1lnMnpjN2Y5VkprZHViUG1KZjAzc2RTZlJxZTh5OC9welJrWGo2?=
 =?gb2312?B?N1VnazV4SEozRm15bWZPVzJqZTdtZG91a3RqR2NVVmk5OUJqaHU3UHVzTlFJ?=
 =?gb2312?B?WG5LclFrQjZGUkhSbFVoVCtOb3pkWXVkbWtFVjdqOFluMEdieEVZc3dFakg2?=
 =?gb2312?B?dkVPdThzNFZRSjBrNFlHQUtoNkdUT3ArTWxLR05kUlhjOHl1SW1iNFYyOHZ6?=
 =?gb2312?B?SFJqSDVkYUtack5LUVpGRTdYUTdRbzBnNUsvOUtkWjJ4aHlHMm91RmRHemZx?=
 =?gb2312?B?WTZKYVI5MlBxMXJRTDBHZHRvOTRRSng2bmpHVlpUVmlWQWs1NUc1ajB2K1F3?=
 =?gb2312?B?TEFiV096bzMzOU1QYUw3MDZDL29mSmRHNjVBMGVnOTNZdmZESEhxNUZ4UXor?=
 =?gb2312?B?WHBCNlpLcU9OS1VoRVVFT0haQWQvWXZBUGVtOTJsbzdSdEdLNzhrczFQMllK?=
 =?gb2312?B?RFltb2xxZTRLbHRMdjU4aGVVcGVEbmdBTThlTmkrVzZPL3Q0Q1BHR0lCVkRk?=
 =?gb2312?B?azZiTkN3WUEwbm5CbFFENFoyMTFOVmNqU3VLNnNYcDJoVUFESGVxL3M5Tlhq?=
 =?gb2312?B?bjM4TVJXZGkyMHJ0RERKK3ZSYzh3YS9GdDQvZ3lzSEV5YkVWVlo2ZDh4VVRP?=
 =?gb2312?Q?DaQtpREBjkbzIKkJBaUhxf9j+CMS1EQfQy3rL?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <A62C4BF90C9D494DB535DD5CECF60CE4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53a381e-a72b-41af-2bd4-08da2723ac5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 01:25:39.5159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25QsceQsvf3glQW0zGo8CfAJxFjNNRYtpDIoGLa6QzBson2ju6swq/rEBiq8ACEiXOiU0J4w4hb3vXrxSL6hCaq99R9ifbhwayw5SXxfueo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1840
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzI2IDA6NTEsIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4gT24gTW9uLCBBcHIg
MjUsIDIwMjIgYXQgMTE6MDk6NDBBTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IEN1cnJlbnRs
eSwgdmZzIG9ubHkgcGFzc2VzIG1vZGUgYXJndW1lbnQgdG8gZmlsZXN5c3RlbSwgdGhlbiB1c2Ug
aW5vZGVfaW5pdF9vd25lcigpDQo+PiB0byBzdHJpcCBTX0lTR0lELiBTb21lIGZpbGVzeXN0ZW0o
aWUgZXh0NC9idHJmcykgd2lsbCBjYWxsIGlub2RlX2luaXRfb3duZXINCj4+IGZpcnN0bHksIHRo
ZW4gcG9zeGkgYWNsIHNldHVwLCBidXQgeGZzIHVzZXMgdGhlIGNvbnRyYXJ5IG9yZGVyLiBJdCB3
aWxsDQo+PiBhZmZlY3QgU19JU0dJRCBjbGVhciBlc3BlY2lhbGx5IHdlIGZpbHRlciBTX0lYR1JQ
IGJ5IHVtYXNrIG9yIGFjbC4NCj4+DQo+PiBSZWdhcmRsZXNzIG9mIHdoaWNoIGZpbGVzeXN0ZW0g
aXMgaW4gdXNlLCBmYWlsdXJlIHRvIHN0cmlwIHRoZSBTR0lEIGNvcnJlY3RseQ0KPj4gaXMgY29u
c2lkZXJlZCBhIHNlY3VyaXR5IGZhaWx1cmUgdGhhdCBuZWVkcyB0byBiZSBmaXhlZC4gVGhlIGN1
cnJlbnQgVkZTDQo+PiBpbmZyYXN0cnVjdHVyZSByZXF1aXJlcyB0aGUgZmlsZXN5c3RlbSB0byBk
byBldmVyeXRoaW5nIHJpZ2h0IGFuZCBub3Qgc3RlcCBvbg0KPj4gYW55IGxhbmRtaW5lcyB0byBz
dHJpcCB0aGUgU0dJRCBiaXQsIHdoZW4gaW4gZmFjdCBpdCBjYW4gZWFzaWx5IGJlIGRvbmUgYXQg
dGhlDQo+PiBWRlMgYW5kIHRoZSBmaWxlc3lzdGVtcyB0aGVuIGRvbid0IGV2ZW4gbmVlZCB0byBi
ZSBhd2FyZSB0aGF0IHRoZSBTR0lEIG5lZWRzDQo+PiB0byBiZSAob3IgaGFzIGJlZW4gc3RyaXBw
ZWQpIGJ5IHRoZSBvcGVyYXRpb24gdGhlIHVzZXIgYXNrZWQgdG8gYmUgZG9uZS4NCj4+DQo+PiBW
ZnMgaGFzIGFsbCB0aGUgaW5mbyBpdCBuZWVkcyAtIGl0IGRvZXNuJ3QgbmVlZCB0aGUgZmlsZXN5
c3RlbXMgdG8gZG8gZXZlcnl0aGluZw0KPj4gY29ycmVjdGx5IHdpdGggdGhlIG1vZGUgYW5kIGVu
c3VyaW5nIHRoYXQgdGhleSBvcmRlciB0aGluZ3MgbGlrZSBwb3NpeCBhY2wgc2V0dXANCj4+IGZ1
bmN0aW9ucyBjb3JyZWN0bHkgd2l0aCBpbm9kZV9pbml0X293bmVyKCkgdG8gc3RyaXAgdGhlIFNH
SUQgYml0Lg0KPj4NCj4+IEp1c3Qgc3RyaXAgdGhlIFNHSUQgYml0IGF0IHRoZSBWRlMsIGFuZCB0
aGVuIHRoZSBmaWxlc3lzdGVtIGNhbid0IGdldCBpdCB3cm9uZy4NCj4+DQo+PiBBbHNvLCB0aGUg
aW5vZGVfc2dpZF9zdHJpcCgpIGFwaSBzaG91bGQgYmUgdXNlZCBiZWZvcmUgSVNfUE9TSVhBQ0wo
KSBiZWNhdXNlDQo+PiB0aGlzIGFwaSBtYXkgY2hhbmdlIG1vZGUuDQo+Pg0KPj4gT25seSB0aGUg
Zm9sbG93aW5nIHBsYWNlcyB1c2UgaW5vZGVfaW5pdF9vd25lcg0KPj4gIg0KPj4gYXJjaC9wb3dl
cnBjL3BsYXRmb3Jtcy9jZWxsL3NwdWZzL2lub2RlLmM6ICAgICAgaW5vZGVfaW5pdF9vd25lcigm
aW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlIHwgU19JRkRJUik7DQo+PiBhcmNoL3Bvd2Vy
cGMvcGxhdGZvcm1zL2NlbGwvc3B1ZnMvaW5vZGUuYzogICAgICBpbm9kZV9pbml0X293bmVyKCZp
bml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUgfCBTX0lGRElSKTsNCj4+IGZzLzlwL3Zmc19p
bm9kZS5jOiAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIE5VTEws
IG1vZGUpOw0KPj4gZnMvYmZzL2Rpci5jOiAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9u
cywgaW5vZGUsIGRpciwgbW9kZSk7DQo+PiBmcy9idHJmcy9pbm9kZS5jOiAgICAgICBpbm9kZV9p
bml0X293bmVyKG1udF91c2VybnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gZnMvYnRyZnMvdGVz
dHMvYnRyZnMtdGVzdHMuYzogICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2Rl
LCBOVUxMLCBTX0lGUkVHKTsNCj4+IGZzL2V4dDIvaWFsbG9jLmM6ICAgICAgICAgICAgICAgaW5v
ZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+IGZzL2V4
dDQvaWFsbG9jLmM6ICAgICAgICAgICAgICAgaW5vZGVfaW5pdF9vd25lcihtbnRfdXNlcm5zLCBp
bm9kZSwgZGlyLCBtb2RlKTsNCj4+IGZzL2YyZnMvbmFtZWkuYzogICAgICAgIGlub2RlX2luaXRf
b3duZXIobW50X3VzZXJucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+PiBmcy9oZnNwbHVzL2lub2Rl
LmM6ICAgICBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUp
Ow0KPj4gZnMvaHVnZXRsYmZzL2lub2RlLmM6ICAgICAgICAgICBpbm9kZV9pbml0X293bmVyKCZp
bml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gZnMvamZzL2pmc19pbm9kZS5jOiAg
ICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgcGFyZW50LCBtb2RlKTsN
Cj4+IGZzL21pbml4L2JpdG1hcC5jOiAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9u
cywgaW5vZGUsIGRpciwgbW9kZSk7DQo+PiBmcy9uaWxmczIvaW5vZGUuYzogICAgICBpbm9kZV9p
bml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gZnMvbnRmczMv
aW5vZGUuYzogICAgICAgaW5vZGVfaW5pdF9vd25lcihtbnRfdXNlcm5zLCBpbm9kZSwgZGlyLCBt
b2RlKTsNCj4+IGZzL29jZnMyL2RsbWZzL2RsbWZzLmM6ICAgICAgICAgaW5vZGVfaW5pdF9vd25l
cigmaW5pdF91c2VyX25zLCBpbm9kZSwgTlVMTCwgbW9kZSk7DQo+PiBmcy9vY2ZzMi9kbG1mcy9k
bG1mcy5jOiBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBwYXJlbnQsIG1v
ZGUpOw0KPj4gZnMvb2NmczIvbmFtZWkuYzogICAgICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91
c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+IGZzL29tZnMvaW5vZGUuYzogICAgICAgIGlu
b2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIE5VTEwsIG1vZGUpOw0KPj4gZnMv
b3ZlcmxheWZzL2Rpci5jOiAgICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9k
ZSwgZGVudHJ5LT5kX3BhcmVudC0+ZF9pbm9kZSwgbW9kZSk7DQo+PiBmcy9yYW1mcy9pbm9kZS5j
OiAgICAgICAgICAgICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRp
ciwgbW9kZSk7DQo+PiBmcy9yZWlzZXJmcy9uYW1laS5jOiAgICBpbm9kZV9pbml0X293bmVyKCZp
bml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gZnMvc3lzdi9pYWxsb2MuYzogICAg
ICAgaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+
IGZzL3ViaWZzL2Rpci5jOiBpbm9kZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBk
aXIsIG1vZGUpOw0KPj4gZnMvdWRmL2lhbGxvYy5jOiAgICAgICAgaW5vZGVfaW5pdF9vd25lcigm
aW5pdF91c2VyX25zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4+IGZzL3Vmcy9pYWxsb2MuYzogICAg
ICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNlcl9ucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+
PiBmcy94ZnMveGZzX2lub2RlLmM6ICAgICAgICAgICAgIGlub2RlX2luaXRfb3duZXIobW50X3Vz
ZXJucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+PiBmcy96b25lZnMvc3VwZXIuYzogICAgICBpbm9k
ZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBwYXJlbnQsIFNfSUZESVIgfCAwNTU1
KTsNCj4+IGtlcm5lbC9icGYvaW5vZGUuYzogICAgIGlub2RlX2luaXRfb3duZXIoJmluaXRfdXNl
cl9ucywgaW5vZGUsIGRpciwgbW9kZSk7DQo+PiBtbS9zaG1lbS5jOiAgICAgICAgICAgICBpbm9k
ZV9pbml0X293bmVyKCZpbml0X3VzZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4gIg0KPj4N
Cj4+IFRoZXkgYXJlIHVzZWQgaW4gZmlsZXN5c3RlbSB0byBpbml0IG5ldyBpbm9kZSBmdW5jdGlv
biBhbmQgdGhlc2UgaW5pdCBpbm9kZQ0KPj4gZnVuY3Rpb25zIGFyZSB1c2VkIGJ5IGZvbGxvd2lu
ZyBvcGVyYXRpb25zOg0KPj4gbWtkaXINCj4+IHN5bWxpbmsNCj4+IG1rbm9kDQo+PiBjcmVhdGUN
Cj4+IHRtcGZpbGUNCj4+IHJlbmFtZQ0KPj4NCj4+IFdlIGRvbid0IGNhcmUgYWJvdXQgbWtkaXIg
YmVjYXVzZSB3ZSBkb24ndCBzdHJpcCBTR0lEIGJpdCBmb3IgZGlyZWN0b3J5IGV4Y2VwdA0KPj4g
ZnMueGZzLmlyaXhfc2dpZF9pbmhlcml0LiBCdXQgd2UgZXZlbiBjYWxsIHByZXBhcmVfbW9kZSgp
IGluIGRvX21rZGlyYXQoKSBzaW5jZQ0KPj4gaW5vZGVfc2dpZF9zdHJpcCgpIHdpbGwgc2tpcCBk
aXJlY3RvcmllcyBhbnl3YXkuIFRoaXMgd2lsbCBlbmZvcmNlIHRoZSBzYW1lDQo+PiBvcmRlcmlu
ZyBmb3IgYWxsIHJlbGV2YW50IG9wZXJhdGlvbnMgYW5kIGl0IHdpbGwgbWFrZSB0aGUgY29kZSBt
b3JlIHVuaWZvcm0gYW5kDQo+PiBlYXNpZXIgdG8gdW5kZXJzdGFuZCBieSB1c2luZyBuZXcgaGVs
cGVyIHByZXBhcmVfbW9kZSgpLg0KPj4NCj4+IHN5bWxpbmsgYW5kIHJlbmFtZSBvbmx5IHVzZSB2
YWxpZCBtb2RlIHRoYXQgZG9lc24ndCBoYXZlIFNHSUQgYml0Lg0KPj4NCj4+IFdlIGhhdmUgYWRk
ZWQgaW5vZGVfc2dpZF9zdHJpcCBhcGkgZm9yIHRoZSByZW1haW5pbmcgb3BlcmF0aW9ucy4NCj4+
DQo+PiBJbiBhZGRpdGlvbiB0byB0aGUgYWJvdmUgc2l4IG9wZXJhdGlvbnMsIGZvdXIgZmlsZXN5
c3RlbXMgaGFzIGEgbGl0dGxlIGRpZmZlcmVuY2UNCj4+IDEpIGJ0cmZzIGhhcyBidHJmc19jcmVh
dGVfc3Vidm9sX3Jvb3QgdG8gY3JlYXRlIG5ldyBpbm9kZSBidXQgdXNlZCBub24gU0dJRCBiaXQN
Cj4+ICAgICBtb2RlIGFuZCBjYW4gaWdub3JlDQo+PiAyKSBvY2ZzMiByZWZsaW5rIGZ1bmN0aW9u
IHNob3VsZCBhZGQgaW5vZGVfc2dpZF9zdHJpcCBhcGkgbWFudWFsbHkgYmVjYXVzZSB0aGlzIGlv
Y3RsDQo+PiAgICAgaXMgb25seSB1c2VmdWwgd2hlbiBiYWNrcG9ydCByZWZsaW5rIGZlYXR1cmVz
IHRvIG9sZCBrZXJuZWxzLiBvY2ZzMiBzdGlsbCB1c2UgdmZzDQo+PiAgICAgcmVtYXBfcmFuZ2Ug
Y29kZSB0byBkbyByZWZsaW5rLg0KPj4gMykgc3B1ZnMgd2hpY2ggZG9lc24ndCByZWFsbHkgZ28g
aHJvdWdoIHRoZSByZWd1bGFyIFZGUyBjYWxscGF0aCBiZWNhdXNlIGl0IGhhcw0KPj4gICAgIHNl
cGFyYXRlIHN5c3RlbSBjYWxsIHNwdV9jcmVhdGUsIGJ1dCBpdCB0IG9ubHkgYWxsb3dzIHRoZSBj
cmVhdGlvbiBvZg0KPj4gICAgIGRpcmVjdG9yaWVzIGFuZCBvbmx5IGFsbG93cyBiaXRzIGluIDA3
NzcgYW5kIGNhbiBpZ25vcmUNCj4+IDQpIGJwZiB1c2UgdmZzX21rb2JqIGluIGJwZl9vYmpfZG9f
cGluIHdpdGgNCj4+ICAgICAiU19JRlJFRyB8ICgoU19JUlVTUiB8IFNfSVdVU1IpJiAgfmN1cnJl
bnRfdW1hc2soKSkgbW9kZSBhbmQNCj4+ICAgICB1c2UgYnBmX21rb2JqX29wcyBpbiBicGZfaXRl
cl9saW5rX3Bpbl9rZXJuZWwgd2l0aCBTX0lGUkVHIHwgU19JUlVTUiBtb2RlLA0KPj4gICAgIHNv
IGJwZiBpcyBhbHNvIG5vdCBhZmZlY3RlZA0KPj4NCj4+IFRoaXMgcGF0Y2ggYWxzbyBjaGFuZ2Vk
IGdycGlkIGJlaGF2aW91ciBmb3IgZXh0NC94ZnMgYmVjYXVzZSB0aGUgbW9kZSBwYXNzZWQgdG8N
Cj4+IHRoZW0gbWF5IGJlZW4gY2hhbmdlZCBieSBpbm9kZV9zZ2lkX3N0cmlwLg0KPj4NCj4+IEFs
c28gYXMgQ2hyaXN0aWFuIEJyYXVuZXIgc2FpZCINCj4+IFRoZSBwYXRjaCBpdHNlbGYgaXMgdXNl
ZnVsIGFzIGl0IHdvdWxkIG1vdmUgYSBzZWN1cml0eSBzZW5zaXRpdmUgb3BlcmF0aW9uIHRoYXQg
aXMNCj4+IGN1cnJlbnRseSBidXJyaWVkIGluIGluZGl2aWR1YWwgZmlsZXN5c3RlbXMgaW50byB0
aGUgdmZzIGxheWVyLiBCdXQgaXQgaGFzIGEgZGVjZW50DQo+PiByZWdyZXNzaW9uICBwb3RlbnRp
YWwgc2luY2UgaXQgbWlnaHQgc3RyaXAgZmlsZXN5c3RlbXMgdGhhdCBoYXZlIHNvIGZhciByZWxp
ZWQgb24NCj4+IGdldHRpbmcgdGhlIFNfSVNHSUQgYml0IHdpdGggYSBtb2RlIGFyZ3VtZW50LiBT
byB0aGlzIG5lZWRzIGEgbG90IG9mIHRlc3RpbmcgYW5kDQo+PiBsb25nIGV4cG9zdXJlIGluIC1u
ZXh0IGZvciBhdCBsZWFzdCBvbmUgZnVsbCBrZXJuZWwgY3ljbGUuIg0KPj4NCj4+IFN1Z2dlc3Rl
ZC1ieTogRGF2ZSBDaGlubmVyPGRhdmlkQGZyb21vcmJpdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBZYW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgZnMvaW5v
ZGUuYyAgICAgICAgIHwgIDIgLS0NCj4+ICAgZnMvbmFtZWkuYyAgICAgICAgIHwgMjIgKysrKysr
KysrLS0tLS0tLS0tLS0tLQ0KPj4gICBmcy9vY2ZzMi9uYW1laS5jICAgfCAgMSArDQo+PiAgIGlu
Y2x1ZGUvbGludXgvZnMuaCB8IDExICsrKysrKysrKysrDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwg
MjEgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Zz
L2lub2RlLmMgYi9mcy9pbm9kZS5jDQo+PiBpbmRleCA3OGU3ZWY1NjdlMDQuLjA0MWMwODM3ZjI0
OCAxMDA2NDQNCj4+IC0tLSBhL2ZzL2lub2RlLmMNCj4+ICsrKyBiL2ZzL2lub2RlLmMNCj4+IEBA
IC0yMjQ2LDggKzIyNDYsNiBAQCB2b2lkIGlub2RlX2luaXRfb3duZXIoc3RydWN0IHVzZXJfbmFt
ZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPj4gICAJCS8qIERpcmVj
dG9yaWVzIGFyZSBzcGVjaWFsLCBhbmQgYWx3YXlzIGluaGVyaXQgU19JU0dJRCAqLw0KPj4gICAJ
CWlmIChTX0lTRElSKG1vZGUpKQ0KPj4gICAJCQltb2RlIHw9IFNfSVNHSUQ7DQo+PiAtCQllbHNl
DQo+PiAtCQkJbW9kZSA9IGlub2RlX3NnaWRfc3RyaXAobW50X3VzZXJucywgZGlyLCBtb2RlKTsN
Cj4+ICAgCX0gZWxzZQ0KPj4gICAJCWlub2RlX2ZzZ2lkX3NldChpbm9kZSwgbW50X3VzZXJucyk7
DQo+PiAgIAlpbm9kZS0+aV9tb2RlID0gbW9kZTsNCj4+IGRpZmYgLS1naXQgYS9mcy9uYW1laS5j
IGIvZnMvbmFtZWkuYw0KPj4gaW5kZXggNzM2NDZlMjhmYWUwLi41YjhlNjI4OGQ1MDMgMTAwNjQ0
DQo+PiAtLS0gYS9mcy9uYW1laS5jDQo+PiArKysgYi9mcy9uYW1laS5jDQo+PiBAQCAtMzI4Nyw4
ICszMjg3LDcgQEAgc3RhdGljIHN0cnVjdCBkZW50cnkgKmxvb2t1cF9vcGVuKHN0cnVjdCBuYW1l
aWRhdGEgKm5kLCBzdHJ1Y3QgZmlsZSAqZmlsZSwNCj4+ICAgCWlmIChvcGVuX2ZsYWcmICBPX0NS
RUFUKSB7DQo+PiAgIAkJaWYgKG9wZW5fZmxhZyYgIE9fRVhDTCkNCj4+ICAgCQkJb3Blbl9mbGFn
Jj0gfk9fVFJVTkM7DQo+PiAtCQlpZiAoIUlTX1BPU0lYQUNMKGRpci0+ZF9pbm9kZSkpDQo+PiAt
CQkJbW9kZSY9IH5jdXJyZW50X3VtYXNrKCk7DQo+PiArCQltb2RlID0gcHJlcGFyZV9tb2RlKG1u
dF91c2VybnMsIGRpci0+ZF9pbm9kZSwgbW9kZSk7DQo+PiAgIAkJaWYgKGxpa2VseShnb3Rfd3Jp
dGUpKQ0KPj4gICAJCQljcmVhdGVfZXJyb3IgPSBtYXlfb19jcmVhdGUobW50X3VzZXJucywmbmQt
PnBhdGgsDQo+PiAgIAkJCQkJCSAgICBkZW50cnksIG1vZGUpOw0KPj4gQEAgLTM1MjEsOCArMzUy
MCw3IEBAIHN0cnVjdCBkZW50cnkgKnZmc190bXBmaWxlKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAq
bW50X3VzZXJucywNCj4+ICAgCWNoaWxkID0gZF9hbGxvYyhkZW50cnksJnNsYXNoX25hbWUpOw0K
Pj4gICAJaWYgKHVubGlrZWx5KCFjaGlsZCkpDQo+PiAgIAkJZ290byBvdXRfZXJyOw0KPj4gLQlp
ZiAoIUlTX1BPU0lYQUNMKGRpcikpDQo+PiAtCQltb2RlJj0gfmN1cnJlbnRfdW1hc2soKTsNCj4+
ICsJbW9kZSA9IHByZXBhcmVfbW9kZShtbnRfdXNlcm5zLCBkaXIsIG1vZGUpOw0KPj4gICAJZXJy
b3IgPSBkaXItPmlfb3AtPnRtcGZpbGUobW50X3VzZXJucywgZGlyLCBjaGlsZCwgbW9kZSk7DQo+
PiAgIAlpZiAoZXJyb3IpDQo+PiAgIAkJZ290byBvdXRfZXJyOw0KPj4gQEAgLTM4NTAsMTMgKzM4
NDgsMTIgQEAgc3RhdGljIGludCBkb19ta25vZGF0KGludCBkZmQsIHN0cnVjdCBmaWxlbmFtZSAq
bmFtZSwgdW1vZGVfdCBtb2RlLA0KPj4gICAJaWYgKElTX0VSUihkZW50cnkpKQ0KPj4gICAJCWdv
dG8gb3V0MTsNCj4+DQo+PiAtCWlmICghSVNfUE9TSVhBQ0wocGF0aC5kZW50cnktPmRfaW5vZGUp
KQ0KPj4gLQkJbW9kZSY9IH5jdXJyZW50X3VtYXNrKCk7DQo+PiArCW1udF91c2VybnMgPSBtbnRf
dXNlcl9ucyhwYXRoLm1udCk7DQo+PiArCW1vZGUgPSBwcmVwYXJlX21vZGUobW50X3VzZXJucywg
cGF0aC5kZW50cnktPmRfaW5vZGUsIG1vZGUpOw0KPj4gICAJZXJyb3IgPSBzZWN1cml0eV9wYXRo
X21rbm9kKCZwYXRoLCBkZW50cnksIG1vZGUsIGRldik7DQo+PiAgIAlpZiAoZXJyb3IpDQo+PiAg
IAkJZ290byBvdXQyOw0KPj4NCj4+IC0JbW50X3VzZXJucyA9IG1udF91c2VyX25zKHBhdGgubW50
KTsNCj4+ICAgCXN3aXRjaCAobW9kZSYgIFNfSUZNVCkgew0KPj4gICAJCWNhc2UgMDogY2FzZSBT
X0lGUkVHOg0KPj4gICAJCQllcnJvciA9IHZmc19jcmVhdGUobW50X3VzZXJucywgcGF0aC5kZW50
cnktPmRfaW5vZGUsDQo+PiBAQCAtMzk0Myw2ICszOTQwLDcgQEAgaW50IGRvX21rZGlyYXQoaW50
IGRmZCwgc3RydWN0IGZpbGVuYW1lICpuYW1lLCB1bW9kZV90IG1vZGUpDQo+PiAgIAlzdHJ1Y3Qg
cGF0aCBwYXRoOw0KPj4gICAJaW50IGVycm9yOw0KPj4gICAJdW5zaWduZWQgaW50IGxvb2t1cF9m
bGFncyA9IExPT0tVUF9ESVJFQ1RPUlk7DQo+PiArCXN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50
X3VzZXJuczsNCj4+DQo+PiAgIHJldHJ5Og0KPj4gICAJZGVudHJ5ID0gZmlsZW5hbWVfY3JlYXRl
KGRmZCwgbmFtZSwmcGF0aCwgbG9va3VwX2ZsYWdzKTsNCj4+IEBAIC0zOTUwLDE1ICszOTQ4LDEz
IEBAIGludCBkb19ta2RpcmF0KGludCBkZmQsIHN0cnVjdCBmaWxlbmFtZSAqbmFtZSwgdW1vZGVf
dCBtb2RlKQ0KPj4gICAJaWYgKElTX0VSUihkZW50cnkpKQ0KPj4gICAJCWdvdG8gb3V0X3B1dG5h
bWU7DQo+Pg0KPj4gLQlpZiAoIUlTX1BPU0lYQUNMKHBhdGguZGVudHJ5LT5kX2lub2RlKSkNCj4+
IC0JCW1vZGUmPSB+Y3VycmVudF91bWFzaygpOw0KPj4gKwltbnRfdXNlcm5zID0gbW50X3VzZXJf
bnMocGF0aC5tbnQpOw0KPj4gKwltb2RlID0gcHJlcGFyZV9tb2RlKG1udF91c2VybnMsIHBhdGgu
ZGVudHJ5LT5kX2lub2RlLCBtb2RlKTsNCj4+ICAgCWVycm9yID0gc2VjdXJpdHlfcGF0aF9ta2Rp
cigmcGF0aCwgZGVudHJ5LCBtb2RlKTsNCj4+IC0JaWYgKCFlcnJvcikgew0KPj4gLQkJc3RydWN0
IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zOw0KPj4gLQkJbW50X3VzZXJucyA9IG1udF91c2Vy
X25zKHBhdGgubW50KTsNCj4+ICsJaWYgKCFlcnJvcikNCj4+ICAgCQllcnJvciA9IHZmc19ta2Rp
cihtbnRfdXNlcm5zLCBwYXRoLmRlbnRyeS0+ZF9pbm9kZSwgZGVudHJ5LA0KPj4gICAJCQkJICBt
b2RlKTsNCj4+IC0JfQ0KPj4gKw0KPj4gICAJZG9uZV9wYXRoX2NyZWF0ZSgmcGF0aCwgZGVudHJ5
KTsNCj4+ICAgCWlmIChyZXRyeV9lc3RhbGUoZXJyb3IsIGxvb2t1cF9mbGFncykpIHsNCj4+ICAg
CQlsb29rdXBfZmxhZ3MgfD0gTE9PS1VQX1JFVkFMOw0KPj4gZGlmZiAtLWdpdCBhL2ZzL29jZnMy
L25hbWVpLmMgYi9mcy9vY2ZzMi9uYW1laS5jDQo+PiBpbmRleCBjNzVmZDU0YjkxODUuLjIxZjNk
YTJlNjZjOSAxMDA2NDQNCj4+IC0tLSBhL2ZzL29jZnMyL25hbWVpLmMNCj4+ICsrKyBiL2ZzL29j
ZnMyL25hbWVpLmMNCj4+IEBAIC0xOTcsNiArMTk3LDcgQEAgc3RhdGljIHN0cnVjdCBpbm9kZSAq
b2NmczJfZ2V0X2luaXRfaW5vZGUoc3RydWN0IGlub2RlICpkaXIsIHVtb2RlX3QgbW9kZSkNCj4+
ICAgCSAqIGNhbGxlcnMuICovDQo+PiAgIAlpZiAoU19JU0RJUihtb2RlKSkNCj4+ICAgCQlzZXRf
bmxpbmsoaW5vZGUsIDIpOw0KPj4gKwltb2RlID0gaW5vZGVfc2dpZF9zdHJpcCgmaW5pdF91c2Vy
X25zLCBkaXIsIG1vZGUpOw0KPj4gICAJaW5vZGVfaW5pdF9vd25lcigmaW5pdF91c2VyX25zLCBp
bm9kZSwgZGlyLCBtb2RlKTsNCj4+ICAgCXN0YXR1cyA9IGRxdW90X2luaXRpYWxpemUoaW5vZGUp
Ow0KPj4gICAJaWYgKHN0YXR1cykNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZzLmgg
Yi9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4+IGluZGV4IDUzMmRlNzZjOWI5MS4uY2E3MGNkZjljOWUy
IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9mcy5oDQo+PiArKysgYi9pbmNsdWRlL2xp
bnV4L2ZzLmgNCj4+IEBAIC0zNDU5LDYgKzM0NTksMTcgQEAgc3RhdGljIGlubGluZSBib29sIGRp
cl9yZWxheF9zaGFyZWQoc3RydWN0IGlub2RlICppbm9kZSkNCj4+ICAgCXJldHVybiAhSVNfREVB
RERJUihpbm9kZSk7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIGlubGluZSB1bW9kZV90IHByZXBh
cmVfbW9kZShzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMsDQo+DQo+IFlvdSBwcm9i
YWJseSBvdWdodCB0byBtYWtlIHRoaXMgbW9yZSBvYnZpb3VzbHkgYSAqZmlsZSogbW9kZSBwcmVw
YXJhdGlvbg0KPiBmdW5jdGlvbiBieSBuYW1pbmcgaXQgInZmc19wcmVwYXJlX21vZGUiIG9yIHNv
bWV0aGluZy4NCg0KSSB3aWxsIHVzZSB2ZnNfcHJlcGFyZV9tb2RlKCkuDQoNCj4NCj4gLS1EDQo+
DQo+PiArCQkJCSAgIGNvbnN0IHN0cnVjdCBpbm9kZSAqZGlyLCB1bW9kZV90IG1vZGUpDQo+PiAr
ew0KPj4gKwltb2RlID0gaW5vZGVfc2dpZF9zdHJpcChtbnRfdXNlcm5zLCBkaXIsIG1vZGUpOw0K
Pj4gKw0KPj4gKwlpZiAoIUlTX1BPU0lYQUNMKGRpcikpDQo+PiArCQltb2RlJj0gfmN1cnJlbnRf
dW1hc2soKTsNCj4+ICsNCj4+ICsJcmV0dXJuIG1vZGU7DQo+PiArfQ0KPj4gKw0KPj4gICBleHRl
cm4gYm9vbCBwYXRoX25vZXhlYyhjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCk7DQo+PiAgIGV4dGVy
biB2b2lkIGlub2RlX25vaGlnaG1lbShzdHJ1Y3QgaW5vZGUgKmlub2RlKTsNCj4+DQo+PiAtLQ0K
Pj4gMi4yNy4wDQo+Pg0K
