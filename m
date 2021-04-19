Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7561D3641EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 14:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbhDSMnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 08:43:09 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:18294 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232709AbhDSMnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:43:08 -0400
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JCUxdR025900;
        Mon, 19 Apr 2021 12:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=+UwMNxlgDvdTT9ijbl2TxsmSrIp/RigDtvwqyGLRHME=;
 b=McMWRQYeur5kYnPwdJdti/lp1oDhKEwUy0pFj6bRXjInb66YjPSV4K7/bmEmWl5+xGoN
 KoBSxJAPWxN7JCnQcfJem1i3k0EXeZJj98ZxdlaIAk1aycc5XzhWBLtjx+WA2fABdnOi
 q0KPbKOqqg+U7Gem+jvsHjHv6OMiUMdv80YryDp1D2zE2OXo4ZgitsupPG2VkxoHfUV/
 2tIBo2iZMiPgQtVcZ+YNHNlOLPNGtqKEybqfOCX0mELu4yR/zSfKD7liPzQIOuQW7wqs
 UWtIjI16riy54YJtZXrDa+qn/nYy+x2G92yDvPUDLvi8GG8PR3LyKlC8sMQGshFkPrBB IA== 
Received: from eur02-ve1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2050.outbound.protection.outlook.com [104.47.6.50])
        by mx08-001d1705.pphosted.com with ESMTP id 37ypj1s924-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 12:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT0aZ4IPouiwiIaPAPTlN/NEAdFLb2G8C5cRDsQRb+4ZjlPZ0iWnIWk1RRvcP+2llp2myfsXHoekGurMUqmgOal3CCk6dh4M9iGOBlVTWFJ6PPJPY85vLk9BKYF81CmgfC/8XhIllcxVd2qNGHEnWqgXxFiSl2zfY/MJQsWw6O9o5m/yfpqWVIvKU4cvWNTVTqoukZXS8REgvHtuImautOzQdyxJSLQtvWsHuPnw02PEjQJvUw8e7Rnmbgidea7VKtZXFTqRraujOW/kwnKpolg+RSDKXfkaty3ndaeB4M+rNmD6RESGlshU7BoqzU+fXC4SpVb7LGMjxzmZ5+9NoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UwMNxlgDvdTT9ijbl2TxsmSrIp/RigDtvwqyGLRHME=;
 b=O1ZgTWOyu2775Q3uKo+6xsdSno7YTw01nWP+wkHukYM+O0Z1eTrxyNmSxwEoP2aB6CIHAUFO6A56V3bFnpC5kBW4876gouxJ/rnX+LfIzPVcr7Hs1bhhuSb2iQyWVxZ3XfQ79r4f60meRDKDno7KBTgzQd1o1xJwIQ3cuLsPQ3AZ1NIDygGDv93rWh5u3ilCPorqc3xbnFwEpzO/rAXZNGfWmp9olwatauuYhhyYmCFA3BXxPIZ9khZhZKtQFWDxHVJtmzU+cv2WKzIH9GWhna0T2dRpKNDwwKkDwmm3i/1Al81X4D8L16iyd01hzGO3dRxCVkDMboYPAb0n7+qHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM9P193MB1620.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 12:41:59 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 12:41:58 +0000
From:   <Peter.Enderborg@sony.com>
To:     <mhocko@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sumit.semwal@linaro.org>, <christian.koenig@amd.com>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <songmuchun@bytedance.com>, <guro@fb.com>, <shakeelb@google.com>,
        <neilb@suse.de>, <samitolvanen@google.com>, <rppt@kernel.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <willy@infradead.org>
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Topic: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Index: AQHXM3Yw6ll+UCWErEeaPUdSTn+rzaq7xNSAgAAG/YA=
Date:   Mon, 19 Apr 2021 12:41:58 +0000
Message-ID: <c3f0da9c-d127-5edf-dd21-50fd5298acef@sony.com>
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <YH10s/7MjxBBsjVL@dhcp22.suse.cz>
In-Reply-To: <YH10s/7MjxBBsjVL@dhcp22.suse.cz>
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
x-ms-office365-filtering-correlation-id: 5f9e4fd3-813d-4e96-3323-08d9033085ed
x-ms-traffictypediagnostic: AM9P193MB1620:
x-microsoft-antispam-prvs: <AM9P193MB1620AD1ADCD492E01EF0171F86499@AM9P193MB1620.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Umb3va7Phf8j78ltBlhPTFk9I0Ecx9D/n35J6mvPn3BfDyoN3iJrcoFAHDGWvImLoE88mIrf8msXgF45/wM4n3I7lEmQ2hbaM/VbUDS2RMvSGSV50hd61gFaqmPzOlmPNcFID2ldCfwbS3KG4jnYkj0m7QbKy7Su9Q7Wt8m9OkXmhTYnS74w2AF9TaAzREakcaDDGRQ11erbCDtzmgGiQGhqgpwLoNa8uAN3nUdGqTMFqKQ7kQt6+mIGhEXOoDhtO60n6jZuBl7wkHhtvsFOMGRbwkGjB6PZXwe2WZoJmRvNIhENd+99mRZ2PTfBMJa8JOTyP4gA4U2twMUVzAnYJlaiF7PNJWeKuB/+XmD4ApF7xZDjM8NAFaabeUXhhNi9bDbQeIQtP7W0KEEuVbd0O9Vnx/mevBv3z10gZWsHb1cXhICC4/6JlBpuYErCUdqVz7+me9jigC2OdwsPxUnQHeEsgd9EWAhktaZ0fvVD0kvmDAVSN8F+SQozHl6EF4/l22/Xb6IQf3PuF5TVlDDNf3gzmBcFRe/KfqPc0GgNeTVC/AK37wXNcmaLMtAetExJOVQGjReMktjaQ54i7utyYr6STVeiBg6hqeE+Oc19LcXLJLTNAirm8Z18yWe8FnU/UeO2+1t8mmCOY1syRNRsQQGfV/gppMU+J0zminzBEjAFGZjjt9IC8kkBnvl/+H/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(66556008)(66946007)(71200400001)(76116006)(7416002)(64756008)(91956017)(66476007)(66446008)(6512007)(5660300002)(54906003)(83380400001)(31686004)(2616005)(86362001)(316002)(478600001)(31696002)(122000001)(36756003)(6486002)(4326008)(186003)(8676002)(8936002)(6506007)(6916009)(53546011)(2906002)(38100700002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YmF5cHVuSFlXUzRuZFNMeWRxMDJHOWxyUzZkYlYzbVljdUhJRXJUTzNyOGtX?=
 =?utf-8?B?WU9LRURlYmQxOHo3cWgyc3lqTzRnNWIzTDRnNU9jcmVqeDRSeGMzeUZwdmtF?=
 =?utf-8?B?RjByRmoxSkNSNUlDWU5EZGk5RFNEZlNTWjFHWEVkaTh0Szk5bWdpWmgrb0d3?=
 =?utf-8?B?WHRPTWFzdXo0K1BqTEEzUlVMTWVSeFpRaFNsS0h4UXN5UVRaNFpsY2YzYjVk?=
 =?utf-8?B?RGo0WkY3MFhlWUcxUjZubTdVUys1RGE4cUIzMVBHc29iR3VqS3NEZmM3eWZC?=
 =?utf-8?B?K3h6Sko0L1dZZi9GUmRLaitQL1RKU1pYdmJMWmxoazYxWlYyV2Noemd1UXV5?=
 =?utf-8?B?Qk12R1hDNjBqZ25uTUtPKytsNnF1OWdJSyttRUt3TUJEWlhNTCs4ekZGNnRx?=
 =?utf-8?B?QUxRUGxyUUo4MnRxZ3dYanFQWGs1aHBBck1EZUJsVVBEL2pwbXV0alEycDNw?=
 =?utf-8?B?bG5zd0hCVEpraERhRzZqTE5KMHp0bjhONWNDR2JzZ2h1WlR2MmFqQWMrR1Fx?=
 =?utf-8?B?Q1lucFNweENTNUFieU4vczBGOUhRWDFJTEZkVEU0T1hiWHUwSUFGZndsajZi?=
 =?utf-8?B?N3ZvS3FDV2VjK1dZNHlTeHZhcVVITFFDT0Rwb3VlVDBnb0h6OVBlY3lKQ05O?=
 =?utf-8?B?QlpTYkxCaC9ZeWNuN24wUWZVMmZUZnZ6L0pDMFE2bWxFOHlZT2RaUGFyR1lM?=
 =?utf-8?B?QXA4b2QyZkRrRjVmR1l1Q0xZWTU4OGRoN0dqbmlTR2ZycUszTjROQU90Mmoy?=
 =?utf-8?B?QUxqbXY2RkIvSVdwMkJLQkNId1oyTUdXTDFTWTE0b2ovQk44UHVGRlZEOGxJ?=
 =?utf-8?B?Qlo1VmpJQXpCa0FlRHRmaUdQeEgvU2FXSHdUYnN1VS9HbEhDelNTUHhFOWk2?=
 =?utf-8?B?NHdSRVFuMG55V1dwOWVTUHFvSGpaTWZmWTlmRlJJbHJXbmxNSDY2TVhDMWl5?=
 =?utf-8?B?U0ZaWXFyM0tPQnlhaU1ZSjlBd0hRSDBiTGViRXZQb3dRWjVOVmFUanI1NXBV?=
 =?utf-8?B?MERqS21QU2RHWmtPeFE2MzF6aFpBdGFqUC9LWnFxMFRhZXVBVXc0b0YrYURK?=
 =?utf-8?B?S2N4MjdMblI3OUV2Z2xJUC9iUk5qM3I4N0pENzBzU3BHaWx2RktUNXBaY3Fn?=
 =?utf-8?B?czFnT2tnQlJqSmNGOXZZTHBSQTdlczhnaU9HYk9LQm9nMW1Eb3BGZFpmeTBY?=
 =?utf-8?B?TlhzMkkyUG5TeTBmSFVGY281RXhoUmJlSFNRc0NFS1lnWGlodFdSZkMvdEpC?=
 =?utf-8?B?YUl4SzdMMklXdDlVQlEweTJBeUdncUlCS0JCdm5RTkVKY0g0OUpqK0htSGpU?=
 =?utf-8?B?LzZnemV3SlErS3d4TjBzemYyRENaZjJFYlZ5Yk02RzU1QWtvY2dqYXJWL1FK?=
 =?utf-8?B?alJFb2I1OHFZUEp1eU42SWduM1VsOTh4OGd3bk1ONDBIa3V3dE5KQW1TSnVv?=
 =?utf-8?B?THdJNTJzbjljTExzZ01sRlhWcERQcG5OTjl4OGZnd0xkZi9wdDZldS93cUFr?=
 =?utf-8?B?RFNJaWRIZEtqOEdtRExhcXVBNFAvMGRmU3VkaTVacXU1VVBrelcvd1pPNW4z?=
 =?utf-8?B?blZXUG1NaTd2OFVTdTF5b3UzUUxBRnJYUWc2WDZRK2pPZnE4Skc1NWVuU29X?=
 =?utf-8?B?cXJKQ2JvcFFDWjdmbzF2Qm10Y1VZQWk0TGpuUkFiRzNxOTBBU000VmJTeGUr?=
 =?utf-8?B?cVovblFJZktML0FuVHhsWFNFblFGdFhGUy9tNXpIZ2ZHWkMvSlAyQ2xwYWpX?=
 =?utf-8?Q?Lf/r2vP5ooR0mePet+x8C9XFg9DfXZ/r98bocZz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD9CE7F1F8C39C4DBC4F5CEABA2CC9BC@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9e4fd3-813d-4e96-3323-08d9033085ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 12:41:58.8550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pg9ZM/0bZ2s+v01dOWCr0NlkxFXKbPAH/qs68vGB/ZBAqcZfpkjt8SkcrmwFdSfnzdJnF7K+MUqe52l9qOfX35sX1phY42f5i8FXBnZ+a54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1620
X-Proofpoint-GUID: ZFp0lccCTPr0SvbYaS5JGB2mqWPmS13J
X-Proofpoint-ORIG-GUID: ZFp0lccCTPr0SvbYaS5JGB2mqWPmS13J
X-Sony-Outbound-GUID: ZFp0lccCTPr0SvbYaS5JGB2mqWPmS13J
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_10:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190088
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xOS8yMSAyOjE2IFBNLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+IE9uIFNhdCAxNy0wNC0y
MSAxMjo0MDozMiwgUGV0ZXIgRW5kZXJib3JnIHdyb3RlOg0KPj4gVGhpcyBhZGRzIGEgdG90YWwg
dXNlZCBkbWEtYnVmIG1lbW9yeS4gRGV0YWlscw0KPj4gY2FuIGJlIGZvdW5kIGluIGRlYnVnZnMs
IGhvd2V2ZXIgaXQgaXMgbm90IGZvciBldmVyeW9uZQ0KPj4gYW5kIG5vdCBhbHdheXMgYXZhaWxh
YmxlLiBkbWEtYnVmIGFyZSBpbmRpcmVjdCBhbGxvY2F0ZWQgYnkNCj4+IHVzZXJzcGFjZS4gU28g
d2l0aCB0aGlzIHZhbHVlIHdlIGNhbiBtb25pdG9yIGFuZCBkZXRlY3QNCj4+IHVzZXJzcGFjZSBh
cHBsaWNhdGlvbnMgdGhhdCBoYXZlIHByb2JsZW1zLg0KPiBUaGUgY2hhbmdlbG9nIHdvdWxkIGJl
bmVmaXQgZnJvbSBtb3JlIGJhY2tncm91bmQgb24gd2h5IHRoaXMgaXMgbmVlZGVkLA0KPiBhbmQg
d2hvIGlzIHRoZSBwcmltYXJ5IGNvbnN1bWVyIG9mIHRoYXQgdmFsdWUuDQo+DQo+IEkgY2Fubm90
IHJlYWxseSBjb21tZW50IG9uIHRoZSBkbWEtYnVmIGludGVybmFscyBidXQgSSBoYXZlIHR3byBy
ZW1hcmtzLg0KPiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3Byb2MucnN0IG5lZWRzIGFuIHVw
ZGF0ZSB3aXRoIHRoZSBjb3VudGVyDQo+IGV4cGxhbmF0aW9uIGFuZCBzZWNvbmRseSBpcyB0aGlz
IGluZm9ybWF0aW9uIHVzZWZ1bCBmb3IgT09NIHNpdHVhdGlvbnMNCj4gYW5hbHlzaXM/IElmIHll
cyB0aGVuIHNob3dfbWVtIHNob3VsZCBkdW1wIHRoZSB2YWx1ZSBhcyB3ZWxsLg0KPg0KPiBGcm9t
IHRoZSBpbXBsZW1lbnRhdGlvbiBwb2ludCBvZiB2aWV3LCBpcyB0aGVyZSBhbnkgcmVhc29uIHdo
eSB0aGlzDQo+IGhhc24ndCB1c2VkIHRoZSBleGlzdGluZyBnbG9iYWxfbm9kZV9wYWdlX3N0YXRl
IGluZnJhc3RydWN0dXJlPw0KDQpJIGZpeCBkb2MgaW4gbmV4dCB2ZXJzaW9uLsKgIEltIG5vdCBz
dXJlIHdoYXQgeW91IGV4cGVjdCB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gaW5jbHVkZS4NCg0KVGhl
IGZ1bmN0aW9uIG9mIHRoZSBtZW1pbmZvIGlzOiAoRnJvbSBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0
ZW1zL3Byb2MucnN0KQ0KDQoiUHJvdmlkZXMgaW5mb3JtYXRpb24gYWJvdXQgZGlzdHJpYnV0aW9u
IGFuZCB1dGlsaXphdGlvbiBvZiBtZW1vcnkuIg0KDQpJbSBub3QgdGhlIGRlc2lnbmVkIG9mIGRt
YS1idWYsIEkgdGhpbmvCoCBnbG9iYWxfbm9kZV9wYWdlX3N0YXRlIGFzIGEga2VybmVsDQppbnRl
cm5hbC4gZG1hLWJ1ZiBpcyBhIGRldmljZSBkcml2ZXIgdGhhdCBwcm92aWRlcyBhIGZ1bmN0aW9u
IHNvIEkgbWlnaHQgYmUNCm9uIHRoZSBvdXRzaWRlLiBIb3dldmVyIEkgYWxzbyBzZWUgdGhhdCBp
dCBtaWdodCBiZSByZWxldmFudCBmb3IgYSBPT00uDQpJdCBpcyBtZW1vcnkgdGhhdCBjYW4gYmUg
ZnJlZWQgYnkga2lsbGluZyB1c2Vyc3BhY2UgcHJvY2Vzc2VzLg0KDQpUaGUgc2hvd19tZW0gdGhp
bmcuIFNob3VsZCBpdCBiZSBhIHNlcGFyYXRlIHBhdGNoPw0KDQoNCg0KDQo=
