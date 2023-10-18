Return-Path: <linux-fsdevel+bounces-592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182567CD6D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74DE28136F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0CE125CB;
	Wed, 18 Oct 2023 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxsqS0j8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E01549E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 08:44:23 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF1F100;
	Wed, 18 Oct 2023 01:44:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-694ed847889so5355486b3a.2;
        Wed, 18 Oct 2023 01:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697618660; x=1698223460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9T8yAaYcutbx/cIRFOhb5zMfg4BEF8miGlVCWRkfNY=;
        b=TxsqS0j8MVk4nmshhSlD2QThB2tQW2K6cRywONHq41R5TB26bdep1UeftIcjgGRlmY
         HaKlgM+ONUJ4PyBYABQknXCvDrTfB1T71hrOZHT3SJKk9/jrscWRB9HXlGdSeGPkQmO0
         Yu89JxHjXpiHeFZpGb0yhzGuhn9xIAoKsCavtSsfbWbwV2OJdoqmc7LL9Le/RZ2s/6tA
         W/Isl/MK6bgDzFDigRKJeQH8s8gRSm0s5RyZs2MILgC5+M+o19vyAn3K1ujC2KafIUhb
         J/nJSZFUXTiolAs3ucc8xjf298F1/Np3wxnR69jo9qQsrD7KQGCIlP+0DLbUs4IAAzMF
         x7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697618660; x=1698223460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9T8yAaYcutbx/cIRFOhb5zMfg4BEF8miGlVCWRkfNY=;
        b=ZoFHFcbDMQo4sPTyoUiKs9qKKgCxYntl/jHS1lZJY2bi8MeZ/0a5gLteLlJ61gQ77B
         E2C+x57W3jB2a9uPc5G+6vg4FoaT25j7rn7Up96F407lZZZPaZpD0m0+Z8BlqJLoCElz
         sV8P/gHjjQMsPEGGxgtkS8xUZMJsH65OrsTpSJQD2LVlrh+olqIDSPEVb/Pp7grV7vbC
         N2gLZjiD2vy1VmyaPdYtdbuluzFEntBRSUOB27S9ng7q76uZYZgLiJxdLv5tYbWsk9/C
         NbDVSvXZ7I+ew0LTRzBX4N2O905h6s/qgUkD7UKEL8XKKE2wipgRTLudqhL2JuZ0q6cU
         c0/w==
X-Gm-Message-State: AOJu0Yxm+SMxIY79q35dMhqBxVGIZcRbrBw6pkKz0hXek10VWKCmXtRt
	X5nPsn2Z+ENnoqgHQd4wPrQ=
X-Google-Smtp-Source: AGHT+IGm4cMzz6aQRVd8olXln/NScqR32TREk75esIbuuqb6IvkmGiL8+iIfnpFvLX/SQnCvZe9CIQ==
X-Received: by 2002:a05:6a20:244e:b0:16b:8bcf:9e27 with SMTP id t14-20020a056a20244e00b0016b8bcf9e27mr5013200pzc.20.1697618660175;
        Wed, 18 Oct 2023 01:44:20 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090264c900b001c61901ed37sm3003927pli.191.2023.10.18.01.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:44:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 17 Oct 2023 22:44:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: guro@fb.com, jack@suse.cz, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, willy@infradead.org,
	joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v3] writeback, cgroup: switch inodes with dirty
 timestamps to release dying cgwbs
Message-ID: <ZS-a4s2eIspiv43P@slm.duckdns.org>
References: <20231014125511.102978-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014125511.102978-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 08:55:11PM +0800, Jingbo Xu wrote:
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
> Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

