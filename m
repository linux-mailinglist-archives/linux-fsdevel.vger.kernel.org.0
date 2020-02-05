Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5E91534FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 17:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgBEQIF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 11:08:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45780 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgBEQIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:08:05 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so2303677qkl.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2020 08:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=eti/xmWoQM9zmxGk4butE/PtzRsW0oA8DEa6iFJ8+dI=;
        b=HRGOK6FIS2hl/PMtcm5v5i+7t4eUky6qd3CfU598xenohgH7fKxZD/nUu5HlTaTRor
         By2+moIAT7ah1RkL1OyRbh7qj1kM2pc5r4zPIcH2iKvU1cBjheHoJGgxQb/ov8ooP0ow
         ZbxgEgNYduPUc0R8MrtijpDVEsqJvVTCmZMPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=eti/xmWoQM9zmxGk4butE/PtzRsW0oA8DEa6iFJ8+dI=;
        b=f7mh7w/vISUXk1daaouveVj3r/ujbfolyCzHooNtIbhLMGsylibmlOr3mLn54JI31f
         Qc37JgJhFoFOkKCpsNCNk23tO6wSYA/p4Tm+BfmjDBwTKgqkNzstDk2+AHptaJ+K5zDe
         +RlX+tVDw2FBUI83JAc5yZ238qYIu5TVHSWAupa/7OYQ5qo3zqY9DqyykRx+0O42SpAl
         tnNgvMiIcLptoRCB+8+YSoTNM2XCp192jeGEqXibC9YqraUSEcCJq2WhgCfgK+/aatgu
         +E/cyYyzibYh9gBb3T6k2CYXaWsDLaalUHFyc7uHDpQjLjDGBIPoeZCcWfpLhwnbCC82
         HIEA==
X-Gm-Message-State: APjAAAWZJyR7fYd3nU8ncac0ADHY/nnNQHqSOyFYIekBFgu1f+c2fsSe
        CkGagIdlhNXE4oX/iy6oWAjwihF7jkYK0A==
X-Google-Smtp-Source: APXvYqxMKXtRZimyppux/LxuB0Oo7mV4j2vSsfUxgSRvFn+rc6DaCduhr+ieI3vN1EBPQm1bppal7A==
X-Received: by 2002:a05:620a:134d:: with SMTP id c13mr33315010qkl.322.1580918884099;
        Wed, 05 Feb 2020 08:08:04 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id 17sm24744qks.84.2020.02.05.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 08:08:03 -0800 (PST)
Date:   Wed, 5 Feb 2020 11:08:01 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [put pull] timestamp stuff
Message-ID: <20200205160801.x3hr3ziwz2ffxltt@chatter.i7.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200204150015.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wivZdF6tNERQp+CXyz7zeN4uG9O4d7mZhCrp3anJ29Arg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wivZdF6tNERQp+CXyz7zeN4uG9O4d7mZhCrp3anJ29Arg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 06:53:07AM +0000, Linus Torvalds wrote:
> But pr-tracker-bot _also_ isn't responding to the one where that
> wasn't the case:
> 
>    [git pull] kernel-initiated rm -rf on ramfs-style filesystems
> 
> and I'm not seeing why that one wasn't picked up. But it seems to be
> because it never made it to lore.
> 
> I see
> 
>   To: Linus Torvalds <torvalds@linux-foundation.org>
>   Cc: fsdevel.@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
>   Subject: [git pull] kernel-initiated rm -rf on ramfs-style filesystems
>   Message-ID: <20200204150912.GS23230@ZenIV.linux.org.uk>
> 
> on that other message in my mailbox, but I don't see it on lore. Odd.
> Is it because the "fsdevel" address is mis-spelled on the Cc line?
> Strange.

That message-id doesn't appear to have traversed the mail system, so my 
guess would be that it didn't make it past some upstream MTA -- either 
vger or the one before it. The fact that this messages is not on 
lkml.org either seems to confirm that theory.

Best,
-K
