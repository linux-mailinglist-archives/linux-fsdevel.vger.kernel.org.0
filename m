Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65748AABBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbfIETG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:06:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43260 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731206AbfIETG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:06:59 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x85J2cvl030568;
        Thu, 5 Sep 2019 12:06:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=B8+xV9GzHKsrV9kOKYUegi7LiriYRm5wIzn2M1BAhKQ=;
 b=edrCqLJsJynRJrQFCsCfODi8+lcLp0DDxMXFzOihpSAU5P1omQOb1Q0UsJtjVlrTJKPs
 C3b3Ct6qNryaQxnYQzIORGzZORtQ7xPviz3e3j8Pm8aodnlcxqG7ahop68dES2EOqk15
 fCcfpPL6XBYtKaT7d+s/wziWRzCDdr4c+KE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2utxy62nnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Sep 2019 12:06:48 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Sep 2019 12:06:47 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 5 Sep 2019 12:06:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaA2wORSwuWoqonwI5s+jUA+OlUZfHo4yUdQognIs4eLHQnF6HCBks+n5lVfaItrNWg/458jxkekEfQdZUQDY1A32vs48zy8/nWumC/CJ5qSNxAWLz6iX0q8fAuXDFzbemNh7PdbbtWCJoG1HpO6QLchJpLOY9o0mcm9+Gl2REFYwO6Q1ynS5PW7WGcvbVhP0Ip/GIoJRipFFtosd42pu5FEKNJofpgC7v53FFsyJqvchDHwQ8N/6Xmdj0P2yEnM83ok9Hzje2GTMPgt2Aqzjd/AmnSaTBH/h5q+AVolty3DY7M9xT0zSXL2pyN8c2oNYhhGRcJUQU1aXIM15l4iEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8+xV9GzHKsrV9kOKYUegi7LiriYRm5wIzn2M1BAhKQ=;
 b=dlJUEpoDw3typYlJEfLhqq7zf2j61ClPgGajE4OBNo1rlPReYo6+v1JunOf36n9D7V+JVeC0HouTG52FbXu4MjHvMHNsLs73rmkRacL+zWE2KDNqw9nxyS070pvJCiYcVvUssFDY8XRwufjh3G93NfwBXEOt/PtE0O39AjMomVMt5mupOAU3z6PejLB7s2yzm4fi4X0VCBNhtkfyHYqY5L07THj3zMWFb9ZEQKA3AN+5/Tx9NwkSaHaqDx45xbBHr2gozNYANnzKT/3y9dVchpIQmoOHWDsKM46CAjbbn3S5O+r2/Fqw/TgbrsofxSjFpXQ03Msxydz1MXEbXx1gmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8+xV9GzHKsrV9kOKYUegi7LiriYRm5wIzn2M1BAhKQ=;
 b=Xowk5ezhAkgiGsKaXsfRYZbKUVZ6LSWN1ceYVdqpxrjUiTR+p+e36yFO/X3n6ns/ZYM/oogP0lu9Dy+Am0OoBj62NGOn1MCKyyn1gCYfheaFyCyyi0yxdt6qXV96l1is6Imm4VY+oSubg9TJNtnOa2jmDCmMrNIKlsRAw6Ft3Bg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Thu, 5 Sep 2019 19:06:46 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 19:06:46 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Linux MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Kirill Shutemov <kirill@shutemov.name>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH 1/3] mm: Add __page_cache_alloc_order
Thread-Topic: [PATCH 1/3] mm: Add __page_cache_alloc_order
Thread-Index: AQHVZBcl1bq58oOe60i78AS/zsbkIKcdb7wAgAABDQCAAAEngA==
Date:   Thu, 5 Sep 2019 19:06:45 +0000
Message-ID: <F4053DAE-8857-467E-9BF3-3A5CC2E195D6@fb.com>
References: <20190905182348.5319-1-willy@infradead.org>
 <20190905182348.5319-2-willy@infradead.org>
 <75104154-A1A4-4FE3-920C-0069E1B5848D@fb.com>
 <20190905190238.GT29434@bombadil.infradead.org>
In-Reply-To: <20190905190238.GT29434@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:b3a5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eec6a8b2-0fcc-4d11-59c1-08d73234325c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1216;
x-ms-traffictypediagnostic: MWHPR15MB1216:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB12168926B60E9FD1368BD53FB3BB0@MWHPR15MB1216.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(136003)(346002)(376002)(51914003)(189003)(199004)(446003)(2616005)(81166006)(81156014)(8676002)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(14454004)(11346002)(6506007)(53546011)(102836004)(86362001)(8936002)(476003)(486006)(186003)(6512007)(57306001)(6916009)(6486002)(6116002)(229853002)(6436002)(50226002)(76176011)(53936002)(2906002)(25786009)(478600001)(4326008)(5660300002)(33656002)(36756003)(305945005)(46003)(99286004)(71190400001)(7736002)(14444005)(256004)(6246003)(54906003)(71200400001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1216;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qqpg4ZMQbDQhGHwSK+AN4DEbKjLwiReeoOX+DnpDIfXOfRq21AvEKl/zAcWw2Kt1CpMoyK5xU+3h//CepWDe4fgNwtO3tnNWelz1mkPWgRvNFF6BzpJbw30v84RcHqHxy4J988+XksbFf0ZnSx2TSYL4WE/y38/zqCt+DhNy17Ehounu0HS+6Y4cfEEGB55Llj4JdeJn3ftji+YoVzYCs/4sFKg6wx5hhE0jxsIuvUagN8/vxY85TSWCjdO+Iw0triK1HR+3OOVcEj1paI6xQsTpLLVKZUCeAr+y1W3K0+SujFChv9RenN8/4OB2HeWoSvZe1Gnym2C6VXpkVTlJDiR8Bhy2EUNCg50cYuK8it3n/Hlc+P+5aDx/1xMQY12ZdUyQTXuHAHnpjRwaty9NkUWuukNRmZqb3CHwRL49dPQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <55B714F3AB3C2F43BB92EB20CFB2A4D9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eec6a8b2-0fcc-4d11-59c1-08d73234325c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 19:06:46.0036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGmjDKQc+ATDnyl/cu+vFr6RcCM+ILTWUR3wxqoIuwZBBevb7vdeZ0sTSeCFDFnlGd7Q1kvv+G7glDEPWTRLEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1216
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_06:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909050177
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 5, 2019, at 12:02 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Thu, Sep 05, 2019 at 06:58:53PM +0000, Song Liu wrote:
>>> On Sep 5, 2019, at 11:23 AM, Matthew Wilcox <willy@infradead.org> wrote=
:
>>> This new function allows page cache pages to be allocated that are
>>> larger than an order-0 page.
>>>=20
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> ---
>>> include/linux/pagemap.h | 14 +++++++++++---
>>> mm/filemap.c            | 11 +++++++----
>>> 2 files changed, 18 insertions(+), 7 deletions(-)
>>>=20
>>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>>> index 103205494ea0..d2147215d415 100644
>>> --- a/include/linux/pagemap.h
>>> +++ b/include/linux/pagemap.h
>>> @@ -208,14 +208,22 @@ static inline int page_cache_add_speculative(stru=
ct page *page, int count)
>>> }
>>>=20
>>> #ifdef CONFIG_NUMA
>>> -extern struct page *__page_cache_alloc(gfp_t gfp);
>>> +extern struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int o=
rder);
>>=20
>> I guess we need __page_cache_alloc(gfp_t gfp) here for CONFIG_NUMA.=20
>=20
> ... no?  The __page_cache_alloc() below is outside the ifdef/else/endif, =
so
> it's the same for both NUMA and non-NUMA.

You are right. I misread this one.=20

>=20
>>> #else
>>> -static inline struct page *__page_cache_alloc(gfp_t gfp)
>>> +static inline
>>> +struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order)
>>> {
>>> -	return alloc_pages(gfp, 0);
>>> +	if (order > 0)
>>> +		gfp |=3D __GFP_COMP;
>>> +	return alloc_pages(gfp, order);
>>> }
>>> #endif
>>>=20
>>> +static inline struct page *__page_cache_alloc(gfp_t gfp)
>>> +{
>>> +	return __page_cache_alloc_order(gfp, 0);
>>=20
>> Maybe "return alloc_pages(gfp, 0);" here to avoid checking "order > 0"?
>=20
> For non-NUMA cases, the __page_cache_alloc_order() will be inlined into
> __page_cache_alloc() and the copiler will eliminate the test.  Or you
> need a better compiler ;-)
>=20
>>> -struct page *__page_cache_alloc(gfp_t gfp)
>>> +struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order)
>>> {
>>> 	int n;
>>> 	struct page *page;
>>>=20
>>> +	if (order > 0)
>>> +		gfp |=3D __GFP_COMP;
>>> +
>>=20
>> I think it will be good to have separate __page_cache_alloc() for order =
0,=20
>> so that we avoid checking "order > 0", but that may require too much=20
>> duplication. So I am on the fence for this one.=20
>=20
> We're about to dive into the page allocator ... two extra instructions
> here aren't going to be noticable.

True. Thanks for the explanation.=20

Acked-by: Song Liu <songliubraving@fb.com>


