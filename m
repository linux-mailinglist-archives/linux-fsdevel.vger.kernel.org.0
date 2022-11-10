Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD166238B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 02:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiKJBNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 20:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbiKJBNI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:13:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9E422507;
        Wed,  9 Nov 2022 17:13:07 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA12wrx021777;
        Thu, 10 Nov 2022 01:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=THyyPfvraNeQj29Zv+qKWri0RLAoXtpg40FIVQ80U5A=;
 b=lOo+D1RjGxy2Q5utBs528qbbHptCx5zqPQRDqCZR/zzyzwtAbRLlTXnbkIlUPbZj+B45
 ziFMd7THKjyC6mbfDqNCRrOhlqEXXd8dpWi2N4nOBCFI6tBwrHervXROjT4z2+ex3Ep3
 QmMKSNBg9PACoHJY/1sgJkfNIWAnlsXgGGGEDKdEhqYI1PJsQGFuE7miEB/HFyIv4SpI
 uxT8F1YL3KYJRCcD4Rldz+eMZRDOA2PRMjVS6F9NPuBDMkjbTUYcJT23sSHZ6HPOFFks
 wjbciR+HuBZe5bP9hIC4LmJ8NNRuXRya0y2IbUZaF9KIMv6glFYNl6pc2bzZHTldncEZ lQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krq9k00c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 01:13:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA15g66004272;
        Thu, 10 Nov 2022 01:13:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq47691-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 01:13:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myvvA1L4iPh0qYuRqQ/bdGmbfSaf7nIv91pVdBymq4NbXz4ixCUgepvT50RP7roha1aJ5P3Jca5GbO8WeEX81t9NBGamq/0C39Lejmd/u0Zf6kRKNVY+u9Sj950cNoSxIV3d3mOpDl40K9q2/z03bO4H0FCoVU/qLA4BNGNkc4BbEsFigwSYqnNnOnNYvb1uZrfMW0A5HMAzpHKjQV7YdDtPHLlTuZ+jJVhHUoydUgA7YcifaQHXjxuhlSQU0N31PK18fNBFa6nlMf3xJ1rJwhe4dtBG1hi/NnJGI3ElMje6YhzQfsT/SISlE0s1XtzZOSqUGDO25txAKQVa270qyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THyyPfvraNeQj29Zv+qKWri0RLAoXtpg40FIVQ80U5A=;
 b=AhVAmdnXEvQYgMagzZbcqoREE8cdRRKOfP5GTdKNs/tHmVY2rlEVISxl09+Lodg1QbclKTdaW2lYh3TAopktDksgCuAb+gAhoqXNwnX1EfJjApFcM0kZJbNfOLKRSpy4FQO3lUmHID1I3uf93SZDOQvvAUDGaRS0JQJuFKOV1C2q3QzlPNltrkKn9Qe7PbWuDdYXcTnkWmvCitLZscUmNlsuzGhYKj4JYk9QpoNQDUmbtKO4SH3Y6rS2oRfnvXSci7Rj4bAICNfYE5kQoFV9aQvU9v5x24IwtWvweOSawtE4Ri1HXT1GBKwdzvSYUmY9E5BBBKd2GGXYMAKPGWmL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THyyPfvraNeQj29Zv+qKWri0RLAoXtpg40FIVQ80U5A=;
 b=gVK3CdMlBdHGXOkHYmjzEIDc7EaN/4F5mStFmba6HmbWjhvyIZQcP+3c3ILglB7VG4Ww43hPwufuQiTuAbHkYmNr60zV+2NhojP9OVu/zafH3r/MC/VESudfaAv1di25AW9k5TCBIwEal/MoTB3DsN1r1oztFiHCC/PgdmwXbXI=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SA3PR10MB7000.namprd10.prod.outlook.com (2603:10b6:806:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 01:13:00 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%9]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 01:13:00 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 1/3] fsnotify: Use d_find_any_alias to get dentry
 associated with inode
In-Reply-To: <20221028001016.332663-2-stephen.s.brennan@oracle.com>
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-2-stephen.s.brennan@oracle.com>
Date:   Wed, 09 Nov 2022 17:12:58 -0800
Message-ID: <87pmdvfw85.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:806:20::28) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|SA3PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f93874-b5e3-4940-82f8-08dac2b8b5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JF92TyPWYpftBUgtEcbtRr0EtrQf0x/9c3VwWabzzQ2TOl59azpTSMmns1m94StO3URE/XkFv3SJRK2wKqtKhWuJh1RdekbH6WIrLGv0m848AjkmurzxuQBsl2HlMgqQifUx7/+KVbSv45xHgSLTi8BrID0JBJbSX0YmvpPfnj6q/isiG0qpneXCTS3VrZCWVNZw/uu8h0KJ0n8xIPTYRiIicYDKM1tahQ3mVnWMFVNpNObYYXGOCUq0DEKGfsiz3broHfSIjpQB9ZXPFVU+IM2H9PR3/qoNoKjgExTct6Ke09ZlQgy23heKzf8Yk95Ko06j+2SH4WHCjfhry/zuC05FxVvetfDHw/zarr74yhPBLUGsyxaov/YmJafPx5dMcjWzHDNSsnd04ZM2PZS8Qu4ikOLw0KcQgJwqq2W068kvl6g7LrZDEDOU7Phuyrmuh5cagGQ4T6fVkLUvuqbX8z1UD0TMVuoP3PLd2wIfnepfuJSgjk4B6L7/AaMzucKEU9tluI/E97Y/10SqJJiXOx4HeMSgpYN63zT8WIrFTMaGhMQBEtSk+qGqr7srR533jA/M9YAVMdNr2F6Vf5S4do+D5oeKMhbfaz1Rb7KgefaHq5jTxwaqcu9Ii3etHLiy8jmwAnvW10Zj1aqOmqe61hzJGkfNe2cLc522I76oy+DJBhTTmiGcceRsZ3MmqOEFEPriwfDd7f3jD4QgonKadA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(36756003)(6486002)(41300700001)(5660300002)(6506007)(8676002)(8936002)(4326008)(6916009)(54906003)(66476007)(66946007)(316002)(66556008)(38100700002)(2906002)(86362001)(186003)(26005)(478600001)(83380400001)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RbOii+jQbvakmj6u8Kz3ZRERylSO1CRGFJ/WqioXG6qOPSuUSexa4oJGEUvH?=
 =?us-ascii?Q?2/ZlOh8SbsWSOCeHqn8mPLg/DYs0s8y7pYmLPwud9nHmAERLYVAbLQWmKHBZ?=
 =?us-ascii?Q?4J38yjqpccqg9Ce/bn2uW9jXOhzx6KsXGXUpeF5jvD91tL4b3gX7k2v7psN5?=
 =?us-ascii?Q?FxOIA1UJ5X+7TElAJQHfpwo3gIcKdEJDvRgH5h+7r0pNS9bk3FpMvrI4u9m/?=
 =?us-ascii?Q?adTGDwFaA44C3xdjmYIA1/gHcirSDax0hlJ2NFLFAvN1TMcCA0Oe8xbhjIwT?=
 =?us-ascii?Q?aZaHDoa/fXPGJqRXEVzOKnM+3nsBbAPvB/CQFt1PgGj1t3YFgWBbevEWu15u?=
 =?us-ascii?Q?1rtUmWHEJ9C/zflaXGfGcHQ2IuRjOc6NVhU0n8hfgjwSUB20GpcskvilP/W5?=
 =?us-ascii?Q?YOs3dYwBZynDlXxVii7cDw53TmW/JkVNKYU7Fzb0xZjHGwlsqk6rlM7X5wKt?=
 =?us-ascii?Q?g9VvP1Nl7HsZ6nGFdkuFKKJavz5KlONr57rMGvlqNowEbNuZlD4lTtIHykg5?=
 =?us-ascii?Q?3clthh/9/CzyhY2DgGt7kdxmtaH0N6sHOB0HuZHXPQsfCRy9gq+nZeATNTtx?=
 =?us-ascii?Q?v3YUtf09/dnBet7Y5y/GDZIPARiStauZvhjXuENi7HUP1AhjaluOnsAcHeAn?=
 =?us-ascii?Q?avzHzvup3zIMRlgvq+9y44yPQJWQczSQxlUvwgoRLYNSs61+wQ4chwIXT6PK?=
 =?us-ascii?Q?wtWbol8IP9yi7TRAIBv0aDO7KY9tk0k8+7qAjPAgFwGSDEPrzFkWrlfa/FjF?=
 =?us-ascii?Q?ToW5smpmkYSaKAiGfUoFFXCVpZ4STctv3ilCE7N8kgGV+xgKIvoO+N/aPr34?=
 =?us-ascii?Q?2my7lN1IDMeUhoFdSI/VmtS9L90wyVWmLMDkeiapepQZgMG/IF55wTlLMgNq?=
 =?us-ascii?Q?ffAWq9NDPuBx85cdgbeMOWLbjGEjyQjDuozIGGbG1nJ2rkh1j09W3Bg9iEu1?=
 =?us-ascii?Q?EgovsZ44uwqyMMxOKAYWzmxw0574qdFhGlxBdrNrhqsGlDsEKfG1b2mN9iUh?=
 =?us-ascii?Q?7PVo1bjPqd7SiS5AsNEFLk32eBdOENbLCjg4MMIswgcklHDtYBl6rS2W3Djv?=
 =?us-ascii?Q?tqmHLtOpwveKyXVtViVQQKK96mcO3ecWUJunxn7FeWb9yy4R3YUe5wFgGPLo?=
 =?us-ascii?Q?M8z+nWICW+kM8Jv/vCSyISbS21qmF+vJzbzP3f8u6GZrhqT+rVERFgtYBIiS?=
 =?us-ascii?Q?f/pb+6iRcEHbZFu7DlNZQxwOMw298vOLzY3ioI+5vsp4PY9n5x6qEfj1nbm1?=
 =?us-ascii?Q?RAwYcVO6MeZB1zE/N6yQqeeQs8NMQCHso7zSS4tpY11Q19cRWnR/64+Zy+hN?=
 =?us-ascii?Q?4JtZERICSKXMm+g/D6mFp0LXXEq13trG5gJma0WeoVyBX620GC/8F04WoY5u?=
 =?us-ascii?Q?4XDRQJTN5YWBJfiTym8y1peeCdNV7L5PFFWgj+ANKxZC+LLFj0snCd28hlqY?=
 =?us-ascii?Q?OguVT6W17DftyzK6d9wca0V0DwrImI92WGdGcPOq9HxZqLX2LzuNv1J8U3yD?=
 =?us-ascii?Q?LW+sirTkaQTdxmjQXhuCU9/iC96mcSrUHprLhQ6M7RSzeY282Pb3DM+mTUrh?=
 =?us-ascii?Q?eUHhiXHxTiq1hdtymuOrHH1Eziw2Pg7xibhlALOx7/cFG7B7wQNr4b6PLAh9?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f93874-b5e3-4940-82f8-08dac2b8b5ac
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 01:13:00.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dd9Ngg498uilrTxmBXX4wsSaPlwKn06Z5SBK+JZh2nNGFAPNyZ9vU5wQbdmDU4UUnAs6mm0N++3m/+FgJ/l4EkPzOWPVSf5gOZ51MmtcSlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100007
X-Proofpoint-ORIG-GUID: ITgrbC2ReEoRXHn4QH649BLWlSWq5jeO
X-Proofpoint-GUID: ITgrbC2ReEoRXHn4QH649BLWlSWq5jeO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:

> Rather than iterating over the inode's i_dentry (requiring holding the
> i_lock for the entire duration of the function), we know that there
> should be only one item in the list. Use d_find_any_alias() and no
> longer hold i_lock.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Notes:
>     Changes since v2:
>     - Add newlines in block comment
>     - d_find_any_alias() returns a reference, which I was leaking. Add
>       a dput(alias) at the end.
>     - Add Amir's R-b
>
>  fs/notify/fsnotify.c | 44 +++++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 7974e91ffe13..7939aa911931 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -105,7 +105,7 @@ void fsnotify_sb_delete(struct super_block *sb)
>   */
>  void __fsnotify_update_child_dentry_flags(struct inode *inode)
>  {
> -	struct dentry *alias;
> +	struct dentry *alias, *child;
>  	int watched;
>  
>  	if (!S_ISDIR(inode->i_mode))
> @@ -114,30 +114,28 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>  	/* determine if the children should tell inode about their events */
>  	watched = fsnotify_inode_watches_children(inode);
>  
> -	spin_lock(&inode->i_lock);
> -	/* run all of the dentries associated with this inode.  Since this is a
> -	 * directory, there damn well better only be one item on this list */
> -	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
> -		struct dentry *child;
> -
> -		/* run all of the children of the original inode and fix their
> -		 * d_flags to indicate parental interest (their parent is the
> -		 * original inode) */
> -		spin_lock(&alias->d_lock);
> -		list_for_each_entry(child, &alias->d_subdirs, d_child) {
> -			if (!child->d_inode)
> -				continue;
> +	/* Since this is a directory, there damn well better only be one child */
> +	alias = d_find_any_alias(inode);

Unfortunately, even this patch is not as simple as we would have liked
to believe. Running LTP, fanotify10 test, I reliably panic here because
d_find_any_alias(inode) returns NULL. I've fixed this in my branch
already with a simple if (alias) return watched;

Will continue to work through LTP tests (with lockdep enabled) and work
on the existing dnotify lock ordering issue.

>  
> -			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> -			if (watched)
> -				child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
> -			else
> -				child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> -			spin_unlock(&child->d_lock);
> -		}
> -		spin_unlock(&alias->d_lock);
> +	/*
> +	 * run all of the children of the original inode and fix their
> +	 * d_flags to indicate parental interest (their parent is the
> +	 * original inode)
> +	 */
> +	spin_lock(&alias->d_lock);
> +	list_for_each_entry(child, &alias->d_subdirs, d_child) {
> +		if (!child->d_inode)
> +			continue;
> +
> +		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> +		if (watched)
> +			child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
> +		else
> +			child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> +		spin_unlock(&child->d_lock);
>  	}
> -	spin_unlock(&inode->i_lock);
> +	spin_unlock(&alias->d_lock);
> +	dput(alias);
>  }
>  
>  /* Are inode/sb/mount interested in parent and name info with this event? */
> -- 
> 2.34.1
