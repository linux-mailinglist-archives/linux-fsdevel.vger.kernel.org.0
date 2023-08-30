Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518AC78DADC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbjH3ShT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244385AbjH3NHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:07:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A01185;
        Wed, 30 Aug 2023 06:07:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9iOS6032352;
        Wed, 30 Aug 2023 13:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-03-30; bh=EpQejMNS2TVFknNGZdPDZDjlDFgn7W5YbXKQwD33AT8=;
 b=HtbRzb8etYGk0rhEtWI8cBybe8kaAHrbR0HH/ciy8TSllsHx4Z/VzJrZ+YJyOEbKOZxb
 u5hekTiUNUwjMN7dqvzptmAZY0N6Kh8atEF+rk7MzcxI3T5U4TUaGcoT5DEiK8G5VLpx
 gWANnAToF7bQ/D10W9WQ1jwtFeN89MaermX/xvXULRVISw1c9djfcE0LdirScJKwYOmO
 GLLb1OmGpFgtRfSp3FlgSuyVhzxkPSUEPBgKJB9ULbnJZVX95FVZYUFlROyYove3QJ4D
 qm7rBxtivjAqNFa6KyVM70M1NAPmMiJFz8pR8iwCLmw46m1aGsAAKu+1nQVO2rBG8CxO nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcq7sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 13:06:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UBmNPo014247;
        Wed, 30 Aug 2023 13:06:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hpg9aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 13:06:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haLHWVbDZXmI4it6NmFDJIEXXyGNCsWzR7TgbjuBtdmiUTGXDOQal43gt7z5sEfqGthQP3aZchTZRss/2hJj5cKWD56NnVeaba+PQP07OEzvi8MfScG/7OiU1pxyPFiJo1HtG5Esx2Nt1NdOP6jc/mgkDu/GZ/taBCtkCanfL6EfA+lrJHp9kfsqIo4K5mcoS1TA7AoSFho3hrIbDxXVlpAyJERsUPVx9j0QGQ6b2OV23chL0XsLUiOamFSvTgICEwRA/u+ag09QTKnB4bqe4jNJKkm0O13FdZtpMTsMtHVnKfXDdknvMDBS+XP1Il2DwYOfkszfrtFfRm7UrAVhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpQejMNS2TVFknNGZdPDZDjlDFgn7W5YbXKQwD33AT8=;
 b=DIOvhaQ5SEX2LvdLTj7jjy60vPmb1UAHzLcdHbemJZSl0NcKsCi8uPFXFoN3y1MUvbURMLv+EMd3E1SNrXufFR+xuf3NNO5RXG+HyxrVTu2GMagF+dZdaQ9Ax+BdIYvGPUQwdVpeuYY11I2o24AafjdADsIYf0rstQS7KTjlIhuItMxj+DnBfSBYNfqv8LTJMdQuFER9UmvoSDHuml1nXDRFC94tVl95G8AzsSj8sp/50rDGWwdxptiUB5VUIVcootSBW8iT4csVzXYhxoxY1kCo6K+dQOFSsZT3ivD07eD4yW0j0qVawuVl1WmfoY/Y9WdoB+gF9R+ypZAYlueUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpQejMNS2TVFknNGZdPDZDjlDFgn7W5YbXKQwD33AT8=;
 b=GYfiwfFdXWGpk5UqmAZVB/NOhDkGIjhlJO1w7XE9ArIBzUZCsgOMBny4LES0zvpfnxZG0XIrLQoGgJw9R/oJBaNSofHf7fvKfu1w7wF8uKunRQFgPuSiA/qxWsZsgHA7DcINuKKSmXsCc7fDqLsowDz0b7GYP7cshjzQp77ne5w=
Received: from SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:233::19)
 by IA0PR10MB7623.namprd10.prod.outlook.com (2603:10b6:208:493::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Wed, 30 Aug
 2023 13:06:54 +0000
Received: from SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::707c:5a02:87a1:38e0]) by SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::707c:5a02:87a1:38e0%3]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 13:06:54 +0000
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     chandan.babu@oracle.com, torvalds@linux-foundation.org
Cc:     cem@kernel.org, corbet@lwn.net, dchinner@redhat.com,
        djwong@kernel.org, kent.overstreet@linux.dev,
        pangzizhen001@208suo.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: new code for 6.6
Date:   Wed, 30 Aug 2023 18:34:59 +0530
Message-ID: <87cyz4smqi.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To SA1PR10MB5867.namprd10.prod.outlook.com
 (2603:10b6:806:233::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5867:EE_|IA0PR10MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 2840ee2f-1c9e-4eac-9b47-08dba959fb4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZuMfNIgN/fkdGxGZhyHy93/VI6mK52h03AtvUNbGRBxjHvKi2g3uEqzVgfyUFha9Bc35Vm+XedJHKvI/zo2Wrq9tDD47Yh+UevFcnwf/KyINlLdGC9duUWflEoIpmyBOtJE8H77RyefFk7wVOpJaL4Wxyw30XFmMmOc96HFa0VIqR/1ljYMTm1oDK/IC24qeS7aaoyDoam3fWJM6oqZ21ci0S0sTDcsu8X7StYgAmLxhgqiEzTXnqyKRxecVEoo7cCBOVy2WA9cBxhwgjFENg9TvDGt145x/km+u2HAuX2htFnLaheqA+ZpFNeqomhfu/YWyK3iwBtV8IEnzrSpt6tNUv/idEK1ycbkGgda4XgjWhN4Ko+0ylqvFO1cTUdZM+kT2IqOXbP8OqUnRgkLheMRsXuksNdEbAHbrz0B9WMPFKBb34OevvfLrLoRoQLUriu976shyHf9GwhQRN1M05DSWCWCBTWWn7uF0ofzIf5XOvBO71rFqakrBUQ9Mu/OY62onAsWzWDnH7lgivpLIsn74baX3iOQC8txBxQ/0OQ4a0bo5Hy3smdhmCxdirhsfV9/N6cvO0PXgE+olhdC4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5867.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199024)(1800799009)(186009)(8676002)(4326008)(8936002)(2906002)(66556008)(316002)(66476007)(66946007)(5660300002)(41300700001)(26005)(6486002)(6506007)(9686003)(6512007)(30864003)(33716001)(478600001)(83380400001)(966005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rI5j5k5p0ndc3dwbpkqYNnvCvmGDwxfyXVOXJCqwRM3mOjWU22zfoIs8OCkM?=
 =?us-ascii?Q?WoL++XG/oOPGNAq07yHBm+5NylkYETgAnIHP/0+eMbbFmk+BifPoU1zB1Pgz?=
 =?us-ascii?Q?S9nHOm6U9ri3Vfo6OzrtF8WkWqYmtuWClB+Jd+0iqxThQIRzfuavt4zLUbzm?=
 =?us-ascii?Q?V7qwGariNxMEcKvUmufeNYXbl/XlKSSYqVVhScIcx0zF7qQDlzx3OL690fvc?=
 =?us-ascii?Q?gkcOj1+vq9SekR+WefOtiEYUnMe4Zuj8Oh0wew1uHR+3gZif3F/0eDkrH9hH?=
 =?us-ascii?Q?um/5zOJPJnln3cGzIjpgXX6/qdPMqKFJ9ZA7KRANZYuvHnaJTisgjRnPqg/B?=
 =?us-ascii?Q?dB21ke1k9TvQQzybSRBjkwWLpxa7wXAgNkQj8td9amr/dV8UekdyeuVLsYxg?=
 =?us-ascii?Q?aQyXBj2HZ0gTqCbQ/kcDqnh3iJbDrGUUUtlRxJTxmoytTkYQo+7Tfoaouk8D?=
 =?us-ascii?Q?zYdy7E6XMdmMy6DQppYkTVws9PBGCNOrCX+QUGUUYs1cDjt36B8nDeZLsKcH?=
 =?us-ascii?Q?6bsDja4ddfjxlw2PFQk6zPiOfnc8D+aPJ0a2gJcFTYZx2sl/liWTGHocoHZj?=
 =?us-ascii?Q?5aS4UwX3WjvmUvSWbzuD060LptZsIqJF31nrIjZCDEHbFpeAsTKH9bPoymmc?=
 =?us-ascii?Q?1JebFTq8F8ea/J4b5Xo6Tny6fM6Wxcymfcq3Oz5LANVAaPvL5ZG2oH8GZx+x?=
 =?us-ascii?Q?D8q5yww0rppiGfE7s7aJ6D9mOiuBMfhhHJ/FW8mkuOq26dzsqxTSPQgU50Ba?=
 =?us-ascii?Q?sgIvn8Ttq5rqneZYZaXwvHWaPzS9NLSJk8yQuVWtS3fAPeq7kilvdzex3ujr?=
 =?us-ascii?Q?d19y4/ztYuJMiAcmbrSkHie2KF9D4hi/z+Nahf/JeMSQJZZbO/6zGnhgROVl?=
 =?us-ascii?Q?OnGFiq+ee7SfyvlwOLyiDqf2wgIP6FgMIQ5QpPeNKAsQ+VO1fwcD/Hmg+4gR?=
 =?us-ascii?Q?UKxmO5KrEkqVRRivlTScJyOZpWW9RSH3YlJHWwT4k/o2Oov8OyXOl6dOpgex?=
 =?us-ascii?Q?+Gj9L5SkApHc2BYQ5aVdiaK9GK4XVNyUdA+Who0Zw67KRGCQbDU6ky+FYRgV?=
 =?us-ascii?Q?mNtiJdobhVH6mla6JuDi0ugfQG8IkeH4Kcc6GKCFySsLW7RjzjHU0d8D2GiN?=
 =?us-ascii?Q?wHLyIUiiVlkeWIuhnkKXRKDkNv41hQl+S+B0olDaqFxTrMH2NE6M5fzua4hy?=
 =?us-ascii?Q?fQqvU121x45oUdzyOrYDAzEmVkBEhK3gQsvSlGQG3wKR1G66lDKZiaVNdXhE?=
 =?us-ascii?Q?zk/l0oJ4/4kM6MwD73yhIH0sjjVaVnZqhFtk3MErzFakAdRqDEhrsmJ2+2yq?=
 =?us-ascii?Q?rKWrnwy+70d8cAmpB87mA3kHursrxeIqPxdL7DpZqNSSrEZPbqDVJ/MB7xrj?=
 =?us-ascii?Q?Tz8ELG2y/H4XgCD6JKxJxqmxHSwk76De6TnaqZFZsA2s9/jWA+4DruthhK+y?=
 =?us-ascii?Q?imkILQZnDo49xqIgR8S8HDawU3uKsnDbUZ95kJoUCRVmOLtLskN+TlbSLIxu?=
 =?us-ascii?Q?npfgv4N0Ahk3zynEp0444m3M1zcx24HyWslNQoS/xubIBE3KsaIp459hbLWN?=
 =?us-ascii?Q?rGKGJTQ5ORRoBf8CIERs/DkEkB5FHpPyNkSRx9Etg8Ud0f5BtKBFo/ivj7IH?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3GnPiGcDFxU3QB+9CB4JYUpsAw/O+ZMN/LIxevmhberfTp7QOP8LCZr60maF?=
 =?us-ascii?Q?1NiUUIy4CROs3swHdq1B/cFkixl9YQoFk4PeJRAKUi/jUkK+7aEKPFhgVuNS?=
 =?us-ascii?Q?aooWSwRJbbrWBcGUPF+HhZdzDcFH1uGy6YuO5WgiQC76qDuo/Ucc4Rs51mBJ?=
 =?us-ascii?Q?eEmg+fKPcmm1sX0d5PnwIVlfnlu7NbMEtWqTmH/tx2xJrgX3dYPJ4iH18uS3?=
 =?us-ascii?Q?B/VkwvrWr/QEUXtrt/t2EsOsLU6F4yzQw+RVfC2wJMhvIygDG2H4NbKiz9yF?=
 =?us-ascii?Q?rcw777aM+YgROuSnE4Tnfah0jV0n26NRy6yQlwrF5CkyCrT+E3Qx2+/+1j25?=
 =?us-ascii?Q?O6pRBMrWmj3ZhOzNyQ69nX0G6+e3QocK8zcftBiZh2dV22rdYjTvTv0zu6/L?=
 =?us-ascii?Q?6HKXADZ8Cx91P5yeFs9nik+xS6v7f1Bu0vmohpN6c6LZOfLYxj3YaPtx2hKi?=
 =?us-ascii?Q?29OrG1eh5wI/CmXwBi8MAjhP8igjMc767gOiIKsvkaBdHkT9HKiEqA9t0wBu?=
 =?us-ascii?Q?5OVF0hnadznXLnnuFXt1uVMzSgEUcRvc7BZFyFbAL5uRqsudTXLO5rbJyV/P?=
 =?us-ascii?Q?VYnZK/5wVQF+cToljZqR/unMuEU3QBVl3QQtM+48rAkeyykYtwmKu9hxS9iS?=
 =?us-ascii?Q?6NUFjbChZVPvMj7fxHFMCtkxwF4qM+6ZBM92xWHgJ3idTkjF7Ztu2V5gXxoW?=
 =?us-ascii?Q?r5nRqaDLmDnb/QQ+L+FLNtswWtZ+7SKnb1icIcvkVmLP9sdqUWSOw3pvZaHP?=
 =?us-ascii?Q?FusqbcEGVY9czMayIDbAOzVBeCDkaZRpmY8sfVqBJhp9sml5+Vfx1moswsRM?=
 =?us-ascii?Q?rMnu74hT5NgzAF6gFeoic6RV8dkwRDToAbgQPWJWJRahK8FV0CUtkkItg6FF?=
 =?us-ascii?Q?B88C2pq3HQouVKNIrQJaE4wNhX9Vnbn+A3mOkd9ToRs09Xzw+noGujJd3YuS?=
 =?us-ascii?Q?9x04BC+V192oWlf5wuA81A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2840ee2f-1c9e-4eac-9b47-08dba959fb4f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5867.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:06:53.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOm3b9ksVnWl2et1/TI1hxbiX72RF4syxVgRx69M0ssoDZsVAKhVYWMX+NmdCk+sDdAHxefLD+y6wiZaRy5VzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300121
X-Proofpoint-ORIG-GUID: u3W-4vMGeASXMoPSZ-BQt2-FY3AFuDG-
X-Proofpoint-GUID: u3W-4vMGeASXMoPSZ-BQt2-FY3AFuDG-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for xfs for 6.6-rc1.

We have started merging Online repair feature into upstream kernel. This
pull request also includes a bug fix and a typo fix.

I had performed a test merge with latest contents of
torvalds/linux.git. i.e.

1c59d383390f970b891b503b7f79b63a02db2ec5
Author:     Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate: Mon Aug 28 19:03:24 2023 -0700
Commit:     Linus Torvalds <torvalds@linux-foundation.org>
CommitDate: Mon Aug 28 19:03:24 2023 -0700

Merge tag 'linux-kselftest-nolibc-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest


This resulted in merge conflicts. The following diff should resolve the
resulting merge conflicts.

diff --cc fs/xfs/scrub/scrub.c
index a0fffbcd022bc,e92129d74462b..7d3aa14d81b55
--- a/fs/xfs/scrub/scrub.c
+++ b/fs/xfs/scrub/scrub.c
@@@ -178,16 -178,16 +178,18 @@@ xchk_teardown
  	}
  	if (sc->ip) {
  		if (sc->ilock_flags)
- 			xfs_iunlock(sc->ip, sc->ilock_flags);
- 		if (sc->ip != ip_in &&
- 		    !xfs_internal_inum(sc->mp, sc->ip->i_ino))
- 			xchk_irele(sc, sc->ip);
+ 			xchk_iunlock(sc, sc->ilock_flags);
+ 		xchk_irele(sc, sc->ip);
  		sc->ip = NULL;
  	}
 -	if (sc->sm->sm_flags & XFS_SCRUB_IFLAG_REPAIR)
 +	if (sc->flags & XCHK_HAVE_FREEZE_PROT) {
 +		sc->flags &= ~XCHK_HAVE_FREEZE_PROT;
  		mnt_drop_write_file(sc->file);
 +	}
+ 	if (sc->xfile) {
+ 		xfile_destroy(sc->xfile);
+ 		sc->xfile = NULL;
+ 	}
  	if (sc->buf) {
  		if (sc->buf_cleanup)
  			sc->buf_cleanup(sc->buf);

The final version of xchk_teardown() will be,

STATIC int
xchk_teardown(
	struct xfs_scrub	*sc,
	int			error)
{
	xchk_ag_free(sc, &sc->sa);
	if (sc->tp) {
		if (error == 0 && (sc->sm->sm_flags & XFS_SCRUB_IFLAG_REPAIR))
			error = xfs_trans_commit(sc->tp);
		else
			xfs_trans_cancel(sc->tp);
		sc->tp = NULL;
	}
	if (sc->ip) {
		if (sc->ilock_flags)
			xchk_iunlock(sc, sc->ilock_flags);
		xchk_irele(sc, sc->ip);
		sc->ip = NULL;
	}
	if (sc->flags & XCHK_HAVE_FREEZE_PROT) {
		sc->flags &= ~XCHK_HAVE_FREEZE_PROT;
		mnt_drop_write_file(sc->file);
	}
	if (sc->xfile) {
		xfile_destroy(sc->xfile);
		sc->xfile = NULL;
	}
	if (sc->buf) {
		if (sc->buf_cleanup)
			sc->buf_cleanup(sc->buf);
		kvfree(sc->buf);
		sc->buf_cleanup = NULL;
		sc->buf = NULL;
	}

	xchk_fsgates_disable(sc);
	return error;
}

diff --cc fs/xfs/xfs_super.c
index c79eac048456b,09638e8fb4eef..1f77014c6e1ab
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@@ -772,17 -760,7 +774,18 @@@ static voi
  xfs_mount_free(
  	struct xfs_mount	*mp)
  {
 +	/*
 +	 * Free the buftargs here because blkdev_put needs to be called outside
 +	 * of sb->s_umount, which is held around the call to ->put_super.
 +	 */
 +	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
 +		xfs_free_buftarg(mp->m_logdev_targp);
 +	if (mp->m_rtdev_targp)
 +		xfs_free_buftarg(mp->m_rtdev_targp);
 +	if (mp->m_ddev_targp)
 +		xfs_free_buftarg(mp->m_ddev_targp);
 +
+ 	debugfs_remove(mp->m_debugfs);
  	kfree(mp->m_rtname);
  	kfree(mp->m_logname);
  	kmem_free(mp);

The final version of xfs_mount_free() will be,

static void
xfs_mount_free(
	struct xfs_mount	*mp)
{
	/*
	 * Free the buftargs here because blkdev_put needs to be called outside
	 * of sb->s_umount, which is held around the call to ->put_super.
	 */
	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
		xfs_free_buftarg(mp->m_logdev_targp);
	if (mp->m_rtdev_targp)
		xfs_free_buftarg(mp->m_rtdev_targp);
	if (mp->m_ddev_targp)
		xfs_free_buftarg(mp->m_ddev_targp);

	debugfs_remove(mp->m_debugfs);
	kfree(mp->m_rtname);
	kfree(mp->m_logname);
	kmem_free(mp);
}

@@@ -1537,11 -1538,18 +1556,18 @@@ xfs_fs_fill_super
  
  	error = xfs_open_devices(mp);
  	if (error)
 -		goto out_free_names;
 +		return error;
  
+ 	if (xfs_debugfs) {
+ 		mp->m_debugfs = xfs_debugfs_mkdir(mp->m_super->s_id,
+ 						  xfs_debugfs);
+ 	} else {
+ 		mp->m_debugfs = NULL;
+ 	}
+ 
  	error = xfs_init_mount_workqueues(mp);
  	if (error)
 -		goto out_close_devices;
 +		goto out_shutdown_devices;
  
  	error = xfs_init_percpu_counters(mp);
  	if (error)


Please let me know if you encounter any problems.


PS: Darrick will continue to sign relevant tags until the kernel.org
keyring maintainers respond to my request to add my gpg key to the
kernel.org PGP keyring.

Also, Both Darrick and me have been running this branch through QA.
Darrick will probably continue to execute QA tests for the near future
until the keyring has been updated and access to git.kernel.org is
granted to me.

-- 
Chandan

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.6-merge-1

for you to fetch changes up to c1950a111dd87604009496e06033ee248c676424:

  fs/xfs: Fix typos in comments (2023-08-18 13:42:43 +0530)

----------------------------------------------------------------
New code for 6.6:

 * Chandan Babu will be taking over as the XFS release manager.  He has
   reviewed all the patches that are in this branch, though I'm signing
   the branch one last time since I'm still technically maintainer. :P
 * Create a maintainer entry profile for XFS in which we lay out the
   various roles that I have played for many years.  Aside from release
   manager, the remaining roles are as yet unfilled.
 * Start merging online repair -- we now have in-memory pageable memory
   for staging btrees, a bunch of pending fixes, and we've started the
   process of refactoring the scrub support code to support more of
   repair.  In particular, reaping of old blocks from damaged structures.
 * Scrub the realtime summary file.
 * Fix a bug where scrub's quota iteration only ever returned the root
   dquot.  Oooops.
 * Fix some typos.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Chandan Babu R (9):
      Merge tag 'maintainer-transition-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      Merge tag 'repair-reap-fixes-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      Merge tag 'big-array-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      Merge tag 'scrub-usage-stats-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      Merge tag 'scrub-rtsummary-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      Merge tag 'repair-tweaks-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      Merge tag 'repair-force-rebuild-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      Merge tag 'repair-agfl-fixes-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA
      Merge tag 'scrub-bmap-fixes-6.6_2023-08-10' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-mergeA

Darrick J. Wong (36):
      docs: add maintainer entry profile for XFS
      MAINTAINERS: drop me as XFS maintainer
      MAINTAINERS: add Chandan Babu as XFS release manager
      xfs: cull repair code that will never get used
      xfs: move the post-repair block reaping code to a separate file
      xfs: only invalidate blocks if we're going to free them
      xfs: only allow reaping of per-AG blocks in xrep_reap_extents
      xfs: use deferred frees to reap old btree blocks
      xfs: rearrange xrep_reap_block to make future code flow easier
      xfs: allow scanning ranges of the buffer cache for live buffers
      xfs: reap large AG metadata extents when possible
      xfs: create a big array data structure
      xfs: use per-AG bitmaps to reap unused AG metadata blocks during repair
      xfs: enable sorting of xfile-backed arrays
      xfs: convert xfarray insertion sort to heapsort using scratchpad memory
      xfs: teach xfile to pass back direct-map pages to caller
      xfs: speed up xfarray sort by sorting xfile page contents directly
      xfs: cache pages used for xfarray quicksort convergence
      xfs: create scaffolding for creating debugfs entries
      xfs: improve xfarray quicksort pivot
      xfs: track usage statistics of online fsck
      xfs: get our own reference to inodes that we want to scrub
      xfs: wrap ilock/iunlock operations on sc->ip
      xfs: move the realtime summary file scrubber to a separate source file
      xfs: always rescan allegedly healthy per-ag metadata after repair
      xfs: implement online scrubbing of rtsummary info
      xfs: don't complain about unfixed metadata when repairs were injected
      xfs: allow the user to cancel repairs before we start writing
      xfs: clear pagf_agflreset when repairing the AGFL
      xfs: allow userspace to rebuild metadata structures
      xfs: fix agf_fllast when repairing an empty AGFL
      xfs: hide xfs_inode_is_allocated in scrub common code
      xfs: rewrite xchk_inode_is_allocated to work properly
      xfs: simplify returns in xchk_bmap
      xfs: don't check reflink iflag state when checking cow fork
      xfs: fix dqiterate thinko

Zizhen Pang (1):
      fs/xfs: Fix typos in comments

 Documentation/filesystems/index.rst                |    1 +
 .../filesystems/xfs-maintainer-entry-profile.rst   |  194 ++++
 .../maintainer/maintainer-entry-profile.rst        |    1 +
 MAINTAINERS                                        |    4 +-
 fs/xfs/Kconfig                                     |   18 +
 fs/xfs/Makefile                                    |   11 +-
 fs/xfs/libxfs/xfs_fs.h                             |    6 +-
 fs/xfs/scrub/agheader_repair.c                     |  101 +-
 fs/xfs/scrub/bitmap.c                              |   78 +-
 fs/xfs/scrub/bitmap.h                              |   10 +-
 fs/xfs/scrub/bmap.c                                |   42 +-
 fs/xfs/scrub/common.c                              |  215 +++-
 fs/xfs/scrub/common.h                              |   39 +-
 fs/xfs/scrub/health.c                              |   10 +
 fs/xfs/scrub/ialloc.c                              |    3 +-
 fs/xfs/scrub/inode.c                               |   11 +-
 fs/xfs/scrub/parent.c                              |    4 +-
 fs/xfs/scrub/quota.c                               |   15 +-
 fs/xfs/scrub/reap.c                                |  498 +++++++++
 fs/xfs/scrub/reap.h                                |   12 +
 fs/xfs/scrub/repair.c                              |  377 ++-----
 fs/xfs/scrub/repair.h                              |   25 +-
 fs/xfs/scrub/rtbitmap.c                            |   48 +-
 fs/xfs/scrub/rtsummary.c                           |  264 +++++
 fs/xfs/scrub/scrub.c                               |   46 +-
 fs/xfs/scrub/scrub.h                               |    4 +
 fs/xfs/scrub/stats.c                               |  405 ++++++++
 fs/xfs/scrub/stats.h                               |   59 ++
 fs/xfs/scrub/trace.c                               |    4 +-
 fs/xfs/scrub/trace.h                               |  391 ++++++-
 fs/xfs/scrub/xfarray.c                             | 1083 ++++++++++++++++++++
 fs/xfs/scrub/xfarray.h                             |  141 +++
 fs/xfs/scrub/xfile.c                               |  420 ++++++++
 fs/xfs/scrub/xfile.h                               |   77 ++
 fs/xfs/xfs_aops.c                                  |    2 +-
 fs/xfs/xfs_buf.c                                   |    9 +-
 fs/xfs/xfs_buf.h                                   |   13 +
 fs/xfs/xfs_dquot.c                                 |    2 +-
 fs/xfs/xfs_icache.c                                |   38 -
 fs/xfs/xfs_icache.h                                |    4 -
 fs/xfs/xfs_linux.h                                 |    1 +
 fs/xfs/xfs_mount.c                                 |    9 +-
 fs/xfs/xfs_mount.h                                 |    4 +
 fs/xfs/xfs_super.c                                 |   53 +-
 fs/xfs/xfs_super.h                                 |    2 +
 fs/xfs/xfs_trace.h                                 |    3 +
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
