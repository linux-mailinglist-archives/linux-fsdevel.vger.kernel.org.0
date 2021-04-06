Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4090355FA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 01:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbhDFXle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 19:41:34 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:43666 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhDFXld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:41:33 -0400
Received: by mail-wr1-f50.google.com with SMTP id x7so15927982wrw.10;
        Tue, 06 Apr 2021 16:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGIJa+EXD8Vc5DJNrcReg/z+0EimDhG6rdWhVbzOtFo=;
        b=CQ0qDAptkIC6tW/QjkTYrwKTt0DT9a42qy4lPFnM4r8k/4F8gSOYBBIuxE740H2p17
         RzmddTwaAv6ON0mKDDGrTQ6ejGZHjVorX9afl/5ZGJngAeB9LXBEdWJPOtKSHcClEYja
         0GjWEUNfq94P3RHscsbNIMkuH9FGu2li59VWTnaAVpPcb4LCyp5zxjiF70kZ7aHou89A
         A5ehGdBDBRM3f535in/qXuwptNZI9m7TKz+9vUC1WCUQPsnYxV5jcoDDQ8nW/hpGEKKf
         eZS9buyKs29dE3EZCwG9rgsK/8mRQdPH3naKt8fipJEepHd10wqBgeYZGmdh3vQNY2v3
         fL+w==
X-Gm-Message-State: AOAM530oOUJ5jVaY3a5Wy5DIziWoTD0+ujeXIKTmzuteUQPdNU4wCtP5
        65me661JHs864WiPuxyJDYg=
X-Google-Smtp-Source: ABdhPJwgTgzHjDtAphSOcIvZkNyZiSytk4BvPsB6Agc23uPs67Vxh0ob67DGX16DGyXt0HXr4p5bpg==
X-Received: by 2002:a5d:5612:: with SMTP id l18mr791487wrv.28.1617752483246;
        Tue, 06 Apr 2021 16:41:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f9sm4864133wmj.38.2021.04.06.16.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 16:41:23 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:41:21 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-remoteproc@vger.kernel.org, linux-arch@vger.kernel.org,
        kexec@lists.infradead.org, rcu@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Corey Minyard <minyard@acm.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
Message-ID: <20210406234121.4ebbaoxyrzdywdj4@liuwe-devbox-debian-v2>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out panic and
> oops helpers.
> 
> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
