Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDB76AC986
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 18:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCFRNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 12:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCFRNo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:13:44 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E011F2FCF9;
        Mon,  6 Mar 2023 09:13:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PVkrT6B2Qz9v7HC;
        Tue,  7 Mar 2023 00:42:17 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCncFfRGQZkRM51AQ--.18145S2;
        Mon, 06 Mar 2023 17:50:38 +0100 (CET)
Message-ID: <ebd9c87f809e586ccd1647171f9f940ce195b03d.camel@huaweicloud.com>
Subject: Re: [PATCH 21/28] security: Introduce inode_post_remove_acl hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, viro@zeniv.linux.org.uk,
        chuck.lever@oracle.com, jlayton@kernel.org, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 06 Mar 2023 17:50:22 +0100
In-Reply-To: <2dcc460c-73ff-d468-0c43-63ccbe0c4f9e@linux.ibm.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303181842.1087717-22-roberto.sassu@huaweicloud.com>
         <6393eb31-5eb3-cb1c-feb7-2ab347703042@linux.ibm.com>
         <7bde74e6e5ccf24b2a2bd9dc2bbfcae5c424eac7.camel@huaweicloud.com>
         <2dcc460c-73ff-d468-0c43-63ccbe0c4f9e@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCncFfRGQZkRM51AQ--.18145S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWDCF1UGw1rGw47Cr1rZwb_yoW8ArW8pF
        47K3WYkr4vqry7Gr1xta18W3s29rWfWry7Z3Z8uryUXFnYyrnFgryfu3W5uFyrGrnFkF1F
        qa15ZF1fZ345ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4pAMgAAsE
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-03-06 at 11:16 -0500, Stefan Berger wrote:
> 
> On 3/6/23 10:34, Roberto Sassu wrote:
> > On Mon, 2023-03-06 at 10:22 -0500, Stefan Berger wrote:
> > > On 3/3/23 13:18, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> > > > the inode_post_remove_acl hook.
> > > > 
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > >    
> > > > +/**
> > > > + * security_inode_post_remove_acl() - Update inode sec after remove_acl op
> > > > + * @idmap: idmap of the mount
> > > > + * @dentry: file
> > > > + * @acl_name: acl name
> > > > + *
> > > > + * Update inode security field after successful remove_acl operation on @dentry
> > > > + * in @idmap. The posix acls are identified by @acl_name.
> > > > + */
> > > > +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> > > > +				    struct dentry *dentry, const char *acl_name)
> > > > +{
> > > > +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > > > +		return;
> > > 
> > > Was that a mistake before that EVM and IMA functions did not filtered out private inodes?
> > 
> > Looks like that. At least for hooks that are not called from
> > security.c.
> 
> It seems like that all security_* functions are filtering on private inodes. Anonymous inodes have them and some filesystem set the S_PRIVATE flag. So it may not make a difference fro IMA and EVM then.

Currently, what it would happen is that the HMAC would be updated
without check, since the check function is usually in security.c
(skipped) and the post elsewhere.

With this patch set, also the post function would not be executed for
private inodes. Maybe, it is worth mentioning it in the next version.

Thanks

Roberto

