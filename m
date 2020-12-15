Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B112DA72E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 05:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgLOEkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 23:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgLOEkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 23:40:21 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A0CC06179C;
        Mon, 14 Dec 2020 20:39:41 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id 81so19165264ioc.13;
        Mon, 14 Dec 2020 20:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZpMSPWj4XpZ3thlAzvu56DgfsvqpomnX3VopvGqVOs=;
        b=V/a9QAKPx8DgB+4XXpXqICtMSlaSE25WJ7EJmPHUOuYhR4sEK0rOQVMjP/J53ayazG
         R4n+7D3icF6qug0Wqr1+o2+CDKC+IfmAW6ZbXW5l3ne1nDcpvKecqX1G6COZS8w3/OS9
         od3iLRkc8Uos9IbacbYGv5gWK6YQVuUm+Qum2CdGkOPs6wKhfR0VXRuNE5g/g/8kbhwr
         FdgFzgbqCmA3Z+KbIoEFjeQxXnWbOJfytkPPJ3avbVCDIaL2SM+k+72q47F4rXl4Dj3m
         XVzdnO7nDSMr7zCW02QABzTsiIyoYONzXKqrsz4/Le+zRThRK3Wm9eTMzlX4WWcqqrO9
         JO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZpMSPWj4XpZ3thlAzvu56DgfsvqpomnX3VopvGqVOs=;
        b=ohZfr9QJkzmPYaknwtJdbnRx2R4AykPOxEKE7/EakGAV7cuQAvFVIkbdkEbdS7pyH4
         gaW827FB2ix/AI5hPIzTOCXNrOyKq4QKPvsUco5Y47TYaU6V6rWW35d2FqheCroBRcNV
         6hUMP/zlXp8vWvYXjjxfAG5ju+Q0TGzy3MHa4K8MLT6i1ByhZh+v00cMvk9LXQlColA8
         ybXtZfT/jGXk8H64wGvscUjFKyLAsRzhxNNTwVCdwLwuZYWfHUX7035fKjw1b5H8F5hC
         T00P34oJrr30Gi1w1CKQtfDqp21fhOVAI1MUlQmuyW0emfxWTKL6AmYvJ63odpZee7ru
         CmDw==
X-Gm-Message-State: AOAM532SPPNVAN+ieoeuVsaKvg6de16FyA+I/xOQnwcYL5vpaH7uC71l
        1CgxUygM1MSn/0+CxCWYz5k4YgCv0Pd0EXBnehs=
X-Google-Smtp-Source: ABdhPJz5tqAgMHotC0ERTj7zEoC52sQPoOS/rmGpHPpLK7dh8dJAOI6n+d/eAqkIo1EpDGfAFFhkyGH6jgFwEVtRovM=
X-Received: by 2002:a02:a152:: with SMTP id m18mr37230897jah.64.1608007180900;
 Mon, 14 Dec 2020 20:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20201209131146.67289-1-laoar.shao@gmail.com> <20201209131146.67289-4-laoar.shao@gmail.com>
 <20201209195235.GN1943235@magnolia> <CALOAHbD_DK9w=s9RDsVBNaYwgeRi4UUEGDHFb3zEsqh_V8gLMA@mail.gmail.com>
 <20201214210833.GE632069@dread.disaster.area> <CALOAHbAK=OB1NQKwNYHttBuM=QZjc04cjU=YRw5MoTWT34HXvg@mail.gmail.com>
 <20201215011240.GJ632069@dread.disaster.area>
In-Reply-To: <20201215011240.GJ632069@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 15 Dec 2020 12:39:05 +0800
Message-ID: <CALOAHbDU1OUaMxV9fz3AP6t0OWp=o8X6bQnw0zdo5HiTmrOZBA@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] xfs: refactor the usage around xfs_trans_context_{set,clear}
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 9:12 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Dec 15, 2020 at 08:42:08AM +0800, Yafang Shao wrote:
> > On Tue, Dec 15, 2020 at 5:08 AM Dave Chinner <david@fromorbit.com> wrote:
> > > On Sun, Dec 13, 2020 at 05:09:02PM +0800, Yafang Shao wrote:
> > > > On Thu, Dec 10, 2020 at 3:52 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > > On Wed, Dec 09, 2020 at 09:11:45PM +0800, Yafang Shao wrote:
> > > static inline void
> > > xfs_trans_context_clear(struct xfs_trans *tp)
> > > {
> > >         /*
> > >          * If xfs_trans_context_swap() handed the NOFS context to a
> > >          * new transaction we do not clear the context here.
> > >          */
> > >         if (current->journal_info != tp)
> >
> > current->journal_info hasn't been used in patch #3, that will make
> > patch #3 a little more complex.
> > We have to do some workaround in patch #3. I will think about it.
>
> What I wrote is how the function should look at the end of the patch
> series.  Do not add the current->journal_info parts of it until the
> patch that introduces the current->journal_info tracking.
>

I know what you meant.
While I mean we have to do some hack, as suggested by Darrrick that
"set NOFS in the old transaction's
t_pflags so that when we clear the context on the old transaction we
don't actually change the thread's NOFS state." in patch #3 and then
remove it in patch #4.


-- 
Thanks
Yafang
