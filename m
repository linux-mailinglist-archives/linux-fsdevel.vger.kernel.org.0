Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF63214D76
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGEPLZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 11:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgGEPLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:11:24 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448B6C08C5DE
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jul 2020 08:11:24 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w16so39761775ejj.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2020 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tHsNsc85oEMgxfMe/9ECsv9KY90m64bzbMRR9357CU=;
        b=Hbpzh2mkywq3PINoKnKvIeWREaFlJ3B37cTwpnx5RerTgpbuKhSZPwrsl1vLicqVxn
         ppPB4hWBeYerbw9BThTxK+n8qqf2CdjU6s1IapyqlR2OMNy+nRTlEXRsvO55prOmzSfR
         GdJuNL11UHoSywYCM3N0fE+L0KDjyeW5bA0QLIHmCIHZMOCWUhHXaRZ43bxKjdjMI7bD
         l+lzN56NXJzBqSPgPsICGEuAOksqaFb7tK3H4T7GjSYbz1pnMTuBMKKgASJ99mLUoqmU
         dkZrcvT0qaRaKCHuU/YsajwEu9OLxgMbwVVylVTd94Q+LxGxTmDXntTiK6+kU/1BOiQp
         yhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tHsNsc85oEMgxfMe/9ECsv9KY90m64bzbMRR9357CU=;
        b=qmyBtNiL3VYQqpJsIkJlxdJ1/eux7OH9SIo6Cmh4W7cVVvPoJ7PkdnMGW60WT24w1E
         emGDF3kHic0cdmZ05xsZZWtxyNrmoNLG/XiJywcsVKE68ENoDP4siq83Myr/MM741xf8
         mGcdwvC6A64oB/C9oEDlxwq2Lbvm2pPIBeJSu1l3ZTW2nbk3OhbrfCTErFa+uXDu0wPB
         tLygCDfEeJn9EplzONOHxKsTJ05DpblmLvh/5xYbBfHIOknCRg0H3pXiYv9rVwv/pKWK
         GqYE9+uHUUPnvc+Pjq8VuSf1RrJGKbwkr79HEQhHy2jZmpmAZIQgEFpaLM3iMURmWqMA
         smhw==
X-Gm-Message-State: AOAM533w25ctxMry54EgPhRmc1ZUw+b8nAoynznm53zaqHLnSE5q0ess
        L2eTUr2DY0UAw++ObiLTr4wj9NsL9ZpHdDAQo9DT
X-Google-Smtp-Source: ABdhPJykYYlS6DyRXswVmWtbu7A3Q6Dy8mVKkx1CmIV5P5PACrs0bkv1logTfFs6fMkOIf3NdUb1tBevQz1LKf/qCoI=
X-Received: by 2002:a17:906:aac9:: with SMTP id kt9mr36448175ejb.488.1593961882949;
 Sun, 05 Jul 2020 08:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <4a5019ed3cfab416aeb6549b791ac6d8cc9fb8b7.1593198710.git.rgb@redhat.com>
In-Reply-To: <4a5019ed3cfab416aeb6549b791ac6d8cc9fb8b7.1593198710.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Jul 2020 11:11:11 -0400
Message-ID: <CAHC9VhSwMEZrq0dnaXmPi=bu0NgUtWPuw-2UGDrQa6TwxWkZtw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 08/13] audit: add containerid support for user records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, Ondrej Mosnacek <omosnace@redhat.com>,
        dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 27, 2020 at 9:23 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Add audit container identifier auxiliary record to user event standalone
> records.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Neil Horman <nhorman@tuxdriver.com>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  kernel/audit.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 54dd2cb69402..997c34178ee8 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1507,6 +1504,14 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                                 audit_log_n_untrustedstring(ab, str, data_len);
>                         }
>                         audit_log_end(ab);
> +                       rcu_read_lock();
> +                       cont = _audit_contobj_get(current);
> +                       rcu_read_unlock();
> +                       audit_log_container_id(context, cont);
> +                       rcu_read_lock();
> +                       _audit_contobj_put(cont);
> +                       rcu_read_unlock();
> +                       audit_free_context(context);

I haven't searched the entire patchset, but it seems like the pattern
above happens a couple of times in this patchset, yes?  If so would it
make sense to wrap the above get/log/put in a helper function?

Not a big deal either way, I'm pretty neutral on it at this point in
the patchset but thought it might be worth mentioning in case you
noticed the same and were on the fence.

--
paul moore
www.paul-moore.com
