Return-Path: <linux-fsdevel+bounces-28149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35FE967650
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 13:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C918281DAD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AE16F27D;
	Sun,  1 Sep 2024 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="y+NY11Ya";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k24vSfx2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0D314E2D6
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Sep 2024 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725191824; cv=none; b=b/LfVNEY0rnZYqpb74p/yG9CF88IRz6aOwquDmfzxWSux9eB2aoaHP04Zh4gG5Hz8fSnimnpUxykTO9YxBYHzcKZsD747sC4SpDRQ5BkYrqvE0SWUwJZCEvNNgI86a+tidz+8bHyAn6IVn+/vdD8SKvGPTh9m1QQOdrt3z3RyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725191824; c=relaxed/simple;
	bh=QQt2WjOYRFh8gZnsjXn23CjQrX0MPNIlR+zVSL6NzAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHaum4zhigJfdeRyTchNPTmN36TBk3sduhmtzwa9nczJIr3+4IicaYATwUCj5CEdhwn7VmtH4znlcXshVP+C4SVqVdlY7YpUsYuJ5mluDGKUh2CBJ9nKrz2IhiaTdCczsZibVrFWSTBGAvMIrDbQ4pSDH+BwnZJmDZgG/J8XLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=y+NY11Ya; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k24vSfx2; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 88CD91380302;
	Sun,  1 Sep 2024 07:57:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 01 Sep 2024 07:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725191821;
	 x=1725278221; bh=/n79tFT80YWexs+8RdZJi4AvyFkh48JAmuCiU6gZbLk=; b=
	y+NY11YaPnTZGr+2hy3ZmQ/W1hiSNY7LTZwmtdM4Ag7h07fc0mP23jh+PE3FJ2bF
	ffEedAx7B9lngqgsjxXYOSWtrpxEzEJsLiJnsxuld/fvJc+P/syb+b+3rb16iBGu
	Qf20EP0pY4rsk3ztLhfaGcuVw1EYsqhaIhKEQwxOIZIB/Ugwmb8n9YEIjgQG870K
	lPfcZxSPd1l41vP2RDCoXgoyC8jSvUMjwgjGGfSvOoo2McFI0x4QRfgJZWFp69nF
	O+r8hUSJzKB6NJ9DA/cP4PMPle9mdNDDduFtcTFSHrVTeq/M+oncC0zbBMu62L4W
	zWspXGXRFmdmd8KPoW9OVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725191821; x=
	1725278221; bh=/n79tFT80YWexs+8RdZJi4AvyFkh48JAmuCiU6gZbLk=; b=k
	24vSfx2wfj3orb1WOTZUqerpJYT1pmOtLl6B4VR06U1prIGflgcrNZu7uQkv7Egg
	QM7Wn7XsyaTsUnpSzFI9uUY/s7bn+vYUdVWU1SXfEkZI0O4vH2Ax3DFbuW/lG0LV
	wKgauo++Sfo6rsLxH7Us0ojmvut88zEAlsK6kE0yRkpCr3jkR66fUQzuf2TWoAS5
	vmauLPT6C+Ssw2ioloo4YrvZdhuBIXwhhygyYLWB+TyDb30Bzl1SgYkjN8SBZn0j
	tMLdWTCDSOohC0OLsGJMqbe+ipM72MxBZVYHVXaMq3a/RTTRmPctvFDG+WY09mof
	XUvzMoBahKq2n7vYOo9SQ==
X-ME-Sender: <xms:jVbUZj_uk6nUABsf1hiVTvTUyW_2RlqTal_ezK2wl4_UKZrPs5sHDg>
    <xme:jVbUZvsmE6jkG0QJsaf267Z4MzgJp3vaciUiGC6KOa9YPbeBM22fDjH6oaY0MbuW5
    ODdufAso_uPGjvC>
X-ME-Received: <xmr:jVbUZhBz8VXXbtTVs58BKPNiLUh53QhUswNZtawYIF2AJp9tl0QdZCcenwr-N6wzI2Ibzyew57mNRgfIYwEvkocAfDLyKbVMIFVmyA7qqJZcqqySRxSd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeghedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphht
    thhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtohepmhhikhhlohhsse
    hsiigvrhgvughirdhhuhdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:jVbUZvfJ0bzXcdBMlJG0c3WWQkgFoAJ7I7Szg-KLg33hgpPvJGt22A>
    <xmx:jVbUZoOsvn5VUx0LpY4AYrgmqzylRcSuQCkRimoT7lpG3DsUyEvAsQ>
    <xmx:jVbUZhnC12kcyDMUCni2OkQSI5p8_VN6VbK4G9DVruk0wiGyllzPWA>
    <xmx:jVbUZius6fg5LO_5630WOBI1DX5EGzcAG2TQXrhojHMIdXYR6HvslQ>
    <xmx:jVbUZn3J38dE2cVOPseyl2VSL_ihLVoEVN-FM31KKiIzkoAvV56saL0J>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Sep 2024 07:57:00 -0400 (EDT)
Message-ID: <4f2d9c60-eca3-41a8-98af-381fae413bf6@fastmail.fm>
Date: Sun, 1 Sep 2024 13:56:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 11/19] fuse: Add support to copy from/to the ring
 buffer
To: Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-11-d149476b1d65@ddn.com>
 <20240530195920.GC2210558@perftesting>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240530195920.GC2210558@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 21:59, Josef Bacik wrote:
> On Wed, May 29, 2024 at 08:00:46PM +0200, Bernd Schubert wrote:
>> This adds support to existing fuse copy code to copy
>> from/to the ring buffer. The ring buffer is here mmaped
>> shared between kernel and userspace.
>>
>> This also fuse_ prefixes the copy_out_args function
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/dev.c        | 60 ++++++++++++++++++++++++++++++----------------------
>>  fs/fuse/fuse_dev_i.h | 38 +++++++++++++++++++++++++++++++++
>>  2 files changed, 73 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 05a87731b5c3..a7d26440de39 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -637,21 +637,7 @@ static int unlock_request(struct fuse_req *req)
>>  	return err;
>>  }
>>  
>> -struct fuse_copy_state {
>> -	int write;
>> -	struct fuse_req *req;
>> -	struct iov_iter *iter;
>> -	struct pipe_buffer *pipebufs;
>> -	struct pipe_buffer *currbuf;
>> -	struct pipe_inode_info *pipe;
>> -	unsigned long nr_segs;
>> -	struct page *pg;
>> -	unsigned len;
>> -	unsigned offset;
>> -	unsigned move_pages:1;
>> -};
>> -
>> -static void fuse_copy_init(struct fuse_copy_state *cs, int write,
>> +void fuse_copy_init(struct fuse_copy_state *cs, int write,
>>  			   struct iov_iter *iter)
>>  {
>>  	memset(cs, 0, sizeof(*cs));
>> @@ -662,6 +648,7 @@ static void fuse_copy_init(struct fuse_copy_state *cs, int write,
>>  /* Unmap and put previous page of userspace buffer */
>>  static void fuse_copy_finish(struct fuse_copy_state *cs)
>>  {
>> +
> 
> Extraneous newline.
> 
>>  	if (cs->currbuf) {
>>  		struct pipe_buffer *buf = cs->currbuf;
>>  
>> @@ -726,6 +713,10 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>>  			cs->pipebufs++;
>>  			cs->nr_segs++;
>>  		}
>> +	} else if (cs->is_uring) {
>> +		if (cs->ring.offset > cs->ring.buf_sz)
>> +			return -ERANGE;
>> +		cs->len = cs->ring.buf_sz - cs->ring.offset;
>>  	} else {
>>  		size_t off;
>>  		err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
>> @@ -744,21 +735,35 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>>  static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
>>  {
>>  	unsigned ncpy = min(*size, cs->len);
>> +
>>  	if (val) {
>> -		void *pgaddr = kmap_local_page(cs->pg);
>> -		void *buf = pgaddr + cs->offset;
>> +
>> +		void *pgaddr = NULL;
>> +		void *buf;
>> +
>> +		if (cs->is_uring) {
>> +			buf = cs->ring.buf + cs->ring.offset;
>> +			cs->ring.offset += ncpy;
>> +
>> +		} else {
>> +			pgaddr = kmap_local_page(cs->pg);
>> +			buf = pgaddr + cs->offset;
>> +		}
>>  
>>  		if (cs->write)
>>  			memcpy(buf, *val, ncpy);
>>  		else
>>  			memcpy(*val, buf, ncpy);
>>  
>> -		kunmap_local(pgaddr);
>> +		if (pgaddr)
>> +			kunmap_local(pgaddr);
>> +
>>  		*val += ncpy;
>>  	}
>>  	*size -= ncpy;
>>  	cs->len -= ncpy;
>>  	cs->offset += ncpy;
>> +
> 
> Extraneous newline.
> 
> Once those nits are fixed you can add
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks again for your reviews! I won't add this for now, as there are
too many changes after removing mmap.


Thanks,
Bernd

