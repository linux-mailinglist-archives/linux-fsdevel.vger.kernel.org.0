Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEA3613593
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 13:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiJaMPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 08:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiJaMPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:15:42 -0400
X-Greylist: delayed 4229 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Oct 2022 05:15:41 PDT
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D1EEE08;
        Mon, 31 Oct 2022 05:15:41 -0700 (PDT)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29V9Ykpr018879;
        Mon, 31 Oct 2022 11:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=zKK6pMomkAXJH4rRJPRiogyT0GBTxLLnBW4WI8BsVIc=;
 b=DYliaJnoARbz1HfTZP68erflOa01QcuqRUI36Vda7ADIju+A7ueKYxiRHwZnpARQC0C0
 S9+G0j7KZ2R7BDlAqITOG6d8x/cEOv+S5AyjIxX7u/6pLC45kVzVthEkWH+cggCTHvkj
 fhvNnxs/OQqWnbhm61QKV6IlIRJ3QFS9VJ175bL3RbtLcFt5eTQnczh72uwvoCYPL1D1
 zItvEQllmejMPF+syZ+ZUFlFxHleZZWgXIyf8RIbRAUL5LaFw4whNrR2Vketkvy9Vvyk
 ntPaKwtZwaSvDwtNjyeDhbDX9BN8eoV2Vf/IaVMA8p2Ds1WDZ83oeoWO5gzoJGy6AY/A 4Q== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2048.outbound.protection.outlook.com [104.47.110.48])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kgsk5sqmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 11:04:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcqVt7aDTLcFECYZXq2HYlQFmWz++fxZWgtJj6jXXKu6QiyRffsR/4YSQITJ7KOifuqk1OyNb8je50bfw28XWSCql1sNE+MX90WPq+MhTvxWf53oSB6X1cB6D3D6E06WS3xLbMckLMO6atShATujQfD5pG0DE4nxbwcn1s1t4i9PkFi1DOMtlqYTiXHKRq9DZ4WWuGY7o4/MTxTH3Jn/Df8OKbzIE8bvcVFH4ovUKUwiAMv2cEXtIjze0LM9W3hCa2ImvULL3L8AlL+JHjFZy6Nmbrbl4YOg8zixUDxrcySkGg3Hz8Lrqj7ceWbyXGlcCBC9mJwuG2TKkFq/bOnp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKK6pMomkAXJH4rRJPRiogyT0GBTxLLnBW4WI8BsVIc=;
 b=NrOQDGpy0szfnqEGefjLsWYe5luAMtdbPDKme4VRDhDlvPR/uliMQfH0KanIOZ6dnOeSYA/u3PSKWpXt/21WrwnRdrMhmi171sAjWe+Z/iPXbo0OoTTOtbOmRDIBv7mU7BVg0Re9BvESncjTakNMJW8fmLyjiGp4EudUcuQCoGIoylSbK5vKIL0QT+puReNDygzjnbHzhPFfgMWdv+U5PfmEFVRAgr5wJukw83aN4sa/FxVj2x16cDWZDxTdHz0bzOGja9yfN5dq/figPwms7InhuJFHhqaxVPgX7NbgorNB4yfUuzAQKiE7I3T3MQchfvEWSrC0QN62u72qX/1mTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB6114.apcprd04.prod.outlook.com (2603:1096:4:1fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Mon, 31 Oct
 2022 11:04:48 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%9]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 11:04:48 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] exfat: hint the empty entry which at the end of
 cluster chain
Thread-Topic: [PATCH v1 2/2] exfat: hint the empty entry which at the end of
 cluster chain
Thread-Index: AdjjiwOaYD2AtaT5Ts+/ofBfIWokxAJZ3ofhAAa6O9A=
Date:   Mon, 31 Oct 2022 11:04:47 +0000
Message-ID: <PUZPR04MB6316E0E22B1CAAAB25E02C3581379@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <CGME20221019072854epcas1p2a2b272458803045b4dfa95b17fb4f547@epcas1p2.samsung.com>
 <PUZPR04MB631604A0BBD29713D3F8DAB0812B9@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <014c01d8ecf0$6e74bc80$4b5e3580$@samsung.com>
 <CAKYAXd9omiOTAaAWSnzE5jCQFDL8Nkok_wm_OAYwxVpgcCxykg@mail.gmail.com>
In-Reply-To: <CAKYAXd9omiOTAaAWSnzE5jCQFDL8Nkok_wm_OAYwxVpgcCxykg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB6114:EE_
x-ms-office365-filtering-correlation-id: 3ed899ed-b9d3-4e9b-dc82-08dabb2fb9b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mgI/59DE74enItRoR6cC2gKXIACTcv69jpLxP7LVSEChOYughcU0yVG/ivrH64u0FUMYXYH8+6wh69Umz3LENRzWbt7rMPuO3DEFONp8q3hqd4o0zLMqwItfIR8E+Sanse9w2JeZK65bp4UkzvTPtqNvUoUgyFph2H0h0QrL84jMwunLxS73SHwsh02fibM0+Wg2NYdSMjMYJ4nZv2o6QgW3FJzWhB9WAfdGYU+zq3fxdmDiEnm3XxY0tMMn1cUe47HJlzaKFYsCdMG9qyztsIF3vmK6Q71062jxFs71NG2TO/2c3iPs9XxWuBYfY5MbQBvEgPQVpAyN/OSZFwJK9ncDc4xK0S5AoG40oEeyeZTE+8Bri5az+hWHeHP2R34WmGQ7CdYI0VFY3bww78HblRpzC/3j7gzF52vc/YzH30Z2awbz18YzGh2MpAJrXIFWnHC4h8mEd9gS6atLN1UEktvNhHdIzUDwoOESELQ3HZDUqdeQ02CqVf09Fb1fqmXp8WmuswEQ2d8vH7ZfNOORb+lLKd0oicYBgqhQlymKjSjk4I9wfKuoWoI6vSQmX2SRDamsV97XkmNNHWTMIosgogMINa0OYlXGy4+gSwG7gIWW+TgAfW7TcH/DYmvA/7hlCTvZAcXYTit7fuf4Td85judZfdal2ubUGHDhtAJNKgucuK21KHe4xwJjoyRqKOrm68zvrunxfHk9l/GLd7SyFCsGm9nJ/EW4+Unpc0r5vK8n4/Ne5vkW8PLRIzjSFvfdIElw4N1AmLITvlJqAr3QJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199015)(122000001)(38070700005)(82960400001)(38100700002)(55016003)(86362001)(33656002)(4001150100001)(71200400001)(2906002)(478600001)(4326008)(316002)(66446008)(76116006)(8676002)(66556008)(66946007)(64756008)(8936002)(5660300002)(110136005)(66476007)(7696005)(6506007)(41300700001)(52536014)(54906003)(9686003)(186003)(53546011)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUE4eFRTOWlEaWpQdUo2bDZ0WGFjSlZFd1N5ZG1yWVpibXJSZWxULy9NclRH?=
 =?utf-8?B?MTVmdSt2MklJd3JLc2FXempjUTNPWFFjNGhhV1p4Ky9LUExDV3IzaHYxMXdv?=
 =?utf-8?B?OGc3d2lPRFladzg3NklDNmljNlBoS1NLMC9ORkFjSlptQ1JXMU95clBnR3Bx?=
 =?utf-8?B?Vk81T21HbzRVQmlYb1RnMGN2SnNaY29TeG51Lzh0TUtzSmQ4czhoWWg4MjIr?=
 =?utf-8?B?SjhqdTUxTlNvUGpYaEdrOFp0eHg1Q0VpY0QwbXJTOUtjb2dIdkFsaGlDQXlX?=
 =?utf-8?B?aVZkSkR0ODNQUHNPdWZxcnc0WG1obkVGQ21CRkZ4STF4NDBFM3pMc2FMQ01x?=
 =?utf-8?B?K3RlN0hYeG1UREUySFA1Uk9GdXlnVytXWnhrYzR5enEzZmp1U2NlWlFxMTVQ?=
 =?utf-8?B?S2pnWTRqa0NSNXBhN1pOY2V4eEF3YXJMZkRJNHg3UC8rbmM1cWR2M0FpN1lT?=
 =?utf-8?B?TUJhOTYyOUZod3ppMWh1T21xNzl1dTJGT2tiVUlVWi9Lcm1RWnBkZG54Y3I3?=
 =?utf-8?B?UHUyTkFqUkRGYUZ3MEtTdzAzYVFSc3FuS0JZUkQ2L1FxOThOdkd0QzhmMWQx?=
 =?utf-8?B?Z1FZZTlwcXcra3pHbHJweWdiTUdEbXpXSXJIM1Q1Z3MrS2FvT2duVXQ2dnMy?=
 =?utf-8?B?Q04zQjZCZGt6RkZzcUprem5IOVRQU2QwOHZ6OFVZVGNZSmpNTEl4em5LdUxm?=
 =?utf-8?B?OXFYRVRQaHMvNnBDVmxTT3FRSDV2RklhYmxYY2s5Tm1nQjllMXBta1NmNFVn?=
 =?utf-8?B?RVV1Rit4bmVFQXlGMkJDdXdWeGNVNWxsbS9hbEpNME9ieFMwaXpLN0kxaVFP?=
 =?utf-8?B?YjBidElqTk9ka3dhUjNGdlBHVUhkaEZlYmxxaUozNTA5eFQ5T3pPMXRPTGdT?=
 =?utf-8?B?MnZPSkUxamVSUGkwaUVMYVNDcVU0SXA2MkJIdUI4MWZiaEM2dG5NWUMzdFNJ?=
 =?utf-8?B?NHJET1VNZTM3SUhiTjgyRjNZM1hjZ3F5eE1KcTg2TEJsR3ZwYUwxWGNqa0Rv?=
 =?utf-8?B?NVBXaktTeUkybWRoNjZjdGFXaFBqT2RzMUVLN0xxZHZ6VlcvRGpzMG03Z3Jn?=
 =?utf-8?B?bGw0UGxPRy9pRmNxTDFwZ2dlamdPV1J1U2IweFRHMXZmWGdMaTA1TlVpSlZT?=
 =?utf-8?B?bklCTWIyNERCZWRsN1RoWXRyeTZ2czdyLzk2NGdicEtldkhwc3ZZY3Z0OVpI?=
 =?utf-8?B?dHdzWHpKamNFQkNZQWhEZ3dJanZRcmhTeEM3dkVZdXpqa2NBYmJXdVNoOGNo?=
 =?utf-8?B?SGtIT3FudzBXaGtwMFBkc3B1QzVwejNBRWlKSVZwVk9pTmZMSWg0ZU92Q2tV?=
 =?utf-8?B?Q0V0TFo3T29VOGdtTWd6WVZ2b0pCMFVsMTZiTG5oM1Z2VHc1ZGkxd1dBd0dC?=
 =?utf-8?B?RHZJdElBSWdEbFhEL1dkVnhiRjc1U0FVR3hTRCtDOGhvV2ZVL1cvUTV2RlF1?=
 =?utf-8?B?T1ZYNE43RFRtdnNCN1dmOENCaDJablJQQkx4cnVsVGh4d1JwSDJtMFlDZ0Vu?=
 =?utf-8?B?dnhWdVZ0eDlWZ1ZIcmFvMzhCU21CTDlvRHNoK3pzcnVLZXltSVBCYktJQ3M0?=
 =?utf-8?B?RW1xVlRNRkJjSlNVYVQzc2p4NVYrT0lIc0xXSHRZUUhvZzgyS3JRamZ2MGZ0?=
 =?utf-8?B?Vld4Yit6MlMzMElldlZUK1VHUy9wTDZVeTQ4c0sraWZBbGUyeUo4MmZTU3pR?=
 =?utf-8?B?NkFwalp0MThtcnE2ejhkRGJCNTcvWVN1N2hZSC9JSXBZRm4xMGxNbERaQ21s?=
 =?utf-8?B?NnA2THdYNzdlM3BOR0JJYncwMmNFTG1OTkRXZkkyY0NqQ1E3QUpWSDI4VThW?=
 =?utf-8?B?eklWb1dSRzh5UTNLb3pjNnJqSU9YVTYrYzhEVkN3WkV1QmdrWHpoU3J4cEZQ?=
 =?utf-8?B?bDRlTGh4Zm4xaXZBWnF1cnhTNXovclIvZUZFQkh0SytKNXQvR2FvV0hKR2NT?=
 =?utf-8?B?TTFmejZKeVF6dFBHSWJDZ1JkSHJ5V0QzVWJzWm56NTN6bDIranhDbkRERHRo?=
 =?utf-8?B?bTlyV0xGaUFCN3lSRmZkb2NBYVJVWDZvLzNjUDJtM3RFRHo3NnlHYzVlanBa?=
 =?utf-8?B?V1ljWDV0RDN2YnkzMHhQZDBQZ0V2dm5BOTdhRUpLUDJTZjYxRmFUTE9NTUNk?=
 =?utf-8?Q?RNLU7jm4afNf2jLUUAyxZf3AW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed899ed-b9d3-4e9b-dc82-08dabb2fb9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 11:04:47.9176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVu+Px7vGGviyD6/ZhgA8SOV05hKZvNCJU0efm8y3fjX3Cit6LhM95c8pjSsIFmhwS9ShIBSamo0cD7huLREgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6114
X-Proofpoint-GUID: hZZn9jm3JU_g5MIydaHVIfUNSgcjwCEd
X-Proofpoint-ORIG-GUID: hZZn9jm3JU_g5MIydaHVIfUNSgcjwCEd
X-Sony-Outbound-GUID: hZZn9jm3JU_g5MIydaHVIfUNSgcjwCEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_06,2022-10-31_01,2022-06-22_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+IFRoaXMgc2VlbXMgbGlrZSBhIHZlcnkgZ29vZCBhcHByb2FjaC4gUGVyaGFwcyB0aGUga2V5
IGZpeCB0aGF0DQo+ID4gaW1wcm92ZWQgcGVyZm9ybWFuY2Ugc2VlbXMgdG8gYmUgdGhlIGhhbmRs
aW5nIG9mIGNhc2VzIHdoZXJlIGVtcHR5DQo+ID4gc3BhY2Ugd2FzIG5vdCBmb3VuZCBhbmQgZW5k
ZWQgd2l0aCBUWVBFX1VOVVNFRC4NCj4gPg0KPiA+IEhvd2V2ZXIsIHRoZXJlIGFyZSBjb25jZXJu
cyBhYm91dCB0cnVzdGluZyBhbmQgdXNpbmcgdGhlIG51bWJlciBvZg0KPiA+IGZyZWUgZW50cmll
cyBhZnRlciBUWVBFX1VOVVNFRCBjYWxjdWxhdGVkIGJhc2VkIG9uIGRpcmVjdG9yeSBzaXplLg0K
PiA+IFRoaXMgaXMgYmVjYXVzZSwgdW5saWtlIGV4RkFUIFNwZWMuLCBpbiB0aGUgcmVhbCB3b3Js
ZCwgdW5leHBlY3RlZA0KPiA+IFRZUEVfVU5VU0VEIGVudHJpZXMgbWF5IGV4aXN0LiA6KCBUaGF0
J3Mgd2h5IGV4ZmF0X3NlYXJjaF9lbXB0eV9zbG90KCkNCj4gPiBjaGVja3MgaWYgdGhlcmUgaXMg
YW55IHZhbGlkIGVudHJ5IGFmdGVyIFRZUEVfVU5VU0VELiBJbiBteQ0KPiA+IGV4cGVyaWVuY2Us
IHRoZXkgY2FuIGJlIGNhdXNlZCBieSBhIHdyb25nIEZTIGRyaXZlciBhbmQgSC9XIGRlZmVjdHMs
DQo+ID4gYW5kIHRoZSBwcm9iYWJpbGl0eSBvZiBvY2N1cnJlbmNlIGlzIG5vdCBsb3cuDQo+ID4N
Cj4gPiBUaGVyZWZvcmUsIHdoZW4gdGhlIGxvb2t1cCBlbmRzIHdpdGggVFlQRV9VTlVTRUQsIGlm
IHRoZXJlIGFyZSBubw0KPiA+IGVtcHR5IGVudHJpZXMgZm91bmQgeWV0LCBpdCB3b3VsZCBiZSBi
ZXR0ZXIgdG8gc2V0IHRoZSBsYXN0IGVtcHR5DQo+ID4gZW50cnkgdG8gaGludF9mZW1wLmVpZHgg
YW5kIHNldCBoaW50X2ZlbXAuY291bnQgdG8gMC4NCj4gPiBJZiBzbywgZXZlbiBpZiB0aGUgbG9v
a3VwIGVuZHMgd2l0aCBUWVBFX1VOVVNFRCwNCj4gPiBleGZhdF9zZWFyY2hfZW1wdHlfc2xvdCgp
IGNhbiBzdGFydCBzZWFyY2hpbmcgZnJvbSB0aGUgcG9zaXRpb24gb2YgdGhlDQo+ID4gbGFzdCBl
bXB0eSBlbnRyeSBhbmQgY2hlY2sgd2hldGhlciB0aGVyZSBhcmUgYWN0dWFsbHkgZW1wdHkgZW50
cmllcyBhcw0KPiA+IG1hbnkgYXMgdGhlIHJlcXVpcmVkIG51bV9lbnRyaWVzIGFzIG5vdy4NCj4g
Pg0KPiA+IHdoYXQgZG8geW91IHRoaW5rPw0KDQpXZSBwbGFuIHRvIGFkZCBhIG5ldyBoZWxwZXIg
ZXhmYXRfZ2V0X2VtcHR5X2RlbnRyeV9zZXQoKSwgdGhpcyBoZWxwZXIgaXMgY2FsbGVkIGJlZm9y
ZQ0Kc2V0dGluZyB0aGUgZW50cnkgdHlwZSwgaXQgY2FjaGVzIGFuZCB0aGVuIGNoZWNrcyBmb3Ig
ZW1wdHkgZW50cmllcyhDaGVjay1vbi13cml0ZSBpcyBzYWZlcg0KdGhhbiBjaGVja2luZyB3aGVu
IGxvb2tpbmcgZm9yIGVtcHR5IGRpcmVjdG9yeSBlbnRyaWVzKS4NCg0KICAgICAgIGZvciAoaSA9
IDA7IGkgPCBlcy0+bnVtX2VudHJpZXM7IGkrKykgew0KICAgICAgICAgICAgICAgZXAgPSBleGZh
dF9nZXRfZGVudHJ5X2NhY2hlZChlcywgaSk7DQogICAgICAgICAgICAgICB0eXBlID0gZXhmYXRf
Z2V0X2VudHJ5X3R5cGUoZXApOw0KICAgICAgICAgICAgICAgaWYgKHR5cGUgPT0gVFlQRV9VTlVT
RUQpDQogICAgICAgICAgICAgICAgICAgICAgIHVudXNlZF9oaXQgPSB0cnVlOw0KICAgICAgICAg
ICAgICAgZWxzZSBpZiAodHlwZSA9PSBUWVBFX0RFTEVURUQpIHsNCiAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKHVudXNlZF9oaXQpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290
byBlcnJvcjsNCiAgICAgICAgICAgICAgIH0gZWxzZQ0KICAgICAgICAgICAgICAgICAgICAgICBn
b3RvIGVycm9yOw0KICAgICAgIH0NCg0KVGhpcyBjb2RlIGlzIG5vdCByZWFkeSwgd2UgYXJlIHRl
c3RpbmcgYW5kIGludGVybmFsIHJldmlld2luZy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPg0KPiBTZW50
OiBNb25kYXksIE9jdG9iZXIgMzEsIDIwMjIgMjozMiBQTQ0KPiBUbzogU3VuZ2pvbmcgU2VvIDxz
ajE1NTcuc2VvQHNhbXN1bmcuY29tPjsgTW8sIFl1ZXpoYW5nDQo+IDxZdWV6aGFuZy5Nb0Bzb255
LmNvbT4NCj4gQ2M6IGxpbnV4LWZzZGV2ZWwgPGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3Jn
PjsgbGludXgta2VybmVsDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxIDIvMl0gZXhmYXQ6IGhpbnQgdGhlIGVtcHR5IGVudHJ5IHdoaWNo
IGF0IHRoZSBlbmQgb2YNCj4gY2x1c3RlciBjaGFpbg0KPiANCj4gQWRkIG1pc3NpbmcgQ2M6IFl1
ZXpoYW5nIE1vLg0KPiANCj4gMjAyMi0xMC0zMSAxNToxNyBHTVQrMDk6MDAsIFN1bmdqb25nIFNl
byA8c2oxNTU3LnNlb0BzYW1zdW5nLmNvbT46DQo+ID4gSGksIFl1ZXpoYW5nIE1vLA0KPiA+DQo+
ID4+IEFmdGVyIHRyYXZlcnNpbmcgYWxsIGRpcmVjdG9yeSBlbnRyaWVzLCBoaW50IHRoZSBlbXB0
eSBkaXJlY3RvcnkNCj4gPj4gZW50cnkgbm8gbWF0dGVyIHdoZXRoZXIgb3Igbm90IHRoZXJlIGFy
ZSBlbm91Z2ggZW1wdHkgZGlyZWN0b3J5DQo+ID4+IGVudHJpZXMuDQo+ID4+DQo+ID4+IEFmdGVy
IHRoaXMgY29tbWl0LCBoaW50IHRoZSBlbXB0eSBkaXJlY3RvcnkgZW50cmllcyBsaWtlIHRoaXM6
DQo+ID4+DQo+ID4+IDEuIEhpbnQgdGhlIGRlbGV0ZWQgZGlyZWN0b3J5IGVudHJpZXMgaWYgZW5v
dWdoOyAyLiBIaW50IHRoZSBkZWxldGVkDQo+ID4+IGFuZCB1bnVzZWQgZGlyZWN0b3J5IGVudHJp
ZXMgd2hpY2ggYXQgdGhlDQo+ID4+ICAgIGVuZCBvZiB0aGUgY2x1c3RlciBjaGFpbiBubyBtYXR0
ZXIgd2hldGhlciBlbm91Z2ggb3Igbm90KEFkZA0KPiA+PiAgICBieSB0aGlzIGNvbW1pdCk7DQo+
ID4+IDMuIElmIG5vIGFueSBlbXB0eSBkaXJlY3RvcnkgZW50cmllcywgaGludCB0aGUgZW1wdHkg
ZGlyZWN0b3J5DQo+ID4+ICAgIGVudHJpZXMgaW4gdGhlIG5ldyBjbHVzdGVyKEFkZCBieSB0aGlz
IGNvbW1pdCkuDQo+ID4+DQo+ID4+IFRoaXMgYXZvaWRzIHJlcGVhdGVkIHRyYXZlcnNhbCBvZiBk
aXJlY3RvcnkgZW50cmllcywgcmVkdWNlcyBDUFUNCj4gPj4gdXNhZ2UsIGFuZCBpbXByb3ZlcyB0
aGUgcGVyZm9ybWFuY2Ugb2YgY3JlYXRpbmcgZmlsZXMgYW5kDQo+ID4+IGRpcmVjdG9yaWVzKGVz
cGVjaWFsbHkgb24gbG93LXBlcmZvcm1hbmNlIENQVXMpLg0KPiA+Pg0KPiA+PiBUZXN0IGNyZWF0
ZSA1MDAwIGZpbGVzIGluIGEgY2xhc3MgNCBTRCBjYXJkIG9uIGlteDZxLXNhYnJlbGl0ZQ0KPiA+
PiB3aXRoOg0KPiA+Pg0KPiA+PiBmb3IgKChpPTA7aTw1O2krKykpOyBkbw0KPiA+PiAgICBzeW5j
DQo+ID4+ICAgIHRpbWUgKGZvciAoKGo9MTtqPD0xMDAwO2orKykpOyBkbyB0b3VjaCBmaWxlJCgo
aSoxMDAwK2opKTsgZG9uZSkNCj4gPj4gZG9uZQ0KPiA+Pg0KPiA+PiBUaGUgbW9yZSBmaWxlcywg
dGhlIG1vcmUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzLg0KPiA+Pg0KPiA+PiAgICAgICAgICAg
ICBCZWZvcmUgICBBZnRlciAgICBJbXByb3ZlbWVudA0KPiA+PiAgICAxfjEwMDAgICAyNS4zNjBz
ICAyMi4xNjhzICAxNC40MCUNCj4gPj4gMTAwMX4yMDAwICAgMzguMjQycyAgMjguNzJzcyAgMzMu
MTUlDQo+ID4+IDIwMDF+MzAwMCAgIDQ5LjEzNHMgIDM1LjAzN3MgIDQwLjIzJQ0KPiA+PiAzMDAx
fjQwMDAgICA2Mi4wNDJzICA0MS42MjRzICA0OS4wNSUNCj4gPj4gNDAwMX41MDAwICAgNzMuNjI5
cyAgNDYuNzcycyAgNTcuNDIlDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1v
IDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NCj4gPj4gUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHku
V3VAc29ueS5jb20+DQo+ID4+IFJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95
YW1hQHNvbnkuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGZzL2V4ZmF0L2Rpci5jICAgfCAyNiArKysr
KysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+PiAgZnMvZXhmYXQvbmFtZWkuYyB8IDIyICsrKysr
KysrKysrKysrLS0tLS0tLS0NCj4gPj4gIDIgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygr
KSwgMTIgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9mcy9leGZhdC9kaXIu
YyBiL2ZzL2V4ZmF0L2Rpci5jIGluZGV4DQo+ID4+IGE1NjlmMjg1ZjRmZC4uNzYwMGYzNTIxMjQ2
IDEwMDY0NA0KPiA+PiAtLS0gYS9mcy9leGZhdC9kaXIuYw0KPiA+PiArKysgYi9mcy9leGZhdC9k
aXIuYw0KPiA+PiBAQCAtOTM2LDE4ICs5MzYsMjUgQEAgc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9j
YWNoZQ0KPiA+PiAqZXhmYXRfZ2V0X2RlbnRyeV9zZXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwN
Cj4gPj4NCj4gPj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBleGZhdF9oaW50X2VtcHR5X2VudHJ5KHN0
cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSwNCj4gPj4gIAkJc3RydWN0IGV4ZmF0X2hpbnRfZmVt
cCAqY2FuZGlfZW1wdHksIHN0cnVjdCBleGZhdF9jaGFpbiAqY2x1LA0KPiA+PiAtCQlpbnQgZGVu
dHJ5LCBpbnQgbnVtX2VudHJpZXMpDQo+ID4+ICsJCWludCBkZW50cnksIGludCBudW1fZW50cmll
cywgaW50IGVudHJ5X3R5cGUpDQo+ID4+ICB7DQo+ID4+ICAJaWYgKGVpLT5oaW50X2ZlbXAuZWlk
eCA9PSBFWEZBVF9ISU5UX05PTkUgfHwNCj4gPj4gIAkgICAgZWktPmhpbnRfZmVtcC5jb3VudCA8
IG51bV9lbnRyaWVzIHx8DQo+ID4+ICAJICAgIGVpLT5oaW50X2ZlbXAuZWlkeCA+IGRlbnRyeSkg
ew0KPiA+PiArCQlpbnQgdG90YWxfZW50cmllcyA9IEVYRkFUX0JfVE9fREVOKGlfc2l6ZV9yZWFk
KCZlaS0NCj4gPj4gPnZmc19pbm9kZSkpOw0KPiA+PiArDQo+ID4+ICAJCWlmIChjYW5kaV9lbXB0
eS0+Y291bnQgPT0gMCkgew0KPiA+PiAgCQkJY2FuZGlfZW1wdHktPmN1ciA9ICpjbHU7DQo+ID4+
ICAJCQljYW5kaV9lbXB0eS0+ZWlkeCA9IGRlbnRyeTsNCj4gPj4gIAkJfQ0KPiA+Pg0KPiA+PiAt
CQljYW5kaV9lbXB0eS0+Y291bnQrKzsNCj4gPj4gLQkJaWYgKGNhbmRpX2VtcHR5LT5jb3VudCA9
PSBudW1fZW50cmllcykNCj4gPj4gKwkJaWYgKGVudHJ5X3R5cGUgPT0gVFlQRV9VTlVTRUQpDQo+
ID4+ICsJCQljYW5kaV9lbXB0eS0+Y291bnQgKz0gdG90YWxfZW50cmllcyAtIGRlbnRyeTsNCj4g
Pg0KPiA+IFRoaXMgc2VlbXMgbGlrZSBhIHZlcnkgZ29vZCBhcHByb2FjaC4gUGVyaGFwcyB0aGUg
a2V5IGZpeCB0aGF0DQo+ID4gaW1wcm92ZWQgcGVyZm9ybWFuY2Ugc2VlbXMgdG8gYmUgdGhlIGhh
bmRsaW5nIG9mIGNhc2VzIHdoZXJlIGVtcHR5DQo+ID4gc3BhY2Ugd2FzIG5vdCBmb3VuZCBhbmQg
ZW5kZWQgd2l0aCBUWVBFX1VOVVNFRC4NCj4gPg0KPiA+IEhvd2V2ZXIsIHRoZXJlIGFyZSBjb25j
ZXJucyBhYm91dCB0cnVzdGluZyBhbmQgdXNpbmcgdGhlIG51bWJlciBvZg0KPiA+IGZyZWUgZW50
cmllcyBhZnRlciBUWVBFX1VOVVNFRCBjYWxjdWxhdGVkIGJhc2VkIG9uIGRpcmVjdG9yeSBzaXpl
Lg0KPiA+IFRoaXMgaXMgYmVjYXVzZSwgdW5saWtlIGV4RkFUIFNwZWMuLCBpbiB0aGUgcmVhbCB3
b3JsZCwgdW5leHBlY3RlZA0KPiA+IFRZUEVfVU5VU0VEIGVudHJpZXMgbWF5IGV4aXN0LiA6KCBU
aGF0J3Mgd2h5IGV4ZmF0X3NlYXJjaF9lbXB0eV9zbG90KCkNCj4gPiBjaGVja3MgaWYgdGhlcmUg
aXMgYW55IHZhbGlkIGVudHJ5IGFmdGVyIFRZUEVfVU5VU0VELiBJbiBteQ0KPiA+IGV4cGVyaWVu
Y2UsIHRoZXkgY2FuIGJlIGNhdXNlZCBieSBhIHdyb25nIEZTIGRyaXZlciBhbmQgSC9XIGRlZmVj
dHMsDQo+ID4gYW5kIHRoZSBwcm9iYWJpbGl0eSBvZiBvY2N1cnJlbmNlIGlzIG5vdCBsb3cuDQo+
ID4NCj4gPiBUaGVyZWZvcmUsIHdoZW4gdGhlIGxvb2t1cCBlbmRzIHdpdGggVFlQRV9VTlVTRUQs
IGlmIHRoZXJlIGFyZSBubw0KPiA+IGVtcHR5IGVudHJpZXMgZm91bmQgeWV0LCBpdCB3b3VsZCBi
ZSBiZXR0ZXIgdG8gc2V0IHRoZSBsYXN0IGVtcHR5DQo+ID4gZW50cnkgdG8gaGludF9mZW1wLmVp
ZHggYW5kIHNldCBoaW50X2ZlbXAuY291bnQgdG8gMC4NCj4gPiBJZiBzbywgZXZlbiBpZiB0aGUg
bG9va3VwIGVuZHMgd2l0aCBUWVBFX1VOVVNFRCwNCj4gPiBleGZhdF9zZWFyY2hfZW1wdHlfc2xv
dCgpIGNhbiBzdGFydCBzZWFyY2hpbmcgZnJvbSB0aGUgcG9zaXRpb24gb2YgdGhlDQo+ID4gbGFz
dCBlbXB0eSBlbnRyeSBhbmQgY2hlY2sgd2hldGhlciB0aGVyZSBhcmUgYWN0dWFsbHkgZW1wdHkg
ZW50cmllcyBhcw0KPiA+IG1hbnkgYXMgdGhlIHJlcXVpcmVkIG51bV9lbnRyaWVzIGFzIG5vdy4N
Cj4gPg0KPiA+IHdoYXQgZG8geW91IHRoaW5rPw0KPiA+DQo+ID4+ICsJCWVsc2UNCj4gPj4gKwkJ
CWNhbmRpX2VtcHR5LT5jb3VudCsrOw0KPiA+PiArDQo+ID4+ICsJCWlmIChjYW5kaV9lbXB0eS0+
Y291bnQgPT0gbnVtX2VudHJpZXMgfHwNCj4gPj4gKwkJICAgIGNhbmRpX2VtcHR5LT5jb3VudCAr
IGNhbmRpX2VtcHR5LT5laWR4ID09IHRvdGFsX2VudHJpZXMpDQo+ID4+ICAJCQllaS0+aGludF9m
ZW1wID0gKmNhbmRpX2VtcHR5Ow0KPiA+PiAgCX0NCj4gPj4gIH0NCj4gPiBbc25pcF0NCj4gPj4g
LS0NCj4gPj4gMi4yNS4xDQo+ID4NCj4gPg0K
