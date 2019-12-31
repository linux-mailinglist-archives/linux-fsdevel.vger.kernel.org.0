Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2146312D934
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 14:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLaNqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 08:46:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36357 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaNqw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:46:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id 19so37889191otz.3;
        Tue, 31 Dec 2019 05:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uBBw2fYsDtBfVJ82B0hrbci7DOyX+XAScgN8zN3sK/4=;
        b=hX5wPR2qQhujGGVexkJlu8ieE07p19KYY6D2pjk2WUqkv9T+/bi/6N+GAyNwhaP8j7
         pyqqzoOMnhAPlq+FJ7XUSGog/V9s4e5pQtqBv0xgPbJF0vUK6Ktj90pKpmyI5D4mYyWD
         QZ2SLN21DooQXnUO7tzZflvIhNo3DJhFq87caiuKX/tTE8Oan3idAPuFQrow9iGLVjLK
         udUQrL3wvFUiIT8J5rLLSWG00j9Gaob5+9moroTR3KC18Q4FlSM7bG2GPsAv/+ASp42x
         jS5/xQJ2ziJERMFOdFyTbPALwjG81D7P/L7aYyYPxvMiSMU3fBb0Dusxf+9U+ZHwGlGY
         CuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uBBw2fYsDtBfVJ82B0hrbci7DOyX+XAScgN8zN3sK/4=;
        b=PPZw3GghRCh56XqTN27xJRHGjFKp16BA7B6oz69pewfU9SuExXclSjPaj3H4EffQtY
         1W1saR9SWUaSpIih1SzroKTLqVnhQ22f/CRvKLWL8PbXl3rrxJF0++RKBMdQqmWZGlI0
         AeiCcWHpO6zMuj643ZbghJhEEmNC2zfR5MJWgsyl5A+NIHmAuicd96cM8uelIIEvaS3O
         FuSvJwmG/m70YtxFetUQFJ67CWd4mBBhfUEboHQolavLZaHM1UAxn6FAQEEWHsFcsvjk
         wRzrCM2RH6TTGoqR3a0HlzBLN9eJTvji13vtwnfL4GSqe8uNBGGnVaB19redHbBniUBK
         vXYA==
X-Gm-Message-State: APjAAAUeGepwqoYjaqHXdeyZkd6KJYVWO5sfH4IyKCSjrGfN5vIby7gb
        OBAhsQndHbLmOK/UYcISQv8KS/9zmerBDB5iLkA=
X-Google-Smtp-Source: APXvYqxwg6ZoThexB++IPZyV8pDi4gYiBkQIcYyXXE8YowM37yB2EQZsveruc0ectrPNNq9V6kmL4/xYCVfTv96/NQk=
X-Received: by 2002:a05:6830:1141:: with SMTP id x1mr6276737otq.120.1577800012184;
 Tue, 31 Dec 2019 05:46:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Tue, 31 Dec 2019 05:46:51 -0800 (PST)
In-Reply-To: <20191229141108.ufnu6lbu7qvl5oxj@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062732epcas1p17f3b1066fb4d6496559f349f950e1751@epcas1p1.samsung.com>
 <20191220062419.23516-2-namjae.jeon@samsung.com> <20191229141108.ufnu6lbu7qvl5oxj@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Tue, 31 Dec 2019 22:46:51 +0900
Message-ID: <CAKYAXd8WwMXSAicX=bx5vu=1GdXW0h4Lg_atxtdC7NLLo8E=SA@mail.gmail.com>
Subject: Re: [PATCH v8 01/13] exfat: add in-memory and on-disk structures and headers
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> +
>> +#define ATTR_READONLY_LE	cpu_to_le16(0x0001)
>> +#define ATTR_HIDDEN_LE		cpu_to_le16(0x0002)
>> +#define ATTR_SYSTEM_LE		cpu_to_le16(0x0004)
>> +#define ATTR_VOLUME_LE		cpu_to_le16(0x0008)
>> +#define ATTR_SUBDIR_LE		cpu_to_le16(0x0010)
>> +#define ATTR_ARCHIVE_LE		cpu_to_le16(0x0020)
>
> Hello!
>
> This looks like copy-paste code from /* file attributes */ section
> above. What about at least making these macro definitions as?
Yes, will remove unused file attribute macros.
>
>   #define ATTR_READONLY_LE	cpu_to_le16(ATTR_READONLY)
>   #define ATTR_HIDDEN_LE	cpu_to_le16(ATTR_HIDDEN)
>   ...
>
> But main question is, are these _LE definitions needed at all?

>
> Looking at the whole patch series and only ATTR_SUBDIR_LE and
> ATTR_ARCHIVE_LE are used.
>
> Is not it better to use cpu_to_le16(ATTR_READONLY) directly in code and
> do not define duplicate ATTR_READONLY_LE macro at all?
I can change them as you pointed out.

Thanks!
>
