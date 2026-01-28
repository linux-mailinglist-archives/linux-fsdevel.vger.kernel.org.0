Return-Path: <linux-fsdevel+bounces-75696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DGEHqiQeWl9xgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 05:29:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB949CFB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 05:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26C6330086DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A94B330315;
	Wed, 28 Jan 2026 04:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM7I2unh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1A24291E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769574562; cv=pass; b=nxK3sNJTYbREaVRxBZ/5TwZlQWFWOcf09KzvDUhNx16bg77FvXgKgFVw4YesQ3Yx80BJOsifxAKMSTETjFP2etbf7GjKWhNghyb8xYjtnGRkOZVz4BWRv0ggD/fMZUK/WCWyjnGTGRatEQQ6EJXWtCOmrFTzclmUS2Nlq2hSkYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769574562; c=relaxed/simple;
	bh=bZMoTqIkNWNBtqgS0BN1DuzX5V2pzB47cae+oRUq14A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlSGmk2HD+4Of+cPKqIJ6EUhTHNqxOYcef0uTijLhSGki651EPDa/PRqQsGUKaijB3fJIBfzP0T3u3SdLarkZ7jrKcSJtfXEMmsFBMJEGIX/YgBOw5aBDwcXXrobo9o9qi1vV7JjrhaoS1rFlBr+KtJ/fYJESytCqEyRKgwp/jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM7I2unh; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6494a3d92f5so7015405d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 20:29:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769574560; cv=none;
        d=google.com; s=arc-20240605;
        b=cyz541snlq8wH37Q4S5T8RvtDXb06aAX9hnd/AcO/7Wm/8PuyknnGfG0QqFw+bMZ+T
         QwU4Aw88NsZBB8iwAG4teu/CEsfk2r8y0ovvWwfz8v2LB5y4Xt0ncbjKQvcPVNO4ia/K
         O0a4a+O23uaIaba70An4UHyRup1m8sjmGXHsZRVUEToCvHZaGNI84Y+mdtVwIqi1ZhOo
         zr7330oFxFy3ao7uYy5oMbEpRWcrhQAxQOqJvDusNPmKFXd9TrelNvml6F1I32/bpq/S
         fvxakqOuRROq5VbP1k9F5M+ixUKfmX/Cs2bDbHdzZUgvSnF/Rg38GVrjkPU5EYdxh0mR
         diCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pc1mFBaik5C4IRr878Nf/VvPc/22Dumv0KmDbktAD4M=;
        fh=MYZyTQNZYDeWMAHFMAmIHeAW1b+0fI6uaU5MVecyfFQ=;
        b=hRg7ShkgO3UCqUdOqmXV63UHMThT3/SCDdYE+lDr96E5P73C3i7odYUEwji0A/qu2F
         jkw9UDrBtgiTHlYJg80WUKj3AWwuZWkr2D4U4lFhwb9cwSlCCTswJcah5/xKiqPHwjey
         MEzEmKzNkx5MNGrJddyUgvnFxR5j2xvBLiw6jzB/PvtXk/QdlsvgTtw3/TuA9UKheLXQ
         5OwV+J6pK4lkdI1BY4DTJeWLztZpRyRjR4GYzp9UdvTWdt2XgcbY3XrCA5yHp87F7BdK
         4RsHjCF7AY0exXi502vk7SyC+uN27R9QohjJCrQww868yz98iXff7eUHQj8oP2GhOura
         MSWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769574560; x=1770179360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pc1mFBaik5C4IRr878Nf/VvPc/22Dumv0KmDbktAD4M=;
        b=VM7I2unhqfrmIJMMZJ8FweRnZmnbxh+BDCP0yFhkpHOag08NYQFU3fYT+qbRE9RVW6
         Ej0l9tvUJ3EVH5QCXcjM/tvHHjv9adH+oW7HHBzk4n6uuKzLYNzBr2PQS/E4NHtRWEJP
         Myej85jmbpcsITAkUd5j8MFQhX7bzh+A60QKGCIFPqAQzGruLdckDvSsI9uhcNH7ezyu
         26sGC3CR+IppJ5AGhF9hVvNTyEP3xZhVSFsdbjEKgLyYC6SzWJ4i97sivJBUYsRcoSBW
         uSXCqjNW7pjNjS6IJrp3uE2jN0IgwWQUVnRBMBcwtJ3kScQcmxCxVVLDjU7lC1mmFAUB
         kCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769574560; x=1770179360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pc1mFBaik5C4IRr878Nf/VvPc/22Dumv0KmDbktAD4M=;
        b=g62RqArqO+HhJVAvFF+otBh5Fkp40QE2DcqI2e2/ttOcLt4V3iaRSj+HtQhk/zWTSd
         ldejYc5hcGpo+sGdf98DFouA5y9/PFqeXTrA10FATFZvIdUAvNXCoBCWKGmeirpeEh0c
         mwh8+7noTLiSkcXl4yG+d2eERvxgClzJKocDK4t+j7SugbqsJE9eVGgvy8hCTM9bGQYD
         EenJR70hY+xvDINIEn9EN8x3X1axdAvG7q4scYi4t16oW9xYGWEJDUy9xXioR8zoAfD4
         Ngos+n5z7Ivx/VZ1OYFlqILhvXraWgeSMH8OYUGRC9bMPyQHeAiT13e6NyVq57ssxgAV
         neEw==
X-Forwarded-Encrypted: i=1; AJvYcCVUWQaiiIS2W2wlEfydpv6mwLf5+wC6ryN/owv16vMoNMkUZXDa31qiAla8TMOJX4oHfg+/tkg0KoL2jism@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3G4uI4/PvINtCKU6qalwXnCkbd5YvuMrYHEUwyMJNKLDMF5DY
	OjUPArVUAsdbe53a+o7MHmZJaJ0aDcGTseUEifaEVyvFwtjPAKl951cYJLUR+phZH4/gR517gus
	R0W+k5bdMMob/zKN5LQtV4iFrgfUxnnw=
X-Gm-Gg: AZuq6aL2G411DxpePj6ufTs+k/IP4t/SJHrLLIY420sAKZpixZk2Ac2kXKzVHslF6fL
	wtI1Kgjrav17BNyVOqabKwd4m+ntFBbKLbDO48z2SAXPsEt60Z0MAfaiYSlgPaHcDIp2eRM6Vz9
	rWMZOrWYQ37A4Pn5zS4aCFAGHTlefA/HszKaihRmC4mxCgFUUXMzzYEMBY6muJR1c1IrW0afAAH
	ddkV0GreKdHVOizq0s7SbGeeq5fWAIogHhlw81CsIK9Gkk82wMJ+LWw+e5IGmkzQmsoMgnUV1aM
	9z7+ok/59RpOYGIAjniU3dkpPqS4yYRiiC23fG+D+NigUFwTBecimAsnEWI=
X-Received: by 2002:a05:690e:d53:b0:644:60d9:864d with SMTP id
 956f58d0204a3-6498fc7d5c2mr2650535d50.92.1769574560447; Tue, 27 Jan 2026
 20:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120051114.1281285-1-kartikey406@gmail.com>
 <1bf327370c695a5ca6a56d287d75a19311246995.camel@ibm.com> <CADhLXY5pVdqhY+cLze66UrZmy0saCro_mQR+APth+VC5tMEnjA@mail.gmail.com>
 <88705e499034c736cc24321a8251354e29a049da.camel@ibm.com> <CADhLXY6wFsspQMe0C4BNRsmKn2LaPaBFfOh1T+OBibuZVSo70g@mail.gmail.com>
 <eefff28b927ccc20442063278e65155c1ed5acd8.camel@ibm.com> <CADhLXY6fMO51pxc1P00F3g9PccNvXwOPd+g0FxeHq1FYGR3Xng@mail.gmail.com>
 <31dcca48613697b220c92367723f16dad7b1b17a.camel@ibm.com> <CADhLXY54yiFoqGghDQ9=p7PQXSo7caJ17pBrGS3Ck3uuRDOB5A@mail.gmail.com>
 <eac09a9664142abbc801197041d34fef44b05435.camel@ibm.com>
In-Reply-To: <eac09a9664142abbc801197041d34fef44b05435.camel@ibm.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 28 Jan 2026 09:59:07 +0530
X-Gm-Features: AZwV_Qhui4lPila23XsyMzV51x2um0JhF_b__M2AinbDKKw4r-1Kknx3P-waMpI
Message-ID: <CADhLXY6WTN1gTYZ72_GvMyS2RJArX=6-h5-NmpwBGRU_m5FjQA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75696-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DCB949CFB8
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 4:51=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> As far as I can see, hfs_brec_read() mostly used for operations with Cata=
log
> File. And we always read hfsplus_cat_entry union. And you can see that it=
 starts
> from type field.
>
> typedef union {
>         __be16 type;
>         struct hfsplus_cat_folder folder;
>         struct hfsplus_cat_file file;
>         struct hfsplus_cat_thread thread;
> } __packed hfsplus_cat_entry;
>
> So, you can use this field to make a decision which type of record is und=
er
> check. So, I think we need to implement generic logic, anyway.
>
> Thanks,
> Slava.
>
> [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfsplus/super.c#=
L570
> [2] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfsplus/dir.c#L5=
2
> [3] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfsplus/catalog.=
c#L202


Hi Slava,

Thank you for the guidance! You're right - we need a generic solution in
hfs_brec_read() that validates based on the actual record type read.

Here's my understanding of the approach:

---

int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32 rec_len)
{
int res;
u16 type;
u32 min_size;
hfsplus_cat_entry *entry =3D rec;

res =3D hfs_brec_find(fd, hfs_find_rec_by_key);
if (res)
return res;
if (fd->entrylength > rec_len)
return -EINVAL;
hfs_bnode_read(fd->bnode, rec, fd->entryoffset, fd->entrylength);
++ /* Validate based on record type */
++ type =3D be16_to_cpu(entry->type);
++
++ switch (type) {
++ case HFSPLUS_FOLDER:
++ min_size =3D sizeof(struct hfsplus_cat_folder);
++ break;
++ case HFSPLUS_FILE:
++ min_size =3D sizeof(struct hfsplus_cat_file);
++ break;
++ case HFSPLUS_FOLDER_THREAD:
++ case HFSPLUS_FILE_THREAD:
++ /* For threads, size depends on string length */
++ min_size =3D offsetof(hfsplus_cat_entry, thread.nodeName) +
++    offsetof(struct hfsplus_unistr, unicode) +
++    be16_to_cpu(entry->thread.nodeName.length) * 2;
++ break;
++ default:
++ pr_err("unknown catalog record type %d\n", type);
++ return -EIO;
++ }
++
++ if (fd->entrylength < min_size) {
++ pr_err("incomplete record read (type %d, got %u, need %u)\n",
++        type, fd->entrylength, min_size);
++ return -EIO;
++ }
return 0;
}

And in hfsplus_find_cat():

int hfsplus_find_cat(struct super_block *sb, u32 cnid,
                     struct hfs_find_data *fd)
{
-- hfsplus_cat_entry tmp;
++ hfsplus_cat_entry tmp =3D {0};
int err;
u16 type;
hfsplus_cat_build_key_with_cnid(sb, fd->search_key, cnid);
err =3D hfs_brec_read(fd, &tmp, sizeof(hfsplus_cat_entry));
if (err)
return err;
/* hfs_brec_read() already validated the record */
...
}

---

This way:
1. Generic validation in hfs_brec_read() using the type field
2. Works for all callers (folder, file, thread records)
3. Variable-size validation for thread records based on string length
4. Fixed-size validation for folder and file records
5. Initialize tmp =3D {0} as defensive programming

Does this approach look correct? Should I handle any other record types in
the switch statement?

Thanks,
Deepanshu

