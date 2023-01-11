Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACE6666082
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 17:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjAKQbG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 11:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjAKQaR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:30:17 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913431C417;
        Wed, 11 Jan 2023 08:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454596; x=1704990596;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S0qQm9H2FJvzQbUjGJ77JCYSJVK7Oxqi71qeHyUH5C4=;
  b=LXlydwhm+JQtjyGg02rm3kHp+pQ6d+TmAZE7VKF2jvxeIXdCjtCnw0R/
   D68+lVfDKyA/ORJnn03/jtKX1qBtzxx5EwX4Sha5A8s2HfssxqmPRYelw
   zhwUiUOgXO+4pRamS7HiHqRlKG39wsk/OsWqSQoSXEUmHLoEr0wTOYU4S
   guI+V/ZYpzHMcdQZKLMsRuWoreDdMQyEmwHAQ1MAm1TljSJo3cG/zJU7M
   +Av88++jSyL6YjtDkDEzvPVC59Wjc5UAt8f3nibqBc0U7wo/2G0rYUOav
   a66oEeJAN5PdhfTf4gtf6l0GttuQstopTI/ISZMBGdq3+FcnJPGeKOgx5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303157951"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303157951"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="831388696"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="831388696"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2023 08:29:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 08:29:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 08:29:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 08:29:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQmE76ymAPEXH6Dn/bSfBC/x0AiJa3dE9eh8OnOLN2ZeyAxKop1EnwxcCi3h5pkEl+BkSaShRBPHrtRsq8qaCxhmUXB7O6rFFNdqq5F/2ha41PNAh8jhWE8nPrI4ZR4zct5BhacuJubgxYIhmGxLUxYEaDiR/gd/xIfMqd+OJazsCb0KduTfj3BbQA7hLnCERBG9gLKEUhoOZc3/P6A1Cy1NQu/MH+HC7IsAVP/M4F7yBCOXiOwbY5aXU/Zi/nCTwbTLS7l8Hwd6dMoevutxcF1KE64O3ccOOI2TVS7b0cdcGLHvKpniRXAqwQDp/GB9upmZtej8NMzR7zaC71Pdfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuKLYbTT8nVmttsibkPdU4dYmk3DlGaucEgMsgs3Of8=;
 b=D5falYEh/nUzfF1dYnwOaMheIQcAwxmd3yGvgxd5MoFCIa/4OYoMfMeXatdjSzm2VufKbAlkU4ZrYAieEEaTzIY24Wx6GPTVl8K5XZElLchDqNX9zlzOGSqBZCnsi6UxQZmzlrz/etSOuHS78AVeVB9JMPBoCJxRAY11P/MhzyGGPa2V5od49M2pja7OpGKiDCsimxa0xMp2MMWr6JWCa5OyFy9e0FfW9Z9KaahYi7yBBXA8NYbU8AiYIQdL5WNMD/rpxXs5wDQpNoh3gOC//ePLx1z6ZZjXulAY26tAhWRODQph2ngv6E3vlW8oIi+4s9r/ECYJprOL1sAbe19GcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB7101.namprd11.prod.outlook.com (2603:10b6:303:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 16:29:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 16:29:25 +0000
Date:   Wed, 11 Jan 2023 08:29:20 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Jeff Moyer <jmoyer@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Benjamin LaHaise <bcrl@kvack.org>, <linux-aio@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Subject: Re: [PATCH v2] fs/aio: Replace kmap{,_atomic}() with
 kmap_local_page()
Message-ID: <Y77j4ItupAhjh76P@iweiny-desk3>
References: <20230109175629.9482-1-fmdefrancesco@gmail.com>
 <Y73+xKXDELSd14p1@ZenIV>
 <x498ri9ma5n.fsf@segfault.boston.devel.redhat.com>
 <Y77dkghufF6GVq1Y@ZenIV>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y77dkghufF6GVq1Y@ZenIV>
X-ClientProxiedBy: BY5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: afd7db0f-6d8a-4028-705e-08daf3f100e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5iow7MBZ8+76cB+7jLLX78WoilELM/4RFHVO2Sk0MFqP3uXDh9eo6lLn0SdSnQulqSIsCBLiPlI1lwLnTAiTv4RFTlvCqJmqzDSV2KjJnsL8pKMkF6RMksfmMtbSglKsOZ7mWxs0o+5LjkXVQCDIeoj+swrfA8OIWNvz7DMD7ByeXvZCSnuptq1FoCpAMfjK1C8YHarBKQVWQ3EvhPptHm+SNCyzpNpeYLuFvO7+znp0nVUmyJsQbcAd22AY2E6/cf0bRBz01VSxZIiBsbFvzHMDChKBKJVVnMuYEWViEzlaGDwP+j+b/ciAOlRhzv1ApoQAI6oSELjcaMjcF5oZjwHMtDwzFBYQH2sxXNHlAy4waALtpExbTi5VnKbP9xAgm0H2l7t6GhlOuZb3Asw4Zwmdvo7NyNyaslF1f0FwJ/776W1K+s5AOQZeS99nfmUkncAsgSUoGUddJWJwvKvBOwSNLCkRwxgLTlNJioNzCr5fHviC8RCVnlQjI2Ksy3dOsurh0AYKZU0y1y8QV6Ty6DBfDgguU7jxD5NSuAHe7bo7rKTBTo74y4iBltkjSujpKLkLv0sPKveaslNkAUzuRD6F0RJ7vi71GJpdnLMPUDg/MczRpr/y6ylu/qrd7Gv+aY0opb6TKp6UvYwPoORgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199015)(82960400001)(9686003)(478600001)(6486002)(41300700001)(38100700002)(6512007)(86362001)(316002)(54906003)(26005)(33716001)(66556008)(66476007)(66946007)(186003)(8676002)(6916009)(5660300002)(107886003)(6666004)(6506007)(2906002)(4326008)(44832011)(83380400001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wuq4zA/ipppKiEhLzs9bAxSs0w9O7EktWvgVzSKDzGjvm8cIAz4KK5pqZDnK?=
 =?us-ascii?Q?TFm28xfatGHik9VrPjPyjakEXYjlqDjfOLRGkxbrzJaJzK7nNkJYvDj2sKdV?=
 =?us-ascii?Q?GTwvb9Xtp41RMIKeD1Os8PpVReGjIKfaNSIjj3jYg4FvbJdaoFsbC4E4So/K?=
 =?us-ascii?Q?/e89IetoTRaZVNCSr6PaEhyrz1yFZFDowIJXy5JFXuPbPkfLqbmrKAJDmBYs?=
 =?us-ascii?Q?RBMfGG7gVt1aDgNPkfHsK8w+VXG6N3WYALU6CywPErUKIWS72GNV5JW/59Uz?=
 =?us-ascii?Q?hebhcJq3vYvY4euREHdT+B4IoLHaeEjemTo/CfBngsHgH0y6G+YTTss74t7y?=
 =?us-ascii?Q?fMWnn5Rku3StRfPGsp3yDrJTYM/Y+/FCKxndSrdRkOQUM9+3eZx2K6Hi9Idu?=
 =?us-ascii?Q?Krn+XZi8VXPE/x8rQvQhQ1PtaKV9BdmjBXGjNLJAV5VudTaaADPhkhtvoAuX?=
 =?us-ascii?Q?M30S+PGDIbySC3bm8srCmf9a8OoUXrXxHYDdhxRATdh5fBDm+aXZ7DvBTLTI?=
 =?us-ascii?Q?tcAgwRCZZZh9/idrBQjmuTQ+aHJ+Zf78qkty2R47O8u159QYQxGFy96xzCer?=
 =?us-ascii?Q?lyMKFe/NXMqi9EuQwE1jclhKYRUdp7l+PYcDxN2YrwYY2Rnwr6lWu6s5YGlZ?=
 =?us-ascii?Q?kI0mZcyeIcMqvUVw0REx1XmSsPd9Onspb3HDso0OhYgAp1EjFaap+4anxgfC?=
 =?us-ascii?Q?6ErHY8iV5N2Fo/jroJkum2LfDWhrPCM0UeANMnHsAijULeZ/wtXbbiJId86Q?=
 =?us-ascii?Q?0eKhBkPhW4brR7ezKgJfQBHZeYoin3caLYOoJgSVs2A28yDCm1IcaQOI310N?=
 =?us-ascii?Q?Kp/G/l/k9Fd+qrT+ASVy9Zyerix1ERY3xLalOsUoYLBqkmjcDAujN2yQmTn7?=
 =?us-ascii?Q?WTAZJ9t1YI1AwOWwJXEJ+kcJW9kLFnwRfTMmUuS4IKPdPTaw6TnMI95a4Oos?=
 =?us-ascii?Q?JhLTUfDjkxzDMatcGJ30gBqirVtYni3hWRUnj30FXm/IGS2CJMelxVFAaS+X?=
 =?us-ascii?Q?tPYVxAh6tHKH0ugBm+VM3MI1GkKNXYgcH8XNEVEZhxg1MG9RF0skNiEBSDSL?=
 =?us-ascii?Q?h5P/2nnDoku9IxEqnzjJsqPsHlQiTfl3Hliz2fQ9+NvcI3IKeMNkd6Zv9HLj?=
 =?us-ascii?Q?lK9Dt4+3vNpIicopIzXy66dnzILX8JobW8khmzu+4KqfEETNZaNMlLozScqh?=
 =?us-ascii?Q?XdMtfr8t7TaFP4uoLPdIdTbIMF/8S6cD231aUwOVMA6oqaOU5i/jMcqEnQCr?=
 =?us-ascii?Q?QDtj8c31bsp7BOFql+EpjQAfOKMSxWuCDHYmPPdZcVzoQDuYeziD8jiXgT6v?=
 =?us-ascii?Q?VBpOQg7XlJOmamDE+qiSnRC/W+1JFJLNIM7bzv6gsmuEYNalnzvpVpA3oHez?=
 =?us-ascii?Q?HbSgpviYquU+5HRE5mZHugqBfv+OxDHAY4ZF480VDUnVtJGJ2PbWkBAJhqYb?=
 =?us-ascii?Q?mI+pXU8mY7BSG3A1YKNXTN2bPuPD1iDH30o3dlGNt8SLzDQzru1jCG4WmWMO?=
 =?us-ascii?Q?52XKbOj8B6jo/QGPtfbSpPjme/GnkaGwcHCeczMVzbGxnNv+Eocq56r8jpQM?=
 =?us-ascii?Q?UAlZpcqJzOgCVNCs7dhQrxfGJf1C0/IjI+2tstRE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afd7db0f-6d8a-4028-705e-08daf3f100e2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 16:29:25.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zA7dATwrOEMctZ+lotdKT/JsbAT6cv7KE42eXZSGzFbOPscGGTgBBc5NXbFJ+J23A0oQauLEvK3nfMr4X/2/KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7101
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:02:26PM +0000, Al Viro wrote:
> On Wed, Jan 11, 2023 at 09:13:40AM -0500, Jeff Moyer wrote:
> > Hi, Al,
> > 
> > Al Viro <viro@zeniv.linux.org.uk> writes:
> > 
> > > On Mon, Jan 09, 2023 at 06:56:29PM +0100, Fabio M. De Francesco wrote:
> > >
> > >> -	ring = kmap_atomic(ctx->ring_pages[0]);
> > >> +	ring = kmap_local_page(ctx->ring_pages[0]);
> > >>  	ring->nr = nr_events;	/* user copy */
> > >>  	ring->id = ~0U;
> > >>  	ring->head = ring->tail = 0;
> > >> @@ -575,7 +575,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
> > >>  	ring->compat_features = AIO_RING_COMPAT_FEATURES;
> > >>  	ring->incompat_features = AIO_RING_INCOMPAT_FEATURES;
> > >>  	ring->header_length = sizeof(struct aio_ring);
> > >> -	kunmap_atomic(ring);
> > >> +	kunmap_local(ring);
> > >>  	flush_dcache_page(ctx->ring_pages[0]);
> > >
> > > I wonder if it would be more readable as memcpy_to_page(), actually...
> > 
> > I'm not sure I understand what you're suggesting.
> 
> 	memcpy_to_page(ctx->ring_pages[0], 0, &(struct aio_ring){
> 			.nr = nr_events, .id = ~0U, .magic = AIO_RING_MAGIC,
> 			.compat_features = AIO_RING_COMPAT_FEATURES,
> 			.in_compat_features = AIO_RING_INCOMPAT_FEATURES,
> 			.header_length = sizeof(struct aio_ring)},
> 			sizeof(struct aio_ring));
> 
> instead of the lines from kmap_atomic to flush_dcache_page...

For us mere mortals I think this may parse easier as:

	struct aio_ring r;

...
	r = (struct aio_ring) {
		.nr = nr_events,
		.id = ~0U,
		.magic = AIO_RING_MAGIC,
		.compat_features = AIO_RING_COMPAT_FEATURES,
		.incompat_features = AIO_RING_INCOMPAT_FEATURES,
		.header_length = sizeof(struct aio_ring),
	};

	memcpy_to_page(ctx->ring_pages[0], 0, &r, sizeof(r));
...

Is there any concern with the extra assignments to the stack only to copy into
the page?  I guess this is not a critical path?

Ira

> > 
> > >>  
> > >>  	return 0;
> > >> @@ -678,9 +678,9 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
> > >>  					 * we are protected from page migration
> > >>  					 * changes ring_pages by ->ring_lock.
> > >>  					 */
> > >> -					ring = kmap_atomic(ctx->ring_pages[0]);
> > >> +					ring = kmap_local_page(ctx->ring_pages[0]);
> > >>  					ring->id = ctx->id;
> > >> -					kunmap_atomic(ring);
> > >> +					kunmap_local(ring);
> > >
> > > Incidentally, does it need flush_dcache_page()?
> > 
> > Yes, good catch.
