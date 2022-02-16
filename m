Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA444B8202
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 08:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiBPHoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 02:44:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiBPHoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:44:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4278C9D4DB;
        Tue, 15 Feb 2022 23:43:47 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G4ZbLv024654;
        Wed, 16 Feb 2022 07:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=bMZ9v5e7xIQmYS3A2+C1R2HbjehYBu85wRTwm+D8Hs0=;
 b=CpEEt+/yg915vBYNg1fyrSMaqFeh0v87G5u19ivDTxKBsNQg4RTJt8HGiugm07IvLlXs
 oEVynrguaxp5fkxCvysKV+YlqBZ1nQOZJwpLPvfY5aXTz7wAZ6Dl7Av/xpCma1gQkjEj
 0A60QrOiXL5ph8IGGEZF+fahOC70oyNErw2VlUtzY/KN5zjdrBNiRpS6J7Epw7Z8nDm8
 yrmUskDJEtXWEd6o2gYR6sM5c7/ffvnCveljMNHlJ75duCbTfpwjtouI45PEKRHZg/Jn
 9wfwYuef4sXIBK/H1khhrbaJ8p6HR82SKLKZJGG82evLfosuZctvVcEpaRt94N8uIkaq NQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncarx45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 07:43:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21G7g79p152449;
        Wed, 16 Feb 2022 07:43:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by aserp3020.oracle.com with ESMTP id 3e8nvs2ewt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 07:43:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVKwuunC1v+Qe55znhFTthheOLhIZDxFViQ4/stHBjnZRRk+x9ol6uVxvuk5bLDDhdErQc1c8OIBPACY5Zofloygr+Nsp6RCn+r+RRVmJ2ooilnypWMeJr47Ttevf9BBkGl2aQc2C6+34fGKM/52abrBO3jbnepEygWV27wvNJExEDa6yzV9eVFkeuD0QObLg2wMCr4sZAKLYQ4n2zJ7E+TV7vFmJlS7Bhw6kOuyiJbBJx+kOjQPgZupoamm2sxsL16DCn+NRYxUgdQye8DW/zgMT5FsqTOPo+bPE0SWY15BJL9VF11YtSwL+vWiljM+SHEmZ061uI26czDcnTx4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMZ9v5e7xIQmYS3A2+C1R2HbjehYBu85wRTwm+D8Hs0=;
 b=Z3tpKv82nmxNsDgP03WeAQ9uS8BDjsOMc2HYfwvnsBKw+TP/vpmDE4mdpOTIMBYpyzMOarPOvPPsSBlEN4Z9vgd/HEFaCOTzLWbF7G9Jeb16exD5OYqCkdBTqAI3Xi7Wc2kFk/sVebWDpfPVZm4fYY70X9aLYYg+z1/NWXtl1jGT3eXDxsqb93tFhm0EXiNGOBxWASL9J6vejW4AhGfUVFrC1PVtp1ul5uX4Jyslb4sJ7gscRh041I/OlvL588d2kO63q7TiVz/shBQebOQjIQpO7SzjqskqTXIX5mv+EO3lJjuVaqORLCsR6+KTMTMWyrpxUYIDx0fsPo9vMs/PFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMZ9v5e7xIQmYS3A2+C1R2HbjehYBu85wRTwm+D8Hs0=;
 b=ieIjrGi/h+KyIgROUkjdOykGu0Mj1ryQRqp6T3/A0tyhLKGSEM8n9QcC3zjrQsL6WRbioXR1MYtYBN6K32ZTRjgPFcwqHtAsUjsc+vRvEq8031p/ALu7XlHfHuHXrgJ9njgN+ceTCBqGSLoLfCC7Gd6HhYFfpbhIsCd5/0SyXoU=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MN2PR10MB3421.namprd10.prod.outlook.com (2603:10b6:208:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 07:43:37 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::a1f3:1518:4e2e:b69b]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::a1f3:1518:4e2e:b69b%5]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 07:43:37 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 1/4] dcache: sweep cached negative dentries to the
 end of list of siblings
In-Reply-To: <Ygx0ZJbn3cdUwnQ1@zeniv-ca.linux.org.uk>
References: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
 <20220209231406.187668-2-stephen.s.brennan@oracle.com>
 <YgSjo5wascR9mfnA@zeniv-ca.linux.org.uk>
 <875ypf8s5m.fsf@stepbren-lnx.us.oracle.com>
 <YgxvK03Q3wBVfLYS@zeniv-ca.linux.org.uk>
 <Ygx0ZJbn3cdUwnQ1@zeniv-ca.linux.org.uk>
Date:   Tue, 15 Feb 2022 23:43:33 -0800
Message-ID: <8735kj8dei.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58ae9160-1bb2-42dc-dae8-08d9f1200a84
X-MS-TrafficTypeDiagnostic: MN2PR10MB3421:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3421F1D4A1C186DEC63C8884DB359@MN2PR10MB3421.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Yetf1l0Q/6pj4pHYVbSzcJGUUyguY0UevchDh6EFL4WgjeaHkvs/FWhWtnErKFrtOdY936LPk9VLgU2Ij37g7cbZEDoyS6c/a4qLXU0k4lAJK9t/du/BrkP6iUJzBxsc3nwBoVVdOEiq70cSu9zKDnJCNBNXcdCrFsn85HLMyUVLe3AEa1VcMZ8VoU6rydJWsig7VC+v1HKkpQ7LTXiMgbuN6FNx+0Xd1VADEmPqN9lx0+FKiPFyPlG3PWpxpq2hqxPyIY96wsPCdiyohdQZxTgCPYifH/wg72iypMlJobJUnqkx2eUnOIuW+qYikFhPe8Y1/XW2rqh2/OliXyB71NOOZusnuTFAguLE14leTPXQdxWiU9ifyhf8y9wcdKT7ZxyuUL36x9A3RneA5yteKB+ICek65fObqmin1ojp0aupILRJdyKNy0VyDn9ojHnyE3YncqjUqU355Ly8MBealJpzOiar+/v0SnAWHDFsL2R7DKiLDLdi2Za3M+KMvkPdOWW1TBDsrkKJjDvG0BJpOK9iPDrdsyyZoFddgrY5XZQr7zi8GKg/zJh2mT8ZIfPS7n48V0STGNFp99kcGmtK1bptn+DtQN93uB2ESZRzuj2kpMm7yNgDxj8qUu7kNj+zd5VyahU/XUjtITY4t0mzJd9yVWEs1HYBCSKZYKECpphOI+E/MIKPTwoSSsfJLYYNlFhEc2I+v7t6ih4L5dyQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(26005)(186003)(83380400001)(52116002)(6486002)(5660300002)(54906003)(2906002)(508600001)(6506007)(6916009)(8936002)(4326008)(8676002)(6666004)(38350700002)(38100700002)(6512007)(66946007)(66476007)(66556008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxQvg8tJ/DuHFYiNG5vMpWoJl9aQjXvZTnKX6Tzs6p6L/GuAzu+9oHljJPs8?=
 =?us-ascii?Q?VLKwGMk/YLC1V+jO6BQZW11V550ryyOmU5PfprMFVK5ryI0c8ZcnQHE9eiAw?=
 =?us-ascii?Q?ZWPBslxU5HudiEoE3WPmb4q48+es9jlpxytadVOpxARywPUGLFjDzOFpiVs9?=
 =?us-ascii?Q?P4aJS41r5fGPTQVXHkLPDitStSqxsU+omd/D1X4BrPXy75dcH1iC0M4s5W8k?=
 =?us-ascii?Q?diY9ALTp8uX/Xo2gYQ2gGoDEN/6LmdhT/DilK+n+ccWCI+3bwvjPWUMUuPMt?=
 =?us-ascii?Q?ltXamPE8WHXvOdEUhGWWomOwhGmaLchXvpP8qbYZDYVPtqdYCeObGvPwfKCF?=
 =?us-ascii?Q?I0KXKN1qQtL1VeEGedQ7gGcb3MfPgBvF4g4eojkqkkNdh6fts6HUET6hosIB?=
 =?us-ascii?Q?TyJnpsV72fzmAmbStPU4Sdqii44ARDElHrar/Akf4th/B3FZkgVgNB5lYSnL?=
 =?us-ascii?Q?BB5xW9213v1iPc0F8YvOPOxBxUSoQCTRwyrCxECnXuvnfUPW/NXEl/+2onYf?=
 =?us-ascii?Q?MBCaoFOG8j58cmPAix/qFk9ySsGzupa0Wuno71e+XFdYcIyQI0yrUFLT4wEr?=
 =?us-ascii?Q?bA6auhhXSKDItc/xfxx2VojzoT3WQ0PJkKRfqtqonKAAGrlhvzbEe2G6Hr3P?=
 =?us-ascii?Q?t12QiW0cODvNXMPGFzFtDTN2ZOIjD2EIzmI1h9qq5QtR9nrf89ahqkRMSUQR?=
 =?us-ascii?Q?ifOMJfU3M6Tl30xRI/o9DBrW/MFlwdrwC0+zqJpSn3VaueK1ZnAu37VWsCt8?=
 =?us-ascii?Q?rKTs37npJqAZbGNQ23SPzv2Q3ANXFi6fsZOhkmoOASouQ1fwNzy6F49EWDlo?=
 =?us-ascii?Q?rQnxQS3aG/UkzoYPHGjlvBp1gUDwiAGuH6u6X9vCPUhgsx3Yzi/F1A+BrI8y?=
 =?us-ascii?Q?N011nLq+SPX0TAJ42jIeH8+/gmcenPoGVyBHZqg82Z+vLPbt9YW+NvJgdY6L?=
 =?us-ascii?Q?57wrthBBTm3zHbUBlSdwAD7p2OQdTafQQPo1vNUYzWZY9iw0BNPj52M0eLjF?=
 =?us-ascii?Q?cluOg7QK31+qYL4TxkVSQxPossiTu/BWPxDBX0mc6YRPQU9IKNz0I5mJFCra?=
 =?us-ascii?Q?TH4ImTtxcYXOd33NLvb0hl4Sz8thLHDAOMv9/XcK4/TyRUl+qZZTu3AIMT8q?=
 =?us-ascii?Q?qhOS9YTMinqu/OmWGGER9DO1e0KKmP4d9ruAIprciCdMyenGzzHua3Ljjg86?=
 =?us-ascii?Q?y6BXZifCTM2lleBlSkzC2xeCGiZ/GNS30m/dip6WcIPSXol0OwMAch1x4ytP?=
 =?us-ascii?Q?We7NLJtow/N5GJUcpMV8+ggsz1rAWYkv84Y0xBmzCuX01M50WnYcyHKyBzgY?=
 =?us-ascii?Q?/weTntrpXFvjjfaHOB7Umt3p94WrWm3+GWYLqZeUHmgo0h6Cq53L5IhHnG2n?=
 =?us-ascii?Q?xU5cC2wVjc+SReNauVu3ydwVZubNebYOyegScbVNCI3Xm6N9egN8XyzCuNIm?=
 =?us-ascii?Q?Rm3hlEkLmqUf408KvixxsBvfVX+NiYzyag9NKqXscHlXebbFdwvKK9/HPcD9?=
 =?us-ascii?Q?c6gEYZhW6dP2Gve5gplEdZRGwtK3OFSqnQh1YBiHDHuZj6fZearQ1zhCVCCr?=
 =?us-ascii?Q?pjvuysDRsadXB9ifuIkiKEhgh5Zw4MR6jhnvklQX2RX1PZ0DPq+Hb+NAXsb7?=
 =?us-ascii?Q?NnEmQ9Hd8eE+/4fHLYZOzI2uizglhmyBYMRLfgHPNGJ2tq+6TYxD1dgk4dHg?=
 =?us-ascii?Q?Yj16BQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ae9160-1bb2-42dc-dae8-08d9f1200a84
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:43:37.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyobFdeyPWKUDqaVmyeY+VMWNwKCDBxt5oACPHA0vCeKHFER7wctGkoglUB34ldwZjY7aDu/aGpTHpv+fpKtgdqaIt3tOKbmTbs+W6u9QU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3421
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10259 signatures=675924
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160042
X-Proofpoint-ORIG-GUID: uRrK29QfnPgYc-vbUWbMypHPMgTLcQQG
X-Proofpoint-GUID: uRrK29QfnPgYc-vbUWbMypHPMgTLcQQG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:
> On Wed, Feb 16, 2022 at 03:27:39AM +0000, Al Viro wrote:
>> On Tue, Feb 15, 2022 at 06:24:53PM -0800, Stephen Brennan wrote:
>>
>> > It seems to me that, if we had taken a reference on child by
>> > incrementing the reference count prior to unlocking it, then
>> > dentry_unlist could never have been called, since we would never have
>> > made it into __dentry_kill. child would still be on the list, and any
>> > cursor (or sweep_negative) list updates would now be reflected in
>> > child->d_child.next. But dput is definitely not safe while holding a
>> > lock on a parent dentry (even more so now thanks to my patch), so that
>> > is out of the question.
>> >
>> > Would dput_to_list be an appropriate solution to that issue? We can
>> > maintain a dispose list in d_walk and then for any dput which really
>> > drops the refcount to 0, we can handle them after d_walk is done. It
>> > shouldn't be that many dentries anyway.
>>
>> 	Interesting idea, but... what happens to behaviour of e.g.
>> shrink_dcache_parent()?  You'd obviously need to modify the test in
>> select_collect(), but then the selected dentries become likely candidates
>> for d_walk() itself wanting to move them over to its internal shrink list.
>> OTOH, __dput_to_list() will just decrement the count and skip the sucker
>> if it's already on a shrink list...
>>
>> 	It might work, but it really needs a careful analysis wrt.
>> parallel d_walk().  What happens when you have two threads hitting
>> shrink_dcache_parent() on two different places, one being an ancestor
>> of another?  That can happen in parallel, and currently it does work
>> correctly, but that's fairly delicate and there are places where a minor
>> change could turn O(n) into O(n^2), etc.
>>
>> 	Let me think about that - I'm not saying it's hopeless, and it
>> would be nice to avoid that subtlety in dentry_unlist(), but there
>> might be dragons.
>
> PS: another obvious change is that d_walk() would become blocking.
> So e.g.
>
> int path_has_submounts(const struct path *parent)
> {
>         struct check_mount data = { .mnt = parent->mnt, .mounted = 0 };
>
> 	read_seqlock_excl(&mount_lock);
> 	d_walk(parent->dentry, &data, path_check_mount);
> 	read_sequnlock_excl(&mount_lock);
>
> 	return data.mounted;
> }
>
> would need a rework - d_walk() is under a spinlock here.  Another
> potential headache in that respect is d_genocide() - currently non-blocking,
> with this change extremely likely to do evictions.  That, however, is
> not a problem for current in-tree callers - they are all shortly followed
> by shrink_dcache_parent() or equivalents.
>
> path_has_submounts(), though...  I'd really hate to reintroduce the
> "call this on entry/call this on exit" callbacks.  Perhaps it would
> be better to pass the dispose list to d_walk() and have the callers
> deal with evictions?  For that matter, shrink_dcache_parent() and
> friends would be just fine passing the same list they are collecting
> into.
>
> <looks at path_has_submounts() callers>
> *growl*
> autofs_d_automount() has it called under sbi->fs_lock.  So we'd need
> to take the disposal all the way out there, and export shrink_dentry_list()
> while we are at it.  Not pretty ;-/
>
> And no, we can't make the disposal async, so offloading it to a worker or
> thread is not feasible...

Hm, making d_walk blocking seems like a real barrier to some users that
use d_walk as a lightweight check (e.g. path_has_submounts) which isn't
sensitive to retries. But other callers like shrink_dcache_parent are
okay with blocking, and already have a dispose list, but they want to
avoid retries.

What if we gave d_walk an optional "dispose" list parameter? For those
that provide it, we take references to ensure that child doesn't get
killed out from under us. For those which don't, if child does get
killed, then they are forced to retry from the beginning of
this_parent->d_subdirs. This wouldn't eliminate the careful analysis
necessary for parallel d_walk when both provide dispose lists. But it
would avoid making all d_walk callers pay the penalty of becoming
blocking.

Here's a super rough sketch of what I mean (it's late at night, no
obvious syntax errors but it won't compile unless all the callers are
updated):

diff --git a/fs/dcache.c b/fs/dcache.c
index e98079ed86be..307d32f023c8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1408,11 +1408,12 @@ enum d_walk_ret {
  * @enter:	callback when first entering the dentry
  *
  * The @enter() callbacks are called with d_lock held.
  */
 static void d_walk(struct dentry *parent, void *data,
-		   enum d_walk_ret (*enter)(void *, struct dentry *))
+		   enum d_walk_ret (*enter)(void *, struct dentry *),
+		   struct list_head *dispose)
 {
 	struct dentry *this_parent;
 	struct list_head *next;
 	unsigned seq = 0;
 	enum d_walk_ret ret;
@@ -1483,23 +1484,30 @@ static void d_walk(struct dentry *parent, void *data,
 ascend:
 	if (this_parent != parent) {
 		struct dentry *child = this_parent;
 		this_parent = child->d_parent;
 
-		spin_unlock(&child->d_lock);
-		spin_lock(&this_parent->d_lock);
+		if (dispose) {
+			child->d_lockref.count += 1;
+			spin_unlock(&child->d_lock);
+			spin_lock(&this_parent->d_lock);
+			dput_to_list(child, dispose);
+		} else {
+			spin_unlock(&child->d_lock);
+			spin_lock(&this_parent->d_lock);
+		}
 
 		/* might go back up the wrong parent if we have had a rename. */
 		if (need_seqretry(&rename_lock, seq))
 			goto rename_retry;
-		/* go into the first sibling still alive */
-		do {
-			next = child->d_child.next;
-			if (next == &this_parent->d_subdirs)
-				goto ascend;
-			child = list_entry(next, struct dentry, d_child);
-		} while (unlikely(child->d_flags & DCACHE_DENTRY_KILLED));
+
+		/* child was killed, its next pointers may now be stale, retry */
+		if (child->d_flags & DCACHE_DENTRY_KILLED)
+			goto killed_retry;
+
+		next = child->d_child.next;
+		child = list_entry(next, struct dentry, d_child);
 		rcu_read_unlock();
 		goto resume;
 	}
 	if (need_seqretry(&rename_lock, seq))
 		goto rename_retry;
@@ -1516,10 +1524,18 @@ static void d_walk(struct dentry *parent, void *data,
 	BUG_ON(seq & 1);
 	if (!retry)
 		return;
 	seq = 1;
 	goto again;
+
+killed_retry:
+	rcu_read_unlock();
+	BUG_ON(dispose);
+	if (!retry)
+		return;
+	goto repeat;
+
 }
 
 struct check_mount {
 	struct vfsmount *mnt;
 	unsigned int mounted;

