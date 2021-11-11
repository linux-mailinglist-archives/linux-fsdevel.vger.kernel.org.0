Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A695944D06B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 04:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhKKDd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 22:33:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:43891 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhKKDd0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 22:33:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="219732205"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="219732205"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 19:30:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="670102683"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 10 Nov 2021 19:30:36 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 10 Nov 2021 19:30:36 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 10 Nov 2021 19:30:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 10 Nov 2021 19:30:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 10 Nov 2021 19:30:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM7mOL4Isqqd/OGWBmGLIcdESL2rmw8N7NPoFWAE/D0IEY01dn++vrwcOG/AaNuTNwsdbVvXpxps5/drhpt7hWuyW2rwZwXYDt60MHtagbLcy9aKaDJszJEFrggEElx5KpZ4VEIpiyRBwZzqUQmtcEyt5Juv3Sk+cOsxa0Xpq288Bf9Vx3JWmLU6W13NRvejcm+/RtNwsOQwbdzKyo5T8VwZUHVrKQmLOKH/1wQNavQbvLZaZpWsYzWO240vXiLzsFUO9R+y28UB0ixGtM4mb6NjqPzPAJSV1dHA2nDa9VB6dGKl1TA1GC2hPk6x0Wyu+HI6eBa25jj51uc/K5Lung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJ9PUPbgM6ABBJt4mzkOQY38bN1I725+AKLT6wzoK6o=;
 b=ej7lTNGJeWSHOBhLdgQnYQbpMPSnvDJQUXOLx5Ga7jxuHLX3d3wOS9kdA76rMX06PeciZSdsfp+qDxXqgi5FdHPxE42kw2qt/S+FPBftBal2vzFJJkgTBdNfFQcB4OJnxm7MDPy2vr5J6bmD9XkmwCuGTIGW+ILEZi/mP1mnj/5qyomoS9FKjsX9hnPZgTfrRgPo1ryKnetwtzYNFqYRrgIWo87Yb4AjgV0cJlkwx3SBRBY52QbWHxJ/q5qZsV8GddX7VoWjZNKl5hm3bdDzfOAqQbLN2bLxPMpMG64EVn6DGf9SsibpyhIV2lwPswm0CAITSTGkMwuH/nxNLeSYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ9PUPbgM6ABBJt4mzkOQY38bN1I725+AKLT6wzoK6o=;
 b=TNiKV9p8SwgFChKbtUwLp89UKeTM3oNRW1IAbDIxO/9jpNrPz8G9FYBaRmYrDlXQZ4swAdT1hbLaPiQz1mYXpwmrSIPys0fzjIlXm6RzqYWvuJW0D4z8s+rOwFlflxdVuy0OsCGQOrah+t+6U/G6UC15e7CR+9KRA28UZEl/ssQ=
Authentication-Results: digikod.net; dkim=none (message not signed)
 header.d=none;digikod.net; dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MWHPR11MB0013.namprd11.prod.outlook.com (2603:10b6:301:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 03:30:17 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::b5eb:b136:3d26:d4e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::b5eb:b136:3d26:d4e6%7]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 03:30:17 +0000
Message-ID: <00da8188-8b8f-d1c0-ad8c-dfd79e52f289@intel.com>
Date:   Thu, 11 Nov 2021 11:29:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [fs] a0918006f9: netperf.Throughput_tps -11.6% regression
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>
CC:     <lkp@lists.01.org>, <lkp@intel.com>, <ying.huang@intel.com>,
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
 <95966337-b36e-f45e-6b16-f433bcb90c4d@digikod.net>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <95966337-b36e-f45e-6b16-f433bcb90c4d@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0115.apcprd06.prod.outlook.com
 (2603:1096:1:1d::17) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
Received: from [10.238.3.74] (192.198.143.17) by SG2PR06CA0115.apcprd06.prod.outlook.com (2603:1096:1:1d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Thu, 11 Nov 2021 03:30:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c42d377b-7ae4-4adf-77dc-08d9a4c39461
X-MS-TrafficTypeDiagnostic: MWHPR11MB0013:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB00136B0892AD88AEB9AAB951EE949@MWHPR11MB0013.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSDlhl4UGWxTs87qEM0zJVPdIZQtK1/sSlwKXiU2uO90JpDA+MIEmjan/job9AhBChd3RgPLMccdq7hnEJSMrSIpECGARt/s5OKBrDMVpLHVjIGCppJUZRZmyncRR9UWQV70jCbFvpH+h0+7wfpN+cL40XwP93z8bTz3mkQ6gWzrP3SRNEndWb5ZV4n6LDJ0OCCCNXE+z3PFEnzUHAG+2n7vnrSUGXDGxFjC47LVRdHmrI/tlIxj5GhZazoIgCV7xRysiKbmWP6WBRsnac6ZlZd7ApV/MJq54u50Xd/iuiB/Y1nXgEr6j2ZsJm+lGEguUzspxyWYNdOYbL6z7REL3gqOUR5AAQkapAm1KiiDijhmIDUOepn++7+XS1fVWrkjbpj4Yhc6ToVKz4zeVLphTAeb8wU86tGV8uCa/1W17gYcEivvIvlkfpwTPOncu3KqZl8uGJkEl/1EB6SLLhf8GsMCVmB+eZT9Qb48PPf63A2EiDziE0KAA7gDf2kLu5oy7E06/+qeY22hQUVBmYFuxvyEoo1BXu1txd6uqntO7VtCK9mX1e5tJTWctGy1qBknwOk9kdQFq9WMU8Jsg91sc4X1h9GPA4dhK3BQN6b8/vCPE8KXBRMdJVyKHc8kvBdj6XGly54LN/oBN+kZ8JWPAlDdnBmRmueMRf7+pPkuosLVGYNcTcE6igrzNspLxnPQ7f9aMOlYsR0J3bLgjDegz+Q0c+D4ImF4q+glkNEKXUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(8936002)(2906002)(66556008)(7406005)(7416002)(66476007)(6636002)(66574015)(31696002)(82960400001)(8676002)(508600001)(2616005)(4326008)(36756003)(6666004)(956004)(16576012)(316002)(86362001)(53546011)(110136005)(54906003)(26005)(186003)(31686004)(6486002)(5660300002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1JtV0JvRGlONGYxRDVnWHRmdk1uK0hzRzA0QWd2L0hzTGh5UG51L0d1ek9X?=
 =?utf-8?B?Z3hvMklMRmN6dWNjUEZJdGZ0QWNmSFlqa3EyWGhDcUgza2pCejdEckFIZGdN?=
 =?utf-8?B?Z1oyTkxYTEovQW1XVVl0K1p1UXFPQ0J3L1BuVy9kYXB6Y0RnTHFSKzNsVUJI?=
 =?utf-8?B?cmJKVTkzb1dvamlFWmdiZEZKaTFYNW1zalB5LzFnNzVUcWxVZEtBRFU2ZmNn?=
 =?utf-8?B?SmFRVWlNbDlSa0VxR1o5aVRtblZCTmJJZjZyMk01MHVsQnZpTkwvWGc3RHU2?=
 =?utf-8?B?b0JiNXF4RWw4NmtlbmE2TGFNWTVheTBQaWZ5NHNQOHpNaWZaNGRPQ1kwL1Bh?=
 =?utf-8?B?VkcvMkdPYWhJWTNIUEJVVWNwLzZkNzBYNlhYcDRjSGVMNWVuZ0E1N2tISWE2?=
 =?utf-8?B?bHh3Yk1SYWNTZmpWZ1dNV2QvcXRnK1VoUWZ5ZDVPOEQvTHQwM1lTeEFuZlFZ?=
 =?utf-8?B?andpazg5SndHNmJpRlZ1UXpUL1lCVTYxV243WDI2d2Q4QU15b05PeUFKZll4?=
 =?utf-8?B?K2ZDaVh0b2ljRlI3cnhRa2Zna1pFZzY5MUZFa1RsNW5JZXpyWGQ5Tk9DbVMx?=
 =?utf-8?B?U0RUdFA1WnVUT3ZQSWNYNUdOc0hpa2pzSzhldXlYV28xN3BKZ3QxRkFGNEMy?=
 =?utf-8?B?ZU9KamIyWjBTWFNUbUNjOVVQbFBrckJoS0IxcHNyWGhZRlA4QU9qRFdTMlc0?=
 =?utf-8?B?aDNQRjlDY0c0dWJHc2tva1lEKzRET25iSG9OaDRqbXVQQnpsSmRTdVdqVUFU?=
 =?utf-8?B?Rm04NWR4Sk1lQlA5YkhhUHdYMVU4aHZxTnZ0elFFZ0c5bmkyR3J2d0szL3hn?=
 =?utf-8?B?U29GTTJsY05IWGRLM2V6eUZnN3dOOFM0elEzRFppalZXREsrdnR2RTB0bzJD?=
 =?utf-8?B?b2FReWpPM3EwSWw2MFZ3MW1qOVF2dVlRTUw2MjE5VHI0SDd2dFZaOG9sRzFE?=
 =?utf-8?B?L0VwbXlQVkdMdGo4ajJSSWxnTjBTRmFERHRZdEpuRm9pRGlkMnJzMUp0T3o0?=
 =?utf-8?B?cG5yVytkMlhGSjlESytCdkFIUXpBY3ZpMTJ0K290dVlkWG0xVXMrTUUwWFlI?=
 =?utf-8?B?TmpZcTAzanJwMnh0N2x2bUpPS0pBaGdIVEkxbU5wVnNKOXRHQzJiUCtkZGRT?=
 =?utf-8?B?QWc3TzkwVUFwck1OYm9EckkyQ0twbktRSnJpVEUvN1JkWitVcnYzTWNhNDIx?=
 =?utf-8?B?c3RjWDhDRXVXTzVVZkFKS0owaExtbkNTZ2l6VGRONjBaZnlJVUUzbjJSOExn?=
 =?utf-8?B?QU1vcHJXM3FWOUNvQVRWR1I0RmtJMTBjVXU4T2FSKzk4MmoydkVvTUNaUjd6?=
 =?utf-8?B?NEhkMjZyU2Q3NzYwNWVvTlNqd3UwRXlwaTBGWmhIdUhjTk8vWTMxSWtOdVU3?=
 =?utf-8?B?QU8xRkZQWTFiWFptcXZsdHVjdFVibURBZFZQK1FNN1liUTBRNU1ZaTJRcTNw?=
 =?utf-8?B?NVVWRkpFQ2l0bCtFNWEwVFI0TWVTYUEzaHQvK2ZYZXJTcmpXQldsUVJYUDIz?=
 =?utf-8?B?bkczKzZGWTdoNERtVWx4dXFHcHp5N1Vna3ZGQlh4WCt4TjZYRndQU1BMMVBn?=
 =?utf-8?B?U0haWnBGYmNBb0ZwMkVaVUE3U2I2Zm1xZmpUQ1FrQStlM3BTSHhFclNoZkZX?=
 =?utf-8?B?TzZnUGVYbU56TnZQM3lzTXl3R3Y0ZlVHVVlVdUNJOS95YUpmMG1QSk5Ha0JK?=
 =?utf-8?B?K0VJMDdjS1NtOGhkcnljdmUxM2x4R0RzWDFMdFZkRlVBRlJYRFhHOUl3TXZS?=
 =?utf-8?B?UisrV09TaGFCR0JkSlI1VDBaUDZCQ2lvVXZLeHVrNlNqYUMvNUF5M1lHVXRZ?=
 =?utf-8?B?dEkxOGpFWjdpWlFrRjNTczRONENPWlY3L01aMFVXMTQ2NWRPSzFYdUNjbEQ3?=
 =?utf-8?B?ampaRE1HQ1VTdGw1ZUVMZzZoZjNWQ290MjdCSmwzQXFKV3VjLzR5aDRhZWpS?=
 =?utf-8?B?OVc4UFg0Vmw0Q0VCV0lHbTFxSDlDSkdRZDRoVzJkendweTFhYlUxSHdrRkpr?=
 =?utf-8?B?NUlVMlZUUldoMWZYQS9YU20vNmxiSURRWWRkWlJHZUFnKytLYTdDRThsMWRW?=
 =?utf-8?B?SHNYdjlZdS95VWd4QXJoODB1cWxjRXNqN0Rvak9lTmNhNzZoL1dMcXUwb0Nr?=
 =?utf-8?B?U0JldHA1SVFwVS9lWVZlWU1PeFhDUGlaNVg3dXFYMHgzTHlBTm1KQWZUZ1Y1?=
 =?utf-8?Q?krV0niuf2N9tAINj5JJn16c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c42d377b-7ae4-4adf-77dc-08d9a4c39461
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 03:30:17.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwyHjDHpFErkZerhdSgvnulIphR02Pqbj2H0nhXudyjQC5vbuY7FzQGVgZ8iaX1tngSxLaahbSyi0OZz8jFwuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0013
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/10/2021 4:52 PM, Mickaël Salaün wrote:
>>> ---------------- ---------------------------
>>>          %stddev     %change         %stddev
>>>              \          |                \
>>>     555600            -0.1%     555305        netperf.Throughput_total_tps
>>>      34725            -0.1%      34706        netperf.Throughput_tps
>>>
>>>
>>> Fengwei also helped review these results and commented:
>>> I suppose these three CPUs have different cache policy. It also could be
>>> related with netperf throughput testing.
>> Does moving the syscall implementation somewhere else change things?
>> That's a _huge_ performance change for something that isn't even called.
>> What's going on here?
> This regression doesn't make sense. I guess this is the result of a
> flaky netperf test, maybe because the test machine was overloaded at
> that time.

I agree the test result looks strange. But I don't think the test machine
or test methodology has issue. It's not possible the test box is overloaded
when test case is running. We did test several times (> 12 times) on different
days. Thanks.


Regards
Yin, Fengwei
