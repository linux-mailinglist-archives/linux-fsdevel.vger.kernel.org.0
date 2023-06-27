Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531A174021E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjF0R0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 13:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjF0R0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:26:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FDF1722;
        Tue, 27 Jun 2023 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687886779; x=1719422779;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SG7/+bGExi2yw6jDSk+TY8LvOSUVjlEfodSH8RX/qHI=;
  b=kcBi6/6GbYsMxsTOdG+1lZYAH7sovEAgSinO7njDruip0S1oiTxana95
   xs2DmttQ7/0jVHviK6sJ51EeUORhDxqUrUNhYb7j0itmu2SOFR12bnmzN
   Djx45ibC6RSC+/EStXNLCbUyOJB2sgA3+EEbHqUx4jvNug1xkAbqjGZ7t
   7FuvxtQXIM97THv09oX1nORprC2tx4JG2/jEqKV8NaJNNSp3kmm2JzKRk
   AC/QPNhePYWraS27HfK2yrCQY1gFRhmTX+E3Vffrd3SOz50AMm5odG4to
   95cD8H0nn0q3G1TtCRkLM1uouCDJw2z/3UshjNV567HwpGkerSRvcNcBL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427639578"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="427639578"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 10:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="710721468"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="710721468"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 27 Jun 2023 10:26:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 10:26:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 10:26:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 27 Jun 2023 10:26:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbFVt3M0dDLF2VQBttkUAB26ShnXtxsqOI2QWaAKN1gmcOfmBScx3pVtZ8u1QWXace10TIWbAlVOIAoP08O7BF5ufd0SizLJH2KysWRDp1WOeyxefeAqY+PFVAXAHB68Lj7ncBWcYh4eyB2yMnB0RSWWfp9Q9Jh1PghdoQuiAFEWns+Hnf0hY9jA2xGrePGhYEMyp+m074zY2vAwsSbhDdw/GZIJPZEPd0V1lBxZuXAGB4v/OCiGifDHoOHCsrFRxRPMnaEQmEHN1zt+E2wrLsSxDgy9I7yOxTxmdZ9YkftibGnghM7Y+U5ACaa5/wkytwA4VV2R3b7UdDi+QvtIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2Ra0oouu59rbBw0mohY2SMBJzmQU0FzgrTQgPVHyHs=;
 b=kHQQrKZrEiZ3+okkgum6FqB4WLopw8217vYXmMM9skOPeb1vuad2G62O+X2K43Qs0yIfKRQV9qPFYiAqyxBAc+ECcvGsBpaimq+OzGV/kJTHGc8DXuyXIuwd3bJ6fA/NW2pamlC5djZdhs046byce+3+ls7s7I+Vi7y+mgaIWSqRH3UA2prHY7gWLHbTRsg1Mq3N39kuVQPZ3ZP48Mdlp7aNygAWBvCpxQwQ0MZ8ibSijS2M0IiQPfSTeeHs2hgUrOkRRBY2Ce2YMDdUxT5/ZHU5sxVfDqxZKd/KwXMIuP/lkZC23tu26Z//3lmJsnu0PZar0D/kXQHP8W/jJ3zWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8574.namprd11.prod.outlook.com (2603:10b6:806:3b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 17:26:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Tue, 27 Jun 2023
 17:26:02 +0000
Date:   Tue, 27 Jun 2023 10:25:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Matthew Wilcox <willy@infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Jane Chu" <jane.chu@oracle.com>
Subject: Re: [v5 0/1] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Message-ID: <649b1ba7495a3_8e17829485@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230615181325.1327259-1-jane.chu@oracle.com>
 <b57afc45-6bf8-3849-856f-2873e60fcf97@web.de>
 <18ca0017-821b-595c-0d5a-25adb04196c1@oracle.com>
 <be3db57c-29d0-cfc9-f0cc-1765b672c57e@web.de>
 <ZJr+ngIH877t9seI@casper.infradead.org>
 <b46b90b5-cc1d-9311-892b-a0f8abe155d6@web.de>
 <ZJsNPKGH903AxDy3@casper.infradead.org>
 <ba6d2b6b-87b8-29c9-93a9-0026ee7ae7ca@web.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ba6d2b6b-87b8-29c9-93a9-0026ee7ae7ca@web.de>
X-ClientProxiedBy: MW4PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:303:dc::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a0f5b3-05de-425c-380f-08db7733946e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fh88OskWjCvj7S/oxfhqVL41S5AFNj1sNvCldngRXboKauwGr/IdqzAsM8TcsyMuXEZLYOMksEnUYzUNbANHcV/IoQlKSLroa9gRy1A2JcRt/WAOypKW7L9tVM+LSwCclPYKzorHxV05xQjyuSEFmrWhRpDfBA9t5GlXmK5Hf6kXyOfLAi6SW8Fijz6D9jiFkbyP818i/iOR9tg/3QsFN5H55BT6gQHtnP1RPJ/MEJwIcd8w7zMUym8FmODvm4AyW40z5i4uJjqITqRy1R6hxmtQD49UAtT/FhoFqKijK4Xk65NWauAzYnbllgGrKLAaEEMdzq/pbMMudGfWLsdAqZaQK6T49OZVUUm5JMqjia7avKiRNb1DczuCMpPrxdvZ55ijlSULZgAXeT4KpgbCCcmy5IMq3boaEJ4dqt0xGu8niyg3SCAis0JO9jPiVRR9+0JjT4J7wuXStW/fH9UdrVa1ExksaKq03u+Ypu5oSbXzmLSwZnO2vjtgofl2I7DsOKK69OmCTg8Mj3J7KXykCU0Elq9HQJ6XRGqEyra1ArqLCOfW9kpK5mCKMkTdJaEJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(66476007)(5660300002)(4744005)(2906002)(186003)(26005)(38100700002)(9686003)(6506007)(6512007)(83380400001)(41300700001)(66946007)(66556008)(8936002)(8676002)(82960400001)(6666004)(6486002)(54906003)(4326008)(478600001)(110136005)(86362001)(316002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ny8m6y8/JSsoHQYm255ke25VuAf9Eqe7wXh3jlrX/C2mDIX6XxppCbCah88C?=
 =?us-ascii?Q?hsMtYWAkdOKC78UwPhS6DG/tvofFKFTWhmKtGTKmPy4CJtWq4VjQFbM7xV5v?=
 =?us-ascii?Q?7JpnGEvXoPwKlx8cTG7GI2tSfj0GunndhjPfXpuWQdfk8f+rUL2a+1sePX2s?=
 =?us-ascii?Q?1juzEk/63XoY8cUACfnSlD7voV3ibD8ypsqpYP4llrcr1AGuz79h3NHU+zLw?=
 =?us-ascii?Q?x/T7dYsF1WmsVM6YWomG62uerEPamgeA/sMHx/eXXSgKrZEeHuaktjRiKNMv?=
 =?us-ascii?Q?breus2Qb9DEsLrqYavIs+LRHvkZ8RxIH+NWMiTILk6WYXfQaG/n1G6JJ2v/i?=
 =?us-ascii?Q?kN81uxrzwnWr02YXxFWGaTIYA0xCTZRhdsyw7Hhl3kllp1io/U8yTCuCZiYu?=
 =?us-ascii?Q?3tQ/EikG7TxY3Dob3ipI8vxVjx+BXqqHXdBUubx6d6jWMwipSU50WdV4oMK+?=
 =?us-ascii?Q?ybLaX29pNpLJnLzYZBn5J0uKSIe6sniLfvulWPMercT4W6t4My3nCSJtBTaB?=
 =?us-ascii?Q?stO8aFwecUAsY1MN4V4B8iiKkk9Qdn91IBiI81JFUbtzyhOAJc3+MaJYrMm9?=
 =?us-ascii?Q?sra3biqyajezaxoDlq8xdJR34x/4TzTJ79fYHuepV8wVqipSnjxy439H8Hen?=
 =?us-ascii?Q?2R5S18X+2sUWAPg9zVOKz/+oO7NDUbnuakw2kPIWVue0/0f3KBD9Vlq2y+oI?=
 =?us-ascii?Q?4HDhZjNqeXhlqJwD3cfKcPKjP7geSjTEgb8uw1KIpgFe9udo6re6VilV+e7e?=
 =?us-ascii?Q?ZzgY7mth79m1XrQ7XiZr4TF1KNJsrN/JHSAw5GJGdt0ATxEX8B9jY48vhKDp?=
 =?us-ascii?Q?7dD1eZVzOyzKNbM6/qFe3K/bMQG38Iz4hSEWC3lkb+yB/n6xrNNq6rBeRboz?=
 =?us-ascii?Q?du6HkGPcCd68BQZKvyOEV2bT8NIkG/rwvzkc+MDBprYxdLJgWSmgTuuneUX9?=
 =?us-ascii?Q?J5J2ZtMEFoUVKWx+A45HW2fDK0bjN3NxSQUeXLKM8rdF7PIVt4s2p6Affbtn?=
 =?us-ascii?Q?r0dx0J0revAb0Tyq6ow0+pw3SYpUX4uDO/BFcJHJZJumuBdjLuGOJDC/Eh38?=
 =?us-ascii?Q?mskLeOqQCDsF5pGxr/bF5NIKdfL0/ac6GH+e3U18h77MNEsfzbwov0AJ4rIQ?=
 =?us-ascii?Q?An7JPZ/HMZ8inyv2A1uqPiD0hYOZmGxzTTm+WAaDXioQwvLOhwMy0bXSYYe5?=
 =?us-ascii?Q?QJDtTOwUXX7hIvM6c8dfCRC/WXb6wtJDuBm4rd9EzbPYIuRPPn/d6qre6IGQ?=
 =?us-ascii?Q?+sllNFUwnZ8Bt5Bz9w/kLdo+rQmD+zRrXdTpdi6pFAb3yrk7WC+4+eNtczGc?=
 =?us-ascii?Q?bSf1HtdsULwj7yCXwXviHSylL6AeOFmP/LercaWrfA1Mo6bg0U1M/W+ox0ww?=
 =?us-ascii?Q?vaSXlZbWJMtQcNtsH1AB5bjBwR14IeT0VmjYqyv5MRXiPnPhO4uiBuEta+F0?=
 =?us-ascii?Q?ykxQ/PGkOEp60XrhizN53Uts86RHqEDCznbz7/L41EgGW8cE7oyjaCO8WA/q?=
 =?us-ascii?Q?vdiDq+EBl4UBSV22eA5HO9cKytGGs2iQ0nwZwFJjRt8JaF/aAFDmIOqqeLVU?=
 =?us-ascii?Q?PdK9QUoBhrsRGuw8mSE8nkG7aFwTGNmFU+qUWGwf1UHz7wgLLzefwF3pEbkS?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a0f5b3-05de-425c-380f-08db7733946e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 17:26:02.2028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9y6rZf0AwpNPpo2I9K1Us3kUSB8oXaDWFYmdFPTvqUBe+7M3NWPcREgjt1Fmtwhf/HuzfrNJIgpQVr3JAZxH+oEhBFO4E20ImkFPSc3d28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8574
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Markus Elfring wrote:
> >> Would you insist on the usage of cover letters also for single patches?
> >
> > I would neither insist on it, nor prohibit it.
> 
> It seems that you can tolerate an extra message here.
> 
> 
> > It simply does not make enough difference.
> 
> Can it occasionally be a bit nicer to receive all relevant information within a single patch
> instead of a combination of two messages?

No, I am the maintainer of this code and everything I needed to judge
this patch was provided. This cover letter only included inter-version
details and anything relevant for the kernel history is included in the
patch itself.

For any code I maintain inter-version details below the --- line or in a
0/1 cover letter are perfectly acceptable.

Please, if the review feedback is arbitrary, as it is in this case,
strongly consider not offering it.
