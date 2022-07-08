Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DF156BD95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiGHPt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiGHPtX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:49:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B355E2ED5E;
        Fri,  8 Jul 2022 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657295362; x=1688831362;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=liJ1xNP88b/IOn0DSv9mLS4gRkR8b+gjB1IZ32wHQ6Y=;
  b=XaI5uNsGj1LkfMd8Rd7Akcy33uYnAGhX2WLOKVGGHcaZbmKQ+hMg7qQb
   jpcon01lMMpfYqOGJSAIy9VHBQunN6Q6yxdQukRw+qSrh1xJmxzSb5umD
   sBjPhFY777ln62HRC3vHKYr8znpCkbFScB/ocjPhcPG7eFIy7lp+MTXQU
   +4KiSa5gOv9k1jx+9F+gRmAcZAbF67fl1ZwOcucNWbvy+UamwqkDskyYD
   EazLahJCOKttxHTAXAEceMhoM3CcHoR8pJGXxCWR2i7E8mbFVzDqeu4GD
   IBp8cLTnfPfAvBqgLmTu7SyGumh2r/CfSR36YeCbf5bTiejpIibWyA3Yo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="283059517"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="283059517"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 08:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="621264708"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 08 Jul 2022 08:49:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 08:49:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Jul 2022 08:49:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Jul 2022 08:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcR9m8cCuFmD3cyjB99LtM+DXiKLSEyq39rqB8wYcMFMD5E2/J5PAQDDjxp6TR/6JnAiwmCk7Z2yoxMdTRyYCB98XO9R/KgxJcCR0Q7Kgi0mbw2lZoCNRlo0juSdtnwcjedEFUupJ9DzqSb18Wat64uSCFjrkdauOspbAbOs+BkTL20a4CQhV7oRit7ZNMQPrT/PXm5SMOnNXBuRHP+tCtTh+SBRxln+PtfK/nxUJncO5s7XixeRxpdclNvwybayCWdhg/r1A/HZiTpPcmKikNCTmr1/OVFAHyf6MbjmCeVm4SCN42a+OIhMED3T+/IpQMw1QtbOPIBmulWnopXZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7UwbsCSX99z4yMrj5OfH4+lAm3TarrBFUtVH7nxQiQ=;
 b=TWot0ZBKkA4EMKyWek7jC+D9niX3zBvqqHnjbPXrMZA+4M15j1rnv0n9U2juC6k/UJyrBHB6NsbeG5uqwsgqZZqRv3OJ4HQHnqYaIKa7bHjwXeNX5Y4xu1lHSoyVrGr2VTGqT+etlBH7xu9PxqXa40FMfduwjIWJ6IG1TdoauVfe7k+hLEbVE8bPcj6qwRbc91VXCSKt9xz4mH7tEB+yyyZJVLKMYD3ulMf+vbfkHrDkQMRNzp8PWpbEMtCvZLJmkSoteJRm3vT6o107yYEtVfAlKKYRDTLS2kijzZFayxo58IffJCyww4+Y6PnbycF3xn0qBah6k+OS7ENuUocqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 PH7PR11MB5913.namprd11.prod.outlook.com (2603:10b6:510:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 15:49:17 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da%9]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 15:49:17 +0000
Date:   Fri, 8 Jul 2022 08:49:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] pci/doe: Use devm_xa_init()
Message-ID: <YshR9b+cc1VogVlc@iweiny-desk3>
References: <20220705232159.2218958-3-ira.weiny@intel.com>
 <20220707160646.GA306751@bhelgaas>
 <YshC+Jaua01dPQak@iweiny-desk3>
 <YshED+nm7LdcmL75@casper.infradead.org>
 <YshFxnBZGUPN5LoC@iweiny-desk3>
 <YshHZXK/dq3apNDu@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YshHZXK/dq3apNDu@casper.infradead.org>
X-ClientProxiedBy: BYAPR01CA0061.prod.exchangelabs.com (2603:10b6:a03:94::38)
 To DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44c751a6-8eba-414e-10bc-08da60f96a1c
X-MS-TrafficTypeDiagnostic: PH7PR11MB5913:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2BtqjVKj0tqzf81sIKqg7sVSIe4zgt6G8ZOwWOu+afmThqxvQ9/qCtkm5d6zDVeKlwgdPsyTk25bH5AAULe3YYvqLNS6pLfxMPoc+Z3hecsK2Dp903189HyBJe7cvgrJgP9zmqFPBhAFUwEN3+l6fO59mpFc2yX/az3+KRwWpy2MYgBSY3iqWqiLSyRpcmEvVtjH8GlJD7QiNj5TcfPeIMEqed7Qf8dVS/N28aIOoyp/ytfALNb3CwlIxVBdR+PQzf3yLVo2FKXeDGNThIoucNNUYEsnuoGtdAgl8zePEqwfZWfuU+IayZCXycHUU4am0wjPf8OtXuqIPgGchT0bAx0WM6ZL6gFjPnEAA/906fOdsOSTBYVyBvJ9f3BQB2zit1mZ/uRlBpKhIUD8OeuAcEGngEt1G/mJndCLFShoFlY27xfyNrzpB3tq4jZXMjhsHVElEoP2WX/cm8DNRPbta8agiQ7qqcT7QjQ6KoYQ+j4vxXSXEy3HWJsS2kt292/6MvpIGMsaUSvmUKfnbHFT+ffdMF5dMBEb/V9ktNpcXQZxwtdTwQPBwHi4lGIdM0odj0g9YLTQbj5zJl801oiPtX2Oai4MqaJPTvPRsHUZgkEodWQEQnCt2CZ88wCWs3QffUiUMPd6RO+LFJ46qfHds/sNyfG43jrKPSd6WS0S77QBv9+8BXF3EbNb2gD9lsVO0+KLSTdy/cAA08STIvVmQ7abw9kX4sBqa3XIoHGqNM2vfeU4Gaz74te5ZdvFYOvIDS8CfBQIFf1qbm3C+wQifK056YtZl7xVIjM9qcuW5kfqKl1EH65+lDmBFrAi9HV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(396003)(136003)(376002)(346002)(2906002)(38100700002)(82960400001)(186003)(5660300002)(33716001)(8936002)(44832011)(6486002)(8676002)(66946007)(66556008)(83380400001)(4326008)(66476007)(86362001)(54906003)(6916009)(9686003)(6512007)(6666004)(478600001)(316002)(41300700001)(6506007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cNTFAOfIelz6fWe8vUH+6lpX/yyA/e1jZjhK+QLpfd43Ig+/DOVKHQUWz3xb?=
 =?us-ascii?Q?EUnxjqziYWch+TfZ9ogmB3chn4bbc95sz3wmwL+69TOcVMEHMyGOxrIFT8jb?=
 =?us-ascii?Q?3iNnVe6uE3TP/JuFYTpE8gXPWgmBsSsuzyXS4rOFiTl+yrC6nWcaLM+/X3eB?=
 =?us-ascii?Q?vN/3yd3CmmKZ4Iz8Xq9tMgfDQXxBQbdfwRAqRYIJ929/ztlAUILzrPtyEOwk?=
 =?us-ascii?Q?DE5N8o0hSaSD6FJkEV0pxZPN0x5SMUzOZCmB/YL2I+TXol9Ri599QFr6xzyG?=
 =?us-ascii?Q?FLdWzQ6dZn064f5ugRAo1Q9mZKRum3OPJcPMomXJRxPkIkcCFyikdMrAW5PQ?=
 =?us-ascii?Q?cp1pFxPpKDcvbt3qgnWHTMMVJFtl+LfEcdZqJpOEIMotoZdAYGSR7bL+XDAL?=
 =?us-ascii?Q?iLCDXjclR0EoewmC8ArypTPgQakHj5HW3PWxk0KQe0zZrUeJ2waUZzbRE6jN?=
 =?us-ascii?Q?lL640XZigk8wac7FCaA9FZr8xiNWR2L/yfrNWl5r7GQllhPpIAebJ7tO2hwk?=
 =?us-ascii?Q?e5O5L+SKxY0tCeRAr/Ru8np+LANTQU0ppTjXiEpeatnuFS4CQdVukypoxdQe?=
 =?us-ascii?Q?ktBkoI0XmyL+hWxKYeqFKv+dCCOm/aMEFX2uFkU6TvRnVoUlLOQ+3COinmch?=
 =?us-ascii?Q?KxQcVQjmnj25a8kqrWd69DFuejoUs2ikkm4AH00xYaZvxNpqWAegrTdQyy0Y?=
 =?us-ascii?Q?6Or1kzIMYeglKbaowyIhiHH7Wc4GywZwUIoVPQNZXcQulBgigh7W9R+Kue2z?=
 =?us-ascii?Q?SebABx6nqSLHR8BrgmGiJDK5cZD+18JA4WIT0O64DtfAoEMIoLxMpMdc1OsY?=
 =?us-ascii?Q?Pm+taykWJt9kUn/yhcLOGl/hEJbcA5q76VL5Z5mOoEDuKrnS3uEHGBX30SA9?=
 =?us-ascii?Q?lsQX/nmkApCTnF2CqWyLw9Ds1CC50rzBzQJujxDIVC5zNKI4+jQdwtrQbXpC?=
 =?us-ascii?Q?kd3eYdFjiVBkOUcS3vj4dD7Hii9saNNLzpTAm7BbAvSSAtS/aZGa1f8BOjVJ?=
 =?us-ascii?Q?+ELN6SACpGyLpue1CaDANbvX6R5tZBEVRPPqJsyOPIUU2ZkWF//tcu2BuYwB?=
 =?us-ascii?Q?aXp0An6Zt0m28fMCbWZSw0evxoZw8GR7w3zGPiB847HB5yiImRZXH5jw8OK3?=
 =?us-ascii?Q?IO7wFFttjucr4LEK5z0E71g2HEgoElGgz3Ye5Kx6eCHvjE9DZOj9asQj/YJp?=
 =?us-ascii?Q?8qdJ+keH4KRRUw8URMse9UZcoAPwn/Yold4Cn0xDIPYL4WQwc51//LdT7/pZ?=
 =?us-ascii?Q?nil8ThPDPUtwEa0WLcuSZ48nYnO5s7tFlt1+NUfOl7XwyUTOggFrzYTMf7Ms?=
 =?us-ascii?Q?79eHYz6eMeQPgg/3/mQ4f8bjkWcNFUpnChKJEUjAy+xz3VCw63BI0UE/+x2s?=
 =?us-ascii?Q?yV4Cq8rT3gH8d+1+XNuCaCSFFOJ3PSQIbPzNf2AyYg/Cy1ECiYTUdMoP32vZ?=
 =?us-ascii?Q?nFQ233wEb0W66+U1AtYbSZDnQiWcpXZFhEoNXH0Pcz8I95axLLUlFXO7B0VC?=
 =?us-ascii?Q?i6t++cG0cIW8ktUaouPMir77IsEtck2m06EPkATgo8zm+u4cqXYTXGuyZmd1?=
 =?us-ascii?Q?TMi3289SpPR34FfI8uWf1NdTfnrqzJwlYjKvUCG68tRa77azVxNjet1xZ9R0?=
 =?us-ascii?Q?znYKyvhWMYBWQhEwW1pxiIZ9Avn9+ZKEkh6BsFxTzd7u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c751a6-8eba-414e-10bc-08da60f96a1c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 15:49:17.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRtLFNKVre7foilH8EUscAsLJpbqqf6m8+qGqhvod33vAhhmcL12/3eTi2O7IQmXzXJswgEPijN7UI+AjAUckQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5913
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 08, 2022 at 04:04:05PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 08, 2022 at 07:57:10AM -0700, Ira Weiny wrote:
> > > > I'll update this to be more clear in a V1 if it goes that far.  But to clarify
> > > > here; the protocol information is a u16 vendor id and u8 protocol number.  So
> > > > we are able to store that in the unsigned long value that would normally be a
> > > > pointer to something in the XArray.
> > > 
> > > Er.  Signed long.
> > 
> > Sorry I misspoke, xa_mk_value() takes an unsigned long.
> 
> It does, *but* ...
> 
> static inline void *xa_mk_value(unsigned long v)
> {
>         WARN_ON((long)v < 0);
>         return (void *)((v << 1) | 1);
> }
> 
> ... you can't pass an integer that has the top bit set to it.
> 
> > Can't I use xa_mk_value() to store data directly in the entry "pointer"?
> 
> Yes, that's the purpose of xa_mk_value().  From what you said, it sounded
> like you were just storing the integer directly, which won't work.
> 
> > +static void *pci_doe_xa_prot_entry(u16 vid, u8 prot)
> > +{
> > +	return xa_mk_value(((unsigned long)vid << 16) | prot);
> > +}
> > 
> > Both Dan and I thought this was acceptable in XArray?
> 
> You haven't tested that on 32-bit, have you?  Shift vid by 8 instead of
> 16, and it'll be fine.

Ah ok.

> 
> (Oh, and you don't need to cast vid; the standard C integer promotions
> will promote vid to int before shifting, and you won't lose any bits)

Will do, thanks!
Ira
