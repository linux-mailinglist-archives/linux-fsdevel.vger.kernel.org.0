Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0BA601A9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJQUv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJQUv0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:51:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35208DF88
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666039886; x=1697575886;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3TsTX8Jr3Ouur/JNS/nKXI6AsmTTmXydNxE5cf//l7k=;
  b=hVQN9aa4abrRLzJCpAEMMYK6ZHJSeFZO5luxZGF9Yr7dnSrHSWDpInV0
   D9sLbOgNonamiu3CZItDjlQ9hIxDigufiheMhRc9jQbghCT+UGgZtXf1S
   VvzEu77RMGR1k0YcU+Q7w1nXGZJrIvAp1pjYiIniICYvTAsxUTBVn3B3e
   IYGVSba2LiQV3V1xOIbQxR+SnwObEjD2wQrL74igiqJTGzxnSk+kGw7pM
   s28XC+bcyCixj71RERW6AI4P7m4c5uOtYhHrQ7WfPBYTwKYvzMlCgxJdh
   xKWyFAsaBiPkwTT4YkH1I+2vQTxqOBO8UawvELwoMvzChbMyF2FgEerzM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="392219524"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="392219524"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 13:51:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="691509573"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="691509573"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2022 13:51:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 13:51:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 17 Oct 2022 13:51:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 17 Oct 2022 13:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciRi54cv+u5y+Pxl/p237at38qc0GDrcfeJssGqSukUv7CKBZ1RdYCmXxv5Y0QeVNnLxQp2XuxqJFulxOaVHrmCNxwR3a84c8JLYuDJpbWgBWHdMayHxI77OfoIJjeqTX7QQvg7C3/9XLPJn+YQFx5Zl1LDdS448H179M0tJXz6rOGbzaUVuBuaZuwcIF2bIXK65JTblXo3i3s/YPMJjAxjFwHzPM5Bv65xDglH6QdFP773NnqvklMD+uXp34okvoZrqiCRxguOXeKM8KYMxACpsvElS3e7ZCGFNhP5+XQYBHAU0KRTGRyC9Tya7oxELJUXWv69Es0wzo+38UDISOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tI2RWD5uJRFV8Quy1Z7J3ChoVw8mYABpUkWJ214bbIc=;
 b=cLsK4AUWfze+48apxp/dtSEbIe4ZpA/fP90a0HmNZF6Jsk3mTjCEX8Y6qiXfK4HJimNUylFZ3p28wJiftpZfm/eDwGb7pnlO1jlJpIXDP+rull4koMv7w0KYVFe70Gvm/gdhr//qMZ2EqlxRN3WUlRDqbkLg9uXe0tTOy+ID35dMzmfCuanA08jppoBMVFxmQAEzrMl/86K7aZk5UmB2HV+NpKUaAO/8TA2fj2zGB+9h3scOsHgQkd5jgCWq5tl5f5O5C2TJlRcavdgUHsBe+hVF6yy7PMmfnBABq/srQg5q+FgdtMvCMwvXqB+CRvaP6kRNsFNAwHKeOdbmzuqchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW3PR11MB4668.namprd11.prod.outlook.com
 (2603:10b6:303:54::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 20:51:22 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.033; Mon, 17 Oct
 2022 20:51:21 +0000
Date:   Mon, 17 Oct 2022 13:51:18 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, <david@fromorbit.com>,
        <nvdimm@lists.linux.dev>, <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 10/25] fsdax: Introduce pgmap_request_folios()
Message-ID: <634dc046bada2_4da329484@dwillia2-xfh.jf.intel.com.notmuch>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579187573.2236710.10151157417629496558.stgit@dwillia2-xfh.jf.intel.com>
 <877d0z0wsl.fsf@nvidia.com>
 <634db5c1f602_4da3294c3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y0229P6z0E9Niw+9@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y0229P6z0E9Niw+9@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MW3PR11MB4668:EE_
X-MS-Office365-Filtering-Correlation-Id: ab66c8b6-9ab9-437b-e2b5-08dab08158cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qR6MgkYoAZAPxGSvNGgoqDNYf+IUwGccUDS35H8lKTd/p0Vsk22QMPx+2b2w8EiejIqlSKn4efFz2uTSF5CS6gKMAyHU5fTEE95DIG1dzjJzkPCIWHmQ/Pfoe7ZS2Et5YrLDRplLjF0k24okVaoe1XynG8HjnBUkmPoOykoJdm/xYxfGA3z7njvUv2Xv336cYPhVPoGg80dlA1GeGGsnhrI0LjvTQ3hUYr1a3uyxwA2JI+zShWAtKQ2c82CcMFWlwWjSYTG3ArsGG4vensk5p/AbhuTyrWjuZNCZS+HQzIYIM7zhMpXEF1ZhIARS59XX7su4gJl0SfauT0l7bWESuzmGJSonPKcgJDWssXv4ljc2S6rJS6uNA2gxnmJCtIqCaynCIp2VVrJvA8jovjjw1wjNR8ZQKj0gWgyX49RQJWTb2GmJDe8KyTCn4D+I4SZl2yL9O7nTJtkqtmrn9PSvzg5NuyyJFwYiz6SHyzATq9kxrt5JU8CyKfklbOqBXJEFK3FZj/F8lNGcWHIJ1xcG1DhvvnBm3smQSj7dmZuBi4FXRjSN3dQ8OFcE/jsjj++CKwn7Qa3FxPu5V7Qnc6fs/3E9vREbKCHh7jyt3ImCEmMFvqKu69y4qkCkOx4EgAT54RK1D+vLrDHqajWthwV1kfM7UdzRgbyUr1HLWZcKkIf2jRI+BcVRkPh+dnSA/rl1PiSieoAT9lSpDH138TR/cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(83380400001)(82960400001)(86362001)(38100700002)(6666004)(66946007)(66556008)(316002)(54906003)(110136005)(7416002)(5660300002)(186003)(8936002)(66476007)(6486002)(2906002)(6506007)(478600001)(6512007)(26005)(41300700001)(4326008)(8676002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2NFqIxE1ezX0uaZRv9g+NLyyPddWk7sRQOy5rWn7eQXViDlHZJIWCLyO7ks4?=
 =?us-ascii?Q?DFkkQUBZ3POa4HEtk+oC3Vorci7nF1swshf6pYzLleCbn4ubsrTo3tarVU5F?=
 =?us-ascii?Q?39BgQ15Yn14NB5qppL1B/bJXNjmYkBE8FbCCcvRirwg4I7y7W8R/Rrjir9zt?=
 =?us-ascii?Q?5WQsA4CWGpAFLQinn5eZjaA469tMtHZu8nDRVNgvL/J23XEmhElBygz81LZ2?=
 =?us-ascii?Q?SKxY8JPAhQ2ZgrX5ntjrIV9juLE+777jkoEa59o6VKXnEih28USrfpxMzjSL?=
 =?us-ascii?Q?5fVd1T1DrcR328StdXv1eJN/Al8dQVjI646WWMnBNCmfThVzytWTJ78jgFGZ?=
 =?us-ascii?Q?LyLTiETtTDy/SDqiPesb3WiPP6iAZ4ZaqYHeBWh4Ng5Nlu/3shot2XVT9Qjm?=
 =?us-ascii?Q?unI7p1at9pM/njO+TG8fLVbZXuD/iNIv8Ush4EmIIXvVJC1LZv15YLqHD1jB?=
 =?us-ascii?Q?6kmaZhML4FNqipnWDfNbn7Jv4ZDmZE95DdU07zvj6i/V0xzbXx3ENOLIef7J?=
 =?us-ascii?Q?ZzmdDcuuP/rOZrJpODuT8zyllWQKEW+RAtML0i85wmV5d4oaRoFmft/brxxw?=
 =?us-ascii?Q?+H1hK+qye566KaHN9NzcMFjlwuRXbeRNhHa/W3wilu0aOxk9NKD0U7Wt6/lF?=
 =?us-ascii?Q?Ew6ZzHL2165xFSWKDfq7vJHNMykWisyQjorX3S168xwYHYsfdkwvkOCJVh5w?=
 =?us-ascii?Q?V/Ls2SG0I1jFYCxrGuRHy538GwtpNRQRq71ImiZcGRvOskSf4A7fsi7bZMXN?=
 =?us-ascii?Q?dqR7aLP37DZzv9nX5+0oHDjNdY97A6Mtg0tGrpJAOYytWarTL+HXinss/lH7?=
 =?us-ascii?Q?5HbUX+E0zWTI0gCv36bG0sZem7LpVdNtB/wIqwgNcd5TmE5Zc5ksZlTKRJAK?=
 =?us-ascii?Q?CEa0QwAAYPf1q6gUSNL55oQrDEJTTu3sFli57WyldlZUwAdwLwVJlM8yBA+k?=
 =?us-ascii?Q?U9npSoMkshqP3uXuLLPPEUV19AXSz011GVy1u4MmTXwAtazyvj8IFMBh6aZV?=
 =?us-ascii?Q?xybHLU6BvNxT5U609p/vO756gJhg5L1QPJO5bX2ogVS34qLZglhcVSuSLVbB?=
 =?us-ascii?Q?n+G5Y2Z3zVnXWJCwG5FLULBuOv1iihmfv3qc1vjkpxK0Du/WfvOrv0SIsq6x?=
 =?us-ascii?Q?iltzHG+QyxphR2Pk+ln3U1PRQcWBycem0wtj5yO6d2E2ZYwLCCbexsMuTHJL?=
 =?us-ascii?Q?lVb9/DHunJNQhYbuUBAIhM4TmVrYrVLiPE/33gGEv0MxEk8HWDyMkBA85cXQ?=
 =?us-ascii?Q?jtJgjN5BUIy+LOc0XAhgKDc06lcIrHU0fonP+/6GQdmFEDKVp/M268tiBfJr?=
 =?us-ascii?Q?9Uuj2EOFd0/2Gu8Uk2o3sowHQFhH1ZwJAEOKVoPayM5jzgKEKU37gfVIJ0Oj?=
 =?us-ascii?Q?kNJMvv6JOYvA65f7V/4Oelgk3vwhlFTGxnVfZC+yNiEukTtZt6bSdmAen7oP?=
 =?us-ascii?Q?NbTPWZ1mzoxe3mXIpKuwB1xCgzsuCliAD2wsdu9woEDIuf7TZgEpUqp48Ta/?=
 =?us-ascii?Q?4F2aN1n/YoQbcPI1puI4/sGgbhST/Xt2BAcOzeLNGIbQ6k6j6AgqLVvurGjt?=
 =?us-ascii?Q?iXKT7kChS0zI+wVS71+J6mAydkKTabBu4cakkvXPfQy7Kk3SdYyTbdP2o2q6?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab66c8b6-9ab9-437b-e2b5-08dab08158cb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:51:21.4779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GYl6tjhwg1c7kQ0wCJTdSWm0klRcIO3zlpGFwbut26x3IKSQyo+rS8KtEEfTLAzoHME7whhY0DbCNUuzyRlNBJgWmMG5eDTQNGFtbLjQoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4668
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jason Gunthorpe wrote:
> On Mon, Oct 17, 2022 at 01:06:25PM -0700, Dan Williams wrote:
> > Alistair Popple wrote:
> > > 
> > > Dan Williams <dan.j.williams@intel.com> writes:
> > > 
> > > [...]
> > > 
> > > > +/**
> > > > + * pgmap_request_folios - activate an contiguous span of folios in @pgmap
> > > > + * @pgmap: host page map for the folio array
> > > > + * @folio: start of the folio list, all subsequent folios have same folio_size()
> > > > + *
> > > > + * Caller is responsible for @pgmap remaining live for the duration of
> > > > + * this call. Caller is also responsible for not racing requests for the
> > > > + * same folios.
> > > > + */
> > > > +bool pgmap_request_folios(struct dev_pagemap *pgmap, struct folio *folio,
> > > > +			  int nr_folios)
> > > 
> > > All callers of pgmap_request_folios() I could see call this with
> > > nr_folios == 1 and pgmap == folio_pgmap(folio). Could we remove the
> > > redundant arguments and simplify it to
> > > pgmap_request_folios(struct folio *folio)?
> > 
> > The rationale for the @pgmap argument being separate is to make clear
> > that the caller must assert that pgmap is alive before passing it to
> > pgmap_request_folios(), and that @pgmap is constant for the span of
> > folios requested.
> 
> The api is kind of weird to take in a folio - it should take in the
> offset in bytes from the start of the pgmap and "create" usable
> non-free folios.

Plumbing that is non-trivial. Recall that in the DAX case the filesystem
can be sitting on top of a stack of device-mapper-dax devices routing to
more than one pgmap, and the pgmap can be made up of discontiguous
ranges. The filesystem knows the offset into the dax-device and then
asks that device to translate that to a pfn. From pfn the optional (see
CONFIG_FS_DAX_LIMITED) pgmap can be retrieved. Once DAX knows what pfn
it wants, while holding a lock that prevents the pgmap from entering its
dying state, it can request to pin that pfn.

I arrived at the interface being folio based because the order of the
pin(s) also needs to be conveyed and the order should be consistent.

> A good design is that nothing has a struct folio * unless it can also
> prove it has a non-zero refcount on it, and that is simply impossible
> for any caller at this point.

I agree that's a good design, and I think it is a bug to make this
request on anything but a zero-refcount folio, but plumbing pgmap
offsets to replace pfn_to_page() would require dax_direct_access() to
shift from a pfn lookup to a pgmap + offset lookup.

CONFIG_FS_DAX_LIMITED is something that needs to be deleted, but for now
it supports DAX without a pgmap, where "limited" is just meant for XIP
(eXecute-In-Place), no GUP support. Once that goes then
dax_direct_access() could evolve into an interface that assumes a pgmap
is present. Until then I think pgmap_request_folios() at least puts out
the immediate fire of making people contend with oddly refcounted DAX
pages.
