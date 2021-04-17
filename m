Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF7362EE0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 11:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhDQJ3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Apr 2021 05:29:37 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:42110 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229972AbhDQJ3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:29:36 -0400
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13H9Sb4h010470;
        Sat, 17 Apr 2021 09:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=ve5QJYCUvFvhZLFwJI3XlTuc2W2vaYTVLaHxPDx/Np4=;
 b=LLiOZmp5wyj8/6tjyD+3/zepv0/aiIgTKwW1eHyoigVYJdzEqdIMLNPDKNMyGsOPvzga
 W5Ni62krz4ZTVWGLBSuR0W/wpP5jFwZ5SkQB4j7YgOfcVKv52+gqYuvkcSXqCdn8Qhol
 iLUHQgQocNEwtmuRn7vUQavFTcLzYALt0ksftnjyiuq5oVyQNLDQiB5sE5ngvmDy/Vqt
 Nxd9MadgUiXYxiU26pPUXsqjaXZMAEqG4O/STAlevWq/Nzm2847QAWVnUiiHG9aNyxzo
 nuXXvoH0UHCT8RUzch+yx9ZFazHY/S7B8mrn7GkQxTK7UG8rVWSt6ToLsn7yBZWGLRIj cQ== 
Received: from eur01-he1-obe.outbound.protection.outlook.com (mail-he1eur01lp2056.outbound.protection.outlook.com [104.47.0.56])
        by mx08-001d1705.pphosted.com with ESMTP id 37ynvkr4mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 09:28:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjWRKQain19OR4ZYP9GkdBg4xq17PzafBE54nI9Mvj7JwAIo9LuzgxuDQjxPBpE7UtFT6ExKV8sruDm1zyZ5A/oUECJHJKSSicryypIzG3h3m/uIr0i4FzzJn16E8lf5xTxhl+a/vJUjr9RCxvDdjMSaAMQrunMjmswgRXBGWKOyl/xV/qDwS8KMJAKkI8SmDIzhjuAGn8RXhLTbRpOfY+GFE+Gf83y31JtD/HzbYxgF9SwBKt2mb0TuY4a8QJr1jaU88EpkFUaGNv/CQPtbC9gkRT+oRZKfo5dtd8SpdEPY/DCaySZ9/8IeghlHZb/Z4gX+XISfKFDUKawiuQyi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve5QJYCUvFvhZLFwJI3XlTuc2W2vaYTVLaHxPDx/Np4=;
 b=YqUjmBl4QOeG853bvKOTHyQQXg8V/wTD+rOxfTgklYgnKJAiqaxKe4rpRqXmM+zWdcsPR9IWJ4CybYhUmJcTB2QN1QwlVTFNAWJhqL8QCWHWxt6IZovMDsMKjU+WxFcWx6Y6lFTFv2WZ+g5kgCd49XHT422/DE5d2VQ/YwRhTNI61qXwByxFdjoI3R7fRQh2jWmqGuloSUNjSBF8IGqRRt3XV731SrNLL6+fIcaBVjcs+L+sVo1HzL0T/gQqVQZ1XtEqZdwgcSKA2WRP3Ya+MIxW9Yk+8fjbIASrvbLpE0jO+FMjHMtLR6a9828yDr7/CO5vfAcQEFuUM/ljbSUBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM9P193MB1825.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Sat, 17 Apr
 2021 09:28:15 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4042.021; Sat, 17 Apr 2021
 09:28:13 +0000
From:   <Peter.Enderborg@sony.com>
To:     <songmuchun@bytedance.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sumit.semwal@linaro.org>, <christian.koenig@amd.com>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <guro@fb.com>,
        <shakeelb@google.com>, <mhocko@suse.com>, <neilb@suse.de>,
        <samitolvanen@google.com>, <rppt@kernel.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <willy@infradead.org>
Subject: Re: [External] [PATCH v3] dma-buf: Add DmaBufTotal counter in meminfo
Thread-Topic: [External] [PATCH v3] dma-buf: Add DmaBufTotal counter in
 meminfo
Thread-Index: AQHXMtqvvAyXQy8bs0eJZhEnkt5Q8qq4BzoAgABq/wA=
Date:   Sat, 17 Apr 2021 09:28:13 +0000
Message-ID: <6de29664-bd8d-b744-2222-3c56cbf8a2e1@sony.com>
References: <20210416160754.2944-1-peter.enderborg@sony.com>
 <CAMZfGtWtUkP69v3NDy8=k1Ze1OriJ3TWeY9868TTdzbQ4LJ5AA@mail.gmail.com>
In-Reply-To: <CAMZfGtWtUkP69v3NDy8=k1Ze1OriJ3TWeY9868TTdzbQ4LJ5AA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d79d2cc-047b-4eb8-f72b-08d901831fa7
x-ms-traffictypediagnostic: AM9P193MB1825:
x-microsoft-antispam-prvs: <AM9P193MB1825F5605360FB0BA5ADA97F864B9@AM9P193MB1825.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0oONAdy1VPjfKR+9EVtBctHtZW3oOKadX1QrKG3f1RtBBO0eiNNCw4jPXCatuJzGuBJpxE/y77Ktp1PuDV6UmJ01U+UKYuWK0HQ9j6+IU2WqxS4Gis13XZbXDRr8KPgyh+jdcjgJWEKMo4g5rvtaoeimi2LupT/wM2MHnw9S2roItXYwnhuNa7KZ28dxWGbEa5ZGu7AhnIRhjo0+EyeTiIXdiVkYxO1EptvPMJUPdChzzNUVp7XbunySLV+sIiyUCJDUpmWrTO7ongVCGd8WNkVKBtcu0RX1CS3JxZ8hm6QI4R1Hgd6G4CAQcyOz3Ju//WCjitsZy681ZgIqPJoyJ4/Z/0GneHE5vNzcrtyrB8VoVjqTefxuKWY/RKzHnavt3zk2oQr11fa5RLh507cMx4668VzCyRk8FM9OsoyuehNYOkT7L42jCW1wi0kgGzIuGKE0Sz7uS5QXRXPZFednQnxmyd9rh/AWAxgggP5ifIrF+NbAfNTNie46pWHmBp4ILPw1yAAqCRk8hoHIt6FBv278+caAWzSfFYmXPRYqpq5s9aH4knACMtY4LhC2M7laErDQMurjJ8A8oHlvbsMCv1CDcdcdVuTxi9lsKH8z2qHpJYkUE5RPEI0F7LFweXRHXv2lZ+9PtI5//OtsalWscClfcjiIeMmGPNOdKzjBaJ9FwP3mzf1uU7q0DL76T/H2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(366004)(346002)(376002)(38100700002)(26005)(5660300002)(36756003)(64756008)(8936002)(6486002)(66446008)(4326008)(66476007)(31686004)(91956017)(122000001)(31696002)(66556008)(66946007)(2906002)(8676002)(6512007)(86362001)(316002)(54906003)(6916009)(53546011)(76116006)(6506007)(7416002)(2616005)(71200400001)(478600001)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?a1JoNHVBT211VDlCQnhBQldDTjgyTjRiaHhRVW5reHh1cGRMOW82aE0rRThM?=
 =?utf-8?B?TkUyK0N0TmhBY3l5c2R5dUxEQzloQUtiLy95b2hxUUxZQjdWaU9CNWhtcWIx?=
 =?utf-8?B?a0Y3WmNyZFhpaGpWWUxKaUt1MlFEWGNONExPMmpoUXRWUVZFOVduaTNJQUVF?=
 =?utf-8?B?Z29uSjk5cldyU0NXazhVdnh6clZiU3FLajdod2U2eWptb2xLR3NhODBuRzZN?=
 =?utf-8?B?OGRtKzBCOWhCVGUyNE1tVGFoUUlNQjgrTWlDQUVVMmJTUXFTRXBCSzRNWlZx?=
 =?utf-8?B?clhPVG9CbUJ1RWdVOFl3SmEvZ1lNOWptb1k4WHRNU1JMelZvVW9URWMzay8v?=
 =?utf-8?B?MWJZRUhLaGdZZ2pXSkY5V3BiWHBZRGZESHVWYjBXdnF5M0psd0prQTJ3M1di?=
 =?utf-8?B?M2JSRHV5VEN3OE5zdXBwM0lFY3NKaTd3WWRYTWpoa08zOVRReTZhRG1yd2FJ?=
 =?utf-8?B?M1VDc2kva0cyTFNjWkRoQUwrcS93L29udkdWbVdnNi9zSkl4blRQbXpOY0d1?=
 =?utf-8?B?NnlsencwcHhyclZYcFN6QlI2RkpPRnJDWlBta3QwMzFzaDVWUnFpMW5UUG1D?=
 =?utf-8?B?dldJSHZteUQyK042MGtnMGszWUo2QjQxcVdBWUt5eTFzUjJEb3ltMmRMbGpk?=
 =?utf-8?B?NXVySGJuTmdlSXJnUkRUd2gwVisveTdhL2M0c1pCNThFeENGMlV1eWx2Mkc5?=
 =?utf-8?B?NmJzdXJqMzNzSzRtRmxydFJyS3Q0TzRodHE1bEIrdjcvaStzcEtMTmhHa214?=
 =?utf-8?B?dldMcmRCVkptUzUyWW4xYmJCbzNhTWs2bDZWWVZxZW1jMnBUYS9MUUc4eVZv?=
 =?utf-8?B?ZCtQa1hLQys4ZDhDWllUOXBBRlExemhmQjhOV1JMby9haEw1amNpc255amRO?=
 =?utf-8?B?MUdKNGMwZEN2aFIvWkk2NFFyNVJXQ09CNVNFNFlLYll6MjZuN2tDN29DMThD?=
 =?utf-8?B?ZzF0TUdvUXlDMis4cnc4bjN1djhVbXdUVVpTbGhYZ3ExRzdCdmswc2FWdXkw?=
 =?utf-8?B?UzkzdXlLUlJLOFhwQlIyd0dkUCtQT1BvdWdSNWRQNWJzbkE0Qm0zaFhCcUJZ?=
 =?utf-8?B?dFZZWm0rSUdLNnpnMWdmaXNnV1YrR2NnZ2RXdUxZZlQyVk9sbjR5a3pHbFZY?=
 =?utf-8?B?eWRNWU9rS0lHRW5NUDVjMk1QWm0yc3h3RHNsQXRKbzVzS0tDZGVJMHpETTE4?=
 =?utf-8?B?aXNhVkRxNWtNdElxdWE3UzFoZ1ZaMXFORTFFZTJ6TUpJb3RmdFVyc2F5L1Bx?=
 =?utf-8?B?K25PeFBuTi9OYW1SeSsrYnlxQU1iUXhsQ0NGYllRTDcvOXJPRGFXU2s2MDNm?=
 =?utf-8?B?R0JEdFFBa1V5c0REL3BvZVJtcDRheE9CdnBZdHE5UTFpN29SRGhlWHBxS2c1?=
 =?utf-8?B?cnRDc3VUeHZnN3ZINEZnM0N5UEovUVBSQ1pqMkJVSlJ4aVMwcW5XaE42YytQ?=
 =?utf-8?B?bmFsaVBOaXF4Y0VQQ20xVSs0ZHI0Ymw1ZDJGYkIvM0VpQ3B6dEt5WnFLb0ZH?=
 =?utf-8?B?WE1tV001WVZXU3A5S2hMWTl3NnZsei90ZTRlWnVmdWZ2bnhBVFpzWS85OHdH?=
 =?utf-8?B?aDhoRzRFbnJDRmVKc3pWaTQ2TDVQMHkwSUlaU1hOcnlWVGo1TElkbWo3UDgv?=
 =?utf-8?B?OVJzWkRuc0EzQ3k1YTZZNnBwcTB6Qi80YzAvNnhsNXVIVE9NdUloSHJQS2dl?=
 =?utf-8?B?c0txVm9tNGpGQ3VYQmhIbGt4Rk1vdlVrOVhTak1yOUptUU8vS1ZjSjh2UDhq?=
 =?utf-8?Q?efUVRYlXtR3Ndy+75970gJTtUsS+c7wFdm6cJR8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC8F907A6E190D448E4A3A3AF4470B07@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d79d2cc-047b-4eb8-f72b-08d901831fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2021 09:28:13.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AV9EGjycIEDxCzlxfE0s6rKUBOOAsyAnuJ2NzOHjJqmEBpdy60SaOqlRRocppEYkGsMvl3k7HBk2o0CaJqzQ32hCpogYqAckLqLxrzUXuI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1825
X-Proofpoint-ORIG-GUID: X_2V1dMPgIeQ0A8rY4_B7wCst3Oq2-qC
X-Proofpoint-GUID: X_2V1dMPgIeQ0A8rY4_B7wCst3Oq2-qC
X-Sony-Outbound-GUID: X_2V1dMPgIeQ0A8rY4_B7wCst3Oq2-qC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-17_06:2021-04-16,2021-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104170065
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xNy8yMSA1OjA1IEFNLCBNdWNodW4gU29uZyB3cm90ZToNCj4gT24gU2F0LCBBcHIgMTcs
IDIwMjEgYXQgMTI6MDggQU0gUGV0ZXIgRW5kZXJib3JnDQo+IDxwZXRlci5lbmRlcmJvcmdAc29u
eS5jb20+IHdyb3RlOg0KPj4gVGhpcyBhZGRzIGEgdG90YWwgdXNlZCBkbWEtYnVmIG1lbW9yeS4g
RGV0YWlscw0KPj4gY2FuIGJlIGZvdW5kIGluIGRlYnVnZnMsIGhvd2V2ZXIgaXQgaXMgbm90IGZv
ciBldmVyeW9uZQ0KPj4gYW5kIG5vdCBhbHdheXMgYXZhaWxhYmxlLiBkbWEtYnVmIGFyZSBpbmRp
cmVjdCBhbGxvY2F0ZWQgYnkNCj4+IHVzZXJzcGFjZS4gU28gd2l0aCB0aGlzIHZhbHVlIHdlIGNh
biBtb25pdG9yIGFuZCBkZXRlY3QNCj4+IHVzZXJzcGFjZSBhcHBsaWNhdGlvbnMgdGhhdCBoYXZl
IHByb2JsZW1zLg0KPiBJIHdhbnQgdG8ga25vdyBtb3JlIGRldGFpbHMgYWJvdXQgdGhlIHByb2Js
ZW1zLg0KPiBDYW4geW91IHNoYXJlIHdoYXQgcHJvYmxlbXMgeW91IGhhdmUgZW5jb3VudGVyZWQ/
DQo+DQo+IFRoYW5rcy4NCg0KV2hhdCBkbyB5b3UgZXhwZWN0IHRvIGJlIHJlbGV2YW50IGZvciB0
aGUga2VybmVsPyBBcHBsaWNhdGlvbnMgdGhhdCBsZWFrcw0KaXMgbm90IHRoYXQgaW1wb3J0YW50
LiBUaGlzIHR5cGVzIG9mIGJ1ZmZlcnMgYXJlIGltcG9ydGFudCBmb3IgYW5kcm9pZA0KYXBwbGlj
YXRpb25zLCBhbmQgYW5kcm9pZCBoYXZlIG1vdmVkIGEgZnJvbSBJT04gYnVmZmVycyB0aGF0IGhh
cw0KbWV0cmljcy4gSXQgZWFzaWx5IGdldCBpbiB0byA1LTEwIHBlcmNlbnQgb2YgdGhlIHRvdGFs
IGFtb3VudCByYW0uDQoNClRoaXMgcHJvdmlkZSB0aGF0IGluZm9ybWF0aW9uIGZvciBlbmQgdXNl
cnMgb3IgYXBwbGljYXRpb24gZGV2ZWxvcGVycw0KdXNpbmcgY29tbWVyY2lhbCBkZXZpY2VzLsKg
IFRoZSBlbmQgdXNlciBnZXQgdG8ga25vdyB3aHkgdGhlaXIgZGV2aWNlDQppcyBydW5uaW5nIG91
dCBvZiBtZW1vcnkuDQoNCg0KPj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgRW5kZXJib3JnIDxwZXRl
ci5lbmRlcmJvcmdAc29ueS5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2RtYS1idWYvZG1hLWJ1
Zi5jIHwgMTIgKysrKysrKysrKysrDQo+PiAgZnMvcHJvYy9tZW1pbmZvLmMgICAgICAgICB8ICA1
ICsrKystDQo+PiAgaW5jbHVkZS9saW51eC9kbWEtYnVmLmggICB8ICAxICsNCj4+ICAzIGZpbGVz
IGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVm
LmMNCj4+IGluZGV4IGYyNjRiNzBjMzgzZS4uZDQwZmZmMmFlMWZhIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYw0KPj4gKysrIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1i
dWYuYw0KPj4gQEAgLTM3LDYgKzM3LDcgQEAgc3RydWN0IGRtYV9idWZfbGlzdCB7DQo+PiAgfTsN
Cj4+DQo+PiAgc3RhdGljIHN0cnVjdCBkbWFfYnVmX2xpc3QgZGJfbGlzdDsNCj4+ICtzdGF0aWMg
YXRvbWljX2xvbmdfdCBkbWFfYnVmX2dsb2JhbF9hbGxvY2F0ZWQ7DQo+Pg0KPj4gIHN0YXRpYyBj
aGFyICpkbWFidWZmc19kbmFtZShzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIGNoYXIgKmJ1ZmZlciwg
aW50IGJ1ZmxlbikNCj4+ICB7DQo+PiBAQCAtNzksNiArODAsNyBAQCBzdGF0aWMgdm9pZCBkbWFf
YnVmX3JlbGVhc2Uoc3RydWN0IGRlbnRyeSAqZGVudHJ5KQ0KPj4gICAgICAgICBpZiAoZG1hYnVm
LT5yZXN2ID09IChzdHJ1Y3QgZG1hX3Jlc3YgKikmZG1hYnVmWzFdKQ0KPj4gICAgICAgICAgICAg
ICAgIGRtYV9yZXN2X2ZpbmkoZG1hYnVmLT5yZXN2KTsNCj4+DQo+PiArICAgICAgIGF0b21pY19s
b25nX3N1YihkbWFidWYtPnNpemUsICZkbWFfYnVmX2dsb2JhbF9hbGxvY2F0ZWQpOw0KPj4gICAg
ICAgICBtb2R1bGVfcHV0KGRtYWJ1Zi0+b3duZXIpOw0KPj4gICAgICAgICBrZnJlZShkbWFidWYt
Pm5hbWUpOw0KPj4gICAgICAgICBrZnJlZShkbWFidWYpOw0KPj4gQEAgLTU4Niw2ICs1ODgsNyBA
QCBzdHJ1Y3QgZG1hX2J1ZiAqZG1hX2J1Zl9leHBvcnQoY29uc3Qgc3RydWN0IGRtYV9idWZfZXhw
b3J0X2luZm8gKmV4cF9pbmZvKQ0KPj4gICAgICAgICBtdXRleF9sb2NrKCZkYl9saXN0LmxvY2sp
Ow0KPj4gICAgICAgICBsaXN0X2FkZCgmZG1hYnVmLT5saXN0X25vZGUsICZkYl9saXN0LmhlYWQp
Ow0KPj4gICAgICAgICBtdXRleF91bmxvY2soJmRiX2xpc3QubG9jayk7DQo+PiArICAgICAgIGF0
b21pY19sb25nX2FkZChkbWFidWYtPnNpemUsICZkbWFfYnVmX2dsb2JhbF9hbGxvY2F0ZWQpOw0K
Pj4NCj4+ICAgICAgICAgcmV0dXJuIGRtYWJ1ZjsNCj4+DQo+PiBAQCAtMTM0Niw2ICsxMzQ5LDE1
IEBAIHZvaWQgZG1hX2J1Zl92dW5tYXAoc3RydWN0IGRtYV9idWYgKmRtYWJ1Ziwgc3RydWN0IGRt
YV9idWZfbWFwICptYXApDQo+PiAgfQ0KPj4gIEVYUE9SVF9TWU1CT0xfR1BMKGRtYV9idWZfdnVu
bWFwKTsNCj4+DQo+PiArLyoqDQo+PiArICogZG1hX2J1Zl9nZXRfc2l6ZSAtIFJldHVybiB0aGUg
dXNlZCBuciBwYWdlcyBieSBkbWEtYnVmDQo+PiArICovDQo+PiArbG9uZyBkbWFfYnVmX2FsbG9j
YXRlZF9wYWdlcyh2b2lkKQ0KPj4gK3sNCj4+ICsgICAgICAgcmV0dXJuIGF0b21pY19sb25nX3Jl
YWQoJmRtYV9idWZfZ2xvYmFsX2FsbG9jYXRlZCkgPj4gUEFHRV9TSElGVDsNCj4+ICt9DQo+PiAr
RVhQT1JUX1NZTUJPTF9HUEwoZG1hX2J1Zl9hbGxvY2F0ZWRfcGFnZXMpOw0KPiBXaHkgbmVlZCAi
RVhQT1JUX1NZTUJPTF9HUEwiPw0KVGhpcyB3aGF0IGFsbCBvdGhlciBleHBvcnRlZCBmdW5jdGlv
bnMgZm9yIHRoaXMgbW9kdWxlIGFyZS4gSSBkb24ndCBzZWUgYW55IHJlYXNvbiBmb3IgdGhpcyBk
byBiZSBkaWZmZXJlbnQuDQo+DQo+PiArDQo+PiAgI2lmZGVmIENPTkZJR19ERUJVR19GUw0KPj4g
IHN0YXRpYyBpbnQgZG1hX2J1Zl9kZWJ1Z19zaG93KHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAq
dW51c2VkKQ0KPj4gIHsNCj4+IGRpZmYgLS1naXQgYS9mcy9wcm9jL21lbWluZm8uYyBiL2ZzL3By
b2MvbWVtaW5mby5jDQo+PiBpbmRleCA2ZmE3NjFjOWNjNzguLmNjYzdjNDBjOGRiNyAxMDA2NDQN
Cj4+IC0tLSBhL2ZzL3Byb2MvbWVtaW5mby5jDQo+PiArKysgYi9mcy9wcm9jL21lbWluZm8uYw0K
Pj4gQEAgLTE2LDYgKzE2LDcgQEANCj4+ICAjaWZkZWYgQ09ORklHX0NNQQ0KPj4gICNpbmNsdWRl
IDxsaW51eC9jbWEuaD4NCj4+ICAjZW5kaWYNCj4+ICsjaW5jbHVkZSA8bGludXgvZG1hLWJ1Zi5o
Pg0KPj4gICNpbmNsdWRlIDxhc20vcGFnZS5oPg0KPj4gICNpbmNsdWRlICJpbnRlcm5hbC5oIg0K
Pj4NCj4+IEBAIC0xNDUsNyArMTQ2LDkgQEAgc3RhdGljIGludCBtZW1pbmZvX3Byb2Nfc2hvdyhz
dHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpDQo+PiAgICAgICAgIHNob3dfdmFsX2tiKG0sICJD
bWFGcmVlOiAgICAgICAgIiwNCj4+ICAgICAgICAgICAgICAgICAgICAgZ2xvYmFsX3pvbmVfcGFn
ZV9zdGF0ZShOUl9GUkVFX0NNQV9QQUdFUykpOw0KPj4gICNlbmRpZg0KPj4gLQ0KPj4gKyNpZmRl
ZiBDT05GSUdfRE1BX1NIQVJFRF9CVUZGRVINCj4+ICsgICAgICAgc2hvd192YWxfa2IobSwgIkRt
YUJ1ZlRvdGFsOiAgICAiLCBkbWFfYnVmX2FsbG9jYXRlZF9wYWdlcygpKTsNCj4+ICsjZW5kaWYN
Cj4+ICAgICAgICAgaHVnZXRsYl9yZXBvcnRfbWVtaW5mbyhtKTsNCj4+DQo+PiAgICAgICAgIGFy
Y2hfcmVwb3J0X21lbWluZm8obSk7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kbWEt
YnVmLmggYi9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaA0KPj4gaW5kZXggZWZkYzU2YjlkOTVmLi41
YjA1ODE2YmQyY2QgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaA0KPj4g
KysrIGIvaW5jbHVkZS9saW51eC9kbWEtYnVmLmgNCj4+IEBAIC01MDcsNCArNTA3LDUgQEAgaW50
IGRtYV9idWZfbW1hcChzdHJ1Y3QgZG1hX2J1ZiAqLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKiwN
Cj4+ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyk7DQo+PiAgaW50IGRtYV9idWZfdm1h
cChzdHJ1Y3QgZG1hX2J1ZiAqZG1hYnVmLCBzdHJ1Y3QgZG1hX2J1Zl9tYXAgKm1hcCk7DQo+PiAg
dm9pZCBkbWFfYnVmX3Z1bm1hcChzdHJ1Y3QgZG1hX2J1ZiAqZG1hYnVmLCBzdHJ1Y3QgZG1hX2J1
Zl9tYXAgKm1hcCk7DQo+PiArbG9uZyBkbWFfYnVmX2FsbG9jYXRlZF9wYWdlcyh2b2lkKTsNCj4+
ICAjZW5kaWYgLyogX19ETUFfQlVGX0hfXyAqLw0KPj4gLS0NCj4+IDIuMTcuMQ0KPj4NCg==
