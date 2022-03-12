Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F363D4D6CF4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 06:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiCLF7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 00:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCLF7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:59:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA5E49FA8;
        Fri, 11 Mar 2022 21:58:27 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C4V05s015317;
        Sat, 12 Mar 2022 05:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=cMTGxYgqvsVPZGigDD4Quz2L3girGmNcicNa0Cx9lnk=;
 b=QBO/9XbetpYgeaaJmVEAWKW1YNUwengJf9O8ZoTFpTaRUvYUhz5rZffvU7i1EQchw6qd
 B+JaKdEXJNse7lzQMKomoQvCHU2WWMdP7gR1VGi9MjqRiwQMtpKOqC7MsYVIlNEWhPzh
 UW4kHrSb7Opzju7bW0D0fmdJ2PVitBzwAjWNj4J2gYRkOzMbFAu3gYZx6aIlc1gR1gMP
 ixBgSB9Ffza/+V7Zr71fGt9K5EX0Jhgdc9F5IFqnbVAddS23wMj//tHZfxEwFN5kZQ1x
 YckVin4A9Hy84lIaKBx+j2XDawi9Ave+Fydxnkk75PH0KicEKx7dPrrQinZDzTtU5O0D vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3erjas2pmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:58:25 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22C5qR72021133;
        Sat, 12 Mar 2022 05:58:25 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3erjas2pm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:58:25 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22C5wLJU025993;
        Sat, 12 Mar 2022 05:58:22 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3erjshg7fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 05:58:22 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22C5wKg814221580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 05:58:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E1D842041;
        Sat, 12 Mar 2022 05:58:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C140B4203F;
        Sat, 12 Mar 2022 05:58:19 +0000 (GMT)
Received: from localhost (unknown [9.43.36.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 12 Mar 2022 05:58:19 +0000 (GMT)
Date:   Sat, 12 Mar 2022 11:28:18 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH 1/2] ext4: Make mb_optimize_scan option work with
 set/unset mount cmd
Message-ID: <20220312055818.s6wdut3riqsqssq7@riteshh-domain>
References: <c98970fe99f26718586d02e942f293300fb48ef3.1646732698.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98970fe99f26718586d02e942f293300fb48ef3.1646732698.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iHKFEVvEP5ya7vMvstucK7sJHYacx0PR
X-Proofpoint-GUID: XQkt6CNHIgBRk-tWGEQzpxuyneYAHYO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-12_02,2022-03-11_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203120032
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cc' Lukas too

On 22/03/08 03:22PM, Ojaswin Mujoo wrote:
> After moving to the new mount API, mb_optimize_scan mount option
> handling was not working as expected due to the parsed value always
> being overwritten by default. Refactor and fix this to the expected
> behavior described below:
>
> *  mb_optimize_scan=1 - On
> *  mb_optimize_scan=0 - Off
> *  mb_optimize_scan not passed - On if no. of BGs > threshold else off
> *  Remounts retain previous value unless we explicitly pass the option
>    with a new value

So with new mount API, once we call ctx_set/clear_mount_opt2 with
EXT4_MOUNT2_MB_OPTIMIZE_SCAN, ext4_apply_options() will take care of
setting/clearing it in sbi->s_mount_**

Then with that small nit mentioned below, the patch looks good to me.
Feel free to add after addressing it.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


>
> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/super.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c5021ca0a28a..cd0547fabd79 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2021,12 +2021,12 @@ static int ext4_set_test_dummy_encryption(struct super_block *sb, char *arg)
>  #define EXT4_SPEC_s_commit_interval		(1 << 16)
>  #define EXT4_SPEC_s_fc_debug_max_replay		(1 << 17)
>  #define EXT4_SPEC_s_sb_block			(1 << 18)
> +#define EXT4_SPEC_mb_optimize_scan		(1 << 19)
>
>  struct ext4_fs_context {
>  	char		*s_qf_names[EXT4_MAXQUOTAS];
>  	char		*test_dummy_enc_arg;
>  	int		s_jquota_fmt;	/* Format of quota to use */
> -	int		mb_optimize_scan;
>  #ifdef CONFIG_EXT4_DEBUG
>  	int s_fc_debug_max_replay;
>  #endif
> @@ -2451,12 +2451,17 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  			ctx_clear_mount_opt(ctx, m->mount_opt);
>  		return 0;
>  	case Opt_mb_optimize_scan:
> -		if (result.int_32 != 0 && result.int_32 != 1) {
> +		if (result.int_32 == 1) {
> +			ctx_set_mount_opt2(ctx, EXT4_MOUNT2_MB_OPTIMIZE_SCAN);
> +			ctx->spec |= EXT4_SPEC_mb_optimize_scan;
> +		} else if (result.int_32 == 0) {
> +			ctx_clear_mount_opt2(ctx, EXT4_MOUNT2_MB_OPTIMIZE_SCAN);
> +			ctx->spec |= EXT4_SPEC_mb_optimize_scan;
> +		} else {
>  			ext4_msg(NULL, KERN_WARNING,
>  				 "mb_optimize_scan should be set to 0 or 1.");
>  			return -EINVAL;
>  		}
> -		ctx->mb_optimize_scan = result.int_32;
>  		return 0;
>  	}
>
> @@ -4369,7 +4374,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>
>  	/* Set defaults for the variables that will be set during parsing */
>  	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
> -	ctx->mb_optimize_scan = DEFAULT_MB_OPTIMIZE_SCAN;

So if we are not using this DEFAULT_MB_OPTIMIZE_SCAN macro anywhere else, then
we should just kill it's definition too in the same patch.

>
>  	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
>  	sbi->s_sectors_written_start =
> @@ -5320,12 +5324,12 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	 * turned off by passing "mb_optimize_scan=0". This can also be
>  	 * turned on forcefully by passing "mb_optimize_scan=1".
>  	 */
> -	if (ctx->mb_optimize_scan == 1)
> -		set_opt2(sb, MB_OPTIMIZE_SCAN);
> -	else if (ctx->mb_optimize_scan == 0)
> -		clear_opt2(sb, MB_OPTIMIZE_SCAN);
> -	else if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
> -		set_opt2(sb, MB_OPTIMIZE_SCAN);
> +	if (!(ctx->spec & EXT4_SPEC_mb_optimize_scan)) {
> +		if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
> +			set_opt2(sb, MB_OPTIMIZE_SCAN);
> +		else
> +			clear_opt2(sb, MB_OPTIMIZE_SCAN);
> +	}
>
>  	err = ext4_mb_init(sb);
>  	if (err) {
> --
> 2.27.0
>
