Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A32C5F7011
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 23:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiJFVQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 17:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiJFVQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:16:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2113.outbound.protection.outlook.com [40.107.93.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B913D00;
        Thu,  6 Oct 2022 14:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Whl6X34tFhydxn6h0QUTUG2Rf7tOj89a5EkaRcxu2K+mm+51lJnojDS8/bv2poh4S/Phk16XsOO6QryG4Ng7sH19ER/9PAdKn0tLEt1DjtoMUP2pJyI4PuS3Ft5VeUPgeuNigCM5fQpYw8VsnXtHlDKLewk7Q2Iq5wh6kFE0VgzBumQ9czjMhg7B0VqGAtWCmhFkkgIlLg1U8tJz0CtVOi9YzCCTIFviklquFHWOxhNMzGZTXLCVQpPZzmxPDdvfDZP0Jfa8RO2JvLFU9aCSLHivD/6jWHYu6HIF1vc9ccUoWu/Z/0070S1A9MRpWOl5n/04692Hasa6heCwinV3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwxyLIynVnfnJ5qj7Jgy/nAW2F4A9Pqa+q6L3AOBiTc=;
 b=QPknt4BLoTxaSsZqrO1QWQjx2iE5ssZkFJd3WFdVoTnVVdEt9Yi6SeycNGaWH1TC8w7K0D/H/xBQOWTu9cE7sUbL3+G3XVG5jdjhrJldCeqTwdC5ZipWW7WHqJlGb1W9REQzwIOSqOYLbOTJA8B3Tirq6ltCZkv/4IZbuJN1nfAo2udeadL37KEXwFLDWUrMKIdiQLhoJMfos18rvo11+EEC66+SYXHKfmfjDxL1XLckr3PiP6xnXMhO6Fwr9jhvcuQHICSdJDzqlOtg1gLcJyP0Whv6mhtwqnTCKH4I2aGozPk+OOP95/ZkeZvx6QZzoW71317l5Gx5JOS9CxTCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwxyLIynVnfnJ5qj7Jgy/nAW2F4A9Pqa+q6L3AOBiTc=;
 b=sW8/hxm2b9Q4kEETyNec3hBbHy8/+YkEOn6kD7GO7S88mwRh5TlkTzJR5C/c5LfmGD9X+E6CfRn4sTEnTryF4IaAVacK5undH22ZOYBlxzs1MfM8pMcCrqz8LK//gfHPrfCGBqVht4R8q2clkF+Hb9EOZPL3jyrdD5fucXpjDyCPSfAP9pZyBwaizDKDn7wlVZ3he5HOUYnNESbUa4vBZpnFlCtEfh9Qn82K9jv+ozjEH3O/Sv6bNI3jolWfXfKSEgfJwXrQH2pKwDKWiIAa74HiZPNJE5VS5RflQFJMubCy1W5Yrht+Lvke0FT7ASYK5R533EviEg+DkY+qptcCYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by BN9PR03MB6202.namprd03.prod.outlook.com (2603:10b6:408:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 21:16:45 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 21:16:45 +0000
Message-ID: <0a7fdb8b-9b7c-86bd-b409-736b664b19a7@bu.edu>
Date:   Thu, 6 Oct 2022 17:16:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC UKL 05/10] x86/uaccess: Make access_ok UKL aware
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, masahiroy@kernel.org,
        michal.lkml@markovi.net,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>, rjones@redhat.com,
        munsoner@bu.edu, tommyu@bu.edu, drepper@redhat.com,
        lwoodman@redhat.com, mboydmcse@gmail.com, okrieg@bu.edu,
        rmancuso@bu.edu
References: <20221003222133.20948-1-aliraza@bu.edu>
 <20221003222133.20948-6-aliraza@bu.edu>
 <d32399c1-88ae-4b7d-925e-b82b2a983e30@app.fastmail.com>
From:   Ali Raza <aliraza@bu.edu>
In-Reply-To: <d32399c1-88ae-4b7d-925e-b82b2a983e30@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:c0::23) To BL0PR03MB4129.namprd03.prod.outlook.com
 (2603:10b6:208:65::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|BN9PR03MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 6850e9ef-e7a6-4cba-9d09-08daa7e01224
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYhK878do7lUqDnDI37IxlM6N4JvOXJ+rS/91xOvQKi4rDOCYIWm37+q+6cTem3xgYNWSZXCyu6HuCC2Z2LJQD63bUmdNICFHm8sD550me2HIgapFtkntcmwb69+W0GV+rBofR36fp9IuMQ81Jr7MhMUOdR3M1zsPVeH8Ve6004Y31KPV0Rwwm6E5Onj7O69wNhJ+lcR9coweLU2GNP14RARFyAoduEsKMGGxNQwp8vSOprYp8RwHKkFqRzvO2OwBGkNKqvQ5d7zGVFlqKFdH0CnJly2SkQ8kqDoGjUjQl2/5ZH26nSJzh5SntsCGoxRa0wc7S+rxiae6bbHKCCvFySdIwEDjelMDBQ2ArNvYbXWg19zRy/vD5FMO/55uUMf9ZjPF2+Tce/HLQdxTsobX+wSc4zxF8XHld/0j3f//ioYxO5ZJD4rb8fnHqaQ4betlO3upZwE1gLgI1d2RFAHKi5lUU3flFA5HjkfQJCIcBnqLQxbVDJMiZzhwZtrkSBiGj1jCPNP1rhduy7UzCLlSSpfBwzrqpZoWsf6B65j+t0jC3EkOT05c2L2iTVpez1Bxl9MquqqGsXYqhzZSPgGeTkBEtGUpUe0VkN6sYNp+HPlXvhBoZTGNfk3JaFCS4OpkoasQa9AJ5j4u8cn7R93K925Bv0cO052jUz9F/qk5wWgE3rB7WjP99v6hGLCPsY2aDIxIoKfI8re2lT2rdr/hiDlgd8YHe2keOVDs0FfxX7bLDkYmTs/YttEi/d2Iuuwz+8cbw7kXPk264xRNIghS5jTGjjR1+JmWYqUuUn/X8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(31686004)(83380400001)(186003)(41320700001)(110136005)(54906003)(36756003)(53546011)(6512007)(66946007)(41300700001)(66556008)(66476007)(8676002)(4326008)(75432002)(6666004)(26005)(6506007)(2906002)(2616005)(8936002)(38100700002)(31696002)(86362001)(7406005)(7416002)(786003)(316002)(478600001)(6486002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmZSVkNzQmg5UGFiaHNyamFPaitsckNaYmVYS0NGaEJqOXNJUXcrYVhKM2c5?=
 =?utf-8?B?d2dOZFlWL3lpajFMWFVMbUNERUZGNnphM0Z4OUE5QWpWS1FuT3paZlhKVkRO?=
 =?utf-8?B?dVBtVS84MDVURnBmUzlCb3IzNUQ4SStlbUQ5b2U2UDdZdDdBZTdVM3gwSTZ6?=
 =?utf-8?B?NTAzb1BBcXhKdXVzM0YxMUtXMjdKU24wcFY4SElWMEZqREpWbDFlSHpSSUlT?=
 =?utf-8?B?ZExQYUQ5aVpNVHdCdVBBdmlpTElMR3hoWWhPNW9wcnpwd2VNUXB2NnZRL2p4?=
 =?utf-8?B?R01KakZQbHBENXhVNVlyWEk5REtYcGk2TUVRWFJ6S1J0eVg0YUpEZXprOUFa?=
 =?utf-8?B?bDRzMDFKTFE0djVJZ0R1M0R2Qjh5ZlBia3RvNGRxZ3ZZeUpBTXgxanNzZDAz?=
 =?utf-8?B?a3dIYU5QMEsxTVlGMWFUbGpaYlV0WXdwZkVSNTh1WFRLRlFHdFdlU3BPN3c0?=
 =?utf-8?B?K0tESGJPYWtLQlF3UVgvTmpZNnVNblRmR2FGWDlEdnNobkJQV3BJbWU2RzhJ?=
 =?utf-8?B?RUNONHdJQlpraFd3WTM5T0FYekNyTllzcVdBVW5lVHJjc0VWYnd3ci9qOUNq?=
 =?utf-8?B?SitURGVOa1A3d2Juc1VyYVlSeDBTcy8wcUdVMCtPYnJKVjRxcDJzOE1JeTJD?=
 =?utf-8?B?ak1sNzA4UWhLWDBmVGRWYi9GZmpPdk9UeFBmSmdKcXN5UGt1N2VsaFJiN2VB?=
 =?utf-8?B?WFdWVTNiTlJwcmgvRlZWUzlIbDVOL2E3WWd0eXZEUlJtS0QrSDFmK09JVXJl?=
 =?utf-8?B?SVVzM1BabG5ZUFdhdVhJNm5OekpPUEU2MXp6OHRrZzY1MFByRSs2RkVrbDJv?=
 =?utf-8?B?ZkxpNDdrTTZJbTRmZ1dOU3BKdFpiZmhyVjBzRUVvaXBGL0VOL1VIRVgxc0xw?=
 =?utf-8?B?Y05mQXRSbUNMd1Z1a0FJNkNPaFFWallHYXZwM3FxdUFRVTRJOERtelUxY0Ri?=
 =?utf-8?B?ZHVkRlhKelZ4TWtTd1l3cTltNkJEL3pwU2NZRm4vc29iQklWc3UwSVhVQXB6?=
 =?utf-8?B?aVc3aXVSN240MmxTRkQ2RFA0YzZxTGJMdVd4WlJPNDFWbTdTOTFMT3AzVDQ0?=
 =?utf-8?B?TndVTWUvcVNGR1dWMXBxdXBXcUV0R0lBMEJPcjRVdC92L2V5T3lhWmVGVEJk?=
 =?utf-8?B?UnptQmJZUnJVamhvNnFtbUFZZ2VkWVB3YTZuY0wrNDNmZzBYclQvckYyWkt3?=
 =?utf-8?B?c2NEaDFiSjBjSi9KcHkzdThNR2RLK0I4Vlk2YXM2Zk5rNVhNTUYxUkRJUG9C?=
 =?utf-8?B?ZytRRGw0UXRSS2JobEErZy92N0k0SmIyRzRHK3RkSVczT1pCN1I0dENGUzRO?=
 =?utf-8?B?RmMyc3ZOZ1dpSHIySGlXVE5NSFIzWEwwSVFSTWdTZjN4VEphVksvVlp2OGNy?=
 =?utf-8?B?NVAxNTFmdFlFZVF4SExjdWFWcWx2ZnpseFJqTDArdVFaS2tDV2VENTVFZGtS?=
 =?utf-8?B?ajRTRU85OHFnN0JUSGdub2xYdEN0ejdzeW84Sm1TUkNpc21xdUFJdDludi85?=
 =?utf-8?B?WldFOGVTbi9IUlZoT2g5cUhDVE5XYk1kNEtjQXNuNUdVUGhJMGVQWjNrQnVl?=
 =?utf-8?B?clZXVVYyNjlTdHNOenQrNHAyamlnbkc1Tjk2U05TSEZnSjQvYVBMTkVtWDNo?=
 =?utf-8?B?ekhqdlBlR1BkWm8xQjEyalN2MytVV1FKYlRKaXN5Rit4RW9Ndmx0T01Zb1Jl?=
 =?utf-8?B?TUNWWGVDZHkzcS9LM3VjOXU4Qm5FNG5XUzllNU9HaWd4OS9oQ3hpSzREbVpW?=
 =?utf-8?B?ajJ2SVNRTmJKdlEvWEJGMStMbzBqdHcxVTlwS09UN0QvMEJ2TlRGWElQRlRL?=
 =?utf-8?B?Ym5hSzc2L2JRaEk5KzZ2TWx5ZUxQVjloUUEvNFpiakoyOEVVYy9TcnFYQjRX?=
 =?utf-8?B?Tlp1QjJhd2lxM2JQbkluY0dNaGZ1cHBWNjRnSUJQMnB0bmFVYi8vdEo4R1U2?=
 =?utf-8?B?cHFxN0lZbklZRWtXQjBZbEptVGxOVlhPWmdvZWRFdlloWnRYQmJWNU5zdkpv?=
 =?utf-8?B?MTZYaTllVXdyTU1ySVdxK1JJM2tzSGVGaGxRcGJpamZ3YVdmVnJVS2N2Vm5S?=
 =?utf-8?B?NjRFeUFSN2FEWVJsKzRmLzZUUitIU3RML216dG1oVG1rRWRyVjJpMURVNEJu?=
 =?utf-8?Q?k4iyW8O0ooFdfs0PERHzzt1h+?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6850e9ef-e7a6-4cba-9d09-08daa7e01224
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:16:44.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: El9netViXzDzLQB/gHGNcw0dhgG+upJTfAMQoFVsS8lhCgIRam1VgGcgRCe4KdL3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6202
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/22 13:36, Andy Lutomirski wrote:
> 
> 
> On Mon, Oct 3, 2022, at 3:21 PM, Ali Raza wrote:
>> When configured for UKL, access_ok needs to account for the unified address
>> space that is used by the kernel and the process being run. To do this,
>> they need to check the task struct field added earlier to determine where
>> the execution that is making the check is running. For a zero value, the
>> normal boundary definitions apply, but non-zero value indicates a UKL
>> thread and a shared address space should be assumed.
> 
> I think this is just wrong.  Why should a UKL process be able to read() to kernel (high-half) memory?
> 
> set_fs() is gone.  Please keep it gone.

UKL needs access to kernel memory because the UKL application is linked
with the kernel, so its data lives along with kernel data in the kernel
half of memory. So any thing which involves a check to see if user
pointer indeed lives in user part of memory would fail. For example,
anything which invokes copy_to_user or copy_from_user would involve a
call to access_ok. This would fail because the UKL user pointer will
have a kernel address.

> 
>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: Michal Marek <michal.lkml@markovi.net>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ben Segall <bsegall@google.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Valentin Schneider <vschneid@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
>>
>> Signed-off-by: Ali Raza <aliraza@bu.edu>
>> ---
>>  arch/x86/include/asm/uaccess.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
>> index 913e593a3b45..adef521b2e59 100644
>> --- a/arch/x86/include/asm/uaccess.h
>> +++ b/arch/x86/include/asm/uaccess.h
>> @@ -37,11 +37,19 @@ static inline bool pagefault_disabled(void);
>>   * Return: true (nonzero) if the memory block may be valid, false (zero)
>>   * if it is definitely invalid.
>>   */
>> +#ifdef CONFIG_UNIKERNEL_LINUX
>> +#define access_ok(addr, size)					\
>> +({									\
>> +	WARN_ON_IN_IRQ();						\
>> +	(is_ukl_thread() ? 1 : likely(__access_ok(addr, size)));	\
>> +})
>> +#else
>>  #define access_ok(addr, size)					\
>>  ({									\
>>  	WARN_ON_IN_IRQ();						\
>>  	likely(__access_ok(addr, size));				\
>>  })
>> +#endif
>>
>>  #include <asm-generic/access_ok.h>
>>
>> -- 
>> 2.21.3

