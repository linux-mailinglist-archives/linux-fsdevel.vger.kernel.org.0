Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C820575224
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbiGNPo3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 11:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiGNPo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:44:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2DDAE4E;
        Thu, 14 Jul 2022 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657813467; x=1689349467;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FN7haTZMN6zPDUbvEGdolsvt29iXJQuUxTTV8/lfbvw=;
  b=IV/XNTL8fp+ybH4c1PEb87Sv8Fa6pZRxip6SAICROwGO8PF4H3U00oNq
   lGcSaiNF6UBfhPu3sUx/eczSui/z+s258Y6ehnRSgwQLqlU/IrmjDsfuy
   7pnP0mu419VTzj3TlWlrYMB69Hv5OmfIC+l3kAl6p0Rl8dBPj4dDom2OK
   1g5RYGv+NQiwPiwWWIDD+3gaL3kWAr71i+wQh1MCzxOaaNA/9LQd8Gq+G
   Ks91XL5gslpsLKZVP5T97eN67uncLSEVxjHXqwZEP2l4kEhDVOR2i/fT5
   jnhckmoHLaMEBV8xRVBmzyEDDfli9SYa8UjqjnMIoP4BA+VpPKypZ3MmX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265960269"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="265960269"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 08:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="571141926"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2022 08:44:06 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 08:44:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 08:44:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 08:44:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlKwCC615n6uSBPce2bZixnVHtBxTKjtt6qiQqzb8AxyhqAQF0+Uh8BpVBjMMyYnMo4tbjer/en9wxwu5Y9gDC0qyqOzm/9Jr7WCzLnHshM9lrxAC/b1Ei0e51GwdGBOvPVkJCoHuf+MzayAC8cYn+nMLR+N/65y6YnEv3Oz1XjWG/3eHG0GqgGp6PjO4dllTtZV5/+CTAfLaV9KU9jB5IR9DWc49bGFg6tYCIyGsaFQQutk3m3FrfhIgno9zbHkMPz2FaZ2Wxg2j3OE+WNZs4G0prMCOF1TRWBQNsQHe0ODbOPRqpk8W4Zb0OvXDSthIHv0u3/msvYv7DDUCwEC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw9ZWhWZVySunOKQWuc58oQSxg+I+VD8dlHffeNrpGw=;
 b=TXha29agjG5f3ga+wA5Q1TmXT4lavfWXLbMkBQonQULc6udwnTKhd1Z61KFmvzt3QZkUw1UiWFzzSQNcAY3Ab+P6Lu8njPDf8GY1+an5Vp8EVGYOS91WHlxhm7ltIsO/O7v2NOWH3d+OPp1rCM6wxoNSe03entCIPIW6FERSO9LJ+fa//frRwhzs4frcrLqazXgYco+n72eLh3JQfb25fuEgZSX09I8FSTpVDWqV9OVryK5/YexziqsvS10rkluv3VPRXvK64gvWhxMl3ytU2FDHgMnGa/z+qI5utNnkdycvLF5OemXRaRABNpafqSjKJQTVJnXZaq2mXMwCBWDh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB2937.namprd11.prod.outlook.com
 (2603:10b6:5:62::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 15:44:03 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 15:44:03 +0000
Date:   Thu, 14 Jul 2022 08:44:00 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] xarray: Introduce devm_xa_init()
Message-ID: <62d039c0cfc13_16fb972943f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220705232159.2218958-1-ira.weiny@intel.com>
 <20220705232159.2218958-2-ira.weiny@intel.com>
 <YshE/pwSUBPAeybU@casper.infradead.org>
 <YshGSgHiAiu9QwiZ@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YshGSgHiAiu9QwiZ@iweiny-desk3>
X-ClientProxiedBy: SJ0PR03CA0375.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::20) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a5268bf-14a3-40b4-ca9b-08da65afad93
X-MS-TrafficTypeDiagnostic: DM6PR11MB2937:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 264iuS/iHEqhl89G//p8bGoivoUnR9xRC2UpbtKVohScdV+EUvYXbIvmNjmEBMAQDk8ogsb2AaYs1SV6N6uqr2YQz8QQOSo/220elc7+LZBlbOo1NMqmoYnpZphwYr3cKB1t7EZDF5lccHqf15qOLcKXGphM3iBse9ZCALdedzmksfqTQKo6nktur64hdJz0O+3txxkRz7Tb8VoefZvdeYh/8JpthhKUyVvnUdoz6RpoOfmnUv1c/Ua56C85IhCOm7Yy6QonX/+3tzb7Q7YtmIsrbRUFew/OFFhG5rKKRFn1Kwr2rEt74qa5Jp1sdTr7RcAgSTULYXNfhMDS7vkJZm1siE019NRniJprfO5dWapa3VPjFYKWAtdNYPzHvr4cB+ZD4T4X+672MmBY2flKiUF08DUT9gxDLcK3xUXcDhyBYr0DqyCGkDiImNIIDqmMuTLL3WXjggNO2koXlsWCHrwrxeMAdwgDMyZWo+zINUC5n8ot1ru6zx0UsCYZ+m/qlNiIiicMQznyFuL8f3HgI2bnjnU/gCwRFyYDjX9Zgu8xE5i5R5p03wgOMUNWMtN3vFUzYyb/Eo22Biyzu8tCqvrexzbX5Xfi1vbMgX+mdZfEQ8/9+6C0grjRY7ugX6fxPUYZPDG1fJQNzTECpKaG1KCF7QOp2XfLX50lrIp9ISVMeUKHCaaPFw/odKag9TVRUsabWZSzI2ZTdPdLtmNTZ6jj8WR99tPEptrHWnqrUbGMECd8IGVzf6IAY8EntG4dIy5B6ifOMIiVlpk7xPeDzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(366004)(346002)(136003)(2906002)(9686003)(41300700001)(8676002)(8936002)(26005)(6512007)(38100700002)(86362001)(6486002)(478600001)(5660300002)(82960400001)(186003)(110136005)(66946007)(6506007)(316002)(4326008)(54906003)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F1IKuNaiAXiJElu17FwdK8KJ7rTV08GwJluboTi6EqSHlDZn5EECuEdpUc2j?=
 =?us-ascii?Q?o09qr6+MR9ij2+MapqsXHu+0xHh3K18p+tq7OcGD1pcaP5tDZivIfc0YOBCf?=
 =?us-ascii?Q?KgN3WXGnYZ23lVT5TmTQLtmu/J0ARWdj5we8ov66ljoU4jB87/ES9RmTO/Q2?=
 =?us-ascii?Q?z46LZBwKoGKSs0NKWmIHaPc5VEr7BHI+rQ05qUBm8QvuQp46B58RB1wuonqm?=
 =?us-ascii?Q?n3xlfn0wdhHQMTK7R9Yqrr+YskU+vvpulaP+0xCevMWu0+AsUKS5I6MhROK3?=
 =?us-ascii?Q?365gzJnCXsxPNMo49+TMTK19xOx3mmEMQLAyEZgB6Jm/BbaCJMkzCUmyiWCs?=
 =?us-ascii?Q?FKq41u9/ImtwPIzNJReII+145ZZLlrAVBQU3csW/ESOOaNvkzk0UDuKp4TGi?=
 =?us-ascii?Q?OQN4d1DF/bmixH1PLNqS76tCtcOk7pEcwJUqXnMdcsqArw86OSGHrCDaLET+?=
 =?us-ascii?Q?ninWqGvPYykd/+anXCcKGDjUyPm2Q0SoVn7Zk2tvqCgnqJKcX/ZOOFOMsGnf?=
 =?us-ascii?Q?tmOm6KlGrutYQEthYqk7NwT4Eb7pwtMKjHIni3i9BTOFOE2fGVD0asCROVQN?=
 =?us-ascii?Q?ju6gYbqVHhGJpDQLZQLKlOgqJMf/gS/Cqg3IPtFk7Daqw8wJFq+/KE6vydF3?=
 =?us-ascii?Q?4i01+JC7Lm5TyO5jstwuQCUVNpgQfxja6VH0HDoD4eSpjgzBV/yWPKWwxI6s?=
 =?us-ascii?Q?nPw8NK9en63SFXfs0KBGFNaV90R+epCw9GqU9EfL7ElJ01yEGc/vLEpCCxxg?=
 =?us-ascii?Q?QlOkcBkfnHSSu/hOyn8+CEw1Fao42Ameuw0eMNXNbM5LUxTiALVqkb0CB+Lu?=
 =?us-ascii?Q?FlHWPKyAdAiCFq40AysD9yc7H5BK9xvXZNsltR59VMSvv5wUP3xHZvHiIUNq?=
 =?us-ascii?Q?jF4VXvAQil+jQXZiOG9vcc7oSYdn4QO6AI7ON73QakQhPuoTpjmOyfIb7jUH?=
 =?us-ascii?Q?Pr+eq7MQbX09EUlOJJi45/AHS4EIjEknJArPtSWHSmZnFnRO8bdCWXmoFtT+?=
 =?us-ascii?Q?9bzFHBUJmPbzGpLpqR6mDfKVBQ9Q4K9gE2IRDq+ZaiTenndulNdHljX0rhPh?=
 =?us-ascii?Q?NokQDyT+LxibZY62jU2DmiWt9PP9PCcjIc+q8oem8S4si9Fomgee3+VIpg2L?=
 =?us-ascii?Q?nH+YDkMQKyiKxdXpdeuI2/BiNs/M0PoTDdkWPXgB+oHha90cxOdhb+hZYIjA?=
 =?us-ascii?Q?nagDGQacNqOVQhcTPMmdjAOw7ovPLA3eJFVq8ycnh8/9NXiSJf33o/jivOq5?=
 =?us-ascii?Q?9X1lkCrDCiwbqsopgUM24J2CmoKdM1hvXLn/thyvv2obrzNXdg23kaRbWZTp?=
 =?us-ascii?Q?tipIDURBWM3IglGGDe8BU/gek0oBTWaLuLfRrVNgUABJFMrqM7QiyI4H/see?=
 =?us-ascii?Q?9CJzPmAhnCOsm+YmDyZ3ydwAZhiNfv/91WMWk3OmuktI+euPVzb/VHjrzr76?=
 =?us-ascii?Q?4KVhprk81VwdYf7Vrn3OjfoZp7tN1pJjJbiL+4+GCh7GNlaiKKDXGKsR0ETY?=
 =?us-ascii?Q?TQmh/L0qrcbdmzLt5Vda1eZZZ0khpCmCgZNK+g7+AFTFpWANlSKfuODK02Zr?=
 =?us-ascii?Q?T0TlAYNQQmhR0fXSda4571juGBF7RjTVaXrFgserqXX/fWhRSSdQlAdkEL7/?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5268bf-14a3-40b4-ca9b-08da65afad93
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 15:44:03.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gLpPnIbMgOILlGk5jibJXLBrjZgb/QOUo5aTHiLh5LUc9w3Tqp2UTiV8K2jo8ezIDw1PqQSz7Oj/n8c6F0L/FpUHsQqbWawJZoxp9aHmWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2937
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ira Weiny wrote:
> On Fri, Jul 08, 2022 at 03:53:50PM +0100, Matthew Wilcox wrote:
> > On Tue, Jul 05, 2022 at 04:21:57PM -0700, ira.weiny@intel.com wrote:
> > > The main issue I see with this is defining devm_xa_init() in device.h.
> > > This makes sense because a device is required to use the call.  However,
> > > I'm worried about if users will find the call there vs including it in
> > > xarray.h?
> > 
> > Honestly, I don't want users to find it.  This only makes sense if you're
> > already bought in to the devm cult.  I worry people will think that
> > they don't need to do anything else; that everything will be magically
> > freed for them, and we'll leak the objects pointed to from the xarray.
> > I don't even like having xa_destroy() in the API, because of exactly this.
> > 
> 
> Fair enough.  Are you ok with the concept though?

I came here to same the same thing as Matthew. devm_xa_init() does not
lessen review burden like other devm helpers. A reviewer still needs to
go verfy that the patch that uses this makes sure to free all objects in
the xarray before it gets destroyed.

If there still needs to be an open-coded "empty the xarray" step, then
that can just do the xa_destroy() there. So for me, no, the concept of
this just not quite jive.
