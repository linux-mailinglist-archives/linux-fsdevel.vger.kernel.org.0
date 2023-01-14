Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6218166A85E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 02:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjANBgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 20:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjANBgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:36:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62E644A;
        Fri, 13 Jan 2023 17:35:59 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DNQ0GJ017798;
        Sat, 14 Jan 2023 01:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=VhWaRdVHK68BeOX9D4i+sh9f5CV2QrNWvqqzczNtTAQ=;
 b=YwxRKxGXbkt5QvDjguXiKQYpygmEoJfyEMlbzYl2mf2IJQ/NUHGF5hvRKUV2eU7SA0Lu
 W2wMxvf7eXbc424MjCfm7yFSBP98Zegwgh/msaStgqnPq881ad+sGxygFuPoJkN0xnJs
 KwmIkUPlNc4S+pC6E/ZSBVmTZEjWGHp4bxGmrsfNrLWG09t7QVfQSkM/nVO5U6dabW6M
 T2/gsUj/Tzv2Q9iEJ6Ntrj6rc3DV96m182ZKfc66b8Rxkk6ijmTYGyi/dN+Ss1XHm9jX
 Hql1B9gn/3q8uxLlZOLMiW0kCcXEjC+Z0lBht+Eb3yd1h2zLawLmKFJrbthl0d9Yj2al NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3f80g8eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 01:35:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30E1X5Ne006223;
        Sat, 14 Jan 2023 01:35:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n3ju1r34n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 01:35:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrrtTbCjnjIWZ5dkRvbz8IbvBMWZMPnn+FWtQF61S/YbP/17rEALGJggCtA8nYQZoSwJutMrmLGn2h7u72pW7JnoN3FHAaJym8fE7ayvQ0U7n5rhzjtHZzqJiccNKCv6SV9fXqWraxq2u7aRggrai1hZ5P9OKRZz/iQAapuMa+gB3NVYIlwftEY9DH780z+RC8vpQ8I9BA75XRZRUtYyUSFS23TPiPGPOhkz5ClUCgwd3oy+h1DTdonimdOiPmYTnCKbPbdiaHec+ykDpzAk9kqNjWYvHmXQlEil60NntUn8MymkyG4mzBexX3JOvyhSPDr+mUAcR1135J07Y/MVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhWaRdVHK68BeOX9D4i+sh9f5CV2QrNWvqqzczNtTAQ=;
 b=NpVx/TmEbFLKzJGQ45pIr0Ts2msxrezGuBI/A4R08ECz1b2Xi/VtrkwKb6Siaty9FoaaLSD264aKFo+TY7sMgnXaA7k2QFbXW+l/3K09zwtqe842UAmPJgMrIlnS3D3Bx4lZRUUveKr+8NouNah7EeucXH98Tfea2jrzGi8X4xAFzgB2J0lFLY4waAs5uteUncyWljoa05DS9IYiiqSPM7x2UnC8oPmXfyvFtx388wTiDfh02RCZXf5PI5N/NO6gTSsuWVfdHyUkldBQjSKNEyCx7lWaIYrjpieLBNPVhEwCbSwHSKzg6dEWWvnChfXFWbndmHxJ7OfZZ6a/8RWUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhWaRdVHK68BeOX9D4i+sh9f5CV2QrNWvqqzczNtTAQ=;
 b=l6M3+a/NoGuxq37Ff0kechXVq6sT9yTFXvOtjmWoakFP7Z95PCAdnY+luZdlGfw6+3RChxO5OmKNkTCxKnQVAX06OJhwd3MhM7aPROB/5sb2GU3AUdfBOAH8PA1CgIJEcarEt+of2YAiVCkO2gGQNmMLInvLHjonYe84nx9Iv6k=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5831.namprd10.prod.outlook.com (2603:10b6:510:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Sat, 14 Jan
 2023 01:35:32 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Sat, 14 Jan 2023
 01:35:32 +0000
To:     Bart Van Assche <bart.vanassche@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH v5 3/9] iov_iter: Use IOCB/IOMAP_WRITE if available
 rather than iterator direction
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilh9ucg3.fsf@ca-mkp.ca.oracle.com>
References: <Y7+8r1IYQS3sbbVz@infradead.org>
        <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
        <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
        <15330.1673519461@warthog.procyon.org.uk>
        <Y8AUTlRibL+pGDJN@infradead.org> <Y8BFVgdGYNQqK3sB@ZenIV>
        <c6f4014e-d199-d5e8-515c-5ffcd9946c80@gmail.com>
Date:   Fri, 13 Jan 2023 20:34:50 -0500
In-Reply-To: <c6f4014e-d199-d5e8-515c-5ffcd9946c80@gmail.com> (Bart Van
        Assche's message of "Thu, 12 Jan 2023 13:49:14 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0112.namprd05.prod.outlook.com
 (2603:10b6:803:42::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: a9309cef-7df9-4285-8fb5-08daf5cfa05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ukqq8Ce+jY8SYL6LuGROPf4opkvohxlMSEaKgelwnp53/hHj5PV73O6323M+wR1NsBiqEgvthairOsVGJ7q/NOyf/YPuqTcNiSJ8SkWAkhNQdPss9IPcBtyAnrjvQD8EadPVq5ZFkY6u4bVl1iY9VfrFUU4huukYDzyVd6ZHveyzuDR0yqFQcZ2yQhCAirzZwwXxbjyBPKkjnx/Ur6cUy6/jr/0gR03ndCheTRXzEcvwBEA0jOpvMnJFJtTPtynyObPzeKu3DBvsYmfa3GkHEYNcuSzTf6BxGsiafjHoSqpEaioVk+sx814CJRYOVShtqgf4K17SmSkDNU3PRL2FMqCKzN3PNWdKagpFGDe9Bcsm+AKo1YTJ0pcQpEQ5PhYqzbReEVs45trNuWIFu/x21EZN+FIRmSYOCyAriVlweOQqKN6L/OIRbY0I6oWwnq6UK1ubQhBibHX0W86Ae7Aj/Q+URmhh4eqZNXLXkRpvzdPxfA7PpHHH/uY+kofUhKveRcgKvGs43+snewi5PR0a0lWQFsQvenvx1ET1HkYZRHDyaFO4KiJHxHOKgrZfcvm/0Lc++iYw6TI9A0hi3r++J2gLRfA2gF22tr6tm1Mka0OGd6GXBiT3y/i23wq3/XOfXBgk4cl4Gxar8RVwpnho5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(8936002)(5660300002)(7416002)(41300700001)(54906003)(4326008)(316002)(6916009)(66946007)(66556008)(8676002)(66476007)(2906002)(6486002)(478600001)(36916002)(38100700002)(26005)(6512007)(6506007)(6666004)(186003)(4744005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2h/JgeGEIxhyJcoXCQLpZwNRGnvAWGTq43exVL4YnwlMh7HJINR5dFVKE0f3?=
 =?us-ascii?Q?y1BzsQDzHshZ1dTj1Epap2crCRklT1tN9819nDAihtiTGV0g3xiN+Edi3Jow?=
 =?us-ascii?Q?L1QhUscVBOC8jB9jjR6q7rBR6Kv2k4nU7fozPDl4fHVTMIjvnVyKrRRxgn2S?=
 =?us-ascii?Q?07yE9cc+/9MYSs/gKj5SuiwUvgiDStPgEaMGqi/DygK0s0sFdA5NyrPSI18u?=
 =?us-ascii?Q?v3bl/vyPg4QGKLo755/QM/tJRBrrC+5ZxbbLoKp1sHamMJ3fppZoBmP5W0F7?=
 =?us-ascii?Q?mHC3ZPMz2FVoNZroF8P1O+GHPxI0dzozqEpoL6PfCGepKs27YrrAP0bz9yXE?=
 =?us-ascii?Q?01D83ayiqwDJEcj6KJI5kbyZ1wGeac2ONmckZmr7wCG4vGnE2MFYaUvtv8kS?=
 =?us-ascii?Q?1DMaZkK4L9Wwo/UfDk3BEgJeO9vXrGlmCHd9n2C7v6ZROJMPALrMgFkeqs95?=
 =?us-ascii?Q?Z+lSvdnaAGjZTRWXrFbMWqTSA5r8ik1J4C39Y0uZgOgIlBqtVDb28S7y/Tfa?=
 =?us-ascii?Q?xl6GLzO3CE2N+QDbca8VxgnNR0PtBsVQIlyW5ckr5OPJx9wg7UkhnsHUUE/A?=
 =?us-ascii?Q?4t8V0fMHstD5qrckXd+WECWoIa+2t4EU3R3ZzsSw778+PTIs1NJbkfXsMHOh?=
 =?us-ascii?Q?QVJJ7nUt8rVhPB7yjBeNopWY0SV8eSQUmUV5FslmoJ88SREKlkSQHYiiAMzC?=
 =?us-ascii?Q?K7KdtIdYvh1UVP4Rr+B/HjRmYD4tmeARX8959DCJ0VP+G3EW9DL/yfno1CcO?=
 =?us-ascii?Q?M8zpcwNULDJKltgWYE+Tc6vKrOLyIrcuWkCpvHcEd9seSx40cnbR6g8mTueJ?=
 =?us-ascii?Q?dtidjXf9doBlOzTdcw8/pdEgMyINlq5ZHblm4qc7jL8FEXAOHN9ZVPGuMvVK?=
 =?us-ascii?Q?8tbLPv221bSC8+CshUGDxyDkvYJmMH0QWanobyfsDUYkT80QQe3t/QOI+FgK?=
 =?us-ascii?Q?voG45Jqgsj2uixdh0W16W9Yph2NRLlnMmXrll4PdkqWrFejHURZ9PPg0pBR5?=
 =?us-ascii?Q?UaG2KyGsFN12c5W3QKMfPt4/Bpbxnw/5PiK9ws+zcIMufQKcgKW7KZuKfloR?=
 =?us-ascii?Q?W1fEzH6CZ/GUDf3R3BfBa5YIef3rU155hh30/7JskBF8gJ5gdHAyKtffpKGa?=
 =?us-ascii?Q?DCR2YS5gSVy8qChZQfiw95GaLBLa51TPa+VL3eg6JCX8bL3JH8ROUCfN++S1?=
 =?us-ascii?Q?ThoOhukdyyFIVAJt0z02nbDdNzzM6wg4y1yd8FWLp0wK1r7FO4XFt458hfa0?=
 =?us-ascii?Q?suc+/kP2JJQjRhzxNNp1puFUhAL28itmfmZMB+VOQYYVzXAFynu6yej4clMu?=
 =?us-ascii?Q?39SszJyQspL3JLgaIRd+jjXCUg2bztnHuj2zGGVQYjeA5Dpy474J8tpDBT3P?=
 =?us-ascii?Q?5INAsC110CKI+mWwvEa7o7sBgbfDVfOxb0BRjCnJaBrhBLzVmvqoHjZ9kuOe?=
 =?us-ascii?Q?JN0Ivcg/drBvkfWntxrDlVp5FTNgUmyioeSSs5MKKtO1817etzZEfaEmGHLj?=
 =?us-ascii?Q?g2U8tdm1u1dDE1zYzfr8unm4QUaKknQdNcxdwmcLddZ6jorsHNc6cbH6keVi?=
 =?us-ascii?Q?vAKAblPf2DV8qYeIAP8tvCqB0iEmYbT8zurhOd6itfRx8DjatYv+oQcU+oph?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Lg6HAbdUZUxeN8cDNoFoQVsgLww9Fm6Mc5PXC8n+t4epXl7egHiPwq2Nn/pg?=
 =?us-ascii?Q?d4jzMyDKUsgIj7Z4sfav6Q0Rw69p3/HJt72tB7q+7tLNRXR2kJoCj/cVc1Yk?=
 =?us-ascii?Q?7inFQqWAf+StGsUuWExRxz+Lp5pbOuZFri5U9S6ObXFiontK8x9dsa79WA6e?=
 =?us-ascii?Q?WmBLfkZZ2xoCFC9XIc/gLiImVr6XPntoX7rHwbICyhmRVipxCpoPJbA7QsBx?=
 =?us-ascii?Q?bmhyAZMAJ9DXWqSfRqbPWyJxbrLbGFpS/ulPnZho0HPZ84A4r4KuFY/LgawR?=
 =?us-ascii?Q?cY5d9Jq7DikNCQlaiL/q25UHeyjNH6U5MzTXS1I6nko9RZAKKP/wrDPQJp3p?=
 =?us-ascii?Q?NeI8c4MTXTB0LAoV7yHe7yshNammM7F6XpDPd14xvly+KNn3uXE99dcBsdbG?=
 =?us-ascii?Q?T6Hovdoo6W3FgAVJECJ9aap3mAMwBrPOaLAvr6BTfRo7X+gwc/ifnrdpZcYQ?=
 =?us-ascii?Q?9AElffKuN+9jVmaLj17du+mgWyCFWe8gEOUtjq0x5NteDJlfThqgfRl9sd9b?=
 =?us-ascii?Q?rYuHLPFOc8Qspg5HgMbrj9eZUxEd1hSWjMMsOfPonSfkh3kSPC9w/wdkhSnc?=
 =?us-ascii?Q?VP2qGsheYsmcU62kpxBHGxFdyZ9vGkVSVx+3gw+XWeV72kiq4HrcR57GlHlH?=
 =?us-ascii?Q?VhgyoDA3/FpFHI1W7FKmM+l7cPPcDdH94agzA6OHOwd4UwkpVZ+2JuO/IP56?=
 =?us-ascii?Q?9e5RQ1J23uRdEnEKaocPuEYR8ruE8bXTfQg2nyWew02HShBHufNSyprb9M+e?=
 =?us-ascii?Q?Oby/0VEWlD3GqSXAvW8dtedk+e8H1emrOJCl1hrLVxbU/hFwXAoJFB8JXNsp?=
 =?us-ascii?Q?w7DdU8WnQS81S8f3WUvL9ejQQuIcgYJodEMzKJYiwbvR54GarB6c1AO+pDT/?=
 =?us-ascii?Q?IC1iDLla3sk1ppTDz9jitfoQQ4owvhqn6hahQTNdf6AtzUcnyCv8vWeoPtf5?=
 =?us-ascii?Q?RPb4GvyKk8iSMuao50RN6VHC7wVLdXITtInw7U1neQrMO7WkotuofFGJH+mP?=
 =?us-ascii?Q?SBnapXdiwd5cD25srZ2XEj8jsNYy/3MNWzgeyh1RttqvuNw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9309cef-7df9-4285-8fb5-08daf5cfa05f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 01:35:32.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsppo4bEAesER9mOjdAsC3NMnHOdhgG/yTJIdA5JDnjbb+Ud6LowseC5bWvel48Y4gp07i5JJCalbtiz1Aouf9+Oov7A48WbWOo+wGUP9Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_12,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=803 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301140008
X-Proofpoint-GUID: Uf1R9_g2cETeko9A1jTywiJnga9w3A8M
X-Proofpoint-ORIG-GUID: Uf1R9_g2cETeko9A1jTywiJnga9w3A8M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Bart,

> I'm not sure that we still need the double copy in the sg driver. It
> seems obscure to me that there is user space software that relies on
> finding "0xec" in bytes not originating from a SCSI
> device. Additionally, SCSI drivers that do not support residuals
> should be something from the past.

Yeah. I'm not aware of anything that relies on this still. But obviously
Doug has more experience in the app dependency department.

-- 
Martin K. Petersen	Oracle Linux Engineering
