Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DBB24E1EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 22:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHUUOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 16:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUUN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:13:59 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C5DC061573
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 13:13:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d11so3621208ejt.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4BtYd9/pAyG1sqGYcTy0rM8tdo0b9K0n3vpfXHvN2DE=;
        b=j1MIxYG+ikKdio/J7EEBu7O+TNel4fKx2ssCXBwf1QibUwKRpqucOcuBx8WB9+MiBp
         yWrpVaS2g4Or8Vsgeq38loMK2o7Ehei2ZhGdshzTafjfyQPoSREWCiy0QXYZYfRIFhsT
         rTX73zkaUPpfX9PRT8k7hafwBU0/ZL0kTf0UUf4nCTb6d68XXCqd64OJIKfV2JWombm8
         WTvRKC3G/CXx75X6/3nsms/N8S8lVzAnUwH06hP72mPQZLr6XxUyXRvWSt0dEEaBoIAL
         5jICYw/OQX1fLwvVhaTNQEe18HTXI5YoEY/jhuo+AvRywFaNHSFUfJHBfv8LqQl2sIo2
         vCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BtYd9/pAyG1sqGYcTy0rM8tdo0b9K0n3vpfXHvN2DE=;
        b=cpFzsYgkDDMVtkHy67JZAAjg92qAvYkzFZTtVPDHFkQ4b4xbmQKVIqC2Yir6FLRUeq
         Ic0mCunxJlgjf5NuixfCR32j1lC3p7qgWDn2FAUpH9NcWRCe1Jjk2xyBeCNZ/pVYl+mo
         eNWyPah+3KaVHD/CA44hBES7JuccLWu+VigwvYFZgb+Z+zFhYd2Hkior7T/RWX/hI+5g
         XFGUhL1twudqUT0DuCj2O/h07qFhTB7ig+HvgBi/411z8XszJSGu9wMtmRBEPifaD5dk
         9EskUqKQ9XENMAzlysYk3UFXgHNAG1VHm4TDaiZjXP8lD5qpPAT7hoSavlh7iss7JqyK
         +3/w==
X-Gm-Message-State: AOAM530Xb8W5aBxE2a8YfmzRkxCTc1LjOKZFUoaMjiTTLGDCmuUUizWm
        8zISzEo1IDRQfi7HVTCS/Fp8QLmOqfQ14Yrawh8M
X-Google-Smtp-Source: ABdhPJyd88CfX7VJaFvZK1tKg0a4ztk8lkZlg+SopdBDlMcFpbfuejWoSXXNsA00gY0qnev4OvuNLAl+o4ySJ/3jueM=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr4526810ejn.542.1598040837725;
 Fri, 21 Aug 2020 13:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <01229b93733d9baf6ac9bb0cc243eeb08ad579cd.1593198710.git.rgb@redhat.com>
 <CAHC9VhT6cLxxws_pYWcL=mWe786xPoTTFfPZ1=P4hx4V3nytXA@mail.gmail.com> <20200807171025.523i2sxfyfl7dfjy@madcap2.tricolour.ca>
In-Reply-To: <20200807171025.523i2sxfyfl7dfjy@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 16:13:45 -0400
Message-ID: <CAHC9VhQ3MVUY8Zs4GNXdaqhiPJBzHW_YcCe=DghAgo7g6yrNBw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 11/13] audit: contid check descendancy and nesting
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>, aris@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 7, 2020 at 1:10 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-07-05 11:11, Paul Moore wrote:
> > On Sat, Jun 27, 2020 at 9:23 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Require the target task to be a descendant of the container
> > > orchestrator/engine.

If you want to get formal about this, you need to define "target" in
the sentence above.  Target of what?

FWIW, I read the above to basically mean that a task can only set the
audit container ID of processes which are beneath it in the "process
tree" where the "process tree" is defined as the relationship between
a parent and children processes such that the children processes are
branches below the parent process.

I have no problem with that, with the understanding that nesting
complicates it somewhat.  For example, this isn't true when one of the
children is a nested orchestrator, is it?

> > > You would only change the audit container ID from one set or inherited
> > > value to another if you were nesting containers.

I thought we decided we were going to allow an orchestrator to move a
process between audit container IDs, yes?  no?

> > > If changing the contid, the container orchestrator/engine must be a
> > > descendant and not same orchestrator as the one that set it so it is not
> > > possible to change the contid of another orchestrator's container.

Try rephrasing the above please, it isn't clear to me what you are
trying to say.

> Are we able to agree on the premises above?  Is anything asserted that
> should not be and is there anything missing?

See above.

If you want to go back to the definitions/assumptions stage, it
probably isn't worth worrying about the other comments until we get
the above sorted.

-- 
paul moore
www.paul-moore.com
