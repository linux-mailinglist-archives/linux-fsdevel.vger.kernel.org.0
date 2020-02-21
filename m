Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A4D1683E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 17:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBUQoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 11:44:44 -0500
Received: from mout.web.de ([212.227.17.12]:40587 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgBUQoo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582303422;
        bh=DrigLGSU+ChrPwJZ0xAMM/fg21zb8HBlkMz62DQ3N8w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qLl9CquUEuagMOdV8hrTcvVyczf/I4hEP7K3zSed3QCbPjS6AVUytmVHOhS8rCrLD
         E7Txu3Dslu0qrEZfFNaFGO0MS0NjkKqTjvzAo0Fv1fHM4/nuRs5/avHFsmZ2ymGjcU
         c2axFXjdZEDfvGWz4yYxsRpyq7q/fU0ZrNZ/H2YU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.97.109]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtWwK-1jWvRy0kTc-010rPX; Fri, 21
 Feb 2020 17:43:42 +0100
Subject: Re: [for-next][12/26] Documentation: bootconfig: Add a doc for
 extended boot config
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Bird <Tim.Bird@sony.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
References: <23e371ca-5df8-3ae3-c685-b01c07b55540@web.de>
 <20200220221340.2b66fd2051a5da74775c474b@kernel.org>
 <5ed96b7b-7485-1ea0-16e2-d39c14ae266d@web.de>
 <20200221191637.e9eed4268ff607a98200628c@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5ade73b0-a3e8-e71a-3685-6485f37ac8b7@web.de>
Date:   Fri, 21 Feb 2020 17:43:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221191637.e9eed4268ff607a98200628c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HaBF0p1Y0Y48qrfqoqWmnTuF4Sl0nwT9DWOsds/JIPH+ixVTRyV
 PqXANwDrmoMXX0/c7fufFyJ0f5TqHRGdumh6bNkzIEkTjTiPbUNxJueh5rSt7Wl/6VkVe9K
 JYVrgpcGO1EPtgreqPjWp0+Tl/QaCqdGNe1TXhTB7CyOwb4mAz8u/ovk7ftIVr64Z7DIGoV
 Z0PtflPXWu30HjYE3UBPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0NgdCAYYZu8=:aa3zSrP1xBMKh+kNR3MWys
 ExrWookpImL9/j67a5rqYXE5V4mvX0TLPf2lzCgS5k58PceGWRCTCsRxG1U//GFJnOkOUKDHP
 h7+Z8wddxL4MxPmr6oEShT2XqzSTK4ebHtVF3qyOmiS7nR1s2GRgss3roRVwLeluKu+0Pm9zS
 YAZohArhE6gzmR93ILiUEGHMExRH+FAYZ95eDgd2QJAhDHYWgCj2q4djGtLI95G2Gh3OswRMD
 IhqORcJUKYiquBHpsoxhS+PpLV6WhU4iWIOblA/Nbw0bAudu7+rFouGsP+1KVndBkVOMMFrya
 ceW21xTNUsDS1M305cOIv77ThEDxUKUC8UQrM8fC25H8gEzaakTdjwCrvFyEH1Ucmv1yiu6qI
 iY0rHPDWkaIxuWzXQimPccLQ+eez+B+jZXANa98VChc0EGx66uvlghHJvmONEBI6xw2Dak8Ao
 xqBV6oCGGFX1fWa5NnrY/eVtS3kLs4cfJh5m0z2pDgiKlCH2pMNBN2OFTOl8WpTtqdZhcZnYB
 PzTzrbNYBMoN4tOFyUb7vH/zMq45xO5hO67TQP5KCnwr9tW7S2W8x4ym7wa9Movx79Ks7JKQZ
 5OunCKyvwHFGY4xquxnJX/txXCN4BF0meFrjkVrRW1SkzYyQvEcYonlY5VVXsN9CENm4QMC44
 DIzpnRhEtMCIIAIuManRw6I/KxAMf/IthQaK8N3jGuzCHFSB85kPd4jQswa4s7gCQQX3PZluM
 3ry1sdc1kUSbeTw/BpVbidSYFcfrladHs1E52lURS7RYUkIjFh2fVorwkcK89bGAWV8yDXTcf
 LCakSr8eEPxz5rmiqRUSRlUTD+yVxfl5I+EFCaG3chtfNrG2xtqYRaXeFvDHrXrCzKiJE837k
 3fl1vVeg0S28YakRStveBGZAN+NI+h8BBcMqZ/2XTRDeVCpzvUu5uGFkdLD8fhFQL5KxkkYhv
 PAEZmRzn/r4603JVh+MOQF46z7CzB4w40tRAL5imX1U/fTVYNLvc+gIu+rLsRHpfsWzKxzVH7
 +soyGMb8cpEhx5a/SqfQR0Ug3QW8/mLPYCqfiuacYu2NPKdilCqH4TEuOBb4Pp9jrPiVdaw/t
 erQYqFGTJrlQVGCOey/Josj8tf+U0DY5WOdJ9aPcdkxVqbGeWaCF3R4cAVmVz/vr1xTzViVHK
 At9GqlfUKwAuH0eHKyYHYXSO1AU2Y/6nFMBfoUMlfP4mSBx+pjDfHWDdqQWOBI5sJ7A/cRjEl
 AKs6JhlEgK5S8TmDd
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Is there a need to separate the number from the following unit?
>
> Sorry, I couldn't understand what you pointed here.

Can the specification =E2=80=9C=E2=80=A6 size is 32 KiB =E2=80=A6=E2=80=9D=
be more appropriate
(besides a small wording adjustment)?


> Like "descriptions of ..." ?

I got another idea also for the provided documentation format.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/D=
ocumentation/admin-guide/bootconfig.rst?id=3Dbee46b309a13ca158c99c325d0408=
fb2f0db207f#n18

* Will a file format description become helpful in the way of
  an extended Backus=E2=80=93Naur form?

* How will data processing evolve around the added structures?

Regards,
Markus
