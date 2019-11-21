Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD211048E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 04:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKUDSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 22:18:42 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:52562 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726165AbfKUDSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:18:42 -0500
Received: from mr1.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAL3Iedb032722
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 22:18:40 -0500
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAL3IZhC018443
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 22:18:40 -0500
Received: by mail-qv1-f69.google.com with SMTP id w7so1328058qvs.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 19:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=cg+2shOc6SicoqPkRoJforXhXtvL9y88wQkMj9c5iCs=;
        b=qkRlhtljEiMsiGt8U1KYMgmlPRMacWQ3C+06jOFte5AG0Z6LNA0PpZdxUJX0efJj+v
         CIb13TftPiiapuA6u+I0ZpyzwBSKFHPRMbrcSfnfH8HCfWNaES4NhL13bRAH658hDvqE
         uJLTif6QVUUI87YgIlvcjQYFWw+MViQCWMT6jLIzgz4wYD/ETU0yFgi1ktHuamZqSZOZ
         55dNOJgwFL37yXKYnXWOXmRlU8rTx5g1OY6hvKKtf5Eh0qVenpxSCM0CSx9+dRez90hF
         tH/0gHGnIMdIIFi+u+ZdnTzgnSgB1GVn40KrRNKBt9N9KqzxNGAYQN9FLdu+D1c7B3+R
         ZRoA==
X-Gm-Message-State: APjAAAVkzTknYdKUx8Rb3ErnWZbs/OSDvHkBD45/OCGJ4iPF5vZXkQ5K
        7QEDAA25PXuEsg1GzhN4H99RgIBu2D8iPFLat1AD9g1g9mZQQ41VjMQlYtJvE4njOofJsJ0E0Lk
        Flu2vGrAi9ieyyd2jEgOA1NSUOVoU6s1GUv9U
X-Received: by 2002:ad4:57aa:: with SMTP id g10mr6231747qvx.164.1574306315607;
        Wed, 20 Nov 2019 19:18:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzODEaEh9xbqWaXWEtTNnZemrPdQzP1qOFLFwr+NFG7iRn0pn5hCeSay8detYrRuKGJDMetQQ==
X-Received: by 2002:ad4:57aa:: with SMTP id g10mr6231736qvx.164.1574306315308;
        Wed, 20 Nov 2019 19:18:35 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 11sm699417qkv.131.2019.11.20.19.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 19:18:33 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Namjae Jeon" <namjae.jeon@samsung.com>
Cc:     "'Nikolay Borisov'" <nborisov@suse.com>,
        gregkh@linuxfoundation.org, hch@lst.de, linkinjeon@gmail.com,
        Markus.Elfring@web.de, sj1557.seo@samsung.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/13] exfat: add file operations
In-Reply-To: <00d201d5a00c$e6273ac0$b275b040$@samsung.com>
References: <20191119071107.1947-1-namjae.jeon@samsung.com> <CGME20191119071404epcas1p4f8df45690c07c4dd032af9cbfb5efcc6@epcas1p4.samsung.com> <20191119071107.1947-6-namjae.jeon@samsung.com> <398eeca9-e59f-385b-791d-561e56567026@suse.com>
 <00d201d5a00c$e6273ac0$b275b040$@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1574306312_2911P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Nov 2019 22:18:32 -0500
Message-ID: <87255.1574306312@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1574306312_2911P
Content-Type: text/plain; charset=us-ascii

On Thu, 21 Nov 2019 10:42:13 +0900, "Namjae Jeon" said:

> > > +		if (clu.flags == 0x03) {
> >
> > That 0x03 is magic constant, better define actual flags and check
> > clu.flag == (FLAG1|FLAG2)
> Okay, Will fix it on v4.

Make sure you catch all the cases.  I seem to remember a lot of 0x01's
in the code as well....

--==_Exmh_1574306312_2911P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXdYCCAdmEQWDXROgAQJAURAAvTo5FUXHjx0W9lf/y635s1e32qu8W0v6
SD396lHlTWVmmx0UtNX17HfPrXSNXrrfQACSISIGIttnMyy38GEmhRWyieGdIrnk
QPnW32RpXra1yrXSPDosTGCof4XKzA2QBj0HddOcvEMs2ybQ2cmLG8lH0UO8/TEo
/n0N0wmCd7ooEYAlv48OO/A6M0ABHhpaevZzLILod5aMrAuN0vmYs7+Klrcit+Vm
nh/LJQ+x5GgAiCzJQC+FcBpYuLdx94cPYj9RsZoLJOcta9/MXk2EmZbUoyfT3YRa
jjTDEYg/oLioV8NgLP+fxR0QdEyNb5eNMNLhta8Gf4E5oBVfW7VGNbfrUh8IZ+ec
e0/0Rhcbt9kqh+I+OmS/qh+eZdI0tSzvL2oYNO+t9U4poDlVVdMGnWHS/F8g5Mkh
fIPweH0/Ltyyicl4pjniWx6XMsieAQTHTg/Nim/T46JcBbidkmhPW9f2WRavMKEU
z7A1x0CiXdeOUoSl3jIK7in8T/0EQObYWj3rVHIBy7j+hWh46uYNywlXhBf9dpwb
J/k4RfoUm9A1RktsSW5beaDNfx+BXHO5dObnzXMtqg4NjbKJoJiQmjj3kX6Jy9Ax
HPinyYu0TRHFskyFY+6pOLdiPqP2O8BWfQvYPnkjhapJ7XNimbu/9ZCKckqadyhT
46IDO6veYfo=
=OYei
-----END PGP SIGNATURE-----

--==_Exmh_1574306312_2911P--
