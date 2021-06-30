Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8D3B88D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhF3TBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 15:01:34 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17467 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhF3TBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 15:01:33 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jun 2021 15:01:33 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1625078637; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Wy+4g0wLKmmjjpZfdyNsSDLqP2H0Hxfzq+0KVJzka23oVEc8wZIZRtW/S4NuvRAM8QzqgRWUc6XQxEcEOewB6Z+RqydX4K1WFLJfO1E/gcEvd0f7dRCTzqPCaMmXKzO5n4DF/GXb9MRVDej158y4ejmrB2hMtZ3lyg8sRlauzxY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1625078637; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6x1NkxpRZsiaFxx7Ph5K9AF96LxiYqWgnR2JhyGMcFI=; 
        b=HXaw/0OCRKumHq/YCnQtx+zUHurTkw0G/ujUisSajgZRbmCbGHunwTyw5MbOZevNqkQSchRc409fMkAorRpge7SPgItx1TpmnmNpckeGC9SsbWWXBGkP3ZZpuDZPMXaioh5324KguzND4MH3IvvJxosU8F648mELEw0DTGk5rck=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com>
Received: from dlrobertson.com (pool-108-51-207-71.washdc.fios.verizon.net [108.51.207.71]) by mx.zohomail.com
        with SMTPS id 1625078635564291.4883579327469; Wed, 30 Jun 2021 11:43:55 -0700 (PDT)
Date:   Wed, 30 Jun 2021 18:18:14 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] bcachefs
Message-ID: <YNy1Zhm+W6rODPBq@dlrobertson.com>
References: <YLgPSZ9LB/LErNw2@moria.home.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p9/18pF7m2xJ3a9h"
Content-Disposition: inline
In-Reply-To: <YLgPSZ9LB/LErNw2@moria.home.lan>
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--p9/18pF7m2xJ3a9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 02, 2021 at 07:07:53PM -0400, Kent Overstreet wrote:
> bcachefs is coming along nicely :) I'd like to give a talk about where things
> are at, and get comments and feedback on the roadmap.
>
> The short of it is, things are stabilizing nicely and snapshots are right around
> the corner - snapshots are largely complete and from initial
> testing/benchmarking it's looking really nice, better than I anticipated, and
> I'm hoping to (finally!) merge bcachefs upstream sometime after snapshots are
> merged.
>
> I've recently been working on the roadmap, it goes into some detail about work
> that still needs to be done:
>
> https://bcachefs.org/Roadmap/

As someone still new to the bcachefs code, I'd be very interested in this topic.
I'd be really interested in the testing roadmap as well as the feature roadmap.

Cheers,

 - Dan

--p9/18pF7m2xJ3a9h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAmDctWYACgkQRcSmUsR+
QqUt5w//fujl6Z6TrpHtVyxcxYLWdBVGTtWcYIm6/5+0eABsJH1gEtnvfC8KEr8u
R+SfH8+LCYJsyebn+UxCQYpWGtEg/3dDFqH2se+AIWgBdCF5YB7+nhygNEYqBX1F
93ZOajY0iSDxbEEd0s7DtMTGJVh0pxmOoQMTQhfaP1cQ7jy6fE0m0wT5BgpwmBjv
wtipm56gmU/RaRRmJNVDiJvJXQX/iQixuRJ492o9Fawzk1Yw+9yotgkr8HkWgDjl
McFo6+lFg1QeZtfu0KngdHO9WgczqkqOk+RG//UE4JOCgULrDcLExBQ1aTaT90G0
nSMU5TnHV1SjVVb6hgLDhsbhoyZMvAeQfOO3xE4UEs029P1Eilo3KzWS7KL0ujRu
SG4l3PJtTn95OlktDFB8561dqMClKc0FJH3d1Hl4AcAyps7yz9/uuufZkzwS+ixc
BxZgWZcvDe0OwhG2a1LRe+/rsT3/0uhzqdoVh6MMZdMSeRS2HkdtVQbPsHKexVd1
DYhZYxt8MsxsStFT+buv7LvxGcNyyw/BVus1+9tHV4mmhUGPVPa5hRQufwXDqIsU
VLBFzWvdg+7bZ+8vDKQhGxLqUFZpGktyQYEGOrmBtgmBPFQp3ahR58aPF5WrqlmN
XWWsRdhofiqCQtmgdniNR7CVpRz6Zsvor68KZTd0IybpotWA9dA=
=nlG9
-----END PGP SIGNATURE-----

--p9/18pF7m2xJ3a9h--
