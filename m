Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BD959D073
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 07:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbiHWF1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 01:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbiHWF1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:27:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845DA5C9CB
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 22:27:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f21so13039228pjt.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 22:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Sowzz9YsPRtzetlPu2hXWOD1OeotK9euRi0tgK9f75Q=;
        b=R5fTZ23o3/uyGMEe9JPFGzHI9DFiWC2w0CKp3DqYbZ49IjmsjiqCATBDckYh+eZ7d9
         1d4WBwCO3y4wBtf/+0KT/Y+zuPIlWKKi2q3EGlyEgRf02QtaOI9X4vAGbxb2IXu5YdlG
         JKTcdnFM+ujiAIm1aXqK+TJ+PIKDm4fWwrEPqzYdLC2mSBc9r7z3ojBwwgzOqIGxLPyp
         LXSuv7KAKzJ4dTdHCNIy6kcmnTN4clq+ZCv+iTcUD27YbYmO2Vut7oglekI6g5XVCVD2
         WWakq55D/JnOOSovKjJutPRRBiS+1WGgEevd0J1LUi8lDvAACYKLnWfzyC+oN1xu+JY7
         wY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Sowzz9YsPRtzetlPu2hXWOD1OeotK9euRi0tgK9f75Q=;
        b=GuWSc4R0fEfN3NcdNcoHKT5PiaJpFRY3ARHL0ZMkMMkANiXUn06+8jeSIUrQhj8nzV
         mLI0FLKxsZ/Xn+Jkg9jIQ+PLefegJ14D2sRMRgIUru+0CDVXjTNdeaTwUSivyctoxNPO
         RBUx9Ef8c1FfeUEHivUstaCCNiMqupBtAovlbHDHKCwICMsimTjNpCOv6xqnxPnUWBWH
         ZyCSD0nB1fPWtxcHIwmfTyA0zAk3wAYqhxrYSP5U3toxnF2yxFnjhWG2v5hUb7o9mG0E
         5M1/qNZq3RA3C0vfjqzLwKiWPtTfInCAG4AWQJjlQ13blCSb4fOlUdlVsO9CMJlcXqAy
         yPfw==
X-Gm-Message-State: ACgBeo3UvhuMxBIMZSsf+hyklWj7j+S1TOO7Z/0aJMObw8q6zkMMsRt8
        15UIacFkh0OC4H8Vc06PtNp4JUUiqGhQDQ==
X-Google-Smtp-Source: AA6agR7jpzKm8gaayS/eD0bwjEuLyuzfsNL+H2XzixW7G/ioIGpMCqEYlWQ020TMCYmNCgCJykQxrA==
X-Received: by 2002:a17:90a:c789:b0:1fa:6bc0:77f6 with SMTP id gn9-20020a17090ac78900b001fa6bc077f6mr1747785pjb.1.1661232449980;
        Mon, 22 Aug 2022 22:27:29 -0700 (PDT)
Received: from [10.4.208.12] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709027fcf00b0016d5428f041sm9336851plb.199.2022.08.22.22.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 22:27:29 -0700 (PDT)
Message-ID: <e340ccaa-92f2-3870-ed26-70df87ad8c8f@bytedance.com>
Date:   Tue, 23 Aug 2022 13:27:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH 4/7] kernfs: Skip kernfs_drain_open_files() more
 aggressively
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
References: <20220820000550.367085-1-tj@kernel.org>
 <20220820000550.367085-5-tj@kernel.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220820000550.367085-5-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/8/20 08:05, Tejun Heo wrote:
> Track the number of mmapped files and files that need to be released and
> skip kernfs_drain_open_file() if both are zero, which are the precise
> conditions which require draining open_files. The early exit test is
> factored into kernfs_should_drain_open_files() which is now tested by
> kernfs_drain_open_files()'s caller - kernfs_drain().
> 
> This isn't a meaningful optimization on its own but will enable future
> stand-alone kernfs_deactivate() implementation.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  fs/kernfs/dir.c             |  3 ++-
>  fs/kernfs/file.c            | 51 +++++++++++++++++++++++++------------
>  fs/kernfs/kernfs-internal.h |  1 +
>  3 files changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 1cc88ba6de90..8ae44db920d4 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -489,7 +489,8 @@ static void kernfs_drain(struct kernfs_node *kn)
>  		rwsem_release(&kn->dep_map, _RET_IP_);
>  	}
>  
> -	kernfs_drain_open_files(kn);
> +	if (kernfs_should_drain_open_files(kn))
> +		kernfs_drain_open_files(kn);
>  
>  	down_write(&root->kernfs_rwsem);
>  }
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 7060a2a714b8..b510589af427 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -23,6 +23,8 @@ struct kernfs_open_node {
>  	atomic_t		event;
>  	wait_queue_head_t	poll;
>  	struct list_head	files; /* goes through kernfs_open_file.list */
> +	unsigned int		nr_mmapped;
> +	unsigned int		nr_to_release;
>  };
>  
>  /*
> @@ -527,6 +529,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
>  
>  	rc = 0;
>  	of->mmapped = true;
> +	of_on(of)->nr_mmapped++;
>  	of->vm_ops = vma->vm_ops;
>  	vma->vm_ops = &kernfs_vm_ops;
>  out_put:
> @@ -574,6 +577,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
>  	}
>  
>  	list_add_tail(&of->list, &on->files);
> +	if (kn->flags & KERNFS_HAS_RELEASE)
> +		on->nr_to_release++;
>  
>  	mutex_unlock(mutex);
>  	return 0;
> @@ -606,8 +611,12 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
>  		return;
>  	}
>  
> -	if (of)
> +	if (of) {
> +		WARN_ON_ONCE((kn->flags & KERNFS_HAS_RELEASE) && !of->released);

kernfs_unlink_open_file() is also used in error case "err_put_node" in kernfs_fop_open(),
which should also dec the on->nr_to_release?

Thanks.

> +		if (of->mmapped)
> +			on->nr_mmapped--;
>  		list_del(&of->list);
> +	}
>  
>  	if (list_empty(&on->files)) {
>  		rcu_assign_pointer(kn->attr.open, NULL);
> @@ -766,6 +775,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
>  		 */
>  		kn->attr.ops->release(of);
>  		of->released = true;
> +		of_on(of)->nr_to_release--;
>  	}
>  }
>  
> @@ -790,25 +800,30 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> -void kernfs_drain_open_files(struct kernfs_node *kn)
> +bool kernfs_should_drain_open_files(struct kernfs_node *kn)
>  {
>  	struct kernfs_open_node *on;
> -	struct kernfs_open_file *of;
> -	struct mutex *mutex;
> -
> -	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
> -		return;
> +	bool ret;
>  
>  	/*
> -	 * lockless opportunistic check is safe below because no one is adding to
> -	 * ->attr.open at this point of time. This check allows early bail out
> -	 * if ->attr.open is already NULL. kernfs_unlink_open_file makes
> -	 * ->attr.open NULL only while holding kernfs_open_file_mutex so below
> -	 * check under kernfs_open_file_mutex_ptr(kn) will ensure bailing out if
> -	 * ->attr.open became NULL while waiting for the mutex.
> +	 * @kn being deactivated guarantees that @kn->attr.open can't change
> +	 * beneath us making the lockless test below safe.
>  	 */
> -	if (!rcu_access_pointer(kn->attr.open))
> -		return;
> +	WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
> +
> +	rcu_read_lock();
> +	on = rcu_dereference(kn->attr.open);
> +	ret = on && (on->nr_mmapped || on->nr_to_release);
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +void kernfs_drain_open_files(struct kernfs_node *kn)
> +{
> +	struct kernfs_open_node *on;
> +	struct kernfs_open_file *of;
> +	struct mutex *mutex;
>  
>  	mutex = kernfs_open_file_mutex_lock(kn);
>  	on = kernfs_deref_open_node_locked(kn);
> @@ -820,13 +835,17 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>  	list_for_each_entry(of, &on->files, list) {
>  		struct inode *inode = file_inode(of->file);
>  
> -		if (kn->flags & KERNFS_HAS_MMAP)
> +		if (of->mmapped) {
>  			unmap_mapping_range(inode->i_mapping, 0, 0, 1);
> +			of->mmapped = false;
> +			on->nr_mmapped--;
> +		}
>  
>  		if (kn->flags & KERNFS_HAS_RELEASE)
>  			kernfs_release_file(kn, of);
>  	}
>  
> +	WARN_ON_ONCE(on->nr_mmapped || on->nr_to_release);
>  	mutex_unlock(mutex);
>  }
>  
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index 3ae214d02d44..fc5821effd97 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -157,6 +157,7 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
>   */
>  extern const struct file_operations kernfs_file_fops;
>  
> +bool kernfs_should_drain_open_files(struct kernfs_node *kn);
>  void kernfs_drain_open_files(struct kernfs_node *kn);
>  
>  /*
