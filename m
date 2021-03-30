Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA03634F381
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhC3VaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:30:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43948 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhC3V2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOjq1011609;
        Tue, 30 Mar 2021 21:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=StS8zsAa0vS/yJW7ncnSFIShqW2WyW3ks/4y0oh9XnE=;
 b=yDaZu6T3voG18G+W3UL6lYZqiDnmZEAVxkp23w+G4nrQD+jqVrHZq+iNyxvV8cb9tqnv
 UWjDKlK0VDX2BrxnyKaMN9mrfqPrP2+xg8FEvsYHonulePoeaUZOK/PFOYuRekGpsFGn
 mcfpIyVDbCV0qts/wiGucXfUMZidRnDeESyegSH46skHxIa+7NN2wrgJi5rgApAsCVBD
 //xAaxOnKWXlhWmhAJHl/b6inUIictd/RpZTu4OBjjRwTr8iOe5QYEt3fVYxpiuJB5AR
 FyHQ7B2na5CoK1U0wMo6WzaYpmjOpDePcPpP/nauBCISIk+YkYJD9liJ26EW5pdGK++z XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37mab3g91g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:28:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOmlg183986;
        Tue, 30 Mar 2021 21:28:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 37mac7u5nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:28:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSRlm3iCB3WuAZvRoMHtpXeUjLve6vGteF6OvM39UuIvd9PNu/KEmMrEhBhGPmyrLXzfF128SZaB2+FGOx4vWaWKsjTpb1f8X4FKbTwZI7QhJCmJWcW+L8fR1hLcB5BQpP7/Z62mvItlsVbcuG4FPRY5Jhz/KQtZdm+hJ5gClNNQyusHftLqf2x1lfE0NLvJpUjfmCZaWilpHJq9l0gPSzGu95Vf0aAf0xDdnviPOKXjEpsOUrOCN50r0MtKM051s3FCFHq8eSm2jTObZYE4y2kRG4tle9cmc4/MUdKZEPDePtoyqNhzf7pp8ZR8YSqfovsp5zH1s4JzSh4k136Fow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StS8zsAa0vS/yJW7ncnSFIShqW2WyW3ks/4y0oh9XnE=;
 b=VpSRymwyb/n6qHei3DxS6OVvKkeSgs12ZbeDGjUYDm104bUsgM5D98sWNwbvyX4Kv6txUDmX1LeY8/3L0N/E1TEzzFZCQlCkw2ykkSmEMKGwI5Ra8DASAqk8uyTbks84YwiSJm0qHS8gxB7cfvr9Vi8jbIUhnCjnouVzYSXjEBwkKNKv4bOAVvQa0YJsjyy3ATDENHLBHRJvBHDHN6MimfVcz33g/IPaYalJE3tq3YFGcnU5cu8i8J0ZUdDPUTHO4fCKc82zm5Y2wNN+Tf4D+EusjWm1yL28fZOMsUj2KhLoSDZ7s0an8uPPrWxibYJXUOieNhjyAr2AV2Kpu/t/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StS8zsAa0vS/yJW7ncnSFIShqW2WyW3ks/4y0oh9XnE=;
 b=jcEQedXq5pZkYWWBQclfxyy4ETw2cOKPYjjopbOffmbIp2SmLBS0TDpL5KCiDQy815W1D2lWsxy2SQxYnQLJ9l/atXWqQQF0uA4g1LTA13FWGQCNi+6/FNTrcIq7VEv3AWYY8Nj1BmyrapH8CvOPnhRLW8fsKMam96nLAcBRjec=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3679.namprd10.prod.outlook.com (2603:10b6:208:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:58 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:58 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org,
        nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org,
        nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com,
        martin.b.radev@gmail.com, andreyknvl@google.com,
        daniel.kiper@oracle.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com,
        guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        david@redhat.com, richard.weiyang@gmail.com,
        vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, daniel.m.jordan@oracle.com,
        steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
Subject: [RFC v2 41/43] XArray: add xas_export_node() and xas_import_node()
Date:   Tue, 30 Mar 2021 14:36:16 -0700
Message-Id: <1617140178-8773-42-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain
X-Originating-IP: [148.87.23.8]
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To MN2PR10MB3533.namprd10.prod.outlook.com
 (2603:10b6:208:118::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 720da738-137f-4934-b7ba-08d8f3c2b078
X-MS-TrafficTypeDiagnostic: MN2PR10MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3679A957F83FADC882881C71EC7D9@MN2PR10MB3679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APIWRvuKH+oXWT697yGj10JyMKQHD4MQmRBUKuO1EaIH+SKzg+r3qIHpXC/ExLd9QWqvYMltD3B5/rumzrg2cSH98bQGpd+rykSIxunFNAD7l9n3zGPAtOVB/CNXuKB9bLAQfa31fcrvpdTKpiLRo3S2NIeIn9diG9K9V4+du1uNeKW9YHdOyF32HM+Yza8rLthNKl4sQWnQjmhK86yK3R8BMhT3ZHs0jZB55jdF4K08VqDdyVl2ZUI4I4LavRc3BnpQacnqrfhvl0b855sL6ao57VsjeQLdS0TQ71o00OrpabgiBQQwvIwmLXKpdxwJHOSVXR7Ub0Ap+ctG9EUJo1GejLBiKzosmhJL9ogvKOzBumCgqB6rQFP9tiC6k9ax03BsrJZHrZakAKV/l//0DIG4aklxXvmIAXXhPCDvlEu9sjan9sFLapbN5G26Bn6ngYmhV9tzEkYtWGBS88QxuvXoQcxrLVEuu5naCLnBfMPdWXQ/8P2YCvCKp2dwNjKDhzZBMGrp/NMpj6RGK2fQ4dp2/DEzbDKJqjfqRhmVsxVc13yaiqEKEFaW5HeCmh+3lxDeNcDhpTUmzxM2NRpbrLoF5TXVLdgW7ES5IrIYvsGJFDQXStVdGXB2pgD2jewpLKyf99fP+lAWc2fl9oDytg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6666004)(4326008)(86362001)(52116002)(186003)(478600001)(36756003)(5660300002)(7416002)(26005)(66946007)(66556008)(7696005)(2616005)(16526019)(8676002)(316002)(2906002)(66476007)(956004)(38100700001)(6486002)(7406005)(8936002)(44832011)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S6jq4r6EP8JZ70qjeRB6agOM2dIojs28TI5Fi+ISRtF/dy62J4fMwj6x2uv+?=
 =?us-ascii?Q?9Uj8AzyKojUVUqkJr6PO5AbvMdPErV/woe/4DkZXPaLrpMjkfc/iIU+6EgkB?=
 =?us-ascii?Q?e+iHBihD1yeu1rxOXqQ26OXCFTZ3/F/7j/i1UbaXplt4KKwnl+4/k2d07Vyl?=
 =?us-ascii?Q?8EemeST7jGKpTtGTmaIMktAK88olS8/bMz21cQ0msxNrZ1ErtW2dt1U4POPy?=
 =?us-ascii?Q?bM57Wq9xqdawlbHTsTAyJsZDyCxRgq/u50Tg7N/B6BcnZVV4TzZqMBdkyOXK?=
 =?us-ascii?Q?/iqpyG56Kh6ObNLXt7EAfymV3KkePX+TLrdn40cMmGNR69plsTUr8Fon7mlx?=
 =?us-ascii?Q?Da0cy30t5Wlsj5jc5YuJjVmlfzajsELq9HvQqKTGTa1vBnl6GyxCwBkt0Xrx?=
 =?us-ascii?Q?RZSJaXwER5RnEKT/PNsNDiNZchjUnukAgvUtf0iDSGBq/IjwPYugckdFxfPj?=
 =?us-ascii?Q?KXZgYNCLyVMy+OZ+t0DZHc49P0c3aTw2fIHXUW31S3QdR2lDwbAOTxT5lz6U?=
 =?us-ascii?Q?ObP5VCHEY/fYWCmEPYUeJQbxOmBa2HI7CVtJozF69Mv3O4meFUt/VoYcXlyu?=
 =?us-ascii?Q?gA+XUaHJNeHRdpry3y/HbF8ZfthS4DMS/VPC3npiBuJ0rtbNCnXxnh53Vsxl?=
 =?us-ascii?Q?2eJhGkRQeEZ4rqF+KGPoRsmArEuBzWceOi4PtqJ4iZXE30tVDETiPqxlHp6l?=
 =?us-ascii?Q?/nTl62u1rwcOnG1Ml3T4ju5b3vNCZH4HcPivV9u3DXKhHQeZq6Zfna4jDNCN?=
 =?us-ascii?Q?pkLFzMDQJDDW2m1YUzTipcAQC6kZmJxafMMXeMYRvweQfxD5g07yRJXhcslN?=
 =?us-ascii?Q?ABl1XlQsNu2caX3tPM+n6h8wYc7UMBpiZic3sEFtm0IenG0HzsqsGrNhlBBy?=
 =?us-ascii?Q?w7w1FjiTSEy14TYL+mBDNEVyEiwo1TWzt+CPOk2eu0K/XL6UZSnuPGxEIZK+?=
 =?us-ascii?Q?rQGiNEcbUt7YoR2FF2qKX7bEgofHe/r0VQHRNtWcP8qtxr0EYXl6vkYfj6Iy?=
 =?us-ascii?Q?gB09oefOT44bg5bKmlM5/PNvRcnwVLqeKRSvWdtqvZsI5LojnoKxdMJ16gxz?=
 =?us-ascii?Q?eh2W1uklgmWMjO+6gl2XqBexthgluau/ZyYp2Ubihmm5Zm5LT/Bv28w9fxCy?=
 =?us-ascii?Q?biMfpBMomc5AVcTYMP/3c/IRyIIfspfNdu4aouVPbUg1q0vYJzpsm1TqKl0r?=
 =?us-ascii?Q?+BlJKqD6xYR7M9NyaO3NC9DPuKLE39iLcNQmmhriwFLe5LAe/dbi6R94ZLLm?=
 =?us-ascii?Q?PC5V8bwJSag8wDX5ECZ8aWvxeUSkMwsGc+p5JqUOJtmsoOhshda53JdmBLVg?=
 =?us-ascii?Q?E+28XE/VtFHKNzPn6RU9/FCd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720da738-137f-4934-b7ba-08d8f3c2b078
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:58.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8KPoOfps9JiFF4NEjORrvVP9mjsbsVQ6Chrj9Kfsmjt81/DCkXb9qy6N0TdbsRYjhltHCOq9x+ilXqccGmIUxBF1Cb33adMHFqyyucSDik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3679
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: 5sId7tjDJ2EdacY3ZifYoHTKYQaaeI4i
X-Proofpoint-GUID: 5sId7tjDJ2EdacY3ZifYoHTKYQaaeI4i
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Contention on the xarray lock when multiple threads are adding to the
same xarray can be mitigated by providing a way to add entries in
bulk.

Allow a caller to allocate and populate an xarray node outside of
the target xarray and then only take the xarray lock long enough to
import the node into it.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 Documentation/core-api/xarray.rst |   8 +++
 include/linux/xarray.h            |   2 +
 lib/test_xarray.c                 |  45 +++++++++++++++++
 lib/xarray.c                      | 100 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 155 insertions(+)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index a137a0e6d068..12ec59038fc8 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -444,6 +444,14 @@ called each time the XArray updates a node.  This is used by the page
 cache workingset code to maintain its list of nodes which contain only
 shadow entries.
 
+xas_export_node() is used to remove and return a node from an XArray
+while xas_import_node() is used to add a node to an XArray.  Together
+these can be used, for example, to reduce lock contention when multiple
+threads are updating an XArray by allowing a caller to allocate and
+populate a node outside of the target XArray in a local XArray, export
+the node, and then take the target XArray lock just long enough to import
+the node.
+
 Multi-Index Entries
 -------------------
 
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 92c0160b3352..1eda38cbe020 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1506,6 +1506,8 @@ static inline bool xas_retry(struct xa_state *xas, const void *entry)
 void xas_pause(struct xa_state *);
 
 void xas_create_range(struct xa_state *);
+struct xa_node *xas_export_node(struct xa_state *xas);
+void xas_import_node(struct xa_state *xas, struct xa_node *node);
 
 #ifdef CONFIG_XARRAY_MULTI
 int xa_get_order(struct xarray *, unsigned long index);
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 8294f43f4981..9cca0921cf9b 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1765,6 +1765,50 @@ static noinline void check_destroy(struct xarray *xa)
 #endif
 }
 
+static noinline void check_export_import_1(struct xarray *xa,
+		unsigned long index, unsigned int order)
+{
+	int xa_shift = order + XA_CHUNK_SHIFT - (order % XA_CHUNK_SHIFT);
+	XA_STATE(xas, xa, index);
+	struct xa_node *node;
+	unsigned long i;
+
+	xa_store_many_order(xa, index, xa_shift);
+
+	xas_lock(&xas);
+	xas_set_order(&xas, index, xa_shift);
+	node = xas_export_node(&xas);
+	xas_unlock(&xas);
+
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	do {
+		xas_lock(&xas);
+		xas_set_order(&xas, index, xa_shift);
+		xas_import_node(&xas, node);
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	for (i = index; i < index + (1UL << xa_shift); i++)
+		xa_erase_index(xa, i);
+
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+
+static noinline void check_export_import(struct xarray *xa)
+{
+	unsigned int order;
+	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 12 : 1;
+
+	for (order = 0; order < max_order; order += XA_CHUNK_SHIFT) {
+		int xa_shift = order + XA_CHUNK_SHIFT;
+		unsigned long j;
+
+		for (j = 0; j < XA_CHUNK_SIZE; j++)
+			check_export_import_1(xa, j << xa_shift, order);
+	}
+}
+
 static DEFINE_XARRAY(array);
 
 static int xarray_checks(void)
@@ -1797,6 +1841,7 @@ static int xarray_checks(void)
 	check_workingset(&array, 0);
 	check_workingset(&array, 64);
 	check_workingset(&array, 4096);
+	check_export_import(&array);
 
 	printk("XArray: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run == tests_passed) ? 0 : -EINVAL;
diff --git a/lib/xarray.c b/lib/xarray.c
index 5fa51614802a..58d58333f0d0 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -510,6 +510,30 @@ static void xas_delete_node(struct xa_state *xas)
 		xas_shrink(xas);
 }
 
+static void xas_unlink_node(struct xa_state *xas)
+{
+	struct xa_node *node = xas->xa_node;
+	struct xa_node *parent;
+
+	parent = xa_parent_locked(xas->xa, node);
+	xas->xa_node = parent;
+	xas->xa_offset = node->offset;
+
+	if (!parent) {
+		xas->xa->xa_head = NULL;
+		xas->xa_node = XAS_BOUNDS;
+		return;
+	}
+
+	parent->slots[xas->xa_offset] = NULL;
+	parent->count--;
+	XA_NODE_BUG_ON(parent, parent->count > XA_CHUNK_SIZE);
+
+	xas_update(xas, parent);
+
+	xas_delete_node(xas);
+}
+
 /**
  * xas_free_nodes() - Free this node and all nodes that it references
  * @xas: Array operation state.
@@ -1690,6 +1714,82 @@ static void xas_set_range(struct xa_state *xas, unsigned long first,
 }
 
 /**
+ * xas_export_node() - remove and return a node from an XArray
+ * @xas: XArray operation state
+ *
+ * The range covered by @xas must be aligned to and cover a single node
+ * at any level of the tree.
+ *
+ * Return: On success, returns the removed node.  If the range is invalid,
+ * returns %NULL and sets -EINVAL in @xas.  Otherwise returns %NULL if the
+ * node does not exist.
+ */
+struct xa_node *xas_export_node(struct xa_state *xas)
+{
+	struct xa_node *node;
+
+	if (!xas->xa_shift || xas->xa_sibs) {
+		xas_set_err(xas, -EINVAL);
+		return NULL;
+	}
+
+	xas->xa_shift -= XA_CHUNK_SHIFT;
+
+	if (!xas_find(xas, xas->xa_index))
+		return NULL;
+	node = xas->xa_node;
+	xas_unlink_node(xas);
+	node->parent = NULL;
+
+	return node;
+}
+
+/**
+ * xas_import_node() - add a node to an XArray
+ * @xas: XArray operation state
+ * @node: The node to add
+ *
+ * The range covered by @xas must be aligned to and cover a single node
+ * at any level of the tree.  No nodes should already exist within the
+ * range.
+ * Sets an error in @xas if the range is invalid or xas_create() fails
+ */
+void xas_import_node(struct xa_state *xas, struct xa_node *node)
+{
+	struct xa_node *parent = NULL;
+	void __rcu **slot = &xas->xa->xa_head;
+	int count = 0;
+
+	if (!xas->xa_shift || xas->xa_sibs) {
+		xas_set_err(xas, -EINVAL);
+		return;
+	}
+
+	if (xas->xa_index || xa_head_locked(xas->xa)) {
+		xas_set_order(xas, xas->xa_index, node->shift + XA_CHUNK_SHIFT);
+		xas_create(xas, true);
+
+		if (xas_invalid(xas))
+			return;
+
+		parent = xas->xa_node;
+	}
+
+	if (parent) {
+		slot = &parent->slots[xas->xa_offset];
+		node->offset = xas->xa_offset;
+		count++;
+	}
+
+	RCU_INIT_POINTER(node->parent, parent);
+	node->array = xas->xa;
+
+	rcu_assign_pointer(*slot, xa_mk_node(node));
+
+	update_node(xas, parent, count, 0);
+}
+
+/**
  * xa_store_range() - Store this entry at a range of indices in the XArray.
  * @xa: XArray.
  * @first: First index to affect.
-- 
1.8.3.1

