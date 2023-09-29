Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A427B3038
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjI2K3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjI2K33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:29:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B720173C;
        Fri, 29 Sep 2023 03:29:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK99CC018488;
        Fri, 29 Sep 2023 10:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=yfJLleUzZhUtQP9VfGEdjJgGnBJM6xGs5In/ja/QADg=;
 b=roZeu5iY7kKBFyFMxMkyb+F0ozckMEXcE27X34LtuAXuz17iKRHcVYnF6HXf/RwxLTyJ
 +ORkw2b10MpFV7a880CA49Zjlx0a0Bx/LzWkLSlXPS4rvu9qmbr4Ox1TNBut5NUoapRS
 n0cA9CudJ4ep4sqaFiBDhs1sRaxmE0wIkXkZoneB7kD8LCooPH8bjb7KgBVI1VyPV37S
 lLZfIchqnMUZcDJMMC6NETfdADX86/Dsg5TePbg5kjJLH7Xujd7dNo/u1cthLq48oYR2
 6brG2/IRzCAM+wK24yfoGU4wX3XqWrjVAKIWkEBjrO8Wy/xu6w5TeW8o5rlHPH8ezC7f kA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3xec8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T9iSOH015821;
        Fri, 29 Sep 2023 10:28:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh4vtc-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 10:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxN+2++jRE4U4Q2Mqsh9hMK5K1y4F49ISqx17Vq9Rigyqz5Pd+o6TOEYnMv4EKSray0e3noGqh92RWbjwy1m1fDsZrPOAmYkCFyG4TWdCk5MOPuQLy4TXId3BPOIzVCXX2NwyuzHm9K1ELOG+equbkIcMENXnbs/vDTLlbS0aQ8wBpPnn257Ae7HS5VMlldq6fL7xzF+JHXa63pGP0attlp3eSdi1BJwqyDPqJRg/enwHup1ZXLPR8vzL4gD5yT1SnACzhZEoudp9MnlSaYxsK5EPuVIvf/XtJB4H72pUj2vcCvfRiQNq3O+C1dOKvFskmEGFA2DvMJwxX0Lm+Yvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfJLleUzZhUtQP9VfGEdjJgGnBJM6xGs5In/ja/QADg=;
 b=cI/L3fR8hYRiUs7jTeCmlMzYgImmOhB4Q8b0EUbb0vE5NYtgBFfKz5G/Skk92Te6E11cJrKWA29tLKhjQA7/flNcrVzK8fyawenEGCcO+pOrR+4/1qZZc4hihhYn21WQCh55f2Zr+4NU+xuwXT+2B4XqisnbQRZ7AM3YDS0hktrN2sZUCcPckxOXXn12OSJiu9Bacv9Dys7+HL6qefY2Qb+9z4vEz50/8qkXBhvHhRi3r91SS9aE4jnBv4cNTlvARSU9CvCjIieP2YZFPTQYy6SwjntyclWMDg89HNZ13m7bboXdmlJrpkOSJijwUkSpUtt5jlYunyr0ZKkEIb+0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfJLleUzZhUtQP9VfGEdjJgGnBJM6xGs5In/ja/QADg=;
 b=FPf+ljqsIlHuUE6qgJvH8jaJid1r7G6r4InWFEJC8rQES9pGyyABgpm/3q8r7hqqKihClO1R22Ean9zCttIodoziyFr05PMyG5zO1NRVlOHGobnuZFtPd1ID1/+skKMlUcqvRaKe3RdmZab0O26qmnDnT/SITblcFWdPulIuPiA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:26 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 13/21] fs: xfs: Make file data allocations observe the 'forcealign' flag
Date:   Fri, 29 Sep 2023 10:27:18 +0000
Message-Id: <20230929102726.2985188-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ef31c5-b056-4194-d843-08dbc0d6d0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xl3/jb6tJQ4mrnWqrfggJBF4T7QIKTqxJ8j+WcQLZ/MIASm+JofSstJtsf6ecqixBYh5RtT35J0WCmJs8OdiH/fHzHtdU+mBWZ97RdVj0oJp3Gg3QE0P2shyccBjoFmq42AZ8wCs6ry9o5eVBLT8gB/UJIl0/JqImPzA/0yK2vK9HjmDW/ue4XMYg0itWJvJQZNLg/K/MyvKn1tXbL6Rq8JF7fttudH6Gw1rY0/OliObrChoDKINcWWFeZ6ZEZTwAH8/RJAVnEptVSyGopIeLjfXSZmb69Bu8kO4+2M9WmlNirejlyWimw/EpP/GqyQYu8mvMKEQBLPUztD8Cabbzg8rQDZ8LQVGpRNYo5SuGYTJGKpNI/hnr6iG8P23SmAOan1NtZoYJLGXDa6dA7t5H1mNTo8+LY6VWyWro4WFU9A7vSi72KN9B2KR0se+mJIzhknxFwhVy6VVinw5p+18CApBjKzK5vNpWnsn4YIkDIgFlvh7fMADz67NsxFyNpqLx0TbB6mPIyqaGgl0f9QWVv0YAZdL2K2JKZ8RNFRXCvevUks6K83k36OdyJLHd7c1pS+nVTIeaCFUd0TvXx2xPSWw6616FWRt5K5K0bKe851fL31B6WNHiZNRVkwL1Y0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(6512007)(921005)(107886003)(1076003)(26005)(2616005)(8936002)(4326008)(36756003)(103116003)(66556008)(7416002)(2906002)(5660300002)(41300700001)(66946007)(86362001)(316002)(8676002)(66476007)(6666004)(478600001)(38100700002)(6486002)(83380400001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sxo5sGDyW3r9NIf3PoyC2jILTl0LsxAvHzCJhglWc4GPFvH9r+48z9bqPeWT?=
 =?us-ascii?Q?b7jIGF41CNe+kaXlUpfu++JJ/Of3aMlkWmGwYzxrByIUlgpHbEtiZz3L/KZG?=
 =?us-ascii?Q?tXyxOgfCbdqnOAVa+PjY2MgLNlVoPPwQctcR9nOE2W6dQWm9yZGxWszZ8XPK?=
 =?us-ascii?Q?tXkl5G4g4tryq8xMazsNrmQiNteg5P/5V0QJI+H/GXds80nr0X6q6X0iouWB?=
 =?us-ascii?Q?ONU+tVQYc0bEg49tFwhvoXkA9i87xqwCpTvtfz/eT/5xEQvCpYAlU+Dec/oW?=
 =?us-ascii?Q?aBLLj4qNSlV+PI6yAT8/fuNctrNv2J4mlN8NX3phSyA2jjL0qg5PBjqz8Rp7?=
 =?us-ascii?Q?A5Q141ciSmfTHVdPxn4eVdddMLo8XyFh0Shyz27XKL1BDgSwaxVtibBdoLRE?=
 =?us-ascii?Q?1tSsS/t9zrbbALHKViXPKYiVzWGB9cfe0bgO6PIUVylamYl33zmdtBZTf2Ak?=
 =?us-ascii?Q?YBSKNaJzO2e0/xhtWfDYYsiLXw+NmjfJb+i3oFOerS9uyjGT71S2JWoAKJpE?=
 =?us-ascii?Q?S3T2jVcILSZrOk8j+SA6Ue1JO9O7dBjiwr4Edvq43EV8snbnnVqTq1m0sSpj?=
 =?us-ascii?Q?+nCLF7AkMHnaf94308/okoshndXZ3rdkIE+HbDAqrLxCyr8uOM/2PmqalufB?=
 =?us-ascii?Q?SUfmx/FLrXrI7xUeMS+a5jtivpZ/Ty9ND1jUGM6fwYxjz+bWhRdYCzohN0AR?=
 =?us-ascii?Q?jjpeljFSdATrrTXKOHZ9Vwxd8fp6gC/AtRU9umxbfFYo/twWyTOgUFM53eJa?=
 =?us-ascii?Q?R914mtVjT/wmFl1jlz+rds9ygfQH5Ivj4T8pQHE7Kv22IQKFu5cIWn6tkxcH?=
 =?us-ascii?Q?VOL4o4m60FGyuBKSpuvawDGyz0T8lMP26fLG6vAmXF602dbHCmp5DL6fIrLu?=
 =?us-ascii?Q?FWdsUkE8zSZ183+L6atAGikpSj5udYFXW+Vp4Z/NVDLbFHIFGw8WgZPBBGQ5?=
 =?us-ascii?Q?RtTA7nHhZabi/3ezcyuQuwFiRuwPL3REl8jRbCua7deWyyY5vWvAnfHw+fMe?=
 =?us-ascii?Q?ltthu0Q3Byhuyl6uZt5YwgwLrvyT14QkMoOTAIrnY8kR+KFVljRAkY9swGTq?=
 =?us-ascii?Q?VwkUAwROKBr0X6tSCa1s2o3tTa9Kpz1Heq9mWPzF4/W3UGkgAUczNZNy4lm5?=
 =?us-ascii?Q?Q/H5tkUQ3fuPWN4Y35M5oPhef1TJrY/NsLLeQARdFbva/atEJZ2tP8NN74AE?=
 =?us-ascii?Q?x9ZYYMksxtNVZrtrlWF0tHi1GSofdMficb3ynJocHBQPQuVlXkSzqwX2INT1?=
 =?us-ascii?Q?ALo4g2/n40ehKFdUuzydWzZMekxQ8aND7HkvRdL3tuj756465km0XGNKw7JM?=
 =?us-ascii?Q?PhXq/246Y8khGJKni27RtfSERG2zLtuIHRMPL5cuCt/Je07zkQSL1wP8SNgq?=
 =?us-ascii?Q?M/oQ/+6K/zq8I+BOkwGVNiDb8ZnaekDtuyBPVwBYvD7XlwjxirIUooQLxtCp?=
 =?us-ascii?Q?YVuV+RJzitMM3wYsnwJxaKnyqOAG/xDcJD7HeGGc4DG6zfCxRH7Dyk7uMkRY?=
 =?us-ascii?Q?0yP47X3R6fmpVzIJCXXV+n+gotA9tJ3zH38i82yuU20HnJUbQrStJD1AWEV6?=
 =?us-ascii?Q?n9ILBECurA8/62MH1No9bpO2QY3mvkuTyWAeioG76Xr8j0ZAiN0BawAo2QET?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?E/BxFyOA63801uPIxpJ9U8wTbovAg0swiQvlDnsEbvOKIh0SEhEWYLpbZ/RI?=
 =?us-ascii?Q?tKdYX7CxMUkwVhR/tVtsjNhN4vp/nFesONflxytK+MRPds2pXBLYrFzrh9G8?=
 =?us-ascii?Q?C0uWmUTxgsx6g9BtdUs49AnacYmNl33gGx9Wh287z7qF4e+Y8v8xEyEtLibx?=
 =?us-ascii?Q?QjBomR7rzS82HqhOLUhN/CgtygjFjNJssnsoLVMO1jDLXZQG0jJR8LYULa38?=
 =?us-ascii?Q?NHyTrElsr/6OQrPoQAMgg0+1nYwxq35xlfa0fth3QVjK6PSIZuLjvII2sSou?=
 =?us-ascii?Q?S89hz8X3dTT+GGViAaPHYQL6O4g4SUYrQNR+xE/HDFC9WIhkTAHNq1JMjpK1?=
 =?us-ascii?Q?YUlKxDtOeS7eHFprjXc4CExwgWj1GveLEygY299ucBIksJCsMRVEDGnIk0GE?=
 =?us-ascii?Q?hi1WCXPnaKr6U2S48mN2xlJ/FjWrpE+CFykVRmAxHm48LBJD/mMZPpc84U4q?=
 =?us-ascii?Q?2cHklwhHfH2nrB3qeIjzn6X6TQvQMUNyuDoNUgmc8pbWbzqAXfHKrMnD+cfT?=
 =?us-ascii?Q?lSi6wm76pMjYVcvHx36Vvt9aSj1VcfW8NzUuycgtdKBNxMu0fwVa16xG1KJ+?=
 =?us-ascii?Q?o71tgi5Bk/V0MNpR2UI/GBghRP2rLBsyn6sS3qcHV1GgidILp88br3rzGGFP?=
 =?us-ascii?Q?vYbWjyUEuQ5A6ZadXhmtAOJTPAtB6ji0j4RKueFmo1vUlfeh7QBkm1YrSA4x?=
 =?us-ascii?Q?zBPEOlWoBg6WzCa7K+uHylZvq2b6e8bJNOuVC32oHGowO3f5Ef+jiSujdSsn?=
 =?us-ascii?Q?d+fgF1dXhPqq2q4hsFd/Pb1lzvRur7mU5jNbohEEuh8t09azYwuk0taIQPYC?=
 =?us-ascii?Q?+dxjdyPOe8BZeb/C9Y8oOZF/UbdwhgppnTp3GHEBXrHqKO1TqXj0eBS0crzp?=
 =?us-ascii?Q?iMgC4NCHEi4dTRMQp8BG8mj21+Dkgt4B3gWliSDpVAyEmqTkEyrNgUxXFinh?=
 =?us-ascii?Q?nAJtCeZDxXvXyS1sDPDDEboE4uRhfCjL6G+Fq/Gz/bak3ZreQ9b/Zz+s6fr6?=
 =?us-ascii?Q?3btZuhycPL/cPuRIdVtqWIGbVFWVZfTvML84QRZbWMrI0F0PaG7f0QC3lyZ9?=
 =?us-ascii?Q?Q22tIQgEKEH1JXxQv4VxR2UL4Il0Og=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ef31c5-b056-4194-d843-08dbc0d6d0d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:26.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gs1Tj7D3gp4lOBy0NJA89h4kAPcl1elONbkZKvuQAN9l2LaNzX8InJ//P5WSoaPq/cYDMWaHUtxH1Qxxqve9xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290090
X-Proofpoint-ORIG-GUID: jKqqc7hMX1GDRb9P8WJqxx9zaiE4CBKH
X-Proofpoint-GUID: jKqqc7hMX1GDRb9P8WJqxx9zaiE4CBKH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Darrick J. Wong" <djwong@kernel.org>

The existing extsize hint code already did the work of expanding file
range mapping requests so that the range is aligned to the hint value.
Now add the code we need to guarantee that the space allocations are
also always aligned.

XXX: still need to check all this with reflink

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Co-developed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 22 +++++++++++++++++-----
 fs/xfs/xfs_iomap.c       |  4 +++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 328134c22104..6c864dc0a6ff 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3328,6 +3328,19 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	/*
+	 * xfs_get_cowextsz_hint() returns extsz_hint for when forcealign is
+	 * set as forcealign and cowextsz_hint are mutually exclusive
+	 */
+	if (xfs_inode_forcealign(ap->ip) && align) {
+		args->alignment = align;
+		if (stripe_align % align)
+			stripe_align = align;
+	} else {
+		args->alignment = 1;
+	}
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
@@ -3423,7 +3436,6 @@ xfs_bmap_exact_minlen_extent_alloc(
 	args.minlen = args.maxlen = ap->minlen;
 	args.total = ap->total;
 
-	args.alignment = 1;
 	args.minalignslop = 0;
 
 	args.minleft = ap->minleft;
@@ -3469,6 +3481,7 @@ xfs_bmap_btalloc_at_eof(
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*caller_pag = args->pag;
+	int			orig_alignment = args->alignment;
 	int			error;
 
 	/*
@@ -3543,10 +3556,10 @@ xfs_bmap_btalloc_at_eof(
 
 	/*
 	 * Allocation failed, so turn return the allocation args to their
-	 * original non-aligned state so the caller can proceed on allocation
-	 * failure as if this function was never called.
+	 * original state so the caller can proceed on allocation failure as
+	 * if this function was never called.
 	 */
-	args->alignment = 1;
+	args->alignment = orig_alignment;
 	return 0;
 }
 
@@ -3694,7 +3707,6 @@ xfs_bmap_btalloc(
 		.wasdel		= ap->wasdel,
 		.resv		= XFS_AG_RESV_NONE,
 		.datatype	= ap->datatype,
-		.alignment	= 1,
 		.minalignslop	= 0,
 	};
 	xfs_fileoff_t		orig_offset;
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 18c8f168b153..70fe873951f3 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -181,7 +181,9 @@ xfs_eof_alignment(
 		 * If mounted with the "-o swalloc" option the alignment is
 		 * increased from the strip unit size to the stripe width.
 		 */
-		if (mp->m_swidth && xfs_has_swalloc(mp))
+		if (xfs_inode_forcealign(ip))
+			align = xfs_get_extsz_hint(ip);
+		else if (mp->m_swidth && xfs_has_swalloc(mp))
 			align = mp->m_swidth;
 		else if (mp->m_dalign)
 			align = mp->m_dalign;
-- 
2.31.1

