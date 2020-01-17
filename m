Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE5D140F0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 17:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgAQQgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 11:36:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39284 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgAQQgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:36:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so10075928plp.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 08:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XNuXdYvjM9tCgfoD/MEtgNJpkVFhhKYo2Zgn1WYvxU0=;
        b=ot9KQT8UpaSUkJUZ741RDaKWhl4B+NSCGimJa3NrWQk1Zt9olOG7R4ofTxUiW7C39q
         F6iIFcU7ZMVOcDHPtGjJh4WLhz0hiLwtaf3xgfXM2K+0DG2NmOb+i0rvjNWhwOoXk2PB
         ELeg2JmuNyVACOKohUbk5g76h3CUnMtmPDntEvQSfyjeN4kdh4Lh5tY8BLafDEroMB/v
         9IO0IFbjyzEdjVBtY5GJ0D33UK9w40yOZVLZXVMyxOb5CAaXrJTj3NsZYg0hCKWAA0To
         DrKbjnyZdqb2sIYUVPW9T+ER2ATs7LGsCh0hFiJ3AE7miwk+4FC+xFcdRB8PsdGMPdTv
         UebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XNuXdYvjM9tCgfoD/MEtgNJpkVFhhKYo2Zgn1WYvxU0=;
        b=cds9931TRfhHCL24rUtiu4bGShcMFFMWddYpDW/rWnlZLLylf5ZpWYrjk3+GNs2t//
         lV7nmBNiDILASsSQaWUs6GEzRHEfSa+8EAd0fyaXGvfLNhw7VgP4BKiXDNJhMNUvKAjD
         f7+U+d4gYHOnQBdDcz+RuawR8n9onk1Srgfij/cxnV8sPw91yxfI1Wyi7TkJ5t8Ag6tI
         9Ia/Wmf6b0hpYkhTZ3C6Cp9kkxKuNh2g6W/O9GPN0K3mRhtQdetnVljIkYK6hCAtFQqZ
         6qPDfrlG3U0aNwWTb1Ji2v+R6A48P479HuAg8RfzltIbrOZXo9laP3PaVelkG8dB5X3y
         Vs/A==
X-Gm-Message-State: APjAAAXHel7Ld1Jlbfgd9B5XwSe5LB2MDbdKeE0FNNklh2b0IXCLXx9p
        H3o9FEV+GVH8sy/c3hLONyfimQ==
X-Google-Smtp-Source: APXvYqwmWAzCDWFkwVFHmEp3BF0BuTkjZpaA2386deDeZL8dTsMJqfMx+vHq3U02bwUvA1eRI7+oeQ==
X-Received: by 2002:a17:90a:dc82:: with SMTP id j2mr6891456pjv.70.1579278977550;
        Fri, 17 Jan 2020 08:36:17 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id f1sm7927823pjq.31.2020.01.17.08.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:36:17 -0800 (PST)
Date:   Fri, 17 Jan 2020 08:36:16 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200117163616.GA282555@vader>
References: <364531.1579265357@warthog.procyon.org.uk>
 <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
 <20200117154657.GK8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117154657.GK8904@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 03:46:57PM +0000, Al Viro wrote:
> On Fri, Jan 17, 2020 at 02:33:01PM +0000, Trond Myklebust wrote:
> > On Fri, 2020-01-17 at 12:49 +0000, David Howells wrote:
> > > It may be worth a discussion of whether linkat() could be given a
> > > flag to
> > > allow the destination to be replaced or if a new syscall should be
> > > made for
> > > this - or whether it should be disallowed entirely.
> > > 
> > > A set of patches has been posted by Omar Sandoval that makes this
> > > possible:
> > > 
> > >     
> > > https://lore.kernel.org/linux-fsdevel/cover.1524549513.git.osandov@fb.com/
> > > 
> > > though it only includes filesystem support for btrfs.
> > > 
> > > This could be useful for cachefiles:
> > > 
> > > 	
> > > https://lore.kernel.org/linux-fsdevel/3326.1579019665@warthog.procyon.org.uk/
> > > 
> > > and overlayfs.
> > > 
> > 
> > That seems to me like a "just go ahead and do it if you can justify it"
> > kind of thing. It has plenty of precedent, and fits easily into the
> > existing syscall, so why do we need a face-to-face discussion?
> 
> Unfortunately, it does *not* fit easily.  And IMO that's linux-abi fodder more
> than anything else.  The problem is in coming up with sane semantics - there's
> a plenty of corner cases with that one.  What to do when destination is
> a dangling symlink, for example?  Or has something mounted on it (no, saying
> "we'll just reject directories" is not enough).  What should happen when
> destination is already a hardlink to the same object?
> 
> It's less of a horror than rename() would've been, but that's not saying
> much.

The semantics I implemented in my series were basically "linkat with
AT_REPLACE replaces the target iff rename would replace the target".
Therefore, symlinks are replaced, not followed, and mountpoints get
EXDEV. In my opinion that's both sane and unsurprising.
