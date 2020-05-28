Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338231E6A19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 21:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406211AbgE1TIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 15:08:35 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:44029 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406081AbgE1TId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 15:08:33 -0400
Received: by mail-ej1-f67.google.com with SMTP id a2so1108946ejb.10;
        Thu, 28 May 2020 12:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=A3AB3XwTTYzt1zONUlGDw1t5RFjEaflenV4Wqzl2A4A=;
        b=gPbV4Hx/5UZ7SPPS8e8R1QNd+d1fPglmN4O+z0VaSDvGSE1/l7B9hrCXrrMlEF6vab
         EazsmY6iRVVWdDogBnBhasX8moWX6PhVetpjHmoSVjbGhnoskmlm28b9YHH2l9A5g5j4
         9UJBLWBPDRKOfX4RFxV+XeTm4THSO+L/YH1k1j0H4i7XmacjGd4vzKGepURymiy+ceIa
         6Rnj8zYXWGVYnBsZr6dPonYm1D+lf4VR56VUjR5mQjQO5r7ASs2Z79LLHSI+xPbSS+b/
         cvJMxoXzROpqWWyPO+nBodgAs3INjqDdWvS9VE1M4IgelNV6oIZl+Qq7TimRvtXE6m+A
         UFAw==
X-Gm-Message-State: AOAM531spj+Jx2Vi4qdqvpqbuGZYcM5EM4msc/Bfg0LEbN9k3YJT0NDr
        ByHDQgjwTKLq05voLxgnYl6YaleKN7w=
X-Google-Smtp-Source: ABdhPJxHprawmsGEdEbW5FMlvuq5wQanGA4PqoeRbJBN6xHhW/L2Fvt/XHMK8cJRmwE1KMis7HFL1g==
X-Received: by 2002:a17:906:7d90:: with SMTP id v16mr4270015ejo.554.1590692911706;
        Thu, 28 May 2020 12:08:31 -0700 (PDT)
Received: from darkstar ([51.154.17.58])
        by smtp.gmail.com with ESMTPSA id j31sm1208387edb.12.2020.05.28.12.08.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 May 2020 12:08:30 -0700 (PDT)
References: <20200511154053.7822-1-qais.yousef@arm.com> <20200528132327.GB706460@hirez.programming.kicks-ass.net> <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com> <20200528161112.GI2483@worktop.programming.kicks-ass.net> <20200528165130.m5unoewcncuvxynn@e107158-lin.cambridge.arm.com> <20200528182913.GQ2483@worktop.programming.kicks-ass.net>
User-agent: mu4e 1.4.3; emacs 26.3
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default boost value
In-reply-to: <20200528182913.GQ2483@worktop.programming.kicks-ass.net>
Message-ID: <878shb3mj6.derkling@matbug.net>
Date:   Thu, 28 May 2020 21:08:29 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


[+Giovanni]

On Thu, May 28, 2020 at 20:29:14 +0200, Peter Zijlstra <peterz@infradead.org> wrote...

> On Thu, May 28, 2020 at 05:51:31PM +0100, Qais Yousef wrote:

>> I had a humble try to catch the overhead but wasn't successful. The observation
>> wasn't missed by us too then.
>
> Right, I remember us doing benchmarks when we introduced all this and
> clearly we missed something. I would be good if Mel can share which
> benchmark hurt most so we can go have a look.

Indeed, would be great to have a description of their test setup and
results. Perhaps Giovanni can also support us on that.

