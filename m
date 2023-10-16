Return-Path: <linux-fsdevel+bounces-403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9DD7CA819
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 14:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8131C20983
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D193273FC;
	Mon, 16 Oct 2023 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMXsnBpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E7273EB
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 12:35:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E80CAB
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697459716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnlyZ/CR5vsw8OMZxmx5aDd65PDqqyZREj3O4xB3j3o=;
	b=LMXsnBpKppCPhpZNf9G0UU8Gsfb6fg0pn4WCt6fUajakzWszMNmeExwxNfCCLxHpdelAcX
	I/8l2Uo3Ojd0vImjZLMfZ/2gj8mC1rFAF1y7a1+JrrcvsR4nq6Rvf3SIdpmA38G/9+FdLA
	WaDNTRTqChiY8UVsYd1uUHu01N5MMso=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-wm8dOpBPPXWpEaN8FSiAYg-1; Mon, 16 Oct 2023 08:35:15 -0400
X-MC-Unique: wm8dOpBPPXWpEaN8FSiAYg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-538128e18e9so3338782a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 05:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697459714; x=1698064514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnlyZ/CR5vsw8OMZxmx5aDd65PDqqyZREj3O4xB3j3o=;
        b=fRhJrlQFZfkx2TRwFNentr01s6iP9r0/0RRNQu5fc2+1ADzU9UuQP2eOvWN5JMSgfA
         NHvtTSc7EXp0fPR2zAB/bJaKYsQuHPWO7pyeeTILHviQ+ELnO77qO+5OA7KGUEB+SqtT
         I5RLR2E90P2tbhOtXhfZjEDx9vjIBLrB80mgsKwnYIZow2Gf9H9R8+zum4s6hN56XgSd
         ToPS7f9/nz3imm3xV9fcbDRFsRkbtB7q5k8UGlXrYKCg5AwnhePptZLjNgaLduUObioS
         c5fq2NBP1xSrxfNbuJxdu8VUBQwZWw2zup7scL0x+vGVzfQ0KDiXFqvWYXQeEwzCLDX8
         CJ6Q==
X-Gm-Message-State: AOJu0Yze3GUq5DeUEOuEbnXsGiyOr522GcWK2/RTj+8xUikcYIwe8dKC
	gTBDh8m2NVgY8xTWnm7ExdXP5L6PoTQfkZyyKzeLGhgZBTd23N4h1lIPxtXVxb9alf8LGeBKgnV
	wsPFYWO8EXqMJPOzDo1n38bpd
X-Received: by 2002:a17:907:785:b0:9bf:ad86:ece8 with SMTP id xd5-20020a170907078500b009bfad86ece8mr3919674ejb.25.1697459713995;
        Mon, 16 Oct 2023 05:35:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqAlWgKovauCzw+CvDXuoKXPDymeOPBUmFvlvX4u/xw/mh1KisWyrhFdlyfV1pcUFxK+1bRA==
X-Received: by 2002:a17:907:785:b0:9bf:ad86:ece8 with SMTP id xd5-20020a170907078500b009bfad86ece8mr3919659ejb.25.1697459713646;
        Mon, 16 Oct 2023 05:35:13 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090681c800b009be23a040cfsm3928853ejx.40.2023.10.16.05.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:35:13 -0700 (PDT)
Date: Mon, 16 Oct 2023 14:35:12 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 11/28] iomap: pass readpage operation to read path
Message-ID: <owraoh7xqk4dhf2mh4pdnh5iwh4on5asmwbpyg5nturzqnqcin@ticdzwwyj2kw>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-12-aalbersh@redhat.com>
 <20231011183117.GN21298@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011183117.GN21298@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-11 11:31:17, Darrick J. Wong wrote:
> On Fri, Oct 06, 2023 at 08:49:05PM +0200, Andrey Albershteyn wrote:
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 96dd0acbba44..3565c449f3c9 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -262,8 +262,25 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
> >  		struct iomap *iomap, loff_t pos, loff_t length, ssize_t written,
> >  		int (*punch)(struct inode *inode, loff_t pos, loff_t length));
> >  
> > -int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
> > -void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
> > +struct iomap_readpage_ops {
> > +	/*
> > +	 * Filesystems wishing to attach private information to a direct io bio
> > +	 * must provide a ->submit_io method that attaches the additional
> > +	 * information to the bio and changes the ->bi_end_io callback to a
> > +	 * custom function.  This function should, at a minimum, perform any
> > +	 * relevant post-processing of the bio and end with a call to
> > +	 * iomap_read_end_io.
> > +	 */
> > +	void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
> > +			loff_t file_offset);
> > +	struct bio_set *bio_set;
> 
> Needs a comment to mention that iomap will allocate bios from @bio_set
> if non-null; or its own internal bioset if null.

Sure.

> > +};
> 
> It's odd that this patch adds this ops structure but doesn't actually
> start using it until the next patch.

I wanted to separate iomap changes with xfs changes so it's easier
to go through, but I fine with merging these two.

-- 
- Andrey


