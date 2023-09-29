Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217D17B308F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjI2KeD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjI2KdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:33:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6D31BEB;
        Fri, 29 Sep 2023 03:31:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9Qm4019170;
        Fri, 29 Sep 2023 10:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=6dpfvd4QexpFHlVLo6uba8WrCzFwMvYjqBcVe1g0GAU=;
 b=M05FVCy6ewd+ln/Y7Xow+rhOvmeL+Z2fLi0sVsDKCgdRcfDt6dy0ffTspj0KQHxvC5LO
 949zI3gHw6v8GP1t/BaOH8EEd2bMXQRFZSa4LidSrehcrKVSeE/74ysdIrLGQ3uWuYiU
 g6r61j2kjGNGY9iiyEjx3DjWgzn1ZwLVqODGPihtboJH4e9SPC5qJ+Jj9/zEIv7pv3oZ
 rEB/cLf3bSWWAV3zs/BaacmHnKj/EJL2VH9UCrRVxyaPPsmVEF+rajK06jW09qdei15K
 d4ebNBNjW3VEVMiPiRmsh0SdCJuAJxfv+Z8FQImF9ETa24ZRFlzVeE3zDgDmoumJwqii HA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjupeug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T81dGq004840;
        Fri, 29 Sep 2023 10:28:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbj374-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE95REGDQiyxCRUi8MAjAQYegi+DSBenwCP6U4+gFADN7HMoULFh+uNUgWKYEAy3ycsu37u5aNLF0YqW62tYAE2GE/4rdiOZcnmjLoJGSLUUQ9b0EwvBq3MCrm1XKIBDOtptWvJyDpe/+i9ArUkZ3wwwoeoSjKp5iLq3eutPCDC+nkxCL981f6dI2bOFUKa8iOOEnA+Gt3Rrt1Iibf2IeB7dIPPiSUQ/XOWYFgp3GSW/FrhvkhyJMI/UWwaCz3Ip4TGk5931GDSaFVExQXA+HoX8WLD6hIat412zpm1yZ3YDgXe8cf/3tzGQ/aDgvwqWU0UQH29UJmj6SGozVHZXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dpfvd4QexpFHlVLo6uba8WrCzFwMvYjqBcVe1g0GAU=;
 b=O8uJBAVFSXQDKa9hVySNzSmDO81HfkQ+NsRCC/86/ON3aJ/Vo4JZbTvwc1ZOA2akYRHo0stiytWZFuTkAjinR1IwwS4MhkQ42yHq1lJp+dWKYrw7YCruB34X81EB4u9E4smPPVU9vMXuJy1paX8mZ1K3j8Q7GNlyi+gwC/AUVJdGmqhQ6/g7pEuwWGq2/ylSda3dnhYE5XQzHCkqSLA3TEXwedr5ItWjm0r8dqcqNjVxG1SCxoCwwVfMfoG33vEJB6FSeK2ZbGEi9HN4E3LEuUY3Di6YY7yelpALQpR8kZPsvjbGSbI+a/ML6j0vcjesKxKfpVQykxMpfC7WKLDg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dpfvd4QexpFHlVLo6uba8WrCzFwMvYjqBcVe1g0GAU=;
 b=YRC3+yRXt+Szk6WXUVUpi6aHbAlY0CAU718tJ+y4l0zaAGEb6pHwRan1PhnpLMU5qXarf6ZlBqTrEEXQpthQ+Cg1ue8QRMyXrTioqFzJTUc+SwLQujbqYUwhrGc164Wz+2Ss0/uKqU1nh1flUyAeN9OvM4dyWujiLmfwtOSAE8o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:19 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 10/21] block: Add fops atomic write support
Date:   Fri, 29 Sep 2023 10:27:15 +0000
Message-Id: <20230929102726.2985188-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbf8b5a-a925-4b5d-15f6-08dbc0d6cc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tze5NULcG2KMQ9XsZLPWlx+wKXFxc95weLnQcd/P4a0jwLeBC0/HtgOukJX8c7HEIjS8wD09wb6bwD5+b+Q/CiNGQ9HB1wxssf/gysqGPJXD4k03GAWlJphQEDZ2hRrTPYAoDT3rOFfhmohAl6ukzfMLey8WrDA/o4dw9WLagzrJAy7WoMhaeEMRrE2dFpXhJ0KzUD1aVe3VgCm1O5IlYqVWFKA4n8wxuzSijWJKKqOr9yTuWCIWxPW2V0e7BeWBHqNPUK+L4JVYaLU7sUyL59KzJcODBloYnNL7GGAzffQC+ml1Du/cmrrx6lN2KDinKUY4NvJ1/KzihTFhN+pG5GE3n2qphxTHU2prE6oEuZNLafC9rABTIHEBJl2rx1a2SzQTMy06HnZHpvFJG9l8tXLIy3vvfLFoyxjiYDpOD6WQDaPUkD2oO6E9pFYBEJxafTGmB4mILlayOlV2hh9KRxU2pDHfyZ+ZWJtz83RmRc4vg8DAuGC7yCCfn+W4yTmCvLibDBg9IAnkzzvDSd4k1vFGLdoLPtD93KIX2QOW11wZKO4Hdr8VWaDsyZA9vZ9jI+t2GFG2NhixyQ2EqM8s6wOSiss88lqL40mtgi0hxFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(6666004)(478600001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQFdOk/9oZLWb1GAG3V5gbDXlfjR3Kq74SuvSz5RWeWk1EA2Q0lbl06w7fEF?=
 =?us-ascii?Q?NJTRmCQ3JkPUv/hRhdH+da6ENdg4tvrx5I8Iqq1aRXGjnfFz8i/prGyfujej?=
 =?us-ascii?Q?VNmzUUZpA+UsmeK+S6mj7q9uUWSiZYzaRdAvpVSbVDvnlDadFHAvC6//XHLl?=
 =?us-ascii?Q?e20DtDiSNceUSHkEC4c5GTe1NRY7m7+t4yE13QDtTXkcdtGESj9PuP60ISRw?=
 =?us-ascii?Q?VvMnbreEIe0CIHDrqGDslHVMkv3QPDHzoSDgnqGLvNxOLfuwMnnaVlULWtgd?=
 =?us-ascii?Q?OTQAfq3AHttfI3GLQg83Z23ixDHyvpkh+2+d82euEvgHoljP9nWQdU7cY+yU?=
 =?us-ascii?Q?P9okA1sYGyniHa+HqeoczDqevQm1pbjcn/Q72GiCdLFFScQ0ZJ8rl0iPry/h?=
 =?us-ascii?Q?6VNcA0kpc+G+EAP5pvkmsXIAlQAUzTeUnIXNZ//Wj6Q8khTsig8zYkRTHdhC?=
 =?us-ascii?Q?qk/xdH1dLC7oZT9GabZjVamwWrtY3JGn/Gw8Xy0Czi2NxpWMFBWYZChp46jl?=
 =?us-ascii?Q?03t6o5WJA+xZ1NKnxeCBR6+S9GuRVjwQ3muyg1irPSpRHky77h53jWuguyBs?=
 =?us-ascii?Q?QeKKFKLWBvJT3CNiPEMmHHxX2tkdHLwCysjJC9TDoYdCvwb+WpyF4A89WCv3?=
 =?us-ascii?Q?Q7Rznt9qDKuokjGy9N/StBS+pTC9TZLIvX/g7zCl6jd+FdsPhO/U7nN7mvCC?=
 =?us-ascii?Q?yIzdzFAHrfoZlfcytKIuNuGJ4GP0x6EWzFCQnL1GrBt39CbdW2RW31PHykq8?=
 =?us-ascii?Q?BAT+dhmH8E0iAPVkiKQnGqIz1t41Wt8smlxorcZkQpKl+s0I6Y0tyXVIDM37?=
 =?us-ascii?Q?zufYmJSxwGWU3dGo/VtR8wtrOWGodjjM7kJ83Sjk7ZoTcok6r52SRBXvE69A?=
 =?us-ascii?Q?HUU3JqB90YB7FkptqIAZy+p9VmN32mkn9T/0whgTpdTG/uwuHYpNMBHwdDZp?=
 =?us-ascii?Q?lE9l/V3TlRHKViYN3oYD8wuQS2SbcIvSOIORYIEjekOHlEXyH2ignuwz8oEr?=
 =?us-ascii?Q?JaYfsq7n33pnel3tJdRHZY6ihB5QNwesSVbNcpbmJsl/g8fqFCG/WmiEoH6O?=
 =?us-ascii?Q?Tdp6QVRif4XTTWw4736VCTuaXJE7rkqM6cx60dW7obc6tGlKnLXdlk5BH5Jj?=
 =?us-ascii?Q?Of+QSmw2ke+TbhcPyvdjUW4xyfDXM4a/5zYm3RfTcnpQiHyp+xdO0xXfbBwG?=
 =?us-ascii?Q?nGPwSTdGIsUB/PrV7PW5YgBHqNM53HmpCK5dnBFQDquh9CcbnswEKQNHGcVf?=
 =?us-ascii?Q?1VvMMWGfSZFB6cZQoR0qTP6Vlnu29dlJVzpWY/3twJGXkIgEOT2T5FGiUinn?=
 =?us-ascii?Q?XsO+GwlTzw4abvs3en/lc56sAuUYFtCoxzOpU6Q3OdHWdKbIPU3Wkq0ooUZ7?=
 =?us-ascii?Q?7nZAHpWhYq1z1nyYHqxIDfMUWRmMAgfCjebgncaW4b5tJ0m6ayvjONoFpvGd?=
 =?us-ascii?Q?rt7EQgipHw6GxLlIGaJGeeQ+bi0o+La2/sxPiOxUKF/hb1UceRxZa405rE6N?=
 =?us-ascii?Q?zTcmS1gpzKG87TtPXS/EGwB+a/nytC/GrA9HQHPh+sFrbaeeRRZQOAXHTr5h?=
 =?us-ascii?Q?MYJ7Z4lk5NYwLUtgGV6FjmWCLoUXOXPAwaOc+KnUG9720zVHAaPR6uwL1pLu?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?FV/zhekTmLuYgdqBbaa6GMckie0YXad1pYgw7PwrLUyrBfRM7f1fxasc8vxh?=
 =?us-ascii?Q?PjaVSEB1pERO1ldI+bgvnStcoj3NQ6mKygbx/CSowr/0Ozw8Co8wMqBWJtQG?=
 =?us-ascii?Q?zAtNc30xc8n1uStOVuPOaX/Ek04bttCOLsyja5yOMWytc9fOvRBz9kIqgBBP?=
 =?us-ascii?Q?Ui335youWP7PM5QBvhnYjPZQ39rACPY9TBV2Ajd+brae/nuxJOePcplrpS+e?=
 =?us-ascii?Q?cwY1s7pWtUVXNDeUc4jXkDsMllYhbT+seqZYH2fgSnMOC4PjDUfynmwSrZ93?=
 =?us-ascii?Q?rgCYFN74m5QLtE+DAneh4SS8wXauvAYYWBUb5WTgPQi8ONNRBO1fHkgjYC8k?=
 =?us-ascii?Q?vdoQKLaELYg6g3SrpKGIuVJ9b83TqXn2jRzt6OvZ4l8HoQKefHWnfvOQwfrv?=
 =?us-ascii?Q?JZuVPeNLm6jK3dRuPKGXXxJ3eb3Pj/wADQc3WIlpEzjEvaYNJNYSUIbWrRRG?=
 =?us-ascii?Q?4AMsiATv2SpUNgxpPancSAiZ75AwDF40HSTzC7kY2GKC3rBR9xXfKDI0XbqH?=
 =?us-ascii?Q?BJoUOq08RCz6MNLjV53Thl73/ZbzHxx8i88qBluznSkt8iSOfZUxYmBd1G9b?=
 =?us-ascii?Q?WJzzbTXsgcddurbRBb6S8hL20e7nX0syfCCVx9lviDR3Q+xxgp4gF1291Oxv?=
 =?us-ascii?Q?IjgPkyPtdKpusq01+u8Gdb1O+G/EqVO26gA3IIdd/7PaQXLCEipTJ8ApuYn3?=
 =?us-ascii?Q?3LijiU5PIofvO7/rpeP5wPA+pnKj75uxcaRM7+vO8X3MFKQjiEzfdPPKMJ0z?=
 =?us-ascii?Q?oTXoIFuS4ROYtZh0Wb+37/xPb1Xg5RaXmdDWU7HD0KrQzIXknHCZ3Ba3TD94?=
 =?us-ascii?Q?ghOCHM8r/GkQKSolM5ntL/p3LWrT8DzJR+q6Kj61JWgT5RPzPWIYxMvhE0aZ?=
 =?us-ascii?Q?d2GGXAtIAed1BtaaiJ8GpwqClBckSf60Y/8QgSm6wxTtFE1o4LazuOG7i2P9?=
 =?us-ascii?Q?f2U4SwCTXpyuO7IHsldtP4JkkxdlwWoZHno29kQvCxduspupKxEIA8CSEvyW?=
 =?us-ascii?Q?itI06vD0ncqX823xNxdRY0GejTg9dyK83CKPUr/6zBEWVXcaEakO0gHJGId+?=
 =?us-ascii?Q?G1oLVL80ZW2wLVgAY3x3iD6NdsqQnA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbf8b5a-a925-4b5d-15f6-08dbc0d6cc91
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:19.2183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adXVzi7vP3Q7EBAfZvzsl5OuCvppN62L4Q89UL0sz61VOeRfuG7MW9HhkQBE6YDIn5/gtjTYmtBN6tXLSfDjlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Proofpoint-ORIG-GUID: IBwO50uRtkvIDU46NwWnYxSbmDjvVWvT
X-Proofpoint-GUID: IBwO50uRtkvIDU46NwWnYxSbmDjvVWvT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for atomic writes, as follows:
- Ensure that the IO follows all the atomic writes rules, like must be
  naturally aligned
- Set REQ_ATOMIC

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index acff3d5d22d4..516669ad69e5 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -41,6 +41,29 @@ static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
 		!bdev_iter_is_aligned(bdev, iter);
 }
 
+static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
+			      struct iov_iter *iter)
+{
+	unsigned int atomic_write_unit_min_bytes =
+			queue_atomic_write_unit_min_bytes(bdev_get_queue(bdev));
+	unsigned int atomic_write_unit_max_bytes =
+			queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
+
+	if (!atomic_write_unit_min_bytes)
+		return false;
+	if (pos % atomic_write_unit_min_bytes)
+		return false;
+	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
+		return false;
+	if (!is_power_of_2(iov_iter_count(iter)))
+		return false;
+	if (iov_iter_count(iter) > atomic_write_unit_max_bytes)
+		return false;
+	if (pos % iov_iter_count(iter))
+		return false;
+	return true;
+}
+
 #define DIO_INLINE_BIO_VECS 4
 
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
@@ -48,6 +71,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 {
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
+	bool is_read = iov_iter_rw(iter) == READ;
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
 	struct bio bio;
@@ -56,6 +81,9 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
 
+	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
+		return -EINVAL;
+
 	if (nr_pages <= DIO_INLINE_BIO_VECS)
 		vecs = inline_vecs;
 	else {
@@ -65,7 +93,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 			return -ENOMEM;
 	}
 
-	if (iov_iter_rw(iter) == READ) {
+	if (is_read) {
 		bio_init(&bio, bdev, vecs, nr_pages, REQ_OP_READ);
 		if (user_backed_iter(iter))
 			should_dirty = true;
@@ -74,6 +102,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	}
 	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio.bi_ioprio = iocb->ki_ioprio;
+	if (atomic_write)
+		bio.bi_opf |= REQ_ATOMIC;
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
@@ -167,10 +197,14 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
+	if (atomic_write)
+		return -EINVAL;
+
 	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
 
@@ -305,6 +339,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	bool is_read = iov_iter_rw(iter) == READ;
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	loff_t pos = iocb->ki_pos;
@@ -313,6 +348,9 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	if (blkdev_dio_unaligned(bdev, pos, iter))
 		return -EINVAL;
 
+	if (atomic_write && !blkdev_atomic_write_valid(bdev, pos, iter))
+		return -EINVAL;
+
 	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
 		opf |= REQ_ALLOC_CACHE;
 	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
@@ -347,6 +385,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 			bio_set_pages_dirty(bio);
 		}
 	} else {
+		if (atomic_write)
+			bio->bi_opf |= REQ_ATOMIC;
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
-- 
2.31.1

