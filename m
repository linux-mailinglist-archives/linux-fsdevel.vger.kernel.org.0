Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA5600834
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 09:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJQH7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJQH7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:59:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5E85B511;
        Mon, 17 Oct 2022 00:59:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29H748Qw001152;
        Mon, 17 Oct 2022 07:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=tORPG7RalQHr9WqlhxDfTCBCbE2+/H9pbPKLXR8wW34=;
 b=JB4jrsIPdKHO7X5PuX88FisL72Wc9qQlr4tZOqYbjPp5WAVfPcv3ncAQscpWnQZa7EgR
 c6xfP/WbpjnIqfKiyx0Vsf+Uv/RtJChHdieLE3BFIZpp/ayJGlkU4j+QsgvTBwOlstJj
 s/LTQiWPzrGTl24iXGxyIDsxo85C9WuriqoY3/z0k9RrwoV5htK/m28TfPeZXIFmoSdf
 Em46TulKcY70lH4av55MIPWURYUfbTWTD/A0CU0VKKYuvw/6HVjN+U9R36B3z7XGPdal
 lKHu/0Uji0Yli0rJ63M7BQt+2Cc5nsN1P3MURzHQeBray8rCWrv2Dh+4H7swkEjoWsEi 6Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k91ra07k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 07:59:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29H4hq1H001192;
        Mon, 17 Oct 2022 07:59:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hqx09c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 07:59:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHl9t5p9i80hBx+Wp5z3DHFS7i1Keb2K0EK386wblQV7gdPgKTR0o9UwD8S79cjCF6OtcF7pEHCxAMPaKO/AwY4+MDKcgOI2HCU/vYXhh/P1Ohzq3B6RXBHxZ/ioBxLK7J+x9WrDUGX9DtVx9z7gsOnHfN+kn/tVxoTrX2yQogk7C06xXivBFhrsITgJPwClD0JXi5o6Bzq+71ElGV8beZxvG0EqmsTERqunvdJfEUvJloliPDbECw+YTPNWNF6d0IgvXgXqbZB2w6lqyLv3htshA8bHh54yz/VuSDxuVYnUnyvAI4I0k90UoT6No1q93sSlZ17HAtbipCFFEAFpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tORPG7RalQHr9WqlhxDfTCBCbE2+/H9pbPKLXR8wW34=;
 b=eBWEvvYztzYd80iegAEikv8lh8IohgEhW+i2HTfBQPSa4MykdNH4H0cHfhWK1TnivsUInWB+DC2LHRor3rcnhOeBKX2mm6z+7ZGq8row7VEiocsOla539zHbWQMet5Bn6LkrVTdq4wYCrG2hs/Fq4lPuBzHu9sbvjTmwdi7893/YI7gi5Bob++Vsk/Ik57scqKm01eyGsTGFczt22UOVq2ne2V+8Le4KN7ce/bHNoILBhiwX3JFfjl5MDvBCv3IRjRIwLMGG2Y0sNUeceAim8Zffi642kiB3/LVvqrqT8BCXhEwTHPEa0F/i4orAAtj96W2eiGOIMJSKJw6iiZIB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tORPG7RalQHr9WqlhxDfTCBCbE2+/H9pbPKLXR8wW34=;
 b=JGIR0b2P9WntzkwzKJj29S+QvPxzfHXu/jKOS6GT/FgufqWW4yVuQfOJnDCqp/794RRMKt2qcogJDXAcOGmOk/QkpFS9t7MRxg880CYaQbN38dcNy9Z0r3O2pmaFmYmoaugBsysiE7WHRT3y/btYR0xzMMPBzvS0S3f6xLe574k=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5244.namprd10.prod.outlook.com (2603:10b6:610:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 07:59:09 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 07:59:09 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] fsnotify: allow sleepable child dentry flag update
In-Reply-To: <CAOQ4uxiXU72-cxbpqdv_5BC4VdjGx5V79zycfD3_tPSWixtT3w@mail.gmail.com>
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <CAOQ4uxiXU72-cxbpqdv_5BC4VdjGx5V79zycfD3_tPSWixtT3w@mail.gmail.com>
Date:   Mon, 17 Oct 2022 00:59:08 -0700
Message-ID: <87o7ua519v.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:806:22::30) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: ef443d6c-3136-446b-29ba-08dab015786d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KudZsxeTf+r/n7Dyk4t7N3yVib4KQyCgbSw6ZdYLpm9c5Pw9/0lQIa+gTMLVnlaUTjOe69EXPEddZCHVRZ9VAx9DKzXRobsSB8MBnm4GTFecppjIj2vbZDFZtxxoXmkyvJvLrdBK7Rk687WrmtGvrdkBlJpbs00t4fW18398BvmFeowhQl2l+hZfkMa1w83GqmdbvpDzJIFr1cDp/zEtV3x73aA99bWiucXJFkMw8MDco6UyrFxk1Y6v0OSVgFgfxAD9PnTJsctQnEcV+DtCH23mlTXXpobjeuFLC5/7WoWy+3UB0zuEet/Ii0ZmWFz6TbtzHRnfPIIRGi8UmW+IeZwZxqEXusPSh42IN7OH2s41D3Z17tI4AUortD/Sb4FLRnudIQNX9htoLq2XRiv59b+a7UdGZYgvVk7B+/LmAGIeVxMFtr9kwpsy3t+PIfqQGCPLbtwXyrR10058bbi1YsHZutDAtW4a3AKu44y6l7hd6EkFXRs+C9qYjzlI1MRVeiaoCp1OodGkPvt2p1kQbxXjrNafAzZZORIAwUUOpq0b5M/UbmUUL1LOeQNE+ZTh9WhlJzW2hk9TPrBZ0Mkqn61PzFHTaQf4dDO35MwmuAAaroFRTMfpsBARDkTYpej43UqZIiLkhu3ioNA0x6ozvC4VEdmHnWWCaI3kFR6F0uktB+YSjQ5u3FSgzd6XJwdr5W510vvyKhHXLdy1kdmvyqrPwLJr3IRbNy/prnHK+JU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(966005)(6486002)(478600001)(66899015)(38100700002)(54906003)(8936002)(6512007)(83380400001)(316002)(6916009)(41300700001)(53546011)(6506007)(36756003)(4326008)(2906002)(186003)(2616005)(15650500001)(26005)(66476007)(66556008)(66946007)(86362001)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wo87uWoO3rx/sGhccsh3IoCZcV0VNu4UuIIGrNNTpX1mnd3oPLqliM1IYKnu?=
 =?us-ascii?Q?Q0gIsAS7i4m/lJZeIbwr220JxVZKIKbn+ZKOBvSO1892CIlBJ80BNw98hdIy?=
 =?us-ascii?Q?/8unY29DmUiC4aqafOt3o6EytxIeJWGdePtH3q5r89udlQMGghpRaFyjxuJO?=
 =?us-ascii?Q?RHy2OwK/Sdthqw/3FsknIQIRvHBh/o/2Lqrc479q7sd00PH4puU4poqgG2I0?=
 =?us-ascii?Q?AUMSwO42Na55o0rUv3mZ+DsnI8cW5fKpGrRjwX0K7OYmkBC2SmqkIJqW7lQ8?=
 =?us-ascii?Q?dPHnbSL7kACHXIBzo/vClI7eZiMPgjk+j4fTuVcdfLxktDVF8c8TR4khCNhF?=
 =?us-ascii?Q?V2Sy9VdVsTyJlThHbhl8y5IcwuxZtXXAMz6vHbkR0L2KrJ4vroMBLWWa8Ye7?=
 =?us-ascii?Q?PzsjJ53DHsum3rHA4oelB6MJuE6+dHVl2lxC7jTDCRjIO6kRwBEGvMygWGUB?=
 =?us-ascii?Q?7EguyujgOdJwnyp0jLnn3PEw+UeQYyF0/f/eyFtSoT3LavcXFdBuK18G+hxe?=
 =?us-ascii?Q?+6eYFzHoTbVjjEJLJbqfuwS+yUqSywKTjd0BpO1pTMiMkX4lUeZ2D+D1d4vy?=
 =?us-ascii?Q?TG/onJHaNh7Rpp/iS2SA//OHgfU8zzawOytBTV1aLoRfUuvnYYubTbVaGJe4?=
 =?us-ascii?Q?f+BqbAM6XSnb3CeWPDzJvgTJXQ060Vk52YtB5vzV7fl64vFJtJJrSogv+3vT?=
 =?us-ascii?Q?3d65sx3fpW5HLANAP+dccaQCCDTQlPKKTT8Zl4pxwnz+vLbjFyNKm4sdY+9E?=
 =?us-ascii?Q?RNBBIQEZmz9lPQGOoc6MPIBjhRuZZZ9xabuw3fsdK8s1dcwA8plcFlQisbGd?=
 =?us-ascii?Q?piEKAWsvkwSg1GjI2GxcO9HVw3uney0oHBGBOuVJfb/JHbDYMfQOAsOBHwtM?=
 =?us-ascii?Q?VaF9VhM2Kw5pKNJtq4705ZAV3ZdRjya7AizXtp6eHFqWqfMXOtcKHxVOUrZC?=
 =?us-ascii?Q?MHyIZ4aUMqbV0WtdGzLDTIB6uGxotL3MFKDrgIAkfJI6O3YQpLVzG5BtMSFc?=
 =?us-ascii?Q?x42GPsr/vVGhaEWg35GfYHYXuFDadsvNpBcET13MnUWejUlw6kwjHvYWYhLH?=
 =?us-ascii?Q?ixbZiquollqheTPaDHILeGKDTe7JSPntqXLaiN35gn5Cd1V0g+wlo8NsbeMJ?=
 =?us-ascii?Q?JP6H5TO49rJfyN/et0gfE+mHtwBoqBvEoome2enHtedIyUzgnlwbLFewgcZl?=
 =?us-ascii?Q?6x7Zclk13Ca1TzfuRL6sWodKCyJosww7LkfAsBPa0mHqz9Ntr3kqjZ1aosOv?=
 =?us-ascii?Q?0AN1a3qssK3dLtJ/0/Ib1xKxwXtvWr46HZ7qEBsf9+TVFo1s+W3ZHQZz1RWw?=
 =?us-ascii?Q?seoCCDfPVhHY5qaGJSbE7KTkRG2qIYYD0TJf7kNOPaVYZYireSzHRTXwiZA5?=
 =?us-ascii?Q?V420JuBIsyjGHb3FNWSzESeOGWIF0EthIhgjOkvYUOzTbH32rwGmj84VUgl7?=
 =?us-ascii?Q?NscHMxxIil1+DqVHcUfArEG/WEnfxg0X5S6WfJGV1YKaE7T64vENUJx7Flij?=
 =?us-ascii?Q?pzjTXFSdnhVGAr6AkxUnx+xu+LmqQaTwrE0CJDltB4hCE78zG3ITfGeqSiCf?=
 =?us-ascii?Q?MYCXGH2CU6Qx5ukP02ouzGivgPjf+eqbumjMsFNlX2UiLZTlHb857KuNAX5P?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef443d6c-3136-446b-29ba-08dab015786d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 07:59:08.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/FUxhAR3lXkba1s20xCAKs+IN2gLW7OIh3a0Nm1IhZedNt/2Gv1sEC0ZazfpzhpCjP313Gp+wer4Mr+jZtCJ9+cxAhgDSM14JHFemU8wHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_06,2022-10-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170046
X-Proofpoint-GUID: n-LD9QiozmJ7X1kWsnvfSsi6Dr8ar-Ws
X-Proofpoint-ORIG-GUID: n-LD9QiozmJ7X1kWsnvfSsi6Dr8ar-Ws
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
> On Fri, Oct 14, 2022 at 1:27 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> Hi Jan, Amir, Al - this is a quite ugly patch but I want to discuss the idea
>> behind it, to see whether we can find something workable. I apologize for the
>> length of text here, but I think it's necessary to give full context and ideas.
>>
>
> Hi Stephen!
>
>> For background, on machines with lots of memory and weird workloads,
>> __fsnotify_update_child_dentry_flags() has been a real thorn in our side. It
>> grabs a couple spinlocks and iterates over the whole d_subdirs list. If that
>> list is long, this can take a while. The list can be long due to lots of
>> negative dentries (which can easily number in the hundreds of millions if you
>> have a process that's relatively frequently looking up nonexisting files). But
>> the list can also be long due to *positive* dentries. I've seen directories with
>> ~7 million positive dentry children falling victim to this function before (XFS
>> allows lots of files per dir)! Positive dentries take longer to process in this
>> function (since they're actually locked and written to), so you don't need as
>> many for them to be a problem.
>>
>> Anyway, if you have a huge d_subdirs list, then you can have problems with soft
>> lockups. From my measurements with ftrace, 100 million negative dentries means
>> that the function takes about 6 seconds to complete (varies wildly by CPU and
>> kernel config/version). That's bad, but it can get *much worse*. Imagine that
>> there are many frequently accessed files in such a directory, and you have an
>> inotify watch. As soon as that watch is removed, the last fsnotify connector
>> goes away, and i_fsnotify_mask becomes 0. System calls accessing dentries still
>> see DCACHE_FSNOTIFY_PARENT_WATCHED, so they fall into __fsnotify_parent and will
>> try to update the dentry flags. In my experience, a thundering herd of CPUs race
>> to __fsnotify_update_child_dentry_flags(). The winner begins updating and the
>> rest spin waiting for the parent inode's i_lock. Many CPUs make it to that
>> point, and they *all* will proceed to iterate through d_subdirs, regardless of
>> how long the list is, even though only the first CPU needed to do it. So now
>> your 6 second spin gets multiplied by 5-10. And since the directory is
>> frequently accessed, all the dget/dputs from other CPUs will all spin for this
>> long time. This amounts to a nearly unusable system.
>>
>> Previously I've tried to generally limit or manage the number of negative
>> dentries in the dcache, which as a general problem is very difficult to get
>> concensus on. I've also tried the patches to reorder dentries in d_subdirs so
>> negative dentries are at the end, which has some difficult issues interacting
>> with d_walk. Neither of those ideas would help for a directory full of positive
>> dentries either.
>>
>> So I have two more narrowly scoped strategies to improve the situation. Both are
>> included in the hacky, awful patch below.
>>
>> First, is to let __fsnotify_update_child_dentry_flags() sleep. This means nobody
>> is holding the spinlock for several seconds at a time. We can actually achieve
>> this via a cursor, the same way that simple_readdir() is implemented. I think
>> this might require moving the declaration of d_alloc_cursor() and maybe
>> exporting it. I had to #include fs/internal.h which is not ok.
>>
>> On its own, that actually makes problems worse, because it allows several tasks
>> to update at the same time, and they're constantly locking/unlocking, which
>> makes contention worse.
>>
>> So second is to add an inode flag saying that
>> __fsnotify_update_child_dentry_flags() is already in progress. This prevents
>> concurrent execution, and it allows the caller to skip updating since they know
>> it's being handled, so it eliminates the thundering herd problem.
>>
>> The patch works great! It eliminates the chances of soft lockups and makes the
>> system responsive under those weird loads. But now, I know I've added a new
>> issue. Updating dentry flags is no longer atomic, and we've lost the guarantee
>
> Just between us ;) the update of the inode event mask is not atomic anyway,
> because the test for 'parent_watched' and fsnotify_inode_watches_children()
> in __fsnotify_parent() are done without any memory access synchronization.
>
> IOW, the only guarantee for users is that *sometime* after adding events
> to a mark mask, events will start being delivered and *sometime* after
> removing events from a mark mask, events will stop being delivered.
> Some events may have implicit memory barriers that make event delivery
> more deterministic, but others may not.

I did wonder about whether it was truly atomic even without the
sleeping... the sleeping just makes matters much worse. But without the
sleeping, I feel like it wouldn't take much memory synchronization.
The dentry flags modification is protected by a spinlock, I assume we
would just need a memory barrier to pair with the unlock?

(But then again, I really need to read and then reread the memory model
document, and think about it when it's not late for me.)

> This may not be considered an issue for asynchronous events, but actually,
> for permission events, I would like to fix that.
> To understand my motivations you can look at:
> https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#Evicting_file_content

I'll take a deeper look in (my) morning! It definitely helps for me to
better understand use cases since I really don't know much beyond
inotify.

>> that after fsnotify_recalc_mask(), child dentries are all flagged when
>> necessary. It's possible that after __fsnotify_update_child_dentry_flags() will
>> skip executing since it sees it's already happening, and inotify_add_watch()
>> would return without the watch being fully ready.
>>
>> I think the approach can still be salvaged, we just need a way to resolve this.
>> EG a wait queue or mutex in the connector would allow us to preserve the
>> guarantee that the child dentries are flagged when necessary. But I know that's
>> a big addition, so I wanted to get some feedback from you as the maintainers. Is
>> the strategy here stupid? Am I missing an easier option?
>
> I think you may be missing an easier option.
>
> The call to __fsnotify_update_child_dentry_flags() in
> __fsnotify_parent() is a very aggressive optimization
> and I think it may be an overkill, and a footgun, according
> to your analysis.

Agreed!

> If only called from the context of fsnotify_recalc_mask()
> (i.e. update mark mask), __fsnotify_update_child_dentry_flags()
> can take the dir inode_lock() to synchronize.
>
> I don't think that the dir inode spin lock needs to be held
> at all during children iteration.

Definitely a sleeping lock is better than the spin lock. And if we did
something like that, it would be worth keeping a little bit of state in
the connector to keep track of whether the dentry flags are set or not.
This way, if several marks are added in a row, you don't repeatedly
iterate over the children to do the same operation over and over again.

No matter what, we have to hold the parent dentry's spinlock, and that's
expensive. So if we can make the update happen only when it would
actually enable or disable the flags, that's worth a few bits of state.

> I think that d_find_any_alias() should be used to obtain
> the alias with elevated refcount instead of the awkward
> d_u.d_alias iteration loop.

D'oh! Much better idea :)
Do you think the BUG_ON would still be worthwhile?

> In the context of __fsnotify_parent(), I think the optimization
> should stick with updating the flags for the specific child dentry
> that had the false positive parent_watched indication,
> leaving the rest of 

> WOULD that address the performance issues of your workload?

I think synchronizing the __fsnotify_update_child_dentry_flags() with a
mutex and getting rid of the call from __fsnotify_parent() would go a
*huge* way (maybe 80%?) towards resolving the performance issues we've
seen. To be clear, I'm representing not one single workload, but a few
different customer workloads which center around this area.

There are some extreme cases I've seen, where the dentry list is so
huge, that even iterating over it once with the parent dentry spinlock
held is enough to trigger softlockups - no need for several calls to
__fsnotify_update_child_dentry_flags() queueing up as described in the
original mail. So ideally, I'd love to try make *something* work with
the cursor idea as well. But I think the two ideas can be separated
easily, and I can discuss with Al further about if cursors can be
salvaged at all.

Thanks so much for the detailed look at this!
Stephen
