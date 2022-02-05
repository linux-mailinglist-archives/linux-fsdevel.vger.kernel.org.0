Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA54AA830
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 11:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiBEKoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 05:44:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233542AbiBEKoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:44:00 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2157D0g1021870;
        Sat, 5 Feb 2022 10:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=YOw22ZCGom0TXvMV2tJ4l4PznnmJtecUrELZ4F1h9R0=;
 b=Oba6uVc0NIHZ2PZHK1I2Gqx6gYm9YcXHLr2df+fezaXcKwY0hfGMkgr7wFnMmTG9eWeM
 4p49M2VoNMwUR9qRAb7UAF70qanmL42I+p/5M3qyBj2rF2/wqTUEsf7EMASglrcACmTs
 CaQ551sMiRRsaAXqIIHd9ywGPUfD8Ecg+6FiU6L2xVUV2uaGWMDSp8S0uHK7udlaVdAr
 v42ML9e54pe3GGWbY4cUYmbcK0p5+Hl+Sa1pkObkpULfnG2fsQ5h4d61HsmcvN62ZHns
 FsgGvBXvNa2wr4at3Vv9o1QN1SgmQU9MkF+eG0g1kedUd3le5bwlbNqxnFZnXqDeib3p mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e1en8758m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 10:43:56 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215AeCL7019352;
        Sat, 5 Feb 2022 10:43:55 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e1en8758f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 10:43:55 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215AWr5h026466;
        Sat, 5 Feb 2022 10:43:53 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3e1gv8sddj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 10:43:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215AXr5L49414598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 10:33:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95F4E5204E;
        Sat,  5 Feb 2022 10:43:51 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 84A295204F;
        Sat,  5 Feb 2022 10:43:48 +0000 (GMT)
Date:   Sat, 5 Feb 2022 16:13:46 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [RFC 2/6] ext4: Implement ext4_group_block_valid() as common
 function
Message-ID: <20220205104346.fpzjm6bmakuv37km@riteshh-domain>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
 <40c85b86dd324a11c962843d8ef242780a84b25f.1643642105.git.riteshh@linux.ibm.com>
 <20220201113453.exaikdfsc3vubqel@quack3.lan>
 <20220204100844.ty23mdc5mfjbgiwj@riteshh-domain>
 <20220204114930.7n7z2zqhtkzmco3p@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204114930.7n7z2zqhtkzmco3p@quack3.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xskNxNiTyDW9_pKQn4t2hKW-T4smvpWs
X-Proofpoint-ORIG-GUID: s_LV5IpgygN046O2RElBpV6MqovmuQQT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_02,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=421 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050070
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/02/04 12:49PM, Jan Kara wrote:
> On Fri 04-02-22 15:38:44, Ritesh Harjani wrote:
> > On 22/02/01 12:34PM, Jan Kara wrote:
> > > On Mon 31-01-22 20:46:51, Ritesh Harjani wrote:
> > > > This patch implements ext4_group_block_valid() check functionality,
> > > > and refactors all the callers to use this common function instead.
> > > >
> > > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ...
> > >
> > > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > > index 8d23108cf9d7..60d32d3d8dc4 100644
> > > > --- a/fs/ext4/mballoc.c
> > > > +++ b/fs/ext4/mballoc.c
> > > > @@ -6001,13 +6001,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
> > > >  		goto error_return;
> > > >  	}
> > > >
> > > > -	if (in_range(ext4_block_bitmap(sb, gdp), block, count) ||
> > > > -	    in_range(ext4_inode_bitmap(sb, gdp), block, count) ||
> > > > -	    in_range(block, ext4_inode_table(sb, gdp),
> > > > -		     sbi->s_itb_per_group) ||
> > > > -	    in_range(block + count - 1, ext4_inode_table(sb, gdp),
> > > > -		     sbi->s_itb_per_group)) {
> > > > -
> > > > +	if (!ext4_group_block_valid(sb, block_group, block, count)) {
> > > >  		ext4_error(sb, "Freeing blocks in system zone - "
> > > >  			   "Block = %llu, count = %lu", block, count);
> > > >  		/* err = 0. ext4_std_error should be a no op */
> > >
> > > When doing this, why not rather directly use ext4_inode_block_valid() here?
> >
> > This is because while freeing these blocks we have their's corresponding block
> > group too. So there is little point in checking FS Metadata of all block groups
> > v/s FS Metadata of just this block group, no?
> >
> > Also, I am not sure if we changing this to check against system-zone's blocks
> > (which has FS Metadata blocks from all block groups), can add any additional
> > penalty?
>
> I agree the check will be somewhat more costly (rbtree lookup). OTOH with
> more complex fs structure (like flexbg which is default for quite some
> time), this is by far not checking the only metadata blocks, that can
> overlap the freed range. Also this is not checking for freeing journal
> blocks. So I'd either got for no check (if we really want performance) or
> full check (if we care more about detecting fs errors early). Because these
> half-baked checks do not bring much value these days...

Agreed. Thanks for putting out your points.
I am making these suggested changes to add stricter checking via
ext4_inode_block_valid() and will be sending out v1 soon.

-ritesh
