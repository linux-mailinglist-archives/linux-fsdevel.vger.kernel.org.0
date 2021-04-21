Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74F36716F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 19:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244756AbhDURhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 13:37:19 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:16910 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234882AbhDURhS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:37:18 -0400
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LHa1Rv015723;
        Wed, 21 Apr 2021 17:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=X+fxM74H2Na7/9xIJEZPclxODO7+Hj9FQQtKo/0peCY=;
 b=VrHH9p2oJjC1CPTn/Mvg0ZmYtNz3SuFWbuv1l8FUM+sIEHRTO4E5aaIKwgih2fUVUox9
 /Y6NHGI6bsv34//UC+eiGXDvx003Wss8hC9uvKgwisj997rRBLVNpct49qZbpm+CKWL8
 7CINTCkRTSmmkKaZajKHq43Lhbj5NwcHaLBF2oOoGksTXHRl4OclATslVRyE8G1AA2L+
 jSLGHYPmls41rdQszta3EaufEdVUIMRANToI8VeC71zEF1jfRnmeyshwgpj7yVKHyegY
 d7hM4KcZNWJm4uel8A4Go0A5Y5yakFWI1dkvz9IVE0IoML7BwMFQBVUYa7Mjz8NNH4xM 8Q== 
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55])
        by mx08-001d1705.pphosted.com with ESMTP id 382g07gaws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 17:36:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz1HU3nqAnU+0jBW0uyJqJEnVzat/c1/bogGt/kpbg1nOhhPzLGBHj9pmVaA6GAQBgE+tsMkxhW2BNMWGMU9ytqYuigah+mohpj1ePHqWS8qoyyj8M64iKwtplge+aNFp4wtMnhtPlTIshanI3YKiUDptxT7b6W/KiNE8vDNSIO0E27hm30q4b2+5skQT1DXWVd5nPPVWiClF3jSF4BskdSQunYQDVJRaYXx49/FP4CKkUU2zSNbayfWIWM8YderjnB77fOPCSAigjabQzqu76g2wMGp/M2MyTtADpfmCpHiYISHrZUWXEORfitPFjqxwYjHa3pRHqdwmoY7qdA5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+fxM74H2Na7/9xIJEZPclxODO7+Hj9FQQtKo/0peCY=;
 b=BnWnMAZ/SsTLJNXR5eaqMLDyMkfBr7JmHaOKy3z0v5f8DCR9w6YLb8L3f8auj7Fdt1ov1PZklX9W4cXWRQX6RZlosvQN614RmAl1g3nmZ58lXzm8CSMWYER3RTBElspXAtfYMFM9G54IqWvI+mobgFwQcwdL2g4JwuV4/LPInLfnQGVd61MsNFi3KmvuF0GhKcp94EnuVKJU0RjsQrl863Xc9S7Q/HiOzlHmo2uH0/0qPtPB3RB17zhY/Yw2YquHaCUJfa+OuLh56E8YPj/83ZLMRoZ7i+9JNQiW4jAVuIrvY+snrTMctRy/tAkobsi2yqszv/qeI54ifty4Pa1rnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM9P193MB1094.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 17:35:58 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4065.020; Wed, 21 Apr 2021
 17:35:57 +0000
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
Thread-Index: AQHXM6gnmsuLu+Ufhk6GusLEaztxYKq9H2WAgAAHpACAAB5AAIAABooAgAFqggCAABbkAIAAUmUAgAAinAA=
Date:   Wed, 21 Apr 2021 17:35:57 +0000
Message-ID: <84e0c6d9-74c6-5fa8-f75a-45c8ec995ac2@sony.com>
References: <20210417163835.25064-1-peter.enderborg@sony.com>
 <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
 <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
 <YH63iPzbGWzb676T@phenom.ffwll.local>
 <a60d1eaf-f9f8-e0f3-d214-15ce2c0635c2@sony.com>
 <YH/tHFBtIawBfGBl@phenom.ffwll.local>
 <cbde932e-8887-391f-4a1d-515e5c56c01d@sony.com> <YIBFbh4Dd1XaDbto@kernel.org>
In-Reply-To: <YIBFbh4Dd1XaDbto@kernel.org>
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
x-ms-office365-filtering-correlation-id: aee18500-b64c-4fd7-0709-08d904ebec67
x-ms-traffictypediagnostic: AM9P193MB1094:
x-microsoft-antispam-prvs: <AM9P193MB1094EF48FD0C5708259007C586479@AM9P193MB1094.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SzmpV/JuITEQlz1nTXiK9tsi86zwIR0UQ9J+NdOebQXEm+nauu6i7fOHzdzGGmtOxaJ1jWJyz0VQaM9Y2WaizyfWfkDHaQ5ZHcuy020JJYeYn75Ko6wPOKLLHTaZJ0s+LMHXyciWAdiMo1kVPITEnAcRR2HqWvb04LzOTE+FTuBIduin+kOyxXrsrh+M1mfwka3cbmuwOnQ3FZdAXeUMIYAqOyxzcoMMSIj1XvFNfUcXM6/Aw3vN/Qm8EJnUGUeV2hGxpH2oOndj96pPCMHmHI1EULwRBYXOA9iZXjTzszvbNdKpYxTzUTI8xBGy3V0T8vtMFM8beUx7Tos5nTrmIF7EMqCLrOmX1xdkWvvlVU8OYz1llP9dScnFbA91iNOqQ7MyMr/E+I7IY9WbVuoBhYkCzygAObLUal1lulYIquDP/SZlNZxCwhOA8WjzhD4FUiokMjPCh0xDwfKxYaNQ+b8PEPQlRNon/t8MkaPmEuEMG5vtZ6cJXVyGvm42ENmE09vqLmb9Cyg3CNQCQlkiDFp2u/a76fKGpp/iz6LjbntNwqSlozJp7ZuHHJmYQI5hChnI8X9giiy7tbCoLW3ZFK1lAkb0BoJqTGWqHCvp9ISfllE9lKYPgsJMp9ZlP4TQzViC7xFWi2ebQiS05q22NpMa+VZRqVbiOfkqdWxPEGg+621E7JyLW54GCnX92vaY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(7416002)(31696002)(122000001)(186003)(66556008)(64756008)(26005)(66476007)(54906003)(83380400001)(478600001)(38100700002)(6506007)(71200400001)(8676002)(66446008)(66946007)(76116006)(31686004)(36756003)(316002)(2906002)(4326008)(86362001)(5660300002)(8936002)(6512007)(91956017)(6916009)(6486002)(2616005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dXlQS3JBVGZvMlJkS2JadWJKRW5qL2ZQMGJBSnFPem1aVEJyb1Z6R0U4Umd2?=
 =?utf-8?B?aWJEWkFmQys3Wll2Q3FVU2ZMUjVQNTlIWTNDcW1WOHNDdmxyMWdhZTkvalVB?=
 =?utf-8?B?dmIxNjNTSWhLOWJvZFVsMzVzKy92TngrTGp3VmV3MnUvQ1pIYjAyUUhjZUdZ?=
 =?utf-8?B?S1c4R1IxZkhEUEF0SnNxYkQ3UlFiUjJkY29PQXpZZE5uWnFwWjllUkN5OXpD?=
 =?utf-8?B?SUdsVE5xU3BsTmdlMFNkL2hLK1R0dkNNWVhCSCtZRWRDMHF6OVhkOTBTMXN5?=
 =?utf-8?B?amV6Z1QvQU1OSjl3S0thRCtYRzhyWE1SZGdMdHcrMzJxRm5KbzJld3ZScy9z?=
 =?utf-8?B?VXhMbVFmeUg1WlJiWWtnTXYvd3dUVEZQWlBmZVZ1WVJXK29CUElJdFQzQWZp?=
 =?utf-8?B?dXc2Q0J3TzFoMFN2dzF3RXpzZ1hYcEd1Znl3ZjlzVTVnN3YrZXZOMVVKbkNt?=
 =?utf-8?B?R2dxRnI2cVpKYXNKbDRqL1QvcEZ0d0hWdTdueDRvRDZWTFdMeTJQR0JicC90?=
 =?utf-8?B?L2V3SkdMS3dORFFMbm1OcWt2YnJkUE9JdHI1Rm5tcDdENGNwMnU3OFpuQUhh?=
 =?utf-8?B?ZUJCTmRDRmx6V2RZUmwwa1NSeXR4b05CdWNqQ1NoZnZ5MnhMK2poL1pxL2FE?=
 =?utf-8?B?VGJWOVlyUDdKRDI5Sys1alIyZ3pxYkV3VzNidXpyN1pIL1I1QzBiMENCdVI2?=
 =?utf-8?B?RjNIbHVmbHdnazlzdys4aHNJVzQyWDNxWGtNL2ZOZEEwdUhWSTJrV2dZa2dO?=
 =?utf-8?B?THhpY0JuT0FRdFVDbnRQdlhuUFQ3Ym9vRS9JVjQ4V3B5akpJUVZQUm45T0h4?=
 =?utf-8?B?R1RyZVpyTjJ4dHpmL2ptYTF3dHZrL05pWjhsMU5YdXArMGZPOUZuYWpNWitN?=
 =?utf-8?B?TVQ5NnlCMVFwc01DYW5yS0I2b2xzTVBJd2NnTkgwdjRsa2YvSjlxRktMVVRU?=
 =?utf-8?B?YzNjaGF2NTJDSU05dmVBOExXT1orc3NUWEhxMjZ1SmFCM1Q1Y0p4Tndac3lr?=
 =?utf-8?B?YXNKVmVEWThtM2NiRm1YczRaSm5QSGNLczcyOUxlbkZWUVkzL0dLS0lBdFlR?=
 =?utf-8?B?MlJZd2pJM1I0ckRiUFZtUDA1RHdYaWVETm1BWkwwMStNWndFVHRWVGVRZDI1?=
 =?utf-8?B?eGJUVHdqSkdDbmMvalBWVDRGYUJOT1EwT0dFQUt1Z3VzZUxlTnhTYU4ybXA5?=
 =?utf-8?B?MlVyaEdGQW9ZSVFpM1Jqd3BSY1FTeEdHUTIvQkFpazFDN2d0QjlPRlJiaTQr?=
 =?utf-8?B?N2ExNkE1bjlINVhNV09wQkEvS2R0N2Iyd1orbm9EQlZXTTdOR3h6SFkyRnNS?=
 =?utf-8?B?K29vNWQ2dEIwNkpXbmxvWlBjT3Vsbmg3K05Fems5V08vOWNDOVRTVHJwQjJo?=
 =?utf-8?B?eWFRQ2lOUzZXZlVzUHBZa3lOcUprUm45MlBLZHBQSVZqWkR4SFlhbVgrNVRn?=
 =?utf-8?B?MUpCOHJ0QkVuMDRUalpCaldLUUplOGlkYnIwOW5IWXJnajNyWk9RbldPUjIw?=
 =?utf-8?B?aFQ2a281R2V5U0RJQ3RDUmp5Z1RlZjFmcHE2TzN2cmo1L0dmSFk0NGdBR1lu?=
 =?utf-8?B?NnZHK3hNZllPUGVaaVUwbm42dlFKQmlSSGlnZEpWdkthNUJDalRjZGR3YUQy?=
 =?utf-8?B?NDBqaU10Z2JrYlBRdU1Zc0NFeXo5Y2dFcExjTThtU3ZHNHJmSFhLVHF3aCtB?=
 =?utf-8?B?Z0kva1B1bWZkZzFJYTRzWDlZOW44R2lKbkx0VzhxaWxhdk9sYWFLc09tOWVx?=
 =?utf-8?Q?Ox8o64w9v4PNzRRauUXKsfjpNN1NaBxCWCj/f+S?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <05F95FBD25A5D443A2D3849F1E45F0F8@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aee18500-b64c-4fd7-0709-08d904ebec67
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 17:35:57.8262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e07OjkW6xOFRVWAOG8MclwtXIOxoualzD3FW1+h7F0kCEpT0nqPHTqquu5r5mjjCINL0NVV0oEVc1XGd+0BtFrGmGXF0f0sE0tp4mQWcGFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1094
X-Proofpoint-GUID: -ejcmY2UE_nlNkPfZG_-VpLdSzP7QemJ
X-Proofpoint-ORIG-GUID: -ejcmY2UE_nlNkPfZG_-VpLdSzP7QemJ
X-Sony-Outbound-GUID: -ejcmY2UE_nlNkPfZG_-VpLdSzP7QemJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_05:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210124
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yMS8yMSA1OjMxIFBNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiBPbiBXZWQsIEFwciAy
MSwgMjAyMSBhdCAxMDozNzoxMUFNICswMDAwLCBQZXRlci5FbmRlcmJvcmdAc29ueS5jb20gd3Jv
dGU6DQo+PiBPbiA0LzIxLzIxIDExOjE1IEFNLCBEYW5pZWwgVmV0dGVyIHdyb3RlOg0KPj4+IFdl
IG5lZWQgdG8gdW5kZXJzdGFuZCB3aGF0IHRoZSAiY29ycmVjdCIgdmFsdWUgaXMuIE5vdCBpbiB0
ZXJtcyBvZiBrZXJuZWwNCj4+PiBjb2RlLCBidXQgaW4gdGVybXMgb2Ygc2VtYW50aWNzLiBMaWtl
IGlmIHVzZXJzcGFjZSBhbGxvY2F0ZXMgYSBHTCB0ZXh0dXJlLA0KPj4+IGlzIHRoaXMgc3VwcG9z
ZWQgdG8gc2hvdyB1cCBpbiB5b3VyIG1ldHJpYyBvciBub3QuIFN0dWZmIGxpa2UgdGhhdC4NCj4+
IFRoYXQgaXQgbGlrZSB0aGF0IHdvdWxkIGxpa2UgdG8gb25seSBvbmUgcG9pbnRlciB0eXBlLiBZ
b3UgbmVlZCB0byBrbm93IHdoYXQNCj4+DQo+PiB5b3UgcG9pbnRpbmcgYXQgdG8ga25vdyB3aGF0
IGl0IGlzLiBpdCBtaWdodCBiZSBhIGhhcmR3YXJlIG9yIGEgb3RoZXIgcG9pbnRlci4NCj4+DQo+
PiBJZiB0aGVyZSBpcyBhIGxpbWl0YXRpb24gb24geW91ciBwb2ludGVycyBpdCBpcyBhIGdvb2Qg
bWV0cmljIHRvIGNvdW50IHRoZW0NCj4+IGV2ZW4gaWYgeW91IGRvbid0wqAga25vdyB3aGF0IHRo
ZXkgYXJlLiBTYW1lIGdvZXMgZm9yIGRtYS1idWYsIHRoZXkNCj4+IGFyZSBnZW5lcmljLCBidXQg
dGhleSBjb25zdW1lIHNvbWUgcmVzb3VyY2VzIHRoYXQgYXJlIGNvdW50ZWQgaW4gcGFnZXMuDQo+
Pg0KPj4gSXQgd291bGQgYmUgdmVyeSBnb29kIGlmIHRoZXJlIGEgc3ViIGRpdmlzaW9uIHdoZXJl
IHlvdSBjb3VsZCBtZWFzdXJlDQo+PiBhbGwgcG9zc2libGUgdHlwZXMgc2VwYXJhdGVseS7CoCBX
ZSBoYXZlIHRoZSBkZXRhaWxlZCBpbiBkZWJ1Z2ZzLCBidXQgbm90aGluZw0KPj4gZm9yIHRoZSB1
c2VyLiBBIHN1bW1hcnkgaW4gbWVtaW5mbyBzZWVtcyB0byBiZSB0aGUgYmVzdCBwbGFjZSBmb3Ig
c3VjaA0KPj4gbWV0cmljLg0KPiAgDQo+IExldCBtZSB0cnkgdG8gc3VtbWFyaXplIG15IHVuZGVy
c3RhbmRpbmcgb2YgdGhlIHByb2JsZW0sIG1heWJlIGl0J2xsIGhlbHANCj4gb3RoZXJzIGFzIHdl
bGwuDQoNClRoYW5rcyENCg0KDQo+IEEgZGV2aWNlIGRyaXZlciBhbGxvY2F0ZXMgbWVtb3J5IGFu
ZCBleHBvcnRzIHRoaXMgbWVtb3J5IHZpYSBkbWEtYnVmIHNvDQo+IHRoYXQgdGhpcyBtZW1vcnkg
d2lsbCBiZSBhY2Nlc3NpYmxlIGZvciB1c2Vyc3BhY2UgdmlhIGEgZmlsZSBkZXNjcmlwdG9yLg0K
Pg0KPiBUaGUgYWxsb2NhdGVkIG1lbW9yeSBjYW4gYmUgZWl0aGVyIGFsbG9jYXRlZCB3aXRoIGFs
bG9jX3BhZ2UoKSBmcm9tIHN5c3RlbQ0KPiBSQU0gb3IgYnkgb3RoZXIgbWVhbnMgZnJvbSBkZWRp
Y2F0ZWQgVlJBTSAodGhhdCBpcyBub3QgbWFuYWdlZCBieSBMaW51eCBtbSkNCj4gb3IgZXZlbiBm
cm9tIG9uLWRldmljZSBtZW1vcnkuDQo+DQo+IFRoZSBkbWEtYnVmIGRyaXZlciB0cmFja3MgdGhl
IGFtb3VudCBvZiB0aGUgbWVtb3J5IGl0IHdhcyByZXF1ZXN0ZWQgdG8NCj4gZXhwb3J0IGFuZCB0
aGUgc2l6ZSBpdCBzZWVzIGlzIGF2YWlsYWJsZSBhdCBkZWJ1Z2ZzIGFuZCBmZGluZm8uDQo+DQo+
IFRoZSBkZWJ1Z2ZzIGlzIG5vdCBhdmFpbGFibGUgdG8gdXNlciBhbmQgbWF5YmUgZW50aXJlbHkg
ZGlzYWJsZWQgaW4NCj4gcHJvZHVjdGlvbiBzeXN0ZW1zLg0KPg0KPiBUaGVyZSBjb3VsZCBiZSBx
dWl0ZSBhIGZldyBvcGVuIGRtYS1idWZzIHNvIHRoZXJlIGlzIG5vIG92ZXJhbGwgc3VtbWFyeSwN
Cj4gcGx1cyBmZGluZm8gaW4gcHJvZHVjdGlvbiBzeXN0ZW1zIHlvdXIgcmVmZXIgdG8gaXMgYWxz
byB1bmF2YWlsYWJsZSB0byB0aGUNCj4gdXNlciBiZWNhdXNlIG9mIHNlbGludXggcG9saWN5Lg0K
Pg0KPiBBbmQgdGhlcmUgYXJlIGEgZmV3IGRldGFpbHMgdGhhdCBhcmUgbm90IGNsZWFyIHRvIG1l
Og0KPg0KPiAqIFNpbmNlIERSTSBkZXZpY2UgZHJpdmVycyBzZWVtIHRvIGJlIHRoZSBtYWpvciB1
c2VyIG9mIGRtYS1idWYgZXhwb3J0cywNCj4gICB3aHkgY2Fubm90IHdlIGFkZCBpbmZvcm1hdGlv
biBhYm91dCB0aGVpciBtZW1vcnkgY29uc3VtcHRpb24gdG8sIHNheSwNCj4gICAvc3lzL2NsYXNz
L2dyYXBoaWNzL2RybS9jYXJkWC9tZW1vcnktdXNhZ2U/DQoNCkFuZHJvaWQgaXMgdXNpbmcgaXQg
Zm9yIGJpbmRlciB0aGF0IGNvbm5lY3QgbW9yZSBvciBsZXNzIGV2ZXJ5dGhpbmcNCmludGVybmFs
bHkuDQoNCj4gKiBIb3cgZXhhY3RseSB1c2VyIGdlbmVyYXRlcyByZXBvcnRzIHRoYXQgd291bGQg
aW5jbHVkZSB0aGUgbmV3IGNvdW50ZXJzPw0KPiAgIEZyb20gbXkgKG1vc3RseSBvdXRkYXRlZCkg
ZXhwZXJpZW5jZSBBbmRyb2lkIHVzZXJzIHdvbid0IG9wZW4gYSB0ZXJtaW5hbA0KPiAgIGFuZCB0
eXBlICdjYXQgL3Byb2MvbWVtaW5mbycgdGhlcmUuIEknZCBwcmVzdW1lIHRoZXJlIGlzIGEgdmVu
ZG9yIGFnZW50DQo+ICAgdGhhdCBjb2xsZWN0cyB0aGUgZGF0YSBhbmQgc2VuZHMgaXQgZm9yIGFu
YWx5c2lzLiBJbiB0aGlzIGNhc2Ugd2hhdCBpcw0KPiAgIHRoZSByZWFzb24gdGhlIHZlbmRvciBp
cyB1bmFibGUgdG8gYWRqdXN0IHNlbGluaXggcG9saWN5IHNvIHRoYXQgdGhlDQo+ICAgYWdlbnQg
d2lsbCBiZSBhYmxlIHRvIGFjY2VzcyBmZGluZm8/DQoNCldoZW4geW91IHR1cm4gb24gZGV2ZWxv
cGVyIG1vZGUgb24gYW5kcm9pZCB5b3UgY2FuIHVzZQ0KdXNiIHdpdGggYSBwcm9ncmFtIGNhbGxl
ZCBhZGIuIEFuZCB0aGVyZSB5b3UgZ2V0IGEgbm9ybWFsIHNoZWxsLg0KDQoobm90IHJvb3QgdGhv
dWdoKQ0KDQpUaGVyZSBpcyBhcHBsaWNhdGlvbnMgdGhhdCBub24gZGV2ZWxvcGVycyBjYW4gdXNl
IHRvIGdldA0KaW5mb3JtYXRpb24uIEl0IGlzIHZlcnkgbGltaXRlZCB0aG91Z2ggYW5kIHRoZXJl
IGFyZSBBUEkncw0KcHJvdmlkZSBpdC4NCg0KDQo+DQo+ICogQW5kLCBhcyBvdGhlcnMgYWxyZWFk
eSBtZW50aW9uZWQsIGl0IGlzIG5vdCBjbGVhciB3aGF0IGFyZSB0aGUgcHJvYmxlbXMNCj4gICB0
aGF0IGNhbiBiZSBkZXRlY3RlZCBieSBleGFtaW5pbmcgRG1hQnVmVG90YWwgZXhjZXB0IHNheWlu
ZyAib2gsIHRoZXJlIGlzDQo+ICAgdG9vIG11Y2gvdG9vIGxpdHRsZSBtZW1vcnkgZXhwb3J0ZWQg
dmlhIGRtYS1idWYiLiBXaGF0IHdvdWxkIGJlIHVzZXINCj4gICB2aXNpYmxlIGVmZmVjdHMgb2Yg
dGhlc2UgcHJvYmxlbXM/IFdoYXQgYXJlIHRoZSBuZXh0IHN0ZXBzIHRvIGludmVzdGlnYXRlDQo+
ICAgdGhlbT8gV2hhdCBvdGhlciBkYXRhIHdpbGwgYmUgcHJvYmFibHkgcmVxdWlyZWQgdG8gaWRl
bnRpZnkgcm9vdCBjYXVzZT8NCj4NCldoZW4geW91IGRlYnVnIHRob3VzYW5kcyBvZiBkZXZpY2Vz
IGl0IGlzIHF1aXRlIG5pY2UgdG8gaGF2ZQ0Kd2F5cyB0byBjbGFzc2lmeSB3aGF0IHRoZSBwcm9i
bGVtIGl0IGlzIG5vdC4gVGhlIG5vcm1hbCB1c2VyIGRvZXMgbm90DQpzZWUgYW55dGhpbmcgb2Yg
dGhpcy4gSG93ZXZlciB0aGV5IGNhbiBnZW5lcmF0ZSBidWctcmVwb3J0cyB0aGF0DQpjb2xsZWN0
IGluZm9ybWF0aW9uIGFib3V0IGFzIG11Y2ggdGhleSBjYW4uIFRoZW4gdGhlIHVzZXIgaGF2ZQ0K
dG8gcHJvdmlkZSB0aGlzIGJ1Zy1yZXBvcnQgdG8gdGhlIG1hbnVmYWN0dXJlIG9yIG1vc3RseSB0
aGUNCmFwcGxpY2F0aW9uIGRldmVsb3Blci4gQW5kIHdoZW4gdGhlIHByb2JsZW0gaXMNCnN5c3Rl
bSByZWxhdGVkIHdlIG5lZWQgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSBvbiBhIGZ1bGwNCmRlYnVn
IGVuYWJsZWQgdW5pdC4NCg0K
