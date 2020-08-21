Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA71024D957
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 18:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHUQEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 12:04:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57592 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbgHUQEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:04:44 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LG2PlF004982;
        Fri, 21 Aug 2020 09:02:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rnk64YE/7e49lqSYCrUx2r0LVtZ9PQ+VntLUaJ/gkvc=;
 b=RVvAWA+t0joC1JTRq60Ci1isPCKrtYhMWCfQu9itpw4nT48xHiIgJQkdx9jHDmtHPEje
 26KFj6ygUsNwXuutwJhLQV1y2eKlw5pxBSkTOf22sPuJrWynOd5T2AwieiSKLRdV918q
 NnZoA0BBJjGJyGCGc5vVLMle3M1Hj4VR0fg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304m3dmjs-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Aug 2020 09:02:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 09:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezeOO8sy2t4saO8ThpxGcE3bIAAJ1gnqaRAyPaVETU5i6hy0QFJ0xYmk85eoViylJ5vVIk+KzMQYB7LO5Tp6XNSiUtbei6hZUQ5ZBCoDGIVqOicxIG8l4ltgaTQ2YcAHr6WHpMsJLt3IN7fLKkUeMRCSE8DDG+5OFiCHnuDM16UAmOAemt+8VDRY7QFtJnzaielsgscTbpUPqj9IVpRZyS4t4nCj21MOLL3kB+BZdheikubLL4sdq329B4DE1jLKZEHEmkAas9bsYWrgXkZChMidLMfuaZj1MRCVeKjsuJiVDtWZR7Fr4f1sJBDtSIkNEHCiXhQjg6kG5uUKPtO9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnk64YE/7e49lqSYCrUx2r0LVtZ9PQ+VntLUaJ/gkvc=;
 b=ZwxUKyDH+TlTs0xH/2/yOA2fgQKLQw+bxXcIJFhA5pDu5ADtr8xQq1ILBTTC0KxaUpDEOhvfYA7KeMIHykBIs8k1UbCtC4z1csIKHcrHUNz5k/he8n9w+CH8J71mivWrjLNXcndEF7c4LkVYkYRf8JDpTaslcHPgMGcaZ7o+RVaYlhPhMJ1wJ7drTWFVyOkDoeXbGyeWBaEDDT4JQW2xGtHB48jhEwT/Qh3GkobxfaEimXmiAjel4HZpsdkrhCa6lP9Kax9Ma4028kAm4zLeBhbx9kLBPZTPygI6pIzFYsg6q0BBo57uLrW/sNqUCGP4zuWjoPpD1H3+bued65j2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnk64YE/7e49lqSYCrUx2r0LVtZ9PQ+VntLUaJ/gkvc=;
 b=Qm6V1kQnEoOiKZ8odC9WRcY0jtemDW+R+WMJq8/tFahCuDQOI3Kx39iKDum/BghBghDzWieFNtXb0ZFjrImijQWg4Vxgtpn3ZdPeR5GjPF9rtPIhfIj/g9WySPEtZvQ18S+EUIapwTNz07FGxlMbx9+n6Wa5On8EZACzyB7/Wbg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Fri, 21 Aug
 2020 16:01:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3283.028; Fri, 21 Aug 2020
 16:01:32 +0000
Date:   Fri, 21 Aug 2020 09:01:28 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
CC:     Shakeel Butt <shakeelb@google.com>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v6 0/4] Charge loop device i/o to issuing cgroup
Message-ID: <20200821160128.GA2233370@carbon.dhcp.thefacebook.com>
References: <20200528135444.11508-1-schatzberg.dan@gmail.com>
 <CALvZod655MqFxmzwCf4ZLSh9QU+oLb0HL-Q_yKomh3fb-_W0Vg@mail.gmail.com>
 <20200821150405.GA4137@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821150405.GA4137@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
X-ClientProxiedBy: BYAPR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:40::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e8c) by BYAPR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:40::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 16:01:31 +0000
X-Originating-IP: [2620:10d:c090:400::5:e8c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3726deef-992b-4bc5-5889-08d845eb78ef
X-MS-TrafficTypeDiagnostic: BY5PR15MB3602:
X-Microsoft-Antispam-PRVS: <BY5PR15MB36027EDB1DA6491D90C1A3C8BE5B0@BY5PR15MB3602.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTxDIuOhkylcDSZFBvYFWooXdzM6tN3dr9URaiCWbzlhMHRMBVrZ5YNrqCIn0Ppjt2TMkesuzdpk4gJO5Y42Ult0zbUV1uDX89w0t2AJhcFKdh0qlfhkdaovlJ0uKBe6KclIX0GHXILSUmwpcFsbsAqGBgt4RaZTxoip90M+GSYD7nF1XVQsNthr/bZa7/iZv/88vMwPyWo7zrA00OUsDYAn8ChLuj6g11/ZD0omqD+THDv5dBZLmK1ErpNtvQklLbBglXAd35T3XAxaVo9cfL2HzOO4AVmLHs8HPcMWfTCm1ibnM9bagDWcJMyE0ZdOHrxt2aOxOdgPQOnumhPFrzCfnn4xuKt8XOIFb2wTqbK2+n/Z1Gh5RLWQ0+ImCaQENJ5DLTjPmo51XYVdT71ihg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(136003)(376002)(7696005)(9686003)(1076003)(55016002)(53546011)(52116002)(33656002)(6506007)(66946007)(6916009)(478600001)(16526019)(66476007)(7416002)(66556008)(2906002)(316002)(54906003)(86362001)(5660300002)(186003)(4326008)(6666004)(966005)(83380400001)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: VAjZAwXafbdZ7+x6ynJIEdBFZ3kxPcHP3O9Tz9SqJtiHcLlCpdGW4bTSth2RGCLLQ3b+iwHPxoHjtV4AHJHzWgb2nMhtEX4iJy2q51hJzY07GCqsCASLQauj0JIlfv//e5mnY8OrRXWLPqebHdeyIZJhid2u4180wflbT8ZEjf71GFYx1TL0SjjdH1zGU/OpxYybFeNNFpDDfBawFCkoIrI2hadnte4hTS85JVYsu7W7rzluiHoii133Om1Zm7uqd3Z1jp6hT0KlSal2qb85i10er3o6U9GgWfKRHSgxMhZv0EOYz6b8PvgbNlJFWZODR7Ciu5NWs73J1/Cdg/IX+xMJxJWubQoiQF6ShrXZeTdpLLZzvnY9Wt9AGKdfvgm624CtuKlq5nXXHwCEiOCPoZDaG09aiqSb7uuruJ6Yxnx77t8vRc3yZaNY3u3vRKSvr8TbjtCktgUfFOZsIqkjfC4u2AOcp8UV1dqCfNrm4QZfsnYzvTOBEaQw/HkFt5fDeLx+bSv22PvCm5byl9WmGEPAopM/GzA9M0D76T1/vMqtsVLkMbzTkvvFcBcpo9r+2QlPEcfMPTy24J6zqofqRgFWAh0xXxE80hhKbrQhnIKM1+QjQWDesLHzo5fg8t+HFBkZFBuqDMy1NnA2F+hYdX8nTncCDrb+Ys+PAIPALvk=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3726deef-992b-4bc5-5889-08d845eb78ef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 16:01:32.4876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVDvrw2ifwVHYk5OhggUoJghYT+t5QLT7JSVUkpkTeOGSSpEh8sNy+BpQ5qQUecY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3602
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210149
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:04:05AM -0400, Dan Schatzberg wrote:
> On Thu, Aug 20, 2020 at 10:06:44AM -0700, Shakeel Butt wrote:
> > On Thu, May 28, 2020 at 6:55 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> > >
> > > Much of the discussion about this has died down. There's been a
> > > concern raised that we could generalize infrastructure across loop,
> > > md, etc. This may be possible, in the future, but it isn't clear to me
> > > how this would look like. I'm inclined to fix the existing issue with
> > > loop devices now (this is a problem we hit at FB) and address
> > > consolidation with other cases if and when those need to be addressed.
> > >
> > 
> > What's the status of this series?
> 
> Thanks for reminding me about this. I haven't got any further
> feedback. I'll bug Jens to take a look and see if he has any concerns
> and if not send a rebased version.

Just as a note, I stole a patch from this series called
"mm: support nesting memalloc_use_memcg()" to use for the bpf memory accounting.
I rewrote the commit log and rebased to the tot with some trivial changes.

I just sent it upstream:
https://lore.kernel.org/bpf/20200821150134.2581465-1-guro@fb.com/T/#md7edb6b5b940cee1c4d15e3cef17aa8b07328c2e

It looks like we need it for two independent sub-systems, so I wonder
if we want to route it first through the mm tree as a standalone patch?

Thanks!
