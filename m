Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD4A1C3697
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 12:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEDKRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726531AbgEDKRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 06:17:45 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C36CC061A0E;
        Mon,  4 May 2020 03:17:44 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so13055006edv.8;
        Mon, 04 May 2020 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=9YLhFsATDF9CQ1Kz7zcFcPQ6ReaZ8MJ/irWvA43Y+c0=;
        b=FItz7HwlVSu7eS7n7AwPvpHdLcGWnBU6ErB/HRgCMWw8TeAUlfMFmxWjXDnyzgzqbc
         WSE8rhkeVDiuI9IBCQTMSqrrnfcOV2vfddsJ3KGOdabSsCQFzuDcQuaf5LExyJdzhfb8
         6BBRYOVRGWECjVxgTzjm2VHNosRK7EjTio6yj1AswTOanWgu3cCTONMhuSolIYbsIh6S
         eeF2b41Ubkd+t5saU2WZ24BbD5KpIzEnDVanhW2SwARZGX2na7tvfA+Bl9SRKI71XHTp
         AMudOq7AEjYcqgawIR0tNH8Ume6Ps1DcY+qzbwCwApxxqsQtMVob1MEkgAXGwn2d2oY8
         h6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=9YLhFsATDF9CQ1Kz7zcFcPQ6ReaZ8MJ/irWvA43Y+c0=;
        b=ExscYGXsN9WI3P4S7EXSeZ4BMH/P08iwsbKPboFhuX337H7M6MQTTJKg0uEix8hLZb
         2C6AWWIWcrZTk148ZIUcQ9ekrgUckAYpFJ/EHtmf0i56/7tVeUUEqQXzPrG4vCTFjJLM
         PZsvRjYs14Xx6bIOt/NhlekGHlnoffBS+rezKlwsYA51t6ZLsNzKP1Rj9YPXrL6EzVLt
         CSm95XF9BubLem/tSYQCxVplJJeSQXgdVoYDakVfNBCqzjiTrUjw4IP/n5jPAHFiMfoZ
         ZZmA/yju+36Q2DlSoPq3JaOFq/rv+1XdRpHdJTBsTxYwHXnnc/SCpA5O4zfNDcWXGAAp
         aV/g==
X-Gm-Message-State: AGi0PuaKZXLhjs0wYBczV6Vqytb1jLyZxa0AcPcjlIexohfchr5EBsK3
        8HYUBw9Id9gVHC86L+iog4510ikzNe7dOTxrhH0=
X-Google-Smtp-Source: APiQypIwdDOKDpx+1h9+iSL94zUNe8BJguW9reVlsixilagJeowBiCSiwwCY3WMAA+G2UF+rvlg34kzDlOSMNeQ+TtE=
X-Received: by 2002:a05:6402:7d6:: with SMTP id u22mr13626163edy.149.1588587462974;
 Mon, 04 May 2020 03:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200202151907.23587-1-cyphar@cyphar.com> <20200202151907.23587-3-cyphar@cyphar.com>
 <1567baea-5476-6d21-4f03-142def0f62e3@gmail.com> <20200331143911.lokfoq3lqfri2mgy@yavin.dot.cyphar.com>
 <cd3a6aad-b906-ee57-1b5b-5939b9602ad0@gmail.com> <20200412164943.imwpdj5qgtyfn5de@yavin.dot.cyphar.com>
 <cd1438ab-cfc6-b286-849e-d7de0d5c7258@gmail.com> <20200414103524.wjhyfobzpjk236o7@yavin.dot.cyphar.com>
In-Reply-To: <20200414103524.wjhyfobzpjk236o7@yavin.dot.cyphar.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 4 May 2020 12:17:32 +0200
Message-ID: <CAKgNAkjUssPCeOHQCg5zxjt2b9huRKfZQ3nR7Qtyr9jaizoqsw@mail.gmail.com>
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2) syscall
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Aleksa,

Ping on this piece please:

> > > It wouldn't hurt to add a longer description of magic-links in
> > > symlink(7). I'll send you a small patch to beef up the description (I
> > > had planned to include a longer rewrite with the O_EMPTYPATH patches but
> > > those require quite a bit more work to land).
> >
> > That would be great. Thank you!
>
> I'll cook something up later this week.

Thanks,

Michael
