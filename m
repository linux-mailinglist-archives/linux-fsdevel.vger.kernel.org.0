Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856363885BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 05:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353200AbhESDxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 23:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353184AbhESDxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 23:53:37 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DEDC06175F;
        Tue, 18 May 2021 20:52:17 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i4so16279354ybe.2;
        Tue, 18 May 2021 20:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=31hE0ciYwTpg7ijaPJpda+ORaHVM9Pjhxdh99gC9+RA=;
        b=p4iDSVkrgcvn+HHZidr1i5wNQ3OUoko1t7M2/s2QOszmvRF8YhW4g9O6NuEsiClc9O
         ewD5PTbhrwSuWAS9+mTajpNSVTya1IJ9nMUMi4s5QDfwKIiLQeUySJWu9C5j2IOqbkok
         zmBXizZUu6Pf+BoPmRWFMe5ubLJh7lopdqFwyo6IkEtWwyPittAttdv5r7/8GyfB502n
         mFX3TarqSW9mkIxsGAfNP6BijHzX/ZZqWA7c2Zd3i2no1b4sLJHa90Af91HQyoluvIRA
         6Im2dhGkhae80pdVB+9raVGymESWcEH8a6g7U2I2zAFcQowBhv6yIvf60wqUY711HOFA
         ZstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=31hE0ciYwTpg7ijaPJpda+ORaHVM9Pjhxdh99gC9+RA=;
        b=Mff+QSLgRLqlxZUdN3JbZOpAkh3QQPI6W7VO9AzIa9Xrzznl3TEAdkuXNSYKele2JE
         +NFDVgLtuLQyl5ZZrQQ7NqntCox7LsCxxW5Id8jy/oht1O4trVsykUY9sW3YFYuWvKlh
         Tt7SpmvDwABUfiw/2slF8z4uM6NdglSo7x0x2dLkrETwYsjjDTHNEe4JTONfoBuGKhi7
         46Xas5mi+/JtfHHqfG1dwM7yWg6ksduaqY2VfRfDzZjCHeZLCBLkJEUvLTa47Hvffybp
         yrOjQCq5w0xLQ8kU3jNvKFqFn269XoO7Vb9NsvD6a7PBIEuWE8TcaB+AbR3T8joQQHY/
         DhbA==
X-Gm-Message-State: AOAM533ep4UD2AGIsWhbz2FW/MMumfFhgCrQy66/XV0akrl/VrLYMhmx
        NQjfLhqvGRG/NVJJw9fsvn5kcpoNogVz1C9zJtnm8JZj4C81yA==
X-Google-Smtp-Source: ABdhPJwzRozfRNytfnSHdCd5fzojx5eQbNvBYy02DQsJh1O+6/LZkjMwoy2GqtQrBMIXNWhTQIOkymcgh69RlP43UQE=
X-Received: by 2002:a25:3084:: with SMTP id w126mr12755882ybw.109.1621396337197;
 Tue, 18 May 2021 20:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210402155347.64594-1-almaz.alexandrovich@paragon-software.com> <20210519034759.259670-1-ngompa13@gmail.com>
In-Reply-To: <20210519034759.259670-1-ngompa13@gmail.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 18 May 2021 23:51:41 -0400
Message-ID: <CAEg-Je-cNTew93EWVK3fPVfRWyy7Xd9nst0Sv+eVXdbS2USGyQ@mail.gmail.com>
Subject: Re: [PATCH v26 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
To:     almaz.alexandrovich@paragon-software.com
Cc:     aaptel@suse.com, andy.lavr@gmail.com, anton@tuxera.com,
        dan.carpenter@oracle.com, David Sterba <dsterba@suse.cz>,
        ebiggers@kernel.org, Christoph Hellwig <hch@lst.de>,
        joe@perches.com, kari.argillander@gmail.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net,
        Mark Harmstone <mark@harmstone.com>, nborisov@suse.com,
        oleksandr@natalenko.name, pali@kernel.org, rdunlap@infradead.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 18, 2021 at 11:49 PM Neal Gompa <ngompa13@gmail.com> wrote:
>
> Hey all,
>
> I've been playing around with this patch set locally and it seems to work
> quite well. I haven't seen any replies from any bots or humans indicating
> that there might be anything wrong on the list or in Patchwork (which
> does not necessarily mean that there wasn't any feedback, I could equally
> be quite bad at finding responses!).
>
> Could someone please review this to see if it's finally suitable for
> upstream inclusion?
>

Oh, and I also forgot...

Tested-by: Neal Gompa <ngompa13@gmail.com>



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
