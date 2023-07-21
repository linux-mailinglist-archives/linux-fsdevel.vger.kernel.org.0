Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5979975D0D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 19:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGURnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 13:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGURnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:43:43 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 10:43:42 PDT
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE7830D4;
        Fri, 21 Jul 2023 10:43:42 -0700 (PDT)
Message-ID: <ebe13d43277d359ae5ce16008930ad13.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1689961020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jP3d4dLAhEr5YGUt5O/pDyHaoVHiSJ5pzZ5OSQvfyAc=;
        b=FsaZbGpEOuGeCEDro2svNKJe4ezK3tUVOzcztxbAFRmoOlNYQM2tbAc/s6CSNRgQaSLVEt
        GspEkrGXJU1cYV9K48kWMFSHN/47d1d0w8/+DgO8DKrrS7sjGjyRrem0wtv6mJ5uFhIVMK
        0Kk+zO283WH0MRt5wiJgYvCeJdbOM1P/a+9yYb8OuD/bzJtupF3EaCZtyR4BRibJ/w7+L0
        GpF7aduEsf2lUoZICerRkuQ5r6ccIGdMIOKUJ+oq1kI24AHctGoUSfNOaqBX6B3aQhlcs9
        NKFT13MGgB8+T5GgFkAqr0VkqEI2RnhUdV/b8WtIvvgITK8+ccZ44tbelQ7ukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1689961020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jP3d4dLAhEr5YGUt5O/pDyHaoVHiSJ5pzZ5OSQvfyAc=;
        b=a2di3gIX8cKhMLkfU29EuhbzyKQF/vbAEBV4bHvs61G93xpKF+i6EX99mJCfJ2nr6/fhTA
        egpH85fJXPVIIOPW/8EbxG0R0+lbYfSh/5/JDLHv2Xoi6eA+qgSJnMCUEkzuiZlhg5H/sb
        ueiqmZV2ApbzZrisrQzV5SvjcadzriUb/b0h82WqaF9gi6HyOlkU1KGa3eWXaFQMiOTEVo
        tORol88rD+1WejYWOfhVNhSwLlX1d+BeMiMc5bJO+c/HBMSB/mIFkck5cxRbozZjoej7kB
        fwldb+LMU8UqPIpSTtLvCrbyEULBN1vrL9ld/kmNBDPHlbu3I+k+P4NyQI6akQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1689961020; a=rsa-sha256;
        cv=none;
        b=mr/ki46je9/9agoe289Mj+uszY6As+Kg3FTcwYED6FNnGFhoXnsXN/zWcAJbehoRz9Sod8
        xUpjZxtE/nCx62CA11PqB0YyScc6whx5Cou/d6u4UkekgBdGcSXSzGfdVTMhXDAnZ+Ajd4
        RzN7CJqcMKq+GIH9CIgqXBfTtPfwNoLaSRDRLiuAs5Pn6Ltp/iDpECFrMiClm8/ZTRKG4W
        H3sbeX2Jg3VIclbUJpCzsvU1DokzaIJq/oAwx0ZfBoy3nc+bRS6zzI8GRZ+Iqz267VQKEA
        I9sRVDGOObpp6AOVEIPk1uLiOjGtgG7g7rLh6nE11srGUjKGLsfr/io1PbvNNw==
From:   Paulo Alcantara <pc@manguebit.com>
To:     Winston Wen <wentao@uniontech.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Winston Wen <wentao@uniontech.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] fs/nls: make load_nls() take a const parameter
In-Reply-To: <20230720063414.2546451-1-wentao@uniontech.com>
References: <20230720063414.2546451-1-wentao@uniontech.com>
Date:   Fri, 21 Jul 2023 14:36:54 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Winston Wen <wentao@uniontech.com> writes:

> load_nls() take a char * parameter, use it to find nls module in list or
> construct the module name to load it.
>
> This change make load_nls() take a const parameter, so we don't need do
> some cast like this:
>
>         ses->local_nls = load_nls((char *)ctx->local_nls->charset);
>
> Also remove the cast in cifs code.
>
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Winston Wen <wentao@uniontech.com>
> ---
>  fs/nls/nls_base.c       | 4 ++--
>  fs/smb/client/connect.c | 2 +-
>  include/linux/nls.h     | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Changes look good, however you should probably get rid of the cifs.ko
changes in this patch and for the cifs.ko one, you could resend without
the casts.
