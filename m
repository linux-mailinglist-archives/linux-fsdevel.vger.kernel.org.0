Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC06741E0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 04:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjF2COI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 22:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjF2CN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:13:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EE130C4;
        Wed, 28 Jun 2023 19:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688004823; x=1719540823;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KCw5v6yYPEevA+8tDWEVbKGLvtQ2GsYVbzNdHYMMNLc=;
  b=lB4M4YAzpIO+LbcYUafCJJucf+UIYVp3qBhGbQz6HfgTeTmRvevGPQfd
   95KPMhYwRgwSjPHkrVFfh/dO5tzv9os0/RRfTxb34AROVG8AxZD+SqGaT
   kvGRH4VbN7DUHJKEnRDxOH4Y0AKYpmH0DtTLc9hwvm3kfsXppLQ+IzYfK
   54MYcMR2sFgmA8FaFwcOHYJhsa7rQASYD5aCwVLU39EHvPwNATmjycPFC
   HpWPaLPFHDpNdnjUejhLGVVTfxOF/Op4Oq8oqUM3gruU2e1YEasdXUXFr
   4HZzKfoItbITv/AWx6FJ9UOpZrvfhRsxIJEP+uYNR/k/mi9KyqmhJ6Oz6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="428022226"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="428022226"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 19:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="963831311"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="963831311"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2023 19:13:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 19:13:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 19:13:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 19:13:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF+/KT1qRmKkRi02IvlHU7Zw1+yTn08IHyk+u/vsNpgfQ08mReJCYxsGpqdBWRCqrPJtFRLmO20ncGgjXU7StUscJhydIN7cOqvO9A453AFzaqlb/ipOXrz6SRFG29FExOKcqqUyahvMt1+3/NGlvEIcMP7fJ+A+SDXrFHmp1ok3uSL/isp86cRVHze9uHPhO8vPxEpsjg7cSavdKj5NzjGBudA13LHxhqaJZxA0XZW1ZXk2O9JibjM9/Qzjw2Irh+u3IChiXGUCFY4qo7WcFo9C+VUOJsspTsC4z+aiWn8AzfOA/dPMRRFJafFdNAD52pmWcMZJMPz7QvbUvBZEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg2rk7CHMWyYprzWfkjxlYB6/TkEYecxNA/ZmbINVy0=;
 b=lpWozFfazE46VXAOlOHKX6mgF+pcXl+HlRjSt4LvUVaZ3BahUe45ODxVMvZkngAbhQJdJsizHbl/J0n5aMONWkLAV62fnUUGRhQDuwEdlnxm4DM2pL0aRPwmDS5FjeMY7LRaNktXOcWrQcXB77rTSzOj+BSmwYWy5N8eGvyDW3S5pMY28/GS08CaHIcxiV8l0g3Sb9sPGrgqXL1STPJKKTN6xyvTw4SFLeUd6eA/2n90fCeLe5O1+oUy6hJRvGIEgFzQC2Czy81rEhwwKtw/Q/rXh6s9NEbr/CEU3AyuLVSE+P9Y46SAgixwQaUx+8eB877FDmcoFvQauA6IJciPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 02:13:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 02:13:37 +0000
Date:   Wed, 28 Jun 2023 19:13:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Deepak R Varma" <drv@mailo.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Message-ID: <649ce8cc8375e_92a162947@iweiny-mobl.notmuch>
References: <20230627135115.GA452832@sumitra.com>
 <ZJxqmEVKoxxftfXM@casper.infradead.org>
 <6924669.18pcnM708K@suse>
 <2882298.SvYEEZNnvj@suse>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2882298.SvYEEZNnvj@suse>
X-ClientProxiedBy: SJ0PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac830bc-8c0e-4346-c861-08db784672ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzaXjccjGAwHRl9HH0bLEPgB0B8w8DXQHF3xXZB9s/PnbVkeAgzDJv5ayrFhVrspwMTHZQrXer3LQHeWQvtvc+O6YRMDWdys0wbYBp1n32e+N+cX+9d9IxYbsoOUgutjMG/pgFc/CJHNxfqFmN9XD53wAIhm/RizCCbQWo34keKF8kIAi+V4hjeIvip0/TIDKZjeZpUQvzY4jTovNCM1dgBoNjpKs80mDI4Yl1b794OKKCxU+laIMySjZmuGyWv1O+Ez8kAWO8vtntEFpBDjv47nWuqG+W6wy2c9+fUemy99fOaF6JZ/Qvd9ClzuetFWnx3KcmDYmveO79y0eFS0oFtZxd0Ascv008YKdrq30NvAgkrmeH7iGDDcTtxuwrJojB1RaoHsw+/z+VJKtV1KFVfoiZYIOfS8vBbXtHhAGW98EqT2hStDiyumWzgNC28WoOoL5gpjq57/KqZ+NoQijwOhYTpNZm/tVG11wp4copD4AIZArXwRtJUckWjqx2zCCNZ7QCYwZL3rZVj6qnqZ2N4ebNQL/F1FqwEYc25ye49eRoEFNn3h6RGuoqKQ+PIG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(41300700001)(9686003)(5660300002)(44832011)(38100700002)(66476007)(316002)(4326008)(86362001)(8676002)(66556008)(8936002)(66946007)(82960400001)(6486002)(26005)(186003)(6506007)(2906002)(4744005)(6512007)(6666004)(54906003)(478600001)(110136005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VGqqog+k33RergG5XUB9WmEcyVR1BMzhnIfiDR4PdZKeHcSu3G3VddAqf7?=
 =?iso-8859-1?Q?lfcMQdBt/3rYntcFyS+mi2RfSABURNFwFH321A9iMNzye4WCLtdfXkfpNm?=
 =?iso-8859-1?Q?J09pFk/Jio0e0uxzW4VYtPr4hdhuAR7G3inhEV1auOzc6gutPeAmc6c33j?=
 =?iso-8859-1?Q?zXqO2cuytHjR2zbyNzm/W8tkyC/6AceMphXEhmPEg6w7GDEwsEURIc4ueZ?=
 =?iso-8859-1?Q?WksGvCVyOlg11Mj7RAHry4eyPvNzQmZa2T/AT8LOI8eP3QOiWuibXIFw/+?=
 =?iso-8859-1?Q?CecjIBfAU2WV6PRyC8cEX5FsZgel5QC0pguHcu8zVutZUWRY6m81q2kGxs?=
 =?iso-8859-1?Q?nAbUF2JHMfY1ahCnrN7AlkwYQsZzj54tDoMh4PQDsaQB7Zj/fmWkoSlpbk?=
 =?iso-8859-1?Q?ZWDlMmHTVmQ5TyMyC2rwXdHXtZhuExcibM73pWdpIlBFbBEz5/FnsC0j+X?=
 =?iso-8859-1?Q?VnuyBXKpgGEtVulkpHvYsZ9OBRyMEZrboi/phvmlIKwlw1Zyty4GdhAaAu?=
 =?iso-8859-1?Q?ymjdgupvSRTQRta5DFfTOdGt7r1isHqmq1TgJYEvufiKjgsFZuZgkIoPgw?=
 =?iso-8859-1?Q?CmBs3aK60MUm+nn9GTRA7TVZevOSlyTDRDdCZK8epYCgxapgjp4OZ3MtaP?=
 =?iso-8859-1?Q?RneSIsf0GIeUXDuLjCvWPCGZ4JwPo/Qm5vhaCCfOgYm/nRNPXAZkHjZtHw?=
 =?iso-8859-1?Q?HNE46CSTi8TtmfTFdKgyloSvWxonUCF7Ss0kUibt4VNRjbJlTssLEaDBbR?=
 =?iso-8859-1?Q?IVP4leIZViOAAfT1JhqKBSpOhhuTHZ0Lbg5FCT3tQhecDXd8vaNVDNLHa7?=
 =?iso-8859-1?Q?MkWxwTTJgg9fx0LQmAUgQ7vHye300bZKrUZYj4kD0MY8pobGuOtZFSkMe7?=
 =?iso-8859-1?Q?MBWBww8JWLDe+mVS9czTVsG6pPveegXmQjDMX+giuY177jlKvNb0Ciiwdp?=
 =?iso-8859-1?Q?lnKkFDWwNBW46Cv4XoQpCGzTPxZlLwrJT5c9IvaJ+2SjEr8gFrRLUhLq5f?=
 =?iso-8859-1?Q?rdPoRLnHFJO+KMZ4cbGU2vO9w2hRnUcyA4KE3MrqITTcPiRMQ2p5anW9WP?=
 =?iso-8859-1?Q?lIV/5kEySBn47dTpGR5voB51hQbUAmwWjlxqnFqkVKDWuvpyiUQSPzjwx5?=
 =?iso-8859-1?Q?QMexmMVl4Dyff5F5e1B+AdlqWyOHyhYvUdU9UwgYISoxFGnoK0rC+NDJoh?=
 =?iso-8859-1?Q?UfG5/V9YwKcANlx49Tni/0SfdqIMOefKZbvrq1Pl/drOlnv7MSZUFQKwqs?=
 =?iso-8859-1?Q?sYVrRvUzqPaOJZ+QlKfN8to1pnQqMyubrZ3AGJZPvVMmiuGyrq1rrWQ7Dy?=
 =?iso-8859-1?Q?0nB3toJWg7JJn7IPSlgVtTRVeGbpbqZXl25tghMhgTcbGBsTJEVSY58qpN?=
 =?iso-8859-1?Q?TcG1NFP+voak73IkOrNV/rZKikDyK4uz1FG8DskmAQ51JiS0GpRpntIj3Q?=
 =?iso-8859-1?Q?4SNToFhp7tg22QIEKAb/+RVrl5YGsajoDI7VqRrduI8lJCY5mwnkx6iWao?=
 =?iso-8859-1?Q?mIZYNC6zgXtb+OXHOz30h5Ud8ffR198xZOhARp1sOu23RgZLxd6jJdyQU/?=
 =?iso-8859-1?Q?ClpTU6vxnyhn9My+6yHY4BworvpPsRPATX8Ynsp0kIbeYSRLZlfzpSP7WH?=
 =?iso-8859-1?Q?9hWWDEWakmteTifqzCfTQGqvaWMHh1S07Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac830bc-8c0e-4346-c861-08db784672ec
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 02:13:37.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfahqhs7xEJ1l0WFcUJSYagXOnM/hicPeUoZrPTL1/0LZIBZOjkn45lHaqQfDu7fxZF10ma5O/H+Y0JelgBxIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6077
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

Fabio M. De Francesco wrote:
> On giovedì 29 giugno 2023 00:23:54 CEST Fabio M. De Francesco wrote:
> 
> [...]
> 
> > 
> > Shouldn't we call folio_lock() to lock the folio to be able to unlock with
> > folio_unlock()?
> 
> Sorry, I wanted to write "If so, I can't find either a folio_lock() or a 
> page_lock() in this filesystem.".

Check the documentation for read_folio:

	... "The filesystem should unlock the folio once the read has
	completed, whether it was successful or not." ...

Ira
