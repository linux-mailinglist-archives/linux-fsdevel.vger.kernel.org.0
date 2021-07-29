Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754373DA47E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 15:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhG2Nkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 09:40:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58392 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbhG2Nkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:40:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 44E572003A;
        Thu, 29 Jul 2021 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627566048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQ5rlkcLuoTbOuoxb2KOY6qdY81CEr3ax9QvoQljnlc=;
        b=0x6Q7L2soYQQus4/ECuxPmJJmE5QLXgHD03/WNfl7trhCbZ62fYBO7XqEyamyHdFMdchpt
        S1QiYY/c41LejOaKV5D5VUjh1aRtjVJcPkZJgQYa5Fu6N1omAs4JGgkqCvf5PcKk/otsDs
        z7j9qXOUFJ7BmDQyY0OG9HtW7lcIVy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627566048;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQ5rlkcLuoTbOuoxb2KOY6qdY81CEr3ax9QvoQljnlc=;
        b=K2RL80hB5F2E3nIb8msjt3Ph1xJiM4ELE+etaj6r4qdiNkS6F5e2EFPKzSRuzxh58yG3v2
        3Dek7r+DVrV79RBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 3830AA3B88;
        Thu, 29 Jul 2021 13:40:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 245A21E12F7; Thu, 29 Jul 2021 15:40:48 +0200 (CEST)
Date:   Thu, 29 Jul 2021 15:40:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Add pidfd support to the fanotify API
Message-ID: <20210729134048.GM29619@quack2.suse.cz>
References: <cover.1626845287.git.repnop@google.com>
 <CAOQ4uxhBYhQoZcbuzT+KsTuyndE7kEv4R8ZhRL-kQScyfADY2A@mail.gmail.com>
 <YP9AMGlGCuItQgJb@google.com>
 <YP9QaEaCWvUV4Qie@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP9QaEaCWvUV4Qie@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-07-21 10:16:40, Matthew Bobrowski wrote:
> On Tue, Jul 27, 2021 at 09:07:28AM +1000, Matthew Bobrowski wrote:
> > On Wed, Jul 21, 2021 at 10:06:56AM +0300, Amir Goldstein wrote:
> > > On Wed, Jul 21, 2021 at 9:17 AM Matthew Bobrowski <repnop@google.com> wrote:
> > > >
> > > > Hey Jan/Amir/Christian,
> > > >
> > > > This is an updated version of the FAN_REPORT_PIDFD series which contains
> > > > the addressed nits from the previous review [0]. As per request, you can
> > > > also find the draft LTP tests here [1] and man-pages update for this new
> > > > API change here [2].
> > > >
> > > > [0] https://lore.kernel.org/linux-fsdevel/cover.1623282854.git.repnop@google.com/
> > > > [1] https://github.com/matthewbobrowski/ltp/commits/fanotify_pidfd_v2
> > > > [2] https://github.com/matthewbobrowski/man-pages/commits/fanotify_pidfd_v1
> > > 
> > > FWIW, those test and man page drafts look good to me :)
> > 
> > Fantastic, thanks for the review!
> > 
> > I will adjust the minor comments/documentation on patch 5/5 and send
> > through an updated series.
> 
> Alright, so I've fixed up the git commit message and comment in the source
> code so that it's more accurate in terms of when/why FAN_NOPIDFD is
> reported.
> 
> I'm going to hold with sending through v4 until I have Jan also look peek
> and poke at v3 as I want to avoid doing any unnecessary round trips.

I've read through the series and I don't have any more comments besides the
objection raised by Jann. I'm still considering that one...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
