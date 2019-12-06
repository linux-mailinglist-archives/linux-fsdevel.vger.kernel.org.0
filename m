Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD711156A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 18:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLFRmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 12:42:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41518 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfLFRmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:42:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so5868007lfp.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 09:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=WqxsPeJTqe0UTYzVZZORXptVNgtf0JJE2rfn+zKoxE0=;
        b=HEM5YKK+f18dJOv7O5XyTyH6kcLpLZWCy5ByaSBms4vRNoJHfyQhYai33MpmgjQAKw
         e4HTdH9FU+7ZhhfH22g2T+NlIXmxO5BdoiJwiHAnY61oeF00SA8vEvO13akaHSJi9pxQ
         r+BNkk83o/o+SYg4tAqP373X9EHeHt02SZ7pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=WqxsPeJTqe0UTYzVZZORXptVNgtf0JJE2rfn+zKoxE0=;
        b=ORm7rnI6IAhGHPfn1vN6K1ZScbgMZa2jrov092FMkmUkgwO5d9fmkwYGcuFW52B4xO
         RV4Kqzreqte5UM5UUxtf1EVQKV1CSvdjpSz8qrXTlQ7XU331x8McZT/NLrxkxLeNtmJk
         5J+rYaadAKzEbXM34nxCGPwGk5Nt/ucYJiR4CDIPUu43ABwhSKUui7OmQM/DY1DgZDoM
         mwp31OySX7fI3WkRukjcHSwhbpioEqvpAoAlyAv7SCu/+43INANFpEoOraVYfU1yR/MK
         rl9apkMaWCf9nhpWnphi+l9ypAfuqnLy/4SxDi8K4m9HAojhyfVfFAPogSyVS1pRxGv3
         72dA==
X-Gm-Message-State: APjAAAV2VkJwA6bU07uL6tnKDskPKoajZhp4ClDm8gUTmALq3eBx2xOK
        4VjegCsnn6V1sFyz9N0ZasNS02njmhc=
X-Google-Smtp-Source: APXvYqwzWwgWmTk9AjFSuef7ub2xj1jzlKAWXsn7/YOiS95100TosK33t3ayT6eFEeDGglj7CKEoAA==
X-Received: by 2002:a19:6d13:: with SMTP id i19mr8962819lfc.6.1575654139241;
        Fri, 06 Dec 2019 09:42:19 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 10sm4854316lfr.30.2019.12.06.09.42.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 09:42:18 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id s22so8516483ljs.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 09:42:17 -0800 (PST)
X-Received: by 2002:a2e:9041:: with SMTP id n1mr9575560ljg.133.1575654137423;
 Fri, 06 Dec 2019 09:42:17 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
In-Reply-To: <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 09:42:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wga+oXMeMjftCKGT=BA=B2Ucfwx18C5eV-DcPwOAJ18Fg@mail.gmail.com>
Message-ID: <CAHk-=wga+oXMeMjftCKGT=BA=B2Ucfwx18C5eV-DcPwOAJ18Fg@mail.gmail.com>
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

On Fri, Dec 6, 2019 at 9:09 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Does the btrfs test that fails actually require a btrfs filesystem?

Nope.

DavidH, you can do this:

   git clone git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
   cd btrfs-progs
   ./autogen.sh
   make

and it looks like that

   make TEST=016\* test-misc

should work - all you need is btrfs and loop built as modules.

               Linus
