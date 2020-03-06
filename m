Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3999317C2EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 17:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFQ3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 11:29:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60305 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCFQ3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:29:04 -0500
Received: from ip-109-40-130-104.web.vodafone.de ([109.40.130.104] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jAFqN-0000CM-K3; Fri, 06 Mar 2020 16:28:59 +0000
Date:   Fri, 6 Mar 2020 17:28:58 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
Message-ID: <20200306162858.zy6u3tvutxvf27yw@wittgenstein>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
 <1583511310.3653.33.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1583511310.3653.33.camel@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 08:15:10AM -0800, James Bottomley wrote:
> On Fri, 2020-03-06 at 09:35 -0500, Josef Bacik wrote:
> > Many people have suggested this elsewhere, but I think we really need
> > to seriously consider it.  Most of us all go to the Linux Plumbers
> > conference.  We could accomplish our main goals with Plumbers without
> > having to deal with all of the above problems.
> 
> [I'm on the Plumbers PC, but not speaking for them, just making general
> observations based on my long history helping to run Plumbers]
> 
> Plumbers has basically reached the size where we can't realistically
> expand without moving to the bigger venues and changing our evening
> events ... it's already been a huge struggle in Lisbon and Halifax
> trying to find a Restaurant big enough for the closing party.
> 
> The other reason for struggling to keep Plumbers around 500 is that the
> value of simply running into people and having an accidental hallway
> track, which is seen as a huge benefit of plumbers, starts diminishing.
>  In fact, having a working hallway starts to become a problem as well
> as we go up in numbers (plus in that survey we keep sending out those
> who reply don't want plumbers to grow too much in size).
> 
> The other problem is content: you're a 3 day 4 track event and we're a
> 3 day 6 track event.  We get enough schedule angst from 6 tracks ... 10
> would likely become hugely difficult.  If we move to 5 days, we'd have
> to shove the Maintainer Summit on the Weekend (you can explain that one
> to Linus) but we'd still be in danger of the day 4 burn out people used
> to complain about when OLS and KS were co-located.
> 
> So, before you suggest Plumbers as the magic answer consider that the
> problems you cite below don't magically go away, they just become
> someone else's headache.
> 
> That's not to say this isn't a good idea, it's just to execute it we'd
> have to transform Plumbers and we should have a community conversation
> about that involving the current Plumbers PC before deciding it's the
> best option.

It's unlikely that this could still be done given that we're also facing
a little uncertainty for Plumbers. It seems like a lot of additional
syncing would be needed.
But the main concern I have is that co-locating both is probably quite
challenging for anyone attending both especially when organizing
something like a microconference.
