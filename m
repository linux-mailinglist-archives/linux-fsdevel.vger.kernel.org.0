Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FB74A977D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 11:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358173AbiBDKKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 05:10:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234330AbiBDKKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:10:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2149VklU023410;
        Fri, 4 Feb 2022 10:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1DDfczcJG7EjgmY5fxQ6QZ/8SWEoB4n5YVmy+4NtpmE=;
 b=Epda695Asm0C5gtco54Ib6oI0n8j1X0UxJi2c8XfwmgZk9N2Zboo4mkh7jWpj7nFGEFD
 FDgFvOQMi9zkBHgUMWdEEjFmTx8eNhHlcROQqrtDlwMwY6TOPT7fAcnH7Wlr1C0Z7v2r
 bivuXwUEmmxn8bvln4P0FND8cjbJ6hQ3AB43CebeO3ZaHho4C4rLFYmjN7xcLCkRAoXK
 6XLFTaJo0/6lX0ZI6IbfliXuUdwPinPGCMsn1qwfWXCcIiK1VUjiQNunFow80vvBn+pi
 G3lbDltd9QT+gpMYjaIeiAJmbuENHZ2QSt4m2/ZjxLPmOKsmyE3HigaYZBau2zPZ8CTk ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0vrrnuq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:10:14 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2149Un8R003039;
        Fri, 4 Feb 2022 10:10:14 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0vrrnupm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:10:13 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214A5UTt008758;
        Fri, 4 Feb 2022 10:10:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3e0r10bgdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:10:12 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214AAAt942074592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 10:10:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E86BA52059;
        Fri,  4 Feb 2022 10:10:09 +0000 (GMT)
Received: from localhost (unknown [9.43.61.133])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7528F5204E;
        Fri,  4 Feb 2022 10:10:09 +0000 (GMT)
Date:   Fri, 4 Feb 2022 15:40:08 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [RFC 4/6] ext4: No need to test for block bitmap bits in
 ext4_mb_mark_bb()
Message-ID: <20220204101008.xjqxsqmxzqtzrztj@riteshh-domain>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
 <65ffc304d66815b6e3270f71e5d756b307d3c5be.1643642105.git.riteshh@linux.ibm.com>
 <20220201113828.coe2l74skdoyrlzz@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201113828.coe2l74skdoyrlzz@quack3.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BST1gf4-5aMRGTumlGk_vO6Ej4Cnc1ek
X-Proofpoint-ORIG-GUID: NemrVu_ndVq9Z3vGjMzFYK5eInJshF4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=873 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040054
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/02/01 12:38PM, Jan Kara wrote:
> On Mon 31-01-22 20:46:53, Ritesh Harjani wrote:
> > We don't need the return value of mb_test_and_clear_bits() in ext4_mb_mark_bb()
> > So simply use mb_clear_bits() instead.
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> Looks good. I'm rather confused by ext4_set_bits() vs mb_clear_bits()
> asymetry but that's not directly related to this patch. Just another
> cleanup to do. Feel free to add:

Yes, make sense. Looking at ext4_set_bits(), I think it should be renamed to
mb_set_bits() for uniform API conventions.

>
> Reviewed-by: Jan Kara <jack@suse.cz>
>

Thanks :)

> 								Honza
>
> > ---
> >  fs/ext4/mballoc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 60d32d3d8dc4..2f931575e6c2 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -3943,7 +3943,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
> >  	if (state)
> >  		ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
> >  	else
> > -		mb_test_and_clear_bits(bitmap_bh->b_data, blkoff, clen);
> > +		mb_clear_bits(bitmap_bh->b_data, blkoff, clen);
> >  	if (ext4_has_group_desc_csum(sb) &&
> >  	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> >  		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
