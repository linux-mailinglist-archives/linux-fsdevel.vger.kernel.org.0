Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6A5CFE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGBM7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 08:59:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44988 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfGBM7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:59:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id e3so8173522wrs.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2019 05:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Za7FT3ICUTHfwgx6cmpB1e+hHBkShVWKxLMf1FU2J4=;
        b=XgJGKQfCtYoJjGJ+5qyXYG21ds8pWt8QdOtSws3c7OnPdbKX6XGzXmFq8Iji/neXs2
         DeWOB497ScjZ4D02LIxos87l102dOG8tSHtRiKdoxoanahAe3ZhpfChbA347O87ZOjgX
         xM27UFl3bpVA89gsX/JCrS2JhYkShH3Bi56yStOxPtpgUIgKwV6QtgJH+FUsQBWYDAVA
         qsfaAdd0QfmZ7wKqeqGYZ4KPV1dZpL6yfGZYexLGkrnNndHBiHSWqQFcGrVd7a9Q6mCl
         LUx1C2YM5AUexzBO6NU+Xs6hqEitUiUz9VtdmUgkpCIxkXI4qPCa1qggl/VyNopQcuRs
         ncJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Za7FT3ICUTHfwgx6cmpB1e+hHBkShVWKxLMf1FU2J4=;
        b=edS+1bLsYOIYEJoGY4/xNU0ZF51o0o+XVyHwWfPVf+DyaH7KpRCd3UJ4mB+9z1TKDE
         h95aAbmgxn0b/plNYuPsmFvIt7A1cZcEcEt/DKH4sxckt4A3Mk9nLk+fgqMz7q7kb9MD
         NVKejVT8KeIYRkE0RLFLq0OV/q4uOmMpOYlPzo0a6G0rMF/UoFyNcjoRByNs1+cHNRgg
         G/LsSqFAbtwesjefUuvu4nXEiceav2S7rW0/Btt6jq61Bu9YP3UsV1xAJOdfiBHodIgV
         CQPTH6Us1+/jhuKxhiT90Jc0HlytdijBBwh85RU3YxS5e9pPP9Sg8iFXMNNYQ+qZVdAE
         6Log==
X-Gm-Message-State: APjAAAVpLevZr82PayrmnSXD3T/LXyq872Xy8Bc2DUjeBWyP8mo6UMg+
        dNLSE3EJgSKS668CuMXMR9vkOQ==
X-Google-Smtp-Source: APXvYqxyD7V7Qe95ff+Km9U8kAkrMH8e8QYY3ATIQpniBTjhSuBQmADBy4t5GLPYdVO+Sr6nbhwsIQ==
X-Received: by 2002:adf:aad1:: with SMTP id i17mr12158591wrc.63.1562072341259;
        Tue, 02 Jul 2019 05:59:01 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id j16sm3467181wrt.88.2019.07.02.05.58.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 05:59:00 -0700 (PDT)
Date:   Tue, 2 Jul 2019 14:58:59 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 01/11] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #15]
Message-ID: <20190702125858.ztxaj2m7ovcyonyk@brauner.io>
References: <20190701104048.c2t5aful2sabngmr@brauner.io>
 <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
 <156173662509.14042.3867242748127323502.stgit@warthog.procyon.org.uk>
 <27313.1561986796@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27313.1561986796@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 02:13:16PM +0100, David Howells wrote:
> Christian Brauner <christian@brauner.io> wrote:
> 
> > > +config FSINFO
> > 
> > Hm, any reason why we would hide that syscalls under a config option?
> 
> Rasmus Villemoes asked for it to be made conditional.

Ah, ok. I guess this is another case of "what about embedded users".
Fair enough.

> 
> https://lore.kernel.org/lkml/f3646774-ee9e-d5b7-8a11-670012034d59@rasmusvillemoes.dk/
> 
> > Do we, not have any dumb helpers for scenarios like this?:
> > 
> > #define strlen_literal(x) (sizeof(""x"") - 1)
> > #define strlen_array(x) (sizeof(x) - 1)
> 
> git grep doesn't find them under this name.

Yeah, than we don't have that. Might be worth having such helpers at
some point.

> 
> > > +	while (!signal_pending(current)) {
> > > +		params->usage = 0;
> > > +		ret = fsinfo(path, params);
> > > +		if (IS_ERR_VALUE((long)ret))
> > > +			return ret; /* Error */
> > > +		if ((unsigned int)ret <= params->buf_size)
> > 
> > if ((size_t)ret ...? Just for the sake of clarity if for nothing else.
> > 
> > > +			return ret; /* It fitted */
> > 
> > Ok, a little confused here, tbh. params->buf_size is size_t
> 
> It's "unsigned int".

Ok, good.

> 
> > and this function returns an int. Forgot whether you mentioned this before,
> > buf_size exceed can't exceed INT_MAX?
> 
> It's mentioned in the documentation (ie. fsinfo.rst).  I'll mention it in the
> comments adjacent to the attribute definition table also.

Thanks! I missed that apparently.

> 
> > Is it really wort it to have this code generating stuff in there?
> 
> From a readability PoV, yes, tabulation is awesome, IMO;-).  Up to 5 lines per
> attribute is too much vertical space and expanding it makes the whole thing
> much less readable.  Add to that that not all attributes will be the same
> number of lines.
> 
> It would be easier if the I could get away with making the constant names
> lower case, but the thou-shalt-capitalise-constantists dislike that, so, given
> that I don't know of a way to make the C preprocessor change the case of a
> symbol, I have to include both parts.
> 
> I have four pieces of information: type, depth, constant name, struct name (if
> applicable), and I can fit them on one line this way.
> 
> You really find this:
> 
> static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
> 	[FSINFO_ATTR_STATFS] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_SINGLE,
> 		.size	= sizeof(struct fsinfo_statfs)
> 	},
> 	[FSINFO_ATTR_FSINFO] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_SINGLE,
> 		.size	= sizeof(struct fsinfo_fsinfo)
> 	},
> 	[FSINFO_ATTR_IDS] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_SINGLE,
> 		.size	= sizeof(struct fsinfo_ids)
> 	},
> 	[FSINFO_ATTR_LIMITS] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_SINGLE,
> 		.size	= sizeof(struct fsinfo_limits)
> 	},
> 	[FSINFO_ATTR_CAPABILITIES] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_SINGLE,
> 		.size	= sizeof(struct fsinfo_capabilities)
> 	},
> 	[FSINFO_ATTR_SUPPORTS] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_SINGLE,
> 		.size	= sizeof(struct fsinfo_supports)
> 	},
> 	[FSINFO_ATTR_TIMESTAMP_INFO] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_SINGLE,
> 		.size	= sizeof(struct fsinfo_timestamp_info)
> 	},
> 	[FSINFO_ATTR_VOLUME_ID] = {
> 		.type	= __FSINFO_STRING,
> 		.flags	= __FSINFO_SINGLE,
> 	},
> 	[FSINFO_ATTR_VOLUME_UUID] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_SINGLE,
> 		.size	= sizeof(struct fsinfo_volume_uuid)
> 	},
> 	[FSINFO_ATTR_VOLUME_NAME] = {
> 		.type	= __FSINFO_STRING,
> 		.flags	= __FSINFO_SINGLE,
> 	},
> 	[FSINFO_ATTR_NAME_ENCODING] = {
> 		.type	= __FSINFO_STRING,
> 		.flags	= __FSINFO_SINGLE,
> 	},
> 	[FSINFO_ATTR_NAME_CODEPAGE] = {
> 		.type	= __FSINFO_STRING,
> 		.flags	= __FSINFO_SINGLE,
> 	},
> 	[FSINFO_ATTR_PARAM_DESCRIPTION] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_SINGLE,
> 		.size	= sizeof(struct fsinfo_param_description)
> 	},
> 	[FSINFO_ATTR_PARAM_SPECIFICATION] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_N,
> 		.size	= sizeof(struct fsinfo_param_specification)
> 	},
> 	[FSINFO_ATTR_PARAM_ENUM] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_N,
> 		.size	= sizeof(struct fsinfo_param_enum)
> 	},
> 	[FSINFO_ATTR_PARAMETERS] = {
> 		.type	= __FSINFO_OPAQUE,
> 		.flags	= __FSINFO_SINGLE,
> 	},
> 	[FSINFO_ATTR_LSM_PARAMETERS] = {
> 		.type	= __FSINFO_OPAQUE,
> 		.flags	= __FSINFO_SINGLE,
> 	},
> 	[FSINFO_ATTR_SERVER_NAME] = {
> 		.type	= __FSINFO_STRING,
> 		.flags	= __FSINFO_N,
> 	},
> 	[FSINFO_ATTR_SERVER_ADDRESS] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_NM,
> 		.size	= sizeof(struct fsinfo_server_address)
> 	},
> 	[FSINFO_ATTR_AFS_CELL_NAME] = {
> 		.type	= __FSINFO_STRING,
> 		.flags	= __FSINFO_SINGLE,
> 	},
> 	[FSINFO_ATTR_MOUNT_INFO] = {
> 		.type	= __FSINFO_STRUCT,
> 		.flags	= __FSINFO_SINGLE,
> 		.size	= sizeof(struct fsinfo_mount_info)
> 	},
> 	[FSINFO_ATTR_MOUNT_DEVNAME] = {
> 		.type	= __FSINFO_STRING,
> 		.flags	= __FSINFO_SINGLE,
> 	},
> 	[FSINFO_ATTR_MOUNT_CHILDREN] = {
> 		.type	= __FSINFO_STRUCT_ARRAY,
> 		.flags	= __FSINFO_SINGLE,
> 		.size	= sizeof(struct fsinfo_mount_child)
> 	},
> 	[FSINFO_ATTR_MOUNT_SUBMOUNT] = {
> 		.type	= __FSINFO_STRING,
> 		.flags	= __FSINFO_N,
> 	},
> };
> 
> is easier to read than this?:

Yes, very much so imho. :)

> 
> static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
> 	FSINFO_STRUCT		(STATFS,		statfs),
> 	FSINFO_STRUCT		(FSINFO,		fsinfo),
> 	FSINFO_STRUCT		(IDS,			ids),
> 	FSINFO_STRUCT		(LIMITS,		limits),
> 	FSINFO_STRUCT		(CAPABILITIES,		capabilities),
> 	FSINFO_STRUCT		(SUPPORTS,		supports),
> 	FSINFO_STRUCT		(TIMESTAMP_INFO,	timestamp_info),
> 	FSINFO_STRING		(VOLUME_ID),
> 	FSINFO_STRUCT		(VOLUME_UUID,		volume_uuid),
> 	FSINFO_STRING		(VOLUME_NAME),
> 	FSINFO_STRING		(NAME_ENCODING),
> 	FSINFO_STRING		(NAME_CODEPAGE),
> 	FSINFO_STRUCT		(PARAM_DESCRIPTION,	param_description),
> 	FSINFO_STRUCT_N		(PARAM_SPECIFICATION,	param_specification),
> 	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
> 	FSINFO_OPAQUE		(PARAMETERS),
> 	FSINFO_OPAQUE		(LSM_PARAMETERS),
> 	FSINFO_STRING_N		(SERVER_NAME),
> 	FSINFO_STRUCT_NM	(SERVER_ADDRESS,	server_address),
> 	FSINFO_STRING		(AFS_CELL_NAME),
> 	FSINFO_STRUCT		(MOUNT_INFO,		mount_info),
> 	FSINFO_STRING		(MOUNT_DEVNAME),
> 	FSINFO_STRUCT_ARRAY	(MOUNT_CHILDREN,	mount_child),
> 	FSINFO_STRING_N		(MOUNT_SUBMOUNT),
> };
> 
> The latter also has the advantage that I can take this and drop it into the
> test program and change the helper macros to make it do other things.  With
> the fully expanded code, that isn't possible.
> 
> One thing I will grant you, though, I can simplify:
> 
> #define __FSINFO_STRUCT		0
> #define __FSINFO_STRING		1
> #define __FSINFO_OPAQUE		2
> #define __FSINFO_STRUCT_ARRAY	3
> #define __FSINFO_0		0
> #define __FSINFO_N		0x0001
> #define __FSINFO_NM		0x0002
> 
> #define _Z(T, F, S) { .type = __FSINFO_##T, .flags = __FSINFO_##F, .size = S }
> #define FSINFO_STRING(X)	 [FSINFO_ATTR_##X] = _Z(STRING, 0, 0)
> #define FSINFO_STRUCT(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, 0, sizeof(struct fsinfo_##Y))
> #define FSINFO_STRING_N(X)	 [FSINFO_ATTR_##X] = _Z(STRING, N, 0)
> #define FSINFO_STRUCT_N(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, N, sizeof(struct fsinfo_##Y))
> #define FSINFO_STRING_NM(X)	 [FSINFO_ATTR_##X] = _Z(STRING, NM, 0)
> #define FSINFO_STRUCT_NM(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, NM, sizeof(struct fsinfo_##Y))
> #define FSINFO_OPAQUE(X)	 [FSINFO_ATTR_##X] = _Z(OPAQUE, 0, 0)
> #define FSINFO_STRUCT_ARRAY(X,Y) [FSINFO_ATTR_##X] = _Z(STRUCT_ARRAY, 0, sizeof(struct fsinfo_##Y))
> 
> a bit:
> 
> #define __FSINFO_STRUCT		0
> #define __FSINFO_STRING		1
> #define __FSINFO_OPAQUE		2
> #define __FSINFO_STRUCT_ARRAY	3
> #define __FSINFO_N		0x01
> #define __FSINFO_NM		0x02
> 
> #define _Z(T, S)    { .type = __FSINFO_##T, .flags = 0,		  .size = S }
> #define _Z_N(T, S)  { .type = __FSINFO_##T, .flags = __FSINFO_N,  .size = S }
> #define _Z_NM(T, S) { .type = __FSINFO_##T, .flags = __FSINFO_NM, .size = S }
> #define FSINFO_STRING(X)	 [FSINFO_ATTR_##X] = _Z(STRING, 0)
> #define FSINFO_STRUCT(X,Y)	 [FSINFO_ATTR_##X] = _Z(STRUCT, sizeof(struct fsinfo_##Y))
> #define FSINFO_STRING_N(X)	 [FSINFO_ATTR_##X] = _Z_N(STRING, 0)
> #define FSINFO_STRUCT_N(X,Y)	 [FSINFO_ATTR_##X] = _Z_N(STRUCT, sizeof(struct fsinfo_##Y))
> #define FSINFO_STRING_NM(X)	 [FSINFO_ATTR_##X] = _Z_NM(STRING, 0)
> #define FSINFO_STRUCT_NM(X,Y)	 [FSINFO_ATTR_##X] = _Z_NM(STRUCT, sizeof(struct fsinfo_##Y))
> #define FSINFO_OPAQUE(X)	 [FSINFO_ATTR_##X] = _Z(OPAQUE, 0)
> #define FSINFO_STRUCT_ARRAY(X,Y) [FSINFO_ATTR_##X] = _Z(STRUCT_ARRAY, sizeof(struct fsinfo_##Y))
> 
> > I urge you to think about git grep users. For them this is an absolute
> > nightmare. :)
> 
> That's a valid point, but it's a problem all over the kernel.  We use
> macroisation everywhere.  See all the declaration and define macros that nest
> layers deep.

Well maybe we can stop doing it (at least for some stuff). :)

> 
> If that's your main worry, The attribute type name could be fully expanded in
> the table, eg.:
> 
> 	FSINFO_STRUCT		(FSINFO_ATTR_CAPABILITIES,	capabilities),
> 	FSINFO_STRING_N		(FSINFO_ATTR_MOUNT_SUBMOUNT),
> 
> > > +	unsigned int result_size;
> > 
> > Wouldn't it be better if this could be a size_t?
> 
> Why?  size_t takes more space on a 64-bit system, but I'm not allowing the
> filesystem to return that much data, mainly because I don't really want to be
> allocating a >2G buffer.
> 
> In fact, for large objects there's something to be said for writing directly
> to userspace rather than going through a buffer, but for the fact that I want
> to hold, say, the RCU readlock across the entire transaction in some
> instances.
> 
> > > +	if (!user_buffer || !user_buf_size) {
> > 
> > Maybe we could be a little more strict and require both be set to their
> > respective zero values, i.e. only support reporting the size if
> > !user_buffer && user_buf_size = 0 for that to work. If only one of them
> > is set to their zero value we report EINVAL.
> 
> That's an option, certainly.

Ok, up to you. I find my suggestion a little cleaner.

> 
> > Hm, I'm not sure that "capabilities" is a good name here. This is
> > potentially misleading because of other uses of "capabilities" we
> > already have. Like, I don't want thes capabilities to pop up when I do
> > git grep capabilities. Just a short way until someone also speaks of
> > "fscaps" or "fsinfocaps" and then confusion is basically guaranteed. :)
> > 
> > Maybe "features" would be better?
> 
> Yeah - that's probably better.  The only issue is that it doesn't have a nice
> short hypocoristicon like "cap", though I could use "feat" I guess.

FEAT is probably ok. Not pretty but "cap" isn't either. 

> 
> > > +#define _ATFILE_SOURCE
> > 
> > nit: Defining fsinfoat() implicitly or what's that supposed to do? If that's
> > the case wouldn't it be nicer to just explicitly declare fsinfoat()
> 
> Um...  fsinfo() takes AT_* flags.  It's fsinfoat(), ffsinfo() and lfsinfo()
> all rolled into one, plus a couple of extra bits.  It doesn't really need an
> at-suffix on the name as there's no at-less original.

Ah, seems like a very ancient macro...
