Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E91BE49C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgD2RCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2RCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:02:20 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E68C03C1AE;
        Wed, 29 Apr 2020 10:02:20 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g14so2301814otg.10;
        Wed, 29 Apr 2020 10:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B985L7L6vo4SZsi3kVQu81cacr5257tGI7VdWzNQtbc=;
        b=BK/QhIP5IW+bddXjrA1pREKlRUiMK9Wa2V3gAEYOxqPdactgZ62/420pj3wtm6eJ9C
         HPR7JOusQPaUNxfJLn76e/Ez4DJlPvUL96k7/WY6gVuonnIGWjETrUj0454zoCzL1fN7
         abqxu2Yc4vSx0bHI6Z/xT/1O1JmkgxrfkJDA24awcq1rNzegC4eF5okwaRi6KTNIV3i7
         ocvUXxtnOm7HQSvRRk9zX0o1Exq1do2ynwyZfuts3czTqYt7LnPZ4X7Nz6O0658Dd/Mb
         C5UEr1euzAXRhYIyHUtpUqMikhKiok+A5kBcQ6yiBANBIz0k0sGDoHwAW7Bo/L4Hv/9s
         ws/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B985L7L6vo4SZsi3kVQu81cacr5257tGI7VdWzNQtbc=;
        b=inkfy7OCPiaGIpc9R938d+upfNLf+w6wemAPzOxZ6kJgJgBHs2Rdl7wkQd0x/kdIzu
         Dfi1thccd13q7rcx5K0KVIyuvmlYSHznKJhf3SW2zbY3iUNG923KwTVf/7rQ97bxTTkE
         C/MccqmJ1hZVfdtUOEVoZQnOQrJ+0Nz8T3g3i95yxgGBSHFGfipV2Pyv0GXYpnsfkuc9
         k0R45ZiV0WMMnFwSVnTVtBckNLwgqM94TWgbKyMpEB3yZ3Uv1anxv7gLvpqVAcEcNQDL
         iBwKW8iILk3ENIR5tPHi7KQY4O642FjnvzZfztmLqkoLOq3uIMxEl5DBW3aBb5oTyw3i
         EQtA==
X-Gm-Message-State: AGi0PuYsHpktyjm+3Mia+NmSojV0bRCass/Bt7troYxAaOaugw3H6q99
        0UfAA/AgtxIw3XIKbnuVKkwrLOLjwCxQHwreRGzWfSQGkHY=
X-Google-Smtp-Source: APiQypJbvSlRX+/S2xFHVro3TSK+FAqAJJ9oku9MV9UO98xDHJFqypFdsLNNoZoZ/3TEZBNx8jYUQ6xYULRbhs1VLEc=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr13649191otb.162.1588179740168;
 Wed, 29 Apr 2020 10:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com>
 <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
 <alpine.LRH.2.21.2004230253530.12318@namei.org> <6fcc0093-f154-493e-dc11-359b44ed57ce@schaufler-ca.com>
 <3ffd699d-c2e7-2bc3-eecc-b28457929da9@schaufler-ca.com> <8bef5acd-471e-0288-ad85-72601c3a2234@schaufler-ca.com>
 <CAEjxPJ66ZZKfAUPnUjQiraNJO0h=T3OTY2qTVPuXrWG9va1-2g@mail.gmail.com>
In-Reply-To: <CAEjxPJ66ZZKfAUPnUjQiraNJO0h=T3OTY2qTVPuXrWG9va1-2g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 29 Apr 2020 13:02:09 -0400
Message-ID: <CAEjxPJ4iquFSBfEj+UEFLUFHPsezuQ-Bzv09n+WgOWk38Nyw3w@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Daniel Colascione <dancol@google.com>,
        James Morris <jmorris@namei.org>,
        Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 12:48 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Apr 27, 2020 at 12:19 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 4/23/2020 3:24 PM, Casey Schaufler wrote:
> > > On 4/22/2020 10:12 AM, Casey Schaufler wrote:
> > >> On 4/22/2020 9:55 AM, James Morris wrote:
> > >>> On Mon, 13 Apr 2020, Daniel Colascione wrote:
> > >>>
> > >>>> On Wed, Apr 1, 2020 at 2:39 PM Daniel Colascione <dancol@google.com> wrote:
> > >>>>> Changes from the fourth version of the patch:
> > >>>> Is there anything else that needs to be done before merging this patch series?
> > > Do you have a test case that exercises this feature?
> >
> > I haven't heard anything back. What would cause this code to be executed?
>
> See https://lore.kernel.org/selinux/513f6230-1fb3-dbb5-5f75-53cd02b91b28@tycho.nsa.gov/
> for example.

NB The example cited above needs to be tweaked for changes in the
logic from the original RFC patch on which the example was
based.  In particular, the userfaultfd CIL policy needs to be updated
to define and use the new anon_inode class and to allow create
permission as follows.

$ cat userfaultfd.cil
(class anon_inode ())
(classcommon anon_inode file)
(classorder (unordered anon_inode))
(type uffd_t)
; Label the UFFD with uffd_t; this can be specialized per domain
(typetransition unconfined_t unconfined_t anon_inode "[userfaultfd]"   uffd_t)
(allow unconfined_t uffd_t (anon_inode (create)))
; Permit read() and ioctl() on the UFFD.
; Comment out if you want to test read or basic ioctl enforcement.
(allow unconfined_t uffd_t (anon_inode (read)))
(allow unconfined_t uffd_t (anon_inode (ioctl)))
; Uncomment one of the allowx lines below to test ioctl whitelisting.
; Currently the 1st one is uncommented; comment that out if trying another.
; None
(allowx unconfined_t uffd_t (ioctl anon_inode ((0x00))))
; UFFDIO_API
;(allowx unconfined_t uffd_t (ioctl anon_inode ((0xaa3f))))
