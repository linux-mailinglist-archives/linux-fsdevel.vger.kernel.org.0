Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E781FCE80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 15:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgFQNeC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 09:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgFQNeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:34:01 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD59C06174E;
        Wed, 17 Jun 2020 06:34:00 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cv17so969690qvb.13;
        Wed, 17 Jun 2020 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sE2GtgzFyH/Me0L3Rwy/BvM2kkw0y53nU1L0Sm+C+QY=;
        b=X9z/7dAR1UUuoM3Fa0+xlrzXxqlhqj/kNY0I9nb0IlEzBVmxHESkw/47G32LB9ktQt
         ec7kXVQNN32dPbx0EzmpbyYlfoDXj+AQ+PcNTD3r27dyNpHLUXZUCjPXd5XRMA2H5nbB
         24r+FbrsY9IcygOqqDNuHCgZ3zYFtqMmzjORtMtGUEy7KdxJ35KbJrL9tL0eWuJrrfb/
         mzzNXb8kGlYOegf338ezMQQEB6OW8E1hrlAWw3aIBmIyX0WJd0XKipfJcimG0I9bx4id
         MStVnZDnyeLuhVVsPNj6DcUUFPQAoZ85e6Xl9qYQ4YXmM1hU13cxTS7ryf+16y2VlD6G
         UPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sE2GtgzFyH/Me0L3Rwy/BvM2kkw0y53nU1L0Sm+C+QY=;
        b=luT3Ynp5Qe8qi9GzySrtB7sBdFAQMO3VPS2I5Gg4+/FhQYpMosBktIY/EKwANx8nBu
         faQuIBf9k6v4w9eXhe0ZfoHkM7ZF5y4ss+y839CkAqAaqnlELqT/ayjzsPidC4+GavSg
         +E/SsaPT3v9sejx+DM3PE126o46xygC33k/AXVvUyYM6pOTUAEAPq/nJAlyAhbz80aoT
         SbP1YwLXVGyqRWW0RoTHYZjuphU9NYtgZAF58reXdsADcUZkRjjUKf1XPtWC1oUkI5dn
         1itcFdfkCqA0YsXa9Q9OWTrfGQrwLTw1JSNV5fqibNlwYnzV6l0fS5COo/+JL+GFbnN1
         AoMg==
X-Gm-Message-State: AOAM531pH/P6vvqkDb4I2qgq6FUIkxEDBhRKMZqgMfQ+auWVr8XEs+0G
        IOX4mxWtly+lVd0ZOSKQqA==
X-Google-Smtp-Source: ABdhPJxysRZkZWDT1x8SCJdemmbfkIJWwqEC58Nn2mufQhTE76A3V/vJPE1KxEQ4DYcjj0emEklIvQ==
X-Received: by 2002:a0c:b256:: with SMTP id k22mr7352996qve.115.1592400839886;
        Wed, 17 Jun 2020 06:33:59 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id a82sm17947212qkb.29.2020.06.17.06.33.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jun 2020 06:33:59 -0700 (PDT)
Date:   Wed, 17 Jun 2020 09:33:57 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200617133357.e56dnjeapatck25w@gabell>
References: <20200616202123.12656-1-msys.mizuma@gmail.com>
 <20200617080314.GA7147@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617080314.GA7147@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:03:14AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 16, 2020 at 04:21:23PM -0400, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > /proc/mounts doesn't show 'i_version' even if iversion
> > mount option is set to XFS.
> > 
> > iversion mount option is a VFS option, not ext4 specific option.
> > Move the handler to show_sb_opts() so that /proc/mounts can show
> > 'i_version' on not only ext4 but also the other filesystem.
> 
> SB_I_VERSION is a kernel internal flag.  XFS doesn't have an i_version
> mount option.

Thank you for pointing it out, I misunderstood that for XFS.

iversion mount option is a VFS option, so I think it's good to
show 'i_version' on /proc/mounts if the filesystem has i_version feature,
like as:

$ cat /proc/mounts
...
/dev/vdb1 /mnt xfs rw,i_version,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota 0 0
...

- Masa
