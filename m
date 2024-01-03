Return-Path: <linux-fsdevel+bounces-7242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4E82318B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 17:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840F71F24BE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 16:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075921C295;
	Wed,  3 Jan 2024 16:50:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1961C282;
	Wed,  3 Jan 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a1915034144so1212227166b.0;
        Wed, 03 Jan 2024 08:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300610; x=1704905410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyxC65ZUHhJNVZLWmNzwaZSs3wWveWb1iIYNlwWiPu4=;
        b=qKgCZ8XhDZr768Vp09YG9E3sCiLARg1eL2U3PcpgsN20qfnHb6GzRjdprJxQ9/GWVU
         r7pPJC5bvLf4veZiwIzNQtN3NTDbLIfk6NaBOc/JiJAMseSrCZMMlnL8dbUJoUH1V0sm
         xNRYGSpuzsWF5qGaHavFff9YgpBVMYZpJST2dcVgfU+1SmGSr46cvcO1mX6I3GWX822l
         hzVSpq7NkCOlQcgOmnuvdnKkJ6ZhLkhkJHU+Wl/8K2OIyltw/MKPimq+7BeORx5/91xv
         FAVUEAAOlJvgRyAt2bSefzTkzX8RtOFajoIcZ+ARLiq81mrb3GpaDwkj9ja0Zz9HwnM3
         fEjA==
X-Gm-Message-State: AOJu0YzRB1WBCWFFob3iT/0Autd1Vev6s3fJw1UVx/u/VGzaWV+CcUjK
	JJQhCtyjWXMkcRhurkH1/246nQyME2os+7/p
X-Google-Smtp-Source: AGHT+IEB78KFE6mJ9iuVuNTP11+VpgrmW2o+MFXlzlfOOUpJT/BeVaCm3TbUiSrg6LpiKTBvplVc0Q==
X-Received: by 2002:a17:907:3c01:b0:a28:4bf8:a16f with SMTP id gh1-20020a1709073c0100b00a284bf8a16fmr977913ejc.136.1704300610368;
        Wed, 03 Jan 2024 08:50:10 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id wl1-20020a170907310100b00a233515c39esm12778546ejb.67.2024.01.03.08.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 08:50:10 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55590da560dso5216407a12.0;
        Wed, 03 Jan 2024 08:50:09 -0800 (PST)
X-Received: by 2002:a17:907:2d9f:b0:a23:6230:6213 with SMTP id
 gt31-20020a1709072d9f00b00a2362306213mr11110657ejc.98.1704300609810; Wed, 03
 Jan 2024 08:50:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221132400.1601991-1-dhowells@redhat.com> <20231221132400.1601991-7-dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-7-dhowells@redhat.com>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Wed, 3 Jan 2024 12:49:58 -0400
X-Gmail-Original-Message-ID: <CAB9dFdufPXLZJAKZbzSfsv4o=SzwKfeW4WGrAdFTmn6B0on63Q@mail.gmail.com>
Message-ID: <CAB9dFdufPXLZJAKZbzSfsv4o=SzwKfeW4WGrAdFTmn6B0on63Q@mail.gmail.com>
Subject: Re: [PATCH v5 06/40] netfs, fscache: Move /proc/fs/fscache to
 /proc/fs/netfs and put in a symlink
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 9:24=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Rename /proc/fs/fscache to "netfs" and make a symlink from fscache to tha=
t.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> cc: Christian Brauner <christian@brauner.io>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-cachefs@redhat.com
> ---
>
> Notes:
>     Changes
>     =3D=3D=3D=3D=3D=3D=3D
>     ver #5)
>      - fscache_init/exit() should depend on CONFIG_FSCACHE, not CONFIG_PR=
OC_FS.
>
>  fs/netfs/fscache_main.c  |  8 ++------
>  fs/netfs/fscache_proc.c  | 23 ++++++++---------------
>  fs/netfs/fscache_stats.c |  4 +---
>  fs/netfs/internal.h      | 12 +++++++++++-
>  fs/netfs/main.c          | 33 +++++++++++++++++++++++++++++++++
>  fs/netfs/stats.c         | 13 +++++++------
>  include/linux/netfs.h    |  1 -
>  7 files changed, 62 insertions(+), 32 deletions(-)
>
> diff --git a/fs/netfs/fscache_main.c b/fs/netfs/fscache_main.c
> index 00600a4d9ce5..42e98bb523e3 100644
> --- a/fs/netfs/fscache_main.c
> +++ b/fs/netfs/fscache_main.c
> @@ -62,7 +62,7 @@ unsigned int fscache_hash(unsigned int salt, const void=
 *data, size_t len)
>  /*
>   * initialise the fs caching module
>   */
> -static int __init fscache_init(void)
> +int __init fscache_init(void)
>  {
>         int ret =3D -ENOMEM;
>
> @@ -94,12 +94,10 @@ static int __init fscache_init(void)
>         return ret;
>  }
>
> -fs_initcall(fscache_init);
> -
>  /*
>   * clean up on module removal
>   */
> -static void __exit fscache_exit(void)
> +void __exit fscache_exit(void)
>  {
>         _enter("");
>
> @@ -108,5 +106,3 @@ static void __exit fscache_exit(void)
>         destroy_workqueue(fscache_wq);
>         pr_notice("FS-Cache unloaded\n");
>  }
> -
> -module_exit(fscache_exit);
> diff --git a/fs/netfs/fscache_proc.c b/fs/netfs/fscache_proc.c
> index dc3b0e9c8cce..ecd0d1edafaa 100644
> --- a/fs/netfs/fscache_proc.c
> +++ b/fs/netfs/fscache_proc.c
> @@ -12,41 +12,34 @@
>  #include "internal.h"
>
>  /*
> - * initialise the /proc/fs/fscache/ directory
> + * Add files to /proc/fs/netfs/.
>   */
>  int __init fscache_proc_init(void)
>  {
> -       if (!proc_mkdir("fs/fscache", NULL))
> -               goto error_dir;
> +       if (!proc_symlink("fs/fscache", NULL, "../netfs"))

This should be just "netfs"

> +               goto error_sym;
>
> -       if (!proc_create_seq("fs/fscache/caches", S_IFREG | 0444, NULL,
> +       if (!proc_create_seq("fs/netfs/caches", S_IFREG | 0444, NULL,
>                              &fscache_caches_seq_ops))
>                 goto error;
>
> -       if (!proc_create_seq("fs/fscache/volumes", S_IFREG | 0444, NULL,
> +       if (!proc_create_seq("fs/netfs/volumes", S_IFREG | 0444, NULL,
>                              &fscache_volumes_seq_ops))
>                 goto error;
>
> -       if (!proc_create_seq("fs/fscache/cookies", S_IFREG | 0444, NULL,
> +       if (!proc_create_seq("fs/netfs/cookies", S_IFREG | 0444, NULL,
>                              &fscache_cookies_seq_ops))
>                 goto error;
> -
> -#ifdef CONFIG_FSCACHE_STATS
> -       if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
> -                               fscache_stats_show))
> -               goto error;
> -#endif
> -
>         return 0;
>
>  error:
>         remove_proc_entry("fs/fscache", NULL);
> -error_dir:
> +error_sym:
>         return -ENOMEM;
>  }
>
>  /*
> - * clean up the /proc/fs/fscache/ directory
> + * Clean up the /proc/fs/fscache symlink.
>   */
>  void fscache_proc_cleanup(void)
>  {
> diff --git a/fs/netfs/fscache_stats.c b/fs/netfs/fscache_stats.c
> index fc94e5e79f1c..aad812ead398 100644
> --- a/fs/netfs/fscache_stats.c
> +++ b/fs/netfs/fscache_stats.c
> @@ -52,7 +52,7 @@ EXPORT_SYMBOL(fscache_n_culled);
>  /*
>   * display the general statistics
>   */
> -int fscache_stats_show(struct seq_file *m, void *v)
> +int fscache_stats_show(struct seq_file *m)
>  {
>         seq_puts(m, "FS-Cache statistics\n");
>         seq_printf(m, "Cookies: n=3D%d v=3D%d vcol=3D%u voom=3D%u\n",
> @@ -96,7 +96,5 @@ int fscache_stats_show(struct seq_file *m, void *v)
>         seq_printf(m, "IO     : rd=3D%u wr=3D%u\n",
>                    atomic_read(&fscache_n_read),
>                    atomic_read(&fscache_n_write));
> -
> -       netfs_stats_show(m);
>         return 0;
>  }
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index 43769ac606e8..3f6e22229433 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -76,6 +76,7 @@ extern atomic_t netfs_n_rh_write_done;
>  extern atomic_t netfs_n_rh_write_failed;
>  extern atomic_t netfs_n_rh_write_zskip;
>
> +int netfs_stats_show(struct seq_file *m, void *v);
>
>  static inline void netfs_stat(atomic_t *stat)
>  {
> @@ -166,6 +167,13 @@ static inline void fscache_see_cookie(struct fscache=
_cookie *cookie,
>   * fscache-main.c
>   */
>  extern unsigned int fscache_hash(unsigned int salt, const void *data, si=
ze_t len);
> +#ifdef CONFIG_FSCACHE
> +int __init fscache_init(void);
> +void __exit fscache_exit(void);
> +#else
> +static inline int fscache_init(void) { return 0; }
> +static inline void fscache_exit(void) {}
> +#endif
>
>  /*
>   * fscache-proc.c
> @@ -216,12 +224,14 @@ static inline void fscache_stat_d(atomic_t *stat)
>
>  #define __fscache_stat(stat) (stat)
>
> -int fscache_stats_show(struct seq_file *m, void *v);
> +int fscache_stats_show(struct seq_file *m);
>  #else
>
>  #define __fscache_stat(stat) (NULL)
>  #define fscache_stat(stat) do {} while (0)
>  #define fscache_stat_d(stat) do {} while (0)
> +
> +static inline int fscache_stats_show(struct seq_file *m) { return 0; }
>  #endif
>
>  /*
> diff --git a/fs/netfs/main.c b/fs/netfs/main.c
> index 1ba8091fcf3e..c9af6e0896d3 100644
> --- a/fs/netfs/main.c
> +++ b/fs/netfs/main.c
> @@ -7,6 +7,8 @@
>
>  #include <linux/module.h>
>  #include <linux/export.h>
> +#include <linux/proc_fs.h>
> +#include <linux/seq_file.h>
>  #include "internal.h"
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/netfs.h>
> @@ -19,3 +21,34 @@ unsigned netfs_debug;
>  module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
>  MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
>
> +static int __init netfs_init(void)
> +{
> +       int ret =3D -ENOMEM;
> +
> +       if (!proc_mkdir("fs/netfs", NULL))
> +               goto error;
> +
> +#ifdef CONFIG_FSCACHE_STATS
> +       if (!proc_create_single("fs/netfs/stats", S_IFREG | 0444, NULL,
> +                               netfs_stats_show))
> +               goto error_proc;
> +#endif
> +
> +       ret =3D fscache_init();
> +       if (ret < 0)
> +               goto error_proc;
> +       return 0;
> +
> +error_proc:
> +       remove_proc_entry("fs/netfs", NULL);
> +error:
> +       return ret;
> +}
> +fs_initcall(netfs_init);
> +
> +static void __exit netfs_exit(void)
> +{
> +       fscache_exit();
> +       remove_proc_entry("fs/netfs", NULL);
> +}
> +module_exit(netfs_exit);
> diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
> index 5510a7a14a40..6025dc485f7e 100644
> --- a/fs/netfs/stats.c
> +++ b/fs/netfs/stats.c
> @@ -28,31 +28,32 @@ atomic_t netfs_n_rh_write_done;
>  atomic_t netfs_n_rh_write_failed;
>  atomic_t netfs_n_rh_write_zskip;
>
> -void netfs_stats_show(struct seq_file *m)
> +int netfs_stats_show(struct seq_file *m, void *v)
>  {
> -       seq_printf(m, "RdHelp : RA=3D%u RP=3D%u WB=3D%u WBZ=3D%u rr=3D%u =
sr=3D%u\n",
> +       seq_printf(m, "Netfs  : RA=3D%u RP=3D%u WB=3D%u WBZ=3D%u rr=3D%u =
sr=3D%u\n",
>                    atomic_read(&netfs_n_rh_readahead),
>                    atomic_read(&netfs_n_rh_readpage),
>                    atomic_read(&netfs_n_rh_write_begin),
>                    atomic_read(&netfs_n_rh_write_zskip),
>                    atomic_read(&netfs_n_rh_rreq),
>                    atomic_read(&netfs_n_rh_sreq));
> -       seq_printf(m, "RdHelp : ZR=3D%u sh=3D%u sk=3D%u\n",
> +       seq_printf(m, "Netfs  : ZR=3D%u sh=3D%u sk=3D%u\n",
>                    atomic_read(&netfs_n_rh_zero),
>                    atomic_read(&netfs_n_rh_short_read),
>                    atomic_read(&netfs_n_rh_write_zskip));
> -       seq_printf(m, "RdHelp : DL=3D%u ds=3D%u df=3D%u di=3D%u\n",
> +       seq_printf(m, "Netfs  : DL=3D%u ds=3D%u df=3D%u di=3D%u\n",
>                    atomic_read(&netfs_n_rh_download),
>                    atomic_read(&netfs_n_rh_download_done),
>                    atomic_read(&netfs_n_rh_download_failed),
>                    atomic_read(&netfs_n_rh_download_instead));
> -       seq_printf(m, "RdHelp : RD=3D%u rs=3D%u rf=3D%u\n",
> +       seq_printf(m, "Netfs  : RD=3D%u rs=3D%u rf=3D%u\n",
>                    atomic_read(&netfs_n_rh_read),
>                    atomic_read(&netfs_n_rh_read_done),
>                    atomic_read(&netfs_n_rh_read_failed));
> -       seq_printf(m, "RdHelp : WR=3D%u ws=3D%u wf=3D%u\n",
> +       seq_printf(m, "Netfs  : WR=3D%u ws=3D%u wf=3D%u\n",
>                    atomic_read(&netfs_n_rh_write),
>                    atomic_read(&netfs_n_rh_write_done),
>                    atomic_read(&netfs_n_rh_write_failed));
> +       return fscache_stats_show(m);
>  }
>  EXPORT_SYMBOL(netfs_stats_show);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index d294ff8f9ae4..9bd91cd615d5 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -294,7 +294,6 @@ void netfs_get_subrequest(struct netfs_io_subrequest =
*subreq,
>                           enum netfs_sreq_ref_trace what);
>  void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
>                           bool was_async, enum netfs_sreq_ref_trace what)=
;
> -void netfs_stats_show(struct seq_file *);
>  ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
>                                 struct iov_iter *new,
>                                 iov_iter_extraction_t extraction_flags);
>

Marc

