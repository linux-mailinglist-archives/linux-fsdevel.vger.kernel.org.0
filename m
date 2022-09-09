Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADC05B417E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 23:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiIIVeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 17:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiIIVee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:34:34 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE2865B6
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 14:34:28 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q63so2726497pga.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Sep 2022 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=32RKuQk21ut6+KAUx33F1+gsJh+klfpdgDVand8UaUY=;
        b=J6IxD7L7SZ4AKh9XtSi8eh8Jx+8cegZUiSYmvebzo/SCXpDkI4leU+G088tW5UxyH2
         TOgZilOPz8NSHWBm5sC2bZBL90HQ/f0MUxSvD0c4d+RiD1OzERYWYJM+BA5FsHysAoL/
         gE5wODosEq+1Aq6kpfxRdvOttRfFVTQbdE2mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=32RKuQk21ut6+KAUx33F1+gsJh+klfpdgDVand8UaUY=;
        b=mNwDWCIZ4T5VKDuKwDleCtEy5jKRhtfoKgjL999mEOVgo1ImEJvgWoQaGq/hx1I952
         kBr+3CWr2gP1J7405ovo7qSdtIL3HaRZt+VtCpAYrnX3mLY+aQRFENrE+AfPJJFSSWlZ
         Pi2GgMPAQffJQt7UlX2ADjDhNa42g9Ru8tC+d8zYb0j98+LTdrVJPTcnIzlqufw2J6Sg
         g9p3BSz+/8uR+sT6ya26OFGm1/cWoG6YDgJVOEB830VnzTJY+0BejSl9rxTKVVEvCgel
         kmaipjubOC7/+trMhzdTK51UT9C5fHv7Z1xq4StolxhgLMQmBsM17iRaUjiQ3mgpf/k6
         DMEQ==
X-Gm-Message-State: ACgBeo1nZ+Ok8OCUPbIMJTTjCyg39PuqRf/wuQ4G+cwMxicooYPySwxx
        NMxlg5c23VymLOMHUeTmCqpoZg==
X-Google-Smtp-Source: AA6agR4MrzUXBLxlI8FMdz+81a18JRGoiLJstTSYWOLWPZB6bw3JAP0uUwjrMYvdUZm9UO87zhTJgQ==
X-Received: by 2002:a65:60c5:0:b0:434:e149:6745 with SMTP id r5-20020a6560c5000000b00434e1496745mr14253221pgv.30.1662759268324;
        Fri, 09 Sep 2022 14:34:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f196-20020a6238cd000000b00540de61c967sm182116pfa.201.2022.09.09.14.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:34:27 -0700 (PDT)
Date:   Fri, 9 Sep 2022 14:34:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florian Mayer <fmayer@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] Add sicode to /proc/<PID>/stat.
Message-ID: <202209091432.5FEEE461F7@keescook>
References: <20220909180617.374238-1-fmayer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909180617.374238-1-fmayer@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 11:06:17AM -0700, Florian Mayer wrote:
> In order to enable additional debugging features, Android init needs a
> way to distinguish MTE-related SEGVs (with si_code of SEGV_MTEAERR)
> from other SEGVs. This is not possible with current APIs, neither by
> the existing information in /proc/<pid>/stat, nor via waitpid.

Normally no changes are made to "stat" any more. New additions are made
to "status" instead. Could it live there instead?

-Kees

-- 
Kees Cook
