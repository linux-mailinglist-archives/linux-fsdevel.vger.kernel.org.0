Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F9925A99E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIBKmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 06:42:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23913 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726210AbgIBKmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 06:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599043323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XTJszgpitbKy6L/bz9FscoxSm/bsss/3ul4CvvkCk0=;
        b=RdGiGVQeJ3K8ntQrvHVY30nK4Sv82cTLzub+ITZiMne4H3eVwWIf84oSCeTKjhR/SK0F3H
        90e+qVpxL2HCGR4KBSOKspUIjS+DoF/KyAbD+xSAsdUiRYlmxfmNMgJFF2RIciEf9pE5kO
        pAJ48mJYz0xXFFy4QYcNxpfaFNVzvhg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-3Iw9wJetMVmiC4msSi2PSw-1; Wed, 02 Sep 2020 06:42:01 -0400
X-MC-Unique: 3Iw9wJetMVmiC4msSi2PSw-1
Received: by mail-qk1-f197.google.com with SMTP id r4so3067411qkb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2020 03:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+XTJszgpitbKy6L/bz9FscoxSm/bsss/3ul4CvvkCk0=;
        b=PoYb+DcgHzs5MNTm8SrINPgaJA2OH93pGELupVhZp91lwWp5oKly0dUAfCfyWsTOEY
         jNiLO9LeObHNkBJB3N4MmWs/IoedcbS7PZlyMi4JFTadRSR5QXEzzrd2QYga6EPAoLle
         5vgor3q1T4EG83MRXPB8s5t/kc+vZ7+OHN0ASZqUVKG2by5QQK2wk+4ijMfLVxMqVS1K
         ZfN4LcC/7N5y0WxBJM5ui/7kpX7cBQtMgNgUG7BzQw0+/pm11Fi2EwUVhHu1a4aMD0nd
         d8pJS5LMGmV0BkBf4PyiaAnU5Mkbf+vI8sw1mPew0S7NSp/K9ZBwhQneDtkvz4tdk9+n
         EBgw==
X-Gm-Message-State: AOAM533M3/vEzG+yvkrSJEDtdPbCvv6mJMlCATSrkw4mPFAJnj9g/oGI
        W3nu9UO2jo+nW3zuXyrlqdGgcw0UytJibPGTzhbOAp+TsWFlGy/94TUIWa3zg+l1ek15bXE9r18
        L8yY3o8Dj4WOipCndCUDWtLrqfg==
X-Received: by 2002:a37:44e:: with SMTP id 75mr6271610qke.236.1599043321440;
        Wed, 02 Sep 2020 03:42:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydItcC9yhjtJPA+8Ykqgjjx2YVnGgomTGpWbhIspqcvlyiSlUxktfFIf2XXPCUlf18IhySRA==
X-Received: by 2002:a37:44e:: with SMTP id 75mr6271599qke.236.1599043321245;
        Wed, 02 Sep 2020 03:42:01 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id n204sm316030qke.62.2020.09.02.03.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 03:42:00 -0700 (PDT)
Message-ID: <5f6a8b4a9c3a14c83ec314fef90c8c3391616a55.camel@redhat.com>
Subject: Re: [PATCH] locks: Remove extra "0x" in tracepoint format specifier
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org
Date:   Wed, 02 Sep 2020 06:41:59 -0400
In-Reply-To: <159889642439.7305.8036885243386192344.stgit@klimt.1015granger.net>
References: <159889642439.7305.8036885243386192344.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-31 at 13:54 -0400, Chuck Lever wrote:
> Clean up: %p adds its own 0x already.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/trace/events/filelock.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
> index c705e4944a50..1646dadd7f37 100644
> --- a/include/trace/events/filelock.h
> +++ b/include/trace/events/filelock.h
> @@ -92,7 +92,7 @@ DECLARE_EVENT_CLASS(filelock_lock,
>  		__entry->ret = ret;
>  	),
>  
> -	TP_printk("fl=0x%p dev=0x%x:0x%x ino=0x%lx fl_blocker=0x%p fl_owner=0x%p fl_pid=%u fl_flags=%s fl_type=%s fl_start=%lld fl_end=%lld ret=%d",
> +	TP_printk("fl=%p dev=0x%x:0x%x ino=0x%lx fl_blocker=%p fl_owner=%p fl_pid=%u fl_flags=%s fl_type=%s fl_start=%lld fl_end=%lld ret=%d",
>  		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
>  		__entry->i_ino, __entry->fl_blocker, __entry->fl_owner,
>  		__entry->fl_pid, show_fl_flags(__entry->fl_flags),
> @@ -145,7 +145,7 @@ DECLARE_EVENT_CLASS(filelock_lease,
>  		__entry->fl_downgrade_time = fl ? fl->fl_downgrade_time : 0;
>  	),
>  
> -	TP_printk("fl=0x%p dev=0x%x:0x%x ino=0x%lx fl_blocker=0x%p fl_owner=0x%p fl_flags=%s fl_type=%s fl_break_time=%lu fl_downgrade_time=%lu",
> +	TP_printk("fl=%p dev=0x%x:0x%x ino=0x%lx fl_blocker=%p fl_owner=%p fl_flags=%s fl_type=%s fl_break_time=%lu fl_downgrade_time=%lu",
>  		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
>  		__entry->i_ino, __entry->fl_blocker, __entry->fl_owner,
>  		show_fl_flags(__entry->fl_flags),
> @@ -195,7 +195,7 @@ TRACE_EVENT(generic_add_lease,
>  		__entry->fl_type = fl->fl_type;
>  	),
>  
> -	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=0x%p fl_flags=%s fl_type=%s",
> +	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=%p fl_flags=%s fl_type=%s",
>  		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
>  		__entry->i_ino, __entry->wcount, __entry->rcount,
>  		__entry->icount, __entry->fl_owner,
> @@ -228,7 +228,7 @@ TRACE_EVENT(leases_conflict,
>  		__entry->conflict = conflict;
>  	),
>  
> -	TP_printk("conflict %d: lease=0x%p fl_flags=%s fl_type=%s; breaker=0x%p fl_flags=%s fl_type=%s",
> +	TP_printk("conflict %d: lease=%p fl_flags=%s fl_type=%s; breaker=%p fl_flags=%s fl_type=%s",
>  		__entry->conflict,
>  		__entry->lease,
>  		show_fl_flags(__entry->l_fl_flags),
> 
> 

Thanks, Chuck! I've pulled this into linux-next for now and it should
make v5.10.
-- 
Jeff Layton <jlayton@redhat.com>

