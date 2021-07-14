Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03CA3C94A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 01:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhGNXtb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 19:49:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhGNXta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 19:49:30 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16ENfAwn001869;
        Wed, 14 Jul 2021 16:46:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=DKF1yofC/4G1EEYbUqe0ACjDsI29uTAqSJbkH4vKkgQ=;
 b=VrcV0ZEUwzQ4mNoLTB4gaz0px8U7CdhEXgUsAhOgb/SVMkfuFUTbqIdinkI78gSGSvXU
 SLuArlJ+M4h9s8zOz3/7hvyHRXpeIyhAi8Bq2dVXhhFKPas55IHeXRUL0FcQyZfGNG4W
 f5DIvqho2Wj2t6KkrnwamRwi3MRWgeDScco= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39sr5hxedq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 14 Jul 2021 16:46:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 16:46:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPyEgB9KuC1uyoQxyUK26ytm7g7yzh3clAJHauKqcHxLhyZD0FVMfHS/HzwTYPh6X25jEZUCHm+DC7eN8NivGuPZB3+hUmBDYoPFTKEkv2rf+KWP9+43fVWbMbVzSRvr302JGQPTXfw5akuSSuOdbgGNi++MAhCLxHs04kxE4STi28X776zM/LxDw/E1c/P9sUGQnOTvAILiKJtUvPAuzSXCiTdgx+IthVpyiXQkLmMUJudWmVAjXkY6962lCss0qjACCHBeD81mldPhKf1hytRjyUnrQvaoj2yGsVdP9dIE+oGO9vwB093mnPKgDMjW0cY2IOL7kXejrDfsFd4c3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKF1yofC/4G1EEYbUqe0ACjDsI29uTAqSJbkH4vKkgQ=;
 b=QV92fq8vNHpgN9aAkR1267HMb1KczQIvJLUuFEJdKLyn+bhzukyygzfuFkgThETYMrkN0gzu+T0FmXMflLVkxygueAkaBs/ODOawdETaiMYKv8POU5ZBEpsDYAhpk5bWdUanRsrxCp9CNkPFnzzq8bu22Ej643P9naJe3lB0Tsq1VkFIq6JxaIA5WFqFFWuF1n3nYr/pXdKY6EBZrpZpVtB7l7JDSRb8SUJ8M7WYVoTg7Izsy7GFnuCKtbcR2qs3/ZL9RpeL7f8R4p/wNnolvP0h2y8/Pwl9ssPcmazIS4imkkxItX/O1r/Vbaf+T40YX1mUZJLWIEmbEYhqdVl3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4219.namprd15.prod.outlook.com (2603:10b6:a03:2ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 23:46:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 23:46:32 +0000
Date:   Wed, 14 Jul 2021 16:46:29 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Boyang Xue <bxue@redhat.com>
CC:     Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
Message-ID: <YO93VTcLDNisdHRf@carbon.dhcp.thefacebook.com>
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com>
 <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz>
 <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:a03:54::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:d7b3) by BYAPR02CA0045.namprd02.prod.outlook.com (2603:10b6:a03:54::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 23:46:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07de5810-2435-4a01-601c-08d947219ba4
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4219:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4219E4DC0AB3D6DDAC661FABBE139@SJ0PR15MB4219.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcf+WuDFLneHwSCAGBUDwTn8qrPW9N5mkmQ74m0GEJJP3xn7I/wnYKn5PgWmXHPGEkNDptRS065oRawqWW5FUEWRi6aku4ZkvF6y4KtTuW2+o/XNPybEfKjqCu9rQjXV+KP11GiDwr+TjE443aqt0kdDGODyd47M0UPw50ZrZdSvwthyORDPNjKxZCpOYiQrRzxGLhtui4ZONMT7+ydGvas7NtlcMu64Oz7CKVByehpLjnWGtXKjKIlA6+BxRZ+kFNgyyJxav1hqVoxaDarvUoX0WMaKuWV2rI/gEIOyzJFxwdtaUXyl2VP9K914UXi3fRDromCBUmPLIl2TPlUCDLT32+M2R/CgrYH0k+tKFySdSF+YNV2ytX5POgLmkBJoP5tQ8+KmeLteJDqU93dXZ6eIjslodvdDfhDuA3H6cL5t3/fv0Z396rXHmouaWFBQFZQD4v+zkX3x5qfaoH8zDh5o5IU9kej96epr2cAPOVpzy7bTvkhELPYzDDE+j8GtBbyB7CN9b4oj1qBGsD+ke6F5yWI7lrk3niZ31bT0baAX3bnHRsWB2a12ON4cBcDIkND8j/b4DMktzf2qJqPfQHXtXO8oVByn/aFM9kVWd9pg/VEKtyAlglc9yk3/i0d3QAnAGBx80N9uetNnQg+vhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(7696005)(52116002)(2906002)(8936002)(8676002)(5660300002)(83380400001)(66556008)(66476007)(4326008)(186003)(478600001)(53546011)(38100700002)(55016002)(9686003)(6916009)(66946007)(6506007)(316002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VqNDjXq8MLFNCN2esryNcLZtg752J4ymSpWpDoNXL0U58EpZCTB82wlDpWCa?=
 =?us-ascii?Q?gSbG3Cb0fIlyydls2d+42tiaLWNDCGJM8WdOqHrMwNxvr05bfkO+rGZ9bYeg?=
 =?us-ascii?Q?trmETbH9hP+em0HpNV+S/14Dnx8JjbrABNIRMtRo2iLUWVVOzhHVNfp0oYL2?=
 =?us-ascii?Q?ctNuQOabLvy6B9jAICRNhhaDQVRQKViIultM2CVxGIg9Jd+GyYaMgb/ijWfL?=
 =?us-ascii?Q?4FplIgXyiz9x+M3HctOZGdCCgRAPi0YyATeyjyzS0io9mTgbSbYC2w0eXu4F?=
 =?us-ascii?Q?h6fk407ZWd7BNJV2WyekChRtJNZkfsmnNsFwR3BaWpjRxyJ7TzKn3neRwCFi?=
 =?us-ascii?Q?QTmO96sayHY+hlohMjdkvz7Cnm5hd2vw7D11VKOKc54cZGa8KGL2R4SwigZi?=
 =?us-ascii?Q?xcJ6ki5CDsVt3b8wlLyfSLSw41eIO1rFkL9VMjrWdzBBHd3r3oF6E2C2Wj6S?=
 =?us-ascii?Q?OaCjrmMVU2uTX7vfr//l2LlmC/cxjgWCf8bgGWQDqYHhqlDyWVNWM3BEcZv2?=
 =?us-ascii?Q?i4ElhXoe0hXBYZ6BW7XLdZvchj40k3kx33oifI7cCw6AcrQEcM3a2PBnMlMe?=
 =?us-ascii?Q?4z1kM94cnao4qGNOsl8pC1c72LU49pgaR1YrW31XA8mJrkloSyqqaS6h46wq?=
 =?us-ascii?Q?r8nsh8FVQyWHVPyR8SUWX7vrg5L5dzhOa6GRt054WroPL9izQL+u9Hgh3CtY?=
 =?us-ascii?Q?z8PwkSzC6b177EyetsFW12SiKPK2JfoP9eRA7KMd3XprFAgF4I5/ETNC5pa/?=
 =?us-ascii?Q?4meYZKPMr2v2SwePuJ+ZYNn7/1INAmKVttlpeXOlm8/trxsipVOtC8SJjknD?=
 =?us-ascii?Q?mJKQw/lIlOhIrc9eaQxnzlaqUiBbsYr8ztE8dpOsQ4iHsVoiS2TUXV1iSJXP?=
 =?us-ascii?Q?aIky9yK9SO/af/HMDf221zj/x1KB9uGmWqCZlGPyqPpYizww7FXchZooG7g8?=
 =?us-ascii?Q?zs1aXfnHO0ntGh6ddIek7+5HY/RBMWkT2aEdCHm3HHS7jFiUJZaWntPxiN9P?=
 =?us-ascii?Q?onzeKKrTgrDFvVMnnBUVi50uWDGa2iMpIIrheb5AR/oZgtDwknzACQkcNvB8?=
 =?us-ascii?Q?tPXK6IPUjJ5bsxeyJRqEMXdcIY0AsVXq2oHp4F7ghvWekZLuabNvY6VvkRYc?=
 =?us-ascii?Q?I4PIOifduDZpE2OHY3jRk9yfkH4Qt8HpF0PWous3DTDbBBEAHKHgUlOLY6CE?=
 =?us-ascii?Q?EZ6QLPXLElSLviSrHuhXw1NnSEdkL++tyrxCciDNPbn5q4y1mMHC/e0O4aB9?=
 =?us-ascii?Q?6/+ugonUdBSCGJgZ0gVA3xTTZLvVqX4GcNZW013gM+CZA2c86S86kDrDbPcY?=
 =?us-ascii?Q?LtdbWYoNMPkmu5XjPb7iYVkfzj2T79c/4IJG7Sy/zzRZUQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07de5810-2435-4a01-601c-08d947219ba4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 23:46:32.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umCY8Xq6VsmuhVMugNUsRT50jTxscz1KSNZ90xwGQ0in3HNrTa7YVaG8Us7kY409
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4219
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: yWdksX0QNausqJ9bq8ryLghVRoV-YW8h
X-Proofpoint-GUID: yWdksX0QNausqJ9bq8ryLghVRoV-YW8h
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_14:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 12:22:28AM +0800, Boyang Xue wrote:
> Hi Jan,
> 
> On Wed, Jul 14, 2021 at 5:26 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 14-07-21 16:44:33, Boyang Xue wrote:
> > > Hi Roman,
> > >
> > > On Wed, Jul 14, 2021 at 12:12 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Wed, Jul 14, 2021 at 11:21:12AM +0800, Boyang Xue wrote:
> > > > > Hello,
> > > > >
> > > > > I'm not sure if this is the right place to report this bug, please
> > > > > correct me if I'm wrong.
> > > > >
> > > > > I found kernel-5.14.0-rc1 (built from the Linus tree) crash when it's
> > > > > running xfstests generic/256 on ext4 [1]. Looking at the call trace,
> > > > > it looks like the bug had been introduced by the commit
> > > > >
> > > > > c22d70a162d3 writeback, cgroup: release dying cgwbs by switching attached inodes
> > > > >
> > > > > It only happens on aarch64, not on x86_64, ppc64le and s390x. Testing
> > > > > was performed with the latest xfstests, and the bug can be reproduced
> > > > > on ext{2, 3, 4} with {1k, 2k, 4k} block sizes.
> > > >
> > > > Hello Boyang,
> > > >
> > > > thank you for the report!
> > > >
> > > > Do you know on which line the oops happens?
> > >
> > > I was trying to inspect the vmcore with crash utility, but
> > > unfortunately it doesn't work.
> >
> > Thanks for report!  Have you tried addr2line utility? Looking at the oops I
> > can see:
> 
> Thanks for the tips!
> 
> It's unclear to me that where to find the required address in the
> addr2line command line, i.e.
> 
> addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> <what address here?>

You can use $nm <vmlinux> to get an address of cleanup_offline_cgwbs_workfn()
and then add 0x320.

Alternatively, maybe you can put the image you're using somewhere?

I'm working on getting my arm64 setup and reproduce the problem, but it takes
time, and I'm not sure I'll be able to reproduce it in qemu running on top of x86.

Thanks!
