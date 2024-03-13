Return-Path: <linux-fsdevel+bounces-14281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9991D87A6FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 12:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545C72881B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CBF3F9D8;
	Wed, 13 Mar 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wfa6A5Xw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEF93F9C2;
	Wed, 13 Mar 2024 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328623; cv=none; b=VTKKdDDkZDl9KDC3b5bMwYuAh94iD7QHeZvQGyqVrJe9bS7z4hNsxS4gU+/QrGwE4IylOp5OgU1BUCNYBReVND0FFDyeICDXdlKpRRH1jisb5G/hK7hvGI1Rs6Gvq9X4lHTxUsOGE2OwePUxPyu/oVUQ98wuou8hF4KsyiZAioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328623; c=relaxed/simple;
	bh=9xGC4SQpm4zfa3uEPVxx0x3Lkh/v6baabtSuFaG50Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dODJkE35v417k3S7mgrAbHtsX0jZ7beSRATm6crk664tLBCNXYgAj3W0pptMKHQlYiQaycZp8iNAe3PsJO5ulAt9XPh2ad4GBS8L7B+w3NFyF029PVbpHrWOwTDzPhGLTy+NQ2ehxSjHfF3uDuYKm8qEkWw5oOY00up23ug3Np4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Wfa6A5Xw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yM2Z9vaSXa8HrhpKkEVTckQYcJBQU4Wl+RREtQMe3Ko=; b=Wfa6A5XwQ7fgzY/3vhYdJfpudb
	PIc1E2SkpFaAIJV57oskRVfmokvr5A4VH4pHz9U7TepUqACgYemlFv33mX0oxBSINDE577R8dIWJE
	NqxRq1pMXopMJ9nKdg0t9qIsb97C6imowZQ7fcTt02/gUTZyu64tG0EU6YOzVFcvmS5mL3S2rQbOL
	z1tVjSyXUiaKxvJpDbIH+P69t5GFAHUD+6dWkQgYAyp9QyvAVXO1NZYAw0NMtUdx/C22cKkihrS4c
	2XHyFugwirV5+eQe+b8xY83IzGuA27hef7lZ7RsggxFZFLRjIFW680jfu+8n94pc40xK5VW2Vqr0y
	CJlbO9lA==;
Received: from 179-125-71-247-dinamico.pombonet.net.br ([179.125.71.247] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rkMbP-009v3c-HN; Wed, 13 Mar 2024 12:16:56 +0100
Date: Wed, 13 Mar 2024 08:16:50 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
Message-ID: <ZfGLIl7riu0w2pAm@quatroqueijos.cascardo.eti.br>
References: <Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
 <87le75s1fg.fsf@mail.parknet.co.jp>
 <Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br>
 <87h6hek50l.fsf@mail.parknet.co.jp>
 <Ze2IAnSX7lr1fZML@quatroqueijos.cascardo.eti.br>
 <87cys2jfop.fsf@mail.parknet.co.jp>
 <ZfFcpWRWdnWmtebd@quatroqueijos.cascardo.eti.br>
 <878r2mk14a.fsf@mail.parknet.co.jp>
 <ZfFmvGRlNR4ZiMMC@quatroqueijos.cascardo.eti.br>
 <874jdajsqm.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jdajsqm.fsf@mail.parknet.co.jp>

On Wed, Mar 13, 2024 at 08:06:41PM +0900, OGAWA Hirofumi wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
> 
> >> So you break the mkdir/rmdir link counting, isn't it?
> >> 
> >
> > It is off by one on those images with directories without ".." subdir.
> > Otherwise, everything else works fine. mkdir/rmdir inside such directories work
> > without any issues as rmdir that same directory.
> 
> mkdir() increase link count, rmdir decrease link count. Your change set
> a dir link count always 2? So if there are 3 normal subdirs, and rmdir
> all those normal dirs, link count underflow.
> 
> Thanks.
> 

No. The main change is as follows:

int fat_subdirs(struct inode *dir)
{
[...]
	int count = 0;
[...]
-		if (de->attr & ATTR_DIR)
+		if (de->attr & ATTR_DIR &&
+		    strncmp(de->name, MSDOS_DOTDOT, MSDOS_NAME))
 			count++;
[...]
	return count;
}

int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
{
[...]
	if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
[...]
-		set_nlink(inode, fat_subdirs(inode));
+		set_nlink(inode, fat_subdirs(inode) + 1);
[...]
}

That is, when first instatiating a directory inode, its link count was set to
the number of subdirs it had, including "." and "..". Now it is set to 1 + the
number of subdirs it has ignoring "..".

mkdir and rmdir still increment and decrement the parent directory link count.

Cascardo.


> > If, on the other hand, we left everything as is and only skipped the
> > validation, such directories would be created with a link count of 0. Then,
> > doing a mkdir inside them would crash the kernel with a BUG as we cannot
> > increment the link count of an inode with 0 links.
> >
> > So the idea of the fix here is that, independently of the existence of "..",
> > the link count will always be at least 1.
> 
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

