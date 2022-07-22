Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76C757E59B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 19:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiGVRcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiGVRcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:32:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E688CD4;
        Fri, 22 Jul 2022 10:32:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MH4C3i008989;
        Fri, 22 Jul 2022 17:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ADysLgyIXdh4ivcePcpPijOOjZ5RE1xWodnaQl2zMDw=;
 b=ZK9KkDsTsDfwP1Gzl9xBHYTsrvzFECl2wx8Bfg2SOSmG5e6pR1g7oVxjSIlDimJ4uAqW
 F29eDOSDEEavphu5UGaIvVQbz8hKuXO2SkCuCI3tPzNgjPvxZcgHywaTwh9raewEUEWI
 KfvBLQhEvI+LL0P3V6RRvI3dXolCXi2ETQnKd4TLPbvTsftkn+WBxAt7WjYyMPbeyt/D
 0vq7R/dNv5NueoSQjPsQI7AOpJ7fygB1A8UW0ai6ECEWXpmfw3Gf3vEkEXLEs+eJi1pp
 /wwT5+eb7dSbXUvdlbMKSxwoDGx8q/dGvnr/6AO6GbYkA5d6//rbpJSvEcXrRUo8eeJj +g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrcfpnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 17:31:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26MG4Sx4002582;
        Fri, 22 Jul 2022 17:31:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mekcpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 17:31:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWJbqlL2d3wHX/IssratFxA8d6viH7IMlDdna0eX9IZ9VhL6jXojQQ4Q72L7/39sv+CLH3dlBzqdJLh0UareL/wh6+lBKoBKRg3xBN6wz6Z3O3TJ+AsTCeYK3dV4kZpXbbPAonIrixAgSFvLsYI4ZX1EJmcgWqt/5crQUFiyV3j12weFmNnYUzB5P1RSNq8andPpWdKQCGbww+DieZ51EqDBM9uBsOChX13/6FMk38nIItvEV/83Qsm4KvDr0WSLfNLG5dTBgrgPd4txUEkCQE9Qf8hXSy/ia4jfqREgCf2713WXY43zIE1cfYmbDsegDNfh/PRkMuNtNgewpJrAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADysLgyIXdh4ivcePcpPijOOjZ5RE1xWodnaQl2zMDw=;
 b=ckWLXOUqc3eRwd9ZRfBHJpa4CF6YXsq2TdYC5DvxYwAnWi95IXzgND/gndhQV1mv132ISsrnRi0jdoOh+EWoRTgrjnImVjjGX7tTuf2qXddSCEUuyIqn+19ytROrKbWeBzReAljJq+hTBdscBvETJ7iAbHh5p4/wQnH69yw4gS4z4DhcrRT2KsBs9f/vcltMWPS7K5Dg6qvUolGgerj9oLxEtQWSZu8f0inn4RWbrJytsLIxO00Q/3xkdBmQmLK9Pistuc3i1iIA8/PYle9zaDWIuaXeVBx6/UF+xv52CrruCkNwELvctXLIFWrkTC7krw7ugoW1Uf0TG0rpWYIoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADysLgyIXdh4ivcePcpPijOOjZ5RE1xWodnaQl2zMDw=;
 b=b10S/1+gwzzOGTQGCoC9Hd851ej7IbbxOA9aHYQXNtF+jM6ib1h8o1eNyTAhs6EkyPnRV+EB6Bdz3xZJhO+wtH2mGZVNQd0GsTwB30e5HFzyMQwXxGWCmSFTeEmA8Z+qNCmq2pRfjgIFH/fkF4LAI90z1G/9FSQc7IRKQ1LqG/o=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB3828.namprd10.prod.outlook.com (2603:10b6:a03:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 17:31:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 17:31:40 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 1/9] statx: add direct I/O alignment information
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fsitjbqn.fsf@ca-mkp.ca.oracle.com>
References: <20220722071228.146690-1-ebiggers@kernel.org>
        <20220722071228.146690-2-ebiggers@kernel.org>
Date:   Fri, 22 Jul 2022 13:31:37 -0400
In-Reply-To: <20220722071228.146690-2-ebiggers@kernel.org> (Eric Biggers's
        message of "Fri, 22 Jul 2022 00:12:20 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::8) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24dd708a-b4df-403b-29f8-08da6c080951
X-MS-TrafficTypeDiagnostic: BY5PR10MB3828:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0FRra4pYqqdoFi7uYVVhmyD1fhfQM+tLfV3pVuh6PWz59BqnUVDh2Seawa6YM5gzJBvPIrMe4JSLc71K0A4us3mz7k7/PzHHyBMdwr3MuDwzefBAABG6dRFw9So8cZOOmfXKROnEgKP/QT3XVZVKvL25PSST2Vu8lZLbOrjYgXI/91T17oHGPkGUZQocJwlHzCgCZLk3ikyHsb8IAUqf9azAG+bQ+rmqAJP/HHbxkc0rjyGTBGMzO8a7VG0d51dDO0Xdt06ykHwX35Ri7Zth7amt6l3tm5evzSUwweoyW8neOmEqJ6F19APJXqRT+bqP1vAlqP7l22qAp2xB10ZJW5B0pH5dR8lwO2FCdBC6Aji8mzCti4jXNBOhxsN9eHM8g70WxQdCnlJXcm26+BPPAZxiPRCLmAwtb3CEDD1Ra3QlOPkfLKbBrPGMcCY0Lwlzl8I1c/1A2mLR5jJXNNyV9IIDSy8Sj+GJGEioR8qQCkwr3Zd2010IWZtOo9jCa3T97UxvNreP1U37hpT3pWAepMkKB7zLkZo8bjqkOD9MOqLkdCLDY/Kb+aDla1f6xwbliSqlF4hnRQJ/LzmBoEULjHVXWKzghu5fINNbhUe7hVg81hlEkipzfNAiE4B0KILOq1g8otrIAmDz49KIBVAbFLywMdMs/u5ZsdaFJ7ZvC/aIgA3tp8ZjMT3IBtOyvdbohvH9ddhqVT87CGbRMKjvYwoTKXKhGbUjxstjyYZkE4y/68hv1v4GP1Bzcx2UYKjJHO+jKtb5FyZJCcxEfkvg4fWysBr9N5/yQS0urkczusjbAmRDFHU7Pn1EO2awyE7W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(376002)(346002)(136003)(6506007)(186003)(6666004)(41300700001)(52116002)(2906002)(36916002)(38100700002)(6512007)(26005)(38350700002)(86362001)(5660300002)(54906003)(4744005)(8936002)(6916009)(7416002)(4326008)(66946007)(8676002)(316002)(66556008)(66476007)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dzwd96FM8nx1tGBiG/ngGu2aqEf+U1Pt98lTe06EWBn5NBUAtAZ8LkLXT8Xk?=
 =?us-ascii?Q?WiH9faQotWRDBj9PsPQ7Eqxb5kRPWmoFSAsYlJ2GOqDVhg4tZRvnxzGWYoBB?=
 =?us-ascii?Q?HwZZso2kpDH8imV2IMQJSLzQkWAsK/W0mUBfITXGVdmDYLth+bpIGX7TMXwY?=
 =?us-ascii?Q?dvskNhd9fTLdmH9U/Mcy3e8uAEGWWU+auoD8FdZLZqqm78Zrqx0gaabrf6Zj?=
 =?us-ascii?Q?iRKpMReNh7hXera41veaKenT93jAkYpWDQAayb29x5xUy4XW3npPWydgvU1X?=
 =?us-ascii?Q?FTQPxVtVIaMJ2nebTxrllnmU6SkRidYK6PplLRiRpclW0LauxPy+253CIzEB?=
 =?us-ascii?Q?NxKKyoVijpmQZuELqW7i9JwsP7MCZ+WeUa8CtzcAB3or9fzjoo/g707jbONI?=
 =?us-ascii?Q?VwS+cSdVQ90wpxNcXzwU82Liu5LDvBOhG9CzR1KD5waYkJaG6KIqmmxbK8kl?=
 =?us-ascii?Q?LGs/7Boma4GWHupx54lkg4g3HSIIuF5GYBQ+rupMlm8X5nfCjCJ7ZEBuU3z7?=
 =?us-ascii?Q?ZAbl50aaPsEQWpxxh8axicBr3vee3wV9lo0b+d73+jbKgNnDUGfGeWW8pZcB?=
 =?us-ascii?Q?nG8AQn93XdZIee6jH75CZEZ8QenGC4fxaDsRNKUufWGyYs0Le80aWNhqBIhJ?=
 =?us-ascii?Q?SLp9qDeN3Vfw83MHut8sWUWArASOLrmFu/6SmZgwtoUmZmrD/zXX5R2IOl9E?=
 =?us-ascii?Q?gTFydH7l/DRcuJYjGkfxoMJy3z9QM8F4xGznQLW9CxwZjOk/UAn6rUtuFO7H?=
 =?us-ascii?Q?4JvNgEXY9uIoQD6AI5WlHWx42KqZLYbgDu15PFScwf1VDsl6AljKX0OdGysl?=
 =?us-ascii?Q?fDrt2zCon6qJ+nAVFlhG8sGdeMlUc0bD/WaKTEsZISJc9/0ldIxkPG1Jdbwq?=
 =?us-ascii?Q?pWeSwnqOMxO1FrmdS0SqOcbPPq09NxdmHP24E7jV+RAWoOQAkZbI7y+Y8ndZ?=
 =?us-ascii?Q?RUokigI6EDVG23Lf8zYxvcUSD6MdOnoH28dNXPbw+77wgXXHZQnQ2G30m6pP?=
 =?us-ascii?Q?bEhS56g7NXOfRJllFdAxT12OjGTgVaciLrc/jHVXa9xKSufnUJhzmJ+uDVtg?=
 =?us-ascii?Q?HiLV/CosQDeN3aayA9GBhtvepeEM5vOd3Dt5xd3GMgOhnF93HSQQxWHJgowO?=
 =?us-ascii?Q?LBNoMilzo5ZelMWGSOwix552NMOwVGORtM8LH99iOCEUyIs4y5az0My9CROW?=
 =?us-ascii?Q?9kCam7ydH0tHq1rGjQuaWL/9wYGngAlLn4L0bJ1909eWjpGANuhyGiG0/bTr?=
 =?us-ascii?Q?qELzKcjp/VWhzAMNz3RKc4854UneUOoGLdgv0iTlyF066djmEZvJUpPosFi1?=
 =?us-ascii?Q?Z6VzxvCNCD4Bn6KQlbKZ9JWVLf5ZgX6FoQ69i31PuXzhXrD5s3pg0TKaO9t4?=
 =?us-ascii?Q?ULIMFKZYEv0YxFIV3I6IQxx3QqVhIBArv1uvR7D4351vVV7beFT6IkqInX1Q?=
 =?us-ascii?Q?+E3JFkVSWvFozNvmluM1cJMqFMgK/dlksXathqoLFKe4xMW2qtMtHLZHMeGM?=
 =?us-ascii?Q?efMQyhc8hoeetyCz19KzTIAomAsnPIZDYLUmZNjUACBsnBMvSrgUM3bfwAhT?=
 =?us-ascii?Q?zGh7T74yfFCE3Rp4g15Jst5VSyGBlzJUaj1avxR9oztpUEnq2AvejAd8L6+y?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dd708a-b4df-403b-29f8-08da6c080951
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 17:31:39.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VL3DpcVUUBMVCpsskuI04bS5wLmfRP3XfSUQA8ToWejXGHVlbSLGTxBqxTAvTy2aDqB30KRGGmwnYwLLSbFCI+9f1gMIhWgaO4vyUx9j0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220073
X-Proofpoint-GUID: HWlmaJ5ZR3HLVBjfYQxsutj3rKOxGw4j
X-Proofpoint-ORIG-GUID: HWlmaJ5ZR3HLVBjfYQxsutj3rKOxGw4j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Eric,

> Therefore, let's expose this information via statx().  Add the
> STATX_DIOALIGN flag and two new statx fields associated with it:
>
> * stx_dio_mem_align: the alignment (in bytes) required for user memory
>   buffers for DIO, or 0 if DIO is not supported on the file.
>
> * stx_dio_offset_align: the alignment (in bytes) required for file
>   offsets and I/O segment lengths for DIO, or 0 if DIO is not supported
>   on the file.  This will only be nonzero if stx_dio_mem_align is
>   nonzero, and vice versa.

Nice to finally have a generic interface for this!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
