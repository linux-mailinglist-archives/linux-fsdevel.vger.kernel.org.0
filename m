Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095F7A31C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 10:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfH3IDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 04:03:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55336 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfH3IDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:03:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id g207so2307325wmg.5;
        Fri, 30 Aug 2019 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vqg4+0qE9By32oVPvkVXl8z2qAEWRTcGM4ZUpT4P/yk=;
        b=imBf2A2SylOOCpkSfnUaZ0Yr/PohhWOJK7LTChewnYLurpeh9mvz6IYcdodAxfuIKb
         bqhyCO7siqbspw7/pOGRSjEpj6Jk6md0R2SCnRG4eAaS3YgJhk+axN9a3XTABiiBcZeX
         KDR/w2ZkkrE3AgMfZY+9ZcTokdTuS8lYk/cqZBAU4OV691WP8tZMDsVELuLJhvQlhvIx
         +ra1xGjptsW58EOHcWm5JNThztUTmjC38krTntvd2nP5XH+LN2Wc3DazKOvLijy1Jwr/
         Uxs4I4IAgtE18dlJtrk4UiNoWyVgZzwzkMPplSz67lxnR9dm9a9impUuwW4o6fCHIsbE
         /aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vqg4+0qE9By32oVPvkVXl8z2qAEWRTcGM4ZUpT4P/yk=;
        b=n0wEfkh5g6Ne995WWjYbs7S4/mFINcrSr/NI80RiSoXPyytIbgQ3MucynZ47PxzUZB
         6o3RwYuxJrFB6OkFV8vqozZTTdw2DjdcGxOW0WlCrh1jwllS5LNsLvZVd+77znLFrLGB
         mavA373k3FyTFqqAQeTB0adLbYMt21llvc4CNPYrbOQjfv1AsgmF/JaC+ntwWiJAR2Va
         n4/riUqLBS4lASJizs6m7kiAoCH4HmBFMk5E9qQedELod3yRHqAVwwanJW/ESiKoXlIJ
         fLjJXYdeykyKaJXaL/SJaQrDUSWMFyQ/+nto+uuLzXIk9fBOKNjAPjzyO9yZGk6h3dA5
         v3/g==
X-Gm-Message-State: APjAAAU9DJnLfW2O5KH4jAmApJIK4N632vS6Ms9PkPPInuFRcOFu4ouy
        tmy5iHUfCmJ6xEOGF8au34OLuRycSiM=
X-Google-Smtp-Source: APXvYqwptRw3grP98+iqcnu6j4w/z5h5jfty0Wj43zUc4O/9bA/1UWI/YKZI5QQqy5pg3XziQtS/8Q==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr16420917wmi.124.1567152184350;
        Fri, 30 Aug 2019 01:03:04 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id w125sm10551497wmg.32.2019.08.30.01.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Aug 2019 01:03:03 -0700 (PDT)
Date:   Fri, 30 Aug 2019 10:03:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190830080302.bgfosew4rzc4og67@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <184209.1567120696@turing-police>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 29 August 2019 19:18:16 Valdis Klētnieks wrote:
> On Thu, 29 Aug 2019 22:56:31 +0200, Pali Roh?r said:
> 
> > I'm not really sure if this exfat implementation is fully suitable for
> > mainline linux kernel.
> >
> > In my opinion, proper way should be to implement exFAT support into
> > existing fs/fat/ code instead of replacing whole vfat/msdosfs by this
> > new (now staging) fat implementation.
> 
> > In linux kernel we really do not need two different implementation of
> > VFAT32.
> 
> This patch however does have one major advantage over "patch vfat to
> support exfat" - which is that the patch exists.

I understand that this is advantage...

> If somebody comes forward with an actual "extend vfat to do exfat" patch,
> we should at that point have a discussion about relative merits....

... but is this advantage such big that it should be merged even due to
"horrible" code quality and lot of code/functionality duplication?
In similar way there should be discussion about these pros and cons.

-- 
Pali Rohár
pali.rohar@gmail.com
