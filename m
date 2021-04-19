Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EAE3645F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbhDSOXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 10:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbhDSOX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:23:29 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F686C061761
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 07:23:00 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n140so35560099oig.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iyPw3xh+gL8EO50n7ZD6mPQ3zLVc071KZQAVN27alq4=;
        b=FtmbvtYsxQWKv8/moQcb/7GviYq3dZg+O9iufhpYH2LGqDmMDZ7Us+2F8PZaa04+9x
         MJ6zYCobk+M2PaLqf8Z3E6LQIITVPBk99v5tk3fU4G3PoHOQpofdDuLAyrvTf7iB2AOO
         nfDKg9kwOqDee8htmIN1+KYoN6F+v74VCfVbEk+C28HEBuxaRU0c9yWTsD63xNVak5oc
         jBjevKajjelLcaDhNdk4+vR/zUt/TXEkDrKMEFZKI4J69JWIrMYJ43PUb6lEvs/nnCMo
         Bau0gIpvTicWrtOUElc1MqzQuNwRHVPhh29uWYOI3a5NqLXkwwQfDxHV5jMsqfMKKO+F
         xDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iyPw3xh+gL8EO50n7ZD6mPQ3zLVc071KZQAVN27alq4=;
        b=DrK8wsM0qHlNfYhP/NWU0Y+RB8AsYTdMfUn9Gy/KlF4cD62rEZaETPP9zVwtOSQdFK
         zUAxoJv8CsLHhv57MhkInkS/z48egALph5F4R1dj2Q+6w/F1s2uz/BOJpMIRkDLWK5YH
         /nDKZjQ5Gii2Vt8x7tzH7IvRTh+VVOpezXtnk/BnBgNj908+b8kE+7n/ZWmMoeLFpajn
         wxwxzvZK0/2/EGNXv6UajOtydu/fznTkyOnIy90U0wlZGA0c0XTlcNkibByKujJzjSs9
         gYTVhFmMFRXugicVwRwU5O6ACFB4rRpPPbGqAFlfEtMDYQQvN+qEe9bmZfhvPM1KOD1B
         oPwA==
X-Gm-Message-State: AOAM531nBPSIQUrPywnFFUSBDxlcov1FpETb1LS8ezqTGr2QrZuY4gkK
        yAYtSygAngpn8nGoln6LOk9KO1C2zLRakFSBbE0=
X-Google-Smtp-Source: ABdhPJyWEH8BBDYfxulF6pV3FbWQ/xWx5YXUB1CPYS8QjkHxSIPNH7IpXYsGakU/vg1FSd0GHdonUg==
X-Received: by 2002:aca:4d8b:: with SMTP id a133mr2280263oib.170.1618842179592;
        Mon, 19 Apr 2021 07:22:59 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id 39sm1900626otv.21.2021.04.19.07.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 07:22:59 -0700 (PDT)
Date:   Mon, 19 Apr 2021 09:22:58 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>, ecryptfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] ecryptfs: remove unused helpers
Message-ID: <20210419142258.GC4991@sequoia>
References: <20210409162422.1326565-1-brauner@kernel.org>
 <20210409162422.1326565-2-brauner@kernel.org>
 <20210419044850.GF398325@elm>
 <YH2KVPsPdSFMEhEY@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH2KVPsPdSFMEhEY@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-04-19 13:49:08, Al Viro wrote:
> On Sun, Apr 18, 2021 at 11:48:50PM -0500, Tyler Hicks wrote:
> > On 2021-04-09 18:24:20, Christian Brauner wrote:
> > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > 
> > > Remove two helpers that are unused.
> > > 
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Cc: Tyler Hicks <code@tyhicks.com>
> > > Cc: ecryptfs@vger.kernel.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > I'll pick this patch up now as it looks like it didn't make it into your
> > v2 of the port to private mounts. I'll review those patches separately.
> 
> FWIW, there's also a series in vfs.git #work.ecryptfs (posted Mar 20),
> and that, AFAICS, duplicates 483bc7e82ccfc in there...

Yeah, I noticed that after I pushed Christian's commit to my next
branch. I've fallen behind on eCryptfs patch review. :/

I plan to review vfs.git #work.ecryptfs in the next couple days. If
everything looks good, do you want me to take it via my tree or were you
planning on taking those yourself?

Tyler
