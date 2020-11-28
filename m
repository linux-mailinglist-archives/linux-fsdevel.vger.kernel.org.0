Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2086A2C74C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbgK1Vtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387450AbgK1TI7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:08:59 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DE2C02A196
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2020 05:02:48 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q22so6713078qkq.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2020 05:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oCh7zLnDTpH16tMp5jixVUXV+XUKvX3ngLZQDxFzJp4=;
        b=i5UTYJJA+h94TcGSI/btN8WADgqf/ob+2yNu636lpqbN2UwIDqjWdnQ1ViMcM8Hh5k
         YCXKb5vy1aHi8tyGC/AXA4fSR+xSc/GDsRr+s9dikOqDdjU8NZ8g41tQnJ1QAJAdrxPy
         1x+kgwkxUNl+E5DEI/F3cxIln8aWLdwXAzd/BUDc9jT/o8ZDE8+f8ryshQw1XnAYrBDp
         rsafHoTthSVV0gncoPHd4t+dmRSBt3UH8tnIuiI9LsWnuFjwNQKYrpZPqDhKKo2WmwaF
         Q8t7q8E5Sby+8DIih8bpEOyFMCg2Epj/EjwMoEgr2muzbePnewT866eS2YTAPNkHHYau
         tvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=oCh7zLnDTpH16tMp5jixVUXV+XUKvX3ngLZQDxFzJp4=;
        b=AAcSDGroJ02c2DrxlDr86Nm3FJ13RB+0/VpV9mEptjhCVrB2+wYU7ahWCwi4d2EW1t
         NCL6KW4bTDMNR0JrelPwyJVsHFuj6WJLZTvhZpwue7KSqIw7RsZGvyTKwD35iposM0GC
         xoppojtjiVG0XYxerTKObz2UR8tk/Lv622G5vdQNx6eGg1Ncf2wGIW/21bpnma5dNJT+
         +rmZ/s+EbDBV8TeGfIdSFKtWJdQi1fk/wN+/wivXd9ntFUxcctnYc2rJq8OpseW4IPXe
         q4iwSO7Y5XQw3EqMGi0ttHThPxVF1kUqoGEgspwzyQg7XaGJzIjH2TP5HsRmCxvOsv3f
         GaCQ==
X-Gm-Message-State: AOAM5314lmQvCD9dzFHOdI4G12il6nq4NopCrLwTrpnfphTKr978qZfY
        KokwoVF6VT20yB5szCpY2l/CGK7LZnlBNbUp+fQ=
X-Google-Smtp-Source: ABdhPJwYbaYHtRd7DDkMoQz+m9TWqI0CT7Nm9g9I3M0KwPQib1kAzaNgVUinRU3Sf3bCV7FLNqCx5exBagy415WKu7Q=
X-Received: by 2002:a37:a1cc:: with SMTP id k195mr13634812qke.379.1606568566658;
 Sat, 28 Nov 2020 05:02:46 -0800 (PST)
MIME-Version: 1.0
Reply-To: mohammedssaaaad@gmail.com
Sender: mr.leonharris111@gmail.com
Received: by 2002:ac8:2263:0:0:0:0:0 with HTTP; Sat, 28 Nov 2020 05:02:46
 -0800 (PST)
From:   Mohammed Saad <mohammedsaadht@gmail.com>
Date:   Sat, 28 Nov 2020 05:02:46 -0800
X-Google-Sender-Auth: RsRGB3qXcn-dZW1bdYG1mFDkeJo
Message-ID: <CANg__WRYN-FHHTuzxy8VM8j3e-FH7aTGZ6bGbgZb8MKo1ZquGQ@mail.gmail.com>
Subject: OK
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings,

I humbly solicit for your partnership to transfer =E2=82=AC15 million Euros
into your personal or company=E2=80=99s account .Contact me for more detail=
ed
explanation.

Kindly send me the followings

Full Names
Address
Occupation
Direct Mobile Telephone Lines
Nationality

Mohammed Saad
