Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9BD6B0B5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 15:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjCHOg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 09:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjCHOgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:36:24 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F995B1EE6;
        Wed,  8 Mar 2023 06:36:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PWvlV2x71z9v7br;
        Wed,  8 Mar 2023 22:27:02 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHDQlBnQhk6W+AAQ--.41041S2;
        Wed, 08 Mar 2023 15:35:57 +0100 (CET)
Message-ID: <384be560fdc4c37f056acc655de68372049560c7.camel@huaweicloud.com>
Subject: Re: [PATCH 23/28] security: Introduce LSM_ORDER_LAST
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
Date:   Wed, 08 Mar 2023 15:35:42 +0100
In-Reply-To: <1d02222998cf465fa7080ffb910bcf5815b7f857.camel@linux.ibm.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303182602.1088032-1-roberto.sassu@huaweicloud.com>
         <a0320926ebfe732dabc4e53c3a35ede450c75474.camel@linux.ibm.com>
         <ee5d9eb3addb9d408408fd748d52686bd9b85e24.camel@huaweicloud.com>
         <1d02222998cf465fa7080ffb910bcf5815b7f857.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCHDQlBnQhk6W+AAQ--.41041S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW5AFyxAryDWF4Dur1fXrb_yoWrGFW8pa
        y8tF43Gr4ktF1xG3Wqv3ZxK3WIq397GFyUWFZ8Xw1UZayvqF9a9F4xCry3uFykXFyDCF10
        vr4av3yfCrn8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4pWQgAAsg
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-03-08 at 09:00 -0500, Mimi Zohar wrote:
> On Wed, 2023-03-08 at 14:26 +0100, Roberto Sassu wrote:
> > On Wed, 2023-03-08 at 08:13 -0500, Mimi Zohar wrote:
> > > Hi Roberto,
> > > 
> > > On Fri, 2023-03-03 at 19:25 +0100, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs willing to be
> > > > the last, e.g. the 'integrity' LSM, without changing the kernel command
> > > > line or configuration.
> > > 
> > > Please reframe this as a bug fix for 79f7865d844c ("LSM: Introduce
> > > "lsm=" for boottime LSM selection") and upstream it first, with
> > > 'integrity' as the last LSM.   The original bug fix commit 92063f3ca73a
> > > ("integrity: double check iint_cache was initialized") could then be
> > > removed.
> > 
> > Ok, I should complete the patch by checking the cache initialization in
> > iint.c.
> > 
> > > > As for LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled and put
> > > > at the end of the LSM list in no particular order.
> > > 
> > > ^Similar to LSM_ORDER_FIRST ...
> > > 
> > > And remove "in no particular order".
> > 
> > The reason for this is that I originally thought that the relative
> > order of LSMs specified in the kernel configuration or the command line
> > was respected (if more than one LSM specifies LSM_ORDER_LAST). In fact
> > not. To do this, we would have to parse the LSM string again, as it is
> > done for LSM_ORDER_MUTABLE LSMs.
> 
> IMA and EVM are only configurable if 'integrity' is enabled.  Similar
> to how LSM_ORDER_FIRST is reserved for capabilities, LSM_ORDER_LAST
> should be reserved for integrity (LSMs), if it is configured, for the
> reason as described in the "[PATCH 24/28] ima: Move to LSM
> infrastructure" patch description.

Yes, it is just that nothing prevents to have multiple LSMs with order
LSM_ORDER_LAST. I guess we will enforce that it is only one by
reviewing the code.

Thanks

Roberto

> > Thanks
> > 
> > Roberto
> > 
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > >  include/linux/lsm_hooks.h |  1 +
> > > >  security/security.c       | 12 +++++++++---
> > > >  2 files changed, 10 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > > index 21a8ce23108..05c4b831d99 100644
> > > > --- a/include/linux/lsm_hooks.h
> > > > +++ b/include/linux/lsm_hooks.h
> > > > @@ -93,6 +93,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
> > > >  enum lsm_order {
> > > >  	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
> > > >  	LSM_ORDER_MUTABLE = 0,
> > > > +	LSM_ORDER_LAST = 1,
> > > >  };
> > > >  
> > > >  struct lsm_info {
> > > > diff --git a/security/security.c b/security/security.c
> > > > index 322090a50cd..24f52ba3218 100644
> > > > --- a/security/security.c
> > > > +++ b/security/security.c
> > > > @@ -284,9 +284,9 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
> > > >  		bool found = false;
> > > >  
> > > >  		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> > > > -			if (lsm->order == LSM_ORDER_MUTABLE &&
> > > > -			    strcmp(lsm->name, name) == 0) {
> > > > -				append_ordered_lsm(lsm, origin);
> > > > +			if (strcmp(lsm->name, name) == 0) {
> > > > +				if (lsm->order == LSM_ORDER_MUTABLE)
> > > > +					append_ordered_lsm(lsm, origin);
> > > >  				found = true;
> > > >  			}
> > > >  		}
> > > > @@ -306,6 +306,12 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
> > > >  		}
> > > >  	}
> > > >  
> > > > +	/* LSM_ORDER_LAST is always last. */
> > > > +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> > > > +		if (lsm->order == LSM_ORDER_LAST)
> > > > +			append_ordered_lsm(lsm, "   last");
> > > > +	}
> > > > +
> > > >  	/* Disable all LSMs not in the ordered list. */
> > > >  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> > > >  		if (exists_ordered_lsm(lsm))

