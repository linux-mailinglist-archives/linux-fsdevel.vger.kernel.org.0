Return-Path: <linux-fsdevel+bounces-624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C637CDB2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437A8281C8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70962335C0;
	Wed, 18 Oct 2023 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxvuwdOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB7335B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 12:03:24 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A095;
	Wed, 18 Oct 2023 05:03:23 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2e4107f47so721453b6e.2;
        Wed, 18 Oct 2023 05:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697630602; x=1698235402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rv7OhqiqpZBzErogOy+IYGjTR5FLpOat8IuKi1lDFtY=;
        b=ZxvuwdOkGjuXK5+CbUYUqpfTujn/tUc6Q1mumxvstOQ3mwzrVBxJqujyXr0InW3o1d
         5zQZMbzrBSCyonGx5BvCGaO32bZK91zeBqmlpA9OkYjo5KBxJi5N5vI5aqY/dscJSnAB
         FM3n6BXKzkHJMmTwBIqht1I1olp4WJ8QGm+xzM5Kx4AfH/Gn578ygQqcfCt9h3CzzT78
         VvXoGfKphbU0GXwlA6Gjy6l1BRVCi1aQ7snzyhxIbRbU9RFwh4HEm1DRI65JBYAwHtD8
         khfsagvnpaFcWr4DhPFzFQvmtOGFuMgGKLIiePP6vsjxcZ33suIpG9OvL+ZAkSHlWK1j
         ouiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697630602; x=1698235402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rv7OhqiqpZBzErogOy+IYGjTR5FLpOat8IuKi1lDFtY=;
        b=aXDIZoEbKRvRUL1n2wyrfY+IkDUj74Vz4DkV2YKqnl1RBh60NUyJQo0q9ikkec5koj
         R0l0Pb+pNAYzYkFOVVK3HTC3PB+rp4KaC5SC83uW2ZletWA77wjdnfowzoZWCfcyDVuD
         SaIGcA8moeEdDu8SUQh5YZ1WRYlN8La4u6hSoGwff2012P98GROusLDP6SXpW4lYKwMt
         LecDQojUJNFe7aQpxlaJhm+a64/XAkEVXn3oJzprJDrEf9e16GjiEhWCtSnsjQOy0j2p
         lnKJchuJAfzYqYP4srXVcAZovKMMpBO6BFCtwBrcoph8hrBO/a7Ypzo8qGcBKNW2WTYJ
         BJPQ==
X-Gm-Message-State: AOJu0Yz+MwsyJNwf0DF7aj9o05aGgEchnh/PAO/XYk7+jboc7S3HmOr7
	Or1cE4rdHuJ2vXqB8Ctr8rgWUdaGJduiXFcHqd4=
X-Google-Smtp-Source: AGHT+IHOzjiMo2Ouhfo1i48HQcJDR2bKJG/OYDCvqaOEDPKFu8HA66T4d0mGQ3YgsXUhr3iH/SE0zXE7yTrnd+IhcQA=
X-Received: by 2002:a05:6808:1486:b0:3ae:5a09:9eb9 with SMTP id
 e6-20020a056808148600b003ae5a099eb9mr6289193oiw.32.1697630602527; Wed, 18 Oct
 2023 05:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-amtime-v1-1-e066bae97285@kernel.org> <CABq1_vhoWrKuDkdogeHufnPn68k9RLsRiZM6H8fp-zoTwnvd_Q@mail.gmail.com>
 <d727d2c860f28c5c1206b4ec2be058b87d787e4f.camel@kernel.org>
In-Reply-To: <d727d2c860f28c5c1206b4ec2be058b87d787e4f.camel@kernel.org>
From: Klara Modin <klarasmodin@gmail.com>
Date: Wed, 18 Oct 2023 14:03:11 +0200
Message-ID: <CABq1_vj4ewSP246V8-nEZMURgiNFtdChvwojRRPrp81e5P=J+A@mail.gmail.com>
Subject: Re: [PATCH] fat: fix mtime handing in __fat_write_inode
To: Jeff Layton <jlayton@kernel.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Den ons 18 okt. 2023 kl 13:55 skrev Jeff Layton <jlayton@kernel.org>:
>
> Many thanks for the bug report and testing! Do you mind if we add your
> Tested-by: for this patch?
>
Not at all, please do.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>

