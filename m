Return-Path: <linux-fsdevel+bounces-674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68827CE361
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1ACE281491
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5803D398;
	Wed, 18 Oct 2023 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DStQVE1L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD6235885;
	Wed, 18 Oct 2023 17:06:07 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980A0B0;
	Wed, 18 Oct 2023 10:06:03 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so8227539276.0;
        Wed, 18 Oct 2023 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697648763; x=1698253563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d4Q67LG+T/tkfhiO4bR+Jgy5IZ6J++uVR4+ne6Y1sBw=;
        b=DStQVE1Lufq1pojvr7xLFSmfh7I5V7ywgqYTIVBZPtNu3uONw+ddAWwWUajV/ZaZpH
         +KuRWjBBBXUqG4qPppd9VWsTkb+MNTknfOMtfSlbYBOPNFckymX7HA06C6Nmw9xwo64d
         3sW8dCJh61U2/TH/2LOnZM5kaq+pPGy1cp8ug0NVjrZPsHGy96u1J1Hz8ZrfQdG80lTK
         EzdbOpj5y2RuUZeOtbhArQ6qI+l0X1Sk469UApe2Q+K7T0YE5+GtDT148yQH7C/volZj
         uqaYbupT1x66rbtn9cojV21MbQDLn0ecKA6iTopE/hW9nNKIJImZNpnxNJs+HlVFLgWE
         if9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648763; x=1698253563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4Q67LG+T/tkfhiO4bR+Jgy5IZ6J++uVR4+ne6Y1sBw=;
        b=t/5HcAcoJqdDnZOFQj200qoreeHxsLs8z///oXsD/1LH5p29sliyYLjdfvuyoo704N
         NJ2nQIIA4O13xsM1kEhVPuc3m35j3y9HK4qJkoF+rzflDCgo05aa0GzVpJ7a4QN2gc8G
         iltuTGN+6LGqO2228d7eeVsDkYfmApf5SEkHyuDXFEPF3jKfn2U7TnDCUJoXFe5XbQmu
         ZSEcdgxwsSeimvJOtXaUc3sbRqJtpSZ9hwibnotbymQ1/e3qCDxSNHTYIDDeIfb9R8wb
         25JnuhRRM4nBPpybhKe5eiNNwasxNt//UC6veooMkhKf3vU5JXBHlWNNkTChf6E7UgSp
         raMw==
X-Gm-Message-State: AOJu0Yyw6qlz4187NzTLKQ/6gv67WZNZKs8xyQ9UkDg1N4XsuLMGbciE
	DHPUv0nQOyR214WcMNanGjZtjqBP5dofAmLSZ/U=
X-Google-Smtp-Source: AGHT+IEhQ5YcbmoiA1MZG99NhODIKunrU/LOZArazzuQhPA+m+OCAV3RM5jSler2oQutmiVzvM+vKtwMQYfgAHN7bUw=
X-Received: by 2002:a25:1fc3:0:b0:d9a:c5f7:f848 with SMTP id
 f186-20020a251fc3000000b00d9ac5f7f848mr5272267ybf.63.1697648762651; Wed, 18
 Oct 2023 10:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-20-wedsonaf@gmail.com>
 <ZTAOfMvegVAc58Yn@casper.infradead.org>
In-Reply-To: <ZTAOfMvegVAc58Yn@casper.infradead.org>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 18 Oct 2023 14:05:51 -0300
Message-ID: <CANeycqqTgj_cVyRx1ZvGFjZjK0ACBUPobDk93ovP41DSXK2Xmg@mail.gmail.com>
Subject: Re: [RFC PATCH 19/19] tarfs: introduce tar fs
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 18 Oct 2023 at 13:57, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Oct 18, 2023 at 09:25:18AM -0300, Wedson Almeida Filho wrote:
> > +    fn read_folio(inode: &INode<Self>, mut folio: LockedFolio<'_>) -> Result {
> > +        let pos = u64::try_from(folio.pos()).unwrap_or(u64::MAX);
> > +        let size = u64::try_from(inode.size())?;
> > +        let sb = inode.super_block();
> > +
> > +        let copied = if pos >= size {
> > +            0
> > +        } else {
> > +            let offset = inode.data().offset.checked_add(pos).ok_or(ERANGE)?;
> > +            let len = core::cmp::min(size - pos, folio.size().try_into()?);
> > +            let mut foffset = 0;
> > +
> > +            if offset.checked_add(len).ok_or(ERANGE)? > sb.data().data_size {
> > +                return Err(EIO);
> > +            }
> > +
> > +            for v in sb.read(offset, len)? {
> > +                let v = v?;
> > +                folio.write(foffset, v.data())?;
> > +                foffset += v.data().len();
> > +            }
> > +            foffset
> > +        };
> > +
> > +        folio.zero_out(copied, folio.size() - copied)?;
> > +        folio.mark_uptodate();
> > +        folio.flush_dcache();
> > +
> > +        Ok(())
> > +    }
>
> Who unlocks the folio here?

The `Drop` implementation of `LockedFolio`.

Note that `read_folio` is given ownership of `folio` (the last
argument), so when it goes out of scope (or when it's explicitly
dropped) its `drop` function is called automatically. You'll its
implementation (and the call to `folio_unlock`) in patch 9.

