Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06CCEDDFE4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2019 20:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJTSIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Oct 2019 14:08:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52471 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfJTSIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Oct 2019 14:08:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so10838124wmh.2;
        Sun, 20 Oct 2019 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZyScSgyx1v1KMw11LXs/d910+0o/5j0T6WzSjnl90Ec=;
        b=lQyno92/NxMfxfaAdR+mU57q/zfWHHiSTBgeqKtrLeobdBwrmxKy8KCMFYCzAGRTZx
         Z0qImnfC701v8yi3sL6xDOJaoS5fISZEqYdgo0emBbPDPBdYwHX483wROvG1g4II8N21
         7tFLaM6sN993v+9w0yv+OGuVc0iPnjGmyKxleIleQi1ED4yQu76d6It6sKySFnYJBv5c
         Krt59icxeVzsw/mMyv6LpQb5awEDRtpRZnHNKkyPb+q8ZJeE2wgnZP4h9n5uNbHyY5Uz
         VoX1oD/A6C2NrFcipFbo0F4l5W0iwCcFRiJT5CtezpvWC/ChrJ1iq7fDDQ/ZQ/FRIT6Q
         n0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZyScSgyx1v1KMw11LXs/d910+0o/5j0T6WzSjnl90Ec=;
        b=IB2uLI52J2T0aXcYeEB0thyWN5c1b8JXreBKQqU8WFPnnl+Mlc9E1DSnPpzo9hqpNP
         iXVdojjJvRZ9LTlApN936rzHJbppX/Nnx77lxtSGxfEUr7hzviwMweZbx4nyyyj6SXw0
         96SgAQUVL675KlgjQAxvfU+Wb/pFQ8KJsXrCnppXwZ6ncjtIRRDUVqNAFxhFEN9AKNK8
         jqsLFNvEjuE/1+OavNcn/T53tzJcB/xeTN6OMwXDV384+p2aZ13Cn9e1WduDtwtju8cY
         Xz80sWB65BpqmzBmnL5MT6gXbdkxm62x3UP5cOB6FoNyC2nqgD/r8ugy9H5+1FVj2BN7
         o+7w==
X-Gm-Message-State: APjAAAUBgEQAifPdozCcPyBP8Y1KQC08c5Uruh3snj5FDZrnbiT+D8HD
        RH0aEfMBs+slbZsqrn/csVGqeGJvfHqQhqXo7CKemS5HPXo=
X-Google-Smtp-Source: APXvYqzEC44nKgE2J9nQP5cTZEkGghcknqCros6dWpjbg+JD2QhjuAbWQ9aVqWOiSC00SOtfbarRFM11fwxwTpv1XfA=
X-Received: by 2002:a05:600c:54e:: with SMTP id k14mr17042823wmc.9.1571594911706;
 Sun, 20 Oct 2019 11:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
In-Reply-To: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 20 Oct 2019 20:08:20 +0200
Message-ID: <CAFLxGvyFBGiDab4wxWidjRyDgWkHVfigVsHiRDB4swpB3G+hvQ@mail.gmail.com>
Subject: Re: [PATCH] fs: exFAT read-only driver GPL implementation by Paragon Software.
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 19, 2019 at 10:33 AM Konstantin Komarov
<almaz.alexandrovich@paragon-software.com> wrote:
>
> Recently exFAT filesystem specification has been made public by Microsoft=
 (https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification=
).
> Having decades of expertise in commercial file systems development, we at=
 Paragon Software GmbH are very excited by Microsoft's decision and now wan=
t to make our contribution to the Open Source Community by providing our im=
plementation of exFAT Read-Only (yet!) fs implementation for the Linux Kern=
el.
> We are about to prepare the Read-Write support patch as well.
> 'fs/exfat' is implemented accordingly to standard Linux fs development ap=
proach with no use/addition of any custom API's.
> To divide our contribution from 'drivers/staging' submit of Aug'2019, our=
 Kconfig key is "EXFAT_RO_FS"

How is this driver different from the driver in drivers/staging?
With the driver in staging and the upcoming driver from Samsung this
is driver number
three for exfat. ;-\

--=20
Thanks,
//richard
