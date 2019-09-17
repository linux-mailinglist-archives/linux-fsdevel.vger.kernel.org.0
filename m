Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62764B46DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 07:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390897AbfIQFbl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 01:31:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35694 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbfIQFbl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 01:31:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so1447946pfw.2;
        Mon, 16 Sep 2019 22:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQ0acRLPRiNkuyWsFFHOV/6xwzk+wEWY0J/gcpntvHs=;
        b=TeorArZ8kq/CR+J83TcgIcoMMXb0AYK6talNwdUHRJVyf9VikpQmWsGf7w3UTHfQny
         pDINeP/EhlRnYY9sMv2fum/y2ArzqdmeDG6hxpTklbaUPRN7YV9s+U7mOiT0H/fgCQDm
         KIxM9/+sDhNZpzPWn/c7afHOZPoV/5MgIDG31sTYYhJmzI7Ej8GSRGomCI5/6RQ9WiLr
         Nvki95KG/xig1NrsLMbSId2FLFpvMbvTlBNBD0ED8BG2PooD4xBLZK9Rg5ULlGRAP60L
         zaD45mDMcL2jwgoEcrUVWYTZN+cQdMEJJTuMS/Vxl5SJayjoOQjwbgRoHqPhCPuFKmUG
         psIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQ0acRLPRiNkuyWsFFHOV/6xwzk+wEWY0J/gcpntvHs=;
        b=bYTbXkAVcTlUyrnVw48jr5PLgn2vg7fWtCJaZ2eG4uSOvBKq9bMjFRQaxqU07lAAiL
         LO1zry62i0NRnsz9BQf22Qy//+pNcAtiUWiB3F2XBYAXGou8OtiAHaIU8/ra9ks1glk5
         won0V/76sKyidPgozkkr9ZcjxaehB8hg/psTfLhaWJ8UxF6zNrv7fWpcwp413DmNa0iN
         LPnBspzA9uu9VhoA7XLjmnevS0GAzZ/DP2T31klgJFwgJLAaRPA3buYwPaIfbXEch3N/
         hQH7pLFYIZ4xBwR3fpBIikt/EUjeDu7kplzMjSuJn1fm+5ud8pxy1GONzzhDryshZZbE
         fd1g==
X-Gm-Message-State: APjAAAX2M8FB4Ht/N7c1XZEMOrB2CI0DAgMsPmwDxJUvhvSTGFnKGBdZ
        tMJ8bo/FhKFJTZ2DaE0IpMg=
X-Google-Smtp-Source: APXvYqxR+x7zzJVajUqecslzP05unUQObpLjtCGBNhxJZNrfm+ZY01XHEVbEv4NirSM8n8X1LdMWug==
X-Received: by 2002:aa7:8f08:: with SMTP id x8mr2368896pfr.48.1568698300250;
        Mon, 16 Sep 2019 22:31:40 -0700 (PDT)
Received: from arter97-x1.inha.ac.kr ([165.246.242.140])
        by smtp.gmail.com with ESMTPSA id h2sm964076pfq.108.2019.09.16.22.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 22:31:39 -0700 (PDT)
From:   Park Ju Hyung <qkrwngud825@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        namjae.jeon@samsung.com
Cc:     alexander.levin@microsoft.com, devel@driverdev.osuosl.org,
        linkinjeon@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sergey.senozhatsky@gmail.com
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
Date:   Tue, 17 Sep 2019 14:31:34 +0900
Message-Id: <20190917053134.27926-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <8998.1568693976@turing-police>
References: <8998.1568693976@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 17 Sep 2019 00:19:36 -0400, "Valdis Klētnieks" said:
> I'm working off a somewhat cleaned up copy of Samsung's original driver,
> because that's what I had knowledge of.  If the sdfat driver is closer to being
> mergeable, I'd not object if that got merged instead.

Greg, as Valdis mentioned here, the staging tree driver is just another exFAT fork
from Samsung.
What's the point of using a much older driver?

sdFAT is clearly more matured and been put into more recent production softwares.
And as I wrote in previous email, it does include some real fixes.

As Namjae said too, Samsung would be more interested in merging sdFAT to upstream.
If we diverge, Samsung will have less reasons to contribute their patches to upstream.

Also, I think it makes much more sense to make Samsung the maintainer of this driver
(if they're willing to put in the manpower to do so). Asking them would be the first
step in doing so.

> But here's the problem... Samsung has their internal sdfat code, Park Yu Hyung
> has what appears to be a fork of that code from some point (and it's unclear ,
> and it's unclear which one has had more bugfixes and cleanups to get it to
> somewhere near mainline mergeable.

I made it extremely clear on where I took the code.

The initial commit: "sdfat: import from G973FXXU3ASG8" states which kernel source
I used.

You can simply search "G973FXXU3ASG8" on http://opensource.samsung.com and download
the source code. It'll match exactly with my initial commit.

My repository is basically rename + clean-up + older kernel compat.

I think we can all agree that using the sdFAT naming on non-Android is very
misleading, which is why I renamed it to exFAT.

sdFAT includes support for fat16/32, and as also mentioned in
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-next&id=58985a9d2d03e977db93bf574a16162766a318fe
this isn't desirable, especially in mainline.
I cleaned it up and removed some other Samsung's code that relies on proprietary
userspace tools such as defrag.

I believe my repository is in the cleanest state for getting merged to mainline,
compared to other drivers avilable out there.

If we happen to pick it to mainline, I think it'll also be quite trivial for Samsung
to pick mainline patches back to their sdFAT drivers used in Galaxy devices.

> Can you provide a pointer to what Samsung is *currently* using? We probably
> need to stop and actually look at the code bases and see what's in the best
> shape currently.

Namjae could probably elaborate here, but if I were to guess, there wasn't a
noticeable difference in recent sdFAT releases. Even the lastest Note10 kernel only
had some uevent changes.

I think the current latest public source's driver is the best one available.

Thanks.
