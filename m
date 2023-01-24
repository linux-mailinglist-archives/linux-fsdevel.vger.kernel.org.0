Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D96E67A3B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 21:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjAXURI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 15:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjAXURG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:17:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F259E83EE;
        Tue, 24 Jan 2023 12:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674591426; x=1706127426;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=fLMLjRXX7yDyxfkZLSf8rFEjaIAcydpWJvXDZXE9yXk=;
  b=Xt5+3Rh8++jca5yZ4GwXr7rtPAdXGbepZmSKkeNLN7IW5Bs/7PEFqtwC
   YH9Tb2/9P4Jw8ghkpeiq0fJ4tOPjRlngIz7FJ5ndHJj+b9Kka+OQuNUQ+
   ggetm1nmFoDT9rZOyjD/5qFJlEvmf7jQwsjcVzn3qenMmJCzw1+N/6Vyy
   XDWK+DTh/TYLf/XubSab5tzJrRiF6gwv4lFfeuxYaaImz8qtCOW+faYrG
   w5Dy4jcQHhww1GfNpt00gAOkZXI4LKSEDllFW6XlGBWlxFdRgj8BjNwzK
   SGB+7w1wNvPloCebf4ZUZRo26qv0GgroexHeO6YQKN/ZstF9T2A+L/FEz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="412628999"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="412628999"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 12:17:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="639699264"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="639699264"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2023 12:17:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 12:17:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 12:17:04 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 12:17:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ85UVJR2V60UrYz0IAYWZdK0UIGQZg77czqatq8Ty7VArTsUqqO8z7msnNmX5FnkzUgjDCtgjmA3P3b+/qjVcses6GSHeoHXk/K52cKpn1X+dFARJ07iS79wraa/k2h/sNz/r9KJ59UBqZuugLdUnsF74mDJa8W4Qthmwxm3SX+fSO4AD0d378zqVTw3UmiuZZWW3axDnWEo7Cqr61bF+ewkun/IlQS3tH9CAIcnpkVA8jzHLeP/kdWHjIG0JiWAndZxvRattSKZshiwjtv8F3hjAnZPe4zf8FVihToGCU7g0ZHblSRgEfMpEyNrU7AHXGu79WQuTUcAX1ZnNCSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvC8Yi8XPEtR1XfYdjjrpaNKEwhmlKMkFS+cn1AWUFM=;
 b=X+hnHoIgBGoG/yT/nb0RA/SARnMsJqyXPX0c4EgEo2g/KzL76OYv3VRVR5vZbn7WcO6xTa1jkBTAO++ktDQh+p7cKAOQfpoI2OGVL6b6LR4F/f2B7d0K8XByZN2MGRc+1cpwVJNhp4o0WpbaptK3dGU6CcFVO3iLZzZSvSY0ZrAm3Ry0ao3aKAMNR4DcFIe/H7BMRWT2M5rApOuWlOMAbuv7N3C80IXtorhqvZEVI5cI3exPLXxlWcqdpFFgBWNC4DJCtMoHSEdqm4tg2KH4F8mlIcyEGWok/O/lyG2pY5QyUF/EydEYl6DKVbQbjXleU1cH3NvBN5I6Ii+N5DscyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB8150.namprd11.prod.outlook.com (2603:10b6:208:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 24 Jan
 2023 20:17:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Tue, 24 Jan 2023
 20:17:02 +0000
Date:   Tue, 24 Jan 2023 12:16:59 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Christoph Hellwig <hch@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Message-ID: <63d03cbb5c6a8_9ed629449@iweiny-mobl.notmuch>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
 <Y8ohpDtqI8bPAgRn@ZenIV>
 <Y8os8QR1pRXyu4N8@ZenIV>
 <3146373.5fSG56mABF@suse>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3146373.5fSG56mABF@suse>
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d0ba88-3ba7-4cbc-71e5-08dafe47f496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VeKnYzRXaajmh5MyMTCaq/boaLGjdRpwORiXp9MVQwbq78DvlB1axPdmDOokUGwCIe2/0P7GepJyfWVLMq8WUcuYSuXdB6JO7qJWItWMidLECam1Rle2T4+sEzFSNZ7ZBRW8HY9fYx+qWBiHFBogkcDG18oKRgCGA0L3c2d8+9XDwq1UYTTuMm74bVsoTwijLVK4qw5949Ng/nKKYV3tXeY9jw3X1sz253k2x02op0Ao9r0djeZUycKLzHQHIJtXeF8Q+vUGQTI5xZBFKvGVfOMi5v1dHes9g63j5SABx28k1Y5xV/QliprabwGpzXBQ+cLgAaXCj3URz5ooDGxZNRde3oOH8YQrzRnJEb3hVjPg+X03dRLtQ2zFEH4Palkq1ZGnzfWxWCXd5vPAjhXmm9LiWvEQQm0SL1TvQyEEOuvR6afyea7ItYPq9KnuUCXcirbBl0stiFXblnLgAcv3aPEQJVRleqqRN5WJJRJMrFzbsm7ngbTr9haF4YC+NkBE1h94G9dOjx5GUHyna7eu23OYlOctXetmGdGGeyl2OkUbydLWq60DhR+mP1ackyY/qmwBm3fIZIibzA2v2aYwETRCt2GSsE2pD5YJaCAM71yfB2dvpeITCu7+vBCpfbHhQWw08e7hNsK/3uhmjHz+ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199018)(66899018)(54906003)(6486002)(66946007)(41300700001)(66476007)(66556008)(82960400001)(38100700002)(6666004)(86362001)(9686003)(4326008)(5660300002)(110136005)(26005)(186003)(8676002)(478600001)(6506007)(316002)(44832011)(8936002)(6512007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NCU55otDfDFqQFopwOvNvKlY13Uyo+rratw//gYhoRPjF/354eIGIQ256k?=
 =?iso-8859-1?Q?p5IDZ9WoLkoDuo/GIu7ySWrEfNXHYW9TT/HgpyjKseWkS+c3r4NLadpVqG?=
 =?iso-8859-1?Q?7EBoSY+B5/PtfeWVoe59m2LbF6soB/rPOhlk2F2R5ccvL6RWf7Ltesy79L?=
 =?iso-8859-1?Q?OtjvhKiHmTSUue8G75Pmqy+3yI734s/qnjrA+YWCwUvYHImvQiO94GxLJl?=
 =?iso-8859-1?Q?CeYTxOBlQyFXZc+1wHnrjIR2Amr/0lg10z5WQvXsQgtYPsa1/bogs7f5uJ?=
 =?iso-8859-1?Q?Bll9bLVDzMjtfrs29w1oMqvRtywdvp/pOuszAD58g4VOLZHN1ygW+tTiP0?=
 =?iso-8859-1?Q?PBNKXZQqhB3tGQSR8BKBG9jxrdqs2NDswcKZHbsJ8FEFPT3kiO8TaD7ghb?=
 =?iso-8859-1?Q?Pa7y/FCT0GLCMsSTUslXQpv2ZN7T2QtxkHpKiehTcHiivR9GKHlI/4GjU5?=
 =?iso-8859-1?Q?1i4Mk9OxK4T5iijMBcdrlRonOj/9Ylg8VqBL2c+fB4L3zIT5sHvFBZuHYH?=
 =?iso-8859-1?Q?EokLnuO4GEZuRa372q+n8yrnZjE07z0zpgnFwKJV6jhjv8BzriwH9OKQmL?=
 =?iso-8859-1?Q?0N4yRL9nAWrPxTyxD5/qQIbRj0pBDs4963tUiEW10u/Jns6f793Kf1GAEv?=
 =?iso-8859-1?Q?Q/ws6jMlnJrLM8QNiz5+6TZjaw+GSIdq/VjOqpE07AN0sZYSMzoSf6UsZF?=
 =?iso-8859-1?Q?h5bQnfo+J1xZoS22E85sag9TPChBgCrYP9avPlnxciQ4YlccRD6ut+86qz?=
 =?iso-8859-1?Q?9sxfyXMSfUCnPHHvfHhU1NHeFcPrSP7hbfW91NSTVkTPJP6Sd5+DvFB/57?=
 =?iso-8859-1?Q?b9sFTogWV9SXnBkTfAWq6YQ57MZWVtw2ZTF+OAoPB0pLYtPhgsN/oBiNC6?=
 =?iso-8859-1?Q?j9XEVy70D3xxIDBnnjYU1QGqp2fXAnSiFBT5HdEopXsw229ysQnT09zaxt?=
 =?iso-8859-1?Q?P1EI3Z9LE2qBHferXNeVR8fprT1YAiUnYx7AlSSiG+vkUXZHJG4yQFK5kv?=
 =?iso-8859-1?Q?r1wdcMaYt3BZFzon0mx+hwggSd9q6Gvod4VFWrsx/Ah0YyKfxHVaoh8POF?=
 =?iso-8859-1?Q?zeSf2g8VSmWdJ/IQ4OClgKG0N9PAuIK/fq2Ks124r3A1RN9gWKcl3dKIP/?=
 =?iso-8859-1?Q?Y9+RXdaZiW762ss4D73OdxaNf3URP0dZ35ZhML7BPD04g7j/zrxWZO+7tq?=
 =?iso-8859-1?Q?tkYcQoZ2Kyl1NOJEMCWiNAc7AQg0vaazmwTlj8qkBQzXbneJ3A/kgNv2o0?=
 =?iso-8859-1?Q?sYZ0+dSLRYXGRh2LT635LTunBRLf2Jpd1B2VIbddxhRCRADnGhe8BQcgdd?=
 =?iso-8859-1?Q?MsLR6s6izKr/+28bKT9Hbf8t94I2H6H2/ftcd+Vb36LWxGEo18nc/8dgoa?=
 =?iso-8859-1?Q?6aZg6HuzreXHmK8xYDUPmyDlI8H7GPNsWJtQMQfYst/c1MB4jeGv0Pc+WQ?=
 =?iso-8859-1?Q?bL5xfLUPVMWDe6heHWRNi3mPq0vKSau+y6ZjQbGigwyoUqw8lNMrukT5Zw?=
 =?iso-8859-1?Q?5K6qlvM+/rdXt4NfTVm1+HHA833h4U5jgkv99WVJlgUOvzoZx5I7cuVHpJ?=
 =?iso-8859-1?Q?LDArF6shYIXj/iF0YLA2ZT45tEkcRdvGPtcfnPuUZOWuAP3AMcn8RxhGYw?=
 =?iso-8859-1?Q?d8282A7Z/OGxAbQwNp6zJ1G4gBAzzB4OUdd8SYtbrKbtTDVsHiph+vvw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d0ba88-3ba7-4cbc-71e5-08dafe47f496
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 20:17:02.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7Ixne5PH/OYW1o98dByWhK5rQdFNuCbf+P3VgO7sT9K74z/BxQdrGRsC0iEjExBfEkLOeuoSi7qJvzrkLTp3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8150
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fabio M. De Francesco wrote:
> On venerdì 20 gennaio 2023 06:56:01 CET Al Viro wrote:
> > On Fri, Jan 20, 2023 at 05:07:48AM +0000, Al Viro wrote:
> > > On Fri, Jan 20, 2023 at 04:54:51AM +0000, Matthew Wilcox wrote:
> > > > > Sure, but... there's also this:
> > > > > 
> > > > > static inline void __kunmap_local(const void *addr)
> > > > > {
> > > > > #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> > > > > 
> > > > >         kunmap_flush_on_unmap(addr);
> > > > > 
> > > > > #endif
> > > > > }
> > > > > 
> > > > > Are you sure that the guts of that thing will be happy with address 
> that
> > > > > is not page-aligned?  I've looked there at some point, got scared of
> > > > > parisc (IIRC) MMU details and decided not to rely upon that...
> > > > 
> > > > Ugh, PA-RISC (the only implementer) definitely will flush the wrong
> > > > addresses.  I think we should do this, as having bugs that only manifest
> > > > on one not-well-tested architecture seems Bad.
> > > > 
> > > >  static inline void __kunmap_local(const void *addr)
> > > >  {
> > > >  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> > > > 
> > > > -       kunmap_flush_on_unmap(addr);
> > > > +       kunmap_flush_on_unmap(PAGE_ALIGN_DOWN(addr));
> > > > 
> > > >  #endif
> > > >  }
> > > 
> > > PTR_ALIGN_DOWN(addr, PAGE_SIZE), perhaps?
> > 
> > 	Anyway, that's a question to parisc folks; I _think_ pdtlb
> > quietly ignores the lower bits of address, so that part seems
> > to be safe, but I wouldn't bet upon that.  And when I got to
> > flush_kernel_dcache_page_asm I gave up - it's been a long time
> > since I've dealt with parisc assembler.
> 
> There seems to be consensus that __kunmap_local() needs to be fixed for the 
> parisc case (ARCH_HAS_FLUSH_ON_KUNMAP).
> 
> Is anyone doing this task?

I'm not looking at it.

> 
> If you agree, I could make this change and give proper credits for the tip.

I think that would be great.

Thanks!
Ira

> 
> Thank you,
> 
> Fabio
> 
> 
> 


