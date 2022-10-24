Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B781860BCFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 00:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiJXWC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 18:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiJXWCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:02:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0033FF6141;
        Mon, 24 Oct 2022 13:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666642619; x=1698178619;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ipCWYGxCfDe3mJz6/UzYioHkVluyq12JXw+n9xQarlk=;
  b=aKFx5BHY67xqUEnSaHkihp2cLDUqOpRMl96AL0e1ARdhcHYxlBwk/Cbs
   ybTYv/KI69c29i6kOw2NzuSBcGGSCE5hpRBStA8+Y4kgTZubaFYoqL1AF
   yvvSM8S2zX/0DWVzG3kKHYDcjpfD9l9OlCj9klziZ0dg86XTr9t0Lgf9c
   tTIPNPXz7Z3jkai6FVllckrGwZfFTM699rnXG2aH134qAtrqBgaMk+1a1
   DXXR7XgMlGK9Wigeb/MwFH1o7nSuH/0fYge/RWv78EJauvuvBfb0XGtJw
   Y0D8voM8QBn8UmPwdrQCIqD6rk3w2vlTf1uUuG+rELyOml+dy2SfvOgrU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="307503750"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="307503750"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 13:14:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="720604487"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="720604487"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Oct 2022 13:14:50 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 13:14:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 13:14:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 13:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAoFCj2JHNQbo7VzesqAgNoh6nwgX/Gp00RzC8ockCJSwXkc2hEQmOah+Cep4zoS4OzaEe1v+0H4kq+62Ls6YxnrpeJNMjGHYqBVB3vT8krd15GmlIqUNQUIxrzzhe+ADJkVFyqVTu3bt9aEG4xVM5zzoRIN3FjzcKahKEL/xBC0TqG7yOq+iDkphybXHXyfWGcORiqNwOj0QbSPiQCwR+oyQZco7CHLLKFrVb1o3Dfp8H2ZejR3MaSlQM4MiDOKMrSW2PTsitfdAw5QVma17pdEXPxZkrA0E3f0Tc3xKHsyypSDvr2EX80X4CXm4TnBnQ8z7Me3ao8I3BFP3joHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcvJim3LozgVlBzdalSpe8VY3wCk/3uLVuxWlvCUgwM=;
 b=NFkbvrP9SCPkSssdKyclnt0vvD/NghtKo/42Zhsn0gDkxlR5Lg4w7NqLg5vFnswa3lyGKS18qm1+M+nZI55s05Bunde47qbSlD0o5TXMLf0ij/IoOwXfCfEDI8kPkUjA22IOtXEK/Tbgcg0FhjxLF+Zrt/l/+5DeODJjWbYmPV7Jx/vByeoilTXH3Jj1Ef/lqLSRsx4HjUbzOddxMVBZt7bMVaS0aB0nxs30HhGpkWb7xpktd/zbPSB3reck/J4B9AG0XXAZnZV1ipR8DdgvXy18Ec7uIPln4RQYrOyk+MBd7vXRDc6R52ETV+snpfUIfcEesJm6bzUCc9D76Id9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4889.namprd11.prod.outlook.com
 (2603:10b6:806:110::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 24 Oct
 2022 20:14:46 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Mon, 24 Oct
 2022 20:14:46 +0000
Date:   Mon, 24 Oct 2022 13:14:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <6356f233d3665_4da32946a@dwillia2-xfh.jf.intel.com.notmuch>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster>
 <YjSTq4roN/LJ7Xsy@bfoster>
 <YjSbHp6B9a1G3tuQ@casper.infradead.org>
 <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
 <6350a5f07bae2_6be12944c@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com>
 <feb89e52675ed630e52dc8aacfa66feb6f19fd3a.camel@linux.intel.com>
 <CAHk-=wj7y5AJKGWExD3TmNj=kOhaJN2Or1p5VXC=P0-YPv97NQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7y5AJKGWExD3TmNj=kOhaJN2Or1p5VXC=P0-YPv97NQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::32) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA2PR11MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: 596762f1-f2d3-4b85-4261-08dab5fc654a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yrKpNONVO4rAVv5iDmfKUSkRLRMrQi1oA1DdztWPUIqhT0InvsCriMQbk8NPxCJ44+CLzUCakKkrEigU8fBkskmrFGa21sfsHV7uWz1SGNx2M24EP/O/h7qFWXuEN83SITeHifW7G99RRaGN7o+8V4FehBhcI2qd4aee8JEXAQYW0cb9V4fb/y/Iryw2Ha2M9zico8Vxfj7sT6NchhB8HFEXkygvZ6DcKHbuSrUC1fEhNwkTxYQ7/74Aw/zuYnQdGHCaEcoKHSgC25WE7spfFjodQG6DhXGYax3TU8pxDI/6C5MjQEsdTkhqQctqCGXCO+1WYBwo8iJt2dJnqF8zAYLQJkvgl411vPuejEizE+34Uvm+GapFquWIjuuy9pE6hIUPe2NVvPOs0rJubgVNZpKoEqvbRq5Yd41aVadx16zQL7tJOBJ/vVid3Nnbm33FxD4BsEfWuRwwNbZcNnP9oSMW3mIcTLrL+MJalbyJ9eUEAJ5MPyUS6E8V3Gxvvudlw/JB2Rqbjpmfgzl2gKe+Xfwu1WFY+KS0nBstUIiFFiZLEZtp9aUWbFUit0Db+OA31aROo5EWEes2WC5hZ97eiwtFLftdMtrC6Vh3+UXIYHKq7xkdCz8WVtRdYYprN1cCD1/sfIUt5dzotGb8kJlIUsXALQEN7Pkw9khM8xC82PJkIVNJ/vdmYEpoFRxYKMuto0WT6QzQoO2r9xNGtDxcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199015)(38100700002)(82960400001)(86362001)(110136005)(316002)(54906003)(478600001)(6486002)(8676002)(41300700001)(66946007)(8936002)(5660300002)(2906002)(66556008)(66476007)(4326008)(83380400001)(53546011)(9686003)(6512007)(6666004)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N8th1Ng8ZkxcamseaLQZW+EEQfg3bMKZ116Rh+QFTOjioxue8ft921kfp12O?=
 =?us-ascii?Q?KpuGK6XiF7zx48NaX9yGaytuhssrnx9odJmZFuayYTax4hfm9KcMdolTk3xz?=
 =?us-ascii?Q?9sGhAg1ck5GdQ4jOnKYa3rOXGDFr0LinDBiDSu+8LtWr5x+wCdcSVzbDS+0B?=
 =?us-ascii?Q?v+srTgipCi75HYst5FKoRlGfN2wGgmCZ+0xGtmrCfFnswwGneQgYxXpGgBay?=
 =?us-ascii?Q?4SxcYnaDQRxAX9o5MWunV6l++i6ygDegkVDwVsZHQWHEM/ILhSSKPGy9GbGb?=
 =?us-ascii?Q?SNCZYRoMSehlLLPKsf2Q5wSJXGpQdu06PPR64Vrej1Tvs0D8S7JS3r5cQ/vw?=
 =?us-ascii?Q?29HuqY+SUuQLDm1mWXKgI7a3xwKxbpTT2nEhCk7iWJuUVzBW3HHN0qOnoBcN?=
 =?us-ascii?Q?mrO/W5HTzMcrhE38MnIEDErW3z51S8Za9LxPkMyjnDcQBvTE2MnQ9NI6HJGW?=
 =?us-ascii?Q?1SmA1xrxiRtfxvkdjFr/7Lex7mmI7r81mPU0T9yqm7M1IAVZ0LZF5x1vb38e?=
 =?us-ascii?Q?tsyoO356Mgt4WWQk4JnPL9MCEpvZaCaxtLkKTUJCa+ToiIO4c42GUJs7j5Uj?=
 =?us-ascii?Q?J/SXcMZoneggER/IRbW0iz9nItnHOwQuq5JzGM2RQU3BJdZDkXPDkm371eZO?=
 =?us-ascii?Q?KFimIm262nXjDf5MZqjLt4MhcHmqPE4dw+kG1gX5iheiWMFZwEnxhB72+9qM?=
 =?us-ascii?Q?RICo6SY0WC0mReTmFsVSjndiy/Wfp6Uz7NIAyrcfYSNPZJsgY4n0N27q19wC?=
 =?us-ascii?Q?o5AGPfiHhr3yr2FFrgR1wpH5dv35nRW74rg4mryLJDNE89yBvePYDBPHx4e6?=
 =?us-ascii?Q?2Cjgrs/iK7KdSv3kTyCdIAcOcc9VmIGVSgNTIM85olm1LucIlOP4UZcNW3IH?=
 =?us-ascii?Q?EwEmFuhNtphBmjxoUfAK6ExyTCUOSvuWFZx3btPhIwaIp/CXJn31Z5XHztB2?=
 =?us-ascii?Q?hvWPLrp2iJkWcwtLLfUh+qD2bkqtk9lV6EHQdtuWWu+Is02x5qlAqi8MJ9VB?=
 =?us-ascii?Q?PqwZ78eUuF41wKH1vCwQNu4zzlTWyzgbKMkR2OlGuD7Knzye5dTWavI0vsVJ?=
 =?us-ascii?Q?eKb1uP7z5rSTOwBrzwdfGy1HSgbKrQthn3xZskEgf1I8smh7dI5NnH1vDf8s?=
 =?us-ascii?Q?ZPqEya2UgPCMzu5CTeIpeFoM+J+9OZb5KU430fCQU3EtJoNzDbVgtQd3MApj?=
 =?us-ascii?Q?HfrLi0yagKQNo8/nKm9EWeVzehDW0JLcDXVLxvgGhm42t/5X5bP4D5GtrHyb?=
 =?us-ascii?Q?pvaWq/2w2/6GZlDoJT15p8mw3ynGcYOMMWj1WNouxfK31SWw8WQg0cpiTZVJ?=
 =?us-ascii?Q?5qMitrpkpeNoyGHavkDyHVVhpuMcOZJE1SbQyEdKkDqZ8Tv/b8Kk1EBHAjtH?=
 =?us-ascii?Q?LSIQKMAk+uxG4W3y/JtdDXf/5FXZjh/1kSxQigQ9DWNxyajTaNlNtRoB7Lyu?=
 =?us-ascii?Q?Y8XCx2dD1ozthJUTOe+K0yXi6AzZwyPxC6iGFl1kgv9sAD4S+xtRvFO7/Tah?=
 =?us-ascii?Q?0aD1H+tSDwjDU8rXS685HlmPkxU+OCBWyK2VEI0yX6c3pKcQRkEYbMVxVDe+?=
 =?us-ascii?Q?bN13B5XJ3Ha85Pk8nMEdPQI5ZmskkGqTVw4avIFb1vOKIqgRYvhjXrN6nDK3?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 596762f1-f2d3-4b85-4261-08dab5fc654a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 20:14:46.3347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xi3EeqgOYWxShJNjpQhJ+dL/snkvX6X1CbnV1cLteq3JL5uQfjMYFNKGaYKJ9gUHKdAYO2zAb1VOYR/DHbN2Iu3U8b+QYnyxt4N0MbWlGWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4889
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, Oct 24, 2022 at 12:39 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >
> > I do think that the original locked page on migration problem was fixed
> > by commit 9a1ea439b16b. Unfortunately the customer did not respond to
> > us when we asked them to test their workload when that patch went
> > into the mainline.
> 
> Oh well.
> 
> > I don't have objection to Matthew's fix to remove the bookmark code,
> > now that it is causing problems with this scenario that I didn't
> > anticipate in my original code.
> 
> I'd really like to avoid *another* "we can't actually verify that this
> helps" change in this area, so I'm hoping that the reporter that Dan
> was talking to could test that patch.

Oh, sorry, I had typed up that reply and contacted Tim offline, but
forgot to send, now sent.

> Otherwise we're kind of going back-and-forth based on "this might fix
> things", which just feels really fragile and reminds me of the bad old
> days when we had the "one step forward, two steps back" dance with
> some of the suspend/resume issues.
> 
> I realize that this code needs some extreme loads (and likely pretty
> special hardware too) to actually become problematic, so testing is
> _always_ going to be a bit of a problem, but still...
