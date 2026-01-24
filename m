Return-Path: <linux-fsdevel+bounces-75341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEG8Ga4ydGmm3AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 03:47:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D729B7C404
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 03:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D4AF3013006
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 02:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F2020DD48;
	Sat, 24 Jan 2026 02:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUs9CDDJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E89286352
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 02:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769222799; cv=pass; b=B/WtpoXuVBENaLHvhhr+yB7+LwhirtqFTEFStm1QlGGZbLUN/ZSokNNZUrhE1dUOXUHa8P3QgqjruRrV3TbiW6Y9VHWyH6GITPeMdDNYggBur9PcDnyX58XTTlrOBhpZPdHal6kqPqXBWKNnIFq8WkTzhYp4LZ4yABIGtg4Digc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769222799; c=relaxed/simple;
	bh=EipzswoJqGpCk/EjSge/EWU+SsEFjc4Js/gT9tBlFzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjj5oqnQIyKpaTBJ2Pj+kVh8lgskhkNOIfQRXTRxCW+9ikG/6d0Lt+dz9gHaNvpiqW/g1CDlTzO1cFjeorD4LUhQD79wZtC0kEnkWWJDq537svvWohvK733D5QTZGXh/nX19PrGaySRUzYkcIza2b2R+BYSmzFi/bDlWggrjdzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUs9CDDJ; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79430ef54c3so25183847b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 18:46:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769222797; cv=none;
        d=google.com; s=arc-20240605;
        b=elp2XQuII1M9GD6lBgct/bCHqJJHq+grhbphYxb3PALQjv8jvptCjvQfZDUecxg95J
         5ZkSFyZv4a8It2zU1f6OYka9rIQ3AAD6xrR31zaOy4w6G4Tqnj4RDKp6w/esbXaWB++O
         6LYu6d2Su+1dkNfiYK6EFKycE8/0mDQVOwOUX+OhwC3rUB6fq/0o+xNV9ZT+/EnDg0gI
         0AWcdNj8YX9dy5XFHNO15SxKx+mQJOpQSNWNdw6Wl0+AWrJ/Qyu1wvswNwWSGNpt1Aa0
         Ast4z1CXtZ4EXLgHOW9T8+fBhNU8MXI1GPA4ldO40VHJnkzFtOGH9JYgpV2grc2KCJ1F
         3LUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hVBIyYSLwYri5Rm5aIFaBdXSWGbMyG2/W55rodswgt8=;
        fh=wALrIgMugMWp4qPZ6/zOTGsn8kI9qoxxAzRKAtf4eFk=;
        b=KDFzi7NAfLJjJx1DTb7xKJ7XnAesMMYsAAftZKiRQ2ErvH4r64kdeDGnvrJ6KdjuIL
         9bP46+HjZ8UpUIA4DbPO6Q+BNp/NfLeUvRBrAL5/oM3CeXUVTBXH4AzxMvP2AFrxYHgn
         3ilx5GkEhjMssZ6l4afKsjunvFgc6bATPgzHnD/qE1KodRBVCYfWjzvrxNFQDC/0aX3i
         nDI655hhTr8KFIzYnqYCpNgxomDvwcI90DaO++O5IAVUhPF5HSgF6KMHmIcACEpZVtAA
         X0Nm8Sp1AgFtO+b9eKCdxtc0rkbktqXTdFCXQZLwxILqZ8rQi48Hn2pL5fzEyteTtcgX
         pLJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769222797; x=1769827597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVBIyYSLwYri5Rm5aIFaBdXSWGbMyG2/W55rodswgt8=;
        b=OUs9CDDJit536hH8CPCzZPzvCdl1byLTIG25xBbh/AyFRWdb/pG3gY7ARJRDeUjI4B
         9uT+knCBRK1E4R1qgnERtT4eGD8FMwpxkbhmes9rwD4rd0DQgu+yORViaJpK2Qqa5gz6
         rF3FDEhEObvEYidrnPdukokSo/cePKUg6onv+MaZsLn9Yd5bW/AVb7/svYoS5PkYL7JX
         wluV88Ckb3tbgtl6Tri8wefFOxzTbVo/4pceFMoQtbmPgozBrrZHlKPPWN+QGLxvfmLY
         yL0Bo7gmCn4m05XSeQ8+3UUJSyNiBCdRvziYmv+DWfTnLEUlcIfQy+o+kvums7lB9WC0
         g1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769222797; x=1769827597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hVBIyYSLwYri5Rm5aIFaBdXSWGbMyG2/W55rodswgt8=;
        b=g9xs2SOS16ntD7zJYPeEWDVXNSj1Hva0sgzZe5DKQ5jZrRrSkuw3+iyReoObQkIpe4
         V+ixv8hyxutrJIsL4Am2prJuRW+wd4pd5Bg/ZHqJiLf8Lo4S4jlYqahe/EBRJYrt8U1N
         fLOSJT+Lk5/lvT6+0dDGdCOwK1QVKmaP93q9S5lmatcvSEcny5hK8qzAyUG3j8NpP/5J
         0SUG/P4K62FGyJzbLwsV84tiZKyY19gupCu9ythrV81PP/Gi7aUKWnOGIBl7Yc/icrYV
         k8pBggAr4hRmgymdbnkMMt85UWAJz33yYTsJaRz7yZQx6ZXioC/HwsZxTnCimJgY9s6h
         p2EA==
X-Forwarded-Encrypted: i=1; AJvYcCUmLkUTSWJZSSc16Iw2An+zP5m2J06LgcxDglPPfXC9r7WREFt9yuoW0+/7szdeq1SBhnR9wujQVjO0/P+c@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Nq+yezsKtNC4gFSKwMKXk+sebBK8PTR1akj3ChYRWyEbGzZQ
	GzpS5tB0NEBWNBwFoQQRIBR536nFam1YVp2J2Ls1GfO+je/LTVXPZpa0zZiR2WJvoiUT8gFJ0Dz
	yDBb1uAQJhrwRB6+RSZJcAo7eOPCcXTy0yfWosAE=
X-Gm-Gg: AZuq6aIiaCLLv/vDwj9jKslc9nFvPX4wQvJDgiDl1vQI0AjFkMK/yOALIm6LJHB61mj
	OZJDQyh7gQ/JHG0G06lggc747RybHzBIZAtqEY5sYAmRubst9mPv7bZNDtdPf9T+Gzy90Jb2Myf
	1JfcE9P0jZTlB0ZQ0bduLycTFCYbJ0nv+jVC95fVHCUDuKLzWNrr7XOjbw9BZRdTkEvwl5Y/qON
	Nb5IdEA29/poEgF2gzay6qggtr/ghINBAiI/Wj/X8pRAUlNOBTkSZ5ml172vPmoyEZEpP6dF0he
	xI+MzNoY2cMSOImmGqj4Kfwb7JIHZlO9JsLcaqRiOzZ2RqeDSM9KopsCZE9i
X-Received: by 2002:a05:690e:1a8b:b0:644:774a:96b5 with SMTP id
 956f58d0204a3-6495bfe741amr3236061d50.54.1769222797135; Fri, 23 Jan 2026
 18:46:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120051114.1281285-1-kartikey406@gmail.com>
 <1bf327370c695a5ca6a56d287d75a19311246995.camel@ibm.com> <CADhLXY5pVdqhY+cLze66UrZmy0saCro_mQR+APth+VC5tMEnjA@mail.gmail.com>
 <88705e499034c736cc24321a8251354e29a049da.camel@ibm.com> <CADhLXY6wFsspQMe0C4BNRsmKn2LaPaBFfOh1T+OBibuZVSo70g@mail.gmail.com>
 <eefff28b927ccc20442063278e65155c1ed5acd8.camel@ibm.com>
In-Reply-To: <eefff28b927ccc20442063278e65155c1ed5acd8.camel@ibm.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sat, 24 Jan 2026 08:16:25 +0530
X-Gm-Features: AZwV_Qj8q7DhtVLFyqLAcJF1pCX8sjvf4AFiQ0O0my4liLv3dCff4U4-FwOit0w
Message-ID: <CADhLXY6fMO51pxc1P00F3g9PccNvXwOPd+g0FxeHq1FYGR3Xng@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: fix uninit-value in hfsplus_strcasecmp
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com" <syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75341-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D729B7C404
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 4:51=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
>
> If the whole fix will be small, then one patch is better to have. Otherwi=
se,
> patchset could be more better for the review.
>

Hi Slava,

Thank you for the guidance! Based on your feedback and the debug output sho=
wing
the partial read (26 bytes read, 520 expected), here's my proposed fix.

I'd appreciate your review before I send the formal patch.

---

The fix includes two changes:

1. Add validation in hfs_brec_read() to reject partial reads:

int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32 rec_len)
{
int res;

res =3D hfs_brec_find(fd, hfs_find_rec_by_key);
if (res)
return res;
if (fd->entrylength > rec_len)
return -EINVAL;
++ if (fd->entrylength < rec_len) {
++ pr_err("hfsplus: incomplete catalog record (got %u, expected %u)\n",
++        fd->entrylength, rec_len);
++ return -EINVAL;
++ }
hfs_bnode_read(fd->bnode, rec, fd->entryoffset, fd->entrylength);
return 0;
}

2. Initialize tmp in hfsplus_find_cat() as defensive programming:

int hfsplus_find_cat(struct super_block *sb, u32 cnid,
     struct hfs_find_data *fd)
{
-- hfsplus_cat_entry tmp;
++ hfsplus_cat_entry tmp =3D {0};
int err;
u16 type;
...
}

---

Does this look correct to you? Should I proceed with this approach, or woul=
d
you suggest any modifications?


Thanks,
Deepanshu

