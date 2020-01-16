Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E431013D567
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 08:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgAPHyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 02:54:24 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:48321 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgAPHyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 02:54:23 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M5gAG-1iz8ag3qI6-007Dg7; Thu, 16 Jan 2020 08:54:09 +0100
To:     YunQiang Su <syq@debian.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     YunQiang Su <ysu@wavecomp.com>
References: <20200116022049.164659-1-syq@debian.org>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2] binfmt_misc: pass info about P flag by AT_FLAGS
Message-ID: <7af5c24d-dd24-b728-92cf-a5a759787590@vivier.eu>
Date:   Thu, 16 Jan 2020 08:54:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116022049.164659-1-syq@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7/OcgETe0F66YHTSEaDjSJ3GZorzr7u9jao/T8a657xQPaisHxO
 mY5jeY1DYG4JDuRH36PJtn0jkDsWnayqPmLFf49iG01x8F0BRwZrmUIEkRfQ9kQvFYHq2n+
 UgohsYVZDHK59ugEeh1j1k5H263WGvJ68XF8MWMOVEymmgzum8/ffjgoQn2d8/a1dyeh/F7
 0GRjiW70GnelfiIhYo/+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1T+TJsQX8Rw=:vVmh8ijUKE7zpeFkf/R8uT
 jVRpn2dU2x1JtrRmbjmgpvh/V2/RTzKkVePfoG0obHp2KUOAN5c7eUp7D7DU/s2zQzy5Irzra
 D5Z5XFsnkXHpjGM58PY1GerXGvZqWT26/j4jfmzyk27M8qFIGCi+W3dbiOE+ZaoaZWFPNKUeT
 fVJYXJsLfVJ2Y3rhu1jewHeJFH5B37W3Ddjh9mttMffYwAC7f2O8Vnxr80WAlqopYfeJ3+X1+
 krKMdr/R7dl7DUvF3AqRzHdyBN2FOPCHvWg/v8rqZlpWzrEgQfJZPzOgzCZ4v/oqhnNlTAoSh
 1A0gsdTEwTHy9aZ++uG8vB9s3ccs1/gE0vF+jVfWdlZa1oyFeGRa26lg9VFSMjP3ZNFAdz3Bq
 yJ42CzZWEQYe3cCq9FgcqiPGnUM/zpxTx1vpVJC1A8WigCV0wW1q6lyNPsiYXY3NV5EGoXjgv
 KS/9oyCqohMNxwKUkKDe+nFeSkD1adEeLjsitNazoLffGa/dcniYzKCDh85j+CjqT1Gt1erUk
 mcpuoRPxQu0+TL4DdxMGtQBWjfs3958iGU44kx8Ea2os9egtnaQPHF2UUUaI3ZuXSwDCVDpjj
 FEEP/6oXT9aEvCYOsnpqWvouKlYRJEnYcxSnhrM/rpawIFu5EaPOakvcg1p/8aBWREFNhHtKM
 FA1grdcqXavAQ1tMWgKZ4cNsh2slhVMPXveUujrcaJjNL9qw5Uh+OmLj7eHA6J0R6Akkb23UV
 oKBzOnbF62ZleV8lkUGIdn0FdhRcJtJkbtXdeMKNmAdUY1reqD3r1YIENiWm62z1w+wKbCuNy
 bVUd+Ihvh80h9YPnVvP2ngVA8mM2n5lq3kwrBps2NfUgINzUbqocCJpUveq6JgOHw3mki5yvB
 HeaYgw019MEFGeACxpfANb14gh3fkfPrkG6VTtmTU=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 16/01/2020 à 03:20, YunQiang Su a écrit :
> From: YunQiang Su <ysu@wavecomp.com>
> 
> Currently program invoked by binfmt_misc cannot be aware about whether
> P flag, aka preserve path is enabled.
> 
> Some applications like qemu need to know since it has 2 use case:
>   1. call by hand, like: qemu-mipsel-static test.app OPTION
>      so, qemu have to assume that P option is not enabled.
>   2. call by binfmt_misc. If qemu cannot know about whether P flag is
>      enabled, distribution's have to set qemu without P flag, and
>      binfmt_misc call qemu like:
>        qemu-mipsel-static /absolute/path/to/test.app OPTION
>      even test.app is not called by absoulute path, like
>        ./relative/path/to/test.app
> 
> This patch passes this information by the 3rd bits of unused AT_FLAGS.
> Then, in qemu, we can get this info by:
>    getauxval(AT_FLAGS) & (1<<3)
> 
> v1->v2:
>   not enable kdebug
> 
> See: https://bugs.launchpad.net/qemu/+bug/1818483
> Signed-off-by: YunQiang Su <ysu@wavecomp.com>
> ---
>  fs/binfmt_elf.c         | 6 +++++-
>  fs/binfmt_elf_fdpic.c   | 6 +++++-
>  fs/binfmt_misc.c        | 2 ++
>  include/linux/binfmts.h | 4 ++++
>  4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index f4713ea76e82..d33ee07d7f57 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -178,6 +178,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	unsigned char k_rand_bytes[16];
>  	int items;
>  	elf_addr_t *elf_info;
> +	elf_addr_t flags = 0;
>  	int ei_index;
>  	const struct cred *cred = current_cred();
>  	struct vm_area_struct *vma;
> @@ -252,7 +253,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>  	NEW_AUX_ENT(AT_BASE, interp_load_addr);
> -	NEW_AUX_ENT(AT_FLAGS, 0);
> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0) {
> +		flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
> +	}

Perhaps we also need a different flag in AT_FLAG than in interp_flag as
BINPRM_FLAGS_PRESERVE_ARGV0 is also part of the internal ABI?

Al?

Thanks,
Laurent

