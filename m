Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7504A45D761
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 10:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354199AbhKYJmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 04:42:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346684AbhKYJkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637833014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1j3sEyc7U5pLLP7CDKkBf36qc69o78zC3HxT76AE2R0=;
        b=bxRJ0cHsxVoxBs1osi2vNK1d6yKSDIANe8hUIprtvQXyQakPTxZj/SOPZ0+va5e/YNIpVY
        rb6YaaHCbSWIMMqm5xoBeS0xDjfGoN4HGNJ68DAsnEgQPNHKKOB+6LZ2myBieOASq1iAKG
        AdFkwIJTwM1ZAax1+w2bMmUp8/wOZhs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-hjsa0weSPM65eIwIeMyE0w-1; Thu, 25 Nov 2021 04:36:52 -0500
X-MC-Unique: hjsa0weSPM65eIwIeMyE0w-1
Received: by mail-wm1-f69.google.com with SMTP id 201-20020a1c04d2000000b003335bf8075fso2943080wme.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Nov 2021 01:36:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=1j3sEyc7U5pLLP7CDKkBf36qc69o78zC3HxT76AE2R0=;
        b=rOmyNhTVd9jchaFJAbuJ+swLoaSSf626qiTgNyGozVoQyuhPEJ6dsixjS2n9wto/71
         XU+YLjwAUEY8zzFnBtmx4D0IGohYRJK+1XSL0ivDZ15lRszdph9SHM9XtQ97dkeKez6t
         16GqY0e4l944siwb20em+o5Xr8EfoBYB8XIzVTu/uHqHevQKrrCpZ1zRMuVnJ10zT1dP
         38S2GXLlclxCzme9uUiL6DiAWZdayvdZ6NQIyUcAWFFPmjlGGZ7bFiidVmeghp1xselP
         JlXLZ+tfTV/969WzJVxV/HKaD53J47QnIrpid8gbv19G92IPxY4yuDz9Bu5TV+6vQgsh
         2z1Q==
X-Gm-Message-State: AOAM530QL8xOruE071xUHT1poVaIaBcJtGk4fBHbS1Kidyhjc4+h6N9a
        EiUNW5J4eikB5A8Kd5UFYBikhOkdwgLG6PzJ2qNrklyhDO+onYGICRv69mQOuMchGVgetL02/Ye
        ziMQlR0yVLLPgvtS/tgcea9c6sw==
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr5259397wmf.177.1637833011740;
        Thu, 25 Nov 2021 01:36:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNT7yd66eB6qLpcYDn59R65nZF06/c+i4fTo/9h0VU3346D4G4ZX5Keq0oDymUbsMTzkxV8g==
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr5259366wmf.177.1637833011529;
        Thu, 25 Nov 2021 01:36:51 -0800 (PST)
Received: from [192.168.3.132] (p5b0c679e.dip0.t-ipconnect.de. [91.12.103.158])
        by smtp.gmail.com with ESMTPSA id d2sm2428646wmb.31.2021.11.25.01.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 01:36:50 -0800 (PST)
Message-ID: <435fab0b-d345-3698-79af-ff858181666a@redhat.com>
Date:   Thu, 25 Nov 2021 10:36:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] kthread: dynamically allocate memory to store
 kthread's full name
Content-Language: en-US
To:     Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oliver.sang@intel.com, lkp@intel.com,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <20211120112850.46047-1-laoar.shao@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211120112850.46047-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.11.21 12:28, Yafang Shao wrote:
> When I was implementing a new per-cpu kthread cfs_migration, I found the
> comm of it "cfs_migration/%u" is truncated due to the limitation of
> TASK_COMM_LEN. For example, the comm of the percpu thread on CPU10~19 are
> all with the same name "cfs_migration/1", which will confuse the user. This
> issue is not critical, because we can get the corresponding CPU from the
> task's Cpus_allowed. But for kthreads correspoinding to other hardware
> devices, it is not easy to get the detailed device info from task comm,
> for example,
> 
>     jbd2/nvme0n1p2-
>     xfs-reclaim/sdf
> 
> Currently there are so many truncated kthreads:
> 
>     rcu_tasks_kthre
>     rcu_tasks_rude_
>     rcu_tasks_trace
>     poll_mpt3sas0_s
>     ext4-rsv-conver
>     xfs-reclaim/sd{a, b, c, ...}
>     xfs-blockgc/sd{a, b, c, ...}
>     xfs-inodegc/sd{a, b, c, ...}
>     audit_send_repl
>     ecryptfs-kthrea
>     vfio-irqfd-clea
>     jbd2/nvme0n1p2-
>     ...
> 
> We can shorten these names to work around this problem, but it may be
> not applied to all of the truncated kthreads. Take 'jbd2/nvme0n1p2-' for
> example, it is a nice name, and it is not a good idea to shorten it.
> 
> One possible way to fix this issue is extending the task comm size, but
> as task->comm is used in lots of places, that may cause some potential
> buffer overflows. Another more conservative approach is introducing a new
> pointer to store kthread's full name if it is truncated, which won't
> introduce too much overhead as it is in the non-critical path. Finally we
> make a dicision to use the second approach. See also the discussions in
> this thread:
> https://lore.kernel.org/lkml/20211101060419.4682-1-laoar.shao@gmail.com/
> 
> After this change, the full name of these truncated kthreads will be
> displayed via /proc/[pid]/comm:
> 
>     rcu_tasks_kthread
>     rcu_tasks_rude_kthread
>     rcu_tasks_trace_kthread
>     poll_mpt3sas0_statu
>     ext4-rsv-conversion
>     xfs-reclaim/sdf1
>     xfs-blockgc/sdf1
>     xfs-inodegc/sdf1
>     audit_send_reply
>     ecryptfs-kthread
>     vfio-irqfd-cleanup
>     jbd2/nvme0n1p2-8

I do wonder if that could break some user space that assumes these names
have maximum length ..

But LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

