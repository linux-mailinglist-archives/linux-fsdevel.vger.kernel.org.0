Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A288B39C36C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 00:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFDW0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 18:26:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5088 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229746AbhFDW0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:26:45 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 154MOYJ6000926;
        Fri, 4 Jun 2021 15:24:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=tqawMRuN9akDj4PgOOjUXWd69bWm9UEVNyAJ582Ynjk=;
 b=DVUs1kzA0g0DEnxbk793938QyI+YIRuRKg3I08CXdRExKc0l9MeCFIPAMJ+irFh7zp2a
 qxYQ9ol3uwo1ntp13XaUUtMf+JsdVzVmzpaS3bJFoMC9IWHPggyYFrntyFvKNy8wR1We
 6OlgDz8Sq9VK8UeATFqLgxIgfQEa3op2rvE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 38y9kqed0w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Jun 2021 15:24:43 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 15:24:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VigYIzMNQsIfcKEIUnb1CLRHiCu8jlkTMUz4WuwTkq9dDV5LnhJXiNTxb/co5ViULZxLB7nJ9CsRpIVyndg6GfvIhbRtJmlMiw18Q/phPYNJsh+onbkDeR9MbODSwzmCiAgbYhnYdLvkLWDNct71l/oX1zd+1750y7696r80yJclQt0JxFo6CmmQyz8up2DsGIPYUcEyjGl1SibnIFqWxzrHRamz2jYJ00R6uOfivXo7mOXvUVOCwoVzSjN6aSzrw4MePIa/7AtnVaMIsUAzy0sjSAGaOJ+eZSnjA4/Ps7q70wD9Lc9ryYqJNrE9iQ8aUiJGsTrT/3WBlSL+NUznrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqawMRuN9akDj4PgOOjUXWd69bWm9UEVNyAJ582Ynjk=;
 b=RpUIHXbmlAZN+F43tjraT0WX4uzeHjPIYcdmSJ+79bqBxnuEdMsQdscrdSCgMXlL8nUuG5SZ3yVk0RAddr0SxcQ5MTfLcK/Wzm3pb9EoMpGb5ZydtQbxRpsitUreqbHL6hbXBiyIR2diDBh+TxWCelpHQFzHE3hKMkA4acnYTsRnphMQF9T5uGacySVJUuNVyC/FyNNYR/sdftjsq3t4gNzoZGs757B6fpF/cI8rjHVB8XxuFAawevkyxO4LMlujBWZdYnWTzoQehR4JEUUHLApxGy2jX7DWHVB7H+vLrWHyBY77wMNLZXwfwOiv1tnJgjjcyE8gpvJVDuGc9d4RGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4135.namprd15.prod.outlook.com (2603:10b6:a03:a0::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 22:24:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4195.020; Fri, 4 Jun 2021
 22:24:40 +0000
Date:   Fri, 4 Jun 2021 15:24:38 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v7 0/6] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Message-ID: <YLqoJn/FmyqjQs0M@carbon.lan>
References: <20210604013159.3126180-1-guro@fb.com>
 <YLpMXmWvPsIK97ZE@slm.duckdns.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YLpMXmWvPsIK97ZE@slm.duckdns.org>
X-Originating-IP: [2620:10d:c090:400::5:f03c]
X-ClientProxiedBy: BYAPR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:a03:117::40) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:f03c) by BYAPR08CA0063.namprd08.prod.outlook.com (2603:10b6:a03:117::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Fri, 4 Jun 2021 22:24:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a284954-a1a6-480f-a824-08d927a78b92
X-MS-TrafficTypeDiagnostic: BYAPR15MB4135:
X-Microsoft-Antispam-PRVS: <BYAPR15MB413540F4E0243AB2ABA09A3FBE3B9@BYAPR15MB4135.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jnKAs6umlxWS8++1UPpiL6LUBFxA556zI6jn4na9qnP3asVuTsh2V+cTLaQIzaN2CN0BSoOwP2jEbFaqFNNEaFx0AmCcBV0CAB599HbfV3PGs4B+tPkx0RmMItqoSqui/AA519LEoLNYnp041YFDm4TpIllq4fQ4GMJN7UVBPYm29/4HaIJAMbTbL7PVv+FizgrIxWEvtH1D4M98RKc4m1jSgfJdqcfDi/Y2/env5/b2u9Ane3QZeHK0iOLApi5aDqIX5q3/1dPqP5yC709gWRsbF/tDJReBKeuUnQEW4XN4My+F3S8nK7PAYiZy9U0elNc1gR6e1S4x9BLWkVKdxjPSVQCa/BBdGwhONz5Ylo3qkdRLUsJgs+0Y1uC5pyZHS9TtZmxzIE54iyGmqcMI8TDWZ8BO9iCJZLYr4DjNcAco3jXenN1or7dzozQmIz5VL3+PVqIU7CtmOoWGajkmGHelNlGudTKJ4uGaYjvR3u+7pG1oq9h1rMrVtoKYSn5DDTHQmnLHiQ4JHbePzAiklbs1WRej3KwA1pBGkcczvor4j+WqxKaZyuYVDQPnPfd+uDqbV52R8Ea7ixHTrMkEe2O0zUE4o+pwjRpCzLRrN/jUEisddF21ozb8xQZSw2fdP8EuB7Qf99lIU3QXdJQLUsW1AO2kilUFk3hn1BRZy1XCCFAftgCvCZrvCnoomqY8PHdnps3/O4dDTN1mQ2Zd8ourrj4S3ONmlyoeDc/9HWDUWDipV/PNX5b+edO+EPp0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(86362001)(36756003)(66946007)(478600001)(6506007)(54906003)(966005)(8886007)(8936002)(8676002)(83380400001)(52116002)(7696005)(66476007)(66556008)(9686003)(55016002)(2906002)(38100700002)(186003)(16526019)(6916009)(5660300002)(316002)(4326008)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w5IdEX7DyXauIsZUibeiMuh8X/aaP1C504YYRf6Rj9WcTrSqeCjU4yGcalvL?=
 =?us-ascii?Q?32HW8ML3gPhBYsmCXWMjMlQu8MirCwoQdMienekAjNQekRIg3F5REm0t1R4t?=
 =?us-ascii?Q?1FbOHzCTS71gwTIxSb3P7dMd5iXvFuhodOm1fKJcFjFC0+d6pcfNaVfSjiLZ?=
 =?us-ascii?Q?ESRmLjVYPBS86rWsBSFRpAmJVIv22mCnKGQed5x6+95foe5kALFiDlZOvfgM?=
 =?us-ascii?Q?VeI2eD91bNocJ4rcyaGjQyTjeBik9hrWZO+Jh4yfal6ZaczrKE8cF86zJv4u?=
 =?us-ascii?Q?9B8xLWjrDnyWhe2bVBeY4cv5fyDGikky70gkfDE9zQr4ZnmNIte7mh6dVtun?=
 =?us-ascii?Q?KEAIDz61q1yQwoYwXLg12ejQbg9Dz4xoeLwtEM/pJayNyUsqFZqBex3qdewe?=
 =?us-ascii?Q?c5G4j0QyBCrl+xYUvC08k0vY34FWlNBZDlKUDFUesRsHkdVaidjVKgn/TGii?=
 =?us-ascii?Q?/zb14agBcJmdJm3KzFOc6snhHImk9JAK2tI5U9YYrYPMZf8piM3KzIeuLQWC?=
 =?us-ascii?Q?gxWW6eqyFxOyrPCrgjF2nEmzvMjAUf09miySZ6zdruOTQK3G/eDZxRgSEca7?=
 =?us-ascii?Q?RyxQ4tT2lGivqTRCJYhVR8d651GnpUkU/aDMsnkW20eFfy8rSZsIGq+FD4gZ?=
 =?us-ascii?Q?AZioPklwI+jaVMw7V5OE+xMGjI2JWZt5/O1bVwUyyteTJEXh1o160vNRjmNZ?=
 =?us-ascii?Q?q9bKhlcn0E9rTElRrO2aigr0uMNVwQORxluoCQ33ThBDp2DpcefOoO+NHzl5?=
 =?us-ascii?Q?uBkp9UUysy/AjG0Nbc+B6oAb/fS9OJYM4DHr0X2sf8oL6wZdgppIsrkjkBGl?=
 =?us-ascii?Q?GErVQKYXFmziPLvaJmxt18cOkGWp+cPZPSPB7tRWOfKbZewLQaCHrjVL6Rsw?=
 =?us-ascii?Q?t1WA3IRHXXAwFc41K+vKv5FHaDjrGxzvd/h0jP4xM2r8BEuJGkJGzCzwJcbw?=
 =?us-ascii?Q?GBrvFtmNkA5w8kek9tlDeQqqMgPyPGuQOcL9FJDy5L47VXwBSvhK3mNtfR6J?=
 =?us-ascii?Q?8KtbkS9Wlhobqg/NjebiJk6A2RGYxY35Z2ExFhCO26dpDfEN1fisEDfGAiWz?=
 =?us-ascii?Q?Uc3DFJRlbibhD0hXjw5k5IWcViOXi+1i9k883xKs+SOCQXruzDPxtnZgGvBW?=
 =?us-ascii?Q?jcfwRcRRTGCbXWFYfo/Aga/+rITBggYc6oRBiFfIORtAIRwbjdaArDuEfTjA?=
 =?us-ascii?Q?Ual4mfUcZPMvV2s2kFY6jdkUrAcUybmfiwNRH/Et6KavWfAyoPerkeeRfM5V?=
 =?us-ascii?Q?Jajj27HnzD62sMRDn+W8Vy4D8O55EHMdAgJiBqlYL2kovzChAaNIl0eM7BO/?=
 =?us-ascii?Q?GfsRIIuqCx9KXujKmDk3CCTf9tybv8I1JqXt7ds2bRD45Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a284954-a1a6-480f-a824-08d927a78b92
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 22:24:40.6111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjTum9raA56BhNDljjtitoamkpy5t7TXLDmILENElaVWTq0OrupldSVQ3WBWVts9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4135
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 0bU0W6yNEK4rAfusg9llKT_RHJ2Tn4kG
X-Proofpoint-GUID: 0bU0W6yNEK4rAfusg9llKT_RHJ2Tn4kG
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_16:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=981 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040154
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 04, 2021 at 11:53:02AM -0400, Tejun Heo wrote:
> On Thu, Jun 03, 2021 at 06:31:53PM -0700, Roman Gushchin wrote:
> > To solve the problem inodes should be eventually detached from the
> > corresponding writeback structure. It's inefficient to do it after
> > every writeback completion. Instead it can be done whenever the
> > original memory cgroup is offlined and writeback structure is getting
> > killed. Scanning over a (potentially long) list of inodes and detach
> > them from the writeback structure can take quite some time. To avoid
> > scanning all inodes, attached inodes are kept on a new list (b_attached).
> > To make it less noticeable to a user, the scanning and switching is performed
> > from a work context.
> 
> Sorry for chiming in late but the series looks great to me and the only
> comment I have is the migration target on the last patch, which isn't a
> critical issue. Please feel free to add
> 
>  Acked-by: Tejun Heo <tj@kernel.org>

Thank you for taking a look and for acking the series!

I agree that switching to the nearest ancestor makes sense. If I remember
correctly, I was doing this in v1 (or at least planned to do), but then
switched to zeroing the pointer and then to bdi's wb.

I fixed it in v8 and pushed it here: https://github.com/rgushchin/linux/tree/cgwb.8 .
I'll wait a bit for Jan's and others feedback and will post v8 on Monday.
Hopefully, it will be the final version.

Btw, how are such patches usually routed? Through Jens's tree?

Thanks!
