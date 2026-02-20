Return-Path: <linux-fsdevel+bounces-77808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFClHGmdmGmWKAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:44:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4CA169CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E3EE302B829
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BE636605D;
	Fri, 20 Feb 2026 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8fDZ5ig"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F6365A13
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609445; cv=pass; b=o8bjrj+BQvxewd8v53ZDW+dhgWEPn30BWj2nHMIBA35kcsylunyknRc/MDtBHfe49gBWRPlgDsAs35CYGw8vy1oJUuMKeJuZ+3k+FuvCJq88VTKFkN/jvAxvs0PlL0wT3iJPoCi/6JG3O/c0dRvoFx9wBFKLJwJbEs0DhcRE9nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609445; c=relaxed/simple;
	bh=B4Z1qVLBCGWcijfUcZ0E5ZLSN2ZLUxfaTWpanT2cb1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nU8SPsGFvEtUgXF6kMEuurhOBbct2TqeRcNw2cIVNp3qBf0SmrqPfEqSAUeCDPVjxzCYp+o4XrcAHitQxIMekWkARVZMKesJ7JOSgqOQYJpRXo7gmpqpGcjbYdorVdohkvtQ/j1Isz7thP0oGMDYt4wH8vAbDqvS1RBlTISi+o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8fDZ5ig; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8f8f2106f1so332748166b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 09:44:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771609442; cv=none;
        d=google.com; s=arc-20240605;
        b=ab+wvUR2hqUosDqPpye4hgaSJMve4ccC6LAeRWrmOrySZl8WBbF4XIgaB2jB7RpYIb
         p8frwaJFLP8D5YYTunYoqynAV+UnBTtfCC5S1+aT15SbHv7wRAO8O+rkxQTcEgNmY+Ly
         0ETc3T07eegrMbq9GS0FI2Jwb9n7kXEvmsYsNVcx9ZIzm8tBqFMamN0gRaJ8QCbfED7l
         Y4RZPpW4qjou/MVfpadRP+JHce43hPX9jQBbXg9/3zuA+FH/kUACCfrUKVnSnbSDWIRy
         SHJr3w+1Cqx/8Lkme/DwxI+DO/l+gOhf2BTUJjUA4Y239padyp10I0ndn0JOVd+iCiHO
         4JxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CKefpqt8YPMOlnxoTebgDHlgo2RmH3VSClTRGTDZyAk=;
        fh=7xme3RH4FLgO8Nhsn6nVFFnlHcC/srG1DE4i+Yn0m+M=;
        b=WEkotkEdmc+4I7bLXW+/MBihOqB6R5R3piiLIK4zUsvpQenLnA4fcNTpVV7cG0B/oD
         tsqaprxcc5vgBhc94dSWxqjVnsTK+1r33J2K30GqY8P9DVWHPsAUYvwMXaY6PEUt7Uso
         NXVVW3+wxnLF4qJ3f3hN2rf8sx5mbVgydUen8Bi2sY3xiVQAEAX01rYVYfx3O9PkUxe7
         B/PvGT1LKUGZTxfRhBtorJWOtRd+qAbBPMk5hu2Ul+XQCA4bIuMyuXqP+P4MESlXBK8L
         qFfl8nTz20a4iYM6Hx4zA14kQtW5he4/wqZ6++pGAy+GUlcEnofqoP5O/rkrRLItkIFX
         sJBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771609442; x=1772214242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKefpqt8YPMOlnxoTebgDHlgo2RmH3VSClTRGTDZyAk=;
        b=c8fDZ5igMeq1VUHwqJ58N5sonmzT3RIi9MFJ+sq+dD/OfYF4liIvkNK1q+DHN7apIT
         tK+thPoXY+FTcXvn7RFiZM1CxlIR4D3PAn2TceNc9G4pFNcnZTmXd+AbYBt1Wj9gO8lh
         JgDCQSRRh3MCr2/PKjiAjufAZ1O4JOeptJVOgADkv4OJGNQ9MHQzofbz058qkNHWmt+T
         Sp4OfR4IZapwEOduVev15bHZjjOMAZIRkyYvM/PCZxHHys5P3FO5OvJQnPPkxDPVHq6F
         RvZX+WC6GmmPzfy8dhz0tuRGH9I8Lwm0apKboYREKCyUlhItu0Co56yRAaDCiIFQgt4L
         Cn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609442; x=1772214242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CKefpqt8YPMOlnxoTebgDHlgo2RmH3VSClTRGTDZyAk=;
        b=SzmhxqgjuHV6iqQP+pQJqJFut+tmfFp4vkBPe98gPILYK21uW4Cp9ih/lytJiyIbTK
         Cjfy93gh3ew7eYp5DHtURSjKR0BoLTAat52yQoASH788iDqSTA9U48pLdVE7OwbpRod9
         RNAD9/To2mxYl1HEqLp6ozpaQPYuXcg4KQ556vGXN8Hb4CNNU6QoEkv/gO0XGsZW6cDG
         dYISf3pWZLryAmJk4wZwauszHiTFZY1A+CtMW9iVt12/03eDCkRQy2Gfgdi3oV1VtsMO
         w7IiCYoTfR+rBiVb+glJTeOlUfTLk0MqxNDi61BZD4qirlpOFi1YrlNHgJ4OemiOtMUH
         GYIA==
X-Forwarded-Encrypted: i=1; AJvYcCUsmv3fF7Tm/bDbMzQfsWMoO9/G5XvmhPTUphdvQ6PFy/V1shHWCGiauhygnRhgtth0Gm12iyHF2hXNMUXz@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4Nx/X1oixkOGIEYUurqnvtu2C8Xkx2g+FI2Swk6FQpkOHydP
	vgD2J4ALa8Ho79tRN364BFXeMuaDYhMnFLdLIBB6+9edWX/qZPfl1CTKeiAs2rJhOPC6aS6W8yr
	Zz4LfOPljEdtI6SDG/nQff2XoUGQspZ4=
X-Gm-Gg: AZuq6aI9hysithFgLtSpLpzHaqlAAKk89ZnMZxF+WWYgrjP0Cf3sKNaO+nMKYjdrNLA
	8kgH8XKdEP56rK2zm7Doz8TBx9Q6wEtL1D3NH373IugMYCiO1GAfITgSCi2R6bwsjDtVJThwftl
	rW0Xhxf/CK3g+4oIhAuPg+wt59l4WjRxq7Bq5UCRdk4i9jg4yU247HDcqIf/HebuowvNwOghr8j
	VrJSveuwI/Zl4B0kHne5Qity6i6MzluwVqAH/o528xeoELeIId71mXCWPwu8sZA3XdRhx7VTx/N
	S0gYABjuiCT2AYOSWB8vheRUMWM1nbULRu1PJC0HGw==
X-Received: by 2002:a17:907:7fa4:b0:b88:448c:be08 with SMTP id
 a640c23a62f3a-b908196ba0bmr21965166b.5.1771609441753; Fri, 20 Feb 2026
 09:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-4-tjmercier@google.com>
In-Reply-To: <20260220055449.3073-4-tjmercier@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Feb 2026 19:43:50 +0200
X-Gm-Features: AaiRm53Yd2hoByeyKZRhB94VwnmInZ2nkUk-ViEeYttOzbObERE3K1f4CUtv2ZM
Message-ID: <CAOQ4uxiPqUzBQAk8Tic7aFMsHtajEWENCTg+CQPMy5XtmS4kBQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selftests: memcg: Add tests for IN_DELETE_SELF and IN_IGNORED
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77808-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DF4CA169CBA
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 6:55=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> Add two new tests that verify inotify events are sent when memcg files
> or directories are removed with rmdir.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/tes=
ting/selftests/cgroup/test_memcontrol.c
> index 4e1647568c5b..57726bc82757 100644
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
> @@ -1625,6 +1626,115 @@ static int test_memcg_oom_group_score_events(cons=
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
> +static int test_memcg_inotify_delete_dir(const char *root)
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
> +       wd =3D inotify_add_watch(fd, memcg, IN_DELETE_SELF);
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


Does this test pass? I expect that listener would get event mask
IN_DELETE_SELF | IN_ISDIR?

Thanks,
Amir.

