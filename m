Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECD95230C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 12:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiEKKhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiEKKhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 06:37:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB02972DB;
        Wed, 11 May 2022 03:37:49 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BAbR1G017036;
        Wed, 11 May 2022 10:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=EPBJm9XO8k3o9QkZ/U+UwrT6k2Ff6FowMYled0T8SxA=;
 b=IJk3L1Kbvd4AywtS8XAy2Hq3S1PXnF5idmc52b5e6oojXA9Z7X1ooiaqxJNlaKTTvSVf
 vV0Dk2e8yis2MJe/5dUrWmv8kMSwhznUymdVn20rnxklpqCER4FadbvnatblRb80s8ZN
 lYLzztLASPcD6jsSTI5ZJD29JpStMeSDzTSBJ/bEf5J2WgLECr4O32plc1hT+n6RhhRb
 zzpSXE9eBCnL3gvNm1ZaImFAQqPE+pjydqnI45f4wcSmbq+YNy4APL4THmHTBJcIiKS2
 J1QrzhUJ/ZQslKmqrz/WygK5rWmbTpyJnkqMcj6LoQemijnKzJdNoR5eB3vmavUb+6y+ ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0a6ysevw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 10:37:46 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BAbjZu018418;
        Wed, 11 May 2022 10:37:45 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0a6ysevp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 10:37:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BAbF1Z013849;
        Wed, 11 May 2022 10:37:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3fyrkk171y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 10:37:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BAbfFU53608844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 10:37:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A73064C050;
        Wed, 11 May 2022 10:37:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F8344C040;
        Wed, 11 May 2022 10:37:39 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.160])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 11 May 2022 10:37:38 +0000 (GMT)
Date:   Wed, 11 May 2022 16:07:36 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix journal_ioprio mount option handling
Message-ID: <YnuR8N9bpYA4drk/@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220418083545.45778-1-ojaswin@linux.ibm.com>
 <20220511074853.4xgdzagwmkp4ejuz@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511074853.4xgdzagwmkp4ejuz@riteshh-domain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OXPBQhM6HyL1hErYOG0V8T7xILOmKNmV
X-Proofpoint-GUID: 2LP6HxIVq7ndkG5NYkRUXUpCri5BWr3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_03,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ritesh,

Thanks for taking the time to review this.

On Wed, May 11, 2022 at 01:18:53PM +0530, Ritesh Harjani wrote:
> On 22/04/18 02:05PM, Ojaswin Mujoo wrote:
> > In __ext4_super() we always overwrote the user specified journal_ioprio
> > value with a default value, expecting  parse_apply_sb_mount_options() to
> > later correctly set ctx->journal_ioprio to the user specified value.
> > However, if parse_apply_sb_mount_options() returned early because of
> > empty sbi->es_s->s_mount_opts, the correct journal_ioprio value was
> > never set.
> 
> >
> > This patch fixes __ext4_super() to only use the default value if the
> 					^^^ __ext4_fill_super
Oops, will fix this in v2.

> > user has not specified any value for journal_ioprio.
> 
> Also the problem is that ext4_parse_param() is called before
> __ext4_fill_super(). Hence when we overwrite ctx->journal_ioprio to default
> value in __ext4_fill_super(), that will end up ignoring the user passed
> journal_ioprio value via mount opts (which was passed earlier in
> ext4_parse_param()).
Right, I think my commit mesage is a bit incorrect in this regards. I
will fix this in v2.
> 
> 
> >
> > Similarly, the remount behavior was to either use journal_ioprio
> > value specified during initial mount, or use the default value
> > irrespective of the journal_ioprio value specified during remount.
> > This patch modifies this to first check if a new value for ioprio
> > has been passed during remount and apply it. Incase, no new value is
> > passed, use the value specified during initial mount.
> 
> Yup, here also ext4_parse_param() is called before __ext4_remount().
> Hence we should check if the user has passed it's value in mount opts, if not,
> only then we should use the task original ioprio.
Yes correct.
> 
> 
> I tested this patch and with the patch applied, the task ioprio can be correctly
> set using "journal_ioprio" mount option.
> 
> "Mount test"
> =============
> qemu-> sudo perf record -e probe:* -aR mount -o journal_ioprio=1 /dev/loop2 /mnt
> qemu-> ps -eaf |grep -E "jbd2|loop2"
> root        3506       2  0 07:41 ?        00:00:00 [jbd2/loop2-8]
> qemu-> sudo perf script
>            mount  3504 [000]  2503.106871: probe:ext4_parse_param_L222: (ffffffff8147817f) journal_ioprio=16385 spec=32
>            mount  3504 [000]  2503.106908: probe:__ext4_fill_super_L26: (ffffffff8147a650) journal_ioprio=16385 spec=32
> qemu-> ionice -p 3506
> best-effort: prio 1
> 
> "remount test"
> =================
> qemu-> sudo perf record -e probe:* -aR mount -o remount,journal_ioprio=0 /dev/loop2 /mnt
> qemu-> sudo perf script
>            mount  3519 [000]  2544.958850: probe:ext4_parse_param_L222: (ffffffff8147817f) journal_ioprio=16384 spec=32
>            mount  3519 [000]  2544.958860:    probe:__ext4_remount_L49: (ffffffff81479da2) journal_ioprio=16384 spec=32
> qemu-> ionice -p 3506
> best-effort: prio 0
> 
> "remount with no mount options"
> =================================
> qemu-> sudo perf record -e probe:* -aR mount -o remount /dev/loop2 /mnt
> qemu-> ionice -p 3506
> best-effort: prio 0
> qemu-> sudo perf script
>            mount  3530 [000]  2575.964048:    probe:__ext4_remount_L49: (ffffffff81479da2) journal_ioprio=16384 spec=0
> 
> 
> >
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> We should add fixes tag too. Can you please confirm if that would be this patch?
> "ext4: Completely separate options parsing and sb setup".
Yes, it does seem like this issue was intorduced in this particular
commit. I'll add the Fixes tag.
> 
> With that feel free to add below -
> 
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks again for the review. I'll wait for a bit to see if we have any
more reviews and then send a v2 with the suggested changes.

Regards,
Ojaswin
> 
> 
> -ritesh
> 
> > ---
> >  fs/ext4/super.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index c5a9ffbf7f4f..bfd767c51203 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -4427,7 +4427,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> >  	int silent = fc->sb_flags & SB_SILENT;
> >
> >  	/* Set defaults for the variables that will be set during parsing */
> > -	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
> > +	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO))
> > +		ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
> >
> >  	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
> >  	sbi->s_sectors_written_start =
> > @@ -6289,7 +6290,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
> >  	char *to_free[EXT4_MAXQUOTAS];
> >  #endif
> >
> > -	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
> >
> >  	/* Store the original options */
> >  	old_sb_flags = sb->s_flags;
> > @@ -6315,9 +6315,14 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
> >  		} else
> >  			old_opts.s_qf_names[i] = NULL;
> >  #endif
> > -	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
> > -		ctx->journal_ioprio =
> > -			sbi->s_journal->j_task->io_context->ioprio;
> > +	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO)) {
> > +		if (sbi->s_journal && sbi->s_journal->j_task->io_context)
> > +			ctx->journal_ioprio =
> > +				sbi->s_journal->j_task->io_context->ioprio;
> > +		else
> > +			ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
> > +
> > +	}
> >
> >  	ext4_apply_options(fc, sb);
> >
> > --
> > 2.27.0
> >
