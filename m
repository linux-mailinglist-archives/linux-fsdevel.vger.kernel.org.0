Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795972D721D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 09:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437015AbgLKInl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 03:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390924AbgLKInI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:43:08 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C9C0613CF;
        Fri, 11 Dec 2020 00:42:28 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n4so8676572iow.12;
        Fri, 11 Dec 2020 00:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rj1vcfLqePUUlfq7nqOeH8Fm78abBXaKWQgBWRoed4A=;
        b=dl7l0wi5jZN6XN7c6BYUXRKxvPj9p3GLxvbbZ2NMLxZYHf74FV7iUH72JnoFuugKv7
         r+j4eW81uTT36YVTgbawKBSSdgIIZOoCYc5h4KnLJIg1cBtqCR1QYVm60D4cCl26oURr
         8AoT9wYTy3YutSRlHGHBcE+bjh5VrQlBU5i/RUygv0DqxTm20HPZ+kseOfcaowuYWLVj
         2oA1BbrBziMh15/eQ54OWxSR135CxJC41UrTHPihzuKnwdRmr1zjBcfepE+vIVz0fo0E
         uD3nTp3WHPKNzi/JadBV8wneE3k56qJK5/wRAyd3Zmq87SFwoakrwiCGFKS6T6n5pwD8
         bv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rj1vcfLqePUUlfq7nqOeH8Fm78abBXaKWQgBWRoed4A=;
        b=Fht6IWs9VvUWBKZr0L7EGWrLqMwjxeiTaAUaUIuNzNczUslMvZzy3vuorlN+IQvqRr
         0kgb7iZRCqHLmDo3iCoyDP5aSp1NeMpSfdLYcYL7w+uf3h93JBKckk5vQm0b6+ZmGHfz
         x5yTsghUxp2KVX05lYhfncfT6UIAOHvSmlIiUuebZt/z7va4jEn3QmNg+PG6+tTWgGLv
         rCTbUOkKWVquvlF6tVSdTvNLqP+pGCtYg3p15K4wYNcmXeiZ61VcRw+ttQdmA7GNZVQM
         +9kuZ6j3DvkKnGoTf96yrqG7671FPEKbhUZ3lab7sjr/Mo5XDq9e44bl0T9r/Amz37jD
         /RRA==
X-Gm-Message-State: AOAM531+phuo4nmXK0XUTtTduTftu5ZS0L3jaG8zHqVfXaW6L+xnbGSm
        eNr543Wv9rLyx/X81H90yRbkD5OwJuTAFb7yvtVkr35Gzpg=
X-Google-Smtp-Source: ABdhPJzhnVXJNQD7u8uaTOLLiLj5CZNQL69qHFfHp5gzroIOKm7nN+i4YJf/xrqJQnnVE0ZxcPXFMeFW5YIBn6SnBtE=
X-Received: by 2002:a02:a60a:: with SMTP id c10mr14200928jam.123.1607676147492;
 Fri, 11 Dec 2020 00:42:27 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2012101507080.1100@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2012101507080.1100@eggly.anvils>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 11 Dec 2020 10:42:16 +0200
Message-ID: <CAOQ4uxj6Vvwj84KL4MaECzw1jV+i_Frm6cuqkrk8fT3a4M=FEw@mail.gmail.com>
Subject: Re: linux-next fsnotify mod breaks tail -f
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000afb1d705b62c45d3"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000afb1d705b62c45d3
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 11, 2020 at 1:45 AM Hugh Dickins <hughd@google.com> wrote:
>
> Hi Jan, Amir,
>
> There's something wrong with linux-next commit ca7fbf0d29ab
> ("fsnotify: fix events reported to watching parent and child").
>
> If I revert that commit, no problem;
> but here's a one-line script "tailed":
>
> for i in 1 2 3 4 5; do date; sleep 1; done &
>
> Then if I run that (same result doing ./tailed after chmod a+x):
>
> sh tailed >log; tail -f log
>
> the "tail -f log" behaves in one of three ways:
>
> 1) On a console, before graphical screen, no problem,
>    it shows the five lines coming from "date" as you would expect.
> 2) From xterm or another tty, shows just the first line from date,
>    but after I wait and Ctrl-C out, "cat log" shows all five lines.
> 3) From xterm or another tty, doesn't even show that first line.
>
> The before/after graphical screen thing seems particularly weird:
> I expect you'll end up with a simpler explanation for what's
> causing that difference.
>
> tailed and log are on ext4, if that's relevant;
> ah, I just tried on tmpfs, and saw no problem there.

Nice riddle Hugh :)
Thanks for this early testing!

I was able to reproduce this.
The outcome does not depend on the type of terminal or filesystem
it depends on the existence of a watch on the parent dir of the log file.
Running ' inotifywait -m . &' will stop tail from getting notifications:

echo > log
tail -f log &
sleep 1
echo "can you see this?" >> log
inotifywait -m . &
sleep 1
echo "how about this?" >> log
kill $(jobs -p)

I suppose with a graphical screen you have systemd or other services
in the system watching the logs/home dir in your test env.

Attached fix patch. I suppose Jan will want to sqhash it.

We missed a subtle logic change in the switch from inode/child marks
to parent/inode marks terminology.

Before the change (!inode_mark && child_mark) meant that name
was not NULL and should be discarded (which the old code did).
After the change (!parent_mark && inode_mark) is not enough to
determine if name should be discarded (it should be discarded only
for "events on child"), so another check is needed.

Thanks,
Amir.

--000000000000afb1d705b62c45d3
Content-Type: text/plain; charset="US-ASCII"; 
	name="fsnotify-fix-for-fix-events-reported-to-watching-parent-and-child.patch.txt"
Content-Disposition: attachment; 
	filename="fsnotify-fix-for-fix-events-reported-to-watching-parent-and-child.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kik0jqhf0>
X-Attachment-Id: f_kik0jqhf0

RnJvbSBjN2VhNTdjNjZjOGM5Zjk2MDc5MjhiZjdjNTVmYzQwOWVlY2MzZTU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDExIERlYyAyMDIwIDEwOjE5OjM2ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZnNu
b3RpZnk6IGZpeCBmb3IgZml4IGV2ZW50cyByZXBvcnRlZCB0byB3YXRjaGluZyBwYXJlbnQgYW5k
CiBjaGlsZAoKVGhlIGNoaWxkIHdhdGNoIGlzIGV4cGVjdGluZyBhbiBldmVudCB3aXRob3V0IGZp
bGUgbmFtZSBhbmQgd2l0aG91dAp0aGUgT05fQ0hJTEQgZmxhZy4KClJlcG9ydGVkLWJ5OiBIdWdo
IERpY2tpbnMgPGh1Z2hkQGdvb2dsZS5jb20+ClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWlu
IDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogZnMvbm90aWZ5L2Zzbm90aWZ5LmMgfCA1ICsrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvbm90aWZ5
L2Zzbm90aWZ5LmMgYi9mcy9ub3RpZnkvZnNub3RpZnkuYwppbmRleCBhMGRhOWU3NjY5OTIuLjMw
ZDQyMmI4YzBmYyAxMDA2NDQKLS0tIGEvZnMvbm90aWZ5L2Zzbm90aWZ5LmMKKysrIGIvZnMvbm90
aWZ5L2Zzbm90aWZ5LmMKQEAgLTI5MSwxMyArMjkxLDE4IEBAIHN0YXRpYyBpbnQgZnNub3RpZnlf
aGFuZGxlX2V2ZW50KHN0cnVjdCBmc25vdGlmeV9ncm91cCAqZ3JvdXAsIF9fdTMyIG1hc2ssCiAJ
CX0KIAkJaWYgKCFpbm9kZV9tYXJrKQogCQkJcmV0dXJuIDA7CisJfQogCisJaWYgKG1hc2sgJiBG
U19FVkVOVF9PTl9DSElMRCkgewogCQkvKgogCQkgKiBTb21lIGV2ZW50cyBjYW4gYmUgc2VudCBv
biBib3RoIHBhcmVudCBkaXIgYW5kIGNoaWxkIG1hcmtzCiAJCSAqIChlLmcuIEZTX0FUVFJJQiku
ICBJZiBib3RoIHBhcmVudCBkaXIgYW5kIGNoaWxkIGFyZQogCQkgKiB3YXRjaGluZywgcmVwb3J0
IHRoZSBldmVudCBvbmNlIHRvIHBhcmVudCBkaXIgd2l0aCBuYW1lIChpZgogCQkgKiBpbnRlcmVz
dGVkKSBhbmQgb25jZSB0byBjaGlsZCB3aXRob3V0IG5hbWUgKGlmIGludGVyZXN0ZWQpLgorCQkg
KiBUaGUgY2hpbGQgd2F0Y2hlciBpcyBleHBlY3RpbmcgYW4gZXZlbnQgd2l0aG91dCBhIGZpbGUg
bmFtZQorCQkgKiBhbmQgd2l0aG91dCB0aGUgRlNfRVZFTlRfT05fQ0hJTEQgZmxhZy4KIAkJICov
CisJCW1hc2sgJj0gfkZTX0VWRU5UX09OX0NISUxEOwogCQlkaXIgPSBOVUxMOwogCQluYW1lID0g
TlVMTDsKIAl9Ci0tIAoyLjI1LjEKCg==
--000000000000afb1d705b62c45d3--
