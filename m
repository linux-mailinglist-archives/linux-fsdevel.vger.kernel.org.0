Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86D8517C380
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 18:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCFRE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 12:04:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36116 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFRE0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:04:26 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAGOX-006OO2-9c; Fri, 06 Mar 2020 17:04:17 +0000
Date:   Fri, 6 Mar 2020 17:04:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
Message-ID: <20200306170417.GX23230@ZenIV.linux.org.uk>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
 <20200306160548.GB25710@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306160548.GB25710@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 08:05:48AM -0800, Matthew Wilcox wrote:

> > 4) Presentations.  90% of the conference is 1-2 people standing at the front
> > of the room, talking to a room of 20-100 people, with only a few people in
> > the audience who cares.  We do our best to curate the presentations so we're
> > not wasting peoples time, but in the end I don't care what David Howells is
> > doing with mount, I trust him to do the right thing and he really just needs
> > to trap Viro in a room to work it out, he doesn't need all of us.
> 
> ... and allow the other 3-5 people who're interested or affected the
> opportunity to sit in.  Like a mailing list, but higher bandwidth.

Latency can be more unpleasant, actually - you try to discuss something between
3 people, when one is in .uk, another - in .us (east coast) and the third one -
in ,au (also east coast).  Timezone deltas - 5 hours and 8 hours, in opposite
directions...  Incidentally, that was about mount, with me and David being
two of participants; I somewhat hoped to get that sorted out at LSF, but Ian
won't be there anyway.  OTOH, that's just an 8 hours delta...
