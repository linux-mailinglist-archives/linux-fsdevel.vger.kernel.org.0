Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302376B0084
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 09:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCHIHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 03:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCHIHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:07:39 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E89DE29;
        Wed,  8 Mar 2023 00:07:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PWl6y2Ntbz9xqcC;
        Wed,  8 Mar 2023 15:58:18 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAX41kGQghkLu58AQ--.21290S2;
        Wed, 08 Mar 2023 09:06:42 +0100 (CET)
Message-ID: <8c7034e74c55e9c4eb6424aa472f5c66b389b34f.camel@huaweicloud.com>
Subject: Re: [PATCH 23/28] security: Introduce LSM_ORDER_LAST
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
Date:   Wed, 08 Mar 2023 09:06:28 +0100
In-Reply-To: <4b158d7e-a96d-58ae-cc34-0ad6abc1cea9@linux.ibm.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303182602.1088032-1-roberto.sassu@huaweicloud.com>
         <4b158d7e-a96d-58ae-cc34-0ad6abc1cea9@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAX41kGQghkLu58AQ--.21290S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy8AF15Ar45KrW7ur47twb_yoW8KF1Upa
        yktFWfGr4FyFy8W3WDX3ZxK3W8t39YkFWUC39rWr1UXa92qrySkr43Cr1S9FyDXF9rCFyI
        vrWav34akwn0yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4pQsgAAsW
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-03-07 at 13:04 -0500, Stefan Berger wrote:
> 
> On 3/3/23 13:25, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs willing to be
> > the last, e.g. the 'integrity' LSM, without changing the kernel command
> > line or configuration.
> > 
> > As for LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled and put
> > at the end of the LSM list in no particular order.
> > 
> 
> I think you should describe the reason for the change for LSM_ORDER_MUTABLE as well.

Right.

Thanks

Roberto

> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >   include/linux/lsm_hooks.h |  1 +
> >   security/security.c       | 12 +++++++++---
> >   2 files changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 21a8ce23108..05c4b831d99 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -93,6 +93,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
> >   enum lsm_order {
> >   	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
> >   	LSM_ORDER_MUTABLE = 0,
> > +	LSM_ORDER_LAST = 1,
> >   };
> >   
> >   struct lsm_info {
> > diff --git a/security/security.c b/security/security.c
> > index 322090a50cd..24f52ba3218 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -284,9 +284,9 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
> >   		bool found = false;
> >   
> >   		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> > -			if (lsm->order == LSM_ORDER_MUTABLE &&
> > -			    strcmp(lsm->name, name) == 0) {
> > -				append_ordered_lsm(lsm, origin);
> > +			if (strcmp(lsm->name, name) == 0) {
> > +				if (lsm->order == LSM_ORDER_MUTABLE)
> > +					append_ordered_lsm(lsm, origin);
> >   				found = true;
> >   			}
> >   		}
> > @@ -306,6 +306,12 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
> >   		}
> >   	}
> >   
> > +	/* LSM_ORDER_LAST is always last. */
> > +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> > +		if (lsm->order == LSM_ORDER_LAST)
> > +			append_ordered_lsm(lsm, "   last");
> > +	}
> > +
> >   	/* Disable all LSMs not in the ordered list. */
> >   	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> >   		if (exists_ordered_lsm(lsm))

