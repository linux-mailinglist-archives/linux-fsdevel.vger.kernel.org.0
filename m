Return-Path: <linux-fsdevel+bounces-76705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOZSDuvaiWlFCgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 14:02:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1AE10F552
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 14:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EA69303FFD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C8820C029;
	Mon,  9 Feb 2026 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADqao1DO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099EB33120D
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642020; cv=pass; b=bGIjWE1nNJefs2TNbjQGcXaFtYJ4Ec2omO8dFl0haJXpZNKixVKuAhUI0JA4YMlkrvNCAYS6P7n1oVoxBEqk2ulieQBZK0jHhbwGFNMSEIdOUBGnlrOpCPEEsmQEw/bRb+/wT3Sbvc6uP1MFd2spKw46yF5zWFCYKN+o7SRcmSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642020; c=relaxed/simple;
	bh=sQZ61J8kyTcO7Pvl9RxElT6zq26ZZeTJV1I2FVx8Ols=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNIvTfkmFDip+Rh/y3tCKdG92Di126QH6L5RiT3h+HKNCAxA2rCTaiCMwaJwH73pr9P6NRpicEAOUnWzK/GrneQVgPnxw9KWHnznaVOozL3QdlPmp/O9R8gswapvFu93WFiISKNiagW6Y9+0XZH9MqBBo/psoO9IH9+ssWTgbII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADqao1DO; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65941c07e8dso4434420a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 05:00:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770642018; cv=none;
        d=google.com; s=arc-20240605;
        b=bSRvgJCTVge8YaXVSoOD4uAI8qK7JGDSl8SvulHPOGWmv+PaHpmj7d78udbob9tPYl
         8L9BmAVvv/P2Civhaur5XoAx1SwKn2/cGTEzYpYVuikvY/Mx+mzUo3vpw6BotyqR1UTc
         DZzaeYbs19VmdYfEId7vqTFmA5JvKjomJC6wjMuey/NmOTnyPnv+aOYj/CWWEhaXjdlM
         xdLPDx0lZIghGJfQEp82s9HFU5GPnhkBv032mYX/sKVLEEajzzdzbGG85muq0ssgn2uc
         oGlXEswE7O11H94O9dBWrG/WArvMvsGiiW/9ST4UnxskTIKPCSgNKArvonWOJcWNTd5X
         uDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hMoZ6wY07SqYnHy0ueNWtNj0fVRmA7qbraA0+zshIW8=;
        fh=aOAK9NPt4cjL+Fy2/JZVlo+Nsu3gyetCpMQxCncEQjk=;
        b=Ns7yTYpKP5UprpG1YcPrPXMZWEnU3VWPRlbVLZlqoOoOXXGLdNgqlpKqsNDRwkpont
         gSz5ZVVz4cs4oYfvFjJUznMjtD0ynibs87/YQG8A5pvGjl5BzSzjnsB96tiaoVjSrLyw
         DZEeQh3yHKd4o6zJrC/C7DkWPFY7JD6iHXe5HiC+ahh+368ckee3/j7aCpAYD8edu0ec
         Zi4gelL+/eyomoTFYf1bEcgMWEtwf0C/u6uEXxGA4UNKk+Rtz6ofBNQvrN24hsqHnUAk
         AZP+QnQPGkByAy27wHvKoWtqjg0rwB278OZk0hNy+F1JdoNA0VBsJfgpJPRSdYXrKBZg
         /l7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770642018; x=1771246818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMoZ6wY07SqYnHy0ueNWtNj0fVRmA7qbraA0+zshIW8=;
        b=ADqao1DOwUHVqhDUeGqnQRxUGH/JfXhGISCrOFgh2ZuYA+U3HHAMbBoxrk+BnEZtSK
         JNZGvlnTBUF+zI1uR/RiX05E7ZzqfmH1s4jMDcQSFEhG1qXoyI1lvy9MspM8O73SNAcT
         yLP2O6qOta16tA6aEqaMlPrSEDSf29iEsfhaNbPbYK8IdUisDcemZMhEVd8PXLPeN9tx
         ZHdIcQ+Rmliem/0BbHdmrDsm3OEegLFpVWv7vOdddf3pz6vh7xCQRBNC9Yn4yQMtU8/g
         svlsxUZUKwXRzXKy5BFRGQRVbsDNI5Z0K89v1MpQGDlrqLUqzNCxwjtlOYaQV8H3HEWL
         jD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770642018; x=1771246818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hMoZ6wY07SqYnHy0ueNWtNj0fVRmA7qbraA0+zshIW8=;
        b=kekLE2jNFesKMXrgyZEfdVmfDJjPDpdS6/ObxQcVJ22gftlP3RM89nbYfVrj4hf+fn
         KRT3uSFK+WgmENBNYbEPR4I7Q6MCkpZRpiLb1lEf8ffEDuh5lfgV7WdRLbvQcKkk4wB8
         1iw7AbfEQ7ZfUudaEs1xlwMxu0QLWRzqRNxIO7+NAvlMdGp5o1u0HfB0sDLfvBHMQrHS
         PwVr6THGulu3zgT4SzkNtdW/avaMLIV1eFnpHJerbMV2ZSY+V38NZynTYGQGIms3eu1E
         YHrKXecmXDHZSu0Q5YnPske5fZvH7GUXyxH8Y6GpBrDMO+iYRoMwrv8XmWo7kb1KttJr
         Lwsg==
X-Forwarded-Encrypted: i=1; AJvYcCUiWIf9KH2g535R2x3wJ0dzhWMDdHcDC+w4rCT87266rYiS35LNtWCWb+R/7y6UtrXnc1CumfsDDzw67VPZ@vger.kernel.org
X-Gm-Message-State: AOJu0YynAdlKBjKIOuRgP5Z6K/TbjUYwJYr+tQe13NPg/kVtS6MsStiH
	zjCsIWnymP8WpQx5oA5Qe061x9YKngRXd/f30h3I6BjpS+43yaLVmv7ZaQifkhS9JWVjfC4s5dL
	XJxFobkYqu+YuZXlUfETJbAqTIAYDQ90=
X-Gm-Gg: AZuq6aLI5mN18MMtbpQb3n4JEjvoKXlb3PAUEtbtW4uAvNaYwuRBtN0nMaV81uRclBR
	jxWm6MfBQwZhAtJA8L+7ueQMJ+4AXvXrdwf1MHk7rQ21/eeN0ZA1asujCaQDC0C7fz/4paFRFj6
	T4gSYxJrU+B233aWziX82bTcXViIGJ+7J/mhJGKwdJ383bVC46Y6d21F/tcgVhIsPCuSSnflnLA
	NptIUUcLp3i8ZYjhZV/QREhI2RTF/h/oMqkMww5pYc41QTHmBwMZayhRgzCDOgwHaIRBxm+g+Cs
	9vsASFbh8w+vipOPBDI+ryToR3oD
X-Received: by 2002:a05:6402:1ed5:b0:64b:73d5:e2b4 with SMTP id
 4fb4d7f45d1cf-6598413b2b8mr5679265a12.5.1770642017891; Mon, 09 Feb 2026
 05:00:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegu0PrfCemFdimcvDfw6BZ2R5=kaZ=Zrt6U5T37W=mfEAw@mail.gmail.com>
 <z24xrtha2ha4ppxomzcqzdkevgtpoiazwb2aehfocyfqwnhkoe@clrijunqda67>
 <CAJfpegvjEzu_mgDaKgNQcnpES8vNu0d+UniS65UFQMsKcaH55w@mail.gmail.com> <jejqzlpcrvn256yfultni2twn5nzehvbelw7ukairf5ntdqcs2@j44pqhuze6rq>
In-Reply-To: <jejqzlpcrvn256yfultni2twn5nzehvbelw7ukairf5ntdqcs2@j44pqhuze6rq>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 9 Feb 2026 14:00:06 +0100
X-Gm-Features: AZwV_QibEBUpjI2OQfkEnrsDVHQyVca9YGwv7pmjuQ4qELt1P1AGMN6OPVMLFKA
Message-ID: <CAOQ4uxgGKKN59P5w4-yLrDX-abWT4qjt7yP9=oUp8op7nJ6wPg@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] xattr caching
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Linux NFS list <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76705-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA1AE10F552
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 1:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 09-02-26 13:26:54, Miklos Szeredi wrote:
> > On Mon, 9 Feb 2026 at 12:28, Jan Kara <jack@suse.cz> wrote:
> >
> > > As you write below, accessing xattrs is relatively rare.
> >
> > I was referring to large xattrs.   Small (<1k) sized xattrs are quite
> > common I think.
> >
> > > Also frequently
> > > accessed information stored in xattrs (such as ACLs) are generally ca=
ched
> > > in the layer handling them.
> >
> > Yes, that's true of most system.* xattrs.  But user (and trusted)
> > xattrs are generally not cached.
>
> Right.
>
> > > Finally, e.g. ext4 ends up caching xattrs in
> > > the buffer cache / page cache as any other metadata. So I guess the
> > > practical gains from such layer won't be generally big?
> >
> > For network fs and userspace fs caching would be a clear win.,
> >
> > For local fs I guess it depends on a number of factors.  I'll do an
> > xattr benchmark.
>
> I agree and frankly I have no doubts you can speed up xattr fetching with
> targetted caching layer even for local fs. Just I don't see a realistic
> workload where the gain would matter... But maybe I just lack imagination
> :).
>

We have production workloads of Samba server which gets user.DOSATTRIB
for every file during readdir (for the Archive/Hidden bits and Creation tim=
e).
The numbers are quite bad.
ksmbd has the same workload of course.

On XFS there is buffer cache that helps xattr read, but it's quite costly
to keep a 4K page just for a 32 bytes xattr blob, so with a large number of
files on a file server, those caches are often not kept for too long.

If there would be a generic xattr cache layer, it would have been very usef=
ul
for this workload.

But IMO the knowledge of which xattr are cost effective to cache is applica=
tion
knowledge, so I think that caching a user or trusted xattr on local fs woul=
d
require some sort of application opt-in, e.g.:
getxattrat(...,AT_GETXATTR_CACHE..) and a vfs flag for ksmbd.

Thanks,
Amir.

