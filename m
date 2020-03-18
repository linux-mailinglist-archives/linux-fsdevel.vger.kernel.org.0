Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C959718A682
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 22:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgCRVIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 17:08:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41828 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbgCRVIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:08:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id v6so17538082edw.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2020 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WatAKLuqZtZlRLQCbRzYpTXRz9maWKDE4hUEG0f7NDw=;
        b=KblwfDmtszqt/poiiBnkGj80+eqtrRyKNLWAFKJyI2lM8X5PpTIHIUIc65zJhoEnEF
         WjcKc+bfilJdpRhIjI1m71RTPdnfUYwaMNgrlZfogSYuI3TKBJzAzVhAyAtHoPrdVKGp
         DLDa+hQ2FiF/ZRAW6YOkmNlRuau5tixJsAn5jRDu0LNFpGvf4mGlYW9x2j+4ybOULNy7
         eW1S/z/G2JKD/YF0c0IywP5jL7tjCmAMSfYHwjw2Mgd+8lo0HY2apy//ZlP3q1BuFweg
         kxv1DBMAmhdBV9qGqhU7t4qHJxKuYe+4PrnuMPBj6LktzBpmvLYwxL6iqDAV7QAmJ5iL
         I9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WatAKLuqZtZlRLQCbRzYpTXRz9maWKDE4hUEG0f7NDw=;
        b=oYo1OMcOFODe2uZTuTsuGqBaNa0EfB4no9Znz41DBTo6dUPo8z1aX98hHbqhKvlIH3
         ibAROtK8geY8WCQEGCWQhKVsIirKC5QH4gBArB88UqjQbLji27t8BZmN5T8jBlfx6q+E
         0b4A34a0nbXgLMx1z5TPg5y+QOrZs2gWLFoR2cMXDq8o0FP0wJi4sxx7TDEBCSLEZVqd
         4pi/XWtdj3s2UAIbBDqIUPq0lTgO1O4AJ0H8gUrHLw3eVatXGCD4NgJOa34nUOW34PLr
         wkpjZofFw1Jh8ANobmLemKV1jyBLzBr5/w9wctOWh3zF9pyHJ64uWs4NPM+rJiaipCSV
         6RUQ==
X-Gm-Message-State: ANhLgQ0tk1BccWV0mNTroRr6skG6D/fJKX6poxc7AaXWpKBQpp1V3moW
        Swf9qw3BjKi9JC3Pt9oqKyvm64fg6pSpsfcLB59W
X-Google-Smtp-Source: ADFU+vvbYGHqEIZHFDpAJYIn0BKyhX1aU7rGbDTvr2tbcPYmEgbd2Lwck7tUApGNIqLuzMQYQdyQBqa6eqOf1oPvVLM=
X-Received: by 2002:aa7:d051:: with SMTP id n17mr5727973edo.196.1584565722903;
 Wed, 18 Mar 2020 14:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <6452955c1e038227a5cd169f689f3fd3db27513f.1577736799.git.rgb@redhat.com>
 <CAHC9VhRkH=YEjAY6dJJHSp934grHnf=O4RiqLu3U8DzdVQOZkg@mail.gmail.com>
 <20200130192753.n7jjrshbhrczjzoe@madcap2.tricolour.ca> <CAHC9VhSVN3mNb5enhLR1hY+ekiAyiYWbehrwd_zN7kz13dF=1w@mail.gmail.com>
 <20200205235056.e5365xtgz7rbese2@madcap2.tricolour.ca> <CAHC9VhTM6MDHLcBfwJ_9DCroG0VA-meO770ihjn1sVy6=0JrHw@mail.gmail.com>
 <20200312205147.plxs4czjeuu4davj@madcap2.tricolour.ca> <CAHC9VhTqWdXMsbSbsWJzRRvVbSaaFBmnFFsVutM7XSx5NT_FJA@mail.gmail.com>
 <20200314224203.ncyx3rgwwe6zet4e@madcap2.tricolour.ca>
In-Reply-To: <20200314224203.ncyx3rgwwe6zet4e@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Mar 2020 17:08:31 -0400
Message-ID: <CAHC9VhTy2ou-vadeMjgTaw-T9mW+nBjbqapA7RSW3EFNJ44JLw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 13/16] audit: track container nesting
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 14, 2020 at 6:42 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-03-13 12:47, Paul Moore wrote:

...

> > It has been a while since I last looked at the patchset, but my
> > concern over the prefered use of the ACID number vs the ACID object is
> > that the number offers no reuse protection where the object does.  I
> > really would like us to use the object everywhere it is possible.
>
> Ok, so I take it from this that I go ahead with the dual format since
> the wrapper funciton to convert from object to ID strips away object
> information negating any benefit of favouring the object pointer.  I'll
> look at the remaining calls that use a contid (rather than contobj) and
> convert all that I can over to storing an object using the dual counters
> that track process exits versus signal2 and trace references.

Well, as I said in the other thread, I'm not sure we need a full two
counters; I think one counter and a simple flag should suffice.
Otherwise that sounds good for the next iteration.

-- 
paul moore
www.paul-moore.com
