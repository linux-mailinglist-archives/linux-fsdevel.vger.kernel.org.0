Return-Path: <linux-fsdevel+bounces-75655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGJPI4o0eWmwvwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:56:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3449ADBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CFBD30432F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55030E852;
	Tue, 27 Jan 2026 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix+lNivl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B332868AB
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769550960; cv=pass; b=aQhSBTKoK0Jp9wzzxZYdRFtmrDcQ+ZenJ6yasoODIyiXdjmRQkbDwQ6mF/vbsnHke6UZyDedrgLoHq+lh8ZXGRQt+ec7xsyGg/DwIavArwxgxzhw/lcVbcjRxhHSMruwcXayZSf+iGCmVOe9th5dI3yIycOS5EPsmiN4ouDjxQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769550960; c=relaxed/simple;
	bh=8m6SHPVdIWrcyh2aRGiyHcnuhF1GhzjV4UbqBqvwtjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUVZD1ooIbjSHqqbLJDEnfaCecnGEG9BrDsY4Lza6Ipcj/4bqdAAU6qqct/wZIgBHMDQ+CMAMSBS3Ev9UZe2906k8qW5daGSbD4geUVcAIKSdzOU7osOV3LieWSpYW6sGpTqnHAyO1QAw2jgDLoaudoTgT7GkZGvtl75BY0sGAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix+lNivl; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5018ec2ae21so68532021cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 13:55:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769550957; cv=none;
        d=google.com; s=arc-20240605;
        b=i6H6lnoK0wD16Vh8pVlXhGFzNmo1JvtaErrlChmXmQyDkizUvGWKbTng3ihTV+y3LC
         30pysDpnNAoyzHnBp9iiFm9NRVHja1zqM9otHdhdct5ygXSGmCMR6GDPkJFQX9/HXdHi
         wBiAAXF8f3pUu3Go5t2D6+wKmggjnthk7Hbv2bBL21OndDLaP8W0uPe/gIyARzIG/HFC
         KovD18NoyD8PZFNCK4FVeLq5xkM1jYC0ZZRyUpVW/eFdqEC7oOVwlAloYzheD4fzO7b/
         p/yZ+EAiqzng3AhjhLSD8E58sdtxQDPhSZTslU3EI+BttyJBx/7/UeKRFnkWRbb6uekA
         e51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NKlFs0mQTNIoeYHTCe8czttQkA2EuwhIv5BND87JXOY=;
        fh=eAhXzUwuk8cFTLfhXk1zjJ5ZgdowCG3AM2eDYCa72Uo=;
        b=HJ9AWDm6qmK+6igtWHvpjyXlJntqAFx4E7ZOBaaKjueKlB7BPs/kywEPgTZ4s3Q0y4
         g3YREIqSItrLe/opQfj9+rZxYFaxCa1I/4KLPExKFcMhGckAt9TbkIHxkydY7fugIuOh
         J7WnB3TTVNnHynYj3FB0yeqLw/JOnjiHtzCbJDnSMzex7l5u1WWr9GiztHzGU57LGNtT
         gdHE3d1vN0Guqx2vbyUtj8/wewrodA4wQq0VUUljyMUr7Kfq5EPEHWjjOoKGKGB6txsh
         +Jiz72rgWIiSkc/iaB4CxjqyZpZgkuJa8HYfRCJ9spr4W859bfv6I1hWrPgwq3+du/9C
         5mLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769550957; x=1770155757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKlFs0mQTNIoeYHTCe8czttQkA2EuwhIv5BND87JXOY=;
        b=ix+lNivlr3lyDXAuHr9H0DGq1g3Qt/dJxnKBg+40FddaJGs4dWOKK1/OlODc5ZqYJB
         k/ni//D0zoZGihJmfE+OX2T7mPfdv8jwxYW/VuqzpghxwH8urb2UoF20+fifIFcnFlwY
         dYRuDywReXrDcVEvYRbCm2IV6r87jPb/zga/nbF/Yz5Cj/iI0w6glXt5qSUghAwy45RP
         R6HDS0B3lCT8fI7owiMBkmYuZ2Fl8ik7lOtC3mdng4Eb86bEKOs67t+8aI6e17wJ9Ncl
         lahXUPAgkUh6615b/DYUpz+XK98/Mov5xF8DGilVRD+KnhRdF+FCuLPS69nm+6mg4xaP
         h2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769550957; x=1770155757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NKlFs0mQTNIoeYHTCe8czttQkA2EuwhIv5BND87JXOY=;
        b=RLK1nqmCCQMZyXz4OfudkSBMoERwIQzXghPdEDRlf/MqCcytyCXvatyKyO5aNdUuFm
         3uoESMMZpQaa9opKzeTLk/gIne9jrMM2gvKC1rbOzD0CChO07FlPu/RC/vCaEh3Q+M3K
         N2Ni+yWwyBirrL4zERKLIRTcBIuNI/OgDxu9C/CQZtW4838NMOjupFN66HXiFonq86PT
         ytP6d/cJfYcp+5VcVb3iWCeJDXSsR3gb8eE4NmLFKKwtD80k0Cc9sjmx8S0btw8/rCJl
         BtnV9EILDaPkbsCyoQOkASKXryd03sk+LmdfGxUA0npC7kFUVFbV2S+EKG1OMxjH/dqL
         Cwsw==
X-Forwarded-Encrypted: i=1; AJvYcCU8MPaJQ0A1dUMH6EKZtLvNN2jIWQA0S8JEWz5O/Na7DD0Uyxoj4Ee5znyvmWW+4HEc07zo51NYNcPRuyvR@vger.kernel.org
X-Gm-Message-State: AOJu0Yypd7fFx94boFf02dU410oC85iSyAgQwCPerKbNblnzXTiyvtif
	jNVoVbnOErqcpC3tJmBttiZpLZBxn5/+wfqfOTFfaEdorqViFyOPj7dXk1atDwkBQ5JuGLHLoO2
	7TTD9y7+1QKwqcN7NnGLyzrSkW383ksM=
X-Gm-Gg: AZuq6aIvhyEdYqRY2U5V3eRSIBpKY/dSiToYrg7IQydHkn/mPF9W/pRCaVfCf++qk1Y
	5ko0kLmtIT+qD8ThYapq5F1F+2wxE4D+f6cMWFgRGXLh6EN3C+GKS8BR4pDpn5X8dw/+ImK78O4
	yqp8HWZhigvZ+kaVJciuRuKIxCpByeCFPulQFTbbX6DeAIC5fSGnH22faWlNt+8hF4/1ovwp/J+
	uP5MROfskId2f/VpmxBubxZAUSWJ0iNTSLcz+Y8f+Is8TpwJPM8k9kWLPbnHln2X6B5MQ==
X-Received: by 2002:a05:622a:311:b0:4ed:a6b0:5c39 with SMTP id
 d75a77b69052e-5032fc1341emr35550071cf.63.1769550956926; Tue, 27 Jan 2026
 13:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116125831.953.compound@groves.net> <20260116185911.1005-10-john@jagalactic.com>
 <20260116185911.1005-1-john@jagalactic.com> <0100019bc831c807-bc90f4c0-d112-4c14-be08-d16839a7bcb6-000000@email.amazonses.com>
In-Reply-To: <0100019bc831c807-bc90f4c0-d112-4c14-be08-d16839a7bcb6-000000@email.amazonses.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Jan 2026 13:55:44 -0800
X-Gm-Features: AZwV_QhPL9Sj6DMGNjDww4OFl9nGLOsm6aFs6t6n1KrqwkFwyhPAYsBkmAeTikQ
Message-ID: <CAJnrk1bvomN7_MZOO8hwf85qLztZys4LfCjfcs_ZUq8+YBk5Wg@mail.gmail.com>
Subject: Re: [PATCH V5 09/19] famfs_fuse: magic.h: Add famfs magic numbers
To: john@jagalactic.com
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
	TAGGED_FROM(0.00)[bounces-75655-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[groves.net:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jagalactic.com:email]
X-Rspamd-Queue-Id: 2D3449ADBC
X-Rspamd-Action: no action

On Fri, Jan 16, 2026 at 11:52=E2=80=AFAM John Groves <john@jagalactic.com> =
wrote:
>
> From: John Groves <john@groves.net>
>
> Famfs distinguishes between its on-media and in-memory superblocks. This
> reserves the numbers, but they are only used by the user space
> components of famfs.
>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  include/uapi/linux/magic.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 638ca21b7a90..712b097bf2a5 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -38,6 +38,8 @@
>  #define OVERLAYFS_SUPER_MAGIC  0x794c7630
>  #define FUSE_SUPER_MAGIC       0x65735546
>  #define BCACHEFS_SUPER_MAGIC   0xca451a4e
> +#define FAMFS_SUPER_MAGIC      0x87b282ff
> +#define FAMFS_STATFS_MAGIC      0x87b282fd

Could you explain why this needs to be added to uapi? If they are used
only by userspace, does it make more sense for these constants to live
in the userspace code instead?

Thanks,
Joanne

>
>  #define MINIX_SUPER_MAGIC      0x137F          /* minix v1 fs, 14 char n=
ames */
>  #define MINIX_SUPER_MAGIC2     0x138F          /* minix v1 fs, 30 char n=
ames */
> --
> 2.52.0
>
>

