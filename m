Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0D74F72A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 05:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbiDGDKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 23:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbiDGDKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:10:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A3B217499;
        Wed,  6 Apr 2022 20:08:27 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2372POUT012451;
        Thu, 7 Apr 2022 03:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=F3x6P1kenH1Hm7uyRz1muMBaUZJEydwA1QWe1BNT6dc=;
 b=cfJmdlT0b28dv1IZ57X77wNW/0fqQIlICfwO+w21wI/1c0lHpUBi2zuV+EXoHxuLCx9+
 gzqua7rNKLsJh19hOfS/0zBGvCfkCYy2lrweCkMd8JtuJNhLctuWbAoww6EZ2zply3JC
 ZIqbDi1nv88R8J2m5pMK46KWih6U/y6utEmvmiAxqETsgHdTNSMNSF/VAFFXPW5xmymY
 5RqSgSb60kNgdK+p1lDvCcexMmB0yW/JWqgG+vd6dul2009SoBlCouO+lunuW/I1DRXe
 dOiSjL78iwHW23gE+ZvYCuXRRyi57NDTPg+ynkS2WqJlrCVV/u5tO5CQddADUltB1K3M dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcja1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:07:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23736Qew029514;
        Thu, 7 Apr 2022 03:07:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f97wqsegs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 03:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrCvlE1NBFTDUpegOdY5bGDTCwM0CCJGtKQtelIaqMpJ7L/nT0Hkc6aFsUcNugG9Vivl7PUD7CAlXVzVK4GL5Q7XkugvuRjZnJuICNnwHdS/0VrxpW1OA+Xv7SIk0GztXBIT8/fPge4xLXBV228hOo71QhAQnwqUC3U5/0pbFLs1bUVrmt5WIJUL5D/HLF3b7LLXy/iVp0rDOPEf6fw3BdmcoG+0GG/PJ2pu/8NEEHps2MJl3fOhwT2dBsEQ6CBh7fw7po9yq1WAz9Of96lC+hrn8jkLM5mojNH0C51Iy000yFb7EiSNlzf94ez3zRxtTsNllu5Sg1ZrPshQXIUNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3x6P1kenH1Hm7uyRz1muMBaUZJEydwA1QWe1BNT6dc=;
 b=iLS/RB2jzMUtJGoaERI3S9n4osy+zSxkMPBizCQNtbcjjVn3+vM/eHQKiSM4kY/o2l8l7ZMSUCfU+EsQvwtZeu7OFFt0twT1+qhhKMHp5oxA4BOkgfHl2wUa1wX+SSltp6NjC2kGn/eUGdKzEmCIe9U+DvUpBCt7FaXjpWuWwoPucI8HHji0BikNynM3y4ZsjgFLFqRgm80zYOxu/HXnG14EkjIM9uS6w2SYYkopRZiSX0yt7xBPg6x0HFdioSTK9NrBxYJyu+zvBCXCzy2HQ5QFx/IB9H1ZeXeGwN9Af/AhWvzxmTgH5UARs5ts8WdgypyEMjbG+6wC407c0+r7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3x6P1kenH1Hm7uyRz1muMBaUZJEydwA1QWe1BNT6dc=;
 b=N2cSI0L09BukAAC2ZOhx8qz0NNNe89edzYFU8Lh//FiCv7KyzXtkTUF06NH7q3cG/ftto95agMLQfKat2F8KX1qQeVJcG6DjvXQsplX2Xi3h+93pjoauE8hqRXxIIDcnc980ndgEcHjUtm/2hTkzz81u8UYXtss6nYLKbcgIdLw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1590.namprd10.prod.outlook.com (2603:10b6:903:2c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 03:07:10 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 03:07:10 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
Subject: Re: [PATCH 02/27] target: pass a block_device to
 target_configure_unmap_from_queue
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lewhk2wm.fsf@ca-mkp.ca.oracle.com>
References: <20220406060516.409838-1-hch@lst.de>
        <20220406060516.409838-3-hch@lst.de>
Date:   Wed, 06 Apr 2022 23:07:07 -0400
In-Reply-To: <20220406060516.409838-3-hch@lst.de> (Christoph Hellwig's message
        of "Wed, 6 Apr 2022 08:04:51 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0036.namprd05.prod.outlook.com
 (2603:10b6:803:40::49) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0159823a-59ea-43a5-79e8-08da1843b492
X-MS-TrafficTypeDiagnostic: CY4PR10MB1590:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB15908E13CAB5A6BA15CA19858EE69@CY4PR10MB1590.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PA2Z3zvnaginXNr0BRdbzRmx4+M6QabC9KKOk44bWlwv1FaywbY9U4dnphNSSK+v/7CcGP9sv89lLuxFchBSBrN6REJmV/ST7yYZCg2v0w3RdYrZCj7jqemUbzytCBhN6mRJZMTJA63mVdBaWPg3lmS5wtA18HWw5+kQMTN0C1rB3N+WbNN7WYjHIkuhxeGwkEhee2LAXUBtG40t3Tw0f9X1R1JebCAVWXvms0sQCJ3aK76BAW72/uw4c9Aveuj6fIDIJVa7b2BWAS+HjPxufBSdGP9hORIvYgJcOJ5161LkSyDMnvsfn5oEjoYLM8IVR+oRUU8v16Tw4rpgAhbczXdHXNfeIMvBC0hrEWtKNbHzrnnvRSGwlxsjinoXy9uAp1h+jeqtkYm1CQsWrwmDwmF7VK5IvwdjWHI1vTOeYAu2OZ0XPqivDhux2S57H5xKVHS/yYWohiQEINSbOuMWfYOCwKYt4omyU9tMD2sIOyEXuw1lIseDTeloFGqw66QuqvZmzzdWZtwjZGL5s46SEY+UWZm6fwfoYsp8DAw89XS+fMKOjC/jHZZMZgiqujuRzczDpLT9EZQjlI1eMvAiMa2psQsodwI8iZ5qSF9kXjjcBvmjrrNrVBqPgaF6cY2Jv8kRhp+rH7g9xKrYX1151xgocKc3xQjpfBM4a1Hr3jXqVThJpZR8CuCeDk4u9e+HKtBgpY1eW9JFbgJKLrGPzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(66476007)(7416002)(5660300002)(4326008)(66946007)(66556008)(8676002)(8936002)(6486002)(38350700002)(26005)(38100700002)(508600001)(186003)(316002)(6666004)(86362001)(2906002)(36916002)(558084003)(6506007)(52116002)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7jOSGYtXx9bA9WZieGCt/o3XE6/UbuWTzsPziP7YgPFtz5rxZj/YbslYIg3d?=
 =?us-ascii?Q?IfID32//vXGCsYbZ93N7wfpG2KUECicS+tuke8qmAFSJRZodMYV3tWLwqFUY?=
 =?us-ascii?Q?wWlanGPpN2/59tfDHEEIGuyAAyNMFWXbVir/PJ4+YRSpfa8rV/V1OZDhtyOB?=
 =?us-ascii?Q?+LddzHBmYUm8LOcJcBJD3WFSD0ZjU2BtERIjTFpoZusVNzeGa5OGgs54YbUC?=
 =?us-ascii?Q?aqJaWpI2w16X6FDC0X98k+0I/lNyxwNYtk2dcixdxFO7/3S403PFtlDgZkMh?=
 =?us-ascii?Q?AV9P5vJjQXRZTLHyygghsV/gmc3V3sxf9BPtS+9q4GBAyFHLE1liJ7hgve1R?=
 =?us-ascii?Q?yHYQD5ftoCrW5zhGK08+N0iBCStRpijKetnXcZ0dZ0e5vmVNl2HO0TY8UWO0?=
 =?us-ascii?Q?yxBK43BmxuVLOEeQxvEdEXf2ocA5NLUH9Sx1ndRD9DwBN7gGM4aP37pRuu5I?=
 =?us-ascii?Q?JtBBLLZVzRS7DsC1Iq6i2xAN/eIBCunuplqn4crvq7Q6OtrvHzAmknjKxL/L?=
 =?us-ascii?Q?mynJcV+cHBqiV/ItBSDHCYfG8dtK1mONjx85/pncIUyxDa0yAJ6t8KJgavUL?=
 =?us-ascii?Q?jsk9wqjJoj2Fu925tNkEpWP673qdG1V7oEA+WxeOnp/TeQBRWbYBHXM6bTw6?=
 =?us-ascii?Q?PoJ8EDlcOZ0Fn4gFcRnsp3P/R/2Tr1qNa8pC/2QDYuCjJaCXn08w2ERmni14?=
 =?us-ascii?Q?IDqFkst+HaZMKtCc5ZKzvHV80pshcOIywm5y2ad9Nfbew48PgZSi8Uo5ZdZ0?=
 =?us-ascii?Q?jee5l2757c201u4lUc1/7xU0z/jG8MEMRpzqG6ugyOmaJ7TJj7HGIqaExbe5?=
 =?us-ascii?Q?2YMmQ2oEeBtspequlBRjY3HTiljM4vKgzgu84M+vFedSMQ+jq4ShumsFnPIM?=
 =?us-ascii?Q?GdYdS9GWwRhCce7HPlrg3ZSHNfvbO9/1bnOQD0FYxXD7QkgBayEiKxWYrej/?=
 =?us-ascii?Q?TwDGp9anU/x4IEY8XrtyUGOXTkxBRTpXwYOCLBu7jOgmVBi+k6suYMxP64hz?=
 =?us-ascii?Q?hXRPRbAEmg87imQn4FDEokjeIX58Qz1feQt06RPF9Sn84dnKEfPAYJV8IRys?=
 =?us-ascii?Q?znf/M26t5kZMDaBZ3x7VHmSmli0jsmtJJnPL7mvF8Mf3WkVScrkWW5i5ptrO?=
 =?us-ascii?Q?2Cl9cc1gPh7lPUwXnoc+NEphMM7+oprjdOgQcI24ZOUbuHwbX1HCPbSyoy6C?=
 =?us-ascii?Q?3IyUrtdTqIchGflbVd0Xww0f6+rzBc0rF9GpbFlnLwq/BX2X7WsGrxDd5XYq?=
 =?us-ascii?Q?ygQgR5ruLhmz+wpsasTpt64MQ0Ic4UgIzkIxyszl9TxR9FfxGoFSXrQUVHLL?=
 =?us-ascii?Q?RKJntEzbhVP/6h/R8pROoYJUkn+bmNbgh9K137PFH2mWYuqI8pZq5KzX/5+O?=
 =?us-ascii?Q?hYv4LhXz6EpYWMiifAreccy8vZvNK5wRiT63dnJhzMmnPBwAMjGwmlwOSr1Y?=
 =?us-ascii?Q?avctRXJWD23qeM5F//b36pFJZH6tMYKrDHT3AdfU0nPnL5xhjhPaukeGfoVT?=
 =?us-ascii?Q?x1vc/7/NVk2g658sDHE94Iwy5h6aa0mLPMaTL66FG+AoorGpG7MuthEbhK6t?=
 =?us-ascii?Q?nj9WCOSCYfuVTHwjwWolZsS9zxyBzzdPzsz7G9Pr0HzjO6d0DHxt57zsYTOy?=
 =?us-ascii?Q?sZqifPtp8ZsTptLFHA2ho5qUK8qmJR098HdKqXKdNkRdK4kFeRwg2fmUpO1H?=
 =?us-ascii?Q?WX/OL3eo90YkrbLdD/iCVKGkjgeZ8c14I2N7/ckBwzeFCgrrHxuG0DZkkl22?=
 =?us-ascii?Q?PhN/NP/Qw+ifIeAZLtiYz5N+Dygw+k0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0159823a-59ea-43a5-79e8-08da1843b492
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 03:07:09.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kG9UjttGiRw3JVf+jwyI08QGAOc5aSrKx67j79jMLLO3Ff/ZV9VhprSYJVdNJOr8vqf7ZUAqbYsGc8mjgfl0GBN0niA5yaYJtcy5AtXhsag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1590
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=849 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070016
X-Proofpoint-ORIG-GUID: YVpZ40QVgdXlllEflIKiZiI8VDmJlUra
X-Proofpoint-GUID: YVpZ40QVgdXlllEflIKiZiI8VDmJlUra
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

> The target code is a consumer of the block layer and should generally
> work on struct block_device.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
