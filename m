Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C902E7FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 00:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfE2WRW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 18:17:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39046 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfE2WRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 18:17:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id f1so3360600lfl.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIvU+ha0PviU/sibSkvPHyTumVcfp/XuVnG8TGWl1tg=;
        b=IhDJTlpcamR/KqtIXXIXgJdfXAsLI2C+ZEXAuUNYlKWGn6wHjE6fpIPNIeDhT7ycQ8
         57igNJrmJ5BNTBnviUUG/OZd+IF7VgnoVis5ZCCvJxb17ZrBByYBXhXN+ZRYNnc3FRIy
         brSYU1jvKSGa+TNQ8WETswSfhGeqztSbfJ7L/bGXevP+zB/TZdI4CXbRsu2J41G+yDwo
         qMRxFM1D7xND12GCJwbw+whugNAe6MnXELtdl7/PWacMAbHfg0mkPJsrxG4ICI+/4Bgd
         Umpf4FN+xj/KrTwt5uEEEDaa00hFCmx8k3DNIvdAxi+WqGo7sS1kO5oJBoew7DOwAn5i
         7ioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIvU+ha0PviU/sibSkvPHyTumVcfp/XuVnG8TGWl1tg=;
        b=pD5NUYCLu/Ds3AKSB8H8aDKsTbpSggYFOGQJSkiGaFeVn0vJbJAgCCSRBD5cu5uILt
         AsP70uUItsvkMBNNeghrOqAgK57GPkF//bF2z4e+TJR0P4pdab+uuv+rWS3/7vT9PKBU
         3OAHstpzmTVNDsQFHT13Fc2Mt2ri/8G9bfVQvJ/Q0RQqU9P9koZdcUEsjJ+BCzbnC0E+
         dc2ZMut9O53W4Aky7eHZrQDfgaIXpQch+ndaS9ShrQpcjKGnJIF4WGBa39bhRvatqTHI
         86IyMaA9P9tnb9gSEVsDUEyi55YZP7l0a1e729ZRDBi7ealbj6BCpaDLYdEOW55q4vYx
         XaFg==
X-Gm-Message-State: APjAAAXxYIgYtHTQ1d1Eygfe75Kzko005+hNr+BzxuiSXo99qOeBDj/f
        EZ38sCQnHuwgfjCv2VRoD8FRjdtDoYzLxas0FtAs
X-Google-Smtp-Source: APXvYqyxrQhJxL6YTK1IQrRGp/CVZ4FR/LfHLvH12rSsobg2OWRzTR6O4bHJaXr5UpPyFchEPI025JnE2t3cIS5I/r8=
X-Received: by 2002:a19:c301:: with SMTP id t1mr140375lff.137.1559168239261;
 Wed, 29 May 2019 15:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554732921.git.rgb@redhat.com> <423ed5e5c5e4ed7c3e26ac7d2bd7c267aaae777c.1554732921.git.rgb@redhat.com>
In-Reply-To: <423ed5e5c5e4ed7c3e26ac7d2bd7c267aaae777c.1554732921.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 May 2019 18:17:08 -0400
Message-ID: <CAHC9VhQ9t-mvJGNCzArjg+MTGNXcZbVrWV4=RUD5ML_bHqua1Q@mail.gmail.com>
Subject: Re: [PATCH ghak90 V6 09/10] audit: add support for containerid to
 network namespaces
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 8, 2019 at 11:41 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Audit events could happen in a network namespace outside of a task
> context due to packets received from the net that trigger an auditing
> rule prior to being associated with a running task.  The network
> namespace could be in use by multiple containers by association to the
> tasks in that network namespace.  We still want a way to attribute
> these events to any potential containers.  Keep a list per network
> namespace to track these audit container identifiiers.
>
> Add/increment the audit container identifier on:
> - initial setting of the audit container identifier via /proc
> - clone/fork call that inherits an audit container identifier
> - unshare call that inherits an audit container identifier
> - setns call that inherits an audit container identifier
> Delete/decrement the audit container identifier on:
> - an inherited audit container identifier dropped when child set
> - process exit
> - unshare call that drops a net namespace
> - setns call that drops a net namespace
>
> Please see the github audit kernel issue for contid net support:
>   https://github.com/linux-audit/audit-kernel/issues/92
> Please see the github audit testsuiite issue for the test case:
>   https://github.com/linux-audit/audit-testsuite/issues/64
> Please see the github audit wiki for the feature overview:
>   https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Neil Horman <nhorman@tuxdriver.com>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/audit.h | 19 +++++++++++
>  kernel/audit.c        | 88 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  kernel/nsproxy.c      |  4 +++
>  3 files changed, 108 insertions(+), 3 deletions(-)

...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 6c742da66b32..996213591617 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -376,6 +384,75 @@ static struct sock *audit_get_sk(const struct net *net)
>         return aunet->sk;
>  }
>
> +void audit_netns_contid_add(struct net *net, u64 contid)
> +{
> +       struct audit_net *aunet;
> +       struct list_head *contid_list;
> +       struct audit_contid *cont;
> +
> +       if (!net)
> +               return;
> +       if (!audit_contid_valid(contid))
> +               return;
> +       aunet = net_generic(net, audit_net_id);
> +       if (!aunet)
> +               return;
> +       contid_list = &aunet->contid_list;
> +       spin_lock(&aunet->contid_list_lock);
> +       list_for_each_entry_rcu(cont, contid_list, list)
> +               if (cont->id == contid) {
> +                       refcount_inc(&cont->refcount);
> +                       goto out;
> +               }
> +       cont = kmalloc(sizeof(struct audit_contid), GFP_ATOMIC);
> +       if (cont) {
> +               INIT_LIST_HEAD(&cont->list);

I thought you were going to get rid of this INIT_LIST_HEAD() call?

> +               cont->id = contid;
> +               refcount_set(&cont->refcount, 1);
> +               list_add_rcu(&cont->list, contid_list);
> +       }
> +out:
> +       spin_unlock(&aunet->contid_list_lock);
> +}

--
paul moore
www.paul-moore.com
