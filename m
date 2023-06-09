Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E537297A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 12:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbjFIK6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 06:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjFIK6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:58:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C0D1FF3;
        Fri,  9 Jun 2023 03:58:20 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359AlmNA016554;
        Fri, 9 Jun 2023 10:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=knzNZL3FfdsawENWl8mQ/5isnk7TPntTlJ/uCLzF0CA=;
 b=Ucb9nnGpA3bOfh5aX9+3VIHEqcgxYM57qZd1dkQ3KpEtGbae8gyN7LFsW11LrLzVR/fw
 7FTI6YDZFNeGpm93tJhr//yyR+IH7uOUEr9pz/PGGLOjRrsmKiLYLk5qCX2m7gWMkq/B
 D41pFZmtlMpz6jVlHi7/E4Qz/zWd3z0cRaX9x5lEUQdS2mG1SpB08JjK4TBi0DPI5U9n
 q9GbsSvB61dEfkmTVS0OxPp8kHll9Sn4UkooAyGRYQXRd0hiVD6lDqaLpRz8rcEpZ5v8
 p+7q+G4hEA3RoRBrUcR45P1DRJ6uhp2QPiMPOvQ0Cfr69rrEZUiDpdRuWr/ysz1p7hmU pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r42mtr70s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 10:58:09 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359Ao8kZ023985;
        Fri, 9 Jun 2023 10:58:08 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r42mtr701-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 10:58:08 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3592X3uC009666;
        Fri, 9 Jun 2023 10:58:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r2a769wjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 10:58:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 359Aw3Oo18809352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jun 2023 10:58:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFE652004B;
        Fri,  9 Jun 2023 10:58:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C9BB20040;
        Fri,  9 Jun 2023 10:58:02 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.5.119])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Jun 2023 10:58:01 +0000 (GMT)
Date:   Fri, 9 Jun 2023 16:27:59 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 11/12] ext4: Add allocation criteria 1.5 (CR1_5)
Message-ID: <ZIMFk5d17TPNgS4v@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
 <150fdf65c8e4cc4dba71e020ce0859bcf636a5ff.1685449706.git.ojaswin@linux.ibm.com>
 <20230607102103.gavbiywdudx54opk@quack3>
 <20230608144505.GA1422249@mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608144505.GA1422249@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5kpqiHdartRibfM8eygJz2heEqLRgH0A
X-Proofpoint-GUID: S-6cV6kB9I631U3WRA1rtig79SfRmo43
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:45:05AM -0400, Theodore Ts'o wrote:
> Jan, thanks for the comments to Ojaswin's patch series.  Since I had
> already landed his patch series in my tree and have been testing it,
> I've fixed the obvious issues you've raised in a fixup patch
> (attached).
> 
> There is one issue which I have not fixed:
> 
> On Wed, Jun 07, 2023 at 12:21:03PM +0200, Jan Kara wrote:
> > > +	for (i = order; i >= min_order; i--) {
> > > +		int frag_order;
> > > +		/*
> > > +		 * Scale down goal len to make sure we find something
> > > +		 * in the free fragments list. Basically, reduce
> > > +		 * preallocations.
> > > +		 */
> > > +		ac->ac_g_ex.fe_len = 1 << i;
> > 
> > I smell some off-by-one issues here. Look fls(1) == 1 so (1 << fls(n)) > n.
> > Hence this loop will actually *grow* the goal allocation length. Also I'm
> > not sure why you have +1 in min_order = fls(ac->ac_o_ex.fe_len) + 1.
> 
> Ojaswin, could you take a look this?  Thanks!!
> 
> 	       	   	       	      - Ted
> 
> commit 182d2d90a180838789ed5a19e08c333043d1617a
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Thu Jun 8 10:39:35 2023 -0400
> 
>     ext4: clean up mballoc criteria comments
>     
>     Line wrap and slightly clarify the comments describing mballoc's
>     cirtiera.
>     
>     Define EXT4_MB_NUM_CRS as part of the enum, so that it will
>     automatically get updated when criteria is added or removed.
>     
>     Also fix a potential unitialized use of 'cr' variable if
>     CONFIG_EXT4_DEBUG is enabled.
>     
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Hi Ted, 

Patch looks good, thanks for doing this. I've sent the fix
for the off by one issue here:

https://lore.kernel.org/linux-ext4/20230609103403.112807-1-ojaswin@linux.ibm.com/T/#u

Jan, thanks for the review. I've addressed the bug for now. Since
I'm on vacation for the next one and a half week I might not be able to
address the other cleanups. I'll get them done once I'm back.

Regards,
ojaswin
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 6a1f013d23f7..45a531446ea2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -128,47 +128,52 @@ enum SHIFT_DIRECTION {
>  };
>  
>  /*
> - * Number of criterias defined. For each criteria, mballoc has slightly
> - * different way of finding the required blocks nad usually, higher the
> - * criteria the slower the allocation. We start at lower criterias and keep
> - * falling back to higher ones if we are not able to find any blocks.
> - */
> -#define EXT4_MB_NUM_CRS 5
> -/*
> - * All possible allocation criterias for mballoc. Lower are faster.
> + * For each criteria, mballoc has slightly different way of finding
> + * the required blocks nad usually, higher the criteria the slower the
> + * allocation.  We start at lower criterias and keep falling back to
> + * higher ones if we are not able to find any blocks.  Lower (earlier)
> + * criteria are faster.
>   */
>  enum criteria {
>  	/*
> -	 * Used when number of blocks needed is a power of 2. This doesn't
> -	 * trigger any disk IO except prefetch and is the fastest criteria.
> +	 * Used when number of blocks needed is a power of 2. This
> +	 * doesn't trigger any disk IO except prefetch and is the
> +	 * fastest criteria.
>  	 */
>  	CR_POWER2_ALIGNED,
>  
>  	/*
> -	 * Tries to lookup in-memory data structures to find the most suitable
> -	 * group that satisfies goal request. No disk IO except block prefetch.
> +	 * Tries to lookup in-memory data structures to find the most
> +	 * suitable group that satisfies goal request. No disk IO
> +	 * except block prefetch.
>  	 */
>  	CR_GOAL_LEN_FAST,
>  
>          /*
> -	 * Same as CR_GOAL_LEN_FAST but is allowed to reduce the goal length to
> -         * the best available length for faster allocation.
> +	 * Same as CR_GOAL_LEN_FAST but is allowed to reduce the goal
> +         * length to the best available length for faster allocation.
>  	 */
>  	CR_BEST_AVAIL_LEN,
>  
>  	/*
> -	 * Reads each block group sequentially, performing disk IO if necessary, to
> -	 * find find_suitable block group. Tries to allocate goal length but might trim
> -	 * the request if nothing is found after enough tries.
> +	 * Reads each block group sequentially, performing disk IO if
> +	 * necessary, to find find_suitable block group. Tries to
> +	 * allocate goal length but might trim the request if nothing
> +	 * is found after enough tries.
>  	 */
>  	CR_GOAL_LEN_SLOW,
>  
>  	/*
> -	 * Finds the first free set of blocks and allocates those. This is only
> -	 * used in rare cases when CR_GOAL_LEN_SLOW also fails to allocate
> -	 * anything.
> +	 * Finds the first free set of blocks and allocates
> +	 * those. This is only used in rare cases when
> +	 * CR_GOAL_LEN_SLOW also fails to allocate anything.
>  	 */
>  	CR_ANY_FREE,
> +
> +	/*
> +	 * Number of criterias defined.
> +	 */
> +	EXT4_MB_NUM_CRS
>  };
>  
>  /* criteria below which we use fast block scanning and avoid unnecessary IO */
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 8a6896d4e9b0..2f9f5dc720cc 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2759,7 +2759,7 @@ static noinline_for_stack int
>  ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  {
>  	ext4_group_t prefetch_grp = 0, ngroups, group, i;
> -	enum criteria cr, new_cr;
> +	enum criteria new_cr, cr = CR_GOAL_LEN_FAST;
>  	int err = 0, first_err = 0;
>  	unsigned int nr = 0, prefetch_ios = 0;
>  	struct ext4_sb_info *sbi;
> @@ -2816,12 +2816,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  		spin_unlock(&sbi->s_md_lock);
>  	}
>  
> -	/* Let's just scan groups to find more-less suitable blocks */
> -	cr = ac->ac_2order ? CR_POWER2_ALIGNED : CR_GOAL_LEN_FAST;
>  	/*
> -	 * cr == CR_POWER2_ALIGNED try to get exact allocation,
> -	 * cr == CR_ANY_FREE try to get anything
> +	 * Let's just scan groups to find more-less suitable blocks We
> +	 * start with CR_GOAL_LEN_FAST, unless it is power of 2
> +	 * aligned, in which case let's do that faster approach first.
>  	 */
> +	if (ac->ac_2order)
> +		cr = CR_POWER2_ALIGNED;
>  repeat:
>  	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
>  		ac->ac_criteria = cr;
