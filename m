Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522DD368226
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 16:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhDVOKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 10:10:15 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:21130 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236092AbhDVOKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:10:14 -0400
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13ME0R5w023601;
        Thu, 22 Apr 2021 14:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=ikZP6ECXJVeil4mEE8Q8HzWCMtUOKauDwSbCMQULQY4=;
 b=EipjOvRFRIZn/AKiLT05GWdqY19QQecDU1EPi5YHvrDt4Rr++ULTi8H4kgU8nEBQX77/
 aVqHpr6ugmQH3Cj6Qrd5kKDp9RzTvPjeVqP8S7waKT1smIpphCn271J8DDcwlBOW8uIR
 RV+6axMY2/YF4Vx+xfEAeZ/tQDbUpHD/hu6/3uJPrwJr9gCFBlzzFwrVR4rYw7OgfnlN
 lMF0cTQWJ7Ynw1ZKylx8gdZs4klCBjOTAFGX1Kdf+yTRZsc6etBFhTDVYgH+eoj87kNU
 1PT1IC/YMbwmvJ+BNdPNaUf54CyUsinRIZCLlVbCDdUxkFavcU7Roj8P2LJ+0cZ3ovCw Kw== 
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56])
        by mx08-001d1705.pphosted.com with ESMTP id 382dwgaepc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 14:09:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1dhItlUUFaaWvYplLYyYbO9R6ax4jxDMhW/Po1gEq4KT7oja/01nGKf972f79nun3En5e2TzIiVOXAc8SGrSdBLlHmXQC3DUikJAUEKLp5hbsCcVYWI0Ho+4aQLuaQiPUzMJ/9ifZgZOhhZ7KPHQBx7PWl2tGjTsvPKSZ6XI0/72hWezlDTAV1SjDn11cp8eb/Ml88sezAoZCeDoyPJN2OKR5x70wowcag/Bm7GGCUudMGCN1UBqQFBeG+tj3svejfua6yLM1+aUJPsOtWunKRmyiD+FWrgLxnjFsm5PbiKV3vz4cOyGDqptanh33AEY3qUA4CJc5ZeRiWQvCzMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikZP6ECXJVeil4mEE8Q8HzWCMtUOKauDwSbCMQULQY4=;
 b=Nmh+p+vAQ7AL1WX4Qap0nwRxu+dcz/ZFOHSCnhCfm/LN9TkJU/TjD4yALzKfDwMw06PGvQqlf6rZXaVzosQk+edEBkxwKD9qWKR+UqEVaOi+C/lTHoJP8dNOgGXwrjXoXpUJ9H/HFY1TphWWZkILjkMmk+4w8xhIQn0u4hQkQxsDpQlPqvrInaaDm3azYJhJgfCbJglAT6RRcXVYg268RSYN86D/DA7HY9UUjj4+7ZIR5PonAdEDMoWoYKnqeOJHn9lu0ZQOztkQqOWUDseg9SA69kiuC099jWXaHb/miI7MDg7R4LGT4iUUCKIA/tcw8gUY947QyPiArHU9z1Kv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM9P193MB1809.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 22 Apr
 2021 14:08:51 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 14:08:51 +0000
From:   <Peter.Enderborg@sony.com>
To:     <rppt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sumit.semwal@linaro.org>, <christian.koenig@amd.com>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <songmuchun@bytedance.com>, <guro@fb.com>, <shakeelb@google.com>,
        <mhocko@suse.com>, <neilb@suse.de>, <samitolvanen@google.com>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <willy@infradead.org>
Subject: Re: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Topic: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Index: AQHXM6gnmsuLu+Ufhk6GusLEaztxYKq9H2WAgAAHpACAAB5AAIAABooAgAFqggCAABbkAIAAUmUAgAAinACAAPM+AIAAZTkA
Date:   Thu, 22 Apr 2021 14:08:51 +0000
Message-ID: <ae091d3d-623b-ce18-e0f2-1591be6db83e@sony.com>
References: <20210417163835.25064-1-peter.enderborg@sony.com>
 <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
 <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
 <YH63iPzbGWzb676T@phenom.ffwll.local>
 <a60d1eaf-f9f8-e0f3-d214-15ce2c0635c2@sony.com>
 <YH/tHFBtIawBfGBl@phenom.ffwll.local>
 <cbde932e-8887-391f-4a1d-515e5c56c01d@sony.com> <YIBFbh4Dd1XaDbto@kernel.org>
 <84e0c6d9-74c6-5fa8-f75a-45c8ec995ac2@sony.com> <YIEugg9RIVSReN97@kernel.org>
In-Reply-To: <YIEugg9RIVSReN97@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e902d58a-9e96-4a76-741a-08d9059827ea
x-ms-traffictypediagnostic: AM9P193MB1809:
x-microsoft-antispam-prvs: <AM9P193MB1809AD5E1C9792AD904243AB86469@AM9P193MB1809.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RIiG+PVojurvMsLQqegTHARvadsYPrwCbBMP1dD6uDSHQtsvDG3ihgDMgv8FKlXJf3xR9i02PekJ/LMt9BlpxU+v2kxSfG+umMl5O6wgRyoy0kdCo8Z615bnUJTE63FG+4BLOa3DabLOwdC9xgDQ/85bJE+AwGW2OnV9E2GP2EJR45cd5vMMc3CHiIl8hFzLQhY4+lZL21zoxR5kKONT18wVWGusUcmzK1/KELsJXIQSwTrtTIfSYe5V8O2Q2XJYPJSiPckEslpYi3UCrL5HsFQVft1DC3J8ie9v4D+98rHwv140BBzhvtTZUIgb4woFnL8CXwnBlAFHQXqEdglyNrjsKpH/cEegjDwmjSxxK8gQXzanIe089pH026WxBlZsI63S0LqIBkuBM5UVVE0iToLWSsgY835g2QgywZO5R0xoaaNBAh5Sc9/ksD4X7W258Fd87wm5bRS2IpGBg/cYct8oSAbveh9rez/oilaoTH/fXDwhfZ/1lCepjmpd3ROa8TsOl+q91SoEITHpviiAi87y/HyZpbL/8b02ftOhBFR5lbm2STbUBAgdMagAxhHx7y7+o+aqA0+GPfCjokSDAB3sBO7vP42j0NF6MDIkOrCarYDpgeE4QLJv3cKFKosY9W9lzLsYFEwVkgr+nCWkUQSZE6WmloagY81MP7aFolkKXz2NrXuktdiYefr/Sj+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(122000001)(6486002)(478600001)(26005)(6512007)(38100700002)(186003)(2616005)(6916009)(53546011)(8936002)(8676002)(6506007)(4326008)(86362001)(54906003)(71200400001)(66946007)(316002)(66446008)(76116006)(91956017)(7416002)(64756008)(66476007)(83380400001)(66556008)(2906002)(5660300002)(31686004)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YlF4SzhMRk5QWkRFZm90Skozc3BrYlEyNm1GdFc4L0p2WlRxSDRlQkF1MmFX?=
 =?utf-8?B?d2F0QzYwdnJRSlNtMkdNVFNPS2Q5eHhxay9KZkEyQWc1c3pIb1VrR1Y2Smdw?=
 =?utf-8?B?WmNqRTlGK1RjbXpGZFN3RWVDL3Q4cENmdmF5Y0UzTUMxZHRSZVdNMExKQ09Z?=
 =?utf-8?B?Vi9uTUlwWEw5S0ZhYWw5WFU0OUcvTFFZUEZzK203K3FZdVBnRkJMMlBvbUZX?=
 =?utf-8?B?SXl0NVFUaUlaK0ZCYWdLQzdhS0NYaHVmeDVZTjlITUN4Smx6YUJIcXVibHc0?=
 =?utf-8?B?ZVNoZ1k4Zk9GYmh4cUl4MkFoRytJMitmd0VzSVpJZm1ESXpaMTZBOW9hcUda?=
 =?utf-8?B?RWUvMU1qRlNqRlBDVkdCTkhhQzNxbjVDRXREendyRGR1aVlIZ0NZWHFscUw4?=
 =?utf-8?B?VmNBWGZJRW12NEhDU0FsN3ZPWlYwdS9rUlZoUVIvU2NOdGxFcUEwTnk1UFNC?=
 =?utf-8?B?NW1KZFhUdjI3cmx3OEMxVzNpOWVuNVBtZjlGTFR4dnZXRlRvb3ZUUE1RazUw?=
 =?utf-8?B?Y3VqR3BiYUt6c0wrTTQ2alNJcCtQSVZVd2NadDJrRmJBaGdhOS9pVDRZK2tI?=
 =?utf-8?B?UWlsSGplSzI1WUFnY0xFRzQyN3JGVVVlT2FWdzBaRzBqQnZBdFJJR29reWZu?=
 =?utf-8?B?RXh1eWZWT0FNN3lrc2pLdkZTOHBsa3NxY0EwWTN0M2pldmxmYWVoV3RLQUgw?=
 =?utf-8?B?SlVqZjFLQ2E2dDNtRFJxa2hlOW5tT2NFVkZhTWllcnVLSnY1MnpadjA5ZG5E?=
 =?utf-8?B?VE90K3IycWxSUm5HejkxU2FhNUd6M1pJd2pqajJzRnlhZEl3c0RTd25xNmxP?=
 =?utf-8?B?aXM5dXprbThPcVh3S1ppS0VqNzN6bHN6VkQxYWNiSWRmKzl0VDhOcEduMHVD?=
 =?utf-8?B?cVJ2NTNXd0hFZEtJVGZ4L2t1bFFBTjVsOXlqUFdoeTA5WTdYalNrRlVvYTgv?=
 =?utf-8?B?NDNRWlVFeGRRUEk1d2RMZGhPVk5TMGltRU84SnZsQU1WamRsZ0FLRHg1V2NJ?=
 =?utf-8?B?ZkI5bk1KdVlneTA4ZmxSQndkeWJKa0tJOEtkTXF2SXZmL1lCdTNRbHIvc0V1?=
 =?utf-8?B?akNOd05oeW81ZUsrUjZHZWIycGxsRDVPa1F1ak5aMHQ1bHpJa0VpNXk4eEhF?=
 =?utf-8?B?K1FRNmdLR3o2c2hCeS94UmloNHpicm9aNVhtNVZPOFJLWlBKb0VBS0g5ckxo?=
 =?utf-8?B?KzZnTWdnYk9ISC9nNFdmU0pna3ppbEhMdUhXcXFMblduWDFhdXYyS0FpOHZR?=
 =?utf-8?B?VHBhbmhtbStsQURpY2M5MWhjaURZak1kVmhpWURhV0l6WVNmeCtvNk05aHNk?=
 =?utf-8?B?bk9vbS94b0NyYW5GQUpuQUJCQ3dvVHhoYkpEY1hlQ1BuVXQ3MjZ4MG4vb0FX?=
 =?utf-8?B?OW5rMmVUSTQ1Vm1DS2VQL1VTZGQzZ3hUNlRFK1R1ZWZHZ1JnNFdUOXR0RUp5?=
 =?utf-8?B?Y2xIMFA2Y2xxWVpiNEg4SWRrRVNGUTFSQ01JeGsrTThXSnBoNTNMbTF0MlJW?=
 =?utf-8?B?Q0lFeFlnWDNlRHRKdTB5N21mbG1JWUpJVHVRYkNlek5nS2FYbUNoT0RvUGUw?=
 =?utf-8?B?dzVwUHphK2lLWXpqbzVlaWw4TFFVOEdEY1VIT2w2MisvbVlhcGtVOWhGVU5H?=
 =?utf-8?B?SjBkempjQlh2R1JkeDV1a2dyMGJ0RUtmS1pKbmlDV2dnSlFCRkRUTVpPeTJ3?=
 =?utf-8?B?OTFMV251SUpVaDc1Zm1kRmxPVFB4YkZReXN2RmE5QjdNWGJ5Yi9wbmtYdWNz?=
 =?utf-8?Q?iuM5PjaH1yRurXSr2s6Mp34Zi6d+T1V6err1RS0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BD10E29750DE64E88193D77C783BC3B@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e902d58a-9e96-4a76-741a-08d9059827ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 14:08:51.1245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNOT9A5R0vBkDCfQA0IeXQ7IUOR1G5qMFCqZPDMywuZetkIqSx7YkBNq4XyQaWHsSgbPRUQEMlOdtn+/TqPGa6Ag+jBdySVhj+G7ACMhrho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1809
X-Proofpoint-GUID: W_i3PPDMQWPl7A1YdOyKxgSF2VXimEJd
X-Proofpoint-ORIG-GUID: W_i3PPDMQWPl7A1YdOyKxgSF2VXimEJd
X-Sony-Outbound-GUID: W_i3PPDMQWPl7A1YdOyKxgSF2VXimEJd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_06:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220115
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yMi8yMSAxMDowNiBBTSwgTWlrZSBSYXBvcG9ydCB3cm90ZToNCj4gT24gV2VkLCBBcHIg
MjEsIDIwMjEgYXQgMDU6MzU6NTdQTSArMDAwMCwgUGV0ZXIuRW5kZXJib3JnQHNvbnkuY29tIHdy
b3RlOg0KPj4gT24gNC8yMS8yMSA1OjMxIFBNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPj4+IE9u
IFdlZCwgQXByIDIxLCAyMDIxIGF0IDEwOjM3OjExQU0gKzAwMDAsIFBldGVyLkVuZGVyYm9yZ0Bz
b255LmNvbSB3cm90ZToNCj4+Pj4gT24gNC8yMS8yMSAxMToxNSBBTSwgRGFuaWVsIFZldHRlciB3
cm90ZToNCj4+Pj4+IFdlIG5lZWQgdG8gdW5kZXJzdGFuZCB3aGF0IHRoZSAiY29ycmVjdCIgdmFs
dWUgaXMuIE5vdCBpbiB0ZXJtcyBvZiBrZXJuZWwNCj4+Pj4+IGNvZGUsIGJ1dCBpbiB0ZXJtcyBv
ZiBzZW1hbnRpY3MuIExpa2UgaWYgdXNlcnNwYWNlIGFsbG9jYXRlcyBhIEdMIHRleHR1cmUsDQo+
Pj4+PiBpcyB0aGlzIHN1cHBvc2VkIHRvIHNob3cgdXAgaW4geW91ciBtZXRyaWMgb3Igbm90LiBT
dHVmZiBsaWtlIHRoYXQuDQo+Pj4+IFRoYXQgaXQgbGlrZSB0aGF0IHdvdWxkIGxpa2UgdG8gb25s
eSBvbmUgcG9pbnRlciB0eXBlLiBZb3UgbmVlZCB0byBrbm93IHdoYXQNCj4+Pj4NCj4+Pj4geW91
IHBvaW50aW5nIGF0IHRvIGtub3cgd2hhdCBpdCBpcy4gaXQgbWlnaHQgYmUgYSBoYXJkd2FyZSBv
ciBhIG90aGVyIHBvaW50ZXIuDQo+Pj4+DQo+Pj4+IElmIHRoZXJlIGlzIGEgbGltaXRhdGlvbiBv
biB5b3VyIHBvaW50ZXJzIGl0IGlzIGEgZ29vZCBtZXRyaWMgdG8gY291bnQgdGhlbQ0KPj4+PiBl
dmVuIGlmIHlvdSBkb24ndMKgIGtub3cgd2hhdCB0aGV5IGFyZS4gU2FtZSBnb2VzIGZvciBkbWEt
YnVmLCB0aGV5DQo+Pj4+IGFyZSBnZW5lcmljLCBidXQgdGhleSBjb25zdW1lIHNvbWUgcmVzb3Vy
Y2VzIHRoYXQgYXJlIGNvdW50ZWQgaW4gcGFnZXMuDQo+Pj4+DQo+Pj4+IEl0IHdvdWxkIGJlIHZl
cnkgZ29vZCBpZiB0aGVyZSBhIHN1YiBkaXZpc2lvbiB3aGVyZSB5b3UgY291bGQgbWVhc3VyZQ0K
Pj4+PiBhbGwgcG9zc2libGUgdHlwZXMgc2VwYXJhdGVseS7CoCBXZSBoYXZlIHRoZSBkZXRhaWxl
ZCBpbiBkZWJ1Z2ZzLCBidXQgbm90aGluZw0KPj4+PiBmb3IgdGhlIHVzZXIuIEEgc3VtbWFyeSBp
biBtZW1pbmZvIHNlZW1zIHRvIGJlIHRoZSBiZXN0IHBsYWNlIGZvciBzdWNoDQo+Pj4+IG1ldHJp
Yy4NCj4+PiAgDQo+Pj4gTGV0IG1lIHRyeSB0byBzdW1tYXJpemUgbXkgdW5kZXJzdGFuZGluZyBv
ZiB0aGUgcHJvYmxlbSwgbWF5YmUgaXQnbGwgaGVscA0KPj4+IG90aGVycyBhcyB3ZWxsLg0KPj4g
VGhhbmtzIQ0KPj4NCj4+DQo+Pj4gQSBkZXZpY2UgZHJpdmVyIGFsbG9jYXRlcyBtZW1vcnkgYW5k
IGV4cG9ydHMgdGhpcyBtZW1vcnkgdmlhIGRtYS1idWYgc28NCj4+PiB0aGF0IHRoaXMgbWVtb3J5
IHdpbGwgYmUgYWNjZXNzaWJsZSBmb3IgdXNlcnNwYWNlIHZpYSBhIGZpbGUgZGVzY3JpcHRvci4N
Cj4+Pg0KPj4+IFRoZSBhbGxvY2F0ZWQgbWVtb3J5IGNhbiBiZSBlaXRoZXIgYWxsb2NhdGVkIHdp
dGggYWxsb2NfcGFnZSgpIGZyb20gc3lzdGVtDQo+Pj4gUkFNIG9yIGJ5IG90aGVyIG1lYW5zIGZy
b20gZGVkaWNhdGVkIFZSQU0gKHRoYXQgaXMgbm90IG1hbmFnZWQgYnkgTGludXggbW0pDQo+Pj4g
b3IgZXZlbiBmcm9tIG9uLWRldmljZSBtZW1vcnkuDQo+Pj4NCj4+PiBUaGUgZG1hLWJ1ZiBkcml2
ZXIgdHJhY2tzIHRoZSBhbW91bnQgb2YgdGhlIG1lbW9yeSBpdCB3YXMgcmVxdWVzdGVkIHRvDQo+
Pj4gZXhwb3J0IGFuZCB0aGUgc2l6ZSBpdCBzZWVzIGlzIGF2YWlsYWJsZSBhdCBkZWJ1Z2ZzIGFu
ZCBmZGluZm8uDQo+Pj4NCj4+PiBUaGUgZGVidWdmcyBpcyBub3QgYXZhaWxhYmxlIHRvIHVzZXIg
YW5kIG1heWJlIGVudGlyZWx5IGRpc2FibGVkIGluDQo+Pj4gcHJvZHVjdGlvbiBzeXN0ZW1zLg0K
Pj4+DQo+Pj4gVGhlcmUgY291bGQgYmUgcXVpdGUgYSBmZXcgb3BlbiBkbWEtYnVmcyBzbyB0aGVy
ZSBpcyBubyBvdmVyYWxsIHN1bW1hcnksDQo+Pj4gcGx1cyBmZGluZm8gaW4gcHJvZHVjdGlvbiBz
eXN0ZW1zIHlvdXIgcmVmZXIgdG8gaXMgYWxzbyB1bmF2YWlsYWJsZSB0byB0aGUNCj4+PiB1c2Vy
IGJlY2F1c2Ugb2Ygc2VsaW51eCBwb2xpY3kuDQo+Pj4NCj4+PiBBbmQgdGhlcmUgYXJlIGEgZmV3
IGRldGFpbHMgdGhhdCBhcmUgbm90IGNsZWFyIHRvIG1lOg0KPj4+DQo+Pj4gKiBTaW5jZSBEUk0g
ZGV2aWNlIGRyaXZlcnMgc2VlbSB0byBiZSB0aGUgbWFqb3IgdXNlciBvZiBkbWEtYnVmIGV4cG9y
dHMsDQo+Pj4gICB3aHkgY2Fubm90IHdlIGFkZCBpbmZvcm1hdGlvbiBhYm91dCB0aGVpciBtZW1v
cnkgY29uc3VtcHRpb24gdG8sIHNheSwNCj4+PiAgIC9zeXMvY2xhc3MvZ3JhcGhpY3MvZHJtL2Nh
cmRYL21lbW9yeS11c2FnZT8NCj4+IEFuZHJvaWQgaXMgdXNpbmcgaXQgZm9yIGJpbmRlciB0aGF0
IGNvbm5lY3QgbW9yZSBvciBsZXNzIGV2ZXJ5dGhpbmcNCj4+IGludGVybmFsbHkuDQo+ICANCj4g
T2ssIHRoZW4gaXQgcnVsZXMgb3V0IC9zeXMvY2xhc3MvZ3JhcGhpY3MgaW5kZWVkLg0KPg0KPj4+
ICogSG93IGV4YWN0bHkgdXNlciBnZW5lcmF0ZXMgcmVwb3J0cyB0aGF0IHdvdWxkIGluY2x1ZGUg
dGhlIG5ldyBjb3VudGVycz8NCj4+PiAgIEZyb20gbXkgKG1vc3RseSBvdXRkYXRlZCkgZXhwZXJp
ZW5jZSBBbmRyb2lkIHVzZXJzIHdvbid0IG9wZW4gYSB0ZXJtaW5hbA0KPj4+ICAgYW5kIHR5cGUg
J2NhdCAvcHJvYy9tZW1pbmZvJyB0aGVyZS4gSSdkIHByZXN1bWUgdGhlcmUgaXMgYSB2ZW5kb3Ig
YWdlbnQNCj4+PiAgIHRoYXQgY29sbGVjdHMgdGhlIGRhdGEgYW5kIHNlbmRzIGl0IGZvciBhbmFs
eXNpcy4gSW4gdGhpcyBjYXNlIHdoYXQgaXMNCj4+PiAgIHRoZSByZWFzb24gdGhlIHZlbmRvciBp
cyB1bmFibGUgdG8gYWRqdXN0IHNlbGluaXggcG9saWN5IHNvIHRoYXQgdGhlDQo+Pj4gICBhZ2Vu
dCB3aWxsIGJlIGFibGUgdG8gYWNjZXNzIGZkaW5mbz8NCj4+IFdoZW4geW91IHR1cm4gb24gZGV2
ZWxvcGVyIG1vZGUgb24gYW5kcm9pZCB5b3UgY2FuIHVzZQ0KPj4gdXNiIHdpdGggYSBwcm9ncmFt
IGNhbGxlZCBhZGIuIEFuZCB0aGVyZSB5b3UgZ2V0IGEgbm9ybWFsIHNoZWxsLg0KPj4NCj4+IChu
b3Qgcm9vdCB0aG91Z2gpDQo+Pg0KPj4gVGhlcmUgaXMgYXBwbGljYXRpb25zIHRoYXQgbm9uIGRl
dmVsb3BlcnMgY2FuIHVzZSB0byBnZXQNCj4+IGluZm9ybWF0aW9uLiBJdCBpcyB2ZXJ5IGxpbWl0
ZWQgdGhvdWdoIGFuZCB0aGVyZSBhcmUgQVBJJ3MNCj4+IHByb3ZpZGUgaXQuDQo+Pg0KPj4NCj4+
PiAqIEFuZCwgYXMgb3RoZXJzIGFscmVhZHkgbWVudGlvbmVkLCBpdCBpcyBub3QgY2xlYXIgd2hh
dCBhcmUgdGhlIHByb2JsZW1zDQo+Pj4gICB0aGF0IGNhbiBiZSBkZXRlY3RlZCBieSBleGFtaW5p
bmcgRG1hQnVmVG90YWwgZXhjZXB0IHNheWluZyAib2gsIHRoZXJlIGlzDQo+Pj4gICB0b28gbXVj
aC90b28gbGl0dGxlIG1lbW9yeSBleHBvcnRlZCB2aWEgZG1hLWJ1ZiIuIFdoYXQgd291bGQgYmUg
dXNlcg0KPj4+ICAgdmlzaWJsZSBlZmZlY3RzIG9mIHRoZXNlIHByb2JsZW1zPyBXaGF0IGFyZSB0
aGUgbmV4dCBzdGVwcyB0byBpbnZlc3RpZ2F0ZQ0KPj4+ICAgdGhlbT8gV2hhdCBvdGhlciBkYXRh
IHdpbGwgYmUgcHJvYmFibHkgcmVxdWlyZWQgdG8gaWRlbnRpZnkgcm9vdCBjYXVzZT8NCj4+Pg0K
Pj4gV2hlbiB5b3UgZGVidWcgdGhvdXNhbmRzIG9mIGRldmljZXMgaXQgaXMgcXVpdGUgbmljZSB0
byBoYXZlDQo+PiB3YXlzIHRvIGNsYXNzaWZ5IHdoYXQgdGhlIHByb2JsZW0gaXQgaXMgbm90LiBU
aGUgbm9ybWFsIHVzZXIgZG9lcyBub3QNCj4+IHNlZSBhbnl0aGluZyBvZiB0aGlzLiBIb3dldmVy
IHRoZXkgY2FuIGdlbmVyYXRlIGJ1Zy1yZXBvcnRzIHRoYXQNCj4+IGNvbGxlY3QgaW5mb3JtYXRp
b24gYWJvdXQgYXMgbXVjaCB0aGV5IGNhbi4gVGhlbiB0aGUgdXNlciBoYXZlDQo+PiB0byBwcm92
aWRlIHRoaXMgYnVnLXJlcG9ydCB0byB0aGUgbWFudWZhY3R1cmUgb3IgbW9zdGx5IHRoZQ0KPj4g
YXBwbGljYXRpb24gZGV2ZWxvcGVyLiBBbmQgd2hlbiB0aGUgcHJvYmxlbSBpcw0KPj4gc3lzdGVt
IHJlbGF0ZWQgd2UgbmVlZCB0byByZXByb2R1Y2UgdGhlIGlzc3VlIG9uIGEgZnVsbA0KPj4gZGVi
dWcgZW5hYmxlZCB1bml0Lg0KPiBTbyB0aGUgZmxvdyBpcyBsaWtlIHRoaXM6DQo+DQo+ICogYSB1
c2VyIGhhcyBhIHByb2JsZW0gYW5kIHJlcG9ydHMgaXQgdG8gYW4gYXBwbGljYXRpb24gZGV2ZWxv
cGVyOyBhdCBiZXN0DQo+ICAgdGhlIHVzZXIgcnVucyBzaW1wbGUgYW5kIGxpbWl0ZWQgYXBwIHRv
IGNvbGxlY3Qgc29tZSBkYXRhDQo+ICogaWYgdGhlIGFwcGxpY2F0aW9uIGRldmVsb3BlciBjb25z
aWRlcnMgdGhpcyBpc3N1ZSBhcyBhIHN5c3RlbSByZWxhdGVkDQo+ICAgdGhleSBjYW4gb3BlbiBh
ZGIgYW5kIGNvbGxlY3Qgc29tZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHRoZSBzeXN0ZW0NCj4g
ICB1c2luZyBub24tcm9vdCBzaGVsbCB3aXRoIHNlbGludXggcG9saWN5IHJlc3RyaWN0aW9ucyBh
bmQgc2VuZCB0aGlzDQo+ICAgaW5mb3JtYXRpb24gdG8gdGhlIGRldmljZSBtYW51ZmFjdHVyZXIu
DQo+ICogdGhlIG1hbnVmYWN0dXJlciBjb250aW51ZXMgdG8gZGVidWcgdGhlIGlzc3VlIGFuZCBh
dCB0aGlzIHBvaW50IGFzIG11Y2gNCj4gICBpbmZvcm1hdGlvbiBpcyBwb3NzaWJsZSB3b3VsZCBo
YXZlIGJlZW4gdXNlZnVsLg0KPg0KPiBJbiB0aGlzIGZsb3cgSSBzdGlsbCBmYWlsIHRvIHVuZGVy
c3RhbmQgd2h5IHRoZSBtYW51ZmFjdHVyZXIgY2Fubm90IHByb3ZpZGUNCj4gdXNlcnNwYWNlIHRv
b2xzIHRoYXQgd2lsbCBiZSBhYmxlIHRvIGNvbGxlY3QgdGhlIHJlcXVpcmVkIGluZm9ybWF0aW9u
Lg0KPiBUaGVzZSB0b29scyBub3QgbmVjZXNzYXJpbHkgbmVlZCB0byB0YXJnZXQgdGhlIGVuZCB1
c2VyLCB0aGV5IG1heSBiZSBvbmx5DQo+IGludGVuZGVkIGZvciB0aGUgYXBwbGljYXRpb24gZGV2
ZWxvcGVycywgZS5nLiBwb2xpY3kgY291bGQgYWxsb3cgc3VjaCB0b29sDQo+IHRvIGFjY2VzcyBz
b21lIG9mIHRoZSBzeXN0ZW0gZGF0YSBvbmx5IHdoZW4gdGhlIHN5c3RlbSBpcyBpbiBkZXZlbG9w
ZXINCj4gbW9kZS4NCj4NClRoZSBtYW51ZmFjdHVyZSBpcyB0cnlpbmcgdG8gZ2V0IHRoZSB0b29s
IHRvIHdvcmsuIFRoaXMgaXMgd2hhdCB0aGUNCnBhdGNoIGlzIGFib3V0LiBFdmVuIGZvciBhIGFw
cGxpY2F0aW9uIGRldmVsb3BlciBhIGNvbW1lcmNpYWwNCnBob25lIGlzIGxvY2tlZCBkb3duLiBN
YW55IHZlbmRvcnMgYWxsb3cgdGhhdCB5b3UgZmxhc2gNCnNvbWUgb3RoZXIgc29mdHdhcmUgbGlr
ZSBhIEFPU1AuwqAgQnV0IHRoYXQgY2FuIGJlIHZlcnkNCmRpZmZlcmVudC4gTGlrZSBpbnN0YWxs
aW5nIGEgdWJ1bnR1IG9uIGEgUEMgdG8gZGVidWcgYSBGZWRvcmEgaXNzdWUuDQoNCkFuZCBzdXJl
IHdlIGNhbiBwaWNrdXAgcGFydHMgb2Ygd2hhdCB1c2luZyB0aGUgZG1hLWJ1Zi4gQnV0DQp3ZSBj
YW4gbm90IGdldCB0aGUgdG90YWwgYW5kIGJlIHN1cmUgdGhhdCBpcyB0aGUgdG90YWwgd2l0aG91
dCBhDQpwcm9wZXIgY291bnRlci4NCg==
