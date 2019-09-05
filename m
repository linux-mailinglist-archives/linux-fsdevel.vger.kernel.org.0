Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D3AAAB9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388405AbfIETBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:01:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61920 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728258AbfIETBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:01:17 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x85Iglxw029269;
        Thu, 5 Sep 2019 11:58:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ShcZD9SyOvFPY7J5OBfaO33KdAibChsNU2k+yIarhrI=;
 b=cbAhRzHwMDwnzPRKIXrqEzQGLBCXMUAeF3m26ncFyqYgD+RQGncm2f3eJL0jdYI0l7eY
 3Q0jp5owpMZ0ZnH3we3BhrZogrJVlo9lHguM1hEuK7QHUSgzxIg5r2Cemr+mY9pBlBqy
 cW2y2aLpURTHToxm46Z3/vs8/GgX5jEL7K4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2utxy62mat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 11:58:57 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 5 Sep 2019 11:58:55 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 5 Sep 2019 11:58:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dvo9sO2wHqwHz+eJBLrTY7bgrZ7YBWhJW8HQ2OPrP3/uSGy6GoBe46h85wo95JoUBiQUaqfE2P1hB3kS3PfPJNeJkc48nbkDTShQYOrRDiVKw4MGBFsAJIygvImam6tEyZpxNatPph+n3jVnHSXYxAHvb9eXIgZfjkFDHYvOaUoSDDQI6qU0/SDDvGe4N1v/RT5kh+RWEOzAK8cIMoVvwcmy1NJLUBIjiTTpv3CVfpDCdTzP42SBMdn5fspXJ777CFe0lKRgnOl1Q7k7qq1F71LlNG38dmb5I5ScSwL7gu5IX6vqkDr2PjLqJ18lnwUHRN7sVjl67+Q6jYgblJ2/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShcZD9SyOvFPY7J5OBfaO33KdAibChsNU2k+yIarhrI=;
 b=T8iepjEeGhtlsmN6K77PjX8NGsKcBfhnsCrC6QSAS28H43JlxQhOI+eWYIFoAmsDr3aS2jdjk9rql9Sm3aZGRgj3DNWM7F/7Gak3OBXP4mTZFn/R39TBxSJ9cl334QLQuZ81xl3BNIT90yA6PetisfwJkGStM81GRj1bwkzBxnNJ0pYyjwvliK6fZOGXVqrHhkUSn8wl8lpKqKMZUuBybXY5646EwkapFil+/vdWxWpFiC6twdiCDwlW2Ku9a60AHyCOgPdJsi9DvZ4Q3dMkG1UZSqMUwQpTVXoeK+N0vShcby8MektXk8U6zPtzUSD+G9MQU4FamMb3UwS5yHHijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShcZD9SyOvFPY7J5OBfaO33KdAibChsNU2k+yIarhrI=;
 b=A8Y1AaezbHOMSTh/0kTix0nsPGe8va15aV3Jre1vICsjCKRtavYgm4GL2gHxccBYb7u627lup0W+DCCOB4dW4PuizQLWdZE96iRC5/LrmCiR86V0LS/Lwjo/9piHFym6p/ht2ydXmg7VXk6JhVM4sW5tT4pKQA9w4xGnoVUTjZ0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1454.namprd15.prod.outlook.com (10.173.235.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Thu, 5 Sep 2019 18:58:53 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 18:58:53 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Linux MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Kirill Shutemov <kirill@shutemov.name>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH 1/3] mm: Add __page_cache_alloc_order
Thread-Topic: [PATCH 1/3] mm: Add __page_cache_alloc_order
Thread-Index: AQHVZBcl1bq58oOe60i78AS/zsbkIKcdb7wA
Date:   Thu, 5 Sep 2019 18:58:53 +0000
Message-ID: <75104154-A1A4-4FE3-920C-0069E1B5848D@fb.com>
References: <20190905182348.5319-1-willy@infradead.org>
 <20190905182348.5319-2-willy@infradead.org>
In-Reply-To: <20190905182348.5319-2-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:b3a5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c66ce6b-0190-4666-2cf5-08d7323318be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1454;
x-ms-traffictypediagnostic: MWHPR15MB1454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB145456EB7D1345D81C091F1DB3BB0@MWHPR15MB1454.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(99286004)(6916009)(6512007)(229853002)(6246003)(5660300002)(57306001)(7736002)(446003)(46003)(305945005)(54906003)(256004)(14444005)(33656002)(11346002)(6436002)(50226002)(6506007)(14454004)(2906002)(66946007)(8936002)(64756008)(66446008)(66556008)(66476007)(478600001)(476003)(316002)(2616005)(8676002)(81156014)(6116002)(81166006)(25786009)(36756003)(86362001)(71200400001)(71190400001)(6486002)(486006)(4326008)(53936002)(102836004)(186003)(53546011)(76176011)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1454;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vhVZVMlPmlLD+Df+RpXsy51oS4ZIBQUFd35eQV0/SH7MnhBHeuSmLSeRhcOUcm7hENCpPG5rnJkIm3ZM0VU/FMR8HPk4SFu+3NWatDW1ECQd0DfjR07oXCasN3zvXSvCW3eW0LnQTJISs8hJrYYq55uJ+imnIkAtDzvG/q7y6MMTbVakoQIvJoMkrgehqx61h/i7dGMkGJhP29FCgLg5o4gmiRO3qfKslL0CVPBBn5hEE/5zH5ZCCZNhUz8z1IVbOrBhn7nHIfWOO5lEkXTSu7o94QIkdqpLeDpdNIQxoN5HCAvYyBzoT1x6HqFiLRTD+DPgZKhC6AaPLQuW74RLs1splHNR2b3k/HZHLX4UvxnnL6ClmgAzbbfTVfyTN7Wn4QpL71ylx+jlAUSqwdfiLCtgqqbV9gIu5Q8oXMAMhgU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3A97E74BA5C47448ACD10B4C4A1FCEC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c66ce6b-0190-4666-2cf5-08d7323318be
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 18:58:53.4872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gx83V91kLdpmATm+m0vQNECO2+s11uRKZL4ZBk0Y3hwWIfy3+d2fDW08dyW7f9oO3NDltSqiWnuH3zZgVCjzEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1454
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_06:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909050176
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 5, 2019, at 11:23 AM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>=20
> This new function allows page cache pages to be allocated that are
> larger than an order-0 page.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> include/linux/pagemap.h | 14 +++++++++++---
> mm/filemap.c            | 11 +++++++----
> 2 files changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 103205494ea0..d2147215d415 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -208,14 +208,22 @@ static inline int page_cache_add_speculative(struct=
 page *page, int count)
> }
>=20
> #ifdef CONFIG_NUMA
> -extern struct page *__page_cache_alloc(gfp_t gfp);
> +extern struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int ord=
er);

I guess we need __page_cache_alloc(gfp_t gfp) here for CONFIG_NUMA.=20


> #else
> -static inline struct page *__page_cache_alloc(gfp_t gfp)
> +static inline
> +struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order)
> {
> -	return alloc_pages(gfp, 0);
> +	if (order > 0)
> +		gfp |=3D __GFP_COMP;
> +	return alloc_pages(gfp, order);
> }
> #endif
>=20
> +static inline struct page *__page_cache_alloc(gfp_t gfp)
> +{
> +	return __page_cache_alloc_order(gfp, 0);

Maybe "return alloc_pages(gfp, 0);" here to avoid checking "order > 0"?

> +}
> +
> static inline struct page *page_cache_alloc(struct address_space *x)
> {
> 	return __page_cache_alloc(mapping_gfp_mask(x));
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 05a5aa82cd32..041c77c4ca56 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -957,24 +957,27 @@ int add_to_page_cache_lru(struct page *page, struct=
 address_space *mapping,
> EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
>=20
> #ifdef CONFIG_NUMA
> -struct page *__page_cache_alloc(gfp_t gfp)
> +struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order)
> {
> 	int n;
> 	struct page *page;
>=20
> +	if (order > 0)
> +		gfp |=3D __GFP_COMP;
> +

I think it will be good to have separate __page_cache_alloc() for order 0,=
=20
so that we avoid checking "order > 0", but that may require too much=20
duplication. So I am on the fence for this one.=20

Thanks,
Song

> 	if (cpuset_do_page_mem_spread()) {
> 		unsigned int cpuset_mems_cookie;
> 		do {
> 			cpuset_mems_cookie =3D read_mems_allowed_begin();
> 			n =3D cpuset_mem_spread_node();
> -			page =3D __alloc_pages_node(n, gfp, 0);
> +			page =3D __alloc_pages_node(n, gfp, order);
> 		} while (!page && read_mems_allowed_retry(cpuset_mems_cookie));
>=20
> 		return page;
> 	}
> -	return alloc_pages(gfp, 0);
> +	return alloc_pages(gfp, order);
> }
> -EXPORT_SYMBOL(__page_cache_alloc);
> +EXPORT_SYMBOL(__page_cache_alloc_order);
> #endif
>=20
> /*
> --=20
> 2.23.0.rc1
>=20

