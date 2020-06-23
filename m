Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD53F2046AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 03:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbgFWBVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 21:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731898AbgFWBVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:21:42 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE86EC061573;
        Mon, 22 Jun 2020 18:21:41 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n24so21453730lji.10;
        Mon, 22 Jun 2020 18:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F+RvqEz6PG/X+CuXMBwrvKY9rrg/o+DXQrz2YG0godc=;
        b=G7HHrTI9fPnjkyBjlhBAlYh3R/lTyai5eZRt1sIWWTU3Y2h+ozMOd94I+5aC4yiLVu
         zK2wfAj7UkBfFXGwpqVyuw1Huy/AsrQCFd1dpZaY1dzuZvHnWl46lfVsNy2yJufcP9cp
         37lzbzNkq6NtIpnBDpFW2FNN+IA9hrxg9pjL+uLeb1/SEOoH3SXpBUfdbKAfVZx84bhn
         eCpi1VNCvkl82CfIzU6j2q8I8yesPLW0fb6vehW73JLckcRLGI7V/+c7wMXkrmho1wWP
         r3xER19+4wKPEkl0B+iYLsSpkSXG+22GGx5mJsnGerWmWg+17n32PlkfDmMm/D5ihYwN
         9v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F+RvqEz6PG/X+CuXMBwrvKY9rrg/o+DXQrz2YG0godc=;
        b=XX+RJhtrzFdDeJ/ScWyB+Oh1cWieY5NNN24KU549qwSfSa+BxwVsCgxKO8oK+9ozPe
         Xxj5dpdK9MicVNZQU1lN3E2SQLSYKb5uAu66G9t+mQxjs0EKWPNFXKcbf+Nigzz/VyWG
         /DBFgaFHIbU0OqdNVdFSw7ZKAYgyvclxLx3Myiw/i8hTXJcChGyrZQ/21PhsfOav7VuX
         Semz/UBwl6FGhIU+HhLlZA4zRDQ00FsQKTapzmMwHaORg0e1Hv+YoQYlTmMkW2piOdwp
         rybxOGdCERS7xXj1z8w6/69iVryJYzs+gdwZqCzJcHH5Bu4FLBCT96taU6l6eXXEhtIQ
         a7Fg==
X-Gm-Message-State: AOAM531qYEsP1XNa86+LeustqjDQteC5U+JOb34LCqQ6qBXQ9qVJ2dhC
        K2yVo0IueC0Bncs5EabpRDGlv2JGWdU=
X-Google-Smtp-Source: ABdhPJxEkZKfCXZNxGovVdsdLGGCiUn3lOCAIEVP6qJZiadlOHDLrbw/GdTXxmtsOEmPZLmWvLagAQ==
X-Received: by 2002:a2e:910c:: with SMTP id m12mr10356326ljg.332.1592875299285;
        Mon, 22 Jun 2020 18:21:39 -0700 (PDT)
Received: from [192.168.10.34] ([178.150.133.249])
        by smtp.gmail.com with ESMTPSA id l16sm3795745lfg.2.2020.06.22.18.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 18:21:38 -0700 (PDT)
Subject: Re: [PATCH] isofs: fix High Sierra dirent flag accesses
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Egor Chelak <egor.chelak@gmail.com>
References: <20200621040817.3388-1-egor.chelak@gmail.com>
 <20200622212245.GC21350@casper.infradead.org>
From:   Egor Chelak <egor.chelak@gmail.com>
Message-ID: <71f6cef7-f392-e1ba-1e79-2b767d2cff15@gmail.com>
Date:   Tue, 23 Jun 2020 04:21:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200622212245.GC21350@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/23/2020 12:22 AM, Matthew Wilcox wrote:
> It's been about 22 years since I contributed the patch which added
> support for the Acorn extensions ;-)  But I'm pretty sure that it's not
> possible to have an Acorn CD-ROM that is also an HSF CD-ROM.  That is,
> all Acorn formatted CD-ROMs are ISO-9660 compatible.  So I think this
> chunk of the patch is not required.

I couldn't find any info on Acorn extensions online, so I wasn't sure if
they were mutually exclusive or not, and fixed it there too, just to be
safe. Still, even though it won't be needed in practice, I think it's
better to access the flags in the same way everywhere. Having the same
field accessed differently in different places raises the question "why
it's done differently here?". If we go that way, at the very least there
should be an explanatory comment saying HSF+Acorn is an impossible
combination, and perhaps some logic to prevent HSF discs from mounting
with -o map=acorn. Just leaving it be doesn't seem like a clean
solution.

On 6/23/2020 12:31 AM, Matthew Wilcox wrote:
> Also, ew.  Why on earth do we do 'de->flags[-sbi->s_high_sierra]'?
> I'm surprised we don't have any tools that warn about references outside
> an array.  I would do this as ...
> 
> static inline u8 de_flags(struct isofs_sb_info *sbi,
> 		struct iso_directory_record *de)
> {
> 	if (sbi->s_high_sierra)
> 		return de->date[6];
> 	return de->flags;
> }
I would do something like that, but for this patch I'm just trying to do
a simple bugfix. The isofs code definitely needs a clean up, and perhaps
I'll do it in a future patch. I haven't submitted a patch before, so I
want to start with something simple and uncontroversial, while I learn
the process. :-)
