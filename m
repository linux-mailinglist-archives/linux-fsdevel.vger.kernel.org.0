Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D295153B89
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 23:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgBEW6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 17:58:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44940 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgBEW6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:58:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id g19so3846254eds.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2020 14:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUqqVzVv+zHVRjksql7Cab1+TMNFjyRWbvebZrdripg=;
        b=RNwHSh2uWCO9tLjuX2QtbpIaLYOgempdFirtNjAkAtl2Lv53y46dHjKm71oMQgMoAC
         SBO8ofU2YRe0ZOpozTHfBE9dWtCVlTzEnRjLzNUNh+QWq+5N6T0J9Uh9t7t+8hTWoF+9
         jIayozCNbwf0lGc0TDFHk7p+O9scR0Q58bIZ3tHbX9+KdOvZHkGiFUztFcYXe8fPt0/2
         kvLAqsTBAcNWdLk5YDyo+6f1q0KuTCLHc4eVbOY0St5zcriy86UeHDmtEnvx4+TV1sc7
         HJLZosR9LDytBdZEDnKXSj9vpSPq3CMMdFHusYNtVgWh70JO/sAOFoOJpbLerAjTch0Y
         zmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUqqVzVv+zHVRjksql7Cab1+TMNFjyRWbvebZrdripg=;
        b=qBMtL3D/BnIhnpFG5DfH4U4RYR7zoi0AlC66h/D/JFU4L9CEO+qkRjZCbEtMREQ/JQ
         2w3iriwYAS20w1R210qiRv0Wb3DSBt5vwCdOW7LP3mtCDuQBefWOUlzK5+T1OFEMdV7M
         JD7CdRlScCflL6YJgwAMJLu8CM+2WlFgwESXN8m9mFj3jlrD1ZVs48EYjwXgRLqQ/D/M
         EzCMxDFd8tuej+m0/A7eL278R6QsW3aJ8Xm7zXLeY39pIPTn7YAiqiMefQdb5yyQTfsf
         a3YLjJnP6ijWnIiarjjpmksjPMuw1dt0AQ5jG8rrMBesLgBPesD+TmZFa/4yIVzNR4od
         fMmg==
X-Gm-Message-State: APjAAAXCfVoxNlFAjkk1k1GR9xs8wZpH3fQLD+UQkR9y4VGlE6BIZNT3
        2Qo/TH8uRfY7VdjDBzTvt6gTMoxyzk9uonUk5uIT
X-Google-Smtp-Source: APXvYqyqotke6mOUBVhpWeNPdxHTvQmAmbBNNpCHK3jA+gycAlKDCEspfqtGiRIi6zOl8VqQ5CArsS+4qJCbOLGo7NA=
X-Received: by 2002:a17:906:9352:: with SMTP id p18mr292520ejw.95.1580943486402;
 Wed, 05 Feb 2020 14:58:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <3665686.i1MIc9PeWa@x2>
 <CAHC9VhRHfjuv5yyn+nQ2LbHtcezBcjKtOQ69ssYrXOiExuCjBw@mail.gmail.com> <35934535.C1y6eIYgqz@x2>
In-Reply-To: <35934535.C1y6eIYgqz@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Feb 2020 17:57:55 -0500
Message-ID: <CAHC9VhQnNUM8XQpFykx_Rg0zNLCaCWDo=HSY3RPhN3ft-RpyHw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 13/16] audit: track container nesting
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

On Tue, Feb 4, 2020 at 1:12 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Tuesday, February 4, 2020 10:52:36 AM EST Paul Moore wrote:
> > On Tue, Feb 4, 2020 at 10:47 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > On Tuesday, February 4, 2020 8:19:44 AM EST Richard Guy Briggs wrote:
> > > > > The established pattern is that we print -1 when its unset and "?"
> > > > > when
> > > > > its totalling missing. So, how could this be invalid? It should be
> > > > > set
> > > > > or not. That is unless its totally missing just like when we do not
> > > > > run
> > > > > with selinux enabled and a context just doesn't exist.
> > > >
> > > > Ok, so in this case it is clearly unset, so should be -1, which will be
> > > > a
> > > > 20-digit number when represented as an unsigned long long int.
> > > >
> > > > Thank you for that clarification Steve.
> > >
> > > It is literally a  -1.  ( 2 characters)
> >
> > Well, not as Richard has currently written the code, it is a "%llu".
> > This was why I asked the question I did; if we want the "-1" here we
> > probably want to special case that as I don't think we want to display
> > audit container IDs as signed numbers in general.
>
> OK, then go with the long number, we'll fix it in the interpretation. I guess
> we do the same thing for auid.

As I said above, I'm okay with a special case handling for unset/"-1"
in this case.

-- 
paul moore
www.paul-moore.com
