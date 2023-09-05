Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A667924A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjIEP7Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 5 Sep 2023 11:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353608AbjIEGwR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:52:17 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52DA1B4;
        Mon,  4 Sep 2023 23:52:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Rfwq91PZtz9v7ZP;
        Tue,  5 Sep 2023 14:40:05 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDX1+_yz_ZkocAiAg--.8435S2;
        Tue, 05 Sep 2023 07:51:44 +0100 (CET)
Message-ID: <b4bc9dbb2417dc8afe0bf0a50233d4c2968bfb7a.camel@huaweicloud.com>
Subject: Re: [PATCH v2 13/25] security: Introduce inode_post_removexattr hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Tue, 05 Sep 2023 08:51:26 +0200
In-Reply-To: <CVAFXF2BQ14B.19BO7F9P62WGT@suppilovahvero>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
         <20230831104136.903180-14-roberto.sassu@huaweicloud.com>
         <CVAFXF2BQ14B.19BO7F9P62WGT@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwDX1+_yz_ZkocAiAg--.8435S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4DAry7AF1kXr4xCFWfZrb_yoWruF47pF
        s8t3W5Cr4rJFy7WFy8tF17uw4I9ayFgry7A3y2gw12yFn2yrn2qrZxCF1UCryrJr40gFyv
        qFnFkrs5Cr13J3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBF1jj5OFhQACsu
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-09-05 at 00:11 +0300, Jarkko Sakkinen wrote:
> On Thu Aug 31, 2023 at 1:41 PM EEST, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> > the inode_post_removexattr hook.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  fs/xattr.c                    |  9 +++++----
> >  include/linux/lsm_hook_defs.h |  2 ++
> >  include/linux/security.h      |  5 +++++
> >  security/security.c           | 14 ++++++++++++++
> >  4 files changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index e7bbb7f57557..4a0280295686 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
> >  		goto out;
> >  
> >  	error = __vfs_removexattr(idmap, dentry, name);
> > +	if (error)
> > +		goto out;
> >  
> > -	if (!error) {
> > -		fsnotify_xattr(dentry);
> > -		evm_inode_post_removexattr(dentry, name);
> > -	}
> > +	fsnotify_xattr(dentry);
> > +	security_inode_post_removexattr(dentry, name);
> > +	evm_inode_post_removexattr(dentry, name);
> >  
> >  out:
> >  	return error;
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 995d30336cfa..1153e7163b8b 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -148,6 +148,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
> >  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
> >  LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
> >  	 struct dentry *dentry, const char *name)
> > +LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
> > +	 const char *name)
> >  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
> >  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
> >  LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 820899db5276..665bba3e0081 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -374,6 +374,7 @@ int security_inode_getxattr(struct dentry *dentry, const char *name);
> >  int security_inode_listxattr(struct dentry *dentry);
> >  int security_inode_removexattr(struct mnt_idmap *idmap,
> >  			       struct dentry *dentry, const char *name);
> > +void security_inode_post_removexattr(struct dentry *dentry, const char *name);
> >  int security_inode_need_killpriv(struct dentry *dentry);
> >  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
> >  int security_inode_getsecurity(struct mnt_idmap *idmap,
> > @@ -919,6 +920,10 @@ static inline int security_inode_removexattr(struct mnt_idmap *idmap,
> >  	return cap_inode_removexattr(idmap, dentry, name);
> >  }
> >  
> > +static inline void security_inode_post_removexattr(struct dentry *dentry,
> > +						   const char *name)
> > +{ }
> 
> static inline void security_inode_post_removexattr(struct dentry *dentry, const char *name)
> {
> }
> 
> > +
> >  static inline int security_inode_need_killpriv(struct dentry *dentry)
> >  {
> >  	return cap_inode_need_killpriv(dentry);
> > diff --git a/security/security.c b/security/security.c
> > index 764a6f28b3b9..3947159ba5e9 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2354,6 +2354,20 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
> >  	return evm_inode_removexattr(idmap, dentry, name);
> >  }
> >  
> > +/**
> > + * security_inode_post_removexattr() - Update the inode after a removexattr op
> > + * @dentry: file
> > + * @name: xattr name
> > + *
> > + * Update the inode after a successful removexattr operation.
> > + */
> > +void security_inode_post_removexattr(struct dentry *dentry, const char *name)
> > +{
> > +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > +		return;
> > +	call_void_hook(inode_post_removexattr, dentry, name);
> > +}
> > +
> >  /**
> >   * security_inode_need_killpriv() - Check if security_inode_killpriv() required
> >   * @dentry: associated dentry
> > -- 
> > 2.34.1
> 
> 
> These odd splits are everywhere in the patch set. Just (nit)picking some.
> 
> It is huge patch set so I don't really get for addign extra lines for no
> good reason.

Thanks for the review, Jarkko.

I don't know... to be honest I still prefer to stay within 80
characters.

Roberto

