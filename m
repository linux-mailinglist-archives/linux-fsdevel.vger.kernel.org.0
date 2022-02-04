Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41B34A9777
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 11:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243358AbiBDKI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 05:08:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234330AbiBDKIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:08:55 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2147x9hr023912;
        Fri, 4 Feb 2022 10:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=iZDEhy/NiFHNyKm3O94Qbyibs0mtD/OXpCE8gCcS7VA=;
 b=P3Jmc+AJuB7r0VrkII+5/q1HAg/IKRhCxfsvV8kcIyo1Vd3rJ84mlF8GsRjnW1Jh5mnT
 0nIpWn+hMh8NSl3CZw+KPvbSSaQZjswE1hDyL+o7CJeKUZt6r+XvI4sXOU/oD6YziVWs
 Ki176MQDd+cWOf9YfcYWFCDthTeSVojE9KRAhNDmGs0YhfiM8EkFAQEznZiXXMnlyLha
 dfuwuMOC22AKeiJ9U6rplA+ghv1Etm/niVp3sZaGVw4xenk1IOF/aMl7TvMPVKO0YaLq
 yxvk2c5Z7GmXfekCEgJb4GqBVwk5T41oKyLi+gU2RNxwFONDkOAcMmeC8TNVBloEfdC3 Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0qxft3m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:08:50 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2149ixGa012267;
        Fri, 4 Feb 2022 10:08:50 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0qxft3ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:08:50 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214A7BHh002476;
        Fri, 4 Feb 2022 10:08:48 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3e0r0u3avh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:08:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214A8j4j40108542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 10:08:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCBDCA4054;
        Fri,  4 Feb 2022 10:08:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ACB1A4064;
        Fri,  4 Feb 2022 10:08:45 +0000 (GMT)
Received: from localhost (unknown [9.43.61.133])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 10:08:45 +0000 (GMT)
Date:   Fri, 4 Feb 2022 15:38:44 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [RFC 2/6] ext4: Implement ext4_group_block_valid() as common
 function
Message-ID: <20220204100844.ty23mdc5mfjbgiwj@riteshh-domain>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
 <40c85b86dd324a11c962843d8ef242780a84b25f.1643642105.git.riteshh@linux.ibm.com>
 <20220201113453.exaikdfsc3vubqel@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201113453.exaikdfsc3vubqel@quack3.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FUfWL4cNtv3hYdo_7EsBDY84iuqf8TD4
X-Proofpoint-ORIG-GUID: zMJWEXrYR61wFRp4z7SbRcO6YtSL6OQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=635 clxscore=1015 lowpriorityscore=0 adultscore=0 mlxscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040054
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/02/01 12:34PM, Jan Kara wrote:
> On Mon 31-01-22 20:46:51, Ritesh Harjani wrote:
> > This patch implements ext4_group_block_valid() check functionality,
> > and refactors all the callers to use this common function instead.
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ...
>
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 8d23108cf9d7..60d32d3d8dc4 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -6001,13 +6001,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
> >  		goto error_return;
> >  	}
> >
> > -	if (in_range(ext4_block_bitmap(sb, gdp), block, count) ||
> > -	    in_range(ext4_inode_bitmap(sb, gdp), block, count) ||
> > -	    in_range(block, ext4_inode_table(sb, gdp),
> > -		     sbi->s_itb_per_group) ||
> > -	    in_range(block + count - 1, ext4_inode_table(sb, gdp),
> > -		     sbi->s_itb_per_group)) {
> > -
> > +	if (!ext4_group_block_valid(sb, block_group, block, count)) {
> >  		ext4_error(sb, "Freeing blocks in system zone - "
> >  			   "Block = %llu, count = %lu", block, count);
> >  		/* err = 0. ext4_std_error should be a no op */
>
> When doing this, why not rather directly use ext4_inode_block_valid() here?

This is because while freeing these blocks we have their's corresponding block
group too. So there is little point in checking FS Metadata of all block groups
v/s FS Metadata of just this block group, no?

Also, I am not sure if we changing this to check against system-zone's blocks
(which has FS Metadata blocks from all block groups), can add any additional
penalty?

-riteshh

>
> > @@ -6194,11 +6188,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
> >  		goto error_return;
> >  	}
> >
> > -	if (in_range(ext4_block_bitmap(sb, desc), block, count) ||
> > -	    in_range(ext4_inode_bitmap(sb, desc), block, count) ||
> > -	    in_range(block, ext4_inode_table(sb, desc), sbi->s_itb_per_group) ||
> > -	    in_range(block + count - 1, ext4_inode_table(sb, desc),
> > -		     sbi->s_itb_per_group)) {
> > +	if (!ext4_group_block_valid(sb, block_group, block, count)) {
> >  		ext4_error(sb, "Adding blocks in system zones - "
> >  			   "Block = %llu, count = %lu",
> >  			   block, count);
>
> And here I'd rather refactor ext4_inode_block_valid() a bit to provide a
> more generic helper not requiring an inode and use it here...
>
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
