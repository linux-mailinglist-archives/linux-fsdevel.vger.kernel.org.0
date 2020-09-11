Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461B62664CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgIKQpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 12:45:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:42089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgIKPIL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599836889;
        bh=G9EeG684OMdUFlLwG1fKDDjwAUDvW1fU+fIQtdRyrqw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FmLtj3P9nVtYk8D8IP76Gmfsm2buRmLyiyQJRp6MZsa3iShB8zigqcBT44hnkwwmI
         5eecR7w0LtVhaWsKRupn9EeksxPPL9VTw28MtVNl8121pp7XS3x+cRXEyTL0CGpuyd
         cGWKI8GJa90QBOf3N1GGz5xXp1s9a9uDFnCWqZjY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDhlf-1kPqko2S7L-00ApMA; Fri, 11
 Sep 2020 16:48:25 +0200
Date:   Fri, 11 Sep 2020 16:48:06 +0200
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     John Wood <john.wood@gmx.com>,
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
Subject: Re: [RESEND][RFC PATCH 0/6] Fork brute force attack mitigation
 (fbfam)
Message-ID: <20200911144806.GA4128@ubuntu>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <202009101656.FB68C6A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009101656.FB68C6A@keescook>
X-Provags-ID: V03:K1:lN2qV3qD2XYCvHt1VuPq2YwfnHEhZEnQJ2uck8HViBxO+Ey5Oty
 ATL+/5H8I/zUYXvMP33JfPDWFPyE23DM1AJqhd6s4wpWmgJrYDZrA175xylTSlrpm8qP0yc
 MSG8/CNOMmjcRYHet6fxq6oZmbbmZ58JhxOdd6qmCTLg2Q6zBO3VPwETDll1RoQlo/eNtDY
 3q5yWEZTjUslSuNBTCm+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zfZog7YqfRo=:zP6dF4Pc4v/zEQ0GrAlY32
 Vj1gyg+5Zzktg+BOyx9VBIKDtXxN6/44JOf5S6QodMzC0O6bZnz56stqlFuHiqRFENmvuTpWs
 jTIro+BUEm7IxLqcLcO+e6JaPVjJqb4yvIOWzyCWZ2CqeZLCiaeYQg60JvfwKGblRBQlM3+5y
 K6aDRFSOB+2iQWd8D8GUh0xXnXGW60BDtdfn7UPLiCbuJsPx45odycKDWexWKFBPevcMTkmAu
 EKwmT3OX8I6/mqz3wZVsImCi9ty5ZNK7sHgh63aOJyZ/sm9T2POA2YYqRMkBDQHHbkRniLE/f
 a9RZBVuO0I1NMh823pz1vDUpUr0ALGilVxPTvpdAi3nvVb2x9zldJuUHKX3dFvnAq4OPlPWd4
 k6NwXXX68I8nPyDQDrcWnm8XtBc6PdgKsjR0Ub9GvfQAXqUCkS/DajD178gxlrQHLtN5PjaAx
 NqVt44EyMA5CP+UKjc+/0igPCELzV4+YvXRDAw4J8NalCapZnCK+bJbnt6RLnagKeQvQJX07n
 TZEDg9wKJMG9iLl5ncSZsftRjNtsT1CpD6BRDXeSFw49oZJkQbZkc9BsBS33qvtWqiKR7i0tu
 cTJziIT8fJj55RVQTCsscqKRnu6vJhkg9Meko3pN1KczigZiUbAPfgMYcQOwMfxct/reeK5Zx
 Erx2mEHwYuym2JEPYL9jn/HavbsIP2LweKcoRcDPBy7VcW2K1hw/MxY7tw9nnpOkUI46FixR5
 Gw+IR+8Of7cge5x4+zId8DOxdGTKps+R8sVC5Xr5p4/2YlpMksyTN35w7nO9uslZjLkGsn0L3
 uETGqa5VEs/VdiXJUt9/lqpaVTnoKcVeSmwov/qjxaRr+P8reu9vIEZnyO5EC+hw0mS5AYrvC
 ZttVKe1SSdmsBaynS9OyLpfkwOi+vV+Tl+XPzISzfU5xlpF3dzZMz+6Rjs6Z2AJtCbFasuKDk
 BfgHosBBg20NjSkI26DtyKjL57QWhQdD2VLTqJUyppaUY9uVHj9nnyf/lf1icm/BX7LD+3P5v
 ZK7I0p6jZCkcQDUPtpEITx71pOnpz4qe8CpmItQqPD1kqdR/cosFJvycw70mkLIVVFVFwpb9p
 zDM5i5gu2NckEjBKXtK33o08FEjtEGCES/vhygf8XzOboN7KopApFhD0heCwLotVp4Q0YIlQ1
 C0hiiA+J6T15UZPuGYByLV5B2mKXEvdqvhLsxk+oNVznW2J4AngtOKse6t7AfF4lqqnZWasMe
 NKXE6fbDSTJk/Uh6URk44hZGrKuzuq7+SsZFdZg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Sep 10, 2020 at 04:58:29PM -0700, Kees Cook wrote:
> On Thu, Sep 10, 2020 at 01:21:01PM -0700, Kees Cook wrote:
> > From: John Wood <john.wood@gmx.com>
> >
> > The goal of this patch serie is to detect and mitigate a fork brute fo=
rce
> > attack.
>
> Thanks for this RFC! I'm excited to get this problem finally handled in
> the kernel. Hopefully the feedback is useful. :)

Kees and Jann,

Thank you very much for your comments and advices. I'm a newbie in the
linux kernel development and this is my first attempt. So, I would prefer
to study all your comments before to reply since a big amount of terms
you expose are unknown to me.

In other words, a late reply to this serie comments is not a lack of
interest. Moreover, I think it would be better that I try to understand an=
d
to implement your ideas before anything else.

My original patch serie is composed of 9 patches, so the 3 lasts are lost.
Kees: Have you removed them for some reason? Can you send them for review?

security/fbfam: Add two new prctls to enable and disable the fbfam feature
https://github.com/johwood/linux/commit/8a36399847213e7eb7b45b853568a53666=
bd0083

Documentation/security: Add documentation for the fbfam feature
https://github.com/johwood/linux/commit/fb46804541f5c0915f3f48acefbe6dc998=
815609

MAINTAINERS: Add a new entry for the fbfam feature
https://github.com/johwood/linux/commit/4303bc8935334136c6ef47b5e50b87cd2c=
472c1f

Is there a problem if I ask for some guidance (replying to this thread)
during the process to do my second patch series?

My goal is to learn as much as possible doing something useful for the
linux kernel.

Thanks a lot,
John Wood

> --
> Kees Cook
