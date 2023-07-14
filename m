Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD56753017
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 05:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjGNDlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 23:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbjGNDlC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:41:02 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EE3CD
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:41:00 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-cad89b0d35cso1392565276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689306060; x=1691898060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvQTgMQayfgjmUKJRh67IR25P+b4FA+q1tIxwLi8BoA=;
        b=jaOnftt48afzTlJLrxhluck7j/hhKo5yJyFXsOxcU9P1t8Tyjv+anRZXACyy1xN6AF
         zfqXYt2UYR7sZFBVTxuY7tmDK+Nt/NABifiIdgKVs0StWUMTcvCWWDeOg+RlxDBkQ4bd
         EAYEvk5IZqEFRF6Cu7O+UUSI9bcIOAQxGyYk+2asVrWC/vaGbcDlEgBAOwCkTTsG6Lm0
         vN+QNEL9gEht3UlRLoQhEs2rp0TQNi86GfrQxh89hzRwcQVdqqzB7jnR7w4wRvmWxUge
         miuU+s8TjOzlPnuDuwqQm+MZc3uDWZOA7VZdhpAZGZfStA8HbmAYAXgo1g1MQl+I2Nwj
         Envg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689306060; x=1691898060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvQTgMQayfgjmUKJRh67IR25P+b4FA+q1tIxwLi8BoA=;
        b=IbXcn+E3fpp5txpTuaoGmvGxAWSPrDKBxfwqvPAb91M+J4s/2rAAcy+rYLP606NiVm
         lf3N1lHBb/UgZwUDRZOFX+BM/Y3exGezvcsZiwdk9vHV8CUEGkjYzKBWhHBwJUQh0vZZ
         EiMr9+xSFCkO9wI1L4fpMFGB+WiNVBAVTBR+n1mTCSYSHL00L6PytDnZNLXj3Lnc84xt
         8deC8RXU2i/SwNkjnzZbVFtY0TaF0SW0dBafUOYlndL+0nHWpYahKcLdosp2QBELo8Uf
         EdQxP/JDbSlOCMN5h8sk4TETqVQEdWm7Gw7viArb5BKIDPt+Yp9zFimULBL0KFCHuESe
         WXNw==
X-Gm-Message-State: ABy/qLazKG9wuxdcVmVRurPAWAceBzeURb/P6QQVVhJARFq7mdIrNtqV
        ZXPDFxUVxgx+UCd4s9CQ1qLEc+WxDqUUCIAxwJsY5w==
X-Google-Smtp-Source: APBJJlHoQ6t+FL9wcuDLnzhzIsH9P7aK0vErv0wtlWTHif17IFj5QJ2w+F5quh6Yx0rEzxY0qgTVCogf20UT6noLb/I=
X-Received: by 2002:a0d:c986:0:b0:561:d1ef:3723 with SMTP id
 l128-20020a0dc986000000b00561d1ef3723mr3908311ywd.38.1689306059905; Thu, 13
 Jul 2023 20:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230711202047.3818697-1-willy@infradead.org> <20230711202047.3818697-10-willy@infradead.org>
In-Reply-To: <20230711202047.3818697-10-willy@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 13 Jul 2023 20:40:46 -0700
Message-ID: <CAJuCfpHDripryQ2T_gzwhZ0ogEgs6vdyrgOoj79ky8Uoyvg0vg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] tcp: Use per-vma locking for receive zerocopy
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        "David S . Miller" <davem@davemloft.net>
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
> From: Arjun Roy <arjunroy@google.com>
>
> Per-VMA locking allows us to lock a struct vm_area_struct without
> taking the process-wide mmap lock in read mode.
>
> Consider a process workload where the mmap lock is taken constantly in
> write mode. In this scenario, all zerocopy receives are periodically
> blocked during that period of time - though in principle, the memory
> ranges being used by TCP are not touched by the operations that need
> the mmap write lock. This results in performance degradation.
>
> Now consider another workload where the mmap lock is never taken in
> write mode, but there are many TCP connections using receive zerocopy
> that are concurrently receiving. These connections all take the mmap
> lock in read mode, but this does induce a lot of contention and atomic
> ops for this process-wide lock. This results in additional CPU
> overhead caused by contending on the cache line for this lock.
>
> However, with per-vma locking, both of these problems can be avoided.
>
> As a test, I ran an RPC-style request/response workload with 4KB
> payloads and receive zerocopy enabled, with 100 simultaneous TCP
> connections. I measured perf cycles within the
> find_tcp_vma/mmap_read_lock/mmap_read_unlock codepath, with and
> without per-vma locking enabled.
>
> When using process-wide mmap semaphore read locking, about 1% of
> measured perf cycles were within this path. With per-VMA locking, this
> value dropped to about 0.45%.
>
> Signed-off-by: Arjun Roy <arjunroy@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Seems to match the original version with less churn.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  net/ipv4/tcp.c | 39 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1542de3f66f7..7118ec6cf886 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2038,6 +2038,30 @@ static void tcp_zc_finalize_rx_tstamp(struct sock =
*sk,
>         }
>  }
>

nit: Maybe add a comment that mmap_locked value is
undefined/meaningless if the function returns NULL?

> +static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
> +               unsigned long address, bool *mmap_locked)
> +{
> +       struct vm_area_struct *vma =3D lock_vma_under_rcu(mm, address);
> +
> +       if (vma) {
> +               if (vma->vm_ops !=3D &tcp_vm_ops) {
> +                       vma_end_read(vma);
> +                       return NULL;
> +               }
> +               *mmap_locked =3D false;
> +               return vma;
> +       }
> +
> +       mmap_read_lock(mm);
> +       vma =3D vma_lookup(mm, address);
> +       if (!vma || vma->vm_ops !=3D &tcp_vm_ops) {
> +               mmap_read_unlock(mm);
> +               return NULL;
> +       }
> +       *mmap_locked =3D true;
> +       return vma;
> +}
> +
>  #define TCP_ZEROCOPY_PAGE_BATCH_SIZE 32
>  static int tcp_zerocopy_receive(struct sock *sk,
>                                 struct tcp_zerocopy_receive *zc,
> @@ -2055,6 +2079,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
>         u32 seq =3D tp->copied_seq;
>         u32 total_bytes_to_map;
>         int inq =3D tcp_inq(sk);
> +       bool mmap_locked;
>         int ret;
>
>         zc->copybuf_len =3D 0;
> @@ -2079,13 +2104,10 @@ static int tcp_zerocopy_receive(struct sock *sk,
>                 return 0;
>         }
>
> -       mmap_read_lock(current->mm);
> -
> -       vma =3D vma_lookup(current->mm, address);
> -       if (!vma || vma->vm_ops !=3D &tcp_vm_ops) {
> -               mmap_read_unlock(current->mm);
> +       vma =3D find_tcp_vma(current->mm, address, &mmap_locked);
> +       if (!vma)
>                 return -EINVAL;
> -       }
> +
>         vma_len =3D min_t(unsigned long, zc->length, vma->vm_end - addres=
s);
>         avail_len =3D min_t(u32, vma_len, inq);
>         total_bytes_to_map =3D avail_len & ~(PAGE_SIZE - 1);
> @@ -2159,7 +2181,10 @@ static int tcp_zerocopy_receive(struct sock *sk,
>                                                    zc, total_bytes_to_map=
);
>         }
>  out:
> -       mmap_read_unlock(current->mm);
> +       if (mmap_locked)
> +               mmap_read_unlock(current->mm);
> +       else
> +               vma_end_read(vma);
>         /* Try to copy straggler data. */
>         if (!ret)
>                 copylen =3D tcp_zc_handle_leftover(zc, sk, skb, &seq, cop=
ybuf_len, tss);
> --
> 2.39.2
>
