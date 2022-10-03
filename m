Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0F25F3651
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 21:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJCTbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 15:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJCTbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:31:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAAD2E688;
        Mon,  3 Oct 2022 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664825506; x=1696361506;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T6+wMQAvssfIeMBFn7auyJqXxteJWViHj09jzia1leE=;
  b=ArvFzt+JZYScNOo5t7VhmYBql+xXhuiOQBITPc+/aIRiLGu+HkfaGNmI
   QLznkFk7x5AGmk9GygWL+ekOAqz2N2wgr+2FXJuh+PMv7bHkSnyJEw13W
   Ol0y97us0NfBKy3PXK5X/GYRVzei8V4bkkB79hR30QCedXCAXaUL5Fkh+
   XZfZ2pJETRTZG2RvGpR9o6s3aHkGX6c393K1nwkZo8t3jDDp2UC+TYO0H
   Xl9oP0qG/Qo/pHZRfBjiKYHTiaqHR18pidiJK4Qk+w6VW4upaPsE6AL5Q
   2d2kVBrbSieT7hxhbfS4kk9IkHZignnwbC7c5447qiSXgUCFVA+TeIrzD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="285932887"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="285932887"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 12:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="868737780"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="868737780"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 03 Oct 2022 12:31:44 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 12:31:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 12:31:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 12:31:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPVAwp9j7Jz87wPtOf2J9l9M0d0lODQgRkIejrCXQN023NJ1lv2iRXF9oBqXowGJx8d6kiWVNYXHkscBA2ZG4wrWVfYo5wZsIVjuZsn1edZwwSabH8RuGphYrwW67mbeN94VWXzWu60IxTRVub8FQfdWYtso255eEFG+1XOMv5D+nudpi1uyPdZ5LS+HI/EZkNqEZ65aqJswpQzJ+X1G4us9fycAwYvOnk6adt4Inz9fWFepq0PqggoKMWr5Zb8d7g7gBXtRDirkYB8uF6qqCKdYocEyfRvtnCzW5oKZoSCfONz2ft7EESpmQ9fCckjOtTksQ4F6q+BCtpUkxkLL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0KouMpsIOfrio/v2f6IGQ/bTtI/Vcb0dLa5bLueqyQ=;
 b=Lr37w/vkyl8gXgo4x9O9EkFZqsSRmRm1pDwv9AYRYvAzDNrRd7vtDwJbsOpt92CdicP4PJk8OuEqifmT9QgwVPTMwYX0yeczqSWnXB6UvMVenEkLsk/aFeZ3s00BBZK7JGmc9+TLRMDo+0/nxF5U5s2+G5w0nQLYdYHEK4pU1DYHNDJulvvxdBG09Jh8h2j8v+gUTm557+faVcX8jfcqzsN3szfNKFi9IXzZDcmWjPVqc6DlSA+Erzd2qD69CUwnj1+xzjVI+gZZ7F3TRAp0kdio/43Z3fPRj0KkGEtOChSNARCrvwrqkNTBCmeXzeJ9stQMN9F+fIXO29aQOTHSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 3 Oct
 2022 19:31:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5654.035; Mon, 3 Oct 2022
 19:31:40 +0000
Date:   Mon, 3 Oct 2022 12:31:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on
 kmap_local_page()
Message-ID: <Yzs4mL3zrrC0/vN+@iweiny-mobl>
References: <YzN+ZYLjK6HI1P1C@ZenIV>
 <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3>
 <7714.1664794108@jrobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7714.1664794108@jrobl>
X-ClientProxiedBy: SJ0PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d87c5e-a9bb-4aec-892b-08daa575e57e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zO9Aqrqr7rKEDeaVvjigd9TgYWPryM8lYwJrB9TpP4WxAZcPmZjgvkygcadD0jrZKlzWwmnsRk/qDolbq7fLwEXTp7fXSc9sbzmMYdh1ZDKATJG1xXT6nJMu2wU3ZUcfzcaIYuXRnH9qz+ffCQgGX5g6zh+qikVkph1qx+Tna6PbMSA2Y2b0ZziBhz7Rvmmui7/QpMjxPUnFdtUMWH5VtJQIpamcntnCHYinU4+WCkK89H0ozsOjVjW9SzRgbhBbaPWftYTGr7/1z/sgxM4mArHYdCg7hmpTAYYQ9dH9lW8mspS7BLOjv9gtjCr+XGTG10Ex85WySc8XwTy+C5Nc00I3WtQSGiwzygceLexAI626gn+LhO5yBt9L8NdUE5Jaa0IYGf5/YpJ1FjMYxZFQK8pRvo8clrRj9bJO47V+Cx84JPKqrsI1S6oeaL/+uTlUtx26wiQ48dtOp5676ovFxTjylWrT5ss9tTRRssPeAU8FMXcUtMc9jGI8jYLgJJ6ko3ZPXVLQNACRc3bAfpBAkAI0aDpcKDIdl6+WKp4ZNIX12BLL1jKibQejeHn0uOYoR8+TUeUr8A6aPjfk8QZ7WUnmfKiA8/mZmFAkc2xobAlsTkoJzeIFjHxXpTxfiMIEqFNlEZJ77rmkl57Er3gGve0IX3eZxWqqmW/FV29tNaP/zYaEykGv8uNy6cnXep3VBAxmSjowJCc9FtBMcEj2y8OqtyZqhkIlP2o0JoSddTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(66946007)(2906002)(44832011)(38100700002)(5660300002)(6486002)(9686003)(4326008)(6512007)(478600001)(8676002)(6506007)(966005)(26005)(8936002)(83380400001)(66556008)(66476007)(186003)(82960400001)(54906003)(316002)(86362001)(41300700001)(6666004)(33716001)(66899015)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RF6EuDME7UFl9VhUa/qzFglKMis3c/UOY2fc+youN9UL91oe8tD80rtwsuiw?=
 =?us-ascii?Q?0JeFn2VlTiPl8vNR/rwdbh8lRANvlI8N7HiEQqItOccNDZoISCAuNdwXIE9p?=
 =?us-ascii?Q?vh5dp2GOasNj0T69pYG8m/7EtbdQgFrofvEDSK9uXKMbhy7uWQj4X4hOee+k?=
 =?us-ascii?Q?OQxlAumXyxrlPvp2lcEmPPHD1ki89Dhhyt5bV4PnxLRIgV/63gO5/GaOO51w?=
 =?us-ascii?Q?oB4kbMFcP/97bII00FJ+2imtVWLudy721SwQ7YATiYNxZdWFyaU0pZ5EvPhG?=
 =?us-ascii?Q?SZqUWczA5/dk19pZcBctvGqYDTp/dtLSrEQry7CcWol8QCuNMBoRbB582yNy?=
 =?us-ascii?Q?NsIPPhShH1TKWI9oBqcJT6w7bX8B2Mw6lRnBx5Mtr/b0QjQykyB8xT+X0CZ9?=
 =?us-ascii?Q?cnWXQwx/YaXoO6pHVVOwiY2lqhOUYqqN1WqPIKWl0AgiYuwEa3rwCOZ2dsIi?=
 =?us-ascii?Q?E/qhsf2q00xaCdKtW74Xf6u62lVX+M5P2IUW6gCc9g2o+4pgv4wh3FD3RiiM?=
 =?us-ascii?Q?cwapD4plQ9dNaIubiR//p01dtjLrC1ND6snwewQIoB34oizeYXSr4BucOImO?=
 =?us-ascii?Q?BdkJHNqh5fBeHtHbRevnOiJE0F07S5nIcSBO+uFJ4vxJmWhKABdrCRvbDlsF?=
 =?us-ascii?Q?Mmnf3HFICX9Zra0tj0gIlNceHhlvw+wynFiuT2iJa+WXGoxuXVsb/X5UIHSI?=
 =?us-ascii?Q?reu2Rm5HNmi6gQKpcRs4QHBq6d8GcIV1x3oZPnbFpgw4ThZfd40aobWS4vu1?=
 =?us-ascii?Q?6sONmbmmEEvfPo4MO3KpcA6VZGX6jPj+tyN5RLOwmcab4+HuqE7V4hDIBNUw?=
 =?us-ascii?Q?1nSm9t1sNae0dRZoZWXIlA/l46F71WMKE6n1CC9T81P0Vb/iBjjyHSQg4KLj?=
 =?us-ascii?Q?MzlFO2asuSlN/DNccjOr4s/sQw+OF3mgL4Yax1dyR58Fuu0dBpCQMqhDh5j6?=
 =?us-ascii?Q?Os06ZMwtzbQJowjhC/clKcpROIOM5IkX/nIj7f1kFiUimGdFu35G210ziqY1?=
 =?us-ascii?Q?9UnroTtl6eEyPUIWIOm3O4Rry11/JVRBd7/0a3F/noTNcVDb6qhiCZayFUTL?=
 =?us-ascii?Q?CFWPmd+d+8atSSIyKsfxkBj/6M/lYnzsxKicjxg3lt5RZC25WeQxfZy5yF4R?=
 =?us-ascii?Q?unY3+4pS7K1rYEStOBucA+0ImDaWW3p8r2S5s8wuFWxGYZcFx716DKnMaOjN?=
 =?us-ascii?Q?V/4c/PNtBy6vW7fGavsLb/PGEazd2G5Umf0SHJbVyDLZVrYBVbMmOKn7Mb9a?=
 =?us-ascii?Q?q22Y4Grtcwvw3qElpPBomSIshgr0YpHJYrrZ29hw6sAEe9BnizZzdNwoKB9U?=
 =?us-ascii?Q?yfqiq03Z7gbgpzevNErOnjBHUmYvfxFCO8awnL9Bgql0saN3b/UTs/NsOmxj?=
 =?us-ascii?Q?EUAX3Ck1CKI1K8VMmdlBGvADqTiGC57dCTeVB9OaQHdjq4JQCFLjctY8NeDT?=
 =?us-ascii?Q?2TvM3PTvANxcMdYEPQX7NHarcinCSaskzsC286wh15M7VIjPZGQcJ+9HAMKl?=
 =?us-ascii?Q?2fpRZ+KO9wy8UQj+WhK1C+A9LA+MEDAmKf5SjSXxJnBSd78YkSRBsqja+ngl?=
 =?us-ascii?Q?gJ2sxzdUejYLIXnCkB0ICAQzjvaBFXiAGGg/bCeg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d87c5e-a9bb-4aec-892b-08daa575e57e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 19:31:40.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4ZTEptTVgkclaGn4wiZogz6hFjrU6pvkzMytpD8U4ItqAaCOzRHcyBM0mfI7mRO0bNrMmgEmpU7euKbb6WVzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 03, 2022 at 07:48:28PM +0900, J. R. Okajima wrote:
> Ira Weiny:
> > On Wed, Sep 28, 2022 at 07:29:43PM +0100, Al Viro wrote:
> > > On Tue, Sep 27, 2022 at 11:51:17PM +0100, Al Viro wrote:
> > > > [I'm going to send a pull request tomorrow if nobody yells;
> > > > please review and test - it seems to work fine here, but extra
> > > > eyes and extra testing would be very welcome]
> 
> I tried gdb backtrace 'bt' command with the new core by v6.0, and it
> doesn't show the call trace correctly. Is it related to this commit?
>

Are you also getting something like this?

BFD: warning: /mnt/9p/test-okajima/core is truncated: expected core file size >= 225280, found: 76616

I did not see that before.  I'm running through this patch vs a fix to
kmap_to_page()[1] and I may have gotten the 2 crossed up.  So I'm retesting
with your test below.

Ira

[1] https://lore.kernel.org/linux-mm/20221003040427.1082050-1-ira.weiny@intel.com/
 
> test program
> ----------------------------------------
> void f(int n)
> {
> 	printf("%d\n", n);
> 	if (!n)
> 		kill(getpid(), SIGQUIT);
> 	f(--n);
> }
> 
> int main(int argc, char *argv[])
> {
> 	f(atoi(argv[1]));
> 	return 0;
> }
> ----------------------------------------
> ulimit -c unlimited
> coredump 2
> gdb coredump core
> bt
> ----------------------------------------
> expected result
> kill
> f
> f
> f
> main
> ----------------------------------------
> actual result
> ??
> ??
> ----------------------------------------
> 
> 
> J. R. Okajima
