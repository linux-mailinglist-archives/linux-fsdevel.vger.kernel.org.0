Return-Path: <linux-fsdevel+bounces-56321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1FDB15A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 10:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3154E2F3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 08:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21474255F2F;
	Wed, 30 Jul 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="djPONCMI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949C1B0F0A;
	Wed, 30 Jul 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753863749; cv=none; b=oa99TgQtqL3jTiwcKYPUpji8kwkf3vgxwy8zr2PmB+kL/BtGcjYwDN2o3Vj6dlEiAqMDTkGfhrV8jHKBrU8vhfzp6uptgMb/Wnt2XrFxzi4vYqz9YC6Uu8ZOLBnyy/e20c/T9KrJTyLF249XtqDw+Trmxkg8QmWxmBf3wTjMwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753863749; c=relaxed/simple;
	bh=gbBIR+y+konKWVt4kgPJOB4DIAF0clpx2ptWxEdYXK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0QIktrEy+v+j9VhfMvzbIe6BmcPOaLin2yoXpesQyfvVmUGxK0R/uTWyfcExSeV7HuG9rIPHP2FEciXwc8yoZqz1HTJyRwMiTWyMURNO32CLxRtzmAPiiGUgJIrPTRHdFL3HecId/F9MLZFmCOyGLoxp6xbOHI0rMNbbyU4GPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=djPONCMI; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k3qD6eVLYJwH4LbBEku4b7SzdXGj/kHmJcfyp+Dlc5M=; b=djPONCMIG+DoFcUgjEzPhHfmpu
	j+AcjQwuBP0zBs6CRtuClMBD82arfP9Pn+rT6ErOqXX+HUnoJpb0C5kKCIxnD/A9bFceyJTAGZXO/
	zjB6/dQlQ3BAlDAvQzTzXh+JV3fHGB/khzKfcZ8bJQsO+5JLFlJNVl5qtMh/hOvC3VAH/VOu12vZE
	MFSmk5/Fg4VUlObZdDF73TSRSbkoiXz84xv2GNxzMNmJ4PgLDKRWEiq5DiBDrsZQBvWAQ2vrBPZ7l
	z/4j7UO1nebaaA47zIJlegyNqPDPVIvIGOuyAlXdG21NZK/Nv6k/QNRMy025UMs1wuNvSu2OdzFZR
	Q09wgTVg==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:34579 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1uh24w-000000098Sh-10Cu;
	Wed, 30 Jul 2025 10:22:25 +0200
Date: Wed, 30 Jul 2025 10:22:23 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Subject: Re: [PATCH] fs: hidepid: Fixes hidepid non dumpable behavior
Message-ID: <rta37trkqzuvoim5muoukxmkbxcamlydwn6zfpm65k5qxyxb7y@pcq6nj54z6hl>
References: <20250717-hidepid_fix-v1-1-dd211d6eca6e@ssi.gouv.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-hidepid_fix-v1-1-dd211d6eca6e@ssi.gouv.fr>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Jann,

While documenting "hidepid=" I encountered those clunky behavior, which
I think we should not have.

Let say we set the "hidepid=" option to "invisible", processes will be fully
invisible to other users than root and the user that reads the procfs entry.

The fact that root is able to see every processes is partialy due to the fact
that the "gid=" variable is set to "0" by default :

```C has_pid_permissions
[...]
	if (in_group_p(fs_info->pid_gid))
		return true;
[...]
```

This means that if a process GID is in the group defined by the "gid=" option,
an authorization is directly returned, and the `ptrace_may_access()` function
is never called.

Thus, if one sets the "gid=" option to "1000", if a process is in this group,
it will now bypass the `security_ptrace_access_check()` hook calls.

This comes with the side effect that now, root will go through the
`ptrace_may_access()` checks and thus, if I have a root process without the
cap_sys_ptrace in its effective set, it will not be able to see other processes
anymore.

```C __ptrace_may_access
[...]
	if (ptrace_has_cap(tcred->user_ns, mode))
		goto ok;
	rcu_read_unlock();
	return -EPERM;
[...]
```

The following behavior thus happens :

```bash
$ sudo capsh --user=root --drop=cap_sys_ptrace -- -c /bin/bash
# mount -o remount,hidepid=2 /proc
# getpcaps $$
=ep cap_sys_ptrace-ep
# ps aux
root         1  0.0  0.1 204724  1404 ?        S    09:43   0:00 /usr/lib/python3.13/site-packages/virtme/guest/bin/virtme-ng-init
root         2  0.0  0.0      0     0 ?        S    09:43   0:00 [kthreadd]
root         3  0.0  0.0      0     0 ?        S    09:43   0:00 [pool_workqueue_release]
[...]

# mount -o remount,hidepid=2,gid=1000 /proc
# getpcaps $$
=ep cap_sys_ptrace-ep
# ps aux
root       621  0.0  0.2   8656  2556 pts/0    S    09:46   0:00 /bin/bash
root       641  0.0  0.4   9592  4012 pts/0    R+   10:03   0:00 ps aux
root       642  0.0  0.2   6896  2452 pts/0    S+   10:03   0:00 less
```

This also means that if a process accesses were controled by an LSM, lets say
with the `audit ptrace` option of AppArmor, they magically disappears for the
process in the group defined in the "gid=" hidepid option and those controls
are "transfered" to root, which was not controlled at first.

Also, note that with "hidepid=ptraceable", the "gid=" option is ignored
and `ptrace_may_access()` is always called.

Shouldn't we always check for the "gid=0" and also call the
`security_ptrace_access_check()` even if the group is set ?

Best regards,

Nicolas

