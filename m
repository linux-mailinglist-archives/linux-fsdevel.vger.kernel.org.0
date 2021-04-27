Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB9536BEC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 07:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhD0FPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 01:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhD0FPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 01:15:00 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88052C061574;
        Mon, 26 Apr 2021 22:14:17 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z14so5918634ioc.12;
        Mon, 26 Apr 2021 22:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87Lm91kN/3Qbc2jjLMsMI7GIKlbTexNd8/+SAT00H2M=;
        b=alq2icoG6JRXKNkjZau2ZOITg5AincB13ZN4k3TejPqBcfJvRUlW8iaYqLX2ixF6x2
         9uTDOr/oua4Njt5nKLETIUj1xg4qt/l0l0Bvj+vXRz7m77gmuKNCydGDrEDpiPoPr2EU
         I7h31bkDZpKYMY0JfuGZUl8je9BUQrE0zlo3dpPLFzbgWObzODFq16u5MVx8ErW5FE17
         9FtYE5k5mnVv2bqMfrOSj+mShxO60Z9beg1mvQ6YD3JUa3ZWar96k+Kvo1GYH4DOjBst
         z9YKNf6Sw7wo5cR018aFpf7LHYLb/jMyo+ho2eXxDK8vhLAnjaIjmbYEiXNp/MNsQshQ
         0KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87Lm91kN/3Qbc2jjLMsMI7GIKlbTexNd8/+SAT00H2M=;
        b=J9W2eGwSD5oYIWPbQ2UqETh0GCACa5R76FeAE8dgQ57M3rBA2MZ07iMQqsHNoOjCu/
         wfSl/qYqTd48bnPAmbgAg6NRmfaAJ7oKcwaKg/tKO1ykEIpQzjPzjqJfC7c2/6qmh8hD
         z/pPbeJn0YpnPWG7dQqEpmC28FFhv673zXHL8ux+nMl8SkLnVFjOt3AOSjaGvppZ1K3p
         Wk+9VWxdJ9tWHZPBPnOCQXA6cha51R7nKaKccMKwG1NqWURI70De0L6vCpRGI40oFX87
         N7ZvmBg+ZmFhF1DEzDyqzfoe2plAXWEnB3ylShDmjGamRJr9p/3YliR2cRCGnKoW3IZ3
         yEAQ==
X-Gm-Message-State: AOAM533UnTqMYdtZeGt2bMA9+KQwNQe0lZBWUp07TG+UONQoQEbLhGP1
        95VfX0cGngvAnMezivDW3iWBOhQ642ztPmNsuvI=
X-Google-Smtp-Source: ABdhPJxMFt7k/ovMax4BVSg5a4SRjixVISvQhtFJuY3RKmheXQtXllKdwKPz79rgrcETa+Gk4oO/Tahb2ZDCG2jGsao=
X-Received: by 2002:a6b:f00f:: with SMTP id w15mr17384051ioc.72.1619500457018;
 Mon, 26 Apr 2021 22:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210419135550.GH8706@quack2.suse.cz> <20210419150233.rgozm4cdbasskatk@wittgenstein>
 <YH4+Swki++PHIwpY@google.com> <20210421080449.GK8706@quack2.suse.cz>
 <YIIBheuHHCJeY6wJ@google.com> <CAOQ4uxhUcefbu+5pLKfx7b-kOPP2OB+_RRPMPDX1vLk36xkZnQ@mail.gmail.com>
 <YIJ/JHdaPv2oD+Jd@google.com> <CAOQ4uxhyGKSM3LFKRtgNe+HmkUJRCFwafXdgC_8ysg7Bs43rWg@mail.gmail.com>
 <YIaVbWu8up3RY7gf@google.com> <CAOQ4uxhp3khQ9Ln2g9s5WLEsb-Cv2vdsZTuYUgQx-DW6GR1RmQ@mail.gmail.com>
 <YIeGefkB+cHMsDse@google.com>
In-Reply-To: <YIeGefkB+cHMsDse@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 08:14:05 +0300
Message-ID: <CAOQ4uxjAqh3xVpigrJe1k01Fy5-rJRxxLGw92BwWtU4zjr=Wjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 6:35 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Mon, Apr 26, 2021 at 02:11:30PM +0300, Amir Goldstein wrote:
> > > Amir, I was just thinking about this a little over the weekend and I
> > > don't think we discussed how to handle the FAN_REPORT_PIDFD |
> > > FAN_REPORT_FID and friends case? My immediate thought is to make
> > > FAN_REPORT_PIDFD mutually exclusive with FAN_REPORT_FID and friends,
> > > but then again receiving a pidfd along with FID events may be also
> > > useful for some? What are your thoughts on this? If we don't go ahead
> > > with mutual exclusion, then this multiple event types alongside struct
> > > fanotify_event_metadata starts getting a little clunky, don't you
> > > think?
> > >
> >
> > The current format of an fanotify event already supports multiple info records:
> >
> > [fanotify_event_metadata]
> > [[fanotify_event_info_header][event record #1]]
> > [[fanotify_event_info_header][event record #2]]...
> >
> > (meta)->event_len is the total event length including all info records.
> >
> > For example, FAN_REPORT_FID | FAN_REPORT_DFID_MAME produces
> > (for some events) two info records, one FAN_EVENT_INFO_TYPE_FID
> > record and one FAN_EVENT_INFO_TYPE_DFID_NAME record.
>
> Ah, that's right! I now remember reviewing some patches associated
> with the FID change series which mentioned the possibility of
> receiving multiple FID info records. As the implementation currently
> stands, AFAIK there's not possibility for fanotify to ever return more
> than two info records, right?
>

Right.
Record types FAN_EVENT_INFO_TYPE_DFID_NAME and
FAN_EVENT_INFO_TYPE_DFID are mutually exclusive.

> > So I see no problem with combination of FAN_REPORT_FID
> > and FAN_REPORT_PIDFD.
>
> OK.
>
> Is there any preference in terms of whether the new FAN_REPORT_PIDFD
> info records precede or come after FAN_REPORT_FID/FAN_REPORT_DFID_NAME
> info records in FAN_REPORT_FID or FAN_REPORT_FID |
> FAN_REPORT_DFID_NAME configurations?
>

Doesn't matter.
Your typical application would first filter by pid/pidfd and only if process
matches the filters would it care to examine the event fid info, correct?
So you go first :)

Thanks,
Amir.
