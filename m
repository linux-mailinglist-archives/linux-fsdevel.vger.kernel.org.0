Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6207B3035
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjI2K3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjI2K33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:29:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BCC1739;
        Fri, 29 Sep 2023 03:29:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK8mQn013122;
        Fri, 29 Sep 2023 10:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Ka1iYY3UMneY6hS80BVNT7BXo5ahZCOR8i+W0L/sm8k=;
 b=nAfKe5Q1KbbfOCylo3AMErOWyf9fCHVKf3H7Pqehgqoz4gq8DXYIE2TR4lYvtyZUTfVs
 iQvIjFkiF4cZkUZ73WVLihbG1uogkJTJ1BoDTZgfFhFtK46ed/acURqtcF7xbHHwKQZm
 279qZ4VJ4g1XCN8GlqdIt0sMGQzSBa6KsT+Lzum58QY5OhAWejaevDxPrY3ALzRXXVbU
 4/0+PxrGQG+PPmWmeRG8jY/8O+yKAYncDO2czCvNURhZwo/iPH85cUAkYjLBl7rTWgV6
 vRm73f/NlIEK/e+jKGS1XfrKGUKw/4T2zXoQGHSK7FG4Nk6G6ZOgpAiwg47RDKVSA1Gv 9A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmupe0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9iSOJ015821;
        Fri, 29 Sep 2023 10:28:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vtc-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKnO/vewQX5EH+DFsaanXxObBwCv+OkwoS39OKz55UJM6xiBFyapX4w+lT3EVwgcfMAk/n+50yVAmWypk8C8szwYiVQsT9nife1Oyjo6d6vlVL5cPJir3soZas6xy+ONH4qhnfZsgk1Wo+Nid8PY5Azm9sNpvz9vH/lxJFYWXSjNmIL4rSyHhmc8H34obJK2Lt3nZ32pXh9omZzmtXgqF3y30M7KdeLdqUEjhNgsIq01ISNec2vvB1BGg/k5z29pnJk+aL7TCN8AuY7C7V9OPAN3fBHBZEO5xFfhrjzhjkJT0xfbw7ZqttRJ634J1vSv9ywQGv2X63iGduKzyjLSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ka1iYY3UMneY6hS80BVNT7BXo5ahZCOR8i+W0L/sm8k=;
 b=Iz22mS060yosq40eSOZklzUUeUpNjOjgij/+4xjKKQtFRFzOd6xr/yUTITlI9O/YdmNWzYp9L+1vSX9FxQ4emx35pYvQwTON1563IrYR5/ECp9GR5ULHp28/X0GbWhzqUECADnorszhGrSdjzj4UUiWR9VCF3yK+EZTvWk4d6YhBhjNqcN/jYIZJsoWEDNpUdS5rEZn5ti69a46P21EEfiiHmCGcw4SJxwPyTU+/fK5V8ieF/UALOznyxuzaylWvf8EOxdaSrGKzPe+/Qc6XBtnHk8FbxupdZvel15PL4J7VvvfC1nlHh2AFUA20PfCk95id5YKQYL5esw80hNd0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ka1iYY3UMneY6hS80BVNT7BXo5ahZCOR8i+W0L/sm8k=;
 b=KCYdJAU10OnqySikN6Vqfw/sU8/vee71a1Qz/0OHbdAd87gzUwbeZWkS27iiRnW3TE0UIdGSWbHU8rUlG9iWUl+ahNwtJfywHXIE/Gd/ioUw0EupfULPb4C2KVgiLG0dZrqddF/bhVO/Wfkvgc4QXi6lwLhcO650w4uQNLJijWA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:31 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 15/21] fs: xfs: Support atomic write for statx
Date:   Fri, 29 Sep 2023 10:27:20 +0000
Message-Id: <20230929102726.2985188-16-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0012.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8248e9-8bac-42aa-2fc9-08dbc0d6d3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52SbcgTMoKRC5/MjvkZ9za5xW5t0sX/32xf0985yU8bUpG7Guj+alamQY7dVQAXhNvMsLd5AoFy0F5dECB+XVGCIIrjC+faShDo98hp7J/8UVxjOYjVU4VebsNSawbAQo1wLosIsOKsuZ2K1bp7hCoGKB6uT5R1igBySNRsPF+hQO5jRzbhF+IWRbNdjr1AuSnX0bhpXOMDicOYWeR82SNcUb2yc40GuB5nkdhWOaS3hwWHSf8pgBuKQ3lOpLjiGaCEvZssw4CdFuRwAxlckISeksvCqUuHkCqU6nMERVWWG+EzyHUw8p0RE97TTkfJmf/ejV2zwqtLoyulOR7Sh/Qpl0VJPtaV+dycKjf5tJ4f/bXJjTYVATMFhFc6FxQ654y8srzyRwTlABKlFKXI4hpZDzXHuxQCumgYW+aJUntEJEUOu6yE8v8wCY+/U0HzYhNtPox9gKsO1/cF2WJ49NMLjKu5hZarialbSoK3Wjg8cm3Ia4D5GVEcPgc7askrfJS1Jb4em6/plWI+1bOE0fmCmCP2s6l2BsQ8K+KS8Xz5lhoopZa0UykMJI+C2l8kUJtUdCgZyQ3tSlZjll4pR7XCJGUVX4lm6hQi234gtd0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(6666004)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N7hEqv0XGPdIhJo80CI0H1J3sQlsUyMoT8doJEuNpnvGtvZhLQatQ7MMqFpK?=
 =?us-ascii?Q?LFepACMOnX8jKVX68A5jubbISfHDwnSwpmlurC7AQNMIGKWrgfJbg7rfITiK?=
 =?us-ascii?Q?YvmWU+4i4q8I6wiztwlt1rUXjVtKOt/suPeCDYTJMgEwVzDEjQt7yZ//Nsg6?=
 =?us-ascii?Q?8YvPQAR7fsToMtAVA7JxIt0hSZ+QBFvqQNdnvslevFFwf4MqXZZobdgiqNby?=
 =?us-ascii?Q?lPz5il6Nw41q0GLCkIZzY30+AIgs3O6hR53dbEG+Kq2NhQUHNP57FvDjgqIH?=
 =?us-ascii?Q?hSN4co1rUvFdwiB1vRtyQM3389/EjxyOJR8bN0/eFqeOylAuA20r2fXgvXt1?=
 =?us-ascii?Q?G28kqQRuh9QDLpzfvIrhV3qt+nwncQy/EQuNYXKIC0okz5/AXBh55jot8wGl?=
 =?us-ascii?Q?VKNO2TxR1Gzet/OoPUdU+a+LQO4buX0mK2IfedoQxQD0chbSq6QmJGcctq1I?=
 =?us-ascii?Q?y0riIIvWHN1ojRphp3ypbqweNmSJAGvcTV0dUeQVm5+hCw4LSulbUngkbN6p?=
 =?us-ascii?Q?x8GQl5ZksjXT/rOqXziOlQW4DYey060vg1ThkRBjiJd0ebVOo//mibjTv9YI?=
 =?us-ascii?Q?yvMkCShzl5xNilymYifBsGRiOEyvCStSgiXbwThMIjEYzimCm1drJ+YmSgFP?=
 =?us-ascii?Q?F1n3v9txvY0uth6qsyMJzqX1b9PQn6ba/moCK6Dn9A3YL80kIoxZffgsyzXE?=
 =?us-ascii?Q?TAbnXH7qWgMqQ1sJLM8HSMpZiRI91T8AtVu48h7e8MPWW9LHzHj+ZHuoK6Y8?=
 =?us-ascii?Q?ndAw1Wts6qp3iE2/pvqHC/NA+PSYMNFWNXLbBwD8vKUTxTmzQmK7mzoXM7+S?=
 =?us-ascii?Q?gRX6pRVFY1kFYUiDjJ1gUa8firVbDxWMWL/W6om9kLfNrPv8uqrbpljx6B/w?=
 =?us-ascii?Q?e6nFS9LomuI+vXcd4x3ynoxhLVHuJYsDe5OxqpWkAaKS1thiYNA/c1iMtpZ7?=
 =?us-ascii?Q?d/OU+QuRiuIo4YRy8ei5JghGiX2RygahNQRMAU06FqzthBJpWUq82tqT1GBe?=
 =?us-ascii?Q?piCBKIJJ6f2pqsJtFpRE9su5B3KcKmYCXve/XGZzf6wCX8QpHXxsdCCRGIi6?=
 =?us-ascii?Q?N0Bh2QQ2PjqGFGYaBdXZEGSbrYJGrpMDfgKsfTTCRX4Dyy0M1QxoEJQFvixy?=
 =?us-ascii?Q?kz77tcu7WOU9eBPvDwDoJnsyQJioQB7f9rtDA9T+SU55a+GYFXZ0nLJiW5Am?=
 =?us-ascii?Q?OuQnPQB3VgC97j0RCGangLPZJ6olWaIMofOaF2vMfjDdmNbVbsIc9q9gaUis?=
 =?us-ascii?Q?zrtcMUzkHvrIu+9uLWiZkMedhwfhWSLjoKPMH5RY6H1w0tLqnxzIpEwT1kBR?=
 =?us-ascii?Q?kUBYdnc3Cko/M9wT8xitQSvlrUa+r0LcsK6YBj3162fw90W2xwcJq6AeGKNI?=
 =?us-ascii?Q?1eaZWIi3Pza6XK3F1iv3aDBTkBzg910HspSr+Id7B5jBlWd4d6Y3GruRmL1+?=
 =?us-ascii?Q?n3UFxPjPfBZPpZ4q6QvkZDThDvmNTqSB6Smc4Ktt5zEmlswCTJuF1XMy0Ign?=
 =?us-ascii?Q?KPOeaP6RGHuxZInUX+xxxrmRpRITbVg0ZcQpx0ohBYC3WLGrssf8QrokoFss?=
 =?us-ascii?Q?yWsBR14uBAPAW5Q22KM6KSwZ+xWJskaN+gu4o9GXx51OXmbewm0Rp5AS9F4l?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RE3p8reYZSefCXwAbWy3jb/o/Y1HHKmsROQVGRq0oHP4Ku1Xi+SfnLcr5Q3Z?=
 =?us-ascii?Q?r+ldfGuaWo3ibHhrjQDNF9XY7iON76WjvPBu5DN1r3SwdAEcEklQGR+zRGan?=
 =?us-ascii?Q?zHKBlKvjiJAd9lo+r4Su7VM7aP1e/qdTm0RIap9BXR58E4OaAPTzNXlqf84s?=
 =?us-ascii?Q?7zruhar7lbaM33osHFhwwkf7uc8rwaOL7eqO+KUiOVSaVE4eHZfQjTkbUxx4?=
 =?us-ascii?Q?kymTk0S4J7YOrjmMMBvrWgawixAT/L2fYCvXCLuqwMHkO81lQeyPW4h0q4mN?=
 =?us-ascii?Q?zIa7KRmWqYk8PgCjUdPw9a4620dSYmOwRtS2wYXCQ9uyL0fe82aVwFIl4uXi?=
 =?us-ascii?Q?c18OvU4ohmh2+48lN8e/I7gW7kGVmDmJ02onHHCkovIrDWNckwcUApk0Dhf8?=
 =?us-ascii?Q?2SkKhFDCg9mvoswnIp8FOki7+Jp1j44rSvbfHpubvjSBtLcUcLbCJufAmOce?=
 =?us-ascii?Q?PofZaPdLYOioel9WSKCiIFjsPQZMR7fhFNh7uskjdmDfwglRg7FQEFGxwf3a?=
 =?us-ascii?Q?CBlDFupbbLpPQRFFRBHKtvcyX5r5I6JL0Di8OjXj5p/ZJDYrMy1oMjabkD0j?=
 =?us-ascii?Q?zeW1q7jukB/LdHCOI5fvI9T3rYSdf1z4PVN4/jg/0A96fZ0XjnsILPJvEw3v?=
 =?us-ascii?Q?g/dzSVQHVmyU8+bq2x7bsmKKG1y9U4xzchaAJUqVJdBDpzwQpLjXcNXguQbl?=
 =?us-ascii?Q?EaZovfIkkr3MV8GWu2v7mSwWnlkTWm3CQ3r4rNKnNJ/Oozyc0n7dA0GSih7T?=
 =?us-ascii?Q?Lf3uuxSqF7M6hWaZksa2LQrmW2JLZkvRiW3w6chZL8AGbF37d5/4tUXSpRm0?=
 =?us-ascii?Q?N6pM3j8DNGrL8AS88cH3J5auLMnYxhWuHnFCsXu7t36kYFZrd1sO8OGoefW6?=
 =?us-ascii?Q?pBWUwluLVcDlA8S/jBYFRhyqrRwrJ9EyTglAxwZN55iarwYEFMQXxpwcKEb6?=
 =?us-ascii?Q?B2KEWlkQ+FZi8yOWHYD5/VFcBdVLs8aG5wm1BxQuG8qb45ck0iKglrs47fU6?=
 =?us-ascii?Q?ASuppjj99U2JJKgdDznE9MtrTovn2Ml3p+JDLkVQsj+MCODLkJZAjyYn5oso?=
 =?us-ascii?Q?uKzxzMJiP+uxplWhAphcRZx5vhZzXg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8248e9-8bac-42aa-2fc9-08dbc0d6d3d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:31.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCv2pTMRL5VyH6ZRk12cR5gYSJ62vMKehVYtE+ukQeoH4Q1hJuv72tfnF5W5h5341saKJRdlPUN3RKVX02aMKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Proofpoint-GUID: 9cYlB2YTRFj6v-Hq-Pg7KIkkasM7oUNY
X-Proofpoint-ORIG-GUID: 9cYlB2YTRFj6v-Hq-Pg7KIkkasM7oUNY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Support providing info on atomic write unit min and max for an inode.

For simplicity, currently we limit the min at the FS block size, but a
lower limit could be supported in future.

The atomic write unit min and max is limited by the guaranteed extent
alignment for the inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iops.h |  4 ++++
 2 files changed, 55 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1c1e6171209d..5bff80748223 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -546,6 +546,46 @@ xfs_stat_blksize(
 	return PAGE_SIZE;
 }
 
+void xfs_ip_atomic_write_attr(struct xfs_inode *ip,
+			xfs_filblks_t *unit_min_fsb,
+			xfs_filblks_t *unit_max_fsb)
+{
+	xfs_extlen_t		extsz_hint = xfs_get_extsz_hint(ip);
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct block_device	*bdev = target->bt_bdev;
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_filblks_t		atomic_write_unit_min,
+				atomic_write_unit_max,
+				align;
+
+	atomic_write_unit_min = XFS_B_TO_FSB(mp,
+		queue_atomic_write_unit_min_bytes(bdev->bd_queue));
+	atomic_write_unit_max = XFS_B_TO_FSB(mp,
+		queue_atomic_write_unit_max_bytes(bdev->bd_queue));
+
+	/* for RT, unset extsize gives hint of 1 */
+	/* for !RT, unset extsize gives hint of 0 */
+	if (extsz_hint && (XFS_IS_REALTIME_INODE(ip) ||
+	    (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)))
+		align = extsz_hint;
+	else
+		align = 1;
+
+	if (atomic_write_unit_max == 0) {
+		*unit_min_fsb = 0;
+		*unit_max_fsb = 0;
+	} else if (atomic_write_unit_min == 0) {
+		*unit_min_fsb = 1;
+		*unit_max_fsb = min_t(xfs_filblks_t, atomic_write_unit_max,
+					align);
+	} else {
+		*unit_min_fsb = min_t(xfs_filblks_t, atomic_write_unit_min,
+					align);
+		*unit_max_fsb = min_t(xfs_filblks_t, atomic_write_unit_max,
+					align);
+	}
+}
+
 STATIC int
 xfs_vn_getattr(
 	struct mnt_idmap	*idmap,
@@ -614,6 +654,17 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
+		if (request_mask & STATX_WRITE_ATOMIC) {
+			xfs_filblks_t unit_min_fsb, unit_max_fsb;
+
+			xfs_ip_atomic_write_attr(ip, &unit_min_fsb,
+				&unit_max_fsb);
+			stat->atomic_write_unit_min = XFS_FSB_TO_B(mp, unit_min_fsb);
+			stat->atomic_write_unit_max = XFS_FSB_TO_B(mp, unit_max_fsb);
+			stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
+			stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
+			stat->result_mask |= STATX_WRITE_ATOMIC;
+		}
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 7f84a0843b24..b1e683b04301 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,4 +19,8 @@ int xfs_vn_setattr_size(struct mnt_idmap *idmap,
 int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 		const struct qstr *qstr);
 
+void xfs_ip_atomic_write_attr(struct xfs_inode *ip,
+			xfs_filblks_t *unit_min_fsb,
+			xfs_filblks_t *unit_max_fsb);
+
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1

