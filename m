Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD4C2DC4C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 17:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgLPQzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 11:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgLPQzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:55:53 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4C4C061794
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 08:55:13 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n16so2317840wmc.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 08:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nYWHrbVbxSSL2gimdMuStJvoiPGVcobkaLSqY1apiew=;
        b=GwZllGkI6HrzePUJDJoMJ5E1CVxjLK6R2rRucQJtAPMWHPuWAtFjooNIk/FDZ3R0P/
         qe+ZHKPCGQP/FZ1zHBP3kusq3Cv23IqmZ3l4jD97AGoQye9QwrGSycW7GdzeaKp2YUQD
         lHCRsjpDZvWWmn10SROnQOF6eu/kdzKmCJCc0BsFNffLELNlBvFLRfKKtxucyr47EwC2
         eXGyB5NgoiotvBmuAsHRl4bjl/XSXyCYU+mdnmyNFvhmQDjmSgShonDXUg4vEVSii8ST
         I4Hm3UNTWZMHZ6pkQ5MojdLKYW++ywIcmQP5tPy3JoR9hBQs6fc+FeInjsSIZMuwC5ve
         AEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nYWHrbVbxSSL2gimdMuStJvoiPGVcobkaLSqY1apiew=;
        b=RPPHKpFy4JJpE5xocgnU19KttJmmy+7OoUcXfjPtuGebp+7RAYTuo/A1xGFc1j4hry
         Db79mO4jUl684o6W7IIv6fl/f9g2R/PpHRCvHcws8fqK4+ktl3H7+vBBHHOCAocCdUz4
         Y7pfWiM1ju7xCrKlu7dJSZ3I7VrvsgUM2wKkkwe+ZsJtaG1hQEQG47UHDtFHZ3JhOtkL
         hLfJgdBknTGUDBS2qtR4mnExXH+7VxVN64bEBDovn1Rv+Gf6300BsfTp2PgY71uC+Coq
         LBbzOogwzRpXnarT5FFl1AsPK2f0e/uX3MCYwWA15WaFR8VFaHwxXQ0h2nTaIfGUNJSG
         VPiw==
X-Gm-Message-State: AOAM5309UFG5HqpZb8xL88PkVVIqm6a7OI+XmMApMvU9r6u8Di67gG6b
        zmSJojo02+6hb+5GuPvUeKOp4g==
X-Google-Smtp-Source: ABdhPJzjFllBtwtnU06LpZi8JepRVnRWoVkcD3APzeffiW53enUJeEPKnt6/1RNgwqAmgGUAOYTUZA==
X-Received: by 2002:a7b:ce14:: with SMTP id m20mr4252720wmc.149.1608137712145;
        Wed, 16 Dec 2020 08:55:12 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id j9sm4605998wrc.63.2020.12.16.08.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:55:11 -0800 (PST)
Date:   Wed, 16 Dec 2020 16:55:10 +0000
From:   Alessio Balsini <balsini@android.com>
To:     "wu-yan@tcl.com" <wu-yan@tcl.com>
Cc:     balsini@android.com, akailash@google.com, amir73il@gmail.com,
        axboe@kernel.dk, duostefano93@gmail.com, dvander@google.com,
        fuse-devel@lists.sourceforge.net, gscrivan@redhat.com,
        jannh@google.com, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, miklos@szeredi.hu, palmer@dabbelt.com,
        paullawrence@google.com, trapexit@spawn.link, zezeozue@google.com
Subject: Re: [PATCH V10 2/5] fuse: Passthrough initialization and release
Message-ID: <X9o77i1T4PDgm4q4@google.com>
References: <20201026125016.1905945-3-balsini@android.com>
 <3bf58b6f-c7eb-7baa-384d-ae0830d8bceb@tcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf58b6f-c7eb-7baa-384d-ae0830d8bceb@tcl.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 09:32:51PM +0800, wu-yan@tcl.com wrote:
> Hi Alessio,
> 
> It may cause file reference counter leak in fuse_passthrough_open. If the
> passthrough_filp
> 
> not implement read_iter/write_iter or passthrough struct allocated failed,
> the reference counter get in fget(pro->fd) not released and cause leak.
> 
> Cheers,
> 
> yanwu
> 


Hi yanwu,

Nice catch, this bug was introduced in v10 and will be fixed in the next
patch set.

Cheers,
Alessio
