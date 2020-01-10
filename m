Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D511365C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 04:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgAJDTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 22:19:41 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:39882 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbgAJDTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 22:19:40 -0500
Received: by mail-qv1-f47.google.com with SMTP id y8so166776qvk.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 19:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFfGhG9FXYFUnx3j3LlD5tdXXW7QcBTE9Rh6RB9Fn9A=;
        b=rF/TJsn0WhwuZCLQvzJIm3JYucQcKiHDGzlIdnHPmN1I/5qqBn24qTpjI8IyaIXF3c
         DxRhgs5oO99VZb4gTMZ+7uaJbe1RRlMPU+zH7LinK+i0UojQyodvEa848WxnFtnzm0e2
         +nqWVSgcMentYXW0uQqXFQxJWwOsZ4UFEd8HNRfl/PTr95PHy3ZW9iM8/a3rWnJFz3eQ
         YLXzW5fwz1sY2Vupbe/AFoAI3mNtX8Mm6oapbGSrue+msdHN5XcAqU4TotSgHkBk4lmc
         5PGfz3DgX/+7ruQJ1YWalingDRWuNjUxWfEzFTt/HXJQoMvmGiedVnELa2QBXj8eb3Iw
         l5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFfGhG9FXYFUnx3j3LlD5tdXXW7QcBTE9Rh6RB9Fn9A=;
        b=YSYDIAW9mzRG6iQZvvfYRzMLG8tM6F+GwGYf1n6gh33RIQhCE317rIMwmmobB8jFaz
         P1cd1TZi2CSGVLzQocJwctbXiANj2MuGFcdjv4k8rsSw6YoIJz4ntKJP8L2DMfIkvZDa
         DJDpgXxhC/K/dSsDriG8GaXqaQ5pPWeJDy97/mP6TwOTgmKrsKSOkADNO91aK2x+UWTe
         h1Z3D2qtmV2HwFa8SMu6dQFoeuv5ErNz4re5oNJjmeFC0p+V8WDLqWauqu4DE+Z/P+QZ
         kQ7SuWVXAOIlIc0Z/zuJodqaoIqyzmSiVd+UPOG3QXHAG2lo6JFkbaG5ILpHpxtd1t7s
         brqw==
X-Gm-Message-State: APjAAAUNk/wjzkXGju2AOY6pLeAAw8D3ewV50IAc3g0E6tdiH59vsbnQ
        T1idsSm9dRqxDa9iRSDZ3XVKAxZkgxQNeMebNns7
X-Google-Smtp-Source: APXvYqwpzrYY11OpDZbAJer1PQrW1cQQ8ndOMkCZMNtUev4PhkUEDwofAXy3YrRjF11wFlDQx6BS4LDmGwg/cAnn4JY=
X-Received: by 2002:a05:6214:11ab:: with SMTP id u11mr690224qvv.193.1578626379744;
 Thu, 09 Jan 2020 19:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20200109215444.95995-1-dima@arista.com> <20200109215444.95995-3-dima@arista.com>
In-Reply-To: <20200109215444.95995-3-dima@arista.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Thu, 9 Jan 2020 19:19:03 -0800
Message-ID: <CAAXuY3rENaHb9yAgdaKRi4A8qQ5QNX8z6WBJRsNM0EVuReL8Qw@mail.gmail.com>
Subject: Re: [PATCH-next 2/3] sysctl/sysrq: Remove __sysrq_enabled copy
To:     Dmitry Safonov <dima@arista.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus FS Devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Furthermore, the private copy isn't correct already in case
> sysrq_always_enabled is true. So, remove __sysrq_enabled and use a
> getter-helper for sysrq enabled status.
Since the old way was known to be unreliable, the new way looks like a
great candidate for a KUnit test.

Off topic: I wonder if Magic Sysrq could be extended with reasonable
effort to be triggered by a sequence of keystrokes which would be less
likely to be generated by a noisy serial.
