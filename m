Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84087B3018
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjI2K23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjI2K20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:28:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C833199;
        Fri, 29 Sep 2023 03:28:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9uNm020162;
        Fri, 29 Sep 2023 10:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=MvSxqf/ZWXX9uNSbYME7f9XmH7IkE6B3FCSobMwR3Is=;
 b=yvl7uTP4rqYVK9j7aSHHxAx1oZP7Hng8eky8VsMh+R/Iqp8sfoXqBBVc88pPPi3z4MCl
 Vqztjvdtp++7oPNIirqi2ksz6ON0uRCPdOY2+lZUaDssuiJy2lERsm3AqqTmAnvCrnv+
 BXEWSlN24Hu1x2jnHgubnNweagjXI7gf5TmT+ttjSzr3au4A3UFG+1ECFlh5ClFwHxyd
 Erf2sS/yO8uJyEetLUUoPLspcpNuBLARDNLdlfFCpDa/XpkNlwTqNWn+LdChxxee5e01
 q4/PMuCZdcD7TQfY2i89Ic0Koqqa1cdyNZGuPi/jHrsccunUoGtsgYM+ZxaXCKYXqAsE Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9peee9v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:27:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TALEKF025319;
        Fri, 29 Sep 2023 10:27:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh34kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:27:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5TO8sXLpj5ApJzeKMS7+ME2Q9fxoXHlZlmb2rC/79zlM4YbS8y4flsPsfGeoxsP0hVD0rL8h2gpDoIYfThMMluzZHUA2PpqQ4n6sT3DdCdmxAS+o3sz5MbnUfwWAX/7/5RGkAO1eTvH3brkmRmQFQCKUhq/lXqqD4DnX+JHzflLBynprNyod+70AVMJez0NVoJHN7K+mVQVOv50GHM8mI9r3CXoOsXiNxhYFQ9xSHnTk79ODMQSya2/H1I9wToJFqEwCJ/U/y8zPIks/f52RKnH9tb4G9kVatmIq5QmTWCYj0P1dYCetpN0JuUUrwCv020dUn/Y+hboqyBSID2EiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvSxqf/ZWXX9uNSbYME7f9XmH7IkE6B3FCSobMwR3Is=;
 b=AxxCpdqfyZ8zW7nnaOqmFPEcuqMGmJ0RfhfFrZOGUVlwIeqfV5EpbNL9C+fcPTq2DjLZ0fNUJeWp7uZvy+LegroH/RA/dz4qxuZJcxApwhBZA97gBftWjYn4yhgPaazTqqbgpWEg+E2WaWA59KKj0U0WCE0WeMhd1c5qEaAgQW1t0Awcpi2A/0nkb3leKuzocc/bNqPc0dgE8czRhgNViBCAYzQmSlLAo1f5CV1Ohh6OMtIgMsZBWAMP8FnEE3P4E4gxUXdJ5PczCCZ7LY4z/aIBOGp6GBuskwLVsFvwQNlHR3SNM1vVFYmuljA3xzoSHNERe7HL5izlEAIfB9JrPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvSxqf/ZWXX9uNSbYME7f9XmH7IkE6B3FCSobMwR3Is=;
 b=rk9oQq4+Jd4Yfqpa9BmVTjwX8CCVlaVEzT5+xerrrHAY4WkenW+4JxVNFGhG9cHWXHhNmAtTrlZGtp0IBxw0sIh7/ymeqQYwfNIQU1PxYN8uKL09EUutTxqcLbHE6hVab5pbdm03JjEYXHmDR7NSOqgDbMzLpeByzBfSNJg/qhw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:27:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:27:54 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 00/21] block atomic writes
Date:   Fri, 29 Sep 2023 10:27:05 +0000
Message-Id: <20230929102726.2985188-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:510:5::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3bd318-6e5d-4ace-2161-08dbc0d6bdfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78c1gv81WMoLDMraEaWRPTkJS9HLYkpYkeisDOZsy2XgcXX2mpb3DFLiszvRnf0dioASLhr31t+z2iMp5Aum0e1rO87r3KSIIcKwDDcfMmFHI7kNAljnY3h9THgfQdYbb8t3atbowplYI58hW8bTnaUxCH/IQK30DsCDtx00kT8NgEsbc8XmW/oJ8/WWznULjJbp5Lhd6W3Q5M5kQkxq1JA4CR138HJKeBf1wN8SXqFQdYx37hnMaYIWya7VI9WXkBd+VxGhKHCViLJ1iiE/3yHpr+JAvzKCq+CNKcfQTSrq9Be/DfHsJsZmVN9w2o+YlvBD+HoM/JPbRXCBGU35BpqhFykpT7qPx4YW/N0su1B4hh72LTcADL7kld6a3txhVmzzIhFR+K0Ov53jrYWU4WSoW7mp+DHTgwwmJMZEYp20pall8slzGAWBTvkyTvhd21YqemsSrTIs53DhEVOk0/F3rqoflCoL6tgcJJLMf8KrNpYNpbgaswvV754IrFbiKLCaeZ9uyTC/qqhjVMAZVC5Lbzj6fHp3FLCEbyBwapmT2hfEbBZPx4hNEpdMp21A/npkJzR35L1avKVsgzfx7G7N0o96uq7pys6v1CpDlh17rQWRVmG30sekoVoOR4jk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(186009)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(66946007)(86362001)(8676002)(66476007)(6666004)(38100700002)(508600001)(966005)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gtaj9dt147PtBbuSB/9ON4HoAoexnTrtEeoU78hyEnkaw0JSIX9jl7xUb7rM?=
 =?us-ascii?Q?m+OYN+Y42DKjJG183aaHXAGhowypvlGhqrefpg0ezreA7aiCzYF03+H33pM/?=
 =?us-ascii?Q?G+bTbjz4zyLYa2X4mo7LcXJfruQfK0Ktnk0xyRYJEbVBR17Wz2Kqo+Zpe8Wl?=
 =?us-ascii?Q?4A28UjpGW3eejAsKy+Kk5ZtzMUJCCwGY2Xbt7lFgzd1Y2rXt7r19Vm43bs5E?=
 =?us-ascii?Q?pimhfczDnAUejJU1oQLvaPMhDqjjq4iaS9sqbUWOF4ZBOWcJyMwGFJvk6VSP?=
 =?us-ascii?Q?mG44mwDPOtBalcPsTXTw7zLGzNpoXgSEeIGJ4GldkHAAPmqgjG47pWhTGwgA?=
 =?us-ascii?Q?QVyXPyOJ5NKlKM3SmSZdfodqPaPnLhOcM5vITo//t22Lc5a9VOqacO3Zw04H?=
 =?us-ascii?Q?BBTOArZxpw11Dw72SCBqjo8OinEFV2ks6mBTz1J4G180vqZ/sNzxpwvlcNlh?=
 =?us-ascii?Q?POddzs1GXr7UdX0C59p8+iF9AhCVDdbT1+Fbhw6y2my1rV76c311CukliOmV?=
 =?us-ascii?Q?E6i0z2HkpHNgIXZ7PP5W/ePQ6XnWLjl660LweN8QFjrO88ZE1vIcfoALaz43?=
 =?us-ascii?Q?o+/Za+xDrTLCYW16H0lTFMheTsFp2AS/XB+5LWc+5R+SojPgB+IWOUytzp0P?=
 =?us-ascii?Q?7T6btB2PKqgzSeUONxuTBx7PYL7VRkh9lSxe8DU1Wsh+krNXrWLFY69zENXC?=
 =?us-ascii?Q?1vxgUT+mz6q7O1gt6Txlp2sXyB84IyL4N6ihNobI0zQBZnAkEDu0c5xUpDJ1?=
 =?us-ascii?Q?mk7snPMVRBC2yBsAFFxe50kDOwHr0wa1mUoElSP577dbayxKoFJwnPhMo38N?=
 =?us-ascii?Q?pUgGt/7rpwqgrN2WHoyw9cMpo8Wtd8oAHjNl0a7EIGOvkX0/2Z0n9+HMgiwH?=
 =?us-ascii?Q?DK3W0XiQizK8aQALxpd3cKh/xJ7Tyk8xHHkpp34CA6/rhKT0OqqeLaSAv/SJ?=
 =?us-ascii?Q?4bPmJ8VIfpmJYxvlrleOmVVEYQNMZ/hyfXJ/cD72Bf/Gcx0HykTiQiRZJMi5?=
 =?us-ascii?Q?sNArn1VKBjdKwACf/Vz6UAPI0nCYG+e1OgnfRKqTwwbBLAhSgA0LsgYZWTXn?=
 =?us-ascii?Q?gTMKLHV1+Az0LDC03MOmP6GWP4PqNlMWtRK9IvGPM+krRCnVYwFOAJNvvCf3?=
 =?us-ascii?Q?mUn+JEDiGDiSEk0wotix4dqKRjuSALIHkNvgoDqdUIH/2+HiQd0UZCjDeMd2?=
 =?us-ascii?Q?XctP1vPEV0iLcDT7Ul0awA5OOZojGLKP7wxsb7zn9npS0FwA2bOFkdcbc/pq?=
 =?us-ascii?Q?aSfe8G/ye8a5XRktid+ktUeZXysBVzbjf2bWrYtrd62qyMpfzCP/6TtwRZt+?=
 =?us-ascii?Q?dgp0jnrn4Kw6CmGaTfTOknxbR/kXrTv/z5REqjQEQZz/9VvsXbgLZP6r0k9t?=
 =?us-ascii?Q?zAsdcQtVjIHw2rlbnI5plhZjVsg/6YGvO1ijwWgZWwk8eCBkdbiulMK9FjYb?=
 =?us-ascii?Q?jV/1GY3nQNSKx0fZdhulz+Os5cfpLR+ofFNOceBDlifrtF779C/DEOxW6h4m?=
 =?us-ascii?Q?YiUBAG07fotQjRhiivNdR8+ieJHZSU4pFnj9B2mA0VmV8ZB93mrubnLZI7JY?=
 =?us-ascii?Q?IBfs/PAvN9ePUBzSzH+vj5O6oOH+cN7Mf9otzOfu9m+rMBD9P+tCzGTNVUVA?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OtKoDoffEJ2OsnP4VVJ7prg4kblo++tMLROabqx/17Dtf1i+VbBSanjk0/sx?=
 =?us-ascii?Q?x2fuxjZXrv6FTFklqakJ/vnCoPqZpFXC5WD55A0+LHuSJauiOdM5drziyrI5?=
 =?us-ascii?Q?6o2/nrbVKWs9c5JTtyhx0e0VHdyMQ7SZz38Kmq6Rk+RV5q20UGjYxFID/8cP?=
 =?us-ascii?Q?O+zlqCSoM7g9E5V3xIg+viGrcorg7NbUdRoGKOwfq/ZyWX7IQujGWhBAos0J?=
 =?us-ascii?Q?vFsapPR9DMec5xMdM+6YuuqCm3xwX34eNMDv4h1ndwKVIWEGRVpT4FmPIRbe?=
 =?us-ascii?Q?1dpcrstzyA/GvMhqSwQlFMu0iuJ6f+Yh9KtE4/EdzSQx8X3MrsFA1M+w/eXO?=
 =?us-ascii?Q?aQz+0uoK4QdEK2SV7N7EMOyhctm9d8ZQISzd9F4mERD8CzWCexyMzPXExDFI?=
 =?us-ascii?Q?9ongtLcqKLLmP79BDWjE0Kd/0uoqeNTWn0wTTUIsr1DOmRw80PMddF3oCnPV?=
 =?us-ascii?Q?QfjaXDjspXMbxT4PDfcH4hDof+mYcmg/dLqNS1ES4tfjNiGI14CYXklfEhGN?=
 =?us-ascii?Q?p87PTfmNkCgN2IvR6OUL563mD8Nf+1yRpTInTgMmiOSN9rP+zC5ZDNF02k/3?=
 =?us-ascii?Q?mTDLnjz1+6+dU0lb67iQurD+nFctQuhMYDCvKvyD+/mn38XzrRemK5mkuPUg?=
 =?us-ascii?Q?lqHjoLJDjaoIkWRkFJ6IYye/jxXZumwGpIz9NtiGHM48O3EWYo4OcGEYrMg7?=
 =?us-ascii?Q?SJ/D9qBx9bQDgEYSnr2m0AUnYMa9Ocj2uIu2O7zQjlcRAmao9o0UegcezdbT?=
 =?us-ascii?Q?+bqbJhKo7Nxy6AFt8O3UX9Tgj9g5MtfIIVnA3Lz2ShnHwvPxbKg3YyNaA+E2?=
 =?us-ascii?Q?5kgNXfOJG0fM6qDDNZiqtElCnlbGOE0AXxMNMwhFDQB8FDCJqYh/UZeX1w5v?=
 =?us-ascii?Q?f1tlY9woq0+cT9NdrhjEJziTEwCXa6VO8QmOlZ75cnJ8EJHVXPVvWSW6vIAY?=
 =?us-ascii?Q?3gUk6NL3AAp2TSaDtB4x6LFjDiGqudOYDuJ/pLcLaNZAcvRaU37SqiKujc3F?=
 =?us-ascii?Q?6A3V0FGSMNiBpIZc+oqfY52gVgctgxax0TNfQFWK6t4SSoKNteOlJU4hDPae?=
 =?us-ascii?Q?qDWAydS8rwPckTZ7Mm4nrZ25tIXVhQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3bd318-6e5d-4ace-2161-08dbc0d6bdfc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:27:54.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NVZmVKeIcHqkxtgItpOsiAkzWWLNat/Ugo/fdI86ONE++6j0XNuf9bs2GFdL0CE1jcp5SFr7ew0ihUnchGSmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=988 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290089
X-Proofpoint-ORIG-GUID: _whshzc6WUE2jm-q-x5KLsZNyoUB3HnT
X-Proofpoint-GUID: _whshzc6WUE2jm-q-x5KLsZNyoUB3HnT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series introduces a proposal to implementing atomic writes in the
kernel for torn-write protection.

This series takes the approach of adding a new "atomic" flag to each of
pwritev2() and iocb->ki_flags - RWF_ATOMIC and IOCB_ATOMIC, respectively.
When set, these indicate that we want the write issued "atomically".

Only direct IO is supported and for block devices and XFS.

The atomic writes feature requires dedicated HW support, like
SCSI WRITE_ATOMIC_16 command.

man pages update has been posted at:
https://lore.kernel.org/linux-api/20230929093717.2972367-1-john.g.garry@oracle.com/T/#t

The goal here is to provide an interface that allow applications use
application-specific block sizes larger than logical block size
reported by the storage device or larger than filesystem block size as
reported by stat().

With this new interface, application blocks will never be torn or
fractured when written. For a power fail, for each individual application
block, all or none of the data to be written. A racing atomic write and
read will mean that the read sees all the old data or all the new data,
but never a mix of old and new.

Two new fields are added to struct statx - atomic_write_unit_min and
atomic_write_unit_max. For each atomic individual write, the total length
of a write must be a between atomic_write_unit_min and
atomic_write_unit_max, inclusive, and a power-of-2. The write must also be
at a natural offset in the file wrt the write length.

For XFS, we must ensure extent alignment with the userspace block size.
XFS supports an extent size hint. However, it must be ensured that the
hint is honoured. For this, a new flag is added - forcealign - to
instruct the XFS block allocator to always honour the extent size hint.

The user would typically set the extent size hint at the userspace
block size to support atomic writes.

The atomic_write_unit_{min, max} values from statx on an XFS file will
consider both the backing bdev atomic_write_unit_{min, max} values and
the extent alignment for the file.

SCSI sd.c and scsi_debug and NVMe kernel support is added.

xfsprogs update for forcealign is at:
https://lore.kernel.org/linux-xfs/20230929095342.2976587-1-john.g.garry@oracle.com/T/#t

This series is based on v6.6-rc3.

Major changes since RFC (https://lore.kernel.org/linux-scsi/20230503183821.1473305-1-john.g.garry@oracle.com/):
- Add XFS forcealign feature
- Only allow writing a single userspace block

Alan Adamson (1):
  nvme: Support atomic writes

Darrick J. Wong (3):
  fs: xfs: Introduce FORCEALIGN inode flag
  fs: xfs: Make file data allocations observe the 'forcealign' flag
  fs: xfs: Enable file data forcealign feature

Himanshu Madhani (2):
  block: Add atomic write operations to request_queue limits
  block: Add REQ_ATOMIC flag

John Garry (13):
  block: Limit atomic writes according to bio and queue limits
  block: Pass blk_queue_get_max_sectors() a request pointer
  block: Limit atomic write IO size according to
    atomic_write_max_sectors
  block: Error an attempt to split an atomic write bio
  block: Add checks to merging of atomic writes
  block: Add fops atomic write support
  fs: xfs: Don't use low-space allocator for alignment > 1
  fs: xfs: Support atomic write for statx
  fs: iomap: Atomic write support
  fs: xfs: iomap atomic write support
  scsi: sd: Support reading atomic properties from block limits VPD
  scsi: sd: Add WRITE_ATOMIC_16 support
  scsi: scsi_debug: Atomic write support

Prasad Singamsetty (2):
  fs/bdev: Add atomic write support info to statx
  fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for atomic write support

 Documentation/ABI/stable/sysfs-block |  42 ++
 block/bdev.c                         |  33 +-
 block/blk-merge.c                    |  92 ++++-
 block/blk-mq.c                       |   2 +-
 block/blk-settings.c                 |  76 ++++
 block/blk-sysfs.c                    |  33 ++
 block/blk.h                          |   9 +-
 block/fops.c                         |  42 +-
 drivers/nvme/host/core.c             |  29 ++
 drivers/scsi/scsi_debug.c            | 587 +++++++++++++++++++++------
 drivers/scsi/scsi_trace.c            |  22 +
 drivers/scsi/sd.c                    |  57 ++-
 drivers/scsi/sd.h                    |   7 +
 fs/iomap/direct-io.c                 |  26 +-
 fs/iomap/trace.h                     |   3 +-
 fs/stat.c                            |  15 +-
 fs/xfs/libxfs/xfs_bmap.c             |  26 +-
 fs/xfs/libxfs/xfs_format.h           |   9 +-
 fs/xfs/libxfs/xfs_inode_buf.c        |  40 ++
 fs/xfs/libxfs/xfs_inode_buf.h        |   3 +
 fs/xfs/libxfs/xfs_sb.c               |   3 +
 fs/xfs/xfs_inode.c                   |  12 +
 fs/xfs/xfs_inode.h                   |   5 +
 fs/xfs/xfs_ioctl.c                   |  18 +
 fs/xfs/xfs_iomap.c                   |  40 +-
 fs/xfs/xfs_iops.c                    |  51 +++
 fs/xfs/xfs_iops.h                    |   4 +
 fs/xfs/xfs_mount.h                   |   2 +
 fs/xfs/xfs_super.c                   |   4 +
 include/linux/blk_types.h            |   2 +
 include/linux/blkdev.h               |  37 +-
 include/linux/fs.h                   |   1 +
 include/linux/iomap.h                |   1 +
 include/linux/stat.h                 |   2 +
 include/scsi/scsi_proto.h            |   1 +
 include/trace/events/scsi.h          |   1 +
 include/uapi/linux/fs.h              |   7 +-
 include/uapi/linux/stat.h            |   7 +-
 38 files changed, 1179 insertions(+), 172 deletions(-)

-- 
2.31.1

