Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3DC615377
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 21:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiKAUtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 16:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKAUtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:49:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA00193CF;
        Tue,  1 Nov 2022 13:49:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KUGWN023221;
        Tue, 1 Nov 2022 20:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=wA2t33b67GpQFCyeQzMDpX8ndmeSmFo7RE6G2oQ2poI=;
 b=DB8hociRt8WqkM7up6H62NsFg2cP156zZAv7NWHLIKiM7IzBdHpjlTGdqnG/NzAiJyIp
 MS+6pYCNhjA76v89R+m+lKeRFghBgag9Y5jfkZLgCWZU9yncPg9F3lHKdL/tx+iyFAJg
 eoTIfAsnxTWuo4w/yktv25dkzzB+fqD0Oa7Gyj0GatTqDGIcSaRm5fpXqwtQsW4OoF0x
 lOQuqlFqBc/Wr12JNpxcio/GYThRrS7W6v8JvvXBARjwsEvZnTyWz9rzfzblyNBFeFZR
 mgVic31H+QwOVQW+mr+ZFyh3LAEsIA+Znj0RLq8LsJjwY1KjpI0BQQ4uFgARFlkuZvP9 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2afqwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 20:49:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KdRmD003001;
        Tue, 1 Nov 2022 20:48:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4v7s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 20:48:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMxhfCIHNJCo+drjFZl2znRNzhWwB2oR8WVzZ0xoZ5IYv47JyZ73iWFcixWYVdrH4zFTyb4k9Yfbd/s9imc5rbVi/WsnWmuJHB4XGDp+FOgO7UmDZ2gCQVImY/A5/zT+9TVV0ZsGr9BTDKTwFzbHUNqP+fmltKuyjroBTywwaGO4cndAcrHwvFWxOi+GEHHrv+Vtnay5BG2b7LDmODH7bb3bnovWrm5pl5RbQtUDIGeEiSFJ4Ip7ev4ARDwsLFxSqbUBqo2GHRI7qnIBAidnrVYzi/wP0fht+fEhiancTW04xzc0y+qHCvm+6X/Re9uoZHMqhyDvPOj3R5ABf3JLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA2t33b67GpQFCyeQzMDpX8ndmeSmFo7RE6G2oQ2poI=;
 b=cOuCeScxBpbHtgGKLFC5abc5op7zaWOVkN+FKYr0/gcp2DFZY5N4v3zSwvVlaxft5Yk55mcdqJjkmZuNAFGqWDU1My2VlQWFN2HWNXu6/a8tL3eyer7FtJ51JR7mSslsROeGit10KT0sHwViM0SzlLza6dUG3XcFZ/XwAFGJomMeM5NxGQHv0E3VznKgSakfMC36zmTyjcF918qWG8cFuE4P5T3imKJXnLRUmiecf//BkiFtM7J6G24PK0C4jYpt/dUmPiVEd7OH2nM2crZoLIJBvILZ9MXll2Oupwb8obG5JIWaf6cOqoTl6b8vomGW/L0bMQ5IxlYXvtpqDoe5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA2t33b67GpQFCyeQzMDpX8ndmeSmFo7RE6G2oQ2poI=;
 b=z7Jh14YYzsYR+QY3ITh96GLtSB+Rrb4NSe3Qvz5K0J19xuCxaaSA3IkauvLgUud7vLK0fZL9CRAqtpzvsTD01XPq3XL1iMYPoRErARKp3rxrGjhkq72o4E9mXQYt3gcNNL8ElQky7YAXKwv9vrJoK+Q+V/gsR6OqF5kzOGurMXU=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by IA1PR10MB6687.namprd10.prod.outlook.com (2603:10b6:208:419::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 20:48:56 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 20:48:56 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 0/3] fsnotify: fix softlockups iterating over d_subdirs
In-Reply-To: <20221101175144.yu3l5qo5gfwfpatt@quack3>
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221101175144.yu3l5qo5gfwfpatt@quack3>
Date:   Tue, 01 Nov 2022 13:48:54 -0700
Message-ID: <877d0eh03t.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:806:6e::15) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|IA1PR10MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 52cc1fc0-8de2-42f4-42a8-08dabc4a7ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utVv247KKSKpFnIaPVlnGCxSMQX8L/akvkD2aMuuIzv8Id3skaBq7slK0DTOeoFEj92hpK3gSdFOKaP5CYQZPq3WjKm/56DAaHV973oZP4N2xtWE7lKw0WBs2BTQyGwXlIPor820eT/NKsTk5SQqyNXp9ePASfyh6ojiaeGbARtBDKgl9gT/Qoe5YbLdXmlnBvutbGniw49x4eI/nKse7KlOchV6Ap9RGlYn0YJWFhoCjNcS1tB39QlFEkwIjRrBSke6pEoK8DjK6eHpEUk+Z5Qq+RwXsWIwrf42Jmblb/Ebc21PrlGfA1Dxx/Y+s1aqq3Hx0dkIHSMb1+wB4S6iRGI+MNEOBGAadKfaiU9BSfDSdm2L3k6Ts8SQJHbGkXxay8hDJ+BnEbBPJ4tHwnREiU7UTwmA1vjIihEztQrug7DMG2nZc+yRng8ibOT6uE1S4MM1CTN4/W/VL3+nwHb7zNkSWVKn8V69KhAK7hYK/1sbfqpPasHQx5uANna3TvhcqNUW8ObLarGUsb0Ut0UIyq+ZORqveu4k/W+43ZDO1gT3oodxt18o42nq9QCa7xy57XjjP9mhLP8zd7S2/IIVppGQQBctTX7glLs44X+3iiDVWJAH2O2gM8OXgeLgTg7tBJ8jhVHZTM+czIVDBbbk0FhIUVoqIXSsM+vRI0AQ1hW/CZHkRO0C+ZZPpvJwKBscoqWb1TBVgoZcFNe8Ejckng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(38100700002)(186003)(83380400001)(2906002)(2616005)(36756003)(66946007)(8676002)(5660300002)(66476007)(4326008)(6486002)(66556008)(54906003)(86362001)(26005)(316002)(6916009)(8936002)(6506007)(478600001)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QR93s5mkCF7ktzvUuKc3BNQ2M2BJjHiDmfLAi4s62YOuPcFt2eCJ/N3lnwuF?=
 =?us-ascii?Q?OXvAS2WwgXFCqB5LAMUqUKht7qEbjDLJzUiK5mzxW48/MNapS2r+lt/Q3gDK?=
 =?us-ascii?Q?nxH+DoaTRZmnbHzrCfVVs8Jk0a3hdDdOaYWbMiUokmT9n58coKKt6I1C7ApD?=
 =?us-ascii?Q?uz+aiCk+uIZCoCvPv2NBokTrP3CMhy984kWyXlqcofkho5uPszXXYjWsQqCV?=
 =?us-ascii?Q?Q2etnTW9cNE+7qZWPCQWedR/cO/XcMSOEqU8kdew7wUBxONktZvrOmUxQiMJ?=
 =?us-ascii?Q?tyVKRPmnH/BMI/TSWzCLEnIYYjsQV9XI5ltOboWgdSrBCJCTy9AWwycTJUWA?=
 =?us-ascii?Q?C8+8QkhwXooqVKzlEhkzIDIL+A6eKVHWvEAZaUSlHF7F8rFIBwojYs58eKfu?=
 =?us-ascii?Q?iQoCvcxLjHwTk5BeGM/BJeWBav++/+oEJ0fygo+Nc57J5r3ojh65JXmcbevb?=
 =?us-ascii?Q?cxEFehyqhLPi506BEm7zHf+K1Wg9+vOvGjEtLaE/NPyVMHSYirGH/6jnebHA?=
 =?us-ascii?Q?MctMyz8PPG1Z1dBBdpYDgakxGL4C//PiTH+wfQHQo6Xxrh/cDHrMsN5K80ba?=
 =?us-ascii?Q?gJtnX9uwsBRlDu2G+Lb9GbkEZGNHRjnrbghAi6PaG26A8iV/qu2fkn5+867w?=
 =?us-ascii?Q?RmUub0FovhjcDRD9IaSUP/WmkA/9axd0mna5Ud6i6Nq7YDac2qDmjMpXTQyj?=
 =?us-ascii?Q?INQocwn3dOPeWfkV8xOuT+oEnwCD+K7j4F9MSkvUvkysjRT8BKait+QaXnSd?=
 =?us-ascii?Q?dLP8LA5gepM0Ch4VgQN987zdBmOFqieuiwYFTcG/PiIigvw1ULdOskEN0Tih?=
 =?us-ascii?Q?Qf6h/4fcQ6Cjld+2usyRNvYDgZDhttefrzbEBR/7GkUyh/de9Tmv8a+MNoS2?=
 =?us-ascii?Q?zvqpDSGtWqPNUOabs7HcrCgEk4W1PAjpX+hsP8WYUmwSmDhc9uDZjsog33H3?=
 =?us-ascii?Q?yKZ8VK4S/yE0kNyHg8DyfKl4JYRYH1reeO//H69XBtdKXORyJFnSIuXmd8G6?=
 =?us-ascii?Q?3vEDVveuzeIq+T7dXOgNQ54GuZogoAnS9lg1Kp5gW1w1aWvEKQvOOMQKAnwL?=
 =?us-ascii?Q?ljfG1cuRvAN48Qw/pxL5CQUjf6fEweoJJP3D2xMM7mWtevwCTLPO/RPGs3t2?=
 =?us-ascii?Q?6Vnxoz9Wbx6okF0BvEmgbzQV4peEFqqpM73y6JqqDHDVdBKm+ZkJWrJvsSZ8?=
 =?us-ascii?Q?/U69yImPCNU3lp/D6lAR9SlwoakD2Kn68SiuslgwHqgah5ZprSDTkm5LGfsT?=
 =?us-ascii?Q?B6BgoJTcvAv0mxqF8IoS5rkLonI21kykEa/YNF7MQKpUxHRzWaOs67hJFat7?=
 =?us-ascii?Q?0xBMECy3+ZWreVO0BY/+eW2rNYb3w45+RnnL3x+KN545zEFdcrDDRnl1VuPN?=
 =?us-ascii?Q?9vRifeiSya79F8UsITmQ6HjZdXLMald+1o+RsI4WkXcrA4SL3HgwfMmijH7l?=
 =?us-ascii?Q?vl8ZEkSuaDYsjA33V7wrbgrXPSXM8SCTyaLBVre5bCYL05Zdr9L3JXqgph5T?=
 =?us-ascii?Q?DNPH+6qC6c9ngfPnkU5WeSHy2e5YKcTP08eHH04IgeGieNHkit+rX8QGeLrS?=
 =?us-ascii?Q?+71vGytnEptJ7wrL1LAD1KhUSXmbQIkc5C3NSFuc0vLRELbfd7hhivOf1W8q?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cc1fc0-8de2-42f4-42a8-08dabc4a7ebd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 20:48:56.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fVK6YKh1oRuoorRXBFGsocRNg3df5sI65uHEmUzTdOjlrPEOwQbZWxW+8iDoj6AIsKASHbXWVArZBy4pTyCB+nPYM3iFjmNcZG9WYh+iVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010146
X-Proofpoint-ORIG-GUID: _8hO3evGhIct6qeznL_K_FI6WfdFIJO2
X-Proofpoint-GUID: _8hO3evGhIct6qeznL_K_FI6WfdFIJO2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

Jan Kara <jack@suse.cz> writes:
> Hi Stephen!
>
> On Thu 27-10-22 17:10:13, Stephen Brennan wrote:
>> Here is v3 of the patch series. I've taken all of the feedback,
>> thanks Amir, Christian, Hilf, et al. Differences are noted in each
>> patch.
>> 
>> I caught an obvious and silly dentry reference leak: d_find_any_alias()
>> returns a reference, which I never called dput() on. With that change, I
>> no longer see the rpc_pipefs issue, but I do think I need more testing
>> and thinking through the third patch. Al, I'd love your feedback on that
>> one especially.
>> 
>> Thanks,
>> Stephen
>> 
>> Stephen Brennan (3):
>>   fsnotify: Use d_find_any_alias to get dentry associated with inode
>>   fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem
>>   fsnotify: allow sleepable child flag update
>
> Thanks for the patches Stephen and I'm sorry for replying somewhat late.

Absolutely no worries, these things take time. Thanks for taking a look!

> The first patch is a nobrainer. The other two patches ... complicate things
> somewhat more complicated than I'd like. I guess I can live with them if we
> don't find a better solution but I'd like to discuss a bit more about
> alternatives.

Understood!

> So what would happen if we just clear DCACHE_FSNOTIFY_PARENT_WATCHED in
> __fsnotify_parent() for the dentry which triggered the event and does not
> have watched parent anymore and never bother with full children walk? I
> suppose your contention problems will be gone, we'll just pay the price of
> dget_parent() + fsnotify_inode_watches_children() for each child that
> falsely triggers instead of for only one. Maybe that's not too bad? After
> all any event upto this moment triggered this overhead as well...

This is an interesting idea. It came across my mind but I don't think I
considered it seriously because I assumed that it was too big a change.
But I suppose in the process I created an even bigger change :P

The false positive dget_parent() + fsnotify_inode_watches_children()
shouldn't be too bad. I could see a situation where there's a lot of
random accesses within a directory, where the dget_parent() could cause
some contention over the parent dentry. But to be fair, the performance
would have been the same or worse while fsnotify was active in that
case, and the contention would go away as most of the dentries get their
flags cleared. So I don't think this is a problem.

> Am I missing something?

I think there's one thing missed here. I understand you'd like to get
rid of the extra flag in the connector. But the advantage of the flag is
avoiding duplicate work by saving a bit of state. Suppose that a mark is
added to a connector, which causes fsnotify_inode_watches_children() to
become true. Then, any subsequent call to fsnotify_recalc_mask() must
call __fsnotify_update_child_dentry_flags(), even though the child
dentry flags don't need to be updated: they're already set. For (very)
large directories, this can take a few seconds, which means that we're
doing a few extra seconds of work each time a new mark is added to or
removed from a connector in that case. I can't imagine that's a super
common workload though, and I don't know if my customers do that (my
guess would be no).

For an example of a test workload where this would make a difference:
one of my test cases is to create a directory with millions of negative
dentries, and then run "for i in {1..20}; do inotifywait $DIR & done".
With the series as-is, only the first task needs to do the child flag
update. With your proposed alternative, each task would re-do the
update.

If we were to manage to get __fsnotify_update_child_dentry_flags() to
work correctly, and safely, with the ability to drop the d_lock and
sleep, then I think that wouldn't be too much of a problem, because then
other spinlock users of the directory will get a chance to grab it, and
so we don't risk softlockups. Without the sleepable iterations, it would
be marginally worse than the current solution, but I can't really
comment _how_ much worse because like I said, it doesn't sound like a
frequent usage pattern.

I think I have a _slight_ preference for the current design, but I see
the appeal of simpler code, and your design would still improve things a
lot! Maybe Amir has an opinion too, but of course I'll defer to what you
want.

Thanks,
Stephen
