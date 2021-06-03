Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3039AA6D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFCSt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 14:49:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45624 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhFCStz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:49:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153Ie16T080111;
        Thu, 3 Jun 2021 18:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AuVO/sb1RV5jD3TWGkxFlS0Z4JAepY3ThDc2E9hh690=;
 b=lYv18YW57U3DA/tLGfBjCpxA7zI0i5n5OnBtC6qIJolP3P/Ix5v5G6pT6xAukr+NAzAa
 9fGvfWCdmmh4P5RGP4cFji0OJUtBo0ixNq0oY99WYq3x5y57s8/hEEPAvdPKLlcws8+Z
 FF87QbafdJ8yy4dqx6lepqg5XYlRKzoeGVPcqke5DrHjPWOGp/4cmPtciSAnZNr+tWGZ
 XOHa0cCA/4AfwBUuaeSNyGn1dzmYlLTsrL17O0bWaiTvhqei21yjMmPY8PcoNiH0q2Kj
 09Z4co2gw6vc16qyXyisno2Eq9TaYULPpVjjZKGiozqDHriaEaQzj6/Bp1XAsYVUHJk2 pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38ue8pm5dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 18:47:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153IemGd195728;
        Thu, 3 Jun 2021 18:47:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 38x1be5g01-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 18:47:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd0BToY1OeGGFJjQd47q8/5wj1AdZuJ2fuMtEH9rXWBAAw0vNCo8jQHMRV9CEqWZgxjtKECqE1AaXwbaYaRkRkChu2jLxW2s/6NATGKDjhMuh7FP36CA7uZoxJmdW/5A8meDbDhj0ZWCrzcbdF+UypNoTpYpUtlXwZHRgAS4DXDNBfuxdTh+haDM+JUBBDqZMrwHK58TBch3HWsNACfxRcn2cGd87ZbYHjOecmWWBHp2JKJJM8X3SN5DqY81Rqihq8+gu+ufIAzS1HUH6dmZpGNG0bJQTjN1i2FymgKN93wLHZpMgRieNQz5zQ9sB1sNdx23VspmoiRzixM2zimPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuVO/sb1RV5jD3TWGkxFlS0Z4JAepY3ThDc2E9hh690=;
 b=FSAQC2hHZecEz5sCMKbEOVbMEAtM52Br6lL3BTgOVlwTeNAbDpkoJOddooyKiYxUzrOIkl6pym+NzUN0ZLUthdAxLUBFlhqjWCHRcD85DlVv3BxL8VqV4H/cYXjVxySipaVaqKYzhfT5WoSnYkM0qmuPLcQmYXQCdL4KEFrqA7BqU40eblkDAHDc35I0ZAaTKFAIaNBkgVuu9qfc+yjHv5UgZzQq2ZJl5hQDPkiu7i5a++7sNGHWTmUdbUoG47TE/d9r2g985finp2X/1k8CdbEcROjqU+5HTmgIpA1FA+ouK0grKQNmf5Bz+MDsJcw17LnkAzf2cZTf+igEhibRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuVO/sb1RV5jD3TWGkxFlS0Z4JAepY3ThDc2E9hh690=;
 b=pDqCNZrM89ziLaIJqIUfeIT9xD+qh1DGGbD4f3GpYoagR3ns6dT/CrdvKhbm0HmpGzJD1kLpTfzltKDsUDEp39C+HXi4NmZ9kC4/pSipTyImdPW2BwJD6xzYu+Q54UasRmS68b72p6JC0xfrY0FC7MgmeUh1oE82A45KOlyYpOU=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3340.namprd10.prod.outlook.com (2603:10b6:5:1aa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 3 Jun
 2021 18:47:46 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::b8b4:5900:668b:c9c2]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::b8b4:5900:668b:c9c2%5]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 18:47:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 2/4] radix tree test suite: Add kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v2 2/4] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Index: AQHXWKjx/w/vLWm26kiDJqpHUDpMBw==
Date:   Thu, 3 Jun 2021 18:47:45 +0000
Message-ID: <20210603184729.3893455-3-Liam.Howlett@Oracle.com>
References: <20210603184729.3893455-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210603184729.3893455-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85b6671c-4e62-44b2-d73e-08d926c01403
x-ms-traffictypediagnostic: DM6PR10MB3340:
x-microsoft-antispam-prvs: <DM6PR10MB334080454A5D3B2F2923613AFD3C9@DM6PR10MB3340.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TNxof5SKCuq0Y3XIc6IqqQXTfxSXYVsyeBR1DidmcpkPk8x4s+VjLa9WV8WCJKoH+Bfi/KWWulFsDAArVJKFuqDQHxTgjp/qZ3B5B9GV2/UhGt0G1w2xfRujUgZI145s75melQLhueH1j6jcoB0C6KnILKZHPAowzgSHPj4X8IlhANdWsIq9ZMbXuG6GgDfhuUV/gVmaq72xN3BcfRqSExQPdCfhT/UL8XYA7qlCLUBHLiSoXxJlmkPJ1zSzmJ/liZ0ghGzW/Tmjai5bQBNBDmEsJkkuCvnKxRk9k0timkgApVRTl2WX4Os4ZCk51GTGnW0kcBfYFEcdLhIBbrojvgAnhGeHZ3Szlb7a+wp2kS6lBOvz9NmAAxr+dLnk9hQ91P/2RFTP8z+mJKS2ZgRarOm8FkDhcJAVF937k8jrksya0NMxULPqWAXWDnmhWMWios64NHLGGaXCX5ikIIoj9JxNqcapcJ55BAZ5GWgQDU27jnr3rY1CC/GXUifncKadYM8EXz7BuRNKlXKpfGVlPDxuiDm86caXkoI18XZuyiKPETrpWyindNNbpw4GKNeay1efiVHx+hPh1symPzgW8MOZEB9yXR5f7YP3DGO0lYo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(39860400002)(136003)(478600001)(71200400001)(66476007)(122000001)(66446008)(64756008)(66556008)(91956017)(66946007)(83380400001)(76116006)(38100700002)(44832011)(4326008)(1076003)(2616005)(8936002)(26005)(6512007)(6486002)(8676002)(5660300002)(186003)(6506007)(110136005)(316002)(36756003)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?+sZFNz1nM480x6WbmHuhXoBTeDw5ABbmsOnGmFymVWFkGBTbPNeFxV2ESp?=
 =?iso-8859-1?Q?yXZyPQ963gUQ32FTA9eQXbM7cV6npQ19qg1mkzNQoNWJXBgXVEPvkFoBsv?=
 =?iso-8859-1?Q?OpiYsPW1vycbu+9rZU5q/zOgUhahtfoHbn0SOrWWmaWItYdR8vCu/cv5o2?=
 =?iso-8859-1?Q?ZhF2LjGotxAezk1hRZJEttl1hwkVfjsJQZ33+PiPn+MAUJpwb3TRDovWfC?=
 =?iso-8859-1?Q?MGfeInab3F505h0YWSdsZzvajF8LubJ4Rev6AKFud16FIxVdzuZ5Z+CPqU?=
 =?iso-8859-1?Q?OGfk9yXNOHlGvboPG8TH7qU2tYeAoKVdeCczW2tASOMablKF8b22AKu65g?=
 =?iso-8859-1?Q?LNz+c89Rj7JuKtLxzTZ28fw+ARv2usNt1A1I+Gfb2jHwZB1AqTJSB87C6B?=
 =?iso-8859-1?Q?y3t3cneu3AfERC7d58G/QsPEbbxOUWpl3tueMhbUHDmbx/6x9SAtZpVgU+?=
 =?iso-8859-1?Q?7Dy3dBjY5WeTiEPETUO98VnkroWEo+td9ubNL9HGT/Zztrb9HtaLLFLtWV?=
 =?iso-8859-1?Q?KYm/NxjKYysuyquxq6lit/Yd953JqSM4I2zFujxYwvjepWzLUMKf4qIswE?=
 =?iso-8859-1?Q?PIfqrJ7vtcLSV757CjJfhV/bha8YrmGIerMpwFGqh7/C8VrVElOCdMGFYC?=
 =?iso-8859-1?Q?GyHP+1wZuwD8RJHuFKAKYOmjhaYG86JABRWKXlIJvIddlXg9FELU0ryBxM?=
 =?iso-8859-1?Q?i36hrjuxH6VF6FGbVwRDUaNyiHiiIlo43/MSWMgOEKq1i1/tLieSVFhMUJ?=
 =?iso-8859-1?Q?gtEuHKIYKqYMNiaMh+3VFtoLtco/BkSjg/sYHcUREMKtRwyGwDWsnsoky3?=
 =?iso-8859-1?Q?oudec6RNpIoQQZFC6YqW+zP9y6sFZHNiOusrOT9Z7OcQDq+aR38TEnmHp3?=
 =?iso-8859-1?Q?AzK3e5N1y2uj1N+wgpZDD3Ke6cQc2b9GSyvT9Oxg+0X5N8oscl0qzOLARI?=
 =?iso-8859-1?Q?Q3DUQgWbWiuq8bMQzg2h7rMfcp90fZttigJ5UYGpwJsHRILQyQrOk2XDVd?=
 =?iso-8859-1?Q?djYc+j7vLWqNGQndnMGeorxTOtnRA1shoTEHmg+a+o8NNf053hJTdbJgqm?=
 =?iso-8859-1?Q?gvxGTRW96eTEpW9Hv/CPO0sKXGH+1o+xXCvtfdDic4N6Tw2XlVFeVgqy9e?=
 =?iso-8859-1?Q?R/cQxnMOZSjs9ZYcNYsyuToawm372l5sm7hLGTCmvRP8rdF9nvXHxy3vuJ?=
 =?iso-8859-1?Q?8ukwrl8ARkj1/KdjafN3kHrLsDzQxrSlkQWbgDi1jH0SKthZhZWJmYeld3?=
 =?iso-8859-1?Q?+MEWG01H+HHg1k4qbrRLQSKyVus9TImrTJQZjca1UbPivBIsgwkl9ghrbh?=
 =?iso-8859-1?Q?xjTUG9O+RGVGXiCgOpemFixEVk9+BpeDs0/lTzeC9eIVSX7hWn5/WTkIcY?=
 =?iso-8859-1?Q?f5tBXeY34G?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b6671c-4e62-44b2-d73e-08d926c01403
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 18:47:45.6796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRgNXqyIinsJXZ3ZtiMoDWUSP7+Ksy1c3yKJltUf2ZcrCL4sIwUbOsGREGkNk1UqiJDdJGGmYLdzAQGvz9grWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3340
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030126
X-Proofpoint-GUID: 2Pz9o7KrtpQ30wlRh5q96hO4CALLx1yG
X-Proofpoint-ORIG-GUID: 2Pz9o7KrtpQ30wlRh5q96hO4CALLx1yG
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030126
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmem_cache_set_non_kernel() is a mechanism to allow a certain number of
kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set in
the flags.  This functionality allows for testing different paths though
the code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/radix-tree/linux.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 2d9c59df60de..00ee01a14652 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,14 +24,24 @@ struct kmem_cache {
 	int nr_objs;
 	void *objs;
 	void (*ctor)(void *);
+	unsigned int non_kernel;
 };
=20
+void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
+{
+	cachep->non_kernel =3D val;
+}
+
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
=20
-	if (!(gfp & __GFP_DIRECT_RECLAIM))
-		return NULL;
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (!cachep->non_kernel)
+			return NULL;
+
+		cachep->non_kernel--;
+	}
=20
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs) {
@@ -116,5 +126,6 @@ kmem_cache_create(const char *name, unsigned int size, =
unsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
--=20
2.30.2
