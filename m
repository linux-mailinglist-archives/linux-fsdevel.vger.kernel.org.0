Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7CF317C6FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 21:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFU0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 15:26:07 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47118 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbgCFU0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:26:07 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 026KPXT6005112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Mar 2020 15:25:34 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 113E242045B; Fri,  6 Mar 2020 15:25:33 -0500 (EST)
Date:   Fri, 6 Mar 2020 15:25:32 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [LSFMMBPF TOPIC] long live LFSMMBPF
Message-ID: <20200306202532.GC12490@mit.edu>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
 <76B62C4B-6ECB-482B-BF7D-95F42E43E7EB@fb.com>
 <1583523705.3653.94.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583523705.3653.94.camel@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 11:41:45AM -0800, James Bottomley wrote:
> And, for everyone who gave us feedback in the Plumbers surveys that co-
> locating with a big conference is *not* what you want because of
> various problems like hallway track disruptions due to other conference
> traffic and simply the difficulty of finding people, the current model
> under consideration is one conference organization (the LF) but two
> separate venues, sort of like OpenStack used to do for their big
> conference and design summit to minimize disruption and increase
> developer focus.

Ths is what I tried to push last year, which was to colocate LSF/MM
and KS/MS in Austin, at the same time as OSS 2020, but in a separate
hotel so we didn't have to deal with the cast of thousands which go to
OSS.  I also liked it because OSS 2020 is in June, so it would have
been from a spacing perspective it would have been an easy way to
start moving MS/KS from the second half of the year into first half of
the year.

But some folks pointed out (not without reason), that Palm Springs was
a lot more fun than Austin, and OSS still has a somewhat bad
reputation of having some really trashy talks, and so even in separate
venue, there were people who really didn't like the idea.

Because of this, when the LF (in December 2019) suggested moving the
MS/KS to Austin as part of OSS, I didn't think we would have critical
mass to overcome the reputation of talks like "#OSSummit: Seven
Properties of Highly Secure IoT." and so I told Angela, "No, we really
can't do this without something like LSF/MM to make sure we have
critical mass for a second Linux systems conference."

						- Ted
