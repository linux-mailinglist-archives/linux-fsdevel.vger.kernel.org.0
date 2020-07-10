Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6A621BFC8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jul 2020 00:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgGJW2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 18:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgGJW2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:28:48 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DB0C08C5DC;
        Fri, 10 Jul 2020 15:28:47 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id e13so6857190qkg.5;
        Fri, 10 Jul 2020 15:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=hGdaV05cW1X2mW2tyPPyA3RWwI45rAOdC5AEhMWDL+0=;
        b=dK8wh55N/arHF4X9cyBJBSJEpWOwUgHYEp537cSPuXw7xMH10nbUKJwWHTU4mXWeNj
         LXcedL/En6IC7jGYOzyhTURMVwsCG7LJgv+HTvfcaIswm2ykMZ5NTCPSuUrTkQsSmuIB
         zz+3tiaTuUFHyqnOTnm5uTeN3pItldBLbfA7/3P/q71J1QlX7HTw/QGscTwrxtn41bhx
         sgCSR1TLrE3nujo+5cnXlZqHYQ4STJIQ7VBKgfNCDNThBAta4rtQziSemof7RuSNp8jV
         zR4VBmy9oKivr0U+YMuzHulUDvPWj6PtYLdtIUHZHZHRSf7EsvI13SaRsO2shvbj3Jo6
         X0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=hGdaV05cW1X2mW2tyPPyA3RWwI45rAOdC5AEhMWDL+0=;
        b=d0ESSjxImWgUehUypBYZn5cYMJsBi5eceenHGwwO1FXRenXwvuLYFAFURBkyfDY4FM
         J38AMVm5xV+wohXXhSXg+WuuPWH/mFsRZJP/koQgokOtbNAQlvWIzBt/m8qA6pTE+0jM
         5BFVYar8jODstQiCo6Vv+1DRAZ4zJaQfdXJcWzf9qekIXWSg+OIGuAmMCCcrnCwhFPb9
         F6IJHFpvCDa0tRbQEBe0UjHFpvsAaLhdxrBVDJxKSqIAfmqIRWakVthwYcKwpiMv42VP
         bGImkMYS8C4MWmYeVsehKaIsmKm96DO063ewap0gi2pDApS4x3T6fYHyEWHxk5nXtaiV
         bh0w==
X-Gm-Message-State: AOAM532Y/nzDnWemhx17o3UDqwIxFsAue2dZIHwFNsg5ikrDtBAxqxTG
        anlNvKrX53xANiF7RwXYc7s=
X-Google-Smtp-Source: ABdhPJwdu1SIKLVvbHtld+Ucsaaz2lElaRXlVdfJf2agzmRcwLwpkdTu2mPjerh45JypR/nVCWF+JQ==
X-Received: by 2002:a37:bd06:: with SMTP id n6mr51067617qkf.344.1594420127058;
        Fri, 10 Jul 2020 15:28:47 -0700 (PDT)
Received: from DESKTOPJC0RTV5 ([155.33.134.7])
        by smtp.gmail.com with ESMTPSA id g30sm10211088qte.72.2020.07.10.15.28.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 15:28:46 -0700 (PDT)
From:   <charley.ashbringer@gmail.com>
To:     "'Matthew Wilcox'" <willy@infradead.org>,
        "'Randy Dunlap'" <rdunlap@infradead.org>
Cc:     <keescook@chromium.org>, <mcgrof@kernel.org>, <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <1594351343-11811-1-git-send-email-charley.ashbringer@gmail.com> <b50e8198-ca2e-eb44-ed71-e4ca27f48232@infradead.org> <20200710112803.GI12769@casper.infradead.org>
In-Reply-To: <20200710112803.GI12769@casper.infradead.org>
Subject: RE: [PATCH] sysctl: add bound to panic_timeout to prevent overflow
Date:   Fri, 10 Jul 2020 18:28:45 -0400
Message-ID: <0d4601d65709$7a0e2d80$6e2a8880$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQK1RVaBa+61frbXsEt9vwPiryoHtwJJAUXHAnUGYEenHZUHwA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, Jul 09, 2020 at 08:31:39PM -0700, Randy Dunlap wrote:
> > > +/* this is needed for setting boundery for panic_timeout to prevent
> > > +it from overflow*/
> >
> >                                  boundary (or max value)
overflow */
> >
> > > +static int panic_time_max = INT_MAX / 1000;
> 
> Or just simplify the comment.
> 
> /* Prevent overflow in panic() */
> 
> Or perhaps better, fix panic() to not overflow.
> 
> -		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP)
{
> +		for (i = 0; i / 1000 < panic_timeout; i += PANIC_TIMER_STEP)
{
> 
> you probably also want to change i to be a long long or the loop may never
> terminate.

Thanks for the feedback, I too agree this should be better than 
modifying the sysctl, considering how localized and neat this
change is. It's also more readable. Setting a bound in sysctl.c
which is dependent on the constant value in panic.c is not a very
good idea.

I agree changing i from long to long long is necessary. 

I'll submit a v2 patch enforcing this shortly.

Cheers,
Changming

