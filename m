Return-Path: <linux-fsdevel+bounces-75969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO7NMyY7fWnbQwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 00:13:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C6BF52A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 00:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BE43303A5F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E93366806;
	Fri, 30 Jan 2026 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlKSw3ey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61AF366551
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769814814; cv=pass; b=NcrtCSffTadK76+74nNiKevHK6QtKY3M6TUhAoOL154DoGNr9Uw3qX0t66NRZ6J+jXDG11fOWjTPXR36dJDNROiNnZNBqtI5Xo+O9EkWTFPbXK/+W6HDDcbzKyvGJ/hqAiaIlEcPsjo7mDL81iFMO/qqtbTML2naP9tvlQqpTno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769814814; c=relaxed/simple;
	bh=c34Quq+eQsW819C0KqCK2tzNAvjf7UPjPYiue9c5K38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJmtTkyh3X0J3q2RqM45eNYaFpTjt6OYF9KyI4TrUCHanWfOfpKCQRt9Xja1t/0LwAG/3Rs5wdNF1bqs+HTpM3UCCPItC+dPqZqgjeyphPxXzAksa4VJDo5j8YfySqu8za/z1v01mFjhleTjaa7VffV9OqRMHTIiLt8TxR2QH7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlKSw3ey; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-502acd495feso28582171cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 15:13:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769814812; cv=none;
        d=google.com; s=arc-20240605;
        b=CwitSEK5UTfHObbYbpdhn/A7n07aobCN+k37/93w3noGcUA7scK+9JxIevRqTzF+ah
         VVPsYubFqYH6TrttTihd8Sf1vB+AY6h5pPPU7Wna/LoIIheBudyigAALkHn343pMDf1S
         949/YC6t3KG5/vPOKwrNeZGLz//eFVTGHqTwxvNgrKiGOs/35Cb6JXnLDTOYbJRclyG2
         vLT36c9BybfIIjtSdE5rc0dlbi7tpu6qlDsrKVKTxpL9MwvXimBXH4C04SwtvvTptnqf
         +SY0cRN4iKMmmhmLf3y/nmEx1ORS4tZDiMoZo56VABhe+yPNEk5A/a3WOp2Y8juz8RuB
         9Gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mCpt40N6zxEp6+nDSQMAaK5Vngq+apunb1ikLDPBcPI=;
        fh=p/YOTivE/sm6w7FH3C3oPB8kUwnxZG2sNANcprbrsKw=;
        b=CZYHLbUhp3OPIeF1v3D8RDtrvuMQTKFyPLKG/Qmg+/6dAFl6XKVpjdcD2K6QdTMVJN
         FGDmr+LsGzoqFS22rYfWuTMXSPtPkLm6UneUqcGyxwjUOgblkGneOCMcIMDbDx0lJC/w
         +kf1/U9sHaUHT9HhtSZQBIaqRWChc59xs8HckHtbkkiCMkOBWDJUlMRyGQ/wv2XwBVri
         L0FjBF+Jb3hIE9Irs0QK52heChi4jKu008H1muq5K2uxydG1peUL9UzTMrlfsT++Rp9S
         mokNXdKcnr/iyxFEOUTtWPcUFBBfsS1PKD/UM0nwlgNl5JHXDwUqQPAVU86ASiAkZ9cY
         wJAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769814812; x=1770419612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCpt40N6zxEp6+nDSQMAaK5Vngq+apunb1ikLDPBcPI=;
        b=NlKSw3eyc1tyXmspzsAwqjEg0L5qtn8VEtydTsA1k/t5kIJxOhrN2xKKdm8BWLN4zz
         rHri9/V/4RaC+06llGtYHBEbstcKr3C2GEYlv+T0zCAcKgW5DwWdrG4GOhekhIpSKNbz
         I4JR2O3IP1Dm1IvYTvX34MyT2FHLc1MS/K0DZp+HKPt3/k3BxZDOXv4U4ca6cPB7X49/
         DzaO0WmFUwSH/KlH3p1SVDNYEkd+OihCUPLw4RbFD24BnLOm47UrWhuqo9VaIefTFdlY
         AutTs27CmaoB8IgK8gsy4HdDweucvKjr0i0a7uD8fogWRB6mEthY6FbUf3gZJSknQ+dF
         rBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769814812; x=1770419612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCpt40N6zxEp6+nDSQMAaK5Vngq+apunb1ikLDPBcPI=;
        b=ItPX3BAM3HQApKVKevz4y5r57214GGNEyU9AJB6V0UCZb0uzxfRwoKs+TbYWTfW1WK
         r+OmWr2CeiW5SuVUU0sC4PFsspd6mca1eLn0Bdwp/a3+uknlC1iNucOh8Hxn9+x5oJ6b
         KVinAxgzHBWbOtE0gKeMuHICq4TwPhxHugzJ2ZXoFe+pnbFiMu1R8xevD4ByTiCdAA13
         wXShqYOU+quvzyfhPFJKxLzDr/18n1pkRnHubeaEN0rk7qvrfiF74i8q0PcN+UO40nVL
         oBSdj+8v71W/7SPN033vCZkbhl4Na5yoIR0r7Lw9mJIDtZlh5JZEHMwwASdO5hTaeJmp
         GVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU7xvfcOpRsxNzmxU6G5+A2bELvGek0yj2CyaUJAjvSMg9k8n9ZiaB7Oq2oxfGYCFgGCwt+qi3MldWnuis@vger.kernel.org
X-Gm-Message-State: AOJu0YxsIXqlniv03Rm1Xb030UI+dGHxuhqxKVTeZIF4ZFJf8GvOOFbF
	RYgafqNnzw1F/u5wVGOKIlqYBz4NXrdzNr2ARcCUVWQwIrpEuCmPv97Z97gHElFVhSHjX+S0zwc
	DOcL7OeTp0GSoPTyg7R9gMY2FBXIF/Io=
X-Gm-Gg: AZuq6aKNdge+QWeJT/ldvGICfS98pHmbV8NolO7faTeOW515EtSmS72C6J3cnHJklPz
	OEwwWV9vKKXEs0ObRBrl1HpLBA45MjSjGyjTuLzRHHQ04WQsZ/YAha6DTxSPyUyW8x5dB2IGV9F
	Z0nJep3ZBZ5pfuXB0GlxUrTUAz344F/6YHvp6oU7GB9MWjC3KopFC1lYu4vzfSQrR4oflog9Mf+
	Yf4utX0k5Btvhmp6WvAxOSpn+9AHiXGybYnuPsOY2wuy6lUgijDuIKuIbkAjZ12bR5F2A==
X-Received: by 2002:a05:622a:c8:b0:501:502b:8c6b with SMTP id
 d75a77b69052e-505d217b5a5mr58752171cf.9.1769814811697; Fri, 30 Jan 2026
 15:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118223344.92651-1-john@jagalactic.com> <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <0100019bd33e43bf-bb49e98f-284c-475b-a027-13c7271f67bf-000000@email.amazonses.com>
In-Reply-To: <0100019bd33e43bf-bb49e98f-284c-475b-a027-13c7271f67bf-000000@email.amazonses.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 30 Jan 2026 15:13:20 -0800
X-Gm-Features: AZwV_QhZcPdEqRRUkE10n-Q1UjWagCWtvDsztQQ9CRVvisVS-xKBB72jFQNvlFU
Message-ID: <CAJnrk1YNRNRrXVydX6=5NAic3fu6QggbA5xV2fwywP27yZu2ZA@mail.gmail.com>
Subject: Re: [PATCH V7 17/19] famfs_fuse: Add DAX address_space_operations
 with noop_dirty_folio
To: John Groves <john@jagalactic.com>
Cc: John Groves <John@groves.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	John Groves <jgroves@fastmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75969-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[groves.net,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 312C6BF52A
X-Rspamd-Action: no action

On Sun, Jan 18, 2026 at 2:33=E2=80=AFPM John Groves <john@jagalactic.com> w=
rote:
>
> From: John Groves <John@Groves.net>
>
> Famfs is memory-backed; there is no place to write back to, and no
> reason to mark pages dirty at all.
>
> Signed-off-by: John Groves <john@groves.net>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/famfs.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> index b38e92d8f381..90325bd14354 100644
> --- a/fs/fuse/famfs.c
> +++ b/fs/fuse/famfs.c
> @@ -14,6 +14,7 @@
>  #include <linux/mm.h>
>  #include <linux/dax.h>
>  #include <linux/iomap.h>
> +#include <linux/pagemap.h>
>  #include <linux/path.h>
>  #include <linux/namei.h>
>  #include <linux/string.h>
> @@ -39,6 +40,15 @@ static const struct dax_holder_operations famfs_fuse_d=
ax_holder_ops =3D {
>         .notify_failure         =3D famfs_dax_notify_failure,
>  };
>
> +/*
> + * DAX address_space_operations for famfs.
> + * famfs doesn't need dirty tracking - writes go directly to
> + * memory with no writeback required.
> + */
> +static const struct address_space_operations famfs_dax_aops =3D {
> +       .dirty_folio    =3D noop_dirty_folio,
> +};
> +
>  /***********************************************************************=
******/
>
>  /*
> @@ -627,6 +637,7 @@ famfs_file_init_dax(
>         if (famfs_meta_set(fi, meta) =3D=3D NULL) {
>                 i_size_write(inode, meta->file_size);
>                 inode->i_flags |=3D S_DAX;
> +               inode->i_data.a_ops =3D &famfs_dax_aops;
>         } else {
>                 pr_debug("%s: file already had metadata\n", __func__);
>                 __famfs_meta_free(meta);
> --
> 2.52.0
>
>

