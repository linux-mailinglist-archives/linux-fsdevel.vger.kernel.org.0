Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45E0209FA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404910AbgFYNTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 09:19:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48163 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404740AbgFYNTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:19:48 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1joRn8-0006y9-Ux
        for linux-fsdevel@vger.kernel.org; Thu, 25 Jun 2020 13:19:47 +0000
Received: by mail-il1-f197.google.com with SMTP id x23so1177887ilk.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2020 06:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oCcK+jnHv06M3UD95WYDmKiLgFOsRpzYd+qB/RCcxR0=;
        b=UjgNwe7b0z0QWBHLGHfo5MrOKCmI+TQ9ixKj0rVRNfH+YxodhqEGy9sZ9FCUCT4EFC
         lwDy7Oz/sAq6ZV095M2wBbF4JEx6nhpKOL4YCsbXhIW7nRlSXwDlpqrk0gFIuF9w8OiS
         cLcKlJKGB4/p/D6zM5seeSJzRiwcJdDCuCl1tRBsf43/fhzxW6NsGB3wQgVXSM1NwW6l
         SNUE8/K7DvKJ4Fb27631SwCY+KSvNyRGilgNeb8dDkCNb7IV99m6hxZ6zVnVnNydt/1d
         yALp2wBJiNwvMBy8BClr13xiAlrHfnjK/3kz17DHjTRKC656szYe7VYpCaQAGCRzETwt
         SXqQ==
X-Gm-Message-State: AOAM532S4e1qYQMwwiFplYFCXiXef2fWbWMa0OlDAfQ35csLUf7Ano54
        6f8G2rv58k8jMy/SJawXN6SXnT5V4efZC0JoCDxTVSmF4VtWvzYNieZk3YyBlkOrOc17WAc5bDc
        oMigYJT05ltD8xQDcgVW29QPnKiI/NTKK/7qz9eYK6nA=
X-Received: by 2002:a92:9f9c:: with SMTP id z28mr4365581ilk.55.1593091185926;
        Thu, 25 Jun 2020 06:19:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzANMH6aDsZdqR/NK+45DW0da/TSJaKesvS1LdJD6ZH18S8Hrq7AICMsRdCw0qfRN6v07bZnw==
X-Received: by 2002:a92:9f9c:: with SMTP id z28mr4365549ilk.55.1593091185532;
        Thu, 25 Jun 2020 06:19:45 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:f090:1573:c2fc:6389])
        by smtp.gmail.com with ESMTPSA id k5sm12778592ili.80.2020.06.25.06.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:19:44 -0700 (PDT)
Date:   Thu, 25 Jun 2020 08:19:43 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: overlayfs regression
Message-ID: <20200625131943.GX14915@ubuntu-x1>
References: <20200624144846.jtpolkxiqmery3uy@wittgenstein>
 <CAOQ4uxhkiWKt2As5kMWt6PNrRwY8QbqXKiHkz_1UFb0Za+BEuw@mail.gmail.com>
 <20200624153545.ixamvyahayzuokl7@wittgenstein>
 <CAOQ4uxjgBRMMB03XEeQvtYO1poGsKwUEO4VpF7uMy8Mkur2vzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjgBRMMB03XEeQvtYO1poGsKwUEO4VpF7uMy8Mkur2vzw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:24:24PM +0300, Amir Goldstein wrote:
> On Wed, Jun 24, 2020 at 6:35 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Wed, Jun 24, 2020 at 06:25:55PM +0300, Amir Goldstein wrote:
> > > On Wed, Jun 24, 2020 at 5:48 PM Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> > > >
> > > > Hey Miklosz,
> > > > hey Amir,
> > > >
> > > > We've been observing regressions in our containers test-suite with
> > > > commit:
> > > >
> > > > Author: Miklos Szeredi <mszeredi@redhat.com>
> > > > Date:   Tue Mar 17 15:04:22 2020 +0100
> > > >
> > > >     ovl: separate detection of remote upper layer from stacked overlay
> > > >
> > > >     Following patch will allow remote as upper layer, but not overlay stacked
> > > >     on upper layer.  Separate the two concepts.
> > > >
> > > >     This patch is doesn't change behavior.
> > > >
> > > >     Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > >
> > >
> > > Are you sure this is the offending commit?
> > > Look at it. It is really moving a bit of code around and should not
> > > change logic.
> > > There are several other commits in 5.7 that could have gone wrong...
> >
> > Yeah, most likely. I can do a bisect but it might take a little until I
> > get around to it. Is that ok?
> >
> 
> ok.
> I thought you pointed to a commit that you bisected the regression to.
> I guess not.

I think this is only an Ubuntu problem, it looks like someone did some
bad conflict resoluation when rebasing a sauce patch onto 5.7.

Seth
