Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE2F5B69C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 10:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIMIoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIMIoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:44:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB981EEC1;
        Tue, 13 Sep 2022 01:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+4/8kQ+MpGVOSBYb+JBdZAyrm0pd4j/mank12Y1LGW5juWVlTpGc2dplN4cHK2gY1m5cmJPK50S+M4PHMTuv4nwrNsXXXqPwp6b48NBTtCPS3vhG5EhaM8Im0Z8vL1I9OIWpaAaRlKUUQOTzS9EvBrTEVUxPXQhxxkMK9u+ykWrD8A9kl272/bj4NNdaIFujUAVC9nM76ZV2qhK7exJnjxIIMjBoZS80eo6BisNMtUgTNqkc21oGwYhlzQAapA28L3NSsz2Jy8v1kYuoqNzTwbbb6APWSyM8ycHZvuaYTyGdi7YQ2FywfjqoQyZDkXOme8f8gDGVoqxgNa+aAopNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fyf12z2hdQxJQEcdn4iRSxnS6bfH5rdvv+cDvXpjCl8=;
 b=F8Y61lOsHea8pgQ+yE+BjvFths8ssWTHaMA8uoxC+RhqVmNyXXz0xRc5eSceRP/kuTkFdZqXOyADVlB7KONGurclOYtpQE2q+LQ0waSLwenRrDDwzM+V5jdeucYIwNXZLJv/cWJZbnI4m4B+lim/llehDy8+64cWU5LCezNat5+cDPeT5f8oUjWIdjV/THuPwNxUaZ+anCx5QJaR+R96xmVb32Hn7E0Ao0KGzI+oC+aup8HjXsbq7jc69AN3/KO0V8x8UCzbg7oztKrqecT/TRnVgrhMXN1UffgLrvTO2CmVRtxi4J4FiY9/ViD8IAOb6zQEOgTCrh+t/A6o4rXLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fyf12z2hdQxJQEcdn4iRSxnS6bfH5rdvv+cDvXpjCl8=;
 b=q1aYNyme59xRqcIW6GQB1TU3ZgRFvWqrCcgfz5t1tFEjjsvAGLaNio2gxUSz4brg2cvd/H7T/Opq1oE6S3AvZIFkZSWjY9PMlmGWkT76rV07PGJ8mRn/Rh+T59fAO1Y/VwVcPHxhS7WeclmP14pjvKUaGKhU07Ox20wnlumNuHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by SJ0PR19MB6814.namprd19.prod.outlook.com (2603:10b6:a03:449::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 08:44:09 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::317e:e5b2:ce73:26c6]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::317e:e5b2:ce73:26c6%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 08:44:09 +0000
Message-ID: <4f0f82ff-69aa-e143-e254-f3da7ccf414d@ddn.com>
Date:   Tue, 13 Sep 2022 10:44:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 1/1] Allow non-extending parallel direct writes on the
 same file.
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>
References: <20220617071027.6569-1-dharamhans87@gmail.com>
 <20220617071027.6569-2-dharamhans87@gmail.com>
 <CAJfpegtRzDbcayn7MYKpgO1MBFeBihyfRB402JHtJkbXg1dvLg@mail.gmail.com>
 <08d11895-cc40-43da-0437-09d3a831b27b@fastmail.fm>
 <CAJfpegvSK0VmU6cLx5kiuXJ=RyL0d4=gvGLFCWQ16FrBGKmhMQ@mail.gmail.com>
Content-Language: de-CH, en-US
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <CAJfpegvSK0VmU6cLx5kiuXJ=RyL0d4=gvGLFCWQ16FrBGKmhMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0176.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::20) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1901MB2037:EE_|SJ0PR19MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 48aae47c-ea22-43f2-9fc2-08da95642016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IK5lZSips/EnTqNI6bneZkXgZt0GWZdquuk6qeUEOu4pdFdH2gqQFibqX/Q3iEaU0FL+xzO3Xhx1CMeh+DRHBXyGxDCSVhkSPzm2DcIrNShcrAMeqMJJ0JTbq2JOFdlLm+Nn96k9tes1gC6nUiesnCQjcULxZWycn2/xCwzFvzUItfS1uuj27BYAF+smm7IJDs5nRSHilDme1hSMny2A0b7GqCVaMxjBj9FZj+eURBacDXB9YK/JGswe83o3fT7a4VNragEyu6xRCCSExa5VcV+rrLvP1urxMDdHDKKbt58ptDx9kyGNxrApVEH+ydpLA6RZteFOERJKFIAyvQjE0lTGBWLulNJrFj71cA1H2LFKu4nymtffZ3XyZk9fYNwnABjtA8uDSF9l3qZLH6/xI4BaufCeIvLso/r924pfl895ZifbQDmVScBJW40KAZH5C/94No1nbBJyPpuZLbcFJN1Dmj41SBDQ0qY9FWP52NQVZgoDfb95q5BI+olrG5+KujNT+mhfeRhGNFMlUcj+8nEzEy4tpIi+bL+E7jxXSPGGJfjc+3IVlouxDXUU+PG/aV9Tn+8tkqZc58YQsfMpn50WdrPkqxUziLDWvII/U0oLoBA+vYOShZ3NGcx6Ab1M+LtMZtA0ULlNaGkihiIduIT5gxzaccHG2r2KCa5kHzSD9OQ891Kyln+XflQ+NjIIrVAau+MDXrd8/hsh7x1xVhYJyKX8UTOL2NkVZiBPUPldcDfGTe45hY8hexD4H/IAcoFeS+JzwusV3S5jFJPwwOBMmF3aRznRfLZ81TaIFjrVTfPV8m9ddEzRYPv0b4BQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(346002)(136003)(366004)(376002)(396003)(451199015)(966005)(54906003)(6916009)(6486002)(31686004)(316002)(36756003)(38100700002)(186003)(2616005)(83380400001)(86362001)(31696002)(2906002)(6666004)(6506007)(53546011)(478600001)(6512007)(8676002)(41300700001)(5660300002)(66556008)(4326008)(66476007)(8936002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWoxWWdJZzkwRFNyampsMUtqNXJpOUI2VHIvLzN4ZGVpZkZMbUF3MVdXcEor?=
 =?utf-8?B?TlUyeUYyN0tKRDJzODJ1aC9FR2VjVlJ6cjVDakZKandqOGREUGlYR1htVkhO?=
 =?utf-8?B?Ync4V1ROY1RRTHI2endZUFFhcXZLK1V2dDBTWDFLUlFpbHg0bnE5TGdjZWYv?=
 =?utf-8?B?ekJ6SGFEdzhoUFBiQS9ueEkvREZEU3pGK2pxbWM5Nm1KK1NaaXBWb2oxYmN5?=
 =?utf-8?B?anJHbnVqNjhDYnAxR29nWkpLMnRhQm1SeXVuZ2d2dll6T005aEs2N3o2aW5R?=
 =?utf-8?B?UTJ2T0p2MW9wR0JuZzBjS2VVN0p2c0FQTjlLdDVCQXpmZUVlTllxRmR5U1Jp?=
 =?utf-8?B?SDZqaEphNWhDcjRIVEhOeDdvMEdFcUxsOTQ0ckg1TlRTRFlUaFNEaklKc055?=
 =?utf-8?B?bWVUaURQWXMzNVJ5bWZoYWxVMy91UkM1RUtrRlF6OSt5clFJOWM3QmlqVDhG?=
 =?utf-8?B?YzVpdzZMTnVwOU11RlJ0ZDdISkZWbWFzaWRYQ3E4R3JZQklvKzRIZ2x0S2xK?=
 =?utf-8?B?aDk1aWdXS2tZN1FFR242dWFOZm5GNklFQnJKczhSSi9sQjVMWUE4M1B6SE0x?=
 =?utf-8?B?TUVWd2M5My8wSGE3NjJ2WC9UajhSKzdMcnZCSEs3MWxadXllNFQ0eWtBTG1Z?=
 =?utf-8?B?MXFMZXFKMmVLOFZNRjhzWEQrMWNxc2xCNHRYclZkbEJVMHVlaGlKSTZMS1Vl?=
 =?utf-8?B?QXJHOFFWRitWS1k0N2g1SXhPYmNGVE4vdW9paktWRmErT3JEN1lXVnJ1OWla?=
 =?utf-8?B?NTVFbWxHVVlpN3FUMzM1ZDFDREZseXFOSFpONzl2SGIxNXlsQXkzZCs0dHFN?=
 =?utf-8?B?ZGUvRUQwblBoNkZlWHBjZzJBQktCZHJwaC9URldMRkdTSTgvWmVjRWlJSXZO?=
 =?utf-8?B?Wkh0dFVDL1UvT05JbVRKYytESmE1TU0yWHprMTd1WExQNDladzh5NlRicy8w?=
 =?utf-8?B?NHNBUEJ0dlJmQXZZakhueVRmVGpkQ0lqWmxjbFBncXNqSmVkd3NBOXd1dDVZ?=
 =?utf-8?B?ZXU1SG1NWHpmbXA5SkZNR05PYnpyY3NqZnBuOTZTTUtUQ3ZiNU9qODgwMkVI?=
 =?utf-8?B?dC9yWHJzTlh6Z1JFVFdWbUM3N0YxZmllRURnUUNoOXBtNkM5a0FlQ1JCYzRa?=
 =?utf-8?B?KzlQcnpoaE43ZS8rbFpYZ0NKOU5aWENYWEphRVA2OGtLK09jeHoxUUMrYWl6?=
 =?utf-8?B?ZXh2cGJOZWhNSTc2aUg3aW9mQ0RsSnBiSXNtb1c4ZnN0ZlZ1dlZ3WUxwYWRD?=
 =?utf-8?B?a3EyNm1IcWx3YVlqeXZJK1hKWjVaMlFRb25JRHRiSVA0L3BGOUJDQm9Xck1w?=
 =?utf-8?B?b3lkMDRobER6bG1sbTVxbzd0RThBeEx5MGhMdkNsRWNnSG9iaFg5VUtyRlZr?=
 =?utf-8?B?bnRnNjhFV0x4TjBDaGdoNHdnUjZ6dXU3OTUyK1hFaFNzMFdnU2VEQ25SWDlo?=
 =?utf-8?B?akJEbVJOYTRQQXAxN1l2d2lGT20rMVZTNmdEWC9PS0NQMG9aY3k5R1lTQkdS?=
 =?utf-8?B?Zll5bzZWOFdtcDFFZG1ZbHhXSGVSaEdrWmdNVk12ajVsU3BCMnNTd3ZtZ3Ix?=
 =?utf-8?B?a3NGMEVHbDkvUFd2VG5Yc3lTSjZaRFcwdzhhMzFwYi9WN0V5WkpZNDJlc0dG?=
 =?utf-8?B?cGZNbmJRMkdRYzRSZzBDaU13UmN2THhuVWRaVjFZOWg4MzNrUnFZd0U4anlF?=
 =?utf-8?B?VWRQQWpZQksxcEkyUStWQlZXVmdHQml6U2dKQzRnSXgrY0w1TFJCSFFOcFBk?=
 =?utf-8?B?SVhpUXRzaG4waGw2QUQ1aWMwZWo3QjNZNzdaT211ODU5Wk9DVVN0WDVYQjFU?=
 =?utf-8?B?clpDRW52VmNJOFU2U2JIOU1XUmhQeFMrOVN1cEpKays4VDhpc3pLdlVsQm1R?=
 =?utf-8?B?ek9qbWlMT3lCRnlSOVJ0d2tKc2dzeW0vWjdlbjBMaUZyaytnY21zMEliTHo4?=
 =?utf-8?B?UHF0SUJpMWFFTXZ0M2RlTllhVVBvMnQ1aVJLVUxmU3llT2NGNzdxbjFGMm1j?=
 =?utf-8?B?VVgzaHpTODd0R3ZwN3hVQy9NNjNQU3Q4cWxzYnlXRXpacW95UDltbTdiKzFX?=
 =?utf-8?B?V1BLK29mTWg2bG1UQ3dSZVQ5dUJaMnUrRWFOaHN2ejRRTmQxWFhsem1KdjFw?=
 =?utf-8?B?ZVErVnhtZ2N1dGFNV1Rkb1FZNG40WlBxUURIQld0VVZ0STFOdGszWWJ3dmRn?=
 =?utf-8?Q?x7G9NYiuPgHcWPy8f0i4iFu6CDOXMwO5LvwQojxtYFwp?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48aae47c-ea22-43f2-9fc2-08da95642016
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 08:44:09.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxZiAd5/H/1HhciUbYAT6Z1kbfD3k8j6k06jC/Ci+2W+5ETto1Uxq7K0+MLgLlq+sM6f4BrANh9LCXKYbQdYHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB6814
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/17/22 14:43, Miklos Szeredi wrote:
> On Fri, 17 Jun 2022 at 11:25, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Miklos,
>>
>> On 6/17/22 09:36, Miklos Szeredi wrote:
>>> On Fri, 17 Jun 2022 at 09:10, Dharmendra Singh <dharamhans87@gmail.com> wrote:
>>>
>>>> This patch relaxes the exclusive lock for direct non-extending writes
>>>> only. File size extending writes might not need the lock either,
>>>> but we are not entirely sure if there is a risk to introduce any
>>>> kind of regression. Furthermore, benchmarking with fio does not
>>>> show a difference between patch versions that take on file size
>>>> extension a) an exclusive lock and b) a shared lock.
>>>
>>> I'm okay with this, but ISTR Bernd noted a real-life scenario where
>>> this is not sufficient.  Maybe that should be mentioned in the patch
>>> header?
>>
>>
>> the above comment is actually directly from me.
>>
>> We didn't check if fio extends the file before the runs, but even if it
>> would, my current thinking is that before we serialized n-threads, now
>> we have an alternation of
>>          - "parallel n-1 threads running" + 1 waiting thread
>>          - "blocked  n-1 threads" + 1 running
>>
>> I think if we will come back anyway, if we should continue to see slow
>> IO with MPIIO. Right now we want to get our patches merged first and
>> then will create an updated module for RHEL8 (+derivatives) customers.
>> Our benchmark machines are also running plain RHEL8 kernels - without
>> back porting the modules first we don' know yet what we will be the
>> actual impact to things like io500.
>>
>> Shall we still extend the commit message or are we good to go?
> 
> Well, it would be nice to see the real workload on the backported
> patch.   Not just because it would tell us if this makes sense in the
> first place, but also to have additional testing.


Sorry for the delay, Dharmendra and me got busy with other tasks and 
Horst (in CC) took over the patches and did the MPIIO benchmarks on 5.19.

Results with https://github.com/dchirikov/mpiio.git

		unpatched    patched	  patched
		(extending) (extending)	 (non-extending)
----------------------------------------------------------
		 MB/s	     MB/s            MB/s
2 threads     2275.00      2497.00 	 5688.00
4 threads     2438.00      2560.00      10240.00
8 threads     2925.00      3792.00      25600.00
16 threads    3792.00 	  10240.00      20480.00


(Patched-nonextending is a manual operation on the file to extend the 
size, mpiio does not support that natively, as far as I know.)



Results with IOR (HPC quasi standard benchmark)

ior -w -E -k -o /tmp/test/home/hbi/test/test.1 -a mpiio -s 1280 -b 8m -t 8m


		unpatched     	patched
		(extending)     (extending)
-------------------------------------------
		   MB/s		  MB/s
2 threads	2086.10		2027.76
4 threads	1858.94		2132.73
8 threads	1792.68		4609.05
16 threads	1786.48		8627.96


(IOR does not allow manual file extension, without changing its code.)

We can see that patched non-extending gives the best results, as 
Dharmendra has already posted before, but results are still
much better with the patches in extending mode. My assumption is here 
instead serializing N-writers, there is an alternative
run of
	- 1 thread extending, N-1 waiting
	- N-1 writing, 1 thread waiting
in the patched version.



Thanks,
Bernd
