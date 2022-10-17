Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C752601884
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJQUGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJQUGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:06:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440675384
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666037195; x=1697573195;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TtAXdpbBTOWgat1oyv0A3kuUqwASS0BDCT/gA65xddc=;
  b=Y1Y2Jzf6t2TTxE9G/D4a+9kkxcV3+jotrhFX1t+UX3wsMM4/T2SVohmc
   vuafv18tKoSMVUyGXXXw8L0V62m9XUBWjTg/PiywWCY5TRY7IYZWUr3hj
   T/2Hp4JmtrSRyQIsYjM2UsH4gjPAxZwEMiA+kOKQN8dZ8aCIMkl/sTRjT
   /XwI4up0lCYaPBn7nls9VLyeCIAIqAnwi0mU+TAhdJWcEtAmMi10/o7RO
   md8mi490UZNGjhifmqjKRJ3W0sm3gOiMZNyvL3MwVmHI2hHC50E3vPd+o
   O3BIv0/nsiQCXgUmlwyw233Xx/EcclCQCnfXZODV+Q08k72Xxn82EhVjB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="289204272"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="289204272"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 13:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="623347248"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="623347248"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2022 13:06:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 13:06:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 13:06:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 17 Oct 2022 13:06:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 17 Oct 2022 13:06:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdwyUaluqDQT4rZaGWdwVy/sESGJLUi4x+nLmDKbS+CfGKt2CDuYyCPGTmC0aSh34k6eAHsdLyX1oDiTe+F8ACfPIz+k03BXArVpklpcIZ/JBV8/Ynbb/wLRONol7ASRzkvQngYQ0oz43/l70Dctuba+LkxlCrDL4u6Oih3symatb6STRnLaXl9vg2rrEtxg9y7oBm5542LOfFxeMDwTa30Wv9sLFMBC/woW8Ruc40/vnhzwI+PgdM8d0ZdencCJ58s1pCPY+otbAIwBglYeAjFKqU32BNYzTRF4a2fAWTwC5TXVhVMOGS81i80mpX6ho1wWs+22+Vz1h37kQ8e21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCYi5RrV12dwahzA41sknKAty1ztuDfN2cbgLfhZUQs=;
 b=GBqQn2MOvtNaJKolfIaOI7COrHeuKwy09JMnjgXUJoDrkM88zeckVLVaVwCRVwlKH2yFZxiteTZ1dBwuptjPrx3n6BnrY/oYyAT3/pQAWkO9jRbWEIdFB5TTVn2rLCugzFWPYzJFXk51/MwDTb+C/PxWy12Dp0S+2kM1wYrMym+l7VPzmOJQrRhEVFWd/zH1/VAHatMPZH/YG+Ih3q+Z0z+1YaLk1yzfv+XMRGJJrLTUtFFo2U7ykutjWs4kA/Uy+BNvA3D3S08cMQ/7LOMFXKRaUGxleZXI2GNkwynyCpbGhep04OOQ1DRA9pYvh39hLaqPc6TkB/XiK5ccVZdVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CO1PR11MB5090.namprd11.prod.outlook.com
 (2603:10b6:303:96::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 17 Oct
 2022 20:06:28 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.033; Mon, 17 Oct
 2022 20:06:27 +0000
Date:   Mon, 17 Oct 2022 13:06:25 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, <david@fromorbit.com>,
        <nvdimm@lists.linux.dev>, <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 10/25] fsdax: Introduce pgmap_request_folios()
Message-ID: <634db5c1f602_4da3294c3@dwillia2-xfh.jf.intel.com.notmuch>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579187573.2236710.10151157417629496558.stgit@dwillia2-xfh.jf.intel.com>
 <877d0z0wsl.fsf@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <877d0z0wsl.fsf@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CO1PR11MB5090:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c21468-f7a3-49f4-8131-08dab07b1325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJnjfUqwX+1A7fr+L6zHIVz+AhLSmmsOmJbm0hURv5vYehsRW8NFLwzH3yskyQ83OxUcmAXPYxIVIo1lI6aZAtbchhL5vcRoQI6Mtr+McgpoEVV0oVruAd34A49aQyoHiklf5UQVZn6JTVf3mzHa6I++To/UcveryOZQ6z6lYvqWeWys5+Grc/70mGiiq6To98xPJ0BE78tEULWve7ZHK53zsVMaeWsAYXM04BY3V/W+68IV2n4+A1I6oMCQd5jnsCAWmJrLbuanuKQ4JyZ56xZYDiwDQpRgzcf0DdO7hjOdkTYvLHynOLHPMLhVWnBXdhfJHwIxxdgDmqlaeL2D7MYaN0kZJmVoAAOzVn9S7GioDdLLYJXNAZaWhxRZ0PMbOm+coLEjXLcr8rI+rSG1b2LHywkkF6z64paRgfc5PIWDdT0K38apqCTaQ9/iTOEpVN4IflDCXcnvaPyGSZaXCmGxTrF6+GitjfNkjcl/CquCT4UPH4QfbA7YTjzubp9oaeSb/iq8ynG68GnyM6qQFgH1C9esHLxoVJo33TSoihqSDpMFjNwcSKZ2mpUiAzAjTPyOOiPYweTsX609RhaCngWHuLLnavQ7kDqkJzk4WVoJJVV1nclOpi1g8r0taXEKv4miOWWlp7+dQMmzoik/bL8mHIC7HD3bK4zQqN1L2p4cnDDFDqzXFI3uS1ys4J9MJkKgXRfHa4WYFVrAKWBc/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(7416002)(5660300002)(2906002)(8936002)(41300700001)(66946007)(110136005)(478600001)(6506007)(6486002)(316002)(66476007)(66556008)(8676002)(4326008)(54906003)(82960400001)(83380400001)(86362001)(38100700002)(6512007)(186003)(26005)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?echt1lfxgQe7U101jXRdLHmBpt85Cl8iRan9ZQ6IAhw6x+X2ggr5jJwG8mLA?=
 =?us-ascii?Q?ULb3wzFo7KDXQ/G0XrpFJ8TDeZSvQRUPpNEIcL8Hfgdt6D0YyiNIXaIf4Z7R?=
 =?us-ascii?Q?dKFCosegUaaCjRcIuAOvYUhT/Ki1lSdtEsDJ4MhZGzsh9Ag/M+fcr/Oy/27o?=
 =?us-ascii?Q?nVe+jAq9QCfsL4/6QYHreHSU1NvXLDw9eDLg67gRjLAw9PwVoFZKhVTfvYfJ?=
 =?us-ascii?Q?YnwDXNUDS603ULoqddGhCD9yTU2haWhStk+vcSJ9IgFNg3kLaxuCAH9l6hIt?=
 =?us-ascii?Q?oD1Z2PXHCbXX1QvwSOkTaLMfxbxyaSyyqzZmf8OJROvdOYupJA7kqbh3bRwx?=
 =?us-ascii?Q?EpeL0D0vjE11zrPOUW/Yr7e5Uku6He+dhJxO53lxwNc8tLY1FMu7xkIZNk+4?=
 =?us-ascii?Q?iOQI3BVCLyNHCx0yyXSEY3dZAFPWmZzfdlQOz8Z409lIHXGQMgJYJFZqBiTo?=
 =?us-ascii?Q?FbHBSCGpERnsuMjENgumFKDlfdHldWzRbc93nu6nlRBhx43OqHELd2nSpSoh?=
 =?us-ascii?Q?OiWpBMC4wYZd3xW1lPXDrDl5EjrJdf+rL6EEhF00cDtRSZVn9fvjBY/RwN9O?=
 =?us-ascii?Q?WF5bI5zALPidxRqN27MNADHX05+F3rhxoFmGjjD1S4JgPl1wTBJASC7f9EkX?=
 =?us-ascii?Q?IuB2YYL7TjKqq+ZcSiDK6IqoRvjqc0WBZXchB1uuUKjaRoC1Tn3YZUnuxU5R?=
 =?us-ascii?Q?KlCjhL2/lMi5+KCGbM4l0gxmQS/n9KMKypAZ6CXesI7vuFmoz7YeFAgaLWg7?=
 =?us-ascii?Q?Ra0dKtdadPrbfM8yyCOpOe+zkgH6Xr5bRYsudA5dy3L7llYZzgc78R6k2Z2y?=
 =?us-ascii?Q?RJJE05Hhd7MTaNNBqrYUrfTdLxKRXp+TDf20UQFBWztqi5HSqBo/mg5Cknfc?=
 =?us-ascii?Q?2BKXYaSMzQObitWcDcggR9xVVY+1O1juhpLfotY21fQ1kRI+ZokkUPPSuTlU?=
 =?us-ascii?Q?77Mofgb63uJm7lQlHNrNlJ/tcg2E+f2n1DJycckMmoZffaV7ISAkUavoUmkD?=
 =?us-ascii?Q?JDlRZ3WOXnZqsCU1dNePYmBv6JgMGk2QLbsWaCrZFyBeqvf1bXO4spRGEn8t?=
 =?us-ascii?Q?0qRnQRh1n2HFzmpF40492kwLVJsm0miIi30stbxxj4ToNQ4aMfitvk4l0sHn?=
 =?us-ascii?Q?flKXeIhjJPCUlZaARwx79NpbOePjdTHbooVW9V0/b36tz9xgtbOBeDKLB4y9?=
 =?us-ascii?Q?mm9IskVXbnPeOZm24Od4cra29VU5PBjd7BY/+EIswax63gt2GzRuKUJVdeZL?=
 =?us-ascii?Q?lGS8IzZsm5d03EeEoIKSVgfD0A0OS4fabN3RHyii+pb5oYq2xRRyg+XyA+v2?=
 =?us-ascii?Q?XshEwOIaze7LGEWZ0UnZ4fYMkadRkr9J7WRsB9umPymu4+s+okQng/Zl9oAa?=
 =?us-ascii?Q?VDUdad5L7kC5qPVltJyYH7ddZcGnC7UYR4JMbVCnD1DN5YcdH7oSQHcxSszv?=
 =?us-ascii?Q?QcXhx7rZzrcoK4QWsYQPEmeH6nm+tq+URsE2gkiUNS72eDInCzzqXrzbrp6w?=
 =?us-ascii?Q?ta1SEvUPv5/j5rOvK/e1PrzgLBfbYNt5iKsM/hzjJ+hm1iITrFzERPMauWyO?=
 =?us-ascii?Q?5ODt+b/M7o5+u7b+bsdFM2OPmoUK4EEMvyaYnYHl3cwUwBIYi6vF2/xbbVN/?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c21468-f7a3-49f4-8131-08dab07b1325
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:06:27.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4VmauE2qacSG862lYujulR04LsXcdM4ONQiNyECxn87udDuHmHOlAAG5RNW5Tlk6b4PnZ7K5YU8VMUkMXSGiXlLAItujHG3biyC6T3G7MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alistair Popple wrote:
> 
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> [...]
> 
> > +/**
> > + * pgmap_request_folios - activate an contiguous span of folios in @pgmap
> > + * @pgmap: host page map for the folio array
> > + * @folio: start of the folio list, all subsequent folios have same folio_size()
> > + *
> > + * Caller is responsible for @pgmap remaining live for the duration of
> > + * this call. Caller is also responsible for not racing requests for the
> > + * same folios.
> > + */
> > +bool pgmap_request_folios(struct dev_pagemap *pgmap, struct folio *folio,
> > +			  int nr_folios)
> 
> All callers of pgmap_request_folios() I could see call this with
> nr_folios == 1 and pgmap == folio_pgmap(folio). Could we remove the
> redundant arguments and simplify it to
> pgmap_request_folios(struct folio *folio)?

The rationale for the @pgmap argument being separate is to make clear
that the caller must assert that pgmap is alive before passing it to
pgmap_request_folios(), and that @pgmap is constant for the span of
folios requested.

However, I see your point that these arguments are redundant so I would
not be opposed to a helper like:

pgmap_request_folio(struct folio *folio)

...that documents that it pulls the pgmap from the folio and because of
that does not support requesting more than one folio.
