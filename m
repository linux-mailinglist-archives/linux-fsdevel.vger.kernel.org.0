Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9154F734D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 05:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbiDGDXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 23:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240223AbiDGDWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:22:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCEF1777CF;
        Wed,  6 Apr 2022 20:18:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2372POVs012451;
        Thu, 7 Apr 2022 03:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=4R18pwpZs4MCAT1nUpfEebB1dGvjB+oR2X9XNPWO4p8=;
 b=K00aU85PLQqbvLtFWFoJrDU265LTE87Pk/HdBAP/k00+nUFnbt0HzC28qXULort8/5dT
 0MHpiTEsWCfgWIp/VfQe9wiWPEAirP8mYmfSrg47AbJZDmThd0V1PsvRsYi51NPFYNvr
 NP2yLcU3EOsB2gWzmVP8aRKlbSwElWU+lSbkDiCvniySQOstZ1VwrWhBJ4RcKNHPBxrF
 V58nasvrQdpQg2m7CndmhycOsf0q09wIS8eq6lycZSkVJxROXgRbjAvJF9JwSI0MotNd
 lbjdKIs09wAmCsCRIasNHrHq321KOUHGDNEJaaEZd2owY8TuK0k2deMmuCCqk82rG8Ea 4w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcjad5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:18:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23736PuX029482;
        Thu, 7 Apr 2022 03:18:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f97wqsm3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O25uO0BueHUJN4G5YWQ/pZKSQFUTVgJDOUxEmxaadRGxJcbSKf6kdI1i4cqtX0sTTskKg8DjCjxfpEobxGIx95JUiYel+ilDSgSrjxjEzhpN76YABubhkRT9yiZIJJpo9Zgbc0uz1GfQs8/NrbS57CinKt6dSFg4HHnOhnGLl5eOhQjfHJusa/VDx6Bef9BlsUjr/ZtM7hPrn6iY2/1nAUYuAYuPG/x/zAmi5qDm9F+cNQQNsoM6rfPflQUqJFw+LgzUYD5Mfl25IR0NILxV2mbpC2UJk8P4uYpdTnnd9gv13GoslRQIl1LQl0hjNLIgEVn7xLEh+HdKST2r0RQWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4R18pwpZs4MCAT1nUpfEebB1dGvjB+oR2X9XNPWO4p8=;
 b=V4FaobBp/9RjdJNp8dnQh12p8QjOIb2fJkFjC9yK/wFeOxgrMwGq6aDEyu1t3e/cPpNFd4iEKDVauxukGJE3e9ghhDQokDAXj2BfPVME+X29tAP73TSRBT2iiQ6dsiCJfEp6F5ySdFsz01vPqFchEGfYSlhMP5EuQRcHwWzBWcbfHg+l6NrSEftNeo6J9oEjJsYmBMcnFMSYUYv7QsiaVRdeuobHtXEAADOKFwf0nFxXL4mmiTp8Fi3DSFqIq8zG0BnnEHYl+hJXjBUGHMAvtHvB6WE5co2Mkk3EdhstyxkRMPV23wSosaSJTEiRO3up6fqaHR546MAgbjhPqikpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R18pwpZs4MCAT1nUpfEebB1dGvjB+oR2X9XNPWO4p8=;
 b=cxLXo3OvLrTa628//kIET7Ti0V6/UZFRGi9WHq1SXkLaJWXQcI3oYPMnBjQ7xLW0zTObAoEjQLfK43tQmNc6mLfp/lWYt8DWQCyoCc9Rnb//ecM/57CfmvxCySwNMe5n+PKd+Ig1TQXRcim1T4Kx5kFPFl088aE8yTpp0FEh3HM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4408.namprd10.prod.outlook.com (2603:10b6:510:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 03:18:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 03:18:23 +0000
To:     Christoph Hellwig via Ocfs2-devel <ocfs2-devel@oss.oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        jfs-discussion@lists.sourceforge.net,
        linux-nvme@lists.infradead.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        dm-devel@redhat.com, target-devel@vger.kernel.org,
        linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
        linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
        xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
        linux-um@lists.infradead.org, nbd@other.debian.org,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-btrfs@vger.kernel.org
Subject: Re: [Ocfs2-devel] [PATCH 13/27] block: add a bdev_stable_writes helper
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mtgxintf.fsf@ca-mkp.ca.oracle.com>
References: <20220406060516.409838-1-hch@lst.de>
        <20220406060516.409838-14-hch@lst.de>
Date:   Wed, 06 Apr 2022 23:18:21 -0400
In-Reply-To: <20220406060516.409838-14-hch@lst.de> (Christoph Hellwig via
        Ocfs2-devel's message of "Wed, 6 Apr 2022 08:05:02 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0078.namprd12.prod.outlook.com
 (2603:10b6:802:20::49) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2ad1994-3c3d-4e6a-83b6-08da18454625
X-MS-TrafficTypeDiagnostic: PH0PR10MB4408:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4408F2AE0D298AF4ACC6B2E08EE69@PH0PR10MB4408.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLUvISXJLjYUGupRQ2XT1s9tBnJewgVitQqt3VbaYK1TlsSRvia+IY6r1cACAlU0Wa9sgavIuhykxLRm2HHe0Pdr64qYaVsO1e2Y/l7KspFO8oSlqX4OsmfRnYdI20hlWEaGs4kWvsvm/5mVwcwnyEKRAF5RE9SHBE1Knr0mMH/zSmqo4bp3hkT82WooPA8N5riuntQXkoB/rNN7cnESYFFPL2asRWA+jwPCZVUphEvJ5XPFvyT1z2Eq+NQwtwzdcvgLA+IBZswJePmovMcCLym7FxouJeyk0vlpY3eLrZNZhP/6ECTKFt+JJ0PAaO6eArEkX+hClm4sYV6QFop66FauGhK2UYdYYA4opvhsBScbB5d4Ed8/cQCqQQ+dhdvW9pdbQoPmm06l/Ahmogsm7wLzTX0M+JEoODGs33L2YsXb/cL8UawqLEDKnXTkjWs2M1XmfwZ/zkzZFNgzArnuUVx7eIPt65HU/Tk1oJrY5ysSRqrw4b3w46oDSItf5KrU9Dp9eoCGmADWlTqdgPqBj3kN9pTb8d0Oc2PybL2XdJH8pDG1B1GumdgkmZjBrEvoXcN6aVgIojHhHdUHDGeGkGQtFkG19FJ6njKmifx5j1yJA5ZsiOBoHwLYh6Zi5wpftFEN5GFzmaxFhO7stvzBoqXlPrLN/M+oOPsEm60V21SQkSDCCwDKlkOodU+X+oC+TQ95BXh9aAkiCMJct1gRlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(26005)(6506007)(36916002)(52116002)(7416002)(83380400001)(186003)(5660300002)(2906002)(8936002)(54906003)(316002)(66946007)(38350700002)(38100700002)(6486002)(6862004)(66556008)(4326008)(8676002)(66476007)(86362001)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xIsd0zLwcVDDnh7s1S0dJ4gppcaVSQwl81pqFbYz/+egH66fuo2Jc5jaKjrG?=
 =?us-ascii?Q?5iZ9E5EH+nYNwN8C6r3SBW1b9dbddV+7pieUtyv0jx1J2YD5Zzt/4MLaM/ko?=
 =?us-ascii?Q?I0nzssasq8sQbtr6/sAG7CmZrQpDLmiT+qpBj3wFUafqk85W+Drzww2xyEpz?=
 =?us-ascii?Q?wI0DSIThoePrDVlDDs8ivw9D3oeEGiNA1ioOAExJdUzArdsS8jer3gKF+rO2?=
 =?us-ascii?Q?ZvU220BzEAtzCOhzO8Ff/U2ZjsQ1TkmSKxflXEjpGHY0cJ6zhVVNNp3HB2iC?=
 =?us-ascii?Q?bX3J9jWoS4tsyz+wWwpJJrTnQJ4zPsO6+ki48PWPdsh2euaJ36jks7y94hZi?=
 =?us-ascii?Q?V/cN3QBs/4R9l81o4Uwurg0tzElEY/5T+H3wo6uTYg2ylkdH/Jmw+nqKzPGN?=
 =?us-ascii?Q?4YDGYkt9Sug99AMbl29IOHzCzYc1oUBMobgGJMbLklxYvuIgUIRrsWnRJuqi?=
 =?us-ascii?Q?ZIyHsyLPdR2QF6NwFaadAFAn1tjlB3IQVnjCjWkj7L+oJGFk7P8W/uJEo5Q5?=
 =?us-ascii?Q?T/c5ZzvwDW+94AZzbaWiENJI4Ctp/2vbovviAIZVOJEhMqaojguOJt2bRJMO?=
 =?us-ascii?Q?Y+748XcIrXL8IEUWvTiHgZYiOOsIhJzz0+hHIvk/yly9LJ1+hb4pRfxtnTC5?=
 =?us-ascii?Q?TMf3WWY/vby6rTVShdQNrzoNMGjnbcEHW7hNd4ZksoAX6LVufUAbUaL8PF6m?=
 =?us-ascii?Q?VBzXXc97sA+qu+HcVVA9PAVO5u2rWh6e0kIw7MFVLOcKd2Q/DqcKYobFs41O?=
 =?us-ascii?Q?qY1zIbQjB89zPwjOOdwl9orWX0fCdfuawnQpOhIToO1UVkhmzdymnn5Lkq+x?=
 =?us-ascii?Q?Xz3U/pDNM/7XXFjSc95PFNwEi/Rdc4l2bxSZMAdvqQZIGrzqapnBUMY4CD33?=
 =?us-ascii?Q?d5giA1c9NSqUUoQSi6SS3Oxsne/7mmvsWjGhDB02IB3O3qXiUVZGLVls3g1r?=
 =?us-ascii?Q?FGY3G0vC8ZetoHeQa8UMBfEYNwQ6KkCWJpwhGISTrgTb/Nq3vwYOP5kWdY3k?=
 =?us-ascii?Q?SAwF+RAnM4qU1Z4QNlCBrx662uuC9IawT2Kk9A+lXP16FAm8vQ9b6IOy2X3D?=
 =?us-ascii?Q?rQf3kx/nU4QPe2JannqJimA8cG+wIGuoTH0Xf7v8vbEIVt8dpGHnpSH6qIZj?=
 =?us-ascii?Q?sbTPBIThpBD6cDEiSSSjKMB9pZrBK1gwMWBy1kiw+T71IBnMkc0gjPpFkFO8?=
 =?us-ascii?Q?InOFEkVOZfl/2n5j8jRuyH8wA1H8KkddXKUwqZSERpwjVZmXvDo8Fp9laCpo?=
 =?us-ascii?Q?MmB40C2ECG/Cue6W8SMe5Y9zunHmiBcfxendBmJgFqnPzHwH65DkGs4y56eK?=
 =?us-ascii?Q?RU7FxGRN84qz5e01RViYgxspfOMT+NtQsKRINgp4oywm5U3jLnumrYnaYT1M?=
 =?us-ascii?Q?/sG2odArhsDNTeuPtDYCCTCKWNrFHuibcJ4SfhQVefycP+gdmnxHjEdB0p5e?=
 =?us-ascii?Q?wl3LG9BFWzfHBRcE24beJ2a60HJYtr5i51pQOOWU0+3NRhTcrkxMQarzn+o5?=
 =?us-ascii?Q?U6JvwGc1Sis+FYUsNIKJzbs07TCq2AeZmof1g/k779pG7UMHfg2oKC5dAD0o?=
 =?us-ascii?Q?0+diKePSeMM9CRHkEK58cTVlS+sTGDjnhSWvaOM2zOWO69Ny5CaatYLC+rAX?=
 =?us-ascii?Q?OHcId1N0UPO0A8mnGFLCCFEgJ72887m2LOfEr5JhHePt4eLhRXXQJ0jVUXrb?=
 =?us-ascii?Q?6Ag3ZB/97Kzn3SXO2TvruRccP3HpJnQWG/K+tS+j3t7o22HdESkN69evPfSL?=
 =?us-ascii?Q?kLkG+Yu6HtWm/SQFpdF0wHGl3iEZ90M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ad1994-3c3d-4e6a-83b6-08da18454625
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 03:18:23.6582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZ9wn6/Z6Gqa+JKgYT944VbgDZ5imkniqjRmEsIQ1javdBvsN1/Na1raINqCIDzfpbrVWYGXUV59K401IhUHeyecdeVGfgDhGALhkfADxIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4408
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=946 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070016
X-Proofpoint-ORIG-GUID: Yoj1mmlMui-AZzQWBd4yidsBNyVdnJfj
X-Proofpoint-GUID: Yoj1mmlMui-AZzQWBd4yidsBNyVdnJfj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

> Add a helper to check the stable writes flag based on the block_device
> instead of having to poke into the block layer internal request_queue.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
