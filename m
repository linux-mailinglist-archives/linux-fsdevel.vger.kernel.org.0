Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42031EBA99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfJaXiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:38:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35736 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfJaXiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:38:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7so8459692lji.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2019 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhXMszijrgAIYzZ9gxH9cFx8EddXNjy2TqQatbYc+Nk=;
        b=PBPIT77AyNqMEwQoyQaCVkLT7M8TfLPd670Drrfj3I0N9/7rXzhpyODn6ZT2yOPckv
         Qilg0l2iIs3UAOmuW8gShWyhaY4PigFiFVzalfqYDBp0oX4PNC/kLszdO9L7c4pT8Cy9
         smo0IdWRKwLl/IbLW0IV5GFldBbIePTM3ejqrwHqLwPH5t3aRPk6EcmXOUvJS6vLwl84
         AFhXYsPEGcB2PqjP4vW+wM6A7JP+eryJelp5BLL9FrnWDvkUc/1vuW51d1lWSLC8Sjjb
         DM60FyewAhh+/w4wnrPgFSBfxJW8wUjS3sROz85MqDxchJDEKZmEFzyf/2uIe0AWD17+
         GwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhXMszijrgAIYzZ9gxH9cFx8EddXNjy2TqQatbYc+Nk=;
        b=TTqjrXXLh8LpasVUwuoSu9EDeuIlp1rexUjtlmq1GMTlDYgmzHCALdCROeEJ8DFceQ
         +JTCvjR2w6c0YRyMVZ/K0HAyJst+nbDEax1XVzx0Gi8Kz/txq5EyDgPqNSjg+58T2y5d
         GVc+Ad0nED/A8ivuAVU+OxssElaVmqs49qRCNyXqjOW2BEWaH/J2E3eaILcpdxsyWQmV
         rn6q6Nv9C1K/oikY66yRWRg8ZbA+FYHSGZrmzKqkYuL7ejhMas6+IMT0TgiJLAtVwZaQ
         xWABgJQmYR02s1bFpZNNF6MWJ4dvhqeEBQIan6qp9zqsfMkfGsjczoQ0bGGxY5X7pali
         fQ9w==
X-Gm-Message-State: APjAAAU2qZ/WyhI2onkziNH9vtcqGYVhCk4owJpGJKNqoXQ1Bvg8FGTT
        zOS/E64hcfdfr6ki7YGx3FSZU8247/8qixCJVUcq
X-Google-Smtp-Source: APXvYqy8BRCKDLBn26Bkj59INhzmzbXz5OoQirpWl9olE5rViDzVr+PfQj3xwew3Q+hP7oK7j+pufcBguSFvNfQncXo=
X-Received: by 2002:a2e:9249:: with SMTP id v9mr6136219ljg.184.1572565079262;
 Thu, 31 Oct 2019 16:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <CAHC9VhRDoX9du4XbCnBtBzsNPMGOsb-TKM1CC+sCL7HP=FuTRQ@mail.gmail.com>
 <20191030220320.tnwkaj5gbzchcn7j@madcap2.tricolour.ca> <3677995.NTHC7m0fHc@x2>
In-Reply-To: <3677995.NTHC7m0fHc@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Oct 2019 19:37:47 -0400
Message-ID: <CAHC9VhQ6Jq5kfrBZ21t9oFR9pYe5gxE2FxLPq27PcSCz4oFauA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 20/21] audit: add capcontid to set contid
 outside init_user_ns
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        omosnace@redhat.com, dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:51 AM Steve Grubb <sgrubb@redhat.com> wrote:
> On Wednesday, October 30, 2019 6:03:20 PM EDT Richard Guy Briggs wrote:
> > > Also, for the record, removing the audit loginuid from procfs is not
> > > something to take lightly, if at all; like it or not, it's part of the
> > > kernel API.
>
> It can also be used by tools to iterate processes related to one user or
> session. I use this in my Intrusion Prevention System which will land in
> audit user space at some point in the future.

Let's try to stay focused on the audit container ID functionality; I
fear if we start bringing in other unrelated issues we are never going
to land these patches.

> > Oh, I'm quite aware of how important this change is and it was discussed
> > with Steve Grubb who saw the concern and value of considering such a
> > disruptive change.
>
> Actually, I advocated for syscall. I think the gist of Eric's idea was that /
> proc is the intersection of many nasty problems. By relying on it, you can't
> simplify the API to reduce the complexity.

I guess complexity is relative in a sense, but reading and writing a
number from a file in procfs seems awfully simple to me.

> Almost no program actually needs
> access to /proc. ps does. But almost everything else is happy without it. For
> example, when you setup chroot jails, you may have to add /dev/random or /
> dev/null, but almost never /proc. What does force you to add /proc is any
> entry point daemon like sshd because it needs to set the loginuid. If we
> switch away from /proc, then sshd or crond will no longer /require/ procfs to
> be available which again simplifies the system design.

It's not that simple, there are plenty of container use cases beyond
ps which require procfs:

Most LSM aware applications require procfs to view and manage some LSM
state (e.g. /proc/self/attr).

System containers, containers that run their own init/systemd/etc.,
require a working procfs.

Nested container orchestrators often run in system containers, which
require a working procfs (see above).

I'm sure there are plenty others, but these are the ones that came
immediately to mind.

-- 
paul moore
www.paul-moore.com
