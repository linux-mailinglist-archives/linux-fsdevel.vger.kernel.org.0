Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88D8167C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 12:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfHEKIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 06:08:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:60660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727259AbfHEKIw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:08:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D916FB616;
        Mon,  5 Aug 2019 10:08:50 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 05 Aug 2019 20:08:41 +1000
Cc:     Sergei Turchanov <turchanov@farpost.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: seq_file: fix problem when seeking mid-record.
In-Reply-To: <4862a29d-7e4f-5bc5-dcde-ec9ebafa1ff2@web.de>
References: <87mugojl0f.fsf@notabene.neil.brown.name> <4862a29d-7e4f-5bc5-dcde-ec9ebafa1ff2@web.de>
Message-ID: <87k1brkjpy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, Aug 05 2019, Markus Elfring wrote:

>> Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code
>> 	and interface")
>
> Please do not split this tag across multiple lines in the final commit description.

I tend to agree...
I had previously seen
     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n"
warnings from checkpatch, but one closer look that doesn't apply to
Fixes: lines (among other special cases).

Maybe Andrew will fix it up for me when it applies .... (please!)

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1IACkACgkQOeye3VZi
gbnoBw/+MWg2FKi+/XtUwIZGJ/Tj0U+YInK6cGf0qPoZLteDdWng3VCtF2J+XphI
rX1TVSY9ihM6uIoJAT7SeILnS2m7IOfCgfxkM/8avqv0Opy6ar9TWlKKXCGFx+yL
BHXgmrH1Z4LkyQrovPhCwi/++AHkuCSy3Wzb+9OahRSGxTCjCoSQXCksPXWlDShU
IL+/bmGbVHvaFic6AiWeElMfHZrg4WXeaxXM9Rp+mWFbZhaWI7TIEyD9odd2tdxk
mVMZkY5v74cDBkywx/K9yYfZ3qBwH5PS6gGodcmZisrSoyEzzR0PTGA2+AUyEiqV
cWiGfYVzwfNHeRvoDGbikNOyiApRABuBXpqr5bmiRq9F98WJSpESStOtHMziQv6/
pOD1TMvdEQFVL3CLiPdO5VDcA4XUJWYXnN+EGVDwTgw0AA8JytsAw2yRfzcFnIVw
q5ZuFtlK7AoGOflHNSGd1lC9wfUE2frqYSCjgJIpY6oLMsqQkB1kQZIGr+xT/vgU
XPkAyjh2+3wHeOG7w/7IEvKx4hzw+1BJRCUnMip7gakbkn3eijscm3DmDiUQT8f8
vUaLC3y5jh9DWQDDgL4jVG5eV/WM27Gin63X+jYPCI3ctJS4hrxvNM7opfqwPqit
ibOlp5B5GMhGHOpP5fXsiiiVaRFTjVk/9dW1sQ0tH2tUGUu/4j4=
=ilJF
-----END PGP SIGNATURE-----
--=-=-=--
