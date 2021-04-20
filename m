Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F1F36553F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 11:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhDTJ1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 05:27:08 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:41482 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231286AbhDTJ1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:27:06 -0400
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13K9LA3C022253;
        Tue, 20 Apr 2021 09:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=UJ+JWzB6q/CYxSJmedzFjk/OXOYucuYNoLL7UgDJql0=;
 b=E4ukGJBzg/M2z53zRkPD4gAtq5kGDHv7pjzYvGZgpLj2SFrYa4nFDzhI0dbf5iBS+Rpq
 BpdSNS09LGRjbXBIrZtj0BlzzQ2tpdg6tn84+xiXnzoC3VpKYBYDj2ZC8xRXZeMLSzgl
 8H8+3tqbdXumE/NRGxLeljnbNmItIWklFSxKBkjpFVF52JiyIrFLBMHRqIRDLtyciXXb
 Pc7DlMFwqc1cWVFmSF5JSZjyNGWBWLw5m+TjOCUMc4L/kofySSU82Dof6bH/eJ0GEkHm
 E4UMLo3QgNG1aEVOpWHmfxB631w6XvueTuZGMjE7L18H/599ljjLFASXv63r7uK6tU3t Og== 
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174])
        by mx08-001d1705.pphosted.com with ESMTP id 37yp874aht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 09:26:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euqExBtyHoVHgN5F1EeA66183G4jtQnGiLH2wteW1qAgmoed+U2w81wSKBWHPaAvFJjXZLOgIukFV8ATLTB37ryGhpKHNrdRLQQzmI2Te4K/v/oZup6rjxGJwbO2sYD14zKCBLb7kFyskMLwj8YKTR4sOMrjxm3umWDmTnbaUfmbUhK9TQ75hb02906C/6HgOK38TvJ69Zc0Clt/Ga2uCETWRp+jvzA2ODy9YQCxHRHysLd7CxHhZnPZMb1PN0zfSm5xff7zeo/IvMrl/IJvGlrT/B5pLholwqysvqRIx/usQ0a9HZ5kotpWw/1jgHXVgwTvAwydsMD9xcZt0NleBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ+JWzB6q/CYxSJmedzFjk/OXOYucuYNoLL7UgDJql0=;
 b=YcSdTHUbVeQlDyT7N1OTLjSYrwJZxf8rkIwiz13Rx0ApDDWUoR9pW3Slvs5PJE44tD6h5O2zdOrur9SnNsHe/gwSNJuo+cQQjWElSMVdSE2VM+VWtlwvP6apymOsx+be5PEXuQUJFxVMQgPv1wNePdnBhAVv+ZCY2BN1+GvICe5viNmOTG3ClkU3U1s4n2RPPYF9sXb6HzSJo+0e2ckPJcJZsUVM3unQXNaEaUdKHjAvGqRZ4VeC9C2IfK4mFtXT1W90cyrNo5gCu9smDPFOWWFg1Vi+jTvLre4my/pH39DdDT8bKKlN0Qg2z+CrUC70KfaeXqau16uxxFkrnSZEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM8P193MB0947.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 20 Apr
 2021 09:25:51 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 09:25:51 +0000
From:   <Peter.Enderborg@sony.com>
To:     <mhocko@suse.com>
CC:     <christian.koenig@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <sumit.semwal@linaro.org>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <songmuchun@bytedance.com>, <guro@fb.com>, <shakeelb@google.com>,
        <neilb@suse.de>, <samitolvanen@google.com>, <rppt@kernel.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <willy@infradead.org>
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Topic: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Index: AQHXM3Yw6ll+UCWErEeaPUdSTn+rzaq7xNSAgAAG/YCAACafgIAABUyAgAAHCICAAAergIAABySAgADyaoCAAAenAIAAA+2AgAAVYwCAAAK3gIAAA7YA
Date:   Tue, 20 Apr 2021 09:25:51 +0000
Message-ID: <532d6d7e-372c-1524-d015-e15d79fcf11c@sony.com>
References: <c3f0da9c-d127-5edf-dd21-50fd5298acef@sony.com>
 <YH2a9YfRBlfNnF+u@dhcp22.suse.cz>
 <23aa041b-0e7c-6f82-5655-836899973d66@sony.com>
 <d70efba0-c63d-b55a-c234-eb6d82ae813f@amd.com>
 <YH2ru642wYfqK5ne@dhcp22.suse.cz>
 <07ed1421-89f8-8845-b254-21730207c185@amd.com>
 <YH59E15ztpTTUKqS@dhcp22.suse.cz>
 <b89c84da-65d2-35df-7249-ea8edc0bee9b@amd.com>
 <YH6GyThr2mPrM6h5@dhcp22.suse.cz>
 <5efa2b11-850b-ad89-b518-b776247748a4@sony.com>
 <YH6bASnaRIV4DGpI@dhcp22.suse.cz>
In-Reply-To: <YH6bASnaRIV4DGpI@dhcp22.suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23f5d43f-e557-43b1-20fa-08d903de4a63
x-ms-traffictypediagnostic: AM8P193MB0947:
x-microsoft-antispam-prvs: <AM8P193MB0947CED05410D4B4A8C78E0E86489@AM8P193MB0947.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +E3F98XG390jDbx5thGC/AB2sJ3pV2zIddgClugoha2ex4FJTH1I40NjtK36CQavgaRgALXOxua1IxH+WtOun9JKPfHcX9X7aIsmSJ0KnoiiI0z49Bf7uCRg29Z6RaEFYIXj7SQkt5BD9Hr6tQURxoSKTM8XGkVKKq6RNR5NDNELZUPBmm5jBSZJ61NsJAZdQDhh/jzsJAcydSaMl0K3IsEHJagESjjh/n1kkyj0Eh6EDu1jr8GGe7i4+xSz3Q/KAMPGBVc2lbRKj0nj8c/d3fGjbyLtpAfOP6LjTHuYWcHbVJbokhVkhAQjrX55m8xHJqauBQza9Am2BInjEX3zPR2CZ7bPcVYRZAhv4oYouHuB49p9qaDFBdYvEvJ5YRMX+Th7UwV9QiZj+0n8zespHSl2+CYKSblRbH8kha0fuuUSiNDd5b7m//qPc7EXJijKWxdNvYNXOkrQWHVFXjSK6d+YM6K5C0VdJ8W7/hI3KNUYb/gA1EV/+vH4J+wWns3qRxgA9OjKO8nt+VXmRLUoyjQpxDa9nLeTq5FSfIu1M/yZDEl5/bBI7PtsJ12/gDcRy5X0geywkGigwE2191n3EhlAu3aifiVvCr5mCnBy+UtJjLVdWZPwTb7ceWbe/vvkdEAdZ9DW2pFfGtVrM1acgjxy6zgG9hyI3W3a/wnSdSJ5DU6w2Zl7ocR4UD0jfMEe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(6512007)(8676002)(7416002)(8936002)(36756003)(186003)(38100700002)(6506007)(2906002)(31696002)(64756008)(66446008)(31686004)(86362001)(2616005)(6916009)(83380400001)(66556008)(53546011)(66476007)(122000001)(4326008)(316002)(5660300002)(6486002)(478600001)(54906003)(26005)(66946007)(76116006)(91956017)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UkRGK2xzVDh3MnpteVVFMlJTS3JzSThPVTZpQVRNM09Pa0E4aldBWTFVTnVr?=
 =?utf-8?B?M2hIZGkySTRxMFNEUGdzUFpYK0FlTVdWV3V6bWJJY2h2enhXNlZWMy83SUlk?=
 =?utf-8?B?TDhlL1pOQmRoOEhMUU83NElvQW5XOGt4dXA5R1ZmNkJlOUcvYm1LNGZEQlNJ?=
 =?utf-8?B?ektaOTNOTHVmaHZnZkZCb3F6dDNCeEd6Vy9OMFdZTUtTUko2Y1NzK2VUcTly?=
 =?utf-8?B?ZUtOUHo1RHg3djlRc01hZHdIeC9jK3ZNMzNmRENKZHJvb0U1U0JkR1drSzFG?=
 =?utf-8?B?TjNmRHBxVXN1SzJGMHhiUkRlTWxkbUZhMm9tY3JyNGNzdFI0bm04M1BLTXNO?=
 =?utf-8?B?TisxOVB3dThFS01KUjJvOHdzMlVLay9qajhvQmFydUgrZk1sRG8zYnFwNi9I?=
 =?utf-8?B?U3A1YmFtYytQYzZPVGRVSXBCT2gycUVSaFRwRWZmTENreno2cnFMODFuNTJo?=
 =?utf-8?B?T1U4dSt2KzVBOG5Wby9ZNDlITC9jMHAwWjB5bWpQc3prQWJmQzRUbEdzeUc2?=
 =?utf-8?B?NnMycEk5eU5zVXEwY2ZTdEFLcUVPa3BEUnBBZWZLZk1FeHljUnUrcVdWTWtv?=
 =?utf-8?B?S1pTZlFWZThyTUdWN1NsZDBudXkxYU91RXBHODZvV0doaWNOeFVOTzROTFgw?=
 =?utf-8?B?RDJpL2RJb2M2MCtJcWh3L3JaY2xKUjBZUDZJcDQwbTdyb3dTcEpjRFZvTjkx?=
 =?utf-8?B?THd0TUV4MHZvNHk4dXJsZzcvWi9vM0JTNGpvWjBxeUVxOUY5THVINnFodWVP?=
 =?utf-8?B?OGN3SU5MYi90Mi9RRXZkRm0yaWxpMkE3TXkvZ1JkZHFaQktGVm1NblNrZVpI?=
 =?utf-8?B?SjRoV01TSU5NaGFCUlJ4dlhaN2Vrc2t4MCsyRURKNjZ0T3FkM0J1RkQ3VjdJ?=
 =?utf-8?B?SCtEdldVbitsTE1QWktKK2hXZUxIYzU4bFdGd0xSODh2Y1Uwb1c0a1UwZHRa?=
 =?utf-8?B?ejQ5N2w3enB0RWk3c2dTSzJPaVhqMkdqZkJST251aFdOZmltcUFGMmhnbTJS?=
 =?utf-8?B?bVpqendaWXR2R2drY1NpcW83dnhVWHR5TEI0cmdpU21pc1BQKzVDVEJmUFdk?=
 =?utf-8?B?N0NvcnJraTZmcVE0SmNVRU1LdEJqa2tObi95UXpDbU5aOXJQNFdmdjZvSnlT?=
 =?utf-8?B?Z1pYWEZ2NWdjc2lPK2VRTlhrSC9mRGVvL2U1dC82MVB2anhZRXhlTnFQYWtu?=
 =?utf-8?B?b0RPU1daOG9hUm5vVThqcXlUNG9CYzI1N2w3N1BYZzlaaldGakRqN1VzRTNu?=
 =?utf-8?B?WHh5U1llS1JMTGsrUXc1VHVHNUF1VGl5MjdNQnRjd3JHYnBrM3Ftc3MxU1JT?=
 =?utf-8?B?eUdZTmV5aHJxaDk1S3BpNW1Kc2ZkTTFSWElheTl1VHpZcWY3cFRjcUo0RnRl?=
 =?utf-8?B?ODFkend5ZGZuMGRra09CMDBteGY0alNRMG1vVEh2RnlFQkhvN1QvcXdOYVdl?=
 =?utf-8?B?b2tNU1JWdlJGM2pnV3g5RzV0QldtaVNIRnFXMkx6UHhzQjcwTnBZVTFZUEZC?=
 =?utf-8?B?ektTcWZzajRQSlZNUGhwSzRUZTg1Q0pJalpXSFV6bmpBSSs4NmFkM3F4aFVx?=
 =?utf-8?B?RFFNd1p6OWtIWG5GeU1YemorRVJjckFuWTZYL3loRk0wMkZ3a3RveHptblQ4?=
 =?utf-8?B?S1dzd0QzL3NkN1RkTGE3NWJkM0tQaEtlZUtwQXVDNzRJOU9qTklWUytDOHFE?=
 =?utf-8?B?bi9ZaGg2NGd6TEREWTdRL09TL2FZSkppb2hSOXZMeFROK0NBTTkvTVB5QWhy?=
 =?utf-8?Q?8o+kkuzjGrFfQzXYDyWY1vsKSfJPq49ZWcyYcIL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8D68F5E8AC60A4DAADDC833B55A60F3@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f5d43f-e557-43b1-20fa-08d903de4a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 09:25:51.4423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svMc/V/lCe5JD9kfmldC4Jy71NfHvgqWp6WVo7B4T/In2hhESG0YkN4UAy5hYgJX4fiJDu9v/64fIrATr6M913VWSjJ0DCbyd+bNNBR8C8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0947
X-Proofpoint-ORIG-GUID: -praFHEcw2BLvc3bLZ5tZrcvS-YfjRM7
X-Proofpoint-GUID: -praFHEcw2BLvc3bLZ5tZrcvS-YfjRM7
X-Sony-Outbound-GUID: -praFHEcw2BLvc3bLZ5tZrcvS-YfjRM7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_02:2021-04-19,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200070
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yMC8yMSAxMToxMiBBTSwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPiBPbiBUdWUgMjAtMDQt
MjEgMDk6MDI6NTcsIFBldGVyLkVuZGVyYm9yZ0Bzb255LmNvbSB3cm90ZToNCj4+Pj4gQnV0IHRo
YXQgaXNuJ3QgcmVhbGx5IHN5c3RlbSBtZW1vcnkgYXQgYWxsLCBpdCdzIGp1c3QgYWxsb2NhdGVk
IGRldmljZQ0KPj4+PiBtZW1vcnkuDQo+Pj4gT0ssIHRoYXQgd2FzIG5vdCByZWFsbHkgY2xlYXIg
dG8gbWUuIFNvIHRoaXMgaXMgbm90IHJlYWxseSBhY2NvdW50ZWQgdG8NCj4+PiBNZW1Ub3RhbD8g
SWYgdGhhdCBpcyByZWFsbHkgdGhlIGNhc2UgdGhlbiByZXBvcnRpbmcgaXQgaW50byB0aGUgb29t
DQo+Pj4gcmVwb3J0IGlzIGNvbXBsZXRlbHkgcG9pbnRsZXNzIGFuZCBJIGFtIG5vdCBldmVuIHN1
cmUgL3Byb2MvbWVtaW5mbyBpcw0KPj4+IHRoZSByaWdodCBpbnRlcmZhY2UgZWl0aGVyLiBJdCB3
b3VsZCBqdXN0IGFkZCBtb3JlIGNvbmZ1c2lvbiBJIGFtDQo+Pj4gYWZyYWlkLg0KPj4+ICANCj4+
IFdoeSBpcyBpdCBjb25mdXNpbmc/IERvY3VtZW50YXRpb24gaXMgcXVpdGUgY2xlYXI6DQo+IEJl
Y2F1c2UgYSBzaW5nbGUgY291bnRlciB3aXRob3V0IGEgd2lkZXIgY29udGV4dCBjYW5ub3QgYmUg
cHV0IGludG8gYW55DQo+IHJlYXNvbmFibGUgY29udGV4dC4gVGhlcmUgaXMgbm8gbm90aW9uIG9m
IHRoZSB0b3RhbCBhbW91bnQgb2YgZGV2aWNlDQo+IG1lbW9yeSB1c2FibGUgZm9yIGRtYS1idWYu
IEFzIENocmlzdGlhbiBleHBsYWluZWQgc29tZSBvZiBpdCBjYW4gYmUgUkFNDQo+IGJhc2VkLiBT
byBhIHNpbmdsZSBudW1iZXIgaXMgcmF0aGVyIHBvaW50bGVzcyBvbiBpdHMgb3duIGluIG1hbnkg
Y2FzZXMuDQo+DQo+IE9yIGxldCBtZSBqdXN0IGFzay4gV2hhdCBjYW4geW91IHRlbGwgZnJvbSBk
bWEtYnVkOiAkRk9PIGtCIGluIGl0cw0KPiBjdXJyZW50IGZvcm0/DQoNCkl0IGlzIGJldHRlciB0
byBiZSBibGluZD8gVGhlIHZhbHVlIGNhbiBzdGlsbCBiZSB1c2VkIGEgcmVsYXRpdmUgbWV0cmlj
Lg0KWW91IGNvbGxlY3QgdGhlIGRhdGEgYW5kIHNlZSBob3cgaXQgY2hhbmdlLiBBbmQgd2hlbiB5
b3Ugc2VlDQphIHVuZXhwZWN0ZWQgY2hhbmdlIHlvdSBzdGFydCB0byBkaWcgaW4uIEl0IGZvcmUg
c3VyZSB3b250IHRlbGwgd2hhdCBsaW5lDQppbiB5b3VyIGFwcGxpY2F0aW9uIHRoYXQgaGFzIGEg
YnVnLsKgIEJ1dCBpdCBtaWdodCBiZSBhbiBpbmRpY2F0b3IgdGhhdA0KYSBuZXcgZ2FtZSB0cmln
Z2VyIGEgbGVhay4gQW5kIGl0IGlzIHZlcnkgd2VsbCBzcGVjaWZpZWQsIGl0IGV4YWN0bHkgdGhl
DQpzaXplIG9mIG1hcHBlZCBkbWEtYnVmLiBGb3Igd2hhdCB5b3UgdXNlIGRtYS1idWYgeW91IG5l
ZWQgdG8ga25vdw0Kb3RoZXIgcGFydHMgb2YgdGhlIHN5c3RlbS4NCg==
