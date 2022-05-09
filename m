Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4DD51F49F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 08:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiEIGkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 02:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiEIGcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 02:32:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1761718543D;
        Sun,  8 May 2022 23:28:27 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2496AdXR024606;
        Mon, 9 May 2022 06:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Cbo8mWah0q6KvLAW2auEG2VV0Yjo5yAYIm2nuqkZLF8=;
 b=Hs3DDd0uxxpDo9HjWZT3FeENE7b2m8PH0MI7SY7bLjIpEZPnf+f8Qnwn8i3X8X83IMFr
 bZwJ8JntcrRkTuYsTf0r5jEOYsdJWKdSDbPRXvrNYKvx3L1fG0OzYu1KijauyhA9rsV0
 Bp3sifr00CANSiJSBkLA0gFdjPFVQ/gszBRKGbvMo48AbC5N7CoZBbh0BFlMJ45Ewi+U
 iBTY+l/7iyqlDNh7tkCjx2yUPA9UtkSWetsUVPRwwkvuANIGHsDx2DyeiBuB2xhuFuot
 ba/FUPAVF7xxckFXEs/pnAS5XlChliFXy5FcCaUKrBzd/IeQ40sQuxjTYCbjqftYAyNL kg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fx22ubk2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 06:27:20 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2496MNI6011694;
        Mon, 9 May 2022 06:27:18 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd8t0h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 06:27:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2496RGZC52625884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 May 2022 06:27:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28E62A4051;
        Mon,  9 May 2022 06:27:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61E3AA4040;
        Mon,  9 May 2022 06:27:14 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.35.189])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  9 May 2022 06:27:14 +0000 (GMT)
Date:   Mon, 9 May 2022 11:57:11 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix journal_ioprio mount option handling
Message-ID: <Yni0P6wS3r32XAZN@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220418083545.45778-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418083545.45778-1-ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dKzuJh_6aO8acZbQ3dODAu1icY_tZxG3
X-Proofpoint-GUID: dKzuJh_6aO8acZbQ3dODAu1icY_tZxG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_01,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Please let me know if there are any suggestions or reviews on this patch.

Thank you in advance,
Ojaswin

On Mon, Apr 18, 2022 at 02:05:45PM +0530, Ojaswin Mujoo wrote:
> In __ext4_super() we always overwrote the user specified journal_ioprio
> value with a default value, expecting  parse_apply_sb_mount_options() to
> later correctly set ctx->journal_ioprio to the user specified value.
> However, if parse_apply_sb_mount_options() returned early because of
> empty sbi->es_s->s_mount_opts, the correct journal_ioprio value was
> never set.
> 
> This patch fixes __ext4_super() to only use the default value if the
> user has not specified any value for journal_ioprio.
> 
> Similarly, the remount behavior was to either use journal_ioprio
> value specified during initial mount, or use the default value
> irrespective of the journal_ioprio value specified during remount.
> This patch modifies this to first check if a new value for ioprio
> has been passed during remount and apply it. Incase, no new value is
> passed, use the value specified during initial mount.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/super.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c5a9ffbf7f4f..bfd767c51203 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4427,7 +4427,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	int silent = fc->sb_flags & SB_SILENT;
>  
>  	/* Set defaults for the variables that will be set during parsing */
> -	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
> +	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO))
> +		ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
>  
>  	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
>  	sbi->s_sectors_written_start =
> @@ -6289,7 +6290,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  	char *to_free[EXT4_MAXQUOTAS];
>  #endif
>  
> -	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
>  
>  	/* Store the original options */
>  	old_sb_flags = sb->s_flags;
> @@ -6315,9 +6315,14 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  		} else
>  			old_opts.s_qf_names[i] = NULL;
>  #endif
> -	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
> -		ctx->journal_ioprio =
> -			sbi->s_journal->j_task->io_context->ioprio;
> +	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO)) {
> +		if (sbi->s_journal && sbi->s_journal->j_task->io_context)
> +			ctx->journal_ioprio =
> +				sbi->s_journal->j_task->io_context->ioprio;
> +		else
> +			ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
> +
> +	}
>  
>  	ext4_apply_options(fc, sb);
>  
> -- 
> 2.27.0
> 
