Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0581AB32B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 09:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391722AbfIFH20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 03:28:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39314 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390788AbfIFH2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:28:25 -0400
Received: by mail-io1-f67.google.com with SMTP id d25so10607346iob.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPV93q9yLYIKpn8nh2t+hGtrutkW9tKqXiA9UxMOKvI=;
        b=Rb5hjLH97fWG9p+/yNu96w9UO3OKt4FmFKmAw11vyG2iZI06iEgcHhxGgyg28O20Kr
         Rbghe6XoI+sRXgV7YJBO/FPPQUesLs1FXAB+/9VWM553hR2QYn3uxlrlNjd/AL+/+wtr
         kfQn6PC4J6PQJUOSyYUVi8f0h31wY1hhPDB7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPV93q9yLYIKpn8nh2t+hGtrutkW9tKqXiA9UxMOKvI=;
        b=SGLrkcrXxriJitHJSQyr+vc/GVaulBV2UHy0fZXM1lSmJZ9kboa+5uKORDlKxbkdy1
         vHH+XEQT2F30SuINnsNX7Hwq8Mmw3e0d9htc7H+500HRsi0Uik2R69VD153aP/a/iwIS
         g/o9PMBTQVwrGY1/AtYfShHkpVM2gcJwxAqJf5t9nek2+BOcprUtWOpJTOy2+Yq/xlYv
         ex5LomnGfucBqZBgHNf0Kp9xZyqe50fc3CbqY01wsJONY+QOwke5CKsO09/gVX2Im2VQ
         KW4jmwuJtnYOV2sKflXH8LQZJEB2rWvct31r9U8h3FrDima2ri5uc0c0tm+9C+7yk425
         mVeg==
X-Gm-Message-State: APjAAAVBYYV6Vln/859ONtNiQIeNq+xQ1ofF0VZAI+RmNr9kwEbmiI4L
        F13KVItCzBVi663VNsXQxrm/BVWWYpQmSy7N3ccAwA==
X-Google-Smtp-Source: APXvYqxR3pH944s5Ok7PV+C2BDLvozfEi9oSPmHQa7sH6FfFjXkuExp6qDUMbbUZDXntpKIoHTPtClMWSvVQofi6VEw=
X-Received: by 2002:a6b:5d18:: with SMTP id r24mr8826984iob.285.1567754905146;
 Fri, 06 Sep 2019 00:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190619123019.30032-1-mszeredi@redhat.com> <CAJfpegv_ezsXOLV2f7yd07=T3MenJoMKhu=MBac1-80s0BFg9A@mail.gmail.com>
 <11485.1562257188@warthog.procyon.org.uk>
In-Reply-To: <11485.1562257188@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Sep 2019 09:28:14 +0200
Message-ID: <CAJfpegutbB+kb8oOx5zHx38vGE90H=JdgkM-7bVE3wxypmfAuw@mail.gmail.com>
Subject: Re: [PATCH 01/13] vfs: verify param type in vfs_parse_sb_flag()
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 4, 2019 at 6:20 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Ping?  Have you had a chance of looking at this series?
>
> Yeah, through due to time pressure, I haven't managed to do much with it.
>
> I don't agree with all your changes, and also I'd like them to wait till after
> the branch of mount API filesystem conversions that I've given to Al has had a
> chance to hopefully go in in this merge window, along with whatever changes Al
> has made to it.

Ping?

Thanks,
Miklos
