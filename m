Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F39E61A5C3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Nov 2022 00:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKDXda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 19:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKDXd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:33:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DB624946;
        Fri,  4 Nov 2022 16:33:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Kj7DO013354;
        Fri, 4 Nov 2022 23:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=rPM8YUESXJlLeA8ei3h72t0ZHedgcNRSO5txDrZC/1g=;
 b=GeYRrbWTfbYbnHLRDyL1CwEWq8WHfFzR+fJ4JF06odGan2Cu0frRGiCJfg2y5WxNKthP
 5TfkuSlFXT1kZG7OCtW7x+y2SwVPvpfN/Q1zWgfoHv1b5dCPRaXeHOYoYWxE/WHgU0tl
 8CcgHI7LHao1o4noLbBThSmzaH9aAleyB0bGSTX1N7FK9gBhcO0pujvR1vGjMSjaVdrB
 pRyecaDGLuvc6SIKRfQyI6bUMXYaajb/Idd+ebmnDXUn45KDNg8L1HfmQiiXh0CQfLFN
 okeZ1yneT9RjgmpaMb++7DXC6uYaSq0ZYssQ65+/PAXRZnXHqyErxrBxjU57SXu9Nqv1 dA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2as205-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:33:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4NVgvk023146;
        Fri, 4 Nov 2022 23:33:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpwp0fe5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj7e6IMzSSvOQBUzO7sXlBUPGnU2W3nYxrhH1hl7zWB+eqDD1wdR1RsxMqqhmsKv/CYCfBaofTx0tXURwC9SPB6v7+1/hPPQT64fE0DZbEEyK7julCUORFtvXwezUv7TtZluaSWbPW9dRaShAFy9aeZL8ONVv6ngZ07OcdUHJflqr9CFsvieOHD3Fm10iwi3I9qY3RQ1gkJ+NF1UxRJy0d6eYtrpEAn4LgwdgXNiXJraO1ipFbq4XTu0FdXzmGRSGWD75BALa5K/cKwUO/yRkBgstcYucwCB+4bfgyDJRRlEVhkkF7h8c6H5zPDaPDItFQBZkItKHuI/wSOw4A/DRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPM8YUESXJlLeA8ei3h72t0ZHedgcNRSO5txDrZC/1g=;
 b=jTFzwabqo/oR+234fnGqdJ1JBUxJAghG9KVGvOLWYVVPxCAwOxP4TUU3h771dPqIafPJ87bm+Ky+BsRHp3laE3AvIsMj5oe22BJpAdfDMJ7tHypgIYdig3I9dXqWwLuDyPsRtdNEonNLJSU8/f8BhlGNKvb1D0wVRARTE4eSKJ+qfmzvqruP3JD7BvOFaNLcgeeLJuxxgi7fIDG29lQRBIdH6rPuHKN1LdjGleYe8yaeGdXKfNjQMs2DxA6l3vLcqmtENkO1h92M1EI6G7kfvc7joEv7Dxirz8frqRq9882CFIYaUVHB2VNhz9urwkRE8wHYbqd79hNFIEGOdeErAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPM8YUESXJlLeA8ei3h72t0ZHedgcNRSO5txDrZC/1g=;
 b=K2JVtoD754XCzXabO27ZL8EK4gZ7q4QNTzIxD8R7o3MrLTHBzSA+hpzkXsofT1TQESerNP8P/ohA5DeDQh6UG2zhVkTcsjfRCqB+lhk/8xqNLeQ33TZgGiY56oz532DDEWm4zlDKN3v/sf8QW2RD4d1K5bJtxkMmqEhumKlcRUg=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SA2PR10MB4699.namprd10.prod.outlook.com (2603:10b6:806:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 23:33:19 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 23:33:19 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 0/3] fsnotify: fix softlockups iterating over d_subdirs
In-Reply-To: <20221102175224.iacden3lq4oksmof@quack3>
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221101175144.yu3l5qo5gfwfpatt@quack3> <877d0eh03t.fsf@oracle.com>
 <20221102175224.iacden3lq4oksmof@quack3>
Date:   Fri, 04 Nov 2022 16:33:18 -0700
Message-ID: <87y1sqfg75.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|SA2PR10MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: 43dfe71b-040c-4b5a-fbea-08dabebcf48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sw9Wuns/d3xcGHB2dsU+lGU4kjhMUzXNgfuEDhojoGLCnsrS2nsrd/gT5Jh+ByT55cgyqxo6cjaamAkhBOZZyYxbdbGyUj5h+APlauqCDlilaQuTWfsn8lV8kqszSrlzx6fKLVXKgncm2H/ISzg85znCFJPE2xn/EWKbwgpQVkKtlXQfcsFb3rtYaW59EWkcXEe3+Vq0d5OgJDpvVmStxTV/IbTmLgeKgxnR4+FDRFKIiL0pH6NWQoupuTX4/d9D4y6XDSJ8PL815LcVIOMao54V0Pe70UuIDvAssGQL43lue38W0NVxykxuMaLPfMoogioClcSxX+7Fev9lJGCzzpZ8gVTVzMRnKCO42GDdICGEJz1JoYsqFNQW/Lh5sEzchRwcn5Gc+L1MJfNkUx3cH9O+tbDUeRzyw4Ya9/gtFqeAESf46OUK4m9N4UL6FnBd5tgVsKwvTmNORE3w67gzurZbOMY6JWlvX/sZMZApvdzphHdboPIYdYwSP/bvaijwogHNn9F+q0oYxwpJ6RnyJ0bLDKcKORub6HpjZ10LUz9fzM/vvGBNBtMRLot/7tXoY/WxEo37T80rDfZJ8PHzWEsJEteb/fkjGHJWRJnvuCFi5kekJXycxhJk67ULUjU070MOePBPYEUjxKCRCmjIiMr1oUw6S1z6YidNM3HujNrKIe33fNJV80CyCbxzVbGZ8r0URij/2bXxfsgwU1QYNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(66946007)(54906003)(36756003)(5660300002)(66556008)(6916009)(8936002)(4326008)(86362001)(66476007)(316002)(26005)(41300700001)(8676002)(6506007)(6512007)(2616005)(186003)(83380400001)(478600001)(6486002)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6LCweAqPjVP/YOXvX/Wm71zBsQz4fWFbJYMKdMj0M8CgllRPF2RHXBrKXvrH?=
 =?us-ascii?Q?3/3DP5bgSjsXURc5ynA9/iAVPOZFmgX2pEKpxCXv1oR2Bl6EtpQ/+0bY/OJk?=
 =?us-ascii?Q?1/U+/GBSX/+K2eRNqkb5Mn6qRVarcpFZ7ugNccXhqdP/Ag6skO5vIcpv2I+R?=
 =?us-ascii?Q?a1nVmVvE8iTSEabSIVHykG4UkioqZE3Uh4b7mWaO+O/L2qtl846xTi+o20S2?=
 =?us-ascii?Q?ByasNd6/bQ7SigIhMabTXwb4Myzew0T75UcxCW2IiDuap2gZoP/xY1aHcNcb?=
 =?us-ascii?Q?0VitDTozAhZaeAQYLu9of+UYhyGCIBW3Te+JB21Yl2nkZ0yBR5ThNIsQgx6x?=
 =?us-ascii?Q?HwAcBV6NAMLRtK8OFN0OUbLNbauIb9vaBPxO/48TdzaV3ucXq2KwVnW8rtls?=
 =?us-ascii?Q?RbgSUP9LSD3PCEh8d5a0w8u4bJgLUkg0oe5q3VnH97aJJZzoVPZ2ffr9rdOq?=
 =?us-ascii?Q?eYJQmYVzEvpHSJz8SwnM74nV0EsfUSn7hBIILcZcW/J/FxwoJxczyGcjpwQ2?=
 =?us-ascii?Q?AzN8pKutarrWPCLcwkURIb1vhanBcv0kX7fYKMp0yDFVxEoSNfkLVHWxytq9?=
 =?us-ascii?Q?qYaqe6fT0mZk3JxFN2MMWGEDMME1mKv08ZpON4ioQW2/y+BTutR8/MEeJV/P?=
 =?us-ascii?Q?Cwi6CcRcPW91yFRolbrz6uhkKNO5Z942wCnfXxA64IS812BhpjF0TDNiL20z?=
 =?us-ascii?Q?VOoW6dcBQmWr+dJAr20pwAZ8xy5L7wlO84Z8/G3NdBvLNYBn3jdXF/j+jaPg?=
 =?us-ascii?Q?pAYKIHfbvLbz9TInMQ/9esDWN9tUY+8AgRn1nLthbKS0O+SBXebv6//l5pMz?=
 =?us-ascii?Q?0X1iRniamZSOSoHH0IJY68tNUVx6FfoKu81jT9D1rYyQzEHssbcvV78mR/Vx?=
 =?us-ascii?Q?6N8tDOAqB9kXBwNNEl8HeeO7J1e80N7XF14soSnsG92oXICjEbsKyYQIsFq1?=
 =?us-ascii?Q?vxAmngR72FfDADyYP/oL9HVVkWKsnZ9SwRbSu1zVa1IR4wL2VQudoZmYTI8A?=
 =?us-ascii?Q?7EtYDDS9PS/QPTFiFohxWCBxvMPLu9OnBqsIVgcaGPNLSAdZ3m4QY265UjVS?=
 =?us-ascii?Q?pgX1EkA1U+aRcq31Hi5KKqnaA5ywXyViy4GuVtZztRjtcGWN9Ih2FLvwo/H9?=
 =?us-ascii?Q?4sgXHbDy9PAL1uV79mRm7bLpPznYGGQ/xEqiB920GMblb3CBgHrPdHoAK4u/?=
 =?us-ascii?Q?7T+olj6OM+DfPp19z+4onMnboo3WReJAnSWyPirRrsRsxaGx1nyEgK0LlBJ+?=
 =?us-ascii?Q?8EAMJe9donVcyorp3LuQY+9zevXTo1xQxcZ2LkYOu+CbZNUm1hmJr0hjhD8g?=
 =?us-ascii?Q?2wFdnCI1zs/VBiZ8pPi0z9X+x1+fYX4bC+zDWT/paDUVZ9x8WJ6hf+rBuY3+?=
 =?us-ascii?Q?bSlbRE85Erm7RVuIZDa5TIdZJjKGRCtbxGZrLVd+2QLLWxxdXkoEruMoKjm8?=
 =?us-ascii?Q?7gLKCYx1fZEXMi1xMqIU6PrLkuH4nbEGCaXYmrp0EfXxOIal1/xgpU1Sqomj?=
 =?us-ascii?Q?tzzqcHfUyzKTDYW8CmRb2FUzLYTTywbrJGvdBTiJhNCJb+JK9gi1jjdQbWZ1?=
 =?us-ascii?Q?2qeZRuFrQmIOMnfH8/iB3i2lVorA1Sif5axbPJl2XAbr0st2C2st6XceRoM1?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dfe71b-040c-4b5a-fbea-08dabebcf48a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 23:33:19.4567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsOXhG+pQmL+bBWR5GCqdKZhH2mWwVuzdJcAGmzl8h+p7q3vVOVXsy6jm6TAViqxd/he6/BvVZBM84vJMoSqRzj9ZBX48ww2me2PO1xNCIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040144
X-Proofpoint-ORIG-GUID: 95hj_Nmz0kQao71YrGDq1hj_hKY9tffY
X-Proofpoint-GUID: 95hj_Nmz0kQao71YrGDq1hj_hKY9tffY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:
> On Tue 01-11-22 13:48:54, Stephen Brennan wrote:
>> Jan Kara <jack@suse.cz> writes:
>> > Hi Stephen!
>> >
>> > On Thu 27-10-22 17:10:13, Stephen Brennan wrote:
>> >> Here is v3 of the patch series. I've taken all of the feedback,
>> >> thanks Amir, Christian, Hilf, et al. Differences are noted in each
>> >> patch.
>> >> 
>> >> I caught an obvious and silly dentry reference leak: d_find_any_alias()
>> >> returns a reference, which I never called dput() on. With that change, I
>> >> no longer see the rpc_pipefs issue, but I do think I need more testing
>> >> and thinking through the third patch. Al, I'd love your feedback on that
>> >> one especially.
>> >> 
>> >> Thanks,
>> >> Stephen
>> >> 
>> >> Stephen Brennan (3):
>> >>   fsnotify: Use d_find_any_alias to get dentry associated with inode
>> >>   fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem
>> >>   fsnotify: allow sleepable child flag update
>> >
>> > Thanks for the patches Stephen and I'm sorry for replying somewhat late.
>> 
>> Absolutely no worries, these things take time. Thanks for taking a look!
>> 
>> > The first patch is a nobrainer. The other two patches ... complicate things
>> > somewhat more complicated than I'd like. I guess I can live with them if we
>> > don't find a better solution but I'd like to discuss a bit more about
>> > alternatives.
>> 
>> Understood!
>> 
>> > So what would happen if we just clear DCACHE_FSNOTIFY_PARENT_WATCHED in
>> > __fsnotify_parent() for the dentry which triggered the event and does not
>> > have watched parent anymore and never bother with full children walk? I
>> > suppose your contention problems will be gone, we'll just pay the price of
>> > dget_parent() + fsnotify_inode_watches_children() for each child that
>> > falsely triggers instead of for only one. Maybe that's not too bad? After
>> > all any event upto this moment triggered this overhead as well...
>> 
>> This is an interesting idea. It came across my mind but I don't think I
>> considered it seriously because I assumed that it was too big a change.
>> But I suppose in the process I created an even bigger change :P
>> 
>> The false positive dget_parent() + fsnotify_inode_watches_children()
>> shouldn't be too bad. I could see a situation where there's a lot of
>> random accesses within a directory, where the dget_parent() could cause
>> some contention over the parent dentry. But to be fair, the performance
>> would have been the same or worse while fsnotify was active in that
>> case, and the contention would go away as most of the dentries get their
>> flags cleared. So I don't think this is a problem.
>> 
>> > Am I missing something?
>> 
>> I think there's one thing missed here. I understand you'd like to get
>> rid of the extra flag in the connector. But the advantage of the flag is
>> avoiding duplicate work by saving a bit of state. Suppose that a mark is
>> added to a connector, which causes fsnotify_inode_watches_children() to
>> become true. Then, any subsequent call to fsnotify_recalc_mask() must
>> call __fsnotify_update_child_dentry_flags(), even though the child
>> dentry flags don't need to be updated: they're already set. For (very)
>> large directories, this can take a few seconds, which means that we're
>> doing a few extra seconds of work each time a new mark is added to or
>> removed from a connector in that case. I can't imagine that's a super
>> common workload though, and I don't know if my customers do that (my
>> guess would be no).
>
> I understand. This basically matters for fsnotify_recalc_mask(). As a side
> note I've realized that your changes to fsnotify_recalc_mask() acquiring
> inode->i_rwsem for updating dentry flags in patch 2/3 are problematic for
> dnotify because that calls fsnotify_recalc_mask() under a spinlock.
> Furthermore it is somewhat worrying also for inotify & fanotify because it
> nests inode->i_rwsem inside fsnotify_group->lock however I'm not 100% sure
> something doesn't force the ordering the other way around (e.g. the removal
> of oneshot mark during modify event generation). Did you run tests with
> lockdep enabled?

No I didn't. I'll be sure to get the LTP tests running with lockdep
early next week and try this series out, we'll probably get an error
like you say.

I'll also take a look at the dnotify use case and see if there's
anything to do there. Hopefully there's something we can do to salvage
it :D

Thanks,
Stephen

> Anyway, if the lock ordering issues can be solved, I suppose we can
> optimize fsnotify_recalc_mask() like:
>
> 	inode_lock(inode);
> 	spin_lock(&conn->lock);
> 	oldmask = inode->i_fsnotify_mask;
> 	__fsnotify_recalc_mask(conn);
> 	newmask = inode->i_fsnotify_mask;
> 	spin_unlock(&conn->lock);
> 	if (watching children changed(oldmask, newmask))
> 		__fsnotify_update_child_dentry_flags(...)
> 	inode_unlock(inode);
>
> And because everything is serialized by inode_lock, we don't have to worry
> about inode->i_fsnotify_mask and dentry flags getting out of sync or some
> mark addition returning before all children are marked for reporting
> events. No need for the connector flag AFAICT.
>
> But the locking issue needs to be resolved first in any case. I need to
> think some more...
>
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
