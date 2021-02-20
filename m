Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1143206CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 20:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBTTNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 14:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhBTTNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:13:24 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2CC061574;
        Sat, 20 Feb 2021 11:12:44 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b145so4069667pfb.4;
        Sat, 20 Feb 2021 11:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCUJuiuY9ImPZDy5gp8HkT1sX9iXGmZBVPPpZjV0Ekk=;
        b=qzN/R/a4nQ4sWoBSqu8DusatbUCaG9iu98obAWoqdH89gN5BTbKJ0EphpRPKVU9JdH
         SulpF7DRdLV9jgmNQtYBZjjoVADUu0oD9tjVuju7p59tbe3N9f2u3bNHljMlVOzED9TM
         b/1S4wzAUQwGBK3ToBfZeHekI7oujbkRSWRuylQY+F8aPvxmeouOJSuoCfi38S0wH1XY
         PfWli9UEWmMerM4rE/3NE+le8EDuPX3QddDrFUk3KhacPUNd+G2+8uOPE+magTHcX3LC
         Z28GyHEcJiVti3tcSKa6ifZsQVxC1umOjCxg9rSRMNEfUvWixb99RkWQNgXdizE3mumh
         MKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCUJuiuY9ImPZDy5gp8HkT1sX9iXGmZBVPPpZjV0Ekk=;
        b=E5qunurTE6SzgPtNz7ZIjlmeH/bSU49Usn3F15xG7Px1ZRIeJkK8Er1bqnQP3bYo/N
         hSEDvPoNDKOV3tgLGgK7TV+763O9CwERgQ/D3A19z3JA5tsmvz2+9wtFa3dGrbJZMag2
         /WqZimtoSVdY49c1Kh6uT/7At0mdDs5Y4ueXrScajEvNEMs+lk8i/rJ6su43EMW4jY+r
         cTLFZ8krL+WuzLCrDlIoENMWfo9WJo498hcbxQ1eDEfPVoD9fFxPnoV0f7ccKAdzHlFX
         oYFgkNoocxmMJFtQeG+XfLbzBtfaa0urh3/bHQruItMLvgBPlowsnNTBGchdRjgCN1M0
         ZeXg==
X-Gm-Message-State: AOAM530BMkju7GBwOGIN9Wcd6++HF/EcpnRVUg0qd4d/uoVntJCN2fZt
        mr8j5xa6gGWxHQukwTUo5Z3IV4sIxO7lbFQoaX8=
X-Google-Smtp-Source: ABdhPJyp4HlnmV7Eqn8Xr8nC6MPAVuIsRn/kjr8NVF51K5no/1Ln7G+vr/KHutSBYQFlI7UuJqXgwJK9fOD9NWpqWXg=
X-Received: by 2002:a63:e109:: with SMTP id z9mr13566082pgh.5.1613848364207;
 Sat, 20 Feb 2021 11:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20210125154937.26479-1-kda@linux-powerpc.org> <20210127175742.GA1744861@infradead.org>
 <CAOJe8K0MC-TCURE2Gpci1SLnLXCbUkE7q6SS0fznzBA+Pf-B8Q@mail.gmail.com>
 <20210129082524.GA2282796@infradead.org> <CAOJe8K0iG91tm8YBRmE_rdMMMbc4iRsMGYNxJk0p9vEedNHEkg@mail.gmail.com>
 <20210129131855.GA2346744@infradead.org> <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
 <CAOJe8K00srtuD+VAJOFcFepOqgNUm0mC8C=hLq2=qhUFSfhpuw@mail.gmail.com>
 <YCwIQmsxWxuw+dnt@zeniv-ca.linux.org.uk> <YC86WeSTkYZqRlJY@zeniv-ca.linux.org.uk>
 <YC88acS6dN6cU1y0@zeniv-ca.linux.org.uk>
In-Reply-To: <YC88acS6dN6cU1y0@zeniv-ca.linux.org.uk>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat, 20 Feb 2021 11:12:33 -0800
Message-ID: <CAM_iQpVpJwRNKjKo3p1jFvCjYAXAY83ux09rd2Mt0hKmvx=RgQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] af_unix: take address assignment/hash insertion into
 a new helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Denis Kirjanov <kda@linux-powerpc.org>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 8:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Duplicated logics in all bind variants (autobind, bind-to-path,
> bind-to-abstract) gets taken into a common helper.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  net/unix/af_unix.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 41c3303c3357..179b4fe837e6 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -262,6 +262,16 @@ static void __unix_insert_socket(struct hlist_head *list, struct sock *sk)
>         sk_add_node(sk, list);
>  }
>
> +static void __unix_set_addr(struct sock *sk, struct unix_address *addr,
> +                           unsigned hash)
> +       __releases(&unix_table_lock)
> +{
> +       __unix_remove_socket(sk);
> +       smp_store_release(&unix_sk(sk)->addr, addr);
> +       __unix_insert_socket(&unix_socket_table[hash], sk);
> +       spin_unlock(&unix_table_lock);

Please take the unlock out, it is clearly an anti-pattern.

And please Cc netdev for networking changes.

Thanks.
