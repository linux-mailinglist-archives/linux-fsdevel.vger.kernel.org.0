Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E23A3AAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 17:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfH3PnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 11:43:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52872 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfH3PnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:43:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id t17so7834051wmi.2;
        Fri, 30 Aug 2019 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSPruanynkI2nxLpUzm3uL7IYac5dvQ3oQe3jl6VLFU=;
        b=nfnaCKLdbctQKQUkacHhaZsoiKIsJEgXtg5ZQt+aGp5XFQAijpASM1A5BmrlCejEQK
         kOn9FIrc5vpJ8YLaYL5eFAK6POudjWvd6F6UG2MjC9FsdgStYp/LLU4N80UDo9w+txIr
         ZGCd4rjnswWooLVkkdd044Q+cVTRymuE5uFn7bixg5CDB75cQTdTxkGKIGk7s3p0XF3C
         mW7IruyFo9/JeAeQbgl0gjnPxXc9pjhPpkWJN1bw8srfRh90bwbtmbH8FjhFG3ChGLHs
         WkPLgEhVf1WASqNOUcy7tq/HeiBFrg2VH8GJpxQjkFcM9jZuvT3w4VRgxoR1A6Ct88VY
         FewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSPruanynkI2nxLpUzm3uL7IYac5dvQ3oQe3jl6VLFU=;
        b=oITyu9nqKJo9kYrfS6lxGMIOL3bf+lu/Nbsv6Xln1SQyxRIi6BhYBj+pg+dF5HsRoI
         eJpSdDUkDlY4XlFC9XJNDXfHuQ64rPdE7BU3PcWrk5PfG9HupbvuNFdriYgColF6lZpk
         TzXaZhKeTvdU/scpZRUXX7ZfzDbViiuPnYHVvmHhTfBlWw6H6F3aNP/otmIJSCqBtS7p
         BAUyJ/sLycPiDG9+/TZppccwJ+BG7y2wq+hr7dyr4QKTsnQl+Lzxtq4qsYbev/gB6xi1
         bYo/lnlxhYQe9t0RtXk4YIbC74SKgR4agejGkP7oD/8vYIVpdXYz9sulxD9oCUxQJ44w
         mynQ==
X-Gm-Message-State: APjAAAW9HsyIacA48t62ZW1HngNf+WfViBS1h7KCfzt+xIRI2uZt1xJQ
        oyXO7ZccwExtGD1jzPzqjoo=
X-Google-Smtp-Source: APXvYqzHRdHs4oKVvSRpy8X7yKHta2hE6g56Kl/oPBafz13i4AYYofq0MPcNwspxJ4vIBJRN+3KfyA==
X-Received: by 2002:a1c:3944:: with SMTP id g65mr19938452wma.68.1567179800378;
        Fri, 30 Aug 2019 08:43:20 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y3sm12403115wmg.2.2019.08.30.08.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Aug 2019 08:43:19 -0700 (PDT)
Date:   Fri, 30 Aug 2019 17:43:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190830154318.ppggurnejlgtrly5@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <20190830154006.GB30863@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r4iv4rpxa6pvfbis"
Content-Disposition: inline
In-Reply-To: <20190830154006.GB30863@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--r4iv4rpxa6pvfbis
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 30 August 2019 08:40:06 Christoph Hellwig wrote:
> On Thu, Aug 29, 2019 at 10:56:31PM +0200, Pali Roh=C3=A1r wrote:
> > In my opinion, proper way should be to implement exFAT support into
> > existing fs/fat/ code instead of replacing whole vfat/msdosfs by this
> > new (now staging) fat implementation.
> >=20
> > In linux kernel we really do not need two different implementation of
> > VFAT32.
>=20
> Not only not useful, but having another one is actively harmful, as
> people might actually accidentally used it for classic fat.
>=20
> But what I'm really annoyed at is this whole culture of just dumping
> some crap into staging and hoping it'll sort itself out.  Which it
> won't.  We'll need a dedidcated developer spending some time on it
> and just get it into shape, and having it in staging does not help
> with that at all - it will get various random cleanup that could
> be trivially scripted, but that is rarely the main issue with any
> codebase.

Exactly. Somebody should take this code and work on it. Otherwise we can
say it is dead code and would happen same thing as with other staging
drivers -- ready to be removed.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--r4iv4rpxa6pvfbis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXWlEFAAKCRCL8Mk9A+RD
UhoKAJ4vZsLuZYAJ6Er06ChAjCyn4WGWCACeLwf/3Q10nG7S6qqrLYFhUaO8WJQ=
=F393
-----END PGP SIGNATURE-----

--r4iv4rpxa6pvfbis--
