Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C65BEB5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiITQvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiITQvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:51:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448EB4DB05;
        Tue, 20 Sep 2022 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663692670; x=1695228670;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wMHIaret8HikmzSReCcE4OzhF03mx+L9y0zDduzVwlo=;
  b=cdF5TAZsaSe1OFECLUghPX6QrV3ofd/F2XpICjFZxX3IU7ti9LyFmdde
   /gwM+eAVvwJ1UHZW3MmColCK/SWu5gTUcoiEn4pvaVFDPuookNOMckieI
   poR4qeDrBR5ybMJYo+lsPZIrklP7MhKnLAlaNNEkfTJPwLC9REPE7b0+J
   7k3hT0Ezn19+dRA5gDYbvUQ3fQq0jpWR6XfA4ZLej3dAqQbI7OkBpCDo0
   9JzkNCyEWj2JUTDcGRkvO51RuHhd4I+uo4ZHCu0cDky0JYR5fqzi8nMfV
   uJwJi6k8uTAuPCnFzg2NuHIZi34nEjxfn0AYwpd0/gwIgSiTaIfiuFCMb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="297347365"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="297347365"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 09:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="708060420"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Sep 2022 09:51:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 09:51:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 09:51:01 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 09:51:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKDE+1CuOJvdFwGZF0vT3e2erLZhgvS+iF94Nl5wVaxD2UywzciYTh51aOvtkPBuV24sBUN2j8MuC65GLYkB+EqPi2ZfWO1jUB+5Dake4Gak2FF2BqRvUP5txEEsVeOGtxmglRgZbAg3GBCUmVeX1LNjK8xJ0/m/DfY8srgtHjN+PXmaVizHMNKXoFgvOfGkuBYadPuJlWP6LOdpoS8Ev6rADc8b/VNGoqyNoZJL3UgVm7wS0fvILbI/E+FpWaYmnIQGQmzoX7LVe5bDzH5Jsrn2Ihyu/X6W1711B0cKAZf1xyZw5K6762SXzH3Wv2nRjah6ivc6EO3/mP6Gyy9CIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H7MDcm+1Aop+9V0xegXYm1TS8uOLUniQu/nQPMRr20=;
 b=IkNNxklU3U2xmC4uR5QekJiW6gTdi2COR1hm42AkoSEC88xgMMLsEGDoN4FZJzC33EgjsGeykIAmuCYCR8Vjb8vlDx5IyxytVzT4o5G4GX37OlKQaRtfauZjY5NcgqRmRKzj4DDos8w4SE84vTIUvv5EyB4BZZ9F0/IjZd/u3zawgerZB7TBCmsZx/9Ep4dbAlHRBrSBAbe4u8tgau0u8sJHSPJ1fP5Wqd9tO20ys3o6dQWXqe0SKgL5UEbZo6syBfkz/Kqoo/t+dAobkaeIxdZ4lRBFoFBBTQmiWddp6cgxwJoyqDJh9XQ2tZDIHeo0OB7O/Rdww6tSu7KY/ZzxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7068.namprd11.prod.outlook.com
 (2603:10b6:806:29b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Tue, 20 Sep
 2022 16:51:00 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 16:50:59 +0000
Date:   Tue, 20 Sep 2022 09:50:50 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] Fix the DAX-gup mistake
Message-ID: <6329ef6a699be_2a6ded29468@dwillia2-xfh.jf.intel.com.notmuch>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <YynOXa8+jxxCjH5k@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YynOXa8+jxxCjH5k@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:332::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ebfdf8-64bc-4f79-b52c-08da9b284bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jk48fMXI6XcmdDmQiDQLgpGz96n+Ux9OfEO7ZDCloD4+kRY3hH23rmyyy95O0a5ptQPVYNSoXVSlond3e/svQ/SHv0BdmDu8seEoU5vIkgFvwhP5bPbAagtMIKHk/LW76Q8Z5aiyUJY2Vb0iesbhZt3dpf3V4/5MwO9+R5KmY9nwSiO0OQ58v6aOhGfWgHhSU3ABTmtVTU/4Vmf+3ajhq29MN92HNxhzxHnyabsAzUbWcCOoesW2kw1F0SjQNlhO7u2EAvVUl6+tKkiYxSyqrDH+85wh8z6wPkMKACyccGsT2J41gTD7L3GEFJ32ODd1kddBPgYLkNSPTpo0TOkpw4HMd1Aa9oT9OfYhHYVX3fw9hNV3OQDr9RhYkohg/J0WMAgXq7Ew9PsHVoCVOyzxM4KLWMi9du/HXqFTCEpJ3DD0PZOOPrmv/8uVr/bN+qvta3TH5LljLUCItvNCCoemzL5gHRIE3BLC6aELED2iRDozg9ZlLLjsbLrwjgna55ur2AjFLO+HtmswY1dSGgvHyxUnE+Pq/l+CfoECxlW8DIfdf0/FtKyKiU4Vx1vl5LdQKpesAK6kL6aiVua0ysrbAVNie3h6aHYfy4IAoVXuWe9kSpuinoeXvLNCZ05XIXzsXppEb37VvcUWaWaeS8qc2HZXKfDHYqsF6cnKSLlhVT0oQ75bzIVw75atOihKUl1/jUWklylTtpxXsyHidSh2XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(6506007)(66476007)(86362001)(38100700002)(82960400001)(478600001)(7416002)(5660300002)(2906002)(6486002)(66556008)(4326008)(66946007)(110136005)(8936002)(8676002)(54906003)(316002)(41300700001)(6666004)(186003)(9686003)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?17p4OkigeWkgIcVbb8S1KboCAm1t9pEsarkscslCaZnR2JqsWJaGlJ7Rmf1Y?=
 =?us-ascii?Q?kZq1BDvyMV3/sDKqgfvRIjeuFdJkNoVoOsB7Q3oHdI9VXlkZ6H7ZEyhHNLtq?=
 =?us-ascii?Q?veh2M1sq3W2V/HW45F1/aLXPAnaH63v/8eUOTjhPLINsBKfBA4I87WfFvkCg?=
 =?us-ascii?Q?OnsYE6XlwMrcXhM6lsB3eFdmhtDk4RjRp+15mLNfjeufgGzvrjlBNns++/hq?=
 =?us-ascii?Q?OyGel0PZqblAN+h9KNrSEvldx3BLp/2KsRWSnAYjmPc8n9xbVCgVhdjUdJjR?=
 =?us-ascii?Q?sAKJq445i9f0A7JA29w6Brl6Y3AxEJ8LVHkcU1QH3SUo+PiWVPA3sOf9lber?=
 =?us-ascii?Q?ksRrKdZG7sJKEFTF90Q05FC9r9uAZ/v9RehI7hvOreJdo/AD35Xyrj6M1C/P?=
 =?us-ascii?Q?QmTR6fehqedZEPb79bOOkB/INNDW6Jkox6SpwUrOgFnv1UGf3eElmsHv6sav?=
 =?us-ascii?Q?WQKUDm15tPJHupWFaeELCgb6lqi0TQUwp28t2DKCHmkV5ncoaVyQ2D3zU4Ta?=
 =?us-ascii?Q?4gD7JyN195K+vrah/i5cx7Y9mSL7ipGsxEJn+MHnCNuuhpEuENLS5G1LmvPR?=
 =?us-ascii?Q?GyPaA8qfBtxaDJFn2AcObB+5R3JUgGTAfhanvBuGYNmI3f7MP1ghIl1dnk1x?=
 =?us-ascii?Q?KsJSC5SuR8BIQeEorXM0fUK42LLBTQg6XA+UxHW2wEg1T4xLPvcvasjkwJ5L?=
 =?us-ascii?Q?yBQnSHnHmhA/nkesYsH3RSX8+HKl+ufdWwWrSYun9DpxfMRtlQyP2tZt/dW4?=
 =?us-ascii?Q?r1vnjitqqskaGVtR5ASU2AUCn9wgfVhLLIR0WmyAHxLy76qFk5wdzeAfS3rK?=
 =?us-ascii?Q?2BQbC0DDaDqF9witws2MjyLaYAzkb4e+cLnPD+Ppz5sPvym7CGaixKdiUgcM?=
 =?us-ascii?Q?4dvmRa4K8x21OTZkwI2DwwijkSolYhGhF1ZNpfSW/XO801DIEta6dRMvdhnD?=
 =?us-ascii?Q?f+rgOtDsj9nGgK45JVoV1WDNY7dERQMmufi9sNSWGAvYm6Gf1JiJiDj/JPju?=
 =?us-ascii?Q?y6MSgjxtBOHh//vcZqmm5lheD+ryk34j3tU/8aYV01RaXWDCSMkbFFDsVsJh?=
 =?us-ascii?Q?k7I0nYWiASnQq8Ipt4PRHW11pBKJsNzVmJbegRlnTELLTNwzf7o7hG1mUe96?=
 =?us-ascii?Q?fCoExwr2fWhpByueLaoMoi+Q3+cLZJ/ZZyTg4q85p52wuM8Hp4vn4Gw1IA2Z?=
 =?us-ascii?Q?hynG+ndmKFAgymrOn4o6ZD1F2qr2hDwhifdNkOQCydFIS4RxPks5Ri1YJTdy?=
 =?us-ascii?Q?oz2ioc0DScNz7VeZIDCBKVybeDYXdrrox3ITla/utHsXjO81cMs6SXMXkyui?=
 =?us-ascii?Q?nxXf1eqzk04FKPlZ0K+6HsFwDTrJ4j3hR2Xw54/s90LB+5FV5K9nVsufN3MO?=
 =?us-ascii?Q?gRBUvPpm3KRtDS3Is/2laTzGsbp/zQhz6n/6VOTMG6hwqbtykFqiOaZyjihZ?=
 =?us-ascii?Q?plq4Rs5Xyn4+PueydnZGJ8IPHw3sHVxc3N9n2xY5x4e5JcBTz/xHurb4TTMM?=
 =?us-ascii?Q?cV8Nv6v55kLncxXJOoBrvlbaYRDaS8qwKN0UdVvHLthFHGg+ZilLJi4ju0M9?=
 =?us-ascii?Q?NgxqA0ON8AltUhoS6VU+1JHR4accZXL62U+4TmgeytAgXDsrP0PaIUtX2OWQ?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ebfdf8-64bc-4f79-b52c-08da9b284bb0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 16:50:59.8777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30EjbCeUv1PBdfTOWVon9dqK0BC5OUQ7eGlCPgsWg9o7aDLdFp7ItoivckEu9yAKrHlpdwNTIKg1vWFSOnVsEWdqWdM/AjQz8rk5WSXTWas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7068
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Thu, Sep 15, 2022 at 08:35:08PM -0700, Dan Williams wrote:
> 
> > This hackery continues the status of DAX pages as special cases in the
> > VM. The thought being carrying the Xarray / mapping infrastructure
> > forward still allows for the continuation of the page-less DAX effort.
> > Otherwise, the work to convert DAX pages to behave like typical
> > vm_normal_page() needs more investigation to untangle transparent huge
> > page assumptions.
> 
> I see it differently, ZONE_DEVICE by definition is page-based. As long
> as DAX is using ZONE_DEVICE it should follow the normal struct page
> rules, including proper reference counting everywhere.
> 
> By not doing this DAX is causing all ZONE_DEVICE users to suffer
> because we haven't really special cased just DAX out of all the other
> users.
> 
> If there is some kind of non-struct page future, then it will not be
> ZONE_DEVICE and it will have its own mechanisms, somehow.
> 
> So, we should be systematically stripping away all the half-backed
> non-struct page stuff from ZONE_DEVICE as a matter of principle. DAX
> included, whatever DAX's future may hold.
> 
> The pte bit and the missing refcounting in the page table paths is the
> remaining big issue and I hope we fix it. The main problem is that
> FS-DAX must create compound pages for the 2M page size.

Yes, this is how I see it too. Without serious help from folks that want
to kill struct-page usage with DAX the next step will be dynamic
compound page metadata initialization whenever a PMD entry is installed.
