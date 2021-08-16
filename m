Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5B63ECD3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 05:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhHPDY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 23:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhHPDY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:24:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A50C061764;
        Sun, 15 Aug 2021 20:23:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g13so31608161lfj.12;
        Sun, 15 Aug 2021 20:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B07EO9ccjm4sJBL35vstmYWtRuMt5BN5atqWj1gYKMU=;
        b=VqcjzqMxg1JPoSOTGNdjSrYRyiutl2kQvwGxfG+Ol6L6WmrZwSwBNyoRd8n+eDhW3p
         nel5nQc2YicEsmVIKf6g5SkB/LPRluLWskJxvLNvSVoFGDMwm8G2aCmZoCaCvWZEQt+Y
         olHiwffAQ1QZ23zbm324s+nFES/bE28kQlzlxF9z6srU+gqgHTL0043e7FUImLIgn+Bk
         fdUoxEwvMyx17GSX0tI3wmSGuMnzjC6LhERdVFcsPfK/4GVml2tuwtp+IjlG9NPsjraf
         x3znroqMtvQt147OrQv/7v/rupL1JS1d99nG3RZrOd/6/+rIVTNDDZEJ1A/ZNFLHxTtG
         mSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B07EO9ccjm4sJBL35vstmYWtRuMt5BN5atqWj1gYKMU=;
        b=dChCdrvOr7FDLSxEC7qnGYQ6Ww3dvPwRYGCShnLqUSBEK7ffN3nxA0B/P+Et120qJu
         s24jD815fQZA3gTzhrt9HA06g9tNwHgoumHs8zoPGs7Q/toqrlmLR1bYr+28KFZXONX5
         CC+lND3vWKxcXMkXA/lS0VRbpcm/IMVrIyuyjaY6JV9Lg48Gipd5T969e2gLO6AQD1z7
         3JoXzGG6JeRxLlOb3ZMJoj9cFsSTAxq38TACC84WOzk4RFUYERDDT81FxAXIMHPGrv2q
         u9nFIyh/RbBXu1AFMgYSCoV+hB9fyP0090dLz+ZZ82pCHUIKB+SK1W2oGQVmRFcymYzA
         rehw==
X-Gm-Message-State: AOAM5331dqu0JRHPdzXzBhPUqjgipiEhxkV8eRRysMbKXAZx/0IAGIm2
        1WtxlHODEfTaYKXChy2eX6E=
X-Google-Smtp-Source: ABdhPJz0J4cOcTPGA3nDyS9oOLzAi7k0UQFfwJxLcWmK7DYwHWCwWBChv2k3p6hmRSguRF20gGuKHw==
X-Received: by 2002:ac2:562b:: with SMTP id b11mr8527015lff.586.1629084233942;
        Sun, 15 Aug 2021 20:23:53 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id o20sm821249lfu.148.2021.08.15.20.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 20:23:53 -0700 (PDT)
Date:   Mon, 16 Aug 2021 06:23:51 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 1/4] fs/ntfs3: Use new api for mounting
Message-ID: <20210816032351.yo7lkfrwsio3qvjw@kari-VirtualBox>
References: <20210816024703.107251-1-kari.argillander@gmail.com>
 <20210816024703.107251-2-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816024703.107251-2-kari.argillander@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 05:47:00AM +0300, Kari Argillander wrote:
> We have now new mount api as described in Documentation/filesystems. We
> should use it as it gives us some benefits which are desribed here
> https://lore.kernel.org/linux-fsdevel/159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk/
> 
> Nls loading is changed a little bit because new api not have default
> optioni for mount parameters. So we need to load nls table before and
> change that if user specifie someting else.
> 
> Also try to use fsparam_flag_no as much as possible. This is just nice
> little touch and is not mandatory but it should not make any harm. It
> is just convenient that we can use example acl/noacl mount options.
 
I would like that if someone can comment can we do reconfigure so that
we change mount options? Can we example change iocharset and be ok after
that? I have look some other fs drivers and in my eyes it seems to be
quite random if driver should let reconfigure all parameters. Right now
code is that we can reconfigure every mount parameter but I do not know
if this is right call.

