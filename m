Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAE7574074
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 02:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiGNAWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 20:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiGNAWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:22:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92C115FC3;
        Wed, 13 Jul 2022 17:22:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DNwvvL021458;
        Thu, 14 Jul 2022 00:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=skvsG77Zdam6PW6q5LdzG8SO7g9xvzI4q6s3C0hlbLQ=;
 b=nkThVIw4SA6tyXjKuwiNWX46ncUReNCYeGnU1ijZnlk4LfSa4nhw706RQSz4StiUx+ZF
 jU58afiILEvSVRD3HGWovYKVHCq0yZ/KwNW7IM0ES0cs/0AdKuqsLex7NvGDeRZp4StZ
 NqlI3fnAGLbsboSNw78xoDciIQxiBotft33cHbDm59QRMq777KcdJJl8XcetYFtBGcTU
 gdSms6jU+VGVMngCggbRR5irEe48LXIRZUwXF7T74WkSzYjknMqfgj0PAqyEMEDmF3VE
 y+FtmoBQGsO4EFdsSnwXU9IpUtpBtj3aaK3+K/I6NbTDfMgP5iIHyq48+Goy7rp+GaMp DA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rg3j6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 00:22:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E0FPH7024772;
        Thu, 14 Jul 2022 00:22:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7045nsut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 00:22:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNZ0SNb0z/L69ZdVevTLC/IUcmWyiz/XSBbB9brcnn05sN7qjnoeB9XjXzMVTPLc3S+x2QJCl0Tvr2fsHof0FyPXaTQ9k7XOjMb/Q/QwaG3ms28VdY7W9RkVU3iONVs1OmNWbo2aT9k5W6p/tMK9jcKIqjnZf5JM1nE5QduShypiaqD0pk2CxaO9xAT+86HmCAFFIODLmWeI9W6jq2y1leKemxPNs5PrQPCIEUBNJ5w+lCaOIoi7x9KDsLbP3NdmBzBEUqTsUmrbkiAiUfQ98z50FyvJF5pIBKOFP5heoOdPtYzsDiGevGA/2uOinXHWuIfYXE+uZH5tCGoT0cIaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skvsG77Zdam6PW6q5LdzG8SO7g9xvzI4q6s3C0hlbLQ=;
 b=oGUgo4GnsGeNqwkHHFSw+SiPRr9/5bAiOZpGrMVVN1VEkTGop2viLJc0Cy6Bu1xWrh/rFRaI8Hi3+Pf0H0AX4XuNPBPJ3s8/IgFml3D9BnvqAli4vm6wsYzNht9vI+fGZo1HIN2u5WpV0weYkL9c4vgZliDenmfxuyZax0aykn3J0IDlZOeUXPm/sGld/vIYyFgzShYAnZynK7H3vvG2XkICxJs4/P0oQxKkzS7Z0NpZka3Oo5I6bMm6lmvuoYomTmkSvGm1BOLU0Yw0vMl2ixcXxTklrE8W5nZ54Ofyi6j8U9XhLJf7bCItR9WcfLNawjI+GSz+zT9OoN+nk5SqHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skvsG77Zdam6PW6q5LdzG8SO7g9xvzI4q6s3C0hlbLQ=;
 b=RI3amCZoS1d6jWPRc0MLGmFrhz1aY07menw7V9heufNSxEPgzqZ2RrOoL8e/BSxdMr7cqrShi8+/B0mCqBNwWAQZYEFLy5OATNxSOydQ7o3nYbQlKArKaCnwsSamsvsLPVJ9sbaHgBFpoAKL7uBCgPGpG6mpdGlit3ssznCdtfI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 00:22:40 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c%7]) with mapi id 15.20.5438.013; Thu, 14 Jul 2022
 00:22:39 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] kernfs: Change kernfs_rename_lock into a read-write lock.
Date:   Thu, 14 Jul 2022 10:22:21 +1000
Message-Id: <20220714002224.3641629-3-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220714002224.3641629-1-imran.f.khan@oracle.com>
References: <20220714002224.3641629-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCP282CA0011.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45d57b91-0e43-4a4c-38df-08da652ef618
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEaBzf8LJUC6zD4VOMFYqjoTi7L7o7SIZV2dZF+D8elwdQuc853ptQVYpJ7GF4PZPQdd2+IX+D+XWUTERYIOTdIEj7sq/Vi+4aBjGM3LIz+gK67CwZnMZ4nzQs39TzoPVIPBUoqBFaCKIYAdxzOFzuM6FJoNntxz9gOlV6k8VnLoWW3jejTk50jvsWljqNK49B7lHmftr9mqtiIFiaRog4xUDiD8hIYnDuwXn8FGP4t+TZjo0up7JCKUjBLqCU1D9yuZbVMyfigN5p7KBXhsDgBaEwshlOLx+SRT8hZgL6t9A5i8gbPZK/ZNCHpqe8AtnHdsubPH4XGoEDpEslUQiB7C1fGIGCVdVV5zrFIbxcjQUTJi6tItKUOcbmcKrteQ6TymL3JijLO3/Y3Yf42JPkJlF/H8bb0Znc1wbAqYCi0aUgoSX2sDi0IfDa4y9Bn/fFtWSOxANinEOnicOxPaS5upluC8jTpsD9AHaZFMcIaRJPVgeoE6d8bhd4U4nr4XXEQFKYnogB/4Sp5prJNyhPsLKQIpFOVSoihR7wTP17D9On+iKyUPklA+9Q1FJI0gc5CK3pYYICpF06NBq8/0JCTynQ1sQ7wzwko0YyVrGJATqpiZ5vVn5AGlz+LIE87aCW+T6B1OlQaqxi/5AktGHBSCl1tRhqo4q9i07qLNOag8r7GLoEuM91UNSDH+x4XaBU+bSl2m119RHh6UAJEaQstoLzz4q+Lo4obNrHnZ9Dvb+xI8nmDREvTkICC6BnX2aj2WNbW3SIDB+KcB4/p7IpSUCCQntDG2FP3ztyxg4l287TQtavF7vjZDZuEb2kdY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(136003)(396003)(376002)(26005)(478600001)(6666004)(52116002)(6506007)(6486002)(6512007)(66946007)(41300700001)(66476007)(8676002)(66556008)(86362001)(316002)(4326008)(83380400001)(38350700002)(1076003)(38100700002)(2616005)(186003)(36756003)(8936002)(5660300002)(103116003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uxMVFj72Gyl43NB5vf3rT4E/hb9wEHvHFWyWP1Qb076yUVS3y6C7h45NCY+e?=
 =?us-ascii?Q?QpLtUGy9KNVtFusrsP3bYrM82ogZsishUZv+QWRn3MOr5opaUQe/kicmC5Tf?=
 =?us-ascii?Q?2xpTiBRWFWnBgyU3Z+gVIaxY/dq8KQqsFHzDWDeXT4DdlNPV79G1i1qYBwGF?=
 =?us-ascii?Q?0P0rLX/Xbxfwl+zTx61QqAHf1pJhLH1kyIm6l0rikU3TvogU982kqlX1ueTG?=
 =?us-ascii?Q?xEDso9WGjsCEgGS+8mvCKj5XcPCM2Ji5iVB08T/FAKnWVB9qPSB7VP0mbnoA?=
 =?us-ascii?Q?iOPMu+aQjyFUc305DfU1LiO1P+cyx8os+hTpKF+BCAU+5vkGfEV47rH4qc5I?=
 =?us-ascii?Q?TwsPinaJX+d84kTF7Z3bD4rTovbvGYz7kSjyaFoVo8UBgkx6nU5+5Hh3anO6?=
 =?us-ascii?Q?e6N1T+VjnItBPEFv3CuOefYHdizwznexQPShnjTFvLuHtrjHyL7JD4MNxje8?=
 =?us-ascii?Q?V56BaDe5fNC77epBD5VY0XLLUuUiW4MOn3CvPcBXmYsIuLh3Fhm52aLRxqCG?=
 =?us-ascii?Q?lrA97VjpLpyBmD9QImLJ8sFdAEU4ZREk1Ppq+4G+RxD3rF21LEaye5mSoead?=
 =?us-ascii?Q?6iw5DiokCLsX7AXCiKvW9LScpAdCYgUeLgBxOS0EAd0LC9wTiittLPoV59JW?=
 =?us-ascii?Q?9CQx7k7IfKJL49imeKe05Sm9DSA4PMm8mPKbtUcSKDUrcxAi6e8y56j3Oi5S?=
 =?us-ascii?Q?d0j//jIvWJL0MlWxISBPpVQZZKfb0RaYptlBQXD4LnUOKuo4yWHcLg0yRu86?=
 =?us-ascii?Q?sooDrKpRtpaAXAOVGRacwRob6tjvOCQNGO4Om57xyRlSv7LlIt3yALPn6em5?=
 =?us-ascii?Q?9bm+YIP1lyYj49Inq05CucfUtxu6g8VqhndhMAzYBS8uuZ/WDdCiVsOf/Itz?=
 =?us-ascii?Q?b4qnehSH8JwZ4ppUqfBEGe/5O7EaoeMFiC4pSudh+2ERTMVxz6BbmgihWmIb?=
 =?us-ascii?Q?yTHCa/D6sTA6INgQHriHKtddAGc4kID1WPgBZJMqKIDQSH32bHjptNXOGh+b?=
 =?us-ascii?Q?2Iyrr518PTSxNJ7j2X+KhPTFYrOrtBa6FvA+6k1hgASuV8rXtHQRjBuHWTui?=
 =?us-ascii?Q?8q6/Z8ITkegUcsvvnKJwK0SC9HLD3YoYm0oPLPL3xGBxKgYnc7fZsmfdgb7B?=
 =?us-ascii?Q?u7IYyBdjd+nMIBm1kULvad2gWjw14gf3iKvG3Hrah4UF4En4AYNW/eDBQspY?=
 =?us-ascii?Q?dAUgMpuGn/Hb0/r7ylYEyKsEUmER9XolG4pxi9WfrDmyAJy6ylMo/jQBf00/?=
 =?us-ascii?Q?QxvmbH3E8MOwKfIp6W/ovq6me0I6KDc7piiUdJimRLWq7cbXJa85X20dSazk?=
 =?us-ascii?Q?9uNKjEah5upMCfks/lamDd+jbWD1jeKNcJ3kW2Owx9Xg/lmUf/2dCwy9UqgI?=
 =?us-ascii?Q?3X7fU4F2TMvO7gEfgZ8d4av++x+U8yIa3nPmKIQqnsUbnaIN1wSMhV4PfUoJ?=
 =?us-ascii?Q?zD1iFZ/2FkE8t1WYn0QwevmEiIC+KyCq36iMLw7j+RZAU4G7D7Uu0AN/4SyR?=
 =?us-ascii?Q?1lMmZyDh5S+KbUmsRWKx6iNUh8ihrSUgx5W+EU746dc2Y8IJrXNzqFcXmE71?=
 =?us-ascii?Q?xYmyYgh8ip3pChy1TGIm+/OoBV+pwTKgWungu0fcnaFQrqbVwrRji4GuUZlN?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d57b91-0e43-4a4c-38df-08da652ef618
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 00:22:39.9123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6l3IC+0DLzLNKqCrXVVyPxSmA3z4nHnD31r4WJx1h+FBoAk1ryuaE0itbqqqJmGeZXYj4GjSoSjU7QvPwPOfmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_13:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140000
X-Proofpoint-GUID: Dcip7RxgpWO6njo_gpdYMKEHTCxIcNnq
X-Proofpoint-ORIG-GUID: Dcip7RxgpWO6njo_gpdYMKEHTCxIcNnq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernfs_rename_lock protects a node's ->parent and thus kernfs topology.
Thus it can be used in cases that rely on a stable kernfs topology.
Change it to a read-write lock for better scalability.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 45e1882bd51fb..d2a0b4acd0733 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,7 +17,7 @@
 
 #include "kernfs-internal.h"
 
-static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
+static DEFINE_RWLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 /*
  * Don't use rename_lock to piggy back on pr_cont_buf. We don't want to
  * call pr_cont() while holding rename_lock. Because sometimes pr_cont()
@@ -192,9 +192,9 @@ int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	ret = kernfs_name_locked(kn, buf, buflen);
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 	return ret;
 }
 
@@ -220,9 +220,9 @@ int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	ret = kernfs_path_from_node_locked(to, from, buf, buflen);
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernfs_path_from_node);
@@ -288,10 +288,10 @@ struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
 	struct kernfs_node *parent;
 	unsigned long flags;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	parent = kn->parent;
 	kernfs_get(parent);
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 
 	return parent;
 }
@@ -1650,7 +1650,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	kernfs_get(new_parent);
 
 	/* rename_lock protects ->parent and ->name accessors */
-	spin_lock_irq(&kernfs_rename_lock);
+	write_lock_irq(&kernfs_rename_lock);
 
 	old_parent = kn->parent;
 	kn->parent = new_parent;
@@ -1661,7 +1661,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		kn->name = new_name;
 	}
 
-	spin_unlock_irq(&kernfs_rename_lock);
+	write_unlock_irq(&kernfs_rename_lock);
 
 	kn->hash = kernfs_name_hash(kn->name, kn->ns);
 	kernfs_link_sibling(kn);
-- 
2.30.2

