Return-Path: <linux-fsdevel+bounces-75968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG3NHH02fWkuQwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 23:53:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FFFBF3C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 23:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8771B30420A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 22:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0535B65F;
	Fri, 30 Jan 2026 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuX4Sh3x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765A358D38
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769813606; cv=pass; b=sAFnEAoE66ifZUM35/F1Xn0bcml9TBiYAFN1AFV6ZjUa3yByjGJ20ocVmIw7aaJiojctLpeDUT1j1cw835W3aP0tHsdrO1QOytM0uE1V3iH46voKf6KO5faulUvbIWhp55lJcmpuJhDyc5foyk5jqG5BeAOFJ6KCecKnd3suTDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769813606; c=relaxed/simple;
	bh=I6AA9LJQkjtH8pRVXBRtk0eb0kKxzR2imNiewT90hbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fo+WM7TpjwU+gWhpVnpzo7kXxT2z3qTlZVqDDvjm90TlIygoua6uq3h9bUrtdmFKwSbhLk3H227tHpXqKWU9P+fc1JhxsgSVdRQrlN5RvzeRUsSFN+bfwRgqYoWrrymQdELmZjv9JBt6RY3b/VSlq6Gx29pplqi9gRR9pHskhsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuX4Sh3x; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50145d27b4cso28366021cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 14:53:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769813604; cv=none;
        d=google.com; s=arc-20240605;
        b=H1xqEqhB0SmxZqHBkBrfXdLRA7ap0/CWkgd6u3ciWbKab02sHyImpGePhZxRxHpGV5
         eeqy9Cr5pYfFIFGmsiqtsauaPpA5A/rZxnnvy31zgKwOIv3eYVgDKPyaIBlA0T0Lsn+f
         k+d5fs9dSd9jdurHEQon2lACI303DY5Wd8ia12NKfj7XWCcNKYodSeDX4/6lUvrx4DpH
         d/S1yrxGS0owGAIBW08SPHu6lVc1AB2gPeTbUUIHX+Qh2D76z1gBhtethVsrN3wedTdz
         6SV1Jy/rnY25F0VJ5rcsWmvByjHiA1N4xNbVDH/f5BbTG0ZebzmkRkUgkc3rTOEgqV4l
         uSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RvpDJGr4SwO80ntJbbklM7U7D7aCaEah0HNbCRkVHSs=;
        fh=yQ3VZZgg/5RP6PBMKhx17SDKhcWKv+jHVIDOUxeE6IE=;
        b=PK6uXS+D7Qs+qkEpzSvd/xPlushQksrsy8ElfJ+brRXLHOSeK0Gdif8sU9MW31Hq3V
         2WKSQ1p8hYBIq+4QUloa0s1h/nDj+czFq5DZjweQsudde1rTVEcL4r3/Yc80LwmkCqhw
         d4ktZe3Tm/wmFblYCQFyIKkor/Ga7dOWU0hn5zsaTL2pSkPSv2pdu1PnrM1IeUXROREE
         LnwbHNCkDDX0BWRCnjugbhXUNF/SWx+gkXgS6BIViCJGXzI+W/5qk4WBDpqg5CMZ9TvN
         /SRp4JMmGrX/An6xLx0GaM/sXWsO7g9lN4AnzUmOyV1IStzDf7bsRGPAWAfIPgewsW7B
         MaUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769813604; x=1770418404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvpDJGr4SwO80ntJbbklM7U7D7aCaEah0HNbCRkVHSs=;
        b=FuX4Sh3xtBiDnHAg9EFEEZ2NvuXwTyuY5kH5yeju3QvvNNpRwES0yiHLoqFqYCEzM/
         erqkzG8/DUskaWzzQur0Z5aWpXSXuzDpNUpc9MsRR1GDIS9QKij2f8A3hPSiC/IkpuEw
         ltrMleIWg+zQSK8wVnGP5P4RVf1jv3GorwW9ObvyRVB1A80qEviOSF+GUDHIenpm5U+i
         PT3DhhATtxe6fYVpEf1U9qiN5Ckh26v87FKM4gybE412l43MPoKrsy7k6bUa3rjv2Abc
         5ToqgZmyRng2xg6qMNxdyjcWzow4ld3hwb1N6SfWwpclON182bdqNIfjaiy1lNmVXAG8
         J/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769813604; x=1770418404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RvpDJGr4SwO80ntJbbklM7U7D7aCaEah0HNbCRkVHSs=;
        b=iST40IbgPRo9Nw7paJ1J39SM6EXFBXQU39mg4LFM/Mgx1IqVz5ZkkR2++z7zd1f4zG
         VDavUE9b/tM3NgP0s9st36VTqHKHIL3ru/+EE//WJmoafC4pmOeSXn+JRAxywebFUQbt
         xEg7ngh7CtV8a9Nh7Ull0K+C87dD+ObK79Ic/zB8nQsVLqm2Zv633YQawtrhMxFEzb+t
         Z2FaDGCY5e16VR5y5kipDdHPOg/tFUit4I2dza2z/KkTpgibk7I+w5+qjnnVNI6Z46sf
         SdSNCV2ffjfx9rkgtBMxMrmMu64cjsMWI9Zt7W9IDGLMFvbUsQhnsOaWnZCwmfR6rbri
         7Q/A==
X-Forwarded-Encrypted: i=1; AJvYcCWM/GCjkxc8Ys0IM/YmLaQBsS4Ld8EjrUxrUalA5iaN6pKBswrKGXL7UMzctEJlSphlt8P473/ilm/Rb9AO@vger.kernel.org
X-Gm-Message-State: AOJu0YzSq791OJl2mEU5CZQyEVdaC4aRYkejjtWn7ZwVObtuVCjNVqb1
	vyuTtVwoP7+9rJs8y03JOG5K5RAq6IuMmKHEqVh6/eNZkxzUQpiCh9ZcM+ZlfoTO3kPJcDxpswS
	N93Vb8VDAjVUy3113UslhMLMGo4WJRqU=
X-Gm-Gg: AZuq6aKvn5viJsJH3IYyeOVrSmuakwZbUbbBJkh59LfHGHvdcUDQ7/NvKerb8BWG6jD
	854qPsWVqOOl+ofs84lS73iPAbt6Eh0q5vYEdFOzcGjNIcEncOAFu2x35j6mFP6Cf/4dhcSBVtw
	7w9lEqX8PTTswenQaDOlaowoEdjnJ/AY3DDzBgeYG75uV5+1aij/I4ksurYgMGXS8CyTXvsPKYm
	s2u8bVDb54LqnZbX6s7DD7t+em8N0+WqxZ/yrddZG465yG2+tkG8z2PPrrPuHShImRoeg==
X-Received: by 2002:ac8:5ac1:0:b0:502:9f71:6458 with SMTP id
 d75a77b69052e-505d223e5afmr53898871cf.44.1769813604047; Fri, 30 Jan 2026
 14:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118223516.92753-1-john@jagalactic.com> <0100019bd33f2761-af1fb233-73d0-4b99-a0c0-d239266aec91-000000@email.amazonses.com>
 <0100019bd33fb644-94215a33-24d2-4474-b9eb-ddae39b29bd8-000000@email.amazonses.com>
In-Reply-To: <0100019bd33fb644-94215a33-24d2-4474-b9eb-ddae39b29bd8-000000@email.amazonses.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 30 Jan 2026 14:53:13 -0800
X-Gm-Features: AZwV_QgH1KMH2vlFTNGo85feW4dv-AHS4Ad-yDU5HTglx7x3SJ0Y27UEufrkPHc
Message-ID: <CAJnrk1Z9BuCLZv576Ro9iYUPRDpW=1euG0rQ2wC_19sBcR18pw@mail.gmail.com>
Subject: Re: [PATCH V7 1/3] fuse_kernel.h: bring up to baseline 6.19
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75968-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jagalactic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C4FFFBF3C7
X-Rspamd-Action: no action

On Sun, Jan 18, 2026 at 2:35=E2=80=AFPM John Groves <john@jagalactic.com> w=
rote:
>
> From: John Groves <john@groves.net>
>
> This is copied from include/uapi/linux/fuse.h in 6.19 with no changes.
>
> Signed-off-by: John Groves <john@groves.net>

This LGTM. We could probably just merge this in already.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  include/fuse_kernel.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
> index 94621f6..c13e1f9 100644
> --- a/include/fuse_kernel.h
> +++ b/include/fuse_kernel.h
> @@ -239,6 +239,7 @@
>   *  7.45
>   *  - add FUSE_COPY_FILE_RANGE_64
>   *  - add struct fuse_copy_file_range_out
> + *  - add FUSE_NOTIFY_PRUNE
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -680,7 +681,7 @@ enum fuse_notify_code {
>         FUSE_NOTIFY_DELETE =3D 6,
>         FUSE_NOTIFY_RESEND =3D 7,
>         FUSE_NOTIFY_INC_EPOCH =3D 8,
> -       FUSE_NOTIFY_CODE_MAX,
> +       FUSE_NOTIFY_PRUNE =3D 9,
>  };
>
>  /* The read buffer is required to be at least 8k, but may be much larger=
 */
> @@ -1119,6 +1120,12 @@ struct fuse_notify_retrieve_in {
>         uint64_t        dummy4;
>  };
>
> +struct fuse_notify_prune_out {
> +       uint32_t        count;
> +       uint32_t        padding;
> +       uint64_t        spare;
> +};
> +
>  struct fuse_backing_map {
>         int32_t         fd;
>         uint32_t        flags;
> @@ -1131,6 +1138,7 @@ struct fuse_backing_map {
>  #define FUSE_DEV_IOC_BACKING_OPEN      _IOW(FUSE_DEV_IOC_MAGIC, 1, \
>                                              struct fuse_backing_map)
>  #define FUSE_DEV_IOC_BACKING_CLOSE     _IOW(FUSE_DEV_IOC_MAGIC, 2, uint3=
2_t)
> +#define FUSE_DEV_IOC_SYNC_INIT         _IO(FUSE_DEV_IOC_MAGIC, 3)
>
>  struct fuse_lseek_in {
>         uint64_t        fh;
> --
> 2.52.0
>

