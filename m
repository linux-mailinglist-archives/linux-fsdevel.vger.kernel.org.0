Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8F14D3C4C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 22:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbiCIVq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 16:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiCIVq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:46:57 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99D211E3C6
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 13:45:57 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so3503198pju.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 13:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mPFui/TC4p7dUMGtLGBbKQqrKx8zpb9vShIPpsPuML0=;
        b=FmgcSQxVPwrzTwKji9hdLnY25RfMT5VN3wweJFejAkZ0PU/llBS2Mj92/mxkiD0k1Q
         fGqieS5x/sut7UaTSPDGpdEbZo5tqk1bGBuzatPFg669/ifbTvo/Nq6qKJ4wT1LpzFKD
         BtkmHn44ujtA5JrEtYiB96ImpO3jN3BKxPUT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mPFui/TC4p7dUMGtLGBbKQqrKx8zpb9vShIPpsPuML0=;
        b=u3QaBR+M2L3t9qCGy25q0rxrayZOO3D7azHpYZKIglMmg8squrywPOEq7usflFvs+I
         L9dUlSxHRg9yM1lVfG60Bjmob7KxQshRtxHbg+x+x0PvIm8xxT1rzxQ6GWB9nN0TVLSb
         fIyemyGY2VL2WswznqvU2Oni/3UbXjp4tlZjXn+8VfZkn07psE9GgQjYtMfDJOQU3Kq3
         mNe/atlKqGWwUstFxs6fRGsMAg5bAORktXxOKLq1srnXpZeF/+SvOuOJ9bTadIY5Zw49
         mHoOcNmJCmb5wW7qOAenANP/m/0HHSMw/oafaVuNIf63OuKoNdRwjFf+mIi5Qt8y8Rh+
         U72Q==
X-Gm-Message-State: AOAM533Gcy2qKii9XBCf9qeHT4Gq82RDzTXOcr5KcZFqEN4ntQU8/gwX
        DNV1ipXQae9ohvBuG41wYcGaOQ==
X-Google-Smtp-Source: ABdhPJwDRr6oG/QAYJFcQdhhQndZU1FMOLkHHmjqOI2A1WXaXvUT/5Af1bNdMhR36WjvO4tYRhinzw==
X-Received: by 2002:a17:903:4a:b0:151:be09:3de9 with SMTP id l10-20020a170903004a00b00151be093de9mr1624286pla.138.1646862357242;
        Wed, 09 Mar 2022 13:45:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h6-20020a636c06000000b00363a2533b17sm3247890pgc.8.2022.03.09.13.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:45:56 -0800 (PST)
Date:   Wed, 9 Mar 2022 13:45:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org
Subject: Re: [GIT PULL] Fix fill_files_note
Message-ID: <202203091345.3755C2B5@keescook>
References: <YfgKw5z2uswzMVRQ@casper.infradead.org>
 <877dafq3bw.fsf@email.froward.int.ebiederm.org>
 <YfgPwPvopO1aqcVC@casper.infradead.org>
 <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
 <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
 <87h788fdaw.fsf_-_@email.froward.int.ebiederm.org>
 <202203081342.1924AD9@keescook>
 <877d93dr8p.fsf@email.froward.int.ebiederm.org>
 <202203090830.7E971BD6C@keescook>
 <8735jqdg84.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735jqdg84.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 09, 2022 at 02:27:07PM -0600, Eric W. Biederman wrote:
> It turns out I missed a crazy corner case of binfmt_flat, when coredumps
> are disabled.  This fixes a compile error that was reported.
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git coredump-vma-snapshot-fix-for-v5.18
>    HEAD: f833116ad2c3eabf9c739946170e07825cca67ed coredump: Don't compile flat_core_dump when coredumps are disabled
> 
> Can you include this as well.

Thanks! Pulled and pushed out.

-- 
Kees Cook
