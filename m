Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBCF2DFF41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 19:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgLUSGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 13:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgLUSGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:06:22 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B17C061282
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 10:05:41 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id b9so14746319ejy.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Dec 2020 10:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDT3CMWkb5v4KlAY6bNjmDFLqwN6ZEiRSV+Z6DSzr0s=;
        b=jrj8LYfQ+G2abRBjq/EQNO52IGqX1ROGqjr73asfsMUx2io1t/Kj5vaWeNRQ05QBws
         7ORYHBk1SfigU2h39+yGI1Lk3AhN50Cgw2pM71/m4zP1hwb+ikD3+K55GDIFL6cu4N9x
         ZXqkVEqq4e9zYCD39Pgl2Yl2UyuINtmv3u1EhVxYVIV2oRUT+oNTfNWmFPJ0oiSuI1AA
         DmducotL7D+1FUZXOZvqHAm9lf7QMa82bUozYx7IzidUTWK7x6Iib27Ho/jYH5ne0Z0S
         Of1Dbmmu0Q124UefwB1rJjBdPSQEFSj36Hggs/J2Zs9T0HFyX0niq795BUINRYC4pEQ5
         L9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDT3CMWkb5v4KlAY6bNjmDFLqwN6ZEiRSV+Z6DSzr0s=;
        b=TGf8uJAjHpoAXT8mnn8zB1/vbKuGwuWFKz1TBe3BjzCDSst8+c0T25QFkjr+05FR7G
         azpGX9K53Moo7NLvWKNoXtUAEcYEzkPmD1ue0kFwhyoAlr+6ZbT8kwNq3SjSQed5uHT5
         ZRWwgSVQh9z/2SqiYsjIUZlDb5P2mBLDC72D4cKzdrIfT8WgMDmXkdQ4f3xLvMjlssYx
         NtD4Wkl8V8IsYn99PK+6ZfHsT0ysTG/HsBJLgV/Lli98SaGd3ER74QjvGmBrRrW3LN+h
         LSXE9bj/NrZdGdpMyv7gaOvNGFR65FQg+swE3Fk18v1iyQzM1iaUfuh85xK0zQXLVlCS
         tn4w==
X-Gm-Message-State: AOAM532n6bffrj5TYpwDqJakrN6tN+krPMYfFa5vfsffFqbO0c6Uy3fK
        CydMYOG3GAFR6LRWImYCnB+ax2GRczoO84IpPsnDVA1Sow==
X-Google-Smtp-Source: ABdhPJwPBtlia5uDw63ingozAyc7AR0jROeP8m6nydP3bWYSBIMRH20XUWt+8TeXFSZsv23dBiOY4HZ+Ga0eJQoO4Vg=
X-Received: by 2002:a17:907:d9e:: with SMTP id go30mr15735065ejc.488.1608570889830;
 Mon, 21 Dec 2020 09:14:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608225886.git.rgb@redhat.com> <982b9adffbd32264a853fe7f4f06f0d0a882c11d.1608225886.git.rgb@redhat.com>
In-Reply-To: <982b9adffbd32264a853fe7f4f06f0d0a882c11d.1608225886.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Dec 2020 12:14:38 -0500
Message-ID: <CAHC9VhSTuBJ3LXxMY=nD7qBzmKLDjXY0V3hsuN34_siq_xRrig@mail.gmail.com>
Subject: Re: [PATCH ghak90 v10 01/11] audit: collect audit task parameters
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux Containers List <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Linux FSdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Neil Horman <nhorman@tuxdriver.com>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Simo Sorce <simo@redhat.com>,
        Eric Paris <eparis@parisplace.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:57 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The audit-related parameters in struct task_struct should ideally be
> collected together and accessed through a standard audit API and the audit
> structures made opaque to other kernel subsystems.
>
> Collect the existing loginuid, sessionid and audit_context together in a
> new opaque struct audit_task_info called "audit" in struct task_struct.
>
> Use kmem_cache to manage this pool of memory.
> Un-inline audit_free() to be able to always recover that memory.
>
> Please see the upstream github issues
> https://github.com/linux-audit/audit-kernel/issues/81
> https://github.com/linux-audit/audit-kernel/issues/90
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Neil Horman <nhorman@tuxdriver.com>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

Did Neil and Ondrej really ACK/Review the changes that you made here
in v10 or are you just carrying over the ACK/Review?  I'm hopeful it
is the former, because I'm going to be a little upset if it is the
latter.

> ---
>  fs/io-wq.c            |   8 +--
>  fs/io_uring.c         |  16 ++---
>  include/linux/audit.h |  49 +++++---------
>  include/linux/sched.h |   7 +-
>  init/init_task.c      |   3 +-
>  init/main.c           |   2 +
>  kernel/audit.c        | 154 +++++++++++++++++++++++++++++++++++++++++-
>  kernel/audit.h        |   7 ++
>  kernel/auditsc.c      |  24 ++++---
>  kernel/fork.c         |   1 -
>  10 files changed, 205 insertions(+), 66 deletions(-)

-- 
paul moore
www.paul-moore.com
