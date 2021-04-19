Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C423364798
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 17:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbhDSP7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 11:59:20 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:60226 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241958AbhDSP7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:59:19 -0400
X-Greylist: delayed 2351 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 11:59:18 EDT
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JF9vU6027869;
        Mon, 19 Apr 2021 15:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=3eWPU5yaEOpanB6mTLtzP2tTF4eXq4E+uHU7eyXY0P8=;
 b=R5vwJD1MsBUD73jrPm2+bti1bq6GUfHZkh5R5Aaqc4t1fzO60HE+4OHp9j3ANhtkH8Am
 +MQiI1qwz7PVau9RItZSFLhaQEZEqbN1QumeZqsvomBBIsfI1Dhy/NvkvAuZx3A7iEQP
 ug962dZo38VtpPsP+MqZDEqR+wl2/YMYchUno08W/LUbYa3TJ4Siijanl7avwhg9gKjm
 gF37TdY2/jYkaELsY2OWebyZyBThMNPZJ8Bo4EgWoVy+M8zlUlDHjVes2rjcA3vOsbsK
 iUkczL+Q0K87Th4FCZkIXQ1xvCNo5q1OC1r/hxLH8SwftW71dbs0ZVE4xrBwbSC8aEfz 1g== 
Received: from eur02-ve1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57])
        by mx08-001d1705.pphosted.com with ESMTP id 37ypf9ayp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 15:19:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsiuUsKG4GcOLh947aGhwS1DmqEWrNAKkQDi9VfdbTZ+EUUMdeyFWs+c174Axq1hC8k57ljbvTR3ZgSj9g4l6/dGfMifmqroDoAQNSRDxxvY5Uq24zYZkqwcjALbatmpVkKslzvcrlDTuSXhjaZ/02nKkTbARnU/dOC0UANctPWG6OcYJew+zDzJiVas7pCemPJWB9zrlG/h6FzrRYw8dyOxNiSQ8IniWwo6e1RxXnTbSUZc4hNKap+7Ex38/NjG6oY5Z7Rigti8tGKgIM06GwxamvXnk7F7UX/ZcmpzHV0QjsPUZso2ZocDXG4T2jJwyYP+kFAYnRPQ2PDUJhu1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eWPU5yaEOpanB6mTLtzP2tTF4eXq4E+uHU7eyXY0P8=;
 b=jsUtGydQ4vK+FkwDDAtvIhl64d+WG9Rq71kR4EKpf7XiQ2+eyDiUcathzj+5SKEMToAaa7mPhO5BxBLQiiN+A/2woma9pvX1S3mOEM/m2xccVIamGyZbwpU7dn/SHiR+kuiANNXnzNMCnObfoYoratx9Sk80a2lfpe/xCnUH495uREdj9vlQuq3lI3PGALrPL+6H3f9GMlK3CJClUxa0T91l/LfLozHvxMQZkjwu2DGEbMza7u8zLqzoW9clA5zMUItqIAZP0sPFK/YzY9hehqFB3Wp47TdeF3BqGsPzFApYNcCXz5uwEnrZhkSRBq0Urz3SE/gq+m6d1q5punvzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM0P193MB0692.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 15:19:03 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::35b3:3e5e:6533:84e0%5]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 15:19:03 +0000
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
Thread-Index: AQHXM3Yw6ll+UCWErEeaPUdSTn+rzaq7xNSAgAAG/YCAACafgIAABUyA
Date:   Mon, 19 Apr 2021 15:19:03 +0000
Message-ID: <23aa041b-0e7c-6f82-5655-836899973d66@sony.com>
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <YH10s/7MjxBBsjVL@dhcp22.suse.cz>
 <c3f0da9c-d127-5edf-dd21-50fd5298acef@sony.com>
 <YH2a9YfRBlfNnF+u@dhcp22.suse.cz>
In-Reply-To: <YH2a9YfRBlfNnF+u@dhcp22.suse.cz>
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
x-ms-office365-filtering-correlation-id: 5d091908-9bc4-4fbd-cf59-08d903467789
x-ms-traffictypediagnostic: AM0P193MB0692:
x-microsoft-antispam-prvs: <AM0P193MB06925381AFE653FEC98E649886499@AM0P193MB0692.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LIx1JVrLnygfy6bl+DJDFGGAHzSXcfwLmm5RlURKQSeZ7K7rgzm8KODHImU6BwPLrTil//Ow/J1b8aTlWDDdny12tBCU5GC5HMd1VGFgzaA9YPutyzqyPDNNQO2WCRVJYcsW8QSc1CUEysZlJ9QXSMUvoAL6DYZVscwmVb1Q5awCraFEZLKbrtthFfcgOTOU7rO/42TVE9DH+i+833C84wwTAZNdqiFVRg27QXyJvb0jnUe/g0H5mGwWsyjX5zIXFOZLG9wxssQOiLtfFJIknpNVjGNYLlqpbNR7Rhkkt+54Vb6MGsSfW+FrZ54V581tHBAJMKqxt38J1UJjfiqS8dBJ7gHp+u0u4VccxFValorpHQHjNyYGCKQQaudyJnKELcrcQkWmpY5DscPL/T1h8HTBMPibu2wg8fZgNupGzcIpy4PeFSVd2/ei8uhEO/0wICI1nPHAVkW902MzDJvg6cTr1dMJiejhrvDqZEr0fm3ugH9SWry6pWfgPREGzadgkFoEfdyS5D28Epbbqa3AcXt06OGUc1VSesGWLJyiFzDfcgaM9JSpOkiF3Mf9zPeoEuhUzHbnP2k8ECU6gdcMk+It+6oDNi1xgfwQyI1oIrc4b9FrTzgkpebQBgSbrmf96ytsO96S3RX8X/1MXepdwosZkxSmlrI+ohdudUebD8acmC+WZhLG4yG3/8qdtaeM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(396003)(346002)(136003)(122000001)(71200400001)(26005)(83380400001)(186003)(8936002)(53546011)(36756003)(5660300002)(7416002)(6916009)(8676002)(2906002)(478600001)(38100700002)(2616005)(64756008)(66556008)(66946007)(31686004)(6512007)(316002)(66446008)(66476007)(4326008)(76116006)(86362001)(6506007)(6486002)(54906003)(91956017)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bTZ2d0puQldtbEdKUHhOZ0h1RHFtVTVBUzNkdk9ZZ3JOVzN0cUFtMnRuUmVx?=
 =?utf-8?B?b3BTakFIdkVRUmFKbXFZS3RvdzZ0eEdKYWFndFJzUENSVnV0aU5wWHFvQ2U1?=
 =?utf-8?B?RlNDcVZFVk53bGVQcmpxWTZwQWI1dW1pRVdONjF2S0ZlcjFwZUFOSlJXTHNW?=
 =?utf-8?B?WWp2T0V2aVVNa1dNS3dLaXZITTZRNUJPQkpJTmVWMGRySnBodXFySVQxTnpj?=
 =?utf-8?B?YlpHZXNzdTdXRUlXbmE3K0hBbDEyRTlVOWMzdDQyckpBVk9JQ3hYWjlUTTMx?=
 =?utf-8?B?NlM0QmdCUENHandMSFNBOTdCU0U0SmxhM0p6VDBsT245WUhHdUhNKzNNckpL?=
 =?utf-8?B?ZnhGMkxXT1oyaCtNQTFwUXFTMjJpVEZMSEM5NVpjdjZSVzVBN3pwbitsSW5m?=
 =?utf-8?B?T0NURDdqMWJtZzNTOWpueW5CMElvTTRjT1AydFZkZkJhSEVuQ3lzbTBjeVFs?=
 =?utf-8?B?TTJubFZjSWppWWsrWmRaYU1SRjB4c2lvTC9JaTF2b3V4U3dxaGdpb04xelI5?=
 =?utf-8?B?S1pzbTVZWm1KS01UdzZHNS9tOEdiWFFsdFlPeXFxTTBVbHc3dEtVMUh1VkhX?=
 =?utf-8?B?TzluOXN4TFk4c2s1M1krZEFQQmNzTSs0NHJwYjNzdk9QL0J1OTBRL3ZiY3J0?=
 =?utf-8?B?T1pnNCszWEZCbndPbEtGaFkvSWdkY1dLYzJ5SFFnWlJYdEZHM1BjTlFJQVB4?=
 =?utf-8?B?WEkrNktoYTlpblZDalhYNFBqZHIxbmJETWZ0dC9CR212UUhHWUkycU10ajVh?=
 =?utf-8?B?NFBYSkpVbUhoUjhzVGh1N090a2NTc2l5dk56aXVTLzM1YVBqQ3V3SEVlaHpV?=
 =?utf-8?B?K29jRXFzdHg4U2dwZi9mNHNvcmFFdG5Zd3kvOEp5SENkcVkxekFjWDVTVlJW?=
 =?utf-8?B?ajM1TjMxZFhOcFB4WjRNcW9jalkrQm9LeHgrVEJ0MXVqZHpTc0RXeWo5OHdY?=
 =?utf-8?B?UVJQdkN2VllFNFdZSnhFM0poU0s4V09VVUJDRktrRFJMV3V3S0RCOGdsZU5C?=
 =?utf-8?B?cUFPL2ZiSHlMYkYrTTRkSVU2OFh3cWY1akFrbmRmbi9pUHhyMkZhUEc2RzBR?=
 =?utf-8?B?dk01dTF1SW4wYUVjRzM4SWhHTkFQWGgzMy94b0dWR0U1eTNWZ0tEWmcwbTRp?=
 =?utf-8?B?eHNPUFNJdDJNOVg0SjdYeHdoa1BtMDVMbzJ3T0V6N2QvMVlHeXA3QXA5djdS?=
 =?utf-8?B?NDBBV3Vvb3IzRTUxQ3h0OGhrWnJwaXh0Y1ppWjlEenJGaUxLL0VoREtqdnlM?=
 =?utf-8?B?MmhMSkNHMHlTYko2ZndVRDdQREZFUmY3QW12YXdzVmU5ZjBqTnc1NDBQSzBY?=
 =?utf-8?B?Nkk4RW9KTTFmY1p6bmphMFh0M0ltTTB3UXFSdHJhSGtmTWZpSExrQ0p2VUhZ?=
 =?utf-8?B?TFV5eHFhM3BaaXpzQWdDb0NUZTdoRkxZczRQa0ErRmkzSXdDc3NHanhwOVJu?=
 =?utf-8?B?NDREOGRaNFYySDRjU0RRSFRjRFpZR3BHLy92cDJpRDVPU2EwMktGci9WUktS?=
 =?utf-8?B?T2MxRGd1Y2YwNkQ1UmtvTHQ2Z2NLNHQwTXFDalZrSnFWODA3NFVoVHE1TWdG?=
 =?utf-8?B?SDlnajVPQjFpS1I4VDVVb1ZaMWJZSEhRV3QvZW91WWtKQUFIRXB5aG5nTzcv?=
 =?utf-8?B?S24rbWtQWWsrOWtGS0syeENudFBoeGh4REhCTmlwQXQrTW93MVlDQlVlSG5H?=
 =?utf-8?B?cnpPVXc4aHJlcFN6MERLbkR1eVd6K1hpUFV1MXVFWlg3Z0h0R204eHVaSDEz?=
 =?utf-8?Q?LNAhR2LFoUeimtDUCn/MviUS8cRbmQ2fBt9AItK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F41EC5F459BCD74FBE1BFFF423E4D818@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d091908-9bc4-4fbd-cf59-08d903467789
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 15:19:03.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJwbApFIjVTCbrV5GgWtNLr5uphPHwDIcqUkI2OXwj3WnFekwbN/+PqZ/2pHKYEluAV+eAZgP4jwMZB1yfHa2OhAd7wTdFsATMM7f969jbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0692
X-Proofpoint-GUID: EoiSFTZYiFVhmiLPi69mEOMnhvu3HkqO
X-Proofpoint-ORIG-GUID: EoiSFTZYiFVhmiLPi69mEOMnhvu3HkqO
X-Sony-Outbound-GUID: EoiSFTZYiFVhmiLPi69mEOMnhvu3HkqO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_10:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190105
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xOS8yMSA1OjAwIFBNLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+IE9uIE1vbiAxOS0wNC0y
MSAxMjo0MTo1OCwgUGV0ZXIuRW5kZXJib3JnQHNvbnkuY29tIHdyb3RlOg0KPj4gT24gNC8xOS8y
MSAyOjE2IFBNLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+Pj4gT24gU2F0IDE3LTA0LTIxIDEyOjQw
OjMyLCBQZXRlciBFbmRlcmJvcmcgd3JvdGU6DQo+Pj4+IFRoaXMgYWRkcyBhIHRvdGFsIHVzZWQg
ZG1hLWJ1ZiBtZW1vcnkuIERldGFpbHMNCj4+Pj4gY2FuIGJlIGZvdW5kIGluIGRlYnVnZnMsIGhv
d2V2ZXIgaXQgaXMgbm90IGZvciBldmVyeW9uZQ0KPj4+PiBhbmQgbm90IGFsd2F5cyBhdmFpbGFi
bGUuIGRtYS1idWYgYXJlIGluZGlyZWN0IGFsbG9jYXRlZCBieQ0KPj4+PiB1c2Vyc3BhY2UuIFNv
IHdpdGggdGhpcyB2YWx1ZSB3ZSBjYW4gbW9uaXRvciBhbmQgZGV0ZWN0DQo+Pj4+IHVzZXJzcGFj
ZSBhcHBsaWNhdGlvbnMgdGhhdCBoYXZlIHByb2JsZW1zLg0KPj4+IFRoZSBjaGFuZ2Vsb2cgd291
bGQgYmVuZWZpdCBmcm9tIG1vcmUgYmFja2dyb3VuZCBvbiB3aHkgdGhpcyBpcyBuZWVkZWQsDQo+
Pj4gYW5kIHdobyBpcyB0aGUgcHJpbWFyeSBjb25zdW1lciBvZiB0aGF0IHZhbHVlLg0KPj4+DQo+
Pj4gSSBjYW5ub3QgcmVhbGx5IGNvbW1lbnQgb24gdGhlIGRtYS1idWYgaW50ZXJuYWxzIGJ1dCBJ
IGhhdmUgdHdvIHJlbWFya3MuDQo+Pj4gRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9wcm9jLnJz
dCBuZWVkcyBhbiB1cGRhdGUgd2l0aCB0aGUgY291bnRlcg0KPj4+IGV4cGxhbmF0aW9uIGFuZCBz
ZWNvbmRseSBpcyB0aGlzIGluZm9ybWF0aW9uIHVzZWZ1bCBmb3IgT09NIHNpdHVhdGlvbnMNCj4+
PiBhbmFseXNpcz8gSWYgeWVzIHRoZW4gc2hvd19tZW0gc2hvdWxkIGR1bXAgdGhlIHZhbHVlIGFz
IHdlbGwuDQo+Pj4NCj4+PiBGcm9tIHRoZSBpbXBsZW1lbnRhdGlvbiBwb2ludCBvZiB2aWV3LCBp
cyB0aGVyZSBhbnkgcmVhc29uIHdoeSB0aGlzDQo+Pj4gaGFzbid0IHVzZWQgdGhlIGV4aXN0aW5n
IGdsb2JhbF9ub2RlX3BhZ2Vfc3RhdGUgaW5mcmFzdHJ1Y3R1cmU/DQo+PiBJIGZpeCBkb2MgaW4g
bmV4dCB2ZXJzaW9uLsKgIEltIG5vdCBzdXJlIHdoYXQgeW91IGV4cGVjdCB0aGUgY29tbWl0IG1l
c3NhZ2UgdG8gaW5jbHVkZS4NCj4gQXMgSSd2ZSBzYWlkLiBVc3VhbCBqdXN0aWZpY2F0aW9uIGNv
dmVycyBhbnN3ZXJzIHRvIGZvbGxvd2luZyBxdWVzdGlvbnMNCj4gCS0gV2h5IGRvIHdlIG5lZWQg
aXQ/DQo+IAktIFdoeSB0aGUgZXhpc3RpbmcgZGF0YSBpcyBpbnN1ZmljaWVudD8NCj4gCS0gV2hv
IGlzIHN1cHBvc2VkIHRvIHVzZSB0aGUgZGF0YSBhbmQgZm9yIHdoYXQ/DQo+DQo+IEkgY2FuIHNl
ZSBhbiBhbnN3ZXIgZm9yIHRoZSBmaXJzdCB0d28gcXVlc3Rpb25zIChiZWNhdXNlIHRoaXMgY2Fu
IGJlIGENCj4gbG90IG9mIG1lbW9yeSBhbmQgdGhlIGV4aXN0aW5nIGluZnJhc3RydWN0dXJlIGlz
IG5vdCBwcm9kdWN0aW9uIHN1aXRhYmxlDQo+IC0gZGVidWdmcykuIEJ1dCB0aGUgY2hhbmdlbG9n
IGRvZXNuJ3QgcmVhbGx5IGV4cGxhaW4gd2hvIGlzIGdvaW5nIHRvIHVzZQ0KPiB0aGUgbmV3IGRh
dGEuIElzIHRoaXMgYSBtb25pdG9yaW5nIHRvIHJhaXNlIGFuIGVhcmx5IGFsYXJtIHdoZW4gdGhl
DQo+IHZhbHVlIGdyb3dzPyBJcyB0aGlzIGZvciBkZWJ1Z2dpbmcgbWlzYmVoYXZpbmcgZHJpdmVy
cz8gSG93IGlzIGl0DQo+IHZhbHVhYmxlIGZvciB0aG9zZT8NCj4NCj4+IFRoZSBmdW5jdGlvbiBv
ZiB0aGUgbWVtaW5mbyBpczogKEZyb20gRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9wcm9jLnJz
dCkNCj4+DQo+PiAiUHJvdmlkZXMgaW5mb3JtYXRpb24gYWJvdXQgZGlzdHJpYnV0aW9uIGFuZCB1
dGlsaXphdGlvbiBvZiBtZW1vcnkuIg0KPiBUcnVlLiBZZXQgd2UgZG8gbm90IGV4cG9ydCBhbnkg
cmFuZG9tIGNvdW50ZXJzLCBkbyB3ZT8NCj4NCj4+IEltIG5vdCB0aGUgZGVzaWduZWQgb2YgZG1h
LWJ1ZiwgSSB0aGlua8KgIGdsb2JhbF9ub2RlX3BhZ2Vfc3RhdGUgYXMgYSBrZXJuZWwNCj4+IGlu
dGVybmFsLg0KPiBJdCBwcm92aWRlcyBhIG5vZGUgc3BlY2lmaWMgYW5kIG9wdGltaXplZCBjb3Vu
dGVycy4gSXMgdGhpcyBhIGdvb2QgZml0DQo+IHdpdGggeW91ciBuZXcgY291bnRlcj8gT3IgdGhl
IE5VTUEgbG9jYWxpdHkgaXMgb2Ygbm8gaW1wb3J0YW5jZT8NCg0KU291bmRzIGdvb2QgdG8gbWUs
IGlmIENocmlzdGlhbiBLb2VuaWcgdGhpbmsgaXQgaXMgZ29vZCwgSSB3aWxsIHVzZSB0aGF0Lg0K
SXQgaXMgb25seSB2aXJ0aW8gaW4gZHJpdmVycyB0aGF0IHVzZSB0aGUgZ2xvYmFsX25vZGVfcGFn
ZV9zdGF0ZSBpZg0KdGhhdCBtYXR0ZXJzLg0KDQoNCj4NCj4+IGRtYS1idWYgaXMgYSBkZXZpY2Ug
ZHJpdmVyIHRoYXQgcHJvdmlkZXMgYSBmdW5jdGlvbiBzbyBJIG1pZ2h0IGJlDQo+PiBvbiB0aGUg
b3V0c2lkZS4gSG93ZXZlciBJIGFsc28gc2VlIHRoYXQgaXQgbWlnaHQgYmUgcmVsZXZhbnQgZm9y
IGEgT09NLg0KPj4gSXQgaXMgbWVtb3J5IHRoYXQgY2FuIGJlIGZyZWVkIGJ5IGtpbGxpbmcgdXNl
cnNwYWNlIHByb2Nlc3Nlcy4NCj4+DQo+PiBUaGUgc2hvd19tZW0gdGhpbmcuIFNob3VsZCBpdCBi
ZSBhIHNlcGFyYXRlIHBhdGNoPw0KPiBUaGlzIGlzIHVwIHRvIHlvdSBidXQgaWYgeW91IHdhbnQg
dG8gZXhwb3NlIHRoZSBjb3VudGVyIHRoZW4gc2VuZCBpdCBpbg0KPiBvbmUgc2VyaWVzLg0KPg0K
