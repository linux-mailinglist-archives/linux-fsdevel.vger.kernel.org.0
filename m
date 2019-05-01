Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 599E1108F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 16:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfEAOVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 10:21:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726501AbfEAOVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 10:21:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41E992Z140344
        for <linux-fsdevel@vger.kernel.org>; Wed, 1 May 2019 10:21:32 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s7cuurra2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 10:21:32 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Wed, 1 May 2019 15:21:30 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 15:21:27 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41ELQbC52691046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 14:21:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E86B4204C;
        Wed,  1 May 2019 14:21:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BDB84204F;
        Wed,  1 May 2019 14:21:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.136])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 May 2019 14:21:24 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V2 12/13] fscrypt_zeroout_range: Encrypt all zeroed out blocks of a page
Date:   Wed, 01 May 2019 19:52:02 +0530
Organization: IBM
In-Reply-To: <20190430165114.GA48973@gmail.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com> <20190428043121.30925-13-chandan@linux.ibm.com> <20190430165114.GA48973@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19050114-4275-0000-0000-000003304E6B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050114-4276-0000-0000-0000383FAABA
Message-Id: <5118219.DRdbvtsWY3@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010091
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday, April 30, 2019 10:21:15 PM IST Eric Biggers wrote:
> On Sun, Apr 28, 2019 at 10:01:20AM +0530, Chandan Rajendra wrote:
> > For subpage-sized blocks, this commit adds code to encrypt all zeroed
> > out blocks mapped by a page.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > ---
> >  fs/crypto/bio.c | 40 ++++++++++++++++++----------------------
> >  1 file changed, 18 insertions(+), 22 deletions(-)
> > 
> > diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> > index 856f4694902d..46dd2ec50c7d 100644
> > --- a/fs/crypto/bio.c
> > +++ b/fs/crypto/bio.c
> > @@ -108,29 +108,23 @@ EXPORT_SYMBOL(fscrypt_pullback_bio_page);
> >  int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
> >  				sector_t pblk, unsigned int len)
> >  {
> > -	struct fscrypt_ctx *ctx;
> >  	struct page *ciphertext_page = NULL;
> >  	struct bio *bio;
> > +	u64 total_bytes, page_bytes;
> 
> page_bytes should be 'unsigned int', since it's <= PAGE_SIZE.
> 
> >  	int ret, err = 0;
> >  
> > -	BUG_ON(inode->i_sb->s_blocksize != PAGE_SIZE);
> > -
> > -	ctx = fscrypt_get_ctx(inode, GFP_NOFS);
> > -	if (IS_ERR(ctx))
> > -		return PTR_ERR(ctx);
> > +	total_bytes = len << inode->i_blkbits;
> 
> Should cast len to 'u64' here, in case it's greater than UINT_MAX / blocksize.
> 
> >  
> > -	ciphertext_page = fscrypt_alloc_bounce_page(ctx, GFP_NOWAIT);
> > -	if (IS_ERR(ciphertext_page)) {
> > -		err = PTR_ERR(ciphertext_page);
> > -		goto errout;
> > -	}
> > +	while (total_bytes) {
> > +		page_bytes = min_t(u64, total_bytes, PAGE_SIZE);
> >  
> > -	while (len--) {
> > -		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk,
> > -					     ZERO_PAGE(0), ciphertext_page,
> > -					     PAGE_SIZE, 0, GFP_NOFS);
> > -		if (err)
> > +		ciphertext_page = fscrypt_encrypt_page(inode, ZERO_PAGE(0),
> > +						page_bytes, 0, lblk, GFP_NOFS);
> > +		if (IS_ERR(ciphertext_page)) {
> > +			err = PTR_ERR(ciphertext_page);
> > +			ciphertext_page = NULL;
> >  			goto errout;
> > +		}
> 
> 'ciphertext_page' is leaked after each loop iteration.  Did you mean to free it,
> or did you mean to reuse it for subsequent iterations?

Thanks for pointing this out. I actually meant to free it. I will see if I can
reuse ciphertext_page in my next patchset rather than freeing and allocating
it each time the loop is executed.

> 
> >  
> >  		bio = bio_alloc(GFP_NOWAIT, 1);
> >  		if (!bio) {
> > @@ -141,9 +135,8 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
> >  		bio->bi_iter.bi_sector =
> >  			pblk << (inode->i_sb->s_blocksize_bits - 9);
> 
> This line uses ->s_blocksize_bits, but your new code uses ->i_blkbits.  AFAIK
> they'll always be the same, but please pick one or the other to use.

I will fix this.

> 
> >  		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> > -		ret = bio_add_page(bio, ciphertext_page,
> > -					inode->i_sb->s_blocksize, 0);
> > -		if (ret != inode->i_sb->s_blocksize) {
> > +		ret = bio_add_page(bio, ciphertext_page, page_bytes, 0);
> > +		if (ret != page_bytes) {
> >  			/* should never happen! */
> >  			WARN_ON(1);
> >  			bio_put(bio);
> > @@ -156,12 +149,15 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
> >  		bio_put(bio);
> >  		if (err)
> >  			goto errout;
> > -		lblk++;
> > -		pblk++;
> > +
> > +		lblk += page_bytes >> inode->i_blkbits;
> > +		pblk += page_bytes >> inode->i_blkbits;
> > +		total_bytes -= page_bytes;
> >  	}
> >  	err = 0;
> >  errout:
> > -	fscrypt_release_ctx(ctx);
> > +	if (!IS_ERR_OR_NULL(ciphertext_page))
> > +		fscrypt_restore_control_page(ciphertext_page);
> >  	return err;
> >  }
> >  EXPORT_SYMBOL(fscrypt_zeroout_range);
> 
> 


-- 
chandan



