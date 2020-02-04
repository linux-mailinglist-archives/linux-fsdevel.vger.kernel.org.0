Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD7152383
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 00:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBDXuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 18:50:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46164 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgBDXuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:50:03 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so361993edi.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2020 15:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tSlSCku20FStpOcQykOPLBXpgF1lEZfJUZ3xezTMXUk=;
        b=AqM0nw1eNjCw1+k0Q8gPthLOiplhEcyUDU1L86hW5DIcXaKozOr4BXTLWPs0JHGhhF
         alVySvV9VMo6EtoIdVq0nb41lFaCoZgWXwhoq+I/tYIJY/N3OL1zIZtahG1+9xv6fB6w
         raQiSGMOHrtUYsg9QkqlUDluzMpH7EkTmyzV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSlSCku20FStpOcQykOPLBXpgF1lEZfJUZ3xezTMXUk=;
        b=aJDjCq+93vDUm7g9VRMy8AWY/gwltdwdDHdTC9VpM1jhL5axJYsEIVQyHwDoDfVt/g
         QjUdml4uI1BRz40xljcH2OH5LNw2IGnEJwW5RvZsPDAZcSTQx7R80eJGZBrC6idnOTzM
         Cp5actXvM3XWOa9oUCvIOfHrMwll6YwJNhiNVgmoPf/dNCgENNSH5E4d8jraJTLsOi5K
         OFz2uurEPAfzSKgf+4jhZL3vYzx2zTNDquk+LUrZCuD4L2dSkQP93Dio/CdfUSJXCUE9
         uDX9Jv2TRbVZmrGWfm8pS9FVFF6etSW9PBkPRqyRwbjsNCkJRFxKvVjoUByOcxH5v9wE
         KQng==
X-Gm-Message-State: APjAAAX97nPCW3sH474EFDxUiHzLdmDKV6m7Gmfj1cjCCIUGuKOrWtYc
        xCL0v1Fp1+SAnhxBhBrJ06GyKW1y00o=
X-Google-Smtp-Source: APXvYqxm4w7xgofRsgXrePC53ebdzGle7DHrb8Ef8emt1mgJf/mU9fhxfqqxCVq5YuFcOAOewfCwLw==
X-Received: by 2002:a05:6402:38c:: with SMTP id o12mr2596004edv.273.1580860201471;
        Tue, 04 Feb 2020 15:50:01 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id p6sm1467130eja.63.2020.02.04.15.50.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 15:50:00 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id p23so405120edr.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2020 15:50:00 -0800 (PST)
X-Received: by 2002:a17:906:dbd5:: with SMTP id yc21mr3824734ejb.35.1580860199474;
 Tue, 04 Feb 2020 15:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20200204215014.257377-1-zwisler@google.com> <CAHQZ30BgsCodGofui2kLwtpgzmpqcDnaWpS4hYf7Z+mGgwxWQw@mail.gmail.com>
 <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
In-Reply-To: <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Tue, 4 Feb 2020 16:49:48 -0700
X-Gmail-Original-Message-ID: <CAGRrVHyzX4zOpO2nniv42BHOCbyCdPV9U7GE3FVhjzeFonb0bQ@mail.gmail.com>
Message-ID: <CAGRrVHyzX4zOpO2nniv42BHOCbyCdPV9U7GE3FVhjzeFonb0bQ@mail.gmail.com>
Subject: Re: [PATCH v5] Add a "nosymfollow" mount option.
To:     Raul Rangel <rrangel@google.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 4, 2020 at 3:11 PM Ross Zwisler <zwisler@chromium.org> wrote:
> On Tue, Feb 4, 2020 at 2:53 PM Raul Rangel <rrangel@google.com> wrote:
> > > --- a/include/uapi/linux/mount.h
> > > +++ b/include/uapi/linux/mount.h
> > > @@ -34,6 +34,7 @@
> > >  #define MS_I_VERSION   (1<<23) /* Update inode I_version field */
> > >  #define MS_STRICTATIME (1<<24) /* Always perform atime updates */
> > >  #define MS_LAZYTIME    (1<<25) /* Update the on-disk [acm]times lazily */
> > > +#define MS_NOSYMFOLLOW (1<<26) /* Do not follow symlinks */
> > Doesn't this conflict with MS_SUBMOUNT below?
> > >
> > >  /* These sb flags are internal to the kernel */
> > >  #define MS_SUBMOUNT     (1<<26)
>
> Yep.  Thanks for the catch, v6 on it's way.

It actually looks like most of the flags which are internal to the
kernel are actually unused (MS_SUBMOUNT, MS_NOREMOTELOCK, MS_NOSEC,
MS_BORN and MS_ACTIVE).  Several are unused completely, and the rest
are just part of the AA_MS_IGNORE_MASK which masks them off in the
apparmor LSM, but I'm pretty sure they couldn't have been set anyway.

I'll just take over (1<<26) for MS_NOSYMFOLLOW, and remove the rest in
a second patch.

If someone thinks these flags are actually used by something and I'm
just missing it, please let me know.
