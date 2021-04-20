Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B7D365786
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhDTLZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 07:25:25 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:17456 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231388AbhDTLZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:25:23 -0400
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KBOI59020617;
        Tue, 20 Apr 2021 11:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=qYGnpog+cwYJvMrXul0PjjZuNqPpEPzdy8B/8pfPBSo=;
 b=jFVXG2po9wJNigIR/JZ9OY/pHqHKTUEi1qVK/7jC/MRT+GvoPJAzXNk15YMwf0Kvr63K
 kW1kNgguTQ7ZG2maMxI3MBcwGVZ5SJlZaRc7s498gHRPECIhfXsr64elWa9Pzm6Mg3rx
 wTyj11ZT22UVKSpOhOfNOmHMn8ij1aTfWvJVOx2tYgc5eQvrwrCdv+mMJ/Gf4IaL4o/E
 FgHcVga+CtgIt6PB7bkBhDW+yYtoitbNcHws5gzS/caqTakPFMFDTvlAPEPdFeeKt9eo
 E6MRV4lsiF1CRuqKs+F2stOcv317GOBswuyaoEUBikdK8Fy4PKcIQ0KwhhLm6OlbyCLU GA== 
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173])
        by mx08-001d1705.pphosted.com with ESMTP id 37ypj1t1py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 11:24:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/7SaBxxZ2guyfLN6l2VWYmre4XltfqRhOA46cJfZ9kBH+7ClEp3mT86b6Q+i1/GhOBakLRRAS7MNRMvjlBDCdL5CoxRLHLantDd2jrUU9Hr9TR3ZfhiU2eyEMUMmf3Z97Xbz925MbXzUQZNonVWfSgh6aUKeymFI9oLOMc2cUY3xJLXkbtOi514cKsnwTMQpEXunFKVKgFgP4KCAecloUUk5BYAjDyQV9osnw9GQFE6yz1aVP3pv8dGkGqm8zsXsOlwaCEPRL+t8gfuHo2WsVGs1fhtZFy9lgyR3fXfMtblccLnm0A2FN0rYMYPpV+2wZQCsUhe50LNXs85euikIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYGnpog+cwYJvMrXul0PjjZuNqPpEPzdy8B/8pfPBSo=;
 b=LIckc8gi4rS5kQAg7XH9zYhe4T/RhRLSBz4b2d82958Wm5XD+tnSrQ8ZjkSc7XH6AYNBL+FFEMQIWtFoP2iHV0uFQXIgrw4hHybATRymJmrl5u3LwUYzxpuaf90hHvRLItiP/D8Mg0HyBuRppF8gtt2nUJmB3bUlJIHH1DMbUxyZEVbi2jUp/tyVqXnQj23FmKF7ZaERSjAEQlw+RrgrGAlmvhWM4bT8Gib+ffUBUcSldBzw/LvmMt0RPZJopIVbFnLFpQ40tE995KdapAUNfmC7yjlrNzJFzChCFkrFRIGpAN/pT/t7e9iKJW94YbncPxTeQzW8fztG3kM9Nr+ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM0P193MB0548.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:165::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 11:24:26 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 11:24:26 +0000
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
Thread-Index: AQHXM3Yw6ll+UCWErEeaPUdSTn+rzaq7xNSAgAAG/YCAACafgIAABUyAgAAHCICAAAergIAABySAgADyaoCAAAenAIAAA+2AgAAVYwCAAAK3gIAAA7YAgAAbcgCAAAWwgA==
Date:   Tue, 20 Apr 2021 11:24:26 +0000
Message-ID: <022cd9d9-8d0a-d1c4-1651-bc5e126b4760@sony.com>
References: <23aa041b-0e7c-6f82-5655-836899973d66@sony.com>
 <d70efba0-c63d-b55a-c234-eb6d82ae813f@amd.com>
 <YH2ru642wYfqK5ne@dhcp22.suse.cz>
 <07ed1421-89f8-8845-b254-21730207c185@amd.com>
 <YH59E15ztpTTUKqS@dhcp22.suse.cz>
 <b89c84da-65d2-35df-7249-ea8edc0bee9b@amd.com>
 <YH6GyThr2mPrM6h5@dhcp22.suse.cz>
 <5efa2b11-850b-ad89-b518-b776247748a4@sony.com>
 <YH6bASnaRIV4DGpI@dhcp22.suse.cz>
 <532d6d7e-372c-1524-d015-e15d79fcf11c@sony.com>
 <YH61JJOlLwBwHqVL@dhcp22.suse.cz>
In-Reply-To: <YH61JJOlLwBwHqVL@dhcp22.suse.cz>
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
x-ms-office365-filtering-correlation-id: f6c2fed6-b9b6-4401-d79a-08d903eedb0a
x-ms-traffictypediagnostic: AM0P193MB0548:
x-microsoft-antispam-prvs: <AM0P193MB0548180A605FBFDBAF3CA79186489@AM0P193MB0548.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iY01PSCdmLG62bzQXR/81hnPFVhgLhFnGDY20Nec/u4hDRSOujjDnL+nuILhaMGcquRqjGlYx865htIlX8AYl1X+PffRGUuwiPAlaIhmc8p/1wWOtUTcVnolErjl0AHIm1sw0/4HpyMcQ/XHVX6P3APkDSyfThkpTmqDNc7BOcUbCtI/cB2gG/6OBQzsw7k9w8m8vbHM44qjNodiv4aoa5i0uHfl+h1inKDAdAOrKKDIu0MVGSD/wzyhqx8eYCArXnBs9+rcwYaxRTc9sg6csQ+H37VNHVbvV+H/R/x258+AAQ0gKEAX9fK+M+1pdL3qMXVurZAClunUMi3KPKm6h42rjdopkkDYu9TsBj57WJEIWpeFiiFQrx9xEsFl82Gcw8T3JC4UQSYu2aqHL1DkSxd5P7bismQkem/Zi5DzpQduNGBsaxPiApz5jnTJgoIIWKs8owe6CmehYrDWcc4Np8p6L04jYC7JPoHszoR7XKaFN1XT8sNCO28BmW3tl6PB/ChbNKzhzfxj2kWwDJv/mTG48u/obLocqse1i3Y9Xsl0K8WDDaq5511NhTk/csS+Z1lBEBjVz4tKxRajMGIE2LtjCjaU9unDr37CHY4vK1s6Ad1RAc9btrxSedp5H4VjXlVGg3MpdDjINIGpRgivYVjoq+rP6CeE7fW3XjOrqLCO9T5Cn//UM4qAbmH2jeCr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(53546011)(71200400001)(6506007)(4326008)(8936002)(83380400001)(6512007)(76116006)(2906002)(5660300002)(36756003)(26005)(66556008)(54906003)(91956017)(66446008)(64756008)(6486002)(66476007)(6916009)(31696002)(316002)(7416002)(38100700002)(86362001)(186003)(122000001)(8676002)(2616005)(66946007)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SlN6YmJtelZidG5TUldEY2FvbVBPd3Jpd3htazYvemNVVC8zU3ZXUllTY1Qv?=
 =?utf-8?B?alVKUjRvS1orR1pEamVQV05EMzBHcUF4ZXB0cGVtdXA1NWRobFpZbDRBWnpj?=
 =?utf-8?B?NFNQcmhkNWROUE1mZEw3MnhwV2MwT3BBZkk1RzR1NzA3b29xWnFmL2Y1eVo3?=
 =?utf-8?B?a1BjTDJWSmcxelYxc1ZJVUo3akl6KzhIQ1lRU0RxdlFxbUhQTmNQWHdwSzFa?=
 =?utf-8?B?L2t0NzMxZ1EwSjZVNHZCcHV6WTRDdERUdmVXR2sxaTBYL1ltcVAvN3dKaUhu?=
 =?utf-8?B?b01aU3NwSTF4UjI2ODFCVE9raFZDNkl5TjJjTUtVQjgvQTJ2Tytjb1pVcTMw?=
 =?utf-8?B?SFZ6cVg1czJ5SjhjSzl5TjBydjVDd1ZxQTdRNWpxK2NoOWwyeGNVb3czSjR2?=
 =?utf-8?B?cDVQYWdaUUFmckhXdmN5Qmh3YngxcDdaNzJqWCtmRzBTWFp4TWZOT3N1ZXFp?=
 =?utf-8?B?blMzVzAwVy9KaG92V3Z3alE2c0gzdWFXTGphMUY1UER3blltVGdXdGVTdkhF?=
 =?utf-8?B?OGtEZE9YZnpLL3ZVRXN4SUpoY204SmdjenYrQ1NiTko3YTVYYnVNbjRna1c3?=
 =?utf-8?B?bC9yRW41VzNhVWhhOHF5Rk9QRW93MlE1RlhYNFBmQ0phNGo5am9yOVdCUFg4?=
 =?utf-8?B?R3U5bXFpbUpZcHUvTFhzR2FjMzlybkkwekN3SkM5Q2JqS1Jlc2o0SlFTMjla?=
 =?utf-8?B?a1Ricy9wR2NEZDE3SGw4M3lTZ2pnc0tBZEtGTEtlZjZYVFZMOHRuV1hUZDFZ?=
 =?utf-8?B?TFBneE0wMHA5N0U5V0I5VXpUSFkrMG02TnlvZmdNSGRuUXBVZE9aV3EzUjJK?=
 =?utf-8?B?czI3MzhJbHVHODJhRTZQQkpKbU9wejFTamQ0RkJ6QmNwQ0NlT0FHY01jeUVl?=
 =?utf-8?B?eGNiaEdzcDd2NWx6V3VMazhOWVlvUHBHYmRhbWNGNE42aXlzVE5jSktMMHd4?=
 =?utf-8?B?VDVMQ081UWR5NW0zNzRHT1pFWWxvQVM3QkY1MkhCcnh2SHRWK09VTS93eHpV?=
 =?utf-8?B?dDhNQ0w2Y01VS2wxL05mZ0V1cmhTTWVJOWVKSUhsNlpTNmNVa0VNUkk4dUEy?=
 =?utf-8?B?SjlZN3NiOS9lKzFDWFo1dURnZmY2RTRpQ2hFeWdlZkZiMmFQYm9zSHl4c05y?=
 =?utf-8?B?cE1YbEFMUXpzcFA2RnVIZWRxQ1Ywc2hnc3hLbEpLNUpjQmpnQ1BWWWY3VmFR?=
 =?utf-8?B?VnJ5OFFEeEV2MzAya3RxcTNyUUo1MGQxZUg2ejVnQjNwRlFHalFUZTl3SGpq?=
 =?utf-8?B?SkM5dnRURFVQeGtGWmV3cUdiQlJ2M0RlVW9URSttODhhNnVYUmZydTdPTG0x?=
 =?utf-8?B?QmQ1dkQrSGZ6d2FVQUk1dXhFS2tvekwveFllOUdNNEgzYTkyeGxzNWtQdlJ1?=
 =?utf-8?B?allkU2t5NDl3bEl6eVkrWEdaeDFKa2Z4SU9teWs2MUFKY2lLdUtaK0NzSmxG?=
 =?utf-8?B?QnRVOGpJMWZGMHdRZFZEcXZ2M0tkVDBHcDFiVWFGRUt4dEY0TzFMSXpFbTR3?=
 =?utf-8?B?bFAwck15d3hRSjJTc21MYUlzcnllMWtiN0VGRklOL05aNUdkTk1nODBOaTBn?=
 =?utf-8?B?T2xnUFNtT0NZRmRGcTNLT0xyUERVbFJ3elBSS0RRYUxsd0M5SkRmck5IRTFT?=
 =?utf-8?B?UWEzSytFWStyUDY5VzZ6WUdPSWMyV1RTTjhjOHZpSzZEcDN3aDhVWnZXbHNQ?=
 =?utf-8?B?b1g5d3lldWFFcVFnVDl1VlVDU2loVUZMeDVjQkRDdXBmWmpGS1B5K2taWVBC?=
 =?utf-8?Q?0Z4Bik4qVS4YrtGJlyfdnQjYDyJuIJRm21ikmiI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <47F4C5FFEDCD094EA1E2A3E64AF9663B@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c2fed6-b9b6-4401-d79a-08d903eedb0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 11:24:26.1009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHHPSKY8/0r39D7oBxdjOBx8yLqnxp88FOBzMjoVX/EdSojKCTPkG4ydwKVXrLGY58/bMPllV3QYNK/Elb+/tSZKm7TRNW6jmYi/wP+IhbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0548
X-Proofpoint-GUID: fZ2YnItzSU47GneDh7bvNoPzdjKf38EM
X-Proofpoint-ORIG-GUID: fZ2YnItzSU47GneDh7bvNoPzdjKf38EM
X-Sony-Outbound-GUID: fZ2YnItzSU47GneDh7bvNoPzdjKf38EM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_02:2021-04-19,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200088
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yMC8yMSAxOjA0IFBNLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+IE9uIFR1ZSAyMC0wNC0y
MSAwOToyNTo1MSwgUGV0ZXIuRW5kZXJib3JnQHNvbnkuY29tIHdyb3RlOg0KPj4gT24gNC8yMC8y
MSAxMToxMiBBTSwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPj4+IE9uIFR1ZSAyMC0wNC0yMSAwOTow
Mjo1NywgUGV0ZXIuRW5kZXJib3JnQHNvbnkuY29tIHdyb3RlOg0KPj4+Pj4+IEJ1dCB0aGF0IGlz
bid0IHJlYWxseSBzeXN0ZW0gbWVtb3J5IGF0IGFsbCwgaXQncyBqdXN0IGFsbG9jYXRlZCBkZXZp
Y2UNCj4+Pj4+PiBtZW1vcnkuDQo+Pj4+PiBPSywgdGhhdCB3YXMgbm90IHJlYWxseSBjbGVhciB0
byBtZS4gU28gdGhpcyBpcyBub3QgcmVhbGx5IGFjY291bnRlZCB0bw0KPj4+Pj4gTWVtVG90YWw/
IElmIHRoYXQgaXMgcmVhbGx5IHRoZSBjYXNlIHRoZW4gcmVwb3J0aW5nIGl0IGludG8gdGhlIG9v
bQ0KPj4+Pj4gcmVwb3J0IGlzIGNvbXBsZXRlbHkgcG9pbnRsZXNzIGFuZCBJIGFtIG5vdCBldmVu
IHN1cmUgL3Byb2MvbWVtaW5mbyBpcw0KPj4+Pj4gdGhlIHJpZ2h0IGludGVyZmFjZSBlaXRoZXIu
IEl0IHdvdWxkIGp1c3QgYWRkIG1vcmUgY29uZnVzaW9uIEkgYW0NCj4+Pj4+IGFmcmFpZC4NCj4+
Pj4+ICANCj4+Pj4gV2h5IGlzIGl0IGNvbmZ1c2luZz8gRG9jdW1lbnRhdGlvbiBpcyBxdWl0ZSBj
bGVhcjoNCj4+PiBCZWNhdXNlIGEgc2luZ2xlIGNvdW50ZXIgd2l0aG91dCBhIHdpZGVyIGNvbnRl
eHQgY2Fubm90IGJlIHB1dCBpbnRvIGFueQ0KPj4+IHJlYXNvbmFibGUgY29udGV4dC4gVGhlcmUg
aXMgbm8gbm90aW9uIG9mIHRoZSB0b3RhbCBhbW91bnQgb2YgZGV2aWNlDQo+Pj4gbWVtb3J5IHVz
YWJsZSBmb3IgZG1hLWJ1Zi4gQXMgQ2hyaXN0aWFuIGV4cGxhaW5lZCBzb21lIG9mIGl0IGNhbiBi
ZSBSQU0NCj4+PiBiYXNlZC4gU28gYSBzaW5nbGUgbnVtYmVyIGlzIHJhdGhlciBwb2ludGxlc3Mg
b24gaXRzIG93biBpbiBtYW55IGNhc2VzLg0KPj4+DQo+Pj4gT3IgbGV0IG1lIGp1c3QgYXNrLiBX
aGF0IGNhbiB5b3UgdGVsbCBmcm9tIGRtYS1idWQ6ICRGT08ga0IgaW4gaXRzDQo+Pj4gY3VycmVu
dCBmb3JtPw0KPj4gSXQgaXMgYmV0dGVyIHRvIGJlIGJsaW5kPw0KPiBObyBpdCBpcyBiZXR0ZXIg
dG8gaGF2ZSBhIHNlbnNpYmxlIGNvdW50ZXIgdGhhdCBjYW4gYmUgcmVhc29uZWQgYWJvdXQuDQo+
IFNvIGZhciB5b3UgYXJlIG9ubHkgY2xhaW1pbmcgdGhhdCBoYXZpbmcgc29tZXRoaW5nIGlzIGJl
dHRlciB0aGFuDQo+IG5vdGhpbmcgYW5kIEkgd291bGQgYWdyZWUgd2l0aCB5b3UgaWYgdGhhdCB3
YXMgYSBkZWJ1Z2dpbmcgb25lIG9mZg0KPiBpbnRlcmZhY2UuIEJ1dCAvcHJvYy9tZW1pbmZvIGFu
ZCBvdGhlciBwcm9jIGZpbGVzIGhhdmUgdG8gYmUgbWFpbnRhaW5lZA0KPiB3aXRoIGZ1dHVyZSBw
b3J0YWJpbGl0eSBpbiBtaW5kLiBUaGlzIGlzIG5vdCBhIGR1bXBpbmcgZ3JvdW5kIGZvciBfc29t
ZV8NCj4gY291bnRlcnMgdGhhdCBtaWdodCBiZSBpbnRlcmVzdGluZyBhdCB0aGUgX2N1cnJlbnRf
IG1vbWVudC4gRS5nLiB3aGF0DQo+IGhhcHBlbnMgaWYgc29tZWJvZHkgd2FudHMgdG8gaGF2ZSBh
IHBlciBkZXZpY2UgcmVzcC4gbWVtb3J5IGJhc2VkDQo+IGRtYS1idWYgZGF0YT8gQXJlIHlvdSBn
b2luZyB0byBjaGFuZ2UgdGhlIHNlbWFudGljIG9yIGFkZCBhbm90aGVyDQo+IDIgY291bnRlcnM/
DQoNClRoaXMgaXMgdGhlIERtYUJ1ZlRvdGFsLiBJdCBpcyB0aGUgdXBwZXIgbGltaXQuIElmIGlz
IG5vdCB0aGVyZSBpc8KgIGlzIHNvbWV0aGluZyBlbHNlLg0KDQpBbmQgd2hlbiB3ZSBoYXZlIGEg
YmV0dGVyIHJlc29sdXRpb24gb24gbWVhc3VyaW5nIGl0LCBpdCB3b3VsZCBtYWtlIHNlbnNlDQp0
byBhZGQgYSBEbWFCdWZWcmFtLCBEbWFCdWZNZW1HQyBvciB3aGF0IGV2ZXIgd2UgY2FuIHBpY2t1
cC4NCg0KVGhpcyBpcyB3aGF0IHdlIGNhbiBtZWFzdXJlIHRvZGF5Lg0K
