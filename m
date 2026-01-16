Return-Path: <linux-fsdevel+bounces-74104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E628D2F942
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 979CD3051AD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761243612E6;
	Fri, 16 Jan 2026 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAkknpoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634933469D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768559444; cv=pass; b=ZJpJEG+VqvgHuG0D4uc6lIO9Qbp4QD/u/BG8ces4g0LyP0YMn8/KwFmGAVuG5Z5Czz/4h6c3+7MCBpm/GkUmBJ23kBTwflHkN5/JIzbQ8Ef9SXtESrBiHC+aRDVNOHXbgH9+Icv18WBDXnqU5PItSfAEmmoeS5MXqAWGwP1n6gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768559444; c=relaxed/simple;
	bh=B4B79QmLv6TQD1z381uGCSUIW+aAL6+AKBabzlbdHlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnoBuzSGk0wgIyzet0oWW3JR2HeDGCiBEqgqVOcirn7jbhY03IvRqIUAWgnuNg5vh4LTwmTUB2fBvtWoCIsnL/F6hU2ByDDT5gARLCp4IhcwkeePHYaxHUpoB3QqvJQoweeDdZwQKLaWB+kFH1YIFYxMGHTtYP4du8TmXATSw58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAkknpoI; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8712507269so281254766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 02:30:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768559441; cv=none;
        d=google.com; s=arc-20240605;
        b=WgHzfLe6cSUqEp4HBTWXQjCLv4hU3+bPgb38g0rNMZYtvXTLfoV3iP9UqNuM8/XESc
         qgJPsCZ+dhgXmbHkzihY2S+tStm5KKzc9jFJP0c5APkcwRAH0Y7T/z1uyPEuTPfHPwYN
         nSaV268rdFYTCaCfyEgloXuzBhCKIwaIv1ZqdyFVtpzBV3OXf5rYHh21zbTCO6zbbvQA
         8U3qhIFdkFjH4z93j0f1EMedc3DTtLdOgipmV7i6IVGPMeC2vs5f2BCBlFOGhbSqTg1M
         +OMeNwF9CDKGJ6aHkLvYBHf8XrgcyPM8uv0FPwNrHOarns4Ed48grg/GU6K0i1STH+p2
         bJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cf56CR+AIA+Ye3zO1l7mJcltomNJyiS/tY/yuhiDWzY=;
        fh=PLBHBQZGsSc4foseHhEdK8DN4EPgVY1CY1yRu4VTLec=;
        b=jrAtfCPL1EV8BrGQkiKFyiyg4LgJ/U84vyj7vVPCZqc69LL0IMf/P0A9o+ZrKtGj5v
         2X6XcBdeghLdIDFinZHjHULuPPrIQwjD8XdlyRXCUlZQdMxvW1nGAQjzEEgg0D8dSwjB
         ak6/7PoUHUEZqI7PCydIu0O8/GfUd8j4YkW5Tg+MJlSIhwH8EDljcfh4s6zC2bu2uYvv
         VJ2Tz18W6NtTdfgzKmP5a3M7qOaKCeAWWZhlsLXbl2JgQ4sQ6VYz9NmaN9HKEB/SrcW6
         hohooBOiI+cPeVoZ1lZavCNpPdBsApqCf+4DoSdMuwkw6gsIUUEQoPzvHRXYgDn4jOfi
         Fj5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768559441; x=1769164241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cf56CR+AIA+Ye3zO1l7mJcltomNJyiS/tY/yuhiDWzY=;
        b=JAkknpoIT4cmGniuo4Vo0GEIE14zEq70eqnl3EmyWSfzHHRFHw3fvndoMtjxEHg45M
         j7G/K5fAujz9pCfuYRMs6n3zCYt9n8InszZ8IanOrDV1h8voM+1rPGcTgyv1Wz6ffnjW
         +eI4cEiAmL/jJr6uhzC5sxDamL8qYcLXXyzQJRcbP0CeH77oGjhzmWyApFya45UQVi2j
         ziv2fL1Ogxl8TLc8y/fmwVYtfr/BTuuycn6LYpxA0C221rzv94Pnyg2AMVn1z26aNi06
         6y70P6ImvSD8l2C6keAcYJ6mbXFIyJdRlWwt5R6FJzMA25GN1g/inShMRsjlQpproWUM
         GPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768559441; x=1769164241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cf56CR+AIA+Ye3zO1l7mJcltomNJyiS/tY/yuhiDWzY=;
        b=i4S7EaREJhXaiF7pgBq/jOCUzLbQ9rq0NeYYLWOpFU3UkCv9QCZpRiMf27kzD3O5hR
         WDq6Ig18VB53S/UdTXD+O9nsMkNQPRDeIND4voXXpVKMBnFSlw6phgXSLUrjsTl6eN27
         d6t/jKFyY+gwRLtwy2khUb5bbMb/Dh3CVo3UUUNH81x6cbviqRnD7Lz+GhQjqLHdBUOa
         Ef0y+kKaRojfQbyQVGYajjZQqS/cHEQIVZApoXT0lS0QCb+XWmI8zRonQNsbhDh/hyMY
         PCw3WqMWriLK5SIbjy90pkrM3qp47fsfG+q7yTTUe9AP5ZEkXd3SCSFTEL4Qa55UiF2g
         bWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUBDsGsEoH/ZaToUp8ACIqK4ImMUcRvGXbvIVjRBFfRFNJaJb9sYacSFoDunEWomjwlUfhU/841sl6eFEo@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmExpzkQjiHJlA6p7iZ+o11rXlPg2qNSqKtahAI1Rr1zdi+Qj
	WgONQHGdwQ6E/HprV8Y9R5xWvMbRlO4DMyeSSvYtgsQFLIqOxKD4YUlTI/jZlLxnyVCA2fNL8nz
	g+In9W56iNGdsmN+wdJhQBUqJrO4QYkw=
X-Gm-Gg: AY/fxX5Xv2PSS6s6+aOkIIZA53NJrCky6Giz9Il1uwJ2Gg8k+3Mijx7x+dOBkjQn3Mm
	UY8d8zcpJx4UF6ejauNN8kVU4yQ5ufiYjxE0psctksw5VvR7w3lsU3ENWnXEhWF/uuiu70FfPsK
	p+x5JAkejqlgyubnMdgJh/XNfA/U7zWyQY5si8BQ4/0RQOvraFJZhK82KS+Vgl9YOCRJe0qVj7N
	UCr04DErx3sbL+bH7p45GiB1VcJFfsnvlD7K4FMvg3lAYNU91uEso0zae7iMjg4Hg+42rtvYoBN
	SaVCgjzb/xjOCU52CcmKemS+Mex43Q==
X-Received: by 2002:a17:907:d1d:b0:b87:28f7:d3b6 with SMTP id
 a640c23a62f3a-b8792d67d35mr233178766b.19.1768559440351; Fri, 16 Jan 2026
 02:30:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdxtTZ=SuV2GMPuqQJe6h-h-CDiG5yBW+07f1QYEw+kTA4-2w@mail.gmail.com>
 <CAOQ4uxggQekxqavkt+RiJd9s9cdDgXZuVfQrL_qNciBNf=4Lww@mail.gmail.com> <CAOdxtTaz7=TzQizrdMEhjgt7LpuuHWzTO80783RLcB_GP3nPdw@mail.gmail.com>
In-Reply-To: <CAOdxtTaz7=TzQizrdMEhjgt7LpuuHWzTO80783RLcB_GP3nPdw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Jan 2026 11:30:28 +0100
X-Gm-Features: AZwV_QjcW5Vh904wqXhwxNbUWeWP8Fsaz10YPClirj1lN31yHbn3TZvsoNvN12E
Message-ID: <CAOQ4uxjMSs7c0OQvexFA11r37=VzCHMjpPm+1EFteYWdJGw2Ug@mail.gmail.com>
Subject: Re: [Regression 6.12] NULL pointer dereference in submit_bio_noacct
 via backing_file_read_iter
To: Chenglong Tang <chenglongtang@google.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 3:56=E2=80=AFAM Chenglong Tang <chenglongtang@googl=
e.com> wrote:
>
> Hi Amir,
>
> Thanks for the guidance. Using the specific order of the 8 commits
> (applying the ovl_real_fdget refactors before the fix consumers)
> resolved the boot-time NULL pointer panic. The system now boots
> successfully.
>
> However, we are still hitting the original kernel panic during runtime
> tests (specifically a CloudSQL workload).
>
> Current Commit Chain (Applied to 6.12):
>
> 76d83345a056 (HEAD -> main-R125-cos-6.12) ovl: convert
> ovl_real_fdget() callers to ovl_real_file()
> 740bdf920b15 ovl: convert ovl_real_fdget_path() callers to ovl_real_file_=
path()
> 100b71ecb237 fs/backing_file: fix wrong argument in callback
> b877bca6858d ovl: store upper real file in ovl_file struct
> 595aac630596 ovl: allocate a container struct ovl_file for ovl private co=
ntext
> 218ec543008d ovl: do not open non-data lower file for fsync
> 6def078942e2 ovl: use wrapper ovl_revert_creds()
> fe73aad71936 backing-file: clean up the API
>
> So it means none of these 8 commits were able to fix the problem.

That's actually a good thing, because as I said from the start,
it does not look like storing the upper real file in ovl_file should have
fixed the root cause.

> Let me explain what's going on here:
>
> We are reporting a rare but persistent kernel panic (~0.02% failure
> rate) occurring during container initialization on Linux 6.12.55+
> (x86_64). The 6.6.x is good. The panic is a NULL pointer dereference
> in submit_bio_noacct, triggered specifically when the Integrity
> Measurement Architecture (IMA) calculates a file hash during a runc
> create operation.
>
> We have isolated the crash to a specific container (ncsa) starting up
> during a high-concurrency boot sequence.
>
> Environment
> * Kernel: Linux 6.12.55+ (x86_64) / Container-Optimized OS
> * Workload: Cloud SQL instance initialization (heavy concurrent runc
> operations managed by systemd).
> * Filesystem: Ext4 backed by NVMe.
> * Security: AppArmor enabled, IMA (Integrity Measurement Architecture) ac=
tive.
>
> The Failure Pattern(In every crash instance, the sequence is identical):
> * systemd initiates the startup of the ncsainit container.
> * runc executes the create command:
> `Bash
> `runc --root /var/lib/cloudsql/runc/root create --bundle
> /var/lib/cloudsql/runc/bundles/ncsa ...
>
> Immediately after this command is logged, the kernel panics.
>
> Stacktrace:
> [  186.938290] BUG: kernel NULL pointer dereference, address: 00000000000=
00156
> [  186.952203] #PF: supervisor read access in kernel mode
> [  186.995248] Oops: Oops: 0000 [#1] SMP PTI
> [  187.035946] CPU: 1 UID: 0 PID: 6764 Comm: runc:[2:INIT] Tainted: G
>          O       6.12.55+ #1
> [  187.081681] RIP: 0010:submit_bio_noacct+0x21d/0x470
> [  187.412981] Call Trace:
> [  187.415751]  <TASK>
> [  187.418141]  ext4_mpage_readpages+0x75c/0x790
> [  187.429011]  read_pages+0x9d/0x250
> [  187.450963]  page_cache_ra_unbounded+0xa2/0x1c0
> [  187.466083]  filemap_get_pages+0x231/0x7a0
> [  187.474687]  filemap_read+0xf6/0x440
> [  187.532345]  integrity_kernel_read+0x34/0x60
> [  187.560740]  ima_calc_file_hash+0x1c1/0x9b0
> [  187.608175]  ima_collect_measurement+0x1b6/0x310
> [  187.613102]  process_measurement+0x4ea/0x850
> [  187.617788]  ima_bprm_check+0x5b/0xc0
> [  187.635403]  bprm_execve+0x203/0x560
> [  187.645058]  do_execveat_common+0x2fb/0x360
> [  187.649730]  __x64_sys_execve+0x3e/0x50
>
> Panic Analysis: The stack trace indicates a race condition where
> ima_bprm_check (triggered by executing the container binary) attempts
> to verify the file. This calls ima_calc_file_hash ->
> ext4_mpage_readpages, which submits a bio to the block layer.
>
> The crash occurs in submit_bio_noacct when it attempts to dereference
> a member of the bio structure (likely bio->bi_bdev or the request
> queue), suggesting the underlying device or queue structure is either
> uninitialized or has been torn down while the IMA check was still in
> flight.
>
> Context on Concurrency: This workload involves systemd starting
> multiple sidecar containers (logging, monitoring, coroner, etc.)
> simultaneously. We suspect this high-concurrency startup creates the
> IO/CPU contention required to hit this race window. However, the crash
> consistently happens only on the ncsa container, implying something
> specific about its launch configuration or timing makes it the
> reliable victim.
>

Your followup email said that the same race can happen also without IMA.
I wonder if it could happen without a backing file, but that is hard
to find out.

My first thought is that it could be related to some black magic
with the backing vm_file, but I have nothing smarter to suggest at
this point.

Thanks,
Amir.

