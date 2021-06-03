Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C9339AA6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 20:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFCStv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 14:49:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46154 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhFCStu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:49:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153Ie3Te131043;
        Thu, 3 Jun 2021 18:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HpBWLO59aXyZyK2wJx11zwDttp5bAdeRTDkLdKRjigA=;
 b=oeuseIfzbaJk8gkr6CyoeOiKRxQ+OkVp1zPxWHaMvAmxNuLk1bA1t35+f58kZ1/5EGmj
 l/FFhldiTmi9iCwtRQ2xo2Wi0F+ta4UH1VhwV7b2YRphl561eBIazGC045AUDxXx9KNh
 kAeOOEEBzK5qj0K39djBGeOVIWAzABTkRreCw8XZ5coj/ZZq8q93u4OVKiliQs/fAbwJ
 RwSNBFsjGfwFuXGdraR0PJR2ytkv5jeAPoasc6l5eu43p5H7+Dgui147Pj/K1zKCiHaz
 gWjr4Vzx5YIG/0eHiKffkl+l82CmMJUYpX5xD5AL+gs39hXIR8li3dS1HzZwDzT8gUJt UA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38ud1sm5kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 18:47:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153IemGf195728;
        Thu, 3 Jun 2021 18:47:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 38x1be5g01-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 18:47:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/w/kQ4Fc0/C7K7Q1u24UvxN2pFxya7C21WCB+v9k6yOwPuix+K9V6S4fp1D/ZpeCoK4arnEuwLBji7eGkP6efb9+qHfJJ1BuM6CsBtuYU4uc5S18zoFNN1zx2xXK1R5w+zkW0Ee+Qzgw/crx1jbnrguGsHEW/NKdbC3tI4IbaITEqpOwOMjKZrXTbwYIrnLnP2C9/yTy5tYPfdO4zsVKiPCjscS1T+KMFL2+iBHE8E6Z7wjt7wjyzA0EsANCQ096+cZydM87ZiMBl+YvEI+h5O5qHNZQ+1VkQujgw7h5MS26cxYB4hPh+CPEH0cpFrIBVlKwEbwz/mQ3LceeWAp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpBWLO59aXyZyK2wJx11zwDttp5bAdeRTDkLdKRjigA=;
 b=E1vYO7hBsZDMPf8dvVGfjSfJJAAyP4uSSkQUSWsPlUSFF4/MGZ0GpNn6eAvXvhIzGvPvBrWSDnQApDytJhbodMCye3yLZRCTOrTBVhDFTi1lm5VPkGmb3W1DaIVK8Aujj96i9Gh0fKcErQVxr8ngX6+7vSbsFL+ki58a5896pu3utwlcpRO4v9kdjMlXDkyGmgBJAxB+bdgAhGd50TEjUsNX+1UXuUC+Jv6htLgUwfRkzAtcgWgynxN3hijLm9KyNf7RlHwyCrcvwZKg6ewF/d/OpA49YfHaxWgogXCQiYOnlcnR5tkjAWhCrpassxd5sYVGi1TDHKLD+Dc/sqMMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpBWLO59aXyZyK2wJx11zwDttp5bAdeRTDkLdKRjigA=;
 b=fn3aIvXWD1y4/Eu2kWI33+dmvuNOTSrI81H2znHA2j0pw3aaI9nILAsGBhF6OaPvWDBM9/3S+1RqT2FJP5giROj8tcRuA5Ib0eAXpSHYpCTnxWwZvw++Ot7k4Ak8TALTgfCLusaSGw+mnYxN5u+oF34bqeiyOWODqJ9IfuZWPkM=
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
Subject: [PATCH v2 4/4] radix tree test suite: Add support for slab bulk APIs
Thread-Topic: [PATCH v2 4/4] radix tree test suite: Add support for slab bulk
 APIs
Thread-Index: AQHXWKjx9kuGxl+yHEqWGf626FHP4Q==
Date:   Thu, 3 Jun 2021 18:47:46 +0000
Message-ID: <20210603184729.3893455-5-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 536cffb0-1ac7-493c-57fc-08d926c0147a
x-ms-traffictypediagnostic: DM6PR10MB3340:
x-microsoft-antispam-prvs: <DM6PR10MB3340969365E2B40DBE1F1D39FD3C9@DM6PR10MB3340.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qHlNoVNaNsHheFYyjQ6UU3AGeX15LLrkI/TFo7MvWNg+NQUIIEU5ox2M5DyMrcfo5HHjyq71ADznLM+St5+uZOr8BSaNw5IfkLWRqgNho3fICNg1i03+6d9BEKOoPKIkf0CukgEC29QR6NpC1VQnzGVoP7UyB9k/VisyGXzdPnUFcCs4wrRu8UHthhnNOeZJH+J2dTSnt5rzacT52u1lNc85npurcH1i0TlQKem6QM3MApL4vLkXGqsSQup0ZUOLyQy64aq94Imsc5q2aT1sIzqzo4k4c89zigGpP65wRW8DfoFiMPD4OGSQ2TEILkkQJqz//wI1KxVSV+FMtsOIBacd+T1eo5RQVfZ6iEQf531pKS/Wll50ACZfy676hsQgMpJk6Gq4LJpe7bQXcWKeJ8bJ0K9iT6mNjHBg/2EY2+17FBJlWV06FfNuLTokJABJo/QpASUA0ezuRB6mkfz01EKgnjrOHo95XEHVnL+tiVTFPMYYfrTJZKTznZvucBQfP05Bhnkg8eVWOR9fBnP408Tb4IxMp1HMcHYJfgni4yXPSLyJF9Pd2oa1cFhcAQ7888mr/O8gA0Bwkjf5C6+LsiUwy+YEZ4tQIlDMv+4i5Rw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(39860400002)(136003)(478600001)(71200400001)(66476007)(122000001)(66446008)(64756008)(66556008)(91956017)(66946007)(83380400001)(76116006)(38100700002)(44832011)(4326008)(1076003)(2616005)(8936002)(26005)(6512007)(6486002)(8676002)(5660300002)(186003)(6506007)(110136005)(316002)(36756003)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?un+aexnB7RTnX5T0eURi3qTsOo+EPgjiz4B+kk4FJ1gKYYPyt/4C5/fQs5?=
 =?iso-8859-1?Q?V2LCQ6IeWlzlR1wgn2h0VGzXqDrxTJDXOwSHOmqpoJmKsTAVuaBRmngS7A?=
 =?iso-8859-1?Q?gEmpo8wYS7U0kasw7/70ZcX8Kct9rm//OSiXrv8xhxRvrmxROHEPRCxx5Y?=
 =?iso-8859-1?Q?+yPDz3dXgRom6cq/x8ACDEr56gP3LHn2K/minImet0oIMj7D/AS/JXcsNP?=
 =?iso-8859-1?Q?tdFX1LXEmRf0LAJzIvm2Cl7jjpBce54nYIXq32xNbNuQ4bXYAGM5mnqBrG?=
 =?iso-8859-1?Q?/gY13ObV4qgKPedYQqXzbZ3/ExKAIsCBlHqtsN7kjt7uUjUWQgwoWtVLU6?=
 =?iso-8859-1?Q?5u7hlNpK1Z6R7Id86ahAD+bGWxZNxihoYVmUFLXi0qgHtLMn5F3SWiZb/g?=
 =?iso-8859-1?Q?OhLq8mA6lrHdDEfIrBwaWCgNTk71A/nBmRsLM1Ntvfk1/iuCwEHYqyLlLU?=
 =?iso-8859-1?Q?l4F89Wv3mu5zWbYnrqWte9WefTu0qP998mqUOT0UyutGtKEaV+PycEIbku?=
 =?iso-8859-1?Q?QARXb9DAUuoED0kstTJXVBc3KaycoX3qTY/56gWItwtyJwNtJbg6WEM+XM?=
 =?iso-8859-1?Q?w8Ib3kZDkrWcpYuvyyNigZmcf9H68wUX0TW7rOKbnfyOOI/WUACKO4DtBU?=
 =?iso-8859-1?Q?pKL7MNX5Rv2Koh+av4/KCtjdb4/G1Z9NEhhH9pdi34Ul0DanpiAiE9c9RF?=
 =?iso-8859-1?Q?fi+HpFxHv3PjEPRqbUgoK5FPOpcl1VYylzQc/fXw0CX1U9A0eiQRn6iJ6H?=
 =?iso-8859-1?Q?Xq//Px1UCV4MWXMEBfz5bccKvzOtEcW9PwPD9QcthDhl7b7ZmE++z2aOMo?=
 =?iso-8859-1?Q?PPiyS+F1aWlacZhWhmJ0zBkWwsiDhod+byDMjh4rB6d0MQap406TGPk5Jd?=
 =?iso-8859-1?Q?HEl2hGtP0uUYjsJZJMwk19ovpNODx9JU8javLi7b4AhEeX9n19Ha336w2U?=
 =?iso-8859-1?Q?iPzfAEia1L1da26qsMg9C4wYN4BS2NYMtF5atZhIfY2BtHk1BNhkspnGyQ?=
 =?iso-8859-1?Q?LgTHuWvWfZAzNeVSylWmon9ObBsdzByR9Eb81HPRkZsb8UJooPhzD57uiB?=
 =?iso-8859-1?Q?ooY3P4VFHpNCzNfoANN1v06Of/MEnDJJmdSqdY4VvsO0GckEGCrLsfv7ay?=
 =?iso-8859-1?Q?hjLuZdcjOh1uVtSO3sPVO5OiyqvQaZyYJiput6caIK13hs4PRh8gyIcb6J?=
 =?iso-8859-1?Q?uQGjZbYoUXdWvIh4boWzoHb/h7dp0kutgWfGX1L6XgUywGYFmb1qRPEJY6?=
 =?iso-8859-1?Q?5PgX2cKx8Z4T10GLzoCCP3oxdRPHvUZZ62lx8SiqFiWT2ENi7fgRZQELPs?=
 =?iso-8859-1?Q?OQ5IW1DazsyIXTgZJ4qtdPv34syXbQe3KB1HcQEBSv4oEzWtNxNV2pkH/x?=
 =?iso-8859-1?Q?dX2J6F6shE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536cffb0-1ac7-493c-57fc-08d926c0147a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 18:47:46.3895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hiuG8jjNLrxTHywEMLdf4rOX8zUvTc+5jMhFJgr7QqSurRCcn+S57IGUTYjGh+554J5dU4wvCTK8/N/Ovz7JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3340
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030126
X-Proofpoint-ORIG-GUID: Qt-Qr3qy9Y0d_ong4lTEY0IcGXfFdi0b
X-Proofpoint-GUID: Qt-Qr3qy9Y0d_ong4lTEY0IcGXfFdi0b
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030126
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for kmem_cache_free_bulk() and kmem_cache_alloc_bulk() to
the radix tree test suite.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c      | 118 +++++++++++++++++++++++++-
 tools/testing/radix-tree/linux/slab.h |   4 +
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index f95e71d65f00..3383d748c650 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -93,14 +93,13 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, int g=
fp)
 	return p;
 }
=20
-void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+void kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
 	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
-	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs > 10 || cachep->align) {
 		memset(objp, POISON_FREE, cachep->size);
 		free(objp);
@@ -110,9 +109,80 @@ void kmem_cache_free(struct kmem_cache *cachep, void *=
objp)
 		node->parent =3D cachep->objs;
 		cachep->objs =3D node;
 	}
+}
+
+void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+{
+	pthread_mutex_lock(&cachep->lock);
+	kmem_cache_free_locked(cachep, objp);
+	pthread_mutex_unlock(&cachep->lock);
+}
+
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist)
+{
+	if (kmalloc_verbose)
+		pr_debug("Bulk free %p[0-%lu]\n", list, size - 1);
+
+	pthread_mutex_lock(&cachep->lock);
+	for (int i =3D 0; i < size; i++)
+		kmem_cache_free_locked(cachep, list[i]);
 	pthread_mutex_unlock(&cachep->lock);
 }
=20
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **p)
+{
+	size_t i;
+
+	if (kmalloc_verbose)
+		pr_debug("Bulk alloc %lu\n", size);
+
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (cachep->non_kernel < size)
+			return 0;
+
+		cachep->non_kernel -=3D size;
+	}
+
+	pthread_mutex_lock(&cachep->lock);
+	if (cachep->nr_objs >=3D size) {
+		struct radix_tree_node *node;
+
+		for (i =3D 0; i < size; i++) {
+			node =3D cachep->objs;
+			cachep->nr_objs--;
+			cachep->objs =3D node->parent;
+			p[i] =3D node;
+			node->parent =3D NULL;
+		}
+		pthread_mutex_unlock(&cachep->lock);
+	} else {
+		pthread_mutex_unlock(&cachep->lock);
+		for (i =3D 0; i < size; i++) {
+			if (cachep->align) {
+				posix_memalign(&p[i], cachep->align,
+					       cachep->size * size);
+			} else {
+				p[i] =3D malloc(cachep->size * size);
+			}
+			if (cachep->ctor)
+				cachep->ctor(p[i]);
+			else if (gfp & __GFP_ZERO)
+				memset(p[i], 0, cachep->size);
+		}
+	}
+
+	for (i =3D 0; i < size; i++) {
+		uatomic_inc(&nr_allocated);
+		uatomic_inc(&cachep->nr_allocated);
+		uatomic_inc(&cachep->nr_tallocated);
+		if (kmalloc_verbose)
+			printf("Allocating %p from slab\n", p[i]);
+	}
+
+	return size;
+}
+
 void *kmalloc(size_t size, gfp_t gfp)
 {
 	void *ret;
@@ -156,3 +226,47 @@ kmem_cache_create(const char *name, unsigned int size,=
 unsigned int align,
 	ret->non_kernel =3D 0;
 	return ret;
 }
+
+/*
+ * Test the test infrastructure for kem_cache_alloc/free and bulk counterp=
arts.
+ */
+void test_kmem_cache_bulk(void)
+{
+	int i;
+	void *list[12];
+	static struct kmem_cache *test_cache, *test_cache2;
+
+	/*
+	 * Testing the bulk allocators without aligned kmem_cache to force the
+	 * bulk alloc/free to reuse
+	 */
+	test_cache =3D kmem_cache_create("test_cache", 256, 0, SLAB_PANIC, NULL);
+
+	for (i =3D 0; i < 5; i++)
+		list[i] =3D kmem_cache_alloc(test_cache, __GFP_DIRECT_RECLAIM);
+
+	for (i =3D 0; i < 5; i++)
+		kmem_cache_free(test_cache, list[i]);
+	assert(test_cache->nr_objs =3D=3D 5);
+
+	kmem_cache_alloc_bulk(test_cache, __GFP_DIRECT_RECLAIM, 5, list);
+	kmem_cache_free_bulk(test_cache, 5, list);
+
+	for (i =3D 0; i < 12 ; i++)
+		list[i] =3D kmem_cache_alloc(test_cache, __GFP_DIRECT_RECLAIM);
+
+	for (i =3D 0; i < 12; i++)
+		kmem_cache_free(test_cache, list[i]);
+
+	/* The last free will not be kept around */
+	assert(test_cache->nr_objs =3D=3D 11);
+
+	/* Aligned caches will immediately free */
+	test_cache2 =3D kmem_cache_create("test_cache2", 128, 128, SLAB_PANIC, NU=
LL);
+
+	kmem_cache_alloc_bulk(test_cache2, __GFP_DIRECT_RECLAIM, 10, list);
+	kmem_cache_free_bulk(test_cache2, 10, list);
+	assert(!test_cache2->nr_objs);
+
+
+}
diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radix-tr=
ee/linux/slab.h
index 2958830ce4d7..d7aed1cc6978 100644
--- a/tools/testing/radix-tree/linux/slab.h
+++ b/tools/testing/radix-tree/linux/slab.h
@@ -24,4 +24,8 @@ struct kmem_cache *kmem_cache_create(const char *name, un=
signed int size,
 			unsigned int align, unsigned int flags,
 			void (*ctor)(void *));
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist);
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **list);
+
 #endif		/* SLAB_H */
--=20
2.30.2
