Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A49442A5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 10:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhKBJ3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 05:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229778AbhKBJ3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635845204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Knb795FyS1otYhncpNSxpdeSg0gR1wnUhjNSfjb9rwI=;
        b=jDr064UReEPLwvorQXPZSLIln28hjzDeyaVW9HRw3wXfo3/BTNUg/P3Fk3Y3KGfFEaghmS
        QeeSFLgDS9vSfy60gqkYVXn/5NZYTaI6TB+73mNUvDuKk8Ch0uHAfCpg5yh42Upc9pvhnh
        rdR4nN2YD66O30c5GIMmfoONxsWJRI0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-MhszdTSVMR-0bLWDFrglaw-1; Tue, 02 Nov 2021 05:26:43 -0400
X-MC-Unique: MhszdTSVMR-0bLWDFrglaw-1
Received: by mail-wr1-f69.google.com with SMTP id q17-20020adff791000000b00183e734ba48so2646737wrp.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Nov 2021 02:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Knb795FyS1otYhncpNSxpdeSg0gR1wnUhjNSfjb9rwI=;
        b=thiun5FuyUd0dnyBLdNw/TmsXPqFu21bDW04rg7YO6VuGLrogbuhYPWkl3rFrhl3x0
         yjQuVo3LFWGKOR086pSZ/fJBuk9Xvw/oUB3wyARmaNzUwHqhbRuoVX9E2nEQbOH6jSwL
         xALeAFc4pdrl6I9xPbXZgXifuFex+52Yopa5HoqJnN1SbrMiB4fTEuPaoTCXUPlbajA7
         jzn1Hsc3sHPGiOftxarR6ljKQzxspdqDRffWpAxzBdKuIN1hZ7wcXu4nSaz+JdCOIZT+
         X0CAW0H37qZ/KLR6M9Xv3juqK+9ga56UUgpMHZMjgc2EaR3dRwRvhI6Y1SPJrhYw0hjj
         eOTg==
X-Gm-Message-State: AOAM5332XicuzZVnnTMzqpM5HACJWlqWPgLskrfgGM9cIrLp8quohU5C
        HkbLBCtG4yNdHNgZKDMoOSp5D1rTQWePUNEpnk5ZRJW6JMTBQYF9zKfn16EQpWxAB7tmfO/7nMD
        SKwmba7rM1YxXlpBgaPAk4MQZhQ==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr8312836wrz.76.1635845202269;
        Tue, 02 Nov 2021 02:26:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypuONJhUPgkx5zdRXtO6PQwaMjrkRCxaI9v4ONJpzmi2h2qNNgIeiTS5/GOGnrjpahGsiP2w==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr8312796wrz.76.1635845202112;
        Tue, 02 Nov 2021 02:26:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6810.dip0.t-ipconnect.de. [91.12.104.16])
        by smtp.gmail.com with ESMTPSA id c17sm16076995wrv.22.2021.11.02.02.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 02:26:41 -0700 (PDT)
Message-ID: <e2695a2d-69bb-52ac-d5b9-fe9e5296393b@redhat.com>
Date:   Tue, 2 Nov 2021 10:26:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 00/11] extend task comm from 16 to 24
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Yafang Shao <laoar.shao@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qiang Zhang <qiang.zhang@windriver.com>,
        robdclark <robdclark@chromium.org>,
        christian <christian@brauner.io>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        kbuild test robot <lkp@intel.com>
References: <20211101060419.4682-1-laoar.shao@gmail.com>
 <YX/0h7j/nDwoBA+J@alley>
 <CALOAHbA61RyGVzG8SVcNG=0rdqnUCt4AxCKmtuxRnbS_SH=+MQ@mail.gmail.com>
 <YYAPhE9uX7OYTlpv@alley>
 <CALOAHbAx55AUo3bm8ZepZSZnw7A08cvKPdPyNTf=E_tPqmw5hw@mail.gmail.com>
 <20211101211845.20ff5b2e@gandalf.local.home>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211101211845.20ff5b2e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> 2.  Keep the current comm[16] as-is and introduce a separate pointer
>> to store kthread's long name
> 
> I'm OK with this. Hopefully more would chime in too.

What you propose sounds sane to me.


-- 
Thanks,

David / dhildenb

