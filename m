Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE96FFB50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 22:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbjEKUaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEKUaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 16:30:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296A149DB;
        Thu, 11 May 2023 13:30:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BDx1B2014467;
        Thu, 11 May 2023 20:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=/Yp5qhHn4keQAkPCibr3+CTO7+NJTOeNPP0TQK5YpZM=;
 b=1OMgsVUVnMs6q8waCgTMFCmMa3iUC17xrls77PtXopnqCUICXyoERlyxG3NT+s96WE6W
 w6OK2USD9npihz2N2dBeQ9uuDAmPvKDk6AV0Rooi9g7DEUT9lEt0ACRh09KONzYQRzAa
 JWdBtROYD0lZMJTQ7t6jUszMOObBqQINmIy9tYTSs0clEcWjx7vwXdYYBN2syrCfSQtO
 g9ixBZ8AOEVl0zdhCTN+UIVbIR4S2tPZ6O6GPWCTstM9dAhq59hJ4Pgg5gWos84IWCFP
 0V3GE0TFVe+Dj77thggQhLubp/s6MKQMABIU3NagZ70POWj6zIgICwdtQGY5/vkO0lX+ EQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77c86mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 20:29:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34BIdVWX011717;
        Thu, 11 May 2023 20:29:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf813xa2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 20:29:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dExiWOCW8wMbs8IykCui6ORcENUzaUe+5rRHtcD8VSwo1S1b8tIBmNAL2wxN5/DhtbnmuIwul14u8/DxIIpBq8l3qthRouGXHt/1EcPec8UWY7GSNpX/jsFxv/QQ2D7yeXx2g9DiBEJ/1wztUfW6VXkRpDX8G0OS/Oh9fm6CkVkAgTfPxV5zAIKJ6IL9HLaa/GrxjyNsdwS0Kbl+cQZ2cJYbIFxYxJLu84LxSo9WsezQJ78oxqxwEs6EONl0X1m0jVMiJba3qmoah2vigY12XJTlKeyI1WtxIq2yZwKkc8od8SmjxOMXYMnPJie445mRhFt6d7caBma1qHQD87+vww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Yp5qhHn4keQAkPCibr3+CTO7+NJTOeNPP0TQK5YpZM=;
 b=EuFdF0o3YYr8QQvpT6DBXmQ5EN+AHnAwhOQUOA/gf8FWHSI5X9blURMY/G4xiKeJ3soYwmHVcrIGD3Xt82XoIE8pzd/Zd2bcqVcadaC9bOJOKdrfav8CQy+TmxZMRwBx4wwhPER3OUd4xT0Em1L41o+Nc3OgjJjymh7BcfWyPvFtDQV+HkQZJ7QgSMuEjgSIHyIPl0WioBGpcf3rql+eSWgiEeZLPvmDR0jzRlPV5Yw4png36G117f9BeqLjqghv0RsHf6+PMT6P5MrLjMu5IGTVhp4mTo14QoP9Akc5G05QIEBfDkWbhNWuU01ph3tedZ9+E09Jnmmf2LfdCvFvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Yp5qhHn4keQAkPCibr3+CTO7+NJTOeNPP0TQK5YpZM=;
 b=H4vS6iPvn/lkJ2uZ74yRKih4OrQ0rkiZABi66I+4cLW+ZW5mznUSzRUCEvAASdL6WVF/7k0kcq67iCJbmrWSdV1anXfgVflJWkbAU8KQ59+c5LtJ9Mq0uTx2Y+jqD11+dsQzNUzZYcCHDRpbgDY8RUgAhyTDW5df+1px0moqTA4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ2PR10MB7760.namprd10.prod.outlook.com (2603:10b6:a03:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 20:22:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6387.022; Thu, 11 May 2023
 20:22:47 +0000
Date:   Thu, 11 May 2023 13:22:43 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        James Houghton <jthoughton@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
Message-ID: <20230511202243.GA5466@monkey>
References: <20230511182426.1898675-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511182426.1898675-1-axelrasmussen@google.com>
X-ClientProxiedBy: MW4PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:303:8c::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ2PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: c98e1d6f-f5f9-4f37-6630-08db525d7c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dTwhewEaNLp+NR3+PTdBiwFfwZ6JCGQc6leOTJ9F9tYlYJZDSLcdpz5+ZwRCKNz7gbp0jcqLpRNRCp0H8rTU2753acuDihsXaigXH9QWk9Hn5l+8X2h7SbRLvEmOZIxkmy2rx8oZCQfQnZgs+xXgSSqfmRUP5mQkEIQ+SV1X+MIpeQ+l5tgxosTkUtCO/AoJBzSP1OIeDQP+DCzouOni93yz6kn904XSZkh0Lnjejkf+wLS0Auw8ykSjoyoj0/jKW/ne5Bj+1osH/ryWI/wb5d+yqBPGdmSCVi5GtZweoZNj9bymOM0oIsvAwlhmXB2LjHda5T1rAWga+AolDqSTb5H37iisVcQfpXg0kgzD7qeosXiGIE84PcwsClkmHHB82xFqtcA2MacjEKdfEBxOLy3UtICh+dfjhJ9S7RyiOy+QMc65CbX00Pgp28YMhoJl4slRW0HRz/aLhEKAxC0xB/mr0swCnlg8C+rA5e8xH2lhXXdjyQC2rxEeLuzGItSr6kCviiYkU+ct7f/OXKij0Tr7K9KcwWnWF3CO8aeygUTxlNy15+Yo1W1T4V/rmRF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(4326008)(66556008)(66476007)(6916009)(478600001)(66946007)(316002)(54906003)(6486002)(33656002)(86362001)(83380400001)(6506007)(26005)(186003)(1076003)(9686003)(6512007)(53546011)(6666004)(8936002)(5660300002)(7416002)(8676002)(44832011)(33716001)(41300700001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wANhYg5M50O6+W8w9ro63Y8i2v5TpeYoK8wV6NxYzSwNjQOnEkNBL8UerdE7?=
 =?us-ascii?Q?lX0QTFy06XtK/b/OQBNgnsesiwmeezHycKipiQMHP3bwLpyvOiyxFVrxEBYJ?=
 =?us-ascii?Q?5f9Ce6vBaloFb/2DLF2TuHdIHWB30gRhmcyahQzSFpWi+++q4inOo4mon9K7?=
 =?us-ascii?Q?vVG9fIldp7AtQcEeA+s8roJazMrIM0jwcxxnma5I82brW3kGOCVu32sMXdq+?=
 =?us-ascii?Q?mb8ZGaCoVhk1YEIgoWTqRQ0OjkN4tjP2cLeueclDO8p7+WLGYSGqCmCpou7d?=
 =?us-ascii?Q?oZwsVGHPDU31leJtbJZb06a9b/n0Z3jIIHkk+6bV6E3QvGP3tieRdOZxfpEo?=
 =?us-ascii?Q?yF/VgVobC5p1czwLiP+iDwQoSht6KZ32tpjiUbMXAOdE+U/+QyeBjjf6ZTRK?=
 =?us-ascii?Q?C0aQLmeFqBNlJbf6TZIPaN3g9GsBinLC18szpVRMi5CAP9S3FfJrzawQVt4t?=
 =?us-ascii?Q?7+9lSCaA7msTmZ7XwLJVZtZuwQXaxEKFLKTJAFcscF2pvZIQGCzltlXHag8V?=
 =?us-ascii?Q?hGHB+s/8gixJbvd9dCHQXn5FVmme1eTxrbYvTjQPhbw2PVi8uXhV7wzARfuq?=
 =?us-ascii?Q?5ojWmojnva2DMcxXybTk1EyDxFslLnob5onUWNxwCix0iAjZ+fLNthlBq/lw?=
 =?us-ascii?Q?KKe5ytrViSdLD6fJ9wLAXBGkKgCYjcaBdqwC2TYRYRMtHxKwWRo3J6FbJc+x?=
 =?us-ascii?Q?EY0gumRtCECkKlHuucfEDcTM7trqR5o8EV0P8c8Pkh6BIqQzyEEUhwFS8tT/?=
 =?us-ascii?Q?RK7bYpemfPBNmqDS9J2BPz1t5Qa0TTqXXrdNECbdcJ7fFqgz8Qu1kv80UPCW?=
 =?us-ascii?Q?Hpa7DHSsmLJcKpjJmpuLiBzEJrFC667DDGjcd873wVhRA/Pe3NXBA5LCuDRY?=
 =?us-ascii?Q?vSy1VwjW9f53zquRKQSZW2Op+SLwCTflBQRMKedjiD9DttZehbZ5hIcDYVYT?=
 =?us-ascii?Q?QK/4qpi3Ou46tRQSK7eOXthcnFcEVRhWMMC4DYYg1FdtFtowS7cJRs5vcAmC?=
 =?us-ascii?Q?Zf9/IXIEGyEII2+92nsEtgs6qP3fZeQzni+zVgan4nR5f4ls3aRjH21amHgy?=
 =?us-ascii?Q?uXjB9QhnfRRTR9EqZnrxe8PhjPFYT4eJeJE3QnW5Bz16gy3xYabnlMhT+tBh?=
 =?us-ascii?Q?IfdHeVsf18QRc96ty3Ae4jOV077Z2Yfu4HbL0iVLuBerqKXOrQn3fTbO3SIh?=
 =?us-ascii?Q?Zo9ejdvaOHVhy4r861ARsibm7E9ZWKh+zK6cj9/deY8+J9p143CklGxuLXT8?=
 =?us-ascii?Q?ZQNOvTueMaZfxBFLXWGypOth4+c6W4bjayi/m9I2DRZZ9f0/Zw8r4NlLcFfz?=
 =?us-ascii?Q?hcpRx7/QeWuaXEfClP5xKBok1EPQOSgNFYIpA1VqGw9lrCByS6+qtglhW8R2?=
 =?us-ascii?Q?OnIdVq5q8ouZnMrz5kHYx5ju0wEayNzc3Etf/LSr0t7DrzU5XStng3CcV6aK?=
 =?us-ascii?Q?39D6Eex5X9X4wRyoI4GV4Mh3DpDedKoqjNesevY/Xo0gPjYODdyKCir+08Zh?=
 =?us-ascii?Q?A5oqa91a6PwzE0Tp0eyvIYvZmNYdrn7iADMl/WuxoT+8zqiFdwOY2MhcHTSf?=
 =?us-ascii?Q?lrCadHW/LHP536lTDg1Ou384sRl45YrUj6fO7zn8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6vK4Ucuf1ikvnIw2A57soMEU5TYkSoNE8u/8KsfUTnctMQnwM/jizWSo1Fx0?=
 =?us-ascii?Q?jPEouzJeMXeftLVeTKvXs022/Aa2oieetvlKWLMT9RKPPen2LS/Fy/d65RoY?=
 =?us-ascii?Q?FnRNt22zc3SrZcJpU1mD+ct5xyGwI6YIBJMH5xkEHSIwxeyVcfMnyxkdqhWH?=
 =?us-ascii?Q?fjV+wudDWjPAOws21ZjsD73AqNS+rBQaXAKpt4Pnoz1MFWzsISPc421jIQgJ?=
 =?us-ascii?Q?AVgA2XaekrPj2f4ESWF1mTJOiKdny11CErOdVu7W8H7QBWNpDC4kMGnG5Qiq?=
 =?us-ascii?Q?f0txR60l8H2qxWGlWx/G5vVBX2Je6DBemWffZB47vSqcWQGXWXkASo0+UVPu?=
 =?us-ascii?Q?4zVND0MU3DfMJ0MOkgg0rBH483/Zaua80QXQ3dOEAbdleQMkcRZ15xLTjkL4?=
 =?us-ascii?Q?xO2fxeBGxWJyeceGg8uVe4e7L9HZQGo3Mnuz6h/D9J2s8+odKoTuO181s4oW?=
 =?us-ascii?Q?rsCKKVU5lITnH+mJxAFrtgW1cElKVLLDAjLEuhywMW9WzEUcDYEv85nLm0Kh?=
 =?us-ascii?Q?ANTpU3U2hEhEX0zYKHCs8issv9X5JdMITurxgkWVIxhToovQDVNL4T+knhif?=
 =?us-ascii?Q?c/HVQxVqBKLsGMt+xGTyzJl1QtFX3hvMO1dfNJapVnlfXztL8esOkg/mXww9?=
 =?us-ascii?Q?dq1No6KgWzRSJIDVe2cIYA+7yVwlDaT1MT/SqpPgqtesndFwmbB4NfQFvIiI?=
 =?us-ascii?Q?XFK8yulGrD9/nfCau8Zd3ZUA612z/qUbnrt6NB+qNqJ0tljQ1vIdy687WnqO?=
 =?us-ascii?Q?WZRFuPbfUt0KNyvWV7l5/KoD2o9M6ncdWjXfb+0epb9iWXYftkQ6LHbUW7R1?=
 =?us-ascii?Q?RSKeVfxUs0VkuTPEIFEbAtNwQgL0feU8+7Da7omcBMX0eQbQQkci5msVtkNo?=
 =?us-ascii?Q?BSJ9RH1aolH/Q4UEXp6OvlwZhgtD61FILYy8u78zzPdIARXmLbgv1noGBFth?=
 =?us-ascii?Q?UJxpjuIgkaB8wSA7qOET2D7Rz63TnKTYlEHJyqMG6DPmkeZasVNd5VjjovCh?=
 =?us-ascii?Q?YRDPDv0R8/kYuXaQ4OwEskQx7tOMuK9WunYV2W63rKq1Bz+buBxsRyMR7mxu?=
 =?us-ascii?Q?tjp5dEHQPbZaneptvUx5tr234AVyJ5QRHQdigwNu6eEMOINRqhFdaEEZMaDE?=
 =?us-ascii?Q?hnCcZgSOpx95?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98e1d6f-f5f9-4f37-6630-08db525d7c10
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 20:22:47.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AyffKTxDGEmW/EVg4hodBkHPJOzM4xPN/OPNwdQWsasvDDpKJFEelDzZlmtkvsJM9O0Lr8bTldihjNvfNVQzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110174
X-Proofpoint-GUID: W5GM3WaUrLTtsZp9C3bmFtkxgG9S5cfX
X-Proofpoint-ORIG-GUID: W5GM3WaUrLTtsZp9C3bmFtkxgG9S5cfX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/11/23 11:24, Axel Rasmussen wrote:
> The basic idea here is to "simulate" memory poisoning for VMs. A VM
> running on some host might encounter a memory error, after which some
> page(s) are poisoned (i.e., future accesses SIGBUS). They expect that
> once poisoned, pages can never become "un-poisoned". So, when we live
> migrate the VM, we need to preserve the poisoned status of these pages.
> 
> When live migrating, we try to get the guest running on its new host as
> quickly as possible. So, we start it running before all memory has been
> copied, and before we're certain which pages should be poisoned or not.
> 
> So the basic way to use this new feature is:
> 
> - On the new host, the guest's memory is registered with userfaultfd, in
>   either MISSING or MINOR mode (doesn't really matter for this purpose).
> - On any first access, we get a userfaultfd event. At this point we can
>   communicate with the old host to find out if the page was poisoned.

Just curious, what is this communication channel with the old host?
-- 
Mike Kravetz

> - If so, we can respond with a UFFDIO_SIGBUS - this places a swap marker
>   so any future accesses will SIGBUS. Because the pte is now "present",
>   future accesses won't generate more userfaultfd events, they'll just
>   SIGBUS directly.
> 
> UFFDIO_SIGBUS does not handle unmapping previously-present PTEs. This
> isn't needed, because during live migration we want to intercept
> all accesses with userfaultfd (not just writes, so WP mode isn't useful
> for this). So whether minor or missing mode is being used (or both), the
> PTE won't be present in any case, so handling that case isn't needed.
> 
