Return-Path: <linux-fsdevel+bounces-79800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BupBmztrmkWKQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:55:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9DE23C30C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 399E93056DD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FDB3DA7D5;
	Mon,  9 Mar 2026 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjLEaYsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612003DA5B5
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070703; cv=pass; b=Wo1dqryAQwBcQquNnOPTKjAPPW3VcfVM7ygtXZmz2iUGFq7RZ2Puqqyj0BzncwIwJbNxnHsB7XnI+VG9cgdVb6oF2fDkBfF1pstKhL5Uw9+5e7RGstWAF+PKR3BpXBUrXF3dYqFFGy0sdI78yEm2Z2GmPaMNS03t0Up92SwRcPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070703; c=relaxed/simple;
	bh=iNHLiCDf49reb7pKbRitTgLTHJvgQkPQChd4fviY9A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJtN8x5Nnu5GCqtni7Ae1dNjade0PU6QzdPKs/O8psc1Cfo5Boa06L88cjKBvte4P7Q9TnUCyQG/sKWcKP/gjzh5rFsABrX56TIBKeIdFutT1le3kIK/AK2AuQpAtBtHdv6k1q9/8Cx9fXDor+0dbcVt376OvQsfuUdCbRfdm5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjLEaYsQ; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-661169cd6d8so13591a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 08:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773070701; cv=none;
        d=google.com; s=arc-20240605;
        b=IL9n/EAwv0P0QHIB/40kU9SxuvySKoVikoPqte2r9y5eTDfaNiU71t6kxUJsvFY1Xt
         p/ZhV0jjqmQo33FxmcS6o1eFJ4Znr4+T7ACEymIN0YcDSNTHpdy6Z1tgrFwDLR4wjTpt
         yuwWU2rwFU+q5K17QA5Brru6fFbEHG6wHGg2MSRcsQO9iQYNeoMu9z7mwcgMlmKElsus
         /UM5VRD0ZY8x8NLPfgmdtPzq6whq4fP+om1UoC382cmtQwzGiSZSgVRE4YcQ53t+pKuM
         5te7JxeNlVvU5yr1KqBqHAxIgSrVV+5Qpyfo3omV518hDIx5ghk6R2H+JhK8WMyj6L90
         nMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uu1JyhWrGMTUefQ+KHAPU+wFh3BG2I8H+RnO/Jnz++8=;
        fh=+/WjqGOODrJjRWEFHLCYnr7yJLLuUBSws8YhyjZh+N8=;
        b=ToQY+wGG8PSoIGZpaNQQjMEs1Wh3WipdQvHB3E1ClzHtXzZy+vxQH9ZXUL7eTnA5dR
         XQvGs3IEFkxC9gT/0CM1FTiXT2ftZiL/jy/DQclTLbwUk6uqokakPrAaR45dsW0EwST+
         ZqGlbG5mMZ1y7lv0tVoxEdfRcNN5hCD+u0DuRs9kx2v4Rr302MUyEY2/br2+9GhGKroz
         4aFzi0TOHOEydFf7tJRnUe+edq5xYH7D1Lxii0fnkf1CBK9Q6p4lAV23pj8UgTKKb3w4
         VnAhJvrdQ+UXcDab4Fmdm08u2MtwZEiwXepO4+sJPlPNEJsw1JjUqKCrnOZXoMW2oaha
         bKCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773070701; x=1773675501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu1JyhWrGMTUefQ+KHAPU+wFh3BG2I8H+RnO/Jnz++8=;
        b=VjLEaYsQUPfnR5xOgC73kM7S1SwbjpADnZ8QOzZcIYphB2L73ZRwZzecty0RaUl20F
         PhJ4eKUr0WhSmVT1T1cfhmcEB5d1qji5Jdrhtzy5u45e15tGTaj31JBEu8gBrQ1SD00X
         ugkLcfnwy+oDw0C8SXB4zgvTiMof3GVJ3oGfhWw3xSk+KFAd8ohPq8gG+ko96R6CgwIA
         2WgvuGcFw8QXu52DGYn0UV5rJKq9u5h+noBYBvmn7I79BmbO30uYZs/EXc+QPvfJQI+2
         yV34/O5xxJbYmPJj6u7LRAqWlt5fBoWo+etsmrJbJ5g8QvV70Ja0Hhn6cu1XybkRG4cm
         MoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070701; x=1773675501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uu1JyhWrGMTUefQ+KHAPU+wFh3BG2I8H+RnO/Jnz++8=;
        b=RZlhNeSJkmhY4oIgqiTTCuI9GPvnDZmjHaCdRjujw+RygqKFsweaY3TegIhGycyw5+
         Nig3kOkmF94fv4S3VLgPFv3J+T6N/lg7xD05FQF/RjwTNs6jpnx7FehbIipkuSxHFov+
         4yfjTUBK/0MpDyLOLgGtsXwMpp2RxDIK64ndGY6P7nAsSJdN9BYIwfBoZD7+gxDsh5NK
         J2WRA4z4hqbuA3RF/waMECbx4Qb9Tn6FVLJWUFVx3+3+I+uL+33xVenIKkpeDE4l2632
         w4bSCcdWbjXmohnT5KNkb4OnsXOt5NIbFvZXru/c5t02lE705ZRrv9a2PFIEiNOv1Bh7
         L6ow==
X-Gm-Message-State: AOJu0YxYKIo1YwYgWD9blXvMb+XfptR/ucJmDfQCZPLm29lYdjHyQuCV
	bkS5XG6njiYnjEe6dxLKslRkoAiMKerslKwfzDq+Qip7VFSpEhhLvPn+DkBLM5d66KBSLVXx3q4
	F8VDYsJL52aU7tko+surPMLeYoeNxJeb4i91qusmF
X-Gm-Gg: ATEYQzwumiSk8UJJ4wOV3wKDvVAezDVWiudXjUI0NyOAdlgUd7Q9TN3OaBsuAExH/xj
	DsaD+4zWhDm11sTMG7pWROFBRmK0O1h997ooSFUkPYMkU6r4ybamQA/2gDWbaTSpLjc/GnqIbZC
	YHM2LkufSq805SFma0jIcjdFA6HEGHSeYJRjlrvjCuTYKXaJV1NcuAKXw7PN76ZAFV7ZVhe1Ezp
	0sTCwoPDie/nojAE3K/tcQCgFa/IYmGebw6Co7BfqWtToAyo7emN/O2ffnEUBCoRtuV4C1OFdLj
	0wHWDRFzqGWNTa6wekV4NEVEnUnJvDCf4FHsmmlVYLM2+QbL
X-Received: by 2002:a05:6402:3506:b0:661:1019:5388 with SMTP id
 4fb4d7f45d1cf-661e7d9e789mr90378a12.10.1773070700341; Mon, 09 Mar 2026
 08:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org> <20260306-work-kthread-nullfs-v2-4-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-4-ad1b4bed7d3e@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Mar 2026 16:37:44 +0100
X-Gm-Features: AaiRm536JZNgrz4IdQWbn2SU23Zp9qTUQkcydIk89QEkamQfmXH-CFmqDZ7PP-k
Message-ID: <CAG48ez060t6NXRt6Hua45aXxAmD0r1vAnm8eEyZSUh95GZG-vg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/23] crypto: ccp: use scoped_with_init_fs() for
 SEV file access
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1B9DE23C30C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79800-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.949];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 12:30=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Replace the manual init_task root retrieval with scoped_with_init_fs()
> to temporarily override current->fs. This allows using the simpler
> filp_open() instead of the init_root() + file_open_root() pattern.
>
> open_file_as_root() =E2=86=90 sev_read_init_ex_file() / sev_write_init_ex=
_file()
> =E2=86=90 sev_platform_init() =E2=86=90 __sev_guest_init() =E2=86=90 KVM =
ioctl =E2=80=94 user process context
>
> Needs init's root because the SEV init_ex file path should resolve
> against the real root, not a KVM user's chroot.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  drivers/crypto/ccp/sev-dev.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 096f993974d1..4320054da0f6 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -260,20 +260,16 @@ static int sev_cmd_buffer_len(int cmd)
>
>  static struct file *open_file_as_root(const char *filename, int flags, u=
mode_t mode)
>  {
> -       struct path root __free(path_put) =3D {};
> -
> -       task_lock(&init_task);
> -       get_fs_root(init_task.fs, &root);
> -       task_unlock(&init_task);
> -
>         CLASS(prepare_creds, cred)();
>         if (!cred)
>                 return ERR_PTR(-ENOMEM);
>
>         cred->fsuid =3D GLOBAL_ROOT_UID;
>
> -       scoped_with_creds(cred)
> -               return file_open_root(&root, filename, flags, mode);
> +       scoped_with_init_fs() {
> +               scoped_with_creds(cred)
> +                       return filp_open(filename, flags, mode);
> +       }

This patch, along with the others that start using
scoped_with_init_fs, should probably go closer to the end of the
series? As-is, if someone bisects to just after this patch, SEV will
be in a broken state where it wrongly looks up a file from the process
root.

