Return-Path: <linux-fsdevel+bounces-151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9507C63B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 06:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D36282796
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 04:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73F3611E;
	Thu, 12 Oct 2023 04:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwx9ODPN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137D20EE
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 04:09:23 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A4CB8
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 21:09:21 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso199825276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 21:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697083760; x=1697688560; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3eZtbO7sGiUdIhODmQ6vSPYTozABWE/uP0uElHmIZc=;
        b=bwx9ODPNNDPDbMUnIKhSU/DEB093iDQeKXp27IKtzl43IXu/mAsnQC0dA80jwugVfP
         KMYifPYmiH/F+tG0zXHqGb1VcpXtChnZyPJaG/DscPQRqtm7l5LVo40iMW+so2fxtkCp
         OQd34IFFOUYDYAdhDoo+jKgdrrRmk+0hKEoQqCaFmErRxiFg3eCwCyB0XyFal3eEICVX
         gy/ulDAgJp+T7QF1hpAMuxKtfYk6UhQq7YgqHEMsgfY4cEqJRsq0xz2KbiyN9HVjES17
         NGlZzR5FR/nh2juQI2Xw/D57yHcy9kirq9UkgP05d4CRi1tT3LFsgpIbZwf+T5B8Wgv7
         Sbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697083760; x=1697688560;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3eZtbO7sGiUdIhODmQ6vSPYTozABWE/uP0uElHmIZc=;
        b=gTDRQUKOTepweCXK2sUtdxi9k+Q46kgat1LcrBEmUwTw/EPqOZjqTeiBHIHYVO96wi
         XoEXl0WOMFrAs1hXOAhXRpUUDRnQM01gFB5YjzfED0r7GsOR7LfsDOrwRfPGLMJtSa/F
         AdsJDxU77TyCYMFiDsX0FHh3a9Y0v8oFjSG9TtMW/MqvNXIO4ur2EHysIn1GGxPnFw0T
         W1eSq+nhL4E+Stv33qG+D0AsG3jpBJidf69VUQUPDD54AdQZ6MhkYIXKlM3XVbOQCIXO
         0qGMj/9QoBW0Y380wworksXYx2YYfYqJHfeHMZehamUgto92+1cKgclt4ilEP4lkR8fR
         Z7Qg==
X-Gm-Message-State: AOJu0YyVqYvERqS3/T6PvR42O2KHgYuLtWoDkV6J1U0Mojr7zEoYfyDq
	ubi8dmUgvJ1WYvIq7OOAYVbOSw==
X-Google-Smtp-Source: AGHT+IGBjSt9U3Lcb7U+xPW4tDBHFN+LRgiJXQXfyU6HuAimlavU+lytPlZrRXik3VKiQGg74BAbxA==
X-Received: by 2002:a25:8906:0:b0:d9a:b844:a16 with SMTP id e6-20020a258906000000b00d9ab8440a16mr859246ybl.16.1697083760445;
        Wed, 11 Oct 2023 21:09:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r127-20020a254485000000b00d7360e0b240sm4936554yba.31.2023.10.11.21.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 21:09:19 -0700 (PDT)
Date: Wed, 11 Oct 2023 21:09:06 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Dennis Zhou <dennisszhou@gmail.com>
cc: Hugh Dickins <hughd@google.com>, "Chen, Tim C" <tim.c.chen@intel.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, 
    Christian Brauner <brauner@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
    Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
    Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 8/8] shmem,percpu_counter: add _limited_add(fbc, limit,
 amount)
In-Reply-To: <ZSCRU/e1dwMftYLC@snowbird>
Message-ID: <f3689af7-ddf6-d4a9-b9d3-cdca15339900@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com> <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com> <DM6PR11MB4107F132CC1203486A91A4DEDCCAA@DM6PR11MB4107.namprd11.prod.outlook.com> <17877ef1-8aac-378b-94-af5afa2793ae@google.com>
 <ZSCRU/e1dwMftYLC@snowbird>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 6 Oct 2023, Dennis Zhou wrote:
> 
> Sorry for the late chime in. I'm traveling right now.

No problem at all, thanks for looking.

> 
> I haven't been super happy lately with percpu_counter as it has had a
> few corner cases such as the cpu_dying_mask fiasco which I thought we
> fixed with a series from tglx [1]. If not I can resurrect it and pull
> it.
> 
> I feel like percpu_counter is deviating from its original intended
> usecase which, from my perspective, was a thin wrapper around a percpu
> variable. At this point we seem to be bolting onto percpu_counter
> instead of giving it a clear focus for what it's supposed to do well.
> I think I understand the use case, and ultimately it's kind of the
> duality where I think it was xfs is using percpu_counters where it must
> be > 0 for the value to make sense and there was a race condition with
> cpu dying [2].
> 
> At this point, I think it's probably better to wholy think about the
> lower bound and upper bound problem of percpu_counter wrt the # of
> online cpus.
> 
> Thanks,
> Dennis
> 
> [1] https://lore.kernel.org/lkml/20230414162755.281993820@linutronix.de/
> [2] https://lore.kernel.org/lkml/20230406015629.1804722-1-yebin@huaweicloud.com/

Thanks for the links.  I can see that the current cpu_dying situation
is not ideal, but don't see any need to get any deeper into that for
percpu_counter_limited_add(): I did consider an update to remove its
use of cpu_dying_mask, but that just seemed wrong - it should do the
same as is currently done in __percpu_counter_sum(), then be updated
along with that when cpu_dying is sorted, by tglx's series or otherwise.

I don't think I agree with you about percpu_counter deviating from its
original intended usecase; but I haven't studied the history to see what
that initial usecase was.  Whatever, we've had percpu_counter_add() and
percpu_counter_compare() for many years, and percpu_counter_limited_add()
is just an atomic combination of those: I don't see it as deviating at all.

Hugh

