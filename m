Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBC2AFD1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 02:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgKLBcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 20:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbgKKWqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:46:45 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B0BC0617A6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 14:27:21 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id l10so3862906lji.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 14:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLOabNKoNSfJ8YlJALUX/HSF7x5smlTVZLW77pgDXxE=;
        b=IRSGHIcCR371rgKVLVF0IWNeekp7RPE0tq0jXgz/fCbjpYkabNrYN8yq8L6uP1wNLm
         iQV9DdRexGpEEOJh3X5FNLU9tmqj7DBi9Jq9H9z+BIkxguhTupVA5zY3gmTZBfYvUSdr
         RBkqVcAV8M5WnEewVOMQWCUC58Swu7KJUcmrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLOabNKoNSfJ8YlJALUX/HSF7x5smlTVZLW77pgDXxE=;
        b=UQrX3aGg6U4qzdYKgZKhMcTLbBFszeja3sCnf298RJGqwSm9eHqeuzDJuE64StCQsJ
         EXKBgdgNBQItyPCle3abdfThnhUem04c3Lt8g/mIbtCDxr4gzGHg28I0LEgF84vZsknG
         YlAnKziETxhxgpjoytxWu5ZplI1L5EH30FqK67sfGzvRLZG5Egm7ItDLRFmOrXb4k/ys
         +swp8wkwwJrZIsUS0lcKGErK83z3uGBStyFzn9U89p/GuuJC+ZZXOHKSDhBgUHnbxU0X
         oCPcgQ67rFsHzhh3z1nGRCSzlEerPhft7n/KDi7bsY3Uz/oAUtSqM3wHdRlFSylY9Q/L
         oxjQ==
X-Gm-Message-State: AOAM531F8hDhRwAYc5GkbpJdLbUe51v1ssh5mZPYNuv+ej17FWy8chiB
        IoHzQle3p6a3qTD/MhOKX8gaP02jrEpBPg==
X-Google-Smtp-Source: ABdhPJxyqc6CBOnSgzDjLRngGcWWnvl4jW32MKEORmxgSG+6YFf6kvRDEWsreKkjQrIupaDDliuDpg==
X-Received: by 2002:a2e:a17c:: with SMTP id u28mr9127994ljl.453.1605133640065;
        Wed, 11 Nov 2020 14:27:20 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id m22sm348894lfb.27.2020.11.11.14.27.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 14:27:19 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id s9so3834358ljo.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 14:27:18 -0800 (PST)
X-Received: by 2002:a05:651c:110:: with SMTP id a16mr12194059ljb.285.1605133638694;
 Wed, 11 Nov 2020 14:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20201104082738.1054792-1-hch@lst.de> <20201104082738.1054792-2-hch@lst.de>
 <20201110213253.GV3576660@ZenIV.linux.org.uk> <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk> <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
 <20201111215220.GA3576660@ZenIV.linux.org.uk> <20201111222116.GA919131@ZenIV.linux.org.uk>
In-Reply-To: <20201111222116.GA919131@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Nov 2020 14:27:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiRM_wDsz1AZ4hyWbctikjSXsYMe-ofvtnQRQ1mFcTqnA@mail.gmail.com>
Message-ID: <CAHk-=wiRM_wDsz1AZ4hyWbctikjSXsYMe-ofvtnQRQ1mFcTqnA@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 2:21 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Something like below (build-tested only):

Apart from my usual "oh, Gods, the iter model really does confuse me"
this looks more like what I expected, yes.

Considering the original bug, I'm clearly not the only one confused by
the iov_iter helper functions and the rules..

             Linus
