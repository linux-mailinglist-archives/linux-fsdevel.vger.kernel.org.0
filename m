Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6831C3C3ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 08:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403857AbfFKG22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 02:28:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:57905 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbfFKG21 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 02:28:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 23:28:26 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jun 2019 23:28:23 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] usb: Add USB subsystem notifications [ver #3]
In-Reply-To: <Pine.LNX.4.44L0.1906071000260.1612-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1906071000260.1612-100000@iolanthe.rowland.org>
Date:   Tue, 11 Jun 2019 09:28:15 +0300
Message-ID: <875zpcfxfk.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Alan Stern <stern@rowland.harvard.edu> writes:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> > On Thu, Jun 06, 2019 at 10:55:24AM -0400, Alan Stern wrote:
>> >> On Thu, 6 Jun 2019, Greg Kroah-Hartman wrote:
>> >>=20
>> >> > On Thu, Jun 06, 2019 at 10:24:18AM -0400, Alan Stern wrote:
>> >> > > On Thu, 6 Jun 2019, David Howells wrote:
>> >> > >=20
>> >> > > > Add a USB subsystem notification mechanism whereby notification=
s about
>> >> > > > hardware events such as device connection, disconnection, reset=
 and I/O
>> >> > > > errors, can be reported to a monitoring process asynchronously.
>> >> > >=20
>> >> > > USB I/O errors covers an awfully large and vague field.  Do we re=
ally
>> >> > > want to include them?  I'm doubtful.
>> >> >=20
>> >> > See the other patch on the linux-usb list that wanted to start addi=
ng
>> >> > KOBJ_CHANGE notifications about USB "i/o errors".
>> >>=20
>> >> That patch wanted to add notifications only for enumeration failures
>> >> (assuming you're talking about the patch from Eugeniu Rosca), not I/O
>> >> errors in general.
>> >
>> > Yes, sorry, I was thinking that as a "I/O failed in enumeration" :)
>> >
>> >> > So for "severe" issues, yes, we should do this, but perhaps not for=
 all
>> >> > of the "normal" things we see when a device is yanked out of the sy=
stem
>> >> > and the like.
>> >>=20
>> >> Then what counts as a "severe" issue?  Anything besides enumeration=20
>> >> failure?
>> >
>> > Not that I can think of at the moment, other than the other recently
>> > added KOBJ_CHANGE issue.  I'm sure we have other "hard failure" issues
>> > in the USB stack that people will want exposed over time.
>>=20
>> From an XHCI standpoint, Transaction Errors might be one thing. They
>> happen rarely and are a strong indication that the bus itself is
>> bad. Either bad cable, misbehaving PHYs, improper power management, etc.
>
> Don't you also get transaction errors if the user unplugs a device in=20
> the middle of a transfer?  That's not the sort of thing we want to sent=20
> notifications about.

Mathias, do we get Transaction Error if user removes cable during a
transfer? I thought we would just get Port Status Change with CC bit
cleared, no?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlz/Sf8ACgkQzL64meEa
mQYadA//auaAM9h9MprFzdErulkqH3HmHRaWdSU/kq9mtbaRLTuogqjRpvHqUc8p
MTfNarWOJXGd5K8l8wjKT1LINfnFJSgcUOWE+bx3FFBbtistVC7KQ+ig9lb/+xj5
TdkQa+9uZRkdFYkJrmPUTLjrnj74wNAnydPdqu5hPPcAHS+MCHF3KNTCN69h+s6g
1F2nxcr9/6ZAPlIPtIHy3NW1wqDSvAKIM9nVWwTtT97B0pPAohAcu9/HrteyqyZ5
53cqMqEn+8l430ehCn1IPNhQW9vIYFsxnaUdcRWpgUgEhkhmS8CBNPianolrMvf6
VkWX0cfFSQeA/T/hrjqEfDAN+jaHlNGfBWScnqKupATHEOQtxobyxo/W9Pzsofqo
k05eNr39pwAKaE0Fh+KOtrhnMKe9n3/ePAkYrYHdV30fuqF0WmtWhNw6btIYA30T
2WHtHhJBP+yRu8VU0Y+EICyBF2L2gNO5sp3m2HsrpcQChescr1br7UYVGgXpxt8T
/74wp8DlZB4NKSgrCrmwE3j1CfbgJCgf1KKsEXWUgF+zdVZTuoZVVOqo5G3iOxZg
9Ry8nqLEA0Gz+HY/37wVmSG7hWS/Me7cpQg289uuEll9UXzpVal6oDaZrBFv3jeA
pf6kOp99IqzbPVG/E16BGCdOgb5gwBNb+agM/Rj5jAn3f0BftoE=
=gmf3
-----END PGP SIGNATURE-----
--=-=-=--
