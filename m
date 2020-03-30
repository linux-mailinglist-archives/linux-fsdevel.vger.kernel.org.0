Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB845197E52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 16:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgC3O0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 10:26:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41767 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgC3O0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:26:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id v1so20801385edq.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2020 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIwHXYaHc6+JACA+fBj9Ng03i5CGrWKmbD2K5DI9CIE=;
        b=ajvRh38GUf77mUItDVx5WbVN3YYFvjpLhHpwTv84kBQrU1zHTfXiaouPYDLxmTBG45
         8MfOdRSj5sryUlWJASFBkFehPbzj8g+e0VLiclXWIZ4G7TNuAWnOLRZsHy5ZILaeErIk
         LqDtUQMsHOq4lmfzrcPHMubNv/dsDfNl88x3vGdvlTcKgkieRjEG7LJI1fd9nz6RqZu5
         BOFFrhLvSD3REAwMRyI7d5+5fdIIBNKMwpnUqrTKVhUtpQqIoLekud+8zPPbmsCM+lt0
         dRMyhqGXKHl96BJACIDgeCHLcpYrgLmsx7K26Jot1RzI/1+tsWiYSF1NdBH7pmfmhUq/
         WEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIwHXYaHc6+JACA+fBj9Ng03i5CGrWKmbD2K5DI9CIE=;
        b=CCkfMq9md7zGK/ypvNoNAaLEOP4m0Lx5HYDpEwoWxUICsnpTAGiMYzE9zU8rujbGCW
         +81x4OMJwzHVa/uPHUFfCSn2bodHxnUADnoGr4cP/1GU2lYZbv2UnrPGNZeMm+5mxQht
         xsar2nLJhjM7+EWlR7UQNaTr1YecRciwXunWKdI7Gzig97xQCArKTPCZFJPVr5ju8TQq
         hCUIc2JIbKAPJKpHAI0ejvLp1rWdtl+erR55AvPdFzBAlG/32/gqjhGKJmqT2++BNKHn
         mskL27K/zoxbSkYWuYeZLopDUXaCQuYKlhDXRHVuf/qhqCUlf7F1Ob7bsQcjhHqFyUFk
         9zYg==
X-Gm-Message-State: ANhLgQ0/UTHbMtb01Hi6g0gXRFlclmCDgohbmEuLvOwBdvPeZr4SCudm
        UQYnQkwQ7lICCu1K1acQMneEFyiPnxa4RCIKJDbv
X-Google-Smtp-Source: ADFU+vvlCnwKHdKl+nxVyk3rZYlrc9sBCQh+XYbClaJVIEpd7a51sng79ner8qjsey4+ghjyaCmOteBvcjGEv+YeeMA=
X-Received: by 2002:aa7:c48f:: with SMTP id m15mr9786550edq.164.1585578403828;
 Mon, 30 Mar 2020 07:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200313185900.y44yvrfm4zxa5lfk@madcap2.tricolour.ca>
 <CAHC9VhR2zCCE5bjH75rSwfLC7TJGFj4RBnrtcOoUiqVp9q5TaA@mail.gmail.com>
 <20200318212630.mw2geg4ykhnbtr3k@madcap2.tricolour.ca> <CAHC9VhRYvGAru3aOMwWKCCWDktS+2pGr+=vV4SjHW_0yewD98A@mail.gmail.com>
 <20200318215550.es4stkjwnefrfen2@madcap2.tricolour.ca> <CAHC9VhSdDDP7Ec-w61NhGxZG5ZiekmrBCAg=Y=VJvEZcgQh46g@mail.gmail.com>
 <20200319220249.jyr6xmwvflya5mks@madcap2.tricolour.ca> <CAHC9VhR84aN72yNB_j61zZgrQV1y6yvrBLNY7jp7BqQiEDL+cw@mail.gmail.com>
 <20200324210152.5uydf3zqi3dwshfu@madcap2.tricolour.ca> <CAHC9VhTQUnVhoN3JXTAQ7ti+nNLfGNVXhT6D-GYJRSpJHCwDRg@mail.gmail.com>
 <20200330134705.jlrkoiqpgjh3rvoh@madcap2.tricolour.ca>
In-Reply-To: <20200330134705.jlrkoiqpgjh3rvoh@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Mar 2020 10:26:34 -0400
Message-ID: <CAHC9VhQTsEMcYAF1CSHrrVn07DR450W9j6sFVfKAQZ0VpheOfw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling
 the audit daemon
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        linux-audit@redhat.com, netfilter-devel@vger.kernel.org,
        ebiederm@xmission.com, simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 9:47 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-03-28 23:11, Paul Moore wrote:
> > On Tue, Mar 24, 2020 at 5:02 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2020-03-23 20:16, Paul Moore wrote:
> > > > On Thu, Mar 19, 2020 at 6:03 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > On 2020-03-18 18:06, Paul Moore wrote:
> > > >
> > > > ...
> > > >
> > > > > > I hope we can do better than string manipulations in the kernel.  I'd
> > > > > > much rather defer generating the ACID list (if possible), than
> > > > > > generating a list only to keep copying and editing it as the record is
> > > > > > sent.
> > > > >
> > > > > At the moment we are stuck with a string-only format.
> > > >
> > > > Yes, we are.  That is another topic, and another set of changes I've
> > > > been deferring so as to not disrupt the audit container ID work.
> > > >
> > > > I was thinking of what we do inside the kernel between when the record
> > > > triggering event happens and when we actually emit the record to
> > > > userspace.  Perhaps we collect the ACID information while the event is
> > > > occurring, but we defer generating the record until later when we have
> > > > a better understanding of what should be included in the ACID list.
> > > > It is somewhat similar (but obviously different) to what we do for
> > > > PATH records (we collect the pathname info when the path is being
> > > > resolved).
> > >
> > > Ok, now I understand your concern.
> > >
> > > In the case of NETFILTER_PKT records, the CONTAINER_ID record is the
> > > only other possible record and they are generated at the same time with
> > > a local context.
> > >
> > > In the case of any event involving a syscall, that CONTAINER_ID record
> > > is generated at the time of the rest of the event record generation at
> > > syscall exit.
> > >
> > > The others are only generated when needed, such as the sig2 reply.
> > >
> > > We generally just store the contobj pointer until we actually generate
> > > the CONTAINER_ID (or CONTAINER_OP) record.
> >
> > Perhaps I'm remembering your latest spin of these patches incorrectly,
> > but there is still a big gap between when the record is generated and
> > when it is sent up to the audit daemon.  Most importantly in that gap
> > is the whole big queue/multicast/unicast mess.
>
> So you suggest generating that record on the fly once it reaches the end
> of the audit_queue just before being sent?  That sounds...  disruptive.
> Each audit daemon is going to have its own queues, so by the time it
> ends up in a particular queue, we'll already know its scope and would
> have the right list of contids to print in that record.

I'm not suggesting any particular solution, I'm just pointing out a
potential problem.  It isn't clear to me that you've thought about how
we generate a multiple records, each with the correct ACID list
intended for a specific audit daemon, based on a single audit event.
Explain to me how you intend that to work and we are good.  Be
specific because I'm not convinced we are talking on the same plane
here.

-- 
paul moore
www.paul-moore.com
