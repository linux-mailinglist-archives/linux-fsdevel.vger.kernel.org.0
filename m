Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097AA7B3093
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjI2KeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjI2Kd0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:33:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861C1BE5;
        Fri, 29 Sep 2023 03:31:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9uuc020187;
        Fri, 29 Sep 2023 10:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ZK0gpmW5aZsbAMF3hHcK+hVzbJCGHzP8MQHn4sb2/8w=;
 b=PecGEHHiD+qMsATlgOHkkVFJISEA6iqf2xuV+v4ZRoFJXWCsm7+uSQrN2yFreIpe4Nn4
 8oYS+/ohoFAndetM2OfH4yQZYPTp5nXeL4UJjRTzDj75swhnDdgfdop/FbHhD7787Jna
 lw9NwLwWoU3FvG2xBBP3n+DFF62dL0HeHBfbHX7pW5Qsuthpimu0j7BpdyxyA0I0AS5b
 k8fQTMaDnSNJwJdXNi2YT/197Igem7SBUtQdaArkgLT7i0m5Vshv6jxjzQNHrKa3M6NX
 1ri5nDut0vyap07vyri4xFnCqpNnU00yTIeAdD6+5wjRibJue98Zh9ydXK0jRtSdXJeg Bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9peee9w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TADLJ8014617;
        Fri, 29 Sep 2023 10:28:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbmmjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxWTDZcVA9DxBxOBED3CYYLR/oqcYERLAL/MFxjLMCNXChPe0YGclxbUlqzZCCnmHm5ZChbXFkWYLT5NdHMcuggq11ZUb+A8A2dOu71z0EmEGwW+mevuNUVX9pC4K7/xeARrEsqwGu5czF1cY2je+pPqTME/aOv5y790hZXaRunB8ZoNB7GhTPUYpT14Fpsgk4goGfdjss07skMNbUXnowqaEWhJZvqMveSYunfVPQWucPJ96DziLiASVxi0aJaS72/kZ4WIPmg5BRUkB2fm9eY0LzOZ2fNqCdgCiX96zTsp0fCkwTYvbLmOdSEj19tKnmpYoCHiIP/Ep068cnXtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK0gpmW5aZsbAMF3hHcK+hVzbJCGHzP8MQHn4sb2/8w=;
 b=BwXk+iPuhywb11yKRzfBtB2QaFE5pu7RyvoxDY/D5/3H6J2nM54RE2Gccaii2BIYjb8zkFhk+OHuAjN+eLOZxxaPsYoKtVBxQSQIM5MlIS7AftiSJNIOgdHkqa3EKPjBryJOrG7qt/7YHBuLqZMCFwVy7rTN4Rvd7iX+5Yg3S5gmIF0LGvO4P9NZ7FxkKNDlMK0NRPmOEWnnt32CxutcEPH3IHhrTG1w2I6zteOU3ndhK6WBgfdPt4P13KrE2P66nQCfdaO4Rgk2zVojcYobsM3dWJfZ9YoZypDQS1eyS7tKBvVEqRcqZg6y2MmsyAuK4gyWEYNNpy/DuKaN5Qz4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK0gpmW5aZsbAMF3hHcK+hVzbJCGHzP8MQHn4sb2/8w=;
 b=h4zJQS1sR/1fO0BosA/AaFopW+IvWqpw9x76OpCVf/jrwbS2mMeJcEaecHeFISRW0vO+5H6200coDDDMNGGH7TyJDJhHm2hktEKt8zPBIh4KAQf9MCDFcp40wwEVR8CoT2apI4A0d171fhhr6pj55JsIJHms/5yGvQ0AO1cUWk8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4680.namprd10.prod.outlook.com (2603:10b6:510:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Fri, 29 Sep
 2023 10:28:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:37 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 19/21] scsi: sd: Add WRITE_ATOMIC_16 support
Date:   Fri, 29 Sep 2023 10:27:24 +0000
Message-Id: <20230929102726.2985188-20-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:208:32f::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4680:EE_
X-MS-Office365-Filtering-Correlation-Id: d6eb0da7-57fc-49ef-333e-08dbc0d6d70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3IRrBQ9MEUJK5PvdcJB76THcmv48nyyEHW9SLg8VSZmhEqcMVOX6Iams4zV3qb6YJyFx4lh2HWzATHBAeVxSiBXfDN5/tHbk8Eo2B3Dbtg+iWcfnIO/GqWbgQvimzW0b4mIhZUkNHI/Pvpi81aEsPoKY7UDbgpiOuuBW0wJr/mXyyTipmhj+QSZUZrpsh4ezDmx6kBzBWD0RiLKyD+aR883UFxlkRTwuqBbyvvaCXQebecXXPj73zh6pnNhqJA+ewi1CrDb1ip+R9WCSL3mdUZOordMT8Ve9RnpNwJLjCGG+JLkwPPBGr3uUZ7L3gKyO5NLBSjIiFA0Th3m7J0WvtBb9CoSIi69/FTm8BakH9AdZtitCUgBUCC3fOmWLrKPcJMW0U/MzqJCsW/HFg0K5+tQtHOJHiz00iga2qIIi+Rb9F03nnO7PUOtmcmbdHlyQdQP5HdRSeufFEF1wG9r2h+4plIhEcQ1NR2T9LLmhMxXtpDvt5o5pJYJzZA23A8Dm9Muy6XC0Y+2NBkk8NnzgJFIMEmOuz5bkL5GUrldyL3cUwpAJfLB1UWbvYJl2nT69qebRa2Lk4pcMEWaWrQglMBgIRiB9T9P3/OILf9eQGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(316002)(66476007)(66946007)(66556008)(8676002)(4326008)(8936002)(41300700001)(107886003)(26005)(36756003)(2616005)(1076003)(83380400001)(478600001)(6486002)(6666004)(6506007)(921005)(86362001)(6512007)(38100700002)(103116003)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ZxHADICqktJ94tDEuEqIhTs6RP8khhQPmbu7WcB8edIAO9d83c9D3II3/z7?=
 =?us-ascii?Q?lk1y/E93QEFXigTAQkp5ZfryjyYvjrxw4+N1vF1buiY8I5ckIQrlaMq9YNr0?=
 =?us-ascii?Q?xcCMwwn4gLxvNwW8RTgirz4Myhuy34V4kkQLCNEDV/TdEd2+SqQi6BoPFNme?=
 =?us-ascii?Q?J5/g4tDtAlMUgsf5QtWToiqDpngU6P7nuEvnQG3mZm1yxmuWWhAvHGi/sCBk?=
 =?us-ascii?Q?VIUseXMCagH2I6ZxVbja1xrUPs4YCIRslRKizFzjxmTwOkUOSbmcNGr26857?=
 =?us-ascii?Q?AbBZJVlcZs5TSYM2k9ZkfFzLaFPHIg5G95pk+EnRR8Sfv5Rl8e1IYIFMIp1z?=
 =?us-ascii?Q?E2lmiEskBk7mHxZEyT8wJSFwBKy+DCz89E3jC9cKHSevkWGGxno3plb1kt+G?=
 =?us-ascii?Q?AWcTFISDLjZKwHyBDa3xbGTTZiHVtJypxKPsalv0IdhTgHDWK2lGwSNYMYUN?=
 =?us-ascii?Q?/raAjDFksxdidb2SWxQq8t3bycXWJi15XFjtAPIWi69k67qKwWbKiNeYMXm4?=
 =?us-ascii?Q?q67JRa6QKmWpcLUcaxbTh5tykXVLrClRoyJWlh9cnwTOMhBZv05aLmLrmdE9?=
 =?us-ascii?Q?5VLpNNa6yURcSGBtTgRJl4zYuT3oRx5jdvdcpqgDcZmuAislNdqqW5/gMRwY?=
 =?us-ascii?Q?qQukQBoceYB8xnjBydnM08FTANRX24ad1LNcK87srLV0lIuaijFEOa6ueyTe?=
 =?us-ascii?Q?Afkynoh3zXzTSN8H4E0jIbN4mg60XRZbk8GgcVX27Sx0aqSB8OdCz7CJcXAD?=
 =?us-ascii?Q?Ti+UO+utqCyq33orNLpfOR3yZq1OqTtYVZeZMM8TdXF5fO2P02VAP7WYnazH?=
 =?us-ascii?Q?5Mq1tTOC3PSIm9YnFC4izQLNyidYEU3oFifplzFgVts1B62LwPGJCCkTNVvY?=
 =?us-ascii?Q?XvfPevkwL8yASunBuUtDQ3mVugPjGHK7hEHGwWcAQu8oO+GG/+8xsvIIdF9y?=
 =?us-ascii?Q?WZBw2mHQWcTL/NJ61Hp3nWJPHJAv6v15bR48DFAgu/letGlx55V2GmMKhStc?=
 =?us-ascii?Q?aJtsLIdlcBtWRh+HA/B47ptFc3752A4H3aOmGdmEHjEUK2+Ei8hcODmHrN1r?=
 =?us-ascii?Q?cRGduNxkRC3kQijt91g1fqF2t8jGVFs28txG25J0SwcSlf10nP3NhZxEVGzC?=
 =?us-ascii?Q?JUwV+ZkVqJ6zFbGbGf6lFRBc1SQt/aX7gp0PLnUxKkeBhSkwwKAYAJTxL7M/?=
 =?us-ascii?Q?SSQBHSijwNmtvjdGmoltK1AJwQpGUq+WDOpXyQzjzHMmrTwFLQsY98UJj26q?=
 =?us-ascii?Q?Q02o8DFO7ZmJzClixLA5CFSiQB+odhpq3jpJDQSyE4k7Cq/FKoGlR8Q5MlJJ?=
 =?us-ascii?Q?6X7RcKqy1w0TUd+lvAoQnr7ahUQqswrUTJmlXusuY66XOHu4Hwd217hfx0/W?=
 =?us-ascii?Q?kWUNvTB0VrK5NsFxGlr+/5pm5h/MASA8qWwuCGH30iecMvejwEXOHkKLtyf1?=
 =?us-ascii?Q?uNevfq+zNl26nsVOs9spKCzidvkZEq8+FbVcT9ZUjqYszA+j8whzlVo1fE5u?=
 =?us-ascii?Q?KzKtJ95WMF00wW76w2f1ooJVI97NhOyyVAAEdypLos3MeV5LeKReaGjlVKVM?=
 =?us-ascii?Q?ADaLoGHWtDlYWpB6Xd6fPQoBck0vdt1klNlIMlssdnyxOrlwG65OEo4+jNU8?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pSaBcK/KvbsF7iQz+7zjWEXGPzyyIx6qIhxD55rdd0EyD8p1op3Ht97I0+hF?=
 =?us-ascii?Q?6X1Kwu3otxLu1YDzNTIe8Dkg3lA0FsLtaOxpG+4LHhwR1JTm4kvjZIYCZTi7?=
 =?us-ascii?Q?u+Y1CYiP1xaaqkFrGuO1c8UXfe+qgkHFF6A125aDuwOmMXc7erNuT5D2y01p?=
 =?us-ascii?Q?TuWteZPo0/NNZSrsXVaT1bfCRkhjsGybiY3Dk/FtfmyZJns/arOtrfPr3xjV?=
 =?us-ascii?Q?3XWNe6TyG1RvQnAw4jxUBgGGMLSsHqyi0JELTrEvNdLE6tkA6aUs/sjygTOD?=
 =?us-ascii?Q?GeqG6lT9zSzvRNuFeCTp4BunqZfknVSn135aGpt2mgqLwZ+FzrYuaOswH73R?=
 =?us-ascii?Q?qvPh8y+k7P+NoamcWdL5poNFYb+f4dXXunhdwV43bmnmdxGTCs5GTjGqAMfQ?=
 =?us-ascii?Q?LQitMCfPYHsd1Kgey7IAHEz6+JGCQ9zqfsr3E8PxvDPJpBPaA/lEOnJOQFcW?=
 =?us-ascii?Q?kvyOpsJsfwdPsVum/zhPLN5lCitF2biN9PeZrZ0rtrkmw1YLqmnDFUEuNRL3?=
 =?us-ascii?Q?Wf7RSPjfWNrPjUildtspH+YbQkQxp2DgPqvhUO7otfNcIZblLkNLA0Up5r8E?=
 =?us-ascii?Q?H5OWLmQKfB1aXObX3m3X0xwzlqKNgwbzwTGEQmi/+VKOiMTEGRQXUw2pIxMd?=
 =?us-ascii?Q?rTF0gvqCSs8yPzN3LZgpoUbMskjHMppFkwsApVr8w1IcM48z10LtAsF0aKYQ?=
 =?us-ascii?Q?03DG7Cby5oQD/9feXezD+R/DHz7Zx8uWkFUpU1HAbmQtyIW/vHLY41INKpPW?=
 =?us-ascii?Q?K+N7py4PqXZlq6zu3hakeoUbHz/wGhsdpeFX1++vKn79NoIoshf1QVltsbQO?=
 =?us-ascii?Q?GTKiFS8ZwiUMpOtzbWYxQ2ocnOYN9YfBxNF+ZzmAZUz+ns7aPp3cqVswv93G?=
 =?us-ascii?Q?TY0fvoDKn5aVS16zhAYo02AYHHQMcqVKWtWp0sC5ni5OgcT0RLf2WZlDcgLB?=
 =?us-ascii?Q?QPXQDtgK5BD4o5T0xycnHsuSvt3fuurqgyOCKbIZtcLvgqS+mi6OgnixnJI2?=
 =?us-ascii?Q?XxNMF4VLYv12cxztAZNxblYsRXb7s3brwFw8WZ4ZSNiBNo+6UUTw3t18vpV5?=
 =?us-ascii?Q?OEWe8flLLOj8y7VLqorilrfSg64+vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6eb0da7-57fc-49ef-333e-08dbc0d6d70d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:36.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0r/8pY4gBmR7cnjJ6mpkNWsrYWENv04dUTsaGPrFM9GYYbsgObzlZ+eRrtnaqR64KcxfwPEUf0BDl9vRGwwow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Proofpoint-ORIG-GUID: tTEXTMgXbzbcU0wirQHgbjo1eBKDivVo
X-Proofpoint-GUID: tTEXTMgXbzbcU0wirQHgbjo1eBKDivVo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add function sd_setup_atomic_cmnd() to setup an WRITE_ATOMIC_16
CDB for when REQ_ATOMIC flag is set for the request.

Also add trace info.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_trace.c   | 22 ++++++++++++++++++++++
 drivers/scsi/sd.c           | 20 ++++++++++++++++++++
 include/scsi/scsi_proto.h   |  1 +
 include/trace/events/scsi.h |  1 +
 4 files changed, 44 insertions(+)

diff --git a/drivers/scsi/scsi_trace.c b/drivers/scsi/scsi_trace.c
index 41a950075913..3e47c4472a80 100644
--- a/drivers/scsi/scsi_trace.c
+++ b/drivers/scsi/scsi_trace.c
@@ -325,6 +325,26 @@ scsi_trace_zbc_out(struct trace_seq *p, unsigned char *cdb, int len)
 	return ret;
 }
 
+static const char *
+scsi_trace_atomic_write16_out(struct trace_seq *p, unsigned char *cdb, int len)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	unsigned int boundary_size;
+	unsigned int nr_blocks;
+	sector_t lba;
+
+	lba = get_unaligned_be64(&cdb[2]);
+	boundary_size = get_unaligned_be16(&cdb[10]);
+	nr_blocks = get_unaligned_be16(&cdb[12]);
+
+	trace_seq_printf(p, "lba=%llu txlen=%u boundary_size=%u",
+			  lba, nr_blocks, boundary_size);
+
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *
 scsi_trace_varlen(struct trace_seq *p, unsigned char *cdb, int len)
 {
@@ -385,6 +405,8 @@ scsi_trace_parse_cdb(struct trace_seq *p, unsigned char *cdb, int len)
 		return scsi_trace_zbc_in(p, cdb, len);
 	case ZBC_OUT:
 		return scsi_trace_zbc_out(p, cdb, len);
+	case WRITE_ATOMIC_16:
+		return scsi_trace_atomic_write16_out(p, cdb, len);
 	default:
 		return scsi_trace_misc(p, cdb, len);
 	}
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 7f6cadd1f8f3..1a41656dac2d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1129,6 +1129,23 @@ static int sd_cdl_dld(struct scsi_disk *sdkp, struct scsi_cmnd *scmd)
 	return (hint - IOPRIO_HINT_DEV_DURATION_LIMIT_1) + 1;
 }
 
+static blk_status_t sd_setup_atomic_cmnd(struct scsi_cmnd *cmd,
+					sector_t lba, unsigned int nr_blocks,
+					unsigned char flags)
+{
+	cmd->cmd_len  = 16;
+	cmd->cmnd[0]  = WRITE_ATOMIC_16;
+	cmd->cmnd[1]  = flags;
+	put_unaligned_be64(lba, &cmd->cmnd[2]);
+	cmd->cmnd[10] = 0;
+	cmd->cmnd[11] = 0;
+	put_unaligned_be16(nr_blocks, &cmd->cmnd[12]);
+	cmd->cmnd[14] = 0;
+	cmd->cmnd[15] = 0;
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
@@ -1139,6 +1156,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	unsigned int nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
 	unsigned int mask = logical_to_sectors(sdp, 1) - 1;
 	bool write = rq_data_dir(rq) == WRITE;
+	bool atomic_write = !!(rq->cmd_flags & REQ_ATOMIC) && write;
 	unsigned char protect, fua;
 	unsigned int dld;
 	blk_status_t ret;
@@ -1200,6 +1218,8 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	if (protect && sdkp->protection_type == T10_PI_TYPE2_PROTECTION) {
 		ret = sd_setup_rw32_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua, dld);
+	} else if (atomic_write) {
+		ret = sd_setup_atomic_cmnd(cmd, lba, nr_blocks, protect | fua);
 	} else if (sdp->use_16_for_rw || (nr_blocks > 0xffff)) {
 		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua, dld);
diff --git a/include/scsi/scsi_proto.h b/include/scsi/scsi_proto.h
index 07d65c1f59db..833de67305b5 100644
--- a/include/scsi/scsi_proto.h
+++ b/include/scsi/scsi_proto.h
@@ -119,6 +119,7 @@
 #define WRITE_SAME_16	      0x93
 #define ZBC_OUT		      0x94
 #define ZBC_IN		      0x95
+#define WRITE_ATOMIC_16	0x9c
 #define SERVICE_ACTION_BIDIRECTIONAL 0x9d
 #define SERVICE_ACTION_IN_16  0x9e
 #define SERVICE_ACTION_OUT_16 0x9f
diff --git a/include/trace/events/scsi.h b/include/trace/events/scsi.h
index 8e2d9b1b0e77..05f1945ed204 100644
--- a/include/trace/events/scsi.h
+++ b/include/trace/events/scsi.h
@@ -102,6 +102,7 @@
 		scsi_opcode_name(WRITE_32),			\
 		scsi_opcode_name(WRITE_SAME_32),		\
 		scsi_opcode_name(ATA_16),			\
+		scsi_opcode_name(WRITE_ATOMIC_16),		\
 		scsi_opcode_name(ATA_12))
 
 #define scsi_hostbyte_name(result)	{ result, #result }
-- 
2.31.1

