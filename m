Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2403E4D3D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 21:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhHITpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 15:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbhHITpj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 15:45:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA1BC0613D3;
        Mon,  9 Aug 2021 12:45:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p38so8792346lfa.0;
        Mon, 09 Aug 2021 12:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DOED0VotuCVEYcyrGmWcGuG5s/v4y1T9PJdVveabexo=;
        b=ncYmL4TN/lwzhXZo7hrhqvxwuUWaobMvpmlvy1k10IGkDGaSav8yqJ7S6NcvVM5hzw
         ARi49oOKqFNU04F7xPq/paptaktZa2GKjb9hvPlv6z0PT8hNWFpeC2nmagbhEBIh5VZH
         rXOuH90hsD/UMOYTqdorHn2L5OFhV1WvWuBGerp48bPxblFv6Ej3FTxK39DaAmnxRMB7
         +aHR/3/z1J6WckcPsZtpVr5hACrBj58792phXWFerzTtMh8ZATvkPpWUEzREmV2SoQrP
         iG1FK04lnIkb0F/376e319tdo1giCyRXHmy0wT0rVlTwx4uicCPF3yg3bVOo8WKUXwqM
         Up3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DOED0VotuCVEYcyrGmWcGuG5s/v4y1T9PJdVveabexo=;
        b=cH3GjRvv1wJko/IuIX+ZrHOy6A3ZFP4wPeIcGY7Uk7eqtA7EqGkXCTXwAIh+/mcmAt
         ZlatfJZysOwdKkRNPuIvmRarzrrcYCW0EKWf2ea7DoXW3XOeNo1u1W91gsSNOhj7qh7M
         LE8iKKv446CWe8+LAZRud69wpKlv7bMDWk1dNLMImAMuGo3UpfOfyMnUhbcdJYU+Iwdj
         0ay6yU3c9TXyrQqHZ/IROAuHl5ApE1NjEzZXXMJ0vNIRg08Tny+tuqxbvXpURlXNocuf
         E4gGIBGWQo45GFf/zh5m3cXW6H69MTcf8tlukP7qObsyUMvV0H2N2AyUHMe1R4UIIJbU
         eRSw==
X-Gm-Message-State: AOAM530qDOX7UrhDsDUCsbAvuX6gvTj59LCpOdFDZSBVzfSTia+4QJ7J
        W0mGi6XHs6jmSfC6NuAVdgk=
X-Google-Smtp-Source: ABdhPJy8YN684aOpruQcDApFcrRq66E/1m/l6HR9maI4geKmr/ljnATCJdremPLHl7GozfW3rw3mcA==
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr18623358lfs.533.1628538317030;
        Mon, 09 Aug 2021 12:45:17 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id j10sm1699950lfm.299.2021.08.09.12.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 12:45:16 -0700 (PDT)
Date:   Mon, 9 Aug 2021 22:45:14 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH v27 10/10] fs/ntfs3: Add MAINTAINERS
Message-ID: <20210809194514.zdc2br3tonoe4zcu@kari-VirtualBox>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-11-almaz.alexandrovich@paragon-software.com>
 <20210809105652.GK5047@twin.jikos.cz>
 <918ff89414fa49f8bcb2dfd00a7b0f0b@paragon-software.com>
 <20210809164425.rcxtftvb2dq644k5@kari-VirtualBox>
 <305bdb56-d40f-2774-12fe-5113f15df5c6@infradead.org>
 <CAA9_cmeK==ZS1wdiOM70L-=z9vQWHiwReS103RfDbCs8weaAzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA9_cmeK==ZS1wdiOM70L-=z9vQWHiwReS103RfDbCs8weaAzw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 11:56:30AM -0700, Dan Williams wrote:
> On Mon, Aug 9, 2021 at 9:58 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 8/9/21 9:44 AM, Kari Argillander wrote:
> > > On Mon, Aug 09, 2021 at 04:16:32PM +0000, Konstantin Komarov wrote:
> > >> From: David Sterba <dsterba@suse.cz>
> > >> Sent: Monday, August 9, 2021 1:57 PM
> > >>> On Thu, Jul 29, 2021 at 04:49:43PM +0300, Konstantin Komarov wrote:
> > >>>> This adds MAINTAINERS
> > >>>>
> > >>>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > >>>> ---
> > >>>>   MAINTAINERS | 7 +++++++
> > >>>>   1 file changed, 7 insertions(+)
> > >>>>
> > >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> > >>>> index 9c3428380..3b6b48537 100644
> > >>>> --- a/MAINTAINERS
> > >>>> +++ b/MAINTAINERS
> > >>>> @@ -13279,6 +13279,13 @@ T:        git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
> > >>>>   F:       Documentation/filesystems/ntfs.rst
> > >>>>   F:       fs/ntfs/
> > >>>>
> > >>>> +NTFS3 FILESYSTEM
> > >>>> +M:        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > >>>> +S:        Supported
> > >>>> +W:        http://www.paragon-software.com/
> > >>>> +F:        Documentation/filesystems/ntfs3.rst
> > >>>> +F:        fs/ntfs3/
> > >>>
> > >>> Can you please add a git tree and mailing list entries?
> > >
> > >> Hi David, I'll add the git tree link for the sources to MAINTAINERS in the next patch. As for the mailing list,
> > >> apologies for the newbie question here, but will it possible to have the @vger.kernel.org list for the ntfs3,
> > >> or it must be external for our case?
> > >> Thanks!
> > >
> > > Good question and I also do not have absolute truth about it but I try
> > > to help. It should be possible. I think you can request new list from
> > > postmaster@vger.kernel.org
> > >
> > > If you need public git tree then kernel.org can maybe provide that. They
> > > also host ntfs so I think no problem with ntfs3. This way you self
> > > do not have to worry public list. But I'm not sure how strict is now
> > > days get account. But if you say that it would be nice that you need
> > > kernel git then maybe someone can help with that.
> > > See more info https://www.kernel.org/faq.html
> >
> > If postmaster@vger.kernel.org isn't helpful or you just want to use
> > kernel.org (note that vger.kernel.org isn't part of kernel.org),
> > you can contact: helpdesk@kernel.org  for git tree or mailing list
> > requests.  Wherever you have a mailing list, you probably should
> > have it archived at lore.kernel.org (see next URL for that).
> >
> > Also you may want to read  https://korg.wiki.kernel.org
> 
> There is also lists.linux.dev for kernel development focused lists:
> 
> https://subspace.kernel.org/lists.linux.dev.html

That seems to be "new vger" so this is the way to go. Good that you bring it
up. More info here https://www.kernel.org/lists-linux-dev.html This was just
in site news so it was kinda hard to find.

