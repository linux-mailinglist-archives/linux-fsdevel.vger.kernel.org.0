Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E9F5A82D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 18:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiHaQPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 12:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiHaQPu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:15:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707D615FC5;
        Wed, 31 Aug 2022 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661962548; x=1693498548;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b7bRtx6F0QxdMu90jgujj/+yWCmS2yF3F+bdYeKTpfA=;
  b=ASE3X1TYC9uNUZSwdgExE4juO40GuBc34xzx1aTxbMBPVEPI+FOHPVOH
   cJxjy0QU7gMe2P4CqyowDs1Vlv+1LXdvCHCG8je1DcB0YUeFqU5S2RAhf
   OSooGnZSxKRQPqa0ypv9q9VAerEsfy7oaask+Jiv8zy16SwJaNDTE++2j
   e5Vog+0anAG1cpt4xYz/wKHjC2DdmVrnc7UNzYdEOGSpUdifASiVSB3Wj
   sS6vuXGS0mYW+9IvxmmIJes4ECATS14Ct8ArLavcgD5WjYgoYignR7nfo
   arULV0CFa0qKQzdg25+XY0LjXbUGCY1yNSSlGjZDA7HOFl3mRuRK24JoO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="278501685"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="278501685"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 09:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="563086407"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 31 Aug 2022 09:15:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 09:15:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 09:15:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 09:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S88QHf+BSBVYNgPF6XRLsyhe+0eBZ+Jng4s9k2GN5B01MHQ0SV2MnluCreS21/70B/K5i43EM6JBeuVi3vnLy9GSnSDltAOLaJgrNH9UwtobREGMOkmljTcRGxMVWgxG+I2rhTkHDs8PZdgAz57afxG5HbrgYwfUv4Tpus5yymBZKHjwzLuAe/MjGf8xyON/k7wNnfqIuB+3MhLTO7QNmqclDbgSbT2oN2xoGfa00/gAW4lyxcC8jhc2bqN8sWYF1FlT+4E8zjwP8TrCT4Ns9EZ9Fszd7gz9EvOmQQe0EF+ix5cHVQtsRNHHptO/dCY9S3QZpmvhIApXs6UkEqof3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hlm3NfsselygIDH61CgZ7paTJbTk0XMaYxvb74HfCb8=;
 b=J8sJImbv0JkPdiynThAOgGtibpLRZvJpSwDQbMHMMvPT5fBgf2IRW+fHf8NIypYbiv8nJT4SuGUtqloqfF8IBy89T5aLEzpHC7mFLvQ0Bzq9gvLgSxsleYFuav03d0doxFWuJSrl9Cke+T8+qMW0fwwHi88Fy/jf4rma/Dg/QTvStIIFUoB7ae7MvmTphYM2pdUnylJ1EAD0+E1KbGD3MBOc2ck9Bp1F94DSDQ42mVV33R8xw77o2Z0m6V9YmaTuKHJlp19rr/EPNBc+RMeEfTujKj/dMff9LgvqGTBErkNnVmFYDv61m0rnLISd79iagaDoMQmDeqpgrcuWjM5mOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DM6PR11MB3212.namprd11.prod.outlook.com (2603:10b6:5:5b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Wed, 31 Aug 2022 16:15:43 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::f9e1:f470:f60f:fb02]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::f9e1:f470:f60f:fb02%7]) with mapi id 15.20.5566.015; Wed, 31 Aug 2022
 16:15:43 +0000
Message-ID: <1c27b6b3-2d3c-d750-58ad-bd35ede421f6@intel.com>
Date:   Wed, 31 Aug 2022 18:15:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/2] libfs: Introduce tokenize_user_input()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <alsa-devel@alsa-project.org>, <broonie@kernel.org>,
        <tiwai@suse.com>, <perex@perex.cz>,
        <amadeuszx.slawinski@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <hdegoede@redhat.com>,
        <lgirdwood@gmail.com>, <kai.vehmanen@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andy.shevchenko@gmail.com>
References: <20220825164833.3923454-1-cezary.rojewski@intel.com>
 <20220825164833.3923454-2-cezary.rojewski@intel.com>
 <Yw5X379ct1PK6wZO@casper.infradead.org>
Content-Language: en-US
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <Yw5X379ct1PK6wZO@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::19) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd0e44cf-7908-444f-c5aa-08da8b6c0dff
X-MS-TrafficTypeDiagnostic: DM6PR11MB3212:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akeU28dUeOcUCNDqhTjRRdo/Y4XGkJ5o2FzxV4WXg5araIzbgw5jykSvG58nyXtH5aV5y3oYkcRH6OokuiP2SoJXrqj0wxAAGfF0zW5emFUKo6kZ/QlWklhrxxc0gQ6eddgsTybC++bg5HYCVZhux3EumfT2gk3bC6QROpAP70pwPc7rnziATwpP/eK2Xnuz246RxjiiLlFNIJd9P53qsewFqvEkIaNurJrIauK12ewzpUeeI+Y9cKttSbj6KTnjBKRsgyd0C0w0zjCfiV/xsmk5pNtq/IFSMS0BgZgTLIMQxf0dRV87M8zwXeK5SS1Ud5QwN+mkMpe8aXDLsT9bP9YGHH4XVEMBruLhzKdM8Q2mGBWseLYAf6RtZPO48nQsLqW5YH6+LX5zHtvB6DHTl+zfDdRpUy7lb8X2O+vxYIa2nyTM2QbL6jmjhHRYycwOQ4Ct/o/qwVB5Eb/5dyNRogVX7RPmJQTvPSxkU1UR5BL9X9SyJLjtVPh3AoqOBLRPM89G75rRr9xqtBxZdeAfqntBlNcm5TXGX+zZc22gmAEMoypmK2AuEtPiTGfdtHP9WcgudBJFvwqmj9A2t2IZNhXnTtQBrxe3ne0zqlo0ShTQQiSlzJ+lN2259onYglKOnOAp5JELsSAi5Em0r3kFJzDvyfx40HH0cHHZqw8+BAllmZVq+YxiypgocLzZoc9F3ZWMDFb4Z8H6wKlslNUUUeDcysosQWO/Wp79lmhIMpEYGZENfT+kT5VJUQEPXK5CQBGs33qDUBo62XBY4bbxQU1blFR4PpWvjSpGzjC1pGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(39860400002)(376002)(136003)(6506007)(31696002)(86362001)(53546011)(6666004)(82960400001)(36756003)(186003)(26005)(31686004)(2616005)(478600001)(41300700001)(6512007)(6486002)(44832011)(316002)(66476007)(6916009)(66946007)(4326008)(7416002)(8676002)(8936002)(5660300002)(66556008)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU9IeEhqT2hNTGdtOVVBOW44SDhBR1FmRlFoUXltQWpOdVBrV1EzTG45NWxy?=
 =?utf-8?B?NUNGTzF0NktETmluZEErcytBZUREeVFRODVWMFRTNEVxMHExN0k1MFdjRy9I?=
 =?utf-8?B?Z0hFNWc2NmZ3NWs3QWJ6YVp3V1ozN3ZZQk93N2pwNDJWSXFESkFpUEN2OEgx?=
 =?utf-8?B?ODkydlc0b21UcE9yZWczaCtiMU5hdS9IZVBmbXhUYVVueVl4aFhITFEwcmRF?=
 =?utf-8?B?Z3VWSmVOYStNUWNLMmZWS3EvUjdMMDB3UmloY0orVkloS3Vkc2hOdlFkWVkr?=
 =?utf-8?B?SzQ3ZmlGOWJsejRITFB6K2MvbDI1TzdwTUhUU1Q5MHFFWmE5YjlITVczLy9W?=
 =?utf-8?B?MWc0SHpWSmN4RDJVSnUzekRlcFVTazZxR21jTnErelFSdWsyMXFlUWh6N1Jm?=
 =?utf-8?B?R1A1Y3VFeDdoQktISHVyK1hJRWd5WTJ4MmVMdE9rZVJiT1VnQVhRVVFabnBU?=
 =?utf-8?B?WmRsRjB2RllrMGtOUnlzZEVUTll2V3N4YzMxS054UDZ4TTJkT0RuSyt4eGJV?=
 =?utf-8?B?bUpUR2FvTWxuWS80dEMremM4VGdiWG04blJ4eUw5SFRIUi9BcGJDSTlIbW1z?=
 =?utf-8?B?dHJvcy9abkZvUFd1eFRUYkpUVndjaUo4WFVmWHFtSXlGSkkxYjYzNVhLbTZ6?=
 =?utf-8?B?ZWJUUUk0Y045bkFIZEh5QzlFTFU0Vi9Zakp3LzFhLzhjekVyaUx5ZGU4UDN6?=
 =?utf-8?B?ZTh5cytuWXo5UWY2QVhwWHBXUTJrRWgvWmtCMHpLQmt2VGFIMGpOaW53eVpR?=
 =?utf-8?B?R1IyU3JPRFV3VFVVYXdRVHBaZ3REM2hydGoyYmlZMTQvOGJ3amtIWlA5c2Fr?=
 =?utf-8?B?dFFUTjJXWGNCMmxWcFowYVFKWFJBakFpRVlpTnFiekptbEN2eUZOT0NpMHdV?=
 =?utf-8?B?MU9GdlUrZU1WU1VjVTZ0M041dTE2Y0pBdnZMU25JSnk4bUJnN3Njck9WTm00?=
 =?utf-8?B?SUQ5d3p5MlJ6YzVqaHhRQkd3WThpOHUwMjdicG5Va0QzM2E1cm0zNitveXJu?=
 =?utf-8?B?R3dkMjlmY3ZaK0p4VTdTQlhvSW1uRGd6K0FnUGhza3Q2Nk54cWZXSll6RGxT?=
 =?utf-8?B?Smd2M3NWcUF4KzlFdlYvTEZ1bXUvU2RaZ0hqOENKZ1k3cW9JWU40aXVXS3I5?=
 =?utf-8?B?VHc4RkJoY2xobFFyZXRDT2ZpZXZERTZvaERwTDVuVmUvQjJiV2FhUjM5SUVF?=
 =?utf-8?B?VjBRODJGcStMOU1qS1QwVDd4R21KWXhaZWhON2loSnFzQ3BQYVlIS1Bsd0h0?=
 =?utf-8?B?Z2dNY0g5TEZQNWREVmlxYlJrNFU1NmczbmdERk9jTzVvVEZYTjVkNGpHR05V?=
 =?utf-8?B?eStwb2hFdUpxODVOM0E4U1dweFpZNnhUTGNvenF3Vi9FS0IwOC80YjhUYUV4?=
 =?utf-8?B?cW5wZFBndEFzbWQyRHJEUHhwR2hiZEgrMDVXcDRpR3B4c2syckNMVnNtc3lW?=
 =?utf-8?B?RlBiYTBqWHZvb0d0dVV5RnNYbXU3NGsrRDBtVlBScnZpc0pTODRPT29YcFlP?=
 =?utf-8?B?V3BkbjRoQVgwSzhsREtHWUFoclpjZDk5N3c5M1czbkdnMHlwbldEYXJhT1Zw?=
 =?utf-8?B?dHhLWEk4ZVNKcjdmenVsd2pja1VlamZzaUFVTkJkY0pwc0s3RElEa3d6Wmd2?=
 =?utf-8?B?UXk1bUxqODY4aDVYMFBXS1l4aUpHeHFCRmtiZmIvMFo2YldEUWxkU1RVaTcx?=
 =?utf-8?B?eXVzUmJ3ZDVQcWhNL0xsQWdoU0ZweHVhNGlGQ0g4bTNmVDV1UVBSc0hZbmoy?=
 =?utf-8?B?cjNRZnBhWEZXSEw2WTRFT3lLbG9JeURLYmtLT2dNbkxqOEN5YUhsbnlXTzhq?=
 =?utf-8?B?NUQ4RXVieGd2NXlaRVJJalpjR2FDUkZkT01MMmR6MlNKVlFma2hESHdHSXFH?=
 =?utf-8?B?UThBWXR3N0NFU1RUSWNpS21oTDU2M3hGVnhGRWhmOHg3Q1dBenQzM0JkUTZw?=
 =?utf-8?B?MUhLSUxKbzh4MTk2VGRjVTlzeXAxREpMVGh6OHRJcXZSTEhkN2JsbWgzcjgv?=
 =?utf-8?B?dFd3Vnk4ajhnSkJmbHF1bnJqcHdQN284M1pJUWladDBRQnhHZjQ2dFNJUk5j?=
 =?utf-8?B?b1NUUjJYbVN0TGEzc2Y0MXlIRVJxSkRaV3N4UHYrK1B4VTZielg5Y2FHb09r?=
 =?utf-8?B?SEZacUkvcFRva0RPZmNlVHFZVlFwVHlhajlDY1VKQmNFYnhicGpKY3A1dE9y?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0e44cf-7908-444f-c5aa-08da8b6c0dff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 16:15:43.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNTJekdiYWyGgdGV+sfELV5LbWszbMt/yszTORW8qLJdCwbDnIS4EDU41Z6Vh0mwuJxful4mC9HljtJ8MfBK/XLvL3vRCWNE4Anf17KJ1Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3212
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-08-30 8:33 PM, Matthew Wilcox wrote:
> On Thu, Aug 25, 2022 at 06:48:32PM +0200, Cezary Rojewski wrote:
>> Add new helper function to allow for splitting specified user string
>> into a sequence of integers. Internally it makes use of get_options() so
>> the returned sequence contains the integers extracted plus an additional
>> element that begins the sequence and specifies the integers count.
>>
>> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
>> ---
>>   fs/libfs.c         | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/fs.h |  1 +
> 
> This really has nothing to do with filesystems.  Surely
> string_helpers.[ch] is the appropriate place for this code?
> Also get_options() should probably move its prototype from kernel.h to
> string_helpers.h.


Hello Matthew,

Thanks for your input. The initial version of the change was located in 
the string_helpers.[ch] just like you propose and I have no problem 
moving it back again. string_helpers are devoid of __user content though 
and that's why in v2 it's part of libfs instead.

I'll give a day or two to see if there are other suggestions and then 
send v3 relocating the implementation.


Regards,
Czarek
