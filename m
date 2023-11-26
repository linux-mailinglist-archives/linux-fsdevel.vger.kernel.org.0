Return-Path: <linux-fsdevel+bounces-3840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E967F9268
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 11:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C1DB20D39
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5227F6FB1;
	Sun, 26 Nov 2023 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHHQNRa1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85CEDE
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 02:58:42 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00b01955acso471646166b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 02:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700996321; x=1701601121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EeTaM+fyZlpKQ1lP1QSi3T2KgXwQsyiy6uswKwHpTSU=;
        b=dHHQNRa1up2BmQmFt46Eab7S8/7ixIHqU6OMt6YCh1AcWwhFV7xPGW6UESJw7syLrI
         +i5/SMdr5z9UVKndAU74vIqtZ11zSxAQJPUQ2vyBvwS8N9UN/TFD8qq9vVVBr20EvWvd
         LxG/xa00XEVYYwFdAz7W991BjwRYrFdJpID2bg2FlgHT9uY7kHRLHH5E+1kkNBsEN1ck
         yhqFRmFJbqePapkeD0WT1G+jAIeT4em0OLtTEPUkqQHN5fOpUpL1oYbDHM/1BVyBPCLW
         TE0rpqTe0kbSbztS6bOejpDOXFWnIVEyiZu8e+jpbL4c/9Y2u5jf9BMZXhX/zm4z6rp0
         /yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700996321; x=1701601121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeTaM+fyZlpKQ1lP1QSi3T2KgXwQsyiy6uswKwHpTSU=;
        b=A7SJp3qB//BWm13ZEkI2qewoY/Wsr1PQwN1vuH1D2tQDnVrFn6kTVlolkzmh4LHwpp
         UA55N6Kh7VA+NLknOxhU3d8RlPJaUxyoRQgexZpaNFJ/j3nr0eCdf8cgylqmXTWKBxDp
         SZ7C+qCkCxGO6UaSP/wsAmFo23+Jx4JV15Sk4zFXs0alglGdx0bTkSfHChKjFYd4X18y
         JJuwtBSX1FvfWrl/nFHRQrTBkNNr/EsYomrj62yhb5aifnTLCq10PykTg6rXhkIYrbum
         tt/df/v+L+8eBZmTQG/C0CA7UlrWtH/MfNwBz6sEONclxCZ5sZf0sByPcNI5XACC5dhN
         Q+Og==
X-Gm-Message-State: AOJu0Yy1A964kMcO7mdrPUaXfO3e5lMu+gCQzxEUB46Uc+pV6B58J7Z/
	0fPx6gzdIi4lr5m0QZ+yp8g=
X-Google-Smtp-Source: AGHT+IEgm0ouk9l1Z1vP5CoGIJx1SUcXjgsogmXSDeZeEn8Sv7V7WlynhaHBgS/dnUXIKhOAr5t2wQ==
X-Received: by 2002:a17:907:7e87:b0:9e0:2319:16f2 with SMTP id qb7-20020a1709077e8700b009e0231916f2mr7105042ejc.43.1700996321061;
        Sun, 26 Nov 2023 02:58:41 -0800 (PST)
Received: from f (cst-prg-77-164.cust.vodafone.cz. [46.135.77.164])
        by smtp.gmail.com with ESMTPSA id q22-20020a1709064c9600b009ae69c303aasm4408555eju.137.2023.11.26.02.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 02:58:40 -0800 (PST)
Date: Sun, 26 Nov 2023 11:58:32 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] simpler way to get benefits of "vfs: shave work on
 failed file open"
Message-ID: <20231126105832.lqhuxmzdxey5ubvs@f>
References: <20231126020834.GC38156@ZenIV>
 <CAHk-=wg=Jo14tKCpvZRd=L-3LUqZnBJfaDk1ur+XumGxvems4A@mail.gmail.com>
 <20231126050824.GE38156@ZenIV>
 <CAHk-=whPy8Dt3OtiW3STVUVKhsAZ2Ca2rHeyNtMpGG-xhSp24w@mail.gmail.com>
 <20231126-luftkammer-sahen-f28150b1e783@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231126-luftkammer-sahen-f28150b1e783@brauner>

On Sun, Nov 26, 2023 at 10:21:59AM +0100, Christian Brauner wrote:
> On Sat, Nov 25, 2023 at 09:17:36PM -0800, Linus Torvalds wrote:
> > On Sat, 25 Nov 2023 at 21:08, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Sat, Nov 25, 2023 at 08:59:54PM -0800, Linus Torvalds wrote:
> > > >
> > > >       because I for some reason (probably looking
> > > > at Mateusz' original patch too much) re-implemented file_free() as
> > > > fput_immediate()..
> > >
> > > file_free() was with RCU delay at that time, IIRC.
> > 
> > Ahh, indeed. So it was the SLAB_TYPESAFE_BY_RCU changes that basically
> 
> Yes, special-casing this into file_free() wasn't looking very appealing.

Right, if the SLAB_TYPESAFE_BY_RCU work was already there my v1 for
dodging task_work would have been much simpler (but would still have
fput_badopen).

While I support deduping code which comes with this patch I'm not fond
of special casing failed opens in fput.

A minor remark is that in the spot which ends up calling here on stock
kernel it is FMODE_OPENED which is the unlikely case, but with the patch
it ends up being handled with a branch marked the other way around.
I noted in my commit message failed opens are not some corner-case, they
are much common.

The thing which irks me on its principle is that special-casing for the
case which is guaranteed to not be true for majority of fput users is
avoidably rolled into the general routine.

For my taste the code below (untested) would be nicer, but I don't think
there are solid grounds for picking one approach over another. That is
to say if you insist on Al's variant then we are done here. :)

diff --git a/fs/file_table.c b/fs/file_table.c
index de4a2915bfd4..5e5613d80631 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -75,18 +75,6 @@ static inline void file_free(struct file *f)
 	}
 }
 
-void release_empty_file(struct file *f)
-{
-	WARN_ON_ONCE(f->f_mode & (FMODE_BACKING | FMODE_OPENED));
-	if (atomic_long_dec_and_test(&f->f_count)) {
-		security_file_free(f);
-		put_cred(f->f_cred);
-		if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
-			percpu_counter_dec(&nr_files);
-		kmem_cache_free(filp_cachep, f);
-	}
-}
-
 /*
  * Return the total number of open files in the system
  */
@@ -461,6 +449,18 @@ void fput(struct file *file)
 	}
 }
 
+void fput_badopen(struct file *f)
+{
+	if (unlikely(f->f_mode & (FMODE_BACKING | FMODE_OPENED))) {
+		fput(f);
+		return;
+	}
+
+	if (likely(atomic_long_dec_and_test(&f->f_count))) {
+		file_free(f);
+	}
+}
+
 /*
  * synchronous analog of fput(); for kernel threads that might be needed
  * in some umount() (and thus can't use flush_delayed_fput() without
diff --git a/fs/internal.h b/fs/internal.h
index 58e43341aebf..3afe774ff7c6 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -94,7 +94,7 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
-void release_empty_file(struct file *f);
+void fput_badopen(struct file *f);
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..e42e2c237a4c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3785,10 +3785,7 @@ static struct file *path_openat(struct nameidata *nd,
 		WARN_ON(1);
 		error = -EINVAL;
 	}
-	if (unlikely(file->f_mode & FMODE_OPENED))
-		fput(file);
-	else
-		release_empty_file(file);
+	fput_badopen(file);
 	if (error == -EOPENSTALE) {
 		if (flags & LOOKUP_RCU)
 			error = -ECHILD;

