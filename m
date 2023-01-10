Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94E76647F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 18:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjAJR7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 12:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbjAJR60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:58:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717352F4;
        Tue, 10 Jan 2023 09:58:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id az20so11690165ejc.1;
        Tue, 10 Jan 2023 09:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9Zu5tLDoswvPcS8TjPw+hiLhOqYPhHzrH0Ze+KXTHE=;
        b=ir+hPtJWqNvJg2azZcfdTpTdLMft4EfLi3D/YJMTBZL5dZj6uSAAnjTI/UC1p/lVpn
         0uuzXG1rb5PuEslf7UTLdXldfkmVAXQNA0aHEvNfGSh39+xjEhLWHnfzkpZsdfLdqehv
         qIfD8BHfElgRDMH4VD3ufGRJid7On/aXea0FbqW2M5xwSin2epMZ3oan9qaGZ9ir9JW2
         2l3u2NDZpSdf1mY/izm+gj+Z7uqt4ZRaIRuUY0BfO9Qba5bvlOEeWmrSIrLiHM1qhr3S
         l0hqSNtZbrSEusMxw0AyXNjqt8wMf1+9XdYb7cohGUnU6KjDr1dUp3GOItzBGpTxnpz1
         AwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9Zu5tLDoswvPcS8TjPw+hiLhOqYPhHzrH0Ze+KXTHE=;
        b=xpdIPCu5LY09hgqm+1CbImqa9yuBcjIXqPzO+3nLSYWLKZJr+KkVPKSc2Yk1XvESXG
         IqW6LNMomfkb0AsTazyNJfR45s1a7qBdi3LM6eB/kHHVoEmbwW7LuR7C3z9ESgR/+pnt
         c3yL1lVuHWXhtIVQBiVlui6UfJP9HrOmulpv+YyevgGUiEEr12Ol+h8yhavsDhhXqBI+
         kmafj9dUJ25D7Fc+0FkHITL2SMtsMOB5PbZelWtJcAZnzZ8jztSUD1nSAgS+9pWg5BR5
         0OGPnFJX6KbDCytFy2K3JfNiDAgXTQn/O8U2qr1KrFsfQ8F3dVrtTpMw89M58uKWVqM7
         J0Yw==
X-Gm-Message-State: AFqh2ko112437ruonv3rfJBACXPwEubffxsHMCsp5en/QOpFVtykg/qV
        dCd2TP54BxCNPIQ/mT437g==
X-Google-Smtp-Source: AMrXdXsnzetjBs5dJe3By+UOQeym9Cl+cBzo98QZrZgsFypNtlZmuXpN2HWRBBU9rD5ylAqPLsA3yw==
X-Received: by 2002:a17:906:1414:b0:78d:f455:b5dd with SMTP id p20-20020a170906141400b0078df455b5ddmr54306349ejc.29.1673373503966;
        Tue, 10 Jan 2023 09:58:23 -0800 (PST)
Received: from p183 ([46.53.249.174])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090699ca00b0084d43100f19sm3223324ejn.89.2023.01.10.09.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 09:58:23 -0800 (PST)
Date:   Tue, 10 Jan 2023 20:58:21 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Chao Yu <chao@kernel.org>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: introduce proc_statfs()
Message-ID: <Y72nPcDDC/+10lYK@p183>
References: <20230110152003.1118777-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230110152003.1118777-1-chao@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 11:20:03PM +0800, Chao Yu wrote:
> Introduce proc_statfs() to replace simple_statfs(), so that
> f_bsize queried from statfs() can be consistent w/ the value we
> set in s_blocksize.
> 
> stat -f /proc/
> 
> Before:
>     ID: 0        Namelen: 255     Type: proc
> Block size: 4096       Fundamental block size: 4096
> Blocks: Total: 0          Free: 0          Available: 0
> Inodes: Total: 0          Free: 0
> 
> After:
>     ID: 0        Namelen: 255     Type: proc
> Block size: 1024       Fundamental block size: 1024
> Blocks: Total: 0          Free: 0          Available: 0
> Inodes: Total: 0          Free: 0

4096 is better value is in fact.

seq_files allocate 1 page and fill it, therefore reading less than
PAGE_SIZE from /proc is mostly waste of syscalls.

I doubt anything uses f_bsize.

BTW this patch is not self contained.
