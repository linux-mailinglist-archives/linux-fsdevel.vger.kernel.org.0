Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91E5815FA7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 00:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgBNXZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 18:25:49 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:57240 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727811AbgBNXZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:25:49 -0500
Received: from mr1.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 01ENPl55012918
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2020 18:25:47 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 01ENPgSN005742
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2020 18:25:47 -0500
Received: by mail-qk1-f200.google.com with SMTP id o185so7282639qke.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2020 15:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=kVVJJc06uXlAboQIV2VK0QKZoPIKTMKcPo6lweP/h3E=;
        b=tfcE2P83P/BUB3Omt8iChW+zaZtlZmITVydnWF3w2xIzPUqZxvbPfdT98e+vagCGf+
         Gp3bVoDwV7k+hB6ES7yli7wNLK2upFtn0co1K54m5+2VfCUOjhnn3LakFRW/NdrQjqBV
         S7t8QPejnrDbL/cmrwUC7qUq5T1yk1mjeS6ojNE3CdwV/85Dx+f6bFew/hPYuFLDNc1i
         i73sXCIlvGGPY34N/ILila4z9dGvKx6puIU82lu3BIn6xukHUvJuQWRR1612c+zrY9+9
         XOtdIDSK76cZg9tEG8OZ+SjFjvrNw/wJNyL5OZiJVfVdGOtTGYuhEY5Z9mS5vV9h0zwI
         rkxg==
X-Gm-Message-State: APjAAAU/7N8VcTOC34+MX+iDWdwOGbFQf/zUMQbR87wVdS4ctVW4ZwVd
        twIUMoSZ4dGoP+REVwEF1dNteRmpsoxBK7O5X7Q/boM5AU5RAm8RzzKCTBih9NI8fqiHkTQ8BOO
        7DX5Xm0lrLHtRsiGXKqj9faU94mga/RNuBa1S
X-Received: by 2002:ac8:607:: with SMTP id d7mr4528922qth.271.1581722742404;
        Fri, 14 Feb 2020 15:25:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1OE/nxm2Js8pfbIZcNF3j9fwwMaytLqhXDFRgrEOoAA7rmVH/ZQz4xkH3QAk0MZ+37+biWA==
X-Received: by 2002:ac8:607:: with SMTP id d7mr4528903qth.271.1581722742018;
        Fri, 14 Feb 2020 15:25:42 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id m204sm4343144qke.35.2020.02.14.15.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 15:25:40 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
In-Reply-To: <20200214224357.yv2lwyusi3gwolp3@pali>
References: <20190829233506.GT5281@sasha-vm> <20190830075647.wvhrx4asnkrfkkwk@pali> <20191016140353.4hrncxa5wkx47oau@pali> <20191016143113.GS31224@sasha-vm> <20191016160349.pwghlg566hh2o7id@pali> <20191016203317.GU31224@sasha-vm> <20191017075008.2uqgdimo3hrktj3i@pali> <20200213000656.hx5wdofkcpg7aoyo@pali> <20200213211847.GA1734@sasha-vm> <86151.1581718578@turing-police>
 <20200214224357.yv2lwyusi3gwolp3@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1581722738_27211P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Feb 2020 18:25:38 -0500
Message-ID: <89492.1581722738@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1581722738_27211P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> Idea is simple. Expects that we have a clean filesystem in correct
> state. We load primary/active/main FAT table (just call it FAT1) and al=
l
> changes to filesystem would be done via second non-active FAT table
> (FAT2). At unmount or sync or flush buffer times, FAT2 would be copied
> back to the FAT1 and filesystem would be back in clean state.

Somehow, scribbling on the non-active table for actual changes sounds lik=
e a
bad idea waiting to happen (partly because if you do that and crash, afte=
r the
reboot you remount, and it starts up with the now-stale FAT1 because you =
never
flagged that FAT as stale.

That means that if we started using the secondary FAT, we'd change the
ActiveFAT variable to indicate that.  And if we do that, we need to also =
set
num_fat to 2 because num_fat 1 and ActiveFAT pointing at the second FAT i=
s
*definitely* bogus.

And that could result in us crashing and leaving the device with a header=
 that
says 'num_fat =3D=3D 2', ActiveFAT =3D=3D second, and the dirty bit set -=
 and the user
next uses the  filesystem on a system/device that hard-codes that there's=
 only 1 FAT,
so it blindly goes on its merry way using a FAT that's stale and never re=
alizing it.

And that's actually the same failure mode as in the first paragraph - you=
 start
off using FAT1 because you don't see an indication that it's stale.

--==_Exmh_1581722738_27211P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXkcscgdmEQWDXROgAQIXsxAAnwJ6P42Kc48EOFVYv1sqnEgmMGQ91vRL
Y4QiUeK8AT/sRAa3s4MlvKBFZtI4+qytCf009UgdY9XWnZe4LymHel/ZQxerVllS
pRYWycRCy7RxlRMYycD3gpOR1zOh3W/ijHthSZSeMjwLhFoyypfVXXoj/4e8N/Jw
3jtKbikQWPBi7/agoPu9rLczip/xZlpIDp2guQ0QwJEPxWjneEkDp8K5TAQxxQqR
/EHNgP3YNarPwo8dp+J6IzIDZBLi9VKf+z+zrkmvKW30nCFEVvly3Eoaxwo04mVH
5ElA1VWqnC13rfE2A4CJKHgAKW46Jw9XDhHt3mk4lqzeLoB6s4crjpa94o+SOle7
n6XM45HAuVUhyIzAnRbr+tMmejYZhs6qIf6O89L6LFk+b4Qh9MuIS1PtuZe8964o
EAJlOpGgC8m2Cszz7ZZVisvLUkMiEkqWCWb/84hbv2f6V5EHSHDuRXPa/cSnwTYK
g39oJXDS0vr4coX3L+A9P1v38/dD+Dz13lB3XW+C9BFHaychrSVDBLmYpWf2mrbx
GN185jBn1QXSSJCElS/BDI2gWey4/ro/WpJ1kuZoqCiNcy5pqnd2LOVHxpeX3qNW
PWyZTsFZHwQIgvpqvcAPx+KHCAuAONW2ZQaAcl2/XKgFJp5DtOl0yrycWBRUA8bC
stu0iNTBrxY=
=VpDW
-----END PGP SIGNATURE-----

--==_Exmh_1581722738_27211P--
