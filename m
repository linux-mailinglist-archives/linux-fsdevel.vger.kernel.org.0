Return-Path: <linux-fsdevel+bounces-27184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B8B95F3E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B881F2836EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA77017D35B;
	Mon, 26 Aug 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="qQj7pA63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41A3CF5E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682669; cv=none; b=n98cg0+CwU1ju1vP8aAHlwBo3laBT1WH1GzZipWPX9uyBSX9GTufFqrasU1O1Xhseuk9/jqmrn2GjgxrE9GidJs+IxFBogstSVkqjKMnUBILDcvmAom8Zne0DrLmY7yhhF45PDNC/bgV36Y9+kWSDDkXl4mnZYwjU+N8BZBqtLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682669; c=relaxed/simple;
	bh=m+DAXiAXRoYXLIl0ntrxCcIEyJVGkUk6cmnHaWHfl4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyGenhYuCSiYPiOb7DDeAGlP1sPsFgXNSB8tOFFCG5ZZzl2pWRUTZ5NV8a6IHBf/UQo9EkvECpI5Hl6b30pzzroTHpFEe27T5KtnIB1sPS6Kff+Fp0ifROQ9PqbSrNeUnbdxyZEongM6wS4ORup4eHOypITTmRUUmZ0gzJS62vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=qQj7pA63; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf66fe9d8bso20605946d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724682666; x=1725287466; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yUafkOkfTF/MtBgnU33NzXr4GUkk/r6kjneCB2AlwMY=;
        b=qQj7pA63e6V4ASNzRomoZ0b+e+/h4tLCNTReqgChV/eHmJx358MnI9Hm+Sd/GXS8nt
         aWE9u26Z8Mxj+ptW2o8tL9CCrmNFJTzadSdHJGWr++cYAHVjNbHkAPF0TEM73QKnx0EP
         iAvgjsaAZ4wFE6U6nDw/v/8plWnEv+d5w2UlgJVZ2XgfvPsyju1I2eRgoZf+yUKogfvF
         XWgAQ4aCaZ1WRRvSUaOJe2WaKnc8tb5CQmjrnIxL0ubr678RBq2Sd7fyDzp51U//rMV+
         rMHDYKSJCbeKEw2pnnJfitcCjZxbO8WGo+dUuSym2FV3o2L/NEcwWoTntNqGDzslESbP
         rcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682666; x=1725287466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUafkOkfTF/MtBgnU33NzXr4GUkk/r6kjneCB2AlwMY=;
        b=xSTWw3dTXmL8l0Tacad0/yQLjP8GaY5V93pbS6O9MvOlD5z0iQimVq3e0aRxPWSLth
         tiAreuYDSq6I7RkTtlXTH0+eoCcnX9RKPqcpxWsF0XkPREIlid7ua/60KsIWus3YipUe
         blJo6dc1tJBvLFXM8S+YfjJlF3MmyWve3VirXP4o6MgVMAcW+XzqIDk35708X3sOqNy+
         RmklegccLAluMFNT7TZn8enHH2P4eoZ5FkkvzmkzJPWZwoM0Q5pKUiwoUuQuBXKuXvTL
         rJqpPjZi733G84LIclvT3uK8H8qvkrQrjNIU/Qc6bvWPmL3WuFBhSfJOgFMju/c3LVRV
         5wUA==
X-Forwarded-Encrypted: i=1; AJvYcCUOK31h9d5cn5aAhR6u7p/9QCYBamO2WyOXRwMtnhvsNKJXkNHFD5pMPgB/8O1IPzvrxDbklyJOj0RquhGu@vger.kernel.org
X-Gm-Message-State: AOJu0YwrWTAlzMVCiHuAkczR5wYj5XjjfoKa9NyJ0/3v3KWmpOedDHv+
	yQogu8QOubOkEk57K4U+T/RWhTqDWi+Asdwe7FQWM56ILl2A8GPAOOK4nvF9Olk=
X-Google-Smtp-Source: AGHT+IGwx921YVklqQfbHvw/93RErEjSG1ES3xWwUzI3HbKc2TTQxWGTod+or+hvI8rbBr5m85j7pg==
X-Received: by 2002:a05:6214:4803:b0:6c1:5f1f:fea3 with SMTP id 6a1803df08f44-6c16ded56bdmr106437266d6.54.1724682666409;
        Mon, 26 Aug 2024 07:31:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d6548csm46308066d6.68.2024.08.26.07.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:31:05 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:31:05 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: Re: [PATCH v3 6/9] fuse: convert fuse_writepages_fill() to use a
 folio for its tmp page
Message-ID: <20240826143105.GD2393039@perftesting>
References: <20240823162730.521499-1-joannelkoong@gmail.com>
 <20240823162730.521499-7-joannelkoong@gmail.com>
 <20240823190346.GB2237731@perftesting>
 <CAJnrk1aU-iY+7v-b+=YJm_ajHFJjm2ZfsT_TwC2EJSy6zSn2uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aU-iY+7v-b+=YJm_ajHFJjm2ZfsT_TwC2EJSy6zSn2uQ@mail.gmail.com>

On Fri, Aug 23, 2024 at 02:38:02PM -0700, Joanne Koong wrote:
> On Fri, Aug 23, 2024 at 12:03 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Fri, Aug 23, 2024 at 09:27:27AM -0700, Joanne Koong wrote:
> > > To pave the way for refactoring out the shared logic in
> > > fuse_writepages_fill() and fuse_writepage_locked(), this change converts
> > > the temporary page in fuse_writepages_fill() to use the folio API.
> > >
> > > This is similar to the change in e0887e095a80 ("fuse: Convert
> > > fuse_writepage_locked to take a folio"), which converted the tmp page in
> > > fuse_writepage_locked() to use the folio API.
> > >
> > > inc_node_page_state() is intentionally preserved here instead of
> > > converting to node_stat_add_folio() since it is updating the stat of the
> > > underlying page and to better maintain API symmetry with
> > > dec_node_page_stat() in fuse_writepage_finish_stat().
> > >
> > > No functional changes added.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  fs/fuse/file.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index a51b0b085616..905b202a7acd 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -2260,7 +2260,7 @@ static int fuse_writepages_fill(struct folio *folio,
> > >       struct inode *inode = data->inode;
> > >       struct fuse_inode *fi = get_fuse_inode(inode);
> > >       struct fuse_conn *fc = get_fuse_conn(inode);
> > > -     struct page *tmp_page;
> > > +     struct folio *tmp_folio;
> > >       int err;
> > >
> > >       if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
> > > @@ -2269,8 +2269,8 @@ static int fuse_writepages_fill(struct folio *folio,
> > >       }
> > >
> > >       err = -ENOMEM;
> > > -     tmp_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> > > -     if (!tmp_page)
> > > +     tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
> > > +     if (!tmp_folio)
> > >               goto out_unlock;
> > >
> > >       /*
> > > @@ -2290,7 +2290,7 @@ static int fuse_writepages_fill(struct folio *folio,
> > >               err = -ENOMEM;
> > >               wpa = fuse_writepage_args_alloc();
> > >               if (!wpa) {
> > > -                     __free_page(tmp_page);
> > > +                     folio_put(tmp_folio);
> > >                       goto out_unlock;
> > >               }
> > >               fuse_writepage_add_to_bucket(fc, wpa);
> > > @@ -2308,14 +2308,14 @@ static int fuse_writepages_fill(struct folio *folio,
> > >       }
> > >       folio_start_writeback(folio);
> > >
> > > -     copy_highpage(tmp_page, &folio->page);
> > > -     ap->pages[ap->num_pages] = tmp_page;
> > > +     folio_copy(tmp_folio, folio);
> > > +     ap->pages[ap->num_pages] = &tmp_folio->page;
> > >       ap->descs[ap->num_pages].offset = 0;
> > >       ap->descs[ap->num_pages].length = PAGE_SIZE;
> > >       data->orig_pages[ap->num_pages] = &folio->page;
> > >
> > >       inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> > > -     inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
> > > +     inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
> >
> > I *think* you can use
> >
> > node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
> >
> > here instead of inc_node_page_state().  Thanks,
> 
> I was thinking inc_node_page_state() here would be better for
> preserving the API symmetry with the dec_node_page_state() function
> that gets called when the writeback gets finished (in
> fuse_writepage_finish_stat) - I don't think it's immediately obvious
> that node_stat_add_folio() and dec_node_page_state() are inverses of
> each other. I don't feel strongly about this though, so i'm happy to
> change this to node_stat_add_folio as well.

Ah yeah that's a good point, probably better to convert those in one shot so
everything is consistent.  Thanks,

Josef

