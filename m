Return-Path: <linux-fsdevel+bounces-75796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ7zNE1jemmB5gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 20:28:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F0EA826C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 20:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FCEC303DD4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222D374192;
	Wed, 28 Jan 2026 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap7b+u1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9EE372B53
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769628485; cv=pass; b=CBUMhkGfPnT7oqS5mjUoaJ608SOTY3mGpr8z/UAE867Fz2tWXRYuJ5h0OtTMGWxgyIkSSIbJaWZs5Jre28OqEaioCwOT3F/GVqY2kxLU8AQvLgj/N7PvLmWQyPvnCxva1QR59qKrdvtdKM8hpJrnEYZsVmvY0HHXl5gLKwh/H88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769628485; c=relaxed/simple;
	bh=hJeEAKiKD4yBbMJhZMhUaDnJz5O9vpsTRwVDafXrX6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JF41GbnbDndJzuhsudnpbZSBPgAGB02aMJS9unO62cIVrvZSb/0N8xxYOiO3FEuxzkAV1OVFrz4po+xIdzFIoll139CEStm18vB2EbO8eDiu7eCjqX/6gDH/BcMzaZ5+Qt8dDo2gk9HX8M4tlPGS+XYOP+blzEhHAxFbPR/WjsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap7b+u1I; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-658b5e57584so476407a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 11:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769628483; cv=none;
        d=google.com; s=arc-20240605;
        b=hl0vWw5x1tAa/h9iy8IWweFHutmFEc7c7VJg7XISLsvyWYIJ3bgVLSocvRAy2HPR5r
         KZWQYe4CSUBUrRA4WUF2fRYKMkD+EUPKAUzPqv/YtEEx4FRdGBnbsd6nda4BKn2QT+L/
         3tKHKcaEljGIF4KqbbI5VHfxMQb8V2TfT4Kr3vqAjjy3+B50IMtJsHy9aMB6w2jeIaio
         w5kMtT+H/8JDy5VWsYYigT1+uIELI6W6EmBiC4tgjC6mRQd0Io8yw8U9E/vYvh0J53xo
         KkCaCT4laBZbB2Gmy6zNJXsFZVBfHUTsbHrkCikQy9ut0WBo887fxL5o8kH0rlbiuOAX
         lKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GePnCPMULS4ZH5+nWQOFHXb1cucdY2lNKyMwVx2+ph0=;
        fh=NoRqsc9KL9dHgfb7B0w/XS3Rg/HhGXWtH6HKR8YqXNs=;
        b=c/Vm9dD7B+4uYPfWah5Nnaj6XKuzQzVK27Ju7NldFm6iw6ZxipebQdo3AZQuCu09uB
         OLTFOW0vrpvMEiK1iSu24ujaw+/JjWDCdtyoDtltpsGaofIa5Mrkl1qGQSXYQrcrayKI
         Q/DjvHrqfOvyVOod630tpHUTE0qW7nHk7YvlmSjdpwUEkB2nPQ/Ci9N7PGZguY6MXsBj
         Er2UrTRXF+E0PaoaBXl9mF35cCVpPmh9aoLooSnbX5uSbFtUDON0NpNh3hlFrzGWModS
         3+3rUj/6lRwS/wJoXiKglKkT+s4UODUDrAFIXWkt3bMLI1TOVsEUH3j45aAcWQU9qoip
         0ItQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769628483; x=1770233283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GePnCPMULS4ZH5+nWQOFHXb1cucdY2lNKyMwVx2+ph0=;
        b=ap7b+u1IgglPywgU7la4B1fIQpGSCTleF+P+Zuv73i1LoP+i0OA3i2KmngojsDIiaU
         4VA/hfnongAJ+NIMmuZZtij9TX5WT4ErDXJ+StwwRMnUmEvcKmkeKUyXRJ5B0bf/9o1j
         fqFcrpKUUQpudL487L7zOpAqXUe0oA9CgcsHe8Yuzr1w52B+jQkPr7zYB3T9B9O03OgH
         988L+kl+qYcns1pTvbF3a5eKmH0YzyLu4xcwjv+Rdav6nbuunDiCQqWMsn5c+7NlF/k9
         c8HlWuRvtAwN1odqk5e9gb1jz1RuKgeAZ6kvjMilcBUsL+U8i/wQdQfR9nv4QmUarZb8
         9xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769628483; x=1770233283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GePnCPMULS4ZH5+nWQOFHXb1cucdY2lNKyMwVx2+ph0=;
        b=pPl8VJU9uBxYsVTViwD4+bdQ6z7WR3nEYu2FDp9QnVhhxK184u3xoPga1U1hgl6hU0
         6o2K/bxEYwHKZMyAMEvfGJJZVCTqxaw4+wQy9hGZW10v2umBZcqUeUjm87aTRGn0aLOP
         o1EGiU5CeevcTYbXAl1ArkEtZ0QygLs/f5IaBUxSbh8XSCFGXbZvEExlnnubp2mRi1b2
         lYP8Qw873Pai65ujF3imkhHAR9VW6CfrOX6Ib59zlV0VlU3yYFtRNi7yMtddW06yPwPh
         7xUagmeA95hYD9jnATCdKMBdiXC68LU7hfJEpgMoz9kioGpiLK5PggQE/R/pSuYXQQxP
         CuwA==
X-Forwarded-Encrypted: i=1; AJvYcCXsMPNfR0grry4HyKwT1T2RWsuP2kfkgaOaVYNkm9YPcT+gE4ch+3B8XWu56ahDJqPv+TnWtWl1hm4G5YIl@vger.kernel.org
X-Gm-Message-State: AOJu0YxqiAACy9pnKRL0QMXYbaZSM9Ekr7EzffTIWDkVnEY8r67ofeGL
	j0vvef0tCytcPX0ylMM9ShNT6N1UCdPt3/r0deIoggGn5/wBHeQEskAoFGjc51HM6T04KN8/L98
	jEWiojmd2T8AMqAVS72YSqfnTDD60v78=
X-Gm-Gg: AZuq6aLn5aceRPuyiHZptSIVlMhRSWf8MqT+yFWeNDsjm+Fby+jkMOm40qULieVldZh
	11BknhD4KI9itYSbSl6z4eyyLFGLyBnMOsneLmBlIJncADp7L4VHKrBbRw+fX2IQjhxJwY52FW+
	Loco1T6lKbN0z3CVy9KSUV4NC+ZzufvOnlWoE7PhtOcDFwTAkxeZNB/mRnxCOcM8nY3/x4GmJ4R
	8yuJIpnO5VeOBml/3DsQpsvJy8f0tftTJSi/XeSrm5AYUkcqnmQzbZigMyLhPBLwrsnPHkqIFZX
	JZNd1AiYTS6uPTg9GwNBDoEiMakUbw==
X-Received: by 2002:a17:906:6a25:b0:b87:6b9a:3016 with SMTP id
 a640c23a62f3a-b8dab4128b3mr438177266b.60.1769628482187; Wed, 28 Jan 2026
 11:28:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128111645.902932-1-amir73il@gmail.com> <20260128111645.902932-2-amir73il@gmail.com>
 <34bda263-4b41-4388-b58a-6fdab6d1fb49@app.fastmail.com>
In-Reply-To: <34bda263-4b41-4388-b58a-6fdab6d1fb49@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Jan 2026 20:27:51 +0100
X-Gm-Features: AZwV_QgreAtAH7FDuCqbPK5kltExclmyKfjvr3XllZoQUxupqijk5qdN7jwW7bI
Message-ID: <CAOQ4uxgjxeLMv5d0BB=KrrzB64LMSoAo9HSkQZmP4Bu_De20Sg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] exportfs: clarify the documentation of
 open()/permission() expotrfs ops
To: Chuck Lever <cel@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>, NeilBrown <neil@brown.name>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75796-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80F0EA826C
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 5:10=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> Typo in Subject: s/expotrfs/exportfs
>
>
> On Wed, Jan 28, 2026, at 6:16 AM, Amir Goldstein wrote:
> > pidfs and nsfs recently gained support for encode/decode of file handle=
s
> > via name_to_handle_at(2)/opan_by_handle_at(2).
>
> s/opan/open
>
> And one more below:
>
>
> > These special kernel filesystems have custom ->open() and ->permission(=
)
> > export methods, which nfsd does not respect and it was never meant to b=
e
> > used for exporting those filesystems by nfsd.
> >
> > Update kernel-doc comments to express the fact the those methods are fo=
r
> > open_by_handle(2) system only and not compatible with nfsd.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  include/linux/exportfs.h | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index 262e24d833134..fafd22ed4c648 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -192,7 +192,9 @@ struct handle_to_path_ctx {
> >  #define FILEID_VALID_USER_FLAGS      (FILEID_IS_CONNECTABLE | FILEID_I=
S_DIR)
> >
> >  /**
> > - * struct export_operations - for nfsd to communicate with file system=
s
> > + * struct export_operations
> > + *
> > + * Methods for nfsd to communicate with file systems:
>
> Let's not remove the brief description for the export_operations
> struct in the Doxygen output.
>

OK. will fix for v4.

Thanks,
Amir.

