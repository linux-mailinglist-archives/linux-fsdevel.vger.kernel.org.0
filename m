Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6787C5F6FFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 23:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiJFVMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJFVM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:12:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2132.outbound.protection.outlook.com [40.107.244.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF7B14C0;
        Thu,  6 Oct 2022 14:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmrU80mTmKahKagE1LAnFzsUc5E+O/LaK4GWNYNQuxrS5/kcYZBnAIZHf41Y61GnRsTKQOwkrKjIBmdo0Z4iihekEZzqA/7Wo9S36J1iEZzoX3rqe0UHutFVPBKIMLACe0pUBB26YDC5Cp7wb2LfKHxpEcV6dyZ1IEouPCYBnthfy9lWhJMFJyASuZ26K8AIbNNtPcdAKd69PGR4ke8XjkCEJjVGUzB7wySOWGSrx+/Ne+1JBJxW0QPI6ZF2XZQXGP5qu41W9Kbs+DqclXSZwkYipt5qbhcVGFmfS/UFa+XdbAbb0AjPAoaByznOiobPp7iKmgFIDxT3V1YapD0r2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KWFRThrUuNZFv84yQ+XRshaJU4+oIOEla0zVzrRvtE=;
 b=G3xHvjqxQfJUTgHvlztKvHJJICFT7pexJiEzAsdBAijGAnWSl29eZnQrVSNSz6zB9kxvXcLIitWmXwpYoDVZiT/0+ySiRNMQfpOhTa2rJI+a1JC6q3Hk+2l+U27tvrG9cx9wi1RW2LrEZF5gBWiENsMMc8uxWhZ6pPL1kfH6+XTcHifkr2MsGGm4ynSB7L3/0hm8Go1JT2j8I9+YNDUCSnuDiS+WOLI7KpKpbRGH616cPb5XfYbz/Inxjgrh0LJOuJpAlJg13gTCE2jZd8Jpio2kpdmbIHfITcXtMcQCZZh0WuXfoLwpYuhtZEMI2gd5XPW+3+TmVITW+RSxNIRUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KWFRThrUuNZFv84yQ+XRshaJU4+oIOEla0zVzrRvtE=;
 b=WpNc6IXWBAwYRkt7bOUW/yEVkYfRctXsOeyQ6KseqQsTmRaMNFlBQQ/jh5xwT8efLSVSafZnEkpjnZ+/u04l5+r85d/+gbcmDnyxvYpcNFXpLuOQcGJBbvxWtl8c/OnBExRyrsu7OfZcUaRuX1QeQH+PUEpZ8if25ODMf2OuVh7CPzXv7eEBWOBsNQSDeXwqwv2g/4HJcZjSZuYyI45W5crkjPjrBF+jNkOF4Dsob7JpDe31I0EcTjRpCjrfa4JOzF/tBJ7vEFcrBtGJQNb9RSx23pYHIHyHz+smaOA6jvMUg1ZLNAAnXlISNisuJodHBuLBPioCNUi4FK1zqSPI2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by MW4PR03MB6427.namprd03.prod.outlook.com (2603:10b6:303:122::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 6 Oct
 2022 21:12:21 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 21:12:21 +0000
Message-ID: <3879d8ae-93dc-b830-76fb-10994e70e082@bu.edu>
Date:   Thu, 6 Oct 2022 17:12:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC UKL 04/10] x86/entry: Create alternate entry path for system
 calls
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
        rmancuso@bu.edu, Daniel Bristot de Oliveira <bristot@kernel.org>
References: <20221003222133.20948-1-aliraza@bu.edu>
 <20221003222133.20948-5-aliraza@bu.edu>
 <b8e86bd9-f8a1-4f37-8f1a-ae0b6209d922@app.fastmail.com>
From:   Ali Raza <aliraza@bu.edu>
In-Reply-To: <b8e86bd9-f8a1-4f37-8f1a-ae0b6209d922@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:36e::6) To BL0PR03MB4129.namprd03.prod.outlook.com
 (2603:10b6:208:65::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|MW4PR03MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6ae5ff-df40-4bbf-d77c-08daa7df7526
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezMtC869Qe+yiU1UELrSrQ+78MtMloY0/HR0gtp3Sh8jNAVqcvTXP8C54lRnROd5G/6hsEX2ykE2RO1zsyOpcs21Cc2oaajAGoidDQrSsqlTG360AyW7+RMJFiWMl/xDOLewbNQCWC98mKTd5o6TF8kUcoJ+P9KvEk9O+E++IK5YheKcADJVQMMxVoypskL6e84ZsS76FSCMoODAyZMkY31OAdTX5WLmidCx+OA+gk7YgokdBw9nrUwgmRN2k6xWBEwIIKORcAcLGxLA+EUW+AWw1ST706wDHbxcUsLjupK/4h6JmQ/+J/ZMg3qhsFwswnxH7M1/B+yJFZElvYB492QR3VFtaY4sNN6xhi1JM356yU6n2nYs4WXtOLTF6iWrMU6FRHqtSMGuOI0pK7+OnHtWJBBgJOuaSHM1cP2D8eXhvCFptZv4NQGJoDBwSPdvE4bC/H946bTBZiDFdlwf0IpZbQDyyjCdSng7KfABUZIA07s2IoWXJU2/a5ofJWDdpWw9GYmclUGaaLyP7HnhXpVUkQGXU1On1C9M91guqANRz/cxpG1vc+AJ0PKB8AIKAnIQVP4XydXagGO31HNmioZNWK1Y9QG52ehS9b3F9XbYx8wA/GS3fsavm4qfBVw7JAgJpbxUeVUupxvjfp1t7/Wme9pDD7lRhp+omWtAGxgluZNy8d5ltG64cAptHDIa9B0mTcOKERcZ1LfSDjjOUIcrQ91M+d/RixSBs7kJ3SfRDR99Yt9YcCJQR73E/nmAIt/M1IAUtoRvMQ72Y7pljPUBBPlYhpkcavNyHbEClrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(66899015)(38100700002)(75432002)(2906002)(6512007)(478600001)(41320700001)(6506007)(26005)(31696002)(7406005)(5660300002)(7416002)(186003)(6486002)(2616005)(316002)(110136005)(786003)(31686004)(36756003)(53546011)(8676002)(83380400001)(66946007)(86362001)(66476007)(66556008)(8936002)(41300700001)(54906003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M21uMElKWEIyTTZXeVJWSENtWDFHa0p4RnZoMVZMWE13Q1JKQWNzT1A1NTY4?=
 =?utf-8?B?cFJLdllKbFl1b01jbWtDMEZzd0luMlE5TkxUN2EyQmZ1aFp1Skk0aGowcVlB?=
 =?utf-8?B?dG9wcFVGREdzcFFpMlN5Q1M0ZUtNOUZxSjBhQk4rMDYxaVZDNkdBaXVyMDll?=
 =?utf-8?B?UGU4Q2VIazZmaEM5QlMrZHE2TGVMYjNMYXFHYmFQajZRMGZNV3BmUUdwcnZt?=
 =?utf-8?B?Q0xJWFVORWl2ZG13cnJWOGIzcElBSEZnYlNnOUx5b3JveVVrbXcrcmVMRStB?=
 =?utf-8?B?ZG50N2hKQU1WNGJJbEJrUi9BbWpKcm1sRnE5dXM5UE5vK0hOSGU1L2RINmM3?=
 =?utf-8?B?ck94KytUN2traWhVR3QvNk0zOXhXT0dEV2NoTnVGR1IxMGh4N0RPbk9KKzgv?=
 =?utf-8?B?SkVoVmpqeUIveXhjTlVGbk8rRVJTd2ZCWUpSR2dFR0ZWRWRtQnRONE5jRkVN?=
 =?utf-8?B?Y2dHOVNLdnZoUEQ4aHJnSThiYTBiQXVKaTdSU1YvSjRQd2RZcDlGUVFNSzFU?=
 =?utf-8?B?aUpMWkp4Wm56d2RVdXk4bDQ1V0laSlNzYkhzc0E1TGFGOHpQb1FVeXpnWi95?=
 =?utf-8?B?R0w5ZDFqSVM5ZEVib3pLeUlTKzRHQkpueHYvNWIwbm1XZzU3R0RhMG9rRkFm?=
 =?utf-8?B?bEJSMmp4cTd4dTN6OVR6MHNUVWU0WmRQNFdRdTFqSkxqWFphTzM0VjhaWEJm?=
 =?utf-8?B?UTFwV1EvTkcxLzZvV1pDVEpheENPQ2ZjMXFPTG5VN0h6dUxGdUlLSjRUSjVj?=
 =?utf-8?B?UDJGSEVTYTZublRsOVBqT1Z0akZ2K29wUFkrYTJnYzZXajd5S3pXRzdNL0Q4?=
 =?utf-8?B?T1VodGhFUk0wbTc5UEtud3RkYVBab3dOYnVMR2ZTSTlNTFhRSDc5RFBjTFdN?=
 =?utf-8?B?Q3gvQnBCN1VFMVVyMUhSbWV4N204Zkw3L2hDNFF3S2RkeEdMcnNhN2VWYmJ3?=
 =?utf-8?B?cTJhWEN6S0FHTGxGU250NmVJeFlWZDFaY0VYbElLVldEeEVEZExmNzdkVmx1?=
 =?utf-8?B?YzhNc2orNHVVQ0dYa094Um9qd3V0bDRPUWlldWc0c20zVVpJdEZBb2ZKOWk1?=
 =?utf-8?B?L3NUNXQ4SGg4dGpycnNuRzlRNk5JTTlIM1dScHJBYTJDdFVYUUNQMjBHeWZV?=
 =?utf-8?B?QituY2I0MVlISElQZWlnQWNwaEI1aFUremNIR0IxMXFwQXlEWkF1K2k2WmVy?=
 =?utf-8?B?cVgvUE9pcjhOajA4dmpRY2FBOFczRXNRSlRMcTV2K3VJZ0pBZVRNOWozcjZK?=
 =?utf-8?B?Umw2RHFsaFBxb2FNb3E5d1ZDTVJLMmZLOWJqRHFvTkVWMHVTUWZpSm52Zjlr?=
 =?utf-8?B?NUFndnU0TS9mR2dmYTRZWVJhQ0dNOWRRdjdIdkFzd0hwYThVVEJ5MjVHRVJT?=
 =?utf-8?B?dXYrTnpPMGtkc2pqaWhrU0hWNWxoMFl6TkpIbFNPTEFSdFJtcUZLQnlpdWFp?=
 =?utf-8?B?dm42T1JoZzdsQ2plRnBKem1Kd0tmV0M0R2FIenFOdGdqUTVqZkk4YzNkOWRQ?=
 =?utf-8?B?Q0M3QU1jaXgrMFk0TGNrRHc1d2RtUUx4c3l2UjNmTmVqZVAyZmZCUzRNZWlZ?=
 =?utf-8?B?MDNTakNUaEIxdUx1dnFnSDlUSzFGaWY2RXVlUzk2WlRtWUVSdzlUeEVoQmh1?=
 =?utf-8?B?STFidkVORFY3VjZLRExaS0tNczljOEVyZHBNeXJEMDNjcEFDbmlPTkhiK29r?=
 =?utf-8?B?VENvMkZyL1BiRDl6Z0NMa3JKZTZwUmVuSXhFM3JwbWhhcmtEWGw5emtJT3pX?=
 =?utf-8?B?ZmZZbkhKSmVGSWY0NlhrNDBLdlQyRTViQW0wQk9RQ1VIWERZc2d0ckVnYm1o?=
 =?utf-8?B?K21mVHRTY1FCd0hzRS8zcmNNSXg5Q1dQSm5qaG5sSDdkQ2IrUjJ1VVJMN1lH?=
 =?utf-8?B?bEpQK1pudmE0dkIyMnJleXVXaWZkNjNMdDFxZFJQMGY3ZmlybU0yYnFrYjBS?=
 =?utf-8?B?NTVkVWoxTktZSFZIeXc0U2R0YjRLcmNNVDNJd3MrdExBTG5RNm1SQ0VRS1Bo?=
 =?utf-8?B?eHRHWGJBblRzZmVHS3B2SHR5QitaemduVzc4L2o1OVFaeS9zUi91c1BORWUx?=
 =?utf-8?B?NXpIM283YkNDRXVKWG9SbTJhZG5CNnk1amliOW1KMVQ0c2NKMU5renJJOXJ2?=
 =?utf-8?Q?Aj/C1ROKUMiVGhbU1QeStBO+L?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6ae5ff-df40-4bbf-d77c-08daa7df7526
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:12:21.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OyxJgQVi+AxjeY8CNMZjpR2GbT5dPfmbp7Xfzymr37MTofi/7rxORlonmrA02I7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6427
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/22 13:43, Andy Lutomirski wrote:
> 
> 
> On Mon, Oct 3, 2022, at 3:21 PM, Ali Raza wrote:
>> If a UKL application makes a system call, it won't go through with the
>> syscall assembly instruction. Instead, the application will use the call
>> instruction to go to the kernel entry point. Instead of adding checks to
>> the normal entry_SYSCALL_64 to see if we came here from a UKL task or a
>> normal application task, we create a totally new entry point called
>> ukl_entry_SYSCALL_64. This allows the normal entry point to be unchanged
>> and simplifies the UKL specific code as well.
>>
>> ukl_entry_SYSCALL_64 is similar to entry_SYSCALL_64 except that it has to
>> populate %rcx with return address manually (syscall instruction does that
>> automatically for normal application tasks). This allows the pt_regs to be
>> correct. Also, we have to push the flags onto the user stack, because on
>> the return path, we first switch to user stack, then pop the flags and then
>> return. Popping the flags would restart interrupts, so we dont want to be
>> stuck on kernel stack when an interrupt hits. All this can be done with an
>> iret instruction, but call/iret pair performans way slower than a call/ret
>> pair.
>>
>> Also, on the entry path, we make sure the context flag i.e., in_user is set
>> to 1 to indicate we are now in kernel context so any new interrupts dont
>> have to go through kernel entry code again. This is normally done with the
>> CS value on stack, but in UKL case that will always be a kernel value. On
>> the way back, the in_user is switched back to 2 to indicate that now
>> application context is being entered. All non-UKL tasks have the in_user
>> value set to 0.
> 
> 
>>
>> The UKL application uses a slightly different value for CS, instead of
>> 0x33, we use 0xC3. As most of the tests compare only the least significant
>> nibble, they behave as expected. The C value in the second nibble allows us
>> to distinguish between user space and UKL application code.
> 
> My intuition would be to try this the other way around.  Use an actual honest CS (specifically _KERNEL_CS) for pt_regs->cs.  Translate at the user ABI boundary instead.  After all, a UKL task is essentially just a kernel thread that happens to have a pt_regs area.

Yes I agree, we can use _KERNEL_CS for UKL threads and then
differentiate between kernel and UKL threads based on a call to
is_ukl_thread. Thank you for pointing that out.

> 
> 
>>
>> Rest of the code makes sure the above mentioned in_user context tracking is
>> done for all entry and exit cases i.e., for interrupts, exceptions etc.  If
>> its a UKL task, if in_user value is 2, we treat it as an application task,
>> and if it is 1, we treat it as coming from kernel context. We skip these
>> checks if in_user is 0.
> 
> By "context tracking" are you referring to RCU?  Since a UKL task is essentially a kernel thread, what "entry" is there other than setting up pt_regs?

Yes, a UKL thread is a kernel thread in that it always executes in
kernel mode. But it is also different than a kernel thread in that it
executes application code as well. Application code requires scheduling,
signal handling etc to work. RCU work needs to be done as well. So the
entry from application code, be it for system calls (without the syscall
instruction), exceptions, interrupts etc., would involve RCU context
tracking. And exit for all these paths would include everything
syscall_exit_to_user_mode does. A UKL thread interrupted while running
kernel code will be dealt like a normal kernel thread.

Put differently, UKL is decoupling user code from user mode, and kernel
code from kernel mode. The user/kernel code is tracked through the
in_user flag in task_struct, while UKL always remains in kernel mode.

> 
>>
>> swapgs_restore_regs_and_return_to_usermode changes also make sure that
>> in_user is correct and then we iret back.
>>
>> Double fault handling is special case. Normally, if a user stack suffers a
>> page fault, hardware switches to a kernel stack and pushes a frame onto the
>> kernel stack. This switch only happens if the execution was in user
>> privilege level when the page fault occurred. For UKL, execution is always
>> in kernel level, so when the user stack suffers a page fault, no switch to
>> a pinned kernel stack happens, and hardware tries to push state on the
>> already faulting user stack. This generates a double fault. So we handle
>> this case in the double fault handler by assuming any double fault is
>> actually a user stack page fault. This can also be fixed by making all page
>> faults go through a pinned stack using the IST mechanism. We have tried and
>> tested that, but in the interest of touching as little code as possible, we
>> chose this option instead.
> 
> Eww.  I guess this is a real problem, but eww.

Yes, I agree.

What might make it less eww would be using the IST mechanism. That would
include setting up a separate stack for all page faults so that we are
guaranteed a fresh stack by hardware every time a page fault occurs.
That would modify the normal path for non UKL page faults as well, and
also touch more code (IDT set up and some boot up code etc.). But we
have implemented and tested it on our end, and would be happy to share
that code as well.

> 

