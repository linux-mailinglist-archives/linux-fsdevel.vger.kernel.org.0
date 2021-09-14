Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F2640BC34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 01:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhINXdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 19:33:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4030 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231435AbhINXdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:33:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxh3W032058;
        Tue, 14 Sep 2021 23:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=72n7PFMsPXdD0BofaQTPMKat9hrrYyPXpzXND92RkZY=;
 b=ztEIN/iyXb74rBlX8+cyidEgj043NVtk7PYZRVUiF73bnDjMWlRvIF0lfIjM9oazwchQ
 3Q6Vm0ft2ZnbaGKDZ0jqTO8qENoyv1BhvuLtRDQJaQ8miDGUULl9sxs+6e7RjPLsNnzF
 9q/r85zpceKrd5jIEX31NaYpUzvrQCxucMdqvKPygxYs1XINOhhG/Cq7Q7GnINRQwkIQ
 qxL1RVrmU4SUccYFaU3LOIoyq5PC+4blHi7sxr5ek34OBa4A2O8bbAupwWvQ7swCe1Cb
 ZIolMZYknJQZ0nt2zwZCt52i4sBi8KEdbHoPhNMNbMBpd0fmHAZvRhw8yYUIk+0e2HkE Ow== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=72n7PFMsPXdD0BofaQTPMKat9hrrYyPXpzXND92RkZY=;
 b=ZJFWcVxRz206IexIa0Wzzh2zp9yyO+IbzhGnIlVllrq+mI9UtWff1ZS//NPNg8w3ascf
 sJUJZ7oqU05CNWx+icdYzNTUaFmhU1i1APNfk+Egng5R0X33bjfylF8bJBdWvtu1VReb
 a2S0O3vUuMVlT3N/i2b+PMQxAa7WURYnrkoAi5vqNnmJZz/K77PgqN8sTPUv9ER3FMJn
 t4yV5OQyZ7yVDAmDtR+P0vApxUgpt73+Z81oOm+yeBhSDYnW38x606cuaH4x8vWaTDWD
 xg3yxs/39/tPvOI5GoYcZ9xUO2hmvO/Nd4soULPABEsELzvvh8DcNc264zX0z2lsjg6E pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p3mk8am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 23:32:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ENTj3c169901;
        Tue, 14 Sep 2021 23:32:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3020.oracle.com with ESMTP id 3b167ssv58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 23:32:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPZnHnKsV7wmBk7RT1fVoWSiB+T8TQQxjufvQnQlrAm4pWlLkvamaNPLkeV5e/Ev1dZ+HAzXd+5XezaryBviHZ8C2D3mE4g2K8AnoN11hm+OSXISswFqttkYr+O0zY/taNLVUPqvjzFJgmpbJgLkrQ7fYyDZC5UWS1DXrn7xF3vIy0FNyFEx9eO9b+Bt2WHm/z+bXvsGaTcAaWtbrTQJbh2JfAToJB+5gBDzPFXCcACQ2lHiJCrpgELTOSkuR8qvK8ouAUb13eHcLvwCWFJs35ceerHFnD0yZHkSGobZEtMHes+4shkKQwJnu7NE49h1TYmJlI5dqNBQHusqzVmqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=72n7PFMsPXdD0BofaQTPMKat9hrrYyPXpzXND92RkZY=;
 b=VSTsNgyTQgim5YRd8ijtELv3SthuOmLkydl3f9K4Z0xeNtKggI7ficp9i7Kcxy6Ab0FTmTHKY2LFKMHLwImYQQESaJYBQDi6rOqSsXFB1F6gmA7sNv8gowSiag8DS1gpYHNP0g/JoldMCMu5nqwMx7rXs+lFHYKoVFEIVEvk5iDiP0pLIt4ma10g+GJDk+yR/idjWtnM+pcvZKLn/JpxJ/EVMKDtrBsrpb4R48wf5cJrbD4U/Nq5v+Ayn6u++55WomkQbjd4qXuxsVIJS8zwFi9juiGLWPyy3sBLp5grRgRRWp37KCdBy2UET6yZedvniEHFyuVg4LtMNNn2ncJN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72n7PFMsPXdD0BofaQTPMKat9hrrYyPXpzXND92RkZY=;
 b=moBAtBGMzT7tEU8gobn1NIrNIsGl/lvPnfqOB3SXJOh5fCHFDIT2WC29o3wlQvv/lYNxfLUm/6aAcHO8yq+twBqHiT8acB7S6GusPxR2OUARZPBCfcKw5Wbdi2rgtIPYI0O5xa87AWJcMsuuzfTTmMno2JJM9Y89lYqswOA7a9c=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4035.namprd10.prod.outlook.com (2603:10b6:a03:1f8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 23:32:15 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::401:1df2:3e9a:66c%5]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 23:32:15 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, jack@suse.cz, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] dax: introduce dax clear poison to page aligned dax pwrite operation
Date:   Tue, 14 Sep 2021 17:31:31 -0600
Message-Id: <20210914233132.3680546-4-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914233132.3680546-1-jane.chu@oracle.com>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0601CA0008.namprd06.prod.outlook.com
 (2603:10b6:803:2f::18) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
Received: from brm-x62-16.us.oracle.com (2606:b400:8004:44::1b) by SN4PR0601CA0008.namprd06.prod.outlook.com (2603:10b6:803:2f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Tue, 14 Sep 2021 23:32:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6004b30b-3bf6-424e-14ac-08d977d7e268
X-MS-TrafficTypeDiagnostic: BY5PR10MB4035:
X-Microsoft-Antispam-PRVS: <BY5PR10MB40353F40F471CE4A9C21F649F3DA9@BY5PR10MB4035.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Kg+dytoBivXWlpmjMjzDrVjbsU4E3pSRYZCL4NSWDSMjIHszQcMGDgaXCdspvH2Cpi1Q8/1HSkIW/z+MxMcHt7ykX4w58qTa2iX3vaMXMSIbELpbP2CLrEbkkdaIC8w8ahDaKD1xSw6EW0lw1/cKonkTiIA3BdHFn1a5+JobpvF89dwggNjazY7l1B3a+mZrVM75ejKb1SjqEo2SAQcasNmcnGp513XkKMXLvT4qL478cls5RE6+iqbWZqb09NeD4wvMH0IbUrsyGBj/3PovrJuOyY7myytYv4RYG9ZpdknOB6BQPlgGZxepiG+t1fY/CzjJKuxmf8SaUp3Qq7taeNl0npAcf4p68OzXvBaI/bJiAUlrArFS/C1YPhqxM+x8N6jd6hZoA+GdxpmXzDAWv2WhYmODXhiy9PIopmHo0Vk4CqMnyjJong6x+yiqDcQhHDPxxfgjE1q5Zv5dhjHjHhpmO6k07hGz6aDWS18+jzHfmynefkkk17UkhUEcISKGzFR1F24YSAtCK+UemIBGCW63YWbuDdTr7InDCYKgpWbczqT9BcI/pv/ERa6GXdLfBUs2Fd+pwrTsvz614w8Cvw908DNRQnq7sIVrStfw0gIe9IUiHwzxAcE8tjRryliiuBzrf6bUgV52fB1kSnYluYwPd1ewS/wqgKzIshHew4HyfDkNF+5bAq/1Y+ImqOq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(39850400004)(346002)(66946007)(66476007)(921005)(1076003)(7416002)(66556008)(52116002)(7696005)(36756003)(316002)(5660300002)(186003)(8676002)(38100700002)(8936002)(2906002)(83380400001)(2616005)(6666004)(44832011)(478600001)(4744005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9IaH4SklUzmNB36Fo63nBdf7sj0QxQMkfXO6mLffgd2yBvOtspB86yHpcus5?=
 =?us-ascii?Q?o+ALLdel/7d8siwI4LezO2FBo3JXz4iTQUwa/0CWDlx2PI4etlwvxnJdE1mv?=
 =?us-ascii?Q?tcDbxNOj2z6YjoHKY1t8HKrcOHHAUyznxuKW3LSolqSOAmLh5Hu4gjKkQMTE?=
 =?us-ascii?Q?0yzvuj7JhCo8qndYSgduwfFYWqDVp8EXzZXRF14p7bPGolLg2D4/aRR5icU0?=
 =?us-ascii?Q?ZWQIgz4UHiKVpMIpl/lpPSgUsLy924NZn5wIG6OKT6BhEq26Nrq8wJypTr9Z?=
 =?us-ascii?Q?6ov2aUwSZX65+IaobPK+wa+Kj43BxGjUGd7t3MSqRqX0Q4OIlFMgw6cDkWfc?=
 =?us-ascii?Q?cFmI9Luud3kODYe+0qMngZO3tmxplkOC0fAkL5V9QvRIpMy7uutIvfqFkLk5?=
 =?us-ascii?Q?FDMZxD2i6a5JWGfGJDsTxvm6ivu4XqmPfBKfdlNadxzTZm2CMp1mp0n1f3Yg?=
 =?us-ascii?Q?q6CAq5wQZXjKD2cq7b4JWTZMJPPqlEyObRL2ZTwY+mnmU/qFncPtu5wKvUbv?=
 =?us-ascii?Q?u7MFnSCHqHi76rZ+uPzRo97Hsf7OxCIKy0SUU1xbutqW6uAXXuf5mslrTWSD?=
 =?us-ascii?Q?x/64A+czcNDlzlQcpBUaXLz3JdxY+a/+KrKJ2XteKjywwvdktVx74Pw3xkK8?=
 =?us-ascii?Q?wrX1kjwxM07OcEx9aEzS8Be5OyZJQqu0OB27wAtcXsLQ1+tV6x+/TKWNBmIb?=
 =?us-ascii?Q?fCehzW1hi3YEhGiDFpSeCUN8aTWGd61m9iTRhm6pe4PV7xfVWs8ansmoSH3O?=
 =?us-ascii?Q?8mODKpF+mEFc0ufwitYS16tKALdCK3YNX/2YKnANTdhTWQJvIJR0Ed7dP7vw?=
 =?us-ascii?Q?5GWQfD/XOkjTbVuQkkFqBOMVvmY7dfxttOCixzPCGIeBivu6nuMA1Q1i07me?=
 =?us-ascii?Q?z6FjdkaKg1kkW036q+zVzbh/oVhH94VM+qvRsHb2nCYEYW0yzPKWf2C3SI+c?=
 =?us-ascii?Q?79AkVj+YRp1uKV98ttzk0nT3RBY9kWwbLkw66hXKCv/IhQfTrY6XRB1EfKAp?=
 =?us-ascii?Q?fgrvX0zea2QERqVWbemRS+aoxdK/s9VGRpkjxTB+CCRfa7dXm1i5aSPrXm1E?=
 =?us-ascii?Q?XyFJQFgUDzaNaofRaOTDY51+V0Lwf4SIrvCq1+3ApNx34W2mG7d575cN1/QF?=
 =?us-ascii?Q?/mfsnldc+v8TPnyJTFeFYn9J4T7bDICrb3INtBNeJ2kSuzePJtV++7D1zOk9?=
 =?us-ascii?Q?HyB5HRb7czFQ8/uE/yyV/fj42Exjavra/gDn3uqAt6P8p0lf7PsY91KUVWSd?=
 =?us-ascii?Q?IhZC6ytnOFcm3VKfRCCJxsUjaOGuRp34cYwmGBwO4BkV9UY6y/UQ/omco6dJ?=
 =?us-ascii?Q?eJ0Z9++J1SkAHR/h9kehB5yKf/IHOhBkdVFWOWbTjpnQ+g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6004b30b-3bf6-424e-14ac-08d977d7e268
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 23:32:15.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsKyt6CEn1yONeEy6HNyMD5zU5Ul4lj7Mna0wX2KdglDUwMPH68RqGUrikOkdOfbJVw6h+fICt7dO28hhl4R9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4035
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140134
X-Proofpoint-GUID: wfRP3o3CMOIRref6XiIHUMONmec1UuI3
X-Proofpoint-ORIG-GUID: wfRP3o3CMOIRref6XiIHUMONmec1UuI3
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currenty, when pwrite(2) s issued to a dax range that contains poison,
the pwrite(2) fails with EIO. Well, if the hardware backend of the
dax device is capable of clearing poison, try that and resume the write.

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

