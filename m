Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8198673F467
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 08:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjF0GUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 02:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF0GUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:20:22 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA869E52;
        Mon, 26 Jun 2023 23:20:21 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-43f4167d2b5so1147707137.2;
        Mon, 26 Jun 2023 23:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687846820; x=1690438820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS+/DS6a2ZYIFGecpsQdsKJGuE+9ACCGxU7vGr6grZo=;
        b=iVaPXWK9tZSiTjDa5a8NN2c6GzXqjIqFOiq69070t0z3VV8YMemqpA+GR8Qet7YseR
         IbHBccyauw7G68TJUEqt6wym94Zx8gjQ0jLbQEHqUuT1U3XS/ZfumEzfF2jk6zJbgUov
         KXwbJOLAncKU+YnC6L/lf9eWI/7i/F9uNjc8yqIH8scuI83VI/m0EKWQcRLLqCB51SKT
         BDomQ9atYo0WjImVB40m0eAOqzZAwRSvT5ghWvyGt7pXh8FsWAd8FCvvQIc4xzDubwar
         cY94FPb8FQJEza0h+BTmo58Fw/oijiAz/WqMzsg0hdm5lUK3S5ykM7nQuHAwoZNAby6H
         GQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687846820; x=1690438820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS+/DS6a2ZYIFGecpsQdsKJGuE+9ACCGxU7vGr6grZo=;
        b=ITMxpcWZaV0jmOGixbBdSlAcb2WxXIPOWreL7p0E1NFcaS6zWI2yU4zhNAuFIe7jqO
         1O/Ww7lZbIDyJctmHEW6iDZY0MaXz9MAPgZNNIl6xy7mImSMYdGFLTeHkZhCd8WYW19Z
         elxZvWWCPZaNpr9SWeYhJ4vJ+TC81rmaX2KchXWVNfsxeD5kvskWhI+Mb4yb8nPN0NUb
         klisR7e6beYdk27ZyrkwlmGoS9Xi6cgrpxjhnStfnAR/DF3CmKlzeO6Sh3T3yua5blXi
         z5eBF5Koldo0OTICIF+6e6UpGtFh75rGX6VsVDSvnBXyUa5vaGFedogHooc9SkxuaBYh
         2njw==
X-Gm-Message-State: AC+VfDx/YZ/ldfgnJPwzX5pRPsPDuhyW5zTGWgSnOndWlfsr2SmveHBZ
        jlP3zRoGaQ8AdBAYWb6nQjnk0RPCfaJkmw6BY5A=
X-Google-Smtp-Source: ACHHUZ5APtrw6EbTALR7i+Yi6sAOVvsG9V6EW3lvUsMAdgWgkMerHr1dvt7+ErqrEbdId5uIw4N/ijFNMx6QaqkdgJA=
X-Received: by 2002:a05:6102:95:b0:443:5aea:408f with SMTP id
 t21-20020a056102009500b004435aea408fmr2282548vsp.27.1687846820694; Mon, 26
 Jun 2023 23:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxj_DLm8_stRJPR7i8bp9aJ5VtjzWqHL2egCTKe3M-6KSw@mail.gmail.com>
 <sun5nn6nzp7cvn43m7476rchcel42zuxv6mo2fab6tu24wc2it@intt5usuvpoq>
In-Reply-To: <sun5nn6nzp7cvn43m7476rchcel42zuxv6mo2fab6tu24wc2it@intt5usuvpoq>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Jun 2023 09:20:09 +0300
Message-ID: <CAOQ4uxhz1HqJMxB4tgc4dOXZ6soG5zij9UcRu4__N6b0jYtHmw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] splice: fsnotify_access(in), fsnotify_modify(out)
 on success in tee
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>
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

On Tue, Jun 27, 2023 at 2:09=E2=80=AFAM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> Same logic applies here: this can fill up the pipe, and pollers that rely
> on getting IN_MODIFY notifications never wake up.
>
> Fixes: 983652c69199 ("splice: report related fsnotify events")
> Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffy=
js3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>

Makes sense.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/splice.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index a18274209dc1..3234aaa6e957 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1819,6 +1819,11 @@ long do_tee(struct file *in, struct file *out, siz=
e_t len, unsigned int flags)
>                 }
>         }
>
> +       if (ret > 0) {
> +               fsnotify_access(in);
> +               fsnotify_modify(out);
> +       }
> +
>         return ret;
>  }
>
> --
> 2.39.2
