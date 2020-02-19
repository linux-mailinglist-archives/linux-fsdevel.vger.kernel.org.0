Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 485D8164F8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 21:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgBSUHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 15:07:41 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37910 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgBSUHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:07:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id r137so5525767oie.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 12:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsjzchhhyvUFJIy0oLPVbK5OuRfi6cC0og4QlfYyVOo=;
        b=LLVJjnUF5S8Fi2UI4Zxvt9/e4fgVq0mM80LYhvtmacBI1WnRfWwwdP/Uc34ENCIVjm
         VBrcCZy/vWhJaiTSFE7XN6lywqznBDKiJLrcjsTSqXMzHxz6yvmp0eGdE3DK1JwzqbID
         jKCn+0alTN1JNanidXo7TrdAThlm3zcM2sBna4Rjg6qGDNaxzx6PRyphsYaHHm/IALf0
         u+iMrDbUNPODuypJgN1LMnAXSl+DlBAD0kYtDRixMD611l01qh57H6eT7D9tzxwkBbTp
         phO6QkaLdrdok29LrYViPR12E41Y0GHczvjfVEP2oHtx0Ip1tzQMNhV8y3iXMLIdEu5o
         zlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsjzchhhyvUFJIy0oLPVbK5OuRfi6cC0og4QlfYyVOo=;
        b=qXgrI7SRMfNupW9Ez3s9OxFMkH2xIGkvzbJNsfNqUOfpxbA3orFTbJKH5Uz7M1VAUb
         nWASMBWetHg2Cu+4n6/qG4Y5y8kBJlXBBd6YUyJkASIRRchFtugPZp7cM2dwDWINR2n7
         xdO6zJiDVS1z5sF93gfkrcC6qJceUJyxsDQyqcXBmuHJbnkl66gfr0DToFATfRtfIZbj
         CyJINTkPilNksccSM8A5GbJDotG9VcbUL8Hf6Om7KOi/KMEnPpEd3VWgJjG8c3D/GccW
         bjiz3cKeh3BNVeNzwgv+H5W84wrLiBCKelq8/rC8pH9jCJDctinmrZLAEspQD39qxozV
         TOug==
X-Gm-Message-State: APjAAAWUaTt69km2NFMrLVmLvNR0Sr8dBhR+v4S8qijdIa0kfJEkmSCs
        9rbopFL6+8vJG/d8zJYXKlPnFmYVzJyq3KjX1qFG8A==
X-Google-Smtp-Source: APXvYqxGb14AZDfGn28Et5c7WU6/PV82oaP46pOorUlMz1aXLbjCmOn8TpEelTga3JSRn8xT+enzbxwYr2tp8IQ5bQc=
X-Received: by 2002:a05:6808:8d0:: with SMTP id k16mr5750652oij.68.1582142858222;
 Wed, 19 Feb 2020 12:07:38 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204550281.3299825.6344518327575765653.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204550281.3299825.6344518327575765653.stgit@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Feb 2020 21:07:11 +0100
Message-ID: <CAG48ez0o3iHjQJNvh8V2Ao77g0CqfqGsv6caMCOFDy7w-VdtkQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #16]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 6:05 PM David Howells <dhowells@redhat.com> wrote:
> Add a system call to allow filesystem information to be queried.  A request
> value can be given to indicate the desired attribute.  Support is provided
> for enumerating multi-value attributes.
[...]
> +static const struct fsinfo_attribute fsinfo_common_attributes[];
> +
> +/**
> + * fsinfo_string - Store a string as an fsinfo attribute value.
> + * @s: The string to store (may be NULL)
> + * @ctx: The parameter context
> + */
> +int fsinfo_string(const char *s, struct fsinfo_context *ctx)
> +{
> +       int ret = 0;
> +
> +       if (s) {
> +               ret = strlen(s);
> +               memcpy(ctx->buffer, s, ret);
> +       }
> +
> +       return ret;
> +}

Please add a check here to ensure that "ret" actually fits into the
buffer (and use WARN_ON() if you think the check should never fire).
Otherwise I think this is too fragile.

[...]
> +static int fsinfo_generic_ids(struct path *path, struct fsinfo_context *ctx)
> +{
> +       struct fsinfo_ids *p = ctx->buffer;
> +       struct super_block *sb;
> +       struct kstatfs buf;
> +       int ret;
> +
> +       ret = vfs_statfs(path, &buf);
> +       if (ret < 0 && ret != -ENOSYS)
> +               return ret;

What's going on here? If vfs_statfs() returns -ENOSYS, we just use the
(AFAICS uninitialized) buf.f_fsid anyway in the memcpy() below and
return it to userspace?

> +       sb = path->dentry->d_sb;
> +       p->f_fstype     = sb->s_magic;
> +       p->f_dev_major  = MAJOR(sb->s_dev);
> +       p->f_dev_minor  = MINOR(sb->s_dev);
> +
> +       memcpy(&p->f_fsid, &buf.f_fsid, sizeof(p->f_fsid));
> +       strlcpy(p->f_fs_name, path->dentry->d_sb->s_type->name,
> +               sizeof(p->f_fs_name));
> +       return sizeof(*p);
> +}
[...]
> +static int fsinfo_attribute_info(struct path *path, struct fsinfo_context *ctx)
> +{
> +       const struct fsinfo_attribute *attr;
> +       struct fsinfo_attribute_info *info = ctx->buffer;
> +       struct dentry *dentry = path->dentry;
> +
> +       if (dentry->d_sb->s_op->fsinfo_attributes)
> +               for (attr = dentry->d_sb->s_op->fsinfo_attributes; attr->get; attr++)
> +                       if (attr->attr_id == ctx->Nth)
> +                               goto found;
> +       for (attr = fsinfo_common_attributes; attr->get; attr++)
> +               if (attr->attr_id == ctx->Nth)
> +                       goto found;
> +       return -ENODATA;
> +
> +found:
> +       info->attr_id           = attr->attr_id;
> +       info->type              = attr->type;
> +       info->flags             = attr->flags;
> +       info->size              = attr->size;
> +       info->element_size      = attr->element_size;
> +       return sizeof(*attr);

I think you meant sizeof(*info).

[...]
> +static int fsinfo_attributes(struct path *path, struct fsinfo_context *ctx)
> +{
> +       const struct fsinfo_attribute *attr;
> +       struct super_block *sb = path->dentry->d_sb;
> +
> +       if (sb->s_op->fsinfo_attributes)
> +               for (attr = sb->s_op->fsinfo_attributes; attr->get; attr++)
> +                       fsinfo_attributes_insert(ctx, attr);
> +       for (attr = fsinfo_common_attributes; attr->get; attr++)
> +               fsinfo_attributes_insert(ctx, attr);
> +       return ctx->usage;

It is kind of weird that you have to return the ctx->usage everywhere
even though the caller already has ctx...

> +}
> +
> +static const struct fsinfo_attribute fsinfo_common_attributes[] = {
> +       FSINFO_VSTRUCT  (FSINFO_ATTR_STATFS,            fsinfo_generic_statfs),
> +       FSINFO_VSTRUCT  (FSINFO_ATTR_IDS,               fsinfo_generic_ids),
> +       FSINFO_VSTRUCT  (FSINFO_ATTR_LIMITS,            fsinfo_generic_limits),
> +       FSINFO_VSTRUCT  (FSINFO_ATTR_SUPPORTS,          fsinfo_generic_supports),
> +       FSINFO_VSTRUCT  (FSINFO_ATTR_TIMESTAMP_INFO,    fsinfo_generic_timestamp_info),
> +       FSINFO_STRING   (FSINFO_ATTR_VOLUME_ID,         fsinfo_generic_volume_id),
> +       FSINFO_VSTRUCT  (FSINFO_ATTR_VOLUME_UUID,       fsinfo_generic_volume_uuid),
> +       FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, fsinfo_attribute_info),
> +       FSINFO_LIST     (FSINFO_ATTR_FSINFO_ATTRIBUTES, fsinfo_attributes),
> +       {}
> +};
> +
> +/*
> + * Retrieve large filesystem information, such as an opaque blob or array of
> + * struct elements where the value isn't limited to the size of a page.
> + */
> +static int vfs_fsinfo_large(struct path *path, struct fsinfo_context *ctx,
> +                           const struct fsinfo_attribute *attr)
> +{
> +       int ret;
> +
> +       while (!signal_pending(current)) {
> +               ctx->usage = 0;
> +               ret = attr->get(path, ctx);
> +               if (IS_ERR_VALUE((long)ret))
> +                       return ret; /* Error */
> +               if ((unsigned int)ret <= ctx->buf_size)
> +                       return ret; /* It fitted */
> +
> +               /* We need to resize the buffer */
> +               kvfree(ctx->buffer);
> +               ctx->buffer = NULL;
> +               ctx->buf_size = roundup(ret, PAGE_SIZE);
> +               if (ctx->buf_size > INT_MAX)
> +                       return -EMSGSIZE;
> +               ctx->buffer = kvmalloc(ctx->buf_size, GFP_KERNEL);

ctx->buffer is _almost_ always pre-zeroed (see vfs_do_fsinfo() below),
except if we have FSINFO_TYPE_OPAQUE or FSINFO_TYPE_LIST with a size
bigger than what the attribute's ->size field said? Is that
intentional?

> +               if (!ctx->buffer)
> +                       return -ENOMEM;
> +       }
> +
> +       return -ERESTARTSYS;
> +}
> +
> +static int vfs_do_fsinfo(struct path *path, struct fsinfo_context *ctx,
> +                        const struct fsinfo_attribute *attr)
> +{
> +       if (ctx->Nth != 0 && !(attr->flags & (FSINFO_FLAGS_N | FSINFO_FLAGS_NM)))
> +               return -ENODATA;
> +       if (ctx->Mth != 0 && !(attr->flags & FSINFO_FLAGS_NM))
> +               return -ENODATA;
> +
> +       ctx->buf_size = attr->size;
> +       if (ctx->want_size_only && attr->type == FSINFO_TYPE_VSTRUCT)
> +               return attr->size;
> +
> +       ctx->buffer = kvzalloc(ctx->buf_size, GFP_KERNEL);
> +       if (!ctx->buffer)
> +               return -ENOMEM;
> +
> +       switch (attr->type) {
> +       case FSINFO_TYPE_VSTRUCT:
> +               ctx->clear_tail = true;
> +               /* Fall through */
> +       case FSINFO_TYPE_STRING:
> +               return attr->get(path, ctx);
> +
> +       case FSINFO_TYPE_OPAQUE:
> +       case FSINFO_TYPE_LIST:
> +               return vfs_fsinfo_large(path, ctx, attr);
> +
> +       default:
> +               return -ENOPKG;
> +       }
> +}
[...]
> +SYSCALL_DEFINE5(fsinfo,
> +               int, dfd, const char __user *, pathname,
> +               struct fsinfo_params __user *, params,
> +               void __user *, user_buffer, size_t, user_buf_size)
> +{
[...]
> +       if (ret < 0)
> +               goto error;
> +
> +       result_size = ret;
> +       if (result_size > user_buf_size)
> +               result_size = user_buf_size;

This is "result_size = min_t(size_t, ret, user_buf_size)".

[...]
> +/*
> + * A filesystem information attribute definition.
> + */
> +struct fsinfo_attribute {
> +       unsigned int            attr_id;        /* The ID of the attribute */
> +       enum fsinfo_value_type  type:8;         /* The type of the attribute's value(s) */
> +       unsigned int            flags:8;
> +       unsigned int            size:16;        /* - Value size (FSINFO_STRUCT) */
> +       unsigned int            element_size:16; /* - Element size (FSINFO_LIST) */
> +       int (*get)(struct path *path, struct fsinfo_context *params);
> +};

Why the bitfields? It doesn't look like that's going to help you much,
you'll just end up with 6 bytes of holes on x86-64:

$ cat fsinfo_attribute_layout.c
enum fsinfo_value_type {
  FSINFO_TYPE_VSTRUCT     = 0,    /* Version-lengthed struct (up to
4096 bytes) */
  FSINFO_TYPE_STRING      = 1,    /* NUL-term var-length string (up to
4095 chars) */
  FSINFO_TYPE_OPAQUE      = 2,    /* Opaque blob (unlimited size) */
  FSINFO_TYPE_LIST        = 3,    /* List of ints/structs (unlimited size) */
};

struct fsinfo_attribute {
  unsigned int            attr_id;        /* The ID of the attribute */
  enum fsinfo_value_type  type:8;         /* The type of the
attribute's value(s) */
  unsigned int            flags:8;
  unsigned int            size:16;        /* - Value size (FSINFO_STRUCT) */
  unsigned int            element_size:16; /* - Element size (FSINFO_LIST) */
  void *get;
};
void *blah(struct fsinfo_attribute *p) {
  return p->get;
}
$ gcc -c -o fsinfo_attribute_layout.o fsinfo_attribute_layout.c -ggdb
$ pahole -C fsinfo_attribute -E --hex fsinfo_attribute_layout.o
struct fsinfo_attribute {
        unsigned int               attr_id;          /*     0   0x4 */
        enum fsinfo_value_type type:8;               /*   0x4: 0 0x4 */
        unsigned int               flags:8;          /*   0x4:0x8 0x4 */
        unsigned int               size:16;          /*   0x4:0x10 0x4 */
        unsigned int               element_size:16;  /*   0x8: 0 0x4 */

        /* XXX 16 bits hole, try to pack */
        /* XXX 4 bytes hole, try to pack */

        void *                     get;              /*  0x10   0x8 */

        /* size: 24, cachelines: 1, members: 6 */
        /* sum members: 12, holes: 1, sum holes: 4 */
        /* sum bitfield members: 48 bits, bit holes: 1, sum bit holes:
16 bits */
        /* last cacheline: 24 bytes */
};
