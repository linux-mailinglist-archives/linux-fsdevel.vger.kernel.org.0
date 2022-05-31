Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD775399C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 00:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348527AbiEaWtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 18:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244193AbiEaWtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 18:49:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC60A0057;
        Tue, 31 May 2022 15:49:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VKp3OO026952;
        Tue, 31 May 2022 22:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HD1Msrjxq79+kMu+isJsPXVnkfxwkvRb6vn8HKqhCzI=;
 b=Cca+lI5E3TT7drOiIiasi+sWTmc1og41V3WZRHETr+PzNA+RGxAnl7BIw3YXPvobbeRu
 +WWvB+kFL3bDkm51MxUGMoUgWoh6cPmjRhdukbfDDJrw38EK4U89RU+yl33abiKWprjl
 hiyefiTz+YiZJMitzr6e4zFidh92iQsWDySlaN3xq/SG+giha5ez355n2jU0drCN8d/D
 9PPfxd1AP2kEdyAwpo2J7XprXp3iKzRt12OMNctpM/mKJo91IApPGBSq/sM9rFTfNJwG
 Ig6JjbZB4U5oB82vlLLvZcihQZ1vQ3KYAGs7/Iz14LEQhzswbJ9LcAMecs1HPbPeC59C hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc6x6d6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 22:48:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VMkDSK035182;
        Tue, 31 May 2022 22:48:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8jy6t72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 22:48:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlafuX5g7JhQrBZIReD1ijg0/8OYB9R4KEEevuXZemYYLyDdIDXTz7FC1KYRJxcVg2uCsKnAdSiFMyrYkZqFncdRqj0/j7GuEMIq+1qq6rBCtkJLq5VaEMdCPuUnqdv2joTQSWT4NyFb6Vv3lptuXONwxai/7nKH+D6EZoBOE4vPONn3eLTZUxp1ho0oAER0n1v4UYtwlyYkEJ+qi4ybUlKQXIxyAamCljpQXI04hkFxYuT53uVRdqNznq0a3ULTYHaPFUT2LAv3by+jjnzsJWOZXoIpXo4Ov6/ryiFLHW29UeQvXgaie/R0qJ4RvppRKWyPeuTZVbt2uNC1qvbfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD1Msrjxq79+kMu+isJsPXVnkfxwkvRb6vn8HKqhCzI=;
 b=kE0dmFIwEvEVt92HV9cMc5EoEii2366aMeP2lw9H6fXD+WbVclr1iL7w2fA8QwIOf9GADj6GO2cc34zFUPaWX7FWztyK7hZToRtGq+KxKR1Htc9JR+xW8wKDKn+Rc6lzANE/OG0IdeE1zTz4rhsOBnIg1ok1/WOp8eEHisky6udzWMjRCLPAUxFMwmjgVvj2fFZMlMr+WrR0hPfDPa2OBwrFZUAvvSfpd0d5Mjw828jDB4Mh6Z+snTnLCaO3C9ZC1aTPSk5QPlvxYb8FFfDri0OYsw9AlRf6cFRyKsVjmXCcA+eQQK1oTpIQZpjiTf5oZSFm9gpaFMq8QQzW+2LovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD1Msrjxq79+kMu+isJsPXVnkfxwkvRb6vn8HKqhCzI=;
 b=PnIMy+EO5c8ju8w331tDT1grPUat/z2un+O+x485w1c1ADZmZCMUmFGnzzBitxVIu1pcni8IDw2jDlMAj4++NRSi1+DXI0BgG/946E13j5v9ONCZmm8OWVM4alNtu4BUDwmZvJYXIn+xXg9ap/Fcx74tBBJhUgWsRQ8JpqNofk0=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB4979.namprd10.prod.outlook.com (2603:10b6:208:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 22:48:44 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::4421:897e:e867:679c%9]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 22:48:44 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Ioannis Ilkos <ilkos@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Colin Cross <ccross@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH 2/2] procfs: Add 'path' to /proc/<pid>/fdinfo/
In-Reply-To: <CAC_TJveDzDaYQKmuLSkGWpnuCW+gvrqdVJqq=wbzoTRjw4OoFw@mail.gmail.com>
References: <20220531212521.1231133-1-kaleshsingh@google.com>
 <20220531212521.1231133-3-kaleshsingh@google.com>
 <14f85d24-a9de-9706-32f0-30be4999c71c@oracle.com>
 <CAC_TJveDzDaYQKmuLSkGWpnuCW+gvrqdVJqq=wbzoTRjw4OoFw@mail.gmail.com>
Date:   Tue, 31 May 2022 15:48:42 -0700
Message-ID: <875yll1fp1.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0119.namprd11.prod.outlook.com
 (2603:10b6:806:d1::34) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a21acf1d-2dea-4be0-4b2c-08da4357b723
X-MS-TrafficTypeDiagnostic: BLAPR10MB4979:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4979144762343BC63328DDDADBDC9@BLAPR10MB4979.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYrdjAG6Omr14f6+5czCWFTM/k3rf56Fng/c77eFQ5mzQ3UnWjeft0SWMbic9W3Gdr4i+JU1QzCbvM7fHD7gYzxmZ+OZzlR3Vy2uWT60aEGHiZZWHDurG51zxvo0+5W5wx0p9OgC68l3b4+qICDU140KCiH4kFmdGX9YHFYWO9jFvFSXZyIyj/MHMBA13qR0sI8Yg3BALJ9axnSou0ycckv80ixLR7hNN31dAyFX4yFjOs6RPvE+/gIn13qB9wma9g+gE6u6QiVBwpkRyGRe4iUfpF1tbzv276K9BsbqLLtsLLPDT3ApPMoLnjXtSiEYUoBzJOkw6W70PHrhD1menQ9qSZd7RpJQ9E7Wr0hxgCFcxY8eqEoLlsVZ92dBoMdjJYM0b8NnUMbgOjYZp1yjvrgvohzTZKpqkQ8j9E4ctCWVCMcSpfxCcVI4UON5c8hqOewAjD1yT4bcGOw5ImobMfwvgVZ/qkSkb6YajBK/ks18loKno7auPeJx67YsTJYnWXWe1LN5DUpSpt0WfWP2EXrV0qksSL6EtM7ZUEJ7BxLCIOn1l+dj3o/DFUG4WCMV7bQhL2P5yZNr2MJO0i3DQvZpoBtncnA2Z2S5G8eZyjOj0SvcNhnEdOH+izOpC9hyNR4rvOpsM6DKHgHutlH4Zpd/mxi0cpi3Da3s2280KBnzSC2LiZLedqad4FLqh7hkQtcnJ7liYVQf+zbXf6OQfdkq0Bn4vZNBMW3jFv3y2Ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(52116002)(6506007)(86362001)(26005)(2906002)(54906003)(8676002)(38100700002)(4326008)(66476007)(66556008)(66946007)(38350700002)(316002)(6916009)(7416002)(6512007)(83380400001)(186003)(5660300002)(8936002)(508600001)(6486002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rf2Wiih9JRfhBPATSkCYGt/KCqldNAVzAFZZ+Q90P1OkUxs/BZCHMmn3hceN?=
 =?us-ascii?Q?WEOqKc5OkwGNyKYvNlcgDud63AZExbU25r7IYq6AdlliixgWb0OvDqGgztj0?=
 =?us-ascii?Q?4uYyaeRQNL3Qzb21s1j70YgURY9//AFE9hsQy3DydRG0jfNax4/EdXgv3i0u?=
 =?us-ascii?Q?T49Ra2IEaZIOERw1QBaPKExked+QTrQdmlxtq/bnpD3h8SvGU7g/Xm7EqElE?=
 =?us-ascii?Q?wa//3kzSSsdb+DzWTi80Q26FtSXrd/xIqP+AUAi20yFCSmvgE4pK37Jn7/x6?=
 =?us-ascii?Q?U3tSrmInplD1D9s9UHjJB0u2pjTMjF44DYnElSbJaqr+DnmVI7x5hQsoK1IK?=
 =?us-ascii?Q?YQT59Oz4WpOImHDBUDy2ESHOgUWuLz1+mYoTbW2U1tJ1lbvSFvN7L6GH+iZB?=
 =?us-ascii?Q?be2ZSP8a0nR+HXd/KlXx9tn83QbafBm1NamVHrm7leCxzyLY9U6qSnYPuPP5?=
 =?us-ascii?Q?r3AMJlKEa6VVcgwT8MjQcSgRttvfxuaxSCpuZxiqL2jX6ojD2sefxZOdH0yt?=
 =?us-ascii?Q?paFZpxM25baFdnQcBwy0VaWGsuHA6Q779bQKxKaX6bvkP+ShaSJCLYH5aeLx?=
 =?us-ascii?Q?609CzYG20iSWGJCnDU8LxfOpE9lzWegyWiGHNjumZxPS9RECeAqdJUech7mK?=
 =?us-ascii?Q?OcFv4P/oJCo3vAVZXyDKH+r273rG7I+qlL5ABnkUxEWYoI+cX9C2SWwj61h/?=
 =?us-ascii?Q?39IVIH16kWmUzJyatElfUVSsdoIttnUnSDH0tqdvwkPWS5XKI+9M2MCJMz2e?=
 =?us-ascii?Q?0NG0Q5YeAonovZIfjy3l3XEF30wmYADiMHQQhoRQdh7LCVG0XZXKUdKMN8gg?=
 =?us-ascii?Q?0gWic0QFIojWSK3c2GIkqigBvlpT6cZB9z8pAUw8VVskgsb03EOigvadvsgt?=
 =?us-ascii?Q?fTx2iV9tXECFROFid2aWA2tOQCUiZJ5XCnT1UvTvVh/t0SZiE+GBDYhRhuPi?=
 =?us-ascii?Q?rmPDWaK2oyRacfWT7buH6zH0bYOpPHAZDYALnzqMMhQJUI5J1iOiYdGAy/94?=
 =?us-ascii?Q?HHzDkOzoywBUizkEZgxTTOkSz0vgGrZOTGcrgaAn/mWHWULJkAtl0e2Wdnui?=
 =?us-ascii?Q?L8OBv8X7PTw5mc0EpNNsUfdQREq33aLuLWcVCVPnJ0aXmzBTD1B76S+bbjL7?=
 =?us-ascii?Q?s0cRRwaldVR6LldcsYSWLu3sLebJwnNot5pnWZMeovQO62b3b+XNg+z4Iy9P?=
 =?us-ascii?Q?aw6Dui2fbm0jyoOFdrlw+AML1n5VOtu8t0VaknzEtX5j3pqfZNM7jGgOzeJg?=
 =?us-ascii?Q?GlL51hQYvi/vyq1oC9jZg2IIR35LlKw4W3IAZl6FfnApMYJR1vfvBY2RwsOu?=
 =?us-ascii?Q?OlRt45Fy/LCO6/OWQJRlXyNOZ6FtlXuJMKgMxJ+/iLEvJKxUaiheVsVkIX7W?=
 =?us-ascii?Q?zFqxgGp7OXOY2QQdEyqd/kwC7LqTQ7+5cOScxFkPRkajOEPAVt0M9ymN0r++?=
 =?us-ascii?Q?4CC3ikYbO6152e6e8vltTLU4ha6ci/1lbSyczyEK8dmRLxvJgpzmwH1Rbl/z?=
 =?us-ascii?Q?5BfVxAUdQmc9fVOU7ymIOXN6bvzwD8QIWziLG2+7eXnfAPcKnN5ZfQxvHvCt?=
 =?us-ascii?Q?zzCuP/gBpo87Pc5f9SZER4IdYBxCSjrB8+GdgFWf6JsqWUJ4fPlZel4Fwzf1?=
 =?us-ascii?Q?cxjshO7QOXur9sEYJ2BTG19cJvRpw5cHjzlMkgH4RkpDgJQV0TOOiiRJUdpC?=
 =?us-ascii?Q?6+r4vdJy7lrDy9/+RT8jt5sGv1FBdTmvsXBRYMPbr49N2bfhTNmQpL5ELDVu?=
 =?us-ascii?Q?G3TBjAKCXMjcGyhNlgP6Bn4yFnyNDmo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21acf1d-2dea-4be0-4b2c-08da4357b723
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 22:48:44.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhAGUkyILvYHEPVZQK6Vvck2qc04mvV9Hbq1zllev60NDFmeabAq2HK8J6PdCo7lKEXn5XaT3nG3Yr3fhKMqBUWequDqOvepXIrjoldM7AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4979
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310099
X-Proofpoint-GUID: PcXknlohpSAg0dMkY7kHup0eYxjyLh84
X-Proofpoint-ORIG-GUID: PcXknlohpSAg0dMkY7kHup0eYxjyLh84
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kalesh Singh <kaleshsingh@google.com> writes:
> On Tue, May 31, 2022 at 3:07 PM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> On 5/31/22 14:25, Kalesh Singh wrote:
>> > In order to identify the type of memory a process has pinned through
>> > its open fds, add the file path to fdinfo output. This allows
>> > identifying memory types based on common prefixes. e.g. "/memfd...",
>> > "/dmabuf...", "/dev/ashmem...".
>> >
>> > Access to /proc/<pid>/fdinfo is governed by PTRACE_MODE_READ_FSCREDS
>> > the same as /proc/<pid>/maps which also exposes the file path of
>> > mappings; so the security permissions for accessing path is consistent
>> > with that of /proc/<pid>/maps.
>>
>> Hi Kalesh,
>
> Hi Stephen,
>
> Thanks for taking a look.
>
>>
>> I think I see the value in the size field, but I'm curious about path,
>> which is available via readlink /proc/<pid>/fd/<n>, since those are
>> symlinks to the file themselves.
>
> This could work if we are root, but the file permissions wouldn't
> allow us to do the readlink on other processes otherwise. We want to
> be able to capture the system state in production environments from
> some trusted process with ptrace read capability.

Interesting, thanks for explaining. It seems weird to have a duplicate
interface for the same information but such is life.

>>
>> File paths can contain fun characters like newlines or colons, which
>> could make parsing out filenames in this text file... fun. How would your
>> userspace parsing logic handle "/home/stephen/filename\nsize:\t4096"? The
>> readlink(2) API makes that easy already.
>
> I think since we have escaped the "\n" (seq_file_path(m, file, "\n")),

I really should have read through that function before commenting,
thanks for teaching me something new :)

Stephen

> then user space might parse this line like:
>
> if (strncmp(line, "path:\t", 6) == 0)
>         char* path = line + 6;
>
>
> Thanks,
> Kalesh
>
>>
>> Is the goal avoiding races (e.g. file descriptor 3 is closed and reopened
>> to a different path between reading fdinfo and stating the fd)?
>>
>> Stephen
>>
>> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>> > ---
>> >
>> > Changes from rfc:
>> >   - Split adding 'size' and 'path' into a separate patches, per Christian
>> >   - Fix indentation (use tabs) in documentaion, per Randy
>> >
>> >  Documentation/filesystems/proc.rst | 14 ++++++++++++--
>> >  fs/proc/fd.c                       |  4 ++++
>> >  2 files changed, 16 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>> > index 779c05528e87..591f12d30d97 100644
>> > --- a/Documentation/filesystems/proc.rst
>> > +++ b/Documentation/filesystems/proc.rst
>> > @@ -1886,14 +1886,16 @@ if precise results are needed.
>> >  3.8  /proc/<pid>/fdinfo/<fd> - Information about opened file
>> >  ---------------------------------------------------------------
>> >  This file provides information associated with an opened file. The regular
>> > -files have at least five fields -- 'pos', 'flags', 'mnt_id', 'ino', and 'size'.
>> > +files have at least six fields -- 'pos', 'flags', 'mnt_id', 'ino', 'size',
>> > +and 'path'.
>> >
>> >  The 'pos' represents the current offset of the opened file in decimal
>> >  form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
>> >  file has been created with [see open(2) for details] and 'mnt_id' represents
>> >  mount ID of the file system containing the opened file [see 3.5
>> >  /proc/<pid>/mountinfo for details]. 'ino' represents the inode number of
>> > -the file, and 'size' represents the size of the file in bytes.
>> > +the file, 'size' represents the size of the file in bytes, and 'path'
>> > +represents the file path.
>> >
>> >  A typical output is::
>> >
>> > @@ -1902,6 +1904,7 @@ A typical output is::
>> >       mnt_id: 19
>> >       ino:    63107
>> >       size:   0
>> > +     path:   /dev/null
>> >
>> >  All locks associated with a file descriptor are shown in its fdinfo too::
>> >
>> > @@ -1920,6 +1923,7 @@ Eventfd files
>> >       mnt_id: 9
>> >       ino:    63107
>> >       size:   0
>> > +     path:   anon_inode:[eventfd]
>> >       eventfd-count:  5a
>> >
>> >  where 'eventfd-count' is hex value of a counter.
>> > @@ -1934,6 +1938,7 @@ Signalfd files
>> >       mnt_id: 9
>> >       ino:    63107
>> >       size:   0
>> > +     path:   anon_inode:[signalfd]
>> >       sigmask:        0000000000000200
>> >
>> >  where 'sigmask' is hex value of the signal mask associated
>> > @@ -1949,6 +1954,7 @@ Epoll files
>> >       mnt_id: 9
>> >       ino:    63107
>> >       size:   0
>> > +     path:   anon_inode:[eventpoll]
>> >       tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
>> >
>> >  where 'tfd' is a target file descriptor number in decimal form,
>> > @@ -1968,6 +1974,7 @@ For inotify files the format is the following::
>> >       mnt_id: 9
>> >       ino:    63107
>> >       size:   0
>> > +     path:   anon_inode:inotify
>> >       inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
>> >
>> >  where 'wd' is a watch descriptor in decimal form, i.e. a target file
>> > @@ -1992,6 +1999,7 @@ For fanotify files the format is::
>> >       mnt_id: 9
>> >       ino:    63107
>> >       size:   0
>> > +     path:   anon_inode:[fanotify]
>> >       fanotify flags:10 event-flags:0
>> >       fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
>> >       fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
>> > @@ -2018,6 +2026,7 @@ Timerfd files
>> >       mnt_id: 9
>> >       ino:    63107
>> >       size:   0
>> > +     path:   anon_inode:[timerfd]
>> >       clockid: 0
>> >       ticks: 0
>> >       settime flags: 01
>> > @@ -2042,6 +2051,7 @@ DMA Buffer files
>> >       mnt_id: 9
>> >       ino:    63107
>> >       size:   32768
>> > +     path:   /dmabuf:
>> >       count:  2
>> >       exp_name:  system-heap
>> >
>> > diff --git a/fs/proc/fd.c b/fs/proc/fd.c
>> > index 464bc3f55759..8889a8ba09d4 100644
>> > --- a/fs/proc/fd.c
>> > +++ b/fs/proc/fd.c
>> > @@ -60,6 +60,10 @@ static int seq_show(struct seq_file *m, void *v)
>> >       seq_printf(m, "ino:\t%lu\n", file_inode(file)->i_ino);
>> >       seq_printf(m, "size:\t%lli\n", (long long)file_inode(file)->i_size);
>> >
>> > +     seq_puts(m, "path:\t");
>> > +     seq_file_path(m, file, "\n");
>> > +     seq_putc(m, '\n');
>> > +
>> >       /* show_fd_locks() never deferences files so a stale value is safe */
>> >       show_fd_locks(m, file, files);
>> >       if (seq_has_overflowed(m))
>>
>> --
>> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>>
