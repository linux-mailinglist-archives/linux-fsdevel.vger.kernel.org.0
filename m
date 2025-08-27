Return-Path: <linux-fsdevel+bounces-59442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D77B38B1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 22:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AC61C20451
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50373002D2;
	Wed, 27 Aug 2025 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MJ0fVELf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC92D238C;
	Wed, 27 Aug 2025 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756327564; cv=none; b=TbUt7FotVi/GYlXPCqnbQJhfvpEdwiOfvpRWRlE4tPqpFA/ShRXoNLR2XwpelpIoHVjyjcjwFuPO0H03lfCtnfEiuXioFwT0+b6+9bzIBOQFHYnIowx6J5kLEpimJjyBJYH2FDZdrXgTTL+U1SyF9ZZas6C5LvSQbr2CLuHGxdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756327564; c=relaxed/simple;
	bh=HTwj7TzbWGskJrgkBIxrdwXAO6cACgjaleP+X8VWAmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qz72rbtSe+qLugZf1ozBcb4QeSx+d9fC8nLBLhPZS/NLnj+1C/7BssLYnGTOyVjWrCfj/NsQnBbxQBUokJMZszwtfFIia5fT7GqJj65jpujR6pSdRxv7xsSgPhX+2m8YxW7/FfPslTOTfmEvEkl4G+PW555gE6Axdf8W+6mVETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MJ0fVELf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eUuaRADv/eid8VLJNi3Co6D4FndZBAbt78tlZsPPzAU=; b=MJ0fVELf32mwrbUmCmscshFj/Q
	hKn1rOzwpCc3xepUh9ecZcvU/xsrqazBq4I+O5rs4HflagiD4wq+0gqRsoq0P6/f2kzoNLJ4gf81c
	RvK+8FW+GZfeF5oGR2M8MUmf1oVsVkL9lmV57C4uRJhbapTg+X+iDM7sol7MDDeuPtR/IKaiVPKcw
	+FUJUgSVKQMtJ92qE94RyAXCTeeNv9IxPjdjZu9p8meLtc04i526uftF9dANuvzVHQ/NrdeS/us0v
	xR3ZvjJCYji5O80roWpyszW/S7/kZOHa2fUlDgd7BsQtmsHenbFf9CieIj9L37IHETv27hbNWiS/8
	Ojx9x3LQ==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1urN1o-002c1V-5n; Wed, 27 Aug 2025 22:45:56 +0200
Message-ID: <37e714a7-ee0e-42e0-af7e-34c6b6503cfa@igalia.com>
Date: Wed, 27 Aug 2025 17:45:52 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
To: Amir Goldstein <amir73il@gmail.com>,
 Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com>
 <875xeb64ks.fsf@mailhost.krisman.be>
 <CAOQ4uxiHQx=_d_22RBUvr9FSbtF-+DJMnoRi0QnODXRR=c47gA@mail.gmail.com>
 <CAOQ4uxgaefXzkjpHgjL0AZrOn_ZMP=b1TKp-KDh53q-4borUZw@mail.gmail.com>
 <871poz4983.fsf@mailhost.krisman.be> <87plci3lxw.fsf@mailhost.krisman.be>
 <CAOQ4uxhw26Tf6LMP1fkH=bTD_LXEkUJ1soWwW+BrgoePsuzVww@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxhw26Tf6LMP1fkH=bTD_LXEkUJ1soWwW+BrgoePsuzVww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Em 26/08/2025 04:19, Amir Goldstein escreveu:
> 
> Andre,
> 
> Just noticed this is a bug, should have been if (*dst), but anyway following
> Gabriel's comments I have made this change in my tree (pending more
> strict related changes):
> 
> static int ovl_casefold(struct ovl_readdir_data *rdd, const char *str, int len,
>                          char **dst)
> {
>          const struct qstr qstr = { .name = str, .len = len };
>          char *cf_name;
>          int cf_len;
> 
>          if (!IS_ENABLED(CONFIG_UNICODE) || !rdd->map || is_dot_dotdot(str, len))
>                  return 0;
> 
>          cf_name = kmalloc(NAME_MAX, GFP_KERNEL);
>          if (!cf_name) {
>                  rdd->err = -ENOMEM;
>                  return -ENOMEM;
>          }
> 
>          cf_len = utf8_casefold(rdd->map, &qstr, *dst, NAME_MAX);

The third argument here should be cf_name, not *dst anymore.

>          if (cf_len > 0)
>                  *dst = cf_name;
>          else
>                  kfree(cf_name);
> 
>          return cf_len;
> }
> 

> Thanks,
> Amir.


