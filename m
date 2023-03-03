Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AF46A8F70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 03:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjCCCzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 21:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCCCzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 21:55:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813B1A674;
        Thu,  2 Mar 2023 18:55:15 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K45dd008824;
        Fri, 3 Mar 2023 02:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=9PkLui8kU1OSB8iH5RRJPzxM12JoWCIptIXPCVznQZ4=;
 b=HHkvmefLFGW6X4m3K/PF5KlBIg8/00tN4Yj2OTtpqpMAbuPW6JS5joaOZ3m9M65e9I5b
 keeipzjG21oqNTgw0ppCpGUGqwDLqHgK6O5UFpmk/rI1kTFe1BhAR8kGlm5sDM861Kzq
 orllAUpz0hP5yJ/jbecWjf0ccpKYhFkg105I8/2B7v7cMcXG5QkZz8b4E+2PnLZqge9C
 es70Nr6aCqEEisrIW3gosYkGo5cjzIyPrUtTKpy4JXBHHh3iPX6oD94tcSxvLP+tApFn
 itGsv2RFYCstPWgsFzY557DdlGO3xfsTBB1+8YU4NOLkUKtOtKX09jhu6C76hX/TmWbr 5A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba2dgpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 02:55:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32312NUu031278;
        Fri, 3 Mar 2023 02:55:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8shrb2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 02:55:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2eSviZ3waBMSfTqkY3hhDL9cgfM3IRX4tkunILTWFOmaAc4z/LiyyORm9eSvRpu9yiugvsdGI3Q6k7V+32JoQDMOag9cldPyIpHoaMAOloCNBEXOg4KXjfZp1qgA6+ZvIPIEtslK3DDWxNeMNuyKziu4y+hhkWMF/M0XCTtCZUfNC7aOcw3S9rHs7GrmBLRvMI4IrKgostsX7AEIyVOe0nvxftZzYMiOeQTBTzXmIUCJKAeuIhr0Q2PqGiA25MH5IDFXNZDqko6W8yyPpkk2dEBaQHhJTVK91Ac4q2PRFi9UhuEC60wTSbTnUIldS/sNg/EXaOei238QFj/36Lz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PkLui8kU1OSB8iH5RRJPzxM12JoWCIptIXPCVznQZ4=;
 b=ZWADsO2PAgySwHNX0d0L1R4tQKqQa3lpctB/1n9isqYbJ14RozZMo8QMldw9hn+Qfup1puEW5VnWEeRBsrUPDTtmiF831irntIVMuv3QR4sNwN/Ipcni3PkLDctpVaEY4+gMCeTSOFDA1EOxgEW/GLYWNgPlsOxbm5LsWG6JyiKiSJPVPvSkRThp5GpdZvfvA4ev+cS4hke0FyZX7eJ21xcZtyzysS9hBiskXSBkDMl5vPczkEBQWktQkWrg75gOTyEN5MNVUduWff3Y8s1TnqrPCoSh8z6Atojx4q1/c8pQdbfIajbTAZsd1uGjbYR7C0jlj59jhQGVd+wZ7fmS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PkLui8kU1OSB8iH5RRJPzxM12JoWCIptIXPCVznQZ4=;
 b=fo2vxaATu2eYMheMYkgbmj5UILp4mmrNrMJTX5MmqbAEPcalcJo/wpPd/8P6YRCLit33fURdo6ZZOpeVGWmTDZ7xSeKaeTCmPq8BCesIA25ptM+1j3QUFEHy6aUv96zAir6cRLoWKFS1WTXJoNxDjp69HgppDEIkI9RQwgZ9Ukg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB6391.namprd10.prod.outlook.com (2603:10b6:806:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Fri, 3 Mar
 2023 02:55:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 02:55:02 +0000
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1356mh925.fsf@ca-mkp.ca.oracle.com>
References: <Y/7L74P6jSWwOvWt@mit.edu>
Date:   Thu, 02 Mar 2023 21:54:59 -0500
In-Reply-To: <Y/7L74P6jSWwOvWt@mit.edu> (Theodore Ts'o's message of "Tue, 28
        Feb 2023 22:52:15 -0500")
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3ba49c-b328-4e0a-8640-08db1b92af6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prUzrPjWxJjGxQCAP4COz9yQlRKHQ5aUG6BsnEoTy3eeABGL3+yO489qY1Lt4eqB0rGXALlulC/GqN+YtGwaOsTsJF7q4244m/yI9BFI4Ux6pizucxfJht8IU0f90MWy1wY5mp2GncLXq/mBkWf/Ct3QxbMWP2UXsXeVKzzdw9dVK0tAPCmiGXvPpKS/dy4rni9osWPYLJUqljr4dXPI7Oos1LZh3/urlQ9g2oLl0jHqdxnA9xZHXDO4jneu7Kae4Fck1Zz4YrnbnXSpAW0/UShjdtP4i8xuIRGa2FYG8RT3T8N29+VigAZOEDpekChDG6lkM1GCh6iGHUZ8DuP+8mrb0XQjeZNa8qZL61WOMvHRuxchIdYocYpRhSJzOTrrzN5NGLoXd703nG94DQrYcKaqWOVymZU7tGJK6bMeikBSjp32XboaGRoCU76gJ66wL9W+40rqMaCclsm9M9+/1KeNZ7fXy+T06kC0502ykxC6A7WQt7fHVmo73qmOj36tv5TVid+FtYi3Dbw3ytk0M2LvewvzN8IqfdnsSX6zakqa2sUOJjxuJg9oodAUm1VJsx7HKS0Uvw97OiHMLUbIc/ZxtlsNl6oieSVCM4xcUECS/7CHZ2oO3QUDL1I0GPEXXe6L5e0P1/cmKjUmAchP3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199018)(26005)(6506007)(6512007)(83380400001)(186003)(6666004)(316002)(36916002)(41300700001)(2906002)(86362001)(6486002)(38100700002)(8936002)(6916009)(4326008)(8676002)(66946007)(66476007)(5660300002)(66556008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AhwlOnsNfbYQ9avuKaOaieMBhnVEWk+8q4kIuA4et6CX5odsOFrgitiBk+U4?=
 =?us-ascii?Q?aM0zk2yb4QRS5G+ei9J5KzlEoxY1ghRAkfk0ffu61t7ETQ2ZWxb0MQMK0Dha?=
 =?us-ascii?Q?tb+WhLvzubHNC7PupTsKfz+KOznyjidnp5jpSufzgO/C4uIlBe7px62mE7BX?=
 =?us-ascii?Q?PyEJ6kNWfDfQpd8IMsvZy4c4jtFBcIw/oIvjl3pUIPHrnRW34oDT0wG68oNd?=
 =?us-ascii?Q?at9hk2pwUxmvypD3Ss2UWkxWeTnkMghpYaI+rgrVY+dAG4hf/6OBLnMJPqg3?=
 =?us-ascii?Q?cCwDB+ijVeB9mK+UxsYqdgqnoHBgReIQkSFUZXqI+C/ubXzZYnhyCutCYn4P?=
 =?us-ascii?Q?ROzv5VrCGUnC0xbXSxiJbvNTbpsjCU8wbKmAKer1sz5AzDbAvXHyDAjdGGF1?=
 =?us-ascii?Q?nYN2FsapNTBAg98R26yC/SOhaoSPicKG63eD6yFiYJw2nDaN/b4xqq4xAvtn?=
 =?us-ascii?Q?80joYbuJJ2ELyUUhtAHJYqRzzHSlSypg2HgQQVzvfiQKu5xh+HPcL2IyEgR6?=
 =?us-ascii?Q?jge2HPfL4MFX5FifvBZqdze/kaXDyQFzet0C64I194ZM2XNjXm4Y7PffHB6f?=
 =?us-ascii?Q?mBYgyoJ6AdjrPR7gI9l4eJ2PYPjtXmxNlOuqr0kTbVRodQveu+Bfsmed707Q?=
 =?us-ascii?Q?qv9TkAGuv7EzVaO/irUbBS0CMOQGmLFGSvWtZMEYQjCE0H4AN9xvLTeG1vDn?=
 =?us-ascii?Q?FZ24Yf3vnRauou/rYYa8JK2u7ayJxYDnladnHf7J+DQAkvkWhw2SFO8jrFjb?=
 =?us-ascii?Q?RRgl8MCBkCDNvS/QVKkr7rjcojbkC10BJaUWMOVOJwoVzuTtcZiGVak6+fRn?=
 =?us-ascii?Q?JeqA0b2hxPl1+ux507QwVxG4ItxvSDxkPx9vjBu7afXVvd4HkIqjDz4p3lKx?=
 =?us-ascii?Q?kkHL/PVqBjYOS7qOQ90qmXGsG4XKrmkuhu8w5dtIoeNZ4IGpZXwubgu97GuJ?=
 =?us-ascii?Q?EOLeoNrzu2aHumhsk2jZD2S/gO40CTIbYY8FuhR4GF3Gqy8uc/1QeK7yIIJS?=
 =?us-ascii?Q?IXhzfxDCxQu6efooqaNJ++zDV/1TVQ3lrMWIutMqEtkd+V7JmVwr6xIKREvd?=
 =?us-ascii?Q?JYo5UNGhTQIAHZQEJyX97LexHl3jbInpTTTudguoECV6h25wl9EAsu66ljhI?=
 =?us-ascii?Q?yPO18EPXMn8TKUHSCT5ls5ngNgZg94FAVJe4O6fepoLQqR3XjHpnJY9b7t3F?=
 =?us-ascii?Q?8xO8hI7kwhzmlfc8Y5nCffqvBagBbg2odlvlSANCyJLltgvQ2/mtmHFcGkQv?=
 =?us-ascii?Q?n4LaLHQCBFD/8kcnElLcwbUOLG4k4H9wG9Jym4veGr5l1ww0PoTGSXQMWaLy?=
 =?us-ascii?Q?zTw4bp+wcGL1lyxQAwOFVkXc+hbia2BYDFfBkUCAw9Kj5LKXpLZgTRuzD4hQ?=
 =?us-ascii?Q?gyG+RuZ7xQvmypzP76cCfaCGybTWXQZvZg35QQMY5z0KKiMBfXrcBAQnhdQR?=
 =?us-ascii?Q?iHSP0WeJomdNqoipIFECZxQf+kX+Tfv/dWN61zdvkKM2RybU2/NOCTcgrZ/u?=
 =?us-ascii?Q?/Xk5eLGb/J3IYaevTrWVxFtEg0r6PFOuruSfBxk9BeH6NwEQ7B94uRBQTFGt?=
 =?us-ascii?Q?MfbuHNycrlaXn63fb39NGUJOD2waWwT5Dz1N5YSLZ+p4PH1umEMTMUNWlpKm?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HG1xU3FVhdJ33nGT/MzVs8YN4Ns2FUfJngaycbHGE8wXOl+d821IrYlRrWHzPlzv4FiEG6A2EUZWVSH1eOoNn6ONVFyHTrF5HvNxoAE/7XfjF1jpo2dyKtRXSeTJNBag/YqmKl/Ti2UjJviy5ES35gpugJy0qBnewSjwQ3EvNypK/x1fmLs/fZVC06n+Q1TgqQUoABGC2se22ntsQyIZYvJE+9cWUPQt/uLDv8UIxxeK2LKRFX3/MmTfOGNLCwznz7XnMnvHbJ2rgNXLOI6N/xubcA+5LvmnQ9F6N6Y1BmiVIJMuRK3dmPYaIsB/96rgiN4DchBbUy1MvNNAsv1jKDRz0k52tczUC9BUOP/tc2L6L6/LgU2VVmyk2tQUpd4+Wl6G74KyAravxi6UBP9QcXv791HKZIi5aJYANQwrrkkiec8oeExe8GH3yb6qeJRyZsn7u3InoqD8srNPx4Xt7jDYgv/qnhAZOlsV6AS9B06h7DbuYFECcnU6b3+UrPiN0/sNFSkjlH/Y6El3FPLE9Tz9QnU5AtnJjnzxC7zJsDt69AMU/6yosBM1Yf3Eyb2IF6EQtcDa7wqAmKAXm0llCjhRpHGjMRFYqcUbNdocrBenpY36fmuVj51QLmczbRwU8lv5ZGLnguYprDiek6FD7SjCy5wE2s3qWkeMImiypZOV7ZUBsCcHc8dKkgSN+bYmllX1cySq93aMn8wuxemusNnlEUeGQ/hKRKRJK3fbll2FrR9OMC+9ZCmNIjavk2yXJ0KYcZM6NK3Zl+ne92MvrNoy0Wia9t6Pvb3LvnOjOrd0BV7iRsdUQUrDtneQuRHoTEKGWU/DtVri/TSziEUKtGd/Vclvfcoi64MM4qLr6Tf7B5+T8/1gz4f3pMjaScl0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3ba49c-b328-4e0a-8640-08db1b92af6f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 02:55:02.7116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkPSpCb3L0JW48EnO7vKuFItZ0O0F+/6V7W/vwd6Plemml9AbPeOoxGcg91ygfylXwrHoBQolOfq9oznWaEYtGpDMgnsOwxhr7X2MVmRRhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=687 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030023
X-Proofpoint-GUID: fp8JgGzPrElqtgO4HIQG5k1RyOQMPx7m
X-Proofpoint-ORIG-GUID: fp8JgGzPrElqtgO4HIQG5k1RyOQMPx7m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Ted!

> With NVMe, it is possible for a storage device to promise this without
> requiring read-modify-write updates for sub-16k writes.  All that is
> necessary are some changes in the block layer so that the kernel does
> not inadvertently tear a write request when splitting a bio because it
> is too large (perhaps because it got merged with some other request,
> and then it gets split at an inconvenient boundary).

We have been working on support for atomic writes and it is not a simple
as it sounds. Atomic operations in SCSI and NVMe have semantic
differences which are challenging to reconcile. On top of that, both the
SCSI and NVMe specs are buggy in the atomics department. We are working
to get things fixed in both standards and aim to discuss our
implementation at LSF/MM.

> There are also more interesting, advanced optimizations that might be
> possible.  For example, Jens had observed the passing hints that
> journaling writes (either from file systems or databases) could be
> potentially useful.

Yep. We got very impressive results identifying journal writes and the
kernel implementation was completely trivial, but...

> Unfortunately most common storage devices have not supported write
> hints, and support for write hints were ripped out last year.  That
> can be easily reversed, but there are some other interesting related
> subjects that are very much suited for LSF/MM.

Hinting didn't see widespread adoption because we in Linux, as well as
the various interested databases, preferred hints to be per-I/O
properties. Whereas $OTHER_OS insisted that hints should be statically
assigned to LBA ranges on media. This left vendors having to choose
between two very different approaches and consequently they chose not to
support any of them.

However, hints are coming back in various forms for non-enterprise and
cloud storage devices so it's good to revive this discussion.

> For example, most cloud storage devices are doing read-ahead to try to
> anticipate read requests from the VM.  This can interfere with the
> read-ahead being done by the guest kernel.  So being able to tell
> cloud storage device whether a particular read request is stemming
> from a read-ahead or not.

Indeed. In our experience the hints that work best are the ones which
convey to the storage device why the I/O is being performed.

-- 
Martin K. Petersen	Oracle Linux Engineering
