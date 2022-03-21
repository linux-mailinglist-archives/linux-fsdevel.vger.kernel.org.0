Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CE54E1EF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 03:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbiCUCIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Mar 2022 22:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344138AbiCUCIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:08:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A946654F9C
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Mar 2022 19:07:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e6so9299623pgn.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Mar 2022 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2dJnNJv7tm7UdVVNql3/erHAUxpmpE++s8tQq8p65Yc=;
        b=mu/10eV1z+dHYGAsdcf9q8Aabh+EEP6gv8Zlf8rKwMJHk9e89FS7GS5uLHgRyQrQW4
         Ct/aNefRA3L4NHnVFXVksmW8dLFKvbTMZSYFPPDYxCwUmCcBUy8FQqXo4jU9aW4O5LNL
         G28HpkWyi5RSqomgMMNT5F65J/9pb9x4mvI9Wvk56nFgf0OvB1Xmou9y4oC1KoySzTmP
         o1EFEcERaW48bE/dogVZvCPvtDIYtQlGmwXIvgcBrAcCa2S4WwnGd2ktgy+Dxb2oLNsb
         uRmu8RLWe9yXUp7yoSeuMNWDpyCHoI1pgWpwFayu8/g4yEia74hMkvsOmUIm05MsRg2z
         B6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2dJnNJv7tm7UdVVNql3/erHAUxpmpE++s8tQq8p65Yc=;
        b=3a3WK3u5vYBTmMy/LFG09Np2R3U0Iq6UKQfR6zJQRSIgN0OcQ7JnUPKWFkzCao7zM4
         fUXfyWI64Un4vCFBCsntZezjn0YaDMjXc1DkhoEbn3+Uz2vnDhAvoQjJQoo4JKIKsfwx
         WbgbQJmaCjBPcPS6MZJTfoNehd+OA0hdiNJIedslXXjqQa1VRRCwP+uBkcBxiieLF7Lf
         mbbpO44JhL+lhMeXURz9RPamWC5MocQXXZUaIh+XfcifUjY3Sy9XJhRF58T1HYDLPXbe
         +RLDnmFLFHV+BwarbJJQBK1OZ/73/gLn+JeB7N5WADBAuKw54yLloZ67eqYOKrBsEyUX
         ozmg==
X-Gm-Message-State: AOAM5320Srf3Ksuwrt1Kd4Sy7qARD12SL5Zwp22yFvv0ECsDxp/ungWG
        AROQyeuNiK25Y2otE9DhZgbPAw==
X-Google-Smtp-Source: ABdhPJzq6K073T30dDUYD8wJP7MMTAw+cUTD/IS/UWpKHIhyrTvuoP/jdZkYeB94PcZPbbr/gShQEg==
X-Received: by 2002:a65:6202:0:b0:382:1fbd:5bb3 with SMTP id d2-20020a656202000000b003821fbd5bb3mr13319263pgv.194.1647828443928;
        Sun, 20 Mar 2022 19:07:23 -0700 (PDT)
Received: from google.com (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a000cc900b004f7a986fc78sm17867328pfv.11.2022.03.20.19.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 19:07:23 -0700 (PDT)
Date:   Mon, 21 Mar 2022 02:07:19 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alessio Balsini <balsini@android.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix integer type usage in uapi header
Message-ID: <Yjfd1+k83U+meSbi@google.com>
References: <20220318171405.2728855-1-cmllamas@google.com>
 <CAJfpegsT6BO5P122wrKbni3qFkyHuq_0Qq4ibr05_SOa7gfvcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsT6BO5P122wrKbni3qFkyHuq_0Qq4ibr05_SOa7gfvcw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 08:24:55PM +0100, Miklos Szeredi wrote:
> On Fri, 18 Mar 2022 at 18:14, Carlos Llamas <cmllamas@google.com> wrote:
> >
> > Kernel uapi headers are supposed to use __[us]{8,16,32,64} defined by
> > <linux/types.h> instead of 'uint32_t' and similar. This patch changes
> > all the definitions in this header to use the correct type. Previous
> > discussion of this topic can be found here:
> >
> >   https://lkml.org/lkml/2019/6/5/18
> 
> This is effectively a revert of these two commits:
> 
> 4c82456eeb4d ("fuse: fix type definitions in uapi header")
> 7e98d53086d1 ("Synchronize fuse header with one used in library")
> 
> And so we've gone full circle and back to having to modify the header
> to be usable in the cross platform library...
> 
> And also made lots of churn for what reason exactly?

There are currently only two uapi headers making use of C99 types and
one is <linux/fuse.h>. This approach results in different typedefs being
selected when compiling for userspace vs the kernel. Plus only __u32 and
similar types align with the coding style as described in 5(e).

Yet, there is still the cross platform concern you mention. I think the
best way to accommodate this while still conforming with the __u32 types
is to follow something similar to 1a95916f5465 ("drm: Add compatibility
#ifdefs for *BSD"). Basically doing this:

  #if defined(__KERNEL__) || defined(__linux__)
  #include <linux/types.h>
  #else
  #include <stdint.h>
  typedef uint16_t __u16;
  typedef int32_t  __s32;
  typedef uint32_t __u32;
  typedef int64_t  __s64;
  typedef uint64_t __u64;
  #endif

This alternative selects the correct uapi types for both __KERNEL__ and
__linux__ cases which is the main goal of this patch and it's just minor
fixes from 7e98d53086d1 ("Synchronize header with one used in library").

I see there where previous attempts to address similar changes here:
  https://lkml.org/lkml/2013/3/11/620
  https://lkml.org/lkml/2013/4/15/487

So, if you agree with the approach above I'd be happy to send a separate
patch on top to address the *BSD compatibility.

Thanks,
Carlos Llamas
