Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800BD118FDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 19:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfLJSgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 13:36:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3102 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbfLJSgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:36:15 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAIZsbv024680;
        Tue, 10 Dec 2019 10:36:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KgkOeBy0mUpy7hy3MMy6GLHK3YzqNcGgGx0apDHTSYs=;
 b=c8jEafbxN5llCfNmoyMqsGIKlef+dJOvAHkiP0pRH7QZz/ZViUfcsquFaBkI1W0XrnQR
 HQz/ZYLj/9Ulptq3DU6smqWoqvl5rJYVVGsUcpUiEjj2s/b7p1LKfo1rAvRf9IvRq0fs
 N64x1taBvgeY/BVJamAlQRHRGy2rN1TFlqQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wteq4gtx9-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 10:36:03 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 10 Dec 2019 10:35:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Dec 2019 10:35:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOTa8uHtQWgvaq9++J3AgvxKDGjTH6Y/t6PMwozPGhCfmozlCtG0H11Xc0sUpuK1v1ABwgwj2jS99MfChv7O7MLuBSRsfgLQBZB73ap+Een/Tg5mVd00JkX4R+b/WAe3m2z2SvffDRZpUwzekj5HNmsHTrOSr+SuhA29WF94BzfjD6eWw1pu+cXElpNYwuDc22YbmX7nuhmEWM2bVxQqj/FB0+N+/L8Njn4AMPreSAPin3dNPUQkx/uSRVVCgSWY2aRdUfiryFcr23L/gudYWORbCcvziVjOIm/cDFGmVbhyNuJyJl7VWm3s8UgHI+ApGavYtfRZmJVGkcvaSveFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgkOeBy0mUpy7hy3MMy6GLHK3YzqNcGgGx0apDHTSYs=;
 b=ki+CndhI5eMA9khSocAyz9rfZuCD7GXWo8jH5Gnx+dqRNPXyzrN3EpMGQ/TA8iWN0jHom0OAos4WmFGekK/zERSipq1N4DECgleh87s8TQUJUVKA4qR4HyLwkaQmXQZQWTXdH3Dk4XsegABi4Lf3UvhnGppuSauHEWVfCiUxE4UWpcCWXzQ2zQDTj76QpIBT5izFiI9cB6QUaukmFVbO6oM/kO6r2Zl3KVFct6g1ztUUE9s6Dd4totvSSaykEj/WSZ0xb4s2gdJ86g8yNPCVosujftw8REAQ1PltGfCVxgXe62hAaJCXxgzw6Vaj/OrUDWJxObTKRrX5QP6GUrRR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgkOeBy0mUpy7hy3MMy6GLHK3YzqNcGgGx0apDHTSYs=;
 b=Sr+mjLrDpFxMPC0ue4w2TxOKM5trYiQUFLtj1uPgADFn1Jp/wtA3HRAdiLe6JebwqA/A3gqvQbAdrv/SNIkSqHDKlaQ7t60j8NJcaA2Vh1W77dXIWZ7eqlXErKgzikDxEROI7wTO7yZYJfoHmHptxv+JRAleVrpe3mPQWbJMDew=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.64.153) by
 SN6PR15MB2480.namprd15.prod.outlook.com (52.135.66.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 10 Dec 2019 18:35:44 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::21bd:84c5:4e24:4695]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::21bd:84c5:4e24:4695%6]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 18:35:44 +0000
From:   Chris Mason <clm@fb.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
Thread-Topic: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
Thread-Index: AQHVr3Zi4ksLnbPc20yUM2zAd0LZvaezllcAgAAB5ACAABoXgA==
Date:   Tue, 10 Dec 2019 18:35:43 +0000
Message-ID: <A3B79FDC-F1FE-4C9F-B6BA-0C0321C3F47B@fb.com>
References: <20191210162454.8608-1-axboe@kernel.dk>
 <20191210162454.8608-4-axboe@kernel.dk>
 <20191210165532.GJ32169@bombadil.infradead.org>
 <721d8d7e-9e24-bded-a3c0-fa5bf433e129@kernel.dk>
In-Reply-To: <721d8d7e-9e24-bded-a3c0-fa5bf433e129@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.13.1r5671)
x-clientproxiedby: BN6PR14CA0033.namprd14.prod.outlook.com
 (2603:10b6:404:13f::19) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:22::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::1662]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f625e25-ddfd-4f11-ca1a-08d77d9fc3e8
x-ms-traffictypediagnostic: SN6PR15MB2480:
x-microsoft-antispam-prvs: <SN6PR15MB2480C90F06F10E61F9359086D35B0@SN6PR15MB2480.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(71200400001)(478600001)(33656002)(81156014)(2616005)(36756003)(8936002)(8676002)(53546011)(4326008)(81166006)(6506007)(2906002)(52116002)(316002)(86362001)(66556008)(5660300002)(6512007)(6916009)(66946007)(6486002)(54906003)(66446008)(66476007)(64756008)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2480;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HB5iQouVpdq/3i+YhUIXEWwb9LXhXe/sTg1ET6u1ttCcspGGtJBELIEz+OCnzRaAEwRVz0HQHILcCSGtGroSKfyfDrZecovDieq/gaB+cjF95pJVsvzgnjvebesBxhCXoLQehQK3TXCwQ7M/AKenfdLuDPs69YJrXWpadIoXIzo092V3u26peKBvPHZ8QeDiw8reOh4DJy0ksE1McHn5jwTEw9LSNrjOrSEMlqwmmMTGVHBBxX5BzgMatBO5JNV2EbrahtoyIMfilUlv2Eewkorm1RnOgQG3KEZEsDhvWAnOLqoCUOPY5sxGJzA3g4IpHGr9Ya+SxZH2wcy3tzkEMKgDy4XHIMV0iOA6J6bcZNM4ekdtblMTkVyXh2DTSFBDuLBg0+l4jShAQVXqdvgAoiLqqXMLY5O1iZPpX7Ul+S5lAliGoWwGiILll0LZwYvS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f625e25-ddfd-4f11-ca1a-08d77d9fc3e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 18:35:43.9348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KiYlEgcLkFPRtGeKyv5QDNdzOh9YcR1VFF2mzZ09U0gqloZwfuVmCINW/YuT4tk0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2480
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_05:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=687
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100154
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10 Dec 2019, at 12:02, Jens Axboe wrote:

> On 12/10/19 9:55 AM, Matthew Wilcox wrote:
>> On Tue, Dec 10, 2019 at 09:24:52AM -0700, Jens Axboe wrote:
>>> +/*
>>> + * Start writeback on the pages in pgs[], and then try and remove=20
>>> those pages
>>> + * from the page cached. Used with RWF_UNCACHED.
>>> + */
>>> +void write_drop_cached_pages(struct page **pgs, struct=20
>>> address_space *mapping,
>>> +			     unsigned *nr)
>>
>> It would seem more natural to use a pagevec instead of pgs/nr.
>
> I did look into that, but they are intertwined with LRU etc. I
> deliberately avoided the LRU on the read side, as it adds noticeable
> overhead and gains us nothing since the pages will be dropped agian.
>
>>> +{
>>> +	loff_t start, end;
>>> +	int i;
>>> +
>>> +	end =3D 0;
>>> +	start =3D LLONG_MAX;
>>> +	for (i =3D 0; i < *nr; i++) {
>>> +		struct page *page =3D pgs[i];
>>> +		loff_t off;
>>> +
>>> +		off =3D (loff_t) page_to_index(page) << PAGE_SHIFT;
>>
>> Isn't that page_offset()?
>
> I guess it is! I'll make that change.
>
>>> +	__filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
>>> +
>>> +	for (i =3D 0; i < *nr; i++) {
>>> +		struct page *page =3D pgs[i];
>>> +
>>> +		lock_page(page);
>>> +		if (page->mapping =3D=3D mapping) {
>>
>> So you're protecting against the page being freed and reallocated to=20
>> a
>> different file, but not against the page being freed and reallocated
>> to a location in the same file which is outside (start, end)?
>
> I guess so, we can add that too, probably just check if the index is
> still the same. More of a behavioral thing, shouldn't be any
> correctness issues there.

Since we have a reference on the page, the mapping can go to NULL but=20
otherwise it should stay in the same mapping at the same offset.

But, Jens and I both just realized he needs to take the reference on the=20
page before write_end is called.

-chris

