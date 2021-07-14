Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D73C844A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhGNMNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 08:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhGNMNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:13:00 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8F6C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 05:10:08 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id z1so1352620ils.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLA88FGwDHelg/MRWPOHcNy0wg+Widk2W0PnpZpHQLU=;
        b=YynHlgN/kzjHami01EOfxBsYNXc9lUeS75NeGSlpsGKY5/hyzzGt1UoXNOys60Q9mM
         KwIrwIoUAK9IhxUe8Tj1GYM6l9sk/atpsU/0yeWYfPKmhY/V0Ij40oZ7dHl/TuZem/f7
         QiDAVHzMvRKj4JMjEWonUDi1TX46cZJy4JID8ZxWUvGX6ZSplY4RjFD4r82jDUjIeYdR
         naYnUYQySAnS5W2wogVmXvbPOZROruleQWGd403ngsdUPmKa6IzDrAdTXCkrwdCeUj77
         W5nzkuazq0oX/0fu23esvwHdyNa3eohMMNeZp3ExxCTJFRMykZnFmhyicUOKZD7UQSvf
         y29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLA88FGwDHelg/MRWPOHcNy0wg+Widk2W0PnpZpHQLU=;
        b=XWiR9cKK4HBFsvGvwB+8j27TIaecc1sPQU6p+qMP0TkS9vonwRuG79gHP4mMx7eX9j
         DleRCpKBORLIA6ZRL3X0YAygwRoqhcuAFtw0CTUt3/VSyKO/Rol9ao8N0wfIa9M9+Ske
         3BBist4ZrEFOzwLEkuBAvjfriA8EzufieXyUjO3czHAXdw0djbp5IjSltlS0c9FWHYrx
         mSOoQH/dh97rmYCxbWJ4BwsoAKVJwHlyVtIftXj5Sm013HdyMDYg7poH+QFNpFKjoMY9
         AAjacOMdtMxgurhwDd0NXuPDWs2wKQcj22NoJ3HltT8Ry2otOi20hpqxpFw4n337OR66
         gN1Q==
X-Gm-Message-State: AOAM532zaY+Qh4qG7KzdRZLPufNq26h45NXyq2wXQWah17O+53e3kMax
        Odrv1enzIxpWpBOAQaCC2rgZaw53rjdnSoMuKfo=
X-Google-Smtp-Source: ABdhPJw3GcSqRMZtuwNhfPEiBaHNCMSGiJ1kf5AAB5Jbk2ENJX77/1JbJljlKQIqXftH1+jIdd7dv9W8Tpkwetwp+Tw=
X-Received: by 2002:a92:d28b:: with SMTP id p11mr6795871ilp.250.1626264607340;
 Wed, 14 Jul 2021 05:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
 <20210712111016.GC26530@quack2.suse.cz> <CAOQ4uxgnbirvr-KSMQyz-PL+Q_FmBF_OfSmWFEu6B0TYN-w1tg@mail.gmail.com>
 <20210712162623.GA9804@quack2.suse.cz> <CAOQ4uxgHeX3r4eJ=4OgksDnkddPqOs0a8JxP5VDFjEddmRcorA@mail.gmail.com>
 <YO469q9T7h0LBlIT@google.com>
In-Reply-To: <YO469q9T7h0LBlIT@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 14 Jul 2021 15:09:56 +0300
Message-ID: <CAOQ4uxgkMrMiNNA=Y2OKP4XYoiDMMZLZshzyviirmRzwQvjr2w@mail.gmail.com>
Subject: Re: FAN_REPORT_CHILD_FID
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 4:16 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Mon, Jul 12, 2021 at 09:08:18PM +0300, Amir Goldstein wrote:
> > On Mon, Jul 12, 2021 at 7:26 PM Jan Kara <jack@suse.cz> wrote:
> > > On Mon 12-07-21 16:00:54, Amir Goldstein wrote:
> > > Just a brainstorming idea: How about creating new event FAN_RENAME that
> > > would report two DFIDs (if it is cross directory rename)?
> >
> > I like the idea, but it would have to be two DFID_NAME is case of
> > FAN_REPORT_DFID_NAME and also for same parent rename
> > to be consistent.
>
> I don't have much to add to this conversation, but I'm just curious here.
>
> If we do require two separate DFID_NAME record objects in the case of cross
> directory rename operations, how does an event listener distinguish the
> difference between which is which i.e. moved_{from/to}?  To me, this
> implies that the event listener is expected to rely on specific
> supplemental information object ordering, which to my knowledge is a
> contract that we had always wanted to avoid drawing.
>

I think the records should not rely on ordering, but on self describing types,
such as FAN_EVENT_INFO_TYPE_DFID_NAME_{FROM,TO}
but I am trying to think of better names.

I am still debating with myself between adding a new event type
(FAN_RENAME), adding a new report flag (FAN_REPORT_TARGET_FID)
that adds info records to existing MOVE_ events or some combination.

My goal is to minimize the man page size and complexity.

Thanks,
Amir.
