Return-Path: <linux-fsdevel+bounces-77811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEdWCLifmGnJKAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:54:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C7B169E94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A1A8307F090
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514D736605A;
	Fri, 20 Feb 2026 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nXcuvZEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486D2D7D47
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610013; cv=pass; b=X6zMrFthiYwZTUAYPiZUPq+jtGBAr2kS/94XUaPXD0fbbOjAL1aHNgRD4Ic4bVj0K7gpxE8f8GJJRS3ZXzg/OZYoFVyTcJsE343Kb9ZvTRz2hD7KPa+g/6+HWZbUHc5oia9WQmBEVf9/eWZC33CEa1YTOSAwAr+or1mLJQCETjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610013; c=relaxed/simple;
	bh=6mvexzEJMyqKObc2kptqIRTofWhm/82iwmnJl33CcXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APqtH78SesLu62eGBxwtH3+qMVWefG7+ZQctu86F2m7tawNsvVlqXdcbzijIlStQRg7M3fu2yRDlfZP2y3vRVNYvMJ6o37t8atDvPuos0XueCY58tKcYKpTAMbuMd1HpbtRM0CxVw8j8Rg0Z9x0hLY9lg98FM2yIceN7jU+WIyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nXcuvZEX; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806b0963a9so2485e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 09:53:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771610011; cv=none;
        d=google.com; s=arc-20240605;
        b=Nvf4Pt1mTsTjGpmPcAIn4lzZjBmHotg+Ie6dIOf550JQmAIOhlwMHL5ec88+XifzW3
         t4Ls5Y34uzb6XMi2ReePrB6UQfQs3csnZOmIp1WdIT8HwtL+1NmCmPaBmqUS0rHWnWdh
         d6Nff0BRB0AUp4Ih24FRmtWwv92DM01SqpEP5fofekAjpNbt46JwdFJJ2JkLzDFdQZ4d
         ZmcsY2743stpkscAQtZwZyliTW+iKQH3vDA+MqHLYMEzCzs30c9OfZf7NrbsY7Amo7PW
         JbBlCJjs5+lx5lv0igWxwergxk8AZ194sL9GdbZksrzg1Oxxco0HTw9TJVXhA/4WBHND
         bPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJXYxrDbswnHka6Gtr3ub6RBkdkqHTgw9iEO6yYMyQA=;
        fh=cq9iwt2/RnWBIQ+NKzTQiwgoBDH3uBwC0/Azrz62NzM=;
        b=G5x+FegPuxygSnvFh79yMPw2IiznjKcAEPBkxmTmxDpp8zya6fgCJvTwz8pDpoeqSD
         7IkaqMqfgax/kheBRDXDr6Ac0YvnCBmz+6Zbpk1rvW5bCsW6vef2luoErcWtNtLjP/OM
         87dykyVBrje/KTrjx8YREkcPRa0kxW+iWoM44d1OhMq3a7VCsrstac+KU1pckl69Fb/i
         osbmT2OYFtkLAeZWEPdVSwwPhDkSBgEXH8h56rABJKgzrg49PaWA+nB5kGnWYrDa+bBa
         RzxxOpsHuXJQVf9xsi/2sC/DCYXbt3lIDWww3mpEAfBI7HkJgzejQjJQfzAYDtJZwF5a
         zWpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771610011; x=1772214811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJXYxrDbswnHka6Gtr3ub6RBkdkqHTgw9iEO6yYMyQA=;
        b=nXcuvZEXEWY34qR4P1PnDNzmW5L7fA/ROo55L2FZL2edN8qWc0KP6Ep0buoG4gHwf9
         163C3S5der9Bg61gCQNOJb32WMulYxfd+3NILzcEVGM+I1viLf+8znNnq62SYuvt/3HA
         xXMDUyOIU/al8/vp6NEAaHLJoMy/5njiZLrpIWDi8Ps9wmQbguh0mtUMVgKnyOMze1cx
         Tv7iVAkbrPc0shb7IQqiVAG1TW9ksSQ6UxwpNABLEyGSQWE2qeHzQ1ne08eLbGWoSYmI
         nAoPgBqdVe2MqFUb4blxRhIZdNL0J2GQ6meBDkZHL7KcaUgIvH18g4s594hKunwC2AGz
         QZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771610011; x=1772214811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJXYxrDbswnHka6Gtr3ub6RBkdkqHTgw9iEO6yYMyQA=;
        b=QtA8RiNHdPKWxM6Fr5I1cu1R9UDJBXi9qBM7GFVkILMIHmmbw4GkQImL6JjQqeyvAc
         4NxeBrCZA5VdFMfRWP7ZPs2yvWbrv7J2+CSSU6SJ67AjoV88Tzt/PDLzRKITeutCQI0P
         bgeCM+y2yr7pwplpOFitcFwLlQz09XzBsnQSuTVSy2S9KtGm12E0vKbApKzfldFG6nCO
         rUa5nDUIYqSbhLbQJwjRFVOel9pu70aePxV72Q4zFhgwAe2JzHSPQm3EXWRY3ScasecX
         sCj9Fh6NLRX2ikh7386R2YjhWKf9TIGHLCCjvaFiB2G6QeIq+pzrNH7ktnPPpZEVkIOA
         X9MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUztQKexm9K6rWiffo5V8D5cKqPGJyh/YAdVO0iUnR/gYlwTl4fEDe3yNrHWsLgfyoDoIiFIfUWCs8pZCMo@vger.kernel.org
X-Gm-Message-State: AOJu0YwVfrQAlt/FTXBQ+ZvQDlrt0vbsgh8nB5FNv0nrEzwGr0kDglAY
	UjVcU/ZiI7D0z622bK00a+BEeaJeLjq+beoqBPSOegab0upyxxlB1XT1s9CHAtF3rW95ib7l1jT
	aybF7F32Gq/WJcTZt1dlEUprrisDQEYdwXXQrpJ5z
X-Gm-Gg: AZuq6aIQhN4T+i9VAdqfSVom6Jsy9RSkE83U4maW3/JSqSiGvoaxbouptNMmDfsrpUo
	U548w5u3pCTmLnuYLd+3W7Pk7DLP+XSKGrFE6svhl5tvc6Q2HqMPLMQ8QXdF5wT/uFAxVbnCfBY
	MkO+jzG2ninh7G6UY85mItM1EfRtujz5ICdMTD/kq3q9+i2v3yU1pb54yrBjDWP2zlsonaBuPoo
	/vCpVks1J21yKyQIx/LZy+mlQw9K/7xfcV3o1vmeIHiTGul7lVtBHvMdmKO9zubpzJ8Jt6cWZrt
	bQgoyb8BUyaEC8Rhc/CP1Z9a2n/SjTgM1oOAoQ==
X-Received: by 2002:a05:600c:5916:b0:47d:7428:d00c with SMTP id
 5b1f17b1804b1-483a4426fcfmr611355e9.17.1771610010645; Fri, 20 Feb 2026
 09:53:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-4-tjmercier@google.com>
 <CAOQ4uxiPqUzBQAk8Tic7aFMsHtajEWENCTg+CQPMy5XtmS4kBQ@mail.gmail.com> <CABdmKX3Pd8sJpzuQD0tfKCznOy3=cDoAOEnN-COQa59weUFrqw@mail.gmail.com>
In-Reply-To: <CABdmKX3Pd8sJpzuQD0tfKCznOy3=cDoAOEnN-COQa59weUFrqw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 20 Feb 2026 09:53:18 -0800
X-Gm-Features: AaiRm523izsi0NGn8Sj7ziPjsd_zQLpE-spc-8PJpygVLLpqc8KPVf5Y_qsAi4o
Message-ID: <CABdmKX0H5Bx7qsk7JmOEnA2NZBHXd+QSYuwXHQGvaN6ppM38NA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77811-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70C7B169E94
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 9:46=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Fri, Feb 20, 2026 at 9:44=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Fri, Feb 20, 2026 at 6:55=E2=80=AFAM T.J. Mercier <tjmercier@google.=
com> wrote:
> > >
> > > Add two new tests that verify inotify events are sent when memcg file=
s
> > > or directories are removed with rmdir.
> > >
> > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > Acked-by: Tejun Heo <tj@kernel.org>
> > > Acked-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  .../selftests/cgroup/test_memcontrol.c        | 112 ++++++++++++++++=
++
> > >  1 file changed, 112 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools=
/testing/selftests/cgroup/test_memcontrol.c
> > > index 4e1647568c5b..57726bc82757 100644
> > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > @@ -10,6 +10,7 @@
> > >  #include <sys/stat.h>
> > >  #include <sys/types.h>
> > >  #include <unistd.h>
> > > +#include <sys/inotify.h>
> > >  #include <sys/socket.h>
> > >  #include <sys/wait.h>
> > >  #include <arpa/inet.h>
> > > @@ -1625,6 +1626,115 @@ static int test_memcg_oom_group_score_events(=
const char *root)
> > >         return ret;
> > >  }
> > >
> > > +static int read_event(int inotify_fd, int expected_event, int expect=
ed_wd)
> > > +{
> > > +       struct inotify_event event;
> > > +       ssize_t len =3D 0;
> > > +
> > > +       len =3D read(inotify_fd, &event, sizeof(event));
> > > +       if (len < (ssize_t)sizeof(event))
> > > +               return -1;
> > > +
> > > +       if (event.mask !=3D expected_event || event.wd !=3D expected_=
wd) {
> > > +               fprintf(stderr,
> > > +                       "event does not match expected values: mask %=
d (expected %d) wd %d (expected %d)\n",
> > > +                       event.mask, expected_event, event.wd, expecte=
d_wd);
> > > +               return -1;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int test_memcg_inotify_delete_file(const char *root)
> > > +{
> > > +       int ret =3D KSFT_FAIL;
> > > +       char *memcg =3D NULL;
> > > +       int fd, wd;
> > > +
> > > +       memcg =3D cg_name(root, "memcg_test_0");
> > > +
> > > +       if (!memcg)
> > > +               goto cleanup;
> > > +
> > > +       if (cg_create(memcg))
> > > +               goto cleanup;
> > > +
> > > +       fd =3D inotify_init1(0);
> > > +       if (fd =3D=3D -1)
> > > +               goto cleanup;
> > > +
> > > +       wd =3D inotify_add_watch(fd, cg_control(memcg, "memory.events=
"), IN_DELETE_SELF);
> > > +       if (wd =3D=3D -1)
> > > +               goto cleanup;
> > > +
> > > +       if (cg_destroy(memcg))
> > > +               goto cleanup;
> > > +       free(memcg);
> > > +       memcg =3D NULL;
> > > +
> > > +       if (read_event(fd, IN_DELETE_SELF, wd))
> > > +               goto cleanup;
> > > +
> > > +       if (read_event(fd, IN_IGNORED, wd))
> > > +               goto cleanup;
> > > +
> > > +       ret =3D KSFT_PASS;
> > > +
> > > +cleanup:
> > > +       if (fd >=3D 0)
> > > +               close(fd);
> > > +       if (memcg)
> > > +               cg_destroy(memcg);
> > > +       free(memcg);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static int test_memcg_inotify_delete_dir(const char *root)
> > > +{
> > > +       int ret =3D KSFT_FAIL;
> > > +       char *memcg =3D NULL;
> > > +       int fd, wd;
> > > +
> > > +       memcg =3D cg_name(root, "memcg_test_0");
> > > +
> > > +       if (!memcg)
> > > +               goto cleanup;
> > > +
> > > +       if (cg_create(memcg))
> > > +               goto cleanup;
> > > +
> > > +       fd =3D inotify_init1(0);
> > > +       if (fd =3D=3D -1)
> > > +               goto cleanup;
> > > +
> > > +       wd =3D inotify_add_watch(fd, memcg, IN_DELETE_SELF);
> > > +       if (wd =3D=3D -1)
> > > +               goto cleanup;
> > > +
> > > +       if (cg_destroy(memcg))
> > > +               goto cleanup;
> > > +       free(memcg);
> > > +       memcg =3D NULL;
> > > +
> > > +       if (read_event(fd, IN_DELETE_SELF, wd))
> > > +               goto cleanup;
> >
> >
> > Does this test pass? I expect that listener would get event mask
> > IN_DELETE_SELF | IN_ISDIR?
>
> Yes, I tested on 4 different machines across different filesystems and
> none of them set IN_ISDIR with IN_DELETE_SELF. The inotify docs say,
> "may be set"... I wonder if that is wishful thinking?

Oh, very intentional:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/=
notify/inotify/inotify_fsnotify.c?h=3Dv6.19#n109

