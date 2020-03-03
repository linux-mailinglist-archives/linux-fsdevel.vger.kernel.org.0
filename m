Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 774C9176A32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 02:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCCBtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 20:49:05 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:41998 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCCBtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:49:05 -0500
Received: by mail-lj1-f173.google.com with SMTP id q19so743725ljp.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 17:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirlab-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r/4TK4RpSOsZG1KYz157/rVP7bhcgbrwMq9gvsQBpSE=;
        b=WOqssWS1QIrJEQysDIBeZnlnC3TVwM/clsfKrxa8W0mlF8iDgI38/oJxklFjEPhBjj
         yjFmIcnmIvpI6ZWY1mOXnU2uHLBOxE/dkUta7wYvUHOnjlLF9yyjEY6ZdKT07/uGftqX
         Z+be1jpr3yHB0zguCDZwbByH3OeRMMBqTR+z3yYszh16NwM8kC5zNkYDApeKRrjiGqXY
         BrVQ9xfOyXVFjP0SCr/6wL/Wrpi1EH2iNtqFg6RoEwZg6+40O4GI96r6rvbIP0kb7td4
         GgnK2BqbEtwzUuXLfFQww+/0M/bC8NEFqDhKDrRu9ZRoA/5U/0D9C32dVAthX2kKMzEq
         07vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r/4TK4RpSOsZG1KYz157/rVP7bhcgbrwMq9gvsQBpSE=;
        b=DUqXDORTXXwaV9KLZi9T5qpxKcVowxwjS4ODtnMOH1NZSNXaHpNdm9+4T/c/bJkP8Q
         Z6XA4ZxhlltGpnc5josd84d9/BLwwZKWcR+SS0PL8Sp3qBi7IzKM5vE7BleiMDlGuLqf
         9D5fvL1B8urs9aEBDR7ey+CoRZ/AMC0UJxMoTgX8GRjuc5TLCpcXsyC5nP14DwRcars4
         zTXNcU9UbYwV2rjf6Ia4FS3A8e4JAvZtxOGVPgtpgasLvlnvCPahiD0bJ8Rw6PrvGmdN
         C3gkNCuGDL9tvnB1jsn30Ai598M8/uy3WewXyJnpLjjmLjXoL7loe9xQb6BnilLVMaa2
         coQg==
X-Gm-Message-State: ANhLgQ3hKRhS6cHwW5vWRvI+wzMMwRcxAsN32XWLFvRYcNqOHCUb8Ts8
        2HujfRtY46ziMspO7jh5oLRQKuGz/L90n8NrSK0oyg==
X-Google-Smtp-Source: ADFU+vsEiDn/HoUUhMS6Uzq8YFYaGK1WeU3lCbywAsX4x/xp9zTRrFFSVOmzBWmSwyb8aEOOykO6+y7m2/NBWC3IVAg=
X-Received: by 2002:a2e:99cc:: with SMTP id l12mr660926ljj.271.1583200142999;
 Mon, 02 Mar 2020 17:49:02 -0800 (PST)
MIME-Version: 1.0
References: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
 <20200302103754.nsvtne2vvduug77e@yavin> <20200302104741.b5lypijqlbpq5lgz@yavin>
In-Reply-To: <20200302104741.b5lypijqlbpq5lgz@yavin>
From:   lampahome <pahome.chen@mirlab.org>
Date:   Tue, 3 Mar 2020 09:48:50 +0800
Message-ID: <CAB3eZfuAXaT4YTBSZ4sGe=NP8=71OT8wu7zXMzOjkd4NzjtXag@mail.gmail.com>
Subject: Re: why do we need utf8 normalization when compare name?
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Sorry, a better example would've been "=C3=B1" (U+00F1). You can also
> represent it as "n" (U+006E) followed by "=E2=97=8C=CC=83" (U+0303 -- "co=
mbining
> tilde"). Both forms are defined by Unicode to be canonically equivalent
> so it would be incorrect to treat the two Unicode strings differently
> (that isn't quite the case for "=C3=85").

So utf8-normalize will convert  "=C3=B1" (U+00F1) and "n" (U+006E) followed
by "=E2=97=8C=CC=83" to a utf8 code, and both are the same, right?
Then compare it byte by byte.
