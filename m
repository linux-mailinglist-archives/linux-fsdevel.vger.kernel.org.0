Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B4A40BC40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 01:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhINXdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 19:33:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4870 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235936AbhINXds (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:33:48 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxRSQ007088;
        Tue, 14 Sep 2021 23:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ef8VNcjuuHkPdEjGsMtD0mPM1amHH71F+wRAjtDzeiw=;
 b=F3SnazJKzw1j7eIDZlRuzIjddkfPDizMzLy0muCmqdxtm55jmSH3jYzNOtvl8XrM5N3l
 7qXbW4q+qBEqn/D6NP5isOprXiTgk7Gy9ThDtaP6lyP2U+9TPH41+x6ILNztQYWRJ8l5
 EldgDjXJT/iGNRoKguE+9K2LY2cYkV4uPtvs+Or1BzYYsHm/MWwBkqo7oWMf2mnOjWfA
 SuNFmiM1tSIeYQDpZeJtHBYDPu/1aixOtLT4HftC8GWLKc7Cy7EVDO3lPUCta9R1TB6W
 kxjs7rMTjRT5h1X02QcGsVOch7+nxMfcvIbIcD6TZYsIJJOg3TSJaTA9CEJipx86UJw8 9g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ef8VNcjuuHkPdEjGsMtD0mPM1amHH71F+wRAjtDzeiw=;
 b=sFRvGiTZhFlVsBENRGI5G+scIF+jJZgINCp5iodUjkkS8GpEGzBB9VM08kBJeSfijs0Y
 8cYkADD+MPQentAdrYHYEzSBipbGRvbWmjqNj7EeaIjN4CjJQz6gZxIPTjestzNVJCPw
 q+B8oSuMdeSXGT+k9vxs8pmI8pjcDp0xz/a6ZitiBhvNvXlDqNc8s58frObgetSTUClA
 44at+ey0hUCK5kF42Q3qgGT9SCvVnh4cwFFh8vyYRTyMvFmvnivKVuH/dHd+j8ZZD6fC
 xeMmCVMqqgmtdSG4Ch6VbmdFtxaSB4CuuDboUZkuEKwQklOYSFzpota671QEIFUREt9O Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p4f35n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 23:32:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ENUhTd075989;
        Tue, 14 Sep 2021 23:32:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3020.oracle.com with ESMTP id 3b0m970nx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 23:32:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKpLDGSlMA1G+8EUtBaQktGUlZNHmQgnxEVeH0/M4gcTvhcLE0Quwd5lRd1c6zkYZe9cwqSynL4PUxWadmQUaJcEgsVTiTli9mr41Reo7WnUWqxJLVQn4azTwZmnBGUMe2BfUi78tqoGyBmXvC3lp7QO2661OfdfZDT3XWFjDgnAUSFwpMgzDdMB8pMf3lzEIlYlHNq+UjDda2SCy5GMpe02krcnIk7YJwlAFfT4AZYinfUFDnSviQ3J61oa7n38wrssV76R7wPdlgmi04xjg+prd4FTWTB0TgyJrEMSMpXV4YV7mBjmHouEObpRHt6VNjaZ87pE5ylsKavvPKZjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ef8VNcjuuHkPdEjGsMtD0mPM1amHH71F+wRAjtDzeiw=;
 b=V/6l3KA+cat+ZMtIzC05benj3MZj5duCTXDGHFj6Zxk7WR4mwbXK8PKAiDqrsH1ncwXbRMqWgbFmQIsoz3WY6vcRjJHIHD0dJ9JZg3hVwgGicS4tLCCXVS5gSccl0sFrGl2cR0W1K+o8qYFSK88wVEZ0xT/8BxBj4YSDmVO+cUL4yjU/dUWwsaBYWMgHOutEnHN17v3ncewJTjxeoRLMcTbFqroEwONn87l9x3oCsGyl5ZI60Bge9Z5PbpQHiYUSlcPzeHUcWfIynOYnrb+wE8rDwbsKVdVfcNFkc+t/60waLGOr4sqsHqTAuIaNb/kQ+0JzktebLimtrFc1b/r61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef8VNcjuuHkPdEjGsMtD0mPM1amHH71F+wRAjtDzeiw=;
 b=Ty9qV6sZ1Kaqetdodx1hU/LfBTKaDzZ0rqf7GQe50CtyIBhI3zJR0DKIH7UfcWSC6hcyNlqx3GdWvzRUT9y1j63u7XaElTcMHVgYaBIrzpkdtKjGwd16xb5Z/31WoFgQ91Vz3AMjIUA7xfxemXcKHYOLQWrPsKyr7zoRiYllyVM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4035.namprd10.prod.outlook.com (2603:10b6:a03:1f8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 23:32:08 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 23:32:08 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, jack@suse.cz, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] dax: introduce dax_clear_poison to dax pwrite operation
Date:   Tue, 14 Sep 2021 17:31:30 -0600
Message-Id: <20210914233132.3680546-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914233132.3680546-1-jane.chu@oracle.com>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0601CA0008.namprd06.prod.outlook.com
 (2603:10b6:803:2f::18) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1b) by SN4PR0601CA0008.namprd06.prod.outlook.com (2603:10b6:803:2f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Tue, 14 Sep 2021 23:32:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34ee914a-a68d-4e83-bff7-08d977d7de19
X-MS-TrafficTypeDiagnostic: BY5PR10MB4035:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4035C5D9F13DEE42827C2DE7F3DA9@BY5PR10MB4035.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRBZw7usx2GxwuqoLhCYREsBtn+KpdeWYDhRhSOHMQi94N6tc/l3MJUOgOhLlyAE7PEC1k92yNAr5u3Pk96JzE1KrK/+4aaHwhk0+e/zUhZHr++wwWFXUP47ciTFYYEBe7PuAoUQNRqBSHKcHNkeTa9tyRsbhmEj1fxX+IzNEXYgQbGPY3q8lXTE3ybo3X4aJnhyIXA8q9k1B6rYbB1VfDxQUMPP4f7odDPs31gOsfTbpKvU54eCoLxF9WwOcDHtJRAPJUpzQdyQKEBc3sFMBnaCLcxZiNnkVn9r6EhbUTYBT+p5ht05qOLknAVWIAY7g7aNluNkYmYe4P3L1zEr5DqLaf9atuuQfwXXC1FjPCW2cjAUi1UhQ0KD4dDSFGix9X02+dhiyh+LuD2ka638h/y78XbQ53dRlo+DspuElPJqv5xQwNdnvCu+UbK3LnZSyTF+LtgFp9XVT7zcQx07WltLmvqGse45Fhh/xKscikiq2GxR7lOrkwIkpekB8r6C1RaEAPikbZVOu0pjQDjo7dpzVkt7DuVKDVbEP+fYTIyQfVcwpYyMkecJgSTt30USoVECY6aDzHjVah5aCzOIeMXsGdteJk0DGUey4td/3cn1ozsopLJLSKMl/iyF/lvmrm0gnRXSUKGgaXjC66RSUGguLugzZX3xNAILa8YE5CY8AXAnHDB03Xy+UBBDguyO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(39850400004)(346002)(66946007)(66476007)(921005)(1076003)(7416002)(66556008)(52116002)(7696005)(36756003)(316002)(5660300002)(186003)(8676002)(38100700002)(8936002)(2906002)(83380400001)(2616005)(6666004)(44832011)(478600001)(4744005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N7IpFqMK1LcRUB4pVsHPLcwWk1YHd/pXpPJUnMONqiD1HN/WuDqhUe5xvV90?=
 =?us-ascii?Q?9VuJKEd5Y+Bk2lby2zK3kmha48PDrxAkey8W9EeyNz3c2obNGmz1bf9oNnm1?=
 =?us-ascii?Q?2f+OmX2NMddUBugblIpeKl0P9zbOUhIkewZxfjPjXjS8hOvCso6NQrsI2rbm?=
 =?us-ascii?Q?93YaxNV8F4slXqZeveFsBczSYquqHkKHOZQAhsbIPU5a7HBlwlN2mfSbZCVM?=
 =?us-ascii?Q?EtWk/q4TOv0V9mwck5y/b8g4xzGxbub4KKOwlYy9xM+FzLLjEtV8pkwiDI2d?=
 =?us-ascii?Q?gVZC1IAZLTof7qtKwm8l5fcsRn4oTeHQbnPnvaJxNMk4tAf3We7O5TVNufyP?=
 =?us-ascii?Q?slT/jC5lRDuuZ2D9+knHk/JzmzB1slWDn5POXCtkrJHlJV3H1aVxIXjGTCbe?=
 =?us-ascii?Q?jJtQOtl+c9cnP2vM9N4w+HOeHiScEw7zm0sITxDe11Hg5m5YOynS0QZcVb66?=
 =?us-ascii?Q?raY7djwnw31a/XvHdxJkM9LuuqXhotJCSek9/SxKcH7UjRdPyBjkULl8O3Hf?=
 =?us-ascii?Q?Xf02Dwo05STvuBLH4bZc2KLO+/85uZjmIharys3s7X2mZmZx3xbkPdU7UJA/?=
 =?us-ascii?Q?+yVi4ivTKDiMtzfmqKSV/EGX88eKxKxUBelYXWGzqpPYmZ9u4TrJl01N3q7j?=
 =?us-ascii?Q?PYO5kxbq38rNx5GgP8XBoiOs81/hCPzJPF5rm1bzPRPndpLw0MUQKofKRARU?=
 =?us-ascii?Q?YLVLRTLG6eR+pFej9mzvksPOxhbmpDoMH+c3eNBMzE5p631DKolOwE0JSIhO?=
 =?us-ascii?Q?+SrYDId076jcRUsmdii1v/Ht6fq6isHwKz3T+EnXvTKCwtC9qtoJXseoTwWH?=
 =?us-ascii?Q?O6UuOaQVugEJVnlehb7zaVlM+pPpfTUGazJ6BNzGHqOV0UKl/atoB0QFZmab?=
 =?us-ascii?Q?BLAql1FWsJXwvYeHy9PJVHLSFq/oMcl9VvIwCnfGD2VR7ZKJautroHXXK8KB?=
 =?us-ascii?Q?53tsRnBCyhjz4Ku7JBwYK3AmRWOsPj2Q7kVEL9x2XBRTkafmB3ofUqEEoXyg?=
 =?us-ascii?Q?kkoZwAOfXOPJ2BvKEfS9HsX6nhw378C8FbNx41zNP2Fm35D9MYtsH2u7h3L9?=
 =?us-ascii?Q?sHMX8OPhR5jBbyC1IcPYsBVhUiXjHxAuX5ScKOuaqX8/ETC0/WPsXpJ0Q7KO?=
 =?us-ascii?Q?xJhke361HgqbP99OVr9ZaBO9E2iZ7zsW0uEpTvYpm7+JKLKU3rVJhaPSYyJ6?=
 =?us-ascii?Q?TYjYyIkwgxcdeSar5zB1NcH/MpGK83eHs/lcxV48JIbMAvE5vV/hPHtv1gtW?=
 =?us-ascii?Q?ukxG69f3RVQnsw+s6/OddKJVDOqsweU0jQu629CIlj+dOohu6bmYUnLzpVUe?=
 =?us-ascii?Q?/T9SLhvu+LVx+O+uXtw/E4b/jtmyB3RroNxQQFW6H0TdGQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ee914a-a68d-4e83-bff7-08d977d7de19
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 23:32:08.0058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nltmx86RU73nP7OI0mEGwrFuJXYnsDvcTScZGpFUUM70eniuBtKuD5/t5xRbDwyMrRGypo5mAVDnZ3RHh4gGnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4035
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140134
X-Proofpoint-GUID: eXUWVwmkK2dUOeOy2JFgj-XUKAwFEbPB
X-Proofpoint-ORIG-GUID: eXUWVwmkK2dUOeOy2JFgj-XUKAwFEbPB
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When pwrite(2) encounters poison in a dax range, it fails with EIO.
But if the backend hardware of the dax device is capable of clearing
poison, try that and resume the write.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 fs/dax.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index 99b4e78d888f..592a156abbf2 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1156,8 +1156,17 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		if (ret)
 			break;
 
+		/*
+		 * If WRITE operation encounters media error in a page aligned
+		 * range, try to clear the error, then resume, for just once.
+		 */
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
 				&kaddr, NULL);
+		if ((map_len == -EIO) && (iov_iter_rw(iter) == WRITE)) {
+			if (dax_clear_poison(dax_dev, pgoff, PHYS_PFN(size)) == 0)
+				map_len = dax_direct_access(dax_dev, pgoff,
+						PHYS_PFN(size), &kaddr, NULL);
+		}
 		if (map_len < 0) {
 			ret = map_len;
 			break;
-- 
2.18.4

