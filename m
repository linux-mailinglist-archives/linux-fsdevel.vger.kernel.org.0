Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F7678F5F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 01:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345619AbjHaXGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 19:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345205AbjHaXGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:06:09 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B52CD6
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 16:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693523163; bh=IKjdHSoMLXSBm/VJ2hHyu0MclhV3JrrnQG299THmcqA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Wu6QLDOnBYszMCHU6EMSkNk16HPayMjyLX0N7KAtCKFYTZbHN1FnIfq0140IoAcrt0BArxmaaQ5XZF/orWYAJ+PQUixIKXpV0P5M3SqBNXwOVieBdRfQFgOqlNNW1PIb+EqruBnw/df5HqODTUS4WpKBNUtr3li7poc2yTPWke+UP6Z/hKDmZ4eqs79E9vxcOj13eMlCVahXBBSpfvlbg+XaYTT4OBrMnYHFucIiwOX4DP916ORPbmkhyIFycfjyJ5MJge5zZAjVKGHYj2tx/sd9J7xJGoTLXkUS6GAI9ntKofdMJ4oSr4EylaSYG1El8Q+vZqVlnUGUG7ganX/7Ng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693523163; bh=+IqfpZmmMv3417Jr2579Jz9wRiieGVpSjfIEwkr/I1n=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hLHahi0nco00Yg4aimF3/0zwmoGq/VJBabQ0RJVkVlFDComgleSShwLol1/7QPv9i0FG8aoeDrWRXRumepooSBVGOttDfaShTB6B84T2IX1dpnbOJWlzktc/PvUtVtcw7jY12s6JG5RNHrr+v/4KzSFI2EHKtz1ZPHXd0799TJRmZradrauUBWrbDO41Ig68QMkrnsN7iSB9SmMOYvN7JIj/9AtO9j6F/eDvQERSNoKhErJ7K3y4bxBuBvX0DKkiGfFsehFBRnb7nm2snQ5LSQU589eaZxCahdq0TlkpkbOkzFSehYvZjDq6cj4kQLlvI/CHvcnXxFhsmfZfX7D0Dg==
X-YMail-OSG: lsoW0M4VM1mZpCb3UWHQrf2oXOhf7LnzxsmX_NozGqDdf_St.WQA7oJAiZR79Mn
 h3RAhestktmzqQH4IAefdeFg24fr1nbNV6tZSNta0glSeGivS8NykMkMjcCClxDVl7bXgiXhWrcO
 VqtjTy0V14EhdbkEybujxkBdQL3wEAwK2MTikVriPzpICV0eCCx67wX1QaejO44sENfo1GepD60Q
 ubATjtVTaBzEEqMf2p8OwdV6iclFzVRJIPh4anuGumZ0FP8IZSPiD2EzAFrfrrhJhE3xA0oWK9uc
 dTYNjtkrFe7zQcBRVsgLuQHpLxlO9hGgQrr2fRvB55Ov7xyf8ZkldNNTuF9GaT8wDY8rRHp0_C53
 Ousp0W179UMJStYxWeDeOpr6ZiHsW9YfsGgj7jTKj7kD1xCfE95DgV5o1N_igCphIOOIrmkeYl_W
 3cwDpm7YjLvk_n6n8w2weCjM4k_AP_LfeL5I8UNK95DNQGdw1oCdu3YYAZ_t3tZDcOnb9As1J.aF
 cTfYj9ylbmiXplV.yxBZyurFwEZ9ha4DQlJnhFj0CkQc.V8rsRq2XBcCQ07y6W6qCuWNxTKtvEkm
 cJ2P.vTxDOFHvblmoYiq2L82Oy5b5KEhgY1jiakKgXln1TWu02yp18GEr02G.tGmlRQd54KPBbjW
 aJdRWk8vjibAyshyJhBX0hlf09BH7vnmMTQg8f.7jjqrXGJsEqi8ALwG_uOxXPf6QCy7tVrJY4yi
 zO6t1G4TbhTqRvkNnF3nmreQcFybBx3l9fT1u74g2rR0FkH7RCL_OY6hQEAp_feViGPJ5rodvjWW
 9vJCNHhVKNl.ETz4.NRBVBHt2pnojJmssptsKPyncgxsKqmxiGk.H_2goXUyUa6N0tvlfr1s4VVc
 4kw48XHaal9PhgC_kV0xU6CTFmoXrVi38PXojQiaUubs_cw8ph519g.LWdCDhZeBGxGlyoFjwFvC
 4_iNZ.xciaQgUYFw1jwjOwokggHI9W2GVR3bGfsrfIp7gHb6beFC9AQhy3nSbewcpwR7gJEp9Ggu
 vazk9ARL9abKJBHsi3dvws1kZCcKsmQStCV33hYORnfnYrvpXTMOY1E0UU.ZqrSPSKETokL0vajK
 0bh0xMcIdvt8re1kv7JK8kRqmhuWaDzWQFQkHOOCHXADfBG3ByHBnusLMElzZmIfYlO26E9TYwRr
 ewupwESRSEEeLH0CV5l8aSULZ192bJ66.D2pb4KQhNoKsdTyIhtOi.vVtpOLG5mE0Mht_uLPbSXH
 k2AMkTBylEGrPVjirL_dgVjvMWLsI.erllhcQY60SHR8dKRtdBAGw2BBG8KAydfWGVgihjiv3qdf
 4XQJlxpAOeXsGU5.kva8QeKUKIwfwwAV6FLXzpgPo5xXCTDp3QtDI5Qdx10.Edjl8m1nZCrvMlwn
 LJXI_QmpqlgbRrwxcSKJ1QVtc0951KDoI0r2s5jc0_a0Zf6oLnWFuFsYJU7B7fKSWzKSWrRj5DNl
 mKWmWiTst40u4.il6ihJ0UwW0sMvMpp1BMPSEcvaoZT.cyx0tld4.mTLpSldS6A1lGpWUs1BZ60R
 IZyRIh5uek8UGjOJyt21g.xiqJ6ZjTuoRhOPcnUJQp4k4YLb8kkn5rbE.8zTcwmQ1NUbJvY7XQ32
 RDYBYC4S65DcMiUMs.mfMPlzXUTr2L8_5y7wrXUjMK7NToy4wbc_cZGxeyVY7ZvkkdD.IqRoHSZn
 lZdo59bggi9egUF5P.8UoWb5wN6cWxpF0w_xtaVYVkuSY7cItP56ol4qrdx_AVbMZ7QaP3abCtGK
 jsddOVTS40uy6I8s2qlz.dkmc5ViXuQytiVbSyzOIBUIayxiJNzKkyyTRB8F5gxng0Nw85jdLsrR
 aH09L515iUCxNifdzskqFjgRBvim5e.s6YypwuoSDR5BWlFtm28XZfj.V_.wO7Tsx0UlfU1fZNYi
 V85g9DhJG1BUroziW2xJQeVa12sw240UwxL1TGSoyeBCoI63ESW1huRaTQtRM3UH9pKpY990kx1U
 EJ7Zd8tyoNUqTsHyeCZmaQq_30u_OWr9Ib4LSp37.y8hN5ttTommhP1WU43XRB_uxf9GL_t1Krwc
 MGgcdNkffgiCOUdp0EAP3jjg6mosvG49SiwwXyHV_.W3Mt_uAuC_LJOXHaCKYXnlibpd7TA37d18
 lmlzLvLw.dqQpzIRigZHER79StYvmk8mqM9EaPQ3zCylfQl9aTjHzxDcN8Qjf7lMznCCaL_gaxPF
 gBRk3vlpXFU3XEX0onCv01_.HsYSG86OAGB3tRtoMPGScqU8UJNjO
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fdfa2e87-cb35-473a-9d2d-8faac18858bf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 31 Aug 2023 23:06:03 +0000
Received: by hermes--production-bf1-865889d799-scr2n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3ba1991f30e41c6780f3de0d210d3f1c;
          Thu, 31 Aug 2023 23:05:57 +0000 (UTC)
Message-ID: <ac31c465-7789-46f0-2e54-29725b3bb5da@schaufler-ca.com>
Date:   Thu, 31 Aug 2023 16:05:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 25/25] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
 <20230831113803.910630-6-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230831113803.910630-6-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/31/2023 4:38 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Before the security field of kernel objects could be shared among LSMs with
> the LSM stacking feature, IMA and EVM had to rely on an alternative storage
> of inode metadata. The association between inode metadata and inode is
> maintained through an rbtree.
>
> With the reservation mechanism offered by the LSM infrastructure, the
> rbtree is no longer necessary, as each LSM could reserve a space in the
> security blob for each inode. Thus, request from the 'integrity' LSM a
> space in the security blob for the pointer of inode metadata
> (integrity_iint_cache structure).
>
> Prefer this to allocating the integrity_iint_cache structure directly, as
> IMA would require it only for a subset of inodes. Always allocating it
> would cause a waste of memory.
>
> Introduce two primitives for getting and setting the pointer of
> integrity_iint_cache in the security blob, respectively
> integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
> the code more understandable, as they directly replace rbtree operations.
>
> Locking is not needed, as access to inode metadata is not shared, it is per
> inode.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/integrity/iint.c      | 67 +++-------------------------------
>  security/integrity/integrity.h | 19 +++++++++-
>  2 files changed, 24 insertions(+), 62 deletions(-)
>
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 70ee803a33ea..c2fba8afbbdb 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -14,56 +14,25 @@
>  #include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/spinlock.h>
> -#include <linux/rbtree.h>
>  #include <linux/file.h>
>  #include <linux/uaccess.h>
>  #include <linux/security.h>
>  #include <linux/lsm_hooks.h>
>  #include "integrity.h"
>  
> -static struct rb_root integrity_iint_tree = RB_ROOT;
> -static DEFINE_RWLOCK(integrity_iint_lock);
>  static struct kmem_cache *iint_cache __read_mostly;
>  
>  struct dentry *integrity_dir;
>  
> -/*
> - * __integrity_iint_find - return the iint associated with an inode
> - */
> -static struct integrity_iint_cache *__integrity_iint_find(struct inode *inode)
> -{
> -	struct integrity_iint_cache *iint;
> -	struct rb_node *n = integrity_iint_tree.rb_node;
> -
> -	while (n) {
> -		iint = rb_entry(n, struct integrity_iint_cache, rb_node);
> -
> -		if (inode < iint->inode)
> -			n = n->rb_left;
> -		else if (inode > iint->inode)
> -			n = n->rb_right;
> -		else
> -			return iint;
> -	}
> -
> -	return NULL;
> -}
> -
>  /*
>   * integrity_iint_find - return the iint associated with an inode
>   */
>  struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
>  {
> -	struct integrity_iint_cache *iint;
> -
>  	if (!IS_IMA(inode))
>  		return NULL;
>  
> -	read_lock(&integrity_iint_lock);
> -	iint = __integrity_iint_find(inode);
> -	read_unlock(&integrity_iint_lock);
> -
> -	return iint;
> +	return integrity_inode_get_iint(inode);
>  }
>  
>  static void iint_free(struct integrity_iint_cache *iint)
> @@ -92,9 +61,7 @@ static void iint_free(struct integrity_iint_cache *iint)
>   */
>  struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
>  {
> -	struct rb_node **p;
> -	struct rb_node *node, *parent = NULL;
> -	struct integrity_iint_cache *iint, *test_iint;
> +	struct integrity_iint_cache *iint;
>  
>  	iint = integrity_iint_find(inode);
>  	if (iint)
> @@ -104,31 +71,10 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
>  	if (!iint)
>  		return NULL;
>  
> -	write_lock(&integrity_iint_lock);
> -
> -	p = &integrity_iint_tree.rb_node;
> -	while (*p) {
> -		parent = *p;
> -		test_iint = rb_entry(parent, struct integrity_iint_cache,
> -				     rb_node);
> -		if (inode < test_iint->inode) {
> -			p = &(*p)->rb_left;
> -		} else if (inode > test_iint->inode) {
> -			p = &(*p)->rb_right;
> -		} else {
> -			write_unlock(&integrity_iint_lock);
> -			kmem_cache_free(iint_cache, iint);
> -			return test_iint;
> -		}
> -	}
> -
>  	iint->inode = inode;
> -	node = &iint->rb_node;
>  	inode->i_flags |= S_IMA;
> -	rb_link_node(node, parent, p);
> -	rb_insert_color(node, &integrity_iint_tree);
> +	integrity_inode_set_iint(inode, iint);
>  
> -	write_unlock(&integrity_iint_lock);
>  	return iint;
>  }
>  
> @@ -145,10 +91,8 @@ static void integrity_inode_free(struct inode *inode)
>  	if (!IS_IMA(inode))
>  		return;
>  
> -	write_lock(&integrity_iint_lock);
> -	iint = __integrity_iint_find(inode);
> -	rb_erase(&iint->rb_node, &integrity_iint_tree);
> -	write_unlock(&integrity_iint_lock);
> +	iint = integrity_iint_find(inode);
> +	integrity_inode_set_iint(inode, NULL);
>  
>  	iint_free(iint);
>  }
> @@ -188,6 +132,7 @@ static int __init integrity_lsm_init(void)
>  }
>  
>  struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
> +	.lbs_inode = sizeof(struct integrity_iint_cache *),
>  	.lbs_xattr_count = 1,
>  };
>  
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index e020c365997b..24de4ad4a37e 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -158,7 +158,6 @@ struct ima_file_id {
>  
>  /* integrity data associated with an inode */
>  struct integrity_iint_cache {
> -	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
>  	struct mutex mutex;	/* protects: version, flags, digest */
>  	struct inode *inode;	/* back pointer to inode in question */
>  	u64 version;		/* track inode changes */
> @@ -192,6 +191,24 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>  extern struct dentry *integrity_dir;
>  extern struct lsm_blob_sizes integrity_blob_sizes;
>  
> +static inline struct integrity_iint_cache *
> +integrity_inode_get_iint(const struct inode *inode)
> +{
> +	struct integrity_iint_cache **iint_sec;
> +
> +	iint_sec = inode->i_security + integrity_blob_sizes.lbs_inode;
> +	return *iint_sec;
> +}
> +
> +static inline void integrity_inode_set_iint(const struct inode *inode,
> +					    struct integrity_iint_cache *iint)
> +{
> +	struct integrity_iint_cache **iint_sec;
> +
> +	iint_sec = inode->i_security + integrity_blob_sizes.lbs_inode;
> +	*iint_sec = iint;
> +}
> +
>  struct modsig;
>  
>  #ifdef CONFIG_IMA
