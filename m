Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6F11D2A00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgENIZq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 04:25:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39501 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbgENIZp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 04:25:45 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 435655C0221;
        Thu, 14 May 2020 04:25:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 14 May 2020 04:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        /xysc5mZRRwSPhJfTdSoHNPvt4tx6ue/BYIZHaszruM=; b=vgKyk2WVbBTezi5J
        KZZxhb5cZm9Y59EZs1jkDIEB3QN/51GbotXc56FPv7Xfcym56gv3O1qR+nljkg5u
        9idmRjW8ePiEQlecNuBuJQMR4LbrOqBGXTBX0nE1nXFcEUdhaX57FmZCO4ejJA+J
        Yhd88QhBv40BAsI1Uw7//IWhAdOnxk0Q1hU+xUGjlQRutLzOhGiVppZIn5WlmQyD
        Wt0ryMujwkZVPejYBHC9M/ajKDJuwtJswUPv/MxVIas0AzIhh+strqXutV3caOqg
        PBBB+ny9WUpKGb9ebSby/tJeHZOH3yKkcXhC0E4lF/15UEI2E3uNoEZMgFXPOQnU
        RcxNuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=/xysc5mZRRwSPhJfTdSoHNPvt4tx6ue/BYIZHaszr
        uM=; b=vQ2dab9dHMuPMC/E2g2BRHkokaNfzXVMkruZHrf1jsACbLHGamb8VmNqE
        P5ZMhljttd/zS6DTJl7pPkbGBq5pIdNs6F9L+H9NXWVaZBO/E5ezTCv5r4n8PfTn
        vd6wIwoC+xrNjrmwgGSL04apsHcNpNL65tRPQsCT+TJUjv4g1hOkyGCcJZtzrS3H
        GxdexL1hxNOW5HIFBTmpckbYeFUC/rVVBmsvfPKukng83zIWcsShNYxamcdefhnC
        GOA11+klUWv8VNUT+ToY+DAEhUTixAU0HSzzWg+P0gDoXzDTQZ0lupWKqCnoPlvF
        QS2xTtr/Z+jSUz7/eNmgrBk3ZPE8w==
X-ME-Sender: <xms:hwC9Xo-am4RF6LNTv7m07mH48iDckWHKMZFJz4JNxG9SYk4P3qqlIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peduudekrddvtdekrddukeejrddvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:hwC9Xgtl5wjK72rTScXd71Y-TFGpnL1_uTrxuWn3nX2w28PKsMdFiw>
    <xmx:hwC9XuA_0lZdHSpSDYw85PV35YMnEkEQa8qWZUpt-wi_mJk0mXcCFg>
    <xmx:hwC9XofeS0RrUpnYeV3V6IFkhOLUBIv4FGnrR_tWrcfFjyCZx6PQ4A>
    <xmx:iAC9XmaibCZ2K5m1rscL-SbvJiOKKfft5rL7AmEL5B5DeSmZEnf0bg>
Received: from mickey.themaw.net (unknown [118.208.187.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id BEA023060A88;
        Thu, 14 May 2020 04:25:40 -0400 (EDT)
Message-ID: <a98e32eb5ad4486fc58e5ce79700a20abecbd69b.camel@themaw.net>
Subject: Re: [PATCH 02/14] autofs: switch to kernel_write
From:   Ian Kent <raven@themaw.net>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Date:   Thu, 14 May 2020 16:25:36 +0800
In-Reply-To: <20200513065656.2110441-3-hch@lst.de>
References: <20200513065656.2110441-1-hch@lst.de>
         <20200513065656.2110441-3-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-05-13 at 08:56 +0200, Christoph Hellwig wrote:
> While pipes don't really need sb_writers projection, __kernel_write
> is an
> interface better kept private, and the additional rw_verify_area does
> not
> hurt here.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Right, should be fine AFAICS.
Acked-by: Ian Kent <raven@themaw.net>

> ---
>  fs/autofs/waitq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
> index b04c528b19d34..74c886f7c51cb 100644
> --- a/fs/autofs/waitq.c
> +++ b/fs/autofs/waitq.c
> @@ -53,7 +53,7 @@ static int autofs_write(struct autofs_sb_info *sbi,
>  
>  	mutex_lock(&sbi->pipe_mutex);
>  	while (bytes) {
> -		wr = __kernel_write(file, data, bytes, &file->f_pos);
> +		wr = kernel_write(file, data, bytes, &file->f_pos);
>  		if (wr <= 0)
>  			break;
>  		data += wr;

