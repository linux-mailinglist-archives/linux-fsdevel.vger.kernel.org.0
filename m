Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4436F4AB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 21:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjEBT6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 15:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjEBT6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 15:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1E519AB
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683057485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKHeKqZ6mdgIeuKnPtdj2k6l6vY7S9mG2MmFei8RXi4=;
        b=Z315wsyMyOkmDSjKFMGSwUrlxAuP0RUw8y4ckDHTcnTO7W1A6FhxmcMX/CeUyV/wG6L+SR
        wIRk08OwipXpL+8O8JeRIeAWePbWuLC0WWCM9W0x5lIM54vKllcC/+KilaRvU8+yTMU6RI
        jrxIwI/l3AQRCFUfsuyfFMT+1eTeZZU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-dz7xzQJCPRCcb_wYvyeVtg-1; Tue, 02 May 2023 15:58:02 -0400
X-MC-Unique: dz7xzQJCPRCcb_wYvyeVtg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 417D8A0F386;
        Tue,  2 May 2023 19:58:01 +0000 (UTC)
Received: from [10.22.10.239] (unknown [10.22.10.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBAAB492B03;
        Tue,  2 May 2023 19:58:00 +0000 (UTC)
Message-ID: <3005132d-7d05-0b7f-09f4-1956e42b6e2a@redhat.com>
Date:   Tue, 2 May 2023 15:58:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/3] cgroup: Drop unused function for cgroup_path
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
References: <20230502133847.14570-1-mkoutny@suse.com>
 <20230502133847.14570-2-mkoutny@suse.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230502133847.14570-2-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/2/23 09:38, Michal Koutný wrote:
> There is no current user and there are alternative methods to obtain
> task's cgroup path.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cgroup.c | 39 ---------------------------------------
>   1 file changed, 39 deletions(-)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 625d7483951c..55e5f0110e3b 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2378,45 +2378,6 @@ int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
>   }
>   EXPORT_SYMBOL_GPL(cgroup_path_ns);
>   
> -/**
> - * task_cgroup_path - cgroup path of a task in the first cgroup hierarchy
> - * @task: target task
> - * @buf: the buffer to write the path into
> - * @buflen: the length of the buffer
> - *
> - * Determine @task's cgroup on the first (the one with the lowest non-zero
> - * hierarchy_id) cgroup hierarchy and copy its path into @buf.  This
> - * function grabs cgroup_mutex and shouldn't be used inside locks used by
> - * cgroup controller callbacks.
> - *
> - * Return value is the same as kernfs_path().
> - */
> -int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
> -{
> -	struct cgroup_root *root;
> -	struct cgroup *cgrp;
> -	int hierarchy_id = 1;
> -	int ret;
> -
> -	cgroup_lock();
> -	spin_lock_irq(&css_set_lock);
> -
> -	root = idr_get_next(&cgroup_hierarchy_idr, &hierarchy_id);
> -
> -	if (root) {
> -		cgrp = task_cgroup_from_root(task, root);
> -		ret = cgroup_path_ns_locked(cgrp, buf, buflen, &init_cgroup_ns);
> -	} else {
> -		/* if no hierarchy exists, everyone is in "/" */
> -		ret = strscpy(buf, "/", buflen);
> -	}
> -
> -	spin_unlock_irq(&css_set_lock);
> -	cgroup_unlock();
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(task_cgroup_path);
> -
>   /**
>    * cgroup_attach_lock - Lock for ->attach()
>    * @lock_threadgroup: whether to down_write cgroup_threadgroup_rwsem

I went to a few of earlier Linux version down to v3.11. 
task_cgroup_path() doesn't seems to have any users in my few attempts. 
Anyway,

Reviewed-by: Waiman Long <longman@redhat.com>

