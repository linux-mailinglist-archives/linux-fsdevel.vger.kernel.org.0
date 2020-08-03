Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7879F23A2EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 12:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgHCKv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 06:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCKvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:51:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09464C06174A;
        Mon,  3 Aug 2020 03:51:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so33779576wra.5;
        Mon, 03 Aug 2020 03:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IdESaKkWlfvo0uBfHnXYqiCTf5lHhJBofqFKmP59uxE=;
        b=Sbqg9cNPrmQa5GhSZaGxIaLfMo9LZBHiiY4lhTREyi7HywInVoqwKcvMEDyyupBVvc
         8r9upTWx9W/uCqvny7x8YxgxRgjDJmanYymUAVyca2W6LwiH0XAeC10n9ZTT4WDiGmUI
         mxOIFrM3sEm6Dl6/wzQ71G0OhCozaeAofF2AcHf6Mn1pkbzFzThB1+KY5cEDfiQ8S8OK
         ib1+GNEEJek0xl3PjzaEXEvO4Bq/pdHTS7h8N+X10N8xl0Q9J9RSMjvynogquk2Cbx+e
         VzVmFwa1bG31Sc2J9II3T7ihByxN3jBD/JiX5A332Np1nb5zeEIfqQD6FdvrWj+2cLpl
         fEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IdESaKkWlfvo0uBfHnXYqiCTf5lHhJBofqFKmP59uxE=;
        b=AhafqURZ7QtYlz2UNDQArY6LYx6aE2smd/H/oGPSGySpvjKL1oDFvPed5T/eomGiRd
         fVVJKalT0fSKeQUuxmlohATFXW8Os/wUskzV6MGLDpCR7c3phgdyhdcLCgPgdT8meSMC
         hANr0ZCeZccmwYv+TpXmPgw+9MRaAKW16346lEhE63hFWblBj/Ckrj6b110TgVnv/nQn
         40mrZ2Q1LXpGK1hroV7R4nyfi+eGrfqFJsLL7QNvXdWFA0QuP4+zHNZgTHtE8fjE5JgR
         oKKmEfbh8+gXbHmqtmEFgN6bcGfuw4Fg76Pzz7Pyz/Vl0lLth9rXAS19+sCbtT13XY1/
         CejA==
X-Gm-Message-State: AOAM530kaUJlShq8Fo4FcLHHELvyNSvSb99NZPflQmYAlF6VrdTL9WNG
        kVdtMn3OWa183bW1pDTY6w==
X-Google-Smtp-Source: ABdhPJy6zkLKjZEI1doYho0GbG0ONSPUPYw7Gusq9LKX5ptSiRW2ZRLlOlku9uUAaV5FfoCZa4vObg==
X-Received: by 2002:a5d:4646:: with SMTP id j6mr12910512wrs.293.1596451907763;
        Mon, 03 Aug 2020 03:51:47 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.84])
        by smtp.gmail.com with ESMTPSA id q5sm23184858wrp.60.2020.08.03.03.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 03:51:46 -0700 (PDT)
Date:   Mon, 3 Aug 2020 13:51:44 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
Message-ID: <20200803105144.GA514556@localhost.localdomain>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <87k0yl5axy.fsf@x220.int.ebiederm.org>
 <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
 <875za43b3w.fsf@x220.int.ebiederm.org>
 <9ceb5049-6aea-1429-e35f-d86480f10d72@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ceb5049-6aea-1429-e35f-d86480f10d72@virtuozzo.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 01:03:17PM +0300, Kirill Tkhai wrote:
> On 31.07.2020 01:13, Eric W. Biederman wrote:
> > Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> > 
> >> On 30.07.2020 17:34, Eric W. Biederman wrote:
> >>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> >>>
> >>>> Currently, there is no a way to list or iterate all or subset of namespaces
> >>>> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
> >>>> but some also may be as open files, which are not attached to a process.
> >>>> When a namespace open fd is sent over unix socket and then closed, it is
> >>>> impossible to know whether the namespace exists or not.
> >>>>
> >>>> Also, even if namespace is exposed as attached to a process or as open file,
> >>>> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
> >>>> this multiplies at tasks and fds number.
> >>>
> >>> I am very dubious about this.
> >>>
> >>> I have been avoiding exactly this kind of interface because it can
> >>> create rather fundamental problems with checkpoint restart.
> >>
> >> restart/restore :)
> >>
> >>> You do have some filtering and the filtering is not based on current.
> >>> Which is good.
> >>>
> >>> A view that is relative to a user namespace might be ok.    It almost
> >>> certainly does better as it's own little filesystem than as an extension
> >>> to proc though.
> >>>
> >>> The big thing we want to ensure is that if you migrate you can restore
> >>> everything.  I don't see how you will be able to restore these files
> >>> after migration.  Anything like this without having a complete
> >>> checkpoint/restore story is a non-starter.
> >>
> >> There is no difference between files in /proc/namespaces/ directory and /proc/[pid]/ns/.
> >>
> >> CRIU can restore open files in /proc/[pid]/ns, the same will be with /proc/namespaces/ files.
> >> As a person who worked deeply for pid_ns and user_ns support in CRIU, I don't see any
> >> problem here.
> > 
> > An obvious diffference is that you are adding the inode to the inode to
> > the file name.  Which means that now you really do have to preserve the
> > inode numbers during process migration.
> >
> > Which means now we have to do all of the work to make inode number
> > restoration possible.  Which means now we need to have multiple
> > instances of nsfs so that we can restore inode numbers.
> > 
> > I think this is still possible but we have been delaying figuring out
> > how to restore inode numbers long enough that may be actual technical
> > problems making it happen.
> 
> Yeah, this matters. But it looks like here is not a dead end. We just need
> change the names the namespaces are exported to particular fs and to support
> rename().
> 
> Before introduction a principally new filesystem type for this, can't
> this be solved in current /proc?
> 
> Alexey, does rename() is prohibited for /proc fs?

Techically it is allowed: add ->rename to /proc/ns inode.
But nobody does it.
