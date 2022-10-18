Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC536036CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 01:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJRXwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 19:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJRXwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:52:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD70ED0CCB;
        Tue, 18 Oct 2022 16:52:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29INiIVq005692;
        Tue, 18 Oct 2022 23:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=wxr1qgkBIBoc1qFzk8MPT2cKIbKIw5qtE7zZ9pGdZaw=;
 b=kRvghdbwD/Mrh5SdS8gYVcF3iLZK+9rWyZL0dWFPDeSOOJVTuTeXDYwf3Kgv1lMNMfCb
 PEqMfjeZ5cZSjYsADaagH0+2/apE69BUy/APspmNzAm9JmosiKHgurQFLord1X8b/iMm
 L7+DW6hhC6l5IZ1NBHSo5QMMuoauT/ViPSdub+b4ArNSKc8u6L4H3zWNATeESxy4xbSW
 4nhw+zvSVlils+KyurvIdKrg9JywlBz1FNbXBkf5WZqOLBPD+7phJIgyFF+bdlkwsf/w
 BBKYS0jZzfPbLTnAH7rNPIp3iqOmPuYWok8KRpNEYX5tL6rPwJcwNjcTM/Xgr8UgBL0S TQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu00h46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 23:52:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IMCe5C033291;
        Tue, 18 Oct 2022 23:52:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hraydbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 23:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMnZ9hby3vahwtnn5hQjWZ2urqYvKtFDa4UCddckIxLAo0lkXFmiYSYB4w4LMGi6slK+wqK2EYaS2LXzKNl6+aSVhfxFzjMe2aCOz9Rofj2t7FQz891Yc/V5fshbYL3N7jThxll7qSsxDCvUkgtQzijVm9EWYAGgsa3foM1Z5FR/e1uMc1YVMPGh3Tz80cSLNvgSmKCoxu/XTSD/fsSgMwP+u+EUczdJGRC4MYOicS2UrG92pOqX/QRpNfb5E1KKQzB7ODl9VsD+VedJhK8HdCk79ibBd8gwIH6X6Gg+u0FPyRZGSDirm7+CrEqx47Hmtf0+IWHMySZInKLNz0DJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxr1qgkBIBoc1qFzk8MPT2cKIbKIw5qtE7zZ9pGdZaw=;
 b=KFa3qEURdZ+PtY6FfAWnWwEB7BXZW4Um8K2ZAyleAngZc5wkKwGjROpsBhN6LWsCMG+PE692EvwrItKvtqvhcTfcZpxpu5uyuhSJzC5Zn3fZjpOMETNX9GD9fgS/I6Fjyfk0cANFzspNMtaMVfhrf47GQK7noxM4nGG5rzSvDIG2QSU1d1TtmRp6ZyVHt8e702WADfFhjGObig95GuUh+yvrTtMw1be+bqwJQ83Z9DgN8wMSPc7rP1bfHFm1ZLPsqi/HoFm9/dLxoirQXGPtxW1J6SJnhIya76JxkF51d5tiUe3NfxXm091HkIHtAhNdjuufjeNkzzneO+nO90oUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxr1qgkBIBoc1qFzk8MPT2cKIbKIw5qtE7zZ9pGdZaw=;
 b=toOPhjCG7cBY2MUFpw6ltBX8yR5AaQK0iHUtkMO2AZX8BxE3OjNJhJraCugcpg1b8Tw9L3jchpOIezYdtzlaJ4a8q44ybw4oHlKatsPlLjyvM1sur9wsLEazTNhAaPuKej0s+BU1/7kIgBHHTDkH7oweZ2pxn1bdi7Upy7oCU98=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CO1PR10MB4724.namprd10.prod.outlook.com (2603:10b6:303:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 23:52:40 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 23:52:40 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fsnotify: fix softlockups iterating over d_subdirs
In-Reply-To: <CAOQ4uxgnW1An-3FJvUfYoixeycZ0w=XDfU0fh6RdV4KM9DzX_g@mail.gmail.com>
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <CAOQ4uxgnW1An-3FJvUfYoixeycZ0w=XDfU0fh6RdV4KM9DzX_g@mail.gmail.com>
Date:   Tue, 18 Oct 2022 16:52:38 -0700
Message-ID: <87edv44rll.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::23) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CO1PR10MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 144c7d68-ab44-44f6-d207-08dab163d740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVBgNnNVyQTgyupNzQO/eINS8B5Zfs1ZzV1GKsXYVbBbb3jti+z7ZGCpjMSGwTJuFfYoBCskqJbe6Rre1LcQLVK/MuMvEIOF+UkUaVOBVqG8JWVuIn/ihW2W82G4bkeJYMsG3ytccmdkkfeZGel86DKIFz67hbvRxyxRlB9ltMBhfThxpjOklReW7bznTiGI0MZU/Dis16C23nQ+xHGSHAlBxU50xh98W8chQAGj4aHHyL7g3mtKwrOpLAWjw6orVX+XYTosT73/2MskDQ4B8fELrpY6xwY0w0NGEgtv7gE2A+m0PC7yTZS55d3IR0MXQcb3nzLbP1yuxXe8sHmlktOsOzZY28LbwZvXxFrRs/BQWN1neAblrGPEf90Jtw/JhELvb1nP+OPAzjV0pKW0vviD/4IdXODWMPw7K3znVYYB1JJUEOcIOdTeOq8tsC/GM2ZAB/x7MBfCBaKsa7sD3NYRN5Vuz2rNSbR1CmF9ED2JDrqKj268L639WLbY8druUNdIp4uLV0gzTsglZrUr0DZC4m2ivDkWjHcyoCN46R87Yh7eIHCPALFVyOmW9CvI45wHavXhw24JhNnENjuxepvgu2FMFbO2Lr3tkPbMsxTf8ZUqJnlWaW4CUEpy8jM4xytaVCDs/NcO4Np1VyfJWwCwd1b+HNU8Rjq7XgjPbCnITxwvPnclm9y5eP1CT71ZvVJ7vjJIi8YUTfYa4puYvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(38100700002)(2616005)(316002)(26005)(8936002)(6506007)(6512007)(36756003)(5660300002)(66946007)(66476007)(4326008)(8676002)(2906002)(41300700001)(53546011)(66556008)(186003)(86362001)(6486002)(54906003)(83380400001)(478600001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OuZzwUSSMWirR5aO9UguvTfWfm51/U3ZaG89m/tSWoqIPBz06T0RXppGK8Ni?=
 =?us-ascii?Q?xfO9w6QC4EjDNcvkAJjLn+xvoB5ciJJhrCzgnLgAzg1Em7/mSdoH1r9jgs9J?=
 =?us-ascii?Q?wjEV7lNw9PvEn1tvHZ2+Yl2yABF4F849RBpKCGDv7jHTQYRaG9FzbRryTGf1?=
 =?us-ascii?Q?xYq0MLhfmxS5yrHV+Paa76XoUM92PrD8aCUTxfoCsOdocgq1CnwL82fpHX+l?=
 =?us-ascii?Q?kOAyrnP458F9BIdU3AXsDCoRU/gEzCTjw/XaJC7kRelrTjvDXdPcoo01vmJi?=
 =?us-ascii?Q?QIRrq+1M8UaJK+yYvNltLFMX6bLZaGWv6JbZn6/KWJ/fgWPlTdZIPgQ6owF9?=
 =?us-ascii?Q?A2DKqoNCYWap09xU+dY7nUMnlPBBzYBPlcppeJkKkcMJRYrenxJlljI8bRjt?=
 =?us-ascii?Q?EYf+SBKZ72HyuIpR0CTtODYfzFLvxQh2EGWmM4vh37GkZJvKlR0/ecp2Gnsp?=
 =?us-ascii?Q?hi+QmBysUVxcm9QmojVEnELJWb6Gei3UC0Fs0TnNBb46D7DWJD/VjXLLgXM5?=
 =?us-ascii?Q?2D6uT62yP86lY7ZIjS8Yza8xM42PW8YinsseWZhzXtXQdvR1ucg3vKRnQAr0?=
 =?us-ascii?Q?/TGaEH9wNIJbVXeXemJ/tpf9qtM2WlFnfLZDBl69HIqGDBJ2gQi5nOJyN0qO?=
 =?us-ascii?Q?FHOvnRR79XUmYdDfpymFt6HZ55SGVWhRIW3uQ0Jmn+Rj5s/BmnVOBQ1+raPR?=
 =?us-ascii?Q?Dq2okmzPH1iPignnj6ToymZ9uhJhr5yuS+wt9bCs1FGdl8PAXT0Ht2gVlIUv?=
 =?us-ascii?Q?SFRhHNlkP9WEm+J+0eJlMVI/de9G9az+GvMdtPhAKiT5g0uIC/dAfs22W700?=
 =?us-ascii?Q?g4oxDyZyk6xqScmbcXB9xGdg8iewvxKSyw1XoPciOCrS32DMGotg0/YvI4FL?=
 =?us-ascii?Q?N4OKTxEY819Nax4zboP5KnGvENKtIZTJQSBlA2N07eVY3sLwhBkkq01pj8IJ?=
 =?us-ascii?Q?4yQ52zpUsAhnE/WnhZpZNHxPHph5jfsLpH0/6Imi8eI6CZJAV7iOoIdgzpms?=
 =?us-ascii?Q?I2nInJuqsWLsxFxjuRg3+jtFWFIFJugYEldPbGs9ZjlWscjv57Vc7lw0PCQC?=
 =?us-ascii?Q?5lK/wB0yrzt1pcoaTsWVP/ZI8R8uicu7pVaiD6YDbIxdUOfP5pHwJd52O3p3?=
 =?us-ascii?Q?z7jUkYXdGVZJZJn71614dWfSz9F7uJ5pK0Oy2XCRXRcIXMezTYdwrCzEPV70?=
 =?us-ascii?Q?wCCBNmuxlp1vd5syz5DQDbvZ+SVUNmVGrWv9psPVXB3JEDDqiUs/tNJveX+e?=
 =?us-ascii?Q?B045zuqoDIt6Ae22y+gD0W2PLc5GMAj/9/BgCzlnLN1BjVuS2a3hgQsn6grs?=
 =?us-ascii?Q?aLXh5wALCvmrd5m3C/IscuRNAbsQ/gIYACvtH3t7XItLSr3U2mYm64pulf2M?=
 =?us-ascii?Q?WQS6fvgMPY7d14czaI/3SMLK4nS1yG81W1+jBWMHqg0QLdaDJ2mMk9kpgeR8?=
 =?us-ascii?Q?I9DkQXrNvk2QVmkMmDyCihM1X/CW5fqmj0ml6kYJKqgRiB9ygkLmKLpCnh8+?=
 =?us-ascii?Q?GF5WWMFI2HDJTzq1XUKaLtQf2KPs/EI9qME/A5NhIMAPOT2ZCMRdwGid8agw?=
 =?us-ascii?Q?3Ick9vF/kBfumot4lFupDeUZg39JAI8aPs4KI9lBgZoDJAg40xOEsFskjMBo?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144c7d68-ab44-44f6-d207-08dab163d740
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 23:52:39.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNQer5Z2oVz00IErQaI2WDcttrHGcSYB95pMx/yUrj+fN0QcND7H9ZAX59Esd60gKj47iWRVqJSZk5d5l9dnNqOOwkuehyRVDLPoA1wl3tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180134
X-Proofpoint-ORIG-GUID: dlf6eXRVCK9zYbTZjClNLkHt0CYnkUjP
X-Proofpoint-GUID: dlf6eXRVCK9zYbTZjClNLkHt0CYnkUjP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:
> On Tue, Oct 18, 2022 at 7:12 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> Hi Jan, Amir, Al,
>>
>> Here's my first shot at implementing what we discussed. I tested it using the
>> negative dentry creation tool I mentioned in my previous message, with a similar
>> workflow. Rather than having a bunch of threads accessing the directory to
>> create that "thundering herd" of CPUs in __fsnotify_update_child_dentry_flags, I
>> just started a lot of inotifywait tasks:
>>
>> 1. Create 100 million negative dentries in a dir
>> 2. Use trace-cmd to watch __fsnotify_update_child_dentry_flags:
>>    trace-cmd start -p function_graph -l __fsnotify_update_child_dentry_flags
>>    sudo cat /sys/kernel/debug/tracing/trace_pipe
>> 3. Run a lot of inotifywait tasks: for i in {1..10} inotifywait $dir & done
>>
>> With step #3, I see only one execution of __fsnotify_update_child_dentry_flags.
>> Once that completes, all the inotifywait tasks say "Watches established".
>> Similarly, once an access occurs in the directory, a single
>> __fsnotify_update_child_dentry_flags execution occurs, and all the tasks exit.
>> In short: it works great!
>>
>> However, while testing this, I've observed a dentry still in use warning during
>> unmount of rpc_pipefs on the "nfs" dentry during shutdown. NFS is of course in
>> use, and I assume that fsnotify must have been used to trigger this. The error
>> is not there on mainline without my patch so it's definitely caused by this
>> code. I'll continue debugging it but I wanted to share my first take on this so
>> you could take a look.
>>
>> [ 1595.197339] BUG: Dentry 000000005f5e7197{i=67,n=nfs}  still in use (2) [unmount of rpc_pipefs rpc_pipefs]
>>
>
> Hmm, the assumption we made about partial stability of d_subdirs
> under dir inode lock looks incorrect for rpc_pipefs.
> None of the functions that update the rpc_pipefs dcache take the parent
> inode lock.

That may be, but I'm confused how that would trigger this issue. If I'm
understanding correctly, this warning indicates a reference counting
bug.

If __fsnotify_update_child_dentry_flags() had gone to sleep and the list
were edited, then it seems like there could be only two possibilities
that could cause bugs:

1. The dentry we slept holding a reference to was removed from the list,
and maybe moved to a different one, or just removed. If that were the
case, we're quite unlucky, because we'll start looping indefinitely as
we'll never get back to the beginning of the list, or worse.

2. A dentry adjacent to the one we held a reference to was removed. In
that case, our dentry's d_child pointers should get rearranged, and when
we wake, we should see those updates and continue.

In neither of those cases do I understand where we could have done a
dget() unpaired with a dput(), which is what seemingly would trigger
this issue.

I'm probably wrong, but without understanding the mechanism behind the
error, I'm not sure how to approach it.

> The assumption looks incorrect for other pseudo fs as well.
>
> The other side of the coin is that we do not really need to worry
> about walking a huge list of pseudo fs children.
>
> The question is how to classify those pseudo fs and whether there
> are other cases like this that we missed.
>
> Perhaps having simple_dentry_operationsis a good enough
> clue, but perhaps it is not enough. I am not sure.
>
> It covers all the cases of pseudo fs that I know about, so you
> can certainly use this clue to avoid going to sleep in the
> update loop as a first approximation.

I would worry that it would become an exercise of whack-a-mole.
Allow/deny-listing certain filesystems for certain behavior seems scary.

> I can try to figure this out, but I prefer that Al will chime in to
> provide reliable answers to those questions.

I have a core dump from the warning (with panic_on_warn=1) and will see
if I can trace or otherwise identify the exact mechanism myself.

> Thanks,
> Amir.
>

Thanks for your detailed review of both the patches. I didn't get much
time today to update the patches and test them. Your feedback looks very
helpful though, and I'll hope to send out an updated revision tomorrow.

In the absolute worst case (and I don't want to concede defeat just
yet), keeping patch 1 without patch 2 (sleepable iteration) would still
be a major win, since it resolves the thundering herd problem which is
what compounds problem of the long lists. 

Thanks!
Stephen
