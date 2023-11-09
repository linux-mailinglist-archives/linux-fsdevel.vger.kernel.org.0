Return-Path: <linux-fsdevel+bounces-2623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E845E7E71AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 19:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137191C20C69
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C141E531;
	Thu,  9 Nov 2023 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQewXdR2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8EBD275;
	Thu,  9 Nov 2023 18:44:51 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68673C10;
	Thu,  9 Nov 2023 10:44:50 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc0d0a0355so10474265ad.3;
        Thu, 09 Nov 2023 10:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699555490; x=1700160290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+u/67wjsdFPfi+3VMrpO879Jm3pGJagHTWGK5mUzdKA=;
        b=UQewXdR2bBAJzU4/NcmlB4LLefRD+Vs87YP1jMVQcNlh8mELXrr/xuEZGXNqTYrTgC
         3DN8bevWy2tsyDyYbKIxs3ofOprWjNbkU9Hg7ON1p6QWCdfKy27S2HFdt4utWDBsbNhf
         DM65YKLy9L5P5PVCnBRw7dL0Voj2yfJMLpGeVwtLxjInkLjj6BWZADOqmJb9hzCscHWK
         0B9S4kwSN5Wf7v4o2kC+4NOMXObEO0aejmehSIuKp4lwTMmXTlL7A72VuwaeIkamHZqQ
         3BUpfgk6p/wMOnI4Ox9B5lSJUz52mv8oSxUPdDnc07YXYgz8/SlwRw6+1H1aCy88yoPH
         YYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699555490; x=1700160290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+u/67wjsdFPfi+3VMrpO879Jm3pGJagHTWGK5mUzdKA=;
        b=kn325mTi/geOx6wEooIDZGQgrChlQSzPJ0tpYW5aFsHUEQ++4VSmo4j0aysBdAQeau
         cl93zdW7em9cGc/6cU/Sc+lJFBJ7kiAjRRa7+K7cQfXbjNTadjOSEQS+Vm7Toy9IU2Cn
         6VY7gqDaRPko8XJ7+yRqv+sL6qwBz/dlg7g6p5+gWCUiRO0YlXYNCEgx5BTjfWRM4p4U
         atoSQ4nZ0f+WXVNYV8W81E1cCHY8GWdSQz430g00FQNGlyRurk2x09WXsM/yjAca2DGv
         j4RaDsg3SggmtSjBjFegAYZbU03rOdyTEHk93lo/yGIhXYqV7TJO2xdTnChgndLtRp1w
         Fnbg==
X-Gm-Message-State: AOJu0YwNTMsMeNTdIuOrpBG6OJr6tI2YQvU05VTeC4KUmGsFeIuuZvRx
	3A9tlwneWHDZ6ks4SQTyb4I=
X-Google-Smtp-Source: AGHT+IFJHWritYKGihXbEEywurx0OvjBoYDD5T+xeqmeKKtVplLsozr1FibWtZf1pSI4siSBPeb1rg==
X-Received: by 2002:a17:902:d486:b0:1cc:50f6:7fca with SMTP id c6-20020a170902d48600b001cc50f67fcamr7229515plg.24.1699555490067;
        Thu, 09 Nov 2023 10:44:50 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e5c700b001cc2f9fd74csm3828866plf.189.2023.11.09.10.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:44:49 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Nov 2023 08:44:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Haitao Huang <haitao.huang@linux.intel.com>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>
Subject: Re: [RFC 0/6] tracking fd counts per cgroup
Message-ID: <ZU0ooOGzXJfa5Zz0@slm.duckdns.org>
References: <20231108002647.73784-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108002647.73784-1-tycho@tycho.pizza>

Hello,

On Tue, Nov 07, 2023 at 05:26:41PM -0700, Tycho Andersen wrote:
> Hi all,
> 
> At Netflix, we have a "canary" framework that will run test versions of
> an application and automatically detect anomalies in various metrics. We
> also have two "fleets", one full of virtual machines, and one that is a
> multi-tenant container environment.
> 
> On our full-VM fleet, one of the metrics we analyze is the number of open file
> descriptors, from /proc/sys/fs/file-nr. However, no equivalent exists for the
> multi-tenant container fleet, which has lead to several production issues.
> 
> This idea is not new of course [1], but hopefully the existence of the new misc
> cgroup will make it more tenable.
> 
> I'm not really tied to any of the semantics in this series (e.g. threads could
> be double counted even with a shared table), and am open to implementing this
> in other ways if it makes more sense.

As already raised by Christian, if the goal is monitoring, you should be
able to do that easily with BPF.

Thanks.

-- 
tejun

