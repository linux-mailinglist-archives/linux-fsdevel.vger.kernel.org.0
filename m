Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE27B3076
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjI2KdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjI2Kcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:32:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB61733;
        Fri, 29 Sep 2023 03:31:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9u7d020163;
        Fri, 29 Sep 2023 10:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=FZl9JhWJFm8ds/0dVoM8Y0ByU2rRnBP5p0YM67SV4sg=;
 b=CY+VE4gVLWjut8K0Yt+3jDDukStXFCgM6EjRLAm6JzJILDbHirz5w/auT5orv6Xm4FGo
 tOby2uEIM1oDoFn0z4MmP+ecqSPrqHYtnpAulG41zRh9HjksJtvR5FoZnxUgTiDjzCQm
 yMz9gfGdv4/MaAdCkESkZWvoljNXIyD0GL8vwQ9uuxUsyr6jO3aQ+x3dr7qx8ErPT0vh
 gTGfSC9fo6R5/h4h6AU0pr0ykke6YLsOW5KGQE3KCiy9jXa9rMMPpoZ+4MrcndNpYUjU
 TRg1vPIbws9Quf7KrAajqXJ/974dFQAFTGNnBkZ8buelbOwV++lAX7JDmESH7McbkJJC Yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9peee9wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:29:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TADLJA014617;
        Fri, 29 Sep 2023 10:28:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbmmjj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOHa9+zZvvhSuCjwiGE88BbtievlzGt3yfvo2gqT4dIdI6sIMwKdTWzXoB93+DxosHLgVRPncm+2Ho/S/URl66i6r2uBIeuYEBsX36StHToq194rvgvMtJgMqJeQ/y0ber35i31RAEQTXFK/H6RvlwR4Xzsc3/xze1DRKZ5a1QxabJLtgRqtd2+XySYrA3Y1B0HwQCOUMCIVF2QBgYMoQCiTJBb2uRps6t9w3udN/snxUu1fJamY7RTiwE+i5Umu6JnpJUZ4dlQSdzQPYw1mHbdGhLng31e+yYMicEBMZ0kTMUZXOsKNRRF3GgHYFv8GjO+9KgeexhajgJV9FJuRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZl9JhWJFm8ds/0dVoM8Y0ByU2rRnBP5p0YM67SV4sg=;
 b=Bxkfsp5NunqVli18tBzXMXMr48a65zL6t539YhK1Tb/x8S9hIXEXiBGj8vAsFT5YZj9X6bqU8FumZsxLx4lcHMKBXA7BZLJL20PinkiUGM2pkQ+JgwcW95n+TNmSy38HW/mBsJRZ7XObql4Gmjk5P1N/Gzp08T0djMhJJsHj8mzeg2KuyLqK/ZdQMWIopEnM7i/me4tdrwUYIcfMygTAaq+RbRGX0i0K48v1wCVky9n1GQlEzGxi06CricuPbpBDhDG1BZimC0cOzXK0tcRcqafxzC/z2hFf3eywbUyDb/VLKSoi2N4ti7gmySLiBs7VAnYK/aa9Po0DWLMq4vMrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZl9JhWJFm8ds/0dVoM8Y0ByU2rRnBP5p0YM67SV4sg=;
 b=Uhgv5llyvwlCx34Ronx8iGZ7AMVK/iwcpJYfyHLjanlIKiBP1WR920bS10EEGWKN7Tm7+5D4Wk1e5k0KckgRIiSxsqedH+ICTLDYqR4G3sxTVbjDtpeuHusfKCiJDHTMot3z88o1NgM4I7ssDCzWWKY9A/yXtQeN3k3pPvrwIKE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4680.namprd10.prod.outlook.com (2603:10b6:510:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Fri, 29 Sep
 2023 10:28:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:40 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 21/21] nvme: Support atomic writes
Date:   Fri, 29 Sep 2023 10:27:26 +0000
Message-Id: <20230929102726.2985188-22-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:36e::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4680:EE_
X-MS-Office365-Filtering-Correlation-Id: 76345577-4b6a-418a-a0b6-08dbc0d6d8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uw13hMllyidPmiro5j2HZHhJLrqb8MYc4/CDkYNPoCFiOigNLCDu6l/YNxJfXGln9+RziNdStdB/5gp4bKNUZwTNyWl5dY8C3qHwtfa4aRuV1ONEZd1BFKtDrMAjjzEm6N3zN0xzmrQ/N/PzV8PnaGMQSReDvOr2sXDE30+MgGsK9yENm5+bZU6Oal4HAAOeeOyl53SNxGVzBL98Ruwte0h+giPE9NQSnhpcT3+cHwG/HBfEx9r4vdqLk1mfbfiwpiag61jetBJn3T/4RuKaDpVyu6KfCcrQvfovMMRkGchnPaHM6MktC39v0bFKDcBqpZ3SYaZlG069I7D3bKGgUNjijIXq6PDZjIaubmnE6HbYAAc6Af9mRtvsYxH8yi++HwGF8aI9CSvhgGaVaJ2eQCJSWgAao58zss7YuryyST5BbGlkgd/ufTzIVkolhSXOTmdfW9hhcRquylvy1K3ZxI317d2QuqWRZNTU10GZp/ixXovkKEwt2HsthtKexP2l5ixOZlOGUd9uPBWd026k3bt0eS6TrPxQZEYybvw8UJYlrZPhbV8CBA/sjIlUafwFohOYTXiL3P8jW+99acBFS/Ch4YdTZQKQbVDoUQMvXOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(316002)(66476007)(66946007)(66556008)(54906003)(8676002)(4326008)(8936002)(41300700001)(107886003)(26005)(36756003)(2616005)(1076003)(83380400001)(478600001)(6486002)(6666004)(6506007)(921005)(86362001)(6512007)(38100700002)(103116003)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLShOUaokrHyb6kSex/57BjOP6j5XHeHfRsmuu0WxZJeoRYYVMymYOkPLnRl?=
 =?us-ascii?Q?ZmHR550EBKG8ce1REiVRHClHQaR77YbY6/YRjD3WSusIRFAxSZTVx3mZBa7d?=
 =?us-ascii?Q?Ukjnw2bWYhPcWe2PQ53tRS68a7y90YQ9Gby8ug1nG8kAMxMnHKM6xbiWnm41?=
 =?us-ascii?Q?tfaHzjBq3dsFIFLdvhgfgHzBO645TvUIoRjXEB2QaNYiBkAhB1yZLj0SwLc/?=
 =?us-ascii?Q?YBV4XOnWNb6Fm983JXZid9FBUS1mIeNadnNVluLnUraIk6VCApiV97wRdrcW?=
 =?us-ascii?Q?Bgf7AqaRZISNuwCuLUuhrkNXeWBVbHevngTOV/WF8vssM79mNSkye/HF/sMF?=
 =?us-ascii?Q?Fsrci5BDjUCANKTypX2b1m/UuN/q1nhWl58YTNKcYJaUeJsK1/GYEP1pQTNt?=
 =?us-ascii?Q?FwtaHkYaSyQbF50yBckLsfVsut9Irh2rhLFu0PauwzuRQ+cFyPc4r9ZGQzdO?=
 =?us-ascii?Q?2osPJ4InG4Sky7ekj7i66SgLN3nOpXH6tbu3tfmTPi1IkTvx//0rWrhy7Vx6?=
 =?us-ascii?Q?z+ymLWeJZXQKIMvL/ylW2uCLD1vJ0ETcNCNbRMi0QJ4wA9dRD+x1RaBTkEUi?=
 =?us-ascii?Q?Q6I8KTxa0Ieu9SCRg8qaoC3vDYIeEujayM+35PIsZTBHbZGLIchWlECYkTTI?=
 =?us-ascii?Q?EMQfsQKrKxGExLmI9Xt2u9T/mWyEsdvvYsWlXj4JMGQ107rfXLMC1C/oZtud?=
 =?us-ascii?Q?wYYN6vDwwOUP5lGPo8zmfsja9T4v0MMCtMqLg+j47R7TenSKusnr/NoswW8n?=
 =?us-ascii?Q?mKaqzdXlxaUdtjVXAXUAlt17ITeLd85IDS/2JinsWbKo2M99tmWLcWmcaqmK?=
 =?us-ascii?Q?guiFsRNoR+cXn4s5xtbce+AjhAIPeqw6wjzmqOs6RQoDz0TynTqfH13zZZyT?=
 =?us-ascii?Q?GWUxXowrQvBomTyinUYo5QLCILRGs3XQuVRumLG3Vswn9zI8lDLtdO8gmpLR?=
 =?us-ascii?Q?wT1b+DeNAE7No7lphwgXczpH6nmkLNGS3bhGafHWFyOW1pNoz6klVQsdTJCB?=
 =?us-ascii?Q?izYuKEVhFZL1UVnrf6DgQ6cEOsoU0p3YA6vj5cqVgBUkt+mt3S6glVz8OdVt?=
 =?us-ascii?Q?9smpeIvuFlcBrhULVFjnAzglcVVs13/v9bGQ4Bj845sifxo+/QMUVXvu+C8v?=
 =?us-ascii?Q?Hyz9yNnhQiORE1A2RZhNv+jwcHliaNQB1uWGOWoEkRzOYxNyM7Y5P76oXl7g?=
 =?us-ascii?Q?aT/J0MyUfLSP4+6VrbwBQSw6au52J3SunsRBa+SJGSv3Ksh64tiPYYh0d9RA?=
 =?us-ascii?Q?7TrNNAkMcf7tfcA5gidR43C8EDbBZlTvizsqEJy+p0RzGbqzJmBzT5uTIXYk?=
 =?us-ascii?Q?dfti2ODq77X0BG9ewmJoHEYlnCSQztFA0I97z1vVKLTw/AiC9rjbeEx394sJ?=
 =?us-ascii?Q?N0Q/GpNM/n8CA2UjQZqudPJoUtikHmQssHgx/7LOkxpSHs5RFFUQYsPyE3eD?=
 =?us-ascii?Q?AEitaY31Mskdfa8C/ZAwZotCL6sX6Ww0oARWfCGTUL4Cgpks1Tg2BmETGtht?=
 =?us-ascii?Q?y623wc4MFpQgRu9OXarisT9jxGYaFllWUpVQ6KOq5nlmkd87y4wmPZ5mYhz7?=
 =?us-ascii?Q?+9LR2GxM1e0vYYNpJ4Qv/rwxPbQ8jJZ8fR85DIQwBs2YBRSzvoia/4YPu7Eo?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3LrikrejUN52TV7nnoH7dfcSWvNxiKA2WZuX6bQhmEC5EIE6IQId6AbBTMY/?=
 =?us-ascii?Q?dVkowE/xoXhBqyF/+/E4R0/YwZLeyukr6Vn/CNQNHUcm5XDgQvqGKekSAbwa?=
 =?us-ascii?Q?4q54NrlId1sm6MYUqib4c+TxwmfM4QTS7ui6LkBWFHATYHSHlDnqKT7kwyrw?=
 =?us-ascii?Q?MNApGSSuR3zZsF7XSO77fJUsxJIyN7QX2sKPJOnf+RR+ZPYAlVFlYhn0qU6N?=
 =?us-ascii?Q?nfB6mAv0HUFby7UPcnEDiy3Ga9fvLGseGUfg0lv+XJay84Bu2dnIHZB/8JWz?=
 =?us-ascii?Q?NxVi4i+IwuYw9goDVT2dCFk+JklVMyJcpLm2V/rZ0wtFUoRnRqYs8Xiu0zQB?=
 =?us-ascii?Q?o6qRAxtw0agxTwKd6RVrIebBR8y5KhJ8ggGXl+iQPfltrOjgPreEM6hMhVG4?=
 =?us-ascii?Q?pZTCY+z/DUHvh63jVRqSGyRtnRRe+MdTVohXvRdy+HB+RPn+sweZ5qbAS/3l?=
 =?us-ascii?Q?y50VbauF9krcOUWnDKYdrU21VKZh4JPQxLHyCZqS3chodCgHw63tqwk36I+x?=
 =?us-ascii?Q?aEjke/Pt5OWywbM+s04NUwMGST8iO6aQjUXXM4+htZ6ayDyF0WalEH+ZUBrv?=
 =?us-ascii?Q?hfR8ewhXiBm4ZmfSY/JtxzjZ2mov5JYXyMxT4eEI5PdUYetZrLVs5iMsoQug?=
 =?us-ascii?Q?zu87mosUDnM+F4IkNBmbqucmd7wn5oQkZFteQARKDOpBKYjNGzyu0Q5a6Wky?=
 =?us-ascii?Q?5l4gXyFr9wcWFmdATuNVPzdVUTgX8Wk2pft02yu2ctiyrfy94dXA0WVGf+uj?=
 =?us-ascii?Q?ke3yMNIQKuSKAXy9Ixnx1DqPu+oglsjsWzL8cuS6csI+y5A6o7Ay//9ZvqpJ?=
 =?us-ascii?Q?oI9rhC6PFOeCGQHXD1wPxs45KkkdxzwE3AjSk0VAVwpZwqgWgsQgIYRPOnP3?=
 =?us-ascii?Q?QDDkg1bnJPUOOLUdMnZLvHC6hLCcqdw0vva/BfiRof1IYKIdJK2UXIWD085W?=
 =?us-ascii?Q?BqdsTuu3lmEn2AcG91dhFpR0iVI1BiMednpLKaPbZx5eYvm8pxPiDIAEBTbF?=
 =?us-ascii?Q?0pit3/QIF/qapqvwn8uJorExfYysNqcF4lzQnW+XAkCp8ideOf7rgmdv5pRh?=
 =?us-ascii?Q?J8qLVMFk/5GVsZT9XgdniNn3b7/3EA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76345577-4b6a-418a-a0b6-08dbc0d6d8fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:40.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLkhpuaDIZ9uacDVITn7BPz+d8Zvy7f4s560+aFK6nhSAEKR76IplmCmd/+Q8rLnaBlm0jErXMt1wP1uhMkGZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Proofpoint-ORIG-GUID: A2RTXmWZQqdEnpftcOxP7cHO2BnvgRXu
X-Proofpoint-GUID: A2RTXmWZQqdEnpftcOxP7cHO2BnvgRXu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Alan Adamson <alan.adamson@oracle.com>

Support reading atomic write registers to fill in request_queue
properties.

Use following method to calculate limits:
atomic_write_max_bytes = flp2(NAWUPF ?: AWUPF)
atomic_write_unit_min = logical_block_size
atomic_write_unit_max = flp2(NAWUPF ?: AWUPF)
atomic_write_boundary = NABSPF

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/core.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21783aa2ee8e..aa0daacf4d7c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1926,6 +1926,35 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
+	atomic_bs = rounddown_pow_of_two(atomic_bs);
+	if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf) {
+		if (id->nabo) {
+			dev_err(ns->ctrl->device, "Support atomic NABO=%x\n",
+				id->nabo);
+		} else {
+			u32 boundary = 0;
+
+			if (le16_to_cpu(id->nabspf))
+				boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
+
+			if (is_power_of_2(boundary) || !boundary) {
+				blk_queue_atomic_write_max_bytes(disk->queue, atomic_bs);
+				blk_queue_atomic_write_unit_min_sectors(disk->queue, 1);
+				blk_queue_atomic_write_unit_max_sectors(disk->queue,
+									atomic_bs / bs);
+				blk_queue_atomic_write_boundary_bytes(disk->queue, boundary);
+			} else {
+				dev_err(ns->ctrl->device, "Unsupported atomic boundary=0x%x\n",
+					boundary);
+			}
+		}
+	} else if (ns->ctrl->subsys->awupf) {
+		blk_queue_atomic_write_max_bytes(disk->queue, atomic_bs);
+		blk_queue_atomic_write_unit_min_sectors(disk->queue, 1);
+		blk_queue_atomic_write_unit_max_sectors(disk->queue, atomic_bs / bs);
+		blk_queue_atomic_write_boundary_bytes(disk->queue, 0);
+	}
+
 	/*
 	 * Register a metadata profile for PI, or the plain non-integrity NVMe
 	 * metadata masquerading as Type 0 if supported, otherwise reject block
-- 
2.31.1

