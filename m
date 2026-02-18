Return-Path: <linux-fsdevel+bounces-77640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDnzHK9DlmmYdAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:56:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E49DE15ABA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3C16301726F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DB8339866;
	Wed, 18 Feb 2026 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ShmlCCdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569933893A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455373; cv=pass; b=AOsTEbIycN0HfoUouYmbk14J9jsI5Ieo/llAYj1F0zI85q1y7mcyhzROcZMclFOcJG5X/iLFUE/yeenNUXO4xQMsu8VA5RZ7ftcLp7pPJ0uQB2DZhQZkIq2NGG4nyk5YLXIb9a7gftJ4LYpzHEC5oo6pPaoRjBBUZyB4pcA6Z0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455373; c=relaxed/simple;
	bh=JCFoaESIl/QxCrjmGNPhcuSnGB4Slki2xY4HPtQx/4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6KLqMLOAfyRpg0sIzmsYP0ZzfaZMqyxaduds3u2QuFjM2nLetF8lB4OrICqSlieBRM3Low8qRmsfM59rQu0ZAuGza0TNCRvxGS2UpdYkLoa92BsLcTGfAVpli0eQJHuRsEgM+GbBHMf+sSbIfpj+Fv1fYsD52wOxd0immlspvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ShmlCCdd; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48371d2f661so10085e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 14:56:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771455370; cv=none;
        d=google.com; s=arc-20240605;
        b=FD+TlWO4Q2pF4b0CAnS0XjPmb+ZFp/6YKeHzBLkmKMY65lg5CVuPgDQDdklLCIQoaM
         N4+/dSGxlOBVw74yShGJYj+rfHh41vu97ng3G6swwVmKUocH+livbxVzaxcg+PMKrx9/
         TzqyscSDv7xAQvG2kjQTUmRHw2aydxVDHGHnP7J4eCWO9Axh0Z7XTwpafJHjJ9SQrjOB
         nPH64K3H6cIhbY5PplrfPKc2Ew4g2OX3ylXYQMUC3qSmucZ9zOcQnFeo32WO6AdkY82Y
         WVnOt1Poxq7o7f8Wqa9zECKfXFaBk4pwlLFHBp84DUoNQFamzG8Q1kMuCSX4r/PHi5Bv
         +keg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ObMI2eFUctqy8D6J4/YNbtZUvjU4iP4F1TUzixbIpBQ=;
        fh=PKNWh1G0wlE/MpJK/7upNWbnE7CU427k1+vX9Lo58gg=;
        b=QAocjEwfoQ2l6YzZag2ruTnX2r8YYVnsE9jba1LOewDQdvwMuTEAqWmsiAgSDt3g7J
         wthFggBdhzlhjPMigvUKM6oOBhNJ20FFeQD0HKdab70KflcACR3jy8QSMyfLSGV03BN1
         zqsvP8w2D4XoGmNMIWAt8N78TjFrHvQoj+g+6pPwj8AXo+T1/N6Kn25fWzNO79ihxs6F
         H50+VGPcXMojmnRt6ItJ9o+15l6RHCyVXRXIUgVIlSlzU5D4O9dMVMjJ4qItuYUhkVha
         hSQgfbm/Fex62HXAdepEkseCcVO3LgitQg00mT20E7kKa6EngPnARsUV9j957fz6e6sy
         NPYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771455370; x=1772060170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObMI2eFUctqy8D6J4/YNbtZUvjU4iP4F1TUzixbIpBQ=;
        b=ShmlCCdd4EYuW9SOyL9+33ELtNZugmxb1vZGD+0++2FLl3YTln9waf8vfCSGY6ZD0x
         jP+RLd04LGQpO/oDCeie7WdtsLBJejFnTFwQ6xsRLodaPWPoXWDrm1MD7Qvm47axmHgd
         dw7hLe4igMVXsKucUSRXovB+QY9Srq2PAvp5/tYJR3J0k9/qAHCN4xh0QIagY9Ne0ioE
         7qEpB3pz5U0X5Pao/4YTDCP/hyhecbXvIlyADXefqBYPi/zcpViDvqMC3lS+yf1274Ox
         VqROLP0iXNQlAhM7GctLHzXu8KqdHArPrAmF4Ws2mGmmwCKuYiqQjmdNvRsdC2egNbpu
         kQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771455370; x=1772060170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ObMI2eFUctqy8D6J4/YNbtZUvjU4iP4F1TUzixbIpBQ=;
        b=ieytxr8K/nS//HpZ9veIwoJ0BPrEoVNaIJegPI7V4z86ScW2VOd/eGGr4oMK641Hfx
         wDB0GWIEY0QMfYhd+e5SzYZW70Ng/mFnuYqxoJsxKh3rtMueXejMEzNWJj8DA0ahmUiV
         TYmd++Ogup+YpBbRGnCvFkHQNKwmSEz/VYuWllr87+e7AQBTP6Z2lQZReUQHPg15oghl
         C0uFQ/XaNkIUdHOZPKMnZz3YuqKVHgvNfPgbsoO2tiIv0wM3yT3MPL1mLlCyES3m9jx7
         X0ZWgaeuhxmb7GAEG74B++pTZE2yX69s+W79WB9vYj7dEPf1nB9/flj8VBh2YwcDhZLm
         h09Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbsj9l2jPxlFYAozy4Z/NzC+k73fboIBWwTYsiSI3tGJp4JlGMrvN25GmqjTfXVN8zyJiFI2x1IuROWCiM@vger.kernel.org
X-Gm-Message-State: AOJu0YyuvGWD5JQ8Cy/FtH34C/vPQ+lpHdGqW5riaJjHBDzdmIV07tec
	UIQqEQAxD/i8b3y9rCiDWVbdAyCjE6QNvGUGEyN8gW8FqammwhkFqNEjdVYKb1j+gfx4GvThsFp
	O+yK10VmLtku2z0EIZnAr4jmxESvdG79l9852Mgpy
X-Gm-Gg: AZuq6aIAiyIipZ8XuLxsvf5CiTZI/bjFTAfYt/gpZC3h1NkjNzeWre1GvzXFlNIflzQ
	6GzKwP6CJW3JAfbBo/0ogrvXWp9W5SfSROnW4SWRmxaxhmRaETcSa2vs7Pl3r6mPV91B/H6pIIL
	TO/cpGCNiwgO+UsTplwLsQnkhZNCr78htvkJIuHRh9XIDg1lBmOCuNH+jTsOsiYwOfnv791HHzr
	+avu/T79YFiQUIdVsOvLeuiSf/O9bigtGCDXcOT+Tc48TlUMKi6qqTlKU7u43LUvp8iPZB75hz/
	y0WqeKIdliUkX0wpaHTn3/IVM1usBluM1vYju9xAliA7PT1EQH/2MRJj7Mw5LGqaRZprVPhJ72e
	5sJ6R
X-Received: by 2002:a05:600c:b4c:b0:477:2f6f:44db with SMTP id
 5b1f17b1804b1-4839fc2b05cmr17515e9.5.1771455370121; Wed, 18 Feb 2026 14:56:10
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com>
 <20260218032232.4049467-4-tjmercier@google.com> <CAOQ4uxh4js=3yk_RxjY5AZmC4kCMVJzbq+4Wnn3mky-_i75QMw@mail.gmail.com>
In-Reply-To: <CAOQ4uxh4js=3yk_RxjY5AZmC4kCMVJzbq+4Wnn3mky-_i75QMw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 18 Feb 2026 14:55:58 -0800
X-Gm-Features: AaiRm50YpaIIErmI92nhYeTavLIal9YPKGY4uR1R97u7wbwoJ0wYYjhpDKRvR7o
Message-ID: <CABdmKX08hFBq3myZqecr1rEYpGMo5xBGJVfB1aNz7t95-8bySQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests: memcg: Add tests IN_DELETE_SELF and
 IN_IGNORED on memory.events
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77640-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E49DE15ABA3
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:31=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Wed, Feb 18, 2026 at 5:22=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > Add two new tests that verify inotify events are sent when memcg files
> > are removed.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Acked-by: Tejun Heo <tj@kernel.org>
>
> Feel free to add:
> Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks!

> Although...
>
> > ---
> >  .../selftests/cgroup/test_memcontrol.c        | 122 ++++++++++++++++++
> >  1 file changed, 122 insertions(+)
> >
> > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/t=
esting/selftests/cgroup/test_memcontrol.c
> > index 4e1647568c5b..2b065d03b730 100644
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
> > @@ -1625,6 +1626,125 @@ static int test_memcg_oom_group_score_events(co=
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
> > +       char *memcg =3D NULL, *child_memcg =3D NULL;
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
> > +       if (cg_write(memcg, "cgroup.subtree_control", "+memory"))
> > +               goto cleanup;
> > +
> > +       child_memcg =3D cg_name(memcg, "child");
> > +       if (!child_memcg)
> > +               goto cleanup;
> > +
> > +       if (cg_create(child_memcg))
> > +               goto cleanup;
> > +
> > +       fd =3D inotify_init1(0);
> > +       if (fd =3D=3D -1)
> > +               goto cleanup;
> > +
> > +       wd =3D inotify_add_watch(fd, cg_control(child_memcg, "memory.ev=
ents"), IN_DELETE_SELF);
> > +       if (wd =3D=3D -1)
> > +               goto cleanup;
> > +
> > +       cg_write(memcg, "cgroup.subtree_control", "-memory");
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
> > +       if (child_memcg)
> > +               cg_destroy(child_memcg);
> > +       free(child_memcg);
> > +       if (memcg)
> > +               cg_destroy(memcg);
> > +       free(memcg);
> > +
> > +       return ret;
> > +}
> > +
> > +static int test_memcg_inotify_delete_rmdir(const char *root)
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
> >  #define T(x) { x, #x }
> >  struct memcg_test {
> >         int (*fn)(const char *root);
> > @@ -1644,6 +1764,8 @@ struct memcg_test {
> >         T(test_memcg_oom_group_leaf_events),
> >         T(test_memcg_oom_group_parent_events),
> >         T(test_memcg_oom_group_score_events),
> > +       T(test_memcg_inotify_delete_file),
> > +       T(test_memcg_inotify_delete_rmdir),
>
> How about another test case:
> - Watch the cgroup directory (not the child file)
> - Destroy cgroup
> - Expect IN_DELETE_SELF | IN_ISDIR
>
> I realize that this test won't pass with your implementation (right?)
> but that is not ok IMO.

Yes, that is correct, but I don't think any docs mention support for
monitoring kernfs directories, only files.

> If we wish to make IN_DELETE_SELF available for kernfs,
> it should not be confined to regular files IMO.

Based on what Honza discovered about i_nlink, it looks like we could
get VFS to send IN_DELETE_SELF for kernfs dirs with something like
this:

@@ -1540,6 +1558,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
                         if (kernfs_type(pos) =3D=3D KERNFS_FILE)
                                kernfs_notify_file_deleted(pos);
+                        else if (kernfs_type(pos) =3D=3D KERNFS_DIR)
+                               kernfs_clear_inode_nlink(pos); <--
calls clear_nlink(inode); for every super

But I don't have a use for it at the moment.

