Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648186B24F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 14:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjCINIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 08:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCINId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:08:33 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB0B7D82;
        Thu,  9 Mar 2023 05:08:07 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PXTlB12Nyz9xGWf;
        Thu,  9 Mar 2023 20:58:46 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3QAwS2glkNqSEAQ--.25311S2;
        Thu, 09 Mar 2023 14:07:43 +0100 (CET)
Message-ID: <92c36707c8f9398f7f626c3da01bb98586880836.camel@huaweicloud.com>
Subject: Re: [PATCH 15/28] security: Introduce inode_post_removexattr hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, viro@zeniv.linux.org.uk,
        chuck.lever@oracle.com, jlayton@kernel.org,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 09 Mar 2023 14:07:26 +0100
In-Reply-To: <f5a61c0f09c1b8d8aaeb99ad7ba4aab15818c5ed.camel@linux.ibm.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303181842.1087717-16-roberto.sassu@huaweicloud.com>
         <f5a61c0f09c1b8d8aaeb99ad7ba4aab15818c5ed.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwC3QAwS2glkNqSEAQ--.25311S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1DuFW3ur4ftrWxGr1xXwb_yoW8trykpF
        s8t3ZxCF4rXr17GF97tF4UCwsagw48Gr4UJ3y2gw1jvFn7twn2qFWUKr15uFyrXr4j9Fyq
        qFnIgr95Cr15AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj4ZjhQAAsc
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-03-08 at 10:43 -0500, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Fri, 2023-03-03 at 19:18 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> > the inode_post_removexattr hook.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  fs/xattr.c                    |  1 +
> >  include/linux/lsm_hook_defs.h |  2 ++
> >  include/linux/security.h      |  5 +++++
> >  security/security.c           | 14 ++++++++++++++
> >  4 files changed, 22 insertions(+)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 14a7eb3c8fa..10c959d9fc6 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -534,6 +534,7 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
> >  
> >  	if (!error) {
> >  		fsnotify_xattr(dentry);
> > +		security_inode_post_removexattr(dentry, name);
> >  		evm_inode_post_removexattr(dentry, name);
> >  	}
> 
> Nothing wrong with this, but other places in this function test "if
> (error) goto ...".   Perhaps it is time to clean this up.

Theoretically, all 'goto out' can be replaced with 'return error'.

I would be more in favor of minimizing the changes as much as possible
to reach the main goal. But it is ok also to change the last part.

Thanks

Roberto

> >  
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index eedefbcdde3..2ae5224d967 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -147,6 +147,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
> >  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
> >  LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
> >  	 struct dentry *dentry, const char *name)
> > +LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
> > +	 const char *name)
> 
> @Christian should the security_inode_removexattr() and
> security_inode_post_removexattr() arguments be the same?
> 
> >  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
> >  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
> >  LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,

