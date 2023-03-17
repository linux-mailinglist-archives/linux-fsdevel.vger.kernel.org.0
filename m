Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CAF6BE756
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 11:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCQKz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 06:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQKzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:55:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AF9DDF35;
        Fri, 17 Mar 2023 03:55:23 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HAe8Pk020672;
        Fri, 17 Mar 2023 10:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RUMpbwc4wqUe3MjJ+ltbvkY9rJ1XIpkrtSkNguYYYYU=;
 b=GkYkcWuhW0C7LoU/lfin6dQFbRnhkxk2RMY1SKZNC5RXfjqx6hX+D6vttucVH/4IpdXO
 h1/2E/MRsRoKkblDQSklJmp/47WjOBX/HLUHRGzNZGgJRJS3es0hLBZzka86kvhF46Sp
 UgPdk+hcODiPSvZxKZe0Z8aVwCKY5jzMLFcmJnn9J2NJQV3CUre5eFHsGls9Xfylyqjt
 d/o44ljsO/m+H+oD1iLNGXwJ1hc8e95u4/E1FAy/TkvmKA3e6u89BbZbLuHGZiBgLaCP
 LgutpWPoXys1I8NIvT+u0yvNx3DwLsCOKD6yg+RAh5HULP9qLnXtQp3J7QGnKuxMK+1c mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcjfhpwc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 10:55:19 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32HAeZfB022275;
        Fri, 17 Mar 2023 10:55:18 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcjfhpwbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 10:55:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32H6uoAx022101;
        Fri, 17 Mar 2023 10:55:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pbsvb210m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 10:55:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32HAtEkQ8258098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 10:55:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A0792004B;
        Fri, 17 Mar 2023 10:55:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A01B20049;
        Fri, 17 Mar 2023 10:55:12 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.91.202])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Mar 2023 10:55:12 +0000 (GMT)
Date:   Fri, 17 Mar 2023 16:25:04 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [RFC 08/11] ext4: Don't skip prefetching BLOCK_UNINIT groups
Message-ID: <ZBRHCHySeQ0KC/f7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <4881693a4f5ba1fed367310b27c793e4e78520d3.1674822311.git.ojaswin@linux.ibm.com>
 <20230309141422.b2nbl554ngna327k@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309141422.b2nbl554ngna327k@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D9YVdtmD-D3rJBeAV2lkCzxwOK-kRLei
X-Proofpoint-ORIG-GUID: JTnpt8bXAF7aeoR6KCJMuv1bUoA8YMJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_06,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:14:22PM +0100, Jan Kara wrote:
> On Fri 27-01-23 18:07:35, Ojaswin Mujoo wrote:
> > Currently, ext4_mb_prefetch() and ext4_mb_prefetch_fini() skip
> > BLOCK_UNINIT groups since fetching their bitmaps doesn't need disk IO.
> > As a consequence, we end not initializing the buddy structures and CR0/1
> > lists for these BGs, even though it can be done without any disk IO
> > overhead. Hence, don't skip such BGs during prefetch and prefetch_fini.
> > 
> > This improves the accuracy of CR0/1 allocation as earlier, we could have
> > essentially empty BLOCK_UNINIT groups being ignored by CR0/1 due to their buddy
> > not being initialized, leading to slower CR2 allocations. With this patch CR0/1
> > will be able to discover these groups as well, thus improving performance.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> The patch looks good. I just somewhat wonder - this change may result in
> uninitialized groups being initialized and used earlier (previously we'd
> rather search in other already initialized groups) which may spread
> allocations more. But I suppose that's fine and uninit groups are not
> really a feature meant to limit fragmentation and as the filesystem ages
> the differences should be minimal. So feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
Thanks for the review. As for the allocation spread, I agree that it
should be something our goal determination logic should take care of
rather than limiting the BGs available to the allocator.

Another point I wanted to discuss wrt this patch series was why were the
BLOCK_UNINIT groups not being prefetched earlier. One point I can think
of is that this might lead to memory pressure when we have too many
empty BGs in a very large (say terabytes) disk.

But i'd still like to know if there's some history behind not
prefetching block uninit.

Cc'ing Andreas as well to check if they came across anything in Lustre
in the past.
> 
> > ---
> >  fs/ext4/mballoc.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 14529d2fe65f..48726a831264 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -2557,9 +2557,7 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
> >  		 */
> >  		if (!EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
> >  		    EXT4_MB_GRP_NEED_INIT(grp) &&
> > -		    ext4_free_group_clusters(sb, gdp) > 0 &&
> > -		    !(ext4_has_group_desc_csum(sb) &&
> > -		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
> > +		    ext4_free_group_clusters(sb, gdp) > 0 ) {
> >  			bh = ext4_read_block_bitmap_nowait(sb, group, true);
> >  			if (bh && !IS_ERR(bh)) {
> >  				if (!buffer_uptodate(bh) && cnt)
> > @@ -2600,9 +2598,7 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
> >  		grp = ext4_get_group_info(sb, group);
> >  
> >  		if (EXT4_MB_GRP_NEED_INIT(grp) &&
> > -		    ext4_free_group_clusters(sb, gdp) > 0 &&
> > -		    !(ext4_has_group_desc_csum(sb) &&
> > -		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
> > +		    ext4_free_group_clusters(sb, gdp) > 0) {
> >  			if (ext4_mb_init_group(sb, group, GFP_NOFS))
> >  				break;
> >  		}
> > -- 
> > 2.31.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
