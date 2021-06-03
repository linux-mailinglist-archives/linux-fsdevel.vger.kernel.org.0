Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7701F39AA6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 20:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFCSt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 14:49:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46416 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhFCSt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:49:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153IdbTM033331;
        Thu, 3 Jun 2021 18:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=X8XbXZJ4murl1vocsC1ZI1YHinrhLAA/wIod5WYs9gY=;
 b=Vfu8JAQN3b6kyIlnSSLp8H53NbFFfmJWlFeR/i+q7+2LrBRta3Oi+WUL9SBtLtqNJPK4
 y55m0Fnjb8qpvb9t8JRebjFhX9K8xvoj9p9XgYaJ2XrS1jpGSmxqnmtta0ZCUTqHOatB
 L3j9SyITtCpy1W6hkpgh8cElGUvuaQrZNnLOdMn/IXGkkJsvQiKDNTprwO0oq/Tarht6
 Yo6ehlKqoib3zcNj9ztqVgSyGYnkgqlTGjtsPjxFRH3olDxBLKj+J4tESoGVBpmLqsl0
 nNNJ0ZmbBJo89aFX+PJ/nY2uANTt8yXwaXj16v8NGCwq/yal0yEJaKvdioFhj3y4GscZ rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38udjmv5up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 18:47:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153IemGe195728;
        Thu, 3 Jun 2021 18:47:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 38x1be5g01-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 18:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF41KZ61sVqYv8WhBImraUZxwhUs2oOWmzuojuSpyUkJu6eJw5HRlBL3mRYJWmnoYSqqbvRTT/amiaIkI5TDlR42pzHalHOxBOH8j1lq7TRG3u/wC4S87YnqNpxQPD0bw1NpXN2GtkxzOAyovLjl7km5Q/pONQmBG+JKimM431i8f7ZkZHbf9GiL9SVYieV4E8T7SK1xB/Podo7swcepiaGDSJP5/xUzI3aoDfucRJjfrQj3e2ojLV3I0GjgHy7iqg8bCN0amwSe5SmqBDDpkFVRtrhU3OAFAC7ay+EQwmmkFKPN9pkDsOrxD8VN+CjY/W8JABs679oI8ev2RVcWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8XbXZJ4murl1vocsC1ZI1YHinrhLAA/wIod5WYs9gY=;
 b=E2/t5ZvOu6TtVNjutob3bPOxheptvVY2JEXhSx03borEWTu5URHdwFqAJhjwAu+WaB6AN8RmVNf12gabuCmPjSmZv/nYvGRAyieT8c3f47/JRG/wTAgPFRrwiaFxwgm6szZNvT1vyQFDX3hJStkyAsDAREJDQKAMarTTOzb4n0RcpQgFbxJFsXcQlmhGPWuynDZ8IiAP7icQ2uNJxuasvOEwRR3MOAuFeNzQoWDz9vIE0s+e709BLe+1BMm48pQNbp4Rhhpi2O3q32PlGeV54bJtVbUNTVDLJ/BWGNhSpfct5gcPhkHizD3h9DKFimSHrc+MJIOh36fGQWqzGdK6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8XbXZJ4murl1vocsC1ZI1YHinrhLAA/wIod5WYs9gY=;
 b=R1Q1HZefExsrtQzRLxASjJSiSB7PSIbcKNiTNXUTJpvTbC6ysXE4iV3aFdCp2y1oDUsxgQXVaAxXG5f9S8jpStxcOnuXsMK7fAGUpQBmsInbZCjkMdPPMd6K4/pOdBhB8xCQPC3MWHsjl9rma0D2OFWykkyVHZwNe0qZH/6Mi30=
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
Subject: [PATCH v2 3/4] radix tree test suite: Add allocation counts and size
 to kmem_cache
Thread-Topic: [PATCH v2 3/4] radix tree test suite: Add allocation counts and
 size to kmem_cache
Thread-Index: AQHXWKjxsXg3LGgTikyOIwccnKdRBA==
Date:   Thu, 3 Jun 2021 18:47:46 +0000
Message-ID: <20210603184729.3893455-4-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 8d818e22-97e2-448d-6f03-08d926c0143c
x-ms-traffictypediagnostic: DM6PR10MB3340:
x-microsoft-antispam-prvs: <DM6PR10MB3340CCBEB1D5635C07D31DC9FD3C9@DM6PR10MB3340.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hEILgT7plywDY5JiTwKbKoxt3tvDUXeSsLeQmX1wafUcfiCm92t1XHZiq+XK/4QqGx3VDihkDC3EVdaFZElOxfZtgpa+qzerzm1jLlDgcKS9tyeySVZ59PJZW2tIPoIT5g/3qNJw1ylgwfuFuxa7p+UXpNRwyr4D99SxYFARzjRQMJlYhv+1jGA7gAhMPFrV1btrIM62bZe1diScCRqH14X7t94hqnRFrhCzfJGnQU6dW2nmtDYVupLI2p0HI3yHrCMEfblL6kD5zC0VEHnC+vFaWacEuZsm27JLsuF0koOgNRKvQynIVhc1ge0wowwN9lKwy9nfeeamhabNcw8ie1KLGhpcYRjFBK0PcqQrSTW0vP2h8Yx+bPSftI9pdWs8MH7pInsUG29284M78BFL00YWbgTIpS+BzY1X2H5Ew6QK+DfmHMfLkUIDBShlnB3623yd4Y6pRs4qAZ1EA1ZuNe6CwUDug1GnUPuhHcIFAqYabXdANukiioqaeU/xOi/qTuVf2dNitedVeU+5mIrDaUp7dfrX2mF1p8FkbVm7TcORajOlVtFy+wxNeUI6wo8RtB0sI4kEOgeWCFG4O7bgDcO8c+vUnbenYh7C5o2ediE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(39860400002)(136003)(478600001)(71200400001)(66476007)(122000001)(66446008)(64756008)(66556008)(91956017)(66946007)(83380400001)(76116006)(38100700002)(44832011)(4326008)(1076003)(2616005)(8936002)(26005)(6512007)(6486002)(8676002)(5660300002)(186003)(6506007)(110136005)(316002)(36756003)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?K+16n1hXxM9cmQ0MPpDw4ilz+8DPxxewr3tdjU4JC91b1EYCBOpdEVC7zT?=
 =?iso-8859-1?Q?j7no5EDHcgo0njs35V8+gSZvPlzJo6LX3N5iwmQ/6EX/iiD5BKQYDlnNlI?=
 =?iso-8859-1?Q?DXF0aszQYHgF5kbLphH5wwjh4DaBbsMNoCG1+PKyUn+ECV44H7vlYOG52m?=
 =?iso-8859-1?Q?sSbI5x5R7d3x55m6M787VGEW9I5cBoCetA1c3wJxJ1gTmKR+vLgING+8Lw?=
 =?iso-8859-1?Q?4/gzoX3/r2u0vlFwIdBGTVdTVR3OABmE0LdxLrL16zxS3KDAj4ltj++LRW?=
 =?iso-8859-1?Q?l8F/wTgIy+Co6FPCCgoMJBrYzmejhR7lFxaVBvEQ6NaVzIVSeEhnVLhB2U?=
 =?iso-8859-1?Q?WjN4o1RmSo0AS3rQrZxtBjnaiX2m8V3LF4E5Hk1VTYc3h0W3JyUKxuhwF3?=
 =?iso-8859-1?Q?lyc4bwASRqeqchbMYUW8U+yyil3gDeGaBDu8c9zQzIrjdyv35g7UM0VqW3?=
 =?iso-8859-1?Q?Usnmg0fyQavvF/kcZDX/xlRZX6MOscmNmpk2O1l86bepMz0++ptiPH2kEj?=
 =?iso-8859-1?Q?n7NeFdi4oLvip+k0gwULbiCXwDSw16pcHbfqoq0kzjwTJT4iX29Sld9ddu?=
 =?iso-8859-1?Q?CSdWKBIc0Ol4RKCQAw1fiIc+tmdhnmV+k1h1ez1LPgi6VgCndpadno9Cn7?=
 =?iso-8859-1?Q?GocyjC7OJOlSBC+A+BWnkBorhN9fZv85A2vQGtMKq9ftvwyx4Trt7s/T/z?=
 =?iso-8859-1?Q?3AmifWT4U8zc4bxLVp36ZXO1IluTBcoAfrivu234k4BbS+pED70CMasvdz?=
 =?iso-8859-1?Q?kkzlfya/gTvHxiZmZ/e/Rq1RhzVsQi5ZLgV3GqHxis+MZxGd7xgw48KUTU?=
 =?iso-8859-1?Q?TAQZmbMr9bOrK3vygVP2xqx8hvMPVxPmV9vgvbUnNx/rOPP0rVkmIeHTZK?=
 =?iso-8859-1?Q?BqdII2ENiW9VsjXZXLmlgGhcQo/qC5gzLCRoKsCPelUOYZr2TcKSc6dY9I?=
 =?iso-8859-1?Q?137TO7XpYLPSaEAXQL8ludRCjw4LkwWt4j5/tYRGB4hoqhEljybFogZcEa?=
 =?iso-8859-1?Q?YpP/vXtIuZtt6+q3ud1tsq9XzrR0FYrGO4zjyppWdsvYPODXrXNbNNBkKr?=
 =?iso-8859-1?Q?4L6dCHrCF/RiMBMN57n55blN1DR286+awTg+Q1hMZT9UYbhGS/hFd2T7Vo?=
 =?iso-8859-1?Q?rrx5tT9xMRsHY5dLHrEd8B7T/TPvrdVACIhqAASRROTvrYlIz1DeNVANW2?=
 =?iso-8859-1?Q?7mQEaneqXA66NYvCadiNFmGi4ILOSKMiZHunEBNgFTZXNbepURdebe2og8?=
 =?iso-8859-1?Q?lASMjj7d/g6hvz5ZeIJLhaPHJR2GcH1E1epVp9wJwLkYWyEl1YQeJlFqp0?=
 =?iso-8859-1?Q?3Yd1LbsQMUV97mG4pDMe9YykKffjEAQtEzvciriugNY88D+cuhNT/Wwl5H?=
 =?iso-8859-1?Q?xOF5jt3Oa+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d818e22-97e2-448d-6f03-08d926c0143c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 18:47:46.0465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOp3GtpBGQQuL20wHVJRjKYIZpGgIygj3Zp8x2PlqhEWGBO0f2qa1HkU0kg27NjxiZ+IG9GWqTiD0ejkH2xwpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3340
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030126
X-Proofpoint-GUID: 8BnLhru-90_hAalS33qRZNbLZYQfynGQ
X-Proofpoint-ORIG-GUID: 8BnLhru-90_hAalS33qRZNbLZYQfynGQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030126
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add functions to get the number of allocations, and total allocations
from a kmem_cache.  Also add a function to get the allocated size and a
way to zero the total allocations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 00ee01a14652..f95e71d65f00 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -25,6 +25,8 @@ struct kmem_cache {
 	void *objs;
 	void (*ctor)(void *);
 	unsigned int non_kernel;
+	unsigned long nr_allocated;
+	unsigned long nr_tallocated;
 };
=20
 void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
@@ -32,6 +34,26 @@ void kmem_cache_set_non_kernel(struct kmem_cache *cachep=
, unsigned int val)
 	cachep->non_kernel =3D val;
 }
=20
+unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
+{
+	return cachep->size * cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_allocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_tallocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_tallocated;
+}
+
+void kmem_cache_zero_nr_tallocated(struct kmem_cache *cachep)
+{
+	cachep->nr_tallocated =3D 0;
+}
+
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
@@ -63,7 +85,9 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp=
)
 			memset(p, 0, cachep->size);
 	}
=20
+	uatomic_inc(&cachep->nr_allocated);
 	uatomic_inc(&nr_allocated);
+	uatomic_inc(&cachep->nr_tallocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from slab\n", p);
 	return p;
@@ -73,6 +97,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *obj=
p)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
+	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
 	pthread_mutex_lock(&cachep->lock);
@@ -124,6 +149,8 @@ kmem_cache_create(const char *name, unsigned int size, =
unsigned int align,
 	ret->size =3D size;
 	ret->align =3D align;
 	ret->nr_objs =3D 0;
+	ret->nr_allocated =3D 0;
+	ret->nr_tallocated =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
 	ret->non_kernel =3D 0;
--=20
2.30.2
