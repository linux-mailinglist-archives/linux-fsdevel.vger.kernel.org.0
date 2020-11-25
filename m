Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB232C4BB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 00:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgKYX5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 18:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgKYX5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 18:57:23 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59259C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 15:57:23 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id b144so118444qkc.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 15:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1gLJhkwZL5WHnwEIFNB/JO9CIv8V2CHzH3Td89zgurk=;
        b=GSfuslRTJrgxqEjDVUBmPEGmyMIn2pC+5TfmYI0jmUTxknWfVqTuN+vWRct7yucSZb
         /pNmb3h40HTTGcy3Ru1Co7qqVywsR8Npt3aXTjec65ac4TIWAh5jwL1Gt5kQhOeGDdZ2
         Jtx16L3J0Ct2uGH7EcUaMgwvDmWbcOqUUIUFzOSrVcb7vwyb7rQx/d3vEIaOXKEIHCT5
         VWW0is8j2/kxqkVEwgvNjDgJNXvPtSpiqhfXUZTgg4kDxUPLVDwlhqSd42OX8SIB0MyG
         bhMCpQFCPF/wUgJcMI4+CjUNy8JwyOaqJPOHHoLhXx4N9ssLqfFUMA9SW1xc62E2wZ8I
         XxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1gLJhkwZL5WHnwEIFNB/JO9CIv8V2CHzH3Td89zgurk=;
        b=RNqPKa+cyHWD1L9tnzcJ8Pav+Bbh0B/cdooOxOrCHyCeIsytQyK7olALADa3/+oCXf
         syEmA82Czx6rmJ7s9Deime6O0FzV5WB4S9/dK6fqoC7AnbleN3cQ2ABlVU5kFhZQ4dSX
         JxNTMX9Bvud2n8q9M7K4w5MOckybrF722bfOPbLfd6YuApvur8kRKKJudTIL6rJ+vAPL
         Nw4hfQhs9EzNpaZX6WydhHuLopgNPLAh89GfDKt8dJftGSUDOJJEjO3Q2H0MqK3pq6sv
         1gARHKAYG84kcvToY+xpJJUbpFjFi6hggNaIBSJzuaZHBohhXODrE+jBo2PZf21V/cpj
         4LkQ==
X-Gm-Message-State: AOAM530mXNyDcmGGZq94ZoMiAgc1S3J4OHTURZ2zSBzQucHFxd4t0Wf4
        ls5NVHxqsHIqR5qJFXbFqRiUQw==
X-Google-Smtp-Source: ABdhPJyaalvrOWdezNgB6SjAER/qll6NTs9Dt1njWus9sIdv1t5iA8R0eLQMngEdaAP+frmCSD+eGg==
X-Received: by 2002:a37:4893:: with SMTP id v141mr574084qka.361.1606348642398;
        Wed, 25 Nov 2020 15:57:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x19sm901590qtr.65.2020.11.25.15.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 15:57:21 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ki4f2-001QAA-Pf; Wed, 25 Nov 2020 19:57:20 -0400
Date:   Wed, 25 Nov 2020 19:57:20 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH] drm/ttm: don't set page->mapping
Message-ID: <20201125235720.GR5487@ziepe.ca>
References: <20201125162532.1299794-1-daniel.vetter@ffwll.ch>
 <20201125162532.1299794-5-daniel.vetter@ffwll.ch>
 <CAKMK7uGXfqaPUtnX=VgA3tFn3S+Gt9GV+kPguakZ6FF_n8LKuA@mail.gmail.com>
 <20201125180606.GQ5487@ziepe.ca>
 <20201125181129.GA1858@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125181129.GA1858@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 06:11:29PM +0000, Christoph Hellwig wrote:
> On Wed, Nov 25, 2020 at 02:06:06PM -0400, Jason Gunthorpe wrote:
> > It uses a empty 'cover-letter' commit and automatically transforms it
> > into exactly the right stuff. Keeps track of everything you send in
> > git, and there is a little tool to auto-run git range-diff to help
> > build change logs..
> > 
> > https://github.com/jgunthorpe/Kernel-Maintainer-Tools/blob/master/gj_tools/cmd_send_patches.py
> > 
> > I've been occasionaly wondering if I should suggest Konstantin add a
> > sending side to b4, maybe using some of those ideas..
> > 
> > (careful if you run it, it does autosend without prompting)
> 
> The looks pretty fancy.  Here is my trivial patchbomb.sh script
> 
> #!/bin/sh
> 
> COVERLETTER=$1
> PATCHES=$2
> 
> git send-email --annotate --to-cover --cc-cover $1 $2
> 
> still needs the git basecommit..endcommit notation, but it fires
> up the series for review.

annotate is OK, I used that for a long time..

My main gripe was it didn't setup the to/cc until after the annotate
editor closes.

Jason
