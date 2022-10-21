Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F671606CC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 03:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJUBD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 21:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJUBDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:03:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A423081F;
        Thu, 20 Oct 2022 18:03:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L0DuhV018604;
        Fri, 21 Oct 2022 01:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=nHvT0TIisYaD9xqDo37eB+ZxqaY+hbhIZ9GE9avGnq0=;
 b=cDuCrq676/MuQ18mrtHf6cRmbiuAcWA3ZjPK0n8LPwT7z9eRUeOe5HA5WxdD4/y0vuOC
 tQHE2b6A55Y0HEVpcQ7VHgOBs5XSMNl5BnsbRu1Inhz1uw3ybvmaW3o0b943vYtVgllk
 NJ3cKchGqnB45WEuKOOnfNXW3ceRR2+5TJDjVTV5M8IN36E4+ehawvmFYgsr8EE+K2+D
 yyHENsssmu80T/RftHpEEkBVHXESv1efXrUwuJ7POtoxohwt6+tXCGOIzkpt2Nzs74sO
 Ig5zMlSgXzAnkaGmXso2HOgFh4PHgcziItUmCvTfibfMTWXAsmYrMfsIHXPOoMootKWC 5Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7st2n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 01:03:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L0CrJg014702;
        Fri, 21 Oct 2022 01:03:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu99feg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 01:03:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdbe+LLV72GhcdXqPdc6WqqzpvIOzz9hTZUJINgxA1MKPNssbnwviq2no+lASgGNVg856d6GTaq57crSMkHNX3eZu35YFRaySJu3BGi8z73FboZuSyKneHrVZO2jLO/GiSPJlzguOyjTvr0RxiTVybcdFb/EZ6I3pkswsCovkSCP1hKLBGd/eWwP+H71ytMhUqqtjtsnLEC3FJtI/VZWBAlQNY2A6HuYk1JlPeZ54STxTbQGydBhdijx/6E+tLLzB3jjiiEFW/hzQ+hhgUdNDO+PQVXekZwSPpJZguXgbx6pT93NQX9OFm/hL57D6QaSquuXXwO6c5Afd9wQVO6Dkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHvT0TIisYaD9xqDo37eB+ZxqaY+hbhIZ9GE9avGnq0=;
 b=lhDlSkmZgl5HuNsZnAcTfYWpz+sfDoGp9etETa3NYGBNjbFT4opi7h2/rfcb3KcCC0yKKS9A7Pl71AX3xSHPsGHMKSZeTKvEHse7ixQopy3ybW4sCeQm37NivPr9W6avK9YPAvHXKo3M2oZQVflBTSDTt0dkNQqbjBSyIgPN1LKE5/idPa+e/jeJOKX+Iuc2jjSDLfAQrYRY+rOYvDzhNkrQli+Jyj+VxM/CL1SRx9MopV64eGg1qzItMzhW/0uXxaW2JtliCo0NUEpTwPh8M0lnqowIsiCzK4VkBLM3L7kSr9a+VaZAL8ApUm3Ubawp/g1G0vz41GK07Pf9sfyWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHvT0TIisYaD9xqDo37eB+ZxqaY+hbhIZ9GE9avGnq0=;
 b=MPpObC31pLeVX7OZW8JaJwSr71t7kPkMlxQTwfqopgvXm7isQQWeIKD+bOHCmfUe9pA48EPuLYnzgIIewimyY7R5thmTblVOEgWarsAwS1WmVLkfUJiM9zbr5fsHL5lHWvGIOoq+tpD/qOCHgyfx6VgiNxxcZGX411CVB4j7CUE=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 01:03:14 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 01:03:13 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] fsnotify: fix softlockups iterating over d_subdirs
Date:   Thu, 20 Oct 2022 18:03:07 -0700
Message-Id: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
References: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::35) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|SJ0PR10MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e66bd33-ff15-4fe2-5891-08dab30007a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NtCVEEi12qeeGcUVoVvaNhmIP5+5YBLrFoDhEnyc9ldvnTOzqo2qS45+FXjANLp5nLxmH3QHj5bKOjTcMxORs3gFA/cctyCiWrVfTA13ocoXPLAwE8IGsWusoEieKwkimJpOSbdsxAg6rj50x8W9iATdS/mDwFWL6XHAF+33pqIthvipCkGg9Zur4NR6eHAA35oUrcGrpsmBPCFer5e7XTSbvB42SdlGeYEPrK7hgqVRhHnnZfWbdcT4zIQMkAEh70W8Pq8kLrabMAi4LjOvwtWE66gpFBvH4o4HjIgkGTYgylVeehALPgEspVC1F5KEyHYwSwu+fNktGow3ylj8jLntDzDFzHJR5nt9Q6qwrOdX1c9orpBqflLrKRJ9ZaVV2BmrnUnWqP7JIY4sTM82OgZPfsCXSL0NGz3L3SZ4w88mZIE1/6OEdCMtKS3grYLWzjBKATVVkWj+NLRkd4qKR7WAf+cnLExHQpO+fCqiGZsLshaSQ3JfHusaiFGqi3exc7TIWHcMLtb4kRdjt1g8PHFuGtXvEVA9ZMX6TyjE9NnHdJfqbgOVsYZJKP55zDM0tOWicyrRn6pnIsbr5enI4Z+L6EZ27Li8ESz+Y2yctw58wAqVMWjaJ4474CSK928zsIBfe7nnE09rlTtsE0oDD1kH9iVKsAn3ug13DHOx7YIoyXZ2x6n1jy/VgeGiUGWfQJa5oMmOmct1WLC8AzEgGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(6506007)(36756003)(86362001)(38100700002)(316002)(2906002)(83380400001)(103116003)(1076003)(110136005)(478600001)(6666004)(26005)(186003)(6512007)(8936002)(2616005)(66556008)(4326008)(66476007)(66946007)(5660300002)(8676002)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vBRwvQAkRHyO1iP2o11C0jxo3CWqtLZhRz6K/hz3LenBeo1H/eg8jEq4nfEB?=
 =?us-ascii?Q?KKZCtMJicQ/AEmQRpIBK6y1WWiNSZ0O4nu6iy3v2no+gA14s8/qVRi8qdGIK?=
 =?us-ascii?Q?w0LKEc1qK28XAU33JtmAXWQ3feiqBG/P/PBRswhYIQw/PqazpZ+54L+YXbgo?=
 =?us-ascii?Q?lfoAe/Rxgv4uMgNHUJR5/asZgGSVoYFewlt2rw2WhHZ7++4wLjQ4MZS3xF6q?=
 =?us-ascii?Q?ls//okHbgSp7YgSm/FNZXyU+6Qfw3NlbTuLjQOAfRzbcKN/pDYlgbcviD/tU?=
 =?us-ascii?Q?Cns5AM+ALMAPb+WKSguMWXlDx+98dsrsnVZiQPPYNCkYx4KmcbjGZxoJxjjl?=
 =?us-ascii?Q?5QUXb3I80Li5f6oHy93LZZQ0zJHsvDu5y02Yl5rlDHYdmu/LVTgBoPK1IF6A?=
 =?us-ascii?Q?hNJ8dfqd0DtpPZOuM/MXyJECvG5oHO16vw4sPdGXBBdkQ8Ks/Rst02taI8LB?=
 =?us-ascii?Q?yu3HD1uglf0XyBF+fvrh3JdoNajjLQhBhuDB8nCiVDY9d82lHRzPyVCZnUPo?=
 =?us-ascii?Q?N1yRjn98qsEBy4AXGHTYIgz3okBI6xpS8ZOs8EUj8cxd2YC2rML1sCig41jp?=
 =?us-ascii?Q?RU8A1cQe4xfABA8ndHWcnygM5RydlWizS7YG7iEmuiPdVNtOFQEwj6om7dji?=
 =?us-ascii?Q?T11ny5U39US7t3FeE1qSGESZerXNEP/G9Zwf2SWZjoe5smfy2yREzdJCxgCx?=
 =?us-ascii?Q?8p76bxl1tEg/S7GxsP4TSgLj1v/7xo6wfn/ntYXxwJj7yS3hmbc9Y4abZhUU?=
 =?us-ascii?Q?JwIAB+V0qt98bh3u8SkPJDuGnQGzTDS3y9+3StLHGRIhXab33UWWdEC4dj3p?=
 =?us-ascii?Q?lc87WpkqG+aL5BQ+9YI29PZlpHJjShQSEaJ/ljUPolZvABjuV8AyD5oPa2F4?=
 =?us-ascii?Q?V6QhWyf8uUH54P5Xmi7P2Jr5PDdxBYs5wL0p9TMnTEaZ9mzlKlLg91nRhkie?=
 =?us-ascii?Q?bE3JOIOQlR8avtXCZN8k9mEVkdB7hXWRgfDUToaunQin/C3CAuOU7vj6iYRF?=
 =?us-ascii?Q?zhBhVBAHWtsPc6B+aUecVdpvKlsesn5quf4A7qPgDogMOrQvO4pN7BWOqisp?=
 =?us-ascii?Q?vUAHniecDj0eE4emE1K8BCLo1BEMPhV0OX0kix+mANvWoayTCM/EhEHVDVDv?=
 =?us-ascii?Q?GW5NcuR3V2jm+SB5uu03Xsm4OtTT0jDGIGudgaRDPx8biAEk320ya31XiY8Y?=
 =?us-ascii?Q?NZjnNrFB3IoM2hRTRX8r7zlQQ16uNDwo/zYIbUdv566SyXgSrNLfvzUjj76L?=
 =?us-ascii?Q?mHGVVrMhnRqgNNDWE0iz6WyAjyv6MEWP4r941Dd3yO4aY6wsQgSoSDrEpUip?=
 =?us-ascii?Q?uy3Xz1P7MQuQzcHMGeEDVjPq1iHsP6NRtd+pWUqoOH5LhS8yeHNDK7h7Mqrv?=
 =?us-ascii?Q?9snvH5PZSpRnhSDeWwA7OWeWtKBJfj2AQ217fvkeaVHSLSlPxaOYn1N/Vcfa?=
 =?us-ascii?Q?Oxn63OSGZ3wvn1S3khVvEKdv5ID8s6+MGActuI9idC+xEVP9GDMaa/KWCIa0?=
 =?us-ascii?Q?lH1AvUAHwvbIfiRnaKwYzf8M7Ao8petBx/Gzkrb6i1rkzxrKimh5Qu5Lp+9j?=
 =?us-ascii?Q?ofLi+1PxPuNnkIyC4jkKdidyRBKAqjUybM5GcarmrajDHcNAo/aGA+BbSog3?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e66bd33-ff15-4fe2-5891-08dab30007a5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 01:03:13.7725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJME+TRfMadCvARDuZyXWo8hQ2HUzhrBNxBUKLIZ+cJGJZOeMl1THej0zOkXJQ7gVz2b7EnS5aa98h83MzU3hGeqMvZZTwm1+VVV1MuMA+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_13,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210004
X-Proofpoint-GUID: SISF3_kro6IJ5yqCe-0q6sJWnSJKQivB
X-Proofpoint-ORIG-GUID: SISF3_kro6IJ5yqCe-0q6sJWnSJKQivB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir, Jan, Al,

Here is my swing at v2 of this series. I've taken Amir's suggestion and
stored the flag state in the connector. There's one issue with that:
when the connector is disconnected, we lose the state information, and
we lose the mutual exclusion of conn->lock. It becomes possible for a
new connector to appear and start doing its own updates. Thankfully I'm
pretty confident that there's no case where it would be actually wrong.

I've tested this without the final patch (since that one triggered the
strange dentry refcount warning) and everything works great. Now that
(hopefully) the changes related to fsnotify connectors and things are
solidified, I'll try to look harder at the sleepable iteration, and see
if I can identify why that's not working, and hopefully solicit some
advice & feedback from Al.

There's definitely a few nits and cleanups to be done yet on the series.
Pretty sure I need to clean up the indentation and a few other
checkpatch oddities, so feel free to hit me with whatever changes you
want to see, however small :)

Stephen Brennan (3):
  fsnotify: Use d_find_any_alias to get dentry associated with inode
  fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem
  fsnotify: allow sleepable child flag update

 fs/notify/fsnotify.c             |  92 +++++++++++++++++++--------
 fs/notify/fsnotify.h             |  31 ++++++++-
 fs/notify/mark.c                 | 106 ++++++++++++++++++++-----------
 include/linux/fsnotify_backend.h |   8 +++
 4 files changed, 175 insertions(+), 62 deletions(-)

-- 
2.34.1

