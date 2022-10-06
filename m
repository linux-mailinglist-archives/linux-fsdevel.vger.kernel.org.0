Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD55F71ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 01:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiJFXiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 19:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiJFXhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:37:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2121429AB
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 16:37:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f23so3080946plr.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 16:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=6w++0UYRYYRcY+xx88ScArCTi1ipokn2/JlIBlSrGmg=;
        b=I2sser8aNPvcfMiVuDPWGoxmgCp7DUUWz+lY5XubZaSgKyPyJO7lKNPi+YrtKb6In+
         MY72dEXIA0tlPsd3/FejBOJQaWzxggqqmaaBikFpwR/LDI8rCiTlzWI0RBrhUSGzz6kT
         nt6sBegoG/UXYUwCbj5bTLCJlXzpFnFLO3AqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6w++0UYRYYRcY+xx88ScArCTi1ipokn2/JlIBlSrGmg=;
        b=aVP7L1pQCWOUd13Q+xxHGVDaA24PCIHeuIi0e1pE1e7uFAbHU7HB22VYLiwAJAAs8u
         OwZS8pT5IctXlVU14OYU2+pBjEobfK8EiQYKNnKYpGyvf8qZcu7vGfMkP42ZY3HvwF+J
         TduEHyqWKiNNUscSUNxiY/SJjspFDcYXMlC6Gz7K+y2ww2EP4R1/gP+Cy4tcufs12a1+
         wwwwhzsRvFxEvtnbNAufhcz+PHlPAzQ3KavnHusuxjpfgWsnNVASVSyzoRqWWxiBe3s/
         p+r0JYjDE/TVESgeyYS6sVu+3WK/s+KzqJp4EFMeLl4rz9rXU2iaJBlcNAeTpUg0yQiF
         5QXA==
X-Gm-Message-State: ACrzQf1kiAjBAEH9PjqlVjw1sS1QtLUQtGNxT+rnrQdWPDw8yI6ING36
        x2ci0/OzVau4exdO8YDrUO5wjg==
X-Google-Smtp-Source: AMsMyM4kDL5a/Dlffn01IBeDnGXhq0ef/rGYfpdZb7ToB+kR3GWSyeZrgAkAjBhjrLrJaZuY+1T3qg==
X-Received: by 2002:a17:903:3113:b0:17f:6846:6266 with SMTP id w19-20020a170903311300b0017f68466266mr1891369plc.150.1665099461056;
        Thu, 06 Oct 2022 16:37:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b203-20020a621bd4000000b0056186e8b29esm180665pfb.96.2022.10.06.16.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:37:40 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:37:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>
Subject: Re: [PATCH 6/8] MAINTAINERS: Add a mailing-list for the pstore
 infrastructure
Message-ID: <202210061637.8C09C55@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-7-gpiccoli@igalia.com>
 <202210061616.9C5054674A@keescook>
 <SJ1PR11MB6083D102B0BF57F3E083A004FC5C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083D102B0BF57F3E083A004FC5C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 11:29:02PM +0000, Luck, Tony wrote:
> > Tony, I see your recent responses, but if you'd rather not be bothered
> > by pstore stuff any more, please let me know. :)
> 
> Kees,
> 
> Occasionally something catches my eye ... but in general I'm not looking at
> pstore patches. You can drop me from the MAINTAINERS file.

Do you mind if I leave you? It's nice to have extra eyes on it when it
does happen! :)

-- 
Kees Cook
