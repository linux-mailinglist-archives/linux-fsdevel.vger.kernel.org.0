Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AAE1DB493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 15:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgETNIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 09:08:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34468 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETNIG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 09:08:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id f6so1421001pgm.1;
        Wed, 20 May 2020 06:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oC3CO1dbSoIbsRb/LeuNNuvbNSOpiNXf/liPEnpy158=;
        b=LpB2UG6PNkXlYBbS+rnwrYdal+waUizlpU1kD3u2YnZkE1yKjFFE1QfURoEq1AH0VJ
         dEVaeh9rsWL1qWlygeutMsqXCTQMelvReCtm2XwuOX3dWxBuM2hTAyJNe4mzSFgaiRyJ
         zs51MBW0MhC8HW7COufXv3luLVM8pQtqOXdVqkiXeW8OSD41iGpB3DJ1WVOxET6g+gih
         AhBNFmre98pRK/SYtp4hIfBk1reWNlRKmM+/2E1reKGdf8ebZflYZk5NQz78XVXTKr0H
         h0Rm6YbQqeoxxguuIaiOqb0KoNpzQadkETA13UVi6Gk2gY07t4R37pAA1Aa2X8yUhmK3
         /peA==
X-Gm-Message-State: AOAM533tpcXoMxEnmGCL45bDaBZR819JWiJQqQqzkz0uWvl4Dw2Qd9gD
        hZ4nJApsqNTCh0SWTcswMNz1er6D4yQ=
X-Google-Smtp-Source: ABdhPJxyuQadFi/BPczL9wi1UixCiN30Jo1EXPFYckrbfa3pjL31XvU1Kw4ZvnRcyfwd/dTCpWqcAA==
X-Received: by 2002:a63:b904:: with SMTP id z4mr4117050pge.25.1589980085715;
        Wed, 20 May 2020 06:08:05 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d4sm1899478pgk.2.2020.05.20.06.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 06:08:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 460F74088B; Wed, 20 May 2020 13:08:03 +0000 (UTC)
Date:   Wed, 20 May 2020 13:08:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, keescook@chromium.org,
        yzaikin@google.com, adobriyan@gmail.com, mingo@kernel.org,
        gpiccoli@canonical.com, rdna@fb.com, patrick.bellasi@arm.com,
        sfr@canb.auug.org.au, mhocko@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, vbabka@suse.cz,
        tglx@linutronix.de, peterz@infradead.org,
        Jisheng.Zhang@synaptics.com, khlebnikov@yandex-team.ru,
        bigeasy@linutronix.de, pmladek@suse.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com, alex.huangjianhui@huawei.com
Subject: Re: [PATCH v4 0/4] cleaning up the sysctls table (hung_task watchdog)
Message-ID: <20200520130802.GW11244@42.do-not-panic.com>
References: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
 <20200519203141.f3152a41dce4bc848c5dded7@linux-foundation.org>
 <5574b304-e890-76a9-8190-f705eba8082d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5574b304-e890-76a9-8190-f705eba8082d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 20, 2020 at 12:02:26PM +0800, Xiaoming Ni wrote:
> On 2020/5/20 11:31, Andrew Morton wrote:
> > On Tue, 19 May 2020 11:31:07 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
> > 
> > > Kernel/sysctl.c
> > 
> > eek!
> > 
> > > 
> > >   fs/proc/proc_sysctl.c        |   2 +-
> > >   include/linux/sched/sysctl.h |  14 +--
> > >   include/linux/sysctl.h       |  13 ++-
> > >   kernel/hung_task.c           |  77 +++++++++++++++-
> > >   kernel/sysctl.c              | 214 +++++++------------------------------------
> > >   kernel/watchdog.c            | 101 ++++++++++++++++++++
> > >   6 files changed, 224 insertions(+), 197 deletions(-)
> > 
> > Here's what we presently have happening in linux-next's kernel/sysctl.c:
> > 
> >   sysctl.c | 3109 ++++++++++++++++++++++++++++++---------------------------------
> >   1 file changed, 1521 insertions(+), 1588 deletions(-)
> > 
> > 
> > So this is not a good time for your patch!
> > 
> > Can I suggest that you set the idea aside and take a look after 5.8-rc1
> > is released?
> > 
> 
> ok, I will make v5 patch based on 5.8-rc1 after 5.8-rc1 is released,
> And add more sysctl table cleanup.

Xiaoming, I'll coordinate with you on this offline as I have the fs
kernel/sysctl.c stuff out of the way as well.

  Luis
