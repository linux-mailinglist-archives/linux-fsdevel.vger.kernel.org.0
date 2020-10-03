Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553C928235C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 11:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgJCJxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 05:53:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:55189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgJCJxo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 05:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601718746;
        bh=+J10i8bNFrOqOG+3GURM3R/KC2tKxHk7bbB91+yozrE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YgyxAo9ipXCQEdwyhONQS+h1PTqn+hieEUf2kcfmMKmC2iYTGHN7xL2TmTFzp0TtB
         mf5ffJupFNvyQJoKYlHbI2fMpjGIMKdHsig7UZZDDhhNc/MOlDRh66QmtxQASKpHsh
         uBc2ARI0Bt9UPKGOIeW6rbl2UzdAcJDvpo0/4NVg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSKyI-1jw0SA1wlc-00Sft4; Sat, 03
 Oct 2020 11:52:26 +0200
Date:   Sat, 3 Oct 2020 11:52:12 +0200
From:   John Wood <john.wood@gmx.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] security/fbfam: Use the api to manage statistics
Message-ID: <20201003095212.GA2911@ubuntu>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-4-keescook@chromium.org>
 <202009101625.0E3B6242@keescook>
 <20200929194712.541c860c@oasis.local.home>
 <20200929194924.31640617@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929194924.31640617@oasis.local.home>
X-Provags-ID: V03:K1:ggAP+Xm36kOZKXGb8H7ns8txs5t75Yr2LN5k1wKKGh7OrSyP4rv
 hABdr9ji9QjJMvdKJxa0Bo3pYk88oKRhyy8fuCUgx+hQKixmUvHbc1MDhKrV5cNsE+bxTP2
 Dk9PDaf2LUhtvdfHI+c0tcesCUkPkqHAYbnqWHE26/KCx1PlkWnubZnT6EbHkaMsMgXGyuU
 xlSBDE65qQDt9mTbJg9QA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3i4hMYig/Sg=:QgDlo3Fo4OAuy7Zosj84zw
 ldZ6Q2QLZiTRCIufr3bSmOYnjwZ1lFU18uEMJkn+4Fr8NbsA9s42eEVDlMksDspaRsYMexdGO
 45XVRt/IoXnOVWdrg2jyNDsQsFsDT+3H1Ktx5oT8R9JIL9uxREu+JqSjEwscQEoNmE+2FDWK9
 w3ENzD6ACmNPB7bStYhkzZXhtS3OlXIMeRHFBKaPl4LjgliDTwfcZ42K2KSfJaV2ut3iyunwk
 OvrkZsHIHx2N+CC45RRk+zAse5/4ZmTd2llFRdGacvZyVD5G5Amt5tmbhEK8Io7fSkxqtQMTb
 yDTVfCdXw9Ou2YjoTZGdc29O3NWP9ksSQr2s0Jm4KF+PSAIFY0MVvQ3tkz9QEGZeCTNiJl24t
 AYWmCP8MFQunYK+/7KQUkV4syjZfKQsOGhWoBeGCogNxTVGAl7eau5NWc506r8MwznKGP0E7X
 5H/soS8iQ9tGJsbrQW2bi4Cr9aI+n9aKj8QSpG9Gyg+tJSh7pnxX7nDG0r5KOYZIavMNAoJTm
 7O1XtZagVphvyo8BF5X4B0nqUuRwvWiHSa0j31be255+FxswtdXj4AGteOxTeHdryUNcC2N4c
 IXfBlvZOOtceo/mv8+KomewuYW8ZJyA2FiOXYI98B17Ox7ywOnqeJ33erC301YOEqIhKqpSUB
 +SnDwitQk+63gfTYzwTfBb6WyjfY0SG+ko9aDzqPTtrRgQU9k9GDC50hN0+lTY6UcxuKz2GWx
 3rsTrH4I5k+HD4pxZRyybfx9ezKoAeC+CW17blJUyroVYsqcc7BoaOllFwrrHUqHL8MY4U8Wn
 gaaOtEm4hIEfgxa4uztTg0NUDg7O7ioBZqC/x+IvNEswdLiS1uYlqTYNUvFhyO49Is7036EVX
 LiR8BLxqRq3Q+T9OXQQzLOe1RMa2iZjvWxCHq0e9nKAq/mZxo+ZeNv24yNDjQ4pafCASpkTl5
 70/RcD2tUgsEg2XVTTpfBuOCUXF3pJr8FyW26PMeJ87GMMR/QCJWUzw4O7E/hT95AP5/rpNIL
 VaoQENCp6HmFy1Y4ufI99vRrKQHUYIhaGbVh8XMbtSsb9LUS0MtfJUWhVAO0d1T9xywLoHp/e
 ZgQE09w+RUrtSAEjD6tj+aj/MuFI7e4IMmAqlimOSAnwzxIyC44HiVHojeYn6G4FKtK74g6sC
 NtpHowXAs6E12LUUobi0vXwNrCdz1IgyUGcpsfaU6OcKS4f50Pb61rPs/b3S5+WDqCnUgcMhI
 US28q0ydgG9GDKNrO6/GL+5MNwwcCb3XfMxjC9g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steven,

On Tue, Sep 29, 2020 at 07:49:24PM -0400, Steven Rostedt wrote:
> On Tue, 29 Sep 2020 19:47:12 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Thu, 10 Sep 2020 16:33:38 -0700
> > Kees Cook <keescook@chromium.org> wrote:
> >
> > > > @@ -1940,6 +1941,7 @@ static int bprm_execve(struct linux_binprm *=
bprm,
> > > >  	task_numa_free(current, false);
> > > >  	if (displaced)
> > > >  		put_files_struct(displaced);
> > > > +	fbfam_execve();
> > >
> > > As mentioned in the other emails, I think this could trivially be
> > > converted into an LSM: all the hooks are available AFAICT. If you on=
ly
> > > want to introspect execve _happening_, you can use bprm_creds_for_ex=
ec
> > > which is called a few lines above. Otherwise, my prior suggestion ("=
the
> > > exec has happened" hook via brpm_cred_committing, etc).
> >
> > And if its information only, you could just register a callback to the
> > trace_sched_process_exec() tracepoint and do whatever you want then.
> >
> > The tracepoints are available for anyone to attach to. Not just tracin=
g.
> >
> And there's also trace_sched_process_fork() and
> trace_sched_process_exit().

Since this feature requires a pointer to the statistical data in the
task_struct structure, and the LSM allows this using the security blobs,
I think that the best for now is convert all the code to an LSM. Anyway,
thanks for the suggestion.

> -- Steve

Thanks,
John Wood

