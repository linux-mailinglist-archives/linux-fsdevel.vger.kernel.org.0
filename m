Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E144267936
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgILJib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 05:38:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:59077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgILJi1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 05:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599903434;
        bh=skrUagSvgqgEZzCi9PdeBBeP4Cqi1Erda0k0fJgiIB8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FftAd7pnCH3fzdB/mQwK5o3526+5rvmiQVz+tQTbnxcymkk3GlkdpnrB1m2vpsdbp
         bVEFr4c00PT2nMP+9JAormOkurommMEJuzzsM4/u0ca4qnWDib1RRNZL4PXOSjCKAh
         fDfSSux5fckZULv312TbZpx8w+A0tRK5qrIOmacA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N49hB-1khfbc3Ii9-0105Mu; Sat, 12
 Sep 2020 11:37:14 +0200
Date:   Sat, 12 Sep 2020 11:36:52 +0200
From:   John Wood <john.wood@gmx.com>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com, John Wood <john.wood@gmx.com>,
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
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RESEND][RFC PATCH 0/6] Fork brute force attack mitigation
 (fbfam)
Message-ID: <20200912093652.GA3041@ubuntu>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <alpine.LRH.2.21.2009121002100.17638@namei.org>
 <202009120055.F6BF704620@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009120055.F6BF704620@keescook>
X-Provags-ID: V03:K1:82dXCEl3cI4cxk3DUO6WIKkws0kGiKuodYSB2Poy3pHIMexgZ3i
 ocFk/YHAJ3DjbN6PRnUmpAr0uwh00WrBXziJGf+yniVRw7LGtyUeiPQxsr9LYsq68ZOZ/WG
 OENMjSgGJ5obexYYwh4gx7hG4Wndyaod5tu/wNF+B9F43ME0vKJv7InV5yifThD30BcMIi2
 Q7LJJJvz5chA4C5qqIZxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B2c/eYE3vYI=:Zbn3OSff8V0GZehoI25jPB
 XIfX7t9qpGtZR8iToZ2IiS6lBYW3veovlwaqN8mf32YrZRUISKTblWhYZOBmzwc6y1t6GWQFg
 NdXxqlWHuT/7m6k6X/TrkwVRrGN25qz+McCYG8lPBpTCw7ivlZfj9Z735ZZ5uyw755BwbxKH2
 Mcahz9+L5cwafaC6wE+M3yFzSdDdqgOjLEneU3IiQe9CTo6o2/XnE+5on3hC6R5N5Y/2wDA1d
 e4Nnj6ywD8yk/2CJj10pGq6SUZacy1ZB7XDohXjC0rYrS6WCSuKTw9DBk+yy15YbsEvPdlA2N
 U61QJgWqOuK7zU9LSzpDbGlzdDkM29EjmqSg8P2SlrTrkBRGhfgRapA8x8jtt2G4JUr6RTnPT
 U8pEJsZM7xoOvN8OzB0KEELqXvLCwnGb26LA9reUNMcWkpu1B5cNO0ZtKB/pSiuWGE7RTChJb
 l5S+YoiivwbgZwCkA9KRrYfEE27VDdXvdizZqQesZOP1P5mOqbwqDei1qY2Sv0yXC1qPnTOkz
 2p0M3jHGbC2w8rgDcdZXLGPjbtoT7xTwD3cEBxAcclCYf0WWOTq/olDnkhk/m/uZvK2dVhHlS
 WjQwncs9EkPlHrctJvP2Oe2OS9q8wHNtJBIDdeppW9IJm8Qii6I31cidHaVDNjYX1mBhCFkLN
 jiScnSXnSMd1b/7nVji25Xc3vuYViuTid6XK9zHV7YyP+iL2R5BpKiRTdMtgSv5CHC/pBSzko
 JDSvogEy9A5MmMidBC+cOz55JnA3hHDDfs/7A1NmktypKRT11aVSggosuWvmDBjMJJdOWEl7H
 uMFJ54BGGSRmkHruKcQQJ725axPIs21Kt6iBcda6GFvnWDVGBa20iL4mT0yqMunGI5UabkMaT
 fZbWHEO+dHExVkhgVhOK5FbTAYXqmf+xh1GQWmR7t5wfL9Ca5InGyqkBXRyorIMZJTVAR2/PU
 +0HSLXm/WAi1uBa5W3DiiKIqzLwGM/N26IefxV4lU4Llo9ttwCaSbT53Z6Sgn2C23GZja/Rnb
 pw05y6c0WGrchZCat0neiVuDUAaVQJg1Qp/LUGvu6/DholigBT2VFgsI+Rs7fRD4x9Vw4YQC7
 mMkA9u/JNdyN2AIqH8u52XMNg7egvycBRjfeMC/whjW1damf6Wjredeau9o/d5+3ZJF1XpIiH
 /lOMjNgOO53bzcOPNaS3HB3MpkPxpyK+D3BtdQwAK9AxA7TtZvKdMNdfvTKHQTXVpfh9ez+8i
 u+gvCQ8PYYgQYTpOab3Yestd59t2YICSNXMfnpA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 12:56:18AM -0700, Kees Cook wrote:
> On Sat, Sep 12, 2020 at 10:03:23AM +1000, James Morris wrote:
> > On Thu, 10 Sep 2020, Kees Cook wrote:
> >
> > > [kees: re-sending this series on behalf of John Wood <john.wood@gmx.=
com>
> > >  also visible at https://github.com/johwood/linux fbfam]
> > >
> > > From: John Wood <john.wood@gmx.com>
> >
> > Why are you resending this? The author of the code needs to be able to
> > send and receive emails directly as part of development and maintenanc=
e.

I tried to send the full patch serie by myself but my email got blocked. A=
fter
get support from my email provider it told to me that my account is young,
and due to its spam policie I am not allow, for now, to send a big amount
of mails in a short period. They also informed me that soon I will be able
to send more mails. The quantity increase with the age of the account.

I hope that for the next version all works as expected.
Apologies.

> I wanted to flush it from my "review" TODO list, mainly.

Thanks Kees for the re-send and review.

> --
> Kees Cook

Regards,
John Wood
