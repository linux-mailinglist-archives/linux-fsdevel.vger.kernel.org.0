Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DDD1B270A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 15:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgDUNCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 09:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728285AbgDUNCy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:02:54 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD329C0610D5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 06:02:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x10so11949641oie.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeatBysOs4g1w9ucJik06kMFsqtbBYNKB2LJi34r5/g=;
        b=ZEHK3zuTVFYNcFuYOAgxTYB5atjiPGX1lleSsfDtvhignUa7fXzs6WpktzR/OAVEGc
         8E1uyGgs3LDOOXc9qAnO0YfOfqcefQ0zM0EsxYkHnrO9Vimg1IYDc6wS9LWjTHf5ERWR
         nL+zBcQ57ReI1KIsOr4yD8DEpcD17YWO2UH3Zuy2GfokaHahgq5LDJ0qoaSrz408loCy
         o34nyylhNIzvvTfjUW1vstzHutbCavTyktxKpSkL1KZuaVaEUwLhEezSih6ycNwuMmie
         RP4kvXAfsYlrZ5pxQahkOhx5t+2D+DWKRNGNiEhW7iAV9LcHogVirvt6RpdWnfvwwrq3
         iJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeatBysOs4g1w9ucJik06kMFsqtbBYNKB2LJi34r5/g=;
        b=js/6eDca4jcQB9JB74Pjvhpu50Tvpy24vnmhHQkgdyMWpejpATOapmHpcZEjgBzUJ0
         HFiJoMnw0F4ZELPByB1TIgSnOzCiVQPym+axPzlnFXuHYLfae5D94izrVdr5fg1vyckT
         9WM2ixHE2mjGx6LNzyXtjJW09eaWoMe9gowieVP1B29LbxDV7PNZKa5tzwtO5WqGl9MF
         YyH179Bsmlf1lMhOji6pJSRsp27MVLm6qDxk23j+2RDrzqIVg5rG4RXL2kquuPE9ynDf
         LqPpKRdU8doT9T9icR/0cPftv35QZXQg/f2TMUH3ng6VKNonXRFnD1JW/53To0iajAYz
         Hapg==
X-Gm-Message-State: AGi0PubFJ6QHLOconH5u+Jl/Nowzq64Ne4fNjZ/rnzVXINw3q+1uTmM0
        WGzv942aV+psOp9zEs5L2NDSS2PJr6ufqxP14DAJ6w==
X-Google-Smtp-Source: APiQypLEdn8xTZKTZv9gRqG5Fj19mVLGqJN/fnq7VfXeiz5gV6tiXoLVzH0IzsAvypZbVip6HiFZw00aj2c/+0a/9rE=
X-Received: by 2002:aca:c751:: with SMTP id x78mr3059673oif.163.1587474172245;
 Tue, 21 Apr 2020 06:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com>
 <87v9luwgc6.fsf@mid.deneb.enyo.de> <CAFEAcA-No3Z95+UQJZWTxDesd-z_Y5XnyHs6NMpzDo3RVOHQ4w@mail.gmail.com>
 <FA73C1DA-B07F-43D5-A9A8-FBC0BAE400CA@dilger.ca>
In-Reply-To: <FA73C1DA-B07F-43D5-A9A8-FBC0BAE400CA@dilger.ca>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 21 Apr 2020 14:02:39 +0100
Message-ID: <CAFEAcA9kktJd8EJ1VCp4a0XikPS9mxmag2GFv0NvwobubQLABw@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 21 Apr 2020 at 00:51, Andreas Dilger <adilger@dilger.ca> wrote:
> Another question I had here is whether the filesystem needs to provide
> 32-bit values for other syscalls, such as stat() and statfs()?  For
> ext4, stat() is not going to return a 64-bit inode number, but other
> filesystems might (e.g. Lustre has a mode to do this).  Similarly,
> should statfs() scale up f_bsize until it can return a 32-bit f_blocks
> value?  We also had to do this ages ago for Lustre when 32-bit clients
> couldn't handle > 16TB filesystems, but that is a single disk today.
>
> Should that be added into F_SET_FILE_32BIT_FS also?

Interesting question. The directory-offset is the thing that's
got peoples' attention because it's what has actually been hit
in real-world situations, but other syscalls have the same
potential problem too. The closest I can think of to a 'general
rule' (in terms of what QEMU would like) would be "behave the
same way you would for a compat32 syscall if you had one, or
how you would behave on an actual 32-bit host".

thanks
-- PMM
