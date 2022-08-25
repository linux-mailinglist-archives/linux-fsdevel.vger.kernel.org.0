Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625E05A100F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 14:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbiHYMMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 08:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbiHYMMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:12:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32208A61EC
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 05:12:04 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso4720019pjj.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Ru17QDTLZvKnteLwuwlcrhPpoXkw+kU/p+9HVxWpvik=;
        b=ddXRGumEtI5cvbDqla6xXpQt/f+vJ4upmi9506EMxPBgan3p/dL5rC2hLdofmquSQ7
         uqFbKf8QYNW8XLU2MD2MC/TYwg5fXQNid8nSQLg6IBLCm/zAXE0TQ8n8l05yAOjRyl55
         k4AyKQTag/PdpGM6VOVlINWxo8lnOMVoa5qc9XsWVCeeKM3XwNFFRQf5o2jVGYCyo/yH
         icBETHtiPWyoNGXlaeRC4VjpVJTlOkkILZHVP/jMaxvwnk3X/ngxsMRdSf2EtXtlLOA1
         iun+FIXvjVwQn5JUBXNhBkdCiKGJFR5/hcToNIhDJn2WzDeXk3daicN7+HsfClbl+E69
         Ef/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Ru17QDTLZvKnteLwuwlcrhPpoXkw+kU/p+9HVxWpvik=;
        b=bURDbFFizXqFOk5HU3yE0jH8o5ltWVYXX0OkXsxqaercd2w0Od3X6cRqlbdcO30U2l
         U1zzT5hg4Njh7h1fZISvNciILNaWP1milC3NXVv1cmhRJNeCjT4f8UmxbszFnORhtUP2
         kaQFpACH9Q/D9TctgqskqWcCow5wHbQfPw305rxxCLN+7LzZNFU1p1qBAPpI0MYZyaKA
         Shos7WnfKHlxHF2dOwAhxti+6UfzZggv0frtz+JteMnfBpauzOO/WEm00tETUx/ZO3yw
         rpG3W+xvJfnYG6AYJfo9e8R6vL7Urr/LK6OR7owRoA7bkPb1nR2AkPBryYYo0VLBP/0C
         bqKQ==
X-Gm-Message-State: ACgBeo0YJGF94OXDzKWfAiHALx9mAjasV3fH33mh66vv3mkegRxzJPbE
        X2bRsrYVO4xEd9G+2G7dOiUn0g==
X-Google-Smtp-Source: AA6agR40vL7N5tG6TitaeoauM03j2rAqbHCgyVmBp2OtC3EIGiiNiDlYKH+Vi6GkjfM5KiOqfDx18w==
X-Received: by 2002:a17:902:dac7:b0:172:e189:f717 with SMTP id q7-20020a170902dac700b00172e189f717mr3803922plx.129.1661429523649;
        Thu, 25 Aug 2022 05:12:03 -0700 (PDT)
Received: from [10.254.35.15] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79591000000b0052aaff953aesm15137111pfj.115.2022.08.25.05.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 05:12:03 -0700 (PDT)
Message-ID: <42d482dc-be96-a624-2ecf-3d22f5baed1c@bytedance.com>
Date:   Thu, 25 Aug 2022 20:11:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH 4/7] kernfs: Skip kernfs_drain_open_files() more
 aggressively
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
References: <20220820000550.367085-1-tj@kernel.org>
 <20220820000550.367085-5-tj@kernel.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220820000550.367085-5-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

The current code use kmalloc() to alloc kernfs_open_node, leave nr_to_release and
nr_mmapped uninitialized.

Found by below stress test:

```
cd /sys/fs/cgroup

while true; do echo 0 > cgroup.pressure; echo 1 > cgroup.pressure; done

while true; do cat *.pressure; done

```

Thanks.

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
