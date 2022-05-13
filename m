Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94247526A5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 21:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383810AbiEMT17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 15:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383740AbiEMTY2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 15:24:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6238E2FFFE;
        Fri, 13 May 2022 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652469754; x=1684005754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LBxBYlQp8eFjaK/ngAucutMPFcTeHXHXaL2qeOabVkY=;
  b=N/7WikMj6q8Xp5P1CtvD9J4FLse9f4ek5uWFI9rUBi68+rSZl8nKuk/B
   WycxV6nJxl3mhAh9MvQ7o9vivgZ5K0sV7qYvPGLHVJQ7Myx7UWbqseN51
   hjcNIQ6csglu0jvkXfg/oHT9nvXHOKZAKHpQ0dbb10dvb65bnW0Ugi2bZ
   bMXiEGgcCDAIAxunSGmQNqa8mCU3AHeM6j+pCb9ROjUtQzyplcFh71q6t
   /Ys9urIuXIkGsHU0cVGb0NwJKrL5OUXTjsGKQoxzOnGe1towINxEdxciy
   dja67c4nnDxYl8DmNBLpv87dIkx75tUTdu3w7MOEz8IQPpmTmVQwQP744
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270323724"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270323724"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 12:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="567330721"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 13 May 2022 12:22:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 13 May 2022 12:22:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 13 May 2022 12:22:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 13 May 2022 12:22:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbGCCi2/6TNScwVTVhWqq/DxAX9qlQSMNaWRd/gyWMXRF7Xc0dXdWnoKmDlyMwUNosonTSBSPmJS76pTlcMNQIGeH5k9lZ6VyeKgRlaGrCXUv8AiFMwDV2SJoRZ7HCQHyx89DQrX9Ym/ak/fEyGFotMzBly0jkPAcykYqOWmlVDk/Utvoobs5F2MwYrEuq41VIGpXn2DqeVPH/xNTlzhTJ/vmHV/mvCj1pjd2eJF1LXjOEn6ay6TG89QUo6tkJ38nzU6qjaO42rGCX2bQkjTZzvmww7U6k6Yug8tnRzECEcSi7WEdCNmFCfjtDLF+VFBMt15Hs1iR/Qomxh4uJr4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Q9Qw6jpI9s+jNBZdfRE1LN64n2KMo2/uN9jD6p60Pg=;
 b=lIVmSaA+AWmHxCVptnOMZ8IWrVyU8d/IdDRqIVTvv1SqeQLhSobXc/22FCnwbAhCaMLOX/L9rYZ9vstAxP9jxYhKFq42chqufrHbe+By+nN4AoFJ+fit8voUXYyjRGjR4jls7EqQd0ZUaK6NoA+lZ+k2qoQ1EG/13SiSXZOh3GTt/mr40HSNDDb9B5cXzZ5BSoNtDhAk8ONj8eLnqx7L6OyIBdpVsAMNjSc3k7ETih+wjFL6Sib/4BasALpoBUxX2G2gFrbDD4Kwl4gAKr4hfmaezo5qnQ2vtcaLXDgoLEMPTqx3hNZzs/NrBG4eseQ9q2YZl+jMfA0JxQ2/6WxuMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Fri, 13 May
 2022 19:22:32 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5227.027; Fri, 13 May 2022
 19:22:32 +0000
Message-ID: <b194cec9-097d-1187-3d4c-9dcbb96bd3e8@intel.com>
Date:   Fri, 13 May 2022 12:22:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH] MAINTAINERS: add Russ Weight as a firmware loader
 maintainer
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20220512185529.3138310-1-mcgrof@kernel.org>
 <Yn3vA+jN4B8C8g0T@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <Yn3vA+jN4B8C8g0T@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::30) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70db3a14-1545-4c13-ef46-08da3515ed50
X-MS-TrafficTypeDiagnostic: PH7PR11MB6031:EE_
X-Microsoft-Antispam-PRVS: <PH7PR11MB603196259AF435D94F3DB260C5CA9@PH7PR11MB6031.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZqhHzxUP6xoRruHpFQFHwg+P1VE9irmOQMMjOzlTww3ZuaV/Z+qGkUoIKgdypXt11D6BcAm3tHFmi3/yVN313ZGmGhC6BKemc8r0KYkqqDzNwwfRyQgnZ0kyhkPBkSjckEmVYdEurhrjwrlTvExmA7HBtr0HulhgdSl/mRZCXlYkAbCsTaT1BOAYcJDK8m/impSuSynwG9LV+8CEHYkUCB8Xd0PQ0Zrz9gxD8aN35bxkSE0Gu83m3LdUjf3KcYZURa06lNbIQk7Cad9uFybCya2Gueds/tPeK8cUu6xvBNlKBIl6MyJrbSFUByvfE812fBSdvySqcbr8/rIiqWWkXgMcclL3A4OCe7xb6JkfRWoDNpcaM6cBEiaAbv93XwVlrsEVh18Q+6SSlby87/Dv7MX/qW0dt5MUv+VK2Zu6e/daLrYlmkcutylhjFjrGA6Jolg4xrd2FVaGhO5gLn+TXOvHolCc6w6AZ4yqM59HHzgrUsaCrvfzEbmQUc+f3MQvEISCgAB4ojlIIIWZ8LeGqDYTxVEaYK3FfLADmOIarmnFUU/hJUo8P8Y3LD6LPMIoVFuUz+ziI9IhYhVVqHIUObrUsQ7OR3NzWJTplaPmuGH46Ul8VNg6HtQXHJYoEPTS5OqmRdMV6K/cNZaAQWAgxnrGsJJy2W7sdr7jUF70m7+SINZQxZdhTotw90BhbCf8G4n2fqPd2ZHpxhAWlujzaxZ8rTqw1hf1ZwdbdMDc03rMHOfOuoUIcdDctqu7Befn1ZFJYUTRVEMqLhPzK3JCvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(316002)(6486002)(31696002)(66556008)(6512007)(83380400001)(86362001)(110136005)(66946007)(6666004)(8676002)(6506007)(4326008)(82960400001)(38100700002)(508600001)(26005)(31686004)(8936002)(2906002)(36756003)(186003)(2616005)(5660300002)(53546011)(16393002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmdVbU5UaWZuc0J2MTFNZG5DeGJUSXBpVFFneHBJL2ZNWGNCcWN3YVd1Y0tl?=
 =?utf-8?B?aDFpaDJzUXBJYnNhV0ZFN0hqMFV4TnhVSFNabWkyaUZ4SXFLbDM5NFArMmFP?=
 =?utf-8?B?NENEYmVDYktJNGFnempkY3dvSVJQYnZwOXpMRmRqYU5NUDNIZityVHgyUWxw?=
 =?utf-8?B?VTM2bXJSUVZQZm1QTWkyNEtuOVBHQkdpTXdnZUlVVzF6Z1lsZFl3SkpPZy91?=
 =?utf-8?B?WWFFMG4wNVVwblgrcjdVZ01welhsZjh1bW85RHdVcWxUL2oyemRBTjMrZlJK?=
 =?utf-8?B?aUhZb2cyQTdieGsvWlhJWXU4TVB2N3dJUXNhSzVQU0ZmMTJBdnJJOWozZTRJ?=
 =?utf-8?B?aW9YS1Y1cG5FNzdHeDBScG1BemdmdWlQMlQ4L01qNGl2RDVuYmFYb1N0bmti?=
 =?utf-8?B?cXVpcFJIWTVUdW1YRVc0dFJpYmRacGVGZkFSSXlPcjJUUm13ZCtERVdxVXdI?=
 =?utf-8?B?b2duQ0pWL3MxNFpCNmFlSDZYcmh0UDl3S2FNYUJxaUxoaU42TjhoUDVnZHAz?=
 =?utf-8?B?S0N6bnJFcDB1QVZtRkZUTks3TnNXblVyTkRmN1h3OEtxWjQ3TjN4c3lNS3NF?=
 =?utf-8?B?KzYwZ0NsSTN1TGtYRjdRL2szNGhlVXVuczRiL284UjNpSXRlWjEyS2NRdXQx?=
 =?utf-8?B?WW55ajlLaEU4a3ppRXVPUzlyZ0gwT2NXWlZWY3BOQWkwMTRzMEUxdzhuM245?=
 =?utf-8?B?VHB6OGZ0MHZLZENiWkZhSC80aW9YajZSenJMYytORHMvUmRlVVpiUkwzN1Vs?=
 =?utf-8?B?c1lKQllqcWh5QTVFV29NVzVERXQ3OTMrSjNuS3R4dnJzZGVLcDlHT0ptQWdv?=
 =?utf-8?B?U3dwYmdUbHJzVUxNLzYzUWU2MWNuaVd1MElaZW14WXAzTjVvVjNOZklHZzVw?=
 =?utf-8?B?QjEwVGI0NjB0ODdSdmlMWlhzSEdVek02bmVOV0xNemJ4OGFlT0VFc0pKSFJC?=
 =?utf-8?B?UnhEYTZlQ1FLdW5SVStvRnU4SkQwSEFjVzFTekJWUmdNcTFJRU5qU0s1VS9s?=
 =?utf-8?B?eDR0NkpkOGI1VzV6T1VHcGJyR3FURVpveDJEb04wcWladmpyQm1XbmJrOVAz?=
 =?utf-8?B?UEhZWFNlMzdiNHl0OE9yaDR4UXZDNFArR2dWbFZoRUtTQmxyOXh1SEFkdi81?=
 =?utf-8?B?QndFM2loOEhDYnZDNWd4MDRZVVlaOG5wdWVTN2dZYlFqejRDZ2ZIMHNlcDNi?=
 =?utf-8?B?ZEcvUEtIVW9jYU9USG8zaUtnTGZjZXY4RlNiejBOTVdEOWpBZzVNUnZMTk9m?=
 =?utf-8?B?b3RqTURETzVuckx1MndTV1UvYzVWWDlGQ0d0UDhVRUtSdktjNVMxalF3SStY?=
 =?utf-8?B?UlZZZVRWZnh5M3E2N3Z1TUV1dU9wUWJ4NldkdUwzR1JGazVweXBwTzhpZklL?=
 =?utf-8?B?WkJodGJmWkgzWkVVMVgwNVg2M1plOVZ6b1ZtcmpNUDJOOG9SS0RMWTBDZlhF?=
 =?utf-8?B?c1J3UkpUSW0zQXdJdit6U2V6SWp5SGFGZFFrZFRVRTVVc056NUVHTXBxV0w0?=
 =?utf-8?B?SERJNFl1azNLeVJZeTVYakZmVFFYRVB2V1ZxTUw5RkNCWVFZZUpGYVQ2YUd4?=
 =?utf-8?B?UGtOWTQwVVVWOUMyS3pSLzRBaUEyd2pFWUhQY25CdFlpa3M4RjRFSG90WG9T?=
 =?utf-8?B?RmZCM3FwZllOMHEzQnJWNmsveTFRaDRtbXZvNkRaTG9kMC9MU1ZHRUJ0RUlK?=
 =?utf-8?B?QmtkR290RERUSHoyZSswRkRYQnVURGplRy9MS0tFYktRNmVjT1RTTUNHTEJo?=
 =?utf-8?B?Sjk4WUZsWW1RR3JBZXBneS8zZ2dwdFJidFRLaHJXWnpLL3cwVWpQMkY5ZGxv?=
 =?utf-8?B?MHpiSXBOemExS3hnaVpEV3V0MkQwNzFyNG9Wb0F5MGdIVEpGR3V3bVBEUVNW?=
 =?utf-8?B?U3F0WlVsVTJKMUE2bE5wNExmR3YwZ1I3S3JTdkkrUmk2eEdZNTB5aUdESkN3?=
 =?utf-8?B?V3g3VjNaT09VYVNSWFdUaTlOSXlpSkNRbVQrczFEL0VTVWFFY3d1SmlTSE13?=
 =?utf-8?B?UG5DNzBLOG9yU2c2VWVSbCtQV3NTa3Q3QW1hbjBnYXJpeEVOSE11R1JNYWxo?=
 =?utf-8?B?TWYvRTlGbVhNZEVIM0oydVhUTmM0TUNqcm1hVWo2Z2JRTWkxbktTNkxUbWJk?=
 =?utf-8?B?K3pGalVra2pYbGNTdXRMVThwQ29KcENtOWNFS01FK05yaW00Y3h3MlZZUDVC?=
 =?utf-8?B?dnhRM0lZU3NPdzFKd3VuaDRjZnNiUDh3MDBrdzZPdk1RUWk2dXJ5MDkzWXRR?=
 =?utf-8?B?L05ySU4vTkluWnBlVm8wVDRua0ZOZ0lFZW03RThKL3FHakd0OGRGMDJVdFNW?=
 =?utf-8?B?aHdvcnpIaXFQaElGaThjeFFQcWszVFZGc2tzNHQwNFJmdmtHVnpqMkg0OGpQ?=
 =?utf-8?Q?tPKFzvdWSHt4w4SU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70db3a14-1545-4c13-ef46-08da3515ed50
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 19:22:32.0154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWnWjyeUd0MvseVeGAzV9nNeUia2zclol/pWu6i9JSl9lXQcOv5aRtMjKrkXun/xFgjcEjB3xI8wQsyRqtmRlgBcy4mCr17eScabbFlXH6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/12/22 22:39, Greg KH wrote:
> On Thu, May 12, 2022 at 11:55:29AM -0700, Luis Chamberlain wrote:
>> Russ has done extensive rework on the usermode helper interface for
>> the firmware loader. He's also exressed recent interest with maintenance
>> and has kindly agreed to help review generic patches for the firmware
>> loader. So add him as a new maintainer!
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>
>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 452f3662e5ac..50e89928d399 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7664,6 +7664,7 @@ F:	include/linux/arm_ffa.h
>>  
>>  FIRMWARE LOADER (request_firmware)
>>  M:	Luis Chamberlain <mcgrof@kernel.org>
>> +M:	Russ Weight <russell.h.weight@intel.com>
>>  L:	linux-kernel@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/firmware_class/
>> -- 
>> 2.35.1
>>
> For obvious reasons, I need an ack from Russ before I can take this.
>
> thanks,
>
> greg k-h

