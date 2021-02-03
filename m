Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1030D2A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 05:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhBCEZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 23:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhBCEZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 23:25:14 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACD9C06174A;
        Tue,  2 Feb 2021 20:24:34 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id w204so19889581ybg.2;
        Tue, 02 Feb 2021 20:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P5epiL1I3IZ+JZZ+3F+sxnWjlBmK3ftZulqVC++bW+k=;
        b=eKS07V/h4GdCp2t9r66fweGixafuC+39Qy00iXO/Z2VfguiFJp+uI85w6DBN4C823r
         nmrl2/DPcDt5ccciz20mdz6bdp8rBekdM9kDHY/6Ih5ravyVaABnBTIEljqSttg7av8j
         OkyY4hadz4kgOZ+JOpPEAIqFYj+C44tmRf1fIeW0AFo5J5xD8b4tWVQXRBRtb/mbxp32
         MEpCgfNjzWYEp3wvFvEE6hOkYaxen4aIxFjvkb0oQZyZmWASqWUeRWHt5Kge5cpz6vj1
         IUYtxXYIVYdNl6DVVZyt0NFqSIBXOjn9rYqv3d6A4n0dazjpbNYjhWBLThgWZ+LQutSB
         Nj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P5epiL1I3IZ+JZZ+3F+sxnWjlBmK3ftZulqVC++bW+k=;
        b=A3sXCMjW6w4XG5iRyXXPmDkbh2iAycXK+Ed0P0JAhha1rhnWA2Ov8hdMnNAoyPLGO/
         f2xctbv5zAjwGhHcrlMevJtkYEDMVDl7MxvdnZ4SHZlMsRkBgsawdBHzULbuUZl/tmbY
         p5SJBGSyTH3sDrwvIW+1xBj26zv2bTnyKSB8NpVBe1xINAqpCUlTOcNZUxilmXAu2sRQ
         hbeWqcJ0+cQrNhsT+I8DwhxxDKydaYGiWfopXpnK5cwKYa3ANJ9MY/idBUTKMN/txbIH
         14rc+P12yT+wkWLYzId/UJhiqDX7QGsFjGR1UEbsd8RikNVnvU5RfB75yGAyDa1Kg0QC
         mC+g==
X-Gm-Message-State: AOAM53207/pnetvC+MkDFsHA5CkXmb+Q8APtmHpzGEIE2w9q1zdI/4yn
        ygb1vkLP07Rd7nAEGi02wzoNluFDsrjC2LRSgbWDuEa6lRU=
X-Google-Smtp-Source: ABdhPJwwBsA4CkWc3Iu/afFsf/qu5CPNJ+0s/bdDHyXH6nu7dSkHvaBuqSC4xqRIc/rIOaylW/Bx0TnAlEXJ+EBKsIs=
X-Received: by 2002:a25:c605:: with SMTP id k5mr1860542ybf.34.1612326273308;
 Tue, 02 Feb 2021 20:24:33 -0800 (PST)
MIME-Version: 1.0
References: <CANT5p=pK3hQNTvsR-WUmtrQFuKngx+A1iYfd0JXyb0WHqpfKMA@mail.gmail.com>
 <20210202174255.4269-1-aaptel@suse.com> <CANT5p=qpnLH_3UrOv9wKGbxa6D8RUSzbY+uposEbAeVaObjbHg@mail.gmail.com>
 <87o8h28gjb.fsf@suse.com>
In-Reply-To: <87o8h28gjb.fsf@suse.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Wed, 3 Feb 2021 09:54:21 +0530
Message-ID: <CANT5p=qPqqLsfTFAWkWQ7QxoKh_psWfpVe+pBShEtN2r81m1TA@mail.gmail.com>
Subject: Re: [PATCH v3] cifs: report error instead of invalid when
 revalidating a dentry fails
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sounds good.

Regards,
Shyam

On Wed, Feb 3, 2021 at 12:04 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote=
:
>
> Shyam Prasad N <nspmangalore@gmail.com> writes:
> > This looks good to me.
> > Let me know if you get a chance to test it out. If not, I'll test it
> > on my setup tomorrow.
>
> I've done some tests: the reproducer cannot trigger the bug, accessing a
> deleted file invalidates, accessing an existing file revalidates. It look=
s
> ok.
>
> Cheers,
> --
> Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg,=
 DE
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=
=BCnchen)
>


--=20
Regards,
Shyam
