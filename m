Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144FE1B101F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgDTPaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDTPaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:30:04 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9923AC061A0C;
        Mon, 20 Apr 2020 08:30:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e2so5936582eje.13;
        Mon, 20 Apr 2020 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ChXiBeTRT71CMVBklbLHXRzN05QgvLFbh2UfLNf6JWo=;
        b=Op6PlwSikOrFSwZSehUg2o6jvp1i/1WueqJOXSSs/4PVE1Jw9eSQqjoLFNn6x9qkBB
         1kyuAb49gBdd7fEahkje+H4WO1uSIQJvlc0dH1qjGRnz5AjlsSvJpwjoid9pR+2q4Eyj
         yw8dfh5VqmTfoSvcyLAA+syQstgBPxsUVT7ROfba2ATLVhd6b0XUgevwP+2+PQHxsCTg
         l1DZe397fJdnyYhffZrGKuO7M4Z6D7qhZEczvAU18701P/05Xq1OMZGdiYJbe2FYdfsM
         gRQqt2AtM7X/CJ/vAC8XzH8S58pxTPov53k5TUW1c1VGBjGH+3Km5TW3zSE8ISsm4a0b
         ssUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ChXiBeTRT71CMVBklbLHXRzN05QgvLFbh2UfLNf6JWo=;
        b=eU0mOOUqjWi/0OMEkCdAc9VR59ajnB6kYZJuAqkbDSR+BnWN7hFgA4Hh6sZyvYghdY
         3xRoWGi0wZZKTADzearpFAu/JhE0RQRf34XtlNFYXgwqXlx97mDJPLRoLyQyh9yJfHCI
         H+Rjq1oDiCUzd84dCzSO3jWeZ7GHXL3D+Ug/QtYuO1fpnGS3FJSs+Ai0pLKFu66LgnEa
         1OkD6S3NC5LJCOchd9CP6Q44/tV8w/NuboSv/d/JUUYiYD+Um4bzTnFab7r1FSUephdu
         oVuksp0KTq+fCoCvMMkY9mPe9MSFGsXOoZt9POQ3G6TUth/RwtNWxyClkgIpKLqJF9nA
         w94A==
X-Gm-Message-State: AGi0Puasef8q9SFBQlyr9HBmyKn4JUKXkTem8ut5UosqT2oBRmCJww+G
        rIWAwPacngMu6xBv4ZzxEI3qIlagBTFXv58Dvho=
X-Google-Smtp-Source: APiQypJMwhr3wlwtMc54euX25ix6n9SXlmaPFdhhbHX1PnRX5XFLSIquayw7L8P2fXf8kXZT1SmtaqmokGiQx3I9d4o=
X-Received: by 2002:a17:906:54cd:: with SMTP id c13mr16047470ejp.307.1587396603272;
 Mon, 20 Apr 2020 08:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <d2979d75-5e45-b145-9ca5-2c315d8ead9c@redhat.com>
 <708b8e2a-2bc2-df38-ec9c-c605203052b5@sandeen.net> <7d74cc3b-52cc-be60-0a69-1a5ee1499f47@sandeen.net>
 <CAKgNAkgLekaA6jBtUYTD2F=7u_GgBbXDvq-jc8RCBswYvvZmtg@mail.gmail.com> <5ac17186-4463-4f61-4733-125f2af9b73d@redhat.com>
In-Reply-To: <5ac17186-4463-4f61-4733-125f2af9b73d@redhat.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 20 Apr 2020 17:29:51 +0200
Message-ID: <CAKgNAkhcAM78ihiW=R1xkVBpFzfNaRhXQJ2x5TnSnLwzVVRH0g@mail.gmail.com>
Subject: Re: [PATCH 2/2 V2] man2: New page documenting filesystem get/set
 label ioctls
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Eric,

On Mon, 20 Apr 2020 at 15:48, Eric Sandeen <sandeen@redhat.com> wrote:
>
> On 4/20/20 7:04 AM, Michael Kerrisk (man-pages) wrote:
> > Hello Eric,
> >
> > So it seems like this feature eventually got merged in Linux 4.18. Is
> > this page up to date with what went into the kernel?
>
> Yes, I believe that it's all still accurate.

Thanks. I've merged the page.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
