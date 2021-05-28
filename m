Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECD33945CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbhE1QYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 12:24:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65326 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230243AbhE1QYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 12:24:33 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 14SG8D0U005399;
        Fri, 28 May 2021 09:22:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=YgXMFdH8CoZiTcSy9Dt4dq5N4bl/MNaWtdxCkfr4ojk=;
 b=orlYUHuV54UHcos61P8lmieM7T3n/uET9Wvs0BEm43dr7/qmbkr1CfFd+BZMCL8c++QG
 JJ0zgJ/Rqx9R8qdSr5WF3MGVeX/dfeHJ6nQdx3MH3RPVKstjHyRS7QiVWc8Foy9ubF6A
 06LbT7HuOqAlaZ676JJNJzXSMGbO1SAXME8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 38ttrxjuqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 May 2021 09:22:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 09:22:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3mB85b+X7sb/TOZuq5zNHtlqN4VS7HVpmZduWzSu/MC0h6e4c5rzuOrqIbsIjW5amXWcKAVU9viHc8B0IGKpGL893L7A7NU7RyMONYEEfq682x6DJ/eCDc3rhWxc14f/5i8GO5SjbPWWOO8zHFa1lsf/v/ouFOzpdl2JgKxmRrOnaEeUiyjOIxw0LS7kCpiB5Wi4vPjKibEiZpEMWYfi18clGb2nqk9x7D3bQQGPaZ71xPYeiL2/18oOO2cGHD5TLYw7ZSLed1yneKK2JgQlKESRIOsymOpcyKEt7W3QkRfFwHtmj9GJIiy6z9QIZFe0B7L/IUiEH7BX5dJg3TjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgXMFdH8CoZiTcSy9Dt4dq5N4bl/MNaWtdxCkfr4ojk=;
 b=h8QIZb2/wClPiJiXJ1Nw0T1ldHF9a+J/ResVTUoC+Oi7FZuS7YoOAskXbZO/Xyi5rZHWGx48vw0fVHiQJ9GX+fjBWO5YOVpghWY9AZ2Zm+DO1B9T0nBaSOAou3AihbiJO8z8Lc6LVNrFXgNmKlDOemduCc2/nP4oe+xgH4/E5UIBL96S39veZja1nBJy0+PL/jcv8x0riIQ90PcGXPoE01YCJQKJOYMb9gPAo3YyrICZ+EHuOySaB3D9HZxQcfX6Q1odQO4FKzxC7KFn9WWbz6UCPp+FHGEKwlCVRLm+E1lo13D1JJ9T4XP7ryla1sFEuN5vaYjylHoxLIUnOkzN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3477.namprd15.prod.outlook.com (2603:10b6:a03:10e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 16:22:50 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 16:22:50 +0000
Date:   Fri, 28 May 2021 09:22:45 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YLEY1RX3FhR9eWrv@carbon.DHCP.thefacebook.com>
References: <20210526222557.3118114-1-guro@fb.com>
 <20210526222557.3118114-3-guro@fb.com>
 <YLBcPCHJOYH4YGl6@T590>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YLBcPCHJOYH4YGl6@T590>
X-Originating-IP: [2620:10d:c090:400::5:fc1a]
X-ClientProxiedBy: MWHPR1401CA0006.namprd14.prod.outlook.com
 (2603:10b6:301:4b::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:fc1a) by MWHPR1401CA0006.namprd14.prod.outlook.com (2603:10b6:301:4b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend Transport; Fri, 28 May 2021 16:22:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d44e5827-286e-4478-b9a3-08d921f4d67a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3477:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3477D6E73AC066A2428B37B8BE229@BYAPR15MB3477.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkGUu6XD823MhC0rvtjbF9hV9YNlcnXnBFGvogqzuRF5jjcd7iv98SxC4l1VCaZ/jPjLT7gBAWLzNrsMooYZ4eugHlBx7dotrDVdoCECNCAUXQ6LASAMi3wd5mimRA0W2hFIgSu40sY28tk4ls6ok+VKZ3zx9fWy7e+RwlMjlVYHTsllpgJ0VL5Qcu7eQs3N9mC63NrEf3rO0YD7u8K1cvMJwneZZsfzX9gM+pz9py/gqH1cCWrV7lZjTe7qrvnlZk5Itps5RNzUZNs6fjqnHMOEruK4RIhrbP+tsjWbl2Kb8cmY2IdBhND+GxYNc72bIHnUPB9GXZTPttmXlmp3nv/cTBMprHYfy3pRhc2R6d5zkQaYYx4ks5pLAOFjshdpZ2e7cYCXgHAxJtnfayu2Cjuy7HL4axIGLwI7bwzHNEAaOOnPJ0WpmGWtHvCnnkGau3ExDA50yO7BHmoMzCNpQntSYEH0ieenkaxjPosUgKCaR2s/4n6+w7JnKaygmLzHO7cOnxx+PjXI9QnfPmdI/5p2FdSv2V3qCdfLWm1HEcWZi75yPGxaexraSGcPx9Vq1BvMr+wQGb0+BEpx75QAq6jOHC62HE13cU8ndnm+MNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(5660300002)(7696005)(66556008)(66476007)(52116002)(6506007)(55016002)(16526019)(7416002)(38100700002)(186003)(498600001)(8676002)(66946007)(54906003)(83380400001)(4326008)(9686003)(2906002)(6666004)(86362001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eIjyYd+wsv7LZta9B5NEGVxVo2n/JKAWZWqvgHCu+LS9UAmsdyzl4UymDYyF?=
 =?us-ascii?Q?Zrm8DxCXx3pR16AglqwHsUZrWJJC0cv5nAbsPaOb3Pjt8TczYNe1utMp4LxE?=
 =?us-ascii?Q?8WFAZZ6SGIjgUbCXUAXii+yOmWfxjaETUhZpclp17gOZmXvPm6mkiiN8EVuP?=
 =?us-ascii?Q?56jX074TujDq68cJmzBg/RFCULiRbi5JjxE2CJ37p+selMzeFPkbYKnmKo4C?=
 =?us-ascii?Q?QJI9mvbRYp20p7U6jKpOgQkFd03YBqRTYDVuB5kMxL0Up6D74arQ7B5ECqju?=
 =?us-ascii?Q?/dL/UsMxJq7r0EyuM2GIpItNfvCI4aM6zjKEATi83Zm7W1jxh4V/m7Z9nrjq?=
 =?us-ascii?Q?Cjp0TiZtx/ZUc30OtWP3gwXAyZUwzC6y+AhHu8XbMnY4AlX7Ns93rs5yiH4a?=
 =?us-ascii?Q?N7inRteoSn9U+msp7AnHBz9pjDIl7fBvsaUWFw833UkYIkHr/55GJhxDpKCj?=
 =?us-ascii?Q?Z2ADMI3En2oLOMHLiW1wLK1hhYRQg/LQkXnAHD2z0dLpVC8h/7RJwjmizJC0?=
 =?us-ascii?Q?1jesYDcnpaj1cLhjzH3J29Jev5C0v4eUflO+cb3ENyifLe9IertF1khj4YPK?=
 =?us-ascii?Q?ElIr6mzlS712trnQK5AzRSpanHFpbpqpptX/ujbmdHVQaCaGlWcraBSX5j5w?=
 =?us-ascii?Q?eXe38CBG6EZ3Ef62Ho7smGe1VH/2qpbFk2K+aEXls3lI6bss2SEoNADCws2z?=
 =?us-ascii?Q?PFDEwn2fzAVTLdrLtPL3+FTktuhdeDsjA/hj/YXW2dl4XumFXVF2458vznlT?=
 =?us-ascii?Q?ltv5LembxgesodC5wc0Njp7qTKilYZ07ELQdNXCCobil4fau0R4M4aORXfRU?=
 =?us-ascii?Q?KxgdXBQ4MghnBAZJhUFJ4h14sK/nYCeqTvQG3Nsg2EhZ651q9H0xG6gLitw/?=
 =?us-ascii?Q?IM0frcZfUBRHXoteCFZZuZ5JBiW1kwHUBGZMy2iUrjLoVE15R4chBQBrJNVK?=
 =?us-ascii?Q?F5G/s7ghLQufckiAaz2WZw3cHuXmytjSoNnuje3vR1bTVOOXRgs+0gWHR+5G?=
 =?us-ascii?Q?dclDnx732OuexAOsyPTmrTZF1MJgXUYp5viyQDJD3WpGV3hhFj7Y0vh7lo92?=
 =?us-ascii?Q?1XEs6AhTDH0OFht9KBgghPIWLqKu/PWSRsXJinVF15mVwBuGIs3p9ZJtk+TQ?=
 =?us-ascii?Q?8vLsRCKQ4JsCjhP+75zn8nsSYjF7vXq2NzJt/aNfKfcxTF9Y1qAT4SO4IVOG?=
 =?us-ascii?Q?eZliDMBF5Sj3eTJfkMV5rWo0MybZ4Oomk2QRhieUkaM3MZNgfDGaCFODw/UB?=
 =?us-ascii?Q?4Ociql32XfS0qqGDMyV581BLZNPxbxjKSmCnigLBnRaYtcJwF1oC2pEcCz5F?=
 =?us-ascii?Q?95bxireJdPB9EtbGy5YKalPzIZVyjxRlZy2tuYLNXbXX0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d44e5827-286e-4478-b9a3-08d921f4d67a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 16:22:50.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eP30q3dks0fVZUNkF9gyCFigrFIhZrtE/wc7gAhbba9K3GthXRLA/VPKwrNOhkvd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3477
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: rI9puzIEh1YmMZ7eQs-AxnirlJHd7MdE
X-Proofpoint-ORIG-GUID: rI9puzIEh1YmMZ7eQs-AxnirlJHd7MdE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_05:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 mlxlogscore=454 clxscore=1011 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105280109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 28, 2021 at 10:58:04AM +0800, Ming Lei wrote:
> On Wed, May 26, 2021 at 03:25:57PM -0700, Roman Gushchin wrote:
> > Asynchronously try to release dying cgwbs by switching clean attached
> > inodes to the bdi's wb. It helps to get rid of per-cgroup writeback
> > structures themselves and of pinned memory and block cgroups, which
> > are way larger structures (mostly due to large per-cpu statistics
> > data). It helps to prevent memory waste and different scalability
> > problems caused by large piles of dying cgroups.
> > 
> > A cgwb cleanup operation can fail due to different reasons (e.g. the
> > cgwb has in-glight/pending io, an attached inode is locked or isn't
> > clean, etc). In this case the next scheduled cleanup will make a new
> > attempt. An attempt is made each time a new cgwb is offlined (in other
> > words a memcg and/or a blkcg is deleted by a user). In the future an
> > additional attempt scheduled by a timer can be implemented.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  fs/fs-writeback.c                | 35 ++++++++++++++++++
> >  include/linux/backing-dev-defs.h |  1 +
> >  include/linux/writeback.h        |  1 +
> >  mm/backing-dev.c                 | 61 ++++++++++++++++++++++++++++++--
> >  4 files changed, 96 insertions(+), 2 deletions(-)
> > 
> 
> Hello Roman,
> 
> The following kernel panic is triggered by this patch:

Hello Ming!

Thank you for the report and for trying my patches!
I think I know what it is and will fix in the next version.

Thanks!
