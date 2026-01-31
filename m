Return-Path: <linux-fsdevel+bounces-75991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIhzC/XXfWkpUAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 11:22:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6033C18E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 11:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD2F8300F151
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 10:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A2433FE12;
	Sat, 31 Jan 2026 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGfIBMRn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60529DB65
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769854953; cv=pass; b=CQYJ3rvMu/bXn7ZcPzLyaWw8HzIrc5xE5pOsWCvA9Nnpjltubh+dPBjNpL7gfCCHk/LFt8sFv4m43UhzZzK07a10LDFGUEfqbiJHY4n2p3CbFbydk7fQtl5qOnJD6sik/fTldndJUneu1KtbC/bAVJaTmugX00OGTN+AskvqLnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769854953; c=relaxed/simple;
	bh=YPQiVbTLDX2QySl8NWtf+H/tt2k8PPdv1MYIXxNFllE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOyKnTFt5QNed8VXQw3yTkfivn+At/w8Cz2OCGxUV05JsZpF9u8ReOTLsBw9vodLqqkM+hUTHyC4VsmZ+NQG9j1bh/KubFfvZ1LPvKRrmEJnxEhEQ+gxuq9x+DyEzzxKZyQe0aLdA5mn4dA61JG0K9I/mprg2BkidboyiiRdz24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGfIBMRn; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-658cb3ee91aso5005258a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 02:22:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769854950; cv=none;
        d=google.com; s=arc-20240605;
        b=gCax+8Cr+lv7/ooYxNbjwDAt3nVQaVhZBemUA2xXJZmbRHOQUa3WCsvFw1T6Ec1yZt
         bKgIjnrLV/o0v3Icy0PzZPQoL5ffST+Nz4TuAuMAJjkgAGnQmywxqf7RQp9dZ0z9xaU/
         X/AHWWrIApjgLwV3FVuWcjYRLqKpYpD8md2x4LSnr+/Q1av0ul0beWUxPO7u3ALij15J
         JaWMHCd7XuVE44CmTxXZcHgr4q1xHlnXN/D9ZIuN0xiQfIu0k89faBHlK1G7ytRgvaMP
         pk8S/SRia13ITcg8uTJGRUV4QgKbkcKHBfsAXMWNH+jyGyosEHZX+UkpYtjjjiHd7Xa3
         2K8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YPQiVbTLDX2QySl8NWtf+H/tt2k8PPdv1MYIXxNFllE=;
        fh=i1S/iBPBj80YY5afumZiIIUSCoOCQN3XwOEdEwN3QO4=;
        b=eTXt6wkyIgcRYxLQtVdkSmeDyCJnYJZ0MU6Y94g8tBQXbRMt5Gp/fySPtMxZpwDdEz
         E2HZf5DXf5u8LsyS4n+3Eu2GUtLIBLxqSS9GzTPbU6ao43gQr12B0iayp+RI2gn0otD/
         QH/cVVYj1RjlfHX6pp6F7JIupdBpbVqhb3l8yID5phQ9o/L5Go7/twalJoxJl4n+4n50
         qSGGNUxiKTIwQztjl6nOPm1GH8BJFqgnehqelt3XAwRniU7o9pRU91s7aNU1pjjac67H
         3YQEADv4rk+pIXU4lF1z3uppxcqSmIcIzgI8GLpwRboPt24fo9aAaBgXZbs78ININunl
         hxvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769854950; x=1770459750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPQiVbTLDX2QySl8NWtf+H/tt2k8PPdv1MYIXxNFllE=;
        b=iGfIBMRnH7Gv9C7JGDzZjOlHDgMv60hNIFmw0+QIXRVzM7SKUTps1f560iBkOWzFat
         H5w+wl7KDxwD0tG322MUxCsclAiTZP2uA8lIi3quR9Zi/En7F8/MMhFaG8HQWXSbpVJn
         wa6P2GwmCAtUmwH0W6D0u0Kj8Tert+BP1Plv55xmvT6b5/9hvyVRoSzSRjE+HqInNn7u
         Eg+9zFCNKM08fKBnV56xXR6rqqy0ijG5M/Z2FeIS358PE5AP3c3xE0JwwJMVCGYcBYel
         Jxs4oDIFzxfHplRXxSUAyJm7/II/SrX0xEum3A5D4NWoD+iXcyVU+Ex5OUEAAOrF5hZy
         dLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769854950; x=1770459750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YPQiVbTLDX2QySl8NWtf+H/tt2k8PPdv1MYIXxNFllE=;
        b=HPAwFN2K5mI9gXCd9CtVZLBerdd0v3OungvE8b0SRPtEV/QnPTkVLwDuJfsTAAA01s
         +66t3xtbrvx0pGn4e+mMhcCFW+2SwyRCS7dcwhYEnKSPmxmzFq4GlK8Kdo1GsOpo/q/0
         BbzoqohHCtkvU0l0WLxVZTLpf9UY/5ACHTmh9LN6F+4+bzc04FJxOQ5JHLekYyJIGSGb
         X9ripChvfVZ71/komprOndYS8byPVc14uG1ZJ5s0MxjzRGZzSLY6x+mm7106+4FzwwfA
         6g/QISDlEVWRqX0mQxC/PIRattnz0FtMQHP1pntV5AICDi/eIy3WK9mgc8vjCtd3CR2e
         eT2g==
X-Forwarded-Encrypted: i=1; AJvYcCXPAUWc51bjYARoezPtb+iuVN9ofT+p7xrfDbIMm1Do3X2LNYmXPMNl+8R1CTrvZ61RAFBeeiXs2mieo9u2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4raRfVG/PV0pkO67Z4WHEy6/tDOGh7wEJdaGAO730TyKyOtp
	rKS7c4TAmqKi6b+aA/DA/vX4EE3m9WNT6gO8MigP4LITp9UsjV2nN6gMw8Vf2Y3AHcVKybPNGRZ
	m1ge0sTlg/qHPluVzQPIMPNMRTNWFP1k=
X-Gm-Gg: AZuq6aIj7qQf/t+5y+5hQn6mkx/u2ttNyjG52f07/VzI+Rl3+4cf/Fqv6kjHP2i8GFj
	xhFoZIkBmLCxuV6fFoitleexcKrHqw+8LPlrwVZk3fpKuX3C1Cz6w/ODl1myNNIpDoskDADuLwO
	j0L7VYi62HkKpLw7W8jsrDwVMfLvTsvMK6ueJtv2zqydawHwKkXz54V+o4yvycba7/57vtjLrgW
	XApdz8b3E07mNdwqY36w1ww5hPVdzT0b/FoRsPBrNTyYvtpXJX7SG5+K1DXVhk7TPiKRoZpkjLG
	j9oQfYvwWgma0lDqDaa0VuFjzkpw
X-Received: by 2002:a05:6402:3483:b0:64b:8d7a:71cf with SMTP id
 4fb4d7f45d1cf-658de5a0ce3mr3157686a12.26.1769854949593; Sat, 31 Jan 2026
 02:22:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130001418.18414-1-wufan@kernel.org> <CAOQ4uxhf6EQKcoN055xzmi-RW2GPxRzz_ExsQawGQBSmoX2WYg@mail.gmail.com>
 <CAKtyLkG1_evj7=yrB6nH-8fJuP3DsWyxwrhv7O_Mk=Fy8FOvVw@mail.gmail.com>
In-Reply-To: <CAKtyLkG1_evj7=yrB6nH-8fJuP3DsWyxwrhv7O_Mk=Fy8FOvVw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 31 Jan 2026 11:22:18 +0100
X-Gm-Features: AZwV_QhOhPDOYt2J1lFISrx3c1dHs0q3o3EvwGFAflm_-U4v5NyUzpUKw-giy8A
Message-ID: <CAOQ4uxjndETYhGayZH_opeMxH1zadW5G0DUHfdiGt=i+pM26ow@mail.gmail.com>
Subject: Re: [PATCH] ipe: document AT_EXECVE_CHECK TOCTOU issue on OverlayFS
To: Fan Wu <wufan@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, mic@digikod.net, 
	miklos@szeredi.hu, linux-unionfs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-75991-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D6033C18E0
X-Rspamd-Action: no action

[+CC fsdevel]

On Fri, Jan 30, 2026 at 8:21=E2=80=AFPM Fan Wu <wufan@kernel.org> wrote:
>
> On Fri, Jan 30, 2026 at 3:06=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Fri, Jan 30, 2026 at 1:14=E2=80=AFAM <wufan@kernel.org> wrote:
> > >
> > > From: Fan Wu <wufan@kernel.org>
> > >
> > > Document a known TOCTOU (time-of-check to time-of-use) issue when usi=
ng
> > > AT_EXECVE_CHECK with read() on OverlayFS.
> >
> > Hi Fan Wu,
> >
> > TBH, I don't like the way that this problem is being framed.
> > IIUC, the problem is using IPE on a non-read-only fs.
> > Is that correct?
> >
> > That fact that IPE metadata is usually coupled with read-only fs
> > is interesting for the understanding of the use case, but unless
> > IPE feature mandates read-only fs, this is a generic problem.
> >
> > OverlayFS is just one private case, which happens to be common
> > in Android or containers? IDK, you did not mention this.
> >
> > Please describe the problem as a generic problem and give
> > overlayfs as an example, preferable with references to the
> > real world use cases.
> >
> > If I misunderstood, please explain why this problem is exclusive
> > to overlayfs.
> >
> > Thanks,
> > Amir.
> >
>
> Hi Amir,
>
> Thanks for the review. That's exactly why we CC'd you and the
> overlayfs folks, we wanted to get your perspective before documenting
> this.
>
> Let me give some background. IPE enforces execution policy based on
> file integrity properties, primarily dm-verity and fs-verity. These
> are the trust anchors, and files without these protections won't be
> trusted by IPE. Since dm-verity and fs-verity are inherently
> read-only, in typical deployments the TOCTOU issue doesn't exist. To
> support overlayfs, IPE uses d_real_inode() to look through the overlay
> and get the real inode from the lower layer.
>
> Recently a new feature AT_EXECVE_CHECK was introduced to allow script
> interpreters to request LSM checks on script files before execution.
> The idea is: interpreter opens the script, calls execveat() with
> AT_EXECVE_CHECK to verify the file passes security policy, then reads
> and executes the content.
>
> What we found is that on overlayfs with a dm-verity lower layer and
> writable upper layer, when a script file only exists in the lower
> layer, AT_EXECVE_CHECK passes because IPE sees it's dm-verity
> protected. But if another process writes to the same path after
> execveat() returns, copy-up happens and subsequent read() from the
> original fd returns content from the upper layer. We verified this
> through testing.

I don't understand how this is different from any AT_EXECVE_CHECK
TOCTOU race on a writable filesystem, regardless of IPE.
It seems to me that it is the user calling AT_EXECVE_CHECK who
is responsible for verifying after reading that file has not changed and if
it has changed, then the AT_EXECVE_CHECK could be invalidated
(depending on policy).

Maybe multi-grain ctime could provide a safe cache invalidating check?
As long as the filesystem is trusted to report true MG ctime.
See below regarding overlayfs...

>
> Overlayfs is popular in container environments, so we want to document
> this for IPE users.
>
> We noticed the overlayfs documentation
> (https://docs.kernel.org/filesystems/overlayfs.html#non-standard-behavior=
)
> states that if a lower layer file is opened and memory mapped,
> subsequent changes are not reflected in the memory mapping. We also
> verified this: mmap keeps the original lower layer content after
> copy-up. One reason we CC'd you is to ask: is relying on mmap to keep
> the original lower file reference a reasonable choice? Or would you
> recommend against depending on this behavior?

I recommend against depending on this behavior.
Please do not document this as a solution.

It sounds like you are documenting a recipe for how to write a safe
interpreter?

The advice to mount overlayfs read only seems impractical to 90%
of the container users which use overlayfs specifically to add writability
over a read only image.

If the generic ctime check is not considered reliable enough for checking
if a file was modified and copied up, what about checking the
STATX_ATTR_VERITY flag of the file?

ovl_getattr() reports the STATX_ flags from the "upper most" inode
and then merges some specific fields from lower layers.

I think that would mean that in the use case to describe, a copy up
would result in STATX_ATTR_VERITY going away when doing
fstat() after a copy up.

If this works, better document it as a good solution.

>
> The narrative in the patch can definitely be adjusted. Would something
> like this work better:
>
> "When using AT_EXECVE_CHECK on overlayfs, if the lower layer is
> integrity-protected but the upper layer is writable, a copy-up between
> the check and read() may cause the interpreter to read unverified
> content."

Sounds fine to me, as long as it is clear that overlayfs is just
a private case of the AT_EXECVE_CHECK TOCOU race.

Thanks,
Amir.

