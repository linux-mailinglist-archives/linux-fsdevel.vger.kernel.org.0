Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CCC209FAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 15:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404895AbgFYNWD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 09:22:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48270 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404854AbgFYNWD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:22:03 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1joRpH-0007g5-Ty; Thu, 25 Jun 2020 13:22:00 +0000
Date:   Thu, 25 Jun 2020 15:21:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: overlayfs regression
Message-ID: <20200625132159.splbwlxadteukah6@wittgenstein>
References: <20200624144846.jtpolkxiqmery3uy@wittgenstein>
 <CAOQ4uxhkiWKt2As5kMWt6PNrRwY8QbqXKiHkz_1UFb0Za+BEuw@mail.gmail.com>
 <20200624153545.ixamvyahayzuokl7@wittgenstein>
 <CAOQ4uxjgBRMMB03XEeQvtYO1poGsKwUEO4VpF7uMy8Mkur2vzw@mail.gmail.com>
 <20200625131943.GX14915@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200625131943.GX14915@ubuntu-x1>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 08:19:43AM -0500, Seth Forshee wrote:
> On Wed, Jun 24, 2020 at 07:24:24PM +0300, Amir Goldstein wrote:
> > On Wed, Jun 24, 2020 at 6:35 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > On Wed, Jun 24, 2020 at 06:25:55PM +0300, Amir Goldstein wrote:
> > > > On Wed, Jun 24, 2020 at 5:48 PM Christian Brauner
> > > > <christian.brauner@ubuntu.com> wrote:
> > > > >
> > > > > Hey Miklosz,
> > > > > hey Amir,
> > > > >
> > > > > We've been observing regressions in our containers test-suite with
> > > > > commit:
> > > > >
> > > > > Author: Miklos Szeredi <mszeredi@redhat.com>
> > > > > Date:   Tue Mar 17 15:04:22 2020 +0100
> > > > >
> > > > >     ovl: separate detection of remote upper layer from stacked overlay
> > > > >
> > > > >     Following patch will allow remote as upper layer, but not overlay stacked
> > > > >     on upper layer.  Separate the two concepts.
> > > > >
> > > > >     This patch is doesn't change behavior.
> > > > >
> > > > >     Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > > >
> > > >
> > > > Are you sure this is the offending commit?
> > > > Look at it. It is really moving a bit of code around and should not
> > > > change logic.
> > > > There are several other commits in 5.7 that could have gone wrong...
> > >
> > > Yeah, most likely. I can do a bisect but it might take a little until I
> > > get around to it. Is that ok?
> > >
> > 
> > ok.
> > I thought you pointed to a commit that you bisected the regression to.
> > I guess not.
> 
> I think this is only an Ubuntu problem, it looks like someone did some
> bad conflict resoluation when rebasing a sauce patch onto 5.7.

Yeah, I just saw this as well.

Sorry for the noise.
Christian
