Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCDEA1477D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 06:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAXFEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 00:04:38 -0500
Received: from sonic310-22.consmr.mail.gq1.yahoo.com ([98.137.69.148]:32868
        "EHLO sonic310-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgAXFEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1579842276; bh=KxVB/E86lNKNhPTU2/RM2/D0ts46IDAvVmg873JVtI4=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=J9TObx8dEXgW7r+jATz5Yr4s7+z500v0s+p0CDTHFKdA73WjMIZOruK/shez9tLr/hBvzVDz+u0TKwhVf6JsJEGeS5ouRptFVF5KulTctzepq8K/DETAQm3BW/QhsGKWaqVHYcCLt+P5ZwSRbwxocDkZZ/m6oi72esrjpsFmBxOD4uqMhw9W3zIpUhPUPi/XSFxnBs0IZ/gbSVCHvIVOsy2TvW1ZwulXz/KSrM9U9VYWjLNEDff+qTlx/IB9vV/lC/iJG5Ux52oujcahCs7QXESkAKi0sSru/TUPxj4SH3utCNX7RP6anjdPvgFKibVt/YH6loZQXPVLGMDzvUlXXw==
X-YMail-OSG: Uc6NeP0VM1nmfwyyfJft38JRGlFtmVIVadugRNgCQQPlasdldofbxmv9XY2SRRv
 c2XF9DV4wrM.lSl37DCJxJwA1ZN1_PbrZtOBJ5MayiXI9WNdNe.L1yGEg1MKDMwwTkDPTrkTd3pp
 5eqh56aDCNt179q4wX85kLpW4xjtpZ1SMtNKHouolgA9cuXn1v38WKfJjLsma9GdxFwgpJ3.1dYn
 Qk_uSCEHt7tnNIp33CXea3xOLhkJWPUwgSvaK2oaPHwQGRjSYigyzwG8KIn0EpBOVYONWHM404iQ
 SWDRrn292EKpMLFmxrAiE3bmy0j0aUHt2BFDfr5a_ncZnAPf5.5RFc3NVlpBeIF.E3NLHbNggfVk
 Er_gw2QUtgyTFMcGUFKHJ2DAcZC5cbWNuvYgrwRxotUGXGAXinwRvvTlGwjc48qj5eY1q.dn4nyl
 COt_c_kB07JsC7dkQkym.GCzUgCswzVPM5X.jn0iv2cpR5PAf2yMwIgnkEolm4PxaUVs4kcE2D7v
 EI2UB6XQoL_zIIww242AooZQNqhzYOokrZZmyAOSF2YPcVzNFRsTEPIfbSslre_gSBaZz.JeMi.d
 oJy3Tv3j6BJYDLxuecH3iWuFVOYTbYeud3hCHm_MxquPLevVAr_B_WIoanZ6C7WtAtRuCOTygDR5
 jD2WFZbXv5xHy1pevldBj9R6eTQefam9xzuqaNTnAwrtjdR4FjtJnczb2lJnEXQNJH1TKNTMouDU
 DneHw3RhQT73gIcK8jGxBC_EoG31Fx9q8ORa4G8PSu62GvuWhsyt7.WZTly1CZCo.kDN6zq2weLm
 vjxw74U73JRTFVb0bWi2TMxWSJWP.dcyXaGyAmQ3jmd5_Tf8lDgOK3jf6iESV4T62w2VrP6xR2cO
 9FN3aWwDMTu__52XTnQFlwZac2G00._Rx3JzWuQ8BTthW.Crl8RWFyfnm2bhk.ZfEjBLDQ3tv4Mz
 pmE7Lx61eSR46OzfqBD7INCLnP9g5HNHTug8vpXuCxza359Nk5t5Z7_ODqvCN_gyiRCvqAGsjPgR
 eC23JS3CpGagk7tcXhv4lOySQBng48w7csOecCr5EAK8djklj0crKAz9NbZgGS55q47ZSbEEh5uV
 ulqtzrz0mmPl0fJux3.ApAVOwpUu03rINtyqr4R7fe7fVBGE5aSa_tx7aLb2qBzuXFSvMie2qyxA
 MFvQhSzAhTGN0_akTcpm6KuGZbqGt4OURebaUVffRFXoERRSOFQJQIOuPZW2XA3ELlagAy_qZkH1
 zWyDpETlchCSf0DUl_hpU5nD9o6rrY03LZfDqCF1G8C1l0RUgpxvp.4CQ1mUoOFDL93oXSkbjnwS
 DeOnHjBHxAkGJfexW8YD0mWiDo5y7ihu24KoLaBmD3bdD6PuP2mnYu9Y96Z_idwkl3IHLO2QpWku
 U8MKFwC7nHgeBhYJQwAqetIjP_3Zb7pql9YY1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 24 Jan 2020 05:04:36 +0000
Received: by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID da8cd968291b387cfb3bcafe1576746f;
          Fri, 24 Jan 2020 05:04:32 +0000 (UTC)
Date:   Fri, 24 Jan 2020 13:04:25 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] ext4: fix race conditions in ->d_compare() and ->d_hash()
Message-ID: <20200124050423.GA31271@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200124041234.159740-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124041234.159740-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

On Thu, Jan 23, 2020 at 08:12:34PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since ->d_compare() and ->d_hash() can be called in RCU-walk mode,
> ->d_parent and ->d_inode can be concurrently modified, and in
> particular, ->d_inode may be changed to NULL.  For ext4_d_hash() this
> resulted in a reproducible NULL dereference if a lookup is done in a
> directory being deleted, e.g. with:
> 
> 	int main()
> 	{
> 		if (fork()) {
> 			for (;;) {
> 				mkdir("subdir", 0700);
> 				rmdir("subdir");
> 			}
> 		} else {
> 			for (;;)
> 				access("subdir/file", 0);
> 		}
> 	}
> 
> ... or by running the 't_encrypted_d_revalidate' program from xfstests.
> Both repros work in any directory on a filesystem with the encoding
> feature, even if the directory doesn't actually have the casefold flag.
> 
> I couldn't reproduce a crash in ext4_d_compare(), but it appears that a
> similar crash is possible there.
> 
> Fix these bugs by reading ->d_parent and ->d_inode using READ_ONCE() and
> falling back to the case sensitive behavior if the inode is NULL.
> 
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
> Cc: <stable@vger.kernel.org> # v5.2+
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/ext4/dir.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 8964778aabefb..0129d14629881 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -671,9 +671,11 @@ static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
>  			  const char *str, const struct qstr *name)
>  {
>  	struct qstr qstr = {.name = str, .len = len };
> -	struct inode *inode = dentry->d_parent->d_inode;
> +	const struct dentry *parent = READ_ONCE(dentry->d_parent);

I'm not sure if we really need READ_ONCE d_parent here (p.s. d_parent
won't be NULL anyway), and d_seq will guard all its validity. If I'm
wrong, correct me kindly...

Otherwise, it looks good to me...
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang


> +	const struct inode *inode = READ_ONCE(parent->d_inode);
>  
> -	if (!IS_CASEFOLDED(inode) || !EXT4_SB(inode->i_sb)->s_encoding) {
> +	if (!inode || !IS_CASEFOLDED(inode) ||
> +	    !EXT4_SB(inode->i_sb)->s_encoding) {
>  		if (len != name->len)
>  			return -1;
>  		return memcmp(str, name->name, len);
> @@ -686,10 +688,11 @@ static int ext4_d_hash(const struct dentry *dentry, struct qstr *str)
>  {
>  	const struct ext4_sb_info *sbi = EXT4_SB(dentry->d_sb);
>  	const struct unicode_map *um = sbi->s_encoding;
> +	const struct inode *inode = READ_ONCE(dentry->d_inode);
>  	unsigned char *norm;
>  	int len, ret = 0;
>  
> -	if (!IS_CASEFOLDED(dentry->d_inode) || !um)
> +	if (!inode || !IS_CASEFOLDED(inode) || !um)
>  		return 0;
>  
>  	norm = kmalloc(PATH_MAX, GFP_ATOMIC);
> -- 
> 2.25.0
> 
