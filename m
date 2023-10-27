Return-Path: <linux-fsdevel+bounces-1322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0359F7D8FDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 09:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8590EB2137A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 07:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986F2BE5D;
	Fri, 27 Oct 2023 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="isffc9DU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1CBE48
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 07:31:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEFE1736;
	Fri, 27 Oct 2023 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=OBan4m2bjYqVie4lPeBGt03STN7dr+T5kNDpo9X58JA=; b=isffc9DURlxxZa2KklA0bVwyzj
	1YYx/UE6nca7fOrnMXemDiBziZp3Z0GALLsRZDmow9ltwmMymJx5WTOM0CV4ed4lvzg13o0f0jfYK
	dvyCiLBjFFC6iVLkXFSPCgxbq0kHXvfs2QAvEkt04T4wJB0cSH4+Nwa/b7ZCSoik3o7jbHqZBiITB
	lapbVGTXU5F9kTj5ESijmSsJw0lslVC1uU5QccR/Wb9o3J5Ajn9d2TdaSMAwMCQiXE+J3N1IiWGFy
	3krGEwvZdcqOCakqVW6T+kaI8oK+jy/ZeedMe6zpohTpD3Bujvq4arEsm8whQZb/fWnlG96UmWfGG
	/T0FaphA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwHJ3-00FnWE-0W;
	Fri, 27 Oct 2023 07:30:57 +0000
Date: Fri, 27 Oct 2023 00:30:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: create an entry for exportfs
Message-ID: <ZTtnMYJdfdIMuZnj@infradead.org>
References: <20231026205553.143556-1-amir73il@gmail.com>
 <ZTtT+8Hudc7HTSQt@infradead.org>
 <CAOQ4uxh+hWrMrP5A=fGRMK7uTxFFPKvJRNu+=Sc3ygXA1PzxvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh+hWrMrP5A=fGRMK7uTxFFPKvJRNu+=Sc3ygXA1PzxvQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 27, 2023 at 09:35:29AM +0300, Amir Goldstein wrote:
> On Fri, Oct 27, 2023 at 9:08 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Oct 26, 2023 at 11:55:53PM +0300, Amir Goldstein wrote:
> > > Split the exportfs entry from the nfsd entry and add myself as reviewer.
> >
> > I think exportfs is by now very much VFS code.
> >
> 
> Yes, that's the idea of making it a vfs sub-entry in MAINTAINERS.
> 
> Is that an ACK? or did you mean that something needs to change
> in the patch?

I as mostly thinking of dropping the diretory and the separate entry.
That would also go along with your patch of making it a bool.

But if you feel strongly about that we can add you as an extra reviewer
for it :)

