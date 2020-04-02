Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E155219C5B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbgDBPXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 11:23:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34637 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388902AbgDBPXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:23:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id o1so4713232edv.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=la1b5Ou2yNh3JsPWbozq9MDt4G+rB5yxkaRSc5pmaiE=;
        b=FbW3d2twbyZ4mtllP3ntlUwxpeUqJ3cuXzhPgbLcRcK7DgxF7GpM/NG2cj6b7bK0kv
         3rYtfI2OchTF6M89+enP7/L2/EO9odtTm15fD4/NU/I3XjwErPdx8RT8ALiIAMU0fCzQ
         thuf5FLYNjQ8Q3+JNQTciGito3W6QCOmhhYBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=la1b5Ou2yNh3JsPWbozq9MDt4G+rB5yxkaRSc5pmaiE=;
        b=N8AkPcpxJDZ4WaXZ5wycAiUdv7GLKLxmzNAJOj29unAcRng0ccZjiuOF/jMyPBgFh7
         JJ/JPwi7uIVcnzGcmtN8uW/21Nf1wtgJogEzMehkqYIQBbbH6mMAB1n2qKGoPlR9PBW3
         yi39K/N9vf9ps/wTAyz6AsCon6GLUKGUP0XiXfmOFYybOTc+RsC5e+LANgZrHMF5nclR
         rbk7bGzOOcKmbh086XIhDoTABb05HPesVLsVw1/bZyDet0gW/wz3O9y4ntDjySmAAvWo
         t37gSNXYb20aV1e6aMxWfX5Uc1rOL6vzJsOQQf+ZBHVJxrYD97ApNAzu+MW9VxB8V0f8
         Ns7Q==
X-Gm-Message-State: AGi0PuaUlPvM/nFbO6J7XaTYAfbRoLcY/BxIl5OV8OvGqlKVXamnz/Sl
        tkE3j3MAgI0tWrYJ3rAfw6t3lhw+BWm9BlXvfvNm8A==
X-Google-Smtp-Source: APiQypICMqPIQd16vetsb2LQJpT3V/kbuhYk03Sj4n2WAAPFiFyV6LvcYLcfWOgYg1ssSkWsh9LfQGG1LiHAXWy3bE4=
X-Received: by 2002:a50:c341:: with SMTP id q1mr3533190edb.247.1585840980469;
 Thu, 02 Apr 2020 08:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login>
 <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com> <20200402143623.GB31529@gardel-login>
In-Reply-To: <20200402143623.GB31529@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 2 Apr 2020 17:22:49 +0200
Message-ID: <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 2, 2020 at 4:36 PM Lennart Poettering <mzxreary@0pointer.de> wrote:

> You appear to be thinking about the "udisks" project or so?

Probably.

The real question is: is there a sane way to filter mount
notifications so that systemd receives only those which it is
interested in, rather than the tens of thousands that for example
autofs is managing and has nothing to do with systemd?

Is there a specific mountpoint or mountpoints that systemd is waiting
for?   How exactly does this work?

Thanks,
Miklos
