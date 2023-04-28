Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C2E6F10EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 06:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbjD1EDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 00:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjD1EDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:03:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F35F26BA;
        Thu, 27 Apr 2023 21:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682654588; x=1714190588;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S1Kj30KkTgVUhDfUPthAxeFEcJ6MrxPRtova6/shuv4=;
  b=eGg2u1XOBQErl+xKkkWKwWtf89XQwBhUs346Jb0Eqcc+6l6hm4VC5Xbx
   tVmb16GXRc9IJ7oVlXRTDSkQp6azH7+2cxeA0XJ4c8h+Qmlj5dPIszLE1
   cBkQH1jyAXTrkDaEo2UmxqlxD7NNQQVFuiAMwjogD5b68gIUdX0Mp5g3y
   GEnyY2WWg4FQ5gKIetZt/vZ6vUq9gccXXplZxxqqo3MimjTLzG8Rt4A75
   /JSz68OdRHZagTDEYjeTKP4TRPhmJ5Oi3yjDltlGfcOB+Z8qcv3j/GUdK
   O/2iUujlecz1TbYMpPuf5Vhu3gim8n4H8rVNdwmYSxlpOT5QNXVOTb8iw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="375629410"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="375629410"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 21:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="672010221"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="672010221"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 27 Apr 2023 21:03:05 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 21:03:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 21:03:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 21:03:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJ+ftwD93uZUg1L44akzJwpEiI/HbkQZzT/luAk9BIxy3CqzBt/wPG8NDn8i4d7hYnnfNCeQNJy+H4wibqKO210V4EiOtAPCEOHZZ1UHhDqIHESzkGUPsTCVzsOYAX+XJiDuWFUFEW2qx5/ybCMK97YnxcDrU8C5D5L+W1kEjBYn7+eC5bZIZwwJVwGn3/bJgkvzK3POxjh9sfUASz2tYyeBuptr6F4DpU/6JY/pXmvk/gMv3eZ3vFNxN4K+NAyIwOAym6eULevr0DccsgO5NVd1NdEWgQTOFNvIRQ2uWKiOoAVT4KhRQYrnZWi5OGb+mkIVUi/6Bu98DXtkrUf89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrHXoAPP7FScu5Re1BEupYdyVshrPiyjVDuTLI4b9qI=;
 b=erUWJBs8m/YaYq0AN5N+zcwhXFd3F/+8Ek6sMSWZ9K1BpqMiUZLikU2hbDmHTxfYNVCwSt8qVIdpBSiJ1KYKfys/dNUNLRFD5aFlnaEdplqul5GfTfQn3fBdCt1MP8Wl68WAvXsYwesAM9B5I01N44UtmKKR15dCc+9QFVRJn0i+WSTi12Px3BrTUoVY/Io0/x9nFV50yaMbhwSOQrbQ0s+L9N4MpQficZWhLkB6xlOwLPoV6HWDsC9/TD+gzD0+LgaCihVXBqDEuRjWa5+OYKCZZ37hESaokTpq3OuZKuQYUWl13JvL4B/Ip5ba3UtsK+XS3RJgFQaacUdGFh7n9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7674.namprd11.prod.outlook.com (2603:10b6:610:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 04:03:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%6]) with mapi id 15.20.6340.020; Fri, 28 Apr 2023
 04:02:57 +0000
Date:   Thu, 27 Apr 2023 21:02:54 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jane Chu <jane.chu@oracle.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Message-ID: <644b456e25af0_1b6629475@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230406230127.716716-1-jane.chu@oracle.com>
 <644aeadcba13b_2028294c9@dwillia2-xfh.jf.intel.com.notmuch>
 <a3c1bef3-4226-7c24-905a-d58bd67b89f1@oracle.com>
 <644b22fddc18c_1b6629488@dwillia2-xfh.jf.intel.com.notmuch>
 <ZEs0jSYkMobnFxXg@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZEs0jSYkMobnFxXg@casper.infradead.org>
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: cab0b3e8-3ea1-4177-9d58-08db479d72bb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8Sa2/qL3ocRKiUF+idA+A6KwMcyi010Mw8p0r8IBytMfe/3qDFfwaIIzj5uaGcWlttjFhm9i6SSd2MBesr77/Ado28LVzkjIZhMGfnHFiSzgeOQjnRONlh7p4qROlnM+lS835UC+NoMs+NnnbLs//XRtrpslvJ8b1D/VF4zKdzSsR7l9xFJT1VAwW5PoeLlBFETsMGpTHpE53R6jqhHmRcCDGrDIT+TTerrlUt21TWW21Or8rnCtLPnn8Ah0BjlUAaGXaowJAHCXdSYLHSZs41WcM+7WZmInaHWYhldwoLl7QcYfl5VggkygvmlaR+6+9Xxp69R2i8IkJB1tiE5mD5WaejSRB/+5EUayVVbSCJ57XSo/zRmipf5p87zIhVgT0aX3Nucl0ewUGpEFVDhU8fGXiAtU5xBpGzZwdnUbTO9dGXtkrh9zo7B1F2Vouu3woaJFVxtnzKnuyeo/uc9hZLEu8SvD9SSGq0nv+gU2uh5doo/lZs0CKvvFlTt4W5bVLkIiySgK5sOqCBFlBiU88a8HurPpSJsPlaJL2uRMV8K0oyUm4Vr0+A/R8cAD5YY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199021)(38100700002)(316002)(478600001)(41300700001)(82960400001)(8676002)(110136005)(2906002)(6486002)(6666004)(86362001)(66476007)(66556008)(8936002)(83380400001)(66946007)(5660300002)(4326008)(26005)(53546011)(9686003)(6512007)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jotZPqlXE32OF+8ERC2MH5Nn8mgMdHucegtOnyCHI/09Ly66JXuIO3hBYb0k?=
 =?us-ascii?Q?ofSTC2GCvCjyt6XJRViXUcLg/5nx70hGu83du2ORkdSTxQoXkpC0d9s8tTB8?=
 =?us-ascii?Q?m7Racjayo9ZufNXE8kLfzq94eFeat8MQHuFnIzMVCvc+qyv81F06AGFbpswh?=
 =?us-ascii?Q?mEIEM6cEc451L/AjzMjMcE+Hf22VchcEyGM1VwtLcJyhzfcDFcjuFWelcwHG?=
 =?us-ascii?Q?eTL6cDaHDWzo+XJOm6xiPZavHf2xVdFsCZJRO9d5WKDZmL8UsA3B2dL6Idy2?=
 =?us-ascii?Q?iZJMzZvm/P/QUG5gHpmbYhawdUDRv1PJxA5rt657IG3EkbMBIpyDP1GdTXZi?=
 =?us-ascii?Q?5ItOId6Z1Qnx7UMQyy0eWBISmvRoSGhbregDArn2e76IF7owyA2BDfy4ciwC?=
 =?us-ascii?Q?qJ45bKBHd8Ge78Je6a6+8Ej5Edg+M1BL+FL4KtjclbDvlHUi/ns1/RjU9ILu?=
 =?us-ascii?Q?5UBLDHW967cKJQ07ZBwfHRMePy7qHlHWQBm50PEdboQ2XWxZjf2jrAwAc0O2?=
 =?us-ascii?Q?t5lmhtDyM2WZXZhLdjBQQXmTnzh/H7FNBHnBe1upueiCom9OYQk146Is3Z+N?=
 =?us-ascii?Q?c+tIyUg6pKX7mT+U9uK7j/B+QRb1gr99cPbgCJMdwEpsx/JZ+mU0mscEg7PN?=
 =?us-ascii?Q?flQrHKImEAoR3KPimIHpvtNbKEw50Yoqe7FRQM6/k41hK1/YnhrZ9ZwsyMir?=
 =?us-ascii?Q?UTDeo3jODZlIigsZAD+jTlLIgpYYJePhsrWdym5NPM2GVbAFOz+Gv4FbOFOX?=
 =?us-ascii?Q?nSuGJYElK/PRHN74fbTdpeI08wf0fOVjumOCzwSyzBgGwNThkFEqZ+okmTg4?=
 =?us-ascii?Q?max8E0M7fQ22aSSdnumOueiwA1ztIePLvGxHFkpJOuaX2D0/PtFhkHAf8Wh2?=
 =?us-ascii?Q?svGzkiwtqbrCdW/FiXSw7zyYYOo/T50GyVHaTj8Ey34c3bd5cuKGsIbAVL+Z?=
 =?us-ascii?Q?9skQKjTZLuCF+bfwsvM0nQDGngmPHp7M3nOIScge7+HppoFU12wlEa0DMKbd?=
 =?us-ascii?Q?weN+BlE05n9ZyY+qVv3dSLCHbt0CuHuidWZjY5QGP7OTblasySvdUfIx80mF?=
 =?us-ascii?Q?KVNoxG8QSBopijjOo4VO6hrTDBFi3ySOIYIldik6XPvyADM9SJzFdAmz3H/i?=
 =?us-ascii?Q?Ph2oxNuTbgR/q3vQxGMLGyobAHtILbxN48cNBIauAcs4pfC5P/4G9Rn/Wv0w?=
 =?us-ascii?Q?CNem3UYvoBNJsdrXkf3EJjXXWqZENqr7Kl9vnDhaVRlbYRyjARKkVjGyyFVG?=
 =?us-ascii?Q?NY3eRfnlHFYUnWlS5H3xt1xl6bN+6GvFbK3TPZgyUqI2v7hsfX5ILGGWSR1Q?=
 =?us-ascii?Q?EO5fhJWC0LbH/aVuCv74gBzQ6m39n50HifHDr9mo+XvEbIf/KfIymY2XB1ix?=
 =?us-ascii?Q?3PNsnA0tWpy657mdqU+Q6YtfI4XWegKwCLO314a1qGVbQUeoG8n4u1QEsoYX?=
 =?us-ascii?Q?CplUbl9xgs8YkqkqcSgQ87I1dg8WD/81wgkt4JytLyCYVlQNlQY3H6urzO+W?=
 =?us-ascii?Q?nWDB1plApfhxQw/aJOu1fSYLuU9tVjOHj/CpN2UJ+gb9E4v5cJlUQDxRUKmc?=
 =?us-ascii?Q?+d2nU/uuqsc4eYMrtlh1unErJQbCTr/wHv+SeAbG0rE4J4Sb9LdbBDX8KjRU?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cab0b3e8-3ea1-4177-9d58-08db479d72bb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 04:02:56.5642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tstkgfy87WlE6PXfDZav5xvJudVA/ZQBxfQFGf2jvkh0aZsfwTbRAISLwnOzqOt1h5JUZgrswkgrmFs+96VMEddIAlC/ls0bpDp4Ug6qaLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7674
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, Apr 27, 2023 at 06:35:57PM -0700, Dan Williams wrote:
> > Jane Chu wrote:
> > > Hi, Dan,
> > > 
> > > On 4/27/2023 2:36 PM, Dan Williams wrote:
> > > > Jane Chu wrote:
> > > >> When dax fault handler fails to provision the fault page due to
> > > >> hwpoison, it returns VM_FAULT_SIGBUS which lead to a sigbus delivered
> > > >> to userspace with .si_code BUS_ADRERR.  Channel dax backend driver's
> > > >> detection on hwpoison to the filesystem to provide the precise reason
> > > >> for the fault.
> > > > 
> > > > It's not yet clear to me by this description why this is an improvement
> > > > or will not cause other confusion. In this case the reason for the
> > > > SIGBUS is because the driver wants to prevent access to poison, not that
> > > > the CPU consumed poison. Can you clarify what is lost by *not* making
> > > > this change?
> > > 
> > > Elsewhere when hwpoison is detected by page fault handler and helpers as 
> > > the direct cause to failure, VM_FAULT_HWPOISON or 
> > > VM_FAULT_HWPOISON_LARGE is flagged to ensure accurate SIGBUS payload is 
> > > produced, such as wp_page_copy() in COW case, do_swap_page() from 
> > > handle_pte_fault(), hugetlb_fault() in hugetlb page fault case where the 
> > > huge fault size would be indicated in the payload.
> > > 
> > > But dax fault has been an exception in that the SIGBUS payload does not 
> > > indicate poison, nor fault size.  I don't see why it should be though,
> > > recall an internal user expressing confusion regarding the different 
> > > SIGBUS payloads.
> > 
> > ...but again this the typical behavior with block devices. If a block
> > device has badblock that causes page cache page not to be populated
> > that's a SIGBUS without hwpoison information. If the page cache is
> > properly populated and then the CPU consumes poison that's a SIGBUS with
> > the additional hwpoison information.
> 
> I'm not sure that's true when we mmap().  Yes, it's not consistent with
> -EIO from read(), but we have additional information here, and it's worth
> providing it.  You can think of it as *in this instance*, the error is
> found "in the page cache", because that's effectively where the error
> is from the point of view of the application?

It's true there is additional information, and applications mostly
cannot tell the difference between fault on failure to populate and
fault on access after populate.

So while it is inconsistent with what happens for typical page cache,
but you're right there's no downside to conveying the extra information
here.
