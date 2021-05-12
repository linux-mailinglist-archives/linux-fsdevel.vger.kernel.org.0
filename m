Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C850F37EBE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376640AbhELTjT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 15:39:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37736 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358835AbhELSul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 14:50:41 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CIjxjF006493;
        Wed, 12 May 2021 18:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Y63T0yUFSSQTzb0SMa1dqSXd+GFHpsKHbP9JoGjZW1U=;
 b=IQFA0nRcSZVqNWv5OEGNJXPWVrv2WqlY5byflZAuk+bULfyjIgVYILfHyE7aea5xbpai
 7Qvuk58Q+Sg+2RaEC/AKANc7B2rDD44iDHYbTp6aqXUJSADnJntiN6cvZv3F1O1pArDl
 C4wYnMcGoCASpZl5fA5WVbAdFNDZ92AxVRyzS1+bpET751k+xb2lNzN8ZYb1BcRcGTYq
 TKW0tfsRabctLSFKSjR1qL3J9zQ+bBTz5Rvogx2/tgsmUCCM0re8tHQLSULrW3hz9yu1
 q5D8pJ6mri81YqEmdOSGy+f4z8K8fzXTtQkRr/gBSTdEAx5YxdqS2B4uGS1cMqYNSD1G wA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38dg5bk44j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 18:48:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CIk5nH085840;
        Wed, 12 May 2021 18:48:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3020.oracle.com with ESMTP id 38fh3yj59b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 18:48:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGduYFIbOViB+NV0XmLfpuke0jIwMEc1eRp1qKOQ8CSwi0RVaqTJhS4X15q2DcSHB+1XodwflqWLgieM+E1eFru0EP3uAmH4kO999H6uRYIYS9IPehy3Xa6wNEG25DQYgJ5vdcXvjHiKsQWcDPun4iMV5d8X3wKqpeNSR0gtmM6LC4/JVwDHpVeGYDuKCP1/SewPY0jR/K97LYor7pZThPV8kQnotqurYM/9BZIx24ZJgzP+w/vxMO5fd6czF8UvHQpqitC/KhOnaBYhgFJ3we9AZSUDwrWhoX80RQ2zlc/yPia+wrIbQ/lZQWNbtIozRwkAWXU5/jC7Rdb7xxtznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y63T0yUFSSQTzb0SMa1dqSXd+GFHpsKHbP9JoGjZW1U=;
 b=l9TVBapusBY2juZA9VibqHPgxJP0+toegpQQI6JHYSoR1r65AW3t1Xiu93ARnWmg9qV7JKgecmks1qSIbGdM6rH0znsQEhEEv2ActXFbnJraMCoGn88qPXHpBFigSuJuoSSbiiP4j7RDmXsf7bD2kZDRfeZ+xHywW2dTsBVDFQYPus1GaSkQtbk1CDzZmLehgWcb8+YrFeY4T7speN9O5WnOqxhnVn9cYPYg4GFGC//OmPtBHWL89+MlKpTJWThVNCAWAI+8OOw97OGSXIC38WUFieVZ61DCS9nHc99e01J0NFUxXUnughITfaGOxwnqxQoCWh+M/8CFL5+ipfB+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y63T0yUFSSQTzb0SMa1dqSXd+GFHpsKHbP9JoGjZW1U=;
 b=LS0ot6AOkdmpSd/YrO9VXlW1Nwvr8EbrojTJP8WAgpndB8l2Iy1X/FBoqBAx/Xxyj6x+tI+F+SGhUry/5OwvXdln/TIzPJqmw5olLRN0p24oCXkU+KUgyW07tF67EcjmagCGHnJzDTLVtCKHZRJNDYM43YLbKL679l6ytsqeGCE=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4785.namprd10.prod.outlook.com (2603:10b6:303:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 18:48:53 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 18:48:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 3/4] radix tree test suite: Add kmem_cache enhancements and
 pr_err
Thread-Topic: [PATCH 3/4] radix tree test suite: Add kmem_cache enhancements
 and pr_err
Thread-Index: AQHXR1901beegMufDU6I/WagSlLBNw==
Date:   Wed, 12 May 2021 18:48:53 +0000
Message-ID: <20210512184850.3526677-3-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 15b8e143-5998-4015-642e-08d91576975a
x-ms-traffictypediagnostic: CO1PR10MB4785:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4785741BCB50F633E5E77ABBFD529@CO1PR10MB4785.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nu+mvqJ/kIDuA5efqLxvsuUjtsT3pNCO4N0r7Rsr+UDY1S+MA6SDtBgighvcOOyLC0lj8i2GJp0SwQVR3rK9ZM4O3iW4PBY7JQCinSl22W17Re864BF0eYMCtro/VwxsimehXzsirYjCITjNXk7u9BIEa9DFxQorLamrfJEshIOshNfadYDC1HW+EUohEqqnDdW0WgcRzCQtXDTqUj7JviwxDLycRfxl2ulv1vL4kSlowNy27WaZNBMs2z7Ys5WGAt4ww8QLad3RW1oeYR2k45VXwIqbXxU6eVeMMRZWlHbPqAWPG6hibwt1+j/MrfJV6+LsUqRr+dU4bL3xf/5KZdwdFt3MXDevUJI0QqOH0R/jJ4Wwr32WOS9/PeBPgxQHMOEBZlCrkGX5ZoXowOT8ZqFdr02BpiZxTv9o3PuIIe3NqrYp+MfZF4TGVmmZsiCLrzLcV2M4tYZzyOf/nQztYpn84QXeQPNhN8krLC0Gim+9BnPbZeSECtspZDH6NuLIPG6cuxz6qP7UXWT/te0KO1t8nFfmRhceeYeWjsIpPFwyl5HkRGntRnH7C0fM/tDacdnxDnHL26slxrmAoARqyRuJmtiQYjmkCBmZzTzrf5k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(36756003)(107886003)(122000001)(4326008)(38100700002)(186003)(86362001)(83380400001)(71200400001)(8676002)(5660300002)(44832011)(110136005)(2616005)(1076003)(8936002)(6486002)(2906002)(6512007)(66476007)(76116006)(66946007)(66556008)(91956017)(64756008)(26005)(478600001)(316002)(66446008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?BxdhnTxDkCf09NCktj0XWu+JXzy5I99+yo8Mjj/Xh/7rmdjnRVf2Vvj347?=
 =?iso-8859-1?Q?OSLGdH9hICjFwljl3WKK57Ma8GJfMYW4jO1mmL6t8FVOSI4m0uQ7mdHaF9?=
 =?iso-8859-1?Q?C3Hmy3Pn455f4h5nsEwebAhUE/496xF2RWf0MJrkXz3FvPqUonaKkvIqbF?=
 =?iso-8859-1?Q?tMZYpVTcHEGE8O+pb3QCkYCIKFOwXMoERmQFXFJ3xjJr+0/dUkmxPSdtPq?=
 =?iso-8859-1?Q?lZQFjp27L+OmLGxIrEwe8DpAGnrfsZ2ezX0V/dzK255F3XGQobi7vfan6+?=
 =?iso-8859-1?Q?ouyS7NFkh01K9pbrl/MBNMAUlMT1dPSGFNLybQmgOAW0ddlbh0V+aYwYLx?=
 =?iso-8859-1?Q?5aQW0Y4Ink8E0bq+Z9FnD9Elo/FqD30cLlR+ybcDs0L164KqUYFYjnhQt/?=
 =?iso-8859-1?Q?9uuU46zL7jOdfaOb0uJtwWdnQ+IS2YFQL4iYvYsd6eHK9qn5JYkRShgvcW?=
 =?iso-8859-1?Q?RzrjrftvLFrmUC03r/uHXESE+5Bc368ElNiXqgr+1P2vCat2oGA17KN0P7?=
 =?iso-8859-1?Q?dhgxyoWI56WLwDEoFkKpcMfmh5zjCS1E4yxuQM7gme4F/QgBtjQOVPYevR?=
 =?iso-8859-1?Q?fVgV4Br+CwfWpsmi26My/ukJDgdubex8exe3ob8uVZZvOeN4fwQM1Ia0k9?=
 =?iso-8859-1?Q?thyWKF1frJttwi/yDiAcH79DizbT/QwZgvPqCaYE7OcCUztIA27y6FHzZ1?=
 =?iso-8859-1?Q?3fPb8cuqX01bfGWm2ee4fLEXTJjq5KBE/1/tlGgwp+D14Br5nD6LFyjGJi?=
 =?iso-8859-1?Q?cLP8FwHdaP85y/zpqDKyNWvVud7olnmeLdUyGkidTNXdHc/jRITGmxERdX?=
 =?iso-8859-1?Q?s624C5+1MCkR6TIXVKchJY8oIXlQpcWqV8GzZJkf30KttkxNZEiZAn5VqM?=
 =?iso-8859-1?Q?/l3Ebkokg0onIG8z1qxCVcfdqTV9L5TUtf73gbOLA4S6SjfA29qdr23wdm?=
 =?iso-8859-1?Q?14jXWK2WKW3ST0TKJEbcrTwC5V/tD8Wl01yLVhcGPvRYM0SSkli9g2VdrI?=
 =?iso-8859-1?Q?hvb7i+9c2H41DbY/v10VFpU6XHGzlDQECEANK90B0IG/4fDSFSgJRbqYQb?=
 =?iso-8859-1?Q?x/ChefbePdAcSjl329pY25b/aXJagPhVnSLtsHbTLkNpgBbirz1P+FLOpi?=
 =?iso-8859-1?Q?B5ASNdu4XV8SPEEU9CZob2/iM/nUNPXqgAh41BbAmOezGh4G4oEg8QWsuU?=
 =?iso-8859-1?Q?ZrMBp1LELlMW0G2ZljMzWuXRSgbF9MgHh3uBph+B8d8gpAs4LWJ81xuSR9?=
 =?iso-8859-1?Q?k7ZNCmGE61jmKwSPUCZf2AQW4eA1lsVi0Phe8ewOhY+AuasRHQIm5H/4V2?=
 =?iso-8859-1?Q?04GwfMzXqt6DfcF9Thw7XIOCBzrNFkw0DW8jkUmG0EKBvYTdp+1h9BtHw4?=
 =?iso-8859-1?Q?8Xj8C+f8Tn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b8e143-5998-4015-642e-08d91576975a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 18:48:53.2516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v9h47eQVThj34u/BLbCHiw8lj4zK/v6f4AnkPLcDZESDWKCNLLfUOdzk9hC0pFhDF+lHLktJCXML+XBv7bUg0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120121
X-Proofpoint-GUID: fG3ZXdV_QpaITavQzP35wrtQcEYGl8ZL
X-Proofpoint-ORIG-GUID: fG3ZXdV_QpaITavQzP35wrtQcEYGl8ZL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120121
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add kmem_cache_set_non_kernel(), a mechanism to allow a certain number
of kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set
in the flags.

Add kmem_cache_get_alloc() to see the size of the allocated kmem_cache.

Add a define of pr_err to printk.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/radix-tree/linux.c        | 20 ++++++++++++++++++--
 tools/testing/radix-tree/linux/kernel.h |  1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 2d9c59df60de..7225b5c46bb6 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,14 +24,29 @@ struct kmem_cache {
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
+unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
+{
+	return cachep->size * nr_allocated;
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
@@ -116,5 +131,6 @@ kmem_cache_create(const char *name, unsigned int size, =
unsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 2c3771fff2c0..e44603a181da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
=20
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.30.2
