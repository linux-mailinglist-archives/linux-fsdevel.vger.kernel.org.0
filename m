Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E541560FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 23:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBGWDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 17:03:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbgBGWDe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2d5zVWoSIkJq53OLV//DrgsyCvw29Qs+2sFuqf28g1Q=; b=sD7ir1TiIMPuJqDgcwhL0G6Qq5
        pkb7NmTPq+WYeXxcgvxtboQn27bmhab+P/SV9ONVh6hpktv490rtGG4N/VPmuzZOo6zbpWgEYO7A2
        y9bGRwUAfL4/TZAoDXuzQwVtFXkne5ezH84W1m1DPDXYiO66PV2AnZmUM0yV1rdtFs/lNG4dCXqoI
        fx2VIVmV9oo+jMA5Z68biCDXGhzIvY28gqzUT5lWG/qSLdiSHM+f3Mk8jrK93PCvcimLrwUIUa2P9
        oUX4qa+TlxUgOC7uerScMQOWACMQpG+kUqef2/xnxFsIjudztjAaKoiDaQCqnxAomxfkxYu1sWUcB
        q8H1Aseg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j0Bin-0001oZ-Iq; Fri, 07 Feb 2020 22:03:33 +0000
Date:   Fri, 7 Feb 2020 14:03:33 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200207220333.GI8731@bombadil.infradead.org>
References: <20200131052520.GC6869@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131052520.GC6869@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 09:25:20PM -0800, Darrick J. Wong wrote:
> It turns out that this system doesn't scale very well either.  Even with
> three maintainers sharing access to the git trees and working together
> to get reviews done, mailing list traffic has been trending upwards for
> years, and we still can't keep up.  I fear that many maintainers are
> burning out.  For XFS, the biggest pain point (AFAICT) is not assembly and
> testing of the git trees, but keeping up with the mail and the reviews.

I think the LSFMMBPF conference is part of the problem.  With the best of
intentions, we have set up a system which serves to keep all but the most
dedicated from having a voice at the premier conference for filesystems,
memory management, storage (and now networking).  It wasn't intended to
be that way, but that's what has happened, and it isn't serving us well
as a result.

Three anecdotes.  First, look at Jason's mail from earlier today:
https://lore.kernel.org/linux-mm/20200207194620.GG8731@bombadil.infradead.org/T/#t

There are 11 people on that list, plus Jason, plus three more than I
recommended.  That's 15, just for that one topic.  I think maybe half
of those people will get an invite anyway, but adding on an extra 5-10
people for (what I think is) a critically important topic at the very
nexus of storage, filesystems, memory management, networking and graphics
is almost certainly out of bounds for the scale of the current conference.

Second, I've had Outreachy students who have made meaningful contributions
to the kernel.  Part of their bursary is a travel grant to go to a
conference and they were excited to come to LSFMM.  I've had to tell
them "this conference is invite-only for the top maintainers; you can't
come".  They ended up going to an Open Source Summit conference instead.
By excluding the people who are starting out, we are failing to grow
our community.  I don't think it would have hurt for them to be in the
room; they were unlikely to speak, and perhaps they would have gone on
to make larger contributions.

Third, I hear from people who work on a specific filesystem "Of the
twenty or so slots for the FS part of the conference, there are about
half a dozen generic filesystem people who'll get an invite, then maybe
six filesystems who'll get two slots each, but what we really want to
do is get everybody working on this filesystem in a room and go over
our particular problem areas".

This kills me because LSFMM has been such a critically important part of
Linux development for over a decade, but I think at this point it is at
least not serving us the way we want it to, and may even be doing more
harm than good.  I think it needs to change, and more people need to
be welcomed to the conference.  Maybe it needs to not be invite-only.
Maybe it can stay invite-only, but be twice as large.  Maybe everybody
who's coming needs to front $100 to put towards the costs of a larger
meeting space with more rooms.

Not achievable for this year, I'm sure, but if we start talking now
maybe we can have a better conference in 2021.
