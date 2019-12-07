Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FA7115A79
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 02:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfLGBEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 20:04:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38516 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfLGBEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 20:04:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so9550014ljh.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 17:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xp39wpo5AR+pbRP/tZoeRSZICS3SHzWRMfhJEvbxIGA=;
        b=F9QgFlzOLVDvV/NH9kO5C38Tw6X+Hr1zV9nvDrPtaW9IdmdHU1TNQTmWgtmr08QLWs
         m/LzPoUZk/NRRXSGyCni67pyjPAjI1csctIc4AcmS9vEoOX/8bco5LDaWzkI+5Pvvxsm
         tA5h/kF2wpsxbPSmFh84K3eYpHR4dbqT6qkZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xp39wpo5AR+pbRP/tZoeRSZICS3SHzWRMfhJEvbxIGA=;
        b=stDIQn3r4pjpOED4l8eiO610ZW2p4kV408ppJf2bZzRgtWZFbMCO43xcIpNCIyBaqd
         9fnP6oFUE1rFEXcml6c6JWqlB5bmUEHUJFoObSxdjA8Gei4vwn7Siu0Wo7Vy6rZxbx/D
         S9htfv0PnP//VYd9sU/+y52DmLnZpz3XoRECy0bnV0G1WvunYgz0y+JwTSTdrUsGj28q
         DMABBlX8JOcLLyXgcvS6GG0rYXB6QD/fALum7N5w4eywA3u8hvJ625IaY86NUrDGFbCg
         Enps9mjUCfU1bpxuyWPSgCEXuxReTcO6YqNbBV8+TxTiCp8GfeYW8MvKoeYMHRu90/px
         TTzw==
X-Gm-Message-State: APjAAAXgVpdM8FPne9tCcSZHmDJoYAu4FyjZcwduerRGqulfFT/wQ5ll
        4sBnuuIsXExSnhCWj00o/lmU0/rHSMA=
X-Google-Smtp-Source: APXvYqyulLCCZdVTUEaURWrvfBaAQ9emntcYDbhNHLKQ/bl/dhWwaUs9ObPAa9JJRwstzd6Bm1Jlaw==
X-Received: by 2002:a2e:b556:: with SMTP id a22mr833728ljn.209.1575680639325;
        Fri, 06 Dec 2019 17:03:59 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w19sm7194177lfl.55.2019.12.06.17.03.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 17:03:57 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id y19so6572051lfl.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 17:03:56 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr9400181lfk.52.1575680636244;
 Fri, 06 Dec 2019 17:03:56 -0800 (PST)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <20191206214725.GA2108@latitude> <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
 <20191207000015.GA1757@latitude>
In-Reply-To: <20191207000015.GA1757@latitude>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 17:03:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
Message-ID: <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 6, 2019 at 4:00 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> Tested with 5.4.0-11505-g347f56fb3890 and still the same wrong behavior.

Ok, we'll continue looking.

That said, your version string is strange.

Commit 347f56fb3890 should be  "v5.4.0-13174-g347f56fb3890", the fact
that you have "11505" confuses me.

The hash is what matters, but I wonder what is going on that you have
the commit count in that version string so wrong.

                   Linus
