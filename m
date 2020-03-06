Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5882917C2AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 17:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFQPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 11:15:15 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54194 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgCFQPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:15:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BB9568EE11D;
        Fri,  6 Mar 2020 08:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583511313;
        bh=8YpCvOiJJi5LTO+evXy59uUm4Zsec62w1mieXmyW+kI=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=DaVISfktNZm6M2hTMMdHP2NyH0i226RQsMh5g/azWA2Rc/kL1NtESbao6Od7niajr
         sPSXTVHaagb5fw1Nb6NMiaf/R3Jww0sbzx4bbRL72V2Zq7bZUhtohrgmu/b1J3QotV
         QIgu4MlzuNwInwWQVQHbet3Tqy+3OR4Vy1q4rMBE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uuYYQODxeSmb; Fri,  6 Mar 2020 08:15:13 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6F29C8EE0F8;
        Fri,  6 Mar 2020 08:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583511312;
        bh=8YpCvOiJJi5LTO+evXy59uUm4Zsec62w1mieXmyW+kI=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=BMTS5yudsTFnMaSxPU9gxGUHp77C2D3h+fSW32Q4Xc5Oy60Fai+9QXDsbEAZHSTnG
         HgPAkCvPZH8a1P1W8laSz1XuWrN+eO1wlMHBzQtpulbJkM2KKG4XR5duFwPoVp9IyW
         X/OgJ84cENu8wo8vL91rnVwPdubkHJDMUYE83SsQ=
Message-ID: <1583511310.3653.33.camel@HansenPartnership.com>
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Date:   Fri, 06 Mar 2020 08:15:10 -0800
In-Reply-To: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-03-06 at 09:35 -0500, Josef Bacik wrote:
> Many people have suggested this elsewhere, but I think we really need
> to seriously consider it.  Most of us all go to the Linux Plumbers
> conference.  We could accomplish our main goals with Plumbers without
> having to deal with all of the above problems.

[I'm on the Plumbers PC, but not speaking for them, just making general
observations based on my long history helping to run Plumbers]

Plumbers has basically reached the size where we can't realistically
expand without moving to the bigger venues and changing our evening
events ... it's already been a huge struggle in Lisbon and Halifax
trying to find a Restaurant big enough for the closing party.

The other reason for struggling to keep Plumbers around 500 is that the
value of simply running into people and having an accidental hallway
track, which is seen as a huge benefit of plumbers, starts diminishing.
 In fact, having a working hallway starts to become a problem as well
as we go up in numbers (plus in that survey we keep sending out those
who reply don't want plumbers to grow too much in size).

The other problem is content: you're a 3 day 4 track event and we're a
3 day 6 track event.  We get enough schedule angst from 6 tracks ... 10
would likely become hugely difficult.  If we move to 5 days, we'd have
to shove the Maintainer Summit on the Weekend (you can explain that one
to Linus) but we'd still be in danger of the day 4 burn out people used
to complain about when OLS and KS were co-located.

So, before you suggest Plumbers as the magic answer consider that the
problems you cite below don't magically go away, they just become
someone else's headache.

That's not to say this isn't a good idea, it's just to execute it we'd
have to transform Plumbers and we should have a community conversation
about that involving the current Plumbers PC before deciding it's the
best option.

James

