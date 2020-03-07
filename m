Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C5717CFA9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 19:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgCGSy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Mar 2020 13:54:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37727 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCGSy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Mar 2020 13:54:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id z12so2724249pgl.4;
        Sat, 07 Mar 2020 10:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hgakR1k+etmqZ1qtI59Bn7lxRJAnw6BxyTHQ7NAwUHc=;
        b=uhMblmTA0gX11AWupAZO+iGi+z3N5+PbErYvU06nzHheULhKlLU7o12MayFK/xNYMx
         MBEBhANDUwyHFpETZIDWw6tcj8NUNk/HYI1rXC0cGc4xvueJsVIk2wJwFXW0HXdD+Qk/
         9MFVRiDaJ/bB1S4pTl2VRYXZIC/6tSjkcVA3D8dihysyEhX/cC7GM1qII1gWdyCL8De5
         /gYwu1z0KtB2MU0Nz36d698ph9HCglg/Du9or1pTkew7/sFdNXyRc8RLxEK+vuCt+nFX
         YKH7yajeRUqIz3PwR3TeKSNLQKQdjLn7q2+EabYPbokdMgHr8dLqCN6NIataf6hkdFSJ
         cjAg==
X-Gm-Message-State: ANhLgQ2fPJIpL/dwWmXIrM2e8WZWMNIq1xnwvIdAPdaDS0vy+AtydM89
        4GlrnOOzSUlLu9VnA2R2tAg=
X-Google-Smtp-Source: ADFU+vsSwnhn+TzuxM7ZREWEte+cfby1aTALdsgpcss9+r26bax0PftHXg/ANCN0NXOqwbB0K3fjHA==
X-Received: by 2002:aa7:9f1c:: with SMTP id g28mr7357608pfr.140.1583607262396;
        Sat, 07 Mar 2020 10:54:22 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z15sm4451875pfg.152.2020.03.07.10.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 10:54:21 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 68F55401A8; Sat,  7 Mar 2020 18:54:20 +0000 (UTC)
Date:   Sat, 7 Mar 2020 18:54:20 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [LSFMMBPF TOPIC] LSFMMBPF 2020 COVID-19 status update
Message-ID: <20200307185420.GG2236@42.do-not-panic.com>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
 <20200306155611.GA167883@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306155611.GA167883@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 10:56:11AM -0500, Theodore Y. Ts'o wrote:
> Should we have LSF/MM/BPF in 2020 and COVID-19?

I'll try to take a proactive approach by doing my own digging, where
is what I have found, and few other proactive thoughts which might help:

The latest update posted on the LSFMM page from March 2 states things
are moving along as planned. After that on March 4th officials from the
county made a trip to Coachella Valley (22 minutes away from the LSFFMM
venue hotel) "to quell public fears about the spread of the novel
coronavirus", and announced that "there are no plans to cancel any of
the upcoming large events like Coachella, Stagecoach and the BNP" [0].

So, hippies are still getting together.

How about our brethren?

If we have to learn from efforts required to continue on with the in
light of the risks, we can look at what SCALE 18 is doing, taking place
right now in Pasadena [1], their page lists a list of proactive measures
required on their part to help alleviate fears and just good best
practices at this point in time.

The landscape seems positive, if we want, to move forward in Palm Springs then.

When are attendees supposed to get notifications if they are invited?

Since the nature of the conference however is unique in that it is
world-wide and invite-only it makes me wonder if the value is reduced
because of this and if we should cancel.

Does the latency involved on the confirmation of attending decrease
the value due to the current haphazard situation with COVID-19?

I am involved in other conferences and am seeing personal driven
cancelations for general concerns. For folks in the US it would be
easier / less risky to travel, so my concerns would be less than others.
But -- would we have higher personal cancelations from EU folks? What
are folks thoughts on this right now? Is anyone in the EU not coming
at all due to concerns who wouldn't mind voicing their concerns even
if LSFMM continues?

And then there is the other question: can we cancel? Or is that
economically just  too late at this point?

[0] https://kesq.com/news/2020/03/04/palm-springs-officials-to-hold-coronavirus-news-conference-on-thursday/
[1] https://www.socallinuxexpo.org/scale/18x

  Luis
