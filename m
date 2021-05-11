Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF1D379E9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 06:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhEKEfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 00:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEKEfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 00:35:06 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E8AC061574;
        Mon, 10 May 2021 21:34:01 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id o9so10934734ilh.6;
        Mon, 10 May 2021 21:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfUwZWIMtFqUWOFRb1yI+FNyvJ/OkAyJSULvaCQz8ss=;
        b=tDUb6aYMiLIvJgg2v2g0IAJwxtKWdiOE/OtwepOaxnDDG7TknHjePeJ/QtpRxKozSe
         /n3SmfA4ZxjORGylMc4qPC3Oi7JNgruHCfLXt3bMW1dpWvfxg27KJ0dMXmDdPNuY9ayr
         gCAhfT35p5NkVndOBmAfEK77JH+mrjKcPsFudXCXF7TX0h0iRsioq20BGEibuefPbj8e
         T9qjO9Pjhxnns3Dde0hqTonVhnQkO8Op2+4IVdw4nQrELZ0gyE7G0m56iPM4L5iEEIv8
         ETMqPR9gNgH35Y7uy1Gt3G/H592b/QhdXQUAWwH8Aq6WEISzXmQao86fbp4aWNy8dgZr
         9KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfUwZWIMtFqUWOFRb1yI+FNyvJ/OkAyJSULvaCQz8ss=;
        b=TsOj1bKmGgPYv+s131CHHJiaMikRaH63BZC8ApCF/rqL1+gAX1PVWCsLwpEnuDd6c3
         Jzrd8y33c7XLfP+jX+bNbhQzNFpvpaG/WBKCElbQRKjkVXJaeWjrP1qsf7iK9oikH8RG
         w+0K2RmZvZpnzy/O1MaJs6EW5s19/LgNQdnFaiK4hDXKzrXRfgnT7W+5S1QmdZi6gmzM
         nT14Tw0Oa1ZTdeYP5+MItNOfFlXCAAca5n0S64CbztpscNUSgt5EUAjL63St9HoJI2iz
         yDO6pvFhes+qJeRvqloEZgTBOjMk4RUiAft6qdynvphFDqEDJG1AEyUXrIakj5F/G+vt
         lmqg==
X-Gm-Message-State: AOAM532QEKnx46XPud5dl4Zp6uVxatErv/wrhs8PosFdgDhG/FjoaHKQ
        JSB1AjK5+z5ZivkHAWRN1CKnTF9mKIRY2qeXzajVuFDqq7A=
X-Google-Smtp-Source: ABdhPJzHVoo8JtSicLmssQ/DW41zGysAwxl21FPZ+B17KgQfDFtNDYxVKtZyGNvANfSWDacO2WRb3EflTE6PprJ11W8=
X-Received: by 2002:a92:b74a:: with SMTP id c10mr24010182ilm.72.1620707640614;
 Mon, 10 May 2021 21:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mt1Fy6hR+Rdig0sHsOS8fVQDsKf9HqZjvjORS3R-7=RFw@mail.gmail.com>
In-Reply-To: <CAH2r5mt1Fy6hR+Rdig0sHsOS8fVQDsKf9HqZjvjORS3R-7=RFw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 11 May 2021 07:33:49 +0300
Message-ID: <CAOQ4uxigOsEUrU5-QndJujVtP9KLdjEQTm3bHjGRCFWjZCAKBw@mail.gmail.com>
Subject: Re: fanotify and network/cluster fs
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 2:36 AM Steve French <smfrench@gmail.com> wrote:
>
> With the recent changes to fanotify (e.g.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7cea2a3c505e)

Not sure how this is related to remote fs notifications.

> has there been any additional discussion of what it would take to
> allow fanotify to be supported for network/cluster fs (all major

It would take someone to pick up this RFC that was already posted
2 years ago:
https://lore.kernel.org/linux-fsdevel/20190507085707.GD30899@veci.piliscsaba.redhat.com/
https://lore.kernel.org/linux-fsdevel/CAOQ4uxipauh1UXHSFt=WsiaDexqecjm4eDkVfnQXN8eYofdg2A@mail.gmail.com/

> dialects supported by cifs.ko support sending notify requests to the
> server - but there is no way for cifs.ko to be told which notify
> requests to send as fanotify/inotify are local only in current Linux -
> unlike other OS where notify is primarily for network fs and passed
> down to the fs)
>

If you wait long enough, I'll get to implementing this for FUSE some day...
But there is *really* nothing blocking cifs developers from implementing this
and writing the specialized tests. I can help with guidance.

Thanks,
Amir.
