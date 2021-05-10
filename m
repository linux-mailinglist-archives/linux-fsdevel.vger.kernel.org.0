Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313BC379AD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 01:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhEJXhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 19:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhEJXhk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 19:37:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F06C061574;
        Mon, 10 May 2021 16:36:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x2so25871780lff.10;
        Mon, 10 May 2021 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1vLdoMc436V5vLkM/SG9lcVa+pKt53d4Ho0rY0HJLfc=;
        b=HXOpcvY8PWrOtEAuDNbElzaBcbgypIoio4lEwgCBpMZIShlIzqBgXtbmYvW3Y01XzC
         gBS7Ky0IdiL/qcwbZ1sBrNoYsWxNsiX3xuzGae1SDlk8JK8ecK22xeUN/ZqXHbxPpcj7
         2aNt9y0N/1teetxGUGyFEBG+GgF8j5IQ4VJzxrXGPYckzBcCrzbvPN24iwo4Fv5leSNA
         Fu0LzFyK6kbgAh1IM6pbD1pacRwaOa61gUl32IxOMlBVZq3NgkYDlgM/xCJC4jpawR95
         h6OrrGlQAmnAfIwm9cwIrAAdU5hjESFjs/YcTIqVD/RyrXV9gSZBXmXhlpX49Fl04OCm
         sfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1vLdoMc436V5vLkM/SG9lcVa+pKt53d4Ho0rY0HJLfc=;
        b=Y+cVZ035Pn74c/eAk4sPXNN3cUqnfTzAS2220OK7yfQfPzp07jcf4iIDbR9cw5TkkF
         DaKHTIEw3h7T3ja+ezDg9AK1PUxKHEBJKss7ZdN7aU1Y6/KRim8GQUjQhd0+2HwM3Bhn
         6jrjP6qInWQawGUHnn4OMRSNy9homPpkaIUFkMiq+G0DFQipp2T+CPId0LaLLze4OhHW
         IX8bSZnxnca0LejwJRyKl/cBPIgOu/mgwR3x/ACsqP4rPrRTBGaiQ4oHwCW1/Sa8Celn
         FiwS7/NLE34iMoPxCMC0eMXGhsP+jwwKl16LxwNQYFTEdVwjCBDDZMZ7kdzWWsMAV24y
         /PZw==
X-Gm-Message-State: AOAM532ZtdbYjn5Ab6JVeOf27v15ixeew9jNCf6iG27GkgHFw2TBoBsc
        mac7ahRvpe2rRqoUJ3ZAr/MmFfDPfTsCZcGwl3JY853AdyCUNg==
X-Google-Smtp-Source: ABdhPJw1SI0MRnGPPtZfzIIMcPqt73V+WOITPpHN1gISMKHTWFjGrBfizgYMWD3HWZce3HWVawlSOYG59wnLWNf9leU=
X-Received: by 2002:a19:614e:: with SMTP id m14mr18062622lfk.395.1620689793374;
 Mon, 10 May 2021 16:36:33 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 10 May 2021 18:36:22 -0500
Message-ID: <CAH2r5mt1Fy6hR+Rdig0sHsOS8fVQDsKf9HqZjvjORS3R-7=RFw@mail.gmail.com>
Subject: fanotify and network/cluster fs
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the recent changes to fanotify (e.g.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7cea2a3c505e)
has there been any additional discussion of what it would take to
allow fanotify to be supported for network/cluster fs (all major
dialects supported by cifs.ko support sending notify requests to the
server - but there is no way for cifs.ko to be told which notify
requests to send as fanotify/inotify are local only in current Linux -
unlike other OS where notify is primarily for network fs and passed
down to the fs)

-- 
Thanks,

Steve
