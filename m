Return-Path: <linux-fsdevel+bounces-21744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20F9095C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 05:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A1A1F22559
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 03:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACDCD53F;
	Sat, 15 Jun 2024 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BrTYbKPy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113703D60;
	Sat, 15 Jun 2024 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718420462; cv=none; b=m/FlacQaWCVOnRZXtUma16wpJ9nWj2eVnDzENqkG9vVZNCYXorS7LQlT6LaJtn7lUsWMQCnn0ty1TAgFEZuOGd6Z2s6IofeGV8DzvIYsozYOs+UvVXzFC2T0jWwe+1wgjJRwadE5mupEjElAyA2pQ2ga4obFBdpiqTnmH0FcLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718420462; c=relaxed/simple;
	bh=4ujlhz/XYkTJNFgjnsc3JV1jf0DS2Z9t4U5pFdyr3RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXoRKJAe01l7FAiDRk7zLHY6mNUs3FZTZXFZAf2CrtFbKmsHwvK/1aJrt1dFMriU3ZFJlO3vgp/2H+RTqPzTQw078nnyvPHrcj71meGdfYZ0Lj0lbzPgFRucOlJHwu1eHSgR7c0RuAD3nr2YLXFF1GOkZenPh/jV7XZMgB0HT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BrTYbKPy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZsJ7xhppQH5+LnYTgIN6HdVAmzBaNnGhRqCh3NGY4oo=; b=BrTYbKPyNAr7Ks3zrM6z8/94BV
	hr46my+ajqDfsDgMb4Pnzi8o8vwASpKn20/gGSSttzmSQUFp69Lyg38cskOmgsN9gddZjFNwgAtl9
	+RAnSpNbTa9DYbNuJnbPOprM6e7+q0QbTaurb8oOU5ivB7GAyG4c/ZpmVgGMfEfivgmp1R6lzngIf
	qm3MEXqE2cKoWFLq9p8BPGeybWZwdD7KfAX9KV3GHLCucilrk/Ixu21R5mgc9JFUeeCuAPCsyEGSS
	G9tGUVO4jGVIjW3skHPCcGpoDU8V7U9qzCalQa+qZEm+pv5YlAvYPl+wJqHQaxpoC9vmzp71BFLs1
	1zz7gccQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sIJey-009A1z-1Q;
	Sat, 15 Jun 2024 03:00:56 +0000
Date: Sat, 15 Jun 2024 04:00:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Congjie Zhou <zcjie0802@qq.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: modify the annotation of vfs_mkdir() in fs/namei.c
Message-ID: <20240615030056.GO1629371@ZenIV>
References: <tencent_3A7366F414667EE52C073850077331ADC709@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3A7366F414667EE52C073850077331ADC709@qq.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jun 15, 2024 at 09:59:13AM +0800, Congjie Zhou wrote:
> modify the annotation of @dir and @dentry


>   * vfs_mkdir - create directory
>   * @idmap:	idmap of the mount the inode was found from
> - * @dir:	inode of @dentry
> - * @dentry:	pointer to dentry of the base directory
> + * @dir:	inode of parent dentry of @dentry
> + * @dentry:	pointer to dentry of the new directory

Ugh...  How about 'inode of the parent directory' and 'dentry
of the child to be' instead?

