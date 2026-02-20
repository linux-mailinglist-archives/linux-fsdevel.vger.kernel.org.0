Return-Path: <linux-fsdevel+bounces-77809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPu6ABmemGmWKAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:47:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 758CA169D40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC4A1301D969
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C17344DA0;
	Fri, 20 Feb 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UErns9a2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A876260565
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609617; cv=pass; b=RrZ8v2xap+ThEKJXFpM8rRLACsQbWGWz+NdJq17Duk8jM5jHa+XtIyIn1KFbmFwe2r014rfSfmIvMxzaZTLIXePPpQGf2UNuuwugnqKivEgv8IIG0XrQhVBTNWeQUlNAxfH3e1VJCiRxZKFU1iqbgrOSHvTzHmZRM0WL53Cwlbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609617; c=relaxed/simple;
	bh=L4LUtbq/AYJ1ibIci7EI6CXd6uhMJdMr550QxtjyFO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUR2UMqy5xTSgK0cuLIgQyxzwWJHUznA8DfiG8G3RpbAItdEBan6/sIA4RyWeoCmvitm+iGbq9sCHfAOQxSJqVJ0jefAA5PFaE6JB48G5gbaumbARVQurkFnWxwICxk3Z8cjvvSymblexy8gnwskiWadOB7OyM4Bps+QyrIhnpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UErns9a2; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806b0963a9so1535e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 09:46:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771609614; cv=none;
        d=google.com; s=arc-20240605;
        b=Qjiavj/HSBCU8HfvDyN9tGSdeUQGaQM3/sZfSfB4ahssFdnmiaW3XFWdb4Hzb+iY/9
         O3kQAiYc5WqW0X3Ne4K/r+3Wb/28U/Bnfji7MGyFHVtSa5e1qsoWdJRpLZS4kZo/hLse
         sIMvV/eQ34LfB/nPGL5UG4m6X4L7L6Ailf/ffPGCYwoQgsTFf2tyVXBM+ZE9sCyLsQlU
         19eiWGpJU21AXgLeB+aZ064jraMNDDNgBH4BeMP/olU6rmp0Y1IDvn2zjsuxy69bDfag
         Y3a7V3FhSOJAt+t0bEc2fyua4Idnbas7dFfi8l4l3gMzs0ugfRFpgJvyVduNuVfWrHiU
         Ykjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TtrPaYzDg2FZ0DurUoi+gNF5T1+mzkiQf2zCfT8eyAI=;
        fh=qF6NP95iUScK/PK2VVRslKA2ecl44n4tWs7wwFkD70I=;
        b=DY1oSPmR9Rx1FdqV3PcIUs6IAAkmBrFZw0oRt27kp0/g5xRvNXl91bfEyfEYajcpgP
         ur6XveNro5RGHA00SnTWH/y2psCTgoqoZ/hnHUcX2XYSzijO/VfTvnp2CdsKYg8gW1Kv
         L5zVQqgBudFu2wsp9vgsWYhucfaI8ilt/Cl/3kszBRnsjzMMxwQVqfN/kH7n9w9yWwUX
         IT+RqGNa7rJf5gw8B2+O4y9GneTsfTqJktA49lUEoSqZiqlmtHQd0wslG8nu/BxQA+08
         5p7kH7RhwlckU5Zci58riaC+d1InPHfm+AVzhIo7W7BA61535yYw8XiuQnqTdWyVfQhI
         X9Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771609614; x=1772214414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtrPaYzDg2FZ0DurUoi+gNF5T1+mzkiQf2zCfT8eyAI=;
        b=UErns9a2UGB3xcL2aFLGvcHe1hlRA35qOtTeH6UbuQQGshI4tTFmf9o43Ye8fLQQpA
         Qqsxcg5codC0LRPBqhLOb9cjg+yUV1HL4b7MSJNYu1U6X6ajiyxcH2H+HVsSBe2dDfDd
         idZjlryRA8Qv6V7THMiCvDnzAJH9iJPQFI7wKmPAcoG+r2J59s/lCb7LT95zFnF4g0Ya
         irJGnYmCuPcyS1IH3tAa3wKG3HKNYT2WKWXAnLZIhlTYYE/KxEM+/OXuxBBrXpRBzhi8
         ieOJIb37UHXE9vrwU58Fqjtkj3fQiFEqh+NsAYOaIVAd6brC/aEkxa1TvbgOmi4iUPTA
         xBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609614; x=1772214414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TtrPaYzDg2FZ0DurUoi+gNF5T1+mzkiQf2zCfT8eyAI=;
        b=LI5tiknLHAqGlHeizxCCvmSicfHXEcmvJQavLh4p6Vk13kcBQoiCmXSvbqmQKgX0ic
         vRjIEAi4/Uw5j/bRyHelYkZ+Atqv2GmWT8OU/S9wQIU/7c+ukCUbxsaCQrP1diEncDsB
         H8vZNjwGTR6pnLna8i+M80z7R+mYl2rblA7XUNvdQqVPdTVbvdgVAkGCSH0HfNYryc6O
         4Wgj0mECkEsDFXZ3PldMLCEz/S98yrRFapWX8TqNRpczLK7/fb90Iuo5wBh9Q+jRf4xL
         U6Q7GMFflarxJfk/4EqF+WsN/dclM7pqtNNt2AtuZxj2dfTMD6O5fmfyYXnE5eoDBH6o
         srMw==
X-Forwarded-Encrypted: i=1; AJvYcCUeTiEArPcCOubyLVd1KCMXye77sp1wGs4zBTNfEEcxabKPRFSbmB8w3lBUh5k68OGmlAPJ+LVmQ/IGdiea@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQsi4NuypvIIuNBHfPnORJnq0Ca6yi2nfXvrAUnhQnp4/uJjk
	qhkMEmP44pzKJRbZGW9wqdtuoZ8zFC/FqPTre1DWW8H5/E88ifjSGUHK2R/kh5FPf8NQsonMkZ5
	oOvKLS/vHonBV1WSTnp2n/9rOYPvypKIDijLL11eI
X-Gm-Gg: AZuq6aK2B+IPN+LG2t2fa8j/UvyK9R777wLdIbpDj/lO2I24g8Up/J5Bp6NN/S/Nh7x
	iYAFY+tewMzQ7i0gmOB+RvShQbOjc0QjzmRs8tiLSG6KeqE/cXxoT/4EG2YQ5HUKUpyw+V4q7IR
	F9+DS7bxLvzL2CPdslHRy2PJJyqHiOfCpmPvhoJ3Ud2Cesycigy3fgtlM9w7bVjzvaDLra9+Ksu
	eAXYlauvDHHOUlXohZixuOOf8nN2pS6HjrZnyOdmw9BC9tfLd6V5rzwn+iqd8CJ+vb5WfN43Ewk
	ts4mXHFbAjzUMVreniHnHjyCCXigegfB27etdw==
X-Received: by 2002:a05:600c:3b24:b0:477:2f6f:44db with SMTP id
 5b1f17b1804b1-483a441ed85mr992395e9.5.1771609613577; Fri, 20 Feb 2026
 09:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-4-tjmercier@google.com>
 <CAOQ4uxiPqUzBQAk8Tic7aFMsHtajEWENCTg+CQPMy5XtmS4kBQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiPqUzBQAk8Tic7aFMsHtajEWENCTg+CQPMy5XtmS4kBQ@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 20 Feb 2026 09:46:41 -0800
X-Gm-Features: AaiRm51nxtCKSVmNbDDauz1vLZUs5KV1q654jLHNKJz17gEkMqiQHsF23IMGBCk
Message-ID: <CABdmKX3Pd8sJpzuQD0tfKCznOy3=cDoAOEnN-COQa59weUFrqw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selftests: memcg: Add tests for IN_DELETE_SELF and IN_IGNORED
To: Amir Goldstein <amir73il@gmail.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77809-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 758CA169D40
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 9:44=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Feb 20, 2026 at 6:55=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > Add two new tests that verify inotify events are sent when memcg files
> > or directories are removed with rmdir.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Acked-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  .../selftests/cgroup/test_memcontrol.c        | 112 ++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >
> > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/t=
esting/selftests/cgroup/test_memcontrol.c
> > index 4e1647568c5b..57726bc82757 100644
> > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > @@ -10,6 +10,7 @@
> >  #include <sys/stat.h>
> >  #include <sys/types.h>
> >  #include <unistd.h>
> > +#include <sys/inotify.h>
> >  #include <sys/socket.h>
> >  #include <sys/wait.h>
> >  #include <arpa/inet.h>
> > @@ -1625,6 +1626,115 @@ static int test_memcg_oom_group_score_events(co=
nst char *root)
> >         return ret;
> >  }
> >
> > +static int read_event(int inotify_fd, int expected_event, int expected=
_wd)
> > +{
> > +       struct inotify_event event;
> > +       ssize_t len =3D 0;
> > +
> > +       len =3D read(inotify_fd, &event, sizeof(event));
> > +       if (len < (ssize_t)sizeof(event))
> > +               return -1;
> > +
> > +       if (event.mask !=3D expected_event || event.wd !=3D expected_wd=
) {
> > +               fprintf(stderr,
> > +                       "event does not match expected values: mask %d =
(expected %d) wd %d (expected %d)\n",
> > +                       event.mask, expected_event, event.wd, expected_=
wd);
> > +               return -1;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int test_memcg_inotify_delete_file(const char *root)
> > +{
> > +       int ret =3D KSFT_FAIL;
> > +       char *memcg =3D NULL;
> > +       int fd, wd;
> > +
> > +       memcg =3D cg_name(root, "memcg_test_0");
> > +
> > +       if (!memcg)
> > +               goto cleanup;
> > +
> > +       if (cg_create(memcg))
> > +               goto cleanup;
> > +
> > +       fd =3D inotify_init1(0);
> > +       if (fd =3D=3D -1)
> > +               goto cleanup;
> > +
> > +       wd =3D inotify_add_watch(fd, cg_control(memcg, "memory.events")=
, IN_DELETE_SELF);
> > +       if (wd =3D=3D -1)
> > +               goto cleanup;
> > +
> > +       if (cg_destroy(memcg))
> > +               goto cleanup;
> > +       free(memcg);
> > +       memcg =3D NULL;
> > +
> > +       if (read_event(fd, IN_DELETE_SELF, wd))
> > +               goto cleanup;
> > +
> > +       if (read_event(fd, IN_IGNORED, wd))
> > +               goto cleanup;
> > +
> > +       ret =3D KSFT_PASS;
> > +
> > +cleanup:
> > +       if (fd >=3D 0)
> > +               close(fd);
> > +       if (memcg)
> > +               cg_destroy(memcg);
> > +       free(memcg);
> > +
> > +       return ret;
> > +}
> > +
> > +static int test_memcg_inotify_delete_dir(const char *root)
> > +{
> > +       int ret =3D KSFT_FAIL;
> > +       char *memcg =3D NULL;
> > +       int fd, wd;
> > +
> > +       memcg =3D cg_name(root, "memcg_test_0");
> > +
> > +       if (!memcg)
> > +               goto cleanup;
> > +
> > +       if (cg_create(memcg))
> > +               goto cleanup;
> > +
> > +       fd =3D inotify_init1(0);
> > +       if (fd =3D=3D -1)
> > +               goto cleanup;
> > +
> > +       wd =3D inotify_add_watch(fd, memcg, IN_DELETE_SELF);
> > +       if (wd =3D=3D -1)
> > +               goto cleanup;
> > +
> > +       if (cg_destroy(memcg))
> > +               goto cleanup;
> > +       free(memcg);
> > +       memcg =3D NULL;
> > +
> > +       if (read_event(fd, IN_DELETE_SELF, wd))
> > +               goto cleanup;
>
>
> Does this test pass? I expect that listener would get event mask
> IN_DELETE_SELF | IN_ISDIR?

Yes, I tested on 4 different machines across different filesystems and
none of them set IN_ISDIR with IN_DELETE_SELF. The inotify docs say,
"may be set"... I wonder if that is wishful thinking?

