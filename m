Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341196B1F91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCIJMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCIJMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:12:35 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C7ADCA5F;
        Thu,  9 Mar 2023 01:12:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PXNWj1ywgz9xtnb;
        Thu,  9 Mar 2023 17:03:29 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB39QDLoglkaOCDAQ--.24643S2;
        Thu, 09 Mar 2023 10:11:52 +0100 (CET)
Message-ID: <3f3c321a870ff8eae8634bab42ea276d6e6a7ed5.camel@huaweicloud.com>
Subject: Re: [PATCH 03/28] ima: Align ima_post_create_tmpfile() definition
 with LSM infrastructure
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
Date:   Thu, 09 Mar 2023 10:11:36 +0100
In-Reply-To: <502bd55cdbe47df40542f957f29f201502d7218f.camel@linux.ibm.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303181842.1087717-4-roberto.sassu@huaweicloud.com>
         <502bd55cdbe47df40542f957f29f201502d7218f.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwB39QDLoglkaOCDAQ--.24643S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWrXr4xJFy8CrWxKw1fXrb_yoW5uFyrpF
        Z3K3WUGrs3Xry7ury0qa13ZrySg3yvqr1UZrWfWa4qyF1ktrnY9F1fCrn0kF45CrWrCr1j
        q3W3KrZ8Ar1UtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBF1jj4pcuAACsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-03-08 at 10:15 -0500, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Fri, 2023-03-03 at 19:18 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Change ima_post_create_tmpfile() definition, so that it can be registered
> > as implementation of the post_create_tmpfile hook.
> 
> Since neither security_create_tmpfile() nor
> security_post_create_tmpfile() already exist, why not pass a pointer to
> the file to conform to the other file related security hooks?

Ok, will change the parameter.

Thanks

Roberto

> Mimi
> 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  fs/namei.c                        | 2 +-
> >  include/linux/ima.h               | 7 +++++--
> >  security/integrity/ima/ima_main.c | 8 ++++++--
> >  3 files changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index b5a1ec29193..57727a1ae38 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3622,7 +3622,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
> >  		inode->i_state |= I_LINKABLE;
> >  		spin_unlock(&inode->i_lock);
> >  	}
> > -	ima_post_create_tmpfile(idmap, inode);
> > +	ima_post_create_tmpfile(idmap, dir, file_dentry(file), mode);
> >  	return 0;
> >  }
> >  
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 179ce52013b..7535686a403 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -19,7 +19,8 @@ extern enum hash_algo ima_get_current_hash_algo(void);
> >  extern int ima_bprm_check(struct linux_binprm *bprm);
> >  extern int ima_file_check(struct file *file, int mask);
> >  extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> > -				    struct inode *inode);
> > +				    struct inode *dir, struct dentry *dentry,
> > +				    umode_t mode);
> >  extern void ima_file_free(struct file *file);
> >  extern int ima_file_mmap(struct file *file, unsigned long reqprot,
> >  			 unsigned long prot, unsigned long flags);
> > @@ -69,7 +70,9 @@ static inline int ima_file_check(struct file *file, int mask)
> >  }
> >  
> >  static inline void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> > -					   struct inode *inode)
> > +					   struct inode *dir,
> > +					   struct dentry *dentry,
> > +					   umode_t mode)
> >  {
> >  }
> >  
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 8941305376b..4a3d0c8bcba 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -659,16 +659,20 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
> >  /**
> >   * ima_post_create_tmpfile - mark newly created tmpfile as new
> >   * @idmap: idmap of the mount the inode was found from
> > - * @inode: inode of the newly created tmpfile
> > + * @dir: inode structure of the parent of the new file
> > + * @dentry: dentry structure of the new file
> > + * @mode: mode of the new file
> >   *
> >   * No measuring, appraising or auditing of newly created tmpfiles is needed.
> >   * Skip calling process_measurement(), but indicate which newly, created
> >   * tmpfiles are in policy.
> >   */
> >  void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> > -			     struct inode *inode)
> > +			     struct inode *dir, struct dentry *dentry,
> > +			     umode_t mode)
> >  {
> >  	struct integrity_iint_cache *iint;
> > +	struct inode *inode = dentry->d_inode;
> >  	int must_appraise;
> >  
> >  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))

