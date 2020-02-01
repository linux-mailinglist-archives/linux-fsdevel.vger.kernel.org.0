Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3AC14FAE9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 00:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBAXJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 18:09:11 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50743 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbgBAXJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 18:09:10 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E45E121AF1;
        Sat,  1 Feb 2020 18:09:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 01 Feb 2020 18:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=j
        bRWZESbTTo4igy9a0un1fKO8J7/F+oK9jmYMIQn0OQ=; b=kaBAHLkYFHwCRbLz7
        jJQgxoaxPFcIZ/A0hE7L286eTL9sLnFJezcUKf8K7eh14WyAxH8cjBVObxIgze8n
        /IfyJAJ0LIk1n885uMcuHfIbygsWFb1V8PF8ttpyaNbo6y/rgoC0pjybigQ97J8U
        eW6/mj9tUekXfW/YDYKS23dwp8kY4kR9vB1RhzU5ZNB2UnguNFZdk4a/i5SYqfWV
        hh6tdm40cO3QqLtKJTCxuaCkw+Ad3COwok12d9mQatL+y7PB/oDoqerGFiAT5JWu
        poZQNU7hHy2zTQ5tt9K8iAqhsacjTjJUqwGbBqvlB0G/WZ15mqMufgH4IUVDoTwq
        FVj0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=jbRWZESbTTo4igy9a0un1fKO8J7/F+oK9jmYMIQn0
        OQ=; b=EOAEhCxK5ES1idCQ8ij45I6yraX3mY4J+PG97cwHVYb9vRPPx7pixssEw
        0HvJrE0Gt7iB4DTmS/r87RKtLLsa7tOfbQxeWPyktWWYIxCQ6hqJmjBe5j/SD0Xk
        xQMeB5BqWHLkUpdTElzOGvfHdqSccIo7Qcz5lOWuBGTYJZHqqzr6IzStjPxrJz+r
        Zk2bT1dr67i2HmY1DlMKAsGwOG+qXMXyUyaR6PfORQC0rP6nEqA5L8OxtF0o6oiW
        Td6o9UjGQpj+35lI9dzZMUcKz4Famdh1RoylUD/bAT/E25dwklJcszfuREOIa35b
        hW19uPfmRst/pruKh8zTmW1ZqiVEw==
X-ME-Sender: <xms:FAU2XvPdqaGv1Ub7JIlPpBCvjzJS6TpMWko1Jv3VtgzAvLn4I_4u4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthekre
    dttdefjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgt
    hhhusggvrhhtsehfrghsthhmrghilhdrfhhmqeenucfkphepudejiedrudekledrieekrd
    dukeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:FAU2Xi5QhrJN7VQSfSCvGW57T7MectRhfQ9sNhoqJF3-dV4rKgNHSQ>
    <xmx:FAU2XgNjORv0C7mADX_7GoRh1keP6Rj18i_Qr-lGpSLNohcFHOI_3w>
    <xmx:FAU2XgmNvOIXn1M6TOkuOn9GC9k7mgoDBhKiLEyGheHrY4D6pOxXng>
    <xmx:FQU2XssgRmuM5JZvHnnqGOVunf6-I1e7aQHSfoGRSScHQmet5myzQA>
Received: from [192.168.1.20] (vol21-h02-176-189-68-189.dsl.sta.abo.bbox.fr [176.189.68.189])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5AFAD3060BB4;
        Sat,  1 Feb 2020 18:09:08 -0500 (EST)
Subject: Re: [PATCH] fuse: fix inode rwsem regression
To:     qiwuchen55@gmail.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>,
        Matthew Wilcox <willy@infradead.org>
References: <1580536171-27838-1-git-send-email-qiwuchen55@gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
Autocrypt: addr=bernd.schubert@fastmail.fm; prefer-encrypt=mutual;
 keydata= mQINBFQNcsgBEACdIK/JfbtJ0RUTqxoXTFaiiPt9Bc46nJ5CZWVcjls1BMc+N08bR+SD5dVe
 8ZPQi4EQJ7BSkSZMCYePY2iqZelX1AjmpJS1wXYoRnrvwLylIB+mABcv0a2M8pbn9jIKd/Z8
 KyWgtapdrFfGnzr9qBgfpleo2z2U4LUPjB+rVyE6AFCLDdSAiUiBd8jdEtflDYby5lpMTjMJ
 QZJKUzIQgC9A1xQWtZGR+FM4/V2SJUeAtowF5IC0/EjWIQl3ssidHpHwhO5cFvbgKaCXp8R0
 Ew+RvFzv1FE189gfRBl0ecNRKuO7veUqVh042byewYa6pOyumJoGzEwOY3jrM7lgfMos/95X
 7zJDBP8wx38v7+K9jjAcrnDLmpwvFVF6B7WD9bgJuL3m4NwrFgga7vRMZZDaay8Yqve5wlgL
 z+j6IWfvLCkA7v829zz/hR2cSh/5EM5tNgj9z4OrQv5Rd8cyDeHG2p019N3jQHsd0aLhgEmn
 kNmqNb4b/08DzCnPlvGMZT/n1+1OMjoqRXId/5sXxTtzLaViox7LrJKD2p8xauVd5CI6/lZX
 JwxUhCLBxKnmkpZzCpPj3np8VRFyOp7EgjNhDM3wrk3tkML4zS6BwNZbu2B3XPMOCXzw8APL
 Eq5ZmXDUmPDT4Yht4PTxpwiTcPEqX2IvVRie+5zuhgp9BkhffwARAQABtEVCZXJuZCBTY2h1
 YmVydCAoTXkgcHJpdmF0ZSBtYWlsIGFkZHJlc3MpIDxiZXJuZC5zY2h1YmVydEBmYXN0bWFp
 bC5mbT6JAlUEEwEIAD8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEIeRe6q0NEmmM
 Tlph5TJ73PH8LfwFAl0m26kFCQr6nFIACgkQ5TJ73PH8Lfz2mxAAjgQpaTWsiCDSvneSRFHV
 OgN6ixB0WB9lopz+VXPwNnZtdZlHqcVY1znnLIg8dZ7lxQCnrQEhQc7jaxRJy68Sdv86STql
 ee3N6yvN6TTnOoEiCGOQ48zK6d5uMvq5bx1Foqtkzk9VYCQmI4xyM/yAyEZNYLSvyMrsDeBe
 fCpbs7lnLXAd3kJPWUq2F6dHS35H8Iqnfg1lPoJqrKwmuEXAG7SvZFtIrmWXIZTFh6nYn4Hd
 CAlGiN8Rk6Y1clYvtxSznzUM/Ui3OZkCyPvWpXz+U5AiYODgW9SHaB2CUzcmhqL/R7Z8V+ZS
 4og7m3fEWlkosn5ZsCAN/tbuFkWMrgK3mEJGc3EcpDyHl9Z/23o4vmCsehwnpQ4YCsxJMkwV
 rVK/yNNQlJQJrEIRG0DBvDvqjLX5rQud1UsjbwWSm1HyJijbKTdMt7riieE8FKZHRtnKF0Tv
 15Uv3C30zRTDyz4D1OqMzNHsK7hODHhkfoKeU4RaZfcdALUUM9rWu+5/LfueaD0/73xtDl4j
 uv/v+dZLrBM6pGPb9q/2TdDHLqi4doxIdVfXs5ti7lXfGTurUPt6pZjE2jNW5gvYPANBGMkU
 Cs61Y3fdMCYQ+hwWcYUYkaPbVUgayb5pYxAp8Whz4s3XD8NewhOC9LN5QkdnMfiq1S25D+0v
 QMtDmCvukmm1mf+5Ag0EVA1yyAEQANsdiAijTIthvNus145j6ytnC9OzRQAQbYT26BN3T8XU
 cwhWQnCKv3m1mC50LPtq4+eWmV3zWcH0Eka0RJlRrs0oAIZ8ZqIw2T8OEcqnJ7J7Lb0Kq287
 9kg2l7Ix48yGbZNUPltmVlPRWhfFvSWgwkBGjR0r15m9doFgpwpqdBXPDfRGDk7g2oDOKDUe
 3pC++WH7dbyLAVAFM5c5/gSaxplPSqCwZxJ5JtddPTa7kblbWxqm9EFwfvOssVh5V3QdaOkg
 ovIT/LRkFyiatKWBBHG+Epe0hwsmJg+MmMpf/3+5zw+oqV5tPESd0Jem/8Ab7AjzrsoaWWn1
 ritnihQLs3+XLWvtT0XOX2z+zU2PKthqHsohlgQE12JO+6y/2mOQAlbtIL4lrzyTNM5hxlRz
 FahGvsWfSMBb6RPcC16Er1a7+Dg1fPjicJ9EHgWlSZUo5VvyC71ilTJ8+P80tsrV55jaulln
 VZTRz8cXqsgr7GmkEhuNe0NSgKg1lf79juQRfb5eMsTWYjADTwf8VJXyGCS7NlI4viKOA20a
 S3uNxsnPzxaMkTKW8ooAZuTDT8sRecs+lRuzU5ywiW0sJBU9EdWm6M+CVvxucnSpJ1Fei7O2
 n5gcg5ghVFfAjw3zxlL1dAkv/bMVwXE5vB2qe3Dw50mMbooWR3ZvX8+G4NdGwXzHABEBAAGJ
 AjwEGAEIACYCGwwWIQQh5F7qrQ0SaYxOWmHlMnvc8fwt/AUCXSbbwwUJCvqcewAKCRDlMnvc
 8fwt/FI1D/4/NdleJOnl+TPIdwZoallzEW+onyUzakXgrOmxOPbohpFkjb2C9r/1KcWxKJ+w
 hZ32Hzvp7ozbAf63USavDFLdkdjwfEhKVxURzO+AgtWyUdObCEZSgp6ClBEK/s7KO0rTtlRm
 nKgVXYd4g1g9agmuNcJusdigKKuHQw9Ezzlu/eRRXwtIlIbV9Uqb0Vg9yG/JPmHvOTSz9Zz5
 3d3sRLZaYki3bizxecTOPQj2cl7wQTqxnngQF5Dqxpb8vZSXkenAjLRBnP51qtGl650Fzo2W
 lAJPN++C/yqEWd1YHcja+oHFrj+q+U1pLQdcT99OqZyuCIKBq/ZnlekyIxoDxqYeVSBrOl1g
 /rxPVqutROg3+cKkUlrKD4cL1PcmmnpU0rUb+/B84P+3b2tBzs0zaZ+gxcuwUw+19cDH2gVs
 ZijEkpmKNxntnpxWfwOdML/0FcozN8Kh8xb8Jlu85nLdu4fVZy2uqkVfrlRUQsmVsQJG+bhC
 OLadHKf8Yg3VCa2whTbG6d/QqPNmltZxzcc9V8ldyVP7JjDBqc4KIuYWsnXJuRjD3+wJFjSD
 nRuztIt6LzsJVlO2b5984kKndPSY68MKDwRZFsskNpDiZn90tk6ShQi049dgrt1Z6aNJsbAY
 RKuEd5PPcv5D3SuPWLXJKLv4QH5esd6iPv20WmEodsArrg==
Message-ID: <668fc86f-4214-f315-9b41-40368ba91022@fastmail.fm>
Date:   Sun, 2 Feb 2020 00:09:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580536171-27838-1-git-send-email-qiwuchen55@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/1/20 6:49 AM, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Apparently our current rwsem code doesn't like doing the trylock, then
> lock for real scheme.  So change our direct write method to just do the
> trylock for the RWF_NOWAIT case.
> This seems to fix AIM7 regression in some scalable filesystems upto ~25%
> in some cases. Claimed in commit 942491c9e6d6 ("xfs: fix AIM7 regression")
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  fs/fuse/file.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index ce71538..ac16994 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1529,7 +1529,13 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	ssize_t res;
>  
>  	/* Don't allow parallel writes to the same file */
> -	inode_lock(inode);
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock(inode))
> +			return -EAGAIN;
> +	} else {
> +		inode_lock(inode);
> +	}
> +
>  	res = generic_write_checks(iocb, from);
>  	if (res > 0) {
>  		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
> 


I would actually like to ask if we can do something about this lock
altogether. Replace it with a range lock?  This very lock badly hurts
fuse shared file performance and maybe I miss something, but it should
be needed only for writes/reads going into the same file?


Thanks,
Bernd
