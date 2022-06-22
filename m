Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21C2554355
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 09:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351881AbiFVG4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 02:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351875AbiFVG4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:56:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76098369DB
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 23:56:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M6Vbv6011411;
        Wed, 22 Jun 2022 06:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=OROcuxmKi32SgSpWM4pWSpfxRtjalgQ06qsiq5kLXc4=;
 b=LbKOUjZJpbIW+pTrJHSZnPCUnSmlUgJzjmeUPgwPB0IBxlo/VN9iCOFEMD2pv8Unu27r
 PEBMX/AdXu4W7RCyuPWU+7dOGwM0GrUUVSTRXyESKoy0nCcn+ovp0g+VQU6tstiPB8VQ
 gFdfQzPBDw8o8uoOiSpeCv+RwKslSNQTQp17VBZ1T2g+A3seR0KfGwKIOhXu+XeBH3wT
 a9Su26wWUEbpKdaQ80Sw/3xP/3HQwsYmKbuKkcC8xdJ5IaFtY6JXeSoKGLshIcK9m5om
 012pcqVqq4gZIQ5762giMdspqwYjybXQ4jtSAY8Js96Kn99fR22Cv2e8HoUzBy+MR08r pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf7fye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 06:56:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25M6uXqc024535;
        Wed, 22 Jun 2022 06:56:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8x6q7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 06:56:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAAHRS1eU9/AsBQnUDBuXlstSWd2qG6br1a6wXbjafqfB2A/b4Pq8TyJp7TtF9qzzjuEA3IjoUOMUaDIaFcqw42tlVu8krN94XOqwOyVygXjnHGQkfv30UbRY18/kh0fA1tufpcZVapEa9J99SXAXUMRcZWIG+AOoG69HyOb45CWqyW6JVfBZop4dv9l1FDDjdG0ydLJWyesOmn/rszDKc4BvSotSg+HuBgRFX8wHX8Qj/1C+nhdhBb6pgmCVNAg2HXnw1SLMsAt03OWyQGdaXMsDQWheBrNndcyh5lbj6Sm1MR6WVdO80d8x9ziiXpe3dsppTarOjgxVox+oukQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OROcuxmKi32SgSpWM4pWSpfxRtjalgQ06qsiq5kLXc4=;
 b=H1N2akwKAxYnFiOS9dFA/w0rlony+7XWZZSqsJ3e6HJjRt9m3wBoCbtIZJ0d/X+KFQbb8p+dC8VqgqB1szp2/a5LjkhGw0DvNmBP/GcU+mKZGA7xtVUka072iccVGAV5NysxawlkpLK/xRuFvV/P5ggMd4Ub9ZGv3hLlcNuPJtphpKv4Ha/RPkGWDOjjC8Es7tlenJVLaSJKVEVKsrqqGN374Riwa7+ggZoNjBNwZ1t+HOtOlVeRGs0F7BS7sbwiRdcUBSM658NJTCEmatREY+5wTJV2OFdQYQyh2koOsxCUhSAzIx1+i8EGPaVNZgg3r1kCbHseg1XPtGY5PuRF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OROcuxmKi32SgSpWM4pWSpfxRtjalgQ06qsiq5kLXc4=;
 b=kEpQjU3EBjmm1TviwRfnoms2SwDF9rYFVO2W+nC/of7pzMAqCuLASd4iU4Xr+u3a/dGczzaZZOq8+H4w4TTShlFlWDQZc4TSw5xgxpVKtkr5wFSxKG3FwPLsM2xg3PiBoIQ96Ub9KPz0A8qVSQF3BwR3HxR5tRcBsn47vQUxe/M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3986.namprd10.prod.outlook.com
 (2603:10b6:a03:1fb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 06:56:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 06:56:29 +0000
Date:   Wed, 22 Jun 2022 09:56:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] mpage: Convert do_mpage_readpage() to use a folio
Message-ID: <YrK9FMnNO3yCmGpk@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0118.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8397306b-7c3d-41f7-5b78-08da541c5576
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB398675CCDBF8DC0221D4C0988EB29@BY5PR10MB3986.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCKd/Yud9QnUkzkZwq/EOhhqtz++HSSoSD0xxry0JUhZR3atoXnOSMy+5uoYBAEnvBaCHBl+Zs0ydvsXUgnviXwXNRo121kMMYzEMedRzlpGo1OelzLzl/s3PLzC/KZPgeBaToHejLhhVZJjJ0/4tiTWLFqXc5JmzGZH7dggfRdCz0ErXdLnM+NFyfJkauTdduCgEbyR0wEOcpeQfPWs2lR3UzQJU1S07wNRVjQ3QO2zP6HtLrrE/o630JV74juJxoAqavRBe2LkG4cCmSwD7nQKsZYk4PEcqBHKF9aFFOGnVqpEh4xf+tFSnI9wPH2VjTcPuzJXZ9cCn4ZmhGhfPBgsq5nIP5i1tvQ7VgGGnmwn4NxbAHxiuoUWUR4fOEtz3n3qlnYLtDqquGCxlBUzghcOhMO+DFrFTRFxDXT+NVibTMTLqrv08qw4thvnMXHBRnDXAyajtnAL6xeA0YquVYPLzjGUDLl7fMdR1KXzBre2WPfWZTZuqHMYBb1TrjuFhVukLMvCtvFJXCV9IF8mvS0f45T8fUNTwXHtXErAmd8nw++ad/Gja/lqYMAPBNtMPw2Kmf5RM4H3P/ND0NTR75ZXpqP8T+Gls/h2DUXnM4ohh8WyVK+5p7EuNJQLjyBzrEiCWx+Y1HVxpqUyoFX4IlRfimGK0XAZMstylGUzVk2SwiKvzcLCiHHvpsFtGzsQ8mTb2gvnVhLHebyYen4y8xwDVJXuFDcHNbdsV43ePynbN02AUjuWK9JQPsiYx3Hrz5DhK4Ww2E0HmG8Dbie4jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(39860400002)(136003)(366004)(376002)(6666004)(26005)(6512007)(52116002)(38100700002)(9686003)(186003)(38350700002)(86362001)(41300700001)(66556008)(6916009)(66946007)(6506007)(316002)(4326008)(83380400001)(6486002)(478600001)(33716001)(5660300002)(2906002)(44832011)(8676002)(66476007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4yXZXzRclD/Gr2BtJ0FKsMf0SiOsknrzKN5x7KmxxRBQ4vgTC9GscAMWWEKg?=
 =?us-ascii?Q?prsoFbtI/GI6zDrs+dFuFl/GIzw+yR412VhwqRDeWdnIym4AUH66lRA86dyp?=
 =?us-ascii?Q?tcDWM73bOHB33ROUUrQyMiyQ8Hvd2jwGEN3AtORgucwp4E57BaXFnDxOi1Lk?=
 =?us-ascii?Q?vH9e0+z5FjjPPeXPj95FJahr44hYb2oD5p2/FijdMWFGw9GZwPdsgVHN8IAZ?=
 =?us-ascii?Q?A2kI7NZzO6AQS1exIj9pjEf8TlMMPKuLXY4//HeAoX7xEp3qUykjZsqvr00h?=
 =?us-ascii?Q?Pa4R1S+v5pIgln0eduguANest5WE4fRHjM47jfeIjsqr4QH81xhIgBC1bfA+?=
 =?us-ascii?Q?mDqbTigKqcT+ze8hw2wl0WLPMFx7W8bdUckpX8wQE8Xcf4KhzDrijgBqQAka?=
 =?us-ascii?Q?t3+AqaaxsFyrbXppIAof3K+tAhJ5ceRSGYkxytaaTQS3IQ4PufGZo8tiPgeD?=
 =?us-ascii?Q?b2UXkxxcSk3cbBKwc97ygVScFLnEq7vremav48kJVykFrBaIR/CvP2iXM8py?=
 =?us-ascii?Q?xCHGisJ4C3sJ/gwz/xCaRQ55Haa4ebtP7iJ1DMrxJuXRbRkjCIGyKa8qoNYn?=
 =?us-ascii?Q?gFO+Lz1BW2InOYIF8yIy5rSR7uIB1D8X//iPwbLrJOwXJ+O25CKFPjJDDhDd?=
 =?us-ascii?Q?jywp8WXSBQUInGYyKEVi1iBMbFoQo0qk2wv8eHAASazXlJXzwQPFBteLH57t?=
 =?us-ascii?Q?AeBdU2Z9+vzwNiRNUpizOAZWyX41jBOPG2EAN4SZs/XANkN0XBhEVdI9ht3L?=
 =?us-ascii?Q?m1lxxriiZz0cQoUPBk+WGMHlwakqBo4RqkFd1vL6RJu5N+jJSsx2ayTQSPGQ?=
 =?us-ascii?Q?9C7ZJO0jYDI3sus+tB8kuH2921qCZMORL9drlVW5tlvmMVQptMdN8sSSz5iG?=
 =?us-ascii?Q?k7rqtXIBePzcdQMqGN7NlVilMpdut/h4maOdK6idzqPTBxvikTQZfTT21MI9?=
 =?us-ascii?Q?zXyV65yLJwOpQ8xThGUPFW7Rl+vZSsITTDZZC87wNvpErI79iBhJiOMZmoTk?=
 =?us-ascii?Q?K15WfGr+d/ac3cpU/wFGC7Rs0+41Y9Fr+K2TKtn/gwd+KGoLn9rJskfQNc7K?=
 =?us-ascii?Q?vCQU5l5VEgu5YMMvA8N8Ne2/FtrvFUiGo/LEUV+GuQ56krhaEfYkECFktRlv?=
 =?us-ascii?Q?G7NL/1/u0pMm7+GqLzmBMuTx2D2bEAP75Y6TkAmHUh00K6jPaqkq1EuJcPWT?=
 =?us-ascii?Q?vJH92xHux+SrF1LoT4jNLBNy5dYk+deactVwtAV5QfEuU0CoalT7uBOJJDdp?=
 =?us-ascii?Q?PhMPBYb9ZfhAO1FqyYEo0X70FXudpobaQ9JQJkNweO5hgBic7Xhd730Rjde4?=
 =?us-ascii?Q?SR8+vB+6rUHJjNKplk2mn/jsAg+ILheIKOmeo7ZJhvs0W+7aozT8KizOpY5M?=
 =?us-ascii?Q?B60Q87OOldTVS/7InQ7T6K6vCTO6M5KFBpNIr/RTbGE9on7FNXEVqDdCMM+q?=
 =?us-ascii?Q?ag2d12f6KnRqMrwouHw4DyxzUS79u7a+M8MQ2UqchARO94JeTF2LKgJ+Ceel?=
 =?us-ascii?Q?ryP/RJMe8FyU/vLvPHRh5EFZygU+9vhKo4fs5GF+6fSK8cVMabiaYDAVgj4+?=
 =?us-ascii?Q?nxSWyV677yIGt2gGSgU7IClDmFBA3U2kFuiSMvFicWtPf3birx212823CwbR?=
 =?us-ascii?Q?oO/INclUyRJ+vp/4X4Y6/kvgjvYHE13IwvQAZABuKaBl/sYYcnTXqWA6VHqm?=
 =?us-ascii?Q?WbC8Ns7PG6Q6kcAdDFvJmy68HOdD11en3r7a4TOyx8WGQsziS6FP1cnmiB+N?=
 =?us-ascii?Q?ytQfvq15k9Lw5h6VntyAVbdBEykTa6w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8397306b-7c3d-41f7-5b78-08da541c5576
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:56:29.9264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eq0FbzmZnJ5kvhp3JF0kYWq2gK0byHr4Hdp7fNf2maLtBAV1SmmwgtvfzLMkxG6LPk4K9PO3aID34rckb0SDLKgOLJ0b0OsxmQqBlHbSif0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_11:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=807 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206220034
X-Proofpoint-ORIG-GUID: TXiZYvrFVBlLsCFNdYAN0M7iw7HslqIA
X-Proofpoint-GUID: TXiZYvrFVBlLsCFNdYAN0M7iw7HslqIA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew Wilcox (Oracle),

The patch 4c27dc762d7b: "mpage: Convert do_mpage_readpage() to use a
folio" from Jun 10, 2022, leads to the following Smatch static
checker warning:

	fs/mpage.c:102 map_buffer_to_folio()
	error: we previously assumed 'page_bh' could be null (see line 99)

fs/mpage.c
    78 static void map_buffer_to_folio(struct folio *folio, struct buffer_head *bh,
    79                 int page_block)
    80 {
    81         struct inode *inode = folio->mapping->host;
    82         struct buffer_head *page_bh, *head;
    83         int block = 0;
    84 
    85         head = folio_buffers(folio);
    86         if (!head) {
    87                 /*
    88                  * don't make any buffers if there is only one buffer on
    89                  * the folio and the folio just needs to be set up to date
    90                  */
    91                 if (inode->i_blkbits == PAGE_SHIFT &&
    92                     buffer_uptodate(bh)) {
    93                         folio_mark_uptodate(folio);
    94                         return;
    95                 }
    96                 create_empty_buffers(&folio->page, i_blocksize(inode), 0);
    97         }

Originally there was a "head = page_buffers(page);" here but now head
is left as NULL.

    98 
    99         page_bh = head;
    100         do {
    101                 if (block == page_block) {
--> 102                         page_bh->b_state = bh->b_state;
    103                         page_bh->b_bdev = bh->b_bdev;
    104                         page_bh->b_blocknr = bh->b_blocknr;
    105                         break;
    106                 }
    107                 page_bh = page_bh->b_this_page;
                                  ^^^^^^^^^
Which will crash.

    108                 block++;
    109         } while (page_bh != head);
    110 }

regards,
dan carpenter
