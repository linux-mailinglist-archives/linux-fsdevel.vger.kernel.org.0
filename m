Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B2F50B0EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 08:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444426AbiDVG4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 02:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiDVG4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:56:10 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF9550E24;
        Thu, 21 Apr 2022 23:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650610397; x=1682146397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dCfBI0WwGSAYyd0qULQkLUfET+xzKbvUTH6t1hCKDJM=;
  b=pK9+VxJe/BoWwYVM/ifxs49qV3AyKbQjgktF0c87EU476Z+U8ShZ6JTU
   XyQoHSg4TA8gLZLujv8oDOJbvsoF4oJzGQRarDWVhfJry30A/l261wh6B
   uRmx5oNVTkz9L7xwcmyYGL7/GJCvprVek6AIJfQrDMgLSo5LPs9kx6kFs
   5tYp+lSe7gIIi5rHScRG0lQ6GOvo5IhiO3Gxm8x6Us3MsWC9TjL77IERa
   ke9Ixs2COzlvcjlkB5O+tckRSeyMmGMh7TPXa7ns7oRErl+IAXPwTRLJY
   f53+BkVu4HFYmtAmTRXKBGHnaUHens9hbwRZaI/9nVXSmnDTHKbbmrARX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="54424580"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="54424580"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 15:53:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgKM1TMJeA0iYCljT3IOeT+pS3ohYvGV2TVts/BIoT0P109khwkMvAQ0HZWOu8kS3Mozz189hGuFB0bp5gEe6wDaS9ucKUCvHilaRxvHZk5754TD4z3KSQ1jJV6P5jEXo7r72RqEkSYy9wh9zlBzC3m7tYfEJLTeNEFJ7zVv+x9ReNua8ab06ewwo0LTgwbGgDC9RqsvwpXublJpU2pt15f4OLmtIAQ5nKJ3YmYDHl/Lb32ES+3Xr6SRHj9CAf6t4W0/t2TVrgqWHm2qYd9XUf1EeycHWqI0/0NEAdCc1ls1p5UGO1x6kIEckw05fIfoyoRDHFaAaTYGSTZ12SNN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCfBI0WwGSAYyd0qULQkLUfET+xzKbvUTH6t1hCKDJM=;
 b=VWgRs/a+XAdQLvdr7Kg+khVA1toFdW9w1EAvWy6XcewjWMDLFyVZcrjpEk7i7d9+DyCdiH6BGgdWUasPgfqgYBzbO+idR4MO9NZIsT3dBCkPxnK1jacKPTg6z4IJ/4bGVXh8TUO7gI93hDLy8ACmulLVUFzQGsoTilD8lDDzDPz60nfrZMxQ2tB9n1QrHZ2qsgLMvXYva11SA7ywedepHrhf0hcO3uQNPjmLSl6buVrKLy/q0816W3L6gHaWP/qjplrhsR33LgbDUIzCpNyIEIxgRhFbzMN0q5xlg24OmQLZZ6HxPkWni8uczhqE5tI9piOOhc+jxHlpZEDsugDl3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCfBI0WwGSAYyd0qULQkLUfET+xzKbvUTH6t1hCKDJM=;
 b=O9opbAB+tw02+1N/G45/ffISWblKz+sQJhv3sR0y0/3ks+FyGiUkzAQCjJPSbzmter39pWlmkHCXWqLWyYIBB5tzzobiM4phc4h2DL9Fe7IAew17IzRcm3dNpK1A5Yx5Z1HFDPAmP0EuxcFgr3hAXuGTHFyNcOvw3RVN89jGlvc=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB2436.jpnprd01.prod.outlook.com (2603:1096:603:3b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 06:53:10 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 06:53:10 +0000
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
Thread-Index: AQHYVUyPCCbG7abR4k+5ZAmuw7aI86z6AWEAgAGQaAA=
Date:   Fri, 22 Apr 2022 06:53:09 +0000
Message-ID: <62625F34.9030407@fujitsu.com>
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
x-ms-office365-filtering-correlation-id: 60b3d609-45ec-42c9-6cd8-08da242cc34f
x-ms-traffictypediagnostic: OSAPR01MB2436:EE_
x-microsoft-antispam-prvs: <OSAPR01MB2436C2CA20191EE53768D1CDFDF79@OSAPR01MB2436.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9zNPdbJvSwbtF2KUPqOI3E2J7/k9CEOVHmvjzehtdIAM3ffQLyFxVG86/LGRLbgHtgjgR0i4DOEKPAnEdu0LL6VywIMTFixFyPcYtXXOQwhnalMppip7+Ns2j1gc9RBHbI7LQ47CCWdjb4eDUjUJaQiniZzTQmlKXPHMq3g09GMstQGcszKdFlh/B55tIBFvO627l5FsaEmUH1M5nnSoMdUegJm1/4/5NXBnjFfByeEzft3Vp8UJyKtAB1/MbpHMZgVk1hDsj1hjLnsR4wu0ApIyGngYqkfTGeok6nj7QCqs0QTE7IjQrADd4hYSI2AXCHzz0fZIuwLw5nX4sHJHn4QZuKnZzAE5XcgGdHb3f2bTjIrX1v1Tv0DAOTxyA/YDNhB+IX4pF8P05ueVqSxr3DG0BdcNIufXRH72/5zS9wtYAPSgYlUXeNIyPN+UeewMrGAWFKRCM6ktWBzdephZgnHk0feIhjWRmW+5CIGKjqQTIx9AOqhRxsOcqgodxPNQ/KN3Ch59qqqhJxQwlwDRjJkX9Aw8IoYVJOm3TACUqu+eoXafU+DV1PBdufO5WU/JNQuAck66btzxHqjS4pFUTojzAEJlTuAEMsn10ggux1sGAH/06bWMII82l5AnN9j0bIdVDYupOOfvoppLtkzEshTMv7EtJJO9J1VUp0CGLx1PmPxLi2+lusNBq30NnzBS+EA/buXJm7ZcRnZPYt6veA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(8936002)(71200400001)(8676002)(64756008)(76116006)(91956017)(66946007)(86362001)(66556008)(66446008)(5660300002)(2906002)(82960400001)(54906003)(186003)(4326008)(83380400001)(85182001)(6916009)(38070700005)(6486002)(87266011)(316002)(26005)(508600001)(45080400002)(122000001)(6506007)(2616005)(36756003)(33656002)(6512007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0VSd0RvTTlxT0dGUmtSeTRXRFkxMmp4MURscURGTjh4dWRaNTliU1lVN0pv?=
 =?utf-8?B?NE9Ucy9mMTR4M2NQQ3ZuamRIbC9Ld3lMM3REbnMxTWRUNWMxRDZwRjhxOTdS?=
 =?utf-8?B?dUxicVdtMGFwODB3ZEo2YzJRU3djUkdHSlIxM3pJdFliU1RJNmluUWtnekZ5?=
 =?utf-8?B?bHpSMTlhYm5LQm1ZTHJyb21Rc0JBTlg1ZG1ubG4rWGpTaFRZNjFONEhuZlZJ?=
 =?utf-8?B?TStjMkdzR3F4YnJ6K2UzY0wwQzQwcGsxQmMrSnBJamdVOEFBbXlzdWdZaXYw?=
 =?utf-8?B?QkFjOGtYbldXNVNHV1pHU0t1N2p0WTBxOFYxTkZTa1hOclE5YmFjNXZFOE9I?=
 =?utf-8?B?MG1wZkJ5WTRqVWQxalhVSmRxdURzbDNhWjVMbDhNM2NSYTI0ZDViWWc1RlJq?=
 =?utf-8?B?cXFYZEgrSno1SmNRNnAzRXl5S29XaU11ZlAyQWtBTnhLUStDc05oM2p2eThQ?=
 =?utf-8?B?dkthcFh5MSs1YVVnQ2doNlJWMzdTK3dRSzNsTEJsSnMwV29YUm9ZWjloNEx0?=
 =?utf-8?B?VDFBTHVPcGVzdkZoRXppMWp4VXh0RURYcUl0Tmd4T0hkcXpuOFJBVWd6c2tl?=
 =?utf-8?B?aVh0OTlZRjNaVXFSZTIyV3dEZ0tUOHJWdlJ3aU9CazdXdk91NFBFT0d5bnBP?=
 =?utf-8?B?aFdjOWVlSEtHN2NXZUwrWkNOTmw2S2liYkVqQzJKaW9oNlY3ZmE3OENXVy95?=
 =?utf-8?B?MkEzRkRNVUQrbWJ1RC9aMXF2bm1Bb1Y4cStNTnpDVk02US84Nm92dFRBbFp3?=
 =?utf-8?B?ZjhsYm5YSGVMNFBUcEtaTnFmTlMwcW9kU2dTNExuYlhIM3BtOG43aTdYclp0?=
 =?utf-8?B?WkFBelF0ampLbDRheVVPeHJ1TTc5S0dXREtRRzVyUXRYWDNNamtaYVF6NTRR?=
 =?utf-8?B?UVpWaWU3YThvYXYyV2xlOGNqRGdCMFF5YVJPN05JMm5QdXlJMldaOTMyRUVl?=
 =?utf-8?B?MHByckZWQ0VOY2dUZ3dqbGt0QVdVMEtOUzBSSzJWcklhSlEwNkhGSUQrRnI5?=
 =?utf-8?B?NTNJK3ZoMk1rOU92cFhJTDZReWRLR3FYMlgydUlEbVYzSXJHK2F0R3hSNXpw?=
 =?utf-8?B?TXB0UEwrOXArSDVSNjg1TDRKWVNQM1lxTlVVTDI4VkU1eTJHOHIzaTcvYitC?=
 =?utf-8?B?RlVWY3J1RWRyMVZkeUZxOGY0NFViVkg0QURMVjRHUDV0WnFNMDFoQ2dTZkZT?=
 =?utf-8?B?ZFQ2cXZLUFoxc3Z6MXZoTVp6U1NnOW82V2p2TzEyb2kzZkxSK2V1dDM4eW9J?=
 =?utf-8?B?SG8yQ255bE8zSlQrS0haK3ZXUkVZSXpXRGFTYVhoQ0RrcGVGRlBkYkY2Q25h?=
 =?utf-8?B?blEwN0Vqem0yOXVXemI2K2kwbkM3NWVJdExMVGxuZHlCN2h2UEwxb0d4S2Iz?=
 =?utf-8?B?ZE5zbGJWL3ZBdXNRNmtKY0NZWjd1UGFDUVd3Sld1OWt2ODRKWFJHN1pwU3Jy?=
 =?utf-8?B?L0p6c1NvMjBpZGI4MkorVVVtQTA4UnBvejRHVHlmRFFWZFcrOWk1dTdzSWpp?=
 =?utf-8?B?bWM1aHltbnVCVE5NWHU3RkZUY1NjSXdMSmQvS2RNcXdBdmNhL3RjR1AzTG1W?=
 =?utf-8?B?Mm4zREx0cmpmelNoZkxIRXFJckFEMWY3WGI3VS82OWlxRzVWc3Brc0Z5bVdN?=
 =?utf-8?B?YUxpM3VGUzdMVlptQkp5bnJsUHpPNjlaUVhrZzJ0V1BHWmsyTm11Z0JXbERq?=
 =?utf-8?B?Ym80VW40R1Fsc3E1L0V6TGRtamhTMEpXekIzZUprVFBhbERob2VwNFpsMFBt?=
 =?utf-8?B?Y0ZMc2FCdFh3STN6OTd0cXlud3VFL0FOT2wxQVJWMURoZUxDWllaTnNLeDhl?=
 =?utf-8?B?NmRPMm9yeVg3Zk5TcnhhNTdObUI4NFlFdm9RTGJKRTlwSEZGaUF0cnBKT3ZI?=
 =?utf-8?B?alVsTnA3azZxMWVXTk9NWW0vRVRscmtWQjNUS3BSYzY0M0c5L1ZEeEgyVVR5?=
 =?utf-8?B?WGdLVWExNVVLY0pKUjlFNU1PbXZzRVl1TWVXTTdSeUI2SWwrNWNlSkM2VjhJ?=
 =?utf-8?B?NlZkeHBnRTJKa1Zva05jc21YRWswbnREbEM3bDFHdkMwUDZKWnd1STNYTkZw?=
 =?utf-8?B?eXJYUENrRUsvOXpodWlHM0prY0dFdjZYR3U5STdBM3dxWmVkS2g4d3p3U0hV?=
 =?utf-8?B?MG9yS3puQnBaQXdqbzZBN2lRbHNnMWNrTlFBVXJ0M0tHdHE0WXFPdmEwZzFX?=
 =?utf-8?B?T2ZtYndoNUtoY3I1NnFGSWRNTFBtOXRnNlh0N3J5by9TNzJPOGRJeXRpb1VK?=
 =?utf-8?B?eXlSM011eTUvcitCZTgyUjZXbjU3eit5N25PcXpCbEFkZXlVUGdHMXpmQkgw?=
 =?utf-8?B?YVlKenZaTUdJZ1dqb0tZMDhWcnBiQUF3VjZQWTJnYUh2T0M1dHZzbXlONEh1?=
 =?utf-8?Q?eFUijOM+/rYUfeMvlQDMYWoUdEsk32iibtJSf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0347B4A90F7A04798B78CCB76733356@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b3d609-45ec-42c9-6cd8-08da242cc34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 06:53:09.9644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CiZFjI2qHhndJ7aesnG7+npF4BJaPUT7WHDmkUQGMfcDWVx24JBhTHQ8OIyNKUdd5743Df/d95X7C2cyHi/WMoAZ4mjpYIiYxI1nyXAKL8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2436
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

5LqOIDIwMjIvNC8yMSAxNjowMSwgQ2hyaXN0aWFuIEJyYXVuZXIg5YaZ6YGTOg0KPiBPbiBUaHUs
IEFwciAyMSwgMjAyMiBhdCAwMzo1NDoxNVBNICswODAwLCBZYW5nIFh1IHdyb3RlOg0KPj4gVGhp
cyBoYXMgbm8gZnVuY3Rpb25hbCBjaGFuZ2UuIEp1c3QgY3JlYXRlIGFuZCBleHBvcnQgaW5vZGVf
c2dpZF9zdHJpcA0KPj4gYXBpIGZvciB0aGUgc3Vic2VxdWVudCBwYXRjaC4gVGhpcyBmdW5jdGlv
biBpcyB1c2VkIHRvIHN0cmlwIGlub2RlJ3MNCj4+IFNfSVNHSUQgbW9kZSB3aGVuIGluaXQgYSBu
ZXcgaW5vZGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdTx4dXlhbmcyMDE4Lmp5QGZ1
aml0c3UuY29tPg0KPj4gLS0tDQo+DQo+IENvdWxkIHlvdSBwbGVhc2UgYWRkIHRoZSBrZXJuZWwg
ZG9jIEkgc2tldGNoZWQgYmVsb3cgdG8gdGhlIG5ldyBoZWxwZXI/DQo+DQo+IExvb2tzIGdvb2Qg
dG8gbWUsDQo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gQnJhdW5lciAoTWljcm9zb2Z0KTxicmF1
bmVyQGtlcm5lbC5vcmc+DQo+DQo+PiB2NC12NToNCj4+IHVzZSB1bW9kZV90IHJldHVybiB2YWx1
ZSBpbnN0ZWFkIG9mIG1vZGUgcG9pbnRlcg0KPj4gICBmcy9pbm9kZS5jICAgICAgICAgfCAyMyAr
KysrKysrKysrKysrKysrKysrLS0tLQ0KPj4gICBpbmNsdWRlL2xpbnV4L2ZzLmggfCAgMiArKw0K
Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2ZzL2lub2RlLmMgYi9mcy9pbm9kZS5jDQo+PiBpbmRleCA5ZDli
NDIyNTA0ZDEuLjU3MTMwZTRlZjhiNCAxMDA2NDQNCj4+IC0tLSBhL2ZzL2lub2RlLmMNCj4+ICsr
KyBiL2ZzL2lub2RlLmMNCj4+IEBAIC0yMjQ2LDEwICsyMjQ2LDggQEAgdm9pZCBpbm9kZV9pbml0
X293bmVyKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0IGlub2RlICpp
bm9kZSwNCj4+ICAgCQkvKiBEaXJlY3RvcmllcyBhcmUgc3BlY2lhbCwgYW5kIGFsd2F5cyBpbmhl
cml0IFNfSVNHSUQgKi8NCj4+ICAgCQlpZiAoU19JU0RJUihtb2RlKSkNCj4+ICAgCQkJbW9kZSB8
PSBTX0lTR0lEOw0KPj4gLQkJZWxzZSBpZiAoKG1vZGUmICAoU19JU0dJRCB8IFNfSVhHUlApKSA9
PSAoU19JU0dJRCB8IFNfSVhHUlApJiYNCj4+IC0JCQkgIWluX2dyb3VwX3AoaV9naWRfaW50b19t
bnQobW50X3VzZXJucywgZGlyKSkmJg0KPj4gLQkJCSAhY2FwYWJsZV93cnRfaW5vZGVfdWlkZ2lk
KG1udF91c2VybnMsIGRpciwgQ0FQX0ZTRVRJRCkpDQo+PiAtCQkJbW9kZSY9IH5TX0lTR0lEOw0K
Pj4gKwkJZWxzZQ0KPj4gKwkJCW1vZGUgPSBpbm9kZV9zZ2lkX3N0cmlwKG1udF91c2VybnMsIGRp
ciwgbW9kZSk7DQo+PiAgIAl9IGVsc2UNCj4+ICAgCQlpbm9kZV9mc2dpZF9zZXQoaW5vZGUsIG1u
dF91c2VybnMpOw0KPj4gICAJaW5vZGUtPmlfbW9kZSA9IG1vZGU7DQo+PiBAQCAtMjQwNSwzICsy
NDAzLDIwIEBAIHN0cnVjdCB0aW1lc3BlYzY0IGN1cnJlbnRfdGltZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlKQ0KPj4gICAJcmV0dXJuIHRpbWVzdGFtcF90cnVuY2F0ZShub3csIGlub2RlKTsNCj4+ICAg
fQ0KPj4gICBFWFBPUlRfU1lNQk9MKGN1cnJlbnRfdGltZSk7DQo+PiArDQo+DQo+IC8qKg0KPiAg
ICogaW5vZGVfc2dpZF9zdHJpcCAtIGhhbmRsZSB0aGUgc2dpZCBiaXQgZm9yIG5vbi1kaXJlY3Rv
cmllcw0KPiAgICogQG1udF91c2VybnM6CWlkbWFwcGluZyBvZiB0aGUgbW91bnQNCk1heWJlIHJl
cGxhY2UgaXQgd2l0aA0KIkBtbnRfdXNlcm5z77yaIFVzZXIgbmFtZXNwYWNlIG9mIHRoZSBtb3Vu
dCB0aGUgaW5vZGUgd2FzIGNyZWF0ZWQgZnJvbSI/DQo+ICAgKiBAZGlyOiBwYXJlbnQgZGlyZWN0
b3J5DQpwYXJlbnQgZGlyZWN0b3J5IGlub2RlDQo+ICAgKiBAbW9kZTogbW9kZSBvZiB0aGUgZmls
ZSB0byBiZSBjcmVhdGVkIGluIEBkaXINCj4gICAqDQo+ICAgKiBJZiB0aGUgQG1vZGUgb2YgdGhl
IG5ldyBmaWxlIGhhcyBib3RoIHRoZSBTX0lTR0lEIGFuZCBTX0lYR1JQIGJpdA0KPiAgICogcmFp
c2VkIGFuZCBAZGlyIGhhcyB0aGUgU19JU0dJRCBiaXQgcmFpc2VkIGVuc3VyZSB0aGF0IHRoZSBj
YWxsZXIgaXMNCj4gICAqIGVpdGhlciBpbiB0aGUgZ3JvdXAgb2YgdGhlIHBhcmVudCBkaXJlY3Rv
cnkgb3IgdGhleSBoYXZlIENBUF9GU0VUSUQNCj4gICAqIGluIHRoZWlyIHVzZXIgbmFtZXNwYWNl
IGFuZCBhcmUgcHJpdmlsZWdlZCBvdmVyIHRoZSBwYXJlbnQgZGlyZWN0b3J5Lg0KPiAgICogSW4g
YWxsIG90aGVyIGNhc2VzLCBzdHJpcCB0aGUgU19JU0dJRCBiaXQgZnJvbSBAbW9kZS4NCj4gICAq
DQo+ICAgKiBSZXR1cm46IHRoZSBuZXcgbW9kZSB0byB1c2UgZm9yIHRoZSBmaWxlDQo+ICAgKi8N
Cj4+ICt1bW9kZV90IGlub2RlX3NnaWRfc3RyaXAoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRf
dXNlcm5zLA0KPj4gKwkJCSBjb25zdCBzdHJ1Y3QgaW5vZGUgKmRpciwgdW1vZGVfdCBtb2RlKQ0K
Pj4gK3sNCj4+ICsJaWYgKFNfSVNESVIobW9kZSkgfHwgIWRpciB8fCAhKGRpci0+aV9tb2RlJiAg
U19JU0dJRCkpDQo+PiArCQlyZXR1cm4gbW9kZTsNCj4+ICsJaWYgKChtb2RlJiAgKFNfSVNHSUQg
fCBTX0lYR1JQKSkgIT0gKFNfSVNHSUQgfCBTX0lYR1JQKSkNCj4+ICsJCXJldHVybiBtb2RlOw0K
Pj4gKwlpZiAoaW5fZ3JvdXBfcChpX2dpZF9pbnRvX21udChtbnRfdXNlcm5zLCBkaXIpKSkNCj4+
ICsJCXJldHVybiBtb2RlOw0KPj4gKwlpZiAoY2FwYWJsZV93cnRfaW5vZGVfdWlkZ2lkKG1udF91
c2VybnMsIGRpciwgQ0FQX0ZTRVRJRCkpDQo+PiArCQlyZXR1cm4gbW9kZTsNCj4+ICsNCj4+ICsJ
bW9kZSY9IH5TX0lTR0lEOw0KPj4gKwlyZXR1cm4gbW9kZTsNCj4+ICt9DQo+PiArRVhQT1JUX1NZ
TUJPTChpbm9kZV9zZ2lkX3N0cmlwKTsNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Zz
LmggYi9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4+IGluZGV4IGJiZGU5NTM4N2EyMy4uNTMyZGU3NmM5
YjkxIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9mcy5oDQo+PiArKysgYi9pbmNsdWRl
L2xpbnV4L2ZzLmgNCj4+IEBAIC0xODk3LDYgKzE4OTcsOCBAQCBleHRlcm4gbG9uZyBjb21wYXRf
cHRyX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLA0KPj4gICB2b2lk
IGlub2RlX2luaXRfb3duZXIoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1
Y3QgaW5vZGUgKmlub2RlLA0KPj4gICAJCSAgICAgIGNvbnN0IHN0cnVjdCBpbm9kZSAqZGlyLCB1
bW9kZV90IG1vZGUpOw0KPj4gICBleHRlcm4gYm9vbCBtYXlfb3Blbl9kZXYoY29uc3Qgc3RydWN0
IHBhdGggKnBhdGgpOw0KPj4gK3Vtb2RlX3QgaW5vZGVfc2dpZF9zdHJpcChzdHJ1Y3QgdXNlcl9u
YW1lc3BhY2UgKm1udF91c2VybnMsDQo+PiArCQkJIGNvbnN0IHN0cnVjdCBpbm9kZSAqZGlyLCB1
bW9kZV90IG1vZGUpOw0KPj4NCj4+ICAgLyoNCj4+ICAgICogVGhpcyBpcyB0aGUgImZpbGxkaXIi
IGZ1bmN0aW9uIHR5cGUsIHVzZWQgYnkgcmVhZGRpcigpIHRvIGxldA0KPj4gLS0NCj4+IDIuMjcu
MA0KPj4NCg==
