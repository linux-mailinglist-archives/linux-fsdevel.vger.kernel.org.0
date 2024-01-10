Return-Path: <linux-fsdevel+bounces-7682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90BA82947D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 08:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D651C25A65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A563A27E;
	Wed, 10 Jan 2024 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA3yTtlW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A733CD6;
	Wed, 10 Jan 2024 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbd715ed145so2809580276.1;
        Tue, 09 Jan 2024 23:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704872953; x=1705477753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hr0AWWYQkUrkL6ap7O3qzijmzqj8/77OpC1z83PqREo=;
        b=mA3yTtlW4K0s1vYki6fmJxMTRK+AsflWjAOtKzEhVQKMJK1OjYAO0t0N/VRe9airgo
         KqoneQalGVRKJ48zpc4njb2HNql8WAjAEZJANkkaXxqsh//Q4FfufjwBqpve9a3RNraN
         bkIbtWi4FyJpDs/0TL7/bUquu8isZnnkC31bgKSqOuzkuTlcKJ8kt3XGX3/EaGtRtXgo
         thntP76Yxjwy9dLMrGAplif/YHWElxmWMHntetV1JhSzHdxv2+pqsWEq/oyWykB01Wfz
         wHBWR1rA+lSjn+D6pGfooepoxqr6vhX160npfhchgPM7KmZmiFPEtJ9WwRuPdArro/fE
         TQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704872953; x=1705477753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hr0AWWYQkUrkL6ap7O3qzijmzqj8/77OpC1z83PqREo=;
        b=h2TYkK8a8/TutiH5vXIAAV//Cl373caRGFIhcQD/rm2a+Uy41Q/OjmNIefDo3hqD3b
         guczIvr9Zcj+T5w0aDJK3E8L1A/57HrJL0IUxDuikqbozlY89plOo0u+c2M+57Yhfjrk
         yIq2uSQTYC8/kUNPwu71zcrkmqlBX2Ceo5bYHiRPdTqkQyc2zQ29MSDEFjbPmybau0m6
         6PMefLtWvaVUjjS39PjRiXU8Vjx1jv9ZiFY2xkEen++y6D8YTFGy/RnLMn70Y8MqDMak
         aDs2XfM4wylAy88Ba2N0rlE3yVoiU1ML/samKQSyLoqciS3vEM6dOtbW2NH85ILs8D6t
         OXpg==
X-Gm-Message-State: AOJu0YyRacmOck4/OYGqBgoL/8dWK19VWrFIWhCJsPV0w8xOiPlDOI7m
	GlzSNMOOE++Zn3Rcim9zhJBqYIS7KAuPT18LhKI=
X-Google-Smtp-Source: AGHT+IGijgC4QR2qR0nbo6qn0JS6njHOhoW2/xKC7fKGq07U8a1iW+YKjIkG0NMVq0woAaYUK9kuX5bbiTpyoL0mi5M=
X-Received: by 2002:a05:6902:1005:b0:dbc:b69d:904f with SMTP id
 w5-20020a056902100500b00dbcb69d904fmr417405ybt.61.1704872952872; Tue, 09 Jan
 2024 23:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org> <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5>
 <20240103204131.GL1674809@ZenIV> <CANeycqrazDc_KKffx3c4C1yKCuSHU14v+L+2wq-pJq+frRf2wg@mail.gmail.com>
 <ZZ2dsiK77Se65wFY@casper.infradead.org> <2024010935-tycoon-baggage-a85b@gregkh>
In-Reply-To: <2024010935-tycoon-baggage-a85b@gregkh>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 10 Jan 2024 04:49:02 -0300
Message-ID: <CANeycqrubugocT0ZEhcUY4H+kytzhm-E4-PoWtvNobYr32auDA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jan 2024 at 16:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Jan 09, 2024 at 07:25:38PM +0000, Matthew Wilcox wrote:
> > You've misunderstood Greg.  He's saying (effectively) "No fs bindings
> > without a filesystem to use them".  And Al, myself and others are saying
> > "Your filesystem interfaces are wrong because they're not usable for real
> > filesystems".  And you're saying "But I'm not allowed to change them".
> > And that's not true.  Change them to be laid out how a real filesystem
> > would need them to be.

Ok, then I'll update the code to have 3 additional traits:

FileOperations
INodeOperations
AddressSpaceOperations

When one initialises an inode, one gets to pick all three.

And FileOperations::read_dir will take a File<T> as its first argument
(instead of an INode<T>).

Does this sound reasonable?

> Note, I agree, change them to work our a "real" filesystem would need
> them and then, automatically, all of the "fake" filesystems like
> currently underway (i.e. tarfs) will work just fine too, right?  That
> way we can drop the .c code for binderfs at the same time, also a nice
> win.

Are you volunteering to rewrite binderfs once rust bindings are available? :)

Cheers,
-Wedson

