Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9CD73CE98
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jun 2023 07:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjFYFvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 01:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFYFvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 01:51:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5C2AC;
        Sat, 24 Jun 2023 22:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687672309; x=1719208309;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=ePH3bQ0xqEhLeKjArd3r8GW6oA7uzKMXCN+a/HHYU0Q=;
  b=UzTIvj6ffLG+fJVT16A4K8jJj5zMtfXRnn4dGkqhe9X8NcVkvbrjwDK9
   umzZPdery6G2G5Y3SPPvHwM0bjtV88j1VCVsFLVoFYeoiKwgBm8A6q0n2
   55dUiRA2zbkXy2tbVAqp7Ovkx3frEps/my2zQgi/pFKotiKQgOaGbjb8t
   c4FVJrXN3JuWTebLw9GKqKpy1lcP7VjLz2NOauJgjSku4pnDn2ZAdN+BI
   wmk2GBU1ips4ltnVNAwHmF8m6xpPEetxJ3g0rxznR81tGKyg/1enhbo30
   VxeW7ECqLOw1aGPOLW/IpU2mw4wNEKqdoe73EWeIBD6HpMgT3x+n0+3cX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="359898631"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="359898631"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 22:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="1046081125"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="1046081125"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jun 2023 22:51:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 24 Jun 2023 22:51:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 24 Jun 2023 22:51:48 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 24 Jun 2023 22:51:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+/qmzSC8IfUGk0LbVfJZr4HRiOeiCZIzWxGftprmRGfMOIa0Ujk6vs4X36t2fsS9T69ewxrnGQGhHJ4ylikFfSF7tnm9jNyUh7mvC/cLLFuc1l8SMXmYplvttgqyRN0Wk5xYhGktCrDE08JyZcMRTqQkMLbD2BAthPqnNTMO4WZxe8EyTwIkSOnfhQc07aZzmPeLqBmfg5R/swnMyWYOW6buFsM93h/HLSkAlWhCVBKPlJmLPGMOglqJjx5JpMyEAxYNfippF9Dyt2NIx1CRB8S8t58QvQT9vn0IlcNZ/RXaQKRyLWFOAOvmbyXCPBHAm4afs3oXrKdkvRbzhtamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMzX9VY/hoxvi4pGJ26AW4l1NTeCRFlTtze2FciUnlQ=;
 b=aMSDidrPZHu0amYkHXskKS+gXy8MmQD4lGTpfbafiLHE9ysEQy3zH0GAMSADD1BryJV5MLpQoKLKIqHZs7SzKZFLf1T1Pd3bRHVNR5h5YebaxnKgRFhCypgJY1yEE3J3TGbngcCUHndT7BagNsmC1YV4F5MVhZC1tEQZmOP9Zcux1vnyGQvwrCrLHtQ5iBRP/fSDJYDjxOegmmCLIznuhjDI+0W7z1PABc6PvWPxekCGgmCrYFgR5CibqnrnLgh8cpii/gjSVbggMdDGy0+0yFeS9jHHKJuYoBOhxMI372Uks/IYXuThvn/mVpga7xhnMPmOqLsP1BUiWH4LoOpClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Sun, 25 Jun
 2023 05:51:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sun, 25 Jun 2023
 05:51:45 +0000
Date:   Sat, 24 Jun 2023 22:51:42 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <willy@infradead.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v5 1/1] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Message-ID: <6497d5ee65a8f_2ed729471@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230615181325.1327259-1-jane.chu@oracle.com>
 <20230615181325.1327259-2-jane.chu@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230615181325.1327259-2-jane.chu@oracle.com>
X-ClientProxiedBy: MW4PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:303:b6::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: d9aac3cb-3377-474b-0d9e-08db754041f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eI0A+Fb6hLLNuU1vx2O/utom15s0kR38Gz9DQeQfhUpW0SEepdDfDp8Xxx3ZsnlIVgZNzL4h1epDmvBAxERf1rqSB10XuP1QUmRNrgjuirymyo/+SL/UJBZHmoJKnB4L2KIRRB+sGrBKsqCxCRFnY7PsKclX0YYIT/jXW7WPRtOP/cyp5k6986Kfpg5tlNljqXv8kEU3V2cKDEkSfwwml5gIn5eaxGJqq89vJmzoxsfzg0pwYMO/uD5ZuKKwTtTlZN6XCKtHfsRCodbIOG5uem6Okoa3XHx23ptxHAtr7Tqfi2v1sdAaGeXwsfs8jEWNhV6zDMG8M4xRQa3OTcNtXhSrELQpvKtIOEGddowMUwaIs2ox9T2Oqig7hvyJbQgLekxBpFZf/7ZpP1QuX7w0xnbi3tXY6kWATY0FdK5rKH6r6k0UeBBL5vhbl0woqt+qjSKw2IyBNse3gEvNnjKD7GTEUamZXWU9/wV8tkPg4qV8k+vibWqO3WTSYDkazKsMZK4GDLuIPhqmtJT5KFum9Pr9je0pjG+xFoZdY8lLiB5O3G9Q1QGhYag+scjCOQm5QsU9BRb+I250WnTf4cZZzKfCmlLFEH5yIsPCTZrMOb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(8936002)(8676002)(66476007)(66556008)(66946007)(41300700001)(316002)(6506007)(9686003)(26005)(186003)(6512007)(478600001)(6666004)(6486002)(2906002)(4744005)(5660300002)(82960400001)(921005)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vlPPwaJK5Uz4ycyT6uuazA8db6LbserTlUr8/bh3hUeAEfWKFgZoID9r4+cw?=
 =?us-ascii?Q?Ur/0H5plRo29yr0tszB1ZLzHLl7HuIzxTh8d9qjWg96Vx/FnWcs0WyAKtfD/?=
 =?us-ascii?Q?G178mf+8zjxviNpL6x+EgiwRP0Gt5gPx0rRnG+DatE1R2U9iFR6a24ctw/fT?=
 =?us-ascii?Q?Weuae9rAP8Q4Udu9C4gm5V1VUqTj6vIz7udsMM2l4+BL8y0wLsHAi6nuCn7E?=
 =?us-ascii?Q?wZhiXFQn989cuNPaFnkblczw/tlsBrUvzTykI/OqzDe8SO+Tg+W4KO4awoR4?=
 =?us-ascii?Q?wIWDzxw9CGA5drQHc1juAXzLlYjXRSJE7OFOMJJQD5xePoLCmCIJz+KYn6hq?=
 =?us-ascii?Q?xdhY5zUYO11syTavDs5AGj9fdsndOMt2wFJ2sS3zuwXBbrdDdXutg3yGTIn3?=
 =?us-ascii?Q?H9KmUXnC/EXF23q1HzsfE3pHMr9g/A4pJBo+RZH/3PL1O0pNK36vutBSHSC8?=
 =?us-ascii?Q?y/XIIkde7hHGeHnduUs36VVcUL3gc4y1O4QEG5FxWAhitVgrJnA5pazUBxtz?=
 =?us-ascii?Q?ZdL8SwVjPPJtVZtnMTzj/G2DD+Lyv0K2Z7P6/b87EpyCv2xzQkXMABYZ2VUu?=
 =?us-ascii?Q?L7X0cfSTI5dTpAbE4HYZM/WcODlzXqlhhrapIL7yjG03ilsYIcCTnbhz8Frm?=
 =?us-ascii?Q?2dsC1s4zU876pqCX9WZwndfhIYYDn8VcBtdz3k/U9BzIurkyhNUd+LxTEBS1?=
 =?us-ascii?Q?1qeeOcW0yl6Cepz+7WVaho3ke/7FZcGC42GadTNmIyj1Ar5uZPhgWmzJDlT5?=
 =?us-ascii?Q?3+YaxL0TjUriZZoIqAki6O5cnJyh6mkn26i45o0+Bt9FLsbhgYth0TVkgwfh?=
 =?us-ascii?Q?KezI/1eLnmayVtDiBWIldRJZZQi3LEO1A9JA4BlPciLQTj1YhLDSYa/E/T+D?=
 =?us-ascii?Q?/GyZE4EJ7RDEtkl8tMyqViBTik6KhIOYjTHmnK2ClmumLe9V3uC1+NtuDgrC?=
 =?us-ascii?Q?7LC8T/OmRnpkfap2r2sc7SSZsslmWauaIImO+EV1QG+PXbiGHzh24M8CkZKN?=
 =?us-ascii?Q?0BxRY0YSNaAKb5wPzQFp2WXJEkpCqjzYSoiR33VAU45RHNj0Jyl3781QBL10?=
 =?us-ascii?Q?+D1+tglaOGAPdE+8ng76fF9oAqg/DL1I1av4kOkzMMVQEesrHrywf7g1+Abc?=
 =?us-ascii?Q?Oz2VnCNVT4JUfM1XAwiBTOTTVwKtZ8t2BU/IxFl0n08YUWWCEd7YymW8/ooK?=
 =?us-ascii?Q?0RVe90bGOw+AMT1a20arXP2624DgvI/+p8UTfHgkt1TDk+7JY09xtBN+kmmO?=
 =?us-ascii?Q?MPJt0siJ50lD8U2bU3pH4c1/cQqHdPqibAhxADboXdq2OoNoAaZPaCWj8GgR?=
 =?us-ascii?Q?l4CDFyrjws0YnfZKwqeq1j0B9BHWRKMAXnahIiWyUwigYNcznkDN3LgKPVnt?=
 =?us-ascii?Q?MZ49qP6jgrIox3xqKU9WXbKgbZiMY+7a6EyVg6+gEV6T7RrTU6rLtSAXljSY?=
 =?us-ascii?Q?8NTiZbNi/pidZCu0VnSOeRxcFXDTGr3Yv4mjq9tC6HjujQxkI25a2JNce1Ru?=
 =?us-ascii?Q?rtWrY9fcow43Nl2frsRGsCoIgHu/E9xOdn9ts4yOVXVepi1SODAtHgLiK+KA?=
 =?us-ascii?Q?QbuuSp4ogT8IcO0/R1H3+QdmfJepXKzDTsss69Y+oPiaD4wGeGkQCpJWIbmr?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9aac3cb-3377-474b-0d9e-08db754041f8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 05:51:44.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdWGMFXgxicjHa/leTC5TJ7P2CSt5r2N2X1n7TBfzgp9ICpJc3CtJJmMSTM34RCu3ERvRR7TziZFL3NPEkNriz5YqB/qLXcI8Ovq1F1KaWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jane Chu wrote:
> When multiple processes mmap() a dax file, then at some point,
> a process issues a 'load' and consumes a hwpoison, the process
> receives a SIGBUS with si_code = BUS_MCEERR_AR and with si_lsb
> set for the poison scope. Soon after, any other process issues
> a 'load' to the poisoned page (that is unmapped from the kernel
> side by memory_failure), it receives a SIGBUS with
> si_code = BUS_ADRERR and without valid si_lsb.
> 
> This is confusing to user, and is different from page fault due
> to poison in RAM memory, also some helpful information is lost.
> 
> Channel dax backend driver's poison detection to the filesystem
> such that instead of reporting VM_FAULT_SIGBUS, it could report
> VM_FAULT_HWPOISON.
> 
> If user level block IO syscalls fail due to poison, the errno will
> be converted to EIO to maintain block API consistency.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
