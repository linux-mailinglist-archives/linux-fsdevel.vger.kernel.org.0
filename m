Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DF92501CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 18:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHXQOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 12:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHXQOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:14:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151C3C061573;
        Mon, 24 Aug 2020 09:14:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so5336049wme.5;
        Mon, 24 Aug 2020 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bQmEiF0nNtva+W4lz+UVmYYBLI7EyXV+PvwzfSiqgKI=;
        b=rRxqAxGOH6uIuRhHwh1XVgZTj5KLQhgkQcjTcx7moc3mobLjJsAILRVb/sjMSvIW2y
         XC8zd2gGEtavfrikYBwfV3wjp25ddVeSFY655JJokMUINWjBLfww48oTh+BTbAx72STs
         GOUWPdv+QFZr+oJr0a9CfxlYPUjJgwutMYL3S3jDV1sdznXFA467AN9flfc5kv/B63zC
         B8LNWcpU2LYGVXwbpkzdiRq5iAsq2gECH9qNQxrhsGesWkVvARdt9T7uIG8dcd152BoC
         m3UMjBouag6JcsdFJEp2s3su0c05SYaNmmWsnAj+09dA9olQ5lovFCQmxqw35Z2mv3Ct
         N2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=bQmEiF0nNtva+W4lz+UVmYYBLI7EyXV+PvwzfSiqgKI=;
        b=ZtddKuytlko2djE5af7XQrZDY8S97vVMClbg+zvlXVtEN2qoKG4scPilSI8a017rRJ
         oJTCZGh1HnhjmS20zRU9Y9ZtXEirUiTrvO6WHG1Di68X5LgFsSrAXnWHiHbPriaYTEfg
         7zZCpB06wGOpA+dtdOtYD0m61RXkHM+KbcaqalkSbIeWkZ9WrQ5+Ps9FWuPWvavIk276
         nohPN/fo+BK6LOrUWSm02BYSfvsoH47Cl88hBsTHR9PfnCD8sK9ginSHzB2hE1s8uAso
         ZIIlaINV+w6srg1xUiNeelUlYgYAFcnXmq++Wii4G750V7NPSWfpF+c9KR/PPQ9CE/rD
         S4Kg==
X-Gm-Message-State: AOAM530mq9PNs3MYwbCE6lEnUVu3GAf4qGo14/f0h2vGSak5WPpW1qwl
        kkUp6x2zGXN/VohzQkGIMNU=
X-Google-Smtp-Source: ABdhPJxTFx9zVn+SnRH0BvljaLLtn5MTvvXZKnJ9KQabhJHX1Q9J0G4k+FMgx7okJUCBnsKuEVynlQ==
X-Received: by 2002:a1c:81c6:: with SMTP id c189mr58412wmd.124.1598285656823;
        Mon, 24 Aug 2020 09:14:16 -0700 (PDT)
Received: from ?IPv6:2a02:8010:64ea:0:fad1:11ff:fead:57db? ([2a02:8010:64ea:0:fad1:11ff:fead:57db])
        by smtp.googlemail.com with ESMTPSA id m125sm24529wme.35.2020.08.24.09.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 09:14:16 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] fs/ntfs3: Add attrib operations
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <c1cb597c14594bd28141cfc1650841e0@paragon-software.com>
From:   Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
 /dLFIhf2zxRylN1xq27M9P2t1xfQFocuYToPsVk=
Message-ID: <52ab2a46-6850-1db8-991f-f58c390936b1@harmstone.com>
Date:   Mon, 24 Aug 2020 17:14:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c1cb597c14594bd28141cfc1650841e0@paragon-software.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Konstantin,

I have an interest in this - I wrote the Btrfs driver for Windows, which =
also had to deal with the issue of how to map NTFS concept to Linux xattr=
s. Unless there's a good reason, I think it'd be in everyone's interests =
if we used the same conventions.

You have four(!) different ways of referring to the attributes value, whi=
ch seems a bit excessive. I suggest you just use user.DOSATTRIB - this sh=
ould be in the user namespace as users can set e.g. the hidden flag on fi=
les at will. This also matches what my driver does, and what Samba does.

I also think it's a mistake to only expose user.DOSATTRIB to Samba - ther=
e's patches in Wine staging which would also benefit from this.

Also, unless I'm missing something there's a bug in ntfs_setxattr - the u=
ser shouldn't be able to clear the FILE_ATTRIBUTE_DIRECTORY flag on direc=
tories nor set it on files.

Thanks

Mark


