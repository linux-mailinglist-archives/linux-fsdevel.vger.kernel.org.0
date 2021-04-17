Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C1B362FC6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 14:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbhDQMPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Apr 2021 08:15:31 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:56284 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235901AbhDQMPb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Apr 2021 08:15:31 -0400
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13HCEchx002177;
        Sat, 17 Apr 2021 12:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=S1;
 bh=VKGNcTb+SELYjVwwF/WYOx9OtIOsVwsLK4X/oNYHz38=;
 b=eU81sbra9SI1E85+w5tdRzXWeRHeClYxsKH3Gabzfg/pprDSywPbqI9pssHqzqw4XjXe
 axJ20Wp4w4Dh5q/gXE0aM2g9FhBoaX+XIwvrIq7iP6yg+BEXxLMYKP16TlonyTytp/F3
 ft+bNIB5e56bESUKVFruR7ECZoS+SVy7n3Oq4jlXh46zqmLbwrU0SSP1fLxa/qsPiaKE
 FNWEALhiYMNv5wdf8PA1yDxmQ9NQVrt0WZzhwUcpmU/REzz7MxtlgCr3kTSzhCgC04qs
 KFTMg810jR9EMHuszj0U0VOmTgfET/LerNScru2xGs2lRzsITkCtuLlHIE/AEDGkXrkO tQ== 
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113])
        by mx08-001d1705.pphosted.com with ESMTP id 37ynvkr64k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 12:14:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hso6vN0ZL38A0wEchZ/8pIAWlaldEIFve5xJchlpYm0/DHV+gHr+GK2rd/a010udFGF4250lVwtdh7L4Bs+DzP+ubucsiOtfq6hSNOl71rJW2Diii4VSk+F01F78WZjFuxsZ0TmfnFgSOkiezW6SXN9se5mY5Joq7UeLHcVTykOvXhZDPVYk6uaxJ5S9+NtEe3MmQZr2NX8gZCZdR8JjsXLJi4EssdbMqiLe9JyTY7h+G/U2F0XJqDphDGClh+G0PM+Pb5XCLsrSbn2zggR73jY7Ukt8wJQbhzEvkH4TJBg/dtbjbIZWR3Inz8UKg0OIfrGgojxDlHzUBH5XsWXnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKGNcTb+SELYjVwwF/WYOx9OtIOsVwsLK4X/oNYHz38=;
 b=TWXccJm1IuDhmUfmqsUN6bXlMtwM50AdR9vlXQ89huES9idfecUka4C/7gjQipYOsuPzjzoqKOOuyBR1ipShGsrReEoyWOwgJDHgK5CEDOP3SvyuyJ4NuA1v70JOOcKS7wbm6P5tSy+0KebTtcqGubIFjRDYdcyzdUnH4g4n5QNVuBDiIHTg7lPrYpkfMD10ygxtbjuASPbzo1nU37B7gOCmrJ5yFTu5s1v5uDF/y61kCmO61tH6ltz10j4M5kwBH6ECx6is8VNB9vdIfX/eiW+xO9RqT8xO0Xph+hQtSW87mRD0f7MG9VjkkOkeKnYxXvpbS0Z7M+a7EHXKtZmHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM9P193MB1409.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:309::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Sat, 17 Apr
 2021 12:13:53 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4042.021; Sat, 17 Apr 2021
 12:13:53 +0000
From:   <Peter.Enderborg@sony.com>
To:     <christian.koenig@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <sumit.semwal@linaro.org>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <songmuchun@bytedance.com>, <guro@fb.com>, <shakeelb@google.com>,
        <mhocko@suse.com>, <neilb@suse.de>, <samitolvanen@google.com>,
        <rppt@kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <willy@infradead.org>
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Topic: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Index: AQHXM3Yw6ll+UCWErEeaPUdSTn+rzaq4ipMAgAAF3YCAAAliAIAABYMA
Date:   Sat, 17 Apr 2021 12:13:53 +0000
Message-ID: <6b9c96b6-ff2c-951f-aea7-9ad8affe9a1e@sony.com>
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <d983aef9-3dde-54cc-59a0-d9d42130b513@amd.com>
 <d822adcc-2a3c-1923-0d1d-4ecabd76a0e5@sony.com>
 <2420ea7a-4746-b11a-3c0e-2f962059d071@amd.com>
In-Reply-To: <2420ea7a-4746-b11a-3c0e-2f962059d071@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 031d53b6-9fe1-4cdb-424b-08d9019a448c
x-ms-traffictypediagnostic: AM9P193MB1409:
x-microsoft-antispam-prvs: <AM9P193MB14090E9CBC436A23B0906D31864B9@AM9P193MB1409.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6K2rl8WnGg1uZ4xuOTn61aEQNi+cjTLJZP4jlNYzX3t8iTITD+ZtUJV/o58cWTaEohCtNi6VV1Y4VzT8QNO6yLsYJgX5i5o3DwYP57FUbCljMcSG9zkDN769cTSMbBi1epRgJsv9yPnQBBiU462o2v+vNgzSIksgsqQxj2iN3qvRchZwjeeQ37wVAh3EA0qxYNnooqtnvmMlo7O4m5aC5VEycrhiuIetjw7urqdsyOqJJ7LfVLOSJScfzw+xiwVudTCsEQeNmHw1KxCxLjL/LgOrlNyMUq757SKLR4vgCiliV4m50nAwnfGzkJW5qEuOpDL3p7YzzCJhQHNQ+3fRj0HcZttowp2uKcBFhpLiYbK36gmTD8vKV//BYH7+gveTJLqmDOEMNHfHlbJnXjq2hAksTi4IfOfPiX8OFH43O3Pwzr4A9fgzWh6LX/0CdDa4uQWHU2Ga1arBjhECT76mtW40m5MR2Yi6h/MNkkWhUgo2hVtoj5YGRMISrW8Zh4ABLvDuH3sv/ZpHFa0Ey9Xu5JT04kAyKmVZ/QsN+8/eVnyDObdW47mggOkJGNVVDu2tI9A3NoQoUM/iho8Qv47iVpnsrdk02Wr5vVVOHwC4oRB4xxf0KpqvcXW9ys8anSq+XLxQynt0Slse0ei5luoO2Uix1xY9KsKv+VH6kXCfDT28cuD8+W/nIgZ6HHvAov3lIM7mwD8sz6UXfpYdLxD5Tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39830400003)(396003)(366004)(346002)(316002)(6506007)(53546011)(7416002)(110136005)(71200400001)(122000001)(31696002)(86362001)(8936002)(186003)(38100700002)(26005)(6486002)(66574015)(91956017)(83380400001)(66946007)(2616005)(5660300002)(921005)(478600001)(36756003)(31686004)(6512007)(2906002)(66446008)(64756008)(66556008)(66476007)(76116006)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c1hkK2U1R1h2dnVNV3hVRVNzVmVnMkl4K21aZXJWbUR3T3BxdDJJbDFqaGRP?=
 =?utf-8?B?Q0VON3RPemhIMGF6eDMxTy9UY2ZIdGNKME1iNXpwR2sxaDVXczdqMUdBMXJF?=
 =?utf-8?B?YlJhTjh5QjE5ek9tdTdBQW1jT0dLUGJRYkJtL0FzZmhGUm5lREtrZXpOR3dR?=
 =?utf-8?B?bFhuZ1I4dXI1TDE3Rm4wL2l4VnpOMENjUkJFOFNkOEUxUHJVazBUaURDbk9G?=
 =?utf-8?B?dGZ2SUZEWjF4WWlpU2tycTRVK3ZHNUdOSmpaMHNESGY1a215NVJSUk1kcEpU?=
 =?utf-8?B?THk3bnl2MEQ0dXNObU56b2RReWF0K0RMNWFEVTQ5dC9qbWpHN2V3WHcxRkla?=
 =?utf-8?B?ZExVdEVmMGhBNGlCazI3Y2FzZ01JdDJUZXdCTHJORDArM3FvL0dZdjBxZU4z?=
 =?utf-8?B?Z1kva0JqbEd3SjZUTDZYalBQdVIrVnpSelMrSkdoOE53Y3pDaFE0RS93dDRu?=
 =?utf-8?B?N0pMVU90WmxMdmlHaFFzTTNlOUFDbi9VN215WThVdEREL1NQVnU3aFB6cnZT?=
 =?utf-8?B?VWptdDk0RnhJamNvSURhaTRlSUtWTnFtZCtYazhQcHBZOWtwV1dNamh6dUNs?=
 =?utf-8?B?dkhrM3ViOVBzRFRrajdHV0hLNFp4RHZ6a3B5ZXZ6VktoOEJGZ1dUdWk5aTUy?=
 =?utf-8?B?b0ZVOVlDaVJyOTNmQzlHdXBGTSsxUDUwY0tsUEozZ2Rpb1h6RXRiSE5ieDNs?=
 =?utf-8?B?RmlZMlA5UHYrc01UcXd6Q2Q0UmJ0Umd4bENMSldQQVdaNjNFQUgyc1RDQS9F?=
 =?utf-8?B?bEZZVDFDa2RBWGlWK2Fia3A3ZGRmNHNmRHFvYlI2Uk5XUkI5ZGZkcVJNS0hE?=
 =?utf-8?B?cWttMzgzNWhZQ2hiU2tPVmxGQ2k3NXF5L3dwbnR2ZjNWNlNSRmpoQVJzcVFV?=
 =?utf-8?B?YVJsY3l4RlVnU0ZoKzlnWDdhUm1kbVZxMXNpMmh6RG9IcjE2WmRGV3VZcmJX?=
 =?utf-8?B?ZEQ0bjc5c1p0YmdkamV4bm51Y0F6eGJIbVY2UFA2TVN1UzR1Mmt6UTU2MlAx?=
 =?utf-8?B?RVZFUTNXbWZLM3V2RGswN2luVTRHeFRQTCt3UDNlRlJvRHVvQVgzMW0zUEJN?=
 =?utf-8?B?NkpNZnFMUCtWQ2huU2drY3UyT2RYbnNKSkJVdEJxVSs3UEJDbWo4THBYMHZM?=
 =?utf-8?B?NTlESGtqRlNmN1dDV21SNzI1cXFTMTVjNU4vYkp5a3JzYzZLT2ZMOG95VXMy?=
 =?utf-8?B?M1plM3NuL1JheDBZYUpHSUJYTm9MYzBjRC9KZWQxR3NoVHlIVlY5bTBzczNQ?=
 =?utf-8?B?ZTBkMlVVWDdUZ0d6Tjc1a3piYmFGUlJNRmdxYzI2dXE0dCtGd096elU5aS9T?=
 =?utf-8?B?dkk3NHFEYTQvVityQW5SVkZXNWdFMFpzTkVqc0l0dGNSRi9laFhvdVNjVUha?=
 =?utf-8?B?a2xJaS9veEpwT2NlTU9ybzZtd2FaekR3SVgzQ1R4Ukx2bEl0TkdDODV4d3lu?=
 =?utf-8?B?cmo3cFoxSVloT1dVR29lbW05OXdxcVE0eXQyTmxNcm13bkNBQzdOQjhTZGU1?=
 =?utf-8?B?UVJNTmJZcmZxeXRNWTQyWmZiMUNMV0cxTGFmL0JHMTNLMjV2SkdlMjVqdlNO?=
 =?utf-8?B?NHc3S2p3WHZUVjNPSW5saU5oTXFieHgrSjJUemhNMkQrM0NpQ2VOK3dpb3JO?=
 =?utf-8?B?a0EzUFVzK0RNOGdyS0RXdzZGY0RURE5Wd1ZnUzk0RS9SQ21mTlZtNFRBMURs?=
 =?utf-8?B?dldwR2pZVVIwT1ZYS2M4T1lvSUVLNVJBOC9tZHpGY0NKSWRtMk5OdFhOQVJF?=
 =?utf-8?Q?Obop8AtNFpT5i19Pu5EWoCadCG+MKCvS2KIPgab?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <22DF92DE9296B34CAAC75300E73DF2A2@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 031d53b6-9fe1-4cdb-424b-08d9019a448c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2021 12:13:53.5483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7wqxXBggu4IoiapVVtBtjrhJFB8wP8qvJ07qUWNunRzHLGvntpMx+qapAh2PkPQ0b3QWVQxC5fiPS3akLF537KFW+/FmyqskidNsNUHuwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1409
X-Proofpoint-ORIG-GUID: FvfNtmTO36N7_jq_Ju0Nen4CF4IkRIk7
X-Proofpoint-GUID: FvfNtmTO36N7_jq_Ju0Nen4CF4IkRIk7
X-Sony-Outbound-GUID: FvfNtmTO36N7_jq_Ju0Nen4CF4IkRIk7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-17_06:2021-04-16,2021-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104170087
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xNy8yMSAxOjU0IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiBBbSAxNy4wNC4y
MSB1bSAxMzoyMCBzY2hyaWViIFBldGVyLkVuZGVyYm9yZ0Bzb255LmNvbToNCj4+IE9uIDQvMTcv
MjEgMTI6NTkgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+Pj4gQW0gMTcuMDQuMjEgdW0g
MTI6NDAgc2NocmllYiBQZXRlciBFbmRlcmJvcmc6DQo+Pj4+IFRoaXMgYWRkcyBhIHRvdGFsIHVz
ZWQgZG1hLWJ1ZiBtZW1vcnkuIERldGFpbHMNCj4+Pj4gY2FuIGJlIGZvdW5kIGluIGRlYnVnZnMs
IGhvd2V2ZXIgaXQgaXMgbm90IGZvciBldmVyeW9uZQ0KPj4+PiBhbmQgbm90IGFsd2F5cyBhdmFp
bGFibGUuIGRtYS1idWYgYXJlIGluZGlyZWN0IGFsbG9jYXRlZCBieQ0KPj4+PiB1c2Vyc3BhY2Uu
IFNvIHdpdGggdGhpcyB2YWx1ZSB3ZSBjYW4gbW9uaXRvciBhbmQgZGV0ZWN0DQo+Pj4+IHVzZXJz
cGFjZSBhcHBsaWNhdGlvbnMgdGhhdCBoYXZlIHByb2JsZW1zLg0KPj4+Pg0KPj4+PiBTaWduZWQt
b2ZmLWJ5OiBQZXRlciBFbmRlcmJvcmcgPHBldGVyLmVuZGVyYm9yZ0Bzb255LmNvbT4NCj4+PiBS
ZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0K
Pj4+DQo+Pj4gSG93IGRvIHlvdSB3YW50IHRvIHVwc3RyZWFtIHRoaXM/DQo+PiBJIGRvbid0IHVu
ZGVyc3RhbmQgdGhhdCBxdWVzdGlvbi4gVGhlIHBhdGNoIGFwcGxpZXMgb24gVG9ydmFsZHMgNS4x
Mi1yYzcsDQo+PiBidXQgSSBndWVzcyA1LjEzIGlzIHdoYXQgd2Ugd29yayBvbiByaWdodCBub3cu
DQo+DQo+IFllYWgsIGJ1dCBob3cgZG8geW91IHdhbnQgdG8gZ2V0IGl0IGludG8gTGludXMgdHJl
ZT8NCj4NCj4gSSBjYW4gcHVzaCBpdCB0b2dldGhlciB3aXRoIG90aGVyIERNQS1idWYgcGF0Y2hl
cyB0aHJvdWdoIGRybS1taXNjLW5leHQgYW5kIHRoZW4gRGF2ZSB3aWxsIHNlbmQgaXQgdG8gTGlu
dXMgZm9yIGluY2x1c2lvbiBpbiA1LjEzLg0KPg0KPiBCdXQgY291bGQgYmUgdGhhdCB5b3UgYXJl
IHB1c2hpbmcgbXVsdGlwbGUgY2hhbmdlcyB0b3dhcmRzIExpbnVzIHRocm91Z2ggc29tZSBvdGhl
ciBicmFuY2guIEluIHRoaXMgY2FzZSBJJ20gZmluZSBpZiB5b3UgcGljayB0aGF0IHdheSBpbnN0
ZWFkIGlmIHlvdSB3YW50IHRvIGtlZXAgeW91ciBwYXRjaGVzIHRvZ2V0aGVyIGZvciBzb21lIHJl
YXNvbi4NCj4NCkl0IGlzIGEgZG1hLWJ1ZiBmdW5jdGlvbmFsaXR5IHNvIGl0IG1ha2UgdmVyeSBt
dWNoIHNlbnNlIHRoYXQgeW91IGFzIG1haW50YWluZXIgb2YgZG1hLWJ1ZiBwaWNrIHRoZW0gdGhl
IHdheSB5b3UgdXN1YWxseSBzZW5kIHRoZW0uIEkgZG9uJ3QgaGF2ZSBhbnkgb3RoZXIgcGF0aCBm
b3IgdGhpcyBwYXRjaC4NCg0KVGh4IQ0KDQpQZXRlci4NCg0KDQo+IENocmlzdGlhbi4NCj4NCj4+
DQo+Pj4+IC0tLQ0KPj4+PiDCoMKgIGRyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgfCAxMyArKysr
KysrKysrKysrDQo+Pj4+IMKgwqAgZnMvcHJvYy9tZW1pbmZvLmPCoMKgwqDCoMKgwqDCoMKgIHzC
oCA1ICsrKystDQo+Pj4+IMKgwqAgaW5jbHVkZS9saW51eC9kbWEtYnVmLmjCoMKgIHzCoCAxICsN
Cj4+Pj4gwqDCoCAzIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgYi9k
cml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jDQo+Pj4+IGluZGV4IGYyNjRiNzBjMzgzZS4uMTk3ZTVj
NDVkZDI2IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jDQo+Pj4+
ICsrKyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMNCj4+Pj4gQEAgLTM3LDYgKzM3LDcgQEAg
c3RydWN0IGRtYV9idWZfbGlzdCB7DQo+Pj4+IMKgwqAgfTsNCj4+Pj4gwqDCoCDCoCBzdGF0aWMg
c3RydWN0IGRtYV9idWZfbGlzdCBkYl9saXN0Ow0KPj4+PiArc3RhdGljIGF0b21pY19sb25nX3Qg
ZG1hX2J1Zl9nbG9iYWxfYWxsb2NhdGVkOw0KPj4+PiDCoMKgIMKgIHN0YXRpYyBjaGFyICpkbWFi
dWZmc19kbmFtZShzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIGNoYXIgKmJ1ZmZlciwgaW50IGJ1Zmxl
bikNCj4+Pj4gwqDCoCB7DQo+Pj4+IEBAIC03OSw2ICs4MCw3IEBAIHN0YXRpYyB2b2lkIGRtYV9i
dWZfcmVsZWFzZShzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+Pj4+IMKgwqDCoMKgwqDCoCBpZiAo
ZG1hYnVmLT5yZXN2ID09IChzdHJ1Y3QgZG1hX3Jlc3YgKikmZG1hYnVmWzFdKQ0KPj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkbWFfcmVzdl9maW5pKGRtYWJ1Zi0+cmVzdik7DQo+Pj4+IMKgwqAg
K8KgwqDCoCBhdG9taWNfbG9uZ19zdWIoZG1hYnVmLT5zaXplLCAmZG1hX2J1Zl9nbG9iYWxfYWxs
b2NhdGVkKTsNCj4+Pj4gwqDCoMKgwqDCoMKgIG1vZHVsZV9wdXQoZG1hYnVmLT5vd25lcik7DQo+
Pj4+IMKgwqDCoMKgwqDCoCBrZnJlZShkbWFidWYtPm5hbWUpOw0KPj4+PiDCoMKgwqDCoMKgwqAg
a2ZyZWUoZG1hYnVmKTsNCj4+Pj4gQEAgLTU4Niw2ICs1ODgsNyBAQCBzdHJ1Y3QgZG1hX2J1ZiAq
ZG1hX2J1Zl9leHBvcnQoY29uc3Qgc3RydWN0IGRtYV9idWZfZXhwb3J0X2luZm8gKmV4cF9pbmZv
KQ0KPj4+PiDCoMKgwqDCoMKgwqAgbXV0ZXhfbG9jaygmZGJfbGlzdC5sb2NrKTsNCj4+Pj4gwqDC
oMKgwqDCoMKgIGxpc3RfYWRkKCZkbWFidWYtPmxpc3Rfbm9kZSwgJmRiX2xpc3QuaGVhZCk7DQo+
Pj4+IMKgwqDCoMKgwqDCoCBtdXRleF91bmxvY2soJmRiX2xpc3QubG9jayk7DQo+Pj4+ICvCoMKg
wqAgYXRvbWljX2xvbmdfYWRkKGRtYWJ1Zi0+c2l6ZSwgJmRtYV9idWZfZ2xvYmFsX2FsbG9jYXRl
ZCk7DQo+Pj4+IMKgwqAgwqDCoMKgwqDCoCByZXR1cm4gZG1hYnVmOw0KPj4+PiDCoMKgIEBAIC0x
MzQ2LDYgKzEzNDksMTYgQEAgdm9pZCBkbWFfYnVmX3Z1bm1hcChzdHJ1Y3QgZG1hX2J1ZiAqZG1h
YnVmLCBzdHJ1Y3QgZG1hX2J1Zl9tYXAgKm1hcCkNCj4+Pj4gwqDCoCB9DQo+Pj4+IMKgwqAgRVhQ
T1JUX1NZTUJPTF9HUEwoZG1hX2J1Zl92dW5tYXApOw0KPj4+PiDCoMKgICsvKioNCj4+Pj4gKyAq
IGRtYV9idWZfYWxsb2NhdGVkX3BhZ2VzIC0gUmV0dXJuIHRoZSB1c2VkIG5yIG9mIHBhZ2VzDQo+
Pj4+ICsgKiBhbGxvY2F0ZWQgZm9yIGRtYS1idWYNCj4+Pj4gKyAqLw0KPj4+PiArbG9uZyBkbWFf
YnVmX2FsbG9jYXRlZF9wYWdlcyh2b2lkKQ0KPj4+PiArew0KPj4+PiArwqDCoMKgIHJldHVybiBh
dG9taWNfbG9uZ19yZWFkKCZkbWFfYnVmX2dsb2JhbF9hbGxvY2F0ZWQpID4+IFBBR0VfU0hJRlQ7
DQo+Pj4+ICt9DQo+Pj4+ICtFWFBPUlRfU1lNQk9MX0dQTChkbWFfYnVmX2FsbG9jYXRlZF9wYWdl
cyk7DQo+Pj4+ICsNCj4+Pj4gwqDCoCAjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+Pj4+IMKgwqAg
c3RhdGljIGludCBkbWFfYnVmX2RlYnVnX3Nob3coc3RydWN0IHNlcV9maWxlICpzLCB2b2lkICp1
bnVzZWQpDQo+Pj4+IMKgwqAgew0KPj4+PiBkaWZmIC0tZ2l0IGEvZnMvcHJvYy9tZW1pbmZvLmMg
Yi9mcy9wcm9jL21lbWluZm8uYw0KPj4+PiBpbmRleCA2ZmE3NjFjOWNjNzguLmNjYzdjNDBjOGRi
NyAxMDA2NDQNCj4+Pj4gLS0tIGEvZnMvcHJvYy9tZW1pbmZvLmMNCj4+Pj4gKysrIGIvZnMvcHJv
Yy9tZW1pbmZvLmMNCj4+Pj4gQEAgLTE2LDYgKzE2LDcgQEANCj4+Pj4gwqDCoCAjaWZkZWYgQ09O
RklHX0NNQQ0KPj4+PiDCoMKgICNpbmNsdWRlIDxsaW51eC9jbWEuaD4NCj4+Pj4gwqDCoCAjZW5k
aWYNCj4+Pj4gKyNpbmNsdWRlIDxsaW51eC9kbWEtYnVmLmg+DQo+Pj4+IMKgwqAgI2luY2x1ZGUg
PGFzbS9wYWdlLmg+DQo+Pj4+IMKgwqAgI2luY2x1ZGUgImludGVybmFsLmgiDQo+Pj4+IMKgwqAg
QEAgLTE0NSw3ICsxNDYsOSBAQCBzdGF0aWMgaW50IG1lbWluZm9fcHJvY19zaG93KHN0cnVjdCBz
ZXFfZmlsZSAqbSwgdm9pZCAqdikNCj4+Pj4gwqDCoMKgwqDCoMKgIHNob3dfdmFsX2tiKG0sICJD
bWFGcmVlOsKgwqDCoMKgwqDCoMKgICIsDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ2xvYmFsX3pvbmVfcGFnZV9zdGF0ZShOUl9GUkVFX0NNQV9QQUdFUykpOw0KPj4+PiDCoMKg
ICNlbmRpZg0KPj4+PiAtDQo+Pj4+ICsjaWZkZWYgQ09ORklHX0RNQV9TSEFSRURfQlVGRkVSDQo+
Pj4+ICvCoMKgwqAgc2hvd192YWxfa2IobSwgIkRtYUJ1ZlRvdGFsOsKgwqDCoCAiLCBkbWFfYnVm
X2FsbG9jYXRlZF9wYWdlcygpKTsNCj4+Pj4gKyNlbmRpZg0KPj4+PiDCoMKgwqDCoMKgwqAgaHVn
ZXRsYl9yZXBvcnRfbWVtaW5mbyhtKTsNCj4+Pj4gwqDCoCDCoMKgwqDCoMKgIGFyY2hfcmVwb3J0
X21lbWluZm8obSk7DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaCBi
L2luY2x1ZGUvbGludXgvZG1hLWJ1Zi5oDQo+Pj4+IGluZGV4IGVmZGM1NmI5ZDk1Zi4uNWIwNTgx
NmJkMmNkIDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaA0KPj4+PiAr
KysgYi9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaA0KPj4+PiBAQCAtNTA3LDQgKzUwNyw1IEBAIGlu
dCBkbWFfYnVmX21tYXAoc3RydWN0IGRtYV9idWYgKiwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICos
DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyk7DQo+Pj4+IMKgwqAg
aW50IGRtYV9idWZfdm1hcChzdHJ1Y3QgZG1hX2J1ZiAqZG1hYnVmLCBzdHJ1Y3QgZG1hX2J1Zl9t
YXAgKm1hcCk7DQo+Pj4+IMKgwqAgdm9pZCBkbWFfYnVmX3Z1bm1hcChzdHJ1Y3QgZG1hX2J1ZiAq
ZG1hYnVmLCBzdHJ1Y3QgZG1hX2J1Zl9tYXAgKm1hcCk7DQo+Pj4+ICtsb25nIGRtYV9idWZfYWxs
b2NhdGVkX3BhZ2VzKHZvaWQpOw0KPj4+PiDCoMKgICNlbmRpZiAvKiBfX0RNQV9CVUZfSF9fICov
DQo+DQo=
