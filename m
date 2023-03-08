Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987F66B0E95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 17:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCHQYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 11:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCHQYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:24:13 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ACEC1C0C;
        Wed,  8 Mar 2023 08:24:02 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PWy7j4CqPz9xHM1;
        Thu,  9 Mar 2023 00:14:41 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBHHGN5tghkH4B+AQ--.22743S2;
        Wed, 08 Mar 2023 17:23:35 +0100 (CET)
Message-ID: <0a15c85e9de2235c313b10839aabf750f276552f.camel@huaweicloud.com>
Subject: Re: [PATCH 00/28] security: Move IMA and EVM to the LSM
 infrastructure
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
Date:   Wed, 08 Mar 2023 17:23:18 +0100
In-Reply-To: <59eb6d6d2ffd5522b2116000ab48b1711d57f5e5.camel@linux.ibm.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <59eb6d6d2ffd5522b2116000ab48b1711d57f5e5.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBHHGN5tghkH4B+AQ--.22743S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArW7Aw17XFWDGryDJw4fXwb_yoW5ZF15pF
        Z8K3W5Kr4ktF109rs2v3y8uFWfCa1fJ3yUJr95K34UZa45GF1FqFWvkF15uFyDG3s0kFyF
        qF4jq3s5Z3WDZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4pXogABsA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-03-08 at 10:14 -0500, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Fri, 2023-03-03 at 19:18 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > This patch set depends on:
> > - https://lore.kernel.org/linux-integrity/20221201104125.919483-1-roberto.sassu@huaweicloud.com/ (there will be a v8 shortly)
> > - https://lore.kernel.org/linux-security-module/20230217032625.678457-1-paul@paul-moore.com/
> > 
> > IMA and EVM are not effectively LSMs, especially due the fact that in the
> > past they could not provide a security blob while there is another LSM
> > active.
> > 
> > That changed in the recent years, the LSM stacking feature now makes it
> > possible to stack together multiple LSMs, and allows them to provide a
> > security blob for most kernel objects. While the LSM stacking feature has
> > some limitations being worked out, it is already suitable to make IMA and
> > EVM as LSMs.
> > 
> > In short, while this patch set is big, it does not make any functional
> > change to IMA and EVM. IMA and EVM functions are called by the LSM
> > infrastructure in the same places as before (except ima_post_path_mknod()),
> > rather being hardcoded calls, and the inode metadata pointer is directly
> > stored in the inode security blob rather than in a separate rbtree.
> > 
> > More specifically, patches 1-13 make IMA and EVM functions suitable to
> > be registered to the LSM infrastructure, by aligning function parameters.
> > 
> > Patches 14-22 add new LSM hooks in the same places where IMA and EVM
> > functions are called, if there is no LSM hook already.
> > 
> > Patch 23 adds the 'last' ordering strategy for LSMs, so that IMA and EVM
> > functions are called in the same order as of today. Also, like with the
> > 'first' strategy, LSMs using it are always enabled, so IMA and EVM
> > functions will be always called (if IMA and EVM are compiled built-in).
> > 
> > Patches 24-27 do the bulk of the work, remove hardcoded calls to IMA and
> > EVM functions, register those functions in the LSM infrastructure, and let
> > the latter call them. In addition, they also reserve one slot for EVM to 
> > supply an xattr to the inode_init_security hook.
> > 
> > Finally, patch 28 removes the rbtree used to bind metadata to the inodes,
> > and instead reserve a space in the inode security blob to store the pointer
> > to metadata. This also brings performance improvements due to retrieving
> > metadata in constant time, as opposed to logarithmic.
> 
> Prior to IMA being upstreamed, it went through a number of iterations,
> first on the security hooks, then as a separate parallel set of
> integrity hooks, and, finally, co-located with the security hooks,
> where they exist.  With this patch set we've come full circle.
> 
> With the LSM stacking support, multiple LSMs can now use the
> 'i_security' field removing the need for the rbtree indirection for
> accessing integrity state info.
> 
> Roberto, thank you for making this change.  Mostly it looks good.  
> Reviewing the patch set will be easier once the prereq's and this patch
> set can be properly applied.

Welcome. Yes, once Paul reviews the other patch set, we can
progressively apply the patches.

Thanks

Roberto

