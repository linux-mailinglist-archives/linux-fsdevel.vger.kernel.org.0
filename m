Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22BC013C23E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgAONF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:05:57 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40100 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgAONF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:05:57 -0500
Received: by mail-oi1-f194.google.com with SMTP id c77so15264813oib.7;
        Wed, 15 Jan 2020 05:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H6BEq2s6qwUB7XkhW258dUzmVLj2UZKqUrk3pae1Gs0=;
        b=DA06P+qiBjRI7oO1e/2aTjANs8Bvc8xArp5OO1/uEkYRSL67h0uVkDIX8RuCQ3q6UC
         yUx3NZGpyUwsjlJR+7lXFQyPQZYbv7+bvq2SqDpso0ARNvGna96AeghU4NEpK7hzlB0v
         TuBwjCmLxfQBtNw6s/Zukpe2JP692kbTWUg720/XzLDrK/m3Sbhousk0icyggOFPK+jF
         VM4dacW6MsdAlq6NgK0eQqpMb8n609anzI8svSQszTHWovXnlbVxBPIic5pHyQrKQvKE
         W519w+qVJH1o7nPGhN8E0OBzC8TbgeC5EUamtbPVz1ViXVeQHBbyXSmZ3s+OaeElUAXE
         kaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H6BEq2s6qwUB7XkhW258dUzmVLj2UZKqUrk3pae1Gs0=;
        b=m4wLr8UaHyV+gZUf0pDwoHIeY0NcgGaInTQMrCrDLyGyXlkw7V7coZzdqHLOboKdLs
         IDon4aYa3STvnAwJMxCwUmNKJF6oNGUe6qq/5W8BgtCzc27gD0yC5CnaYkqYYPy0khvg
         j8504ucoCw/fPkj8mQRnW210mnBMjrYsY3brpPCM0eJY4ac6idNH9lSGvp/pVxcWtcZH
         MeGhX10HH49GmzOQe5pB1/JxylnNPbNJ+v8+H4Vp3QpSu1fSfi7dllgVwnEB/K2EVhjT
         G6S+CXjqdRZW/RZzf5fjiIiW5gHQrayl/I61zQ+1wG17dYavpUDDodBwRfhRSPhm2ESg
         a8Zw==
X-Gm-Message-State: APjAAAVViR7V8SYUHrqT3wVsy5HXEixMPoZT/wUI7uGhBb7l7ApObVb1
        mgVCt4XiZfEx378YJ0v8VuaRdkhPXHrAPvueMEQZJw==
X-Google-Smtp-Source: APXvYqwIkGNliK8WGdVz6f0X4PNRU83A/8S8ETo5iuUEpsAnfbuFAWGsTOz4is+DVgq7eJGGTUQQO13WvtbQOdpzAG4=
X-Received: by 2002:a54:4715:: with SMTP id k21mr21339030oik.163.1579093556436;
 Wed, 15 Jan 2020 05:05:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Wed, 15 Jan 2020 05:05:55 -0800 (PST)
In-Reply-To: <20200115094732.bou23s3bduxpnr4k@pali>
References: <CGME20200115082818epcas1p4892a99345626188afd111ee263132458@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115094732.bou23s3bduxpnr4k@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Wed, 15 Jan 2020 22:05:55 +0900
Message-ID: <CAKYAXd9BQJ-KKaqLycJU6HVHo7qFgvpyOOmzjcfeibkrwwMK9g@mail.gmail.com>
Subject: Re: [PATCH v10 00/14] add the latest exfat driver
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-01-15 18:47 GMT+09:00, Pali Roh=C3=A1r <pali.rohar@gmail.com>:
> Hello! I have reviewed all changes in time when v10 has been preparing.
>
> There is just a small issue with description of EXFAT_DEFAULT_IOCHARSET
> option (see email). Otherwise it looks good you can add my Reviewed-by
> on whole patch series.
>
> Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Thanks for your review and help.
I will add your reviewed-by tag on next version.
>
> Next steps for future:
>
> * De-duplicate cache code between fat and exfat. Currently fs/exfat
>   cache code is heavily copy-paste of fs/fat cache code.
>
> * De-duplicate UTF-16 functions. Currently fs/exfat has e.g. helper
>   functions for surrogate pairs copy-paste from fs/nls.
>
> * Unify EXFAT_DEFAULT_IOCHARSET and FAT_DEFAULT_IOCHARSET. Or maybe
>   unify it with other filesystems too.
>
> * After applying this patch series, remote staging exfat implementation.
Yep, I will check them.
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
>
