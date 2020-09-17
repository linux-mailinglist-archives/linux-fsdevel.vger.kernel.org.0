Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4243226E421
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 20:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIQSlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 14:41:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:49501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgIQSld (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600368012;
        bh=BJaSI38+zQjgcLqD+dMdPDjGZYHwT/xid39c3EhZ514=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=e9t1Z/p/aOHSebcLMutxKwgppPMe/c4ATNfVeaagoYuVRoFaa2lcxDVvXkzWR76hB
         YofRiSl0Oz66n/3Ox6RXXKJl0zCEVor4IEaBtxU8K7RZNYnhgrVIaB3LpC3/tCCxMV
         KpFqJTeep7knJ//m+d/o4g/0m+imNEeAr2az4VAk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJmF-1kmnc722Vv-00nPxK; Thu, 17
 Sep 2020 20:40:12 +0200
Date:   Thu, 17 Sep 2020 20:40:06 +0200
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>, kernel-hardening@lists.openwall.com,
        John Wood <john.wood@gmx.com>,
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
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] security/fbfam: Add a Kconfig to enable the
 fbfam feature
Message-ID: <20200917175146.GB3637@ubuntu>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-2-keescook@chromium.org>
 <202009101615.8566BA3967@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009101615.8566BA3967@keescook>
X-Provags-ID: V03:K1:hfSrV/JuouzV96KqzDpTM0p1F5fgksRQkQ6glwDqKnplLy7aA51
 LEXmlmjhZhsKwcw5j0kbmt75CSucf6iASudyPU5ybTSp6TwgdsHyhmEvzYWejOaYtXBaxA/
 PnRKC9PzHtt0+UFq1WxYfr9s9ZeCojzAxzMMqSLlO3HjvJvoExAeNrCrqI6qFldyYkuwPt5
 pa5DJIH2/13k0Vpfy5WPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F+CYmWgFS1M=:BsRffWDkQBmHd+tKnquYN/
 8GM8gVMJzJUHm1wLN6sXJNkaM1TtRt/1V5S2aDYLosqzA7/u+EEtothfBo8QFKI9FsOFNyOFy
 H4gOTJ0PF86fTmrXj6o7Tz1Z6U8o7uI4HIj5/mIYwLFl/TTv52z/+P6riiqXobBwn6C+80my/
 gFNP+8JTHOp6yYAVBo+A8OSWoCQ5MagOVy0OoyK9mTw/3jXZItatZ2UsEYTSyPeb9+sQXm2tH
 LLvGlF9TZ83maf5WrMyEJMqXha5sf7FjN4voWB3UEc8J4dWImKh15qpA/hr2sicARZPIKPe6F
 K6QNgXaMIap5HLkHsnQETPu+cPdKK61VbmNLxFBwlfNcvFNu4y05X0UuH7IrTqMxlfV4MSus1
 mkxSH4DErxV9mJfPRiannVBfsktkpXJAC8eczFtHls1VXsqZ+UTYg6BRGmdK4MGtH1ReFH9ZA
 ywFRgt+be+8LcK4jyQAFgZQpRqrGJRqYUGTdFbGZ/tEdNcBc/q8s9ygAr7KMCKBmITyFkDRYN
 E2K4u3EPUFOIaJqgd7EZ84wtGR39Sqniot95q5qpQEC8HNFBJ6yGzLnHy311i48kU+X2Z2yjp
 kfxfaNP66eE/U59rDWestmaYslNyqva/9g2civeO4EtLuH3mpUwArmBzb0/qlIit5/fVwI/Cf
 RN1Ur93LTn76zDgltjycZ8ALztU4UiZeDL5ChGXw3vK1pDz8pndc4M+kTZMdxWLAjKfqQURqJ
 PKMjOcNHsujSTb9s3fJVMCIuM1ndW0RPV89rtBn38eMK77nv3r4yrzQpZdykSZQmvi2wgvWiK
 HUz6U8VlqmJVX0IcIupeW1EWfrtdYb9JcWvMnhX8yfjg7N0/4Ijrly8zmsppeNTu3kZrMdLj1
 VO7J368MKPC0a5VAZ510UDgycg7VfOfLijEnyU5EmK6FwTQJ3AodhBVWJJt/b4CUCs1gdsrIC
 dXLbIuM177k0+HIj51B+7ikdPWBivlOy8obh0XKgsNk5GliXVn6jCrxTUtT+C1WvaxSYOlUxm
 8ZSYhm/OSApgQDJD2mvOL9huMsK/GHuEMP5N2x78Ewd6j8QsvmGBY3daU7p5WFAac5BELEUmp
 IOhwYHNGrrQI/FUuAy1z5G/w46UgEIYf4p5lOTNp+lmjx9tHvtb0EoAdpU/1t1rzPsPSwXc5d
 jQWlqvI38Yv94/imXFKlXrwpMtvjpHh39fqQxvy1z7m85HSQrL5DuN01Fp0JhxQtXd/s24Dsq
 V81jzjHU6ZR+y6kUDixI7ItGZU/kNMJFd4Eerpw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Sep 10, 2020 at 04:18:08PM -0700, Kees Cook wrote:
> On Thu, Sep 10, 2020 at 01:21:02PM -0700, Kees Cook wrote:
> > From: John Wood <john.wood@gmx.com>
> >
> > Add a menu entry under "Security options" to enable the "Fork brute
> > force attack mitigation" feature.
> >
> > Signed-off-by: John Wood <john.wood@gmx.com>
> > ---
> >  security/Kconfig       |  1 +
> >  security/fbfam/Kconfig | 10 ++++++++++
> >  2 files changed, 11 insertions(+)
> >  create mode 100644 security/fbfam/Kconfig
> >
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 7561f6f99f1d..00a90e25b8d5 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -290,6 +290,7 @@ config LSM
> >  	  If unsure, leave this as the default.
> >
> >  source "security/Kconfig.hardening"
> > +source "security/fbfam/Kconfig"
>
> Given the layout you've chosen and the interface you've got, I think
> this should just be treated like a regular LSM.

Yes, throughout the review it seems the most appropiate is treat
this feature as a regular LSM. Thanks.

> >
> >  endmenu
> >
> > diff --git a/security/fbfam/Kconfig b/security/fbfam/Kconfig
> > new file mode 100644
> > index 000000000000..bbe7f6aad369
> > --- /dev/null
> > +++ b/security/fbfam/Kconfig
> > @@ -0,0 +1,10 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +config FBFAM
>
> To jump on the bikeshed: how about just calling this
> FORK_BRUTE_FORCE_DETECTION or FORK_BRUTE, and the directory could be
> "brute", etc. "fbfam" doesn't tell anyone anything.

Understood. But how about use the fbfam abbreviation in the code? Like as
function name prefix, struct name prefix, ... It would be better to use a
more descriptive name in this scenario? It is not clear to me.

> --
> Kees Cook

Thanks,
John Wood

