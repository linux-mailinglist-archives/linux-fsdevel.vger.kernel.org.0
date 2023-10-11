Return-Path: <linux-fsdevel+bounces-41-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2037C4B37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 09:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7891C20D88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 07:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0DF1798A;
	Wed, 11 Oct 2023 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="khQutv74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA622117
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 07:07:49 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990FB90
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 00:07:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5346b64f17aso11478580a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1697008065; x=1697612865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qZdr/OmU9//AzD2PL83jeMNBa/vNjL57DmBMZIx5BPA=;
        b=khQutv74qGy4Ky371n0aV2Njy1qeUQDhGH1p8h48RIuSEE0wJA9NvgYoZzyk7+awU8
         qEOX9+SZBKMQYB/jazn3Cj6454OizTpo3g6moxGsuB720Lh+uHrutabg16CbkHm9QzGG
         MrEHcdPwipFg6B+QaHuvkDEVElysK+hiew54Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697008065; x=1697612865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZdr/OmU9//AzD2PL83jeMNBa/vNjL57DmBMZIx5BPA=;
        b=j73Kyrn7Fpw5VhKPW1adGQ69EjEY10bg9mN64DmeFnd17OQdJGp88xCCyZfVWOfTCR
         Gtrq09vu1ITTe+YOWnNhgJ5gLD8OJBsfrXpOtTaCXE4ihQtn+W+rMv+r2UxQAOnjnj5U
         fuvZyh2TiypL7/KlFXtdys+stM8qlKZnCHYXg3sleNbaRdQtsBu9xPCzMWi/NM9P4/XK
         TRkNxKPBRM9sdmJxXDQ8Sw/ku9KPKi9gdXJ4l/lou1Sxa6BRPxxXvWjjrbtHhAOd/u2g
         2UWo2Nzyhdb9Ujm2kC1TA3KK/j+FEeC+Y9H2aeAY/hl/7quak5/P1z5G3hq9DQDrcpIg
         Gh4Q==
X-Gm-Message-State: AOJu0YwAYHA2Y15QkWHO7cZ29AV4KKorIcuTQGRVGROYqGDed4EzTsCe
	F9MlPhSJ4RFMnpbI2UVN+zOyZ65dCfcPnJtdCDBM2A==
X-Google-Smtp-Source: AGHT+IHxSFAWoxypAIR4Zn2MKcRaxT5uvo/oC0sGn2qRZ1uoaS2bzlqSGyqodwewEcMa6l0D40uGq3seGQXqZBSKu4A=
X-Received: by 2002:a17:906:8465:b0:9b2:8b14:7a3d with SMTP id
 hx5-20020a170906846500b009b28b147a3dmr19127877ejc.4.1697008065009; Wed, 11
 Oct 2023 00:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1696043833.git.kjlx@templeofstupid.com> <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com>
 <20231010023507.GA1983@templeofstupid.com> <CAJfpegvr0cHj53jSPyBxVZnMpReq_RFhT-P1jv8eUu4pqxt9HA@mail.gmail.com>
 <20231011012545.GA1977@templeofstupid.com>
In-Reply-To: <20231011012545.GA1977@templeofstupid.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 Oct 2023 09:07:33 +0200
Message-ID: <CAJfpegukL5bj6U0Kvvw_uTW1jstoD2DTLM7kByx2HAhOP02HEg@mail.gmail.com>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their parent
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-kernel@vger.kernel.org, German Maglione <gmaglione@redhat.com>, 
	Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 11 Oct 2023 at 03:26, Krister Johansen <kjlx@templeofstupid.com> wrote:

> I am curious what you have in mind in order to move this towards a
> proper fix?  I shied away from the approach of stealing a nlookup from
> mp_fi beacuse it wasn't clear that I could always count on the nlookup
> in the parent staying positive.  E.g. I was afraid I was either going to
> not have enough nlookups to move to submounts, or trigger a forget from
> an exiting container that leads to an EBADF from the initial mount
> namespace.

One idea is to transfer the nlookup to a separately refcounted object
that is referenced from mp_fi as well as all the submounts.

Thanks,
Miklos

