Return-Path: <linux-fsdevel+bounces-75794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJRtI61bemm35QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:55:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 046FEA7F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 328DC305144B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE652374169;
	Wed, 28 Jan 2026 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMqWeIwI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F9372B3C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626481; cv=pass; b=X59ER5oQLKxFw5nlA6z5UAYBtmUpBU/f+ZIuBgTgqVz/1BPOK0o2MmXU9pG2kHji1izNBTid5sINzn61duYPZL+tcHTDJN6TOZYCzLzHlhCCjEv2yCWzujcn/DxOMeIC5fHehzqQK25u7RDkrZJ6a0LD8mWaxPQwx4bKT5iPMlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626481; c=relaxed/simple;
	bh=Iv/R1VrCmh7DPMnIVbKr+xqiK5DjA15w78PbjXQO200=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfHraDtvhYQuuhwHnaMBbZXbh6Uoq8LNLwUzI9XvZWePEiiQR0e340WxI5PirHqUfcx+RREGQ/VQMeT2EXpjetQGawJrDJ3xIjCmnmbnA+AHhDvuJIcpGiS9yqPgwU0E1d3uaoxVpytCdhtH3U5djyes5qZtYDL51GQN7sJwMBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMqWeIwI; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5014e1312c6so832771cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 10:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769626479; cv=none;
        d=google.com; s=arc-20240605;
        b=EITg1xiET64imSNPVbqLChGv5rgUq0bvWkv4PDZwdFyrqZmNECEvl6ZcvLA3a+q5Sf
         KenQqZLgF2YIwovg6kEGV77hRzBp3IQOe3S2Sy1nf8wpGwjY2iWr+TdU2nIu3H9n8LDb
         GdzBKYheh757oppBFp9W5bGvBMgi+N9Vpk3ad/SfNkQGLw+JbtI6oE3M1Ori0cAhgNa2
         WuBc3Of+sjNrDhQ65DPLEJgRupKyG1Z3lCzxXfdAptsT1Ih1nctsoIshef53VOKm0TPe
         pOhGWlO0HbRAR/FVkzYYmyGYLhFfVKh4mac/Mvs4T1quB5JU+mewoAEV63feBCMv6nBw
         beXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EQD+zhNe2TBSVN4C+gGjdPZJybKoBQIJM5cDvqByP90=;
        fh=j/wCGtY9uboQ/MzSCBOlS9J7ZpUZwYP63osyKXg/iew=;
        b=hmDznzdMwEaRwEPfY010HFT6l5ILzDBeCkYyVdx9ZZer+vvTsT5mDH66+RZZKDav9k
         zs3kJPBRcc7VnjBIzntdGU/uhIT6FqUAyYsVRbKVqg1VmPNmte9xlD5TTTQmrxhknqqD
         eHoA6MnEnoHcbTwgKpCpJF+sY+qRgdk1N6+kRWnpVQix29Wav/0sKu1oaXX/NBs8qoC2
         epFt7J7vwBVu7QTdTpuothJjljqWsLuzhGUFwETsrn2pmoSYiAsb46/mBQHTzELdPD05
         VZOHUBdpJ5rfob5QxlmIRIhtJ0xsYOAsnWeujN66fhMi9EAOcJg9K+LKxK1ZhaTdLGnG
         dwtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769626479; x=1770231279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQD+zhNe2TBSVN4C+gGjdPZJybKoBQIJM5cDvqByP90=;
        b=nMqWeIwIAlKYcQIFhefA7zNtavrmv2uZ1Rq3jpT/gQrF4rV7DhVyyMlHiMWHWjMLBC
         dkXaLYPg57lLfsY3ZY8e0H8v4bvI/UCaEew+WU/YHJQuVZF5765U3AN+toFuivAuYhYy
         yblY7vDQ50Q4nsFIpY9Mto3Ehw0CGGg1kQwpiyJp73rAHafr+u4GfnCSYTsAxeA9bZPE
         dN2GVo80uQViIUaIyHRJPeoMblJGhyzc6DmkWyFCXcXY1PjPTOH26nV3AokrrDa5y679
         oE5oj4IfSJ65MBZ1Y2iPt/1OrlufxJRgRk13ygoW1CzpqiV07uTW5U+vrfgsIbits/cX
         StSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626479; x=1770231279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQD+zhNe2TBSVN4C+gGjdPZJybKoBQIJM5cDvqByP90=;
        b=wLST3hS7LCACdK2qJJmqWAPMjsaCvHDfLjstSt1KP7/vhH1NviAwWWVxrXf5Lphix8
         LHTHEsqdWZnZbK5zk4ja4spLTsWr62NZ4/3ZRMRdCuhaADxMKIJbX0E2rs5axbmoLLzh
         4sAlrBZybGhCR5GKn8XZC4d/GIS+XQTD2NqyzqrHb3zMwOt2k/9jB+J3gWSwM8IkFt4a
         cqM0P0+aALsC0dCRe2uoK6J7QoVGtLLirbbWVrIoRVX3jdfptgxix8UyvOIyhz86IOru
         c3P2bAhAx5dd2kFXBfPS4wSm255EF67bETk2OAukRENUJBXLqMrEDsfbVMTZb0+ha1jT
         DcOw==
X-Forwarded-Encrypted: i=1; AJvYcCU6z60iaZe3EPOvXzAJWdJPE+SZopkS+j2G5tMO70FNwNRUSKIYbPt4drv6Itsu7brwug0C/rOzTcQO1Csu@vger.kernel.org
X-Gm-Message-State: AOJu0YwbDyyA9jJTHi9Yg/1cSTMsKHBtXczYvV/iSDmpwmoFqEzHPYCu
	OkK1l0zwxXrjbQKyaHTrtzgKF1QsuY82i0SMikNdjNmbdZna0yhjh7TDPvftHlUJ0qOZ3rYLnzy
	t++Tho+lBctcAxnTGwUiX7FBADeOM1kk=
X-Gm-Gg: AZuq6aIZvYFU6acMc/HMANDV9Z9kJ0Z/b7PZB2VfPhzFy4LCuQKtGene1EjT7f4qyoN
	SrlJMlctepXgDcg+POJ1TUtkvhGyE65rxNs2kfmvDWGUds8aYQj5uwGQevveBgxpqb72k9OjpXa
	dAJsZIFZKLB+d9Ix2bfx2ym32K1vyHAeLsZmAunlgeHiAt+mkmhCAdxV1ZtbcCklZ+HTXKLUsxP
	rfk3FXYaivc/YqjAR13NV1H2IKOHjXXK1NyVrPcJRgZjf3FvyXoowUReScQomfwxf3lQg==
X-Received: by 2002:a05:622a:1b91:b0:502:9b1f:ca4f with SMTP id
 d75a77b69052e-5032fc14d15mr83239651cf.84.1769626478464; Wed, 28 Jan 2026
 10:54:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116125831.953.compound@groves.net> <20260116185911.1005-10-john@jagalactic.com>
 <20260116185911.1005-1-john@jagalactic.com> <0100019bc831c807-bc90f4c0-d112-4c14-be08-d16839a7bcb6-000000@email.amazonses.com>
 <aXoarMgfbL6rh6xi@groves.net> <CAJnrk1bvomN7_MZOO8hwf85qLztZys4LfCjfcs_ZUq8+YBk5Wg@mail.gmail.com>
 <0100019c05067b3b-b9ab2963-ace5-481f-8969-c11f80a74423-000000@email.amazonses.com>
In-Reply-To: <0100019c05067b3b-b9ab2963-ace5-481f-8969-c11f80a74423-000000@email.amazonses.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 28 Jan 2026 10:54:26 -0800
X-Gm-Features: AZwV_QgXH_eGEFbh8Ufwurz5i77r71GDNcEX490YVb0oLl5TmaOznNxDkpKSA1U
Message-ID: <CAJnrk1Y6HayeS-C3sOEOc_CgaS_K=SedZNpHASAXAkgZyp3Xsg@mail.gmail.com>
Subject: Re: [PATCH V5 09/19] famfs_fuse: magic.h: Add famfs magic numbers
To: john@groves.net
Cc: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
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
	TAGGED_FROM(0.00)[bounces-75794-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[37];
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
X-Rspamd-Queue-Id: 046FEA7F1E
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 6:33=E2=80=AFAM John Groves <john@jagalactic.com> w=
rote:
>
> On 26/01/27 01:55PM, Joanne Koong wrote:
> > On Fri, Jan 16, 2026 at 11:52=E2=80=AFAM John Groves <john@jagalactic.c=
om> wrote:
> > >
> > > From: John Groves <john@groves.net>
> > >
> > > Famfs distinguishes between its on-media and in-memory superblocks. T=
his
> > > reserves the numbers, but they are only used by the user space
> > > components of famfs.
> > >
> > > Signed-off-by: John Groves <john@groves.net>
> > > ---
> > >  include/uapi/linux/magic.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > > index 638ca21b7a90..712b097bf2a5 100644
> > > --- a/include/uapi/linux/magic.h
> > > +++ b/include/uapi/linux/magic.h
> > > @@ -38,6 +38,8 @@
> > >  #define OVERLAYFS_SUPER_MAGIC  0x794c7630
> > >  #define FUSE_SUPER_MAGIC       0x65735546
> > >  #define BCACHEFS_SUPER_MAGIC   0xca451a4e
> > > +#define FAMFS_SUPER_MAGIC      0x87b282ff
> > > +#define FAMFS_STATFS_MAGIC      0x87b282fd
> >
> > Could you explain why this needs to be added to uapi? If they are used
> > only by userspace, does it make more sense for these constants to live
> > in the userspace code instead?
> >
> > Thanks,
> > Joanne
>
> Hi Joanne,
>
> I think this is where it belongs; one function of uapi/linux/magic.h is a=
s
> a "registry" of magic numbers, which do need to be unique because they're
> the first step of recognizing what is on a device.
>
> This is a well-established ecosystem with block devices. Blkid / libblkid
> scan block devices and keep a database of what devices exist and what
> appears to be on them. When one adds a magic number that applies to block
> devices, one sends a patch to util-linux (where blkid lives) to add abili=
ty
> to recognize your media format (which IIRC includes the second recognitio=
n
> step - if the magic # matches, verify the superblock checksum).
>
> For character dax devices the ecosystem isn't really there yet, but the
> pattern is the same - and still makes sense.
>
> Also, 2 years ago in the very first public famfs patch set (pre-fuse),
> Christian Brauner told me they belong here [1].

Hi John,

Thanks for the context. I was under the impression include/uapi/ was
only for constants the kernel exposes as part of its ABI. If I'm
understanding it correctly, FAMFS_SUPER_MAGIC is used purely as an
on-disk format marker for identification by userspace tools. Why
doesn't having the magic number defined in the equivalent of
blkid/libblkid for dax devices and defined/used in the famfs
server-side implementation suffice for that purpose? I'm asking in
part because it seems like a slippery slope to me where any fuse
server could make the same argument in the future that their magic
constant should be added to uapi.

For Christian's comment, my understanding was that with the pre-fuse
patchset, it did need to be in uapi because the kernel explicitly set
sb->s_magic to it, but with famfs now going through fuse, sb->s_magic
uses FUSE_SUPER_MAGIC.

Thanks,
Joanne

>
> But if the consensus happens to have moved since then, NP...
>
> Regards,
> John
>
> [1] https://lore.kernel.org/linux-fsdevel/20240227-kiesgrube-couch-77ee2f=
6917c7@brauner/
>
>

