Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F1228C5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 23:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387928AbfEWVev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 17:34:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41570 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbfEWVeu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 17:34:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id d8so5469663lfb.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jsp+xqBh3VOcvBT5H96/8E3FdbJHIyc5xxFW2dfP/m4=;
        b=dF/oF44gx9ScO79G+tsbRedT9Qx7Ab9VCyHwdrwLsKk3zJSxTaQBKRXHQ8Nc2fad2k
         0ejthuD+IVzTB9jnA6YnDhUn4oLApqa8MWbLQeI4oH2boDNSZBn/29NIcA0MO7emST+w
         uSAj0wFFuRSP8TpzfsclarSH7UZAqicwGdbk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jsp+xqBh3VOcvBT5H96/8E3FdbJHIyc5xxFW2dfP/m4=;
        b=WD97hM59wpYfSUThipDH2pxAj0eBfWBX/pi56DnMU3QZf0YA7fplQYS7Sw0029yi7h
         IqCyXEcD9la7LKkA5o9HIx50qphIfFegmczt0EkgRoz+cX0VZLpyaiobsG7GDaOiv8g2
         ugHah8WjqLoQad1cRRIwHRBZ4Bju89CQlZFkASHPwm+jr/J1h4PNvOBC0FjmQd1C05xV
         dEWoUwszJD8OFMr3L7PKe3OR3tgi95Ei9xPjn3RalNQWr72eV6aliG3HmyEanB556U6/
         cStHP7y7QhUzYmbTVqSA3RdVCgvyn7KBHTwLQlSuxDA0klDBWkTm3oQxq+D2ln8gHMNA
         ijUw==
X-Gm-Message-State: APjAAAVg0krJRtYWVwNSG/4E5HMgpSwFyB4Qw4bGJG+YfJM100nxA3mY
        z9jZ0KXgPK7+rUIsRTYWUzq2hHAe+LE=
X-Google-Smtp-Source: APXvYqxj3+1XADFLpTZ4xq70LM5pGPkEYE92SVkXTAQLY5K6CqARNHnPypvLSwAhNz4HnYfHbzrbKA==
X-Received: by 2002:a05:6512:508:: with SMTP id o8mr5961297lfb.119.1558647288725;
        Thu, 23 May 2019 14:34:48 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q23sm140876ljg.35.2019.05.23.14.34.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 14:34:47 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id x132so5503191lfd.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 14:34:47 -0700 (PDT)
X-Received: by 2002:ac2:518e:: with SMTP id u14mr11079489lfi.120.1558647287406;
 Thu, 23 May 2019 14:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190523182152.GA6875@avx2>
In-Reply-To: <20190523182152.GA6875@avx2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 May 2019 14:34:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5YZQ=ox+T1kc4RWp3KP+4VvXzvr8vOBbqcht6cOXufw@mail.gmail.com>
Message-ID: <CAHk-=wj5YZQ=ox+T1kc4RWp3KP+4VvXzvr8vOBbqcht6cOXufw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] close_range()
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 11:22 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> > This is v2 of this patchset.
>
> We've sent fdmap(2) back in the day:

Well, if the main point of the exercise is performance, then fdmap()
is clearly inferior.

Sadly, with all the HW security mitigation, system calls are no longer cheap.

Would there ever be any other reason to traverse unknown open files
than to close them?

                   Linus
