Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A32D414E6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 18:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhIVQ5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 12:57:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60902 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236647AbhIVQ5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:57:51 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MC6K62013331;
        Wed, 22 Sep 2021 09:56:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LIfPRjJ9DRbgubl9vdvqfmyvyvStj+uqaODG1KWb1vg=;
 b=qSVjsRgzoY4IqMMvd1DyCdODxd/TrprOL8rXrIPVGL36h7uGwTyW+qK6BMxyl+k4vwcP
 Cm4aX8zSbHV3ewZ3TTqXW3O72b+j1VLSLBNi8ZSfcNTsWOXjExaZMbVwLEaYGzLPAyDU
 Z64T+41ZyG9xWlsjcAyON2BMWnCs7e98kKg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q5bpg8d-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Sep 2021 09:56:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 09:56:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQHj4ZAlZZ4Av7RgTKJt3/H1T3i2KH3jIA0rasbt/vdu7tkYLRnIFRW/kZ65MwEqvhV4MiU0OICDHF0JFLOIu0Hzl7IhAkRKBIMUa2FXeVRJmmma9b3jQSHKW3DaAUPKNN/HQXjEYDPg5YKmewTgQ6XItCPNRaL4fOobKgcaPdB7SPAigoC64EJPC8HJo7e/oZSTn0b2iQpRmep7UpRLJzhoIFDWhAQ0yEl8emKMMyCQ+sr1JLLaIyFs+RsN4EMPIbWFUgWYhqMNTu4WyomIXw7pOtONNU8jyHzoMB3woa6Zxj5LwheP27OUP/KtU9lr45awFNa+H1ThAeU/z3pOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LIfPRjJ9DRbgubl9vdvqfmyvyvStj+uqaODG1KWb1vg=;
 b=GWYwGuHHo9a++liJG8zOHyZ/wyMrCloOCXxMvsHd86m8qE9FE1HaveWBNkm13DRIhveLYnYwHnOtTTo3cbNX8z6a5+bTdJlEFrwc7jxbKpN8ufJDml0cLvLjGtmenhURK+A2CpNcFmiSMm48feNwUsEgpOLMkS/KpzIleRvcGW3ZOPdD4AI08eYIsDYW672WCuHluujuzrDDBYBEaVvTVW/yOTI4fkIdzDnylzygAO4S6qZ18v6fssrOsxmR1bnP0Rk8tba/NWRc3y7EcVDpz2a9TtxowyCPHOQgxQXNWGpo9WG57kupn6C29XlL830PcFgW1hohVWbnzBz2ih0w7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4924.namprd15.prod.outlook.com (2603:10b6:303:e3::16)
 by CO1PR15MB4875.namprd15.prod.outlook.com (2603:10b6:303:e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 16:56:16 +0000
Received: from CO1PR15MB4924.namprd15.prod.outlook.com
 ([fe80::409a:5252:df3c:dabb]) by CO1PR15MB4924.namprd15.prod.outlook.com
 ([fe80::409a:5252:df3c:dabb%5]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 16:56:16 +0000
From:   Chris Mason <clm@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Thread-Topic: Folios for 5.15 request - Was: re: Folio discussion recap -
Thread-Index: AQHXry7ehRY4Im5hkkC38glmwJhmkKuwKSsAgAAKXQCAAAtEgIAACFiA
Date:   Wed, 22 Sep 2021 16:56:16 +0000
Message-ID: <A8B68BA5-E90E-4AFF-A14A-211BBC4CDECE@fb.com>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan> <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org> <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan> <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org> <YUtPvGm2RztJdSf1@moria.home.lan>
 <YUtZL0e2eBIQpLPE@casper.infradead.org>
In-Reply-To: <YUtZL0e2eBIQpLPE@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 110a6702-8b51-4f59-b6ce-08d97de9e45e
x-ms-traffictypediagnostic: CO1PR15MB4875:
x-microsoft-antispam-prvs: <CO1PR15MB4875A4D40C6F065B6A3463EBD3A29@CO1PR15MB4875.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pSJCDKylDZ/5aAIJutetlBGIRRWa6W+vrJPY0qiAM5LZ6bPlP6SNU6SY3oUR6jzdb4d3qzcD0G/+d7PO5GakiVBMDgjo/rvHcXVEpDmPzKupeYbHtqs7olGL87KdOrDkFfG9aNSfZkHAkFQUiY99240WnIFhA0GolnKx4pw2OM9lnFNH+goSk5qcgBOWvbZoJUo44iwW/WcgBVQrS/Wcte8heUjEodzejIcmjK9CebrxtInqfJT6hb2ORQ10IawtDqmdGjnlcAquYGoSXckMZaDEv4bvEa5MJa+OL7tGRndfSbICxsu+8llGnMc3tZ9F5ghR6ZqWpj2zH3k86SKqnp3XNTHPWDRQZHv4frFNeaaQAM2ICpXbVonbr+3v2nYn5P/KUuQKuf213KGbfN06LlP7okI1SK+zznxd8Bm1bqzzjynlm1Zrf3d4JSIbsiLsqtsMZ1VwdfRetNSpZtkvDK5SYzMD1h0mmbSg8A2bc+5T7T7Mhc348dLR/oKezc/zY1U4NjmGnVdhAdsGBmqlS8nIQg4jVZ4VUgjSJcerRvRp4I8gJcjXkE8QwGYd7vMCRRi6/1UKdPjY1Ak4PuyeBuHJZD5iFqEeK7pcpNK87bAz0sKUMNcL+2bNnh7uZ2MymyH/Ud3evhGGxxOa2oZrv8D96D5hZqB1OJanTAHJjcWFbe7XUdt0Mh9I7HPTh/3Lhca7YAZ25R2/sD9fMuknemXHlbyML9f6C+d1MeUipwn7fYj4KYVAsKqbdDimkRLB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4924.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(6486002)(4326008)(6512007)(66946007)(91956017)(36756003)(76116006)(66476007)(66556008)(71200400001)(86362001)(53546011)(8676002)(6506007)(8936002)(508600001)(54906003)(2616005)(316002)(186003)(38070700005)(38100700002)(83380400001)(122000001)(5660300002)(2906002)(66446008)(64756008)(33656002)(6916009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTFzbmNJOFd4bWNCT3RIUTg0bC9CcDNUSmR5QnZ3dUxxWTBVYmwyeWxBRENJ?=
 =?utf-8?B?MnhYanJOYm5KK2ljSnhPWk44SnlPSFdQVVhySHpRMGRObnlRWHlWeldISkc3?=
 =?utf-8?B?R0RYUXQ5aUNPK1A5RFVYd0NMR1VMN2VNOW9YN2c2KzhDd3JNeEpNUUdJK2Jv?=
 =?utf-8?B?a1RudDNSekxocStCTFY4LzE2RTJqcHQwVFo0WjNsUmEwYTlrMytOSldzemdr?=
 =?utf-8?B?dzRVbHFPZHBWalJLL3gvWjlPMWVaUm5uRnF3WDMzcnFLTlNBVk9nVkhqOG43?=
 =?utf-8?B?dGViaFlTUE5peFVzWmN0TGRURlNIVzVMdmN0MlJ1dElpY0Z2VjVySTZ1UCt1?=
 =?utf-8?B?ZTA1TVM4VFk4aUVWWnZ3ckZNa2Y0UXhDby8yblZ1WlYvR1NxOTJNQ1Z2R25z?=
 =?utf-8?B?REdDc2E1Q1c2RXNYR0dDa2k5ZFd4Uklpdk1zREM5QUc5VXM5S3JnUlAxZG8z?=
 =?utf-8?B?c0pzUnNYcnQ5TUs2VnhQRFVoY29keVdMU3RxTE9hYVFHM0FxZElRRVhEdDIz?=
 =?utf-8?B?cCtNa1VKNVZkM0RvR1RNVGlRYnZYMXZiTVAwdFhjck82QzJFSmFwL0sycU1q?=
 =?utf-8?B?TXcyeEtoOFZsSXNjNFhRRzYzM0p6ZFBzL2piVWFPNUl2R2gwSFUzUExZQmlv?=
 =?utf-8?B?MDBNTy93NFdCbytGbWJiUXorYnA0bFBxQncwNHJOMWxReWxtZ0FzaWtvTFNr?=
 =?utf-8?B?ZTFNNXdHaHQyeHZad1JGTmRpak5xQTNWK2NQbEtZVUhITExETERGZGNqbVM3?=
 =?utf-8?B?Z3lMeEM1U29RMW9ic1lPVjBycURGbCtmZzM0S21vNzVXdnUzQXJNcjRZTVBO?=
 =?utf-8?B?bk9CRTc0MjlUeHVreEROZEkyS1hPM25IWEVXdzdDVVcxbEgzMDFxZ2diNnFn?=
 =?utf-8?B?YkNlUG1aZlFPUVY1SC96S0trYmFZRUZweHlxMEFpb3B3OFI1M2ovWDhxbmE0?=
 =?utf-8?B?czB5N2U3QWR2V20xc0g1ZFNrSDVmdWFjdG5TTHEyUE1lREFPdW1OaHQwZmpn?=
 =?utf-8?B?N05uUWt5cVE4TWFPeXM5a0FKN0JXOHVwQlJvME14ZGtZQ0pqajNCV0RrdHZq?=
 =?utf-8?B?T0Vwc1MzVGZkckFnZUpleDlxbGpxZW5jTllvN1pWMkRoMEdLNnc4Q3liSElx?=
 =?utf-8?B?cERsMFUvSkxDTURuSFAxTjExb2lDZWJZdmxFZWxvbjRFZ3Y2bC93M3E5a1ZH?=
 =?utf-8?B?eVJrckdGb2twVnhVWGlCTGhkZzl5SzhsSjY5dGNtSE4rZ3FOYWJvNjg3TVdn?=
 =?utf-8?B?bXJsazVPeG9vNldMN1JxSmVuSlNkTGhXdmVSRFlEL0hKUit3RURTT2FxVzRW?=
 =?utf-8?B?aDM4NnZWTjFUYWFCVkh5eDBvQnRZaVlUcWY2RFEzR3d3VjdOUTA3a3k5b2Fy?=
 =?utf-8?B?Y1pvUXU3N0VmVkZiSWU1NUFxQ0l5Z3drY0Q1dkN1YnJ4ZFBuS21qYkhQMXZ1?=
 =?utf-8?B?cjVIN1NrMHkwVVZablkyRHRXV3NXaXJtM1BQaXp3OHdObzlaZW9wajZmODFp?=
 =?utf-8?B?NzZwV0d1QXE2bWVDRXA1aWYzK01ZZ05HK2Z2djBiaU1TbXlTVjlSVWlFaVdt?=
 =?utf-8?B?QmtDL0dqTFlNMm43ZmFVZ1ZmWXdxOXZFRkxEcktJM3pFNVQxRGlnRzZzcDFK?=
 =?utf-8?B?V290bC9mMjNCdEZtYTBlV1hJd05HR3F6YUZESDE5SVhkeDIvVzh6MFVwOVlC?=
 =?utf-8?B?ZzF4Y1FZNnZ4SHVraElOa1g0OFdDM2k1NHpLNHFtcWtyY1V3cHFNenBkVmVp?=
 =?utf-8?B?a00vLzNrcFJQSllRUzdmdFZSSHUzOEpaU0hTcDZKNkZWOEpiNDdOS1JQRjlY?=
 =?utf-8?Q?ZlgAPIDZM8L0Jb8fKgnhAij8eVuk8vTKgY0Lg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <55CBA2C928074A4F98DCDE2E92E26AE3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4924.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110a6702-8b51-4f59-b6ce-08d97de9e45e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 16:56:16.1173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaAjZE9FcK1B2VaQD2EF7iQ0OSw7FQu5N00ROMmo6lj25hA/wSIs2n/yo5gu7bEZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4875
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: IOtq36U8RsotMTi-qyxeEC-r3C0jY7sL
X-Proofpoint-GUID: IOtq36U8RsotMTi-qyxeEC-r3C0jY7sL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_06,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIFNlcCAyMiwgMjAyMSwgYXQgMTI6MjYgUE0sIE1hdHRoZXcgV2lsY294IDx3aWxseUBp
bmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgU2VwIDIyLCAyMDIxIGF0IDExOjQ2
OjA0QU0gLTA0MDAsIEtlbnQgT3ZlcnN0cmVldCB3cm90ZToNCj4+IE9uIFdlZCwgU2VwIDIyLCAy
MDIxIGF0IDExOjA4OjU4QU0gLTA0MDAsIEpvaGFubmVzIFdlaW5lciB3cm90ZToNCj4+PiBPbiBU
dWUsIFNlcCAyMSwgMjAyMSBhdCAwNToyMjo1NFBNIC0wNDAwLCBLZW50IE92ZXJzdHJlZXQgd3Jv
dGU6DQo+Pj4+IC0gaXQncyBiZWNvbWUgYXBwYXJlbnQgdGhhdCB0aGVyZSBoYXZlbid0IGJlZW4g
YW55IHJlYWwgb2JqZWN0aW9ucyB0byB0aGUgY29kZQ0KPj4+PiAgIHRoYXQgd2FzIHF1ZXVlZCB1
cCBmb3IgNS4xNS4gVGhlcmUgX2FyZV8gdmVyeSByZWFsIGRpc2N1c3Npb25zIGFuZCBwb2ludHMg
b2YNCj4+Pj4gICBjb250ZW50aW9uIHN0aWxsIHRvIGJlIGRlY2lkZWQgYW5kIHJlc29sdmVkIGZv
ciB0aGUgd29yayBiZXlvbmQgZmlsZSBiYWNrZWQNCj4+Pj4gICBwYWdlcywgYnV0IHRob3NlIGRp
c2N1c3Npb25zIHdlcmUgd2hhdCBkZXJhaWxlZCB0aGUgbW9yZSBtb2Rlc3QsIGFuZCBtb3JlDQo+
Pj4+ICAgYmFkbHkgbmVlZGVkLCB3b3JrIHRoYXQgYWZmZWN0cyBldmVyeW9uZSBpbiBmaWxlc3lz
dGVtIGxhbmQNCj4+PiANCj4+PiBVbmZvcnR1bmF0ZWx5LCBJIHRoaW5rIHRoaXMgaXMgYSByZXN1
bHQgb2YgbWUgd2FudGluZyB0byBkaXNjdXNzIGEgd2F5DQo+Pj4gZm9yd2FyZCByYXRoZXIgdGhh
biBhIHdheSBiYWNrLg0KPj4+IA0KPj4+IFRvIGNsYXJpZnk6IEkgZG8gdmVyeSBtdWNoIG9iamVj
dCB0byB0aGUgY29kZSBhcyBjdXJyZW50bHkgcXVldWVkIHVwLA0KPj4+IGFuZCBub3QganVzdCB0
byBhIHZhZ3VlIGZ1dHVyZSBkaXJlY3Rpb24uDQo+Pj4gDQo+Pj4gVGhlIHBhdGNoZXMgYWRkIGFu
ZCBjb252ZXJ0IGEgbG90IG9mIGNvbXBsaWNhdGVkIGNvZGUgdG8gcHJvdmlzaW9uIGZvcg0KPj4+
IGEgZnV0dXJlIHdlIGRvIG5vdCBhZ3JlZSBvbi4gVGhlIGluZGlyZWN0aW9ucyBpdCBhZGRzLCBh
bmQgdGhlIGh5YnJpZA0KPj4+IHN0YXRlIGl0IGxlYXZlcyB0aGUgdHJlZSBpbiwgbWFrZSBpdCBk
aXJlY3RseSBtb3JlIGRpZmZpY3VsdCB0byB3b3JrDQo+Pj4gd2l0aCBhbmQgdW5kZXJzdGFuZCB0
aGUgTU0gY29kZSBiYXNlLiBTdHVmZiB0aGF0IGlzbid0IG5lZWRlZCBmb3INCj4+PiBleHBvc2lu
ZyBmb2xpb3MgdG8gdGhlIGZpbGVzeXN0ZW1zLg0KPj4+IA0KPj4+IEFzIFdpbGx5IGhhcyByZXBl
YXRlZGx5IGV4cHJlc3NlZCBhIHRha2UtaXQtb3ItbGVhdmUtaXQgYXR0aXR1ZGUgaW4NCj4+PiBy
ZXNwb25zZSB0byBteSBmZWVkYmFjaywgSSdtIG5vdCBleGNpdGVkIGFib3V0IG1lcmdpbmcgdGhp
cyBub3cgYW5kDQo+Pj4gcG90ZW50aWFsbHkgbGVhdmluZyBxdWl0ZSBhIGJpdCBvZiBjbGVhbnVw
IHdvcmsgdG8gb3RoZXJzIGlmIHRoZQ0KPj4+IGRvd25zdHJlYW0gZGlzY3Vzc2lvbiBkb24ndCBn
byB0byBoaXMgbGlraW5nLg0KPiANCj4gV2UncmUgYXQgYSB0YWtlLWl0LW9yLWxlYXZlLWl0IHBv
aW50IGZvciB0aGlzIHB1bGwgcmVxdWVzdC4gIFRoZSB0aW1lDQo+IGZvciBkaXNjdXNzaW9uIHdh
cyAqTU9OVEhTKiBhZ28uDQo+IA0KDQpJ4oCZbGwgYWRtaXQgSeKAmW0gbm90IGltcGFydGlhbCwg
YnV0IG15IGZ1bmRhbWVudGFsIGdvYWwgaXMgbW92aW5nIHRoZSBwYXRjaGVzIGZvcndhcmQuICBH
aXZlbiBmb2xpb3Mgd2lsbCBuZWVkIGxvbmcgdGVybSBtYWludGVuYW5jZSwgZW5nYWdlbWVudCwg
YW5kIGl0ZXJhdGlvbiB0aHJvdWdob3V0IG1tLywgdGFrZS1pdC1vci1sZWF2ZS1pdCBwdWxscyBz
ZWVtIGxpa2UgYSByZWNpcGUgZm9yIGZ1dHVyZSBjb25mbGljdCwgYW5kIG1vcmUgaW1wb3J0YW50
bHksIGJ1Z3MuDQoNCknigJlkIG11Y2ggcmF0aGVyIHdvcmsgaXQgb3V0IG5vdy4NCg0KLWNocmlz
DQoNCg==
