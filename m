Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402AF44D4C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 11:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhKKKLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 05:11:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232892AbhKKKLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636625305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GiHlgUAmwsKT+hTugq3VkakjXKCs0k5+tiUaL6hbwdA=;
        b=J1Dlqh1ezSCuU5WBAK40eNEzwXjdReBVb6Fwl7iFbz7MaQL+WI7TbvS6TLlr+VXUDLy8d3
        x2dNn6KR4fdSVZfO7BbLxn+VwveMJlAG8Gh9QFyg1tC/pLEvPhAPy/rCsQcPqhtN/l4FMD
        K/1ryc8T+Tu7jz/DTcSOehK0avRdWLM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-89hW5tUXPC-25GqWkioneQ-1; Thu, 11 Nov 2021 05:08:24 -0500
X-MC-Unique: 89hW5tUXPC-25GqWkioneQ-1
Received: by mail-wm1-f72.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso4576123wmb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 02:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=GiHlgUAmwsKT+hTugq3VkakjXKCs0k5+tiUaL6hbwdA=;
        b=7NNkpJTOFo8PSatVEwaOpYqRl59KIsDPk+wvxjb9s9aXUSDerDJ8C3L87t2pby7Uyp
         rNnpqS0sIXu+1PhVpH+xfbyidnVjuwnV9ADOiwwO5Crvo2u/VB7B5jOM7VyDFOa51Glw
         7aoabq6sD43JS0miS8m6C+ypDyOwjzACM4NPFMzVqezfu+nupG7AjYEoFPeew3V3jVGV
         mM0rqxAxyvn1S8JGgbBrfxdjL7R9QOxZGK0sDka1JtvyEbHbCpz5CSqY6KbIMZrdLmET
         9xs7yYomsj1zY/JF/WJCmy8kHocnQ8O2FEEAG0V21wuEmGwmC5RXjJuWRS8fP8d42dbt
         m9OQ==
X-Gm-Message-State: AOAM5308l+nzktO1xmXz1l131zDn5FnSPlS1Da1GPrv1PYy5tQrQMXB/
        qvE4RkIjkaH+t1D713urar9o4XhtuQaD3jFacSzwH8TMK+uViuBGP7NXc6qFglmBjOKUi9akS5T
        4yA7VuuNjdQfXyRw8LVLXdyFBdQ==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr7550621wry.415.1636625303235;
        Thu, 11 Nov 2021 02:08:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6xfbJxVXU/0Vk9IV0rvq5JIqAJLSbOfFYTCvTXeNfro03lA0NI5R+gVHhWEw6LtsXRfL2QQ==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr7550593wry.415.1636625303017;
        Thu, 11 Nov 2021 02:08:23 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ee8.dip0.t-ipconnect.de. [79.242.62.232])
        by smtp.gmail.com with ESMTPSA id l4sm2372769wrv.94.2021.11.11.02.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 02:08:22 -0800 (PST)
Message-ID: <e7778942-6220-949b-72f1-fa4fc4ffbfee@redhat.com>
Date:   Thu, 11 Nov 2021 11:08:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 6/7] tools/bpf/bpftool/skeleton: use
 bpf_probe_read_kernel_str to get task comm
Content-Language: en-US
To:     Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oliver.sang@intel.com, lkp@intel.com,
        Andrii Nakryiko <andrii@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>
References: <20211108083840.4627-1-laoar.shao@gmail.com>
 <20211108083840.4627-7-laoar.shao@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211108083840.4627-7-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.11.21 09:38, Yafang Shao wrote:
> bpf_probe_read_kernel_str() will add a nul terminator to the dst, then
> we don't care about if the dst size is big enough.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

