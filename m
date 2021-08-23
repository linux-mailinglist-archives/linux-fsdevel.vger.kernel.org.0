Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F583F4679
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhHWIPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 04:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235575AbhHWIPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629706494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sAS3UII3BoCLendYghwp+E5/qpLsis2DFPR6GELCxPg=;
        b=RnAGNa8Y6XFvGjWAbaBJfkItKTTh9aOxzk9WYYcSjv+OQpxMG21ktfBN6TE1kwsuIDsfgZ
        msBBND6ayBdF8uYhHs0Wq0Cmv1t5GFhy1UOQ7KiodjZM94idFAOwHzgEpWv0mQxv+lRiRf
        OP4igU/iumDw+iw+F1hgdZ6leJeEak4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-MgRCMTvFNSu3pm2djBnWTw-1; Mon, 23 Aug 2021 04:14:53 -0400
X-MC-Unique: MgRCMTvFNSu3pm2djBnWTw-1
Received: by mail-wm1-f71.google.com with SMTP id z18-20020a1c7e120000b02902e69f6fa2e0so2722824wmc.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 01:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=sAS3UII3BoCLendYghwp+E5/qpLsis2DFPR6GELCxPg=;
        b=mHjG3HwWrmReeRj33eddV6Qecogm1/+FIrTO1KXmPoe1udpRotEF+x1ILjEpAklhJd
         /mVrNG2HRNk2PxPjciC5S9lRSTJ3ISJZYFRcKNx1JcgHx2TazH8itjZY5xoasf1bOGoK
         ue3W9KrChi5YsW39PjAYl0ugd4vY1cdHkIFyomnEVCO2USLDnyY8MpRobhLBaU6fSqBb
         yTmNdh7u/rDwA6PfNU9gigxrC+Kq+UDWcexSg4ITmht9JhBSMBuX8eKj5ZofMRtje7b4
         3N+1GAXbMOmYOULxisP29NoLFQEBvAehX5V77YhAySEYG9+9Wd5WTEZnqkF3nwBZee2v
         YBEg==
X-Gm-Message-State: AOAM530knGkU1SIp/NB9nWniyPvNU1dep1dzwS0TWlLNx5WPfvIkx0Mx
        UqzoMo5ht92v96biMLqqcAmfOcjqz43cx92GVwRR1KY+OpKxyDt+06npLczGfs2EHyr9WOEuZyt
        A9j59NIrRxGrLLibyw30+ncibBg==
X-Received: by 2002:adf:e910:: with SMTP id f16mr6700308wrm.393.1629706491883;
        Mon, 23 Aug 2021 01:14:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9tWYyiX6YvxpM93MetANrNoX2lZvyAZMJH8SnDUJVD31ZiO7K1OFWJvibdiL9k2vCA5llew==
X-Received: by 2002:adf:e910:: with SMTP id f16mr6700299wrm.393.1629706491736;
        Mon, 23 Aug 2021 01:14:51 -0700 (PDT)
Received: from 0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa (0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:ffda:0:2059:8730:b2:c370])
        by smtp.gmail.com with ESMTPSA id f2sm14085343wru.31.2021.08.23.01.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 01:14:51 -0700 (PDT)
Message-ID: <8e2ab23b93c96248b7c253dc3ea2007f5244adee.camel@redhat.com>
Subject: Re: [Cluster-devel] [PATCH v6 10/19] gfs2: Introduce flag for glock
 holder auto-demotion
From:   Steven Whitehouse <swhiteho@redhat.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Date:   Mon, 23 Aug 2021 09:14:50 +0100
In-Reply-To: <CAHc6FU7EMOEU7C5ryu5pMMx1v+8CTAOMyGdf=wfaw8=TTA_btQ@mail.gmail.com>
References: <20210819194102.1491495-1-agruenba@redhat.com>
         <20210819194102.1491495-11-agruenba@redhat.com>
         <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
         <cf284633-a9db-9f88-6b60-4377bc33e473@redhat.com>
         <CAHc6FU7EMOEU7C5ryu5pMMx1v+8CTAOMyGdf=wfaw8=TTA_btQ@mail.gmail.com>
Organization: Red Hat UK Ltd
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-08-20 at 17:22 +0200, Andreas Gruenbacher wrote:
> On Fri, Aug 20, 2021 at 3:11 PM Bob Peterson <rpeterso@redhat.com>
> wrote:
> > 
[snip]
> > 
> > You can almost think of this as a performance enhancement. This
> > concept
> > allows a process to hold a glock for much longer periods of time,
> > at a
> > lower priority, for example, when gfs2_file_read_iter needs to hold
> > the
> > glock for very long-running iterative reads.
> 
> Consider a process that allocates a somewhat large buffer and reads
> into it in chunks that are not page aligned. The buffer initially
> won't be faulted in, so we fault in the first chunk and write into
> it.
> Then, when reading the second chunk, we find that the first page of
> the second chunk is already present. We fill it, set the
> HIF_MAY_DEMOTE flag, fault in more pages, and clear the
> HIF_MAY_DEMOTE
> flag. If we then still have the glock (which is very likely), we
> resume the read. Otherwise, we return a short result.
> 
> Thanks,
> Andreas
> 

If the goal here is just to allow the glock to be held for a longer
period of time, but with occasional interruptions to prevent
starvation, then we have a potential model for this. There is
cond_resched_lock() which does this for spin locks. So perhaps we might
do something similar:

/**
 * gfs2_glock_cond_regain - Conditionally drop and regain glock
 * @gl: The glock
 * @gh: A granted holder for the glock
 *
 * If there is a pending demote request for this glock, drop and 
 * requeue a lock request for this glock. If there is no pending
 * demote request, this is a no-op. In either case the glock is
 * held on both entry and exit.
 *
 * Returns: 0 if no pending demote, 1 if lock dropped and regained
 */
int gfs2_glock_cond_regain(struct gfs2_glock *gl, struct gfs2_holder
*gh);

That seems more easily understood, and clearly documents places where
the lock may be dropped and regained. I think that the implementation
should be simpler and cleaner, compared with the current proposed
patch. There are only two bit flags related to pending demotes, for
example, so the check should be trivial.

It may need a few changes depending on the exact circumstances, but
hopefully that illustrates the concept,

Steve.



