Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A38134A31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 19:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgAHSIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 13:08:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32939 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgAHSIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:08:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id d139so222886wmd.0;
        Wed, 08 Jan 2020 10:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TsH7XwJsxGx79w1TgjxocPZkHP3L9pmyXlSJue7R1zY=;
        b=bNhBQkNipNM+U5oZXVkCtwzbIMtrif3bevutws45HsRlSt5Ziefr5nGdo+G7EbrC98
         7Lv81PAZcYVvdd9DEhte3LKDhZl3Y7lRb3S27Uql405vwHRXxtianeqMGmrA/rnhFIDX
         Xif0pvfmVPLcn3HeGuYqC7Nb2A2TFCnrW/qKCclTXEqw/qMlHRVIAHpfjJxVcJH4qvkT
         xPeryvhcWkbdDOYUw6xAnCuCA8CsBtbuHfA/nrMGPDO+h03dIH5RSCM+iWWlk8o3iJVb
         rEb1dk/ZSSnXHpATqpZWWWO5osDkwP2WxE50+Fwxfg6JV0NTspnf4NcfjiN3Vw38ZB+D
         ceCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TsH7XwJsxGx79w1TgjxocPZkHP3L9pmyXlSJue7R1zY=;
        b=cVI59f+abh6O4elXakPRseBv9mRe/hQLigROpV6haebHR6CPhrDjDquENj2xrnbaNG
         0vEl4TXe3+xkpAPm+xmtMka8kWEYYu6sCrypCu5/2PBIEaouNR3Q01QnZaHRn6GupOzk
         iShLF+7Odv56EpFA5aPVkXiff3HOd4i0l5A91LoXZ4bw8cRW6SayNdNwPwUsub3oablo
         B6f5T+1raktgxdvjclfcjbvr+NHIV3GbXs9ucD6sTdRw0AUq+3Rs19AGBAehCd62X/Sq
         EEKMnvqnCODM3koi4FLI8nLRwFaIRyP5sOgwQq0HQroKj8Xsp5Y9jVJBZYPaTGKeAkk7
         vaHw==
X-Gm-Message-State: APjAAAUCF4Q1vyldPNbPMqBU2IT8OcidvKBay9YF1Vu/7OeQiahQvu4n
        ZeDGXnXnBwysphp2IiAztrI=
X-Google-Smtp-Source: APXvYqzb52ciHpxWj4S2VreD0O8TqU8VrrYGL79+Si8Y/iUp06P6U3SIIUXSDmrNiB0vrqBEtzpBLw==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr5037527wmj.41.1578506901791;
        Wed, 08 Jan 2020 10:08:21 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u13sm4828628wmd.36.2020.01.08.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 10:08:20 -0800 (PST)
Date:   Wed, 8 Jan 2020 19:08:19 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [v8 08/13] exfat: add exfat cache
Message-ID: <20200108180819.3gt6ihm4w2haustn@pali>
References: <CAKYAXd8Ed18OYYrEgwpDZooNdmsKwFqakGhTyLUgjgfQK39NpQ@mail.gmail.com>
 <f253ed6a-3aae-b8df-04cf-7d5c0b3039f2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="derhsrcp37i5wips"
Content-Disposition: inline
In-Reply-To: <f253ed6a-3aae-b8df-04cf-7d5c0b3039f2@web.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--derhsrcp37i5wips
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 02 January 2020 11:19:26 Markus Elfring wrote:
> > I am planning to change to share stuff included cache with fat after
> > exfat upstream.
>=20
> Can unwanted code duplication be avoided before?

+1 Could it be possible?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--derhsrcp37i5wips
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhYakQAKCRCL8Mk9A+RD
UuliAKCXKFoMYqa11qTgZaLSQ+MrN6cbjgCeLKReEtMg7naHIq8LizLpDyGSRKM=
=Udmx
-----END PGP SIGNATURE-----

--derhsrcp37i5wips--
