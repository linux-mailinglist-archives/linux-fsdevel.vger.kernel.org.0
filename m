Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19932752FAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 05:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjGNDCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 23:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjGNDC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:02:28 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25732698
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:02:26 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso1298102276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689303746; x=1691895746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWF1rWhwYv+32T0N3hVOD4U3JND/hlQOgh7+AffgXaU=;
        b=CrUx2usXaCQdB6JxGiNre8mx7bMBbOckXX2C7PBlp3J8MVt0FZEo1yQQ8jMXUfGaIZ
         2iE/uBdh+tsOCNjB06NImh0I26WW8XSTt1pc+mv6azbjNnuPDeT/1pIWt1AVCpRQ0Xlj
         MoafYI9Z3F/z7aQ9h3nqJlwnNUMoQBxeqhurtaGG9F2zro+naS1RSlEtit54eONqf4Zw
         ntGr32h80xGf4vsXqOsROcEyP7u1AA70uXZZ+V9WoP6UEx+TXG7dapp9NbQI61aIenAX
         HKFicWi5QrkmzqyBbUJSpkALzYPKc6RHRSrMUQawgMBUXFOSgC00RJLA/mLyToszK/uf
         3VrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689303746; x=1691895746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWF1rWhwYv+32T0N3hVOD4U3JND/hlQOgh7+AffgXaU=;
        b=GsfwTyy4jysCrN2C9wO5PDdIpLBlQsTEgxpCqFZM1YLGRMckq2qPryJ09VcfIIBOXw
         yHVIRKnKP/vvKfMKA/Low6GOTF+ofczJxJrpY3RyXYtxbirFy6X4ID4QLyiIIJM8wpmz
         DIyh18Df29vKLLUGQsbGJnoo2dk4WW58/9eSgnb9dTeu1tuvHl0iVWBzUaEUk5RLjuVD
         5rEXkQkE71mEcqy+synPYYs6e3Vc2iZ2MQyQt8agKAFhGq2SJPQJkF6ZrERPGcoka/4S
         5+RQ6gQ12SWRYcObp1wQ6EjNWpq07gBuc/diEy04Mc06d8svOI0ghESirrs13J+EE76v
         +Aew==
X-Gm-Message-State: ABy/qLam2YM/n7E6Fw3hLzjUowgBLSVUw3g38H6rHwMPpFF1/OGJPiHw
        6ykadBgkPNIofrYlxpk0uE4bBNcEB3TPrcKzFmPRgQ==
X-Google-Smtp-Source: APBJJlGc5/3ujsQL3fWtKfDw79yqtAH5ym2lb7z3t8EOMU7ReBiHpL/fRRDNVtaivThgrLsLUJ1Pfn7J1DVYN1K2r8k=
X-Received: by 2002:a25:e4c1:0:b0:caa:7841:9e9c with SMTP id
 b184-20020a25e4c1000000b00caa78419e9cmr2679381ybh.27.1689303745815; Thu, 13
 Jul 2023 20:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230711202047.3818697-1-willy@infradead.org> <20230711202047.3818697-2-willy@infradead.org>
In-Reply-To: <20230711202047.3818697-2-willy@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 13 Jul 2023 20:02:12 -0700
Message-ID: <CAJuCfpGTRZO121fD0_nXi534D45+eOSUkCO7dcZe13jhkdfnSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] Revert "tcp: Use per-vma locking for receive zerocopy"
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 1:21=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> This reverts commit 7a7f094635349a7d0314364ad50bdeb770b6df4f.

nit: some explanation and SOB would be nice.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  MAINTAINERS            |  1 -
>  include/linux/net_mm.h | 17 ----------------
>  include/net/tcp.h      |  1 -
>  mm/memory.c            |  7 +++----
>  net/ipv4/tcp.c         | 45 ++++++++----------------------------------
>  5 files changed, 11 insertions(+), 60 deletions(-)
>  delete mode 100644 include/linux/net_mm.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 18cd0ce2c7d2..00047800cff1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14816,7 +14816,6 @@ NETWORKING [TCP]
>  M:     Eric Dumazet <edumazet@google.com>
>  L:     netdev@vger.kernel.org
>  S:     Maintained
> -F:     include/linux/net_mm.h
>  F:     include/linux/tcp.h
>  F:     include/net/tcp.h
>  F:     include/trace/events/tcp.h
> diff --git a/include/linux/net_mm.h b/include/linux/net_mm.h
> deleted file mode 100644
> index b298998bd5a0..000000000000
> --- a/include/linux/net_mm.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -#ifdef CONFIG_MMU
> -
> -#ifdef CONFIG_INET
> -extern const struct vm_operations_struct tcp_vm_ops;
> -static inline bool vma_is_tcp(const struct vm_area_struct *vma)
> -{
> -       return vma->vm_ops =3D=3D &tcp_vm_ops;
> -}
> -#else
> -static inline bool vma_is_tcp(const struct vm_area_struct *vma)
> -{
> -       return false;
> -}
> -#endif /* CONFIG_INET*/
> -
> -#endif /* CONFIG_MMU */
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 226bce6d1e8c..95e4507febed 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -45,7 +45,6 @@
>  #include <linux/memcontrol.h>
>  #include <linux/bpf-cgroup.h>
>  #include <linux/siphash.h>
> -#include <linux/net_mm.h>
>
>  extern struct inet_hashinfo tcp_hashinfo;
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 0a265ac6246e..2c7967632866 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -77,7 +77,6 @@
>  #include <linux/ptrace.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/sysctl.h>
> -#include <linux/net_mm.h>
>
>  #include <trace/events/kmem.h>
>
> @@ -5419,12 +5418,12 @@ struct vm_area_struct *lock_vma_under_rcu(struct =
mm_struct *mm,
>         if (!vma)
>                 goto inval;
>
> -       /* Only anonymous and tcp vmas are supported for now */
> -       if (!vma_is_anonymous(vma) && !vma_is_tcp(vma))
> +       /* Only anonymous vmas are supported for now */
> +       if (!vma_is_anonymous(vma))
>                 goto inval;
>
>         /* find_mergeable_anon_vma uses adjacent vmas which are not locke=
d */
> -       if (!vma->anon_vma && !vma_is_tcp(vma))
> +       if (!vma->anon_vma)
>                 goto inval;
>
>         if (!vma_start_read(vma))
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03e08745308..1542de3f66f7 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1739,7 +1739,7 @@ void tcp_update_recv_tstamps(struct sk_buff *skb,
>  }
>
>  #ifdef CONFIG_MMU
> -const struct vm_operations_struct tcp_vm_ops =3D {
> +static const struct vm_operations_struct tcp_vm_ops =3D {
>  };
>
>  int tcp_mmap(struct file *file, struct socket *sock,
> @@ -2038,34 +2038,6 @@ static void tcp_zc_finalize_rx_tstamp(struct sock =
*sk,
>         }
>  }
>
> -static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
> -                                          unsigned long address,
> -                                          bool *mmap_locked)
> -{
> -       struct vm_area_struct *vma =3D NULL;
> -
> -#ifdef CONFIG_PER_VMA_LOCK
> -       vma =3D lock_vma_under_rcu(mm, address);
> -#endif
> -       if (vma) {
> -               if (!vma_is_tcp(vma)) {
> -                       vma_end_read(vma);
> -                       return NULL;
> -               }
> -               *mmap_locked =3D false;
> -               return vma;
> -       }
> -
> -       mmap_read_lock(mm);
> -       vma =3D vma_lookup(mm, address);
> -       if (!vma || !vma_is_tcp(vma)) {
> -               mmap_read_unlock(mm);
> -               return NULL;
> -       }
> -       *mmap_locked =3D true;
> -       return vma;
> -}
> -
>  #define TCP_ZEROCOPY_PAGE_BATCH_SIZE 32
>  static int tcp_zerocopy_receive(struct sock *sk,
>                                 struct tcp_zerocopy_receive *zc,
> @@ -2083,7 +2055,6 @@ static int tcp_zerocopy_receive(struct sock *sk,
>         u32 seq =3D tp->copied_seq;
>         u32 total_bytes_to_map;
>         int inq =3D tcp_inq(sk);
> -       bool mmap_locked;
>         int ret;
>
>         zc->copybuf_len =3D 0;
> @@ -2108,10 +2079,13 @@ static int tcp_zerocopy_receive(struct sock *sk,
>                 return 0;
>         }
>
> -       vma =3D find_tcp_vma(current->mm, address, &mmap_locked);
> -       if (!vma)
> -               return -EINVAL;
> +       mmap_read_lock(current->mm);
>
> +       vma =3D vma_lookup(current->mm, address);
> +       if (!vma || vma->vm_ops !=3D &tcp_vm_ops) {
> +               mmap_read_unlock(current->mm);
> +               return -EINVAL;
> +       }
>         vma_len =3D min_t(unsigned long, zc->length, vma->vm_end - addres=
s);
>         avail_len =3D min_t(u32, vma_len, inq);
>         total_bytes_to_map =3D avail_len & ~(PAGE_SIZE - 1);
> @@ -2185,10 +2159,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
>                                                    zc, total_bytes_to_map=
);
>         }
>  out:
> -       if (mmap_locked)
> -               mmap_read_unlock(current->mm);
> -       else
> -               vma_end_read(vma);
> +       mmap_read_unlock(current->mm);
>         /* Try to copy straggler data. */
>         if (!ret)
>                 copylen =3D tcp_zc_handle_leftover(zc, sk, skb, &seq, cop=
ybuf_len, tss);
> --
> 2.39.2
>
