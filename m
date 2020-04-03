Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC5D19D653
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403845AbgDCMFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 08:05:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46284 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgDCMFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:05:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id j17so8138330wru.13;
        Fri, 03 Apr 2020 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xz6spXtxxXdjkDuCcyDHWPj+MoNvcOatFi0zEd+zC0=;
        b=rdInxIDZH8FzPi57P97yKIhOoXuVFtuqAb8PKguS0X1qKjdDr+qAG1PciOTqJxQ+Tz
         A1MNbOjSq9u4pwN8w48hwIekA1PRVNzQO89nb4KNL39ZCJuej1UqfsMDjD5y+ggmyzTp
         KJF+A4u7bkEHfF3LQfoBWGAWTXKDlIPfcOCIYFlrmHXlOIW8IH2vsfTUEgWF+nkbryXv
         7t202s3pRaNZYm4ztPHeWsr0WTKU6Q5d2S+X5/XdOwzus9exF5ESNN3iON9qPDLw1aZa
         62YsUsMcEK0cSyGHOTK9YctN8wFcucj7R7UhZsTzTEFDui8HJS++bY2vT6GxCvfIG/eN
         +i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xz6spXtxxXdjkDuCcyDHWPj+MoNvcOatFi0zEd+zC0=;
        b=YxhBOqKhxqQsrvXN0k0pZKLJhdyLlMs5C4wRKqU4/lFXDzpKZLmpcmtZQe5LqD/g/W
         PkSW4a1JCnOmojpTeSNreIu4QRNAQ/9fevMJCdcO59pzv3hwcZZhydEgyFDmYNd0SfzZ
         YCM+K1cXsMupvcr2UfsmTc311Gk0gLqh24eP+cN+lpxD5Txuh0X0WCzxYQ2HS1pH3VLh
         yfQFPbdIWtON6sImRbLr41oUPdryQzkxAjNKDe6/4X5Oizf+3BHj5pkb7AoZpuL5Ca7v
         TrBb6fnUMgICT71NJmQIHSFrVkHpeWHbx16nIt+P0HSlskagbXjKtZJa4gd/RwPpdRfN
         xNAQ==
X-Gm-Message-State: AGi0PuYHDaKQ3fc6aPTEvZQXIhtYiWEtfLx/PKpAXyaDWVwPv1HdD1gp
        dybAPWSDxoyhim3PnlMHHE9xYA7G4vljjiTAS8fEJg==
X-Google-Smtp-Source: APiQypIqpFog1SlT/1VxZRLlaqx3z/hXF8ftyyW8oHGJcs3nkJA+LhjrDFx9PCVCWiy2bIGtL8+B7rPXnsKStdrC7H0=
X-Received: by 2002:adf:a482:: with SMTP id g2mr3495010wrb.214.1585915535427;
 Fri, 03 Apr 2020 05:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login>
 <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login> <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
In-Reply-To: <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 3 Apr 2020 14:05:23 +0200
Message-ID: <CAFLxGvyegY-p6MWCBZADRYjrxH17P+EEajupYYojqRkfkoNM3w@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 3, 2020 at 1:40 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, Apr 3, 2020 at 1:11 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
> >
> > On Fr, 03.04.20 09:44, Ian Kent (raven@themaw.net) wrote:
> >
> > > > Currently the only way to find the mount id from a path is by parsing
> > > > /proc/self/fdinfo/$fd.  It is trivial, however, to extend statx(2) to
> > > > return it directly from a path.   Also the mount notification queue
> > > > that David implemented contains the mount ID of the changed mount.
> >
> > I would love to have the mount ID exposed via statx().
>
> Here's a patch.

I was looking more than once for a nice way to get the mount id.
Having it exposed via statx() would be great!

-- 
Thanks,
//richard
