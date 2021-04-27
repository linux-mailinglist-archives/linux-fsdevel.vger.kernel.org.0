Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E5136CDC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 23:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbhD0VUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 17:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbhD0VTq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:19:46 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D75EC06175F;
        Tue, 27 Apr 2021 14:19:02 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q136so40561941qka.7;
        Tue, 27 Apr 2021 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dJjOb9I+Ht5GT1o5uyWtnPInY/oz4rJkDgZTL5ei9LQ=;
        b=EfYKlLP6vteQqTo6S89SRXZ9eNM6OypgoADvoXZok/s39NF1yPIXHIfVz5XPSRwUmo
         9qjoqYDpI3JkDMK/NmDuLpgjiLClLHGOLcZdUP0ZABXV5x8adr527xzB9TaJ9DqeJlpW
         9icyvTmDYDgTyIvPUpCcZ15gY1pUnrIx2irXE2UqGVmYW02dWcI0PevAZcU5L3oNt0tC
         6SPsr7LIV7WzRL4c/l5N0zUtFCVsxSj0qvG+RR0UAF8F30FH53ly99rVyLzgUcydxhcd
         MJlrOOodpYNFdzrja2i7zDEn9o4QOUQG/S2yBCEwY5z5bEAG4Xem1n7WPARBQtyymrdM
         U+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJjOb9I+Ht5GT1o5uyWtnPInY/oz4rJkDgZTL5ei9LQ=;
        b=awaiSeltzvJ4qNdU6Fw53wCTIH6+Necl8m44ao2AisHk8j6ER+eEGmHAoAMhPG/GXB
         ufyCXpWlP8xVrrVWvIDp0PCq4F3crxllmV4ZdRbWWqDlLDpD9tgjiv7LJbPsSvaV8/Ov
         fXAL+A34SfTADa7o3dUBDLw34P7MaUWyMKo9cb9reV0ZqZAfAICElHO3MIM2quy388Hr
         TrhQBFVR92ifIp1krJ7OImjhl3k3utITt0gWEYMj4XtG3zg2RptlQ0sif2KghE7xwMOU
         TrlWOKYwCqyjw2CR90dqlUWstevFiZW6iaWmgYyr5rP1KRysfvM/pqX8M5DoBNd/dYha
         p26w==
X-Gm-Message-State: AOAM533CLAGYPJAM9JmK2Hw+Ao1onW/M//9uzXPaJFOr540E+4CONwny
        4mVYNcpILWC2MH5jAhjVDNqrWpzvSl2F
X-Google-Smtp-Source: ABdhPJyU9IEOMTgwo1Cr9qBgdMhd8CchzBUkFcyZvXS7VEUS6UW7fUQkuW7qxnjZauiWj0xZbaOi7w==
X-Received: by 2002:a37:5fc2:: with SMTP id t185mr24639825qkb.254.1619558341798;
        Tue, 27 Apr 2021 14:19:01 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id r81sm3690989qka.82.2021.04.27.14.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 14:19:01 -0700 (PDT)
Date:   Tue, 27 Apr 2021 17:18:59 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Eryu Guan <eguan@linux.alibaba.com>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 3/3] Use --yes option to lvcreate
Message-ID: <YIh/w4cD3zt6BKpj@moria.home.lan>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <20210427164419.3729180-4-kent.overstreet@gmail.com>
 <20210427170339.GA9611@e18g06458.et15sqa>
 <YIh0Iy+BiY4zzhB1@moria.home.lan>
 <20210427204319.GD235567@casper.infradead.org>
 <YIh719wtNOiipwc3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIh719wtNOiipwc3@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 02:02:15PM -0700, Eric Biggers wrote:
> On Tue, Apr 27, 2021 at 09:43:19PM +0100, Matthew Wilcox wrote:
> > On Tue, Apr 27, 2021 at 04:29:23PM -0400, Kent Overstreet wrote:
> > > On Wed, Apr 28, 2021 at 01:03:39AM +0800, Eryu Guan wrote:
> > > > On Tue, Apr 27, 2021 at 12:44:19PM -0400, Kent Overstreet wrote:
> > > > > This fixes spurious test failures caused by broken pipe messages.
> > > > > 
> > > > > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> > > > > ---
> > > > >  tests/generic/081 | 2 +-
> > > > >  tests/generic/108 | 2 +-
> > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/tests/generic/081 b/tests/generic/081
> > > > > index 5dff079852..26702007ab 100755
> > > > > --- a/tests/generic/081
> > > > > +++ b/tests/generic/081
> > > > > @@ -70,7 +70,7 @@ _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
> > > > >  $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> > > > >  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
> > > > >  # (like 2.02.95 in RHEL6) don't support --yes option
> > > > > -yes | $LVM_PROG lvcreate -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> > > > > +$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> > > > 
> > > > Please see above comments, we use yes pipe intentionally. I don't see
> > > > how this would result in broken pipe. Would you please provide more
> > > > details? And let's see if we could fix the broken pipe issue.
> > > 
> > > If lvcreate never ask y/n - never reads from standard input, then echo sees a
> > > broken pipe when it tries to write. That's what I get without this patch.
> > 
> > I think it's something in how ktest sets up the environment.  I also see
> > the SIGPIPEs when using your ktest scripts, but not when ssh'ing into
> > the guest and running the test.
> > 
> > What that thing is, I don't know.  I'm not tall enough to understand
> > signal handling.
> 
> See xfstests commit 9bcb266cd778 ("generic/397: be compatible with ignored
> SIGPIPE") for an example of the same problem being fixed in another test, with
> some more explanation.
> 
> But it's better to just not execute xfstests (or any shell script, for that
> matter) in an environment where SIGPIPE is ignored.

Ah, thanks for the info. I'll see if I can figure out what's mucking with the
signal handler (probably systemd...)
