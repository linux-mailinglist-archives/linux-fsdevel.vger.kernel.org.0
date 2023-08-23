Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE74C78516A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 09:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjHWHX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjHWHX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:23:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF39F3;
        Wed, 23 Aug 2023 00:23:53 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MME9R7026088;
        Wed, 23 Aug 2023 07:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-03-30; bh=U3QBDkPLkBLAnvllnz5C7SlJ/CJd6uYnSlYjNCRAFeQ=;
 b=Yi77viMK8NPViEn1fmdkq6uo18deADmyolAOANuIEK4BNHbJJc/wAf9VLFmpfbmzd/Lk
 syO90vv/eFX6t65ZHGwmJwNtaWpKVzQEFlSTrvLXVuMKN0+RFVL4pYtPirBJw7LfdELm
 sh2QtRP6+Fhb+71g42fV1q+mVv3aWqTSaOLLNOC/DX9KotTIUWSsxD5EVtBPYd/HbW6e
 qyI1ukcro0Zg51P74LnuYS8GqV/W0C8QlSyQXG5VVdnia0ufvTy5snNRcKBqDehNcp9K
 e6OhOQ7lEhXqyChAZQ9ZW4yC45eCemmzJq8w7edF/gchj8nnJocE58e1kl2EUW9HFeMA rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20d93yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 07:23:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37N6b6fC036182;
        Wed, 23 Aug 2023 07:23:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yu6dad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 07:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fv94UkLieylnSRoRFaL4LUPBLqsskOQK0aAEQqPJ0KIDBnD96rxcRRyC3Rx6LszH1he90//5/07xEIC1dMkkxIrfTqEe5OZ60QsCfE4UONAxtimcnkkrxDcqChuyEhMauN3nJmSkutz7wXX7ACu5fbkuGKmt/4krdqSAJE36A9QE3FsnMJM9MFGGPPqjUuGT159W53K/GOmBBWGEyKM50V+f9j2MnBqpsLnbByjXYy4gdq6wBSanwAAhqezjTjyzh5ErGzQEK6Jw4wK3Tt7CxpL9jbvfGiIcRy+NmZmLfS6umd6IsweKUPGiJuUtnxirSUjgzVpDYgvWWs0Fw6lKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3QBDkPLkBLAnvllnz5C7SlJ/CJd6uYnSlYjNCRAFeQ=;
 b=g2RDRNTFAg6NeCwoU8SVbMJvwH1GrU4yu1WBVxSwyfmf1GRHGtt4iVF2STrgTPiG4w22psZodzAbGkM/plqQlcF6JP7fSMRfFmm8UpKYlGZAYWLy9ByKRqhHPwgkfqM8dGDvHswu0aa5N5jLXlmXyB8DYm4ef6EuAiDsuuHDcN4Xu85lqFDV2N+oXj0d1ca22zw03hoaj1U04Imaal0fBXNVdNoBtEHoVlUpwBTcOJZbspDQF7IVqvuLnTgz7uyomgSvSRE9PPZORIJWEFo71w32Q/sYTK7hUCzjojwQAPpxbTDeMXolX66Tvn7qPrZskAcAP/RI/l2NhURqWwuFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3QBDkPLkBLAnvllnz5C7SlJ/CJd6uYnSlYjNCRAFeQ=;
 b=HUzkYrzDRF+Z5Z5lGVPH16j0y6vNh4ZSljjQq4UEDLlg4+/wJQgg6py4J+lN6AoZKHGspVedyzHr2HhEWgFcAuVgGd4ioyMUiBPlnxU7dLvukDkHHmrbe1h5+Jf6gjpYxZ0L1cbPbxhHpMCC0ypdDrAJnv7Rou3TAzCFSKEzO/0=
Received: from SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:233::19)
 by IA0PR10MB6866.namprd10.prod.outlook.com (2603:10b6:208:434::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 07:23:09 +0000
Received: from SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::707c:5a02:87a1:38e0]) by SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::707c:5a02:87a1:38e0%3]) with mapi id 15.20.6699.020; Wed, 23 Aug 2023
 07:23:09 +0000
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     chandan.babu@oracle.com
Cc:     cem@kernel.org, dchinner@redhat.com, djwong@kernel.org,
        kent.overstreet@linux.dev, pangzizhen001@208suo.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to c1950a111dd8
Date:   Wed, 23 Aug 2023 12:51:01 +0530
Message-ID: <87cyzedxyj.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:404:f6::20) To SA1PR10MB5867.namprd10.prod.outlook.com
 (2603:10b6:806:233::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5867:EE_|IA0PR10MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eaa3512-3805-4d93-2cbf-08dba3a9cd27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsKNMTl4hqExWCYNWmn7dHZ3h6R/189AobhKCNkt+D6OJBHt5tHDRxNHDSBuV3quz7MPQTJZxZIVuOdC8jxhyYiFpA3lF5GgQTvf2+KqkDcZEJJc2nFQ33AMifuVXAg+J2lMFTmd43jpGUuE4rWyR3wZHISoKlmCWuTvpzZiE6fMQZ6/EHhE4kin7A4pJyYMw3uB3bTehiFeoTzp+F7wIpqdNaSB/3H0y+50ZnXhQyoxqa5ifC3xuLnZGfRzV5I9NN10WJ1xi2LxLY6fHWSIy5mrk+t55aiqhmrPQ4lbs1Iun27GBDKVtLSiJGJx263ftqJYBvxudsoS0MYXLitwl/WXKtmRhizyIHI1WEnT11C36QPEzUz2it679E4WgEB7gTbR7sR0WWa59oVzX890b9z2j8Tftiq4k/MYw+EcLczqTWOvIhDU0/GMcpizY/sg1IHp1G7UyhqQm7RjKc/tdKBKtdAquOkYRgkoLAQwAKcrbRPpCoZ/+xPgBnrO+n8KvM652Zi+QNazTI+RJQZQiNNoEV2I7h5c7yuP+9Q3z2MdAnae5CWuU1NonhH2MBPHnTy4JLZzrdEnBou5fpEu5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5867.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(6666004)(6506007)(6486002)(6512007)(86362001)(66556008)(4326008)(15650500001)(5660300002)(2906002)(38100700002)(66946007)(8936002)(8676002)(34206002)(41300700001)(316002)(66476007)(33716001)(9686003)(966005)(478600001)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ErbWnhQRH5VszFrHGxT5ikVVhXHHjpUGdKmYAlOsSxbbaQqnLosKZ8Bicvmk?=
 =?us-ascii?Q?eqn32KK4iX86TrtlZc3zJDyXYZHEVuZHwWBQKnrOdK0pig/t8oq+XGhhH+wd?=
 =?us-ascii?Q?eKwgztx2zt0jdvgXxlRqNwT7TqCOtTQ0IZD0fZhuBKdG7g9tJCw+C7aOBfZf?=
 =?us-ascii?Q?E6QxYzD/FPCplauYDvyY5bTWcQGavUIf+TdOqsA6qOvPhZv6nVElSFDttpJq?=
 =?us-ascii?Q?6cwa9mzL6Si9E9vo/2rj+8w0NJui9dCN+5T2qCXYvYyMGDGbuhmFrFVmt+i+?=
 =?us-ascii?Q?/tty3wJzLCFJ+++B2FnbeAkgqRayAQr82T5eUTAfKNiSO2DcCnbOOtg6+RWD?=
 =?us-ascii?Q?ajLCCWCVp+awidWb4rTKTqZCiVMKDZRp5SYAVoEFEDaPHPDJ1ler0Q2vfygu?=
 =?us-ascii?Q?UNKAJ5lARermL6hccW93FKOA7vrkYq35AqSc/nDVPDAgBl2Ca7B9XdXkfIM7?=
 =?us-ascii?Q?AzjW3mFLEwfDIqUTNx9ZItq4jmAMvI/+BzREWyHpZYXeT7EaizNBq7Y25wWy?=
 =?us-ascii?Q?ER198dEMOgfWOw7yDIO1UbavkPFy3uxx4NidJ5afBW9mgWdJ0KZvFTZ3V/p4?=
 =?us-ascii?Q?XyS5sIu2lSGI0bx60jjuR1OWiz1BJ7cibfO5IW8fAOTPbqPfqAs9RZkv4yca?=
 =?us-ascii?Q?+ODLmeHzUC1XPbhq9lXy6Ez7teqZbax6vCf3DZBYB5CjBCa6kvBLFZ2+G8/L?=
 =?us-ascii?Q?X0xPpGbDBh+VLfwx2IrT069bVH/D0AeNAF0m5PQ72i2qTQ3zYjsPoawxEldO?=
 =?us-ascii?Q?SR6S/OHqll5RZZWmckYYrRo6vEHMTUSMqTWaaGrbsmNMupp4475fQ9qkvmtA?=
 =?us-ascii?Q?yjhW7jMs/MhqA7xQHeubVN0pltbAIOrGJtVI8eEBQo1M2xgTgQmS79CSrffO?=
 =?us-ascii?Q?A2O4lwjz8b79++Q8Cj7qhUDi2pH2mJBFSQdMxwOnjdAjtuCj9QLsDO+gQBi3?=
 =?us-ascii?Q?6GoHM/pJB8YWkoHT09GhumkzqmcyOPwlCDaDhlvuYDPp64+gQXZpaWzMqBse?=
 =?us-ascii?Q?KSUNfIvNFWydiPsg/MXmpiVnr8oa3HSyrYyH/iHL+FWJ7y44jeYFfNJefJBN?=
 =?us-ascii?Q?mvN8KnoO6O4z4ycSjBImyr5vb11MDaX7cs1XCPtqAA9sIYARKo34Y+dHxaEM?=
 =?us-ascii?Q?/sLQ2an7yUnZL4LoCT6X3ka5l7WeEuyU4962vpiY0fKZe/2ksGLtJbVvjzWt?=
 =?us-ascii?Q?Pv9r2fHxa9nB2YuMMquvQ0NL1SYL52AzHRXFe8zL+yAO2ZK2AmeYo3l8qSNx?=
 =?us-ascii?Q?CsPc8W5Qklor4USicXxc2F9a7Y6Cqq3uJHz8aPbXSD9laUzxmRuzmjfZyDAN?=
 =?us-ascii?Q?XKHQirEWJIZbAplBmtYhdk7lFUpaJLJyXVe/nP5kCF1kVzU6qDmIHl76sSil?=
 =?us-ascii?Q?/zrqOE4R2yaO30Y1KJIsFPgwTpA2hS6u+DfQASmlAwrfQGZI4V6PRqjTRXBL?=
 =?us-ascii?Q?sqPzZyHgjFKN2I0+EmFQvwxlC+m/6vq3g+Ye7XBdAdA6/G7cy8i/sOO6kOs6?=
 =?us-ascii?Q?V3ul6b0UbRnvUxbD1e+v8ZEUcJlYbUNdw/yYEh9isoeBEntYpyUzLnQvBKct?=
 =?us-ascii?Q?ZVDvkuKC/8PYpLspx1tVp+kYGE/1WDLQNjbNTHgJcIOuXXTdCDY+uk3QKfHf?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7NRaY4ec2semhdGsHFh/YgQhvVakCNtjG722E1LFj7XUIQ9TsrSjApqsNk2P8kop8tydtGQXSzCGKlNy6e+44EQ/6sWyTmqab8E8sy6z5cmd9PicnsvkreVIGhAfNqHkCUcOEoREViKFD7DujRKdfNBcle9DjSRF63SunPBqnVhqwXLdtPlJyDWTg6m3iyX56iP8NFRXfxV6YfTd6mKKoYsFgsicEkvHoRiqIvhQ1SXnCisqAOXR7GOraXOP0rgYp1VGbnrq40uP898bMlkorsfNCnMSE3Oq4dAhjii9QMKn5XK79fJ23OdSm9GPg+1dlIU6eW5WZ3OqbYAZcpSexDO6i6opS/s26oa3e05uCK8ZjpFPc9zKEBd3XOb5SxfbwiTtmnGq2rMk/b2CWh33ZMDlG4M+EhsXhqIRyEquwHD2//ygWxICufx4AE8MO5HJehu8dY5rQyDdZzoUbfH4sa2XReGNPn1APdU4MN/RxgcOPMqezJSxN7bJl2vnUea3fU8862Hj9a7H9vohjCek3Yy/NLWYrFQapu8MmDBqkDeBUDmxHNRn5wrVIJoP74i63xD+W7OWCyWZJ2fE/9EdSFBusTdgLZK2XjeUkw3uq9mX8AamADH+HnRPq2FkTy9+j83nCF7ykiNcc+cI9HHBIihjjK/IlnRiik7Sb52TQAERsVjuudNZbxrbLInelblf6uESeyIKp9fU76Wsk+epZebHvY2YvV4RCs3qM2XUXMd+vfbKvu1KaaUYakZEL6szhkVINgPOQH1IbAcG/TJv8U+TM3VH7MVoU6uzgfchvjIiD9t+aht2sKfubiANT4PEM9R/ayHlhZ/j8pLjziMUA2wU3w9BJSABzmA4/bgJaTi+I02z5uAnZGc/QNLxSnJF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaa3512-3805-4d93-2cbf-08dba3a9cd27
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5867.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:23:09.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tK6M2Kl9O4og4JrkdXj5LVg/Dpq9BW0keQi9Ng/sJd/N9sk9dBtOs429RRP6iLpl05bdL4U0dcIVOaqCcDD2aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_04,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230066
X-Proofpoint-GUID: Udvzg9svhLT-TdB7_fY2ThBt8agp6Jsk
X-Proofpoint-ORIG-GUID: Udvzg9svhLT-TdB7_fY2ThBt8agp6Jsk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The for-next branch of the xfs-linux repository at:

	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

c1950a111dd8 fs/xfs: Fix typos in comments

46 new commits:

Chandan Babu R (9):
      [3eef00105a42] Merge tag 'maintainer-transition-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      [81fbc5f93080] Merge tag 'repair-reap-fixes-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      [d668fc1fdad1] Merge tag 'big-array-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      [889b09b3d00c] Merge tag 'scrub-usage-stats-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      [df7833234b66] Merge tag 'scrub-rtsummary-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      [7857acd8773e] Merge tag 'repair-tweaks-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      [5221002c0543] Merge tag 'repair-force-rebuild-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      [939c9de87fc3] Merge tag 'repair-agfl-fixes-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      [220c8d57f55f] Merge tag 'scrub-bmap-fixes-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA

Darrick J. Wong (36):
      [19e13b0a6d08] docs: add maintainer entry profile for XFS
      [d554046e981a] MAINTAINERS: drop me as XFS maintainer
      [d6532904a102] MAINTAINERS: add Chandan Babu as XFS release manager
      [86a464179cef] xfs: cull repair code that will never get used
      [e06ef14b9f8e] xfs: move the post-repair block reaping code to a separate file
      [8e54e06b5c7d] xfs: only invalidate blocks if we're going to free them
      [a55e07308831] xfs: only allow reaping of per-AG blocks in xrep_reap_extents
      [5fee784ed085] xfs: use deferred frees to reap old btree blocks
      [77a1396f9ff1] xfs: rearrange xrep_reap_block to make future code flow easier
      [9ed851f695c7] xfs: allow scanning ranges of the buffer cache for live buffers
      [1c7ce115e521] xfs: reap large AG metadata extents when possible
      [3934e8ebb7cc] xfs: create a big array data structure
      [014ad53732d2] xfs: use per-AG bitmaps to reap unused AG metadata blocks during repair
      [232ea052775f] xfs: enable sorting of xfile-backed arrays
      [c390c6450318] xfs: convert xfarray insertion sort to heapsort using scratchpad memory
      [137db333b291] xfs: teach xfile to pass back direct-map pages to caller
      [e5b46c75892e] xfs: speed up xfarray sort by sorting xfile page contents directly
      [cf36f4f64c2d] xfs: cache pages used for xfarray quicksort convergence
      [a76dba3b248c] xfs: create scaffolding for creating debugfs entries
      [764018caa99f] xfs: improve xfarray quicksort pivot
      [d7a74cad8f45] xfs: track usage statistics of online fsck
      [17308539507c] xfs: get our own reference to inodes that we want to scrub
      [294012fb070e] xfs: wrap ilock/iunlock operations on sc->ip
      [b7d47a77b904] xfs: move the realtime summary file scrubber to a separate source file
      [d65eb8a63350] xfs: always rescan allegedly healthy per-ag metadata after repair
      [526aab5f5790] xfs: implement online scrubbing of rtsummary info
      [8336a64eb75c] xfs: don't complain about unfixed metadata when repairs were injected
      [d728f4e3b21e] xfs: allow the user to cancel repairs before we start writing
      [9ce7f9b225b6] xfs: clear pagf_agflreset when repairing the AGFL
      [5c83df2e54b6] xfs: allow userspace to rebuild metadata structures
      [a634c0a60b9c] xfs: fix agf_fllast when repairing an empty AGFL
      [0d2966345364] xfs: hide xfs_inode_is_allocated in scrub common code
      [369c001b7a25] xfs: rewrite xchk_inode_is_allocated to work properly
      [65092ca1402c] xfs: simplify returns in xchk_bmap
      [e27a1369a9c1] xfs: don't check reflink iflag state when checking cow fork
      [2c234a22866e] xfs: fix dqiterate thinko

Zizhen Pang (1):
      [c1950a111dd8] fs/xfs: Fix typos in comments

Code Diffstat:

 Documentation/filesystems/index.rst                        |    1 +
 Documentation/filesystems/xfs-maintainer-entry-profile.rst |  194 ++++++++++++++++
 Documentation/maintainer/maintainer-entry-profile.rst      |    1 +
 MAINTAINERS                                                |    4 +-
 fs/xfs/Kconfig                                             |   18 ++
 fs/xfs/Makefile                                            |   11 +-
 fs/xfs/libxfs/xfs_fs.h                                     |    6 +-
 fs/xfs/scrub/agheader_repair.c                             |  101 +++++----
 fs/xfs/scrub/bitmap.c                                      |   78 +------
 fs/xfs/scrub/bitmap.h                                      |   10 +-
 fs/xfs/scrub/bmap.c                                        |   42 ++--
 fs/xfs/scrub/common.c                                      |  215 +++++++++++++++++-
 fs/xfs/scrub/common.h                                      |   39 +++-
 fs/xfs/scrub/health.c                                      |   10 +
 fs/xfs/scrub/ialloc.c                                      |    3 +-
 fs/xfs/scrub/inode.c                                       |   11 +-
 fs/xfs/scrub/parent.c                                      |    4 +-
 fs/xfs/scrub/quota.c                                       |   15 +-
 fs/xfs/scrub/reap.c                                        |  498 +++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/reap.h                                        |   12 +
 fs/xfs/scrub/repair.c                                      |  377 +++++--------------------------
 fs/xfs/scrub/repair.h                                      |   25 ++-
 fs/xfs/scrub/rtbitmap.c                                    |   48 +---
 fs/xfs/scrub/rtsummary.c                                   |  264 ++++++++++++++++++++++
 fs/xfs/scrub/scrub.c                                       |   46 ++--
 fs/xfs/scrub/scrub.h                                       |    4 +
 fs/xfs/scrub/stats.c                                       |  405 +++++++++++++++++++++++++++++++++
 fs/xfs/scrub/stats.h                                       |   59 +++++
 fs/xfs/scrub/trace.c                                       |    4 +-
 fs/xfs/scrub/trace.h                                       |  391 +++++++++++++++++++++++++++++---
 fs/xfs/scrub/xfarray.c                                     | 1083 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfarray.h                                     |  141 ++++++++++++
 fs/xfs/scrub/xfile.c                                       |  420 ++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfile.h                                       |   77 +++++++
 fs/xfs/xfs_aops.c                                          |    2 +-
 fs/xfs/xfs_buf.c                                           |    9 +-
 fs/xfs/xfs_buf.h                                           |   13 ++
 fs/xfs/xfs_dquot.c                                         |    2 +-
 fs/xfs/xfs_icache.c                                        |   38 ----
 fs/xfs/xfs_icache.h                                        |    4 -
 fs/xfs/xfs_linux.h                                         |    1 +
 fs/xfs/xfs_mount.c                                         |    9 +-
 fs/xfs/xfs_mount.h                                         |    4 +
 fs/xfs/xfs_super.c                                         |   53 ++++-
 fs/xfs/xfs_super.h                                         |    2 +
 fs/xfs/xfs_trace.h                                         |    3 +
 46 files changed, 4109 insertions(+), 648 deletions(-)
 create mode 100644 Documentation/filesystems/xfs-maintainer-entry-profile.rst
 create mode 100644 fs/xfs/scrub/reap.c
 create mode 100644 fs/xfs/scrub/reap.h
 create mode 100644 fs/xfs/scrub/rtsummary.c
 create mode 100644 fs/xfs/scrub/stats.c
 create mode 100644 fs/xfs/scrub/stats.h
 create mode 100644 fs/xfs/scrub/xfarray.c
 create mode 100644 fs/xfs/scrub/xfarray.h
 create mode 100644 fs/xfs/scrub/xfile.c
 create mode 100644 fs/xfs/scrub/xfile.h
