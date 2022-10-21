Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11278606CCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 03:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJUBDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 21:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJUBD0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:03:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB73023082A;
        Thu, 20 Oct 2022 18:03:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L0EDxM016669;
        Fri, 21 Oct 2022 01:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=U4SsRmB3G9PJJFDy2/xoex3JNU0etDYF8lljuvSJL4A=;
 b=fo8ctwo1GMJEkGKlJ8czaX1kZ1KpeToJM9ewvgdhT47qSQhElgixhSDrBiz7c6i4myDk
 93aqkGOLK0Yr3Z1xpw/kI2n50/6zSJ1WYemOMKFnoT+GFMwwwibCAXThLEX905Ieducj
 8A1GiI6hAyeV+6nflvMxCWPcTR63kZsMz4Px59Ise/Ot1p5JqBIOL+u6+m8bnUSWhkx4
 W5enJeC1xpm0lLaVKuCcK5kxfrApA6dXCIvK4gYLSi3H3dV8WogGtcOHNOkvxciB4iUx
 +AQl1xSNf5ppQnkTCPoQ8/Gy1hTwxihwMJa9YxECOayaqLn8rV90nM+8D1SDaiJM3lco Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtqp4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 01:03:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KL9HmT018261;
        Fri, 21 Oct 2022 01:03:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0tge9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 01:03:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oasWSnRyud56tV2DbBDE9HKTEyh02AK0qgPa5QZdDwQFd57Xr+I3R1UwUHgrtnJ1hNuel7qBJxQdurYjMBEF/ESXPVSJ/VHgKdPfQRSGkBEsOJs2WLFhnniD5OcdyIbxymyTjoerv91o/PgD55sN8/EZPNQCUO/ZchxhvsuhYvXvnbN316c8jmPjqE3iPuiZye5Ei/sE2bstsJdq8kOkMGNVugvnjghjtw8jb30W/G5aHp4kirkacHzWAY07WG8zaDj50qmp64rX8gQEpvglvKJcicZn5TdIVj05DUPpTUiEb9z8XNpw4N8udK0ndU5pkQGVYhTKdQFBBrbXY6em6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4SsRmB3G9PJJFDy2/xoex3JNU0etDYF8lljuvSJL4A=;
 b=f8CaPmkRQbi7GspwwBxHXBjOKKdTXRP+P2FLEROWXesJnfTxQHYGbX7RzO3yCrJChzJS6srLUt1q8q+iIGPHLtq7n5/JDiU2heRQHYVnbtkD//nJJ3Tml32L6pdVIovELBveCaKAeRhNtLYdbaws1jOikpm8pSBWRtNUywbWumgmtoIyqJ+8udaRtqlFxnBLNEq4dZYvPyI26d68JIrVH3yNfPevDGAjeYyEU35KFd5//vCgQrDBASDMDCYFml1Z7qPuvCDjv0rfzoUhCpCcvkETTjwL182Pg8g91jUngC6wAqQ7iPWMBTc7FBGL0sCVL4hRQ6swIdwrURJD6gMidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4SsRmB3G9PJJFDy2/xoex3JNU0etDYF8lljuvSJL4A=;
 b=hDEjfLMobA7zl5JaVpDRcC7sgTnjfvzv01UK0K4M6SjspHq2mwH68SVSa2vNqCSMWdk7QkXLykNXOxHv1g2NkaGjM45odDV7EzTXqmQrwg/L8rWkzzQHYDLDOQ7K1K1HZXljYZMpQ2A6hRtsvgSJWRKzbN6z/8sf4TnDR27RIrw=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 01:03:19 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 01:03:19 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v2 3/3] fsnotify: allow sleepable child flag update
Date:   Thu, 20 Oct 2022 18:03:10 -0700
Message-Id: <20221021010310.29521-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
References: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <20221021010310.29521-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::44) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|SJ0PR10MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: cc24e55a-ed3e-448d-6d0f-08dab3000b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXZfaspf+88LZXLT8EZn2DCncVaLTCsOyDFqUu0aZbKgfBqPWNDCiGAJZsPUgBg56fzyR6Y1Jj5y7nJBwVtcSNgoYgZ5ynoUuAM/HbzdqB4iHnqblng6hAaItYDxx55budj0vE/+kAMKL7g95fv6qpTTfbynfnqy6eW58zWw7vh0pGf67XFpKVDMeSJi7bUUPCGUt1zwJ+qIbqOMpre3nWJ1gOnMCQibtqWmjPstSWgc25lBdbMLp6+4awiXMySd3cbg26+LXAjMMA6IlmSUZIQXauUND5pGvEppFkpwbmrvPjUYRmITWjQdzrzlH9TWcpMbI5tG885KLaafLEtUBL24py53/Rr3Obh7VrPGO+Thp93uE7rxjkkozHfI3hwRDmJx3RKRJpjN498ofT4v7YFbJoM5Z8ugcALBu2KAcgejvTndsVaG0IeZyudTQeEzJ1VCMASlRMaXqaqNb8ZIUdepUSlx9E2mO8d/myOgnMa2o6Fvq0C9GjP/WKu/j2h/mbOwpppYprsx/WQ+np+r2rPla/Dv2jlGFXQw4x1HVYsatHB+buI/zuxw52ev303bJVutHZ0SvlxQbwWlIOTxZhtRiDn9UmTzuyTdViA58IAg871IsdsQV9PGJtFljLw/sNUW8n7BNlBK9r2ckYuQUoX1VCw4oZitb11LKeZORGBrsIjjJZc44FZzJL0dxvp/+7f/LKPiaV/FZNcjoNdBAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(6506007)(36756003)(86362001)(38100700002)(316002)(2906002)(83380400001)(103116003)(1076003)(110136005)(478600001)(107886003)(6666004)(26005)(186003)(6512007)(8936002)(2616005)(66556008)(4326008)(66476007)(66946007)(5660300002)(8676002)(41300700001)(54906003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LlsO9tCZnn1kpKorq8Ng+F7ojN6zKiaM2zQ6BXPzMTYJPA042CrivsJZlQrD?=
 =?us-ascii?Q?+XNVsJqXvscsfURIVkHuRvdZDlPldVwq3t4kJRykKMDUXVVXc+XBdlv/yvRF?=
 =?us-ascii?Q?+X8UwEfnEGAlkO+XMocraflLhBsxQtSSkXqSC8weES9Wzzhi0KFglk02v9Vw?=
 =?us-ascii?Q?ketfSZoEF5MSLSXyasiRatRsjDmybHSVe5nDDEUOjNKNbEF/F6nDYBcsFiMQ?=
 =?us-ascii?Q?KZt71m8P1QuQn8rdBAKG7z4W2ZCKNCp0lTQJU1C+gvUO5SE1AUY9hnr5zFpq?=
 =?us-ascii?Q?fPh5LB6lsLOC0m1VyEbLO0YgX/0Jvnzv3wGN2nQ3aQeWvCQKKt9BqYB0z/8n?=
 =?us-ascii?Q?L5eFAHrtdQ3WGbE7nPvhrHpTwY4U0EAfUX/6gpOOSqFL+ayX5/eoljDpLFhJ?=
 =?us-ascii?Q?vhPb+WD3IyK3O1lVutK0FES80h6PEAj3FRrr8kvTr09CmD7L2pve68t6URBP?=
 =?us-ascii?Q?85ZZASPkRl8rQtbdX0XqNKFgEkCTosED5aR0SYQXA+QC/bCK0wCYNoHCrfZD?=
 =?us-ascii?Q?uUw0VIxZiS+2L5QzYI5qY8CH+LLYJp2B1oFnwlduoBfT4CjrAPkqbCV/iPQJ?=
 =?us-ascii?Q?eVOAuZvbMxgaXaECLcWHgVg5GkG0jKHuHrVhRthZjg62V7KlTXnUFG9uwWfM?=
 =?us-ascii?Q?guS1zxNd8H0IMw9D91G1gCl/6Gpir9FYHgtywqVmM0gDubRVj0Vulf8diQW3?=
 =?us-ascii?Q?XS/GOlXWAe6ceoX/oORYBpUlWHi8Im1YvuzFx+ZCNFQHEoEQmdbx3Qr6vR23?=
 =?us-ascii?Q?AYPS+pehCCcOtYLI6YgAko+cUO94A5xxCXdB155AxMHsiNt2jhDaNQSEbwV9?=
 =?us-ascii?Q?I6+jGfm3VLri0jJ/PK50Y10J3x+jxgCd+5Od3W5fHyGizLlFPBDlKLLwQGLo?=
 =?us-ascii?Q?BsvTQvafAnTgYTYoRIQ/5eqI3/nO4qytxERjUKMEM3mzDM3S2ANN+eb9OGvH?=
 =?us-ascii?Q?ElOrnnjyL5hd/hg+Uo2WJIc3UnjbxXQZWD18EukPunZAQwhSl5U58FBRppFy?=
 =?us-ascii?Q?vY7YXC0LG1vkKgyw0T0MndXACiWw5TnF+XlG9NpimRPVru5cbAKGXSKpk2ss?=
 =?us-ascii?Q?OzcBI2+QZXsCJOB3Yyh5G4aBvcsgalWV/82lEAAlA1x+lxbRA8c6BwANkss1?=
 =?us-ascii?Q?cu4/hBd48IZfZktcKOGc19CNpd1+aT0Cbl4XqG4p3cQZIVmRx29J60YqNQUq?=
 =?us-ascii?Q?IJ1S33cCDkxUyg9sK3fbFiQHnIofjvnoI72mKNcYWUWal5pFDfWsXA3cBPKg?=
 =?us-ascii?Q?HTIU8OoOD5I0FXNgD0iuPKwq3K9IC8vTVZhVAm1M0u6D8xdpLGGNnddFzw78?=
 =?us-ascii?Q?W2OXEGYUm6jMemNkZycUUhxh0qaS2ELO67wvZrlYiR05/lhuuqM00BOFlIZf?=
 =?us-ascii?Q?Or8KWnYuoLBHU6X9SXDvrCDnmKsFTPeyVaNKAN8gp75uB9cjRMUROCJlSJym?=
 =?us-ascii?Q?lAGM2jYP41b3gfEpgLRGx2lABNgWHSmVbYiiJFtkgFuH1QDItcMkkUvq/WQG?=
 =?us-ascii?Q?C2NRnLaYnDLh1/iU/b/0ywgqt48eIAnqG268VsYr3Bi1/v9VaIeSRaLWvb3I?=
 =?us-ascii?Q?DB7yPIpzoUf+fbWRvdoXgHw7X/qoqEpnUehTTFct/jSx8ujOtq2+WaA9mlEA?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc24e55a-ed3e-448d-6d0f-08dab3000b28
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 01:03:19.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZdg5d5ARpWwymK2UIjXov7Cr4XKnIP8hvIJPZhEZx+aFoNUU+UJ5dcIaFw4meHVjC62HBgHYDpeawE4XHv/SsH/A7Z86NrHYSTS7qDGo7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_13,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210004
X-Proofpoint-ORIG-GUID: S5OU2UjuDetV2H9CkBqqHX3e5PMccWOM
X-Proofpoint-GUID: S5OU2UjuDetV2H9CkBqqHX3e5PMccWOM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With very large d_subdirs lists, iteration can take a long time. Since
iteration needs to hold parent->d_lock, this can trigger soft lockups.
It would be best to make this iteration sleepable. Since we have the
inode locked exclusive, we can drop the parent->d_lock and sleep,
holding a reference to a child dentry, and continue iteration once we
wake.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/notify/fsnotify.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index f83eca4fb841..061e626127ca 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -102,10 +102,12 @@ void fsnotify_sb_delete(struct super_block *sb)
  * on a child we run all of our children and set a dentry flag saying that the
  * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
+ *
+ * Context: inode locked exclusive
  */
 bool __fsnotify_update_children_dentry_flags(struct inode *inode)
 {
-	struct dentry *alias, *child;
+	struct dentry *child, *alias, *last_ref = NULL;
 	int watched;
 
 	if (!S_ISDIR(inode->i_mode))
@@ -119,11 +121,38 @@ bool __fsnotify_update_children_dentry_flags(struct inode *inode)
 	/* Since this is a directory, there damn well better only be one child */
 	alias = d_find_any_alias(inode);
 
-	/* run all of the children of the original inode and fix their
-	 * d_flags to indicate parental interest (their parent is the
-	 * original inode) */
+	/*
+	 * These lists can get very long, so we may need to sleep during
+	 * iteration. Normally this would be impossible without a cursor,
+	 * but since we have the inode locked exclusive, we're guaranteed
+	 * that the directory won't be modified, so whichever dentry we
+	 * pick to sleep on won't get moved. So, start a manual iteration
+	 * over d_subdirs which will allow us to sleep.
+	 */
 	spin_lock(&alias->d_lock);
+retry:
 	list_for_each_entry(child, &alias->d_subdirs, d_child) {
+		if (need_resched()) {
+			/*
+			 * We need to hold a reference while we sleep. But when
+			 * we wake, dput() could free the dentry, invalidating
+			 * the list pointers. We can't look at the list pointers
+			 * until we re-lock the parent, and we can't dput() once
+			 * we have the parent locked. So the solution is to hold
+			 * onto our reference and free it the *next* time we drop
+			 * alias->d_lock: either at the end of the function, or
+			 * at the time of the next sleep.
+			 */
+			dget(child);
+			spin_unlock(&alias->d_lock);
+			dput(last_ref);
+			last_ref = child;
+			cond_resched();
+			spin_lock(&alias->d_lock);
+			if (child->d_parent != alias)
+				goto retry;
+		}
+
 		if (!child->d_inode)
 			continue;
 
@@ -135,6 +164,8 @@ bool __fsnotify_update_children_dentry_flags(struct inode *inode)
 		spin_unlock(&child->d_lock);
 	}
 	spin_unlock(&alias->d_lock);
+	if (last_ref)
+		dput(last_ref);
 	return watched;
 }
 
-- 
2.34.1

