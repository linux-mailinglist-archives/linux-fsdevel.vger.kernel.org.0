Return-Path: <linux-fsdevel+bounces-75982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iARXJopYfWlDRgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:19:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06268BFEF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B35C3034280
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEC7325713;
	Sat, 31 Jan 2026 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSNneL6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB5E2E0B48
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822327; cv=pass; b=Q9lQGN62ObgIWSoQALk1pmNmVUZHfJvV05j8I7ED6DJX+cl5CL/hJ6kdXBSJdVeCAJ/BFo9z8QNGTGNHKp8P6oAQa2Y3U7WkO/H7xh/uiYrtKe0ixm2CPtg9F4TwMFThpq1LszNp23MJVrXgHM93frCYG0qQxkWmrV/F9TQFaps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822327; c=relaxed/simple;
	bh=NJyyW3LrV2W0dVysafPoC2cjKhBb+MYi76erl20GHWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8vQQ8rYB1GcLmlblbAo818W0rRGa/7VROFZ9E8LiWEJfcHq1KiXymPEcKX42KH3tl+R82aKskW1t+AhWSvlCaRws+Nkj1PEKLYxnuNYNFd7mZwgr4eWQv0qVZaBRkxOm6v13ak+31MpUBnBydiYloC7ecB2ROopHXMFHOW4gCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSNneL6Z; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a2fe9e200so26045236d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 17:18:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769822323; cv=none;
        d=google.com; s=arc-20240605;
        b=EspoxTFIWSRmKcRk3gokR0AIfMA8h8cJzaKXHRSAZlQwgVGyLfzpX0JEOiDmtirv8U
         amtejxfjWLWr1ShQHQ3G39JC+KL03iNX0mIM+Gash/wTkty+LfNO1JKark5fJHIMdi+c
         UQQM57z3qEUtx5USXwtMKBCEn22Wrh+CyEXYqa99EU9wfibLSgCMBm2wWNFFanoD2j9k
         21O2v2RhT9OX2lAfPX4dFJarQH5PCfHE/9QbEoWgIHmmXgkvNr2VoIPvM2d1sBKJwiPJ
         nYOy5EOypkd7el2m9pNNcdFDs4b+2lk83xm3vrM7A9h+0FRMCS3FgFhulS0ispOCG6/G
         93Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9hrsBRNghnIovdQhJmal8FXOCZu37oJsf0hDL/41Z4=;
        fh=2twxbGmC3Tpaci62B/76MOFhyk3gLM7I7kHfqPtXn10=;
        b=R6R9fi0CbMS36LwRtTwBuIcY4C6ejUM8VPxdOX1G6xy8zSZZTNWLZDCcpGNHWrRVpY
         AmvHtqoiUEc0tJiOFFGcDImdlcQhHFGNGGRiuGt3g3yTTPpIANhyKm+I46iomZ6y0qhU
         noqyJVTJ7lsHEG/9G2SpaVrW5Cvsmi1QzjkMBKTWlGCPdIOSJXBS2/Rk5zK1K3q9e3Q4
         VqQ5lHpotmCejltXB/NQOtJe1uW0HCoS1LcotmIOlt4LX6FuirNzStbkmV9u5G9sTryi
         pHi2kg/6V1ApFjEVZRZFA2na7rOMNE0Zc5i5W0SYhmjULKl56aMRpDiNXQHn+owfnAhK
         KI1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769822323; x=1770427123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9hrsBRNghnIovdQhJmal8FXOCZu37oJsf0hDL/41Z4=;
        b=MSNneL6ZdYS1vduzZenv+A58CJIG8UdamLkhXnr/8M8qRF6bLvW4xnwm/VgGelXIFl
         Tj/cfvczfvA6tQ7Rm9CtQeA/gDpKESzHzdYX3VXFWA/1KF0MBZHAykOv0tVmtfUzOKda
         qId3vRNxsCijXl/sjwUwZpmCNLUFkJl6DAozGBUgGOerPhHa2oxWGbTNjX9rkGalHfOX
         VED2q3zf5UT5E7EZl45MKecY9pOLuq1uWqbZQDFz7qZcHEA1CXd/HtVlQdbZ/UHBJF1x
         eJo384AlDBIPIADVGL5ZVUe+CTjBbQm+HXsDgVxVYtjifhX4Cno7a40hCza5Oxu0el8S
         3CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769822323; x=1770427123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C9hrsBRNghnIovdQhJmal8FXOCZu37oJsf0hDL/41Z4=;
        b=mI4b7bDpzklvXpjh6pYef0DMwRQwnxdjMyEP6IvqyHtJho6x+lpSUANrpkjh13QEeN
         K/yml5LsbuifmXn0yFKa+jlE51n7pGB+7UPla4/nGxETA6S5B2MgFFBpnjuPwrL2y54p
         XeD4oDVer6jLNWdMXHgGsHiO3RTplZbg5AS8EVPJVgpLiqCI0eSQcukspabxQMRHA5ro
         0Al3fHbjM2sMM6UdxrF3o1rF5MgcSyhvMyiLKhyYQUNql5fEZgfuCier9EL5nR0yBf4H
         q+BajioT0X+eo5gaP8K3jkd3CfWHBBs3v+v81C53LX/3l8835rQak1DjOZR2IG/CiTU5
         jGLw==
X-Forwarded-Encrypted: i=1; AJvYcCXTTVjSysdeH2I30v5cbEw5//Ih4DtdhZbes8Xyzna/ifN6d40/4sy0MKFG3LaYmbBmY5lIs5/AxAMtybeL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+dgxdPQvg++Q5qeMigS7f3uWJ9b4vZOAt7lHeYzFgOQskoP2
	r9lx6qEouUuWIm5toZ0u5+2KQwQuXBSQB66iDnYlBLxuiuXYpVbbJVw25ReNi4j1Iiey/LAN5qb
	4InCzGIe8cD27Fa10UbUI4fIopIqDVGs=
X-Gm-Gg: AZuq6aLrSGO4jySnluhhn9ebmYO2kaF0FA9M+/jGwc23OF0GpSH0D0hVDHd8FicBNOg
	+MmWn6CP+8A/xEOhH1h21SKE1OBLpJHqBsF32K2gWYnAIcK8029BC/XOPa0c/w3MX3E797MwIdj
	f3mbyss3OLpd2MYRKqJR37z63SSXGHMe02aGeFQ1+z1QAk4ShVrBBosXCyK7Q90y61TqvwOlA63
	5do53mW9vvO0qTl0fC3JLLAYVcgis8bB86+BrBtOe7YQDJhqc6SL1fjJf9y+Idp8B2IxA==
X-Received: by 2002:a05:6214:29cd:b0:894:2e09:335c with SMTP id
 6a1803df08f44-894ea06291bmr70047416d6.53.1769822323137; Fri, 30 Jan 2026
 17:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118223516.92753-1-john@jagalactic.com> <0100019bd33f2761-af1fb233-73d0-4b99-a0c0-d239266aec91-000000@email.amazonses.com>
 <0100019bd33fb644-94215a33-24d2-4474-b9eb-ddae39b29bd8-000000@email.amazonses.com>
 <CAJnrk1Z9BuCLZv576Ro9iYUPRDpW=1euG0rQ2wC_19sBcR18pw@mail.gmail.com> <20260131004119.GA104658@frogsfrogsfrogs>
In-Reply-To: <20260131004119.GA104658@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 30 Jan 2026 17:18:32 -0800
X-Gm-Features: AZwV_QjdwrW8pUbs14BS2iG7wgbYWMrbtNkfExGV1HlyGRZYGgSvmv1QKkg5_Go
Message-ID: <CAJnrk1adQktTTv=9_G=G_QDTkEZyCQgsPDd7QSGwwTsWk_4fEg@mail.gmail.com>
Subject: Re: [PATCH V7 1/3] fuse_kernel.h: bring up to baseline 6.19
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, 
	Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
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
	TAGGED_FROM(0.00)[bounces-75982-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[jagalactic.com,groves.net,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,groves.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jagalactic.com:email]
X-Rspamd-Queue-Id: 06268BFEF1
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 4:41=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Jan 30, 2026 at 02:53:13PM -0800, Joanne Koong wrote:
> > On Sun, Jan 18, 2026 at 2:35=E2=80=AFPM John Groves <john@jagalactic.co=
m> wrote:
> > >
> > > From: John Groves <john@groves.net>
> > >
> > > This is copied from include/uapi/linux/fuse.h in 6.19 with no changes=
.
> > >
> > > Signed-off-by: John Groves <john@groves.net>
> >
> > This LGTM. We could probably just merge this in already.
> >
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> >
> > > ---
> > >  include/fuse_kernel.h | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
> > > index 94621f6..c13e1f9 100644
> > > --- a/include/fuse_kernel.h
> > > +++ b/include/fuse_kernel.h
> > > @@ -239,6 +239,7 @@
> > >   *  7.45
> > >   *  - add FUSE_COPY_FILE_RANGE_64
> > >   *  - add struct fuse_copy_file_range_out
> > > + *  - add FUSE_NOTIFY_PRUNE
> > >   */
> > >
> > >  #ifndef _LINUX_FUSE_H
> > > @@ -680,7 +681,7 @@ enum fuse_notify_code {
> > >         FUSE_NOTIFY_DELETE =3D 6,
> > >         FUSE_NOTIFY_RESEND =3D 7,
> > >         FUSE_NOTIFY_INC_EPOCH =3D 8,
> > > -       FUSE_NOTIFY_CODE_MAX,
> > > +       FUSE_NOTIFY_PRUNE =3D 9,
>
> This insertion ought to preserve FUSE_NOTIFY_CODE_MAX, right?

FUSE_NOTIFY_CODE_MAX was removed by Miklos in commit 0a0fdb98d16e3.

Thanks,
Joanne
>
> --D
>
> > >  };
> > >
> > >  /* The read buffer is required to be at least 8k, but may be much la=
rger */
> > > @@ -1119,6 +1120,12 @@ struct fuse_notify_retrieve_in {
> > >         uint64_t        dummy4;
> > >  };
> > >
> > > +struct fuse_notify_prune_out {
> > > +       uint32_t        count;
> > > +       uint32_t        padding;
> > > +       uint64_t        spare;
> > > +};
> > > +
> > >  struct fuse_backing_map {
> > >         int32_t         fd;
> > >         uint32_t        flags;
> > > @@ -1131,6 +1138,7 @@ struct fuse_backing_map {
> > >  #define FUSE_DEV_IOC_BACKING_OPEN      _IOW(FUSE_DEV_IOC_MAGIC, 1, \
> > >                                              struct fuse_backing_map)
> > >  #define FUSE_DEV_IOC_BACKING_CLOSE     _IOW(FUSE_DEV_IOC_MAGIC, 2, u=
int32_t)
> > > +#define FUSE_DEV_IOC_SYNC_INIT         _IO(FUSE_DEV_IOC_MAGIC, 3)
> > >
> > >  struct fuse_lseek_in {
> > >         uint64_t        fh;
> > > --
> > > 2.52.0
> > >

