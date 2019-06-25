Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA5052863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFYJoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 05:44:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38976 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfFYJoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:44:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so2230053wma.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bydo2op0dEgUZuz3qW1iTjTnv7PZTnBhu3PVuy5btRI=;
        b=ZQiQ3l2DAOdTJcoC1/Rsa9r+oooT/9ohiTlXeViOLYljBKqXmmxSnzM1i1GdrEciOp
         xbGsiJI4Rm/eKlyR7IoQN8NZ5tVAnBuPfKadcdUywwAc7vrSBif7OtHBO0Mzqhv8ZTZw
         nswaxWmYfKddj1aNCNntl0JDid41iE3UJX12wR8hyscyqFkfwGwAenyS01/Lg6MaeOv8
         IE8br5WXbq2r++Rb1aD8/72p25sVF6mYX1E6r0AWZ1TaO0cfwaCMTuCDuDTZVBYEt+iI
         YLzkgQb1FKPdnH4QeiTlvPghLn7+FoAQT0zOpeTzLKdKuFSrBdM6TTJHZ4tLnLRQmj4F
         nVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bydo2op0dEgUZuz3qW1iTjTnv7PZTnBhu3PVuy5btRI=;
        b=EpKtT+fKIrgExO06NuYoPFwcDn7AgH9fRRwIynUbdWZtavZK8op/7lpTtqGaGyVJ3P
         YWJHW2hnpULlYkhBTy3iI4Ke0wn4Suq+/W27swq0zlc0imXBPKFX2NFKznK36lahCdNn
         8fiMcVAFZ6EE/Q9zKThOKYB0bClbjg/3ov+z+bcJzfii6ayx+5KwZCinGjXWT5KjrALM
         jr/GnK2qWnoFHalgLtBkR8LqejvtolIMrWJis96FFpl/l60a7kojeDUNQQ23JssL+9tR
         TReX/RKDWGISK4wv1xvgyF57ZHarbOCf9USvo9lhv61XOeAE/u6zF6hpVD/T9uwGR5qN
         UWIQ==
X-Gm-Message-State: APjAAAUPwbYLY4NGH0IzHN6lEwX0nXRjWPabufg32yOHYBME2aUCxv3y
        k1hXfl9AvwPBkT74Bfck4GoExA==
X-Google-Smtp-Source: APXvYqzbbgxKqnWuULE98jTvZIu0mIK3QI2A9La+GcuSzjbQENnr1OIn9sUivIDTIuXJLnW+iQP4eQ==
X-Received: by 2002:a1c:a483:: with SMTP id n125mr18675831wme.172.1561455857585;
        Tue, 25 Jun 2019 02:44:17 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id q1sm1859824wmq.25.2019.06.25.02.44.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 02:44:17 -0700 (PDT)
Date:   Tue, 25 Jun 2019 11:44:16 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] vfs: Implement parameter value retrieval with
 fsinfo() [ver #14]
Message-ID: <20190625094415.lv4tw26isxziflxp@brauner.io>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
 <156138537329.25627.5525420330768463735.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156138537329.25627.5525420330768463735.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:09:33PM +0100, David Howells wrote:
> Implement parameter value retrieval with fsinfo() - akin to parsing
> /proc/mounts.
> 
> This allows all the parameters to be retrieved in one go with:
> 
> 	struct fsinfo_params params = {
> 		.request	= FSINFO_ATTR_PARAMETER,
> 	};
> 
> Each parameter comes as a pair of blobs with a length tacked on the front
> rather than using separators, since any printable character that could be
> used as a separator can be found in some value somewhere (including comma).
> In fact, cifs allows the separator to be set using the "sep=" option in
> parameter parsing.
> 
> The length on the front of each blob is 1-3 bytes long.  Each byte has a
> flag in bit 7 that's set if there are more bytes and clear on the last
> byte; bits 0-6 should be shifted and OR'd into the length count.  The bytes
> are most-significant first.
> 
> For example, 0x83 0xf5 0x06 is the length (0x03<<14 | 0x75<<7 | 0x06).

Ok, but that is such a royal pain for userspace. Shouldn't we export a
uapi helper that they can use to parse out the length or even iterate
the string or something?

> 
> As mentioned, each parameter comes as a pair of blobs in key, value order.
> The value has length zero if not present.  So, for example:
> 
> 	\x08compress\x04zlib
> 
> from btrfs would be equivalent to "compress=zlib" and:
> 
> 	\x02ro\x00\x06noexec\x00
> 
> would be equivalent to "ro,noexec".
> 
> The test-fsinfo sample program is modified to dump the parameters.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/fsinfo.c                 |  122 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fsinfo.h      |    4 +
>  include/uapi/linux/fsinfo.h |    1 
>  samples/vfs/test-fsinfo.c   |   38 +++++++++++++
>  4 files changed, 165 insertions(+)
> 
> diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> index 9e2a25510b88..3b35cedab0df 100644
> --- a/fs/fsinfo.c
> +++ b/fs/fsinfo.c
> @@ -296,6 +296,32 @@ static int fsinfo_generic_param_enum(struct file_system_type *f,
>  	return sizeof(*p);
>  }
>  
> +void fsinfo_note_sb_params(struct fsinfo_kparams *params, unsigned int s_flags)
> +{
> +	if (s_flags & SB_DIRSYNC)
> +		fsinfo_note_param(params, "dirsync", NULL);
> +	if (s_flags & SB_LAZYTIME)
> +		fsinfo_note_param(params, "lazytime", NULL);
> +	if (s_flags & SB_MANDLOCK)
> +		fsinfo_note_param(params, "mand", NULL);
> +	if (s_flags & SB_POSIXACL)
> +		fsinfo_note_param(params, "posixacl", NULL);
> +	if (s_flags & SB_RDONLY)
> +		fsinfo_note_param(params, "ro", NULL);
> +	else
> +		fsinfo_note_param(params, "rw", NULL);
> +	if (s_flags & SB_SYNCHRONOUS)
> +		fsinfo_note_param(params, "sync", NULL);
> +}
> +EXPORT_SYMBOL(fsinfo_note_sb_params);
> +
> +static int fsinfo_generic_parameters(struct path *path,
> +				     struct fsinfo_kparams *params)
> +{
> +	fsinfo_note_sb_params(params, READ_ONCE(path->dentry->d_sb->s_flags));
> +	return params->usage;
> +}
> +
>  /*
>   * Implement some queries generically from stuff in the superblock.
>   */
> @@ -304,6 +330,7 @@ int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
>  	struct file_system_type *fs = path->dentry->d_sb->s_type;
>  
>  #define _gen(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(path, params->buffer)
> +#define _genp(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(path, params)
>  #define _genf(X, Y) FSINFO_ATTR_##X: return fsinfo_generic_##Y(fs, params)
>  
>  	switch (params->request) {
> @@ -319,6 +346,7 @@ int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
>  	case _genf(PARAM_DESCRIPTION,	param_description);
>  	case _genf(PARAM_SPECIFICATION,	param_specification);
>  	case _genf(PARAM_ENUM,		param_enum);
> +	case _genp(PARAMETERS,		parameters);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -358,8 +386,16 @@ static int vfs_fsinfo(struct path *path, struct fsinfo_kparams *params)
>  		return fsinfo(path, params);
>  
>  	while (!signal_pending(current)) {
> +		if (params->request == FSINFO_ATTR_PARAMETERS) {
> +			if (down_read_killable(&dentry->d_sb->s_umount) < 0)
> +				return -ERESTARTSYS;
> +		}
> +
>  		params->usage = 0;
>  		ret = fsinfo(path, params);
> +		if (params->request == FSINFO_ATTR_PARAMETERS)
> +			up_read(&dentry->d_sb->s_umount);
> +
>  		if (ret <= (int)params->buf_size)
>  			return ret; /* Error or it fitted */
>  		kvfree(params->buffer);
> @@ -529,6 +565,7 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
>  	FSINFO_STRUCT		(PARAM_DESCRIPTION,	param_description),
>  	FSINFO_STRUCT_N		(PARAM_SPECIFICATION,	param_specification),
>  	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
> +	FSINFO_OPAQUE		(PARAMETERS,		-),
>  };
>  
>  /**
> @@ -676,3 +713,88 @@ SYSCALL_DEFINE5(fsinfo,
>  error:
>  	return ret;
>  }
> +
> +/*
> + * Store a parameter into the user's parameter buffer.  The key is prefixed by
> + * a single byte length (1-127) and the value by one (0-0x7f) or two bytes
> + * (0x80-0x3fff) or three bytes (0x4000-0x1fffff).
> + *
> + * Note that we must always make the size determination, even if the buffer is
> + * already full, so that we can tell the caller how much buffer we actually
> + * need.
> + */
> +static void __fsinfo_note_param(struct fsinfo_kparams *params, const char *key,
> +				const char *val, unsigned int vlen)
> +{
> +	char *p;
> +	unsigned int usage;
> +	int klen, total, vmeta;
> +	u8 x;
> +
> +	klen = strlen(key);
> +	BUG_ON(klen < 1 || klen > 127);
> +	BUG_ON(vlen > (1 << 21) - 1);
> +	BUG_ON(vlen > 0 && !val);
> +
> +	vmeta = (vlen <= 127) ? 1 : (vlen <= 127 * 127) ? 2 : 3;
> +
> +	total = 1 + klen + vmeta + vlen;
> +
> +	usage = params->usage;
> +	params->usage = usage + total;
> +	if (!params->buffer || params->usage > params->buf_size)
> +		return;
> +
> +	p = params->buffer + usage;
> +	*p++ = klen;
> +	p = memcpy(p, key, klen);
> +	p += klen;
> +
> +	/* The more significant groups of 7 bits in the size are included in
> +	 * most->least order with 0x80 OR'd in.  The least significant 7 bits
> +	 * are last with the top bit clear.
> +	 */
> +	x = vlen >> 14;
> +	if (x & 0x7f)
> +		*p++ = 0x80 | x;
> +
> +	x = vlen >> 7;
> +	if (x & 0x7f)
> +		*p++ = 0x80 | x;
> +
> +	*p++ = vlen & 0x7f;
> +	memcpy(p, val, vlen);
> +}
> +
> +/**
> + * fsinfo_note_param - Store a parameter for FSINFO_ATTR_PARAMETERS
> + * @params: The parameter buffer
> + * @key: The parameter's key
> + * @val: The parameter's value (or NULL)
> + */
> +void fsinfo_note_param(struct fsinfo_kparams *params, const char *key,
> +		       const char *val)
> +{
> +	__fsinfo_note_param(params, key, val, val ? strlen(val) : 0);
> +}
> +EXPORT_SYMBOL(fsinfo_note_param);
> +
> +/**
> + * fsinfo_note_paramf - Store a formatted parameter for FSINFO_ATTR_PARAMETERS
> + * @params: The parameter buffer
> + * @key: The parameter's key
> + * @val_fmt: Format string for the parameter's value
> + */
> +void fsinfo_note_paramf(struct fsinfo_kparams *params, const char *key,
> +			const char *val_fmt, ...)
> +{
> +	va_list va;
> +	int n;
> +
> +	va_start(va, val_fmt);
> +	n = vsnprintf(params->scratch_buffer, 4096, val_fmt, va);
> +	va_end(va);
> +
> +	__fsinfo_note_param(params, key, params->scratch_buffer, n);
> +}
> +EXPORT_SYMBOL(fsinfo_note_paramf);
> diff --git a/include/linux/fsinfo.h b/include/linux/fsinfo.h
> index e17e4f0bae18..731931afbf1c 100644
> --- a/include/linux/fsinfo.h
> +++ b/include/linux/fsinfo.h
> @@ -29,6 +29,10 @@ struct fsinfo_kparams {
>  };
>  
>  extern int generic_fsinfo(struct path *, struct fsinfo_kparams *);
> +extern void fsinfo_note_sb_params(struct fsinfo_kparams *, unsigned int);
> +extern void fsinfo_note_param(struct fsinfo_kparams *, const char *, const char *);
> +extern void fsinfo_note_paramf(struct fsinfo_kparams *, const char *, const char *, ...)
> +	__printf(3, 4);
>  
>  static inline void fsinfo_set_cap(struct fsinfo_capabilities *c,
>  				  enum fsinfo_capability cap)
> diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
> index 9d929d2f7eee..475cd1c97b12 100644
> --- a/include/uapi/linux/fsinfo.h
> +++ b/include/uapi/linux/fsinfo.h
> @@ -30,6 +30,7 @@ enum fsinfo_attribute {
>  	FSINFO_ATTR_PARAM_DESCRIPTION	= 12,	/* General fs parameter description */
>  	FSINFO_ATTR_PARAM_SPECIFICATION	= 13,	/* Nth parameter specification */
>  	FSINFO_ATTR_PARAM_ENUM		= 14,	/* Nth enum-to-val */
> +	FSINFO_ATTR_PARAMETERS		= 15,	/* Mount parameters (large string) */
>  	FSINFO_ATTR__NR
>  };
>  
> diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
> index 3c6ea3a5c157..8cf5b02e333a 100644
> --- a/samples/vfs/test-fsinfo.c
> +++ b/samples/vfs/test-fsinfo.c
> @@ -81,6 +81,7 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
>  	FSINFO_STRUCT		(PARAM_DESCRIPTION,	param_description),
>  	FSINFO_STRUCT_N		(PARAM_SPECIFICATION,	param_specification),
>  	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
> +	FSINFO_OVERLARGE	(PARAMETERS,		-),
>  };
>  
>  #define FSINFO_NAME(X,Y) [FSINFO_ATTR_##X] = #Y
> @@ -100,6 +101,7 @@ static const char *fsinfo_attr_names[FSINFO_ATTR__NR] = {
>  	FSINFO_NAME		(PARAM_DESCRIPTION,	param_description),
>  	FSINFO_NAME		(PARAM_SPECIFICATION,	param_specification),
>  	FSINFO_NAME		(PARAM_ENUM,		param_enum),
> +	FSINFO_NAME		(PARAMETERS,		parameters),
>  };
>  
>  union reply {
> @@ -352,6 +354,34 @@ static void dump_fsinfo(enum fsinfo_attribute attr,
>  	dumper(r, size);
>  }
>  
> +static void dump_params(struct fsinfo_attr_info about, union reply *r, int size)
> +{
> +	int len;
> +	char *p = r->buffer, *e = p + size;
> +	bool is_key = true;
> +
> +	while (p < e) {
> +		len = 0;
> +		while (p[0] & 0x80) {
> +			len <<= 7;
> +			len |= *p++ & 0x7f;
> +		}
> +
> +		len <<= 7;
> +		len |= *p++;
> +		if (len > e - p)
> +			break;
> +		if (is_key || len)
> +			printf("%s%*.*s", is_key ? "[PARM] " : "= ", len, len, p);
> +		if (is_key)
> +			putchar(' ');
> +		else
> +			putchar('\n');
> +		p += len;
> +		is_key = !is_key;
> +	}
> +}
> +
>  /*
>   * Try one subinstance of an attribute.
>   */
> @@ -427,6 +457,12 @@ static int try_one(const char *file, struct fsinfo_params *params, bool raw)
>  		return 0;
>  	}
>  
> +	switch (params->request) {
> +	case FSINFO_ATTR_PARAMETERS:
> +		if (ret == 0)
> +			return 0;
> +	}
> +
>  	switch (about.flags & (__FSINFO_N | __FSINFO_NM)) {
>  	case 0:
>  		printf("\e[33m%s\e[m: ",
> @@ -469,6 +505,8 @@ static int try_one(const char *file, struct fsinfo_params *params, bool raw)
>  		return 0;
>  
>  	case __FSINFO_OVER:
> +		if (params->request == FSINFO_ATTR_PARAMETERS)
> +			dump_params(about, r, ret);
>  		return 0;
>  
>  	case __FSINFO_STRUCT_ARRAY:
> 
