Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E33744BA1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 02:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhKJB54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 20:57:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:50204 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhKJB5y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 20:57:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="213306999"
X-IronPort-AV: E=Sophos;i="5.87,222,1631602800"; 
   d="scan'208";a="213306999"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 17:55:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,222,1631602800"; 
   d="scan'208";a="533889165"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 09 Nov 2021 17:55:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 17:55:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 9 Nov 2021 17:55:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 9 Nov 2021 17:55:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/9nD0w7fr7/pHll9Bx8e2Kj85DNfzP+g6wsUcU146HWuokr35lf1LMlUKeEKe6PXF0hxAD5fn/i4HG3l8X60gwg1TfV2UM5B7uvsIRj153v3P8uziu5IML4l84go6vWVfgL1gFzUbAQdK4TWR9ui5azdLyDzecDooRzkBIkDPbSj5AS21gd/Xk4ziebKCsfmCZoNu9UzjbyLH4dQs+9JS5jUfn6MHU0p5Y+72tB63siUT8Xo67lOliU6R1WZuIBckEtbPQOOlaRIvs6XAPNE01JNBVxEL+933kQDOWxlCE6y4LN8tPs9eMQJymPQyZgkUB9J2k9nb9jUzn6nGBu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qH+jh+tu1+7jgY2NuyN/0s15OkG8zT2abP2UYFEOZk=;
 b=m3n5Zg7lDveyCkUSCN85frP3tAOPq2mWiGbiSkqtY6yX+apQMuTjg3Bgk3cu01bMQRe/zWJTuU2Ro2pHgiDdbhuJ1Adgv84JcEaCyrPHVGAhpcnKytBXbZD9Xtpldsqcq3d9EnAXm4bXDr4Y3WYpqV++81fPVYARpoOwgD35rVMonu425fZIK3GhZgVBfFjv17UbNyguPk0+KoiW6jJrJNMAPxAtYIQOm2N1EKLqiLDLEyctY/7UxlCwXHAfwhUHVS3l/oZTsfGse+KN0joGny7Y4uGt2ewLTXzJpmQ67BM6vXPz9f+UvF+hcODo5Us50fP4qLHCrm3OZFdqwkVDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qH+jh+tu1+7jgY2NuyN/0s15OkG8zT2abP2UYFEOZk=;
 b=KNkIETYE0h8QsRsR3xpqRDZmsUKal66jrWvlu8tLUmzQT3zVgFJq+99oh5wjY9A1wUi4XraNhvsWQcXxWDjhv95KZwOCknTM3xXJKFv0TvVon0MBuBe7Ks14Zk/c15ZYSe2vH/AxZgjK6LsBCLEBvFZhO83CQbuWEtwUV+HaGMY=
Authentication-Results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Wed, 10 Nov
 2021 01:54:45 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::b5eb:b136:3d26:d4e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::b5eb:b136:3d26:d4e6%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 01:54:45 +0000
Subject: Re: [fs] a0918006f9: netperf.Throughput_tps -11.6% regression
To:     Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>
CC:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        <lkp@lists.01.org>, <lkp@intel.com>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aleksa Sarai" <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, "Jan Kara" <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        <kernel-hardening@lists.openwall.com>, <linux-api@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20211012192410.2356090-2-mic@digikod.net>
 <20211105064159.GB17949@xsang-OptiPlex-9020>
 <202111090920.4958E610D1@keescook>
From:   Yin Fengwei <fengwei.yin@intel.com>
Message-ID: <129a2714-bad3-6f91-d841-51121bcc6e8d@intel.com>
Date:   Wed, 10 Nov 2021 09:54:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <202111090920.4958E610D1@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0080.apcprd02.prod.outlook.com
 (2603:1096:4:90::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
Received: from [10.239.159.48] (192.198.142.17) by SG2PR02CA0080.apcprd02.prod.outlook.com (2603:1096:4:90::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Wed, 10 Nov 2021 01:54:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 938f4f3a-f4b1-4121-72f1-08d9a3ed1196
X-MS-TrafficTypeDiagnostic: MW4PR11MB5912:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MW4PR11MB59129EBEDD9295117FB796DEEE939@MW4PR11MB5912.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M03u3apj6pJ4/9PCABKx52uKs6zt+SHSP9v1U2t7kZ30kTDEElhfeZSSgcW4cKP3YfvzRP7cJCtrinzFtC7j4LaK+ZGyvQhVvHVv31z3hc1aolZzJX18fTwtC+M4qmMJBLCIDntlvnyDtkvlkgZv1niwcrpFdKwmmapj+hAJKSoE3YMvQSQcPZKoI2klxVjyMxg5/cGFLSG0+78hIE2O9XLTbPM5eKaOGphTeFqoVgupFneqIYGS3EunQHrRWOh/FqaqcaHWyVfY+l7HiU8b8h0VkBklIuL49/V0okoPj7/nvSl2qFQgHta/YxlPsXbu1MPv+NAy8grnnMJGKsPFWs1Z/h0B3ti2xqRFMfzFDKXElzRLxpKMgy0AOJ8RyqP5vTF0JMWbuR4AW3ZOb+k4vO7YxFy6WcvsOEH9mCVKM2cY1zSUhxVRir7aOiRoDJYQ5JPdz6kz3cTMIiUZmbsY4vbNV5zLULSnXaubb0x+9gEd9uR+NWQ4WH54AZPYXGCzXP7pkC08eJNPf75vn6qJYJQjUa4d3+CM4eVAdObn7XDikYoJaj9V1JrvYCls4mD/fXiylAazUD3KHo2RTxcZl0fu/Z7Rtse9HGWEgpMDuOXOSKe/lCHwQZjJbVLvR/sJ83BIbKgOhc1q6m5eWsxSS5cMMM4GBRKeTdAkI8Yyn0KpCrr48ndaQmu/YN4wpOWGC6tFuEr7OdVZsOhZOIV2yRHog4dR11zjvY9Lxn8VB4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(110136005)(4326008)(16576012)(38100700002)(6666004)(36756003)(86362001)(6636002)(5660300002)(66476007)(26005)(2906002)(54906003)(186003)(7416002)(8936002)(316002)(53546011)(7406005)(66946007)(508600001)(82960400001)(6486002)(31696002)(66556008)(956004)(2616005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkxUNUlVZ2ZLbnBLSWxpVzBYa3ZScXhjKzQ0T3dicXpFRnVjT2V5ejI4U0pn?=
 =?utf-8?B?WG5UM0hlRHVmT2hKSGhyVWpnYlZsTE9IWUlGWFpjQjd1dU82anVOR083dnNE?=
 =?utf-8?B?Qi8vMEpaaHZEdm1WSmJXNlpxRHVSTlRqRXhLM0s2TFRaOFB2eW5DTTlTVjZZ?=
 =?utf-8?B?MXhNNVJ1L09uYzJUejdxTGVyM3R0aEk5M2EwbFZWK1orTTlnNHE0NWtvY0to?=
 =?utf-8?B?UEx2OEQwRk51c1V2Q3hobzNPYTJsaUc4anNxbDJtWHRrUndQYXRGSWUrV2VX?=
 =?utf-8?B?Mmg3ZkJtZ2UwdG5lcWNJa1ZoajVKaHcvb2RIcjJnMEpKUUpuamtNaDlpMmlF?=
 =?utf-8?B?QzF3RGNGM3BZQW1XYThkWU5YVE9YZGc0R3FYaEhydGwrbEVuNjU0T2lKZHJT?=
 =?utf-8?B?ckhrWHY4Rkh4c3U1QlNuTzlNOWFNSGJVa1Nza1cyUno4bGFMMUdjRUxkNnNM?=
 =?utf-8?B?NW42TStYSVZCMm53MkdjVTl2bVRFaDAvRjRQVEQ3SDhybU03OWptU3phSlBB?=
 =?utf-8?B?bENwV1p3RUtWbTE1NjhOODdHK0pCN0dlNG5TTlVrU2Qzd05GV2pZQzdoS3l1?=
 =?utf-8?B?aVFHNlFZN09oUmF1dXo5ZHVtdUNJS2gxY2lNN2VmSStxYnhCSUZEQTViV1N1?=
 =?utf-8?B?UFlQOURkc3V3Z2NyL1NTYWdISStVY3V2dDJZbGIvaEUra3QrRHQxcVo5Q0RB?=
 =?utf-8?B?YjlWd1FkV3NjWkdST1dIOTVNWkMvcjV0eW9xQmthdG9nRUlYYkR5NWN4VUZp?=
 =?utf-8?B?ek5XOFZ1Zi9mZG1KOGk5QXNDd0dKMWZNVUlTRzlHbVlBdm0wMXMzWG8wbzNX?=
 =?utf-8?B?QzgxL0ZaaGN4WXgrZ0d0ODNTTnhmSGcyTm52K3lZVGxvM3luZi9YcU9hYk5X?=
 =?utf-8?B?OUEyRk1oTkNFMTJZYVhWb1k5OTZNZ29CeGhOS1FhbVkveWoyQXp5RFpiaWFY?=
 =?utf-8?B?YnRCc1Z4TXZqc3ROSC9RaEJEcDhRek1DNVVJSHJ6bnVLKy9RZ3J4TFFuRXNw?=
 =?utf-8?B?S1ZRU0JQZE1OTk5kT1hqamxDRzVOZlFMakcyU0prQ0NCbjEwSk5pT2txeXpU?=
 =?utf-8?B?ZUZlcUxLMWRkKzVsU3FMZHRqVnVYNVRGK2MwMExQL2dpekE5K3puaDlSUm9K?=
 =?utf-8?B?ZEhwcFJSUExvbkNpUWFtbW1CUUMraXI0d1pzZWtBNDdlOFpLUHcrcGhsZWtv?=
 =?utf-8?B?NlVobGI5dDF2djN1b1IvMG9SYmxHTElvYnVOdVk3T2ZDMTlVSm9ianFENWJ0?=
 =?utf-8?B?amU4WEtSL3FWUnI4YUt3OGNNWjc2bFozYVprbnNIMHkyNnIrY0JMS285Q3V5?=
 =?utf-8?B?aXo4ZGJRMlRNQ3VSYU85TWM4SFF3V2VyUTcxcTJnbnJyNlJ3UE5JYTUweDBt?=
 =?utf-8?B?QnlHekZ6SWtJTUE5OGhjNi9mOWhmblZndjI1SmhUZmxpcGhDVktiaGlYY1U3?=
 =?utf-8?B?YkxsYUNpdDJvWHFXU2NZalV4TDZDbnM3VUVOdVBINTZmVWkyanVha3JzS3Vz?=
 =?utf-8?B?eVYwemlsZm12L0ovV29Fa2s3UkdtOEsyVnNjd0NncnJPVS9Gbm05Vyt4KzFI?=
 =?utf-8?B?N2lZdHl6VlFKUGdGd3JzTSswTkpHSUduWC9vc3BJVW9ONnZEMEtJNS9GM3I3?=
 =?utf-8?B?dUdhWkpPOGlzVVRvWVhRczVKd2hRbkpvbVZ4MmF3dThKTTBsaWpIemE4S0F3?=
 =?utf-8?B?bTRsbnVWMlJYbUxta1FXRzVEQnZiUTR5SFhMTmtOQkdIV0MrQm1yWWo1V3Vj?=
 =?utf-8?B?Mlo3RThra1BEeHJzc0xkaUhzc3BHa095bGw5THQ5V28yRnFIWjlZWDBwWnVo?=
 =?utf-8?B?MktHQXQxTWUwa3FTNkZwRFdLYWxSUHdLbkVSVFV6VlBHZTIrdldOSEtzTWRI?=
 =?utf-8?B?L0FDd011MEtSK2ZlcGJEVUhid2tsRjBVaDhNWVo2RWowVlBFbWxkR0dicWJ5?=
 =?utf-8?B?MURaYVB2VS9EbWhVKzA3V0FHOVV0MzRtdDlPU1BJQ1Nka0d6M29lWDltb2Nn?=
 =?utf-8?B?VHo5dVpuRTJTZlJiaGR3TzZ0WmJNUGhIeFVQUEVROEdBWkZBdHprbHB5Y0di?=
 =?utf-8?B?cWZTUzFtQ0gyTXFSb1dwNXFvVVFoREdENm1RWG0xb2ZmZFNHVkZFUE50cjNK?=
 =?utf-8?B?bllpNWEveTBqcmV2azJFamNUQTVESWVMSnpmZlhsdEdYb1hwOVNZWlI4M0h3?=
 =?utf-8?Q?oR1rRnt8WEX7ddXzyRzLOn0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 938f4f3a-f4b1-4121-72f1-08d9a3ed1196
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 01:54:45.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3Jh1BornAHvLfcEGSzOil5/EDZUGq567DvMmF4M2Ih/xr3AL3FPnYQL4uwCAJ+L8gVE6Zk6BRxRg5iFLzka3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5912
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees,

On 11/10/21 1:21 AM, Kees Cook wrote:
>>     555600            -0.1%     555305        netperf.Throughput_total_tps
>>      34725            -0.1%      34706        netperf.Throughput_tps
>>
>>
>> Fengwei also helped review these results and commented:
>> I suppose these three CPUs have different cache policy. It also could be
>> related with netperf throughput testing.
> Does moving the syscall implementation somewhere else change things?
> That's a _huge_ performance change for something that isn't even called.
> What's going on here?

We just tried to do trick change to make sure the new function doesn't
make other kernel function address changed. But didn't try to move around
the new function even it's not called. We could try to move it around to
see the impact to netperf throughput.


We tried the original patch (without change to make sure no kernel function
address patch) on other box. As report, the regression are different on
different CPUs like:
       -11.6% vs -5.7% vs 0.1%

So my guess is that the different CPUs on these test box have different
cache policies which cause different performance impact when kernel
functions/data address are different. 

Yes. This is strange. We don't know exact reason. Need deeper investigation
on this.


Regards
Yin, Fengwei

> 
> -Kees
> 
