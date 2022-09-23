Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18A05E7FC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 18:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiIWQaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 12:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIWQaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:30:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C944AD5E;
        Fri, 23 Sep 2022 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663950599; x=1695486599;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=evPPg4gNTcbhBmranJt88xKrfhR+56VB+I1SanGeBIc=;
  b=SX6+QZYq3K8EpjUPPqE0yY6BU1XZJBizgy4plYq2Qz378mYuDFur0AUz
   Cmg1jhYZfIJgDQ19ifPA+JFI1Fb4BbBbwqXtvi1ibAewD5Vp44U2yniJQ
   19NH2/KC06Q1k8okzeW8mo7+xkPsAbDA8fGfQSzAkOFKONG8XPDmRybMW
   tNIbnq3nE28jjD3eynd7ixcqrKTIOd7173D01512R/QZrCwJxlK+Z9B7E
   On6MuE+RpLbgTm4PFOI05dkfm/ipDsmoxStEiIX4IhSeJonhqWR3CWOAv
   1fVR5Ufr5GoUVsP0T5C5uIHIDsyRycRVDdI5GrZbGkFvE3CBigmQvxFy8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="300610898"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="300610898"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 09:29:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="571427840"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 23 Sep 2022 09:29:58 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 09:29:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 23 Sep 2022 09:29:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 23 Sep 2022 09:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AikExckdPCwaH/IRFYWNHQbrNsHY3ca5tzauAkcqIoGA11J/e8nh7CRNWYVLGPTWSMlOUD8pGBOuINnM2Sx8pLQbUBdLgfYvywkicW4MC8YSgsaAxp6bQz3g8sVJIhNAGaoSI/FA/UyCqOIxhAhzlDECzuP5hRJG1Z6TaWVfcUc62PXySPpK2OHynXKMYjo4UZzQ/dLRq4ZCz58d8VT5sRi8ugZTz50Sa5C1mXZHK1+gI8EiOqgE6sKqD7ERSN46439rN4m350t96lf0Oh04aV5Y+fNCk+Oi5pNLU1CWDYBvg/mkvytLIf3n/JYbHwZVXdw9jwlBBRZyxxllU/zdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/pStw/n0Ztp9YLr4pkeoMC1TxDN+qphQnGfCaRPsl4=;
 b=LYiUibCmK4JB1rboi/eAB2e68YaePym/4do6sQ8o1t+vsBRMlKwX91VVvcDne+2rek3Lwp+YJPmYTAJmIwt9p29q82dYrqd4VvYo/qGbJV19Q40L0bX5s8cdi0WO9O6Nh8qglzn+G6aKBgGxTYalHgdcMnBo/gn1P+7luUccvpsfm67ury/ZCAW50WfKbD4jKlbiiHsFDMHOszeeYyQSp53lzho3t2UfB0OcHXPfFB5VpFv2uzeilZ3oUy37H5lTVHxZx/Eu8VnHwi7UrSkIECFqdni2FwIzeOBgkCAOsD6OAPjSaTU6zKqgJNgvnX/oOAvJBs6NhofkAuSSPWrOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA1PR11MB6918.namprd11.prod.outlook.com
 (2603:10b6:806:2bf::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Fri, 23 Sep
 2022 16:29:55 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 16:29:54 +0000
Date:   Fri, 23 Sep 2022 09:29:51 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
        "Jan Kara" <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 10/18] fsdax: Manage pgmap references at entry
 insertion and deletion
Message-ID: <632ddeffd86ff_33d629490@dwillia2-xfh.jf.intel.com.notmuch>
References: <YysZrdF/BSQhjWZs@nvidia.com>
 <632b2b4edd803_66d1a2941a@dwillia2-xfh.jf.intel.com.notmuch>
 <632b8470d34a6_34962946d@dwillia2-xfh.jf.intel.com.notmuch>
 <YyuLLsindwo0prz4@nvidia.com>
 <632ba8eaa5aea_349629422@dwillia2-xfh.jf.intel.com.notmuch>
 <YyurdXnW7SyEndHV@nvidia.com>
 <632bc5c4363e9_349629486@dwillia2-xfh.jf.intel.com.notmuch>
 <YyyhrTxFJZlMGYY6@nvidia.com>
 <632cd9a2a023_3496294da@dwillia2-xfh.jf.intel.com.notmuch>
 <Yy2ziac3GdHrpxuh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yy2ziac3GdHrpxuh@nvidia.com>
X-ClientProxiedBy: BY3PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA1PR11MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: efb33aa0-0229-4bf0-bc89-08da9d80d89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fxE9V4ay7yk73clkRiOwDmy++TlhJacWBg1SFZlQQZ5WBm9wnxcFGumfZbF4LL59PW26fYLNRImyNG3lknup2hJHN0o1OfY87P5qPVbSbWulEsBCFnHF8oIoxI/wIiw4ymqma1WMLUG0+9JLk4WAzWaJ9u6MU2O9e1wAAhtCEkYDk3gpcdpnwdn7IJl7tW0ESuMBFKZ+QbzQXWWVDqVl3YCe+jK4um/3C3f0J+MbKfouBE7qmuA2bjKJPlniqRz3BS79LWU9gQ4ckPhsK+zNeBC7OCiiKtT1hJZypYKbcgR8kC3o7n2hUSN4/N3ZUJMK4NBy7boSQhC6TN7AFx0bcRIREEDiPcHNWL51ss97LbKWK4B3/nKt1rGP8IZSZxkNwbsMPKSiDNDCKp/nkY2b1ViWh7itTEe3JYK1EOUJII1bsiO8LaOw7YWs8nLHtRakXfN9GTfjnTddFjPAFDUYzk+i2TgG/EGqWHBjMVV2sGYQtOkI4gfLv1WI9pIfQjD1mwqla+TXjnhZgZf3wM++K/LyYL/GohpPj3jqaPa5u1LuAHstGCY92DXnkc8yYXpQusOjbRQLDCV7mEdtK2lsQq/uoYfTDAn/7gflUk+8mUfOplpqIaqqDSwxxP8RfDiaoCE7qvh7/Mmg4NEw1J4aIwYdGo5yTYYqkq9msjRY9+ZJDWxD83oA/Eu/G/yq9CB0mwWdVs79suEQez4WN3gMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199015)(110136005)(316002)(41300700001)(9686003)(26005)(6512007)(6506007)(54906003)(478600001)(8936002)(6666004)(82960400001)(2906002)(5660300002)(7416002)(66946007)(4326008)(186003)(6486002)(86362001)(8676002)(38100700002)(83380400001)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NLdrMbpZFa1vGifbgaQnNIS0dv6rH53N4c4tik8LOW3eDwLxWul9q2GfDnxD?=
 =?us-ascii?Q?d/+5q7vjynaHVdrVG/moz/TfE+0CZND+Lzz3qLpCiUkbQHK0vpXI/tE+yOWC?=
 =?us-ascii?Q?iv2mairKwgjMYeNb+ommhFOwMXinU7YY/8zBCnaL0LEDPRNCPrO3pMFNgVLI?=
 =?us-ascii?Q?cBW2y00OCiX7GkiiOYdZbDL7aLai3nVZgRCIC8YD06f2mJgI2UFwSFNr+IUv?=
 =?us-ascii?Q?qN16TlSja2srS7NoVZQArJLLyK7KJ7Uwm3PXHryoHEfm84cIC9WHS0YB2CBD?=
 =?us-ascii?Q?mXn3X50n/6lV8J3D2LoMvr0mG7S4jsTU/u2lQumCI85K6aNqWcTmrAcHyztW?=
 =?us-ascii?Q?LyLH/d2j+mRzrEE2se+tyQO5fv2yVM3E+TzSqZHDh3lZ/K6gw/mG5G1nuIkE?=
 =?us-ascii?Q?o3dnQL345GqwSee3ijRIaEH8nmcfCAvsq5smvioh31+SKDc9ygGzKwSLbDta?=
 =?us-ascii?Q?GirJH4TX39oGNsJPw1AHAG7AWFDUVebDyI3gYUNMSqDxtGM2xwgzIC5li+GK?=
 =?us-ascii?Q?7wJdCgZfMwRJPe5IWnPkiAxf0X5wnEm/dw4icQH+tyiCOKFvRMO+fM131wi6?=
 =?us-ascii?Q?ZXBiw8T389ekoquTFseJZrIes4Qza96I6e99457IdF8p8eFXu3zK4cIwfs9k?=
 =?us-ascii?Q?lyiKAm4PBQP/I2P68Nlic9UlVyQN82Uh55veCazfHMiL+btZTQAMWzMmyAIc?=
 =?us-ascii?Q?8XhKKds5SMaOmHLpZUSkK5F5aNi8iY/Aa3APo7vLl7VyURBABvQUU8JMeFDp?=
 =?us-ascii?Q?1smP970Lpu2XfKLC0kzRurp5ux+WqvtQSHL+H4e5Gy3tXQvH4WmeEHKbHTG0?=
 =?us-ascii?Q?4AyiYx1jJman5q4dEAxvb++N/XLSo5weuymlAYTCAz1p3J5bq3grfhZlqLpl?=
 =?us-ascii?Q?ZP1JqwEjRXjwv6ud+peZNl6Op4QoBEeAwvNkUtAAuOMYL1LlTp3TBxLaAk0J?=
 =?us-ascii?Q?EagfEhLd+KL08DmqjRsCfpyLs97k1rPs255PHPHgynIbyKYKP1Ru0GUHyHIi?=
 =?us-ascii?Q?4xuiM4bq8sKbR0Za4t9E7M10iqWyk8KiAdyFoSuk4uSZ0wYSLaTB20QGuBdc?=
 =?us-ascii?Q?oz/2wdQ5gvgtw8DDWwGkQhcHRSemVGFSA3FsvkEKh3PKR9/foWfRiQI4BPku?=
 =?us-ascii?Q?qs8dckYVZrYU6kpnxjkSw9yE4tMHI/vK/E9pv22wSoZRUNaYwneuIvNSB/4Y?=
 =?us-ascii?Q?SeMssP/Anno3u22JZrVQMGg4ezeaH2pxFuec3GuZFRGFElQkw+1uYMi+T7Go?=
 =?us-ascii?Q?OfjKIMHYhcoRWIGWq8jJ7p4r4V+t/dMd/rFz7fkUA3UtgLUns5POpP7DUxuo?=
 =?us-ascii?Q?7PP+kT6tbVnbaep7Q/wrIuA/LKDFal9hoo1Mi9ypfn5imkuNM9yEtIKOL89y?=
 =?us-ascii?Q?aCQCdmHhFlqMd4+IcPwpjbmk4gXx8QUAn1HKuoagL+Esf2ktJxymNJ4iTwKx?=
 =?us-ascii?Q?2P+m0bwaQFMC3FzvItOfLIsetCDEEVYx5JpM2O8k1IJ9yaHYJfpDIp686u2y?=
 =?us-ascii?Q?m90N58MGcl9ssLgTzClDGkBvgVSqPTu0VyB4liPUvvcnd5V3TqWOKNtQ7xpU?=
 =?us-ascii?Q?gdTp2P4MmZ7MzeK5zC36voAmRozBL8SIN9wheBprgYtZsbcAj++ClimJ66Em?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efb33aa0-0229-4bf0-bc89-08da9d80d89d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 16:29:54.3812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOSSoLg1OHcDLgLN+HCiV1ENgCFrn9GraHnKQYnl+P/iKXYJ/5FaFvZ3O16DC1bTw3Obkr2/U1T8lcWk5mlPdALc13JDsCD7l85RTq9uiLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6918
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
> On Thu, Sep 22, 2022 at 02:54:42PM -0700, Dan Williams wrote:
> 
> > > I'm thinking broadly about how to make pgmap usable to all the other
> > > drivers in a safe and robust way that makes some kind of logical sense.
> > 
> > I think the API should be pgmap_folio_get() because, at least for DAX,
> > the memory is already allocated. 
> 
> I would pick a name that has some logical connection to
> ops->page_free()
> 
> This function is starting a pairing where once it completes page_free
> will eventually be called.

Following Dave's note that this is an 'arbitration' mechanism I think
request/release is more appropriate than alloc/free for what this is doing.

> 
> > /**
> >  * pgmap_get_folio() - reference a folio in a live @pgmap by @pfn
> >  * @pgmap: live pgmap instance, caller ensures this does not race @pgmap death
> >  * @pfn: page frame number covered by @pgmap
> >  */
> > struct folio *pgmap_get_folio(struct dev_pagemap *pgmap, unsigned long pfn)
> > {
> >         struct page *page;
> >         
> >         VM_WARN_ONCE(pgmap != xa_load(&pgmap_array, PHYS_PFN(phys)));
> >
> >         if (WARN_ONCE(percpu_ref_is_dying(&pgmap->ref)))
> >                 return NULL;
> 
> This shouldn't be a WARN?

It's a bug if someone calls this after killing the pgmap. I.e.  the
expectation is that the caller is synchronzing this. The only reason
this isn't a VM_WARN_ONCE is because the sanity check is cheap, but I do
not expect it to fire on anything but a development kernel.

> 
> >         page = pfn_to_page(pfn);
> >         return page_folio(page);
> > }
> 
> Yeah, makes sense to me, but I would do a len as well to amortize the
> cost of all these checks..
> 
> > This does not create compound folios, that needs to be coordinated with
> > the caller and likely needs an explicit
> 
> Does it? What situations do you think the caller needs to coordinate
> the folio size? Caller should call the function for each logical unit
> of storage it wants to allocate from the pgmap..

The problem for fsdax is that it needs to gather all the PTEs, hold a
lock to synchronize against events that would shatter a huge page, and
then build up the compound folio metadata before inserting the PMD. So I
think that flow is request all pfns, lock, fixup refcounts, build up
compound folio, insert huge i_pages entry, unlock and install the pmd.
