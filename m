Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FDD4CC11C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 16:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiCCPXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 10:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiCCPXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:23:43 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5602C191439;
        Thu,  3 Mar 2022 07:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646320978; x=1677856978;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TbiaQEeMJW5NLeqiP2VCY4kw6ONoS/mP4Ec6/YTxxLk=;
  b=jT2a+A+0F0dLOWBJKNsLab6UY7MjpfEtRtG3GI1n5mq4JmedLnxZTM04
   zaGFcsf386ifNy+FR2WrwKqeTjk7/UzGE7ofxLYN77D19WzZPdd13dGF5
   rNn7RQgImBmjuUjAGiGwzUDy3CPNRoLcFBzkrurPmGDQ2dIgWDYcjNWMX
   zyb/2/WgB90C9JF8P0CxhWjdDXbFx/d6tYC5kRFzEpU3Q8GAZZI9gEnSp
   xprqjmTw+koXf8fdzV6NS6x4yKF0s3Iz0RmwhwqaqRtobSX9PM/hdrlVg
   AjsxaetAPiCrGWVPBD81A7x9mIKQyXn6T129U33vxRGhyb+/1Q8np8WJs
   g==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="195359573"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2022 23:22:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8qbdeTJQAimMdC3edNA2NJguQtIcNULTjm206qSHiONCpRS8CWJVTmSOa49xzvBOJ3fDm7zK3nnY6YtLtqsUR6ULL1BnleSJrC2RaLmveGV0yoOpnP5L83wxLvzdScW6hBLBzYfEtim1oULjtw+mMfw7Eb7vf5QH96jgZkRJvDTvtJnrl0Yy82uQz+CYB9CjscnaVhNRVjCJ8RF2s5nmZBNXabjRerGv0rC1phCpC1eHAMTEy6LEzr/ExgHbyKBgQzvXS1W0pDzYj9RNROmmOhxE9YrnB7PDtTw7VwGByZJBoDHSYUQsxFmOWnBKXxvx6+70VxDvVPMzQ3N7Nj9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbiaQEeMJW5NLeqiP2VCY4kw6ONoS/mP4Ec6/YTxxLk=;
 b=YjjwsXlT5XGv6PFm3jfO4asF4deP5/r1cSkvcoXPNGYy9Rfrul6Ifr/nqLCU/aZP32ptDzzArH0tCvpZP27yO8ctnvPywFbaUHYeWPrIFuIjeKFr4LcNQddecY7/eii9OwqAmvFzWQlSphHqxk8z4Ziylq/Fx1USJO0bnB1ZKc/NRqekFrVJUXZdtGXrdXGU69ELOleRkFSqojY3/Rne/f49+VwVBUCceXNTO+97GcNHNziInMhBaWXv+Q7Rz+kundKZw5FMTiLPyHkkgQPaxacXj9B0vvGwF3jyoW+UO+WFMHg03fRsfJjYJ7bztW/opu2Hdrviw1RRjOow4YccnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbiaQEeMJW5NLeqiP2VCY4kw6ONoS/mP4Ec6/YTxxLk=;
 b=sTwBJ+2mqXaF6FCIdeBvcRMEl4xxfHgl2zNo40CTrL5CabVDOAuI5mucFMZtW+7/aFrXzODrqz6sngekUpOp9DCwldFQINEPZhfH9ixXziJoCjA4MvxpbNCY5h44Om20N65htn4e3/HaiUWYASH3NcrZM8pszcH4fXMSMTc31sc=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by BN3PR04MB2162.namprd04.prod.outlook.com (2a01:111:e400:7bbe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 15:22:52 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::c8f4:8499:a5fc:1835]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::c8f4:8499:a5fc:1835%3]) with mapi id 15.20.5038.016; Thu, 3 Mar 2022
 15:22:52 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Adam Manzanares <a.manzanares@samsung.com>
CC:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmd1Ny4qtE3bUeyZ6TIm7TKKqytIu+AgAAQCQCAADergIAAVbwAgAAHhYA=
Date:   Thu, 3 Mar 2022 15:22:52 +0000
Message-ID: <4526a529-4faa-388a-a873-3dfe92b0279b@wdc.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
 <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
 <CGME20220303094915uscas1p20491e1e17088cfe8acda899a77dce98b@uscas1p2.samsung.com>
 <8386a6b9-3f06-0963-a132-5562b9c93283@wdc.com>
 <20220303145551.GA7057@bgt-140510-bm01>
In-Reply-To: <20220303145551.GA7057@bgt-140510-bm01>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e00614a6-7544-42f1-d103-08d9fd29af43
x-ms-traffictypediagnostic: BN3PR04MB2162:EE_
x-microsoft-antispam-prvs: <BN3PR04MB2162E4813682EE163CEFD37CE7049@BN3PR04MB2162.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmghCFyRDCJttQ/nnYnc71FfZiBzxEkVmP+KpObEOWrK/q2xNcThwV3rVxQZU6BbQAWRVQ23NzysqTDPqOoTKhNoW2jArpjLFMnph/67fjbAulezzwgv6i0g8QksMPfLO3CfJHVTdGyItHZZ+9y8R0tPUHPUstSOOdM9WznPdfpdWsXsCCIdIWWQIviNKg5Hy1mK18bJSCoIuI7LaL0un7I6HG1xCh7qVMMMTYbXJJIAa2GasFSVDGH3py+y0KIF/z/knTkK2vejDwTtW2k9ReEA292UkQ4lqKsoH2cSSDrsSD9EdReggnYQqgWjlMXkp1XViSVc9+f75hUkkhkWqcTsn40JoyTWZDNnP3Qt9M58x07jEa00pSW23432RM/RdyPsrd6MG2k3ilHtCBRqJDt5E7GL1AmmHCEz8eaOsrymNt8A/TN2xe2Zy40G/pOi8zcMegnYxOnlJHAYZggSqkLGIBAIs5bPBUX84Q1AMYfAwvvvorZfRlRsNxksM0WKzA9B5+lmvGbd1UvVOdF6dxouIXrfCoxUnvkq3Z64ptBT71Rb77oOw404gbDfgZMfvEFjM46R6ZUvnt4iPTHkvyNHgjFPykU8ELDepTbummI9jHIhOQkUTRvomCZ+ch47d8yKrHMJQ7xxVNzU1XSqNgHRUksId0Uy/ngLJ4bBMNFDWlunExSzxQH6NWfQ2bKLJ61SCJUrBS2LsU0QngGFm3KghD+LPOMD3ldfzoYDRj/3DzWlbpEbGZdQu424/E96Rl3ShAbfVYBAEV35xM4FDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8676002)(31696002)(38100700002)(6512007)(53546011)(316002)(86362001)(54906003)(6916009)(91956017)(6506007)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(71200400001)(6486002)(38070700005)(4326008)(7416002)(5660300002)(82960400001)(508600001)(8936002)(83380400001)(26005)(122000001)(186003)(66574015)(2616005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnoxRXQwbytmcTR4TkJKbVRSOFFteVFDQWdiQllUSWFMbXFkRHRaZktaOGhm?=
 =?utf-8?B?aWl1MUxPaHBkNmw4Um9ablZwblYrVnFQdTdTNTAyMkJiUy9mcGRuL0UyV0hK?=
 =?utf-8?B?VVZxQlBnSHc0ajNURUdkeDJTY1grMDdIVjFIbXczWGtGelN2OThmMXZoeWhL?=
 =?utf-8?B?aDhVaFFEaE4rOEpxbEFpQzZQdTN2eHRQZnpLUGl2aUFtaHc4b203UElRTWw1?=
 =?utf-8?B?OWVIaVdsaHpyMzJWNDEvODJLdng5cXRrSEFHenRObUw0MEk5M0lKSlo5RFU4?=
 =?utf-8?B?dDVaS1BZSUhsdGd2NTBqNkI5c3plRzR3eU9qVkM3bkMyWVNjeC9QTlpsS05a?=
 =?utf-8?B?U1Zja0s3MVA4dVZURExvUW5OTTgvOWdaRXRIR0l0Mlo4QmdFdk9KcDVEWG85?=
 =?utf-8?B?TjNrU2Z0cVNycGhPb0FWZzVRVUt6cXVlaWM0MklieVFwQ2hlT0VrVUhaVENj?=
 =?utf-8?B?MnU1Wm5PV3Yyc1RhamFLSTFyakVWVzloRFhIeVVISkFVODQwZkJKNnVQT3Ni?=
 =?utf-8?B?MktuS2hmNlJDMHJJcEFZZnkwdzVoOTlJNi9adU5MSWVhUmV5bWR0c0V6U2wy?=
 =?utf-8?B?TjVSUFFTTFhrWDhPYndpUmExQjhGS1o4aEx4VDJVbjdQS3hpV0hOeVJJWUs4?=
 =?utf-8?B?Q1lxSVE2UnN3NE9rcVpHa2VRK3cwMW5yVU5TYi8xM2NyNVNZRmowNEhINGYy?=
 =?utf-8?B?THBQOUFZM1NkWUtSdFpseWhHWlRlbDlQRVlQb3FaMENQaEthZTIwTVEzUUVW?=
 =?utf-8?B?OFQxbCtBS2h4NGtvMjF0VTFYT216bDVUQWd3WHErOUErYkQ3bGhNUWQwM3BP?=
 =?utf-8?B?OFFnREJ5cE90dklFT3pVUUt0RFd1elZRRnNmTUd4WGNCaE5yUkdueTVVU3Vo?=
 =?utf-8?B?Wnd2S1NMYTFLd1ZjUFVmUVVaZHA0NXIydHY5RUZRSzhycFlEbVZ1YW0veVdN?=
 =?utf-8?B?SUZ4WkhxWE50THpVR0UrR0VzSUJvUDZ5ajdCd1o0U04yU3JPM2RYb2pHTEx0?=
 =?utf-8?B?OW9yblplSE5ja2M3cFU4KzAxMUMzY1o4STVuUGtzc3hKTFJ1UE41WTRZTXhQ?=
 =?utf-8?B?Y1M2c1M0NUhmUC9HN0pBcExES3RVVnYybU1hRDUwTEZ5RDgwVUE3OUNxQVE5?=
 =?utf-8?B?NGhnNG5ZeTU3TzhvNlFLNFVxSXlDSExRRjA5UVo4TmI3SThYR2VBRzJqRGdy?=
 =?utf-8?B?bkJHTno5bWRUblBzSEI5M3FhRWhMRldnVU8wdXBKbzdSZWgrRmZPMDFETWFN?=
 =?utf-8?B?MTNqS05QWjB3ODVmRFdydjE3VW13empXdTlFYW4yZ0ZxOFdiS1A2RURJRk5x?=
 =?utf-8?B?ZysxN0FmaG80aE5CeGhtOWxQQzZLUjE5R0d3cEdydWV6NE1KQUR5b05odEVS?=
 =?utf-8?B?OTFHZGdOT2h1RXdDd0poNkRROFNRS2c5SnFNUWdqay81eG5yL2JSTlZoOVlt?=
 =?utf-8?B?bW4yaVRjZmZGbEphb0d3cHBuZlRsWE9MS1QrekpwY2xaUVB1NW43Z3Bsblds?=
 =?utf-8?B?SEFGSGZvTlZoamszdHpPdm9ISlhSaGt3MDlXZ2EvRHRYU2NEZHgyU0hyYjZE?=
 =?utf-8?B?YW5ON05hUVBKZXZxdG5WdnF4bXVYS2s0c3dFWkhDWEJqZTNPaEpCZ1VYRnRa?=
 =?utf-8?B?Z0dEcHZUTW9PU3U2QjEwTHljcUFUdG9BZFZLSllkWVRZRW5qcTZEV3FjdGFM?=
 =?utf-8?B?eXRrVWZveVN0MTFkSm1va0J5ZVRtVk5BQVE5VFkvMkw2QlpDSzVJS09BV0w0?=
 =?utf-8?B?N1dmRlU0b0EzWlVnM3hwT3ZzZWxDTFBZRlFJR2wzcnRyRmlPVE9ScWpHSDZL?=
 =?utf-8?B?RW9wNE9HUitWRUZuMTlhWExEYzd3QjJVbzBYY1FYNXR4R0l1YVQycmF6bFpP?=
 =?utf-8?B?bHd1d2JTWW40dnJIdnVub1JHMTRUdDVDNDBRTkhHczQ1akFZVzRHaGh1RSs4?=
 =?utf-8?B?S296by9udUtyem04R04wTnVsOHBLZUVvaFdYWi9jSGlZRDBzN2tFbXNFbTBj?=
 =?utf-8?B?RHEwWUxva0RJcTFXYXJQa2tQTHVwM0s3R1FwbFlCcUYwMG5zZU45MVRSOFNv?=
 =?utf-8?B?ZjdIYStwVFNsK2NWSWpPZFAzbk1KcEUzaU56a21hUzN2TGhDcXZxc1VsZHhZ?=
 =?utf-8?B?YmxsNlZEM2d6c3dZL3l4RlZYYUY1eEkxRDBBMC9oTFdwVTU2OUJHYy8rWXkx?=
 =?utf-8?Q?JNdOm/OXax2nW9VJE288iaSXkeOshrqKmRq/zHHHVm1o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1838EB461038A249A92A2C096FBCBB6A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00614a6-7544-42f1-d103-08d9fd29af43
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 15:22:52.3861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /amLRFuEKWN9gQbBfV/IFQU0n90pRQgmQIWViABF1Nq2/vXxJtOvYpaP1cen4zSyMxnt5gtQlsXqUWFbr4p/Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2162
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjAyMi8wMy8wMyAxNjo1NSwgQWRhbSBNYW56YW5hcmVzIHdyb3RlOg0KPiBPbiBUaHUsIE1h
ciAwMywgMjAyMiBhdCAwOTo0OTowNkFNICswMDAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4+
IE9uIDIwMjIvMDMvMDMgODoyOSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToNCj4+PiBPbiAwMy4w
My4yMDIyIDA2OjMyLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOg0KPj4+Pg0KPj4+Pj4gT24gMyBN
YXIgMjAyMiwgYXQgMDQuMjQsIEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3JvZkBrZXJuZWwub3JnPiB3
cm90ZToNCj4+Pj4+DQo+Pj4+PiDvu79UaGlua2luZyBwcm9hY3RpdmVseSBhYm91dCBMU0ZNTSwg
cmVnYXJkaW5nIGp1c3QgWm9uZSBzdG9yYWdlLi4NCj4+Pj4+DQo+Pj4+PiBJJ2QgbGlrZSB0byBw
cm9wb3NlIGEgQm9GIGZvciBab25lZCBTdG9yYWdlLiBUaGUgcG9pbnQgb2YgaXQgaXMNCj4+Pj4+
IHRvIGFkZHJlc3MgdGhlIGV4aXN0aW5nIHBvaW50IHBvaW50cyB3ZSBoYXZlIGFuZCB0YWtlIGFk
dmFudGFnZSBvZg0KPj4+Pj4gaGF2aW5nIGZvbGtzIGluIHRoZSByb29tIHdlIGNhbiBsaWtlbHkg
c2V0dGxlIG9uIHRoaW5ncyBmYXN0ZXIgd2hpY2gNCj4+Pj4+IG90aGVyd2lzZSB3b3VsZCB0YWtl
IHllYXJzLg0KPj4+Pj4NCj4+Pj4+IEknbGwgdGhyb3cgYXQgbGVhc3Qgb25lIHRvcGljIG91dDoN
Cj4+Pj4+DQo+Pj4+PiAgKiBSYXcgYWNjZXNzIGZvciB6b25lIGFwcGVuZCBmb3IgbWljcm9iZW5j
aG1hcmtzOg0KPj4+Pj4gICAgICAtIGFyZSB3ZSByZWFsbHkgaGFwcHkgd2l0aCB0aGUgc3RhdHVz
IHF1bz8NCj4+Pj4+ICAgIC0gaWYgbm90IHdoYXQgb3V0bGV0cyBkbyB3ZSBoYXZlPw0KPj4+Pj4N
Cj4+Pj4+IEkgdGhpbmsgdGhlIG52bWUgcGFzc3Rocm9naCBzdHVmZiBkZXNlcnZlcyBpdCdzIG93
biBzaGFyZWQNCj4+Pj4+IGRpc2N1c3Npb24gdGhvdWdoIGFuZCBzaG91bGQgbm90IG1ha2UgaXQg
cGFydCBvZiB0aGUgQm9GLg0KPj4+Pj4NCj4+Pj4+ICBMdWlzDQo+Pj4+DQo+Pj4+IFRoYW5rcyBm
b3IgcHJvcG9zaW5nIHRoaXMsIEx1aXMuDQo+Pj4+DQo+Pj4+IEnigJlkIGxpa2UgdG8gam9pbiB0
aGlzIGRpc2N1c3Npb24gdG9vLg0KPj4+Pg0KPj4+PiBUaGFua3MsDQo+Pj4+IEphdmllcg0KPj4+
DQo+Pj4gTGV0IG1lIGV4cGFuZCBhIGJpdCBvbiB0aGlzLiBUaGVyZSBpcyBvbmUgdG9waWMgdGhh
dCBJIHdvdWxkIGxpa2UgdG8NCj4+PiBjb3ZlciBpbiB0aGlzIHNlc3Npb246DQo+Pj4NCj4+PiAg
ICAtIFBPMiB6b25lIHNpemVzDQo+Pj4gICAgICAgIEluIHRoZSBwYXN0IHdlZWtzIHdlIGhhdmUg
YmVlbiB0YWxraW5nIHRvIERhbWllbiBhbmQgTWF0aWFzIGFyb3VuZA0KPj4+ICAgICAgICB0aGUg
Y29uc3RyYWludCB0aGF0IHdlIGN1cnJlbnRseSBoYXZlIGZvciBQTzIgem9uZSBzaXplcy4gV2hp
bGUNCj4+PiAgICAgICAgdGhpcyBoYXMgbm90IGJlZW4gYW4gaXNzdWUgZm9yIFNNUiBIRERzLCB0
aGUgZ2FwIHRoYXQgWk5TDQo+Pj4gICAgICAgIGludHJvZHVjZXMgYmV0d2VlbiB6b25lIGNhcGFj
aXR5IGFuZCB6b25lIHNpemUgY2F1c2VzIGhvbGVzIGluIHRoZQ0KPj4+ICAgICAgICBhZGRyZXNz
IHNwYWNlLiBUaGlzIHVubWFwcGVkIExCQSBzcGFjZSBoYXMgYmVlbiB0aGUgdG9waWMgb2YNCj4+
PiAgICAgICAgZGlzY3Vzc2lvbiB3aXRoIHNldmVyYWwgWk5TIGFkb3B0ZXJzLg0KPj4+DQo+Pj4g
ICAgICAgIE9uZSBvZiB0aGUgdGhpbmdzIHRvIG5vdGUgaGVyZSBpcyB0aGF0IGV2ZW4gaWYgdGhl
IHpvbmUgc2l6ZSBpcyBhDQo+Pj4gICAgICAgIFBPMiwgdGhlIHpvbmUgY2FwYWNpdHkgaXMgdHlw
aWNhbGx5IG5vdC4gVGhpcyBtZWFucyB0aGF0IGV2ZW4gd2hlbg0KPj4+ICAgICAgICB3ZSBjYW4g
dXNlIHNoaWZ0cyB0byBtb3ZlIGFyb3VuZCB6b25lcywgdGhlIGFjdHVhbCBkYXRhIHBsYWNlbWVu
dA0KPj4+ICAgICAgICBhbGdvcml0aG1zIG5lZWQgdG8gZGVhbCB3aXRoIGFyYml0cmFyeSBzaXpl
cy4gU28gYXQgdGhlIGVuZCBvZiB0aGUNCj4+PiAgICAgICAgZGF5IGFwcGxpY2F0aW9ucyB0aGF0
IHVzZSBhIGNvbnRpZ3VvdXMgYWRkcmVzcyBzcGFjZSAtIGxpa2UgaW4gYQ0KPj4+ICAgICAgICBj
b252ZW50aW9uYWwgYmxvY2sgZGV2aWNlIC0sIHdpbGwgaGF2ZSB0byBkZWFsIHdpdGggdGhpcy4N
Cj4+DQo+PiAidGhlIGFjdHVhbCBkYXRhIHBsYWNlbWVudCBhbGdvcml0aG1zIG5lZWQgdG8gZGVh
bCB3aXRoIGFyYml0cmFyeSBzaXplcyINCj4+DQo+PiA/Pz8NCj4+DQo+PiBObyBpdCBkb2VzIG5v
dC4gV2l0aCB6b25lIGNhcCA8IHpvbmUgc2l6ZSwgdGhlIGFtb3VudCBvZiBzZWN0b3JzIHRoYXQg
Y2FuIGJlDQo+PiB1c2VkIHdpdGhpbiBhIHpvbmUgbWF5IGJlIHNtYWxsZXIgdGhhbiB0aGUgem9u
ZSBzaXplLCBidXQ6DQo+PiAxKSBXcml0ZXMgc3RpbGwgbXVzdCBiZSBpc3N1ZWQgYXQgdGhlIFdQ
IGxvY2F0aW9uIHNvIGNob29zaW5nIGEgem9uZSBmb3Igd3JpdGluZw0KPj4gZGF0YSBoYXMgdGhl
IHNhbWUgY29uc3RyYWludCByZWdhcmRsZXNzIG9mIHRoZSB6b25lIGNhcGFjaXR5OiBEbyBJIGhh
dmUgZW5vdWdoDQo+PiB1c2FibGUgc2VjdG9ycyBsZWZ0IGluIHRoZSB6b25lID8NCj4gDQo+IEFy
ZSB5b3Ugc2F5aW5nIGhvbGVzIGFyZSBpcnJlbGV2YW50IGJlY2F1c2UgYW4gYXBwbGljYXRpb24g
aGFzIHRvIGtub3cgdGhlIA0KPiBzdGF0dXMgb2YgYSB6b25lIGJ5IHF1ZXJ5aW5nIHRoZSBkZXZp
Y2UgZm9yIHRoZSB6b25lIHN0YXR1cyBiZWZvcmUgdXNpbmcgYSB6b25lDQo+IGFuZCBhdCB0aGF0
IHBvaW50IGl0IHNob3VsZCBrbm93IGEgc3RhcnQgTEJBPyBJIHNlZSB5b3VyIHBvaW50IGhlcmUg
YnV0IHdlIGhhdmUNCj4gdG8gYXNzdW1lIHRoaW5ncyB0byBhcnJpdmUgYXQgdGhpcyBjb25jbHVz
aW9uLg0KDQpPZiBjb3Vyc2UgaG9sZXMgYXJlIHJlbGV2YW50LiBCdXQgdGhlaXIgcHJlc2VuY2Ug
ZG9lcyBub3QgY29tcGxpY2F0ZSBhbnl0aGluZw0KYmVjYXVzZSB0aGUgYmFzaWMgbWFuYWdlbWVu
dCBvZiB6b25lcyBhbHJlYWR5IGhhcyB0byBkZWFsIHdpdGggMiBzZWN0b3IgcmFuZ2VzDQppbiBh
bnkgem9uZTogc2VjdG9ycyB0aGF0IGhhdmUgYWxyZWFkeSBiZWVuIHdyaXR0ZW4gYW5kIHRoZSBv
bmUgdGhhdCBoYXZlIG5vdC4NClRoZSAiaG9sZSIgZm9yIHpvbmUgY2FwYWNpdHkgIT0gem9uZSBz
aXplIGNhc2UgaXMgc2ltcGx5IGFub3RoZXIgcmFuZ2UgdG8gYmUNCmlnbm9yZWQuDQoNCkFuZCB0
aGUgb25seSB0aGluZyBJIGFtIGFzc3VtaW5nIGhlcmUgaXMgdGhhdCB0aGUgc29mdHdhcmUgaGFz
IGEgZGVjZW50IGRlc2lnbiwNCnRoYXQgaXMsIGl0IGlzIGluZGVlZCB6b25lIGF3YXJlIGFuZCBt
YW5hZ2VzIHpvbmVzICh0aGVpciBzdGF0ZSBhbmQgd3ANCnBvc2l0aW9uKS4gVGhhdCBkb2VzIG5v
dCBtZWFuIHRoYXQgb25lIG5lZWRzIHRvIGRvIGEgcmVwb3J0IHpvbmVzIGJlZm9yZSBldmVyeQ0K
SU8gKHdlbGwsIGR1bWIgYXBwbGljYXRpb24gY2FuIGRvIHRoYXQgaWYgdGhleSB3YW50KS4gWm9u
ZSBtYW5hZ2VtZW50IGlzDQppbml0aWFsaXplZCB1c2luZyBhIHJlcG9ydCB6b25lIGNvbW1hbmQg
aW5mb3JtYXRpb24gYnV0IGNhbiBiZSB0aGVuIGJlIGNhY2hlZCBvbg0KdGhlIGhvc3QgZHJhbSBp
biBhbnkgZm9ybSBzdWl0YWJsZSBmb3IgdGhlIGFwcGxpY2F0aW9uLg0KDQo+IA0KPiBMZXQncyB0
aGluayBvZiBhbm90aGVyIHNjZW5hcmlvIHdoZXJlIHRoZSBkcml2ZSBpcyBtYW5hZ2VkIGJ5IGEg
dXNlciBzcGFjZSANCj4gYXBwbGljYXRpb24gdGhhdCBrbm93cyB0aGUgc3RhdHVzIG9mIHpvbmVz
IGFuZCBwaWNrcyBhIHpvbmUgYmVjYXVzZSBpdCBrbm93cyANCj4gaXQgaXMgZnJlZS4gVG8gY2Fs
Y3VsYXRlIHRoZSBzdGFydCBvZmZzZXQgaW4gdGVybXMgb2YgTEJBcyB0aGUgYXBwbGljYXRpb24g
aGFzIA0KPiB0byB1c2UgdGhlIGRpZmZlcmVuY2UgaW4gem9uZV9zaXplIGFuZCB6b25lX2NhcCB0
byBjYWxjdWxhdGUgdGhlIHdyaXRlIG9mZnNldA0KPiBpbiB0ZXJtcyBvZiBMQkFzLiANCg0KV2hh
dCA/IFRoaXMgZG9lcyBub3QgbWFrZSBzZW5zZS4gVGhlIGFwcGxpY2F0aW9uIHNpbXBseSBuZWVk
cyB0byBrbm93IHRoZQ0KY3VycmVudCAic29mdCIgd3AgcG9zaXRpb24gYW5kIGlzc3VlIHdyaXRl
cyBhdCB0aGF0IHBvc2l0aW9uIGFuZCBpbmNyZW1lbnQgaXQNCnJpZ2h0IGF3YXkgd2l0aCB0aGUg
bnVtYmVyIG9mIHNlY3RvcnMgd3JpdHRlbi4gT25jZSB0aGF0IHBvc2l0aW9uIHJlYWNoZXMgem9u
ZQ0KY2FwLCB0aGUgem9uZSBpcyBmdWxsLiBUaGUgaG9sZSBiZWhpbmQgdGhhdCBjYW4gYmUgaWdu
b3JlZC4gV2hhdCBpcyBkaWZmaWN1bHQNCndpdGggdGhpcyA/IFRoaXMgaXMgem9uZSBzdG9yYWdl
IHVzZSAxMDEuDQoNCj4gTXkgYXJndW1lbnQgaXMgdGhhdCB0aGUgem9uZV9zaXplIGlzIGEgY29u
c3RydWN0IGNvbmNlaXZlZCB0byBtYWtlIGEgWk5TIHpvbmUNCj4gYSBwb3dlciBvZiAyIHRoYXQg
Y3JlYXRlcyBhIGhvbGUgaW4gdGhlIExCQSBzcGFjZS4gQXBwbGljYXRpb25zIGRvbid0IHdhbnQN
Cj4gdG8gZGVhbCB3aXRoIHRoZSBwb3dlciBvZiAyIGNvbnN0cmFpbnQgYW5kIG5laXRoZXIgZG8g
ZGV2aWNlcy4gSXQgc2VlbXMgbGlrZQ0KPiB0aGUgZXhpc3Rpbmcgem9uZWQga2VybmVsIGluZnJh
c3RydWN0dXJlLCB3aGljaCBtYWRlIHNlbnNlIGZvciBTTVIsIHB1c2hlZCANCj4gdGhpcyBjb25z
dHJhaW50IG9udG8gZGV2aWNlcyBhbmQgb250byB1c2Vycy4gQXJndW1lbnRzIGNhbiBiZSBtYWRl
IGZvciB3aGVyZSANCj4gY29tcGxleGl0eSBzaG91bGQgbGllLCBidXQgSSBkb24ndCB0aGluayB0
aGlzIGRlY2lzaW9uIG1hZGUgdGhpbmdzIGVhc2llciBmb3INCj4gc29tZW9uZSB0byB1c2UgYSBa
TlMgU1NEIGFzIGEgYmxvY2sgZGV2aWNlLg0KDQoiQXBwbGljYXRpb25zIGRvbid0IHdhbnQgdG8g
ZGVhbCB3aXRoIHRoZSBwb3dlciBvZiAyIGNvbnN0cmFpbnQiDQoNCldlbGwsIHdlIGRlZmluaXRl
bHkgYXJlIG5vdCB0YWxraW5nIHRvIHRoZSBzYW1lIHVzZXJzIHRoZW4uIEJlY2F1c2UgSSBoZWFy
ZCB0aGUNCmNvbnRyYXJ5IGZyb20gdXNlcnMgd2hvIGhhdmUgYWN0dWFsbHkgZGVwbG95ZWQgem9u
ZWQgc3RvcmFnZSBhdCBzY2FsZS4gQW5kIHRoZXJlDQppcyBub3RoaW5nIHRvIGRlYWwgd2l0aCBw
b3dlciBvZiAyLiBUaGlzIGlzIG5vdCBhIGNvbnN0cmFpbnQgaW4gaXRzZWxmLiBBDQpwYXJ0aWN1
bGFyIHpvbmUgc2l6ZSBpcyB0aGUgY29uc3RyYWludCBhbmQgZm9yIHRoYXQsIHVzZXJzIGFyZSBp
bmRlZWQgbmV2ZXINCnNhdGlzZmllZCAoc29tZSB3YW50IHNtYWxsZXIgem9uZXMsIG90aGVyIGJp
Z2dlciB6b25lcykuIFNvIGZhciwgcG93ZXIgb2YgMiBzaXplDQpoYXMgYmVlbiBtb3N0bHkgaXJy
ZWxldmFudCBvciBhY3R1YWxseSByZXF1aXJlZCBiZWNhdXNlIGV2ZXJ5Ym9keSB1bmRlcnN0YW5k
cw0KdGhlIENQVSBsb2FkIGJlbmVmaXRzIG9mIGJpdCBzaGlmdCBhcml0aG1ldGljIGFzIG9wcG9z
ZWQgdG8gQ1BVIGN5Y2xlIGh1bmdyeQ0KbXVsdGlwbGljYXRpb25zIGFuZCBkaXZpc2lvbnMuDQoN
Cj4gDQo+PiAyKSBSZWFkaW5nIGFmdGVyIHRoZSBXUCBpcyBub3QgdXNlZnVsIChpZiBub3Qgb3V0
cmlnaHQgc3R1cGlkKSwgcmVnYXJkbGVzcyBvZg0KPj4gd2hlcmUgdGhlIGxhc3QgdXNhYmxlIHNl
Y3RvciBpbiB0aGUgem9uZSBpcyAoYXQgem9uZSBzdGFydCArIHpvbmUgc2l6ZSBvciBhdA0KPj4g
em9uZSBzdGFydCArIHpvbmUgY2FwKS4NCj4gDQo+IE9mIGNvdXJzZSBidXQgdGhlIHdpdGggcG8y
IHlvdSBmb3JjZSB1c2VsZXNzIExCQSBzcGFjZSBldmVuIGlmIHlvdSBmaWxsIGEgem9uZS4NCg0K
QW5kIG15IHBvaW50IGlzOiBzbyB3aGF0ID8gSSBkbyBub3Qgc2VlIHRoaXMgYXMgYSBwcm9ibGVt
IGdpdmVuIHRoYXQgYWNjZXNzZXMNCm11c3QgYmUgem9uZSBiYXNlZCBhbnl3YXkuDQoNCj4+IEFu
ZCB0YWxraW5nIGFib3V0ICJ1c2UgYSBjb250aWd1b3VzIGFkZHJlc3Mgc3BhY2UiIGlzIGluIG15
IG9waW5pb24gbm9uc2Vuc2UgaW4NCj4+IHRoZSBjb250ZXh0IG9mIHpvbmVkIHN0b3JhZ2Ugc2lu
Y2UgYnkgZGVmaW5pdGlvbiwgZXZlcnl0aGluZyBoYXMgdG8gYmUgbWFuYWdlZA0KPj4gdXNpbmcg
em9uZXMgYXMgdW5pdHMuIFRoZSBvbmx5IHNlbnNpYmxlIHJhbmdlIGZvciBhICJjb250aWd1b3Vz
IGFkZHJlc3Mgc3BhY2UiDQo+PiBpcyAiem9uZSBzdGFydCArIG1pbih6b25lIGNhcCwgem9uZSBz
aXplKSIuDQo+IA0KPiBEZWZpbml0ZWx5IGRpc2FncmVlIHdpdGggdGhpcyBnaXZlbiBwcmV2aW91
cyBhcmd1bWVudHMuIFRoaXMgaXMgYSBjb25zdHJ1Y3QgDQo+IGZvcmNlZCB1cG9uIHVzIGJlY2F1
c2Ugb2Ygem9uZWQgc3RvcmFnZSBsZWdhY3kuDQoNCldoYXQgY29uc3RydWN0ID8gVGhlIHpvbmUg
aXMgdGhlIHVuaXQuIE5vIG1hdHRlciBpdHMgc2l6ZSwgaXQgKm11c3QqIHJlbWFpbiB0aGUNCmFj
Y2VzcyBtYW5hZ2VtZW50IHVuaXQgZm9yIHRoZSB6b25lZCBzb2Z0d2FyZSB0b3AgYmUgY29ycmVj
dC4gVGhpbmtpbmcgdGhhdCBvbmUNCmNhbiBjb3JyZWN0bHkgaW1wbGVtZW50IGEgem9uZSBjb21w
bGlhbnQgYXBwbGljYXRpb24sIG9yIGFueSBwaWVjZSBvZiBzb2Z0d2FyZSwNCndpdGhvdXQgbWFu
YWdpbmcgem9uZXMgYW5kIHVzaW5nIHRoZW0gYXMgdGhlIHN0b3JhZ2UgdW5pdCBpcyBpbiBteSBv
cGluaW9uIGEgYmFkDQpkZXNpZ24gYm91bmQgdG8gZmFpbC4NCg0KSSBtYXkgYmUgd3JvbmcsIG9m
IGNvdXJzZSwgYnV0IEkgc3RpbGwgaGF2ZSB0byBiZSBwcm92ZW4gc28gYnkgYW4gYWN0dWFsIHVz
ZSBjYXNlLg0KDQo+IA0KPj4NCj4+PiAgICAgICAgU2luY2UgY2h1bmtfc2VjdG9ycyBpcyBubyBs
b25nZXIgcmVxdWlyZWQgdG8gYmUgYSBQTzIsIHdlIGhhdmUNCj4+PiAgICAgICAgc3RhcnRlZCB0
aGUgd29yayBpbiByZW1vdmluZyB0aGlzIGNvbnN0cmFpbnQuIFdlIGFyZSB3b3JraW5nIGluIDIN
Cj4+PiAgICAgICAgcGhhc2VzOg0KPj4+DQo+Pj4gICAgICAgICAgMS4gQWRkIGFuIGVtdWxhdGlv
biBsYXllciBpbiBOVk1lIGRyaXZlciB0byBzaW11bGF0ZSBQTzIgZGV2aWNlcw0KPj4+IAl3aGVu
IHRoZSBIVyBwcmVzZW50cyBhIHpvbmVfY2FwYWNpdHkgPSB6b25lX3NpemUuIFRoaXMgaXMgYQ0K
Pj4+IAlwcm9kdWN0IG9mIG9uZSBvZiBEYW1pZW4ncyBlYXJseSBjb25jZXJucyBhYm91dCBzdXBw
b3J0aW5nDQo+Pj4gCWV4aXN0aW5nIGFwcGxpY2F0aW9ucyBhbmQgRlNzIHRoYXQgd29yayB1bmRl
ciB0aGUgUE8yDQo+Pj4gCWFzc3VtcHRpb24uIFdlIHdpbGwgcG9zdCB0aGVzZSBwYXRjaGVzIGlu
IHRoZSBuZXh0IGZldyBkYXlzLg0KPj4+DQo+Pj4gICAgICAgICAgMi4gUmVtb3ZlIHRoZSBQTzIg
Y29uc3RyYWludCBmcm9tIHRoZSBibG9jayBsYXllciBhbmQgYWRkDQo+Pj4gCXN1cHBvcnQgZm9y
IGFyYml0cmFyeSB6b25lIHN1cHBvcnQgaW4gYnRyZnMuIFRoaXMgd2lsbCBhbGxvdyB0aGUNCj4+
PiAJcmF3IGJsb2NrIGRldmljZSB0byBiZSBwcmVzZW50IGZvciBhcmJpdHJhcnkgem9uZSBzaXpl
cyAoYW5kDQo+Pj4gCWNhcGFjaXRpZXMpIGFuZCBidHJmcyB3aWxsIGJlIGFibGUgdG8gdXNlIGl0
IG5hdGl2ZWx5Lg0KPj4NCj4+IFpvbmUgc2l6ZXMgY2Fubm90IGJlIGFyYml0cmFyeSBpbiBidHJm
cyBzaW5jZSBibG9jayBncm91cHMgbXVzdCBiZSBhIG11bHRpcGxlIG9mDQo+PiA2NEsuIFNvIGNv
bnN0cmFpbnRzIHJlbWFpbiBhbmQgc2hvdWxkIGJlIGVuZm9yY2VkLCBhdCBsZWFzdCBieSBidHJm
cy4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGJhc2UgYSBsb3Qgb2YgZGVjaXNpb25z
IG9uIHRoZSB3b3JrIHRoYXQgaGFzIGdvbmUgaW50byANCj4gYnRyZnMuIEkgdGhpbmsgaXQgaXMg
dmVyeSBwcm9taXNpbmcsIGJ1dCBJIGRvbid0IHRoaW5rIGl0IGlzIHNldHRsZWQgdGhhdCBpdCAN
Cj4gaXMgdGhlIG9ubHkgd2F5IHBlb3BsZSB3aWxsIGNvbnN1bWUgWk5TIFNTRHMuDQoNCk9mIGNv
dXJzZSBpdCBpcyBub3QuIEJ1dCBub3Qgc2F0aXNmeWluZyB0aGlzIGNvbnN0cmFpbnQgZXNzZW50
aWFsbHkgZGlzYWJsZXMNCmJ0cmZzIHN1cHBvcnQuIEV2ZXIgaGVhcmQgb2YgYSByZWd1bGFyIGJs
b2NrIGRldmljZSB0aGF0IHlvdSBjYW5ub3QgZm9ybWF0IHdpdGgNCmV4dDQgb3IgeGZzID8gSXQg
aXMgdGhlIHNhbWUgaGVyZS4NCg0KDQotLSANCkRhbWllbiBMZSBNb2FsDQpXZXN0ZXJuIERpZ2l0
YWwgUmVzZWFyY2g=
