Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4145F627CF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 12:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiKNLuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 06:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiKNLte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:49:34 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094AE27929
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 03:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668426370; x=1699962370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y9lXOJSkScvipyLFk3IOX+HRSdLCF+yRYYZMgy7fKHM=;
  b=edK3Z7J0IFiuVOlZpGQt2v56Xpy83/d+sO53W1i1E7Tj80NNTdrRmHnD
   yZ2S/iy5x5yFcWMm5rxw5GJSMG+lHBZZN1jberWl/hTZ9Oc5SUuyV0vHd
   hfWx6NvcdDAEvBBIxVU9B1pcQW8BGkiwx1sXg+FfWZJ9kqEIDMrOi8Ziy
   5ic+H8GlmDOyReFavz1jd17zamtolDJLbWZjz3dgCN3Hp3oMHuIuVi4YG
   UKstBVgfwTUMfB+GOBvWz8ERe1b1NyeaBakBm5SbxqEDUUCWWnX0+jUHf
   bLMhicQJdeTF+YHxhjp1/6VkrPLAvQEh/HpnHKeskr2kubq9ChMetWb71
   g==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="216218611"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 19:46:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIoxVyKodL/byCZPX3HfM7agqO7U2DezcoIdT96mdtqp3mzmSiKXF1fe0vVpIDsO0INDVMJq+d5hwvgHcH0gxE3WGuOkP6FO32pub+jR91MxkrB/a1x/I2WISYfOhNmdr2Vc8AF4cMmhX2s1arjsPsSe2CgBztjL6hcWLg52oLOO2W7zFm2S2mBbE0ewoCyySb1rTTp288f40TlF4pA0aOn7sldmNwJAK3JwS5QlRYyxseyZ2C1h7v3+9+OJ8AfAGHPiOt40VPTUIZiWFv/WobA1kpstrizL7JzuY/n9StRSFkuc+Nd8tmGW7Q3fVd+e+/KZJBJ++5474aJwbIAYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9lXOJSkScvipyLFk3IOX+HRSdLCF+yRYYZMgy7fKHM=;
 b=Yq3qW/mDM7Ou7kibg1R/PvbxnUvfSvLKxoJaIzLePH7z1rCnQEmJ32++dm7y1MU4LDdvUV0hikpivIQ2iVzA+48vd1vg4+fpxO3P4yaQ3dRcsskP4zrCdxylv7xnsOTjh0d+mQjztDzjF1A7341++KrVSg9364q5R3z8KEJKgGeub9pmyhWd2W/uCV26bIHtyNh84Ns50zO4i+Spu/N4j/nEHIJBVeqzkkPwtCQOjs9kqQcPfEZvdFM84dbJfQJ2d146T0VCgWoJBFaG/W3hlOdXSeQrFK7DtYrBVV0MEhqfJ3stPkJbheX6ehiVeoRPatP768Cmqk4sXthT+SGLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9lXOJSkScvipyLFk3IOX+HRSdLCF+yRYYZMgy7fKHM=;
 b=T1kZWn6gfeU79nX+I+NTUK9XCWyHbgN1Hl0GFXiT9YiyZm9QHMxm2F/u9XMe0LRRCRp3qnWdkwBhuMjD+2jrudVM35UW6Wu1tSeDb3uOUTs2KCKy/PeQsezpFeI3jXNzCdphzQ9xMgtO6cogkv9zCDaar+X3wSEYgAaX1pty/o8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6733.namprd04.prod.outlook.com (2603:10b6:208:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 11:46:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%8]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 11:46:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] zonefs: add sanity check for aggregated conventional
 zones
Thread-Topic: [PATCH v2] zonefs: add sanity check for aggregated conventional
 zones
Thread-Index: AQHY+AHrkMVvJw4seEagKr3HlrLTW64+TPCAgAAAaYA=
Date:   Mon, 14 Nov 2022 11:46:07 +0000
Message-ID: <a4b0f598-106d-6fc1-bec0-bd0899ef3539@wdc.com>
References: <fe0e42b533442766d941740697cd8e33fcad99ad.1668413972.git.johannes.thumshirn@wdc.com>
 <d9376665-7295-8d75-d35f-7e4f63c22cdd@opensource.wdc.com>
In-Reply-To: <d9376665-7295-8d75-d35f-7e4f63c22cdd@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6733:EE_
x-ms-office365-filtering-correlation-id: deb61bb8-c64a-433b-3bca-08dac635d1ad
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzKoIACMu8mbE8VHfcHosh2p/NdBvBoWqQIWbxqPpGJIcEVDH8rSswc52RDOkuEmG3qjgmXSKIzmVgw+671y190A8GExG+mYvLIQ+6VfuNitKMeq213/1efy5wC56/sXc4sewEaHvMLUXyMxdA3Dsc8i+EUu9y3SkNdAlyHEBgZ20/MtMUtW6zHReJboh1NoJjf3ughfObrIwTRcvFhnWlAKVtzWPn9mKDL80AbT8JQcI/qWMblG0Vg8cEhyytytjfNUHQAqLE06su3IyFXqVzZJA6XrKKHBQaW+sBLj0azpti1bFQyyYvycyUGYHka6Z4Y+fmxVJ2pBOiyEjbG2VgLCEKmbSg4jGqOl5Ub/XC3Gg8gpfzSrKQ7tg1PWpddvVh05JiqEWD6Y1hl/xLcSDKONGVXi5rNKLGz34HEU7M6vbvjgZUtgFidreWJ3VtzL9quTqHqG+eFnzul4Cluc0CjE5wY7ons4E7CYt2G82SVAVST5chgNr3d3BtXAt4aiLrfu+NupIlYvNalbscWzXdWvZZkUzZuFS/pCdoEdQaWN7VVDiUQu+Dohv8yDmj2S0eAFgbzMNAtV4vKwlPygs1rIqoEszV4n9wQWwVsWcTwBmavb1eJ7kzGzksDXdZnGlRkCxVnaL832FIjTs7E0Jdmp9nqdjpFRikfc2c327PgSFW2xHhMF5ohqb4DO0tDeqVVcZBS4RcgDamZVTwQbEZyyMb9UynmRhVQkYAiHQmtKYXXYvBzjBk+nTLyrb0UDGw0atSgekOhSgC5n4TMie+9O8FbIjQq9G2jIFM7gyxfm6bBBwlSWqIORqAacrop+sIov+9RGCtN7xxQ1xueSvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199015)(64756008)(31696002)(86362001)(316002)(82960400001)(122000001)(38070700005)(6862004)(4744005)(41300700001)(2906002)(4326008)(5660300002)(8936002)(66556008)(66476007)(66446008)(71200400001)(26005)(6512007)(186003)(91956017)(76116006)(66946007)(8676002)(6506007)(6486002)(478600001)(2616005)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmJNNnUyaDF4YWdST1EwRTlvTWlLWXJBOG5NRGo4U0JKUFNrSmp3d284SDNj?=
 =?utf-8?B?NmYyREh2RnhyOWpUSjRBZkRWU0xRZXFoVXErWmIvTkUvdVZoOGkwOEJGTzVR?=
 =?utf-8?B?d0NDSURWbWY2SHg4Mk9rc3I1cEtOSU1WUHdXcWhQRkZzbFA0QmZ3UktuWmZw?=
 =?utf-8?B?Ny9YTUZNbFNaaDFuYWpkSjZvS1NJOHF5M0VCOEhyQjBMV2hEVEp5UnRuREpl?=
 =?utf-8?B?ZmowbmNXZGY1ZWwrTStlbzVOMmp3Vi91YzVldVJlM2c3cmFHcDE0MExxVkJD?=
 =?utf-8?B?RE9mR0lLMG1Pd3JWejM2QnJWVnF2UlM2MkwvemdBVjZ0WVYzWS9aNDYxdk5w?=
 =?utf-8?B?QkdCMXRWT3cwY08yMFl6TDJlWUplekJKQm5qQzZaa20yRFVhYUg5aHpYTFJN?=
 =?utf-8?B?bWlPdzdUblpXTE9YSWg5M3hzM2Q1SS9kYUhjYUtoZE1yZlhGdUlTMlR3VHdQ?=
 =?utf-8?B?TnZ3VnZZaG9KOStkQndXTUEvSU5OdzNLbDV4NEdqUTRrN3JNU253bWtyazFk?=
 =?utf-8?B?SVo3a0I3YjNUUWd0K0FIWTZ4VVhXNHVISkdrZFhOL2lCbFdhTktDK1ZRM1cw?=
 =?utf-8?B?WEl0S1JsRXNRcmVzd2NBOWZNZWlwSHRzQS9xTGE4QkZBVHFYVWZtc3hvZGoy?=
 =?utf-8?B?bmZ4cU94V0l1WG1Ra0xrejgwaWV4SDRLOXRNb2p1Wngyb3NMem1rYlNZb2Zm?=
 =?utf-8?B?U251NzJmRDd0eEdkL2w0V3ZWWTFWVm5UQWtXaXJtOW1kZ2dxd0ZleVErRjF0?=
 =?utf-8?B?Uk9ZM1ZiaERqZjJNK0hRSlgwTU11b1B4L2RScWJiTUw0OFBXVFpCNlhCaldJ?=
 =?utf-8?B?U1RhS2xnNktLT01NWkJYQUE4QlFsQXM1elhoYVBpb05MaTRNazRnWUlQR3My?=
 =?utf-8?B?RVF5T3NEL0NNOUNiSEt5YmpoVFZWamdvV2t5OFVsSnV6Q3NBREZtMi9uMzlH?=
 =?utf-8?B?YXQyQ3YveVBvMVdlTDh4WTRLR2FCUlVraFJ4QzhkNVNWMm9KNnpIYllGdVdN?=
 =?utf-8?B?RDN4M3VZTitxV3VMdGRHYXQrenhiV0dLRkIzRDZxd0dGRWdpYWpja1ZyTnh0?=
 =?utf-8?B?d2NhWEtrQ2RaaHBvTS93OEFVWjhycTYvTkxrMk1BZVRHTnpTaUNYMzFtM2Zm?=
 =?utf-8?B?ZURLcDhJNHg0aldZeW9lS2M1b2RBZDBFWnVMdzUwWllqOTZ5NFl1QlRLL0dZ?=
 =?utf-8?B?L1d5VXJ6TVNUN040NjgxTzZNdXZ1blF3Sk1RY2NjYWxhMUtZTEttdFVyb0M5?=
 =?utf-8?B?b0tqMk9SQk5PK3hIdGFrQnV4ODlvaXJybUVCcGdDNUtVei80Z3NUZVZSME12?=
 =?utf-8?B?WDdkLzBiODFMTWRUNXNiNWxPTjdVUXZQYUxpTFNqV2xUeGFpVG5KYUNlTVhX?=
 =?utf-8?B?WWRGY3lHUlRQVytCMEovMkY2ZkkvUGYwS2pzVERDcEFQSDhSaUFleGR6WkVX?=
 =?utf-8?B?MDRxOUcrQ1A4MXVwNnFrMjczWkhyazE5RVh3YWFRWHIxNEtiL2tRdzZKbXBZ?=
 =?utf-8?B?REtrdU9wMWk4Qk1RWXFMNmV6bkYydnRHMkFoK3ZrZERlODFwUkpnVHNXa0p3?=
 =?utf-8?B?TWR6VWYxQmd6OHNSYkxOdXhJeHdYTUh0S2ZVRUxZMkdobGFicGFxdzFuRG5l?=
 =?utf-8?B?ZEhwSlk2eXBWUW9QQXUwdlgrQzN6QUJGeFFtdWhQTzNuek1xSGFBZzMzSFdm?=
 =?utf-8?B?cVJXenFlVStyM3JpWlBsc1Z3WFMyRGFaaWtNR2toTUJGVThETklNdUE2ZllN?=
 =?utf-8?B?YVZqdUhxZ3pFYXphd2liZ2ZZMEFMMTZXYTN0U09DZlFUT0VjNkJyd0drVHFX?=
 =?utf-8?B?L0Qxd0o1R0ppYW81T0dFZ3A4UzByM29YMk9LQUg0bU5ISWl6Rmh2bXk5Z3pi?=
 =?utf-8?B?WjVTR3EwMWE0MUhCUzQycHcwTDZnUGJ0eTBrZmNGN1JTc2FoSEtONllLTlZZ?=
 =?utf-8?B?TDNJdmVmdFRZQXV2SnlqbEVDK3VmeG9WbWZFcFpmVXFDNGgrS1RlaXRHcmk4?=
 =?utf-8?B?czczcnJQOFFGaEJ0SjA5MFd0cWtkRGd5YWhLUFBkazB1ZFNkNjFCQ09yV01O?=
 =?utf-8?B?N2JZQXo2QXVFVndQcWpuRVJpNWxMWE5YcndYbFcvcXpjaDQvUHcvRFREcEp3?=
 =?utf-8?B?NndqWDRVZ1hEUlpGbmZVYUVvTzAvZXBta3p1TnFGWUhtSWpTQloxZXA5N2NE?=
 =?utf-8?Q?YzgQFfhwtoQME9z/00onrRY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9405895ECED8C442959EAD7F7F1C6DC4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gC8csRQcW7BL4rbZCs1jN2qDn3+A089nlwIqTJtVLrZ1UIUhS/jJJ/Ib+9KQgWa5f+CEbX1ms+Zl3j5+7QgOwSm+DL/WxE4b+hztiXYejFaF8R9XeyoYMbVb/+HOJL8dO5tnQMjR8LZGW1x2UT0NpCRwKg02YXz1D2p3Ff2HPIlRF0LZiUQuARCwPiLu4juSYGjf/915q1r/wAnXTZj26u7VySXfO0C2p9epkmNn4scZvwvQW2VXV1NPA+zGibN+MDn+YsaKuakoLwk/pEQ+hshJnKQWWW01TxqDsc0ipFksVRYTs+XA+z3LxG00EBa7LQMggOaFWY1FFothN7R5tBM4m7n4Dad1kv7OfwEjSkRjDghc5ZIGY1l4+XcbSzIwW1wOEmcsUb0tk9CcVg2G8wVEWN70O7JQH/s1y/95LqAtpEp0BDz6PD7Cu7/3L9zoDJF69Au0sTE8NMQVMdy72hqg2jmeE6IWPx9Q8J03X/o+EUb74Cyu2Ck66gPvmpxoiPMV0/dXO7AxaZwsJwOLRd+aDnOcH80ctiu7Cmi9B2GH0gHbEHq/3mXuyzpHPZ5ge5MbzKkkdFwV1PK8W4Jn/3hvi7zrpTx7Zq5ShMa+Ol16RkNFzENq+uKxfyjyxLfFscxe8nM7OSFZodAUik8q7NDX4TJwUQGpIVmLtiIR53AGPwg4rrP3vSFL+JPXTHDNBmdLu5CKBH+pYGn/AWXD+722IjYwJJNTBJfJKP8BEnS2TqfLY962Be9pmHkTDjLYet2tT7OhjabzDahcfq42Ul159TvFKMdSQbcjUKwP4Uk=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb61bb8-c64a-433b-3bca-08dac635d1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 11:46:07.9391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sqjn3JIe02TR4H3TkhHP0fPX1GCwx9D79s+JLHjEXyU036Eo9QCXsdfHtqK/ayRfsGXLXDAWU+QAXjm6AMrQJD5lDWl34kQ5aSYs2sozaqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6733
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTQuMTEuMjIgMTI6NDQsIERhbWllbiBMZSBNb2FsIHdyb3RlDQo+PiBAQCAtMTU3MCw4ICsx
NTc4LDkgQEAgc3RhdGljIGludCB6b25lZnNfY3JlYXRlX3pncm91cChzdHJ1Y3Qgem9uZWZzX3pv
bmVfZGF0YSAqemQsDQo+PiAgCQkgKiBVc2UgdGhlIGZpbGUgbnVtYmVyIHdpdGhpbiBpdHMgZ3Jv
dXAgYXMgZmlsZSBuYW1lLg0KPj4gIAkJICovDQo+PiAgCQlzbnByaW50ZihmaWxlX25hbWUsIFpP
TkVGU19OQU1FX01BWCAtIDEsICIldSIsIG4pOw0KPj4gLQkJaWYgKCF6b25lZnNfY3JlYXRlX2lu
b2RlKGRpciwgZmlsZV9uYW1lLCB6b25lLCB0eXBlKSkgew0KPj4gLQkJCXJldCA9IC1FTk9NRU07
DQo+PiArCQlkaXIgPSB6b25lZnNfY3JlYXRlX2lub2RlKGRpciwgZmlsZV9uYW1lLCB6b25lLCB0
eXBlKTsNCj4gDQo+IFRoaXMgb25lIGlzIGZvciBmaWxlIGlub2RlcyBidXQgeW91IGFyZSBvdmVy
d3JpdGluZyBkaXIsIHdoaWNoIHdpbGwNCj4gdG90YWxseSBtZXNzIHRoaW5ncyB1cCBmb3IgdGhl
IG5leHQgZmlsZSBpbm9kZSB0byBjcmVhdGUuDQo+IA0KPj4gKwkJaWYgKElTX0VSUihkaXIpKSB7
DQo+PiArCQkJcmV0ID0gUFRSX0VSUihkaXIpOw0KPj4gIAkJCWdvdG8gZnJlZTsNCj4+ICAJCX0N
Cj4+ICANCj4gDQoNCkluZGVlZCBJJ20gc29ycnkuIFdpbGwgc2VuZCBhIHYzIEFTQVAuDQo=
