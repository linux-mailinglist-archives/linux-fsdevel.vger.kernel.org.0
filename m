Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175983657AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 13:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhDTLi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 07:38:56 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:32284 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231393AbhDTLiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:38:51 -0400
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KBaD0C028049;
        Tue, 20 Apr 2021 11:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=S1;
 bh=EWMLnQCWyQW+xu5EY6A+vykjbEci9ZXLnB4SuLDR89Y=;
 b=gFMCNkshNB05jLDaoBr/vst189t4u8VoqhxIm8cB2ml4OJYtvTj2nvKwX/oecK9QJNfo
 NF7idi8T/GcsvnSyc4CdWEbitrwRHDJ0ifssxJ7qBUYfU+/FBbPxkXkQG+2rEjhqyUhk
 4TPTsyzr4F24m7Hetonb5mS2uSF5tE1oIGXM5CUKB5wQloLaDGslg4KZSL2Z00ozbruM
 jUGFoG7GNBOjCiiyA4BggEx+e1uSH0mNtGPB3V6XitBaNqyQmTLA6mOJe64zOHGTyuyK
 pya+vKeaiWh9GpZ/GQfQlvOj8f8ek55uO1+dT503yg1LxCjUQO9ALEALEqjKX5jJzsK9 GQ== 
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113])
        by mx08-001d1705.pphosted.com with ESMTP id 37yr2u4cvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 11:37:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh9H30Y5KmFgf54gCvvco0RoRXutWYzoGOJHo3SrZa7mmEfHGF+Tm/tvKcRgT6pBcEwrXkBA3aWQ3NLxlOBIK2gKMyGJYWYEssoGGvtm+gY9d68ogoo8h4DjMQ988hi4MW91vIFJHCLtIFDwTe6JVL0p56A9LrwAIshNgpNS1NYet8nhDk5HzVN7N9EIjg7tknqsLl+bS8+p4+Ug1uwmpIcuv9eeDALA0mQcoOuW0hUwpa45me+8+Ja/RbgbCgeMp055jMm++nPqSBHrThyCtczhh6eI2a9YpcQ+9NoBdLlVz1K1EQJzuB6Zl2PoPaB1RHBUbjRCDClLd251edN8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWMLnQCWyQW+xu5EY6A+vykjbEci9ZXLnB4SuLDR89Y=;
 b=ThQ3VJvkDWt0J4HBhW75l28ou2XNt71BTuX8TKzAhribU69wmXRAcX5ru/QvpmvfD+U3hWixmhJQv8sPMu+1S1qRTulFxQldmCL4zfMzrKv10Cu3vCHNqeWOayatau25eTjN7UpFPNoKglNCDjrhqt/MHwGaNe42HtBDheosqcdOzgJb55Yj7Qk2IpCQes6Lr3CVQ1xl0wJUz2ZcrX4bITSVKJBYfops3TXFqbeiwmUKpSZ3WFySOrVeMV/t9sMAg+W8F1UlFE1SPgS052DniDGNGU0c0+7NV44MxpMmHGMw5wf3UIHX4HP0udchbdzU67X/NtHDobTDUI44eclgZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM9P193MB1411.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:303::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 11:37:41 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 11:37:41 +0000
From:   <Peter.Enderborg@sony.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sumit.semwal@linaro.org>, <christian.koenig@amd.com>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <songmuchun@bytedance.com>, <guro@fb.com>, <shakeelb@google.com>,
        <mhocko@suse.com>, <neilb@suse.de>, <samitolvanen@google.com>,
        <rppt@kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <willy@infradead.org>
Subject: Re: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Topic: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Index: AQHXM6gnmsuLu+Ufhk6GusLEaztxYKq9H2WAgAAHpACAAB5AAIAABooA
Date:   Tue, 20 Apr 2021 11:37:41 +0000
Message-ID: <a60d1eaf-f9f8-e0f3-d214-15ce2c0635c2@sony.com>
References: <20210417163835.25064-1-peter.enderborg@sony.com>
 <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
 <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
 <YH63iPzbGWzb676T@phenom.ffwll.local>
In-Reply-To: <YH63iPzbGWzb676T@phenom.ffwll.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59a4931a-92ff-4e13-bbd4-08d903f0b4f1
x-ms-traffictypediagnostic: AM9P193MB1411:
x-microsoft-antispam-prvs: <AM9P193MB141194A03DDBCB5A0B77645386489@AM9P193MB1411.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNQNnral8qbDT4fJ0HEGjjZbOAW6VrD1OW42T3Ag8o9D65rKFDOW1OWtxnshnlMX/8rRuz1/uNrObts8+idL4/1pltZmUOlEeny1O5RUMGBW4eOBE2QGyPn6OMQ/5yo8vJR0rPm3KuzhauF3OLI6ekexbEGZCYfk6VYG00ewc820TECH4y3ZeO11DZ37pveePuEgZd4hJfpIvjrOSmSPcDrSTouqzdouMdkKDWDDhpv+Hb2s25PxHgylL04+NaQ4YY97gC55vxQ2LIEAmCQoxt6LnnAjJUjhyf++ibZ503KCtnQaOVwXJfs/bgoNwrWbMx2wc1FLW1lsM1GwQklXrEvKdi2/m7mlmL3taBgkD3oFS1pKXKTeP1yEU0Uc4kTEPbUDOLM4dl2zhKcZQzDWe14Z5KX92kxIcmvRwRr4GBdZg1bjLFCSnWoJo/iKYJ8/I3Pk0GzV3rFFs5aKJy3wkbXd99UL0ozfMg5dyfcgLzhCvsMzEQW4MURICMMnUSrDChPzyqOnRtR5t+1TL39wnTAjqWUIDghnKsscnFW0xcuJ50mZXK8FqUHqzqDnixL+7eSiTUtOxfip0NIUSoCU9IVUWJbr5Ef//YSgWX1pS6R5yxFnzoBNXd3udX4ZmfZ5+X0T3D4JwCoG5Q75wVlBBL+iaAagko1Ox3tEkTQQb4SSuxoylrVD1m4M4bpOnZOYso7g/3pHgrssi3E9dk7m8oRFgyC10249egFAZlTSNBMipKSy2REhVSQBRiZrxec1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(8676002)(8936002)(186003)(66556008)(71200400001)(2616005)(66476007)(6486002)(478600001)(66446008)(921005)(83380400001)(31686004)(36756003)(64756008)(31696002)(110136005)(26005)(2906002)(66946007)(76116006)(316002)(38100700002)(122000001)(6506007)(53546011)(5660300002)(91956017)(6512007)(7416002)(86362001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?T2UvMjN1RmgzMkFIRlNXMkV1S0xobnlXc2ExYitxdVVKeEFsQVp5eUFLZjFl?=
 =?utf-8?B?N0g5TVNiZE9JRXpmVy9uSllUL0hQQ09SNUJuSXAzWFZOUHZXRFZJeXdvd0VY?=
 =?utf-8?B?NFN3RzA3QVJpbVpDMVl4UFdFOWxIZUNQVVZrR0JTeE4rb3BpeXAzYTVpTDRH?=
 =?utf-8?B?aWpYMGZ0OUJxK0dEcS90UVhQMGRjdFp0SlRkQ1pUYnZVWUJsUDZZOW1oNWtX?=
 =?utf-8?B?ZFROblJnazY3cGFGbGVCcGN5c2hOQ1E5VXNYYWVqQzNBQkZIUGZ3YVYzSDQx?=
 =?utf-8?B?MHZEZDYyOGIrb29abU1BRUZDRWdFbTlwR0ZvemNxUHd5RlhFbFc0R01VUFZq?=
 =?utf-8?B?a3VGQTZ0Qk1nN3hIUkJDSW1EbzhBdGVLWjZDNDMzNUJlVzhuTVcyemlIeS9n?=
 =?utf-8?B?Wmo4L2hGY1gyNWtBdDR0bm9aakpnVDJXY1pQLzJ0K2FIUGl4Yi9xcnY2YW9Y?=
 =?utf-8?B?NTdIOXJYZVUvOWdTVWJjYnIreS9FQkg2cmdzMitCU2hteU1pdXZKQnYxOE1z?=
 =?utf-8?B?d29RdkFIUWtxRzMrZ3dSLzBuS1pKSmZTaDQ5NmM1OEt4WHZTWitqM1FWWFZK?=
 =?utf-8?B?eksrWWVXblNNaHRMSWVmeGRoTnhEck13U3EzRjBIN2JzQWZ1MDdUVzc3L1BK?=
 =?utf-8?B?d0pCTSt0SS9Bd0ZYN0haZUtNR2lDU0l2R0pjelYvRnVDbkNhd2UxdGhleVkv?=
 =?utf-8?B?MU9XalFiWEIrSjRjVk4rajBKU3FoN01OZTg5cVlpSWRRclc5dnFzQnIrcHB0?=
 =?utf-8?B?Q1ZIRmtkQnpMazRqcjVpcHVxT2V6cUZWRlRXbWVxZDdtZUUveUVoY1dwS2hO?=
 =?utf-8?B?YVp3eVlmbndyZnhpZVQ3OERkY3lZMjdDOFZkRzNJTWtsZ2JlY0JKbU9WaERJ?=
 =?utf-8?B?SmU1NUg5SHIwS3RIVjd5aUJVdVVyNFA1elJDdlZocEdQd1hVM0FuRUFHMzhT?=
 =?utf-8?B?V0wxQ1RjRzFqMGR3KzN0a3R3MzFraWtIMjcrR1IvVWs3N2RpOVhwVEJSZ1hr?=
 =?utf-8?B?UEJPdWdvT3MrQ0Z1S1BpZURYQ21NM1N4NDlMeE95dnVQSmJvS00wYlYwNTVW?=
 =?utf-8?B?aWdVWEhRcytEd1FuV1dhVDUzeEZVbFZwK0tyK2VtaEpIb3pkWUpXdW44QTd1?=
 =?utf-8?B?QmpwMzBJL1JPbWZvOTF6TG9VbjJmaUFzUGtCK0pWT0kxcmYzMEhRSHhHM1VD?=
 =?utf-8?B?c29VRjl1MVl4U3NHQmtreVFmMmVyaHRrQXYrdHlGLytCaFdEZU95YmNIZzhx?=
 =?utf-8?B?aFZkMG9ldUFWeE0wQmV3dS9yL0t6Z3pLVHY4SzVvTjhLcVlsZ0V0RjM1dDJN?=
 =?utf-8?B?dWZuUm55UjNUSG9DTWJpUXRtZXg3RmxMdnQ3c09adjFsUkRDMW1RM1krWlB2?=
 =?utf-8?B?ZzJ4TXhReGlMZFp6RWkwMXgwSGxBME1KeUNldzRoV1dpUGJ4RG5XcllOUzZv?=
 =?utf-8?B?TUM0ZjRFMnkyNTkxcGgyOHdrNUtIVmNqekdPWjlMRWM2d2o4RGlhNkpyNkJY?=
 =?utf-8?B?dENRVVFMQld6MjhrRGsrenQwdkt1eTYzMXUzOFZRQ0lHaUNYcW15OHVDSTJO?=
 =?utf-8?B?cG1TcFJVeFNEdmVLYW1scGZ4Zm5zaExVOWJuNXg1RFZTWU5NSU9jczQ1QjhS?=
 =?utf-8?B?Qmk2SFNmR1ZQWExibmcyRlYyeDBmZHRLejVXL1NQc1VtbmJSVE42UWFzYlQ1?=
 =?utf-8?B?VzhDMVB0eUdSTWN6QnhucmRGcm5LNTVsY1RYN0d6a3ErbXBPQlU1NmZ4MzFZ?=
 =?utf-8?Q?uB4bwjLFVvvMqKjdy+AVIlFPUuvlnS7FjPhYEAK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D15AABA5EB7A2246AE5505CC6C344F4E@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a4931a-92ff-4e13-bbd4-08d903f0b4f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 11:37:41.0808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eAciJecAEXymrCQZtnOPph+uOVONYV9JjWWrOrr+6zn+MwcKB9H2EKddZtnQ3RBhdmaiD6+0C4DCX1eyfyfLOHqyhv2xJW24fDBcNOZGR4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1411
X-Proofpoint-GUID: HIGXyuy3qjd4AAXsyrEH2he-0Rm83_GT
X-Proofpoint-ORIG-GUID: HIGXyuy3qjd4AAXsyrEH2he-0Rm83_GT
X-Sony-Outbound-GUID: HIGXyuy3qjd4AAXsyrEH2he-0Rm83_GT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_02:2021-04-19,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104200089
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yMC8yMSAxOjE0IFBNLCBEYW5pZWwgVmV0dGVyIHdyb3RlOg0KPiBPbiBUdWUsIEFwciAy
MCwgMjAyMSBhdCAwOToyNjowMEFNICswMDAwLCBQZXRlci5FbmRlcmJvcmdAc29ueS5jb20gd3Jv
dGU6DQo+PiBPbiA0LzIwLzIxIDEwOjU4IEFNLCBEYW5pZWwgVmV0dGVyIHdyb3RlOg0KPj4+IE9u
IFNhdCwgQXByIDE3LCAyMDIxIGF0IDA2OjM4OjM1UE0gKzAyMDAsIFBldGVyIEVuZGVyYm9yZyB3
cm90ZToNCj4+Pj4gVGhpcyBhZGRzIGEgdG90YWwgdXNlZCBkbWEtYnVmIG1lbW9yeS4gRGV0YWls
cw0KPj4+PiBjYW4gYmUgZm91bmQgaW4gZGVidWdmcywgaG93ZXZlciBpdCBpcyBub3QgZm9yIGV2
ZXJ5b25lDQo+Pj4+IGFuZCBub3QgYWx3YXlzIGF2YWlsYWJsZS4gZG1hLWJ1ZiBhcmUgaW5kaXJl
Y3QgYWxsb2NhdGVkIGJ5DQo+Pj4+IHVzZXJzcGFjZS4gU28gd2l0aCB0aGlzIHZhbHVlIHdlIGNh
biBtb25pdG9yIGFuZCBkZXRlY3QNCj4+Pj4gdXNlcnNwYWNlIGFwcGxpY2F0aW9ucyB0aGF0IGhh
dmUgcHJvYmxlbXMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFBldGVyIEVuZGVyYm9yZyA8
cGV0ZXIuZW5kZXJib3JnQHNvbnkuY29tPg0KPj4+IFNvIHRoZXJlIGhhdmUgYmVlbiB0b25zIG9m
IGRpc2N1c3Npb25zIGFyb3VuZCBob3cgdG8gdHJhY2sgZG1hLWJ1ZiBhbmQNCj4+PiB3aHksIGFu
ZCBJIHJlYWxseSBuZWVkIHRvIHVuZGVyc3RhbmQgdGhlIHVzZS1jYXNzIGhlcmUgZmlyc3QgSSB0
aGluay4gcHJvYw0KPj4+IHVhcGkgaXMgYXMgbXVjaCBmb3JldmVyIGFzIGFueXRoaW5nIGVsc2Us
IGFuZCBkZXBlbmRpbmcgd2hhdCB5b3UncmUgZG9pbmcNCj4+PiB0aGlzIGRvZXNuJ3QgbWFrZSBh
bnkgc2Vuc2UgYXQgYWxsOg0KPj4+DQo+Pj4gLSBvbiBtb3N0IGxpbnV4IHN5c3RlbXMgZG1hLWJ1
ZiBhcmUgb25seSBpbnN0YW50aWF0ZWQgZm9yIHNoYXJlZCBidWZmZXIuDQo+Pj4gICBTbyB0aGVy
ZSB0aGlzIGdpdmVzIHlvdSBhIGZhaXJseSBtZWFuaW5nbGVzcyBudW1iZXIgYW5kIG5vdCBhbnl0
aGluZw0KPj4+ICAgcmVmbGVjdGluZyBncHUgbWVtb3J5IHVzYWdlIGF0IGFsbC4NCj4+Pg0KPj4+
IC0gb24gQW5kcm9pZCBhbGwgYnVmZmVycyBhcmUgYWxsb2NhdGVkIHRocm91Z2ggZG1hLWJ1ZiBh
ZmFpay4gQnV0IHRoZXJlDQo+Pj4gICB3ZSd2ZSByZWNlbnRseSBoYWQgc29tZSBkaXNjdXNzaW9u
cyBhYm91dCBob3cgZXhhY3RseSB3ZSBzaG91bGQgdHJhY2sNCj4+PiAgIGFsbCB0aGlzLCBhbmQg
dGhlIGNvbmNsdXNpb24gd2FzIHRoYXQgbW9zdCBvZiB0aGlzIHNob3VsZCBiZSBzb2x2ZWQgYnkN
Cj4+PiAgIGNncm91cHMgbG9uZyB0ZXJtLiBTbyBpZiB0aGlzIGlzIGZvciBBbmRyb2lkLCB0aGVu
IEkgZG9uJ3QgdGhpbmsgYWRkaW5nDQo+Pj4gICByYW5kb20gcXVpY2sgc3RvcC1nYXBzIHRvIHVw
c3RyZWFtIGlzIGEgZ29vZCBpZGVhIChiZWNhdXNlIGl0J3MgYSBwcmV0dHkNCj4+PiAgIGxvbmcg
bGlzdCBvZiBwYXRjaGVzIHRoYXQgaGF2ZSBjb21lIHVwIG9uIHRoaXMpLg0KPj4+DQo+Pj4gU28g
d2hhdCBpcyB0aGlzIGZvcj8NCj4+IEZvciB0aGUgb3ZlcnZpZXcuIGRtYS1idWYgdG9kYXkgb25s
eSBoYXZlIGRlYnVnZnMgZm9yIGluZm8uIERlYnVnZnMNCj4+IGlzIG5vdCBhbGxvd2VkIGJ5IGdv
b2dsZSB0byB1c2UgaW4gYW5kb2lkLiBTbyB0aGlzIGFnZ3JlZ2F0ZSB0aGUgaW5mb3JtYXRpb24N
Cj4+IHNvIHdlIGNhbiBnZXQgaW5mb3JtYXRpb24gb24gd2hhdCBnb2luZyBvbiBvbiB0aGUgc3lz
dGVtLsKgDQo+Pg0KPj4gQW5kIHRoZSBMS01MIHN0YW5kYXJkIHJlc3BvbmQgdG8gdGhhdCBpcyAi
U0hPVyBNRSBUSEUgQ09ERSIuDQo+IFllcy4gRXhjZXB0IHRoaXMgZXh0ZW5kcyB0byBob3cgZXhh
Y3RseSB0aGlzIGlzIHN1cHBvc2VkIHRvIGJlIHVzZWQgaW4NCj4gdXNlcnNwYWNlIGFuZCBhY3Rl
ZCB1cG9uLg0KPg0KPj4gV2hlbiB0aGUgdG9wIG1lbWdjIGhhcyBhIGFnZ3JlZ2F0ZWQgaW5mb3Jt
YXRpb24gb24gZG1hLWJ1ZiBpdCBpcyBtYXliZQ0KPj4gYSBiZXR0ZXIgc291cmNlIHRvIG1lbWlu
Zm8uIEJ1dCB0aGVuIGl0IGFsc28gaW1wbHkgdGhhdCBkbWEtYnVmIHJlcXVpcmVzIG1lbWNnLg0K
Pj4NCj4+IEFuZCBJIGRvbnQgc2VlIGFueSBwcm9ibGVtIHRvIHJlcGxhY2UgdGhpcyB3aXRoIHNv
bWV0aGluZyBiZXR0ZXIgd2l0aCBpdCBpcyByZWFkeS4NCj4gVGhlIHRoaW5nIGlzLCB0aGlzIGlz
IHVhcGkuIE9uY2UgaXQncyBtZXJnZWQgd2UgY2Fubm90LCBldmVyLCByZXBsYWNlIGl0Lg0KPiBJ
dCBtdXN0IGJlIGtlcHQgYXJvdW5kIGZvcmV2ZXIsIG9yIGEgdmVyeSBjbG9zZSBhcHByb3hpbWF0
aW9uIHRoZXJlb2YuIFNvDQo+IG1lcmdpbmcgdGhpcyB3aXRoIHRoZSBqdXN0aWZpY2F0aW9uIHRo
YXQgd2UgY2FuIGZpeCBpdCBsYXRlciBvbiBvciByZXBsYWNlDQo+IGlzbid0IGdvaW5nIHRvIGhh
cHBlbi4NCg0KSXQgaXMgaW50ZW5kZWQgdG8gYmUgcmVsZXZhbnQgYXMgbG9uZyB0aGVyZSBpcyBh
IGRtYS1idWYuIFRoaXMgaXMgYSBwcm9wZXINCm1ldHJpYy4gSWYgdGhlIG5ld2VyIGltcGxlbWVu
dGF0aW9ucyBpcyBub3QgZ2V0IHRoZSBzYW1lIHJlc3VsdCBpdCBpcw0Kbm90IGRvaW5nIGl0IHJp
Z2h0IGFuZCBpcyBub3QgYmV0dGVyLiBJZiBhIG1lbWNnIGNvdW50ZXIgb3IgYSBnbG9iYWxfem9u
ZQ0KY291bnRlciBkbyB0aGUgc2FtZSB0aGluZyB0aGV5IGl0IGNhbiByZXBsYWNlIHRoZSBzdWdn
ZXN0ZWQgbWV0aG9kLg0KDQpCdXQgSSBkb250IHRoaW5rIHRoZXkgd2lsbC4gZG1hLWJ1ZiBkb2Vz
IG5vdCBoYXZlIHRvIGJlIG1hcHBlZCB0byBhIHByb2Nlc3MsDQphbmQgdGhlIGNhc2Ugb2YgdnJh
bSwgaXQgaXMgbm90IGNvdmVyZWQgaW4gY3VycmVudCBnbG9iYWxfem9uZS4gQWxsIG9mIHRoZW0N
CndvdWxkIGJlIHZlcnkgbmljZSB0byBoYXZlIGluIHNvbWUgZm9ybS4gQnV0IGl0IHdvbnQgY2hh
bmdlIHdoYXQgdGhlDQpjb3JyZWN0IHZhbHVlIG9mIHdoYXQgIlRvdGFsIiBpcy4NCg0KDQo+IC1E
YW5pZWwNCj4NCj4+PiAtRGFuaWVsDQo+Pj4NCj4+Pj4gLS0tDQo+Pj4+ICBkcml2ZXJzL2RtYS1i
dWYvZG1hLWJ1Zi5jIHwgMTIgKysrKysrKysrKysrDQo+Pj4+ICBmcy9wcm9jL21lbWluZm8uYyAg
ICAgICAgIHwgIDUgKysrKy0NCj4+Pj4gIGluY2x1ZGUvbGludXgvZG1hLWJ1Zi5oICAgfCAgMSAr
DQo+Pj4+ICAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgYi9kcml2
ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jDQo+Pj4+IGluZGV4IGYyNjRiNzBjMzgzZS4uNGRjMzdjZDQy
OTNiIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jDQo+Pj4+ICsr
KyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMNCj4+Pj4gQEAgLTM3LDYgKzM3LDcgQEAgc3Ry
dWN0IGRtYV9idWZfbGlzdCB7DQo+Pj4+ICB9Ow0KPj4+PiAgDQo+Pj4+ICBzdGF0aWMgc3RydWN0
IGRtYV9idWZfbGlzdCBkYl9saXN0Ow0KPj4+PiArc3RhdGljIGF0b21pY19sb25nX3QgZG1hX2J1
Zl9nbG9iYWxfYWxsb2NhdGVkOw0KPj4+PiAgDQo+Pj4+ICBzdGF0aWMgY2hhciAqZG1hYnVmZnNf
ZG5hbWUoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBjaGFyICpidWZmZXIsIGludCBidWZsZW4pDQo+
Pj4+ICB7DQo+Pj4+IEBAIC03OSw2ICs4MCw3IEBAIHN0YXRpYyB2b2lkIGRtYV9idWZfcmVsZWFz
ZShzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+Pj4+ICAJaWYgKGRtYWJ1Zi0+cmVzdiA9PSAoc3Ry
dWN0IGRtYV9yZXN2ICopJmRtYWJ1ZlsxXSkNCj4+Pj4gIAkJZG1hX3Jlc3ZfZmluaShkbWFidWYt
PnJlc3YpOw0KPj4+PiAgDQo+Pj4+ICsJYXRvbWljX2xvbmdfc3ViKGRtYWJ1Zi0+c2l6ZSwgJmRt
YV9idWZfZ2xvYmFsX2FsbG9jYXRlZCk7DQo+Pj4+ICAJbW9kdWxlX3B1dChkbWFidWYtPm93bmVy
KTsNCj4+Pj4gIAlrZnJlZShkbWFidWYtPm5hbWUpOw0KPj4+PiAgCWtmcmVlKGRtYWJ1Zik7DQo+
Pj4+IEBAIC01ODYsNiArNTg4LDcgQEAgc3RydWN0IGRtYV9idWYgKmRtYV9idWZfZXhwb3J0KGNv
bnN0IHN0cnVjdCBkbWFfYnVmX2V4cG9ydF9pbmZvICpleHBfaW5mbykNCj4+Pj4gIAltdXRleF9s
b2NrKCZkYl9saXN0LmxvY2spOw0KPj4+PiAgCWxpc3RfYWRkKCZkbWFidWYtPmxpc3Rfbm9kZSwg
JmRiX2xpc3QuaGVhZCk7DQo+Pj4+ICAJbXV0ZXhfdW5sb2NrKCZkYl9saXN0LmxvY2spOw0KPj4+
PiArCWF0b21pY19sb25nX2FkZChkbWFidWYtPnNpemUsICZkbWFfYnVmX2dsb2JhbF9hbGxvY2F0
ZWQpOw0KPj4+PiAgDQo+Pj4+ICAJcmV0dXJuIGRtYWJ1ZjsNCj4+Pj4gIA0KPj4+PiBAQCAtMTM0
Niw2ICsxMzQ5LDE1IEBAIHZvaWQgZG1hX2J1Zl92dW5tYXAoc3RydWN0IGRtYV9idWYgKmRtYWJ1
Ziwgc3RydWN0IGRtYV9idWZfbWFwICptYXApDQo+Pj4+ICB9DQo+Pj4+ICBFWFBPUlRfU1lNQk9M
X0dQTChkbWFfYnVmX3Z1bm1hcCk7DQo+Pj4+ICANCj4+Pj4gKy8qKg0KPj4+PiArICogZG1hX2J1
Zl9hbGxvY2F0ZWRfcGFnZXMgLSBSZXR1cm4gdGhlIHVzZWQgbnIgb2YgcGFnZXMNCj4+Pj4gKyAq
IGFsbG9jYXRlZCBmb3IgZG1hLWJ1Zg0KPj4+PiArICovDQo+Pj4+ICtsb25nIGRtYV9idWZfYWxs
b2NhdGVkX3BhZ2VzKHZvaWQpDQo+Pj4+ICt7DQo+Pj4+ICsJcmV0dXJuIGF0b21pY19sb25nX3Jl
YWQoJmRtYV9idWZfZ2xvYmFsX2FsbG9jYXRlZCkgPj4gUEFHRV9TSElGVDsNCj4+Pj4gK30NCj4+
Pj4gKw0KPj4+PiAgI2lmZGVmIENPTkZJR19ERUJVR19GUw0KPj4+PiAgc3RhdGljIGludCBkbWFf
YnVmX2RlYnVnX3Nob3coc3RydWN0IHNlcV9maWxlICpzLCB2b2lkICp1bnVzZWQpDQo+Pj4+ICB7
DQo+Pj4+IGRpZmYgLS1naXQgYS9mcy9wcm9jL21lbWluZm8uYyBiL2ZzL3Byb2MvbWVtaW5mby5j
DQo+Pj4+IGluZGV4IDZmYTc2MWM5Y2M3OC4uY2NjN2M0MGM4ZGI3IDEwMDY0NA0KPj4+PiAtLS0g
YS9mcy9wcm9jL21lbWluZm8uYw0KPj4+PiArKysgYi9mcy9wcm9jL21lbWluZm8uYw0KPj4+PiBA
QCAtMTYsNiArMTYsNyBAQA0KPj4+PiAgI2lmZGVmIENPTkZJR19DTUENCj4+Pj4gICNpbmNsdWRl
IDxsaW51eC9jbWEuaD4NCj4+Pj4gICNlbmRpZg0KPj4+PiArI2luY2x1ZGUgPGxpbnV4L2RtYS1i
dWYuaD4NCj4+Pj4gICNpbmNsdWRlIDxhc20vcGFnZS5oPg0KPj4+PiAgI2luY2x1ZGUgImludGVy
bmFsLmgiDQo+Pj4+ICANCj4+Pj4gQEAgLTE0NSw3ICsxNDYsOSBAQCBzdGF0aWMgaW50IG1lbWlu
Zm9fcHJvY19zaG93KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdikNCj4+Pj4gIAlzaG93X3Zh
bF9rYihtLCAiQ21hRnJlZTogICAgICAgICIsDQo+Pj4+ICAJCSAgICBnbG9iYWxfem9uZV9wYWdl
X3N0YXRlKE5SX0ZSRUVfQ01BX1BBR0VTKSk7DQo+Pj4+ICAjZW5kaWYNCj4+Pj4gLQ0KPj4+PiAr
I2lmZGVmIENPTkZJR19ETUFfU0hBUkVEX0JVRkZFUg0KPj4+PiArCXNob3dfdmFsX2tiKG0sICJE
bWFCdWZUb3RhbDogICAgIiwgZG1hX2J1Zl9hbGxvY2F0ZWRfcGFnZXMoKSk7DQo+Pj4+ICsjZW5k
aWYNCj4+Pj4gIAlodWdldGxiX3JlcG9ydF9tZW1pbmZvKG0pOw0KPj4+PiAgDQo+Pj4+ICAJYXJj
aF9yZXBvcnRfbWVtaW5mbyhtKTsNCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZG1h
LWJ1Zi5oIGIvaW5jbHVkZS9saW51eC9kbWEtYnVmLmgNCj4+Pj4gaW5kZXggZWZkYzU2YjlkOTVm
Li41YjA1ODE2YmQyY2QgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi5o
DQo+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi5oDQo+Pj4+IEBAIC01MDcsNCArNTA3
LDUgQEAgaW50IGRtYV9idWZfbW1hcChzdHJ1Y3QgZG1hX2J1ZiAqLCBzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKiwNCj4+Pj4gIAkJIHVuc2lnbmVkIGxvbmcpOw0KPj4+PiAgaW50IGRtYV9idWZfdm1h
cChzdHJ1Y3QgZG1hX2J1ZiAqZG1hYnVmLCBzdHJ1Y3QgZG1hX2J1Zl9tYXAgKm1hcCk7DQo+Pj4+
ICB2b2lkIGRtYV9idWZfdnVubWFwKHN0cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0cnVjdCBkbWFf
YnVmX21hcCAqbWFwKTsNCj4+Pj4gK2xvbmcgZG1hX2J1Zl9hbGxvY2F0ZWRfcGFnZXModm9pZCk7
DQo+Pj4+ICAjZW5kaWYgLyogX19ETUFfQlVGX0hfXyAqLw0KPj4+PiAtLSANCj4+Pj4gMi4xNy4x
DQo+Pj4+DQo+Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQo+Pj4+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QNCj4+Pj4gZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPj4+PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWxfXzshIUptb1pp
WkdCdjNSdktSU3ghcVc4a1VPWnlZNERrZXc2T3ZxZ2ZvTS01dW5RTlZlRl9NMWJpYUlBeVFRQlIw
S0I3a3NSelpqb2gzODJaZEdHUVI5ayQgDQo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KPj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdA0KPj4gZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
X187ISFKbW9aaVpHQnYzUnZLUlN4IXZYdkRnNkk0Vl9fUWRMMmZBMDhSYzV2NnJqRHp4T0lRejZr
d3lNTUxVSzNfZzR6N3FaVGcxSDk4QkREVHhaZVpqSTQkIA0KDQo=
