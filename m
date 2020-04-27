Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E81BB205
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 01:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgD0X24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 19:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgD0X2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:28:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91E5C0610D5;
        Mon, 27 Apr 2020 16:28:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y25so9769651pfn.5;
        Mon, 27 Apr 2020 16:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3+IHnDhveDGaeKCCK0OYWbU0s/NXx9OTuAol7R/VECo=;
        b=cGIyZLN1vtbT/cGwzzdhiFz4OM0YjsRDk5xuN0Yz842DiSOrJAjPTxJz+DomJSQpKR
         TkeSn6hsRLpEbUTUD/0qfyJn+DMv02u7MVRRQ10nUUv3JK/ROXS5UukiAt66eFXVP7iW
         T+YwDNHD5cYsVyqzlmbNb8BHQoFUJfxjkksitV0QPa4yyvfvz8GFBIctncwcgP/eHhJZ
         fFZbhnYLnHWbpWvLZX69/VobPVATQWF11yfrphPZGRHr9lrUNoc770UaVMpGHFDsmX7Y
         qvfOd4Do0r8C+KVktJUzrVMN6xBL7pG/7iJUHG6B1wN/X97u/jsBbVJzxxpoGYN8mwGK
         evNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=3+IHnDhveDGaeKCCK0OYWbU0s/NXx9OTuAol7R/VECo=;
        b=PUH5LHDyq+E45PsMA8Ew4dOuuAdIZmnCM6Rv59nBHnoVD/SgsSekJrFINXEUxmKfUN
         aFTo0Vn9PORM3xd89rLWoYEUHjlRujjE/pR9cJaj5XoXc+6+JTzFgs0kIrcvTvjePUzc
         lGSrZkA692r8v5ldadcKzbfxBVifDPSKi2BNbqvkpuiQE4GEPn9+3msxyrOxziLPQI2p
         xfsWIzm06R5JK+JaawR8yZaTXCvX1mcH8l3I2VDcCyZ7orM/j7RwOQSPP+U8ZySDp9Av
         LGmSRdcLvSOCjM+MMYY/5pqdIOw4IjtK7HQUOfZftn+gfrkgOwlDuA+elMM8g6VD862Z
         pMTw==
X-Gm-Message-State: AGi0PuaBFGkOeAxPZQHnIO03bYGE7bqSpissk3xQwklMg0J2OXy3cJGw
        eFkF3o92NrL6TDitJ3IYFwI=
X-Google-Smtp-Source: APiQypJtJ9ReIfTtyu5z3RxVDsRD7/rjAa3M3BxCSTrSlWeZnLHG1eQze305qm1kgwA01zyl/Ltaog==
X-Received: by 2002:a63:1823:: with SMTP id y35mr25701371pgl.25.1588030134185;
        Mon, 27 Apr 2020 16:28:54 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id x12sm13510217pfq.209.2020.04.27.16.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 16:28:53 -0700 (PDT)
Date:   Mon, 27 Apr 2020 16:28:51 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2020-04-26-00-15 uploaded (mm/madvise.c)
Message-ID: <20200427232851.GC163745@google.com>
References: <20200426071602.ZmQ_9C0ql%akpm@linux-foundation.org>
 <bec3b7bd-0829-b430-be1a-f61da01ac4ac@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bec3b7bd-0829-b430-be1a-f61da01ac4ac@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 26, 2020 at 10:26:01AM -0700, Randy Dunlap wrote:
> On 4/26/20 12:16 AM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-04-26-00-15 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.
> 
> Hi,
> I'm seeing lots of build failures in mm/madvise.c.
> 
> Is Minchin's patch only partially applied or is it just missing some pieces?
> 
> a.  mm/madvise.c needs to #include <linux/uio.h>
> 
> b.  looks like the sys_process_madvise() prototype in <linux/syscalls.h>
> has not been updated:

I screwed up. Sorry about that.
Thanks for the fixing, Randy and Andrew.
> 
> In file included from ../mm/madvise.c:11:0:
> ../include/linux/syscalls.h:239:18: error: conflicting types for ‘sys_process_madvise’
>   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                   ^
> ../include/linux/syscalls.h:225:2: note: in expansion of macro ‘__SYSCALL_DEFINEx’
>   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~
> ../include/linux/syscalls.h:219:36: note: in expansion of macro ‘SYSCALL_DEFINEx’
>  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
>                                     ^~~~~~~~~~~~~~~
> ../mm/madvise.c:1295:1: note: in expansion of macro ‘SYSCALL_DEFINE6’
>  SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
>  ^~~~~~~~~~~~~~~
> In file included from ../mm/madvise.c:11:0:
> ../include/linux/syscalls.h:880:17: note: previous declaration of ‘sys_process_madvise’ was here
>  asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
>                  ^~~~~~~~~~~~~~~~~~~
> 
> thanks.
> -- 
> ~Randy
> 
