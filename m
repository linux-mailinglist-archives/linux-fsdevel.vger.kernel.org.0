Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7334337EBE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378107AbhELTj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 15:39:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37842 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358836AbhELSul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 14:50:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CIjpcO039831;
        Wed, 12 May 2021 18:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2AUChyL1YDsfAL9qtR4tOnBwVF+/pbaF+GWIekH6RJM=;
 b=AHmpb+juOOz9459bDA8Sr1rsQYnqhR4rxB8AzMb6QvqOuUfvN6A7Lbn2Ck9kebRUt1Cq
 u2SeFDwDjXkP/RtZqWrqpTGalMOdMDivFdChV1SvyJjbtphtf2vD8DqaKj/USEhfrQTF
 u5qVievBX2uIgnicnySoNjJwatqvavvduv8fahhlQ1eygSCxXtW0kPst03sF85afRhvN
 XbzuEXloR+BIL/OMm/OAQcnU9A5Rd8ajQw0Y5Sf0CMzQLIJeA9K4NUmJS4nHd2Oxnnz2
 j7vTSS40h9bL96AQogQKBGz89kLRTeotHEzFKF3dmWNrgRzYsqLG3/iElL2L1hMfyRng xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38e285j8k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 18:48:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CIk5nI085840;
        Wed, 12 May 2021 18:48:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3020.oracle.com with ESMTP id 38fh3yj59b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 18:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB9waYSbxUPMWRqNAACUeWZtukYXgG9ITXDDzhZXJrQ6ghnUsAfTI9J6Nh/pU52YFZi51Pa8gmhsmiskOfd544vr4pmATd1IcA9NpGM7r220SqSMBOGVj9WVF6VgydTIFWN6x0N4KqGYeVCdVnHvUYeam9dUrofvWJwdf7CzKb6temUWA6RI8EeaNzCzuyVx/WLsei6OkcZLNQrkLbw/ScAOKF7ydM/hLCTD+DGp8VcPLBcVWFPeWyAg8lbrNdZz9Muhe/YwaxW8LeRm+LLlAxRb5O83+Pj0t30gzsEUkPkxq5FuKAvBu2RIbk0PwbloZOM/4ffyuuGlS7sCyoa0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AUChyL1YDsfAL9qtR4tOnBwVF+/pbaF+GWIekH6RJM=;
 b=GCvGoy0NPDA+SjmW1sK1wH9U0iyfRDxdCsz65TrITA18pxp0F5WISFo/2NQmFTGHGMsb0cRgttEFTmeAFkZ5qd/fwiX2wy2iSZyQ7i8PkV8uf1kzATPzpGqZfvEYlyKoTn4II8MAHsa+FtKyEDJBjt6+NNYQqWg6oWPP/xe6pp60BeUM6rIC2o9abvtfyDUjPBuUboMUqB5+wt2b0G89H2R1eBQlsd8pKzMLPrpKp0skMySB2lkch/bJJEz9AS243ljsLj/nBG/hL9hnpHI+tQOeUouBEINVZSSXFon3mGxliYlDXwZMkCGDpikhKpYkmNONsdAxe2QNisvT/WwSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AUChyL1YDsfAL9qtR4tOnBwVF+/pbaF+GWIekH6RJM=;
 b=zdOkLw4VLt3qCtxMPiqy9noCKf/1OxjwZg543uw+PjzUR8wiY25LRt1yhoCXIsrrHjgGlM2LYmCfW0SJSCPxSqkmnvIisrJfoUtcVYt+Q7EnpYaTHXsZfL3SIjqFooKLC8sPX+lqErZkrxImX4fRqdPoxXmo2eKptYNzahhJMDc=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4785.namprd10.prod.outlook.com (2603:10b6:303:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 18:48:54 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 18:48:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 4/4] radix tree test suite: Add support for slab bulk APIs
Thread-Topic: [PATCH 4/4] radix tree test suite: Add support for slab bulk
 APIs
Thread-Index: AQHXR190ZG3e9pzf7UmqWG6nJYdkiQ==
Date:   Wed, 12 May 2021 18:48:53 +0000
Message-ID: <20210512184850.3526677-4-Liam.Howlett@Oracle.com>
References: <20210512184850.3526677-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210512184850.3526677-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32010078-cca6-4692-2a22-08d915769786
x-ms-traffictypediagnostic: CO1PR10MB4785:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4785A4E13141DFC41A814A8AFD529@CO1PR10MB4785.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9OR69fU+j5VyVmBKyCF1kJ76uaLzjZE3zhLW7UTpuceEmmcX12J6hlN92if6JREENCIKSHRJl7d6BRQfF4WcDiTxWVrbT9YNd/NBPxodTH77B/aBWy75ZVqpModxohzJqIKJExEXvULn95K+O/n8t3YY+PEQT4oYYJyOs9NyF8St7uhwEaSxPLdCcbrg3jKkHuURl7Is+wwcAdgGm389zyTPCkyVsUl+8RwvO6dWe0fvnsqzPfTnzcjgS1q3Huw2eGfjgtO1/P5FTe8FXRt4nKMZ+N69Mg24rZmnlj4DZhlYJFg4Jz3ProF99bqD5Npij7NVdzBi/YWTlQ6AgNcgt08FlLc6oFslPbmIEQ9VKAoD4MeQus5EOomeMtjD67m15WVQIY+srZh9FDT2IBnmtB0TcBJPLmLDrpwCAbuhhTZGhrVvugCwt/oSr8O0S3GfL66H96r7jLzbThd29YsXBd/hFX4T5nlYPJYGcBJwo7qcHjIj3fBjYX6Wt6uDi1+vb0JBy7UG+am6TP3Q3ZQOVihylNFZE1Tvh/lpfs7HW4sNPBQ1NSt6q1mqnVRTolblJFSeM7t0yzoadjcWLvs66b8tjtOmCH5hQ6UqeW7MFkk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(36756003)(107886003)(122000001)(4326008)(38100700002)(186003)(86362001)(83380400001)(71200400001)(8676002)(5660300002)(44832011)(110136005)(2616005)(1076003)(8936002)(6486002)(2906002)(6512007)(66476007)(76116006)(66946007)(66556008)(91956017)(64756008)(26005)(478600001)(316002)(66446008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Ez4JB+99URFVzuohlJX0TJ2DZUsVCuX6ZBdiEdeJZS8GiWciccz2h90/fu?=
 =?iso-8859-1?Q?3HwLG/QxqS61DgrMPC0Pt06nUiwzQFVkUFXRu3gRvyCfxiEJS2TQp6sDZ+?=
 =?iso-8859-1?Q?JMDjcUNVuhNyAPHncD0DnNrdnXoVjh/u2G2grvjAf2NDjd9vt2OaXIJRgf?=
 =?iso-8859-1?Q?8wkp+HtRTAFq8zAodD/K2HHwQ7FhTV+unkfMUrB72yI9ytkKI3Spm2uRjJ?=
 =?iso-8859-1?Q?62B36V5VU7yduQAYUHSjPFk2jbbyLlYdDBpPqW/YLVdu/UCIQL2DPo1/Da?=
 =?iso-8859-1?Q?i8IKDBWGgP/cCWAyPfuFMPpeXKXpMS3E5Ee4VBRUqlbJdq8nKlSmVlfNOa?=
 =?iso-8859-1?Q?tkJCGX/VhjQAd5i/o1rk0Ob+rH8gOXP8CA1IVWg0+ILkhFOtQ3qM1qw5uv?=
 =?iso-8859-1?Q?/mvc7m2IkGcCg3ZI1QCAQVZhENykbOKxyF0tbrRCSWok4Q0TNyAi3yjYje?=
 =?iso-8859-1?Q?j/ZWsMfyDSE+JgFFz2QvaHAacqIZxRIa2UWf5qI+OzmbKmuMkcfnoKkp93?=
 =?iso-8859-1?Q?CvecowBitS6F/KgW6ALdSrpQ2I6BR19sep4ESsnauQmm4CP2UTnG1PcTkL?=
 =?iso-8859-1?Q?LYxbMxW4tU1fyXLLFTJcZfzuqb/FuMEA2DCseMwmolFILKw75UOE3PijzI?=
 =?iso-8859-1?Q?0JufkrjFVZZ8PLxag9yayt6NPE/NE1EM0pWqkAh8oCC1DVak0+eq/OUmnB?=
 =?iso-8859-1?Q?3P3IFW78Wnxe7sEkTvVHsLvPwIii/LGtyd9E7oSjpKlOfPxAlX/pHNfdK6?=
 =?iso-8859-1?Q?EXfE1dPC2OYHbyOe08kXZ8Qu0pRxfcerJ/cRW1jttEuHP5NiugAN1dsDZ6?=
 =?iso-8859-1?Q?6UIkBzaHxZ5qh3Cf+kNjWkmj35AA7u92Bp5lGhcCekCusLbT6++oshTABJ?=
 =?iso-8859-1?Q?mJcDKkcsfghl0oHi2snvTYNvtNyj7w1Q1EUFY9XZ80FOGNVssVaeLN87Un?=
 =?iso-8859-1?Q?36amAAR470rhrQ8zLLuraOEzvGzHxqZ0QsRCIdvtMDlThuZAewkzbPiP/N?=
 =?iso-8859-1?Q?SAhF7PSon5g/G4u/3UDEQN7LkLQUQYOTnpQ10C8funAiBVyiY7D0GroEdd?=
 =?iso-8859-1?Q?By2n9SQ/FQFPADWjIAZekoMWGMhgQhSb4pal2c9eVoeM77wY42juf0zxAL?=
 =?iso-8859-1?Q?rAXSkB6h1lOGnxK8IayTNHKDd7ABybLqJ+1wTA9Hn7csAPvgoKBWfa+ZHD?=
 =?iso-8859-1?Q?edDQEEwg0GxFIXM3dx15HAXuuykrIcqsf/OwpGGUYArVMrVwQtPY1Yd753?=
 =?iso-8859-1?Q?KORdaRiZzX1hIZ337ZjU+BTSOJdTtr2IJ3f09wpzAw1VV1vvyV7CItT/Ee?=
 =?iso-8859-1?Q?XQc1hpyjk8TJBaNF364avGav12FSW9WD3g+pzm5Gjkq2POfDDLTUFApv3R?=
 =?iso-8859-1?Q?GpYeoXbnVC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32010078-cca6-4692-2a22-08d915769786
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 18:48:53.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mg4HXCK+QZmZzbLw7gJhewZJI5fjVADqO8vbrcqxmAQhYFw2aHNG4xMRqiEUQQjbvYiU60XKwfy/3m6Zmdc1Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120121
X-Proofpoint-GUID: yLv5BSgi0Qd9xVdXizG7k0Z5PRMK4mpv
X-Proofpoint-ORIG-GUID: yLv5BSgi0Qd9xVdXizG7k0Z5PRMK4mpv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120121
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for kmem_cache_free_bulk() and kmem_cache_alloc_bulk() to
the radix tree test suite.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c      | 61 +++++++++++++++++++++++++++
 tools/testing/radix-tree/linux/slab.h |  3 ++
 2 files changed, 64 insertions(+)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 7225b5c46bb6..726407f934d3 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -93,6 +93,67 @@ void kmem_cache_free(struct kmem_cache *cachep, void *ob=
jp)
 	pthread_mutex_unlock(&cachep->lock);
 }
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist)
+{
+	if (kmalloc_verbose)
+		printk("Bulk free %p[0-%lu]\n", list, size - 1);
+
+	for (int i =3D 0; i < size; i++)
+		kmem_cache_free(cachep, list[i]);
+}
+
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **p)
+{
+	size_t i;
+
+	if (kmalloc_verbose)
+		printk("Bulk alloc %lu\n", size);
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
+		struct radix_tree_node *node =3D cachep->objs;
+
+		for (i =3D 0; i < size; i++) {
+			cachep->nr_objs--;
+			cachep->objs =3D node->parent;
+			p[i] =3D cachep->objs;
+		}
+		pthread_mutex_unlock(&cachep->lock);
+		node->parent =3D NULL;
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
+		uatomic_inc(&nr_tallocated);
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
diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radix-tr=
ee/linux/slab.h
index 2958830ce4d7..de3befdf14df 100644
--- a/tools/testing/radix-tree/linux/slab.h
+++ b/tools/testing/radix-tree/linux/slab.h
@@ -24,4 +24,7 @@ struct kmem_cache *kmem_cache_create(const char *name, un=
signed int size,
 			unsigned int align, unsigned int flags,
 			void (*ctor)(void *));
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t, void **);
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t, size_t, void *=
*);
+
 #endif		/* SLAB_H */
--=20
2.30.2
