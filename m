Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7643FFD67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348937AbhICJqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 05:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348880AbhICJqH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630662307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/vGWzQqDyFpKhyOh2wIj+Kx4GVFTcdYuhnpoMJMGvEA=;
        b=HOaWSbxaoOijHJtzyyvY+jf0zlsY3B4I917IjTuiLRM2TgCzjyYxgRfYPaUAjmmYVxyN2t
        SHrxkmUMa68gsbF05Pu5Wev5/6y0Sav5qdsEMts0p5OAlztJYRrSajm5VAQYBQy8sRk4ss
        KSrJNiV8K3vbG9IrSrs5ylcwRgF43gY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-r6Fd9ulzNoG_SMfrJZHUQQ-1; Fri, 03 Sep 2021 05:45:06 -0400
X-MC-Unique: r6Fd9ulzNoG_SMfrJZHUQQ-1
Received: by mail-wr1-f72.google.com with SMTP id n1-20020a5d4c41000000b00159305d19baso1387227wrt.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Sep 2021 02:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/vGWzQqDyFpKhyOh2wIj+Kx4GVFTcdYuhnpoMJMGvEA=;
        b=tW/t8nk0W3UcAPxhHety/pcGp1iFAVuc8oVqtHhKZp25Vh637Fc1NSl599pTnGmDnf
         kchqVDgF6x+3X36PQ+id29dYGGCDv2zLlHMIoJEPA325BGo66Mu+l84Jjwfk0nIciI/V
         fhBwgtz0CWzeD7jmjEEsRDMopglYbwdyXiV6MJSy6yduLrcvcmaKKMqhMtWyq9Hbc8F4
         DdEU24/6GiAe6DcPdjyN4tSFPWB9+4U8UCsXNbBpyZFvYoxFaodO+L/17i9xAU6gQNES
         m+DBiC2BQEhSNRubrowhhVUKCSZxooWtmqEPSkfQ1B+sx2f5mYrI77jlhBgo9ljkCVr5
         oEeg==
X-Gm-Message-State: AOAM531E5vVLhsJAODmkZHWJDoRvUL74fzNLonjYj51lC2jwRcONYuNt
        51NCojUE9F7yUySIhdNHh9/ymjWf5pM3GiL+r+tnxUIi8RTTRs7XBBiXq4X/exfIqCZYCp5ruSL
        9eOQmypoFsOudDYtAAtzi9Di+/w==
X-Received: by 2002:a5d:534c:: with SMTP id t12mr2933363wrv.219.1630662305222;
        Fri, 03 Sep 2021 02:45:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp4wZnhZMdzpuRGRjPbO89lNQeoyMiOxBHqBuOuGQAYy9XHQ2xW00EnKcwVfrZ6lqnhbC09Q==
X-Received: by 2002:a5d:534c:: with SMTP id t12mr2933309wrv.219.1630662305062;
        Fri, 03 Sep 2021 02:45:05 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e05.dip0.t-ipconnect.de. [79.242.62.5])
        by smtp.gmail.com with ESMTPSA id v21sm4449203wra.92.2021.09.03.02.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 02:45:03 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] Remove in-tree usage of MAP_DENYWRITE
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210816194840.42769-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7c57a16b-8184-36a3-fcdc-5e751184827b@redhat.com>
Date:   Fri, 3 Sep 2021 11:45:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816194840.42769-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.08.21 21:48, David Hildenbrand wrote:
> This series removes all in-tree usage of MAP_DENYWRITE from the kernel
> and removes VM_DENYWRITE. We stopped supporting MAP_DENYWRITE for
> user space applications a while ago because of the chance for DoS.
> The last renaming user is binfmt binary loading during exec and
> legacy library loading via uselib().
> 

So, how do we want to continue with this? Pick it up for v5.15? Have it 
in -next for a while and eventually pick it up for v5.16?

I think the "remove ETXTBSY completely" and "remove the sanity mapping 
check" thingies should be done on top.

-- 
Thanks,

David / dhildenb

