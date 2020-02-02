Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2420814FF5F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 22:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBBVZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Feb 2020 16:25:03 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36913 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726971AbgBBVZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:25:03 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EC54C2F0;
        Sun,  2 Feb 2020 16:25:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 02 Feb 2020 16:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=L
        PxAQQiqRuoGOPKvYDIsLfwWX7h3xUQbmwrfmLakCe4=; b=Hmka/5594kogfTHSe
        njcJkTHBFRhi1dtYBnecVetpuLZHyYslqhYAEa/iMriNJGBrBbfg5T3wtfNNzFoq
        761nVT2i9lYEqde3nc6Fh+Suu+v8ZIi2X68h6N5lb7gPMXSqsxfVvpUy8WxIVy4E
        g+2Ru49oRuw5FB2yx/csIek8a1BumVYYG2EcBzjtHaZXeIyRxIAJxomiNagq6X0q
        I/lq5YdAp2m8SUWFB50bMni5IZd2ILVTQwo3w6NMP0VgMRn88gv+9A6WlSyIPX9U
        hgfhrXdhBn2Z9LtcUPjDwTUf0GXWjr2qXbJLh+R7xWqo97nio742pV7+CuIXHBx+
        3GwQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=LPxAQQiqRuoGOPKvYDIsLfwWX7h3xUQbmwrfmLakC
        e4=; b=BkwmvuA5eKxoL2ecK8vaWz8OzrG+bRStDEEMmrLTyH9wUl9+SLguWXcMN
        6ezKm+ho6hYR+sh2veCV2AKy+Sa33eCNbZB7QLRUOLYhfaLaS8VqMWwSubo3DX94
        g7IJn45iBqz7uSQiPvhUodAFjirfIdw5f9fpdbyALlIsonwquiNDWIlYBINN5m16
        /cJW3+kGLXc7CTwNhEDypnpgkz87/71AKgu3ki+LlSMfc/89EqqroDbg65hC9pf/
        G/GMjiSTTlb5fcAdnDtU8Kz6VtXZWjfT5G9QDW8D53XnMBlMr3W2QQ8Z3CAVzscj
        Uy0Z5eZ80WA/P0kjQadYFfdg2XaPg==
X-ME-Sender: <xms:LT43XhSf-nK5iOOp98uoYfio071OETUcbgluxqGJGD8PIZa7Vf5AMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeehgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhs
    tghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmheqnecukfhppedujeeirddukeelrdeike
    drudekleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:LT43XvCoNr-G3PRj4KwYNDNeFdHGLxsA6_35jgStcFdHvb4fbpiqig>
    <xmx:LT43Xh17-CQK3RopScxpUnApaDCE8fPvxdvuzyuMzEnPSwMhxYXy6A>
    <xmx:LT43XtWCI7AxpL_Tln_2ZOv0OR8eY9H13WaPmFI6392QaPF02M6wWw>
    <xmx:LT43XnQiHFRWIbda3esPxSqmlDUD860z1Vd8Ojwxt4shUKFqBAxrYQ>
Received: from [192.168.1.20] (vol21-h02-176-189-68-189.dsl.sta.abo.bbox.fr [176.189.68.189])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E581328005D;
        Sun,  2 Feb 2020 16:25:00 -0500 (EST)
Subject: Re: [PATCH] fuse: Allow parallel DIO reads and check NOWAIT case for
 DIO writes
To:     qiwuchen55@gmail.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
References: <1580614487-1341-1-git-send-email-qiwuchen55@gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
Autocrypt: addr=bernd.schubert@fastmail.fm; prefer-encrypt=mutual;
 keydata= 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
Message-ID: <07d333db-9ed3-2628-673e-cb614c31f29e@fastmail.fm>
Date:   Sun, 2 Feb 2020 22:25:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580614487-1341-1-git-send-email-qiwuchen55@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> @@ -1518,6 +1525,9 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  		res = __fuse_direct_read(&io, to, &iocb->ki_pos);
>  	}
> +	inode_unlock_shared(inode);
> +
> +	file_accessed(iocb->ki_filp);


Shouldn't the file_accessed() in different patch, with a description? It
looks totally unrelated to locking?


Thanks,
Bernd
