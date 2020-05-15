Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83E91D4C1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgEOLIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 07:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgEOLIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 07:08:34 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ABFC061A0C;
        Fri, 15 May 2020 04:08:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so1890817wmb.4;
        Fri, 15 May 2020 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:references:user-agent:to:cc:subject:in-reply-to
         :message-id:date:mime-version;
        bh=IBPGZ3DM0PlzuvB+YBGLdiafW7KRUg8pjACcdCCPbQQ=;
        b=vfpFrEzXt7bRkWd7gagjNDejTok32gGkPzwqhZpHd0C134h3oAl8HRhvX6mB5dfMnd
         rpnltUZA15oj3RAfRRsF78ar1SSnh1vpdc+jX9ENg1xw7nYLPPebXLy5jnJ4Yxy2RWRo
         VU3aJhXQ3cWMEpsMCSDFJs4jdfhcI9vhQc+fd5EIsPne/1nhjI3Mdi+DK5nW2FtnMz9V
         jLSrUxiOm4sFeQhfERyLSkMU2EsHQVkT6z40ID+ME9KiT1o6/1JmLCfgVQtKnaxjRki9
         f4DFoH0dC64RNYpnDJjPXcVii+/6FXS7Ex90g1sfHTW0jDMz78EJLrHnJ6bCR2X+wJCG
         JEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:references:user-agent:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=IBPGZ3DM0PlzuvB+YBGLdiafW7KRUg8pjACcdCCPbQQ=;
        b=trXLC4nf4fchbTNL9Djj7sl9qFhFEUB6srY7Lmfrlq26ri+MUdxbrnccxIIgyPne91
         SaNBGBAF+2wt5OTwJkhY25Imo2wMB4Xg5OffKE2KSZZF/TZWabiYVcA5wAvmZyokowKN
         sO77Jevsy+NIBiEtwLY3nUcw/w3fwQP7V95magJ4P3bOgnPlFphbJ/MW7M81ljxbP41U
         rOc3EQf/jxrzMsuVY40VqT2SMMqj1BKlzKoVfX1ljs85uPaM/2f+PVeLjQxmSekVtwua
         HeQZ7Tjro6hE6p2BHhGZYmyxJoctYTRNbYf2H2S1KwX3rDdWcrPDSK1vyEM5c0fLxAR6
         fr+A==
X-Gm-Message-State: AOAM532rZbUZ5z4HHr4AeCfHNceqnOWq2xRf+b7MZLySRE1o3gnXwSoU
        zQ5U/0IF1f/ebUlW0XuXB06pLserQq1Uqw==
X-Google-Smtp-Source: ABdhPJwvMYgHBVnayKybHd+BYeUsFVC9sF2kvzHtrvrcCkBDW4cE4KBcAY8XdjdXf+V3/kw+uUFL0w==
X-Received: by 2002:a1c:2348:: with SMTP id j69mr3575311wmj.11.1589540912197;
        Fri, 15 May 2020 04:08:32 -0700 (PDT)
Received: from darkstar ([51.154.17.58])
        by smtp.gmail.com with ESMTPSA id h1sm3186097wme.42.2020.05.15.04.08.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 May 2020 04:08:31 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
X-Google-Original-From: Patrick Bellasi <patrick.bellasi@matbug.com>
References: <20200511154053.7822-1-qais.yousef@arm.com>
User-agent: mu4e 1.4.3; emacs 26.3
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default boost value
In-reply-to: <20200511154053.7822-1-qais.yousef@arm.com>
Message-ID: <873681jw0i.derkling@matbug.com>
Date:   Fri, 15 May 2020 13:08:29 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I Qais,
I see we are converging toward the final shape. :)

Function wise code looks ok to me now.

Lemme just point out few more remarks and possible nit-picks.
I guess at the end it's up to you to decide if you wanna follow up with
a v6 and to the maintainers to decide how picky they wanna be.

Otherwise, FWIW, feel free to consider this a LGTM.

Best,
Patrick

On Mon, May 11, 2020 at 17:40:52 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

[...]

> +static inline void uclamp_sync_util_min_rt_default(struct task_struct *p,
> +						   enum uclamp_id clamp_id)
> +{
> +	unsigned int default_util_min = sysctl_sched_uclamp_util_min_rt_default;
> +	struct uclamp_se *uc_se;
> +
> +	/* Only sync for UCLAMP_MIN and RT tasks */
> +	if (clamp_id != UCLAMP_MIN || !rt_task(p))
> +		return;
> +
> +	uc_se = &p->uclamp_req[UCLAMP_MIN];

I went back to v3 version, where this was done above:

   https://lore.kernel.org/lkml/20200429113255.GA19464@codeaurora.org/
   Message-ID: 20200429113255.GA19464@codeaurora.org

and still I don't see why we want to keep it after this first check?

IMO it's just not required and it makes to code a tiny uglier.

> +
> +	/*
> +	 * Only sync if user didn't override the default request and the sysctl
> +	 * knob has changed.
> +	 */
> +	if (uc_se->user_defined || uc_se->value == default_util_min)
> +		return;
> +

nit-pick: the two comments above are stating the obvious.

> +	uclamp_se_set(uc_se, default_util_min, false);
> +}
> +
>  static inline struct uclamp_se
>  uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>  {
> @@ -907,8 +949,13 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>  static inline struct uclamp_se
>  uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
>  {
> -	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
> -	struct uclamp_se uc_max = uclamp_default[clamp_id];
> +	struct uclamp_se uc_req, uc_max;
> +
> +	/* Sync up any change to sysctl_sched_uclamp_util_min_rt_default. */

same here: the comment is stating the obvious.

Maybe even just by using a different function name we better document
the code, e.g. uclamp_rt_restrict(p, clamp_id);

This will implicitly convey the purpose: RT tasks can be somehow
further restricted, i.e. in addition to the TG restriction following.


> +	uclamp_sync_util_min_rt_default(p, clamp_id);
> +
> +	uc_req = uclamp_tg_restrict(p, clamp_id);
> +	uc_max = uclamp_default[clamp_id];
>  
>  	/* System default restrictions always apply */
>  	if (unlikely(uc_req.value > uc_max.value))

[...]

