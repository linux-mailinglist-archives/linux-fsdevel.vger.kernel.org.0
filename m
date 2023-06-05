Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628BF7220EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 10:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFEIZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 04:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFEIZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:25:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C4DAD;
        Mon,  5 Jun 2023 01:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685953535; x=1717489535;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yxuewILc8U+FnIEbSDGFKalRmMpM1qUOIgGGfStou3A=;
  b=iiYJfjk0uywUrgoL+mEasSHoE3a8R+xkHvnGMpzeeEUNjPdqBvPSAiZU
   OCC/bz1e47xp/7YiDNBfEy8A1XLbBAyW0PyiEy8oPMw3FRfZKZR1vQtsv
   MuL+FIwIkvP2QoobiuazbiI/qD4CvztDo5Mc7oF2eMnJFbweMLz90qaYD
   hwpAqGvkS+RIHm1kTfQ2fVRJOHhz0TQW25O6e+MgvKp0DqXHhyVkWxUXo
   1YXVb0U6505fK/zhyUB2/8njrNDi3eMzqV8sx5FgOY7KtD4Sm4AnL8tA3
   t2RHuWAzUM6+0LKsveyava3tOKW0yBRrF7CovfzqywpdOjJmMn0M/GrlT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="336667386"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336667386"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 01:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="708578692"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="708578692"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2023 01:25:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 01:25:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 01:25:33 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 01:25:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1mOje9qu3uLHqlPhqpkj9zJkTBPQZInqIXAr6ez1c3FsgyIgyKjnn31Y926zki0fR8yI1SGuVSPe4IWEsgLmafRiN2JVdJ4g5JxKThxZMzYSm184ARUomrjH6UUX3jo0jghkIbdKCP7sKg+6FNJfPEbJl/BSaWVeXQ1SDp0aFxdik1Mx+0103FXXTZ2Y5hq7H1ASWIGYZV8xWZ5e/ox9cFaDMAHFxm6Fvkpj5jInh79K3IjIyMm0IZY+oxQG16q6AInbDzYgu2U/hei02h/e4L6EQ0MwxSZOn/1a2UMI5W76r/yDqyfdYXt5T06EFKcck6gArKyW19gKQ408KhNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGbqZs/5klQxisM/aXpJQf87QBxEkcS7Tq/bvqAOc9Q=;
 b=PLQ8ne2DwWQ7z9TYHLDqNx2pEbgAI8/ulg2fAjhHNjW1oMiPb+aKw37N1XEKRy0pi/XippP0/xYrX3Mg/tbmQ2/ruHFL4wTPZ4SZlTK+arCsH9swA8cUqj69KTGrOBzu/phWdSSDrs8n3bNTuvfJzV59rY/EJCyeheFRWVc/5ei66Afv3FAzCLXQacw03u85LhFnV/6HwW7THMH3lgE4oQgjZzGlpyUlyvmgKq5md7eN95mxW0SELQPjAkCtAfbFw2RVRHfCVtQXI2hqjQgF013FJDaAUANUzbhyzKuVGqtToCA+KZ7VsVkkhIKwTrzXHLnOubIq3YPj3fxpEVrYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB7515.namprd11.prod.outlook.com (2603:10b6:510:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Mon, 5 Jun
 2023 08:25:30 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:25:29 +0000
Message-ID: <d47f280e-9e98-ffd2-1386-097fc8dc11b5@intel.com>
Date:   Mon, 5 Jun 2023 16:25:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v2 7/7] iomap: Copy larger chunks from userspace
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        "Christoph Hellwig" <hch@infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-8-willy@infradead.org>
 <20230604182952.GH72241@frogsfrogsfrogs>
 <ZH0MDtoTyUMQ7eok@casper.infradead.org>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZH0MDtoTyUMQ7eok@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0231.apcprd06.prod.outlook.com
 (2603:1096:4:ac::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 388b6388-8831-4b31-8271-08db659e6c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs8Ax4UmtWF+5lFeGTnViK0iKQNZ4pYe3039Zf4F0j3Qboid+F1XBCfM6nSoPE56LnsOUgRvZCxsbZFhw1obi/oZ2gHI/f9oqNB3brGpYAZlPVktmv2Awd94391gGey6nOkKc1c+RoNTHt62+AjMeF/wXqfy0V1GHcJHimW361RNxSauzJbdFP0EzIWqpEFf9pKvdBHOzNwglyvL5lGiXyUUME48ildA85/l65npoxdMHyJ7breF19r9iEepjnGrZho+ekg4OHetnSl7223abbAZN4/TU7RfnWPMf9f+bCGIzB+eA0OBuzatMUrNiEVTJgrrJNNm3ScNNubPO409NPfnEmpSdKy/atm3NgNL0lxkQOnYtrJilDZUcY+99BpqeqLoz6oSPbolH6fRQ8hSvlsgyiQ47SF+CX8Rw5ZbF1o6p96zUJkz/khJnSwZUbdWgg4QZ5yKuc0DT09Rs3/y3zR4kbdv8Q5WClqqoqx/VEFMsGlskK+dfzXJsrCwXf0Mt/Dbf6DW8AR5DyxXN9R2XUgwknQPKKhfUsh0tPnwkIzAV1AhooZgsbZajP7me2f2aC0sYacn7uG5oPsqDG0bAFOzjAnT+WXHVlcM7o5+oL6s8QHpl15WYoMzl3oZ0tlm3cR6a638U4Jm95u2bmrH9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(8936002)(8676002)(31686004)(5660300002)(54906003)(110136005)(6666004)(36756003)(2906002)(41300700001)(66899021)(66946007)(4326008)(66476007)(316002)(66556008)(478600001)(6486002)(86362001)(31696002)(82960400001)(2616005)(186003)(38100700002)(53546011)(83380400001)(26005)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STl0L0lENHdLV1YwWXB3bWltVkd3Nkx1Z25Ba0hxcXZkNDl1TjVBVG5kWWZW?=
 =?utf-8?B?bFp6Q25qUVdJVW1QVDM4ZHJnTCtjaHNqNGNCV21GM3NCM0tWcXdnYUR5bzN3?=
 =?utf-8?B?QXh1Ri9DT2ZGclRFQmk2UDdUZnpkMHZHdG9lT0VIT0pPOTVmNEJaU2N5dU45?=
 =?utf-8?B?MGQ5anVkZ2pVNnlBOUQyUkIvc0RTQ2l6bHFMblVwSWRFaEkzQmRpVUo3Zmls?=
 =?utf-8?B?bzhnT0NqSGxEMXVKMXp1L0ZpbXNrNW5lMkNNODJ3LzVSSVVVcEpMMWlBdGp3?=
 =?utf-8?B?Rk83aHRWclpCamJ3UFpCQ09PcWtaaWVlMU1iMDlMUUd5UkRBZG5xZmtsVGky?=
 =?utf-8?B?WENVMzIvblB6R0t1SEtUNGc2eEtRUTZOOVphdjd3R2QwcmZuSmQrZjQ3aisr?=
 =?utf-8?B?TnMyZ0cvdkp4MUMvMFF5Yk04eWRMWHMxNk10cnhMRk1mM1hXOG9aQmFLNmlz?=
 =?utf-8?B?bTFPVzVVM0h2Y1pSTWxUczA3NFVlc0JaWkdmQ2tWRkFSSnZEQzdRZGtUczcw?=
 =?utf-8?B?eHg0bXhJTWR1T1JydkNobDlYdEJoMWdUSWpOZkZEV28vRVViS3FmVWFUUCt6?=
 =?utf-8?B?eTFORWIyNWs0d3NHaHN6ZVFOcllzc0U1NS90YXNWR0toZW4wbTVrMEdqUnA4?=
 =?utf-8?B?Q3NRR1J1K0Evby9mWVJDQ1Y0MkprV3B4YU1TYUdHeGRyamdtZ3NtWDJjclhI?=
 =?utf-8?B?L0w5ZkVSV0dSVWRsK0ZSR2xJeGlmZURLUnlSdGJwekFUd1V3aXJhcGxxZWkx?=
 =?utf-8?B?aTlveEdwaGpOaGEyZE9xcEJOM1ljZEFDRlhvRit1UVJRYlk4YkJJUW5ZQ1do?=
 =?utf-8?B?Z3R2WXBBRnoreC9DS0g0Q1dnRmdtUWhid2VVQlh5eUpoUWxvelRNZTRZSEdN?=
 =?utf-8?B?U2VvQ3M3MUlra2srWXJEbHJJeStLSnJtcXYwKytrTlg2WUhrL2lFc1M3RnpX?=
 =?utf-8?B?N3RZRnh0QktOcUhwMEFRYTluTU11VWhaeUd4NXBxVm16NHl1c3h3THlyYXVj?=
 =?utf-8?B?UFJPbUxCU3EzUExFS0ZPNWRtSzNEdnNsZ2VFdGRRa3Z3dVo0eXJCaXRZOVAy?=
 =?utf-8?B?L2JxMmxHakVmbkFBSGhXTThxRG42OFRoVjdvb09FOUgxLzE0NnI3S2JZWnRz?=
 =?utf-8?B?UWJsSndOU0d0NFBjeHBBNUJKMlRXblowVzFRem9FMGxCTkVqSUZBTWt1NUhH?=
 =?utf-8?B?VGlJZGw2VGsvdGZJTCtWTDFtY1RLdm1odWJuKy9nbk5ERCtZYmhXUlVMNlAr?=
 =?utf-8?B?M0xKTE85c3lmOS96dlhzVnZSaFVEWTVnS3lKL0pCR0tqZTZ0N1VzUzdOcEhX?=
 =?utf-8?B?ZXFhU0Z0WWZLRnBRZFBxTG1tY1REYnJjS1Y3Nlk5WVhKUm5tQ3N1VEpMRWI3?=
 =?utf-8?B?SWVxN3kxYzIzV3lmT3pTbmF0SUtoZmx6UWRjV3h0RDIvNEFHOFRWamdMZ010?=
 =?utf-8?B?TE45UXN4SlB4cmhSQ1lDS090YjA1R0NBNG9RVlVLVU0zQXo4c2o4Yk1yREh1?=
 =?utf-8?B?Y0pWSmFPWkJEOHlxZEpKTTdySk5sUG5OcXE2akhJRXFXR251TFN0Q24waHRi?=
 =?utf-8?B?QWMwdjQ1bWVJYS9WWjE0VHByL3ZSdCtFc3Y2M2RkQW1vZndjSlIzbnpyMGpG?=
 =?utf-8?B?d2h6UFZRMmkrbWZiMk5xUGNrVjdJSU5HRlpaUzlCcHU3L1RQUktJL01xdzZL?=
 =?utf-8?B?aXF4TFZYR3liSlQxV0U0bUxuQnllakZtdzRxWlphN1VBM1g1WnhUL1J2SlVF?=
 =?utf-8?B?TFA0VWR6dlVOYmU3c2M2YXI4V0ZKeGl2LzdWVzIyNnFKWVh5Y3QyanlXbG9t?=
 =?utf-8?B?czRyempMdE5EdVlwWi8ySmNkd205WmVtMGppUWVtcnJpUytiOTY2SURma2Vw?=
 =?utf-8?B?LzE4QldiWDRmWXlNbm1JWVNjdTZNOCsyK2VGbE9wYjhTR0hBNC9HaWNSSDFj?=
 =?utf-8?B?bW4vaHlnKzd4aytCU0wvVVRZYXo1eXlhOWM4WSt4cmUrMldLTE5vVTgrTUpL?=
 =?utf-8?B?Nk9yMi9JM0RjNkZQd045WlQxTDQ0U0cydVVqV1pnbldkNmdGSGhLK1FGb2t3?=
 =?utf-8?B?a0xCQ0tWNXVSZ2xXeTZqbG1TS0dkVTIzR0VYZVJTWGdMTEErRFVrOXpOb2Ew?=
 =?utf-8?Q?IRqC2qlOsaBDVnCmv1QwrX+JA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 388b6388-8831-4b31-8271-08db659e6c03
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 08:25:29.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8gQ/KckVQQ/WIu7ZAP+JfQyTdGvKVMF+GryyzNCwN0O/aZWxjkt7LjwPe+gwWTgUTbkLXVMAhpRlx4t6wgWug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7515
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



On 6/5/2023 6:11 AM, Matthew Wilcox wrote:
> On Sun, Jun 04, 2023 at 11:29:52AM -0700, Darrick J. Wong wrote:
>> On Fri, Jun 02, 2023 at 11:24:44PM +0100, Matthew Wilcox (Oracle) wrote:
>>> -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
>>> +		copied = copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
>>
>> I think I've gotten lost in the weeds.  Does copy_page_from_iter_atomic
>> actually know how to deal with a multipage folio?  AFAICT it takes a
>> page, kmaps it, and copies @bytes starting at @offset in the page.  If
>> a caller feeds it a multipage folio, does that all work correctly?  Or
>> will the pagecache split multipage folios as needed to make it work
>> right?
> 
> It's a smidgen inefficient, but it does work.  First, it calls
> page_copy_sane() to check that offset & n fit within the compound page
> (ie this all predates folios).
> 
> ... Oh.  copy_page_from_iter() handles this correctly.
> copy_page_from_iter_atomic() doesn't.  I'll have to fix this
> first.  Looks like Al fixed copy_page_from_iter() in c03f05f183cd
> and didn't fix copy_page_from_iter_atomic().
> 
>> If we create a 64k folio at pos 0 and then want to write a byte at pos
>> 40k, does __filemap_get_folio break up the 64k folio so that the folio
>> returned by iomap_get_folio starts at 40k?  Or can the iter code handle
>> jumping ten pages into a 16-page folio and I just can't see it?
> 
> Well ... it handles it fine unless it's highmem.  p is kaddr + offset,
> so if offset is 40k, it works correctly on !highmem.
So is it better to have implementations for !highmem and highmem? And for
!highmem, we don't need the kmap_local_page()/kunmap_local() and chunk
size per copy is not limited to PAGE_SIZE. Thanks.


Regards
Yin, Fengwei
