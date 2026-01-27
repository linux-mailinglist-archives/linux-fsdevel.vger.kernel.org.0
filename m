Return-Path: <linux-fsdevel+bounces-75586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E0b/Hnd1eGlDqAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 09:21:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEFE9107D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 09:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2744B30360AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA887273D75;
	Tue, 27 Jan 2026 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6sTLfJS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F77023B63F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769502064; cv=pass; b=qeWV8nODC352zZn5lFqWGHPBkcQHh3DpsdLu855HT9U6Yu0Arrdfki0WRG5RAIbnTb1fTxbl39LXgPnXHgH2TEIE18nBoMGns6uGhwkcarEkWE9mNZzPi8KgLDQc3N41YvBI1U+VAyJwX2UGXxl6tQymBbARNCc752FYJ1UWaxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769502064; c=relaxed/simple;
	bh=wbCW7fe55k09XI3K+JlcQBRGcE9oz5k4KpG+0aRPYBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQjT/8YBLW2KZy8MhHfvo2/7jO7mrjAQPk07o1p1T+Eu4CCO+yg8aEOEWDr4sw6VL7JWQrM94qiCaEfACQj2bVlSPmbtPth+DMLsbGwWvOhaPzz/z3rq99meVyM4zWNnD13lPAZrjqWaeuBFxHFElMLEyf8073Mgp20ecK5HPt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6sTLfJS; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6496a048323so2419416d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 00:21:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769502062; cv=none;
        d=google.com; s=arc-20240605;
        b=Tjwwkf+Nx79LUTfUvgZUePDgC9yvfJTtJFwdHa8eqMKAHrIwaNP0YIWzgDG6U7JgEc
         dOYzbwHb2l6rhJ6s+3jYKcS+fGDz8DfbLC72KTjY8y99qRHIVEZ51i0fgaBCr3eC0tIs
         rmDm/75kN/7eg9VpAmyAI5q//Q5scQ5PppQ0fHawrNUah8lEy+knTfMzNgequt7Kr7wn
         LQEFNtkk44Se2rWVnvjGJQEQjcAdAcDUYSOa4fUJQLmrXy4GLSXeA1A4mfoxOBjlY5W4
         aVmzm4DJ9101USSp2KWeZpusAV8DzSyLmuAUnmgeiLmv0TsGc/rWQXwKhCuluQYrlNOk
         kYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rInO50rL+FT4bl7O6+DTFr33WqdYfNDMtWFHdaLnEt0=;
        fh=d0VxgjYbUqLOll3r4yRt+Bo3jU6fk5EXTrodWrhuzko=;
        b=hsMs+S6J68MHkT40lM7J7pK/kIlJUQKztHY0s7wcOQcVD+NNrk6GsSExOBw6+jOx+R
         7bO3pBhWTKKsVNogcdE+cXDwysZWCHP1UBzS+4hWL4x4YXmuvMOrXo6CSoDCMbXy/iEz
         soOWNnyh5ZvFjKmkm/ypTviQE7KJb35TJjhJIdaGv8R81T1OCp2MmkQx6/XMrw8q5z/c
         nMJF3EHnjz7Pzphc2hp950VRqX+XxNo/PDC+ltKACjzl+lFQv+ASNNRNMLOdA2OTtSN9
         FCjrcGdKNl2Q0mG1pXXCBNo9L10fowyKh0IkmQ6KjNIlxkYPZoiZ5qafqYmjIr8NQJ0e
         4GOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769502062; x=1770106862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rInO50rL+FT4bl7O6+DTFr33WqdYfNDMtWFHdaLnEt0=;
        b=G6sTLfJS1rD+2lWUN5Jeh+FyFeQvpvCLq8o+fXkV/SS3jYBQhCJltB+RxsOLJst3Uv
         U9QLdVE+qrpvB/zJ2ZE9uiCsUqKJCZOLtoMtU62wIFYnfz1jnC7eC9QJZ3jNvYI9H4zb
         Pn36qLC/lj3WFgQ4lDcxHtXFfZ7xqDAgRUCpV616Q/CUvv+WVTkcrX0cWKPTKjT3D420
         x3q8Xl15QtytDS4+n0cERYP/cGhuRzZ6nLGrb96+tmXP2E6N4JaCkDjRmdKEuuqq7Ja3
         JRzymLqqCUu64+nyH8o8POUyLUQJBzAPs9NPWYbT4S5dGNADAlUUR0P+5zz9gRURuzEE
         1nJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769502062; x=1770106862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rInO50rL+FT4bl7O6+DTFr33WqdYfNDMtWFHdaLnEt0=;
        b=ffvKhxpZF90i98GtXhhvbmWTcZvkNlogDbsXxaPU6+DOuPQIiS5MZDjPWlDniYPd7P
         dQIKae+JfhgbL7dYcfEnHG8fTN6Y1ukmhQf7MC+RTYAl6cd8hQuDS8Ta61MMaLI9zu3j
         L+/V9uSfyRiztk6XvUtlM2cSFSmRVaPCA0hZ+k3SmC141BZnrGoM0JRct85opl2/FZ7f
         uUp/OZ8Qk8ikbUvHitlTgn3d1hhbzMajoZTyUwX/X62CBu6Djn5t/JT1cNGsJ8+Nkh5G
         Brjnwd78B/iODmAE4Akf42G1XzhBcLaIBt7T7nsfQUo3b137M9VJsqbzUacVUwWeSzcf
         GIiA==
X-Forwarded-Encrypted: i=1; AJvYcCUkdcJyCAGRyH/IkBXEYV58jBg9o3H38+Wv+PucAPq31JJD/dIugCfqJ9Zvu9XvDzplWIxeUmqJoQRlM27o@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0ksA+cChlLYQfr2BUY3fVB7OabhM+hoxPCCWeQgQqxf1pRgx
	SbImDk8izVfVytjOU+iQRav4ZkVI5NeP4R2w+uPtyHSzHcYy+vgpjJOQ161vhywjMhR8FpWWlix
	ltKwKZUIF3RMONidSwPFx/hSwsfMN4Pc=
X-Gm-Gg: AZuq6aLjfzk4PPXv69zW2oIWyYZKqOF8/b/wJiBJL7ZuN6gkebBM6HNjaIUp2y4+bOZ
	U1eOirDxEpm/DUz0dFq9CXqgzr9GnSEvcle2y2z/HHzo8sH1iHOxmWUHbVpS2jAxE68qCgovufR
	fmx8t0kuHM6BQpLd9EA73JvQU/VbV/bl6yNCyiapJR9F8qP+1c6O8gwfdU2tlus4BfkNOR96Y9r
	enjW/gZRsDPW11uQa05FF/yi0A/uTSmNkBSteFtMRLVQu54SyXxRH08caR9omNCwqVJtAh6nB9l
	H2mn65OylBZNwVq92iQ5kPum/x1xynPTueJdnpH2EE9fg/3b2wJSBEeieDib
X-Received: by 2002:a05:690e:400d:b0:649:5204:a127 with SMTP id
 956f58d0204a3-6498fc41ba9mr444727d50.60.1769502062094; Tue, 27 Jan 2026
 00:21:02 -0800 (PST)
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
 <31dcca48613697b220c92367723f16dad7b1b17a.camel@ibm.com>
In-Reply-To: <31dcca48613697b220c92367723f16dad7b1b17a.camel@ibm.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 27 Jan 2026 13:50:50 +0530
X-Gm-Features: AZwV_Qhe6fxp2jAVwPMsMcVlTeM41QPZmidu_Ux_pnnXLXQtJVWuBW9FKTOYJ3Y
Message-ID: <CADhLXY54yiFoqGghDQ9=p7PQXSo7caJ17pBrGS3Ck3uuRDOB5A@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-75586-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEEFE9107D
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 2:07=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>


>
> It looks like we can simply combined to check into one:
>
> if (fd->entrylength !=3D rec_len)
>
> However, I am not completely sure that it's completely correct fix. Becau=
se, for
> example, hfs_cat_find_brec() tries to read hfs_cat_rec union:
>
>         hfs_cat_build_key(sb, fd->search_key, cnid, NULL);
>         res =3D hfs_brec_read(fd, &rec, sizeof(rec));
>         if (res)
>                 return res;
>
> It means that we provide the bigger length that it is required for struct
> hfs_cat_file or struct hfs_cat_dir. It sounds to me that the reading of t=
hese
> records will be rejected. Am I wrong here?
>

Hi Slava,

Thank you for the feedback! You're absolutely right - using !=3D would brea=
k
callers that read unions with different-sized members.

Instead of validating in hfs_brec_read() (which is generic), I should valid=
ate
specifically in hfsplus_find_cat() where we know we're reading a thread rec=
ord.

Here's the corrected approach:

---

int hfsplus_find_cat(struct super_block *sb, u32 cnid,
                     struct hfs_find_data *fd)
{
        hfsplus_cat_entry tmp =3D {0};
        int err;
        u16 type;
        u32 min_size;

        hfsplus_cat_build_key_with_cnid(sb, fd->search_key, cnid);
        err =3D hfs_brec_read(fd, &tmp, sizeof(hfsplus_cat_entry));
        if (err)
                return err;

        type =3D be16_to_cpu(tmp.type);
        if (type !=3D HFSPLUS_FOLDER_THREAD && type !=3D HFSPLUS_FILE_THREA=
D) {
                pr_err("found bad thread record in catalog\n");
                return -EIO;
        }

++      /* Validate we read a complete thread record */
++      min_size =3D offsetof(hfsplus_cat_entry, thread.nodeName) +
++                 offsetof(struct hfsplus_unistr, unicode) +
++                 be16_to_cpu(tmp.thread.nodeName.length) * 2;
++      if (fd->entrylength < min_size) {
++              pr_err("incomplete thread record read (got %u, need %u)\n",
++                     fd->entrylength, min_size);
++              return -EIO;
++      }

        if (be16_to_cpu(tmp.thread.nodeName.length) > 255) {
                pr_err("catalog name length corrupted\n");
                return -EIO;
        }

        hfsplus_cat_build_key_uni(fd->search_key,
                be32_to_cpu(tmp.thread.parentID),
                &tmp.thread.nodeName);
        return hfs_brec_find(fd, hfs_find_rec_by_key);
}

---

This way:
1. hfs_brec_read() remains generic (doesn't break other callers)
2. We validate specifically for thread records where we know the
expected structure
3. We calculate minimum required size based on the string length the
record claims
4. We initialize tmp =3D {0} as defensive programming

Does this look correct?

Thanks,
Deepanshu

