Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38081B6BD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 05:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgDXDUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 23:20:04 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50458 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgDXDUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:20:03 -0400
Received: by mail-pj1-f65.google.com with SMTP id t9so3394465pjw.0;
        Thu, 23 Apr 2020 20:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ZH9Ac1Wv4hWojn5xkvRonxutV2FsugtsUJq4hlyFEA=;
        b=PnxH2jhhIDXJ6PLHs938LWZkEJEX9NUH1qukNaxoIQ2x/TjZ7KJq8LBGviiYcExSD1
         7DQTg+bo81nXiVETuhwJHbhoTHMf3hOwEEx/4Nv2v7hFfLE1956LBIYvI8sGwGx433Qy
         A2Gx1ovn1BZs9aRPOgsUmO779WHUNUtLbiRs79dN9lT4jH+x7q+6GAw3ZBb1eqNKg2CB
         jzL8gxso4tTWK4SsNB6yZ2LC0y0Z6PGf+HDvQwm6hHkCHLwlcw8eb5iCjx/aprY7HbrC
         3GnimgDvVjY8McCew58S7vIhrEHraHtbqADH6I5qUpSUOaXNJmtixRjjEAxK5pm4my2i
         +hXA==
X-Gm-Message-State: AGi0PuYyGe47pV4XWIIGxY3BYTrGe5i/MgUnes4Tfr8EejIM7I+k1ZnB
        BssDmwpEFuyMxTjJhCoqIA8=
X-Google-Smtp-Source: APiQypJg1Oxrz6E0AuvPBFm5A7ok+QMisdqXvZjdu4zhXFw/iM9e/WwuPweVrTHBWitBpiXEa8tkOw==
X-Received: by 2002:a17:90a:24e7:: with SMTP id i94mr4175199pje.117.1587698401571;
        Thu, 23 Apr 2020 20:20:01 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c28sm4101785pfp.200.2020.04.23.20.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 20:20:00 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 459CA402A1; Fri, 24 Apr 2020 03:19:59 +0000 (UTC)
Date:   Fri, 24 Apr 2020 03:19:59 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jakub Kicinski <kubakici@wp.pl>, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, maco@android.com, andy.gross@linaro.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        markivx@codeaurora.org, broonie@kernel.org,
        dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] firmware_loader: re-export fw_fallback_config into
 firmware_loader's own namespace
Message-ID: <20200424031959.GB11244@42.do-not-panic.com>
References: <20200423203140.19510-1-mcgrof@kernel.org>
 <20200423180544.60d12af0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200424021420.GZ11244@42.do-not-panic.com>
 <20200424131556.1dbe18aa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline
In-Reply-To: <20200424131556.1dbe18aa@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 01:15:56PM +1000, Stephen Rothwell wrote:
> Hi Luis,
>=20
> On Fri, 24 Apr 2020 02:14:20 +0000 Luis Chamberlain <mcgrof@kernel.org> w=
rote:
> >
> > > > Fixes: "firmware_loader: remove unused exports" =20
> > >=20
> > > Can't help but notice this strange form of the Fixes tag, is it
> > > intentional? =20
> >=20
> > Yeah, no there is no commit for the patch as the commit is ephemeral in
> > a development tree not yet upstream, ie, not on Linus' tree yet. Using a
> > commit here then makes no sense unless one wants to use a reference
> > development tree in this case, as development trees are expected to
> > rebase to move closer towards Linus' tree. When a tree rebases, the
> > commit IDs change, and this is why the commit is ephemeral unless
> > one uses a base tree / branch / tag.
>=20
> That commit is in Greg's driver-core tree which never rebases, so the
> SHA1 can be considered immutable.  This is (should be) true for most
> trees that are published in linux-next (I know it is not true for some).

Cool, but once merged on Linus' tree, I think it gets yet-another-commit
ID right? So someone looking for:

git show commit-id-on-gregs-driver-core-tree

It would not work? Or would it?

  Luis

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEENnNq2KuOejlQLZofziMdCjCSiKcFAl6iWtIACgkQziMdCjCS
iKfQBw/+Lzzb2oD/yCkznS2KCv3QtuujHr6furDP2sZuulh0i5pEYb/BuZAGsXtG
UzziOSQlZvcl+p7LoC8iTBDh3MW9XPDU6nLNqQCKucnChjJTIRm4S/8Uv+YjHwGx
z3K0510W+SHIBIfaqyabSdm6bdYa9hsiKUYT0OB2iuRds/YaMF0cIjcIbK9zBLQ2
v/YfCzZdVc66TE1N9FgpUNPBEp9OBXE/inMgYuc2cf3Fos3JTxOyEe20mxky/Byo
wvuAnHI2o/xkptwcM9ZvEooK64T5RWd6ZeCP4qV9WnZnbjaR9LjtjMcjRI/a5TyT
vnzsZaG7Xbc/DGftHopb0697MZUwqC+zmIeVLH4pt/yVjQ2EJ0UneE9/GndRkYeZ
h4qqDLGsWIa4Aa0yTplL9E1p6VQkI0jI4O098c03rVZDvNh1pDDfgxkSaPEe7EQ7
pgmph857K4K1mARA/DwVbDqvTDplnmAxpEKoMqVEFNCqrbyADE2rT5j+pPmqfg5S
ZB3FNreSHLP8TE6Q51PgSrsb5ZoSPLdVzgxb/V1Sp3+2OZDddOvyTNzdDx0MY2jp
nG/IzaQdp2Rc48wAMrlAUoWEpANkL7ECzfpYhyW94zG3kTs0oxjxfa1jT9qY0L6S
8SI8B7idrEZ+BDqS8TIoTRuHAiykVQJSf+BRcFGt3kFwb+90g08=
=kP8g
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
