Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367FD59D058
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 07:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbiHWFPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 01:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiHWFPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:15:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3804B490
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 22:15:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ds12-20020a17090b08cc00b001fae6343d9fso766270pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 22:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7CbX3vi42ZGOMPpEOi1rGvmX1pkFnmfkswzcsMu8F9g=;
        b=IP23OU1H2oHfzax5Zpb+rmZuLU0x4qGPU0go1jT7eiz/80hf0Rzs94X17vA/NlU/KM
         O5VzBWxZEqGDlfLw7jbIfOvCBaMF7dQVoD3SXUeBIrOf9Icim5uUyQMzMKG84U51ncd2
         rp6LqyYBccf7UAmjTZhndl+2zO7IbuXKPVKZifMCLf+iZvRYw59F7/PlaoL9uIj2cXhX
         D9ULBeA6T1SNgg44kZk858ZDnIvr2bTxnmYgQlXoIyJBSNMzCvhkMN08DnY8CkINwDRj
         4jBgRo6dNBWIhvcZvFX4JFNG98IUSLM3c8sL1xb3POdsqEtTadC73RB+5oAz9pmp1yqw
         wz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7CbX3vi42ZGOMPpEOi1rGvmX1pkFnmfkswzcsMu8F9g=;
        b=HBP+kuhduJ+IfKdtyseHUxLEFtyGojDnnHhT+fWQFpWekGU3r9jXwYkVH5g65VMIKE
         H0tefTvH6O1chNqBErFm7ICbmaWM/Tmmp9r9yAf05yFK6rYB/lsGyK4ToSfF16hqLG17
         stRBROWISn8SOQkcyLExxJVZM0xGYrh9n8fBDVBA7NgtLicQlrXrjhjoMFmpmBzV31xF
         VQdWYmpfDSfZyyMBgC0htXKlD4RRMkzQuNy5iUM7jO2XFWDPwUfe9iW/OoekXt1s2Heq
         8sffSBkjg5osXskt6HadhGtc4RVa/IrpzxjEM9Ejvojp0947aHhPuwVPz/fT6MMnKQvk
         jaxw==
X-Gm-Message-State: ACgBeo37RrTHJfHA/hInrvZUV2v7wcPFG8eLy0sEuFOtKmk3REn5oPa8
        ZzXcmMtXJzvusMzKUuUEOllWFApPwBc3+Q==
X-Google-Smtp-Source: AA6agR4jUE9KX/eVg+ify06PCyMTZ8AQgGHY1+TzKuNlZgnwdClieyo5ucmnluvh5LC/4VwOs8k1Xw==
X-Received: by 2002:a17:902:c945:b0:16d:d425:324a with SMTP id i5-20020a170902c94500b0016dd425324amr22469171pla.7.1661231713837;
        Mon, 22 Aug 2022 22:15:13 -0700 (PDT)
Received: from [10.4.208.12] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id c14-20020a17090a020e00b001f22647cb56sm10908810pjc.27.2022.08.22.22.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 22:15:13 -0700 (PDT)
Message-ID: <c615cfd1-9a80-a753-ceef-116cfbc70ceb@bytedance.com>
Date:   Tue, 23 Aug 2022 13:15:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH 1/7] kernfs: Simply by replacing kernfs_deref_open_node()
 with of_on()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
References: <20220820000550.367085-1-tj@kernel.org>
 <20220820000550.367085-2-tj@kernel.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220820000550.367085-2-tj@kernel.org>
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
> kernfs_node->attr.open is an RCU pointer to kernfs_open_node. However, RCU
> dereference is currently only used in kernfs_notify(). Everywhere else,
> either we're holding the lock which protects it or know that the
> kernfs_open_node is pinned becaused we have a pointer to a kernfs_open_file
> which is hanging off of it.
> 
> kernfs_deref_open_node() is used for the latter case - accessing
> kernfs_open_node from kernfs_open_file. The lifetime and visibility rules
> are simple and clear here. To someone who can access a kernfs_open_file, its
> kernfs_open_node is pinned and visible through of->kn->attr.open.
> 
> Replace kernfs_deref_open_node() which simpler of_on(). The former takes
> both @kn and @of and RCU deref @kn->attr.open while sanity checking with
> @of. The latter takes @of and uses protected deref on of->kn->attr.open.
> 
> As the return value can't be NULL, remove the error handling in the callers
> too.
> 
> This shouldn't cause any functional changes.

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Imran Khan <imran.f.khan@oracle.com>
> ---
>  fs/kernfs/file.c | 56 +++++++++++-------------------------------------
>  1 file changed, 13 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index b3ec34386b43..32b16fe00a9e 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -57,31 +57,17 @@ static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
>  }
>  
>  /**
> - * kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
> - *
> - * @of: associated kernfs_open_file instance.
> - * @kn: target kernfs_node.
> - *
> - * Fetch and return ->attr.open of @kn if @of->list is non empty.
> - * If @of->list is not empty we can safely assume that @of is on
> - * @kn->attr.open->files list and this guarantees that @kn->attr.open
> - * will not vanish i.e. dereferencing outside RCU read-side critical
> - * section is safe here.
> - *
> - * The caller needs to make sure that @of->list is not empty.
> + * of_on - Return the kernfs_open_node of the specified kernfs_open_file
> + * @of: taret kernfs_open_file
>   */
> -static struct kernfs_open_node *
> -kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
> +static struct kernfs_open_node *of_on(struct kernfs_open_file *of)
>  {
> -	struct kernfs_open_node *on;
> -
> -	on = rcu_dereference_check(kn->attr.open, !list_empty(&of->list));
> -
> -	return on;
> +	return rcu_dereference_protected(of->kn->attr.open,
> +					 !list_empty(&of->list));
>  }
>  
>  /**
> - * kernfs_deref_open_node_protected - Get kernfs_open_node corresponding to @kn
> + * kernfs_deref_open_node_locked - Get kernfs_open_node corresponding to @kn
>   *
>   * @kn: target kernfs_node.
>   *
> @@ -96,7 +82,7 @@ kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
>   * The caller needs to make sure that kernfs_open_file_mutex is held.
>   */
>  static struct kernfs_open_node *
> -kernfs_deref_open_node_protected(struct kernfs_node *kn)
> +kernfs_deref_open_node_locked(struct kernfs_node *kn)
>  {
>  	return rcu_dereference_protected(kn->attr.open,
>  				lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
> @@ -207,12 +193,8 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
>  static int kernfs_seq_show(struct seq_file *sf, void *v)
>  {
>  	struct kernfs_open_file *of = sf->private;
> -	struct kernfs_open_node *on = kernfs_deref_open_node(of, of->kn);
> -
> -	if (!on)
> -		return -EINVAL;
>  
> -	of->event = atomic_read(&on->event);
> +	of->event = atomic_read(&of_on(of)->event);
>  
>  	return of->kn->attr.ops->seq_show(sf, v);
>  }
> @@ -235,7 +217,6 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
>  	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
>  	const struct kernfs_ops *ops;
> -	struct kernfs_open_node *on;
>  	char *buf;
>  
>  	buf = of->prealloc_buf;
> @@ -257,14 +238,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		goto out_free;
>  	}
>  
> -	on = kernfs_deref_open_node(of, of->kn);
> -	if (!on) {
> -		len = -EINVAL;
> -		mutex_unlock(&of->mutex);
> -		goto out_free;
> -	}
> -
> -	of->event = atomic_read(&on->event);
> +	of->event = atomic_read(&of_on(of)->event);
>  
>  	ops = kernfs_ops(of->kn);
>  	if (ops->read)
> @@ -584,7 +558,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
>  	struct mutex *mutex = NULL;
>  
>  	mutex = kernfs_open_file_mutex_lock(kn);
> -	on = kernfs_deref_open_node_protected(kn);
> +	on = kernfs_deref_open_node_locked(kn);
>  
>  	if (on) {
>  		list_add_tail(&of->list, &on->files);
> @@ -629,7 +603,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
>  
>  	mutex = kernfs_open_file_mutex_lock(kn);
>  
> -	on = kernfs_deref_open_node_protected(kn);
> +	on = kernfs_deref_open_node_locked(kn);
>  	if (!on) {
>  		mutex_unlock(mutex);
>  		return;
> @@ -839,7 +813,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>  		return;
>  
>  	mutex = kernfs_open_file_mutex_lock(kn);
> -	on = kernfs_deref_open_node_protected(kn);
> +	on = kernfs_deref_open_node_locked(kn);
>  	if (!on) {
>  		mutex_unlock(mutex);
>  		return;
> @@ -874,11 +848,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>   */
>  __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
>  {
> -	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
> -	struct kernfs_open_node *on = kernfs_deref_open_node(of, kn);
> -
> -	if (!on)
> -		return EPOLLERR;
> +	struct kernfs_open_node *on = of_on(of);
>  
>  	poll_wait(of->file, &on->poll, wait);
>  
