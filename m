Return-Path: <linux-fsdevel+bounces-591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9860D7CD6CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D6B281394
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 08:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AFD156C5;
	Wed, 18 Oct 2023 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgMXQFA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F58C0C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 08:43:56 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CC1C6;
	Wed, 18 Oct 2023 01:43:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9d407bb15so55532475ad.0;
        Wed, 18 Oct 2023 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697618635; x=1698223435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAr4Czs1Gmv7dgWfEmdHDDt8I2NpUA7OGZmt8fiF/E0=;
        b=QgMXQFA9e4+m0u3jKiJFFyKnc4p7AxhbnczkydbxRSjqwUaf6Tgj8Dx2NOHGSczpHD
         yn/8EX5fbv1r+7ct52nITw7LxZGoaz/0bFdbuQ4znQxTDxUMOPWQ0ohAB5h8huo7LcAG
         CSxD4ku/8xpCA/pKbeWIpAI/gIjvnvtZYREBmz6ZoKJUBpv+oiOTgHcSx9mAkTFLVN45
         ciDnj2LerZNGctupfGH0Ik0CfG3m5DN1DbQx7SK4H8HSed8b/AnV9ja4Cmf8S5ECoaMu
         RB99mMm2KUg3jiWmks+T1twhlK5ZZaPJYnS81Pw183qkLWSOE12CUjFaxXahEgoaBQNh
         gr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697618635; x=1698223435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAr4Czs1Gmv7dgWfEmdHDDt8I2NpUA7OGZmt8fiF/E0=;
        b=nIz/DiC9E+X4+isuLLmo/NIhFBpraflRFhzdYnfQLde0CszSonXc46qcJ/mrNN51Ry
         I3q1VyDoAkq/ZAjhsZ4J692uaZHi3kDcQHi0pkpw3pkU608z0o5Mgq+TCSGcNOlynGVu
         NU9fx9GsC5Zld5gI7ZL6UV//sREEeazaiJuOtgNTNhcy5yJT8MpcftLJ8MJ+93BJNK5M
         t/nQxiehFWA/JR2d65MJTGKtXe6S41X+5aNjKkHYAsCTsbeOuCAuarqfpGoGVzG+RfmN
         ovFSCkJdsiOsRDGrLmXk1yBH28/HCHwQN7srWgXvQgms0BMdGztBy9qEokn2XV66FGmq
         0vOQ==
X-Gm-Message-State: AOJu0YyN/jtwSHtdt8tR18hJ/d45NqDuxpbT5N+T25tlCFv+bmbb4hvY
	1Pelm8sdW8q16bzqhy0xnqw=
X-Google-Smtp-Source: AGHT+IG9r9bT1AXckrnxG5oN5+oChhVpMiXvwpGVI5YME+Fe/zKTLdnxRiBZ8kmFxj8PaxCAtPWQzA==
X-Received: by 2002:a17:902:e74a:b0:1c9:ccb3:2352 with SMTP id p10-20020a170902e74a00b001c9ccb32352mr5994017plf.12.1697618634960;
        Wed, 18 Oct 2023 01:43:54 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902760d00b001c5fc11c085sm2941357pll.264.2023.10.18.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:43:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 17 Oct 2023 22:43:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: guro@fb.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, willy@infradead.org,
	joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2] writeback, cgroup: switch inodes with dirty
 timestamps to release dying cgwbs
Message-ID: <ZS-aydAgB5SIkHyk@slm.duckdns.org>
References: <20231013055208.15457-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013055208.15457-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 01:52:08PM +0800, Jingbo Xu wrote:
> The cgwb cleanup routine will try to release the dying cgwb by switching
> the attached inodes.  It fetches the attached inodes from wb->b_attached
> list, omitting the fact that inodes only with dirty timestamps reside in
> wb->b_dirty_time list, which is the case when lazytime is enabled.  This
> causes enormous zombie memory cgroup when lazytime is enabled, as inodes
> with dirty timestamps can not be switched to a live cgwb for a long time.
> 
> It is reasonable not to switch cgwb for inodes with dirty data, as
> otherwise it may break the bandwidth restrictions.  However since the
> writeback of inode metadata is not accounted for, let's also switch
> inodes with dirty timestamps to avoid zombie memory and block cgroups
> when laztytime is enabled.
> 
> Fixs: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

