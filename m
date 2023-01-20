Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF5E675D3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 19:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjATS7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 13:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjATS7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:59:12 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC740743B7
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 10:59:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so9963910pjm.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 10:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vGi7Fd7MCMNA1QbBTQeJ0YgM+KM/Q0j6YdyrOcqHQyg=;
        b=ViH4SFAYoJcKC3JvCi+t/v1dJudaXxAaoV4xT+2F3ReKac3Fodcu0WsiO+d9lZtKIe
         onk0aFZu1AFUSjl+23eZPaneXHe64JzGmdkMFTTeDRf9KxthsIfCuO8QjlFH5q/uCk5L
         yGtzcFS+r+aIAmhbwTd5BfN0RWA1DGpjYj2U7cZGuwcUTpeAqWUTnLu/q0JR6M+eiQzV
         b/lX+eYxUV4af4KjioSy+LP1p82H6LZm8H2pmOc/we5nMxEYgZHmDAgRZD+Jrc3WymfY
         98ZzUGR7AQRCtRXBYU17T2XS2JrWFaUZszT8lqs3b4VuMRB15uNaYUClbyEnSVqcvfLw
         oaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGi7Fd7MCMNA1QbBTQeJ0YgM+KM/Q0j6YdyrOcqHQyg=;
        b=Bn0vgtS+nZHszneK8h3jKNDjPq1JfyRnECMDys7dniORcFHYfA+CPS6MTzcfzsPxxo
         SVTNLGdIt7N8pStvsIzBb83snbzdMKQGMwZo5piB+1QshiQwBrUwSpt0JbOVuLVTD8y3
         RvDSgvA7yKwHTnQI8Rxz+Rj8NB37LMqi6m5iTqaZf4l4sAFjHskHoFk9kn/Wy0a1wR+G
         ql1Dy3G9qUVLMJdzaixQxQ7WrjrLL6wRmyz20wubChjbEP1oO04uSDkCBkl23PuCD1AA
         x4xF2v5mJJ/iiP/dL3HodIyeGFWCHvrTPNO2nfXdOpqROdelR8X8FcjV7xMNQ/4ypGGw
         VjyA==
X-Gm-Message-State: AFqh2kqOz8hdQeME2ie/NAlHeCC2q7BPCfkGAGAb3nBKbQNf2w26UXtV
        I8DyyH8s5Zs2zbaAKnPZ24hWrkZVH4brRO/sIjn32UNXc7EUCYQ=
X-Google-Smtp-Source: AMrXdXv1EvsSKj6cBEZSgfojuR+NDh6GI91jSVXXXVvUq1XUrgEqDaNqOzBTs/FIVGle64jfvZ5hUS6q9GmG9EWAy7I=
X-Received: by 2002:a17:90a:c784:b0:227:202b:8eaa with SMTP id
 gn4-20020a17090ac78400b00227202b8eaamr1704350pjb.147.1674241144111; Fri, 20
 Jan 2023 10:59:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673989212.git.rgb@redhat.com> <82aba376bfbb9927ab7146e8e2dee8d844a31dc2.1673989212.git.rgb@redhat.com>
In-Reply-To: <82aba376bfbb9927ab7146e8e2dee8d844a31dc2.1673989212.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Jan 2023 13:58:53 -0500
Message-ID: <CAHC9VhTgesdmF3-+oP-EYuNZ-8LKXGPYuSffVst_Wca5Oj0EAQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] fanotify,audit: Allow audit to use the full
 permission event response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 4:14 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> This patch passes the full response so that the audit function can use all
> of it. The audit function was updated to log the additional information in
> the AUDIT_FANOTIFY record.
>
> Currently the only type of fanotify info that is defined is an audit
> rule number, but convert it to hex encoding to future-proof the field.
> Hex encoding suggested by Paul Moore <paul@paul-moore.com>.
>
> The {subj,obj}_trust values are {0,1,2}, corresponding to no, yes, unknown.
>
> Sample records:
>   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3137 subj_trust=3 obj_trust=5
>   type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F subj_trust=2 obj_trust=2
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/notify/fanotify/fanotify.c |  3 ++-
>  include/linux/audit.h         |  9 +++++----
>  kernel/auditsc.c              | 16 +++++++++++++---
>  3 files changed, 20 insertions(+), 8 deletions(-)

...

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d1fb821de104..3133c4175c15 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2877,10 +2878,19 @@ void __audit_log_kern_module(char *name)
>         context->type = AUDIT_KERN_MODULE;
>  }
>
> -void __audit_fanotify(u32 response)
> +void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
>  {
> -       audit_log(audit_context(), GFP_KERNEL,
> -               AUDIT_FANOTIFY, "resp=%u", response);
> +       /* {subj,obj}_trust values are {0,1,2}: no,yes,unknown */
> +       if (friar->hdr.type == FAN_RESPONSE_INFO_NONE) {
> +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> +                         "resp=%u fan_type=%u fan_info=3F subj_trust=2 obj_trust=2",
> +                         response, FAN_RESPONSE_INFO_NONE);
> +               return;
> +       }
> +       audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> +                 "resp=%u fan_type=%u fan_info=%X subj_trust=%u obj_trust=%u",
> +                 response, friar->hdr.type, friar->rule_number,
> +                 friar->subj_trust, friar->obj_trust);
>  }

The only thing that comes to mind might be to convert the if-return
into a switch statement to make it a bit cleaner and easier to patch
in the future, but that is soooo far removed from any real concern
that I debated even mentioning it.  I only bring it up in case the
"3F" discussion results in a respin, and even then I'm not going to
hold my ACK over something as silly as a if-return vs switch.

For clarity, this is what I was thinking:

void __audit_fanontify(...)
{
  switch (type) {
  case FAN_RESPONSE_INFO_NONE:
    audit_log(...);
    break;
  default:
    audit_log(...);
  }
}

-- 
paul-moore.com
