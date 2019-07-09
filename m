Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02F6393A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 18:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfGIQWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 12:22:10 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:47788 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726238AbfGIQWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:22:10 -0400
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x69GM8IK014061
        for <linux-fsdevel@vger.kernel.org>; Tue, 9 Jul 2019 12:22:08 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x69GM3jB013919
        for <linux-fsdevel@vger.kernel.org>; Tue, 9 Jul 2019 12:22:08 -0400
Received: by mail-qk1-f197.google.com with SMTP id c1so19665705qkl.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2019 09:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=AeNqLIavBQU2jaz1EVONE/nn9rzf6yeKY0A80d2Rc5I=;
        b=YxeAqmC1IFz3cGb+i++Mr7su+fY4xb84IAhyd+4JgJQRuudD0+b1NR12/CWDzFO61k
         ZqSLSlvpnTSYwBxe3bWMEm/2S2qoNxD/GLNelsp0CdCFOx3Kc4rkSr4tFJBUWkpTAlNO
         vTN1G1N8ay7nnMzEgxkpRxQpQ7LbK/L/HRSHaA7TmJxCFSI2aL0y3TUAbncts1stabUF
         e6oqke0eKq8o+RwKY5yP7rZE9oc81/5SqiaHeCIOcLa8HE8L088LV4tsrLMoGjoiBF83
         ORu1fyfi5tVyqchwsid26jVxhTMivd9YrBQ7TbIZAO8sN+Vt/9FE6M2KlZLeM99MatyT
         MfCA==
X-Gm-Message-State: APjAAAWxlRhl0fSSSw8N3MW0cHKPDsg58ElPCc5TP3KwCsC+hAQb0enS
        EbBKl3DfK1FFrr/oQQOlp+qvbtZpPhAYUgmOam8KGm5mD2EDniPmPT0rYU+vdHxYDdXgoG+jJbi
        3+hFa9O0QypH5IcGB6ef5lZbH5dnJmTVHUKSp
X-Received: by 2002:ae9:d606:: with SMTP id r6mr19014450qkk.364.1562689323258;
        Tue, 09 Jul 2019 09:22:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz73ZAgK9eZK6CI+vjMNwlRqTNw895f8ZNT6RNkI7Yk9A4kFfUyb9h9brqr19IgxqlljVxO4w==
X-Received: by 2002:ae9:d606:: with SMTP id r6mr19014424qkk.364.1562689323029;
        Tue, 09 Jul 2019 09:22:03 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::7ca])
        by smtp.gmail.com with ESMTPSA id x42sm2490742qth.24.2019.07.09.09.22.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 09:22:01 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, kys@microsoft.com,
        Sasha Levin <sashal@kernel.org>
Subject: Re: exfat filesystem
In-Reply-To: <20190709154834.GJ32320@bombadil.infradead.org>
References: <21080.1562632662@turing-police> <20190709045020.GB23646@mit.edu> <20190709112136.GI32320@bombadil.infradead.org> <20190709153039.GA3200@mit.edu>
 <20190709154834.GJ32320@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1562689319_2389P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Jul 2019 12:21:59 -0400
Message-ID: <22959.1562689319@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1562689319_2389P
Content-Type: text/plain; charset=us-ascii

On Tue, 09 Jul 2019 08:48:34 -0700, Matthew Wilcox said:

> Interesting analysis.  It seems to me that the correct forms would be
> observed if someone suitably senior at Microsoft accepted the work from
> Valdis and submitted it with their sign-off.  KY, how about it?

I'd be totally OK with that....


--==_Exmh_1562689319_2389P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXSS/JgdmEQWDXROgAQLYWA/+IsHeZtVAiVMZ6bjpDTfWqg6B1nIV/psL
Cqhyj5AcsxgpCLQHrtFhyDIB4suPWa9Mqlglg00eTBsQe1DYRwVK30IQRXHrgXaV
xwIuN38RaP3XQjFeczUUTghvPhirnQ2CDrV9q13jgKs/AvPIFotNG/XDawDK2zvK
nTAepX1mJ9zIom4xcZIz4nc/m/qsmwQAoVEGywmeXGcapFTVpI3yErsOnwW5B8V1
45zsfLrZOU3GuSZ61EMSJRe3UH50kNppQbmUCfVEE3yoHI7kqNM1Qhhjwx/6YfNI
5kyPHq5gEv1sbUFg+VXDmI7JseXdl4jB19XRu8yOjQxQB1Vpd+5pjsUr89d+3R5Q
8oX2TapLS0W+BozW3eFWhVdY610xqkCEDR9h+2wtrgV/bpXG7Prva0hQE/qscHYQ
4Azo1lkwUKKYOKR7aYVfXtq+mztND3nxvMVvUQWNdwiWXDmHpGVp1Hps4ZWdFZKJ
Z8654wqKIi6VG+SPvpG596hbMnEhNRIKkievWZF7Rue50Z+uiwHySQuGOjlYabdC
LD4r/E6RzgiayvKqn0akjVK89tx/lUhAM9kGvnaEF8xKmMIARY5kpAPL4/xCi7sT
ZdmA6KJEr4vfIcZTyYI7elGlyUxpdfO0pMU+GgUuXRwKQiIDfgus++Gr6RUul/Zl
zsOlhd3mjmg=
=h3KC
-----END PGP SIGNATURE-----

--==_Exmh_1562689319_2389P--
