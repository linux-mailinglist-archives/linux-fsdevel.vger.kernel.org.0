Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5873B2AFD16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 02:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgKLBcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 20:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgKLAbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:31:00 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457B7C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 16:31:00 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id k1so3677449ilc.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 16:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8l0j+cAspJw3PKNvEwGXKQZgH357sPK1IXSg0Dm5rWM=;
        b=LNGJWwVJv/+IA3kzIbW9fZVxxRU3l/QIh+VULZZbgiI0DBdOi/8sRaA3pP1V6rSXl4
         x7epCo6q0RIQza7V/yhUR37RzB+Z0Jtj8mF+Mgw3foZIc29WoH4RyrBlX46WajyP/ptQ
         pUDCbrrL6sPgMZeAN/TQqnhO2c0+Ar/MjfGls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8l0j+cAspJw3PKNvEwGXKQZgH357sPK1IXSg0Dm5rWM=;
        b=Cn3ijByYmT54GzyjsiZpyrCAw1w6Xs/jyDQqeq6R92BhQ79U8OfTvtqjZ9UG9QHatp
         ej4Y3kXWwE5TUse9GwoEvmZqiyTg7fgyQzL4GE+pTNsLiXWV9/YvsIsd3hcNPdXi0Ypy
         H1N5FvG68qHALcLYeKE7D2olMIXw3HFrQpKg101gVXML44q+vhKueDO1j5V28ghesg6J
         xbfvcT4u/rRZ8GMt1yScw/cMWlAoy8KyetEuUP6uJjhAOrd4xRYpSk3X+mSck1N4OC4y
         D1EAWGKCc+nFsglv5MJORnxa5r4jG/5kTi7CKuKBRzwW8mxk22Cq+Tr3gyX5uk1hzEVh
         YohA==
X-Gm-Message-State: AOAM533vQXV4I7KzbTfqhBYrzexD0+tp9ll53YqK1J00LqNtREwRiblf
        gK6ToJ+VHLuNHYisjjouOugX/A==
X-Google-Smtp-Source: ABdhPJx1a97kaxKxxIObDOxrDXMR9vrr9lZfPgLuYHRngybHUM+LAZuPz2yhltqA1jFrW78j7RVysA==
X-Received: by 2002:a92:3312:: with SMTP id a18mr21071286ilf.165.1605141059275;
        Wed, 11 Nov 2020 16:30:59 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id m9sm1831941ioc.15.2020.11.11.16.30.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Nov 2020 16:30:58 -0800 (PST)
Date:   Thu, 12 Nov 2020 00:30:57 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>,
        "alban.crequy@gmail.com" <alban.crequy@gmail.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "mauricio@kinvolk.io" <mauricio@kinvolk.io>,
        "bfields@fieldses.org" <bfields@fieldses.org>
Subject: Re: [PATCH v4 0/2] NFS: Fix interaction between fs_context and user
 namespaces
Message-ID: <20201112003056.GA351@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201102174737.2740-1-sargun@sargun.me>
 <CAMXgnP5cVoLKTGPOAO+aLEAGLpkjACy1e4iLBKkfp8Gv1U77xA@mail.gmail.com>
 <f6d86006ccd19d4d101097de309eb21bbbf96e43.camel@hammerspace.com>
 <20201111111233.GA21917@ircssh-2.c.rugged-nimbus-611.internal>
 <8feccf45f6575a204da03e796391cc135283eb88.camel@hammerspace.com>
 <20201111185727.GA27945@ircssh-2.c.rugged-nimbus-611.internal>
 <17d0e6c2e30d5b28cc1cb0313822e5ca39a2245c.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17d0e6c2e30d5b28cc1cb0313822e5ca39a2245c.camel@hammerspace.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:03:18PM +0000, Trond Myklebust wrote:
> On Wed, 2020-11-11 at 18:57 +0000, Sargun Dhillon wrote:
> > On Wed, Nov 11, 2020 at 02:38:11PM +0000, Trond Myklebust wrote:
> > > On Wed, 2020-11-11 at 11:12 +0000, Sargun Dhillon wrote:
> > > 
> > > The current code for setting server->cred was developed
> > > independently
> > > of fsopen() (and predates it actually). I'm fine with the change to
> > > have server->cred be the cred of the user that called fsopen().
> > > That's
> > > in line with what we used to do for sys_mount().
> > > 
> > Just curious, without FS_USERNS, how were you mounting NFSv4 in an
> > unprivileged user ns?
> 
> The code was originally developed on a 5.1 kernel. So all my testing
> has been with ordinary sys_mount() calls in a container that had
> CAP_SYS_ADMIN privileges.
> 
> > > However all the other stuff to throw errors when the user namespace
> > > is
> > > not init_user_ns introduces massive regressions.
> > > 
> > 
> > I can remove that and respin the patch. How do you feel about that? 
> > I would 
> > still like to keep the log lines though because it is a uapi change.
> > I am 
> > worried that someone might exercise this path with GSS and allow for
> > upcalls 
> > into the main namespaces by accident -- or be confused of why they're
> > seeing 
> > upcalls "in a different namespace".
> > 
> > Are you okay with picking up ("NFS: NFSv2/NFSv3: Use cred from
> > fs_context during 
> > mount") without any changes?
> 
> Why do we need the dprintk()s? It seems to me that either they should
> be reporting something that the user needs to know (in which case they
> should be real printk()s) or they are telling us something that we
> should already know. To me they seem to fit more in the latter
> category.
> 
> > 
> > I can respin ("NFSv4: Refactor NFS to use user namespaces") without:
> > /*
> >  * nfs4idmap is not fully isolated by user namespaces. It is
> > currently
> >  * only network namespace aware. If upcalls never happen, we do not
> >  * need to worry as nfs_client instances aren't shared between
> >  * user namespaces.
> >  */
> > if (idmap_userns(server->nfs_client->cl_idmap) != &init_user_ns && 
> >         !(server->caps & NFS_CAP_UIDGID_NOMAP)) {
> >         error = -EINVAL;
> >         errorf(fc, "Mount credentials are from non init user
> > namespace and ID mapping is enabled. This is not allowed.");
> >         goto error;
> > }
> > 
> > (and making it so we can call idmap_userns)
> > 
> 
> Yes. That would be acceptable. Again, though, I'd like to see the
> dprintk()s gone.
> 

I can drop the dprintks, but given this is a uapi change, does it make sense to 
pr_info_once? Especially, because this can have security impact?
