Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 060537D7EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 10:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfHAIoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 04:44:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39360 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfHAIoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:44:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so52035357wmc.4;
        Thu, 01 Aug 2019 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wbG1tKcKSzX4oqDDNmN4IBWjESBPU0P0uXP9xiyp8X4=;
        b=EG54Vi8r+AgRGm++comVwkUjejlVCuBURBQsWnPYMYwYeVCBcQK3xmPtHnXG1nG4Jo
         BgM3iktvqBAT+zfcR9kZRjZlMkV/YICQTnNH9ZUg8PZhAJDCtEgMML/SzMREUHHpdRVe
         slJS/jQcP32xNACpDkZVpQlalZ0M9vx6mmn5JTbTmlYpZ1tVhpbloaV8PyA15YMHBYLp
         mFxBRBKUbaWzEknkzyapESiKg+yfvus2kYI/d9+1oHAOJFAZdLLH0vxxkiprp0pko6em
         5AKKCZFotnHQkTGS5PbHoCFqLol+Yu1w6g3edDHI3+mp4cYNUCEbpjXvI9fWnlvdJCQk
         UdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wbG1tKcKSzX4oqDDNmN4IBWjESBPU0P0uXP9xiyp8X4=;
        b=oGf/VkXpaeHDeIFMhu1d8QHXauh82i3FKyqO6v1l/VdcqY4OKdLHfmEx8C+mhnM09q
         OC7+HmqW5R9uEvsIn9G/jHKRPO+mpc5iSakh6igARgxhji7bdmskPz+auavXqkP0HOoV
         0l5BuJayusN8eREd++9zK+RAYm8VkXs+nr1ZgCOEhQQJcIRKD9CRzWDi7gfJFMfymh38
         RHn8ryd1iJt7ZXbMEng6zKGAmkSQcmLIKN7SJx8bS2I2CN1j3u8eBkqqt47kiQZ5Np9B
         giYB0zn99USLhw08j1rnY31apvMEFCGCLej8veWEheisdhseQjfbvEEm9D4heaeoNNbt
         FYtQ==
X-Gm-Message-State: APjAAAUC7Bd+IazGVapMZFwogkgnSmWzspfCj02XAq9bN4WvI3joLkw/
        FOjhx06dogeE3tIwxZuetv0=
X-Google-Smtp-Source: APXvYqy/fvWuSBBAPRPVG+qUHIVz9oF4Zn1RQcucbT/rkf2Z7BGfRy8C5b9vV+sqpowWy2PfOZJXVA==
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr108894065wmj.64.1564649053607;
        Thu, 01 Aug 2019 01:44:13 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id w24sm55282939wmc.30.2019.08.01.01.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2019 01:44:12 -0700 (PDT)
Date:   Thu, 1 Aug 2019 10:44:11 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Roald Strauss <mr_lou@dewfall.dk>,
        "Steven J. Magnani" <steve.magnani@digidescorp.com>,
        Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: UDF filesystem image with Write-Once UDF Access Type
Message-ID: <20190801084411.l4uv7xrb5ilouuje@pali>
References: <20190712100224.s2chparxszlbnill@pali>
 <20190801073530.GA25064@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="inwxaplukm2xspax"
Content-Disposition: inline
In-Reply-To: <20190801073530.GA25064@quack2.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--inwxaplukm2xspax
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 01 August 2019 09:35:30 Jan Kara wrote:
> On Fri 12-07-19 12:02:24, Pali Roh=C3=A1r  wrote:
> > Also in git master of udftools has mkduffs now new option --read-only
> > which creates UDF image with Read-Only Access Type.
>=20
> I've tested this and the kernel properly mounts the image read-only.

Roald, can you test that problem which you described to me with
read-only access type is now correctly fixed?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--inwxaplukm2xspax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXUKmWQAKCRCL8Mk9A+RD
Us9IAKDBKpXCN3FssjdZETAu9KuhlTIURQCdFNIBQrFUPHRjge4zkW8cnEAImkE=
=ItTT
-----END PGP SIGNATURE-----

--inwxaplukm2xspax--
