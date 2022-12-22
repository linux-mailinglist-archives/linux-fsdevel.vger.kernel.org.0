Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6BA6548C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 23:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiLVW6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 17:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbiLVW6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:58:41 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42CF27CF8;
        Thu, 22 Dec 2022 14:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671749917; x=1703285917;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Y1PeQm6PdgN8EYBMnifDl2yOOqgrqEYFXOSzSNihW2Q=;
  b=Xeq/ZPIU2vBO56G9Sg9DSUtOG8E/m9iRwT0d4LeeTx/7zZ5NXq8xfsLA
   jNA0Y9pEJpl3M4nE5nKVxVZTb7qbyd+s+NSXgdEMxYonaI0bSVMjGaKSG
   uLdngxZSJyPLsP49th9zMY32wMX7dKogF3379pktd0JxZwrYUNEvznZPP
   /a0WVgBIoyikND2d55pWCnwEYVnWlMeM6nlbNpWS73lvZEeeol9ClpLjJ
   Z1NOgKGf0likfEwEV7aHxLcse9CHSEobteWRzOmIM2jbW9WneC6LTh9mK
   gY/bVh/IjQVWitbujnk61qSfhMqT6aiEObMZNUh7W7Z0pnxkaGu/m4cwb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="300570761"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="300570761"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 14:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="980759738"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="980759738"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 22 Dec 2022 14:58:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 22 Dec 2022 14:58:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 22 Dec 2022 14:58:36 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 22 Dec 2022 14:58:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oL/aJxpQeV9XGfyKJc3+0fEDQt2avekmAdN5IGZ9hH3yt+Uj+lMId/BjWR32858i1/Ww7v6btJG37M3qHpFupJGh6axccTRiNMXwaRLoecqUYAfZ0cgQ3cllQfMZq/LdO5KuCxko2fOfI4sdyCMNinMpZ/V/mFmoZN4Mbl6hu57/W9fz/pLJpBEYmyt/s9pMk7Y/MSyC3hMyaAfEY2YxQGxbgk6LaTD+KmUHqLrtK2loAzYNPhDrGeOcfy0NuAxpVnTe+W8wRoDxSQBrTlghiv14bgd7FbT6YY52QFc/FvqeiEip9NXM4WqNal/JCmew/3qp4rFiu7NM1YVDYcppeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw5WTn0yJoDxoOyZjINg+JsWKtbOD7UocidIuXY7QXk=;
 b=IisksceNj3nYwikgVRDjaUxqt1t+maIKYFgPpJuGsP5R0cKjneaE98GBT9bHyAmmDgqA7VrQE1NQU2wEr3IwySfYgYDShyuIcCkbXhzzK18dvr9cxIiawGjSQrsH0kFWpadb60m9vDinIWkgThaWmlAX3v+gKmhNj+KzlfhX5ycej1eCE0UVKaAM2CzVBZeOMTMY9D1nmOylCwcmHDCVHKk3p3+/sLdgmE/VGqn6202e6iJVCMiPk+6PlBFSYGG6J5VgKTgk4yMo4K7Uu0ERR43FDMxoNI1aFTEmxg4g5OgZIbjIO1I02qCdQ+ccQ4W2nKx5wm8QO7/VnvwgEQQDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Thu, 22 Dec
 2022 22:58:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 22:58:34 +0000
Date:   Thu, 22 Dec 2022 14:58:29 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <Y6ThFQ74/OLsCqTs@iweiny-desk3>
References: <20221221172802.18743-1-fmdefrancesco@gmail.com>
 <20221221172802.18743-4-fmdefrancesco@gmail.com>
 <Y6Pt7QXbXjaFpNjx@iweiny-desk3>
 <1884934.6tgchFWduM@suse>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1884934.6tgchFWduM@suse>
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d756ad0-5bef-4be4-4e27-08dae4700d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2wCuY3tAQzkEc26ROYicgwaLvXmokiZFilkyqMC67GP5wNB6eaOitUspb304Dc4h/Ez/A8pFQS0cYsJt7eOmaaogIo7sb1gA6mJOtKfpwIzZBv1YYKE2hu2HxMqkHus5nNyRaEeCIgrWlRX7jQV7pb5SqnYfen6eAOAskgcKZ39e4vF2Bm/+4vxNLgWvbwf0v6eJr4vEZAbgEE0MwsNd4Da/QnxI18AWs05bXKN4OMfzDC4yk9796cb5W4e7SL+7ku4eh9KMPpD+0/xrvbIBbDBVXu9/CzCeOPnxHKNUMUmoEqYJsYzOXK7S9lDYiE/n2ywA1pKzcrnuSlymBLaovU/X8s4TK1JFKX86AZmF+kun8ER6kzUuGs3IfDHbR4Q5gDptkG4cL+UbRHaNE9QU477OHOFvaShyKLDGJWj/0Fdqcq8OCg5RsZPyG/3TJPGDzMWNyGgqH/QWqH/DCOhSPhmMkNr5j4EGkrw8JUCO983WQfeEELwYuaDNjfKOUJZm62MgnAVSHJkuC/oXLErp556vkltmR/hH6X1NAFU83wBqfdy5bBt2jGjhSkqOh5CjVPAkL2XAKC3fx6ZOyJahL9E7/9Okh071JjKe5bpia4hpNtoNwc3HywhU++jYaG3jgm0U2YY0zbxNAQfG8NWVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199015)(6486002)(478600001)(8936002)(30864003)(44832011)(5660300002)(33716001)(82960400001)(38100700002)(2906002)(83380400001)(6916009)(54906003)(316002)(41300700001)(86362001)(66476007)(8676002)(66946007)(66556008)(4326008)(9686003)(6512007)(26005)(6506007)(186003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzJuZk03Yks1ZzNKUkFyd1Y5S3lWWXVmajE4Vjg1V1paNTR3aGZlNXRiWXZT?=
 =?utf-8?B?OWxXMWltQ1liSTREakMxTTl2V09Ob0UrTC9odFg4dWs4eVNRMEd6dExpMHJO?=
 =?utf-8?B?RUsrbVo1R1daK3MxODZPekJMd1Y2YmJMQzE1SWVvRHRQT04rYThjR3oyWVRr?=
 =?utf-8?B?MEpRd2h3b3JkVVJkRC9qUTVUVnlNWm5ScDd0Y2VRK3I4TmtaZXR1cGk0cmNN?=
 =?utf-8?B?blpSSkFxUkF6UlZBb1M2SGk5QU5RcW1BdmFJb0FFRHJETkp3TGNlYmFVdld4?=
 =?utf-8?B?VHJYSkNVUXZTdEh3c29sOTExUnZkK3RrOFZxbHhneUhYVzNMbUVoMU5YMXRK?=
 =?utf-8?B?amEreUJHOVdKNFNvQ1YzZEhHUU5yOEIweWpCa2tHTDN2MG50OGZyaXBPYU9B?=
 =?utf-8?B?MTBiK1NBSXozYm1qY3hGSTVyL21nZnIyT2RmOGZRVERERUg4RFFMbWJaa3g5?=
 =?utf-8?B?WEFkSFF6Mm1ONjdidFVTNlpwVFFmK2tpcEc0WmVuS05QbUVBcFovaUVhNkJk?=
 =?utf-8?B?a0UxSnladTlYQzN1czI0SmNZUkgzUEJCdEN6Sm9xRjk0SWZjODRMOVVBWW0r?=
 =?utf-8?B?aHBmOUlsMkc5Q0VSRnZCb2t0b2svaUZTVkJJMllTV0NNVmhTRm9yVlZUdDlT?=
 =?utf-8?B?b1VQYytibWdjN3QrN2RYd1VwL1pYSEVTL2dPZ3RRME43WVdVSU9oQ1lndEl0?=
 =?utf-8?B?T2sxSHRaaHJ5Q3lRc0M0NmpMSEtiQlNrbWh3cVNKKytGS2ZTeDgzeFRIZjVt?=
 =?utf-8?B?RlIxdUV3S05YV2FDQVlpNkVVdzgzMDYraGw4YmhQaXpOZGRzMkpkMUtnTi82?=
 =?utf-8?B?OUVEWFZUcWtwNHVWbURXeks3djdKK0ZFblFXcFZCYm16bFB3YXNZdmpNQzZ6?=
 =?utf-8?B?TXlBR1FxbFg3aDFHeVR6ZEFFNThuME9NZlRvdEJuelU5VjdUWVF1SmRIeW44?=
 =?utf-8?B?aDFqNjJuc1g2MVZ4WU9jMUZiRHl3M1FxN2JvaDBsL0Erb3VCNzZXeFE3ZWZC?=
 =?utf-8?B?eXczNFpUMEtnZGg0OCtrbjBxS0FJZThqVmRNUDJjMzUrb2FhbThBaDd2eDNL?=
 =?utf-8?B?OFYwa29lQ2g0dlhycmJxQmF2K1ZCY0NDcjdFYXhMZ2IyUWFwWmMyM2RuVjZD?=
 =?utf-8?B?NmVlZ3hhdjI5TVZOTmZKakRLY2dIQitrWTBZQURiSWV1Rm5WSGhQVmtzeTJI?=
 =?utf-8?B?MDA1NHU0aHFMTjNkcWRtVVR3UmRqNW5BU0ViOUhsR1JQckdXVlIvRG41WGlV?=
 =?utf-8?B?aDJlY2RGemZ6Z3RmN0xLcVdDZXFYcEpxVDhjM0Fjc1dKUnMxQkVoNTNUWEsy?=
 =?utf-8?B?cGJneUw3cFd3Q0M1RVI0RzJVVTEzRnhUU0JtRTFCRVpZVTVaQWtjazRRMHpj?=
 =?utf-8?B?cGhPZyt1ZVpXS1FQaWl4M1ZlRXJIeXZ2STFnRVZFUUxtUVVDU2tGVTBSL1FX?=
 =?utf-8?B?akNWckhPaDBGTjBiajRpeGZUUGtQT3V2ZXZTbXZQdTRheUMxcFJDSlJCSG5U?=
 =?utf-8?B?WjRqS1hqQlY2RlZjT2NaVWRSS05rOEhDNkVNelpWUVBVYzBWSWliNzZOazNl?=
 =?utf-8?B?cTNSMVpKNmxpZFd0eWE3Um4xRnNweGdFaGJ4MVNhZUJFTkdoMkRiclU3TDdn?=
 =?utf-8?B?blRaRVlHcldzU0JIUmxMVEZGYXduZVNZRG4vL2lVejB2eWtUOU9mSFZDMUNp?=
 =?utf-8?B?QkJsbER3NUdkblpuZGVsOWlWaHEzWkgyZTFBU1NFZHlwUHMyN2dOSEp2V3lL?=
 =?utf-8?B?ZDAzcVhlc2VmaUVQWmlJclMrR0x2Y0RaWlk5dkE2WFBzUEdiak5uWWtyUE5H?=
 =?utf-8?B?aEc4RXJnc0pJSnZtZWlzdC93ZHduaklTU2dQN0VFL2dyVWlhcFgwU1dtcGkw?=
 =?utf-8?B?cnZVRlF0TGVad1dRK0U2QlAyaVp0WXVjYXN1Ti8xN0dvVEE4SnlZcUhTbkcw?=
 =?utf-8?B?cVJGaEN0OXR2cm1WTXpicTNVbDU1dDhGUno4akZqNXgzcU5zNC83TFVzMGtV?=
 =?utf-8?B?U0NYeHR2WGdTNXdLYmY4dS9hTHR6Nlc2M2p4dUpwNXd5MkMxZGVISUpYbHNk?=
 =?utf-8?B?RlRzcjRieHZ4aUxjYTYzMW9MVlVWZGxYOWFQUG5aR3BUL09QUkZFYUxuMTdY?=
 =?utf-8?Q?1tkFuqzXRyuQ43SMS9wuQ8mvI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d756ad0-5bef-4be4-4e27-08dae4700d5d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 22:58:33.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Whu2PKakUAf7g+boMRdvYc4DhOOIBOumzTtDNG2hkL8wwrX/4OKHRmBbiUBgNWbNdsMOn9n2SfowInt5X1dLEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 03:27:08PM +0100, Fabio M. De Francesco wrote:
> On giovedì 22 dicembre 2022 06:41:01 CET Ira Weiny wrote:
> > On Wed, Dec 21, 2022 at 06:28:02PM +0100, Fabio M. De Francesco wrote:
> > > kmap() is being deprecated in favor of kmap_local_page().
> > > 
> > > There are two main problems with kmap(): (1) It comes with an overhead as
> > > the mapping space is restricted and protected by a global lock for
> > > synchronization and (2) it also requires global TLB invalidation when the
> > > kmap’s pool wraps and it might block when the mapping space is fully
> > > utilized until a slot becomes available.
> > > 
> > > With kmap_local_page() the mappings are per thread, CPU local, can take
> > > page faults, and can be called from any context (including interrupts).
> > > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > > the tasks can be preempted and, when they are scheduled to run again, the
> > > kernel virtual addresses are restored and still valid.
> > > 
> > > Since its use in fs/ufs is safe everywhere, it should be preferred.
> > > 
> > > Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
> > > requires the mapping address, so return that address from ufs_get_page()
> > > to be used in ufs_put_page().
> > 
> > I don't see the calls to kunmap() in ufs_rename converted here?
> > 
> > Did I miss them?
> >
> 
> No, it's my fault.
> I must have used "grep" on all files in fs/ufs, but I forgot to run it :-(
> 
> While at this... I'm wondering whether or not we could benefit from a WARNING 
> about the use of kunmap(). I'm talking about adding this too to checkpatch.pl, 
> exactly as we already have it for catching the deprecated use of kmap(). 

That would not have caught this issue.  Any addition of kunmap() in a patch
would have to come with a call to kmap().  (Unless they are fixing some kmap
bug I suppose.)  I'm not sure how the checkpatch.pl maintainers would feel
about this.  You can always submit a patch and find out but I would not worry
about it.

>  
> >
> > I think those calls need to be changed to ufs_put_page() calls in a 
> precursor
> > patch to this one unless I'm missing something.
> > 
> 
> Again I think that you are not missing anything and that your suggestion 
> sounds good.
> 
> I'll replace the three kunmap() + put_page() with three calls to 
> ufs_put_page() in ufs_rename(). I'll do these changes in patch 3/4. Instead 
> the current 3/4 patch will move ahead and become 4/4.

Sounds good.

> 
> >
> > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > > 
> > >  fs/ufs/dir.c | 75 ++++++++++++++++++++++++++++++++--------------------
> > >  1 file changed, 46 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> > > index 9fa86614d2d1..ed3568da29a8 100644
> > > --- a/fs/ufs/dir.c
> > > +++ b/fs/ufs/dir.c
> > > @@ -61,9 +61,9 @@ static int ufs_commit_chunk(struct page *page, loff_t 
> pos,
> > > unsigned len)> 
> > >  	return err;
> > >  
> > >  }
> > > 
> > > -static inline void ufs_put_page(struct page *page)
> > > +static inline void ufs_put_page(struct page *page, void *page_addr)
> > > 
> > >  {
> > > 
> > > -	kunmap(page);
> > > +	kunmap_local((void *)((unsigned long)page_addr & PAGE_MASK));
> > 
> > Any address in the page can be passed to kunmap_local() as this mask is done
> > internally.
> > 
> 
> I know that any address can be passed and that the bitwise and is performed 
> internally in kunmap_local_indexed(). This is why I've never done something 
> like this in any other of my precedent conversions. 
> 
> However, I thought that Al should have had reasons to suggest to call 
> kunmap_local() this way. Copy-pasted from one of his message (https://
> lore.kernel.org/lkml/Y4E++JERgUMoqfjG@ZenIV/) while commenting the one patch 
> old conversions:
> 
> --- begin ---
> 
>  -static inline void ufs_put_page(struct page *page)
> > +inline void ufs_put_page(struct page *page, void *page_addr)
> >  {
> > -	kunmap(page);
> > +	kunmap_local(page_addr);
> 
> Make that
> 	kunmap_local((void *)((unsigned long)page_addr & PAGE_MASK));
> and things become much easier.
> 
> >  	put_page(page);
> >  }
> 
> --- end ---
> 
> Did I misinterpret his words?
> However, it's my fault again because I should have asked why :-(

Perhaps Al did not know that kunmap_local() would take care of this for you?

> 
> > >  	put_page(page);
> > >  
> > >  }
> > > 
> > > @@ -76,7 +76,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct
> > > qstr *qstr)> 
> > >  	de = ufs_find_entry(dir, qstr, &page);
> > >  	if (de) {
> > >  	
> > >  		res = fs32_to_cpu(dir->i_sb, de->d_ino);
> > > 
> > > -		ufs_put_page(page);
> > > +		ufs_put_page(page, de);
> > > 
> > >  	}
> > >  	return res;
> > >  
> > >  }
> > > 
> > > @@ -99,18 +99,17 @@ void ufs_set_link(struct inode *dir, struct
> > > ufs_dir_entry *de,> 
> > >  	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
> > >  	
> > >  	err = ufs_commit_chunk(page, pos, len);
> > > 
> > > -	ufs_put_page(page);
> > > +	ufs_put_page(page, de);
> > > 
> > >  	if (update_times)
> > >  	
> > >  		dir->i_mtime = dir->i_ctime = current_time(dir);
> > >  	
> > >  	mark_inode_dirty(dir);
> > >  
> > >  }
> > > 
> > > -static bool ufs_check_page(struct page *page)
> > > +static bool ufs_check_page(struct page *page, char *kaddr)
> > > 
> > >  {
> > >  
> > >  	struct inode *dir = page->mapping->host;
> > >  	struct super_block *sb = dir->i_sb;
> > > 
> > > -	char *kaddr = page_address(page);
> > > 
> > >  	unsigned offs, rec_len;
> > >  	unsigned limit = PAGE_SIZE;
> > >  	const unsigned chunk_mask = UFS_SB(sb)->s_uspi->s_dirblksize - 1;
> > > 
> > > @@ -185,23 +184,32 @@ static bool ufs_check_page(struct page *page)
> > > 
> > >  	return false;
> > >  
> > >  }
> > > 
> > > +/*
> > > + * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
> > > + * rules documented in kmap_local_page()/kunmap_local().
> > > + *
> > > + * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page()
> > > + * and must be treated accordingly for nesting purposes.
> > > + */
> > > 
> > >  static void *ufs_get_page(struct inode *dir, unsigned long n, struct page
> > >  **p) {
> > > 
> > > +	char *kaddr;
> > > +
> > > 
> > >  	struct address_space *mapping = dir->i_mapping;
> > >  	struct page *page = read_mapping_page(mapping, n, NULL);
> > >  	if (!IS_ERR(page)) {
> > > 
> > > -		kmap(page);
> > > +		kaddr = kmap_local_page(page);
> > > 
> > >  		if (unlikely(!PageChecked(page))) {
> > > 
> > > -			if (!ufs_check_page(page))
> > > +			if (!ufs_check_page(page, kaddr))
> > > 
> > >  				goto fail;
> > >  		
> > >  		}
> > >  		*p = page;
> > > 
> > > -		return page_address(page);
> > > +		return kaddr;
> > > 
> > >  	}
> > >  	return ERR_CAST(page);
> > >  
> > >  fail:
> > > -	ufs_put_page(page);
> > > +	ufs_put_page(page, kaddr);
> > > 
> > >  	return ERR_PTR(-EIO);
> > >  
> > >  }
> > > 
> > > @@ -227,6 +235,13 @@ ufs_next_entry(struct super_block *sb, struct
> > > ufs_dir_entry *p)> 
> > >  					fs16_to_cpu(sb, p-
> >d_reclen));
> > >  
> > >  }
> > > 
> > > +/*
> > > + * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
> > > + * rules documented in kmap_local_page()/kunmap_local().
> > > + *
> > > + * ufs_dotdot() acts as a call to ufs_get_page() and must be treated
> > > + * accordingly for nesting purposes.
> > > + */
> > > 
> > >  struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
> > >  {
> > >  
> > >  	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);
> > > 
> > > @@ -238,12 +253,15 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir,
> > > struct page **p)> 
> > >  }
> > >  
> > >  /*
> > > 
> > > - *	ufs_find_entry()
> > > + * Finds an entry in the specified directory with the wanted name. It
> > > returns a + * pointer to the directory's entry. The page in which the 
> entry
> > > was found is + * in the res_page out parameter. The page is returned 
> mapped
> > > and unlocked. + * The entry is guaranteed to be valid.
> > > 
> > >   *
> > > 
> > > - * finds an entry in the specified directory with the wanted name. It
> > > - * returns the page in which the entry was found, and the entry itself
> > > - * (as a parameter - res_dir). Page is returned mapped and unlocked.
> > > - * Entry is guaranteed to be valid.
> > 
> > I don't follow why this comment needed changing for this patch.  It probably
> > warrants it's own patch.
> > 
> 
> Sure, the removal of the name of function is a different logical change, so 
> I'll probably leave it as it was. 
> 
> > > + * On Success ufs_put_page() should be called on *res_page.
> > > + *
> > > + * ufs_find_entry() acts as a call to ufs_get_page() and must be treated
> > > + * accordingly for nesting purposes.
> > > 
> > >   */
> 
> But this last part should be still added. Am I wrong?

You are not wrong.  Adding this is appropriate.  Just not the rest which seemed
very minor changes anyway.

> 
> > >  struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr 
> *qstr,
> > >  				struct page **res_page)
> > > 
> > > @@ -282,7 +300,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode 
> *dir,
> > > const struct qstr *qstr,> 
> > >  					goto found;
> > >  				
> > >  				de = ufs_next_entry(sb, de);
> > >  			
> > >  			}
> > > 
> > > -			ufs_put_page(page);
> > > +			ufs_put_page(page, kaddr);
> > > 
> > >  		}
> > >  		if (++n >= npages)
> > >  		
> > >  			n = 0;
> > > 
> > > @@ -360,7 +378,7 @@ int ufs_add_link(struct dentry *dentry, struct inode
> > > *inode)> 
> > >  			de = (struct ufs_dir_entry *) ((char *) de + 
> rec_len);
> > >  		
> > >  		}
> > >  		unlock_page(page);
> > > 
> > > -		ufs_put_page(page);
> > > +		ufs_put_page(page, kaddr);
> > > 
> > >  	}
> > >  	BUG();
> > >  	return -EINVAL;
> > > 
> > > @@ -390,7 +408,7 @@ int ufs_add_link(struct dentry *dentry, struct inode
> > > *inode)> 
> > >  	mark_inode_dirty(dir);
> > >  	/* OFFSET_CACHE */
> > >  
> > >  out_put:
> > > -	ufs_put_page(page);
> > > +	ufs_put_page(page, kaddr);
> > > 
> > >  	return err;
> > >  
> > >  out_unlock:
> > >  	unlock_page(page);
> > > 
> > > @@ -468,13 +486,13 @@ ufs_readdir(struct file *file, struct dir_context
> > > *ctx)
> > > 
> > >  					       ufs_get_de_namlen(sb, 
> de),
> > >  					       fs32_to_cpu(sb, de-
> >d_ino),
> > >  					       d_type)) {
> > > 
> > > -					ufs_put_page(page);
> > > +					ufs_put_page(page, kaddr);
> > > 
> > >  					return 0;
> > >  				
> > >  				}
> > >  			
> > >  			}
> > >  			ctx->pos += fs16_to_cpu(sb, de->d_reclen);
> > >  		
> > >  		}
> > > 
> > > -		ufs_put_page(page);
> > > +		ufs_put_page(page, kaddr);
> > > 
> > >  	}
> > >  	return 0;
> > >  
> > >  }
> > > 
> > > @@ -485,10 +503,10 @@ ufs_readdir(struct file *file, struct dir_context
> > > *ctx)
> > > 
> > >   * previous entry.
> > >   */
> > >  
> > >  int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
> > > 
> > > -		     struct page * page)
> > > +		     struct page *page)
> > > 
> > >  {
> > >  
> > >  	struct super_block *sb = inode->i_sb;
> > > 
> > > -	char *kaddr = page_address(page);
> > > +	char *kaddr = (char *)((unsigned long)dir & PAGE_MASK);
> > 
> > I feel like this deserves a comment to clarify that dir points somewhere in
> > the page we need the base address of.
> 
> OK, it sounds reasonable.
> 
> > >  	unsigned int from = offset_in_page(dir) &
> > >  	~(UFS_SB(sb)->s_uspi->s_dirblksize - 1); unsigned int to =
> > >  	offset_in_page(dir) + fs16_to_cpu(sb, dir->d_reclen); loff_t pos;
> > > 
> > > @@ -527,7 +545,7 @@ int ufs_delete_entry(struct inode *inode, struct
> > > ufs_dir_entry *dir,> 
> > >  	inode->i_ctime = inode->i_mtime = current_time(inode);
> > >  	mark_inode_dirty(inode);
> > >  
> > >  out:
> > > -	ufs_put_page(page);
> > > +	ufs_put_page(page, kaddr);
> > > 
> > >  	UFSD("EXIT\n");
> > >  	return err;
> > >  
> > >  }
> > > 
> > > @@ -551,8 +569,7 @@ int ufs_make_empty(struct inode * inode, struct inode
> > > *dir)> 
> > >  		goto fail;
> > >  	
> > >  	}
> > > 
> > > -	kmap(page);
> > > -	base = (char*)page_address(page);
> > > +	base = kmap_local_page(page);
> > 
> > NIT: I'd make this conversion a separate patch.
> > 
> > Ira
> > 
> 
> We've always done multiple conversions at the same time if in the same file, 
> even if they were unrelated.
> 
> I don't understand why we want to change the usual procedure. Can you please 
> elaborate a bit more on this topic?

The difference here is we are making a lot of changes to the
ufs_{get,put}_page() calls and all their callers and this is not part of those
changes.  So reviewing those was hard enough without looking at this more
mundane change.  But like I said it is a nit so feel free to leave it as the
change looks fine.

> 
> Thanks so much for finding the missing conversions and for your other comments 
> and advice on this patch.

NP!

Ira

> 
> Fabio
> 
> > >  	memset(base, 0, PAGE_SIZE);
> > >  	
> > >  	de = (struct ufs_dir_entry *) base;
> > > 
> > > @@ -569,7 +586,7 @@ int ufs_make_empty(struct inode * inode, struct inode
> > > *dir)> 
> > >  	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
> > >  	ufs_set_de_namlen(sb, de, 2);
> > >  	strcpy (de->d_name, "..");
> > > 
> > > -	kunmap(page);
> > > +	kunmap_local(base);
> > > 
> > >  	err = ufs_commit_chunk(page, 0, chunk_size);
> > >  
> > >  fail:
> > > @@ -585,9 +602,9 @@ int ufs_empty_dir(struct inode * inode)
> > > 
> > >  	struct super_block *sb = inode->i_sb;
> > >  	struct page *page = NULL;
> > >  	unsigned long i, npages = dir_pages(inode);
> > > 
> > > +	char *kaddr;
> > > 
> > >  	for (i = 0; i < npages; i++) {
> > > 
> > > -		char *kaddr;
> > > 
> > >  		struct ufs_dir_entry *de;
> > >  		
> > >  		kaddr = ufs_get_page(inode, i, &page);
> > > 
> > > @@ -620,12 +637,12 @@ int ufs_empty_dir(struct inode * inode)
> > > 
> > >  			}
> > >  			de = ufs_next_entry(sb, de);
> > >  		
> > >  		}
> > > 
> > > -		ufs_put_page(page);
> > > +		ufs_put_page(page, kaddr);
> > > 
> > >  	}
> > >  	return 1;
> > >  
> > >  not_empty:
> > > -	ufs_put_page(page);
> > > +	ufs_put_page(page, kaddr);
> > > 
> > >  	return 0;
> > >  
> > >  }
> > > 
> > > --
> > > 2.39.0
> 
> 
> 
> 
