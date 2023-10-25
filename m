Return-Path: <linux-fsdevel+bounces-1160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC8A7D6CEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C483B21289
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746F127EE2;
	Wed, 25 Oct 2023 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YUExOLi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF5208CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 13:17:52 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A94C182
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 06:17:49 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a8ee23f043so56534707b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698239868; x=1698844668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhI+0U3C4maNiYVWrEGT2SlLeFp5Rtq5XADzsjH+0y0=;
        b=YUExOLi3bB63BLB3LmYOz5fXJsFz3giuSe6MQq8EMmn0CbAicL3fynsuabXbu5RnpM
         8YerNvWGWSvLxa4RpdC8ZKkr6GO+zdwHREY0+u6WbPDTZxY+HFatJXYan1fFXjo1IKdZ
         vGEF4K/J3gwmKsairkEsU5iQ7q5Z1Av03mCrwGf7P42OsacRgFuwDhR5676fhGxlXki8
         lFKd24FRToX7wRSQOqIZAmTOxSTYCIl9/0b9RZGhHsO3R6+yi2d9Zi1Uwp5XD+D9tPlf
         s1OBenoev16RvP2Jd8aoDcQDGm7D28qgTAnINVZAzfr0KmVchGFRN/KpvWSgc+Mwd0iC
         2fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698239868; x=1698844668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhI+0U3C4maNiYVWrEGT2SlLeFp5Rtq5XADzsjH+0y0=;
        b=jXgearby6obtzdZQrKnqXBnIvpZb2IBS3VuX6O4MMHm1A0pBs55YnN/elMQW/zTuep
         KBoVaiey3DC5qPVMI7qpv9yi5DAK1D7ma3FX41pyLpw0rH+Baa+1sJXjGf1zKjP+Mg4w
         KrajeFliyERU7BpUi5o41P9ydx4yxEl2UaFbr/AaPsMHV7YT/e3fjM3RgU3HFNqMydV7
         tQr15KGapoid6mHQbynEKe1cGWH0bRKrb4HXadX1WCpu1Wgz8QO4Dtp5PCe5htRTxOQW
         9CzwpnLSGDHj02Mczzp0P7eGbsct6rW6MF5NpidGHN+VChRSAtmckkDIjvySEEH0XrCu
         UrFQ==
X-Gm-Message-State: AOJu0Yxe4gjQHkgYxsYMkhJgtFLDaS40mqcz9XZDNzNfjvl3opynapd4
	H/rR1toFF1MiSGAhic5sdpoBMwb2Wmm1O+J8M6g+
X-Google-Smtp-Source: AGHT+IEmM4VRNzvMlwEig7LRJ0/I8fW70H8OJI07w9jqnVgfL3k2gIIT/BmMHa1TUskU3QK75Bw+pBd7fYHozFYVqsg=
X-Received: by 2002:a25:5856:0:b0:da0:86e8:aea4 with SMTP id
 m83-20020a255856000000b00da086e8aea4mr840904ybb.57.1698239868426; Wed, 25 Oct
 2023 06:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 25 Oct 2023 09:17:37 -0400
Message-ID: <CAHC9VhThNGA+qRgs=rOmEfvffj3qLzB=Jx4ii-uksuU1YJ6F5w@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v2 00/14] device_cgroup: guard mknod for
 non-initial user namespace
To: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, gyroidos@aisec.fraunhofer.de, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 5:42=E2=80=AFAM Michael Wei=C3=9F
<michael.weiss@aisec.fraunhofer.de> wrote:
>
> Introduce the flag BPF_DEVCG_ACC_MKNOD_UNS for bpf programs of type
> BPF_PROG_TYPE_CGROUP_DEVICE which allows to guard access to mknod
> in non-initial user namespaces.
>
> If a container manager restricts its unprivileged (user namespaced)
> children by a device cgroup, it is not necessary to deny mknod()
> anymore. Thus, user space applications may map devices on different
> locations in the file system by using mknod() inside the container.
>
> A use case for this, we also use in GyroidOS, is to run virsh for
> VMs inside an unprivileged container. virsh creates device nodes,
> e.g., "/var/run/libvirt/qemu/11-fgfg.dev/null" which currently fails
> in a non-initial userns, even if a cgroup device white list with the
> corresponding major, minor of /dev/null exists. Thus, in this case
> the usual bind mounts or pre populated device nodes under /dev are
> not sufficient.
>
> To circumvent this limitation, allow mknod() by checking CAP_MKNOD
> in the userns by implementing the security_inode_mknod_nscap(). The
> hook implementation checks if the corresponding permission flag
> BPF_DEVCG_ACC_MKNOD_UNS is set for the device in the bpf program.
> To avoid to create unusable inodes in user space the hook also
> checks SB_I_NODEV on the corresponding super block.
>
> Further, the security_sb_alloc_userns() hook is implemented using
> cgroup_bpf_current_enabled() to allow usage of device nodes on super
> blocks mounted by a guarded task.
>
> Patch 1 to 3 rework the current devcgroup_inode hooks as an LSM
>
> Patch 4 to 8 rework explicit calls to devcgroup_check_permission
> also as LSM hooks and finalize the conversion of the device_cgroup
> subsystem to a LSM.
>
> Patch 9 and 10 introduce new generic security hooks to be used
> for the actual mknod device guard implementation.
>
> Patch 11 wires up the security hooks in the vfs
>
> Patch 12 and 13 provide helper functions in the bpf cgroup
> subsystem.
>
> Patch 14 finally implement the LSM hooks to grand access
>
> Signed-off-by: Michael Wei=C3=9F <michael.weiss@aisec.fraunhofer.de>
> ---
> Changes in v2:
> - Integrate this as LSM (Christian, Paul)
> - Switched to a device cgroup specific flag instead of a generic
>   bpf program flag (Christian)
> - do not ignore SB_I_NODEV in fs/namei.c but use LSM hook in
>   sb_alloc_super in fs/super.c
> - Link to v1: https://lore.kernel.org/r/20230814-devcg_guard-v1-0-654971a=
b88b1@aisec.fraunhofer.de
>
> Michael Wei=C3=9F (14):
>   device_cgroup: Implement devcgroup hooks as lsm security hooks
>   vfs: Remove explicit devcgroup_inode calls
>   device_cgroup: Remove explicit devcgroup_inode hooks
>   lsm: Add security_dev_permission() hook
>   device_cgroup: Implement dev_permission() hook
>   block: Switch from devcgroup_check_permission to security hook
>   drm/amdkfd: Switch from devcgroup_check_permission to security hook
>   device_cgroup: Hide devcgroup functionality completely in lsm
>   lsm: Add security_inode_mknod_nscap() hook
>   lsm: Add security_sb_alloc_userns() hook
>   vfs: Wire up security hooks for lsm-based device guard in userns
>   bpf: Add flag BPF_DEVCG_ACC_MKNOD_UNS for device access
>   bpf: cgroup: Introduce helper cgroup_bpf_current_enabled()
>   device_cgroup: Allow mknod in non-initial userns if guarded
>
>  block/bdev.c                                 |   9 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |   7 +-
>  fs/namei.c                                   |  24 ++--
>  fs/super.c                                   |   6 +-
>  include/linux/bpf-cgroup.h                   |   2 +
>  include/linux/device_cgroup.h                |  67 -----------
>  include/linux/lsm_hook_defs.h                |   4 +
>  include/linux/security.h                     |  18 +++
>  include/uapi/linux/bpf.h                     |   1 +
>  init/Kconfig                                 |   4 +
>  kernel/bpf/cgroup.c                          |  14 +++
>  security/Kconfig                             |   1 +
>  security/Makefile                            |   2 +-
>  security/device_cgroup/Kconfig               |   7 ++
>  security/device_cgroup/Makefile              |   4 +
>  security/{ =3D> device_cgroup}/device_cgroup.c |   3 +-
>  security/device_cgroup/device_cgroup.h       |  20 ++++
>  security/device_cgroup/lsm.c                 | 114 +++++++++++++++++++
>  security/security.c                          |  75 ++++++++++++
>  19 files changed, 294 insertions(+), 88 deletions(-)
>  delete mode 100644 include/linux/device_cgroup.h
>  create mode 100644 security/device_cgroup/Kconfig
>  create mode 100644 security/device_cgroup/Makefile
>  rename security/{ =3D> device_cgroup}/device_cgroup.c (99%)
>  create mode 100644 security/device_cgroup/device_cgroup.h
>  create mode 100644 security/device_cgroup/lsm.c

Hi Michael,

I think this was lost because it wasn't CC'd to the LSM list (see
below).  I've CC'd the list on my reply, but future patch submissions
that involve the LSM must be posted to the LSM list if you would like
them to be considered.

http://vger.kernel.org/vger-lists.html#linux-security-module

--=20
paul-moore.com

