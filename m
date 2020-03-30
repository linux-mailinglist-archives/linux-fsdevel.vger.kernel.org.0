Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30F1197FAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 17:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgC3Pc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 11:32:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:34322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbgC3Pc2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:32:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 63894AC37;
        Mon, 30 Mar 2020 15:32:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E8DEB1E11AF; Mon, 30 Mar 2020 17:32:26 +0200 (CEST)
Date:   Mon, 30 Mar 2020 17:32:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 10/14] fanotify: divorce fanotify_path_event and
 fanotify_fid_event
Message-ID: <20200330153226.GH26544@quack2.suse.cz>
References: <20200319151022.31456-1-amir73il@gmail.com>
 <20200319151022.31456-11-amir73il@gmail.com>
 <20200324175029.GD28951@quack2.suse.cz>
 <CAOQ4uxhh8DJC+5xPjGaph8yKXa_hSxi7ua0s3wUDaV7MPcaStw@mail.gmail.com>
 <20200325092707.GF28951@quack2.suse.cz>
 <CAOQ4uxi8idvhgs0Uu96t=h5B=K71-79mnOGEGuaifitvvpo_2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi8idvhgs0Uu96t=h5B=K71-79mnOGEGuaifitvvpo_2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 30-03-20 13:42:03, Amir Goldstein wrote:
> >
> > Ah, right. Thanks for clarification. Actually, I think now that we have
> > fanotify event 'type' notion, I'd like to make overflow event a separate
> > type which will likely simplify a bunch of code (e.g. we get rid of a
> > strange corner case of 'path' being included in the event but being
> > actually invalid). Not sure whether I'll do it for this merge window,
> > probably not since we're in a bit of a hurry.
> >
> 
> Jan,
> 
> I went a head and did those 2 cleanups you suggested to
> fanotify_alloc_event(). pushed result to fsnotify-fixes branch.
> Probably no rush to get those into this merge window.
> For your consideration.

Thanks! Since the merge window is already open, I'd queue these fixes for
the next merge window together with the remaining fanotify work...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
