Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC86E4CFC3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 12:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiCGLHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 06:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241705AbiCGLHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:07:20 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223106543C;
        Mon,  7 Mar 2022 02:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646648926; x=1678184926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eEYZQoac4BKVatM7qI5wWmGkxETFp5xZ2Y+Pr5NFOqs=;
  b=LsodOiTL24bondN0MU3dC1mnwb5ZjzI4xcBCZmbSct/QyDW9GwyPaze2
   sYz6MKR8ieg6+V8a9ygw70KrVzu6FbKbwP1oIZkmOYajMrJUgOxelnv+z
   rxi98z+WFtINgZQ8SkXE5zKX4+bZgmrrUC3Mk7/LPv4+wXd/zHh15IiI/
   CKHl4oX24HJ20veHcNCJ41aAXTsOSXpOuGqw5/KdZLxGrDrLiGeeqBeyj
   ZZes4e9JfYArCNWC7HsVGNbZP9u0ofCdp0rOGpURXvWxErS+W1kq1v37k
   xUnIt8Kp6h0gh61crrEAaSHGZJdUd91to1wkSgIt9kvpak7iJ3Ydp9sij
   A==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643644800"; 
   d="scan'208";a="298791148"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 18:27:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKZeWqwzRc/aKTi/E+QmsOtNS6FFHx02fg1kbdWtVvA8EN4GgErDhZT7vQjTp8B1suqwO4ZnxOgh3+GdZWvWW44zIsMjhUn4y24G2UhVAQxUB+uVT0+Q0EhWY+TCsj1rgS/PK+aXhTf9l+uT62M3uSmcvYdfr5ZgAWio1GRv2qxy+jw8tARAfmGTielgrCPcHSwTj2F/eCJXONa8KbRslb4j95//PAy6Xc2XNAbiDfNx2XfMUWV3IOV/FMt+zZghQ2gLDSQDCeavnfq4GnXSgd8dW+J8yHAEO2bEwKYFFji9Os7UaT2H5Drh5amkCr+s+WHCTnc06XcCTv6xg6adMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEYZQoac4BKVatM7qI5wWmGkxETFp5xZ2Y+Pr5NFOqs=;
 b=cUiJ+y2h10LgWdGIsmGRhmXKYFBmqdqlsQyTWijINSECXOknwcxT1NDX1s4apoSgC1vV5kUo7vlnVw10JMZWhr5CzZM9BGFth7bZCaNha0L6itNnLrjjtcSI03KlTj8Mwey0ftJjr2Go0W3Bmr/ZWNAO//P7B/NA8R5irjWuvh5I/UZYE9V/YQrcCkLlBS3VFSSZMJOAw4TXlhnQuUtIDCnzhd0JlOq4nyGbfPgXmEgXJL4I9XleugrVGgW2MYnMR1QqBj8zwtwHF5U3QJ6LMkvpYs1y7gFIsPgLTIrE+cEMsKoyqjn1mCTlBE9h+Y2ic9l/hTTk/ilxZpVPRR4aow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEYZQoac4BKVatM7qI5wWmGkxETFp5xZ2Y+Pr5NFOqs=;
 b=IZB0mK9OlFE4R8sw1C5dYSjcJ4ESfQ+KxOefHMFtjx6XcuVuPZF4yBP/+jV3YqI/m2IfSNfpinE2e8/pwnxwJ166illThmJQOqy5UnFdCPVpDZCCmOpq1Ud6mfu3JUmdst4gS7Ey8WepUctZjtQem6SguDySY5eCty89DfT+CPo=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by MW4PR04MB7203.namprd04.prod.outlook.com (2603:10b6:303:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Mon, 7 Mar
 2022 10:27:50 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::5cb9:fb30:fba:1e1c]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::5cb9:fb30:fba:1e1c%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 10:27:50 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     Dave Chinner <david@fromorbit.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: RE: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmotDjh/nK/9UCnXW/KPy7zfqyuW0cAgAFwvQCAAAkrgIAAA4sAgACQpoCAAx7VgIAANISQ
Date:   Mon, 7 Mar 2022 10:27:49 +0000
Message-ID: <BYAPR04MB496845AB3EEC1EAD8C7CE4D9F1089@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <20220304224257.GN3927073@dread.disaster.area>
 <YiKY6pMczvRuEovI@bombadil.infradead.org>
 <20220305073321.5apdknpmctcvo3qj@ArmHalley.localdomain>
 <20220307071229.GR3927073@dread.disaster.area>
In-Reply-To: <20220307071229.GR3927073@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfbd8c85-6675-4e90-0bbd-08da00252161
x-ms-traffictypediagnostic: MW4PR04MB7203:EE_
x-microsoft-antispam-prvs: <MW4PR04MB72035A358807F125420259B4F1089@MW4PR04MB7203.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CsggllxHb9SiRYCzkdV1Iu1O4EX11dvnxP6SYhy2IZ2nwxut8v4OHqlnbpXuwYzOMaGYkDC0DGnIiBoNamFjFGsmS5XFUCG5bHBN/XVvWye4RPC8I0xZ3lksL+egGvAjrmVqMUaB1GpaACqBfer0Qv/pP4G0YjJw0LF+CWqbvHIA9izxt8s7xlDnvcXzeFfxbmnz90kIgX4480OgNukmpiH1ROxhzcH2f2fhE9q84TJosXCBkTzxKHTjFYT6Z3qvJhEcwnDqaFftqmzSSZw00BH+eq9Vkff2vXvlv3uEwNg4g1fhIMRh7galKWOYHk1nMRpin9Y9D0uJj6TDFK9fNJcdXlo1ndqiYz7Og/FtBGj57mlsru2q5cS5wy796V/VgUk6P1eeyQAHqDnEGcOqd9Kny0yZoS7ccJq4Fg2pGzRDd/pAmS4o2NE73nPI9HdsDlLJRgrSG0owOzt89d6MJN1zLpzhracnads1zxzd63IJSIu99CLRgQmKdHFREq9lPnBfpRdF09jomY/4bqF6SRDSHBLmsOswUMmKHmc1/j1AppaRL+NJ0mNpvEILx2YCKppDBAnsu5QyouB0g9pJfqPufOWfzjXGiMitb/NOSsSgHors651KjAq3lN8y6C3HHKAVzXgBtFgcGoA+XBRBI2RZF868AY4WejTHu6BlRb0/5CZ3l75LFiB670GJoCQHn0jPD8DLQ2x3dCM6cY5HUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(55016003)(71200400001)(85202003)(6506007)(7696005)(83380400001)(38070700005)(2906002)(82960400001)(33656002)(85182001)(7416002)(5660300002)(316002)(54906003)(26005)(66556008)(76116006)(66946007)(9686003)(52536014)(8936002)(122000001)(186003)(86362001)(8676002)(64756008)(4326008)(110136005)(508600001)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlZYekk2Y3BYTjJoZC9jRzhyRXp5cTE4NE9XOEs2NFZ5TnVoTFExN1hTR0Zr?=
 =?utf-8?B?dVE1eWtYcm9lWFBwaFNSZDJIb3hRQlg2ZVVJbDBWSUZBMGpjQ013SlgyYkg1?=
 =?utf-8?B?R2RTSyswcWNTTmtZTEN6S25tZE9saG9RWWJ3eHRaMXpJbndqbDg5MzNxWDN2?=
 =?utf-8?B?KytGVHFGM3h6cWk4Wm9xbklDZzBQWndCeWVWU3VjSy9UaWxTMDNnMzNPdDRK?=
 =?utf-8?B?aFk2TDZudWtUa3BQcGlxZ3QvdkFFa0lodGpaenNmMllaOGhMd2xSY2VIOEFy?=
 =?utf-8?B?NEtvYWMvZGFMWTRYSHZFK2h2czdHY0R2TnVFRTg3c3FPS0lCa2x4QWpkLytM?=
 =?utf-8?B?NVVyL2JMbm8rdndPNWxId3lBTi9acFhnTU9ISGJjQlNoajhiRGlaL2M1Qmdo?=
 =?utf-8?B?TnM5VUdIU3ZXeUk3KytjSWs1UG9QdmsvcE1TS293cVFlV1FmcmpIN0pBOGdw?=
 =?utf-8?B?MFZKeFYxcG1hc3VsR1BLWjM0eEk1QklqVkdEZEQ0TUN5dVpsWWNBdDN4TUZz?=
 =?utf-8?B?empHUTFWeFlDUE5oVDBXMUt6N2o0d0NDN25xdmcwYkxqUS9vWmtsbU4yL2Rk?=
 =?utf-8?B?eGNLOGlQaU9DVi9mYzc5dTgrenRoUnVkeDg5YUhrL2I2K0Jtck8yaGhqSngw?=
 =?utf-8?B?ODVxQnR4Q3dwWlM1SStNd1Z2RDJCNjVxaHpWeityQnBlYXpwSDFnVk9LZkhO?=
 =?utf-8?B?UGlDNUxWaTYzTDJvTlc5REFWS1h6KzJsb21ZUXlwYnRza1lwb0ViRXZvNXBo?=
 =?utf-8?B?c0U4TmUwK25qc0lRcUNmNlpEb1ZrcFV2UDZLNWFDdTFEL21xZkdERUhxbDdB?=
 =?utf-8?B?eER4eWowZURVUXRod1VNMGZUN2k4SW1HeG96Ry8wWkNqdjNsaTJJTTRBSUJw?=
 =?utf-8?B?aHpWcjVpOHhxQWF5VFM2aHdaV1d3OUJmR2FUUGJSRDhoL3VJS1AzZHh3TVk0?=
 =?utf-8?B?NFp4Y2xTUENwOUN1MTdEU0F2UUpRQU9SdFFxb28vRWZNMGsrbCtPQzRnWTk3?=
 =?utf-8?B?WHphV0xyY3VqUUtkZmF1ZWJ0eUhWOWxjNUpJSzVDbFJaN3JmaEdDMElMVkdl?=
 =?utf-8?B?VnVvMENZRjd3SUtuUjNKdmUwbmZsc0tBL0FvRys0WmZtUmwwUDB3dkNaK2JY?=
 =?utf-8?B?S3BqOFRCd2JSMTdZS09Fc3Y4OW9WZGFxZ0NNMkhaOXp0WGJjemZJeVlhK1U3?=
 =?utf-8?B?TlA4R3psZmpYM1NrUDNBc0JqT21lVUFZSzU5VEFNREZwanE2RGN4R3JTeVNR?=
 =?utf-8?B?Q0JYWTlzNU1qMnByaXRrN2lvM0JpMFVHVDJkaFFJdnlWd3NjZTFKQWVZdHdF?=
 =?utf-8?B?STlvd2wxaDdQREFVZWhZNERUcFpPZFo1dTdpTmg5OHR1bHEvRDQvRFBpUFpG?=
 =?utf-8?B?S2xtSFZkVitoNTdDUmlzakovTmVLYXgwRlF1QmlTOVpQWWMyVENhQ1hNYjh3?=
 =?utf-8?B?MkhMZ21ZS29uVVBEeVh4Q2d2aFlnaW5QVGc2aXNzckRqTTY1eXhYcEE0cFV4?=
 =?utf-8?B?RUFQZVl6YmFlRXIxb0dnc3VUd2JZdDhSWlAyTHhRd05qNlJlQlMzT1RRcmpY?=
 =?utf-8?B?NWNHRGxmN1N6RVFISTlUbWw2WlJJbUFLNEtSQ0RqbzArNnFTckxSQlJzM1B1?=
 =?utf-8?B?SzBaOXNvYytnelZiaU1ZMFViMEp3QjhsWURRdE9NWUVoU3NndExsQ21lZUhz?=
 =?utf-8?B?Tno3N3oyS1FxMTF5ZFZwK29UZkREYVMxeCt1Tjd6UzNrZFZMc0tKaGExTnE1?=
 =?utf-8?B?aWFMVFR4bWpocm5HdFVyTHNNT0k2cWU3ZXFma04vUzVPbGM1SCt0MDVKamVT?=
 =?utf-8?B?ZnFaRkgzYUdsTmN3TURITHErbmJ6OHAxWVNmTDB3NHpwcXhkUFN6enZ4UHNy?=
 =?utf-8?B?MUZkNEJqTlFWZW9xb05UZ2hEZHQwWTNBYTE5ODhyUE51Z1JMVlNZem5vdFMy?=
 =?utf-8?B?ellPYklsNEJNRExOaXdLTjZtUVhkSk1TWmRyeE8zbFJleklPYXZ5cXVTNUhr?=
 =?utf-8?B?UGJQRi9GSGEwSVNNa0hpbEFQVStKdnRSaHNBU2U0VURMMDlvb0hUblZ4NHBo?=
 =?utf-8?B?MmQxekF6NVhUUGRoUk9GVFBYQnpTL1hYbVVaR0cxZHN4Wm5lcmZtaGdvM2p0?=
 =?utf-8?B?TmJSWEpBazBSajMzS2w4dEpoSnZmeXFGTDQxa0VZRTJJT3lFYWFFdUR4c1Q2?=
 =?utf-8?Q?tg5jz4vlWD++4naMal/7n1E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbd8c85-6675-4e90-0bbd-08da00252161
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 10:27:49.7488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QNOu7uSOr/drD3JsXRcu2s+0/EflvpJaKV7J5NQVV62cv6b2CQkwkpf2dvopCSvavT54lZf+isC+RdJ/N+AlUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7203
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+IEkgdW5kZXJzdGFuZCB0aGF0IHlvdSBwb2ludCB0byBab25lRlMgZm9yIHRoaXMuIEl0IGlz
IHRydWUgdGhhdCBpdCB3YXMNCj4gPiBwcmVzZW50ZWQgYXQgdGhlIG1vbWVudCBhcyB0aGUgd2F5
IHRvIGRvIHJhdyB6b25lIGFjY2VzcyBmcm9tDQo+ID4gdXNlci1zcGFjZS4NCj4gPg0KPiA+IEhv
d2V2ZXIsIHRoZXJlIGlzIG5vIHVzZXJzIG9mIFpvbmVGUyBmb3IgWk5TIGRldmljZXMgdGhhdCBJ
IGFtIGF3YXJlDQo+ID4gb2YgKG1heWJlIGZvciBTTVIgdGhpcyBpcyBhIGRpZmZlcmVudCBzdG9y
eSkuICBUaGUgbWFpbiBvcGVuLXNvdXJjZQ0KPiA+IGltcGxlbWVudGF0aW9ucyBvdXQgdGhlcmUg
Zm9yIFJvY2tzREIgdGhhdCBhcmUgYmVpbmcgdXNlZCBpbg0KPiA+IHByb2R1Y3Rpb24gKFplbkZT
IGFuZCB4WlRMKSByZWx5IG9uIGVpdGhlciByYXcgem9uZSBibG9jayBhY2Nlc3Mgb3INCj4gPiB0
aGUgZ2VuZXJpYyBjaGFyIGRldmljZSBpbiBOVk1lICgvZGV2L25nWG5ZKS4NCj4gDQo+IFRoYXQn
cyBleGFjdGx5IHRoZSBzaXR1YXRpb24gd2Ugd2FudCB0byBhdm9pZC4NCj4gDQo+IFlvdSdyZSB0
YWxraW5nIGFib3V0IGFjY2Vzc2luZyBab25lZCBzdG9yYWdlIGJ5IGtub3dpbmcgZGlyZWN0bHkg
YWJvdXQgaG93DQo+IHRoZSBoYXJkd2FyZSB3b3JrcyBhbmQgaW50ZXJmYWNpbmcgZGlyZWN0bHkg
d2l0aCBoYXJkd2FyZSBzcGVjaWZpYyBkZXZpY2UNCj4gY29tbWFuZHMuDQo+IA0KPiBUaGlzIGlz
IGV4YWN0bHkgd2hhdCBpcyB3cm9uZyB3aXRoIHRoaXMgd2hvbGUgY29udmVyc2F0aW9uIC0gZGly
ZWN0IGFjY2VzcyB0bw0KPiBoYXJkd2FyZSBpcyBmcmFnaWxlIGFuZCB2ZXJ5IGxpbWl0aW5nLCBh
bmQgdGhlIHdob2xlIHB1cnBvc2Ugb2YgaGF2aW5nIGFuDQo+IG9wZXJhdGluZyBzeXN0ZW0gaXMg
dG8gYWJzdHJhY3QgdGhlIGhhcmR3YXJlIGZ1bmN0aW9uYWxpdHkgaW50byBhIGdlbmVyYWxseQ0K
PiB1c2FibGUgQVBJLiBUaGF0IHdheSB3aGVuIHNvbWV0aGluZyBuZXcgZ2V0cyBhZGRlZCB0byB0
aGUgaGFyZHdhcmUgb3INCj4gc29tZXRoaW5nIGdldHMgcmVtb3ZlZCwgdGhlIGFwcGxpY2F0aW9u
cyBkb24ndCBiZWNhdXNlIHRoZXkgd2VyZW4ndCB3cml0dGVuDQo+IHdpdGggdGhhdCBzb3J0IG9m
IGhhcmR3YXJlIGZ1bmN0aW9uYWxpdHkgZXh0ZW5zaW9uIGluIG1pbmQuDQo+IA0KPiBJIHVuZGVy
c3RhbmQgdGhhdCBSb2Nrc0RCIHByb2JhYmx5IHdlbnQgZGlyZWN0IHRvIHRoZSBoYXJkd2FyZSBi
ZWNhdXNlLCBhdA0KPiB0aGUgdGltZSwgaXQgd2FzIHRoZSBvbmx5IGNob2ljZSB0aGUgZGV2ZWxv
cGVycyBoYWQgdG8gbWFrZSB1c2Ugb2YgWk5TIGJhc2VkDQo+IHN0b3JhZ2UuIEkgdW5kZXJzdGFu
ZCB0aGF0Lg0KPiANCj4gSG93ZXZlciwgSSBhbHNvIHVuZGVyc3RhbmQgdGhhdCB0aGVyZSBhcmUg
KmJldHRlciBvcHRpb25zIG5vdyogdGhhdCBhbGxvdw0KPiBhcHBsaWNhdGlvbnMgdG8gdGFyZ2V0
IHpvbmUgc3RvcmFnZSBpbiBhIHdheSB0aGF0IGRvZXNuJ3QgZXhwb3NlIHRoZW0gdG8gdGhlDQo+
IGZvaWJsZXMgb2YgaGFyZHdhcmUgc3VwcG9ydCBhbmQgc3RvcmFnZSBwcm90b2NvbCBzcGVjaWZp
Y2F0aW9ucyBhbmQNCj4gY2hhcmFjdGVyaXN0aWNzLg0KPiANCj4gVGhlIGdlbmVyaWMgaW50ZXJm
YWNlIHRoYXQgdGhlIGtlcm5lbCBwcm92aWRlcyBmb3Igem9uZWQgc3RvcmFnZSBpcyBjYWxsZWQN
Cj4gWm9uZUZTLiBGb3JnZXQgYWJvdXQgdGhlIGZhY3QgaXQgaXMgYSBmaWxlc3lzdGVtLCBhbGwg
aXQgZG9lcyBpcyBwcm92aWRlIHVzZXJzcGFjZQ0KPiB3aXRoIGEgbmFtZWQgem9uZSBhYnN0cmFj
dGlvbiBmb3IgYSB6b25lZA0KPiBkZXZpY2U6IGV2ZXJ5IHpvbmUgaXMgYW4gYXBwZW5kLW9ubHkg
ZmlsZS4NCj4gDQo+IFRoYXQncyB3aGF0IEknbSB0cnlpbmcgdG8gZ2V0IGFjcm9zcyBoZXJlIC0g
dGhpcyB3aG9sZSBkaXNjdXNzaW9uIGFib3V0IHpvbmUNCj4gY2FwYWNpdHkgbm90IG1hdGNoaW5n
IHpvbmUgc2l6ZSBpcyBhIGhhcmR3YXJlLyBzcGVjaWZpY2F0aW9uIGRldGFpbCB0aGF0DQo+IGFw
cGxpY2F0aW9ucyAqZG8gbm90IG5lZWQgdG8ga25vdyBhYm91dCogdG8gdXNlIHpvbmUgc3RvcmFn
ZS4gVGhhdCdzDQo+IHNvbWV0aGluZyB0YWh0IFpvbmVmcyBjYW4vZG9lcyBoaWRlIGZyb20gYXBw
bGljYXRpb25zIGNvbXBsZXRlbHkgLSB0aGUgem9uZQ0KPiBmaWxlcyBiZWhhdmUgZXhhY3RseSB0
aGUgc2FtZSBmcm9tIHRoZSB1c2VyIHBlcnNwZWN0aXZlIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlcg0K
PiB0aGUgaGFyZHdhcmUgem9uZSBjYXBhY2l0eSBpcyB0aGUgc2FtZSBvciBsZXNzIHRoYW4gdGhl
IHpvbmUgc2l6ZS4NCj4gDQo+IEV4cGFuZGluZyBhY2Nlc3MgdGhlIGhhcmR3YXJlIGFuZC9vciBy
YXcgYmxvY2sgZGV2aWNlcyB0byBlbnN1cmUgdXNlcnNwYWNlDQo+IGFwcGxpY2F0aW9ucyBjYW4g
ZGlyZWN0bHkgbWFuYWdlIHpvbmUgd3JpdGUgcG9pbnRlcnMsIHpvbmUgY2FwYWNpdHkvc3BhY2UN
Cj4gbGltaXRzLCBldGMgaXMgdGhlIHdyb25nIGFyY2hpdGVjdHVyYWwgZGlyZWN0aW9uIHRvIGJl
IHRha2luZy4gVGhlIHNvcnQgb2YNCj4gKmhhcmR3YXJlIHF1aXJrcyogYmVpbmcgZGlzY3Vzc2Vk
IGluIHRoaXMgdGhyZWFkIG5lZWQgdG8gYmUgbWFuYWdlZCBieSB0aGUNCj4ga2VybmVsIGFuZCBo
aWRkZW4gZnJvbSB1c2Vyc3BhY2U7IHVzZXJzcGFjZSBzaG91bGRuJ3QgbmVlZCB0byBjYXJlIGFi
b3V0DQo+IHN1Y2ggd2llcmQgYW5kIGVzb3RlcmljIGhhcmR3YXJlIGFuZCBzdG9yYWdlDQo+IHBy
b3RvY29sL3NwZWNpZmljYXRpb24vaW1wbGVtZW50YXRpb24NCj4gZGlmZmVyZW5jZXMuDQo+IA0K
PiBJTU8sIHdoaWxlIFJvY2tzREIgaXMgdGhlIHRlY2hub2xvZ3kgbGVhZGVyIGZvciBaTlMsIGl0
IGlzIG5vdCB0aGUgbW9kZWwgdGhhdA0KPiBuZXcgYXBwbGljYXRpb25zIHNob3VsZCBiZSB0cnlp
bmcgdG8gZW11bGF0ZS4gVGhleSBzaG91bGQgYmUgZGVzaWduZWQgZnJvbQ0KPiB0aGUgZ3JvdW5k
IHVwIHRvIHVzZSBab25lRlMgaW5zdGVhZCBvZiBkaXJlY3RseSBhY2Nlc3NpbmcgbnZtZSBkZXZp
Y2VzIG9yDQo+IHRyeWluZyB0byB1c2UgdGhlIHJhdyBibG9jayBkZXZpY2VzIGZvciB6b25lZCBz
dG9yYWdlLiBVc2UgdGhlIGdlbmVyaWMga2VybmVsDQo+IGFic3RyYWN0aW9uIGZvciB0aGUgaGFy
ZHdhcmUgbGlrZSBhcHBsaWNhdGlvbnMgZG8gZm9yIGFsbCBvdGhlciB0aGluZ3MhDQo+IA0KPiA+
IFRoaXMgaXMgYmVjYXVzZSBoYXZpbmcgdGhlIGNhcGFiaWxpdHkgdG8gZG8gem9uZSBtYW5hZ2Vt
ZW50IGZyb20NCj4gPiBhcHBsaWNhdGlvbnMgdGhhdCBhbHJlYWR5IHdvcmsgd2l0aCBvYmplY3Rz
IGZpdHMgbXVjaCBiZXR0ZXIuDQo+IA0KPiBab25lRlMgZG9lc24ndCBhYnNvbHZlIGFwcGxpY2F0
aW9ucyBmcm9tIGhhdmluZyB0byBwZXJmb3JtIHpvbmUgbWFuYWdlbWVudA0KPiB0byBwYWNrIGl0
J3Mgb2JqZWN0cyBhbmQgZ2FyYmFnZSBjb2xsZWN0IHN0YWxlIHN0b3JhZ2Ugc3BhY2UuICBab25l
RlMgbWVyZWx5DQo+IHByb3ZpZGVzIGEgZ2VuZXJpYywgZmlsZSBiYXNlZCwgaGFyZHdhcmUgaW5k
ZXBlbmRlbnQgQVBJIGZvciBwZXJmb3JtaW5nIHRoZXNlDQo+IHpvbmUgbWFuYWdlbWVudCB0YXNr
cy4NCj4gDQo+ID4gTXkgcG9pbnQgaXMgdGhhdCB0aGVyZSBpcyBzcGFjZSBmb3IgYm90aCBab25l
RlMgYW5kIHJhdyB6b25lZCBibG9jaw0KPiA+IGRldmljZS4gQW5kIHJlZ2FyZGluZyAhUE8yIHpv
bmUgc2l6ZXMsIG15IHBvaW50IGlzIHRoYXQgdGhpcyBjYW4gYmUNCj4gPiBsZXZlcmFnZWQgYm90
aCBieSBidHJmcyBhbmQgdGhpcyByYXcgem9uZSBibG9jayBkZXZpY2UuDQo+IA0KPiBPbiB0aGF0
IEkgZGlzYWdyZWUgLSBhbnkgYXJndW1lbnQgdGhhdCBzdGFydHMgd2l0aCAid2UgbmVlZCByYXcg
em9uZWQgYmxvY2sNCj4gZGV2aWNlIGFjY2VzcyB0byAuLi4uIiBpcyBzdGFydGluZyBmcm9tIGFu
IGludmFsaWQgcHJlbWlzZS4gV2Ugc2hvdWxkIGJlIGhpZGluZw0KPiBoYXJkd2FyZSBxdWlya3Mg
ZnJvbSB1c2Vyc3BhY2UsIG5vdCBleHBvc2luZyB0aGVtIGZ1cnRoZXIuDQo+IA0KPiBJTU8sIHdl
IHdhbnQgd3JpdGluZyB6b25lIHN0b3JhZ2UgbmF0aXZlIGFwcGxpY2F0aW9ucyB0byBiZSBzaW1w
bGUgYW5kDQo+IGFwcHJvYWNoYWJsZSBieSBhbnlvbmUgd2hvIGtub3dzIGhvdyB0byB3cml0ZSB0
byBhcHBlbmQtb25seSBmaWxlcy4gIFdlIGRvDQo+IG5vdCB3YW50IHN1Y2ggYXBwbGljYXRpb25z
IHRvIGJlIGxpbWl0ZWQgdG8gcGVvcGxlIHdobyBoYXZlIGRlZXAgYW5kIHJhcmUNCj4gZXhwZXJ0
aXNlIGluIHRoZSBkYXJrIGRldGFpbHMgb2YsIHNheSwgbGFyZ2VseSB1bmRvY3VtZW50ZWQgbmlj
aGUgTlZNZSBaTlMNCj4gc3BlY2lmaWNhdGlvbiBhbmQgcHJvdG9jb2wgcXVpcmtzLg0KPiANCj4g
Wm9uZUZTIHByb3ZpZGVzIHVzIHdpdGggYSBwYXRoIHRvIHRoZSBmb3JtZXIsIHdoYXQgeW91IGFy
ZSBhZHZvY2F0aW5nIGlzIHRoZQ0KPiBsYXR0ZXIuLi4uDQo+IA0KDQorIEhhbnMgKHplbmZzL3Jv
Y2tzZGIgYXV0aG9yKQ0KDQpEYXZlLCB0aGFuayB5b3UgZm9yIHlvdXIgZ3JlYXQgaW5zaWdodC4g
SXQgaXMgYSBncmVhdCBhcmd1bWVudCBmb3Igd2h5IHpvbmVmcyBtYWtlcyBzZW5zZS4gSSBtdXN0
IGFkbWl0IHRoYXQgRGFtaWVuIGhhcyBiZWVuIHRlbGxpbmcgbWUgdGhpcyBtdWx0aXBsZSB0aW1l
cywgYnV0IEkgZGlkbid0IGZ1bGx5IGdyb2sgdGhlIGJlbmVmaXRzIHVudGlsIHNlZWluZyBpdCBp
biB0aGUgbGlnaHQgb2YgdGhpcyB0aHJlYWQuDQoNCldydCB0byBSb2Nrc0RCIHN1cHBvcnQgdXNp
bmcgWmVuRlMgLSB3aGlsZSByYXcgYmxvY2sgYWNjZXNzIHdhcyB0aGUgaW5pdGlhbCBhcHByb2Fj
aCwgaXQgaXMgdmVyeSBlYXN5IHRvIGNoYW5nZSB0byB1c2UgdGhlIHpvbmVmcyBBUEkuIEhhbnMg
aGFzIGFscmVhZHkgd2hpcHBlZCB1cCBhIHBsYW4gZm9yIGhvdyB0byBkbyBpdC4NCg0KDQo=
