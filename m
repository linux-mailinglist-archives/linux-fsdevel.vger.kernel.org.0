Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B64618A1F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 18:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCRRve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 13:51:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:50562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCRRve (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:51:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77A3BABE7;
        Wed, 18 Mar 2020 17:51:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 48AB21E11A0; Wed, 18 Mar 2020 18:51:31 +0100 (CET)
Date:   Wed, 18 Mar 2020 18:51:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
Message-ID: <20200318175131.GK22684@quack2.suse.cz>
References: <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
 <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com>
 <20200227112755.GZ10728@quack2.suse.cz>
 <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
 <20200227133016.GD10728@quack2.suse.cz>
 <CAOQ4uxghKxf4Gfw9GX1QZ_ju3RhZcOLxtYnhAn9A3MJtt3PMCQ@mail.gmail.com>
 <CAOQ4uxiHA5fM9SjA+XXcGQOg2u4UPvs_-nm+sKXcNXoGKxVgTg@mail.gmail.com>
 <20200305154908.GK21048@quack2.suse.cz>
 <CAOQ4uxgJPkYOL5-jj=b+z5dG5DK8spzYUD7_OfMdBwh4gnTUYg@mail.gmail.com>
 <CAOQ4uxg4tRCALm+JaAQt9eWuU_23c55eaPivdRbb3yH=kcey8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg4tRCALm+JaAQt9eWuU_23c55eaPivdRbb3yH=kcey8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 08-03-20 09:29:08, Amir Goldstein wrote:
> > To see what the benefit of inherit fanotify_fid_event is, I did a test patch
> > to get rid of it and pushed the result to fanotify_name-wip:
> >
> > * b7eb8314c61b - fanotify: do not inherit fanotify_name_event from
> > fanotify_fid_event
> >
> > IMO, the removal of inheritance in this struct is artificial and
> > brings no benefit.
> > There is not a single line of code that improved IMO vs. several added
> > helpers which abstract something that is pretty obvious.
> >
> > That said, I don't mind going with this variant.
> > Let me you what your final call is.
> >
> 
> Eventually, it was easier to work the non-inherited variant into the series
> as the helpers aid with abstracting things as the series progresses and
> because object_fh is added to fanotify_name_event late in the series.
> So I went with your preference.
> 
> Pushed the work to fanotify_name branch.
> Let me know if you want me to post v3.

So I went through the patches - had only minor comments for most of them.
Can you post the next revision by email and I'll pickup at least the
obvious preparatory patches to my tree. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
