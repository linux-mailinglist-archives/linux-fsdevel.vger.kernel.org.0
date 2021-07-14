Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D9F3C883C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbhGNQCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhGNQCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:02:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6633FC06175F;
        Wed, 14 Jul 2021 08:59:25 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u25so4110447ljj.11;
        Wed, 14 Jul 2021 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UJ4E/XVzZM3ylSuwrw9dCIunWH7KAQHUmW4q5N94kcc=;
        b=tw9V/5BAB7DcppZw4qv7SJrckZJdY/MRbWk4EJ65eGrxhUQgv29cr/OImjqQrhMX0g
         GTpk1yQSeS/WD0jvHsGIR+t2Ncx4K4T+dFtVH5bwqk8tIcWPpoUarVg1EBMUADPFRXxs
         e5QgjxRv7hCUJfGEcdyy0P7/Ka0K5BXS6PqG6xkpAYh8sBbsWmMeK8bRdo3enoR9mzsc
         vspisdxBfGGf26jikFgq9iGRBsrpNsqrA84VTiyFHLfb92e9U3Nt59d0BdjQasojeWyg
         IuUsCyZu6E9ktmHftUnVdtOPjVOy/VdUAKCoLidFFve9Q3A2NfKlUZQ45Mx3iUIP5YE0
         qDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UJ4E/XVzZM3ylSuwrw9dCIunWH7KAQHUmW4q5N94kcc=;
        b=U5OI3uRZmv+JmK8cIVwNbhhyq8BhOEgxnKA4LCRrkl7MjKcuA16EThkh4vdC+Chmy+
         iENO1FttPaiKKE82RPV6OcfzdQ3bevw6GNjBb4a40J+iVWNP4IeA0TvoM5Bqi2rElDBl
         OvDuPAA7z6Utf4uZdrMy+gMNLtAWhDY7Ppc6mz5lAiWSO+k06L2pfL6hLG1VN6Ch5jMb
         LHCgcptyaehy2jW7TfXSPRZoUaajlRg3Tmwf/0G2g0FIf+znaOnNmVZn4PVF+SZOIPjr
         tWYV5mwVF78CNasd+p8onZ/RynHfLDxSCka5t5pcUeaFLkqK012v15CSRhI/RQPs4peO
         sXMQ==
X-Gm-Message-State: AOAM530MO77KkprYId1316sfZwcSfksqJv4fcCVhGUOl6e8qGefjpLll
        eqPXwZIZA6loLMLrDBaNDJk=
X-Google-Smtp-Source: ABdhPJy920bWU5iblLN0ldCTe7g8Jo0x8c7L5tLIQEpGZwMN2OvWDNQwqxsgSO8HBr0mJxb9PzmTQA==
X-Received: by 2002:a2e:8e26:: with SMTP id r6mr9935055ljk.159.1626278363778;
        Wed, 14 Jul 2021 08:59:23 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id p16sm191967lfs.83.2021.07.14.08.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 08:59:23 -0700 (PDT)
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <7f4a96bc-3912-dfb6-4a32-f0c6487d977b@gmail.com>
Date:   Wed, 14 Jul 2021 17:59:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YO755O8JnxG44YaT@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.07.2021 16:51, Greg KH wrote:
> On Wed, Jul 14, 2021 at 12:50:08PM +0200, Rafał Miłecki wrote:
>> Hi Alexander,
>>
>> On 13.07.2021 22:14, Al Viro wrote:
>>> To elaborate a bit - there's one case when I want it to go through
>>> vfs.git, and that's when there's an interference between something
>>> going on in vfs.git and the work done in filesystem.  Other than
>>> that, I'm perfectly fine with maintainer sending pull request directly
>>> to Linus (provided that I hadn't spotted something obviously wrong
>>> in the series, of course, but that's not "I want it to go through
>>> vfs.git" - that's "I don't want it in mainline until such and such
>>> bug is resolved").
>>
>> let me take this opportunity to ask about another filesystem.
>>
>> Would you advise to send pull req for the fs/ntfs3 directly to Linus?
>>
>> That is a pending filesystem that happens to be highly expected by many
>> Linux focused communities.
>>
>>
>> Paragon Software GmbH proved it's commitment by sending as many as 26
>> versions on it's patchset. The last set was send early April:
>>
>> [PATCH v26 00/10] NTFS read-write driver GPL implementation by Paragon Software
>> https://marc.info/?l=linux-fsdevel&m=161738417018673&q=mbox
>> https://patchwork.kernel.org/project/linux-fsdevel/list/?series=460291
>>
>>
>> I'd say there weren't any serious issues raised since then.
>>
>> One Tested-by, one maintenance question, one remainder, one clang-12
>> issue [0] [1].
>>
>> It seems this filesystem only needs:
>> 1. [Requirement] Adjusting to the meanwhile changed iov API [2]
>> 2. [Clean up] Using fs/iomap/ helpers [3]
> 
> Why haven't those things been done and the patches resubmitted for
> review?  Nothing we can do from our side when the developers don't want
> to submit a new series, right?

The real issue (broken compilation) has been pointed out 2 days ago and
is a result of a more recent commit. For months filesystem could be
pushed but it wasn't for unknown reason.

As for fs/iomap/ helpers it's unclear to me if that is really required
or could be worked on later as a clean up. Darrick joked his opinion on
using those helper is biased.

In short I'd say: missing feedback.
