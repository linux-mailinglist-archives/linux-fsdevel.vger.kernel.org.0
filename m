Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D8B24E1D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 22:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgHUUGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 16:06:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15476 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgHUUGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:06:50 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LK0d1o020310;
        Fri, 21 Aug 2020 13:05:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=wUAx8CXyWwn0REf5nzJmEo+bX91x9dOeaJe1nMET1Gg=;
 b=Oslhq6o2PIblXvTVmHCjo4SijNPQVmGfKdYoqXQqBHO13WQT047ih0ITfb6U5BueC2mZ
 h9PQnAIRQ4fwj7immsjbjDhvtIorA6GXB01yIWZFYgj80U/8HBMI2D+YCx0K1TfQ0DHW
 Vu4ExOSLjMgiHUrbh4kIFRF0IrM11zFI3yI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 331cuebubw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Aug 2020 13:05:39 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 13:05:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAm6ailCsAovZ//ENZ9qpIFc0ir4LCKBOzHQn11BJevrvkoeF171ye7riAHEHBjM7bLfqpYBaZQZA3W9Baiv2SCcStJOwes1IJkchXxkZY1qHo60vd3j++8DC9ptllZPUYA66hItS2XSD/R7Py8sagRe3fiFLG7oFKGX66AJ9g8BEXwSHnQnifkOgLXU+7oRCEEdZNkrMU7hnQfG9cQIHptRz2Aq738WayOYnFJz7oJc8jY+uuKfGCPqAJIH/gAvuX5rY/uek9Z1hr8EL+bEB5T+HCTWqJSRmjSm0zbd4twyoq1Hc5DtgaaAfQ/krEwakEbRzg+WU4utbxxaNwkgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUAx8CXyWwn0REf5nzJmEo+bX91x9dOeaJe1nMET1Gg=;
 b=h6Ttj1vmTyKPiPHwztlMtgLaC9eiO4z6hWNq3atQndKYF9Ggp6B5GW09Tgad1Rchq15Q+UnLoGCxJ1ej9URX4u8cLsSYVXjakKDYLmtU8RhPFizOXRluYnvtBqt6GIsqXyTW6uZDjw+EiOHFWubWA/PwM7yzn0meuGe0s0aew8pYhuXrX6vsVnx6UDm/cvMQSSPKsMIeikqOIygHrIWjG/HRh3jZ++RpM4MXcVGK9ZxUItpugs66c+RIlLjt6nlOqO2OE4MwrsBgT9XvrA/SFO8GwUXZE4rKbENzd+Cq7UR/QKFRmDZesLgsazHtH1xcp3umgYtfq76IV2PeMKLuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUAx8CXyWwn0REf5nzJmEo+bX91x9dOeaJe1nMET1Gg=;
 b=jp+E+qei1X3icW308uDTJBMcElt7uyh9dQLaB+hbilKeoxNe+iTjXjHaq3IfCQsLeXMFdEvGxziRc8iQtdeoWf+Bk9KyTS1msqvEZewf7/rE9L9cphBdYYbCEQGU8UIRZQ1WZJEZXegOUfh1Lkh+p6TudUsQ4RzaWd1qMHzMtCU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3448.namprd15.prod.outlook.com (2603:10b6:a03:103::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 21 Aug
 2020 20:05:34 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3283.028; Fri, 21 Aug 2020
 20:05:34 +0000
Date:   Fri, 21 Aug 2020 13:05:30 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20200821200530.GA2250889@carbon.dhcp.thefacebook.com>
References: <20200528135444.11508-1-schatzberg.dan@gmail.com>
 <CALvZod655MqFxmzwCf4ZLSh9QU+oLb0HL-Q_yKomh3fb-_W0Vg@mail.gmail.com>
 <20200821150405.GA4137@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <20200821160128.GA2233370@carbon.dhcp.thefacebook.com>
 <CALvZod69w5UoCjfWcqVAejpKWzRAUxX7dEPzqDUknHhUFV_XEA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod69w5UoCjfWcqVAejpKWzRAUxX7dEPzqDUknHhUFV_XEA@mail.gmail.com>
X-ClientProxiedBy: BYAPR01CA0013.prod.exchangelabs.com (2603:10b6:a02:80::26)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e850) by BYAPR01CA0013.prod.exchangelabs.com (2603:10b6:a02:80::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 20:05:32 +0000
X-Originating-IP: [2620:10d:c090:400::5:e850]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a211de19-fb67-43d9-130e-08d8460d9038
X-MS-TrafficTypeDiagnostic: BYAPR15MB3448:
X-Microsoft-Antispam-PRVS: <BYAPR15MB344897842885D0D812D0D066BE5B0@BYAPR15MB3448.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJdGRkhKIOz98v2XjSEpwiQnxKUliWiI/No9wuq7FgIGR6KSmnvvr1IxEQff3xc0InkisNC25MRzpBkO8qqxHCfN8p1iQXKkD8+KjUwaEyGWkqSVuN0uBjvehpam0lzr25+on709GGTN919Q/qeFwgW9Mdixjj45Oe/5033oYPt0eK05qdPPIP2qBgvDFUygQY/+L0EFR7tQ7DibFeklWGDuKRRDV5BXibkKllIU35lVnoDeSAnyaAf+8/xGlh8qJhAbk2dhV5/xbDrygoTqrBtAaDdjrDOwAli2cZELItSZv9prshdMdk5ZHXbhQvrzZ8eR3wa/hv+js+oiwZ9aUaPpiSnp8JaAq1bfnKiXcZWl6pEBgRWsZy3E4Rf3V4ysNgj3STB1xYmBHpymhWBfiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(346002)(136003)(39860400002)(316002)(66476007)(66556008)(966005)(86362001)(478600001)(4326008)(7416002)(66946007)(33656002)(54906003)(6916009)(83380400001)(5660300002)(2906002)(8936002)(1076003)(9686003)(55016002)(53546011)(6506007)(8676002)(52116002)(7696005)(186003)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bLTXYiGEm5fYOApXh7Oq+Wr271vbvfwg0SabdwxBRfWQm0opT857f7dglzrKJ4YG/v07oy8KHqAPK7GvXheL3eBbMANn67+jyUs2AyaKCayOQfXBR+MFy7dkIhWZalKuzlQSmwqnGuMwyBmQfAmTt7QrADuMXyAMub3gn3YanRnFHT9JrgNQPC/R/zC4zlIN+z3uJuHOVvTV9dQKz6PPOsrsc64n7PvssYVEFodBbCc481lWCO7yAfYHQybQfelOddTr+vmFl0+H1UwdBjQFPL6J+te+6pXRqJqAiS6diD4RJ5nwDRF4qEwB2hwuaZCxLVFUeOb3oDy70MMJijBNO1FfsKei/E4I+5idHnpJ3mjRkEhiOYkQEhwcvTTGcMflzcd1XoHNbcRdL8p3O/b7+0oTgnaSx48HPEaqDLUvcnquzhmnmlK/U+h2lrj5o59DZA0mqEdpwK8DJE9gzSdVrGSxv34ISYQu2Yu1b9cQpSCTpZrg1VwmshEQjIF654GU6f5LlkykOuT8kbB7hrC8HGs595Yn5zgT1FWBH9artW3c0CDGC8qQZLcDnDpbM2ZlqBU0e4REWt/WjNAChWZzc9iDstIu58vonJr0DTVKrur8mAmbFHlUtlyQ/Zj27KMlAL9WWpmuVVE73qrxm+qkeCYssMv+xsFqzXf879Nkpio=
X-MS-Exchange-CrossTenant-Network-Message-Id: a211de19-fb67-43d9-130e-08d8460d9038
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 20:05:34.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2A3czRRj6Jcc+cdJT2hRzqyl0AM36LkK/gb3WWIA0uuTBYGo9k3HG4Y2urm8fTW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3448
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_09:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210188
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:27:56AM -0700, Shakeel Butt wrote:
> On Fri, Aug 21, 2020 at 9:02 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, Aug 21, 2020 at 11:04:05AM -0400, Dan Schatzberg wrote:
> > > On Thu, Aug 20, 2020 at 10:06:44AM -0700, Shakeel Butt wrote:
> > > > On Thu, May 28, 2020 at 6:55 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> > > > >
> > > > > Much of the discussion about this has died down. There's been a
> > > > > concern raised that we could generalize infrastructure across loop,
> > > > > md, etc. This may be possible, in the future, but it isn't clear to me
> > > > > how this would look like. I'm inclined to fix the existing issue with
> > > > > loop devices now (this is a problem we hit at FB) and address
> > > > > consolidation with other cases if and when those need to be addressed.
> > > > >
> > > >
> > > > What's the status of this series?
> > >
> > > Thanks for reminding me about this. I haven't got any further
> > > feedback. I'll bug Jens to take a look and see if he has any concerns
> > > and if not send a rebased version.
> >
> > Just as a note, I stole a patch from this series called
> > "mm: support nesting memalloc_use_memcg()" to use for the bpf memory accounting.
> > I rewrote the commit log and rebased to the tot with some trivial changes.
> >
> > I just sent it upstream:
> > https://lore.kernel.org/bpf/20200821150134.2581465-1-guro@fb.com/T/#md7edb6b5b940cee1c4d15e3cef17aa8b07328c2e
> >
> > It looks like we need it for two independent sub-systems, so I wonder
> > if we want to route it first through the mm tree as a standalone patch?
> >
> 
> Another way is to push that patch to 5.9-rc2 linus tree, so both block
> and mm branches for 5.10 will have it. (Not sure if that's ok.)

Ok, it looks like the patch provides a generally useful API enhancement.
And we do have at least two potential use cases for it.
Let me send it as a standalone patch to linux-mm@.

Btw, Shakeel, what do you think of s/memalloc_use_memcg()/set_active_memcg() ?

And thank you for reviews!

Roman
