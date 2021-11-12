Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E77544E64E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 13:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhKLM23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 07:28:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:5401 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231231AbhKLM22 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:28:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="230585995"
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="230585995"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 04:25:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="670639203"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2021 04:25:36 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 04:25:35 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 04:25:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 12 Nov 2021 04:25:35 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 12 Nov 2021 04:25:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQTQU18M3mltFM+MJY+cTEY95NoXnrSJJCdOPoN45P0hSyxGPNWSJQyy+mYMyHuqZKA7DxAVwAc1+OSoPf0Ir5oLLW4bkNXq9I245YBRFf4Tl+O26LO+F5iplZQN4k/9OJJWKxbFGNlVUQ2+GJ3Ac+LblC19dY+wnEGWNzxDqSEg6J5Cqg8lpHSdieha/6lsxlwt8V94gAd+UBeZ+gCRUEm6eX8NImvrXm+uWa7HYKoGoaB0LUI/U5Bw8O9q2oZGq18efG8m9Zq+D/+JPA/d4U9ebwBG3iJ+0j2CN027gVNOdCLF/fmOb8Wye7oYeMU++dtx9If2AP2wwY/oACCq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkylTRdJMTOPlOmYlqfUDh1NOPuZ0yIoMS5covUK/K0=;
 b=nsK8j4I+FhfQZWzto+uuPON2OIQ3TYaQUqTBeq8Q9DAFH+fDSvd89pXUZ2yXdESxK5c2lKek20fFInNBKWiRC6DCg7TbG6cSktCihVv+djSoyltY2F/z8krn9LFR4NSsSjVSaGPnZ1PdhBRNJVsvBP8bBHJ7TV/+YuzULmRRubX44HCwzev3YTkcPgWAiU34p3UmK5SiSBargWedLTpBDCoZ3VVipKWwTSdE7ITtZEmzB6py72igdzdgIfehb6zSeWuGtGAKsNHdJNQGppZqGepc8c+qhxKhSiaq5lZmqzTDh0vRIlqc/YBBRBy+5G/MM2+VqMHd5IUzh60abT29sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkylTRdJMTOPlOmYlqfUDh1NOPuZ0yIoMS5covUK/K0=;
 b=UCTxkgh/CPy4Fzklo1y7NLFoMu5ZEkGkROBGD7utjiGVoxW5hsMqyPz/cl4SyC7F3jFvNoil3YkqN66buNFIneMKM43mcmrAJoSvcqDhakarbVYsulp/OMMtgKGmOWVdvIV+GJkszWnG1jdG2R2KHvOVHSj38ghdzzM3Wf87UyQ=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MWHPR11MB1357.namprd11.prod.outlook.com (2603:10b6:300:2b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Fri, 12 Nov
 2021 12:25:29 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::b5eb:b136:3d26:d4e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::b5eb:b136:3d26:d4e6%5]) with mapi id 15.20.4690.026; Fri, 12 Nov 2021
 12:25:29 +0000
Message-ID: <c6d3b7c2-4724-4dec-d29a-dee8f7e8cfc8@intel.com>
Date:   Fri, 12 Nov 2021 20:25:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [fs] a0918006f9: netperf.Throughput_tps -11.6% regression
Content-Language: en-US
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
In-Reply-To: <202111090920.4958E610D1@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0189.apcprd02.prod.outlook.com
 (2603:1096:201:21::25) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
Received: from [10.254.213.132] (192.198.143.24) by HK2PR02CA0189.apcprd02.prod.outlook.com (2603:1096:201:21::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 12 Nov 2021 12:25:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f72abbe-a3f0-47b0-bf6e-08d9a5d78323
X-MS-TrafficTypeDiagnostic: MWHPR11MB1357:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB1357BB0556136CB5C3CA3402EE959@MWHPR11MB1357.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwzcI18bPN7jtca7rGyUY51miBSkgVRyKhb0OmnC9ssk94In3skndpPLdtTl3frkVHypQeEfCKUcWLDjyg+/3cLlclSM6zuc+kDiQf0NqRPd6Byrny+Zdzyxy/WiFnMZmr+EAyy2emKqUIFNvgRYDftHRtU1pjIJWDBtraVsD82r6GVMJ/15p3VS8o+ZmEJGzYOJ6oFl0cppub/xxjzQDDV0HrFwvE/ky3IJETJqkp1d7yK2uU0bcr+X4WiTUnU+xlAPelLkQMBCws/pcVJWJMejG86zs90jCCPu2jYgDFLdL+WNQErhcAeCSw2Ea8L8XU0ocMofTdz1gP5mjQq++win58saieYwnBJ28yDazlRJFizfzN7xuK19EY56im/9s2CV8d7gYqeG/lURZI7L7ksP7MsS+opJGzN6ZQDmaH/PnHYM9CPN91siJFP/0JfQFKkT7TcglM+eerm0AZ31pJFoQ4KReWR+4duNsqFGBLBGlm6l4jPOtBoq7Km6GznVT0aC4oPx4wrJMyenv00bj2qQeE8CAvXYyVnSXks/t4L129i0HVP9mTckS6NTnZVo6zPV0Q7VJUeSi9dbH0pQp7KNYa4LrNCCzJpFIwKDkODX/pgjoTTuOpdSgr5dgMvUvrJy7LJicsRJPH7KVbyS9MYDZh6/P9a3/Zw9VeVGVbNwDqgbz7eau+caO2LYQTBaRe9qpjNNExbgsBWM/Q4+m0ULprO/7AJ2UBDEjFqjNcXynEsuUkGdZKzn4+VlF/tB3wgOqBP+RRIlkVek6qpy/6mH6u2COg8cQ85O5r5oMinIS998qe/eq6MP1HUcOF7w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7406005)(4744005)(6486002)(4326008)(54906003)(31686004)(7416002)(316002)(110136005)(16576012)(66476007)(66556008)(66946007)(5660300002)(956004)(31696002)(508600001)(966005)(6636002)(36756003)(26005)(8936002)(6666004)(2906002)(82960400001)(53546011)(8676002)(86362001)(186003)(38100700002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzdWUXRvVDE2NHQwRFBwL2ZldEF0SG1FeXcyc0s2ME10V0VGNUlReUgzRS81?=
 =?utf-8?B?TURxQUNCa2s4b2FXUjdRaXZzTis5S01QQW04Z29oNk82ZGlFTFZhQ1ZoVklU?=
 =?utf-8?B?NXpVenpRMEd6S3BnSy9GS21kQ3VZTkN3TVF5OTBsakpEcjZMcUtUY2s2ZFM3?=
 =?utf-8?B?cDBFb1p3MGd1cU5yNTh0emFqWkFLR2NOZG50aHhBQUV3RmpzeWY5VzkwUG82?=
 =?utf-8?B?RnBuVTNhdmNIYWdVVGd0L0crUDMrRys0bTA1WFZ3NnBMa3hsa1hKNVk3NTZF?=
 =?utf-8?B?SDF6UnI2U3lnTkhqUldwL05Lb2tLTDVIa3h6WjR5SXVkVHFrYlJuSGpqWFBx?=
 =?utf-8?B?ZTRJMVpoQzBBTTJpVEhUOVEvZTJxaTNNNlhIOGFweWMyWk5nR3A3NTRIaFJ3?=
 =?utf-8?B?dTBiRCtDS3RLZ2lQSFdOZmI4a29vdVZ4UStidTdTOUU3SzJjdStscngwNmJY?=
 =?utf-8?B?OTJrcUtaOXpOS3VPL1E2REVhZGJNbDNGZEtkTDNvZE00dFh1anhzWmpya2NT?=
 =?utf-8?B?dkpxQjRJUDRSaXhPb1pSa2ZHNWVKc3MxQnoxd3Bsb214aTM5TlZiNnN6YmdQ?=
 =?utf-8?B?akZZU1lIMWptMUVlTXhHSk5PQVJYSlJYb1A0NWJQSE5pVW44K2RtcGx0SnB1?=
 =?utf-8?B?eTBMQm1DSnd2Q1pVV0NCMjNZQk1nK1N5VGdSU0J1alpCYVpCTGxWUkwrTGEz?=
 =?utf-8?B?WUxETm1NY3RzQkhtYjl1N2JKVEM3UTJyZ1ZvaE5RV0luU3BQMHIwYzNiOW03?=
 =?utf-8?B?aGZrUzk2VFh0V01MenJWM1JiWmRNdXVTWkdaTVVpaDRtcDdQY2tvSGFVN09G?=
 =?utf-8?B?bEdzUExYelBPNTZGMWxZNUFPWlpNczluNjJpYnRLMXYySkZKVFZiWjhvNmJn?=
 =?utf-8?B?dVBRUVU1cW81VUhEQVJYZkJ1dFFkVEljWFdlaWRsazRMOVVzSktxSHhVeCt5?=
 =?utf-8?B?b3NhNTQwUDFKZk05VXh6TFl1UnY3a25GVllRVVpNZDZXMllzRy9jdiswZFJ3?=
 =?utf-8?B?RXhCSXpBd2ZQREsvRUxtVHlVRS9XVUtxclNqY29WcmhPU00vbHRjbTNjTGZn?=
 =?utf-8?B?c3VGdDVFMlBHWXUzTy9ZZm9SbVJVc3JqaUN1NVc5RGRlZmE5OUUzTTU2TWpN?=
 =?utf-8?B?RitCY2VQSnA5aU90a2pFQ1N1eXpxR0UzVU1PamJTLzk3N0VtZ3RobzRBZzIx?=
 =?utf-8?B?YUVQSXFMWUVhRm1FWTlTb3F3aG1JNDd2bzlEbEFJd0c5SjVXKzJXRmltNk9N?=
 =?utf-8?B?ZkNtRmxjaHdTd0s3VG1lbUJkYUIrdmZZQW1KMENMVVlneHNUemdJZzB1R2ZR?=
 =?utf-8?B?a2V1dCtwNCtWYkZKOEFuSU8zbVdSZ3pxYnVwV3gyWEY1YTFpRGFNWXlvVSt1?=
 =?utf-8?B?TDk3UXFqM25BNm9vcFlBcjNGb2pJUnoxeGYwdFV0aWpIQkQxTldndjdrYmJ5?=
 =?utf-8?B?UytDSHl2VWxMQXl1aDh2V1VGNCtoTEM2NjRkODU0dkxvb1BHZHBoUkRteTNq?=
 =?utf-8?B?QldYSHVZWWRSd1RuVHpLaTQ4bEM4MmRXNXpsNzFwQ3pwUnYveGtNdjF4bzNI?=
 =?utf-8?B?ZFhkZGhzR2N6UmlFQnQyaUVJa3FKTWd2V2JJcU8yam8wSHgvN1FXSkV3NGtQ?=
 =?utf-8?B?VU9LanJNaERwVjFNTkVyL3NOcTdtejdzbElhd1djQkZLM3JRc0tiWi9UVnBl?=
 =?utf-8?B?dmVya3hDRTBpaXdkb1FkZG50eFV4YzRKby9aMDRlU3ROdVJwWkNXTmIyN1k2?=
 =?utf-8?B?YlZxcEl4MUlHaGIvcnZTeHZnWnZ6eTgzOXBkcjY5Zll0NFJiZXFGaExGRWRX?=
 =?utf-8?B?WS8wbmI0MlpqblFCRW54aWYyWFBPVFNYc2xXN053SzloNkc1c0JCRkx1ZWtO?=
 =?utf-8?B?UlNhTWc3QTMvYTAyczRiUmZzZGJCMFgzcVMvcFZVaEk0TWFhZXRnOGlTdEJa?=
 =?utf-8?B?SHoveFh3NUlVNjBxWktLenJHTTBMTU1ndUVDcmVNQ09TSzVIV0U3UTZlZ2I5?=
 =?utf-8?B?RmhucHZTMCt5cTJOajdqQ1hCS1hXMGpPci9yNXZSaTUrNW5nRmZrNU1oRHFk?=
 =?utf-8?B?YkduTnJJd01OVlNQUml3dVowSGRQWDJaT0pVM1VKa09OVVV4a1h3emc0RXZz?=
 =?utf-8?B?a3JaVjJhUmlpRWpBckdEQ2tNVjRHRitZNEpzNnhhUEVOMHpPNzNOWUN5NEhJ?=
 =?utf-8?Q?CwJVE8nEZ/uj2w17smV9wv4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f72abbe-a3f0-47b0-bf6e-08d9a5d78323
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 12:25:29.0198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGIV8pMPuPHcPHQeJeyF0bZqhglauUH++CGIF9DEAVPxWCMpXdSVCqwZ+RJphK+hA3oTU+0Pj6UShIngejYmlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1357
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees,

On 11/10/2021 1:21 AM, Kees Cook wrote:
>> I suppose these three CPUs have different cache policy. It also could be
>> related with netperf throughput testing.
> Does moving the syscall implementation somewhere else change things?
I moved the syscall implementation to a stand alone file and put the file
to net directory for testing. The new patch is like:
https://zerobin.net/?a2b782afadf3c428#Me8l4AJuhiSCfaLVWVzydAVIK6ves0EVIVD76wLnVQo=


The test result is like following:
     - on Cascade Lake: -10.4%
    356365           -10.4%     319180        netperf.Throughput_total_tps
     22272           -10.4%      19948        netperf.Throughput_tps


     - on Cooper Lake: -4.0%
    345772 ±  4%      -4.0%     331814        netperf.Throughput_total_tps
     21610 ±  4%      -4.0%      20738        netperf.Throughput_tps


     - on Ice Lake: -1.1%
    509824            -1.1%     504434        netperf.Throughput_total_tps
     31864            -1.1%      31527        netperf.Throughput_tps


Regards
Yin, Fengwei
