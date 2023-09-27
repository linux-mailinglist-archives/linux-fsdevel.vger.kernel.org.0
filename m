Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AD37B0C6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 21:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjI0TO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 15:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0TO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:14:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD2CE6;
        Wed, 27 Sep 2023 12:14:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RIx6nW006412;
        Wed, 27 Sep 2023 19:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=d53NU7Ix4SpWg+4SUr0aoGEnj0Ux1rTPnW6bvpFD7tM=;
 b=kLiVXzdFaWvT9vS8uSZkV/SJU0CfVWbWwAju17XYDTCZmM8RDJgjaDh5lVjcaESTLVPT
 nxGT0t60Y4d6nqyLqu7qAu9MMqo/MozUuAAPo5bq+AGYvzDEVphpYin7y50cQUXRPXMR
 jTXdI+ImUYqvxKN2JmwxbS7boz/ryY7lFyzprsNIYcya0J7SqRHJ542NwQHa2IaklLgU
 RFj8dT2+D+8vxsJ7KqpKM9y8s/Z4aQa9raujw31QUihFveeyYc34wAp6QLLHR9x4xqzH
 hcK34XJhWThP34jjD5Zk7bBWsjfB7QTH3nWUuhAgC7rEL6B0ogH453MuAiqf3tC60ejv Dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9peeabpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 19:14:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RIWYx0030785;
        Wed, 27 Sep 2023 19:14:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfee1px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 19:14:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=algJg5XkHvSvH0rVQAex9qyilHu3T6/+2I9NUQZnP8eqSqTW2qnF36TcBZUOHsJSMdO0VWOJaHZwavQ3kLsN3VVasOiTnHsp520SAhf5un+ezQ7WoknVuj0L3AxFMkf8QTx/U4vpfBy3Bw2ZZLzuEBEk2CHGHGU6YgMGvke5TXIJYoGm+6XTWAg1SfIqoBgawedSGyWzYFLJZqyKpu/v3A+A4ms6FF5qd72I2etPu1rtf7MaoqOUF3o4IkK0+FbItCGwmsLiRCKhg+P2OKHhPCUL223i8YigQtWENkIoZa2HpWkkaxgJa+yWiDSOFVXStR4FIXTZAR7OxMe0EjkSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d53NU7Ix4SpWg+4SUr0aoGEnj0Ux1rTPnW6bvpFD7tM=;
 b=LHj1jYCXxAv5kewMmydAauvToKgDA88Rihqbp5yEZtPQP0HYghzZNAqzwTGlVMALFl4AOaSleI1MZ9OdjCcBUxvvZbBrjxfvPVpGLld6eOTeOqBXjUCLsbcuRt8fe3doPvkZJKG81MArwAwJlKPUXrQOZ6qYnWHjzqjxVQdpu+1IctDLi/9SzTBAnlzv/4Zu/CFSAU3vdBFKq0XXFtdy6Mp/zymzAg9cF8g1mrtFKJ/BA7mWeLfqOuAsEN3U6Ki4hKQdD2o2hZVewPZfhyS1PGJUHRPjbwcMjDdCOHAz6gXc0fKs/Woj4gttONyufzqCLKOYakJvlK3Val+QZEEq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d53NU7Ix4SpWg+4SUr0aoGEnj0Ux1rTPnW6bvpFD7tM=;
 b=KCpo6UAamu4xlqcD7R2zHUA4teD1bt4UHtffFVULaUY27hoEjdYzjq8oNSjQuDRHVoaxgd+tvYEXSOwHlbHTQ9bhht8kXQO8RJ/n3qZwL1dm4nrcwOZ6o+ZsqDJQCGPcqvW3clZUKT9iVmTgUXNcGXTApX2aWt7Hy7EYO3fb7+I=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4667.namprd10.prod.outlook.com (2603:10b6:806:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 19:14:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 19:14:16 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7hnzbsy.fsf@ca-mkp.ca.oracle.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
Date:   Wed, 27 Sep 2023 15:14:10 -0400
In-Reply-To: <20230920191442.3701673-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Wed, 20 Sep 2023 12:14:25 -0700")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0165.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA2PR10MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: 8869cd4f-156d-4696-6d1c-08dbbf8df16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3ky+UL1mOzN/iZLdTpAseWlaB6Z6xpekXKPtQqigsCm+QzmQ4bgg46iKOfvd4MqE43v3UedTMCApUTK4hQtLCbRV3/2tHKxI+lKf8jPIc1moqwg4mV6j3lbfGPJ6nK+qGPThoob0YYVMtsfVADctvG9lYqnanm1kF+hZqHHjfdcgYaBypJClzXhOwkYw/oWsORO5ITB5ctLlF7qZtKXUPynxNwuRog4GTC3P1iVA2QX6Wj13HdiQjDW5D07Tp3Dxw5CSM77qIK9TYVojLd5y20lvEMrcpo4PWe0r4/BHB07FTREItuRcJMy8+FFNLVvgtQoC+sKAfcId+uVLPD9+gAzjIUx7O89lQLHV9COoEV0h23PKXg/s7Xjz74L5DKIsH5jj30kPjTb+3depwNGAQF1P1bT3qh4wbdWZEd01hfRhpn7AyW4OY1MLxMcyK9WYluFzI1bnd5yEtWbW1ZRg6PiVyo0H0tW2UvvsPWMlpcU+VXUIPn+BHcy4o/wekpD7b+aBzlah73g52No5Hemn82c8Xue2SVI4LfNMA0x0Gsi7F8/b4Bl34QeUe1PNdJz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(6666004)(36916002)(6506007)(86362001)(26005)(6512007)(83380400001)(41300700001)(38100700002)(316002)(8936002)(66476007)(54906003)(2906002)(66556008)(478600001)(66946007)(4326008)(6486002)(8676002)(6916009)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bsu2ARhxBfqKtQwXl+zRsVJLknIqn7lzO78SM0Yqt7l5JoiWWclt6RwWpqmN?=
 =?us-ascii?Q?9L4cUzUjHmGA26xMYAkg914c80CnRqIBIAlm89OJFNPiedkrztGZXIX59pNe?=
 =?us-ascii?Q?LMXOMCGUQebSn3b6JvaYplAdz2r+2NNqenNM0YuKccNHtoj8aQmyoU4dzgAE?=
 =?us-ascii?Q?Ny/7KT41vhqukSwxAI5fX9yzz/k/V6FfYPHVSDxxStwQoYWPCRH0HdUGaSF6?=
 =?us-ascii?Q?RPWxpz09ABoSm1Q0R6wNxcBHCeC4IJzQAO162l2ZWZTVOca4rE6JmGAaElFL?=
 =?us-ascii?Q?iT6HOOZnjwUeLWrI41ujczvZEkNAn+FAnMsLvNFYKAc9xomIuw5/KjcwGeG5?=
 =?us-ascii?Q?hTVdquYuP0sW3eGu0g1Fgms+Abc4YXfvV7HbnZshiOpr2KGnd71FMsLvIFGU?=
 =?us-ascii?Q?Cmo9Za9UsZbuy8gLsjT95LLRUZX0+UolbHWSwwAKhEHVR8tM4fHXq5Q/6J4S?=
 =?us-ascii?Q?MK1e5KhtauUDUp81+iTD5FHRg4QesqKQklXJda3agQotGxdhcV9TmLLxGeO9?=
 =?us-ascii?Q?T49HPo+XXK2yXQbNo15lPxycAXIyxjX9G5eJTUt07cEXfb1Py7Mgo5SdYtKN?=
 =?us-ascii?Q?cE3oLWgYjUU5ADPCXGNTvFilpIDBZtlyMLc7fWrhtLvEuJbD2qKSlTAnpkOU?=
 =?us-ascii?Q?VGfepSAyD9iJ1qYaqBwC/SavOsCXjTVjB/5NR9CyBJgTbzjrtFHzHC4y1JDi?=
 =?us-ascii?Q?5T55RAHknKGoGk5TiG4hgO90Lkpc61mfr37Aik+yGwHTtOcoPAC6Ufr4kgim?=
 =?us-ascii?Q?JB06qNXi9M+SzJ4NI78GnBDuHWnHOFU1ropG6najBi1YbKK/DRqCa3cZ0uYT?=
 =?us-ascii?Q?tdTulv80eAVoqGr3v+67qmJFO+lED8HBd0Y0ri3QqqZMMWoz9jbFvE3UOptw?=
 =?us-ascii?Q?piGe8/riB4UGWpMoKVDc1UbbdeSMhZwIrGfm4Tij5B3R4ezygFUKBstp03m1?=
 =?us-ascii?Q?gUBzA7obTrZf235JHVzXwgbNxTZS/oHk9aHukSvUbqIWIxkash7LQ7WNrSSP?=
 =?us-ascii?Q?lQtMQWXxhJ4yck5Sxwx097PleY7DBbk1XSh9UE0LM7s0ofdVLUZmKAnuTieq?=
 =?us-ascii?Q?ODUF3qTxPOLNGgL/BO2O0Hf/XkHkhf7oOLX2kfEyoBkW2VK7GvW21vzDf4FP?=
 =?us-ascii?Q?Ji8Lmya6aPKMnMGOgQTVjjpLc5pyeFdAqPmBWwUwUurrZVJobJrZMobnQdKX?=
 =?us-ascii?Q?5Q0HyKp2AXgJjRNg/txCvotujIc42+oCEw6x9BuEg50eYyX6Q4E+4b35qyUX?=
 =?us-ascii?Q?ZGj3NYCZXnZgiPWdk30N5G0S2N+R+CKK7LyL3T57Bv3U3QOdb+EmhADsftJD?=
 =?us-ascii?Q?ZI1rg+oSXGvCUkBPRRC8ARQGbu8tE2nzvfaE63anoRGZtxwqvHrVYFnaPfqA?=
 =?us-ascii?Q?g0HDN8bzTKn267KtP3LIf2Kv55gFWIUEErfmnJavGF/t1EsN3GmOzWoSf8xk?=
 =?us-ascii?Q?jhemZSImj2hqRpuFYfa6yO4I08/13JA804nMeM8P9I41EU82qOMlFeUwdZVb?=
 =?us-ascii?Q?sNdwRHNsveEyzD+UZy05yjmhlh8rcMS1Xt+1CmBakung5H7loAd9eU45Gcv3?=
 =?us-ascii?Q?CXyoJ51F/Gp+WrRUcm4Yq8AdzYUQXxe4b5V844cwDjqOjFkvnmSEmmj88eXi?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P0FWH5sVbtMwSs8QIYmEfdiEsFXqJdmkkvHipxlVObM1C0L0ZzsZPebt+1SM/wUpB+P2ndj1hImwA5Fktn6gxLCuKK0eoTl29hMTtGLPkluqb9OEOclwCjPNtqVOiOJj42XC/mmIMf0FtnxWKwRSkbSA8U7oRDSxOonHHiEGdxjXmJ5AwF5CnwCx3PVSmxYeaIqnSF3Yx5cOt8rappnlstgxkIgTsG480bsPgVG0ZgFzqMez22sEySdERgoMO4AgBFEGw/V8g5rfB17U3MRGGCAIF+xcixNbsU5IU8uJgQjpXcN5I8HvFo9IHNvDxEGarPABR7ruOZLiBHufAen8o0iYDP4xtmlbAujF67gwVlo0NNd5W94kh31I6B83grl5mv+hn0ZferKiBXguiP2hoAg7SaXgwo+EBDzYlTx3qQKCjR9CxEM6uN+kWiCNM9EVvaJeSm+FbWjzPn+i/J9Z9FH2OWK9mFMkyGd/x6X5zY2k4YGYgE+P8SaTS3obc4Hjp0UPtkA6XhpVSxgSiTXcxJf/x/Xc9Do/4NB/0qBHFmqtsi1ik+U6xdmv3M56r9hJSyiN3SoIKf/64DWLp/aLdP1Mf+dsULLX4ZD7vjDzBWUXE6PvU5GGBVlz1joY6aLxD2xam21srxrBFQdttaTojHcaWQ/BcdGI7GRKJha34IHk6AVEj95Dy4CC1WteMae3cxRetFEUhhBgwvfMPc6oRWKpMMqhOYyJjarcRn2y+19Jk2XCEI8fhbx+k0ythqj7GD4c7UOhyz5Ao03HhsNw8TUMAegA+YKkxofHqztOFIVFtAaIgfZCjC+z7vkqhQwNzd64fnDLjbMqO4XJDxQceg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8869cd4f-156d-4696-6d1c-08dbbf8df16e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 19:14:16.6323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkoWjKSunxuGI/U0kaJE/PEBBhgPcM3OTAguKFYXzt5+Fs7HxJEVZY/bEpcm8ai8lF3F3f9YMGMGiAIJIFHZZxvm8nJq3A+rv1Ffd3OAvvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=523 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270163
X-Proofpoint-ORIG-GUID: Iaz9Lg0QV-CbnXF1krjkbxd4slInMtup
X-Proofpoint-GUID: Iaz9Lg0QV-CbnXF1krjkbxd4slInMtup
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Bart!

> Zoned UFS vendors need the data temperature information. Hence this
> patch series that restores write hint information in F2FS and in the
> block layer. The SCSI disk (sd) driver is modified such that it passes
> write hint information to SCSI devices via the GROUP NUMBER field.

I don't have any particular problems with your implementation, although
I'm still trying to wrap my head around how to make this coexist with my
I/O hinting series. But I guess there's probably not going to be a big
overlap between devices that support both features.

However, it still pains me greatly to see the SBC proposal being
intertwined with the travesty that is streams. Why not define everything
in the IO advice hints group descriptor? I/O hints already use GROUP
NUMBER as an index. Why not just define a few permanent hint
descriptors? What's the point of the additional level of indirection to
tie this new feature into streams? RSCS basically says "ignore the
streams-specific bits and bobs and do this other stuff instead". What
does the streams infrastructure provide that can't be solved trivially
in the IO advise mode page alone?

For existing UFS devices which predate RSCS and streams but which
support getting data temperature from GROUP NUMBER, what is the
mechanism for detecting and enabling the feature?

-- 
Martin K. Petersen	Oracle Linux Engineering
