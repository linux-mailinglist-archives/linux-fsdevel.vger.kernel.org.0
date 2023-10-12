Return-Path: <linux-fsdevel+bounces-192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ACF7C74CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 19:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3F0282C41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 17:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EA936AF2;
	Thu, 12 Oct 2023 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9JvIr2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6193266BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 17:31:11 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03249182;
	Thu, 12 Oct 2023 10:31:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9b95943beso10873895ad.1;
        Thu, 12 Oct 2023 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131869; x=1697736669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1DANaDEHOucqubqJ4/b/aNrMNFhI1eFitx/RoQbRb8=;
        b=F9JvIr2em32HFZF/djAEzFjgX4RuTj6a3ud4BBXRc3DkqduDSW+xW2HtzZ2vlUXNl7
         nvo86Z2EHWPB5TMzSsPzhkEbDZeOBGP7pynRJZXA3u+A5VFYeuIdJwlCIiQw5d79idiN
         T9jBPhGnlK0Z2ty4nG6jzv3id4JH5gUkUUUL7hkaz52XiSct542Ctlsfd2/d5WGJ4d1P
         hPFbyTIIQDlbEK/vMJ9azlSAjfOJxke5krwgBKvVarV9Ty16hCSjYyEYHr2M93w4YCcC
         hGjIyZpHVBUeu9kvAdnkAMg8O2AiE6XLL4rAnPPMkvuBU/fcT/N/Q5kMEMeo+8Tol1FX
         3yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131869; x=1697736669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1DANaDEHOucqubqJ4/b/aNrMNFhI1eFitx/RoQbRb8=;
        b=aaifymGcJoNPxj7QGFtNH/3Z1Lrx6UeWHl/00FiuIsYo6Bk6LVMQR859iX/qPmJMYL
         P7fvorykLMd7xDTO+ube/51RExB/Gm7AChBo81+mE8Wo1CQwDDYdNdtFNSIbqqIuv+4+
         8XmCW96GeUEd6fORcduAFxl7VQjgkc/tDokRcC9G7nmYHfa64IiUQ5tzP0GguHUbhWBb
         W2T8Wv9uxK3NcjuOeKtomC4GN4kdUquwSQQZxGM8xq3rz/am+Ym3f7JPX6R53CqRJkhH
         RyhyDFsUE4LP8kNiabyvwYYREHWvGz61v3CgQ01S5TRDIeRU4XgnaMuFgLWaejukkHB9
         +Xww==
X-Gm-Message-State: AOJu0YyLU0ZkwrLAOthTsAb2ftAdrfq4iz3ONYGpZ4qMfY1Ex+i4mj1V
	iYmYH3LpEo/Le0dljwvlOkWv1NZGMSXMFw==
X-Google-Smtp-Source: AGHT+IGq/d2q/qrQoh3AnyQyCl8AR4fKt3fghwW8Pm7f+T9b/MyONsNEnanxjJMz2+mJxVjMy0m/Cw==
X-Received: by 2002:a17:902:c115:b0:1c5:e1b7:1c13 with SMTP id 21-20020a170902c11500b001c5e1b71c13mr22664289pli.3.1697131869277;
        Thu, 12 Oct 2023 10:31:09 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b001c57aac6e5esm2278311plg.23.2023.10.12.10.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:31:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 12 Oct 2023 07:31:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: guro@fb.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, willy@infradead.org,
	joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] writeback, cgroup: switch inodes with dirty timestamps
 to release dying cgwbs
Message-ID: <ZSgtW0wGZZ3N3oKl@slm.duckdns.org>
References: <20231011084228.77615-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011084228.77615-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 04:42:28PM +0800, Jingbo Xu wrote:
> The cgwb cleanup routine will try to release the dying cgwb by switching
> the attached inodes.  It fetches the attached inodes from wb->b_attached
> list, omitting the fact that inodes only with dirty timestamps reside in
> wb->b_dirty_time list, which is the case when lazytime is enabled.  This
> causes enormous zombie memory cgroup when lazytime is enabled, as inodes
> with dirty timestamps can not be switched to a live cgwb for a long time.
> 
> It is reasonable not to switch cgwb for inodes with dirty data, as
> otherwise it may break the bandwidth restrictions.  However since the
> writeback of inode metadata is not accounted, let's also switch inodes
> with dirty timestamps to avoid zombie memory and block cgroups when
> laztytime is enabled.
> 
> Fixs: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

The patch looks fine to me.

...
> +	restart = isw_prepare_wbs_switch(isw, &wb->b_attached, &nr);
> +	if (!restart)
> +		restart = isw_prepare_wbs_switch(isw, &wb->b_dirty_time, &nr);

But can you add a comment explaining why we're also migrating b_dirty_time?

Thanks.

-- 
tejun

