Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522F6242AAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 15:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgHLNzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 09:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgHLNzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:55:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7391AC061383
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 06:55:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jp10so2382992ejb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZcIucU/ldxd0dbDYM4XtjXVSKv642KUcN/yZSDiGto=;
        b=XRtuwHdxJqOzPIFxerMkyp8hhNxNJMsP2AwEx7trHlV+heDqTH77rrr6fEaAGI5sq8
         gvZQXMiSqqMWj9SIJNysFAtJVN2JUflQ+Ggha4iGRaHB9eBRRtdYycXaP1afY2gc/1Gi
         blQ5bCn2ECUSS5OJ+iE2oN8giTALSTWteYRUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZcIucU/ldxd0dbDYM4XtjXVSKv642KUcN/yZSDiGto=;
        b=QfopM9ZN2x725I6QNFEhxm9EY3kbpHhzBqwy3Jj9KX1hxrPqacn57JUFQtkeH7vLMs
         SFY+sOMiaIqXT7R4H1wveYE+r9OoZ3Fe0YXWdYPVtS7Abex/HFLokD5lUNNJ6CzxfVUV
         2qrT6/M2ZCPnbCOc0zI2Y6b8tFkv/6ofMW5PPlDdf9hpUETaltC6rjvWmujoLCVR8jAB
         TV1WLNUi+HTG9sPvkq2oeBmK8oOxJyQFnP1NiM/aoNpEHP3Q3Fj1m/SQZDcaY+JARqnz
         aZep48/CpqjL6UqBC4lnu42AhE3vzKYNLl91s0q6WmmeSu1VbXvKeeU08vWxA63hTTMK
         DthQ==
X-Gm-Message-State: AOAM532U8qSe2KjDr6WjP7vZM5qiUacIhuQ6GYso8SsISwYW7vg50204
        ULVnbiiL8XquxT9QMZfWjJ81TEVBFWWDPhX2Ku/BLg==
X-Google-Smtp-Source: ABdhPJzUNNYA8k0uex8jfqOZllA0O05gwHDjFPq3AxWJVK67L46SkPySElUc7Ev1MgfSUw2yHyZXngaRqwl8Tu3X5vM=
X-Received: by 2002:a17:907:405f:: with SMTP id ns23mr30169147ejb.511.1597240501997;
 Wed, 12 Aug 2020 06:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <20200812101405.brquf7xxt2q22dd3@ws.net.home> <CAJfpegs4gzvJMBz=su8KgXXxX41tv8tVhO88Eap9pDeHRaSDPA@mail.gmail.com>
 <133508.1597239193@warthog.procyon.org.uk>
In-Reply-To: <133508.1597239193@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 15:54:50 +0200
Message-ID: <CAJfpegv9pCXoAeGzq6KBH-R1q9OODqJMFpNfKryLPN-oNygjJw@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     David Howells <dhowells@redhat.com>
Cc:     Karel Zak <kzak@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 3:33 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > You said yourself, that what's really needed is e.g. consistent
> > snapshot of a complete mount tree topology.  And to get the complete
> > topology FSINFO_ATTR_MOUNT_TOPOLOGY and FSINFO_ATTR_MOUNT_CHILDREN are
> > needed for *each* individual mount.
>
> That's not entirely true.
>
> FSINFO_ATTR_MOUNT_ALL can be used instead of FSINFO_ATTR_MOUNT_CHILDREN if you
> want to scan an entire subtree in one go.  It returns the same record type.
>
> The result from ALL/CHILDREN includes sufficient information to build the
> tree.  That only requires the parent ID.  All the rest of the information
> TOPOLOGY exposes is to do with propagation.
>
> Now, granted, I didn't include all of the topology info in the records
> returned by ALL/CHILDREN because I don't expect it to change very often.  But
> you can check the event counter supplied with each record to see if it might
> have changed - and then call TOPOLOGY on the ones that changed.

IDGI, you have all these interfaces but how will they be used?

E.g. one wants to build a consistent topology together with
propagation and attributes.   That would start with
FSINFO_ATTR_MOUNT_ALL, then iterate the given mounts calling
FSINFO_ATTR_MOUNT_INFO and FSINFO_ATTR_MOUNT_TOPOLOGY for each.  Then
when done, check the subtree notification counter with
FSINFO_ATTR_MOUNT_INFO on the top one  to see if anything has changed
in the meantime.  If it has, the whole process needs to be restarted
to see which has been changed (unless notification is also enabled).
How does the atomicity of FSINFO_ATTR_MOUNT_ALL help with that?  The
same could be done with just FSINFO_ATTR_MOUNT_CHILDREN.

And more importantly does level of consistency matter at all?  There's
no such thing for directory trees, why are mount trees different in
this respect?

> Text interfaces are also a PITA, especially when you may get multiple pieces
> of information returned in one buffer and especially when you throw in
> character escaping.  Of course, we can do it - and we do do it all over - but
> that doesn't make it efficient.

Agreed.  The format of text interfaces matters very much.

Thanks,
Miklos
