Return-Path: <linux-fsdevel+bounces-75961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /iljLZEQfWmUQAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 21:12:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16380BE50D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 21:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD9AF301AA4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 20:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BFE3195EC;
	Fri, 30 Jan 2026 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyE31yWN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DFA2DF3CC
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769803906; cv=pass; b=Wi65bFJjK4Y3C6MXYQi0VtAmwOnxGPvJgAo5E/PMBHsksiFzvFA5t5oExi0fOJYwK5wd9ssQD7FIA8Ut435pIMVa80UR7041eIYooyIiMQXCYFtC8L0moyvBg9pYEqL8RtoCxRyES9YFsMOMXi6tBAwwhIs7oJPyHbudwQuoLMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769803906; c=relaxed/simple;
	bh=rQg2XAmvCjv6Pxt+pWb6hjO1zF2ufQcWZb17Q9FMzPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaRwt4Y1tx0JoFLxTjKqnq3HkskCk4HhlZhEdrhxDQ9iOtXcTd5vN2IUvRd+RgtY9HruRkY8FsemY7B/O+F8+nSRwVMc38ru5iVIF9Jaqsml7dqVLqhuqgG8Auw07JcK21Q+rMI3rZfjgl4+fkJ3JN1aS8tWHAn0/YPIQxJJor0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyE31yWN; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c635559e1c3so1044959a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 12:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769803904; cv=none;
        d=google.com; s=arc-20240605;
        b=J1MCSZ0QvK4pNp3nU9vRUSNEH1ACJyhVVRzRWtWJehxFlBSpejn9TZYhSsarMk6HXj
         Hq8oK3xO8IWCLhoyUKS8qXE6snzSWd/CnAoFoKi3ff78upb9qNY4BWIglryihqNNA5JH
         TFh5t1qK1VBQ43sNR7R6wFWGqGK01LYFre7jVu0sNZM2o5a2gWWxAy9eicKERiDcnzWK
         wF9j7U5ZqNZomO6TYhIY9bnNoVQ/RmGG2DluVM1LmE6Lehg/LzlcmzmaAJOU/h6KOqWu
         3QWZ3sgz1Ca41UNTVWgKbvpj4ytikqNQcGqXKmLkuiKatipSNkfm3Ng4kxcGRP0JYgj8
         5qQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KqTERH/+2h6DWpnL/jhYC24xZ6zypIXUC8x2yGcNW24=;
        fh=E9rBYURn3cvxSLLDeFxx1teF6/shY+ovDrVPhBE0hxY=;
        b=izxtPHF3GJBluCYZF+ezIdpxP2jJYqM6lYecUsCz/IdTUqjDk+is7MAipfh+RlsDjN
         hUgFYSfqSBpgDUIUGXI7+cFD5Jyk90OpE3Zox5Mp4fpovDjx5pGkv72rmo+1VcOx7f3S
         9KM1X93mug7PAA2/uOwvL4TQjRk7qjgZlgQqtTZtjyUxjMcgn+lRhn9dmglk9sBFVMRO
         tsZEiYZVbIk+bjm1Ce9LPQiF5n88h9Evkt/vqQ86/y1kgG1/AQzWxS19Tf3f7Uv7klcB
         YuDyFkUwXpTV5nJ1vqJfy3zpWbhHZY6LEjQQ0ffuFrII6eusBDLO9i1UnSZ5QzshJq36
         q23w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769803904; x=1770408704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqTERH/+2h6DWpnL/jhYC24xZ6zypIXUC8x2yGcNW24=;
        b=ZyE31yWNSqzEjtKHvg3//CTFyIXR+qPm2f22n6bCJas3JQ8lwMlI8z7DUDGlv51Q7a
         Il4eLZpdm2j6G2DEGsngfTjuOJnUP//5HDi5ibQKxul/deEwowBgJvE240m9MgnsQr5N
         0cG+MnocgRWkgHUfnArhtditIY6yh0f1hn/iIMCpMBh66VN6tgSgOls46pzR8bEVtOpW
         Ablj1bVl7jLnsXT5A9L1TxkwwJcn7xxkDZdaIE0h72UpVDlVCPV1vHNkGNOx3XkU7o60
         TBFuXZbqowEdU7OEAH7GA37OQVl/ntSG+FI55vaSbbUJv9AHAHjYK+BHHpucmcbavb/O
         CN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769803904; x=1770408704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KqTERH/+2h6DWpnL/jhYC24xZ6zypIXUC8x2yGcNW24=;
        b=rwDO7MIb0zA2+kzROHrvWFCp3iH9RpNEZsbKmXSXKG6SrsUVBrADRPQI+1mY5T5BsS
         aPl+ztnJSEwK8u1xGJWmmQ8c1Hd1bA7ohpzZLKTOtm8a4TDfBDXI5UCs3V+mb+6il6JA
         lEq47fQhcjSo+oK8BZOppZsKvSjBHEMqQCM5wyxqstdbtmD48CmkSG++WGACxJ6/MpQ6
         d2JH/URlNQUpIbp5vtx/kkUINl1lGQS5mHTutApX/LBY9MEg7IDptDfYMaXrk9cBh1Mc
         FGNqh8ljQwSpS0kuyPXfvKU3hg3utHBk/3gmr69G9F9a9yLBrCToOWdkpQbkUMXqiXd7
         fdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX063T+VreHIt1ooY40QKYpbxDoGjB6w0W+BWCmXyFHQWC3BzOWUlp/vKkTttYcu+HleJQrMpS0tqUl1l81@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6UfKIWsE9NozODdkkjpd2c89TRE+KScNDD7IgzO6gIv+SvYy7
	E+kGEO1FxfWX2cFb8Evoc67oRrEIux21fRQwj/eHawR7JVmMIX4lwt7iLYPTgWyOo6XadkqGxhx
	HM7LyFn7LuGvOmg7Y2YgR2JtjstM1jIM=
X-Gm-Gg: AZuq6aLD3ofpF+077/mLl0wb8uGuoov3NiEnrY7WiJXzaac/BpAqA+gvw3PtdOyJeKl
	qP1WYJYPOk1KOPUqv/mqnUXKe5EYNbxEBOSZJgfif0rFmTE2aSolv5px0AUumAntXobEdzLPCD3
	I3d/aMsCZ/vuz4nJJfml7XPIEQ2aotv9uMxlWbo0wzDVsUwJB8aKiLeLCAniFDFgzDBaea8zzUB
	kNF1QdA+8iKiGAwORG5faOGW5KJie8Wq5iZ5adUJEvDrDyNb+sG2uK+cEOrWQVAzkaKgHfyi1vz
	aWdLgkHgehs=
X-Received: by 2002:a17:90a:d2c6:b0:34a:a16d:77c3 with SMTP id
 98e67ed59e1d1-3543c3a6c21mr3874104a91.2.1769803904268; Fri, 30 Jan 2026
 12:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129215340.3742283-1-andrii@kernel.org> <202601301121.zr5U6ixA-lkp@intel.com>
In-Reply-To: <202601301121.zr5U6ixA-lkp@intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jan 2026 12:11:31 -0800
X-Gm-Features: AZwV_Qj7wDya2OBtNs7PUmH8JcxUTODcuVx2e0LmJSjVryNSnlC4sk5utSn3GV0
Message-ID: <CAEf4BzZthAONGByqvk3pHRT3GaA8=fNbz+d1V1CY1N8sHEcsjA@mail.gmail.com>
Subject: Re: [PATCH v2 mm-stable] procfs: avoid fetching build ID while
 holding VMA lock
To: akpm@linux-foundation.org
Cc: kernel test robot <lkp@intel.com>, Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org, 
	oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, surenb@google.com, shakeel.butt@linux.dev, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75961-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,01.org:url,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: 16380BE50D
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 7:55=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Andrii,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/net]
> [also build test WARNING on bpf-next/master bpf/master linus/master v6.19=
-rc7]
> [cannot apply to akpm-mm/mm-everything next-20260129]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/pr=
ocfs-avoid-fetching-build-ID-while-holding-VMA-lock/20260130-055639
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
net
> patch link:    https://lore.kernel.org/r/20260129215340.3742283-1-andrii%=
40kernel.org
> patch subject: [PATCH v2 mm-stable] procfs: avoid fetching build ID while=
 holding VMA lock
> config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/202601=
30/202601301121.zr5U6ixA-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 11.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260130/202601301121.zr5U6ixA-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601301121.zr5U6ixA-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> Warning: lib/buildid.c:348 This comment starts with '/**', but isn't a=
 kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>     * Parse build ID of ELF file

So AI tells me to be a proper kernel-doc comment this should have been:

* build_id_parse_file() - Parse build ID of ELF file

Andrew, should I send v3 or you can just patch it up in-place? Thanks!


>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

