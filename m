Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F901310BAA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 14:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBENPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 08:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhBENMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:12:46 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EF7C061226;
        Fri,  5 Feb 2021 05:12:08 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h16so4833106qth.11;
        Fri, 05 Feb 2021 05:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ADRxoQcIvYivgr5yxTch27ilZAmQaMeSDDWZOkwCWGM=;
        b=LqQ+V8XsT3jUqZm/2Z2FTttylVoXlqRgIKLUMUUjcnkV9D5WIMXNPv+5ofTUvSsoI+
         8r/lkjs6o7UkW7+VfiVxssrpawWiMXqw4BjhMVM7v6W7Q7F3uVTlYRrtgJhzE9N2jE2+
         sgwEDVuFpCkq+6mZ+EdkX5rI2gYqV2iyH+GFsBNNBTDSjyeDrn7c2NVOzBUAg+pz/QUy
         3BjSAEoeqr9GtdddaCP3ga3Ix2kROB/Sb7Uq0B6Wq60KHrnPvFD+bJL+Vr8/6TiQN5Lg
         sC5k9X34J9iqUHq4jfjfIBzExDjVowJOMFiuNOQ4bDS7IGdGsXLo4nOeGYnjfX8vzDVG
         JbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ADRxoQcIvYivgr5yxTch27ilZAmQaMeSDDWZOkwCWGM=;
        b=kzsnm/SDz9VsZRTOxGo3Gn5HAMKvIvEnb+1dTEGJZIW1oc81/6rnpf3ucjW/gVK9k8
         QaX6gY5ZvZkmKiKPfpU05cMkZKJf2mJhSx0UEkZ3i+c68Bpn40Ms+Ok+4sVa66+13SBt
         T6w13f91zk63MuA/5inEViF/oCnq85zruWb5punQUhC1yWPZ7rAjUUHmhKyY0lmt8eLq
         A+0y4DB+dX8lN60B7/teSMYWZsvN9cMA/+BxyHuhsYuEsNRy4fS7IUWv2KvdrcYSEYRC
         tTeofJ+kajlxRo1Xv2cby29U4AJBUmtpq/k4gee9uo4eWVlvIBwwrjpiHhQkRj1aK6aE
         PzTQ==
X-Gm-Message-State: AOAM533FqoLBRIj+g9qmEe3w349AjuV8DVae/IElB5bGkFd1+eIJeIwO
        /iP6N906AH6kJiHsIQogLG4=
X-Google-Smtp-Source: ABdhPJyGhsRsZy/grCUETYf2npxbNoEl8rms4QclOCP/dCvHASmxBEAW620yerk9l1ZdHC1CL+PYTg==
X-Received: by 2002:ac8:5cd0:: with SMTP id s16mr4050236qta.333.1612530727724;
        Fri, 05 Feb 2021 05:12:07 -0800 (PST)
Received: from ArchLinux ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id l128sm8688569qkf.68.2021.02.05.05.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 05:12:06 -0800 (PST)
Date:   Fri, 5 Feb 2021 18:41:57 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] fs: notify: inotify: Replace a common bad word with
 better common word
Message-ID: <YB1EHZL5gbVGO1Xx@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20210205122033.1345204-1-unixbhaskar@gmail.com>
 <CAOQ4uxhy2XG=EBg6f6xwSNZnYU9z0vx0W6Q2pXDT_KOTKWPZ8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eFE9rVWUG2DXNXni"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhy2XG=EBg6f6xwSNZnYU9z0vx0W6Q2pXDT_KOTKWPZ8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--eFE9rVWUG2DXNXni
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:45 Fri 05 Feb 2021, Amir Goldstein wrote:
>On Fri, Feb 5, 2021 at 2:20 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>>
>>
>>
>> s/fucked/messed/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  fs/notify/inotify/inotify_user.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
>> index 59c177011a0f..0a9d1a81edf0 100644
>> --- a/fs/notify/inotify/inotify_user.c
>> +++ b/fs/notify/inotify/inotify_user.c
>> @@ -455,7 +455,7 @@ static void inotify_remove_from_idr(struct fsnotify_group *group,
>>         /*
>>          * We found an mark in the idr at the right wd, but it's
>>          * not the mark we were told to remove.  eparis seriously
>> -        * fucked up somewhere.
>> +        * messed up somewhere.
>>          */
>>         if (unlikely(found_i_mark != i_mark)) {
>>                 WARN_ONCE(1, "%s: i_mark=%p i_mark->wd=%d i_mark->group=%p "
>> --
>> 2.30.0
>>
>
>Same comment as the previous attempt:
>
>https://lore.kernel.org/linux-fsdevel/20181205094913.GC22304@quack2.suse.cz/
>
>Please remove the part of the comment that adds no valuable information
>and fix grammar mistakes.
>
I am not sure Amir ..could you please pinpoint that.


>Thanks,
>Amir.

--eFE9rVWUG2DXNXni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAdRB0ACgkQsjqdtxFL
KRW/zQf7BKegoPzRENcHDlqWV4qPeYTiBUn8XddvlhpP6SZvcSZsx/U66L/0uvaW
2dPIQMzYVuUTZAuYH1aHRCjWYy+ufSzl/dzfFZhb7SntIXnGuZYkfJGt8DYctRtL
nOfoQVJeZFNWha0hyKH5QiiIcSzZQTvL0sccqJxWUfiQrR+fHo8WcoX8NIIyPZqa
15D7l95O0H4Su+LhNQePZsQeB3zHWI4Sgaf6xghxD2IqrZgRjJ/AF43P7ROuMmAX
cdEov7bfv3xUmgsdBL6Cbc4wBlc4J5t0NKrxrkfZc596w2ql+oYId14KFrwiHgkx
tpyOhco9pHcB+ec4aeN7TqxmCtg3hg==
=+s+x
-----END PGP SIGNATURE-----

--eFE9rVWUG2DXNXni--
