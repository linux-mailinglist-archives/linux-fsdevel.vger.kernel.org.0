Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402E23C8888
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 18:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhGNQVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhGNQVW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:21:22 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B688C06175F;
        Wed, 14 Jul 2021 09:18:29 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b40so4203319ljf.12;
        Wed, 14 Jul 2021 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4dmyFudmqM35M4fxUjbwxzi8D3gpd+2jW5SdToDO008=;
        b=Lrp3yue8taTSFoHaZno0VXwcfHyJVAa9j97nmENM2H20rzINkjXZxclFrL2JfHCRdN
         3l2Jn1WjcsaUWSLmScjkV69B3MAXiZ2lCFngdPOTvOm6XZvLEJqJ6MckCLQNY9Klp/gJ
         +yxJGgjc+AJPEaGmCqNYNPB1QDdr/Hlb03bYrScjY7mDh0S5QBU7QgcMlYNwCdroGCqE
         faB/8E32xq/BHxd4aCRAevDovZw8t8Qs4f3WMIhdNQr84l8MK+0HkUra066lpTp9Izk/
         0dD1PGoAtxxCpw5jWOxPrWJDsfw9AskcmpxTB2FxRDhJhp3YPStHj8eJhWzd/kLbUz6B
         hhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4dmyFudmqM35M4fxUjbwxzi8D3gpd+2jW5SdToDO008=;
        b=Zh+KdWAmWFS6jG2IarrubBcoZ8+q0i/ra9ZAFQFElQH+vrVkdJjjHYDdybohoTJbRA
         bug1Etm00Ji8poguLOpGqg1rFcQfiDpns3uwaZm54WNjRWhimqmGFBiCemIgXBeOHapb
         fVAAcFIQLKBytMJbuDD8wlWiCTbqBSzY7uc1iZxgD+5c38lpgQdqwnq2T5HGRroyQiGK
         YhuB6Ipn1c9qtCaJyzZpjG7iC6FC3kwudpVGRLds5+lXdG225+NNpKQDtgeE0sLeB2Wj
         ovdFYiwa16LvN48IXZIFSp3Dlxwwvf4LOP+uAYMp270gncKxgp38bXewFPmTNXSpn4gL
         Wu+g==
X-Gm-Message-State: AOAM531fi94IodW8wWIKPkRm8tI8bF8Ezof72wzl9WAzrnEXOchivTW9
        Ge5le6e7ZvUyldKcYhyVHRA=
X-Google-Smtp-Source: ABdhPJye5vz+hvuPkKfHD19KQ6U212f6Tl2NLMdLr8lUm1SAJc+P8hb6ID6nHkMKz57A6kN2vEukaA==
X-Received: by 2002:a2e:b548:: with SMTP id a8mr10206515ljn.346.1626279507951;
        Wed, 14 Jul 2021 09:18:27 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id v16sm285386ljn.93.2021.07.14.09.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 09:18:27 -0700 (PDT)
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
 <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
 <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
 <bea2bcf2-02f6-f247-9e06-7b9ec154377a@gmail.com> <YO755O8JnxG44YaT@kroah.com>
 <7f4a96bc-3912-dfb6-4a32-f0c6487d977b@gmail.com>
 <YO8LOKR/vRUgggTx@casper.infradead.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
Date:   Wed, 14 Jul 2021 18:18:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YO8LOKR/vRUgggTx@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.07.2021 18:05, Matthew Wilcox wrote:
> On Wed, Jul 14, 2021 at 05:59:19PM +0200, Rafał Miłecki wrote:
>> In short I'd say: missing feedback.
> 
> Uh, with all due respect: Fuck you.
> 
> I've provided feedback, and Paragon have done a fantastic job of
> responding to it.  Pretending that the filesystem has simply been
> ignored is hugely disrespectful of my time and those at Paragon.
> 
> I'm supportive of ntfs3 being included, FWIW.  It looks to be
> in much better shape than the existing fs/ntfs.

Thanks you for kind words before even trying to clarify the situation.

What I meant (but failed to write clearly) is missing feedback on *the
latest* patchset.

I highly appreciate everyone who took time and helped polishing that
filesystem to its latest form.
