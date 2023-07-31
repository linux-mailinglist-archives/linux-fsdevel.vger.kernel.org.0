Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D0276A062
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 20:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGaS1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjGaS1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:27:34 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961B199C;
        Mon, 31 Jul 2023 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690828048; x=1722364048;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RUmishTtUTS0eW3pV1ygdWg8hNKmLAcPxF4S6hXx+gw=;
  b=kzwXM690BX9pLB5d52an3tQCHomMmIsSzIfdA48ZlCr1bSQExZ+CD5J4
   T4HP9DYldrWocZte6GgKY/GJZWG9+AINoe6bCX9J/E/6Dm+UVzQ4lPCbF
   ocZEA4mmgd0yEczatlS+fCtd1rp0JcCHPgaL7H3kxJscs4uDvX038Q7qS
   q00S8XZb/gQLxTPLDpl4WKyLEfLy1R5yLT4POu3y8k2qGidSypMV8P05L
   89cxcIpoHL46tVBx5oSsCvZ2izN5FSdWFlCmjHtby4rwsIsUY5jzkeB+R
   HbHTXasIRK16701I9lbvCv4PtHpWMEBe/On5JGBTGxxpH7jPP6QdbJEkH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="455472517"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="455472517"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 11:27:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="758008658"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="758008658"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 11:27:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 11:27:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 11:27:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 11:27:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdxlfxnSb0DCwYRFzTyh29Xu64k0LZchbRhaN1mrUJOOjLJfUizz1h687xQN7qqWPTqxd3tj4eFxg3o1Jd+ibJZvfy7RRysNS1i7kPtCQ5YkeOGdQhtIwuQyTgawbTrMM0b4J/6dkVuR+ifdhEokPgUpT6dSs1eMc6tyRvREzPFQPp2ZIDkp43sIAlmmFl6D+TzMSAGw34y5pf8W32GTjaPGT6w8wXRGSSbiaVUQyAlclPBEpR09Z3/qSuRyD3xdYLfifIHhpk5XRGpEb5WWMg554pIRQJq9jvztuunnxhB3wuI5OopYFOWp7cXEz3pptawyESrYiPL3G4Yu1jyjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcmVbAhro6pOSqQ/Tfjdltg0p1SI/nssr627R1s37GU=;
 b=kVdtVNx1JhNRJHzbL/g8XdzcZYUvBOMQ5Cy6fSvueT71GizTREyrCVQ590uFuhxy0rFfwxIyIo3SIsEw3InjPz3/8Hq16mtU5glkMWwlqL3b3SKfNTI08kJ5GAc6R2mmU8JWvYncOWzTQTe+C22vvoVHZLusDPlBES9gExpbFQuHDe55oWngRGM6ofHPqIaV5emg6xAj6dgxJI97toYCmsofoCmLaNgYg4TQIcCeyqHQyoRx3OAWfSC38XQvjow+g3nTOL8+OgLONs00QgzyW7w3QEGuHBq2RvGHHv1Zx8MODo5gopUQZ6PLbdPGsJeUzCHuSafg5Ph9NVSdeeC0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 18:27:24 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3bb3:50af:f225:8be0]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3bb3:50af:f225:8be0%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:27:24 +0000
Message-ID: <e1aef4d4-b6fb-46ca-f11b-08b3e5eea27d@intel.com>
Date:   Mon, 31 Jul 2023 20:27:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: ksys_sync_helper
To:     Christoph Hellwig <hch@infradead.org>
CC:     Christian Brauner <christian@brauner.io>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Harry Pan <harry.pan@intel.com>, <linux-pm@vger.kernel.org>
References: <ZMdgxYPPRYFipu1e@infradead.org>
Content-Language: en-US
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <ZMdgxYPPRYFipu1e@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0353.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::13) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|MN6PR11MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ca3025-45ad-447d-acf8-08db91f3c955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9KvgcdsSDK4Pe8UFik6JUb40AYYIf1e57iuklJu8zr9kkldvan+HqnTHcVtUf/XgiIGPCB5017QV8pv5CqEyEuiPs3eW+087FyV9tfbRC/6HdjIzrgTWFcBZScgl1Wh5Hf8DvWs57QHUH4/omKCIsjXbWEQEgv65hkdFazrQGblQaAUI0QDWUfZwlRjXAsNShthgxkK24aNv3qcUQH5ed0X+NP1AJETTjYaVn83xgcprsGIM12/cv89xbfq/c6SEW6PqZ/y28nptQOhEvKVLrszosxT+SxgthoTDUx4yJdYHxwAk6YG40XZDfXRWqnzfQ/7TKBMwxiorxhaDogwDE6IioShVC94P9h5i1fpd0MDiXajSSVYb6teN5E806ehBzjfepeBezNap6PCnlHTjcyrxPmVSK0R5JQ//cPIHAgfZrADLETuLe11bxZ7GVh02mvTNhrPQ5/gZhMAG1x6Fz/pNwh5yMDbUPBSC9JraodQ3Qvx991iHy/SsvSEBMsoiDdtj1xh4Lm21CbAGHyKdFEQZ+ZN+ziNROs7wEQsGdzxWe1PHVFjlGTFwe3I1vZJFTwRAMsNl2+TX1c580kIqtCI03i1YQvUPlKPS4kmcWzOaDtt2Ew5O5Jd4kxW3HoOPsPci4hwSJJGCylOTtrF8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(38100700002)(82960400001)(31696002)(86362001)(36756003)(6512007)(6666004)(478600001)(6486002)(2616005)(53546011)(26005)(186003)(8676002)(8936002)(6506007)(7116003)(5660300002)(66556008)(66476007)(66946007)(54906003)(6916009)(31686004)(2906002)(4326008)(4744005)(41300700001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVQQW1waTE5OFNOVlpHMldhTEh1dk01SndOVlY3R2Mva3RPZXpTVW9GcXM4?=
 =?utf-8?B?NzJCc0I1RHk0ZXlhT0ZKMVhSSGplQjdxeXVyQVducXhRK0pJeDEyT0o1a1RR?=
 =?utf-8?B?amU3blBrdkVKd2tkdkxTblhYRFhpa2tIeGI0YXVoTXBERmF1NXZtLzUwV29C?=
 =?utf-8?B?ZW9BVDFzRHBsaXJ5alRKbmk0ZTVRZXFRQU5naEZJUnVhMFZCNW1DSnJRWGRK?=
 =?utf-8?B?dTlJK3JYZWkvdDg3Ui91bDA4YUdXU1dkRFBwRUViNDJPSnlpK1k2NTdBd3BO?=
 =?utf-8?B?NUxRc09mMHJPZTYyZDB3QWNlMDNqelBlVDBBdEpoUC9nWDlsNUF2QzFKZEMw?=
 =?utf-8?B?eEJ5SHhmdm8vaGcwRmdiVWVLVXRSZ3lmZ0t4ZmM1M1ZRaktISmpoVm9pL2Yv?=
 =?utf-8?B?dHJJb1Y2eDBXb2FXdGNoNXJKaUVkbThiQ3dEZDNSU0ZGUGVVSXo1MzhTU1Mz?=
 =?utf-8?B?SlI4eENsU0Y0ZVlGU2wzeUZhZk5sQmNGdmhIdnVJSDFEbm5JcFdRbjVpWlc0?=
 =?utf-8?B?cTkvcWFqZ1VvL2NmS2lZQmh6SUZlWFFrdUpIeFhGaVBqTC9GemFacHhleHZp?=
 =?utf-8?B?R0ViNkROQ2RtcU9GTy8xeFBNRy9XSjQ3ZXlLVUtQdVB2ZDZMYXBtcnFvT3No?=
 =?utf-8?B?ejlxVVA1UFlTQmRCcjYreVZqNEdhdDJFTlRSdkZYZlhzVXd4dURVY3YwM0c1?=
 =?utf-8?B?Q3hhNW1KcUswUnpzVGNsb1RRZUlrUURnVmxtaUE4cTBOUStWNlcrbVI0b0hH?=
 =?utf-8?B?M2ZnODJtL05paDR2NFp4TE5rbHJURzEvVFZBaVI1cnlMakFwemNjdzZpUzNN?=
 =?utf-8?B?b0lFQlJhT3VxbHg3aUFSNjcvMUlNNXB5ZkxiOXlaYk5rOWs4Mkp4eXdENXFz?=
 =?utf-8?B?aUhQRm1TSlhRekpWdXRHWHJuejRPUkhsc1d4UFFzVDM5UnZuTUJKdFAxdVcz?=
 =?utf-8?B?VkZ4M0FXTWxSWHJaVGFGaCt1UUF1M0RvMjdZck5BRTVoSDQxbkdpMWwrWURl?=
 =?utf-8?B?ek1RVzUyOHlvb2cyYVNMN0VIcVo0Q0VEYkhKN0lObGVpL1dIMk1TWW1ySGcz?=
 =?utf-8?B?RGpJSFpTZm9EaU1pS1NlMUthQUUveXBoM2NaZml5eG90SjdLNndua0xhMlI5?=
 =?utf-8?B?UThqYWoyaFFsclFJVGNoL3JSdUt2dHNPd2RpVTlLTjFCTDJrL0dIbzIxQWhI?=
 =?utf-8?B?VUNkdWN0elAyeFBNWldIK1lqVkN4U01CMGREV2drRDdOTlhNdmhSTWM3ZmQy?=
 =?utf-8?B?T1pqNHo4OEt5ZEs0TWYxQkQ0bk5ybkl3K0dNMzBRWms1cmloajA4WHBJQW0r?=
 =?utf-8?B?NWZudVhscnUyMkdiR1RnQW9FUGpTR2lJcDR3TW5yU21uRnJUNytsODduOW1u?=
 =?utf-8?B?YUtTTkJseE9uYmlQdkJpbGpoWkVxQkxPWFVYaEt1L0crd2Fld0l5dzhPeHVu?=
 =?utf-8?B?eDZMSTArekxLVEt2WklORi9SNUwybEM5aWswY0VDN1lQWW1GVWxlNXlqbDNX?=
 =?utf-8?B?SVNtZytQWW1jRkk5UklYbzF2THBTZkpEVnFRVFRlVHhQUmxmRjlmdnluUHRx?=
 =?utf-8?B?WStVN1dXRmJyU2RFa0E5TXJIdEhBNGdiUGJKbXpSWno4V2xjblU1MFd4em4x?=
 =?utf-8?B?WWNhQko5TGZGS0RkMDU5UXh2NmJMYnNsdXcwVlNFYjR4RFZneDlheVNQTVZJ?=
 =?utf-8?B?UUlCaloyMW9vT2s5M00vK09UWGZ5Ym5PeGlWTVhzVGRjZXlsZUlLOVRHdWhD?=
 =?utf-8?B?cHBJWGs5aDFEOEtVLy9wS1RmMEZxeEhkdTEyMUdJZkNBbjcveE51OVNNWWFR?=
 =?utf-8?B?azJVd0RVS1VCdnZyeGp0NFd2aVZ4QVRFN2VkTnZQV1lwU2Y3ZVJ1aStvRjNz?=
 =?utf-8?B?aXJYemplT2hmMjBQL2FJMEpjaUoyWWFZZUJLWC9MN3UrOUxWWEZUT3p6YTlW?=
 =?utf-8?B?UTVPYVNQM1FZcm9mbUZ6NzFvTVliM2RsMkxvWTBOTWs4RWZjblZyZmRUMnY2?=
 =?utf-8?B?MGRxTk5ZL1BlMmpSaDZEWmJDREpsWGttY0ZnT3NhZHZuTW9iZmJkRlFqNE5V?=
 =?utf-8?B?NzhkY2t4cEZzK2NFMTJrcEc5M2J2d3E5OEw1SFdJSHVUQTVwR0VuRmFXTS9N?=
 =?utf-8?B?VkdBL0Q1dmNCZVJqdDhIWTBWVmMxeWl2ODJPYU9MazlsMTdxdkNYRjZ0bXp3?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ca3025-45ad-447d-acf8-08db91f3c955
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:27:24.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TouV7YYJ+L6Tvb5pTrKOaKz5m9slp7m0ZSkukQYPQht0QqUUWCN1gspQQ2OtQuePijxqjdTtHsfmqL+wxeiiDQw6zEVS2V/JlypU/9GU3Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/31/2023 9:20 AM, Christoph Hellwig wrote:
> Guys,
>
> why did b5dee3130bb4014 add a magic export for sync functionality
> that wrapps VFS code in a weird way, and then exports it (without
> even adding a user in that commit)?   This kind of functionality
> needs to be exported from the VFS, and only with ACKs?

OK, I'll remember about this.


> With this
> and commit d5ea093eebf022e now we end up with a random driver (amdgpu)
> syncing all file systems for absolutely no good reason.

Sorry about that.

The problematic commit should still revert more or less cleanly, so 
please do that if that's what you need.


