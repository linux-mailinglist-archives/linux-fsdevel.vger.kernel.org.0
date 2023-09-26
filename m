Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24D7AEFD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjIZPkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjIZPkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:40:41 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F710A;
        Tue, 26 Sep 2023 08:40:35 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3ae0135c4deso5344409b6e.3;
        Tue, 26 Sep 2023 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695742834; x=1696347634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WU3qYtBinvT71w132QpbX+eOLkKeT0fUhf/6tkLATls=;
        b=l6TpI4TSrCElg6GxvysUrz3K52U+QtTG/RvCYiJ0C3NKrjUoi2YTuR4ZjIRhEXaZxW
         1vo8GE7NdFchOgO4DiPybAGqXYusnm16DlLcZ3I1m7H6d1c6rhSHPkoYAQVqdSTxGYuO
         YlrRoIoDjrLQeF1Be7oeRU0z3oieNEIR3AMzOkTWN0Fe81I3/IAkeI9FNgra/SvoKARR
         Il7cFXJ1ZSUnLplhM0upaBbeMUxf/k2+iGFhxz0LB87IThIqAytRLyCaADOq2pXaN36e
         jy/qwc3Kmp2lzPhPXmOHKjC9fLwi9AuvVnkYMpDAp1MxGcGi+YgQ3MtOnhkX+ecyGY1u
         6wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695742834; x=1696347634;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WU3qYtBinvT71w132QpbX+eOLkKeT0fUhf/6tkLATls=;
        b=ix+PegJ9jLrqhYt1937/WdsQOq/HKd26Zln28SIY/1Oy5RTSNh2IflAyVkrWows+9y
         iEnqIn9xVD/oIhVBI88PfdoadJj95x2NQJkm7gE5trjsExc5D4ElIjWVw2+HGPuJpUXF
         HJhQq2bCy0L1TqN2QGi9TfciKGzBs2BAo2hoLG1aWZ0XXjknVYf1RDtEgcrHhCXKswqS
         q+1dmCCfdD+T5OwjQbYMm6SuGnWZfpBy2l+UkydSYkUQ+aDaStvDNKEXGc7tjsxxbzHy
         2WKFGAH0e2CLTJCLTLzj/BnxYXC61MRifPfpUzAxPGP9s7wsrUIIV5Oq/GUfP8ySeztT
         EXpQ==
X-Gm-Message-State: AOJu0YwgQf9byBzJohObRKwuZ/7QH6glLcm9oJKWU4CIhdZ7sgm4rzcB
        VYYfz4aP+kxarotOUnRSjxRbtyEB3YeKz1dnDwz1LzH35qU=
X-Google-Smtp-Source: AGHT+IHCVn8zibrHZMmkqGpBuEQhFBU4J+psIue6mQMPMEfOCPnNPOV3nKb0mDX+dB1pVluG4CdhgSS1nfBgYxbtDwM=
X-Received: by 2002:aca:f154:0:b0:3a7:3ea1:b5a0 with SMTP id
 p81-20020acaf154000000b003a73ea1b5a0mr11079342oih.47.1695742834290; Tue, 26
 Sep 2023 08:40:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5d4a:0:b0:4f0:1250:dd51 with HTTP; Tue, 26 Sep 2023
 08:40:33 -0700 (PDT)
In-Reply-To: <20230926-worum-angezapft-5c3f7770ad29@brauner>
References: <20230925205545.4135472-1-mjguzik@gmail.com> <20230926-anforderungen-obgleich-47e465f0bd47@brauner>
 <CAGudoHG0-BWTVRG8uZk5Gy8xSwpT8JO5Z=VfY3_dFcCaqhLf5Q@mail.gmail.com> <20230926-worum-angezapft-5c3f7770ad29@brauner>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 26 Sep 2023 17:40:33 +0200
Message-ID: <CAGudoHFWJWdE26kEGdj=83KJ_gJi9BwRiOUQ1Gy=1i9u4fgJSA@mail.gmail.com>
Subject: Re: [PATCH] vfs: shave work on failed file open
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/26/23, Christian Brauner <brauner@kernel.org> wrote:
>> > if (WARN_ON_ONCE(atomic_long_cmpxchg(&file->f_count, 1, 0) != 1)) {
>
>> bench again.
>
> Can you see how much of a difference it makes because imho it really
> looks a lot nicer then this ugly atomic_read followed by atomic_set...
>

Huh, turns out to be in the noise here and I see why.

Immediately following this there are several atomic ops anyway,
notably to unref creds and apparmor labels. So happens top of the
profile is the allocator(!).

These can be fixed but that's perhaps for another time.

If going this route then perhaps atomic_long_dec_and_test just like
fput? Although one could argue if that cmpxchg failed then something
fishy is going on and "real" fput would be safer. Ultimately there is
a lot of handwaving possible whichever way, so just pick something and
I'll send a v2.

-- 
Mateusz Guzik <mjguzik gmail.com>
