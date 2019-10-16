Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13127D965A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 18:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbfJPQFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 12:05:55 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:48548 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727714AbfJPQFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:05:54 -0400
Received: from mr1.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9GG5rm7004175
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 12:05:53 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9GG5maf017787
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 12:05:53 -0400
Received: by mail-qk1-f200.google.com with SMTP id x77so24174097qka.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 09:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=Cc00vF+ZmzoZk3aEyCGrhUsksukEBOoMGKgFpD+Z/O8=;
        b=HysKcoILTf4Lz3hG8wYqjcKQ12ACM54aCO53IcIE/cstl4z6GQ+fHavmhwLJF2ZQms
         xJT1zhIZ+P/T5+EVvR5GfIXrIr+nyBtRjX9g1oFe4Hpa3EFBt0nb7gY1AGTPMouTsSTc
         jaNiE/GwADPMr9sACN2hS8znp9Qd6kdo1ygK8YIxGleUYOX+9CCbpo0S6A9Gi+NGluzJ
         h4WAzGprDcmOWZZ6g31BxtVTbJQ9vdeQdGh5ltkAoc+4vDms++rsxqSHI5ZqMrcNuplo
         TqN+T5XkeRRvZyxzXvV+YjOy02Kft9mbfvtlZ+wsr1ABgfFQH+9K+/ggbyuegH29kzlf
         piAg==
X-Gm-Message-State: APjAAAUltxdj0qkHK4IUsxoeykyMD2qsPS+RUyn+whnKCn/eXhj+REo1
        ePBNDIENIQd0Yy+M5xNJseOyy0z4B9jaweDu6gIS8tSTPGa5ty1x/fw+XdCc5MygPbin88A/bHj
        Iyhml9n5mZgwmq/5AlDY6dI0k4N7W2h0cboyu
X-Received: by 2002:a05:620a:89d:: with SMTP id b29mr5064576qka.266.1571241947963;
        Wed, 16 Oct 2019 09:05:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyxFqltsKGrKtwqF17O9iibdxSM9S5WlrJxC+GCESGrDZgAo+ncpxnY/6mYmIUe2vm9OOVKfg==
X-Received: by 2002:a05:620a:89d:: with SMTP id b29mr5064547qka.266.1571241947613;
        Wed, 16 Oct 2019 09:05:47 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::9ca])
        by smtp.gmail.com with ESMTPSA id e5sm15152719qtk.35.2019.10.16.09.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 09:05:46 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Sasha Levin <sashal@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
In-Reply-To: <20191016143113.GS31224@sasha-vm>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org> <20190829205631.uhz6jdboneej3j3c@pali> <184209.1567120696@turing-police> <20190829233506.GT5281@sasha-vm> <20190830075647.wvhrx4asnkrfkkwk@pali> <20191016140353.4hrncxa5wkx47oau@pali>
 <20191016143113.GS31224@sasha-vm>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1571241945_33600P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Oct 2019 12:05:45 -0400
Message-ID: <158801.1571241945@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1571241945_33600P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Oct 2019 10:31:13 -0400, Sasha Levin said:
> On Wed, Oct 16, 2019 at 04:03:53PM +0200, Pali Roh=E1r wrote:

> >Now one month passed, so do you have some information when missing par=
ts
> >of documentation like TexFAT would be released to public?
>
> Sure, I'll see if I can get an approval to open it up.
>
> Can I assume you will be implementing TexFAT support once the spec is
> available?

It's certainly something that *should* be supported. The exact timeframe,=
 and
who the =22you=22 that actually writes the patch is of course up in the a=
ir (and
will likely end up being a collaborative effort between the first author =
and
corrections from others).


--==_Exmh_1571241945_33600P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXac/2AdmEQWDXROgAQL74w/+PBT69vQpDRQ38D0E+OMJwMnyCoXnCUU8
8xVZjGM3mGHPtChb9+wO2l8NjtT9XBiDm5r53Yr5GN53Vh1awdp1A2LaK8ba//SA
cQxNjDeVK1aKpJ+mxBAkVsic+h38rR9ajMfGWHtQ/+PT2Co3OmQHmKvyb5VGSXbC
UlTZjfyEpNofW2QjAFPyurkRHD3HS8DiA4e58t9Pm1VavQAr0NgIb8DclCOF2mVj
9HluyEcc9WoYceCqnWwkmT6k0KynYgtouJjteBMMdNlfStdvWOsdmrOvrKnUL3Y1
e+KmwXxg4mOjvlet0FjRtm48HSDIeA8o7kiB697KPSFa/oD9XPcLmg1ck1u/b7M0
HoHJ9fuPHkafe0OOW6T0ZQWWbcouOZh+jhoniakz+sfMrNpDWEcJklWfrs34hJty
6Sy9xQ4fRf3U7eVJTbbNImU4kc+ByHhcvcxkCOJKunKVP5DIliOjstIX2UXSRKGo
RhVTIWmS0Ds8+yuu2p4rpNfnab40G7KCMopq3gIGLEu/feYrUSWSMg0SqhbRsJ3e
gJGhKiUUnLDkiISt3fl8flb1XpbFZJ5OIUcguJGVEv7rpco5ovcgGTsdnXC9IFjS
X2vnUi44X5r/JX5hyBzxHxuUacQdtimzz12sRHCMIJSd0873lqKyTANgeWlYo1He
O0opOSTeAyE=
=QAWJ
-----END PGP SIGNATURE-----

--==_Exmh_1571241945_33600P--
