Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC20460D2EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiJYSC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 14:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJYSC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:02:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAC9624E;
        Tue, 25 Oct 2022 11:02:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PHnGKx004662;
        Tue, 25 Oct 2022 18:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=9h9db/FiCN/0tNq3zskdngcEt+CE2712+uo15jHV3TM=;
 b=pj6bWTN861PDXVxVFsB0BNqf6/M+0J9R12ms98zJACF0dKoDslBLP5b6M+YXDaKMvuJz
 ZyaRnaVNot98bvVDqdJ/duKmiw2pKKA4jGObgKOkvPXcFycPaRbKG4Gd6M6JuyBlvGYz
 KWKqJUKk1EXZOB2ZbYlfk9J2MfHl6/GWvboESyFifuG5YxhaUv31e2v78spfhS+YGm5A
 kM05v+V7oU5YzHG3vFy6XuB8RfeXcaBwciUBHbcb5fGKLQtaOxVwpM9ykiL/tgglZAgk
 6Q/uX5RtmEEd+81VuIRlGHDPCcT7zZYmWbO6nFxGqELmm9lUg12Cxw/9pvtT4Q0hkcqV ZA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xe3nsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 18:02:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PHTOCq039831;
        Tue, 25 Oct 2022 18:02:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6yawkxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 18:02:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNku8Q1AyNPr1cYVHkfcaNBon73WO0uCqFlF9RSMYyDxKJhqBRBqba65UwxtAUlN+Kbbt1JacGDbm5q7bvEZzuXMdTbAv2+CBxBTDNmldz5iqQCknucjuKWRvE1vmGJ746Uwu21sEFYcQ2qWxKTCHksNm3um98x2hJOl71ZFJo9gR+RKYqk+/xairojo6Gssc9aQmZzaem9UOaie/vMnx1BiqAdAhIW7t+6/Q76QRSU48HZYDpzpX3jLNVn9ANDgPtyGg5idXdiNiPN6mhE9JnuX6eWOOqetCBFj3X9WI644zF161wFOF+W9bfnIYcIzKNpKzs/okS40iMTVzJyysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h9db/FiCN/0tNq3zskdngcEt+CE2712+uo15jHV3TM=;
 b=h6EkwfNgyg8mKhrbzKCRIg3WDtyJE3GKkdQQHq89c+BFowUiTRQHwdgXAw7sokmD0jmjy6JFvGdUrNGgue6lGzKv2zejrj7FNYkSS0CXHrn1Q1UCiz8R04Nqog8cZgBseTsg792C8yzvAEa2va7iP2ey6UE72Un+Nf+AbXJcoS3v/iJkr8lIEUdRh89PdRESjzyerk3Tbqf+sXPJ0ww55ri2ox0KBWKB9A5zD01CHMuZ6f78KRkeCb9Lcu6cYtJ+riecD6Q9TvY6dJftIwXjfQ8Ge/HuwVZKjDOUWEouDTsIcI1T9QfH96+z+RI/Tjp1QO3EihjiUC9tmBkH0roy6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h9db/FiCN/0tNq3zskdngcEt+CE2712+uo15jHV3TM=;
 b=KzMMLLrP0Z+Gk8widYQbOanISHqKKN2B/1L7uoNFuNJTjSf5VakCYK07BmeafpMYL5rgMr/NzNVBRFJH6c6QXoHnhCmfJnJW42q0GPaZ2OSjNXvAlgRH0VseaEfD225MbAXKIbjJp//xGJUypQD19rQ53zIwBq/+/hm32U1mG/c=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 25 Oct
 2022 18:02:45 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%7]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 18:02:45 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fsnotify: Protect i_fsnotify_mask and child
 flags with inode rwsem
In-Reply-To: <CAOQ4uxh7OvmH6o1fUmMoQ_D347jVBx53TLe4R=BjtXTuvCzKCA@mail.gmail.com>
References: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221021010310.29521-3-stephen.s.brennan@oracle.com>
 <CAOQ4uxj+ctptwuJ__gn=2URvzkXUc2NZkJaY=woGFEQQZdZn9Q@mail.gmail.com>
 <CAOQ4uxh7OvmH6o1fUmMoQ_D347jVBx53TLe4R=BjtXTuvCzKCA@mail.gmail.com>
Date:   Tue, 25 Oct 2022 11:02:36 -0700
Message-ID: <87lep3hjcz.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0134.namprd11.prod.outlook.com
 (2603:10b6:806:131::19) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|SA1PR10MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: 7971a8d4-afcf-400d-9ef9-08dab6b31eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OH72Deie4EA03bUB7J/3PfJJQ9SgCRcWseBE/J2RAdm3L+axBQv++j3q9oeUeT4DOFLV8bMdaSuRnmsLFUNiSSeqmq+0zOKH02+aS1tK0BlKZhyHNtDSS2pdn+sqIK+uhR2aqSj4wXwI9FlMEkhxnrrJixijafmNo3op6zaVi2MB3ghDZ5gCmGG1DLyrQlnzUBzldb/nPVry2bhBWvPhWjzR+spnMRcjDFh5B9ThfdeTGxvE4c8/3kzsO2AQqaZjmhMZMDaja2S8MfWeI1RptRUJ1pWdKuUCWjm9rzkLl6or0+O+/SeRaCY1HI7gFLXARa8a7AOyEtyatkMtUIHy0YFBvQBg/bXTQ4HcH0S4OncZPslXK5zrhQzCR6ZDZTw6Cy36MtdD3oDbiMeZQeD+lubY6AXjY9RiP8SS6dqfGD0fPMY7nZiSA14yJoA3XkPJYQxQwT3CnIgK7+NNcikIe7g080am2FyJEaAFaQwJPPhQr0gFnzzHmWelz8UHQYsUlOaYQCEkEs7Ysqceb5kTmrtOPDjSUV/4l5J6G1WsV7cn8e4QdcZOQVo9fqiIOAE9qwrKIVJc/9FRf475NMHvw/liTjhHQEps8ocIcNtw4nOXg+SXUxOr5Z0pwAYpTmo/RrlfANSRGgGhHDt68abSyaAZsppTNwGrfO9bNLYRupKpruKWJGIuqF1q6wtoS3/cudomd5A/edHE0eEF4+dBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(4326008)(66556008)(66476007)(6486002)(41300700001)(6512007)(6506007)(6666004)(38100700002)(2906002)(53546011)(83380400001)(8936002)(478600001)(36756003)(8676002)(26005)(5660300002)(66946007)(186003)(6916009)(86362001)(54906003)(316002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FNuBuweejZQ4r5egTEEgWqP0asLEvyFriIFJT1Tzg0Vd2GgFypB/lMi9O6C+?=
 =?us-ascii?Q?//5KxHhG6U/4AeIsCqx8SvPkMWM60xw2hRltOI97G1VgCTchpfYN1Tj/hwlN?=
 =?us-ascii?Q?v+BYhw3K//CPAZ3ilm8SW8IaqQaVy5/9rLxZmg6/tRLONngSe4mptP1ZYclm?=
 =?us-ascii?Q?vdjbMgj21iVZFdVR+HB/HIV2k44/RtB0I+K1kWe72p9edA00OTUSIsvdSrOE?=
 =?us-ascii?Q?7fGfvJBlaIB7sAwWsJUsDgbsL0Nmft7zWHra5xkl7Agoci34bPOKNhUu28vk?=
 =?us-ascii?Q?rSYQv8ODYWLOZHD5hX4zbf1hfz9/iPb0/yypsTlLGWYpZghyFaebsxc2nSwC?=
 =?us-ascii?Q?ZDJNpSLyztV0fsG0G6CS8TmV2CZVYkH1nu/H0JBib2PIoWctHcJMUBN5EfUp?=
 =?us-ascii?Q?MraejC4p7cZ7pi+WNgOLJXPsDsJeuQwqQX/1Eda+rxvoZJ/h79h5dwnDxU2f?=
 =?us-ascii?Q?mET8nSSAJX6GrW/A7ShLtGNALo0zu5mFBE5LmCStAxhAlfsCo+6cZQS44SrF?=
 =?us-ascii?Q?shdmroXDtWug0icwz/rQegrzSeM+oiswVMBMQpSnr4RCmgC7LqcaR7z7IL/J?=
 =?us-ascii?Q?niLB2KktaconLWgvhSBMR5CJLuxPGuYelh3wvPdXNRbbe0LWhEE+g6aGNZlR?=
 =?us-ascii?Q?wf93P6Ziazg8sd3ajVubVda6AyRwtB2lb36m4ejiukaVvv+4/Jd2RapT3YWK?=
 =?us-ascii?Q?dAh9LvgknG3JSkoZUaNKzBRX/+3Ak9bCjSNRstRsxNVDXZdnN7ATsn3dy/dU?=
 =?us-ascii?Q?47wqtGGdWlnzZ76jYzQq0Xn6Ovmqb9BMblsCAPdbqsZJMj/Gf3qEy+pSKjPS?=
 =?us-ascii?Q?w3fm8uFCaRYqbuNOBblv55Hk6CD4QzNz1QtaacXTPmNQwf171mM/Nt1jnphr?=
 =?us-ascii?Q?PbNwqBS5yAc8R1XSW14nv4j9J6Xly8PH37/Ve/LHZUHX6BzUiRACYCZJxSUu?=
 =?us-ascii?Q?lxG9ee2veyZD0cBnpuIbfX0p1z5PaZl71BuPxJADYJsJMGtWDJb8sbJTvsXF?=
 =?us-ascii?Q?jbpJuUURMPn972RAQiW+ztONvZSwkH9q2++5hiO2S/DxtVTLPHzAV7gDVEkP?=
 =?us-ascii?Q?qTQR9lJKxUSsSHw3wEooB/3iHOe/QSckT7VWEVDOTxwuUnKheLWZVrYDUFp0?=
 =?us-ascii?Q?pImrFN/HEqjrQ/aQv4v64L55TLEKuiobTmbgWkebQ8TALKmeoX5GvhuPMxe5?=
 =?us-ascii?Q?uXztx4iucloJx/TWQxAl0NkCgE7Lhr6IDM4QyQ7MaoYgIxo18OKXgEQILt+K?=
 =?us-ascii?Q?F5V3obb83FqaecF7LOat6h0k5bcritT5UtHRKMAmbnkmGtZmy9kPayuiooE2?=
 =?us-ascii?Q?5Iw5G9Nywcdh1wZf5kEzWNQ/GHAR5tgNV4P5lkjulL4m1g/YQP0IZB/ZQyAP?=
 =?us-ascii?Q?zcH+1cTpoJwdGVp9bDwL+rznmW6eh8+Gh7NvCkVKm7F7wdo1SAxKFhBUe07t?=
 =?us-ascii?Q?diFFReWCidLtvR/4gNSHpB7ZrNeaAKVAZj7lQQnpG6AwBFXFpTM00DIW+fyW?=
 =?us-ascii?Q?5DMVJyGD7hZ3KcR8sP3pTGCNa3YZhxe09VkQDe61bLECfaT+omfy2/rvt9PF?=
 =?us-ascii?Q?XdWODuDW1TJFH/b7O2gba40LXDw7Y1MmhiblLtCwb2qReOvT1d+4yBz24/Sx?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7971a8d4-afcf-400d-9ef9-08dab6b31eab
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:02:45.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XphEYRD+gQ33bBd3mWC1KF7PNuc3tz0vWNwPjv/bXtJaCznt0BCvylXsmuJcVqHlS7XnTFgePEfoskQiRVKrJ0aQW9A9i0QdBSIndSFkWD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_11,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=886 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250102
X-Proofpoint-GUID: MG2FhGuf49jYu4QpAnXk_M3IDEBrGKDq
X-Proofpoint-ORIG-GUID: MG2FhGuf49jYu4QpAnXk_M3IDEBrGKDq
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

> On Fri, Oct 21, 2022 at 11:22 AM Amir Goldstein <amir73il@gmail.com> wrote:
> ...
>> > +/*
>> > + * Objects may need some additional actions to be taken when the last reference
>> > + * is dropped. Define flags to indicate which actions are necessary.
>> > + */
>> > +#define FSNOTIFY_OBJ_FLAG_NEED_IPUT            0x01
>> > +#define FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN      0x02
>>
>> with changed_flags argument, you do not need these, you can use
>> the existing CONN_FLAGS.
>>
>> It is a bit ugly that the direction of the change is not expressed
>> in changed_flags, but for the current code, it is not needed, because
>> update_children does care about the direction of the change and
>> the direction of change to HAS_IREF is expressed by the inode
>> object return value.
>>
>
> Oh that is a lie...
>
> return value can be non NULL because of an added mark
> that wants iref and also wants to watch children, but the
> only practical consequence of this is that you can only
> do the WARN_ON for the else case of update_children
> in fsnotify_recalc_mask().
>
> I still think it is a win for code simplicity as I detailed
> in my comments.
>
>> Maybe try it out in v3 to see how it works.
>>
>> Unless Jan has an idea that will be easier to read and maintain...
>>
>
> Maybe fsnotify_update_inode_conn_flags() should return "update_flags"
> and not "changed_flags", because actually the WATCHING_CHILDREN
> flag is not changed by the helper itself.

Yeah, this is the way I'd like to go. The approach of "orig_flags ^
new_flags" doesn't work since we're not changing the WATCHING_CHILDREN
flag.

At the end of the day, I do believe that it's equivalent to what I had
originally, except that we'd use FSNOTIFY_CONN_FLAG_* rather than my new
FSNOTIFY_OBJ_FLAG_*, which works for me, the new constants are a bit of
clutter.

> Then, HAS_IREF is not returned when helper did get_iref() and changed
> HAS_IREF itself and then the comment that says:
>      /* Unpin inode after detach of last mark that wanted iref */
> will be even clearer:
>
>         if (want_iref) {
>                 /* Pin inode if any mark wants inode refcount held */
>                 fsnotify_get_inode_ref(fsnotify_conn_inode(conn));
>                 conn->flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
>         } else {
>                 /* Unpin inode after detach of last mark that wanted iref */
>                 ret = inode;
>                 update_flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;

Is it possible that once the spinlock is dropped, another
fsnotify_recalc_mask() finds that FSNOTIFY_CONN_FLAG_HAS_IREF is still
set, and so it also sets FSNOTIFY_CONN_FLAG_HAS_IREF, causing two
threads to both do an iput?

It may not be possible due to the current use of the functions, but I
guess it would be safer to clear the connector flag here under the
spinlock, and set the *update_flags accordingly so that only one thread
performs the iput().


Stephen

>         }
>
> Thanks,
> Amir.
