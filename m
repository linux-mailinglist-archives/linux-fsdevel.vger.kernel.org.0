Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B8D1C1D3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 20:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgEASc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 14:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730217AbgEASc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 14:32:56 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5D8C061A0C;
        Fri,  1 May 2020 11:32:56 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id i27so3253974ota.7;
        Fri, 01 May 2020 11:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Qmvh7uhlyOv4U/7qQXX/hfMofRU+8ICG2gVkpg7rmk=;
        b=kZXV9bInoZgJZ6HcAzR1LvYHwm6qz4GdGcfC9CuZU8l1X90m8ZACPZyx9Egtr4dkCL
         rrzq3uMlbI+GWeTbNNsgbHUdVKHuNVCAtQFBUzrJMoL5kbUlrTVwSwl8+sE5s8vguu0F
         VigKCrXGIMYLKYFOWXqZ1VO6O//p8QyXKArUQ/n3dvBMyRekxE4W4BHw0AQ7WRQU6N1s
         bKzqmWtc/ZzVXbQxnY6rkqbw1v/zNmPxhlFmLMYAqA4eNUqAQTFJ3zYpww+au0AVdMSb
         cRivk+oC1QCzQ3ehMajKTypmSk6ULqUaOVAwQFgUfvTAIzCEIXBUCTdIuSHpK1zaLfu3
         rkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Qmvh7uhlyOv4U/7qQXX/hfMofRU+8ICG2gVkpg7rmk=;
        b=JaFIh3iG+7XxvPUBQu3tXJYZAs4rNgM50uxuqhGfQJkMcNXSRGzKhwSavfWpdFYElr
         wCwHJ4/7I6+LAYhl7CmipexWvT2OlwOULE+vdEHXulROGcRHBfKoeecXfUM3t54QfVr3
         A4eoirpi6sRjQREfznXlFTcVrnUAWelX3trA8lzs8brKjGwq+3lTE9SWNatO3QF0H2Tn
         E6WqU4ELBVAqKfGvI1Lz3zE7ugYCRraeORYopRHbMMbxY+7pQRpS3Kclw5DvPtvd4hZM
         OL0LHS3QsANVghm7paP9xf8a8C9sxL2ZRQ52/XNI6U7PE6whsnPJwFJ/vjGgYs8GqIgy
         PTEg==
X-Gm-Message-State: AGi0PubNPoo7d1kYIXLpW8bjnFVVPm6AunUdZkGOGB5kBOYF4RIgicU3
        pFzaFCOXzoXaqdlQNnbMVcz6945GnHp8q8V/Tts=
X-Google-Smtp-Source: APiQypJOFNfYRfkorFkvPPm6K3ku1eNh71oc68jWQ44FcH3mdHql3grbEMaEE5R0nAfi/q55r/8QvDIA3m4Z7j9NL1A=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr4743248otb.162.1588357975980;
 Fri, 01 May 2020 11:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFHJroyC8SAFJZuQxcwHqph5EQRg=MqFdvfnwbK35Cv-A-neA@mail.gmail.com>
 <CAJfpegtWEMd_bCeULG13PACqPq5G5HbwKjMOnCoXyFQViXE0yQ@mail.gmail.com>
In-Reply-To: <CAJfpegtWEMd_bCeULG13PACqPq5G5HbwKjMOnCoXyFQViXE0yQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 1 May 2020 14:32:43 -0400
Message-ID: <CAEjxPJ56JXRr0MWxtekBhfNS7i8hFex2oiwqGYrh=m1cH9X4kg@mail.gmail.com>
Subject: Re: fuse doesn't use security_inode_init_security?
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chirantan Ekbote <chirantan@chromium.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        LSM <linux-security-module@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 1, 2020 at 3:54 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, May 1, 2020 at 8:55 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
> >
> > Hello,
> >
> > I noticed that the fuse module doesn't currently call
> > security_inode_init_security and I was wondering if there is a
> > specific reason for that.  I found a patch from 2013[1] that would
> > change fuse so that it would call that function but it doesn't appear
> > that the patch was merged.
> >
> > For background: I currently have a virtio-fs server with a guest VM
> > that wants to use selinux.  I was able to enable selinux support
> > without much issue by adding
> >
> >     fs_use_xattr virtiofs u:object_r:labeledfs:s0;
> >
> > to the selinux policy in the guest.  This works for the most part
> > except that `setfscreatecon` doesn't appear to work.  From what I can
> > tell, this ends up writing to `/proc/[pid]/attr/fscreate` and the
> > attributes actually get set via the `inode_init_security` lsm hook in
> > selinux.  However, since fuse doesn't call
> > `security_inode_init_security` the hook never runs so the
> > file/directory doesn't have the right attributes.
> >
> > Is it safe to just call `security_inode_init_security` whenever fuse
> > creates a new inode?  How does this affect non-virtiofs fuse servers?
>
> Not sure,  Adding more Cc's.
>
> I know there's a deadlock scenario with getxattr called on root inode
> before mount returns, which causes a deadlock unless mount is run in
> the background.  Current libfuse doesn't handle this, but I think some
> fuse fs work around this by not using libfuse, or at least have some
> special setup code (glusterfs? ceph-fuse? not sure...).  I also don't
> know whether the ->inode_init_security hook is related to this or not.

(cc selinux list)

security_inode_init_security() calls the initxattrs callback to
actually set each xattr in the backing store (if any), so unless you
have a way to pass that to the daemon along with the create request
the attribute won't be persisted with the file.  Setting the xattrs is
supposed to be atomic with the file creation, not a separate
setxattr() operation after creating the file, similar to ACL
inheritance on new files.

Also possibly related
https://lore.kernel.org/selinux/6df9b58c-fe9b-28f3-c151-f77aa6dd67e7@tycho.nsa.gov/.
