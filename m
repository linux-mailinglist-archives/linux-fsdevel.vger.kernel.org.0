Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9901601422
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJQRAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 13:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJQRAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:00:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E80630F70;
        Mon, 17 Oct 2022 10:00:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HF6tq4011744;
        Mon, 17 Oct 2022 17:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=9MqghJaxr9RQiICScyadbqyt9JKQ1jpfBMbFffGHexc=;
 b=YLIsGg44dQ/C6P+NRKx8kCDOr6MJSpyWlRp9bnFgupfkiufrIihmu1t+FRaVkZlEc2NJ
 sRII8oRbGaclg7YFAtdDfsQq7nLvbFznd3al1b987qMTb+wATWOdghHaILIVECodk2RY
 uGDcWjhVaDaNi0AJVPZz4qlsQ+mbWa4PBSXjdn2nGM/fuVCj3O8yExe0eZwjSALT8k85
 pifcJb/Ea293kwb7On1OQji8N8E+pbOCTj8L+9YtGhTBkqQmSeoS6AxOyDVSZRyId2eR
 kKBpLJnvCIFfrXivYhCA7KbLWfFdspQnxeUqMloP+JcfBw/6o240kKU5XTUikDKImfBF 7w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mtyvb5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 17:00:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HF5qlr017282;
        Mon, 17 Oct 2022 17:00:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu65u50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 17:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAvugyQBbfvhA8ljE94ODESOl8F30uYFJ4BoIpOFWXPHpNng1VdZgVeynetZE4o13nyWaIw91WYHBBUOSCnbgFqEI6mrfOxjVMZW7y0vOPBoXIFBFfmsMFWL94hr/qdrvidkouk+KLkzjRyxwg9hoqbQcCfrac1vCAIzT12Ir3gUityqsMuWohZUfnhsYVqO8xbvMwZ5F9lNQKiiUmC2uN8hhji+gc4+5P1dpwLnw0i/lKnPxxQ72Uac4aasN2c0CHHq2OeQXTkN/IhdW4Su3ND1xFrONXng6Kk7M/k8uYeQI7bV7G7bJLqnAaHw0oms46cugEBYhzVqkgbdiIQ2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MqghJaxr9RQiICScyadbqyt9JKQ1jpfBMbFffGHexc=;
 b=gvKkE6H0JoszZYnzdIPUP9iemVzSiocHvbWMwP95BdJbu2wvj6SDaI62YA5jy2bVoEizZQwvaxzP7knUWw7uYPzcuKRVHLAQKAG0Xi21sz6xWzdZ99lQm5n3YJuyqJQGnM++jHu7wvv3kGOAWEHAxLs8YsD+gH2SeNQVkQCLzSvdoi6yRHeWLWHfGdAQQtqN8ejnxxgBiLaZ3LsASzYZTmJIg9OrwXki8NyVg2Su64j3zjD8cEL/Ebtwp1bdH8l/PGffyUcERInXHpQUE+xD0HFIiwriHPcwBlUWK5qY3GYLhiVkzMFFDHAa/cNjZjafWKkiIRHxM+/ma4rHgZe4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MqghJaxr9RQiICScyadbqyt9JKQ1jpfBMbFffGHexc=;
 b=hgV8brXNvwbm2kqKI3fOmRr4T1bK6i5Qv2BDN+1TCD+C5y0aonYDiwlkVXyGGGQcBP89i0JEG61Q2YNMAmLAtH26ie94loql2kn1WNPTQnIgeQgmAhaM10L8QrZmBDmwek7v4th9WUZqMmXujHA4fOGeUcMXj8b0JouJskxaGHQ=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 16:59:58 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 16:59:57 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] fsnotify: allow sleepable child dentry flag update
In-Reply-To: <CAOQ4uxiamB8zfr=XTrnKA9BB4=B-DtwOim=xcYNc+vcW=WXv9Q@mail.gmail.com>
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <CAOQ4uxiXU72-cxbpqdv_5BC4VdjGx5V79zycfD3_tPSWixtT3w@mail.gmail.com>
 <87o7ua519v.fsf@oracle.com>
 <CAOQ4uxiamB8zfr=XTrnKA9BB4=B-DtwOim=xcYNc+vcW=WXv9Q@mail.gmail.com>
Date:   Mon, 17 Oct 2022 09:59:57 -0700
Message-ID: <87lepe4c8i.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0174.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::29) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbf1082-a40e-4ac4-bffc-08dab061056f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQVBgQo4lCjbjJoitLdcFaMVhbNZ6g+ro1tSxo+GTIAVnbIwDiybmoZq94ZDNU+7nu4/LpoP6z4386rC3xMSWbExhohonwbsYEE76pqKfr6c/67/vMy1w370BDxmC6BCAGwezsdALHaKjazAzsU2lf2jDdnXIQBl7+Buyu7qlkkBM8JIp8cRcS56XTlmQxBFLjQKUutj52rYdzYlI2hBYsdpHbfpMAP2zdPyvJE7khA7ETcbTAbyTCoFGkSsrp+MWDLjF4ag989d27ibvYvgh78y6ryIpKEj9Ss60tfrgip2MIlIW1+oxnLmDjc+W/qeYY4Nb8Gvw5L17YPUxwmt/M7MGnNixhERUirjjTqKEucpgIcqVFf1nToeaNf/RMLTk9BYPv6F9BgdF7YXgQllLzrkHJ38EEqLH2JC5ZNKin/TyQAFpKeKCKkmniARoF/rgiezEDUuvRknjW2RBV7gK2lYdTVGIA/+jP9gaeB7wW/64t6gamfvZeqgBRfhGmsJyVDIR5tQvnORb3qpSL8FLFzr8B/WSD1+9R0D/iKb0Z94NJiXNuKgHI4E6zcJGPlcp4OVdw4q9U9xqBN9hYAWPCtKmV4hiehK2hdGPMZJL36jG36AXwrwURmEy1gNwUj6/LQFKFFwNrugbDm87jeBf0rhm1KAc+OJlp7AshO6x9rYzbClcel6P5I75ztpX+Sh//Y0ZfNCNEz7ZmdXSpOHFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(6916009)(66899015)(8676002)(66476007)(54906003)(316002)(478600001)(66556008)(6506007)(4326008)(53546011)(41300700001)(6512007)(26005)(186003)(2906002)(6486002)(8936002)(2616005)(5660300002)(36756003)(83380400001)(38100700002)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rHeVIaQCZq9dcQbQKJa49tALKdY+tTUmYNQTLM8py0P0TlgRu5Zg869Wupjx?=
 =?us-ascii?Q?ckNh+41DOIA+1UGzx0mH7CqbkShZvdi1F2jfhr710ABK0EXkQ3uyuD0nw6jt?=
 =?us-ascii?Q?fOK3FnY3BSq/0bCpp6LcuD69S36kJekn8joFwmTFyNGnBJkfvz5CfEiJSWWw?=
 =?us-ascii?Q?1HY7xY7JKla92eota05URsbWZdW0VvDJ0vuklcB67r2fRe+fviDaCeKJy5ml?=
 =?us-ascii?Q?EEBAyspCamh678PYih0yjTqJNZwxBMs2xMaQSPlCL6pxwlV4dmU6q6m+hPYb?=
 =?us-ascii?Q?s2DgexjgB0eOm6cCZx3sBlzCtukS0891msI2mHm4gyXzroenbTzzuRKNHRKm?=
 =?us-ascii?Q?m60aiDLXr5tz+sXqUHFKGHu9kWmOoUhwmX+bYtzLSxbpTjLyKo7FZhbmm9yP?=
 =?us-ascii?Q?GrlSctxu180ziarRMh6lFgeEN+CWI6f5ICGM8ecJ3IWZEVvNJNL+9HzrukZi?=
 =?us-ascii?Q?65hCPEAMCMuPUuln5F1SQe7VUyxEfR6KZdu6XZNgxfbJ8+Gbl69YkU/QcdRx?=
 =?us-ascii?Q?/l1PeQJYIvOYA2WZ6Yl+QwSDn0RLIgLuNXwEL2K2yE/7Lt3Fy/MatOGhjIT2?=
 =?us-ascii?Q?9cBNMpD9WNpmBxQjXBMideJG/Dww9nldiPdhyyaihVrxajhOT9hFE+CeYys9?=
 =?us-ascii?Q?2oCmj46ohGfUMy8dk8c1JfMqwEAmTPFkYQ/OM1mQP9AMz+dBuplhQ0tqwbQe?=
 =?us-ascii?Q?fs5027huwjH724Lark+5qH9uJkYxragusM+Wx/lrEYIgyRT/K13cfZUisC1r?=
 =?us-ascii?Q?X0qiipFpdkJS5Ux9cy5/W/u9bbT2rNTrQN2c40zxrSrwSWHbu7oMbqBB6JtD?=
 =?us-ascii?Q?x/yM0vALTaGdkNe95xq+yoyqqZ0dKUDhWHG1bLIyYBy7T7kghi45x987yya3?=
 =?us-ascii?Q?3UNOeJny7RZhHhbSPr6d7NOYlVcoecGqvwXXr60uDKaZ/otXDbwYZ+u7G89w?=
 =?us-ascii?Q?47+0+N8zjoaHqQMhZDkMsQUajnXia2C4UVmNrSy04lohha2DVOEPYmCl5bSw?=
 =?us-ascii?Q?7ZSL0VTD8ZdpEGaICq8XZoGSd1TJ1NQRe6/D1GBrkiG+bdaKJ42nLkTZRflV?=
 =?us-ascii?Q?0n4OGnyeqKDYdOq/MSa1lfjK9vqMvQK6R4DfnNgHKHFLUbGmEBJEUjYRbcte?=
 =?us-ascii?Q?FpwDA4SWmZ6RP0rrDV72ij8R6aWPsqiFXCJAz6rBFBePIcAHxFt8kqUJS5M8?=
 =?us-ascii?Q?FpnztnHxVRrTSjIVUtwGMxFkrCAvzdhjYVuDkoEgTyugqLcJ2tG4aNQtn/NP?=
 =?us-ascii?Q?IZJxV34gc1X8GqdjBUKMLh5N7LvSHpJOr6cKgJEN0XnxjYHG3rhLVEJqRjsB?=
 =?us-ascii?Q?EqZz0OwdeRaaGfNYIGnkyj2RtdaoKSXnoTSOMiU1JnhAlHOMZs3h18+mJURF?=
 =?us-ascii?Q?rYo189BBqWCUrCNKYQXKygeTxyDQuT/bn5x64cD2e7fyas+kh4x5LGPxTK2W?=
 =?us-ascii?Q?MPQo/WVWNCbs6P7LRfeMJP6ymalVh63uqJ/mhSS/K7tvXe2IKWuqZnek2CRn?=
 =?us-ascii?Q?jzdVBPCdICfgCHARzmjnNLCO4Lc41rx5IXQCF7lPATCySaC00M5WsrNSHOa7?=
 =?us-ascii?Q?DFdiyhIe4HaOlecltBAsZ3N021/QMOmh5k8UONTho3B6cof66QDPaEgV9Lun?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbf1082-a40e-4ac4-bffc-08dab061056f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 16:59:57.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxT8XiK++SxO/kJ0tiQ8CNSI4Bl2RmSEomHzuXssRBw9GqO1FVv3ZyCVs2E6Hux+EIIZrT6j7tnt5gOfje/XjQp4CruuXfjFWD21oNqH+gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=965 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170099
X-Proofpoint-ORIG-GUID: 01_s7WFODKR6fchXQmQfEoX4l05z3rzB
X-Proofpoint-GUID: 01_s7WFODKR6fchXQmQfEoX4l05z3rzB
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

> On Mon, Oct 17, 2022 at 10:59 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> Amir Goldstein <amir73il@gmail.com> writes:
[snip]
>> > I think that d_find_any_alias() should be used to obtain
>> > the alias with elevated refcount instead of the awkward
>> > d_u.d_alias iteration loop.
>>
>> D'oh! Much better idea :)
>> Do you think the BUG_ON would still be worthwhile?
>>
>
> Which BUG_ON()?
> In general no, if there are ever more multiple aliases for
> a directory inode, updating dentry flags would be the last
> of our problems.

Sorry, I meant the one in my patch which asserts that the dentry is the
only alias for that inode. I suppose you're right about having bigger
problems in that case -- but the existing code "handles" it by iterating
over the alias list.

>
>> > In the context of __fsnotify_parent(), I think the optimization
>> > should stick with updating the flags for the specific child dentry
>> > that had the false positive parent_watched indication,
>> > leaving the rest of
>>
>> > WOULD that address the performance issues of your workload?
>>
>> I think synchronizing the __fsnotify_update_child_dentry_flags() with a
>> mutex and getting rid of the call from __fsnotify_parent() would go a
>> *huge* way (maybe 80%?) towards resolving the performance issues we've
>> seen. To be clear, I'm representing not one single workload, but a few
>> different customer workloads which center around this area.
>>
>> There are some extreme cases I've seen, where the dentry list is so
>> huge, that even iterating over it once with the parent dentry spinlock
>> held is enough to trigger softlockups - no need for several calls to
>> __fsnotify_update_child_dentry_flags() queueing up as described in the
>> original mail. So ideally, I'd love to try make *something* work with
>> the cursor idea as well. But I think the two ideas can be separated
>> easily, and I can discuss with Al further about if cursors can be
>> salvaged at all.
>>
>
> Assuming that you take the dir inode_lock() in
> __fsnotify_update_child_dentry_flags(), then I *think* that children
> dentries cannot be added to dcache and children dentries cannot
> turn from positive to negative and vice versa.
>
> Probably the only thing that can change d_subdirs is children dentries
> being evicted from dcache(?), so I *think* that once in N children
> if you can dget(child), drop alias->d_lock, cond_resched(),
> and then continue d_subdirs iteration from child->d_child.

This sounds like an excellent idea. I can't think of anything which
would remove a dentry from d_subdirs without the inode lock held.
Cursors wouldn't move without the lock held in read mode. Temporary
dentries from d_alloc_parallel are similar - they need the inode locked
shared in order to be removed from the parent list.

I'll try implementing it (along with the fsnotify changes we've
discussed in this thread). I'll add a BUG_ON after we wake up from
COND_RESCHED() to guarantee that the parent is the same dentry as
expected - just in case the assumption is wrong.

Al - if you've read this far :) - does this approach sound reasonable,
compared to the cursor? I'll send out some concrete patches as soon as
I've implemented and done a few tests on them.

Thanks,
Stephen
