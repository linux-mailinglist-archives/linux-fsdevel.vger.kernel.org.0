Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95689EA68E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 23:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfJ3WqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 18:46:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35373 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfJ3WqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:46:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id d13so2726632pfq.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 15:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PnrfXeYVRnpGVPGiQDcbW5SLqkZubZ+o9/pPkDpKRLw=;
        b=bkZBZ57meOngOGFWqgT5tJ/VVPrpfwkqsGbUVC907SVJYvcwR7C7b06NpUvxn9YGsB
         g+BiTZl9eHlishVM5xWNwl8ci/CTMSziIL/JSijnZhCVj7MH59NANsRpnDuIN/nVz15s
         k9Zb+Je5/nezygJuhSKvSjcW8+eGRONrr263WBn7hIB1K2BqH82J7Mxzik2VBVARSCcw
         mU4NFZFindc3TWrhDteecyPufF9Fy8T0AK+s0kCV9a0nvkli3jAfk5WhomQGMU/kb9G4
         +dDuFKJ3FNf0VOfgQcX+EDtMCWoCtNWyTh93zoeeMaf5OPHWjTekPJAgBEn5wA8VSiU0
         YmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PnrfXeYVRnpGVPGiQDcbW5SLqkZubZ+o9/pPkDpKRLw=;
        b=XHggoDzPs/MiW0B/cajhgxfFBXYc4cYWrOmK8UrvHh+R52L3mAWY47OMC6Y9y0zOU0
         v7vj7dAxVzZ4vA4b6RSc2FVTG/0RSHXTgN8AuodQpoF4H35n/p589R9GzKHJ7FYCfFA0
         4Hz1hc1j6rY2wEU1ZoHPMnQ/qXXAas8uB5UHh4cgjXhbGoaSyiKgR6/oYFU9oJH+tfKi
         QAyLOD7N811FyZbhXhfGrbXPtHzcn+wPQNcbi77v6gmujB3bO6WGLDmGUhhPyqMObY+E
         M74k250kVcDs9TpRa50X6GR1zq92FQOZ+Rvh40Cs+YmwwVx+1p/3dkdv2VE2+tsfmXs1
         faxw==
X-Gm-Message-State: APjAAAUwTrZQbztfatJIs4Vd+wCJCq60uC02PFgmjOwT0XJJQU2MLWZ+
        wDY5bFUjfoDrgW9kRoreqm7+7g==
X-Google-Smtp-Source: APXvYqzUxjMMwehyd2VV+tc2gBZO2f30q1yw7y78xZS39vYxlWAxedexkNC5tZJkUonFDc7ZstjC/A==
X-Received: by 2002:a63:3e43:: with SMTP id l64mr2048023pga.51.1572475567838;
        Wed, 30 Oct 2019 15:46:07 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::3912])
        by smtp.gmail.com with ESMTPSA id f17sm906751pgd.8.2019.10.30.15.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 15:46:07 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:46:06 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH man-pages] Document encoded I/O
Message-ID: <20191030224606.GF326591@vader>
References: <cover.1571164762.git.osandov@fb.com>
 <c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com>
 <CAOQ4uxh_pZSiMmD=46Mc3o0GE+svXuoC155P_9FGJXdsE4cweg@mail.gmail.com>
 <20191021185356.GB81648@vader>
 <CAOQ4uxgm6MWwCDO5stUwOKKSq7Ot4-Sc96F1Evc6ra5qBE+-wA@mail.gmail.com>
 <20191023044430.alow65tnodgnu5um@yavin.dot.cyphar.com>
 <CAOQ4uxjyNZhyU9yEYkuMnD0o=sU1vJMOYJAzjV7FDjG45gaevg@mail.gmail.com>
 <20191023121203.pozm2xzrbxmcqpbr@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023121203.pozm2xzrbxmcqpbr@yavin.dot.cyphar.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:12:03PM +1100, Aleksa Sarai wrote:
> On 2019-10-23, Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > No, I see why you choose to add the flag to open(2).
> > > > I have no objection.
> > > >
> > > > I once had a crazy thought how to add new open flags
> > > > in a non racy manner without adding a new syscall,
> > > > but as you wrote, this is not relevant for O_ALLOW_ENCODED.
> > > >
> > > > Something like:
> > > >
> > > > /*
> > > >  * Old kernels silently ignore unsupported open flags.
> > > >  * New kernels that gets __O_CHECK_NEWFLAGS do
> > > >  * the proper checking for unsupported flags AND set the
> > > >  * flag __O_HAVE_NEWFLAGS.
> > > >  */
> > > > #define O_FLAG1 __O_CHECK_NEWFLAGS|__O_FLAG1
> > > > #define O_HAVE_FLAG1 __O_HAVE_NEWFLAGS|__O_FLAG1
> > > >
> > > > fd = open(path, O_FLAG1);
> > > > if (fd < 0)
> > > >     return -errno;
> > > > flags = fcntl(fd, F_GETFL, 0);
> > > > if (flags < 0)
> > > >     return flags;
> > > > if ((flags & O_HAVE_FLAG1) != O_HAVE_FLAG1) {
> > > >     close(fd);
> > > >     return -EINVAL;
> > > > }
> > >
> > > You don't need to add __O_HAVE_NEWFLAGS to do this -- this already works
> > > today for userspace to check whether a flag works properly
> > > (specifically, __O_FLAG1 will only be set if __O_FLAG1 is supported --
> > > otherwise it gets cleared during build_open_flags).
> > 
> > That's a behavior of quite recent kernels since
> > 629e014bb834 fs: completely ignore unknown open flags
> > and maybe some stable kernels. Real old kernels don't have that luxury.
> 
> Ah okay -- so the key feature is that __O_CHECK_NEWFLAGS gets
> transformed into __O_HAVE_NEWFLAGS (making it so that both the older and
> current behaviours are detected). Apologies, I missed that on my first
> read-through.
> 
> While it is a little bit ugly, it probably wouldn't be a bad idea to
> have something like that.
> 
> > > The problem with adding new flags is that an *old* program running on a
> > > *new* kernel could pass a garbage flag (__O_CHECK_NEWFLAGS for instance)
> > > that causes an error only on the new kernel.
> > 
> > That's a theoretic problem. Same as O_PATH|O_TMPFILE.
> > Show me a real life program that passes garbage files to open.
> 
> Has "that's a theoretical problem" helped when we faced this issue in
> the past? I don't disagree that this is mostly theoretical, but I have a
> feeling that this is an argument that won't hold water.
> 
> As for an example of semi-garbage flag passing -- systemd passes
> O_PATH|O_NOCTTY in several places. Yes, they're known flags (so not
> entirely applicable to this discussion) but it's also not a meaningful
> combination of flags and yet is permitted.
> 
> > > The only real solution to this (and several other problems) is
> > > openat2().
> > 
> > No argue about that. Come on, let's get it merged ;-)
> 
> Believe me, I'm trying. ;)
> 
> > > As for O_ALLOW_ENCODED -- the current semantics (-EPERM if it
> > > is set without CAP_SYS_ADMIN) *will* cause backwards compatibility
> > > issues for programs that have garbage flags set...
> > >
> > 
> > Again, that's theoretical. In practice, O_ALLOW_ENCODED can work with
> > open()/openat(). In fact, even if O_ALLOW_ENCODED gets merged after
> > openat2(), I don't think it should be forbidden by open()/openat(),
> > right? Do in that sense, O_ALLOW_ENCODED does not depend on openat2().
> 
> If it's a valid open() flag it'll also be a valid openat2(2) flag. The
> only question is whether the garbage-flag problem justifies making it a
> no-op for open(2).

Consider O_NOATIME: a (non-root) program passing this flag for files it
didn't own would have been broken by kernel v2.6.8. Or, more recently, a
program accidentally setting O_TMPFILE would suddenly get drastically
different behavior on v3.11. These two flags technically broke backwards
compatibility. I don't think it's worth the trouble to treat
O_ALLOW_ENCODED any differently for open().
