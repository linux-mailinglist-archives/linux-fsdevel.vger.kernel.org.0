Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9072464AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 12:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHQKmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 06:42:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40296 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726151AbgHQKmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597660918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PUJr2mnP6BBvGf0Kjd5lhs/X3Ec756z2m+nUcS2WOv0=;
        b=DXRAYmXVXoKW5b6pqmLW90xNq61cKRBlPZ5GlbKU+AocaZ/XRYTTxMAPOOKgFLB67KOHfM
        gOrREUogs5rlcrJuK4amd7hCcUsDGu4wjHm8k0ciXjHAHHN7oTf9zUhpNfus43UzcsO9Lz
        eREDVXXZ8mZy+Mr0ekQDi6DFS+hvsmg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-GyBc7orbNq-BKtLHgd-jGw-1; Mon, 17 Aug 2020 06:41:40 -0400
X-MC-Unique: GyBc7orbNq-BKtLHgd-jGw-1
Received: by mail-wr1-f70.google.com with SMTP id e14so6829024wrr.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 03:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PUJr2mnP6BBvGf0Kjd5lhs/X3Ec756z2m+nUcS2WOv0=;
        b=nMLtD1mZ6V7UMuj79rhQGEzHDzk15y9oq5xu8lOT+6z3AXgptF60bnfISiZs+olM2d
         H897aaCRSV9jZzrHGQ+uDJVm+vKLHAIp6TneB+5WnwiZTcMRkqNJP52NM2zEJoODWWpe
         IRFYn+lGrUsZL0ebtnsP12vz9FMkW+rBPV5RhgazwUmc6lqD1z9GENs5lOe5Gqsb/l5M
         edni/u6z3fsIG6tpiTN40Tc2v18lwPI2mspiKpNiBYCG9bN/2p2RY/6NUmaP+4CcUfxv
         qUwGehJciVj4CKKfKcGrKRn36Fz+M/fs3wgaBVml/MeHt5+Lkm1+z/zyLtFHYNBWOmAx
         3ntg==
X-Gm-Message-State: AOAM53192A815PIyNZbJTXk1acCMT9IESahT2O0zBuAZtF3VjFd8rwmi
        Cq/LmS7b7OAfHo/VqcwbgPNAoxdWC2MKxQzyfBjoiTVZxdkuZmZ9lg1A77SYzKQp6y5F8xNTlDr
        7QW3Vc2rFUYTSpeJMK92YK2dVug==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr13966081wmz.119.1597660899673;
        Mon, 17 Aug 2020 03:41:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqlBqWFxOiqPpRiM4LJ468Hm0058AImmVCARluPm+REFssSMQSBhWZ3F7LfJGZ19Vvr0lF6Q==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr13966061wmz.119.1597660899335;
        Mon, 17 Aug 2020 03:41:39 -0700 (PDT)
Received: from steredhat ([5.171.230.129])
        by smtp.gmail.com with ESMTPSA id g14sm29251689wme.16.2020.08.17.03.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 03:41:38 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:41:34 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, kbuild-all@lists.01.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
Message-ID: <20200817104134.fgmrppzchno2hcci@steredhat>
References: <20200813153254.93731-3-sgarzare@redhat.com>
 <202008140142.UYrgnsNY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008140142.UYrgnsNY%lkp@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 14, 2020 at 01:42:15AM +0800, kernel test robot wrote:
> Hi Stefano,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.8 next-20200813]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Stefano-Garzarella/io_uring-add-restrictions-to-support-untrusted-applications-and-guests/20200813-233653
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dc06fe51d26efc100ac74121607c01a454867c91
> config: s390-randconfig-c003-20200813 (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> coccinelle warnings: (new ones prefixed by >>)
> 
> >> fs/io_uring.c:8516:7-14: WARNING opportunity for memdup_user

Yeah, I think make sense.

I'll use memdup_user() in the next version.

> 
> vim +8516 fs/io_uring.c
> 
>   8497	
>   8498	static int io_register_restrictions(struct io_ring_ctx *ctx, void __user *arg,
>   8499					    unsigned int nr_args)
>   8500	{
>   8501		struct io_uring_restriction *res;
>   8502		size_t size;
>   8503		int i, ret;
>   8504	
>   8505		/* We allow only a single restrictions registration */
>   8506		if (ctx->restricted)
>   8507			return -EBUSY;
>   8508	
>   8509		if (!arg || nr_args > IORING_MAX_RESTRICTIONS)
>   8510			return -EINVAL;
>   8511	
>   8512		size = array_size(nr_args, sizeof(*res));
>   8513		if (size == SIZE_MAX)
>   8514			return -EOVERFLOW;
>   8515	
> > 8516		res = kmalloc(size, GFP_KERNEL);
>   8517		if (!res)
>   8518			return -ENOMEM;
>   8519	
>   8520		if (copy_from_user(res, arg, size)) {
>   8521			ret = -EFAULT;
>   8522			goto out;
>   8523		}
>   8524	
>   8525		for (i = 0; i < nr_args; i++) {
>   8526			switch (res[i].opcode) {
>   8527			case IORING_RESTRICTION_REGISTER_OP:
>   8528				if (res[i].register_op >= IORING_REGISTER_LAST) {
>   8529					ret = -EINVAL;
>   8530					goto out;
>   8531				}
>   8532	
>   8533				__set_bit(res[i].register_op,
>   8534					  ctx->restrictions.register_op);
>   8535				break;
>   8536			case IORING_RESTRICTION_SQE_OP:
>   8537				if (res[i].sqe_op >= IORING_OP_LAST) {
>   8538					ret = -EINVAL;
>   8539					goto out;
>   8540				}
>   8541	
>   8542				__set_bit(res[i].sqe_op, ctx->restrictions.sqe_op);
>   8543				break;
>   8544			case IORING_RESTRICTION_SQE_FLAGS_ALLOWED:
>   8545				ctx->restrictions.sqe_flags_allowed = res[i].sqe_flags;
>   8546				break;
>   8547			case IORING_RESTRICTION_SQE_FLAGS_REQUIRED:
>   8548				ctx->restrictions.sqe_flags_required = res[i].sqe_flags;
>   8549				break;
>   8550			default:
>   8551				ret = -EINVAL;
>   8552				goto out;
>   8553			}
>   8554		}
>   8555	
>   8556		ctx->restricted = 1;
>   8557	
>   8558		ret = 0;
>   8559	out:
>   8560		/* Reset all restrictions if an error happened */
>   8561		if (ret != 0)
>   8562			memset(&ctx->restrictions, 0, sizeof(ctx->restrictions));
>   8563	
>   8564		kfree(res);
>   8565		return ret;
>   8566	}
>   8567	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


