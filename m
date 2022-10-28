Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A146106AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 02:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiJ1AKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 20:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJ1AK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:10:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C0837FB6;
        Thu, 27 Oct 2022 17:10:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMO7DU005927;
        Fri, 28 Oct 2022 00:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=7vQvu9vc3UC1afkOp5IDlzyW0Jgv4xGFic4JwBlj5IM=;
 b=TLv2hlFHxMtN4p2oFK9oA7fCoxRHlEU6KE6CQVVsG//zenKkNbEpTOJOmZAEXfstdKpN
 jblL1ouSBKmPuTtegLiqSg6FesU/nLRPAL6KAls3TEHxXqYhnKizkOkzVn7bcNhmJ0uH
 66/vY3s1cYa3sF18pjxqw86TPW8zUU9eptlVC1VODZ3AOxTByFc+CfHtEtwu0ck5BcG+
 34nDHnUOau095cRo5Ru+UL32Dgbin6waoybanEYMPdv+Q6R+8kt2JrIuGg00sA2qsYcq
 bolVduaMl2ko3cQQTQnu/dvu0W/yh/o1rAlYxgtrU6P4XRBYknDritMl3QaQUgwqueYI BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7uh76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 00:10:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RLoWmb006786;
        Fri, 28 Oct 2022 00:10:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghgy1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 00:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnDZVQn7oEuO147CNFWOXy/v5PDzZOPj8NWJBvIVxs6RvUAd/YkFT1Bdcs61v3juFa9aGUIWwKkiTPktaJPRiJXi/YtSPurVpxig5CkhyR4GYkUYNS7E4T4OtRHBRX4sZP0Q0fiLWI0pnmMIWQ0dkG9ZOKsU/n8UwPUmAG8zQ0VENxADaJViF6nRmWdFdjyhDrgEf0GRr84Ua1dIdhs+OPMGw3TvKkg2a91f5QnTObCIn8fyWxjM5cOoTgyNH5+pyUBe+l+HpOIuP1dnN7CJ3rtZMBecTlTmqZcDDch8M1jvyUyXh2aNTzxWV+Y2KSQVIqvSpcVDpto0m6LwOanZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vQvu9vc3UC1afkOp5IDlzyW0Jgv4xGFic4JwBlj5IM=;
 b=d+wPtmndaiLhjfbW0HszyvDe4KXz4706BKc63wfDq7drSXVlyBxRID0M4/e21bLpUHpZfVigHkx8KMRK7vUD9DLu9X1mWlDNrcBViKtt3Vo/J9pHl9+9bVXf4ywe5BgpdlPlxqnsiRn5OF4LuArqYjK6ji8bAGaE7M/4+mCIbcA8wvH3B0dT3s7Sf49y30lCoCeE3P4pQqgXW8AOo/np2Ce+vxCGVlDNnPQHiH1L+dUM0k/xmXVVzoGMYvuNROZ4AEGuA2ME4THxnJs17vzGrjuZL34txcXbu4wHZTFk6RxyAn2JR2hgnV9y1J/bkArgt9hEk7WW3hFIXyIGI/SDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vQvu9vc3UC1afkOp5IDlzyW0Jgv4xGFic4JwBlj5IM=;
 b=h1l7HBZD0/xX74nGbR+tSskjE8MtI+CyZEX93kBeWGsW90zK0XPFs2pE1OSBbLrWchNzTj2MOqQkTLyM/RBZpD8ONF+d307wTqjuT0yQOWH9V9wH2tNSwIBanZ3FyQkUzq8Bti9aT3LAC/rXvyoDkaVt2SQSoFdyi7COjD0o79s=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 00:10:20 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%9]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 00:10:19 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 0/3] fsnotify: fix softlockups iterating over d_subdirs
Date:   Thu, 27 Oct 2022 17:10:13 -0700
Message-Id: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:806:120::12) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: f74fd9c4-80b2-48bb-1892-08dab878cc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFrGPGCySIRnHmV/LlT0hsJ7QXUCNGbwYpcuQTjvAfRfEbUZB5OTDKfPOivBuy11DWYBGnHD8vUOlmBZWoWG4lJ/HqPnTJbV3eZ21s7UZF5YWqOOzUA5t/De5tP3RvBBipHGFaBYzbW4ZfQv6IcMcoTYo1CQIchlmf89CYEgkqcYqli/d7SZ0u8lcm8iBwCPZZxV46L+ASqTbcxeP2eltHHbMxuTqUp6Vie73lHOsuBO8zuJEMpGqNuf6awvhsYX7WBm7ylQJFyECN1yxvWgfegvh8sICGZLTy0eAvS8iUaaCrP2OUKwLm/MulbAOaZLF+CiV02k8naifZ3cTj1+GmdRdqMzWUFJ9CMqw8YrUm/HeaXRyaZCyOkhC4YCCy+mtvRJ+L4MRvN+nWrslfFpmBnLReGePnDFi0VKnQrG8LcNPkKGFXgeQlRbAjthYnH51s50ZV7YBnyiZpdVd/R/9ZVebIDKq71CqoE/YmANbVgJEdud7NoYAv2ZH9G7AjwdVFzMm7nqIDgXLHFhAh9B+lu0heB6SLNVmfDdN3lggBUc9M1FQan9eedFYi/QnG5EamIGnDWwWrx0IOVVpIv8VB/bnxfS96taKdJ/YS9HESJDw+b6usKgX6rz8LhI/GT9LYfn2ObMHNhN8sWGaqRqz9CWsnlvyoYRK+zDNvuyjJhf/vLoYm0o3bHu7La28bWKqIYPavQg7tiJW9yTpKeo6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(83380400001)(103116003)(36756003)(6486002)(6666004)(478600001)(5660300002)(66946007)(4326008)(8676002)(66476007)(8936002)(66556008)(41300700001)(54906003)(6916009)(316002)(4744005)(6506007)(1076003)(2616005)(38100700002)(186003)(6512007)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PlXbKXBORVZjDmC4XBkVFTo1wRVRZDG7QBOVykU1tFMKkwMx+m5GWq0ueQ5B?=
 =?us-ascii?Q?eOWvqxa0QrPjibnoyfJufDG4Q3HWzOeJv5zVkawsiJbl67cZij3EstyV6bvw?=
 =?us-ascii?Q?eR7EpDLCnceD2/Orjvyu2qF9ETswcMSm22ZiKVhJvkZBKoOxHuws+QTDuYJb?=
 =?us-ascii?Q?9sP3z/mdRl/yNEMUxIYkEnJHSfVrGQiC2LWZS9tmMKz9iMfoh89ThqvYyd72?=
 =?us-ascii?Q?ZejDxyENslekdPFOam+JsyNOAUEfZKe5xLKQQX6Mm5Q/t8PMymEHcS6jVdmt?=
 =?us-ascii?Q?gVj1UIUXPYuts0m5wJYM2Mp9LRVti21fLIkTj3hTHEXXPVbuOdpZ0hHRlTBH?=
 =?us-ascii?Q?ocBFmvxrkHtgHDzk4oQs6iU6Aj9NXVmbFzp8Y4HEG18ugX9cC34uyb1DMU7d?=
 =?us-ascii?Q?wu5crZNfkiIkcY+dBaO6B1aPk4ak3ckc6GRlgOkUgMuMyUHy8/x9xd4eOoQ2?=
 =?us-ascii?Q?jQNIF16hh7FQwwZuqddyl0GTkbyDa79fHk8mhjQh4UYCvR8F8z0LzZDjB5LL?=
 =?us-ascii?Q?wUmwgkfaN+WGbDPXeTu9fMj9cya0RFd0ZL3jfk8mgqpyKrCuH6ftCWWJSo3D?=
 =?us-ascii?Q?LaWRiErx3lHeDwNuZipyNcP3NeWy4CzLqmOsGuj10dMMyQCKL1s8E6eIasJw?=
 =?us-ascii?Q?TDdZGfzAaMWCc2THuj1CgnxzE5y2ikwNLKPboe1unX0gYC9MHSlxIpvDUxgL?=
 =?us-ascii?Q?DwdqpRa8X4acG7ojtsmxO4Q48kV+qHvXybV8sChkw4MCwcF56i4413pjZ+wK?=
 =?us-ascii?Q?+8bcdL8giM9V/2Fl53ylEdCZ6HlvMVYQwFMgo5sPm0/VpBElvsprMgRD7UQ9?=
 =?us-ascii?Q?n9BLejvl3ZuwoC72Ckp14j1b6z0UP+W8siusbZUL0i7VbHF4ETXB0AZCuCpX?=
 =?us-ascii?Q?nPhYjNkdtkNugehnp+6SKghhKb4zOdHtNDfVHfd7GaEUnu07CBkDKZbSWNYs?=
 =?us-ascii?Q?C4dFmvfjklZBdns4YhcLyQT6ncICahhpGdx4IV6DsoOEMdSHGz0EoKGZFOom?=
 =?us-ascii?Q?oNuQpHrYFEn/BlztB7TEUHhO9nXh7JB/T4zy0U11Ei6yJNrpCnD3yALoG7EP?=
 =?us-ascii?Q?Z1QXLKKDvawtk9uo0lfDABezWjJyiRyfa9N8RWQDVUmO6yqG+Ia9+7leZTns?=
 =?us-ascii?Q?+FJc0HoxrlUAJKnR3UvGr7GRMFG39DRu7J5fan9u3cr2cxKG6tOKWM3Z47XD?=
 =?us-ascii?Q?o2N4IYEOKO4sfg6lfrTAeNqFIMM2NgHsWKnWHSryfaQEbYrOLMOGmDW6Ci/k?=
 =?us-ascii?Q?2PtqrDnU9JJHvA684WbkAPywYFPrNMq4QdBCOY8bmMURnwlEuiPcznXGmT2b?=
 =?us-ascii?Q?WnSD3kd3m67lO5/sCDUlzXnM9EWH8r55coxUPrqzqSUDXOoXQaN/BT5UNkQK?=
 =?us-ascii?Q?olzuxdda8KPafmJ1OzkiAPd2OH9mmCT9G83SAnlWD370KraL7Km3iiOBDEvA?=
 =?us-ascii?Q?3NlbUVXQk5ow1+Q07bL6rcuV3jdlpinquAEmAVyhQQz7OHyenEt17+yHm2vX?=
 =?us-ascii?Q?Vh+R0gEqDezMuRmbEo7NMmdFzmARxB9JxN/rQO3hfoRFvI1ZrsNBOxuNZ2g6?=
 =?us-ascii?Q?FFKUOsxv9tRL9UsYDQWJl3CZfGjy6bhshR8GH2vK6m/7plA1UM5qe3qfEguj?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74fd9c4-80b2-48bb-1892-08dab878cc74
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 00:10:19.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pS+WYKyzDiC2H3gYHfDbSFOoxbyanXQC0mloQQa8EjuVbWB3qmkHni4TrifkXm4uJ2Vt5lWbwFaTdIv0QXLKLCNnLoNgYWEmpcXpLZpT5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=941
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270138
X-Proofpoint-GUID: AWmWzrcAWuai_5eUifGj5kR6_0sdu4-o
X-Proofpoint-ORIG-GUID: AWmWzrcAWuai_5eUifGj5kR6_0sdu4-o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Here is v3 of the patch series. I've taken all of the feedback,
thanks Amir, Christian, Hilf, et al. Differences are noted in each
patch.

I caught an obvious and silly dentry reference leak: d_find_any_alias()
returns a reference, which I never called dput() on. With that change, I
no longer see the rpc_pipefs issue, but I do think I need more testing
and thinking through the third patch. Al, I'd love your feedback on that
one especially.

Thanks,
Stephen

Stephen Brennan (3):
  fsnotify: Use d_find_any_alias to get dentry associated with inode
  fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem
  fsnotify: allow sleepable child flag update

 fs/notify/fsnotify.c             | 115 +++++++++++++++++++++-------
 fs/notify/fsnotify.h             |  13 +++-
 fs/notify/mark.c                 | 124 ++++++++++++++++++++-----------
 include/linux/fsnotify_backend.h |   1 +
 4 files changed, 185 insertions(+), 68 deletions(-)

-- 
2.34.1

