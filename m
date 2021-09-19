Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83463410AFA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Sep 2021 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbhISJsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Sep 2021 05:48:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:59743 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237933AbhISJsY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Sep 2021 05:48:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="284020203"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; 
   d="gz'50?scan'50,208,50";a="284020203"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2021 02:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; 
   d="gz'50?scan'50,208,50";a="453747611"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 19 Sep 2021 02:46:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 19 Sep 2021 02:46:57 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 19 Sep 2021 02:46:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 19 Sep 2021 02:46:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 19 Sep 2021 02:46:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a374pswHLuFVlaDGcTUk/L1XQsduRlK8d+yHN5gAmeewEzNje3bX7aPw2yzutE4Cb4emaY0FMG/AN9VV2Antrv3oTWlBVdA9KJotj53Y/GT5ndIC4Pi2ibs6M3cYx2H6V6KoUymD1xGq+TkhdO+lUns1O4LgxV37joZkoxNdHxJ7onhIjYHCqBMkAHDCxCARnSwJt+rKe6GU241c2Qx3ZU/+qLPByDXPrjFIP44YxBRiaskLTofwhM1mM6U8s3RyyRJMKlMk3qtturS0x63sVLKlzrBP1EZ5r2UoLvviyi06J5UX3QZJY+KsOVtsW/Xd36Lq936Ri0ASxVr6V5t14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/2Q5Y7lNjbFqjJTYVbz5RW2BIn0dv2c7CUGLW7nSupw=;
 b=bUATJaJXGA5hQ0yzT4ShQkCFZ4FhmN9Zhhv69qIJj402unGQxRzV2dVhBZjtXXT7RcIBbkjk4rGYe1sppkAvPVtd2VW+vugCWm8cuDgvUDKDZJp0C240Vgi8fC2pGLPlt0islZ8dzRo7/1JUL/EQy5btTRgmMPgTjjkHFIN+crFGcoo4oZZfzcq5iPjQv5iHvkcJRkSwE6r35e2TdTkfEKvOeAn3Ittr8WB5LiWC/sNfA0Km5wgaovDytSUMKXWqj0POeJCDjQuRBt/B7xxquZUEQT8hPQveLARczE0k5q5ijAZcuXV/MUetb7hm2103hEby7EMYPJtMtHclKqLsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2Q5Y7lNjbFqjJTYVbz5RW2BIn0dv2c7CUGLW7nSupw=;
 b=xoAegtPrp5Zu4lXVYqGpIRvXCk9Kx93OOjh72lwP0WP+B6btgqIEfzJ0KPzGGSOu93hrDEavnZpP/BznBuP+nCEWfDH2tsWSbZHC4HOTOMFWc/pEfe/RxYvjSf3DKy2oMmIGg24OAe0vVON0QIiQepGf8EIJiZth0PHw6/O1zho=
Authentication-Results: effective-light.com; dkim=none (message not signed)
 header.d=none;effective-light.com; dmarc=none action=none
 header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5662.namprd11.prod.outlook.com (2603:10b6:a03:3af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sun, 19 Sep
 2021 09:46:54 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::6d71:2479:2bf5:de7f%9]) with mapi id 15.20.4523.018; Sun, 19 Sep 2021
 09:46:53 +0000
Content-Type: multipart/mixed; boundary="------------GZXmDgKAz7ulJogkfvG8s6kk"
Message-ID: <fb97ac6b-f555-4a06-f5d9-190b2ef13909@intel.com>
Date:   Sun, 19 Sep 2021 17:46:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.1.1
Subject: Re: [PATCH] aio: convert active_reqs into a hashtable
References: <202109171539.NOLGFkzS-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202109171539.NOLGFkzS-lkp@intel.com>
To:     Hamza Mahfooz <someguy@effective-light.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
X-Forwarded-Message-Id: <202109171539.NOLGFkzS-lkp@intel.com>
X-ClientProxiedBy: HK2PR02CA0221.apcprd02.prod.outlook.com
 (2603:1096:201:20::33) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.255.28.110] (192.198.143.18) by HK2PR02CA0221.apcprd02.prod.outlook.com (2603:1096:201:20::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Sun, 19 Sep 2021 09:46:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9546652f-a688-4849-d4c2-08d97b526957
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5662:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5662F6D5EE9B39E3CAF56AB4FBDF9@SJ0PR11MB5662.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DyfOHVUN588pW0C3ffCV1hX/1Wfb1gK77P8oXcjb79qTeyl4buh6cds7+fefySLLBck4kTHszaKHjjbHcIS8QoeryUoQNJkM0CNnqVlDeZv2R1nWwwjyVXbQ+WUK1oKEL1OQJlqN4n8vhjJPb0nxsfqYZjc0JMDXhDDaP9icUEDs7s5UOjoJQ5TvKER8W55XQyUk351VCPOfSVB3lfYhBt+R67h7f3A/xF4Ds3sgJBD8fyceEUgm9Gww1KZzfL1TchoR+pPnN8i+ysmSshxA4mxfRy507u/TsDjAKSMSZSlf8yNo7QyzKL9KY03hKos0iFgatCzwmds5xWz4qIApWHLyYQj/bI+lh4au7UGNlYsF7mBYliU8dD1v4rVfqVJAxl+6kzTjTvGLxiXU6Oue/fVnVGR4SqV9siVtt1uFof4ZgTSc5EdHzJZ2EmMR2LBbReQ+uZXhHPVLzo2JhELWdh/UKJMZu5ovxDLT/gbROU19oa9IyzqUUc5ipQ/gmtQdTNYHrsj4eRtFBjXCtO8/2yYo69Yk/XBIyjlqY4ckBm3yfPjjQgq/dnm0DXpIC6K8DXJNbx33poafn7eyRM4rySG12DiGNyC5BzXPoHGxQyE7UBw+WxhIYOA4nga9v8bLQsxQfLARnZQw5WxOBNVCgtQd9cXgd0aGXNMtrdZUCmGzASUJN/Lv8t14mTfMtekVZ7BpPaQ8oUXFcRan9iC6HTdQrwLYzpEE2h6DxPjSMeBLaKacknwlyqe00V4Nli787ckFal/my8295Kn9xobid34Q+xpkuShqHmUhaiMkS4JURuV8LzmWdLRNFjiub9Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(66616009)(66476007)(66946007)(16576012)(66556008)(186003)(966005)(316002)(26005)(8936002)(6486002)(6666004)(4326008)(31696002)(54906003)(31686004)(110136005)(83380400001)(4001150100001)(235185007)(5660300002)(33964004)(86362001)(36756003)(478600001)(38100700002)(2906002)(8676002)(956004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amNHV2FOZ29iV1loOTN0K3dCYTJNc1NzdU1ST0E0V01DcGdWMDAzMjFvbG5p?=
 =?utf-8?B?VVNtUTlMY0d1NDJmQmxvblhSR0QvQ0F0Vm1mQWdoNFNYUysvQWFpWEhtT3g1?=
 =?utf-8?B?ZnlhdUs3QjcvMUdwM2dac3VwZXVSdmxZa2o2eXFGdDJvTXlQV04vam1namwz?=
 =?utf-8?B?dXB5MFVWcS83azlVNzMxcndtNGtHSGdwOTl2dlQzMkJKb0VYYnBJbG05dXFu?=
 =?utf-8?B?QkdTTmtiQ0I4L29jRUViK0k1NHR5eTJOWm9Ka1kvRm95Y0xFOXBGMGNLZ2x3?=
 =?utf-8?B?emkxV2FWdW1mREhPbmNoUGYzSlVnMWFxeDUvazhMQzh3ZnhDSjNnRUg3ZzJU?=
 =?utf-8?B?Sys2QStOUGlWWTA4S3owaTgvL0xlTmVDUndsbk5SR3pFUGpleXBjVlVObFJX?=
 =?utf-8?B?cGR6bEh2bS9FZEdtdm91V051Z3oyNkV2N3ArQm42RGNiWTZwSWFIalJUU1Yv?=
 =?utf-8?B?U2ZURzNNM3ZmVVpsSklUZW5rVnBHM3JXZExRWHVlbEdmckR6QkdRYWprY0hq?=
 =?utf-8?B?Zlk4aWUxTlZFQ1lHUEZaRTgvY1hhdjdxSldlZm1obCt2MDU4UGdEYnBUZnRP?=
 =?utf-8?B?V3JWL29mRy9TTktQNjMzeFBHTmJQS3VBYk15ekRxWnRUS3hLejF4OFI1UG9F?=
 =?utf-8?B?eWV2YUZ2TmtSVGVrTVNYQ2Frd2ZNNFBvT2h0cTVlTVp0TjBuWVdHcW9EUFEr?=
 =?utf-8?B?WjJqdkd1VklaaTVIcHdPT24vZEhvZTBpTndzVzRZNXY2dVpQc3g1SXRpb2tp?=
 =?utf-8?B?OWFCNXE2T3RKVWpNQk9GV3I2dktZV2JhOU9SODhtZ0dZckxxaW91b3hod3Q5?=
 =?utf-8?B?NVlSbDJaWmc1RHFHRi9XT2xid0FXd3lZck9vNUwvcXdzOHpIVnZXK29IdEtu?=
 =?utf-8?B?NkxHYWtIRkhITEFGVEpEdkdNSXJjdjlpY2pVUkhUbk1pcnN5cHFMd3N2Nm52?=
 =?utf-8?B?cFJNMlBiSGkyTkhBTXl0aGJBRzd5cndYWGpJSWxDL2FDN1p3VEhSQnlrRlpV?=
 =?utf-8?B?VnJtaXNwcExadlh4VVRmSGtqRmdRWG04aUZYM1JqakZMRUtyWVlxL2o4TDkz?=
 =?utf-8?B?K0VPS1NQUXNsRXJDb29nYU82WlovcG5vdHRPNHROVTlWNWJRT3NJaGxsaGVE?=
 =?utf-8?B?eDRvelJFVkI3MTk1NXlGbGcvZU95M09pWlp5SWV4a1EzMjg1VTFoekJrMlVE?=
 =?utf-8?B?bytTNnFEYlZ3V0JFVVkySU1tNmdqdzdSSEgrUTZSUTFOUStUVDR1bnc3VCtG?=
 =?utf-8?B?Q0RwSXBMZEJibFpuWStYQ2RrTloxa2RTYzh0eG40YjdjT3hyM3VMeWRVZzZQ?=
 =?utf-8?B?c3pYRnJpYkdVbW9QWkVYUjYxYURSNHJIUytnTHV5ZFRUWmZENjhMTkdVcWxK?=
 =?utf-8?B?SjJWd3lFYVRqNTNyNHppNmsyTG1VV2Q2TjNwQ0MxTEJYQXgvVFJ5d1kzNHR2?=
 =?utf-8?B?R01uK1FMc1B5ODE4cEQ0SXNwRkdXMk80RFpNenkvOEg3QmV2OTNRWUk5eUpQ?=
 =?utf-8?B?Mmg0YWk0RG1vSzFoaFZmL0N2YmRrbzdFb0kzY25ISHk3TXBxQVRNSFRrSmRS?=
 =?utf-8?B?L0JDeVc4b0dhTTUxK2QyVlhVZTQ5azEyTmxIcnZPZVZ2ZWdqeWtHZUVscjZL?=
 =?utf-8?B?Z3QrZVJkL05sWi95WmxPT01zNUlsaXUrcWQ2TnU5WG92TEtRVk5TVGd1M2pz?=
 =?utf-8?B?cDI2czh1clBkaXM0aG92N28xNkNURjlYL09yaGM3SkRKaWErK25ONmI2TmlV?=
 =?utf-8?Q?LLY1R48b33VSnLxVL7j6yz0nn9HjUSwYzpObNWw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9546652f-a688-4849-d4c2-08d97b526957
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2021 09:46:53.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A22CTE7o/Bcgn7CXcKA4ZUPawSWgMuCMnZQQ/JWTfa9JEWW/NXZpJ+d0J7nP/s632xDU4zRQPf7X4u26FTgIrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5662
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--------------GZXmDgKAz7ulJogkfvG8s6kk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hamza,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on linux/master v5.15-rc1 next-20210916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Hamza-Mahfooz/aio-convert-active_reqs-into-a-hashtable/20210914-174924
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d0ee23f9d78be5531c4b055ea424ed0b489dfe9b
:::::: branch date: 3 days ago
:::::: commit date: 3 days ago
config: arm-randconfig-c002-20210916 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 8cbbd7e0b2aa21ce7e416cfb63d9965518948c35)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install arm cross compiling tool for clang build
         # apt-get install binutils-arm-linux-gnueabi
         # https://github.com/0day-ci/linux/commit/ab7dca103bc74aed4baada06420395f4bead4e6c
         git remote add linux-review https://github.com/0day-ci/linux
         git fetch --no-tags linux-review Hamza-Mahfooz/aio-convert-active_reqs-into-a-hashtable/20210914-174924
         git checkout ab7dca103bc74aed4baada06420395f4bead4e6c
         # save the attached .config to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> fs/aio.c:2042:36: warning: Dereference of undefined pointer value [clang-analyzer-core.NullDereference]
            list = &ctx->active_reqs[hash_min(kiocb->ki_res.obj, ctx->hash_bits)];
                                              ^

vim +2042 fs/aio.c

c00d2c7e898800 Al Viro           2016-12-20  2009
^1da177e4c3f41 Linus Torvalds    2005-04-16  2010  /* sys_io_cancel:
^1da177e4c3f41 Linus Torvalds    2005-04-16  2011   *	Attempts to cancel an iocb previously passed to io_submit.  If
^1da177e4c3f41 Linus Torvalds    2005-04-16  2012   *	the operation is successfully cancelled, the resulting event is
^1da177e4c3f41 Linus Torvalds    2005-04-16  2013   *	copied into the memory pointed to by result without being placed
^1da177e4c3f41 Linus Torvalds    2005-04-16  2014   *	into the completion queue and 0 is returned.  May fail with
^1da177e4c3f41 Linus Torvalds    2005-04-16  2015   *	-EFAULT if any of the data structures pointed to are invalid.
^1da177e4c3f41 Linus Torvalds    2005-04-16  2016   *	May fail with -EINVAL if aio_context specified by ctx_id is
^1da177e4c3f41 Linus Torvalds    2005-04-16  2017   *	invalid.  May fail with -EAGAIN if the iocb specified was not
^1da177e4c3f41 Linus Torvalds    2005-04-16  2018   *	cancelled.  Will fail with -ENOSYS if not implemented.
^1da177e4c3f41 Linus Torvalds    2005-04-16  2019   */
002c8976ee5377 Heiko Carstens    2009-01-14  2020  SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
002c8976ee5377 Heiko Carstens    2009-01-14  2021  		struct io_event __user *, result)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2022  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  2023  	struct kioctx *ctx;
04b2fa9f8f36ec Christoph Hellwig 2015-02-02  2024  	struct aio_kiocb *kiocb;
888933f8fdf06e Christoph Hellwig 2018-05-23  2025  	int ret = -EINVAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2026  	u32 key;
ab7dca103bc74a Hamza Mahfooz     2021-09-14  2027  	struct hlist_head *list;
ab7dca103bc74a Hamza Mahfooz     2021-09-14  2028  	struct hlist_node *node;
a9339b7855094b Al Viro           2019-03-07  2029  	u64 obj = (u64)(unsigned long)iocb;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2030
f3a2752a43de18 Christoph Hellwig 2018-03-30  2031  	if (unlikely(get_user(key, &iocb->aio_key)))
^1da177e4c3f41 Linus Torvalds    2005-04-16  2032  		return -EFAULT;
f3a2752a43de18 Christoph Hellwig 2018-03-30  2033  	if (unlikely(key != KIOCB_KEY))
f3a2752a43de18 Christoph Hellwig 2018-03-30  2034  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2035
^1da177e4c3f41 Linus Torvalds    2005-04-16  2036  	ctx = lookup_ioctx(ctx_id);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2037  	if (unlikely(!ctx))
^1da177e4c3f41 Linus Torvalds    2005-04-16  2038  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2039
^1da177e4c3f41 Linus Torvalds    2005-04-16  2040  	spin_lock_irq(&ctx->ctx_lock);
ab7dca103bc74a Hamza Mahfooz     2021-09-14  2041
ab7dca103bc74a Hamza Mahfooz     2021-09-14 @2042  	list = &ctx->active_reqs[hash_min(kiocb->ki_res.obj, ctx->hash_bits)];
ab7dca103bc74a Hamza Mahfooz     2021-09-14  2043
ab7dca103bc74a Hamza Mahfooz     2021-09-14  2044  	hlist_for_each_entry_safe(kiocb, node, list, ki_node) {
a9339b7855094b Al Viro           2019-03-07  2045  		if (kiocb->ki_res.obj == obj) {
888933f8fdf06e Christoph Hellwig 2018-05-23  2046  			ret = kiocb->ki_cancel(&kiocb->rw);
ab7dca103bc74a Hamza Mahfooz     2021-09-14  2047  			hash_del(&kiocb->ki_node);
833f4154ed5602 Al Viro           2019-03-11  2048  			break;
833f4154ed5602 Al Viro           2019-03-11  2049  		}
888933f8fdf06e Christoph Hellwig 2018-05-23  2050  	}
ab7dca103bc74a Hamza Mahfooz     2021-09-14  2051
^1da177e4c3f41 Linus Torvalds    2005-04-16  2052  	spin_unlock_irq(&ctx->ctx_lock);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2053
^1da177e4c3f41 Linus Torvalds    2005-04-16  2054  	if (!ret) {
bec68faaf3ba74 Kent Overstreet   2013-05-13  2055  		/*
bec68faaf3ba74 Kent Overstreet   2013-05-13  2056  		 * The result argument is no longer used - the io_event is
bec68faaf3ba74 Kent Overstreet   2013-05-13  2057  		 * always delivered via the ring buffer. -EINPROGRESS indicates
bec68faaf3ba74 Kent Overstreet   2013-05-13  2058  		 * cancellation is progress:
^1da177e4c3f41 Linus Torvalds    2005-04-16  2059  		 */
bec68faaf3ba74 Kent Overstreet   2013-05-13  2060  		ret = -EINPROGRESS;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2061  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2062
723be6e39d1425 Kent Overstreet   2013-05-28  2063  	percpu_ref_put(&ctx->users);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2064
^1da177e4c3f41 Linus Torvalds    2005-04-16  2065  	return ret;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2066  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  2067

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--------------GZXmDgKAz7ulJogkfvG8s6kk
Content-Type: application/gzip; name=".config.gz"
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
+QEA

--------------GZXmDgKAz7ulJogkfvG8s6kk--
