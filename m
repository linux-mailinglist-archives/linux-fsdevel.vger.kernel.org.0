Return-Path: <linux-fsdevel+bounces-76888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMudJCOXi2kCXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 21:37:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E54B11F0E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 21:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D323B30488A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC53321AA;
	Tue, 10 Feb 2026 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="alU7uXpN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618132F745
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770755869; cv=pass; b=BtZ6W4Z0n68L4PX2HjTZDwH9hwYpIUwu2wYPBXXBCVLOu6xKPZUjgUe5F9BbMvCHB2brWKtPvcR6m1NeVnkTTfJiVjZTEBfh6oEQGVBEE1y/UWqX5qS2PLfEuMc+gJVVtprGj2ejBj329DKjiLaWh1r1RPHgnCRSLOg6KAU2xQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770755869; c=relaxed/simple;
	bh=ttYIFJDDeP7EMLnxlLPVz52qkQlsuyLNc483J3nXZV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6ZOVyWBAOyJmAhl+ofEt//gF5BpVrEOEKCGtTHQvF/DWU9muvISLKfpz3RFpkyS47INnC6CvOJtOSFseOvtkhK1zfzPEptlEaorm68VUIqNncWOA/stcu9Z/6oEshh7pMCmIkyjNfWo7J0sCyKCuwvkt0gM1bIW99zY+sY+PAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=alU7uXpN; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79495b1aaa7so60787247b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 12:37:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770755867; cv=none;
        d=google.com; s=arc-20240605;
        b=LF+8UeASWcqaagvRKHBcTchu1ABJ5/UuWVL987ZNUG0A59KfWvAVWt4nWOjQoTfHJC
         6NCffHCxiBACzQFHGg0osUaJPAQgRdNeNTm0sE47/Xc1oZemb60HzbY81X3/NdthBu3c
         4uEWpsLNUQgW/fTLEH6FFSrh5k4UaILbKA1Eelp0auYO9fTBtdwxuDFOAJEx9rlNfqgu
         mpA3MHpD4OCzXmkxXCv5wZBCCSb0Jmv5Jl8RqcrWCN9sWXK1WGk6XqsupHRQeZHeb9Ew
         /0EPBru6iiIXpn/PY02m8d8JsP6QabuibGUUb5/k91o2ck9eSQ7Gw1o9W2WC8gnfjHq3
         FzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qlZ4xyzf/Ip4fodbzXtwn4FA9xAkiKblH6NpEXTYsSQ=;
        fh=VE9EeiC0boIXf2iWOPraZC7+r0tR+sqcMDwHGvwIo8c=;
        b=TT9vuzClyzFY/PHPv9LJUfUe03WE3FZRCep6oCBIq46BOnte6Qb/NP/8IPITrcq1Uo
         EIL68RKTsPDA8fjljzac67XX3l775hBAtfrvFDIHUU4ghfyiPvxL6AT/pOT+8VY23y0n
         4BymuDy9qOs9Wkdzv2V9P8h98P5pjCiFw74zni1/9+5xZWAnEKSelPPJvwDU1ssxdsat
         JSGWCENtSTTg58bSuQZOrZyo4o69HVw5ww6fsXhLRT6E693ZeC+7EY4sgfwg2pK3uwkK
         /L+epJVTft2sJ+xHDAWuCFBJDctd+Ocsr9CJPyTozbq0RJmyieMZ7UzwTby6b1MRirgF
         rmOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770755867; x=1771360667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qlZ4xyzf/Ip4fodbzXtwn4FA9xAkiKblH6NpEXTYsSQ=;
        b=alU7uXpN6h8IS89L0LDPYTQC8U9d9dlTUbvsa/TJxR4NpCeUo9QbQtWRQ66Yry7zMt
         Ov98V2Qqf7J/JykRxkWAgWxUjBrp7lKwzkgxSaH+MX8QXBP6YMDAYLcYWaet3jWJko0R
         +op5mvVBp7Mp5D8DRZxX4zlo62vygHyFLkA7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770755867; x=1771360667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlZ4xyzf/Ip4fodbzXtwn4FA9xAkiKblH6NpEXTYsSQ=;
        b=Os/UelJCWoHFiknaDto9480Qfnq7o6SEGTaYTugWIa8RNEGV+EiWXj6E+yFk3fSWBb
         P/X71VtZCnY7HPMNFE0ljamB2K2cRfiCA01XEYl1/lQCLbtPYBcIJzHgwJRoSZe+6xrA
         b6uJalB35E9Feb2PkCLjFtc4kMzljL05R4CMW2NQFhtR+YFmNhFYelnmXjNxId18nntw
         PaDtD+qK4s+rftRJ+P3I21wRv6y0u2PYsRup0xJPuHBA0mDd5zVCuIeBz8t+nxM2Ec9h
         3QiZxEtSXwTLc9hhmwWALJpWhdkWhJgutjmvVNFwNQz5SyHHYeW3TKVUAsqPxZjoWFnL
         xgFg==
X-Forwarded-Encrypted: i=1; AJvYcCUfZ/YsCtU//LMfpKkfxVpyC4+wFzwETWl9D5smQa6ntpdcoU2jxgGRc7n8m9mdlpmSD1Q5/+DH58WaF/30@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8yumLcjWtrEE3ZXCOVu1T5OdX506iuT0hcUZ3H75mzr+00FEQ
	Vr3LhXcTsZH1/gYCiWjJMtN931G8+UImwflKb9UtxHahebOzVOXUlJ8+tFFBqfxHyv1gcNJAndK
	Saylcz6jmpN/T+MZorgL+PGlc4G1y1efIB2ADE0KEdA==
X-Gm-Gg: AZuq6aKtZO6v7NGN68ZVXiPCQ6d1XyD8wpNNs+iGuDxfDhYoi2XsWqdTCXFNoPlGV41
	FkvySG1DV318dUv9BsQYZrng1Jh4ouihu6yx+elgeNyBfGLp8IFV1Hikea6mlK2nStWmR2g2GDv
	JKwYWengIr3u/9jme4URgXOfXudYKZ45e+m/+wzaa8CoaLZl2TiLq1Zc2oRuHmHSPEwFAlK8wig
	N7P4nuKKP+vUI94CZ0Zy4R7oYaVlyaDh5lofAP9/XuSBOrl+AB1/05Luv8Fug5AM09lOaSUOG7C
	vbewseUZrngKkbpVzFfamZZY6DH7+xT8EjVZmvI=
X-Received: by 2002:a05:690c:c50c:b0:794:c679:1d1d with SMTP id
 00721157ae682-7965efaa2camr29027447b3.24.1770755867381; Tue, 10 Feb 2026
 12:37:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209190605.1564597-1-avagin@google.com> <20260209190605.1564597-5-avagin@google.com>
In-Reply-To: <20260209190605.1564597-5-avagin@google.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 10 Feb 2026 21:37:34 +0100
X-Gm-Features: AZwV_Qh72JA-cEZtTCmkRnGPAQAW0gnIwzAXo_f1l64-sLCqrTNi2ouzycVcpIs
Message-ID: <CAJqdLrow_EEda3Gw8Q9E2VF9pWxa7COUu88fZZiP1-=Mk00DqA@mail.gmail.com>
Subject: Re: [PATCH 4/4] selftests/exec: add test for HWCAP inheritance
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76888-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mihalicyn.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,futurfusion.io:email]
X-Rspamd-Queue-Id: 0E54B11F0E1
X-Rspamd-Action: no action

Am Mo., 9. Feb. 2026 um 20:06 Uhr schrieb Andrei Vagin <avagin@google.com>:
>
> Verify that HWCAPs are correctly inherited/preserved across execve() when
> modified via prctl(PR_SET_MM_AUXV).
>
> The test performs the following steps:
> * reads the current AUXV using prctl(PR_GET_AUXV);
> * finds an HWCAP entry and toggles its most significant bit;
> * replaces the AUXV of the current process with the modified one using
>   prctl(PR_SET_MM, PR_SET_MM_AUXV);
> * executes itself to verify that the new program sees the modified HWCAP
>   value.
>
> Signed-off-by: Andrei Vagin <avagin@google.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  tools/testing/selftests/exec/.gitignore      |   1 +
>  tools/testing/selftests/exec/Makefile        |   1 +
>  tools/testing/selftests/exec/hwcap_inherit.c | 105 +++++++++++++++++++
>  3 files changed, 107 insertions(+)
>  create mode 100644 tools/testing/selftests/exec/hwcap_inherit.c
>
> diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
> index 7f3d1ae762ec..2ff245fd0ba6 100644
> --- a/tools/testing/selftests/exec/.gitignore
> +++ b/tools/testing/selftests/exec/.gitignore
> @@ -19,3 +19,4 @@ null-argv
>  xxxxxxxx*
>  pipe
>  S_I*.test
> +hwcap_inherit
> \ No newline at end of file
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index 45a3cfc435cf..e73005965e05 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -20,6 +20,7 @@ TEST_FILES := Makefile
>  TEST_GEN_PROGS += recursion-depth
>  TEST_GEN_PROGS += null-argv
>  TEST_GEN_PROGS += check-exec
> +TEST_GEN_PROGS += hwcap_inherit
>
>  EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*        \
>                $(OUTPUT)/S_I*.test
> diff --git a/tools/testing/selftests/exec/hwcap_inherit.c b/tools/testing/selftests/exec/hwcap_inherit.c
> new file mode 100644
> index 000000000000..1b43b2dbb1d0
> --- /dev/null
> +++ b/tools/testing/selftests/exec/hwcap_inherit.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <sys/auxv.h>
> +#include <sys/prctl.h>
> +#include <sys/wait.h>
> +#include <linux/prctl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <elf.h>
> +#include <linux/auxvec.h>
> +
> +#include "../kselftest.h"
> +
> +static int find_msb(unsigned long v)
> +{
> +       return sizeof(v)*8 - __builtin_clzl(v) - 1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       unsigned long auxv[1024], hwcap, new_hwcap, hwcap_idx;
> +       int size, hwcap_type = 0, hwcap_feature, count, status;
> +       char hwcap_str[32], hwcap_type_str[32];
> +       pid_t pid;
> +
> +       if (argc > 1 && strcmp(argv[1], "verify") == 0) {
> +               unsigned long type = strtoul(argv[2], NULL, 16);
> +               unsigned long expected = strtoul(argv[3], NULL, 16);
> +               unsigned long hwcap = getauxval(type);
> +
> +               if (hwcap != expected) {
> +                       ksft_print_msg("HWCAP mismatch: type %lx, expected %lx, got %lx\n",
> +                                       type, expected, hwcap);
> +                       return 1;
> +               }
> +               ksft_print_msg("HWCAP matched: %lx\n", hwcap);
> +               return 0;
> +       }
> +
> +       ksft_print_header();
> +       ksft_set_plan(1);
> +
> +       size = prctl(PR_GET_AUXV, auxv, sizeof(auxv), 0, 0);
> +       if (size == -1)
> +               ksft_exit_fail_perror("prctl(PR_GET_AUXV)");
> +
> +       count = size / sizeof(unsigned long);
> +
> +       /* Find the "latest" feature and try to mask it out. */
> +       for (int i = 0; i < count - 1; i += 2) {
> +               hwcap = auxv[i + 1];
> +               if (hwcap == 0)
> +                       continue;
> +               switch (auxv[i]) {
> +               case AT_HWCAP4:
> +               case AT_HWCAP3:
> +               case AT_HWCAP2:
> +               case AT_HWCAP:
> +                       hwcap_type = auxv[i];
> +                       hwcap_feature = find_msb(hwcap);
> +                       hwcap_idx = i + 1;
> +                       break;
> +               default:
> +                       continue;
> +               }
> +       }
> +       if (hwcap_type == 0)
> +               ksft_exit_skip("No features found, skipping test\n");
> +       hwcap = auxv[hwcap_idx];
> +       new_hwcap = hwcap ^ (1UL << hwcap_feature);
> +       auxv[hwcap_idx] = new_hwcap;
> +
> +       if (prctl(PR_SET_MM, PR_SET_MM_AUXV, auxv, size, 0) < 0) {
> +               if (errno == EPERM)
> +                       ksft_exit_skip("prctl(PR_SET_MM_AUXV) requires CAP_SYS_RESOURCE\n");
> +               ksft_exit_fail_perror("prctl(PR_SET_MM_AUXV)");
> +       }
> +
> +       pid = fork();
> +       if (pid < 0)
> +               ksft_exit_fail_perror("fork");
> +       if (pid == 0) {
> +               char *new_argv[] = { argv[0], "verify", hwcap_type_str, hwcap_str, NULL };
> +
> +               snprintf(hwcap_str, sizeof(hwcap_str), "%lx", new_hwcap);
> +               snprintf(hwcap_type_str, sizeof(hwcap_type_str), "%x", hwcap_type);
> +
> +               execv(argv[0], new_argv);
> +               perror("execv");
> +               exit(1);
> +       }
> +
> +       if (waitpid(pid, &status, 0) == -1)
> +               ksft_exit_fail_perror("waitpid");
> +       if (status != 0)
> +               ksft_exit_fail_msg("HWCAP inheritance failed (status %d)\n", status);
> +
> +       ksft_test_result_pass("HWCAP inheritance succeeded\n");
> +       ksft_exit_pass();
> +       return 0;
> +}
> --
> 2.53.0.239.g8d8fc8a987-goog
>

