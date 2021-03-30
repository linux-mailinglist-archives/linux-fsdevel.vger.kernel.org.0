Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B934F33E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhC3V2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:28:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33014 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhC3V1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPG4H122973;
        Tue, 30 Mar 2021 21:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=zgl5LgrNn6hrsz19f6IfEd781HdZViILBnwp/lvaJNw=;
 b=Ggj4Sl7peRP4HD9C6ln2YwNbEoYvgxtyxvQr+ZoVWfBDRKTIWyBRceMaW3WHQqXsfMZH
 RVsnvJuJF+pPgOAIjw0BvLX8UFBGgrBs0EtNU9obZWJWnYzngCrqc/taeg/0cvtmycgH
 IFQ7DPMzJdoh/2Mnp0YcC9ipJb4HAu14O1XBjCSmaVIDC1QCaE5v3VR6EONSGo+cds72
 L0tF8SE4SytWEF+QVLBzossnhox4T9FXTuH3S5XX+UL5OZtQ1xzNMIlnNARhn4uTozlR
 yxM7ueH4PWiy/gIEEA9dL1iWvBCjDJzE/iS0GWfB3Sg7sdnWl7Wd23WnI3umeIEgloTz TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37mafv083j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOaCC149646;
        Tue, 30 Mar 2021 21:26:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3020.oracle.com with ESMTP id 37mac4kf36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+ZOe3pVxovc8FztkmfUaVyPC4mxy+v4cLnDmIKn5uWaZqJGttXLPV0we/x+BzbAZQmMs3C6fn2z8GEZk8RZKmcZ+GujlYOxOA6fJSOorvarJ+7RHwGN4rpAxoE70Mpqg5ag61XeZ7gNEZyW53slswdRlAuYh1Igt13nphR7hI8Bk+frgpn14pHunvJslbqbBtkf8fvnKnsAXG/Ah+UMuDWOmbGk8PMJlJ1PDgnBzWpC6oeJnOTeVtO6yGsVcS7z3p+jjK869zCkO41iXqTEw5J7YXB0CPSggiyzs6tG7jnKEO3knjAPSFGmw6mjpVuj95sWBXMjfrDrZsZhRjzpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgl5LgrNn6hrsz19f6IfEd781HdZViILBnwp/lvaJNw=;
 b=Hob+qkCdiAUOF5X80u2H9SdJk8+y1gAAbpF3JlwpcRjgG5YApeDS8uZDJ//sx78RsTSQPiXgkyZYEtQPmRqDh26qraowfGmsq16wN4n+I+PoEnTDrAeU6dz2pHy+ycS5JzeSELP6IFasrwf2foOOnn0V6el68IkJIVWXIyos1pAYNPnX/Pd/cEfZQmpai4B/oWzCHQPNxEExbVCzdeMlsa/3eYh7KXS7kYXhqqUEsBGSNSSbj7mm8unMgy8mBmM3KGaEvDjYqpIKRh03l2r+wbA1NS0K0/+dchoIQvfvhUzrmJJM9S548MyDYDStjBkTKPQZvsmWFWSVoo6TdiiB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgl5LgrNn6hrsz19f6IfEd781HdZViILBnwp/lvaJNw=;
 b=xRxXPSNarLAM/OPCDkG9wJkmKnFRkDbNjhkSzMFeM8uMWvoVVlBB4Dql2jK5L30ua12UzwXmbSPRZjkVkcAiIpSD4kScoSe0HbgDMWSB4a3rz2hL3JD5+pMQy5fTgZBX3TNAsvOOW0bcVL6wBKBO1i9FRnoGEdgueXreuRC+R/o=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3600.namprd10.prod.outlook.com (2603:10b6:208:114::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:26:52 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:52 +0000
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
Subject: [RFC v2 26/43] mm: shmem: specify the mm to use when inserting pages
Date:   Tue, 30 Mar 2021 14:36:01 -0700
Message-Id: <1617140178-8773-27-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2c7844c-986f-49ee-eaba-08d8f3c288fb
X-MS-TrafficTypeDiagnostic: MN2PR10MB3600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3600999E01463B931D83F76DEC7D9@MN2PR10MB3600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hlqp344PKo4sYXS2yNszx+14cwSa7oZCuIqq/OMHnNNsyb20B3wgcFcaxdgfw1Khbin2Vux2Vc+vRMcSosQubuIcK7yY7aHRY1uiUDBLaVutvb01h1jsywYJQfCHjxUwFFKp2Wd5sn2DbWRHNDlNOdNlUIMqwwDcxCg70YbdQ+nO0TCaeohb4uaNdbokOJ5C1eapx/qsn2VsyVFlzAiHaKrpaW6LIWDJ93hlI0SGapjbv7WgtacogiDFUFfK0iKtf8dBLAxfqo/TvOXpvMCyVLAlGinpusJUMSqwQXMGtZk8pqQ6qgz84eA/cl7qKvPIf6MQ+c/eKr9rQu+DROTRWxnfMzzcKBYSxjxIUGzKuTBuqpY9ZWt/VGzFuyJyy4GcI87uKeEaKP1M0Ck0eiCXKSxNieH8G8gVo/xRNkEERnLEjxhnq9Qb3HtkIQD347rJr+JK10xXfk6ClIsPW4CmhEyYSaRqcX/p695fsV/h2rbPdSynvCdVrHFdigzRZu40EYKYOWmqfaw7fBp8mOTPMx+5QlY2zLEzeOISKdcUchkpnI9hOFnIkDqUbMFULNF9QZJAT4AECbc5H2ZuVSIU5D6VPKlpvjZpX4nc4f+LD9k3sOH+u6KfIyg2RmYG8u3PNcqGoWgu3Z0T2CeS2MRhEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(6666004)(7696005)(316002)(36756003)(44832011)(8936002)(2616005)(956004)(5660300002)(16526019)(186003)(4326008)(6486002)(86362001)(38100700001)(83380400001)(26005)(66476007)(7406005)(7416002)(66556008)(8676002)(478600001)(52116002)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/DsgAuT1t0NVzHO18b1CdFRZaKX/5yDScZNes80qkNInMVgqsHp2GULpxIC+?=
 =?us-ascii?Q?V6IlrsuPhAYjn5liOqwwF+V1UM7/haPpQHOj7dIn+JVuwMcSvAoYKMyOmX+k?=
 =?us-ascii?Q?GY9K6yq7stzQp+SAYaBdXVBoeeUk/SGnu/KcxbFvS8aoIttuTeE1mlJ9rbdv?=
 =?us-ascii?Q?s4+HBvs5UJx2DssmHDFw89E3F0+uK2M7xJYwaExT8ltVeYSFBKyfIFBAm5j5?=
 =?us-ascii?Q?DcE3t8ECwhy4yfsvt9JYeEHKhL8FQXKdIGYXF06qDmSbD/GUly8dGJeaQuJM?=
 =?us-ascii?Q?KAl4x4g/YSx537ZhT1g4j0Cic0KCprtarz4SL+rgq5Cooz72+NGM+oXIo7a2?=
 =?us-ascii?Q?JONEtIw43PScYqa5iyStGZ2KxwtWrfj4LEMn2+qXas8AUPDdO/1n7r0WSwAX?=
 =?us-ascii?Q?sTiOsTyVRvfTtHchk4rGjGCrbV5/9isevFb21pgZ6kjE+ITZkFmF3Mg7eaFR?=
 =?us-ascii?Q?ZRF6tOuF9TodQLitzUTvA7lN0/LUN1z63d8ezu1SPV6i5ZlqVovwMCDC4iWQ?=
 =?us-ascii?Q?5z8LOkRtdModqVPXLeJKFYWa4jpXlfxidMUFmoHo5gPQiXLHxnuxx2fwvXOS?=
 =?us-ascii?Q?dYmpo8gzJ3O2bzrADdDVZh/RM5t6jvi69miy4KVNYj/0DqD4N9CTvnDomg0v?=
 =?us-ascii?Q?iTUTFOIlyJTJuO8eR9ex4XIyPsj6isRF1LGLXKktwzM+I0UaKLmegAzDqa6Q?=
 =?us-ascii?Q?GzGNSK2NoW60i/s9/U6mrjkNxwqLsaifdoVMbgWMFYhHvCoSZ5XmaVPMmhWt?=
 =?us-ascii?Q?3sU1SXJzWro+IbnGkVuipourKVYd/qvZAcGRdEjF3pWczyJTbJ1H3//oaZUM?=
 =?us-ascii?Q?CavAIEIA/2eJY0opQq69fPlBiqmKZFtjjwuLHN8lCqrhGgSZMly1TMPOGe+W?=
 =?us-ascii?Q?oZap/FbqZJsKulOkvMVoq2wwqUf4weMoxZncBa9lcUK1uvrf2T5bjaF1l1Fv?=
 =?us-ascii?Q?OVw20jrbXfmgUxj6XGXUDTepzmlf0REmtMPImq2xtcRMNwyBRqSmev4bxw1A?=
 =?us-ascii?Q?mhGrEIexXa4kTcU8C3mF7Lka14taP0zU4DJ3b2oHZ9qn5yb6dLw9g6aMx67a?=
 =?us-ascii?Q?+XXpO8wRu0t1UJOoWgbbHAb0AbY0h0am94kdePsgn91Mlr67V9KeECUDAtrE?=
 =?us-ascii?Q?CwhTFwTenDDg8kxSlG91dJTyz284IIupICDIBS/apDzxQlTIoVmo8JHNfnww?=
 =?us-ascii?Q?N4IcWgtXGParfTsItl1o+/Mu6M+jIZM3//c8QZ4yFAeEHb9Ea8EogXO9d+f9?=
 =?us-ascii?Q?Ij5hmuB12xxEW+Dt4GFMQPJxLGkMhWaPubpdxmqX04JN+YHMi3bWBaxzUER2?=
 =?us-ascii?Q?73DcQXxM8x7uf4h8FOfBgKg6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c7844c-986f-49ee-eaba-08d8f3c288fb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:52.2289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8o+aL4pFbZSf4ZWrirThTWt3NB4v9FahqCV38mvXbzGTUv8K7i1zc6dnOq/9lfgFENI/G1S2OMPsZc9z8OoxR+AYvb+TN448PeXP8XKrtmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3600
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: wwqvilEskCM1PZahcPdqtOy2JDn09BbF
X-Proofpoint-GUID: wwqvilEskCM1PZahcPdqtOy2JDn09BbF
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Explicitly specify the mm to pass to shmem_insert_page() when
the pkram_stream is initialized rather than use the mm of the
current thread.  This will allow for multiple kernel threads to
target the same mm when inserting pages in parallel.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem_pkram.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index 904b1b861ce5..8682b0c002c0 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -225,7 +225,7 @@ int shmem_save_pkram(struct super_block *sb)
 	return err;
 }
 
-static int load_file_content(struct pkram_stream *ps, struct address_space *mapping)
+static int load_file_content(struct pkram_stream *ps, struct address_space *mapping, struct mm_struct *mm)
 {
 	PKRAM_ACCESS(pa, ps, pages);
 	unsigned long index;
@@ -237,7 +237,7 @@ static int load_file_content(struct pkram_stream *ps, struct address_space *mapp
 		if (!page)
 			break;
 
-		err = shmem_insert_page(current->mm, mapping->host, index, page);
+		err = shmem_insert_page(mm, mapping->host, index, page);
 		put_page(page);
 		cond_resched();
 	} while (!err);
@@ -291,7 +291,7 @@ static int load_file(struct dentry *parent, struct pkram_stream *ps,
 	inode->i_ctime = ns_to_timespec64(hdr.ctime);
 	i_size_write(inode, hdr.size);
 
-	err = load_file_content(ps, inode->i_mapping);
+	err = load_file_content(ps, inode->i_mapping, current->mm);
 out_unlock:
 	inode_unlock(d_inode(parent));
 out:
-- 
1.8.3.1

