Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E607AADD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjIVJ1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 05:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjIVJ1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:27:30 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4DA199
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 02:27:23 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d8164e661abso2263715276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695374842; x=1695979642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUsw/sfVCl6MTODztp5pfdtfeJTvlbxrkbvvWFQDC0g=;
        b=WnSaDB/mkLML8d+v+QLa9MoiH11sNAMFhzul6W2W+ETwqSH2/W0cd58pmNmVnkfPVl
         3+ejqRecJLKEhi2BmLpgzuXAqZXgRB3Dr+BFDtX6FIet4O4NLHwSZCPPp1DoQqvT3oLF
         ZpPbDEb6UhlTkLg70huj6cefDtwstrwpHsH6Do0J5y1iz/khxH0czoF/sOlVZodmqjM6
         d3EtfkQKEwNy6ICSRL0OJM1bbcWI6y5tWnNG0HHGdB7uCa5qaagVHy5LFVUT4kDQ2uJ6
         K/Fg18ZQn0iYaVeyCottpKKFnI5GbUxjrTrdiSv8Tp343ZTbrnxBmpTvtlgAz8NxP0AJ
         Z7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695374842; x=1695979642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUsw/sfVCl6MTODztp5pfdtfeJTvlbxrkbvvWFQDC0g=;
        b=m3g+biu6oNCLeI1BwjKigwNtA051jyuDyiMt+LzvczLMhOueyDOMwZiUklAzW+GpT1
         qS5plxSC+aq/i9X9mbDJekmFbPThdpsxGdU44+8swcZSDuNkwHhC7tkL4QUUBTJmoxHT
         Wq9NiX1PnuegQRLtfuCucuHTWAWkfv3P9Yq7xwx9T0KVMn4POiviIk8qIHdR5seOiz/0
         140fWEiWhu9CiqO0LpnbggwXRNHiUFYrMzg5BFp88GoBGqbXIUkQYa4PsqhoH50S9fw7
         VaY99rAUXbldLO9gpNVqiJ5WLBUuey0S2f7okFaHcPTU0WfnGHM7vmUVZl20PfNS1Kke
         /2Bw==
X-Gm-Message-State: AOJu0YymD6tILXWqNIOwdIk4Iz5XkQeFxkwpmSMTykt5lE0J4zAFp26x
        KuBoyjaqgDqRe1OhqMT+EkVMQPcpv/3s65g5Y+sl
X-Google-Smtp-Source: AGHT+IHWcifQ3cnzHufT41+GtP5iVL/vJLwKoXU7wdpw+prh7kdb7xnGr3HnQxfK8sANXszV/K7RCeUQf85zVL0jqKk=
X-Received: by 2002:a25:ad50:0:b0:d11:45d3:b25d with SMTP id
 l16-20020a25ad50000000b00d1145d3b25dmr7910229ybe.46.1695374842573; Fri, 22
 Sep 2023 02:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230912212906.3975866-3-andrii@kernel.org> <3808036a0b32a17a7fd9e7d671b5458d.paul@paul-moore.com>
 <CAEf4BzYiKhG3ZL-GGQ4fHzSu6RKx2fh2JHwcL9_XKzQBvx3Bjg@mail.gmail.com>
 <CAHC9VhSOCAb6JQJn96xgwNNMGM0mKXf64ygkj4=Yv0FA8AYR=Q@mail.gmail.com>
 <CAEf4BzZC+9GbCsG56B2Q=woq+RHQS8oMTGJSNiMFKZpOKHhKpg@mail.gmail.com> <CAHC9VhTiqhQcfDr-7mThY1kH-Fwa7NUUU8ZWZvLFVudgtO8RAA@mail.gmail.com>
In-Reply-To: <CAHC9VhTiqhQcfDr-7mThY1kH-Fwa7NUUU8ZWZvLFVudgtO8RAA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Sep 2023 05:27:11 -0400
Message-ID: <CAHC9VhSLtPYBVSeQGYNJ7Kqq7_M4Cgpqn1LXFiEUCx6G2YMRrg@mail.gmail.com>
Subject: Re: [PATCH v4 2/12] bpf: introduce BPF token object
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 6:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>

...

> Typically the LSM hook call sites end up being in the same general
> area as the capability checks, usually just after (we want the normal
> Linux discretionary access controls to always come first for the sake
> of consistency).  Sticking with that approach it looks like we would
> end up with a LSM call in bpf_prog_load() right after bpf_capable()
> call, the only gotcha with that is the bpf_prog struct isn't populated
> yet, but how important is that when we have the bpf_attr info (honest
> question, I don't know the answer to this)?
>
> Ignoring the bpf_prog struct, do you think something like this would
> work for a hook call site (please forgive the pseudo code)?
>
>   int bpf_prog_load(...)
>   {
>          ...
>      bpf_cap =3D bpf_token_capable(token, CAP_BPF);
>      err =3D security_bpf_token(BPF_PROG_LOAD, attr, uattr_size, token);
>      if (err)
>        return err;
>     ...
>   }
>
> Assuming this type of hook configuration, and an empty/passthrough
> security_bpf() hook, a LSM would first see the various
> capable()/ns_capable() checks present in bpf_token_capable() followed
> by a BPF op check, complete with token, in the security_bpf_token()
> hook.  Further assuming that we convert the bpf_token_new_fd() to use
> anon_inode_getfd_secure() instead of anon_inode_getfd() and the
> security_bpf_token() could still access the token fd via the bpf_attr
> struct I think we could do something like this for the SELinux case
> (more rough pseudo code):
>
>   int selinux_bpf_token(...)
>   {
>     ssid =3D current_sid();
>     if (token) {
>       /* this could be simplified with better integration
>        * in bpf_token_get_from_fd() */
>       fd =3D fdget(attr->prog_token_fd);
>       inode =3D file_inode(fd.file);
>       isec =3D selinux_inode(inode);
>       tsid =3D isec->sid;
>       fdput(fd);
>     } else
>       tsid =3D ssid;
>     switch(cmd) {
>     ...
>     case BPF_PROG_LOAD:
>       rc =3D avc_has_perm(ssid, tsid, SECCLAS_BPF, BPF__PROG_LOAD);
>       break;
>     default:
>       rc =3D 0;
>     }
>     return rc;
>   }
>
> This would preserve the current behaviour when a token was not present:
>
>  allow @current @current : bpf { prog_load }
>
> ... but this would change to the following if a token was present:
>
>  allow @current @DELEGATED_ANON_INODE : bpf { prog_load }
>
> That seems reasonable to me, but I've CC'd the SELinux list on this so
> others can sanity check the above :)

I thought it might be helpful to add a bit more background on my
thinking for the SELinux folks, especially since the object label used
in the example above is a bit unusual.  As a reminder, the object
label in the delegated case is not the current domain as it is now for
standard BPF program loads, it is the label of the BPF delegation
token (anonymous inode) that is created by the process/orchestrator
that manages the namespace and explicitly enabled the BPF privilege
delegation.  The BPF token can be labeled using the existing anonymous
inode transition rules.

First off I decided to reuse the existing permission so as not to
break current policies.  We can always separate the PROG_LOAD
permission into a standard and delegated permission if desired, but I
believe we would need to gate that with a policy capability and
preserve some form of access control for the legacy PROG_LOAD-only
case.

Preserving the PROG_LOAD permission does present a challenge with
respect to differentiating the delegated program load from a normal
program load while ensuring that existing policies continue to work
and delegated operations require explicit policy adjustments.
Changing the object label in the delegated case was the only approach
I could think of that would satisfy all of these constraints, but I'm
open to other ideas, tweaks, etc. and I would love to get some other
opinions on this.

Thoughts?

--=20
paul-moore.com
