Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC6C355E79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 00:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbhDFWHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 18:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242418AbhDFWHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 18:07:33 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F595C06174A;
        Tue,  6 Apr 2021 15:07:24 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c6so12397566qtc.1;
        Tue, 06 Apr 2021 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FNlQbRYhTWjYAtMu2lcd0x/gAMIkEaGXqaTzkAYm0GA=;
        b=ALgLJwemD7yXgO6M7nRJtlvGlI5tpLemrY1Tyn7XvEksXMUdcNTrwaeGGnOlFNF+gO
         QWTjXW2UZfuDe182r/wp4I1hm86YFa4dDv6CMchywuBj/0suACsDO0Eehj8JvJu1NGNi
         qhErdnrv3Lq1EPq+CI41QaD25QFP48gG5Ih7pr1dxDVbfhH60Z8vlYTmbPY7qWriv8ve
         1BxuDFPTT6TeN0prU+Y58SP1/6QEQMlU/apI4m7CIzTtpt1gYgsBEcgcAf4qoPCdkIC6
         HG2uMLS81IR7kTkJSEG/D8jH+00r4I9wKzVHefAEGAm6lj+SRgWhKPodYjBlWpT4W8IM
         SEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNlQbRYhTWjYAtMu2lcd0x/gAMIkEaGXqaTzkAYm0GA=;
        b=B9BcTZf/7Te3mnv9hClKOMvI9msdLVsMcHL7TGhePWR5fk+7pOSowoeD89CRyRrMj2
         22V8gtg2g9aTw9s4LDCvgKCkdhXUwl26rhkfdJqTiOOYNPWQhM1EDsMAIyNF9/1KIhl1
         SjOjONU224JCHbWz65Uieqe0Y4bq0AUwc0yDrJUzBifZKmEX8iafs85ktyckKnqUqtUB
         zNgwt9pIQsrzz5Gq5SDpJF6Dipx/ZGmdbyOitIKso2LrF6oRa7moGXu035ZZwET5iz08
         QHg8wtpedQLdiKYvRawTYcnAUS+qbT8C7gGCgOSs6/KdeXZMxlz6HvZGeEbHvEg1scQK
         lahQ==
X-Gm-Message-State: AOAM532myrPk6imzdNtuYnor3pBA5PHNz568sZHZspspckuKiJvgyDP7
        ahqZlcf/NuRu5aEwOLOOfcKl7U0qC0o8
X-Google-Smtp-Source: ABdhPJzmBiWMKLQ5BtKcwlgh0HvziOGnZz7O/n7svkO5IG9sJMBtYk2+Zy6rhuqmsGADjREOnO2reQ==
X-Received: by 2002:ac8:544:: with SMTP id c4mr141211qth.248.1617746843799;
        Tue, 06 Apr 2021 15:07:23 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id p186sm17136871qka.66.2021.04.06.15.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 15:07:23 -0700 (PDT)
Date:   Tue, 6 Apr 2021 18:07:21 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hlist-bl: add hlist_bl_fake()
Message-ID: <YGzbmROPKH4F6yDl@moria.home.lan>
References: <20210406123343.1739669-1-david@fromorbit.com>
 <20210406123343.1739669-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406123343.1739669-3-david@fromorbit.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 10:33:42PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> in preparation for switching the VFS inode cache over the hlist_bl
> lists, we nee dto be able to fake a list node that looks like it is
> hased for correct operation of filesystems that don't directly use
> the VFS indoe cache.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

> ---
>  include/linux/list_bl.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
> index ae1b541446c9..8ee2bf5af131 100644
> --- a/include/linux/list_bl.h
> +++ b/include/linux/list_bl.h
> @@ -143,6 +143,28 @@ static inline void hlist_bl_del_init(struct hlist_bl_node *n)
>  	}
>  }
>  
> +/**
> + * hlist_bl_add_fake - create a fake list consisting of a single headless node
> + * @n: Node to make a fake list out of
> + *
> + * This makes @n appear to be its own predecessor on a headless hlist.
> + * The point of this is to allow things like hlist_bl_del() to work correctly
> + * in cases where there is no list.
> + */
> +static inline void hlist_bl_add_fake(struct hlist_bl_node *n)
> +{
> +	n->pprev = &n->next;
> +}
> +
> +/**
> + * hlist_fake: Is this node a fake hlist_bl?
> + * @h: Node to check for being a self-referential fake hlist.
> + */
> +static inline bool hlist_bl_fake(struct hlist_bl_node *n)
> +{
> +	return n->pprev == &n->next;
> +}
> +
>  static inline void hlist_bl_lock(struct hlist_bl_head *b)
>  {
>  	bit_spin_lock(0, (unsigned long *)b);
> -- 
> 2.31.0
> 
