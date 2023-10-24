Return-Path: <linux-fsdevel+bounces-1114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1467D59F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 19:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3216A2818D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC93B2A8;
	Tue, 24 Oct 2023 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJzYRlrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF521A19;
	Tue, 24 Oct 2023 17:52:25 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F7AE8;
	Tue, 24 Oct 2023 10:52:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso7096113a12.0;
        Tue, 24 Oct 2023 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698169941; x=1698774741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T46xYbc9SnhWUAzFRxoyQoMZoGtasSe/R4I6iHwAO7w=;
        b=BJzYRlrO3LhcbLoBTmbqPSpA/ZXwXlkxVh6WNVPcOjdZbbtPp/ukBnYMSkayYYfgsF
         ungpcoEKG/blUkVU5a0ue1FOTY/VDriuoJwMaG+raBJ1hS2mTrvxht6USbl1BnSlqLQF
         Jog1zd12lfxvEnhESXl/htbSJCsPHs5H4dP5pWZ+HiwBr3mUP9I1j98TkPKH+OT5eJsG
         HrWATggqO1VOqDXolvDv7KK2bY9yFQzcTDWV7J78p+HWdSM/2XafZLoyudlP7pKyqKtl
         8q8kLl+NINRy95DSsoPy6DEyFkF4JeE+uvXn/ljQair6OPrr0h/zSpIzyGpchrTWXSdF
         L+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698169941; x=1698774741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T46xYbc9SnhWUAzFRxoyQoMZoGtasSe/R4I6iHwAO7w=;
        b=gkHCJCGymKHX3BpL7Jxvg0JiHHUfAUIUfCAHWYZsr/7HddxyHaueZooKgy0V/KBd8t
         dlIIXluaq34SD4hVc/AWyRUMNw4Jnbjiap4lWibmvkndoRX5oSVGVZMOiuQcTQhALyaj
         3wtoyAilqgH9nWolpbHJk6Q+H6UD1usnwVyHC7P34sMkbzqY7LntdoqAkr3CQc+fiYmo
         lGiUSmtpv1EPCZQ9HFkGnIalIH8YSAgKOu+3cq8wOaB0OeFhhm58UhOOrb5ruOuWjbxm
         184JFe1lZ7QW61tlUt62iaLIEQ+/7d7tuaYkXaHYb/jIJMn/RHMwM7tnnYRrt3NHNUP9
         xMAA==
X-Gm-Message-State: AOJu0YxO53JugiQ0apDsARaeh2H7Zu1Txu5ooPtB7pLzGRPdR2CmMh22
	aWeL78rGIQj9Yx1wzfaoHZLXRp+xS/qzQUn/hlU=
X-Google-Smtp-Source: AGHT+IFnWsGWEYeJij82wqTSVOt37wI6bf5HG3ryeu/szQVpa/IlM/AEGs/P1oIaYcgW47iV8bupkeXyX3uS9Kc4cs4=
X-Received: by 2002:a17:907:728b:b0:9b7:292:85f6 with SMTP id
 dt11-20020a170907728b00b009b7029285f6mr9888199ejc.12.1698169941102; Tue, 24
 Oct 2023 10:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016180220.3866105-1-andrii@kernel.org>
In-Reply-To: <20231016180220.3866105-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Oct 2023 10:52:09 -0700
Message-ID: <CAEf4BzaMLg31g6Jm9LmFM9UYUjm1Eq7P6Y-KnoiDoh7Sbj_RWg@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 00/18] BPF token and BPF FS-based delegation
To: Andrii Nakryiko <andrii@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com, 
	sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 11:04=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> This patch set introduces an ability to delegate a subset of BPF subsyste=
m
> functionality from privileged system-wide daemon (e.g., systemd or any ot=
her
> container manager) through special mount options for userns-bound BPF FS =
to
> a *trusted* unprivileged application. Trust is the key here. This
> functionality is not about allowing unconditional unprivileged BPF usage.
> Establishing trust, though, is completely up to the discretion of respect=
ive
> privileged application that would create and mount a BPF FS instance with
> delegation enabled, as different production setups can and do achieve it
> through a combination of different means (signing, LSM, code reviews, etc=
),
> and it's undesirable and infeasible for kernel to enforce any particular =
way
> of validating trustworthiness of particular process.
>
> The main motivation for this work is a desire to enable containerized BPF
> applications to be used together with user namespaces. This is currently
> impossible, as CAP_BPF, required for BPF subsystem usage, cannot be names=
paced
> or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BP=
F
> helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely=
 read
> arbitrary memory, and it's impossible to ensure that they only read memor=
y of
> processes belonging to any given namespace. This means that it's impossib=
le to
> have a mechanically verifiable namespace-aware CAP_BPF capability, and as=
 such
> another mechanism to allow safe usage of BPF functionality is necessary.B=
PF FS
> delegation mount options and BPF token derived from such BPF FS instance =
is
> such a mechanism. Kernel makes no assumption about what "trusted" constit=
utes
> in any particular case, and it's up to specific privileged applications a=
nd
> their surrounding infrastructure to decide that. What kernel provides is =
a set
> of APIs to setup and mount special BPF FS instanecs and derive BPF tokens=
 from
> it. BPF FS and BPF token are both bound to its owning userns and in such =
a way
> are constrained inside intended container. Users can then pass BPF token =
FD to
> privileged bpf() syscall commands, like BPF map creation and BPF program
> loading, to perform such operations without having init userns privileged=
.
>
> This version incorporates feedback and suggestions ([3]) received on v3 o=
f
> this patch set, and instead of allowing to create BPF tokens directly ass=
uming
> capable(CAP_SYS_ADMIN), we instead enhance BPF FS to accepts a few new
> delegation mount options. If these options are used and BPF FS itself is
> properly created, set up, and mounted inside the user namespaced containe=
r,
> user application is able to derive a BPF token object from BPF FS instanc=
e,
> and pass that token to bpf() syscall. As explained in patch #2, BPF token
> itself doesn't grant access to BPF functionality, but instead allows kern=
el to
> do namespaced capabilities checks (ns_capable() vs capable()) for CAP_BPF=
,
> CAP_PERFMON, CAP_NET_ADMIN, and CAP_SYS_ADMIN, as applicable. So it forms=
 one
> half of a puzzle and allows container managers and sys admins to have saf=
e and
> flexible configuration options: determining which containers get delegati=
on of
> BPF functionality through BPF FS, and then which applications within such
> containers are allowed to perform bpf() commands, based on namespaces
> capabilities.
>
> Previous attempt at addressing this very same problem ([0]) attempted to
> utilize authoritative LSM approach, but was conclusively rejected by upst=
ream
> LSM maintainers. BPF token concept is not changing anything about LSM
> approach, but can be combined with LSM hooks for very fine-grained securi=
ty
> policy. Some ideas about making BPF token more convenient to use with LSM=
 (in
> particular custom BPF LSM programs) was briefly described in recent LSF/M=
M/BPF
> 2023 presentation ([1]). E.g., an ability to specify user-provided data
> (context), which in combination with BPF LSM would allow implementing a v=
ery
> dynamic and fine-granular custom security policies on top of BPF token. I=
n the
> interest of minimizing API surface area and discussions this was relegate=
d to
> follow up patches, as it's not essential to the fundamental concept of
> delegatable BPF token.
>
> It should be noted that BPF token is conceptually quite similar to the id=
ea of
> /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
> difference is the idea of using virtual anon_inode file to hold BPF token=
 and
> allowing multiple independent instances of them, each (potentially) with =
its
> own set of restrictions. And also, crucially, BPF token approach is not u=
sing
> any special stateful task-scoped flags. Instead, bpf() syscall accepts
> token_fd parameters explicitly for each relevant BPF command. This addres=
ses
> main concerns brought up during the /dev/bpf discussion, and fits better =
with
> overall BPF subsystem design.
>
> This patch set adds a basic minimum of functionality to make BPF token id=
ea
> useful and to discuss API and functionality. Currently only low-level lib=
bpf
> APIs support creating and passing BPF token around, allowing to test kern=
el
> functionality, but for the most part is not sufficient for real-world
> applications, which typically use high-level libbpf APIs based on `struct
> bpf_object` type. This was done with the intent to limit the size of patc=
h set
> and concentrate on mostly kernel-side changes. All the necessary plumbing=
 for
> libbpf will be sent as a separate follow up patch set kernel support make=
s it
> upstream.
>
> Another part that should happen once kernel-side BPF token is established=
, is
> a set of conventions between applications (e.g., systemd), tools (e.g.,
> bpftool), and libraries (e.g., libbpf) on exposing delegatable BPF FS
> instance(s) at well-defined locations to allow applications take advantag=
e of
> this in automatic fashion without explicit code changes on BPF applicatio=
n's
> side. But I'd like to postpone this discussion to after BPF token concept
> lands.
>
>   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.o=
rg/
>   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BP=
F_LSFMM2023.pdf
>   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving=
@fb.com/
>   [3] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785=
e@brauner/
>
> v7->v8:
>   - add bpf_token_allow_cmd and bpf_token_capable hooks (Paul);
>   - inline bpf_token_alloc() into bpf_token_create() to prevent accidenta=
l
>     divergence with security_bpf_token_create() hook (Paul);

Hi Paul,

I believe I addressed all the concerns you had in this revision. Can
you please take a look and confirm that all things look good to you
from LSM perspective? Thanks!


> v6->v7:
>   - separate patches to refactor bpf_prog_alloc/bpf_map_alloc LSM hooks, =
as
>     discussed with Paul, and now they also accept struct bpf_token;
>   - added bpf_token_create/bpf_token_free to allow LSMs (SELinux,
>     specifically) to set up security LSM blob (Paul);
>   - last patch also wires bpf_security_struct setup by SELinux, similar t=
o how
>     it's done for BPF map/prog, though I'm not sure if that's enough, so =
worst
>     case it's easy to drop this patch if more full fledged SELinux
>     implementation will be done separately;
>   - small fixes for issues caught by code reviews (Jiri, Hou);
>   - fix for test_maps test that doesn't use LIBBPF_OPTS() macro (CI);
> v5->v6:
>   - fix possible use of uninitialized variable in selftests (CI);
>   - don't use anon_inode, instead create one from BPF FS instance (Christ=
ian);
>   - don't store bpf_token inside struct bpf_map, instead pass it explicit=
ly to
>     map_check_btf(). We do store bpf_token inside prog->aux, because it's=
 used
>     during verification and even can be checked during attach time for so=
me
>     program types;
>   - LSM hooks are left intact pending the conclusion of discussion with P=
aul
>     Moore; I'd prefer to do LSM-related changes as a follow up patch set
>     anyways;
> v4->v5:
>   - add pre-patch unifying CAP_NET_ADMIN handling inside kernel/bpf/sysca=
ll.c
>     (Paul Moore);
>   - fix build warnings and errors in selftests and kernel, detected by CI=
 and
>     kernel test robot;
> v3->v4:
>   - add delegation mount options to BPF FS;
>   - BPF token is derived from the instance of BPF FS and associates itsel=
f
>     with BPF FS' owning userns;
>   - BPF token doesn't grant BPF functionality directly, it just turns
>     capable() checks into ns_capable() checks within BPF FS' owning user;
>   - BPF token cannot be pinned;
> v2->v3:
>   - make BPF_TOKEN_CREATE pin created BPF token in BPF FS, and disallow
>     BPF_OBJ_PIN for BPF token;
> v1->v2:
>   - fix build failures on Kconfig with CONFIG_BPF_SYSCALL unset;
>   - drop BPF_F_TOKEN_UNKNOWN_* flags and simplify UAPI (Stanislav).
>
> Andrii Nakryiko (18):
>   bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
>   bpf: add BPF token delegation mount options to BPF FS
>   bpf: introduce BPF token object
>   bpf: add BPF token support to BPF_MAP_CREATE command
>   bpf: add BPF token support to BPF_BTF_LOAD command
>   bpf: add BPF token support to BPF_PROG_LOAD command
>   bpf: take into account BPF token when fetching helper protos
>   bpf: consistenly use BPF token throughout BPF verifier logic
>   bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
>   bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM hooks
>   bpf,lsm: add BPF token LSM hooks
>   libbpf: add bpf_token_create() API
>   selftests/bpf: fix test_maps' use of bpf_map_create_opts
>   libbpf: add BPF token support to bpf_map_create() API
>   libbpf: add BPF token support to bpf_btf_load() API
>   libbpf: add BPF token support to bpf_prog_load() API
>   selftests/bpf: add BPF token-enabled tests
>   bpf,selinux: allocate bpf_security_struct per BPF token
>
>  drivers/media/rc/bpf-lirc.c                   |   2 +-
>  include/linux/bpf.h                           |  83 ++-
>  include/linux/filter.h                        |   2 +-
>  include/linux/lsm_hook_defs.h                 |  15 +-
>  include/linux/security.h                      |  43 +-
>  include/uapi/linux/bpf.h                      |  44 ++
>  kernel/bpf/Makefile                           |   2 +-
>  kernel/bpf/arraymap.c                         |   2 +-
>  kernel/bpf/bpf_lsm.c                          |  15 +-
>  kernel/bpf/cgroup.c                           |   6 +-
>  kernel/bpf/core.c                             |   3 +-
>  kernel/bpf/helpers.c                          |   6 +-
>  kernel/bpf/inode.c                            |  98 ++-
>  kernel/bpf/syscall.c                          | 215 ++++--
>  kernel/bpf/token.c                            | 247 +++++++
>  kernel/bpf/verifier.c                         |  13 +-
>  kernel/trace/bpf_trace.c                      |   2 +-
>  net/core/filter.c                             |  36 +-
>  net/ipv4/bpf_tcp_ca.c                         |   2 +-
>  net/netfilter/nf_bpf_link.c                   |   2 +-
>  security/security.c                           | 101 ++-
>  security/selinux/hooks.c                      |  47 +-
>  tools/include/uapi/linux/bpf.h                |  44 ++
>  tools/lib/bpf/bpf.c                           |  30 +-
>  tools/lib/bpf/bpf.h                           |  39 +-
>  tools/lib/bpf/libbpf.map                      |   1 +
>  .../bpf/map_tests/map_percpu_stats.c          |  20 +-
>  .../selftests/bpf/prog_tests/libbpf_probes.c  |   4 +
>  .../selftests/bpf/prog_tests/libbpf_str.c     |   6 +
>  .../testing/selftests/bpf/prog_tests/token.c  | 629 ++++++++++++++++++
>  30 files changed, 1577 insertions(+), 182 deletions(-)
>  create mode 100644 kernel/bpf/token.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
>
> --
> 2.34.1
>
>

