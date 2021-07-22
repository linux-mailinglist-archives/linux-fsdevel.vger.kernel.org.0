Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508063D1FA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 10:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGVH3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 03:29:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48644 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230392AbhGVH3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:29:47 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16M89YP6009727;
        Thu, 22 Jul 2021 08:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=dh61yMiiS+phkl4Zfz++yRn4n1nmcDIExFTGxySLJqM=;
 b=GJiAqcsQufK/2OVArRVFHV82QkBXUMRpjnrhIGh1XpgfyDP6NGfx22V4KJhlf/23Xwp9
 qFl8YUcoVmgvpa0pGuNTEDhSChmmKjVWUTXco/ZgQrHchI6Bf7wv1GjwylbknUyaJzXr
 rdvPhk0oRiVFBWDSgjl9N2+q4DoX68KocYoCWGoBjunb9j7z+fAdvK96S76+F/rsL1BL
 yvPsjUmmSj0GitB+UyTnxkCfUIw4ULiuBf6FZZ6+I9h28iHjlJ6rxJTmfKgl6g2BrtTT
 ng7ZMTkU/+uXJvibp8MFStHbqQWODMWthDxYQWSkchrZN8n2NEvYz+5dkFx+jsytnK2s 8w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=dh61yMiiS+phkl4Zfz++yRn4n1nmcDIExFTGxySLJqM=;
 b=UMQcU2QEPP5Yxn4JcEPIBjSkR6ix7sKwRjfjc8slO9UdujGlliMY0Ac4mMVAz+nQAWOd
 LOv7g2cOMXiLEl3nzoMmYNq7/ERjUgSaa6iqBxihoxbhRlZRfuS+e60/1/hTX4XFU2y5
 0+TE7kDDgnqSsgHwX674f3DOvYeexO6Ub5IgWbqRaIgr+ppn4eFlQ1LsnrA4cJCVKEWz
 YOOkFM8B45/srBoft03FH6m3xILJyxN5N7euZxAj8syTc+0SXCUWC+m/HimabnPApsmx
 bYV31/588VUKy13MWV0uSlQfYyN7BsNFxZksjjzSw7BDQJckrQBsVW/HvaJ9G3vcNgQw 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39xvm7rpas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 08:10:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16M86aHj158323;
        Thu, 22 Jul 2021 08:10:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3030.oracle.com with ESMTP id 39umb4ednh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 08:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDZQ9U2bVGECaSvTLtEhga+l32RlwIp3SUNTs1QKROxc8TjQDc+0QjvX4exTDInLrgzQdOtYBXGghblIcLVt8A8NU2sWEZcmJ6tLvDPPn+xDJ/op6Ni5ZEpvqgGWDXzyIWL95qhNF9Iys5NngQZwu2ybI7uOHaiyTsoZDQZBdutbloEXTI4aN43DPS0r/HCaoIWLy1KXKM61sXUgi3XsDQXz+05exEh7LxEzhFLNquHrJOb51aq+R/BsHWvP8Qpg22COneWBu0Bv+msDQxp5BmdLJQ+NYX+nY158eQFAhsaxi3in25v6U+eyXbaByeFF4ytuhp2GPk9ZCSPi1acTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh61yMiiS+phkl4Zfz++yRn4n1nmcDIExFTGxySLJqM=;
 b=DgUAZzpugeqB6JvfACTLRhMvyVo9UMEOeMPtGL6HXQ2k6/lwNruP9jT6KJepdNoaD993D5YQfwDZwkzi2BmORHjjLvQGm7pO+SzYYWDFVs/uLN0R/bfZWz+T1DQ/QG1BegxmpH+8J+NVchmz+mapAf5K7pF60n+0Qhf7BLqsmCAp87YRWOAPbjgUg+Lw8rSFagRhDq3LYuaXz0Q9zkwC9gwYvwcwqDYBJHzLhmPKQbJllAV8KLzoGfPUQqz1/AaZymxCq2G6TgRPW5a3a7N2nvwC4rwH3v5loxJC+mTeyopkPqTrkCB+V65CondAWq1xo3MDhoJNW3bbFrPcYm78wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh61yMiiS+phkl4Zfz++yRn4n1nmcDIExFTGxySLJqM=;
 b=x5qSdVoFo3ntsN6LBo9jhyS9hGG4OAgtSzhsajJJLWUaDqnMXvcHTaPvddDC7UKYQpt4Jj2r8+rygtj/XcB0GV3ZuI63t1n6z7xrVBYFEhB56rwXslge9oNNwf20vbBNVGVMnlSAEREOFts84GRXytMKPnS/Opl+3NEux+78UPA=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1376.namprd10.prod.outlook.com
 (2603:10b6:300:21::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Thu, 22 Jul
 2021 08:10:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 08:10:05 +0000
Date:   Thu, 22 Jul 2021 11:09:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     butt3rflyh4ck <butterflyhuangxx@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: A shift-out-of-bounds in minix_statfs in fs/minix/inode.c
Message-ID: <20210722080945.GY1931@kadam>
References: <CAFcO6XOdMe-RgN8MCUT59cYEVBp+3VYTW-exzxhKdBk57q0GYw@mail.gmail.com>
 <YPhbU/umyUZLdxIw@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPhbU/umyUZLdxIw@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 08:10:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 111589f0-4a23-435a-7f54-08d94ce81cd1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1376:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB13760FD4E9CE35FCE8EEE0C48EE49@MWHPR10MB1376.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNP2gmGB6J+i9sU3SNEcdc98sHehPB40rFql7rI7At4OPlZjcAt4YQqu989qDg+YGuPwrGdohhxBKVk8Jl8Xk+3RFg479NXqjEBHZqYY4xweXmsepLMAPwHj9/zm2jlMfqcfz286wbQi6dyhq129BeX/x5YbGubA2tqziotQdcQZXydPc2v7qytNaSuXYoHx+ZbGgMyeWlxBjFU+yC2qFBJUxht7QRbQ8jYkJ36nQ0XMjLaWiIK6/8YA4umyOtkxw8srngf5MmRjzFH9BRjLhDAtGHM8qmhURe1/Zj89MjQOh7KeuJ7xIqQGBy0gUhHlLE5ZawGSYnhVuTWGqIcrRfiZAkJ/FLdP1rfkz0W0rh11B+EAc0icIUtqtGc4GxWZANPbQ+Oi9C/P9iOWNH1DaMbS7DXgtHAhKpd8w4ed3jmpkx6ry/CvpA+ju6nWT5uaqYFkyVAhYJDi4OFcjCpStBeiBxMhw/rTUjyDziwmKYMWG1z6p+F7sKKA+52mP4TXsh4G7sTstdiJBlcTKBQ5JH4zO61wmUMt5Bw86uZwigVsl5RJgzURyReciwtPntiL5v+1cGG1aPpNIecmf3u/2+fmBA1g0kGgrJ9jDX8Lq11Hpcmvu1BTaNoJlVF81+KgHW95c+xpM9eCUqpH3QZwi3TxDQl+OvrMie1TOVM6YGKUfexs9HGTCglpBoSPDb0miNTAXC+emxhNc7R+kYRe+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(39860400002)(136003)(186003)(9576002)(52116002)(1076003)(26005)(33656002)(38350700002)(6496006)(66946007)(4326008)(5660300002)(44832011)(956004)(83380400001)(9686003)(33716001)(66476007)(2906002)(66556008)(86362001)(316002)(6916009)(54906003)(55016002)(8676002)(8936002)(6666004)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3IIr5mkkkvCWR/MJBDV/yxCFPF2joNa9lM/RskCaCjFC30qhLS0vZfIfIhX4?=
 =?us-ascii?Q?b35x0wnFm03jpW17/Uj/EjBi0t4wj9gIafLZpJh7reNEwnfXbIj5JElecW+o?=
 =?us-ascii?Q?RpCSBKRY+RX3uJU33ynIXOCIcE64MG0TuALePM6APYTYCjCyUrrCpaqhCxRD?=
 =?us-ascii?Q?tvvdUna27THW/bVkwDsPPiZzakPULaaPRPrnOuPYaTkkEovS7iYyGNAExBmo?=
 =?us-ascii?Q?zaH51NL90S/018bukRG9CcNMA/5cJVBwc9yWLAVvcdwk+MAlQv+LkCdQT3BE?=
 =?us-ascii?Q?9GHbRBbaSB99Zi+v4EX1oPsUsWdWFUh/0T82rNh8gbHoFIk6ZWTikq51XtA1?=
 =?us-ascii?Q?g0ioDlMAZ+d/uAVhM3Wj0H75J5x8YC7wvMURa7hsD/Wi8kQzdOFQPaY4JUQz?=
 =?us-ascii?Q?YQzVHxPCcR7zkF99CUK/gFCo3GPVWG4+Q+PLVz4y1GRah+dD5g5n/nJCJpQ2?=
 =?us-ascii?Q?LMZxS/WFejT0A/+sjYeubl/yr+yT1hImFe/aOA1Q00UFbMuID0jszx97I7MP?=
 =?us-ascii?Q?MzvfAPV5CJvG5WNNQ6PsWrCWpv8vYD4bv0HNbMrPftrKubO+b+ySKVPaNcfn?=
 =?us-ascii?Q?7KlgiDJ4gGWr8rFL0NFRCHhVRtfcSDL3Kqy0OBDxAhSym0mbqlPkg4rrXMJ2?=
 =?us-ascii?Q?idxhwzWb6/oTg+bYdiKqLfrptJLC/cOGupyDW1o2aWYBFa5fz+kDrNlTNQUC?=
 =?us-ascii?Q?Oo/qOWu11IvuXCGf9hW9CuiAJpF43iWohL4jxseGmG608ijYtciQ0o8aHm0h?=
 =?us-ascii?Q?s7/NIUyy8PW9FqErV1dGr0K/WRKfnDhSkvf8FuFMwwTAnBYWTT64EgGMLisL?=
 =?us-ascii?Q?ZCdSLPoYTux5xiftjgqnkzfbq1cY9J24Y370ZPap40k/AH9JkE1LTXKXqwta?=
 =?us-ascii?Q?Hw9Knxuq85IwTgQnOBsGOMVJC3sB1OTbN0+P4qBjmyAx2eUi/9wrxn+U+QFP?=
 =?us-ascii?Q?jwH9oOCVzcV/20tDU5JVrp22f7vRvi/q891rk7o9bsbgBEfgVhKQMPKWNM2v?=
 =?us-ascii?Q?dpZrnUYR73bxE63Ra93bV+AgMOVygxt1f3MsDznXTm9AMH13NjZsoSd7wRrQ?=
 =?us-ascii?Q?87/7csCqNTla1QyTOSBXi84ZYcgzAL9K46tFEFQ7CvBNvVFlkyY2fENubfeD?=
 =?us-ascii?Q?yzGKRmzY6NJ5OYzJ9gBlFt5cZZ/8CfaJxRNv3wwnJ7PKKZ2h2KGuqSRnhyZF?=
 =?us-ascii?Q?/KJ6lac9O87qxn9sO1hER3rsNCQBJfb3kZGcdDwT0qDEtDEkNeb/GYE4sKfi?=
 =?us-ascii?Q?OYF3JZCjeLV7eC72wGCP5UW7Iisj/HQzzaXSd4j/X8GRejVHx00gSod9R2xg?=
 =?us-ascii?Q?vAumFLvXLs4mUwN7MR/O6MvC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111589f0-4a23-435a-7f54-08d94ce81cd1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 08:10:05.5427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFfNf/w07lPYlHI5pnLZfxJSORny2bMEbNL7yoJyeo6lAWMXGwF/76dZ66yHpztuodH0vhTQpZpzvgPKUWy8jAMFjECgRp09EqGdDE/fCVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1376
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=954 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107220051
X-Proofpoint-ORIG-GUID: 1pDYoJZktvzfOzv-uuP88zCh-wykCcSu
X-Proofpoint-GUID: 1pDYoJZktvzfOzv-uuP88zCh-wykCcSu
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 06:37:23PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 22, 2021 at 01:14:06AM +0800, butt3rflyh4ck wrote:
> > ms = (struct minix_super_block *) bh->b_data; /// --------------> set
> > minix_super_block pointer
> > sbi->s_ms = ms;
> > sbi->s_sbh = bh;
> > sbi->s_mount_state = ms->s_state;
> > sbi->s_ninodes = ms->s_ninodes;
> > sbi->s_nzones = ms->s_nzones;
> > sbi->s_imap_blocks = ms->s_imap_blocks;
> > sbi->s_zmap_blocks = ms->s_zmap_blocks;
> > sbi->s_firstdatazone = ms->s_firstdatazone;
> > sbi->s_log_zone_size = ms->s_log_zone_size;  // ------------------>
> > set sbi->s_log_zone_size
> 
> So what you're saying is that if you construct a malicious minix image,
> you can produce undefined behaviour?  That's not something we're
> traditionally interested in, unless the filesystem is one customarily
> used for data interchange (like FAT or iso9660).

Someone had the idea what we should make these things only compile for
usermode linux.  It's kind of a hassle to copy things from UML but if
people really wanted to we could write a program to handle it.

regards,
dan carpenter
