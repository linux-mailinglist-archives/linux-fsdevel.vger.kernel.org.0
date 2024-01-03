Return-Path: <linux-fsdevel+bounces-7254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB748235D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B141F258E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02AB1D540;
	Wed,  3 Jan 2024 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="KqCLgCLv";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="cp+ReJMB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE71D529;
	Wed,  3 Jan 2024 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id AF266C027; Wed,  3 Jan 2024 20:47:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704311224; bh=rchUNxdMCqpxIcXW8Gd8rSQ5mpefCht1oHNRmrwB1pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqCLgCLvNFzqohtP+Q00yasRxvDCYWdLlzzFXvHOWe9rBinElOfDxYU9K7hZf/nb5
	 yzmsz914DpXIublCq4fenyPl790/cWrEV7Kv4otTyDddP9sHmecTY6qkluQNeTRw7w
	 GKv1xUqnqtUTL42Y2EPdQ80fY9FfEXuGjGRjLZs9Qr5bzV9qoaM3QhgjSJFjppKcmq
	 rXQmZLjbTyRKgOPCBhHEQGlvLYtEwr/yOK1sq/ZJvt8pX0twrYja27PDZZqd+TmdMk
	 WRzeilNoNFYXeYNhQ9F8HKU2gyKS8QlDNkTR7vC3ErTf43wXbMoYLC/aypxu8I24Fw
	 jrRHmZJW8oL+g==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 7F88AC01A;
	Wed,  3 Jan 2024 20:46:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704311223; bh=rchUNxdMCqpxIcXW8Gd8rSQ5mpefCht1oHNRmrwB1pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cp+ReJMBn4/XifVWwL9GKWjgkdtOemo/VHptMfuCAey1eLCbRlXG8C98KiVBZWxQz
	 akAQ/UbdziobN/oM86x455uM+VDXCfHi0FGn1LyWCSLZ+O0lcIM1epqEAlYR/oI3bW
	 KDoePmBGHzUHJfEwETut5v+EXyKaJQl3IsJzqKvrTVSxz+zFiA7glGc3YoQxwb3kZG
	 Dk8V40uXy4lDjOa4efxjrsPampxxMLB0G9RZK+y1M1uBtZ2jO2fVIGlj2hdwqGPJ5b
	 cnZIsrl4Zu+sK1EsxMTzzmiNyNw1eykicrjIUmzOzbzIkTLPStHaI5hlFt4HU2Gojv
	 twZElKdDAeHDQ==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 34cd8836;
	Wed, 3 Jan 2024 19:46:53 +0000 (UTC)
Date: Thu, 4 Jan 2024 04:46:38 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 5/5] 9p: Use length of data written to the server in
 preference to error
Message-ID: <ZZW5nlB5v-SDsT_P@codewreck.org>
References: <20240103145935.384404-1-dhowells@redhat.com>
 <20240103145935.384404-6-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103145935.384404-6-dhowells@redhat.com>

David Howells wrote on Wed, Jan 03, 2024 at 02:59:29PM +0000:
> In v9fs_upload_to_server(), we pass the error to netfslib to terminate the
> subreq rather than the amount of data written - even if we did actually
> write something.
> 
> Further, we assume that the write is always entirely done if successful -
> but it might have been partially complete - as returned by
> p9_client_write(), but we ignore that.
> 
> Fix this by indicating the amount written by preference and only returning
> the error if we didn't write anything.
> 
> (We might want to return both in future if both are available as this
> might be useful as to whether we retry or not.)
> 
> Suggested-by: Dominique Martinet <asmadeus@codewreck.org>

Thanks,

Acked-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique Martinet | Asmadeus

