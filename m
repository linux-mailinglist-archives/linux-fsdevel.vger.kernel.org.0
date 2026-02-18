Return-Path: <linux-fsdevel+bounces-77545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCANJEt5lWl8RwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:33:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F07091541A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57A49300845F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8047131BC95;
	Wed, 18 Feb 2026 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV0DEnxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552C38FA3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403514; cv=pass; b=GbigdOQOBv6sbk3e7HylJ12Ax+GMkIsfnqoqQXk1G6mmftyNJWapj/LNxfeHoVZ9p0YJyhO6dek1u1emxL5BkXyKC5z+MoH8lsJ3UACMVni/kkaMX2mgc6tZGRUAdRktFSLqwZsw922GCiONn5ajTd26LZGPTSg+/JL0jtyjNgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403514; c=relaxed/simple;
	bh=g34/cXMgvqM8CAz3Jm7hMSLsp37KovcyCljYWpgZMh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEVP6P6cHlkJESW75vEYmmQpJcyXpH7tCeCFrAfIAkjXeWl0mX5Mwf3TK45buOE4cSzjt6FfnQYOnIYeRPtVStbpFkrXFki2N+TjoapQrcEqd6aH9NLaWY6TTC2f+rTp6FoRZ9a+/yVhwPF/m0p+LB2p10Hy6yS9QKA/NxILLjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV0DEnxP; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65a1970b912so995810a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 00:31:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771403511; cv=none;
        d=google.com; s=arc-20240605;
        b=Pxtc7/sDG0LsWvQijcs7RM58xGlvhg5z9HH8c79OpIVzRnjU03Ru4DQZV5+2b77xCY
         9NPf6lUWKD9GxQFQeojzadGua/EpWiNnZMs6RIGmseudhXotkaTOTm+cE8bQnAJiBn2R
         yoBcKpADeeskdGi3tSWHHMviSs2YOpnKwUOfnW5INnnsi7vWhypSe96vsgTHG4r6aQI8
         aZMDxrGyd/Fsb6RN8kevVAt01dAUIA2FjztwQQp5liK9zc2vewhXsXj1evn7aDzqot3Z
         1B6wclwRd6DnjsICebPisMMVwd3g4HbMciB+31vKs3AHOOZ9+ryVmrB6gRut0eME88J9
         Pt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T3U76qnvucsTLQ+BdD/Esd8/yZzq4QLRxWdPKbrqOpc=;
        fh=HaVfpPPRCsZ2uDGPj2bktu4el1T6amgLWlXkZkLHKuI=;
        b=HIt4xehFWjm8pLU8obpWNwvcJ863KaErk1SD5dqKSWyWf78n4/3T0snU8N5FurXyX1
         EwmkTtvtjy0T9WmU6VIeTEwyeR+2rQa0apFkT9+ITZJsaMRUE1+LSluLc7zXYtBbMh8J
         Feaw8BmRtyT5/cbcgnY18HgG6xqrrnzZvn2TbOqCkxgkcdHzIVaaU6ME3TP4wyu2uH6Z
         rHZ3/GOHphJeV3BlnQ8WNDSVZO+27fuATJ8xn0pGFFL+LdrO/giZJkB5obI6wNdSvb9S
         cpya3fCm7qod3WAjKweEdaib8W0UWb+iVDsXUq2+qpOyntUjKyHRCh2QKtTiTOz1oY3S
         P2Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771403511; x=1772008311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3U76qnvucsTLQ+BdD/Esd8/yZzq4QLRxWdPKbrqOpc=;
        b=cV0DEnxPnsQlkkqBoKaJBnR9i1cJOj5Ru4XBw6d/4t6WYqZol6c/Rbg8DXX1lSuzMt
         NIQhNbv+VUpFyMhdhKtwNP3b2U0XLEzOBaw1HWYP8hYbBtKZjLTYgOAn1jTebwrv0oYt
         D3KOnJZzFbY/lbxTkUlkuF2Tym2dUh1C+/yPV+o183OvaoTKivCEx6dupgrq4JyJNpAm
         ITiNuqapI/kBnRVks42K/JqKr5BbX6fY9dVENXb0XoStRY0/xJtwLIWEgrhRYhJR/Izb
         t/JqDZaAVKQOXy/nIXzHstKYshLIGZ660aXxQy5QwSgrfGJCd0PB8YfuAs+lUvGxPApY
         Izeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771403511; x=1772008311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3U76qnvucsTLQ+BdD/Esd8/yZzq4QLRxWdPKbrqOpc=;
        b=TorDDv2HswBBdXmmUjwuHLU28f0V9AEc2kdR3VupCbHDzL9zi4BmmatHuJVRE/y0y1
         d1B7AgXvZFTfWnUTPdv8KHH69IfWbbg+bNNwCo8ii6JeXWFPgF/0zCUewZ8PU+K/3rZz
         JaSNozGZ3NQCYSf6fv0QARHn68zKYl3Evk4EzwUDsgl+pHLuEcYp8FprMTfXo+ouSES4
         BKMKJXf9KyvQtoaTfeZim+UFPWkrL0gyD286TyWoiDUr+bFGEWWB7egz2a5nPFRAPxx2
         qAj2unMK6sf9RfzmuNHNhKyRsqbU+cVTGyW3On4vRJggEP/sw9YydYu2QR1ei4qgnLyV
         4loA==
X-Forwarded-Encrypted: i=1; AJvYcCVuq1hCWTFKBirZdCmbq6lvXTd7AIY5RuhaqU7ELKwBKW+qMtAuAWzKInsPhfv837NGIC2R9YUwMdKZ6IWL@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJa2l0Vbl/qlzJZylZSWrvwqZpD/Nzy/skAy6hqYmCYLZoybN
	0q2Tq+qf7mer9JWkub655g3Ihfiv6vowwdnn5LcRVT42LyM5Mg/dg67rbyihTJtwD5xGO6wpSrq
	nP5jCSE88WuW02KdQY6aNaN9G0CDo7t8=
X-Gm-Gg: AZuq6aKp7syv0ERjvAOglduhBMBaWOnOb2KlvVZR8AImZ8VeVGzdpb4JlYIrsdoH3aY
	cicP51E2HzNk3w/jN3ESje+dBDlCdRCUG/lmuhzjz7kghkcVfL7jjaxjzy2ZxfMTC9a2N4/C/MZ
	oKkEmR13xnns3zj6VhO/wyvr0F/+u+RcZaD8wvUR0L3llNWkzIovU6g1FlsmLH3XTjbrB7OJ0w0
	7qFeFfrJca/9DMAmUwvNi39TysO3QLvCq/vi+v/3ocpbLtgILhAmhl4LqAr+VbQtM11BuRHakIF
	HCQUL+3y
X-Received: by 2002:a05:6402:1141:b0:65a:4207:fbf0 with SMTP id
 4fb4d7f45d1cf-65c7720cc7bmr375715a12.15.1771403510892; Wed, 18 Feb 2026
 00:31:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com> <20260218032232.4049467-4-tjmercier@google.com>
In-Reply-To: <20260218032232.4049467-4-tjmercier@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Feb 2026 09:31:39 +0100
X-Gm-Features: AaiRm53vob00Ykj2SozMaQzwl7X3rV4VFQLdOBL-uAsZ0fNoE8t3B9B1XVNGy1c
Message-ID: <CAOQ4uxh4js=3yk_RxjY5AZmC4kCMVJzbq+4Wnn3mky-_i75QMw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests: memcg: Add tests IN_DELETE_SELF and
 IN_IGNORED on memory.events
To: "T.J. Mercier" <tjmercier@google.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77545-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: F07091541A2
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 5:22=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> Add two new tests that verify inotify events are sent when memcg files
> are removed.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Tejun Heo <tj@kernel.org>

Feel free to add:
Acked-by: Amir Goldstein <amir73il@gmail.com>

Although...

> ---
>  .../selftests/cgroup/test_memcontrol.c        | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/tes=
ting/selftests/cgroup/test_memcontrol.c
> index 4e1647568c5b..2b065d03b730 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -10,6 +10,7 @@
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <unistd.h>
> +#include <sys/inotify.h>
>  #include <sys/socket.h>
>  #include <sys/wait.h>
>  #include <arpa/inet.h>
> @@ -1625,6 +1626,125 @@ static int test_memcg_oom_group_score_events(cons=
t char *root)
>         return ret;
>  }
>
> +static int read_event(int inotify_fd, int expected_event, int expected_w=
d)
> +{
> +       struct inotify_event event;
> +       ssize_t len =3D 0;
> +
> +       len =3D read(inotify_fd, &event, sizeof(event));
> +       if (len < (ssize_t)sizeof(event))
> +               return -1;
> +
> +       if (event.mask !=3D expected_event || event.wd !=3D expected_wd) =
{
> +               fprintf(stderr,
> +                       "event does not match expected values: mask %d (e=
xpected %d) wd %d (expected %d)\n",
> +                       event.mask, expected_event, event.wd, expected_wd=
);
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int test_memcg_inotify_delete_file(const char *root)
> +{
> +       int ret =3D KSFT_FAIL;
> +       char *memcg =3D NULL, *child_memcg =3D NULL;
> +       int fd, wd;
> +
> +       memcg =3D cg_name(root, "memcg_test_0");
> +
> +       if (!memcg)
> +               goto cleanup;
> +
> +       if (cg_create(memcg))
> +               goto cleanup;
> +
> +       if (cg_write(memcg, "cgroup.subtree_control", "+memory"))
> +               goto cleanup;
> +
> +       child_memcg =3D cg_name(memcg, "child");
> +       if (!child_memcg)
> +               goto cleanup;
> +
> +       if (cg_create(child_memcg))
> +               goto cleanup;
> +
> +       fd =3D inotify_init1(0);
> +       if (fd =3D=3D -1)
> +               goto cleanup;
> +
> +       wd =3D inotify_add_watch(fd, cg_control(child_memcg, "memory.even=
ts"), IN_DELETE_SELF);
> +       if (wd =3D=3D -1)
> +               goto cleanup;
> +
> +       cg_write(memcg, "cgroup.subtree_control", "-memory");
> +
> +       if (read_event(fd, IN_DELETE_SELF, wd))
> +               goto cleanup;
> +
> +       if (read_event(fd, IN_IGNORED, wd))
> +               goto cleanup;
> +
> +       ret =3D KSFT_PASS;
> +
> +cleanup:
> +       if (fd >=3D 0)
> +               close(fd);
> +       if (child_memcg)
> +               cg_destroy(child_memcg);
> +       free(child_memcg);
> +       if (memcg)
> +               cg_destroy(memcg);
> +       free(memcg);
> +
> +       return ret;
> +}
> +
> +static int test_memcg_inotify_delete_rmdir(const char *root)
> +{
> +       int ret =3D KSFT_FAIL;
> +       char *memcg =3D NULL;
> +       int fd, wd;
> +
> +       memcg =3D cg_name(root, "memcg_test_0");
> +
> +       if (!memcg)
> +               goto cleanup;
> +
> +       if (cg_create(memcg))
> +               goto cleanup;
> +
> +       fd =3D inotify_init1(0);
> +       if (fd =3D=3D -1)
> +               goto cleanup;
> +
> +       wd =3D inotify_add_watch(fd, cg_control(memcg, "memory.events"), =
IN_DELETE_SELF);
> +       if (wd =3D=3D -1)
> +               goto cleanup;
> +
> +       if (cg_destroy(memcg))
> +               goto cleanup;
> +       free(memcg);
> +       memcg =3D NULL;
> +
> +       if (read_event(fd, IN_DELETE_SELF, wd))
> +               goto cleanup;
> +
> +       if (read_event(fd, IN_IGNORED, wd))
> +               goto cleanup;
> +
> +       ret =3D KSFT_PASS;
> +
> +cleanup:
> +       if (fd >=3D 0)
> +               close(fd);
> +       if (memcg)
> +               cg_destroy(memcg);
> +       free(memcg);
> +
> +       return ret;
> +}
> +
>  #define T(x) { x, #x }
>  struct memcg_test {
>         int (*fn)(const char *root);
> @@ -1644,6 +1764,8 @@ struct memcg_test {
>         T(test_memcg_oom_group_leaf_events),
>         T(test_memcg_oom_group_parent_events),
>         T(test_memcg_oom_group_score_events),
> +       T(test_memcg_inotify_delete_file),
> +       T(test_memcg_inotify_delete_rmdir),

How about another test case:
- Watch the cgroup directory (not the child file)
- Destroy cgroup
- Expect IN_DELETE_SELF | IN_ISDIR

I realize that this test won't pass with your implementation (right?)
but that is not ok IMO.

If we wish to make IN_DELETE_SELF available for kernfs,
it should not be confined to regular files IMO.

Thanks,
Amir.

