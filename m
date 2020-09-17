Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889D726E2B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgIQRmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:42:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:34289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgIQRlF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:41:05 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 13:40:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600364424;
        bh=AtpaLz5T0doiwW45rKTXhN9OPitxExJgCcjhtNz0x98=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=AZ54eguBjBVpgfrIyJQ0SsL2DbHWtMwIHELHexCYssWjgRYBO475Odahy/r27XRnm
         Ko3nlAolpxQqLoaPfZuDLPzAu76osTD6vmmgZAWj8rrYTPHYfElYy3nzEOB3yom1u1
         pU/Ymjp7/OXsClocPacrbIv2nF3gNU9P0nV5ZqbI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOA3F-1k7jNd13M1-00OYlk; Thu, 17
 Sep 2020 19:32:28 +0200
Date:   Thu, 17 Sep 2020 19:32:09 +0200
From:   John Wood <john.wood@gmx.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, John Wood <john.wood@gmx.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] security/fbfam: Add a Kconfig to enable the
 fbfam feature
Message-ID: <20200917173209.GA3637@ubuntu>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-2-keescook@chromium.org>
 <CAG48ez1V=oVczCCSuRaWX=bbN2cOi0Y9q48=e-Fuhg7mwMOi0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1V=oVczCCSuRaWX=bbN2cOi0Y9q48=e-Fuhg7mwMOi0A@mail.gmail.com>
X-Provags-ID: V03:K1:R5ZkovHXd6oUrfcKmVNF76tjDIn4TAPnGKJDjlfIyNZe9chhDUt
 Esh/G27SFDsxpGe3eTJoHTkEtlKWjMzGSWaf4NY77J0KknyMS4Kn3FifB6lpQ9wSsgJm6aR
 GWM1FOcKZJ7nuqitu7T9wYT0c/x3o41HPECfOOo6S21tnSwhYbEzXGPZ8NK/o/DFW7XB3Cr
 jdRHD05vg7a/XdyN7NGVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/6CMB5QJPcI=:X8wmKlFpZ253znFDwPLRvb
 YlZ/RdCI9xCVOBo9khl6lMLnAtBDlf5hMUNoOiyWZOv1J4QhAiinM2EoW6kY+qc8hjBJl2874
 9bMUGQjsWdx4JH9U5brc4MuC19cin2DtZ29eZvfSI96b/elLNnR9aTov1mQB/C5Eimqy4fn+3
 9Nf5mi/WXSFRHDUYdkLT8IszB7q6thtLFe2tvdQdPiPTRvVggd2/V0NX3n/t8N7/R+eCLy7lo
 68v/prC3P0LDKQ+MsH3wLOPe1kT9PYMxyCYZsb5EN5iD67JB+g8PBu+1B0UA4Z048/10ti3SE
 WBTOV59GkNvF1RMmhH7mB7wW8J3GsMXdEfsTvEl98flGZc8dVunjEYCs8SNhdYTyUtklweh1b
 tSLoGPdXya8K0TH79aqwk++pYYNHLo9XWonep/6IkJBZCb32iDfJvruIeklbxHTtLgwJzuPpG
 86NTtzC11WP5tG+UpwhgE1A6XzX0ItSGweTHyBkR20t1yP05fmU48TuhjvwJDnZzLxx+W9CKg
 0ZmvuiW7I6Jrx5Vu26y4FLlWxROQn+C96iSZDx9M9G/hYncOeeY13LyUbh5wAVg1cblVy4QLD
 iQzVNhCq0J/ncRiijX1j7rDxLIFiwFZ5SI36ewts0CarJmfwiFE7lzIi+Xwg/+PeLHK8nnNLu
 DkN1N0tORU5izm1eHOOKBV208HzG4zOw/uTKyxEcsncBin1AKCVMaBFTJjV5WEKxvNjxU97mi
 zkLokRyZdGski1EAt1kPj3oG3AM2QZ7YRa6PeSsWKIPFqL4YeHgAxowfhHzQfNAAYTRFz6geZ
 Bn/7XX6nPF7sxU3E5mzUu643lR3FWnXR4STPrrP/P25HBZ6IYiQjGUzd11xrNx78P7H0yPm9S
 x9ii8+mMdTo+hTZ8ThfI2h5HyP40BIL2lFq5V7wafb8nRnoiq2Sdu3EvAhe8PRiReC8A8T7ci
 wSQf+RvoGk8M9D8n1TF4g5icDvjJsssP8O5usLHZAIIfum5N/qwYm0dRHsaGDwcEnS7lr2CY9
 BUJxYj5K3maLD/TaiF4AOmUIqZ+8pL7UAzpKTFkXA+JqapWjrdFAlftP2UPCet8sAsd4M6WSX
 qS7gKahFwtQGMhnhzlsB2FF+5OciezSR/rQWZE6EoMRN6hqTok023YEUIjq28NmnUzBCwhjcy
 LEuRV4FCDPe0Y7DnC/SknZzc5eO758PryvZxDUo87FL3KE6/El5axTRhxOkyWI2+ou/MBoEqs
 DhSvYP2Mo0rcNzsdPPid0MuNieSbeSjCHLNBOaQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 11:21:58PM +0200, Jann Horn wrote:
> On Thu, Sep 10, 2020 at 10:21 PM Kees Cook <keescook@chromium.org> wrote=
:
> > From: John Wood <john.wood@gmx.com>
> >
> > Add a menu entry under "Security options" to enable the "Fork brute
> > force attack mitigation" feature.
> [...]
> > +config FBFAM
>
> Please give this a more descriptive name than FBFAM. Some name where,
> if a random kernel developer sees an "#ifdef" with that name in some
> random piece of kernel code, they immediately have a rough idea for
> what kind of feature this is.
>
> Perhaps something like THROTTLE_FORK_CRASHES. Or something else that
> is equally descriptive.

Ok, understood. This will be fixed for the next version. Thanks.

> > +       bool "Fork brute force attack mitigation"
> > +       default n
>
> "default n" is superfluous and should AFAIK be omitted.

Ok. I will remove it. Thanks.

> > +       help
> > +         This is a user defense that detects any fork brute force att=
ack
> > +         based on the application's crashing rate. When this measure =
is
> > +         triggered the fork system call is blocked.
>
> This help text claims that the mitigation will block fork(), but patch
> 6/6 actually kills the process hierarchy.

Sorry, it's a mistake. It was the first idea but finally the implementatio=
n
changed and this description not was modified. Apologies. It will be fixed
for the next version.

Thanks,
John Wood
