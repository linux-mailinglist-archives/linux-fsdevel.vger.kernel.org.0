Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E556571794C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 09:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbjEaH7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjEaH6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 03:58:39 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29A0E6C
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 00:58:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3980c92d8d6so3857366b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685519892; x=1688111892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=InhpvKQBhuZi3uizA3ONGCOh0jmtHn7qt+ZVuzjjuiM=;
        b=tZFMiYqPIJ9QsnTZJcGA5KXCQCUWewvMM43Y7tfBdI99FFxi2uHboFR+hz0rnURJZB
         95PrjmSLJGGkIDPf+IRCikfqpl43gHI9kLLwLtME4A7wROFwLuJk/BnMAG4/L2OYrDgx
         NgzYQrXI8j/ZIylhLq7sJoQnwJ29VxGfg1XUbjJUzqsMVkc0IYlfZyTfLv7v2WaU0amy
         1TkrfPAVkZkToPj/SYDbVyNxeEgzHyIkE8Lp1L9x1lO33UxMzyqQ+JzyA371s7rMeiAT
         P+1kaAVaYqmw1d2GwSjKAiDpBnmGcuUUo5Jw6jK5Hy5nOXQYWpSNShuJyOtnG42v15dV
         EXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519892; x=1688111892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InhpvKQBhuZi3uizA3ONGCOh0jmtHn7qt+ZVuzjjuiM=;
        b=WwKSf9DeBgha0VZ5g2Ss98UKw/pXwNAFMo12kSVW6vjbQkk/33EuaYkzuHTU9xaxaM
         HlyGM5yVw97ScNreUDtzMJM2elZIY3VHPoWID1tKwhPyJkOSiS6+NsADWL/1DVT299eN
         lmvXXea6Y5v9CYRs+br995PAMbLhAV0icnNebdiKU4Kpo31edEPINL9iCl9rCweEQdqA
         DYWNO5Sfk3Nr6ySbuB/Y2Ha7fx3uvePYvIE4+yY3qNCHJsucBE4N1QeT58XqMVvsJwVt
         OUwxaayMVYY0lZKYWj0GSH5OTvPLH/QAuwIn9dRW1re/tbJRcVcjb8CtyLCukuRh3dtB
         zoTQ==
X-Gm-Message-State: AC+VfDyIt45gWSdQnwBtZFcP2CvJ/U7zTeu0Cqi1RNKRe9Gw863Ua4Tf
        jgOMJE1gZeRreCPz6P8TEfLUS3aXUv1kGPJAacWsGA==
X-Google-Smtp-Source: ACHHUZ6KJVE5W4R+5NrNC41r5RT6N1KjMilZ2ar1Y08ZzVEnNcR+1sdvGuHh8D63nQ1jjTKO7GvQbO0SQnFt1dsMjUs=
X-Received: by 2002:aca:6155:0:b0:397:f86d:3024 with SMTP id
 v82-20020aca6155000000b00397f86d3024mr3019097oib.15.1685519892188; Wed, 31
 May 2023 00:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230526130716.2932507-1-loic.poulain@linaro.org>
 <ZHYOucvIYTBwnzOb@infradead.org> <20230530-angepackt-zahnpasta-3e24954150fc@brauner>
 <ZHbhEMxW2XjvAAju@infradead.org>
In-Reply-To: <ZHbhEMxW2XjvAAju@infradead.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 31 May 2023 09:57:36 +0200
Message-ID: <CAMZdPi_05osnDu=Bt7NYLR_+JLQpRc=dSrTSdR-46oX_nP9kpA@mail.gmail.com>
Subject: Re: [PATCH] init: Add support for rootwait timeout parameter
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>, corbet@lwn.net,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 31 May 2023 at 07:54, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, May 30, 2023 at 05:43:53PM +0200, Christian Brauner wrote:
> > On Tue, May 30, 2023 at 07:56:57AM -0700, Christoph Hellwig wrote:
> > > This clashes a bit with my big rework in this area in the
> > > "fix the name_to_dev_t mess" series. I need to resend that series
> > > anyway, should I just include a rebased version of this patch?
> >
> > Sure, if this makes things easier for you then definitely.
>
> I have missed you had more comments that need a respin.  So maybe
> Loic can just do the rebase and send it out with a note for the
> baseline?  I plan to resend my series later today.

Can do that if it helps, please CC me.

Loic
