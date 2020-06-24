Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A2206950
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 03:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbgFXBDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 21:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387677AbgFXBDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:03:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C0CC061573
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2020 18:03:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t21so198798edr.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2020 18:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eo5cTIL37FpYiHosBDpvR4kZAwB7mWQXF34HqE6NXHo=;
        b=KYVTXVXkCqMbcVuFTDEDKDF/vl50d6y6AVcDR3VWHAdVtg0rVF+rufFQ1wEqaxVJxh
         SIb5YPrtFiiuP3U/USOvpvsCngwFcKcauttqEoZunWAugH4tljXQUnJSNiIjDNlSZE/Y
         8vINYeh9lbMfW+YemTuHtIAKi4Sl9PXz4gZiOGRJUuGUwoyGoQmUiLV5cCSbIz4EaasJ
         92s42xO9NEEqZm68/Q83e/Ak5uUYC6GXyyuUfu/VrtqYiplckhU03c0Vgvov8YbQnCav
         /XiD58yFRrnMH13HCsgJrnDk0K6+OaiL+fWCrT5lEA0dPZE6YPGCpL2dE8+4ZxvV249D
         1a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eo5cTIL37FpYiHosBDpvR4kZAwB7mWQXF34HqE6NXHo=;
        b=WPRETzh+g0sJYrk/FdSJTouBK6eJv5F1pOFXrLO2wr7C2GmsKOagqFlH9w9dQvhHG5
         mM9U1gWY1JyiAa4WrZXCE0l4+dBpIgUmEC9dAHU5m3g2rfXpdgUzpzJJZAzgEl0U4Icq
         AyBeVxyz0i/u0elpMW1oYA5JSnd2mDkvxXL00gFyO5KpyXf9BsVkwd0ZGbmoRArDIX20
         7SDbkIoLJhsYLpGxksKOm6B6DKETFXpopbVHCp9SbiPa46b7QDSRribnryjimkEYWkaT
         KFnTDZOqCAy/5tGEO8zDQHk1+B/bNI5kcE6rCHqWwKi0nblnvsL4uTftiwHE1nk5II0E
         hqNQ==
X-Gm-Message-State: AOAM5330s2nZClAEQokfaOACstha28Ew8oZwDet4G0QWWXPWdFHQYsnS
        bpksOYTrF3BgjICgqg8s5LZAdqp3NLndfmcwiwU6Teb7
X-Google-Smtp-Source: ABdhPJwgEGyrPH+KoGgpyagYhDQWzp/X9Fcbf8BzrxMJ5Voz+JAHTmCCV7B6TldsquEEpVkTerwdy9arRqf3hvl6HiY=
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr9688647edj.93.1592960627165;
 Tue, 23 Jun 2020 18:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
 <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com> <3015561.1592960116@warthog.procyon.org.uk>
In-Reply-To: <3015561.1592960116@warthog.procyon.org.uk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Jun 2020 18:03:36 -0700
Message-ID: <CAPcyv4gdB6iOD8N0KAHY9WybpJtRx3EfEQCSM1zuTDkURrfuug@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To:     David Howells <dhowells@redhat.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "raven@themaw.net" <raven@themaw.net>,
        "kzak@redhat.com" <kzak@redhat.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dray@redhat.com" <dray@redhat.com>,
        "swhiteho@redhat.com" <swhiteho@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "jlayton@redhat.com" <jlayton@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "andres@anarazel.de" <andres@anarazel.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 5:55 PM David Howells <dhowells@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > > This commit:
> > >
> > > >       keys: Make the KEY_NEED_* perms an enum rather than a mask
> > >
> > > ...upstream as:
> > >
> > >     8c0637e950d6 keys: Make the KEY_NEED_* perms an enum rather than a mask
> > >
> > > ...triggers a regression in the libnvdimm unit test that exercises the
> > > encrypted keys used to store nvdimm passphrases. It results in the
> > > below warning.
> >
> > This regression is still present in tip of tree. David, have you had a
> > chance to take a look?
>
> nvdimm_lookup_user_key() needs to indicate to lookup_user_key() what it wants
> the key for so that the appropriate security checks can take place in SELinux
> and Smack.  Note that I have a patch in the works that changes this still
> further.
>
> Does setting the third argument of lookup_user_key() to KEY_NEED_SEARCH work
> for you?

It does, thanks.

Shall I wait for your further reworks to fix this for v5.8, or is that
v5.9 material?
