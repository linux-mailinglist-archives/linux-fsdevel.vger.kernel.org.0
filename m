Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6447B306E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjI2Kci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjI2KcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:32:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCC319BF;
        Fri, 29 Sep 2023 03:30:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9TaS022472;
        Fri, 29 Sep 2023 10:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=wKQnTlekCZ9343QFec+axFCxLhLvHWxYR9RAFTQeMpI=;
 b=ycPLbL/udujskk1QzMLVVaSWSRPQ8MsATNKJGbx7dNnbYa5yI3Nts/liE5eum/qu4n35
 leOVXUkwdYAzHjwl9FzclM6zubAIvdYz2Waz4+36ofAX6PKJF2QQiUpIznhDqXg8KuXp
 lK8oE0hpEQe3x9jhD/lQJxRmSQMC1VPG9p0LLiYu2pWkXxwwzgmJ54WmY18MSzsTw5uG
 np+u8qhvgDZD/COSAaXB4P51vLUEOmEMBStB6EyC9ZXX3Np5EoH1NppJtZseuTqbdVW+
 IvQhpcEijGR2zTIocLzoXMRjJupbOozSSF9zG/+gEQAhL7Sz46CcGMH2ivp9hO/PyhCA 0w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbpbqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TACjjW040728;
        Fri, 29 Sep 2023 10:28:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfhd6r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Acus1aaAqtjTtHhNbHl9zLj/0JuvMMURkmIotntxYPSl9+b5Y+FodjTouC/u1KwjA+9NdPjQzO7o3h0BvNZoFTn7Pm7WhqbD3oSLPcJwi+Syqnk+h4D6LVVEXM7zC9/pWLNmmPf+fQz3hD4KkaiZnjnoD6UfH479T1zR2EuhNsxcGJVJgntjJ+u/CJCdHcMUl6AiO5rhZCmXv1eri9uMloKyP+DBojhElak/CpxbtHp+vvKarD41ALqgPpku7R4dDzfJ013IVk/WtGX6HkPUsdEQbQuozGdbqaqtuIMBEd3I+jWmZKLXv2r7r6N8WgwDz6DRUDlclNuAmHcaFLcVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKQnTlekCZ9343QFec+axFCxLhLvHWxYR9RAFTQeMpI=;
 b=T2OduUHq3NPWGwpd1j59b0eJ4QPmUwC1XQAWknBSuc6GcNMFswzs39kSmY6xIWZBXHBWawMqyBREGLBSpbX+Y3c2KCIaeXRJrOfirC5AI22IO58ZmlzHjstQY5zBYhP2l+iLzJpwl2LkRwRnScjAuxSCe4G1zVgt10u40wmfVX6D6LqyK3SXN9bnUTfvnOgBCkTBPASrmv5R3Jg1tsZGOSks0bbqeuFVFbLGa2qznkWm5XkAP4yJnc87rG+IQ5vL1xSwZYDoFEZJzn4VSlJEZz2VZe/uqmFE1UJGSYYwvui0kjdTLNmQcCY4OKmdqEeQNeQmjva+7vauSd07uVwBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKQnTlekCZ9343QFec+axFCxLhLvHWxYR9RAFTQeMpI=;
 b=EKIaAeO/RmlkjET/pVbocOyUaV2Wne7r4/5AoqDg7MQHqXsSqDWf+JeyyftUeIReet+OwiAlw4SLYkfbVQYuemPPFtWdEFZKUasC8Vzj/B6ZCq/PVjDglDqI4U3XdP1H3o1xSx/Et8QQFYSQ9bdEXfDVZmQgLNYR1KgbfaRN+7g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:14 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 08/21] block: Error an attempt to split an atomic write bio
Date:   Fri, 29 Sep 2023 10:27:13 +0000
Message-Id: <20230929102726.2985188-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:510:323::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c10223-5fdd-4a26-8767-08dbc0d6c972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xOgy44rwFgN+M6CH8ZK5cBcZujGZmsxOVyM51wctQ3CB/+WnP8pB3q7E3zC7Lm0TWiIQXZ7UtnZNhgdyxaEZZ3oQ7NocofcHz8MWzdn7YbfHojVfzAPIyWW/NwcLQrgX4ZkxexbHwB7SmZhaQwCHTukFINmV9xQNNjT53P8pTiQPNaTlR+vD+nzc3YGzwgkXWVtPCzuvjBZFthcjqWz1EFBlCyIWrK+p7CGRA20HB4tKRpydV+N/Dr4gJhtfZZ6DigrNri0rqsG4BOnoTne6qFcnFdKWZKLt5LVYo0elPRgRboFWEH2aGKxBGWlMmLGfeFZEZmlBOaJs3PcQ9xBTYQlNVEIalWYgnMNFNX9fTxuiM/PUQ6KNIi/4FRu0ItQDIVmFlMJj9DpUnV8eViUV2T6nKqg5bZJMW+rvvneKFTJ1PPTWU27nQlx5hUuMA7u0w9OPc/NcffZw1GEdIZQKrdPRwrBTyaSJQ63Rg72Gli04kQ/mr26OfIMDegRYTaZQ1TygQGLbrb3CiOX86tsRcpNLhejuCAM4tcH1H+Ajp0pvHEFXD3kpwmS2qG2MiA0dM3EjdSBjF3+LKU+R3OfqdodQx8mUP3NTrj0i3IrMH6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(4744005)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lvxd8LEcDiqsdyT0+fQGpV6XZOXjo5u/kzLshq7+xBpgnB0q5W54SpZzfWP6?=
 =?us-ascii?Q?0abVQkJ08M1xLYIP6fV40aVaa0V6frm8UVlZypbeG0tATbqab8YCWAnAxXhF?=
 =?us-ascii?Q?eR8NrCQVF2T/qcVC2nJ5kcHx6cG5oaAYz/htGi5JZ8w8S3YlaYSWBiB6Jk0s?=
 =?us-ascii?Q?AnG1nyPk+llM1gukxWEAuc7pWClh4lngoWoDAgRq1V2zVqT+JrCvuayh0i5y?=
 =?us-ascii?Q?4EACZbwqcUeby6HbQh++K4Z8DyYzMsfMk2sec8EV9we8QkKs/D41yuwzTcnl?=
 =?us-ascii?Q?kU3LWzQ6YCnRv+ZeQAh0pJFQq8TyJx6GJFq+saIJSfK13yEv7cCPW4vytp6i?=
 =?us-ascii?Q?to4Yxnc963U/aPJT0p1VcnW/5Ly4O1g8POaI7bc3C7RjvR9eiQ8C6YxT4oi7?=
 =?us-ascii?Q?Ak6YKxcJUGAgHhYdF8hegH31JEvGe63qhYPwQ6hemEjiG4d24wQsMCkmZBsy?=
 =?us-ascii?Q?NV+VaUKqpd47kR900ivQBHacfYXoJ7sEkjEBYpXO9UUbL1V1CP/H445IcUSC?=
 =?us-ascii?Q?/r7zVM0PhwK/+Of+dhVVjyCbVX/mK+J8CImz4iGY9ziwSFtQT2P4OU4qRiKX?=
 =?us-ascii?Q?f9mNSAjM57wBRNjYgjJDBH9DsQm/CLjKkqHoSU5sWmrFrDeakdJMxs+O6VLi?=
 =?us-ascii?Q?pXPY6tZDERg9EWrP+uHtmwAEVA0lPim+CUud/BW/jn6kb7IbH0BxncQJtkRr?=
 =?us-ascii?Q?nbvQDskrV90GgHFqwECTX2ZL9836G7dtNvCfwSN4CX1/WpsQE/laoJVGmL7/?=
 =?us-ascii?Q?+wV3LTd2meFBAAnUIEXT0OFSrvlIESVIfW9qhQC0wGY9NmKtiGkspi6pOPGI?=
 =?us-ascii?Q?zheH87g7Hz5da7gDQPrx40EKX7sBq58sZEnbar+AT7YIRu+jLF4pD8PnXfJ9?=
 =?us-ascii?Q?kYyotA607wOspWzCgivG23ahR10d+ZFjz1hcFPyfMW2rLRzYi00NCBF1bp0e?=
 =?us-ascii?Q?cIrdh2nEvy4cC2/HjjoFdPWQeSQI6BJutoEh12RNT1vEuvX3FpwkUabRVNs1?=
 =?us-ascii?Q?P5+bQhweizr8nxLuJTEW3BUQacvtOvAmBIs0yrA08ZzeES//zBy6FVqTPuEl?=
 =?us-ascii?Q?BZuVi00F/UMjt/Q/VownRXtWPGcUy6Jv8fpfbX70l/tAkOsssRFquUwJvTu1?=
 =?us-ascii?Q?DUTMu/JeJ6LBbewqF+UMXX0fK5PCnih7zNYyuerf+j10IBEaepz4W+Mk3aPB?=
 =?us-ascii?Q?u7G1TAavZfoCcZKDuLoFKXrXzuW6yrgUc0taGENFWdlH8WyQxnQc8PCbUf4m?=
 =?us-ascii?Q?JiOUXLGnPdVq9WSUML2vxasqldZbI5SDgp6ccaHolZca8lykNBF+jb7k3w3t?=
 =?us-ascii?Q?3i2nCVOKxX+t0mqd8dsVICl6aNhfr9nUNtap6fqi7a49iUkSy55P0VT8Xdy8?=
 =?us-ascii?Q?4LChtHoNueMO1md8kLMFW/DVVt/L7pbxSFIKrm3bhmGtClTk6JJaEzysa+or?=
 =?us-ascii?Q?qfYW2/zYZ68seBKT8JNb8s1QFGluG8z+9BEzb0HqUxYv04dmnyBysfLtLAFY?=
 =?us-ascii?Q?BdncQtDWmyMHDK5CaGd3IL6fXoBf0/KJO4GBKplCRuONzKWB92ENkH/ol6WI?=
 =?us-ascii?Q?4pxG6qNmqTVmDSoHesYUxir09FZkjX7/6GgYgkt+FhYswYNfP4HT836nm7LO?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8jsPgEGEHt3HFDd42JwW6+lnWf0yvbnoaxvVXnTTsuNMSlLv08fbhgxN8WZ4?=
 =?us-ascii?Q?NJNcpVzdDU+HC07YBHT3jrJH1ev2+7WH96gHzV3ypcA2ScRrMHAgYgTxj49J?=
 =?us-ascii?Q?6QrHdruSxCdaASDktXt3UwhSZIsQNWi9O/sfEYXb1Kt47fu33SGg3no+vKhp?=
 =?us-ascii?Q?Lk90E7/QNu/vl4Yd6wpP7wkBsRiTw4K+2z024jDqoiD+cviJRGVwRA58T56G?=
 =?us-ascii?Q?kfzkoeyljFIfDJtjHPtb+nHbEjxDEI+HLgoliSL8cjKAteNlJ4FVtBHkRnBy?=
 =?us-ascii?Q?R4lcf7OY9arZriK/iBDUjoPftnQY4cwGCgesj3UNTdwmaobbipsiwWynguYX?=
 =?us-ascii?Q?dZI9hF4gf1uZpWqqU3gOjOstn0wtUP8MLdy7yXXGEfIIWPtyFEC5xhKmwAiy?=
 =?us-ascii?Q?J01DgKGtp7IUpzZyt/Orj//NJhuGU/bTHs8cpKYFHSpYMgEJX1G/OZ52xoye?=
 =?us-ascii?Q?KfgeXx5uW75fRS+SEy75BrVNzW/uucf2NbojNhpslWCCKtgzBbkAbeRjCLSR?=
 =?us-ascii?Q?CDxJ/OA/g+dg0a7E8goW+JRovTzUrvx9PWfVTvP2uzqgMv6B31HYF+aVXjEa?=
 =?us-ascii?Q?uqwB3N0ReDxBXGHx2vE4KJlVs0CEMXYUfBiPgb+f2DakC+G4DVO6o0B5hulz?=
 =?us-ascii?Q?tWR4cewSgxTrrce7p/bbln7ZFL1dvagTXPi1yD3phbLvRtPJHIORDwn8wX6g?=
 =?us-ascii?Q?T1CRDsd0ibK0cq/nXglCo4Lmbd3yv1oDgulo2c2Tb3/CXn92Lv0qCqAGBmvY?=
 =?us-ascii?Q?Qx1BXn+H7LAXnBTvMlaCk6kfd8yguDWOwhcwKkoqyIWwa4ajzB3IZMBNbU/M?=
 =?us-ascii?Q?PNWFvVTgqqWlh3dXXTEwRABmMvZwzUitFuUe/bgMPTbMNgd27Vq7um7TKKYb?=
 =?us-ascii?Q?KQOoSaGKJeGkDT3+yRqfNxCInEGRy9hpHNuR+dkHb5YSvANnhxMw2ZLfCT6r?=
 =?us-ascii?Q?60aN+nT7kSKT+iNwSji1svIS19uCFMq1EFqter0ovROYGXfp6qCl6A4iSpSZ?=
 =?us-ascii?Q?x7Z+ftO5L9YoWQ4PFvsjNrR0CofuaZF6xsVfl84d9AbCcbIDHc2lp5nxr5U8?=
 =?us-ascii?Q?QVZEPHY/ZYKMGzNDPq2eba0MLCai3g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c10223-5fdd-4a26-8767-08dbc0d6c972
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:14.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2DcfwNjykjswhdnr+6NCegkoxvTe6W+U2E77Q37Zgbx33cu9trQmNkJ+BRg3FMJbJTE4uDQ1K4mynvrSXM5rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290089
X-Proofpoint-GUID: kOJZhJd5YMZG4TBxHCQATIXUj-pY732s
X-Proofpoint-ORIG-GUID: kOJZhJd5YMZG4TBxHCQATIXUj-pY732s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As the name suggests, we should not be splitting these.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8d4de9253fe9..bc21f8ff4842 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -319,6 +319,11 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 	*segs = nsegs;
 	return NULL;
 split:
+	if (bio->bi_opf & REQ_ATOMIC) {
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+		return ERR_PTR(-EIO);
+	}
 	/*
 	 * We can't sanely support splitting for a REQ_NOWAIT bio. End it
 	 * with EAGAIN if splitting is required and return an error pointer.
-- 
2.31.1

