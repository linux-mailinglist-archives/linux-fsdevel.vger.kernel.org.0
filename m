Return-Path: <linux-fsdevel+bounces-4802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF2280401C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 21:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5A1B20763
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 20:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C963935EE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+HENCPQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2798AB
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 10:53:32 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-423e95c2d54so26419571cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 10:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701716012; x=1702320812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0rF3UvVm24+J1RpS/OxR7vpWF7aBZSdC/exgzsi3rE=;
        b=G+HENCPQgm5GGLkGSbAlP+8RcAM+5B0pGSLuOuED0Mc3j0Biutd5oFOalpMuxpDasG
         lxBx2aXDj9FD5VmMkRBYh6gXYBY3DCDsYYmz4V6oWKzCVPjgVxJxlkCAmqtKCSH5UevD
         u/EliTHVN1qIh8fFEB1ncY2Uv2j5OozTwhxNOFc9rXmZkCmP6KwzUvj7IyoA7+wiH6Fd
         FEznRFd6kG/Ix5/FzIlkWXtGIWuq3x+zoZvuAk5+CaF+zCFP6MEe88XFN2E6NlojrnHp
         BsqAkrex7obDhAhw9JLAGvnyD5v7UxbTbB7rO3cisAQ3jjxGNQOkK3LivbmllWbgVvJ5
         n3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716012; x=1702320812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0rF3UvVm24+J1RpS/OxR7vpWF7aBZSdC/exgzsi3rE=;
        b=c1XEe5vpZeZukMO5WhhjevbaWOf4jQdEFzuPrev3YeS1wMuFSRsW246HkqZUBXHghM
         W+4dda3cO+UThp+OPfxAthjaip5Ofouj4oRyUA4fYvdnQcxOGPSoUM/OYxdKTFLoVKau
         iQMVEzsLe+XTlm4WwSoe3b9SkvGRzwmnzln+TApz7Zam/7RCu5M5ZBuhsaxclnD5Wc+Z
         9yiQ2Szjy9CfmhKQMRlLDVqByO1S4WjpTszX4dIM4WY1x9jqbtyl/GOsANo4Z3KAL07y
         274xSQWjKLBDZrfeJEVKuuApcpbWMJ5J1ztAIf35M0B28ymvzaviRoi5ad3BnECveqHT
         Zjog==
X-Gm-Message-State: AOJu0YxDiSAnRr38imRNkaBqljTCF3DVf6sKbsXk65seY4KTCSsJ78Dh
	PoW6zG7m4VQcaPV91SofBRidxspsvv0Ptqcd6IY7sGsgIAI=
X-Google-Smtp-Source: AGHT+IFki7sYtuXI4aSnIZP8JYr6jH6XjOY8y/s+1KsWX66V+X9GS8i/wHONsrkRIjd66xqeuXboW9vshyuz4dAg/Gw=
X-Received: by 2002:a05:6214:5801:b0:67a:212c:94a5 with SMTP id
 mk1-20020a056214580100b0067a212c94a5mr35111qvb.23.1701716012066; Mon, 04 Dec
 2023 10:53:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130141624.3338942-1-amir73il@gmail.com> <20231130141624.3338942-2-amir73il@gmail.com>
 <20231204083733.GA32438@lst.de> <20231204083849.GC32438@lst.de>
 <CAOQ4uxjZAjJSR-AUH+UQM3AX9Ota3DVxygFSVkpEQdxK15n_qQ@mail.gmail.com>
 <20231204140749.GB27396@lst.de> <CAOQ4uxg+agJ7ybOHfY5bKk_oi=f11zvPLzgnNF5zqZxnkTsUCA@mail.gmail.com>
 <20231204171646.fwfa2chhuj5qsesh@quack3>
In-Reply-To: <20231204171646.fwfa2chhuj5qsesh@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 Dec 2023 20:53:20 +0200
Message-ID: <CAOQ4uxj=Jxoj+=jZgob-uiouOeFWo+0PyptcmBZb=fE5zuVT-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fs: fork splice_file_range() from do_splice_direct()
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 7:16=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 04-12-23 16:29:02, Amir Goldstein wrote:
> > On Mon, Dec 4, 2023 at 4:07=E2=80=AFPM Christoph Hellwig <hch@lst.de> w=
rote:
> > > On Mon, Dec 04, 2023 at 03:29:43PM +0200, Amir Goldstein wrote:
> > > Well, splice_file_range makes sense if it is a separate helper.  But =
when
> > > is the default implementation for ->copy_file_range and matches the
> > > signature, naming it that way is not only sensible but required to ke=
ep
> > > sanity.
> > >
> >
> > It is NOT a default implementation of ->copy_file_range(), but
> > a fallback helper.
> > Specifically, it is never expected to have a filesystem that does
> > .copy_file_range =3D generic_copy_file_range,
> > so getting rid of generic_copy_file_range() would be good.
> >
> > Note also that generic_copy_file_range() gets a flags argument
> > that is COPY_FILE_* flags (currently only for the vfs level)
> > and this flags argument is NOT the splice flags argument, so
> > I intentionally removed the flags argument from splice_file_range()
> > to reduce confusion.
> >
> > I like the idea of moving MAX_RW_COUNT into splice_file_range()
> > and replacing generic_copy_file_range() calls with splice_file_range().
> >
> > I do not feel strongly against splice_copy_file_range() name, but
> > I would like to get feedback from other reviewers that approved the
> > name splice_file_range() before changing it.
>
> For me the name is not a big deal either way.

I would rather add this inline wrapper than uniting the two helpers:

static inline long splice_copy_file_range(struct file *in, loff_t pos_in,
                                          struct file *out, loff_t pos_out,
                                          size_t len)
{
        return splice_file_range(in, &pos_in, out, &pos_out,
                                      min_t(size_t, len, MAX_RW_COUNT));
}

It is keeping the same signature as copy_file_range() minus flags,
to be used for ->copy_file_range() fallback and keeps the current
splice_file_range() helpers for special cases as ceph that want to
update the in/out offset.

Thanks,
Amir.

