Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECFE7B76B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 04:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbjJDCyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 22:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjJDCyK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:54:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE3AAF;
        Tue,  3 Oct 2023 19:54:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I51BD019574;
        Wed, 4 Oct 2023 02:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=GvXY58FJLSzUsW2XC1ktG2icL+zEMrUBcXB4pT/Dt1A=;
 b=KrX/qZHfcnYCtSpfJl4lIkLkDJapZwmWVNadmL+CoaAnD7yt+IabhTDD0o3nkVwqYgsG
 SXoa1R/YglT8voPCrz08b/iAubF0BZaWZd9JQzrukxhyEFD72oX2KAqEux8vYcqMhDll
 ZAJTpPSyzFRJskKQBzq3vpOQolocJgY0ASQ8WpuxLLzsUSgF8tGXnOV8LyIOgDMmAnRQ
 rpJo0JJ8ocE2fgz19ESc6/+3kuysmaFHE50XwsufN6MNBua3UzX6NzexJ439Sf1p9h+Q
 9FtETFb7fAgnxQQ0JCedrPDhRbd/xj2aVOQRwRm34gJAj1SMSUykXPJHNFXZd7UiTkxR JQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjbx0ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 02:53:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394107i0025740;
        Wed, 4 Oct 2023 02:53:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4dbbuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 02:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHxBRQsWwHAb8C720u6I20FLryXT1kivuYszFf1XFYa7fM0Zi7UuiqRRtUzwnREPJ4kqWEMn4YU6T4x1L6P28mqK7mcVoolCuDkkJ2hFzgW+MYRl032XV2IIoIQ106OrD1eunAAXT+5X9lD+UUanEzHqBa2qetXP0PMm073XBI0l4Zq3prZ2cSIvW0Ckt0L5+mB3ljEisggvy4t4qTjHgoQKakMVs+GyX1yZRw/zy84Pq0lX/j3ePzCRVqyydj1UUkgbPuBIX8Q6Ml/PuWwGLsXA0DzW+IMif3fjSzVZ/TdttfWCCli0bLhBlkESC+hmvwp5LANq2lkD6QhwC9KDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvXY58FJLSzUsW2XC1ktG2icL+zEMrUBcXB4pT/Dt1A=;
 b=TMkwWm7JcuDnOSz4CDA8OHbVRZoI97fbUtlPAtPoBxocISPlVNZioIFtIFam6RVUZYYPl3GZxwDCUTIKtP8HxkyknD11tLG1uuMqU64+AQsnEXM/koq3H7NlAMUzGwS/d4uoYGhPKSw4/6eNZ0dwnEkEucs1OIgoHUWve+LMM5HnK0cy1RvhWYq/4BJ5yM4oEONm7h4UTDeCXruOR1j5tv4yTOHB/ulDNp9HdIY06ablMIo23A6yeQFv5Pa96EwmGhet1cZgrwu7UM6QewtcFuEaSqEsLrRlKJdl8iHgxIgCRD/RlCtl8T+Hy7bol1mq+FOfpZ3goO0DJciyFIfxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvXY58FJLSzUsW2XC1ktG2icL+zEMrUBcXB4pT/Dt1A=;
 b=nmfbUx4UwkyO+PddPFekqcim8bufG94BipMjRVdnasUF4xz/PStoGU+/RmofI4qZuRNzGlL+rXFYTEYm3FaSipHNROupf0zsXTDsEoStroj+HgIb0x77ciDYCoD09mDtQT2X/ApV+W9RVNhVz3F7ARcNJY01rIRvjY6LpGSccdU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6232.namprd10.prod.outlook.com (2603:10b6:8:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 4 Oct
 2023 02:53:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 02:53:23 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
        <20230929102726.2985188-11-john.g.garry@oracle.com>
        <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
        <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
        <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
        <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
        <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
Date:   Tue, 03 Oct 2023 22:53:20 -0400
In-Reply-To: <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org> (Bart Van Assche's
        message of "Tue, 3 Oct 2023 09:55:40 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf58c7c-ba1a-43b1-c90b-08dbc48512c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxGXz7xuoDJ/jv8C2IdhmnGiQDOlFpN00y/4zhB9N6Sb/cRU8vVwPLPoh19XmTTK94dzYXdUA6fvOgVJv84cq4WFVz9txvH71T8ndYHJWQL1FcjLyvS05VWdfCvXo4ooVJrF4H6PSchzedMuepv6zm45ajwIGS+B648/UGbFOB3EhTbbw/WtOgwvG6wPMD5A+9eD0HPISMKknAeFX59tKS+wsIM9LHu2X5Ogy6X3G5kscHhQfk0bA7NKUsQFYdWjQUFKCfoZjnOXr6r6V0q7zbWNjlCzJQZlN1mqzWmBOxpPF/bg+5XD2j9PHLzonrdCXd9lauwUQpYVx/2vtafWeHwIVO2+HlJADghZG9IKHv+5e7oNx16lfAz93NrJjNfpOf0j6PuFSolWk2U8XRZdKM1NtpOWIHAaM+r6dOl6PfcAYrt5L8rU7qQ3FviHpEx5gsRuqVP+jol4cGcfNCQA0g9eicPIVS1PaTfp8l4mcYVVX1LzbKuCo6vZtq7vuhGVqqNUEzDfYalaw10ZsBMz9sftxGi4yz4EVwf+rBcEF8EIOD/siuHAez8i5nuOfL4V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(7416002)(2906002)(86362001)(66946007)(36916002)(38100700002)(66556008)(54906003)(6916009)(316002)(41300700001)(6486002)(66476007)(6512007)(26005)(6506007)(8676002)(8936002)(4326008)(478600001)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8/Dj/aK8wSEFvenDLkvpCN0rt9+YbMvcPecY3rjQxdPF8odetjffcBat4oJp?=
 =?us-ascii?Q?TfnJOcGgj+IYr7GvBfgxHsc7Q/FKn3GvfldBwRWSSJ5JxCXKEgMFxUCIuSHK?=
 =?us-ascii?Q?7cYZUHd9Z9B4Hsb2wwEOCPbZt4+DofP5H0c9i5I9GdQ9nK1h1QEAIYc1mNwT?=
 =?us-ascii?Q?8FrL59fUTkl6J4txIho3JOWw/XaMUqf9csOlqjevLpJNyd9wXawffmnkGf+h?=
 =?us-ascii?Q?DrdDnAgAEGMGk+giqL7B932danyG5CBSU81VA3B9i81tJC8yTnlD53FgBtCA?=
 =?us-ascii?Q?8L7D/DhKs7hMl9k7L0EAOT3aMRiKDO8rco5q7xV02zVEKbt2ZnWpfpT6Nmpu?=
 =?us-ascii?Q?hAsJX958HjDfpb8FHubJT+iEefOQaV+R4j9cs2Bql4MoAWU45PbjbFcDO7ZX?=
 =?us-ascii?Q?RNgY28mGcGipDD1JEXgxbOHYL7NZCOfJy5BjsyFdmKUksr7uvjsn3QTwqTPf?=
 =?us-ascii?Q?J5CCQ0JME7l2M9SLEfElwCmeaevI1h2rtl3Zyd9eSHJl5jR6Qw/ZsB3Bytej?=
 =?us-ascii?Q?r+BBO7+XdQZlqTyxVZ2RCBWqiGjP5oB9OhybcsEmfkBeq26QBb725P1Ds9Zs?=
 =?us-ascii?Q?VhkHcT0GwS6rMWdoISJFrCX/DzFFWHvbrQgRaYx+D5338Gov4CUdRye+zNUf?=
 =?us-ascii?Q?1iTt4yVyKymtlb9mFM6sOdJvttacLl4MQ3fwC4WQ7fp43vQGY41JgWhmzsRx?=
 =?us-ascii?Q?ymhjT1nDq22mx8HPMdUee1zQXsiNUGbU4Pg5IN35P3fLbGUdFmc1LJtxnB3u?=
 =?us-ascii?Q?i3x1cbkApZFk42T4U7tJ4zlaCUB+bTuoyeHQPYSV7Fc6C6s5wx7N35mp6VF3?=
 =?us-ascii?Q?lAUGFgORFWwKSBHCDINu9FlIxzFCheki8Sqt2uG+zGHElsr3QOTl/X4kRhYW?=
 =?us-ascii?Q?LVnd3+chRwL4NIHQeRvJPrGVvEdKI/VIFNtpmWIufEWPkVe0E6GJ5D09qnHS?=
 =?us-ascii?Q?cK9rYrP0QsIwRHNCTZxkZyT8Otygvomn74wrp8Sa1NUMIYW4b+Pblk+mrqQq?=
 =?us-ascii?Q?wHirViBRBT1d5F7fgOY+04jja2kq6eg1fZtsn7dTGsuPXuSWvrZtDYiP2NfS?=
 =?us-ascii?Q?1NLqo4B3ZH6R2ddah7WBdwp2WP0U7+sEy5u5cLlD80loD38A3K6j+j1D47+C?=
 =?us-ascii?Q?ya/sJuWEieYi5a2BOfxXP8IZRbfVv4bTApjSYy5s8vcE5bFcNv6CJuO3POCI?=
 =?us-ascii?Q?e1MYXjsEMJ/gXIK5oXHKnTfGuBwTiMu/3cee8/Rl50t1VaMGfd9emRT9d/CF?=
 =?us-ascii?Q?AhZXZ5UEb+gI25EhnrBTOqAqgXhFD00cTS4aTbH1p8sPNtJeLbuls3NCicxF?=
 =?us-ascii?Q?dvZxnWn6Ih0sCkzsT58MqFRQdMJxdufhYZpSp0DxVBfVCXdzTb24Q3KEG0Gg?=
 =?us-ascii?Q?RQygLx8eDXvtqPzkHoClljLUPcnEFfC4kxyy+Hay/I8ySNSB6x02hC+uuXrf?=
 =?us-ascii?Q?PerkR5/OkJ9Vi8ogOleYG4mxFRIkRFlHEz5DRur19eESrsXP2QqGvrvZBaSI?=
 =?us-ascii?Q?f+L5Nq3bFlCFEIA6827UTcFv6tXTLGMR9LYJBQR2PWVCNIUNASgCHPB+pGzs?=
 =?us-ascii?Q?x9aS53xbTK5l1KJ4OvTRbr89SnQlOdygQtXJAfRRhBqTytA+9qv2fcLP2wXc?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?g1LF1qQh1Ks48DR9GOxuuf/aqTy4Q4h5l6U1qlEgNUCvdfEJdcSmTYZZ+MX4?=
 =?us-ascii?Q?U2iIidVmWPQUsL8EMux5YDmufW6LttXFy3gz8YDBFZOjlFRRlrTSOaBev7+5?=
 =?us-ascii?Q?R5NHfyLrhc7iIUYRk7odGPWN+8Tt/YY492fv6JwE7pHFsJn/4h4mg0Xe0f96?=
 =?us-ascii?Q?UpJGCe0mPuGF6wquZHyWSsQEI+NSFvszLGbZaIK50Rem6y0x5xptjY6kyuV2?=
 =?us-ascii?Q?Fv3l3nF601cKbyrPGBMf6kYIQ35kAdacH2jQiLAL4QibVVIIg3xDsiqIlg48?=
 =?us-ascii?Q?QymwMH8NA9v4T5pbSEekQWLVeqM0kcJr5O44R7nYAh1/CCUdCA+DcCy8X65O?=
 =?us-ascii?Q?KlSZoSmvz2fHSD1WAK0pBwH6O0RNSqiPyTLSaeFmPkMdp4h3wIJe4FYfvZxe?=
 =?us-ascii?Q?yepE7jpXYUmjTGfIjKTrQaSiOrl5HkVQSYa7OTCHrswusYeZ55e15nlLM31x?=
 =?us-ascii?Q?zsHdkhkWWTJCtDzZ4MxZw2jlDBd4pofeSy8SNj7nzTQrmwpK4R2cFRj84Kd3?=
 =?us-ascii?Q?cDRDT0aXtlP8MF37X6SOEzU2jrAqLBdEiQgGRoKmMzrG8QwAL0yEW2vufqHQ?=
 =?us-ascii?Q?ep4rrKqul13WUj0J6ZuS4jEA3Rn5dbqJB0XSKkjpjyFmMbBa5hjKmpGWd8Ej?=
 =?us-ascii?Q?o00mt2KWvqdt4FTruUt6wuvZXT++k9if9fejO+l0w72Y1x1u9PuNvu1pTLQq?=
 =?us-ascii?Q?8je7jgfRYcYfsZBy2zbsg213vY0j65iz9DalSTLhWMs6DbGRjYbrS5vPydpj?=
 =?us-ascii?Q?yKUdJRMt9emASzaHKeXqxKZ1gA3B+/u6+5Q4IhtX0GOBrZAh/GHWIrHdULsC?=
 =?us-ascii?Q?kZf+wpSNo13CNediJWp5Nz9m0TJvdwCUuyMlFynhn1+E7+EDUUizQ8+SQLAy?=
 =?us-ascii?Q?KTep1t/7vOhiR53vJrDGohE/r5eoRD46imNudKH9sGVPwid10UirotZlWPE4?=
 =?us-ascii?Q?Hnj/2aL4nPHGkydXuLbOh3GAtYZH3UxiRcXkiL45LQ1J8/oeFOAc1S13jNtc?=
 =?us-ascii?Q?9Nl9TntNLAzN4T5/DCGC/QQrfW+oKIvAm9rUA9TeFwmG6rq8NCNVxdYmLh1r?=
 =?us-ascii?Q?XpYPnWWGyJKS2duVL6sM3BHSh4RPhfO+w2G1SlvWt9ijlEvQfmg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf58c7c-ba1a-43b1-c90b-08dbc48512c8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 02:53:22.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vY9djBJ0UKsLajIdzL0J2XRznG9RqJEFuKa36e0OxZsYMhOqTSPX5KM0tWu/89e+KZsueu1eYi2f0UPf5jQwQ+zSdpOG243CgzEq4qA7J18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=983
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040019
X-Proofpoint-GUID: vML1Z2CDTyLtAnn1tpbr0NaSVTE6MrEY
X-Proofpoint-ORIG-GUID: vML1Z2CDTyLtAnn1tpbr0NaSVTE6MrEY
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

> I'm still wondering whether we really should support storage devices
> that report an ATOMIC TRANSFER LENGTH GRANULARITY that is larger than
> the logical block size.

We should. The common case is that the device reports an ATOMIC TRANSFER
LENGTH GRANULARITY matching the reported physical block size. I.e. a
logical block size of 512 bytes and a physical block size of 4KB. In
that scenario a write of a single logical block would require
read-modify-write of a physical block.

> Is my understanding correct that the NVMe specification makes it
> mandatory to support single logical block atomic writes since the
> smallest value that can be reported as the AWUN parameter is one
> logical block because this parameter is a 0's based value? Is my
> understanding correct that SCSI devices that report an ATOMIC TRANSFER
> LENGTH GRANULARITY that is larger than the logical block size are not
> able to support the NVMe protocol?

That's correct. There are obviously things you can express in SCSI that
you can't in NVMe. And the other way around. Our intent is to support
both protocols.

-- 
Martin K. Petersen	Oracle Linux Engineering
