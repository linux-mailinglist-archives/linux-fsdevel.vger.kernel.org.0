Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6830C415E60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 14:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbhIWMae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 08:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240907AbhIWMad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632400142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6i3fBCJC10gtsE4qGMBj68+CN3wfV5gDLQqR168G9Dk=;
        b=AUywM8aeQEOqiUKbsvyGbzmmDmFl8lNtRuyOGhC3VWPpuiVlssYTc4xorIfWQiGJIuplQJ
        EHvXXhhUeUL7iCeZWlGVoXytHuo0INavZxu7myAhMeaaNkmMnnkGeGjCFPj/VSR1pLhYPT
        NDIrKp84h2hxbQP+OtefQHLPBfQHZzA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-OlUfGqqTMTOOzjSyjiAxdg-1; Thu, 23 Sep 2021 08:29:00 -0400
X-MC-Unique: OlUfGqqTMTOOzjSyjiAxdg-1
Received: by mail-ed1-f70.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso6665882edx.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 05:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6i3fBCJC10gtsE4qGMBj68+CN3wfV5gDLQqR168G9Dk=;
        b=UFTDjFUIFqrTmxsZJk2n3hXpWH31o1q/rm+UzWwqQb0efvNX58eRp9yyvjBhN+oIwM
         3qfrSs9SaH3Z9OMgyZ0Q3t8JZo3jr80Tzp2z0BVlYwi8jGZkRuQZsoxdhvi748BchcIj
         4aig2Uwfft4kfO3gHhVJWVSa3eNrAdu5V2eNRNHcLMX25JSATyYVHQwjoKIMDlYLkc2h
         QdUwhS+x3fDDs8oYjdhXdnJMmeYmEs1ghoGwlk1LQfgVol7kQPLHsK35rSHrJt3d7N/I
         msLnSDO65Rqdzb/rlqrdyczZYA4bE4CVZ86zgFskXS4JY2CRAyD/RegJMJrMAMB2vrP3
         DXFg==
X-Gm-Message-State: AOAM533HXuQ4VkUS02eHu4pqrPyOlJ87CxtMv7JtzRDt/JB9xyK1/E09
        farApRvW3WHtocOKma/iTX8b5dS+7H6LFXfyBtVxkPCe7E5Kn66T5UXsxzPgyv//VjvoFA4QB7/
        ZUCSY9NIJdAkET8wkRhJq260Wxdr8hpwJ2jtCCWtcbQ==
X-Received: by 2002:a05:6402:897:: with SMTP id e23mr5170318edy.366.1632400139640;
        Thu, 23 Sep 2021 05:28:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYy/wWQjDZ/fGJqWWcZXPsmQpw7zVgYaxHXKM9mcBOBv23lQ9FsWLSB4TCRkEY8aeJhdj1dMYp2jbTehNSdpA=
X-Received: by 2002:a05:6402:897:: with SMTP id e23mr5170301edy.366.1632400139463;
 Thu, 23 Sep 2021 05:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210721113057.993344-1-rbergant@redhat.com> <YSeNNnNBW7ceLuh+@casper.infradead.org>
 <a5873099-a803-3cfa-118f-0615e7a65130@sandeen.net> <CACWnjLxtQOcpLGES1bX1cN8E4PYSx-EVk0=akMUss1pXuk1Q7A@mail.gmail.com>
In-Reply-To: <CACWnjLxtQOcpLGES1bX1cN8E4PYSx-EVk0=akMUss1pXuk1Q7A@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 23 Sep 2021 08:28:23 -0400
Message-ID: <CALF+zOmuj2VJn=g-HwB8mbEPLtKcUC29LxLx4Vh2a_cjYw5A6A@mail.gmail.com>
Subject: Re: [PATCH] vfs: parse sloppy mount option in correct order
To:     Roberto Bergantinos Corpas <rbergant@redhat.com>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 26, 2021 at 9:32 AM Roberto Bergantinos Corpas
<rbergant@redhat.com> wrote:
>
> On Thu, Aug 26, 2021 at 3:13 PM Eric Sandeen <sandeen@sandeen.net> wrote:
> >
> > On 8/26/21 7:46 AM, Matthew Wilcox wrote:
> > > On Wed, Jul 21, 2021 at 01:30:57PM +0200, Roberto Bergantinos Corpas wrote:
> > >> With addition of fs_context support, options string is parsed
> > >> sequentially, if 'sloppy' option is not leftmost one, we may
> > >> return ENOPARAM to userland if a non-valid option preceeds sloopy
> > >> and mount will fail :
> > >>
> > >> host# mount -o quota,sloppy 172.23.1.225:/share /mnt
> > >> mount.nfs: an incorrect mount option was specified
> > >> host# mount -o sloppy,quota 172.23.1.225:/share /mnt
> > >
> > > It isn't clear to me that this is incorrect behaviour.  Perhaps the user
> > > actually wants the options to the left parsed strictly and the options
> > > to the right parsed sloppily?
> >
> > I don't think mount options have ever been order-dependent, at least not
> > intentionally so, have they?
> >
> > And what matters most here is surely "how did it work before the mount
> > API change?"
> >> And it seems to me that previously, invalid options were noted, and whether the
> > mount would fail was left to the end, depending on whether sloppy was seen
> > anywhere in the mount options string.  This is the old option parsing:
> >
> >          while ((p = strsep(&raw, ",")) != NULL) {
> > ...
> >                  switch (token) {
> > ...
> >                  case Opt_sloppy:
> >                          sloppy = 1;
> >                          dfprintk(MOUNT, "NFS:   relaxing parsing rules\n");
> >                          break;
> > ...
> >                  default:
> >                          invalid_option = 1;
> >                          dfprintk(MOUNT, "NFS:   unrecognized mount option "
> >                                          "'%s'\n", p);
> >                  }
> >          }
> >
> >          if (!sloppy && invalid_option)
> >                  return 0;
>
>  Agree, that's my main point. I think that breaks from previous
> behaviour and indeed causes issues on the field.
> My understanding too is that there's no order-dependency.
>
> roberto
>
Hi Roberto, Eric and David H, this seems to have stalled.  What are
the next steps here?

Roberto, it sounded like David H was suggesting maybe an alternative
approach.  Did you look into that?

Then there was a discussion about whether this change was intended
behavior or not, and the main point made was it was a change in
behavior, which I don't think was intended.  I guess one could make
the argument order was never guaranteed, but then why make behavior
order dependent now if it was not intentional kernel change?  I agree
if possible we should retain the order independent behavior in the
kernel.

