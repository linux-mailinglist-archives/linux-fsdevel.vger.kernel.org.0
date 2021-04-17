Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBCD362F79
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 13:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhDQLWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Apr 2021 07:22:33 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:51858 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230510AbhDQLWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:22:32 -0400
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13HBLZff009256;
        Sat, 17 Apr 2021 11:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=S1;
 bh=zqPsWJCOc9C8Pp+DMehXSiyn39RxrP8WzzEtpdkIilk=;
 b=Wyl9CnFYwg6VARtnymMaKtpHVgr06fAaE+FGfXc7eLsojzBSoqtb1z7k6eHhB3ztl56r
 Q7DMZgLTUVWRhj8v3ybWi99OmOMwtFlOju9H7O+84jx3EVRxqo3UACR3GQApu0mI0Gym
 OaryOlkfg/l8w2GTKFbGxwz3tkKkLT9smUJO/mhG6IUhfDKvWcFBI0uabTAXENLKmNVl
 FM8CahHVn8vJWo+54j9OmF6BIolBJkv/2QfSxfZfdrhBZjcL9KequrZc+Y3XOnzitG1V
 1QGATCP0ZSqZhpVHVqXoAoRlTOb3qGwdJD1stpbXWV1ckxudx+GP8n7B/7rhZyFgXeOM hQ== 
Received: from eur03-am5-obe.outbound.protection.outlook.com (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56])
        by mx08-001d1705.pphosted.com with ESMTP id 37ynvkr5nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 11:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wlb+SrgWoFv4GqQA1Ls7S3qqERu+0rcZacB7GIntf3xvlu5VQr8dgihPiGf+1FrJnj8NTV4qyfsqE+LtQrUJMQiqegxaNTrY9uOcfF5J1O7FRnZjDaSH9EhIYC669sRZDLbn6nRs9KFvCn2x1YUSFZfyf5j7VzTp5vFa4KbC85qGBOHYCU/bPo0ydiGK2gbe3gZfpZGBM5nbzi9rLa+k4p4Kwgbub/JHuc/Y2sHgAI/WLTK8MHnQNaRt5htVBKxcJQWbVAaGYzr0evOYg0yT/UijqJw7ce/VhgXM9DHSbEmhg5lasgcdhHzpe68ffCItNWVT+u7GH7UWg0VYzxSSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqPsWJCOc9C8Pp+DMehXSiyn39RxrP8WzzEtpdkIilk=;
 b=UmKMByDV91VNax9UoxKmVHf5YQRaipnUKQK/SbpS0THtMB6/nx+2Z4bwKILQ9VALo0iiZVPeknZadmMSZa9iaqoD2I7oFnn3L9e/YQxnnOxoIRhNHvySOe+jv6CbUh/BPN0CHikoTqNTSwhgMT1D4nh915Zuu06+ZAfGFLA+a9Rnmt9Fgwci3D1wP7BdqqhtqhCaZTvm78ry7VqNaiFvtdNpcjt6O8a1TW6ww6JsH1XnBT2230OfZ5qtSQXwsf7gvwVKNbMtNKaWaJsVkV2DUOK+BpI4QcTqHTA1x9RORCxbzYGMwRCLQXS4IOkGf7lNDUhOfTQZhtAqu23MWOlOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM9P193MB1378.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Sat, 17 Apr
 2021 11:20:34 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4042.021; Sat, 17 Apr 2021
 11:20:33 +0000
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
Thread-Index: AQHXM3Yw6ll+UCWErEeaPUdSTn+rzaq4ipMAgAAF3YA=
Date:   Sat, 17 Apr 2021 11:20:33 +0000
Message-ID: <d822adcc-2a3c-1923-0d1d-4ecabd76a0e5@sony.com>
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <d983aef9-3dde-54cc-59a0-d9d42130b513@amd.com>
In-Reply-To: <d983aef9-3dde-54cc-59a0-d9d42130b513@amd.com>
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
x-ms-office365-filtering-correlation-id: f6dbc90a-941d-47c9-9ad2-08d90192d15d
x-ms-traffictypediagnostic: AM9P193MB1378:
x-microsoft-antispam-prvs: <AM9P193MB137859C29525F135697E0B98864B9@AM9P193MB1378.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JZG+m5s7XOZPHo/uERWP2BM1WNtZpmdd00u2Xe3OpwLyjdHm2YNqmynDYzCIn4W4vsGkixKc6kHCc9iivSiw9Q7IzWhX9AFrIZBmFTCfho+ERd/epEmj3fCN9FXToPwFHXzmEujyr/mZNw9OS96sCldzWLNvGWjEuPAbQMhWDjrNjLfZdwh/OXgHfX0s/rhOnFVDSRaGl1YKkyjD6wypIbu8Ft+D6P6FPGffaqsaIne2RLJIAk97qnXUkQBinYmoTQIw05pthQK9IbU9TGr42nor0cXjw7NWIslzg9yYMcxXkt1L2yoMnn91STJLxRwlr7xHhGJLb4uBVkX6BXzygnmPpkxATCrh+sHH83AkdDaQ+5qc0F1Um0Rm5ynmpNZODtr1cScuf0ozJgtI3Oxd4SFKNJBnu3iwpVRbr9DlzsnB1styzPdTE9sW8E+JpOMzddJAbTrOlhByiTdk9dCtqlg2IYvMCsPjNg+HHw6T/5ihxM7ai2a8wKPok6wuKtQ78PiMYpU9+QPwofPc0Q5gdbnaHJyjFStelCmY4g5iMkYZJ0OGPQcEC/RpHGRr8X0d/LWpriqBsnC5qJ2JGj57kY+OfFspA+xSqKveBz2pSvaXRWAGyRj2xfg7QNlp1axLmpgxvQpYbMw40voGYET3lcu+WK5zACBp0UENwPgNsbsT93GAn18t5FN2iAVyZxY+KSsXc3Xbdh6pablM3Xp9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(53546011)(83380400001)(6506007)(71200400001)(66574015)(6486002)(5660300002)(316002)(8936002)(921005)(110136005)(66476007)(36756003)(26005)(91956017)(76116006)(66556008)(64756008)(66446008)(66946007)(122000001)(6512007)(186003)(8676002)(7416002)(86362001)(38100700002)(31696002)(2616005)(478600001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aG5vaGJGUjRSZGZNMVpucDRvVGtNN096ZDVmWlZ4MGlHRktyYlJhN2UxSWc5?=
 =?utf-8?B?QTNsT1FDNzhadVZaaXA5WFAvVDdyTG5CejF2R2c5WnZITGxmWUg0cHQ5cVJr?=
 =?utf-8?B?dkhPZmdwMFZEb3VCZGV6eWt3SE83RWNzdWRuSGJnTG1MaWFmMjRtQzVubW1I?=
 =?utf-8?B?a096WHp5a29ZQnEzaVNOWXdublRhb1lGSmpRNkJLTDJBU2NIcFNuRUNLMjFh?=
 =?utf-8?B?d3ROdm5aUG5TWVVtckxyZGpaZ3pNdUErWGVPYXcwR0g0ZkJMZ3dsOHltSTF4?=
 =?utf-8?B?NktRV3RzekRxNkdSeE4zY3JPVkZxYTl1NWdEYWE2Wk84Wk0yQkYyWHZCMlA1?=
 =?utf-8?B?NzlVZTgrb2RxR200cjQ3clJ5TTE3Vmt3eGQwVHRkdnJzZ1dRWHU2TVlXUDdM?=
 =?utf-8?B?ZndJQTNmVE9FQldUM1pBS1hmYmVpY2liV0xDVVV4YW9CQmhGUFRKL04yaTR4?=
 =?utf-8?B?a3JvYTJvOGNjK3EyMmNxUU0xQjdtRE1FV1R0S240OTUxQWorR0luM00yQ04v?=
 =?utf-8?B?aldGWSs3ZVJ0YTErc3Q0YVNaT3JKS3ZwUGl4ODNMcDZQT2VYbHZ1R1lXb3Q3?=
 =?utf-8?B?NlVqUXVHa2dwZkErR0lFa3J1bmgrWS93bzZDNFU4Ui9OckVlc0Z1YU42SlYw?=
 =?utf-8?B?VjVUc2x0dlhHNS93VDRaZmFkOTZJYXVUOEQ1UHVnalN4bHhZSjd6QUFxaXRG?=
 =?utf-8?B?MHFoYnFqRHNVaGxpZDU3d29zbFNtRUROdjN5RkMxTHNpSEorWG9GaFk2NTFQ?=
 =?utf-8?B?TUdTL2dwYkxlaWRyZ1VVd0REdnZoSkg3clVWZmsyeVh1dGdEc3paN0N6QkhE?=
 =?utf-8?B?WlhEcDdKaGNqNU1GZktGMCs4Wk9oVHZTSzcrdVFycXdPQ2d0RzFzS2o1YlVq?=
 =?utf-8?B?K0h0VU1yS2pJWE5henVsVXdSTmNBdWxxUnA5aW43ZGVmYWNvQ29POWEzK1ZK?=
 =?utf-8?B?RStPcnBvajBnRTgrSFZvb2l3cGt5MmF3eTEwSlYxd2E5cGxmclBNK3hIanl6?=
 =?utf-8?B?dGRpNDJFYzZTR0tuQ3FjL1JOR0FsRXN4Q2padVdIbEMxUkZlL2NEK2ZJYnpW?=
 =?utf-8?B?cGFDSGpSOE1xT2ljWlBqZ3BnRmZEeFdqK3NiSUluc2JodEVhRGIvTzlZcEVi?=
 =?utf-8?B?anE1bmhETm4rODlDSWsvWVVYOXJmT1JITGQ2MGR4SU85bE41bGJTdEo1K2Q5?=
 =?utf-8?B?U2RRNjlERzVIUU12Z2t3UEYvdElwTFdPN25zNGF3NFpGMyttK09XSGxQRzRD?=
 =?utf-8?B?dXFoaUpXQWt3eTZxY2dwWURzQU1KMEdMVUpIamV1dFlEblcwLys3RzBmSDZV?=
 =?utf-8?B?cWcwNlIvMWl6SUl0SUNiVFlMdWNHdlhTeTU3a2VLc2RSa0Z4aXZFSWpQUyt4?=
 =?utf-8?B?dGZxMklJTzhHbTJIcW1mNkZRblN3cnA5a1lZOFFzNlMvYVMzVzk4UlRsRmd5?=
 =?utf-8?B?bXRtOElxU3F2OWpicTdCRVE3TkFuNStXRkFKNUpoWDBPbTNmRUlFL2F2bHdF?=
 =?utf-8?B?SnhZdGM4Tis4TkxCRlFBRUswa3VTYkcyMkQ0MkNKaVNmZFFjd2tSZFpaZEV5?=
 =?utf-8?B?cTZwVThOQ3NQcjJCd0g2dWw2cmthaEtuclJPS0N0ZklpMTR3cFRoY2h3YkJj?=
 =?utf-8?B?VDVsV0xUSk1ReFljZ3l5dlpLdm5jd0twQm9DblZsa25RMHVKU2l0cnlNUEp5?=
 =?utf-8?B?Yy9qYXV6SmsxZGlRdGRXbnU4ZFkvemJTZ250SlQwVG43MXV2bWFvWnQ4ZEZV?=
 =?utf-8?Q?WDk0fzoo5TlFLJlOTHlnL5R/NsNjnFaZp7YMylK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <761562F745B4D942B9D3E6EADEE42593@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dbc90a-941d-47c9-9ad2-08d90192d15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2021 11:20:33.7906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09xHtOKH8L/DXKZXVEY/fJq1CT7hwVl2b8vPSdVmtDR1SE5gxGLNT/40L618xgZACu5L//NemnGXa60qCRXxKGxj3Jpxsu65sFTnQs2HhWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1378
X-Proofpoint-ORIG-GUID: KI5u0z5_v7RsmfwxIZ0_8JQ5DDlxcp4E
X-Proofpoint-GUID: KI5u0z5_v7RsmfwxIZ0_8JQ5DDlxcp4E
X-Sony-Outbound-GUID: KI5u0z5_v7RsmfwxIZ0_8JQ5DDlxcp4E
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-17_06:2021-04-16,2021-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104170080
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xNy8yMSAxMjo1OSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4gQW0gMTcuMDQu
MjEgdW0gMTI6NDAgc2NocmllYiBQZXRlciBFbmRlcmJvcmc6DQo+PiBUaGlzIGFkZHMgYSB0b3Rh
bCB1c2VkIGRtYS1idWYgbWVtb3J5LiBEZXRhaWxzDQo+PiBjYW4gYmUgZm91bmQgaW4gZGVidWdm
cywgaG93ZXZlciBpdCBpcyBub3QgZm9yIGV2ZXJ5b25lDQo+PiBhbmQgbm90IGFsd2F5cyBhdmFp
bGFibGUuIGRtYS1idWYgYXJlIGluZGlyZWN0IGFsbG9jYXRlZCBieQ0KPj4gdXNlcnNwYWNlLiBT
byB3aXRoIHRoaXMgdmFsdWUgd2UgY2FuIG1vbml0b3IgYW5kIGRldGVjdA0KPj4gdXNlcnNwYWNl
IGFwcGxpY2F0aW9ucyB0aGF0IGhhdmUgcHJvYmxlbXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
UGV0ZXIgRW5kZXJib3JnIDxwZXRlci5lbmRlcmJvcmdAc29ueS5jb20+DQo+DQo+IFJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+DQo+IEhv
dyBkbyB5b3Ugd2FudCB0byB1cHN0cmVhbSB0aGlzPw0KDQpJIGRvbid0IHVuZGVyc3RhbmQgdGhh
dCBxdWVzdGlvbi4gVGhlIHBhdGNoIGFwcGxpZXMgb24gVG9ydmFsZHMgNS4xMi1yYzcsDQpidXQg
SSBndWVzcyA1LjEzIGlzIHdoYXQgd2Ugd29yayBvbiByaWdodCBub3cuDQoNCj4NCj4+IC0tLQ0K
Pj4gwqAgZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYyB8IDEzICsrKysrKysrKysrKysNCj4+IMKg
IGZzL3Byb2MvbWVtaW5mby5jwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKysrLQ0KPj4gwqAgaW5j
bHVkZS9saW51eC9kbWEtYnVmLmjCoMKgIHzCoCAxICsNCj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwg
MTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYw0KPj4gaW5k
ZXggZjI2NGI3MGMzODNlLi4xOTdlNWM0NWRkMjYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2Rt
YS1idWYvZG1hLWJ1Zi5jDQo+PiArKysgYi9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jDQo+PiBA
QCAtMzcsNiArMzcsNyBAQCBzdHJ1Y3QgZG1hX2J1Zl9saXN0IHsNCj4+IMKgIH07DQo+PiDCoCDC
oCBzdGF0aWMgc3RydWN0IGRtYV9idWZfbGlzdCBkYl9saXN0Ow0KPj4gK3N0YXRpYyBhdG9taWNf
bG9uZ190IGRtYV9idWZfZ2xvYmFsX2FsbG9jYXRlZDsNCj4+IMKgIMKgIHN0YXRpYyBjaGFyICpk
bWFidWZmc19kbmFtZShzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIGNoYXIgKmJ1ZmZlciwgaW50IGJ1
ZmxlbikNCj4+IMKgIHsNCj4+IEBAIC03OSw2ICs4MCw3IEBAIHN0YXRpYyB2b2lkIGRtYV9idWZf
cmVsZWFzZShzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+PiDCoMKgwqDCoMKgIGlmIChkbWFidWYt
PnJlc3YgPT0gKHN0cnVjdCBkbWFfcmVzdiAqKSZkbWFidWZbMV0pDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgZG1hX3Jlc3ZfZmluaShkbWFidWYtPnJlc3YpOw0KPj4gwqAgK8KgwqDCoCBhdG9taWNf
bG9uZ19zdWIoZG1hYnVmLT5zaXplLCAmZG1hX2J1Zl9nbG9iYWxfYWxsb2NhdGVkKTsNCj4+IMKg
wqDCoMKgwqAgbW9kdWxlX3B1dChkbWFidWYtPm93bmVyKTsNCj4+IMKgwqDCoMKgwqAga2ZyZWUo
ZG1hYnVmLT5uYW1lKTsNCj4+IMKgwqDCoMKgwqAga2ZyZWUoZG1hYnVmKTsNCj4+IEBAIC01ODYs
NiArNTg4LDcgQEAgc3RydWN0IGRtYV9idWYgKmRtYV9idWZfZXhwb3J0KGNvbnN0IHN0cnVjdCBk
bWFfYnVmX2V4cG9ydF9pbmZvICpleHBfaW5mbykNCj4+IMKgwqDCoMKgwqAgbXV0ZXhfbG9jaygm
ZGJfbGlzdC5sb2NrKTsNCj4+IMKgwqDCoMKgwqAgbGlzdF9hZGQoJmRtYWJ1Zi0+bGlzdF9ub2Rl
LCAmZGJfbGlzdC5oZWFkKTsNCj4+IMKgwqDCoMKgwqAgbXV0ZXhfdW5sb2NrKCZkYl9saXN0Lmxv
Y2spOw0KPj4gK8KgwqDCoCBhdG9taWNfbG9uZ19hZGQoZG1hYnVmLT5zaXplLCAmZG1hX2J1Zl9n
bG9iYWxfYWxsb2NhdGVkKTsNCj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIGRtYWJ1ZjsNCj4+IMKg
IEBAIC0xMzQ2LDYgKzEzNDksMTYgQEAgdm9pZCBkbWFfYnVmX3Z1bm1hcChzdHJ1Y3QgZG1hX2J1
ZiAqZG1hYnVmLCBzdHJ1Y3QgZG1hX2J1Zl9tYXAgKm1hcCkNCj4+IMKgIH0NCj4+IMKgIEVYUE9S
VF9TWU1CT0xfR1BMKGRtYV9idWZfdnVubWFwKTsNCj4+IMKgICsvKioNCj4+ICsgKiBkbWFfYnVm
X2FsbG9jYXRlZF9wYWdlcyAtIFJldHVybiB0aGUgdXNlZCBuciBvZiBwYWdlcw0KPj4gKyAqIGFs
bG9jYXRlZCBmb3IgZG1hLWJ1Zg0KPj4gKyAqLw0KPj4gK2xvbmcgZG1hX2J1Zl9hbGxvY2F0ZWRf
cGFnZXModm9pZCkNCj4+ICt7DQo+PiArwqDCoMKgIHJldHVybiBhdG9taWNfbG9uZ19yZWFkKCZk
bWFfYnVmX2dsb2JhbF9hbGxvY2F0ZWQpID4+IFBBR0VfU0hJRlQ7DQo+PiArfQ0KPj4gK0VYUE9S
VF9TWU1CT0xfR1BMKGRtYV9idWZfYWxsb2NhdGVkX3BhZ2VzKTsNCj4+ICsNCj4+IMKgICNpZmRl
ZiBDT05GSUdfREVCVUdfRlMNCj4+IMKgIHN0YXRpYyBpbnQgZG1hX2J1Zl9kZWJ1Z19zaG93KHN0
cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqdW51c2VkKQ0KPj4gwqAgew0KPj4gZGlmZiAtLWdpdCBh
L2ZzL3Byb2MvbWVtaW5mby5jIGIvZnMvcHJvYy9tZW1pbmZvLmMNCj4+IGluZGV4IDZmYTc2MWM5
Y2M3OC4uY2NjN2M0MGM4ZGI3IDEwMDY0NA0KPj4gLS0tIGEvZnMvcHJvYy9tZW1pbmZvLmMNCj4+
ICsrKyBiL2ZzL3Byb2MvbWVtaW5mby5jDQo+PiBAQCAtMTYsNiArMTYsNyBAQA0KPj4gwqAgI2lm
ZGVmIENPTkZJR19DTUENCj4+IMKgICNpbmNsdWRlIDxsaW51eC9jbWEuaD4NCj4+IMKgICNlbmRp
Zg0KPj4gKyNpbmNsdWRlIDxsaW51eC9kbWEtYnVmLmg+DQo+PiDCoCAjaW5jbHVkZSA8YXNtL3Bh
Z2UuaD4NCj4+IMKgICNpbmNsdWRlICJpbnRlcm5hbC5oIg0KPj4gwqAgQEAgLTE0NSw3ICsxNDYs
OSBAQCBzdGF0aWMgaW50IG1lbWluZm9fcHJvY19zaG93KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9p
ZCAqdikNCj4+IMKgwqDCoMKgwqAgc2hvd192YWxfa2IobSwgIkNtYUZyZWU6wqDCoMKgwqDCoMKg
wqAgIiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdsb2JhbF96b25lX3BhZ2Vfc3Rh
dGUoTlJfRlJFRV9DTUFfUEFHRVMpKTsNCj4+IMKgICNlbmRpZg0KPj4gLQ0KPj4gKyNpZmRlZiBD
T05GSUdfRE1BX1NIQVJFRF9CVUZGRVINCj4+ICvCoMKgwqAgc2hvd192YWxfa2IobSwgIkRtYUJ1
ZlRvdGFsOsKgwqDCoCAiLCBkbWFfYnVmX2FsbG9jYXRlZF9wYWdlcygpKTsNCj4+ICsjZW5kaWYN
Cj4+IMKgwqDCoMKgwqAgaHVnZXRsYl9yZXBvcnRfbWVtaW5mbyhtKTsNCj4+IMKgIMKgwqDCoMKg
wqAgYXJjaF9yZXBvcnRfbWVtaW5mbyhtKTsNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2RtYS1idWYuaCBiL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi5oDQo+PiBpbmRleCBlZmRjNTZiOWQ5
NWYuLjViMDU4MTZiZDJjZCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi5o
DQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaA0KPj4gQEAgLTUwNyw0ICs1MDcsNSBA
QCBpbnQgZG1hX2J1Zl9tbWFwKHN0cnVjdCBkbWFfYnVmICosIHN0cnVjdCB2bV9hcmVhX3N0cnVj
dCAqLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyk7DQo+PiDCoCBpbnQg
ZG1hX2J1Zl92bWFwKHN0cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0cnVjdCBkbWFfYnVmX21hcCAq
bWFwKTsNCj4+IMKgIHZvaWQgZG1hX2J1Zl92dW5tYXAoc3RydWN0IGRtYV9idWYgKmRtYWJ1Ziwg
c3RydWN0IGRtYV9idWZfbWFwICptYXApOw0KPj4gK2xvbmcgZG1hX2J1Zl9hbGxvY2F0ZWRfcGFn
ZXModm9pZCk7DQo+PiDCoCAjZW5kaWYgLyogX19ETUFfQlVGX0hfXyAqLw0KPg0K
