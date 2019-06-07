Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B926838483
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 08:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfFGGlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 02:41:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:49807 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfFGGlE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:41:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 23:41:03 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga008.jf.intel.com with ESMTP; 06 Jun 2019 23:41:00 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] usb: Add USB subsystem notifications [ver #3]
In-Reply-To: <20190606153150.GB28997@kroah.com>
References: <20190606143306.GA11294@kroah.com> <Pine.LNX.4.44L0.1906061051310.1641-100000@iolanthe.rowland.org> <20190606153150.GB28997@kroah.com>
Date:   Fri, 07 Jun 2019 09:40:56 +0300
Message-ID: <87imthdhjb.fsf@linux.intel.com>
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

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Thu, Jun 06, 2019 at 10:55:24AM -0400, Alan Stern wrote:
>> On Thu, 6 Jun 2019, Greg Kroah-Hartman wrote:
>>=20
>> > On Thu, Jun 06, 2019 at 10:24:18AM -0400, Alan Stern wrote:
>> > > On Thu, 6 Jun 2019, David Howells wrote:
>> > >=20
>> > > > Add a USB subsystem notification mechanism whereby notifications a=
bout
>> > > > hardware events such as device connection, disconnection, reset an=
d I/O
>> > > > errors, can be reported to a monitoring process asynchronously.
>> > >=20
>> > > USB I/O errors covers an awfully large and vague field.  Do we really
>> > > want to include them?  I'm doubtful.
>> >=20
>> > See the other patch on the linux-usb list that wanted to start adding
>> > KOBJ_CHANGE notifications about USB "i/o errors".
>>=20
>> That patch wanted to add notifications only for enumeration failures
>> (assuming you're talking about the patch from Eugeniu Rosca), not I/O
>> errors in general.
>
> Yes, sorry, I was thinking that as a "I/O failed in enumeration" :)
>
>> > So for "severe" issues, yes, we should do this, but perhaps not for all
>> > of the "normal" things we see when a device is yanked out of the system
>> > and the like.
>>=20
>> Then what counts as a "severe" issue?  Anything besides enumeration=20
>> failure?
>
> Not that I can think of at the moment, other than the other recently
> added KOBJ_CHANGE issue.  I'm sure we have other "hard failure" issues
> in the USB stack that people will want exposed over time.

From=20an XHCI standpoint, Transaction Errors might be one thing. They
happen rarely and are a strong indication that the bus itself is
bad. Either bad cable, misbehaving PHYs, improper power management, etc.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlz6BvgACgkQzL64meEa
mQbHWA//alAxWfE7N7D+w/lSXSIZSiBqlrME+vIZMZvLXt1L3QgGugGyks7F0vZg
GaYpsclw6LHhR0Nxjnb4h4zEEKidtzSGjPFEW0ghtmTOC+vPzqyxuiHuKIXUFFyJ
7PSoe583uk8sEpPMPi9+imXjjBlgCylCHsI/7JIVNFPx+fZEpJXXffJQZsnELoib
F6DI9+uaDCSqCpduSOwxEqx28bE7SKMugJV3CjHSFKLY8n+u1PBFlMJEgulNUCro
Lum8WN98AnNfUVtinU4mUONIW2dZGaxxIhVdrKMluixEn9+O3zal0Ot2YAnLruvf
mG4d+zsKaPojOB4Trze7F9FQQgaDprzqLg6BgRS3rZTiHBYgwcblPuBZosLeGttC
T/mI4bp+4zqJ36cl9hXh4w2VbyN1qwlqvZ3qwQJahcuTYGVIne/JIz+4T8A2uf+v
FRUmw1gZxjVBC/KI/VGUY0raq7DAbk55YfXLF2tnYc6sG9a51VQn0xy7L/rtouL/
VQygKOay7wPw1k9lEUpJzgqwBg2s1Xv+5Hj4CeE91sboglzhRXl62MPg7B4KUFfM
paMco4/bCwZ5kc/4N2SZd0SgKFGGbyDVg+uvB610vU6cu0V0WaQLQ6W3WCnxvUel
04A0dGEf9E7/A/m8OLiv0ARjWfmc7BIVCLSAoGw5Gkv6MGxsrKA=
=Dh4b
-----END PGP SIGNATURE-----
--=-=-=--
