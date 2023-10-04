Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FC87B76D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 05:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjJDDSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 23:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJDDSL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 23:18:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF65CA6;
        Tue,  3 Oct 2023 20:18:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I568X006412;
        Wed, 4 Oct 2023 03:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=nQSLwpcJ+bTdf8eWuU9waO4uCwaVrdWckvtrKloteJM=;
 b=NTCwIwXay1l5VsCIGxPOT2Wj/cHBFDF6Kb5icQVNHs+VWU6zFb5EXTRoxUMDRphlgp0g
 2tKBWt2l1pNkkzWMA2G2KrmZX7hm2HlCItbt0chS+KS5Pn6Ea2E2L6dCFD3PFq6SHs2b
 Evm1at1u6ZGRvBAs9YyFSXQu2uHHRvguyhBA5pe2SHTnjhsPdUFmVUvcQq5treVKIJmQ
 nLf8mUt9L1GdkpOz1ir+TzkMSaJvAgz1HoUevJHEaKEYW8INSdVtZueouhzFXuhK/1Pn
 KQb+UhR8z9gKO3uH2T8WISy82J96xWtgCy9z45dLZ61sfOa9oSS/BmAG1YLTfAx0nqUi Mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7ve1fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 03:17:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39411qHr033708;
        Wed, 4 Oct 2023 03:17:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea475hu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 03:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrXgU03vavX+HSI9SzNn/gJ7P+J97/m2wW9By41QsZkZ4pRn9yuq5lg6E4hSog8MfAQSzEy+j29mdciL3PnHbkG78NmnXUEhKTFnZGtFN4Gt1tZUqFTHLqybXWkHiLdIW9Jf+MsnbiyPjQk9epyv+BhhG7DeGMaCKcnlXqrhInWGQ5tw1OPpntFUeonqZxGqDzozURPqKGyLwVJ1qamInlr4s8w37Hvo0gqRI+YrwvfT1IgjBphs/xEO2PEYN6YEv295G7EcJlNawUM140T2dGckxun2ukJOZcIMdPHObOvOM9ObAoz8cXNBq7ep8el1QHJI5i73XfcXF4E3Yy/1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQSLwpcJ+bTdf8eWuU9waO4uCwaVrdWckvtrKloteJM=;
 b=cbngEjZcfOiedZQz4c2D/+2ZGpnA+wDO/sYylDO7iqpuekVmQC1JKvegOCSI38Xg1ihitfy1hz94q4wrXngM4aNfluoLBMJMsJADLJHA8OSvM61v7CVwMtfaTq4Of3vhTwoykZasCbcJRBayU07OSEfg32f2yxONnWRSKKAFSAI9yCTVCiERTUDWpNWtM+rAxJkZIedIrXEOdliCu8lpjW4ST5mX4d/Y8J7BWylQgPlOENeN8BFoRWiKybSIwwjGe2uXYThwEXYGDglZw3UetqKzAXga+r5/vqPWUf+JpdT90KPDZHdDAeC4oMMLm5eK9R2OfoGRz1jmOW9BydG9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQSLwpcJ+bTdf8eWuU9waO4uCwaVrdWckvtrKloteJM=;
 b=dY19qIE07ViT7k/grvAOZ9eMu/39oV6b+YZHUimLgdLlhFd9lkXwLJLlSVZEAuPLaH0sSHy3k55qLQEljsqULsszul+8uQlXjsujZhJzm0aRR8DqpFEp04tmY1nTtDS2Q1H0yVu+tNjSfp+DZ4bjJBydbuwbMHcupv5WWbJHJ98=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7511.namprd10.prod.outlook.com (2603:10b6:8:164::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 03:17:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 03:17:54 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15y3nrstk.fsf@ca-mkp.ca.oracle.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
        <yq1o7hnzbsy.fsf@ca-mkp.ca.oracle.com> <ZRqrl7+oopXnn8r5@x1-carbon>
        <yq14jj8trfu.fsf@ca-mkp.ca.oracle.com>
        <123f0c8c-46a3-4cb2-9078-ad71d6cf91ef@acm.org>
Date:   Tue, 03 Oct 2023 23:17:51 -0400
In-Reply-To: <123f0c8c-46a3-4cb2-9078-ad71d6cf91ef@acm.org> (Bart Van Assche's
        message of "Tue, 3 Oct 2023 10:26:27 -0700")
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ead91a-3660-4e36-a7a7-08dbc4887fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/gFSDJ2xObCK/GKyz2DsWNltfwUPQz5p3KHklnVGZc+w167uYmQzW5bVbbR0fu0ApoEmzphzfwYWixmm3rc1tVZ4IRo925BCBCcrwB/DMFhZZQ6GZUFC9hrYNr0BixnmxaPNsL7gJw/PHaHXEcLMQ4hYCXaNN81gjbaeZbecfKFfQCCemS18rSb+e2uXBflUHHzThwcxzSk9ueyJZpzNRzCAPlVJ3eED6cnGRLYVE0o6pMps5XApmHPAoTXOEtbYHHLvlqGzNSdzVTppNdDh1hym3V5si/cbIueaHZkJDFwcRjzIuZLXF2miWZRlHs9Eywvu49qdHJdg4TUYUKz82/E1QBpOkHufMFQD6M/XGWojEr/nT4m7Bxj3C/Ae+a636HDXsQyWiYKsX96jA/Mw7IZIxukDlBraqg7Hp4a5mI+n30ptnI1jQ9d7Qx0UKAsLiF0hme/2w+l53sC7txXDavLCiMzRpnwCgIRlpQSrOkvpCDUxcX2pg+aeW8mMM7OKWiHD+l7oHksIL/Xm4SojVuCKQjoJiAn/KdBeHu+0hhNmO5JV6axTsiLlYdOzUm4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(54906003)(66946007)(5660300002)(316002)(6916009)(6486002)(478600001)(66476007)(66556008)(4744005)(6666004)(8676002)(2906002)(6506007)(8936002)(41300700001)(36916002)(4326008)(6512007)(26005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jWUAozYZm3b1J/FojILZ5e5YUrlG5ivSMeUlsD2gfKtfjzPAEFzJcvB0Osu5?=
 =?us-ascii?Q?LuUWc1E0AZ3ggw2E8sZBFPTtS+4PsmrwRAXUL9kTyz10sjYkWx3bxMuUbcpk?=
 =?us-ascii?Q?PDmsHBnuUCNA5fgs9BPkbRSo32dIExKbhU0MstpuZZmcxrRaC6SjkuXelMow?=
 =?us-ascii?Q?j4wBgtK6EV9PCtv4evyj2LRHXoY9kSK941KduUCDNCITxAfvcYehmqLCffzP?=
 =?us-ascii?Q?4eupuu6C8+ALKDaAM7Fbe13ifB6QdTM2fVguCd4Mq97CyYxtXUmCHqLxyOxp?=
 =?us-ascii?Q?xDWJRLZOl8XwrdiRDnzTO19bZMm7OFJ9wyzOjxmVOduVilGVS3lfpr87xfLU?=
 =?us-ascii?Q?IiEMTWWKt3pb1yXTpx/70tdtn43n3lNaiteu1KR6hqkWDrgxVgBc+JQdlp9f?=
 =?us-ascii?Q?cgzBBtX6+VUHkRYdPyRsP1bxzIC4EqCA+TvUAbqIan9JqspsHgqmslwbSkiM?=
 =?us-ascii?Q?33+VwRyx7pkN6ke88M8LZHNDw9qF3ipdgw8NzPJAl6TIlDNu/CTYkcsKYm7U?=
 =?us-ascii?Q?wQNyhxLRUKH4BP/aFMHLtMONHkZ1Xr4fWw0bauoOuXsd+KVxuf+XzBY4bO4g?=
 =?us-ascii?Q?8Pg4I09JwMZyTKTKmEt48gKE56VBpfQgdGqtaGYkMT65j1ViBhUS/TO5Ba98?=
 =?us-ascii?Q?I3zAj4+q5u3yHyPx8bCc5xEwyczfCdOcnTRwabnLhnqQT/wsdT6dlXPCXMXb?=
 =?us-ascii?Q?3psGDKCy92MhE/QaR/Pb4lbIVArX53rUkXdr4NMyXmm5iDf+Oi4pyqorXXGf?=
 =?us-ascii?Q?oMwiNyOiYFSjO3Pv6dd08EoPeJM6t2vQP7aT1pN/4TC+zy8aiZBQohqiyjlD?=
 =?us-ascii?Q?Qbcb4oX2a9wXeERoQMaqg+EDPZyA/F3sxZBrOXZLKW9UayWCs1zLgcHYncQH?=
 =?us-ascii?Q?arcByYc6Ios37bzH/6CKUA8y0Gmf3MN5wUedapGbKGFO+Ebw7UDZy3yR8w5x?=
 =?us-ascii?Q?rmePo8wgy4eet3PP83h2Gp4tIiAGuzQk1ouwSq4xiuWHn7/wW6ysjPNdAQxE?=
 =?us-ascii?Q?kmRcdrvnq3ICHQ2DVNl7jFQNBkaKfnAGZ5QS8Cyi0NnA+OJO6bCEN4G1MAKp?=
 =?us-ascii?Q?ObfK62Hgo+wZYse1/4Qh7emOd0CMRixc4HnccXApgeHqs3DjDuLwWztTWuEL?=
 =?us-ascii?Q?X4wR/Bnf96THT+baHiVLYL6z8e3ZaX8SyzsifiCYnYHOvDebQCTgdM2qr9KW?=
 =?us-ascii?Q?itXUqJ8ZDhhfNC5WdQe1WM4uLT/oDoaJs9WpzJFFz3bXGtvNj9lVpEyf+2j1?=
 =?us-ascii?Q?F5InM8Eof0ncK7cGVzOpBB2K/FKekpUkNGH7LD1WS3iGFjKK5F0+PkmNbnw/?=
 =?us-ascii?Q?j/xW5fWKfRZSUfBnVrkknGy8+dCh/wBnt6u59yi3acMfPfOOYlmprnS87m9U?=
 =?us-ascii?Q?1Zda3YCnzgAaW0Vd9OUypoU6OoVpWkcZofmP34sHNL1w8El42yw7oowev/P+?=
 =?us-ascii?Q?1L/QiXTpeVRL9tg/8Ysrqkv3q0o5oTiJtZVi9uz7iWcMSm37NKBZaD/QLWC4?=
 =?us-ascii?Q?e+YridfwMm6x0XwnAO3rKNpisSH2IhS8TtqkKbG+IFAVl6MGX9nrBDkDP8Aw?=
 =?us-ascii?Q?sgxwONdd7E7QzDRvmeD8SO2s7HZ7rCxErUcZO1YljkPIAv3pBzobnvaRrFfH?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f+RuksIKb/E/h99inuAHZXlHKc6Ywo1RTmxOJlxWsM3/bFU1GPv6Ehi3mW/K0Bd0Md/t929l92JP90+zCZqT4lAd7tfj95C5tPdTojZ8nQ2bV+rmV14J0Ti+t05KRwo9RVU7P18OhPikMpMBejXcUf4ILrGrsGA6ItUXRM+EWIlfiVCu9J0ZHts6wnN41+yMUBh0vw5huqhTqMXEdePRJFiCAQjRkvNYWL+Tdw6ZpmCJWcsToJMKuOWYnjER8xxeAhOA1aPdZO0O8FT4BjsO1HbXGyvyNsXuFQUtn8doWNOOYRqo7zrRhOiFfNhESWHchm1i3S8uLNj7RK2mnTnPxcIVmYdxUYxlu7PUVfutTGsFc8HWB8VzaWPnVerawZsc6Amxaz6AhLLfwWaQmn80CIPVTB50ww8qEPOPt7mmjmiwxZBGlmgHeEzbUNc01UN7YTvyD8TggFs8I9Ux1MExmiHgXkcK3k/LhynB55wh2FXqMmZprkiWK+Sgx8gbLUu9enjitEp4bLabTFUEh34dwl77aH8AptwP8EY75bjZErgIV9fpEd8HrGIWzXyL5wxveG5IguGTxXcVvwjxBl/VCd9TQ++zM+/1BWEolA2Xni0UbkDGA/MWt5jKYiGgNFkXep4RGH4Kgdo9Zx5Hcg/r9K3v187kabEr1bJdLgw4nxUAw1IAKvkATyHY4bMul8GGB+ji9d6ABpAVDbwPOzaXcPlcL61At4Pdp5bHca3nsUmgNf1tu5Kbe3Fm1FKkzJLAIGzrNzPuWOpKKNIcQ/8Zt9CBVD4WA+AHOVwMaalnkaObfz3wzG4hwHOYDB0UXr9F05AMNpg8XH6L2Yp5MqccUwhrQ8FN17jV7vPbyQz4vc1h2AGpXEJ0sBH6nAbkfa+2
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ead91a-3660-4e36-a7a7-08dbc4887fd3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 03:17:54.4787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RZGPjaoUCOlrhljsEzNa27pK+7zc6Fy0maxcaT9rSCUbvde1aqRlsy9rwLthL+2hhOgQO1iojeZTA9JXo6tO1mP2vbTvtV+erUV7fgeAIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=662
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040021
X-Proofpoint-ORIG-GUID: llfUkl8ltDB1uPiXaIXmlQbLhE3gslyO
X-Proofpoint-GUID: llfUkl8ltDB1uPiXaIXmlQbLhE3gslyO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Bart,

> Do you plan to use existing bits from the ioprio bitmask or new bits?
> Bits 0-2 are used for the priority level. Bits 3-5 are used for CDL.
> Bits 13-15 are used for the I/O priority. The SCSI and NVMe standard
> define 64 different data lifetimes (six bits). So there are 16 - 3 - 3
> - 6 = 4 remaining bits.

I just use the existing I/O priority classes and levels to set a
high/normal/low relative priority.

I would still like pursue I/O classification since that performed better
in our testing. But that does involve working with vendors on a Linux
profile as discussed at LSF/MM. Don't really more than a handful in
either case.

-- 
Martin K. Petersen	Oracle Linux Engineering
