Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B787274B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 04:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjFHCEO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 22:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFHCEN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:04:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE64B269E;
        Wed,  7 Jun 2023 19:04:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357Ndk2m017995;
        Thu, 8 Jun 2023 02:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=zPFRecVpMssJ846Gt6GnRpdKavHQQrE5NoVEL4mEcaA=;
 b=eAd+fosaa4FaPHRDSKbjdrY4D/2UP37/KW3C7HAUnKBi5bxJ3MX3Xy25FWx++TLn5pa8
 8iaPTFV6retkCvIvliMm8aASSJBCI5u3GLCT0kak3b1hmSBi8fB13/ZzJoktXivB7vQW
 j7+uWA1dzXl2zCqr8Tgf8Iy3AU78fF7MngPzjcFJsiMyE1Wm4Ta5GUa5ErIe5zV26oOw
 AqaUSTm2IIrlaSTT3OrzbqZ2rTC+O+Wx8aPUyBTACkLY1JQTJoZ2h2v9b3LT66kKIZu2
 9wyDe1WPzVcJLINwJOATj9CZrDPXltzHSHLURVJllV3by5FJYQ1Nm0OxxdFkFOeRPJHn TA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6ub46t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 02:04:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357Ni37n015818;
        Thu, 8 Jun 2023 02:03:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6mgp0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 02:03:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ohkw1cUv0SvCW3j9d6z9VcAtLrms9bxcmXVxqZRJv9TixmJHZAWbHF8xGKQG6SBM3WN/n3aO2aJzecc8W92bBbHafDEzdc9tD04+e/FMoMWJ6KptU8MxuYejk4RPubDVUSDEMpzWBnZVk5P2bSSBME8pz8J7mFALaXO1ROSgwUVLk0bLMvHgmScOPpOTIv/rl3ztb22P5NjYwK5ViPnSS9hZQmNApULAzowXEWHYFFlK6ufQhg/SF06MOQO64xCVULVruFsg/hr9IpiodP+tOBR3BtkLtoiG2x/ev5+UESUGC+nQ6DTUfXcnkt2KUTveyn6Bq2iVhoFVnAJqGpp/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPFRecVpMssJ846Gt6GnRpdKavHQQrE5NoVEL4mEcaA=;
 b=FhEJY1hlMBH9qfabMKjFPIxp68C+dDEzzlWNPT26uLOqbbpq5Zgui1HMdyoJTFAGJpemu+cL3zV6uxt6gRP9YbH3ytUQ7iCMlFBGf9411LW+JC4xwVcuz74JVOca3FCBk4djSUfUE8DabHXrVd0vSCT0yMdqH/+ElwhR0P/xcJNnALSUpUqo+0uR9SMFYIxxZkZwRR5de2n4D7LJ11iMCvuBQceNuApI9ArVwJt/MjRCGECKFhBmqcouJn20t7CJ53t3I8Vb5c6QCt0qRrhPyV4f0cWTL7lVVnt6/xOzBA12PTNh1wgl9tkEPMqe7plyo+1yictFO0Xg8ux2+PTVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPFRecVpMssJ846Gt6GnRpdKavHQQrE5NoVEL4mEcaA=;
 b=yHSi7CJpUhQcXAjhHf8aAk136X8kCtkT5nEAv1m3HkudhJKqcq8QzuFm+VOZHDEz7RAY0AHQP7o+F9SEHSFTOFT0oTEEMB6VO+oVcyrb17R3tFXL51PRcKc6vLUjV/9lKMs2t/3pQY4g7md0Vs97wiz+Mt9MJmdnql7mg+lfnD4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7413.namprd10.prod.outlook.com (2603:10b6:610:154::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 8 Jun
 2023 02:03:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 02:03:43 +0000
To:     Dave Chinner <david@fromorbit.com>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joe Thornber <thornber@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, dm-devel@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Joe Thornber <ejt@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfb21zsa.fsf@ca-mkp.ca.oracle.com>
References: <ZG1dAtHmbQ53aOhA@dread.disaster.area> <ZG+KoxDMeyogq4J0@bfoster>
        <ZHB954zGG1ag0E/t@dread.disaster.area>
        <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
        <ZHFEfngPyUOqlthr@dread.disaster.area>
        <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
        <ZHYB/6l5Wi+xwkbQ@redhat.com>
        <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
        <ZHYWAGmKhwwmTjW/@redhat.com>
        <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
        <ZHqOvq3ORETQB31m@dread.disaster.area>
Date:   Wed, 07 Jun 2023 22:03:40 -0400
In-Reply-To: <ZHqOvq3ORETQB31m@dread.disaster.area> (Dave Chinner's message of
        "Sat, 3 Jun 2023 10:52:14 +1000")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:5:333::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4959a4-414e-4f70-6701-08db67c4964d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0u9PtSuEdA5DTQf+Uog0aC92BF2nw1I9yPelJUi4tNa0C4b4h60whrxjbvZ8fwIcpgZxJwbKcMEHhcmktLh1ALm543E5jb9/wDq1WCkCsaV1H6Q+CYwmjYDl75Gwi2pisSdumGbUKd1kE6+FWf4lBEfc+v35kEK0ZihRTfYkyow9G76MwTaZyOiu1ihkjNvNH16WF9tz1sn+voweNtRFok5ojpNP1t3nbA+xUkW1rJb0AAqzk0isA8JTyOKq9eCpzy0Vmfgh8Aihvbxw0b/WUUD/TKbDeuY6ZgX9M4+MINgjRnJ4E4SgUC0DUb5fs5jDTfLZOV+AqdLW7IXM11u4mcgzifcsr2FK5q69Y6Z3be95EUJFULJ7ekiGH5dG0x5eRauIIky+UOOOCfWzYO5MTjLDJ5Hs4f3cvHwhJuEu9Qo4/vdTdQ0n/Ty+XMcI1Zsu1vCrnwlda86dze0UdkKNCYF26loOU3bid6gOXvm7FC9tB3bq3PDaoAUM74n/z6T0nMEVcvoodXGCfhpPZN9gqkeOV+YtRSpRv3tVFGVq9oYuh5likXNYXyCUOar4UyX/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(5660300002)(83380400001)(7416002)(8936002)(86362001)(66946007)(41300700001)(6486002)(26005)(38100700002)(316002)(4326008)(6512007)(66476007)(36916002)(6916009)(54906003)(66556008)(478600001)(8676002)(186003)(6506007)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2P2wXqnA1AIc+D1BMU8uGjZFtmjmVBgm+uzTNY2UXFI4k3//fzxa32DulGK6?=
 =?us-ascii?Q?RyeIb5dgob2K1xb3q14j25kfG4KB68ZqRFkVUo6PHbY95z0ExbI/jHkTCwu5?=
 =?us-ascii?Q?TENUBrfsn0uuDXpqtUhdgOT+b2rxHNO+p11ppgvjBM+e+Lvo9Kktg50zcMee?=
 =?us-ascii?Q?T8L6ccUA9vMAGwLB6krsBq/VvtCA65bgebEXKLmS4UBgv4+TW1AobsYbeZAT?=
 =?us-ascii?Q?jA3W85woTaeUXWaHKqBP8fXU/VaDcFCqiPhpaYWLOaKT5a/qBPWHGzBUl/F0?=
 =?us-ascii?Q?JwzZoYaOAdQNayt4j4JqJprhZtBiyHAFdwHebpxhWqlbJaMfbqFwXr1LxG2u?=
 =?us-ascii?Q?972IMbI8jUi5I8EzTBWjBSI1w+bl6rdgLJm1kTHRhA5CPtUN1oANM8jaHuup?=
 =?us-ascii?Q?LIVjD+D2GEzjSVhFqp/cFkaBvpTO4IPSnLhvbTm6oRwT0fHzaGvPHIbyryDN?=
 =?us-ascii?Q?xLF88MY353cJ1jUC6AFz6MA/b02bAefwtyp6a5P9OoBTqZrob+7p63rlFLR3?=
 =?us-ascii?Q?nGs9y8w/GoOBVHSb6jFUhDa5UI5Jdpk1A7F6HobGXzdYnzo+vXR94wHmGNF+?=
 =?us-ascii?Q?9Dr+wmYpjw57ngOsBjmszLhNeyrdAe9mMDfS6jx/W6rT9RG6MvXCg3R/VUgj?=
 =?us-ascii?Q?TxLNeeObsmcArKG4nFz8I2/mon6cOtisPykA7/9ZdzSoBjJ/Sj6+Ycvyo/ly?=
 =?us-ascii?Q?/gdul+DpfXRAEVdn8VntVxUI1YK9Eqx7ViWNuHDFoQHaA04GXT8GzImPDCpz?=
 =?us-ascii?Q?37dD4a03rWm7P0bv7eNvbRtLM5qBtUtpsm8m7uBscQcH88QXov+JGLBKtEeb?=
 =?us-ascii?Q?upbEnsbkXwbNVudDWSQY7rnT1kxjHOySD2SdZrYDw0Pw4ABYptCXrj3zKk+S?=
 =?us-ascii?Q?gU4wEH8z2vb5kCIR5EIgkr6+AcqioopctUDSyyvV6rlcTdIzd0r4d6pJCS0Z?=
 =?us-ascii?Q?l6avi6CbycP3etAhUNokb0GyZvyfkMq3EVYB7S8J/1Fj4m80ZZmfVXy5N2IZ?=
 =?us-ascii?Q?8xIYM/jeIzYmdB36rQmmBihlGL24ckJaViK4m8+/FGOIam5sT+0RiCUrzuHm?=
 =?us-ascii?Q?hi1y304olneOZJbrKw3ahXsZq2b/2yCFpsmq+reoncOa6Yz6iBdahF82XkB2?=
 =?us-ascii?Q?n1mbZ8JDVSrR7jnf5wukWsj2fGJpUIMhY3jfD0yz40uf0WKi9OFYjOuSnoxf?=
 =?us-ascii?Q?/kPSzqKR8wCNNp2hYoyVOEGmyo35mo1Y/XaIORTFH8n73v6dS66h7YeJ6X5W?=
 =?us-ascii?Q?yPEXduOaoXSFuk+kMH4XGaycVJ/Shh3xgu8gmDN8LvtNC5EnnYnm9QEcq4Lm?=
 =?us-ascii?Q?ywDr88GPSP1iJmQkqf7vd2TvBtqwqgMacbumM7+TEDfAGJAglrexNF8sy/QM?=
 =?us-ascii?Q?eUHK6OQIlbz5N6Rd51/8C5sRNkqYuGRhQqWu/EgvkmBkX3HOTIWpfXFkCS0z?=
 =?us-ascii?Q?LUwpXFX0Gqi1KGN6Pm3W3Q8irIHVnJ6mYGwkq0Pti9xt+HmDVj1fZ39JXK07?=
 =?us-ascii?Q?3HzhtXew2/tvtZZfb00zuCogh7cSXhFvDD8FqfEmB/EHQVY1v1MgKhfMHSuP?=
 =?us-ascii?Q?c1BKfCLKr8EoNqpgQNAVNUlwakZ70Sn1OZskYbt9zjrjqWWfnQcpilwUAuyc?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IJlyDKGi1CSg5yvJc155/f0vdpShExEqnLUfXV4dkiJuVDs3FsBKZcGQI5p8?=
 =?us-ascii?Q?o8jlErEap2Bnaq7OWKmmm7BIwBcoU6QIfJ1+7AMYVjEnD91J9PbV100SiQs9?=
 =?us-ascii?Q?B9aneBbNIpfvzWenotLOTUkx9PJjC4lola3M8Bz9xfHWMZ04o3cJPb7Ic2C0?=
 =?us-ascii?Q?6hj9vHQR73FkMbvV/ygTkz32ZJehz2kkxd8/LumCo45vGr5m6bfLMEBa7Qyg?=
 =?us-ascii?Q?KNKZvOt7bxA0+1pOczzAUVJ1Q8caCSiegV8mK7Zm7S4ATHMrwEbVwzks9u68?=
 =?us-ascii?Q?gDcZK1m/7z1BenK00FloxuSjmZpDm16/vbb7IJOyas5ZCNB0ECkhtkdq6Rpj?=
 =?us-ascii?Q?O4E23Rkm5EwvF/NW2bwBKqNypgxnwEJaCqeRl3megMtKZD+Zy4PeaomKA4Q2?=
 =?us-ascii?Q?xyVY4i2jn5zKLuozLRcCzLRoj+yTanWHuU13GNkV6xASH+dcF1VJATWe6LPo?=
 =?us-ascii?Q?W+lhug4x852qajI4tWWAyQcgoE+PB5hN7ak7/yYjoYVJpQzWiMA4XZrhbo8w?=
 =?us-ascii?Q?iqSXCqtmq1EzOFoOhUVHarT+eDuHi+DMQTEj3WeRAm/0LUBXgD8p2H1+4G2L?=
 =?us-ascii?Q?V0l6DEw3iECDP23mGsWW5TYyy1Plmf1reIfEoDHdtIq9H4ZMmvtPohNE++Wc?=
 =?us-ascii?Q?m9pIyiW2T0VYd5w6Db7YsPvRy3QH/MQ0/ENI7+zq90OzT0GO9C8Rz6K+NY7U?=
 =?us-ascii?Q?EnVxWxkFugJpBpYlvWtHlorfnXUpHTwtvZ1DBHtnGLb5YQp1GxC3JE4vrvV9?=
 =?us-ascii?Q?fhYJRPycIWQo8vlLziTx3niJD6LlP1MbJZ9znaObLWA1HrhDSw4BIyCFLIbv?=
 =?us-ascii?Q?hmhPmjrQNnrUIQW85sKxLM5IscQ9WNC2dn61j88CNRmrjic5IqJQBqs7oUzw?=
 =?us-ascii?Q?6dYvd9bzgPH/Tres8XCr7iyqF8oMJTLeBPbwniXTPXY2qs95SB5CXh71rkuN?=
 =?us-ascii?Q?RKiM0hB8JH0tgnhtOutqFEtm+3ZipAE+2NG+c07l7Imv6ldYBcYkrijYPB8d?=
 =?us-ascii?Q?wjdw+C45ITg53lfMLm+WOFKWYg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4959a4-414e-4f70-6701-08db67c4964d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 02:03:43.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDdyRby7cgI6L/SS63kqFxXOoQtDCgWdBK6byT6iAJ2hlgOuF/5wu3Bvu0JnAOxyGsymUOhcL6l6tMMq63vBR4/s3LHXUfJxxx/oRKoMdH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=880 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080015
X-Proofpoint-GUID: qvEDSeu3ZiYVHl31NCVuM1rmGCKDqo6X
X-Proofpoint-ORIG-GUID: qvEDSeu3ZiYVHl31NCVuM1rmGCKDqo6X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Dave,

> Possibly unintentionally, I didn't call it REQ_OP_PROVISION but that's
> what I intended - the operation does not contain data at all. It's an
> operation like REQ_OP_DISCARD or REQ_OP_WRITE_ZEROS - it contains a
> range of sectors that need to be provisioned (or discarded), and
> nothing else.

Yep. That's also how SCSI defines it. The act of provisioning a block
range is done through an UNMAP command using a special flag. All it does
is pin down those LBAs so future writes to them won't result in ENOSPC.

-- 
Martin K. Petersen	Oracle Linux Engineering
