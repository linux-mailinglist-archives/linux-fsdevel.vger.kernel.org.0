Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61002DDF5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 09:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbgLRICM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 03:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgLRICL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:02:11 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27833C0617A7;
        Fri, 18 Dec 2020 00:01:28 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o13so3200232lfr.3;
        Fri, 18 Dec 2020 00:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DWXWwMxuO5VVgTeHS2MDsqO66san9FIaw5EJpdNOYwY=;
        b=lT52rP0ePFZFuLL4A4f+0puqMLAsNvs8IM2du26nu5GK85lcGZXB6g2+aeZnRU4PYX
         p/XGsGT8+RQvFOALsaaS6FLI7wdEsAlf5T0zRzE3q++LUytIajAVO//IAIzqee5Ym/cc
         SgznQo3koMaGw2jNODT8oNkVC+OrLDV13CUBQmX05J9830chh96vhqxCdtFkXrH/wzxU
         usQ9dwwHAOgOdad1wlfLDBJsUTKgGfFaRn2J3Wb+uP8rocOWHAAYb6qZcf7VZlUM0dwu
         lEFw4BeD/77Ag0tOVkXETcTuqA08il9WnsDKRQZQisDNEdgVx4KQVWiegNCgcwkRXHjQ
         44LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DWXWwMxuO5VVgTeHS2MDsqO66san9FIaw5EJpdNOYwY=;
        b=AQB2vRV464rcIT+u9aAZMatO6SvXlJu+yGb+HAToRiguRfM2W4UDo/0Kmd82aRWAcf
         6Yx4rwJjbcZ1dnoGu8coxo64WElrt63i8B/ZuvhT0XBApSyDFKgmZkz9sIx1NBuACQH0
         m96jZMREdBzNGeWEMkJTPHEpBpCI020AUjymxBF56CrR1ej5n8HwBOItj/W9KMcuLavb
         Dzn8Tws2FXI4ss3FnqNYQSvtztWto5CT29ggzoJoGF7yUXyRKnnXRq2LqTNU+G79dxDY
         /AbpUSr/1ORPUt8Kt1eIOumjTiCbKiwz/TMZHc1Acy1PLp6PLgECTUJgcQ8mAjlIUfvA
         XFng==
X-Gm-Message-State: AOAM533FWRyW0Zi6Dlzn6kwJl26w+srX40uIyo5kXUE1F7unToE4trpM
        f7xM4fisBfwKF5rx6yqC30ATCLTA3+zdlrekr8c0edjiDFVDsCJcF8E=
X-Google-Smtp-Source: ABdhPJz8UHuSQ4+Ai4tOHxW6C1UIqWY8YcCQlMgp0t5lXDW/Hv8Q/IuwKgsfqr+9BT3/Q0kEZBbv9shGjPwy6FnJyVI=
X-Received: by 2002:a2e:9c82:: with SMTP id x2mr1298415lji.190.1608278486487;
 Fri, 18 Dec 2020 00:01:26 -0800 (PST)
MIME-Version: 1.0
References: <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
 <CAC2o3DJdHuQxY7Rn5uXUprS7i8ri1qB=wOUM2rdZkWt4yJHv1w@mail.gmail.com>
 <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
 <CAC2o3DLGtx15cgra3Y92UBdQRBKGckqOkDmwBV-aV-EpUqO5SQ@mail.gmail.com>
 <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
 <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
 <CAC2o3DJsvB6kj=S6D3q+_OBjgez9Q9B5s3-_gjUjaKmb2MkTHQ@mail.gmail.com>
 <c4002127c72c07a00e8ba0fae6b0ebf5ba8e08e7.camel@themaw.net>
 <a39b73a53778094279522f1665be01ce15fb21f4.camel@themaw.net>
 <c8a6c9adc3651e64cf694f580a8cb3d87d7cb893.camel@themaw.net>
 <X9t1xVTZ/ApIvPMg@mtj.duckdns.org> <67a3012a6a215001c8be9344aee1c99897ff8b7e.camel@themaw.net>
In-Reply-To: <67a3012a6a215001c8be9344aee1c99897ff8b7e.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Fri, 18 Dec 2020 16:01:14 +0800
Message-ID: <CAC2o3DJhx+dJX-oMKSTNabWYyRB750VABib+OZ=7UX6rGJZD5g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency improvement
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 18, 2020 at 3:36 PM Ian Kent <raven@themaw.net> wrote:
>
> On Thu, 2020-12-17 at 10:14 -0500, Tejun Heo wrote:
> > Hello,
> >
> > On Thu, Dec 17, 2020 at 07:48:49PM +0800, Ian Kent wrote:
> > > > What could be done is to make the kernfs node attr_mutex
> > > > a pointer and dynamically allocate it but even that is too
> > > > costly a size addition to the kernfs node structure as
> > > > Tejun has said.
> > >
> > > I guess the question to ask is, is there really a need to
> > > call kernfs_refresh_inode() from functions that are usually
> > > reading/checking functions.
> > >
> > > Would it be sufficient to refresh the inode in the write/set
> > > operations in (if there's any) places where things like
> > > setattr_copy() is not already called?
> > >
> > > Perhaps GKH or Tejun could comment on this?
> >
> > My memory is a bit hazy but invalidations on reads is how sysfs
> > namespace is
> > implemented, so I don't think there's an easy around that. The only
> > thing I
> > can think of is embedding the lock into attrs and doing xchg dance
> > when
> > attaching it.
>
> Sounds like your saying it would be ok to add a lock to the
> attrs structure, am I correct?
>
> Assuming it is then, to keep things simple, use two locks.
>
> One global lock for the allocation and an attrs lock for all the
> attrs field updates including the kernfs_refresh_inode() update.
>
> The critical section for the global lock could be reduced and it
> changed to a spin lock.
>
> In __kernfs_iattrs() we would have something like:
>
> take the allocation lock
> do the allocated checks
>   assign if existing attrs
>   release the allocation lock
>   return existing if found
> othewise
>   release the allocation lock
>
> allocate and initialize attrs
>
> take the allocation lock
> check if someone beat us to it
>   free and grab exiting attrs
> otherwise
>   assign the new attrs
> release the allocation lock
> return attrs
>
> Add a spinlock to the attrs struct and use it everywhere for
> field updates.
>
> Am I on the right track or can you see problems with this?
>
> Ian
>

umm, we update the inode in kernfs_refresh_inode, right??  So I guess
the problem is how can we protect the inode when kernfs_refresh_inode
is called, not the attrs??


thanks,
fox
