Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73DF6573EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Dec 2022 09:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiL1I2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Dec 2022 03:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiL1I2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:28:40 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923E3F037;
        Wed, 28 Dec 2022 00:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672216118; x=1703752118;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GHYckRNLBAJkM1B6ZVZAzlngKHgbuthXJCPMXZpUS18=;
  b=STGx9+vPg6hzKH0jSzHifA2RNweCWBsRH/e2sTSrGl4iSvA0NCvVFgGM
   0IsarcprYZyju/RJlJuGvW/B2Tuf/Qatj9+AbGzMRAPymTXUOtMIlBhEW
   uwA5ABeeFBDm0K0ILoMpXAjsxhtPE1cFVJFgoS+4+VMS36bziMIP/8GOz
   CkCOqcYgyQ6Q38Mnxeyek/m5CaQbm1JeVd7S3pXoGMTdoXcGolrsEa+5I
   WqPyT0QLTc9GQAax3coHUywUrDr4FiDRLQ0LagnWavxd1Hwu7LlljjqjU
   KwNGqYriBJ819rhkDFgOOFRSfcJzjPehJ2eUqMuiTN2yeJsasLIJxDk94
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="322068246"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="322068246"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 00:28:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="716565660"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="716565660"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 28 Dec 2022 00:28:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 28 Dec 2022 00:28:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 28 Dec 2022 00:28:34 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 28 Dec 2022 00:28:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rl8OIlP8rSD70Z1QPAqv+4TVIuHWK1QlZ8p5KdqFRYgBHvTQcnU5u+baNFQqkWlkVZIZl4BBykic3wQZ10uDeIlU5F4IPoqPHuJI4gQDSkHffTAOoxMRJl91FkSf0jTCIPJ5tKRBGKq/paXKcJPxYWvd4sW6qrfkV1Jmd/6UQYWOHR7ePQkpxOYK2Sql2RnY97//RYSd48qlXQlqmpnbwBf3/2Hnlm8GAvL07f86rAYjJ68ePVjGATXThcSdyUxcDWQ7tP4Us8APss3drIYRcR4JJnN31ZdYo7Y3Wpvc/STuAaqH1aoMc70eCNoNCmySeWq1QRllK510fVxnUknu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0wHkUBLhb2NVqlSR+uKFzfL++/32lyZTLZ2Q7ms/qQ=;
 b=STVP6rg2MqlojABMeapZ6UQoYboBnv3dMbbfq1F7RsLhNJVlGiMldiqPMRXGaJo7GpafV4YPJGBvuVuPlWgthVDkpz1klUiWdzhWIbfxkPdQXBTUyTZrp7vFfuErTdjbGPFnMQSVY30fl+zx5KvnJ6dpnUMlZqGBSbS+v2GCe+HB+dUZxwbKLwqVPzeBIDBJA9eQuLEsuXPHTbOaCnXkXjKYBQK8B9HKHCw/wzvVF+o1IiCvtEfyOGDlk3S0djaEhnAZjtH7gR+ku+qHRrCxib1x08QoGNTxYIxs2cBlt2Rp2Sd1ynVPgHVPDbWaltD1jBVQW5Ge0UHqTriHgZpufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5052.namprd11.prod.outlook.com (2603:10b6:806:fa::15)
 by MW4PR11MB6572.namprd11.prod.outlook.com (2603:10b6:303:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 08:28:23 +0000
Received: from SA2PR11MB5052.namprd11.prod.outlook.com
 ([fe80::d95b:a6f1:ed4d:5327]) by SA2PR11MB5052.namprd11.prod.outlook.com
 ([fe80::d95b:a6f1:ed4d:5327%8]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 08:28:23 +0000
Message-ID: <1c9bbaa5-eea3-351e-d6a0-cfbc32115c82@intel.com>
Date:   Wed, 28 Dec 2022 16:28:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <qemu-devel@nongnu.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <luto@kernel.org>, <jun.nakajima@intel.com>,
        <dave.hansen@intel.com>, <ak@linux.intel.com>, <david@redhat.com>,
        <aarcange@redhat.com>, <ddutile@redhat.com>, <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>, <tabba@google.com>,
        Michael Roth <michael.roth@amd.com>, <mhocko@suse.com>,
        <wei.w.wang@intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
From:   Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To SA2PR11MB5052.namprd11.prod.outlook.com
 (2603:10b6:806:fa::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB5052:EE_|MW4PR11MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: dc99bd20-2dac-49fe-daf6-08dae8ad7bdc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jDNOgnqpVNTJpoERKSxjgjPgz0nTEcHl3IMzjuRncNmLHKjsiAtPJiJRk42ZvIjlnXxOtgzShDMk7lr75y7pMejzUeYyBtK7UcckuFsq3Il1Z5t3rPW5YT+saRRhKAULS88JlGwWeNMN+fyq201DoHYFvrBfPTdu74Be5N434AK3e7vhUdZzBm+yM0FHVUu2jQSjqZrUohhgSdc1lxEFefzlgQku8nJfaatdjoADHoNORqaG+wwfneOgmU1ojMbsljOBdUIWdBOWRXBrPC2t/3aCBh7rqQSzLngLvaWDFlHegqX6ahjTiTTVu2yurSSNMds96HuehY+0BwYmOIg25FFPppn3pMsNQ4ndg8uWQlaz0bUhCgOQYPuR5tFZkIeukPugiB6k4WJMGw4FOeM067/WUOAfKvYgw4zADWK/h8HGksf4kysVTi9QpRQqdA0BfT57eT7C92XbqYlMZCXoSohZEcxU2A8neAp76GEL+qC0V56O0Zi5momJYeIDy2HtM2nipsDX8MRVVaDP4KtqiWVH/65DZAzZDgssipwXAXTYZPqW/9MTpBCd3QzK752gaZ4F032hPIlLLvIRMa8XUWhPYx76mBPLJeZXYNLkp6X8H3qLEzBokmVMw6NXuXQjnxY7DfYBap4KGhS4Sl4rDtPAGLhLZw2ws05HCQboL7xL93wYZ2I0woPSi/sx2NGyX6OaCbeJj7lRNry83endAWw32yznupmkb+va46MtXF6jJnHu7g7i93wt6yuJyL5vFePfOkDa5P1EKxcAD4GyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5052.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(36756003)(2906002)(82960400001)(38100700002)(5660300002)(8936002)(41300700001)(7416002)(7406005)(44832011)(83380400001)(31696002)(86362001)(31686004)(66946007)(66556008)(66476007)(54906003)(6666004)(478600001)(6506007)(6486002)(966005)(316002)(8676002)(4326008)(6512007)(53546011)(186003)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1JtZERLWGhGTFB0TDZRWThtdit4NitFZUc1QUFTTzlFUUFCdmMvVzR1aTN2?=
 =?utf-8?B?YTdlTkNPcDZqYUxteHZ3SklmMVhQWEhjRWhXeE03WjhzZjVPU0JGYklQZGEx?=
 =?utf-8?B?cDh4dnBEK3hDUGdwd2JndlZnemxxNkFMSnBVdlFUaFNDK2RudUlZMWNDRUEx?=
 =?utf-8?B?QzdsZTR2TzQzL1FqMVplNncxMk1yOEhtZlFmeWpEY1lZRGJ2enAyT3hwZnJW?=
 =?utf-8?B?Q2tPQVIwYVZneFRzMU9OYk1LZHIzcHQ2YitXK2liNDBaMXhUem9kd2VNNVBr?=
 =?utf-8?B?VWYwOVdXQ3FSRi9wVFIvL1h1ajF3SlhhNmFJTGNlbE9rNjFLZklxTXdnTkhw?=
 =?utf-8?B?VHBFdGRaQVM3ajhIWVdwa3pTczFINldvZVR2NUl1RHhueHNkREtyd1YvSDd4?=
 =?utf-8?B?MDF2R25vbkQyUk04UmExR3VmTi9kOGp3b0c4bE1GaEtlWFNBNzY0T3VhNElz?=
 =?utf-8?B?a3hNbkdRVEpxc3dqSmpXeVBhdkZMSnFzQlA2dDZ2ZDdlbVZhdyttTWRtRDNw?=
 =?utf-8?B?V2ZLdjFRQWZSWEdEakZpSEdDdEhJamtsY3VmaEw4eXBibVFaTFpMSytQM24y?=
 =?utf-8?B?NlNIb0dOQjFLT2sxcXkyWUtCWFpuRDFLMjk0ZVc5NXdHNHFuTmovNHo5QTVK?=
 =?utf-8?B?aXVib1BpYmFOejJ6NEpBV0M5cUNmK0MwQjhMczgzRkpJQlRyK2liVlVqR2Ra?=
 =?utf-8?B?U2c2NmNJNEpEUUJkcG5iclZ3TWErYkpnSHYwWG02aEJVWm9MNXlPU0FBc0FZ?=
 =?utf-8?B?Mmw5RDlheHg0c0NNOFB0OFJjUm9seGlsY3k5V2VJanJMbVJZNXpRRTR0blF2?=
 =?utf-8?B?Y0VWenEzZUh1ekUvbXcwSU5kOEx0WW9lRnkyVDlXRlNlOTdsNjV1WXJwLytz?=
 =?utf-8?B?eHdQaThIeDBwL0VxRmM4VVJIZ1dnQ256cWRxTUxYaVNJY05QekwvL09wbHRz?=
 =?utf-8?B?R3FyMnpCRjhmZEJZRDk0MnBOblI3bnQ0NTkxUlIzbFBwYjc0SlE3R29lbXB4?=
 =?utf-8?B?Y010WmhNYysvQTJBRFlZSHNFNWZWSHVuS1ZxRklIVVdJUUowNXFSK2tlQUls?=
 =?utf-8?B?Q1Z2VTRoNm0xeWg0OExYOUduTjU5dFAxWnlHRTlVQU9ITjJRRFhzQWpKWG1V?=
 =?utf-8?B?d0FuM2xLekw2U0l2N3RhTTZVYjBVTlJscDFQYjc2blA1cE9hSk5zdFJSSU55?=
 =?utf-8?B?SS9jTVovTkpmL2xUaW9Qbmt2SmVpam1ZK0tBMTZ3RjJ6VTBHVVZkczhhWXlQ?=
 =?utf-8?B?WWFqRFU5MEg3NWFzZDRpenR1SDNlazFlS2VqQzhML2t0d0VmYXY5NHg4NER2?=
 =?utf-8?B?czhlOFRlNzNMWjRPNHBRL0k4YUZHMkE5ZTBEYUpCTXBKUTFuSjMxVHJQeE1p?=
 =?utf-8?B?NGRhbEc4RmFxNzlEVmwwdUR4ZFZLbWxXdnhLRGlRYTBXVlpONzdUSGtMajB4?=
 =?utf-8?B?MXJaemJBL0NyUnM1dURUVlBidjJUZUladUhRc3BTSTFSQzJBR0dXMEM4bTZQ?=
 =?utf-8?B?aytKZ0NQWm5nUm80VjB5U3NEY3djVGF3RWNRZGJwRGdHZWdiVnRCVjBkbGtI?=
 =?utf-8?B?NzdSZWlwcks5NXpwWklZcmZiMjZzRHhDT3pqZEh5YUp6U3MxWkJOcjVqWm5Q?=
 =?utf-8?B?WU9uWitPSjhDT2JOakkxeW80dytxVDAyM2k4c3VVTWRTV2Q4UGhJRGs2YzNs?=
 =?utf-8?B?U2NLODJxUU5qcGlGWHhiSWVXeXJFYzhsdDhvbm9DSEpzZ2hwcHN0Ymxwamcr?=
 =?utf-8?B?RkRDVWFxR1ZtV3plV1pJbTBncEVXZUpIRlNBTzRjRTAxeTFMODhrcXBYMmJk?=
 =?utf-8?B?RVBhY1pqZ2h4OVBDR0V5S1d1UUpQMzFaaGk1U3A2aEtQR3BaNk9pNEZvbFc5?=
 =?utf-8?B?c0lVbG5rL0NJMXNRUjVvbFJZS1l4SlZWbTN6Y3F2K2JleGVjMmkyUnUzVDBW?=
 =?utf-8?B?aTY4SDRpTTMwRzRTMGliYURyKy9UYWl3VElWdUZsVDBzWGtZNDN2VG5YVk5X?=
 =?utf-8?B?YTRSNzloY1NVNWhMMG1PN1BoSXFTUHdBNWxsL1dyb2N5TjM3aGFEWFZVRWY4?=
 =?utf-8?B?NlozWG1heVJxTE9vRWRpY1dqN2V0TGx1OVkvWC8vV3FoTUpQa3pQSkRPOFY3?=
 =?utf-8?B?bEpuMGFYZ1orbWdvdWZnMVU4TjJxOG5mdTBKL2Vmc09tQXhqMmpwUkdTMHF6?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc99bd20-2dac-49fe-daf6-08dae8ad7bdc
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5052.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 08:28:23.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nfq/1k+GUq+SfZtGySx3qF75/dMebs/u9KKh8Dlfq8qSgwRTjhzbdF4TQlg2nPfGFiaM7ApmgfHlk3BtBAlwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6572
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/2/2022 2:13 PM, Chao Peng wrote:
> In confidential computing usages, whether a page is private or shared is
> necessary information for KVM to perform operations like page fault
> handling, page zapping etc. There are other potential use cases for
> per-page memory attributes, e.g. to make memory read-only (or no-exec,
> or exec-only, etc.) without having to modify memslots.
> 
> Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
> userspace to operate on the per-page memory attributes.
>   - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
>     a guest memory range.
>   - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
>     memory attributes.
> 
> KVM internally uses xarray to store the per-page memory attributes.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com/
> ---
>  Documentation/virt/kvm/api.rst | 63 ++++++++++++++++++++++++++++
>  arch/x86/kvm/Kconfig           |  1 +
>  include/linux/kvm_host.h       |  3 ++
>  include/uapi/linux/kvm.h       | 17 ++++++++
>  virt/kvm/Kconfig               |  3 ++
>  virt/kvm/kvm_main.c            | 76 ++++++++++++++++++++++++++++++++++
>  6 files changed, 163 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 5617bc4f899f..bb2f709c0900 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5952,6 +5952,59 @@ delivery must be provided via the "reg_aen" struct.
>  The "pad" and "reserved" fields may be used for future extensions and should be
>  set to 0s by userspace.
>  
> +4.138 KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES
> +-----------------------------------------
> +
> +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> +:Architectures: x86
> +:Type: vm ioctl
> +:Parameters: u64 memory attributes bitmask(out)
> +:Returns: 0 on success, <0 on error
> +
> +Returns supported memory attributes bitmask. Supported memory attributes will
> +have the corresponding bits set in u64 memory attributes bitmask.
> +
> +The following memory attributes are defined::
> +
> +  #define KVM_MEMORY_ATTRIBUTE_READ              (1ULL << 0)
> +  #define KVM_MEMORY_ATTRIBUTE_WRITE             (1ULL << 1)
> +  #define KVM_MEMORY_ATTRIBUTE_EXECUTE           (1ULL << 2)
> +  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> +
> +4.139 KVM_SET_MEMORY_ATTRIBUTES
> +-----------------------------------------
> +
> +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> +:Architectures: x86
> +:Type: vm ioctl
> +:Parameters: struct kvm_memory_attributes(in/out)
> +:Returns: 0 on success, <0 on error
> +
> +Sets memory attributes for pages in a guest memory range. Parameters are
> +specified via the following structure::
> +
> +  struct kvm_memory_attributes {
> +	__u64 address;
> +	__u64 size;
> +	__u64 attributes;
> +	__u64 flags;
> +  };
> +
> +The user sets the per-page memory attributes to a guest memory range indicated
> +by address/size, and in return KVM adjusts address and size to reflect the
> +actual pages of the memory range have been successfully set to the attributes.
> +If the call returns 0, "address" is updated to the last successful address + 1
> +and "size" is updated to the remaining address size that has not been set
> +successfully. The user should check the return value as well as the size to
> +decide if the operation succeeded for the whole range or not. The user may want
> +to retry the operation with the returned address/size if the previous range was
> +partially successful.
> +
> +Both address and size should be page aligned and the supported attributes can be
> +retrieved with KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES.
> +
> +The "flags" field may be used for future extensions and should be set to 0s.
> +
>  5. The kvm_run structure
>  ========================
>  
> @@ -8270,6 +8323,16 @@ structure.
>  When getting the Modified Change Topology Report value, the attr->addr
>  must point to a byte where the value will be stored or retrieved from.
>  
> +8.40 KVM_CAP_MEMORY_ATTRIBUTES
> +------------------------------
> +
> +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> +:Architectures: x86
> +:Type: vm
> +
> +This capability indicates KVM supports per-page memory attributes and ioctls
> +KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES/KVM_SET_MEMORY_ATTRIBUTES are available.
> +
>  9. Known KVM API problems
>  =========================
>  
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index fbeaa9ddef59..a8e379a3afee 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -49,6 +49,7 @@ config KVM
>  	select SRCU
>  	select INTERVAL_TREE
>  	select HAVE_KVM_PM_NOTIFIER if PM
> +	select HAVE_KVM_MEMORY_ATTRIBUTES
>  	help
>  	  Support hosting fully virtualized guest machines using hardware
>  	  virtualization extensions.  You will need a fairly recent
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 8f874a964313..a784e2b06625 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -800,6 +800,9 @@ struct kvm {
>  
>  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>  	struct notifier_block pm_notifier;
> +#endif
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +	struct xarray mem_attr_array;
>  #endif
>  	char stats_id[KVM_STATS_NAME_SIZE];
>  };
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 64dfe9c07c87..5d0941acb5bb 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1182,6 +1182,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_CPU_TOPOLOGY 222
>  #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
>  #define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
> +#define KVM_CAP_MEMORY_ATTRIBUTES 225
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> @@ -2238,4 +2239,20 @@ struct kvm_s390_zpci_op {
>  /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
>  #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
>  
> +/* Available with KVM_CAP_MEMORY_ATTRIBUTES */
> +#define KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES    _IOR(KVMIO,  0xd2, __u64)
> +#define KVM_SET_MEMORY_ATTRIBUTES              _IOWR(KVMIO,  0xd3, struct kvm_memory_attributes)
> +
> +struct kvm_memory_attributes {
> +	__u64 address;
> +	__u64 size;
> +	__u64 attributes;
> +	__u64 flags;
> +};
> +
> +#define KVM_MEMORY_ATTRIBUTE_READ              (1ULL << 0)
> +#define KVM_MEMORY_ATTRIBUTE_WRITE             (1ULL << 1)
> +#define KVM_MEMORY_ATTRIBUTE_EXECUTE           (1ULL << 2)
> +#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> +
>  #endif /* __LINUX_KVM_H */
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 800f9470e36b..effdea5dd4f0 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -19,6 +19,9 @@ config HAVE_KVM_IRQ_ROUTING
>  config HAVE_KVM_DIRTY_RING
>         bool
>  
> +config HAVE_KVM_MEMORY_ATTRIBUTES
> +       bool
> +
>  # Only strongly ordered architectures can select this, as it doesn't
>  # put any explicit constraint on userspace ordering. They can also
>  # select the _ACQ_REL version.
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1782c4555d94..7f0f5e9f2406 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1150,6 +1150,9 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
>  	spin_lock_init(&kvm->mn_invalidate_lock);
>  	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
>  	xa_init(&kvm->vcpu_array);
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +	xa_init(&kvm->mem_attr_array);
> +#endif
>  
>  	INIT_LIST_HEAD(&kvm->gpc_list);
>  	spin_lock_init(&kvm->gpc_lock);
> @@ -1323,6 +1326,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
>  		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
>  	}
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +	xa_destroy(&kvm->mem_attr_array);
> +#endif
>  	cleanup_srcu_struct(&kvm->irq_srcu);
>  	cleanup_srcu_struct(&kvm->srcu);
>  	kvm_arch_free_vm(kvm);
> @@ -2323,6 +2329,49 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>  }
>  #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
>  
> +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> +static u64 kvm_supported_mem_attributes(struct kvm *kvm)
> +{
> +	return 0;
> +}
> +
> +static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> +					   struct kvm_memory_attributes *attrs)
> +{
> +	gfn_t start, end;
> +	unsigned long i;
> +	void *entry;
> +	u64 supported_attrs = kvm_supported_mem_attributes(kvm);
> +
> +	/* flags is currently not used. */
> +	if (attrs->flags)
> +		return -EINVAL;
> +	if (attrs->attributes & ~supported_attrs)
> +		return -EINVAL;
> +	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
> +		return -EINVAL;
> +	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
> +		return -EINVAL;
> +
> +	start = attrs->address >> PAGE_SHIFT;
> +	end = (attrs->address + attrs->size - 1 + PAGE_SIZE) >> PAGE_SHIFT;
> +
> +	entry = attrs->attributes ? xa_mk_value(attrs->attributes) : NULL;
> +

Because guest memory defaults to private, and now this patch stores the
attributes with KVM_MEMORY_ATTRIBUTE_PRIVATE instead of _SHARED, it
would bring more KVM_EXIT_MEMORY_FAULT exits at the beginning of boot
time. Maybe it can be optimized somehow in other places? e.g. set mem
attr in advance.

> +	mutex_lock(&kvm->lock);
> +	for (i = start; i < end; i++)
> +		if (xa_err(xa_store(&kvm->mem_attr_array, i, entry,
> +				    GFP_KERNEL_ACCOUNT)))
> +			break;
> +	mutex_unlock(&kvm->lock);
> +
> +	attrs->address = i << PAGE_SHIFT;
> +	attrs->size = (end - i) << PAGE_SHIFT;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES */
> +
>  struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
>  {
>  	return __gfn_to_memslot(kvm_memslots(kvm), gfn);

