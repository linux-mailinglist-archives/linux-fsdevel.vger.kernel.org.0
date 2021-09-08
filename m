Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CE04031BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 02:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347188AbhIHAF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 20:05:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57702 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347152AbhIHAF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:05:28 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187LTZC7015703;
        Wed, 8 Sep 2021 00:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=QlSui7A98vbmXzPptJLKqYxYJOsWjBk9Se11S+phqq0=;
 b=JVvx9pHWAymTGgEyQE7eo1EISL2d5SqOA32pCu8A/EJdr1qvjB0WApVGzj6iwRvhKK2q
 1RARR2MpOnRmD4rWuzdRLDQhh1izwOoEiYxpR2LNcwTnc7LlTJULVfBjMTEAPhqSbvUa
 4L9x8AizmUTEXiSsNDQLo70KTimQZgwWuXkMGoGhnoV829FmC961oVQ311mKLLtlThMa
 Y0jKCQch4EkXosPz4GnqaNKpwVllqYxJ+HWLutYGccO1bRMAwIGXMybzNuUMwhbeCwQY
 ffOBAojxfkfm+hue4e1XpJZ2FglyJ/3Stjg78Wi0uKj9itGgnnJ3GCGXM9NSlQ3P5NfP mA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=QlSui7A98vbmXzPptJLKqYxYJOsWjBk9Se11S+phqq0=;
 b=l0tfOSKwjpBvbBPIXZDBitzaCsHDMly7+p2SAB2slC+ZK0AX0Jb+txJ6Vp+WqtNfRB9x
 Y2xB3TxAR7CE4aL67fcs8mJ10zNTKAHgPXbtG6wnH60ZeqeKXvHfYZH3OahVfiAvQ7fI
 GKDILSxmxhKA2ACNM6K8NbCeZDDvs60z1mxSmyZPZxGPYpyqRr9EhEkM4KovQCasceSU
 5ghZCE+mBRQVjK6n4J1UyHiRCvsv63FxdVCgO2CDEEAzXOvMurrXeoaiLWQBfk7PtIUe
 BgDCEPoytD8qjHxf9r7TZnSmA0R6SupHf8Rup3CPk1Cq8W3pEXs1aB9oS8LB5Na9X4gE cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcuq8t6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 00:04:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18800ngE029240;
        Wed, 8 Sep 2021 00:04:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3030.oracle.com with ESMTP id 3axcq0g29u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 00:04:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdOk8Zr2TpGuUV2a/HJR3YGJ/fdROrrdaBoSlhG+DXHNTIGtbfmM+z0I9r47SbK3lC97fqeFKuhoK+RbRDfK1+fIUD+djBRL/PjgO+skFmvPfdQs5KKl5hdakJr+IvHvcGIEUvsWKVVZBei1cnjuoWqLFAgkW/WmnyoJKFRisZ9fXfH4jfSMAgb+RCf+t75GymNTBcUAIyr42U79fC8Sj2vzVEFHT/aMOzAh/yxf/8RwePTfUEwD76mleyF/pKd2rJUW/+uUM1Jw+f8Snfba8o1a95AWEli7jPLOLdCveaaYVGGM6Ian/fkSUdaAwRyfi2Tu9/JPAUVGEt8vLY1XzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QlSui7A98vbmXzPptJLKqYxYJOsWjBk9Se11S+phqq0=;
 b=HA8rUtJwprOrA2HiMnu3ongvFy7SFz1E0i2PP0vsua/sI8k+L2oSIFmThbVt5ymY8jLvP6rfeRdIi6XCuR4ikZzl+9HONxaUKbcKorL2GIpWt5x2d0vFTm5D75IP8gLDIRU7eWPw2e+Rz+heI0g9xbLiDJsR1rj4x+L9lGOxx5U09XQsPcwodC6AnvXTFA/LCnq36UTMLwhRHcR6CzzYkHyJgkto6MewFVYC/TOENzpNLnHpV2c4XhlSH4EX9V9cZKBiPHIGbraiYTpUkHuC3siSSjkQ3aOrQ+tsEpwm0DCUPCV96hjMqjZew5hGihDSBncMujzi4KGt0sbUlV+mUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlSui7A98vbmXzPptJLKqYxYJOsWjBk9Se11S+phqq0=;
 b=e67JUlIKsPa7uGoICft6D5/sznD1IyQcOUFDT4MgrtYyl9PFMTHl02moOwoFzsjQaOA1LgHQWReI2P76J/8LJa78n7GcVH5mbmf/Uok4b4etQgTabL4ekzemR3hVqN8MHuD10AUWNGpRH0+WgEAkNNqsk2rCsvFaE+jimiXEJsQ=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5147.namprd10.prod.outlook.com (2603:10b6:610:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 00:04:16 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%9]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 00:04:16 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] namei: Rename __filename_parentat()
Date:   Tue,  7 Sep 2021 17:04:11 -0700
Message-Id: <20210908000413.42264-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210908000413.42264-1-stephen.s.brennan@oracle.com>
References: <20210908000413.42264-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0080.namprd05.prod.outlook.com
 (2603:10b6:803:22::18) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (148.87.23.7) by SN4PR0501CA0080.namprd05.prod.outlook.com (2603:10b6:803:22::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 00:04:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b622c60-7013-47ee-b849-08d9725c32e1
X-MS-TrafficTypeDiagnostic: CH0PR10MB5147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5147875AE7D6FD40F188550ADBD49@CH0PR10MB5147.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?80MAvXkgNnWC7yvjXzAzkWuWTRHkCfMRF/0PCLLJNwr72LWg0Kz6HQqScdvU?=
 =?us-ascii?Q?4+kt9vhNLDYdrChIxEx91Ac7WVKxHBghBfEI4D3b9CPHtAp/FJroS0uZVPRk?=
 =?us-ascii?Q?PrMP4Awev9hY1j35VG0IZ/e/Kyza2X6qv0TpDJCumXsJZVVmHQi1TOLRYhf0?=
 =?us-ascii?Q?5NYhZDelHRKZLvxNuqljcNpwoTSSVbPZ6P5qZ1si8jvRLf2xmJ3t/Kp9t0hn?=
 =?us-ascii?Q?UPkSVfB7Fbma0HBB5CPJQjHOE1T5c+q+LmDXnAEGRbrNHp2hk1SubEjK+jsn?=
 =?us-ascii?Q?1szgSfyD+I6snM0m6O/Dbvr2olm9t7tG0xhugmavKBvrt5KuTEYd+85/u8fD?=
 =?us-ascii?Q?gbDfNCAkLwUDStQ2dacNpNahpt5lfyI8Yr6xVqOzrZChg+ZbB4flDv5rgGLT?=
 =?us-ascii?Q?6phewox4gDL4fhp0vQ/MetK1FO9vr/d6aDSmwKxeK9ixABhUqzgI+lvTjnJY?=
 =?us-ascii?Q?GZWWjrWnXgsdEoYKpyryD8XANXf4BEjOOJyl4a4V23IQNaVda0808GL8YxUw?=
 =?us-ascii?Q?RuihTDa6wDBUi4Wn/SU2vQmySH51hWtGLuG+QUwkzXJmI9tXhN5gCwvAfDJl?=
 =?us-ascii?Q?GD87u9MUKhbq3TycnGUQckbJ6OOf/m7iN8m01MaqLvrHvQ5n3qiwHXxfWh2N?=
 =?us-ascii?Q?t64utnutg1kgvEBosBkpT12qPdOutupKb28TIx5FgF85hlxD50MguWG/jdZu?=
 =?us-ascii?Q?5/Hfbmg3D7o3xn+ufauwm1T/4fJupEo2431tbTDIg7Pq92UxGF88SQishgyn?=
 =?us-ascii?Q?V06jLScj+7GhVqpiS3PGKJDzTgcPr6rYlik64dVCVCsfL3daUIhxy+znNo2c?=
 =?us-ascii?Q?w9yVpMhH+p2kNZ+9UZ9WsqHwH3yrO+9h2JAWnIU6tg00JETADBZFRCEUVUz2?=
 =?us-ascii?Q?HKuV/NByEwlihm9yyUpfBrh67nCGQWzB/eiTaRPFsokp2TLBn0xEKvSGCOSR?=
 =?us-ascii?Q?k3TYa7ci3gScTc67ntTC5WFcllTrr8SHyAmCCkAgPK//2R/44eG1SdvP3JWT?=
 =?us-ascii?Q?GMXG6oDVXAfPCr8LVidti4Q6LtTmiFw4Rhd3+u8OSnchDIu2RJKBuhq76FIq?=
 =?us-ascii?Q?QlX3YDU3tW1vGe40fFiuXrGPAjsTSoSTzzALM1VJC/K4Czsr5O4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(8676002)(2906002)(6666004)(8936002)(103116003)(478600001)(66476007)(52116002)(956004)(316002)(66556008)(38350700002)(38100700002)(36756003)(6486002)(6496006)(966005)(86362001)(2616005)(1076003)(26005)(4326008)(6916009)(186003)(83380400001)(5660300002)(66946007)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X8Yb6VL7b18VpYb8TwIhvpRwrh8/uZWXws3P2XQZV+5sFUzZ1tOnXaywWfrH?=
 =?us-ascii?Q?4qxX2D262g3uLaFPC+okX//OdUQ63IdINzC5l6rLu8d8fMhIYOKFOBvi9w/6?=
 =?us-ascii?Q?IwT8A6zxALoGgexxuYB60aaBWWsUGUvvMWpz0/ZzHMgzbsa70fr86B6Uso8X?=
 =?us-ascii?Q?zq1gp6xS5midSXIkgsY9k+Fb+NPKnGS6g++YMXIYUfTtsk+OC0S+EokCwvuT?=
 =?us-ascii?Q?MAz069fZdPI3jP6ymD+Jmdo+E0sAqhSAo1EDTKcy5ujUuDbsyuecKA4IS08S?=
 =?us-ascii?Q?feJ3yjiKKBnz/wvk+VEIt7fmbNKub8Y87vmXdZdWWTv1wSaD5bgKNLEljKl1?=
 =?us-ascii?Q?y7TSiJPdY/zDL3dY6yPZLmG0WILvBPdK/l4m/6lbR5qyAKkcNiPw+mRAxvPK?=
 =?us-ascii?Q?Yq1p69/j4LPue6tM5Gsf7vtambM5+/UhjI8+vz4eOeEbsxXvdtaCGJsZSezD?=
 =?us-ascii?Q?wRV9XcsL/JHx82/KwBfqJSWrdK55nrQ/tmR5WJhtV05/k1TVFaPL6T3PoP4m?=
 =?us-ascii?Q?ipLWhmAgQb4sYf4oMBWMPTBU7H5UulDJDAeujcF5Hn+uE6xVluO1F8JsLcWk?=
 =?us-ascii?Q?bWiJXzl6xiVnpZAvT/ARAjZ5b/uk12/XBSGheXMZQMkFQTtNE9knntOabY3M?=
 =?us-ascii?Q?0/RUEf4LnH2bia+nauCNvOoFG846gZ0do+RQatdrahwU2uwFSRzHF/LDkTGJ?=
 =?us-ascii?Q?kt6s2VtcM2VsbhjoJxX60E6PH92+cF/euvBVhTcZmT8xVriFY77keJl9UD0p?=
 =?us-ascii?Q?xFj33Th9NKp1DHWRhjz0vmdFKrZpfyqwqp5NBB4uLP1RfspcnmkgXkMh5N21?=
 =?us-ascii?Q?j47+iCG+6SZIlDTTkGFYjZegH5NJAMFICwAJJbEr5miOPhzgbkrbkN8ZnbvE?=
 =?us-ascii?Q?8K2cinac5b+AtAEYcuCQalAzMgWKCS29HI8JrYtq8Cxs1OwGOm3bPFWWtFoJ?=
 =?us-ascii?Q?yXCh0jUoZ33RyJmOidB4AqGIu1gmdPZXPtU6Srm+3Sb6YfHa8ftByAmA/pa7?=
 =?us-ascii?Q?o/a8Y1lCp2h+zBUN0zWeSaqGzDzpGn19zpLrwh4EZtxFjL/fh4KuciQEsOb/?=
 =?us-ascii?Q?1RFN35BQvX6mFyu0+wAurNkam3Ori9BBDHBxRAAPlUw2vRlWmf++QCE2/SMd?=
 =?us-ascii?Q?3qVFGBKbHut9ZHisvc68J+CWmijMNT7k3Fn8PXWeG4vSlBZplJNedzlBWdNb?=
 =?us-ascii?Q?Bcou/vEprHDVr8ykfmlHCYeO7NUm5RiAJdHUPj+8FLKTpo+x6dOcacmJY79n?=
 =?us-ascii?Q?YebCu4IIdF+XLFyPisS0ceUkrA0TYQGNwFnktdMdTNjonS7eU7GxvJpZCxwz?=
 =?us-ascii?Q?By/nrEe8O+n552UM5yZ4yZKx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b622c60-7013-47ee-b849-08d9725c32e1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 00:04:16.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Fz2meAkNTZXIZrzNbB+956cqSmojw3CYERHCZsG+g7hwULwzgzoGBJfYi1mZOu8pwYWVZmMOYJH7A1En3dYDCcH4bLO1dDkvDo2iCRKGDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5147
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070152
X-Proofpoint-ORIG-GUID: -tKpG_WRIqzSxBr1nIvx4_MK0yYGqUuC
X-Proofpoint-GUID: -tKpG_WRIqzSxBr1nIvx4_MK0yYGqUuC
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that filename_parentat() is gone, rename __filename_parentat() to
the original name.

Link: https://lore.kernel.org/linux-fsdevel/YS9D4AlEsaCxLFV0@infradead.org/
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Co-authored-by: Dmitry Kadashev <dkadashev@gmail.com>
---
 fs/namei.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index d6340fabaab4..33f60d1b3a87 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2514,9 +2514,10 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
 	return err;
 }
 
-static int __filename_parentat(int dfd, struct filename *name,
-				unsigned int flags, struct path *parent,
-				struct qstr *last, int *type)
+/* Note: this does not consume "name" */
+static int filename_parentat(int dfd, struct filename *name,
+			     unsigned int flags, struct path *parent,
+			     struct qstr *last, int *type)
 {
 	int retval;
 	struct nameidata nd;
@@ -2546,7 +2547,7 @@ static struct dentry *__kern_path_locked(struct filename *name,
 	struct qstr last;
 	int type, error;
 
-	error = __filename_parentat(AT_FDCWD, name, 0, path, &last, &type);
+	error = filename_parentat(AT_FDCWD, name, 0, path, &last, &type);
 	if (error)
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM)) {
@@ -3633,7 +3634,7 @@ static struct dentry *__filename_create(int dfd, struct filename *name,
 	 */
 	lookup_flags &= LOOKUP_REVAL;
 
-	error = __filename_parentat(dfd, name, lookup_flags, path, &last, &type);
+	error = filename_parentat(dfd, name, lookup_flags, path, &last, &type);
 	if (error)
 		return ERR_PTR(error);
 
@@ -3995,7 +3996,7 @@ int do_rmdir(int dfd, struct filename *name)
 	int type;
 	unsigned int lookup_flags = 0;
 retry:
-	error = __filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
+	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
 		goto exit1;
 
@@ -4134,7 +4135,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	struct inode *delegated_inode = NULL;
 	unsigned int lookup_flags = 0;
 retry:
-	error = __filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
+	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
 		goto exit1;
 
@@ -4682,13 +4683,13 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		target_flags = 0;
 
 retry:
-	error = __filename_parentat(olddfd, from, lookup_flags, &old_path,
-					&old_last, &old_type);
+	error = filename_parentat(olddfd, from, lookup_flags, &old_path,
+				  &old_last, &old_type);
 	if (error)
 		goto put_names;
 
-	error = __filename_parentat(newdfd, to, lookup_flags, &new_path, &new_last,
-				&new_type);
+	error = filename_parentat(newdfd, to, lookup_flags, &new_path, &new_last,
+				  &new_type);
 	if (error)
 		goto exit1;
 
-- 
2.30.2

