Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CFA7189C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 21:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjEaTBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjEaTBn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 15:01:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117FB19D;
        Wed, 31 May 2023 12:01:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f818c48fbso1073375566b.0;
        Wed, 31 May 2023 12:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685559668; x=1688151668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMM9p/WFQFaMR6YliCHSUjskw+5S7I0WnBjfi1SU4e4=;
        b=qCTQel0ZFK3EVOP9HMnQbFPK/VxPeZogE8d3ZcZKB0CP8fGYe71DJtucc9iZaMYO2o
         X6Zes/Yi2futILFYfdb+r3ynA8sGYAj8AbtDZTVRmSY3MjDXWoGooxh07AENXTcbe0yC
         qEIZ8/qDpGrqfwGazk0OT68mVMfx7NKKr9WK+2OIQcDWu7xOXTqhqVn3a5gybWLOC2Lt
         gSELD0TfOVCvn0XpGYNXxN4FcVHjPBtXIdQ819sXFr+YZBo+WxcOuWjeGR0wqtoDyASL
         zhU65uaos7rOzRogEDvf/GektF7mWNQwzNmjguesMlBcTSekLBu1/HxG/ua992SYGCI3
         4vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685559668; x=1688151668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMM9p/WFQFaMR6YliCHSUjskw+5S7I0WnBjfi1SU4e4=;
        b=XNcHjQQENSdMiL5ymplhOkqBJIt7jtO5c+J/jgtmf5V7Saj0cq9PCpIi4+UZW525Z0
         yoW1vPEPK3sv9brtgwypAIaTM/ukx4FBq131ZXYYhsFnRgmApB/lbN0H483FCDXXQkfg
         JUGZlQsUZvBXNi8zSJRhvFRXbzhM5x4P6lCrRbmkVnKb6vQ44ow+ru8V/YrcrGC5wkuP
         PTZH1XsQAInT6bmV4S7afiocTLPHbKYxRbaL7kgmm4L13utx8W3/8btCt5l5mWaAy4R0
         TCsY4oHKoRruech6hUoE3oPhR+qmLoSV/lMzAoEr9s3nuwTTssJ0eMG3wBzwdPqHwAhe
         USGg==
X-Gm-Message-State: AC+VfDwzdkyHaIhf89btgl7Cq08fxkRdPVBmDiZpJOLLO6Bfh5bpmQ+b
        HP4tSGLzjy3UcZ/buDe9HNSFK0vO2t8iA+hwVJkniAeO9gk=
X-Google-Smtp-Source: ACHHUZ4g99XC6v0QFmjQ1l5lPXeASNyjBnXljqHYYAadhm5o/gC/2RPIHeUboeBIsi9PHrGOoAwb3Pt6lkYBhefkKfM=
X-Received: by 2002:a17:907:8687:b0:96a:53e6:eab5 with SMTP id
 qa7-20020a170907868700b0096a53e6eab5mr5827056ejc.41.1685559667832; Wed, 31
 May 2023 12:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230509132433.2FSY_6t7@linutronix.de> <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
 <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
 <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
 <20230525141813.TFZLWM4M@linutronix.de> <CAEf4Bzaipoo6X_2Fh5WTV-m0yjP0pvhqi7-FPFtGOrSzNpdGJQ@mail.gmail.com>
 <20230526112356.fOlWmeOF@linutronix.de>
In-Reply-To: <20230526112356.fOlWmeOF@linutronix.de>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 31 May 2023 12:00:56 -0700
Message-ID: <CAEf4Bzawgrn2DhR9uvXwFFiLR9g+j4RYC6cr3n+eRD_RoKBAJA@mail.gmail.com>
Subject: Re: [PATCH v3] bpf: Remove in_atomic() from bpf_link_put().
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 4:24=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks are
> invoked within softirq context. By setting rcutree.use_softirq=3D0 boot
> option the RCU callbacks will be invoked in a per-CPU kthread with
> bottom halves disabled which implies a RCU read section.
>
> On PREEMPT_RT the context remains fully preemptible. The RCU read
> section however does not allow schedule() invocation. The latter happens
> in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
> from bpf_link_put().
>
> It was pointed out that the bpf_link_put() invocation should not be
> delayed if originated from close(). It was also pointed out that other
> invocations from within a syscall should also avoid the workqueue.
> After an audit of all bpf_link_put() callers it looks that the only
> atomic caller is the RCU callback. Everything else is called from
> preemptible context because it is a syscall, a mutex_t is acquired near
> by or due a GFP_KERNEL memory allocation.
>
> Let bpf_link_put() free the resources directly. Add
> bpf_link_put_from_atomic() which uses the kworker to free the
> resources. Let bpf_any_put() invoke one or the other depending on the
> context it is called from (RCU or not).
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> On 2023-05-25 10:51:23 [-0700], Andrii Nakryiko wrote:
> v2=E2=80=A6v3:
>   - Drop bpf_link_put_direct(). Let bpf_link_put() do the direct free
>     and add bpf_link_put_from_atomic() to do the delayed free via the
>     worker.

This seems like an unsafe "default put" choice. I think it makes more
sense to have bpf_link_put() do a safe scheduled put, and then having
a separate bpf_link_put_direct() for those special cases where we care
the most (in kernel/bpf/inode.c and kernel/bpf/syscall.c).

>
> v1=E2=80=A6v2:
>    - Add bpf_link_put_direct() to be used from bpf_link_release() as
>      suggested.
>
> > Looks good to me, but it's not sufficient. See kernel/bpf/inode.c, we
> > need to do bpf_link_put_direct() from bpf_put_any(), which should be
> > safe as well because it all is either triggered from bpf() syscall or
> > by unlink()'ing BPF FS file. For file deletion we have the same
> > requirement to have deterministic release of bpf_link.
>
> Okay. I checked all callers and it seems that the only atomic caller is
> the RCU callback.
>
>  include/linux/bpf.h  |  5 +++++
>  kernel/bpf/inode.c   | 13 ++++++++-----
>  kernel/bpf/syscall.c | 21 ++++++++++++---------
>  3 files changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e53ceee1df370..dced1f880cfa6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2073,6 +2073,7 @@ int bpf_link_settle(struct bpf_link_primer *primer)=
;
>  void bpf_link_cleanup(struct bpf_link_primer *primer);
>  void bpf_link_inc(struct bpf_link *link);
>  void bpf_link_put(struct bpf_link *link);
> +void bpf_link_put_from_atomic(struct bpf_link *link);
>  int bpf_link_new_fd(struct bpf_link *link);
>  struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
>  struct bpf_link *bpf_link_get_from_fd(u32 ufd);
> @@ -2432,6 +2433,10 @@ static inline void bpf_link_put(struct bpf_link *l=
ink)
>  {
>  }
>
> +static inline void bpf_link_put_from_atomic(struct bpf_link *link)
> +{
> +}
> +
>  static inline int bpf_obj_get_user(const char __user *pathname, int flag=
s)
>  {
>         return -EOPNOTSUPP;
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 9948b542a470e..2e1e9f3c7f701 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -49,7 +49,7 @@ static void *bpf_any_get(void *raw, enum bpf_type type)
>         return raw;
>  }
>
> -static void bpf_any_put(void *raw, enum bpf_type type)
> +static void bpf_any_put(void *raw, enum bpf_type type, bool may_sleep)
>  {
>         switch (type) {
>         case BPF_TYPE_PROG:
> @@ -59,7 +59,10 @@ static void bpf_any_put(void *raw, enum bpf_type type)
>                 bpf_map_put_with_uref(raw);
>                 break;
>         case BPF_TYPE_LINK:
> -               bpf_link_put(raw);
> +               if (may_sleep)
> +                       bpf_link_put(raw);
> +               else
> +                       bpf_link_put_from_atomic(raw);

Do we need to do this in two different ways here? The only situation
that has may_sleep=3Dfalse is when called from superblock->free_inode.
According to documentation:

  Freeing memory in the callback is fine; doing
  more than that is possible, but requires a lot of care and is best
  avoided.

So it feels like cleaning up link should be safe to do from this
context as well? I've cc'ed linux-fsdevel@, hopefully they can advise.


>                 break;
>         default:
>                 WARN_ON_ONCE(1);
> @@ -490,7 +493,7 @@ int bpf_obj_pin_user(u32 ufd, const char __user *path=
name)
>
>         ret =3D bpf_obj_do_pin(pathname, raw, type);
>         if (ret !=3D 0)
> -               bpf_any_put(raw, type);
> +               bpf_any_put(raw, type, true);
>
>         return ret;
>  }
> @@ -552,7 +555,7 @@ int bpf_obj_get_user(const char __user *pathname, int=
 flags)
>                 return -ENOENT;
>
>         if (ret < 0)
> -               bpf_any_put(raw, type);
> +               bpf_any_put(raw, type, true);
>         return ret;
>  }
>
> @@ -617,7 +620,7 @@ static void bpf_free_inode(struct inode *inode)
>         if (S_ISLNK(inode->i_mode))
>                 kfree(inode->i_link);
>         if (!bpf_inode_type(inode, &type))
> -               bpf_any_put(inode->i_private, type);
> +               bpf_any_put(inode->i_private, type, false);
>         free_inode_nonrcu(inode);
>  }
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 14f39c1e573ee..87b07ebd6d146 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2777,20 +2777,23 @@ static void bpf_link_put_deferred(struct work_str=
uct *work)
>         bpf_link_free(link);
>  }
>
> -/* bpf_link_put can be called from atomic context, but ensures that reso=
urces
> - * are freed from process context
> +/* bpf_link_put_from_atomic is called from atomic context. It needs to b=
e called
> + * from sleepable context in order to acquire sleeping locks during the =
process.
>   */
> -void bpf_link_put(struct bpf_link *link)
> +void bpf_link_put_from_atomic(struct bpf_link *link)
>  {
>         if (!atomic64_dec_and_test(&link->refcnt))
>                 return;
>
> -       if (in_atomic()) {
> -               INIT_WORK(&link->work, bpf_link_put_deferred);
> -               schedule_work(&link->work);
> -       } else {
> -               bpf_link_free(link);
> -       }
> +       INIT_WORK(&link->work, bpf_link_put_deferred);
> +       schedule_work(&link->work);
> +}
> +
> +void bpf_link_put(struct bpf_link *link)
> +{
> +       if (!atomic64_dec_and_test(&link->refcnt))
> +               return;
> +       bpf_link_free(link);
>  }
>  EXPORT_SYMBOL(bpf_link_put);
>
> --
> 2.40.1
>
