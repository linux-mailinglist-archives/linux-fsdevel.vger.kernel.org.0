Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5BE7115AE1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 04:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfLGDu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 22:50:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42208 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLGDu3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 22:50:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id e28so9748266ljo.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 19:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=HEWM2qIddnPGufw5AQ6kyl6Y/Tjfdse09Yspvk/3RCI=;
        b=he2M8AdxCQFydLibVKShqyzikO8W2EI8NOK9ISS7ou9cfn0OpWBilIcQsB6NDgoNoq
         HKWi3kUP6tC/54/dKSqhFCoBdWpmni/VDi171bSieu2XDq+IZyrEDQTduR8PFfHiVvxK
         Esk5z6f8gqcxysY+UedwEvpN8S4uaS6yqV5Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HEWM2qIddnPGufw5AQ6kyl6Y/Tjfdse09Yspvk/3RCI=;
        b=SU3qAgdWHdHWhjoC+09ULMahW4dctBFjoF5Vu2zNYUQWi9iunNUcbgPCDnd25kaCIl
         Nwux4RIdGxsWa9P9yy381w84BQ4wrqEKKn2mRl52qfXJAu1mLGdVZkhUJY2ZAAwJ/hMd
         FSfwZOc/Pvv9hzdKnX8vtX03M8499d+9f+NwKNR/4yeYoKVUzn7eFIzQacYVAZi2oQJ+
         JtgqxgcwXZcAosper30q9yZKCE7HjCf3F2YWRlKyyIV3Z7+8XX5VSOya4XrR1l6HKEKU
         aCS+swQzTKuxlvARkMJ27AvWIMXzGimOc11wWeBBvxPyuwmuJSorHkALIJPSUWwdmjv9
         rf0A==
X-Gm-Message-State: APjAAAXM/FY99/rrmHXYI8KdGcUMRNStGAUvL36mi/Vj4zsh69CSvQU9
        n4mUOo+V7730dF8N+G8QEw98C33rbcQ=
X-Google-Smtp-Source: APXvYqxZ/GvatGtR1BSVFj1Z60VHRCAhASRqUOY/k37tF6nV52j6U7x2+ADHZ4QBYZh+dPU7aAYB0w==
X-Received: by 2002:a2e:7e05:: with SMTP id z5mr1583799ljc.71.1575690626728;
        Fri, 06 Dec 2019 19:50:26 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id b22sm7700745lji.66.2019.12.06.19.50.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 19:50:25 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id c19so9721141lji.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 19:50:24 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr7759167ljj.148.1575690624637;
 Fri, 06 Dec 2019 19:50:24 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
In-Reply-To: <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 19:50:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
Message-ID: <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 6, 2019 at 1:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It doesn't fix my "kernel compiles go single-threaded" issue.

I ended up just bisecting it.

The "make goes slow" problem bisects down to b667b8673443 ("pipe:
Advance tail pointer inside of wait spinlock in pipe_read()").

I assume it's the added "do_wakeup = 0" (not the spinlock) that ends
up having some subtle issue.

Very strange, but there it is.

               Linus
