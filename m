Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7D14BE271
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 18:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377321AbiBUOK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 09:10:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377319AbiBUOKW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:10:22 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8781EAC3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 06:09:58 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id u10so17651368vsu.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 06:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7+WcxmhaLYcJ+8pluGn0/oWg/SAXibHCywaoZcD3M+k=;
        b=CUb60dhdXmw4ncFzQuHXXsgnJnX7JNIF197o+EN3b+b+wyYQ8vLLr9cBpaBOgj3r/s
         NgoyMjGyrv5Uy1jX0NoFJbsjmJMCGppdOlovWoHRdlnDd7V9ZNKCGYQXtAhhOOjxr5La
         MeRZzs42F1R6QyzbMaOXRm1lp+qh/ZL4znWP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+WcxmhaLYcJ+8pluGn0/oWg/SAXibHCywaoZcD3M+k=;
        b=qr2MzGNDkXvXhwLsECty8tRWJunWdKVTP1pi5EKGmkbXoQfc5meRSAFo9o+VDPqoao
         JFtiDSa+FL0yW+p8oUllHnupip4WaDlihZ0sL5QRzdLJ6atCXIL0ZRaSjieu/YtdHqa/
         +xRYl/V6yfIE+O5xtL/BwBt0l8ECfx9BpdACwdZovVQxTH3Yase48uFbXJHl0Ma8dWce
         BS+X2MoUn8UQPwvxOX7ePEUu9NaDRo/7uxPkYqkcDw01xpiVqJdHXNUNiBqahuyPrZOk
         dUw0lEMuhNtQG5erWYF4lZFgwfCYocNE4/rDOdZl+iFF9yl8jtVS3bWUm9ZzuT+XYYTP
         Kwyg==
X-Gm-Message-State: AOAM533aWjX9Sn45Naxtc1etZU5Yz5mNM6hEqtI9qs+iPla/vqU+uqvZ
        /MJY7Clz8bNyR72BRRoP1T00eL7DGog8PW43nFo0Cw==
X-Google-Smtp-Source: ABdhPJyQMpd7yYaTSY0oqRBS+NVBJD9xwwqBnymrxaPZ/UfchwBdEYzHUvnV66r3tYDpNqKJHCvEr7U1+zqYVkjcrQQ=
X-Received: by 2002:a05:6102:15ac:b0:31b:fc94:f0de with SMTP id
 g44-20020a05610215ac00b0031bfc94f0demr6436149vsv.48.1645452598020; Mon, 21
 Feb 2022 06:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20220110235252.138931-1-jlayton@kernel.org>
In-Reply-To: <20220110235252.138931-1-jlayton@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Feb 2022 15:09:47 +0100
Message-ID: <CAJfpegswypcKcFAk3+wvJ9xg098Nik02_dT1PLUnsRRLdmrZSg@mail.gmail.com>
Subject: Re: [PATCH] fuse: move FUSE_SUPER_MAGIC definition to magic.h
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Jan 2022 at 00:52, Jeff Layton <jlayton@kernel.org> wrote:
>
> ...to help userland apps that need to identify FUSE mounts.

Thanks, applied.

Miklos
