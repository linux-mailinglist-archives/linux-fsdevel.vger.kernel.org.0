Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660BA7B08FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 17:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjI0Pit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 11:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjI0Phx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:37:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451451730;
        Wed, 27 Sep 2023 08:36:50 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RDSfXF001707;
        Wed, 27 Sep 2023 15:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=wjlE6YfW+AlwFRFW2/6YxxOJn8deQD7qdRzkMzwKH1E=;
 b=wRXY440RLG9P71w7uQgV6x9a0JkHo8HomcAUFcmvGz9G5TDTksGVNjLKRH7+i5bGNxst
 eOpEQa/akm9ytjFPlrFpu5mzwktVXc8j7wpC1JsU0s09Q+w1/Np26u+mmu6LiKpWVawZ
 6awbigAsgvaj4vsXfiTUeTOoFNHB0XhhqQy5H56aDJr8ScgDfOoWKFCAgKv3YcM7WtEX
 a/tWq7B7m1hxqtUG3WScMvb8jnE0coGbX6G+lXNhs690HlIi+pi2c8pemKmYu0TKVuuB
 O2hur4JjHju8MLwtbP1n97MR2HIVyxXorLZUstc5X1JeRNm7DbYCmlP7ltTi1ZZsON9X pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc1yjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 15:36:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RFK6OZ039362;
        Wed, 27 Sep 2023 15:36:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfe64tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 15:36:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCvzx1SpTkQam318gguDRgaiJ0JP9Shd0Z69IYQ91XYY2cacNFgoR8V/rr2WOIGtzTPeYdszwADrfsVxBu7AnZxnm9dIAmVcxWqjy5m1s5givmkbY2dd5qL1qN8JHlXz0tqtFs6kGoeLLgAg/ImTl+OURBZrPwHllUTPXe7KqWvFe2z1Wsr9Q2Cs44ZPPcM6SI2Wo3pss6643fcKoi6HDvMRquOKFkjMv3xgx6jEltSgYpsoeVgqyZ4IY4qWeQtxiMDOvJpVfRrg+7KWTmLbkn8bia7o9vWavj7u/5ekMrcgoKasCzUsOro5SeqH2538DPZA/zEcwIuXtXArR58Elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjlE6YfW+AlwFRFW2/6YxxOJn8deQD7qdRzkMzwKH1E=;
 b=lIVQs8/p5AkvvzSJ7YMnMbgUMgYdrXcJQTsgGLGE2cJmEYmnaJ4Uc+x2rJZMc7SiIrUSa107JIeiNLKTFzp7eq1usRuzX0bPRSTxvGDCy1NSdAIV5nMCnLTBacdJNiF0k/1xzrmkjN/51LEsdpFdQBgDpNk4dLvTGBTSSvxbUUt+asSqOm4NtyQGw4MW3M528SIQ8hb5ejTYmYMo4OF/rkP8diRYv+E7Kcq/Bp6+FmyL3T3raSy71OBBo3gIJr05EBxm82URhUpYActD3y6ZchpR5p7A0akbCRFW8HDuF9wnYVS9jeTyhHGqpyOOAfP3zWrM16CUNClXFEkSkU5z3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjlE6YfW+AlwFRFW2/6YxxOJn8deQD7qdRzkMzwKH1E=;
 b=FjqorI5ey3cEmC/r0bfMdDRtLCncsVaUA/mqMd6WanVkyIwwY2V7VUvF97lDOmHjWh+VH7U3Mn4DiF8vC0jdLaWJqDAAg7Pe4Z2EegBJJ9RPxeor7IkN+qcVDoVB3Hquz3v8cnG/Imxz8bYnlYLe6+gVhoF3hALA6PLFLEBxxS0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 15:36:12 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 15:36:12 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 15/29] scsi: target: Convert to bdev_open_by_path()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zg17zl0n.fsf@ca-mkp.ca.oracle.com>
References: <20230818123232.2269-1-jack@suse.cz>
        <20230927093442.25915-15-jack@suse.cz>
Date:   Wed, 27 Sep 2023 11:36:10 -0400
In-Reply-To: <20230927093442.25915-15-jack@suse.cz> (Jan Kara's message of
        "Wed, 27 Sep 2023 11:34:21 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0156.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN4PR10MB5559:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4037ef-881f-442a-ddbf-08dbbf6f7ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRJf1BhD6dWH3sPLVUtFwn4WhpDgMIXpdqciSKuv/Z0Ko7yJ2kgCzdjDa1sDTkDBRBmeOnwwUex/5bb/YkqNql9WmtC9P6qoi6F6v8cfTlRJVJMdcqT4d56iM4b1mibJYBVBWcNUonfMaZLS4tJryUNtVzLkK5AWaKe18G/S/xTCVJ5H6NhG6oZELdTyLvDaanYu1TKYGd75Fx4MCSkNa8AlbmbWU1RSkdNjbkRMB5P02bpSXNyuvJa9hA0OBROfUs+fJiN11Ai904iGQB0DByWZcTgdqEMqbaMwz1I9M3nCAv9ek9Myf+jgdEFKTw+FKT2dGsYlU2VwrxFPgzq3FwdcatmlZxgPeb5fhLxr6L23CUntqxsQT3wrLU7N/YTP0arAskr19bawAIJ8F6DLUJoZ5HDlwKWSy4WwR+CFamH6kU1ENPg+du/DNz/JoRj7l7tqXDZ1eEexaLQrAk8kIoMqAbQTbidBaQy93IDtPY18HHdSrqz67EVbeO58YgjIfG/NGwBNLtODZO3vKnR8zR3WqYR4FJ8zTLAo28/DrHMe1IUaI2Ptv5pVwMlF87Oj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(83380400001)(6506007)(36916002)(6512007)(2906002)(5660300002)(38100700002)(8936002)(8676002)(6916009)(316002)(41300700001)(54906003)(558084003)(4326008)(478600001)(26005)(6486002)(86362001)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?agUM1DkGQ7L0Wu6gA8qtp+YPQ0R0LUMgBpgIAj2JCJx1csgB2xbW3qXlMRxr?=
 =?us-ascii?Q?CbTYTUB12CpJhHujWVulquOP6LvzAU+1MFVnVFAcgfnyvmHPEEsasHhrxARY?=
 =?us-ascii?Q?VzsHNdYBVAO8YzDHy3MOxLdh7u6JJ22sTgNUbd/RKwduhnz/C3xXmV3UqX2p?=
 =?us-ascii?Q?icF3FUnbe2KhrZTh89e9Xc/2pPPiMpoZZk9woX2TX3qX2CVtxZT6RTZs2ZB5?=
 =?us-ascii?Q?W6OLFXqpvFec9I8LUQ7kd7shrdFppehcmHpuqk1mUpe7d+uB6Zi5pgNnrU7y?=
 =?us-ascii?Q?hUll42pKUE1oWccz7VGWrXhbLE0sH0ZpCelJqoDlvMgfiMCzPlZtGwnSl5fu?=
 =?us-ascii?Q?xbzbaGYmx3v/JIxbMVXVcdFDTSl12KvdSeN7603I4R2kAI7/T174uCL2bsaJ?=
 =?us-ascii?Q?85cb9H/Py1YbrV3M+dwuluum/pC7eqX28ldA7bJY0/s6ej/aCffmKMaV3sHk?=
 =?us-ascii?Q?2vJ0IFfXIre0d+MfNKHr11PlnQZa0ZI5HgMMQAe/4SYXyiFhgroFQBjaX+bQ?=
 =?us-ascii?Q?3Qs+BXA1Q2dQKg+9Q/gyW9BdVR2gYBJ887mPgbih/7VO7vj7zDdB9EY3bK5Z?=
 =?us-ascii?Q?qFrtIAg2nAdZOC7mYbRd638JaFtnN47GXo1/CjXf51pGA8dtxf4QClmMLDWQ?=
 =?us-ascii?Q?A32c9L7uYIIhHKdJZZwTAJ4Ebb0N8Ziwombv9c0LB9L9u1bb1TCGMg6a9gi4?=
 =?us-ascii?Q?wtWK/uO9vLeo4p/MXTZ8ensmc4ydakxOC1alcIfig2PgTGhJsDn3a8iPYT9i?=
 =?us-ascii?Q?OYJnUuVyIgVbVOHShDjZp/fuyQKCG4NyDHp4hoB892Flx42uDp0dOZ/FKswG?=
 =?us-ascii?Q?gY0BYsdBLCcuCyaRC5LDG589VwmklYGV+M/Oynib6wVnUWpl5rizCC68y5BS?=
 =?us-ascii?Q?4BBdk4sUgqfnuVtyEytuflCpNlrtM9Wpu8uIg1msQihCiWp/t/aU6y9u5rNB?=
 =?us-ascii?Q?FFnYTSLCjBI+6jHfkbT7Wrj80TERYYQI4E3e1N7E/DvUOgOMVGRsKSiw0AFD?=
 =?us-ascii?Q?q81KHa5H0KCQAu11N+Dglr1gebgbgQ+BFqyNkyioLiBXw1Xj8Di4QAENvNE6?=
 =?us-ascii?Q?PGYkQ+LByO+u/uP2tbJr0UDsn6PPmXXq+Q3nMwG+9dNSAIojM8462EV9a24D?=
 =?us-ascii?Q?e1h+TthzL1xfjPT+0FjMK6bGbAK6xnHWKwrZrDCotJdQzZlYYIN3OukZETem?=
 =?us-ascii?Q?80yYILJxvN1xZ/co0XCIzNFZsDlm6+eZfRzBsAoo37+nm1cBafKYIXAKj5rM?=
 =?us-ascii?Q?NzwhmdzyTYADhg6m4CM9x0yNIlHt5oVgQltX/mYyy7oEfSLFXnrOJ0xVx48f?=
 =?us-ascii?Q?DoP67piXfE/RhcZm3ly9ESp/p14hiDh17rx6OLmWg+j9w8qWtneZyr+kcDFm?=
 =?us-ascii?Q?Kp/Q0gtg1Oz4oRUQQH50kxT36DtInVQmLxjGrHzFXzR5OGOxKdg0kYSfc0kh?=
 =?us-ascii?Q?EGj8Jk8EEBEuZ7TJV1nQr7DfL+X9sDL/i2PnjdNUS0JXPVl6A7rOdzW3yKB4?=
 =?us-ascii?Q?fiHk3PWGKM0Y2soMNY+pK8bf4HVYfz4J3Ay/rn4sKIBRewpA8fqqpG8Us1ux?=
 =?us-ascii?Q?tKL87SHU647JuZXbmA4FywDvURFftjv9eBIRQYSJ/i1F1bcCTSQqxhdraVDg?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Zd3fsirqGr+8vh4fl88B6Nz0NfZ0w83hich5/SMevoOFau90wiy8/rWWgvY9wzzOf0X2qW7xDcXvhkkWxTJ2e9IHuKaYFG9AepXvD4eg4v09qeshAWdaIITkEN8MZhDiG4b8xrgOn4sPGP4K0fgquRibk0BEqXpzFyRMou6KRc5QIs3zbHcM0H2zwaYK/usJTMvedA7h/ZVgZXZekg/O6aNzXCKkU9JdWTFM+5YbwRYn8Xp6QvaT32JHeAFfq7VqYjAbVJaHYlO2gYeZx5+rvTZq3F+Yb+E8XPfRoU+V2qyn+N7MkUwiDm66u5p86eZSvou1cLH8mowvsBivsYAaj8yoP+Zd7nrOZITrE18EuHTQ8+954Dtl5bRDuThea1S/MiWOWRrIZiXU944NDc82slV5YMCIWlT4shzBKdTRTGkpG8DfESSBfjONs9M+OI+RqBvlvSwUvZAe3F0bvfncaZXcASr7bOK201GwVAnJSRSqiNWWKw2SehVWQ25hxWlERJfbei6z5Pxq/P7urDuoFc5SJ0yaDnatOG8gWUrBrwfHZjeo6kXxTtquBTpfNrwUgmD6Hcq98ywS8hmUCJjeJ7OLiVG5fH8WhXKq1rIlqOtUZ6oaung/4CVCGiVk5d/AJQ/eCRRd8z13ppY8JFukQlgYKyf+yIHW7mceeG/sNWF91+IBt/n/KQe2NQQUWOjUqVWm3QOcl5lVfwdZ51iO4bnj4FNzcvjgcg9PT9b9q4XtiJ5HH9Wf7fOkSKoEr5vpHBX9/g4EcR5m6DS9TLiy40Zd3+TGENOYLgQagErXZ/prvhlVImJXtaX7GQaLcztbNY4m0tY+sci1HhSAKt0It3PDtCyK1oFKGxyuX/b4UJZQ0SU0ONKGdqIH6zRQeZ1p
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4037ef-881f-442a-ddbf-08dbbf6f7ad2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:36:12.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ms2mtwH5sWja5oAXzcKn0vQYDeZlqK7+SNxjpi4fpND27/UCQuJvhiuWxH8UOy9fsZcT9hKKO9rTLiU/HXTLKOPOMl65RraEIy3osIW+FR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_10,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=893 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270131
X-Proofpoint-GUID: bBJ7RMHHqer3_OnSkV9UW8d84cO9JjhP
X-Proofpoint-ORIG-GUID: bBJ7RMHHqer3_OnSkV9UW8d84cO9JjhP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Jan,

> Convert iblock and pscsi drivers to use bdev_open_by_path() and pass
> the handle around.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
